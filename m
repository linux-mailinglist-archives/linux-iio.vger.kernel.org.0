Return-Path: <linux-iio+bounces-6756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7FC913B99
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB46B20D59
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 14:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB7D148830;
	Sun, 23 Jun 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDnFeY4m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202A3EA69;
	Sun, 23 Jun 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719151432; cv=none; b=cOddlQvv1pALTk6JHw3/eLYwdcIISkhKcpHvHCOsZJT0OY6zLVzdoSANnQ///a/zjPYQs9m3csn0sIjK/9IzKvhAU1zfPAPosCvXMg4sKaSAmje3d6kNwAm+IkBJ1WGsTXVkjU3ckTOarbyA7Zjx+VsJzUeALS0aHNsP559aYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719151432; c=relaxed/simple;
	bh=5E7qZTaLrptgMLPeZ2Zh9CU15YieUVahqfywkjpS59Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyJBGISKsatDcA6w+3t6SrEkZ1gXAR3nOd6Q/YdJSBimIVzwMuNi/FtGYYw470B0L7n2+tZQKTMx7ltxGJg6OR4oss0Y502cokqAzKOGf1W0cIRTfizQWOy9C1I0MalI50Y+48bKnhJuGwjswueJv6QUAAcOnoALuWBLJf/2Egs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDnFeY4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B071C2BD10;
	Sun, 23 Jun 2024 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719151432;
	bh=5E7qZTaLrptgMLPeZ2Zh9CU15YieUVahqfywkjpS59Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDnFeY4mEcrR1Q/FqMgrVcafIEjNh1XjCEjUHK4iRrbuYuNMk3/iXCNZDzSt3Ie52
	 fmgYzYs43mVg4j4SFH43W+1ewyWgLhkX09LgtKHQAaoESVpGbZr2R8FnwHujqMiNV2
	 3mJLFlqShnXIfKBEbZWHTVLuX8qjZz493oeAZqzxJLIZjzFUvopLhMuHtem7Do0eIg
	 2cT7hvS3/U0kvHhAfbTn4GxxZ0gBt/8GpCNfMU6HCoBOZODZcoYBBNnajrZEehmglG
	 OFPqqLwc1UtDJ/4w/bEC/+56qUZHWBNcGROUGHL1fN/mx2hm2cTfkoFAyCLKCij+1f
	 rgCv60upawnwQ==
Date: Sun, 23 Jun 2024 15:03:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240623-juror-ground-9a44d66a002b@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-5-kimseer.paller@analog.com>
 <20240619-vanity-crowd-24d93dda47b8@spud>
 <20240623144339.6a5087cf@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gotob1j8o7zv8sSA"
Content-Disposition: inline
In-Reply-To: <20240623144339.6a5087cf@jic23-huawei>


--Gotob1j8o7zv8sSA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 02:43:39PM +0100, Jonathan Cameron wrote:
> On Wed, 19 Jun 2024 18:57:59 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote:
> > > +patternProperties:
> > > +  "^channel@[0-4]$":
> > > +    type: object
> > > +    additionalProperties: false
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: The channel number representing the DAC output =
channel.
> > > +        maximum: 4
> > > +
> > > +      adi,toggle-mode:
> > > +        description:
> > > +          Set the channel as a toggle enabled channel. Toggle operat=
ion enables
> > > +          fast switching of a DAC output between two different DAC c=
odes without
> > > +          any SPI transaction.
> > > +        type: boolean
> > > +
> > > +      adi,output-range-microamp:
> > > +        description: Specify the channel output full scale range.
> > > +        enum: [3125000, 6250000, 12500000, 25000000, 50000000, 10000=
0000,
> > > +               200000000, 300000000] =20
> >=20
> > IIO folks, is this sort of thing common/likely to exist on other DACs?
>=20
> Fair point. It is probably time to conclude this is at least moderately c=
ommon
> and generalize it - which will need a dac.yaml similar to the one we have=
 for
> ADCs in adc/adc.yaml.  That will need to make this a per channel node
> property (same as the adc ones).

Looks like it is already per channel node?

> I'd also expect it to always take 2 values. In many cases the first will =
be 0
> but that is fine.

What would that first value represent?

--Gotob1j8o7zv8sSA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZngrQgAKCRB4tDGHoIJi
0islAPwLPnSI4CgCbvi/mHWsJtsyLxHJAa83f5STXzTBI2G1JAD/YXx3AOBRSAqa
jj+8CvnzWgNJVd9jsv4hhj2tqjbrrAM=
=/iLh
-----END PGP SIGNATURE-----

--Gotob1j8o7zv8sSA--

