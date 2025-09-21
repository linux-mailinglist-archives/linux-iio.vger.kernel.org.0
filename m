Return-Path: <linux-iio+bounces-24339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A1DB8E625
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE84F176478
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B302848AA;
	Sun, 21 Sep 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLJADyZi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43628DB3;
	Sun, 21 Sep 2025 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758489738; cv=none; b=S0G0ZvlCOC0yj56m3jvdxDyG5LOINrG8KjLzNtl3Q+OAvukQ8UuUbsNfGN8Eu6hHCzOFEbFQ6/8lEyJLkFyg0+4B8mZdxg/968IUQ9kXsTzkgXUHQFDhA8HQTeiCDoR5+V0k6gpGoaNhDEBlx9Am3tZEO2hiiiBtcbBYPNNRnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758489738; c=relaxed/simple;
	bh=H+EzH1zfM2DRRNjqf5i051YOsyI8mugNoDG3wbNZDww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6oJzKxuyxkHzUgWM4iKhzGLHI+gxuoPc1LDgVDGftFEGgweKwHkX/Mw67YSFRMN+Vze8o7cragVkX8iHpDmyjMPPkGnJOMnFUwk6Ph2d4cMz2zQByAKW4NNG6i71KgMZ7zf3yY7VmdIg2lOQFPWGslBnZf6Vp7v86qydCKpSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLJADyZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F57C4CEE7;
	Sun, 21 Sep 2025 21:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758489737;
	bh=H+EzH1zfM2DRRNjqf5i051YOsyI8mugNoDG3wbNZDww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uLJADyZiNVHmSFF5dt3xlH2LjyNBtqRuOhJPGeBHZUutRyXAyaL+1wCC19OaYfJ2A
	 UKYMTtfSVS+th7n60smPpZP/JOCakC9JFk5zBxtMuyUUv3mBh8Q9dlLky2OAYddkNr
	 rzgwo8wuO5yooISyb/3nqKifIXKgHnvcXyownNjtZt2gWv9mW5YFO3+4YbmMCZ3HHV
	 AxN3laNuX7QEt4gaiDu9UaVVl0D5S4wBmLt/qi/yeIJPydq5m+3gFFoHqN+2RZ3Z80
	 Zl7eCSXkRH/Ko+aRbQKPi+Wm974+JiWeDq+tm6/Eu3UwRVRaFdRcLggYS0cmZTZs9S
	 D7pJBIU3wfqvQ==
Date: Sun, 21 Sep 2025 22:22:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v11 1/3] dt-bindings: iio: adc: add max14001
Message-ID: <20250921-paralegal-styling-17b66d975dcf@spud>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <30f33a64da0339eccc1474406afb2b1d02a0cd6b.1757971454.git.marilene.agarcia@gmail.com>
 <8e88b601-1329-4cdb-bbd7-feb998c552e8@baylibre.com>
 <20250916-alto-vaseline-f8dafbab03e9@spud>
 <aM8gVOVEujP6Yzxx@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W+DpYoV8b+Cs/Ccq"
Content-Disposition: inline
In-Reply-To: <aM8gVOVEujP6Yzxx@debian-BULLSEYE-live-builder-AMD64>


--W+DpYoV8b+Cs/Ccq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 06:44:52PM -0300, Marcelo Schmitt wrote:
> ...
> >=20
> > > > +  interrupts:
> > > > +    minItems: 1
> > > > +    items:
> > > > +      - description: |
> > > > +          Asserts high when ADC readings exceed the upper threshol=
d and low
> > > > +          when below the lower threshold. Must be connected to the=
 COUT pin.
> > > > +      - description: |
> > > > +          Alert output that asserts low during a number of differe=
nt error
> > > > +          conditions. The interrupt source must be attached to FAU=
LT pin.
> >=20
> > These descriptions read wrong to me. They __are__ the COUT and FAULT
> > pins, given what David responded to above, not something that can be
> > connected to these pins (if they were, they would be represented as
> > -gpios rather than interrupts most likely). Unless you mean that these
> > pins can have some other use and are only available on the COUT/FAULT
> > pins when some register value is set - but even in that case saying
> > "must be" doesn't fit since the interrupt property could be used to
> > configure the device accordingly.
>=20
> COUT and FAULT are just two pins on the ADC chip that can be used to gene=
rate
> interrupts. Would a description like the one below sound better?
>=20
>   interrupts:
>     minItems: 1
>     items:
>       - description: |
>           cout: Comparator output signal that asserts high when ADC readi=
ngs
>           exceed the upper threshold and low when readings fall below the=
 lower
>           threshold.

I think you should mention the pin name here, like you did below.
"asserts high on the COUT pin" or w/e.

>       - description: |
>           fault: When fault reporting is enabled, the FAULT pin is assert=
ed low
>           whenever one of the monitored fault conditions occurs.
>=20
> Best regards,
> Marcelo

--W+DpYoV8b+Cs/Ccq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNBsgwAKCRB4tDGHoIJi
0hK2AQD3IF48yOtDk+looOMHt+sNV097qYD6vDjajm46tHWH2wEAiermHYVxtsB+
p3quzF9ZZWvf3l8lN9Eu13vhfxmjiQ8=
=bJdk
-----END PGP SIGNATURE-----

--W+DpYoV8b+Cs/Ccq--

