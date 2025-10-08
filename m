Return-Path: <linux-iio+bounces-24864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2ABC6A0D
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 23:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991E718998E0
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 21:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9DD284893;
	Wed,  8 Oct 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvAUh2Bi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8F63B9;
	Wed,  8 Oct 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957310; cv=none; b=bHNgensd/VGDBggysu+cZ+MALHn7GLExCbl6mSKw/96ZxHPNY9VoqgKQOEqygEUmjV0TRr8QmiwZLHGOvR65/7yczTpqJk/5Nw6nOUsNhSktbaYPtoQq/fkhFYxBcKmVVPDOO44X00idvPGDZi+j6vzLXTP0buAYNX6k+2Adgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957310; c=relaxed/simple;
	bh=15UYY3+XhX9yKY0WQdEZQLLk6SlLzD2Dvnh5FJ+vIKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HceeLr1W8kWDPo4R59d5pFyj3liUXudTdr8t3xlpJp4KWRiLXWJQOazqr82Lhpb6wO2NFBQH1FSzyg+TidCS//7ZLFPpNz2QwtD+unVVeNQotV4sqFenKnAU3W0eeWVGv2X89U3AXQ3VUg4zvenBbXFcqxQ8PYcXEMEVeh0PkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvAUh2Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461CEC4CEE7;
	Wed,  8 Oct 2025 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759957310;
	bh=15UYY3+XhX9yKY0WQdEZQLLk6SlLzD2Dvnh5FJ+vIKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvAUh2BiLU5uCl+Ns+KtxmYjvDuaPJXnhhDRPoxI8UPlZoIFvHWa9eoPRLEDygLWg
	 jGeJkrZeV/SoBfldILcts+KBwbWOgle9BVSpHmzZO4xPs7rS73RQheSpB1WwVnoHQj
	 W6Lq2A/FFuubeHPD/Kw+drs/vVwd5jERWKA8M9f0R2Bsk4iWswvrGISw8llaAhY3wO
	 IIPlT+ZiUzmRD3u5IDuDPojni9ziQzL7qoUjkq96hcj4GnaYSR5xI/fsrv4lQpVXPP
	 oU0LOxztUYO0p7xzwPRIxB2lBNDxarkY8ddnbEH1G2Tnn3ZtGGP1GJbV75QEDBTb/X
	 CmKRpPr6sNxmw==
Date: Wed, 8 Oct 2025 22:01:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com,
	gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	peterz@infradead.org, jstephan@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	jdelvare@suse.com, linux@roeck-us.net, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: temperature: Add NXP P3T175x
 support
Message-ID: <20251008-agility-suffix-317de5698a5d@spud>
References: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
 <20251008100713.1198461-2-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wvEdgMsuivxB+WiK"
Content-Disposition: inline
In-Reply-To: <20251008100713.1198461-2-lakshay.piplani@nxp.com>


--wvEdgMsuivxB+WiK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 03:37:12PM +0530, Lakshay Piplani wrote:
> Add bindings for the NXP P3T175x (P3T1750/P3T1755) temperature
> sensor, supporting both I2C & I3C interfaces.
>=20
> The P3T1750 and P3T1755 are functionally equivalent temperature
> sensors with identical interfaces and features. The P3T1755 offers
> improved accuracy(=C2=B10.5=C2=B0C) in the =E2=80=9320=C2=B0C to +85=C2=
=B0C range, while both
> maintain =C2=B11=C2=B0C accuracy across =E2=80=9340=C2=B0C to +125=C2=B0C.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
> V3 -> V4: Changes since V3:
> 	  - Updated commit message to clarify the difference between P3T1750 and=
 P3T1755.
> V2 -> V3: Changes since V2:
>           - Removed nxp,interrupt-mode and nxp,fault-queue properties fro=
m DT binding
>           - Updated compatible strings:
>             - nxp,p3t1750-iio =E2=86=92 nxp,p3t1750dp
>             - nxp,p3t1755-iio =E2=86=92 nxp,p3t1755dp
> V1 -> V2: Changes since V1:
>           - Dropped nxp,alert-active-high
>           - Fixed YAML formatting, line wrapping, and examples
>=20
>  .../bindings/iio/temperature/nxp,p3t1755.yaml | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/nxp=
,p3t1755.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/nxp,p3t175=
5.yaml b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> new file mode 100644
> index 000000000000..16a01fa81251
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml

This filename should actually match the compatible, so you're missing
dp.
dG
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/nxp,p3t1755.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP P3T175xDP Temperature Sensor
> +
> +maintainers:
> +  - Lakshay Piplani <lakshay.piplani@nxp.com>
> +
> +description: |
> +  Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
> +
> +  P3T175xDP (P3T1750/P3T1755) is a digital temperature sensor with a ran=
ge of
> +  -40=C2=B0C to +125=C2=B0C and a 12-bit resolution. It supports communi=
cation over both
> +  I2C and I3C interfaces.
> +
> +  The I2C interface supports up to 32 static addresses and provides an A=
LERT
> +  output to signal when temperature thresholds are crossed.
> +
> +  The I3C interface supports In-Band interrupts (IBI) in interrupt mode,
> +  allowing the device to notify the controller of threshold events witho=
ut
> +  dedicated alert pin.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,p3t1750dp
> +      - nxp,p3t1755dp
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      In I2C mode, the device supports up to 32 static addresses.
> +      In I3C mode, the 'reg' property encodes a triplet of
> +      <static-address BCR PID> used for device matching.
> +      Static address is optional if matching is done via PID.
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
> +        temp-sensor@48 {
> +            compatible =3D "nxp,p3t1755dp";
> +            reg =3D <0x48>;
> +            interrupt-parent =3D <&gpio2>;
> +            interrupts =3D <3 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> --=20
> 2.25.1
>=20

--wvEdgMsuivxB+WiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaObROAAKCRB4tDGHoIJi
0heMAP9bXoNNTQUYc8KJqRZG4ke9LdvyetG4wWJLCu2TCg+mhwD/fKGbocCbnzlu
fl4VmfNHIcVt9Mg3vap9EhfrBTvxMQ8=
=yT+I
-----END PGP SIGNATURE-----

--wvEdgMsuivxB+WiK--

