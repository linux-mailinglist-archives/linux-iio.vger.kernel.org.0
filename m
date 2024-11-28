Return-Path: <linux-iio+bounces-12782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9C49DBB89
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 17:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BEEB232A0
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 16:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1AA1C07E5;
	Thu, 28 Nov 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr9TeyA+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6EB1AA1E4;
	Thu, 28 Nov 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812635; cv=none; b=V+DnM0FIQGaQAesIQTTNtbSwY6TGZG2MIKlssTb0HUuGs3PHXaysKbIVvMFRAosgVyiZesP7FAYgOacla04IP4ukPBIPmd+PTmp7eiM1vOBbbZE0pnKVteeI57hpO2cNxlTWvq3HRCm6xxwaJbZqc8g78jERs6pVKglNl8+gDyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812635; c=relaxed/simple;
	bh=okAaqW4wJNybkQoDzBAMqbD3/IoNTo/QwUvQMJFxovg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSKtomqw1M8HFzoS31fiMv90+4jellruQRegq6CbEalZJi3HRO2dg1X+vlAl+Ykm9RlarM79Gh9AOEbuyYg6ZLtzfTrPh6j1/GDIUSc8Pu+3FQx95XFLX45oMybMfGpTbSbYFN76xwo8OvhE9Io+pp1K2l/vGEwPHx29JEIq6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr9TeyA+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso4295691fa.1;
        Thu, 28 Nov 2024 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732812632; x=1733417432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMhyJcHOTwOTZlj4QlGUDoHdLCNeq1FU2ehiF3dhMzs=;
        b=Qr9TeyA+1vo4pHuYcgkJ9iTJjVau/85nl6g0tUwyccQjmEA6vl3l9xB1yIl1kuPxXD
         HseO9O2S8JXwDXzlu6yxXMM/vy2L0ir+yHlrr4ASToHYKe2ZP+k8tRWxlAOt5qujRjrX
         /mc/b852+5R0K7qwHywOOiFc7BA7zhH96s4lRlEdEhn98TMJi73hCU6Cmyo4BA3Xdai2
         39iYqXyI90ECNFyAiAG1pwvwZdQJ7a/reOJmHS5Ftq8336AWT1legDCFLEBZy2ds5rlT
         ttLwKPJLc78J5FhfWpQhPWPPwblv9xVXpHVVqtwIS4Eg5Td9Nd7rw8rw4NUe8dHlYfNC
         TorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732812632; x=1733417432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMhyJcHOTwOTZlj4QlGUDoHdLCNeq1FU2ehiF3dhMzs=;
        b=OqVumOMww0KcAVaUwswD9QBBHulTIslTcnORZVPMp2Pd5pfOlO6qeRLij/NerNqnbS
         GsGZJNuFsmxxBAAObQL+LUZCuh1uFPkxD8cjYDd5q1igBmGFp+um5y8rJ+74IN4hJKWs
         4Sft6BU+CdX6YyPa/3tbQJqQuHoxoLhEQTXQns1pbmpfVsYImrrm63YIkGe/tMfJW01D
         C+X8zqVRE8NOj5x9XOT4t/kfFA0egF7skwv/1I0PG6bRkz2bq0O41kMQGeCzCjybbYKj
         1DfdSkxCUNOFAW1QzIsqPT6Vg25Fh8GW2RWxn3gjRYTCla5hEd820tliQ+GBrGXzbSN7
         9COQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0velPZZOoI+BWH/AyHxLx4S0YlpxdhESpNeCHrONhwaWX0d8PHMx6Xe5W2FV7Unj584AspuG/VEY=@vger.kernel.org, AJvYcCVsN3/PKQlxG9V0Am8rYX4HstVx2x64ZAa3xuS1DztMlieW0z9lgkJjYq3K7vDbrs3TyfaOMwVBOYJI/Yvl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3CgQrroY1Z1WQkyDI9uzwvjAmAVIMGrDV2FmS96IySeIauDy
	36/5s05Pd55U6KW7l6YcfW51uiaBdD2dIiG8m703Xwy2bEqk2xjSK551tw==
X-Gm-Gg: ASbGncu9t1wbSE3WWOzvCRQQdk3paS1WkRmPQZ4D7VmRTmNSQEKE/wkyFv2jMOgrOJ+
	P7mTP0gh5RI2znVnTDxYl++Bg9iEX99RM8XT7j7x+24LISmh80nYkMCcd2sMU3UGqczBj/iZAdx
	bsO5O2RrpSy4LOfk1ZeMj0b9Cp9oIr6fB7SqRTa74X4XPHqBfwA7iDekhg2X8FHInJf+G3BJDHA
	wgGu/SZvjn5WqxOZt7OsTZHd4j0aczcK9BYFQxJl0jo6c8ZblV6/EtA
X-Google-Smtp-Source: AGHT+IGFHETRuNIz0UOtcyPEOkLL+enzqYEyP2wRO3yn4NsL5OPcH/n8W8tWPcLrElcJ6ueDeAlTyQ==
X-Received: by 2002:a2e:9687:0:b0:2ff:e54a:cd08 with SMTP id 38308e7fff4ca-2ffe54acea4mr3133751fa.3.1732812631758;
        Thu, 28 Nov 2024 08:50:31 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfca0ee9sm2315511fa.95.2024.11.28.08.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:50:29 -0800 (PST)
Date: Thu, 28 Nov 2024 18:50:24 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: gts: Simplify using __free
Message-ID: <1f8e1388b69df8a5a1a87748e9c748d2a3aa0533.1732811829.git.mazziesaccount@gmail.com>
References: <cover.1732811829.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g1sn1l6yxl4+IK/6"
Content-Disposition: inline
In-Reply-To: <cover.1732811829.git.mazziesaccount@gmail.com>


--g1sn1l6yxl4+IK/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The error path in the gain_to_scaletables() uses goto for unwinding an
allocation on failure. This can be slightly simplified by using the
automated free when exiting the scope.

Use __free(kfree) and drop the goto based error handling.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
This is derived from the:
https://lore.kernel.org/lkml/5efc30d832275778d1f48d7e2c75b1ecc63511d5.17321=
05157.git.mazziesaccount@gmail.com/
---
 drivers/iio/industrialio-gts-helper.c | 108 +++++++++++++++-----------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrial=
io-gts-helper.c
index 291c0fc332c9..e15d0112e9e3 100644
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
@@ -165,11 +166,9 @@ static int iio_gts_gain_cmp(const void *a, const void =
*b)
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
@@ -189,8 +188,15 @@ static int gain_to_scaletables(struct iio_gts *gts, in=
t **gains, int **scales)
 		}
 	}
=20
-	gain_bytes =3D array_size(gts->num_hwgain, sizeof(int));
-	all_gains =3D kcalloc(gts->num_itime, gain_bytes, GFP_KERNEL);
+	return 0;
+}
+
+static int build_combined_table(struct iio_gts *gts, int **gains, size_t g=
ain_bytes)
+{
+	int ret, i, j, new_idx, time_idx;
+	int *all_gains __free(kfree) =3D kcalloc(gts->num_itime, gain_bytes,
+					       GFP_KERNEL);
+
 	if (!all_gains)
 		return -ENOMEM;
=20
@@ -232,10 +238,9 @@ static int gain_to_scaletables(struct iio_gts *gts, in=
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
@@ -246,14 +251,25 @@ static int gain_to_scaletables(struct iio_gts *gts, i=
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
+	return 0;
+}
=20
-	return ret;
+static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **sca=
les)
+{
+	int ret;
+	size_t gain_bytes;
+
+	ret =3D fill_and_sort_scaletables(gts, gains, scales);
+	if (ret)
+		return ret;
+
+	gain_bytes =3D array_size(gts->num_hwgain, sizeof(int));
+
+	return build_combined_table(gts, gains, gain_bytes);
 }
=20
 /**
@@ -337,26 +353,11 @@ static void iio_gts_us_to_int_micro(int *time_us, int=
 *int_micro_times,
 	}
 }
=20
-/**
- * iio_gts_build_avail_time_table - build table of available integration t=
imes
- * @gts:	Gain time scale descriptor
- *
- * Build the table which can represent the available times to be returned
- * to users using the read_avail-callback.
- *
- * NOTE: Space allocated for the tables must be freed using
- * iio_gts_purge_avail_time_table() when the tables are no longer needed.
- *
- * Return: 0 on success.
- */
-static int iio_gts_build_avail_time_table(struct iio_gts *gts)
+static int __iio_gts_build_avail_time_table(struct iio_gts *gts)
 {
-	int *times, i, j, idx =3D 0, *int_micro_times;
-
-	if (!gts->num_itime)
-		return 0;
+	int i, j, idx =3D 0, *int_micro_times;
+	int *times __free(kfree) =3D kcalloc(gts->num_itime, sizeof(int), GFP_KER=
NEL);
=20
-	times =3D kcalloc(gts->num_itime, sizeof(int), GFP_KERNEL);
 	if (!times)
 		return -ENOMEM;
=20
@@ -384,25 +385,42 @@ static int iio_gts_build_avail_time_table(struct iio_=
gts *gts)
=20
 	/* create a list of times formatted as list of IIO_VAL_INT_PLUS_MICRO */
 	int_micro_times =3D kcalloc(idx, sizeof(int) * 2, GFP_KERNEL);
-	if (int_micro_times) {
-		/*
-		 * This is just to survive a unlikely corner-case where times in
-		 * the given time table were not unique. Else we could just
-		 * trust the gts->num_itime.
-		 */
-		gts->num_avail_time_tables =3D idx;
-		iio_gts_us_to_int_micro(times, int_micro_times, idx);
-	}
-
-	gts->avail_time_tables =3D int_micro_times;
-	kfree(times);
-
 	if (!int_micro_times)
 		return -ENOMEM;
=20
+	/*
+	 * This is just to survive a unlikely corner-case where times in
+	 * the given time table were not unique. Else we could just
+	 * trust the gts->num_itime.
+	 */
+	gts->num_avail_time_tables =3D idx;
+	iio_gts_us_to_int_micro(times, int_micro_times, idx);
+
+	gts->avail_time_tables =3D int_micro_times;
+
 	return 0;
 }
=20
+/**
+ * iio_gts_build_avail_time_table - build table of available integration t=
imes
+ * @gts:	Gain time scale descriptor
+ *
+ * Build the table which can represent the available times to be returned
+ * to users using the read_avail-callback.
+ *
+ * NOTE: Space allocated for the tables must be freed using
+ * iio_gts_purge_avail_time_table() when the tables are no longer needed.
+ *
+ * Return: 0 on success.
+ */
+static int iio_gts_build_avail_time_table(struct iio_gts *gts)
+{
+	if (!gts->num_itime)
+		return 0;
+
+	return __iio_gts_build_avail_time_table(gts);
+}
+
 /**
  * iio_gts_purge_avail_time_table - free-up the available integration time=
 table
  * @gts:	Gain time scale descriptor
--=20
2.47.0


--g1sn1l6yxl4+IK/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIn1AACgkQeFA3/03a
ocXbVgf9HiIYHwRvuilElogb+kLQ5SJ0dhJ4S3odi/ScXsskDotST5q1gSZ4sojv
YAO3nXLOhp54sRYSJEq1Oi9mBd2eB7bHrDhXJo7tQ6CWbyJ4awXI565d2FEGn/bY
8ULRDyg74VqzZPI1BM3SqYybAh5A/LDlE3VivXW/jS7J9EjLP6MHI2cLrez70L1E
TdYIb8CziTqq4Md+l1LGO+h+RHIrmudVRK4tex7/1MoPH14quI2yWbMkfBSLVBQd
tqaZG6mPPrD1aF3rdM0izx62+e+HLI0/x68mgflBifgcDY1FslL1Foc9gKlSFN86
5Fh/L4o9V5qe2eno7TiMai/foFaIlQ==
=wo1i
-----END PGP SIGNATURE-----

--g1sn1l6yxl4+IK/6--

