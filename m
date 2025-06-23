Return-Path: <linux-iio+bounces-20905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E16AE3EF4
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 14:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF781772BE
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32922512C8;
	Mon, 23 Jun 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F8gbgihn"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3024DCF2;
	Mon, 23 Jun 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680039; cv=none; b=uHtEJ4P/oy+SplbxGWjrZ9UQ96ab47tJ9PWTAlDCgACFtnyQVNyuihklv/hlDbBycX/wsclJG3W1Sg6TP4IrVbZGtucGtPuVupKANcgDG8ethiNLYMvsR/i4x1+/YnJ++iepMuI3uRDs1oN+MpxBqJoOOnPs7gBdj/h6VBcTAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680039; c=relaxed/simple;
	bh=WdgRym+rs2N8cx2EBLq0NFaaKh9pfeQf1rK27XSLT/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2rT0J3Mo6eaXngKRkOREm2zfg7itZEOlwSVGGvlaedV/2a/EnYC2fb9D3FXGE0EBSS0EpahSnKGOn3DeQfROzVG0y/ZnqNH9svdh7EJ5G5fazGBGcwejo1cZmzNxwQ32Skmf8FeuobvdgosKlWoWUPYLK4+TKJSd6jqkU47SNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F8gbgihn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680035;
	bh=WdgRym+rs2N8cx2EBLq0NFaaKh9pfeQf1rK27XSLT/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8gbgihnPR/z9b6f+HcS1fUqJfzmDv6PJeKKRt1KoOXViS9+DttsVnz7a780IeqNN
	 YyBVV6ecR347YysfAsyDhGI2xvxFFNWCuwIkTh+5ZfkYpM63sHMu63ByKuXqP5jhCn
	 5L72yweadIWU/f6v08ep86ngGZOFNt4lv3PRjtec36RfivB3sOCePJYt80ygQvjHnt
	 7rXKPoeUb7FBq6aNoffrbVRUP6vcCf98nPYPxK2iR4ZW30eTlJI7aWk29OyZaA4O2N
	 w2etsDlPmiPw28QkE8uQ9xzIxY1h5C4o95Z02EkbV/difEE3bJJhtLrd4XjXUeTebl
	 NNq7ksOHk0Tyg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A92A217E0202;
	Mon, 23 Jun 2025 14:00:34 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 3/5] iio: adc: mt6359: Add ready register index and mask to channel data
Date: Mon, 23 Jun 2025 14:00:26 +0200
Message-ID: <20250623120028.108809-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
References: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding support for the AUXADC block found in
the MT6363 PMIC, add the ready register index and mask to the
mtk_pmic_auxadc_chan structure, populate those in the channel
description for all of the already supported SoCs and make use
of them in the .read_imp() callbacks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 118 ++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 53 deletions(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index eecf88b05c6f..ae7b65f5f551 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -101,12 +101,16 @@ struct mt6359_auxadc {
  * struct mtk_pmic_auxadc_chan - PMIC AUXADC channel data
  * @req_idx:       Request register number
  * @req_mask:      Bitmask to activate a channel
+ * @rdy_idx:       Readiness register number
+ * @rdy_mask:      Bitmask to determine channel readiness
  * @num_samples:   Number of AUXADC samples for averaging
  * @r_ratio:       Resistance ratio fractional
  */
 struct mtk_pmic_auxadc_chan {
 	u8 req_idx;
 	u16 req_mask;
+	u8 rdy_idx;
+	u16 rdy_mask;
 	u16 num_samples;
 	struct u8_fract r_ratio;
 };
@@ -130,13 +134,17 @@ struct mtk_pmic_auxadc_info {
 	const u16 *regs;
 	u16 sec_unlock_key;
 	u8 imp_adc_num;
-	int (*read_imp)(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat);
+	int (*read_imp)(struct mt6359_auxadc *adc_dev,
+			const struct iio_chan_spec *chan, int *vbat, int *ibat);
 };
 
-#define MTK_PMIC_ADC_CHAN(_ch_idx, _req_idx, _req_bit, _samples, _rnum, _rdiv)	\
+#define MTK_PMIC_ADC_CHAN(_ch_idx, _req_idx, _req_bit, _rdy_idx, _rdy_bit,	\
+			  _samples, _rnum, _rdiv)				\
 	[PMIC_AUXADC_CHAN_##_ch_idx] = {					\
 		.req_idx = _req_idx,						\
 		.req_mask = BIT(_req_bit),					\
+		.rdy_idx = _rdy_idx,						\
+		.rdy_mask = BIT(_rdy_bit),					\
 		.num_samples = _samples,					\
 		.r_ratio = { _rnum, _rdiv }					\
 	}
@@ -177,21 +185,21 @@ static const struct iio_chan_spec mt6357_auxadc_channels[] = {
 };
 
 static const struct mtk_pmic_auxadc_chan mt6357_auxadc_ch_desc[] = {
-	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, 128, 3, 1),
-	MTK_PMIC_ADC_CHAN(ISENSE, PMIC_AUXADC_RQST0, 0, 128, 3, 1),
-	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 0, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, 128, 1, 1),
-	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, 256, 1, 1),
-	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, 16, 1, 1),
-	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 5, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 6, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 128, 3, 1),
+	MTK_PMIC_ADC_CHAN(ISENSE, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 128, 3, 1),
+	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, PMIC_AUXADC_IMP0, 8, 128, 1, 1),
+	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, PMIC_AUXADC_IMP0, 8, 256, 1, 1),
+	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, PMIC_AUXADC_IMP0, 8, 16, 1, 1),
+	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 5, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 6, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
 
 	/* Battery impedance channels */
-	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 3, 1),
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 0, 0, 128, 3, 1),
 };
 
 static const u16 mt6357_auxadc_regs[] = {
@@ -224,22 +232,22 @@ static const struct iio_chan_spec mt6358_auxadc_channels[] = {
 };
 
 static const struct mtk_pmic_auxadc_chan mt6358_auxadc_ch_desc[] = {
-	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, 128, 3, 1),
-	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 0, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, 8, 2, 1),
-	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, 8, 3, 2),
-	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, 128, 1, 1),
-	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, 256, 1, 1),
-	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, 16, 1, 1),
-	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, 8, 2, 1),
-	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 8, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 9, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 128, 3, 1),
+	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, PMIC_AUXADC_IMP0, 8, 8, 2, 1),
+	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, PMIC_AUXADC_IMP0, 8, 8, 3, 2),
+	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, PMIC_AUXADC_IMP0, 8, 128, 1, 1),
+	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, PMIC_AUXADC_IMP0, 8, 256, 1, 1),
+	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, PMIC_AUXADC_IMP0, 8, 16, 1, 1),
+	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, PMIC_AUXADC_IMP0, 8, 8, 2, 1),
+	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 8, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 9, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
 
 	/* Battery impedance channels */
-	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 7, 2),
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 0, 0, 128, 7, 2),
 };
 
 static const u16 mt6358_auxadc_regs[] = {
@@ -272,22 +280,22 @@ static const struct iio_chan_spec mt6359_auxadc_channels[] = {
 };
 
 static const struct mtk_pmic_auxadc_chan mt6359_auxadc_ch_desc[] = {
-	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, 128, 7, 2),
-	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, 8, 5, 2),
-	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, 8, 3, 2),
-	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, 128, 1, 1),
-	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, 256, 1, 1),
-	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, 16, 1, 1),
-	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, 8, 5, 2),
-	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 8, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 9, 8, 1, 1),
-	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP1, 15, 128, 7, 2),
+	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, PMIC_AUXADC_IMP1, 15, 8, 5, 2),
+	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, PMIC_AUXADC_IMP1, 15, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, PMIC_AUXADC_IMP1, 15 ,8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, PMIC_AUXADC_IMP1, 15, 8, 3, 2),
+	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, PMIC_AUXADC_IMP1, 15, 128, 1, 1),
+	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, PMIC_AUXADC_IMP1, 15, 256, 1, 1),
+	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, PMIC_AUXADC_IMP1, 15, 16, 1, 1),
+	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, PMIC_AUXADC_IMP1, 15, 8, 5, 2),
+	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 8, PMIC_AUXADC_IMP1, 15, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 9, PMIC_AUXADC_IMP1, 15, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, PMIC_AUXADC_IMP1, 15, 8, 1, 1),
 
 	/* Battery impedance channels */
-	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 7, 2),
-	MTK_PMIC_ADC_CHAN(IBAT, 0, 0, 128, 7, 2),
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 0, 0, 128, 7, 2),
+	MTK_PMIC_ADC_CHAN(IBAT, 0, 0, 0, 0, 128, 7, 2),
 };
 
 static const u16 mt6359_auxadc_regs[] = {
@@ -313,9 +321,10 @@ static void mt6358_stop_imp_conv(struct mt6359_auxadc *adc_dev)
 	regmap_clear_bits(regmap, cinfo->regs[PMIC_AUXADC_DCM_CON], MT6358_DCM_CK_SW_EN);
 }
 
-static int mt6358_start_imp_conv(struct mt6359_auxadc *adc_dev)
+static int mt6358_start_imp_conv(struct mt6359_auxadc *adc_dev, const struct iio_chan_spec *chan)
 {
 	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	const struct mtk_pmic_auxadc_chan *desc = &cinfo->desc[chan->scan_index];
 	struct regmap *regmap = adc_dev->regmap;
 	u32 val;
 	int ret;
@@ -323,8 +332,8 @@ static int mt6358_start_imp_conv(struct mt6359_auxadc *adc_dev)
 	regmap_set_bits(regmap, cinfo->regs[PMIC_AUXADC_DCM_CON], MT6358_DCM_CK_SW_EN);
 	regmap_set_bits(regmap, cinfo->regs[PMIC_AUXADC_IMP1], MT6358_IMP1_AUTOREPEAT_EN);
 
-	ret = regmap_read_poll_timeout(adc_dev->regmap, cinfo->regs[PMIC_AUXADC_IMP0],
-				       val, val & MT6358_IMP0_IRQ_RDY,
+	ret = regmap_read_poll_timeout(regmap, cinfo->regs[desc->rdy_idx],
+				       val, val & desc->rdy_mask,
 				       IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
 	if (ret) {
 		mt6358_stop_imp_conv(adc_dev);
@@ -334,7 +343,8 @@ static int mt6358_start_imp_conv(struct mt6359_auxadc *adc_dev)
 	return 0;
 }
 
-static int mt6358_read_imp(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat)
+static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
+			   const struct iio_chan_spec *chan, int *vbat, int *ibat)
 {
 	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
 	struct regmap *regmap = adc_dev->regmap;
@@ -342,7 +352,7 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat)
 	u32 val_v;
 	int ret;
 
-	ret = mt6358_start_imp_conv(adc_dev);
+	ret = mt6358_start_imp_conv(adc_dev, chan);
 	if (ret)
 		return ret;
 
@@ -359,17 +369,19 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat)
 	return 0;
 }
 
-static int mt6359_read_imp(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat)
+static int mt6359_read_imp(struct mt6359_auxadc *adc_dev,
+			   const struct iio_chan_spec *chan, int *vbat, int *ibat)
 {
 	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	const struct mtk_pmic_auxadc_chan *desc = &cinfo->desc[chan->scan_index];
 	struct regmap *regmap = adc_dev->regmap;
 	u32 val, val_v, val_i;
 	int ret;
 
 	/* Start conversion */
 	regmap_write(regmap, cinfo->regs[PMIC_AUXADC_IMP0], MT6359_IMP0_CONV_EN);
-	ret = regmap_read_poll_timeout(regmap, cinfo->regs[PMIC_AUXADC_IMP1],
-				       val, val & MT6359_IMP1_IRQ_RDY,
+	ret = regmap_read_poll_timeout(regmap, cinfo->regs[desc->rdy_idx],
+				       val, val & desc->rdy_mask,
 				       IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
 
 	/* Stop conversion regardless of the result */
@@ -506,10 +518,10 @@ static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
 	scoped_guard(mutex, &adc_dev->lock) {
 		switch (chan->scan_index) {
 		case PMIC_AUXADC_CHAN_IBAT:
-			ret = adc_dev->chip_info->read_imp(adc_dev, NULL, val);
+			ret = adc_dev->chip_info->read_imp(adc_dev, chan, NULL, val);
 			break;
 		case PMIC_AUXADC_CHAN_VBAT:
-			ret = adc_dev->chip_info->read_imp(adc_dev, val, NULL);
+			ret = adc_dev->chip_info->read_imp(adc_dev, chan, val, NULL);
 			break;
 		default:
 			ret = mt6359_auxadc_read_adc(adc_dev, chan, val);
-- 
2.49.0


