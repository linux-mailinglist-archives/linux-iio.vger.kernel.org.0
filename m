Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4A459C1F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 06:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhKWGBS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 01:01:18 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:11998 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233629AbhKWGBM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 01:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637647085; x=1669183085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fTwTU1ZrRyHsycPj98uZ+fbJZszR+Zc/L9tGNuRg2ps=;
  b=VqoFFrH984NadEiItp2iQ0fSD/6ZDkYCOKfa/RF10C4dQ7f6WLbLnsgp
   vjmk12f8W8woiAfDxUjajWeBJrtd7QAAMNQhpwZ/kpuTkAXoIPR3A9Zx9
   OhQbiZgr/k72wP1bMJq7HI6KctJnl+QX7lG5dPRFCuw0/ntP9EZjIu5b9
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Nov 2021 21:58:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 21:58:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 22 Nov 2021 21:58:04 -0800
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 22 Nov 2021 21:57:56 -0800
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <amitk@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH V3 4/4] thermal: qcom: add support for PMIC5 Gen2 ADCTM
Date:   Tue, 23 Nov 2021 11:27:04 +0530
Message-ID: <1637647025-20409-5-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
References: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for PMIC5 Gen2 ADC_TM, used on PMIC7 chips. It is a
close counterpart of PMIC7 ADC and has the same functionality as
PMIC5 ADC_TM, for threshold monitoring and interrupt generation.
It is present on PMK8350 alone, like PMIC7 ADC and can be used
to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
having ADC on a target, through PBS(Programmable Boot Sequence).

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 375 ++++++++++++++++++++++++++++++-
 1 file changed, 372 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index fc8cd45..a7b33a8 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -4,7 +4,10 @@
  *
  * Based on original driver:
  * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
+ *
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
  */
+
 #include <linux/bitfield.h>
 #include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/consumer.h>
@@ -71,6 +74,60 @@
 #define ADC_TM5_M_HIGH_THR_INT_EN			BIT(1)
 #define ADC_TM5_M_LOW_THR_INT_EN			BIT(0)
 
+#define ADC_TM_GEN2_STATUS1			0x08
+#define ADC_TM_GEN2_STATUS_LOW_SET		0x09
+#define ADC_TM_GEN2_STATUS_LOW_CLR		0x0a
+#define ADC_TM_GEN2_STATUS_HIGH_SET		0x0b
+#define ADC_TM_GEN2_STATUS_HIGH_CLR		0x0c
+
+#define ADC_TM_GEN2_CFG_HS_SET			0x0d
+#define ADC_TM_GEN2_CFG_HS_FLAG			BIT(0)
+#define ADC_TM_GEN2_CFG_HS_CLR			0x0e
+
+#define ADC_TM_GEN2_SID				0x40
+
+#define ADC_TM_GEN2_CH_CTL			0x41
+#define ADC_TM_GEN2_TM_CH_SEL			GENMASK(7, 5)
+#define ADC_TM_GEN2_MEAS_INT_SEL		GENMASK(3, 2)
+
+#define ADC_TM_GEN2_ADC_DIG_PARAM		0x42
+#define ADC_TM_GEN2_CTL_CAL_SEL			GENMASK(5, 4)
+#define ADC_TM_GEN2_CTL_DEC_RATIO_MASK		GENMASK(3, 2)
+
+#define ADC_TM_GEN2_FAST_AVG_CTL		0x43
+#define ADC_TM_GEN2_FAST_AVG_EN			BIT(7)
+
+#define ADC_TM_GEN2_ADC_CH_SEL_CTL		0x44
+
+#define ADC_TM_GEN2_DELAY_CTL			0x45
+#define ADC_TM_GEN2_HW_SETTLE_DELAY		GENMASK(3, 0)
+
+#define ADC_TM_GEN2_EN_CTL1			0x46
+#define ADC_TM_GEN2_EN				BIT(7)
+
+#define ADC_TM_GEN2_CONV_REQ			0x47
+#define ADC_TM_GEN2_CONV_REQ_EN			BIT(7)
+
+#define ADC_TM_GEN2_LOW_THR0			0x49
+#define ADC_TM_GEN2_LOW_THR1			0x4a
+#define ADC_TM_GEN2_HIGH_THR0			0x4b
+#define ADC_TM_GEN2_HIGH_THR1			0x4c
+#define ADC_TM_GEN2_LOWER_MASK(n)		((n) & GENMASK(7, 0))
+#define ADC_TM_GEN2_UPPER_MASK(n)		(((n) & GENMASK(15, 8)) >> 8)
+
+#define ADC_TM_GEN2_MEAS_IRQ_EN			0x4d
+#define ADC_TM_GEN2_MEAS_EN			BIT(7)
+#define ADC_TM5_GEN2_HIGH_THR_INT_EN		BIT(1)
+#define ADC_TM5_GEN2_LOW_THR_INT_EN		BIT(0)
+
+#define ADC_TM_GEN2_MEAS_INT_LSB		0x50
+#define ADC_TM_GEN2_MEAS_INT_MSB		0x51
+#define ADC_TM_GEN2_MEAS_INT_MODE		0x52
+
+#define ADC_TM_GEN2_Mn_DATA0(n)			((n * 2) + 0xa0)
+#define ADC_TM_GEN2_Mn_DATA1(n)			((n * 2) + 0xa1)
+#define ADC_TM_GEN2_DATA_SHIFT			8
+
 enum adc5_timer_select {
 	ADC5_TIMER_SEL_1 = 0,
 	ADC5_TIMER_SEL_2,
@@ -81,6 +138,7 @@ enum adc5_timer_select {
 enum adc5_gen {
 	ADC_TM5,
 	ADC_TM_HC,
+	ADC_TM5_GEN2,
 	ADC_TM5_MAX
 };
 
@@ -90,6 +148,14 @@ enum adc_tm5_cal_method {
 	ADC_TM5_ABSOLUTE_CAL
 };
 
+enum adc_tm_gen2_time_select {
+	MEAS_INT_50MS = 0,
+	MEAS_INT_100MS,
+	MEAS_INT_1S,
+	MEAS_INT_SET,
+	MEAS_INT_NONE,
+};
+
 struct adc_tm5_chip;
 struct adc_tm5_channel;
 
@@ -112,6 +178,12 @@ struct adc_tm5_data {
  * @prescale: channel scaling performed on the input signal.
  * @hw_settle_time: the time between AMUX being configured and the
  *	start of conversion.
+ * @decimation: sampling rate supported for the channel.
+ * @avg_samples: ability to provide single result from the ADC
+ *	that is an average of multiple measurements.
+ * @high_thr_en: channel upper voltage threshold enable state.
+ * @low_thr_en: channel lower voltage threshold enable state.
+ * @meas_en: recurring measurement enable state
  * @iio: IIO channel instance used by this channel.
  * @chip: ADC TM chip instance.
  * @tzd: thermal zone device used by this channel.
@@ -122,6 +194,11 @@ struct adc_tm5_channel {
 	enum adc_tm5_cal_method	cal_method;
 	unsigned int		prescale;
 	unsigned int		hw_settle_time;
+	unsigned int		decimation;	/* For Gen2 ADC_TM */
+	unsigned int		avg_samples;	/* For Gen2 ADC_TM */
+	bool			high_thr_en;	/* For Gen2 ADC_TM */
+	bool			low_thr_en;	/* For Gen2 ADC_TM */
+	bool			meas_en;	/* For Gen2 ADC_TM */
 	struct iio_channel	*iio;
 	struct adc_tm5_chip	*chip;
 	struct thermal_zone_device *tzd;
@@ -135,9 +212,15 @@ struct adc_tm5_channel {
  * @channels: array of ADC TM channel data.
  * @nchannels: amount of channels defined/allocated
  * @decimation: sampling rate supported for the channel.
+ *      Applies to all channels, used only on Gen1 ADC_TM.
  * @avg_samples: ability to provide single result from the ADC
- *	that is an average of multiple measurements.
+ *      that is an average of multiple measurements. Applies to all
+ *      channels, used only on Gen1 ADC_TM.
  * @base: base address of TM registers.
+ * @adc_mutex_lock: ADC_TM mutex lock, used only on Gen2 ADC_TM.
+ *      It is used to ensure only one ADC channel configuration
+ *      is done at a time using the shared set of configuration
+ *      registers.
  */
 struct adc_tm5_chip {
 	struct regmap		*regmap;
@@ -148,6 +231,7 @@ struct adc_tm5_chip {
 	unsigned int		decimation;
 	unsigned int		avg_samples;
 	u16			base;
+	struct mutex		adc_mutex_lock;
 };
 
 static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
@@ -214,6 +298,61 @@ static irqreturn_t adc_tm5_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t adc_tm5_gen2_isr(int irq, void *data)
+{
+	struct adc_tm5_chip *chip = data;
+	u8 status_low, status_high;
+	int ret, i;
+
+	ret = adc_tm5_read(chip, ADC_TM_GEN2_STATUS_LOW_CLR, &status_low, sizeof(status_low));
+	if (ret) {
+		dev_err(chip->dev, "read status_low failed: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc_tm5_read(chip, ADC_TM_GEN2_STATUS_HIGH_CLR, &status_high, sizeof(status_high));
+	if (ret) {
+		dev_err(chip->dev, "read status_high failed: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_STATUS_LOW_CLR, &status_low, sizeof(status_low));
+	if (ret < 0) {
+		dev_err(chip->dev, "clear status low failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_STATUS_HIGH_CLR, &status_high, sizeof(status_high));
+	if (ret < 0) {
+		dev_err(chip->dev, "clear status high failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	for (i = 0; i < chip->nchannels; i++) {
+		bool upper_set = false, lower_set = false;
+		unsigned int ch = chip->channels[i].channel;
+
+		/* No TZD, we warned at the boot time */
+		if (!chip->channels[i].tzd)
+			continue;
+
+		if (!chip->channels[i].meas_en)
+			continue;
+
+		lower_set = (status_low & BIT(ch)) &&
+			(chip->channels[i].low_thr_en);
+
+		upper_set = (status_high & BIT(ch)) &&
+			(chip->channels[i].high_thr_en);
+
+		if (upper_set || lower_set)
+			thermal_zone_device_update(chip->channels[i].tzd,
+						   THERMAL_EVENT_UNSPECIFIED);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int adc_tm5_get_temp(void *data, int *temp)
 {
 	struct adc_tm5_channel *channel = data;
@@ -244,6 +383,104 @@ static int adc_tm5_disable_channel(struct adc_tm5_channel *channel)
 				  0);
 }
 
+#define ADC_TM_GEN2_POLL_DELAY_MIN_US		100
+#define ADC_TM_GEN2_POLL_DELAY_MAX_US		110
+#define ADC_TM_GEN2_POLL_RETRY_COUNT		3
+
+static int32_t adc_tm5_gen2_conv_req(struct adc_tm5_chip *chip)
+{
+	int ret;
+	u8 data;
+	unsigned int count;
+
+	data = ADC_TM_GEN2_EN;
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_EN_CTL1, &data, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "adc-tm enable failed with %d\n", ret);
+		return ret;
+	}
+
+	data = ADC_TM_GEN2_CFG_HS_FLAG;
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_CFG_HS_SET, &data, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "adc-tm handshake failed with %d\n", ret);
+		return ret;
+	}
+
+	data = ADC_TM_GEN2_CONV_REQ_EN;
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_CONV_REQ, &data, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "adc-tm request conversion failed with %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * SW sets a handshake bit and waits for PBS to clear it
+	 * before the next conversion request can be queued.
+	 */
+
+	for (count = 0; count < ADC_TM_GEN2_POLL_RETRY_COUNT; count++) {
+		ret = adc_tm5_read(chip, ADC_TM_GEN2_CFG_HS_SET, &data, sizeof(data));
+		if (ret < 0) {
+			dev_err(chip->dev, "adc-tm read failed with %d\n", ret);
+			return ret;
+		}
+
+		if (!(data & ADC_TM_GEN2_CFG_HS_FLAG))
+			return ret;
+		usleep_range(ADC_TM_GEN2_POLL_DELAY_MIN_US,
+			ADC_TM_GEN2_POLL_DELAY_MAX_US);
+	}
+
+	dev_err(chip->dev, "adc-tm conversion request handshake timed out\n");
+
+	return -ETIMEDOUT;
+}
+
+static int adc_tm5_gen2_disable_channel(struct adc_tm5_channel *channel)
+{
+	struct adc_tm5_chip *chip = channel->chip;
+	int ret;
+	u8 val;
+
+	mutex_lock(&chip->adc_mutex_lock);
+
+	channel->meas_en = false;
+	channel->high_thr_en = false;
+	channel->low_thr_en = false;
+
+	ret = adc_tm5_read(chip, ADC_TM_GEN2_CH_CTL, &val, sizeof(val));
+	if (ret < 0) {
+		dev_err(chip->dev, "adc-tm block read failed with %d\n", ret);
+		goto disable_fail;
+	}
+
+	val &= ~ADC_TM_GEN2_TM_CH_SEL;
+	val |= FIELD_PREP(ADC_TM_GEN2_TM_CH_SEL, channel->channel);
+
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_CH_CTL, &val, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "adc-tm channel disable failed with %d\n", ret);
+		goto disable_fail;
+	}
+
+	val = 0;
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_MEAS_IRQ_EN, &val, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "adc-tm interrupt disable failed with %d\n", ret);
+		goto disable_fail;
+	}
+
+
+	ret = adc_tm5_gen2_conv_req(channel->chip);
+	if (ret < 0)
+		dev_err(chip->dev, "adc-tm channel configure failed with %d\n", ret);
+
+disable_fail:
+	mutex_unlock(&chip->adc_mutex_lock);
+	return ret;
+}
+
 static int adc_tm5_enable(struct adc_tm5_chip *chip)
 {
 	int ret;
@@ -324,6 +561,86 @@ static int adc_tm5_configure(struct adc_tm5_channel *channel, int low, int high)
 	return adc_tm5_enable(chip);
 }
 
+static int adc_tm5_gen2_configure(struct adc_tm5_channel *channel, int low, int high)
+{
+	struct adc_tm5_chip *chip = channel->chip;
+	int ret;
+	u8 buf[14];
+	u16 adc_code;
+
+	mutex_lock(&chip->adc_mutex_lock);
+
+	channel->meas_en = true;
+
+	ret = adc_tm5_read(chip, ADC_TM_GEN2_SID, buf, sizeof(buf));
+	if (ret < 0) {
+		dev_err(chip->dev, "adc-tm block read failed with %d\n", ret);
+		goto config_fail;
+	}
+
+	/* Set SID from virtual channel number */
+	buf[0] = channel->adc_channel >> 8;
+
+	/* Set TM channel number used and measurement interval */
+	buf[1] &= ~ADC_TM_GEN2_TM_CH_SEL;
+	buf[1] |= FIELD_PREP(ADC_TM_GEN2_TM_CH_SEL, channel->channel);
+	buf[1] &= ~ADC_TM_GEN2_MEAS_INT_SEL;
+	buf[1] |= FIELD_PREP(ADC_TM_GEN2_MEAS_INT_SEL, MEAS_INT_1S);
+
+	buf[2] &= ~ADC_TM_GEN2_CTL_DEC_RATIO_MASK;
+	buf[2] |= FIELD_PREP(ADC_TM_GEN2_CTL_DEC_RATIO_MASK, channel->decimation);
+	buf[2] &= ~ADC_TM_GEN2_CTL_CAL_SEL;
+	buf[2] |= FIELD_PREP(ADC_TM_GEN2_CTL_CAL_SEL, channel->cal_method);
+
+	buf[3] = channel->avg_samples | ADC_TM_GEN2_FAST_AVG_EN;
+
+	buf[4] = channel->adc_channel & 0xff;
+
+	buf[5] = channel->hw_settle_time & ADC_TM_GEN2_HW_SETTLE_DELAY;
+
+	/* High temperature corresponds to low voltage threshold */
+	if (high != INT_MAX) {
+		channel->low_thr_en = true;
+		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high);
+
+		buf[9] = adc_code & 0xff;
+		buf[10] = adc_code >> 8;
+	} else {
+		channel->low_thr_en = false;
+	}
+
+	/* Low temperature corresponds to high voltage threshold */
+	if (low != -INT_MAX) {
+		channel->high_thr_en = true;
+		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low);
+
+		buf[11] = adc_code & 0xff;
+		buf[12] = adc_code >> 8;
+	} else {
+		channel->high_thr_en = false;
+	}
+
+	buf[13] = ADC_TM_GEN2_MEAS_EN;
+	if (channel->high_thr_en)
+		buf[13] |= ADC_TM5_GEN2_HIGH_THR_INT_EN;
+	if (channel->low_thr_en)
+		buf[13] |= ADC_TM5_GEN2_LOW_THR_INT_EN;
+
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_SID, buf, sizeof(buf));
+	if (ret) {
+		dev_err(chip->dev, "channel %d params write failed: %d\n", channel->channel, ret);
+		goto config_fail;
+	}
+
+	ret = adc_tm5_gen2_conv_req(channel->chip);
+	if (ret < 0)
+		dev_err(chip->dev, "adc-tm channel configure failed with %d\n", ret);
+
+config_fail:
+	mutex_unlock(&chip->adc_mutex_lock);
+	return ret;
+}
+
 static int adc_tm5_set_trips(void *data, int low, int high)
 {
 	struct adc_tm5_channel *channel = data;
@@ -422,6 +739,11 @@ static int adc_tm5_init(struct adc_tm5_chip *chip)
 		}
 	}
 
+	mutex_init(&chip->adc_mutex_lock);
+
+	if (chip->data->gen == ADC_TM5_GEN2)
+		return ret;
+
 	buf[0] = chip->decimation;
 	buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
 	buf[2] = ADC_TM5_TIMER1;
@@ -442,7 +764,7 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
 				       struct device_node *node)
 {
 	const char *name = node->name;
-	u32 chan, value, varr[2];
+	u32 chan, value, adc_channel, varr[2];
 	int ret;
 	struct device *dev = adc_tm->dev;
 	struct of_phandle_args args;
@@ -472,7 +794,11 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
 	}
 	of_node_put(args.np);
 
-	if (args.args_count != 1 || args.args[0] >= ADC5_MAX_CHANNEL) {
+	adc_channel = args.args[0];
+	if (adc_tm->data->gen == ADC_TM5_GEN2)
+		adc_channel &= 0xff;
+
+	if (args.args_count != 1 || adc_channel >= ADC5_MAX_CHANNEL) {
 		dev_err(dev, "%s: invalid ADC channel number %d\n", name, chan);
 		return -EINVAL;
 	}
@@ -518,6 +844,32 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
 	else
 		channel->cal_method = ADC_TM5_ABSOLUTE_CAL;
 
+	if (adc_tm->data->gen == ADC_TM5_GEN2) {
+		ret = of_property_read_u32(node, "qcom,decimation", &value);
+		if (!ret) {
+			ret = qcom_adc5_decimation_from_dt(value, adc_tm->data->decimation);
+			if (ret < 0) {
+				dev_err(dev, "invalid decimation %d\n", value);
+				return ret;
+			}
+			channel->decimation = ret;
+		} else {
+			channel->decimation = ADC5_DECIMATION_DEFAULT;
+		}
+
+		ret = of_property_read_u32(node, "qcom,avg-samples", &value);
+		if (!ret) {
+			ret = qcom_adc5_avg_samples_from_dt(value);
+			if (ret < 0) {
+				dev_err(dev, "invalid avg-samples %d\n", value);
+				return ret;
+			}
+			channel->avg_samples = ret;
+		} else {
+			channel->avg_samples = VADC_DEF_AVG_SAMPLES;
+		}
+	}
+
 	return 0;
 }
 
@@ -546,6 +898,19 @@ static const struct adc_tm5_data adc_tm_hc_data_pmic = {
 	.gen = ADC_TM_HC,
 };
 
+static const struct adc_tm5_data adc_tm5_gen2_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) { 85, 340, 1360 },
+	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
+					 1000, 2000, 4000, 8000, 16000, 32000,
+					 64000, 128000 },
+	.disable_channel = adc_tm5_gen2_disable_channel,
+	.configure = adc_tm5_gen2_configure,
+	.isr = adc_tm5_gen2_isr,
+	.irq_name = "pm-adc-tm5-gen2",
+	.gen = ADC_TM5_GEN2,
+};
+
 static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
 {
 	struct adc_tm5_channel *channels;
@@ -671,6 +1036,10 @@ static const struct of_device_id adc_tm5_match_table[] = {
 		.compatible = "qcom,spmi-adc-tm-hc",
 		.data = &adc_tm_hc_data_pmic,
 	},
+	{
+		.compatible = "qcom,spmi-adc-tm5-gen2",
+		.data = &adc_tm5_gen2_data_pmic,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc_tm5_match_table);
-- 
2.7.4

