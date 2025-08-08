Return-Path: <linux-iio+bounces-22431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E217B1E4D1
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9A71AA27F9
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0204A1DF97C;
	Fri,  8 Aug 2025 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex309Po0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600F26D4D5;
	Fri,  8 Aug 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643094; cv=none; b=g8O52fRbToDbFSkK6QBJRRxbdVI54Rk9aMuD//cEUsuCsFcvMAkcAH+8sGBoLQhgQsd1Ppl+hYzcpYkCTgT7NCz3FMfqjZWOJVvklZwJhkS7mgoSnf7llnR3smo7lkmRKH/u3l6gnlf/1NTM4qSs8nMaOxxnUj+ue3EiOf0uYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643094; c=relaxed/simple;
	bh=i3Gj/eGdxovc1S1YRB7Ee0F2MtWAFEDFX2x1Bz9i86c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urhevt61aS8P0HJCfCv0Q2MV34SEcyiuTxOiWXCdFDo+zqSabJ09iXsL3gP6HXdQIJsVTSNGIbevaMRK5OjJrymLgwZfb1dHWvUxfLixW/mxUmFVKDmJWW2b3wN4gYWGZvpNpHKOSQp5j00xe0khVfRQCfbAZZT0XPFcLxj+ruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex309Po0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55b88369530so2121658e87.0;
        Fri, 08 Aug 2025 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643090; x=1755247890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wG7aBfRHnHo0r7lCWYEcuTsWYHXTQH7vU37MjVO2mqY=;
        b=ex309Po0LhpHw76WA3Hhfj6v22yFKjKZ+lkG9zo+7Ben1fGp8nnFvkUBZJpw1dBXeE
         kYJE/UCKPsURJkpYGKaURH1g6OWu50I6qGecl4AnKI+sA58F5c/8vrBo2bUjQPJzA6r2
         P4+AqkyeNTezjqvgVQXrmFtdZKD2NJMMKFlx8NrkURKYPq9is1AeeMJ1RD+45/qQNX48
         W+WOx9v/1ljc/6zegpp8Tg0b/Aaj+PVmraQcHJA+GliD7kyjWhUyqwSAtAciXtitJBCh
         ldrpkTbvpg5JtMhRQFQSbM/kqy5Sy81AMbBe7i5ZCDT5SZuSZsROA6ADkroQaeS3iPyx
         A2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643090; x=1755247890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG7aBfRHnHo0r7lCWYEcuTsWYHXTQH7vU37MjVO2mqY=;
        b=QzUFOCFFxyIZZQFrxlKBLSGqK3l/xs4AuLDQVTTMQdcFJzL04ylj7JV63kPOEiTRWW
         gJNNk7MkcjS+PBy45JTIxJV30wV71VAG5vgX67BAsP6HUlY5kRrQFLgRPYTD8ybNkGMt
         bHOmWo0kIzssGxnaYeu0mYZ4u6yrZ3KENghe+ZBLj+henieL+qHCxlNJxrLmdb1hpNQK
         joVUnqzsPaB1szNyuEvQM4DQ8PKazVZUPWNub5D4LFdqG5/rrZMczSBqMQKNiL9kX20S
         O8HsihsjhJDTBR4ObEQlkg4zFmfa2qJNOZ9EWsDIEblaNxPTn9o64cf/c3DrfbeKFHeZ
         oBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2LnPqqumPjDFzxenpIiBcKUy+BigMPoJdZa3By2kL7Hw79jSHVq9/Q9DvZ9dKiqoTzhTUgaszsyYxX/R5@vger.kernel.org, AJvYcCVVeX+Z+4y4kW53E01MVwCAhJHhyBvH0glW0bJJAvK0j6SGkwoYvthgJneFdGJWBUpDE8CSD1yrNVAH@vger.kernel.org, AJvYcCWPvKWMS5ayvI6mM977nOL8FfSopbhRbDCJgCx1Vqxcyt8Gq7FGYGv3QyNaFW9rwKsuwK1uTKhUlHLA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2A4uIN3q5MXdfg2GQZsO7zAlek+T7OpJoH6NEXefJmGnHh1o
	BbY7FkyPl0rc4Pa4RoHm8cwBcdGfsE1Osx23EmWm6SLYbxSFDnDqdYo1
X-Gm-Gg: ASbGncsijmIqgIkkPsxd+QTHsxIwlhaVWzqW+PzY4/58BNgUQizASbKx9quGo1YiEqz
	rmc67amCe9IwKkFnS5t47ASVvyFjXRmWwhv19NzTXbzzvGh7ASKH8xJNnuOcRnvs9YihGa1l/xp
	S+b9XkgFcVz1voJBmcksmLqPfjbRXF82N4ApnTSPBgj2sC+l1HVlyaNmNQb/Z7sWvfxmVPIaCV1
	928JdaLJFEIOzZNYvVgyWcvNIHcIL11H0N8R7kf9/bANeLbZADtbWrV0Vtz7D6UKr0t8jxo0S8s
	0pt6enBnZbzELK9q2IBmqORALECrtARRmSkcwQNrnuYeCPE5cTrtbTEQNuYFLOFU0Jf4W+BlTLe
	iHt8lnM2/NMGCmdeismcB2NSf8XqX
X-Google-Smtp-Source: AGHT+IFktDMP92fd3xwj6HpLG4KUTK4DqzevdxSYJvT0Hg1irkXLwGs5vFiLx0OlhQjtxCrKPuvhug==
X-Received: by 2002:a05:6512:3e26:b0:553:23f9:bb37 with SMTP id 2adb3069b0e04-55cc0149c19mr457657e87.40.1754643089573;
        Fri, 08 Aug 2025 01:51:29 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9919bsm3031969e87.89.2025.08.08.01.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:51:28 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:51:25 +0300
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
Subject: [PATCH v3 02/10] iio: adc: ad7476: Simplify scale handling
Message-ID: <593907619b726f22a383ac527941241a34bfafd7.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MWnzZwHDcaylGcU2"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--MWnzZwHDcaylGcU2
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


--MWnzZwHDcaylGcU2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVuo0ACgkQeFA3/03a
ocXT4Af/WW0NjnvKnc+auIxAj9ZYud5yhDBfhjEyIgtfb0C3y5vuh4QnHR2E4KEQ
oqy/J/Uw2JZr7iNxy7mTg4PWjb8dbsyg/sZXbPKJbi2HnCoTtRYoElMhSYl5wMAH
MOUk/rGsuOgib6liHqClHlgXNrVR73NmYRWPfJwDh7BQMp4G4wtGvt9+44YdPnJR
0FB/WZBkKTbt9eBvOAyTcRX4CcHl1m4s51+PC1QT3Dww0eY0yn7KddBdH5hBMVLd
FiXz5uZdJJeXi/U9aY+X4lMLwVashpyA4ENDJzTiFmUvBM8b5mEPVKHvIPKNzBjp
HSeMTUKQ8l8O9Ems+sl1gSNoJeWT1Q==
=vM78
-----END PGP SIGNATURE-----

--MWnzZwHDcaylGcU2--

