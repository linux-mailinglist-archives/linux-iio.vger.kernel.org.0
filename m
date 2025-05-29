Return-Path: <linux-iio+bounces-20003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BC8AC7B1F
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 11:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E3116C14A
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 09:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142821CC45;
	Thu, 29 May 2025 09:32:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179615E97;
	Thu, 29 May 2025 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511163; cv=none; b=heVJWWAT/QBiIkzpHp0oO0FRh3JMnwWihzD1zQytoQ3SXGqiDZOzQ5gU8nPHZRN3lDA/ZUhIE9FViweRF20xypRklVwR8aw/wxOmA51Fp3UjezBv6iLPnluWlyJ4i1YTjcjcdTx/YbbOZBFOkAKjkqPyYCPhrfBNEZVMVUKGfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511163; c=relaxed/simple;
	bh=mcjR3gQ+VgRUfhP02WimDDfywq/u9GcQQll4HVvoscY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBr96zgU6gmyvbvI2au6SJDpyCEEep7Avy+rPl+Jkbpqarv74HIibnV7UYkfckM/vBNk3AplnqI9s0YPhH4Sh0bzThkjfGNKo/7rd8N4Khg08IxGJPatFLhQ/eOG/wxtO8ZotTNLrt9OQ3EqI5cp43d8dQvzzYYDZH2vY09DtIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7Lj60y2dz6L5Fs;
	Thu, 29 May 2025 17:31:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 484571402FE;
	Thu, 29 May 2025 17:32:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 May
 2025 11:32:36 +0200
Date: Thu, 29 May 2025 10:32:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Gyeyoung Baek <gye976@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: trigger: Avoid data race
Message-ID: <20250529103235.0000144a@huawei.com>
In-Reply-To: <CAHp75VdBMXCBYiDX8ocyOZBm_dhWJSU_NXJN6PmOwsZaJt=AHw@mail.gmail.com>
References: <20250527200534.98689-1-gye976@gmail.com>
	<CAHp75VcUr7-X+F1f=wPH4=Z7q3kFffv8BgkmKWM4VTjy2w-tGg@mail.gmail.com>
	<CAKbEznuuGX3Gnqg6WF2mqbigRps0gzK_PfGHGNy8-v1WOZoMUQ@mail.gmail.com>
	<CAHp75VfEeNyspiMSax1_d+cpbmCQQVbOBEPCHuAag2O0ZHC1jA@mail.gmail.com>
	<CAKbEznt7ZhN9gZWy-7wHhFhwbF8XtCGrukuxe4eAFZpfxfu6vg@mail.gmail.com>
	<20250528180214.00002253@huawei.com>
	<CAHp75VdBMXCBYiDX8ocyOZBm_dhWJSU_NXJN6PmOwsZaJt=AHw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 29 May 2025 07:42:46 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, May 28, 2025 at 7:02=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Wed, 28 May 2025 16:17:06 +0900
> > Gyeyoung Baek <gye976@gmail.com> wrote: =20
> > > On Wed, May 28, 2025 at 6:19=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote: =20
> > > > On Tue, May 27, 2025 at 11:10=E2=80=AFPM Gyeyoung Baek <gye976@gmai=
l.com> wrote: =20
> > > > > On Wed, May 28, 2025 at 5:25=E2=80=AFAM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote: =20
> > > > > > On Tue, May 27, 2025 at 10:05=E2=80=AFPM Gyeyoung Baek <gye976@=
gmail.com> wrote: =20
>=20
> ...
>=20
> > > > > > At bare minimum they are not relevant to the patch change and h=
aven't
> > > > > > been described in the commit messages. =20
> > > > >
> > > > > I initially skipped this part as I thought it was minor.
> > > > > But on a second look, it seems better to separate the declaration=
 from
> > > > > the logic.
> > > > >
> > > > > What do you think about the data race logic? Would it make sense?=
 =20
> > > >
> > > > The point is valid, the atomic_read() + atomic_set() is 101 thingy,
> > > > whoever did that doesn't really have a clue what atomic(ity) is. =20
> >
> > :)
> >
> > I'm trying to recall what this protection is actually for so this might
> > be a little vague as descriptions go...
> >
> > The key here is what can happen in that 'race' and hence why I'm still =
fairly
> > sure it isn't a real race.  Firstly this is called in an irq handler
> > so we can only have one call of this particular function at a time
> > for a given trigger.  So no race against itself.
> >
> > The atomic part is about decrements that can happen elsewhere, but there
> > can never be 'more' decrements than the value we set the counter to in =
this
> > function.  That is it never goes negative.
> >
> > Those decrements ultimately happen in calls that can't happen until aft=
er
> > the set (via various convoluted paths ultimately getting to
> > iio_trigger_notify_done()).  In many cases the trigger is masked until =
it
> > is reenabled on the counter =3D=3D 0 (elsewhere) - but not always...
> >
> > IIRC correctly aim is to not double trigger in cases where we can't mask
> > the trigger (a particularly rubbish trigger) - so if any of the downstr=
eam
> > devices still hasn't called iio_trigger_notify_done() then we quietly
> > drop this particular irq on the floor. We don't mind dropping a few
> > too many, just dropping too few a then we end up loosing count of who
> > has to be 'done' with the trigger.
> >
> > Hence the counter won't change between atomic_get and the atomic_set
> > as it's always 0 which means no one else is left to decrement it.
> >
> > Atomics don't always need to be atomic all the time, they just are in
> > some states. =20
>=20
> Yes, but this is confusing and/or buggy code to begin with (and
> independently on the background of its usage). Technically this patch
> (perhaps with a better commit message) is valid. Main two points here:
> 1) avoiding potential (even theoretical) race;=20

Not a race, even a theoretical one, that I can establish.


> 2) do not spread a
> really wrong pattern to avoid people learning from it (in case
> somebody takes this code as an example for a new driver which might
> reside outside of IIO and hence might not be caught by the reviewers
> of _that_ subsystem).

Hmm. I'd conjecture (I'll pester some uarch folk later to confirm)
that an implementation of cmpxchg might be considerably more costly
than a get followed by a set. Might be cheaper too depending on
implementation.  The compiler should be able to fuse them anyway
if that makes sense for a given uarch (guess I'll pester compiler
folk as well.)

>=20
> Alternatively we need to get rid of atomic operations, but with the
> same effect as 2) above.

IIRC to access atomics, atomic the atomic get / set have to be used and
in the decrement path we must ensure only one winner of the race to 0
(because there is an operation to perform on that which must happen only
once).

I'm not against some changes here to make sure the code isn't cut
and paste for other uses (it's pretty specific so I doubt it, but you never
know). That might either be switching to cmpxchg or just adding some commen=
ts
on the logic.

Without a clear path to bugs this isn't a fix, so fixes tag isn't appropria=
te.
=20
>=20
> > So, is this something that has caused observed problems, or based
> > on code inspection? My remembering of what was going on here might well
> > be flawed.
> >
> > There are some 'fun' corners for what happens after that set though
> > where a handler can run fast enough in race conditions we end up
> > hitting 0 in iio_trigger_notify_done_atomic() and have to schedule
> > restarting of the trigger because that might involve a bus write over
> > a sleeping bus.  That one was a painful bug report some years ago... =20
>=20


