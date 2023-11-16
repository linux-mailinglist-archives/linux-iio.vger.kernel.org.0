Return-Path: <linux-iio+bounces-114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAF97EE274
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 15:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D910C1C20A7C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5F31755;
	Thu, 16 Nov 2023 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7iLLyr6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690A31728;
	Thu, 16 Nov 2023 14:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348A4C433C8;
	Thu, 16 Nov 2023 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700144159;
	bh=NqNngx7IGcQZOL1i4RZBel57M9UqE/S+QpP/P7tzoOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7iLLyr6LioSjjzCjCGziuC79WrEY3vRI00z8amYxugxe24caU82NjV7DMCVcO/94
	 /AFtXQM/j2NS5CO4qVVGnV+SmpejgmBL3dllBXZVtGfFHvOqIbK0v/zLi2khPwNNGI
	 P6XbSz5uSVhPTKhWFRGyHatRcpolH9loc9BxPGGOJOua6qmpZMcAHMDhsEy/PPpunD
	 +ZYanRf9plGcO/bgEQ1kF/ZvWrET1xOWV05Wj1Vnx3UBE3B21OWLI4QsBUkl+C53mV
	 EzWWz3vSkE2TNCZWMXGJzWKgmn6RWVRKPo+txnkoZPBDu8y/eng256Wse+6d+TmABc
	 WneJheSwEnp7w==
Date: Thu, 16 Nov 2023 14:15:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Li peiyu <579lpy@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH [2/2]] dt-bindings: iio: humidity: Add TI HDC302x support
Message-ID: <20231116-shriek-retouch-6a367b2422a3@squawk>
References: <20231116125433.13285-1-579lpy@gmail.com>
 <20231116131407.13860-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4A5WVN84xMuEuPuU"
Content-Disposition: inline
In-Reply-To: <20231116131407.13860-1-579lpy@gmail.com>


--4A5WVN84xMuEuPuU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 09:14:07PM +0800, Li peiyu wrote:
> Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
> temperature sensors.
>=20
> Signed-off-by: Li peiyu <579lpy@gmail.com>
> ---
>  .../bindings/iio/humidity/ti,hdc3020.yaml     | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc=
3020.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.ya=
ml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> new file mode 100644
> index 000000000000..8015c4bb5b2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>

Usually this is you, not the maintainer of the subsystem, since you have
the hardware in question and an interest in it specifically.

> +
> +description: |
> +  The HDC302x is an integrated capacitive based relative humidity (RH)
> +  and temperature sensor.
> +
> +  datasheet is available:
> +    https://www.ti.com/lit/ds/symlink/hdc3020.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,hdc3020
> +      - ti,hdc3021
> +      - ti,hdc3022

Looking at your driver, all three of these seem to be compatible?
I did only have a quick look though, so please correct me if that is not
the case. If they are compatible, please set this up to use a fallback
compatible - for example allow
compatible =3D "ti,hdc3020";
compatible =3D "ti,hdc3021", "ti,hdc3020";
compatible =3D "ti,hdc3022", "ti,hdc3020";

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        humidity@47 {

The generic node name here should probably be "humidity-sensor".

Cheers,
Conor.

> +            compatible =3D "ti,hdc3020";
> +            reg =3D <0x47>;
> +        };
> +    };
> --=20
> 2.34.1
>=20

--4A5WVN84xMuEuPuU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVYkGQAKCRB4tDGHoIJi
0isfAQDx4UAz4ZKk6C7D0bkkz/wh9YVUhL1bnysGg+PaGTo17wD/Ul22ueR6jCtR
DJhfPCD36Jj+R0FMeVN4l2bfg2z/Dgg=
=uVyx
-----END PGP SIGNATURE-----

--4A5WVN84xMuEuPuU--

