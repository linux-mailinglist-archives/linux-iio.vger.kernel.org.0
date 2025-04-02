Return-Path: <linux-iio+bounces-17537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824D4A7883A
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9213B06D6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245872327AE;
	Wed,  2 Apr 2025 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0Eq3dVU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24157231CAE;
	Wed,  2 Apr 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743576287; cv=none; b=GqbjU/e7lMJvvmzKPLfk6vmB4dGtjSkRClOsvewgZ1230M7gTOph7NfXBqbp1w4mEYu4pc4e8kgnkHQmeqwdlKwFmxgPorqKwrNixLeIomeoAoVGLYtkHUasWUlFql7A29DXXrZi23/QH79i5pWQzJYFH9X5pKGIGpTG0qPdo2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743576287; c=relaxed/simple;
	bh=w59FUeUJ5lPfldVA7sWBkOtZqptARVo6IrhNG/64huQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siJUiJodDsaCfP6LJELaPUZiKgV52uHYblfNPRwJjQyOAFYnpgbs6spdS6fjtGKptmULUAa4KjQTfRgNp/4WXYNzUU83YJ3UI5w1GGxN/ShHV5yGnYj4b+UptKMyMuzcuAk7pVo28+qPwqBo0F33bHCXOqOJhTfDVdUfaUQlUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0Eq3dVU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5499659e669so1877428e87.3;
        Tue, 01 Apr 2025 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743576282; x=1744181082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LlH9M3OOE5qNDtaUmP7iITtLaH6D+OBrVLCEyeDjplA=;
        b=L0Eq3dVULScAZfDhvtuQha6vnu8sHnGOUxWVyLSbRsS+fTtXJDp/6BX/YletD1S6ud
         YT+BDUi3gXYc6dYYd6BqsDP6jEVcigAc49l/5Grvenj76nlFZv/fVu34kQkPNLeRGpo0
         ISXnynhxFDJrv0z3ifeYA4bN1t286v7CyXaZuNOp0DdZUFRBPikVYf+HBiWIkcl+k2E+
         CEE+BStAh4lrfdzV84daoyCauNS41t1Gq5BSO5FJA+d7SZpBlfCSo/PQAYC8SiGWHdJQ
         kfvBjBpnqhAxQqJFUe/FVnRvapYgn/wMyCaLEQoQOUav3ZzX/RcnQty+hEQer4W5SHNx
         DsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743576282; x=1744181082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlH9M3OOE5qNDtaUmP7iITtLaH6D+OBrVLCEyeDjplA=;
        b=arN0AikuE/Qyqjb2GrXs9kmHwEjKCIjY5YdaCGWFSBT5dR2kzaJ+MO6U32OoVBRh9J
         BrHCuI7YYJJJqAi+Tr5exBAFcez38rfgpJprenSevROwcn98SZwASQFfby3kl5AOUbI6
         hWLtJQPeG9XzkMxKvK+A/bdZ9n1VC4N0/AWzkseNJ93hhMyd4MIm1kZiCs4YtcoGQ305
         6DUy0cElgAqbpN2K8GDr1lfvrAViShonEzOipSDFoFyNaQaiQfm9+0g9TyxBpTSX6qPh
         YwTsYTuvYWQRivzlo8y9a7lEhAm/yntZN4+PO5fN/RZVRcbjKu+zar6t08xlYXJ2tzdp
         jwbw==
X-Forwarded-Encrypted: i=1; AJvYcCV0PjPjR2M0G7Oyp9npRbjdw7azFYkTD0jNmu5F5KaSHvUNo8LtIMR1FHVCZeNTBZY/0utGQDMZir62@vger.kernel.org, AJvYcCVAGU4lfGDoeEXegnlL3YT3JrXtgYqd6PVXvaQNS/IEfTCfvBiu7USHQo4hgipkmE9PkicTRZc2nxp15gpW@vger.kernel.org, AJvYcCX/tjllaRaRGw1MWjctV64MbqLnsSzOElsxFhZRpSW7N2Rki910q4OBmjUf/YHQyaAdNq48cTU0Vj6N@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbm97k5FbMDXRsiHeL363S3aFl10NaDAaF1Nov3Gxcar5F/cXT
	w0ublwmMWz8bVIGQMatINUGmCBP5GU/RtIs/G8Mf951X2kYI+6Jw
X-Gm-Gg: ASbGncu1+1sbAf1fMEySaAP4kztpz8TdzH+6PztzQY1OWxHkMuIrgal/FVNr7J4/Ubz
	UIJV3UNprlHTrEYZCQz09jAWIFpj8XDzwIu1DZSaOUucGAXA878Qd03cO3oorTZz9shXo0LCbsU
	EXatBbNk7PEjpxrV4uQIhPQ6ujQe49+cEMi+WqmUIW1w38rOpvA3SRQOIJHUp0VR+z3galHS8KJ
	yc7fnpRzYSWOXkHu/0B1SKYdtE2GH+yLckmi/YY6r+7zpmz9WkkRhrjv/1WOF7jRpadp28MLPu8
	UkkBdsIAIapikmSNh+0vExzuXCx4Kicca6NdZb3B79tK4+ags9s=
X-Google-Smtp-Source: AGHT+IGFT6J2izO71CRheocjLo5evyR65cdzQ6iy3ERf8IGLMKjqQ1niS6wikLh0W4i40nsVElLc6Q==
X-Received: by 2002:a05:6512:3c9a:b0:545:2cb6:af31 with SMTP id 2adb3069b0e04-54c0a4bfa6amr1552669e87.15.1743576281785;
        Tue, 01 Apr 2025 23:44:41 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094bb4f8sm1598873e87.36.2025.04.01.23.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:44:40 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:44:36 +0300
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
Subject: [PATCH 1/5] dt-bindings: Add ROHM BD7970x variants
Message-ID: <0a114565e4de52bf8f98c4f9d17943e5148b0112.1743576022.git.mazziesaccount@gmail.com>
References: <cover.1743576022.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="97tzLPq4bVak8Y3T"
Content-Disposition: inline
In-Reply-To: <cover.1743576022.git.mazziesaccount@gmail.com>


--97tzLPq4bVak8Y3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79700, BD79701 and BD79702 are subsets of the BD79703 DAC.
The main difference is the number of the channels. BD79703 has 6
channels.

The BD79702 has 4, BD79701 3 and BD79700 2 channels. Additionally, the
BD79700 and BD79701 do not have separate Vfs pin but use the Vcc also
for the full-scale voltage.

Add properties for the BD79700, BD79701 and BD79702.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/iio/dac/rohm,bd79703.yaml        | 33 +++++++++++++++----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml b/=
Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml
index 188b00333dfb..c00fa50e42e8 100644
--- a/Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml
@@ -5,19 +5,26 @@
 $id: http://devicetree.org/schemas/iio/dac/rohm,bd79703.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: ROHM BD79703 DAC device driver
+title: ROHM BD79700, BD79701, BD79702 and BD79703 DACs
=20
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
-  The ROHM BD79703 is a 6 channel, 8-bit DAC.
-  Datasheet can be found here:
+  The ROHM BD7970[0,1,2,3] are 8-bit DACs. The BD79700 has 2 channels,
+  BD79701 3 channels, BD79702 4 channels and BD79703 has 6 channels.
+  Datasheets for BD79702 and BD79703 can be found from
   https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter/=
dac/bd79702fv-lb_bd79703fv-lb-e.pdf
+  and for the BD79700 and the BD79701 from
+  https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter/=
dac/bd79700fvm-lb_bd79701fvm-lb-e.pdf
=20
 properties:
   compatible:
-    const: rohm,bd79703
+    enum:
+      - rohm,bd79700
+      - rohm,bd79701
+      - rohm,bd79702
+      - rohm,bd79703
=20
   reg:
     maxItems: 1
@@ -27,19 +34,31 @@ properties:
=20
   vfs-supply:
     description:
-      The regulator to use as a full scale voltage. The voltage should be =
between 2.7V .. VCC
+      The regulator to use as a full scale voltage. The voltage should be
+      between 2.7V .. VCC. Not present on BD79700 and BD79701.
=20
   vcc-supply:
     description:
-      The regulator supplying the operating voltage. Should be between 2.7=
V ... 5.5V
+      The regulator supplying the operating voltage. Should be between
+      2.7V ... 5.5V. Is used also as a Vfs on BD79700 and BD79701.
=20
 required:
   - compatible
   - reg
   - spi-max-frequency
-  - vfs-supply
   - vcc-supply
=20
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - rohm,bd79702
+          - rohm,bd79703
+then:
+  required:
+    - vfs-supply
+
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
=20
--=20
2.49.0


--97tzLPq4bVak8Y3T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs3NQACgkQeFA3/03a
ocXOewf9EwridfLIvSb5efM+QpzkBC6NGFig8m0ZjdaOStYtJC5xq/zAnIwkT/gZ
RHoKpoOOTntAacbY87m5YJ1Gutksp39TQ/qGzpum+EYuXt4wGxdcwPx+1FetgQ1K
iO5bEJAMpIskc+6lNnC905YIaRSM7Zus6lHDMqyCK7bYpLlNzFPx/nQBc1vd5Dd6
ru5Jh3R3qB6yqC5nDGRUqR7xK9Pr3i09pQxBQYvd3Z6WFIEiiXKC7tYCOO6Lnu79
xGiQe+c8LbuaEKY/djUnu9PBPJTv1lrP3o5z+vXGrpbdIaPPOoHqgUedAR6sRLZj
/VV2zUB3ErYAbQuA8Ra0V1t1mcqnNQ==
=MxLF
-----END PGP SIGNATURE-----

--97tzLPq4bVak8Y3T--

