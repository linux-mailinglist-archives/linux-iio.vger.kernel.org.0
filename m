Return-Path: <linux-iio+bounces-21303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 903BAAF76EB
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A174B18890F2
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF032EAD07;
	Thu,  3 Jul 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qvvy5aZY"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3542EA15F;
	Thu,  3 Jul 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551918; cv=none; b=ifKxTNEdw6StqadICMoxXAlD00FgFAH2wxk6T5Q4ODiezflHRn4tRf2DEIMTOTDKqRmI4yDMU1cm8s9r18iIU9eGcOP6YLnXPzc2XGjOSLNQAPiNuQzggpcPiIkdumfwuY5EQsuqSXzYEeQmp+Hct1/JjPEXiqilcD+L9WmbUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551918; c=relaxed/simple;
	bh=eHKz8yzSn2a1aRhQBHAgxVwSmANOLbNOWTVC0mXfEl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FS2J6drInAsQuOqGq93jFykjt06HK5uRjC+3k5kuRXkV3+Lq82ECl+YTS08JKTVjTJ0kJS/Xh9FY2Kt2HiyblE4UCrIRSj7z4wYEUjk7WvFfZliLWzyD+yeH+a4UaDwDGil9vaPUaZTpv4n5Jwa4BSpN0Tin8suNSXNqrUusa4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qvvy5aZY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751551914;
	bh=eHKz8yzSn2a1aRhQBHAgxVwSmANOLbNOWTVC0mXfEl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qvvy5aZYtmDx8IZiv85k9xBvqrmtUJ26dG/ujzRb6uGK/daoixZ3BpOmk/gbk1Tyi
	 3HNmc8usZqrThN9hXMTn0s+dIHuCl61erXvYHu7CQq8Bba5Q9JZuM0Cr+j6U5PLxc3
	 pz+6xkO7eqPKnfbDpY6/8rqIzDXzGHY7QH6YIOAmKyedfh/qNlg0ZPgDzCf9y2HLht
	 wEv34yBGv+GD0rSIpyKWT7XXe+dy8ztA8W8o1/69/PnWUIGodLjv5BoYum9IR5pB1J
	 0oJFoQVWW7ZoYekNghChgtGlIOo3Jx0Iqmk1j/xo7nknmufjP/Tv1WZeBngA8QVa1f
	 1jkfH9/D6GEUw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2D50D17E0F34;
	Thu,  3 Jul 2025 16:11:53 +0200 (CEST)
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
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 5/6] iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC
Date: Thu,  3 Jul 2025 16:11:45 +0200
Message-ID: <20250703141146.171431-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
References: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MediaTek MT6363 is a PMIC found on MT8196/MT6991 board designs
and communicates with the SoC over SPMI.

This PMIC integrates an Auxiliary ADC (AUXADC) which has a grand
total of 54 ADC channels: 49 PMIC-internal channels, 2 external
NTC thermistor channels and 2 generic ADC channels (mapped to 7
PMIC ADC external inputs).

To use a generic ADC channel it is necessary to enable one of
the PMIC ADC inputs at a time and only then start the reading,
so in this case it is possible to read only one external input
for each generic ADC channel.

Due to the lack of documentation, this implementation supports
using only one generic ADC channel, hence supports reading only
one external input at a time.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 268 ++++++++++++++++++++++++++++++--
 1 file changed, 252 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 914c9a22cd14..38c635cd0cd7 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -7,6 +7,7 @@
  * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
@@ -24,6 +25,7 @@
 #include <dt-bindings/iio/adc/mediatek,mt6357-auxadc.h>
 #include <dt-bindings/iio/adc/mediatek,mt6358-auxadc.h>
 #include <dt-bindings/iio/adc/mediatek,mt6359-auxadc.h>
+#include <dt-bindings/iio/adc/mediatek,mt6363-auxadc.h>
 
 #define AUXADC_AVG_TIME_US		10
 #define AUXADC_POLL_DELAY_US		100
@@ -45,6 +47,11 @@
 #define MT6359_IMP0_CONV_EN		BIT(0)
 #define MT6359_IMP1_IRQ_RDY		BIT(15)
 
+#define MT6363_EXT_CHAN_MASK		GENMASK(2, 0)
+#define MT6363_EXT_PURES_MASK		GENMASK(4, 3)
+  #define MT6363_PULLUP_RES_100K	0
+  #define MT6363_PULLUP_RES_OPEN	3
+
 enum mtk_pmic_auxadc_regs {
 	PMIC_AUXADC_ADC0,
 	PMIC_AUXADC_DCM_CON,
@@ -53,6 +60,8 @@ enum mtk_pmic_auxadc_regs {
 	PMIC_AUXADC_IMP3,
 	PMIC_AUXADC_RQST0,
 	PMIC_AUXADC_RQST1,
+	PMIC_AUXADC_RQST3,
+	PMIC_AUXADC_SDMADC_CON0,
 	PMIC_HK_TOP_WKEY,
 	PMIC_HK_TOP_RST_CON0,
 	PMIC_FGADC_R_CON0,
@@ -74,7 +83,16 @@ enum mtk_pmic_auxadc_channels {
 	PMIC_AUXADC_CHAN_TSX_TEMP,
 	PMIC_AUXADC_CHAN_HPOFS_CAL,
 	PMIC_AUXADC_CHAN_DCXO_TEMP,
+	PMIC_AUXADC_CHAN_VTREF,
 	PMIC_AUXADC_CHAN_VBIF,
+	PMIC_AUXADC_CHAN_VSYSSNS,
+	PMIC_AUXADC_CHAN_VIN1,
+	PMIC_AUXADC_CHAN_VIN2,
+	PMIC_AUXADC_CHAN_VIN3,
+	PMIC_AUXADC_CHAN_VIN4,
+	PMIC_AUXADC_CHAN_VIN5,
+	PMIC_AUXADC_CHAN_VIN6,
+	PMIC_AUXADC_CHAN_VIN7,
 	PMIC_AUXADC_CHAN_IBAT,
 	PMIC_AUXADC_CHAN_VBAT,
 	PMIC_AUXADC_CHAN_MAX
@@ -102,6 +120,9 @@ struct mt6359_auxadc {
  * @req_mask:      Bitmask to activate a channel
  * @rdy_idx:       Readiness register number
  * @rdy_mask:      Bitmask to determine channel readiness
+ * @ext_sel_idx:   PMIC GPIO channel register number
+ * @ext_sel_ch:    PMIC GPIO number
+ * @ext_sel_pu:    PMIC GPIO channel pullup resistor selector
  * @num_samples:   Number of AUXADC samples for averaging
  * @r_ratio:       Resistance ratio fractional
  */
@@ -110,6 +131,9 @@ struct mtk_pmic_auxadc_chan {
 	u16 req_mask;
 	u8 rdy_idx;
 	u16 rdy_mask;
+	s8 ext_sel_idx;
+	u8 ext_sel_ch;
+	u8 ext_sel_pu;
 	u16 num_samples;
 	struct u8_fract r_ratio;
 };
@@ -124,6 +148,8 @@ struct mtk_pmic_auxadc_chan {
  * @sec_unlock_key: Security unlock key for HK_TOP writes
  * @vref_mv:        AUXADC Reference Voltage (VREF) in millivolts
  * @imp_adc_num:    ADC channel for battery impedance readings
+ * @is_spmi:        Defines whether this PMIC communicates over SPMI
+ * @no_reset:       If true, this PMIC does not support ADC reset
  * @read_imp:       Callback to read impedance channels
  */
 struct mtk_pmic_auxadc_info {
@@ -135,21 +161,32 @@ struct mtk_pmic_auxadc_info {
 	u16 sec_unlock_key;
 	u32 vref_mv;
 	u8 imp_adc_num;
+	bool is_spmi;
+	bool no_reset;
 	int (*read_imp)(struct mt6359_auxadc *adc_dev,
 			const struct iio_chan_spec *chan, int *vbat, int *ibat);
 };
 
-#define MTK_PMIC_ADC_CHAN(_ch_idx, _req_idx, _req_bit, _rdy_idx, _rdy_bit,	\
-			  _samples, _rnum, _rdiv)				\
+#define MTK_PMIC_ADC_EXT_CHAN(_ch_idx, _req_idx, _req_bit, _rdy_idx, _rdy_bit,	\
+			      _ext_sel_idx, _ext_sel_ch, _ext_sel_pu,		\
+			      _samples, _rnum, _rdiv)				\
 	[PMIC_AUXADC_CHAN_##_ch_idx] = {					\
 		.req_idx = _req_idx,						\
 		.req_mask = BIT(_req_bit),					\
 		.rdy_idx = _rdy_idx,						\
 		.rdy_mask = BIT(_rdy_bit),					\
+		.ext_sel_idx = _ext_sel_idx,					\
+		.ext_sel_ch = _ext_sel_ch,					\
+		.ext_sel_pu = _ext_sel_pu,					\
 		.num_samples = _samples,					\
 		.r_ratio = { _rnum, _rdiv }					\
 	}
 
+#define MTK_PMIC_ADC_CHAN(_ch_idx, _req_idx, _req_bit, _rdy_idx, _rdy_bit,	\
+			  _samples, _rnum, _rdiv)				\
+	MTK_PMIC_ADC_EXT_CHAN(_ch_idx, _req_idx, _req_bit, _rdy_idx, _rdy_bit,	\
+			      -1, 0, 0, _samples, _rnum, _rdiv)
+
 #define MTK_PMIC_IIO_CHAN(_model, _name, _ch_idx, _adc_idx, _nbits, _ch_type)	\
 {										\
 	.type = _ch_type,							\
@@ -311,6 +348,70 @@ static const u16 mt6359_auxadc_regs[] = {
 	[PMIC_AUXADC_IMP3]	= 0x120e,
 };
 
+static const struct iio_chan_spec mt6363_auxadc_channels[] = {
+	MTK_PMIC_IIO_CHAN(MT6363, bat_adc, BATADC, 0, 15, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6363, cdt_v, VCDT, 2, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6363, batt_temp, BAT_TEMP, 3, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6363, chip_temp, CHIP_TEMP, 4, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6363, sys_sns_v, VSYSSNS, 6, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, tref_v, VTREF, 11, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, vcore_temp, VCORE_TEMP, 38, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6363, vproc_temp, VPROC_TEMP, 39, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6363, vgpu_temp, VGPU_TEMP, 40, 12, IIO_TEMP),
+
+	/* For VIN, ADC12 holds the result depending on which GPIO was activated */
+	MTK_PMIC_IIO_CHAN(MT6363, in1_v, VIN1, 45, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, in2_v, VIN2, 45, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, in3_v, VIN3, 45, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, in4_v, VIN4, 45, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, in5_v, VIN5, 45, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, in6_v, VIN6, 45, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6363, in7_v, VIN7, 45, 15, IIO_VOLTAGE),
+};
+
+static const struct mtk_pmic_auxadc_chan mt6363_auxadc_ch_desc[] = {
+	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_ADC0, 15, 64, 4, 1),
+	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 2, PMIC_AUXADC_ADC0, 15, 32, 1, 1),
+	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, PMIC_AUXADC_ADC0, 15, 32, 3, 2),
+	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, PMIC_AUXADC_ADC0, 15, 32, 1, 1),
+	MTK_PMIC_ADC_CHAN(VSYSSNS, PMIC_AUXADC_RQST1, 6, PMIC_AUXADC_ADC0, 15, 64, 3, 1),
+	MTK_PMIC_ADC_CHAN(VTREF, PMIC_AUXADC_RQST1, 3, PMIC_AUXADC_ADC0, 15, 32, 3, 2),
+	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST3, 0, PMIC_AUXADC_ADC0, 15, 32, 1, 1),
+	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST3, 1, PMIC_AUXADC_ADC0, 15, 32, 1, 1),
+	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST3, 2, PMIC_AUXADC_ADC0, 15, 32, 1, 1),
+
+	MTK_PMIC_ADC_EXT_CHAN(VIN1,
+			      PMIC_AUXADC_RQST1, 4, PMIC_AUXADC_ADC0, 15,
+			      PMIC_AUXADC_SDMADC_CON0, 1, MT6363_PULLUP_RES_100K, 32, 1, 1),
+	MTK_PMIC_ADC_EXT_CHAN(VIN2,
+			      PMIC_AUXADC_RQST1, 4, PMIC_AUXADC_ADC0, 15,
+			      PMIC_AUXADC_SDMADC_CON0, 2, MT6363_PULLUP_RES_100K, 32, 1, 1),
+	MTK_PMIC_ADC_EXT_CHAN(VIN3,
+			      PMIC_AUXADC_RQST1, 4, PMIC_AUXADC_ADC0, 15,
+			      PMIC_AUXADC_SDMADC_CON0, 3, MT6363_PULLUP_RES_100K, 32, 1, 1),
+	MTK_PMIC_ADC_EXT_CHAN(VIN4,
+			      PMIC_AUXADC_RQST1, 4, PMIC_AUXADC_ADC0, 15,
+			      PMIC_AUXADC_SDMADC_CON0, 4, MT6363_PULLUP_RES_100K, 32, 1, 1),
+	MTK_PMIC_ADC_EXT_CHAN(VIN5,
+			      PMIC_AUXADC_RQST1, 4, PMIC_AUXADC_ADC0, 15,
+			      PMIC_AUXADC_SDMADC_CON0, 5, MT6363_PULLUP_RES_100K, 32, 1, 1),
+	MTK_PMIC_ADC_EXT_CHAN(VIN6,
+			      PMIC_AUXADC_RQST1, 4, PMIC_AUXADC_ADC0, 15,
+			      PMIC_AUXADC_SDMADC_CON0, 6, MT6363_PULLUP_RES_100K, 32, 1, 1),
+	MTK_PMIC_ADC_EXT_CHAN(VIN7,
+			      PMIC_AUXADC_RQST1, 4, PMIC_AUXADC_ADC0, 15,
+			      PMIC_AUXADC_SDMADC_CON0, 7, MT6363_PULLUP_RES_100K, 32, 1, 1),
+};
+
+static const u16 mt6363_auxadc_regs[] = {
+	[PMIC_AUXADC_RQST0]	= 0x1108,
+	[PMIC_AUXADC_RQST1]	= 0x1109,
+	[PMIC_AUXADC_RQST3]	= 0x110c,
+	[PMIC_AUXADC_ADC0]	= 0x1088,
+	[PMIC_AUXADC_IMP0]	= 0x1208,
+	[PMIC_AUXADC_IMP1]	= 0x1209,
+};
+
 static void mt6358_stop_imp_conv(struct mt6359_auxadc *adc_dev)
 {
 	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
@@ -442,11 +543,26 @@ static const struct mtk_pmic_auxadc_info mt6359_chip_info = {
 	.vref_mv = 1800,
 };
 
+static const struct mtk_pmic_auxadc_info mt6363_chip_info = {
+	.model_name = "MT6363",
+	.channels = mt6363_auxadc_channels,
+	.num_channels = ARRAY_SIZE(mt6363_auxadc_channels),
+	.desc = mt6363_auxadc_ch_desc,
+	.regs = mt6363_auxadc_regs,
+	.is_spmi = true,
+	.no_reset = true,
+	.vref_mv = 1840,
+};
+
 static void mt6359_auxadc_reset(struct mt6359_auxadc *adc_dev)
 {
 	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
 	struct regmap *regmap = adc_dev->regmap;
 
+	/* Some PMICs do not support reset */
+	if (cinfo->no_reset)
+		return;
+
 	/* Unlock HK_TOP writes */
 	if (cinfo->sec_unlock_key)
 		regmap_write(regmap, cinfo->regs[PMIC_HK_TOP_WKEY], cinfo->sec_unlock_key);
@@ -462,13 +578,29 @@ static void mt6359_auxadc_reset(struct mt6359_auxadc *adc_dev)
 		regmap_write(regmap, cinfo->regs[PMIC_HK_TOP_WKEY], 0);
 }
 
-static int mt6359_auxadc_read_adc(struct mt6359_auxadc *adc_dev,
-				  const struct iio_chan_spec *chan, int *out)
+/**
+ * mt6359_auxadc_sample_adc_val() - Start ADC channel sampling and read value
+ * @adc_dev: Main driver structure
+ * @chan:    IIO Channel spec for requested ADC
+ * @out:     Preallocated variable to store the value read from HW
+ *
+ * This function starts the sampling for an ADC channel, waits until all
+ * of the samples are averaged and then reads the value from the HW.
+ *
+ * Note that the caller must stop the ADC sampling on its own, as this
+ * function *never* stops it.
+ *
+ * Return:
+ * Negative number for error;
+ * Upon success returns zero and writes the read value to *out.
+ */
+static int mt6359_auxadc_sample_adc_val(struct mt6359_auxadc *adc_dev,
+					const struct iio_chan_spec *chan, u32 *out)
 {
 	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
 	const struct mtk_pmic_auxadc_chan *desc = &cinfo->desc[chan->scan_index];
 	struct regmap *regmap = adc_dev->regmap;
-	u32 val;
+	u32 reg, rdy_mask, val, lval;
 	int ret;
 
 	/* Request to start sampling for ADC channel */
@@ -479,16 +611,95 @@ static int mt6359_auxadc_read_adc(struct mt6359_auxadc *adc_dev,
 	/* Wait until all samples are averaged */
 	fsleep(desc->num_samples * AUXADC_AVG_TIME_US);
 
-	ret = regmap_read_poll_timeout(regmap,
-				       cinfo->regs[PMIC_AUXADC_ADC0] + (chan->address << 1),
-				       val, val & PMIC_AUXADC_RDY_BIT,
+	reg = cinfo->regs[PMIC_AUXADC_ADC0] + (chan->address << 1);
+	rdy_mask = PMIC_AUXADC_RDY_BIT;
+
+	/*
+	 * Even though for both PWRAP and SPMI cases the ADC HW signals that
+	 * the data is ready by setting AUXADC_RDY_BIT, for SPMI the register
+	 * read is only 8 bits long: for this case, the check has to be done
+	 * on the ADC(x)_H register (high bits) and the rdy_mask needs to be
+	 * shifted to the right by the same 8 bits.
+	 */
+	if (cinfo->is_spmi) {
+		rdy_mask >>= 8;
+		reg += 1;
+	}
+
+	ret = regmap_read_poll_timeout(regmap, reg, val, val & rdy_mask,
 				       AUXADC_POLL_DELAY_US, AUXADC_TIMEOUT_US);
+	if (ret) {
+		dev_dbg(adc_dev->dev, "ADC read timeout for chan %lu\n", chan->address);
+		return ret;
+	}
+
+	if (cinfo->is_spmi) {
+		ret = regmap_read(regmap, reg - 1, &lval);
+		if (ret)
+			return ret;
+
+		val = (val << 8) | lval;
+	}
+
+	*out = val;
+	return 0;
+}
+
+static int mt6359_auxadc_read_adc(struct mt6359_auxadc *adc_dev,
+				  const struct iio_chan_spec *chan, int *out)
+{
+	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	const struct mtk_pmic_auxadc_chan *desc = &cinfo->desc[chan->scan_index];
+	struct regmap *regmap = adc_dev->regmap;
+	int ret, adc_stop_err;
+	u8 ext_sel;
+	u32 val;
+
+	if (desc->ext_sel_idx >= 0) {
+		ext_sel = FIELD_PREP(MT6363_EXT_PURES_MASK, desc->ext_sel_pu);
+		ext_sel |= FIELD_PREP(MT6363_EXT_CHAN_MASK, desc->ext_sel_ch);
+
+		ret = regmap_update_bits(regmap, cinfo->regs[desc->ext_sel_idx],
+					 MT6363_EXT_PURES_MASK | MT6363_EXT_CHAN_MASK,
+					 ext_sel);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Get sampled value, then stop sampling unconditionally; the gathered
+	 * value is good regardless of if the ADC could be stopped.
+	 *
+	 * Note that if the ADC cannot be stopped but sampling was ok, this
+	 * function will not return any error, but will set the timed_out
+	 * status: this is not critical, as the ADC may auto recover and auto
+	 * stop after some time (depending on the PMIC model); if not, the next
+	 * read attempt will return -ETIMEDOUT and, for models that support it,
+	 * reset will be triggered.
+	 */
+	ret = mt6359_auxadc_sample_adc_val(adc_dev, chan, &val);
+
+	adc_stop_err = regmap_write(regmap, cinfo->regs[desc->req_idx], 0);
+	if (adc_stop_err) {
+		dev_warn(adc_dev->dev, "Could not stop the ADC: %d\n,", adc_stop_err);
+		adc_dev->timed_out = true;
+	}
+
+	/* If any sampling error occurred, the retrieved value is invalid */
 	if (ret)
 		return ret;
 
-	/* Stop sampling */
-	regmap_write(regmap, cinfo->regs[desc->req_idx], 0);
+	/* ...and deactivate the ADC GPIO if previously done */
+	if (desc->ext_sel_idx >= 0) {
+		ext_sel = FIELD_PREP(MT6363_EXT_PURES_MASK, MT6363_PULLUP_RES_OPEN);
+
+		ret = regmap_update_bits(regmap, cinfo->regs[desc->ext_sel_idx],
+					 MT6363_EXT_PURES_MASK, ext_sel);
+		if (ret)
+			return ret;
+	}
 
+	/* Everything went fine, give back the ADC reading */
 	*out = val & GENMASK(chan->scan_type.realbits - 1, 0);
 	return 0;
 }
@@ -522,9 +733,15 @@ static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
 	scoped_guard(mutex, &adc_dev->lock) {
 		switch (chan->scan_index) {
 		case PMIC_AUXADC_CHAN_IBAT:
+			if (!adc_dev->chip_info->read_imp)
+				return -EOPNOTSUPP;
+
 			ret = adc_dev->chip_info->read_imp(adc_dev, chan, NULL, val);
 			break;
 		case PMIC_AUXADC_CHAN_VBAT:
+			if (!adc_dev->chip_info->read_imp)
+				return -EOPNOTSUPP;
+
 			ret = adc_dev->chip_info->read_imp(adc_dev, chan, val, NULL);
 			break;
 		default:
@@ -559,15 +776,36 @@ static const struct iio_info mt6359_auxadc_iio_info = {
 
 static int mt6359_auxadc_probe(struct platform_device *pdev)
 {
+	const struct mtk_pmic_auxadc_info *chip_info;
 	struct device *dev = &pdev->dev;
-	struct device *mt6397_mfd_dev = dev->parent;
+	struct device *mfd_dev = dev->parent;
 	struct mt6359_auxadc *adc_dev;
 	struct iio_dev *indio_dev;
+	struct device *regmap_dev;
 	struct regmap *regmap;
 	int ret;
 
+	chip_info = device_get_match_data(dev);
+	if (!chip_info)
+		return -EINVAL;
+	/*
+	 * The regmap for this device has to be acquired differently for
+	 * SoC PMIC Wrapper and SPMI PMIC cases:
+	 *
+	 * If this is under SPMI, the regmap comes from the direct parent of
+	 * this driver: this_device->parent(mfd).
+	 *                            ... or ...
+	 * If this is under the SoC PMIC Wrapper, the regmap comes from the
+	 * parent of the MT6397 MFD: this_device->parent(mfd)->parent(pwrap)
+	 */
+	if (chip_info->is_spmi)
+		regmap_dev = mfd_dev;
+	else
+		regmap_dev = mfd_dev->parent;
+
+
 	/* Regmap is from SoC PMIC Wrapper, parent of the mt6397 MFD */
-	regmap = dev_get_regmap(mt6397_mfd_dev->parent, NULL);
+	regmap = dev_get_regmap(regmap_dev, NULL);
 	if (!regmap)
 		return dev_err_probe(dev, -ENODEV, "Failed to get regmap\n");
 
@@ -578,10 +816,7 @@ static int mt6359_auxadc_probe(struct platform_device *pdev)
 	adc_dev = iio_priv(indio_dev);
 	adc_dev->regmap = regmap;
 	adc_dev->dev = dev;
-
-	adc_dev->chip_info = device_get_match_data(dev);
-	if (!adc_dev->chip_info)
-		return -EINVAL;
+	adc_dev->chip_info = chip_info;
 
 	mutex_init(&adc_dev->lock);
 
@@ -604,6 +839,7 @@ static const struct of_device_id mt6359_auxadc_of_match[] = {
 	{ .compatible = "mediatek,mt6357-auxadc", .data = &mt6357_chip_info },
 	{ .compatible = "mediatek,mt6358-auxadc", .data = &mt6358_chip_info },
 	{ .compatible = "mediatek,mt6359-auxadc", .data = &mt6359_chip_info },
+	{ .compatible = "mediatek,mt6363-auxadc", .data = &mt6363_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mt6359_auxadc_of_match);
-- 
2.49.0


