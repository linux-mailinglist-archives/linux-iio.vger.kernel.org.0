Return-Path: <linux-iio+bounces-80-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0027EC575
	for <lists+linux-iio@lfdr.de>; Wed, 15 Nov 2023 15:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C5528149A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Nov 2023 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F32EAEE;
	Wed, 15 Nov 2023 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCHf3pqh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047A2FC2A;
	Wed, 15 Nov 2023 14:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14A5C433C8;
	Wed, 15 Nov 2023 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700059137;
	bh=V6YbwlGcrf2Z9pv+riw05AJ1AB+MKCO/JbUd36Barhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCHf3pqhF4URY84pt75400f8LCvqCFX9rOe1/AJnXhtMQQYT0KHbR4ow9znYb58lx
	 JmcfqiDM8oTaMGjZPmLodk6uwmKBauUUrk91Wo3fDSTpmnfUHsIoLoNgt536vSprve
	 CBk56G0MBPrhaDxO/zt5Kaw9khOJiAENffeXtryF6cLWyb7rJamSLh4WMOjBPSM1ho
	 cL3vzpvromKAMWA9+rR7s1VjI8fbHbxP6ZQrbFXDan8nX1C5BbSjFe7KXGgFNOlAGf
	 tzB9NT+Hk6oNGAlM8KiXkTqqq78emc5aQjWj5to/KieCytTXdSngjnPmd0tlqNkbU+
	 4MmvO85fN9CZQ==
Date: Wed, 15 Nov 2023 14:38:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: trivial-devices: add aosong,ags02ma
Message-ID: <20231115-stability-arrive-e0458f6f7b0f@squawk>
References: <20231115125810.1394854-1-anshulusr@gmail.com>
 <20231115125810.1394854-2-anshulusr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1U46IvZoQyzS/ftn"
Content-Disposition: inline
In-Reply-To: <20231115125810.1394854-2-anshulusr@gmail.com>


--1U46IvZoQyzS/ftn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 06:28:07PM +0530, Anshul Dalal wrote:
> Add bindings for Aosong AGS02MA TVOC sensor.
>=20
> The sensor communicates over i2c with the default address 0x1a.
> TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.
>=20
> Datasheet:
>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> Product-Page:
>   http://www.aosong.com/m/en/products-33.html
>=20
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> ---
>=20
> Changes for v2:
> - Removed device from trivial-devices

Your $subject still says "trivial-devices" though, so please fix that in
your next submission.

> - Added standalone binding with vdd-supply property
> ---
>  .../bindings/iio/chemical/aosong,ags02ma.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong=
,ags02ma.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,ags02m=
a.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
> new file mode 100644
> index 000000000000..4a0278c6318c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/aosong,ags02ma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aosong AGS02MA VOC Sensor
> +
> +description: |
> +  AGS02MA is an TVOC (Total Volatile Organic Compounds) i2c sensor with =
default
> +  address of 0x1a.
> +
> +  Datasheet:
> +    https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> +
> +maintainers:
> +  - Anshul Dalal <anshulusr@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aosong,ags02ma
> +      - asair,ags02ma

Why do you have two compatibles for the same device? Please document and
use only one of these. The aoson website says:
"Guangzhou ASAIR Electronic Co., Ltd"
so I suspect "asair" is a more apt vendor prefix.


Thanks,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        light-sensor@1a {
> +            compatible =3D "aosong,ags02ma";
> +            reg =3D <0x1a>;
> +            vdd-supply =3D <&vdd_regulator>;
> +        };
> +    };
> --=20
> 2.42.0
>=20

--1U46IvZoQyzS/ftn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVTX6AAKCRB4tDGHoIJi
0p8YAP97yIsknJKuaKNoFLpkjtdd7KHr4eWGOq6p5+3kJSLLdQEArd6XtnHdgfui
DfxPLrSxiaGIQHzHgjrlBCnSVV4pLAU=
=f488
-----END PGP SIGNATURE-----

--1U46IvZoQyzS/ftn--

