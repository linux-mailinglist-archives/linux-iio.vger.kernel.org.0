Return-Path: <linux-iio+bounces-24876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D51BBCA3C3
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 18:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9433C4759
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26E225416;
	Thu,  9 Oct 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikK7YUwk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92D21CC79;
	Thu,  9 Oct 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028525; cv=none; b=T+GEvwD7/UNa5ur9WWWHe3KCHMgyYAFY5Kh61r4HvxAoW2R8FHpBNcSIVQ9kEbgDagKiNohQakLK0IQruNlhasiM///JIS0Rgxpaqhl2cahmpQkY6VhVyUI4fk+HIsE1ZrBg9s1eZvdpL+NzfUoK6ZFfEOzwV1JsOXIS2SBvqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028525; c=relaxed/simple;
	bh=1YqLlKixVNW6t8A6z6DdqayoYTseCKmtsXME3qIeraQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD2cjasxeIgXedGps7vBRWJGpCt8gB+mdYZ/3FjrOp+PoSozhpsPokGPolwXxYkyAeZCHsPxNB9JCQclW1LHS32MuwBXp5SsZKshG/pNfLb2b1NPDK+Zbnzil6i/c2i/DKp21Rjucf2pxH14QEHD74hy/Bi4TJ9BVEn6kmj9aLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikK7YUwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDE9C4CEE7;
	Thu,  9 Oct 2025 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760028524;
	bh=1YqLlKixVNW6t8A6z6DdqayoYTseCKmtsXME3qIeraQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikK7YUwkH3NNRg1jDP8ti2XVZ25rmGCB6DQtqaNiQsOSyLc+4nax+SsLZA71pFxYu
	 Ld2cy+qLlrEUYTEMPNINui/yGSZa+yPgHV/dBoaprD7g2vjQvX6PYE/ertYiTHg+Jz
	 6E1GIuVbcqnoTGaG6KvnaBN+PZbfp2eh3SN07JePyhDw1VsuzQUeNYy1a5Thh00at5
	 dCdV0AG9r01qw8a2S8OVTSFscFyQG/1Q+taDzQTN7Un2+J1gn2zWkRRszMOEt8SNSM
	 DzP9Por67HVSToDyWz1xofE5VJndwWtyElzjICrawgwOLGGpyUzhO1rt6Nhzrwoszk
	 /CB2tj4GEKX4g==
Date: Thu, 9 Oct 2025 17:48:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dima.fedrau@gmail.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com,
	Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: imu: smi330: Add binding
Message-ID: <20251009-squishy-poem-ddb0fdd9583d@spud>
References: <20251009153149.5162-1-Jianping.Shen@de.bosch.com>
 <20251009153149.5162-2-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ifzSNsRgI1TNdLUQ"
Content-Disposition: inline
In-Reply-To: <20251009153149.5162-2-Jianping.Shen@de.bosch.com>


--ifzSNsRgI1TNdLUQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 05:31:48PM +0200, Jianping.Shen@de.bosch.com wrote:
> From: Jianping Shen <Jianping.Shen@de.bosch.com>
>=20
> Add devicetree binding for Bosch imu smi330.
> The smi330 is a combined three axis angular rate and
> three axis acceleration sensor module.
>=20
> Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>

https://lore.kernel.org/all/20250916-henna-rinsing-32a18a4d30b9@spud/

Why did you ignore my ack?
Didn't Jonathan already apply v4 of this two weeks ago, why is there
even a v5 to begin with?

Conor.

> ---
>  .../bindings/iio/imu/bosch,smi330.yaml        | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi33=
0.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml =
b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
> new file mode 100644
> index 00000000000..0270ca456d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,smi330.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch SMI330 6-Axis IMU
> +
> +maintainers:
> +  - Stefan Gutmann <stefam.gutmann@de.bosch.com>
> +
> +description:
> +  SMI330 is a 6-axis inertial measurement unit that supports acceleratio=
n and
> +  gyroscopic measurements with hardware fifo buffering. Sensor also prov=
ides
> +  events information such as motion, no-motion and tilt detection.
> +
> +properties:
> +  compatible:
> +    const: bosch,smi330
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: provide VDD power to the sensor.
> +
> +  vddio-supply:
> +    description: provide VDD IO power to the sensor.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +  drive-open-drain:
> +    type: boolean
> +    description:
> +      set if the interrupt pin(s) should be configured as
> +      open drain. If not set, defaults to push-pull.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example for I2C
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        imu@68 {
> +            compatible =3D "bosch,smi330";
> +            reg =3D <0x68>;
> +            vddio-supply =3D <&vddio>;
> +            vdd-supply =3D <&vdd>;
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <26 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names =3D "INT1";
> +        };
> +    };
> +
> +    // Example for SPI
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        imu@0 {
> +            compatible =3D "bosch,smi330";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <10000000>;
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <26 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names =3D "INT1";
> +        };
> +    };
> --=20
> 2.34.1
>=20

--ifzSNsRgI1TNdLUQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOfnZwAKCRB4tDGHoIJi
0tQ7AQCndhP3ffMWKNUtK7fPczCtGHHnlJf0UP2mPQbOTQSUswD/b6rVZCLTcGTI
mjEhuwQ8rg9geOuGSVi17hV/tmh0Zgg=
=7oxX
-----END PGP SIGNATURE-----

--ifzSNsRgI1TNdLUQ--

