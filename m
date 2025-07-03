Return-Path: <linux-iio+bounces-21302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8383AF76E0
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340ED4E59EF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC72EA75E;
	Thu,  3 Jul 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kOLETCWU"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F082E92AA;
	Thu,  3 Jul 2025 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551916; cv=none; b=Fzi1BbVvkp1CNf94QRbiDZ23ge0oc0Jk82U2QzPBCmz6pMIM52LR+2sSQMxEpyTx8YLFN4eHPDAHbiNFXW7BLgrAkulLKVh1bjn9lbSCRVrV4GAzBJbpvSXzSEEKI5/f8EwwVbwOU+n8idjUnsW8PEpToXQY7pch8BbCYxVI7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551916; c=relaxed/simple;
	bh=QsAuJqTGSAkxlbhomMU/9ni8VK3R+48MCxlhKRwWCTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2WYifJd39w26McpFbV1bhZkIEHEaDd2seei/26X4JqDDNXC2QFxKgBNTOAOcyvtI7w2JvcMhNgcsd4rOvtFyvvJSEHH3ib4yNjJ7407oC1u8NEJ9LS8vv6aKDlAKT0u7bsQBMWzvCh/W3F79XN2+reQKk3xiG0ERRT5h3yXhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kOLETCWU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751551913;
	bh=QsAuJqTGSAkxlbhomMU/9ni8VK3R+48MCxlhKRwWCTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOLETCWUPeE1udZ03kmUBNL2S8DvMhiSdoMP6lzihCqaTLs7C7qVwwbc8idqlt1H7
	 BwYaCDtNRJYGAP480dZ5zpqlebB7csvDLDY8MDV1D1J+QRMDB4cRIfp/5/tS7WMgf7
	 zDfceKyt/BnyeEANdUlHgyvBUUwWhF8KYxuHkRb2CvusTQTrUVj5Ix+nV9fOgt5iFM
	 CVyFvqJz1IlD5vslYwbNe1W55+mjxDYjvYpMYeKaT0XcHy8y6TUIIywqwvkUUIa8d9
	 bNG3KpL1WLls+sO06prHGf4dpp0SRMrqD+3hoOAwgq5smKVp4ZIU4oCiM6EaABOrnh
	 u6BEF4J0rhyRw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3FBB017E0EC0;
	Thu,  3 Jul 2025 16:11:52 +0200 (CEST)
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
Subject: [PATCH v2 4/6] iio: adc: mt6359: Move reference voltage to platform data
Date: Thu,  3 Jul 2025 16:11:44 +0200
Message-ID: <20250703141146.171431-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
References: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to add support for new PMICs, add a `vref_mv`
member to struct mtk_pmic_auxadc_info and use it in place of
the AUXADC_VOLT_FULL definition.

As a consequence, the definition was also removed.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 2ccc64e6c126..914c9a22cd14 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -28,7 +28,6 @@
 #define AUXADC_AVG_TIME_US		10
 #define AUXADC_POLL_DELAY_US		100
 #define AUXADC_TIMEOUT_US		32000
-#define AUXADC_VOLT_FULL		1800
 #define IMP_STOP_DELAY_US		150
 #define IMP_POLL_DELAY_US		1000
 
@@ -123,6 +122,7 @@ struct mtk_pmic_auxadc_chan {
  * @desc:           PMIC AUXADC channel data
  * @regs:           List of PMIC specific registers
  * @sec_unlock_key: Security unlock key for HK_TOP writes
+ * @vref_mv:        AUXADC Reference Voltage (VREF) in millivolts
  * @imp_adc_num:    ADC channel for battery impedance readings
  * @read_imp:       Callback to read impedance channels
  */
@@ -133,6 +133,7 @@ struct mtk_pmic_auxadc_info {
 	const struct mtk_pmic_auxadc_chan *desc;
 	const u16 *regs;
 	u16 sec_unlock_key;
+	u32 vref_mv;
 	u8 imp_adc_num;
 	int (*read_imp)(struct mt6359_auxadc *adc_dev,
 			const struct iio_chan_spec *chan, int *vbat, int *ibat);
@@ -416,6 +417,7 @@ static const struct mtk_pmic_auxadc_info mt6357_chip_info = {
 	.regs = mt6357_auxadc_regs,
 	.imp_adc_num = MT6357_IMP_ADC_NUM,
 	.read_imp = mt6358_read_imp,
+	.vref_mv = 1800,
 };
 
 static const struct mtk_pmic_auxadc_info mt6358_chip_info = {
@@ -426,6 +428,7 @@ static const struct mtk_pmic_auxadc_info mt6358_chip_info = {
 	.regs = mt6358_auxadc_regs,
 	.imp_adc_num = MT6358_IMP_ADC_NUM,
 	.read_imp = mt6358_read_imp,
+	.vref_mv = 1800,
 };
 
 static const struct mtk_pmic_auxadc_info mt6359_chip_info = {
@@ -436,6 +439,7 @@ static const struct mtk_pmic_auxadc_info mt6359_chip_info = {
 	.regs = mt6359_auxadc_regs,
 	.sec_unlock_key = 0x6359,
 	.read_imp = mt6359_read_imp,
+	.vref_mv = 1800,
 };
 
 static void mt6359_auxadc_reset(struct mt6359_auxadc *adc_dev)
@@ -505,7 +509,7 @@ static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	if (mask == IIO_CHAN_INFO_SCALE) {
-		*val = desc->r_ratio.numerator * AUXADC_VOLT_FULL;
+		*val = desc->r_ratio.numerator * cinfo->vref_mv;
 
 		if (desc->r_ratio.denominator > 1) {
 			*val2 = desc->r_ratio.denominator;
-- 
2.49.0


