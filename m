Return-Path: <linux-iio+bounces-12771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E69DB484
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 10:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB12B2381D
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA12154445;
	Thu, 28 Nov 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB7yISXa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED414E2DA;
	Thu, 28 Nov 2024 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784609; cv=none; b=j4WGx6Fb8UngIAJ23zewjbfWEu9qiMSuxI7x1waaK8O0WdVAJk9ccBRmQx4Lc4G16j4P/imJ3z63XLXCV/vnir2uZDatwIz3NKXiqCeM+SCu9owDL9RhR45svnfJRdmsoyQrGvEWQk2gaOrM5yybA/eCyvVUxNzwvVXA1Dvw8V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784609; c=relaxed/simple;
	bh=BozK0bq0GagTzyJ41FfQ1odVfcFYg553FMs4RIHWzos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHn4g51Gl0TWr+FFuSC82D/ErrFmt7Cx+HTvZaaEcM7MP9scGl4qp4VIC0lnNpKUXdWBeaTPvsqOE1NnMhRdSjbGmDkwuaWbC7nq6XXdMWHz6m1sVUI5uH9getpiQhjDyXU2qeUnMSW45uAzNeJE5lvKRQVkgenPpZ0E9frKm/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB7yISXa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffa8092e34so6574191fa.1;
        Thu, 28 Nov 2024 01:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784605; x=1733389405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UhDJcJyfVDqNgtZQFZmRTeTfoWRpV0TeVifUOwYfPdA=;
        b=iB7yISXa7ZdyHfRUaFnjKGETM5xg1kSpe9WOOra9CU7N0fco5Kqdlx/Nkt37ShCxFE
         Z2KEf8fR1fGb1UF8fc04j7hrX5L38LoVUTM7xxR/70S2fX6Lmmv6igbluy/4ZxwXS+cA
         F5nqKvY42JPvabWOc3LSFBZyDnu0P2H//1RormorMfhQ8qhUzpAJev/oCqW7/756KYFu
         1i4Lb4o4iFbrNILAJzu5ZeYYYVpqz1F/VPUKiiWYngrT7Z7ONC4SjpOs6JoHmzJk19Ne
         lURtEecRfYAG/jwgDvzBc86US+jyFpt2nb7Qmgm3GdSehXPByVBpn+MXwmUJ71zlqZSo
         HgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784605; x=1733389405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhDJcJyfVDqNgtZQFZmRTeTfoWRpV0TeVifUOwYfPdA=;
        b=g1inseTS4+oZuRIE2sS+AQy2wtNuAiWVWRNg4k9e8HI639KlFgegQH7+2bdFyU2BN3
         hdWu2pofDKPVEPllnaLk6u+Zgxyn1nd8qr8EAxwghzV0cYqhNfk/9oFI+NvEPLDsy9W1
         wj6jdpi0p206mtvHoYQvEQeFGkS33WTiOKbgQsW/XHRiWmPrd4SgPn7slD9R/2p1VxBK
         CubCg6xGCxqyjI2NQWJlsndFwJrFaz4xRswydHw93iPVhDhxm26oRtQ/VHrveSq7Xdd8
         G6Gnz71iME10p6jHtPg6jOG/JRqefMFCXJTFOCmmhyqz8z5m59aZkLnNuhxTtJ/H1RC7
         iJYg==
X-Forwarded-Encrypted: i=1; AJvYcCVWG/jjjEHQBIR9V0Atflw85PABG0/RPT2337NwcjKkNJVsbGOZ+0jpl8Z7t3pIV3hjoOXEs6PH/KjoM/Xx@vger.kernel.org, AJvYcCXRlCjsE8mgQpDoobCXVu1oo63Wb5a/OPm9OLw+6ikSd5hiZBUqGWQaPQJPRggY9k+up62XQXf90xVF@vger.kernel.org, AJvYcCXjb9eAGDhVNAPbTpZFN0GGNjgyl+ZQ5TN5Rcz2M2zDwvRoQSSLiDbatQun8jvKGZK4kjRIGjdrnfur@vger.kernel.org
X-Gm-Message-State: AOJu0YyRBbdpaOmHbfO18aMQuUNuczK2kIYViVMR1aPRwfCAFycP6R/t
	tS6ULWe3xOqeiJImcuDOUedPCCyryrDYvv4SEQX84WoeV7ybm+is
X-Gm-Gg: ASbGncuT9UB7H5lvMGAucz4uLs1nnLJfd8Gt7LwcpZVlHgSoY56v+AlllcdrefDh1JB
	3BxAoX/jmI2VXzC0Te0XKCFa50kl3jcpy+kEVq8Jwbqx2TCOoNd2++Ck86JJ2Ow1/FEYPQ0MALl
	qHByPxUPik/sZ8Oyeafhg64285Vwet5BB2FmuuCdhnZVMAMeau3SEzlsZiy0FJuHydudzJbczoP
	VtSjIc13sOC71n0aU7LWMYsgL49bXTypfucbTdUxc8KsXORKvfH
X-Google-Smtp-Source: AGHT+IEd31/l4Hn6iVqfw/sNeigPCk4lTB2+2SQj9dPA4fH+L/MtoSg1LKaHziMq7LvtIzr9hbZplQ==
X-Received: by 2002:a05:6512:3d04:b0:53d:de69:debd with SMTP id 2adb3069b0e04-53df00d05ecmr3750528e87.17.1732784605315;
        Thu, 28 Nov 2024 01:03:25 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6430cbcsm117127e87.1.2024.11.28.01.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:03:23 -0800 (PST)
Date: Thu, 28 Nov 2024 11:03:18 +0200
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
Subject: [PATCH v3 6/7] iio: accel: kx022a: Support KX134-1211
Message-ID: <6e95af6b425df6a5ff5218825ec8923f1341f7c3.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pcC40V6Ok/sRrVks"
Content-Disposition: inline
In-Reply-To: <cover.1732783834.git.mazziesaccount@gmail.com>


--pcC40V6Ok/sRrVks
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
  v2 =3D> v3:
  - patch number changed because patches were dropped.
  v1 =3D> v2:
  - new patch.
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


--pcC40V6Ok/sRrVks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIMdYACgkQeFA3/03a
ocWSfQf/Zho77lVfWQPpRYpL4GkUWOU4iSTStzPOVsBt+DurlmFAnRV0NTvJZYcx
wgRJICCJuln0HBA/pR3u3uPCXCJS6r8JnO3T+jhdpynPYOzha8PHUXCs0CGLOztO
+SGKjILT9MElBCUBxyv2bQJXwAveMCE8YKwQxgoNLm4yjdbYMsO7Wl/bD2ZgvZ34
xG3ZPC+SXwSJDmA4XJxoO6F2uIUOt8XpF0lBiPmAr60s2PoQZlOyGoyHnzzYQof3
Q5xokaVJqjykszbUaTJtpL+80Q22rPF+cqZvKfHDd6kkv9TziTZ1TX+LSWVdkw5J
Jovl/IeFpF1wNwvdvtIXeUpCiS1sjg==
=B/ta
-----END PGP SIGNATURE-----

--pcC40V6Ok/sRrVks--

