Return-Path: <linux-iio+bounces-9964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF798C341
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 18:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76901C21CD6
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 16:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3A1CF5D0;
	Tue,  1 Oct 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyadSO9P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888681CC886;
	Tue,  1 Oct 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799515; cv=none; b=rSi8/9PO8iQqcuSbS0M9K3SNqYOqEyaSbc4tRhRRyR6NXlGmFtupTTpQEvSW7P4m5+z9SAtmtLLWD1lOqb4NB4Rugtz9bmBklSnHbXCrXof62HgLoYA+jSki67TkPlWXRSxPA1dhFbb52iHzVmBFppL5SOmJklrwVnn43J/t7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799515; c=relaxed/simple;
	bh=8CYtzeuLs6CCIRD2fBZvkMPfTc4SmlBullhKTpkXAIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWMz8ALIh0BtJPLRCw1ibsNOR2t7UeTH00AbdBAWDH5xvxVGds8p6HiT3f6N3xdFPPWZWEN/USQF4QjPCg25iaS0ezXWuT0Rv7LsFluoPfqVsvsgtmu8+ovSY2L/qM+vIyiY/NW4MkTjtkSSsw8PEyGwpwifd1O+j+c8Hf1m/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyadSO9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65C2C4CEC6;
	Tue,  1 Oct 2024 16:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727799515;
	bh=8CYtzeuLs6CCIRD2fBZvkMPfTc4SmlBullhKTpkXAIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyadSO9PSycQp+6mA1O5shA068U3KckO5T0wizaXBNFdLSvBo1eeKZfTuwe0AsGKN
	 NPM9YOKd9LyY9CMk9/9RKnPMzlMbX3rI9jOBYvbE6UBCZfuH2daVoz78fwiGzKWHrz
	 neHUM9dcbkOuNDc64y6zkeTcY430du4NCNoXuYE8x4iosCwj7z9oWm2+U7/QE4iSKB
	 vLdDtv2cwRyLVZCHp5+vfvop/jrLj9WLLh9gqD3gF7iBX1X242kU1qmZC4UCo57TnH
	 tc7claQZdOMZob8dl4Nv2+5A8zNi2AF7pAZsTQLTVcqedKQUKRD1neFqvfWy+IzZLC
	 O6NTFQA7tUkIA==
Date: Tue, 1 Oct 2024 17:18:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add the GE HealthCare PMC ADC
Message-ID: <20241001-corrode-preteen-546c98d45976@spud>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
 <20241001074618.350785-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WU91GRG2OkpcK9lH"
Content-Disposition: inline
In-Reply-To: <20241001074618.350785-3-herve.codina@bootlin.com>


--WU91GRG2OkpcK9lH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 09:46:16AM +0200, Herve Codina wrote:
> The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> (voltage and current), 16-Bit ADC with an I2C Interface.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/iio/adc/gehc,pmc-adc.yaml        | 82 +++++++++++++++++++
>  include/dt-bindings/iio/adc/gehc,pmc-adc.h    | 10 +++
>  2 files changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/gehc,pmc-ad=
c.yaml
>  create mode 100644 include/dt-bindings/iio/adc/gehc,pmc-adc.h
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml =
b/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
> new file mode 100644
> index 000000000000..6b2bb1309767
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/gehc,pmc-adc.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/gehc,pmc-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GE HealthCare PMC Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  The GE HealthCare PMC ADC is a 16-Channel (voltage and current), 16-Bi=
t ADC
> +  with an I2C Interface.
> +
> +properties:
> +  compatible:
> +    const: gehc,pmc-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the VDD power supply.
> +
> +  vdda-supply:
> +    description:
> +      Regulator for the VDD analog (VDDA) power supply.
> +
> +  vddio-supply:
> +    description:
> +      Regulator for the VDD IO (VDDIO) power supply.
> +
> +  vref-supply:
> +    description:
> +      Regulator for the voltage reference power supply.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: osc

Since there's no datasheet for me to look up, why is the clock optional?

> +
> +  "#io-channel-cells":
> +    const: 2
> +    description: |
> +      The first cell is the channel type (dt-bindings/iio/adc/gehc,pmc-a=
dc.h
> +      defines these values):
> +       - 0: voltage
> +       - 1: current
> +      The second cell is the channel number from 0 to 15.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vdda-supply
> +  - vddio-supply
> +  - vref-supply
> +  - '#io-channel-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@14 {
> +            compatible =3D "gehc,pmc-adc";
> +            reg =3D <0x14>;
> +            vdd-supply =3D <&reg_vdd>;
> +            vdda-supply =3D <&reg_vdda>;
> +            vddio-supply =3D <&reg_vddio>;
> +            vref-supply =3D <&reg_vref>;
> +            #io-channel-cells =3D <2>;
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/iio/adc/gehc,pmc-adc.h b/include/dt-bind=
ings/iio/adc/gehc,pmc-adc.h
> new file mode 100644
> index 000000000000..2f291e3c76ae
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/gehc,pmc-adc.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +
> +#ifndef _DT_BINDINGS_IIO_ADC_GEHC_PMC_ADC_H
> +#define _DT_BINDINGS_IIO_ADC_GEHC_PMC_ADC_H
> +
> +/* ADC channel type */
> +#define GEHC_PMC_ADC_VOLTAGE	0
> +#define GEHC_PMC_ADC_CURRENT	1
> +
> +#endif
> --=20
> 2.46.1
>=20

--WU91GRG2OkpcK9lH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvwg1gAKCRB4tDGHoIJi
0jPVAP4oToTpqpGn/77nFWojDllgTo0ty5NPLB3GfOchQgHa1QEAlZUZ3pXca1tt
n3jvx/zH1u4Neq9UNHyU6wh4BIFnyQE=
=3iSn
-----END PGP SIGNATURE-----

--WU91GRG2OkpcK9lH--

