Return-Path: <linux-iio+bounces-17540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36CBA78844
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5326516ECC2
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB6232395;
	Wed,  2 Apr 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3BFJMR8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360D3C17;
	Wed,  2 Apr 2025 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576399; cv=none; b=KNmjlv9icN8OziKsvFyBYdzI4nri6YQCHmy5jv39iouQcnYil5X5IMReElY09wnjsxKKkw5HmZLmU3BvKaV3ZJ6zIy97ovUIxHAPoGYRZOBFhkInT3ukuVN3ygTlEnBSSq3XJDFcJ3XS/Rr6wHmHuZW5+8aBhDNsVujAQwdtUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576399; c=relaxed/simple;
	bh=IUwdUbHeFL0dqDwaq4iIV3I6pbitR6/LH0Nohc/Vqqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6/dykrfJqONla0IO6VmVPHvUmnkNy/Rxz9ntwDTazl4AbN062xEICUd3necyM+Dw56zKEmdDSngfZZwjbe6XLdaIz/kU8DRa95LAPmL3iJrujiqtqKKreahdK8jUKBcrGfCSlA3nrtcVZsYe7uHEUtGBYHBTR6opjWeKtlU4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3BFJMR8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54acc0cd458so654492e87.0;
        Tue, 01 Apr 2025 23:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743576396; x=1744181196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TApx6q5zRSyJu5vFDntepnYrxk7e4Dyv7PtEpuL5hI4=;
        b=c3BFJMR8jrQygWYcOi4RH/D7So5ON5G0UTAZJfqdELycOCCO69rYthanBhsQb7ipu2
         K0A8kfgFBLkZDcO8QhbKZUkNhIEksB6gh6TWlg7CpXC4KYH7AMY6Bpi9RpS8tChszX66
         1hKINopQFEmqqNxalqf9PyoyeEOAMXDv9P5HqIVUy/8wWjz0AIOCbFEab35J/2XZPZTv
         r0LMK4rUjARMSDulsTKflVeaPIRWco3Y35kefAZtYVFav3hI+fZwZAuDYrenRlv9tMdN
         megAAZaA0IpxHX87gsieH6OpUOgDP/DCAlAkR9XcxppoWUUro8TO28qtejYGC33SeEgJ
         a/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743576396; x=1744181196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TApx6q5zRSyJu5vFDntepnYrxk7e4Dyv7PtEpuL5hI4=;
        b=CLeek4db6WO8uH8LdpfR3ycKSgCZ0G7iGTvkDQrtyJ9sk+OT6SuR6mr/uuZESlitnB
         +D2xYHDGgFOkKgyCH3F4gJfo+lvh0VhsjeUQVccQHZV++sjqyjouqKlgyD/0mvJ83HjM
         RBsVvaskIw8OMLV9jMGrfdFnZK+ZjHkNTKDCa3ap8Dlgyx0njbzu1wDvnSiSf+9piS6+
         ViU01yaEpfi59HdiGR611/S1EzYKhLz7fXwL4wVIatYTVz9N+bHhbPM0q4WARXrs9k0Y
         dAgFlBJkcol3gdXPNL/32Rq1PoD48OlPvh6L1FjZc/l9Nda0knLqrP3zGaN+iJGNYlIt
         9JjA==
X-Forwarded-Encrypted: i=1; AJvYcCVyYeCNpPUBfca0doEaxdgiNm6+m9eXL4nZuUl4gVNi1GxfqAsLUgnqjNkRVhEvDavXOFLqyEjS3N03@vger.kernel.org, AJvYcCWQiWBgzAX/DtVGLd7b/XziPVH9bSnlWCLtRfACJn6EZLooma37kAYQ7L0zAsbGo2ONifj/4jIa2XLWZRVw@vger.kernel.org, AJvYcCXN8VyETmbgIuGfhLFfP6dC6+j0ZAbn+ZEOEKfK5Zh2v5JPfldF7GXtmkRZEo/i70pyfrUf5PTRQeJ5@vger.kernel.org
X-Gm-Message-State: AOJu0YzOCNgfhSauqhFGOL9XIGMMMsULDWd9/tQJyx0R8aX6j5bn2QfY
	Sheewg128O++jTEK4c2TPZDH9K079kmVZ9lF7536mXSlXOKk4ccx
X-Gm-Gg: ASbGncsDx08LKz7yzxem43809aWCpAsOfX3Jkf6s8Uo6K8HNfIdB/h6gHcHbHTgbY6w
	U/jjn7dA/OWC43JGlKj1FjmpXNdNZ1RTzXf15iM3qGXjg7eJRpPV2zWKgpfZIOLngLDIC5sXfL4
	e5eqk+9z7f/bGSaLpr+MepT6/NOw2nSklZfy7I70cPaNd9d3LoyjNLK6Yp4+/4A0eSDZNmiJ9PU
	cw7dr8lTCFHlTEf54pgvxEucupMdvo77wS26ofNCazv5MZ/aqSq7DYEJfDCrAJBElOiHHWDn0hf
	X+VSJI64EFycYhKviRScOAl6cth1Vb+u970cy/Dj8iia0IDO9HM=
X-Google-Smtp-Source: AGHT+IHB1cqHIml6QCpYB2EIlpijEXbykwLbiu/6J4VIivRNVo2eFNPbbx98QtlmqxGoDkmvo9h1IQ==
X-Received: by 2002:a05:6512:3e08:b0:545:f70:8aa7 with SMTP id 2adb3069b0e04-54c19c6b888mr393715e87.32.1743576395582;
        Tue, 01 Apr 2025 23:46:35 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094bb3fasm1528319e87.25.2025.04.01.23.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:46:34 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:46:30 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iio: bd79703: Support BD79700 and BD79701
Message-ID: <845aa45974f6fb81c83046368a24a0674e9a8b0e.1743576022.git.mazziesaccount@gmail.com>
References: <cover.1743576022.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mi8RUyLGxKqxdEB+"
Content-Disposition: inline
In-Reply-To: <cover.1743576022.git.mazziesaccount@gmail.com>


--Mi8RUyLGxKqxdEB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The BD79700 and BD79701 look like almost exact subsets of the BD79703.
The BD79703 contains 6 channels (channels 0 to 5). The BD79700 provides
only 2 channels, matching the BD79703 channels 0 and 1. The BD79701
provides 3 channels (matching BD79703 channels 0, 1, and 2).

Furthermore, the BD79700 and BD79701 do not have separate VFS pin but
use VCC for the full-scale voltage.

Suopport these ICs using the BD79703 driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/dac/rohm-bd79703.c | 57 +++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
index 35e1b1134ec6..63a70fbd7e0e 100644
--- a/drivers/iio/dac/rohm-bd79703.c
+++ b/drivers/iio/dac/rohm-bd79703.c
@@ -49,6 +49,7 @@ struct bd7970x_chip_data {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	int num_channels;
+	bool has_vfs;
 };
=20
 static int bd79703_read_raw(struct iio_dev *idev,
@@ -93,6 +94,17 @@ static const struct iio_info bd79703_info =3D {
 	.address =3D (_chan + 1),					\
 }
=20
+static const struct iio_chan_spec bd79700_channels[] =3D {
+	BD79703_CHAN(0),
+	BD79703_CHAN(1),
+};
+
+static const struct iio_chan_spec bd79701_channels[] =3D {
+	BD79703_CHAN(0),
+	BD79703_CHAN(1),
+	BD79703_CHAN(2),
+};
+
 static const struct iio_chan_spec bd79703_channels[] =3D {
 	BD79703_CHAN(0),
 	BD79703_CHAN(1),
@@ -102,10 +114,25 @@ static const struct iio_chan_spec bd79703_channels[] =
=3D {
 	BD79703_CHAN(5),
 };
=20
+static const struct bd7970x_chip_data bd79700_chip_data =3D {
+	.name =3D "bd79700",
+	.channels =3D bd79700_channels,
+	.num_channels =3D ARRAY_SIZE(bd79700_channels),
+	.has_vfs =3D false,
+};
+
+static const struct bd7970x_chip_data bd79701_chip_data =3D {
+	.name =3D "bd79701",
+	.channels =3D bd79701_channels,
+	.num_channels =3D ARRAY_SIZE(bd79701_channels),
+	.has_vfs =3D false,
+};
+
 static const struct bd7970x_chip_data bd79703_chip_data =3D {
 	.name =3D "bd79703",
 	.channels =3D bd79703_channels,
 	.num_channels =3D ARRAY_SIZE(bd79703_channels),
+	.has_vfs =3D true,
 };
=20
 static int bd79703_probe(struct spi_device *spi)
@@ -131,15 +158,25 @@ static int bd79703_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
 				     "Failed to initialize Regmap\n");
=20
-	ret =3D devm_regulator_get_enable(dev, "vcc");
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to enable VCC\n");
-
-	ret =3D devm_regulator_get_enable_read_voltage(dev, "vfs");
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to get Vfs\n");
-
+	/*
+	 * BD79703 has a separate VFS pin, whereas the BD79700 and BD79701 use
+	 * VCC for their full-scale output voltage.
+	 */
+	if (cd->has_vfs) {
+		ret =3D devm_regulator_get_enable(dev, "vcc");
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to enable VCC\n");
+
+		ret =3D devm_regulator_get_enable_read_voltage(dev, "vfs");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Failed to get Vfs\n");
+	} else {
+		ret =3D devm_regulator_get_enable_read_voltage(dev, "vcc");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Failed to get VCC\n");
+	}
 	data->vfs =3D ret;
+
 	idev->channels =3D cd->channels;
 	idev->num_channels =3D cd->num_channels;
 	idev->modes =3D INDIO_DIRECT_MODE;
@@ -155,12 +192,16 @@ static int bd79703_probe(struct spi_device *spi)
 }
=20
 static const struct spi_device_id bd79703_id[] =3D {
+	{ "bd79700", (kernel_ulong_t)&bd79700_chip_data },
+	{ "bd79701", (kernel_ulong_t)&bd79701_chip_data },
 	{ "bd79703", (kernel_ulong_t)&bd79703_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bd79703_id);
=20
 static const struct of_device_id bd79703_of_match[] =3D {
+	{ .compatible =3D "rohm,bd79700", .data =3D &bd79700_chip_data },
+	{ .compatible =3D "rohm,bd79701", .data =3D &bd79701_chip_data },
 	{ .compatible =3D "rohm,bd79703", .data =3D &bd79703_chip_data },
 	{ }
 };
--=20
2.49.0


--Mi8RUyLGxKqxdEB+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs3UYACgkQeFA3/03a
ocXjYQgAkgkv9yo+85PplwAjjjyZ/4R/cgGh67WDBoQ7WIWvoWAbo1AGsx7HlyNJ
Rbcuf/VqfFHYOiC9l9lx6jchk6tZZNRXj/JBfFzdXBX3Xc5J8h5/MF5BH0G/WbMy
7MY7o+27dvtrP+z6w6ZImM95aD+Un/bXy7iLFi+ydznn2zbvWtTb9n7toK2zka4g
FvjqUvHH6qvTAB0XTfx3ay/V/S70bLPgPAvk/qVq21nckQQGD48L087OF+m5rOBn
vhrsFgr1KgvrBomePxRyydxgztR70ciOxjRC8s9mw2laSkEFSmEjuAKv006dKFyw
gMGb3kdEdAJMhS1tm2a5aXC6VJyB6g==
=d4tv
-----END PGP SIGNATURE-----

--Mi8RUyLGxKqxdEB+--

