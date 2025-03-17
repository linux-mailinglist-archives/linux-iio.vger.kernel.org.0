Return-Path: <linux-iio+bounces-16975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788FDA656A9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9224A1785C7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECA817A2F6;
	Mon, 17 Mar 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Woze4uOG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B281A072A;
	Mon, 17 Mar 2025 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226635; cv=none; b=sGzjRvYFvM8JwSzfuuVl/4bQpgR6CvjXXx0B8Xt6buHZ61FpceKFJGQJ7yAC1YCUo3TUOuzYClTRg77ccClNAaz1xpFkQewPgMEkRDEVcnHzYllWghp2xIE/xwKN1Rckh6koo3HmS8JZNp9/JTPfO1n9aiG7EzJpKUAplUoGvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226635; c=relaxed/simple;
	bh=m7U8fAB6+rBctVibOJhlSy+d8mkZPMqouG2VSIkTUN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+yyhzL2/edDi8Vn7pNPnDJvCK/CdLLSbAJGtjjdmx0LyJoLBui9oeQqUq2yXHF8XXyvB0OrA4aLTs+yFVp9JWO3mMK2q9RH12cAb1ovlG2W2WO8Dbvbf3sWU5+U5GULQSeXJwn7CVM0mZBvJN90C4fBYmG9TrqxRGwsTur4QXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Woze4uOG; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf251025aso40570591fa.1;
        Mon, 17 Mar 2025 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226632; x=1742831432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqe6dWIwNAw+qNAKGhGuEhz9Q5fiLMxva+6dudY1/qE=;
        b=Woze4uOGF1rZS/bF+skEY5IiMSV1snkEyZACQK7cr9N0mmSrSVHgZG+b8fDia74sqQ
         LQOMlcK9Y1L9I6v5SQH8mt6nm2c/DU01U5mkmFud4TgGEHd1uvh4VroVslzP8dKh4JCv
         /YEziAqWkolETu7lVcciKfEhaJAYqEc+hndCJpaMjTOASMeF3QOEGqNeKRL+f2EQs3Bg
         Zt/p3uTpW/eBMxyhPfDdExNlNHPhsnPQ/d8PCsE3ABHQJPGOrsyhjoydPdkaFFaFk7DK
         N2VZK6baH/Tp/LiWHUfVLoyss+58HJ7PhNVtfy51WXc83PUeZjkXRIRNGSWsOZ94JS3d
         mhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226632; x=1742831432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqe6dWIwNAw+qNAKGhGuEhz9Q5fiLMxva+6dudY1/qE=;
        b=teEh3bbE7xHB1uke8WM2UV05Jx1nSVfTHiklIcAWEURKzsp20LUKi7itvLCZwvx4+4
         EBt5mJNKWQiGd/Z9DzZtjKZzwamn53Dlpy5Ynkt6thzJwWML50md+UcMNstzGzlnbhvU
         w9dHYkxHj/W2bvRogUmhLiYfw/Gi/ry7D+xmf5pFcN6LRwlvIFoeD21iiobuq+OpZA3r
         0RdWMBy9wGmWDvS/le9cJqHtSx8spU7Z9nVsHkUk5XV0VR/b1jC1CEqgxdvclmqxZJU0
         iEunAQG9wgjiCj4vzGL94XuRJvGrbFj/DGkCCNwk5zWe4e+A4UuZSFlbmH6zSYvCSeAm
         KwCA==
X-Forwarded-Encrypted: i=1; AJvYcCV/378ehA936YtL8zwOwCE+wnCSzBPhkn3wN3MfeJ21aX1jLsKCFwjSw6ILmm447CG5rUvw347fiT1E@vger.kernel.org, AJvYcCXQoEH5ARAjwy0Y9r8RfWyN6qOJLu6RKgFnpFSxkvJcgCdxDUGMi/UZl56hIquX0Pcc8quvsJ/yLoNfoq7V@vger.kernel.org, AJvYcCXem8lCMNg21q+P5zbbJtLSz/8bgBY69u3culm8FCADhKDUm5zDvOwhRJzIwAy9Kc6Zr5FC0ExB7Za5@vger.kernel.org
X-Gm-Message-State: AOJu0YywSgPUveLdzkoGcqrnvKwex+Z5/PlWITyx+z1AMFal7IiHuXIV
	fPbGmwL6uLa3A+TFV8rmR54dISmnG0X8LVL/RLFuqpG5hzrqtXCbSyQTZg==
X-Gm-Gg: ASbGnctnZaE0h1xZ9JrpuytbCM9ONvmvMOfXusk6i3C/qlhc3NS1pOlLXvqoX262KP4
	TO/PKUSxAkB6f21mWOFlG+32xOp/06CVFnCoQipb4e3SUSVghKfvrEqd6VqDJTFNeaAdAwoQLex
	edI21xF9ENFKA0l3U7otlxNeXpyxa4B2sVmSsU6SGwzPQ2tGR3fyvwhvSE43i+mu580ayo1kWQ3
	egNDoq26P01eqJ5aK5aBe0yJftxe6LYU5ODZVqdIv3WXnmEUtk2SyNnsBCGTy5GlFOjlUwz5Gv9
	JYndE5bB2PuEs1ZLZF9pUs6IAGLkKdvKRk9B1PgcHTMF8sBgcwdCxRGZCEc0Tw==
X-Google-Smtp-Source: AGHT+IFqtAUU+eGXTJ8RjEaj93AIVBSpQSv5aI9Dd4fjZafWNuHCehb1IpNk9FhCPSID0EQfzfZfIQ==
X-Received: by 2002:a2e:8a84:0:b0:30c:3099:13db with SMTP id 38308e7fff4ca-30c4a861c53mr58488631fa.14.1742226631407;
        Mon, 17 Mar 2025 08:50:31 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0d2617sm15918991fa.1.2025.03.17.08.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:50:30 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:50:26 +0200
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
Subject: [PATCH v8 01/10] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <7ea6dc5e04f0a72b071d373c4b44e279243566d5.1742225817.git.mazziesaccount@gmail.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sFLKwjUBG1GuSr+b"
Content-Disposition: inline
In-Reply-To: <cover.1742225817.git.mazziesaccount@gmail.com>


--sFLKwjUBG1GuSr+b
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


--sFLKwjUBG1GuSr+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfYRMIACgkQeFA3/03a
ocXpnwgAtaUEazmahQx5sUt/xCL72Ix/9P/klId8rRPkL9p90G6Phrf4ZjRSBkB/
ETwY4QNtc6gdBi+XDQNm1hLybXvz77Wa4zfoSo0tb3t8siy20F1/qkrfc3zWdXH7
NxmhTwb9/e/jsnNMG7PM8fYrwpvFMEIIrBff5zQvECjeuAePjwaqz4hMljG6myDZ
5tV7boqkaJE5jtIl6YgYGoaLVV+wz9YGnXHzRTyuJGMMXL0kCU+HG8dWSZOZZSxo
vII1M57H2/syPAQqvaOCWsYYyArhU58HKt6tIjnMmbvSKn5qKwXemEA7EVfvyl+u
jsyZyWkPxuEWhl0avxLuGXK8ZeEUew==
=Qxk6
-----END PGP SIGNATURE-----

--sFLKwjUBG1GuSr+b--

