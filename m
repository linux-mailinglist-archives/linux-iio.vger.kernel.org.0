Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6259131D6A4
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 09:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhBQIeY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 03:34:24 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60400 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231878AbhBQIdx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 03:33:53 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H8UL2t026118;
        Wed, 17 Feb 2021 03:33:01 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb2hux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 03:33:01 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11H8Wxtx007692
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Feb 2021 03:33:00 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 17 Feb 2021 00:32:57 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Wed, 17 Feb 2021 00:32:57 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 17 Feb 2021 00:32:57 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11H8WWlJ007757;
        Wed, 17 Feb 2021 03:32:53 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Mihail Chindris <Mihail.Chindris@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 5/5] iio: dac: ad5686: Add PWM as a trigger source
Date:   Wed, 17 Feb 2021 10:34:38 +0200
Message-ID: <20210217083438.37865-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217083438.37865-1-alexandru.ardelean@analog.com>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_06:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Mircea Caprioru <mircea.caprioru@analog.com>

A PWM signal will be used as a trigger source to have a deterministic
sampling frequency since this family of DAC has no hardware interrupt
source.

This feature is made optional however, as there are some board setups where
this isn't used.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Mihail Chindris <Mihail.Chindris@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dac/ad5686-spi.c |   2 +-
 drivers/iio/dac/ad5686.c     | 146 ++++++++++++++++++++++++++++++++++-
 drivers/iio/dac/ad5686.h     |   7 +-
 drivers/iio/dac/ad5696-i2c.c |   2 +-
 4 files changed, 152 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 0188ded5137c..07fadcf8e1e3 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -92,7 +92,7 @@ static int ad5686_spi_probe(struct spi_device *spi)
 	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	return ad5686_probe(&spi->dev, id->driver_data, id->name,
-			    ad5686_spi_write, ad5686_spi_read);
+			    ad5686_spi_write, ad5686_spi_read, spi->irq);
 }
 
 static int ad5686_spi_remove(struct spi_device *spi)
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 7d6792ac1020..9e48559ec566 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -16,6 +16,10 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include "ad5686.h"
 
@@ -123,6 +127,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
+	struct pwm_state state;
 	int ret;
 
 	switch (m) {
@@ -139,6 +144,10 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 		*val = st->vref_mv;
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		pwm_get_state(st->pwm, &state);
+		*val = DIV_ROUND_CLOSEST_ULL(1000000000ULL, state.period);
+		return IIO_VAL_INT;
 	}
 	return -EINVAL;
 }
@@ -150,6 +159,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
+	struct pwm_state state;
 	int ret;
 
 	switch (mask) {
@@ -164,6 +174,14 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 				val << chan->scan_type.shift);
 		mutex_unlock(&st->lock);
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		pwm_get_state(st->pwm, &state);
+
+		state.period = DIV_ROUND_CLOSEST_ULL(1000000000ULL, val);
+		pwm_set_relative_duty_cycle(&state, 50, 100);
+
+		ret = pwm_apply_state(st->pwm, &state);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -171,7 +189,37 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad5686_trig_set_state(struct iio_trigger *trig,
+				 bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct ad5686_state *st = iio_priv(indio_dev);
+	struct pwm_state pwm_st;
+
+	pwm_get_state(st->pwm, &pwm_st);
+	pwm_st.enabled = state;
+
+	return pwm_apply_state(st->pwm, &pwm_st);
+}
+
+static int ad5686_validate_trigger(struct iio_dev *indio_dev,
+				    struct iio_trigger *trig)
+{
+	struct ad5686_state *st = iio_priv(indio_dev);
+
+	if (st->trig != trig)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops ad5686_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
+	.set_trigger_state = &ad5686_trig_set_state,
+};
+
 static const struct iio_info ad5686_info = {
+	.validate_trigger = &ad5686_validate_trigger,
 	.read_raw = ad5686_read_raw,
 	.write_raw = ad5686_write_raw,
 };
@@ -194,8 +242,10 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.output = 1,					\
 		.channel = chan,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
+					    BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 		.address = addr,				\
+		.scan_index = chan,				\
 		.scan_type = {					\
 			.sign = 'u',				\
 			.realbits = (bits),			\
@@ -428,13 +478,57 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	},
 };
 
+static irqreturn_t ad5686_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	const struct iio_chan_spec *chan;
+	struct iio_buffer *buffer = indio_dev->buffer;
+	struct ad5686_state *st = iio_priv(indio_dev);
+	u8 sample[2];
+	unsigned int i;
+	u16 val;
+	int ret;
+
+	ret = iio_buffer_remove_sample(buffer, sample);
+	if (ret < 0)
+		goto out;
+
+	mutex_lock(&st->lock);
+	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
+		val = (sample[1] << 8) + sample[0];
+
+		chan = iio_find_channel_from_si(indio_dev, i);
+		ret = st->write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
+				chan->address, val << chan->scan_type.shift);
+	}
+	mutex_unlock(&st->lock);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ad5686_irq_handler(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct ad5686_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(st->trig);
+
+	return IRQ_HANDLED;
+}
+
 int ad5686_probe(struct device *dev,
 		 enum ad5686_supported_device_ids chip_type,
 		 const char *name, ad5686_write_func write,
-		 ad5686_read_func read)
+		 ad5686_read_func read, int irq)
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
+	struct pwm_state state;
 	unsigned int val, ref_bit_msk;
 	u8 cmd;
 	int ret, i, voltage_uv = 0;
@@ -450,6 +544,23 @@ int ad5686_probe(struct device *dev,
 	st->write = write;
 	st->read = read;
 
+	mutex_init(&st->lock);
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", name, indio_dev->id);
+	if (st->trig == NULL)
+		ret = -ENOMEM;
+
+	st->trig->ops = &ad5686_trigger_ops;
+	st->trig->dev.parent = dev;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
+
+	ret = devm_iio_trigger_register(dev, st->trig);
+	if (ret)
+		return ret;
+
+	/* select default trigger */
+	indio_dev->trig = iio_trigger_get(st->trig);
+
 	st->reg = devm_regulator_get_optional(dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
@@ -463,6 +574,30 @@ int ad5686_probe(struct device *dev,
 		voltage_uv = ret;
 	}
 
+	/* PWM configuration */
+	st->pwm = devm_pwm_get(dev, "pwm-trigger");
+	if (!IS_ERR(st->pwm)) {
+		/* Set a default pwm frequency of 1kHz and 50% duty cycle */
+		pwm_init_state(st->pwm, &state);
+		state.enabled = false;
+		state.period = 1000000;
+		pwm_set_relative_duty_cycle(&state, 50, 100);
+		ret = pwm_apply_state(st->pwm, &state);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Configure IRQ */
+	if (irq) {
+		ret = devm_request_threaded_irq(dev, irq, NULL, ad5686_irq_handler,
+						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+						"ad5686 irq", indio_dev);
+		if (ret)
+			return ret;
+
+		st->irq = irq;
+	}
+
 	st->chip_info = &ad5686_chip_info_tbl[chip_type];
 
 	if (voltage_uv)
@@ -513,6 +648,13 @@ int ad5686_probe(struct device *dev,
 	if (ret)
 		goto error_disable_reg;
 
+	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev, NULL,
+						  &ad5686_trigger_handler,
+						  IIO_BUFFER_DIRECTION_OUT,
+						  NULL, NULL);
+	if (ret)
+		goto error_disable_reg;
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg;
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index d9c8ba413fe9..b287873553a1 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -12,6 +12,7 @@
 #include <linux/cache.h>
 #include <linux/mutex.h>
 #include <linux/kernel.h>
+#include <linux/pwm.h>
 
 #define AD5310_CMD(x)				((x) << 12)
 
@@ -112,6 +113,7 @@ struct ad5686_chip_info {
 /**
  * struct ad5446_state - driver instance specific data
  * @spi:		spi_device
+ * @pwm:		pwm used for buffer trigger
  * @chip_info:		chip model specific constants, available modes etc
  * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
@@ -124,6 +126,8 @@ struct ad5686_chip_info {
 
 struct ad5686_state {
 	struct device			*dev;
+	struct pwm_device		*pwm;
+	struct iio_trigger		*trig;
 	const struct ad5686_chip_info	*chip_info;
 	struct regulator		*reg;
 	unsigned short			vref_mv;
@@ -133,6 +137,7 @@ struct ad5686_state {
 	ad5686_read_func		read;
 	bool				use_internal_vref;
 	struct mutex			lock;
+	int				irq;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -150,7 +155,7 @@ struct ad5686_state {
 int ad5686_probe(struct device *dev,
 		 enum ad5686_supported_device_ids chip_type,
 		 const char *name, ad5686_write_func write,
-		 ad5686_read_func read);
+		 ad5686_read_func read, int irq);
 
 int ad5686_remove(struct device *dev);
 
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index a39eda7c02d2..f80acc0972ea 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -62,7 +62,7 @@ static int ad5686_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	return ad5686_probe(&i2c->dev, id->driver_data, id->name,
-			    ad5686_i2c_write, ad5686_i2c_read);
+			    ad5686_i2c_write, ad5686_i2c_read, i2c->irq);
 }
 
 static int ad5686_i2c_remove(struct i2c_client *i2c)
-- 
2.17.1

