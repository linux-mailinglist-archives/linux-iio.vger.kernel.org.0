Return-Path: <linux-iio+bounces-7845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4993B392
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 17:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762F51C23668
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAE315B134;
	Wed, 24 Jul 2024 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr18G810"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D2315B132;
	Wed, 24 Jul 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834745; cv=none; b=qGlEYz2KjrKS6EZLn5x6NSEA91l+EtaauelFkBxYIXHZpZkC0TgDGTFnZ9wmfKjCni4yhp3xs+BlJgtnXf1YVcc3gyDnq9Ozcx+dVaBI6d01Kj9eoJDslk7u2lDLcVA4PXEWCKp/jMGQknTcuX0+V0r7P7Ja4pmFIc16jZysNSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834745; c=relaxed/simple;
	bh=A6/WUlTLFtFYkn2WHKIiYGD7lSw86yVgWdSVlD2hQ8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oe2JDfXKvnUrwR118rjmFov1VaTl10IkXvm1TxwYZ0KKs0BUxfZzBGLAYJ+5Qyy5BbTfHgMWTuXnCq5K0bJr0Cs5G9+tdkJ6y5q8pG0IUESYGkVZZeuHuEgNJQH8YdGo5UlpGqqoGptQwJ2t3BhPmj9xPoMz8QAkDg7EjL4wyPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr18G810; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D64FC32781;
	Wed, 24 Jul 2024 15:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721834744;
	bh=A6/WUlTLFtFYkn2WHKIiYGD7lSw86yVgWdSVlD2hQ8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nr18G810BWzNPqO+hHzTb4ecr2Mq4zCrqJNV8gidnXNZ/vIFnCxouJ8MZAwXezqme
	 v4GXs+26yVrc+PhHxr1Xt4tjJGdiYxXQ0WgBekeMrXtYdI4fjL0sCoy1QNHh3TsEon
	 eNBmoIUaIqhUHyxhKlKSMyvCeqZiBfp/dzcGrckQ3pTF/1F4mldpPDt4O+V4OGvE9W
	 j9WcRPm2vnKMyOIAuDzrDn0T3OZwivlOdnamDrDUust7HP8ZwWQAX5cj9fej9QA5XU
	 0/VLtjk8bsyg6XcaUQnsONQJxBaL/3tOekxw6K46WhIpOO/obH22AMMqi1yPoSMahx
	 kIBBMUJQd64yw==
Date: Wed, 24 Jul 2024 16:25:39 +0100
From: Conor Dooley <conor@kernel.org>
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dima.fedrau@gmail.com" <dima.fedrau@gmail.com>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Lorenz Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>,
	"Frauendorf Ulrike (ME/PJ-SW3)" <Ulrike.Frauendorf@de.bosch.com>,
	"Dolde Kai (ME-SE/PAE-A3)" <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
Message-ID: <20240724-ogle-equal-d14de4318080@spud>
References: <20240724125115.10110-1-Jianping.Shen@de.bosch.com>
 <20a8ad37-f6ce-4342-a2f7-bf3495dfeb69@kernel.org>
 <AM8PR10MB47219903C83BA4F0AFE2DAA3CDAA2@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z4NQh/ZZRjlgWpNL"
Content-Disposition: inline
In-Reply-To: <AM8PR10MB47219903C83BA4F0AFE2DAA3CDAA2@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>


--z4NQh/ZZRjlgWpNL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 02:19:25PM +0000, Shen Jianping (ME-SE/EAD2) wrote:
> Anyway, please send bindings with driver in the same patchset.
>=20
> -> It's fine for us. Nevertheless according to the Devicetree (DT) bindin=
g submitting rules 1.1
>=20
> " The Documentation/ and include/dt-bindings/ portion of the patch should=
 be a separate patch." See -> https://www.kernel.org/doc/html/latest/device=
tree/bindings/submitting-patches.html#i-for-patch-submitters
>=20
> Shall we still put the binding and driver in the same patch ?

No, different patches please. Also, please fix your mail client so that
it quotes emails properly.

Thanks,
Conor.

>=20
> Mit freundlichen Gr=FC=DFen / Best regards
>=20
> Jianping Shen
>=20
> Mobility Electronics - Sensors, Engineering Advanced Development - MEMS S=
olutions Software (ME-SE/EAD2)
> Robert Bosch GmbH | Postfach 13 42 | 72703 Reutlingen | GERMANY | www.bos=
ch.com
> Tel. +49 7121 35-37749 | Telefax +49 711 811-509378 | Jianping.Shen@de.bo=
sch.com
>=20
> Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart, HRB 14000;
> Aufsichtsratsvorsitzender: Prof. Dr. Stefan Asenkerschbaumer;=20
> Gesch=E4ftsf=FChrung: Dr. Stefan Hartung, Dr. Christian Fischer, Dr. Mark=
us Forschner,=20
> Stefan Grosch, Dr. Markus Heyn, Dr. Frank Meyer, Dr. Tanja R=FCckert
>=20
> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>=20
> Sent: Wednesday, July 24, 2024 3:17 PM
> To: Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>; jic23@kernel=
=2Eorg; lars@metafoo.de; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kern=
el.org; dima.fedrau@gmail.com; marcelo.schmitt1@gmail.com; linux-iio@vger.k=
ernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lorenz=
 Christian (ME-SE/EAD2) <Christian.Lorenz3@de.bosch.com>; Frauendorf Ulrike=
 (ME/PJ-SW3) <Ulrike.Frauendorf@de.bosch.com>; Dolde Kai (ME-SE/PAE-A3) <Ka=
i.Dolde@de.bosch.com>
> Subject: Re: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
>=20
> On 24/07/2024 14:51, Jianping.Shen@de.bosch.com wrote:
> > From: "Shen Jianping (ME-SE/EAD2)"=20
> > <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> >=20
> > dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
>=20
> Something got corrupted here.
>=20
> Anyway, please send bindings with driver in the same patchset.
>=20
> Limited review follows:
>=20
> > Signed-off-by: Shen Jianping (ME-SE/EAD2)=20
> > <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> > ---
>=20
> Missing changelog. That's v2, not v1? Provide changelog under --- and ver=
sion your patches correctly. b4 does it for you...
>=20
>=20
> >  .../bindings/iio/imu/bosch,smi240.yaml        | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644=20
> > Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> >=20
> > diff --git=20
> > a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml=20
> > b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> > new file mode 100644
> > index 00000000000..5e89d85d867
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:=20
> > +https://eur03.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Fiio%2Fimu%2Fbosch%2Csmi240.yaml%23&data=3D05%7C0
> > +2%7CJianping.Shen%40de.bosch.com%7Ce4bd3cadbf5f4b17bf7308dcabe2e9b6%7
> > +C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638574238283264004%7CUnkn
> > +own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
> > +iLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DgbcSKWPDSDT0qTWo5L%2FUYxlQDunqNl2l
> > +L7JAxwHhNJY%3D&reserved=3D0
> > +$schema:=20
> > +https://eur03.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=3D05%7C02%7CJianping.Shen
> > +%40de.bosch.com%7Ce4bd3cadbf5f4b17bf7308dcabe2e9b6%7C0ae51e1907c84e4b
> > +bb6d648ee58410f4%7C0%7C0%7C638574238283281959%7CUnknown%7CTWFpbGZsb3d
> > +8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > +C0%7C%7C%7C&sdata=3DkW25MDdZz9c3ePA%2BUrGXSWsBWlDxb6UAKjOeLSnFEXU%3D&re
> > +served=3D0
> > +
> > +title: Bosch SMI240 IMU
> > +
> > +maintainers:
> > +  - Jianping Shen <Jianping.Shen@de.bosch.com>
> > +
> > +description: |
>=20
> Do not need '|' unless you need to preserve formatting.
>=20
> > +  The SMI240 is a combined three axis angular rate and three axis=20
> > + acceleration sensor module  with a measurement range of +/-300=B0/s a=
nd up to 16g. SMI240 does not support interrupt.
> > + =20
> > + https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> > + w.bosch-semiconductors.com%2Fmems-sensors%2Fhighly-automated-driving
> > + %2Fsmi240%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7Ce4bd3cadb
> > + f5f4b17bf7308dcabe2e9b6%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7
> > + C638574238283298041%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> > + IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Dd2%2Bk
> > + j8GzUms9o0Nbdu9QpTzZwujQnjJMp0GFp%2B5MrB0%3D&reserved=3D0
>=20
> This does not look like wrapped according to Linux Coding Style. See Codi=
ng Style, so 80.
>=20
> > +
> > +properties:
> > +  compatible:
> > +    const: bosch,smi240
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: provide VDD power to the sensor.
> > +
> > +  vddio-supply:
> > +    description: provide VDD IO power to the sensor.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        spi@0 {
>=20
> That's not a SPI controller. Your description suggests "imu".
>=20
> Best regards,
> Krzysztof
>=20

--z4NQh/ZZRjlgWpNL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqEc8wAKCRB4tDGHoIJi
0g/sAP9MhRCKKw8vBNbLKlks9BmPKuN40U1C30jh/YSEYDCK8AD+O/1+Pv3731dG
A8IlfvXTpvntl//0eLR5Pr9YCuSutQo=
=G1i3
-----END PGP SIGNATURE-----

--z4NQh/ZZRjlgWpNL--

