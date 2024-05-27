Return-Path: <linux-iio+bounces-5362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C77D8D0986
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 19:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4967C1C219B3
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763D15F321;
	Mon, 27 May 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="angG1vvB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747915EFCC;
	Mon, 27 May 2024 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832120; cv=none; b=ViZDxVGy81K/ws4RZ9LgeGRsxxXLdwP7JZUUUMVr+rELqIJjnIcKDdJzuaUXiII8hP9Tv5VWso9D6qWhmuI5pZNdfQMXerzrnfpNup500H3CINgl6hBgOkJYZFXHGGpoYfCMYR5Bs0wgNQNd8LXTUzXsSF1CDXsrVldJzHJ6KtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832120; c=relaxed/simple;
	bh=Osjj8NjnFAIZU2NVPkIF21tWTVtBoakiM3p/XGDg+2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP4KpU7l8NXXGA3mwZP4bKXeDt7eN2vkuANOcU59Ie9IIVlaSFod5Q6K6Wbp6xH7MJqdC6EkEE6gVkZ6UIVGJVa5TN9Cz8IbCjz/WENHsIB/MW1npbkTu/Z/v1klUh/VCOh3gJlan+Du6TpplShcR18RJ4XHeST6BsGVSme6G+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=angG1vvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF0CC2BBFC;
	Mon, 27 May 2024 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716832119;
	bh=Osjj8NjnFAIZU2NVPkIF21tWTVtBoakiM3p/XGDg+2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=angG1vvBB/tISqrSMgWTWIbf561kOmcQ+2YRLZ8hOmXgWKdyKc5jrn1KxIkn3xgUA
	 7ItUxqSGbJYMhWd5AgC3lhXZnxaoywxAtQx78m8WtWT46ovOLXI2klMAr8KLT8qc6w
	 JRr93tFRa2CAO5P+UpYPpKkUGGdSP3WEdvL0sEqICVwRyfkUb3vyRs5GtCCwr5gOTg
	 wSdmgtC/a5Gw14NtE0Pjm9elV1LCik59I5TIinkEcbLlPIvTyz+9TlRhEfQ9CruP7J
	 20a03DPvhHLMeUbrNql+prYlpgisTVDJyYRTqYvscOcawZEG9zTw5058jci6aPpyg8
	 9/hI9lo1QUdew==
Date: Mon, 27 May 2024 18:48:35 +0100
From: Conor Dooley <conor@kernel.org>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240527-arguably-said-361184ad848e@spud>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4cO0smBLoF4dPAzc"
Content-Disposition: inline
In-Reply-To: <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>


--4cO0smBLoF4dPAzc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 08:02:34PM +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
>=20
> AD411x family ADCs support a VCOM pin, dedicated for single-ended usage.
> AD4111/AD4112 support current channels, usage is implemented by
>  specifying channel reg values bigger than 15.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 122 +++++++++++++++=
+++++-
>  1 file changed, 120 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> index ea6cfcd0aff4..5b1af382dad3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -19,7 +19,18 @@ description: |
>    primarily for measurement of signals close to DC but also delivers
>    outstanding performance with input bandwidths out to ~10kHz.
> =20
> +  Analog Devices AD411x ADC's:
> +  The AD411X family encompasses a series of low power, low noise, 24-bit,
> +  sigma-delta analog-to-digital converters that offer a versatile range =
of
> +  specifications. They integrate an analog front end suitable for proces=
sing
> +  fully differential/single-ended and bipolar voltage inputs.
> +
>    Datasheets for supported chips:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4111.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4112.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4114.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4115.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4116.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-4.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
> @@ -31,6 +42,11 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - adi,ad4111
> +      - adi,ad4112
> +      - adi,ad4114
> +      - adi,ad4115
> +      - adi,ad4116
>        - adi,ad7172-2
>        - adi,ad7172-4
>        - adi,ad7173-8
> @@ -129,10 +145,36 @@ patternProperties:
>          maximum: 15
> =20
>        diff-channels:
> +        description: |
> +          For using current channels specify select the current inputs
> +           and enable the adi,current-channel property.
> +
> +          Family AD411x supports a dedicated VINCOM voltage input.
> +          To select it set the second channel to 16.
> +            (VIN2, VINCOM) -> diff-channels =3D <2 16>
> +
> +          There are special values that can be selected besides the volt=
age
> +          analog inputs:
> +            21: REF+
> +            22: REF=E2=88=92
> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD71=
77-2:
> +            19: ((AVDD1 =E2=88=92 AVSS)/5)+
> +            20: ((AVDD1 =E2=88=92 AVSS)/5)=E2=88=92
> +
>          items:
>            minimum: 0
>            maximum: 31
> =20
> +      single-channel:
> +        description: |
> +          Models AD4111 and AD4112 support single-ended current channels.
> +          To select the desired current input, specify the desired input=
 pair:
> +            (IIN2+, IIN2=E2=88=92) -> single-channel =3D <2>
> +
> +        items:
> +          minimum: 1
> +          maximum: 16
> +
>        adi,reference-select:
>          description: |
>            Select the reference source to use when converting on
> @@ -154,9 +196,26 @@ patternProperties:
>            - avdd
>          default: refout-avss
> =20
> +      adi,current-channel:
> +        description: |
> +          Signal that the selected inputs are current channels.
> +          Only available on AD4111 and AD4112.
> +        type: boolean
> +
> +      adi,channel-type:
> +        description:
> +          Used to differentiate between different channel types as the d=
evice
> +           register configurations are the same for all usage types.
> +          Both pseudo-differential and single-ended channels will use the
> +           single-ended specifier.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - single-ended
> +          - differential
> +        default: differential

I dunno if my brain just ain't workin' right today, or if this is not
sufficiently explained, but why is this property needed? You've got
diff-channels and single-channels already, why can you not infer the
information you need from them? What should software do with this
information?
Additionally, "pseudo-differential" is not explained in this binding.

Also, what does "the device register configurations are the same for
all uses types" mean? The description here implies that you'd be reading
the registers to determine the configuration, but as far as I understand
it's the job of drivers to actually configure devices.
The only way I could interpret this that makes sense to me is that you're
trying to say that the device doesn't have registers that allow you to
do runtime configuration detection - but that's the norm and I would not
call it out here.

Thanks,
Conor.

--4cO0smBLoF4dPAzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlTHcwAKCRB4tDGHoIJi
0kRjAPsG84+KDR7s4y1gNjTV2xf5bXRkzPtrvnplSviQITN4QgD/XKQvmuVdBUba
oKS3NOU3/HdgiortQmm/UlCPF14I/ww=
=NQX0
-----END PGP SIGNATURE-----

--4cO0smBLoF4dPAzc--

