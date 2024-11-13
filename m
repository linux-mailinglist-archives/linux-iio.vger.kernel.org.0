Return-Path: <linux-iio+bounces-12198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1009C6E02
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3D4B2E815
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500B201002;
	Wed, 13 Nov 2024 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX15IScd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C31FF5E5;
	Wed, 13 Nov 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496837; cv=none; b=g7SNV5BAzWwzrSdlMaRShw+MO6ovDe6gwyiEgSW9A3OIoV9py/nts+kROJVrS0B3Wr/snTUWAkqGToIwza2Leim74qELiR3+1ebQdlmfMjvPRwhi9kx5RCTmo5t/Ud4B5YWwiRFDnjUurlTYmfVFeQteOI/z9z+5/xMBpC2+LEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496837; c=relaxed/simple;
	bh=U1n36CoErKiW0PdZw+ayzm0kwFFBLzKR5JG6iNgBoHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHBm0Cah2nrCNmoYEwTfgS8YzCcHD6ezTKo9zlMofpwxGg5zYuXpveJpwwoKvvHwFzo+RZEuf7JtZyuZFHpbLWlgFYBxYU3jgkuI9tvfCI/yKg+pB3XQrIDfvPqPBXbYmgL9XbRLQVbHQbwotK7RdJ90h6q9v0RTLlNGQTASCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX15IScd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f84907caso7629708e87.3;
        Wed, 13 Nov 2024 03:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731496833; x=1732101633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JSAf5erNRaQJKP71Ai70DIwS8n0/VvSIv+3u/yhIIdo=;
        b=DX15IScd1D9ChYZ2R5TyYdc9EO6bAeFmKfEXUrFJHFS1WQKW1+E3lpFXFKsYTV5e3j
         pcJbGO/kFulKHSQo6WKCDYBNXoMc0Kwt9hCwwyYm8kkJHJi5CAyToE6fP//gBPf1Z0Me
         KpudQgNmGX6LCokAfND9CbMUM3S6VSMAsZ3AD5h3+As9sUH3Xd2uORra2YAiD8bCwsfy
         jGEZsA6eMSuxaqmuwcRv0sSje+x25XWhiVmrThUyUFIf6ettb25JNvpvn71IqsU7EBdX
         i46DTnH/rHWnen9E6sTnscx1pgMkmif15JZivcv2LXtokLWttLCl1hZWnks5d1XmWo6z
         P6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496833; x=1732101633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSAf5erNRaQJKP71Ai70DIwS8n0/VvSIv+3u/yhIIdo=;
        b=MKAZCzr54xq4ea4Z/GLd7B5YqW2+fY832VY90qUo7v1xctXAj6xECoMEJVlVwpGBuY
         8gjF878gb6Tb4lap+8DR0h0UP6q6v7dmnkHPWlBY2RItAJs/fSrsKJjB/AZxkxnJlNTv
         8EOVI25RDlQ9/VZq8e3WLnNuTFcuKXNQHnVlV6iOACsVLUpb0bWWc9fZouAp3cBbe94E
         5usoS/00JVIZeBGDa300hBc6vJhx+6dyfsxHCXIwFQ0sJ8cMH+/LbuGCGgc6SRljROcZ
         grBbmoWCtp0TsuAgBzbkqhT0sLR3/7mdemRTXUDuGa0a3iSIXupFWIg+B4rMRFsS+C85
         sfLA==
X-Forwarded-Encrypted: i=1; AJvYcCUcZIAx7raT0yJz++a6pEdYWE6VFg0jC5PtrHKh4xSlp4mIcQdlJwGV1rwPoqsn4JWgihosmsdgfJC5@vger.kernel.org, AJvYcCVVBIZL3qnM6DkNknoU1EQEbgy2OfrfD6cLL/S6+MEcMPZOQm7XM0ZgPqGTz3pzLyxc/oEZaxsQE0tZ@vger.kernel.org, AJvYcCWphGDVBzjOeZwqaLfoRgeakA2DDEiDwGxDD9eMRD8vNynlK+QvKC24EJWTS+V631JEZDL7RrgNhzWV7DSk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8eWrIKYRILnD9Do2llIrqQEXL7oKLoI6ACwv3+QtrnOl7GLxd
	Ssuze7AQNogAB0MLu9+gr/XToY/WKqJ4cqlECgiCN5QNtekW1XnD
X-Google-Smtp-Source: AGHT+IH7JkALubcn0oc/gipIDR5MpOA2xnur135kdnz3s/idRAQt+/kwYNUY0/qT67KWvTTTV4Xkfw==
X-Received: by 2002:a05:6512:b17:b0:52f:c13f:23d2 with SMTP id 2adb3069b0e04-53d862cae67mr9690920e87.25.1731496833088;
        Wed, 13 Nov 2024 03:20:33 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826888dfsm2137157e87.106.2024.11.13.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:20:31 -0800 (PST)
Date: Wed, 13 Nov 2024 13:20:26 +0200
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
Subject: [PATCH 3/5] iio: accel: kx022a: Support ICs with different G-ranges
Message-ID: <75b415b60f6c29bb01766db8b5628cc67bacc940.1731495937.git.mazziesaccount@gmail.com>
References: <cover.1731495937.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9+bX2y3kbdFbdJQH"
Content-Disposition: inline
In-Reply-To: <cover.1731495937.git.mazziesaccount@gmail.com>


--9+bX2y3kbdFbdJQH
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
 drivers/iio/accel/kionix-kx022a.c | 32 ++++++++++++++++++++-----------
 drivers/iio/accel/kionix-kx022a.h |  2 ++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 321bb2c35578..e2e41dea9d9f 100644
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
@@ -1143,6 +1144,9 @@ const struct kx022a_chip_info kx022a_chip_info =3D {
 	.regmap_config			=3D &kx022a_regmap_config,
 	.channels			=3D kx022a_channels,
 	.num_channels			=3D ARRAY_SIZE(kx022a_channels),
+	.scale_table			=3D kx022a_scale_table,
+	.scale_table_size		=3D ARRAY_SIZE(kx022a_scale_table) *
+					  ARRAY_SIZE(kx022a_scale_table[0]),
 	.fifo_length			=3D KX022A_FIFO_LENGTH,
 	.who				=3D KX022A_REG_WHO,
 	.id				=3D KX022A_ID,
@@ -1168,6 +1172,9 @@ const struct kx022a_chip_info kx132_chip_info =3D {
 	.regmap_config		  =3D &kx132_regmap_config,
 	.channels		  =3D kx132_channels,
 	.num_channels		  =3D ARRAY_SIZE(kx132_channels),
+	.scale_table			=3D kx022a_scale_table,
+	.scale_table_size		=3D ARRAY_SIZE(kx022a_scale_table) *
+					  ARRAY_SIZE(kx022a_scale_table[0]),
 	.fifo_length		  =3D KX132_FIFO_LENGTH,
 	.who			  =3D KX132_REG_WHO,
 	.id			  =3D KX132_ID,
@@ -1201,6 +1208,9 @@ const struct kx022a_chip_info kx132acr_chip_info =3D {
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


--9+bX2y3kbdFbdJQH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc0i3kACgkQeFA3/03a
ocVRIAf+OmlAOvznaLnZWbOQ1qDLRRgd6qibeB5bJKlEXUf7npGpmAKhEi9AabGq
5hE+r2zTaAmJ/5oSGksW1+54GIeOxtjAoefk9xRytWVu9/zITfQxl1CpGlOieHzX
2FxZtYdlr1hWkkdvpHJBjBFWzUPjW3EdUcewYlkG9sZJShuXmuPOeqr4b6yEEm9c
Rg6yNZ2eU9Q4nxNP/wwb8afLku8f03OmcCfxHPPjCx48GMzxNoxsXdOgV1TN1QvG
4J9gnGNaHqCfZTXKUxyJwW1WhOy9m90QG5ype63sMoLbItiVYUD75PVN7uEWqn9b
d2nk3wIsOop3f/Cpvn7wB7lUqUlxkA==
=+9hg
-----END PGP SIGNATURE-----

--9+bX2y3kbdFbdJQH--

