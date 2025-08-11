Return-Path: <linux-iio+bounces-22549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8746B2024E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E613E18C010B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3892DE1E2;
	Mon, 11 Aug 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By7m2rDx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922252DD5E0;
	Mon, 11 Aug 2025 08:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902307; cv=none; b=F9O2Osl1haDjcvXgh6+rXDxWlZpQ/B2nx/Dcmu3Wp9CVN8cRgvUtvDvSV2QNXAFgxv+j5VDKQi0sG9Pt9Dw1C6o0Bz2JGB3f0OencmDLsP0Py3/8mG3/R3rcosDW9KUp/iBpZ6pEis/4nxIpFOR63PNM1Ewd4q5cdVKnScYK4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902307; c=relaxed/simple;
	bh=Fk+3uilsvTXsZ4oTWbIlmyRSY9KBkFoqsH0gBQl2XZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGiZdfE+73fsTaZy9DQ9R4117DVdcMLr2rC0uXSM3W7xCi5JmhQc3ShVX9yGMOJpBupbCLTLw0G3K3J4N251GgbnNBMbmFm9a9lqoRp8D8urYSNL5jvMMoNS7aztWgJ+2lqWtLrQSidVGaszPfBoxCUkCmurfFGrvp01BjGdaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By7m2rDx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b9375d703so3956286e87.3;
        Mon, 11 Aug 2025 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902304; x=1755507104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vr3xE3E1ywd/XOxjJYuL9VMaaS8/27KJS7LUx7CgcI0=;
        b=By7m2rDxfkXXDjy5jYuuZXnQwtiC6fBVnwk3hyehRpsakRq0198DVwJKn0v6hihZgs
         Etw8DgeVHLxyNWwW4IaReILcuYEVrsR3PtsTVscWpZEgr796j2MWg0HQtbXF5gf+USr5
         p0dJ56jTSNukwTDvM7mIznaRyiTO0xwBto7TZC9of7YjDO18AsXiCJVCzPR0XBRhAat3
         i7BWQVcqF3Tx3mpKTsw/lsGqLL/ulscYmclaTeyyiekWCN/hYPGoEcIOQWy+gIub5V30
         8dXi4P54fo3n9F5vY77dt2nuhdy/pctfQPWX9urbSALtTSk32Ko9aVQdY+HIRKAAzR4U
         P/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902304; x=1755507104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr3xE3E1ywd/XOxjJYuL9VMaaS8/27KJS7LUx7CgcI0=;
        b=t2RgNuH4m+nzW8Iq1cySSNpwqJLUwIBTl86ZP+ma1Hg7HN/nDEyYzxkkr4M3fGWsmf
         SrMOHCu6QTePMgVHrHvDuTal2jPgviC+plTtERfe56/wYklGJA3Ft7IS3Ff+UZwpOhY0
         5NS2IpgPxYnRcw0a6Cfp3gQ6p9ZCwrrfCFShj31I7VZTHmDYtxDrQiWtfVxBuemN+ZnZ
         vLQ7mI4XCOqk4HvwpwK7ZBjrP+4Kt5N53jkvfqYQ7QFDOeqI3yAyNvB2S0N87rkBmgwl
         0QYyuTaYHU4ZEfzojQW6IN/27vCVWKzhREcRVemOLtQHJOeuxKiOkQYK12ynVAOBQgIn
         qHtA==
X-Forwarded-Encrypted: i=1; AJvYcCU7F7/O0EPvCp9qfoAD7c84PXcylemGSRyv7iBnP9RWONa1kCqEvIxmnkjkSJ4P/t7RqxgKjjxjIzrV@vger.kernel.org, AJvYcCUQgDY8OGEguCvEw7NhO/km5y7OoGooYybtVxSJ7Z11cV8gr52nQU094oLOJtn4DLhUEbGKf0MnX+n9@vger.kernel.org, AJvYcCUpYGEZ3qe7MLTyAKzi7NKVzh9OUaMouDBRFf0hbLRjcVg5ZBBlGOAamCZ5pOcesptxNsnz4WDRy+Ysbipq@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsa9bPO+mD8uX5wOLZ9MTQ2lQhPsEbw7BsmQ0b8pACDSGhYBk
	W03Cr3mYb90aYykCnf+zYNbOD0Sgb3DfSKxeLQNLAxSY7hH/qUimnRgf
X-Gm-Gg: ASbGncsq/rRTIKbYRzL4n/8snWxJ1cRdgk9XJf0mqDnXqkqpROVCx3K/e6MdY+czQab
	vEk4eUEnEQ4BOphaBHrG3LWLtz6ri18tYZsNEgT/Vc+1vP+WtLEV2ww+A7kyCQ9tNCW0GRIwKKQ
	dDFHkgE6R81vQDxG5MtlWKZVgQn2zkJtREW7hbNpSUZ6Z4RseZwW9pbw99EWLFLVrDtS2K5CkDI
	oagKgXhF/AqOncm2DNGYaPBzdLMY5q/wgpxTqOYuoIrgcqHvPaSQWp3NYvt65XjOiIt/dG8hNoN
	vf+e/ueW8OjHIJVmAGL8Qu5DNqPODUt9fuihKshuCp87cgAHAkScRQlYT8yTO6Ih/ldBEomajf1
	OzjOnqJiVGalnQdJCZY9Y0HcUwDzeTC9ViQXCjbo=
X-Google-Smtp-Source: AGHT+IGgBdiV+baojFAyaObCoheXQKCKeuqGTNM+PXMyb0753GRatdjOVxHL44bz8CY9cIFkwuow8w==
X-Received: by 2002:a05:6512:2348:b0:55b:91b6:446b with SMTP id 2adb3069b0e04-55cc009e883mr2959808e87.2.1754902303561;
        Mon, 11 Aug 2025 01:51:43 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ad021sm4233661e87.74.2025.08.11.01.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:51:42 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:51:39 +0300
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
Subject: [PATCH v4 07/11] iio: adc: ad7476: Conditionally call convstart
Message-ID: <9760cde888fac7335c17d7ab63d5fb2e7c59ac51.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sZzpSYC3Ny0Q1aET"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--sZzpSYC3Ny0Q1aET
Content-Type: text/plain; charset=iso-8859-1
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
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---
Revision history:
 v3 =3D> :
 - No changes

 v2 =3D> v3:
 - Use indirect call to convstart (via function pointer) also from the
   ad7476_scan_direct().
 - Adapt to the change which returned the chip_info pointer back to the
   driver's state structure.

 v1 =3D> v2:
 - Adapt to the change which removed the chip_info pointer from the
  driver's state structure.

The follow-up patch adding support for the ROHM BD79105 will bring
different 'convstart' functions in use. The IC specific pointer will
also prepare the way for this.
---
 drivers/iio/adc/ad7476.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index ad9e629f0cbd..6cb2cbeafbd3 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -31,6 +31,7 @@ struct ad7476_chip_info {
 	unsigned int			int_vref_mv;
 	struct iio_chan_spec		channel[2];
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
@@ -94,7 +96,8 @@ static int ad7476_scan_direct(struct ad7476_state *st)
 {
 	int ret;
=20
-	ad7091_convst(st);
+	if (st->chip_info->conversion_pre_op)
+		st->chip_info->conversion_pre_op(st);
=20
 	ret =3D spi_sync(st->spi, &st->msg);
 	if (ret)
@@ -160,12 +163,14 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
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
--=20
2.50.1


--sZzpSYC3Ny0Q1aET
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZrxsACgkQeFA3/03a
ocUvSQf+IvW6HdeYk/he3GicwRposZgQSmMXpvu6Brmdy3Qm/VejXDK16dyC6knO
ttxjiGZ82/HrcoqPFcCLguxS1Pkn+TpYB7kwWVsT5ffpbUNoeRB6jlIorChLRa1U
b4dcz+FsIYi4vkBX+r3r3zS61exjYE69zopnw2JOunfwIuuh5KgmZVdBDiJh5xga
w+STlIl13X2rBkKhVrf+lNQ/Nsr+ifR0Vzipk1zN+UXa5XRYMQsyYoX17/pc4fJL
EzD+9DI8m2aN2gx/YIk9zsZaNM2ual5QwtTw08cRVAe8gpzkk4Axh/wieKS+pei/
/1fNry1f38o1KzN/iCDJugJdgk4wGg==
=yApc
-----END PGP SIGNATURE-----

--sZzpSYC3Ny0Q1aET--

