Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5691D36FD7F
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhD3PRB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 11:17:01 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:55696 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229969AbhD3PQy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Apr 2021 11:16:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1C9244148B;
        Fri, 30 Apr 2021 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1619795763; x=1621610164; bh=W8rRLVjeBpKReObsLYESpW8i4F7awUTnC6l
        JDY0jLUA=; b=kZQguzMC6iW9Brha0S0ooYab3+yFMjOtBQCmhocc3fP2eq2r1oy
        sjRKXeLb4whCqNHQvKIJn9vueeBxTbAoxwlDcvugKcTjg0XsXj00QiAu6gXTx6Nd
        ua9V2ODpFpmvVPlX1Nsm3kKqTZQAXkJyCKJWbXm1gP3OFEgSJYX7aPRM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x54U983Ft57f; Fri, 30 Apr 2021 18:16:03 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D19294148E;
        Fri, 30 Apr 2021 18:16:03 +0300 (MSK)
Received: from localhost.yadro.com (10.199.0.97) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 30
 Apr 2021 18:16:03 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH 1/4] iio: proximity: vcnl3020: add periodic mode
Date:   Fri, 30 Apr 2021 18:24:16 +0300
Message-ID: <20210430152419.261757-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210430152419.261757-1-i.mikhaylov@yadro.com>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.0.97]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the possibility to run proximity sensor in periodic measurement
mode.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/iio/proximity/vcnl3020.c | 138 +++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 43817f6b3086..25c6bdba3ede 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -36,6 +36,21 @@
 #define VCNL_PS_OD		BIT(3) /* start on-demand proximity
 					* measurement
 					*/
+#define VCNL_PS_EN		BIT(1) /* Enables periodic proximity
+					* measurement
+					*/
+#define VCNL_PS_SELFTIMED_EN	BIT(0) /* Enables state machine and LP
+					* oscillator for self timed
+					* measurements
+					*/
+
+/* Bit masks for ICR */
+#define  VCNL_ICR_THRES_EN	BIT(1) /* Enable interrupts on low or high
+					* thresholds */
+
+/* Bit masks for ISR */
+#define VCNL_INT_TH_HI		BIT(0)	/* High threshold hit */
+#define VCNL_INT_TH_LOW		BIT(1)	/* Low threshold hit */
 
 #define VCNL_ON_DEMAND_TIMEOUT_US	100000
 #define VCNL_POLL_US			20000
@@ -215,12 +230,124 @@ static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
 	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
 }
 
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
+static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool state)
+{
+	struct vcnl3020_data *data = iio_priv(indio_dev);
+	int rc;
+	int icr;
+	int cmd;
+	int isr;
+
+	if (state) {
+		rc = iio_device_claim_direct_mode(indio_dev);
+		if (rc)
+			return rc;
+
+		/* Enable periodic measurement of proximity data. */
+		cmd = VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
+
+		/*
+		 * Enable interrupts on threshold, for proximity data by
+		 * default.
+		 */
+		icr = VCNL_ICR_THRES_EN;
+	} else {
+		if (!vcnl3020_is_thr_enabled(data))
+			return 0;
+
+		cmd = 0;
+		icr = 0;
+		isr = 0;
+	}
+
+	rc = regmap_write(data->regmap, VCNL_COMMAND, cmd);
+	if (rc)
+		goto end;
+
+	rc = regmap_write(data->regmap, VCNL_PS_ICR, icr);
+	if (rc)
+		goto end;
+
+	if (!state)
+		/* Clear interrupts */
+		rc = regmap_write(data->regmap, VCNL_ISR, isr);
+
+end:
+	if (state)
+		iio_device_release_direct_mode(indio_dev);
+
+	return rc;
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
 
@@ -233,6 +360,11 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+
+		/* Protect against event capture. */
+		if (vcnl3020_is_in_periodic_mode(data))
+			return -EBUSY;
+
 		rc = vcnl3020_measure_proximity(data, val);
 		if (rc)
 			return rc;
@@ -254,6 +386,10 @@ static int vcnl3020_write_raw(struct iio_dev *indio_dev,
 	int rc;
 	struct vcnl3020_data *data = iio_priv(indio_dev);
 
+	/* Protect against event capture. */
+	if (vcnl3020_is_in_periodic_mode(data))
+		return -EBUSY;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		rc = iio_device_claim_direct_mode(indio_dev);
@@ -287,6 +423,8 @@ static const struct iio_info vcnl3020_info = {
 	.read_raw = vcnl3020_read_raw,
 	.write_raw = vcnl3020_write_raw,
 	.read_avail = vcnl3020_read_avail,
+	.read_event_config = vcnl3020_read_event_config,
+	.write_event_config = vcnl3020_write_event_config,
 };
 
 static const struct regmap_config vcnl3020_regmap_config = {
-- 
2.26.3

