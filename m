Return-Path: <linux-iio+bounces-23007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBB3B2CBB2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0993D3B3AF8
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535830EF9F;
	Tue, 19 Aug 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY1Y0E6m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B030BF71;
	Tue, 19 Aug 2025 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627135; cv=none; b=iTvj9NoAvhI3hkwE1vA4+EwwDTYLGLygwIXhV1/raSG8d8JjSGezUukrokB00SV5RSHqTjSmkYuhr3K1x0l8LSa1MqYXW9yv+KO1R/gkKDpqREF04EaxAdcvK2+nGYg2zOcGzqTFK7IIbzC6ARhVlXnIQymuOFNbN38fL/8X5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627135; c=relaxed/simple;
	bh=AoERD4ZxArAr7g/5QIVH/HyMW+sbBV9YvBMb+yvH45c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvs3w+8xVIo8osUkZX+E6uDAYUVE7w2tO5tmCziXBHr6aIQhO7FUPA7m1+GtiGR1fUf6Cu/SA1f8P14ICgsT/aHcNgNASdJVKLJI4JsmmZtLTMfmNYNDcXVcuom5wC0lhQUzHj+zEXUXRXuKybAeE/CoUxk+tt9wQGI3WyOhZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY1Y0E6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3101C4CEF1;
	Tue, 19 Aug 2025 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627135;
	bh=AoERD4ZxArAr7g/5QIVH/HyMW+sbBV9YvBMb+yvH45c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XY1Y0E6mcK8yirwz4G2g22An1eg++XdDljy1DWXBdiOITLzmfhRSBgzJLv+X4KNX5
	 EH0ftdbNxhPaGfkpImnS4rAs2XTujpQ4OsefzkKrDyvVvF5RBRViBbeWwjiiyGEN+S
	 tLoLg3BK9j/t3cQZDChuS8pkR78Wi01A3mD3CCCyEycYWJ/Zldb/5u0DVYJ8i0Eg+d
	 Bw4UAT9ORugtcnoCu/ur0ICQHyiEoJA4vFC2Ms6KNbIn+AMqMUdIq1uqfQVxv68cel
	 RDDE+BTY83I22XbDNBjg8VrSz12aug7YjUNEvUlFaj6ZOEy9vL/RRRVkynhAB6RfMc
	 aeUdG7OmqLwng==
Date: Tue, 19 Aug 2025 19:12:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: max1238: Add
 #io-channel-cells property
Message-ID: <20250819-astronomy-gladiator-21823768723a@spud>
References: <20250818200014.3700738-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DSiCfLRmt6iyDHmw"
Content-Disposition: inline
In-Reply-To: <20250818200014.3700738-1-Frank.Li@nxp.com>


--DSiCfLRmt6iyDHmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 04:00:13PM -0400, Frank Li wrote:
> Add #io-channel-cells property because it is multi-channel ADC.

As far as I understand it, that's not a correct statement. A single
channel ADC can have the property, but it would be set to 0 just as a
single clock provider has #clock-cells of 0.

I did check the devices and they do all appear to be multichannel (not
just the 1238) so the change you're making here looks correct, unless
some of them would actually require 2 cells for some reason - but you
should really state that in your commit message when there's about 30
compatibles so that I don't have to check them.

With an accurate commit message,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Maybe Jonathan is willing to do that since it's just adding "of 1" to
the first sentence.

>=20
> Fix below CHECK_DTBS warnings:
>   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: adc@35 (maxim,max1239): '#io-=
channel-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/maxim,max1238.yam=
l#
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml=
 b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> index 60d7b34e3286f..ae3c89393f1a3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> @@ -53,6 +53,9 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  "#io-channel-cells":
> +    const: 1
> +
>    vcc-supply: true
>    vref-supply:
>      description: Optional external reference.  If not supplied, internal
> --=20
> 2.34.1
>=20

--DSiCfLRmt6iyDHmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKS+egAKCRB4tDGHoIJi
0v0rAQDWxASg3MF9RgagWA6/SS2sG6+G/p2ZaZDXfUfFZBHZGQD/TumQX8AKKXig
TxQ6zDvrGNl/fj0ym3fH/YYpBvWCmAg=
=MVrX
-----END PGP SIGNATURE-----

--DSiCfLRmt6iyDHmw--

