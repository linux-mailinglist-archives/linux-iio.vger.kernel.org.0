Return-Path: <linux-iio+bounces-17757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2DA7DC64
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0CE1751E5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E5523C8BB;
	Mon,  7 Apr 2025 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzp2BqfK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880E238D27;
	Mon,  7 Apr 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025816; cv=none; b=AwbE0zhBQKVOtXtVb5qcuq2fpO2/hZx0cv2xb+SGHId7FC/wytGxZwk9i0BA536cFM3NniE4DEKqgbE+rnki43QAk/LQR94UaK8ps4qtqCIJO1eFoDNdGVytw4aPhE66wwq/Z3Sj3jH7tqMSYYe/XpWjxOPkcdcLLT5X9pfZTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025816; c=relaxed/simple;
	bh=kpJnzEPJ5DBpJTe5Y3Q9ZCqetJ9R7nSpDjl72oKh5CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj69S5Ag4FXKc8qQ3zrVZL5HzBenSiJOrPGy9gRhbC0eswSAAdL/9frydsm5dmwJM7WCsvbQhrraEBH5If/1BOveQtCFz5a9wZco6LA3o55XM3qhAhBGXpNaJcHp30kod5k95q7QKDV4FfpjBMazahDX8pUCee/uyvY07GLDjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzp2BqfK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-548430564d9so4845432e87.2;
        Mon, 07 Apr 2025 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744025812; x=1744630612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeJtpPmNV6fcrn2H+o0MwC8iIldJ9JWXCVKDhrhoghY=;
        b=Jzp2BqfKgFSQa+e7wgwuf6/O5CIgkvH5qLN4a2CdyVmn9ji/NLigaSyJNz911HyPPI
         jmVfRgOxCo0spFw51NDumnTPFVoJPfPCxS0uiTS8cx/UTFQMKI8fJhWZj2B+l1WRP02Q
         KCulEV0J1nYqpWPrRiV1u0KQpHjgtpA7I3wkVbGeMWgbOo4stozgWvRk1hWISv9ssOTd
         48tIZkIr6Ku/c4GbpuEkpdlA1t1NFR9VPF6FjQ272z8VGSbA6R4kH6NDGE4yR211o/e3
         EVEOVlHPFRDS42ySfJ0iIRvSYifFQySC0vaYFpkSXEcdtFak8MovJsjRsoskaQGzHz8A
         wgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025812; x=1744630612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeJtpPmNV6fcrn2H+o0MwC8iIldJ9JWXCVKDhrhoghY=;
        b=o2MMe2X9H5KL64BhjFSh+Xk8lDvZy346FLAxNTuQLVuISA9Rxn+eeg0fzGAz7w8QSM
         QwP7Jm5X88WWJdWiLha7kJ41OG0rp3xECTcQ4mWs2gbEWk4kzQMcM+3kJZEuV399d5cT
         yzoOYnOwXtkmz05TaJeOfQH3BYG8cOaEj3ZU6b/gV3a9/nLKj8wODzrJHfPgPDR+2bo6
         WffpOcuVQj6BhGRm09AxTCApwUmjtjd77Z/7dgykDj0qyWUR3yCjqMBArGU9iHqHbFEs
         EoqFitH2THtl2hEWHuuNhUKHjZsYXLDbPn9bIqKrPI+Vql1QOupfb5vqsRtO1GUDCkUn
         wZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUexPZ8iFS6EKN7kZVBLbF6XXwyGF1nnXBnekhVe9tYcOyAuKZnHxxxv3jdHyLIpfi790ZnbeKmOWFQ5q1j@vger.kernel.org, AJvYcCVIhQgq6xCimVd6mTJGKZ/FFgRLutO12GNZNrGzEZ4dtvRmnlq4s7HCiiAUpYd/QLWtgHl0/ROkesDm@vger.kernel.org, AJvYcCWboGjcIPkn2qI0HxoNhb6pFXxAZedGvD4746wWjPM+uKdBBqakiseU44Bup9W0+3+zyBf1YWBs5WED@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTLHfIuZRqSx3S7RVR27dd6FzbE8vOF0+GlhSg7OMB6yzx2rM
	ooJQ0g1yuiOqsdSDcUsRQ2LiaNvAKgwymObCj7Xn/kA7E884aKbn
X-Gm-Gg: ASbGncs8D36PmKtCAaPmD8+GAAL2Wb/jz66KYhqQo2fhsIP2ou92WEsOInO08i7eAEG
	s/tHrhssiHjXtyDtHzzg2ZkMIRMofe7xevv0lVPVfWUZ0t4dNn1cn9FaI8j8RIdhIMECz/m0wHk
	bpo5BmkMBR1Mr//0bdEKR5JfRE+C7zBNKU5zoS4CAwK0mFG0ihKOb9/rYyr8cTTTa9ZUWWRrk1r
	a1HRiIyFLWYrjo6UbdWv6QctpGQxJcc/VpVsXnWehbalbfTYVGcBNF9RbGCj2tOKdIeduBc2Skm
	F9bgdmv8zadnTtIVRWhw1V62XnqPswqP9TXYniz6yrKsMo6UcrSv7/0QaVYfvA==
X-Google-Smtp-Source: AGHT+IG+Q9KD2qeqzs8zVpl3Y94ulKfjn2Hl5MtyIDuv4DilVpp02mFzgE1yTF+ezGnyYDe7JuRq9w==
X-Received: by 2002:a05:6512:1255:b0:549:9143:4e8d with SMTP id 2adb3069b0e04-54c297b7221mr1969212e87.8.1744025812321;
        Mon, 07 Apr 2025 04:36:52 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c2e33fb7fsm588377e87.24.2025.04.07.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:36:50 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:36:47 +0300
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
Subject: [PATCH v3 6/8] iio: adc: ti-adc128s052: Support ROHM BD79104
Message-ID: <36ffa72cbdf8dbbdf1e612040db82ebcdf73fa24.1744022065.git.mazziesaccount@gmail.com>
References: <cover.1744022065.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D4s0BnB5gxrNyS7W"
Content-Disposition: inline
In-Reply-To: <cover.1744022065.git.mazziesaccount@gmail.com>


--D4s0BnB5gxrNyS7W
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
v2 =3D>
 - No changes
 v1 =3D> v2:
  - Use Datasheet tags in commit message.
---
 drivers/iio/adc/Kconfig         |  2 +-
 drivers/iio/adc/ti-adc128s052.c | 40 +++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6529df1a498c..bbad7b3d41bf 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1469,7 +1469,7 @@ config TI_ADC128S052
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
index fa0099356be7..d4721ad90f2c 100644
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
@@ -124,10 +127,28 @@ static const struct iio_chan_spec adc124s021_channels=
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
@@ -162,7 +183,7 @@ static int adc128_probe(struct spi_device *spi)
 	indio_dev->channels =3D config->channels;
 	indio_dev->num_channels =3D config->num_channels;
=20
-	adc->reg =3D devm_regulator_get(&spi->dev, "vref");
+	adc->reg =3D devm_regulator_get(&spi->dev, config->refname);
 	if (IS_ERR(adc->reg))
 		return PTR_ERR(adc->reg);
=20
@@ -174,6 +195,15 @@ static int adc128_probe(struct spi_device *spi)
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
@@ -189,6 +219,7 @@ static const struct of_device_id adc128_of_match[] =3D {
 	{ .compatible =3D "ti,adc124s021", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s051", .data =3D &adc128_config[2] },
 	{ .compatible =3D "ti,adc124s101", .data =3D &adc128_config[2] },
+	{ .compatible =3D "rohm,bd79104", .data =3D &adc128_config[3] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
@@ -201,6 +232,7 @@ static const struct spi_device_id adc128_id[] =3D {
 	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
 	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
 	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
+	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
--=20
2.49.0


--D4s0BnB5gxrNyS7W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzuM8ACgkQeFA3/03a
ocU3DAf/b0FSUJ5PSXSeaFIbsPTobY0zR3Vrvv0ay5og4XQNj4CQ1mLUAk95Kn0A
aormVPozpwnrgm1xMDhR1Pkdnhch+UcpJjnqYAAFqIB+qxARBlpanqDaKQJgfYjW
YIWNDrQeRi59YqLkWvnkBRVztUAl2h8MR9CRrbdcqZ8K3zoqxq9UuVXpvSmdkFZi
nwmTpVU/ZJyBtem3qe+euRShkuYEDHP8shgcCqM/bYqZl0DFk2nd+z1Ci5nNgAG1
PvBm0DYsl4g537zpYEg2aguhshbHV7eC3IhbvLaO9XJPXV/7udyGhiaIibMNBoX9
JaNuvcA8YLUVJyKLqdZ6mdJBtjbK6Q==
=oA/g
-----END PGP SIGNATURE-----

--D4s0BnB5gxrNyS7W--

