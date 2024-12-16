Return-Path: <linux-iio+bounces-13537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149059F2C73
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 09:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BD8161924
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF23200BAA;
	Mon, 16 Dec 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0Ks55wd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F7200B8C;
	Mon, 16 Dec 2024 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339408; cv=none; b=hc5TW7PguVqiefJUUMWVkIiEjxWn2yvJgqxBUgZ73Zvk6nVTbdiLVr6vjf0rDQ+HyJSezjnJuhmIWCTiPX0RHDM2y7sUiq55ltJ8F2lEnY927+gJvFQEpjy5kCMDJyJvrOtCETB073omU8eFvu9Kwjv895m0ITEI/WQpqrBHDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339408; c=relaxed/simple;
	bh=tfbUP9gjJDGiJPTIqFiPdMEMEkKSRuNhcd5l9B9OJ/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M5r5A54WYvsVkdK+k/n7Iz5ko9B2sRi26+dZxi3r23yXKTzRr1WNq1b4fxDP2DL9DigwPMW/GB/FO8caW3+iv2+f+oN1FDvPwveFcSf8KgYuBXaIIqC6+SzwfiX5jzyMXrjBEw+XaUll9mLhe/0DARltb8J30QL5u8GKK7e214I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0Ks55wd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so32154881fa.1;
        Mon, 16 Dec 2024 00:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734339404; x=1734944204; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=626pWv5KSy+d5fJyUTQWTlBU9Lgvvvj33oOG+jYjkv0=;
        b=i0Ks55wdt8p0o7dCT7Z0MXpxZmMhc1ef5FbTht3p+vGedmTgOeucvQMNwieOrCm8W6
         CwQ3LHTh5QITNHopFkLqlSFYScGLchBYOY4TtZjrC/EIaP5bgCve3Hn2wNlPVJdKIoYk
         v9FxKbJ8LpmCNSRrEpdXx9R59EpSBkM6VO6BP8JkoahJhwIXDsiZ9aqS+ucc8e91jVob
         3xZ+hOtNBkE2TJ0u2qdplf89AhdG+lXBpy+nYke2EIx41bX2eBML9l0ny/pjzcZyXMWH
         OfwG1lB4QLHQEoPlhwiREHxM38L7E3RMI/FXY6lcSzSKEZhsJnFtJLNdqqPNzn+bNOU8
         PvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734339404; x=1734944204;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=626pWv5KSy+d5fJyUTQWTlBU9Lgvvvj33oOG+jYjkv0=;
        b=pvnRMaa2gkAhGJ3A9gTeFYY9d91OziXhDPUNZpTB1He1qLqdcSLFmg0PzuwvoWYL3D
         Hvk+WnrHzOKemjg3ZtxOVgJdn0ks1Irq4DUPsY6uPvSWNI6ZIUsMTiP9zvLN5x126Ad/
         y6QLN/vZp+XKU8816P3H936pUuU+G9ZrpYyBjCBnqxzwSyDQI1oAKk2SdJXGChbh3t89
         xS6+UjPMR6LaXDC4+spBBwClnejWwUxAsLyTgN6cdLoAu7O8TY+ddC+S9HsXK7wkyyPA
         kEjKuNDfO9faKH4LzUO4yQ6+i6QH8ObslcanQ0ChJ93Gb37sgfogpgVdD6SVW8PDc2QV
         D+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpWDdrnRWpYuqZLJ48qQXN6i3LXTI/dgtmkW8G51Pa2zugsj8Bgtxmva/P7z3iBLFW/S2ZezHhQPbVR/2r@vger.kernel.org, AJvYcCWA5QokS0PvMhnonkolgsuXJxMfUnzE5COnNolN3ecld3aAb/YKNYmOtZlMcopVdHZIReIzW1LegIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMIXSRdvkMBGQpnrAZ82/SVkmXdIpRZBMKLuEfSma0oxchSEj
	KlrgFTEdrkQoj0cNQVDJWWaDGWB/2Ps6MYtXSOHXALXyTjBT1/aU
X-Gm-Gg: ASbGncvPjOY5jUwCdzXPw1HJx8XA/ulTVPG9BC7/0OBf9VFXmdqU2cFeU3dtOEKpSkJ
	6rWAb01eQmPWlv90hyadH/+M27wZXV+ftwGlSKxZcX6vFG9GllhUlwX+A7t68zS/awquDO6gDh/
	TGs+6yE+1rD3zlEb2ANXWpTkivYgPcNjIL+/MKBtTwcfbMf2tXOK5U85C8LG+5se1cv2pnNkuK2
	6a/1EAUppId0zw3w8EAZkVEPptRlEqYOhD6pQ2B0ZR2QwD0w1/w8pInWyw=
X-Google-Smtp-Source: AGHT+IG3Oh337cUx8Oy+qqjyTPg8NGVyK3fDHAmv4fQ//dttOmRU51JIvzr7qeqQXMoU/yfI7RqujA==
X-Received: by 2002:a2e:a30e:0:b0:2ff:df01:2b43 with SMTP id 38308e7fff4ca-3025447b0a9mr31724281fa.18.1734339404090;
        Mon, 16 Dec 2024 00:56:44 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a5fbcsm8358901fa.105.2024.12.16.00.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:56:42 -0800 (PST)
Date: Mon, 16 Dec 2024 10:56:37 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: gts: Simplify available scale table build
Message-ID: <Z1_rRXqdhxhL6wBw@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eo02nJzJzcUjPyry"
Content-Disposition: inline


--eo02nJzJzcUjPyry
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
Revision history:
 v2:
    - Add a few comments
    - Use more descriptive variable name

This is still only tested using the kunit tests. All further testing is
still highly appreciated!
---
 drivers/iio/industrialio-gts-helper.c | 272 ++++++++++++++++----------
 1 file changed, 174 insertions(+), 98 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 291c0fc332c9..65697be58a10 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -160,16 +160,123 @@ static void iio_gts_purge_avail_scale_table(struct i=
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
+/*
+ * Do a single table listing all the unique scales that any combination of
+ * supported gains and times can provide.
+ */
+static int do_combined_scaletable(struct iio_gts *gts,
+				  size_t all_scales_tbl_bytes)
+{
+	int t_idx, i, new_idx;
+	int **scales =3D gts->per_time_avail_scale_tables;
+	int *all_scales =3D kcalloc(gts->num_itime, all_scales_tbl_bytes,
+				  GFP_KERNEL);
+
+	if (!all_scales)
+		return -ENOMEM;
+	/*
+	 * Create table containing all of the supported scales by looping
+	 * through all of the per-time scales and copying the unique scales
+	 * into one sorted table.
+	 *
+	 * We assume all the gains for same integration time were unique.
+	 * It is likely the first time table had greatest time multiplier as
+	 * the times are in the order of preference and greater times are
+	 * usually preferred. Hence we start from the last table which is likely
+	 * to have the smallest total gains.
+	 */
+	t_idx =3D gts->num_itime - 1;
+	memcpy(all_scales, scales[t_idx], all_scales_tbl_bytes);
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
@@ -189,71 +296,69 @@ static int gain_to_scaletables(struct iio_gts *gts, i=
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
+
+static void compute_per_time_gains(struct iio_gts *gts, int **gains)
+{
+	int i, j;
+
+	for (i =3D 0; i < gts->num_itime; i++) {
+		for (j =3D 0; j < gts->num_hwgain; j++)
+			gains[i][j] =3D gts->hwgain_table[j].gain *
+				      gts->itime_table[i].mul;
+	}
+}
+
+static int compute_per_time_tables(struct iio_gts *gts, int **scales)
+{
+	int **per_time_gains;
+	int ret;
=20
 	/*
-	 * We assume all the gains for same integration time were unique.
-	 * It is likely the first time table had greatest time multiplier as
-	 * the times are in the order of preference and greater times are
-	 * usually preferred. Hence we start from the last table which is likely
-	 * to have the smallest total gains.
+	 * Create a temporary array of the 'total gains' for each integration
+	 * time.
 	 */
-	time_idx =3D gts->num_itime - 1;
-	memcpy(all_gains, gains[time_idx], gain_bytes);
-	new_idx =3D gts->num_hwgain;
+	ret =3D iio_gts_alloc_int_table_array(&per_time_gains, gts->num_itime,
+					    gts->num_hwgain);
+	if (ret)
+		return ret;
=20
-	while (time_idx-- > 0) {
-		for (j =3D 0; j < gts->num_hwgain; j++) {
-			int candidate =3D gains[time_idx][j];
-			int chk;
+	compute_per_time_gains(gts, per_time_gains);
=20
-			if (candidate > all_gains[new_idx - 1]) {
-				all_gains[new_idx] =3D candidate;
-				new_idx++;
+	/* Convert the gains to scales and populate the scale tables */
+	ret =3D fill_and_sort_scaletables(gts, per_time_gains, scales);
=20
-				continue;
-			}
-			for (chk =3D 0; chk < new_idx; chk++)
-				if (candidate <=3D all_gains[chk])
-					break;
+	iio_gts_free_int_table_array(per_time_gains, gts->num_itime);
=20
-			if (candidate =3D=3D all_gains[chk])
-				continue;
+	return ret;
+}
=20
-			memmove(&all_gains[chk + 1], &all_gains[chk],
-				(new_idx - chk) * sizeof(int));
-			all_gains[chk] =3D candidate;
-			new_idx++;
-		}
-	}
+/*
+ * Create a table of supported scales for each supported integration time.
+ * This can be used as available_scales by drivers which don't allow scale
+ * setting to change the integration time to display correct set of scales
+ * depending on the used integration time.
+ */
+static int **create_per_time_scales(struct iio_gts *gts)
+{
+	int **per_time_scales, ret;
=20
-	gts->avail_all_scales_table =3D kcalloc(new_idx, 2 * sizeof(int),
-					      GFP_KERNEL);
-	if (!gts->avail_all_scales_table) {
-		ret =3D -ENOMEM;
-		goto free_out;
-	}
-	gts->num_avail_all_scales =3D new_idx;
+	ret =3D iio_gts_alloc_int_table_array(&per_time_scales, gts->num_itime,
+					    gts->num_hwgain * 2);
+	if (ret)
+		return ERR_PTR(ret);
=20
-	for (i =3D 0; i < gts->num_avail_all_scales; i++) {
-		ret =3D iio_gts_total_gain_to_scale(gts, all_gains[i],
-					&gts->avail_all_scales_table[i * 2],
-					&gts->avail_all_scales_table[i * 2 + 1]);
+	ret =3D compute_per_time_tables(gts, per_time_scales);
+	if (ret)
+		goto err_out;
=20
-		if (ret) {
-			kfree(gts->avail_all_scales_table);
-			gts->num_avail_all_scales =3D 0;
-			goto free_out;
-		}
-	}
+	return per_time_scales;
=20
-free_out:
-	kfree(all_gains);
+err_out:
+	iio_gts_free_int_table_array(per_time_scales, gts->num_itime);
=20
-	return ret;
+	return ERR_PTR(ret);
 }
=20
 /**
@@ -275,55 +380,26 @@ static int gain_to_scaletables(struct iio_gts *gts, i=
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
+	int ret, all_scales_tbl_bytes;
+	int **per_time_scales;
=20
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
-
-		for (j =3D 0; j < gts->num_hwgain; j++)
-			per_time_gains[i][j] =3D gts->hwgain_table[j].gain *
-					       gts->itime_table[i].mul;
-	}
+	if (unlikely(check_mul_overflow(gts->num_hwgain, 2 * sizeof(int),
+					&all_scales_tbl_bytes)))
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
+	ret =3D do_combined_scaletable(gts, all_scales_tbl_bytes);
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
--=20
2.47.0


--eo02nJzJzcUjPyry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdf60EACgkQeFA3/03a
ocWsLwf/coSoYvQ6FJiP/WDFlXtYTHiNisdHqHJfZddfnCbTSmHp3k8f3OcKHJhl
Dw4II4slg/o7JeEPq2bQQkghOh5nTduDRvTkAYunZ3OCqjBSnUeelcXtPuEEdy2H
0WKeZxEOF2flmgQDM65sWdfGCEeRh4V4D0nzmG3xUo8G4C2gLylflEW2qR+ktvX1
YmUucIyvgp6g7SzEGQZPIhFe9MfIiH+YqzmUk0FZm0Zw0io4mudfI7gMSEndIN2E
f+dzALyEABuntcOacQZrbhy4dw0Lovxvl6tvd8KRGsE/ZIzoIzpG8YqFO7yf6bDG
Mo1KsWauX9pagkQJI/F7n0KAVhze3g==
=iwJ3
-----END PGP SIGNATURE-----

--eo02nJzJzcUjPyry--

