Return-Path: <linux-iio+bounces-23930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B14B5156B
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E681B2871C
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE33064B2;
	Wed, 10 Sep 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYPyBuF3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE927B343;
	Wed, 10 Sep 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503455; cv=none; b=duojfEBqKMJpgx8w5MYvMJ+GSbal+cDDyG6fa2/Yn+N1BX4WCLzcPjx+ebJ2mkXBe4NN49JaEtVLTpp5H3MUhI7Ff781jDkIdsLuTc86izoFRBXnd67ex/evCOyLyQt+9zX7a7xkSsdGoVwRvyCL2Dix2tUHkAtotnAmNrB+ggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503455; c=relaxed/simple;
	bh=wpa4q3p3EsV3E2H05DNlRQHr7Fm+gWL/8Zz+03Rmda4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9GJDfGn4iZmF7bfRUYD+JfPObjQNwyE7XAnsMCT9R4ulXC2FUl2S2Dqs+2DTuyn6ujeEZ1O18uRmj1KtEQbuhE2QmSuyCozThWDsRLetNcy0diLKfAWuq36M1Too2G2Mbo6RAJt83InWjFtaOvdW4IEBIiNm7BlxGsnjRhBloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYPyBuF3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-56088927dcbso8199250e87.3;
        Wed, 10 Sep 2025 04:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757503452; x=1758108252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KR0vKP+eM32S8H3L31SnWgV0UccCcsyZbHsgICsXzec=;
        b=gYPyBuF33avl4oJk5rZ8IQPgDo/Nvq3kpb7OZ3MkrUy7GKBTBHD/m9oNWkgYI82mGq
         DEbXF2anoYuQlaccKc/LDzm4UEHgqT7k03/cKlzLdwVZzlyHhOBvgzRrxNKq68iaUoqS
         +skvyCOdzEtE+kRx57K7c7JStkzIZWw4J/TK4RPqavZlVhBG2BziAsBl4w/WLA9Uorih
         zl7rxl8qhNgZsl7n7OjAcWSEsitntfYO80Pi0YDBuq6G48uzx46ko57s22+0bBQ/3qQ5
         RNZVlQQiqSdb4MetUQMcmoAD3XShxjVAPSiLyYFjoK1PoqxSTqw5MmlO6Qk1JqOnvtQg
         0a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503452; x=1758108252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR0vKP+eM32S8H3L31SnWgV0UccCcsyZbHsgICsXzec=;
        b=aiAN6iwo+QA+wGvA97QYE42MTwCVgzqJfO2qJ0fRC3tiX1KaUYdk3UhUT3JnVoiFLB
         EBwV6xxPUE9lXFNO3hhAphtvIiU2tMYy2NmJvqJqZEPdrnqXK8G0vUFBV4W9g0TxCfNR
         rATSD7n7L33gP2veXzpR28vt2XVazQ8FJkhywUqjYYOKLOnBy2ux8hQuBQGzqgBXpnfl
         odyYnqbtOA4G3XB7fJtn4QErOvG9nKCwbvvZ7XRLWOb/BvadynK9BVAHtzMaonAB2g+s
         wmqzv4cpT6wtjmYz844Ds0HykQ8xGARzANlkX8qkgsFqDA7xGBi4+PNxYsmcus+IEN4w
         Q9Og==
X-Forwarded-Encrypted: i=1; AJvYcCU1zGrK1qkEyISK7ObRUkFNGM19LQCtgEuhkA6PQ1q0OILFaGCkFysjTebIfRt9KHYr90XiJPxgwlMKTRqo@vger.kernel.org, AJvYcCVH4BEC5QpilXLAPW3MiPdeDmBBBWGV+SZJ50uPL0klZkINWxk5CCE5YXg9te2FGQLseJgbLaAx6eyI@vger.kernel.org, AJvYcCWn/jCdfIPef059Rtd7XCkJB34ofMDZZ+ozbvLlYdmsw4kTx4rOphQGrvJsfrlsUS+4cpzkw5fbuOZDLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfTnxQOdbIY634zEccC0e9GotgjtiD/STXsr9bNFP1mhWo1Rz
	9+so2CJaiTKu3J3gOABtmXog5+ZviqYhToR3Z/y6KDB7BQauH8IybO/e
X-Gm-Gg: ASbGncv1sjm2LqosZYj+ha3Kn3Wgr3IVY6NH10UDmJH95OL0ZfyQtd/116gRFExJKtY
	IM+UEGwRxlIFKZjWCvqpN7CpShtv/7wTF7eA5qWXo7tPfRVHbpOZ1UbeqtGT7prfFDS1J8pUZD1
	V/XUu8Bb3u6vIevxl2OSbs/elVlHxhuiT3c3IdNlwM4AnF+N0So9CFD1SxcEvKdw9UmnL8GZ9+r
	17GuTueRgVHetjPtF12uA7EyNxNnOSZbOs4BBsp3PqL1+qOfIU6fc1ty6NJ9ggitCT7u/58w40R
	y78ZquSoCdiCZvkSQ/Hm3jtvpMVQjYqP1H2Z5o2r11oxvonPyhtry6JHq9AJIop6v6T0gyATiQ2
	9zKZi0iQXvQkkasII+ZkuqBJuiZGu7ojuEzOcidJh
X-Google-Smtp-Source: AGHT+IHKpvMa5s3+nE++NnYM74FEMfo148Wo22o6hH1L4tcWnAgaSlMeUWd6jpdX9ok88HTMFIHukQ==
X-Received: by 2002:a05:6512:63cf:10b0:562:1159:5161 with SMTP id 2adb3069b0e04-56261219d12mr5013712e87.31.1757503451427;
        Wed, 10 Sep 2025 04:24:11 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c8fa580sm1203749e87.42.2025.09.10.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:24:10 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:24:06 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
Message-ID: <20250910-bd79112-v4-1-f82f43746a8c@gmail.com>
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i2uIKOJtXFbDDFSu"
Content-Disposition: inline
In-Reply-To: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3384;
 i=mazziesaccount@gmail.com; h=from:subject:message-id;
 bh=q+PdYztni/yNFMmXAS+zMK1I2vs1JpjrImQBvaSjEjs=;
 b=owEBbQGS/pANAwAKAXhQN/9N2qHFAcsmYgBowV8JqVxxxYSX7+PJuHZntJIVa9yWGALHeMTQy
 wD/t5kHDA2JATMEAAEKAB0WIQQjH5/zBlvbx8soSFN4UDf/TdqhxQUCaMFfCQAKCRB4UDf/Tdqh
 xVieCADUYkIlMiSWqkzfYBevobhIjXBuoDQLOk014GlSkhC9UQiEgYEmtikzZsGw9x/LGOhBqvH
 15kkDoKgn25lnSavUYaSnzZ2chC4RJl248Dq9KPOTdO8BmYE52dugfwFTpGkjIAWw6JRa3J6NMD
 R1B+YZyd/+cDR/SzJorxrBUHcCtwNjyHd6O59bfuNczH4V4oWvwlpNxMuluMGHxxTXNcxJUWIce
 hAWVdeqKyAKj/ZwYhHBc7et669lp2U/bGKdFTQ8cEr4BAgMQWJjSv6KKG4FNOIpGSst0XLC/wAL
 pW/VOLRowc3CB+EjtRw38QGadWvQyIYVaWegD2GBy12dWQtH
X-Developer-Key: i=mazziesaccount@gmail.com; a=openpgp;
 fpr=83351EE69759B11AF0A3107B40497F0C4693EF47


--i2uIKOJtXFbDDFSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.

The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
daisy-chain configuration) and maximum sampling rate is 1MSPS.

Add a device tree binding document for the ROHM BD79112.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

---
Revision history:
v3 =3D> v4:
 - shorten the example by dropping some channels.

v1 =3D> v2:
 - BD79112 can act as a GPIO controller.
---
 .../devicetree/bindings/iio/adc/rohm,bd79112.yaml  | 104 +++++++++++++++++=
++++
 1 file changed, 104 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..aa8b07c3fac1096c0d48ec64361=
263624f2bb9fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/rohm,bd79112.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD79112 ADC/GPO
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  The ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. ADC input pins can be
+  also configured as general purpose inputs/outputs. SPI should use MODE 3.
+
+properties:
+  compatible:
+    const: rohm,bd79112
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+  spi-cpol: true
+
+  gpio-controller: true
+  "#gpio-cells":
+    const: 2
+
+  vdd-supply: true
+
+  iovdd-supply: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@([0-9]|[12][0-9]|3[01])$":
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description: Represents ADC channel. Omitted channels' inputs are GPIO=
s.
+
+    properties:
+      reg:
+        description: AIN pin number
+        minimum: 0
+        maximum: 31
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - iovdd-supply
+  - vdd-supply
+  - spi-cpha
+  - spi-cpol
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        adc: adc@0 {
+            compatible =3D "rohm,bd79112";
+            reg =3D <0x0>;
+
+            spi-cpha;
+            spi-cpol;
+
+            vdd-supply =3D <&dummyreg>;
+            iovdd-supply =3D <&dummyreg>;
+
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            gpio-controller;
+            #gpio-cells =3D <2>;
+
+            channel@0 {
+                reg =3D <0>;
+            };
+            channel@1 {
+                reg =3D <1>;
+            };
+            channel@2 {
+                reg =3D <2>;
+            };
+            channel@16 {
+                reg =3D <16>;
+            };
+            channel@20 {
+                reg =3D <20>;
+            };
+        };
+    };

--=20
2.51.0


--i2uIKOJtXFbDDFSu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjBX9YACgkQeFA3/03a
ocXwDAgAhmqpgYoe1oSwMCnUa9QqWoYyrSqjCKIYpv6nqIrQlshDXlT4XoQvomuN
vvyvlg1b5dgH1HYEKBEJZYIzBhon3DwHIjCBZSY0MRdRklNgAw43r2AyTl/u+FRI
Gz6LDq48x9vXKXnphXz0dGh5g0DVJfJLXLsIWmLDEcTlvjDqRRQaKXh7QWdg26w4
IG2k0OpiXPIMTrr0JEAF664RvDVsMMAX+rEJwSv1mhkMbFeZlCJd8ZIgwnxyGldS
ljtScmxE+CXPEKK+qNoEUJDJWItl+lFVJSfjVAZ18KjnvshFkdk3h5kzyuv5f1RB
DlTZ+aIrS2nx90MukjZCcXqlPBnBFg==
=t8za
-----END PGP SIGNATURE-----

--i2uIKOJtXFbDDFSu--

