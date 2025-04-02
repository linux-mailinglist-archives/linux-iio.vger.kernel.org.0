Return-Path: <linux-iio+bounces-17533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50AAA787E8
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1643AF79E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E1230D14;
	Wed,  2 Apr 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvXA+Kce"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075A230BE3;
	Wed,  2 Apr 2025 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574212; cv=none; b=TuX1zV4EkOFz/jFgNASqfLAADbRJ8BOpNzn5KEaLCPjza9M+aAz2dgu4odcy2oMfC2fZR/zJiOEmuokCE5UHfe69GD0YR24zsWr/DA02l4MQGEJ1v1lgxpPmM+tFOwyYktjd3Vq8QBUrh138wXcqe/6QzqDNAdkBhInqEX9V7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574212; c=relaxed/simple;
	bh=RMfvE3UxUx8s+HZgIR3p7Ek8rDHMVkGpVS4uzspM28I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpZSOM6UeWs32+PgPQPxAvSKGI8yUv+pnsXV1Pac8F/h1wWLz8wi1jmn6u+sGK5clK25Pllf+0C7kCl5DqIq564DmcSp3HD28OPdPJvkonE1YVyN0TB8UwOLpMdPu8kv4q574HNcRYv1bJu+mvFkQGbV2fcnu+8jscNJrnKOkvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvXA+Kce; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bee278c2aso5886821fa.0;
        Tue, 01 Apr 2025 23:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574209; x=1744179009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZOTnR6gg4o5Zat+jvBjSqS5Z1+QmVDtxQd0gGuKYC4=;
        b=HvXA+Kce1743WlDMJsBkDjArOAuZoma9q8/HT6dgwjjvVYCX5S46BSlcBkRy4LvO6w
         TMwOhCuD2KlHJfM77euI1Aql+NqY7l4utXN+HMqc1X8lxF4mfgH1n8QTj7zyPOlvVKxP
         04umHb4iLZvIS1QNQTZpIs3//cLX7/WyV1UO+Vh8klToh6sqwyY0gloAkrnM7ItxFq64
         EBc7PLQ2ovrzcg+3r7nxRTfH0maUo3fWMGt48Wh4Fd+GB36wB5IRIuETNG/brDeTGZfc
         iuLloxcI6rvYUpSOuMKebCzj4DYkOoE1SQk49Ut6FtsS5nHKAOISfLiShqIOdefHOWt+
         CgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574209; x=1744179009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZOTnR6gg4o5Zat+jvBjSqS5Z1+QmVDtxQd0gGuKYC4=;
        b=svLZx5ZbEqPEiDnLG8NRHT6hK5V45yf7cRVACa+YXCxLNSd4f64S0o8S/vn8D36kbR
         xBEMoGETUCG0m4EylzHM3jsHtNwdh8nNO1PqVtgF2rQQTF+u6Zyt6zZoITEAZuMTgOpq
         Ioug6C0fI2cgHb7UPXcMGNtW9u9MuBNaYGFY8v3EPZySUwEzbX9C/QjtgZmI+IfnGFF5
         KGFTzUmWarKzFmNZQGRjCzyNyixy1H2TPVWDOf3CsC0dZ0mOpL4arAAMT6q5VCY0+ty9
         jgaw4ayc6G7swLY14p1GS96mTACWgYf64IpCdMS4uo8+iJYvNCYxGT2h6aqJvjFf7Gnj
         E/rw==
X-Forwarded-Encrypted: i=1; AJvYcCVK7wsYvdao6bFSXJ/U6D1aNxwXljSSk+ixz2MIYT6loO4gOKbdgyw0Ch9PqANPSj7pXN2h5lWCs7BF@vger.kernel.org, AJvYcCX/8mRfBM0b5qrguKu8OfbIBDRTuMTPZpBQksvmKe/qEUVqmzzYe32EGWuOPjAlZFvocCrDKn7meoXR@vger.kernel.org, AJvYcCXlhzEnjpujrDTAVB1chAtfgzNK74Dse8aC5raw1k/9/sv54iRA004ymkgtfCXJY1N5C4uFnycAhz+BeFQG@vger.kernel.org
X-Gm-Message-State: AOJu0YxBO1M3gyGvbB/cbHlyc8PZiIHHj5t4ezosHFg8Z7rtUMl7NB+7
	CExg3neBWhWz/fG52vAivVKjy0c1BYlI1vlpeu4O3gnrCpSl6dYM
X-Gm-Gg: ASbGncsftkRE3MJS0ViX6+7jyLZcWQ/t/NwKWYNj+H1xik+56NB2T1uhHruwkt2bzee
	DFWN/4b10mTlnouVHYcxj3IlQ7leQjQCVm0C7/fekuXja9Oaz7f50zU1WwjwGtxqpVTZCKlFO2M
	rD3hhDlwgswLXPAmI82TayrBuwUZPJu1jmq563pHFh5vZGKDAdVrXLhEMVPHZsPs/RHUxsHk1GW
	U3BRYcalRqOWQdb/gJrdZez3Mt8EJAqMCEib9AntPSr+MnFDEb/k4d1N99ZDwycStlbsxjVjaH0
	Thxs6/jEzdkNv6xlIiUe50UhQtSQ2gQNgF194b1RLzotjSpjFsA=
X-Google-Smtp-Source: AGHT+IH83AmkdQf5pOBVli6oipqJFDi1PuOvLVbjkHwOtxeL7fz3oBRiaTiVei92OabQIt+k+ncL/g==
X-Received: by 2002:a05:651c:10ac:b0:30b:f92c:16f3 with SMTP id 38308e7fff4ca-30efa5224efmr2022861fa.11.1743574208585;
        Tue, 01 Apr 2025 23:10:08 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b59686sm19681961fa.97.2025.04.01.23.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:10:07 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:10:04 +0300
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
Subject: [PATCH v2 6/7] iio: adc: ti-adc128s052: Support ROHM BD79104
Message-ID: <7b7c8c8ae79224c5aa74ed084858d90df6bbad81.1743573284.git.mazziesaccount@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ujxrzJXipQIJqS6A"
Content-Disposition: inline
In-Reply-To: <cover.1743573284.git.mazziesaccount@gmail.com>


--ujxrzJXipQIJqS6A
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

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Datasheet: https://www.ti.com/lit/ds/symlink/adc128s052.pdf # [1]
Datasheet: https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_co=
nverter/dac/bd79104fv-la-e.pdf # [2]

---
Revision history:
 v1 =3D> v2:
  - Use Datasheet tags in commit message.
---
 drivers/iio/adc/Kconfig         |  2 +-
 drivers/iio/adc/ti-adc128s052.c | 40 +++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 859c77f40f1d..045cd696a57d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1486,7 +1486,7 @@ config TI_ADC128S052
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
index a15b75fc067e..0f93c6266527 100644
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
@@ -125,10 +128,28 @@ static const struct iio_chan_spec adc124s021_channels=
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
@@ -163,7 +184,7 @@ static int adc128_probe(struct spi_device *spi)
 	indio_dev->channels =3D config->channels;
 	indio_dev->num_channels =3D config->num_channels;
=20
-	adc->reg =3D devm_regulator_get(&spi->dev, "vref");
+	adc->reg =3D devm_regulator_get(&spi->dev, config->refname);
 	if (IS_ERR(adc->reg))
 		return PTR_ERR(adc->reg);
=20
@@ -175,6 +196,15 @@ static int adc128_probe(struct spi_device *spi)
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
 	ret =3D devm_mutex_init(&spi->dev, &adc->lock);
 	if (ret)
 		return ret;
@@ -190,6 +220,7 @@ static const struct of_device_id adc128_of_match[] =3D {
 	{ .compatible =3D "ti,adc124s021", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s051", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s101", .data =3D &adc128_config[2] },
+	{ .compatible =3D "rohm,bd79104", .data =3D &adc128_config[3] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
@@ -202,6 +233,7 @@ static const struct spi_device_id adc128_id[] =3D {
 	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
 	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
 	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
+	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
--=20
2.49.0


--ujxrzJXipQIJqS6A
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs1LsACgkQeFA3/03a
ocVq4AgAqQTz7P4kCrzrGGYbd1dsVTAWePIJaBceOInf4eD/Om0KWASk6/z7S3il
eWYA1+OZyI5OoTFq5dqiPOUDLmWpVJUa6a5C2675wgujZcm6iONh2IB+TRY5CCZV
6J414ehFguVZJDICTS+zSaqGTVwmOP1PLFhTR9uheOpQ7TvM5b4MPuVTHEA9LrKw
+KqPfmS0esANvMixRG6lekpFStu3VrUyScN2hPz+Whw1udEcBsO5JMpRqhVAdvdi
aJhSf59wrzYhokHxoKqQnhmvfhZy1wthJ2SNGtsgd4ZX/R0wpBlpRzjq+WknE6TH
AhQDKqodQniIGAPSQ/a5J9Z9SpD2/A==
=geDB
-----END PGP SIGNATURE-----

--ujxrzJXipQIJqS6A--

