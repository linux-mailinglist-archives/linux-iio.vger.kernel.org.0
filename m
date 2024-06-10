Return-Path: <linux-iio+bounces-6144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B9901EB2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B41F281A88
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AE17441A;
	Mon, 10 Jun 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5o63lwZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98449757EB;
	Mon, 10 Jun 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013694; cv=none; b=qUbSzzxPZ4rl/HU7HDzSBueDvjUeeql9xWJh+XI7fsZkrLk2f1mCRlBpgfYl47+1z9NAD2VN0QOwwaksrjYQCCUfr+9rEhYng/EmxfLVKqr+mHB0Fyv8Ynu1xcQ0j8uZ8WshpTp1KDlE23RBdX/gMibwL3pC6JzxmF26xEc6ElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013694; c=relaxed/simple;
	bh=Y6dF7X+ryoe3sbJPnfn6AtduznOg3+wYS8FSinR3mZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKCGNVFgyX8WV00GaWUF0WKOBimhIPqSfM+H0fuLJ05RlNc+/2QakFZ0PZTRDXFfS4WTFdL/Oi2xZ+O6VSY7yuLUGVoZ7tjtIVs8RxaiwYXrZ4OHnVml1VloYa8SBB+xSeZUPALbFdm8HQpvumV05MB+qRPXQSTrqaY3ExpliO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5o63lwZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso889081fa.0;
        Mon, 10 Jun 2024 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718013689; x=1718618489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk0ZKB4N8IwFdXrLRT6XeuO3e3tJLiQyjQiW2wIsaDE=;
        b=i5o63lwZxmhrYSXOHd/munY6R6/dujodWtentoy1TuF71xIZyY5ztVPUH//MesTWmG
         o4xImH0iFbIOUQM4J71hblrPK6vN/0ebfiXC/FfW9LXeJSerAMbCOHaIUzWE2aocQ5xU
         WgpxnnQn6NwXwRzIYVwCC+lPs43b6ODNf16z2qRCyfN26Lv40kevqagG4FLQ5MFOSVf9
         +ZFLlO4M4iyqiiFFXJJhpc8lxR0cVv2KOjPiCJ7W/qwsd4Le/k2Go4Nic2L8Ejts3qfZ
         VHyMWQ0L7AXDEEMum3Q1/MwCIOfhLhvp4yEWZBhQCql3kje0X/onLfuawPje5+tdR225
         5lZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013689; x=1718618489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk0ZKB4N8IwFdXrLRT6XeuO3e3tJLiQyjQiW2wIsaDE=;
        b=Dav/nRacWkCfAkL9TwM5nTgRbK8NG74/6Xvek5GF1oj40sShSX2gDgBIOLIZKIvShS
         dafweYAVMIFNA4MmuePQRQ0TYeTWJOrEI1dz/6XmaFNiuuVBmcfmmIYUzbNpL4qidz0a
         Xn6ylBHvnDD/krIYAV8aYY9/udOsrmfgfgN9FrJUWzJztt6OLWrOgFDfC8U+JzlXhqZi
         dSZa0sa2nOAkrQxUXxZRi1zUJzS3a0LVU2HBKbMB+HdIabja3plb5AsjtpW9sPGM9iat
         iD5ledIvJlyQC2POV4L49hTf3mw1mqPCEBD+rkNIn50zglM9nn3Xn8ZFRwcYc4W+lazH
         /jZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtvIfYw9uX7YnAWF3G1/AMfV0c4by8oXrMqd7x+oPKg63NwMvAcfPhHLfqyzQd5xq42IWLjVnlmzEpLHSR92ox42Elz6zuJgeBdcNFRR9jk4zP+Qlmg4p6+gOT3JATwuhxnmtyVj8X
X-Gm-Message-State: AOJu0YwThTK6b0Z6e86qpdR1NMmTUBT0RormRK0ZiX4IyJz0vuywcQ0q
	ZSItz+LuazSszAs7N3eAw6O0dqVQSTnjUoiNtz7ctVIFzP99G3AJmAt7gw==
X-Google-Smtp-Source: AGHT+IG6Ee1umvmRlcPX5gFChjbuO9vH50McvKkECMEYnfAD0stqAcGoCY2Y1MVdMZooQ6ELktCtlw==
X-Received: by 2002:a2e:9212:0:b0:2eb:e867:3eab with SMTP id 38308e7fff4ca-2ebe8673ecfmr11343121fa.25.1718013688643;
        Mon, 10 Jun 2024 03:01:28 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebeecf26c1sm521111fa.133.2024.06.10.03.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:01:27 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:01:23 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] bu27034: ROHM BU27034NUC to BU27034ANUC
Message-ID: <d43500621a2ad0811f58c8c7c87cbdc7b2abb8c1.1718013518.git.mazziesaccount@gmail.com>
References: <cover.1718013518.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n15hqPetZk+katb2"
Content-Disposition: inline
In-Reply-To: <cover.1718013518.git.mazziesaccount@gmail.com>


--n15hqPetZk+katb2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27034NUC was cancelled and BU27034ANUC is replacing this
sensor. Use the BU27034NUC driver to support the new BU27034ANUC.

According to ROHM, the BU27034NUC was never mass-produced. Hence dropping
the BU27034NUC support and using this driver to support BU27034ANUC
should not be a problem to users.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
---
 drivers/iio/light/rohm-bu27034.c | 321 +++++++------------------------
 1 file changed, 68 insertions(+), 253 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index bf3de853a811..51acad2cafbd 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * BU27034 ROHM Ambient Light Sensor
+ * BU27034ANUC ROHM Ambient Light Sensor
  *
  * Copyright (c) 2023, ROHM Semiconductor.
- * https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/b=
u27034nuc-e.pdf
  */
=20
 #include <linux/bitfield.h>
@@ -30,17 +29,15 @@
=20
 #define BU27034_REG_MODE_CONTROL2	0x42
 #define BU27034_MASK_D01_GAIN		GENMASK(7, 3)
-#define BU27034_MASK_D2_GAIN_HI		GENMASK(7, 6)
-#define BU27034_MASK_D2_GAIN_LO		GENMASK(2, 0)
=20
 #define BU27034_REG_MODE_CONTROL3	0x43
 #define BU27034_REG_MODE_CONTROL4	0x44
 #define BU27034_MASK_MEAS_EN		BIT(0)
 #define BU27034_MASK_VALID		BIT(7)
+#define BU27034_NUM_HW_DATA_CHANS	2
 #define BU27034_REG_DATA0_LO		0x50
 #define BU27034_REG_DATA1_LO		0x52
-#define BU27034_REG_DATA2_LO		0x54
-#define BU27034_REG_DATA2_HI		0x55
+#define BU27034_REG_DATA1_HI		0x53
 #define BU27034_REG_MANUFACTURER_ID	0x92
 #define BU27034_REG_MAX BU27034_REG_MANUFACTURER_ID
=20
@@ -88,58 +85,48 @@ enum {
 	BU27034_CHAN_ALS,
 	BU27034_CHAN_DATA0,
 	BU27034_CHAN_DATA1,
-	BU27034_CHAN_DATA2,
 	BU27034_NUM_CHANS
 };
=20
 static const unsigned long bu27034_scan_masks[] =3D {
-	GENMASK(BU27034_CHAN_DATA2, BU27034_CHAN_ALS), 0
+	GENMASK(BU27034_CHAN_DATA1, BU27034_CHAN_DATA0),
+	GENMASK(BU27034_CHAN_DATA1, BU27034_CHAN_ALS), 0
 };
=20
 /*
- * Available scales with gain 1x - 4096x, timings 55, 100, 200, 400 mS
+ * Available scales with gain 1x - 1024x, timings 55, 100, 200, 400 mS
  * Time impacts to gain: 1x, 2x, 4x, 8x.
  *
- * =3D> Max total gain is HWGAIN * gain by integration time (8 * 4096) =3D=
 32768
+ * =3D> Max total gain is HWGAIN * gain by integration time (8 * 1024) =3D=
 8192
+ * if 1x gain is scale 1, scale for 2x gain is 0.5, 4x =3D> 0.25,
+ * ... 8192x =3D> 0.0001220703125 =3D> 122070.3125 nanos
  *
- * Using NANO precision for scale we must use scale 64x corresponding gain=
 1x
- * to avoid precision loss. (32x would result scale 976 562.5(nanos).
+ * Using NANO precision for scale, we must use scale 16x corresponding gai=
n 1x
+ * to avoid precision loss. (8x would result scale 976 562.5(nanos).
  */
-#define BU27034_SCALE_1X	64
+#define BU27034_SCALE_1X	16
=20
 /* See the data sheet for the "Gain Setting" table */
 #define BU27034_GSEL_1X		0x00 /* 00000 */
 #define BU27034_GSEL_4X		0x08 /* 01000 */
-#define BU27034_GSEL_16X	0x0a /* 01010 */
 #define BU27034_GSEL_32X	0x0b /* 01011 */
-#define BU27034_GSEL_64X	0x0c /* 01100 */
 #define BU27034_GSEL_256X	0x18 /* 11000 */
 #define BU27034_GSEL_512X	0x19 /* 11001 */
 #define BU27034_GSEL_1024X	0x1a /* 11010 */
-#define BU27034_GSEL_2048X	0x1b /* 11011 */
-#define BU27034_GSEL_4096X	0x1c /* 11100 */
=20
 /* Available gain settings */
 static const struct iio_gain_sel_pair bu27034_gains[] =3D {
 	GAIN_SCALE_GAIN(1, BU27034_GSEL_1X),
 	GAIN_SCALE_GAIN(4, BU27034_GSEL_4X),
-	GAIN_SCALE_GAIN(16, BU27034_GSEL_16X),
 	GAIN_SCALE_GAIN(32, BU27034_GSEL_32X),
-	GAIN_SCALE_GAIN(64, BU27034_GSEL_64X),
 	GAIN_SCALE_GAIN(256, BU27034_GSEL_256X),
 	GAIN_SCALE_GAIN(512, BU27034_GSEL_512X),
 	GAIN_SCALE_GAIN(1024, BU27034_GSEL_1024X),
-	GAIN_SCALE_GAIN(2048, BU27034_GSEL_2048X),
-	GAIN_SCALE_GAIN(4096, BU27034_GSEL_4096X),
 };
=20
 /*
- * The IC has 5 modes for sampling time. 5 mS mode is exceptional as it li=
mits
- * the data collection to data0-channel only and cuts the supported range =
to
- * 10 bit. It is not supported by the driver.
- *
- * "normal" modes are 55, 100, 200 and 400 mS modes - which do have direct
- * multiplying impact to the register values (similar to gain).
+ * Measurement modes are 55, 100, 200 and 400 mS modes - which do have dir=
ect
+ * multiplying impact to the data register values (similar to gain).
  *
  * This means that if meas-mode is changed for example from 400 =3D> 200,
  * the scale is doubled. Eg, time impact to total gain is x1, x2, x4, x8.
@@ -156,11 +143,11 @@ static const struct iio_itime_sel_mul bu27034_itimes[=
] =3D {
 	GAIN_SCALE_ITIME_US(55000, BU27034_MEAS_MODE_55MS, 1),
 };
=20
-#define BU27034_CHAN_DATA(_name, _ch2)					\
+#define BU27034_CHAN_DATA(_name)					\
 {									\
 	.type =3D IIO_INTENSITY,						\
 	.channel =3D BU27034_CHAN_##_name,				\
-	.channel2 =3D (_ch2),						\
+	.channel2 =3D IIO_MOD_LIGHT_CLEAR,				\
 	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
 			      BIT(IIO_CHAN_INFO_SCALE),			\
 	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),	\
@@ -195,13 +182,12 @@ static const struct iio_chan_spec bu27034_channels[] =
=3D {
 	/*
 	 * The BU27034 DATA0 and DATA1 channels are both on the visible light
 	 * area (mostly). The data0 sensitivity peaks at 500nm, DATA1 at 600nm.
-	 * These wave lengths are pretty much on the border of colours making
-	 * these a poor candidates for R/G/B standardization. Hence they're both
-	 * marked as clear channels
+	 * These wave lengths are cyan(ish) and orange(ish), making these
+	 * sub-optiomal candidates for R/G/B standardization. Hence they're
+	 * both marked as clear channels.
 	 */
-	BU27034_CHAN_DATA(DATA0, IIO_MOD_LIGHT_CLEAR),
-	BU27034_CHAN_DATA(DATA1, IIO_MOD_LIGHT_CLEAR),
-	BU27034_CHAN_DATA(DATA2, IIO_MOD_LIGHT_IR),
+	BU27034_CHAN_DATA(DATA0),
+	BU27034_CHAN_DATA(DATA1),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
=20
@@ -215,20 +201,14 @@ struct bu27034_data {
 	struct mutex mutex;
 	struct iio_gts gts;
 	struct task_struct *task;
-	__le16 raw[3];
+	__le16 raw[BU27034_NUM_HW_DATA_CHANS];
 	struct {
 		u32 mlux;
-		__le16 channels[3];
+		__le16 channels[BU27034_NUM_HW_DATA_CHANS];
 		s64 ts __aligned(8);
 	} scan;
 };
=20
-struct bu27034_result {
-	u16 ch0;
-	u16 ch1;
-	u16 ch2;
-};
-
 static const struct regmap_range bu27034_volatile_ranges[] =3D {
 	{
 		.range_min =3D BU27034_REG_SYSTEM_CONTROL,
@@ -238,7 +218,7 @@ static const struct regmap_range bu27034_volatile_range=
s[] =3D {
 		.range_max =3D BU27034_REG_MODE_CONTROL4,
 	}, {
 		.range_min =3D BU27034_REG_DATA0_LO,
-		.range_max =3D BU27034_REG_DATA2_HI,
+		.range_max =3D BU27034_REG_DATA1_HI,
 	},
 };
=20
@@ -250,7 +230,7 @@ static const struct regmap_access_table bu27034_volatil=
e_regs =3D {
 static const struct regmap_range bu27034_read_only_ranges[] =3D {
 	{
 		.range_min =3D BU27034_REG_DATA0_LO,
-		.range_max =3D BU27034_REG_DATA2_HI,
+		.range_max =3D BU27034_REG_DATA1_HI,
 	}, {
 		.range_min =3D BU27034_REG_MANUFACTURER_ID,
 		.range_max =3D BU27034_REG_MANUFACTURER_ID,
@@ -281,39 +261,15 @@ static int bu27034_get_gain_sel(struct bu27034_data *=
data, int chan)
 {
 	int ret, val;
=20
-	switch (chan) {
-	case BU27034_CHAN_DATA0:
-	case BU27034_CHAN_DATA1:
-	{
-		int reg[] =3D {
-			[BU27034_CHAN_DATA0] =3D BU27034_REG_MODE_CONTROL2,
-			[BU27034_CHAN_DATA1] =3D BU27034_REG_MODE_CONTROL3,
-		};
-		ret =3D regmap_read(data->regmap, reg[chan], &val);
-		if (ret)
-			return ret;
-
-		return FIELD_GET(BU27034_MASK_D01_GAIN, val);
-	}
-	case BU27034_CHAN_DATA2:
-	{
-		int d2_lo_bits =3D fls(BU27034_MASK_D2_GAIN_LO);
-
-		ret =3D regmap_read(data->regmap, BU27034_REG_MODE_CONTROL2, &val);
-		if (ret)
-			return ret;
+	int reg[] =3D {
+		[BU27034_CHAN_DATA0] =3D BU27034_REG_MODE_CONTROL2,
+		[BU27034_CHAN_DATA1] =3D BU27034_REG_MODE_CONTROL3,
+	};
+	ret =3D regmap_read(data->regmap, reg[chan], &val);
+	if (ret)
+		return ret;
=20
-		/*
-		 * The data2 channel gain is composed by 5 non continuous bits
-		 * [7:6], [2:0]. Thus when we combine the 5-bit 'selector'
-		 * from register value we must right shift the high bits by 3.
-		 */
-		return FIELD_GET(BU27034_MASK_D2_GAIN_HI, val) << d2_lo_bits |
-		       FIELD_GET(BU27034_MASK_D2_GAIN_LO, val);
-	}
-	default:
-		return -EINVAL;
-	}
+	return FIELD_GET(BU27034_MASK_D01_GAIN, val);
 }
=20
 static int bu27034_get_gain(struct bu27034_data *data, int chan, int *gain)
@@ -396,44 +352,9 @@ static int bu27034_write_gain_sel(struct bu27034_data =
*data, int chan, int sel)
 	};
 	int mask, val;
=20
-	if (chan !=3D BU27034_CHAN_DATA0 && chan !=3D BU27034_CHAN_DATA1)
-		return -EINVAL;
-
 	val =3D FIELD_PREP(BU27034_MASK_D01_GAIN, sel);
-
 	mask =3D BU27034_MASK_D01_GAIN;
=20
-	if (chan =3D=3D BU27034_CHAN_DATA0) {
-		/*
-		 * We keep the same gain for channel 2 as we set for channel 0
-		 * We can't allow them to be individually controlled because
-		 * setting one will impact also the other. Also, if we don't
-		 * always update both gains we may result unsupported bit
-		 * combinations.
-		 *
-		 * This is not nice but this is yet another place where the
-		 * user space must be prepared to surprizes. Namely, see chan 2
-		 * gain changed when chan 0 gain is changed.
-		 *
-		 * This is not fatal for most users though. I don't expect the
-		 * channel 2 to be used in any generic cases - the intensity
-		 * values provided by the sensor for IR area are not openly
-		 * documented. Also, channel 2 is not used for visible light.
-		 *
-		 * So, if there is application which is written to utilize the
-		 * channel 2 - then it is probably specifically targeted to this
-		 * sensor and knows how to utilize those values. It is safe to
-		 * hope such user can also cope with the gain changes.
-		 */
-		mask |=3D  BU27034_MASK_D2_GAIN_LO;
-
-		/*
-		 * The D2 gain bits are directly the lowest bits of selector.
-		 * Just do add those bits to the value
-		 */
-		val |=3D sel & BU27034_MASK_D2_GAIN_LO;
-	}
-
 	return regmap_update_bits(data->regmap, reg[chan], mask, val);
 }
=20
@@ -441,13 +362,6 @@ static int bu27034_set_gain(struct bu27034_data *data,=
 int chan, int gain)
 {
 	int ret;
=20
-	/*
-	 * We don't allow setting channel 2 gain as it messes up the
-	 * gain for channel 0 - which shares the high bits
-	 */
-	if (chan !=3D BU27034_CHAN_DATA0 && chan !=3D BU27034_CHAN_DATA1)
-		return -EINVAL;
-
 	ret =3D iio_gts_find_sel_by_gain(&data->gts, gain);
 	if (ret < 0)
 		return ret;
@@ -571,9 +485,6 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
 	int ret, time_sel, gain_sel, i;
 	bool found =3D false;
=20
-	if (chan =3D=3D BU27034_CHAN_DATA2)
-		return -EINVAL;
-
 	if (chan =3D=3D BU27034_CHAN_ALS) {
 		if (val =3D=3D 0 && val2 =3D=3D 1000000)
 			return 0;
@@ -598,9 +509,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
=20
 		/*
 		 * Populate information for the other channel which should also
-		 * maintain the scale. (Due to the HW limitations the chan2
-		 * gets the same gain as chan0, so we only need to explicitly
-		 * set the chan 0 and 1).
+		 * maintain the scale.
 		 */
 		if (chan =3D=3D BU27034_CHAN_DATA0)
 			gain.chan =3D BU27034_CHAN_DATA1;
@@ -614,7 +523,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
 		/*
 		 * Iterate through all the times to see if we find one which
 		 * can support requested scale for requested channel, while
-		 * maintaining the scale for other channels
+		 * maintaining the scale for the other channel
 		 */
 		for (i =3D 0; i < data->gts.num_itime; i++) {
 			new_time_sel =3D data->gts.itime_table[i].sel;
@@ -629,7 +538,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
 			if (ret)
 				continue;
=20
-			/* Can the other channel(s) maintain scale? */
+			/* Can the other channel maintain scale? */
 			ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(
 				&data->gts, gain.old_gain, time_sel,
 				new_time_sel, &gain.new_gain);
@@ -641,7 +550,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
 		}
 		if (!found) {
 			dev_dbg(data->dev,
-				"Can't set scale maintaining other channels\n");
+				"Can't set scale maintaining other channel\n");
 			ret =3D -EINVAL;
=20
 			goto unlock_out;
@@ -665,102 +574,21 @@ static int bu27034_set_scale(struct bu27034_data *da=
ta, int chan,
 }
=20
 /*
- * for (D1/D0 < 0.87):
- * lx =3D 0.004521097 * D1 - 0.002663996 * D0 +
- *	0.00012213 * D1 * D1 / D0
- *
- * =3D>	115.7400832 * ch1 / gain1 / mt -
- *	68.1982976 * ch0 / gain0 / mt +
- *	0.00012213 * 25600 * (ch1 / gain1 / mt) * 25600 *
- *	(ch1 /gain1 / mt) / (25600 * ch0 / gain0 / mt)
+ * for (D1/D0 < 1.5):
+ *    lx =3D (0.001193 * D0 + (-0.0000747) * D1) * ((D1/D0 =E2=80=93 1.5) =
* (0.25) + 1)
  *
- * A =3D	0.00012213 * 25600 * (ch1 /gain1 / mt) * 25600 *
- *	(ch1 /gain1 / mt) / (25600 * ch0 / gain0 / mt)
- * =3D>	0.00012213 * 25600 * (ch1 /gain1 / mt) *
- *	(ch1 /gain1 / mt) / (ch0 / gain0 / mt)
- * =3D>	0.00012213 * 25600 * (ch1 / gain1) * (ch1 /gain1 / mt) /
- *	(ch0 / gain0)
- * =3D>	0.00012213 * 25600 * (ch1 / gain1) * (ch1 /gain1 / mt) *
- *	gain0 / ch0
- * =3D>	3.126528 * ch1 * ch1 * gain0 / gain1 / gain1 / mt /ch0
+ *    =3D> -0.000745625 * D0 + 0.0002515625 * D1 + -0.000018675 * D1 * D1 =
/ D0
  *
- * lx =3D (115.7400832 * ch1 / gain1 - 68.1982976 * ch0 / gain0) /
- *	mt + A
- * =3D>	(115.7400832 * ch1 / gain1 - 68.1982976 * ch0 / gain0) /
- *	mt + 3.126528 * ch1 * ch1 * gain0 / gain1 / gain1 / mt /
- *	ch0
+ *    =3D> (6.44 * ch1 / gain1 + 19.088 * ch0 / gain0 -
+ *       0.47808 * ch1 * ch1 * gain0 / gain1 / gain1 / ch0) /
+ *       mt
  *
- * =3D>	(115.7400832 * ch1 / gain1 - 68.1982976 * ch0 / gain0 +
- *	  3.126528 * ch1 * ch1 * gain0 / gain1 / gain1 / ch0) /
- *	  mt
+ * Else
+ *    lx =3D 0.001193 * D0 - 0.0000747 * D1
  *
- * For (0.87 <=3D D1/D0 < 1.00)
- * lx =3D (0.001331* D0 + 0.0000354 * D1) * ((D1/D0 =E2=80=93 0.87) * (0.3=
85) + 1)
- * =3D>	(0.001331 * 256 * 100 * ch0 / gain0 / mt + 0.0000354 * 256 *
- *	100 * ch1 / gain1 / mt) * ((D1/D0 -  0.87) * (0.385) + 1)
- * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	((D1/D0 -  0.87) * (0.385) + 1)
- * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	(0.385 * D1/D0 - 0.66505)
- * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	(0.385 * 256 * 100 * ch1 / gain1 / mt / (256 * 100 * ch0 / gain0 / mt) =
- 0.66505)
- * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	(9856 * ch1 / gain1 / mt / (25600 * ch0 / gain0 / mt) + 0.66505)
- * =3D>	13.118336 * ch1 / (gain1 * mt)
- *	+ 22.66064768 * ch0 / (gain0 * mt)
- *	+ 8931.90144 * ch1 * ch1 * gain0 /
- *	  (25600 * ch0 * gain1 * gain1 * mt)
- *	+ 0.602694912 * ch1 / (gain1 * mt)
- *
- * =3D>	[0.3489024 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1)
- *	 + 22.66064768 * ch0 / gain0
- *	 + 13.721030912 * ch1 / gain1
- *	] / mt
- *
- * For (D1/D0 >=3D 1.00)
- *
- * lx	=3D (0.001331* D0 + 0.0000354 * D1) * ((D1/D0 =E2=80=93 2.0) * (-0.0=
5) + 1)
- *	=3D> (0.001331* D0 + 0.0000354 * D1) * (-0.05D1/D0 + 1.1)
- *	=3D> (0.001331 * 256 * 100 * ch0 / gain0 / mt + 0.0000354 * 256 *
- *	   100 * ch1 / gain1 / mt) * (-0.05D1/D0 + 1.1)
- *	=3D> (34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	   (-0.05 * 256 * 100 * ch1 / gain1 / mt / (256 * 100 * ch0 / gain0 / m=
t) + 1.1)
- *	=3D> (34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	   (-1280 * ch1 / (gain1 * mt * 25600 * ch0 / gain0 / mt) + 1.1)
- *	=3D> (34.0736 * ch0 * -1280 * ch1 * gain0 * mt /( gain0 * mt * gain1 * =
mt * 25600 * ch0)
- *	    + 34.0736 * 1.1 * ch0 / (gain0 * mt)
- *	    + 0.90624 * ch1 * -1280 * ch1 *gain0 * mt / (gain1 * mt *gain1 * mt=
 * 25600 * ch0)
- *	    + 1.1 * 0.90624 * ch1 / (gain1 * mt)
- *	=3D> -43614.208 * ch1 / (gain1 * mt * 25600)
- *	    + 37.48096  ch0 / (gain0 * mt)
- *	    - 1159.9872 * ch1 * ch1 * gain0 / (gain1 * gain1 * mt * 25600 * ch0)
- *	    + 0.996864 ch1 / (gain1 * mt)
- *	=3D> [
- *		- 0.045312 * ch1 * ch1 * gain0 / (gain1 * gain1 * ch0)
- *		- 0.706816 * ch1 / gain1
- *		+ 37.48096  ch0 /gain0
- *	   ] * mt
- *
- *
- * So, the first case (D1/D0 < 0.87) can be computed to a form:
- *
- * lx =3D (3.126528 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
- *	 115.7400832 * ch1 / gain1 +
- *	-68.1982976 * ch0 / gain0
- *	 / mt
- *
- * Second case (0.87 <=3D D1/D0 < 1.00) goes to form:
- *
- *	=3D> [0.3489024 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
- *	    13.721030912 * ch1 / gain1 +
- *	    22.66064768 * ch0 / gain0
- *	   ] / mt
- *
- * Third case (D1/D0 >=3D 1.00) goes to form:
- *	=3D> [-0.045312 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
- *	    -0.706816 * ch1 / gain1 +
- *	    37.48096  ch0 /(gain0
- *	   ] / mt
+ *    =3D> (1.91232 * ch1 / gain1 + 30.5408 * ch0 / gain0 +
+ *        [0 * ch1 * ch1 * gain0 / gain1 / gain1 / ch0] ) /
+ *        mt
  *
  * This can be unified to format:
  * lx =3D [
@@ -770,19 +598,14 @@ static int bu27034_set_scale(struct bu27034_data *dat=
a, int chan,
  *	] / mt
  *
  * For case 1:
- * A =3D 3.126528,
- * B =3D 115.7400832
- * C =3D -68.1982976
+ * A =3D -0.47808,
+ * B =3D 6.44,
+ * C =3D 19.088
  *
  * For case 2:
- * A =3D 0.3489024
- * B =3D 13.721030912
- * C =3D 22.66064768
- *
- * For case 3:
- * A =3D -0.045312
- * B =3D -0.706816
- * C =3D 37.48096
+ * A =3D 0
+ * B =3D 1.91232
+ * C =3D 30.5408
  */
=20
 struct bu27034_lx_coeff {
@@ -887,21 +710,16 @@ static int bu27034_fixp_calc_lx(unsigned int ch0, uns=
igned int ch1,
 {
 	static const struct bu27034_lx_coeff coeff[] =3D {
 		{
-			.A =3D 31265280,		/* 3.126528 */
-			.B =3D 1157400832,	/*115.7400832 */
-			.C =3D 681982976,		/* -68.1982976 */
-			.is_neg =3D {false, false, true},
+			.A =3D 4780800,		/* -0.47808 */
+			.B =3D 64400000,		/*6.44 */
+			.C =3D 190880000,		/* 19.088 */
+			.is_neg =3D {true, false, false},
 		}, {
-			.A =3D 3489024,		/* 0.3489024 */
-			.B =3D 137210309,		/* 13.721030912 */
-			.C =3D 226606476,		/* 22.66064768 */
+			.A =3D 0,			/* 0 */
+			.B =3D 19123200,		/* 1.91232 */
+			.C =3D 305408000,		/* 30.5408 */
 			/* All terms positive */
-		}, {
-			.A =3D 453120,		/* -0.045312 */
-			.B =3D 7068160,		/* -0.706816 */
-			.C =3D 374809600,		/* 37.48096 */
-			.is_neg =3D {true, true, false},
-		}
+		},
 	};
 	const struct bu27034_lx_coeff *c =3D &coeff[coeff_idx];
 	u64 res =3D 0, terms[3];
@@ -973,7 +791,6 @@ static int bu27034_read_result(struct bu27034_data *dat=
a, int chan, int *res)
 	int reg[] =3D {
 		[BU27034_CHAN_DATA0] =3D BU27034_REG_DATA0_LO,
 		[BU27034_CHAN_DATA1] =3D BU27034_REG_DATA1_LO,
-		[BU27034_CHAN_DATA2] =3D BU27034_REG_DATA2_LO,
 	};
 	int valid, ret;
 	__le16 val;
@@ -1040,7 +857,7 @@ static int bu27034_get_single_result(struct bu27034_da=
ta *data, int chan,
 {
 	int ret;
=20
-	if (chan < BU27034_CHAN_DATA0 || chan > BU27034_CHAN_DATA2)
+	if (chan < BU27034_CHAN_DATA0 || chan > BU27034_CHAN_DATA1)
 		return -EINVAL;
=20
 	ret =3D bu27034_meas_set(data, true);
@@ -1065,12 +882,10 @@ static int bu27034_get_single_result(struct bu27034_=
data *data, int chan,
  * D1 =3D data1/ch1_gain/meas_time_ms * 25600
  *
  * Then:
- * if (D1/D0 < 0.87)
- *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 3.45 + 1)
- * else if (D1/D0 < 1)
- *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 0.385 + 1)
- * else
- *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 2) * -0.05 + 1)
+ * If (D1/D0 < 1.5)
+ *    lx =3D (0.001193 * D0 + (-0.0000747) * D1) * ((D1/D0 =E2=80=93 1.5) =
* (0.25) + 1)
+ * Else
+ *    lx =3D (0.001193* D0 + (-0.0000747) * D1)
  *
  * We use it here. Users who have for example some colored lens
  * need to modify the calculation but I hope this gives a starting point f=
or
@@ -1139,7 +954,7 @@ static int bu27034_calc_mlux(struct bu27034_data *data=
, __le16 *res, int *val)
=20
 static int bu27034_get_mlux(struct bu27034_data *data, int chan, int *val)
 {
-	__le16 res[3];
+	__le16 res[BU27034_NUM_HW_DATA_CHANS];
 	int ret;
=20
 	ret =3D bu27034_meas_set(data, true);
--=20
2.45.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--n15hqPetZk+katb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZmzvMACgkQeFA3/03a
ocXdSAgAqTanVLU8yD8xvGS+R4tWmyoIdYwEv5C+8/s3GHjAEV8K/FucFcqK9DGm
RFD+JfqZMjhbxOqKYcNfWGaBCOLe7YNrsOP97BqCZKf5NYq9SYJ9t0LuUcBeYq1b
Vko77ZBZrqsvOcXh6mZzH6TEWoUtrJpaY4tGUc/qZdYl3RkT9Qp8f3IZL8TVIbfN
P2I8E8DQzJLgg9brSLkWA1j3gZZhm1oZrL8K2HkXv0PaeH9b2heaNxseGxFe2Fmo
2/kQAPhCV0HubW3BVyL62mef++UCqKusrTllUKKvUgXCn50r9B7cFU5ExBuG1J5H
QKwEA++IxstzzBh6jrBwdz3JJfMnwQ==
=CF0q
-----END PGP SIGNATURE-----

--n15hqPetZk+katb2--

