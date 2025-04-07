Return-Path: <linux-iio+bounces-17759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335BA7DC6D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2E3A6D02
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D122A7F3;
	Mon,  7 Apr 2025 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEAJKD5A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447E1EF1D;
	Mon,  7 Apr 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025881; cv=none; b=BUl/tkg0W/Mu0800CBv2JFaCXMH0YTeQOO18xyrDlxCTQmdB9vwai4VmF6C3VSjVCVIyMKS9bpg2c3bCEZkS7V0tvlMxuBHxOWTRAWjrihurSxg7yCwfSccEie6vdnmtv8pHwe45biRc1El5iXAYSfjuGBNL/Fn97bOGkITVleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025881; c=relaxed/simple;
	bh=bsDKEmqgO0I2EGpzutpYFXCP3t7mHPazIKYXeIXoc14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4imAn73Khi1nkOSKvczxut49iquoqRFe5A+QBmmleMnbTHpwObyEI+ECGRwbHyTxYh0ltnwlUa7grJ5pseRaKfpcEVZJafVkWewlTQebOqbox/5iuohM5zfyze1aGg7iC2ZyEAFJrvCza2/ugRni8MRZS8s9Uyo/6ksJ9Xygo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEAJKD5A; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54993c68ba0so4717730e87.2;
        Mon, 07 Apr 2025 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025878; x=1744630678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0bW7XRgSgAoBBUc68G36J8+gSyA5kZtB4e9OyIg/to=;
        b=XEAJKD5Au9iYxiZafjgVbJpHt5ftDf5m/WfiaooUl6a4wtEvYpZzrYneF4Q0HHgYkn
         L7SrhukR0DerQxQFB6Qn9NtdLuX8XXuu08rTFP7+Kih1pXEgMze9TNsArT6r+Yek7471
         fUzVysPwE14adzRFTRz3q/upUldIxi6hg1g2rSIk3xk1VcO2oeJDXG1JU2l+n1GPH9ul
         rt7YPaFd7HQmeFu75BYSTUSRjn/Z/VczLgClAYVp8FdsF1sNe+7tebPM+6MjEA6FRcYO
         BXI05OPUMEs5NUFC1IfwOioXeSCoxotFT0GftBIujmoUHK7jtTr4WUrQcUL8beIZ2jAJ
         Tz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025878; x=1744630678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0bW7XRgSgAoBBUc68G36J8+gSyA5kZtB4e9OyIg/to=;
        b=OfmlhKhj03PRyNf+PXchK95PpoZQyZltb1e1NYvWDYe9zIaa6Hk8wfidrGIvMn+rin
         3oebMULkum2b6PA5Pb9ZEPLno0/j5B4vc2j6VaAtPmSaAt6nXXFOci/X6G3Z8sPXEgqB
         hza/HGHnw8K/te10IWeA6EDyC9hgClC1/pNIfcgzDVXruHSQnWq5yhIEpgTiI04pNii9
         NyfTGTmXc7vi+BXJJTKs3Evx4XulmL116HImNFXAv6ZQbZyg0kxVCbmQRwZUcBHwcC6A
         LYzERJ3dviLhW7YsPgSqw3oQiSn0bln0cqlYL+WBAv6V21okoJoehlOCZk1kuDId+61v
         +VUg==
X-Forwarded-Encrypted: i=1; AJvYcCWj1FO85icKqKhsJJWoU6vvQBH7/z9WoL+DLY2IPdLyJCBezUJ0Cv6h5PbFxWpG8GBdiu/P6/kN9oDSWwZr@vger.kernel.org, AJvYcCX6XUuAzIiQlkN+Ffr5ekT9SfYabjtMZZ1YBINbPpwRV6+S1ZKZw9Is+uSqAwtpAGxDo1rnr6mn72As@vger.kernel.org, AJvYcCXyfB6xosJacGJ+FfbXMon+iqo45SD3J+mjyARJ11ruGYSf1vgVEbO6UfpTxYNAIEmFQm01hXMDlf49@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgui7vWJjuK65o5U5QmQy01KpCKCpUVclgXm1hWReWVnDrtkyp
	miuDCeKqrNw+sC87xEa49wRwxcz0zC2o9ZYpv2Kf4L9IvVu+PmRn
X-Gm-Gg: ASbGnctEq1F8Yd7YV6GFZUYvltYl788BlPUSwNisVg2iNiwViv99KenkQnXuEjavEZq
	pZr7dXHyuolAc8B6GgJz4fUjb+PsWGaQnIZ/vzjqvJkol1K8yyAJwZaGVCgV8bEoIYbCo83Rnq3
	kFRn0tDIdTwbmbtFnblKY9niU0S7xI82pVAzKkHeWp81diMsXXMLznyET1KvfdYrgQTZLR3LMBd
	8xNrt39JUyRItMHQxkUTqvM7G/BR3gObtGRyuAU/p3Es5iarFwYWlP1i+dyNU9/3aRUH6AmbaDA
	Pabarj0XwqlbWBKT9Kg5fdX/MoLr3R/IL7PeUrmOLRS1JX0JqK4=
X-Google-Smtp-Source: AGHT+IGyVZ/zW67Y/NNpMoE1zJsgrkYKSJz2zRA0jkIHBBPaqRlJygoJDYO/LmcFcb2Ox+M4uNGpWQ==
X-Received: by 2002:a05:6512:3b8b:b0:545:9e1:e824 with SMTP id 2adb3069b0e04-54c2280c34fmr3027378e87.48.1744025877566;
        Mon, 07 Apr 2025 04:37:57 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e670d0csm1209187e87.217.2025.04.07.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:37:56 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:37:52 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v3 8/8] iio: ti-adc128s052: Drop variable vref
Message-ID: <db5cb2e1543e03d5a9953faa3934d66f4621cd12.1744022065.git.mazziesaccount@gmail.com>
References: <cover.1744022065.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gf8nlqtMmO3Y2tnb"
Content-Disposition: inline
In-Reply-To: <cover.1744022065.git.mazziesaccount@gmail.com>


--gf8nlqtMmO3Y2tnb
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
Revision History:
 v2 =3D> v3:
  - Rename vref =3D> vref_mv to make units visible
  - Divide vref once in the probe to avoid division every time the scale
    is requested
 v2:
  - New patch
---
 drivers/iio/adc/ti-adc128s052.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index d4721ad90f2c..c38468f299ce 100644
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
@@ -183,17 +173,12 @@ static int adc128_probe(struct spi_device *spi)
 	indio_dev->channels =3D config->channels;
 	indio_dev->num_channels =3D config->num_channels;
=20
-	adc->reg =3D devm_regulator_get(&spi->dev, config->refname);
-	if (IS_ERR(adc->reg))
-		return PTR_ERR(adc->reg);
+	adc->vref_mv =3D devm_regulator_get_enable_read_voltage(&spi->dev,
+							   config->refname);
+	if (adc->vref_mv < 0)
+		return adc->vref_mv;
=20
-	ret =3D regulator_enable(adc->reg);
-	if (ret < 0)
-		return ret;
-	ret =3D devm_add_action_or_reset(&spi->dev, adc128_disable_regulator,
-				       adc->reg);
-	if (ret)
-		return ret;
+	adc->vref_mv /=3D 1000;
=20
 	if (config->num_other_regulators) {
 		ret =3D devm_regulator_bulk_get_enable(&spi->dev,
--=20
2.49.0


--gf8nlqtMmO3Y2tnb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzuRAACgkQeFA3/03a
ocW1zwf+J/Z/A7KSvBPvQYaP4Z1Vt2HWpQz3KxhusMr7hHQNF2F4cIcSlgDxwGM/
qpXDaPAhYj33qhH7uQ2vaMYC/nUXNpiikrz/ccgs9mAS7OGWEjtI8/DFyTrYaZj1
xwVDDw0dVHgOScG1GnkiqNn2yC3I1I/aFjZPwpsr+aZfxNjbCI2DPvrybmm4AZMJ
/EZcVcYq6g/Ifwvn27/pxoupLOC28AI56LOZ4/ukEtWS73CK+aiwOEUo6uKLHcOU
5yf7PviRyA6HC5O20/4JV5mnjDecJsAXI+faZjQA37RKRRor5qEo13tytzUtK17V
JA/vdUfvT4FUX0BH2CLc3SlIUh0lsQ==
=A4JU
-----END PGP SIGNATURE-----

--gf8nlqtMmO3Y2tnb--

