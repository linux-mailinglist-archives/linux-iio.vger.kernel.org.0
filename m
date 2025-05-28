Return-Path: <linux-iio+bounces-19995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D02AC6EAA
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93CD17284C
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E421F461A;
	Wed, 28 May 2025 17:02:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F55CA6F;
	Wed, 28 May 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451742; cv=none; b=GJiOO74CqjsHscHOpVHXi85KQjSYIu/JJ1OTnCdz4Eg2xFGHbnpQsRTbZkwINALqLCW4BItT2Rtj5W+hhW3K+2bE3U7YkAWdx7nOtfXxq9PefqTwuPTQKJOMbnNmUmD60F9dQv4EyBJ9XQxv2cLjPIk3oPBpIL1TqRNv35GjTb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451742; c=relaxed/simple;
	bh=BPHRlGQHl/3MSxPFSO8Vd6F+fQkuJJ1rjfhVgzceE3I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIhwP3uJ5VbFJQbienrxMVdGifMbpOWaF4BLNbX9vfteggkAzkGkbpzJaIf0rfqY14Ypsmrd+qFN9WimJ+0nFWT4eoY50ladzXAdwXagmV8E4YI3/WP/Ce1ZN79S2T5N6tFXc72Ap/wiAo9LAkk7FWesQagxe2c+6T03dF5cb0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6wkS0Jvtz6HJby;
	Thu, 29 May 2025 01:01:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D541140277;
	Thu, 29 May 2025 01:02:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 May
 2025 19:02:16 +0200
Date: Wed, 28 May 2025 18:02:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gyeyoung Baek <gye976@gmail.com>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: trigger: Avoid data race
Message-ID: <20250528180214.00002253@huawei.com>
In-Reply-To: <CAKbEznt7ZhN9gZWy-7wHhFhwbF8XtCGrukuxe4eAFZpfxfu6vg@mail.gmail.com>
References: <20250527200534.98689-1-gye976@gmail.com>
	<CAHp75VcUr7-X+F1f=wPH4=Z7q3kFffv8BgkmKWM4VTjy2w-tGg@mail.gmail.com>
	<CAKbEznuuGX3Gnqg6WF2mqbigRps0gzK_PfGHGNy8-v1WOZoMUQ@mail.gmail.com>
	<CAHp75VfEeNyspiMSax1_d+cpbmCQQVbOBEPCHuAag2O0ZHC1jA@mail.gmail.com>
	<CAKbEznt7ZhN9gZWy-7wHhFhwbF8XtCGrukuxe4eAFZpfxfu6vg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 28 May 2025 16:17:06 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> On Wed, May 28, 2025 at 6:19=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, May 27, 2025 at 11:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.co=
m> wrote: =20
> > > On Wed, May 28, 2025 at 5:25=E2=80=AFAM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote: =20
> > > > On Tue, May 27, 2025 at 10:05=E2=80=AFPM Gyeyoung Baek <gye976@gmai=
l.com> wrote: =20
> >
> > ...
> > =20
> > > > At bare minimum they are not relevant to the patch change and haven=
't
> > > > been described in the commit messages. =20
> > >
> > > Hi Andy, thanks for your review.
> > > I initially skipped this part as I thought it was minor.
> > > But on a second look, it seems better to separate the declaration from
> > > the logic.
> > >
> > > What do you think about the data race logic? Would it make sense? =20
> >
> > The point is valid, the atomic_read() + atomic_set() is 101 thingy,
> > whoever did that doesn't really have a clue what atomic(ity) is. =20

:)=20

I'm trying to recall what this protection is actually for so this might
be a little vague as descriptions go...

The key here is what can happen in that 'race' and hence why I'm still fair=
ly=20
sure it isn't a real race.  Firstly this is called in an irq handler
so we can only have one call of this particular function at a time
for a given trigger.  So no race against itself.

The atomic part is about decrements that can happen elsewhere, but there
can never be 'more' decrements than the value we set the counter to in this
function.  That is it never goes negative.

Those decrements ultimately happen in calls that can't happen until after
the set (via various convoluted paths ultimately getting to
iio_trigger_notify_done()).  In many cases the trigger is masked until it
is reenabled on the counter =3D=3D 0 (elsewhere) - but not always...

IIRC correctly aim is to not double trigger in cases where we can't mask
the trigger (a particularly rubbish trigger) - so if any of the downstream
devices still hasn't called iio_trigger_notify_done() then we quietly
drop this particular irq on the floor. We don't mind dropping a few
too many, just dropping too few a then we end up loosing count of who
has to be 'done' with the trigger.

Hence the counter won't change between atomic_get and the atomic_set
as it's always 0 which means no one else is left to decrement it.

Atomics don't always need to be atomic all the time, they just are in
some states.

So, is this something that has caused observed problems, or based
on code inspection? My remembering of what was going on here might well
be flawed.

There are some 'fun' corners for what happens after that set though
where a handler can run fast enough in race conditions we end up
hitting 0 in iio_trigger_notify_done_atomic() and have to schedule
restarting of the trigger because that might involve a bus write over
a sleeping bus.  That one was a painful bug report some years ago...

Jonathan

>=20
> Thanks for your explanation.
> Then I=E2=80=99ll send a v2 patch with only the `int i` change, following=
 the
> review feedback.
>=20
> --
> Best regards,
> Gyeyoung
>=20
>=20


