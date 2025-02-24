Return-Path: <linux-iio+bounces-16025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5038EA42B64
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60EE7A3FFB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87060262D38;
	Mon, 24 Feb 2025 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVdv70sQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B695264613;
	Mon, 24 Feb 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421960; cv=none; b=kIVqFqndaqYfpjL+2T1T8CuJAFxhA9o3ov8lx2ual6MRIUZ5M6QZEtPpiAiceVGMgRL+/fgYks0v6eaz2MQAki5C0FH1/2ciKskhQGZhf+k8A845zSk35C4VKMg6gU2pX0dfcsQ0rMIsY5DNxwvoV/cwgKDOd7Fj2Viygn7niyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421960; c=relaxed/simple;
	bh=98uB1rbdWm3A58E80bor3xFULFwAE6GtkDVd4uWUY2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJFROk+AX49BHKBFCAEtIUR/NZi5EqFpw6xp6G2FSL478arw8b10FtB3Fja2o/mvFbZusSlScQTbtjsjB/y09bHv4iP7vp7FzWpPllVCiZqY+wWix1h4lXYP0xU5Ftl3vea5Nyxvbd30MWIjksPW4tO6O7LB31D5y59rItMNeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVdv70sQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54529e15643so5285935e87.1;
        Mon, 24 Feb 2025 10:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740421956; x=1741026756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N39GuLsH/GHnLWfi6A3DaLvaYCvcqGiUvrrDOML07K8=;
        b=eVdv70sQCN1jkqLwXhLeGG4uLtshEdmrcIswwawv4e+/XZatwc3yxdabR2N59nLgKy
         hYJ6QlcBNYG5bM9uvEbsNVRo+b2BSWCx9Dk05dyXzP77fkYfz04+3Mqx6NoIFwnfKNXa
         lbQHIi6Oi5ZRvIeEowJuLxt6KcUyilHozpYbc57JuDK1jrvs2lISlZdFSBU+zl6CxtTW
         ZPUK/BWgc1JAY85OGfjdWgd9gPBHIInzbWuFIGAVpfboZxK0nHSCoZGHuZ/2gQfXnsId
         mTRz2Yfun1i1SyBJfgik7UEJ843WiIh6zN1gtwr0udEFNZ+4MYvWhBtpf6soyV22uyUo
         L+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740421956; x=1741026756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N39GuLsH/GHnLWfi6A3DaLvaYCvcqGiUvrrDOML07K8=;
        b=kteTx7xedyVdOS7RLGKVt4ghaVQTysl8ZFkOm8alvpX4G6mhG1we4uZUiUziGPqjSS
         9YfvaEimIVM2fXI3UCFY1s/GMjqrCRs3+7UxPMEsWktLFMHHj13+UhsU2wIuxfsNikcV
         FhzdmlT1aEO3bMidBKDLnf8k/S9xhB6P5Fjw7NbTMi1/7plPgrNlSm0fKSjZkhLYJe6+
         ruBPAJgESQ6ZdFEUzbBaIqSQhAG5HatA+3XSARpPXBJ2fM2zlbevuiodqlXPfjrp9Kq+
         KvZs5PDQmpG9hCl+uOKzw3UGSYOaWJBiphu6qA7/Gj9ow03gWJgHCvcHBRKf+vKqF+1E
         kXKg==
X-Forwarded-Encrypted: i=1; AJvYcCUpWq0560LEtLPAXovHUgEWZNmY/vvnzueZHW/VpbUM3LZg0HAL+zhVP7JGX/v+Cifv33MRVgFGgol7@vger.kernel.org, AJvYcCVDHL0E4mpQhXh1VSU5vcbH3gonZj/DoqNiUt+DlkxvgQe0FIMaRYQBXSirQ/ZqrRNSLN3bfnEo/bJz@vger.kernel.org, AJvYcCW4YsJZ9qthKJdGAl8aYXyBARfddAsg/GI854zv2uCvep4hr9dWkeOmFYqU6k6kEJbmjtsOm4YTlvlNfWm2@vger.kernel.org, AJvYcCWCT3AS2DA5ktoy/ZYeBvL9bQrRPu6+3B2B3vTSp4SRJAuDt5UgDU7vsXbg5hO1H3mi4/UrsSFoQEBaV8I+AWgCeWU=@vger.kernel.org, AJvYcCWcAuJraHyXtsboQWkrksh3hTEHkxTCQuCI1TTgk5D4F0vPB6FISSGAEiqANyN6i2rWd42YaZBSJyhuSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8ToiI911YIKYIh/CeCJ+CoOhJKCAKDTPZL6Avifu9sjfcwUn
	V4RBOvmblhVNw034V3kvUOSpBfYzAy0S8RUwg6siJuB/Pp9yxaj1
X-Gm-Gg: ASbGnctZyiC0PYGZgVelGK3rt6Ngq0IHtibeVArAdBtTlAbJOzd9N8PtIJ6t7xsrdQT
	p2or8PBjzem1aE8yY25k/8mhUzu3z/DjBr8oMKWT6SVAo+5ONirXIZbK/6egavX5Zcffa7r+chw
	/pC0XQ8hdNry7qplYevUsxVjv8cYt+VkKy//ksIwNBua7TSRbOAZVsxZKPK6IfVk8VEsQo9X+jr
	Ui+GDUdTPctQ4GB1mBayxr+DZJsaBlkutGamErZ/kshijYA6ny2fCcgGG8F9I+yJOOKrraEuKjW
	qTkYKy+PO6wkzbUkq6AKCK+pOUYKmKSA
X-Google-Smtp-Source: AGHT+IGuoaXIvmZgefmGuVB5f6nZE8zpUKpcTq1FcueeKygwj6PXc2F3VGYVqvK8LafWdWjrrE8P6g==
X-Received: by 2002:a05:6512:159b:b0:545:fdd:9ef4 with SMTP id 2adb3069b0e04-54838c5e1bfmr4544720e87.8.1740421956169;
        Mon, 24 Feb 2025 10:32:36 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54771f058casm1259809e87.188.2025.02.24.10.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:32:34 -0800 (PST)
Date: Mon, 24 Feb 2025 20:32:29 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v4 01/10] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <4d390ca96434a8ee35c0c850cfe4fd49e99db653.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OoD2QNHpBXvMQxnR"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--OoD2QNHpBXvMQxnR
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


--OoD2QNHpBXvMQxnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8uz0ACgkQeFA3/03a
ocXYDAf/aZy7lHBMV/y8BQfayGuvRMNa+yzPpPHq/dU6XF5PEhMqMJ3UsVOhR+1d
UGxrDIENa7xyOPAw3ixngeMix77PFLLj/SwSFcDID2NWy5h8HsjTPdIlPZ+/2m+N
5f7BlMlr7tJYGxTerh8S9zrB2JjLQu15lX9FKyjbGwyjBeLJNLur6WyGPLVKxlKC
lYtZN4TXAoU1slNTQkNhaOeJA6MBzokAx0R9Le6wvULUuzyEykpl3k2ULVnOXR8/
zSGA8NBGCgJYExdvpYqYy8x9b8yZec+Lz7/OxFKuylNYCSm0E6K6nNJQY+9V3Pt2
m0cy3LLxtBGaVFknxcgYneSUA3z7iw==
=70g3
-----END PGP SIGNATURE-----

--OoD2QNHpBXvMQxnR--

