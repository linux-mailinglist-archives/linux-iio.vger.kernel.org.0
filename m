Return-Path: <linux-iio+bounces-27733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC50D1D863
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5651E3020E4E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB01138A9B0;
	Wed, 14 Jan 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EjzoeJ8c"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC038A298;
	Wed, 14 Jan 2026 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382883; cv=none; b=KIJw7L9ZP6LEQnNzPmxkfv9GMgDPOuF0N5vXwzAzM7SJBoPINKkVu99nlNNvijg0eTvSq3s4UfsoG20K32WO3FKObYfi2bxJoID5FtaZEBoSEyEGGJQdEa5Dwvvwb29wRc/g36vE+zfJzmAp6whCDsHMKOTf5zkLWv2FTK7WT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382883; c=relaxed/simple;
	bh=5ddrCvPfLkSQsikhTAlB1Jp/3gf1cFDIQVGIgUpCzXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwNkEVdNDESLqY0B8f7zxn4sfLG4Fc+yYeZi9yJCR7oiZWCtKx+odSii+KfHbZTzB5UBSafGw9DIzTBBn+zJmekA0V2BAyecmbVNZt9TjtGgh2x/ax9yp6twXR36stZEwXYwcY+pmORZolj3vFTKWD+l7MkCBQe1gYWYZVs5V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EjzoeJ8c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768382880;
	bh=5ddrCvPfLkSQsikhTAlB1Jp/3gf1cFDIQVGIgUpCzXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjzoeJ8c4fX42W/RpMcY/uhueaTEVdm1LcEUgE6I0O1Cb8m5dhVMgMgQlfTXd01K3
	 Rm285DAe+f73SSsdP/5Vw21dgaofIZYPtcePnrbjGojdxvoMCIejyUX6TJxKtMzTTZ
	 amki+V0puHNOuULvoWsvdUtgGWIzU+w2G2Q6kO0DwWPJmRoPcSYaRT9Mg6ilCrlblc
	 Ux4ezzfcd0rQ6OaX95DNu566fvz3uyeEagW4Hm42iwwqWKb+vLOW7C9B+N8yNMSP7x
	 LoijKyfRPynj9LI6YBTkUthuNafno+lA7zQjt1oimQEqOaetENti+Sj7+l3qVKiGQG
	 5YxKxfk6LN+GQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2CBFF17E1523;
	Wed, 14 Jan 2026 10:27:59 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	sboyd@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v8 10/10] iio: adc: qcom-spmi-iadc: Remove regmap R/W wrapper functions
Date: Wed, 14 Jan 2026 10:27:42 +0100
Message-ID: <20260114092742.13231-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver doesn't need to add any register base address to any
regmap call anymore since it was migrated to register as a SPMI
subdevice with its own regmap reg_base, which makes the regmap
API to automatically add such base address internally.

Since the iadc_{read,write,read_result}() functions now only do
call regmap_{read,write,bulk_read}() and nothing else, simplify
the driver by removing them and by calling regmap APIs directly.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/qcom-spmi-iadc.c | 83 ++++++++++++--------------------
 1 file changed, 30 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index 55a09c0e2d5c..503f90b2a5ba 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -113,77 +113,59 @@ struct iadc_chip {
 	struct completion complete;
 };
 
-static int iadc_read(struct iadc_chip *iadc, u16 offset, u8 *data)
-{
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(iadc->regmap, offset, &val);
-	if (ret < 0)
-		return ret;
-
-	*data = val;
-	return 0;
-}
-
-static int iadc_write(struct iadc_chip *iadc, u16 offset, u8 data)
-{
-	return regmap_write(iadc->regmap, offset, data);
-}
-
 static int iadc_reset(struct iadc_chip *iadc)
 {
-	u8 data;
+	u32 data;
 	int ret;
 
-	ret = iadc_write(iadc, IADC_SEC_ACCESS, IADC_SEC_ACCESS_DATA);
+	ret = regmap_write(iadc->regmap, IADC_SEC_ACCESS, IADC_SEC_ACCESS_DATA);
 	if (ret < 0)
 		return ret;
 
-	ret = iadc_read(iadc, IADC_PERH_RESET_CTL3, &data);
+	ret = regmap_read(iadc->regmap, IADC_PERH_RESET_CTL3, &data);
 	if (ret < 0)
 		return ret;
 
-	ret = iadc_write(iadc, IADC_SEC_ACCESS, IADC_SEC_ACCESS_DATA);
+	ret = regmap_write(iadc->regmap, IADC_SEC_ACCESS, IADC_SEC_ACCESS_DATA);
 	if (ret < 0)
 		return ret;
 
 	data |= IADC_FOLLOW_WARM_RB;
 
-	return iadc_write(iadc, IADC_PERH_RESET_CTL3, data);
+	return regmap_write(iadc->regmap, IADC_PERH_RESET_CTL3, data);
 }
 
 static int iadc_set_state(struct iadc_chip *iadc, bool state)
 {
-	return iadc_write(iadc, IADC_EN_CTL1, state ? IADC_EN_CTL1_SET : 0);
+	return regmap_write(iadc->regmap, IADC_EN_CTL1, state ? IADC_EN_CTL1_SET : 0);
 }
 
 static void iadc_status_show(struct iadc_chip *iadc)
 {
-	u8 mode, sta1, chan, dig, en, req;
+	u32 mode, sta1, chan, dig, en, req;
 	int ret;
 
-	ret = iadc_read(iadc, IADC_MODE_CTL, &mode);
+	ret = regmap_read(iadc->regmap, IADC_MODE_CTL, &mode);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_DIG_PARAM, &dig);
+	ret = regmap_read(iadc->regmap, IADC_DIG_PARAM, &dig);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_CH_SEL_CTL, &chan);
+	ret = regmap_read(iadc->regmap, IADC_CH_SEL_CTL, &chan);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_CONV_REQ, &req);
+	ret = regmap_read(iadc->regmap, IADC_CONV_REQ, &req);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_STATUS1, &sta1);
+	ret = regmap_read(iadc->regmap, IADC_STATUS1, &sta1);
 	if (ret < 0)
 		return;
 
-	ret = iadc_read(iadc, IADC_EN_CTL1, &en);
+	ret = regmap_read(iadc->regmap, IADC_EN_CTL1, &en);
 	if (ret < 0)
 		return;
 
@@ -199,34 +181,34 @@ static int iadc_configure(struct iadc_chip *iadc, int channel)
 
 	/* Mode selection */
 	mode = (IADC_OP_MODE_NORMAL << IADC_OP_MODE_SHIFT) | IADC_TRIM_EN;
-	ret = iadc_write(iadc, IADC_MODE_CTL, mode);
+	ret = regmap_write(iadc->regmap, IADC_MODE_CTL, mode);
 	if (ret < 0)
 		return ret;
 
 	/* Channel selection */
-	ret = iadc_write(iadc, IADC_CH_SEL_CTL, channel);
+	ret = regmap_write(iadc->regmap, IADC_CH_SEL_CTL, channel);
 	if (ret < 0)
 		return ret;
 
 	/* Digital parameter setup */
 	decim = IADC_DEF_DECIMATION << IADC_DIG_DEC_RATIO_SEL_SHIFT;
-	ret = iadc_write(iadc, IADC_DIG_PARAM, decim);
+	ret = regmap_write(iadc->regmap, IADC_DIG_PARAM, decim);
 	if (ret < 0)
 		return ret;
 
 	/* HW settle time delay */
-	ret = iadc_write(iadc, IADC_HW_SETTLE_DELAY, IADC_DEF_HW_SETTLE_TIME);
+	ret = regmap_write(iadc->regmap, IADC_HW_SETTLE_DELAY, IADC_DEF_HW_SETTLE_TIME);
 	if (ret < 0)
 		return ret;
 
-	ret = iadc_write(iadc, IADC_FAST_AVG_CTL, IADC_DEF_AVG_SAMPLES);
+	ret = regmap_write(iadc->regmap, IADC_FAST_AVG_CTL, IADC_DEF_AVG_SAMPLES);
 	if (ret < 0)
 		return ret;
 
 	if (IADC_DEF_AVG_SAMPLES)
-		ret = iadc_write(iadc, IADC_FAST_AVG_EN, IADC_FAST_AVG_EN_SET);
+		ret = regmap_write(iadc->regmap, IADC_FAST_AVG_EN, IADC_FAST_AVG_EN_SET);
 	else
-		ret = iadc_write(iadc, IADC_FAST_AVG_EN, 0);
+		ret = regmap_write(iadc->regmap, IADC_FAST_AVG_EN, 0);
 
 	if (ret < 0)
 		return ret;
@@ -239,19 +221,19 @@ static int iadc_configure(struct iadc_chip *iadc, int channel)
 		return ret;
 
 	/* Request conversion */
-	return iadc_write(iadc, IADC_CONV_REQ, IADC_CONV_REQ_SET);
+	return regmap_write(iadc->regmap, IADC_CONV_REQ, IADC_CONV_REQ_SET);
 }
 
 static int iadc_poll_wait_eoc(struct iadc_chip *iadc, unsigned int interval_us)
 {
 	unsigned int count, retry;
+	u32 sta1;
 	int ret;
-	u8 sta1;
 
 	retry = interval_us / IADC_CONV_TIME_MIN_US;
 
 	for (count = 0; count < retry; count++) {
-		ret = iadc_read(iadc, IADC_STATUS1, &sta1);
+		ret = regmap_read(iadc->regmap, IADC_STATUS1, &sta1);
 		if (ret < 0)
 			return ret;
 
@@ -267,11 +249,6 @@ static int iadc_poll_wait_eoc(struct iadc_chip *iadc, unsigned int interval_us)
 	return -ETIMEDOUT;
 }
 
-static int iadc_read_result(struct iadc_chip *iadc, u16 *data)
-{
-	return regmap_bulk_read(iadc->regmap, IADC_DATA, data, 2);
-}
-
 static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
 {
 	unsigned int wait;
@@ -296,7 +273,7 @@ static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
 	}
 
 	if (!ret)
-		ret = iadc_read_result(iadc, data);
+		ret = regmap_bulk_read(iadc->regmap, IADC_DATA, data, sizeof(*data));
 exit:
 	iadc_set_state(iadc, false);
 	if (ret < 0)
@@ -392,10 +369,10 @@ static int iadc_update_offset(struct iadc_chip *iadc)
 
 static int iadc_version_check(struct iadc_chip *iadc)
 {
-	u8 val;
+	u32 val;
 	int ret;
 
-	ret = iadc_read(iadc, IADC_PERPH_TYPE, &val);
+	ret = regmap_read(iadc->regmap, IADC_PERPH_TYPE, &val);
 	if (ret < 0)
 		return ret;
 
@@ -404,7 +381,7 @@ static int iadc_version_check(struct iadc_chip *iadc)
 		return -EINVAL;
 	}
 
-	ret = iadc_read(iadc, IADC_PERPH_SUBTYPE, &val);
+	ret = regmap_read(iadc->regmap, IADC_PERPH_SUBTYPE, &val);
 	if (ret < 0)
 		return ret;
 
@@ -413,7 +390,7 @@ static int iadc_version_check(struct iadc_chip *iadc)
 		return -EINVAL;
 	}
 
-	ret = iadc_read(iadc, IADC_REVISION2, &val);
+	ret = regmap_read(iadc->regmap, IADC_REVISION2, &val);
 	if (ret < 0)
 		return ret;
 
@@ -428,7 +405,7 @@ static int iadc_version_check(struct iadc_chip *iadc)
 static int iadc_rsense_read(struct iadc_chip *iadc, struct device_node *node)
 {
 	int ret, sign, int_sense;
-	u8 deviation;
+	u32 deviation;
 
 	ret = of_property_read_u32(node, "qcom,external-resistor-micro-ohms",
 				   &iadc->rsense[IADC_EXT_RSENSE]);
@@ -440,7 +417,7 @@ static int iadc_rsense_read(struct iadc_chip *iadc, struct device_node *node)
 		return -EINVAL;
 	}
 
-	ret = iadc_read(iadc, IADC_NOMINAL_RSENSE, &deviation);
+	ret = regmap_read(iadc->regmap, IADC_NOMINAL_RSENSE, &deviation);
 	if (ret < 0)
 		return ret;
 
-- 
2.52.0


