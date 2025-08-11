Return-Path: <linux-iio+bounces-22551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A670B20253
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE9718C0171
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3B22DCC06;
	Mon, 11 Aug 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH5jB4fF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA6F2DC348;
	Mon, 11 Aug 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902333; cv=none; b=B/jY99WUNZJVJupoGK2jyipfjgiyjIYgMYbfqpK3Wjat+kyRP2HvP87H4Me4mgtIIgf4e1BzSVlHSJDaO1+uBaTwty5mj71pxHAFB84yE+nYCz9kykhNP1cMbPhaYgb/3/P2TIm39PyDcXBnXrzP4OTjYxEy7BkbXvbJpoM/tLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902333; c=relaxed/simple;
	bh=B98h9SMmWcloGfwByr1AEuZtlWL2J4qIXk7HFzhUve4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuKNwuT3lyuMmx72JWbvfP9eu2bA+HKKZ9vU/IkLqjfGb6Qg5JA1hu1Qny2qmbmBVoyk/wIl0tRP5EuP6E9RDTOc5TiUAsnEHA7zXcWpxHhUnNQIxJPFdNODadsA1Tz134D9XW44rMNEeOU1OvB97X2e3tnyHHYqbAOFjS8bIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH5jB4fF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b827aba01so3656832e87.0;
        Mon, 11 Aug 2025 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902330; x=1755507130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHAtfrRtxvHEtP10YJKiS8okB/LBMZppG4BpJwJGUnw=;
        b=YH5jB4fFMaHKl77n4g/bIunfAcxyd29Vvj4w/IxzfWINsXWwfM7e4GraahLjHdSFlB
         8ohLPyVfSleEsPZJhcIiDLvHXFT5FmRajlPQoxuLuPoJZ0eCnN/abP7ddk7efdDfoHfs
         vYqjgLhdcXNT2CBFk2oKLd89opNGwu/QS4xMel/Q8jlmu203pzJNn0Hn47XVo6vJXA1g
         FDKqvGYUQeCaMgXgAOpYt7uuPvCR5dwjnDqHTthnIwJDt3zic/c8QG1HsGng8LN+f3wC
         SujeBnSWqhJnrHtWHzz51kFnR45oWsKjGHjc+Xf/UgjbrXla+P1ltNrxfKy48yMrKyHS
         NwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902330; x=1755507130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHAtfrRtxvHEtP10YJKiS8okB/LBMZppG4BpJwJGUnw=;
        b=Hf8HEdTSDIVgUFlWWLLYRPPwTOAsR6jdUhP8xr/QeTCr7VmaTna/f+hf3SI9otlbxU
         M6UchWZSgkQWfEv+QyQIjGSck2qeEfXGBDoEJ8Y3yfkN7K3d5ZjTrMSKJBiE0GXxdbIY
         L+jTiTEAaC8dQ+Pqm5qFj8AyiGmOxay7wlsEirQz5pSku6GNelZnUS7y3Gm92VPMGPkD
         b0ZXKm5PlfUeQPm3xzvjBa4t4EcmVa1T/Ztl+hUis4M77SUWT06x+bj/ZHzwc6972sAa
         E6RNbkYbSifiU5HCfM3Vg2p2g7iz3F2CWVE59P5XeNx5YpQ3+0//eIvvOrC8EO7MQDek
         s8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU9rnHaJz96gSi2QV3/w7bxr2ynWREU76WZ1elWm6W7/rU5+X7ebtwMYz7vTRVDH1bGqNQ0W1ZIjIYN@vger.kernel.org, AJvYcCVpBfl2tPtqc8iAKk+Xs3mtV/kFhQDa4rmAT3XA3ZOwOfLpuA5H/1hzSfNplKeJHMWvQ6U0hAUvMK7n@vger.kernel.org, AJvYcCXgxPzW0bXarBhrviBXSHQF4ENTn3qMQ1mjIYp6B1yS9ydWELyIYjH/Dc/MOTm3pb/3TeBfjHH/kHDP4vBm@vger.kernel.org
X-Gm-Message-State: AOJu0YwW6qUOY9ds/j0pJk40b4C3NDS+M4e9tCwl68OJi5jXv8Y3H4QN
	F29w1tbx3XqqfXjeZyxARpptew4QIrLhG45KVdvdy15CT3gvlHzRg7lB
X-Gm-Gg: ASbGnctwQNguYLCkrQrgbTKjzIf7UO1p9IHn3JskbdUZkt1/78NOHlOpMFFz/u8oFp4
	pfMTRFmF3UGL34FzWtcQgwZs2LsMOVqeu6X+p9Y/EHnEx1qdpeFRag/qXy0xOKlwp3DJasVaFQr
	38WkHmq94Letu+fL80uJmQIV4ZymF3iFdGc3Upawn0jftw+kXzLOC+5d+n2HCjSGD4M88EizvHS
	RQGN8gpIvpw6Xu8W1NpSLFuNC46LCvxHqXkAhPlXmzd48quG1DHorqr4+4q0mdhVAhho6G7V44P
	vAD6tBZUWghZpjfrVsy5JBCW+8C/a48M0iLue2loxBbwV8ml/2S3lzf8HGLUtWbfCv7Ep2kUR9l
	SDVzsio2kBLx68b5lbAB0djBIrdhB
X-Google-Smtp-Source: AGHT+IHJvr3yA1Umn1PLWqFR5Gf0Le6R1ieFJ/vZAuD2ftWoR6eZ7Fj7BFMa8ZFNacZzpAr5kPiMhg==
X-Received: by 2002:a05:6512:234a:b0:55b:9647:8e75 with SMTP id 2adb3069b0e04-55cc00de0famr3163000e87.15.1754902329705;
        Mon, 11 Aug 2025 01:52:09 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cca00f74esm1006099e87.65.2025.08.11.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:52:08 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:52:04 +0300
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
Subject: [PATCH v4 09/11] dt-bindings: iio: adc: ad7476: Add ROHM bd79105
Message-ID: <3f70f68665225be3091f8a0412e74037b6a2a88e.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4smEFqmVtnc1ZMXb"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--4smEFqmVtnc1ZMXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79105 is a simple, 16-bit, 1-channel ADC with a 'CONVSTART'
pin used to start the ADC conversion. Other than the 'CONVSTART', there
are 3 supply pins (one used as a reference), analog inputs, ground and
communication pins. It's worth noting that the pin somewhat confusingly
labeled as 'DIN', is a pin which should be used as a chip-select. The IC
does not have any writable registers.

The device is designed so that the output pin can, in addition to
outputting the data, be used as a 'data-ready'-IRQ. There are cases
where the IRQ can't be used (because it is delivered via SPI data-line).
Hence, some systems may use a GPIO for polling the data readiness.

Add a compatible for the bd79105 and add the data-ready GPIO to the
binding.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v3 =3D> v4:
 - Drop the redundant 'true' branches
 v2 =3D> v3:
 - No changes
 v1 =3D> v2:
 - BD79105 can provide data-ready IRQ (or GPIO) via DOUT-pin.
---
 .../bindings/iio/adc/adi,ad7476.yaml          | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
index db2a9662bd94..55880191c511 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
@@ -41,6 +41,7 @@ properties:
               - adi,ad7910
               - adi,ad7920
               - adi,ad7940
+              - rohm,bd79105
               - ti,adc081s
               - ti,adc101s
               - ti,adc121s
@@ -55,6 +56,11 @@ properties:
   reg:
     maxItems: 1
=20
+  interrupts:
+    description:
+      The data-ready interrupt. Provided via DOUT pin.
+    maxItems: 1
+
   vcc-supply:
     description:
       Main powersupply voltage for the chips, sometimes referred to as VDD=
 on
@@ -75,6 +81,10 @@ properties:
     description: A GPIO used to trigger the start of a conversion
     maxItems: 1
=20
+  rdy-gpios:
+    description: A GPIO for detecting the data-ready.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -82,6 +92,20 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
=20
+# Devices with an IRQ
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rohm,bd79105
+    then:
+      properties:
+        interrupts: true
+    else:
+      properties:
+        interrupts: false
+
   # Devices where reference is vcc
   - if:
       properties:
@@ -116,6 +140,7 @@ allOf:
                 - adi,ad7274
                 - adi,ad7475
                 - lltc,ltc2314-14
+                - rohm,bd79105
     then:
       properties:
         vref-supply: false
@@ -129,6 +154,7 @@ allOf:
               - adi,ad7274
               - adi,ad7475
               - lltc,ltc2314-14
+              - rohm,bd79105
     then:
       required:
         - vref-supply
@@ -140,9 +166,23 @@ allOf:
               enum:
                 - adi,ad7475
                 - adi,ad7495
+                - rohm,bd79105
     then:
       properties:
         vdrive-supply: false
+
+  # Devices which support polling the data-ready via GPIO
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - rohm,bd79105
+    then:
+      properties:
+        rdy-gpios: false
+
   - if:
       not:
         properties:
@@ -151,10 +191,22 @@ allOf:
               enum:
                 - adi,ad7091
                 - adi,ad7091r
+                - rohm,bd79105
     then:
       properties:
         adi,conversion-start-gpios: false
=20
+  # Devices with a convstart GPIO where it is not optional
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rohm,bd79105
+    then:
+      required:
+        - adi,conversion-start-gpios
+
 unevaluatedProperties: false
=20
 examples:
--=20
2.50.1


--4smEFqmVtnc1ZMXb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZrzQACgkQeFA3/03a
ocW+MAf/c0SJwuqK9VCRKllFME9CYIWHVkfsQYnlrpOTBbp4oJIslbfxHg+yzLLR
UL2vNYmyXZa2fRTXq4czwpOPPWHGQY205elfSzsL9pp2LfNH6GoYlDegAk4T7yjz
23WvgSFENAJI66hkcznPv+1+5jArfWqkLDGCtunNoMF2R8nwLFWWDZyKNWmZ+7TO
9ZAHPh1dBnQARgJOhesJrrCKfe1e1XdYZrN3VpG7hMB5YspkARZm0VZSwPej0cOi
QVHsXL9x5n9foFP4hdheVAMCmHf6QY/UMpuRs9Ah13OtXwxnu1mgoqAh1hDErcfK
Rmh9+xqSOJtgPrbMPapF5hcxI2ypyA==
=rMHU
-----END PGP SIGNATURE-----

--4smEFqmVtnc1ZMXb--

