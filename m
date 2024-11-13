Return-Path: <linux-iio+bounces-12200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFED9C6DBC
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 12:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CC4282AF4
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E179B1FF611;
	Wed, 13 Nov 2024 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhfscpQY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BA18A6B8;
	Wed, 13 Nov 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496877; cv=none; b=axw7ztop414f680ZrE3x1sfJqOFy8rTsj8X6zwUvprjGpHASx/a69ZqXBl3tXmPQxXy8X9E4Di/1uA/J+4Oyosn6pwwUGIH8fX2VLwUr3pzq8/u6+r8p+5JPhjlUYaEq2+4HKMn5umB0Q4P0Cd4TXWVzUfKQcR9WOv4k3hiwvY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496877; c=relaxed/simple;
	bh=A9+H5DYChc9i1OraBfq2YKkXC8djpjb1+M0L+QHxpec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfS437WTR6amEeFwXR4SmI0Whgad/BLy6yhaWKvKFD2EiJuYDWeiDdhhUoB5nv3Argz09B6Uk2k3qLd2TbcHol7zXgAhBzUeJ36xKib82+9UBLYkx2ic+gQhLgtC1V6dA+fJ6/SoVJ7+YSwGSfKOXjg42CI7pF/sI40E4Ou1j8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhfscpQY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53da353eb35so176534e87.0;
        Wed, 13 Nov 2024 03:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731496873; x=1732101673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNcaPkh2M7fZ1XR/E+G2gkC3Hxx73FT6z4UhoVfTABo=;
        b=ZhfscpQYufhmmF6Tj/u5+H2B5f6YOytIfuPJHFPOG1LuIETs4RReUapv1QIbJaYlap
         w8dIVZC5IW8AzffokhU8fnAID7bDYHvJdUIA2mRqU9rOdHVvmcrMMaP9rsykrsx0pViz
         1YrUVnInDTfr2XrC8azLlFSYG+WE8PVbVoCXR7i08ZVuJCtmnxqyZzXljJ5BXoQF+aBP
         z0Kcdu2OjiqOtLyzO4frEImv7yY3b8GBUlB1HqZWJ7BHvN7jbvk4vq0uZxFhvf1A4UmJ
         GN83q9AseEoAl6+tsL/6pLahgR0VUznnTJeSVGcIQEV+TsIGbNOKy7zSf/+WAIcSPS+W
         NdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496873; x=1732101673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNcaPkh2M7fZ1XR/E+G2gkC3Hxx73FT6z4UhoVfTABo=;
        b=oTRp8iaSSkRNr1k1JHLEyOqvYFunPt9OZlc64MtV2p/q2U72fe/Gp5GPgPH2AN4Hbv
         L3YRJwD9IiHj08+i3tm3ClJ9hBHxbZJmtk68jpa6ptI1yp7jfES7fkyrtewSgZ8MAWMl
         rr9UxWSn5U/cLilr0PFzMDrETt14ri/dlXd+dmg9guDyTYlUI9p20sFpa8qUqKZzPQlU
         9PYE4J98HmgZkXQ+lOBkYDJfr1cQeF065hI1zHAIwDbytYUW7CUZCXPhhufphvjroSQg
         rSyUDgH0fLKnwZ1z5RuVCvHwxh+imDNc223BSB9pNCP2ZfoqAd42/xk+6oKNN/D9SOjJ
         hu+g==
X-Forwarded-Encrypted: i=1; AJvYcCUQn2/gh9at+YHCsfpuLer42Wc3L0vesQpe/m1sFLoTfIkEbRoSM/ZYGbmuP2ctoUCkHNoQu/KNrBkjYNhM@vger.kernel.org, AJvYcCVDXaQfn7hbBBvjFTXcCGj22h8NQUDuhu63wEQat9BRhfFL0vS1Tfv7V8xK4FUHGYCi4D0j+A7WbtYN@vger.kernel.org, AJvYcCWusFGFyDvMnqW0OPVICoyH1cNH8pJryoElm3iNV07rSg1BFDz0n2HxGMzdZy0JY4Mi2p0i9npwDPKl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5FTtK+DZv3UVjuxJ3HsBixAfZsHGWl7UwFLxmWu6S2Bgb8H1c
	P9a4M1titnRZsmke5CXp9n6B39oRHof2uKdoZYKwpmcNbFhUCGz3
X-Google-Smtp-Source: AGHT+IFYQ76KJydVCSCuMqiDn5p3lMtFd+RiBmDDgbWEaeGnLPLzEVqafbvV1b1AVaz1pQ8vogbotg==
X-Received: by 2002:a05:6512:3e1a:b0:539:e2cc:d380 with SMTP id 2adb3069b0e04-53d9fe89333mr1218893e87.27.1731496872570;
        Wed, 13 Nov 2024 03:21:12 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d88bc8213sm1646240e87.166.2024.11.13.03.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:21:10 -0800 (PST)
Date: Wed, 13 Nov 2024 13:21:05 +0200
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
Subject: [PATCH 5/5] iio: kx022a: Support ROHM KX134ACR-LBZ
Message-ID: <bd0c9fba0843401f8494459ff537911e07ee39dc.1731495937.git.mazziesaccount@gmail.com>
References: <cover.1731495937.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WcPdX6aUzbDgIr8Y"
Content-Disposition: inline
In-Reply-To: <cover.1731495937.git.mazziesaccount@gmail.com>


--WcPdX6aUzbDgIr8Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The register interface of the ROHM KX134ACR-LBZ accelerometer is
almost identical to the KX132ACR-LBZ. The main difference between these
accelerometers is that the KX134ACR-LBZ supports different G-ranges. The
driver can model this by informing different scale to users. Also, the
content of the "who_am_I" register is different.

Add an ID and scales for the KX134ACR-LBZ.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/accel/kionix-kx022a-i2c.c |  2 ++
 drivers/iio/accel/kionix-kx022a-spi.c |  2 ++
 drivers/iio/accel/kionix-kx022a.c     | 36 +++++++++++++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h     |  2 ++
 4 files changed, 42 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kion=
ix-kx022a-i2c.c
index 8a1d4fc28ddd..9fd049c2b62e 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -39,6 +39,7 @@ static const struct i2c_device_id kx022a_i2c_id[] =3D {
 	{ .name =3D "kx022a", .driver_data =3D (kernel_ulong_t)&kx022a_chip_info =
},
 	{ .name =3D "kx132-1211", .driver_data =3D (kernel_ulong_t)&kx132_chip_in=
fo },
 	{ .name =3D "kx132acr-lbz", .driver_data =3D (kernel_ulong_t)&kx132acr_ch=
ip_info },
+	{ .name =3D "kx134acr-lbz", .driver_data =3D (kernel_ulong_t)&kx134acr_ch=
ip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
@@ -47,6 +48,7 @@ static const struct of_device_id kx022a_of_match[] =3D {
 	{ .compatible =3D "kionix,kx022a", .data =3D &kx022a_chip_info },
 	{ .compatible =3D "kionix,kx132-1211", .data =3D &kx132_chip_info },
 	{ .compatible =3D "rohm,kx132acr-lbz", .data =3D &kx132acr_chip_info },
+	{ .compatible =3D "rohm,kx134acr-lbz", .data =3D &kx134acr_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kion=
ix-kx022a-spi.c
index f798b964d0b5..b20978afc565 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -39,6 +39,7 @@ static const struct spi_device_id kx022a_id[] =3D {
 	{ .name =3D "kx022a", .driver_data =3D (kernel_ulong_t)&kx022a_chip_info =
},
 	{ .name =3D "kx132-1211", .driver_data =3D (kernel_ulong_t)&kx132_chip_in=
fo },
 	{ .name =3D "kx132acr-lbz", .driver_data =3D (kernel_ulong_t)&kx132acr_ch=
ip_info },
+	{ .name =3D "kx134acr-lbz", .driver_data =3D (kernel_ulong_t)&kx134acr_ch=
ip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, kx022a_id);
@@ -47,6 +48,7 @@ static const struct of_device_id kx022a_of_match[] =3D {
 	{ .compatible =3D "kionix,kx022a", .data =3D &kx022a_chip_info },
 	{ .compatible =3D "kionix,kx132-1211", .data =3D &kx132_chip_info },
 	{ .compatible =3D "rohm,kx132acr-lbz", .data =3D &kx132acr_chip_info },
+	{ .compatible =3D "rohm,kx134acr-lbz", .data =3D &kx134acr_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index e2e41dea9d9f..e3b47a6eac18 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -408,6 +408,14 @@ static const int kx022a_scale_table[][2] =3D {
 	{ 0, 4788403 },
 };
=20
+/* KX134ACR-LBZ ranges are (+/-) 8, 16, 32, 64 G */
+static const int kx134acr_lbz_scale_table[][2] =3D {
+	{ 0, 2394202 },
+	{ 0, 4788403 },
+	{ 0, 9576807 },
+	{ 0, 19153613 },
+};
+
 static int kx022a_read_avail(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     const int **vals, int *type, int *length,
@@ -1231,6 +1239,34 @@ const struct kx022a_chip_info kx132acr_chip_info =3D=
 {
 };
 EXPORT_SYMBOL_NS_GPL(kx132acr_chip_info, IIO_KX022A);
=20
+const struct kx022a_chip_info kx134acr_chip_info =3D {
+	.name				=3D "kx134acr-lbz",
+	.regmap_config			=3D &kx022a_regmap_config,
+	.channels			=3D kx022a_channels,
+	.num_channels			=3D ARRAY_SIZE(kx022a_channels),
+	.scale_table			=3D kx134acr_lbz_scale_table,
+	.scale_table_size		=3D ARRAY_SIZE(kx134acr_lbz_scale_table) *
+					  ARRAY_SIZE(kx134acr_lbz_scale_table[0]),
+	.fifo_length			=3D KX022A_FIFO_LENGTH,
+	.who				=3D KX022A_REG_WHO,
+	.id				=3D KX134ACR_LBZ_ID,
+	.cntl				=3D KX022A_REG_CNTL,
+	.cntl2				=3D KX022A_REG_CNTL2,
+	.odcntl				=3D KX022A_REG_ODCNTL,
+	.buf_cntl1			=3D KX022A_REG_BUF_CNTL1,
+	.buf_cntl2			=3D KX022A_REG_BUF_CNTL2,
+	.buf_clear			=3D KX022A_REG_BUF_CLEAR,
+	.buf_status1			=3D KX022A_REG_BUF_STATUS_1,
+	.buf_read			=3D KX022A_REG_BUF_READ,
+	.inc1				=3D KX022A_REG_INC1,
+	.inc4				=3D KX022A_REG_INC4,
+	.inc5				=3D KX022A_REG_INC5,
+	.inc6				=3D KX022A_REG_INC6,
+	.xout_l				=3D KX022A_REG_XOUT_L,
+	.get_fifo_bytes_available	=3D kx022a_get_fifo_bytes_available,
+};
+EXPORT_SYMBOL_NS_GPL(kx134acr_chip_info, IIO_KX022A);
+
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_inf=
o *chip_info)
 {
 	static const char * const regulator_names[] =3D {"io-vdd", "vdd"};
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-k=
x022a.h
index 36e9d9de8c13..ea32fd252a38 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -14,6 +14,7 @@
 #define KX022A_REG_WHO		0x0f
 #define KX022A_ID		0xc8
 #define KX132ACR_LBZ_ID		0xd8
+#define KX134ACR_LBZ_ID		0xcc
=20
 #define KX022A_REG_CNTL2	0x19
 #define KX022A_MASK_SRST	BIT(7)
@@ -190,5 +191,6 @@ int kx022a_probe_internal(struct device *dev, const str=
uct kx022a_chip_info *chi
 extern const struct kx022a_chip_info kx022a_chip_info;
 extern const struct kx022a_chip_info kx132_chip_info;
 extern const struct kx022a_chip_info kx132acr_chip_info;
+extern const struct kx022a_chip_info kx134acr_chip_info;
=20
 #endif
--=20
2.47.0


--WcPdX6aUzbDgIr8Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc0i6EACgkQeFA3/03a
ocUlJQf9GXoSAsQAT3Rj/CsO6AhBHExgB61qyUejXfii8T6p9uHpnpjuer5v8gN9
UWUI9yOGUwZaNPiKznNAMgEJVjAJNQ+JfaomecpCt7YZh6xxXi4X/XfCcWSy5lkZ
jFmu2Kep10J4JLF9tF3RH6QUkIWfc0YXODh9Wl35VY6lNYrCFTaHzey3NpooXWN0
p92VVCyYqA79Z3VXGSgv7kLwkhlAEuhKpXwzojuwipzxutCm9H0pS4VHju2GnuIJ
2mDXVswb/cyAHNHv4JTjV5OjFrzMHNtit7DQZ4U9mKOP5xELrY60ghdAfSP1mCtJ
7Wbx+c36GmRp6/Xuqw1Eq3PhbgxWtA==
=psAf
-----END PGP SIGNATURE-----

--WcPdX6aUzbDgIr8Y--

