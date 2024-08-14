Return-Path: <linux-iio+bounces-8471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D375951F43
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 17:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8AB2858C5
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E231B86C8;
	Wed, 14 Aug 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxmJ8WeY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E804D1B5836;
	Wed, 14 Aug 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651139; cv=none; b=CFH96wEISpC0Gn9WloGGFke5LNtGYhsmnnJmCI+wSDuckQ1dIbQjw0WHrSH1lyudhJzKZq4N/nGwRwtSs7MTq5RsfsJpMpGMcWTXO0fVcUnuqLlwmFGMA54Vd3Zi3FmYy4dzDQhrrJsJcytUrkFkkKN+Yhze93UgJ3NEjJYEzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651139; c=relaxed/simple;
	bh=ebhppG2jJl4kjOhx5+tliZesEl+lN1kt3DqcIRt8yZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdY6ce76uDg7c8o4ROKUMBMJ2QmVwDhzSADPxUEbrzvYKcs5FnXYJCQU9qfWdnVuV6BdouDf4pEsygR+pUF9VIPRsD05JXSAbS/qtlGAntrvIjKknqkgiWaMqoxGClvyBup5F1uBQs4Qka6zXtgKZVwVrvI4FHRBD+DKY3QpPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxmJ8WeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EFDC4AF09;
	Wed, 14 Aug 2024 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723651138;
	bh=ebhppG2jJl4kjOhx5+tliZesEl+lN1kt3DqcIRt8yZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxmJ8WeYYlLlmy6Yb1oBPI/Ih0P/gcHJgZ8Akq+m364iSP7/wMC6WeMk2j/DB30tG
	 a9zujq/bdZo6ZkCAQdhX2xOkGiYj8wS2VXH+6m6jcgHIDPRpLIR/qReU4Uy0PUxTdl
	 /ovdsFpzYXOq2yb7VOKF22Od2gchqWbXSi7XVDW+6d12hL2qBeGpt6s3VQFxlWvwWW
	 FuAhJXGtfOmZ51Xv8PoJ1Hh8sSeoW4MVQ3nQzixrBVPW3AsElaSn0Ekw9mbuPLC1QV
	 T0ogsAnAH6cNBESF6tRqFzsibDfHl3kfk9mtiWrj8Alk3xuurK1dkqbN3lpQWoZo7V
	 r6s4VwdIg9mHA==
Date: Wed, 14 Aug 2024 16:58:53 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v3 5/9] spi: dt-bindings: axi-spi-engine: document
 spi-offloads
Message-ID: <20240814-breeding-revolving-ba26c46164de@spud>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <20240722-dlech-mainline-spi-engine-offload-2-v3-5-7420e45df69b@baylibre.com>
 <20240726123836.GA998909-robh@kernel.org>
 <9f57e41f-3534-4188-ae78-d323aa45e2a1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZusG0p1O4JWHSMMm"
Content-Disposition: inline
In-Reply-To: <9f57e41f-3534-4188-ae78-d323aa45e2a1@baylibre.com>


--ZusG0p1O4JWHSMMm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 02:17:00PM -0500, David Lechner wrote:
> On 7/26/24 7:38 AM, Rob Herring wrote:
> > On Mon, Jul 22, 2024 at 04:57:12PM -0500, David Lechner wrote:
> >> The AXI SPI Engine has support for hardware offloading capabilities.
> >> There can be up to 32 offload instances per SPI controller, so the
> >> bindings limit the value accordingly.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>
> >> RFC: I have a few questions about this one...
> >>
> >> 1.  The trigger-source properties are borrowed from the leds bindings.
> >>     Do we want to promote this to a generic binding that can be used by
> >>     any type of device?
> >=20
> > I would make it specific to spi-offload.
>=20
> OK
>=20
> Meanwhile, we are working on some other ADCs (without SPI offload) and
> finding that they are using basically the same sorts of triggers. And
> on the driver side of things in this series, I'm getting feedback that
> we should have some sort of generic trigger device rather than using,
> e.g. a clk directly. If we need this same sort of trigger abstraction
> for both SPI offloads and IIO device, it does seems like we might want
> to consider something like a new trigger subsystem.

A "device" in the sense that "pwm-clk" is a device I suppose. Are any of
these other things WIP on the lists (that I may have missed while I was
away) or are they still something you're working on internally.

--ZusG0p1O4JWHSMMm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrzUPQAKCRB4tDGHoIJi
0jD4AP0dE6Z/BC26csx6JZBoqN6h2RHSUhANMGAyLa3RP+2TcAEA0T3231n3cMsw
b3Z3Lf7qc9+eIRitPf5gvLRy2++mlg0=
=uOLi
-----END PGP SIGNATURE-----

--ZusG0p1O4JWHSMMm--

