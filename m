Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9162690D5
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 17:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgINP53 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 11:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgINPs1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 11:48:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71336C06121D
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:48:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id q8so13994912lfb.6
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBF3uLUf/ZUhgh6mGdQvvNaF8GSfsySai+h7lBFUhRU=;
        b=MHAcrp1DIu+7X1MMvIqj8iO10ePD6MAHM7QGaKsy1vPSsC8LWVyzstsV20l33Oiks7
         oRYg2yst66/tcD8Ws/E0N07mCSFakO1pFbwSYm0spQE4WHpY8esZf70LfAfq+SYloNoi
         HEsgpgWnqDpPwVn+jDf1jR03xTyKZLypKafCoXFhW+VJDecJLcim1qP02pR+Scm8YQ9H
         If9HlsAIFsOleKBHqoPW6GeDCJcyD9TawhVmM1Zaks5pvDZHM+fZPQiT2nj5293TKL1a
         9QLOmAV124fClgDLuZfBr65eLj0LQ3aXtba+Eyc490dpezgqThZcYpk9Mfofl1etsNdf
         Arjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBF3uLUf/ZUhgh6mGdQvvNaF8GSfsySai+h7lBFUhRU=;
        b=qg3NWPyOlczJA7XExoen6qafobZ1d6bgR/FsLK+PwCIn7ZL0qvPUPUZv6EnuXeGNkl
         s1KjM0B5lZIwVJoKQmCmu17m2MiKCsRyt6zenY7Ftieers6ENOpJO1V54C0s8Mmw6Wpp
         wkozOVEDWkASHJzZ1P5t9kgl/EITyJAFJvAkRk1tEhAizDrIuARy0JGIM4nIbZhWmcZr
         qIKY1OjaLur3XdaowU1TgeNPttqjtvD4VjdUwJ0NjMEWkwfsRNK/teDKQ7ESjX9njVEc
         YYg//6Mwri9t3dFbvlG867mgx6yN7m4e3OUiX9Mh42kfn6VoKR9TIjjA31w0vbS0yrOC
         LLeg==
X-Gm-Message-State: AOAM533igBAu0xQFhP4C30hHlbQAYZ2Xzf/xa4tb5K/I0XyZ/4U8d4pd
        UHHXFu7X+4ug8h0CN+f7m/6QlQ==
X-Google-Smtp-Source: ABdhPJxAHzUNgWPH3beX+XgFIMd5oVeoFoffgonGFzJwEKvQksZwlNQrtF89FCqmfEf4VI9mfumGCQ==
X-Received: by 2002:a19:c7d3:: with SMTP id x202mr5518322lff.66.1600098504836;
        Mon, 14 Sep 2020 08:48:24 -0700 (PDT)
Received: from eriador.lan ([188.162.64.187])
        by smtp.gmail.com with ESMTPSA id f19sm3834650lfs.85.2020.09.14.08.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:48:24 -0700 (PDT)
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 3/9] iio: adc: qcom-vadc: move several adc5 functions to common file
Date:   Mon, 14 Sep 2020 18:48:03 +0300
Message-Id: <20200914154809.192174-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
References: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
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

