Return-Path: <linux-iio+bounces-12451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B884E9D48BE
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D430B24267
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 08:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8918B1CB511;
	Thu, 21 Nov 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8kDCojT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92011CB33F;
	Thu, 21 Nov 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177317; cv=none; b=vBcn+U9xKyVhC0wqT56xtqEkZwL6b7/UMSWf+8hppv9yXx4Fa4nH2K/7h2S+RSo9IBPVXosaZg+ObbZpyr75K6ZwKWoSSnT+9BH+K4fV4+lH+vsbYgVMLn2bdpJP5BUZCi7vtQaTGxM2E7OmG/3vSWLFHsFMRySNOdcp2WtjLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177317; c=relaxed/simple;
	bh=dGN2Nm+0BkDArBThjkDHlNygFnYu8lKpAr+UO7Am8CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIQj34yhfLBX+Zanc/1F+4+OePUIEg2XtvEgblg3Ubj9XjrSU1pRm0bJVv4A0gmB1TgTVtJSidGcC6P1kxS3poYrCRcl8eJH2ATVNG4wSCmuNezdZLnIg3NqOYotiv7M5DKu2rhiOzec9lAh/lZTuyKNxIG7BhMOPUmu5yVKCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8kDCojT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ff550d37a6so7600711fa.0;
        Thu, 21 Nov 2024 00:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732177313; x=1732782113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn43AcFqNBvQ9O6y3AMVs8AexQzeuQlFzw2cpuwp37E=;
        b=K8kDCojTI8ltoQHovc3C5D6FElnHhbNe6udGcds7assdgGLAstNhQTZ5shrxl3GOcg
         5YPRBsUKH8pw9KfLzGjgxGxLtaXmh4RVRIcwcLEGeVYUofIanbvJ/eib59rJTnV98w/S
         A7VU4xMbAK4dKj9EecjD2CqG6Hnytob0uJwNE0Tjlkv/8Jo9hSM2sjUcBOyxVTrU00fO
         Lq7fAo7MRWye7NXAuPogV22APTUs5M31zr+Y29lkAbVSvywKOcjC0UhPGn2JfRAS7CT9
         AS41j/uPbrTtFqnkdtpBJMycLvPwK85/vnZNkZRKlgzcGzb/LLDk9UQfR9dShE2rC8A7
         QMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177313; x=1732782113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn43AcFqNBvQ9O6y3AMVs8AexQzeuQlFzw2cpuwp37E=;
        b=cfHOBxgucxATGmwH70t06QGDPxZa5qbfsVy+Yd82CNqQ8QalY3Ae7A2mSF2vOWmAc0
         J7jUeizOHvikcvw8DNsd458ASJobJFYWas+q4Hn4U83BSR6eEpyuVtlxM9TJwfLfICuE
         aW0lS95RiGQ4lmjXBhS89dkz4c+qCSTxvKQUYMNmdR3sNCztObWQHM2U+ZsG0/cb76Ce
         CwkzkIxXtODpdi+Dm249ThrxKt/PFzo8NwPgDWkJaM0dQMaiZewTxkTR3J9+05JElWLs
         6t35SmlHY+et+rZ7bRj3ihfZ5UUfkEjRyQ/vEILS8VVDOVl3F5qVaZ6bjs32G9VWanD0
         pG8g==
X-Forwarded-Encrypted: i=1; AJvYcCV+3SoBmhJtOfisZE9Ta6D8WDCCS7C1TEa7VUkXrBlsNwPvhAXXXlOZZEFDx23TseHdexbo7HtDndxVki6K@vger.kernel.org, AJvYcCW1DoNcbkiAfacUsH3AaQ4YBYKF+7oYeAI0RYys2DcdAb4ZHb3MZPjQLnEIfNaeEaZEbB01hBGH0HAj@vger.kernel.org, AJvYcCXHhVXjsX8WBI1mVeL1dIsczUJZyogpmbDelKcwWuMftPvultuU8zTP91134iJkQzMvKahZZyTZ4xp5@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhr7advbb1aup0PNqm5KuTeSOWUM8m/ueN/nEVfT+XOTgIS1k
	TDtWXPnBqMsRcDofx93ZX7HRcwFLjZLJVZO1oU5P79HWqw2yvqIc
X-Gm-Gg: ASbGncv/O/+aTex9zCHh8ZVGxTQguV500mimGvtLABfm9zj+bRzRnjpiutzqsd0ZVHG
	Bx/7vMuzx+JFN5A/xlELV9AqzTMoLunumeEhNdjkvG0zMPP5PpiLkNLQtDaZ1gRa6kBps9sERBb
	ocuDiqyFAqE8LheP7SE33EqWNI/Q7+ZI8CQ+cCV1QCIq5Pijv64ZQNqJDwUCprujpyl0n1IscYE
	VnTm7nNf5uRCqVYA3OFKtw9E5M7G7589/ki4QXpsi6oLXnTKyrG
X-Google-Smtp-Source: AGHT+IG8q8e6bzQ90TXu7yt52oGt8qHW6ZY1jHaXuiCoCg9dksvHwao03XMcXo0Ja6yigUjZfcY4ng==
X-Received: by 2002:a05:651c:12c4:b0:2fb:607b:4cde with SMTP id 38308e7fff4ca-2ff8dcd2f96mr28224791fa.39.1732177312557;
        Thu, 21 Nov 2024 00:21:52 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69851577sm17891751fa.9.2024.11.21.00.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:21:51 -0800 (PST)
Date: Thu, 21 Nov 2024 10:21:46 +0200
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
Subject: [PATCH v2 8/8] iio: accel: kx022a: Support KX134-1211
Message-ID: <833f2f066e12021bfbca25d84f9c4673b902a8bc.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PLvimeSiTIMtWcQ/"
Content-Disposition: inline
In-Reply-To: <cover.1732105157.git.mazziesaccount@gmail.com>


--PLvimeSiTIMtWcQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM KX134-1211 has very similar register interface as KX132-1211
does. The main differencies are the content of the "Who am I"
identification register and different g-ranges. The KX132-1211 can
measure ranges from +/- 2g to +/-16g where the KX134-1211 supports
measuring ranges +/- 8g to +/- 64g.

Support the ROHM KX134-1211.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

Revision history:
  v1 =3D> v2:
  - new patch
---
 drivers/iio/accel/kionix-kx022a-i2c.c |  2 ++
 drivers/iio/accel/kionix-kx022a-spi.c |  2 ++
 drivers/iio/accel/kionix-kx022a.c     | 30 +++++++++++++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h     |  2 ++
 4 files changed, 36 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kion=
ix-kx022a-i2c.c
index 9fd049c2b62e..7359073ae0c0 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -38,6 +38,7 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 static const struct i2c_device_id kx022a_i2c_id[] =3D {
 	{ .name =3D "kx022a", .driver_data =3D (kernel_ulong_t)&kx022a_chip_info =
},
 	{ .name =3D "kx132-1211", .driver_data =3D (kernel_ulong_t)&kx132_chip_in=
fo },
+	{ .name =3D "kx134-1211", .driver_data =3D (kernel_ulong_t)&kx134_chip_in=
fo },
 	{ .name =3D "kx132acr-lbz", .driver_data =3D (kernel_ulong_t)&kx132acr_ch=
ip_info },
 	{ .name =3D "kx134acr-lbz", .driver_data =3D (kernel_ulong_t)&kx134acr_ch=
ip_info },
 	{ }
@@ -47,6 +48,7 @@ MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
 static const struct of_device_id kx022a_of_match[] =3D {
 	{ .compatible =3D "kionix,kx022a", .data =3D &kx022a_chip_info },
 	{ .compatible =3D "kionix,kx132-1211", .data =3D &kx132_chip_info },
+	{ .compatible =3D "kionix,kx134-1211", .data =3D &kx134_chip_info },
 	{ .compatible =3D "rohm,kx132acr-lbz", .data =3D &kx132acr_chip_info },
 	{ .compatible =3D "rohm,kx134acr-lbz", .data =3D &kx134acr_chip_info },
 	{ }
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kion=
ix-kx022a-spi.c
index b20978afc565..50aeaafc56ec 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -38,6 +38,7 @@ static int kx022a_spi_probe(struct spi_device *spi)
 static const struct spi_device_id kx022a_id[] =3D {
 	{ .name =3D "kx022a", .driver_data =3D (kernel_ulong_t)&kx022a_chip_info =
},
 	{ .name =3D "kx132-1211", .driver_data =3D (kernel_ulong_t)&kx132_chip_in=
fo },
+	{ .name =3D "kx134-1211", .driver_data =3D (kernel_ulong_t)&kx134_chip_in=
fo },
 	{ .name =3D "kx132acr-lbz", .driver_data =3D (kernel_ulong_t)&kx132acr_ch=
ip_info },
 	{ .name =3D "kx134acr-lbz", .driver_data =3D (kernel_ulong_t)&kx134acr_ch=
ip_info },
 	{ }
@@ -47,6 +48,7 @@ MODULE_DEVICE_TABLE(spi, kx022a_id);
 static const struct of_device_id kx022a_of_match[] =3D {
 	{ .compatible =3D "kionix,kx022a", .data =3D &kx022a_chip_info },
 	{ .compatible =3D "kionix,kx132-1211", .data =3D &kx132_chip_info },
+	{ .compatible =3D "kionix,kx134-1211", .data =3D &kx134_chip_info },
 	{ .compatible =3D "rohm,kx132acr-lbz", .data =3D &kx132acr_chip_info },
 	{ .compatible =3D "rohm,kx134acr-lbz", .data =3D &kx134acr_chip_info },
 	{ }
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 9fe16802c125..e3986dd65337 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1209,6 +1209,36 @@ const struct kx022a_chip_info kx132_chip_info =3D {
 };
 EXPORT_SYMBOL_NS_GPL(kx132_chip_info, IIO_KX022A);
=20
+const struct kx022a_chip_info kx134_chip_info =3D {
+	.name			  =3D "kx134-1211",
+	.regmap_config		  =3D &kx132_regmap_config,
+	.channels		  =3D kx132_channels,
+	.num_channels		  =3D ARRAY_SIZE(kx132_channels),
+	.scale_table			=3D kx134acr_lbz_scale_table,
+	.scale_table_size		=3D ARRAY_SIZE(kx134acr_lbz_scale_table) *
+					  ARRAY_SIZE(kx134acr_lbz_scale_table[0]),
+	.fifo_length		  =3D KX132_FIFO_LENGTH,
+	.who			  =3D KX132_REG_WHO,
+	.id			  =3D KX134_1211_ID,
+	.cntl			  =3D KX132_REG_CNTL,
+	.cntl2			  =3D KX132_REG_CNTL2,
+	.odcntl			  =3D KX132_REG_ODCNTL,
+	.buf_cntl1		  =3D KX132_REG_BUF_CNTL1,
+	.buf_cntl2		  =3D KX132_REG_BUF_CNTL2,
+	.buf_clear		  =3D KX132_REG_BUF_CLEAR,
+	.buf_status1		  =3D KX132_REG_BUF_STATUS_1,
+	.buf_smp_lvl_mask	  =3D KX132_MASK_BUF_SMP_LVL,
+	.buf_read		  =3D KX132_REG_BUF_READ,
+	.inc1			  =3D KX132_REG_INC1,
+	.inc4			  =3D KX132_REG_INC4,
+	.inc5			  =3D KX132_REG_INC5,
+	.inc6			  =3D KX132_REG_INC6,
+	.xout_l			  =3D KX132_REG_XOUT_L,
+	.get_fifo_bytes_available =3D kx132_get_fifo_bytes_available,
+};
+EXPORT_SYMBOL_NS_GPL(kx134_chip_info, IIO_KX022A);
+
+
 /*
  * Despite the naming, KX132ACR-LBZ is not similar to KX132-1211 but it is
  * exact subset of KX022A. KX132ACR-LBZ is meant to be used for industrial
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-k=
x022a.h
index ea32fd252a38..142652ff4b22 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -78,6 +78,7 @@
=20
 #define KX132_REG_WHO		0x13
 #define KX132_ID		0x3d
+#define KX134_1211_ID		0x46
=20
 #define KX132_FIFO_LENGTH	86
=20
@@ -190,6 +191,7 @@ int kx022a_probe_internal(struct device *dev, const str=
uct kx022a_chip_info *chi
=20
 extern const struct kx022a_chip_info kx022a_chip_info;
 extern const struct kx022a_chip_info kx132_chip_info;
+extern const struct kx022a_chip_info kx134_chip_info;
 extern const struct kx022a_chip_info kx132acr_chip_info;
 extern const struct kx022a_chip_info kx134acr_chip_info;
=20
--=20
2.47.0


--PLvimeSiTIMtWcQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc+7ZoACgkQeFA3/03a
ocUQTAf8Cq62fxAksV9iCIpVwhHxL45PZQirwWM2XaIPIHi03dPDHmTqIBrLSJip
8k3Dl/w8G+5xNLPxbE9D/r7Y4zJB34546/9GKqJc68h3m9BAZXbRMzh5mxGBSviu
Buo0F0Mr8LIkcVWLEzGbkmUM6l1JfJW4iWFwcR0RNduRwIm7ZY0tqT8td+2dURZV
LAzu1UiomeVA/JyJ396PCY7zddx+pLyI649VeEE/PxBFBUqWYLWPevS2cN0ThKXm
YXXb1m+bUpbwC9mjIbTv47SthmpZRo1I7gWDg15FGoLTbGAfCLUMu1ErxiCz0dgf
5+6Pqx+uei2MuHf99eImuIuUdOLCMQ==
=v7i2
-----END PGP SIGNATURE-----

--PLvimeSiTIMtWcQ/--

