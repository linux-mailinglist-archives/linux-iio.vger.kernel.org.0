Return-Path: <linux-iio+bounces-22550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88751B20254
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1663B5CDA
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C63F2DCF62;
	Mon, 11 Aug 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn4l4xFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA72DC353;
	Mon, 11 Aug 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902319; cv=none; b=MpCCCZAYhjZwr88dfuBko0+GYHBHIrBXBEHvvAqcs5eUxHvx1u/UlC/R2dQJQ339vZ1JUdiOTJ7JIHs2XpXetyhSwHEABFIKfS3cavQIgrF5Wid2X8x2RlpujYBhnFM2A3XZ8r5JGHVcvnseDAZXneX+C5+PHYNtCkVy1KsVef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902319; c=relaxed/simple;
	bh=F4TREeWMWt2jjWFZvCzOgn7NQa8DjZhmx90+FLb1BDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUhyFSxQDw3aLckxYy7q/ju74kPVwkeCxFZ6FxcUmUbduzPWYDzWLIzRomQexFE8sxQfXWu0KxNlcrNhW2Omx9lQHtxRccR2mdyC5tYh2X//SQOEto8ap9n7FaAA7Fwq6LRjYQWeOi+jAx9U/e3QPruyHBm+0upKaJu2spve/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn4l4xFv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b8f1a13e9so3700028e87.1;
        Mon, 11 Aug 2025 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902315; x=1755507115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHvkgWv4w2o+btTskbyx1TNjeGCh7Hy/escoNAAMkGQ=;
        b=Sn4l4xFvJTVbpKSCMO5dzqDmU/rqlCOIGXFOFsJpy9LqVMaNglmm6Eol5k8f74w9hG
         4VbKvd5CmA+rF3SDdXsUOYEXviIQfY876meTGMF9vj4VnpJJoUIG8F+FlM613GD35zQM
         0ApxvftTJtMAm7rR8IYq6pa6/7aIN0QCiIRKmvlP+KdYI4587uFW+EQMkqsJkY/VB0QC
         oDOdFVkqsO+h8pymlYm8kR3cUscDK1aVwULR1nrrV6PyvtWs6ZdVDIVki260ZQl3tDFK
         EFfyJdfpqDffJddvIINMHyMvfyYEhIooK67FpIMh75AZ2Dq2yre8lb+/wVnxoQf6GXbI
         sz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902315; x=1755507115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHvkgWv4w2o+btTskbyx1TNjeGCh7Hy/escoNAAMkGQ=;
        b=aBuExBluVQIU8/M/UsVsTW8KGkiBj55H4pe6dLVP5n3K/h4weYCaLzjz98dkgWL1BZ
         85uHsJF21kRxA4aO+m72RJhyCnebIHefL3/WvxEXNTAvInYT8zyfCIySU3N3/acPdbiX
         CqlBz+dfxINZpKfJpjj7IaS230dpa2lpwFqCRSRE2DUcz3oSHOlcSK8OaVfj5DR8xPVf
         cQZZs1DNDjTUgiSja/92+95Bo/Ojf+f39KwZWv7HF4/SRoqNuGBFjV7P2n95sneUuX3b
         VE2rwR/1j207TACHPawvwNq7RKWSMtSizlUMgyWVjdpa8IGuUqB/enPcUvO/t8ApkFR7
         Ap3A==
X-Forwarded-Encrypted: i=1; AJvYcCV1iJZAWzrteY7e9F0XLTj6TWxn1yWptfv9kX6+4IGAMkwH77QyuNBlMGVdjBQWcSALkZrK39KLhV0N@vger.kernel.org, AJvYcCWJlusWNrt8i2EV4Ngu0/3J62DJKii+UjXVSlpcMsVzwjujeANsjTg1n8AeNX9UqllGfKF9FMywVXtW@vger.kernel.org, AJvYcCXLB/4C6A5EEyihQ4PXKALIQbfmBFBbvoDQ632jrlrrNHH3oR4jBxtbICFQ/3SxDM7j5A15NVwQAFFuWkfe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cyEP7QTQiIemT1pDfUon37ktdYaawHseSwnUhr8gErDqBow+
	+auAfdfQctStfj4mLaD3yjYJ5FAt/qANQII/HxImffv9tANYyJLTjsy91BONaKF9
X-Gm-Gg: ASbGnctfyGW0uxECzGTtUe2Lc6h5I42CYtMXDLqvByVRi8aC0Swb1+5D+IwJju8ibbh
	2NJWt1xCLIqq83fePltTkHgGI7fBfJT7u2rLia2TQ1ATbGqdG6HnFDamHVrF3DI4/73Dr1chR3N
	+BPJPqbzw57ujscdgpdSU2/Np12KWb3oPx5jdOoXTrKJP9qeO3gTrqvxLHRssO0mDo48CgY79uX
	PPsPYsc/EYhJNaQpzPggMBsM6H1pb2a1R6sbT1KahquA6M/18Ksi986knxV5m/t+iQbcTj6M/oU
	ByPpxvz329VqSeZdfc8pSyIsGshvmX60RdVuLSaBFvHeBFlYwDWXqmMd1QMG2tbI/KQSUYqGC7f
	6AsPZJtk8YjJoeHZgmicnHJuGOh2Z
X-Google-Smtp-Source: AGHT+IH+OdrCj38XEWkGd9pziFWciblrMgaMuuZmQdvkTrTBiUuSoINGNEkVURI9AfXRVP/j19Yd2g==
X-Received: by 2002:a05:6512:3d18:b0:55a:271e:9659 with SMTP id 2adb3069b0e04-55cc012c1bcmr2728378e87.27.1754902314728;
        Mon, 11 Aug 2025 01:51:54 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55ccc0617f7sm921690e87.166.2025.08.11.01.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:51:53 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:51:50 +0300
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
Subject: [PATCH v4 08/11] dt-bindings: iio: adc: ad7476: Drop redundant prop:
 true
Message-ID: <bee66444bf628ba9a34a02738a1842e2abc14290.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kiPr8Lj+77WZ/2pb"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--kiPr8Lj+77WZ/2pb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports a few variants with different power-supplies and
control GPIOs. The binding first unconditionally introduces all the
properties, and later sets them 'true' or 'false' based on the
combatible.

The 'true' seems to be implied by the initial property introduction so
the 'true' -branches in later conditional handling (based on the
compatible) can be omitted.

Drop the redundant true -branches.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v3 =3D> v4:
 - New patch
---
 .../bindings/iio/adc/adi,ad7476.yaml          | 54 +++++++++----------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
index d0cb32f136e5..db2a9662bd94 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
@@ -106,19 +106,17 @@ allOf:
         - vcc-supply
   # Devices with a vref
   - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - adi,ad7091r
-              - adi,ad7273
-              - adi,ad7274
-              - adi,ad7475
-              - lltc,ltc2314-14
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - adi,ad7091r
+                - adi,ad7273
+                - adi,ad7274
+                - adi,ad7475
+                - lltc,ltc2314-14
     then:
-      properties:
-        vref-supply: true
-    else:
       properties:
         vref-supply: false
   # Devices with a vref where it is not optional
@@ -135,29 +133,25 @@ allOf:
       required:
         - vref-supply
   - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - adi,ad7475
-              - adi,ad7495
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - adi,ad7475
+                - adi,ad7495
     then:
-      properties:
-        vdrive-supply: true
-    else:
       properties:
         vdrive-supply: false
   - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - adi,ad7091
-              - adi,ad7091r
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - adi,ad7091
+                - adi,ad7091r
     then:
-      properties:
-        adi,conversion-start-gpios: true
-    else:
       properties:
         adi,conversion-start-gpios: false
=20
--=20
2.50.1


--kiPr8Lj+77WZ/2pb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZryYACgkQeFA3/03a
ocW1UAf8D5iNCkNr6m+TmAyk99X0/5g13oGX1AzJmEbofesps1ngeLzlcOKYKm8G
Y4H1qQITwKJWJMsHRayIfakFtaKt52nu55EEZLXnzSjgr7cWHo7U/wBmb7Sb4Mu0
iMM/P58C6nTZjTwkO1o00V3tEhozU75XNh9I32OuZEOHKlJWuOKqCTlBys6sHvNA
niuXVaQbj2SIIeVoFXvtYMshvCyPUqrwviDEf/6I/B3Br7PGOJgm+sxY5pNi5PUa
fnx9ogQ8YyJBDSsDb4UdxBu8U1xrJYJ0vVQubwADKQCU5VjzlIn2uMp+N/sn4SET
S041kuOeDwXt6/EyczvNCa1tA6oWHg==
=lCOn
-----END PGP SIGNATURE-----

--kiPr8Lj+77WZ/2pb--

