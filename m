Return-Path: <linux-iio+bounces-16481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E918A55164
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 17:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5D6166692
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C5E216385;
	Thu,  6 Mar 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdQ7BS4U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF11215F4A;
	Thu,  6 Mar 2025 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278713; cv=none; b=CDKMJ1lytnrd7ldqLc0T9vNQ72OJtprrDF7odvSmTEmMbhQk8xQPX6JOH2IFfTzaZ13+EVAPOUBLULv9cHdp7QYsabuCONSUpW+d4R/PoU+WgGyuWtiASRxeCJ4vp8/f4eQWrJpzvMf5bwDUUkUW1C15jcXTk0z700UDpSsvTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278713; c=relaxed/simple;
	bh=1YVNXREKerbJc2W0V2FUBlTZv41KD7ByV0F/aR+LAUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdDpRqj8Ws1Ukgjz/n+ZBavMjhtJTPyJEorhZ+U8M3UcrSGj7ofqHPzOrs0BQwwazfa9scEbBmORR2YrpmRG3wzCULYd2bX+ZG4ojqBxuuvxkylsAY2Kfey+m7YbxA6L4BggGC4d6szUIOym9e01pF6ozX2q2hrPn4ciT9mFxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdQ7BS4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2E6C4CEE0;
	Thu,  6 Mar 2025 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741278712;
	bh=1YVNXREKerbJc2W0V2FUBlTZv41KD7ByV0F/aR+LAUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdQ7BS4UXLnDumIjCHtlwxlpW7xog3RJfd799Zr12Bfpt4fQlHaso4vFju7+SVkHO
	 RAFr2c2KqIry19OvRuyJvG2NpxvfUQsbyZXbjJa6osN58UXu+GWr8lU59+nTyy7xe4
	 OauS/zEGC629wHvrK9nDK3tok9qYLZEEBDH+Cm+pFAkqceruQnoNGz0MUUjQltbmCW
	 5FIzaRkG8GFcrO4YYGfDMbzod0X37GUE2wgNW87nrfnrk13Ar7XHtw0tyYP80wHV3a
	 qOqRkMfJ7CxSBR2jYudAfbyp/rvh9WxX1g8qpl6UyAUJQjanvH7AGDpSD9yj5MxOaL
	 vlUrWCaJ6DVBA==
Date: Thu, 6 Mar 2025 16:31:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <20250306-promotion-tarmac-bc5172f38f31@spud>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WnsN0m5riA8cEpX8"
Content-Disposition: inline
In-Reply-To: <20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>


--WnsN0m5riA8cEpX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 03:03:15PM +0100, Jorge Marques wrote:
> Add dt-bindings for AD4052 family, devices AD4050/AD4052/AD4056/AD4058,
> low-power with monitor capabilities SAR ADCs.
> Contain selectable oversampling and sample rate, the latter for both
> oversampling and monitor mode.
> The monitor capability is exposed as an IIO threshold either direction
> event.
>=20
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4052.yaml    | 80 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 86 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..4602f1f0184d58f33883852ff=
6d76933758825f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4052.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4052 ADC family device driver
> +
> +maintainers:
> +  - Jorge Marques <jorge.marques@analog.com>
> +
> +description: |
> +  Analog Devices AD4052 Single Channel Precision SAR ADC family
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
4050.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
4052.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4050
> +      - adi,ad4052
> +      - adi,ad4056
> +      - adi,ad4058

Can you mention in your commit message what differs between these
devices that makes picking one as the "base"/fallback compatible
unsuitable please?

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Reference clock
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: threshold events.
> +      - description: device ready and data ready.
> +
> +  cnv-gpios:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 62500000
> +
> +  vdd-supply: true
> +  vdd_1_8-supply: true

You're allowed to use . in property names, and the _s should be -s.
That said, vdd and vdd 1.8? Shouldn't both have the voltage in them in
that case?

> +  vio-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ad4052";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <25000000>;
> +
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <0 0 IRQ_TYPE_EDGE_RISING>,
> +                         <0 1 IRQ_TYPE_EDGE_RISING>;
> +            cnv-gpios =3D <&gpio 2 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06f122cb8bbd15a0076c229dfc89be0b5126f237..fef8adaee888d59e1aa3b3592=
dda5a8bea0b7677 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1317,6 +1317,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,a=
d4030.yaml
>  F:	Documentation/iio/ad4030.rst
>  F:	drivers/iio/adc/ad4030.c
> =20
> +ANALOG DEVICES INC AD4052 DRIVER
> +M:	Jorge Marques <jorge.marques@analog.com>
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> +
>  ANALOG DEVICES INC AD4130 DRIVER
>  M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
>  L:	linux-iio@vger.kernel.org
>=20
> --=20
> 2.48.1
>=20

--WnsN0m5riA8cEpX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8nN8wAKCRB4tDGHoIJi
0rPgAP9RY5AUojf9A7qx28AknUa06FgmWImev3hlMVjQpw2JagEA2GIGsqkLO38v
mwAISqfFo5ejMR4bXk+RvBQEhvNknAQ=
=GEYD
-----END PGP SIGNATURE-----

--WnsN0m5riA8cEpX8--

