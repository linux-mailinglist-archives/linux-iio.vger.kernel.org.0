Return-Path: <linux-iio+bounces-5220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937D18CD5D9
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345EAB22613
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0904113C3E7;
	Thu, 23 May 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLo2wGmT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E01EA6F;
	Thu, 23 May 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474717; cv=none; b=sXyxwp+XzcFy7PzETKcZY3WqBnzY57lzocU4+N0cUHDJms5yO13+LmiuYM4ExgdAJ1ociC9Jw0hefnAC8Gfj8jL1TLTYB42kLiVX1vQ034ainz0Us1h4DAuqTrrJQOrTcxbYz4N515yCaaoQkZqN4c10ezgtjoNdFzZ0UT1SEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474717; c=relaxed/simple;
	bh=z+/P8L5KjNx907uaz+/G1K7pVGEzXZy7/dsMvxUblY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0vfeOP9Xz0L8CdxCJWj60JPrkRVwhKISv6APake2XvJ+NHMWGEKC0duKF4m6hT+EC4NHtD5h0IPHRjuGCS1MtcnDz1kZhRdHa/HQ5xezFbDDHNVZIZGoDd2wusOyjkns7+7hFWVeRI9ZLBQpMUQh+oJXXAXUHrjvKCC5wvxbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLo2wGmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282C6C2BD10;
	Thu, 23 May 2024 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716474717;
	bh=z+/P8L5KjNx907uaz+/G1K7pVGEzXZy7/dsMvxUblY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLo2wGmTg6txQgIoshiVsLwUvoY7/xKWZMSxVOYB3O85VZCq5alt62eezKWuas3px
	 DjCVEcadDbuUC89D7N5lCnTjD8Dyh/UVvqiwu75V9SwiRFZfxHkPAlnlNLt4O012lj
	 poL3iHuakngtyKHf+2CqGsOfomtvn/AJRECZsWBOGP26Dw8DAlXzUqV7OanHBQ0K/3
	 4zjzrTbgKJmHWaEdIZYperJDQR3g4Q1JcEz0E/JyjvAWkJPEyMd3OaSM1AyFVlMj3K
	 7XD5I8cNhK1z7ufAVZF0OgkPDxbsTwXjmCmLrHwABC+sFdVRSdhVMx9/qtQGIjI/GL
	 kZenvq60TQETQ==
Date: Thu, 23 May 2024 15:31:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <20240523-divided-herbicide-11396549e05f@spud>
References: <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gf9CS1NJgXAMKbNH"
Content-Disposition: inline
In-Reply-To: <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>


--gf9CS1NJgXAMKbNH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 02:15:35PM +0200, Nuno S=C3=A1 wrote:
> On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:
> > On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
> > > On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >=20
> > > > On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
> > > > > On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@kerne=
l.org> wrote:
> > > > > > On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
> > > >=20
> > I think you're right something like that is a stretch to say that that
> > is a feature of the SPI controller - but I still don't believe that
> > modelling it as part of the ADC is correct. I don't fully understand the
> > io-backends and how they work yet, but the features you describe there
> > seem like something that should/could be modelled as one, with its own
> > node and compatible etc. Describing custom RTL stuff ain't always
> > strightforward, but the stuff from Analog is versioned and documented
> > etc so it shouldn't be quite that hard.
> >=20
>=20
> Putting this in io-backends is likely a stretch but one thing to add is t=
hat the
> peripheral is always (I think) kind of the consumer of the resources. Tak=
ing the
> trigger (PWM) as an example and even when it is directly connected with t=
he offload
> block, the peripheral still needs to know about it. Think of sampling fre=
quency...
> The period of the trigger signal is strictly connected with the sampling =
frequency of
> the peripheral for example. So I see 2 things:

Cherry picking this one thing to reply to cos I'm not sure if it was
understood as I intended. When I talked about io-backends I was not
suggesting that we drop the spi-offload idea, I was suggesting that if
something has a dedicated register region & resources that handles both
offloading and some usecase specific data processing that it should be a
device of its own, acting as a provider of both spi-offloads and
io-backends.
I'll look at the rest of the mail soonTM.

--gf9CS1NJgXAMKbNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk9TVwAKCRB4tDGHoIJi
0hN/APsFPaTQxDK3YqRUJgT5J20VxUY1KBTNxCCt0kwkMu/iygD9EE5MiES4Ipue
iL0dC3Lu3LuqcZ78q0lv9bkm/bhYLAk=
=gfAt
-----END PGP SIGNATURE-----

--gf9CS1NJgXAMKbNH--

