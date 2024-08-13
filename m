Return-Path: <linux-iio+bounces-8446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C18A950974
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 17:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A65B23CBC
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59961A072B;
	Tue, 13 Aug 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhsPtjjj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BE4D8DA;
	Tue, 13 Aug 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564361; cv=none; b=oxY9XrzeydOaSMxHJfEP1BBOx4QdMuMn3H7QLII40bFrxLhjGqskr2E4kN3tkIgDIUbQBf+j6J4KgEMYa/0Mulat6jX3rD53Puwx9B21hVGIDkNPOCJ0z96Wk1XU6DDSonlBGbgGtW24FtrZ0K8cN38i6KAIxCaI8xx4WPOxGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564361; c=relaxed/simple;
	bh=ZlKUmXlqq9/iNnq096zz+gRPSOfnGhngngYJ4qgE5pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5E4fejYANxJntNjrhVywb7q2KoTF20KiKC+n4n/8GlZ85Ezvap9y0tSSAs1bw7bdErbCK4S5gyjLRI5urEeTE3CUTzt60rn01eVZNC3Di3rz6vnaOxBjIiZGX7Zd4gNVLgUG0pBxQahY7yMiNQO1eBQ8i2vdqDTmEsVB2rjjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhsPtjjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652E6C4AF0B;
	Tue, 13 Aug 2024 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564361;
	bh=ZlKUmXlqq9/iNnq096zz+gRPSOfnGhngngYJ4qgE5pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhsPtjjjWazLteTlYkPd9J5ZfufuCVCkSMCfJ7hyxJgs9Jc4MuParMSur9EfM7VUH
	 YAW7na7jQ/cmkI2KGvg/+6MZMGiryuza4Cw/YXjXe1vpjQMKEF4aRe02FsAEQfQGud
	 1azzsJ4nJpgn2w4H8984gZTf9eMdf47GQTEw1wMZAPiuUnoNh2wn1IGdiM+48OnaDq
	 czJisRQLIGZe+fnhEwKavXfthqpdJB9kJrHjEGSVHvMfkyoZI6qtzK8fKw+0HxWAmZ
	 yNfj3S5x/HuKnMGSGPlx6n+UjEGrWD65Q0guR7y5BSgE9Ht2A4ohwJTz3SMAmk1AWT
	 FKtgwNV70lRJg==
Date: Tue, 13 Aug 2024 16:52:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add everlight pm16d17 binding
Message-ID: <20240813-captivity-spellbind-d36ca0f31e22@spud>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
 <f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2VX6fNxUtDign4YH"
Content-Disposition: inline
In-Reply-To: <f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>


--2VX6fNxUtDign4YH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 07:40:41AM +0200, Jan Kiszka wrote:
> From: Chao Zeng <chao.zeng@siemens.com>
>=20
> Add the binding document for the everlight pm16d17 sensor.
>=20
> Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
> Co-developed-by: Baocheng Su <baocheng.su@siemens.com>
> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>

Ditto here Jan.

> ---
>  .../iio/proximity/everlight,pm16d17.yaml      | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/everl=
ight,pm16d17.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/proximity/everlight,pm=
16d17.yaml b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16=
d17.yaml
> new file mode 100644
> index 000000000000..fadc3075181a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.y=
aml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/everlight,pm16d17.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Everlight PM-16D17 Ambient Light & Proximity Sensor
> +
> +maintainers:
> +  - Chao Zeng <chao.zeng@siemens.com>
> +
> +description: |
> +  This sensor uses standard I2C interface. Interrupt function is not cov=
ered.

Bindings should be complete, even if software doesn't use the
interrupts. Can you document them please.

> +  Datasheet: https://en.everlight.com/sensor/category-proximity_sensor/d=
igital_proximity_sensor/

Do you have a link to a datasheet? The link to the pm16d17 here 404s for
me.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - everlight,pm16d17
> +
> +  reg:
> +    maxItems: 1
> +
> +  ps-gain:
> +    description: Receiver gain of proximity sensor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8]
> +    default: 1
> +
> +  ps-itime:

How did you get itime from conversion time? To the layman (like me!)
conversion-time would make more sense...

Also, "ps"? The whole thing is a proxy sensor, so why have that prefix
on properties. What is missing however is a vendor prefix.

> +    description: Conversion time for proximity sensor [ms]
> +    $ref: /schemas/types.yaml#/definitions/string

Instead of a string, please use the -us suffix, and put this in
microseconds instead.

In total, that would be s/ps-itime/everlight,conversion-time-us/.

I would, however, like to know why this is a property of the hardware.
What factors do you have to consider when determining what value to put
in here?

> +    enum:
> +      - "0.4"
> +      - "0.8"
> +      - "1.6"
> +      - "3.2"
> +      - "6.3"
> +      - "12.6"
> +      - "25.2"
> +    default: "0.4"
> +
> +  ps-wtime:
> +    description: Waiting time for proximity sensor [ms]
> +    $ref: /schemas/types.yaml#/definitions/string

All of the same comments apply here. E.g. why "wtime" isntead of
"waiting-time" and so on.
I would really like to know why these things are properties of the
hardware, rather than something that software should control.

> +    enum:
> +      - "12.5"
> +      - "25"
> +      - "50"
> +      - "100"
> +      - "200"
> +      - "400"
> +      - "800"
> +      - "1600"
> +    default: "12.5"
> +
> +  ps-ir-led-pulse-count:
> +    description: IR LED drive pulse count
> +    $ref: /schemas/types.yaml#/definitions/uint32

All custom properties require a vendor prefix, not "ps". Again, what
makes this a property of the hardware, rather than something that
software should control?

> +    minimum: 1
> +    maximum: 256
> +    default: 1
> +
> +  ps-offset-cancel:
> +    description: |
> +      When PS offset cancel function is enabled, the result of subtracti=
ng any
> +      value specified by the PS offset cancel register from the internal=
 PS
> +      output data is written to the PS output data register.

Again, what makes this a property of the hardware? What hardware related
factors determine that value that you put in here?

Thanks,
Conor.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    maximum: 65535
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        lightsensor: pm16d17@44 {
> +            compatible =3D "everlight,pm16d17";
> +            reg =3D <0x44>;
> +
> +            ps-gain =3D <1>;
> +            ps-itime =3D "0.4";
> +            ps-wtime =3D "12.5";
> +            ps-ir-led-pulse-count =3D <1>;
> +            ps-offset-cancel =3D <280>;
> +        };
> +    };
> --=20
> 2.43.0
>=20

--2VX6fNxUtDign4YH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZruBRQAKCRB4tDGHoIJi
0gbgAPY6XCZ4NPiuN7/Q9RHJY3EJ2FM+sX/sRAtOqS031dAfAQCgOsa90zWkxzvq
GfQrOrbGe+Sf6+rB1Z0SfpoAn/A+Cg==
=O01h
-----END PGP SIGNATURE-----

--2VX6fNxUtDign4YH--

