Return-Path: <linux-iio+bounces-17217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA68A6D4B2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 08:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345DE7A5936
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 07:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E764D2505D8;
	Mon, 24 Mar 2025 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUxTm5L3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12542505B7;
	Mon, 24 Mar 2025 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800367; cv=none; b=G/gt8kDlgdJPF5HEDn9qg8XRNm7oIgmuq6+rjJa3YSPl/8d17D+9oAR5Riy8k+KzzkcdLb+Tj8BzIkP9ofoSzoVMWHJAH53S5NmTFEQW1jH5TV/zkPupijLZGZBGPLnkMrm/eJg84v/k9i74CuZPKiL96W3Nz20rhM0OXPyFLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800367; c=relaxed/simple;
	bh=XlzI1IHxjwfuKVLJIiXEoNwlCPM2LIzr43HFpsWZYXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgahnSirMk3j+/xeoW2JHHEscdpkUNpVFFKuhH0GQio9JO2gDhw9E60bfgiCbW5ocEC3HBnQXY9YPza6IAVPoPeH0UyNtXeZtQy9l/OoXF5dHfU+nafXrbsnsR0p9GsvxUiNJgqbUjQiQEVViqCbZR/xlHU+XubohTmvFlW/RSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUxTm5L3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so4574342e87.1;
        Mon, 24 Mar 2025 00:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742800364; x=1743405164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+ytWjAlq0HNiJKJ14GQ44iV01O359MSwnvedPnkgjQ=;
        b=NUxTm5L3Vfp0XuSknsCuBUrmOUPKsp1Mf36cZjTUJ2p+i16HJbECnxH2IWhnuN/G6W
         NLs6FSrp1EUffzfa3OyPqThIYxTpk7vO4yGDa2gJ3ubEZHKD2Ps7KNmpOX0rdd8AemC5
         48IFPmQcCgnht8CNMdbFpXb6jmfUc4zScMvcdEhmvECYddWIH4a5tFBQv8a0Xng8JPIe
         IkVQFJjeFZz3Kfd4LwvXfhqx6Pw7Ntf/d9DgPQBQwtlESfFWfKV1TspFmZwDc+32GiuI
         XwcLttaK7koxNcvIiTJ6VqUe0zjd9p2E8vYLRjau3ewO1bxIJHNfgRtJFcqU3Zn5+TtV
         8bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800364; x=1743405164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+ytWjAlq0HNiJKJ14GQ44iV01O359MSwnvedPnkgjQ=;
        b=ewn2IsEWbpa8xS+GYoiiRz7YRHFdBAV1D9BgmED9PGYpptBYPaxM2jJp3gUGjdiKTj
         M/ZgF1zaPJjpkYn/fs34dSJ5rAL1Hqabz/adEOGwxTRLmmpDlxyn9z05GSk/8WTAwBjy
         Yl/6tP+5bNfQ6xJOftLEuUi9B5gAGfcejL5g1dE14v3OHlWRTjj5TRMEPoZlJ8Rggvfa
         ctv0iCoSGNsI+rsVpe7Yy8IY/0GN3Ey3+eSvEOMMk5r11t6e5tlpaW3GldKZr4fxBMAx
         5muGbv9feNOEMgpEB6ejUgxvyISq8C7unYXhiIE+ay5R8JXN/PtdtatEmVX3tY3YkKFz
         ckWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc342asDKzbjCUaBtVXEoGRG5J6RujCe2A6nYYwBy2Hcpq219uqkmmtCBQi13FFqp0cEsLM95xhcmzPJ8j@vger.kernel.org, AJvYcCXMQcJOo90e8Ha9EslgK2HGG4LS8jO/b8iWNQYR64z2h8/qlhm7BQGu1UcN/BTGxo23L05bRgzNSUEe@vger.kernel.org, AJvYcCXZicPX1mJIxXQjxabjfZo3k09CQuHkBEWGNlB/qPgW6eSoSaFGYZm2AUR5T2jGZJGb02YLveXBtHz5@vger.kernel.org
X-Gm-Message-State: AOJu0YweB69j+peuzzT+Kea+5PMppjVCFSFwgkBhqvDWXoSVULDS2Ugl
	PwjIAYiSlnW+9wgcwDpSIOxF9KzNqoYnAphRrBg9YpjgsiHAETQW
X-Gm-Gg: ASbGncvvE4ec7pRO2fMHUiztfBv8eMRRkjnmM/X7U+OraoI+hZTaTKpoHe1WWk0tRlY
	w1Aq84lAMxAwa8MZh3kEyXeXE70+A9/Y2jfHcuEonYCPsR4A4dS9SdJMzlmcuXZ0j8B0SLmCwLr
	CONCbyGVoaIF7Jlh7xjNTQISNvnb798l+IcnR8iqTHcFNoOe2CfoxVKn2N4h+gCeP1RJEGqJLbT
	vdCYKxMMd8BxJ7F2/4ug6hnWNc6lpEA4zBbCtdl9+cpb4btUZhkEpRr2T0/TgJpevItNfRikBvm
	tsiBruthf9UlFs/6TPkYqhSo2p1doh00MDLv+HxO35OYV8oWAhdXm7R2h6rahA==
X-Google-Smtp-Source: AGHT+IGf7h596ZaefXU/5UBstlz8hYr1O+WvoNOGjX0ytqOQj1qDa3+HXIZMMU3svI19Jn5baiXYag==
X-Received: by 2002:a05:6512:1190:b0:54a:c835:cc44 with SMTP id 2adb3069b0e04-54ad65097dbmr4152343e87.46.1742800363579;
        Mon, 24 Mar 2025 00:12:43 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646931esm1041623e87.42.2025.03.24.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:12:41 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:12:36 +0200
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
Subject: [PATCH v10 1/8] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <e16f54b6214b0d796216729a7e29b8f7be9ae19e.1742560649.git.mazziesaccount@gmail.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/0CmiCE/oIOetfjq"
Content-Disposition: inline
In-Reply-To: <cover.1742560649.git.mazziesaccount@gmail.com>


--/0CmiCE/oIOetfjq
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
2.49.0


--/0CmiCE/oIOetfjq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhBeQACgkQeFA3/03a
ocWRKQf/SBeqXdlXkdJu/SynzW0w6N3Is5LibMyN/zSKh8no4ojzKTlUgAr1f3JZ
xguQrs5lt9eUIbrYl+aB/wTU/Cz/XUl7ybo2jElQEZCN/KkpR6ukgAbmZXh/d8gu
uNIMR0fXlO/TBCgWc1oCMpEQjhDTS3TAWGQjd4o7xhUtBMyLC5RP/MFeDmk9ZA6i
2TRUbQDzzqjvo/qiagS2l2II+NR46CEBSeNGaogigoz7EIozGVzTUF9aazDqMZbv
dTtmPbpCXM5DcFMPtIAroRMQXyuFqlmzS90EnB91oHTq849yKbFtrLJ9lL08I+QQ
zocgiEnBhM7o4XwGjHrFN6+LJRuStQ==
=LlOS
-----END PGP SIGNATURE-----

--/0CmiCE/oIOetfjq--

