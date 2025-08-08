Return-Path: <linux-iio+bounces-22438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B752B1E516
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31F616AE08
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C31426FA69;
	Fri,  8 Aug 2025 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUg9XPQf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865D2690C4;
	Fri,  8 Aug 2025 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643274; cv=none; b=WIYyaQ5Nk5vB7JgIKmHncsPOrc5VIKf325SYFkDdZgkeoSX5t97MDiXP+xZ8ac4J/+xqguhiwOyYLPjlvAoGz+VY0pdp0Fp2ANUQDhTeDbkwOnTbP5kXQMkE9YopOS/pkc6LCs2bg17rT2Je28QXUCSvQc7tDhOSElYVGqNTMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643274; c=relaxed/simple;
	bh=OiR/2HnHwk3hu8f6SamcIhgWgOSPUE9a9pwFjFj4Qp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORBSj2HEsGz5HLswgoEAHeJT7eNp/eCVJNo/17Vhu5HwaYruyey2UUDbc+MpoD6AtAOzDFoyXHfJoWEPlvIrA86zGlOsYTlUDlCUs8asGpNp/Hu/aNCuDyQHRhVtTcc4MNq40w0YGe1N0bhAY7xL67ppwgouNSBVQnN/MAhYziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUg9XPQf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55b7454c6b0so2032202e87.3;
        Fri, 08 Aug 2025 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643269; x=1755248069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJXYbABixyTOaHOtiXscD+YAY82rcQaoMNZVj4YOt9Y=;
        b=EUg9XPQfy1E/s8MiCkGOyS1ZSW78r1xUibPyzdh64T6fSGAvgPszVaTYA+2I3UA46y
         5nbLCs50oyVGmaIQFG32eGYcx4jIGWaNQ441OhbAGGq2fSul6YS4w+dPY08Ie+XEU8lR
         lhyaOHQmHSweaZR9dEub8hxzidpWDEybNaM6GN74i6EVpFnRaercNDQNk7mlahfzPPnr
         vU3fwgOvDv65aJ02ExmOJmLg/W6PpnQAfsOhg/PPCNWbAJ12uxNj+1e1T0YG8fNmsVKL
         IXzft6++F/TtDE+HiyFBv5UrX0RE02+A1a/Fbe+gpdidLjW558nt35D2ASiZ6ZUxGGBq
         6law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643269; x=1755248069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJXYbABixyTOaHOtiXscD+YAY82rcQaoMNZVj4YOt9Y=;
        b=B4XQsxtdb5PgdqUmB7RNKLt2Wg8zKuOfza3tYu1/lB1EfW9uYnLTJodZNc5G3m3IIg
         HjIDvnFI9Q2Lx2yS2V1o/M47SrAIiqeJk6ls2N7GrPnB2dCjOhg2Kn46yJFUQuaoafqc
         86XnkM2N2FgBpfCMv+6/gPu8zlT5IIUeYdxo5gbiomW+QzlbUc5IVduAjOrZ4gnk+9dX
         aTzcT8+Ik+Groh5wKN5fpKGH/klwc6K344vpenxx2fZwvVq/oRBn9kUj7DD/sYR4AD+1
         6RK4Yi018icSZNY+XQ0GP7gglviRrwAaK/Gi6KyfIHuNHoddg4LZ/norj6GngbW6xV46
         XFfg==
X-Forwarded-Encrypted: i=1; AJvYcCVq2CGOTnIrhFpwmq+9bTTkUbbTSkQ29Nb6AS5glAhoM1iCDnim3aWrvUh2glhqfloTlh6L1vElIjQP@vger.kernel.org, AJvYcCW91gQdXPPUdolAJoyWa1mjXAJC7MJtPAvsqMchogxWn98b5bLR3C1NVIYwPnCQyneJ43oTxTBSJRY7o0qI@vger.kernel.org, AJvYcCXrGzZqqazfKYPn71uwgJYHkcQpilp1lNFybzgoeCKWrL8G6mMMwv7SiRGdI0miciyCQUCz+gT+B0U8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxonl6su3cc8RdVNIGdhphFyveUN7OwoznA7SR+3sUzmaXo9Ilh
	avSbv5l1jSAzpp4wPziSxPrOINSzX+050v7QSd5LVE439+/b8Q19HySp
X-Gm-Gg: ASbGncueSCeWY8wm5ksKTaUmgQ+nSwP8//U3ImL7QFrayuYqZNAIgQ3tUq/vCGsEJme
	YzwDjhXAFBC/jXWlysG9uIEE7SMPYtjWOTj97afV2pcn6m3ZU1qCY8L7V3vo+ZHCJZXZj1bou07
	ch4m3OPwNbUaEpsmXEGew74QgPm34ptckwsGblBru9eszlqARdr75lNgW1iJFQYt8ZuDonKtd1V
	wv/ewFflpykhv231G3iQTVyIRkfUXTcxvf76NNHT1xqxDba9qnaaY3K6btpZHHa7xNUAvziwDBi
	ZIrWe1OdDKPFKm13Vj4YZnQmMVjujMsAtqb1/xJq15sw6M73ZCyS0KFENf/SlJ73JpreNoZ+CF7
	IFqS8O6htmzDsbth6IQYwF3cKtC4z
X-Google-Smtp-Source: AGHT+IG6+zQUBeiPdqX1g2jivVW56r5EB4sFlrYO+u0gHY0UIcG4wiioSFcEo94BfT3o6rO+2EB62Q==
X-Received: by 2002:a05:6512:2211:b0:55a:e1f6:bd98 with SMTP id 2adb3069b0e04-55cc0083b04mr542983e87.6.1754643269329;
        Fri, 08 Aug 2025 01:54:29 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b887f72f4sm2979768e87.0.2025.08.08.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:54:28 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:54:25 +0300
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
Subject: [PATCH v3 08/10] dt-bindings: iio: adc: ad7476: Add ROHM bd79105
Message-ID: <cc5cfa7540caae4bcb7448a59602421d54353ecc.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2LLsVrY0GN/V41a"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--f2LLsVrY0GN/V41a
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
 v2 =3D> :
 - No changes

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


--f2LLsVrY0GN/V41a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVu0EACgkQeFA3/03a
ocW9CAf/UPyXzdt1BynNJE7meCRzAkG9IHNcnMy/peVmH59nu/DDz/OmIONCiY/S
0xs9+Z62vmiNwMlqE4Sm0BU+s4gbwZBCrZsX7EuB0QNFx5jUIWfSTBBRsJHxhvNL
B3vrIT8MGxQvplZq/ilo0uzb+HoHw8A7TkSUIRIxDDzqiuwGvZ6jLLYOGe6Stk5u
V+GDA818TuPepjnSvpvkHQW3aB5d/+dBA9g+ao+wsXeCTYvOAfdWoZ71OVbBQx5J
Fq2eIZFOhX8LSj9TShZoSu9QY2KdbPnrulfhseibeSzKXmKojArtaSxebpx+7voO
p227+BnPPOE07QpDUReYge18sXjUyA==
=phHV
-----END PGP SIGNATURE-----

--f2LLsVrY0GN/V41a--

