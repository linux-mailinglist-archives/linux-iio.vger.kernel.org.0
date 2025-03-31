Return-Path: <linux-iio+bounces-17401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62DAA760C3
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 10:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2394D3A471E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A151C84A0;
	Mon, 31 Mar 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw+eAWJ5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DAE2E339E;
	Mon, 31 Mar 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408149; cv=none; b=Wzl/fyHHdLgdc70A0lc4Qxjdi+WWVkrDj+SLSZJgg7OEE4pP4lq3SnXSdVVQKDrzqgM/4/srqMDnNj9Zz51Sw9zNF7EVV8Ic+heUlBBM7TMEcQ/6MOdaQUVU5sk/AdCdtmNhU9IdsRH8Kkd3BDd1z2wGnpyTEzHxd5gPV69AHKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408149; c=relaxed/simple;
	bh=5rVe9imDrBqwoVS3nmrzj5OiIc+q5Cb9W+twR5Yfcio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7TRn9J1N2W2QVyv9xtRmJoT84LW2GbbJsSRVbC5JxFihjhdrfFxwdsy1u4+TMnxw0azsxCTY9hQ8145wVwtmwZMyuu43AYPlJPKP/T0R0wm5mAj01SU6+4KA1BiJe3kOSH4c2LisCm7dadrENWmi7XxNgShKse3MSKLEL7famQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zw+eAWJ5; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfca745c7so37000521fa.0;
        Mon, 31 Mar 2025 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408145; x=1744012945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lul6pYDrqMp2jglnr5NoE6c8rK1dP6WMV6wVzXKjElM=;
        b=Zw+eAWJ5XnQWboL4NqPDyIiwn2xJAMMDGVxk1HuBm4aBq3aZQFbRvhMl0RbEgjVKF0
         x4cts0vDfjfw//WGrYyoQB0kDsiCxmao3ydznmN5a1mC9KcjVwRngTPVZC7WY0qXwxEq
         gs5UIpGhBz5r2tm2/F3qJGpLcejCYe9FY7j1FLeiJChrEHYXPla2H444hmYg3mMy9LdD
         5Dr/69awVDcYqeRfX3K7kyWOzso9Oo3nNaohF6IMgmhBphotxB3puNBh+X5Zgyj44fkp
         AVb75ybPzPucEMo28Ra9xd2Zr04qH2zxCjq5xx/F6f/dkZLjByp2bcJKoxJNEMBu5sKj
         M+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408145; x=1744012945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lul6pYDrqMp2jglnr5NoE6c8rK1dP6WMV6wVzXKjElM=;
        b=YQUnPMrEyxaV0/b2XfdgS9sHhDXZA4qEJ/iMhVGyyyaMXPXJIiwrJBHnN67PQXs4fV
         Yyn9jtKnxFu0oH18JCDL18OSvQLRKHWCCpv2eMF7MmnN1CiGHqjzu3u88eJo6evc3ZBU
         DNytn3OevZ8773tB5IgGhDrxoKqhe+bys1mnDnNvjNQW/9Y+faJqIK4MTIkjgBj0ieQC
         cHJnfMDAui6aIjWfnCn/t7aHVAxEJFN8hAMxjspJiZPdFz0Us1LE/2YcKzG0ud7+5J+b
         rHj1WOc7Is0MBU34878YqQh1d+iFWTsflPYWfLmgRcKooMKGPiQnzn8+xu0PhK0nZX1P
         pLVw==
X-Forwarded-Encrypted: i=1; AJvYcCUNpW79VV0x1MIKgbaNSnHZ5Drx38ZsLkIN5UicV6nLMrcuTnpFZZ2m6O9PNg1bNWt49j3QzamHKEwB@vger.kernel.org, AJvYcCUeLNrNqm6rR0j5b4Ox2ibyiu/RkmWc2Snktz30w5OHv1nFVTonTGciXnkKodtj9+LwxdYaBK+X6Aiu@vger.kernel.org, AJvYcCWPMNz+EAt9g5VqGpnf3oXNA0gnRVRB90/zkR2BWiTmVDGWrnmboeuLnDjbMeQNdTiSFX0x5Eednerh3LPu@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXLTRmpd9jYDsW7hiay1RSfDFsLaLeM2GSjtX3/CIYBm5vKBs
	I2KrrbM+wo2V2mpYmBEJ4j8d70oTAPCqEXxdIG78t9QqT6X8AnZa
X-Gm-Gg: ASbGncvKce4/RXXMKlNRAy/istG2OkAexa8jXCdy29ZPBMhiO+LpknHXqM/EHYhWX07
	AvVaE5QdZcOMzzSXfoIj7NWKeBc1D2GqniXZTxphHem6NcyrarwY4dlnnJywvn6/tCkcOst5NUT
	J9dwq/HCsyb4fTbAe8h0s4RZXtEfdsALNZlqTZMrTzxjffCqtruQ2W/MgRFaXAeHFpfJPizmjVZ
	0mqBtlOvdaunOjRzitl3B48Ra2uYTumPUSEqJBrrHl/s5EH3xS/feUSMUmOtPaUDT1gkK8B0V3O
	c1uh0iiiPMwSHI3QyqgiXdGSUTo93sz2PgS3c4iEjxdTEx4wkS8=
X-Google-Smtp-Source: AGHT+IEi39YS3JIYQbYEh/M6rfvzknIbHLZ2VCuLIAtWb097g9mbPKqfqpvseEV4eBTOF+x1ZvsOgg==
X-Received: by 2002:a05:651c:2122:b0:30b:badf:75fd with SMTP id 38308e7fff4ca-30de022ed14mr23208701fa.1.1743408145318;
        Mon, 31 Mar 2025 01:02:25 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2b599f0sm13062291fa.110.2025.03.31.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:02:24 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:02:20 +0300
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
Subject: [PATCH 1/6] dt-bindings: ROHM BD79104 ADC
Message-ID: <4ccc6d33ffb0fd29f02afcb9124a0f72f571a0cd.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1u29wmuWIMkhiD7n"
Content-Disposition: inline
In-Reply-To: <cover.1742474322.git.mazziesaccount@gmail.com>


--1u29wmuWIMkhiD7n
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
2.48.1


--1u29wmuWIMkhiD7n
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfqTAwACgkQeFA3/03a
ocX9AAgAhHdn7sXz/kEyFmYqBYKBQAP3XU13BE2Z6y25zPP2XSAokgthRbZT/HL/
NIFEZOQFalLBoIWfrTbx8UcLo3wOdLzXAD37YtVWIf3VFZXT3U8J8QAvdeOe5O64
AiQUzVTg2/g8DTLem7qY6RZjGsJ5BD1Y9azH4AivwxM6N955wKyXfD4RKOWVo+CX
3ssl4/wNcSeSFcA+iHGIo0qT3KV1u8A3wzJrrF0nI0CoZqG9Z9+9XouLsuOhIF8d
iopUUSKijMFGUXEwLpA45rtmR1IfgtT1fVBR/7orSI8z4auYpWgvPbcqdttCOfXT
z7cUowDPq/q90SMzokSRs3xrRfXBmQ==
=xMqb
-----END PGP SIGNATURE-----

--1u29wmuWIMkhiD7n--

