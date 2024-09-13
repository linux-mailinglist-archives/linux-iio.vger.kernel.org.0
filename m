Return-Path: <linux-iio+bounces-9522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D8D9787D0
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 20:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A511F25FFD
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 18:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AA712C474;
	Fri, 13 Sep 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLI6O7yj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF28C11;
	Fri, 13 Sep 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252055; cv=none; b=LM/PHzMBawpCdlmdYMxN1c6iHmElMWKVL24667/Ei2paY/r6U8LJ+4nxOjRHcwZvnZ9twApPv9oqGJAhzdUgrD91toGdSF12bZai3ykVm1T5KcYjQUO0MdMF/coLM4EPAtEW3DvEc5zyJA2zLDch9rS/3IdA/v7GDvahm7iCtpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252055; c=relaxed/simple;
	bh=lw0eK6fflWLo8L9Xc6oEj9NPbarXvrNywgJhseEI1to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g94UpfFZd0G+1WmuGq9HOuLDl1pEdU/u0ELyPVuk/exTobo7DuAtXKxDOM/kmCD5dTcyAWwSr1BeJvzOOtmkpQ5yxnykuxQ1PYmH3jTIn4/tR3FdMgn63TUWKLllbC/AVbWRmoY8mD+jtA5LBrY9OYmczRizh/AIXmSivP5WYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLI6O7yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4ACC4CEC7;
	Fri, 13 Sep 2024 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726252055;
	bh=lw0eK6fflWLo8L9Xc6oEj9NPbarXvrNywgJhseEI1to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLI6O7yjFdju5S0/44XPZp2MQYIvN2HPbxq0F7Y91MPyxs54GtyJnn01HhMHWIMO9
	 IXdzSj9MppdtB2VRQif816nHhSVsSit2ZvaC6dJj1oZrlBFUFQZ7Y7pTtO+27RUXIR
	 4FzLz2nUKVLNjOdtmyBXMXQWLfXAJqhEkUWjO3JnspWY5xKjo+Ey8AkdOzbB8u1ToW
	 vzCc4ztMYHVCIQfJmDoTgauCs5VPcLMd5/8S0DqDXIqdkl8F/szMLQEBwaWUo8Yql2
	 Wnwo79mdtdwoG+Y0n/Jbxi4Yz0Q9uh7ytO2dbP9Ox8W5WdxnRu8RdCXYhDNUGW1Wpn
	 Ppqw66NUmN/yQ==
Date: Fri, 13 Sep 2024 19:27:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v6 2/4] dt-bindings: iio: pressure: bmp085: Add
 interrupts for BMP3xx and BMP5xx devices
Message-ID: <20240913-overarch-preplan-c899f16a90c8@spud>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
 <20240912233234.45519-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yklktLtRTBY9hG1i"
Content-Disposition: inline
In-Reply-To: <20240912233234.45519-3-vassilisamir@gmail.com>


--yklktLtRTBY9hG1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 01:32:32AM +0200, Vasileios Amoiridis wrote:
> Add interrupt options for BMP3xx and BMP5xx devices as well.
>=20
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  .../bindings/iio/pressure/bmp085.yaml         | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b=
/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> index 6fda887ee9d4..7c9d85be9008 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> @@ -48,14 +48,34 @@ properties:
> =20
>    interrupts:
>      description:
> -      interrupt mapping for IRQ (BMP085 only)
> +      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx

If you respin, you can drop the description entirely, since you've added
proper enforcement below.

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>      maxItems: 1
> =20
> +  drive-open-drain:
> +    description:
> +      set if the interrupt pin should be configured as open drain.
> +      If not set, defaults to push-pull configuration.
> +    type: boolean
> +
>  required:
>    - compatible
>    - vddd-supply
>    - vdda-supply
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - bosch,bmp085
> +                - bosch,bmp380
> +                - bosch,bmp580
> +    then:
> +      properties:
> +        interrupts: false
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.25.1
>=20

--yklktLtRTBY9hG1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuSEEQAKCRB4tDGHoIJi
0ug0AQDv9jtxn90k9XFvocbM+CoDnehphvbc+3ADMDwVjaf1rgEA1SL5+udw2VPe
exH1SqZqbO4XEmb+Nl+bljSO0kWQ+gg=
=ett3
-----END PGP SIGNATURE-----

--yklktLtRTBY9hG1i--

