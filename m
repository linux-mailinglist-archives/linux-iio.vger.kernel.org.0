Return-Path: <linux-iio+bounces-15778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E826A3BE10
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B27169358
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE91DFE30;
	Wed, 19 Feb 2025 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLvFn57X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105AF1CAA85;
	Wed, 19 Feb 2025 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968220; cv=none; b=M7TfCtuosaRrCoGTo4LvfriuiV74AhpHqjqiDVExihviugPESf29pOeeENvr7w0OGol+JRmr5IiH1Ui0jilfT8rYQSYxz/81LVOGHQWhQ1UwA5/4crk96iEYtA7kShTgxfF2Ilug/RMGD1DkK3U3XnzaHexmfpH476vpQUbO6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968220; c=relaxed/simple;
	bh=3gWSTns6gMmB1JQU1DSavPgSrppmWBtW/fPGFzLygso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRJlXh6V08q06QZqMat7wD9zJ5Rl1lD2yxy0fe+aCGOrgcQkZweUPMnecMZ8Jnfh/p1kOXrfPV8PzCljQ99rneyOjXbKjzzvYK4DxVuEEpP5YPEkFiM9Hb0Y8pG6f65Cj+7zDFdf5bfcqAnokjrSFSR3PaCRml4zuC0l3bo2Tf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLvFn57X; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30930b0b420so38840261fa.2;
        Wed, 19 Feb 2025 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968217; x=1740573017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hUrd+Gyy/ajIhuvrP2MqW/IazkO3sAPZGITYXZm04k=;
        b=FLvFn57Xg0E7pm28+Im79KZEtJ10U3kbuvxsSCBH8+8Ml+KwWCWmvIPE2v0H6DsOJH
         KoVG6oBmemXCnWhId22okS3n2T8gFExUpPSSfBs4jp//SzGBlGmGaYVAqjeUte09C51U
         w3lmhSZmmr78DpD7ELWIfNiuWPWv5lvUJfYxKMwNYlTSlzzL4HeTIN1IQm/y0zNy5dhv
         33tMyBVYxW6Ipb651R58DOzvNbOdj/+g8Lg+wvBurm5Xn7kS7qzPvDtd9Xvfch1YRfk1
         PyyJWl8dTgUwulz5aSXp9TmgZZdgJhLxKqTcjlQDCDzOXWxdmQD9T2ba/oA9P6CYQiJU
         mWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968217; x=1740573017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hUrd+Gyy/ajIhuvrP2MqW/IazkO3sAPZGITYXZm04k=;
        b=YM+tMSI0BdPGOIx4068FaHmMoGTMvX2ttzXtuBo+DSloN2PlVy4PzoKuQPjw84O+ek
         k4bOc9vjJFK+2e3ZeL/Wu/qvZZwQruuCf1c/n5nSVhftRzk9dA7OvaECBYH7UOKczHiS
         dCBbDFUsqjnAlA5i8i8LFz1WE4ijPjt+Eod7Dr6VEXniujzCjDCr+HOMBTpit0b3+0yw
         8VcBSQhDzxfqdeO27FWmpvM3oNP/dEAwXFIbRGvsFKbjpawfi0qK+OLu/qqdgu01MynI
         w5tGyn2hDSa5Husld93XsH2jWK7Xbwto+nLkA4YpNbQeQJkPc2phq4CEilHtDEovBFbi
         zpKg==
X-Forwarded-Encrypted: i=1; AJvYcCU3wj2m6u6vzb8Zv8y4FoHjEngoWWMRxMKo82MxMp4DS3tDdB0tJIV1PcSnHjyjJDaIbAbLYkP8/2Bz@vger.kernel.org, AJvYcCUOPDDp4XNiITH4rhr1sMx+XE3NCBlgtS0otlw5692QerEbRW9rRakCNrt+ZoghpX5XLg/WIaqGE36w@vger.kernel.org, AJvYcCVG1Nl9oVsr3fTha9CXT2z4FtjmHPJUuHlr2cnZr96lJTruL5oOvjHSt6+2aj9s3oiIDuNWzvdHp5pcYXwGIZEhb4c=@vger.kernel.org, AJvYcCWr1dlbAiUfpVajAb9EFOsUIY1XfeMIapC8Z8jxJYo3oHJ/2PoeVQ5LEhtN7ONvGhhxKWx7du7p/ymvOIAy@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDA3giiMdQ9+t7lyWC1aR9HuBtbAGdKUxltqy7d6wfrOa8qK3
	yNWSJOai5WAW16RK0psMhbOUG2o6Lm7QJHUhF+UcF5lqj7S8ic/M
X-Gm-Gg: ASbGncuOHPj48n3w9lqze58PtZXUW4+l3CnSKfLgbe0PrrZgJnR+/OegN4J1rxLtk1a
	bgdMAookgLIW8kKbDp8XkMub+QdHnSmVxF76ubY0+1Kzp3LdFX/DtRAzWL0QdaV2VssljoZKdg2
	4x+kd4/neDTd8uzSV33pD9/a4btqW3JYK1okZhwVzbJQyVn1BqlAKUeJkkzXNUK8hhYk9iA4Rs3
	SBN5FqG8lUtb5zPSY/m7FjV/B692+xzq9+U7SQ9gY/5Q7Bc8NFmTePcWHszDd7Qtr5QF0N+p741
	qGJpHjKiX3xgMj4UWJVcUQ==
X-Google-Smtp-Source: AGHT+IFF8ZAOezRn1kWhpmBq+gPrOLGIPq15CfW2c+RFEDW/9HuXUxU0qk6Hp+MJg1WFZfej+FArLQ==
X-Received: by 2002:a2e:b176:0:b0:309:25f6:8dcb with SMTP id 38308e7fff4ca-30a44dbb334mr9639561fa.5.1739968216796;
        Wed, 19 Feb 2025 04:30:16 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309e57cc68esm13923301fa.114.2025.02.19.04.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:30:14 -0800 (PST)
Date: Wed, 19 Feb 2025 14:30:09 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v3 1/9] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <52db5ddb99dcd8da847f8fe595efa74c3ab1573c.1739967040.git.mazziesaccount@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R4M0D4QEb5Wt72s2"
Content-Disposition: inline
In-Reply-To: <cover.1739967040.git.mazziesaccount@gmail.com>


--R4M0D4QEb5Wt72s2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add binding document for the ROHM BD79124 ADC / GPO.

ROHM BD79124 is a 8-channel, 12-bit ADC. The input pins can also be used
as general purpose outputs.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Revision history:
v2 =3D> v3:
 - Restrict channel numbers to 0-7 as suggested by Conor
RFC v1 =3D> v2:
 - drop MFD and represent directly as ADC
 - drop pinmux and treat all non ADC channel pins as GPOs
---
 .../bindings/iio/adc/rohm,bd79124.yaml        | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
new file mode 100644
index 000000000000..503285823376
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/rohm,bd79124.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD79124 ADC/GPO
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
+  an automatic measurement mode, with an alarm interrupt for out-of-window
+  measurements. ADC input pins can be also configured as general purpose
+  outputs.
+
+properties:
+  compatible:
+    const: rohm,bd79124
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+  "^channel@[0-7]+$":
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description: Represents ADC channel.
+
+    properties:
+      reg:
+        description: AIN pin number
+        minimum: 0
+        maximum: 7
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
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        adc: adc@10 {
+            compatible =3D "rohm,bd79124";
+            reg =3D <0x10>;
+
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 8>;
+
+            vdd-supply =3D <&dummyreg>;
+            iovdd-supply =3D <&dummyreg>;
+
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
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
+        };
+    };
--=20
2.48.1


--R4M0D4QEb5Wt72s2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme1ztEACgkQeFA3/03a
ocU2GAgAi1f9EhPjwB6NYTSl71jogLZMg16q4DlOdHT5/QC1eZtxXbrJF0fqBJ9b
ZYymKkMVy3nlmcL75k/CoKlQFQyDLmJ5QG/bb2TsI8P+WvTTkW/njLa9K84ZC2cB
rd3U/DxERcFfHZc2mCrJPIWsihlIHDcISg6dN14sjtv9EV1aSj4xufwmOxpqSmLO
nyIjYvI3wPWsrxUCm78ukA02eDjmyPnXQwI5D7vANv4YSaoZf9PTYZ5l01iWgNw1
mwKjV9GLgBtz4p1+5TJ/R6+JT01hf6lriq6oiPL4Uf6aWn8hJoUbrceEk6ZXCj9F
sZJB9KYXRQpvgzQpYoLYwhSzkJ2YGA==
=A04d
-----END PGP SIGNATURE-----

--R4M0D4QEb5Wt72s2--

