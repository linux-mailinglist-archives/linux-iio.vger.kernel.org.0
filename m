Return-Path: <linux-iio+bounces-12449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4F9D48B7
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6611F21314
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 08:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778FF12FB1B;
	Thu, 21 Nov 2024 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJZsfm7r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCE1C9EB3;
	Thu, 21 Nov 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177284; cv=none; b=Y6DKAZd683jQMvkFSn127flRtSjaSFl3c11hOA5+rDLV2qFJZg7D77P8GdndQGdGQEhPqlaActx1gxnh0tYJVICEDrfHCZg3NKX2RgW4j6gU9mAfrF3+zZHWslCmMrC+ynDWYM5mIvCb5hH+iGvTpg7HAV/RDyENm7lGXXwWb1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177284; c=relaxed/simple;
	bh=QyrEhCXNAhpBOqwFALJpqV7cpP14N52tdA96aUoxEC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqasPZfGZiQVNGt1JWaX8QaHQaTbLgEzRFN8Rc5p/koNtHkLZZ9hFfDSMDDyuVW3PilS5sF0KpRCF3x4UPJe36O/as21GRSyE2ICfj/ysWIkajd+IkKm1DK9DVZvBS5KDSF18sr4WHBBbFquqdSS6PS6M6RrwKnMP5JYIPyibxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJZsfm7r; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so6639181fa.1;
        Thu, 21 Nov 2024 00:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732177280; x=1732782080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ac6DcT7m+XqERQTxslNvsybc6SvgcEDlo0rPf5G7rM4=;
        b=PJZsfm7rwOthaTFmou+8FV5OkLqruk+fnZqBfDlS/Lagt4AIJBsHuk7PeKxLBQvcg9
         lOcb0bEmY0633GIU6M/djtPVkgGbusnnLFMvYXhLCd5tkYUySoe9Fyahh5xHQT79U5A4
         oi6YeCOP75Cs+19AlO8goGGbM7YMFlwdnWIfhoaj0grWdEaB4xOKrBiVXDtJclw1sYTe
         dSXjMVEs9vKHEdiFw4uNiBkRdQ4GaXGXmIn4hOApnBrKmqBMaCx4tTfv3fpm/i3oapXW
         DVr2n32R5p92OLsiEIhewWkmzz4D5eryTKLHd4v7vvXmfTUW7xmPT9slbmfmNY9xL68p
         CEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177280; x=1732782080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac6DcT7m+XqERQTxslNvsybc6SvgcEDlo0rPf5G7rM4=;
        b=kMeU2DpyeFDUTRGX4aeQGeTa21z4PUF8AJilVxqfYnCPh7jCIlOOz2LMgerHcEp8FV
         Xk0AkytaUjF8OkyU5Mt1VSvJCSnAzEW91194pCAfQxsK1Sa7DDP8oDfSSUIdb9Omku19
         3AIX/taPXX8PLx7yZPJjFd9gTGwH8aYj/yKZiG9OTAFYGBFl2oPK86ThfmvjAMGiZ8td
         q4xdiEhV4GXuTLxbLl422IRYp6Mvw1onDdJx/ijQ+4PegT+KCids17+SGrBevxuX0pGc
         o12sWTdNitZTVxaNUJDeg5P1KzAbhatWhYtI4hLRr8FZc1zN/aSqJa0S0wHgF7eGihvZ
         x24A==
X-Forwarded-Encrypted: i=1; AJvYcCUJtHZI9EeZZOOnXefLnA6krDaq7MsfHF+wNyjWDDjA5IknSLx4hmx08Ps4QR2UXi6ySmq3TUwiwonS@vger.kernel.org, AJvYcCV6LSE8CPibucu4JacIEUWaTWSe7ziBNsws45BQDby+OZG3C6AhtrqId4ba5PWrcBPHmICoO0sbCzLnxHO0@vger.kernel.org, AJvYcCWzAkirZ9f3X/TPZlP0xDMsKfR2UV4h4I7A7EJseTVoDnKACL5Vx3UqRwBjUJNDnWGt79iobUZ8qIoI@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOvWZeULQxf0R0HgoKDE5k3Owm022v8iB50hVJK3uko3WuOTY
	TJFsd4ppPsC2PfNrT+dXASsrcs9Ymxxa4lyjHLnylCnHhweUgg5X
X-Google-Smtp-Source: AGHT+IFpTRtafYfo+W4m9opflshPgglG4mD7WloZ6X8pHAWv94FP85Jd9cKM6AWAj44y7zQ2ZlXuGA==
X-Received: by 2002:a2e:bc03:0:b0:2ff:55a0:91ff with SMTP id 38308e7fff4ca-2ff8db0e497mr26811131fa.3.1732177280238;
        Thu, 21 Nov 2024 00:21:20 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69ae80d2sm18682291fa.79.2024.11.21.00.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:21:19 -0800 (PST)
Date: Thu, 21 Nov 2024 10:21:14 +0200
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
Subject: [PATCH v2 6/8] iio: kx022a: Support ROHM KX134ACR-LBZ
Message-ID: <ae005ae20ef05e984551aa6a40745209b042e5da.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y2ITjcJdtR70pLrI"
Content-Disposition: inline
In-Reply-To: <cover.1732105157.git.mazziesaccount@gmail.com>


--Y2ITjcJdtR70pLrI
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

Revision history:
  v1 =3D> v2:.
  - patch number changed because a change was added to the series.
  - rebased on iio/testing to avoid conflicts with queued fixes
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
index b23a27623a46..9fe16802c125 100644
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
@@ -1236,6 +1244,34 @@ const struct kx022a_chip_info kx132acr_chip_info =3D=
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


--Y2ITjcJdtR70pLrI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc+7XoACgkQeFA3/03a
ocWybggAzkYLUyUtsbYNnTopKdiF4T2N3xHPbIbPzTA9KW66nauo4QWcd+p+Cu+l
BjcL3Gim2t6V4RgZDnxYt6dAZtePEQX/w4QW2i0PHeDez2JBoCftFOgymqxkEwGi
slFn5iO25IzYyiYAfFUe9tYFQvseifGSBTHfwRQ9PrHhBsILKh6zDS4unz6hnopS
t2QbZdkUn517TclODC2fp3knHXKyW47Edg/W1jpN4enXWJ8zwq/NmAZ4iw+aWtyd
10m5JDDs7zmLySr0Vk4X/9flyb0pRS0Fl1DsiA1fnYgEq9XQ7BMdIVtoWEnFy/8k
p145+Ai7FreWiQBzpFf793enYg/cLw==
=Sesv
-----END PGP SIGNATURE-----

--Y2ITjcJdtR70pLrI--

