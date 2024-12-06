Return-Path: <linux-iio+bounces-13147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370D9E6D0B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FDB16899A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7159E2010EC;
	Fri,  6 Dec 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XDNyaHnU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3D201246
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483655; cv=none; b=LaZl2v2twf1DbGNgN5Ki7BhLxWjkD1un/+rIWnEOIhES/wsHaGdsiB7s41DMl2vONMxTC7P5yuKGiwjIX3IfbsONuGbWg9usuxcxovRXm6ke05SsmEV+uaYAPYilP8JQ0bovZCft5wJxscMsyRsnj3HbyhyN5PpL6+uvkW3aaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483655; c=relaxed/simple;
	bh=wxZRPXX+wShOhw7KsuKigJkq79dPZO6Cla2zUo3+n2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/bWXA62tVxteVTTxVimSAVW7dNRK76hxn+llp+hV7x1BWTKmWNGtevPDdoofnUTIptwvEOMt3L3Cvg+3BtZ+ynpb2pfoKofM+nS8+0Kayc7v7YOJ1wyaNseDryQpXIk23+UOQhEKS7exkUs8XKZv6AefNFqpeusQDX2m6iWbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XDNyaHnU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d10f713ef0so5490120a12.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483652; x=1734088452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeWsRAgiOnQ9J+Bi5jRmNn74NPnMNokWHPaSe/KrAuI=;
        b=XDNyaHnUqoOeGNHVbu8DPm6yKi1PfeEfY+2ABhMwxpkcMqOv7aypGcIPBX/qG/YO2f
         eYF+w1gxf30Ey/RYGFwVbwlnJa+FsLtJjIksc+aWxrUXK06zIWT9073CPl00f7UqJitb
         eLA+Ftn6FnsD0bcHjTuR1aBQdL5Z+T3TTNbgJNFSz/kOhClSsu7REH662eFZJ677K4To
         EOXluF3CkoTGjUmPrp/cDlp8irN15BecyeE/EMXNpOT98Pz+mXrNmj2PaqApBPGo1tCG
         5yVF0r8hO6XYaD06DSYVHyLG8HSFVWK7beVehy8MEWUVbFUepR5zCYPhXzfjCxH9CHbi
         VH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483652; x=1734088452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeWsRAgiOnQ9J+Bi5jRmNn74NPnMNokWHPaSe/KrAuI=;
        b=qKlHZGzNB5sXc11TtUI3H5utlHi2IM0kc7aI0TCAQHik7ELOIyW6U33v3FYHNkh/bl
         Xg+PVEnkR4ge/j8XiIboYnLeyWO3WZn+qdc88kF+hzDd2bvpjDoBAbUYzylXtEKx67K7
         +5+cA7G6V3P58nIS8Y3Lq1ekRk6Mj2ke4Slu+XBH2QdHsbgBK3mSznwO5UsrzbYxD1pI
         BcwEDFbtnVJdV3gGgMBgqKZ9Y4usgMVAbEz8EIIkA9dH3aP4F/hVwSYnUXoVBX1I+3P1
         jOVgxCeRnAndxyiDH3NIRYukX1AxwxZR+XKmrS7SpQuJ7mV3fVTl02cdSh/ZY4Zvolxs
         R6dw==
X-Forwarded-Encrypted: i=1; AJvYcCXH+8uL4I4g6Yp+A66HAy/dblKTEP+7Zlved6WsXnxPjfJTl+K4e7Zz+sOVazc1DZ4Ux9cGhjlkLjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx90iZV+9n4ar+9MJDddbRUtnnSaYvDtXW/QWZNg5vnGUuHaBNp
	uz7vMLb5+OQOtZv20wCBnl8Jd4YFNVe1evmJ1zzd6z2e+lZ34pGYBEcXhd5wHMY=
X-Gm-Gg: ASbGncsWoPq621NdRfvvzwE5H1dRkVAbmfkEE+W3FlO0id8jn4MQSHCDDXPDLF3BA/X
	havSZnpU5TL9jTeAODwJhFVIIy4etvsUgc8BRELxB1d02jlHiqn1grAfgnIPDhiGCNoYxBows5Y
	SjKx3/OID97D0dvGXrlo3gZiEIrJ2A+8EwBkaJ8UN5iUuB56jAz8AiKwfoc/NT5kyepX3Lt8jKs
	TE5wlydDrXbZPfnoVSZVxOv8Gaq9OZwu6VYCTgDVYEvPan26jp2y9SThv8/or9sTaNXu8q8a7Oa
	VyWY
X-Google-Smtp-Source: AGHT+IHTQu8XnR/9fX757rUtPWhGNIBbj7HW1RmDso9os/gZdEm8EVXl76Iicy9Ae0iw5PO3pdZnrQ==
X-Received: by 2002:a17:907:2d0f:b0:aa5:ef1c:9dfc with SMTP id a640c23a62f3a-aa62032df68mr624741666b.8.1733483651596;
        Fri, 06 Dec 2024 03:14:11 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 10/15] iio: adc: rzg2l_adc: Add support for channel 8
Date: Fri,  6 Dec 2024 13:13:32 +0200
Message-Id: <20241206111337.726244-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The ADC on the Renesas RZ/G3S SoC includes an additional channel (channel
8) dedicated to reading temperature values from the Thermal Sensor Unit
(TSU). There is a direct in-SoC connection between the ADC and TSU IPs.

To read the temperature reported by the TSU, a different sampling rate
(compared to channels 0-7) must be configured in the ADM3 register.

The rzg2l_adc driver has been updated to support reading the TSU
temperature.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- adjusted the RZG2L_ADC_MAX_CHANNELS
- introduced rzg2l_adc_ch_to_adsmp_index() and used it accordingly
- made the IIO_TEMP channel as raw channel as requested in the
  review process. I also realized having it as scale channel is
  wrong as the ADC doesn't actually report a temperature but a
  raw value that is then converted to a temperature with the
  help of the TSU (Thermal Sensor Unit) driver. Code from the
  TSU driver (not yet published) that reads the TSU sensor through
  the ADC and coverts the raw value to a temperature value is as
  follows:


// ...

#define TSU_READ_STEPS		8

/* Default calibration values, if FUSE values are missing */
#define SW_CALIB0_VAL	1297
#define SW_CALIB1_VAL	751

#define MCELSIUS(temp)		(temp * MILLIDEGREE_PER_DEGREE)

struct rzg3s_thermal_priv {
	void __iomem *base;
	struct device *dev;
	struct thermal_zone_device *tz;
	struct reset_control *rstc;
	struct iio_channel *channel;
	u16 calib0;
	u16 calib1;
};

// ...

static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
{
	struct rzg3s_thermal_priv *priv = thermal_zone_device_priv(tz);
	struct device *dev = priv->dev;
	u32 ts_code_ave = 0;
	int ret, val;

	ret = pm_runtime_resume_and_get(dev);
	if (ret)
		return ret;

	for (u8 i = 0; i < TSU_READ_STEPS; i++) {
		ret = iio_read_channel_raw(priv->channel, &val);
		if (ret < 0)
			goto rpm_put;
		
		ts_code_ave += val;
		/*
		 * According to HW manual (section 40.4.4 Procedure for Measuring the Temperature)
		 * we need to wait here at leat 3us.
		 */
		usleep_range(5, 10);
	}

	ret = 0;
	ts_code_ave = DIV_ROUND_CLOSEST(ts_code_ave, TSU_READ_STEPS);

	/*
	 * According to HW manual (section 40.4.4 Procedure for Measuring the Temperature)
	 * the formula to compute the temperature is as follows;
	 *
	 * Tj = (ts_code_ave - priv->calib0) * (165 / (priv->calib0 - priv->calib1)) - 40
	 */
	*temp = DIV_ROUND_CLOSEST_ULL(((u64)(ts_code_ave - priv->calib1) * 165),
				      (priv->calib0 - priv->calib1)) - 40;

	/* Round it up to 0.5 degrees Celsius and report it in Mili Celsius. */
	*temp = roundup(MCELSIUS(*temp), 500);

rpm_put:
	pm_runtime_mark_last_busy(dev);
	pm_runtime_put_autosuspend(dev);

	return ret;
}

// ...


 drivers/iio/adc/rzg2l_adc.c | 62 ++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 6740912f83c5..e8dbc5dfbea1 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -52,12 +52,13 @@
 #define RZG2L_ADCR(n)			(0x30 + ((n) * 0x4))
 #define RZG2L_ADCR_AD_MASK		GENMASK(11, 0)
 
-#define RZG2L_ADC_MAX_CHANNELS		8
+#define RZG2L_ADC_MAX_CHANNELS		9
 #define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
 
 /**
  * struct rzg2l_adc_hw_params - ADC hardware specific parameters
- * @default_adsmp: default ADC sampling period (see ADM3 register)
+ * @default_adsmp: default ADC sampling period (see ADM3 register); index 0 is
+ * used for voltage channels, index 1 is used for temperature channel
  * @adsmp_mask: ADC sampling period mask (see ADM3 register)
  * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
  * @default_adcmp: default ADC cmp (see ADM3 register)
@@ -65,7 +66,7 @@
  * @adivc: specifies if ADVIC register is available
  */
 struct rzg2l_adc_hw_params {
-	u16 default_adsmp;
+	u16 default_adsmp[2];
 	u16 adsmp_mask;
 	u16 adint_inten_mask;
 	u8 default_adcmp;
@@ -89,15 +90,26 @@ struct rzg2l_adc {
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
 };
 
-static const char * const rzg2l_adc_channel_name[] = {
-	"adc0",
-	"adc1",
-	"adc2",
-	"adc3",
-	"adc4",
-	"adc5",
-	"adc6",
-	"adc7",
+/**
+ * struct rzg2l_adc_channel - ADC channel descriptor
+ * @name: ADC channel name
+ * @type: ADC channel type
+ */
+struct rzg2l_adc_channel {
+	const char * const name;
+	enum iio_chan_type type;
+};
+
+static const struct rzg2l_adc_channel rzg2l_adc_channels[] = {
+	{ "adc0", IIO_VOLTAGE },
+	{ "adc1", IIO_VOLTAGE },
+	{ "adc2", IIO_VOLTAGE },
+	{ "adc3", IIO_VOLTAGE },
+	{ "adc4", IIO_VOLTAGE },
+	{ "adc5", IIO_VOLTAGE },
+	{ "adc6", IIO_VOLTAGE },
+	{ "adc7", IIO_VOLTAGE },
+	{ "adc8", IIO_TEMP },
 };
 
 static unsigned int rzg2l_adc_readl(struct rzg2l_adc *adc, u32 reg)
@@ -163,9 +175,18 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(1), reg);
 }
 
+static u8 rzg2l_adc_ch_to_adsmp_index(u8 ch)
+{
+	if (rzg2l_adc_channels[ch].type == IIO_VOLTAGE)
+		return 0;
+
+	return 1;
+}
+
 static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 {
 	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
+	u8 index = rzg2l_adc_ch_to_adsmp_index(ch);
 	u32 reg;
 
 	if (rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_ADBSY)
@@ -179,6 +200,11 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 	reg |= BIT(ch);
 	rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
 
+	reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
+	reg &= ~hw_params->adsmp_mask;
+	reg |= hw_params->default_adsmp[index];
+	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
+
 	/*
 	 * Setup ADINT
 	 * INTS[31] - Select pulse signal
@@ -235,7 +261,7 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: {
-		if (chan->type != IIO_VOLTAGE)
+		if (chan->type != IIO_VOLTAGE && chan->type != IIO_TEMP)
 			return -EINVAL;
 
 		guard(mutex)(&adc->lock);
@@ -258,7 +284,7 @@ static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
 				const struct iio_chan_spec *chan,
 				char *label)
 {
-	return sysfs_emit(label, "%s\n", rzg2l_adc_channel_name[chan->channel]);
+	return sysfs_emit(label, "%s\n", rzg2l_adc_channels[chan->channel].name);
 }
 
 static const struct iio_info rzg2l_adc_iio_info = {
@@ -332,11 +358,11 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		if (channel >= hw_params->num_channels)
 			return -EINVAL;
 
-		chan_array[i].type = IIO_VOLTAGE;
+		chan_array[i].type = rzg2l_adc_channels[channel].type;
 		chan_array[i].indexed = 1;
 		chan_array[i].channel = channel;
 		chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
-		chan_array[i].datasheet_name = rzg2l_adc_channel_name[channel];
+		chan_array[i].datasheet_name = rzg2l_adc_channels[channel].name;
 		i++;
 	}
 
@@ -386,7 +412,7 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	reg &= ~RZG2L_ADM3_ADCMP_MASK;
 	reg &= ~hw_params->adsmp_mask;
 	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
-	       hw_params->default_adsmp;
+	       hw_params->default_adsmp[0];
 
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
@@ -469,7 +495,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
 	.num_channels = 8,
 	.default_adcmp = 0xe,
-	.default_adsmp = 0x578,
+	.default_adsmp = { 0x578 },
 	.adsmp_mask = GENMASK(15, 0),
 	.adint_inten_mask = GENMASK(7, 0),
 	.adivc = true
-- 
2.39.2


