Return-Path: <linux-iio+bounces-22387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D092B1D4D8
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E81C1883662
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370EA24BBE4;
	Thu,  7 Aug 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keSal52J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1B24678A;
	Thu,  7 Aug 2025 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559268; cv=none; b=m2ow3ShE5KWxAgciJ+zwWfcNDaPnw9LuSUFx+4nGcK41kCUcb6eoYNubWulKNctIckrDil/RgGeXuBOOGU0g+2bHygEzCb4kb75WnT/liD2TmU+zanX9Zk7QbM2CESLKWqbLexbuDkg9zc1HxWHu11aDF4yJPb8hRGDBPTAh0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559268; c=relaxed/simple;
	bh=O2ueyr+B0ri2LzKhL1UU4mM3o5ahwf/ZvWLBsxzWzOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUzgJMBoxTdLasr2Of7Xj+7GQC+AK6b2X8GQacrFL395szkDnuHIEgOLeyT8ksMnVbglhlCZPNLwM82ysKsEmynaFCXfa5aRopLwTmmUXw8wI+6y/pYWlN/8q7AZYYmUlCSSnuFYxEEq9R8ZVErdQ6tNb2Oria7Cew9bAfe3rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keSal52J; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55b8a0f36fcso898259e87.1;
        Thu, 07 Aug 2025 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559264; x=1755164064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xlpz6uXwD6POSBazwUz9cwRtiqHcvTaGRwP5mmmfK3Q=;
        b=keSal52JuIOJ59sCa5xMaixn7MzEg1JnwZERDHVtZ+fsJ/+b35lICxETzflkG/ject
         RxWpTz75JhoxPId8U4IiJVvaTi6u9FxKSs9zTF8JW6bJJDza1UjQLO+RM2ZJKIgh4tv0
         IQq2UrczLHT8nOcGBjRUVCc4K6Ezhnm9ttHDU2k0hOTDu09mLripLVp5YJkUyMephLog
         cyQvX6Z//MeGY6RSF7dh0rj+Un1YtViZqeh7LJWk7txJowJO8xo+G4Cbtmnwa+5mZriX
         xg+TNP34s5Oiusd86FZf0KEMtFab/ZnL41hH0RROJUb7cpEIz6Z3uZyjjGWJCgj5KpPd
         2BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559264; x=1755164064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xlpz6uXwD6POSBazwUz9cwRtiqHcvTaGRwP5mmmfK3Q=;
        b=Az5Y0LPC1V9+Sb2BUH7jv3m9uzAEQCmXGgp0V0Ctabi6FfAcsbSPN7YOrSzCVVK3C/
         WQP1quUuPnZ0gmnY3X4R9tDUDHFxEmhhyuh/ShZV30EFDPXBMUNyK5Mp61nxPd/zeMDR
         wV0Stk5huYV6+l2dJHTyiWYFjAdvzxBaQk8KmsGHYbeejfZetvLcZf8FVabSWqvRUPF7
         49jNSRhg1inCjzCFNZCqUg/8kozeJoCjpm7crBqLg2iWjldtOVPrBlCNedmCqrv/831Z
         ue3LgkdNvxd1YUBf63ArsXagjyc2DbiTMrxTStgUZiZuh6/XUP/jkm9M0WouJpFZZ14y
         gMqw==
X-Forwarded-Encrypted: i=1; AJvYcCUBFXCiA6WfVTEVXMSimfEYY5a7g4rsO7BICIa4KVHvmiZGKOiXlgUUQ6DwxqlW7joQToCdTtW090hP@vger.kernel.org, AJvYcCVboz/R/Wv4EueRrvjfSQXA3P3LshSS8WGjfkH6yezh9DLdY6MNjDiYbav5L7i55zzImPv2N4+lOkSP@vger.kernel.org, AJvYcCXPaN3BWk+2akVgfxkZwxsjPIR0IfWkF7Istxf7H2KUaPuh1MxuqWjHPVBt0mgSTqMmI4Cd/Ai2EqwdzEmE@vger.kernel.org
X-Gm-Message-State: AOJu0YwONwdxIywDjQSNRx0mHRUZQN71BKG9hBFCnQcfndovn9X83cL5
	oCoIoLnhEozQ/Vvt1WTIly+uO86XmatGg7KVzWvKcVLOrIx/9nw23kyD9zq/GQ==
X-Gm-Gg: ASbGnctekcY+it8L3XdMwMyASsSAp7R7k4nAaUjGk5LOxZB5M8S00AsqFI6/b1TbXba
	yl6DIknXifgIB/aUOUY/k9wy8XRg8dRqBVrrnf8+vrROvjPNhZxM2Q+U8ZF6LCOmC2XUvJcr6Yc
	22xbl4o9Ca5hCfXGmCGGmOgyhdxHfs4vrKxC2ANYaKJAwoC4l41eLkwH6ACVszxSVwLFmhm2DP1
	eLIOKisradZjIdD1Pt8UcLYFru7jDqqB9d4LcNVca6PqJqZmSP2AMHjFvLunD3a5SRjVUrqAcbh
	qMHQWdjib8yOmRVSb7hNpiFiyyVojIovpDfuOxdnmmrs/SkxaU8ju+zkY1R0bk6JzwH8ZzTS8+3
	KA1khY+7S3C0cyXiNvaes8Xdqh9JMZYCmVYlPfnk=
X-Google-Smtp-Source: AGHT+IF2jBhRN/QpN88yMSsiMczQn9QFSobLBjIBvGKbroAeo4rz1hrnMQ/X35t7VjNAUUECYwGDfg==
X-Received: by 2002:ac2:4e01:0:b0:55b:5393:bb32 with SMTP id 2adb3069b0e04-55caf37bd4cmr1673670e87.33.1754559263962;
        Thu, 07 Aug 2025 02:34:23 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca6274sm2572955e87.140.2025.08.07.02.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:34:23 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:34:18 +0300
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
Subject: [PATCH v2 03/10] iio: adc: ad7476: Use mV for internal reference
Message-ID: <415c4c8f8301395aee2a85d071722fd6bcb488ec.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6pqI/XR25oVK9acU"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--6pqI/XR25oVK9acU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports some ICs with an internal reference voltage. For
those ICs the reference voltage has been hard-coded as micro volts, but
the value which is later used in code needs to be milli volts. This
results the need to divide hard coded voltage by 1000 before using it.

Simplify code by changing the hard-coded voltage to millivolts and by
dropping the division.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 v1 =3D> :
 - No changes
---
 drivers/iio/adc/ad7476.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index f117aafd8fad..7b6d36999afc 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -27,7 +27,7 @@
 struct ad7476_state;
=20
 struct ad7476_chip_info {
-	unsigned int			int_vref_uv;
+	unsigned int			int_vref_mv;
 	struct iio_chan_spec		channel[2];
 	/* channels used when convst gpio is defined */
 	struct iio_chan_spec		convst_channel[2];
@@ -172,7 +172,7 @@ static const struct ad7476_chip_info ad7091r_chip_info =
=3D {
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
 	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
 	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.int_vref_uv =3D 2500000,
+	.int_vref_mv =3D 2500,
 	.has_vref =3D true,
 	.reset =3D ad7091_reset,
 };
@@ -229,7 +229,7 @@ static const struct ad7476_chip_info ad7475_chip_info =
=3D {
 static const struct ad7476_chip_info ad7495_chip_info =3D {
 	.channel[0] =3D AD7476_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.int_vref_uv =3D 2500000,
+	.int_vref_mv =3D 2500,
 	.has_vdrive =3D true,
 };
=20
@@ -295,7 +295,7 @@ static int ad7476_probe(struct spi_device *spi)
 		return -ENODEV;
=20
 	/* Use VCC for reference voltage if vref / internal vref aren't used */
-	if (!st->chip_info->int_vref_uv && !st->chip_info->has_vref) {
+	if (!st->chip_info->int_vref_mv && !st->chip_info->has_vref) {
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
 		if (ret < 0)
 			return ret;
@@ -310,7 +310,7 @@ static int ad7476_probe(struct spi_device *spi)
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
 		if (ret < 0) {
 			/* Vref is optional if a device has an internal reference */
-			if (!st->chip_info->int_vref_uv || ret !=3D -ENODEV)
+			if (!st->chip_info->int_vref_mv || ret !=3D -ENODEV)
 				return ret;
 		} else {
 			st->scale_mv =3D ret / 1000;
@@ -318,7 +318,7 @@ static int ad7476_probe(struct spi_device *spi)
 	}
=20
 	if (!st->scale_mv)
-		st->scale_mv =3D st->chip_info->int_vref_uv / 1000;
+		st->scale_mv =3D st->chip_info->int_vref_mv;
=20
 	if (st->chip_info->has_vdrive) {
 		ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
--=20
2.50.1


--6pqI/XR25oVK9acU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUcxoACgkQeFA3/03a
ocUfmgf9EYHSBJjYNn3vgvqjgvC5+OK5Pk9FXEXsR9TuLF2CPpImzDs2+vHv2wkn
XaMo0e/sCJthNV+QCBTWHQMTMgHAHv8G9Z+0KY2IK+KuZL8WRfmXWOJwQ/LZpJDT
N/AGol4+JfGBa1yLLv3aSAEuMFoicBBlUfh6sGq9zqNPB+5bcWfaB5M6YDPnCg2J
QZcMw5hyvaKS8qbNc2FlfWrVmq6d7hGQ0RT7hmdMr/yB5qFFjQ6/YrSzIlOqq59a
IfkPmXC2rjTDwpxMEqhjHqTbCdn0DuK4tSX1STCunDSWlx4/lXcZdrNILjLM9LmZ
/FJxbO0XEkfbVarjqojyb8MLnjvNWA==
=ijm1
-----END PGP SIGNATURE-----

--6pqI/XR25oVK9acU--

