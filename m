Return-Path: <linux-iio+bounces-22392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B18B1D4EE
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AC4178869
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88513263F28;
	Thu,  7 Aug 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehB31vRL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94226E17D;
	Thu,  7 Aug 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559323; cv=none; b=YpY+mq4+tBMq/HoOjqxCwXm9169BADxC5O9ilW7TOeKqlg+5ZST9CZCwaC2zLcCxT0RMBA3MIgb8kkJubS9oTLxVNzTVZPWm9TaSMQ2kLRWGZoKogMwoyeGLBJqMEoEclFqIfHJt8PfgLnF1Yi4hqd5+L/Ls9K9AkS6ih89S1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559323; c=relaxed/simple;
	bh=WUneGp4dtEsWDnOkFFAGx2PzmZNciVfF21HyZnrsDgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/vCifkNY6BRMnNV9h9iNuIfW7PVpd9tcf6xIFuZKSyYkoiYY5Z66EPk5Q3uLTIktXaQUJxu1kpLy00QruT35KLFwYiSvBpgh/5BP3scv28apzuTM3jd1i+NGiTlQy6hPXx1cW0yUMI2G0w4Eub+MYsutNO+DfNGBRhzWSTCrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehB31vRL; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55b859545c3so2331837e87.0;
        Thu, 07 Aug 2025 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559319; x=1755164119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/86h0FQRVpfowRTytjXX+T6FZ3yXmtaLRCQm9RvuMhI=;
        b=ehB31vRLzIzIVEOheO0S3aMpXnxG0OTN71Tf9B7u/kSI1yNXpLIMgG5bsnHHha3Udh
         ncOfejAdVpB0FndfJN58WAk8P6dhb2xs7eYQ/2V9NAsEPEFo6wS3SesKQ26JUlT+60MY
         FvwsUbh5dGJzFveM87jdu2Bm/K/hBZ4TquP0HG7K5tOP/T5DwPuQaw6z5c/Mo4WQghJC
         oZmTjMamLcacIlSBa9MSU7n58o+zYa4WUhwBdLvo5IbS99ohtxuFK1GfDjWRqPQarB1y
         U81NpXuEkZGlm3g/NViwZG5YaeNTyC6MsRLdDVdWm+JCw2T95ke7IQI6TN0BKx+lcGnJ
         5tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559319; x=1755164119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/86h0FQRVpfowRTytjXX+T6FZ3yXmtaLRCQm9RvuMhI=;
        b=i9cErgJZvlaQ73JlCHbksAmlbgVX4RBeNJXHzSX40wTIKKZF6kl3mYF5mxvrzFLnR0
         quZplQ3JzDeOqCR6owvB4vgXcLG9VHa2X4+Y/iBTsJhDrnegh4pOpkIAmpayNUYDddeD
         RTKbAOCFjW2dWNxcryGoTyQXQxDm3fBJUANDUOX2PcHQvDxkEIYN9wkf8UkAuZSe2bw4
         RxidYaXl9iblRFB9uWO/BcJ5ZsTH3WVl+E8qcB2HGwQbi7qTWyJz1QIo9FVnP/6vS73y
         KxHt/8EJ8nN6ELQMXH8wRMzM1b/hIPKnyj3c1X6NRH1CbHiM02WpUx4hSe37Ihc1Cs/5
         mkmA==
X-Forwarded-Encrypted: i=1; AJvYcCV1vDJP8vSwREjsL76++RWSb9VLCrm3H2QB/mPOmwgEO4DaFmg83d7sJe/iOSNGVe+aFEerLuM4py/N@vger.kernel.org, AJvYcCVegeEbXBc/w9CpiQBuxKamn2+3HNpU35ItMa0SYntcPkaBS05vh58lb69o+6TE1fi7PDLU6fscJxaK+erk@vger.kernel.org, AJvYcCXrOp/+mr4xXPVcCdt0fDCnCl/P962uy87CfYqgR6DIrrtjMT+dWTyCH+5JO2gVtU4SiEW7gjU9tJ61@vger.kernel.org
X-Gm-Message-State: AOJu0YwULAi8qz9eKs3VXW9jpR2ADQAuU4dqyghuVpGwzAob2FPhn4SB
	eSnSn3625akS6brI/Jw2JgSC45ItFNxkfrdviXyd0dBvZQVfyJM7ZyPl
X-Gm-Gg: ASbGncsmS69+awfmilFrFhSU0YAldkZPPLNNZWNGp3l+Fyf83al0GmQ+NaMb4hThZFp
	X3kZmE5Ab/e9cKlFq+UAu7ue2O2flHANxFTc1RF+4G8baFP/GnscY/bp5OyuX3Akl3BWPJUmCqN
	jwKYq7EcXrkDQUhV7ixkWA289phd/H5FFWi8aA49bgTFJclEqe+OHTXjAKus6wwe8hBeCTFGyGw
	ORcEmW2U+A07H3WzfWhwGnSqDOfvmbzosjHWRfXihDcMTMpjJ3svL2oYtrrXIW1ZisWpHPxC8eb
	auoIu/+j6XJgnyRrZAXnxmp9AOnTJ0GoX7QND4TQfi/5KInjXNMprhsfzjcx3Nrl/77rfDTdWSG
	l54ab8c5wocLpjQh0fD9qrVZbeQ3S
X-Google-Smtp-Source: AGHT+IGlwB3E3iFsoV+RPbthQ2Ea2eKedtqx0x4kCaDJKfU831U5xjQOWACgAkUckWcm5YIZT2beZw==
X-Received: by 2002:a05:6512:2344:b0:55b:8285:3f31 with SMTP id 2adb3069b0e04-55cb61ec19bmr1072822e87.24.1754559319005;
        Thu, 07 Aug 2025 02:35:19 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac54fsm2615427e87.62.2025.08.07.02.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:35:18 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:35:14 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] dt-bindings: iio: adc: ad7476: Add ROHM bd79105
Message-ID: <ccec6e1477951d6d87dbf6cf4fb83d239632da2d.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="at11eeWsaZC/GkIE"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--at11eeWsaZC/GkIE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79105 is a simple, 16-bit, 1-channel ADC with a 'CONVSTART'
pin used to start the ADC conversion. Other than the 'CONVSTART', there
are 3 supply pins (one used as a reference), analog inputs, ground and
communication pins. It's worth noting that the pin somewhat confusingly
labeled as 'DIN', is a pin which should be used as a chip-select. The IC
does not have any writable registers.

The device is designed so that the output pin can, in addition to
outputting the data, be used as a 'data-ready'-IRQ. This, however, would
require the IRQ to be masked from host side for the duration of the data
reads - and it wouldn't also work when the SPI is shared. (As access to
the other SPI devices would cause data line changes to be detected as
IRQs - and the BD79105 provides no means to detect if it has generated
an IRQ).

Hence the device-tree does not contain any IRQ properties.

Add a compatible for the bd79105.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> v2:
 - BD79105 can provide data-ready IRQ (or GPIO) via DOUT-pin.
---
 .../bindings/iio/adc/adi,ad7476.yaml          | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
index d0cb32f136e5..c411a7467651 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
@@ -41,6 +41,7 @@ properties:
               - adi,ad7910
               - adi,ad7920
               - adi,ad7940
+              - rohm,bd79105
               - ti,adc081s
               - ti,adc101s
               - ti,adc121s
@@ -55,6 +56,11 @@ properties:
   reg:
     maxItems: 1
=20
+  interrupts:
+    description:
+      The data-ready interrupt. Provided via DOUT pin.
+    maxItems: 1
+
   vcc-supply:
     description:
       Main powersupply voltage for the chips, sometimes referred to as VDD=
 on
@@ -75,6 +81,10 @@ properties:
     description: A GPIO used to trigger the start of a conversion
     maxItems: 1
=20
+  rdy-gpios:
+    description: A GPIO for detecting the data-ready.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -82,6 +92,20 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
=20
+# Devices with an IRQ
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rohm,bd79105
+    then:
+      properties:
+        interrupts: true
+    else:
+      properties:
+        interrupts: false
+
   # Devices where reference is vcc
   - if:
       properties:
@@ -115,6 +139,7 @@ allOf:
               - adi,ad7274
               - adi,ad7475
               - lltc,ltc2314-14
+              - rohm,bd79105
     then:
       properties:
         vref-supply: true
@@ -131,6 +156,7 @@ allOf:
               - adi,ad7274
               - adi,ad7475
               - lltc,ltc2314-14
+              - rohm,bd79105
     then:
       required:
         - vref-supply
@@ -141,12 +167,28 @@ allOf:
             enum:
               - adi,ad7475
               - adi,ad7495
+              - rohm,bd79105
     then:
       properties:
         vdrive-supply: true
     else:
       properties:
         vdrive-supply: false
+
+  # Devices which support polling the data-ready via GPIO
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rohm,bd79105
+    then:
+      properties:
+        rdy-gpios: true
+    else:
+      properties:
+        rdy-gpios: false
+
   - if:
       properties:
         compatible:
@@ -154,6 +196,7 @@ allOf:
             enum:
               - adi,ad7091
               - adi,ad7091r
+              - rohm,bd79105
     then:
       properties:
         adi,conversion-start-gpios: true
@@ -161,6 +204,17 @@ allOf:
       properties:
         adi,conversion-start-gpios: false
=20
+  # Devices with a convstart GPIO where it is not optional
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rohm,bd79105
+    then:
+      required:
+        - adi,conversion-start-gpios
+
 unevaluatedProperties: false
=20
 examples:
--=20
2.50.1


--at11eeWsaZC/GkIE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUc1IACgkQeFA3/03a
ocXMxQgAuWytX3w35Hq7qrSK+8M/ivw0OgfVLiolOWqcMKzhReJJPUuA0Qhu6kMY
ryfCTeJehZllkJPImRPRCTZecLwkrzYzNdXQWRK98mGcTJiJ2JTHgIECm61cpkIj
qL++WtcdbF1uEUxwlSrj/InzZkscrp2ySmqYRUg1+ErWB4DkUVHldoY/M2XV3Q5y
oFnhD9B0nYf2Kq7535YkdD8QlJwvE6VOP8rB2qo+VXxNvLM47tlLq5SBbxNsQf3d
CXxWyV7nYLPzaSMWlNNkjyqZDt64nxLqAl87ZcppHZlIkPC2oDwUYqItkgf6Xv+b
SbmGY0M7BGm+5SIbxM4GWDxO58BIow==
=PITl
-----END PGP SIGNATURE-----

--at11eeWsaZC/GkIE--

