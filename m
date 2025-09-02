Return-Path: <linux-iio+bounces-23633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FA3B4008C
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93875E1CCB
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 12:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ECE2C0266;
	Tue,  2 Sep 2025 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsEY8DXI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5D27A124;
	Tue,  2 Sep 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815845; cv=none; b=sULdPUHyurvQAikkzHVWkkrAXWODuCJDm/MFpkEcoihw6aGmx3tO3ew3wqhRcKUMYYvIOHdZJ8DfJyL//sr9x1eYS7dh4Knl0ie0uddvYtOtyOmFAiqMCGjV8pgkycsLHJJarUrKQ3xc9spBkHQ/goV/Ht/eK+z47tYY0MQQLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815845; c=relaxed/simple;
	bh=otAvF/42ChB7v7oe9K2BFoeiIddL2pnRaVhuxUZFr+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYnnVyIEUG7gmIxmh8CcnlufffjZ+vA/Z49NxuOukota2Kkc2QB6Jm56WBice7AsihYAwqyvIrVj8wvoqGE3JeM+Bq+QyaHKXAiNj7PTuiZLV/rryhMA62pnNOVf83EAclfVk3c4+FbLgbt090QmlaEHldHy7NKX7GEfwh0KIvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsEY8DXI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f6186cc17so4253798e87.2;
        Tue, 02 Sep 2025 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756815842; x=1757420642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqnQxt6oxRV6JdFg9gzzJQBDn9rcHdxloxXVIhYBipk=;
        b=IsEY8DXISxqmzePsxxHlCuXjhCBRdvDt3/c18v77MKXUGVPhBqH9P9yns4vP1nw2Qv
         uxEwykxT463pZ5ifKqtp/XU/0FilNoLYo7nVSOk2BDS4bRR+zwPFzcYVYPS5Acl3ffsw
         rkxKtuSLXh8NIxPvdCPsjSa858sZ8RYxaJ8qLK8MOPinUnyVB3YV1uHvRUYozMSEzwUD
         WcuWPfnyYquIoDtgWx3saoM1xvAR4t8KQrA0cdIoZ4usoZXAMJQAJ2y4/zutf6+VHQCm
         gRNz46vqn7UYJBDfgRO0uMZGf8vyP3fvCaXREHAF1qdkDeNQLyTp4Kh7DwieRAlaXipy
         FLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815842; x=1757420642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqnQxt6oxRV6JdFg9gzzJQBDn9rcHdxloxXVIhYBipk=;
        b=eVeBiiwiS1eM6LPOkvB/RK61+9/67sMEj1vbE8T/MJaFSmQc+2qeDy+7QeP0wPScXE
         kUD0QddKdc4WYHZCZ54klW9ytP+wDI4I8DHj52mQucKhyp3bghGbCtqKof2tQ+9AYPVz
         b4o688DuThvAChoDKEK4IVNpFuM1xKroPVl+RyM8bgnh2KkQNLzmv/P9PRtuVDt2KLfl
         foz2Gi4jtXDHwi0XF+J2j8FSGQsQ3JhQuyw5zhci44lPc9IoRiDcE4ga/yyeEYZj55kU
         QlKJgMbJF9ict4MYcFbSUJvs3A2q/APIbsu2YyN7cWtcFgFFJL+Zr6APa1YHuYYVn3kV
         IH4A==
X-Forwarded-Encrypted: i=1; AJvYcCUx3YWhYpE4jvnSwSlVz/3+xX2j9mk+pmZEnYNBp3J9eMtYS8E50x2x/sDg0W3yd1tZUUwEqeNhejgCN5M9@vger.kernel.org, AJvYcCVC/xwUDe40byl1IwW5YZLd3T9FhdiyMRDrgMdZW+i531+E/G/nrkxkwmjpTf81rYgTRAvi+Z3shnjs@vger.kernel.org, AJvYcCWcU6Z1HPwsv4CpX9lbikNIvLegTWvE0TchardPbs6+jZlnvDmyQbSZnvirV6vm66c4z7kvbgOcv3W+@vger.kernel.org, AJvYcCXy0pHBS5NFS3QuqS8aXFNHWv2GqmKnXbDxSDbXT2er+W0KUKcxewSJHdUzZd7nqI/bEtzkKL+etWN6tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBXFVb9Ru1oLsJgh06D3aABqFh36dPJ1oHhYPvAiLr8bgYtAU
	jEaEQw8V6kPsI4JKIddawOMsEzpNFuFypDeLDc1SD+0bqf/nq4O1R3/F
X-Gm-Gg: ASbGncvFkoGGWGPevySvmEGDdCZLR0LSnn2vwjwWvK74eaeOM9VGOca46liR7wHR4Eg
	kPu4hgmqjpUjiNawdAPePOTtMG3pZJDcVFbMigCwKdU5GmcMDSUn5al+WO30Mzng0sE4Quw0fx7
	lr5xQ8EK6GgPV6IXlFl5jOV44oCIaqXXGmumo1uf/0Dau8a/3FRbb+gwUa4fdK0kHsN5URhEmIw
	AiCUGrYrYoIBVVJuFjyGMF/U+bi1oOynv7ghD6cFjWkwyWfrXrsHAUKqu16eJs5G6VDYZ4A7tV7
	dMNIIkaxJaXBKA5ggYWHZr1cPhdAwKpCCJOYZMtmcAEXq+CWEZflTrfvQqFO5N0UQIYTLg0DZer
	p8dPsxp6/jWlUdaV4vKLS259jPg==
X-Google-Smtp-Source: AGHT+IF0oRwG/YCSkiJbr75HCBX+hLvTKsEO8zM5DMR16P1q6J7acgp0iDNYTrHJGs9skRD77JPaGg==
X-Received: by 2002:a05:651c:41dc:b0:336:9fd5:2fd6 with SMTP id 38308e7fff4ca-336caf7c3bcmr26299811fa.24.1756815840067;
        Tue, 02 Sep 2025 05:24:00 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c50f88sm4387551fa.13.2025.09.02.05.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:23:59 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:23:54 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
Message-ID: <77c36ecaf5992ebcabf6ce862bf2a6ec72d9f606.1756813980.git.mazziesaccount@gmail.com>
References: <cover.1756813980.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tl6oCcfwafGdyC8p"
Content-Disposition: inline
In-Reply-To: <cover.1756813980.git.mazziesaccount@gmail.com>


--tl6oCcfwafGdyC8p
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
---
 .../bindings/iio/adc/rohm,bd79112.yaml        | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79112.=
yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
new file mode 100644
index 000000000000..c340a05fbbda
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
@@ -0,0 +1,118 @@
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
+
+  "#gpio-cells":
+    const: 1
+    description:
+      The pin number.
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
+            channel@3 {
+                reg =3D <3>;
+            };
+            channel@4 {
+                reg =3D <4>;
+            };
+            channel@5 {
+                reg =3D <5>;
+            };
+            channel@6 {
+                reg =3D <6>;
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


--tl6oCcfwafGdyC8p
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi24doACgkQeFA3/03a
ocXwXgf/YrBxkSf2PjK8NQ0EGq8EPTQOX/KLapX0ICGGJOPSNHAGSvuoUImyxwC4
aoeoqAGoAegynOZsITfcuS50kkx6C6cEcwk2uswIKB2qhuCSR/WHyGs6D2J75x6m
lj9gMUGGLjZsc94njLD4nxDP1KqdYL++Ir/llOBYJINod6CG0perT1M7ttMFswmL
/c1X7E9cdBUUMkDChKIbxaHiKZOpY/AXu0q7LPa5Ynd9Bnmz5ypAYkVrHCCs8fAz
f0kUmVlcu88qqtsjm5QHMqvy0sDTiBgSpoK+QtHm6RnPd0MyCqMFN2cb1c4Zjtig
T09gDC9Cfl8gyUmQVe7wiJGzyOzihQ==
=e4mD
-----END PGP SIGNATURE-----

--tl6oCcfwafGdyC8p--

