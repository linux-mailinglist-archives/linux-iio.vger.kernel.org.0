Return-Path: <linux-iio+bounces-9518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034E5978643
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 18:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB7F1C22E04
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473380BFC;
	Fri, 13 Sep 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiEni0i7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE4811F1;
	Fri, 13 Sep 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246510; cv=none; b=RnXXwNJ9DRnjoDug6OIuDTacUOQJpFqwPyvkpfpESAtZ7KeWLALdnXg8bZfT/XInTkvwjdNszPT1pwHQpaaPKH3gxQMLAy6Kh6pjVEKq58nwKlYzb1w5B/Odr+SkuW6+iTKvxle/GKAb0rqcD9O4XaNA/4gqPnsOo+i7F8bQamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246510; c=relaxed/simple;
	bh=uKhpgO4U1LU2Qn0MR9AEWzNBPZVEpvrphvFSVZ5WChc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8SR7Km5ijW0bwGtKcMEf4GXgdbneye1BBOg0DU+z2CM2m9yXLCCYeuchQNtevvmxtIJkgyRfIGlTkn+D4PEuWRBkMR3vK6+Fe9GI418GY3qmiKUN9UyDHLnEaJwq0lGeuUr5Jfl1nOIy9SCzZUi5/ATiiX5Ps2cMKFPGbEnKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiEni0i7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E9FC4CEC0;
	Fri, 13 Sep 2024 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726246510;
	bh=uKhpgO4U1LU2Qn0MR9AEWzNBPZVEpvrphvFSVZ5WChc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uiEni0i71hRGogUzI6V8cTtiNOTxq9X3jgPJ+ZIemrJap1W1mv2C0TaAak+x79epJ
	 zVbhmNJy2W+fe/3ERrq/Zah3bQGryKibjykKng7OQ9scyf41C+2I4cLcHL0brB4IYK
	 J5x02OU06yI2zdE1K5UxRQ3EFmTrBIoV2T/46eiVOD58TQhxelONiEcCZ9NGaZuOEa
	 lzLaoWIcJ9zjeT5/VYZBWhFhBjnkUSmrc/0j/AFklzsA6zjzrDWFcMsxtQchCmMG8b
	 xr7KgcqT8G+8/O7gAVmEgg5pARf5NygSJVTBZ0OO88gok8nrmmXuP45QZIOChHBVMp
	 wtkouJ4pfV4rg==
Date: Fri, 13 Sep 2024 17:55:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/7] dt-bindings: iio: light: veml6030: add veml6035
Message-ID: <20240913-triceps-impure-bc97dd2b432a@spud>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
 <20240913-veml6035-v1-2-0b09c0c90418@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CPwJ6ZTIqbb0u5rU"
Content-Disposition: inline
In-Reply-To: <20240913-veml6035-v1-2-0b09c0c90418@gmail.com>


--CPwJ6ZTIqbb0u5rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 03:18:57PM +0200, Javier Carrasco wrote:
> The veml6035 is a similar ambient light sensor to the veml6030, and
> from the bindings point of view, it shares the same properties. Its
> only difference in that respect is a different I2C address.
>=20
> Estend the existing bindings to support the veml6035 ALS.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../bindings/iio/light/vishay,veml6030.yaml        | 40 ++++++++++++++++=
+-----
>  1 file changed, 31 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.=
yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> index 7f4995557570..f88e043d7ede 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> @@ -4,14 +4,14 @@
>  $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: VEML6030 Ambient Light Sensor (ALS)
> +title: VEML6030 and VEML6035 Ambient Light Sensors (ALS)
> =20
>  maintainers:
>    - Rishi Gupta <gupt21@gmail.com>
> =20
>  description: |
> -  Bindings for the ambient light sensor veml6030 from Vishay
> -  Semiconductors over an i2c interface.
> +  Bindings for the ambient light sensors veml6030 and veml6035 from
> +  Vishay Semiconductors over an i2c interface.
> =20
>    Irrespective of whether interrupt is used or not, application
>    can get the ALS and White channel reading from IIO raw interface.
> @@ -19,20 +19,18 @@ description: |
>    If the interrupts are used, application will receive an IIO event
>    whenever configured threshold is crossed.
> =20
> -  Specifications about the sensor can be found at:
> +  Specifications about the sensors can be found at:
>      https://www.vishay.com/docs/84366/veml6030.pdf
> +    https://www.vishay.com/docs/84889/veml6035.pdf
> =20
>  properties:
>    compatible:
>      enum:
>        - vishay,veml6030
> +      - vishay,veml6035
> =20
>    reg:
> -    description:
> -      I2C address of the device.
> -    enum:
> -      - 0x10 # ADDR pin pulled down
> -      - 0x48 # ADDR pin pulled up
> +    maxItems: 1
> =20
>    interrupts:
>      description:
> @@ -45,6 +43,30 @@ required:
>    - compatible
>    - reg
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - vishay,veml6030
> +    then:
> +      properties:
> +        reg:
> +          enum:
> +            - 0x10  # ADDR pin pulled down
> +            - 0x48  # ADDR pin pulled up

Ordinarily, I'd say that enforcing the reg properties isn't really
needed, but I think in this case the extra detail in the comments makes
it worth retaining.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - vishay,veml6035
> +    then:
> +      properties:
> +        reg:
> +          enum:
> +            - 0x29
> +
>  additionalProperties: false
> =20
>  examples:
>=20
> --=20
> 2.43.0
>=20

--CPwJ6ZTIqbb0u5rU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuRuaQAKCRB4tDGHoIJi
0mT3AP9M4mogwv8GmIRVMbmdkIzKy/0MA8oc05awjjdvrwB+ugEAiXtE0nHvFtRS
TcMVHXhav8HI1r48GUMgWvJFmnN62Qk=
=Fre/
-----END PGP SIGNATURE-----

--CPwJ6ZTIqbb0u5rU--

