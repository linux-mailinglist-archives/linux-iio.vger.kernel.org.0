Return-Path: <linux-iio+bounces-12447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFBF9D48B0
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487A6B2357F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E01CB313;
	Thu, 21 Nov 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYScxxev"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489612FB1B;
	Thu, 21 Nov 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177250; cv=none; b=haGw4uNrrJOF5mhhIrVOys6ZT2FGqvQGVdZKeIDVSsH7aTcAHD90BAAAUAafmo7vl0aPNpXK13/5f/Uf3Kdn4Ae8o8LEiH++U6i10DkebmZ4r+Wz6+VkSVLLHqzOqnMbTcgpcwvpQRTwFukDfxUBqoZaG4ERxm9jtbXPmDmRkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177250; c=relaxed/simple;
	bh=D6Gk23yPn+Pf+BfSoF++QzMUir3tcaJIxUjG5pKdssU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEpgNyANV2WmVgedBNVWzHYG6X3nifZZHdnNITQzs+YLdPUCbb/Yv5eFj+6TZlUAK6tKiB5hWgHstriTAYnnC8/Wcnp1ieWAW5YV9qMUeyLGjA1Z2kABrXJJof/tSGVsipbEo5Qhh9qg230Jwi7QrvX/Px41+F5d4/h/4tiEZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYScxxev; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so10761451fa.0;
        Thu, 21 Nov 2024 00:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732177247; x=1732782047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nadS3kyGO1tCxcQ0OWmMFA5pJwFg8BTRjcC/TXXsp3c=;
        b=LYScxxev6zZCEvTSa0kym9t1/+4YsycRe2j2A1+UFAijNo1KlL9lNG9OKU5uudn74A
         9NqqyjXnGtdOSQA4oLzUC08dal4N+vKnclAnG1STJpJEsaXwwLcoNJWs8bn/yx1edtkp
         zekeOmJp/6Q+BL8FOPhofNsXSBZfgRKMOn4jxI7xZS0lYT8YbQMOSq6+hOYM74w1ekrl
         /+cXNHvPKIh3pVveM8AeuFEd1beo0dlyBDKb/fuiIeYqWltSj3UN31zwUV6JToQQfbFP
         H2HR0HkTe0iIq0F4f2srIGmkFI5TnAH30fFfnM8J6d3FBq+SmFLPN5fQ3y3e+NGl8h0E
         wRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177247; x=1732782047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nadS3kyGO1tCxcQ0OWmMFA5pJwFg8BTRjcC/TXXsp3c=;
        b=K/XuRUy3Z40+dS75VNJlncRda2cDomU6STRVyHBWKVo1xyOCqT7rX0ZnG5xQ4KXe8h
         ftl6cSDwFSGTe11OmbxwHUrvfr1UZVyEhViIrRhq3VSkEcIl8Qy2+8KOd7CcjK8GRoNA
         aLh+lOHD4w5ZrLVQbKWG/g4KjwXCHX5QFhMhE8B0k55ND+JlTSaydqs2eejeuAvuTN+O
         7QbOOO7FrrIxuPxaLS09HOH816yhgq6KE8OqfiElcqOgCuQCTYw+TTZLFStqIwgsP9sR
         vObHjoUSPJE+48Hv60s6w02k0i5uUWKBnEbereIA7J14vQ8fttW0qyaOIwWfAy8XWn6M
         +VkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhN3ZdzbY0cYEmsLRUqPIJwLWL4tfnPcHVmLmWm9VSYsJ3gyZzABll4Rbsv+2baSn0AXWS9SpC+X6s@vger.kernel.org, AJvYcCWoOQaIS/aWQ+Z4HOOQEuOoxfgMSPP9dKg4CeUdCKCqCmZyk2eB+j0zhTzxaZ/tud8yoyS8mWLWJXamurXF@vger.kernel.org, AJvYcCXkJnOHKIBPzyinurrjr8GtZ3eoqhTZ60KwkIKXPelKx6yGk9tgxGu02CiKpj7W0mw60exIPfe9+7cW@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3ByVfC6XJ1ZrChk3jGqPTxKNHive/TRZgEWjjULDSBs0a2zk
	Ob3R8YgMvUFx94Jga3UAPb970t1carQFpbcBaWlbpJR2qUdw5UdT
X-Google-Smtp-Source: AGHT+IFO/wkCZwRDPfXP6zNmTgQQ3Wc6KHl9afYQRDg3+vzoiBKCDmG5siAY7tZqTRqIsQvTrzvSqQ==
X-Received: by 2002:a2e:a596:0:b0:2f7:5a41:b0b with SMTP id 38308e7fff4ca-2ff8dc762admr62599591fa.26.1732177246897;
        Thu, 21 Nov 2024 00:20:46 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69959957sm18020121fa.43.2024.11.21.00.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:20:44 -0800 (PST)
Date: Thu, 21 Nov 2024 10:20:39 +0200
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
Subject: [PATCH v2 4/8] iio: accel: kx022a: Support ICs with different
 G-ranges
Message-ID: <5eda60de7d8fce910bc638918cbd3a204a7989e6.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2KlgkoOUh2SNTBo"
Content-Disposition: inline
In-Reply-To: <cover.1732105157.git.mazziesaccount@gmail.com>


--w2KlgkoOUh2SNTBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The register interface of the ROHM KX134ACR-LBZ accelerometer is almost
identical to the KX132ACR-LBZ. Main difference between these
accelerometers is that the KX134ACR-LBZ supports G-ranges +/- 8, 16,
32 and 64G. All the other sensors supported by the kx022a driver can
measure +/- 2, 4, 8 and 16G.

Prepare supporting the KX134ACR-LBZ with different G-ranges by storing
a pointer to the scale tables in IC specific structure.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

Revision history:
  v1 =3D> v2:
  - patch number changed because a change was added to the series.
  - rebased on iio/testing to avoid conflicts with queued fixes
---
 drivers/iio/accel/kionix-kx022a.c | 32 ++++++++++++++++++++-----------
 drivers/iio/accel/kionix-kx022a.h |  2 ++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 98953178a580..b23a27623a46 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -413,6 +413,8 @@ static int kx022a_read_avail(struct iio_dev *indio_dev,
 			     const int **vals, int *type, int *length,
 			     long mask)
 {
+	struct kx022a_data *data =3D iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*vals =3D (const int *)kx022a_accel_samp_freq_table;
@@ -421,9 +423,8 @@ static int kx022a_read_avail(struct iio_dev *indio_dev,
 		*type =3D IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SCALE:
-		*vals =3D (const int *)kx022a_scale_table;
-		*length =3D ARRAY_SIZE(kx022a_scale_table) *
-			  ARRAY_SIZE(kx022a_scale_table[0]);
+		*vals =3D (const int *)data->chip_info->scale_table;
+		*length =3D data->chip_info->scale_table_size;
 		*type =3D IIO_VAL_INT_PLUS_NANO;
 		return IIO_AVAIL_LIST;
 	default:
@@ -439,14 +440,14 @@ static void kx022a_reg2freq(unsigned int val,  int *v=
al1, int *val2)
 	*val2 =3D kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR][1];
 }
=20
-static void kx022a_reg2scale(unsigned int val, unsigned int *val1,
-			     unsigned int *val2)
+static void kx022a_reg2scale(struct kx022a_data *data, unsigned int val,
+			     unsigned int *val1, unsigned int *val2)
 {
 	val &=3D KX022A_MASK_GSEL;
 	val >>=3D KX022A_GSEL_SHIFT;
=20
-	*val1 =3D kx022a_scale_table[val][0];
-	*val2 =3D kx022a_scale_table[val][1];
+	*val1 =3D data->chip_info->scale_table[val][0];
+	*val2 =3D data->chip_info->scale_table[val][1];
 }
=20
 static int __kx022a_turn_on_off(struct kx022a_data *data, bool on)
@@ -544,11 +545,11 @@ static int kx022a_write_raw(struct iio_dev *idev,
 		kx022a_turn_on_unlock(data);
 		break;
 	case IIO_CHAN_INFO_SCALE:
-		n =3D ARRAY_SIZE(kx022a_scale_table);
+		n =3D data->chip_info->scale_table_size / 2;
=20
 		while (n-- > 0)
-			if (val =3D=3D kx022a_scale_table[n][0] &&
-			    val2 =3D=3D kx022a_scale_table[n][1])
+			if (val =3D=3D data->chip_info->scale_table[n][0] &&
+			    val2 =3D=3D data->chip_info->scale_table[n][1])
 				break;
 		if (n < 0) {
 			ret =3D -EINVAL;
@@ -643,7 +644,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		if (ret < 0)
 			return ret;
=20
-		kx022a_reg2scale(regval, val, val2);
+		kx022a_reg2scale(data, regval, val, val2);
=20
 		return IIO_VAL_INT_PLUS_NANO;
 	}
@@ -1148,6 +1149,9 @@ const struct kx022a_chip_info kx022a_chip_info =3D {
 	.regmap_config			=3D &kx022a_regmap_config,
 	.channels			=3D kx022a_channels,
 	.num_channels			=3D ARRAY_SIZE(kx022a_channels),
+	.scale_table			=3D kx022a_scale_table,
+	.scale_table_size		=3D ARRAY_SIZE(kx022a_scale_table) *
+					  ARRAY_SIZE(kx022a_scale_table[0]),
 	.fifo_length			=3D KX022A_FIFO_LENGTH,
 	.who				=3D KX022A_REG_WHO,
 	.id				=3D KX022A_ID,
@@ -1173,6 +1177,9 @@ const struct kx022a_chip_info kx132_chip_info =3D {
 	.regmap_config		  =3D &kx132_regmap_config,
 	.channels		  =3D kx132_channels,
 	.num_channels		  =3D ARRAY_SIZE(kx132_channels),
+	.scale_table			=3D kx022a_scale_table,
+	.scale_table_size		=3D ARRAY_SIZE(kx022a_scale_table) *
+					  ARRAY_SIZE(kx022a_scale_table[0]),
 	.fifo_length		  =3D KX132_FIFO_LENGTH,
 	.who			  =3D KX132_REG_WHO,
 	.id			  =3D KX132_ID,
@@ -1206,6 +1213,9 @@ const struct kx022a_chip_info kx132acr_chip_info =3D {
 	.regmap_config			=3D &kx022a_regmap_config,
 	.channels			=3D kx022a_channels,
 	.num_channels			=3D ARRAY_SIZE(kx022a_channels),
+	.scale_table			=3D kx022a_scale_table,
+	.scale_table_size		=3D ARRAY_SIZE(kx022a_scale_table) *
+					  ARRAY_SIZE(kx022a_scale_table[0]),
 	.fifo_length			=3D KX022A_FIFO_LENGTH,
 	.who				=3D KX022A_REG_WHO,
 	.id				=3D KX132ACR_LBZ_ID,
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-k=
x022a.h
index 7060438ad88c..36e9d9de8c13 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -161,6 +161,8 @@ struct kx022a_data;
 struct kx022a_chip_info {
 	const char *name;
 	const struct regmap_config *regmap_config;
+	const int (*scale_table)[2];
+	const int scale_table_size;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 	unsigned int fifo_length;
--=20
2.47.0


--w2KlgkoOUh2SNTBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc+7VcACgkQeFA3/03a
ocXfrAf+IB9OKt3PIdSO0pqk2f3GOOadgqn81N9VE6tp39QvYQNlqS0Eub9GTEhH
4iuMUYYLyfk4mWCSZZouIWLxPI7NI5Uyi5KmuhN2M1JjP2vheTh5Huu7w21OjFM1
Ur0Jz66afMu8UiGBUhN0BvORa2iTPhiiIBEQmWPjQz0SAPm5Tz5chG9A31Fsr1bD
sySBFPUqbEitAbKJw+VSFAUv19Dg2cF8YVKa5VKqCnUwSgtZpVEU9f8UrOcm+ryJ
NrGOgs4yNTZ7sbAworqRmNKDTGQyQgUCx7UU6DwpMDBPtsYMH1aS19PWKQ82gCwP
417009RkzadMk4cxCyiF8rXgYYNZqg==
=Ft9k
-----END PGP SIGNATURE-----

--w2KlgkoOUh2SNTBo--

