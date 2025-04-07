Return-Path: <linux-iio+bounces-17751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766C0A7DB6E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 12:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A173AF4D6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78223815B;
	Mon,  7 Apr 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezp+d0l3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67548199E9A;
	Mon,  7 Apr 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744022714; cv=none; b=jlT8hGT9CQ78VlgtYz156PYG5+SoDpUa4FMFKpSMvqf4ggrNTKnVrbCbQ3iXJx5dbMhevSvgC6vUxiv2muBInGylbxWt6rcH4wulMdj6JxyGsqrrBMKOWEPu65LTvMpt5CAb/p53rvM8ozhi8FCfpbya9+9CIm1WHRrx/B74ONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744022714; c=relaxed/simple;
	bh=NXPOzpeCwPDnycPH2c7OfmWVhNM7SK2Xf7Bt8/1zCaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajjU6jvGIDVq6Z0M0kjf3eb9XlE1+V+bRS2+PY54UOVkx60d04bswzLp87gyYrzCtIhWGPjj3xeUWrKMNNlitL30E2fCuZSv75dp3QWJdowYfKXVCmkdcA1xWWlQvc5kgTTGL1c/3EF8x5Heb8yq3/dFDTeMHqDL3u8ZuzH72IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezp+d0l3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54b10594812so4740306e87.1;
        Mon, 07 Apr 2025 03:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744022710; x=1744627510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5OIXlm56gKmh/A9Z+P9Y2yDvHss8pWd/2p6nBUoAZc=;
        b=ezp+d0l3YTqaiQYTfYk9t9XcabWjtBphWwSo2NBwAgjq4OuHad5V9ebpO1xJ6buept
         fwiZjoiH/m2anCCD55ATeHqD8ZolK+vpMwgiiCEYKOeDr3FherLQzBQkgP6gv2Vo7uMq
         O6uwfdfRxrPyvLCwU9nk1d09AL06Qt95I2RLUfwdL8dzJQsOMq4Usswn3XH4UmjXRyDt
         6CWmLc3uhu1lSg05Oy2CwzYV8gdy2pE7R5qIDP2Tq58dman0sqp0pzOldBHbG5vqN52j
         4E89DOiAlqDpzF/VZ/DJVBFPOmAoPllgzrsyzPh5YKwc2NlqKoX+EtHbNuFGY4utc7Jc
         xMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744022710; x=1744627510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5OIXlm56gKmh/A9Z+P9Y2yDvHss8pWd/2p6nBUoAZc=;
        b=t7ewdFIboW61xFtd4BCENqlqFw3o0nvwO3EOrqog5dDiBU04h3Mxp2TG6/gHBeCFXL
         Ryla8mAmx1x5qGayXqb+VsTYIfoBAuATDCTJY5wVNFx7Ua5gGCh4T9QlCm4/FvFU0j7k
         pDl4i6tRNO/wtI4vt2uGce9Mh/PplxtuD60i8WW39Dtf3Rxos828sHGiji3RkRXy8CBu
         FbGaNf4ORoarZgIrVLdUPE53zmU3FeqYnaiL3KPJmy/+f+g4pwF6qha3lgk0mD5lGiAZ
         oqauOaJXHpCJt2LYZapkpA0GZElKPgkWFiz0c8Uy53QgTCAiFW7flOH5OSM9F1W0apje
         Ml/g==
X-Forwarded-Encrypted: i=1; AJvYcCVM0WXMMDb4JmxCAXfDQP9PEU3BzL72Y/5Ir4tTLjoDI0rLdiqSYhuPqV/Q4OgZX6y3tyu5BsUs8Jtf@vger.kernel.org, AJvYcCX7lG7x3DFKMr/vFkB1D3AMTZv6MKdYqCiycIkJF8V3bmpoNE5HzWMQA5xhXprHlAUqyd7xhFxY1z1vVDlb@vger.kernel.org, AJvYcCXqiAHj8RFzwe/zQ7YV8SopUlIrMT12LaA4/XY11NQ4RPwXfToqKfUMtaQl9OOsB7KCyQjWXluKc2uh@vger.kernel.org
X-Gm-Message-State: AOJu0YxNmiZ0w8V0RZPQ9AkM/Phcs8iPBL+DRK5FZyo5+SbzWBMNeIH0
	OyGpCdVa9IFIg1zjgMgkhN4i1PFCvFCCgrFK8sh3T8TR68CkT0dc
X-Gm-Gg: ASbGncvlUCfwWSrDBNvC7fCCrYHqzntyKhB7RGnszCTm9NsmHCvNNSTbV5Yhs7YmWjb
	Ow/7O4U51J/S1ORa/ie3rVYFfNAn7NBHXPyw/KiUsq9iaAIcKPyxJVt5+GQAud8XWxvaHQV3b5y
	RBtmKK5QJ6StpiqVEdluO70VPUfQhWjTwkL3ruat7bMI9U4kT/swMDeJPTfE6Yu5KzkgX/AKtMw
	fyjrZV+vOJqSO0zAuRLtNc033QQNflXkdcVlpbb+79KR0Xjs0mLKXOAIlFZPj9P2MWz0LWozzvr
	KK1dv9IEGd9XZDgiI/4tWJZoh4XUrD1i926M5mBCOopA32taGCMc3KvXnOkaUA==
X-Google-Smtp-Source: AGHT+IHQ1k7gyWSF8meHnKZO7bwz77/mvDW2LY7CtZ8hMaWsRkVM1bYe3hg+yQFgQX8Y/JpvqT8STw==
X-Received: by 2002:a05:6512:23a9:b0:545:cc2:accd with SMTP id 2adb3069b0e04-54c232dd30dmr3059697e87.20.1744022710277;
        Mon, 07 Apr 2025 03:45:10 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5ab7besm1196646e87.41.2025.04.07.03.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:45:09 -0700 (PDT)
Date: Mon, 7 Apr 2025 13:45:06 +0300
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
Subject: [PATCH v3 1/8] dt-bindings: ROHM BD79104 ADC
Message-ID: <2a4c65ee35cb79c6b29dbc59cfd9bc7d615a08ac.1744022065.git.mazziesaccount@gmail.com>
References: <cover.1744022065.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O8gRmlxfIcnPzpYt"
Content-Disposition: inline
In-Reply-To: <cover.1744022065.git.mazziesaccount@gmail.com>


--O8gRmlxfIcnPzpYt
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


--O8gRmlxfIcnPzpYt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfzrLIACgkQeFA3/03a
ocU+KAf/Z+/WedUM/rG4SE4sEpVryEqtkh8X4fOtxC8DyYQffnMls8DksTu7VO9e
MuJuwJwQbCQnD7YsSpSj2mUQHf9HN4CI08SYusQRfWkiCNOcCEJPk8wJb7xIJlq+
rq5k2YL597KkB7MXS94YoqgEereRLgK2JecRoyPdB2Lw7M1OcVRIkc7lv4X1e+9E
ENek74cKGU7uRrZg37VcC+e1skFNmFK5HwViYcRzeG3RS/Shx0TuXd2YSByW1iA3
bmqo76zg5LKHP8CVKyIDx3HIFvd17RvwVFehQjcxnLOhyHPxOT4rWX55Y0fZhehV
MwGbghpuYv+Tn+ZMbWxDGa7ZwOD6fA==
=BiuX
-----END PGP SIGNATURE-----

--O8gRmlxfIcnPzpYt--

