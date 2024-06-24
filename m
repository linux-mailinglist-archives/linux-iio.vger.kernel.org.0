Return-Path: <linux-iio+bounces-6828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF1915581
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C658B22211
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705F19EEDA;
	Mon, 24 Jun 2024 17:38:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B45FC08;
	Mon, 24 Jun 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250680; cv=none; b=Nwuma+y/j/qQXlli4m7419GP8XRhJxu2dgACyM/pfiDNKm+EWzsZxOVmaKAU3IkG7G4lBFa6rnC2iaJPy83JY9UID831/7bLrG5fIg2bpQ3JqMYh9TQnjVXsh9kxeEop3LtFCvbjgrym43KmU4qgQ8LYbzvmRUAbDuF/PfEKgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250680; c=relaxed/simple;
	bh=hKek7vAN+H1Rl0A+SO7nDTHqRgCZcC5LuCBveazv6cc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LArhbQqBmR5ky330xOEmjgrJuGJi+GTu2Eh72gs4WGOB5wymusr9o9DgRjJIJ/lteWksDh9C1NmeqkyBZqareQrBvUz8Jdn/trCM/wzDBAvFMLdWR9bajyq+0/GkmaKZzdqG4YzHCBf3DUJWzu7ptRmq4wZ5dQab18vnSqzq9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W7FXG15BPz6K6KJ;
	Tue, 25 Jun 2024 01:37:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F8E8140A70;
	Tue, 25 Jun 2024 01:37:54 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 18:37:53 +0100
Date: Mon, 24 Jun 2024 18:37:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Conor Dooley <conor@kernel.org>
CC: "Paller, Kim Seer" <KimSeer.Paller@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "Hennerich, Michael"
	<Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<noname.nuno@gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240624183753.0000218c@Huawei.com>
In-Reply-To: <20240624-untracked-molasses-31e8769dddd3@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
	<20240619064904.73832-5-kimseer.paller@analog.com>
	<20240619-vanity-crowd-24d93dda47b8@spud>
	<20240623144339.6a5087cf@jic23-huawei>
	<PH0PR03MB71419D55571B07479B4F4FB8F9D42@PH0PR03MB7141.namprd03.prod.outlook.com>
	<20240624-untracked-molasses-31e8769dddd3@spud>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 18:00:24 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Jun 24, 2024 at 03:26:26PM +0000, Paller, Kim Seer wrote:
> >=20
> >  =20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, June 23, 2024 9:44 PM
> > > To: Conor Dooley <conor@kernel.org>
> > > Cc: Paller, Kim Seer <KimSeer.Paller@analog.com>; linux-
> > > kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vger.ke=
rnel.org;
> > > David Lechner <dlechner@baylibre.com>; Lars-Peter Clausen
> > > <lars@metafoo.de>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> > > <broonie@kernel.org>; Dimitri Fedrau <dima.fedrau@gmail.com>; Krzyszt=
of
> > > Kozlowski <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor
> > > Dooley <conor+dt@kernel.org>; Hennerich, Michael
> > > <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> > > Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.ya=
ml
> > >=20
> > > [External]
> > >=20
> > > On Wed, 19 Jun 2024 18:57:59 +0100
> > > Conor Dooley <conor@kernel.org> wrote:
> > >  =20
> > > > On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote: =20
> > > > > +patternProperties:
> > > > > +  "^channel@[0-4]$":
> > > > > +    type: object
> > > > > +    additionalProperties: false
> > > > > +
> > > > > +    properties:
> > > > > +      reg:
> > > > > +        description: The channel number representing the DAC out=
put =20
> > > channel. =20
> > > > > +        maximum: 4
> > > > > +
> > > > > +      adi,toggle-mode:
> > > > > +        description:
> > > > > +          Set the channel as a toggle enabled channel. Toggle op=
eration =20
> > > enables =20
> > > > > +          fast switching of a DAC output between two different D=
AC codes =20
> > > without =20
> > > > > +          any SPI transaction.
> > > > > +        type: boolean
> > > > > +
> > > > > +      adi,output-range-microamp:
> > > > > +        description: Specify the channel output full scale range.
> > > > > +        enum: [3125000, 6250000, 12500000, 25000000, 50000000, =
=20
> > > 100000000, =20
> > > > > +               200000000, 300000000] =20
> > > >
> > > > IIO folks, is this sort of thing common/likely to exist on other DA=
Cs? =20
> > >=20
> > > Fair point. It is probably time to conclude this is at least moderate=
ly common
> > > and generalize it - which will need a dac.yaml similar to the one we =
have for
> > > ADCs in adc/adc.yaml.  That will need to make this a per channel node=
 property
> > > (same as the adc ones). =20
> >=20
> > Should I proceed with generalizing common DAC properties in this series=
 and does =20
>=20
> I think so, yes.

Yes, that would great.

>=20
> > this mean somehow removing these common properties from existing DAC bi=
ndings? =20
>=20
> I think that that one is up to Jonathan.

We can deprecate them.  At somepoint we can remove them form the documented=
 bindings
but we will need to keep them in drivers forever (which won't be costly in =
this case).

Jonathan

>=20
> > > I'd also expect it to always take 2 values. In many cases the first w=
ill be 0 but
> > > that is fine.
> > >=20
> > > Jonathan =20
> >  =20
>=20


