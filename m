Return-Path: <linux-iio+bounces-19411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3AFAB259F
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 00:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49A17A792A
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F6214A81;
	Sat, 10 May 2025 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X74CRg6O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE963212FB0;
	Sat, 10 May 2025 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746917081; cv=none; b=lB0bkIPC48FLt7feCYE96qTjO+MdNlWBt8fOLhgZVS4/iaD0fUg4kQGkQYhEfdUww/+psnS9WJckzE/7TwQZQRhBS62hzxj3pb+Vi8NHzlOSwqNOoEyicGparan+bDgWV+bwUah+NruGDX3Mp8fR0yeby3Ro1Z0aJM/cED+i4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746917081; c=relaxed/simple;
	bh=pHpPP/AAF2ZJnFibnFDEHJ3e1IW13uLT58acUXO49WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4qpenkMIjna3uOweZ2NXMFakZiVkxQ9vhnSKnz9fEKmcV5ZnvmG+PitND5nnv28HsfVUwh93LFyU8wruTVqtyHTMH3Lg2DSLlq0s11+XKwWyF72BBWngwZOR8j/19+nnnT64ofcj2TbHoL15Y2Ptmvd5T5GKrqZNgwB46IArVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X74CRg6O; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d72b749dcso3839235e9.1;
        Sat, 10 May 2025 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746917078; x=1747521878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIqO0nvCoKmouswT3ks4gDpudOxCgK+0lldLLrbYLPE=;
        b=X74CRg6OrqtV+kbIVpDE3zud91l6bbkPF9gtOPSuluofzXndcuTgBWOGx1u9EPpxub
         C8LWD8KO2bjq5QHVYUUPOMlCL+KSl64wKnGyqbmcmgY2fGSym86UyK4nfz9xikraoSN2
         nl8bcHZAD/Kr+0PDqse6lmVAWCl0vUoBxuKxvR44STBNVpebl36pJTI5fR85V18ag/Qf
         gVZlApe5KFcsZAH0FKDGCf7hZaMyv4+HsdjHy13Xat8tksSi82UIfnnNRFl95GAc1F/Y
         TJW/U1Jfd1t0WWUrdEwnoqdusgpM83S+NfifNqEpoEiYitXScsJkmSG8Di3OvxAIOO6G
         Ar0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746917078; x=1747521878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIqO0nvCoKmouswT3ks4gDpudOxCgK+0lldLLrbYLPE=;
        b=Yd9KxFjjzY5XNg/HdF8uTkNLIi91nAWXuVrn6+jH+MbD1j0uNIxyQN1PhJwPeLmKhh
         UjI5CtHRr4rY5we3lMSciyhqceG0vq6GVux2dLfuxb9qMSZ8Lj5SFo6/RjyTmFtMNtlR
         J83HAY/0UwUMuyKL9OOQLbV9E2EqGchKijtpUGMjko3zVxFXoHI/utzFZ+oWPAVtl7j6
         So3Vodw9mImogyLVrwxPN+QvvQHY0gIqRmxPrW4NQGVbD3270q2DA73qEbWzZmha/39b
         XDhyzww6p4qybk4NlBrQJJ3JIOLmfTdQsYXdzmJ1jB6KyoZzMaMSwGUH9VVse5Iq7Jar
         WQKA==
X-Forwarded-Encrypted: i=1; AJvYcCUS3dHeAFbOsMhOl3uHtWLMW0NBvmHG1Zyya1X7I5TwVZ8YBDJncBNUrBzFUNnK63oSQxNymL0NfyXm5w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UcnLvCOO0CjVEc9iRDGaK0/pTF+Qg/dFNF+VUYz8vDUmCmJF
	luiMxQBQmpdRkXQKBPW5aQ4iHZ60uKsIfMiCDiaA5iBwpTX55Oue
X-Gm-Gg: ASbGnctlrFSE8lcEEb4PQSVjY8/leNP5ZzsqRO82riYpDx2VC/GMQv+sOm7xqpiBU2w
	JXVe55ebkuqmL72xrIX4H4PbeBlf0fUkxSWo1LZJH03bd2PKUzixdQAGNAgVWRPzzc8bdjSA/gx
	j7W89IK4ACyF3zLg5Few8x/PdZqBaHudV4LySBzFFZ18mlmqz8wAHVGVXNOUzOTGPT+YSCfZne/
	iVADQgHNekoDXWImbHdlewNOVeiUla9qpSEMeSF7sKh0Mrct5H16Vuj1ck2GeHuMoV54K4JW3kJ
	DkGuWN1UaglZMPGNYWQKTm1P5TCDatgobUr1/c9IsIGPy/tYPVY1BjJvRLdrOyXyoFjK8uD+/M9
	f9mYSUix7kF9ElEbcqj4K7A==
X-Google-Smtp-Source: AGHT+IHhH4kcGqYt31UC3pP6Z93GHyZ4oNNc8k+nZWObK1c9DshfUZL6xAgGKi+T6otxhBJw3Qad2g==
X-Received: by 2002:a5d:64cd:0:b0:3a0:9188:ef58 with SMTP id ffacd0b85a97d-3a1f64ab2e7mr2473442f8f.14.1746917077834;
        Sat, 10 May 2025 15:44:37 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm7701015f8f.55.2025.05.10.15.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:44:37 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 1/7] iio: accel: adxl345: extend sample frequency adjustments
Date: Sat, 10 May 2025 22:43:59 +0000
Message-Id: <20250510224405.17910-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250510224405.17910-1-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce enums and functions to work with the sample frequency
adjustments. Let the sample frequency adjust via IIO and configure
a reasonable default.

Replace the old static sample frequency handling. During adjustment of
bw registers, measuring is disabled and afterwards enabled again.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |   2 +-
 drivers/iio/accel/adxl345_core.c | 150 ++++++++++++++++++++++++-------
 2 files changed, 118 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 7d482dd595fa..6c1f96406136 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -69,7 +69,7 @@
  * BW_RATE bits - Bandwidth and output data rate. The default value is
  * 0x0A, which translates to a 100 Hz output data rate
  */
-#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_RATE_MSK		GENMASK(3, 0)
 #define ADXL345_BW_LOW_POWER		BIT(4)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c464c87033fb..bbdc9d10d962 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -64,6 +64,45 @@ static const unsigned int adxl345_tap_time_reg[] = {
 	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
 };
 
+enum adxl345_odr {
+	ADXL345_ODR_0P10HZ = 0,
+	ADXL345_ODR_0P20HZ,
+	ADXL345_ODR_0P39HZ,
+	ADXL345_ODR_0P78HZ,
+	ADXL345_ODR_1P56HZ,
+	ADXL345_ODR_3P13HZ,
+	ADXL345_ODR_6P25HZ,
+	ADXL345_ODR_12P50HZ,
+	ADXL345_ODR_25HZ,
+	ADXL345_ODR_50HZ,
+	ADXL345_ODR_100HZ,
+	ADXL345_ODR_200HZ,
+	ADXL345_ODR_400HZ,
+	ADXL345_ODR_800HZ,
+	ADXL345_ODR_1600HZ,
+	ADXL345_ODR_3200HZ,
+};
+
+/* Certain features recommend 12.5 Hz - 400 Hz ODR */
+static const int adxl345_odr_tbl[][2] = {
+	[ADXL345_ODR_0P10HZ]	= {    0,  97000 },
+	[ADXL345_ODR_0P20HZ]	= {    0, 195000 },
+	[ADXL345_ODR_0P39HZ]	= {    0, 390000 },
+	[ADXL345_ODR_0P78HZ]	= {    0, 781000 },
+	[ADXL345_ODR_1P56HZ]	= {    1, 562000 },
+	[ADXL345_ODR_3P13HZ]	= {    3, 125000 },
+	[ADXL345_ODR_6P25HZ]	= {    6, 250000 },
+	[ADXL345_ODR_12P50HZ]	= {   12, 500000 },
+	[ADXL345_ODR_25HZ]	= {   25, 0 },
+	[ADXL345_ODR_50HZ]	= {   50, 0 },
+	[ADXL345_ODR_100HZ]	= {  100, 0 },
+	[ADXL345_ODR_200HZ]	= {  200, 0 },
+	[ADXL345_ODR_400HZ]	= {  400, 0 },
+	[ADXL345_ODR_800HZ]	= {  800, 0 },
+	[ADXL345_ODR_1600HZ]	= { 1600, 0 },
+	[ADXL345_ODR_3200HZ]	= { 3200, 0 },
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -107,6 +146,7 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -383,14 +423,53 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
 	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
 }
 
+static int adxl345_find_odr(struct adxl345_state *st, int val,
+			    int val2, enum adxl345_odr *odr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(adxl345_odr_tbl); i++) {
+		if (val == adxl345_odr_tbl[i][0] &&
+		    val2 == adxl345_odr_tbl[i][1]) {
+			*odr = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
+{
+	return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
+				 ADXL345_BW_RATE_MSK,
+				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
+}
+
+static int adxl345_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type,
+			      int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)adxl345_odr_tbl;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(adxl345_odr_tbl) * 2;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
 	__le16 accel;
-	long long samp_freq_nhz;
 	unsigned int regval;
+	enum adxl345_odr odr;
 	int ret;
 
 	switch (mask) {
@@ -428,12 +507,10 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
 		if (ret)
 			return ret;
-
-		samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
-				(regval & ADXL345_BW_RATE);
-		*val = div_s64_rem(samp_freq_nhz, NANOHZ_PER_HZ, val2);
-
-		return IIO_VAL_INT_PLUS_NANO;
+		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
+		*val = adxl345_odr_tbl[odr][0];
+		*val2 = adxl345_odr_tbl[odr][1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
 	return -EINVAL;
@@ -444,7 +521,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	s64 n;
+	enum adxl345_odr odr;
+	int ret;
+
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -452,20 +534,26 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
 		 * factor
 		 */
-		return regmap_write(st->regmap,
-				    ADXL345_REG_OFS_AXIS(chan->address),
-				    val / 4);
+		ret = regmap_write(st->regmap,
+				   ADXL345_REG_OFS_AXIS(chan->address),
+				   val / 4);
+		if (ret)
+			return ret;
+		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		n = div_s64(val * NANOHZ_PER_HZ + val2,
-			    ADXL345_BASE_RATE_NANO_HZ);
+		ret = adxl345_find_odr(st, val, val2, &odr);
+		if (ret)
+			return ret;
 
-		return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
-					  ADXL345_BW_RATE,
-					  clamp_val(ilog2(n), 0,
-						    ADXL345_BW_RATE));
+		ret = adxl345_set_odr(st, odr);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	return -EINVAL;
+	return adxl345_set_measure_en(st, true);
 }
 
 static int adxl345_read_event_config(struct iio_dev *indio_dev,
@@ -654,7 +742,7 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -667,19 +755,6 @@ static void adxl345_powerdown(void *ptr)
 	adxl345_set_measure_en(st, false);
 }
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
-"0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
-);
-
-static struct attribute *adxl345_attrs[] = {
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group adxl345_attrs_group = {
-	.attrs = adxl345_attrs,
-};
-
 static int adxl345_set_fifo(struct adxl345_state *st)
 {
 	unsigned int intio;
@@ -931,9 +1006,9 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 }
 
 static const struct iio_info adxl345_info = {
-	.attrs		= &adxl345_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
+	.read_avail	= adxl345_read_avail,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 	.read_event_config = adxl345_read_event_config,
 	.write_event_config = adxl345_write_event_config,
@@ -999,6 +1074,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 	indio_dev->available_scan_masks = adxl345_scan_masks;
 
+	/*
+	 * Using I2C at 100kHz would limit the maximum ODR to 200Hz, operation
+	 * at an output rate above the recommended maximum may result in
+	 * undesired behavior.
+	 */
+	ret = adxl345_set_odr(st, ADXL345_ODR_200HZ);
+	if (ret)
+		return ret;
+
 	/* Reset interrupts at start up */
 	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
 	if (ret)
-- 
2.39.5


