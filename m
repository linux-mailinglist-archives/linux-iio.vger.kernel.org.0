Return-Path: <linux-iio+bounces-5609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14018D74F4
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFFB282029
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC53381DF;
	Sun,  2 Jun 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDsRiuZ7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD722574D;
	Sun,  2 Jun 2024 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717327792; cv=none; b=RoqQRSnajhhZDdp8OtDOrNT1mfg9PDv55uxCffvdO1VzHBvwuD3WqbE4vWc+BLrhc3/ZNyzADkIuTNK02EzGYj4aGaUwPk7Lw8l8MwwqE9SvqLoJOOz9i41X5JHdXvoXq6IDmNVidvyiGeZBU13fDonpILzzlXgOgfMyuUPa3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717327792; c=relaxed/simple;
	bh=AYFVYkYawNKzmNOOxgWvekrO9Ajz7ik6QvipGBnlb6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBgmLyCbH0NDwmUg+dDdDrmAFNxZdmYlUCHbYvmbpX+RsIk+0WsbQ5cv+K2kIH4Xrxe8tp2le5sRJJCTCy87r1yC1fXfLNu7KyGnC7Qbr8ASQReljcX2XyNP9hgZ4Jxsf7HrIKx0ZihyiiGrmrWp92XU7z/3Inl1iV6AYs7yw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDsRiuZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FACC2BBFC;
	Sun,  2 Jun 2024 11:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717327792;
	bh=AYFVYkYawNKzmNOOxgWvekrO9Ajz7ik6QvipGBnlb6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eDsRiuZ7fDqFrxjazH3kSdcZR+nSbQD128PDihBa9WncAgLh4Io3VKgfrF4Z3NFhz
	 bttjWM/UnuLCJIhHTHzxqI5SZ+vlP+IM8lt34bm3YfMwHrXEWS9ltVcfRg1AgfrBEf
	 ZKt5C3LWDi0vInAs5ngY0/o8nF248hc1gnAMMLukiXTeqZa3fA8xklVl8i7CFCO3vs
	 bz1jXkk9X6zjWDgU5xioFRI2CB5OirpTNyz9rAoz9qDyrph7mCVkjf4ry5LtD5D9o1
	 0fJIexTsG+li7r5XwaKvzy/nXSjmK1wTPcap3iLpAKKZ3H8v9KKvNqOpaAM6nfS4WW
	 A2DneOk4LyU7Q==
Date: Sun, 2 Jun 2024 12:29:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2] driver: iio: add missing checks on iio_info's
 callback access
Message-ID: <20240602122940.1ac61c4d@jic23-huawei>
In-Reply-To: <20240529151204.00001293@Huawei.com>
References: <20240529-iio-core-fix-segfault-v2-1-7b5a5fa6853f@baylibre.com>
	<20240529130458.000049e6@Huawei.com>
	<CAEHHSvZFfV9mMjnGprqfU-NyCFCdkTLCmfy8K6Ey83-Yg_wA6A@mail.gmail.com>
	<20240529151204.00001293@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 May 2024 15:12:04 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 29 May 2024 15:10:42 +0200
> Julien Stephan <jstephan@baylibre.com> wrote:
>=20
> > Le mer. 29 mai 2024 =C3=A0 14:05, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> a =C3=A9crit : =20
> > >
> > > On Wed, 29 May 2024 13:55:52 +0200
> > > Julien Stephan <jstephan@baylibre.com> wrote:
> > >   =20
> > > > Some callbacks from iio_info structure are accessed without any che=
ck, so
> > > > if a driver doesn't implement them trying to access the correspondi=
ng
> > > > sysfs entries produce a kernel oops such as:
> > > >
> > > > [ 2203.527791] Unable to handle kernel NULL pointer dereference at =
virtual address 00000000 when execute
> > > > [...]
> > > > [ 2203.783416] Call trace:
> > > > [ 2203.783429]  iio_read_channel_info_avail from dev_attr_show+0x18=
/0x48
> > > > [ 2203.789807]  dev_attr_show from sysfs_kf_seq_show+0x90/0x120
> > > > [ 2203.794181]  sysfs_kf_seq_show from seq_read_iter+0xd0/0x4e4
> > > > [ 2203.798555]  seq_read_iter from vfs_read+0x238/0x2a0
> > > > [ 2203.802236]  vfs_read from ksys_read+0xa4/0xd4
> > > > [ 2203.805385]  ksys_read from ret_fast_syscall+0x0/0x54
> > > > [ 2203.809135] Exception stack(0xe0badfa8 to 0xe0badff0)
> > > > [ 2203.812880] dfa0:                   00000003 b6f10f80 00000003 b=
6eab000 00020000 00000000
> > > > [ 2203.819746] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 0=
0000000 00020000 00000000
> > > > [ 2203.826619] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0
> > > > [ 2203.830363] Code: bad PC value
> > > > [ 2203.832695] ---[ end trace 0000000000000000 ]---
> > > >
> > > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>   =20
> > >
> > > How bad would a registration time check look?
> > > I'd rather catch this early than have drivers with missing hooks
> > > that we don't notice because no one pokes the file.   =20
Even if we make further improvements this patch feels like good hardening.
So applied to the togreg branch of iio.git.

Thanks,

Jonathan

> >=20
> > Hi Jonathan,
> >=20
> > Do you mean something like that (as it is done for ext_info for example=
) :
> >=20
> > ret =3D __iio_add_chan_devattr(iio_chan_info_postfix[i],
> >                  chan,
> > -                &iio_read_channel_info,
> > -                &iio_write_channel_info,
> > +                indio_dev->info->read_raw ?
> > +                    &iio_read_channel_info : NULL, =20
>=20
> Doesn't work because of the read_raw_multi callback, but otherwise
> this does improve our permissions handling a little at least.
> It 'might' be considered an ABI change though :(
>=20
> > +                indio_dev->info->write_raw ?
> > +                    &iio_write_channel_info : NULL,
> >                  i,
> >                  shared_by,
> >                  &indio_dev->dev,
> >                  NULL,
> >                  &iio_dev_opaque->channel_attr_list);
> >=20
> > Or do you want to check even before and do not create the  sysfs
> > entry if there is no callback registered by the driver? =20
>=20
> I was thinking a much more stupid option of a missing read_raw
> and read_raw_multi + anything in the info_masks pretty much
> indicates a bug.
>=20
> I don't think we have any 'write only' attributes
>=20
> Similar for read_event_config, though write_event_config is
> trickier as we 'might' one day have a device where the events
> are all fixed value and always on (so read only).
>=20
> Perhaps what you have here is the simplest option as the exact
> rules for what callbacks are provided area bit messy so checking
> at use is fine.
>=20
> However I'd like to see some scattered use of local variables like
> in inkern.c
> struct iio_info *info =3D chan->indio_dev->info;
> to reduce the long lines.
>=20
>=20
> >=20
> > Julien
> >  =20
> > >
> > > The inkern ones are good though.
> > >
> > > Jonathan
> > >   =20
> > > > ---
> > > > Changes in v2:
> > > > - crop dmesg log to show only pertinent info and reduce commit mess=
age
> > > > - Link to v1: https://lore.kernel.org/r/20240529-iio-core-fix-segfa=
ult-v1-1-7ff1ba881d38@baylibre.com
> > > > ---
> > > >  drivers/iio/industrialio-core.c  |  7 ++++++-
> > > >  drivers/iio/industrialio-event.c |  9 +++++++++
> > > >  drivers/iio/inkern.c             | 16 +++++++++++-----
> > > >  3 files changed, 26 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industri=
alio-core.c
> > > > index fa7cc051b4c4..2f185b386949 100644
> > > > --- a/drivers/iio/industrialio-core.c
> > > > +++ b/drivers/iio/industrialio-core.c
> > > > @@ -758,9 +758,11 @@ static ssize_t iio_read_channel_info(struct de=
vice *dev,
> > > >                                                       INDIO_MAX_RAW=
_ELEMENTS,
> > > >                                                       vals, &val_le=
n,
> > > >                                                       this_attr->ad=
dress);
> > > > -     else
> > > > +     else if (indio_dev->info->read_raw)
> > > >               ret =3D indio_dev->info->read_raw(indio_dev, this_att=
r->c,
> > > >                                   &vals[0], &vals[1], this_attr->ad=
dress);
> > > > +     else
> > > > +             return -EINVAL;
> > > >
> > > >       if (ret < 0)
> > > >               return ret;
> > > > @@ -842,6 +844,9 @@ static ssize_t iio_read_channel_info_avail(stru=
ct device *dev,
> > > >       int length;
> > > >       int type;
> > > >
> > > > +     if (!indio_dev->info->read_avail)
> > > > +             return -EINVAL;
> > > > +
> > > >       ret =3D indio_dev->info->read_avail(indio_dev, this_attr->c,
> > > >                                         &vals, &type, &length,
> > > >                                         this_attr->address);
> > > > diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industr=
ialio-event.c
> > > > index 910c1f14abd5..a64f8fbac597 100644
> > > > --- a/drivers/iio/industrialio-event.c
> > > > +++ b/drivers/iio/industrialio-event.c
> > > > @@ -285,6 +285,9 @@ static ssize_t iio_ev_state_store(struct device=
 *dev,
> > > >       if (ret < 0)
> > > >               return ret;
> > > >
> > > > +     if (!indio_dev->info->write_event_config)
> > > > +             return -EINVAL;
> > > > +
> > > >       ret =3D indio_dev->info->write_event_config(indio_dev,
> > > >               this_attr->c, iio_ev_attr_type(this_attr),
> > > >               iio_ev_attr_dir(this_attr), val);
> > > > @@ -300,6 +303,9 @@ static ssize_t iio_ev_state_show(struct device =
*dev,
> > > >       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> > > >       int val;
> > > >
> > > > +     if (!indio_dev->info->read_event_config)
> > > > +             return -EINVAL;
> > > > +
> > > >       val =3D indio_dev->info->read_event_config(indio_dev,
> > > >               this_attr->c, iio_ev_attr_type(this_attr),
> > > >               iio_ev_attr_dir(this_attr));
> > > > @@ -318,6 +324,9 @@ static ssize_t iio_ev_value_show(struct device =
*dev,
> > > >       int val, val2, val_arr[2];
> > > >       int ret;
> > > >
> > > > +     if (!indio_dev->info->read_event_value)
> > > > +             return -EINVAL;
> > > > +
> > > >       ret =3D indio_dev->info->read_event_value(indio_dev,
> > > >               this_attr->c, iio_ev_attr_type(this_attr),
> > > >               iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_att=
r),
> > > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > > index 52d773261828..74f87f6ac390 100644
> > > > --- a/drivers/iio/inkern.c
> > > > +++ b/drivers/iio/inkern.c
> > > > @@ -560,9 +560,11 @@ static int iio_channel_read(struct iio_channel=
 *chan, int *val, int *val2,
> > > >                                       vals, &val_len, info);
> > > >               *val =3D vals[0];
> > > >               *val2 =3D vals[1];
> > > > -     } else {
> > > > +     } else if (chan->indio_dev->info->read_raw) {
> > > >               ret =3D chan->indio_dev->info->read_raw(chan->indio_d=
ev,
> > > >                                       chan->channel, val, val2, inf=
o);
> > > > +     } else {
> > > > +             return -EINVAL;
> > > >       }
> > > >
> > > >       return ret;
> > > > @@ -753,8 +755,10 @@ static int iio_channel_read_avail(struct iio_c=
hannel *chan,
> > > >       if (!iio_channel_has_available(chan->channel, info))
> > > >               return -EINVAL;
> > > >
> > > > -     return chan->indio_dev->info->read_avail(chan->indio_dev, cha=
n->channel,
> > > > -                                              vals, type, length, =
info);
> > > > +     if (chan->indio_dev->info->read_avail)
> > > > +             return chan->indio_dev->info->read_avail(chan->indio_=
dev, chan->channel,
> > > > +                                                      vals, type, =
length, info);
> > > > +     return -EINVAL;
> > > >  }
> > > >
> > > >  int iio_read_avail_channel_attribute(struct iio_channel *chan,
> > > > @@ -917,8 +921,10 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
> > > >  static int iio_channel_write(struct iio_channel *chan, int val, in=
t val2,
> > > >                            enum iio_chan_info_enum info)
> > > >  {
> > > > -     return chan->indio_dev->info->write_raw(chan->indio_dev,
> > > > -                                             chan->channel, val, v=
al2, info);
> > > > +     if (chan->indio_dev->info->write_raw)
> > > > +             return chan->indio_dev->info->write_raw(chan->indio_d=
ev,
> > > > +                                                     chan->channel=
, val, val2, info);
> > > > +     return -EINVAL;
> > > >  }
> > > >
> > > >  int iio_write_channel_attribute(struct iio_channel *chan, int val,=
 int val2,
> > > >
> > > > ---
> > > > base-commit: 409b6d632f5078f3ae1018b6e43c32f2e12f6736
> > > > change-id: 20240528-iio-core-fix-segfault-aa74be7eee4a
> > > >
> > > > Best regards,   =20
> > >   =20
>=20


