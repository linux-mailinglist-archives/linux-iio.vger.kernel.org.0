Return-Path: <linux-iio+bounces-15082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62098A2B0F6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 19:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C977A3847
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD71A0BC5;
	Thu,  6 Feb 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnvkdD6w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFBD19CC05;
	Thu,  6 Feb 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866059; cv=none; b=D4Fn2BjPLYeS5duArDf5s3PwWAyPvEK+DwQJnAd3ydKrbLOQfVowVSnOdINOxPHXvHi1LHGIdh0qrbKuABhqQP/exbsqNmGpE3WTAd+QrkuQ0FobEzJFUCU2JW7Q1oAvf3eDxaTrcdng/oMqldLyycXcVDUiPjQxGKSK0BAIMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866059; c=relaxed/simple;
	bh=j6HGYyGPwE2tuf0qT9ePG+naFb8GANLvOkDxNv/9coI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLeku0V2xMYCKvDGzPNBhJnL9b4KdF8wepGz8BI7+pPHqCk0yZhzpZBLT2xeNAktqelZAOjHhfx7zMrl+fKMOooZhZVj/FfuzJpy3KVSLGOBCE8yaf17kVYMeL+fXZmk3FZvwC2Dav0cTM7QJ5N5gcy3DbDgu7cLQUHNWr/DdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnvkdD6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5426C4CEDD;
	Thu,  6 Feb 2025 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738866059;
	bh=j6HGYyGPwE2tuf0qT9ePG+naFb8GANLvOkDxNv/9coI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnvkdD6wwCvetXTtTU3DD3qXLbEz1k1pUj2N2g6iKUSc30+eHNEzEtkNcxkbR8Nk/
	 n4wEBey7C85XeSyqkSi2PFuHoH/Eu8kYbN3VtWttfEkbkbprlIwfWr9oGDErtayuVw
	 QAMJd9NGhvXhoJrKBg6hnNvgVQmpkU0eGG+MfE/vtzRK3oOg9SjsDsA0vdnYNUaSHw
	 mzZ7kfhPXN9xbEed5e934I0LZkffaWfhdarAElMCQIlRvEf1KwKruDCTHWyPJxVsF3
	 6rLSr7Y4qlh+1T0Cj1PRR8hBVWN859Nkp1mXVG2sl9S5tU1wAvu8U0XRtbH4oK7pA6
	 I6Rho8WVdEJFg==
Date: Thu, 6 Feb 2025 18:20:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Hermes Zhang <Hermes.Zhang@axis.com>
Cc: jic23@kernel.org, robh@kernel.org, lars@metafoo.de, krzk+dt@kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Hermes Zhang <chenhuiz@axis.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: chemical: sensirion,senxx: Add
 yaml description
Message-ID: <20250206-italics-reproduce-35d554c38751@spud>
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
 <20250206061521.2546108-3-Hermes.Zhang@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gevec6sj3mQRLmUh"
Content-Disposition: inline
In-Reply-To: <20250206061521.2546108-3-Hermes.Zhang@axis.com>


--Gevec6sj3mQRLmUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 02:15:16PM +0800, Hermes Zhang wrote:
> Add documentation for the SEN5x/SEN6x environmental sensor from Sensirion.
>=20
> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
> ---
>  .../iio/chemical/sensirion,senxx.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensir=
ion,senxx.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sen=
xx.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.ya=
ml
> new file mode 100644
> index 000000000000..4d998eabe441
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml

filename matching a compatible please.

> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/sensirion,senxx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SEN5x/SEN6x environmental sensor
> +
> +maintainers:
> +  - Hermes Zhang <chenhuiz@axis.com>
> +
> +description: |
> +  The SEN5x/SEN6x is a sensor module family combining the measurement of=
 air
> +  quality parameters: particulate matter, VOC, NOx, humidity, and temper=
ature.
> +
> +  Datasheet:
> +  https://sensirion.com/media/documents/6791EFA0/62A1F68F/Sensirion_Data=
sheet_Environmental_Node_SEN5x.pdf
> +  https://sensirion.com/media/documents/FAFC548D/6731FFFA/Sensirion_Data=
sheet_SEN6x.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,sen50
> +      - sensirion,sen54
> +      - sensirion,sen55
> +      - sensirion,sen60
> +      - sensirion,sen65
> +      - sensirion,sen66

I'd like a note in the commit message as to how all of these devices are
different please.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

No supplies needed for this device? Seems like you would need at least
one, no?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      sen55@69 {
> +        compatible =3D "sensirion,sen55";
> +        reg =3D <0x69>;
> +      };
> +    };
> --=20
> 2.45.2
>=20

--Gevec6sj3mQRLmUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6T9hgAKCRB4tDGHoIJi
0iSRAPkBaE83GiZYvgBcL3QGaQsIGlJ/PlgGutZFblMaxfjLdQD9GxJeK4n5HSG6
8azZAY5MEzmkXd7mLi4SAOdf5GHc9gI=
=E6hP
-----END PGP SIGNATURE-----

--Gevec6sj3mQRLmUh--

