Return-Path: <linux-iio+bounces-22171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37561B17FE7
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 12:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511473BBFB0
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1FF22F39B;
	Fri,  1 Aug 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYA+mh9U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411921A449;
	Fri,  1 Aug 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042842; cv=none; b=K60kCme1a3BUpVH3i08G8RJfm5VTnf0D5MLYrX56S/Uv8mTgu0CAPL2yTcLo4Wkm+xvnBhTL9Ea8J8Yw29X7su8AtU0hjsgWNuE1li1G/RlABE1ItRUSfi28FYjcFZEn3lET6e8vNSI4LJjNP4XKApRozrG9ErRL4B96PAabbnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042842; c=relaxed/simple;
	bh=6IsLwmenUQPuKm2ah2QCuXHb5W35/Mu3BURR+7T7Bho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC/85kPOmv8ITzhVZ1pk0bAFZ3bJvhPUsVGOa6Rrce5y4bD8eRrXu1wbYAOp79Da7eNlZn1dfQrcPqDsVNi99JJ+2jRerq43l+tk0paJUh0DXIQ129fJjwEKBi5PvFsIqBQYCa4oU0Ps4yPaVWnlReALAA/Yav/k9oe2g+F5rZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYA+mh9U; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55b8a7a505cso1015426e87.0;
        Fri, 01 Aug 2025 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754042839; x=1754647639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8scFkk9ZTKaEns0gwD+Rk6y/5CcqRH8JvL0z+OjDhE=;
        b=mYA+mh9UfkRdd3IaX5go9IQdppSDmw0mXNsYVaxOJYtN2+vZs7aPXSyGbVlGJR5OfP
         +bLJ6OJ9x+qjIqTPcSM73fHF/D6tUkZEuXjN+p5+6UqjdmnjF/EGsPpk4bCxXyAWFsnQ
         N0O0P3Wll6OW7Jg2fazaaw8sFQ3stSkwsbEtU1s/zZieUSybKGgHPWpXsy89/C9S8xi1
         +2QSFwR2VpVC/aZmEDHML+7A1u3JgnYi4wXuvKotlk3EZ1Hvi7yUCLtLrgEHtlfdjPjX
         3FzaTvyh/ba4JteWoLh3at6kQChw//LYdRkuZwtsQPryb/lg5U/DjxkEFl2O9WwnXIZ3
         5PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754042839; x=1754647639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8scFkk9ZTKaEns0gwD+Rk6y/5CcqRH8JvL0z+OjDhE=;
        b=HDJsSUZcoNXqPVQO1QOREbMELn+mMYg8SOtMbZo0tsC5e6XngRyrRrJ83C8YgMh00v
         VrGg5ex4qH2UWcMbRz306JOCv5SIYbJsy24OZ41/ZrdgYsxHDH2VdbZht+n3+1O+OO9t
         +Xgvmml0xQZqVkT2vrqF22lBnzccOO9G3wr6WC32DiMsqB3pci03mgODqQWJJksMD8cj
         res9NjtNNWZVX9athasUpR5robaFfi7g9PFrJzwTaWUxhnI8yrCzuKRv69vkFQnvy0bh
         iEsoipeCa/MQ4/n9BfHgJpIERg+NRH31X0Rovou8uvIaFuwJIW+8RsBJ+siclpYl9qLM
         iRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGCDdLOP6mbLzolFuvbuBK9LCor0u7x7XonIolRCzRl/B4clMqDkXBqYTdlOmp/anwwm/z7rDzq/SEFxAi@vger.kernel.org, AJvYcCURSkawUWnF6qQooR5EjbCwYZYNlsLJJGs8gFu3e0czhpBwcWRluKmlb9erZcPBvtR4aMbeNr68zCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgwHKuBwTW80iTWHEc2q6J/OhMuh7QUDbE3QsKzt3Gibvj6FL
	pDX8iHC/t4f8n/oYYXkoiGG0FjSvLhPOK7BJ1K/+NFnICtq/d0guP0cR
X-Gm-Gg: ASbGncuenrCkKlKpT6FD91+RwBe6eMufZFEAeGtVPuLori5Je+pMToIabk8n939N1fD
	+Y2k4xx2LGGbrjpHZe5X8f+K8x33v8WzCkC0iKxuEB1RQpU1MyUoBb8emqr6yPxBxMtlRM9gOSS
	/L2kqDcfC0K5H/s98PtrR2g23gcO2p7eh7vkiXmOeWDshRate7aolEUGbqsNyprlYCMsbmQs+aX
	BlBIGvh+le7xsnl5tVv3t/928hhlR3NbpNk3raaTHpAA4oNqQlBmOTSS5AcYmHzTrgyrnh3l9m0
	gg6JWaCnP83/FSznO+YgiF3+IignTVPmizXvV92EULLACk35TWBt0FBnnRXTivltQjESlScOq7S
	hWKt2HutQ1QqJ+eOzH2N/+vAgeNDZVHqFtepyDo0=
X-Google-Smtp-Source: AGHT+IHyJqF57Cw2o8pzRyIpnhygA8fA+ni9UrVRDwZ07HgnOeaTDgKNg2z0GwlDf55b1hkS2LiC/w==
X-Received: by 2002:a05:6512:39d3:b0:553:1f90:cca4 with SMTP id 2adb3069b0e04-55b7c00bbeemr3857174e87.13.1754042838431;
        Fri, 01 Aug 2025 03:07:18 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bcd5sm543013e87.31.2025.08.01.03.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:07:17 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:07:13 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] iio: adc: ad7476: Simplify chip type detection
Message-ID: <0ed3a1e9346d84d20838e89a531e8d99f95bcb97.1754041258.git.mazziesaccount@gmail.com>
References: <cover.1754041258.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dkf8v2MGdo4/7nKW"
Content-Disposition: inline
In-Reply-To: <cover.1754041258.git.mazziesaccount@gmail.com>


--dkf8v2MGdo4/7nKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 driver uses a table of structures for defining the IC variant
specific data. Table is indexed using enum values, which are picked by
SPI ID.

Having the table and an enum adds extra complexity. It is potentially
unsafe if someone alters the enumeration values, or size of the IC data
table.

Simplify this by dropping the table and using individual structures for
the IC specific data, and storing the IC specific structure's address
directly in the SPI ID data.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
100% Untested.
No functional changes intended
---
 drivers/iio/adc/ad7476.c | 292 +++++++++++++++++++--------------------
 1 file changed, 143 insertions(+), 149 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index aea734aa06bd..bdfffc4f5724 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -52,29 +52,6 @@ struct ad7476_state {
 	unsigned char data[ALIGN(2, sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA=
_MINALIGN);
 };
=20
-enum ad7476_supported_device_ids {
-	ID_AD7091,
-	ID_AD7091R,
-	ID_AD7273,
-	ID_AD7274,
-	ID_AD7276,
-	ID_AD7277,
-	ID_AD7278,
-	ID_AD7466,
-	ID_AD7467,
-	ID_AD7468,
-	ID_AD7475,
-	ID_AD7495,
-	ID_AD7940,
-	ID_ADC081S,
-	ID_ADC101S,
-	ID_ADC121S,
-	ID_ADS7866,
-	ID_ADS7867,
-	ID_ADS7868,
-	ID_LTC2314_14,
-};
-
 static void ad7091_convst(struct ad7476_state *st)
 {
 	if (!st->convst_gpio)
@@ -190,102 +167,119 @@ static int ad7476_read_raw(struct iio_dev *indio_de=
v,
 #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
 		BIT(IIO_CHAN_INFO_RAW))
=20
-static const struct ad7476_chip_info ad7476_chip_info_tbl[] =3D {
-	[ID_AD7091] =3D {
-		.channel[0] =3D AD7091R_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
-		.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.reset =3D ad7091_reset,
-	},
-	[ID_AD7091R] =3D {
-		.channel[0] =3D AD7091R_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
-		.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.int_vref_uv =3D 2500000,
-		.has_vref =3D true,
-		.reset =3D ad7091_reset,
-	},
-	[ID_AD7273] =3D {
-		.channel[0] =3D AD7940_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.has_vref =3D true,
-	},
-	[ID_AD7274] =3D {
-		.channel[0] =3D AD7940_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.has_vref =3D true,
-	},
-	[ID_AD7276] =3D {
-		.channel[0] =3D AD7940_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7277] =3D {
-		.channel[0] =3D AD7940_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7278] =3D {
-		.channel[0] =3D AD7940_CHAN(8),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7466] =3D {
-		.channel[0] =3D AD7476_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7467] =3D {
-		.channel[0] =3D AD7476_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7468] =3D {
-		.channel[0] =3D AD7476_CHAN(8),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_AD7475] =3D {
-		.channel[0] =3D AD7476_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.has_vref =3D true,
-		.has_vdrive =3D true,
-	},
-	[ID_AD7495] =3D {
-		.channel[0] =3D AD7476_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.int_vref_uv =3D 2500000,
-		.has_vdrive =3D true,
-	},
-	[ID_AD7940] =3D {
-		.channel[0] =3D AD7940_CHAN(14),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADC081S] =3D {
-		.channel[0] =3D ADC081S_CHAN(8),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADC101S] =3D {
-		.channel[0] =3D ADC081S_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADC121S] =3D {
-		.channel[0] =3D ADC081S_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADS7866] =3D {
-		.channel[0] =3D ADS786X_CHAN(12),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADS7867] =3D {
-		.channel[0] =3D ADS786X_CHAN(10),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_ADS7868] =3D {
-		.channel[0] =3D ADS786X_CHAN(8),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	},
-	[ID_LTC2314_14] =3D {
-		.channel[0] =3D AD7940_CHAN(14),
-		.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-		.has_vref =3D true,
-	},
+static const struct ad7476_chip_info ad7091_chip_info =3D {
+	.channel[0] =3D AD7091R_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
+	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.reset =3D ad7091_reset,
+};
+
+static const struct ad7476_chip_info ad7091r_chip_info =3D {
+	.channel[0] =3D AD7091R_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
+	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.int_vref_uv =3D 2500000,
+	.has_vref =3D true,
+	.reset =3D ad7091_reset,
+};
+
+static const struct ad7476_chip_info ad7273_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.has_vref =3D true,
+};
+
+static const struct ad7476_chip_info ad7274_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.has_vref =3D true,
+};
+
+static const struct ad7476_chip_info ad7276_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7277_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7278_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(8),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7466_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7467_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7468_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(8),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ad7475_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.has_vref =3D true,
+	.has_vdrive =3D true,
+};
+
+static const struct ad7476_chip_info ad7495_chip_info =3D {
+	.channel[0] =3D AD7476_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.int_vref_uv =3D 2500000,
+	.has_vdrive =3D true,
+};
+
+static const struct ad7476_chip_info ad7940_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(14),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info adc081s_chip_info =3D {
+	.channel[0] =3D ADC081S_CHAN(8),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info adc101s_chip_info =3D {
+	.channel[0] =3D ADC081S_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info adc121s_chip_info =3D {
+	.channel[0] =3D ADC081S_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ads7866_chip_info =3D {
+	.channel[0] =3D ADS786X_CHAN(12),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ads7867_chip_info =3D {
+	.channel[0] =3D ADS786X_CHAN(10),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ads7868_chip_info =3D {
+	.channel[0] =3D ADS786X_CHAN(8),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct ad7476_chip_info ltc2314_14_chip_info =3D {
+	.channel[0] =3D AD7940_CHAN(14),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.has_vref =3D true,
 };
=20
 static const struct iio_info ad7476_info =3D {
@@ -312,7 +306,7 @@ static int ad7476_probe(struct spi_device *spi)
=20
 	st =3D iio_priv(indio_dev);
 	st->chip_info =3D
-		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+		(struct ad7476_chip_info *)spi_get_device_id(spi)->driver_data;
=20
 	reg =3D devm_regulator_get(&spi->dev, "vcc");
 	if (IS_ERR(reg))
@@ -408,41 +402,41 @@ static int ad7476_probe(struct spi_device *spi)
 }
=20
 static const struct spi_device_id ad7476_id[] =3D {
-	{ "ad7091", ID_AD7091 },
-	{ "ad7091r", ID_AD7091R },
-	{ "ad7273", ID_AD7273 },
-	{ "ad7274", ID_AD7274 },
-	{ "ad7276", ID_AD7276},
-	{ "ad7277", ID_AD7277 },
-	{ "ad7278", ID_AD7278 },
-	{ "ad7466", ID_AD7466 },
-	{ "ad7467", ID_AD7467 },
-	{ "ad7468", ID_AD7468 },
-	{ "ad7475", ID_AD7475 },
-	{ "ad7476", ID_AD7466 },
-	{ "ad7476a", ID_AD7466 },
-	{ "ad7477", ID_AD7467 },
-	{ "ad7477a", ID_AD7467 },
-	{ "ad7478", ID_AD7468 },
-	{ "ad7478a", ID_AD7468 },
-	{ "ad7495", ID_AD7495 },
-	{ "ad7910", ID_AD7467 },
-	{ "ad7920", ID_AD7466 },
-	{ "ad7940", ID_AD7940 },
-	{ "adc081s", ID_ADC081S },
-	{ "adc101s", ID_ADC101S },
-	{ "adc121s", ID_ADC121S },
-	{ "ads7866", ID_ADS7866 },
-	{ "ads7867", ID_ADS7867 },
-	{ "ads7868", ID_ADS7868 },
+	{ "ad7091", (kernel_ulong_t)&ad7091_chip_info },
+	{ "ad7091r", (kernel_ulong_t)&ad7091r_chip_info },
+	{ "ad7273", (kernel_ulong_t)&ad7273_chip_info },
+	{ "ad7274", (kernel_ulong_t)&ad7274_chip_info },
+	{ "ad7276", (kernel_ulong_t)&ad7276_chip_info },
+	{ "ad7277", (kernel_ulong_t)&ad7277_chip_info },
+	{ "ad7278", (kernel_ulong_t)&ad7278_chip_info },
+	{ "ad7466", (kernel_ulong_t)&ad7466_chip_info },
+	{ "ad7467", (kernel_ulong_t)&ad7467_chip_info },
+	{ "ad7468", (kernel_ulong_t)&ad7468_chip_info },
+	{ "ad7475", (kernel_ulong_t)&ad7475_chip_info },
+	{ "ad7476", (kernel_ulong_t)&ad7466_chip_info },
+	{ "ad7476a", (kernel_ulong_t)&ad7466_chip_info },
+	{ "ad7477", (kernel_ulong_t)&ad7467_chip_info },
+	{ "ad7477a", (kernel_ulong_t)&ad7467_chip_info },
+	{ "ad7478", (kernel_ulong_t)&ad7468_chip_info },
+	{ "ad7478a", (kernel_ulong_t)&ad7468_chip_info },
+	{ "ad7495", (kernel_ulong_t)&ad7495_chip_info },
+	{ "ad7910", (kernel_ulong_t)&ad7467_chip_info },
+	{ "ad7920", (kernel_ulong_t)&ad7466_chip_info },
+	{ "ad7940", (kernel_ulong_t)&ad7940_chip_info },
+	{ "adc081s", (kernel_ulong_t)&adc081s_chip_info },
+	{ "adc101s", (kernel_ulong_t)&adc101s_chip_info },
+	{ "adc121s", (kernel_ulong_t)&adc121s_chip_info },
+	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
+	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
+	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
 	/*
 	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
 	 * point of view. The binding document mandates the ADS7866 to be
 	 * marked as a fallback for the BU79100G, but we still need the SPI ID
 	 * here to make the module loading work.
 	 */
-	{ "bu79100g", ID_ADS7866 },
-	{ "ltc2314-14", ID_LTC2314_14 },
+	{ "bu79100g", (kernel_ulong_t)&ads7866_chip_info },
+	{ "ltc2314-14", (kernel_ulong_t)&ltc2314_14_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7476_id);
--=20
2.50.1


--dkf8v2MGdo4/7nKW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiMkdEACgkQeFA3/03a
ocVqXQgAjqeXnMUbsGnMfzyiX0SU4hQNBCh97Cn8QCKx/sbxHAHHcKo6r++byvrC
/RgeM1pKh80B0fzqlHgXibGzJFk/BSAtFm9g/yJuQtlG3LtYVFPRG2yRRGyC+FNT
c/Hhguvf2HLQmpSdWL2zpSx0ujdPn0eHgQIwLoXD16bCNP68ZkEJM4k05JrzKFmm
xKtpFQPf2thAOWuYBRDuv3S4+fFF61zvCHwrN/Vsv9n5vW23j/ILBEjXpukxsKSh
eo+vTYBXCd1haLZenzBpbs18r/totCvypUmyTvp4HUQsn1fsciaeGVrrioCeuQcl
vD/tTtSao8egOY9b1ZeYvhh3vk1qhQ==
=6ADS
-----END PGP SIGNATURE-----

--dkf8v2MGdo4/7nKW--

