Return-Path: <linux-iio+bounces-24299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674AEB8AC39
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 19:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3234E5A406A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A14322A09;
	Fri, 19 Sep 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsG07qKK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3070322771;
	Fri, 19 Sep 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758302976; cv=none; b=ttnFho523+RnyadqHHaRoBHHsmBCd3JrFmmi2ChFLENxBITGo1OLjc4hAy5HDQItSenv5ZcccT7zE9Mr9nNGYmXjzfrVN9amun2oNuqs39/ZyWS9zZlH+cgUhleNnwdU9O7eUF4rk+cxu5nM2ENKZqVci56tmNt0tfrLt0d1uUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758302976; c=relaxed/simple;
	bh=yolyFSvAZQSCV4o00YkI5zTRWR/ZeCIulMzo4rybVAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5scXZJ2v3BeLsjIR9LdmKK6YL3xupG4BOvl9aMR6FYgFUX+lqKrlVG/Fjkr9MkcSiKIPMePVvW4y4NksBZcE8Iet5B2XAccrylaEY4/UZTpRH49N6uorNfQhLelLuvtbngi159a06nSUNaW8mh1aBgIri+EeTzW4k6EuCYDlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsG07qKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B17C4CEF7;
	Fri, 19 Sep 2025 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758302975;
	bh=yolyFSvAZQSCV4o00YkI5zTRWR/ZeCIulMzo4rybVAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsG07qKKniEd6O+WrjI6ci8uYXes5STUKUnnn1PvaSz+EKY86M11/ZMhIhci10tzs
	 p8k+yFATL57JcJ6e4eUFBGnYFK6s8rRT6SzdtgSoHJtAhzcKfOVOiGa2mOsAf9fXmO
	 dEuMIZ6eT2TVXmZGs/5eWPO6O8TF4p9yh61hdpiZSI0GaYZVKDDbxr2uQOdcLDcgih
	 WWlXl78spe/elw1zwYpOpcfjBhjtGwKdNiS44ScY9yL3EQALA4GHfdu4WN1/YtN27D
	 93jxldHmhlVhShxGlfZZ0JRxGuA8vYpzLN+ZgRw1fAqoiXLQl52U4xX8J8ObOyiduT
	 yQgD80c8KB/oQ==
Date: Fri, 19 Sep 2025 18:29:29 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: adc: adi,ad4030: Reference
 spi-peripheral-props
Message-ID: <20250919-paramount-headstand-c9b5d4d03c58@spud>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
 <f7d7f400-cc43-41d9-bc97-39d308363f14@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eiMpNmTU9mjnvz9W"
Content-Disposition: inline
In-Reply-To: <f7d7f400-cc43-41d9-bc97-39d308363f14@baylibre.com>


--eiMpNmTU9mjnvz9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 02:39:01PM -0500, David Lechner wrote:
> On 9/18/25 12:38 PM, Marcelo Schmitt wrote:
> > AD4030 and similar devices all connect to the system as SPI peripherals.
> > Reference spi-peripheral-props so common SPI peripheral can be used from
> > ad4030 dt-binding.
> >=20
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> > index 54e7349317b7..a8fee4062d0e 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> > @@ -20,6 +20,8 @@ description: |
> >    * https://www.analog.com/media/en/technical-documentation/data-sheet=
s/ad4630-24_ad4632-24.pdf
> >    * https://www.analog.com/media/en/technical-documentation/data-sheet=
s/ad4630-16-4632-16.pdf
> > =20
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
>=20
> I think this is already referenced for all child nodes of a SPI
> controller because of pattern matching of:
>=20
> patternProperties:
>   "^.*@[0-9a-f]+$":
>     type: object
>     $ref: spi-peripheral-props.yaml
>=20
> in Documentation/devicetree/bindings/spi/spi-controller.yaml
>=20
> So perhaps not strictly necessary?
>=20
> Would be curious to know if there is some difference.

I think it's good form if you're actually referencing the properties. I
don't know if it actually makes a difference in the end result of
dtbs_check but it may in terms of making sure properties in this binding
are properly typed when it is tested against. In this case, it appears
you're only looking at uint32 properties so it mightn't have any impact.
Rob would know for sure.


--eiMpNmTU9mjnvz9W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaM2S+QAKCRB4tDGHoIJi
0rJvAP9pbgnWHcefL9cZQwGDDaXr8+UfIrd0gSsrfedRiYie+AD8DsnTAienjOR2
JqyWaPj65PIXAeCWs5vwNEf5aUxIMQU=
=n/GA
-----END PGP SIGNATURE-----

--eiMpNmTU9mjnvz9W--

