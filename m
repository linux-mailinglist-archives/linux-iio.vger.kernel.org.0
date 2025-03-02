Return-Path: <linux-iio+bounces-16223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A5A4AF0A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 04:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9593B0EBA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2519F1487DD;
	Sun,  2 Mar 2025 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncDCdnwR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CA23F383;
	Sun,  2 Mar 2025 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740885677; cv=none; b=svsvCs+MgE8/DLCgoRj3YlR2sZyPlpKvqLNl2Sxjz/a72lXjw6YdDQHXq4/iOyYE0vOGq18G43fq/AC4ubqp1Mo7V6mX82isdH+NW0asmnFLJrR2Z54McdlkIlAomD/GZLxcqDKImhyI6t3q5myCcmZt1SBQEt/mpRC/qEFKqgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740885677; c=relaxed/simple;
	bh=O/MA92hB3AkjNrf7z/VXmgx/ltMRoX0rGgcUffwbu9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djELSwm/4jimIydtGGeKxFBKeLoA3CINinK0XicypcpRCw18/pK7dHWEVQSkZ29LlhaXXQMEU6PyoJIdEArd8ZgdhOdneQsCrML+m4X/7QT7NlxViKZxSN35cHI6cxzz9IDTZ1/4QAXmbSeAPTSHBV3u/6XlPGtZgd/xpfr2ezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncDCdnwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AB1C4CEE2;
	Sun,  2 Mar 2025 03:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740885677;
	bh=O/MA92hB3AkjNrf7z/VXmgx/ltMRoX0rGgcUffwbu9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ncDCdnwRP5zOoDVILCciSwRQ/NSzgjHe27I7RjLy7tc5fZcfBKv8Ywn00WK3+9j4L
	 A0zD0DXY+mB8HLZHFzIX7EYJ0hk+vFxDvMu7kRJ4/U6B9iIzalpTDSJhHFc6oYM3Je
	 sq5FyrzZtBi8FZzJxgibZCmcDLgs5Kidhk1tKF4A0JksvqLe5AyVCvY1XdE6imIPrJ
	 y08Teu/YAMhRIG0C2fR8xei8nl5sEPNmivs7U2N+KXxmyGIp7RNNgdtf0kBQTEjb1h
	 +ZqQV/992sV7KnJ8QupGmjA+vHzYfrqBuM18zz/KSraEa6Fuffn2CE3SeQgzHur7NK
	 uQOY4iTFo0Lkg==
Date: Sun, 2 Mar 2025 03:20:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa
 <nuno.sa@analog.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <20250302032054.1fb8a011@jic23-huawei>
In-Reply-To: <9180ff11-888b-453d-9617-4b3a0fb38d91@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
	<23f5ee3e3bf7179930d66c720d5c4c33cdbe8366.1740421248.git.mazziesaccount@gmail.com>
	<0de7b0ac-eca5-49ba-b1b3-f249655f3646@baylibre.com>
	<1b308a10-9622-47f9-b489-bd969fbdfc34@gmail.com>
	<6f6e6550-5246-476f-9168-5e24151ab165@baylibre.com>
	<9180ff11-888b-453d-9617-4b3a0fb38d91@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Feb 2025 09:46:06 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 26/02/2025 18:10, David Lechner wrote:
> > On 2/26/25 12:28 AM, Matti Vaittinen wrote: =20
> >> Hi David,
> >>
> >> Thanks for taking a look at this :)
> >>
> >> On 26/02/2025 02:26, David Lechner wrote: =20
> >>> On 2/24/25 12:33 PM, Matti Vaittinen wrote: =20
>=20
> ...
>=20
> >> =20
> >>> Similarly, on several drivers we added recently that make use of adc.=
yaml
> >>> (adi,ad7380, adi,ad4695) we wrote the bindings with the intention that
> >>> if a channel was wired in the default configuration, then you would j=
ust
> >>> omit the channel node for that input pin. Therefore, this helper coul=
dn't
> >>> be used by these drivers since we always have a fixed number of chann=
els
> >>> used in the driver regardless of if there are explicit channel nodes =
in
> >>> the devicetree or not. =20
> >>
> >> I think this works with the ICs where channels, indeed, always are the=
re. But this is not the case with _all_ ICs. And in order to keep the consi=
stency I'd actually required that if channels are listed in the DT, then _a=
ll_ the channels must be listed. Else it becomes less straightforward for p=
eople to understand how many channels there are based on the device tree. I=
 believe this was also proposed by Jonathan during the v1 review:
> >> =20
> >>>> Hmm. That'd mean the ADC channels _must_ be defined in DT in order t=
o be
> >>>> usable(?) Well, if this is the usual way, then it should be well kno=
wn
> >>>> by users. Thanks. =20

So there is some history here that complicates things.

1) Originally we always provided all channels.  Easy case :)
2) Along came SoC ADC users who were unhappy with this not so much because
   of the case Matti hit where the channel can be something else but more
   because it's not unusual to either not wire up some pins on an SoC
   or there are multiple packages that we don't otherwise distinguish
   (as no software differences really) in which some internal pins never
   reach the ones on the package.   Various solutions initially existed
   for this (you can find things like xxx,channels properties in some bindi=
ngs.)
3) Then along came devices where we wanted per channel config.
   There were some 'interesting' bindings for that as well for a while but
   eventually we decided on channel nodes when needed.  Those always allowed
   drivers to supply extra channels that didn't have nodes though (that's
   a driver /binding choice and motivated somewhat by whether the unwired
   pin thing matters - there are ADC package variants where this happens
   but it is rare unlike for SoCs where it seems to be common).
   From this discussion it occurs to me that we maybe want to make sure
   that binding docs state what is expected here clearly.  If there is
   a concept of a 'default' for missing channel nodes then we need to say
   what it is.  Property defaults will give us most of that but don't cover
   everything.
4) Now we had channel nodes we can also use them for (2).  In those cases
   on a device specific case we allow for channels that don't have nodes
   to be hidden.   There is often a fallback for this which is more about
   how bindings evolved (sure they shouldn't evolve but they do unfortunate=
ly).
   In those cases, no channel nodes =3D=3D all channel nodes with default s=
ettings.


> >>>
> >>> Yes. We basically have two types of binding wrt to channels.
> >>> 1) Always there - no explicit binding, but also no way to describe
> >>>  =C2=A0=C2=A0=C2=A0 anything specific about the channels.
> >>> 2) Subnode per channel with stuff from adc.yaml and anything device
> >>>  =C2=A0=C2=A0=C2=A0 specific.=C2=A0 Only channels that that have a no=
de are enabled.
> >>> =20
> >=20
> > Hmm... does that mean we implemented it wrong on ad7380 and ad4695? =20
>=20
> I believe this is a question to Jonathan. With my ADC-driver experience=20
> I am not the person to answer this :)
>=20
> _If_ I commented something to this, I would say that: "I believe, this=20
> question is a good example of why providing helpers is so powerful. In=20
> my experience, when we provide helpers, then there will be a 'de facto'=20
> way of doing things, which improves consistency". But as I feel I'm on=20
> the verge of stepping on someones toes (and I am really the novice on=20
> this area), I won't say that comment out loud.

Problem is always 'history'.  We already have a bunch of drivers
doing what the parts David called out do.  The bindings are clear and
ultimately it is a bit device specific to whether missing nodes logically
should default to default parameters or be hidden. In some cases there are
natural defaults, in others not even close as we have fully flexible
MUXes in front of differential ADCs and can in theory configure far more
combinations than we even have pins for.

So today the situation is we have all the options in tree and we aren't
really in a position to drop any of them:

a) custom bindings to configure channels - lots of these :(
b) everything on if no channel nodes.  Maybe everything on always.
c) channel nodes necessary for a channel to exist.

If I were starting all this again we'd probably reduce the options but
too late now :(

Only thing I'd request is if a binding uses channel nodes at all.
It should be possible to provide all nodes - whether or not some are
just the defaults.  That way we can advise writers of bindings to
provide all the channels they want to use.  The other cases then
become a case of whether they get more channels than expected, but
never that some they want aren't there!  A binding that didn't do
this wouldn't be wrong, it would just mean the writer read the binding
doc more carefully and knows what is expected for this device rather
than more generally.

There are some 'interesting' is it broken ABI backwards compatibility
questions when we retrofit channel nodes into a binding.  In those cases
we can't hide non specified nodes as it would mean channels disappear that
in an earlier kernel were present.  In theory that should never be a
problem but not all userspace code is going to be sufficient careful
to not be disrupted by channel number changes.  Even this I think we
broke once or twice because of cases like the one Matti has where they
are multipurpose pins on some chip variant we didn't know about when
the driver was written.

Jonathan

>=20
> >>> There are a few drivers that for historical reasons support both
> >>> options with 'no channels' meaning 'all channels'. =20
> >>
> >> https://lore.kernel.org/all/20250201162631.2eab9a9a@jic23-huawei/
> >> =20
> >>> In my experience, the only time we don't populate all available chann=
els
> >>> on an ADC, even if not used, is in cases like differential chips where
> >>> any two inputs can be mixed and matched to form a channel. Some of th=
ese,
> >>> like adi,ad7173-8 would have 100s or 1000s of channels if we tried to
> >>> include all possible channels. In those cases, we make an exception a=
nd
> >>> use a dynamic number of channels based on the devicetree. But for chi=
ps
> >>> that have less than 20 total possible channels or so we've always
> >>> provided all possible channels to userspace. It makes writing userspa=
ce
> >>> software for a specific chip easier if we can always assume that chip
> >>> has the same number of channels. =20
> >>
> >> In any exception to this rule of describing all channels in DT should =
just avoid using these helpers and do things as they're done now. No one is=
 forced to use them. But I am not really sure why would you not describe al=
l the channels in the device-tree for ICs with less than 20 channels? I'd a=
ssume that if the channels are unconditionally usable in the hardware, then=
 they should be in DT as well(?) =20
> >=20
> > I devicetree, I think the tendency is to be less verbose and only add
> > properties/nodes when there is something that is not the usual case.
> > Default values are chosen to be the most usual case so we don't have
> > to write so much in the .dts. =20
>=20
> On the other hand, I've received comments from the DTS people to expose=20
> all HW blocks in the bindings. AFAIR, for example, marking=20
> power-supplies as 'optional' in bindings is frowned upon, because they=20
> are in the HW whether the SW needs to control them or not. Hence I think=
=20
> marking either all or no channels in dt should be the way to go - but my=
=20
> thinking is not done based on the years of experience on ADCs!

Even for power supplies there is a difference between the binding doc
saying they are there and what we do if they aren't (which is assume
a stub regulator representing an non controllable / unknowable power supply
is sufficient).    Also for power supplies there isn't really a 'default'
to use so it doesn't really work as a comparison.

Hindsight is a wonderful thing.  I'm not sure on what policy we should have
gone for, but now we are kind of stuck with this slightly messy situation.

Helper wise if it expands usefulness we may want a bool parameter to say
if we skip the missing or not + make sure a max expected channel is provided
(might already be - I didn't check!)

Jonathan

>=20
> >>>> Add couple of helper functions which can be used to retrieve the cha=
nnel
> >>>> information from the device node.
> >>>>
> >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>> =20
> >>
> >> Yours,
> >>  =C2=A0=C2=A0=C2=A0=C2=A0-- Matti =20
> >  =20
>=20


