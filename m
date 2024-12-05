Return-Path: <linux-iio+bounces-13127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B3A9E5DBA
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56A428541D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412122B8A3;
	Thu,  5 Dec 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4m4lqei"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB30226EEF;
	Thu,  5 Dec 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421241; cv=none; b=YZHtW/XEUsfUZYjCKk+HcOEna/lrUOASOCWmYpWj7EOzI80dR7NNaI4pk1zrH09qxaiLGU02xon2Nl+963zwUJU0sEJOlU+HpJPvr0oWFDJQwcpW+DJHQvBeBEyDpqnpS6rZW/sqYh31CsVb0KqLjzIDrR5QV1i/HLYLDtsO0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421241; c=relaxed/simple;
	bh=YPSxGZSaXFm4i6tytW5Jpx+fpeUcxowZd2a2TmtvO4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDz7MjTlCabHHi8fPpZUM3H38q8NlwjtqpgHXLbXvXxaKN5zE72A58MqByrPBlMGpQXksNh6uxkDTvkgAsjfl1mH9tv3R45hMm8jjquAh5w8ngWZeiZeOavLzrGD1i3lL1wC15dolskXSyFehlNPdAtgXmScybh7COhJN/LiCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4m4lqei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24310C4CED1;
	Thu,  5 Dec 2024 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733421241;
	bh=YPSxGZSaXFm4i6tytW5Jpx+fpeUcxowZd2a2TmtvO4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4m4lqeiZchL3C7WOSSk87re53fXBIrGsGOdC0b3hkJszEe71FYGAzEzesdfcpNrB
	 hs63b4BqqSJRHfaengn+zmQuZzOyXADBLk5aIKo0OwK6FIziqFFXh80rEMHUrN+vzF
	 pasPsTZ8WRwlCah+kExA3vlGtFWziz1BspFOaWc+ZCcO0R67B5SJNs+GGTUL/ugQd/
	 YGpTPiQISeXVy2W9+XLY/0km0PLV3tJyYFEv09hAn84h50ib2AMMhMDr4SCT7gn4LH
	 NtzWGXeSFDs/fT03b1afyDTMBIcF3mkqBo57waDMyBAhTPiazJOVWphsrTZytY+CUW
	 2xDjfBtOOC9eQ==
Date: Thu, 5 Dec 2024 17:53:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v5 06/10] dt-bindings: iio: accel: add interrupt-names
Message-ID: <20241205-fraying-overfull-4fe3eb6c5376@spud>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
 <20241205171343.308963-7-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7FVAxa4gn8urbTFj"
Content-Disposition: inline
In-Reply-To: <20241205171343.308963-7-l.rubusch@gmail.com>


--7FVAxa4gn8urbTFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 05:13:39PM +0000, Lothar Rubusch wrote:
> Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> sensor. Only one line will be connected for incoming events. The driver
> needs to be configured accordingly. If no interrupt line is set up, the
> sensor will still measure, but no events are possible.
>=20
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl345.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml=
 b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index 280ed479ef5..67e2c029a6c 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -37,6 +37,11 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  interrupt-names:
> +    description: Use either INT1 or INT2 for events, or ignore events.
> +    items:
> +      - enum: [INT1, INT2]

The description for this ", or ignore events" does not make sense. Just
drop it, it's clear what happens if you don't provide interrupts.

However, interrupts is a required property but interrupt-names is not.
Seems rather pointless not making interrupt-names a required property
(in the binding!) since if you only add interrupts and not
interrupt-names you can't even use the interrupt as you do not know
whether or not it is INT1 or INT2?

> +
>  required:
>    - compatible
>    - reg
> @@ -61,6 +66,7 @@ examples:
>              reg =3D <0x2a>;
>              interrupt-parent =3D <&gpio0>;
>              interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names =3D "INT1";
>          };
>      };
>    - |
> @@ -79,5 +85,6 @@ examples:
>              spi-cpha;
>              interrupt-parent =3D <&gpio0>;
>              interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names =3D "INT2";
>          };
>      };
> --=20
> 2.39.2
>=20

--7FVAxa4gn8urbTFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1HotAAKCRB4tDGHoIJi
0lAXAP4/wz5aqiHLtqp74DS+pYek3HB9cjtPHE7AGGkjFTRpkQD9FBXfnA/7Ij5v
2agh6kxZiI8orLosGMcY0VLAiyKjigM=
=9acU
-----END PGP SIGNATURE-----

--7FVAxa4gn8urbTFj--

