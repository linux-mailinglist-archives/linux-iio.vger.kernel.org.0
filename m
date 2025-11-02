Return-Path: <linux-iio+bounces-25803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FCEC28EE7
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 13:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20607347D6C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 12:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD55821D599;
	Sun,  2 Nov 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR1w5gf5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723134D39C;
	Sun,  2 Nov 2025 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762085273; cv=none; b=M1gGcUqqEymXLUmKUs0F+zurIAMmwh6VDhaBFxXe8S0iQCjuW2u0lffxnsEPE/iK8tzsZCl2YOFmxaI9p6t0BiWc1dWmd4hB59bp/e4JUw87e9GUtrfT/j9ZZ24OQ4Ga7HknXW3OdlkPbXle62CGQDzzGXsLXODY2M/VlUZ3NtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762085273; c=relaxed/simple;
	bh=ikluRLwAQOhoq3dUiGSz7FKG3t3zxynUJqtA23ZgsD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEtQJIk/wRklXxxZfaTLZKoz4aZgGNAJ+KB8CqiM/KtS9PRfMDb8vonvE5GA3urxJlzIKYS5LlYR2vaIgqoFQ46iC1hTrBMtyTPeT97s/Sun2WAl6szd9QYpG0yUl0ahGjJRf95FdvU4701A6IRgm37i5nwSxyXoBXetM67Jmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR1w5gf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40307C4CEF7;
	Sun,  2 Nov 2025 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762085273;
	bh=ikluRLwAQOhoq3dUiGSz7FKG3t3zxynUJqtA23ZgsD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NR1w5gf5TLhA+7s1VfbKdJiWB2AerUn9FGAZzcW5luA8xLelI0r7XeXsa8RWyaCYx
	 Qvz0ZrmT6Jf1dnVhmvpFlhOPh5vlCfCcNbAEpAb/H9XMrPr7rSkLYsNWPaAzPE0UZm
	 WIvgGT7JWKTP4cTkSUW26K69SpUJxrej58bFOqjF+e3aa827G6DoaDwPX6bmenddUh
	 ilkvQWs5PxiC1SGrltyKWg8bI72fI/SKy2qfNvqgkqTFRETA+P5ROOVlw7Npa/KzxD
	 go0e6+Zi2DbRSA9FePaAngjBGofRNH5S83jJRTMjrUkVygHsaVI1c3hlWdMMfmUONN
	 Zkx+D/Esxka5A==
Date: Sun, 2 Nov 2025 12:07:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: wens@kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>, David
 Lechner  <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko  <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Use datasheet name as fallback for label
Message-ID: <20251102120746.48dfb71b@jic23-huawei>
In-Reply-To: <9e4253955100998826b36834632b2326782141ac.camel@gmail.com>
References: <20251027124210.788962-1-wens@kernel.org>
	<20251027144327.09f59982@jic23-huawei>
	<aQB5Dw2Eg0tVdNow@smile.fi.intel.com>
	<5e3bf0d87ae1b539d134edefee67d3e3ef3b46cb.camel@gmail.com>
	<CAGb2v676eOkPOc33+FMX6k9562gn34+MR15t-iucLjd0qQKs7Q@mail.gmail.com>
	<9e4253955100998826b36834632b2326782141ac.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 15:17:24 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-10-28 at 22:36 +0800, Chen-Yu Tsai wrote:
> > On Tue, Oct 28, 2025 at 5:22=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
.com> wrote: =20
> > >=20
> > > On Tue, 2025-10-28 at 10:04 +0200, Andy Shevchenko wrote: =20
> > > > On Mon, Oct 27, 2025 at 02:43:27PM +0000, Jonathan Cameron wrote: =
=20
> > > > > On Mon, 27 Oct 2025 20:42:09 +0800
> > > > > Chen-Yu Tsai <wens@kernel.org> wrote:
> > > > >  =20
> > > > > > Some IIO drivers do not provide labels or extended names for th=
eir
> > > > > > channels. However they may provide datasheet names. axp20x-adc =
is
> > > > > > one such example.
> > > > > >=20
> > > > > > Use the datasheet name as a fallback for the channel label. This
> > > > > > mainly
> > > > > > benefits iio-hwmon by letting the produced hwmon sensors have m=
ore
> > > > > > meaningful names rather than in_voltageX. =20
> > > > >=20
> > > > > I definitely don't want to have different behaviour for in kernel
> > > > > requests
> > > > > and for people reading the _label attributes.
> > > > > https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/iio/ind=
ustrialio-core.c#L1232
> > > > > would need modifying to allow for the sysfs attributes to be crea=
ted.
> > > > >=20
> > > > > In general I'm not sure I want to do this.=C2=A0 Datasheet names =
can be
> > > > > exceptionally
> > > > > obscure which is why we've kept them hidden from userspace.=C2=A0=
 At least
> > > > > dts
> > > > > writers
> > > > > tend to have those names on their circuit diagrams and tend to ha=
ve
> > > > > datasheet access.
> > > > >=20
> > > > > Let's see if anyone else has feedback on this suggestion over nex=
t week
> > > > > or
> > > > > so. =20
> > > >=20
> > > > This is an ABI change without =20
> > >=20
> > > Indeed...
> > >  =20
> > > > 1) proper documentation;
> > > > 2) backward compatibility (i.e. there is no knob to opt-out the cha=
nge, or
> > > > make
> > > > it opt-in).
> > > >=20
> > > > In this form is definitely NAK.
> > > >=20
> > > > If you wish something like this, better to have a separate attribut=
e. But
> > > > the
> > > > problem maybe also that the same component (or 100% compatible one)=
 made
> > > > by
> > > > different vendors and have different datasheet names. This means th=
at the
> > > > new
> > > > attribute may still be ambiguous. Hence I see a little sense to hav=
e it,
> > > > rather
> > > > better to have these links / names to be put in DT schema. At least=
 there
> > > > we
> > > > have different vendors and compatibility mappings. =20
> > >=20
> > > I mean, we already have labels for channels so this all looks like a =
bit of
> > > overlap to me (though I see the temptation of going this way). For
> > > extended_names, there was a reason why it came as a fallback for .lab=
el()
> > > [1].
> > > For this, I'm not really convinced for now. There is also at least one
> > > driver
> > > already exporting the .datasheet_name as a label [2] so maybe we shou=
ld do
> > > that
> > > instead (again, I understand that doing it like this we only need to =
change
> > > one
> > > place...)? Otherwise we should clean up those and that should definit=
ely be
> > > part
> > > of the series (if we even consider this). =20
> >=20
> > Thanks for the pointers. In my case I think either solution works.
> >=20
> > The axp20x-adc driver currently provides _no_ labels. Would adding labe=
ls
> > now be considered backward incompatible?
> >  =20
>=20
> Jonathan should know better but I'm not seeing any reason why you could n=
ot add
> .label support for axp20x-adc (exporting the .datasheet_name for the chan=
nels)
> instead of the current patch.

I'd prefer a per driver version of this as then the author can look for the
sorts of issues Andy raised.  Basically it boils down to are the datasheet
names convenient and human readable names that it makes sense to reuse
for a particular set of devices (if no label in DT is provided)?

So basically side step the insane by doing it where we can evaluate that
the names meet this criteria.

Jonathan

>=20
> - Nuno S=C3=A1
>=20


