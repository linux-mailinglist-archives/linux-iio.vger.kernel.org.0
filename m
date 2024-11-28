Return-Path: <linux-iio+bounces-12783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593CF9DBB8B
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5342B23457
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6161C07C6;
	Thu, 28 Nov 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9KKmNiV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150019923C;
	Thu, 28 Nov 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812655; cv=none; b=jHG6TYvzXD+5yPnOp0HZ8g0QOY0Fulk8XRYWpReYWMLf/Ip+SP5OunKAXkzk0IKu5ER+2SiZq9uT2EXrwpc1VFm7x224Gz/sd42/Se1p4EG2TRw61nmEOc7GeRDLYQWEUDxu6UGsQWZgc3XGNOHuYb9cOkvvpJNyCA7iebl0Rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812655; c=relaxed/simple;
	bh=jVAKUz6MEw83QiOzWclac1mRqxhA/+eXfFUwUwzTwFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sul8BWdUc8vsmFOuqlmdTHEqwkHQLJQ+mdH14AbcwsFqTI9NyN9q0zvaAHWU9O1OrIidRt4HcgnYSZkW8Rd8ObytcXQY6YPCspVqSEhNyADlGoLdt0oZfjDsUKj+s2KbRl+sIpDLVazpTpUbbJ8hH8rlkNa778BmKh/si1MBe6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9KKmNiV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffbea0acc2so11627171fa.1;
        Thu, 28 Nov 2024 08:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732812652; x=1733417452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLTYx/5BrDI+gA+YBI5Z0MbzuciNuAtO+o+043dPYSA=;
        b=f9KKmNiVkMJUGGJmli4sPrvEQKu3INYaG9Dmu9g6mGLyKPFyPuu2QWbdvharVxwmce
         zx1+N4d+JcaWBY29N5E9AGZ8IcaeykW2HMVrmfhrlFtyasBaUXj4rW98T1TqToIX07aN
         vWhvPaTm4pihKBlheLIzGwZVsIoPJHppBiv9evG0l3AVUISuQG3bQJUG6AgZNO+sTUdz
         6Qu5Oa3tgvoeGPlvl9BkOqThTSO6rx2tx2w7O61Bw0sXnSv8UppBbHR81eTUaZvW0sSD
         YEtJh0AVQjrREv0CcBnrJf44sZfIiUKAh655AOri6tmxhbwXbZAhhb13wT8z4Ab2Pr6P
         FAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732812652; x=1733417452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLTYx/5BrDI+gA+YBI5Z0MbzuciNuAtO+o+043dPYSA=;
        b=uszOwMGRveUIuuIKh1ZqyhlNeq+5g/6vdOY2obwaSGPMAq0lFCsd76KgrAzQxqKMFe
         mpViV3rHOJpM4mvDfUnaDyKdsB7/3CrZD3B2uQ4tumZOoPKaUVFE9TaMnMvtcyZQI69s
         iW+YKJsjgfygjCkJH3G3qLOIfjvhGWxFshrSKrJuvtbqASqzZW6twcwE+ENmUzcsn7ni
         OZJ2cNcjeDF27MuzdEcmEOlS/FD7nj/BTaFUNgSdg9t8gOz9RvRDTEvgD69twPJ72dCF
         mJvW8BzMHCqydhe2zUXKTKj9KqzqGyVl8CY24xdu5mWYfPDpx/dMCHFUrHwkX/zGbr8y
         Zb3A==
X-Forwarded-Encrypted: i=1; AJvYcCU/xn3QiSSO5SeU8yYBjqs90GyJbd1t6+I+QZqbAgfLxCNhsaIZpQFE3zSGRBaYDlAcXNKUeDfwBEg=@vger.kernel.org, AJvYcCXHbf5cJ0msSBOYYFK2OGrNca+jIQybzo3uGI+RtqHc2WIevI2xYpyXrPOPyrR/ZQYn0H2SaSJt8TPok3XF@vger.kernel.org
X-Gm-Message-State: AOJu0YxdLipzy5AawusGLXVNCn56sHeQ7Fd+lXsmgxbxlyiD5bRefoMF
	28rJ0Y2QrtpPKLR14J5E4SkqZtWvt7OuG6GegWfa7knu/1YfdFkmsjC06w==
X-Gm-Gg: ASbGnct6uvrb1hvYNyNgq+/p68LWbsQdlT39GRIC8TivNNUq76+g4PbzFtBWzmwSHlt
	9Aqv0P4GNBhyjw6JEgOhYdcggzDbnt+qus/PRatcWnSpw0UQySC3ss1uHYR2kHYV3NSeyl9G5vz
	LYhiIB8WJ4y3OMNxtl+M6hLUlDre1ERnz7eorgh7E4a6UwVAsNwYdjLp49y//iXdE8i1DAJUcYV
	pyMwXdG0NHz3h0NdTsXdult3KuBb3xwkgaoc2wvhupHW4cfzJtRJ/DL
X-Google-Smtp-Source: AGHT+IEPpSpgm9OntrkxTix1kkPmk1INj6kIXBsZT5Lx3X4ybxdCrzQvdc/n1j7QM9iph6MZO1QHsw==
X-Received: by 2002:a2e:b8c7:0:b0:2ff:8d3b:46d3 with SMTP id 38308e7fff4ca-2ffd6096835mr40391371fa.16.1732812652243;
        Thu, 28 Nov 2024 08:50:52 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfccda9dsm2277301fa.123.2024.11.28.08.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:50:50 -0800 (PST)
Date: Thu, 28 Nov 2024 18:50:44 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: gts: split table-building function
Message-ID: <678a3859bd9feeedc10eda04b801f37fa0444d25.1732811829.git.mazziesaccount@gmail.com>
References: <cover.1732811829.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zZzcVk8244zs3C02"
Content-Disposition: inline
In-Reply-To: <cover.1732811829.git.mazziesaccount@gmail.com>


--zZzcVk8244zs3C02
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function which builds the available scales tables for the GTS
helpers is hard to follow. Split it up so it is more obvious for
occasional reader to see what is done and why.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/industrialio-gts-helper.c | 66 +++++++++++++++++----------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index e15d0112e9e3..7f900f578f1d 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -191,14 +191,10 @@ static int fill_and_sort_scaletables(struct iio_gts *=
gts, int **gains, int **sca
 	return 0;
 }
=20
-static int build_combined_table(struct iio_gts *gts, int **gains, size_t g=
ain_bytes)
+static int combine_gain_tables(struct iio_gts *gts, int **gains,
+			       int *all_gains, size_t gain_bytes)
 {
-	int ret, i, j, new_idx, time_idx;
-	int *all_gains __free(kfree) =3D kcalloc(gts->num_itime, gain_bytes,
-					       GFP_KERNEL);
-
-	if (!all_gains)
-		return -ENOMEM;
+	int i, new_idx, time_idx;
=20
 	/*
 	 * We assume all the gains for same integration time were unique.
@@ -212,8 +208,8 @@ static int build_combined_table(struct iio_gts *gts, in=
t **gains, size_t gain_by
 	new_idx =3D gts->num_hwgain;
=20
 	while (time_idx-- > 0) {
-		for (j =3D 0; j < gts->num_hwgain; j++) {
-			int candidate =3D gains[time_idx][j];
+		for (i =3D 0; i < gts->num_hwgain; i++) {
+			int candidate =3D gains[time_idx][i];
 			int chk;
=20
 			if (candidate > all_gains[new_idx - 1]) {
@@ -236,25 +232,47 @@ static int build_combined_table(struct iio_gts *gts, =
int **gains, size_t gain_by
 		}
 	}
=20
-	gts->avail_all_scales_table =3D kcalloc(new_idx, 2 * sizeof(int),
-					      GFP_KERNEL);
-	if (!gts->avail_all_scales_table)
-		return -ENOMEM;
+	return new_idx;
+}
=20
-	gts->num_avail_all_scales =3D new_idx;
+static int *build_all_scales_table(struct iio_gts *gts, int *all_gains, in=
t num_scales)
+{
+	int i, ret;
+	int *all_scales __free(kfree) =3D kcalloc(num_scales, 2 * sizeof(int),
+						GFP_KERNEL);
=20
-	for (i =3D 0; i < gts->num_avail_all_scales; i++) {
-		ret =3D iio_gts_total_gain_to_scale(gts, all_gains[i],
-					&gts->avail_all_scales_table[i * 2],
-					&gts->avail_all_scales_table[i * 2 + 1]);
+	if (!all_scales)
+		return ERR_PTR(-ENOMEM);
=20
-		if (ret) {
-			kfree(gts->avail_all_scales_table);
-			gts->num_avail_all_scales =3D 0;
-			return ret;
-		}
+	for (i =3D 0; i < num_scales; i++) {
+		ret =3D iio_gts_total_gain_to_scale(gts, all_gains[i], &all_scales[i * 2=
],
+						  &all_scales[i * 2 + 1]);
+		if (ret)
+			return ERR_PTR(ret);
 	}
=20
+	return_ptr(all_scales);
+}
+
+static int build_combined_tables(struct iio_gts *gts,
+				 int **gains, size_t gain_bytes)
+{
+	int *all_scales, num_gains;
+	int *all_gains __free(kfree) =3D kcalloc(gts->num_itime, gain_bytes,
+					       GFP_KERNEL);
+
+	if (!all_gains)
+		return -ENOMEM;
+
+	num_gains =3D combine_gain_tables(gts, gains, all_gains, gain_bytes);
+
+	all_scales =3D build_all_scales_table(gts, all_gains, num_gains);
+	if (IS_ERR(all_scales))
+		return PTR_ERR(all_scales);
+
+	gts->num_avail_all_scales =3D num_gains;
+	gts->avail_all_scales_table =3D all_scales;
+
 	return 0;
 }
=20
@@ -269,7 +287,7 @@ static int gain_to_scaletables(struct iio_gts *gts, int=
 **gains, int **scales)
=20
 	gain_bytes =3D array_size(gts->num_hwgain, sizeof(int));
=20
-	return build_combined_table(gts, gains, gain_bytes);
+	return build_combined_tables(gts, gains, gain_bytes);
 }
=20
 /**
--=20
2.47.0


--zZzcVk8244zs3C02
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIn2QACgkQeFA3/03a
ocWN8AgAp7ZRYiwrGEhh12BjRAs3F7psLZOs0Q5ObyeOHV0f7yYBW0n2NZciDaw5
ED2LvGJ8VL9pD3PhjWWI7uTjqYP5aiJsu8gLrXTtdq8FsvRXc3gK1dNtzBHnTxTa
ZwEGo0TTC2pW61z88LnVrI8JHuXhb058HlsK6CDIm7Yndz+DPWxli4/odemjc9sp
id12rFjjbv9GyvCYtuEG+4LbSeiuThZy9UFyk0q4cQ4Rv0ER24+bbCGcuEo4F84b
WQV9JW+0Q3Pcvj1QfaFDCwbYPSPM99+xFNIdYK287ZIWOKvYyznopMd8KOoquhpu
lvErKw431yXxHvcIKG5iFxzqx6hJLQ==
=tsRn
-----END PGP SIGNATURE-----

--zZzcVk8244zs3C02--

