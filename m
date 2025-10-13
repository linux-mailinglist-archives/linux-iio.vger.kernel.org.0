Return-Path: <linux-iio+bounces-25040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E0BD6017
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 21:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6660640241D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4DA2DA765;
	Mon, 13 Oct 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJYFPyGn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0552264D9;
	Mon, 13 Oct 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385037; cv=none; b=a5J9iDV7AJDZIS3V+4bg1/cAH+KHJz3XqTrjsX2J8ksV1BePE7LcptmVVUY5OSNZT9O/dSu8nilJ5oOlQPpKtCoYqY+GrzoauDc3CZ5YQdQRazf9ku0tTea64IreoBdEX/uXKXzvDZA0iTgfRBwrY6BhyDGnSACHmh1S1viWcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385037; c=relaxed/simple;
	bh=RTh2qQLRy2voO67dBZSLvPZprE+dNHWREq6r4yE8Mk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4DAk2JJqYLibfIM+aNAAIxwBdPry0e8pdApYJ8Uw7dQyZRPW75d9qmE0hZQuyocWAQ4F2+ae+JLxMrDEFoUVuz1y94UOfLJVOlWGFl6YZjReaeweMwvuOzszFq18NfJe25zC0TI5IiOz4yAwrNccBS7+Zi2ebuII1T44vW4z50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJYFPyGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB908C4CEE7;
	Mon, 13 Oct 2025 19:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760385036;
	bh=RTh2qQLRy2voO67dBZSLvPZprE+dNHWREq6r4yE8Mk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJYFPyGnKukKJNwjAB7nsV/eQ8UTkrCIhyaAvA41S2ffyHHg8+Naq4/0JoYVAkEIR
	 0hvyWjekpPulSaXrZ35ijIsu3qxhFwz6g2EUmTr8x++VwwEetlZoVnSnoN0XVVI0uO
	 X27A0p5q1p1ttB8E0XATjwnGKgFTm/Z0aleI8E2yA0UphczVnYqmHxtZbdbrGiowxC
	 twIHwxRQPaDpQIeaodgiZT9GL1moLAaAPySYqmMp2vbLkM+XwnxQwfqdTV9OHD9c3L
	 vSDBncoKwuAcRv7LXA9jIrCAQn/eO0tu0XQB9Zh/1rdfj7pszhL8LcLd+Ix22V71UT
	 ve1lC3tV/iXOQ==
Date: Mon, 13 Oct 2025 20:50:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <20251013-step-quaintly-c58d8a1a460b@spud>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-1-0f8ce7fef50c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RlRwCY1q8HISHvhf"
Content-Disposition: inline
In-Reply-To: <20251013-staging-ad4062-v1-1-0f8ce7fef50c@analog.com>


--RlRwCY1q8HISHvhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 09:27:59AM +0200, Jorge Marques wrote:
> Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> monitor capabilities SAR ADCs. Each variant of the family differs in
> granuality. The device contains two outputs (gp0, gp1). The outputs can
> be configured for range of options, such as threshold and data ready.
> The device uses a 2-wire I3C interface.
>=20
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 83 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 89 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..dcf86088fc4f32de7ad681561=
a09bad2755af04c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4062.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4062 ADC family device driver
> +
> +maintainers:
> +  - Jorge Marques <jorge.marques@analog.com>
> +
> +description: |
> +  Analog Devices AD4062 Single Channel Precision SAR ADC family
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
4060.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
4062.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4060
> +      - adi,ad4062
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: gp0
> +        description: Signal coming from the GP0 pin.
> +      - const: gp1
> +        description: Signal coming from the GP1 pin.

Please move the descriptions to the interrupts property, by creating an
items list there. I think more information should probably be provided
about them, than just "signal coming from", perhaps referencing the
ability for what the signal actually represents being controllable at
runtime.

> +
> +  vdd-supply:
> +    description: Analog power supply.
> +
> +  vio-supply:
> +    description: Digital interface logic power supply.
> +
> +  ref-supply:
> +    description: |
> +      Reference voltage to set the ADC full-scale range. If not present,
> +      vdd-supply is used as the reference voltage.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vio-supply
> +
> +allOf:
> +  - $ref: /schemas/i3c/i3c.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i3c {
> +        #address-cells =3D <3>;
> +        #size-cells =3D <0>;
> +
> +        ad4062: adc@0,2ee007c0000 {

Remove the ad4062 label here, since there are no users.

Cheers,
Conor.

pw-bot: changes-requested

> +            reg =3D <0x0 0x2ee 0x7c0000>;
> +            vdd-supply =3D <&vdd>;
> +            vio-supply =3D <&vio>;
> +            ref-supply =3D <&ref>;
> +
> +            gp1-gpios =3D <&gpio0 0 GPIO_ACTIVE_HIGH>;
> +            gp0-gpios =3D <&gpio0 1 GPIO_ACTIVE_HIGH>;
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <0 0 IRQ_TYPE_EDGE_RISING>,
> +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "gp0", "gp1";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f090c2f6e63a0d255a025885cc4573f5802ef159..afbfaeba5387b9fbfa9bf1443=
a059c47dd596d45 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1400,6 +1400,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,a=
d4030.yaml
>  F:	Documentation/iio/ad4030.rst
>  F:	drivers/iio/adc/ad4030.c
> =20
> +ANALOG DEVICES INC AD4062 DRIVER
> +M:	Jorge Marques <jorge.marques@analog.com>
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> +
>  ANALOG DEVICES INC AD4080 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
>=20
> --=20
> 2.49.0
>=20

--RlRwCY1q8HISHvhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaO1YBwAKCRB4tDGHoIJi
0n2pAQDQUqZKxVS/Fi8UDVh9b6mYPR3VqeiZgt0GW/NYaqmKLQD+JiTFL7Rw6HV3
1v+YhASFyCE3ozd8V5LLvPPD5kwxaAs=
=WHF1
-----END PGP SIGNATURE-----

--RlRwCY1q8HISHvhf--

