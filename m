Return-Path: <linux-iio+bounces-13271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF29E8CBC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 08:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBA4281C4C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DF0215072;
	Mon,  9 Dec 2024 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RITjiLXJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52E21506D;
	Mon,  9 Dec 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731133; cv=none; b=Y0m5vDOsfkJ8qwKuk4cWOXrnDMCtcNI00Ggy1oXub+/4UW+eAE95RlrCNFvkX5mQAyuIaE6Bh+V7SEZyDTnr3dQyqbvDK81yWyyHM5BeEGTJW1zImW69UXkPihtsF+ejFa/eilq4DyxgIg0PbuLjRjVDeOXke6Eexhdc++XJwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731133; c=relaxed/simple;
	bh=Os5dAcd3Zrt+fqku1kSGs/tQuhvf2EFVfB1PWyATEa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e1+WxmrjNDy9ncpct0I7ad2dlLaXZDoS60v+ko54107eQnrkhLYOepS0495aanIm+IljZLwb2HMD4LP+akZhsXbhhilo8kCoMFkAQjcxM45oSZaCvtIGtafAjNzDLj/FZO6teqD1wQhiqGCrM9wXy4TPdHBH50TmeYxkPWSJ8PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RITjiLXJ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e21990bcbso4083965e87.0;
        Sun, 08 Dec 2024 23:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733731130; x=1734335930; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTTN9XB+lkC9OcQRKqP0MOZQL7W2W4sTEAkLUkmeWDo=;
        b=RITjiLXJO7hUbtHV1xRLIlNuS6tkWSPBWooOm4pFGjLd3QrCPNJXNM3atF7pgXCuQb
         jmESjAyySjumIjmW7cLd0JT07yWspNX/BAVRiV4I2U21HWGjtn6zXtFrXIZcDEPV9cuo
         e9SCQQnwlTiNL5cGwf84w06RRZiosiV3MofQqIuPcTLSj85mOvukCLHhkK834Nv+J98q
         X10Eg4C+P4DrGfuHr8SEvTa9zSG4YRSgYojtW/H/S+xt5t7RZJTgVlc2mnwW5J5jcsC8
         nrLBCEh8W2Uuov3kNq9vFMdu6etG06UiLjbMqthmy75WKNbsK1jYbyQa3c9uwHBPz5n9
         MYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731130; x=1734335930;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTTN9XB+lkC9OcQRKqP0MOZQL7W2W4sTEAkLUkmeWDo=;
        b=oo2u/a0ZEfKHFX9xiInKOX9aP1J8XQhB50Tugaaz49gjmn4/tO4ptjveVqA/gT/Z4J
         HXsvKlAfIr3E7ZeDFXaK1or6JfVeHdiCA8pjq5RSgbM4iWKKcdhfAJiGmirOyxy066Ex
         UHnw+UW2duIduXAyPSHFhPut1FCJNlta+DrQSeGfyDy3B6IX/I4TBXEF3z5+3CTxKrjo
         b4tsDPh591F37tmii6qyiQ5viwVZKV29JuWPBH2aXQeEIGw0d180Vla+ftaL4+YGbpnQ
         oI/ZLc5SfS4RFdLr6P47TmArkEljvEE/u4ZBQNYn0NU3tzAjyi/qvIHkJ/wO6t6I9eJH
         rvjg==
X-Forwarded-Encrypted: i=1; AJvYcCU7U9XdwgbZrIvL0l+oKJJyIUwx615ziwa+6r+cOhWK9f1y7HY/Gcu/862CcYVXYDmqsX+BUf7NPUqs0j7j@vger.kernel.org, AJvYcCVXr4ZwwTqjQVJFfJ1D5SdTpLVh6UEvbnKfJwe3TufqKrPW7ZwJIGYXPInpM9zLAIQQcO3IbO/WB80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUz7q+b4i1o1ZO5MWUJb3xL/glAVUt9uXJW4smgxGD68ZSJQ3g
	YyQLuaesbhSluCY8ELF84eSts5o6Rp8Gx3LcuhLaZPpT4/dEK26Kt7rvcg==
X-Gm-Gg: ASbGncvTJNSgxVA8b6scn6eMctycxh0dPAAggsZUG5YyzVjSOrt9Aeu6sHl9Aun+NvV
	SAtlvA5/h3SuK3LsuLRY933+HTVG3E/6LS0btJXIRJQ8yFwl/MM0kLAUh7xlEFIiFzmpNxLfGdd
	KKf7SJNPa+W71KF/bRszymFJqLFDDVJ+YUewLN2Ek1aj687L/P6lRHeA+SUYWig9LlQ+U8cLEWg
	9ZB5saZPWzpKEC/1aDF04aJYSs8iQtH/tiEbFZftL92RTwCOTL1C5QP
X-Google-Smtp-Source: AGHT+IEg4jECNjWlFnf/oy5L/AoowQGFGFZ2JNnhKAf37333VKmG+ohdMKy0nFjASYCqEaCE2RcWjQ==
X-Received: by 2002:a05:6512:131d:b0:53e:23ec:b2e7 with SMTP id 2adb3069b0e04-53e2c2c4b9dmr3807616e87.34.1733731129420;
        Sun, 08 Dec 2024 23:58:49 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39bd3f20sm790524e87.229.2024.12.08.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:58:47 -0800 (PST)
Date: Mon, 9 Dec 2024 09:58:41 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iio: gts: Simplify available scale table build
Message-ID: <Z1ajMXzvlgU0Smdf@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G1RNIunrlcThCopX"
Content-Disposition: inline


--G1RNIunrlcThCopX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Make available scale building more clear. This hurts the performance
quite a bit by looping throgh the scales many times instead of doing
everything in one loop. It however simplifies logic by:
 - decoupling the gain and scale allocations & computations
 - keeping the temporary 'per_time_gains' table inside the
   per_time_scales computation function.
 - separating building the 'all scales' table in own function and doing
   it based on the already computed per-time scales.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
In my (not always) humble (enough) opinion:
 - Building the available scales tables was confusing.
 - The result of this patch looks much clearer and is simpler to follow.
 - Handles memory allocations and freeing in somehow easyish to follow
   manner while still:
     - Avoids introducing mid-function variables
     - Avoids mixing and matching 'scoped' allocs with regular ones

I however send this as an RFC because it hurts the performance quite a
bit. (No measurements done, I doubt exact numbers matter. I'd just say
it more than doubles the time, prbably triples or quadruples). Well, it
is not really on a hot path though, tables are computed once at
start-up, and with a sane amount of gains/times this is likely not a
real problem.

This has been tested only by running the kunit tests for the gts-helpers
in a beaglebone black. Further testing and eyeing is appreciated :)
---
 drivers/iio/industrialio-gts-helper.c | 250 +++++++++++++++-----------
 1 file changed, 149 insertions(+), 101 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 291c0fc332c9..01206bc3e48e 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -160,16 +160,108 @@ static void iio_gts_purge_avail_scale_table(struct i=
io_gts *gts)
 	gts->num_avail_all_scales =3D 0;
 }
=20
+static int scale_eq(int *sc1, int *sc2)
+{
+	return sc1[0] =3D=3D sc2[0] && sc1[1] =3D=3D sc2[1];
+}
+
+static int scale_smaller(int *sc1, int *sc2)
+{
+	if (sc1[0] !=3D sc2[0])
+		return sc1[0] < sc2[0];
+
+	/* If integer parts are equal, fixp parts */
+	return sc1[1] < sc2[1];
+}
+
+static int do_combined_scaletable(struct iio_gts *gts, size_t scale_bytes)
+{
+	int t_idx, i, new_idx;
+	int **scales =3D gts->per_time_avail_scale_tables;
+	int *all_scales =3D kcalloc(gts->num_itime, scale_bytes, GFP_KERNEL);
+
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
+			int chk;
+
+			if (scale_smaller(candidate, &all_scales[new_idx - 2])) {
+				all_scales[new_idx] =3D candidate[0];
+				all_scales[new_idx + 1] =3D candidate[1];
+				new_idx +=3D 2;
+
+				continue;
+			}
+			for (chk =3D 0; chk < new_idx; chk +=3D 2)
+				if (!scale_smaller(candidate, &all_scales[chk]))
+					break;
+
+
+			if (scale_eq(candidate, &all_scales[chk]))
+				continue;
+
+			memmove(&all_scales[chk + 2], &all_scales[chk],
+				(new_idx - chk) * sizeof(int));
+			all_scales[chk] =3D candidate[0];
+			all_scales[chk + 1] =3D candidate[1];
+			new_idx +=3D 2;
+		}
+	}
+
+	gts->num_avail_all_scales =3D new_idx / 2;
+	gts->avail_all_scales_table =3D all_scales;
+
+	return 0;
+}
+
+static void iio_gts_free_int_table_array(int **arr, int num_tables)
+{
+	int i;
+
+	for (i =3D 0; i < num_tables; i++)
+		kfree(arr[i]);
+
+	kfree(arr);
+}
+
+static int iio_gts_alloc_int_table_array(int ***arr, int num_tables, int n=
um_table_items)
+{
+	int i, **tmp;
+
+	tmp =3D kcalloc(num_tables, sizeof(**arr), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	for (i =3D 0; i < num_tables; i++) {
+		tmp[i] =3D kcalloc(num_table_items, sizeof(int), GFP_KERNEL);
+		if (!tmp[i])
+			goto err_free;
+	}
+
+	*arr =3D tmp;
+
+	return 0;
+err_free:
+	iio_gts_free_int_table_array(tmp, i);
+
+	return -ENOMEM;
+}
+
 static int iio_gts_gain_cmp(const void *a, const void *b)
 {
 	return *(int *)a - *(int *)b;
 }
=20
-static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **sca=
les)
+static int fill_and_sort_scaletables(struct iio_gts *gts, int **gains, int=
 **scales)
 {
-	int i, j, new_idx, time_idx, ret =3D 0;
-	int *all_gains;
-	size_t gain_bytes;
+	int i, j, ret;
=20
 	for (i =3D 0; i < gts->num_itime; i++) {
 		/*
@@ -189,73 +281,59 @@ static int gain_to_scaletables(struct iio_gts *gts, i=
nt **gains, int **scales)
 		}
 	}
=20
-	gain_bytes =3D array_size(gts->num_hwgain, sizeof(int));
-	all_gains =3D kcalloc(gts->num_itime, gain_bytes, GFP_KERNEL);
-	if (!all_gains)
-		return -ENOMEM;
+	return 0;
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
+static void compute_per_time_gains(struct iio_gts *gts, int **gains)
+{
+	int i, j;
=20
-	while (time_idx-- > 0) {
-		for (j =3D 0; j < gts->num_hwgain; j++) {
-			int candidate =3D gains[time_idx][j];
-			int chk;
+	for (i =3D 0; i < gts->num_itime; i++) {
+		for (j =3D 0; j < gts->num_hwgain; j++)
+			gains[i][j] =3D gts->hwgain_table[j].gain *
+				      gts->itime_table[i].mul;
+	}
+}
=20
-			if (candidate > all_gains[new_idx - 1]) {
-				all_gains[new_idx] =3D candidate;
-				new_idx++;
+static int compute_per_time_tables(struct iio_gts *gts, int **scales)
+{
+	int **per_time_gains;
+	int ret;
=20
-				continue;
-			}
-			for (chk =3D 0; chk < new_idx; chk++)
-				if (candidate <=3D all_gains[chk])
-					break;
+	ret =3D iio_gts_alloc_int_table_array(&per_time_gains, gts->num_itime,
+					    gts->num_hwgain);
+	if (ret)
+		return ret;
=20
-			if (candidate =3D=3D all_gains[chk])
-				continue;
+	compute_per_time_gains(gts, per_time_gains);
=20
-			memmove(&all_gains[chk + 1], &all_gains[chk],
-				(new_idx - chk) * sizeof(int));
-			all_gains[chk] =3D candidate;
-			new_idx++;
-		}
-	}
+	ret =3D fill_and_sort_scaletables(gts, per_time_gains, scales);
=20
-	gts->avail_all_scales_table =3D kcalloc(new_idx, 2 * sizeof(int),
-					      GFP_KERNEL);
-	if (!gts->avail_all_scales_table) {
-		ret =3D -ENOMEM;
-		goto free_out;
-	}
-	gts->num_avail_all_scales =3D new_idx;
+	iio_gts_free_int_table_array(per_time_gains, gts->num_itime);
=20
-	for (i =3D 0; i < gts->num_avail_all_scales; i++) {
-		ret =3D iio_gts_total_gain_to_scale(gts, all_gains[i],
-					&gts->avail_all_scales_table[i * 2],
-					&gts->avail_all_scales_table[i * 2 + 1]);
+	return ret;
+}
=20
-		if (ret) {
-			kfree(gts->avail_all_scales_table);
-			gts->num_avail_all_scales =3D 0;
-			goto free_out;
-		}
-	}
+static int **create_per_time_scales(struct iio_gts *gts)
+{
+	int **per_time_scales, ret;
=20
-free_out:
-	kfree(all_gains);
+	ret =3D iio_gts_alloc_int_table_array(&per_time_scales, gts->num_itime,
+					    gts->num_hwgain * 2);
+	if (ret)
+		return ERR_PTR(ret);
=20
-	return ret;
-}
+	ret =3D compute_per_time_tables(gts, per_time_scales);
+	if (ret)
+		goto err_out;
+
+	return per_time_scales;
=20
+err_out:
+	iio_gts_free_int_table_array(per_time_scales, gts->num_itime);
+
+	return ERR_PTR(ret);
+}
 /**
  * iio_gts_build_avail_scale_table - create tables of available scales
  * @gts:	Gain time scale descriptor
@@ -275,55 +353,25 @@ static int gain_to_scaletables(struct iio_gts *gts, i=
nt **gains, int **scales)
  */
 static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
 {
-	int **per_time_gains, **per_time_scales, i, j, ret =3D -ENOMEM;
-
-	per_time_gains =3D kcalloc(gts->num_itime, sizeof(*per_time_gains), GFP_K=
ERNEL);
-	if (!per_time_gains)
-		return ret;
-
-	per_time_scales =3D kcalloc(gts->num_itime, sizeof(*per_time_scales), GFP=
_KERNEL);
-	if (!per_time_scales)
-		goto free_gains;
-
-	for (i =3D 0; i < gts->num_itime; i++) {
-		per_time_scales[i] =3D kcalloc(gts->num_hwgain, 2 * sizeof(int),
-					     GFP_KERNEL);
-		if (!per_time_scales[i])
-			goto err_free_out;
-
-		per_time_gains[i] =3D kcalloc(gts->num_hwgain, sizeof(int),
-					    GFP_KERNEL);
-		if (!per_time_gains[i]) {
-			kfree(per_time_scales[i]);
-			goto err_free_out;
-		}
+	int ret, scale_bytes;
+	int **per_time_scales;
=20
-		for (j =3D 0; j < gts->num_hwgain; j++)
-			per_time_gains[i][j] =3D gts->hwgain_table[j].gain *
-					       gts->itime_table[i].mul;
-	}
+	if (unlikely(check_mul_overflow(gts->num_hwgain, 2 * sizeof(int), &scale_=
bytes)))
+		return -EOVERFLOW;
=20
-	ret =3D gain_to_scaletables(gts, per_time_gains, per_time_scales);
-	if (ret)
-		goto err_free_out;
+	per_time_scales =3D create_per_time_scales(gts);
+	if (IS_ERR(per_time_scales))
+		return PTR_ERR(per_time_scales);
=20
-	for (i =3D 0; i < gts->num_itime; i++)
-		kfree(per_time_gains[i]);
-	kfree(per_time_gains);
 	gts->per_time_avail_scale_tables =3D per_time_scales;
=20
-	return 0;
-
-err_free_out:
-	for (i--; i >=3D 0; i--) {
-		kfree(per_time_scales[i]);
-		kfree(per_time_gains[i]);
+	ret =3D do_combined_scaletable(gts, scale_bytes);
+	if (ret) {
+		iio_gts_free_int_table_array(per_time_scales, gts->num_itime);
+		return ret;
 	}
-	kfree(per_time_scales);
-free_gains:
-	kfree(per_time_gains);
=20
-	return ret;
+	return 0;
 }
=20
 static void iio_gts_us_to_int_micro(int *time_us, int *int_micro_times,

base-commit: 05ff9c9c53c643551fe08fe52bd714310b9afc2e
--=20
2.47.0


--G1RNIunrlcThCopX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdWoywACgkQeFA3/03a
ocUVwQgAtayF6kMcStmaHXOjFYx7a8ZSx4eAt28EXCBfoNnYu+oeW2mXPZ90h9Bq
7ItF4vhrgtu82Z9Pwypni+6iIWn8TgFfon+Sl2SHyr1LgIpFwxGwjcXwvdkinJsv
8AQ0nW1UKVQzlx607RZceF3eD87AaHHCxnIXwhZk8lBFHHHO9d+y5eq2K6h5HZIl
6QAnF4xhnkJA1Ea9p4UNLzlJnlKkhO0mfy3jV+LEWTTRIcSLPXzvKDiWK65I3ub3
hWK0SUBjGL8GmFfxH3sCBAeBjf5UYJzgE12tsxnKFNqHdgOc34Rp8IEBpUaJmcia
R0DLH0ye0yXybsEvKXNttZGjZh9fnA==
=htE5
-----END PGP SIGNATURE-----

--G1RNIunrlcThCopX--

