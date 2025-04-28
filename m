Return-Path: <linux-iio+bounces-18757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B24A9E8BF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 09:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883BE188F8AA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC341C9EB1;
	Mon, 28 Apr 2025 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmC+QhMV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1B3C3C;
	Mon, 28 Apr 2025 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823758; cv=none; b=V6mA0XdIFQDVM5xinN+25QaxF3AKKF4TD7oEGEICUBTvZUjOKA0mGaCIvxZIxl03KZg4IzVPdI2pRrkjL/tolLeO4JihAMWn3WWsLT0IzpXS71+umrRIPKLEE3Gl7e/DBFWRR2Tf5tk13QVJUeS5uLMFz/md21p2i8IcolO/wjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823758; c=relaxed/simple;
	bh=5F7JfgtkKFnOClnGWwKldccpucpiSv2bOpWoSonwojM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mXepzJOnRoaUlY5aJRwo0Amj8rEXmEmQEv6Rt0EIu1eozJ8q5j5dYUQaroXAT2AqSc5emkzgeQhvvM/gAVlVA6cV+GvbQ6PLfixM2mIE0Sr5UAuNgTsiXx67TeeUd9jWWc4fGP6UAigZq0L/FPLy5lrBq9dLm/MDHVMhSRap7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmC+QhMV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54addb5a139so4787474e87.0;
        Mon, 28 Apr 2025 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823755; x=1746428555; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKZTAR18iQQ5PiSvQfyPIEtFL+CoyxFraPYXeb+BF+A=;
        b=nmC+QhMVoSyuMnvt0jfRLTMosm6SKYLUAM2vXAGzVgKh7+AKSEtP21SMtb4zkQ0nYw
         TTPh9uez9+U5GcT2He5tB71DLRSnik/ZGn5q4IH3gGciD8x8spGe4b25IDaD81QAAU4e
         RaVIlbSMWUpJl1H5CyrMd44geidzDthvuWZONTgfgazOClFkc04gLEIy40xvryeMwEYl
         z0yLSgk1bKKSR5zqafhdvk5KG6liY9ix2aQBw3Y6mAUSkDJguQFSeo4rJbtTGKIB/f8/
         tvlZrEF9IBkHiEYVOTpL5o88EQbo2Nljm7eeC3Q3VYtbKPko83ToBZxfpjVj6Qd3TKi6
         //7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823755; x=1746428555;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKZTAR18iQQ5PiSvQfyPIEtFL+CoyxFraPYXeb+BF+A=;
        b=YAbtRO2jjJ818RZi8Bb++17qzSWtK5LyvHV2DbQ6QYg/UYUfuyUFIufAYjm85ALjKe
         CdcGyK0zvpS1J9NAokOEQaiSPBfkpHd4jbjKHE8AE+lompmHkEYpMtVddkhehVg+uMhT
         N9NHFcwMcj9yx7XvNK//TvyjfekXjKKXo72zfBFr/6HKsRCKFq3V361ZGlM1XMnQwyyR
         ArdncdXxhtVQfVHmUYle8wyzawpmIIrrWHanD5QZKFAKMH05V8BMDE0OJajVqqV6e1y8
         ukj2Y/lxmf6DPhzX6iH97e6522Kdm/ZyuRVQtGjEkVzdHyV/Qz3xpGHshZ3qul0NjySN
         shcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8+vuWxz/ItsfcrUprATSm8ExVnaA0eIEHBIdE0IxOGwqibryOGcRUgBFjqUlx49/MIsGsJlski3w9C8Sa@vger.kernel.org, AJvYcCV1cOOFZJGkcCA0x51tjk3cZgbMAJJzs4/FGv5ObK6qtlTDodpJECOwXMLy5pJfqMepVzWpZJ/8FXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xQ7FMoKeTM8HkQhNB+PGdLy/42Q90rjH1iXg4E2rrzn9bu5e
	FrRI13Iq76ME2+wnF9Bhs8zO8JadssiKymr7n/llDpbGVmYG4ab4
X-Gm-Gg: ASbGncs3Nedg51pKd+Ygk7+2DUYtFPNzMf7F82g+Z0oEkF1ohfa9eeePvfXv1dbGMSZ
	RF9FH9jfAxCrTxQ2pBf/ZIjW67eEs3mLfgNrrDBZ6i+MYa15Thw55C8oye+2UGiA5y6HITLfOyq
	SL/h1bQNj0aMUQE8SMKC8pPzRI3BsZ5HF6HBlEZ9UEGj+E20oXfGRy38Xmp2gHeAfM9kGALj7Ml
	d3+9M5nFJqB/DTYDVnqIr9KLnXNGEKDF+6k2mA0X7o6MnjrFYbetG4dasVu55nw+o3RpGtqd7IV
	b6ciKe5xo53/fbu2EgY8f/E8fDtfLQTahF1NeHosmPsaGwbus0I0JsCjGQ==
X-Google-Smtp-Source: AGHT+IE1wjupvO5Q83YwJEzkje9DsDOyRwb3d3UPovutABH1nRWY7Hx1Ef8G/Sa0AxSVKdRD1nAxVA==
X-Received: by 2002:a05:6512:1090:b0:54d:68bd:2847 with SMTP id 2adb3069b0e04-54e90015593mr1878763e87.52.1745823754566;
        Mon, 28 Apr 2025 00:02:34 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb3bdbcsm1555619e87.96.2025.04.28.00.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 00:02:33 -0700 (PDT)
Date: Mon, 28 Apr 2025 10:02:17 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ti-adc128s052: Drop variable vref
Message-ID: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d3Pp7L838hXuKerh"
Content-Disposition: inline


--d3Pp7L838hXuKerh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

According to Jonathan, variable reference voltages are very rare. It is
unlikely it is needed, and supporting it makes the code a bit more
complex.

Simplify the driver and drop the variable vref support.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
RFCv3 to this patch:
 - Split out of the series (as other patches were applied)
 - Print an error if Vref can't be read
 - RFCv3: https://lore.kernel.org/all/db5cb2e1543e03d5a9953faa3934d66f4621c=
d12.1744022065.git.mazziesaccount@gmail.com/
---
 drivers/iio/adc/ti-adc128s052.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index d4721ad90f2c..383098206246 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -29,13 +29,12 @@ struct adc128_configuration {
 struct adc128 {
 	struct spi_device *spi;
=20
-	struct regulator *reg;
 	/*
 	 * Serialize the SPI 'write-channel + read data' accesses and protect
 	 * the shared buffer.
 	 */
 	struct mutex lock;
-
+	int vref_mv;
 	union {
 		__be16 buffer16;
 		u8 buffer[2];
@@ -81,11 +80,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
=20
 	case IIO_CHAN_INFO_SCALE:
=20
-		ret =3D regulator_get_voltage(adc->reg);
-		if (ret < 0)
-			return ret;
-
-		*val =3D ret / 1000;
+		*val =3D adc->vref_mv;
 		*val2 =3D 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
=20
@@ -155,11 +150,6 @@ static const struct iio_info adc128_info =3D {
 	.read_raw =3D adc128_read_raw,
 };
=20
-static void adc128_disable_regulator(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int adc128_probe(struct spi_device *spi)
 {
 	const struct adc128_configuration *config;
@@ -183,17 +173,14 @@ static int adc128_probe(struct spi_device *spi)
 	indio_dev->channels =3D config->channels;
 	indio_dev->num_channels =3D config->num_channels;
=20
-	adc->reg =3D devm_regulator_get(&spi->dev, config->refname);
-	if (IS_ERR(adc->reg))
-		return PTR_ERR(adc->reg);
-
-	ret =3D regulator_enable(adc->reg);
+	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev,
+							   config->refname);
 	if (ret < 0)
-		return ret;
-	ret =3D devm_add_action_or_reset(&spi->dev, adc128_disable_regulator,
-				       adc->reg);
-	if (ret)
-		return ret;
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to read '%s' voltage",
+				     config->refname);
+
+	adc->vref_mv =3D ret / 1000;
=20
 	if (config->num_other_regulators) {
 		ret =3D devm_regulator_bulk_get_enable(&spi->dev,

base-commit: 350224bdb9725aab5b90d72fc3db7618ebd232ae
--=20
2.49.0


--d3Pp7L838hXuKerh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmgPJ/UACgkQeFA3/03a
ocVkWQf+LtXxOmsp24IhxXidyxq2xGdPFzLuvNvH0W01JNYW9sBm1pccqeYK31hs
ALvBFBLBcLVutFJPMq6e7tYzhgokwL/ITqLtYGE8pxa5Xic7X2xbyEZZIgY6mqv+
BFUpIikAmGFMEFkJSjivkIprVI4OEWXgh2iaK7J894fqdxlTXBtUpO+GcYy1hZu5
/AujvyyeG0sBghD86CuyaG0jMy031BLc94vtwtSU7TPVLrzPRxLBHY4eEc74eVtL
P5+DOCrzovo+pyUcyFcaWOeMawrqRkxi/XUWFHL0fJEYvfoPdgOEmnCTxwe7XDaq
ii0eJEWw+Bqh26kixKZWuQ0e2o4h8A==
=VBG+
-----END PGP SIGNATURE-----

--d3Pp7L838hXuKerh--

