Return-Path: <linux-iio+bounces-5513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615818D50F7
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 19:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2802859AE
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B246246421;
	Thu, 30 May 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQUhxd5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680253BB2E;
	Thu, 30 May 2024 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089916; cv=none; b=QtJgeK0mxPDDv0/9dID8do9XJ6gI/87FdL7od1bu3hbcIJnQ0Jb8NZs0tMMnYtykwIBXVARSesyqVzwbH0NAbhpfJ9S5dkTwUdY4hwhB50zWPLK+DvTwQ6htL2uBs98xLHDRGiMAGen13M/J5H8DNM6AraYrFvptm/Eq9dKz1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089916; c=relaxed/simple;
	bh=pboA1hBIpcHcKlGoMIXYiUxcorVrN0SMLl0WvkRYb4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CowjV3Dd8nrWlowTktB/te2uB+lsgr7q6KHi81Ft5Bvv6nXstbnkctn6vXukNwfB6HFT07hnAE+ox31exCHqCoh9fZ+XveXqnA2ntA166YB6F7EmARJnffsUShr1GBTF0T1ankCmWvD7iKf0Uq9TJpAm8n+ILmcR0Db7bvwuayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQUhxd5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19598C2BBFC;
	Thu, 30 May 2024 17:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717089916;
	bh=pboA1hBIpcHcKlGoMIXYiUxcorVrN0SMLl0WvkRYb4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQUhxd5PNM/15CU7pteQgxbwJLw07SUIwItr650NQrDeK8ct+/gcsW/sdGtrUCVBz
	 x4DyI0kc6lFyc7Lf7IiV61AnfNkxFYIMHVIQNK/9xbTLEnVnVBpA3lMTGxxKifmGu1
	 IWnON8+LE08bPC1MY1OCRjic+qeYWVaqm5K7eiXZJq//Ti+FQ3yiCWn5kPUjTY3W0Y
	 ypa9B+AUYPmi6Nm/IUFtpELH+6LvL66oRxHnBstPZkOcTas0F3Jb85qrMc/I68SD4x
	 NzsQwQ5M2JL8jSS4kgtDK25CPZLDfblt3nIX/wgUDfqTehwGMZJ/8NqPwvdJCYP1F8
	 JtYiTyu6tF1sg==
Date: Thu, 30 May 2024 18:25:10 +0100
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
Message-ID: <20240530-unaltered-thong-a6e52519f101@spud>
References: <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <59df2cc3-5a62-45be-a0aa-5bbff13c2ae4@baylibre.com>
 <20240526-stylized-preaching-d0b15a95fe19@spud>
 <baa286ca-3388-4604-9bc3-233c1fc77c42@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nlIBklSo3KTqCWIO"
Content-Disposition: inline
In-Reply-To: <baa286ca-3388-4604-9bc3-233c1fc77c42@baylibre.com>


--nlIBklSo3KTqCWIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 03:10:54PM -0500, David Lechner wrote:
> On 5/26/24 10:45 AM, Conor Dooley wrote:
> > On Thu, May 23, 2024 at 09:28:54AM -0500, David Lechner wrote:
>=20
>=20
> >> * A is the one we need to figure out. I'm proposing that the PWM consu=
mer
> >>   should be whatever kind of composite device node we come up with that
> >>   also solves the issue described below about where does the CRC check=
er
> >>   (or whatever) go. I think we are in agreement here at least on the p=
oint
> >>   that it doesn't belong in the SPI controller node?
> >=20
> > To be clear, you're saying that we agree that the CRC checker doesnt
> > belong in the SPI controller node, right?
>=20
> Yes.=20

Okay, ye. We're on the same page then about that part.


--nlIBklSo3KTqCWIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZli2dgAKCRB4tDGHoIJi
0pjHAQCA1My+hayttX0Rfvpc9/Yovyg3HVsBE4YZTTK4+pNrmAEAlmsqE+T4GClt
SZyq1aNDCiMpi/6NTsWEf1+r0blkpgI=
=CHF9
-----END PGP SIGNATURE-----

--nlIBklSo3KTqCWIO--

