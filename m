Return-Path: <linux-iio+bounces-6912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5176F916DE2
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 18:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824FB1C216E7
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51AC171E5E;
	Tue, 25 Jun 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm+diwmZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007E16D323;
	Tue, 25 Jun 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332455; cv=none; b=XR+rwWX8zfk2i5UY28dEFft96oAIQQJJDDvkzEQvwrjRHt7fejTcGDrTbZu3M3jXXI28m42dxlIStHLKmyXgIzgNs0iIJvKX4+nLmaeEfza9PGKlCZdbaCvNgEdxqf6shUsueDrdgK1YPLSkJyO6HHcjWm3wYPulzotyDNy9tVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332455; c=relaxed/simple;
	bh=LpzZBc0Vbc4k/sUuPmQjYLw1XjhqksxL+PGKPl7fiH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/Ic04EokdK2i0L+hIqdUhoeP+cbm+s6U1nDXlujWnclWPMT9kUGmOCz1pEjAFsWEmUifaQfvL2j5NVhoEb15i86OlgOyyoLXjwdNVwJi7mxxM5nbEIP6UxZinIJLjKcGUR0caDYfivsrqinp65GYPB58ucPrZeXak7lxkucejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm+diwmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71CAC32781;
	Tue, 25 Jun 2024 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332455;
	bh=LpzZBc0Vbc4k/sUuPmQjYLw1XjhqksxL+PGKPl7fiH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rm+diwmZk1a1eMHbHnZhX7U+VOLGrqb6BTLh2my9XC0EMVzE7jA9Nmz/Ql3Li/1dL
	 vu2SOlF3Yv6NLptdQpUOoRaaD3wzaYcmXaczdH1V9T0nAk+GgB6git4TjvRp1FACML
	 iCgpKonofGmKg1yBDa3YUR2vRDU6oy0v1eE5E7VsQPkDxRX5nk153I9psdVyv/yAYD
	 laziq/HDex+u8LyQLiEb26y2Ij0ggcSsAZpEzHAWSynI99g3EpSAjpOZWod/brQdqU
	 UDAFi0D78sRQqQ5xQC9bB1VOPOTv8iX/Q7zv8N26JyCVKkNXmclugSpq3ntCj+kSSw
	 A4xpskjB7J91g==
Date: Tue, 25 Jun 2024 17:20:48 +0100
From: Conor Dooley <conor@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240625-roster-umbrella-3782caa23791@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-5-kimseer.paller@analog.com>
 <20240619-vanity-crowd-24d93dda47b8@spud>
 <20240623144339.6a5087cf@jic23-huawei>
 <PH0PR03MB71419D55571B07479B4F4FB8F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
 <20240624-untracked-molasses-31e8769dddd3@spud>
 <20240624183753.0000218c@Huawei.com>
 <PH0PR03MB7141EE1309B35372201A6A80F9D52@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C1hbkhA2YA3Pd8xN"
Content-Disposition: inline
In-Reply-To: <PH0PR03MB7141EE1309B35372201A6A80F9D52@PH0PR03MB7141.namprd03.prod.outlook.com>


--C1hbkhA2YA3Pd8xN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 03:51:27PM +0000, Paller, Kim Seer wrote:
>=20
>=20
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>

> > On Mon, 24 Jun 2024 18:00:24 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >=20
> > > On Mon, Jun 24, 2024 at 03:26:26PM +0000, Paller, Kim Seer wrote:
> > > >
> > > >
> > > > > From: Jonathan Cameron <jic23@kernel.org>

> > > > > Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc267=
2.yaml
> > > > >
> > > > >
> > > > > On Wed, 19 Jun 2024 18:57:59 +0100
> > > > > Conor Dooley <conor@kernel.org> wrote:
> > > > >
> > > > > > On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote:
> > > > > > > +patternProperties:
> > > > > > > +  "^channel@[0-4]$":
> > > > > > > +    type: object
> > > > > > > +    additionalProperties: false
> > > > > > > +
> > > > > > > +    properties:
> > > > > > > +      reg:
> > > > > > > +        description: The channel number representing the DAC=
 output
> > > > > channel.
> > > > > > > +        maximum: 4
> > > > > > > +
> > > > > > > +      adi,toggle-mode:
> > > > > > > +        description:
> > > > > > > +          Set the channel as a toggle enabled channel. Toggl=
e operation
> > > > > enables
> > > > > > > +          fast switching of a DAC output between two differe=
nt DAC
> > codes
> > > > > without
> > > > > > > +          any SPI transaction.
> > > > > > > +        type: boolean
> > > > > > > +
> > > > > > > +      adi,output-range-microamp:
> > > > > > > +        description: Specify the channel output full scale r=
ange.
> > > > > > > +        enum: [3125000, 6250000, 12500000, 25000000, 5000000=
0,
> > > > > 100000000,
> > > > > > > +               200000000, 300000000]
> > > > > >
> > > > > > IIO folks, is this sort of thing common/likely to exist on othe=
r DACs?
> > > > >
> > > > > Fair point. It is probably time to conclude this is at least mode=
rately
> > common
> > > > > and generalize it - which will need a dac.yaml similar to the one=
 we have
> > for
> > > > > ADCs in adc/adc.yaml.  That will need to make this a per channel =
node
> > property
> > > > > (same as the adc ones).
> > > >
> > > > Should I proceed with generalizing common DAC properties in this se=
ries
> > and does
> > >
> > > I think so, yes.
> >=20
> > Yes, that would great.
>=20
> I was wondering who would be the designated maintainer for new dac.yaml?

I'd suggest Jonathan!

> > > > this mean somehow removing these common properties from existing DAC
> > bindings?
> > >
> > > I think that that one is up to Jonathan.
> >=20
> > We can deprecate them.  At somepoint we can remove them form the
> > documented bindings
> > but we will need to keep them in drivers forever (which won't be costly=
 in this
> > case).

Right. Anything where the name _would change_ needs to be deprecated and
kept forever. I was thinking more about properties that are defined in
multiple locations with the same name, e.g. if "output-range-microvolts"
existed in 6 different bindings.

Thanks,
Conor.

--C1hbkhA2YA3Pd8xN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnruYAAKCRB4tDGHoIJi
0vtCAP9y2KE27dN0FKcsOTqmU5ZWlS2UqExFZA7jFfaFniMJVQEArwWLy19ph2fg
/pL7HeG2W9LLM68Mkja9Fh13ppgBSQw=
=hDLH
-----END PGP SIGNATURE-----

--C1hbkhA2YA3Pd8xN--

