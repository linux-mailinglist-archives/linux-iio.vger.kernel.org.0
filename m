Return-Path: <linux-iio+bounces-22548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E2AB20249
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C317D4216FE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1922D2DCBF3;
	Mon, 11 Aug 2025 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8aU3SFF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ACC2DCBF2;
	Mon, 11 Aug 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902296; cv=none; b=k4zT6nTYs30GCuDo8R1jgNgp7yH/uSV2HQad5JjorkmWN7szkfQypUBpij0/aQSl48cLP8i0ygKYfSgbFAXNCgF9yAqf8YXUhyx1OKulNhMtkUwWI6/QSFoEG7rdBIikz9214ygihbvtD5Yy3Z7YrFe21qPyWJES0FCWmac2eHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902296; c=relaxed/simple;
	bh=/Vnky2iqRMx7r7Ax8IGIXak+StDACGUg1XrbsYbfuF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc0Omop3fB86dijdh0c/Wx2lxQPYoKF8KvMN2NFaRcKkrd4YkrZ7nTrC2OWLE6xjazjRNpAtmSIGGW6EGgEnpYSzQC5tqxVtGUHpNaVJh0V2rYp9CjJBHpS7LGiuaP7FmIZ/zFeXCzvc6YbmW365tzv/aKdDieOcbVzSlR5/3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8aU3SFF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55b9375d703so3956104e87.3;
        Mon, 11 Aug 2025 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902293; x=1755507093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuWxdzDiaehJlYEQjhVRrrYl9Kyef8+nTjKfvh6jf68=;
        b=P8aU3SFFGyMRO1a2FNjt+Lkb+PIjqzVerT5CewWO4mR8m0zi5vK8duRvPONhFeubnJ
         BIySO5jaKFPNtGoOkdkgK5GwXuAXR1KzZ5UXddUfgBePckUouR0rLd0LDPZIwk/pmBzy
         s4+SmLAaQz7AoioYrXtc+QHOh03aI35BlX6wSB8VoCYjVz544aHwT6wc/NeMrAHzXpNH
         5b0fmeKlb4qfGGrajCqAjx+DLciK3ihKNmCX0mUspFC5Wg9soe6PM2fSM0tMZciA++uA
         xDZ4AMreSyR8KAacKduXL1uACtPlN60g2xecyc9GDBPTM19TPNPHfVs/OCyapiDZDI3I
         Inng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902293; x=1755507093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuWxdzDiaehJlYEQjhVRrrYl9Kyef8+nTjKfvh6jf68=;
        b=gWcZYa6VDohml6QtyTazgue2NeAvcwJendLRd2MWz2rMPWiNMTIEvVpMIdzRhHtuUk
         w1lvjsPKLbXQX4ncGU2DM9tgL2HG4D8B+eIWsJOfiNDna+TqzvFf89T5yxAVDhcV2SMH
         PIylK7Cif2MWXYrNk683tstkLVBOfb/zppFStPjUPX1tBB3kVeNB8XHpPC0IE/pSeXD3
         K+Zrhwk5VoT1uGZMXH2GgiGVefh2AkzJ+hPAWUWCtOC94inOVH5/Hr6sxRjOmGBA+0w0
         pCu4Wc8YkVKXKTYvQctYQQB3uETf2xFrR+U0CQfeRJiJ87ORuUYnGWAInNrmTnix0iPb
         PIhw==
X-Forwarded-Encrypted: i=1; AJvYcCV1KFfhxlGm/2ndkxdJ4ojxIHtJTR2fwphmHlhohfiVTbRfH615oWZPswOliWPVHaP+x2fizbiYN9kRaafw@vger.kernel.org, AJvYcCWqExposjdY5ksQXbhSPVv53zSZay+AgLVvzDf9hrKHRwC2tB8idEaSJbIj0Lb7NHihjKqpuWEmJkUx@vger.kernel.org, AJvYcCXB/hX0MtdQcZrEG4DzGEYH4ZfkRai4tWgfxi+CPYOwSV39JDSqGuzORwQL88HgDX6yOM9OPtEik/yj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Y3GIuSHfkVHJaOGh8QwgKCQEv5dWfqGUxiSzhCQlh93Cizwh
	CGgVoxyggqQFScl6slnHJo77beii2dP1W/gLnTrPifv8rBxK7Z0y2C52
X-Gm-Gg: ASbGncs+LoRZSeS6m73clraSwq21oLhD+4rRwxZUcEFkt7a89fbALWHeqw6ndWubGua
	OeGTmLcSVhtlSL6HD3bsdRJBUdzRvzgLky6CLXdOyW7rdjA3i8a1cbyMouTgrEQ5QMqt4k4Cv5r
	uRYypyW1smI85B2byzv13onYexQkGUmZmwKt5WVCK+A2XkzuWV1WbrtenBdEj7nkpGjak7rQNUz
	F5uomn3Vjx5B0fD8M0n6ZlyFYLJzoJBuDfh2+o98Nx+Qf0ke/IeXLkGN6yq9YdWstAylcCMFt24
	l+JN5LR6bQA9E5WRiO25AHJLvUNGQHUK4+0K/ZM/CgcuLDrPACjWeVC9os/6gtw9igylEShdzKj
	lbb+HYMv9iNitFp/wcMnjaexZqUfl
X-Google-Smtp-Source: AGHT+IHNVyQLH0DilTgBNOFCK9SlfrEy0aR3YzUjpUY0uxGDQP+JsKJIRT1iU0SsfDGwPJNXSGQPuw==
X-Received: by 2002:a05:6512:10d0:b0:55b:9483:81b with SMTP id 2adb3069b0e04-55cc0123bf3mr3340354e87.34.1754902292823;
        Mon, 11 Aug 2025 01:51:32 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b887f72f4sm4237349e87.0.2025.08.11.01.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:51:31 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:51:28 +0300
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
Subject: [PATCH v4 06/11] iio: adc: ad7476: Drop convstart chan_spec
Message-ID: <cd7c72e3ee00f279d3381873f54e0c5b75b5ad11.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qUzuhLq20cKqadNw"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--qUzuhLq20cKqadNw
Content-Type: text/plain; charset=iso-8859-1
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
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---
Revision history:
 v3 =3D> :
 - No changes

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


--qUzuhLq20cKqadNw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZrxAACgkQeFA3/03a
ocVDzAgAmXdxFkwmCGS3i4kD4BBfxI0MVfpwsQucvEu8r0VF3x2T1G2Nm9J8WZCx
tciL00SL1sY5c+KbFZ6kppfbU6skJCqbLPxYQQ4fSfAmwFRK9i2TI87+S6pdlja5
FPXhTz5py7X4JaJkOWtIbprC74yuznFLw/M18Mnq3xVHFViUUUjPaicn3B0Dxe7d
bgCAItpOWn907PZfxg3grUWQ6EYV3ego/Zdb1TomMvijR3JlySv4NY+nRkl7sF87
rMnPXThbPdG8BUgUajziBvRXKT7bJw2nm3MDWsA/RTC0Psa/tcYZv1rAVDamxI/p
yef/q0We3rWBkPSdqiwqaZ5JUn9oog==
=KcP+
-----END PGP SIGNATURE-----

--qUzuhLq20cKqadNw--

