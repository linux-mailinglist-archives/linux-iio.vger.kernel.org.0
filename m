Return-Path: <linux-iio+bounces-17344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E0EA75A92
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05EE1886A53
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8111C5F39;
	Sun, 30 Mar 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFEzN1Gi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D146B5;
	Sun, 30 Mar 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743347950; cv=none; b=BQvI+ncZ7RH5emYizxK8cgf60aL8zB50B/VZOMc7Lp7+YNBMPR3FIiXBqijE8hSyN+P/YbG3+t/o8I6/ZXoS3vQ0X5NyXPBd9XpkpfNq3AQZZ8iXOAavclwdCjcW/riqkQOSqT/xF47EKUTaOo/VagB/n0aIw2vNfs4nUxjhsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743347950; c=relaxed/simple;
	bh=wWJH4qthvkKah4YoqMVuhDK4KUnv3vBmdbn04K2tkuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbd6gY5NmeblS7Coeaw8QPd+u6Z6y6Ah7E5F62ZF2n2u4c/vGNMM/rU9oRY9EuOKeUEAN2vhUbd1v2oMDMb7daVaweBt7ccpkOIbq2h/Vgq0APQS373JSuZpSSjPAukY3j5PfGEzaJiiddE9Z4amZPzySzhhcBhZtIT9N8ji4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFEzN1Gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD169C4CEDD;
	Sun, 30 Mar 2025 15:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743347949;
	bh=wWJH4qthvkKah4YoqMVuhDK4KUnv3vBmdbn04K2tkuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tFEzN1GiLSrwOpa2ZB8BO622EMiTuDYsB1EePUfU13nl3uuEWDnhcIo+znFBIcRRo
	 oAVVSjbIgmu5LkJcT3CTZ4vzrhNDCH2aV9jd15vzOWryZNnWOFyank4RoRZ7xw0IuU
	 +iY4rws1AapbwFqaSkZ5E+3ipli6w8YRWUAHzgUHR+dQMIkJJvAXzjAuVWLv9T/8r+
	 P+cupzIjtdJZK1+2fALxFRfn4lj8J7Zg+zBnf/fewgut+xSQh2Cxb6xLv7B34oWPZi
	 HIU6PHQFaC+sO978kccFkxh4Rrkmku4IFI6h5/x3v0+wyAdI2r2XQJ2X85kWZgywIi
	 KYJAO9N+io/sg==
Date: Tue, 17 Sep 2024 12:19:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Esteban Blanc <eblanc@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
Message-ID: <20240917121920.75e7edba@jic23-huawei>
In-Reply-To: <2b319d9453f4fe8842e4c306d9e2071ad031c0e7.camel@gmail.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	<20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
	<20240826102748.4be0b642@jic23-huawei>
	<D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
	<0a4e7fe39cf36774b28c86f6baab5ef8c20e3d6b.camel@gmail.com>
	<D4567LFFTYJQ.2YC5OODKOVPNB@baylibre.com>
	<84961c1f857dfc8498c41ac97235a037111ed6d5.camel@gmail.com>
	<20240914122529.14759e63@jic23-huawei>
	<2b319d9453f4fe8842e4c306d9e2071ad031c0e7.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Sep 2024 08:12:24 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-09-14 at 12:25 +0100, Jonathan Cameron wrote:
> > On Fri, 13 Sep 2024 15:46:17 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Fri, 2024-09-13 at 12:55 +0000, Esteban Blanc wrote: =20
> > > > On Fri Sep 13, 2024 at 10:18 AM UTC, Nuno S=C3=A1 wrote:=C2=A0  =20
> > > > > On Fri, 2024-09-13 at 09:55 +0000, Esteban Blanc wrote:=C2=A0  =20
> > > > > > On Mon Aug 26, 2024 at 9:27 AM UTC, Jonathan Cameron wrote:=C2=
=A0  =20
> > > > > > > On Thu, 22 Aug 2024 14:45:20 +0200
> > > > > > > Esteban Blanc <eblanc@baylibre.com> wrote:=C2=A0  =20
> > > > > > > > +static const unsigned long ad4630_channel_masks[] =3D {
> > > > > > > > +	/* Differential only */
> > > > > > > > +	BIT(0) | BIT(2),
> > > > > > > > +	/* Differential with common byte */
> > > > > > > > +	GENMASK(3, 0),=C2=A0  =20
> > > > > > > The packing of data isn't going to be good. How bad to shuffle
> > > > > > > to put the two small channels next to each other?
> > > > > > > Seems like it means you will want to combine your deinterleave
> > > > > > > and channel specific handling above, which is a bit fiddly but
> > > > > > > not much worse than current code.=C2=A0  =20
> > > > > >=20
> > > > > > I can do it since that was what I had done in the RFC in the fi=
rst place.
> > > > > > Nuno asked for in this email
> > > > > > https://lore.kernel.org/r/0036d44542f8cf45c91c867f0ddd7b45d1904=
d6b.camel@gmail.com/
> > > > > > :
> > > > > > =C2=A0  =20
> > > > > > > > > * You're pushing the CM channels into the end. So when we=
 a 2 channel
> > > > > > > > > device
> > > > > > > > > we'll have:=C2=A0  =20
> > > > > > =C2=A0  =20
> > > > > > > > > in_voltage0 - diff
> > > > > > > > > in_voltage1 - diff
> > > > > > > > > in_voltage2 - CM associated with chan0
> > > > > > > > > in_voltage0 - CM associated with chan1
> > > > > > > > >=20
> > > > > > > > > I think we could make it so the CM channel comes right af=
ter the
> > > > > > > > > channel
> > > > > > > > > where
> > > > > > > > > it's data belongs too. So for example, odd channels would=
 be CM
> > > > > > > > > channels
> > > > > > > > > (and
> > > > > > > > > labels could also make sense).=C2=A0  =20
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
> > > > > > =C2=A0  =20
> > > > >=20
> > > > > Tbh, I was not even thinking about the layout when I proposed the
> > > > > arrangement.
> > > > > Just
> > > > > made sense to me (from a logical point of view) to have them toge=
ther as they
> > > > > relate
> > > > > to the same physical channel. FWIW, we're also speaking bytes in =
here so not
> > > > > sure
> > > > > if
> > > > > it's that important (or bad).=C2=A0  =20
> > > >=20
> > > > The best we can do (if we managed to do it HDL wise) is to reorder =
the
> > > > data to get both CM byte in a single u32 after the 2 u32 of both di=
ff
> > > > channel. That would be 3 u32 instead of 4. =20
> >=20
> > Entirely up to you. :) =20
> > > > =C2=A0  =20
> > >=20
> > > We are starting to see more and more devices that do stuff like this.=
 Have one
> > > physical channel that reflects in more than one IIO channel. For SW b=
uffering
> > > it's
> > > not really a big deal but for HW buffering it's not ideal.=20
> > >=20
> > > I feel that at some point we should think about having a way to map a=
 channel
> > > scan
> > > element (being kind of a virtual scan element) into the storage_bits =
of another
> > > one.
> > > So in this case, one sample (for one channel) would be the 32bits and=
 things
> > > should
> > > work the same either in SW or HW buffering.
> > >=20
> > > That said, it's probably easier said than done in practice :) =20
> >=20
> > Yeah. That could get ugly fast + All existing userspace will fail to ha=
ndle it
> > so I'm not keen. Maybe it's doable if we assume the 'virtual channels' =
are all
> > meta data we don't mind loosing with existing software stacks and define
> > a non overlapping ABI to identify the metadata.=C2=A0 Still smells bad =
to me so
> > I'll take quite a bit of convincing! =20
>=20
> Naturally it would have to be done in a way that drivers not defining the=
 "special"
> scan elements would not be affected.

It's worse than that - it would need be defined so userspace running
against the devices with the special channels would have to work without
knowing anything about them. So we couldn't do the really nasty thing
of setting scan_index the same for both of them with same storage size and
different shifts and real_bits.  That would be the sort of things that might
crash userspace code.

Driver effects are less of an issue than ABI breakage - or even just
ABI a userspace author would not expect.

>=20
> >=20
> > Adding something to clearly 'associate' multiple related channels would=
 be fine
> > as that wouldn't change the data interpretation, just provide more info=
 on top.
> > Kind of a structured _label=20
> >=20
> > Maybe a _channelgroup attribute?=C2=A0=C2=A0 Would be const and all the=
 channels with
> > the same index would reflect that they were measured on same 'thing'.
> > Typically thing might be a pin or differential pair, but we might be me=
asuring
> > different types of signals - e.g. current and power.
> >  =20
>=20
> Sounds reasonable but I think the tricky part is always to have a sane wa=
y of saying
> that multiple scan elements relate to just one storage_bits so we could s=
ay something
> like (taking this as example):
>=20
> scan0: //diff channel which describing the physical HW in terms of real s=
ize
>  .storage_bits =3D 32
>  .real_bits =3D 24
>  .shift =3D 8
>=20
> scan1: //CM data
>  //.storage - relates to scan0 so should add nothing to the sample size i=
f both
> enabled
>  .real_bits =3D 8
>=20
Indeed - I get the concept, but don't like it.=20
In general it's a dead end for general purpose channels - because of that
pile of legacy userspace.  It 'might' just about be acceptable for 'meta da=
ta' channels
or where we are adding significant new interface for functionality purposes=
 (e.g.
when we did the newer DMA buffer stuff).

> Likely not what you meant but one thing I took from your '_channelgroup' =
idea was to
> have something similar to extended_info maybe with a small top level desc=
ription and
> then an array of channels (that would form the group/aggregated channel).=
 Only on the
> top level description we would be allowed to define the size of the scan =
element (in
> case of buffering). Still seems tricky to me :).

Yeah.  The channel group thing was for normal naturally aligned packing, not
data backed tighter than that.

>=20
> Anyways, Right now, I have no time for something like this but eventually=
 would like
> to try something. But if someone wants to propose something sooner, pleas=
e :)

*looks doubtful*  Maybe I can be convinced.  We'll see.

Jonathan
>=20
> - Nuno S=C3=A1=20
>=20


