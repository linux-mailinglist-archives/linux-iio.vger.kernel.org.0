Return-Path: <linux-iio+bounces-22322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC61B1C0E5
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D476230E3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622E0202960;
	Wed,  6 Aug 2025 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDbQUMTy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07021423C;
	Wed,  6 Aug 2025 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463798; cv=none; b=B9tUICJiZl4Q224DqCdqphT2N9F8YTyRic82NN++mkRGcfRUGtVT+ciI6O8tmXq70rzP5Cpa3cGW6on6nYMY8ZRoW82V0E/J++LCgQsu3J4IrYLp5mgX+a9MjWearfcG7o12QOXSoNbCaNkTnHhPcnTaYJX1uQxLUxtEBn98mOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463798; c=relaxed/simple;
	bh=Q3yJuCmn5e61EVSt3NEGZOpzGPKuGdJJrmEbbyLJFDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIy1Ib/hzvkpgT4wsPi+LhJurzpUKdFVW7uEpQZ3HqoYB2gG3nsmMfkHLutHFeSpErcHCimmUDpDKgM5qLyJIz3mHC6XVFOZOkOqWYjiAU71n8bO3oRJy4nmczkbOyOQr0uJVt0aNZeYHi1T6Jveo8AzMDu5ufP6ItXLLHC93Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDbQUMTy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5550dca1241so5530003e87.0;
        Wed, 06 Aug 2025 00:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463793; x=1755068593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCjap3r6GWY+oG9C3YnaC3pah6IKSDtl20E2gnxSsio=;
        b=SDbQUMTyu0V4gHtDIY9ajz86UtKtlvv33j0N4lWFBuHGdUbGW6Tc6k+f9qkfcs3UJt
         xKcxnM28A2Se9p6qYK7rVmzrpPkk1yBXGU+h9wKZqTpvfmbd2JRgDlZp3T0pZyBPMPZT
         p4xUIHYBr8E3vqWfT0Yjf+myk9fvLZUQKNnbiPKQKubtnL24pjx5k9pr7fhzKHzoH11d
         uHycq4OobalWsWGbTeic048n8fNys8brV7G9bm6Ys5OpfkYvQyw8mIkA+re68lPiLEEd
         t0amshrNkwM8Rg8qfCxbY5TFC3AW6wjvffmA2L+ahC74DfQBOFXsCoPYdMgUlhShletd
         FDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463793; x=1755068593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCjap3r6GWY+oG9C3YnaC3pah6IKSDtl20E2gnxSsio=;
        b=cP3mT3plDsk4IJNL/W3Au2SbN8mHkP+yPpUzoJTnOIwHq9DhqmQtWEUGhNTWFew/7n
         lrYG18l1Jf9rlXMSvO/7KjjGiBCbCdOPme9OkH1pADb1FlULfiws+0QPuQ8kjzyXBJ3l
         H/xN5JtmvEHoV3zAOwJSv988I1vl+uyt1F8a3+vDqxYQrXDalLcG6s76g/w5AwyCogib
         fYiafojtUPzRyxzS3m61jTs6bq2+hD6YCklwlfZjOCNYb0q9ZhZCP2jYi/aJj6cG1w8x
         5ZuALiri5jrPBv+IyMwfQo/NKcHpHz4Ffzeyn65g1k6OpT/IMqOXCeep2hyqGWp8Ngrt
         9ugA==
X-Forwarded-Encrypted: i=1; AJvYcCVAxYN3g2IeOpka8hUNA/5o1+ZLsbQkfSJDqEqO/dTJ41wd1Fg0wEwHjy/mvd/FQ4DGaZ7/BDpMk6t+@vger.kernel.org, AJvYcCWCR/3SDUota0zjDVBWco1Buyl67WZ0Zku7WUWTIk1XYs3VVd5QJflJNLfrvtJCCyzlwIjOP9ZuX9k1yFPv@vger.kernel.org, AJvYcCXAR6HQ/tGogasTq+FXs6ltjIOXeeHxl3loHqDB5LCshrWITG+pnE2XrvPicBJgOpilT/OWZwSqydwV@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6y87shjKc4ZjS1adO9mWBI82E19HmoK4dVD2erhF+oALy99k
	zQiacI8JOOUd/MYslx9jWMrhng3YK9fTJP/4gw3xCWGDyru/3BzKvTDd
X-Gm-Gg: ASbGncuOLdErdU4QULT1zxYRO+pX13BAUOh+uCOn8iUVfY2MICcdKZv3kVGtxzkPlBZ
	tl/YAexYfQz9SZ+XE/+WQWuSKxsC2cOm9MWk+IoblFGmD0urMf98E8Q/ITUkHhlrO3P+uGL/3Sf
	jTt+mmGRRhYXjEranjF+Vc5J+TEwm0sEbM7LcxctZiRotJ8/CbrBUG/8pXq09SLAQcRma9p3BwT
	/nH+3GGXFhYvbXPE0Vdqo6nx1qzN1r4PGJLCofF8GM5AuBztbpE3E6jK+jcs99GdQKLyuCsG80u
	inLICZ3PYarcm3hcDOsFYdHgJ4fDMbePfU/CcQZJSi0XH5Y73PG2QfHt+oa05txgTenQC3DlIDV
	mzjhxJo6jp2u7edTiVnQYz/7YD4IO
X-Google-Smtp-Source: AGHT+IHKKTvv9J4YYqd16LLOskb5afYcS6JdMeohnxCIaQl8a4iANFrq/LCIfv6pVxbzo1ROgrtm0w==
X-Received: by 2002:a05:6512:3b28:b0:55b:8434:afad with SMTP id 2adb3069b0e04-55caf39e532mr468699e87.40.1754463793216;
        Wed, 06 Aug 2025 00:03:13 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cb7e15sm2198377e87.176.2025.08.06.00.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:03:12 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:03:07 +0300
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
Subject: [PATCH 2/8] iio: adc: ad7476: Simplify scale handling
Message-ID: <645ac6fb917e12db6cdc0fc343487531f61c176a.1754463393.git.mazziesaccount@gmail.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tSziX7xv44S3yHgS"
Content-Disposition: inline
In-Reply-To: <cover.1754463393.git.mazziesaccount@gmail.com>


--tSziX7xv44S3yHgS
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

According to the discussion:
https://lore.kernel.org/linux-iio/20250331122247.05c6b09d@jic23-huawei/
variable voltage references are rare, making it hard to justify the
added complexity for supporting those.

Drop the support for the variable voltage references and simplify things
by using the managed regulator get and enable interfaces.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

---
Revision history:
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


--tSziX7xv44S3yHgS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiS/isACgkQeFA3/03a
ocU65wgAxgI0tQnDVM07q6o4iYZyEWKcAKo7UC2+RScuMwf+E4xMPExzRUoD02HZ
SDquSiXUi17JZOGxlo9QJeWAUwTZn+lPx/2NeYtxkexZBdF+sq+ks7pBFb1tZviX
sO8SNa0fimmPCcuT+TSAtrBrapec1Ltkj81OiA4Tns03P3mv3FZUiZZgFw/L3bA+
ZAngNpDFoPGlKSDBlNgPlz5C9PwYzouka7N5lhI0j45+Wj3cJ5abNjf35t+JHlUR
36tdyPqWG6hftQKZ3DcvC1Lpv9LO0l6JoHPWswEkt+vmb/i3HmPsw4bJblm4nBwr
7x/WdL6Ufu+PNuWOKor7KGwcVQG7iw==
=CtYQ
-----END PGP SIGNATURE-----

--tSziX7xv44S3yHgS--

