Return-Path: <linux-iio+bounces-7350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4001F928733
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CC0B267FF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9540714A617;
	Fri,  5 Jul 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsDGKiFY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD671494D9;
	Fri,  5 Jul 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176861; cv=none; b=CmWzVHJfYhZ6VBIvs+GonYaAlOccIOE7b/1XjWUjWAlUr7u5pIruWSW1BKsRgHYlsyEWC+4dFPYUGrLKsGElmIL/Fy8zkQCdXA/ZCWNYxE+MoLF/2cncxHpF3WcBes8c9qa3y9+LiNNwb/IykbzD7RwhGSMxRbz85hjdG1DtDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176861; c=relaxed/simple;
	bh=RnVcsFlEYyDPqf3CWLYFuSkjMBEsRhVWOx/GCvQ+OjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz/bWvhYGJR4s2AO0IlUeb9yTmtteHozfQorDt0B1c3yc/2scZ6VAWhUppv9AgK8B4u6X+jaZwj/FLEcWjEe0kFK3r74ZQIYt4shkabpHdNbP6Tbf74Y+ewa3+U5XTN2Kb+nKOTGrCO9S6ztIDXI+ZlsqQDg0LP/M7xdkBp0HMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsDGKiFY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso2183922e87.2;
        Fri, 05 Jul 2024 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720176858; x=1720781658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMaSOFsBwSxZehEg946gXs11Hd0r2J8Qex03xKjgN7M=;
        b=bsDGKiFYctleQE5bRGBdUps7LpB+3OrNTGGm9tiSofEcTaEjgAgwRIKtqGjvqsfwr3
         ib96xH40DXcyXPnDi+xnDcXVtt1BhhBjzMNS2B/FbExMQ3B4CHlffVOJB6dDHO70z4A7
         Ux0ak07u0LQpHnMgSGjFtkSuEHdYggAXKOUyNRaNvG85aXf0Y/SWlvw1SfBdDHdtQdwF
         aTKBnR8NFugHbiRtAifG6AMXzc2stItQJ8IcmMTHS0Ai5eIvk7OClDXcLn/SKiKLe+lO
         oq2lIyBr8xx1S6HadqflLxwGRMggoSWm9ei7C4ZKbXC3XZN9v6yN3fLwYnGYS1MmHK3j
         ZKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176858; x=1720781658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMaSOFsBwSxZehEg946gXs11Hd0r2J8Qex03xKjgN7M=;
        b=evnB7dZlhtHreTjjaWddx/7+jt3nG4tTPLIqPi/MthELKk201tKCVibLf2UibIUWlY
         a3Garkc078+Knn2hJHMLZ8+lUqraAiB4HaiK4dIs2cqKePG2QO2Ufu1xiytdLS4ybiUO
         OfwW/ivIrtRVr0b21xTLDVqdBV4cchxC5ibVZW0fLrMsTesPlgpRBzWqv/udkbSSFb+X
         o5XUEDdd4nhM/C7CDwyALUkXZdizcS2qZNzr3coIU7aMgO03l2go1+uVg3DvhxxyI1Do
         /mE2ZT6FO6yWei+rfrdYbgMk4dJWKkJw8CDVnWg4zICEJfzGNxN0v0jt1CdqFKLeMqMg
         cqYg==
X-Forwarded-Encrypted: i=1; AJvYcCU1TRym/9Kd4YKYPFz3O3RYn+sK6uzyYFfs3zFqBe4hEfJk8lpA/+dDXPb7yV6kPzbAhJ7U4YFuwVaVicC/o4UA1hYKWpmVPQIctYfJvmL8IuanfRZVFyLkpl1xieXUhPqF04aEQ+mpITYl2aEqs0AC7ykOIV2FpRoS3ZoyUgnDe6NEdA==
X-Gm-Message-State: AOJu0YyxIifxd7J2Xv3wQCJ5acOiXsMYHllwqICelCCQbOQ7eZ5ETFwS
	1gOiCgym+9a2OJYIaU4Rwwm1GlwzYM1uTBN9V4pqcSXGUrU50vdRNMCV3A==
X-Google-Smtp-Source: AGHT+IEWQ40RNZhfV7Eks6cNnGUujSgPKANOXaSIEAXEp04d6CaSWKXWmQBNw88m1RchKCIyR2Fhuw==
X-Received: by 2002:ac2:4568:0:b0:52e:710e:e4d2 with SMTP id 2adb3069b0e04-52ea06327b8mr3502163e87.33.1720176857253;
        Fri, 05 Jul 2024 03:54:17 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e95588702sm909212e87.250.2024.07.05.03.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:54:16 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:54:12 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] dt-bindings: iio: BU27034 => BU27034ANUC
Message-ID: <c39f9c67b3c07a27d7a13109c7b69cff9cfd2b9b.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZAYJsJE4agjDBduS"
Content-Disposition: inline
In-Reply-To: <cover.1720176341.git.mazziesaccount@gmail.com>


--ZAYJsJE4agjDBduS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The BU27034NUC was cancelled before it entered mass production. It was
replaced by a new variant BU27034ANUC (note, added 'A'). The new
variant gained a few significant changes, like removal of the 3.rd data
channel and dropping some of the gain settings. This means that, from
software point of view these ICs are incompatible. Lux calculation based
on the data from the sensors needs to be done differently, and on the
BU27034ANUC the channel 3 data is missing. Also, the gain setting
differencies matter.

Unfortunately, the identification register was not changed so there is no
safe way for the software to distinguish the variants.

According to the ROHM HQ engineers, the old BU27034NUC should not be
encountered in the wild. Hence it makes sense to remove the support for
the old BU27034NUC and add support for the new BU27034ANUC. Change the
compatible in order to not load the incompatible old driver for new sensor
(or, if someone had the old sensor, the new driver for it).

Drop the compatible for old sensor which should not be in the wild and
add a new compatible for the new model with accurate model suffix
'anuc'.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
A patch renaming the file according to the new compatible will follow.
If renaming is not needed or appropriate, that patch can be dropped.

Revision history:
v2: New patch
---
 .../devicetree/bindings/iio/light/rohm,bu27034.yaml      | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml =
b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
index 30a109a1bf3b..535bd18348ac 100644
--- a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
@@ -4,20 +4,19 @@
 $id: http://devicetree.org/schemas/iio/light/rohm,bu27034.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: ROHM BU27034 ambient light sensor
+title: ROHM BU27034ANUC ambient light sensor
=20
 maintainers:
   - Matti Vaittinen <mazziesaccount@gmail.com>
=20
 description: |
-  ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diod=
es
+  ROHM BU27034ANUC is an ambient light sesnor with 2 channels and 2 photo =
diodes
   capable of detecting a very wide range of illuminance. Typical applicati=
on
   is adjusting LCD and backlight power of TVs and mobile phones.
-  https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/bu=
27034nuc-e.pdf
=20
 properties:
   compatible:
-    const: rohm,bu27034
+    const: rohm,bu27034anuc
=20
   reg:
     maxItems: 1
@@ -37,7 +36,7 @@ examples:
       #size-cells =3D <0>;
=20
       light-sensor@38 {
-        compatible =3D "rohm,bu27034";
+        compatible =3D "rohm,bu27034anuc";
         reg =3D <0x38>;
         vdd-supply =3D <&vdd>;
       };
--=20
2.45.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--ZAYJsJE4agjDBduS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaH0NQACgkQeFA3/03a
ocU5mQf/UUsVd8oDQV8ihQ2doYkFMB8XIfmcxEDMSruXJCdZoTVqckqpY2G/ERfS
hE+lg+kj3N5vRK3FkjIRKuslxb3+WYD0S43hQIkgaWoDWvzZ2AWFwSpET+/380C9
oVdFVnVhSdLg7cJTa6SoKSMQj1bbs8w9DZIATEFMsQOdo8Mf2r1XiJOz8ZOj9suK
XVa4f4Zm91A4cbX5apblieuChIX0X1k1zm6ssz+QRblJdTiiJcbxA7rZA8aJVSH8
r3sry4x741k3IqY57ABiI+LDmQUrE6Okiod4JBe/8cxkJF2yc9L+EDAa5meHptbL
qqlohLzivU5cEznkpPGQxFJR8S4Hqw==
=l9Le
-----END PGP SIGNATURE-----

--ZAYJsJE4agjDBduS--

