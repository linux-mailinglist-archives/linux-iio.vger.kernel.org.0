Return-Path: <linux-iio+bounces-17539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12546A78841
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA6516ECBA
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D092327A1;
	Wed,  2 Apr 2025 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqFGXQ5d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7895232792;
	Wed,  2 Apr 2025 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576382; cv=none; b=ZnF8d9O8OKJ/kRahY0YzH/WOKLBhYUrVtIZ8v3RoJ0f1P2+BPYJc3H2WGWF6u1QZ5G9YA+3uBRKufKiQCc/mUgAEPxbBs3lj50R4r7uLPaU6SsYwUPOM59OdMhvO3GQVUaAm18+UIy5U9kQi/xD6K114MMka6KiHm1Ibm37feD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576382; c=relaxed/simple;
	bh=5Tu6qFtZWZlXL2BchJOllZFpT7StVUWq2Xga5P56KVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qifg3LwRNfJBpNFIqNVI6+TS1Fgrh5Rhr+z3DHF4f8fdNKaApbeTIB10Lt7QAqP2SLVkaK/2BkMlKHV8ZR3bZq8GnIung0GVSaR7H4o+2IrNt14NnFu5P5mpXsY4J/e7aWvGOjed9oNQRPxyJpSf8O8+6iP5cNj4Cicees9iyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqFGXQ5d; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30db2c2c609so68066031fa.3;
        Tue, 01 Apr 2025 23:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743576379; x=1744181179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jA/5cJRyzUpXOaAYgVofpvVcnYlQLgyR64YPAjaXn4c=;
        b=MqFGXQ5dYjNQS3k7n15Xv4DJnpIRXLbC2hUW/a7JL0zTwbbXrHx83piaO7ftHy8gmF
         +J0Cva8jGIcTAMSFZrgtUklWr0qACK+pgZqB/vXOGtPkXz+T8Ld6zQLvdT8Uhy2l4f25
         0sNDgEjAOf6+fjkeQutpyWjmuzmJo3d/PERF8lGuKghTPImpWEAfzfd3phRsYxc4W6Rg
         FTiJtZyMhnMLeM4p2DD2SX/FvsGRTvuLlkh9QaKY4ZiX6Ni1o5wDiSnLKv7bXltZ06m1
         9ToQGEfBG2jREWsblykf+FGnPf7SL2ljw7SAgn5lWAXCWhcXSwB99EuPS8BHiyX8LlFQ
         X5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743576379; x=1744181179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jA/5cJRyzUpXOaAYgVofpvVcnYlQLgyR64YPAjaXn4c=;
        b=ZdB6TRSYh5OdTTSTXzq+GGGuTEfvsPQ9tKLOrlopVfwoiZsAEsQlkqk6Qdg3/q23vA
         RS59lUmb13yirz1PpZvVUyZJT+p9McGyZ3tSgDugFEudCySbSowx0XvovfzPyz66mwfn
         Yl/VTbM1Go9VIuXmiOXTct7BYwVs5w2used7MJOKhFpjQoQyw8QZRxh9dnjJl2OdyLac
         PRmwJHxHVWjRLjkMzbts8cJJsji83PDiSUbBuWaXKGLkhbNZ5x+GrpTY6DcyUlcQf9dq
         BfLzUxzfLKDchCVvWtA3R7/EwVXyiBtiqfDEF+sN13NS3LJvCe48LdypnJZIfT2nC0Bu
         BejA==
X-Forwarded-Encrypted: i=1; AJvYcCVzYjw9+6d2ac1ChVFeUpcCTCtt3Bch5HBjFY4IxYFpqnJGrtFS/bGHGEszFJHsEFTA/gYGi4hZYS7T@vger.kernel.org, AJvYcCWd73xY1kIMaFybSjGa2w7sg5DKCl2EFD7p1ZmaoYGuLRFsx32Yw+sQWLkj9C2l8Lr94e3KAwB1DEKOfXyn@vger.kernel.org, AJvYcCXvxNhzWWOKNbA3woXF2AupU3i4mitKEPq05Sq2Zi0jOr+lBjVUmj8Kq8ZqPtt9limNkAPqGDc08CrS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/y+daji6FIJgvfwaC0U9jsrubMBcnWvhAROtqe9gLh5SjnUFl
	rdXG9u6oBvdHFIpDiUX6MEfvNuvPF0dXbLCq7VZO4At/012VQIEO
X-Gm-Gg: ASbGnctVFyLp3i3nlEsgHRybu2o8Mdb/GXensG7wCd67ahXpp55Q6DwBWRXe7Rju/j0
	op5RroA+pEGIuZR8gXPMQLhzMA+azBaHZzdOzHJd4nci28yhJGa6CpSoQ8I5lrblkoNiUemLXA0
	ZnsFHGYeNlWLRAtZaeugOP3DgZGz/6c/HxFb0XZ8oliQ6gtAugRnATfSWLToXFGK8OT8j79SAZz
	tlOxRr8ltBIDuolotsu5FVkSD51xr7LfL8bSwAtDlPRnJpypoYYoMfmjC/46mPrP0tw8d/56gId
	9YoagqXsukkbuJ32tQadWKUu3poW5pY6649N6RcXSIUMYUX15DE=
X-Google-Smtp-Source: AGHT+IH3us/H9vhFC2mYeXA90ODjOuqI0X+m8v+9sdO78B95L0RxeTQM6Rmi6GpJRPSkZbkgwoD7nA==
X-Received: by 2002:a05:651c:1615:b0:30b:c8b1:dd95 with SMTP id 38308e7fff4ca-30eecd3bdfamr20586391fa.22.1743576378478;
        Tue, 01 Apr 2025 23:46:18 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b8f6bbsm19654271fa.111.2025.04.01.23.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:46:17 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:46:13 +0300
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
Subject: [PATCH 3/5] dac: bd79703: Add chip data
Message-ID: <2cacb4bec5455fe1aa58a0b28d2d91b96a396d1a.1743576022.git.mazziesaccount@gmail.com>
References: <cover.1743576022.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J7gs07qkpaTHTaG4"
Content-Disposition: inline
In-Reply-To: <cover.1743576022.git.mazziesaccount@gmail.com>


--J7gs07qkpaTHTaG4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add a chip data structure which allows handling the different variants
(ROHM BD79700, BD79701) with different number of channels.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/dac/rohm-bd79703.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
index 236aa98bf005..35e1b1134ec6 100644
--- a/drivers/iio/dac/rohm-bd79703.c
+++ b/drivers/iio/dac/rohm-bd79703.c
@@ -38,11 +38,19 @@ static const struct regmap_config bd79703_regmap_config=
 =3D {
 	.cache_type =3D REGCACHE_RBTREE,
 };
=20
+/* Dynamic driver private data */
 struct bd79703_data {
 	struct regmap *regmap;
 	int vfs;
 };
=20
+/* Static, IC type specific data for different variants */
+struct bd7970x_chip_data {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+};
+
 static int bd79703_read_raw(struct iio_dev *idev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -94,13 +102,24 @@ static const struct iio_chan_spec bd79703_channels[] =
=3D {
 	BD79703_CHAN(5),
 };
=20
+static const struct bd7970x_chip_data bd79703_chip_data =3D {
+	.name =3D "bd79703",
+	.channels =3D bd79703_channels,
+	.num_channels =3D ARRAY_SIZE(bd79703_channels),
+};
+
 static int bd79703_probe(struct spi_device *spi)
 {
+	const struct bd7970x_chip_data *cd;
 	struct device *dev =3D &spi->dev;
 	struct bd79703_data *data;
 	struct iio_dev *idev;
 	int ret;
=20
+	cd =3D spi_get_device_match_data(spi);
+	if (!cd)
+		return -ENODEV;
+
 	idev =3D devm_iio_device_alloc(dev, sizeof(*data));
 	if (!idev)
 		return -ENOMEM;
@@ -121,11 +140,11 @@ static int bd79703_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret, "Failed to get Vfs\n");
=20
 	data->vfs =3D ret;
-	idev->channels =3D bd79703_channels;
-	idev->num_channels =3D ARRAY_SIZE(bd79703_channels);
+	idev->channels =3D cd->channels;
+	idev->num_channels =3D cd->num_channels;
 	idev->modes =3D INDIO_DIRECT_MODE;
 	idev->info =3D &bd79703_info;
-	idev->name =3D "bd79703";
+	idev->name =3D cd->name;
=20
 	/* Initialize all to output zero */
 	ret =3D regmap_write(data->regmap, BD79703_REG_OUT_ALL, 0);
@@ -136,13 +155,13 @@ static int bd79703_probe(struct spi_device *spi)
 }
=20
 static const struct spi_device_id bd79703_id[] =3D {
-	{ "bd79703", },
+	{ "bd79703", (kernel_ulong_t)&bd79703_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bd79703_id);
=20
 static const struct of_device_id bd79703_of_match[] =3D {
-	{ .compatible =3D "rohm,bd79703", },
+	{ .compatible =3D "rohm,bd79703", .data =3D &bd79703_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd79703_of_match);
--=20
2.49.0


--J7gs07qkpaTHTaG4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs3TUACgkQeFA3/03a
ocWSBQf/RQb6n8BZ1oEoqAjljTMZSL+C9oLHGmHFx99zMA8HqwM0MrMzKK1Inu4g
3TU7XR0cBGdRP9J4eVNfxqodZpNFaVyON7xFFMhVqigqtB23Lp6UFwA8uJ4TiRSc
h0fYy42dcL8qBbZOjh5ISj2Mmzv39ESDQWSBZhMQLa5BbpRmqmoGkH1oJZvmkNlb
MDtP651ZM8quaae4PDC0OtP7FaaPtg8g5jnJuIMeF0+j1ilD4PAqViRAT21MsBOU
I3HP7YspeGjCs0w7HRVee6gTD5rR1KohwTj4SwjvApWL2Sl+p8XyoXA1T42Kweia
QaColxIxblsH05qVv42JqjrpEkgM/w==
=y/u7
-----END PGP SIGNATURE-----

--J7gs07qkpaTHTaG4--

