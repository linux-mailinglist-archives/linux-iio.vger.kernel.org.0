Return-Path: <linux-iio+bounces-9538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE345979071
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D5282196
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A311CF2A3;
	Sat, 14 Sep 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcRILbhr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C3154BE0;
	Sat, 14 Sep 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726313139; cv=none; b=m7d5HOUjMPmmQad71AW1UgA6LwnLkVSUo45sQAWo/emsnitGxae8m19G8BbY0ScOnV62JXSMHuAMquDfERRbhWc8TEkSvWORSwK9u1ScksyiD+ZtiesOtYKA6IamV9uVPMeIv0ixWHsQQglrQfJBFU2oLKBr6YSGsnMVWb3UiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726313139; c=relaxed/simple;
	bh=GfS5z4KzP0QM7VZHYxwcQ8lO2YebsYDNdHBpezQQCUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghru4CUu6b3M7nZqnI8tz+xW7RQdHSS6tH4IOdkyWOjKVIWpPbTwgkopjs8mgh+6+ZIwgF+65ZsBHmfUOAtubsYiI01YpQi2vEcFczUYb6Vgw4QOa1PonkIh0QRexnskX601U+1jRH9nJgE/CYKSUVKAS3NVJfRJlF6Pz0kuC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcRILbhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457EFC4CEC0;
	Sat, 14 Sep 2024 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726313139;
	bh=GfS5z4KzP0QM7VZHYxwcQ8lO2YebsYDNdHBpezQQCUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VcRILbhrT6jeiCApcj5mJKsAwM3ZR30MkIBktUrd7O6JBrfVlSToIaxxqioAVoVTz
	 di8kmayl71aRQBRX3eo5fbwjdAw2KX02uQsH44x6YrCu5qe+4JqJp1gghNRPM4CUdH
	 v56+BxmAexD1DsDRNeMYW7OvudHLIZUfYwli3Qm0cMr/oUAXiemrPIiR8ndDYH1C0t
	 vQak+dznngURbTpqMhwhTlnIO8EaUC3JNb3rjpryFA1x2D5NZ30bD3tMlPNDBSS9Ch
	 8ee1Tg60JfPTLheLcpbkx5Urxjntq3Fcu4HgkwCMytc0Je2h5sseLyxqwr0J7kjYmf
	 YTRACQ6dQ9Mwg==
Date: Sat, 14 Sep 2024 12:25:29 +0100
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
Message-ID: <20240914122529.14759e63@jic23-huawei>
In-Reply-To: <84961c1f857dfc8498c41ac97235a037111ed6d5.camel@gmail.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	<20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
	<20240826102748.4be0b642@jic23-huawei>
	<D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
	<0a4e7fe39cf36774b28c86f6baab5ef8c20e3d6b.camel@gmail.com>
	<D4567LFFTYJQ.2YC5OODKOVPNB@baylibre.com>
	<84961c1f857dfc8498c41ac97235a037111ed6d5.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Sep 2024 15:46:17 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2024-09-13 at 12:55 +0000, Esteban Blanc wrote:
> > On Fri Sep 13, 2024 at 10:18 AM UTC, Nuno S=C3=A1 wrote: =20
> > > On Fri, 2024-09-13 at 09:55 +0000, Esteban Blanc wrote: =20
> > > > On Mon Aug 26, 2024 at 9:27 AM UTC, Jonathan Cameron wrote: =20
> > > > > On Thu, 22 Aug 2024 14:45:20 +0200
> > > > > Esteban Blanc <eblanc@baylibre.com> wrote: =20
> > > > > > +static const unsigned long ad4630_channel_masks[] =3D {
> > > > > > +	/* Differential only */
> > > > > > +	BIT(0) | BIT(2),
> > > > > > +	/* Differential with common byte */
> > > > > > +	GENMASK(3, 0), =20
> > > > > The packing of data isn't going to be good. How bad to shuffle
> > > > > to put the two small channels next to each other?
> > > > > Seems like it means you will want to combine your deinterleave
> > > > > and channel specific handling above, which is a bit fiddly but
> > > > > not much worse than current code. =20
> > > >=20
> > > > I can do it since that was what I had done in the RFC in the first =
place.
> > > > Nuno asked for in this email
> > > > https://lore.kernel.org/r/0036d44542f8cf45c91c867f0ddd7b45d1904d6b.=
camel@gmail.com/
> > > > :
> > > >  =20
> > > > > > > * You're pushing the CM channels into the end. So when we a 2=
 channel
> > > > > > > device
> > > > > > > we'll have: =20
> > > >  =20
> > > > > > > in_voltage0 - diff
> > > > > > > in_voltage1 - diff
> > > > > > > in_voltage2 - CM associated with chan0
> > > > > > > in_voltage0 - CM associated with chan1
> > > > > > >=20
> > > > > > > I think we could make it so the CM channel comes right after =
the channel
> > > > > > > where
> > > > > > > it's data belongs too. So for example, odd channels would be =
CM channels
> > > > > > > (and
> > > > > > > labels could also make sense). =20
> > > >=20
> > > > So that's what I did here :D
> > > >=20
> > > > For the software side off things here it doesn't change a lot of th=
ings
> > > > since we have to manipulate the data anyway, putting the extra byte=
 at the
> > > > end or in between is no extra work.
> > > > For the offload engine however, it should be easier to ask for 24 b=
its
> > > > then 8 bits for each channel as it would return two u32 per "hardwa=
re
> > > > channel".
> > > >=20
> > > > In order to avoid having two different layouts, I was kind of sold =
by
> > > > Nuno's idea of having the CM in between each diff channel.
> > > >  =20
> > >=20
> > > Tbh, I was not even thinking about the layout when I proposed the arr=
angement.
> > > Just
> > > made sense to me (from a logical point of view) to have them together=
 as they
> > > relate
> > > to the same physical channel. FWIW, we're also speaking bytes in here=
 so not sure
> > > if
> > > it's that important (or bad). =20
> >=20
> > The best we can do (if we managed to do it HDL wise) is to reorder the
> > data to get both CM byte in a single u32 after the 2 u32 of both diff
> > channel. That would be 3 u32 instead of 4.

Entirely up to you. :)
> >  =20
>=20
> We are starting to see more and more devices that do stuff like this. Hav=
e one
> physical channel that reflects in more than one IIO channel. For SW buffe=
ring it's
> not really a big deal but for HW buffering it's not ideal.=20
>=20
> I feel that at some point we should think about having a way to map a cha=
nnel scan
> element (being kind of a virtual scan element) into the storage_bits of a=
nother one.
> So in this case, one sample (for one channel) would be the 32bits and thi=
ngs should
> work the same either in SW or HW buffering.
>=20
> That said, it's probably easier said than done in practice :)

Yeah. That could get ugly fast + All existing userspace will fail to handle=
 it
so I'm not keen. Maybe it's doable if we assume the 'virtual channels' are =
all
meta data we don't mind loosing with existing software stacks and define
a non overlapping ABI to identify the metadata.  Still smells bad to me so
I'll take quite a bit of convincing!

Adding something to clearly 'associate' multiple related channels would be =
fine
as that wouldn't change the data interpretation, just provide more info on =
top.
Kind of a structured _label=20

Maybe a _channelgroup attribute?   Would be const and all the channels with
the same index would reflect that they were measured on same 'thing'.
Typically thing might be a pin or differential pair, but we might be measur=
ing
different types of signals - e.g. current and power.

Joanthan

>=20
> - Nuno S=C3=A1
>=20


