Return-Path: <linux-iio+bounces-17528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E55A787D3
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD86516F023
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBA136A;
	Wed,  2 Apr 2025 06:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQAyJuHH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C165420CCE5;
	Wed,  2 Apr 2025 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574093; cv=none; b=qdIfYRjQNs3BunD7b0bU8wWacI9IAjz110JLej3D5n7CN4HxhAa5BI3BYXXZHQvbs17uYLi+efXvq5RpDa1cIxs6KQwcejMClXzjtd4JUuGdz0NwvmqguCtQGAUD9uT5ge9yqJUSGB4Y/Ph2vV6DN0uuyOTjsKsOfTdxE0nTVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574093; c=relaxed/simple;
	bh=eZxZTq6pS/HM+O7v0A9dhvmyld03qEHcWwbI3YVhT3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMS+WRMw4oGMe4QssqYjpKHFHXCA74IudnPMkXJPQb7LjDDQzRlCAQxXHyfWMeHnoeK3u//GZ5qE347wiQ8ByHKyRn5sCPa1qhUm8XQ1V4ewlQHa62zQpC5XnU1F9P4RdpkV4S3kB3hO1gwLNLFqtdYJNlacItNlg2UGIcLXAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQAyJuHH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so60359051fa.2;
        Tue, 01 Apr 2025 23:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574090; x=1744178890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sgeAVPyjp9TCbQljkQodgNP6c9gbbT8INwjJ6cOTjI=;
        b=bQAyJuHHFesSIx4iDAUT6H09U6QvB1ry1WFXt9JUkkUSP7bx3eqRWYrwkgbBDNtjlw
         S4t8a1QlaMjrMbfyJAaIpn2mvvHFbq+88LVHd04BO+w6cW1PcqOGYcZsDkfUDJOWeKJf
         5IQXWhaYeOTAbB666H3vMF4XhrLJrPtJy2NucegJwU4SfQMpKAZZrNYa/EydglgbO80V
         qfMEfOAsapIuhoTkaqVuAQPyNI+IivCLolmYKBfBlgxZeabsDPbkrVDMsZ344aEjK8sI
         h/Z6fYEX9XcHHCNjOIwxednww6KGSvheTrASuE43mz+69x+Oe+9rdBu95MCLIpaEuiSq
         LvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574090; x=1744178890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sgeAVPyjp9TCbQljkQodgNP6c9gbbT8INwjJ6cOTjI=;
        b=G0gH3EIxt0JLFpagwDyKyZDxWOCnkkQg8XvENqBy1QHgqziNXNqlfN7QrGvu1/A3l8
         TJvP60xw38QFhT2uOsmnWP5+3BO4COs/uCpcAOp/2onhWTpOK7NzwXYxGjI0t325Yof0
         V6mWaubOGGy+Vy96fNVcN1PbAQ5E9snMib0hsX4MbANDrZhh1V4j/PF2ZcVuLdFzYQ7s
         IHe0u9NgnDIvPnZfkM6ujLp2bs+t1Vt04sCsHNpjwXCJJDwDCOx3cmrg6ox23G+YWPbJ
         59tPuPgTdGjtl7Xvay/8FQOBvR7fd3pDOKp6b6NiX3+DaTM4SlJ5BQW5OHLAI8vZVRq1
         hvSA==
X-Forwarded-Encrypted: i=1; AJvYcCV5u45C93tO+zzyV/csthBzK8e2fg+au5UdKB9VrbLXt/ZWjRi/l5nMwvVuTfNUp+UK6rZNkOhCp3e8o8Rj@vger.kernel.org, AJvYcCWyUj4LCBxWuHLBx41QhXyAylZRc9yiAzEn1wyKXSS79S31JgTIC0hmWE1LR4J4/mDILbpXzfGeoURH@vger.kernel.org, AJvYcCXEdHvMK7aL40G8OxIshIG5joE7fC6yVqAE/1dVBDQcjo/vtqWsGrHYiNk1fYZGJ6PQCdGSpg+PBvjC@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYD+7U22UNFbB9A1/S7GgZT3m7vY/oNhAC8IBUxF+g0bhrLrR
	tBNlZPqxXRVGnT+HDGoZ40z2dd7JzUkEP0gCm4p4h2l2EQ0SkKvsfqyevQ==
X-Gm-Gg: ASbGncuDaBy1PW+Lcq0NOvUpPhciwGq/PRt4X5UvLTDv5CA4seK1NzThqyw8lLVvtAZ
	oWXgaEBjX/4pttjjNxyqAMReX5Qz+/q9h3No9BeFVcofBFLGh37gDDHsTKmNsswWY3l7gmk4PFw
	EBck1ZjUQAoi0VQIpZCTSzG9a+DHGAIHZU1YGeOdczWOvTaNv1CORVVqm3yCsXkkaie1L7Rji6+
	8VLZ1aJZruk8m+3ablCIQB+0J8banB6jVZpR04zCxHvwnUFVvUg8NNRVU9O4NwKhThuqAnmKiec
	OIJPWHP0LOo7dbHR28xkfC8VMZF89VflOH/3b7g7Egf8hXyEWqU=
X-Google-Smtp-Source: AGHT+IHigyHi4jlFN/pHTxKJFypJNcHGZohJMMr64IHaxZbTy5fjoqi/sXOhsNCNh/TGmfjxuVQrRg==
X-Received: by 2002:a05:651c:19a7:b0:30d:b309:21c6 with SMTP id 38308e7fff4ca-30de0231ff9mr38186611fa.5.1743574089474;
        Tue, 01 Apr 2025 23:08:09 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b4c82dsm19825911fa.72.2025.04.01.23.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:08:08 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:08:04 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: ROHM BD79104 ADC
Message-ID: <7660772204c9f738bec680b2dda4e88173026214.1743573284.git.mazziesaccount@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i1tRBlfWe8RbE1FC"
Content-Disposition: inline
In-Reply-To: <cover.1743573284.git.mazziesaccount@gmail.com>


--i1tRBlfWe8RbE1FC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79104 is a 12-bit, 8-channel ADC with two power supply pins,
connected to SPI. It's worth noting the IC requires SPI MODE 3, (CPHA =3D
1, CPOL =3D 1).

I used an evaluation board "BD79104FV-EVK-001" from ROHM. With this
board I had problems to have things working correctly with higher SPI
clock frequencies. I didn't do thorough testing for maximum frequency
though. First attempt was 40M, then 20M and finally 4M. With 20M it
seemed as if the read values were shifted by 1 bit. With 4M it worked
fine.

The component data-sheet is not exact what comes to the maximum SPI
frequency. It says SPI frequency is 20M - "unless othervice specified".
Additionally, it says that maximum sampling rate is 1Mhz, and since
reading a sample requires writing the channel (16 bits) and reading
data (16 bits) - we get some upper limit from this.

=46rom the "frequency is 20M, unless othervice specified" I picked the
maximum frequency 20M - and did assumption that my problems with 20M
weren't related to the BD79104 - but to the evaluation board
"BD79104FV-EVK-001".

Add bindings for the ROHM BD79104 ADC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---
Revision history:
v1 =3D>
 - No changes
---
 .../bindings/iio/adc/rohm,bd79104.yaml        | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79104.=
yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
new file mode 100644
index 000000000000..2a8ad4fdfc6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79104.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/rohm,bd79104.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM Semiconductor BD79104 ADC
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  12 bit SPI ADC with 8 channels.
+
+properties:
+  compatible:
+    const: rohm,bd79104
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  iovdd-supply: true
+
+# The component data-sheet says the frequency is 20M. I, however, found
+# that the ROHM evaluation board BD79104FV-EVK-001 had problems with 20M.
+# I have successfully used it with 4M. My _assumption_ is that this is not
+# the limitation of the component itself, but a limitation of the EVK.
+  spi-max-frequency:
+    maximum: 20000000
+
+  "#io-channel-cells":
+    const: 1
+
+  spi-cpha: true
+  spi-cpol: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - iovdd-supply
+  - spi-cpha
+  - spi-cpol
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        adc@0 {
+            compatible =3D "rohm,bd79104";
+            reg =3D <0>;
+            vdd-supply =3D <&vdd_supply>;
+            iovdd-supply =3D <&iovdd_supply>;
+            spi-max-frequency =3D <4000000>;
+            spi-cpha;
+            spi-cpol;
+            #io-channel-cells =3D <1>;
+        };
+    };
+...
--=20
2.49.0


--i1tRBlfWe8RbE1FC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs1EQACgkQeFA3/03a
ocVWEwf/cwPRz29uEM69zN7uOaemKSz/vRvWNjOu8y7yX8fC/hemm9oPECDc6+gO
GKXlIlMiMslYZmkF0jO0Uz+ZBDOkvLmQiqrmHHmJ/PNhRHQ8KOrjb84U6QjKCFE8
ZE9Rt0NK64f78vLOKiWIfQxB/VmxsAhSUzpyKpo03rhwRl/afgGF5hXav69mXVQY
mkVb2v2szzpkUfZOcquCzfzEtGZzehZ0Vo61euHfrjnYhhizbP8AHAheI++doqOY
g518s2AfCfAqlzhSGsJA+pRfJotdSzG9RkVzUkv80fXxlhJX3Y8PJ78OXWHvckWU
2vJAczPD+E2gyDVFNmCqEIO8C4KN2Q==
=8N8a
-----END PGP SIGNATURE-----

--i1tRBlfWe8RbE1FC--

