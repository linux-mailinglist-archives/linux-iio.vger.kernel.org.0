Return-Path: <linux-iio+bounces-9626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9092797AF9F
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FAE1F22DFB
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D485A165F0C;
	Tue, 17 Sep 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD5Ctc2I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AB14F10E;
	Tue, 17 Sep 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726572089; cv=none; b=QUx8DNduG7mIfhmxu/dAKhGTvIJ/dHCy4xmzu/htWwidmIkl27IMFXcX+smuZ/sFLsrQzDhiveiW6ErNoaOsBe71nuwowyhFFMOBwoxPNek/BI3p2H6U741BUBXy4CAPW4wZ4dgjO+6KejrtHTIYYUqlBMAzZeFVkzEdgc+hzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726572089; c=relaxed/simple;
	bh=wN/quzx53yxT8DLmO/UxxTHzRzSSJTQQ9ncoC/q8R9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9YDrtDQU1LF+ZwQvkIQvvA9uvsmd2vIF9tHoXmgIRcABz32CKNZ9EH8elVllmySU8YMA4kDTVHAe63XTf4wURZntZWJCEF285CkOp1GTpqFbr7gm4niBbtwH3DfJxmpZiscfq0oDmLW958AQH/xHrrrww8hdqVjJwjIicPG93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD5Ctc2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13A9C4CECE;
	Tue, 17 Sep 2024 11:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726572088;
	bh=wN/quzx53yxT8DLmO/UxxTHzRzSSJTQQ9ncoC/q8R9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mD5Ctc2IAvRmr7CQfVvwy7+fhgl+Uvwm9kArohzcSxA+yVpzyDE2blTDzYs0RuV5Q
	 bmRSudhhtcA38VOZmygxXZVWacgYFcCF6yyXuuQdrQGvAUjK/NxOYEbbb9uiTok5EU
	 +T0jdLwqYu6QGlhkJblJgq1z+LklH0JoznwgdRclaE9NfNOIXBuLlRLcLf7bAbcdHx
	 6cd6U633PVM2ERQgZYI0t5DL3c7VBQrudunhnbs4zdGrFzdoAXIkoMVkplNSRceLni
	 XkuTObDUw8DshhyaPoSnixs6mbCZbAsOlTw0EK4XqYRKzQdVJ5CLoEpXtF5zCdN0Qm
	 3oyGguB3/PxQQ==
Date: Tue, 17 Sep 2024 12:21:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Esteban Blanc" <eblanc@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Nuno Sa" <nuno.sa@analog.com>,
 "Jonathan Corbet" <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
Message-ID: <20240917122115.02234530@jic23-huawei>
In-Reply-To: <D47LHT5XPYTX.3OWFQR9N23FZH@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	<20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
	<20240826102748.4be0b642@jic23-huawei>
	<D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
	<0a4e7fe39cf36774b28c86f6baab5ef8c20e3d6b.camel@gmail.com>
	<D4567LFFTYJQ.2YC5OODKOVPNB@baylibre.com>
	<84961c1f857dfc8498c41ac97235a037111ed6d5.camel@gmail.com>
	<20240914122529.14759e63@jic23-huawei>
	<D47LHT5XPYTX.3OWFQR9N23FZH@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Sep 2024 09:19:02 +0000
"Esteban Blanc" <eblanc@baylibre.com> wrote:

> On Sat Sep 14, 2024 at 11:25 AM UTC, Jonathan Cameron wrote:
> > On Fri, 13 Sep 2024 15:46:17 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > =20
> > > On Fri, 2024-09-13 at 12:55 +0000, Esteban Blanc wrote: =20
> > > > On Fri Sep 13, 2024 at 10:18 AM UTC, Nuno S=C3=A1 wrote:   =20
> > > > > On Fri, 2024-09-13 at 09:55 +0000, Esteban Blanc wrote:   =20
> > > > > > On Mon Aug 26, 2024 at 9:27 AM UTC, Jonathan Cameron wrote:   =
=20
> > > > > > > On Thu, 22 Aug 2024 14:45:20 +0200
> > > > > > > Esteban Blanc <eblanc@baylibre.com> wrote:   =20
> > > > > > > > +static const unsigned long ad4630_channel_masks[] =3D {
> > > > > > > > +	/* Differential only */
> > > > > > > > +	BIT(0) | BIT(2),
> > > > > > > > +	/* Differential with common byte */
> > > > > > > > +	GENMASK(3, 0),   =20
> > > > > > > The packing of data isn't going to be good. How bad to shuffle
> > > > > > > to put the two small channels next to each other?
> > > > > > > Seems like it means you will want to combine your deinterleave
> > > > > > > and channel specific handling above, which is a bit fiddly but
> > > > > > > not much worse than current code.   =20
> > > > > >=20
> > > > > > I can do it since that was what I had done in the RFC in the fi=
rst place.
> > > > > > Nuno asked for in this email
> > > > > > https://lore.kernel.org/r/0036d44542f8cf45c91c867f0ddd7b45d1904=
d6b.camel@gmail.com/
> > > > > > :
> > > > > >    =20
> > > > > > > > > * You're pushing the CM channels into the end. So when we=
 a 2 channel
> > > > > > > > > device
> > > > > > > > > we'll have:   =20
> > > > > >    =20
> > > > > > > > > in_voltage0 - diff
> > > > > > > > > in_voltage1 - diff
> > > > > > > > > in_voltage2 - CM associated with chan0
> > > > > > > > > in_voltage0 - CM associated with chan1
> > > > > > > > >=20
> > > > > > > > > I think we could make it so the CM channel comes right af=
ter the channel
> > > > > > > > > where
> > > > > > > > > it's data belongs too. So for example, odd channels would=
 be CM channels
> > > > > > > > > (and
> > > > > > > > > labels could also make sense).   =20
> > > > > >=20
> > > > > > So that's what I did here :D
> > > > > >=20
> > > > > > For the software side off things here it doesn't change a lot o=
f things
> > > > > > since we have to manipulate the data anyway, putting the extra =
byte at the
> > > > > > end or in between is no extra work.
> > > > > > For the offload engine however, it should be easier to ask for =
24 bits
> > > > > > then 8 bits for each channel as it would return two u32 per "ha=
rdware
> > > > > > channel".
> > > > > >=20
> > > > > > In order to avoid having two different layouts, I was kind of s=
old by
> > > > > > Nuno's idea of having the CM in between each diff channel.
> > > > > >    =20
> > > > >=20
> > > > > Tbh, I was not even thinking about the layout when I proposed the=
 arrangement.
> > > > > Just
> > > > > made sense to me (from a logical point of view) to have them toge=
ther as they
> > > > > relate
> > > > > to the same physical channel. FWIW, we're also speaking bytes in =
here so not sure
> > > > > if
> > > > > it's that important (or bad).   =20
> > > >=20
> > > > The best we can do (if we managed to do it HDL wise) is to reorder =
the
> > > > data to get both CM byte in a single u32 after the 2 u32 of both di=
ff
> > > > channel. That would be 3 u32 instead of 4. =20
> >
> > Entirely up to you. :) =20
>=20
> Ok so here is the plan I propose:
>  1. Use the layout of this patch (common byte channels just after their
>  respective diff channel) as it should work out of the box for the offload
>  engine (once it's merged [1]).
>  2. In case of performance issue, switch to the RFC layout (both diff
>  channels then both common byte channels) and try to modify the HDL for
>  the offload engine to reduce the memory footprint by one byte for the 2
>  hardware channels case.
It's a bit of a risk as you might get someone making too many assumptions a=
bout
channel ordering in some specific purpose code - at that point this change
is an ABI break that someone noticed.

So I'd guess we'll stay with 1 for ever which is find.

Jonathan


>=20
> [1]: https://lore.kernel.org/lkml/20240722-dlech-mainline-spi-engine-offl=
oad-2-v3-0-7420e45df69b@baylibre.com/
>=20
> Best regards,
>=20


