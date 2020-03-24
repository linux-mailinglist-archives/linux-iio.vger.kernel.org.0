Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 471FB191544
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 16:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgCXPqY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 11:46:24 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:64969 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728107AbgCXPqX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 11:46:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585064782; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pEhwZ2hT2J8RnerqY6fNSRco2R/9Q/1O1NL264QvQ1k=; b=RJ8SVFJtil2wMInFwOHTTEAp0argDLH+kRXgyTaA5iGTqdN2cfFcr5Gq+QenDey4YKjXAksI
 YbLOMp/L6vQ8p9bF8rVbQ4rQahHfNf5L2eFFRoSY81x6QbtDT5pPl0Y6ASvBHsHKSk07aPZ9
 RFps6Sp5fcLaHiN3K/aqUHMaHfY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7a2b41.7fd79ffff2d0-smtp-out-n03;
 Tue, 24 Mar 2020 15:46:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A45CC44791; Tue, 24 Mar 2020 15:46:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C643BC433D2;
        Tue, 24 Mar 2020 15:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C643BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
From:   Jishnu Prakash <jprakash@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org, sboyd@codeaurora.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org,
        Jishnu Prakash <jprakash@codeaurora.org>
Subject: [PATCH 3/3] iio: adc: Add support for PMIC7 ADC
Date:   Tue, 24 Mar 2020 21:14:10 +0530
Message-Id: <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC architecture on PMIC7 is changed as compared to PMIC5. The
major change from PMIC5 is that all SW communication to ADC goes through
PMK8350, which communicates with other PMICs through PBS when the ADC
on PMK8350 works in master mode. The SID register is used to identify the
PMICs with which the PBS needs to communicate. Add support for the same.

In addition, add definitions for ADC channels and virtual channel
definitions per PMIC, to be used by ADC clients for PMIC7.

Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c                 | 239 ++++++++++++++++++++-
 drivers/iio/adc/qcom-vadc-common.c               | 260 +++++++++++++++++++++++
 drivers/iio/adc/qcom-vadc-common.h               |  14 ++
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h  |  67 ++++++
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h |  88 ++++++++
 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h |  46 ++++
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h |  28 +++
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h |  28 +++
 include/dt-bindings/iio/qcom,spmi-vadc.h         |  78 ++++++-
 9 files changed, 843 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 21fdcde..bcfb749 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/bitops.h>
@@ -23,6 +23,7 @@
 
 #define ADC5_USR_REVISION1			0x0
 #define ADC5_USR_STATUS1			0x8
+#define ADC5_USR_STATUS1_CONV_FAULT		BIT(7)
 #define ADC5_USR_STATUS1_REQ_STS		BIT(1)
 #define ADC5_USR_STATUS1_EOC			BIT(0)
 #define ADC5_USR_STATUS1_REQ_STS_EOC_MASK	0x3
@@ -65,6 +66,9 @@
 
 #define ADC5_USR_IBAT_DATA1			0x53
 
+#define ADC_CHANNEL_OFFSET			0x8
+#define ADC_CHANNEL_MASK			0xff
+
 /*
  * Conversion time varies based on the decimation, clock rate, fast average
  * samples and measurements queued across different VADC peripherals.
@@ -79,6 +83,11 @@
 #define ADC5_HW_SETTLE_DIFF_MINOR		3
 #define ADC5_HW_SETTLE_DIFF_MAJOR		5
 
+/* For PMIC7 */
+#define ADC_APP_SID				0x40
+#define ADC_APP_SID_MASK			0xf
+#define ADC7_CONV_TIMEOUT			msecs_to_jiffies(10)
+
 enum adc5_cal_method {
 	ADC5_NO_CAL = 0,
 	ADC5_RATIOMETRIC_CAL,
@@ -96,6 +105,7 @@ enum adc5_cal_val {
  * @cal_method: calibration method.
  * @cal_val: calibration value
  * @decimation: sampling rate supported for the channel.
+ * @sid: slave id of PMIC owning the channel, for PMIC7.
  * @prescale: channel scaling performed on the input signal.
  * @hw_settle_time: the time between AMUX being configured and the
  *	start of conversion.
@@ -110,6 +120,7 @@ struct adc5_channel_prop {
 	enum adc5_cal_method	cal_method;
 	enum adc5_cal_val	cal_val;
 	unsigned int		decimation;
+	unsigned int		sid;
 	unsigned int		prescale;
 	unsigned int		hw_settle_time;
 	unsigned int		avg_samples;
@@ -140,6 +151,7 @@ struct adc5_chip {
 	bool			poll_eoc;
 	struct completion	complete;
 	struct mutex		lock;
+	bool			is_pmic7;
 	const struct adc5_data	*data;
 };
 
@@ -165,6 +177,11 @@ static int adc5_write(struct adc5_chip *adc, u16 offset, u8 *data, int len)
 	return regmap_bulk_write(adc->regmap, adc->base + offset, data, len);
 }
 
+static int adc5_masked_write(struct adc5_chip *adc, u16 offset, u8 mask, u8 val)
+{
+	return regmap_update_bits(adc->regmap, adc->base + offset, mask, val);
+}
+
 static int adc5_prescaling_from_dt(u32 num, u32 den)
 {
 	unsigned int pre;
@@ -314,6 +331,49 @@ static int adc5_configure(struct adc5_chip *adc,
 	return adc5_write(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
 }
 
+static int adc7_configure(struct adc5_chip *adc,
+			struct adc5_channel_prop *prop)
+{
+	int ret;
+	u8 conv_req = 0, buf[4];
+
+	ret = adc5_masked_write(adc, ADC_APP_SID, ADC_APP_SID_MASK, prop->sid);
+	if (ret)
+		return ret;
+
+	ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	/* Digital param selection */
+	adc5_update_dig_param(adc, prop, &buf[0]);
+
+	/* Update fast average sample value */
+	buf[1] &= (u8) ~ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK;
+	buf[1] |= prop->avg_samples;
+
+	/* Select ADC channel */
+	buf[2] = prop->channel;
+
+	/* Select HW settle delay for channel */
+	buf[3] &= (u8) ~ADC5_USR_HW_SETTLE_DELAY_MASK;
+	buf[3] |= prop->hw_settle_time;
+
+	/* Select CONV request */
+	conv_req = ADC5_USR_CONV_REQ_REQ;
+
+	if (!adc->poll_eoc)
+		reinit_completion(&adc->complete);
+
+	ret = adc5_write(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	ret = adc5_write(adc, ADC5_USR_CONV_REQ, &conv_req, 1);
+
+	return ret;
+}
+
 static int adc5_do_conversion(struct adc5_chip *adc,
 			struct adc5_channel_prop *prop,
 			struct iio_chan_spec const *chan,
@@ -355,6 +415,44 @@ static int adc5_do_conversion(struct adc5_chip *adc,
 	return ret;
 }
 
+static int adc7_do_conversion(struct adc5_chip *adc,
+			struct adc5_channel_prop *prop,
+			struct iio_chan_spec const *chan,
+			u16 *data_volt, u16 *data_cur)
+{
+	int ret;
+	u8 status = 0;
+
+	mutex_lock(&adc->lock);
+
+	ret = adc7_configure(adc, prop);
+	if (ret) {
+		pr_err("ADC configure failed with %d\n", ret);
+		goto unlock;
+	}
+
+	/* No support for polling mode at present*/
+	wait_for_completion_timeout(&adc->complete,
+					ADC7_CONV_TIMEOUT);
+
+	ret = adc5_read(adc, ADC5_USR_STATUS1, &status, 1);
+	if (ret < 0)
+		goto unlock;
+
+	if (status & ADC5_USR_STATUS1_CONV_FAULT) {
+		pr_err("Unexpected conversion fault\n");
+		ret = -EIO;
+		goto unlock;
+	}
+
+	ret = adc5_read_voltage_data(adc, data_volt);
+
+unlock:
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
 static irqreturn_t adc5_isr(int irq, void *dev_id)
 {
 	struct adc5_chip *adc = dev_id;
@@ -377,6 +475,56 @@ static int adc5_of_xlate(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int adc7_of_xlate(struct iio_dev *indio_dev,
+				const struct of_phandle_args *iiospec)
+{
+	struct adc5_chip *adc = iio_priv(indio_dev);
+	int i, v_channel;
+
+	for (i = 0; i < adc->nchannels; i++) {
+		v_channel = ((adc->chan_props[i].sid << ADC_CHANNEL_OFFSET) |
+			adc->chan_props[i].channel);
+		if (v_channel == iiospec->args[0])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int adc7_read_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan, int *val, int *val2,
+			 long mask)
+{
+	struct adc5_chip *adc = iio_priv(indio_dev);
+	struct adc5_channel_prop *prop;
+	u16 adc_code_volt, adc_code_cur;
+	int ret;
+
+	prop = &adc->chan_props[chan->address];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = adc7_do_conversion(adc, prop, chan,
+					&adc_code_volt, &adc_code_cur);
+		if (ret)
+			return ret;
+
+		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
+			&adc5_prescale_ratios[prop->prescale],
+			adc->data,
+			adc_code_volt, val);
+
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int adc5_read_raw(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask)
@@ -415,6 +563,11 @@ static const struct iio_info adc5_info = {
 	.of_xlate = adc5_of_xlate,
 };
 
+static const struct iio_info adc7_info = {
+	.read_raw = adc7_read_raw,
+	.of_xlate = adc7_of_xlate,
+};
+
 struct adc5_channels {
 	const char *datasheet_name;
 	unsigned int prescale_index;
@@ -477,6 +630,39 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_PM5_SMB_TEMP)
 };
 
+static const struct adc5_channels adc7_chans_pmic[ADC5_MAX_CHANNEL] = {
+	[ADC7_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 0,
+					SCALE_HW_CALIB_DEFAULT)
+	[ADC7_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
+					SCALE_HW_CALIB_DEFAULT)
+	[ADC7_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
+					SCALE_HW_CALIB_DEFAULT)
+	[ADC7_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 3,
+					SCALE_HW_CALIB_DEFAULT)
+	[ADC7_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
+					SCALE_HW_CALIB_PMIC_THERM_PM7)
+	[ADC7_AMUX_THM1_100K_PU]	= ADC5_CHAN_TEMP("amux_thm1_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC7_AMUX_THM2_100K_PU]	= ADC5_CHAN_TEMP("amux_thm2_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC7_AMUX_THM3_100K_PU]	= ADC5_CHAN_TEMP("amux_thm3_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC7_AMUX_THM4_100K_PU]	= ADC5_CHAN_TEMP("amux_thm4_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC7_AMUX_THM5_100K_PU]	= ADC5_CHAN_TEMP("amux_thm5_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC7_AMUX_THM6_100K_PU]	= ADC5_CHAN_TEMP("amux_thm6_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC7_GPIO1_100K_PU]	= ADC5_CHAN_TEMP("gpio1_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC7_GPIO2_100K_PU]	= ADC5_CHAN_TEMP("gpio2_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC7_GPIO3_100K_PU]	= ADC5_CHAN_TEMP("gpio3_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+	[ADC7_GPIO4_100K_PU]	= ADC5_CHAN_TEMP("gpio4_pu2", 0,
+					SCALE_HW_CALIB_THERM_100K_PU_PM7)
+};
+
 static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
 	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 0,
 					SCALE_HW_CALIB_DEFAULT)
@@ -511,6 +697,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 {
 	const char *name = node->name, *channel_name;
 	u32 chan, value, varr[2];
+	u32 sid = 0;
 	int ret;
 	struct device *dev = adc->dev;
 
@@ -520,6 +707,15 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 		return ret;
 	}
 
+	/*
+	 * Value read from "reg" is virtual channel number
+	 * virtual channel number = (sid << 8 | channel number).
+	 */
+	if (adc->is_pmic7) {
+		sid = (chan >> ADC_CHANNEL_OFFSET);
+		chan = (chan & ADC_CHANNEL_MASK);
+	}
+
 	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA ||
 	    !data->adc_chans[chan].datasheet_name) {
 		dev_err(dev, "%s invalid channel number %d\n", name, chan);
@@ -528,6 +724,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	/* the channel has DT description */
 	prop->channel = chan;
+	prop->sid = sid;
 
 	channel_name = of_get_property(node,
 				"label", NULL) ? : node->name;
@@ -578,8 +775,9 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 		pr_debug("dig_ver:minor:%d, major:%d\n", dig_version[0],
 						dig_version[1]);
 		/* Digital controller >= 5.3 have hw_settle_2 option */
-		if (dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
-			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR)
+		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
+			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR) ||
+			(adc->is_pmic7))
 			ret = adc5_hw_settle_time_from_dt(value,
 							data->hw_settle_2);
 		else
@@ -639,6 +837,17 @@ static const struct adc5_data adc5_data_pmic = {
 				1, 2, 4, 8, 16, 32, 64, 128},
 };
 
+static const struct adc5_data adc7_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.adc_chans = adc7_chans_pmic,
+	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
+				{85, 340, 1360},
+	.hw_settle_2 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
+				{15, 100, 200, 300, 400, 500, 600, 700,
+				1000, 2000, 4000, 8000, 16000, 32000,
+				64000, 128000},
+};
+
 static const struct adc5_data adc5_data_pmic_rev2 = {
 	.full_scale_code_volt = 0x4000,
 	.full_scale_code_cur = 0x1800,
@@ -659,6 +868,10 @@ static const struct of_device_id adc5_match_table[] = {
 		.data = &adc5_data_pmic,
 	},
 	{
+		.compatible = "qcom,spmi-adc7",
+		.data = &adc7_data_pmic,
+	},
+	{
 		.compatible = "qcom,spmi-adc-rev2",
 		.data = &adc5_data_pmic_rev2,
 	},
@@ -752,6 +965,16 @@ static int adc5_probe(struct platform_device *pdev)
 	adc->regmap = regmap;
 	adc->dev = dev;
 	adc->base = reg;
+
+	platform_set_drvdata(pdev, adc);
+
+	if (of_device_is_compatible(node, "qcom,spmi-adc7")) {
+		indio_dev->info = &adc7_info;
+		adc->is_pmic7 = true;
+	} else {
+		indio_dev->info = &adc5_info;
+	}
+
 	init_completion(&adc->complete);
 	mutex_init(&adc->lock);
 
@@ -777,19 +1000,27 @@ static int adc5_probe(struct platform_device *pdev)
 	indio_dev->dev.of_node = node;
 	indio_dev->name = pdev->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &adc5_info;
 	indio_dev->channels = adc->iio_chans;
 	indio_dev->num_channels = adc->nchannels;
 
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static int adc5_exit(struct platform_device *pdev)
+{
+	struct adc5_chip *adc = platform_get_drvdata(pdev);
+
+	mutex_destroy(&adc->lock);
+	return 0;
+}
+
 static struct platform_driver adc5_driver = {
 	.driver = {
 		.name = "qcom-spmi-adc5.c",
 		.of_match_table = adc5_match_table,
 	},
 	.probe = adc5_probe,
+	.remove = adc5_exit,
 };
 module_platform_driver(adc5_driver);
 
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 2bb78d1..43d2473 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -89,6 +89,195 @@ static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] = {
 	{ 46,	125000 },
 };
 
+static const struct vadc_map_pt adcmap7_die_temp[] = {
+	{ 433700, 1967},
+	{ 473100, 1964},
+	{ 512400, 1957},
+	{ 551500, 1949},
+	{ 590500, 1940},
+	{ 629300, 1930},
+	{ 667900, 1921},
+	{ 706400, 1910},
+	{ 744600, 1896},
+	{ 782500, 1878},
+	{ 820100, 1859},
+	{ 857300, 0},
+};
+
+/*
+ * Resistance to temperature table for 100k pull up for NTCG104EF104.
+ */
+static const struct vadc_map_pt adcmap7_100k[] = {
+	{ 4250657, -40960 },
+	{ 3962085, -39936 },
+	{ 3694875, -38912 },
+	{ 3447322, -37888 },
+	{ 3217867, -36864 },
+	{ 3005082, -35840 },
+	{ 2807660, -34816 },
+	{ 2624405, -33792 },
+	{ 2454218, -32768 },
+	{ 2296094, -31744 },
+	{ 2149108, -30720 },
+	{ 2012414, -29696 },
+	{ 1885232, -28672 },
+	{ 1766846, -27648 },
+	{ 1656598, -26624 },
+	{ 1553884, -25600 },
+	{ 1458147, -24576 },
+	{ 1368873, -23552 },
+	{ 1285590, -22528 },
+	{ 1207863, -21504 },
+	{ 1135290, -20480 },
+	{ 1067501, -19456 },
+	{ 1004155, -18432 },
+	{ 944935, -17408 },
+	{ 889550, -16384 },
+	{ 837731, -15360 },
+	{ 789229, -14336 },
+	{ 743813, -13312 },
+	{ 701271, -12288 },
+	{ 661405, -11264 },
+	{ 624032, -10240 },
+	{ 588982, -9216 },
+	{ 556100, -8192 },
+	{ 525239, -7168 },
+	{ 496264, -6144 },
+	{ 469050, -5120 },
+	{ 443480, -4096 },
+	{ 419448, -3072 },
+	{ 396851, -2048 },
+	{ 375597, -1024 },
+	{ 355598, 0 },
+	{ 336775, 1024 },
+	{ 319052, 2048 },
+	{ 302359, 3072 },
+	{ 286630, 4096 },
+	{ 271806, 5120 },
+	{ 257829, 6144 },
+	{ 244646, 7168 },
+	{ 232209, 8192 },
+	{ 220471, 9216 },
+	{ 209390, 10240 },
+	{ 198926, 11264 },
+	{ 189040, 12288 },
+	{ 179698, 13312 },
+	{ 170868, 14336 },
+	{ 162519, 15360 },
+	{ 154622, 16384 },
+	{ 147150, 17408 },
+	{ 140079, 18432 },
+	{ 133385, 19456 },
+	{ 127046, 20480 },
+	{ 121042, 21504 },
+	{ 115352, 22528 },
+	{ 109960, 23552 },
+	{ 104848, 24576 },
+	{ 100000, 25600 },
+	{ 95402, 26624 },
+	{ 91038, 27648 },
+	{ 86897, 28672 },
+	{ 82965, 29696 },
+	{ 79232, 30720 },
+	{ 75686, 31744 },
+	{ 72316, 32768 },
+	{ 69114, 33792 },
+	{ 66070, 34816 },
+	{ 63176, 35840 },
+	{ 60423, 36864 },
+	{ 57804, 37888 },
+	{ 55312, 38912 },
+	{ 52940, 39936 },
+	{ 50681, 40960 },
+	{ 48531, 41984 },
+	{ 46482, 43008 },
+	{ 44530, 44032 },
+	{ 42670, 45056 },
+	{ 40897, 46080 },
+	{ 39207, 47104 },
+	{ 37595, 48128 },
+	{ 36057, 49152 },
+	{ 34590, 50176 },
+	{ 33190, 51200 },
+	{ 31853, 52224 },
+	{ 30577, 53248 },
+	{ 29358, 54272 },
+	{ 28194, 55296 },
+	{ 27082, 56320 },
+	{ 26020, 57344 },
+	{ 25004, 58368 },
+	{ 24033, 59392 },
+	{ 23104, 60416 },
+	{ 22216, 61440 },
+	{ 21367, 62464 },
+	{ 20554, 63488 },
+	{ 19776, 64512 },
+	{ 19031, 65536 },
+	{ 18318, 66560 },
+	{ 17636, 67584 },
+	{ 16982, 68608 },
+	{ 16355, 69632 },
+	{ 15755, 70656 },
+	{ 15180, 71680 },
+	{ 14628, 72704 },
+	{ 14099, 73728 },
+	{ 13592, 74752 },
+	{ 13106, 75776 },
+	{ 12640, 76800 },
+	{ 12192, 77824 },
+	{ 11762, 78848 },
+	{ 11350, 79872 },
+	{ 10954, 80896 },
+	{ 10574, 81920 },
+	{ 10209, 82944 },
+	{ 9858, 83968 },
+	{ 9521, 84992 },
+	{ 9197, 86016 },
+	{ 8886, 87040 },
+	{ 8587, 88064 },
+	{ 8299, 89088 },
+	{ 8023, 90112 },
+	{ 7757, 91136 },
+	{ 7501, 92160 },
+	{ 7254, 93184 },
+	{ 7017, 94208 },
+	{ 6789, 95232 },
+	{ 6570, 96256 },
+	{ 6358, 97280 },
+	{ 6155, 98304 },
+	{ 5959, 99328 },
+	{ 5770, 100352 },
+	{ 5588, 101376 },
+	{ 5412, 102400 },
+	{ 5243, 103424 },
+	{ 5080, 104448 },
+	{ 4923, 105472 },
+	{ 4771, 106496 },
+	{ 4625, 107520 },
+	{ 4484, 108544 },
+	{ 4348, 109568 },
+	{ 4217, 110592 },
+	{ 4090, 111616 },
+	{ 3968, 112640 },
+	{ 3850, 113664 },
+	{ 3736, 114688 },
+	{ 3626, 115712 },
+	{ 3519, 116736 },
+	{ 3417, 117760 },
+	{ 3317, 118784 },
+	{ 3221, 119808 },
+	{ 3129, 120832 },
+	{ 3039, 121856 },
+	{ 2952, 122880 },
+	{ 2868, 123904 },
+	{ 2787, 124928 },
+	{ 2709, 125952 },
+	{ 2633, 126976 },
+	{ 2560, 128000 },
+	{ 2489, 129024 },
+	{ 2420, 130048 }
+};
+
 static int qcom_vadc_scale_hw_calib_volt(
 				const struct vadc_prescale_ratio *prescale,
 				const struct adc5_data *data,
@@ -97,6 +286,10 @@ static int qcom_vadc_scale_hw_calib_therm(
 				const struct vadc_prescale_ratio *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
+static int qcom_vadc7_scale_hw_calib_therm(
+				const struct vadc_prescale_ratio *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec);
 static int qcom_vadc_scale_hw_smb_temp(
 				const struct vadc_prescale_ratio *prescale,
 				const struct adc5_data *data,
@@ -109,12 +302,20 @@ static int qcom_vadc_scale_hw_calib_die_temp(
 				const struct vadc_prescale_ratio *prescale,
 				const struct adc5_data *data,
 				u16 adc_code, int *result_mdec);
+static int qcom_vadc7_scale_hw_calib_die_temp(
+				const struct vadc_prescale_ratio *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec);
 
 static struct qcom_adc5_scale_type scale_adc5_fn[] = {
 	[SCALE_HW_CALIB_DEFAULT] = {qcom_vadc_scale_hw_calib_volt},
 	[SCALE_HW_CALIB_THERM_100K_PULLUP] = {qcom_vadc_scale_hw_calib_therm},
 	[SCALE_HW_CALIB_XOTHERM] = {qcom_vadc_scale_hw_calib_therm},
+	[SCALE_HW_CALIB_THERM_100K_PU_PM7] = {
+					qcom_vadc7_scale_hw_calib_therm},
 	[SCALE_HW_CALIB_PMIC_THERM] = {qcom_vadc_scale_hw_calib_die_temp},
+	[SCALE_HW_CALIB_PMIC_THERM_PM7] = {
+					qcom_vadc7_scale_hw_calib_die_temp},
 	[SCALE_HW_CALIB_PM5_CHG_TEMP] = {qcom_vadc_scale_hw_chg5_temp},
 	[SCALE_HW_CALIB_PM5_SMB_TEMP] = {qcom_vadc_scale_hw_smb_temp},
 };
@@ -291,6 +492,32 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
 	return (int) voltage;
 }
 
+static int qcom_vadc7_scale_hw_calib_therm(
+				const struct vadc_prescale_ratio *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec)
+{
+	s64 resistance = 0;
+	int ret, result = 0;
+
+	if (adc_code >= RATIO_MAX_ADC7)
+		return -EINVAL;
+
+	/* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/
+	resistance = (s64) adc_code * R_PU_100K;
+	resistance = div64_s64(resistance, (RATIO_MAX_ADC7 - adc_code));
+
+	ret = qcom_vadc_map_voltage_temp(adcmap7_100k,
+				 ARRAY_SIZE(adcmap7_100k),
+				 resistance, &result);
+	if (ret)
+		return ret;
+
+	*result_mdec = result;
+
+	return 0;
+}
+
 static int qcom_vadc_scale_hw_calib_volt(
 				const struct vadc_prescale_ratio *prescale,
 				const struct adc5_data *data,
@@ -330,6 +557,39 @@ static int qcom_vadc_scale_hw_calib_die_temp(
 	return 0;
 }
 
+static int qcom_vadc7_scale_hw_calib_die_temp(
+				const struct vadc_prescale_ratio *prescale,
+				const struct adc5_data *data,
+				u16 adc_code, int *result_mdec)
+{
+
+	int voltage, vtemp0, temp, i = 0;
+
+	voltage = qcom_vadc_scale_code_voltage_factor(adc_code,
+				prescale, data, 1);
+
+	while (i < ARRAY_SIZE(adcmap7_die_temp)) {
+		if (adcmap7_die_temp[i].x > voltage)
+			break;
+		i++;
+	}
+
+	if (i == 0) {
+		*result_mdec = DIE_TEMP_ADC7_SCALE_1;
+	} else if (i == ARRAY_SIZE(adcmap7_die_temp)) {
+		*result_mdec = DIE_TEMP_ADC7_MAX;
+	} else {
+		vtemp0 = adcmap7_die_temp[i-1].x;
+		voltage = voltage - vtemp0;
+		temp = div64_s64(voltage * DIE_TEMP_ADC7_SCALE_FACTOR,
+			adcmap7_die_temp[i-1].y);
+		temp += DIE_TEMP_ADC7_SCALE_1 + (DIE_TEMP_ADC7_SCALE_2 * (i-1));
+		*result_mdec = temp;
+	}
+
+	return 0;
+}
+
 static int qcom_vadc_scale_hw_smb_temp(
 				const struct vadc_prescale_ratio *prescale,
 				const struct adc5_data *data,
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index e074902a..5f9e680 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -49,6 +49,14 @@
 #define ADC5_FULL_SCALE_CODE			0x70e4
 #define ADC5_USR_DATA_CHECK			0x8000
 
+#define R_PU_100K			100000
+#define RATIO_MAX_ADC7		0x4000
+
+#define DIE_TEMP_ADC7_SCALE_1				-60000
+#define DIE_TEMP_ADC7_SCALE_2				20000
+#define DIE_TEMP_ADC7_SCALE_FACTOR			1000
+#define DIE_TEMP_ADC7_MAX				160000
+
 /**
  * struct vadc_map_pt - Map the graph representation for ADC channel
  * @x: Represent the ADC digitized code.
@@ -110,8 +118,12 @@ struct vadc_prescale_ratio {
  *	lookup table. The hardware applies offset/slope to adc code.
  * SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
  *	100k pullup. The hardware applies offset/slope to adc code.
+ * SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
+ *	lookup table for PMIC7. The hardware applies offset/slope to adc code.
  * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
  *	The hardware applies offset/slope to adc code.
+ * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
+ *	The hardware applies offset/slope to adc code. This is for PMIC7.
  * SCALE_HW_CALIB_PM5_CHG_TEMP: Returns result in millidegrees for PMIC5
  *	charger temperature.
  * SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for PMIC5
@@ -126,7 +138,9 @@ enum vadc_scale_fn_type {
 	SCALE_HW_CALIB_DEFAULT,
 	SCALE_HW_CALIB_THERM_100K_PULLUP,
 	SCALE_HW_CALIB_XOTHERM,
+	SCALE_HW_CALIB_THERM_100K_PU_PM7,
 	SCALE_HW_CALIB_PMIC_THERM,
+	SCALE_HW_CALIB_PMIC_THERM_PM7,
 	SCALE_HW_CALIB_PM5_CHG_TEMP,
 	SCALE_HW_CALIB_PM5_SMB_TEMP,
 	SCALE_HW_CALIB_INVALID,
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
new file mode 100644
index 0000000..9426f27
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
+
+#ifndef PM8350_SID
+#define PM8350_SID					1
+#endif
+
+/* ADC channels for PM8350_ADC for PMIC7 */
+#define PM8350_ADC7_REF_GND			(PM8350_SID << 8 | 0x0)
+#define PM8350_ADC7_1P25VREF			(PM8350_SID << 8 | 0x01)
+#define PM8350_ADC7_VREF_VADC			(PM8350_SID << 8 | 0x02)
+#define PM8350_ADC7_DIE_TEMP			(PM8350_SID << 8 | 0x03)
+
+#define PM8350_ADC7_AMUX_THM1			(PM8350_SID << 8 | 0x04)
+#define PM8350_ADC7_AMUX_THM2			(PM8350_SID << 8 | 0x05)
+#define PM8350_ADC7_AMUX_THM3			(PM8350_SID << 8 | 0x06)
+#define PM8350_ADC7_AMUX_THM4			(PM8350_SID << 8 | 0x07)
+#define PM8350_ADC7_AMUX_THM5			(PM8350_SID << 8 | 0x08)
+#define PM8350_ADC7_GPIO1			(PM8350_SID << 8 | 0x0a)
+#define PM8350_ADC7_GPIO2			(PM8350_SID << 8 | 0x0b)
+#define PM8350_ADC7_GPIO3			(PM8350_SID << 8 | 0x0c)
+#define PM8350_ADC7_GPIO4			(PM8350_SID << 8 | 0x0d)
+
+/* 30k pull-up1 */
+#define PM8350_ADC7_AMUX_THM1_30K_PU		(PM8350_SID << 8 | 0x24)
+#define PM8350_ADC7_AMUX_THM2_30K_PU		(PM8350_SID << 8 | 0x25)
+#define PM8350_ADC7_AMUX_THM3_30K_PU		(PM8350_SID << 8 | 0x26)
+#define PM8350_ADC7_AMUX_THM4_30K_PU		(PM8350_SID << 8 | 0x27)
+#define PM8350_ADC7_AMUX_THM5_30K_PU		(PM8350_SID << 8 | 0x28)
+#define PM8350_ADC7_GPIO1_30K_PU		(PM8350_SID << 8 | 0x2a)
+#define PM8350_ADC7_GPIO2_30K_PU		(PM8350_SID << 8 | 0x2b)
+#define PM8350_ADC7_GPIO3_30K_PU		(PM8350_SID << 8 | 0x2c)
+#define PM8350_ADC7_GPIO4_30K_PU		(PM8350_SID << 8 | 0x2d)
+
+/* 100k pull-up2 */
+#define PM8350_ADC7_AMUX_THM1_100K_PU		(PM8350_SID << 8 | 0x44)
+#define PM8350_ADC7_AMUX_THM2_100K_PU		(PM8350_SID << 8 | 0x45)
+#define PM8350_ADC7_AMUX_THM3_100K_PU		(PM8350_SID << 8 | 0x46)
+#define PM8350_ADC7_AMUX_THM4_100K_PU		(PM8350_SID << 8 | 0x47)
+#define PM8350_ADC7_AMUX_THM5_100K_PU		(PM8350_SID << 8 | 0x48)
+#define PM8350_ADC7_GPIO1_100K_PU		(PM8350_SID << 8 | 0x4a)
+#define PM8350_ADC7_GPIO2_100K_PU		(PM8350_SID << 8 | 0x4b)
+#define PM8350_ADC7_GPIO3_100K_PU		(PM8350_SID << 8 | 0x4c)
+#define PM8350_ADC7_GPIO4_100K_PU		(PM8350_SID << 8 | 0x4d)
+
+/* 400k pull-up3 */
+#define PM8350_ADC7_AMUX_THM1_400K_PU		(PM8350_SID << 8 | 0x64)
+#define PM8350_ADC7_AMUX_THM2_400K_PU		(PM8350_SID << 8 | 0x65)
+#define PM8350_ADC7_AMUX_THM3_400K_PU		(PM8350_SID << 8 | 0x66)
+#define PM8350_ADC7_AMUX_THM4_400K_PU		(PM8350_SID << 8 | 0x67)
+#define PM8350_ADC7_AMUX_THM5_400K_PU		(PM8350_SID << 8 | 0x68)
+#define PM8350_ADC7_GPIO1_400K_PU		(PM8350_SID << 8 | 0x6a)
+#define PM8350_ADC7_GPIO2_400K_PU		(PM8350_SID << 8 | 0x6b)
+#define PM8350_ADC7_GPIO3_400K_PU		(PM8350_SID << 8 | 0x6c)
+#define PM8350_ADC7_GPIO4_400K_PU		(PM8350_SID << 8 | 0x6d)
+
+/* 1/3 Divider */
+#define PM8350_ADC7_GPIO4_DIV3			(PM8350_SID << 8 | 0x8d)
+
+#define PM8350_ADC7_VPH_PWR			(PM8350_SID << 8 | 0x8e)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
new file mode 100644
index 0000000..dc2497c
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H
+
+#ifndef PM8350B_SID
+#define PM8350B_SID					3
+#endif
+
+/* ADC channels for PM8350B_ADC for PMIC7 */
+#define PM8350B_ADC7_REF_GND			(PM8350B_SID << 8 | 0x0)
+#define PM8350B_ADC7_1P25VREF			(PM8350B_SID << 8 | 0x01)
+#define PM8350B_ADC7_VREF_VADC			(PM8350B_SID << 8 | 0x02)
+#define PM8350B_ADC7_DIE_TEMP			(PM8350B_SID << 8 | 0x03)
+
+#define PM8350B_ADC7_AMUX_THM1			(PM8350B_SID << 8 | 0x04)
+#define PM8350B_ADC7_AMUX_THM2			(PM8350B_SID << 8 | 0x05)
+#define PM8350B_ADC7_AMUX_THM3			(PM8350B_SID << 8 | 0x06)
+#define PM8350B_ADC7_AMUX_THM4			(PM8350B_SID << 8 | 0x07)
+#define PM8350B_ADC7_AMUX_THM5			(PM8350B_SID << 8 | 0x08)
+#define PM8350B_ADC7_AMUX_THM6			(PM8350B_SID << 8 | 0x09)
+#define PM8350B_ADC7_GPIO1			(PM8350B_SID << 8 | 0x0a)
+#define PM8350B_ADC7_GPIO2			(PM8350B_SID << 8 | 0x0b)
+#define PM8350B_ADC7_GPIO3			(PM8350B_SID << 8 | 0x0c)
+#define PM8350B_ADC7_GPIO4			(PM8350B_SID << 8 | 0x0d)
+
+#define PM8350B_ADC7_CHG_TEMP			(PM8350B_SID << 8 | 0x10)
+#define PM8350B_ADC7_USB_IN_V_16		(PM8350B_SID << 8 | 0x11)
+#define PM8350B_ADC7_VDC_16			(PM8350B_SID << 8 | 0x12)
+#define PM8350B_ADC7_CC1_ID			(PM8350B_SID << 8 | 0x13)
+#define PM8350B_ADC7_VREF_BAT_THERM		(PM8350B_SID << 8 | 0x15)
+#define PM8350B_ADC7_IIN_FB			(PM8350B_SID << 8 | 0x17)
+
+/* 30k pull-up1 */
+#define PM8350B_ADC7_AMUX_THM1_30K_PU		(PM8350B_SID << 8 | 0x24)
+#define PM8350B_ADC7_AMUX_THM2_30K_PU		(PM8350B_SID << 8 | 0x25)
+#define PM8350B_ADC7_AMUX_THM3_30K_PU		(PM8350B_SID << 8 | 0x26)
+#define PM8350B_ADC7_AMUX_THM4_30K_PU		(PM8350B_SID << 8 | 0x27)
+#define PM8350B_ADC7_AMUX_THM5_30K_PU		(PM8350B_SID << 8 | 0x28)
+#define PM8350B_ADC7_AMUX_THM6_30K_PU		(PM8350B_SID << 8 | 0x29)
+#define PM8350B_ADC7_GPIO1_30K_PU		(PM8350B_SID << 8 | 0x2a)
+#define PM8350B_ADC7_GPIO2_30K_PU		(PM8350B_SID << 8 | 0x2b)
+#define PM8350B_ADC7_GPIO3_30K_PU		(PM8350B_SID << 8 | 0x2c)
+#define PM8350B_ADC7_GPIO4_30K_PU		(PM8350B_SID << 8 | 0x2d)
+#define PM8350B_ADC7_CC1_ID_30K_PU		(PM8350B_SID << 8 | 0x33)
+
+/* 100k pull-up2 */
+#define PM8350B_ADC7_AMUX_THM1_100K_PU		(PM8350B_SID << 8 | 0x44)
+#define PM8350B_ADC7_AMUX_THM2_100K_PU		(PM8350B_SID << 8 | 0x45)
+#define PM8350B_ADC7_AMUX_THM3_100K_PU		(PM8350B_SID << 8 | 0x46)
+#define PM8350B_ADC7_AMUX_THM4_100K_PU		(PM8350B_SID << 8 | 0x47)
+#define PM8350B_ADC7_AMUX_THM5_100K_PU		(PM8350B_SID << 8 | 0x48)
+#define PM8350B_ADC7_AMUX_THM6_100K_PU		(PM8350B_SID << 8 | 0x49)
+#define PM8350B_ADC7_GPIO1_100K_PU		(PM8350B_SID << 8 | 0x4a)
+#define PM8350B_ADC7_GPIO2_100K_PU		(PM8350B_SID << 8 | 0x4b)
+#define PM8350B_ADC7_GPIO3_100K_PU		(PM8350B_SID << 8 | 0x4c)
+#define PM8350B_ADC7_GPIO4_100K_PU		(PM8350B_SID << 8 | 0x4d)
+#define PM8350B_ADC7_CC1_ID_100K_PU		(PM8350B_SID << 8 | 0x53)
+
+/* 400k pull-up3 */
+#define PM8350B_ADC7_AMUX_THM1_400K_PU		(PM8350B_SID << 8 | 0x64)
+#define PM8350B_ADC7_AMUX_THM2_400K_PU		(PM8350B_SID << 8 | 0x65)
+#define PM8350B_ADC7_AMUX_THM3_400K_PU		(PM8350B_SID << 8 | 0x66)
+#define PM8350B_ADC7_AMUX_THM4_400K_PU		(PM8350B_SID << 8 | 0x67)
+#define PM8350B_ADC7_AMUX_THM5_400K_PU		(PM8350B_SID << 8 | 0x68)
+#define PM8350B_ADC7_AMUX_THM6_400K_PU		(PM8350B_SID << 8 | 0x69)
+#define PM8350B_ADC7_GPIO1_400K_PU		(PM8350B_SID << 8 | 0x6a)
+#define PM8350B_ADC7_GPIO2_400K_PU		(PM8350B_SID << 8 | 0x6b)
+#define PM8350B_ADC7_GPIO3_400K_PU		(PM8350B_SID << 8 | 0x6c)
+#define PM8350B_ADC7_GPIO4_400K_PU		(PM8350B_SID << 8 | 0x6d)
+#define PM8350B_ADC7_CC1_ID_400K_PU		(PM8350B_SID << 8 | 0x73)
+
+/* 1/3 Divider */
+#define PM8350B_ADC7_GPIO1_DIV3			(PM8350B_SID << 8 | 0x8a)
+#define PM8350B_ADC7_GPIO2_DIV3			(PM8350B_SID << 8 | 0x8b)
+#define PM8350B_ADC7_GPIO3_DIV3			(PM8350B_SID << 8 | 0x8c)
+#define PM8350B_ADC7_GPIO4_DIV3			(PM8350B_SID << 8 | 0x8d)
+
+#define PM8350B_ADC7_VPH_PWR			(PM8350B_SID << 8 | 0x8e)
+#define PM8350B_ADC7_VBAT_SNS			(PM8350B_SID << 8 | 0x8f)
+
+#define PM8350B_ADC7_SBUx			(PM8350B_SID << 8 | 0x94)
+#define PM8350B_ADC7_VBAT_2S_MID		(PM8350B_SID << 8 | 0x96)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8350B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
new file mode 100644
index 0000000..6c29687
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
+
+#ifndef PMK8350_SID
+#define PMK8350_SID					0
+#endif
+
+/* ADC channels for PMK8350_ADC for PMIC7 */
+#define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | 0x0)
+#define PMK8350_ADC7_1P25VREF			(PMK8350_SID << 8 | 0x01)
+#define PMK8350_ADC7_VREF_VADC			(PMK8350_SID << 8 | 0x02)
+#define PMK8350_ADC7_DIE_TEMP			(PMK8350_SID << 8 | 0x03)
+
+#define PMK8350_ADC7_AMUX_THM1			(PMK8350_SID << 8 | 0x04)
+#define PMK8350_ADC7_AMUX_THM2			(PMK8350_SID << 8 | 0x05)
+#define PMK8350_ADC7_AMUX_THM3			(PMK8350_SID << 8 | 0x06)
+#define PMK8350_ADC7_AMUX_THM4			(PMK8350_SID << 8 | 0x07)
+#define PMK8350_ADC7_AMUX_THM5			(PMK8350_SID << 8 | 0x08)
+
+/* 30k pull-up1 */
+#define PMK8350_ADC7_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | 0x24)
+#define PMK8350_ADC7_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | 0x25)
+#define PMK8350_ADC7_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | 0x26)
+#define PMK8350_ADC7_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | 0x27)
+#define PMK8350_ADC7_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | 0x28)
+
+/* 100k pull-up2 */
+#define PMK8350_ADC7_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | 0x44)
+#define PMK8350_ADC7_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | 0x45)
+#define PMK8350_ADC7_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | 0x46)
+#define PMK8350_ADC7_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | 0x47)
+#define PMK8350_ADC7_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | 0x48)
+
+/* 400k pull-up3 */
+#define PMK8350_ADC7_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | 0x64)
+#define PMK8350_ADC7_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | 0x65)
+#define PMK8350_ADC7_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | 0x66)
+#define PMK8350_ADC7_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | 0x67)
+#define PMK8350_ADC7_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | 0x68)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
new file mode 100644
index 0000000..d6df1b1
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H
+
+#ifndef PMR735A_SID
+#define PMR735A_SID					4
+#endif
+
+/* ADC channels for PMR735A_ADC for PMIC7 */
+#define PMR735A_ADC7_REF_GND			(PMR735A_SID << 8 | 0x0)
+#define PMR735A_ADC7_1P25VREF			(PMR735A_SID << 8 | 0x01)
+#define PMR735A_ADC7_VREF_VADC			(PMR735A_SID << 8 | 0x02)
+#define PMR735A_ADC7_DIE_TEMP			(PMR735A_SID << 8 | 0x03)
+
+#define PMR735A_ADC7_GPIO1			(PMR735A_SID << 8 | 0x0a)
+#define PMR735A_ADC7_GPIO2			(PMR735A_SID << 8 | 0x0b)
+#define PMR735A_ADC7_GPIO3			(PMR735A_SID << 8 | 0x0c)
+
+/* 100k pull-up2 */
+#define PMR735A_ADC7_GPIO1_100K_PU		(PMR735A_SID << 8 | 0x4a)
+#define PMR735A_ADC7_GPIO2_100K_PU		(PMR735A_SID << 8 | 0x4b)
+#define PMR735A_ADC7_GPIO3_100K_PU		(PMR735A_SID << 8 | 0x4c)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735A_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
new file mode 100644
index 0000000..8da0e7d
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
+
+#ifndef PMR735B_SID
+#define PMR735B_SID					5
+#endif
+
+/* ADC channels for PMR735B_ADC for PMIC7 */
+#define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | 0x0)
+#define PMR735B_ADC7_1P25VREF			(PMR735B_SID << 8 | 0x01)
+#define PMR735B_ADC7_VREF_VADC			(PMR735B_SID << 8 | 0x02)
+#define PMR735B_ADC7_DIE_TEMP			(PMR735B_SID << 8 | 0x03)
+
+#define PMR735B_ADC7_GPIO1			(PMR735B_SID << 8 | 0x0a)
+#define PMR735B_ADC7_GPIO2			(PMR735B_SID << 8 | 0x0b)
+#define PMR735B_ADC7_GPIO3			(PMR735B_SID << 8 | 0x0c)
+
+/* 100k pull-up2 */
+#define PMR735B_ADC7_GPIO1_100K_PU		(PMR735B_SID << 8 | 0x4a)
+#define PMR735B_ADC7_GPIO2_100K_PU		(PMR735B_SID << 8 | 0x4b)
+#define PMR735B_ADC7_GPIO3_100K_PU		(PMR735B_SID << 8 | 0x4c)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
index 61d556d..08adfe2 100644
--- a/include/dt-bindings/iio/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (c) 2012-2014,2018 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
@@ -221,4 +221,80 @@
 
 #define ADC5_MAX_CHANNEL			0xc0
 
+/* ADC channels for ADC for PMIC7 */
+
+#define ADC7_REF_GND				0x00
+#define ADC7_1P25VREF				0x01
+#define ADC7_VREF_VADC				0x02
+#define ADC7_DIE_TEMP				0x03
+
+#define ADC7_AMUX_THM1				0x04
+#define ADC7_AMUX_THM2				0x05
+#define ADC7_AMUX_THM3				0x06
+#define ADC7_AMUX_THM4				0x07
+#define ADC7_AMUX_THM5				0x08
+#define ADC7_AMUX_THM6				0x09
+#define ADC7_GPIO1				0x0a
+#define ADC7_GPIO2				0x0b
+#define ADC7_GPIO3				0x0c
+#define ADC7_GPIO4				0x0d
+
+#define ADC7_CHG_TEMP				0x10
+#define ADC7_USB_IN_V_16			0x11
+#define ADC7_VDC_16				0x12
+#define ADC7_CC1_ID				0x13
+#define ADC7_VREF_BAT_THERM			0x15
+#define ADC7_IIN_FB				0x17
+
+/* 30k pull-up1 */
+#define ADC7_AMUX_THM1_30K_PU			0x24
+#define ADC7_AMUX_THM2_30K_PU			0x25
+#define ADC7_AMUX_THM3_30K_PU			0x26
+#define ADC7_AMUX_THM4_30K_PU			0x27
+#define ADC7_AMUX_THM5_30K_PU			0x28
+#define ADC7_AMUX_THM6_30K_PU			0x29
+#define ADC7_GPIO1_30K_PU			0x2a
+#define ADC7_GPIO2_30K_PU			0x2b
+#define ADC7_GPIO3_30K_PU			0x2c
+#define ADC7_GPIO4_30K_PU			0x2d
+#define ADC7_CC1_ID_30K_PU			0x33
+
+/* 100k pull-up2 */
+#define ADC7_AMUX_THM1_100K_PU			0x44
+#define ADC7_AMUX_THM2_100K_PU			0x45
+#define ADC7_AMUX_THM3_100K_PU			0x46
+#define ADC7_AMUX_THM4_100K_PU			0x47
+#define ADC7_AMUX_THM5_100K_PU			0x48
+#define ADC7_AMUX_THM6_100K_PU			0x49
+#define ADC7_GPIO1_100K_PU			0x4a
+#define ADC7_GPIO2_100K_PU			0x4b
+#define ADC7_GPIO3_100K_PU			0x4c
+#define ADC7_GPIO4_100K_PU			0x4d
+#define ADC7_CC1_ID_100K_PU			0x53
+
+/* 400k pull-up3 */
+#define ADC7_AMUX_THM1_400K_PU			0x64
+#define ADC7_AMUX_THM2_400K_PU			0x65
+#define ADC7_AMUX_THM3_400K_PU			0x66
+#define ADC7_AMUX_THM4_400K_PU			0x67
+#define ADC7_AMUX_THM5_400K_PU			0x68
+#define ADC7_AMUX_THM6_400K_PU			0x69
+#define ADC7_GPIO1_400K_PU			0x6a
+#define ADC7_GPIO2_400K_PU			0x6b
+#define ADC7_GPIO3_400K_PU			0x6c
+#define ADC7_GPIO4_400K_PU			0x6d
+#define ADC7_CC1_ID_400K_PU			0x73
+
+/* 1/3 Divider */
+#define ADC7_GPIO1_DIV3				0x8a
+#define ADC7_GPIO2_DIV3				0x8b
+#define ADC7_GPIO3_DIV3				0x8c
+#define ADC7_GPIO4_DIV3				0x8d
+
+#define ADC7_VPH_PWR				0x8e
+#define ADC7_VBAT_SNS				0x8f
+
+#define ADC7_SBUx				0x94
+#define ADC7_VBAT_2S_MID			0x96
+
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
