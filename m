Return-Path: <linux-iio+bounces-12769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F869DB480
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 10:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC89166D19
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE69156238;
	Thu, 28 Nov 2024 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njdC85wN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC6154C17;
	Thu, 28 Nov 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784577; cv=none; b=VTKVM8GU1Y0FD8BzC+1bUgp8rqT4mVU0ksv7XdEGDvc1yWgyCVYPq2xg47xi6uZ39YEPO5t5rKr9RyYLfRO1p/8WEfMKnl9O2XMpWbDOVLo2xm4qx6/ITZ1+rdJR91ffpA1lRVlFdBBEwVdOrw3dtUluitgPh9u39cSnr6OhDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784577; c=relaxed/simple;
	bh=fjW6D3iIw02hXTHuiiDDX2Yp1fZBRd7dCiCdiiPOwF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFo618fOB5pMMv0O7cMOdLKi33TcDWyMcUNBB6p1qHr1IiA2yP0RUhS4gx4f3TW9xT/jXD2MKy3kmdBhntnhw8vh5xV0BWgdIeFkycM3PBO75aPk+PJcXBe3yvsvWcIxcuiu9tjqtMDe7ZJnGsxmqkA5aPonHe2SkObfBwvv2Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njdC85wN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53ded167ae3so685665e87.0;
        Thu, 28 Nov 2024 01:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784573; x=1733389373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oF/+3kCu9KXAtvcNzSgI4p1+vhLomCHXaKzHdk+jh3g=;
        b=njdC85wNgN9horKL3nIE/ItdKVWjF4akocO4DqJKjAB6fQXzr8vu4BZUVo4yAdsMMo
         i/C9q+Li+cwc17wdh1Y7cfKfB5t/sW+uxBw6R8sKi9kcYRhISlZ0hHqSsa/u+ve5IkuM
         lRNx+t6fQ5JQgnyErkixUmEwLgpgmNVvAdXBoCEuh2/F1Xk5HH3tX6QFNVCxNCQGyzZx
         5V7uJ8E1ahtUEiRTbHa5VT2Egbeek2YemJdORiAs0QJKMYpLp8ng1NKUffgKySr1Ilz8
         Hr+g63CtlGDraV46QlJ1Zdv0HN+gkzxXDGur3ez9kv+I+mSFEl0YYwW0RiOpljDRdn5W
         0AeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784573; x=1733389373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF/+3kCu9KXAtvcNzSgI4p1+vhLomCHXaKzHdk+jh3g=;
        b=Ppf5Y1tdCBWhXIDIto3fI/N0eWDMWt5GX9rWNGh2QZsCBFGoYViiXoMc58S/dc8X/l
         Mxum82rOUICww16tEQJ+qoCSSldBmKlsasCKYc9iB3wXqxL+CD++S2Vc9XERdOBTlDbs
         a6qApV52SufBM1bGZtVcc0tbg9TSrIrm6bPjOlj+Bptn4ufHbGLtqpeR41q0U82yRiUx
         PsdgoIOUX49CPI1z1+BsF5Ksuk4gn5y4zmy6AXmCKcx8d6nknpw3xAp2LI1gHkFlxOIP
         88Javib2bBYczxHMxjexlaTnhRvLYbaFtiztwfZ5FnyVdWL6dl7o7cfotw8Iq8MbntQH
         qAxg==
X-Forwarded-Encrypted: i=1; AJvYcCUuEuXmMEmT98LwjAIDP4G48UK+8nRD6FQv2H79AQKD40jy0EWCueYWpQqFoudQ09XeNMAskm7DX/3o@vger.kernel.org, AJvYcCW7cs7IexyeavvS0gTFhTGi+/kBUJvgkFCLLHF/+5iSt/Z8WGtfYK3U2/WTEU6mqlTpk6kb0BQsQr89m+wD@vger.kernel.org, AJvYcCWLPSGNUVWeAulKVvHrww9ODGzDzYwe7Tts134uGCL/u+AhIqzqX1cIBv9gNaBhwaqFdRYxdXLZ4ViD@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHRQ53G7kwSU+FKdTfuk+cWorC9xQu2T8OkJFC7LklgHyUMOs
	WfLE0eUmzjiKcY1jt6QNGGzRMqRtFZWj6usruuU5ttslFMtCzszI
X-Gm-Gg: ASbGncvxWRuxuEYk4XU/a1yAeZHg/05b/bQGnIc+ab0i8VGXyZnHYg4/q5105PeZtrz
	R2s/V9fEWOoaslCM6vo+ootRVRVyBCsVBXKgBj5nTz3KPu/J/M69ztZOyiSvouBmOL1bza5YjVJ
	03bxlXOup0jqyk1KYYF8ZkvjKCyIaDp+pbnX9W62lo0IydRr/EnTzIsQlXHNN7AtCqC/5XGcMmX
	g607PKnL39rala0pJYxWfvEfvSe4Pzhz0Izkh2DVEIiTr9scBff
X-Google-Smtp-Source: AGHT+IErq4imRX3wLkkf5SH9n7pslkqAr9BpQxDOICuCh4OpJMn9bEk6NOCRZ3vHCt+KUJimkXQeKw==
X-Received: by 2002:a05:6512:32a8:b0:53d:f09e:99d3 with SMTP id 2adb3069b0e04-53df09e9a97mr2590488e87.0.1732784572968;
        Thu, 28 Nov 2024 01:02:52 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6430e74sm118560e87.9.2024.11.28.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:02:50 -0800 (PST)
Date: Thu, 28 Nov 2024 11:02:45 +0200
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
Subject: [PATCH v3 4/7] iio: kx022a: Support ROHM KX134ACR-LBZ
Message-ID: <27c43c595de1f3f698ace671922d4f5a48c3cd54.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/MeALgLoBC5o0rp/"
Content-Disposition: inline
In-Reply-To: <cover.1732783834.git.mazziesaccount@gmail.com>


--/MeALgLoBC5o0rp/
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
  v2 =3D> v3:
  - patch number changed because patches were dropped.
  v1 =3D> v2:
  - patch number changed because a change was added to the series.
  - rebased on iio/testing to avoid conflicts with queued fixes.
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


--/MeALgLoBC5o0rp/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIMbUACgkQeFA3/03a
ocVHqggApB1SAUD15L2f8gb4nn3HXKqQJmIFKySgvyn7Y4nN6bBVXwgb3Q0iAfzw
X3Ft+pGFaGgu4QFW3N9S9U2ua2pnUyQFAp+TbH2p+FMpcj9eyUv5XObXOWUOAY0x
Tg2Pz2aU50N5Pz5Ilheyz2QYBZOcFOpEtO8aY0T4kpIbmx4GXAz6ffiNselTFov1
pMayVfvhAljGan0tXvLlWskVkZZbTGJayZHwYACbJ5KrkO1MzvtOlBcW3vWJZD7H
zMda8hpeh3wBwaJ9S8m98mD9uhm64LV/BVG1vZxy3veGUM826Mp30fLeZ2Rp21BO
mxRPrXtgyDhibTysbVcMr3TZMH/YOA==
=ljZl
-----END PGP SIGNATURE-----

--/MeALgLoBC5o0rp/--

