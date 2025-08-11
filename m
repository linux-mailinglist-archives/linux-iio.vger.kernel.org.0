Return-Path: <linux-iio+bounces-22544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4DCB2023E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873ED189FB7E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB6D2DCBE0;
	Mon, 11 Aug 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdDuIyIc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DF2DC342;
	Mon, 11 Aug 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902249; cv=none; b=PmNbm7af2TTdyMFrR8AFkG3P7/jSPM8I/MdrZ4a2q4BFoeRhTaq3sBkCAzNKn0J3zwvqaX+nHTajR6NXf03HIQhNeorvK3ynrjxM21OqwGr26WTNF8IFsAxMfS/jMHI/YQ5/DmtWAcsN3BDDCFmU/r/aGdKKC6hoNDPX7W4T8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902249; c=relaxed/simple;
	bh=B46hppQeK1lIKIJYubQ57oe3Qk6/PIsnE0NKeW8G9ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAHJvgYjx9QDSOSWHT/tPR38i/nQ941NDFw6uaUzdj4Mg+dlQ7ikkX2T+MWUvquhNgfogEEeXu+ZmRNH8toDkEosMjr1b7s1vkXbE17c+wBEuZgI8T6MpLgRb9ehP9dZrF+VaIhW4aspLztKFaM7j3G86RRrLaxqqHp+mMTJr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdDuIyIc; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-33253a73769so33059891fa.3;
        Mon, 11 Aug 2025 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902246; x=1755507046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mu3YSTmQBEzx4wE3yLemm216yEBM36j9lnSYVQfOsz8=;
        b=EdDuIyIcIyNoVGNV6swy0q8GHevKUdh5f0vJRzL0R7LgD5pNk7w/GzAe2VOIFOAMpM
         PubFtIns3u/YDfMyzhkCOkQjleUDmCbWaFbxk+uc5vlzFu3MYJTq4X09PpRJefPR2VfX
         w5K9v02Xsr+H38TCXhgzPRzgIR5LOMh3dBmfvA5j/2i1NF8Guwl5yDe7qEMnV9qt/Y40
         sBvml//EYsChKT16HFcoycVb/J/l6rIsg9lCUK8vJ6wqSk2x4qVu/o4eIeMF0bIslMCT
         p0FGOgoTUm2Ky3mU4p9GIf1R2mrF0KvO2nuWpKfJJi96Alwp/uO44UE6jM+660w03E3b
         fTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902246; x=1755507046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu3YSTmQBEzx4wE3yLemm216yEBM36j9lnSYVQfOsz8=;
        b=TYgs3VisQ+5CLepdAlGqU2liHYKLOuD2dgv5kzGkU/JNWoyGAQZwB5J5QPplaCWIUj
         bL7T/EgeqZOcNa3JHbujBCLvAUbNsKnX7gtiUf+MkCFGZxWF1Pg/XH/bPOVgXlmb0lhf
         TbYeYDhAQ+m6/kcXRdc7dBm7sWIPhfyc7jMqKj6krpTX6DUeS4TVaAJJyys9dkRBISM1
         7W6sXFR1cgPDmwAr1BHg97vAjWRSCB2x6r2/R/9JP+3Y9QnvxJffDltmG2Jf/I+CqRX2
         l0O2TIbbKzA1FG1N+c71xjBvyJ5UaefYf/vd9NsW2yKO14CnUQ9vEuboamTUVdO8m4eZ
         /b4w==
X-Forwarded-Encrypted: i=1; AJvYcCUHO7j/CGqmbzSHoahOpjibzr03rk++41T0a7fpIkMF70Y4Kd56WiXmFC4TiO1Fj7X5p/cI5xf14QfO@vger.kernel.org, AJvYcCUNRxyUi3BO2T3kmcKnnBp9PWhsG9STW3LmvRSFSSm77DTKKnIG2TnuT2e1I0u6ruyDBVGGvi7mabdJ@vger.kernel.org, AJvYcCWZ6nYGmGgxfIg5lwKICIwiEa7Dv56UN3mP06NNMKEcz/mPXIbS6AT2uVLxcHAabCpyVoKQG55pfn+dWpSy@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0cFfbGRermQx4KIXCxqYf8lZ7Vf+n4fWLYrESx47ULScpW6G
	9VqC3pqxp7x1k6mVGEBK6urMqyMOTfLX05xSFS4Zj2Bc5hfDGLU0fd+i
X-Gm-Gg: ASbGncsEoiau2NFzOZ76i79LgBUMV4+zlQMy1JQJANQy80x1+++Pl3S0Gxn8zBHbIRP
	iy5omwtv/wUffK9UfXTpiNkLA5l4+wzgXNoyqdlgRLEoZBR05UMOFsjFBLsY+lo1f6Nf64G2yZf
	L3uJpqC4Mvrl3Zaz09bDL0rEfxXg0ES/KM/8h9lEC9TQ1UEmB71yNlp7gXNLI1P1uZ6M5ySSaI8
	Jm7rpDlkNlJCIMbsjL4NZvB/yXoc6lMMq/tDeBAVzEZCkVlbZNsP4xj/vU260mOkMVEOtBOpm8z
	aGrIxDEICuvz4zKoDXD+/9PyXaV2pQykHB5XLondv3Bk6ORuLysfGLwY6lkYq47Ll2WXsv1mUHy
	smf4poqMKSibUe35LmLGQAZWj7ihEMElCxrUnElc=
X-Google-Smtp-Source: AGHT+IF8bIs4u2mPEnCvLq/C22NV6ukRLhAXw8+58HS22f8DlGdtxQemYQ4HfV1rolum3/uHTI7O9Q==
X-Received: by 2002:a2e:a584:0:b0:333:bf9e:d75a with SMTP id 38308e7fff4ca-333bf9ed868mr12283071fa.6.1754902245839;
        Mon, 11 Aug 2025 01:50:45 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3326ebb6581sm27011131fa.57.2025.08.11.01.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:50:44 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:50:41 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/11] iio: adc: ad7476: Simplify scale handling
Message-ID: <4a497cc5ac0f6506c1c94d10849e0ae1cacf1191.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BKTTlH+fa4DxGJK9"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--BKTTlH+fa4DxGJK9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 driver supports variants with different amount of supply
regulators. On some variants there is only VCC, which is used as a
reference voltage. Others have separate VREF regulator, and some rely on
internal VREF. Some have both internal VREF and option to connect
external one.

The ad7476 driver reads the regulator voltage only when the user asks to
get the scale. This means the driver needs to do some dancing while
picking the correct reference regulator (or internal reference), and
store it for the later use.

According to the discussion [1] variable voltage references are rare,
making it hard to justify the added complexity for supporting those.

Drop the support for the variable voltage references and simplify things
by using the managed regulator get and enable interfaces.

Link: https://lore.kernel.org/linux-iio/20250331122247.05c6b09d@jic23-huawe=
i/ #1
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---
Revision history:
 v2 =3D> :
 - No changes

 v1 =3D> v2:
 - use link-tag

 This patch was originally sent as an RFC in 2 patch series:
 https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.com/
 Changes from the RFC:
 - Fix the faulty conversion from  uV to mV as pointed out by David.
---
 drivers/iio/adc/ad7476.c | 84 ++++++++++------------------------------
 1 file changed, 21 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 9869526c1524..f117aafd8fad 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -39,10 +39,10 @@ struct ad7476_chip_info {
 struct ad7476_state {
 	struct spi_device		*spi;
 	const struct ad7476_chip_info	*chip_info;
-	struct regulator		*ref_reg;
 	struct gpio_desc		*convst_gpio;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
+	int				scale_mv;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -111,7 +111,6 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad7476_state *st =3D iio_priv(indio_dev);
-	int scale_uv;
=20
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
@@ -126,14 +125,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (st->ref_reg) {
-			scale_uv =3D regulator_get_voltage(st->ref_reg);
-			if (scale_uv < 0)
-				return scale_uv;
-		} else {
-			scale_uv =3D st->chip_info->int_vref_uv;
-		}
-		*val =3D scale_uv / 1000;
+		*val =3D st->scale_mv;
 		*val2 =3D chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
@@ -286,18 +278,10 @@ static const struct iio_info ad7476_info =3D {
 	.read_raw =3D &ad7476_read_raw,
 };
=20
-static void ad7476_reg_disable(void *data)
-{
-	struct regulator *reg =3D data;
-
-	regulator_disable(reg);
-}
-
 static int ad7476_probe(struct spi_device *spi)
 {
 	struct ad7476_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *reg;
 	int ret;
=20
 	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -310,58 +294,32 @@ static int ad7476_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return -ENODEV;
=20
-	reg =3D devm_regulator_get(&spi->dev, "vcc");
-	if (IS_ERR(reg))
-		return PTR_ERR(reg);
-
-	ret =3D regulator_enable(reg);
-	if (ret)
-		return ret;
-
-	ret =3D devm_add_action_or_reset(&spi->dev, ad7476_reg_disable, reg);
-	if (ret)
-		return ret;
-
-	/* Either vcc or vref (below) as appropriate */
-	if (!st->chip_info->int_vref_uv)
-		st->ref_reg =3D reg;
+	/* Use VCC for reference voltage if vref / internal vref aren't used */
+	if (!st->chip_info->int_vref_uv && !st->chip_info->has_vref) {
+		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
+		if (ret < 0)
+			return ret;
+		st->scale_mv =3D ret / 1000;
+	} else {
+		ret =3D devm_regulator_get_enable(&spi->dev, "vcc");
+		if (ret < 0)
+			return ret;
+	}
=20
 	if (st->chip_info->has_vref) {
-
-		/* If a device has an internal reference vref is optional */
-		if (st->chip_info->int_vref_uv) {
-			reg =3D devm_regulator_get_optional(&spi->dev, "vref");
-			if (IS_ERR(reg) && (PTR_ERR(reg) !=3D -ENODEV))
-				return PTR_ERR(reg);
-		} else {
-			reg =3D devm_regulator_get(&spi->dev, "vref");
-			if (IS_ERR(reg))
-				return PTR_ERR(reg);
-		}
-
-		if (!IS_ERR(reg)) {
-			ret =3D regulator_enable(reg);
-			if (ret)
+		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+		if (ret < 0) {
+			/* Vref is optional if a device has an internal reference */
+			if (!st->chip_info->int_vref_uv || ret !=3D -ENODEV)
 				return ret;
-
-			ret =3D devm_add_action_or_reset(&spi->dev,
-						       ad7476_reg_disable,
-						       reg);
-			if (ret)
-				return ret;
-			st->ref_reg =3D reg;
 		} else {
-			/*
-			 * Can only get here if device supports both internal
-			 * and external reference, but the regulator connected
-			 * to the external reference is not connected.
-			 * Set the reference regulator pointer to NULL to
-			 * indicate this.
-			 */
-			st->ref_reg =3D NULL;
+			st->scale_mv =3D ret / 1000;
 		}
 	}
=20
+	if (!st->scale_mv)
+		st->scale_mv =3D st->chip_info->int_vref_uv / 1000;
+
 	if (st->chip_info->has_vdrive) {
 		ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
 		if (ret)
--=20
2.50.1


--BKTTlH+fa4DxGJK9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZruEACgkQeFA3/03a
ocVTWQf/fRlCRPd2gphSq1P0fnTqUEAcvWenf7g9fP2mCOmdFCKFWG73KkpaHWZW
6JRCAx4euHHWphadV2ZJnRsMCFR2LnaqixMNVsI2zKxAV3J0xwnW/n0A5lvVjWcg
8ujtUQMcrF06tK7+8LF6TSmaSgDFlVezdr91SxxK7QmIsI5tXi8hbZkwRO7hlxB+
PxNWdX2ehLO6ENGKaWJGIhWYvv0Efj3OO46l1uEHBwbMDogrk7Vq3Bm9OlOQmrnR
pfEgnwKk+etMflZ3/HfIR/9q0l5BihaELxxkOqgcGzj735k7xAqLHp/uPPrEakSX
6LHYCT1mJN3rZ2iI5iNjYXyVUnBicw==
=CIfe
-----END PGP SIGNATURE-----

--BKTTlH+fa4DxGJK9--

