Return-Path: <linux-iio+bounces-26995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB53CB3B68
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 19:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0536030141EC
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCA83242A4;
	Wed, 10 Dec 2025 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlloFr9R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC7276020;
	Wed, 10 Dec 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389894; cv=none; b=OVWv3vSXERvK8OIxhcK546T0G5lXtkGjQk4Wn5LPdXth9Rwoi6tPQF4sivFd+QlObvPvFEs8UnXyavK07aAjbR6zy/D+O3H31FAvf8hKD7JfT8v9BDkwJCYhrskHE7vKDU/wau/gOpdA1hFQU7SmieTicqDb6qQGpiSSUtJIjiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389894; c=relaxed/simple;
	bh=0faUSSKLytOQXTQ0wtj0LzWTrjM3kYFWiYFxfpTAknw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOE0N2HFeAo9AV/8TTCrEubTTpcDdwLI1cwCWBNZg7V4EUulwWlJfEfGOmRvtjla3SPLWvmjIXPtmTi/OPRPU20M971EpqXL/88M0PjMiLwuvMT7rynYMc6dQ9MbU+QI/v28ekek0H2Y9m+7Su6JwUOTtKLCYDNMlx96Kgb33Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlloFr9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A909C4CEF1;
	Wed, 10 Dec 2025 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765389894;
	bh=0faUSSKLytOQXTQ0wtj0LzWTrjM3kYFWiYFxfpTAknw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UlloFr9REes6eNWj2a7za8w/R5HxMPI3KTLC65OdbnKtfQR3Dx5Latzj40LHYsqb4
	 8sc4557skKYfMeLO/zXrJzPtACiAzo6RU4zxTDQ7oHyz7rrkqlivmtco82x9Ta4XeK
	 TCsDcWix55AcYnFoqBfcxnraTTWCspMuhWgv7sYLbmbV5OZ7cUZt+j+tvpUCG080Jj
	 s/Gp4lV4WaWyVILxG6/ZcCYeoYuj4TS8qKNn0Jj8k+EifQPALccFmXpkmE5ew61HEc
	 O8WhGo7Krfi3nm7nYFexjgOfZXXnlcCJSQM3txQt+hXsa63xZ08/MJlYMlwSU9syCk
	 iH0Xiw3RNcDKQ==
Date: Wed, 10 Dec 2025 18:04:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Benson Leung
 <bleung@chromium.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou	 <gwendal@chromium.org>, Shrikant Raskar
 <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko	
 <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode
 locks
Message-ID: <20251210180447.0a37c3dc@jic23-huawei>
In-Reply-To: <8f24bb46e02a6bec6267430d0f0742c601af9aed.camel@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	<77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
	<CAHp75VdNjqZdy0+aSbBzn9CwEwHUhjwED+KRVqkdOMc_N+nX9w@mail.gmail.com>
	<20251206184645.51099254@jic23-huawei>
	<54483083c42cf7500239ebb7c0d32d25f11bb02f.camel@gmail.com>
	<7aeab2a4-72d9-452f-af86-1e44d5133b67@baylibre.com>
	<8f24bb46e02a6bec6267430d0f0742c601af9aed.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Dec 2025 09:17:17 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-12-09 at 11:05 -0600, David Lechner wrote:
> > On 12/9/25 4:34 AM, Nuno S=C3=A1 wrote: =20
> > > On Sat, 2025-12-06 at 18:46 +0000, Jonathan Cameron wrote: =20
> > > > On Thu, 4 Dec 2025 17:07:28 +0200
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > >  =20
> > > > > On Thu, Dec 4, 2025 at 4:35=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@=
gmail.com> wrote: =20
> > > > > > On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:=C2=A0  =20
> > > > > > >=20
> > > > > > > In a recent driver review discussion [1], Andy Shevchenko sug=
gested we
> > > > > > > add cleanup.h support for the lock API:
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_claim_{direct,buffe=
r_mode}().=C2=A0  =20
> > > > > >=20
> > > > > > We already went this patch and then reverted it. I guess before=
 we did not had
> > > > > > ACQUIRE() and ACQUIRE_ERR() but I'm not sure that makes it much=
 better. Looking at the
> > > > > > last two patches on how we are handling the buffer mode stuff, =
I'm really not convinced...
> > > > > >=20
> > > > > > Also, I have doubts sparse can keep up with the __cleanup stuff=
 so I'm not sure the
> > > > > > annotations much make sense if we go down this path. Unless we =
want to use both
> > > > > > approaches which is also questionable.=C2=A0  =20
> > > > >=20
> > > > > This, indeed, needs a (broader) discussion and I appreciate that =
Kurt
> > > > > sent this RFC. Jonathan, what's your thoughts? =20
> > > >=20
> > > > I was pretty heavily involved in discussions around ACQUIRE() and i=
t's use
> > > > in CXL and runtime PM (though that's still evolving with Rafael try=
ing
> > > > to improve the syntax a little).=C2=A0 As you might guess I did hav=
e this use
> > > > in mind during those discussions.
> > > >=20
> > > > As far as I know by avoiding the for loop complexity of the previous
> > > > try we made and looking (under the hood) like guard() it should be =
much
> > > > easier and safer to use.=C2=A0 Looking at this was on my list, so I=
'm very happy
> > > > to see this series from Kurt exploring how it would be done.
> > > >=20
> > > > Sparse wise there is no support for now for any of the cleanup.h ma=
gic
> > > > other than ignoring it.=C2=A0 That doesn't bother me that much thou=
gh as these
> > > > macros create more or less hidden local variables that are hard to =
mess
> > > > with in incorrect ways.
> > > >=20
> > > > So in general I'm very much in favour of this for same reasons I ju=
mped
> > > > in last time (which turned out to be premature!)
> > > >=20
> > > > This will be particularly useful in avoiding the need for helper fu=
nctions
> > > > in otherwise simple code flows.
> > > >  =20
> > >=20
> > > Ok, it seems we are going down the path to introduce this again. I do=
 agree the new ACQUIRE()
> > > macros make things better (btw, I would be in favor of something simi=
lar to pm runtime). Though
> > > I'm still a bit worried about the device lock helper (the iio_device_=
claim one). We went through
> > > some significant work in order to make mlock private (given historica=
l abuse of it) and this
> > > is basically making it public again. So I would like to either think =
a bit harder to see if we
> > > can avoid it or just keep the code in patches 5 and 6 as is (even tho=
ugh the dance in there is
> > > really not pretty).
> > >=20
> > > At the very least I would like to see a big, fat comment stating that=
 lock is not to be randomly
> > > used by drivers to protect their own internal data structures and sta=
te.
> > >=20
> > > - Nuno S=C3=A1 =20
> >=20
> > Due to the way that conditional guards only extend regular guards, I do=
n't
> > think there is a way to not expose the basic mlock wrapper. So "don't u=
se this
> > unless you really know what you are doing" docs seem like the best opti=
on. =20
>=20
> Right! I figured my first option would be very unlikely... But for the co=
mment I hope we can
> elaborate a bit more. Like "don't use this lock to protect your own drive=
r state/data ... you might
> need this together iio_buffer_enabled() and if for some reason you cannot=
 use the claim helpers).
I think this problem is possible to work around.

We use wrapper macros rather than ever using the ACQUIRE macro directly
(and obscure function names to make it obvious they aren't normal :)

The underlying lock guards might be there but they'll smell so bad that any=
one
using them should have at least checked why and hence seen the 'do not use =
this'
documentation.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
>=20


