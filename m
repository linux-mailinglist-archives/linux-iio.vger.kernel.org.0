Return-Path: <linux-iio+bounces-15036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9B7A28BBC
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 14:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9942718886C6
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B90E126BFF;
	Wed,  5 Feb 2025 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMbP0meZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949BA86328;
	Wed,  5 Feb 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762479; cv=none; b=a78fVRfCtOxmZapai/Rbdry0vu8vcRkNJipVoBP0pCm9vfYRukTqx805H3fopJqj8986KvLuiWifN/DE+8M85Y6It8UeFbF1wL4GnHXcvyz8TdxR4fskp/L8+up2MHAaFdXCprqxbej8A8cVEcyc4dIHv0pP4PazWTaI3SuIBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762479; c=relaxed/simple;
	bh=QYyo/FHbFYMbk/asRpef5Q7eAX3O1AFDLqu97FKYJgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYQRJxDQ14cxym3/TyRcb6ZL+uNo2LwmMvbuAoldcMCnL2K3Nq8fAQYcjekqSjow8EOG5/iQTfQLCuwhHm76TfdQarLKmG1F5KctzHR4ylwCvH6qdNkUv2Z7waw+VYYz/yKEUWuGqYr0UtpY4nSdOlAKnlqFYQjDuNvCkLdct2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMbP0meZ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so52395521fa.1;
        Wed, 05 Feb 2025 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762476; x=1739367276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgJySmC9K5gh6Gsa4LTSVYRV3LnuSU0bHaNrJJQ8n3k=;
        b=CMbP0meZ0JaRzg0CtYbQYFnUpMjPBhpWdAXtzaCaiK8dBCLeQfl2Db5UfgjQzncuUn
         QbunmgoUOIifyhAVo/P6Ijps9RotiSGqNynx4WzxuYDNukioySTB3kR7dD0KNj8dfdVD
         M/G01mO5ZQBZvrgL0qPI7FAxolXjJBcylhGW6ZQJtO9agUCX/pidPE/9wgJ7pUivDCnT
         pfJPaVvsYp+bSSCH3hoCqLB9mcKPEEobHZkMhBJxkuLO8ms2aLrQOyDe3biN58HlO5v5
         ZAGv7xMGfbjoxsWh1ENg+/YLziX0ahKdMq0kHHTFtN07J5IzUshBeoCz+KRFBP7CTMat
         +HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762476; x=1739367276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgJySmC9K5gh6Gsa4LTSVYRV3LnuSU0bHaNrJJQ8n3k=;
        b=scAD41N7bIlBXO0CW31NSO7CUECbYtvvHU/6Bplm2lys1w458y5cNiTDsi9JKQATku
         /hHPvnMyMSsTOpiYgvRHCVqIIKYq2PpL8HrCsbNEAWNzNTBdKW1GxE8VL5LBQq+sxZ7h
         udNvFykYnexkyiBYQHKwSxtutfLWtWDFMFkF3SqUfBsuVGLkjOiAyPZbWUq6K1f03Vys
         WJz67oWEModynp/wKzujAlEJrj4LW1sEyTqgNzqmx2yHMEbrvlorWxXF0WLL3cqa7JCd
         sYVZFGodQ1osUcleqXwivFMTqvLxzi/NcXlMqQsViRMYo6Rx5dw8wsYPZlWOzU1RYQ47
         FiCw==
X-Forwarded-Encrypted: i=1; AJvYcCUG0bBCroA7T0DH2/yKQNOm37UjroV8SmT9SWEKlyhNNuF9+xeg/Imde1qM3TdTl6uKR7h+ktKUCY5jNcKx@vger.kernel.org, AJvYcCVk5iQlMpGbb9HABtSQq0jvyFtqT+N+8c9mTafO76QiEK71/Kmlk0PAnXGkIusnpl3gcO8C939Q3hIs@vger.kernel.org, AJvYcCVt+vl4pbefRJNbx2l3wH16+mEUnQ9Vyx+upckV74vFxob2VDvFcd8NdQaxqhlECHwpkztDMQrUJ+X0@vger.kernel.org
X-Gm-Message-State: AOJu0YydT3+vNErmMSv6UTJQapN1ImyuPhJLSOrln/nSyHUMIbLnouoB
	MWc4RWvy2CLUZSo9UQqX9rVkquansOxKoUnmi9dTvMROnjFOmTT8
X-Gm-Gg: ASbGncv4NLO6jYKSRihciSidr/EoOKRSLS33e9wpvFrHpSGg2ECH/MPmq0lCvbD7jn8
	B0+BkT17wJ2FNlBF4QzyUQBMOyjyPtjxGyE3iyTenakLNVGQrp2BJe9Jxx6Lt/57W0wiHRJKrgF
	p+Xphjo2fZFsHcCw3Jv9VP1Kcclwb273XHLUfuMBr+8oy4emwHK4P5zQbweWt6FkhcRBc91Kjka
	jsUwvwxYmUETlCeOqgfipEgpGaAZJKHtHdQWKYxafiuANte1HfMLJTBJnljEtQJko/mhD6K/JzL
	Yi5a+xY/2/rXjVzcXA==
X-Google-Smtp-Source: AGHT+IG8c7efCTwjbXvONBdjVeyk/YNlgHGXfYF46uq7psk7lZj7EwQZzsbRh+1xREmSrUrPkJKfUA==
X-Received: by 2002:a05:651c:b08:b0:2ff:c242:29c8 with SMTP id 38308e7fff4ca-307cf386eaamr10046331fa.35.1738762475266;
        Wed, 05 Feb 2025 05:34:35 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a308869esm21460511fa.35.2025.02.05.05.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:34:34 -0800 (PST)
Date: Wed, 5 Feb 2025 15:34:29 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <4e6cd143d3e896587528a415c8623ecd610fac55.1738761899.git.mazziesaccount@gmail.com>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qRQuqB26klp9g2e6"
Content-Disposition: inline
In-Reply-To: <cover.1738761899.git.mazziesaccount@gmail.com>


--qRQuqB26klp9g2e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add binding document for the ROHM BD79124 ADC / GPO.

ROHM BD79124 is a 8-channel, 12-bit ADC. The input pins can also be used
as general purpose outputs.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
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
index 000000000000..50889dc6b9a8
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
+  "^channel@[0-9a-f]+$":
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


--qRQuqB26klp9g2e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmejaOUACgkQeFA3/03a
ocUUegf/SbncO0VOWa4EjHwz/klqaoC/R3YQkyGQOpqv6IwBiRVaT5eAmVPV33oL
H8LYlt/Gwg58weQebwrI+42G9B2g5t6vi8wGrdd/TDa+KHDOVUlJXS2uIV5mlydK
puKfiFo3KhwYUTe+wPV7tMInKUb3vV8Tm1VRoH3f9f8Wt9gCj7UAo4172PBHLvfk
MvSx089gOU1PQOJH/zyU91bhUVMQwrdtByqsS2BuRngYhBigkYGhNSPWuso+SQuY
LqtLUjsNPmf/rHXIHwEHhHHfGuBQayOY4ooghlhoqPPG+rh2D/K5NziYhspIBs7Y
ew8OZCrBswoIuIEj3zw5HrO9Pmb7EA==
=I6XS
-----END PGP SIGNATURE-----

--qRQuqB26klp9g2e6--

