Return-Path: <linux-iio+bounces-23733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A2FB44E22
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B061EA4019A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 06:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4062C08D9;
	Fri,  5 Sep 2025 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpAx+ot4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC162AD2F;
	Fri,  5 Sep 2025 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757054547; cv=none; b=dn1NF6QlAB2jbyeqkjq0pMHMXiYVd8KIUlcLzMUBuEXvoGhtKpnXcPWzy/3CWdsGmQ+ihX8n5Lt9gyLsfTOCODf+9enocS9bY4lU0dZFP4HQ/eMzaEaZpTAuXet+XtRa+aPgwj7uVtoPO5XOP+Irne+E5TsqfcEkMwYeNNdYV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757054547; c=relaxed/simple;
	bh=lKXtA4GySFOMc6ieLpM8V6NEQPr1DTX64d9uqElbcvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJN50nK0J5xCpYS3aUDn4HUVePRZEw0+auyHo6cVgQXwjw6gtz6/V99c6uSlPP24lpMdxkV4jE1TM4gtHPGcnosAJEfl5bUmztZq2A0iTJKz/9UukKlZRZiT6Yo7Ihh5BX1kG44KoaJyHqPo9edCLw1o93/SqQ7EvJa1rSdTtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpAx+ot4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f753ec672so2021667e87.2;
        Thu, 04 Sep 2025 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757054543; x=1757659343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyAUcTRME0EUwXHHSqQ1v3rEyofDfzA+4Kk7rXlPvOw=;
        b=mpAx+ot4USJq6Rkr3cdu8Wcgswy8mQG6G5Km/dfyYCc/2/bJE4OVoj9RviTxL4/j50
         tNHYshJ1mKOeobwIx5daEsGInLJLRkG/ovixTL4mJWCVOvyq0KkszO+B9/5NS5tNUbx3
         IBNiqzhVEb/lM3AYhA7+YGb4RR5wQELKJn1BEgXvorkJo/wl44KHmQ6c6RLouD3t2BrD
         GPeuxe0u966NAcAQGNIzfa+aaxiW+EQ9LtV1EG1+fNAPVKIu9xttD4F4yxwb8kwO3IEn
         gXOwcJHIyfb4wYbFtW6Kzqnhdww7wiXvLcSDraaVIp9tOcwaMNiS5kS4CWQcq8aszfxT
         CqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757054543; x=1757659343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyAUcTRME0EUwXHHSqQ1v3rEyofDfzA+4Kk7rXlPvOw=;
        b=MYYTQG8ezYH4OntEtvW1FU3cGhvflABUogs8ckU1kr0mebpKqivgAcgf6qyAhFfFfx
         T39qouw0YTUxVwEpFSkiuhYsRDCv9ZUzE3gnL9XjM1F0O3C3QI8+3e8gFfJDZL6R3umI
         voLZwnV5fNWxc1JckFMB4DoXkA/0xj8gj/zp3quF22Iz+7Jf8MraCXwMsvhOVqQKDj3U
         IsReaLKFD4yymsDY57+ISlQ6kuO2Wjbr01cSe3yslU/mat+KUpk8pj6q9wIlSsu3yAXM
         9xuZF2m8l6ZZXwlRmaYJmbnGtwsZDk6ZTwf4Ptb9BrO1SE7XD7eH8lfZfL0Y2Mp3oCoa
         xq3w==
X-Forwarded-Encrypted: i=1; AJvYcCWSjs/rz50avw6hDS3ecVDf+2NZ5CEEISeBUFIvfYZBUK5AXuMlF3UgOwvlQ+CH0n3R87G2kRkaoVTy@vger.kernel.org, AJvYcCWhh7W37mO84bSf6h+3pOd3HNppxMRSEIZI+aFRevo6EY/BgxpI1sh981+NJqqaYWTnyoCtznnrC76/Iw==@vger.kernel.org, AJvYcCWnCh7gI7j7e8hRSd4MTe8D9sZNguyUvUhq+9sFipTc7DLEby/demgDgHbdfqjaI/W0BFF/mbVXn4+j7D5D@vger.kernel.org, AJvYcCXVS2EcdL0kQPyWdUdGq9oLheG1WCYLggiKfEtzXXUNMO61luFXSE83PulEuV4PaTebQklnLNNRIaeP@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQIytcUwyimJcv6/QR9jjt/l4RkzZmKWeCNnVLkwOiGPYn8Jp
	+bq+1jLwafQUmU7qk+ILFNn8lFXQJ7qyfq2qEeHAmV7pNhUhbHKSkIAQ
X-Gm-Gg: ASbGncugWIcvkHuuUpLciRSt15Zm4UjHJSQfcJe6mlu+vsyN+wehjIYueEd8I+x2wNQ
	E18fXhopK09pZIHvkyb6F2AuUeBg/cA3BJZk4CwgNETOS7dvIHQOv4c/fx4QI+/uaRUvLNgozyl
	+uja2zk3Xox3KL4IanfbRr+pbW03T3x8iyQbBu6u6bCy27+kyulWfgqGMBdNP4vLySk5TnVRv9C
	j3Y6ulMjH5R/4Zn0ePtQgNT/EfWVf+lGTLG+Mx6HsHO17QFrz3XB7I5YFM7ZhFiBSlHKg2anFjv
	ttNzQRPyOZSqLZjLxNHnhDq4P3TE0MsXqss/p1vQ/n5ewtNeWduE6PSHoG0aO2hyEklQMpAygNN
	GtffXYyTPq/mWfQW0XVIBQz8aI+x6AA==
X-Google-Smtp-Source: AGHT+IHVmsYTKQPKsx2Dl1dFgR7wnYbn803i81Uo1faDJpKu+bSLWIp7ii1lNr/mTZ1RTFjoVU95zA==
X-Received: by 2002:a05:6512:ea0:b0:55f:4b12:755b with SMTP id 2adb3069b0e04-55f708b4e9emr5962483e87.20.1757054543137;
        Thu, 04 Sep 2025 23:42:23 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5dcecsm1646902e87.25.2025.09.04.23.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 23:42:22 -0700 (PDT)
Date: Fri, 5 Sep 2025 09:42:18 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Hans de Goede <hansg@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
Message-ID: <fc3cffa3b75d1fcd19df0ff794e6ad75c8c87373.1757053456.git.mazziesaccount@gmail.com>
References: <cover.1757053456.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Azf79QCNeb52MKgZ"
Content-Disposition: inline
In-Reply-To: <cover.1757053456.git.mazziesaccount@gmail.com>


--Azf79QCNeb52MKgZ
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

---
Revision history:
v1 =3D> v2:
 - BD79112 can act as a GPIO controller.
---
 .../bindings/iio/adc/rohm,bd79112.yaml        | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79112.=
yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
new file mode 100644
index 000000000000..8aeac5b60880
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
@@ -0,0 +1,116 @@
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


--Azf79QCNeb52MKgZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi6hkoACgkQeFA3/03a
ocUA3gf/dvRLLAoDaxH2kH3VA0ELZDW6f42mVKdoLyhsXV03lalk45ArueUazdeL
5MmHvk50UgwJEC7aE2NM6Dh2a6sh9GEt16cxE/9foW1OR9WLcBBWqvhMKgDIzeiO
JLqtlND9R5HbkuHHEP1Qmm75QgVXLrHoFessVfDE7Cw9Yh9OfWDMJiHH6L9KX1oH
3gS7CclKklHgGnBD28/jhndj0rhqlEdgtV3wB0KkdKd0A5ynLkRp7dADzijZKT0h
dQq8UD1NBaGEtHquaVyhUPTBxPDBZxxRFlY98T8SLsvd5/leErauEzyReyrDZ99/
kBoktIr8s7VwJFVhYxKEuh/YE6olpQ==
=V2kD
-----END PGP SIGNATURE-----

--Azf79QCNeb52MKgZ--

