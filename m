Return-Path: <linux-iio+bounces-12767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71AF9DB475
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 10:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC81162F71
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727FA1534FB;
	Thu, 28 Nov 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWwcxoj8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9652F88;
	Thu, 28 Nov 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784546; cv=none; b=Fvf3YixDVCn8UuBgQaWIPHuMuY9BtMz0aLpW9bVRUozcaYH3jMBizeE9AlO87VZRShsXwVJn2GaQoidIJBDMXJd9Rt7ZhRliW4r0yILrldJ2cYAQt1m1Rri3Lid+87bHY9+LYLZfQwauQOiUHksOZb5BbvoQVNUCLLOWYlodYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784546; c=relaxed/simple;
	bh=r/eeg3om9ivU0+M1FKxsElEgfHpj09dDPhesON/f1Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMyFAOSI08Hy3U2rkA3iieQSN02MN+5McQi5RNscLTZyV9HHy89okax8NIqEy5h9EJ/tbD+MdznFLoEYlu1Ia4nN+KflXkXW/Jx6ksQkm5TMoJnYmvExtMtVCWjI85Q6AXycL7XgcKmp1q3NlXqIU9/xfEAXW/us8eujsmDGMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWwcxoj8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffdf564190so5540391fa.3;
        Thu, 28 Nov 2024 01:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784542; x=1733389342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JS8d/eTEBGERRIVkh1QG1hDjxDaJ+9ipo4AmlFs0eGo=;
        b=MWwcxoj896SBdHm019ej10eFf5Odg1ZO78tMvyNXnGIWfkCLiITCZLnUX91Nf2jRGF
         FA6R+QB0qvnm6c7AiqWZHJGCNbkvc5amVk1jOqPvd1BnXZFf8WisVaHNTecZKC6W/tql
         E30YoyZse4VgrW0r3ANr4KTCdEwSESSLhErI78h9TEgfweZx1Dh8oiwEfsmri0ElPwaL
         9Sr9LR9yIW88d4sijwNT/kqmJgze5sbGNjXIZtG8NlMh7j3l2rPlCW2BD6BQ+dXq5Epd
         1WeJ379fu+WmRv4m0BHIcSOKg//KQWUZE5wbAxQMqyOCHieIEC0BF6cydNqABKaLZHZC
         WNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784542; x=1733389342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JS8d/eTEBGERRIVkh1QG1hDjxDaJ+9ipo4AmlFs0eGo=;
        b=O+7nHfyHUwrL76u7nclqwQo7jre9mn4p560MEfqBsbDZqBbW0t/EAoK+jtZCUXJDEq
         kkYv2wLSsl4CIFUi3t2T7C7s1Njre2LEghxgA9ug+mia2594Dyovli798WUoK/nu3Uys
         uV2b6kLct0cpRdj6AMj7FjqIuLT5KC8dPZYU05bmHnR7FJvoEFi5bEqbAwbZQjq81NKa
         ugvYiopug6NGEYcBlel9aSEvytPhTIszUt8JGD1Fs6PWs7vP7bgwcErlWdNYCbBT9V+M
         u/ItkfV51bwUwmM8+7gxZXMv/EXdkgrERr49FA9XixGyd7mgycks8WiYFCE1iTmHC/wk
         Ex5A==
X-Forwarded-Encrypted: i=1; AJvYcCWYtawEWVjopVodx8TaW19Vf7trjrQz1gUUtbFJwazKpx5Mm1I9LHaLA17iQnx8T+HZNrDEWn4QDsbe@vger.kernel.org, AJvYcCWm/Bq6aKOyqdyjpdaMbUr4+RKtyulbghzAMg6sHE4PcM0rWZlGeyg/gCxA4r4Sym31GfhErPK1Dfmb@vger.kernel.org, AJvYcCXPlrgOr3AqW3Lr5ViMlF1Nm8EBIwhjS5uTk5v1lnZ4SUWLW1TS9cwu6+cWtkT9df0a/jW11COZS5Ch6bYU@vger.kernel.org
X-Gm-Message-State: AOJu0YxxGDZBZ7g2/0JR8JgyKY4ARS9jji+zjQfUN7otaEN6tYfx/46o
	kLxskCQTQpfItyh0BCkXUrBNoL5BLT9D+2lLiAdlwyj+B6wOk/dj
X-Gm-Gg: ASbGncvN2xmegqpDhsv4WNB8WxIVxsuVCyd2MbhdtFnFJxZUaNFhRAXlxm+iY8MiKRs
	o4HNLGcS/wsvb9Xs1xbd5Okgo2tku2iqGDZDeqM5D91oaeqdTZgiqNDexU4LDmWv38SjQbOkXfZ
	6HmVhrlPTR8lrheizTkFA7d+EbQURxHWGxm0LKkbZHWQjbC7QzlPxZ64+wSjVDvNcBOtGk4Cmbb
	8LaBqm9eNTZLHGJyKX/uXL3De2QUYDGv05XdvmQCRLkpBotXRfI
X-Google-Smtp-Source: AGHT+IERYLeFqFfPV04lEE2WfX3aJ7m9wgmeo3ZuOuY/JPUNDf6zq9SQcQxYSBf9juZwJNHJKTVdWw==
X-Received: by 2002:a05:651c:2119:b0:2fb:593c:2bf2 with SMTP id 38308e7fff4ca-2ffd5fcd5cemr32880701fa.3.1732784542031;
        Thu, 28 Nov 2024 01:02:22 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfca2907sm1333331fa.110.2024.11.28.01.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:02:20 -0800 (PST)
Date: Thu, 28 Nov 2024 11:02:15 +0200
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
Subject: [PATCH v3 2/7] iio: accel: kx022a: Support ICs with different
 G-ranges
Message-ID: <fc667b1495adf4e3f29ecbb336495c1f18b47e61.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vyd84sCsVdWpsYz6"
Content-Disposition: inline
In-Reply-To: <cover.1732783834.git.mazziesaccount@gmail.com>


--vyd84sCsVdWpsYz6
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
  v2 =3D> v3:
  - patch number changed because patches were dropped.
  v1 =3D> v2:
  - patch number changed because a change was added to the series.
  - rebased on iio/testing to avoid conflicts with queued fixes.
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


--vyd84sCsVdWpsYz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIMZcACgkQeFA3/03a
ocWeMQgAxMcL9EaBc9ikbrzJmUATmof4n7+okncagifwEfgsGG578BN/vpp8et0i
srkyuKw3o6mobS/SxdVV5cxSgXT7bNu6TzJZ7GBJZCNLdPKQZqY5heWPnUhF5qd0
S0pioq2ytEqKkiQClRa4uee3cabkna+QCyN2DrAvSaRBbTFWgxiL5XLykHcvQ8nw
h0oRV583JNBAFvQPdTr9eulkd3BJPQKzes8jHfsQYHxew1nAU5b9jRty5YvoVvKr
TJd0g/CZ7nDpv74BNAMIF/pSAK2wknjIXxzkl6d/m44sXoCxf+0znwY0PetFLHVu
7mu38/OwqQUVE1ENKCYWQgEihT70xQ==
=Raq+
-----END PGP SIGNATURE-----

--vyd84sCsVdWpsYz6--

