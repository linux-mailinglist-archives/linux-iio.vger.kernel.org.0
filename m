Return-Path: <linux-iio+bounces-17138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C3AA6A118
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B71F7B0650
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA420C02A;
	Thu, 20 Mar 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwZmSDaw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09A1F03F2;
	Thu, 20 Mar 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458858; cv=none; b=EIc+mNkQi2RjKywc4eF5ADxkgOGRrzB2mOBFhiiXJ/Zne2JMO+8ICVbCugwdyfzPEVWoTCn7uRNixcokrLF1oJXzYL8bvOO5omkHjZjnZh4Kj8+63wWXkO/J2/6iM3etP9EfLP/1oi1wyaBFXqzRMSZV24SyogPqXlUTKlL7SKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458858; c=relaxed/simple;
	bh=m9ldrpcnCoikE6giWHd9jUoVh2I0mSYdeJC9WLuvQgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlRGb/ZEf+m+WwvaAa63yjvLrrTML79Liir8XpbQ3L7Ex3/PMLIX0BAZtHhFSRbLDRSscjZlR7c/NgRqKeb/UvvwnSNxYrRab4vwNgAqH+tXVH7DJngX+r8OxJ6ICp+2au1gjeXhf/tnQbSZvVu8dmULDECPjWD2xdK1QPt4qmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwZmSDaw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5499659e669so615899e87.3;
        Thu, 20 Mar 2025 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458854; x=1743063654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9iENHKVkwQALSkIT4ciqqxVbw3ICVWHqdjLqSDCxudY=;
        b=gwZmSDaw8ErlAuWjw9PQvB0qAHQodU2M3JtDhS4TY5a0DwuYSAHV1q6dVHD8EvwkG2
         WyNfjCkZYw6nXP4SgzQu6hGb/FrDF3Ny1IOE5oMqFd9ImdU4ztC38Stxux+MqwkLYY+A
         9qOiv1+ujSt8vH08Bjm63V0Vl6KcxH+6Wnd4eAFy47/pDAoachzDIC0GZBGz/4St7Alh
         EVJleHGem09d8sOjzlwyrnLkxILmIWmJmX6xM2MHGbI1whPXYqkfALEW/qLxvjFSEusv
         1+EX0d8HXdHiOXBeXGX1ynZTvfKCyOZS2RgSYvSCxzCGWGYcOWxhjP2n1WeXAasJK9H1
         Zpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458854; x=1743063654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iENHKVkwQALSkIT4ciqqxVbw3ICVWHqdjLqSDCxudY=;
        b=rsPK/uyNt0KZsThvtacPCibOEQRyevsnaTv/Fzwg7wxm+6cY7YGz/SBzM+E0rzQeOQ
         J5PWzN+zbG/sneV97s90kxuLf/8Z7YDXqfrVRtqnCnPiPIS45gYDkg9Pz9ThoBaGfm99
         yWoKFqLkvnojsdreqWPRgbyHB5fQI2JtoskrDMxr/y/IZ3d+7ERF5kDlUqekuknpOw2P
         dQRmb5hdDDBQId3skMNosNoEmadqIjO7IvdFgplCU77aOD8ZkEva9TzMyyEvM/yLuvmA
         mELQa4X5/6UghXRcRojZc5ZRffXiMMdJ3eVMCBsEptXbBf+OoKBDut1ew+991NMhcmSb
         xAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP0DNTMrhL1JQRU4rq898WjBuHrUtPjnv+UYyEFUS73KHaYkaESu4M1MpX8WJcR240/RTAM00E8Jn/s8+t@vger.kernel.org, AJvYcCUe5gOYJx1THkhaGMGR30jey37jWdbZLA2gMXSPTnl+/3JQWnYB0sjLH7pNfvw51lUB2bHkIcIQM+JF@vger.kernel.org, AJvYcCWx3zZvY/YqW8HP+e4DY4h+o6FF4K7LM/2VAIEWS2TTPUrBQyXt4dT1iGC1WFnJ6sf3LqiQ1z5dsOa0@vger.kernel.org
X-Gm-Message-State: AOJu0YxaUajbUENQQjafgfUEuvvR4AFIrwIkuCZIVila+V6T1bEAXotU
	CFnd0Q5PbTKY8zT3SRBG6X5WCNDAiDZbhmFQemKU6wbB59cbGrT1
X-Gm-Gg: ASbGnctPq177PpcWFGpQGqehHRWSwZOXsxkRynBD78iCtMtnEczQOxp0EekUb6CAtW2
	vwa/IDQzy5wyO/tVILvJ12AwXN4i9hNdAVCfPAIrDNIRaLthorgRh1AWyhk4sb+uDgTVIsnK0cv
	J2Vn2ttHCBj2Voo0G4mShnVVDc4OCxlbTvUIGtWqSLB4L0lfErp21v7W7zHXPRNHY5e2zNDGAsV
	78sjE2rDNcoSs//4fG5bEuse4zk02FFdsIU7nbFWzCxwEki8vNYUYqzuF+iaWA3wiXDPcEEGtMH
	5GN5H9M0+Xyuq9iTobDLoevOt3B3zqfJlf8RjWd6E/OE94a1uO4=
X-Google-Smtp-Source: AGHT+IHZT50mChewQrqED18bCPxt8oOSgGTEXlwZ6D49vU1R1f4+KpfiFq2ln/VYvdhId27X2iik5w==
X-Received: by 2002:a05:6512:130c:b0:549:903a:1c2 with SMTP id 2adb3069b0e04-54acb22429fmr1982203e87.49.1742458854183;
        Thu, 20 Mar 2025 01:20:54 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dc3sm2209562e87.152.2025.03.20.01.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:20:53 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:20:47 +0200
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
Subject: [PATCH v9 1/8] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <e16f54b6214b0d796216729a7e29b8f7be9ae19e.1742457420.git.mazziesaccount@gmail.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xAcJQBerHGygPDu4"
Content-Disposition: inline
In-Reply-To: <cover.1742457420.git.mazziesaccount@gmail.com>


--xAcJQBerHGygPDu4
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


--xAcJQBerHGygPDu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfbz98ACgkQeFA3/03a
ocXyUwf+L0DqwbrheDMl+16Q49pBwmzb2F6jweE0QzMHkSi4HdY03hkryNUTNjPR
BQWvGUGpaMSnBesvLkxSl4wN9mRS572T/YNutzEx6yYvXbaB2Mv3EZh6PdYahKHX
irMgG6gq/7/NvRMQgYGJJ5erkfeXPp1nQkWBEFpalBkdX6tZEIQObsGCCQo5oFa0
FENh88Tx9o3m+FDe9Ve889IkeTRzFOpGOXz3VpC6ZKXLiXLeaaZn6TrkVtqCi+9P
vQQv6AkdXWZQXy7tVuWhwWbPn7BbUGK4BUxQ7CrNne4oLLqaiLXnM76JXKomUO4U
8i7LBej4yfl5adKD/L2roLILk2ZvTQ==
=tmL0
-----END PGP SIGNATURE-----

--xAcJQBerHGygPDu4--

