Return-Path: <linux-iio+bounces-10945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601AE9AB4EE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABC92855E0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B551BC091;
	Tue, 22 Oct 2024 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMmzlyXd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5616EB7C;
	Tue, 22 Oct 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617762; cv=none; b=Q3lVR0i0omtE8RNmoyj/mNm7UzpOKpQgYuCTnoYSBXnTAzROZBBj92yj6ynhQZz6L45o2EsU9F2x3ynPiTeys468rZk8ARmkJVTnXIIO+aPgeHlZ3/6BNIffL4lw3v+BrUlT9KkLNCrFygme4WabEFORxL4E/foSauSoyB3JkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617762; c=relaxed/simple;
	bh=ky5NuXLBXkFS61V1YLSFtI5CbHssuX6MIidt+OAZbIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPgqi85YBsGxWXzs9V1OAbd6kmZqgf3qGMk436gR/BFpNi3SG8201wezDc+W4eCt4wTlHYSlwapfHjfV/3TbJCGqk0kHRWk7Wsy/S/YKHOcUjxQNPTilOYPNv8hxSEWn+XGfkqEasadFj2OxoF+W5L7o/stS5LepoxjztbYfssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMmzlyXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E3CC4CEC3;
	Tue, 22 Oct 2024 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729617761;
	bh=ky5NuXLBXkFS61V1YLSFtI5CbHssuX6MIidt+OAZbIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMmzlyXdm9iUN/REp1M4Dpv5ecgn3SASXlKaHDY/EplI6Qi5Du3D9wGeg5xgoC+RE
	 SK/J1+qthurVxghTypeRnfdVFDf7OBsYsdtxKdxqZsguQKbWVzn35jELh4Q6qtaeQG
	 TzhcXVtgf/u7/v/7lmPNTv2d4gLIgrF+hyswdA0PXW4YRnERrj4xKjd4Uc+1MCFpAn
	 MLHcAMhYZa3hqsgSI94hASWHEOdvNlxaEwNTBzLKbXcaKOd0laRkqIacIFrvjhJrnW
	 3aAIVFWt0Np8LlVLW8noxSYNTK3W45DGW73C6yer6B1eHTtDX0aeYhlP2i+z6RQCUf
	 GySMU4HsWFcIQ==
Date: Tue, 22 Oct 2024 18:22:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <20241022-flagpole-subject-51e68e81e948@spud>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-2-969694f53c5d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MJ8JfCsAMbIqFwFl"
Content-Disposition: inline
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-2-969694f53c5d@baylibre.com>


--MJ8JfCsAMbIqFwFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 02:40:12PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add a new compatible and related bindigns for the fpga-based
> "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
>=20
> The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> mainly to reach high speed transfer rates using a QSPI DDR
> (dobule-data-rate) interface.
>=20
> The ad3552r device is defined as a child of the AXI DAC, that in
> this case is acting as an SPI controller.
>=20
> Note, #io-backend is present because it is possible (in theory anyway)
> to use a separate controller for the control path than that used
> for the datapath.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 69 ++++++++++++++++=
+++++-
>  1 file changed, 66 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> index a55e9bfc66d7..0aabb210f26d 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> @@ -19,11 +19,13 @@ description: |
>    memory via DMA into the DAC.
> =20
>    https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> +  https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> =20
>  properties:
>    compatible:
>      enum:
>        - adi,axi-dac-9.1.b
> +      - adi,axi-ad3552r
> =20
>    reg:
>      maxItems: 1
> @@ -36,7 +38,12 @@ properties:
>        - const: tx
> =20
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> =20
>    '#io-backend-cells':
>      const: 0
> @@ -47,7 +54,31 @@ required:
>    - reg
>    - clocks
> =20
> -additionalProperties: false
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,axi-ad3552r
> +    then:
> +      $ref: /schemas/spi/spi-controller.yaml#
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2

Is this maxItems required? It matches the outer maximum.

> +        clock-names:
> +          items:
> +            - const: s_axi_aclk
> +            - const: dac_clk

The names are the same in both cases, you can move the definitions
outside of the if/then/else stuff and only constrain it here.

> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: s_axi_aclk
> +
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> @@ -57,6 +88,38 @@ examples:
>          dmas =3D <&tx_dma 0>;
>          dma-names =3D "tx";
>          #io-backend-cells =3D <0>;
> -        clocks =3D <&axi_clk>;
> +        clocks =3D <&clkc 15>;
> +        clock-names =3D "s_axi_aclk";
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    axi_dac: spi@44a70000 {
> +        compatible =3D "adi,axi-ad3552r";
> +        reg =3D <0x44a70000 0x1000>;
> +        dmas =3D <&dac_tx_dma 0>;
> +        dma-names =3D "tx";
> +        #io-backend-cells =3D <0>;
> +        clocks =3D <&clkc 15>, <&ref_clk>;
> +        clock-names =3D "s_axi_aclk", "dac_clk";
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@0 {
> +            compatible =3D "adi,ad3552r";
> +            reg =3D <0>;
> +            reset-gpios =3D <&gpio0 92 GPIO_ACTIVE_HIGH>;
> +            io-backends =3D <&axi_dac>;
> +            spi-max-frequency =3D <20000000>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                adi,output-range-microvolt =3D <(-10000000) (10000000)>;
> +            };
> +        };
>      };
>  ...
>=20
> --=20
> 2.45.0.rc1
>=20

--MJ8JfCsAMbIqFwFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxffXAAKCRB4tDGHoIJi
0lYXAP4qWF+5usb9GM3yIpXbgIa/+PcPuM+Vd2kfP4v63wVL2AD/euPMQtDB2L6T
WN/LfMdAMctnoR3zuwSeR+V/TzGrgAs=
=kwA/
-----END PGP SIGNATURE-----

--MJ8JfCsAMbIqFwFl--

