Return-Path: <linux-iio+bounces-12784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CCD9DBB8D
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 17:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1EE28297F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1AC1BD9F2;
	Thu, 28 Nov 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmMRt/8c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216391B85FA;
	Thu, 28 Nov 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812671; cv=none; b=qywKts/qVTsdSdlQPQ+ged2msCC4rUat+E+1FHV9GlOSCYczbno0AnSsk1EwTpuiVw1NJD3B1U3MN8ksVBlc9bMxxid2BeZ5a8XZEO6PDWfJm1QnGgQXzKPnNr8YTA8jAIKiKjhXC1uz2FIrlzQZuQ+pOb+DsMwDNl2FmBOHtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812671; c=relaxed/simple;
	bh=HRu6qMThfqN+xQWI++pVUu9DTreaS3FHP8Mm5pJtibY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpMnwAjQEWn0x3lwaKbnREnX2jB3dVeRkMGACx89/rUqOdJXvTsS5Vm0MtS7IZEGVKdK2/eliPkarJpV3Z+hE4DmfO9uRKQI2w7E1ikl4NsOPuGrWqk+bsFViPGpKPbu/pGeyEVn1SVdXZA1pTRUtu5Vpg+cULGz5V9UCmJCPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmMRt/8c; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffced84ba8so10618011fa.2;
        Thu, 28 Nov 2024 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732812667; x=1733417467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ndFM14y62Wb33fCpKZ8TUwn/mnlk0DqbbpdktEjptc=;
        b=RmMRt/8cAW3XWWNJRgPyqusIFrC8FEW06xmCSDs+exie//CDqt7aK47+OVjeG1byR+
         RJ3pyvm07zrpm8s/Wb9lqvHvbAd27KeFp5YTT1UjYMinHrhwYk0grwgMmc0bUqwImYtr
         jKbsAxiPBO4Pxy5I7lnO2Q9CFbDzs44rQ4Ritv2okul5A/ql2H+W53lTbbA9Dz+6/yNH
         hU3Vw3wbyTGwrC0/pUR3I2M227NPMJXLe76F4GQODzlFLthPq//Ip6Hv7dqkFviFZS7z
         Kx8IAm0zdXYEs3s/kIoFax8CDlQS9HT509Hlg6U/yMaivBmqnf3PrPqx4FvF9QfDKxsX
         Ubew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732812667; x=1733417467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ndFM14y62Wb33fCpKZ8TUwn/mnlk0DqbbpdktEjptc=;
        b=C2NZWpiDL3/kgHJ0jqAn70mGjOCYbZAEf+75H88A77dwGd8/1Zt2f+6iRhVtpumAZT
         /W9GxTUKaX2pPHFyNlLVMAelvrgK+32ghNbg1a7I261a1zA4fLXP3WI2Zxv0ZfFSr/G0
         YarnmrYwaneQaX9YhqBDgyS7vy5rknnDgF+z/YFSFSLZ+mvQiE32+vdb+2UPi8t3zpC/
         jPtDN38lWO7AsdJLBo1rOLh6vtOb5wk1LDxJoA70MN4w4swdTmfAftWWTqGhiXg63S65
         NbDUQh8TCKoWrRNKaqtF0mxpBP2Rzzs26IGGDNieRc+ROLqZE49D4TWY985gnoMDHG1g
         SWqg==
X-Forwarded-Encrypted: i=1; AJvYcCW5XWc7+FPiWCXuHRemxl29B0uvXTrgh0kf0eeZnj2kHslqTafJ/XimdZ78u+tx4kD6aRS++Sq4OrA=@vger.kernel.org, AJvYcCWnMtBNw7maJp2yP/fIfLjqhqVZjFr8qtOqS4TEPp5VtIdizDAtf30V5nPle2fuMMEj1tpyYu/ocvyIPwyw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9W3ndv5n/pxHKFuaOzrRWOFokjZIHoIjnvtCWlZdKWRjuICk1
	wfsDY1Fa1Qb8ZMe6xE+B89cJdHH/VEQp8jEEKgZ0X8AqgmNTEkc0
X-Gm-Gg: ASbGncscGHoNyb7sBZTgAVf+9P71+zsR/yHBCj59aX1EVmpfjMyTU2AUTGUdzfw7WtI
	+KEQeEdrBdnq/my5mh9cl8iNjSOX7/l5Kt5n7vjQxrMF1hMxXRtvlaM6Sl/DmHrqpLwdVzZuHIG
	ef/++/MRpemxwhrH69AF/5+CQWfMY6+VvmmC5nGcM3u4mbTqZmsyT2ux6yW6EG2BwJcy3p8STaw
	cVYxBAqTvVaRVcnXTgKV6OBSqF6nfLeIBk+yP5Hwnr4A2/HXEzp4Nya
X-Google-Smtp-Source: AGHT+IHzTYzz902yDmwlDMHKjfLhepUqjiHHItwAowmu45zVAvKGfeRxa1/PtTpp9SscJz+lBJxJxg==
X-Received: by 2002:a2e:bd06:0:b0:2ff:ca1a:14f5 with SMTP id 38308e7fff4ca-2ffd6020153mr48784121fa.17.1732812666993;
        Thu, 28 Nov 2024 08:51:06 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfca1249sm2321851fa.108.2024.11.28.08.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:51:04 -0800 (PST)
Date: Thu, 28 Nov 2024 18:51:00 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: gts: simplify scale table build
Message-ID: <4b05448b65969f9f433f7ac3aa234c33025ad262.1732811829.git.mazziesaccount@gmail.com>
References: <cover.1732811829.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fq3DbwCLiTHcF6lR"
Content-Disposition: inline
In-Reply-To: <cover.1732811829.git.mazziesaccount@gmail.com>


--Fq3DbwCLiTHcF6lR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The GTS helpers offer two different set of "available scales" -tables.
Drivers can choose to advertice the scales which are available on a
currently selected integration time (by just changing the hwgain).
Another option is to list all scales which can be supported using any of
the integration times. This is useful for drivers which allow scale
setting to also change the integration time to meet the scale user
prefers.

The helper function which build these tables for the GTS did firstbuild
the "time specific" scale arrays for all the times. This is done by
calculating the scales based on the integration time specific "total
gain" arrays (gain contributed by both the integration time and hw-gain).

After this the helper code calculates an array for all available scales.
This is done combining all the time specific total-gains into one sorted
array, removing dublicate gains and finally converting the gains to
scales as above.

This can be somewhat simplified by changing the logic for calculating
the 'all available scales' -array to directly use the time specific
scale arrays instead of time specific total-gain arrays. Code can
directly just add all the already computed time specific scales to one
big 'all scales'-array, keep it sorted and remove duplicates.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

This has been tested by IIO-gts kunit tests only. All testing is
appreciated.

Comparing the scales is not as pretty as comparing the gains was, as
scales are in two ints where the gains were in one. This makes the code
slightly more hairy. I however believe that the logic is now more
obvious. This might be more important for one reading this later...
---
 drivers/iio/industrialio-gts-helper.c | 109 ++++++++++----------------
 1 file changed, 42 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 7f900f578f1d..31101848b194 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -191,86 +191,61 @@ static int fill_and_sort_scaletables(struct iio_gts *=
gts, int **gains, int **sca
 	return 0;
 }
=20
-static int combine_gain_tables(struct iio_gts *gts, int **gains,
-			       int *all_gains, size_t gain_bytes)
+static int scale_eq(int *sc1, int *sc2)
 {
-	int i, new_idx, time_idx;
+	return *sc1 =3D=3D *sc2 && *(sc1 + 1) =3D=3D *(sc2 + 1);
+}
=20
-	/*
-	 * We assume all the gains for same integration time were unique.
-	 * It is likely the first time table had greatest time multiplier as
-	 * the times are in the order of preference and greater times are
-	 * usually preferred. Hence we start from the last table which is likely
-	 * to have the smallest total gains.
-	 */
-	time_idx =3D gts->num_itime - 1;
-	memcpy(all_gains, gains[time_idx], gain_bytes);
-	new_idx =3D gts->num_hwgain;
+static int scale_smaller(int *sc1, int *sc2)
+{
+	if (*sc1 !=3D *sc2)
+		return *sc1 < *sc2;
+
+	/* If integer parts are equal, fixp parts */
+	return *(sc1 + 1) < *(sc2 + 1);
+}
+
+static int do_combined_scaletable(struct iio_gts *gts, int **scales, size_=
t scale_bytes)
+{
+	int t_idx, i, new_idx;
+	int *all_scales =3D kcalloc(gts->num_itime, scale_bytes, GFP_KERNEL);
=20
-	while (time_idx-- > 0) {
-		for (i =3D 0; i < gts->num_hwgain; i++) {
-			int candidate =3D gains[time_idx][i];
+	if (!all_scales)
+		return -ENOMEM;
+
+	t_idx =3D gts->num_itime - 1;
+	memcpy(all_scales, scales[t_idx], scale_bytes);
+	new_idx =3D gts->num_hwgain * 2;
+
+	while (t_idx-- > 0) {
+		for (i =3D 0; i < gts->num_hwgain ; i++) {
+			int *candidate =3D &scales[t_idx][i * 2];
 			int chk;
=20
-			if (candidate > all_gains[new_idx - 1]) {
-				all_gains[new_idx] =3D candidate;
-				new_idx++;
+			if (scale_smaller(candidate, &all_scales[new_idx - 2])) {
+				all_scales[new_idx] =3D *candidate;
+				all_scales[new_idx + 1] =3D *(candidate + 1);
+				new_idx +=3D 2;
=20
 				continue;
 			}
-			for (chk =3D 0; chk < new_idx; chk++)
-				if (candidate <=3D all_gains[chk])
+			for (chk =3D 0; chk < new_idx; chk +=3D 2)
+				if (!scale_smaller(candidate, &all_scales[chk]))
 					break;
=20
-			if (candidate =3D=3D all_gains[chk])
+
+			if (scale_eq(candidate, &all_scales[chk]))
 				continue;
=20
-			memmove(&all_gains[chk + 1], &all_gains[chk],
+			memmove(&all_scales[chk + 2], &all_scales[chk],
 				(new_idx - chk) * sizeof(int));
-			all_gains[chk] =3D candidate;
-			new_idx++;
+			all_scales[chk] =3D *candidate;
+			all_scales[chk + 1] =3D *(candidate + 1);
+			new_idx +=3D 2;
 		}
 	}
=20
-	return new_idx;
-}
-
-static int *build_all_scales_table(struct iio_gts *gts, int *all_gains, in=
t num_scales)
-{
-	int i, ret;
-	int *all_scales __free(kfree) =3D kcalloc(num_scales, 2 * sizeof(int),
-						GFP_KERNEL);
-
-	if (!all_scales)
-		return ERR_PTR(-ENOMEM);
-
-	for (i =3D 0; i < num_scales; i++) {
-		ret =3D iio_gts_total_gain_to_scale(gts, all_gains[i], &all_scales[i * 2=
],
-						  &all_scales[i * 2 + 1]);
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
-	return_ptr(all_scales);
-}
-
-static int build_combined_tables(struct iio_gts *gts,
-				 int **gains, size_t gain_bytes)
-{
-	int *all_scales, num_gains;
-	int *all_gains __free(kfree) =3D kcalloc(gts->num_itime, gain_bytes,
-					       GFP_KERNEL);
-
-	if (!all_gains)
-		return -ENOMEM;
-
-	num_gains =3D combine_gain_tables(gts, gains, all_gains, gain_bytes);
-
-	all_scales =3D build_all_scales_table(gts, all_gains, num_gains);
-	if (IS_ERR(all_scales))
-		return PTR_ERR(all_scales);
-
-	gts->num_avail_all_scales =3D num_gains;
+	gts->num_avail_all_scales =3D new_idx / 2;
 	gts->avail_all_scales_table =3D all_scales;
=20
 	return 0;
@@ -279,15 +254,15 @@ static int build_combined_tables(struct iio_gts *gts,
 static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **sca=
les)
 {
 	int ret;
-	size_t gain_bytes;
+	size_t scale_bytes;
=20
 	ret =3D fill_and_sort_scaletables(gts, gains, scales);
 	if (ret)
 		return ret;
=20
-	gain_bytes =3D array_size(gts->num_hwgain, sizeof(int));
+	scale_bytes =3D array_size(gts->num_hwgain, 2 * sizeof(int));
=20
-	return build_combined_tables(gts, gains, gain_bytes);
+	return do_combined_scaletable(gts, scales, scale_bytes);
 }
=20
 /**
--=20
2.47.0


--Fq3DbwCLiTHcF6lR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIn3QACgkQeFA3/03a
ocX3Bwf/ZapavfrlbVBHVTdp0GcpZ/wG67cmQkFv5Um6qgddL+hnvHRSd+3rBxKW
0Y/bcOmFHgfoD3XEOvMMVXEe6yW84blqwQdUhaCNiwm/GoN9UI8ct9TNJIcqCWLq
KXZfJAkDnbyQiSAy1fg+iBJ+X+RzcR/CPR6VTieAwTRtWfhxWbvyRq4+zuvRFZHZ
08g1mlCUxujD/u79wxsmaNP2QG9ZIqyS1Cbhs82gHb9erVntwxa+qMce+IXSZT3P
Xr6e9andY8gSaTc2VZ0IgKUahKOWTt5xJ4DSjv7QlQ0M5zUtVnajka5EQ2tMolnz
zIkOC63kx20/ztI6eXxqcQLdvTNGzA==
=5GMT
-----END PGP SIGNATURE-----

--Fq3DbwCLiTHcF6lR--

