Return-Path: <linux-iio+bounces-18941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13672AA6039
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777DE1748F8
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5AE1F8AD3;
	Thu,  1 May 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bElToQK7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B0C198E6F;
	Thu,  1 May 2025 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111103; cv=none; b=sw/ngOY9SgRByRYsm+CZg8NdquXEx8HDykAF7Ix35Ojvom9sgBjm3euT9rV5CrteExXeR5O37jnmzA/7CZPHJLXtw2mFSc7VzuJYH/cNzIwxMYl57lM3MYwt1lr/7uZ3UeHDbNPyNpK8g4+t59uhi9KrOkFMw6KlawNVHx40TeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111103; c=relaxed/simple;
	bh=wdjmd1246JboK3lbng6YEeoL6Zhji4MPN6fOxhiJpdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPjxoajVywGq2nZ+p/VdoSsYixa+HwVuEAptcBZ/jNtat7EI2OEMpsCG3G6brtiRtFZ8ZU2KDd6ZPq3qdxGuM9ao2ztMVAjPCdOQHHLWKdBLd08563WOyH3Xw+YrscwiS/kvrAYMy2kromhzQUPQo9zVyHZwSMr1cobV6GW9jG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bElToQK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165E7C4CEED;
	Thu,  1 May 2025 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746111103;
	bh=wdjmd1246JboK3lbng6YEeoL6Zhji4MPN6fOxhiJpdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bElToQK7w+6nx2mjMzHZ1uPtFSEXuTctwMZpLLhMeeOV/VYTwgnbx9bHHJ4faKYGg
	 AjKJpDYz71VP+m2LLTbUClNzwYzz1iUqD56BJiT9HPE+O5YENSfY2bhTT3VfbLuuHv
	 ljDSf3MYYjO4RmomsHmcYreMwPD58KlX8R8SU+twUekKefPPM3PnbPwNb/5OyneW5X
	 M12BOSI2xPPnteqTVBGhwGjaZOWMU1JqdhBzvAcAFUe/BQOqJwZEGuK8k87jc9cQJ2
	 B3OvsOYi8pjxHNT9Gbp3jE3sEpBsW6muo/bBHZlSTWixxObZBDmw8GvmP66Ss+UKG2
	 nbwUoN2n+CuUQ==
Date: Thu, 1 May 2025 15:51:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Sayyad Abid <sayyad.abid16@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, olivier.moysan@foss.st.com,
	gstols@baylibre.com, tgamblin@baylibre.com, alisadariana@gmail.com,
	eblanc@baylibre.com, antoniu.miclaus@analog.com,
	andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
	ramona.gradinariu@analog.com, herve.codina@bootlin.com,
	tobias.sperling@softing.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] dt-bindings: iio: adc: add bindings for TI
 ADS1262
Message-ID: <20250501-nervous-agreed-73b4b63c82e0@spud>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
 <20250501100043.325423-6-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="62IET8pWxsXuL1RR"
Content-Disposition: inline
In-Reply-To: <20250501100043.325423-6-sayyad.abid16@gmail.com>


--62IET8pWxsXuL1RR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 03:30:43PM +0530, Sayyad Abid wrote:

> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1262

How different is the ads1263? Do we get support for both "for free"?

> +  spi-cpha:
> +    type: boolean
> +    description: Required for SPI mode 1 operation

This should just collapse to "spi-cpha: true", cos the definition of it
comes from spi-peripheral-props.yaml.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for the reset pin (active low)
> +
> +  vref-supply:
> +    description: |
> +      The regulator supply for ADC reference voltage. If not specified,
> +      the internal 2.5V reference will be used.

I looked this device up, I don't see an input pin called "vref" and
there appear to be multiple reference inputs. All supplies should be
documented.

> +      ti,gain:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 5
> +        description: |
> +          PGA gain setting. Not applicable for temperature sensor (chann=
el 11).
> +          0: 1 (default)
> +          1: 2
> +          2: 4
> +          3: 8
> +          4: 16
> +          5: 32

Why can't the gain be in it's actual unit, rather than what I am
guessing is a register value?

> +  ti,data-rate:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 15
> +    description: |
> +      Data acquisition rate in samples per second
> +      0: 2.5
> +      1: 5
> +      2: 10
> +      3: 16.6
> +      4: 20
> +      5: 50
> +      6: 60
> +      7: 100
> +      8: 400
> +      9: 1200
> +      10: 2400
> +      11: 4800
> +      12: 7200
> +      13: 14400
> +      14: 19200
> +      15: 38400

Same applies here really, except that the fractional per second rate
would only work if the base unit was samples-per-<something sub second>,
which might or might not be worth it.

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      ads1262: adc@0 {

The label here is unused AFAICT and should be dropped.

Cheers,
Conor.

> +        compatible =3D "ti,ads1262";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <7372800>;
> +        vref-supply =3D <&adc_vref>;
> +        spi-cpha;
> +        reset-gpios =3D <&gpio1 16 GPIO_ACTIVE_LOW>;
> +        ti,pga-bypass;
> +        ti,data-rate =3D <15>; /* 38400 SPS */
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        #io-channel-cells =3D <1>;
> +
> +        /* Single-ended channel */
> +        channel@0 {
> +          reg =3D <0>;
> +        };
> +
> +        /* Differential channel */
> +        channel@1 {
> +          reg =3D <1>;
> +          diff-channels =3D <1 2>;
> +          ti,gain =3D <2>; /* Gain of 4 */
> +        };
> +
> +        /* Temperature sensor */
> +        channel@11 {
> +          reg =3D <11>;
> +        };
> +      };
> +    };
> +...
> --=20
> 2.39.5
>=20

--62IET8pWxsXuL1RR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBOKeAAKCRB4tDGHoIJi
0iDXAQDMeJzpK7bqks7PXJSILFx1HYJxR0frq2wqV/4eAZzXHwD8DYzj4Zw2QiD9
uGzl1vxYuhW4ijM+iUCVHnGoSy9wkgg=
=JpzC
-----END PGP SIGNATURE-----

--62IET8pWxsXuL1RR--

