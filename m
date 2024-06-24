Return-Path: <linux-iio+bounces-6824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34E29154E8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317C61C22664
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC7019E7FD;
	Mon, 24 Jun 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQASADSP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7619AD75;
	Mon, 24 Jun 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248430; cv=none; b=CumESBYPhCwJ3GV12IRJrkCTy/BRgINIeG20Z44wcgt4oFr5/D7BCQzzMmXsDny4ZgAeyxEeIT3VWduM/vhgid0vqQ2yMEl1gNwi0B3BUXtD1VJI0OvrYbS+SjzGLVt/o4SQ6NrcPJ1Ptd4Zy8Yxn/PduSShxirPro408w8WaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248430; c=relaxed/simple;
	bh=EB2Vu1uZ3PbGJZtLzuNrFlJTZIHyzcLAaz9VPoAVtYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkW36fPNFI4trL0sSKg4RS/dmgiD5qvpwtLW6GoGs5XUK8kY/Fk7Eh1wzGDFZOerFQqKnwyOPCquLO8bVnbY4V+PcwLH87GPfUnfLP/RUXNxfgRr1OnxNT9e0O6zOjS6kD4/9qWEgrvQ8oG99iJFYneEh9ljcDJlLmowa970yO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQASADSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E84C2BBFC;
	Mon, 24 Jun 2024 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719248430;
	bh=EB2Vu1uZ3PbGJZtLzuNrFlJTZIHyzcLAaz9VPoAVtYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQASADSPlVYuf64HpQV4/aJlbDXT+VGeIu1zEjfmkLhcG+oDJODI4mf/RMcFqK98y
	 71XgOd8KlGtZLNUXa0+OhkCe2bFoB4xOYLuZvXGRFsMoufHGN4qpt4yeOT3rDQHapv
	 ZhYNX4/DlJxIAmShCio2BzNm7NHd0ZwsyL7BGKnvDO3h2pgA6tKxN+8kbjvHddExqp
	 Lp2p98eU5b4zS7eCx969eGBdFgY4Rg9ZpwT+lzCpLH02LWDe6/PcF2ecQlRBz1o8nP
	 DyYBc3h5B6KdVOII9h6ebF7PgQtIVrEwM0CBtWlUitzpQN0SakD02iiup+MShrcVPq
	 bFHPzvxp9jvLQ==
Date: Mon, 24 Jun 2024 18:00:24 +0100
From: Conor Dooley <conor@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <20240624-untracked-molasses-31e8769dddd3@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
 <20240619064904.73832-5-kimseer.paller@analog.com>
 <20240619-vanity-crowd-24d93dda47b8@spud>
 <20240623144339.6a5087cf@jic23-huawei>
 <PH0PR03MB71419D55571B07479B4F4FB8F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BsG0Zvx10wXMJvsJ"
Content-Disposition: inline
In-Reply-To: <PH0PR03MB71419D55571B07479B4F4FB8F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>


--BsG0Zvx10wXMJvsJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 03:26:26PM +0000, Paller, Kim Seer wrote:
>=20
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, June 23, 2024 9:44 PM
> > To: Conor Dooley <conor@kernel.org>
> > Cc: Paller, Kim Seer <KimSeer.Paller@analog.com>; linux-
> > kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kern=
el.org;
> > David Lechner <dlechner@baylibre.com>; Lars-Peter Clausen
> > <lars@metafoo.de>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> > <broonie@kernel.org>; Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof
> > Kozlowski <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor
> > Dooley <conor+dt@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> > Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
> >=20
> > [External]
> >=20
> > On Wed, 19 Jun 2024 18:57:59 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >=20
> > > On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote:
> > > > +patternProperties:
> > > > +  "^channel@[0-4]$":
> > > > +    type: object
> > > > +    additionalProperties: false
> > > > +
> > > > +    properties:
> > > > +      reg:
> > > > +        description: The channel number representing the DAC output
> > channel.
> > > > +        maximum: 4
> > > > +
> > > > +      adi,toggle-mode:
> > > > +        description:
> > > > +          Set the channel as a toggle enabled channel. Toggle oper=
ation
> > enables
> > > > +          fast switching of a DAC output between two different DAC=
 codes
> > without
> > > > +          any SPI transaction.
> > > > +        type: boolean
> > > > +
> > > > +      adi,output-range-microamp:
> > > > +        description: Specify the channel output full scale range.
> > > > +        enum: [3125000, 6250000, 12500000, 25000000, 50000000,
> > 100000000,
> > > > +               200000000, 300000000]
> > >
> > > IIO folks, is this sort of thing common/likely to exist on other DACs?
> >=20
> > Fair point. It is probably time to conclude this is at least moderately=
 common
> > and generalize it - which will need a dac.yaml similar to the one we ha=
ve for
> > ADCs in adc/adc.yaml.  That will need to make this a per channel node p=
roperty
> > (same as the adc ones).
>=20
> Should I proceed with generalizing common DAC properties in this series a=
nd does

I think so, yes.

> this mean somehow removing these common properties from existing DAC bind=
ings?

I think that that one is up to Jonathan.

> > I'd also expect it to always take 2 values. In many cases the first wil=
l be 0 but
> > that is fine.
> >=20
> > Jonathan
>=20

--BsG0Zvx10wXMJvsJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmmKAAKCRB4tDGHoIJi
0rTAAQDRMrnRi4oNL/zjW/21PNfWpzyX3vPvb4XBtLhQ6CB3MAD9HwLwK7stijFd
XKOBCouTp5hoYMUd6fTkOxiInssLlAI=
=WSk1
-----END PGP SIGNATURE-----

--BsG0Zvx10wXMJvsJ--

