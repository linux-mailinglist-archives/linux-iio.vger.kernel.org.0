Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CDB288D0F
	for <lists+linux-iio@lfdr.de>; Fri,  9 Oct 2020 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbgJIPpP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Oct 2020 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389396AbgJIPpO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Oct 2020 11:45:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11DCC0613D2
        for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2020 08:45:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id p15so10054261ljj.8
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2020 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBF3uLUf/ZUhgh6mGdQvvNaF8GSfsySai+h7lBFUhRU=;
        b=XL2vdeWgEVe94RGhiYbFDW/ClKymnBKiFPGYOUzuBKpryBUCzgF36zed+Gr6PwqCKT
         F8GUMm39Krdbm/f/xZ9O6SVNbxlol+Pal9xm61+gTFypOJN/tSEZ0UOmN4t7OlswW7RO
         yeWs5blxicvGf5JQ+iF97HuUnElk2EsvDPQpmoHniVtOW4UcPHtSHUiug0b8wG4mWHKZ
         EQgPWpqRBfLd6efFQbYrsl7kILPNp5XM0yQmvnO0h0N3CKVX0jHyWZzn4+F4OVwwQfyb
         fq1uunlh+tQQAGlxxILJVYyY+PobE8UqXprhDEiItY1/Zaq3QaQmnluoXuUyGqniGeMY
         Kf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBF3uLUf/ZUhgh6mGdQvvNaF8GSfsySai+h7lBFUhRU=;
        b=B1ksDTOKRr1mzuvnjWgKurbVlxCkKq2vUAHOfbcVUEOaZ8hlUmxBQj/MA9NDzOXA2K
         LmV+OcsoxTNuYZANEFxTVAo3DdQO9r77o/Wud/8SHiC1hKJvy+x+oJ+VN0S0BkcApAj1
         bpfEG8rcQ6r6CQe5+1vkEuYUa9B7ki/nVAzVsNmPvb6foToha7qhbvhEjVuy+riEncuu
         pSsswVaLM2RrIeH/eMWlvdxBRvoS19gCeRP24Ux9qAUawf+kyeGveEJ2C94bN436TFam
         Y5lygGdxlNa2wn9G8c+nhHGyXxp4uyTwLnjwlY+UaNx15gm5SzX1sBLIrnZMCnUsvOvn
         zWbw==
X-Gm-Message-State: AOAM532NVCCy/j5ngbrJckQ70JChaOkszG9zr4nT+pG0H6pYAl/F9RpP
        wfPNa1fUw1F80QKbF0OMqc5OCQ==
X-Google-Smtp-Source: ABdhPJyJMWeonPuKWJGmws0xoWX0CZRCHIogY7XtVeD69hFBZK4q/IXkF0qff35OA6jbCBUqdsg0+Q==
X-Received: by 2002:a2e:8e86:: with SMTP id z6mr1674964ljk.190.1602258312392;
        Fri, 09 Oct 2020 08:45:12 -0700 (PDT)
Received: from eriador.lan ([188.162.65.231])
        by smtp.gmail.com with ESMTPSA id r4sm1505597lfc.162.2020.10.09.08.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:45:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 03/11] iio: adc: qcom-vadc: move several adc5 functions to common file
Date:   Fri,  9 Oct 2020 18:44:51 +0300
Message-Id: <20201009154459.106189-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
References: <20201009154459.106189-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADC-TM5 driver will make use of several functions from ADC5 driver. Move
them to qcom-vadc-common driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c   | 75 +++---------------------------
 drivers/iio/adc/qcom-vadc-common.c | 68 ++++++++++++++++++++++++++-
 drivers/iio/adc/qcom-vadc-common.h | 10 +++-
 3 files changed, 82 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index c10aa28be70a..c2da8f068b87 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -154,18 +154,6 @@ struct adc5_chip {
 	const struct adc5_data	*data;
 };
 
-static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
-	{.num =  1, .den =  1},
-	{.num =  1, .den =  3},
-	{.num =  1, .den =  4},
-	{.num =  1, .den =  6},
-	{.num =  1, .den = 20},
-	{.num =  1, .den =  8},
-	{.num = 10, .den = 81},
-	{.num =  1, .den = 10},
-	{.num =  1, .den = 16}
-};
-
 static int adc5_read(struct adc5_chip *adc, u16 offset, u8 *data, int len)
 {
 	return regmap_bulk_read(adc->regmap, adc->base + offset, data, len);
@@ -181,55 +169,6 @@ static int adc5_masked_write(struct adc5_chip *adc, u16 offset, u8 mask, u8 val)
 	return regmap_update_bits(adc->regmap, adc->base + offset, mask, val);
 }
 
-static int adc5_prescaling_from_dt(u32 num, u32 den)
-{
-	unsigned int pre;
-
-	for (pre = 0; pre < ARRAY_SIZE(adc5_prescale_ratios); pre++)
-		if (adc5_prescale_ratios[pre].num == num &&
-		    adc5_prescale_ratios[pre].den == den)
-			break;
-
-	if (pre == ARRAY_SIZE(adc5_prescale_ratios))
-		return -EINVAL;
-
-	return pre;
-}
-
-static int adc5_hw_settle_time_from_dt(u32 value,
-					const unsigned int *hw_settle)
-{
-	unsigned int i;
-
-	for (i = 0; i < VADC_HW_SETTLE_SAMPLES_MAX; i++) {
-		if (value == hw_settle[i])
-			return i;
-	}
-
-	return -EINVAL;
-}
-
-static int adc5_avg_samples_from_dt(u32 value)
-{
-	if (!is_power_of_2(value) || value > ADC5_AVG_SAMPLES_MAX)
-		return -EINVAL;
-
-	return __ffs(value);
-}
-
-static int adc5_decimation_from_dt(u32 value,
-					const unsigned int *decimation)
-{
-	unsigned int i;
-
-	for (i = 0; i < ADC5_DECIMATION_SAMPLES_MAX; i++) {
-		if (value == decimation[i])
-			return i;
-	}
-
-	return -EINVAL;
-}
-
 static int adc5_read_voltage_data(struct adc5_chip *adc, u16 *data)
 {
 	int ret;
@@ -511,7 +450,7 @@ static int adc_read_raw_common(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
-			&adc5_prescale_ratios[prop->prescale],
+			prop->prescale,
 			adc->data,
 			adc_code_volt, val);
 		if (ret)
@@ -717,7 +656,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	ret = of_property_read_u32(node, "qcom,decimation", &value);
 	if (!ret) {
-		ret = adc5_decimation_from_dt(value, data->decimation);
+		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid decimation %d\n",
 				chan, value);
@@ -730,7 +669,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
 	if (!ret) {
-		ret = adc5_prescaling_from_dt(varr[0], varr[1]);
+		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid pre-scaling <%d %d>\n",
 				chan, varr[0], varr[1]);
@@ -759,11 +698,9 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
 			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR) ||
 			adc->data->info == &adc7_info)
-			ret = adc5_hw_settle_time_from_dt(value,
-							data->hw_settle_2);
+			ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_2);
 		else
-			ret = adc5_hw_settle_time_from_dt(value,
-							data->hw_settle_1);
+			ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_1);
 
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid hw-settle-time %d us\n",
@@ -777,7 +714,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
 	if (!ret) {
-		ret = adc5_avg_samples_from_dt(value);
+		ret = qcom_adc5_avg_samples_from_dt(value);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid avg-samples %d\n",
 				chan, value);
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 5113aaa6ba67..d11f3343ad52 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -278,6 +278,18 @@ static const struct vadc_map_pt adcmap7_100k[] = {
 	{ 2420, 130048 }
 };
 
+static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
+	{.num =  1, .den =  1},
+	{.num =  1, .den =  3},
+	{.num =  1, .den =  4},
+	{.num =  1, .den =  6},
+	{.num =  1, .den = 20},
+	{.num =  1, .den =  8},
+	{.num = 10, .den = 81},
+	{.num =  1, .den = 10},
+	{.num =  1, .den = 16}
+};
+
 static int qcom_vadc_scale_hw_calib_volt(
 				const struct vadc_prescale_ratio *prescale,
 				const struct adc5_data *data,
@@ -647,10 +659,12 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
 EXPORT_SYMBOL(qcom_vadc_scale);
 
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
-		    const struct vadc_prescale_ratio *prescale,
+		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
 		    u16 adc_code, int *result)
 {
+	const struct vadc_prescale_ratio *prescale = &adc5_prescale_ratios[prescale_ratio];
+
 	if (!(scaletype >= SCALE_HW_CALIB_DEFAULT &&
 		scaletype < SCALE_HW_CALIB_INVALID)) {
 		pr_err("Invalid scale type %d\n", scaletype);
@@ -662,6 +676,58 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 }
 EXPORT_SYMBOL(qcom_adc5_hw_scale);
 
+int qcom_adc5_prescaling_from_dt(u32 num, u32 den)
+{
+	unsigned int pre;
+
+	for (pre = 0; pre < ARRAY_SIZE(adc5_prescale_ratios); pre++)
+		if (adc5_prescale_ratios[pre].num == num &&
+		    adc5_prescale_ratios[pre].den == den)
+			break;
+
+	if (pre == ARRAY_SIZE(adc5_prescale_ratios))
+		return -EINVAL;
+
+	return pre;
+}
+EXPORT_SYMBOL(qcom_adc5_prescaling_from_dt);
+
+int qcom_adc5_hw_settle_time_from_dt(u32 value,
+				     const unsigned int *hw_settle)
+{
+	unsigned int i;
+
+	for (i = 0; i < VADC_HW_SETTLE_SAMPLES_MAX; i++) {
+		if (value == hw_settle[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(qcom_adc5_hw_settle_time_from_dt);
+
+int qcom_adc5_avg_samples_from_dt(u32 value)
+{
+	if (!is_power_of_2(value) || value > ADC5_AVG_SAMPLES_MAX)
+		return -EINVAL;
+
+	return __ffs(value);
+}
+EXPORT_SYMBOL(qcom_adc5_avg_samples_from_dt);
+
+int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
+{
+	unsigned int i;
+
+	for (i = 0; i < ADC5_DECIMATION_SAMPLES_MAX; i++) {
+		if (value == decimation[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(qcom_adc5_decimation_from_dt);
+
 int qcom_vadc_decimation_from_dt(u32 value)
 {
 	if (!is_power_of_2(value) || value < VADC_DECIMATION_MIN ||
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index 17b2fc4d8bf2..7e5f6428e311 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -168,10 +168,18 @@ struct qcom_adc5_scale_type {
 };
 
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
-		    const struct vadc_prescale_ratio *prescale,
+		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
 		    u16 adc_code, int *result_mdec);
 
+int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
+
+int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
+
+int qcom_adc5_avg_samples_from_dt(u32 value);
+
+int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation);
+
 int qcom_vadc_decimation_from_dt(u32 value);
 
 #endif /* QCOM_VADC_COMMON_H */
-- 
2.28.0

