Return-Path: <linux-iio+bounces-5446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911AA8D38DD
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B44BAB2711E
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61E14A4CE;
	Wed, 29 May 2024 14:12:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045154FAE;
	Wed, 29 May 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991931; cv=none; b=OpR0rgFl6jeUHL5+6aIQHCHLQXifpW5BA6NrZ2sDUuCW0JQo3qENRfa3Svucq8+32MTQBQ88DnINQuy3zTrr1swpJi2S0+JgHI5GqUXRMvmQ0fFfU2YsHXrMrypepYFA+mb7W1gDw4a5NVF2cEZ/o/4kQdutDE1254EoPn4zSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991931; c=relaxed/simple;
	bh=+scz4t99HrNfb43TGDs/Gk5/fHNulxEOPZbWLGxOB1k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otgL9jRvOESCNyHjNtZm+J5t8WLAoojdxsYTjAcRtPJuJwCaso8ca7xO3c2CA4ot+VIPUAVJjN7pZC7jSO/GbVpHIiRJow//VHeFHXXWk3HUG1h1wlSqiEIfI0qdH0/htMqJVinZYBUjpGzHLoE38Rv9mEfBBNomw0dIqrhmK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqBBK2sS0z6K9F7;
	Wed, 29 May 2024 22:11:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 29D78140A78;
	Wed, 29 May 2024 22:12:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 29 May
 2024 15:12:05 +0100
Date: Wed, 29 May 2024 15:12:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Julien Stephan <jstephan@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nuno Sa
	<nuno.sa@analog.com>
Subject: Re: [PATCH v2] driver: iio: add missing checks on iio_info's
 callback access
Message-ID: <20240529151204.00001293@Huawei.com>
In-Reply-To: <CAEHHSvZFfV9mMjnGprqfU-NyCFCdkTLCmfy8K6Ey83-Yg_wA6A@mail.gmail.com>
References: <20240529-iio-core-fix-segfault-v2-1-7b5a5fa6853f@baylibre.com>
	<20240529130458.000049e6@Huawei.com>
	<CAEHHSvZFfV9mMjnGprqfU-NyCFCdkTLCmfy8K6Ey83-Yg_wA6A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 29 May 2024 15:10:42 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Le mer. 29 mai 2024 =E0 14:05, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> a =E9crit :
> >
> > On Wed, 29 May 2024 13:55:52 +0200
> > Julien Stephan <jstephan@baylibre.com> wrote:
> > =20
> > > Some callbacks from iio_info structure are accessed without any check=
, so
> > > if a driver doesn't implement them trying to access the corresponding
> > > sysfs entries produce a kernel oops such as:
> > >
> > > [ 2203.527791] Unable to handle kernel NULL pointer dereference at vi=
rtual address 00000000 when execute
> > > [...]
> > > [ 2203.783416] Call trace:
> > > [ 2203.783429]  iio_read_channel_info_avail from dev_attr_show+0x18/0=
x48
> > > [ 2203.789807]  dev_attr_show from sysfs_kf_seq_show+0x90/0x120
> > > [ 2203.794181]  sysfs_kf_seq_show from seq_read_iter+0xd0/0x4e4
> > > [ 2203.798555]  seq_read_iter from vfs_read+0x238/0x2a0
> > > [ 2203.802236]  vfs_read from ksys_read+0xa4/0xd4
> > > [ 2203.805385]  ksys_read from ret_fast_syscall+0x0/0x54
> > > [ 2203.809135] Exception stack(0xe0badfa8 to 0xe0badff0)
> > > [ 2203.812880] dfa0:                   00000003 b6f10f80 00000003 b6e=
ab000 00020000 00000000
> > > [ 2203.819746] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 000=
00000 00020000 00000000
> > > [ 2203.826619] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0
> > > [ 2203.830363] Code: bad PC value
> > > [ 2203.832695] ---[ end trace 0000000000000000 ]---
> > >
> > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com> =20
> >
> > How bad would a registration time check look?
> > I'd rather catch this early than have drivers with missing hooks
> > that we don't notice because no one pokes the file. =20
>=20
> Hi Jonathan,
>=20
> Do you mean something like that (as it is done for ext_info for example) :
>=20
> ret =3D __iio_add_chan_devattr(iio_chan_info_postfix[i],
>                  chan,
> -                &iio_read_channel_info,
> -                &iio_write_channel_info,
> +                indio_dev->info->read_raw ?
> +                    &iio_read_channel_info : NULL,

Doesn't work because of the read_raw_multi callback, but otherwise
this does improve our permissions handling a little at least.
It 'might' be considered an ABI change though :(

> +                indio_dev->info->write_raw ?
> +                    &iio_write_channel_info : NULL,
>                  i,
>                  shared_by,
>                  &indio_dev->dev,
>                  NULL,
>                  &iio_dev_opaque->channel_attr_list);
>=20
> Or do you want to check even before and do not create the  sysfs
> entry if there is no callback registered by the driver?

I was thinking a much more stupid option of a missing read_raw
and read_raw_multi + anything in the info_masks pretty much
indicates a bug.

I don't think we have any 'write only' attributes

Similar for read_event_config, though write_event_config is
trickier as we 'might' one day have a device where the events
are all fixed value and always on (so read only).

Perhaps what you have here is the simplest option as the exact
rules for what callbacks are provided area bit messy so checking
at use is fine.

However I'd like to see some scattered use of local variables like
in inkern.c
struct iio_info *info =3D chan->indio_dev->info;
to reduce the long lines.


>=20
> Julien
>=20
> >
> > The inkern ones are good though.
> >
> > Jonathan
> > =20
> > > ---
> > > Changes in v2:
> > > - crop dmesg log to show only pertinent info and reduce commit message
> > > - Link to v1: https://lore.kernel.org/r/20240529-iio-core-fix-segfaul=
t-v1-1-7ff1ba881d38@baylibre.com
> > > ---
> > >  drivers/iio/industrialio-core.c  |  7 ++++++-
> > >  drivers/iio/industrialio-event.c |  9 +++++++++
> > >  drivers/iio/inkern.c             | 16 +++++++++++-----
> > >  3 files changed, 26 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrial=
io-core.c
> > > index fa7cc051b4c4..2f185b386949 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -758,9 +758,11 @@ static ssize_t iio_read_channel_info(struct devi=
ce *dev,
> > >                                                       INDIO_MAX_RAW_E=
LEMENTS,
> > >                                                       vals, &val_len,
> > >                                                       this_attr->addr=
ess);
> > > -     else
> > > +     else if (indio_dev->info->read_raw)
> > >               ret =3D indio_dev->info->read_raw(indio_dev, this_attr-=
>c,
> > >                                   &vals[0], &vals[1], this_attr->addr=
ess);
> > > +     else
> > > +             return -EINVAL;
> > >
> > >       if (ret < 0)
> > >               return ret;
> > > @@ -842,6 +844,9 @@ static ssize_t iio_read_channel_info_avail(struct=
 device *dev,
> > >       int length;
> > >       int type;
> > >
> > > +     if (!indio_dev->info->read_avail)
> > > +             return -EINVAL;
> > > +
> > >       ret =3D indio_dev->info->read_avail(indio_dev, this_attr->c,
> > >                                         &vals, &type, &length,
> > >                                         this_attr->address);
> > > diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industria=
lio-event.c
> > > index 910c1f14abd5..a64f8fbac597 100644
> > > --- a/drivers/iio/industrialio-event.c
> > > +++ b/drivers/iio/industrialio-event.c
> > > @@ -285,6 +285,9 @@ static ssize_t iio_ev_state_store(struct device *=
dev,
> > >       if (ret < 0)
> > >               return ret;
> > >
> > > +     if (!indio_dev->info->write_event_config)
> > > +             return -EINVAL;
> > > +
> > >       ret =3D indio_dev->info->write_event_config(indio_dev,
> > >               this_attr->c, iio_ev_attr_type(this_attr),
> > >               iio_ev_attr_dir(this_attr), val);
> > > @@ -300,6 +303,9 @@ static ssize_t iio_ev_state_show(struct device *d=
ev,
> > >       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> > >       int val;
> > >
> > > +     if (!indio_dev->info->read_event_config)
> > > +             return -EINVAL;
> > > +
> > >       val =3D indio_dev->info->read_event_config(indio_dev,
> > >               this_attr->c, iio_ev_attr_type(this_attr),
> > >               iio_ev_attr_dir(this_attr));
> > > @@ -318,6 +324,9 @@ static ssize_t iio_ev_value_show(struct device *d=
ev,
> > >       int val, val2, val_arr[2];
> > >       int ret;
> > >
> > > +     if (!indio_dev->info->read_event_value)
> > > +             return -EINVAL;
> > > +
> > >       ret =3D indio_dev->info->read_event_value(indio_dev,
> > >               this_attr->c, iio_ev_attr_type(this_attr),
> > >               iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
> > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > index 52d773261828..74f87f6ac390 100644
> > > --- a/drivers/iio/inkern.c
> > > +++ b/drivers/iio/inkern.c
> > > @@ -560,9 +560,11 @@ static int iio_channel_read(struct iio_channel *=
chan, int *val, int *val2,
> > >                                       vals, &val_len, info);
> > >               *val =3D vals[0];
> > >               *val2 =3D vals[1];
> > > -     } else {
> > > +     } else if (chan->indio_dev->info->read_raw) {
> > >               ret =3D chan->indio_dev->info->read_raw(chan->indio_dev,
> > >                                       chan->channel, val, val2, info);
> > > +     } else {
> > > +             return -EINVAL;
> > >       }
> > >
> > >       return ret;
> > > @@ -753,8 +755,10 @@ static int iio_channel_read_avail(struct iio_cha=
nnel *chan,
> > >       if (!iio_channel_has_available(chan->channel, info))
> > >               return -EINVAL;
> > >
> > > -     return chan->indio_dev->info->read_avail(chan->indio_dev, chan-=
>channel,
> > > -                                              vals, type, length, in=
fo);
> > > +     if (chan->indio_dev->info->read_avail)
> > > +             return chan->indio_dev->info->read_avail(chan->indio_de=
v, chan->channel,
> > > +                                                      vals, type, le=
ngth, info);
> > > +     return -EINVAL;
> > >  }
> > >
> > >  int iio_read_avail_channel_attribute(struct iio_channel *chan,
> > > @@ -917,8 +921,10 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
> > >  static int iio_channel_write(struct iio_channel *chan, int val, int =
val2,
> > >                            enum iio_chan_info_enum info)
> > >  {
> > > -     return chan->indio_dev->info->write_raw(chan->indio_dev,
> > > -                                             chan->channel, val, val=
2, info);
> > > +     if (chan->indio_dev->info->write_raw)
> > > +             return chan->indio_dev->info->write_raw(chan->indio_dev,
> > > +                                                     chan->channel, =
val, val2, info);
> > > +     return -EINVAL;
> > >  }
> > >
> > >  int iio_write_channel_attribute(struct iio_channel *chan, int val, i=
nt val2,
> > >
> > > ---
> > > base-commit: 409b6d632f5078f3ae1018b6e43c32f2e12f6736
> > > change-id: 20240528-iio-core-fix-segfault-aa74be7eee4a
> > >
> > > Best regards, =20
> > =20


