Return-Path: <linux-iio+bounces-22391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A35B1D4EB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F017042A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738F323BCF8;
	Thu,  7 Aug 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM81ylys"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73A25392C;
	Thu,  7 Aug 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559313; cv=none; b=OXR1JV07yjOXKz0cx46I4KjzgSFBiKdVdAQ4D60/JJjn1P+m8ewSrk0C0T8Ytg6HZR7qzMbGG3Y9AowmHXPr8D25IBfJlOTQWFgf0UN1CUUXZK1FcWMVE9Gz0+3Nm54wdkKOiLrLrLcvN7GWxiX5Lv+P/3vIB1S5jSi8tetZLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559313; c=relaxed/simple;
	bh=l+woFtL1W7/UzA7zPRs3KeK7rXLUBLmGdQYdEXWQeZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD5w7bQBdSI5nmBJHn6OJwm/wxOuokve1tSCYYJpPYFzoTVgOfxrmWl/PS3qEXf9TtchHJRF0h0/wwKTJJeYdYk6XqdHXLmDF+rE0t7uHj54bnXmfZTT1fw08ic+9TM8Wq4ykyCeFfpoBxudtp+EaIfo1D3hAGnqDLXhDYCFoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM81ylys; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b8a7a505cso1064922e87.0;
        Thu, 07 Aug 2025 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559308; x=1755164108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3EUsBasMFAOAbCJ1sYS53/ushup2issIIHtvCrEMH0Y=;
        b=HM81ylyszBS8cvQ0voBhoB/xJVB+nkh+Y5oOeK2O6tDMhP7hKOWcqD39CLK7Z4bkMA
         9punGhQ+/2VcSq7KjZR+Fqhugni4AphzLPXbCcBYutKp5QX0gPb8U33wY5SqqhoQcAhM
         vrzEjzQZbWiAcu70rDa1S5JOc0z3MXui0lqMiuPVJ1jVrlVONxlIpDagNXywdqX+Srth
         mj3bk1xJjVV5NJf/rWy8G1ABHxrMCT9OtFk21qKn8XCKHvOQOzfzzEVN5W8ZCXeeTQr/
         wL1Y7tJq+KssxbtSwhPxwNMOKO++dt+A7QfVLi7DT1mR2wkKyyS0syrzpUpVsJd8vgIp
         vZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559308; x=1755164108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EUsBasMFAOAbCJ1sYS53/ushup2issIIHtvCrEMH0Y=;
        b=hKq28lDPSN9bpbcKwO0cYfPylHbP2lSAnvNUNyFGrYNogwdunGukgGoU3zcqfyR5IY
         W0yAkn4O9TPZsNu0iUqK4Wyl6G7JayytDGo/ciWsqFU9TF/vLfJRl2Dcs8vZopbcuafb
         GjiFOB8keuD0Puw9MAQZKYtjQVA6igGoJavJuuL6kPoJT5/ZYx7yR6pk65cu9+akgPyc
         T6iPSPc4DH1sQ/0Nl/hRWPCosrQfoZRMCl8Cr8xkj5/LbH2rt2zTRNZEShz/5Ff3ut8E
         jNB+4dPFkvpgG0ihnDEOAzfkTP16F1ncR43ixfGth5E5TdaZf+GthabuZSNfjUlRd7pd
         OPhw==
X-Forwarded-Encrypted: i=1; AJvYcCUlpp7WAbES1iow7FHer17c95MSJxMIF8NQacPmHWVG1JFLZSebmO/y4DDM27yQNbT1EGAW24O0LKCp@vger.kernel.org, AJvYcCV5VKzLq2VLMxin6zTRdLZWXkqp32xKibUSCKbHr/v3pzlTyrKLLzF2KUNxdpEkoZdR7FV+dtipAhWa@vger.kernel.org, AJvYcCVoXh14PHM4kDYp5eWJWuCK7earlAAYTQ1hNYDhMXTNu1tn+MAGyzLCzXjiAiFiXkMvOeaVcEOeNKi8lswB@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKriBRn/mf0QMnoCiPN2exR4U6IRl1s+Ef9+UMDS+pCt6u11T
	m44qBgBaRKgcTTBVhCILP5tqXPJaoSphP88aUiQsFfznpYxcUzHSgsRZ
X-Gm-Gg: ASbGncsm2uN1dIZCejLlq85zfqg/dMQwcQIhYPgQc4gfgPQxH5j0olKM6RK7qhCNvg5
	oIZwevXdGTNq+GY3Y/+KQIwPZzzWHSKX9CReZdvq1O7eqaXnKp9YJCBEaW6XIhuYURISHeCA8YE
	lQ/KhnKzm0oKpwdhLiSpzasU471hJsgmt7Lnp3bWgKow77urmO6PCXyAsgspkJW3BqBmIav6uXH
	ACv/yLKaAAUDLoJz7iYfiz9Ac+1hQTcIF3zu8eS+cPN9mkzWlRqymxVo8RHyhHwA+WcjhCqIrLG
	OG2CRDRiC+nBsB41ULHkXjtgc9xdVZwX1DKxWNYJVStAAheSaPMdUPAACdS5sLuZX1uac+jniX+
	sX1Ci7n6K9Yj4P+0XABkaRLjSHgE+
X-Google-Smtp-Source: AGHT+IHcHEgrIpvotg6381CRbJkhNqRvVe34a04NOFVw750G1c1wOB9+foZNqZMejeG0h49y5VLsRA==
X-Received: by 2002:a05:6512:3b07:b0:553:252f:aded with SMTP id 2adb3069b0e04-55caf517dd6mr2010470e87.6.1754559308225;
        Thu, 07 Aug 2025 02:35:08 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3fb1sm2599853e87.136.2025.08.07.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:35:07 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:35:03 +0300
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
Subject: [PATCH v2 07/10] iio: adc: ad7476: Conditionally call convstart
Message-ID: <bb96107301b249d4be912fa4384ed4de7791410b.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wHHcPTbMuBFq7jW5"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--wHHcPTbMuBFq7jW5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports two IC variants which may have a 'convstart' -GPIO
for starting the conversion. Currently the driver calls a function which
tries to access the GPIO for all of the IC variants, whether they
support 'convstart' or not. This is not an error because this function
returns early if GPIO information is not populated.

We can do a tad better by calling this function only for the ICs which
have the 'convstart' by providing a function pointer to the convstart
function from the chip_info structure, and calling this function only
for the ICs which have the function pointer set.

This does also allow to support ICs which require different convstart
handling than the currently supported ICs.

Call convstart function only on the ICs which can support it and allow
IC-specific convstart functions for the ICs which require different
handling.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 v1 =3D> v2:
 - Adapt to the change which removed the chip_info pointer from the
  driver's state structure.

The follow-up patch adding support for the ROHM BD79105 will bring
different 'convstart' functions in use. The IC specific pointer will
also prepare the way for this.
---
 drivers/iio/adc/ad7476.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index a30eb016c11c..8914861802be 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -30,6 +30,7 @@ struct ad7476_chip_info {
 	unsigned int			int_vref_mv;
 	struct iio_chan_spec		channel[2];
 	void (*reset)(struct ad7476_state *);
+	void (*conversion_pre_op)(struct ad7476_state *st);
 	bool				has_vref;
 	bool				has_vdrive;
 };
@@ -37,6 +38,7 @@ struct ad7476_chip_info {
 struct ad7476_state {
 	struct spi_device		*spi;
 	struct gpio_desc		*convst_gpio;
+	void (*conversion_pre_op)(struct ad7476_state *st);
 	struct spi_transfer		xfer;
 	struct spi_message		msg;
 	struct iio_chan_spec		channel[2];
@@ -68,7 +70,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  =
*p)
 	struct ad7476_state *st =3D iio_priv(indio_dev);
 	int b_sent;
=20
-	ad7091_convst(st);
+	if (st->conversion_pre_op)
+		st->conversion_pre_op(st);
=20
 	b_sent =3D spi_sync(st->spi, &st->msg);
 	if (b_sent < 0)
@@ -158,12 +161,14 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 static const struct ad7476_chip_info ad7091_chip_info =3D {
 	.channel[0] =3D AD7091R_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.conversion_pre_op =3D ad7091_convst,
 	.reset =3D ad7091_reset,
 };
=20
 static const struct ad7476_chip_info ad7091r_chip_info =3D {
 	.channel[0] =3D AD7091R_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.conversion_pre_op =3D ad7091_convst,
 	.int_vref_mv =3D 2500,
 	.has_vref =3D true,
 	.reset =3D ad7091_reset,
@@ -319,6 +324,7 @@ static int ad7476_probe(struct spi_device *spi)
 			return ret;
 	}
=20
+	st->conversion_pre_op =3D chip_info->conversion_pre_op;
 	st->convst_gpio =3D devm_gpiod_get_optional(&spi->dev,
 						  "adi,conversion-start",
 						  GPIOD_OUT_LOW);
--=20
2.50.1


--wHHcPTbMuBFq7jW5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUc0cACgkQeFA3/03a
ocXCoAf/XHp3S0MqqKrZEKJOs6gVkUhEQTiQ2UVMqyhWf8kHnXctWt3AU1nsxglu
CxQ4rREWA9I82IbFZNfQKBLPKnKamaAOPwiL/xreXWw44E6RsZrxp+CE0c2/zWxS
A8F1+RuPGGn0r1mfU0ZgwTnRx6QYxfshEMhZ/U5xoY2sFEvNIMEixWqPqLysKeIX
PJwM4htoJ7XJe/nnJiTXWPxEC4XkUyIokFjxpEF5wD8ARS7jYP95Muw1h9eCPfTS
5fMKtl0jCplrO6BUJcO30sFMnaUmqZ1bT6ePhZR4xehqdbMUufih0F0BN7nakQl0
ik4sx+uUXlXjvWzLcwNdb4pNA9TeQQ==
=RWSm
-----END PGP SIGNATURE-----

--wHHcPTbMuBFq7jW5--

