Return-Path: <linux-iio+bounces-10521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C1899B5F5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C990B2311D
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123C2F870;
	Sat, 12 Oct 2024 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUg+eWRr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37902745B;
	Sat, 12 Oct 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728748062; cv=none; b=m13opXLLbfHlIsebOnmTO6h+xMQxp7LpyABkWMKFC7DdwLrdNksC8+q2b9lGdJFNV2rJIYYjW2y2C/UPew4GRZGRrnCUlK+8DwdrAebrJq3b/pHqr0ELtECDqzQvxDcn5QRz27wvwWWx1S6gCjxb+OCcpogI6RnDjRMo/Y3C+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728748062; c=relaxed/simple;
	bh=2MNDZtcVc98ttTX6U8/xvAW50zYpOlIJSSpWO9xFQLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak260dF6sA3SCw82A6thNBY2DlzW7eZwwq5/gnE8rQUHXZaWYOqiUO++eIgkieins4F+yIeeguK52NsMr9h0byMo+q3wJDeszmXTtZLTZ0AeetqMyfyvmIRurAXHFQNMetJAg7ZZlwFwAA/UjcPfHThCjLTZk7MTlXJgvwSUZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUg+eWRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A123C4CEC6;
	Sat, 12 Oct 2024 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728748061;
	bh=2MNDZtcVc98ttTX6U8/xvAW50zYpOlIJSSpWO9xFQLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mUg+eWRrFOZKE9GJrIxKV3Cybz9eZ3pNmZveldT19bwfJRRt++fwB2XwVNmV0NvFa
	 wNQthr75nKZS0jnrxLcNtf5Tub5hsRXP3quARuUaioSTyNM4VILvmTEH0kH4RFHm0V
	 c7HXrW80RbY7Yp+rcFzaox9XbhRDX7tdQdLrUOsHezBmrg62h9oQqqMpu2rEi9sZv5
	 /oTRL9ZK9rqq04W/cKH28iGABnOsIx3M2nYKlJeALMkqau75Cdr/DpxntOB7FSgmM8
	 UtsLcId945XagdLhokquEQjnBc6EtvU/cFC1tum6H3A5kZj2YEMvuGFPKZCh1IavrN
	 i5Q5nrQ/tSr6A==
Date: Sat, 12 Oct 2024 16:47:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers
 <ceggers@arri.de>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Peter Rosin
 <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: inkern: copy/release available info from
 producer
Message-ID: <20241012164732.518f86a5@jic23-huawei>
In-Reply-To: <172849861528.354008.17477801981314044908@njaxe.localdomain>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
	<20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com>
	<8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com>
	<172837007815.3337.5869213289160447430@njaxe.localdomain>
	<8241b4caf9ebacb116f50bfe1503f325cc576066.camel@gmail.com>
	<172837459910.12274.5022869861872605261@njaxe.localdomain>
	<27e0d7b2a70015300047d9388edc87a8ece0c0dc.camel@gmail.com>
	<172849861528.354008.17477801981314044908@njaxe.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Oct 2024 20:30:15 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Quoting Nuno S=C3=A1 (2024-10-08 14:37:22)
> > On Tue, 2024-10-08 at 10:03 +0200, Matteo Martelli wrote: =20
> > > Quoting Nuno S=C3=A1 (2024-10-08 09:29:14) =20
> > > > On Tue, 2024-10-08 at 08:47 +0200, Matteo Martelli wrote: =20
> > > > > Quoting Nuno S=C3=A1 (2024-10-07 17:15:13) =20
> > > > > > On Mon, 2024-10-07 at 10:37 +0200, Matteo Martelli wrote: =20
> > > > > > > Consumers need to call the read_avail_release_resource after =
reading
> > > > > > > the
> > > > > > > available info. To call the release with info_exists locked, =
copy the
> > > > > > > available info from the producer and immediately call its rel=
ease
> > > > > > > callback. With this change, users of iio_read_avail_channel_r=
aw() and
> > > > > > > iio_read_avail_channel_attribute() must free the copied avail=
 info
> > > > > > > after
> > > > > > > calling them.
> > > > > > >=20
> > > > > > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > > > > > > ---
> > > > > > > =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 64 +++++++++++++++++++++++++++++++++--
> > > > > > > ----
> > > > > > > -----
> > > > > > > =C2=A0include/linux/iio/consumer.h |=C2=A0 4 +--
> > > > > > > =C2=A02 files changed, 50 insertions(+), 18 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > > > > > index
> > > > > > > 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa2cea=
447e16800
> > > > > > > 7a44
> > > > > > > 7ffc0d91
> > > > > > > 100644
> > > > > > > --- a/drivers/iio/inkern.c
> > > > > > > +++ b/drivers/iio/inkern.c
> > > > > > > @@ -760,9 +760,25 @@ static int iio_channel_read_avail(struct
> > > > > > > iio_channel
> > > > > > > *chan,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!iio_channel_has_available=
(chan->channel, info))
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > > > =C2=A0
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail)
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return iio_info->read_avail(chan->indio_dev, chan- =20
> > > > > > > >channel, =20
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 vals, type, length, info);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail) {
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const int *vals_tmp;
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 int ret;
> > > > > > > +
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D iio_info->read_avail(chan->indio_dev, chan- =20
> > > > > > > >channel, =20
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0 &vals_tmp, type, length,
> > > > > > > info);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (ret < 0)
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > > > > +
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *vals =3D kmemdup_array(vals_tmp, *length, sizeof(int),
> > > > > > > GFP_KERNEL);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!*vals)
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > > > > > > + =20
> > > > > >=20
> > > > > > Not a big deal but I would likely prefer to avoid yet another c=
opy. If
> > > > > > I'm
> > > > > > understanding things correctly, I would rather create an inkern=
 wrapper
> > > > > > API
> > > > > > like=20
> > > > > > iio_channel_read_avail_release_resource() - maybe something wit=
h a
> > > > > > smaller
> > > > > > name :).
> > > > > > Hence, the lifetime of the data would be only controlled by the=
 producer
> > > > > > of
> > > > > > it. It
> > > > > > would also produce a smaller diff (I think). I just find it a b=
it
> > > > > > confusing
> > > > > > that we
> > > > > > duplicate the data in here and the producer also duplicates it =
on the - =20
> > > > > > > read_avail() =20
> > > > > > call. Another advantage I see is that often the available data =
is indeed
> > > > > > const in
> > > > > > which case no kmemdup_array() is needed at all. =20
> > > > >=20
> > > > >=20
> > > > > If I understand correctly your suggestion you would leave the ink=
ern
> > > > > iio_channel_read_avail() untouched, then add a new inkern wrapper,
> > > > > something
> > > > > like iio_channel_read_avail_release_resource(), that would call t=
he
> > > > > producer's
> > > > > read_avail_release_resource(). The consumer would invoke this new=
 wrapper
> > > > > in
> > > > > its
> > > > > own read_avail_release_resource() avoiding the additional copy. T=
he call
> > > > > stack
> > > > > would look something like the following:
> > > > >=20
> > > > > iio_read_channel_info_avail() {

Here you are talking about the core code that produces a string.
But you've done that in reply to v5 which is about inkern interfaces
that don't work in strings...



> > > > > =C2=A0=C2=A0=C2=A0 consumer->read_avail() {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel=
_raw() {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_channel_read_avail() {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->read_avail() {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmemdup_array();
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0=C2=A0=C2=A0 }
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 iio_format_list();
That's effectively making the safe copy that is handed back to the
caller. So this is fine.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 consumer->read_avail_release_resource() {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel=
_release_resource() {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 producer->read_avail_release_resource() {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree();
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > } =20
> > > >=20
> > > > Yeah, exactly what came to mind...

I'm very confused what scope of comments here is. Maybe the easiest thing i=
s to send the code.


> > > >  =20
> > > > >=20
> > > > >=20
> > > > > I was going with the simpler solution you described, but my conce=
rn with
> > > > > it
> > > > > was
> > > > > that the info_exists_lock mutex would be unlocked between a
> > > > > iio_channel_read_avail()
> > > > > call and its corresponding iio_channel_read_avail_release_resourc=
e() call.
> > > > > To my understanding, this could potentially allow for the device =
to be
> > > > > unregistered between the two calls and result in a memleak of the=
 avail
> > > > > buffer
> > > > > allocated by the producer.

Yes. That's why we have to free the produced copy under the exist_lock
(and take yet another copy).

> > > > >=20
> > > > > However, I have been trying to reproduce a similar case by adding=
 a delay
> > > > > between the consumer->read_avail() and the
> > > > > consumer->read_avail_release_resources(), and by unbinding the dr=
iver
> > > > > during
> > > > > that delay, thus with the info_exists_lock mutex unlocked. In thi=
s case
> > > > > the
> > > > > driver is not unregistered until the iio_read_channel_info_avail()
> > > > > function
> > > > > completes, likely because of some other lock on the sysfs file af=
ter the
> > > > > call
> > > > > of
> > > > > cdev_device_del() in iio_device_unregister().
> > > > >  =20
> > > >=20
> > > > Yes, you need to have some sync point at the kernfs level otherwise=
 we could
> > > > always be handling a sysfs attr while the device is being removed u=
nder our
> > > > feet. But I'm not sure what you're trying to do... IIUC, the proble=
m might
> > > > come
> > > > if have:
> > > >=20
> > > > consumer->read_avail_channel_attribute()
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->info_lock()
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->read_avail()
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 producer->kmalloc()
> > > >=20
> > > > ...
> > > > // producer unbound
> > > > ...
> > > > consumer->read_avail_release()
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> > > >=20
> > > > // producer->kmalloc() never get's freed...
> > > >=20
> > > > The above is your problem right? And I think it should be a valid o=
ne since
> > > > between ->read_avail_channel_attribute() and read_avail_release() t=
here's
> > > > nothing preventing the producer from being unregistered... =20
> > >=20
> > > Yes, that's the problem.
> > >  =20
> > > >=20
> > > > If I'm not missing nothing one solution would be for the producer t=
o do
> > > > devm_kmalloc() and devm_kfree() on read_avail() and release_resourc=
es() but
> > > > at
> > > > that point I'm not sure it's better than what you have since it's o=
dd enough
> > > > for
> > > > being missed in reviews... =20

If it's an allocation to keep a copy for an active consumer then that is na=
sty
as the lifetime is completely untidied.  Effectively you are garbage collec=
ting.

> > >=20
> > > I honestly didn't think of this and it would in fact prevent the
> > > additional copy. But I agree that it could be missed in new drivers,
> > > maybe a comment in the iio_info read_avail_release_resource() callback
> > > declaration would help? =20
> > > >  =20
> > At this point I would say whatever you or Jonathan prefer :)
> >  =20
>=20
> I run some quick tests with this approach and haven't found any issue so
> far.=20

I can't see what is preventing the race you describe where the
release callback is swept out by a driver unbind of the provider.
So unless we can show that is safe I don't see a way to avoid a consumer co=
py.

Long shot, Lars-Peter I think you fixed up most of the previous races in th=
is
code, don't suppose you remember how it works?

> I would personally switch to this approach as it would be much
> simpler and easier to understand, and since the avail lists are const
> for most of the current drivers I would not expect many new drivers
> needing a dynamic available list. However, I will wait Jonathan feedback
> first.
The idea here is almost no one actually makes a copy in the producer.
The consumer copy is a necessity to my thinking because we are effectively
passing the ownership of the data.  Unfortunately we have no idea how
the producer would free it so we need to create our own copy.

Key here is this a very rare operation.   No one polls available
data at high frequency, it's a read once kind of thing typically.
+ these are normally really short lists in the cases we actually use
(so far I 'think' they have always been the 3 value range form, not
 a list of potential values).

Jonathan


>=20
> About the release wrapper name: even though "release_resource" looks a
> common suffix for this kind of pattern,
> iio_read_avail_channel_release_resource() seems in fact extremely long
> and I would go for something like iio_read_avail_channel_release(). At
> that point I would also shorten the iio_info release function name for
> consistency, like read_avail_release_resource() =3D> read_avail_release().
> I hope such names would be clear enough though. Any feedback on this?
>=20
> > - Nuno S=C3=A1 =20
>=20
> Thanks,
> Matteo Martelli


