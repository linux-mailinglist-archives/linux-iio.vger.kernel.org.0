Return-Path: <linux-iio+bounces-25417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13ADC05FAD
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 13:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACFD19A1FED
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5310313E19;
	Fri, 24 Oct 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s00cKF6/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8431076A;
	Fri, 24 Oct 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303903; cv=none; b=YR3wzlNh/wlP5VP4zIkgqNYpEjgTJuKbaJJEqmLDV1I5zzwOSm9sBuQk4QhayIsPMPwO8yzcxNBM/MJSyqyXe/f0etbfUxgngLY4fkD0+yi8qekm7+MeZ0UsKOaBCMA1unP/ESEuMrhwIRWa7PJvskFl+QqyB4YTZKm/uijG+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303903; c=relaxed/simple;
	bh=BXDZzEsmDtJ5qTyvhREBgZJTmqfehHSA8zAtWClKrHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efHX4DKVtCa/ZOw9uIXXXU09Kup37W4JgI+ccLMMlJwJH6HVWBszmoeNVjQU30bcbBcOFGy6dggFXrWjHcD+WYcAjdTAjtAENiFT3xRLozasvDKR+eH4tLzZLM4fL764N2cgS8rnWTgBQyurEMXyXK8lBhhv6NZ8H3hVjm+vvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s00cKF6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54CFC4CEF1;
	Fri, 24 Oct 2025 11:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303903;
	bh=BXDZzEsmDtJ5qTyvhREBgZJTmqfehHSA8zAtWClKrHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s00cKF6/xs83KcywZRPOgdT4aoPRhjLwHATJdc00VFTBa8X1rXo9jHqsJqzE7q4F3
	 /h3/OZofAbLS0hWvv16p0r34A/GKUtev+QS8sogwsAi4Lc8UzFr3Y1Gnsfhhxp3174
	 xk3JWOAs7lqoXQZ2zkKlVaSR3xuUwsK6lqpsDOdJalkjSjEAU8p6sSOs0cGQ2pqep9
	 mDKCh6Bp62y+lPtCUImH4bMa6ZDIoLn0icZkcM3JxIhKlpdWUVeli+iSwp085DRmrz
	 E2O6cwjB4BCnvJbnhU61NjAkOkZLbiie4a1aipQOiSBDbKD3FxvZNW5gWEn+lds/jZ
	 3yiT89Icq8QeA==
Date: Fri, 24 Oct 2025 12:04:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Document AD5446 and
 similar devices
Message-ID: <20251024-scope-uncle-93183d40ef11@spud>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
 <20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
 <20251023-food-say-5e396be087af@spud>
 <20251024111207.00007427@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/M3fZ5hx6PMPNKnm"
Content-Disposition: inline
In-Reply-To: <20251024111207.00007427@huawei.com>


--/M3fZ5hx6PMPNKnm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:12:07AM +0100, Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 19:24:17 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Thu, Oct 23, 2025 at 02:01:37PM +0300, Nuno S=E1 wrote:
> > > Add device tree binding documentation for the Analog Devices AD5446
> > > family of Digital-to-Analog Converters and compatible devices from
> > > Texas Instruments. There's both SPI and I2C interfaces and feature
> > > resolutions ranging from 8-bit to 16-bit.
> > >=20
> > > The binding covers 29 compatible devices including the AD5446 series,=
 =20
> >=20
> > If they're compatible, how come there's no fallback use? Just to keep
> > things consistent with how they've always been while probing as spi
> > child devices?
> Hi Conor,
>=20
> They aren't compatible. The 2nd patch is misleading because it doesn't
> associate data with the of_device_id.  The driver is getting that from
> matching the compatible property with manufacturer stripped off.
>=20
> I've requested Nuno sort that out in v3. It's a bit more than just
> adding the data as would also involve moving away from using an enum
> to using pointers to the structures that the enum indexes (currently in
> an array).
>=20
> https://elixir.bootlin.com/linux/v6.17.4/source/drivers/iio/dac/ad5446.c#=
L315
>=20

Right, I think the wording about "compatible" should be removed from the
commit message here then. Maybe something like "derivative devices"
would be a better fit?

pw-bot: changes-requested

--/M3fZ5hx6PMPNKnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPtdWgAKCRB4tDGHoIJi
0lglAP4jQBOF2sAGXw664t5Pyzfi13Clz417NDGxCuZ6LGqhfgD/fQoTSwsQSsmn
W54gFdLJViK9B4R9K/EhOwfxpQrmgAI=
=awPw
-----END PGP SIGNATURE-----

--/M3fZ5hx6PMPNKnm--

