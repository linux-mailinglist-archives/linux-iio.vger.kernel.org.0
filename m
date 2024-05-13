Return-Path: <linux-iio+bounces-5013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441C48C453A
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AF31F2188D
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618A18645;
	Mon, 13 May 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJNrDZT8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE215C0;
	Mon, 13 May 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618770; cv=none; b=gDzJzlrPi9ymTSRiJiqtQnthPuVMC/BwV6uWyJFkggXMHiHbKuBeVfyzPIJGPbjTHI/ppnMjqYDjpXRt7F35Or9nqHsQuKemndt4XCBQv/zQ5NAIo1RfO+1tlIKKCjjdOzmQv+Bwcuub7SFnshm+hXLxQm1Ie1AeWCW0YBkQhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618770; c=relaxed/simple;
	bh=FPfAXVM12QYDyYflSy0vT9mflrQA7TObx9YGhJ3owMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ET4UCQMD5Go3w9giX4sX6vJbohzzVR6iDdKzB/nC2hS46TYUfJfIRLQG+Vo2Ftqo5u0hiKM2Lh99+K3C/e6uSeT7BSE8lgYR9Kbx+Ckqk1Mt0RDawHrCNHSJOQsyanujqaux9F9+K4fWMgT+vs413tYwuXiTXlWQRKJorX5xAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJNrDZT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF5DC113CC;
	Mon, 13 May 2024 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715618770;
	bh=FPfAXVM12QYDyYflSy0vT9mflrQA7TObx9YGhJ3owMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJNrDZT8ki4t4Db9+DTa2OrP3Tn8kyMdH77y5inAKYCvKgARikHL3kUkh1MvqTQ2q
	 LU5NT8OAG5Y+rW65PWWdgs5VeKGWvWr/g8k7duQ9eX89hOC24yCw6DVP8KeHsDvS6O
	 BoGvuNGCPJMMA5v/RNmQnfp10rmv9JZyv2Ejl5BnutFeGOTMqIrfrFolzqHJ6ztzar
	 MB5tRlJSPVjSYa5Yissa3/xuTmwejCHvZ/LbIqKgAD8yhlrm6rnmx7Q/aoVUED7hZU
	 5e6MmBxgfPq/RzNW9xlfvypEGtRlWY0/PPDtY0wEYg7+fEhqmervzWrPErhrM9MWnm
	 9F1dX2W8EaBfQ==
Date: Mon, 13 May 2024 17:46:05 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
Message-ID: <20240513-headsman-hacking-d51fcc811695@spud>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Btx5Xw/JNA0IyjcR"
Content-Disposition: inline
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com>


--Btx5Xw/JNA0IyjcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 07:44:24PM -0500, David Lechner wrote:
> This adds a new property to the spi-peripheral-props binding for use
> with peripherals connected to controllers that support offloading.
>=20
> Here, offloading means that the controller has the ability to perform
> complex SPI transactions without CPU intervention in some shape or form.
>=20
> This property will be used to assign controller offload resources to
> each peripheral that needs them. What these resources are will be
> defined by each specific controller binding.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v2 changes:
>=20
> In v1, instead of generic SPI bindings, there were only controller-
> specific bindings, so this is a new patch.
>=20
> In the previous version I also had an offloads object node that described
> what the offload capabilities were but it was suggested that this was
> not necessary/overcomplicated. So I've gone to the other extreme and
> made it perhaps over-simplified now by requiring all information about
> how each offload is used to be encoded in a single u32.

The property is a u32-array, so I guess, not a single u32?

> We could of course consider using #spi-offload-cells instead for
> allowing encoding multiple parameters for each offload instance if that
> would be preferable.

A -cells property was my gut reaction to what you'd written here and
seems especially appropriate if there's any likelihood of some future
device using some external resources for spi-offloading.
However, -cells properties go in providers, not consumers, so it wouldn't
end up in spi-periph-props.yaml, but rather in the controller binding,
and instead there'd be a cell array type property in here. I think you
know that though and I'm interpreting what's been written rather than
what you meant.

> I also considered adding spi-offload-names that could be used as sort
> of a compatible string (more of an interface name really) in case some
> peripherals may want to support more than 1 specialized type of offload.
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml          | 10 ++++=
++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.y=
aml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 15938f81fdce..32991a2d2264 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -113,6 +113,16 @@ properties:
>      minItems: 2
>      maxItems: 4
> =20
> +  spi-offloads:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Array of controller offload instances that are reserved for use by=
 the
> +      peripheral device. The semantic meaning of the values of the array
> +      elements is defined by the controller. For example, it could be a =
simple
> +      0-based index of the offload instance, or it could be a bitfield w=
here
> +      a few bits represent the assigned hardware trigger, a few bits rep=
resent
> +      the assigned RX stream, etc.
> +
>    st,spi-midi-ns:
>      description: |
>        Only for STM32H7, (Master Inter-Data Idleness) minimum time
>=20
> --=20
> 2.43.2
>=20

--Btx5Xw/JNA0IyjcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkJDzAAKCRB4tDGHoIJi
0rxnAP46azYaoMSmeOfVGolpu43RRMkioH3BACCy3ZHbSEx66AEAsD8kvUpG4dCX
dXN+O+jruTMFSscpBOTnGnv8/cH7cww=
=am+m
-----END PGP SIGNATURE-----

--Btx5Xw/JNA0IyjcR--

