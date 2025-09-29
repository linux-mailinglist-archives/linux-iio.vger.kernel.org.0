Return-Path: <linux-iio+bounces-24570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6D5BAA2E8
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C741162952
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7E01F1538;
	Mon, 29 Sep 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8hWv2qe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1C214813;
	Mon, 29 Sep 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167233; cv=none; b=kihGCy5BFrYtxhGbUa4EGuvwVzTG4ILt5gv288xbPzNhjthGNHe6/9xmbDdnDvdo2ia0gMYbxFmbog+289nMqGiVg0lL6uJ7KpXr37nZWXeXW1CkoJPajOGEVxNkJAmevY2DjzNm4dVAq2krQaT03z/nONF0tP4KRRtcpUht5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167233; c=relaxed/simple;
	bh=4rZNsu8QGDCFma7zcOHapI/aN7/dV6PWZmNXgYGyJMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd+9kA8QEGnMW4iCoVQsGc0e5/ug/qH4MUBxoboNgJugSHtJj/+AEYEDWbwkAdC/Oe+74To8FxS3G1oOTQSzuQJp6Ur0KbJRuiywqXEs00O7V7jfjP02leVEFD5d6mLgWTWTxWqOQwenwdtPmawrHholEc0N+IHFFWopUDJbYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8hWv2qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05A3C4CEF4;
	Mon, 29 Sep 2025 17:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759167231;
	bh=4rZNsu8QGDCFma7zcOHapI/aN7/dV6PWZmNXgYGyJMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8hWv2qemqh0aLgpmmqQNk0IqAOp4EXTerzehasHk8KGl4IPWsOLUTfbBbj/b5imO
	 odArmW+o2BxOhvAb4359t5cHtVQwyqVpPVKYCEuWgcLEF8kb1qZBOP5czSPtkIuwHJ
	 JBjdtStCZooIK9Xz+hF5UyBwQxOYw9xueKC/1Tvq0rtbOUk1mavxK2iaNBLFX4E9MU
	 0Ab98p3if0nFjbBgVuqzCLdYyW+JNDX5vTJMHbFXwFNgAq4qNpHijb4u04wZUlqaGR
	 AOMKU4hfClOTlutJWXgc42ZsbYYcL4gTUKd+yKpCaxgpdjizMooqhU2nXzwAWvTCSJ
	 sYlHdlL+vG0pg==
Date: Mon, 29 Sep 2025 18:33:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com,
	gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	peterz@infradead.org, jstephan@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	jonathan.cameron@huawei.com, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: temperature: Add NXP P3T175x
 support
Message-ID: <20250929-panther-providing-d69e6016acc9@spud>
References: <20250929094543.2512264-1-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgliMA4ktxGmPwLv"
Content-Disposition: inline
In-Reply-To: <20250929094543.2512264-1-lakshay.piplani@nxp.com>


--cgliMA4ktxGmPwLv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 03:15:42PM +0530, Lakshay Piplani wrote:
> Add bindings for the NXP P3T175x (P3T1750/P3T1755) temperature
> sensor, supporting both I2C & I3C interfaces.

Can you please mention here what the difference between devices is?

>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
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

--cgliMA4ktxGmPwLv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrC+QAKCRB4tDGHoIJi
0mW2AP4uqFgdTFvca8mVJA+tAqUvGIeQxDEbIIM3/yjbo7QZ8wD/TfF3agyYq+6T
r7amWo2btMqsEsrOfeuACJfJRyP5EAA=
=BQew
-----END PGP SIGNATURE-----

--cgliMA4ktxGmPwLv--

