Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78071202C61
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 21:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgFUTf7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbgFUTf6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 15:35:58 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF20C061796
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:35:58 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k15so1379737lfc.4
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5oc+8iupKokx1vIwx2BgSUJUDtArVXE3sPkQPErCBew=;
        b=b4CYgCFiAXg7oskXiicQUC77JqVVOFahqrL4MZK0ld3d0r86P+SmnYaya89sTWb62v
         gFbP7sTeFgcLLMdMfSY7h12cR9+ckeiniuy6+ufeqGztIs9Kew4xbRzC6gk6Hs7s5Xpg
         KQU7xuDA23OSkTmAvTM+qq6HaSnqgdIOuQ9aszZE/ineR3tHeVr5qB6YRPXNhUdorLfF
         EutpqoGIeNqIccy5qBxonT77hoOUEdkJGDV/inYlFZEZiQynihnbQhhda79UocfZyFlk
         xz4AXHAVq7ZuvtYwolp9+3vRZ5J05HQG6UDSc4hwm+t19VCyR9HqYTzMTmUhRxcCV5Qj
         KEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5oc+8iupKokx1vIwx2BgSUJUDtArVXE3sPkQPErCBew=;
        b=L7qUDqRzMHMUQJDTnJSlINHZD3w7XAH2xgQHE3PvT668t1i7RRaw9j7DnnU3w22wsY
         t1XT1SU5SsUcWGph5ZKl0zkTNi4la7u4ogIwz71660Ff8AIhLV6dXAsWfh+QNLdeadoN
         Cnil2zzLTPWeCh/W2TM3IwmGmHiMgv1nm76KoM4bP5H5DG0VVGA88gGKsHSDTje5a2kx
         JM2SFKR8XSDH71qwLKNz3HJZ3dgO22O+lBOZs1Lu/I2RqbmvSluvZtGYVVNs9DIJBhv8
         1IOCCO17Hwnog3SRssxROXdoNrp67SOBCm/+SWFuAkEPLL37yXkfQPM41Ne5OWC1TZMW
         uFuA==
X-Gm-Message-State: AOAM533gbZ02Xj8M+gr72awcwLzDI1QT2476QQiJ/w7bQrDd/JGE632E
        RTKcpD5eqWB9NBfOGkKQKd933g==
X-Google-Smtp-Source: ABdhPJzLm9TRwXrpMuDy8Q6DqcksIMnANVf9Yh3B00QsffrmH97mM3SlbpHT17es10eUfTIgVtBUoQ==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr8018395lfe.154.1592768156464;
        Sun, 21 Jun 2020 12:35:56 -0700 (PDT)
Received: from eriador.lan ([188.162.65.109])
        by smtp.gmail.com with ESMTPSA id r13sm2917854lfp.80.2020.06.21.12.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 12:35:55 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 2/5] iio: adc: qcom-vadc: move several adc5 functions to common file
Date:   Sun, 21 Jun 2020 22:35:46 +0300
Message-Id: <20200621193549.2070434-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
References: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADC-TM5 driver will make use of several functions from ADC5 driver. Move
them to qcom-vadc-common driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c   | 73 +++---------------------------
 drivers/iio/adc/qcom-vadc-common.c | 69 +++++++++++++++++++++++++++-
 drivers/iio/adc/qcom-vadc-common.h | 12 ++++-
 3 files changed, 85 insertions(+), 69 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 21fdcde77883..10ca0bf77160 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -143,18 +143,6 @@ struct adc5_chip {
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
@@ -165,55 +153,6 @@ static int adc5_write(struct adc5_chip *adc, u16 offset, u8 *data, int len)
 	return regmap_bulk_write(adc->regmap, adc->base + offset, data, len);
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
@@ -396,7 +335,7 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
-			&adc5_prescale_ratios[prop->prescale],
+			prop->prescale,
 			adc->data,
 			adc_code_volt, val);
 		if (ret)
@@ -539,7 +478,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	ret = of_property_read_u32(node, "qcom,decimation", &value);
 	if (!ret) {
-		ret = adc5_decimation_from_dt(value, data->decimation);
+		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid decimation %d\n",
 				chan, value);
@@ -552,7 +491,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
 	if (!ret) {
-		ret = adc5_prescaling_from_dt(varr[0], varr[1]);
+		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid pre-scaling <%d %d>\n",
 				chan, varr[0], varr[1]);
@@ -580,10 +519,10 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 		/* Digital controller >= 5.3 have hw_settle_2 option */
 		if (dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
 			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR)
-			ret = adc5_hw_settle_time_from_dt(value,
+			ret = qcom_adc5_hw_settle_time_from_dt(value,
 							data->hw_settle_2);
 		else
-			ret = adc5_hw_settle_time_from_dt(value,
+			ret = qcom_adc5_hw_settle_time_from_dt(value,
 							data->hw_settle_1);
 
 		if (ret < 0) {
@@ -598,7 +537,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 
 	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
 	if (!ret) {
-		ret = adc5_avg_samples_from_dt(value);
+		ret = qcom_adc5_avg_samples_from_dt(value);
 		if (ret < 0) {
 			dev_err(dev, "%02x invalid avg-samples %d\n",
 				chan, value);
diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 2bb78d1c4daa..ffa578ce76db 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -89,6 +89,18 @@ static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] = {
 	{ 46,	125000 },
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
@@ -385,10 +397,12 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
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
@@ -400,6 +414,59 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
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
+int qcom_adc5_decimation_from_dt(u32 value,
+			    const unsigned int *decimation)
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
index e074902a24cc..2c65ddc98696 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -153,10 +153,20 @@ struct qcom_adc5_scale_type {
 };
 
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
-		    const struct vadc_prescale_ratio *prescale,
+		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
 		    u16 adc_code, int *result_mdec);
 
+int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
+
+int qcom_adc5_hw_settle_time_from_dt(u32 value,
+		const unsigned int *hw_settle);
+
+int qcom_adc5_avg_samples_from_dt(u32 value);
+
+int qcom_adc5_decimation_from_dt(u32 value,
+			    const unsigned int *decimation);
+
 int qcom_vadc_decimation_from_dt(u32 value);
 
 #endif /* QCOM_VADC_COMMON_H */
-- 
2.27.0

