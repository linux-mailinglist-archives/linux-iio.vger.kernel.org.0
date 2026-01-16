Return-Path: <linux-iio+bounces-27869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C33D3847A
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F124630382B9
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596863491CD;
	Fri, 16 Jan 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmEPDuM4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B62040B6;
	Fri, 16 Jan 2026 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588654; cv=none; b=koWzG2SSKTKhWsyQp8ouhFXWsn90huaTvQdhvaszwj4rJ7vWyj0l8uD1j2GImNLUsUm1PO4S59Cr8mUjy81SiqgF3DxHIDjiUzgDPf1LxosoMcYPV3Q8K+kSXMTV0LPrq/9LJFM3+sXbNs+PW212CodWL74e5lEDAdfBzGprkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588654; c=relaxed/simple;
	bh=dKiQH24rXUflHfGME7jJbjg+kLTX0Wocen1lVyR/ry4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivRssZ9R/YI44dJyaPAV/lyXFmaSpOH2QtQdA3TjQXtKudAvQ2RUL+/XmW69puXXCkuYaGfclpbuMOpoQr1D2pGSIsxC2fhHMJR7MAqnlVu4/fYC1PiCfPfYgdzvoKFcYum4++veKkzG0ofWUOnyR5fsNhhZ00aa3bwh2KSnG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmEPDuM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71D0C116C6;
	Fri, 16 Jan 2026 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768588653;
	bh=dKiQH24rXUflHfGME7jJbjg+kLTX0Wocen1lVyR/ry4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZmEPDuM4+RvWJgebSd5DPcNTld4AMLM5n2AHSTexORlSLQf2MKQ5lwDYvvB6c9xSO
	 j2am301el1w8QXG6SQsMB5IiCwhJXEAsguaB6BVBTVjINLR3zIb5Q7sBb0VwDl4GoY
	 Gnyfu+QZnUj2bQcE25zTG/nEu8sIlU+llC//xgkIbk/Fb+mshfvwU/IFJa1x20MSdn
	 hQm+CRdLJY9PkpO0A570JjrBpvA0xHYs1z03X5g6UoYYqT9Jtx0+i2BJbrEp/OzZmV
	 R2tO/2um7OFm/g29Kjl1jotZGL0ItPrBuvyA5zJXFc9be1V/6nZWxw4CCIx0VTWhmN
	 8g0MJ0YJFYpWA==
Date: Fri, 16 Jan 2026 18:37:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, David Lechner	 <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Olivier Moysan	 <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: adc: ad9467: Support alternative backends
Message-ID: <20260116183724.18063cec@jic23-huawei>
In-Reply-To: <931160a27cfcfbf55d75bf9662442988c266343f.camel@gmail.com>
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	<0ad12e16e3fffb4b72a460d7f2b2e627a781b93b.camel@gmail.com>
	<7ac7033a-2273-4556-a605-1ea0200665a9@vaisala.com>
	<5896ab55e0d23d235908f9f592c8a7975428dc54.camel@gmail.com>
	<41cac06c-8db2-4a52-854f-659606d89121@vaisala.com>
	<931160a27cfcfbf55d75bf9662442988c266343f.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jan 2026 13:31:39 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2026-01-15 at 15:30 +0200, Tomas Melin wrote:
> > Hi,
> >=20
> > On 15/01/2026 14:04, Nuno S=C3=A1 wrote: =20
> > > On Wed, 2026-01-14 at 17:32 +0200, Tomas Melin wrote: =20
> > > > Hi Nuno,
> > > >=20
> > > > On 14/01/2026 15:32, Nuno S=C3=A1 wrote: =20
> >  =20
> > > > >=20
> > > > > But more importantly, how are your usecase supposed to work with =
this
> > > > > series? I'm not seeing any new backend being added as part of the=
 series.
> > > > > Point is, if we are adding all of this, I would expect your useca=
se to
> > > > > have fully upstream support. If I'm not missing nothing, we would=
 at least
> > > > > need a dummy backend providing stubs for enable()/disable() =20
> > > > My usecase adds simplistic backend support and registers to the
> > > > framework via an related driver. So that use case works with that
> > > > approach. I think it is better to assume there is always some entity
> > > > that can take on the role of being backend, rather than adding a du=
mmy
> > > > backend. Adding the capabilities are defining role here, as having =
that =20
> > >=20
> > > Well, I would argue your backend is exactly that. A dummy one :) =20
> >=20
> > It's kindof ;)=C2=A0 But on general level it handles the stuff a backend
> > needs to do, just does not have most of the operations or capabilities
> > available. OTOH having the backend defined means that if some of the
> > capabilites would be added, there is a natural place to add it.
> >  =20
>=20
> But there's nothing you can control from Linux right?
>=20
> > >  =20
> > > > allows for customer integrations with backends that differ but are =
of no
> > > > interest for the mainline.
> > > >  =20
> > >=20
> > > It would still be nice to have this usecase fully supported upstream=
=C2=A0
> > > (having a black box backend).=C2=A0
> > >=20
> > > What I have in mind would be really to do the same as regulators do. =
If you call
> > > regulator_get() then the consumer really assumes a regulator must exi=
st. But if it
> > > is something the kernel does not control we get a dummy one with very=
 limited
> > > functionality/stubs. If you call regulator_get_optional(), then the r=
egulator is
> > > really optional and might not physically exist. Seems very similar to=
 what you have. =20
> >=20
> > There could perhaps be use for a backend like this too. Is the idea such
> > that one would still need to define a "iio-backend-simple" node or such
> > to device tree which would then provide the backend link and compatible?
> >  =20
>=20
> My idea would be to automatically define one if we fail to find it. Natur=
ally if we
> ever add an optional() get the dummy could not be added. See how regulato=
r_get()
> handles it. That's basically what I have in mind.
>=20
It's an interesting idea, but I'd like some input from DT folk on this.
The fake regulators thing is kind of legacy from lots of drivers gaining the
power handling later and it being boring / too late to add all the fixed re=
gs
to DT.  This is a much less common case and I find it a little unlikely the=
re
is nothing useful to know about where the data is going - so how useful
is an autocreated backend?

Jonathan

> - Nuno S=C3=A1


