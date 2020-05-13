Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674071D0BFF
	for <lists+linux-iio@lfdr.de>; Wed, 13 May 2020 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbgEMJYA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 May 2020 05:24:00 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:41865 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732448AbgEMJX7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2020 05:23:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589361839; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WUEX6bVcZh9oe8T3NGf1t4ZNiXNzwxOiupI1edWKU+Q=; b=LtnkiQlRV20xg88/lbTdVjVKDFWFXWwN//3MO6uqD2Q/hwW80iCfOFNN5adD0A9/YxtwhJ59
 skcWgg5cUzUcf/o642Z66GsNHlguvvB/NXXmsH62cRUBfqbtkqwPFrGUP1qVFUlRXZN9HJw0
 AazjF1xAwIIglalYZKtgqs5RqWM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebbbcae.7fa2b5f26d50-smtp-out-n05;
 Wed, 13 May 2020 09:23:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77FABC44795; Wed, 13 May 2020 09:23:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 789FDC433BA;
        Wed, 13 May 2020 09:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 789FDC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
From:   Jishnu Prakash <jprakash@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, andy.shevchenko@gmail.com,
        amit.kucheria@verdurent.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org,
        Jishnu Prakash <jprakash@codeaurora.org>
Subject: [PATCH V4 5/5] iio: adc: Clean up ADC code common to PMIC5 and PMIC7
Date:   Wed, 13 May 2020 14:52:16 +0530
Message-Id: <1589361736-816-6-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589361736-816-1-git-send-email-jprakash@codeaurora.org>
References: <1589361736-816-1-git-send-email-jprakash@codeaurora.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit includes the following changes:
Add a common function used for read_raw callback for
both PMIC5 and PMIC7 ADCs.
Add exit function for ADC.
Add info_property under adc_data to more efficiently
distinguish PMIC5 and PMIC7 ADCs.

Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c   | 83 +++++++++++++++++++++-----------------
 drivers/iio/adc/qcom-vadc-common.h |  1 +
 2 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 974073f..fbe7a39 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -167,8 +167,6 @@ static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
 	{.num =  1, .den = 16}
 };
 
-static const struct adc5_data adc7_data_pmic;
-
 static int adc5_read(struct adc5_chip *adc, u16 offset, u8 *data, int len)
 {
 	return regmap_bulk_read(adc->regmap, adc->base + offset, data, len);
@@ -452,6 +450,13 @@ static int adc7_do_conversion(struct adc5_chip *adc,
 	return ret;
 }
 
+struct adc_do_conversion {
+	int (*adc_do_conversion)(struct adc5_chip *adc,
+			struct adc5_channel_prop *prop,
+			struct iio_chan_spec const *chan,
+			u16 *data_volt, u16 *data_cur);
+};
+
 static irqreturn_t adc5_isr(int irq, void *dev_id)
 {
 	struct adc5_chip *adc = dev_id;
@@ -490,9 +495,9 @@ static int adc7_of_xlate(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int adc5_read_raw(struct iio_dev *indio_dev,
+static int adc_read_raw_common(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
-			 long mask)
+			 long mask, struct adc_do_conversion do_conv)
 {
 	struct adc5_chip *adc = iio_priv(indio_dev);
 	struct adc5_channel_prop *prop;
@@ -503,8 +508,9 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		ret = adc5_do_conversion(adc, prop, chan,
-				&adc_code_volt, &adc_code_cur);
+		ret = do_conv.adc_do_conversion(adc, prop, chan,
+					&adc_code_volt, &adc_code_cur);
+
 		if (ret)
 			return ret;
 
@@ -512,6 +518,7 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
 			&adc5_prescale_ratios[prop->prescale],
 			adc->data,
 			adc_code_volt, val);
+
 		if (ret)
 			return ret;
 
@@ -523,38 +530,28 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int adc7_read_raw(struct iio_dev *indio_dev,
+static int adc5_read_raw(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask)
 {
-	struct adc5_chip *adc = iio_priv(indio_dev);
-	struct adc5_channel_prop *prop;
-	u16 adc_code_volt, adc_code_cur;
-	int ret;
-
-	prop = &adc->chan_props[chan->address];
+	struct adc_do_conversion do_conv;
 
-	switch (mask) {
-	case IIO_CHAN_INFO_PROCESSED:
-		ret = adc7_do_conversion(adc, prop, chan,
-					&adc_code_volt, &adc_code_cur);
-		if (ret)
-			return ret;
+	do_conv.adc_do_conversion = adc5_do_conversion;
 
-		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
-			&adc5_prescale_ratios[prop->prescale],
-			adc->data,
-			adc_code_volt, val);
+	return adc_read_raw_common(indio_dev, chan, val, val2,
+				mask, do_conv);
+}
 
-		if (ret)
-			return ret;
+static int adc7_read_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan, int *val, int *val2,
+			 long mask)
+{
+	struct adc_do_conversion do_conv;
 
-		return IIO_VAL_INT;
-	default:
-		return -EINVAL;
-	}
+	do_conv.adc_do_conversion = adc7_do_conversion;
 
-	return 0;
+	return adc_read_raw_common(indio_dev, chan, val, val2,
+				mask, do_conv);
 }
 
 static const struct iio_info adc5_info = {
@@ -710,7 +707,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	/* virtual channel number = sid << 8 | channel number */
 
-	if (adc->data == &adc7_data_pmic) {
+	if (adc->data->info == &adc7_info) {
 		sid = chan >> ADC_CHANNEL_OFFSET;
 		chan = chan & ADC_CHANNEL_MASK;
 	}
@@ -776,7 +773,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 		/* Digital controller >= 5.3 have hw_settle_2 option */
 		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
 			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR) ||
-			adc->data == &adc7_data_pmic)
+			adc->data->info == &adc7_info)
 			ret = adc5_hw_settle_time_from_dt(value,
 							data->hw_settle_2);
 		else
@@ -826,6 +823,7 @@ static const struct adc5_data adc5_data_pmic = {
 	.full_scale_code_volt = 0x70e4,
 	.full_scale_code_cur = 0x2710,
 	.adc_chans = adc5_chans_pmic,
+	.info = &adc5_info,
 	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
 				{250, 420, 840},
 	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
@@ -839,6 +837,7 @@ static const struct adc5_data adc5_data_pmic = {
 static const struct adc5_data adc7_data_pmic = {
 	.full_scale_code_volt = 0x70e4,
 	.adc_chans = adc7_chans_pmic,
+	.info = &adc7_info,
 	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
 				{85, 340, 1360},
 	.hw_settle_2 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
@@ -851,6 +850,7 @@ static const struct adc5_data adc5_data_pmic_rev2 = {
 	.full_scale_code_volt = 0x4000,
 	.full_scale_code_cur = 0x1800,
 	.adc_chans = adc5_chans_rev2,
+	.info = &adc5_info,
 	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
 				{256, 512, 1024},
 	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
@@ -965,10 +965,7 @@ static int adc5_probe(struct platform_device *pdev)
 	adc->dev = dev;
 	adc->base = reg;
 
-	if (of_device_is_compatible(node, "qcom,spmi-adc7"))
-		indio_dev->info = &adc7_info;
-	else
-		indio_dev->info = &adc5_info;
+	platform_set_drvdata(pdev, adc);
 
 	init_completion(&adc->complete);
 	mutex_init(&adc->lock);
@@ -979,6 +976,8 @@ static int adc5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	indio_dev->info = adc->data->info;
+
 	irq_eoc = platform_get_irq(pdev, 0);
 	if (irq_eoc < 0) {
 		if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
@@ -991,6 +990,8 @@ static int adc5_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	adc->irq_eoc = irq_eoc;
+
 	indio_dev->dev.parent = dev;
 	indio_dev->dev.of_node = node;
 	indio_dev->name = pdev->name;
@@ -1001,12 +1002,22 @@ static int adc5_probe(struct platform_device *pdev)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static int adc5_exit(struct platform_device *pdev)
+{
+	struct adc5_chip *adc = platform_get_drvdata(pdev);
+
+	if (adc->irq_eoc >= 0)
+		disable_irq(adc->irq_eoc);
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
 
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index 5f9e680..d195e83 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -150,6 +150,7 @@ struct adc5_data {
 	const u32	full_scale_code_volt;
 	const u32	full_scale_code_cur;
 	const struct adc5_channels *adc_chans;
+	const struct iio_info *info;
 	unsigned int	*decimation;
 	unsigned int	*hw_settle_1;
 	unsigned int	*hw_settle_2;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
