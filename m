Return-Path: <linux-iio+bounces-22325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A503B1C0EF
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84AC625375
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD320217705;
	Wed,  6 Aug 2025 07:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUbt173W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E3E21171D;
	Wed,  6 Aug 2025 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463848; cv=none; b=ZMEk5cqdJV9wMrhLrTXLwV5lXGDTQ9teexTBjowXHfAQd0PnfV9N2OODWL80EngAoaV2kZViZrZ1dmgz8CTsYREGloJdhUu11AhAkyzRQgpKMvqP6E18m/S3wxFIDnahR6k3Oy0XApTqi4Kptn643/qEz+XtXDFNPQ7fiyenVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463848; c=relaxed/simple;
	bh=hwtMa1B9TuJl9ZOzMky//EfcmefYCbzuGhAjPEcOPnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIHzAzn44YHAJF1+Gx6NRvQljYk+jnRjZNd+JSi7FREmdah6WmcDrw6JXVvs7fLcCxdLdJQUn1Z9jdeb5og5nW+n9zXyjnExJkHk3iOQd8YAkTyQzJKKYh4F8ura11jCbbjrdVUltA/6JN5l0fqSFABjW+CiOCD/eLJopcXhQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUbt173W; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3323d8e0ac4so51094211fa.0;
        Wed, 06 Aug 2025 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463845; x=1755068645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/IoDDRIABOObCmrxi8jBjNjIwGtA+S+pMEW+f05CYIA=;
        b=nUbt173WgvqqTXMtYT+STs7t84lQi7tLLVDRtEqU4oJsNERJsbS3mA+hF5Ao1otJyO
         hJ0Y+9Lbzgc1ghD3G19GeJlZ+fw8/xFk3kzHIPaB8lXnyTctQSOzamS9Sq47F5B64dij
         KcCfKcu/4Q/IbUaAkNcmoTMEjI5zlVCUxrQzcd2e2S2e8fWX99ShfgcUNetZmiSV2YF6
         mmbmM46nJSoPc/ZlqvyTISUoudKQyaSxUv30N9+mJVltcQTtCtETn+PocjucIBQBXpB5
         0TeLskzu2WvJJ1KWmAMhlnueDhJdmZSFKinKmDjhtFCTIZmX0cnnbD/vZ9/YG6AOUE1a
         F4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463845; x=1755068645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IoDDRIABOObCmrxi8jBjNjIwGtA+S+pMEW+f05CYIA=;
        b=I9O8sFtmu6CamXBaSTU8Vfz9NWQoS5mCVhqgEcbTiPpBvm/by/eOinVTJnd33xCSFb
         DmrH7njf33BpHsJ3PjAk59pi1bGGxRMiYvKzvwuhEyVGATAmittYoJ+HogsGhic/t7G2
         ZcyoYyYMaBVD3d+z1ZhKsOE7uv67s+p1SA6ObidRJdeb9TwpbtdKIkcXuf5hkcsPOEvJ
         f3ysdscwDFRwH3ANx4drcf+WFI0nyfigcdQQDkHsRqTLB4u+msFa1ACAbGkifgoeyxF0
         bASn0DGTYTmUXrWqq+FNT+8aPtXwkWiHVgneaw1zaDs0Q4+g0QPcssXPOrbtXL/fCMkc
         iEYA==
X-Forwarded-Encrypted: i=1; AJvYcCWkfgSeihCTzCN80E0y4d5EjjBXGuhpeMwSFKQRzyyxPJrwYpGSju/Ogq4qzkcXMNEoIL0d8o/gZKog@vger.kernel.org, AJvYcCWxqFnrzBpbAWOjQx4pXKh87bL/A3Z1fggY+HnWhYyiBZKjKZwcEM0B7rR+fzSham0kQdP7kUsOZhL/Ay0L@vger.kernel.org, AJvYcCXHL4tOEB2Pa6a9H1PT93+XjbebClbbeUvgU5+KivmX3UR7QJuVtK3G1IrnO+iTVuCs/LCndp2s2QiS@vger.kernel.org
X-Gm-Message-State: AOJu0YwdpxWt6iAhf+5kF1wN73k++2+/AHdRy4WbkfNZEvL+vATwXIYv
	UC1gH9Qq2G3EN2r50AodZtNWmEAaG1Tg1+s9PRvdOvU1XWPo0sCzidqa
X-Gm-Gg: ASbGncv27w93/5K7TK7wCM7dqtdWVocaVnj42mK+Mf/JdPioNzaJGMPoXwY13TcRo6X
	7Md0+T4ej2LHqdYNbOS0fQvb1KsFiJ3xW7uS028WrMT11gLmR7reFXQHsnuD06GQH30UgvYBiEH
	jlBkXBVS/LDVSnnYQ/vRWTteD8cwTjkJot8/RgYnDQLPMHmdqHQQ4pUeZXYHpsf2ImJLO/3qVco
	l5JJ2CwATZvxDnmeqljD0v24QCPz8m92OzrETDrzH9IzjGetJ1+cJTJSO3Dul5X/Ca2nyYJoPjy
	IEzZymSrBj/JeUb2P9mm3WdgtD24CXBBLWLFVDKbjEhagFXc1enM6BW7MPJcJgdcaWdKTdLNlAA
	IsUxA2/8ZRJAn2/FXujTopNoGfjmy
X-Google-Smtp-Source: AGHT+IHP6rKzt1qa9m4jiTXy6M3RTEmEmUg++BPMOHjQeRhGi8O8F3sLaC9yCcxLhKwPrfUMMqyeEw==
X-Received: by 2002:a05:6512:3f14:b0:55b:7947:e316 with SMTP id 2adb3069b0e04-55caf35bf2bmr568417e87.26.1754463844646;
        Wed, 06 Aug 2025 00:04:04 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c98c35sm2249459e87.97.2025.08.06.00.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:04:03 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:04:00 +0300
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
Subject: [PATCH 5/8] iio: adc: ad7476: Conditionally call convstart
Message-ID: <2030974bcd7a6fd0a904ae8dc9e9872086c59886.1754463393.git.mazziesaccount@gmail.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MCDLFsQ7gMQ0bgWA"
Content-Disposition: inline
In-Reply-To: <cover.1754463393.git.mazziesaccount@gmail.com>


--MCDLFsQ7gMQ0bgWA
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
The follow-up patch adding support for the ROHM BD79105 will bring
different 'convstart' functions in use. The IC specific pointer will
also prepare the way for this.
---
 drivers/iio/adc/ad7476.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index fc701267358e..1f736be09663 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -32,6 +32,7 @@ struct ad7476_chip_info {
 	/* channels used when convst gpio is defined */
 	struct iio_chan_spec		convst_channel[2];
 	void (*reset)(struct ad7476_state *);
+	void (*conversion_pre_op)(struct ad7476_state *st);
 	bool				has_vref;
 	bool				has_vdrive;
 };
@@ -70,7 +71,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  =
*p)
 	struct ad7476_state *st =3D iio_priv(indio_dev);
 	int b_sent;
=20
-	ad7091_convst(st);
+	if (st->chip_info->conversion_pre_op)
+		st->chip_info->conversion_pre_op(st);
=20
 	b_sent =3D spi_sync(st->spi, &st->msg);
 	if (b_sent < 0)
@@ -164,6 +166,7 @@ static const struct ad7476_chip_info ad7091_chip_info =
=3D {
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
 	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
 	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.conversion_pre_op =3D ad7091_convst,
 	.reset =3D ad7091_reset,
 };
=20
@@ -172,6 +175,7 @@ static const struct ad7476_chip_info ad7091r_chip_info =
=3D {
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
 	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
 	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.conversion_pre_op =3D ad7091_convst,
 	.int_vref_mv =3D 2500,
 	.has_vref =3D true,
 	.reset =3D ad7091_reset,
--=20
2.50.1


--MCDLFsQ7gMQ0bgWA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiS/mAACgkQeFA3/03a
ocWV/gf9Hkxj16WdJh1g3eHtEEXatZcMrQ588CnaGAlw9CK4fuJktuR26qflPa2/
HP1mPhRTFaND+2Y4HAUBg6ZMtBhnwdoM/I6E4kmQ4gPe4c25W0zUT6WQSJKPIgps
TAoPFtzxfSuy2IvJpGEC4IfCJuIZd1bmXzP7inVsNPiLE2MT+ywfTFmmkSu8tTl/
qlXDJO9X0R5YuxEt2tWBygEMr4WTYR6Qy36JRs2zsox7zGL8Eo2jQf+7OUCC/468
qhIHz/ciBoJWKn3sCCYMKNdpRFqfKq6scL4UcaVkqrNBTBcz/cPErcDR8imKPmBF
jiUHSCfTwrqALsKpqP330f20SJoskQ==
=jEMm
-----END PGP SIGNATURE-----

--MCDLFsQ7gMQ0bgWA--

