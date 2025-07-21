Return-Path: <linux-iio+bounces-21802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8ADB0BE4B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 09:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370187A5E90
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 07:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52FB289E38;
	Mon, 21 Jul 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RaQbuP+S"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F2289361;
	Mon, 21 Jul 2025 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084552; cv=none; b=pLYcaHdu92iBI21EntX+POIT3ZTcOIe1nalp5YkdmMFekYO4AmvjVUPgtDfpbDEYSdccKhiTYOviZNImXNPI0Mj/J+xcgOzs9fzPmMNZcH9w4Mp7YcGXQrfJSRY1cUWGAyzSSRslH39Y30ny6dXVZF5idv51Y39UVUdwJh2Hcjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084552; c=relaxed/simple;
	bh=mBc7530Rsi1COudHSAOxtA9Am1XSATrJ3WR33XSu+Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BT28NrMhQa3dK++Y145EhYE13sWkXKWpilDbD9nWrZi1fAeE38H0nEEDNfDERBN/oYqSV1Rlpmw4UQ5Rx0L2iOM/4y33cFVtHBH2Me7QQy7ZILNEyZerqz1eD0+G78PzRek2XGBnu10ngucXM7rR9hwyDAib6GsT/nidyRNEqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RaQbuP+S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753084548;
	bh=mBc7530Rsi1COudHSAOxtA9Am1XSATrJ3WR33XSu+Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaQbuP+SHLOgEo6vOLDymcVPgrJLYaSZyc3L6cRB+NuLivuTTuBz4Uj0VY9TLa9rG
	 naMfR1PgN1/PJByhrp6Nub/68IAYasx02wPtTOjnUtw8JaZMmWAgcBckmiYc+IiQOr
	 rhRmyIqgHU2VbNOci6TAld2/FnJzIYtp5t2E1cothUwWm4nJWRkqQ36QgSE6bm9Ap4
	 YwdAooI97kDYJvluzWrkbvctmcZ1a4Gv2hDD11LO6sCjaRNU0S1cuCSk2f1IYufly+
	 1587nB6r7wil51nxVHz+dqHfWZrJO6SC4n4qsJoonIEfIwTFM6RVKreuxKtSp/0BHK
	 XTjWzw7DEkTDg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9623F17E132A;
	Mon, 21 Jul 2025 09:55:47 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	sre@kernel.org,
	krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	wenst@chromium.org
Subject: [PATCH v1 7/7] iio: adc: qcom-spmi-iadc: Remove regmap R/W wrapper functions
Date: Mon, 21 Jul 2025 09:55:25 +0200
Message-ID: <20250721075525.29636-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/qcom-spmi-iadc.c | 83 ++++++++++++--------------------
 1 file changed, 30 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index 34e31bb49f4f..111027ae033e 100644
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
 	int ret;
-	u8 sta1;
+	u32 sta1;
 
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
+		ret = regmap_bulk_read(iadc->regmap, IADC_DATA, data, 2);
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
2.50.1


