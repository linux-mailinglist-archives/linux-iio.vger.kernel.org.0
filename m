Return-Path: <linux-iio+bounces-17406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F367A760D5
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDCA167F73
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0481CEEB2;
	Mon, 31 Mar 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1kchZx4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF281B6CF1;
	Mon, 31 Mar 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408247; cv=none; b=dX2zgkM+QjrZe/WND6iU+f8QlfdFhoNqPrsa1/7YnDGwdYJNXsGOEEJfBl0vjCCYn/G9jMK0LMk/PmWLxajzb8tpW+vw+apk/1gSl3kr/XzTw6zQEQpAg8s4rE3pXP7P2Fd+TbZlxfYhL1yXtCsP2MVFJVRk6oRE2SeR/qI67HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408247; c=relaxed/simple;
	bh=xDj6NmkTBE+WE2RIjKG6TW64UV4EnZk3zV/BHOKImr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4JxPHVmTqztXvCiOtuFmZO2OyUM2/ZYoLgT5nJq8d1XVhSGrUhHkz9IWl2EZZvmRV1xu3bSH6z/XTkaGQe6igM27C7ceMkT1ZNq4hiLS4tWtjSBVG1CjQp0mZsPrN5e2XV9nW8lWa+U8lAGz/vsbFYQAZtCo1fZyCX0OeZfLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1kchZx4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c2d427194so42859891fa.0;
        Mon, 31 Mar 2025 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408243; x=1744013043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOKTaS1bnkUrUG2tKrfWfNop8QOJHGyKI2kaH/s8Zn8=;
        b=P1kchZx4MPQuPMQULlJymYuvHsJh6CbMmSFcyjB2pvgTcvYcOhabe8vTBsNMk2UzRL
         61x8knBesoorrZzMhvwwPmw34WiIc05uuBlLoRPnRL4e7m122g62ABOPjTJhLizbliZd
         /f4tZCB2jIEAZVcIm96+Wz5nuKFKhtOGXNbfuXmK40v26YR3wy7d4enfg4GoMocwDB4t
         6wfd1sGyUjPCRvXOWd1SrcWcYksKt1Pf1M/Ah6BnqRYtTgZ/9011baC4tRBwwy8Soy4v
         7s+Ss7OFdrc/NVJK0qz3PyUDSQe4JK9drGskqdw6zFKVrglHcvCbQCDmfUxh2j4aGOln
         fTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408243; x=1744013043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOKTaS1bnkUrUG2tKrfWfNop8QOJHGyKI2kaH/s8Zn8=;
        b=rlzBT96/CtlhYiaX24aiQpseqXx1d8PV3nTd4GdB2q9qiZKroIWaAT+dstxd13goOP
         duxFNjym/hrfS6PVjAkZK+pR4flivZvlm3sXzXOo6NuirUaMPwojeXeQiiRw7pglneF4
         j7cmROLr59OrQ2w/TwWk64P0x6FagHI/9BG6VGJRmMskMvIdpSodpIwlojnahch3PK2q
         H0yCsPXbobMNV5YdACyGQXgnAiGhKAVLlhkmQ70Fio4UNerUFxb7Ghysz6Wa1rqOXvnp
         umuT5WqUDSMu03vovn9BVGSDz1p7/ynCoYeqPL7FM2q3D59HZCUW2bR/l8cW5s/Q/frS
         KIfA==
X-Forwarded-Encrypted: i=1; AJvYcCUNXnNEcdCzFuhCATUL3Ib89j8uD5d5PnnzmiHHdNqDds2JvQCiS+siwLT2Hi4C1Txt7L3obqu+RcGu@vger.kernel.org, AJvYcCVLzxQFjt5uJ55a40T8WfFcYhiCP1+n3S2S7I4LpFsC2ljbYANe4dtogulCRd5SZjxqzJdOGXcBDdNoVeWU@vger.kernel.org, AJvYcCWVggrWWAbzGTDaoSP8ZHxAJm2bxzl4NRR1bbUpRLwuaL/HgilbGdq+1hJhS0cH7NeDiJiToACWQKmA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PYzBMdDsSJMZfB3tVgABmEMr+fSqAHXjW+U3ae5Q5apAMiIk
	KN6iiSyIlJBm5a8SL8Qipu6yYhrEalJ/Aa5pSI2uIjXYOBK/I68qg1KdUQ==
X-Gm-Gg: ASbGnctlEZi/1c75JfGKRzW79ux7uE4lVILL73rVebzetnI0ynCHjO7AX/A5Q+WAXVU
	Q74mH407U4u2ETWwT3HF3DIjUjqZk5aVyqPOm6BNpJPhjUhIn/r6inD65Uk4y8Ap4lhVIDMxSuv
	XJxlJBYB0jL92MTxM23J9plwRgDX66BpLPueF/vCiRLZw6IugikK4Hoih+r+YBVEgkDUW4KCvTx
	FgARWMpp9gMVCqNEb+n5N/NFuPOFuE3e7JJ49QSqu70us7j8LFscd3IlCTiSQvNq4LnWx3DgrwJ
	uy6oBS4WlD9ITb9vIVq+dBsilR1ZgvIZXH3ptftWpFThwZXaAdw=
X-Google-Smtp-Source: AGHT+IFrVJs9P88My0ZQaQfwWTY7umA6uN4F81QOq5AxFhrpwQR/ctkCFCLRiMaArfQ4VSeugw0MZQ==
X-Received: by 2002:a05:651c:896:b0:30b:c07d:29f3 with SMTP id 38308e7fff4ca-30de027ab19mr29782161fa.21.1743408243180;
        Mon, 31 Mar 2025 01:04:03 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2ad61f6sm13031671fa.60.2025.03.31.01.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:04:02 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:03:58 +0300
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
Subject: [PATCH 6/6] iio: adc: ti-adc128s052: Support ROHM BD79104
Message-ID: <8e10f2d82362ca7c207324a5a97bb1759581acea.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EaIuK5wapJbyil3W"
Content-Disposition: inline
In-Reply-To: <cover.1742474322.git.mazziesaccount@gmail.com>


--EaIuK5wapJbyil3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79104 ADC has identical SPI communication logic as the
ti-adc128s052. Eg, SPI transfer should be 16 clk cycles, conversion is
started when the CS is pulled low, and channel selection is done by
writing the channel ID after two zero bits. Data is contained in
big-endian format in the last 12 bits.

The BD79104 has two input voltage pins. Data sheet uses terms "vdd" and
"iovdd". The "vdd" is used also as an analog reference voltage. Hence
the driver expects finding these from the device-tree, instead of having
the "vref" only as TI's driver.

NOTE: The TI's data sheet[1] does show that the TI's IC does actually
have two voltage inputs as well. Pins are called Va (analog reference)
and Vd (digital supply pin) - but I keep the existing driver behaviour
for the TI's IC "as is", because I have no HW to test changes, and
because I have no real need to touch it.

NOTE II: The BD79104 requires SPI MODE 3.

NOTE III: I used evaluation board "BD79104FV-EVK-001" made by ROHM. With
this board I had to drop the SPI speed below the 20M which is mentioned
in the data-sheet [2]. This, however, may be a limitation of the EVK
board, not the component itself.

[1]: https://www.ti.com/lit/ds/symlink/adc128s052.pdf

[2]:
https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter/dac=
/bd79104fv-la-e.pdf

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
---
 drivers/iio/adc/Kconfig         |  2 +-
 drivers/iio/adc/ti-adc128s052.c | 40 +++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..148a52b3db94 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1425,7 +1425,7 @@ config TI_ADC128S052
 	depends on SPI
 	help
 	  If you say yes here you get support for Texas Instruments ADC128S052,
-	  ADC122S021 and ADC124S021 chips.
+	  ADC122S021, ADC124S021 and ROHM Semiconductor BD79104 chips.
=20
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-adc128s052.
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index c68ee4e17a03..c7283d606d2e 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -21,6 +21,9 @@
 struct adc128_configuration {
 	const struct iio_chan_spec	*channels;
 	u8				num_channels;
+	const char			*refname;
+	int				num_other_regulators;
+	const char * const		(*other_regulators)[];
 };
=20
 struct adc128 {
@@ -119,10 +122,28 @@ static const struct iio_chan_spec adc124s021_channels=
[] =3D {
 	ADC128_VOLTAGE_CHANNEL(3),
 };
=20
+static const char * const bd79104_regulators[] =3D { "iovdd" };
+
 static const struct adc128_configuration adc128_config[] =3D {
-	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
-	{ adc122s021_channels, ARRAY_SIZE(adc122s021_channels) },
-	{ adc124s021_channels, ARRAY_SIZE(adc124s021_channels) },
+	{
+		.channels =3D adc128s052_channels,
+		.num_channels =3D ARRAY_SIZE(adc128s052_channels),
+		.refname =3D "vref",
+	}, {
+		.channels =3D adc122s021_channels,
+		.num_channels =3D ARRAY_SIZE(adc122s021_channels),
+		.refname =3D "vref",
+	}, {
+		.channels =3D adc124s021_channels,
+		.num_channels =3D ARRAY_SIZE(adc124s021_channels),
+		.refname =3D "vref",
+	}, {
+		.channels =3D adc128s052_channels,
+		.num_channels =3D ARRAY_SIZE(adc128s052_channels),
+		.refname =3D "vdd",
+		.other_regulators =3D &bd79104_regulators,
+		.num_other_regulators =3D 1,
+	},
 };
=20
 static const struct iio_info adc128_info =3D {
@@ -157,7 +178,7 @@ static int adc128_probe(struct spi_device *spi)
 	indio_dev->channels =3D config->channels;
 	indio_dev->num_channels =3D config->num_channels;
=20
-	adc->reg =3D devm_regulator_get(&spi->dev, "vref");
+	adc->reg =3D devm_regulator_get(&spi->dev, config->refname);
 	if (IS_ERR(adc->reg))
 		return PTR_ERR(adc->reg);
=20
@@ -169,6 +190,15 @@ static int adc128_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
+	if (config->num_other_regulators) {
+		ret =3D devm_regulator_bulk_get_enable(&spi->dev,
+						config->num_other_regulators,
+						*config->other_regulators);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to enable regulators\n");
+	}
+
 	devm_mutex_init(&spi->dev, &adc->lock);
=20
 	return devm_iio_device_register(&spi->dev, indio_dev);
@@ -182,6 +212,7 @@ static const struct of_device_id adc128_of_match[] =3D {
 	{ .compatible =3D "ti,adc124s021", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s051", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s101", .data =3D &adc128_config[2] },
+	{ .compatible =3D "rohm,bd79104", .data =3D &adc128_config[3] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
@@ -194,6 +225,7 @@ static const struct spi_device_id adc128_id[] =3D {
 	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
 	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
 	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
+	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
--=20
2.48.1


--EaIuK5wapJbyil3W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfqTG4ACgkQeFA3/03a
ocWb2QgAl3JsI3FCbaZPGxCSoFBEhpdz5d+NWAF4yozNoZZWmZ1HRaw088V+Vz0o
KabpEd/YKwyxpl4jhKxu923e2f/OlJW3uVjkh3dIdR8i2Vqy6nI7RdN4ujnZSXb4
ep+wD1YqdiA35HK6QyaTKhg5nVXrEWjZ2zUF41Gj6GY3TvMmISIGO9bAgWvhvBLY
r1aZjo8vjDnivLbCKdzsOFtS5zeTFS9UvWw2eUDwuRatYHimxhZt2jyGWo3Pd0d/
ElugUK6zgGipnGM0YTeYSvGZBbLuala8wP1GmD0khbomW7Foclp7NSu+0JEwN+OU
yhrvRalvkI6ndNQ9tylUMdupA0LqBw==
=Y9+j
-----END PGP SIGNATURE-----

--EaIuK5wapJbyil3W--

