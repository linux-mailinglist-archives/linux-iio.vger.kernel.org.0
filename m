Return-Path: <linux-iio+bounces-24302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0912B8AC96
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 19:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A00B4E52C7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C132253E;
	Fri, 19 Sep 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9b2GGM4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A677221D9E;
	Fri, 19 Sep 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303378; cv=none; b=Zay5oY/f1n7E3/D4AU/xdBZDlFE+jfQEvBvQe0x2FmsNbS6nT53LCwxNjo+0eeGYsZv+YnNJBnaqgsj589NlIV5+ijiyXYkSJXJc00olrDPLQCATAPIGP3HWbyYQV5hsf3kl5eVYNq1HmTGPxtLhsswwGXeFDdf41CTJbcrabaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303378; c=relaxed/simple;
	bh=FO8wvkYRv7nTrTXR9Ddx+akxFWDQBaEu2zw/QHN4Eig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geqQ1salMKRE8wRhW/AB1Iv2gA/8xgwgCKpXdAwgMb620Bsq4Mu+94m1HRvbgmy/X/DVFhKRWvB4cJ0/V1Ex/AIQGTpcmY/8vXxeQ6v5f8ji8dymcFYiObulVlXaP9wSkVv3sYerw4C16U9pJ635NCxafExngVG5Yew8DfvmBks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9b2GGM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB856C4CEF0;
	Fri, 19 Sep 2025 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758303377;
	bh=FO8wvkYRv7nTrTXR9Ddx+akxFWDQBaEu2zw/QHN4Eig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9b2GGM4BBa0/x3g/XtG1YIUP+CeVPucx8Qfy3FwTFRmhFnRmwz6Wl/QJ5YORseMx
	 qelTD0GuduCyavwvmetPKa3QwdVVS2xi1MghAUJzTgwaO7brdHC+UMahzQJwk+RuYV
	 eXtunFtPYHy0VuqpaoV0S1fZE2Iy7p7dPvrUyoPk1jyNVAMAzghFDuhgZPqjdXtxAK
	 NE786ikXrx9DuPqAfgiQIgoZmntWjG9IfmvEMo1JWranEqgKkps+hihg2D37kSP5us
	 LqhqV4zv5K7YmMTYlOEQJo/ri0gIC4qidxHjBbYuw8dhSfoVELf0HGuwOqiOdRI2bl
	 T5V4EkvmEghkA==
Date: Fri, 19 Sep 2025 18:36:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20250919-unsure-mounted-0fc49ce72216@spud>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <2d6bca62056e1254f91b45f70f4ba4614e659c1c.1758214628.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oNeuq5bm6kVKK+yF"
Content-Disposition: inline
In-Reply-To: <2d6bca62056e1254f91b45f70f4ba4614e659c1c.1758214628.git.marcelo.schmitt@analog.com>


--oNeuq5bm6kVKK+yF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 02:39:29PM -0300, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have=
 a
> PGA (programmable gain amplifier) that scales the input signal prior to it
> reaching the ADC inputs. The PGA is controlled through a couple of pins (=
A0
> and A1) that set one of four possible signal gain configurations.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v1 -> v2
> - Use pattern to specify devices that require gain related properties.
> - Disallow gain related properties for devices that don't come with embed=
ded PGA.
> - Documented VDDH and VDD_FDA supplies for ADAQ4216 and ADAQ4224.
> - Updated PGA gain constants.
>=20
>  .../bindings/iio/adc/adi,ad4030.yaml          | 65 +++++++++++++++++--
>  1 file changed, 60 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index 564b6f67a96e..bd43c617ae11 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -19,6 +19,8 @@ description: |
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4030-24-4032-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4630-24_ad4632-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4630-16-4632-16.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4216.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4224.pdf
> =20
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
> =20
> @@ -31,6 +33,8 @@ properties:
>        - adi,ad4630-24
>        - adi,ad4632-16
>        - adi,ad4632-24
> +      - adi,adaq4216
> +      - adi,adaq4224
> =20
>    reg:
>      maxItems: 1
> @@ -54,6 +58,14 @@ properties:
>      description:
>        Internal buffered Reference. Used when ref-supply is not connected.
> =20
> +  vddh-supply:
> +    description:
> +      PGIA Positive Power Supply.
> +
> +  vdd-fda-supply:
> +    description:
> +      FDA Positive Power Supply.
> +
>    cnv-gpios:
>      description:
>        The Convert Input (CNV). It initiates the sampling conversions.
> @@ -64,6 +76,27 @@ properties:
>        The Reset Input (/RST). Used for asynchronous device reset.
>      maxItems: 1
> =20
> +  pga-gpios:
> +    description:
> +      A0 and A1 pins for gain selection. For devices that have PGA confi=
guration
> +      input pins, pga-gpios should be defined if adi,gain-milli is absen=
t.
> +    minItems: 2
> +    maxItems: 2
> +
> +  adi,pga-value:
> +    $ref: /schemas/types.yaml#/definitions/uint32

How come this is "value" rather than "gain"?

> +    description: |
> +      Should be present if PGA control inputs are pin-strapped. The valu=
es
> +      specify the gain per mille. For example, 333 means the input signa=
l is
> +      scaled by a 0.333 factor (i.e. attenuated to one third of it's ori=
ginal
> +      magnitude). Possible values:
> +      Gain 333 (A1=3D0, A0=3D0)
> +      Gain 555 (A1=3D0, A0=3D1)
> +      Gain 2222 (A1=3D1, A0=3D0)
> +      Gain 6666 (A1=3D1, A0=3D1)
> +      If defined, pga-gpios must be absent.
> +    enum: [333, 555, 2222, 6666]
> +
>    pwms:
>      description: PWM signal connected to the CNV pin.
>      maxItems: 1
> @@ -86,11 +119,33 @@ required:
>    - vio-supply
>    - cnv-gpios
> =20
> -oneOf:
> -  - required:
> -      - ref-supply
> -  - required:
> -      - refin-supply
> +allOf:
> +  - oneOf:
> +      - required:
> +          - ref-supply
> +      - required:
> +          - refin-supply
> +  # ADAQ devices require a gain property to indicate how hardware PGA is=
 set
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            pattern: ^adi,adaq
> +    then:
> +      allOf:
> +        - required: [vddh-supply, vdd-fda-supply]
> +          properties:
> +            ref-supply: false
> +        - oneOf:
> +            - required:
> +                - adi,pga-value
> +            - required:
> +                - pga-gpios
> +    else:
> +      properties:
> +        adi,pga-value: false
> +        pga-gpios: false
> +
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.50.1
>=20

--oNeuq5bm6kVKK+yF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2UjAAKCRB4tDGHoIJi
0maCAP0X6Ycu32Zx57iHv8gynnTTCR4gcKXh1z3OmUDvmRhhQQD/YdUYZ66mR9YO
d/7UA6JvzjYg4YpAD5hSfGZMuA3wrwc=
=UgDm
-----END PGP SIGNATURE-----

--oNeuq5bm6kVKK+yF--

