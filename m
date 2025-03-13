Return-Path: <linux-iio+bounces-16765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD860A5ECA8
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 08:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04A13B2437
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 07:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B14B1FBE9F;
	Thu, 13 Mar 2025 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce3CRrmd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4EB1FAC3B;
	Thu, 13 Mar 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850250; cv=none; b=V1mXvyLwKFroK3o2gpKzsjVw1xjPa1BacTsJHlZj/9NeviYavhOhyCfDNZZFJF+rUf6FvCWgCvLug7LDPlX6zXAtpN02KZ/U3mwOhGfDwOKCmRvATOlQDZuwKzcnM2Zn0Fi12hl1yzn8VT4POsuKl6R0kkNW+3eP0vKuOmyOSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850250; c=relaxed/simple;
	bh=4p6Gfor/SOc4asbcBSEH69X2wY3cJibrS9BOl5THn7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3z4BEAFZLeGUdC3LTvb5JlsvjSSEAKxSWPZMTzWOlE1OJPCuPgmricy29IL/rb5AVYnKSXpQeua98fMYNDPQejE7TAXdYE5nueGnSadpv1AM3xbA0jPmBuKzp6qGNOKVzQ+17rH5YchRR4P/oB9iZ6bHilJ1N2S2oifTJYoS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce3CRrmd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54998f865b8so561549e87.3;
        Thu, 13 Mar 2025 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741850246; x=1742455046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSr6AMaC8K2l4k/tfNq/2fUjBVTyE/z7zvPNDZY9oNQ=;
        b=Ce3CRrmd1IUZgwB9vzZeEGOccsVa7rZ8MsjICmjipj4svAlKihTGr+rSiT9KsNjgJy
         jkYi0trQ9wZkR0tYve/looB1+F5uTrFWD757t+I32OzBEwaC/WkjfXk9Kq/aPyOdY9mY
         8/VoH7T2Vyq8gLEBpnbb8aP1QsV94vvZxy3hp9GKjCXDR3TnHcXxNGtATsbpqYff2h6f
         kd2JW+MrAw/b2wou6Ho+YbJQkOabQN7+szF3WkTBtTz8BTG6y7Kk93FLY23a449AVMxp
         zk6oMfgyvVWW91SoSCo9Wp04lKtFKbXJxlfEyFsGpo4fm+dMmh4oHAjun3ot873b3dMU
         98bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850246; x=1742455046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSr6AMaC8K2l4k/tfNq/2fUjBVTyE/z7zvPNDZY9oNQ=;
        b=UdYREsi2f3tyoaCuZgU0t20pvAkMUbQAtuuxYVk1+KK617lVn4ntlYj+eoj99R7myJ
         n9yWfygL1WRDHa6xxbZD6BqOtrANF0aV9QH55i6A2O2rlPsYsxMo23LrSIVNmt/ptVUv
         tyhsgwQMk7qgHaEOYHLQ4gxr9XkQJWw5t8gXPfgUdthJjum3vtUq59I6nN86LcP5tZIj
         TdfSbC9Orc6WTfiPG7mZJXfol5soN/FM540A9hBF93x6I4vVfvLFS4tpTjryX/ZpU+Gv
         e6RKGOyGz2tSZehApNxCqpkhdEUmvZlwYvuqlsV+FNGyMW1qARXNvyXSlNiQRJetOO8m
         3j7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCAFR065kvYI2oCe0tByH9oJ2uGFaStMJ+3VCMB39n0HYaDoruyQtNBJAum6lrFg9Naaui9V6hH0v7@vger.kernel.org, AJvYcCVMQJlNIRHk4SwTkDzNNCWxOTCQJvMoGi+X9XFUs4MnBR8ovOv67xXpy/LGKotLZZbtesHmYQnKAzuXFuGi@vger.kernel.org, AJvYcCVhhV++8SjHQMe591zrCy0IBWMqYeNu0GRtud5J0rIkalOmFOyrsl38D1KvkMAKDhWU9gJlWwIOyTLb@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxB6K2imofT5zlp2S4eUlhZTGP2qQyXsTw9fzQKycVSaMbZJk
	qGTQ0RBlAPSPISB/c4KGawv1zUvzizDltqnMXbdeNNNk2W1BmDxegQ+MTQ==
X-Gm-Gg: ASbGncvB2RKFctqF2opN2u3TVJ0crlW1ZkwOraPLjj7pffNwh7KIelj+7DBwBBZMik6
	jPQqYjzZeCkbh00hlMQu5NsNIf1hh2NECgUmSpcalaG1+q5g1vic8QGWqWgwUwhKUv5J+tpWU0Q
	2x8sdFiedXghD2w43RVtfthjIgZztUDZaSjQaAkEw3LW5eqWAqWlWtyYa10q8vz0YdTUIPrcyQE
	UkaXkL3Uq2TNavzsrmyAhzT3xNTiKKZY8TwzvuyNEg1CuYzJXZInt6J+WeCp43TkZk+tSCVl8Mr
	5f/BgS67UzhwGMBLpkizOga1rIZK5n2OiiALfkRNrPtRZ9ldU20=
X-Google-Smtp-Source: AGHT+IFw+3SXgvCsmWZmhytQtFza8X3PaBFUnEOSUnPTiiz6PPcy/w1QxUoBPbfOR3HugnkElttR7w==
X-Received: by 2002:a05:6512:118a:b0:540:1f7d:8bce with SMTP id 2adb3069b0e04-54990eadb4amr7628734e87.38.1741850246236;
        Thu, 13 Mar 2025 00:17:26 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a884esm120722e87.11.2025.03.13.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:17:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:17:17 +0200
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
Subject: [PATCH v7 01/10] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <7ea6dc5e04f0a72b071d373c4b44e279243566d5.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7FQYMfPmZM+y/XN7"
Content-Disposition: inline
In-Reply-To: <cover.1741849323.git.mazziesaccount@gmail.com>


--7FQYMfPmZM+y/XN7
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


--7FQYMfPmZM+y/XN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfShn0ACgkQeFA3/03a
ocXYLAgAzblEWxUU32W28Y2HNzrxheKDM7NdLnMpBH9UNB4NZyhrXUbKSW/Y1gaU
mZaNgM68V919J5zqjPYXV2pJsb0AWkRJC7dQK9aJ+eNyqUHf64otNJXA0zklxc1A
7TQ6j/NDJj3YkrkdFq1sQ53W5Jzw0w9n6AuJa53f7D5IMPHkUf99JfgN0Orcs/tT
KqDrBydswg74/wg9/R2tbTnQggm12wr7WpUXldjoKLIdj4vwXe2Ha09WKdx5K4Nk
PtdDYPw6x4YhapD30qYQtJCvYzfrBZS+J4Yput0rxp4hZkC5ZCkYk4Hj1taBeZOh
eHZag5NF9w7coZWILxMQjm0B9D4P0w==
=g/Vg
-----END PGP SIGNATURE-----

--7FQYMfPmZM+y/XN7--

