Return-Path: <linux-iio+bounces-22390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E02B1D4E5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807E1625159
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0DC260592;
	Thu,  7 Aug 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMfYh85Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6433E2609D4;
	Thu,  7 Aug 2025 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559301; cv=none; b=btW+XJxoZ2M6TV5Af/U5nzlR6PrEmfFJRZmEECBIFgQ/PDcEpHaEhUe21qmssS82Ny6d3lH6VFOe9jsz7uKOC3XcOEswO07bsHw5gSruV1/oakzkajQUbKTs62LuBgujDnd/sO1zglP1P40M26lM7XkKGc3tIogv0JFCM7bkv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559301; c=relaxed/simple;
	bh=KQZ6ovOmuImtp+CBBb7QEeca0yE11Mi6Ia56+2Qfk/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI6N2k+6lZBCEmIT53saJgGXUXqdDcUAXu1V9S6bqlgdKNMy+Tcj6wg3rRRzUXRPn+ySxAyeziKW2fQY/GtH6fxj7dcQE/vz09aryi2f4Qm7vkzphl5svhRNViUIO6qiAFgGajTPxJf/kai7PKBtBDQ8jLrz8Dx219kIkFw9NHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMfYh85Z; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-33275f235ffso17007381fa.0;
        Thu, 07 Aug 2025 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559297; x=1755164097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fKfv0Nkf2vBcw+8Jy+gZgUsJIuuiqMC+PcsITHGfZw=;
        b=kMfYh85Z4/P74u/PxavE+FGgUmp44UgOUzPETYLVjLCk5ShkrUXKfwD1KKtLQhO72h
         69fIuWwNrs6ShOv5nIlWIScM4yI7u19lJYHwhnxzsGJS+NL9gT25WmViJWhc4xXeHmCB
         bbCkbFZl1tZe39nkdJJEtQ7v9/s+nh3h+fbqBCLh3pVMmnWg2EfNFavhYXc7Ek+Kj1IC
         OHO/CTXuB3EhqUK7f9dYG89rL6otxDIKaMq0GwWsyFD529X9bR80Kc5ZA6oWLkCVkSc7
         go0/5yyPeDJacMQseM2cSh7fJFQ5HsFWLNR7MMOn70Dm/AIH76vzvEmSCj9he/2/AJ71
         gQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559297; x=1755164097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fKfv0Nkf2vBcw+8Jy+gZgUsJIuuiqMC+PcsITHGfZw=;
        b=kdDK5m6uDeAvBPI/JATDwPcf7Wq6eCwnNdeeVZ0r2UMUZCBBQwW5Z2Mtlj6/nqT31k
         hM1TgIYsaQ8/O8lRZmtzLZExtoZG+XTu8Wfy5UIShX6u3UazF3I1E2rR0oGOdvePCltO
         EIHBEog9lh0A/yJ58Na86kZfrEq94tu5kg4/yj04yIGpBCOOPBNE8sjve4KZ42LLpvLU
         V4k4EkFCkaCZNtl7tINbaGfKUdZeYBO2qD8HTy33eZMPUmX2yOos3CIX7ydCoMPjae5h
         DkY3r5bUXWha5o3dZMKqNdNfX4xG/akBLED3QutEO3ZzJXbQHt7cNnG18+Rm4YBSKMKE
         rHRg==
X-Forwarded-Encrypted: i=1; AJvYcCUpm3odB7IDmYpz3Zzd5NsfmUUcOTSI81N6SN8W4w0tTZnaJrx2sPQdVC2UgLmWSrqek+zrLEHihrqNY67R@vger.kernel.org, AJvYcCVcaUB9ODFLYttJU9ANT04+1lBSO/tAsIbJXNnzEsLLZHoJ4wTCVcztJnzqXvNNak5r6KM4xLnsIUjG@vger.kernel.org, AJvYcCX1CfE54fkhGGAGHo2C58vOXOxBHuqp/Ipv3zOZkQhv77Tz64g6cbR98HsgmZiPXona0nuhe2+5Y9Uj@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQ+HO4iQAYTYSklSO9k84l5TuuVP1GUbTMx5qNijeQuzeUm2Y
	Ar8cZkF7yLY+ZfmI6M6gaWpmlJgRfx6qvSx2NSdQUWXicAJOReUtng1YIVYoEg==
X-Gm-Gg: ASbGncsxc0A23hual1kVCIEXtwXio+OzXn6gpaTY5cSvNL7AQpjOYsUEnjzaslrZR9I
	xTqApmgZhCqzKfFRrcIg9dfKsy4mPSn1f4lSRX+1u7uF7gQL28ONcd76x6e0yZ/48iQEKPB8eSV
	jOv29vl9pev9UMGCZ/EE5UQY+H0QvjqXVBeCjXoPqcNR9++ZxK0/LmbH5J3Ovwshlbx5nXzm+NO
	QeFdVXFVZlAxCrWnAL4piObLtFv44TeMJmonqzoz0TcI8MxoxbjPL3NmBegJqMv694ELCUFvbpQ
	xMrMGLogvfCdosIsNR3XJmsS86+tglO52U1eiJh1FbcbMolcbDGpplMFDroumg3YCwAYiKHNELy
	lG5zdhobM5hhDmnZsf5Djoy9XmghV
X-Google-Smtp-Source: AGHT+IHDJdJiUEu8Ar2bRub8FD3qZLUdU1BCkHGvq/qIWqK0EV8YDRR84YS96pGx9/VFq6qlOPTwmg==
X-Received: by 2002:a2e:b893:0:b0:332:13d4:6f6e with SMTP id 38308e7fff4ca-3338d124fd2mr8411851fa.2.1754559297066;
        Thu, 07 Aug 2025 02:34:57 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3323893c626sm28197591fa.79.2025.08.07.02.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:34:56 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:34:52 +0300
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
Subject: [PATCH v2 06/10] iio: adc: ad7476: Drop convstart chan_spec
Message-ID: <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bPRF+FJQWs6abA7X"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--bPRF+FJQWs6abA7X
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
allocating a mutable per driver instance channel spec an adding the flag
in probe if needed. This will simplify the driver with the cost of added
memory consumption.

Assuming there aren't systems with very many ADCs and very few
resources, this tradeoff seems worth making.

Simplify the driver by dropping the 'convstart' channel spec and
allocating the chan spec for each driver instance.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> v2:
 - New patch

I considered squashing this change with the one limiting the chip_info
scope. Having this as a separate change should help reverting if someone
complains about the increased memory consumption though.
---
 drivers/iio/adc/ad7476.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index e97742912b8e..a30eb016c11c 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -29,8 +29,6 @@ struct ad7476_state;
 struct ad7476_chip_info {
 	unsigned int			int_vref_mv;
 	struct iio_chan_spec		channel[2];
-	/* channels used when convst gpio is defined */
-	struct iio_chan_spec		convst_channel[2];
 	void (*reset)(struct ad7476_state *);
 	bool				has_vref;
 	bool				has_vdrive;
@@ -41,6 +39,7 @@ struct ad7476_state {
 	struct gpio_desc		*convst_gpio;
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
+	struct iio_chan_spec		channel[2];
 	int				scale_mv;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -153,24 +152,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
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
@@ -282,7 +275,7 @@ static int ad7476_probe(struct spi_device *spi)
 	const struct ad7476_chip_info *chip_info;
 	struct ad7476_state *st;
 	struct iio_dev *indio_dev;
-	int ret;
+	int ret, i;
=20
 	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -332,16 +325,28 @@ static int ad7476_probe(struct spi_device *spi)
 	if (IS_ERR(st->convst_gpio))
 		return PTR_ERR(st->convst_gpio);
=20
+	/*
+	 * This will never realize. Unless someone changes the channel specs
+	 * in this driver. And if someone does, without changing the loop
+	 * below, then we'd better immediately produce a big fat error, before
+	 * the change proceeds from that developer's table.
+	 */
+	BUILD_BUG_ON(ARRAY_SIZE(st->channel) !=3D ARRAY_SIZE(chip_info->channel));
+	for (i =3D 0; i < ARRAY_SIZE(st->channel); i++) {
+		st->channel[i] =3D chip_info->channel[i];
+		if (st->convst_gpio)
+			st->channel[i].info_mask_separate |=3D
+				BIT(IIO_CHAN_INFO_RAW);
+	}
+
 	st->spi =3D spi;
=20
 	indio_dev->name =3D spi_get_device_id(spi)->name;
 	indio_dev->modes =3D INDIO_DIRECT_MODE;
-	indio_dev->channels =3D chip_info->channel;
-	indio_dev->num_channels =3D 2;
+	indio_dev->channels =3D st->channel;
+	indio_dev->num_channels =3D ARRAY_SIZE(st->channel);
 	indio_dev->info =3D &ad7476_info;
=20
-	if (st->convst_gpio)
-		indio_dev->channels =3D chip_info->convst_channel;
 	/* Setup default message */
=20
 	st->xfer.rx_buf =3D &st->data;
--=20
2.50.1


--bPRF+FJQWs6abA7X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUczwACgkQeFA3/03a
ocVTbwgAhrHR8JRotB74Lfxu9MNuH5TaC9uKDmd/toJz36TfJ0WidNLw204vYdzE
qTT7StYqLqzoKYzi5GI03vN14TKBQ89YC3ZgkKx3PHk0XnZtgRP8Ny2hbay8dKsK
4uxr3DQ4LDYnK3DIxyHEbF9DVVvtqJ6QR2RI1lxJezzHyLTWTeU/LEVXJz294I21
3AGCA0ruRpx3SaUImzn8/wTEDtvVDS2A02mLdf7Ng4pTGV/4Vja9X6v842BX1Q1d
6aIbC3KdEZwgoSKMMmgfJWBu6s53/U5XMbDcDdMgEcrRsp2gqrlQ/DULv3on6HzA
v523f86SszKuNjO8tiF7Ri6CPhcgNw==
=/WKm
-----END PGP SIGNATURE-----

--bPRF+FJQWs6abA7X--

