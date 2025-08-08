Return-Path: <linux-iio+bounces-22435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E156B1E508
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E3C18C7563
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123826A08D;
	Fri,  8 Aug 2025 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxzo5hen"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D28266EFC;
	Fri,  8 Aug 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643219; cv=none; b=GRxMt729cx8EWdBQkQJEmPhBk2611ttJXhtie/XGJDp/6pAeXMNVFDHLVa9+lRJtRj8+PsffteI/nDKu0i4eEQ9pm81Qidz15/C5A5+5d41gXaNjW8a/Ql0En+jj33ElbM78eW1zvBC8dFyDIWuKrK2/un6EcYvDyOFTW0ztM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643219; c=relaxed/simple;
	bh=sGcmvCCkuD4TFvA9CCB58Xk9MMl4mueGmFJlTd+8tI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByLX+ClLMraHg6CWwGttaXZJGThFPo3c3dcvgV6erQHtIltsMjyvkWS3DF0pNdB7H6K3fkyAWSfH4BvXZE4A8+O7RSwMBt+8N2/1LIdHbQG2ll6ArWF94tDndpfvqdI/ryvGZPeYeQoBaqEZF56YGN1Zun7DqQzd1HdZB5pVAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxzo5hen; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3322a34e84fso17053051fa.0;
        Fri, 08 Aug 2025 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643214; x=1755248014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TC755O3UA0g/O5J4PLl4KCN+52Xn33ErgZAEv4wP64g=;
        b=kxzo5henD+c/i3ZX7GctUaaeXJwujxm8pGLAynpTegXmDpYxuvf0BbuYLElpI0aNOA
         UJO9kIPBx+t9JuLucfwV64AF5WgQXwp6AD3omAyyg+JViHGznR9zRoHHnNVchauH9Zf5
         RZifWhWwsqaTU/Hm/nkb7LtHu86nBDYflc5FCPR6iHEg4zDPgntagZZ79mSHCFuNaibw
         6n+YJn7yyL0zOFeP9oMM2IyolpMzCGNm9NeYZwO2HWVOPdeDtr1Vtb9mxvZ7/i2YtTp1
         RHcp+PilDLN8Z87EMTqSPygPQEb45Z9ZBku2nDX3eV5p704Q4EnJeJNPQ3QSUeH2Zy80
         aLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643214; x=1755248014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TC755O3UA0g/O5J4PLl4KCN+52Xn33ErgZAEv4wP64g=;
        b=MBqPf1P/hm6pZiCsMtEVn9eIar7JY9UwTM9T0+9s2Nn2StMxQzze8PaQturMr4BNRq
         Txo7GiUnB/dUshikJJ/TYDo+KECDj11AMq5YhJHPonnMkxFqbhjJTRK6KJT0pR0Cd2EM
         kVuOZ1BdiYbi7KNk/JItXFRFezQr3G6zlA9mvz8maPQdsfnEmGPTudAibKvph9ubJEpX
         Hx8xzxgDzTlpOcNaHjO6YLJbGuaHUrmU0u/Y/568/5XYq1mEBTtvEUOUYXXVjBmRb3gN
         OjNDpbOV1beTgLwLCaAOiJJdV/GEAM/52ydVQfZC4FeXR3yZ8Qgf4X1mUnfoVpcDt5cT
         dGOw==
X-Forwarded-Encrypted: i=1; AJvYcCUSSxHCTcFzbpL/IrLZsAwAMKw5dzZiQ6niNAka9GVaaU1T+b0VKThFIK5sqGW2KllBm+DYug4oYqeCFoHY@vger.kernel.org, AJvYcCVvvCCav7iHbUMnMlZ0L3XZjzCl9pv4D1FzVKWeDSoXveWiMz+C9/YN6759jax3uvoW5qji/Y2JmOFK@vger.kernel.org, AJvYcCWaMBfTVESNQ2WwjmHHTG0jG+NFIvuzKLkH3iDRsMw52vZZrSNUirTDAo9sLXVNgjXBwabY05JEaZYY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JyfbJ88qj5y61UGjfkTwH21S5nDfYQLElw0DyQN0QXoIZpWK
	3b3q7Dd3H3D5YAudjfPjgg7bMhCF9YaoLY14EWFlaDd/3Qqmu6UJqfeg
X-Gm-Gg: ASbGncsx2/5SEWHk7d2WXA1YvDmBlM7s/73hTQblHxnXSnYmtjQpOGjgaS6PhJXWXTG
	3nSqjDxbUd0u4HIhEC5/bAio/aHvZ0OD37O0SlfFV+IVmkFZPpBMUvB5msWW2HpWGfm9/gIcfoN
	hzVPlpftaXYiBYrXchFJOkJOMjurtef6GiaaUXGlatDIjCm83cy+iEVwxUhz19GcUHjvAnkfjzh
	RjV+kPfg4ywyLM+bomOdiCOzVt0nhP1+7uqf/S7J1IjqWSYW1hFKDOmHZqn9a+cUfDjelIyt52J
	833AEyXmZ989KRFXaMmuocebKO/JcRiLk2JJp+zLIrBp2zr/cmKrvvZBu5UqKywp0PBkNZt2m4H
	CqiL/uSlpPGQ0GHtRi5n7u3i1dmcP
X-Google-Smtp-Source: AGHT+IHEY7XI84xB5fZ8gDYWIsh/qgurALzwFw49Z1QNlCZibQFaYU9lAwVmSYbQNmJKbawQ6HKxlQ==
X-Received: by 2002:a05:651c:f02:b0:332:6304:3076 with SMTP id 38308e7fff4ca-333a2148f34mr6475291fa.1.1754643213769;
        Fri, 08 Aug 2025 01:53:33 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3327e325a42sm11684241fa.59.2025.08.08.01.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:53:32 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:53:29 +0300
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
Subject: [PATCH v3 06/10] iio: adc: ad7476: Drop convstart chan_spec
Message-ID: <8ed500a973d14460f541f1701e4423eb11b1f179.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V2qZQqwVIAoZBGk9"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--V2qZQqwVIAoZBGk9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 driver defines separate chan_spec structures for operation
with and without convstart GPIO. At quick glance this may seem as if the
driver did provide more than 1 data-channel to users - one for the
regular data, other for the data obtained with the convstart GPIO.

The only difference between the 'convstart' and 'non convstart'
-channels is presence / absence of the BIT(IIO_CHAN_INFO_RAW) in
channel's flags.

We can drop the convstart channel spec, and related convstart macro, by
allocating a mutable per driver instance channel spec and adding the flag
in probe if needed. This will simplify the driver with the cost of added
memory consumption.

Assuming there aren't systems with very many ADCs and very few
resources, this tradeoff seems worth making.

Simplify the driver by dropping the 'convstart' channel spec and
allocating the channel spec for each driver instance.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v2 =3D> v3:
 - Use __set_bit() instead of |=3D
 - Swicth BUILD_BUG_ON to static_assert
 - Clarify a comment
 - Improve commit message

 v1 =3D> v2:
 - New patch
---
 drivers/iio/adc/ad7476.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 1445f0f599d9..ad9e629f0cbd 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -6,6 +6,7 @@
  * Copyright 2010 Analog Devices Inc.
  */
=20
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -29,8 +30,6 @@ struct ad7476_state;
 struct ad7476_chip_info {
 	unsigned int			int_vref_mv;
 	struct iio_chan_spec		channel[2];
-	/* channels used when convst gpio is defined */
-	struct iio_chan_spec		convst_channel[2];
 	void (*reset)(struct ad7476_state *);
 	bool				has_vref;
 	bool				has_vdrive;
@@ -42,6 +41,7 @@ struct ad7476_state {
 	struct gpio_desc		*convst_gpio;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
+	struct iio_chan_spec		channel[2];
 	int				scale_mv;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -154,24 +154,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
 		BIT(IIO_CHAN_INFO_RAW))
 #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
-#define AD7091R_CONVST_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), \
-		BIT(IIO_CHAN_INFO_RAW))
 #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
 		BIT(IIO_CHAN_INFO_RAW))
=20
 static const struct ad7476_chip_info ad7091_chip_info =3D {
 	.channel[0] =3D AD7091R_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
-	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
 	.reset =3D ad7091_reset,
 };
=20
 static const struct ad7476_chip_info ad7091r_chip_info =3D {
 	.channel[0] =3D AD7091R_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
-	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
 	.int_vref_mv =3D 2500,
 	.has_vref =3D true,
 	.reset =3D ad7091_reset,
@@ -282,6 +276,7 @@ static int ad7476_probe(struct spi_device *spi)
 {
 	struct ad7476_state *st;
 	struct iio_dev *indio_dev;
+	unsigned int i;
 	int ret;
=20
 	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -332,16 +327,28 @@ static int ad7476_probe(struct spi_device *spi)
 	if (IS_ERR(st->convst_gpio))
 		return PTR_ERR(st->convst_gpio);
=20
+	/*
+	 * This will never happen. Unless someone changes the channel specs
+	 * in this driver. And if someone does, without changing the loop
+	 * below, then we'd better immediately produce a big fat error, before
+	 * the change proceeds from that developer's table.
+	 */
+	static_assert(ARRAY_SIZE(st->channel) =3D=3D ARRAY_SIZE(st->chip_info->ch=
annel));
+	for (i =3D 0; i < ARRAY_SIZE(st->channel); i++) {
+		st->channel[i] =3D st->chip_info->channel[i];
+		if (st->convst_gpio)
+			__set_bit(IIO_CHAN_INFO_RAW,
+				  &st->channel[i].info_mask_separate);
+	}
+
 	st->spi =3D spi;
=20
 	indio_dev->name =3D spi_get_device_id(spi)->name;
 	indio_dev->modes =3D INDIO_DIRECT_MODE;
-	indio_dev->channels =3D st->chip_info->channel;
-	indio_dev->num_channels =3D 2;
+	indio_dev->channels =3D st->channel;
+	indio_dev->num_channels =3D ARRAY_SIZE(st->channel);
 	indio_dev->info =3D &ad7476_info;
=20
-	if (st->convst_gpio)
-		indio_dev->channels =3D st->chip_info->convst_channel;
 	/* Setup default message */
=20
 	st->xfer.rx_buf =3D &st->data;
--=20
2.50.1


--V2qZQqwVIAoZBGk9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVuwkACgkQeFA3/03a
ocVy6wf/ZYuGJWJpzIqcvSLPQw6/tQ5+0bhjuMvUuOe3PLclUwVyMaP0/cRgS1bW
nzKBl6bij50L2USUzXvFl44WIV4YiturebYRmHNjmRZGROlzFDt5Iy7a7WqVl0y/
vDQWzKPUikYrrAUEmCNjzwQlQsI3FLLpeCcPFdG94wphIJLtRpIxcZF7iGdoWUia
WlgifxsgwxfbPUNsh2oTGMe/E5v5udEuo+0NKW8VptJHBpM8ZuYPwQK823op0okg
DYUNs8aweAGJfScerU4ilBpsgBPcBq8181/PqLdG9vM9pc8WEUfNDoy7TTwsemyM
cysnuue2juUXJoqphaybcLs/a19UtA==
=jXgG
-----END PGP SIGNATURE-----

--V2qZQqwVIAoZBGk9--

