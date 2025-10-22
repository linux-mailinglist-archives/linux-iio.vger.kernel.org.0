Return-Path: <linux-iio+bounces-25358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C4BFDB67
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBEF3AAA02
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 17:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779092DC348;
	Wed, 22 Oct 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmGlDwG3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353E26ED4B;
	Wed, 22 Oct 2025 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155455; cv=none; b=AFZKn7dWlwXQbnK+Ix5JNXIaH4NshiSVjwpKcPsn6iLWyjFng0rl7VCa3D0De7HIMynIQAR2bZBdnsh6kCGDjIP9DqLZ/OrZRkBkCdqAB8tA85gOcHrt8dNsL9GR63QnmCyde+2H3IFsqilqEJQzdOaoWQQHkOZ582NBcJFQnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155455; c=relaxed/simple;
	bh=aMBfoiS7TXWQxlK+kUBxkNRtHrKbU0MW+tHVyHacEWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4c2s4XMoI+AWrltCtizMr+5VEJa5KdOv3ZxBBbWipelYW2c2p4CSjItyA9TMR/T4Jzb2Btx2IGXUo7wb/pgpsf7aiL/lnVGeuGzAlTcR5ocs8OPn/YdwZqQ9joli+pllDqDuRNXxYv68btQ6X//a6fVUtLjoUtiPQIZ78xUYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmGlDwG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5E3C4CEE7;
	Wed, 22 Oct 2025 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155454;
	bh=aMBfoiS7TXWQxlK+kUBxkNRtHrKbU0MW+tHVyHacEWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmGlDwG3lM+s4sUd1DbnBulxrCsg6Js8EY0vZsV/rPi5RUDPMQMXVwbZnToV7ezDL
	 neje42tlXom4X5yh+ndfR9ZX4AHeD69oLO15OQj/JxF6SzuYcfXGa1F5IVZ/AHx5yc
	 qnPcwLpuAB8DbBXm5TRqtrQb06e42p1WF+dXORf0gXVlRTuOhsiwYZIOEdTBeDXVmx
	 mLFFeX5SX3eiUxX5S5nuff5sSg54IBXXfE0LAGj4pTFCvIOfXxp72ELYiSmmLdo3QK
	 DJ0a2TgI4yndDYtOhxfPsnMYUQxTYeaSd2l7TBswoBzeycCsp5AVqYvEdHsKh1bmD1
	 O5HeuVIwM3MiQ==
Date: Wed, 22 Oct 2025 18:50:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Aditya Dutt <duttaditya18@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Frank Zago <frank@zago.net>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: position: Add ams AS5600 Position
 Sensor
Message-ID: <20251022-savanna-gluten-0c5397bd4de4@spud>
References: <20251020201653.86181-1-duttaditya18@gmail.com>
 <20251020201653.86181-2-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OzPS2Shsrc7Vzr5x"
Content-Disposition: inline
In-Reply-To: <20251020201653.86181-2-duttaditya18@gmail.com>


--OzPS2Shsrc7Vzr5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 01:46:52AM +0530, Aditya Dutt wrote:
> The AS5600 is a Hall-based rotary magnetic position sensor using
> planar sensors that convert the magnetic field component perpendicular
> to the surface of the chip into a voltage, or a numerical value
> available through i2c.
>=20
> Add dt-bindings for the sensor.
>=20
> Datasheet: https://ams-osram.com/products/sensor-solutions/position-senso=
rs/ams-as5600-position-sensor

Looks like this device has two supplies, could you document those
please?

Additionally, this "PGO" pin - is it necessary for a driver to know what
state it is in to function correctly? If so, can the information about
which state it is in be gathered from i2c?
Should there also be an optional pgo-gpios property for the scenario
where it is not tied, but set by a GPIO, if that is even possible.

> Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
> ---
>  .../bindings/iio/position/ams,as5600.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/position/ams,as=
5600.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/position/ams,as5600.ya=
ml b/Documentation/devicetree/bindings/iio/position/ams,as5600.yaml
> new file mode 100644
> index 000000000000..d4c92dd41dd6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/position/ams,as5600.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/position/ams,as5600.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ams AS5600 Position Sensor
> +
> +maintainers:
> +  - Aditya Dutt <duttaditya18@gmail.com>
> +
> +description: |
> +  12-Bit Programmable Contactless Potentiometer
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ams,as5600

blank line here please.

> +  reg:
> +    maxItems: 1
> +    description: |
> +      The I2C register address of the device. Typical address for AS5600=
: 0x36.
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
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      ams5600@36 {

potentiometer@36

pw-bot: changes-requested

Cheers,
Conor.

> +        compatible =3D "ams,as5600";
> +        reg =3D <0x36>;
> +      };
> +    };
> +
> +...
> --=20
> 2.34.1
>=20

--OzPS2Shsrc7Vzr5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkZeQAKCRB4tDGHoIJi
0vBLAP9RMGFPj6gbrBZaaEIaeSxbhiHozKyiE248FCgnAYHnOAEAkrlBQoi+mcMx
fJLqI8ROL/gWvZhqBI3AEPibBFlUaQ4=
=GpNy
-----END PGP SIGNATURE-----

--OzPS2Shsrc7Vzr5x--

