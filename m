Return-Path: <linux-iio+bounces-7353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B7E92873D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9112851A6
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869AB149E13;
	Fri,  5 Jul 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSzMYHPT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3114A097;
	Fri,  5 Jul 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176913; cv=none; b=AE9oC1NNOiMQvkwRbCFBDfd/Zsvfxb7WuI09OuJ0DNNDv0Thw5HFOOd4mU9F8nEl8pokO4j17YuqMdmjI6iYv06p5qT2PRCsVIcctarvFJAP3c/agy2hJz4/DLu8j1mB4nflobVwnVSJKa1q18jE3Xt4eNYloN9FhVToyApmO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176913; c=relaxed/simple;
	bh=HI+sQcyToYP3AHzvRgs7ALxEDV5Q8tjimOtKlODEuLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoFQMCbdoIvXRageGywBk4XaxrMjhciAWRT+/loS1TWk4e1QraIHyio7kgw69aCvmXD6aJApNtlid8VE9AJ5zmyfYiaNrrlnpOIbL0XPDLIOIKHPakjm/Tnmk6U7HBZdoCkllj3yI+we2iFiazdqawSf5Pl6PwylwuaSLzpi3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSzMYHPT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee98947f70so1232281fa.1;
        Fri, 05 Jul 2024 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176910; x=1720781710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9fwtvcdlweMGd2QiElI8TeM324PEzcDKDnI9f687yxY=;
        b=kSzMYHPTToyllg64Ffq+fPFnKzqvDTXMVw1EiFfo+VWQV6Pai70w1n0YGEF/DeHm9J
         YccFd0jb5I4OdklksWw4pA1Z2mEAua5QPmHGomMoUPBF8iVOlyY4CcEvPH80rWTsRVfq
         bGWjG12lcWVx/eMARmqEezZ6ddji7GOv1d/e9Cx9NQLNpIdJLCU58tXJToDJcvrfsDiB
         kiAy/A5uD29AUTMa1j8ept1fkCoJJ017b7uzPHEPiLT4tWEaDtbEef3R4tLbhk4J8iEq
         C64qQufEM7XVC4MS3qqBEfAO5UYxlfmig+mTnIh2KrJV+YYyWZ1ga/A+haAWBJj/bxjk
         eVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176910; x=1720781710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fwtvcdlweMGd2QiElI8TeM324PEzcDKDnI9f687yxY=;
        b=RlV+WhuVXF5lxL1irtVnZMQnqhZLX1Fht35dJBUViNT1c5p9Z5GGpdHmUkExcfk2Qz
         m8WvAtB0zunLUECqoDx+c25JCfGNjCFkJIajb1ZdE6T62kvT6mawLqYVo0/hhDQFBCmf
         +pVBDhX7If6sqc+own1C7oJnHY8pxqxpVgdlBiVknHY2+6jqA2knvNagKoRGlz9RrVkB
         VnglKJsQQilC/jijn+wgxR0rQXJ4SIxWfk/pB6i1oPWPQ072NXl80uqo0oZg1gpDr4rJ
         t3Qa0WAuzYkyhEXqsPRmjDx8iDxt6n4QPGvGA8l8syTZKpCLNfxXjhE00Tvc6f6ut442
         iTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJJubnPnOMbQnvApM9dgn8PoKMrtbJQF/zRmnE4CsQeUQHhe4IvesFr+2mw992vj3X3nSqVcryjR1T3yPAUEASUxW7LMT/lKApOVJSzExy4uaXhgVYqmAe/4Hvhx2BoRJQ2Gwv0z3YkZIXXkvc2zh3KyqemfZFGF+nvYTx98v39K6F0g==
X-Gm-Message-State: AOJu0YwPpYLvV8WKeDgUmVILw2Imdxlj0i6sw6XBxDlCc5yyPN9hhYPH
	jtlKFaPt6A3kiOBllSm5ycBFIHUOuyiSocFfd9W4+DqHcUm2Rn/h
X-Google-Smtp-Source: AGHT+IFmQqi9ZfmaKxDU4qnmIDKXCPS7LX8lggs+yNIXNA/gNYpjq+MLZy2rIK9L4yoAycfGv1JT4Q==
X-Received: by 2002:a2e:300e:0:b0:2ee:8b5d:715f with SMTP id 38308e7fff4ca-2ee8ee13ef6mr22227331fa.45.1720176908881;
        Fri, 05 Jul 2024 03:55:08 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee516803c4sm26618861fa.93.2024.07.05.03.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:55:08 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:55:03 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] bu27034: ROHM BU27034NUC to BU27034ANUC drop data2
Message-ID: <6f261d4499e9c0e161279717261cc9a20764a6bd.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vPWVIUugZIyCLoDV"
Content-Disposition: inline
In-Reply-To: <cover.1720176341.git.mazziesaccount@gmail.com>


--vPWVIUugZIyCLoDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27034NUC was cancelled and BU27034ANUC is replacing this
sensor. The BU27034ANUC does not have the data2 channel.

Drop the data2 channel.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - patch splitted
 - fixed empty lines in bu27034_get_gain_sel()
---
 drivers/iio/light/rohm-bu27034.c | 138 +++++++------------------------
 1 file changed, 28 insertions(+), 110 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index f876bb21ffa5..86b8771caff0 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -29,17 +29,15 @@
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
@@ -87,12 +85,12 @@ enum {
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
@@ -155,11 +153,10 @@ static const struct iio_itime_sel_mul bu27034_itimes[=
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
 	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
 			      BIT(IIO_CHAN_INFO_SCALE),			\
 	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),	\
@@ -194,13 +191,12 @@ static const struct iio_chan_spec bu27034_channels[] =
=3D {
 	/*
 	 * The BU27034 DATA0 and DATA1 channels are both on the visible light
 	 * area (mostly). The data0 sensitivity peaks at 500nm, DATA1 at 600nm.
-	 * These wave lengths are pretty much on the border of colours making
-	 * these a poor candidates for R/G/B standardization. Hence they're both
-	 * marked as clear channels
+	 * These wave lengths are cyan(ish) and orange(ish), making these
+	 * sub-optiomal candidates for R/G/B standardization. Hence the
+	 * colour modifier is omitted.
 	 */
-	BU27034_CHAN_DATA(DATA0, IIO_MOD_LIGHT_CLEAR),
-	BU27034_CHAN_DATA(DATA1, IIO_MOD_LIGHT_CLEAR),
-	BU27034_CHAN_DATA(DATA2, IIO_MOD_LIGHT_IR),
+	BU27034_CHAN_DATA(DATA0),
+	BU27034_CHAN_DATA(DATA1),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
=20
@@ -214,20 +210,14 @@ struct bu27034_data {
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
@@ -237,7 +227,7 @@ static const struct regmap_range bu27034_volatile_range=
s[] =3D {
 		.range_max =3D BU27034_REG_MODE_CONTROL4,
 	}, {
 		.range_min =3D BU27034_REG_DATA0_LO,
-		.range_max =3D BU27034_REG_DATA2_HI,
+		.range_max =3D BU27034_REG_DATA1_HI,
 	},
 };
=20
@@ -249,7 +239,7 @@ static const struct regmap_access_table bu27034_volatil=
e_regs =3D {
 static const struct regmap_range bu27034_read_only_ranges[] =3D {
 	{
 		.range_min =3D BU27034_REG_DATA0_LO,
-		.range_max =3D BU27034_REG_DATA2_HI,
+		.range_max =3D BU27034_REG_DATA1_HI,
 	}, {
 		.range_min =3D BU27034_REG_MANUFACTURER_ID,
 		.range_max =3D BU27034_REG_MANUFACTURER_ID,
@@ -278,41 +268,17 @@ struct bu27034_gain_check {
=20
 static int bu27034_get_gain_sel(struct bu27034_data *data, int chan)
 {
+	int reg[] =3D {
+		[BU27034_CHAN_DATA0] =3D BU27034_REG_MODE_CONTROL2,
+		[BU27034_CHAN_DATA1] =3D BU27034_REG_MODE_CONTROL3,
+	};
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
@@ -395,44 +361,9 @@ static int bu27034_write_gain_sel(struct bu27034_data =
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
@@ -440,13 +371,6 @@ static int bu27034_set_gain(struct bu27034_data *data,=
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
@@ -570,9 +494,6 @@ static int bu27034_set_scale(struct bu27034_data *data,=
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
@@ -597,9 +518,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
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
@@ -613,7 +532,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
 		/*
 		 * Iterate through all the times to see if we find one which
 		 * can support requested scale for requested channel, while
-		 * maintaining the scale for other channels
+		 * maintaining the scale for the other channel
 		 */
 		for (i =3D 0; i < data->gts.num_itime; i++) {
 			new_time_sel =3D data->gts.itime_table[i].sel;
@@ -628,7 +547,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
 			if (ret)
 				continue;
=20
-			/* Can the other channel(s) maintain scale? */
+			/* Can the other channel maintain scale? */
 			ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(
 				&data->gts, gain.old_gain, time_sel,
 				new_time_sel, &gain.new_gain);
@@ -640,7 +559,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
 		}
 		if (!found) {
 			dev_dbg(data->dev,
-				"Can't set scale maintaining other channels\n");
+				"Can't set scale maintaining other channel\n");
 			ret =3D -EINVAL;
=20
 			goto unlock_out;
@@ -972,7 +891,6 @@ static int bu27034_read_result(struct bu27034_data *dat=
a, int chan, int *res)
 	int reg[] =3D {
 		[BU27034_CHAN_DATA0] =3D BU27034_REG_DATA0_LO,
 		[BU27034_CHAN_DATA1] =3D BU27034_REG_DATA1_LO,
-		[BU27034_CHAN_DATA2] =3D BU27034_REG_DATA2_LO,
 	};
 	int valid, ret;
 	__le16 val;
@@ -1039,7 +957,7 @@ static int bu27034_get_single_result(struct bu27034_da=
ta *data, int chan,
 {
 	int ret;
=20
-	if (chan < BU27034_CHAN_DATA0 || chan > BU27034_CHAN_DATA2)
+	if (chan < BU27034_CHAN_DATA0 || chan > BU27034_CHAN_DATA1)
 		return -EINVAL;
=20
 	ret =3D bu27034_meas_set(data, true);
@@ -1138,7 +1056,7 @@ static int bu27034_calc_mlux(struct bu27034_data *dat=
a, __le16 *res, int *val)
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

--vPWVIUugZIyCLoDV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaH0QcACgkQeFA3/03a
ocU+gQf/ez3i4ZjTURsDW+AhkGceaQGeUN9z6LY+Mpk9RavyXIsQLwh4h6bTfEzo
w0x32lgU7Eci4U9kY10UucV7322YQvdkxZ5RsrOnrBxdgWWur0lqFq99R2W4nWeg
vDAeBfquH8/m0QLDoBGvuarnsKA4/Ktgf0inmIbxC4oWKDkQ1s+8JO4wsXJHJQgO
S26Pc6/tzyr1SSRCJi16hyQgIfbbduy9kPGLpgehkJreZOWqhm8M/3m4mby/hB7U
1idgpbcwZqO9z0B4lD2r/x0Pu1Mlctspl7uVfG8wqXaYlEs1rWCwUOcO47bXdFmj
KdI7ksF78KXxGO3Yitjh8WJ2Xllorg==
=rv2Y
-----END PGP SIGNATURE-----

--vPWVIUugZIyCLoDV--

