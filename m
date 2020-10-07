Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F5A2860AC
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgJGNyz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 09:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgJGNys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 09:54:48 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF847C0613D2
        for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2020 06:54:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a7so1308486lfk.9
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2020 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBF3uLUf/ZUhgh6mGdQvvNaF8GSfsySai+h7lBFUhRU=;
        b=EAHbpqp21p2zdCmvj+TaCxF2mZ0ZZ8JoJrIEaaJqXV2tfjK6MasdDd8KRjgJo8qkjv
         6nH1bg+7QByD7t3TJWdLCrR7X3BVPTJg6clDOb8JDucLP5yEOjZeGiBvjQiQ4QeJ5h2t
         acNBVVZsVCgKt7L3YJ7y/mwcatNtZUowdpmq2i/gsFBtqeRegTwAHiSQUg6dV3t/hviM
         vpR08vXU6pwDymvm0WYCEML4NWnmcU59QF0OLInratMSkRYfQ7HJwpEgrl/7xI6tHR7w
         azgNuhM61jeYouKUhyCJXO4ogbnAbpCuVUev1CAMabjLkJXRHYy6UuzGilkSPVYbZs4N
         pvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBF3uLUf/ZUhgh6mGdQvvNaF8GSfsySai+h7lBFUhRU=;
        b=kpnfJw1PymfdAVuc8EDDeiCrpwtIS0MQ4Q/P4xORGYQI2vKH0ilrYGpmoIO04U51P5
         paRzdljJ8WlAi/pp0qcuuc++Kwd7jSmaHVeolXUZQXL64sfAMgqdYePeyjMsvCpyzKjV
         63RkFEX8Y5Y0kXRG4fVG87gCFMLHw7T7jQlNz63ZDNnU2hePOT36eURLy789K7NF/O/R
         keB5ZCKcYdfe/GLej6bLLAO+fnLbDJLY4eO9jVobNia03u8nZRWsq1kgqG8mPYTusuE6
         JZ40qmVeItDl1gy+6Gemt7xeHno5CWQucx0pZJw2fGQJEkybhnx29PtjrPFH4T5Jy20L
         5Cjw==
X-Gm-Message-State: AOAM531LquwmzOfNQw4OAf2c8h0qS4MWKFH1i8hu97O5TvG8RwVpXu8c
        q/kdZXA1T1UomGi2gMHfKLiMNg==
X-Google-Smtp-Source: ABdhPJwcWXv/H522wjC304Hvzt0UVQvSRu4GAPm0ITvHapZWmolKxQ+aBmWo2CM9JJn8K8RMdNu2/Q==
X-Received: by 2002:ac2:55a5:: with SMTP id y5mr1146402lfg.473.1602078886285;
        Wed, 07 Oct 2020 06:54:46 -0700 (PDT)
Received: from localhost.localdomain ([188.162.65.250])
        by smtp.gmail.com with ESMTPSA id n3sm339768lfq.274.2020.10.07.06.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:54:45 -0700 (PDT)
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
Subject: [PATCH v7 03/10] iio: adc: qcom-vadc: move several adc5 functions to common file
Date:   Wed,  7 Oct 2020 16:54:26 +0300
Message-Id: <20201007135433.1041979-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
References: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
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

