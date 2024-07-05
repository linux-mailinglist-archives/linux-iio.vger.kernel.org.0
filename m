Return-Path: <linux-iio+bounces-7354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4F928740
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDFB1F26D3C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0DD1494C8;
	Fri,  5 Jul 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWOl7N+G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F141494B2;
	Fri,  5 Jul 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176927; cv=none; b=A1jU1STwCNUBrsbJ89XSWRnV7IboyVlJiAKOVfQD0gN7sq/6YlENrSOo6Ryf5R2SZZz1LCtA1+l+p2hGo5fdNk1zLRC0reWx9BnIigFTukftRTDvsHT5tc/zLC+r8eoJ1QIpwKqCJn6DRvb03HNZbxIQB6RqpNVUtNsCGjx1QFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176927; c=relaxed/simple;
	bh=uizZIXQWBHm/nBSdPOwzmlkSiKo+SRxFRLi7vHlsv9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9C9c9VXIX14T3VrMS5pTfQcQFFHkaQalBhqk6zVRUYDSDukYQaBu2wspNi5uY0YM5knc/NT8JpBhqFa4L4fLDwRisgE/+rrlEJt2CEy4JTnECmApiO7hiUIqMhF5sjqq2gn2Ec+1XZOtNDRfVWrq1y6w1QTNLnvNlfAAMOMq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWOl7N+G; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee9505cd37so5644961fa.2;
        Fri, 05 Jul 2024 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176924; x=1720781724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l38WS20I2ZkeICm8h8eAH34Be7x0pCth3bMK+qjFUAA=;
        b=iWOl7N+Gg1D92iFphVLz2Yd6AE5qE09wims44PJ2KkQiz9aCLd8jQi2EQP8FnWal+h
         w0J6azglIHO5PpWBVKpN6pSdmzvfBJE9krQP2vTSnyu+QrmCUCo6MM/u1vthn7qee5nJ
         VCCO72pVLRangZgLrjld2nCCOcOYyz/ue1tdhjMNhqvFdaNjYc8Xs+VV2BGfgtYGBaGI
         KQLnEVp6cRdl+tvpU7MxOgi9hbqjd6gPNCWXITn/xQquAaEaSjRCGZwFuy1aqsYaMj3n
         gU/CdNqDWbvh0pQBakEvRLA+Zp9WpQUL3/H3ePKFNG2+X1tSqi4c5ln1prTUVY8Cn9BJ
         IHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176924; x=1720781724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l38WS20I2ZkeICm8h8eAH34Be7x0pCth3bMK+qjFUAA=;
        b=PgqMXcXD6wx32DfzFlk0kOxEHE/xaz7bcUOkgvnz7zWE9iPwbZ/ALHzz9txiL+0b62
         CgOcQAjccZYty+U+zADrZ7pT0ac/lc4KmH7APR5gzgOEFDcMT1wdPWthoSbskQwdEucS
         s3gKpdMcBsZnynO6X3E9mDzFu+TO6rGPGDyg9vp27nqxegitiKzEDaIzXnBKnvWcLnWI
         lmCAYuJVr+4bB4MPo/UT5kB2FjHi8U81GD7u2Tu+ErP7bltm+l8M9tq6Ju6hb1noepKa
         b5n8uBGAP4OCXiMj5IF4ZR84JN7EtBdzOdVwwasZzbTguGJuJTmvRiOzpHjUVHwIPAOP
         E0IA==
X-Forwarded-Encrypted: i=1; AJvYcCUeiEkgTiWXsZt+Zus9BfrA897ggiqFQQmmLn3BaalQ6Y7kC8nA+SPy/O7eq4zrEg0gX5FvLsdZKwUN67OlxRcSz1etbBK4VMFzXMHWtm+w0m8HhJEnT/vViFaU/9NHHC9Qzp9RWVj2Je43AK5wgCDz/xDsR+vcOBA8+al1GoFeHOwSPQ==
X-Gm-Message-State: AOJu0Yx2La+c0hrERne5RA+wSza6H9usHfuY8guCmnFFcL0zbS2xsAC8
	nMypzjxng0icz/NrbVzRd92Gug+kjc4iBorcIQlpV77iDwP9IxGN
X-Google-Smtp-Source: AGHT+IEqEpKW8Uw8UxN4TC6arB7J/zSXGBUaP3mzr1hB86ne8sxQ75qXNrPzZvEouJ3lvKfuyf/DUQ==
X-Received: by 2002:a2e:9515:0:b0:2eb:f472:e7d3 with SMTP id 38308e7fff4ca-2ee8ed22c62mr29336611fa.6.1720176923713;
        Fri, 05 Jul 2024 03:55:23 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee516969d3sm26595771fa.132.2024.07.05.03.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:55:22 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:55:19 +0300
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
Subject: [PATCH v2 5/7] bu27034: ROHM BU27034ANUC correct gains and times
Message-ID: <19f8cca2b5498fbfea6e657b7b9c90b78516866a.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uRryvoHoTSr8kYEb"
Content-Disposition: inline
In-Reply-To: <cover.1720176341.git.mazziesaccount@gmail.com>


--uRryvoHoTSr8kYEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27034NUC was cancelled and BU27034ANUC is replacing this
sensor. The BU27034ANUC does not support all the gains or all the
integration times that were supported on BU27034NUC.

Srop unsupported times and gains

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v1 =3D> v2:
 - splitted from a big patch, no real changes
---
 drivers/iio/light/rohm-bu27034.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 86b8771caff0..850ec78f5405 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -94,49 +94,39 @@ static const unsigned long bu27034_scan_masks[] =3D {
 };
=20
 /*
- * Available scales with gain 1x - 4096x, timings 55, 100, 200, 400 mS
+ * Available scales with gain 1x - 1024x, timings 55, 100, 200, 400 mS
  * Time impacts to gain: 1x, 2x, 4x, 8x.
  *
- * =3D> Max total gain is HWGAIN * gain by integration time (8 * 4096) =3D=
 32768
+ * =3D> Max total gain is HWGAIN * gain by integration time (8 * 1024) =3D=
 8192
+ * if 1x gain is scale 1, scale for 2x gain is 0.5, 4x =3D> 0.25,
+ * ... 8192x =3D> 0.0001220703125 =3D> 122070.3125 nanos
  *
- * Using NANO precision for scale we must use scale 64x corresponding gain=
 1x
- * to avoid precision loss. (32x would result scale 976 562.5(nanos).
+ * Using NANO precision for scale, we must use scale 16x corresponding gai=
n 1x
+ * to avoid precision loss. (8x would result scale 976 562.5(nanos).
  */
-#define BU27034_SCALE_1X	64
+#define BU27034_SCALE_1X	16
=20
 /* See the data sheet for the "Gain Setting" table */
 #define BU27034_GSEL_1X		0x00 /* 00000 */
 #define BU27034_GSEL_4X		0x08 /* 01000 */
-#define BU27034_GSEL_16X	0x0a /* 01010 */
 #define BU27034_GSEL_32X	0x0b /* 01011 */
-#define BU27034_GSEL_64X	0x0c /* 01100 */
 #define BU27034_GSEL_256X	0x18 /* 11000 */
 #define BU27034_GSEL_512X	0x19 /* 11001 */
 #define BU27034_GSEL_1024X	0x1a /* 11010 */
-#define BU27034_GSEL_2048X	0x1b /* 11011 */
-#define BU27034_GSEL_4096X	0x1c /* 11100 */
=20
 /* Available gain settings */
 static const struct iio_gain_sel_pair bu27034_gains[] =3D {
 	GAIN_SCALE_GAIN(1, BU27034_GSEL_1X),
 	GAIN_SCALE_GAIN(4, BU27034_GSEL_4X),
-	GAIN_SCALE_GAIN(16, BU27034_GSEL_16X),
 	GAIN_SCALE_GAIN(32, BU27034_GSEL_32X),
-	GAIN_SCALE_GAIN(64, BU27034_GSEL_64X),
 	GAIN_SCALE_GAIN(256, BU27034_GSEL_256X),
 	GAIN_SCALE_GAIN(512, BU27034_GSEL_512X),
 	GAIN_SCALE_GAIN(1024, BU27034_GSEL_1024X),
-	GAIN_SCALE_GAIN(2048, BU27034_GSEL_2048X),
-	GAIN_SCALE_GAIN(4096, BU27034_GSEL_4096X),
 };
=20
 /*
- * The IC has 5 modes for sampling time. 5 mS mode is exceptional as it li=
mits
- * the data collection to data0-channel only and cuts the supported range =
to
- * 10 bit. It is not supported by the driver.
- *
- * "normal" modes are 55, 100, 200 and 400 mS modes - which do have direct
- * multiplying impact to the register values (similar to gain).
+ * Measurement modes are 55, 100, 200 and 400 mS modes - which do have dir=
ect
+ * multiplying impact to the data register values (similar to gain).
  *
  * This means that if meas-mode is changed for example from 400 =3D> 200,
  * the scale is doubled. Eg, time impact to total gain is x1, x2, x4, x8.
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

--uRryvoHoTSr8kYEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaH0RYACgkQeFA3/03a
ocUFmAf/ZTFtct8rbLixjUyqG209EHm5FMSwG1g5JbxRQgebEHHYqWkHBV+v9moq
R6kDx+x8E7e0lp/1q4c/M9NG1ZYtwc0h46e4yH3QMtoV8y+fCDk0z7SKAo4Mi+x5
UlYCZfrNXzBxSC0r+B2ai6AIWx/fOenXV+wVeDT1aCHJWI29crFG2s3BVE4oTI7l
AqPyGEJ6+4BUNhpmXi7ICkmghVODfeP83EOjwsdpoWhAdD3g/bYRAguefb1Tx7ex
i66NIlidN+NKSLAcHn+amS9nrBFZkCD0wVmSqkwltoOODddisQt0Zd0xlvF+cezU
jEXtlUwJ+R3uQwlbWFkur7bydTgAXg==
=oJJJ
-----END PGP SIGNATURE-----

--uRryvoHoTSr8kYEb--

