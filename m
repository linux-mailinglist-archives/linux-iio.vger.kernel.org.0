Return-Path: <linux-iio+bounces-12196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5599C6DAF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 12:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A042822B6
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50932003C3;
	Wed, 13 Nov 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzMkH+cf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66111FA279;
	Wed, 13 Nov 2024 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496790; cv=none; b=qoQXAa6kl/zNnrj1HdvMaY+ua/rIE1dZaMUcGRB9AhiNo/teO6wvKq2x48IJjNqAesiCJSGjUYGaKzUU035QP0YJ9Lfa2pjPXXtzsFPNnXOrobLFSOcB7UllWUQVGud1zErCrdhN/f/ltnSdNOmS/iFC7N6hLOsyEObGk8QwT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496790; c=relaxed/simple;
	bh=vu1G/K3iUOYc77Q2pZ4u5yw9IRJOBW0fw06l8wMIUuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJUbgS5yeZv9bZLE9pr9MRwG4JICGdN5HLfs44c06f3D15xunG+wy+h2QV5Hf+ncV6wQsOJAQ3nJap6d58BXuBzup+t6irAZ+c+ahfpp7sO6pbvNmRLUJm8K16yCvlYS6qTYOKtM28UcMGn2XCop37qq8k7DnXqUBSgLifEiPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzMkH+cf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so80476301fa.0;
        Wed, 13 Nov 2024 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731496787; x=1732101587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVyD+0LvveRPdZcA7UwxKxYNGvXm4cKi4+Ze2YrwQt8=;
        b=DzMkH+cfl0tDSLKZhHQu+mVdKka3AzLO2k9ON6lDLerFfq5NAAYzOZ1JyvSUTP7PNb
         TjGjNfVmtJrPTO4UVWd8ypSpc68R2tLccxSFt52Vb1WXSiKfVVMgnLBEjD/ayHo/5TUB
         7bcGq+SB5T8puiqEKeATXemCMvHhw82MQ0GiB0LJOxsAhriB0F5oROMQ/x93tgQAf4W2
         zCPipZi2QUGj/Yke6Wqb8oBPNvTbcE28suKwLYKpXY61TIKQm/fbPaBbtJS7F5CIaIsU
         0zRhHrl4Ds91CQ54Gc0gbtYUWaxAyj/Cjkx76OklcPGO2m5vS46idnnlBPJDaqo96ip0
         Bnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496787; x=1732101587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVyD+0LvveRPdZcA7UwxKxYNGvXm4cKi4+Ze2YrwQt8=;
        b=lWWWTx++IzPEM6Zg0JH07ykezF9rGU3RllQTtW1AFWewQEjQU3zEy9GXBQwGzYNdzW
         PWTNg9uRtvEodGmWpgw/kA6r5nNRSpus1zhc70hh1tuVqxvvcJU6emIdodsdv3AvXlua
         s/2Qb61UqU9QMM/R/XQ4nSOHKVxd2WhYnvSV11vClqB0BsMvg9dxJ1AjgziiequmAHmp
         +xrlmczBg9p2x8M/yqru5MHJE0D/IplrDiVReSlA2/MwT4JjkUBUcQDDAbd4zrKKW7EL
         Y+SrNNvGREpQWf8FGscXTEegJItBjQlob0p+UqeIwwHVtZZk/FGqYInGlg4k5Th7milt
         GSxw==
X-Forwarded-Encrypted: i=1; AJvYcCUXpfcL6zdRFcCvW/2FnHYUHMGy3vpRov53ctMjGyG4BeG34VEXGeMlKwJjHv/x8w4XCqPF6bnqtvQTB25y@vger.kernel.org, AJvYcCVrbH2SLV3DQCvHLHdXla60JeXzUmn7jekRvKTlWLSBzJMEJBPDgkMB73mevXasmqXmFJ/V9cNM6O5h@vger.kernel.org, AJvYcCWbdbIR2gelaagjgp7jtaG5X2SC76Cz2DZ5W3q4wft5r425bHVixC/25W4CLADRgrd1OS2LLvki0rss@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnNxh5couJTMAbsfUilYkKCoLWHk4cS3rlL1zdUneZzIfrUFg
	upgLtDwV/KEMyOzKX8gXNwPRY5NaKzdNJd1RJVsO+zsO+z+zFwV5
X-Google-Smtp-Source: AGHT+IEaQgpg0/aLF4pYWyIyyKOugIN2gsZBC22UsZsmIceAVgA64VsbH6WuqDqITQEnEDhc8M93Lw==
X-Received: by 2002:a05:6512:3096:b0:53d:a214:386 with SMTP id 2adb3069b0e04-53da2140599mr1201785e87.27.1731496786624;
        Wed, 13 Nov 2024 03:19:46 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da2191b35sm103761e87.72.2024.11.13.03.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:19:45 -0800 (PST)
Date: Wed, 13 Nov 2024 13:19:41 +0200
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
Subject: [PATCH 1/5] iio: gts: Simplify using __free
Message-ID: <4db5d44854c9af1b7ec8a70b28f03d8488628868.1731495937.git.mazziesaccount@gmail.com>
References: <cover.1731495937.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i/ogBz58vmcQq9xY"
Content-Disposition: inline
In-Reply-To: <cover.1731495937.git.mazziesaccount@gmail.com>


--i/ogBz58vmcQq9xY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The error path in the gain_to_scaletables() uses goto for unwinding an
allocation on failure. This can be slightly simplified by using the
automated free when exiting the scope.

Use __free(kfree) and drop the goto based error handling.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/industrialio-gts-helper.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 5f131bc1a01e..85b43441b5d1 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
  */
=20
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/export.h>
@@ -168,7 +169,7 @@ static int iio_gts_gain_cmp(const void *a, const void *=
b)
 static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **sca=
les)
 {
 	int ret, i, j, new_idx, time_idx;
-	int *all_gains;
+	int *all_gains __free(kfree) =3D NULL;
 	size_t gain_bytes;
=20
 	for (i =3D 0; i < gts->num_itime; i++) {
@@ -232,10 +233,9 @@ static int gain_to_scaletables(struct iio_gts *gts, in=
t **gains, int **scales)
=20
 	gts->avail_all_scales_table =3D kcalloc(new_idx, 2 * sizeof(int),
 					      GFP_KERNEL);
-	if (!gts->avail_all_scales_table) {
-		ret =3D -ENOMEM;
-		goto free_out;
-	}
+	if (!gts->avail_all_scales_table)
+		return -ENOMEM;
+
 	gts->num_avail_all_scales =3D new_idx;
=20
 	for (i =3D 0; i < gts->num_avail_all_scales; i++) {
@@ -246,14 +246,11 @@ static int gain_to_scaletables(struct iio_gts *gts, i=
nt **gains, int **scales)
 		if (ret) {
 			kfree(gts->avail_all_scales_table);
 			gts->num_avail_all_scales =3D 0;
-			goto free_out;
+			return ret;
 		}
 	}
=20
-free_out:
-	kfree(all_gains);
-
-	return ret;
+	return 0;
 }
=20
 /**
--=20
2.47.0


--i/ogBz58vmcQq9xY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc0i00ACgkQeFA3/03a
ocWnJAf+LbzjsR00g7zLP3BsqBjUWkl6a5JAPdyhr+rpitERIQ/LKxRHkdPzihUg
YtBvo7+MAu8FSNxbTlEsijKFwqogExl/+fCRniK5Tky7RwIP51P06ci3hLd+dgv7
1Eu36hlP9/S2jdZyPaY9PoqQpEltG5dNhL51GsKT79ENQUbw+mWj5yptunzLixQK
doh5DhNgJgS4Kv00MLRf8je3qZPGSYRNzzpE/tQuTkT6qI04NsXMp1Vlnokd9rFE
dLipLhs9EE0CDf4wdVjxog4TH2YIZ/xPE1FKQi4ZdMz92svMuW92EPK3FCpZFGw/
0hMxRYXKwibyJZAOsJarsNrqvLP5Ow==
=cCf4
-----END PGP SIGNATURE-----

--i/ogBz58vmcQq9xY--

