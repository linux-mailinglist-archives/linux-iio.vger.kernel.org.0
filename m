Return-Path: <linux-iio+bounces-7355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C630A928743
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B63B264C7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97D14A4D0;
	Fri,  5 Jul 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc08TT+z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC60147C9A;
	Fri,  5 Jul 2024 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176943; cv=none; b=AtMJ3Weu8q42dfwR2GbIOwdSnUGv72OHhdO7dqhbZN5J4EbUT/CSq+uf/eQKgcqjYutv7JbCYQaL1+XfyrY1K4aA/ufThV9BZBlf0lVeqpf07RS2j3SNRGfZKDMpoy0YasTnyCZ3F8pgbEwAbNEcTdSDWEgofvUUbqUWwLiAQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176943; c=relaxed/simple;
	bh=zIjoA6Dq9DwPlrvDfQBJ8BrxD5cxRgcvJ4TuPLJdtls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUoTpSCVIHcIP7q+2n7Xk9O2SjFhC5kGrtUAbRUKddsYlwpJTpiBzsNIGO5EVrirXBxLt7/sUjwbpTFocM/rlmEaWjg+95hhGkGdEpSnYs+6kpbmSIjJ7eXhujkb6B3qTq+5dCnlAoOpHTJglET7imZE6BKmmqZsmejwGQj1Y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc08TT+z; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so20021411fa.3;
        Fri, 05 Jul 2024 03:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176939; x=1720781739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zq8sVfWi+SvUMeKR0gIcar/+sIzKUyE5bCb4en+xoo4=;
        b=Tc08TT+z5pB5uCyvKWcvwLltIBqqo+T89bJJiay7ybotf+MSLu98dDTn6dQbDNHxL8
         mKkqNWAislqySYtaxK3FxOADmX6XbvLqdOa+A4wyMJc51bnOVDEXBOr4djbId3+e4HRX
         qe0hZe2KLqbi+QPRTSMIdYB/X5PCPhE9BsvKlXwRlX855OsiYMnul4QLAFd4N6lVvkg9
         CmfVoQfWgHuXlh3kYABHe2YlV5pCA5vjuLpWMEG0bOgymHS6GlFTmVLLlwT5Sqbh7FCV
         INUUYSYdq53bCNusLw4V4EERcDjvD/wG4LuBgjDfevk8/84ds5CO+gOCzxVr8VLrpk3H
         LMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176939; x=1720781739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zq8sVfWi+SvUMeKR0gIcar/+sIzKUyE5bCb4en+xoo4=;
        b=kpzKyY7gRp+j9f+dbohUcN+9ovXpxYu2aKFe+JWjMsAQ6jvLk05HOok4YB0EJZX2gm
         WMFXjEAF0L0LaxjnXvoaKrA3d179P9kj2nXhCSx7GZUY7VZml8XsxHM+LX6r3UFfcclA
         I61/gLobLUlIEbZ4a9hDc9XBHkOQ57PENcpGdxVUFWPCr30MuJsUG5WUFvrL906OtZ0b
         LtIA7op258y2UaRDJ+4Ei8CZmrXBM2AX5EwKylm8hgJa4q50vzHbs71T0xruCW0VKA1j
         QnTanQ24/9M2hlHkSi2cTCPTpCC3PDBtL729r7brKAHFvKfsDRCU8i1y5zes/5PL7rCr
         7sJg==
X-Forwarded-Encrypted: i=1; AJvYcCVvmZGgMXWlL3mVsFCFZOxt1dJ16bGLWNhR4unUtNEcsHTsIsWsFLqgO+VJjza4FOS4z02oDTm1ctbj1YTwXJpQdEvvPin6smKefRzCrlyfh+yekqdINd8wM8qLWURMrowSNlByJpQI+tMFDQ2SH02nol6flddc3ULvulS7FHZcA4/Ssg==
X-Gm-Message-State: AOJu0YyUTZkXYjRLBoStGr82GMMzTgrIjn0pg5U7J9gh1+l06g4PvSLO
	M+k76cN3HnzA3Q3/iSpljPzDM6HAYJEO5P6eVUHkADLCouB92sUJ
X-Google-Smtp-Source: AGHT+IH6kUGqhfbH7KJBbnKp6WFjNZw8K6WL02KwwxnFntBG3ti0Bh3q+29Ed+gTqgCqsQaG+nq1Dg==
X-Received: by 2002:a2e:8397:0:b0:2ee:4aaf:5f16 with SMTP id 38308e7fff4ca-2ee8ed66da3mr27860831fa.1.1720176939083;
        Fri, 05 Jul 2024 03:55:39 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee9410f20bsm2286601fa.114.2024.07.05.03.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:55:38 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:55:34 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] bu27034: ROHM BU27034ANUC correct lux calculation
Message-ID: <b7bea76b54b28eb354dc523771a0e0a8b6f26095.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7mHQTSwa23lrjvdZ"
Content-Disposition: inline
In-Reply-To: <cover.1720176341.git.mazziesaccount@gmail.com>


--7mHQTSwa23lrjvdZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27034NUC was cancelled and BU27034ANUC is replacing this
sensor. The lux computation based on the data from a BU27034ANUC is
different from the computation for the data from an old BU27034NUC.

Fix the lux computation.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v1 =3D> v2:
 - splitted from a big patch
 - fix maths in comments to follow the coding style
 - fix the D1 / D0 ratio logic when picking the right coefficients for
   Lux calculation
---
 drivers/iio/light/rohm-bu27034.c | 157 ++++++-------------------------
 1 file changed, 31 insertions(+), 126 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 850ec78f5405..ec4f9bef83f8 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -573,102 +573,21 @@ static int bu27034_set_scale(struct bu27034_data *da=
ta, int chan,
 }
=20
 /*
- * for (D1/D0 < 0.87):
- * lx =3D 0.004521097 * D1 - 0.002663996 * D0 +
- *	0.00012213 * D1 * D1 / D0
+ * for (D1/D0 < 1.5):
+ *    lx =3D (0.001193 * D0 + (-0.0000747) * D1) * ((D1/D0 =E2=80=93 1.5) =
* (0.25) + 1)
  *
- * =3D>	115.7400832 * ch1 / gain1 / mt -
- *	68.1982976 * ch0 / gain0 / mt +
- *	0.00012213 * 25600 * (ch1 / gain1 / mt) * 25600 *
- *	(ch1 /gain1 / mt) / (25600 * ch0 / gain0 / mt)
+ *    =3D> -0.000745625 * D0 + 0.0002515625 * D1 + -0.000018675 * D1 * D1 =
/ D0
  *
- * A =3D	0.00012213 * 25600 * (ch1 /gain1 / mt) * 25600 *
- *	(ch1 /gain1 / mt) / (25600 * ch0 / gain0 / mt)
- * =3D>	0.00012213 * 25600 * (ch1 /gain1 / mt) *
- *	(ch1 /gain1 / mt) / (ch0 / gain0 / mt)
- * =3D>	0.00012213 * 25600 * (ch1 / gain1) * (ch1 /gain1 / mt) /
- *	(ch0 / gain0)
- * =3D>	0.00012213 * 25600 * (ch1 / gain1) * (ch1 /gain1 / mt) *
- *	gain0 / ch0
- * =3D>	3.126528 * ch1 * ch1 * gain0 / gain1 / gain1 / mt /ch0
+ *    =3D> (6.44 * ch1 / gain1 + 19.088 * ch0 / gain0 -
+ *       0.47808 * ch1 * ch1 * gain0 / gain1 / gain1 / ch0) /
+ *       mt
  *
- * lx =3D (115.7400832 * ch1 / gain1 - 68.1982976 * ch0 / gain0) /
- *	mt + A
- * =3D>	(115.7400832 * ch1 / gain1 - 68.1982976 * ch0 / gain0) /
- *	mt + 3.126528 * ch1 * ch1 * gain0 / gain1 / gain1 / mt /
- *	ch0
+ * Else
+ *    lx =3D 0.001193 * D0 - 0.0000747 * D1
  *
- * =3D>	(115.7400832 * ch1 / gain1 - 68.1982976 * ch0 / gain0 +
- *	  3.126528 * ch1 * ch1 * gain0 / gain1 / gain1 / ch0) /
- *	  mt
- *
- * For (0.87 <=3D D1/D0 < 1.00)
- * lx =3D (0.001331* D0 + 0.0000354 * D1) * ((D1/D0 =E2=80=93 0.87) * (0.3=
85) + 1)
- * =3D>	(0.001331 * 256 * 100 * ch0 / gain0 / mt + 0.0000354 * 256 *
- *	100 * ch1 / gain1 / mt) * ((D1/D0 -  0.87) * (0.385) + 1)
- * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	((D1/D0 -  0.87) * (0.385) + 1)
- * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	(0.385 * D1/D0 - 0.66505)
- * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	(0.385 * 256 * 100 * ch1 / gain1 / mt / (256 * 100 * ch0 / gain0 / mt) =
- 0.66505)
- * =3D>	(34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	(9856 * ch1 / gain1 / mt / (25600 * ch0 / gain0 / mt) + 0.66505)
- * =3D>	13.118336 * ch1 / (gain1 * mt)
- *	+ 22.66064768 * ch0 / (gain0 * mt)
- *	+ 8931.90144 * ch1 * ch1 * gain0 /
- *	  (25600 * ch0 * gain1 * gain1 * mt)
- *	+ 0.602694912 * ch1 / (gain1 * mt)
- *
- * =3D>	[0.3489024 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1)
- *	 + 22.66064768 * ch0 / gain0
- *	 + 13.721030912 * ch1 / gain1
- *	] / mt
- *
- * For (D1/D0 >=3D 1.00)
- *
- * lx	=3D (0.001331* D0 + 0.0000354 * D1) * ((D1/D0 =E2=80=93 2.0) * (-0.0=
5) + 1)
- *	=3D> (0.001331* D0 + 0.0000354 * D1) * (-0.05D1/D0 + 1.1)
- *	=3D> (0.001331 * 256 * 100 * ch0 / gain0 / mt + 0.0000354 * 256 *
- *	   100 * ch1 / gain1 / mt) * (-0.05D1/D0 + 1.1)
- *	=3D> (34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	   (-0.05 * 256 * 100 * ch1 / gain1 / mt / (256 * 100 * ch0 / gain0 / m=
t) + 1.1)
- *	=3D> (34.0736 * ch0 / gain0 / mt + 0.90624 * ch1 / gain1 / mt) *
- *	   (-1280 * ch1 / (gain1 * mt * 25600 * ch0 / gain0 / mt) + 1.1)
- *	=3D> (34.0736 * ch0 * -1280 * ch1 * gain0 * mt /( gain0 * mt * gain1 * =
mt * 25600 * ch0)
- *	    + 34.0736 * 1.1 * ch0 / (gain0 * mt)
- *	    + 0.90624 * ch1 * -1280 * ch1 *gain0 * mt / (gain1 * mt *gain1 * mt=
 * 25600 * ch0)
- *	    + 1.1 * 0.90624 * ch1 / (gain1 * mt)
- *	=3D> -43614.208 * ch1 / (gain1 * mt * 25600)
- *	    + 37.48096  ch0 / (gain0 * mt)
- *	    - 1159.9872 * ch1 * ch1 * gain0 / (gain1 * gain1 * mt * 25600 * ch0)
- *	    + 0.996864 ch1 / (gain1 * mt)
- *	=3D> [
- *		- 0.045312 * ch1 * ch1 * gain0 / (gain1 * gain1 * ch0)
- *		- 0.706816 * ch1 / gain1
- *		+ 37.48096  ch0 /gain0
- *	   ] * mt
- *
- *
- * So, the first case (D1/D0 < 0.87) can be computed to a form:
- *
- * lx =3D (3.126528 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
- *	 115.7400832 * ch1 / gain1 +
- *	-68.1982976 * ch0 / gain0
- *	 / mt
- *
- * Second case (0.87 <=3D D1/D0 < 1.00) goes to form:
- *
- *	=3D> [0.3489024 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
- *	    13.721030912 * ch1 / gain1 +
- *	    22.66064768 * ch0 / gain0
- *	   ] / mt
- *
- * Third case (D1/D0 >=3D 1.00) goes to form:
- *	=3D> [-0.045312 * ch1 * ch1 * gain0 / (ch0 * gain1 * gain1) +
- *	    -0.706816 * ch1 / gain1 +
- *	    37.48096  ch0 /(gain0
- *	   ] / mt
+ *    =3D> (1.91232 * ch1 / gain1 + 30.5408 * ch0 / gain0 +
+ *        [0 * ch1 * ch1 * gain0 / gain1 / gain1 / ch0] ) /
+ *        mt
  *
  * This can be unified to format:
  * lx =3D [
@@ -678,19 +597,14 @@ static int bu27034_set_scale(struct bu27034_data *dat=
a, int chan,
  *	] / mt
  *
  * For case 1:
- * A =3D 3.126528,
- * B =3D 115.7400832
- * C =3D -68.1982976
+ * A =3D -0.47808,
+ * B =3D 6.44,
+ * C =3D 19.088
  *
  * For case 2:
- * A =3D 0.3489024
- * B =3D 13.721030912
- * C =3D 22.66064768
- *
- * For case 3:
- * A =3D -0.045312
- * B =3D -0.706816
- * C =3D 37.48096
+ * A =3D 0
+ * B =3D 1.91232
+ * C =3D 30.5408
  */
=20
 struct bu27034_lx_coeff {
@@ -795,21 +709,16 @@ static int bu27034_fixp_calc_lx(unsigned int ch0, uns=
igned int ch1,
 {
 	static const struct bu27034_lx_coeff coeff[] =3D {
 		{
-			.A =3D 31265280,		/* 3.126528 */
-			.B =3D 1157400832,	/*115.7400832 */
-			.C =3D 681982976,		/* -68.1982976 */
-			.is_neg =3D {false, false, true},
+			.A =3D 4780800,		/* -0.47808 */
+			.B =3D 64400000,		/* 6.44 */
+			.C =3D 190880000,		/* 19.088 */
+			.is_neg =3D { true, false, false },
 		}, {
-			.A =3D 3489024,		/* 0.3489024 */
-			.B =3D 137210309,		/* 13.721030912 */
-			.C =3D 226606476,		/* 22.66064768 */
+			.A =3D 0,			/* 0 */
+			.B =3D 19123200,		/* 1.91232 */
+			.C =3D 305408000,		/* 30.5408 */
 			/* All terms positive */
-		}, {
-			.A =3D 453120,		/* -0.045312 */
-			.B =3D 7068160,		/* -0.706816 */
-			.C =3D 374809600,		/* 37.48096 */
-			.is_neg =3D {true, true, false},
-		}
+		},
 	};
 	const struct bu27034_lx_coeff *c =3D &coeff[coeff_idx];
 	u64 res =3D 0, terms[3];
@@ -972,12 +881,10 @@ static int bu27034_get_single_result(struct bu27034_d=
ata *data, int chan,
  * D1 =3D data1/ch1_gain/meas_time_ms * 25600
  *
  * Then:
- * if (D1/D0 < 0.87)
- *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 3.45 + 1)
- * else if (D1/D0 < 1)
- *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 0.385 + 1)
- * else
- *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 2) * -0.05 + 1)
+ * If (D1/D0 < 1.5)
+ *    lx =3D (0.001193 * D0 + (-0.0000747) * D1) * ((D1 / D0 =E2=80=93 1.5=
) * 0.25 + 1)
+ * Else
+ *    lx =3D (0.001193 * D0 + (-0.0000747) * D1)
  *
  * We use it here. Users who have for example some colored lens
  * need to modify the calculation but I hope this gives a starting point f=
or
@@ -1028,12 +935,10 @@ static int bu27034_calc_mlux(struct bu27034_data *da=
ta, __le16 *res, int *val)
 		d1_d0_ratio_scaled /=3D ch0 * gain1;
 	}
=20
-	if (d1_d0_ratio_scaled < 87)
+	if (d1_d0_ratio_scaled < 150)
 		ret =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 0);
-	else if (d1_d0_ratio_scaled < 100)
-		ret =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 1);
 	else
-		ret =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 2);
+		ret =3D bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 1);
=20
 	if (ret < 0)
 		return ret;
--=20
2.45.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--7mHQTSwa23lrjvdZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaH0SYACgkQeFA3/03a
ocXjdwgArCHFONs3kSkpr+cHvPOIbS5wVV8e0qDpPYzxIMy3JeHhoKZKfbgbJbMW
DB9uQIGa738wXsDLpteLGy/EYlE5i4bc434UqZeYLfe/jUmYxOVJcF8k1l9fdIC5
IzfzkvS7YmMZnWG3UjCp4BD5JQElGMplM9X+djEnWGv7Z+BcDlQGwoghlPqJk3CB
ODDY5D50CDh/KigkhE+YgfJidBzNxP3G1EcCGF+ZobD+TfG0TW0/gfHc4DnhLW9w
+7p+L0U8va2nKueegWnw5kpnkA/fKbqOEYCeWHRwULKTUUl3Qp/Sbxxb5/HSZV5o
5+JDDgIuOOdCPhnhGUgPb6AL9S8tHw==
=Mn7L
-----END PGP SIGNATURE-----

--7mHQTSwa23lrjvdZ--

