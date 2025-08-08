Return-Path: <linux-iio+bounces-22437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20A0B1E50D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE35F1AA497F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D56C26D4F7;
	Fri,  8 Aug 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1Cd4uvj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328A2690C4;
	Fri,  8 Aug 2025 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643258; cv=none; b=pspxTE9XKCFjyJpay6VRqB7aqvrMd8UAUFpZGYeCTkSP13LnD5ZfnijuxljiZ3jOjaoYto9XaAYoZaavI4Veqnlw3hcdhg5SMYs8k2VB+VQLrhRR+3HYSNaNnB57Lqy9yOzUoazHTlLo0O0SwavY6i+GR5+p3B/u8RiIl9lUwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643258; c=relaxed/simple;
	bh=nMzDRldyT6gamGZ8y4MMUQ0ws1QkdVOzdQy0YqPLcwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozTmspt9PeaDroswemGLwotbHOcsT0rX7hKUiFKFQlAyuoz41Gg/av5/bKVq+nUC+vsMRLcsuKB4ocx8TrGL4f02wSU+Pl57mSuFS/1O9jkf/KElo3d5WXN5hFVjPxTHQvGLsPLlTi+gW74vvNTAG40JWMQl+lqgPRJTzDCxAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1Cd4uvj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b8b8e00caso2297526e87.3;
        Fri, 08 Aug 2025 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643254; x=1755248054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWogjGnTRuwcmlfIkxh4lLwLazo54YDHCMD6nS/8DMA=;
        b=T1Cd4uvjTCzzb2zS9bgFwfVZNJvRyIktPDS/u+GqmuMEv8kVuQ9iSgO4htJzDDCG8l
         GotGTvVrLZ4kbGBX66b1MBTwKa+ZN06bsl7KL8chyMRuyrUaIHVbhSs7/GV1TGx/k0k2
         0XWLfqK/YBG78eErqlR7+he1bP2n+Nc9A3IVJY7M83n4Jzz0b2CpuVMt47YOTUSBn8u+
         MOLNC2OXFJ6jLTa7rxtAZLmqAtr3IBfdbRBpd0ULkVa9Knw/bG7tsaOJKpu/R4CnMr7o
         BM6DecPpYGMfKuLVTuSM92h+keGkepE4jmI8LGYOOLK9AjZQH9SE/LsAq2Rxb0CwjeK1
         062Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643254; x=1755248054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWogjGnTRuwcmlfIkxh4lLwLazo54YDHCMD6nS/8DMA=;
        b=PleVK5f7HzuhwJQonCZjQFtbwulpGZTlebShVykTkccOv68AP1op2b8Dd+aBFUZbSf
         1uXAk836dpm24RLC8toTGTnvKcCG2QdZdlAGl0yxrQDs/dXRExstHjRjTAZG+8f5xrmR
         GXdBaM8dtc3WfXiS54VB47GyP/pu3YAsxCCueYCfy+5B6whUV0lpoukN80Oz+FQNiP7w
         QQchAsPhF/sy/pUQKmXkE+cJ4DUjrHLMBxOkUzt+EgkCO+36v/qzPnE9r2NghPxK/+Wn
         QA8tJ/gF115ShEIqx5qaBultXCcBlD5Ft6Apw9vvd+/XClfNM5da/BNgG1sa5sCrZinQ
         GFpw==
X-Forwarded-Encrypted: i=1; AJvYcCUayg3H13Tny75zZ/xscgGzSe+Di/VWxgsLNmb7p1Zb/6zycgsi8iYAyGROL8wOsIT3ndssufn4CtkAx5mK@vger.kernel.org, AJvYcCWk0mWLISVOZMIx2cCrksYN5LrZDqcJOnwhP/9vMViktWUAE77EhvT53fHqTNcoL/mi+63NOj3RxHis@vger.kernel.org, AJvYcCX36fJlT0S/TmwLzMB/4azNBg5U8cd7tGyggjeJAOr7kPRhvAIYsz7qq/z4JfN8uQdnfnimOpm724Hv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoyvn2JkbVDV9wKKd6JfYgSmZR/3VmVGLO6ohI/QYCImQ4Lj49
	vNDxRYc6OUJjd/ESKAc9PN8u0jKczdQCc0alziFPGIL3m7waAjk/eMMC+bMgWg==
X-Gm-Gg: ASbGncs1Fcg1K6YSmgSSOLKo2kuMSfDiX0aOB8s1a409C84KHjhMV94RmFYbITW69cS
	Pd4vvZXmrPJz44byTxm4z/BTc/eAn9hYY+692Otc3y+wVGgzKN2XzNjJHjA4pOczX2eMUftp4Fb
	zQQs3JuMrdVpju27SXhqxn3+rlotBx8RfMFJsef2A5VNdLd7XAgdG3r9tRUpA55zcL5TphshbX2
	skftrfqdpZkQJWGudNNkFzIUHq9uBD/gcvuIxY/bY57XUrA4LyjTCSenWrezfJJcuv4TJwAMQ84
	1uydUaqo7g3hvNOzZBKznkV4gVEcDFeh1Krm4ynMe3YpcDVV7nvz70ZyMCLdVQrx7+ernd6D714
	UZmh9X/WFjyL2vuUWCvaTB1+4vBSv
X-Google-Smtp-Source: AGHT+IEDsSSIgbWeg2vqcDdGPmOdqerKcyBcMFifPi1Cnby+NU76x4CeDPpiP3/6+DXb9iajdac3lg==
X-Received: by 2002:a05:6512:1591:b0:55b:8a07:7917 with SMTP id 2adb3069b0e04-55cc00fd54fmr520067e87.30.1754643254150;
        Fri, 08 Aug 2025 01:54:14 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b9f77a1fbsm1912310e87.121.2025.08.08.01.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:54:13 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:54:09 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] iio: adc: ad7476: Conditionally call convstart
Message-ID: <57284a156afeb1531fae39897eba4e73d90fa5b9.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MgcP2BfGJn65CyD4"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--MgcP2BfGJn65CyD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports two IC variants which may have a 'convstart' -GPIO
for starting the conversion. Currently the driver calls a function which
tries to access the GPIO for all of the IC variants, whether they
support 'convstart' or not. This is not an error because this function
returns early if GPIO information is not populated.

We can do a tad better by calling this function only for the ICs which
have the 'convstart' by providing a function pointer to the convstart
function from the chip_info structure, and calling this function only
for the ICs which have the function pointer set.

This does also allow to support ICs which require different convstart
handling than the currently supported ICs.

Call convstart function only on the ICs which can support it and allow
IC-specific convstart functions for the ICs which require different
handling.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
 v2 =3D> v3:
 - Use indirect call to convstart (via function pointer) also from the
   ad7476_scan_direct().
 - Adapt to the change which returned the chip_info pointer back to the
   driver's state structure.

 v1 =3D> v2:
 - Adapt to the change which removed the chip_info pointer from the
  driver's state structure.

The follow-up patch adding support for the ROHM BD79105 will bring
different 'convstart' functions in use. The IC specific pointer will
also prepare the way for this.
---
 drivers/iio/adc/ad7476.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index ad9e629f0cbd..6cb2cbeafbd3 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -31,6 +31,7 @@ struct ad7476_chip_info {
 	unsigned int			int_vref_mv;
 	struct iio_chan_spec		channel[2];
 	void (*reset)(struct ad7476_state *);
+	void (*conversion_pre_op)(struct ad7476_state *st);
 	bool				has_vref;
 	bool				has_vdrive;
 };
@@ -70,7 +71,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  =
*p)
 	struct ad7476_state *st =3D iio_priv(indio_dev);
 	int b_sent;
=20
-	ad7091_convst(st);
+	if (st->chip_info->conversion_pre_op)
+		st->chip_info->conversion_pre_op(st);
=20
 	b_sent =3D spi_sync(st->spi, &st->msg);
 	if (b_sent < 0)
@@ -94,7 +96,8 @@ static int ad7476_scan_direct(struct ad7476_state *st)
 {
 	int ret;
=20
-	ad7091_convst(st);
+	if (st->chip_info->conversion_pre_op)
+		st->chip_info->conversion_pre_op(st);
=20
 	ret =3D spi_sync(st->spi, &st->msg);
 	if (ret)
@@ -160,12 +163,14 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 static const struct ad7476_chip_info ad7091_chip_info =3D {
 	.channel[0] =3D AD7091R_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.conversion_pre_op =3D ad7091_convst,
 	.reset =3D ad7091_reset,
 };
=20
 static const struct ad7476_chip_info ad7091r_chip_info =3D {
 	.channel[0] =3D AD7091R_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	.conversion_pre_op =3D ad7091_convst,
 	.int_vref_mv =3D 2500,
 	.has_vref =3D true,
 	.reset =3D ad7091_reset,
--=20
2.50.1


--MgcP2BfGJn65CyD4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVuzEACgkQeFA3/03a
ocWDrAf/cJ7BfiUMPb+mT/65RXiU+d/OYqvkHvOu/SEjFt0mZkg8WuUL+BG670XU
gC1TvWjFV4fFUTpigq0wAHyrv6ILMKzS2qFVzSbXip5QBReqjs1QRhLsJkC+j0Uv
F43L3W6HYfuFZe9HZUjNXHgqs3ykXhEzYcMJt6776/tIujyK/erqqDCSAcGBVQCE
wqIa0lWypN4lyYSmZjLedno58s2pA/qiEZq/ACLgeiNCx7AyR+XihXXENVDJLqA8
8z7gGcw+ITri6S2kh1O6UGuvoky96PEhotswYtZUPTNX97nJK46eLlCCqP1zwoMQ
7uOGBd3Q5aZRU5kmBGellJLLP/gRrQ==
=sPUM
-----END PGP SIGNATURE-----

--MgcP2BfGJn65CyD4--

