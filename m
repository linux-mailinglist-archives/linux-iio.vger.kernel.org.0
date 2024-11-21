Return-Path: <linux-iio+bounces-12445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326D9D48A8
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49435281B6A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD5D1BBBE8;
	Thu, 21 Nov 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMn8/S+T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9755512FB1B;
	Thu, 21 Nov 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177218; cv=none; b=OU5JGo5IDmzAAxcEa/X9ghhEFhJ2JcIfBMZhsH5BafJck84V77c0ifUWixsHJHkLYyqi/K0T+Bx9gobzR5wG8nj9kBhUTyQxx9ZOE05nVJJKw0vDoLgEq/31Cw3tdRaldreW/A3/Ap5xcfT9R/RH3E8UKTlGPYxLKTLgoBiC1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177218; c=relaxed/simple;
	bh=7Rt42u/XCjYpglpy1boRCDwPVpqgQFmGqiV2rb0uP6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho/ucXURCugH8FdgPLzl/7/rek6G5/BXAmjj5XTiYnHng5o0VG5RaOswcXeXGYwD0vKxMtu7unPXGDGniEHBT1U657eDVEurS/y++5Q8tjghmpGDkys6jtUyWpoiWy7dIki1dYIkIlEs8Lr4LrdtgcQzOuVmxLd5fgUlEHAMpaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMn8/S+T; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb561f273eso6545201fa.2;
        Thu, 21 Nov 2024 00:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732177215; x=1732782015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmhBGQ/m+qVWheJtFzpyd5mx+oTRXoNs7skerrQrF0g=;
        b=hMn8/S+TZQm9Eg9CYjyQ3yEAZHMoc0td6eVgn09fueJljMj2+tolJ9ZtiNbJihw4Hb
         nOPGdIc7DauUD/m+2orxSTLSrgrLAyqfSdB3soggJuvV+yG0sHZT/7UYXtuAEaKPmsIW
         xOhg10T4kRXq2AH4x4n3CmxohO+q/ZYxLVcE0U1KdrbSKTq2XRV9jwky8Y5XVlv6RvHJ
         LjhGVB5JnDRNXm0bN16EbJs8UESl0H1JF6+CDX+z2MaPtihnovA0AZWpqbKbT3ViT4Iy
         GEcWS0qv/eMJU/k7WPXK9owK1K7skHZOeUsAwBEifiiEBW1XhYmVFDt0iHc9/Nnmse51
         6YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177215; x=1732782015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmhBGQ/m+qVWheJtFzpyd5mx+oTRXoNs7skerrQrF0g=;
        b=XBlTqhhiDwWO3aL0exiXNy96yI1dqH+0LUIP5q/NTGV6RxjVRn9KSjNHJGI1a8kQ73
         G8gBU9rpCB4+tTGHG4Rf4Ir/82jThEzcUnS71Le/vgKa0lcpMrhn0VPXWcOnV1u9HIjl
         SIN1ISqyPZUZ+ghGg7i4X7VqzdlYPhtbfynou0DjY5u+GgBvOxGKTZBFbWjAMovQkXeQ
         So/vaExsHAHfdqd6NpFPCwLuOW9KbE0N421A33/nRJkFgswJpvwiWFbQmnXaXLHNB59o
         EBDr1UYBADgW/abZBBIXwtzW80GycWyHbHdbPbRbchjT3hezh8BZOMEWTg2eqiqWRWVo
         65SA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ecrkie4ucaVUc10F8urh2BpsPEpkOnZr/KFapFSeTvwrwJ1AA6pQALpMzL73BBN9qRQRCwvUAQXd@vger.kernel.org, AJvYcCX+3Ox2RN9FYoeBSAzVvnEWpE5DlTzrEVFRwAMwCAyJXHbcCFtoiIOUZWsn+ju9HPBuPH+lzsfr1nC99g8+@vger.kernel.org, AJvYcCXfbhv6SXWMFgoxrf6mnWaTP47KOagOr9VXqMJxd8zhunAsS3Vv6XgBnijq4lJ1dOt6uMcpyC9UCtW9@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKZG3TrWokWTJoZEoASafB+25nSgtaRkO8hzPuHTq9PTWoltA
	tGwpvf9TaBmtP4Pbuywgvcz6640vLZnHO7/7y0bGmSTKjmhe8NxMUbgiDdEu
X-Google-Smtp-Source: AGHT+IEXAKD/iUvWWuPhg6BgTI8jpoaIDpC5HIqcCZiH/v34w/m3LLezWKo9yLndSf2xo7t5UfgRfA==
X-Received: by 2002:a05:651c:e04:b0:2fb:5723:c9ea with SMTP id 38308e7fff4ca-2ff8dcc9c31mr21887501fa.30.1732177214588;
        Thu, 21 Nov 2024 00:20:14 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69967dedsm18104251fa.56.2024.11.21.00.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:20:12 -0800 (PST)
Date: Thu, 21 Nov 2024 10:20:07 +0200
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
Subject: [PATCH v2 2/8] iio: gts: Simplify using __free
Message-ID: <5efc30d832275778d1f48d7e2c75b1ecc63511d5.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G7KqgZMyx/6Ie9qJ"
Content-Disposition: inline
In-Reply-To: <cover.1732105157.git.mazziesaccount@gmail.com>


--G7KqgZMyx/6Ie9qJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The error path in the gain_to_scaletables() uses goto for unwinding an
allocation on failure. This can be slightly simplified by using the
automated free when exiting the scope.

Use __free(kfree) and drop the goto based error handling.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

Revision history:
  v1 =3D> v2:
  - patch number changed because a change was added to the series.
  - rebased on iio/testing to avoid conflicts with queued fixes
---
 drivers/iio/industrialio-gts-helper.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 291c0fc332c9..602d3d338e66 100644
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
@@ -167,8 +168,8 @@ static int iio_gts_gain_cmp(const void *a, const void *=
b)
=20
 static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **sca=
les)
 {
-	int i, j, new_idx, time_idx, ret =3D 0;
-	int *all_gains;
+	int ret, i, j, new_idx, time_idx;
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


--G7KqgZMyx/6Ie9qJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc+7TcACgkQeFA3/03a
ocXx6wgAgYPmFY4jKwes3jusxJXsPXjKt41x+W4CeD4c6rMqWmF19IY9fczoEuO5
rXbT+pC2A0NsX8TmF3/VNbZSOr73F51tCsBZ0ETOSJeE/M5b235wVJuRfRLzi1wr
a85MvVbCQMVGgr+fyTJTzhD06mmL/xg3yxj1r7YnXc3vFPVqKL5LweVt8W65zsIi
73Rmtpuciwa1vhuIVbnbOVEWb6opTZ6NJwdHD00oeaBr1Uaou20ZbL2cZFbvfMDD
4/P5h2C8ET29Vn+p6GTGHm0zwvT1b/h2Y6MOgaNmy95kHGT4Z1KlQ9UBrWgjnCoU
xdAh7MhC0/psvsilLbsJ1Fqsgdraew==
=1sAH
-----END PGP SIGNATURE-----

--G7KqgZMyx/6Ie9qJ--

