Return-Path: <linux-iio+bounces-16356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC25AA4E1F5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12BF7A21B5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC7920898C;
	Tue,  4 Mar 2025 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GITy0Rqj"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1D207A1D
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099970; cv=pass; b=iwE9Hvbq61nWn/OY5EJPsP1NM1MK77ITwGYUGTzdubOjFY232XqMBeH49ptDEVg06YUuqealTyQmc9b3y+rjFYdZOUDugse7IAAxNmvHEzh3g2rOZahpHvkVequ6SN7rGihFJRre9ejoMUAu+fc8JOT8NwupOWDKZ6H2pL3K3hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099970; c=relaxed/simple;
	bh=EbucS9fypPRrxe77EUKH2Wejd1lPYl15t0UP9HZGEqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK5dIqGIdmbezmSBqYBDEO6MerY5Bi0xFjox25RgiqQOPXkmgB4NCVi3CXHAksXkZ08dEMBwIiUsn9NR0Vi4lkymO2uJBz4bMPzmqCJ2FMPmlFDzY6TAonFrbRFfo1YXv0yWyX/YZF3Lj0oxn57rT4vT/KaaVX8o2WT03L4Yh9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GITy0Rqj; arc=none smtp.client-ip=209.85.167.43; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 3C3F040F1CD1
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 17:52:47 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GITy0Rqj
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dsh4YBHzFxnt
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 17:51:04 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0C1AF41898; Tue,  4 Mar 2025 17:50:54 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GITy0Rqj
X-Envelope-From: <linux-kernel+bounces-541592-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GITy0Rqj
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 38DFE41A6C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:34:42 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 0DF582DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:34:42 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8626A1885987
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208D1FC7EE;
	Mon,  3 Mar 2025 11:33:34 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23F1FBC8E;
	Mon,  3 Mar 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001611; cv=none; b=XEdzSryMJfS+IMIG8E45F0SkyJMknDDtVe6vjzs1uNVubJULX4oiRkxkIS5JRiZVf68BsgdvR0Jj/E8aUL8UxMlOuQYzQtrfnEIZ2z5OHrbvVBg8rQtAWDBHq+//9wVLxu44pWqzbu/gcA0twv5+MdHlf1l3nOA8B/3FXeVJZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001611; c=relaxed/simple;
	bh=EbucS9fypPRrxe77EUKH2Wejd1lPYl15t0UP9HZGEqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzdT0XVdAJ/qQ5nENs/rZe179686YmnCg/k6rI8zIO1ySOpIYkDQfygq76jEHXofYasUg6jq7/enEJNSTflVo6OHr+pJBmCNOLbW1UnqONUObM06IQ5kzYQI3Rc8pXQh1k5xEqXATXHYOBHPA/1tjEfuOYF2efZ+kNePYAEPuQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GITy0Rqj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54954fa61c9so3328581e87.1;
        Mon, 03 Mar 2025 03:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001607; x=1741606407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9+cj8/dfHbTSNAL8XTYITukNJGo/7BX2z1hHrSetVU=;
        b=GITy0RqjSE14XIkKTitreAvzxCGZZURIovg9KhqbArdzc6eWNrZms5tLuTLWA2WthN
         jzx4mqBXmK4juNVL+Pagd+u/J/LwVt5utgqXzDKtBah3jrExBM6SbU9MCEqfR5/xHbP6
         hKyFAB+u9dLlAORZe4TAuEhHJiqjRS9eO4P5tOZMp2oqkbV1Xea8HIrWHt/iQ3KPYljw
         5byWFxmBGOmENHPFIKC+1qdL4uJ2pEsMfxmbVrZjAhzanf2LxwNVeDXUrDFe0IAdNu0u
         IOFWBRbP+NqnOZcR67Sge8otB7Gwr4kzbMrVPaPOkGpgTxrwXbGvalVnXSJSMhv7rxs1
         icwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001607; x=1741606407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9+cj8/dfHbTSNAL8XTYITukNJGo/7BX2z1hHrSetVU=;
        b=Lu3xD7juGIu26r54mDQ0ZhsrNg56kLM3sNWwr1AAqzsKhW02dDVt28N7JIBAvilRB3
         vrhFDYOVrCa+dSnKsCXaHKNskqgldhupOlkFvOFfOrTNXADdy9IqHaAE4j3j5Yfgh+sZ
         JlB2sSNa5wup/wJIZQXTAxgobiHA0Nv6hsDcSYft2p+xwYU5/8A6T0m9Iqhc1MWVmr1Y
         4Xt34WSAyFNSP/QpFPAZX1fCej/ozJChLee2xBnmF6A0ga0dKHXRCqzkLDp+gsXVwrR6
         ITf48bp3RqgeeLK7J8sym+ZyRFLPAUpdaWLzbY29MZlgkw+c3j8E0Klu23spxaXevA2l
         6+GA==
X-Forwarded-Encrypted: i=1; AJvYcCU0g25ZIanPQsCWaRgNy1eFja8GRfxRMvkB3eZIiK69upqsbdK6H66cJsW5opxD0v0/dUYnZo3OCeE=@vger.kernel.org, AJvYcCU9cq/UszcnNoOJZtaGJ/x+lMYM/32Y3aRFxe+mLr6dMPz+HQkeSsIJv5IRJKZ/gLykqKr97ZHvHtMri27Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAnH9WkT3QWAE7lV1xcZtiDERAuI0GJTzn2Z0/dM/DqPrquiS
	pNUVHuTPD6o5uzm54XHsGyFbS1w84XJqzXIpdDVkZCzMBDNi4Lte
X-Gm-Gg: ASbGncsCXUXSxlfRt74SBhbeGGs6E4wbCaXREu9DSfk15gbxhpkSweMWqUscE16+82E
	yI4ngVA8T7AjoAaVNTjKNoYCJpQVWDpwrub2IDj7KLdbjOOrfywNiJtfigh83yM8H96Yhfq7jLn
	Q+IZ18ZaJ8kMto6frnrUyRF3vjXV3zf9O5CZuUT4iWYkpBFL3Mrj2S9rKfHfySZqUxr40I8+xJ2
	Wzjx65wxcm4WiHIgG5ULDLblWH2cRQT3RPEhMxpNpP1olG2cdRbwDGPZ58yUlUoSGdyVCT7eX+r
	lXWrl4X3pgTa0eP3jDY20QRO+IcJIg9d7OIcSIwtC2tG+1xQtI2KkKLwrq+u7rCsSKsyd1u6NJ9
	+OkL8qgY6lCI=
X-Google-Smtp-Source: AGHT+IELLGKVO/o+HmAod5MzHgf6kI4dYfAzYeQr2/x9V6T8BPVqqc3LSAZb/E1O4jjjBc626oReGg==
X-Received: by 2002:a05:6512:3a90:b0:545:60b:f38d with SMTP id 2adb3069b0e04-5494c107f3cmr4953235e87.8.1741001607278;
        Mon, 03 Mar 2025 03:33:27 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54963b5f23esm406831e87.55.2025.03.03.03.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:33:26 -0800 (PST)
Date: Mon, 3 Mar 2025 13:33:21 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/10] iio: adc: ti-ads7924 Drop unnecessary function
 parameters
Message-ID: <2bb4c61122eca2f3a35f6087e7d9815675013f66.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gwlQIDs1bHgXfyTL"
Content-Disposition: inline
In-Reply-To: <cover.1740993491.git.mazziesaccount@gmail.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dsh4YBHzFxnt
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704675.82069@WUZjplqCuKTPthRwSSexLg
X-ITU-MailScanner-SpamCheck: not spam


--gwlQIDs1bHgXfyTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Device pointer is the only variable which is used by the
ads7924_get_channels_config() and which is declared outside this
function. Still, the function gets the iio_device and i2c_client as
parameters. The sole caller of this function (probe) already has the
device pointer which it can directly pass to the function.

Simplify code by passing the device pointer directly as a parameter
instead of digging it from the iio_device's private data.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v4 =3D> No changes

This commit is compile-tested only! All further testing is appreciated.
---
 drivers/iio/adc/ti-ads7924.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index 66b54c0d75aa..b1f745f75dbe 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -251,11 +251,8 @@ static const struct iio_info ads7924_info =3D {
 	.read_raw =3D ads7924_read_raw,
 };
=20
-static int ads7924_get_channels_config(struct i2c_client *client,
-				       struct iio_dev *indio_dev)
+static int ads7924_get_channels_config(struct device *dev)
 {
-	struct ads7924_data *priv =3D iio_priv(indio_dev);
-	struct device *dev =3D priv->dev;
 	struct fwnode_handle *node;
 	int num_channels =3D 0;
=20
@@ -380,7 +377,7 @@ static int ads7924_probe(struct i2c_client *client)
 	indio_dev->num_channels =3D ARRAY_SIZE(ads7924_channels);
 	indio_dev->info =3D &ads7924_info;
=20
-	ret =3D ads7924_get_channels_config(client, indio_dev);
+	ret =3D ads7924_get_channels_config(dev);
 	if (ret < 0)
 		return dev_err_probe(dev, ret,
 				     "failed to get channels configuration\n");
--=20
2.48.1


--gwlQIDs1bHgXfyTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFk4EACgkQeFA3/03a
ocWH6Qf9FyzEsyqkzgN9MZRHwDCGKzAlC9o6MXhuUysrrkV+2T4yCPFQLuJ9/riu
EJzcbBEnnsq/IIZuK2kP1qaWku3h/BA4LtzHaEb1zvczRXJDO0PVx8lFmXRsYqho
pjMZE/2NzEDXor3SUKgKdxbT7mqpwZiLHRAwAyACsn74cBmwNTcK8dIqP1gNapH6
LciyxcMQ/BGnz/yECLN5gjfyJ6Ht/2P9y1tYUfUQeoD/1EntEdeUSxZn1C7K7Wfw
Dph4I5jckTj+EfMXGg9BmBChfhG1TtJ5KHMdPSA/HiG98UG3497yG1CMx5chATPA
T4qKyEN11pYl8IKhw0mGrPskOmJZww==
=3FY/
-----END PGP SIGNATURE-----

--gwlQIDs1bHgXfyTL--


