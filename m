Return-Path: <linux-iio+bounces-14749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A468FA23E64
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 14:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ABFB18864F6
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97761C5486;
	Fri, 31 Jan 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdEiIr2a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687A1E4AB;
	Fri, 31 Jan 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330613; cv=none; b=sZ0xslfyEi+KkRthwIb7l09J0/HyMOwNUegCnW0c1UnAhrgi/lOV4XofTGkqhhXbD8JkQE7o96vHQSta5DMlJqKFG92h7pndcRbDi09sYj+32cQ8FD/Ll0XjbUH1TswXSwvyG5gwM/aIM8naJbvxEOOGNsyE8G8GhqtPS07rH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330613; c=relaxed/simple;
	bh=DJRPvpIQK0LG7sCK+/WcdDN1yXWavai5+ZLaoyd3Rqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPmbsznOQsKplc6o0PRUU0eRJs130h3EYdDe3ACSVChGtne2bysW+bnMw8FaYeo2CiYk7GwtIRN7U/Qv5vktd3pLR36YZ0MFgIAuey7mbTUMIEH21ns6oan+d87U6sW1zhWDcfL0oxUOp6IiP5T08I/VzBxwOtYrQgY5IVTclII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdEiIr2a; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30036310158so15564781fa.0;
        Fri, 31 Jan 2025 05:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738330610; x=1738935410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHjZJjhlTmTfO7AepzA0fuoarBMFQAvtRywIjm0RXDU=;
        b=CdEiIr2astDKEYVTKsls56K4M6sEe5Em47xEk/ZBRdXTsPOCFuRP066akHYdYWQnla
         zLA51faSSlpFCKPBUOicOemxmFE73poIXo59PkHvcv9EoeCxmVXJ9CVVOi9AnzdY3dka
         CF/EjGoYHkqz4BzdwNbv349aKdsejJQPL/Pr3TxdOR7/CWtxwx3kO4ym9Rec2HKVch+Q
         3veh0/rH30YVPGfeZmxXLgAXL/60+ZP1dayKW1VHjMXSTML1HuN6ffzd1C0yytmSRvso
         L3yYKFK+4Er4mp9MUkJdKiWhgHSqVehWqcJHiY7ELgDANcVC9t7T9/F0PCwvL6saeqre
         +Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738330610; x=1738935410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHjZJjhlTmTfO7AepzA0fuoarBMFQAvtRywIjm0RXDU=;
        b=FmLonNIRrGkavg00RuJiGBs9xYxiy4qBL+Q6JRrA7HxGfqPnzB30wEbytGhbiQgvPb
         TaBPpJ+epxg5eYHRqEdfN6A/C1+K2cg/x3DZ//pr8KnI28miiwNb8X06GwZlNfuoVLPP
         Hdpji2wJ82+xqcVBXE64JVIkViwZXpBibQdzeNLzusnGSgGArrb0Cpg17T4feVu5cfWx
         n61Y0Er0WCV/8JbnB3dBEil8ykfOggFH3FqEXjDTlC99dhUb7rrNmRr/lkmEcxjz2mNT
         DImfG6dZ7PunESnT9WzniOtLJt6cqWyRwXDwWdvE9LLjglcyOCmfIpl3Qjfs77EEmbdH
         imxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYEdbtaQ9fK9eaU11xyAdzF7hQUey6p4pl03hChzg6GekFDfjkFApwgc3c4rIogFsypmia5skY4FIF@vger.kernel.org, AJvYcCVDHMiTr2XB6ww246DY6Dxczeli79cpb6YXq/QSBK3Vfz+p/KMtxaZSBqxidDR9/b4h2Bh/58oWdCQ0d8lZ@vger.kernel.org, AJvYcCXm3gf/xFywgUY1Heg0+hxplP6u6Z3zkL709m3pHdHtrJRl4P7+ASBZbvn+iCSi59RCQ/5KyKv9CY6D6w==@vger.kernel.org, AJvYcCXn5o5kNGlAd3WKL414oGmqIKCaOtDqaDQjzxG8PKio4e/xXTrtIMZQSf9GFNxUCHzXczSgUj4oLUwN@vger.kernel.org
X-Gm-Message-State: AOJu0YzESOarvgcJ4QsriB/VgfWjNuOZ9vGLtTHLRAf2P4dEuD1ul8QA
	WxC7Y2/bD8mOCf8vDB85yEiwFkPYOyaz6o4UwAh4poF/ZA4W9qm3
X-Gm-Gg: ASbGncvPmOXe+U1rcViP02nYm/Y+dBwcQiY1z/H9CkCx/gQnIEjBq/XeaLayKpaevqz
	POROW8gYVqygC6pD6zng7DRYyqscjHWLokOD9WlYjK++Hb2aCVc/BXgL2DyFCXm3vdHMCGgtB4g
	oyj5YhuklHopR7KNizt8d8jXvUWIHiPHzXuzrtO5LOh/SFU2Y3lXjgw53gQPyHH/wuzC9gtSE3P
	jWV/G1U4oaJ2ovleBQ9jSnOXhCPDjF8UvAO7WvJJW2hPi3d57RxjeF94t7OzKmCEEDlaVCfIaRY
	MQU7ComGU40awh1Aw9pFa0Z1vye/0UrCk/+8rtu8VaPV5AA=
X-Google-Smtp-Source: AGHT+IEQ0bw+FMqpnnG1HQlqpnFBJ5xouoypPekLv04MRrk3htGFQBFUIqOaT6KT3/bnqro69xlfsA==
X-Received: by 2002:a05:651c:2121:b0:302:1fce:3938 with SMTP id 38308e7fff4ca-307968d42c1mr39290581fa.11.1738330609310;
        Fri, 31 Jan 2025 05:36:49 -0800 (PST)
Received: from mva-rohm (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3423fa1sm6104581fa.92.2025.01.31.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:36:46 -0800 (PST)
Date: Fri, 31 Jan 2025 15:36:40 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 1/5] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <90f58229e4ebc5aadd6a38a0671563978e7de4f5.1738328714.git.mazziesaccount@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tqzf0yeGqtO+Siil"
Content-Disposition: inline
In-Reply-To: <cover.1738328714.git.mazziesaccount@gmail.com>


--Tqzf0yeGqtO+Siil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add binding document for the ROHM BD79124 ADC / GPO.

ROHM BD79124 is a 8-channel, 12-bit ADC. The input pins can also be used
as general purpose outputs. Switching between ADC and GPO is described
using as a pinmux.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../devicetree/bindings/mfd/rohm,bd79124.yaml | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd79124.yaml

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd79124.yaml b/Docu=
mentation/devicetree/bindings/mfd/rohm,bd79124.yaml
new file mode 100644
index 000000000000..0d2958e82780
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd79124.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rohm,bd79124.yaml#
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
+patternProperties:
+  "^channel@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description: Represents ADC channel.
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 8
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+  "-pins$":
+    type: object
+    $ref: /schemas/pinctrl/pinmux-node.yaml
+
+    properties:
+      function:
+        enum: [gpo, adc]
+
+      groups:
+        description:
+          List of pin groups affected by the functions specified in this
+          subnode.
+        items:
+          enum: [ain0, ain1, ain2, ain3, ain4, ain5, ain6, ain7]
+
+      pins:
+        items:
+          enum: [ain0, ain1, ain2, ain3, ain4, ain5, ain6, ain7]
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
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 8>;
+            vdd-supply =3D <&dummyreg>;
+            iovdd-supply =3D <&dummyreg>;
+
+            adcpins: adc-pins {
+                pins =3D "ain0", "ain1", "ain5", "ain7";
+                function =3D "adc";
+            };
+            gpopins: gpo-pins {
+                groups =3D "ain2", "ain3", "ain4", "ain6";
+                function =3D "gpo";
+            };
+        };
+    };
--=20
2.48.1


--Tqzf0yeGqtO+Siil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmec0egACgkQeFA3/03a
ocWyGggAvnVxmeOWL4XttH1jZ+fw9cSnIqoUYFPdd9tFC2kUTMzl2Um8dge8qoDX
/oZ9KX3q3wcBzH94ysu1appA2+27Jf6VLcEj5mEZhbSVCM7Yv9N3svvkWoV9+KgM
EffBFuIMCvYOS6z+2+Q3xDFfCVq624phTHV5ZSU7PxIu7yQ3irG/0cltCY5/BSGV
VnWvXvbBT8gTvAR/XLnSxd9KRiuew5S/Yp8nQMacmb5oU9FyLuQbYBidZ8sWFHDT
vLOwUigHx3LL6lqA2ZKVJYDmQEq+enW/1SYeADSoh7mFG1MSg9xzX5wK6xygStK7
fNPhiVEb6I+TSYjIo1izYbBrKieFRw==
=Plev
-----END PGP SIGNATURE-----

--Tqzf0yeGqtO+Siil--

