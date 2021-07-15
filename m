Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC9C3C9ECA
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 14:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhGOMkr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 08:40:47 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58732 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231548AbhGOMkr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Jul 2021 08:40:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1610241268;
        Thu, 15 Jul 2021 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1626352671; x=1628167072; bh=EJ4XNhSWQWd55qEoU+Jg83i2VR1b8Emv8Gu
        M1r5mb4A=; b=fpWJYLf9JI3BUavu+s8tYd5QalCD4bvonp1hwlb/HgVaT8tTC9D
        3Mi5WCzp+3stjee4InKf+Q1AbuRA8jSmJaHIc2YXqPFvz5CCWIssBmm+HhRLI3vL
        /B8EAJke+uixO8UyYWAg2NG2cAlNxKBaztpFgCtfViJkTFCeWmbDGMe8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XGBcvDSa9bh0; Thu, 15 Jul 2021 15:37:51 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3DD7C42C03;
        Thu, 15 Jul 2021 15:37:51 +0300 (MSK)
Received: from fedora.bbmc.yadro.com (10.199.1.7) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 15
 Jul 2021 15:37:50 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v4 1/1] iio: proximity: vcnl3020: add periodic mode
Date:   Thu, 15 Jul 2021 15:47:28 +0300
Message-ID: <20210715124728.838455-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715124728.838455-1-i.mikhaylov@yadro.com>
References: <20210715124728.838455-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.1.7]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the possibility to run proximity sensor in periodic measurement
mode with thresholds.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/iio/proximity/vcnl3020.c | 328 +++++++++++++++++++++++++++++--
 1 file changed, 313 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 43817f6b3086..edbc920635f1 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -3,7 +3,6 @@
  * Support for Vishay VCNL3020 proximity sensor on i2c bus.
  * Based on Vishay VCNL4000 driver code.
  *
- * TODO: interrupts.
  */
 
 #include <linux/module.h>
@@ -11,9 +10,10 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
 
 #define VCNL3020_PROD_ID	0x21
 
@@ -37,6 +37,21 @@
 					* measurement
 					*/
 
+/* Enables periodic proximity measurement */
+#define VCNL_PS_EN		BIT(1)
+
+/* Enables state machine and LP oscillator for self timed  measurements */
+#define VCNL_PS_SELFTIMED_EN	BIT(0)
+
+/* Bit masks for ICR */
+
+/* Enable interrupts on low or high thresholds */
+#define  VCNL_ICR_THRES_EN	BIT(1)
+
+/* Bit masks for ISR */
+#define VCNL_INT_TH_HI		BIT(0)	/* High threshold hit */
+#define VCNL_INT_TH_LOW		BIT(1)	/* Low threshold hit */
+
 #define VCNL_ON_DEMAND_TIMEOUT_US	100000
 #define VCNL_POLL_US			20000
 
@@ -63,6 +78,7 @@ struct vcnl3020_data {
 	struct device *dev;
 	u8 rev;
 	struct mutex lock;
+	__be16 buf ____cacheline_aligned;
 };
 
 /**
@@ -140,14 +156,31 @@ static int vcnl3020_init(struct vcnl3020_data *data)
 					       vcnl3020_led_current_property);
 };
 
+static bool vcnl3020_is_in_periodic_mode(struct vcnl3020_data *data)
+{
+	int rc;
+	unsigned int cmd;
+
+	rc = regmap_read(data->regmap, VCNL_COMMAND, &cmd);
+	if (rc)
+		return false;
+
+	return !!(cmd & VCNL_PS_SELFTIMED_EN);
+}
+
 static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
 {
 	int rc;
 	unsigned int reg;
-	__be16 res;
 
 	mutex_lock(&data->lock);
 
+	/* Protect against event capture. */
+	if (vcnl3020_is_in_periodic_mode(data)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
+
 	rc = regmap_write(data->regmap, VCNL_COMMAND, VCNL_PS_OD);
 	if (rc)
 		goto err_unlock;
@@ -163,12 +196,12 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
 	}
 
 	/* high & low result bytes read */
-	rc = regmap_bulk_read(data->regmap, VCNL_PS_RESULT_HI, &res,
-			      sizeof(res));
+	rc = regmap_bulk_read(data->regmap, VCNL_PS_RESULT_HI, &data->buf,
+			      sizeof(data->buf));
 	if (rc)
 		goto err_unlock;
 
-	*val = be16_to_cpu(res);
+	*val = be16_to_cpu(data->buf);
 
 err_unlock:
 	mutex_unlock(&data->lock);
@@ -200,6 +233,15 @@ static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
 {
 	unsigned int i;
 	int index = -1;
+	int rc;
+
+	mutex_lock(&data->lock);
+
+	/* Protect against event capture. */
+	if (vcnl3020_is_in_periodic_mode(data)) {
+		rc = -EBUSY;
+		goto err_unlock;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(vcnl3020_prox_sampling_frequency); i++) {
 		if (val == vcnl3020_prox_sampling_frequency[i][0] &&
@@ -209,18 +251,229 @@ static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
 		}
 	}
 
-	if (index < 0)
+	if (index < 0) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+
+	rc = regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
+
+err_unlock:
+	mutex_unlock(&data->lock);
+
+	return rc;
+}
+
+static bool vcnl3020_is_thr_enabled(struct vcnl3020_data *data)
+{
+	int rc;
+	unsigned int icr;
+
+	rc = regmap_read(data->regmap, VCNL_PS_ICR, &icr);
+	if (rc)
+		return false;
+
+	return !!(icr & VCNL_ICR_THRES_EN);
+}
+
+static int vcnl3020_read_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	int rc;
+	struct vcnl3020_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			rc = regmap_bulk_read(data->regmap, VCNL_PS_HI_THR_HI,
+					      &data->buf, sizeof(data->buf));
+			if (rc < 0)
+				return rc;
+			*val = be16_to_cpu(data->buf);
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			rc = regmap_bulk_read(data->regmap, VCNL_PS_LO_THR_HI,
+					      &data->buf, sizeof(data->buf));
+			if (rc < 0)
+				return rc;
+			*val = be16_to_cpu(data->buf);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
 		return -EINVAL;
+	}
+}
+
+static int vcnl3020_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	int rc;
+	struct vcnl3020_data *data = iio_priv(indio_dev);
 
-	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
+	mutex_lock(&data->lock);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			/* 16 bit word/ low * high */
+			data->buf = cpu_to_be16(val);
+			rc = regmap_bulk_write(data->regmap, VCNL_PS_HI_THR_HI,
+					       &data->buf, sizeof(data->buf));
+			if (rc < 0)
+				goto err_unlock;
+			rc = IIO_VAL_INT;
+			goto err_unlock;
+		case IIO_EV_DIR_FALLING:
+			data->buf = cpu_to_be16(val);
+			rc = regmap_bulk_write(data->regmap, VCNL_PS_LO_THR_HI,
+					       &data->buf, sizeof(data->buf));
+			if (rc < 0)
+				goto err_unlock;
+			rc = IIO_VAL_INT;
+			goto err_unlock;
+		default:
+			rc = -EINVAL;
+			goto err_unlock;
+		}
+	default:
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+err_unlock:
+	mutex_unlock(&data->lock);
+
+	return rc;
 }
 
+static int vcnl3020_enable_periodic(struct iio_dev *indio_dev,
+				    struct vcnl3020_data *data)
+{
+	int rc;
+	int cmd;
+
+	mutex_lock(&data->lock);
+
+	/* Enable periodic measurement of proximity data. */
+	cmd = VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
+
+	rc = regmap_write(data->regmap, VCNL_COMMAND, cmd);
+	if (rc)
+		goto err_unlock;
+
+	/*
+	 * Enable interrupts on threshold, for proximity data by
+	 * default.
+	 */
+	rc = regmap_write(data->regmap, VCNL_PS_ICR, VCNL_ICR_THRES_EN);
+
+err_unlock:
+	mutex_unlock(&data->lock);
+
+	return rc;
+}
+
+static int vcnl3020_disable_periodic(struct iio_dev *indio_dev,
+				     struct vcnl3020_data *data)
+{
+	int rc;
+
+	mutex_lock(&data->lock);
+
+	rc = regmap_write(data->regmap, VCNL_COMMAND, 0);
+	if (rc)
+		goto err_unlock;
+
+	rc = regmap_write(data->regmap, VCNL_PS_ICR, 0);
+	if (rc)
+		goto err_unlock;
+
+	/* Clear interrupt flag bit */
+	rc = regmap_write(data->regmap, VCNL_ISR, 0);
+
+err_unlock:
+	mutex_unlock(&data->lock);
+
+	return rc;
+}
+
+static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool state)
+{
+	struct vcnl3020_data *data = iio_priv(indio_dev);
+
+	if (state) {
+		return vcnl3020_enable_periodic(indio_dev, data);
+	} else {
+		if (!vcnl3020_is_thr_enabled(data))
+			return 0;
+		return vcnl3020_disable_periodic(indio_dev, data);
+	}
+}
+
+static int vcnl3020_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       int state)
+{
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		return vcnl3020_config_threshold(indio_dev, state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl3020_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	struct vcnl3020_data *data = iio_priv(indio_dev);
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		return vcnl3020_is_thr_enabled(data);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_event_spec vcnl3020_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec vcnl3020_channels[] = {
 	{
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.event_spec = vcnl3020_event_spec,
+		.num_event_specs = ARRAY_SIZE(vcnl3020_event_spec),
 	},
 };
 
@@ -251,17 +504,11 @@ static int vcnl3020_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
 {
-	int rc;
 	struct vcnl3020_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		rc = iio_device_claim_direct_mode(indio_dev);
-		if (rc)
-			return rc;
-		rc = vcnl3020_write_proxy_samp_freq(data, val, val2);
-		iio_device_release_direct_mode(indio_dev);
-		return rc;
+		return vcnl3020_write_proxy_samp_freq(data, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -287,6 +534,10 @@ static const struct iio_info vcnl3020_info = {
 	.read_raw = vcnl3020_read_raw,
 	.write_raw = vcnl3020_write_raw,
 	.read_avail = vcnl3020_read_avail,
+	.read_event_value = vcnl3020_read_event,
+	.write_event_value = vcnl3020_write_event,
+	.read_event_config = vcnl3020_read_event_config,
+	.write_event_config = vcnl3020_write_event_config,
 };
 
 static const struct regmap_config vcnl3020_regmap_config = {
@@ -295,6 +546,40 @@ static const struct regmap_config vcnl3020_regmap_config = {
 	.max_register	= VCNL_PS_MOD_ADJ,
 };
 
+static irqreturn_t vcnl3020_handle_irq_thread(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct vcnl3020_data *data = iio_priv(indio_dev);
+	unsigned int isr;
+	int rc;
+
+	rc = regmap_read(data->regmap, VCNL_ISR, &isr);
+	if (rc) {
+		dev_err(data->dev, "Error (%d) reading reg (0x%x)\n",
+			rc, VCNL_ISR);
+		return IRQ_HANDLED;
+	}
+
+	if (isr & VCNL_ICR_THRES_EN) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
+						    1,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+
+		rc = regmap_write(data->regmap, VCNL_ISR,
+				  isr & VCNL_ICR_THRES_EN);
+		if (rc)
+			dev_err(data->dev, "Error (%d) writing in reg (0x%x)\n",
+				rc, VCNL_ISR);
+	} else {
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int vcnl3020_probe(struct i2c_client *client)
 {
 	struct vcnl3020_data *data;
@@ -327,6 +612,19 @@ static int vcnl3020_probe(struct i2c_client *client)
 	indio_dev->name = "vcnl3020";
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (client->irq) {
+		rc = devm_request_threaded_irq(&client->dev, client->irq,
+					       NULL, vcnl3020_handle_irq_thread,
+					       IRQF_ONESHOT, indio_dev->name,
+					       indio_dev);
+		if (rc) {
+			dev_err(&client->dev,
+				"Error (%d) irq request failed (%u)\n", rc,
+				client->irq);
+			return rc;
+		}
+	}
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.31.1

