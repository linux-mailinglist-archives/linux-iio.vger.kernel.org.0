Return-Path: <linux-iio+bounces-12796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F89DBC9A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 20:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EE6281CB0
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 19:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EA1C3306;
	Thu, 28 Nov 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbKlxkQz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF91C330D;
	Thu, 28 Nov 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822546; cv=none; b=AvLBkNqS7OVd3ZwkCKGP8FVOdmEeT2oMjbaeKxxHTE9q0iI4GiTSMmukDk9la5eBrf9AxistIq3WWxVnws4PwCVGvvgTZOPthEch+/J3liijqAWZBLlHjZlceLR7sqFmxOMkzXPzyoSdxm78bl8t9JsiEtvI3kQn9sX4FyOUlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822546; c=relaxed/simple;
	bh=Xs4SFrfjcojrKW38bT4vXTNI4FCEHpzH0vxdjv7Ksq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cC3q0raD4vW1Y4jecfcuJu2sPEcVfQLvXXJa1zKTQv9nr8L8Oc9uYHECZT4gTGDQS1Ec2zyF0yHZZWrQmXJWH8bEyTXcNMcPEU2PPlTdAbT0Z+3SZ2D1VvQxVFi1OtLsSxdbFjM8XgZbhDmTb4ZxXaTBnXELPEQp5iQCnAwc06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbKlxkQz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de84e4005so1333236e87.0;
        Thu, 28 Nov 2024 11:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732822543; x=1733427343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVqvoySSfVRyCQ8/4F08qojq11+dNqetGDv3YIIcEzM=;
        b=KbKlxkQzR0RpGsdq4EyRn1L29TdRJIgJ115poPzI7mv2yNA5fyfQ/RnD/+SOcUda8R
         1gL+TiM54svzfK9LcZ/O2PPlpZIpfMLcvj7eWdQAAfZ41Y6ns7VXahFBl2KhY6O5gTRw
         zOMQKxhldmdRZwIuxvj3RTTVPDpLH+o/pGCTKPfr1mRfk6hWNLVvhMPx4mTEPyycN/f4
         dYIS7QQqsLTkHDrsMZaZkcP0IX8d2r7MC+pYYarCL0aMLzdv77wVj1kxrFNwH7Ot/8k6
         7fz4KlHWXCk+p+Xd7I32pjyXXz4uY/Cme4PhzAAzJ/rhNhFgsgICZW19emFg5fG9q8Y3
         /eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732822543; x=1733427343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVqvoySSfVRyCQ8/4F08qojq11+dNqetGDv3YIIcEzM=;
        b=AVU1ixGwVvI0F8ZJyNx9Ttuacxkw2bNP35YXYaJITVQFuGPD2XydkOHrXaDAPi5ZXw
         yEt/6shM8MW2xBKZJeIaHcR400jSMZ8lDZtXLLoc/ns7k7uGid3QXOxHvaoRAh8+ML1a
         FTkFsKT+5U3eu5gnPasRlyahI92XSRUdy00+vGMujVmbvWwhqZjYEY+5z7ofzjSmyNEY
         HwRsSzShRF4roy7kz3WRptznuuelguWXh+dhvmEDg5H2FZPhRkWhQsqSNDn+O/UYB01B
         hiBnc4Qm0BPguPFvbxESuCLjRLMYAdTprkKoH1fgSkCgsV3lyYf5zLxn000EkFalzmhb
         60dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfuz02ourMjo6kfx3E4rWF5PCNYUR5JkAaCTkqbExiaT1yYHaoATARF0QRF50pX3Jz5USErQUycl1d0Vsz@vger.kernel.org, AJvYcCWpAofjzPO093C7I+eoYFg46iHr75Reql59qrDkKrgWBc5FwRQuGPbKSjQNcU0eg1uoFIioSwa7bTb/@vger.kernel.org, AJvYcCXA51hSZUMafZXzwdu2Rd0jLkLDdYPN0TZrkxkhhj9NSPP30roaWtJlYEYhHXXe9X7yU2wJz9c/6Pzl@vger.kernel.org
X-Gm-Message-State: AOJu0YxxBFvM6uTu86ygjjWNY0v8cZ0M32tyJdzMSAI7xTaqYIDVSmBT
	I0FVjDHKDlhRywBqaoBSyOCVy6eaVudvC6tar1JckcCN0sUbc4if
X-Gm-Gg: ASbGncu7+UZkB8XBjMd3CM/FCGXWVs93vJgbGT39XG5jOHAaJCfUBhW3AuRluoqgNuK
	mX2CMhNrQDZdJpmSvrozHaO3zI4GA4jF2EPVdNQc4y4r57U2NNgqqiVGuccBrhQJz1g/3/g8GxY
	JIVfqVoHsmggmtV7ubE4k1By5xjj7PDzIN2y9HYz0FWziOoN5xi690rQWcsvEzdhQZwX+9IiC7f
	DOUahXK6W4vL8wB7W/cTkmbkloKse96cr0kkaehMrqiZ9r+pMh5hU+B
X-Google-Smtp-Source: AGHT+IGGEh82zHrkBqKDiTtP5rk2nRwPjhtgMImYbycgLEFg7XtV4wstndyMUD3rfP+y8ANbWyGTOw==
X-Received: by 2002:ac2:4884:0:b0:53d:f0ff:d244 with SMTP id 2adb3069b0e04-53df0ffd256mr3687125e87.22.1732822542620;
        Thu, 28 Nov 2024 11:35:42 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f106sm261905e87.131.2024.11.28.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 11:35:40 -0800 (PST)
Date: Thu, 28 Nov 2024 21:35:35 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>, Marek Vasut <marex@denx.de>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: light: Drop BU27008 and BU27010
Message-ID: <3be66a8ec15fedd18ef13afae48ebb182196da13.1732819203.git.mazziesaccount@gmail.com>
References: <cover.1732819203.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MVxgxlU4J1FjKlu8"
Content-Disposition: inline
In-Reply-To: <cover.1732819203.git.mazziesaccount@gmail.com>


--MVxgxlU4J1FjKlu8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27008 and BU27010 RGB sensors got cancelled. I was informed
they never reached mass production stage.

Keeping the bindings around is waste of maintenance resources. Drop the
bindings.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/iio/light/rohm,bu27008.yaml      | 49 ------------------
 .../bindings/iio/light/rohm,bu27010.yaml      | 50 -------------------
 2 files changed, 99 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2700=
8.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27008.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27008.yaml
deleted file mode 100644
index 4f66fd47b016..000000000000
--- a/Documentation/devicetree/bindings/iio/light/rohm,bu27008.yaml
+++ /dev/null
@@ -1,49 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/light/rohm,bu27008.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: ROHM BU27008 color sensor
-
-maintainers:
-  - Matti Vaittinen <mazziesaccount@gmail.com>
-
-description:
-  The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
-  and IR) with four configurable channels. Red and green being always
-  available and two out of the rest three (blue, clear, IR) can be
-  selected to be simultaneously measured. Typical application is adjusting
-  LCD backlight of TVs, mobile phones and tablet PCs.
-
-properties:
-  compatible:
-    const: rohm,bu27008
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-  vdd-supply: true
-
-required:
-  - compatible
-  - reg
-
-additionalProperties: false
-
-examples:
-  - |
-    i2c {
-      #address-cells =3D <1>;
-      #size-cells =3D <0>;
-
-      light-sensor@38 {
-        compatible =3D "rohm,bu27008";
-        reg =3D <0x38>;
-      };
-    };
-
-...
diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
deleted file mode 100644
index bed42d5d0d94..000000000000
--- a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
+++ /dev/null
@@ -1,50 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/light/rohm,bu27010.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: ROHM BU27010 color sensor
-
-maintainers:
-  - Matti Vaittinen <mazziesaccount@gmail.com>
-
-description: |
-  The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
-  IR and flickering detection) with five configurable channels. Red, green
-  and flickering detection being always available and two out of the rest
-  three (blue, clear, IR) can be selected to be simultaneously measured.
-  Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
-  and tablet PCs.
-
-properties:
-  compatible:
-    const: rohm,bu27010
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-  vdd-supply: true
-
-required:
-  - compatible
-  - reg
-  - vdd-supply
-
-additionalProperties: false
-
-examples:
-  - |
-    i2c {
-      #address-cells =3D <1>;
-      #size-cells =3D <0>;
-
-      light-sensor@38 {
-        compatible =3D "rohm,bu27010";
-        reg =3D <0x38>;
-        vdd-supply =3D <&vdd>;
-      };
-    };
--=20
2.47.0


--MVxgxlU4J1FjKlu8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIxgcACgkQeFA3/03a
ocV/JggAk9824aOuKNeVxBwnkL8G7UNWUViqkEVLaZJzOUL+slcBOkefooghMfaV
l6hkZ+oCa0F+oC09i5P1y1eU0cibvQd/aLmN+sFLbLxl4IJLdEBByRnivazXwmVT
OoRVOfyobggR06aaNNQbwwnMZ4YQIq57cYZWdMk/ciFRnCD0IcNSycZM127kPgax
GdDrvj+BAXY0aJ0tDGRSqtEahwRPHEOOnA62dcbqz21qiKfKE9XnSYmlltPZPfO+
6famMSGV+sipNZDDo2KjH4kQPrTH2Dw/xewF2T9E1br3c31u1JnnTCPE8rZQGIPJ
RotxV7ebjnAkGBKP4YsutaNFdy8RNw==
=ht04
-----END PGP SIGNATURE-----

--MVxgxlU4J1FjKlu8--

