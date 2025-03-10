Return-Path: <linux-iio+bounces-16665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB2AA59540
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6DD188EC03
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E46227E80;
	Mon, 10 Mar 2025 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XffAynss"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE6229B10;
	Mon, 10 Mar 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611262; cv=none; b=mshMDtGWS58buY5ZmLFtWwqZb56qn8nLptF7sYFkOlH2iaZR99GOAlytOgJ7T1B9YgvA9F9noc2lBKOfCUtLsrA3hTQLTqXDI7BhpV9oKk2I2dETdafhGBL//CL6A4TeSIXDk5MocjAZsnrb9azIe0YL5hgrKQ944fSFkexqxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611262; c=relaxed/simple;
	bh=hfonMr9KTehGSUCJiTUluzcfc+ZrHJdVr6Koj9sDnPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8F3nUQG9Udd1oLw8oDlcxG7myED9MZ2+FN3Xfhfb9aqssskcQww1zxHs9LB5nXrHoClUKtrnm6stYLN1rDprR1hwakIyKOyFpoQpt8txLf7DF+EojGuyCcL+t1Mhof8VlzJu0frCUJ4Bxwn/57/K+btE3JDx+8C7/pSvtttLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XffAynss; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso25178811fa.3;
        Mon, 10 Mar 2025 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611259; x=1742216059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1S912joY+zkoMzH+dL5TkQE1Cyu56ln68Q97QOeykWw=;
        b=XffAynsslqXLU6C9ZYjZVOjy1/RDGsrhbTAL1VqXCSaP2OIgpUdc2JKhDRFCETecFr
         Y/tpBXm5kqkLb00EfH2Q9L06whtj2YJrt+I0NsZLAt82n5CGbYu8G6Poc9XTtToNVaEZ
         Gbnjd0plS2c96/6XPnpWMWz2xz8DyUcAYSlNB5xq7kH4OLe3P78IVM8ESWTJHFlqGtzq
         yujLrXiI38BVy/U7lRIoz1Rvtla0s8qdccu7wNokwW/YUNxWaI3BzQTkiiPVoqlDgfSU
         zRrCmT+2aaAttZlDe+I5sBejJWGTv4fYRNO9hP4tbfieh8vesLWL2uiW12I64ST869jo
         p41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611259; x=1742216059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S912joY+zkoMzH+dL5TkQE1Cyu56ln68Q97QOeykWw=;
        b=oD1U3ei3kBe4Vz7FkGG23QsidLwRufwiQSlj+MIcW5Ik+qq2S8Zk3Ujgi3MHCz528Q
         DHd/U918FzR8ZdDy7HoVLgy/YW+0xMxTLtcs8mG6VWtywmsnKiGf0inL1GxXZ1qne+kY
         kieq72elqGab9wcRFmujbWVCBLES811TA5TVGVOBKRG2jWZLn3463ci+vHpgFjrTlRAn
         /P2uhzFyobU/tNGs5z7qrWd1ROhy4lIcaBy3uIezETLysQLqK76uB1ZAAft9bkEKmAdp
         yjNkCezdUJOXRIZccb0+HhGVZFDQwg9Sm1V3SIVSs2i5vfOXIo2NXmjIZ24C5fjxneC/
         BTrg==
X-Forwarded-Encrypted: i=1; AJvYcCU6AiHHzLBkN0NfkQX3XVsNz64uzAJvVRUSSXAHAOhZdCaZMlc+JUkwmHUvo4B585CbtfAf0DMn5EzEiKcV@vger.kernel.org, AJvYcCV/Prae6IjFDQSbn0uib5i9pfInoyUsDcQ80yFtK9SV0Hapz25v/fDh8sXJhUc0KPMCyraWcsrCzpHh@vger.kernel.org, AJvYcCWHIfzsOVrE2scVpaZVUXPZZD4sM+XQU6vF3wFLIpFYR2+47cGp0PNYbXTnmPYFT7gAV+J4lwcQUGEH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PHT3tdRdfhDipufaHWfUA7wSNXJEt16X6s/EbUxgozGUKKS0
	J4PwRZ74rg1voR6E5Oa0XK7/oUsUCq0x4vQWYfc/+JnGq/JW7XAh3FA3Pg==
X-Gm-Gg: ASbGncusg5GEY7L2YWAm/k9Hw4DQMu2DVdAAuOiw8AkW2HkE/sFJuWfLP1t4r9pcYpq
	Vg7AHYzSFLE4ik33ZUg8S32rPDImT5iNvh9FedhpyzVsFS41hYKtpelNInN/FmB6xz/32tHmCFE
	EOPB7L4Yq1eh+1nkifMJiX55ta+Qfmmlx0YRX9HcXkcsQbPQgDr0vIoH9tl69Cvs6RzwIxsVDh+
	zLusTo+GXufPO1ZyRio0JnuZJB0XZ1CDZu0svrRSNW2vWjcnIf+f8YPVJjSp0PIF3col6NXQGga
	W8NkBbixBUVYfKZUt7+EijS7S31FYrvnvxUP4NJ3dprhns1vJCM=
X-Google-Smtp-Source: AGHT+IEjzphsV6P0hk/5xhJyDaWRVpCGeGeS7n2u+CXNMtaBpAxEOkdqhC1cED+x/K9ALJo0pWWYBQ==
X-Received: by 2002:a05:6512:2342:b0:549:8b24:988f with SMTP id 2adb3069b0e04-54990da2790mr4279341e87.0.1741611258357;
        Mon, 10 Mar 2025 05:54:18 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bf0297ef4sm15174581fa.38.2025.03.10.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:54:17 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:54:14 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/10] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <a710ebd82dbbd3ba3fb2352a1f592e9f09b4fb92.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8H+5vsLgzbREdEV/"
Content-Disposition: inline
In-Reply-To: <cover.1741610847.git.mazziesaccount@gmail.com>


--8H+5vsLgzbREdEV/
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
v3 =3D>
 - No changes
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


--8H+5vsLgzbREdEV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfO4PUACgkQeFA3/03a
ocX4wwgAzsQUi5lNe1jSvxTxy6cVLAS7BzrzRtZayeWBfoIhK24kAlc5dPnPrIf1
t+LYOvUPWSVp7nvriNnW0xtRjkGOcQ4Zj4F+IE7+W1xsGW3qkvESKL1HEBBYlNlS
bB6FZ+cQX0C9yvUUj1oq60IJ20sb9vZFkUI/xBfr0OBnESFsH2FAHm28JlUSCt1L
UzpwhqeJCZyDz0TtjXc8EZDxh9cAD56smeVQHZSa9IArVmsXUinO/J6kkJRKhOXY
bCYwVhFcXZ/vRE2w7XRICYMsa6P526tuHfzq3SQHNNoDaFywWcYtQx68fMFbIOac
doViorM4eYMkU8CDQ4yyjmJVWozC+g==
=RVE0
-----END PGP SIGNATURE-----

--8H+5vsLgzbREdEV/--

