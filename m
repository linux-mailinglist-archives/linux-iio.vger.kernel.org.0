Return-Path: <linux-iio+bounces-5443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4928D3730
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AF12877E2
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA8412B77;
	Wed, 29 May 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wrNHQVYu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB1E542
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988259; cv=none; b=sNB0K1ofjhY92FK2/lU/ZwhJhAW92xhnozoFSpiyrA5Eeo9KRxNXjRWYvs8NT+yNbTFD3tXAjf6nUobpVAdzAqS4Vz1m0LvaduJWmLEAWh9Pwitz1Y4IZfCqL5nSBILrYwGlPoQMRMBE3ft2UlasJrITyVE1vrpqL5Nxfwsz0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988259; c=relaxed/simple;
	bh=27tuP5wl143oePuzHxzCglDI6RFchxnmMb1lpfU7CoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNn6BoanKlSXzmEDnfKEiqeXTPN9ltV8us3QAhyroQ+4xKTkoERw3bi7eKYZhGFuz8+miXwTUC8l3yHhsLSXpp5JsBxNIg8sDs2w0pnF5kLrJuheSNno4DWnGW/zBL07AxlLMZZwgSg/Ajw4v+ZkUlDAPzR/9XKhFqhVM9Jf38c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wrNHQVYu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a635a74e0deso161198166b.0
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716988254; x=1717593054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azRDT6gpTMZiud8t7xJbr3kGPCFGLs0Glt2PXkWkLkE=;
        b=wrNHQVYu4LB4eygkJBVjb90ryHlDJ3O8BJs6maUhaA4/kgeZEL9zqvCKrFaFvbZgK1
         yDhB8shkMDCdRWN3Jqhd4KLoYE9TvrFTOCl8k3ZKaTPpu1QHMiLM83ekEs/QqEz25NKh
         0thSDh+h82RYblJAwoCKKtdS28Kc8iT5wSJS63+8x8hoQ0R1qBDZJ27noc2Qu3ptZ6T+
         I+YLs2opESyRECfUbMBCvTKGTjp7PoQE78UA3ctDMIwKXaKxGVfCFlFajlAkMzWORjYr
         uxYIZFkO3TbvUVsWR6ecYc2npPODoqyTjsi7Wna9w0/IqHBmauo0f9Jzwapnc8RSMYoC
         ER3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716988254; x=1717593054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azRDT6gpTMZiud8t7xJbr3kGPCFGLs0Glt2PXkWkLkE=;
        b=Af5UOBwR0dqcR7teWT33DAPjA4s990Tc4JvniZdd7IEl5HSYv1OYUoxSu3osb6/WdK
         B1dM1AS8zFj8rh3pSEQF1PL+RPeZAq8PPT1VwigwzOZkUgP/oPRuxRBgO5LBspd2m6Sa
         jvVBc+IXXcJOy7SY1DRZ1n5O/kf+J2DEUHbHu7NHsxWW5jcxkJvqw/JwhXjmOV4us6Hg
         J+iey6XpLrs3AvDIyphdxInhqYLPOe6b4wSyk12LU3nqbwEbx6dMgP178fruEaOs1jLX
         CUkwT5cycvIIkkWJNg1b0TiKe9pzStvxajT386WgrrHKahEadGL7JH7V1BQuBh2Vlc6U
         EmyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGu2Xm0UaJ1s2stRFf7WTVTzwHYsxRk0xoS4KYUKtONvZInh/q2ZXEOp1Pjeuke75vWfem+LHVCr8JByejIpo1vGa4gH6Oso9M
X-Gm-Message-State: AOJu0YyX47rwDR0BDDHbeJHO7WgM1VT/of+gKpASm3SIAkVcRjqU2Orn
	i1j9Wm/e17UAbE/lCfmN4SYN4ohpkPJ+5y5w2WmCCC+WQ/Btw32hFmqmYf8lzVBMZj6cMnUhLh6
	AQ2FeYYNanANgAeeptoslHdSHrqJjKKssukcetQ==
X-Google-Smtp-Source: AGHT+IHA7ognnhG0bvxa1m4QF32kWlCkzx0bjiSWoLlCWaUy6x0QDo83C7OTeOAS/73vId94RFnpGWM0RP/6IJZ1XVE=
X-Received: by 2002:a17:906:f0d1:b0:a62:80f4:9ef2 with SMTP id
 a640c23a62f3a-a6280f4a19emr916098366b.71.1716988254571; Wed, 29 May 2024
 06:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-iio-core-fix-segfault-v2-1-7b5a5fa6853f@baylibre.com> <20240529130458.000049e6@Huawei.com>
In-Reply-To: <20240529130458.000049e6@Huawei.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 May 2024 15:10:42 +0200
Message-ID: <CAEHHSvZFfV9mMjnGprqfU-NyCFCdkTLCmfy8K6Ey83-Yg_wA6A@mail.gmail.com>
Subject: Re: [PATCH v2] driver: iio: add missing checks on iio_info's callback access
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 29 mai 2024 =C3=A0 14:05, Jonathan Cameron
<Jonathan.Cameron@huawei.com> a =C3=A9crit :
>
> On Wed, 29 May 2024 13:55:52 +0200
> Julien Stephan <jstephan@baylibre.com> wrote:
>
> > Some callbacks from iio_info structure are accessed without any check, =
so
> > if a driver doesn't implement them trying to access the corresponding
> > sysfs entries produce a kernel oops such as:
> >
> > [ 2203.527791] Unable to handle kernel NULL pointer dereference at virt=
ual address 00000000 when execute
> > [...]
> > [ 2203.783416] Call trace:
> > [ 2203.783429]  iio_read_channel_info_avail from dev_attr_show+0x18/0x4=
8
> > [ 2203.789807]  dev_attr_show from sysfs_kf_seq_show+0x90/0x120
> > [ 2203.794181]  sysfs_kf_seq_show from seq_read_iter+0xd0/0x4e4
> > [ 2203.798555]  seq_read_iter from vfs_read+0x238/0x2a0
> > [ 2203.802236]  vfs_read from ksys_read+0xa4/0xd4
> > [ 2203.805385]  ksys_read from ret_fast_syscall+0x0/0x54
> > [ 2203.809135] Exception stack(0xe0badfa8 to 0xe0badff0)
> > [ 2203.812880] dfa0:                   00000003 b6f10f80 00000003 b6eab=
000 00020000 00000000
> > [ 2203.819746] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 00000=
000 00020000 00000000
> > [ 2203.826619] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0
> > [ 2203.830363] Code: bad PC value
> > [ 2203.832695] ---[ end trace 0000000000000000 ]---
> >
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
> How bad would a registration time check look?
> I'd rather catch this early than have drivers with missing hooks
> that we don't notice because no one pokes the file.

Hi Jonathan,

Do you mean something like that (as it is done for ext_info for example) :

ret =3D __iio_add_chan_devattr(iio_chan_info_postfix[i],
                 chan,
-                &iio_read_channel_info,
-                &iio_write_channel_info,
+                indio_dev->info->read_raw ?
+                    &iio_read_channel_info : NULL,
+                indio_dev->info->write_raw ?
+                    &iio_write_channel_info : NULL,
                 i,
                 shared_by,
                 &indio_dev->dev,
                 NULL,
                 &iio_dev_opaque->channel_attr_list);

Or do you want to check even before and do not create the  sysfs
entry if there is no callback registered by the driver?

Julien

>
> The inkern ones are good though.
>
> Jonathan
>
> > ---
> > Changes in v2:
> > - crop dmesg log to show only pertinent info and reduce commit message
> > - Link to v1: https://lore.kernel.org/r/20240529-iio-core-fix-segfault-=
v1-1-7ff1ba881d38@baylibre.com
> > ---
> >  drivers/iio/industrialio-core.c  |  7 ++++++-
> >  drivers/iio/industrialio-event.c |  9 +++++++++
> >  drivers/iio/inkern.c             | 16 +++++++++++-----
> >  3 files changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index fa7cc051b4c4..2f185b386949 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -758,9 +758,11 @@ static ssize_t iio_read_channel_info(struct device=
 *dev,
> >                                                       INDIO_MAX_RAW_ELE=
MENTS,
> >                                                       vals, &val_len,
> >                                                       this_attr->addres=
s);
> > -     else
> > +     else if (indio_dev->info->read_raw)
> >               ret =3D indio_dev->info->read_raw(indio_dev, this_attr->c=
,
> >                                   &vals[0], &vals[1], this_attr->addres=
s);
> > +     else
> > +             return -EINVAL;
> >
> >       if (ret < 0)
> >               return ret;
> > @@ -842,6 +844,9 @@ static ssize_t iio_read_channel_info_avail(struct d=
evice *dev,
> >       int length;
> >       int type;
> >
> > +     if (!indio_dev->info->read_avail)
> > +             return -EINVAL;
> > +
> >       ret =3D indio_dev->info->read_avail(indio_dev, this_attr->c,
> >                                         &vals, &type, &length,
> >                                         this_attr->address);
> > diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industriali=
o-event.c
> > index 910c1f14abd5..a64f8fbac597 100644
> > --- a/drivers/iio/industrialio-event.c
> > +++ b/drivers/iio/industrialio-event.c
> > @@ -285,6 +285,9 @@ static ssize_t iio_ev_state_store(struct device *de=
v,
> >       if (ret < 0)
> >               return ret;
> >
> > +     if (!indio_dev->info->write_event_config)
> > +             return -EINVAL;
> > +
> >       ret =3D indio_dev->info->write_event_config(indio_dev,
> >               this_attr->c, iio_ev_attr_type(this_attr),
> >               iio_ev_attr_dir(this_attr), val);
> > @@ -300,6 +303,9 @@ static ssize_t iio_ev_state_show(struct device *dev=
,
> >       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> >       int val;
> >
> > +     if (!indio_dev->info->read_event_config)
> > +             return -EINVAL;
> > +
> >       val =3D indio_dev->info->read_event_config(indio_dev,
> >               this_attr->c, iio_ev_attr_type(this_attr),
> >               iio_ev_attr_dir(this_attr));
> > @@ -318,6 +324,9 @@ static ssize_t iio_ev_value_show(struct device *dev=
,
> >       int val, val2, val_arr[2];
> >       int ret;
> >
> > +     if (!indio_dev->info->read_event_value)
> > +             return -EINVAL;
> > +
> >       ret =3D indio_dev->info->read_event_value(indio_dev,
> >               this_attr->c, iio_ev_attr_type(this_attr),
> >               iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index 52d773261828..74f87f6ac390 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -560,9 +560,11 @@ static int iio_channel_read(struct iio_channel *ch=
an, int *val, int *val2,
> >                                       vals, &val_len, info);
> >               *val =3D vals[0];
> >               *val2 =3D vals[1];
> > -     } else {
> > +     } else if (chan->indio_dev->info->read_raw) {
> >               ret =3D chan->indio_dev->info->read_raw(chan->indio_dev,
> >                                       chan->channel, val, val2, info);
> > +     } else {
> > +             return -EINVAL;
> >       }
> >
> >       return ret;
> > @@ -753,8 +755,10 @@ static int iio_channel_read_avail(struct iio_chann=
el *chan,
> >       if (!iio_channel_has_available(chan->channel, info))
> >               return -EINVAL;
> >
> > -     return chan->indio_dev->info->read_avail(chan->indio_dev, chan->c=
hannel,
> > -                                              vals, type, length, info=
);
> > +     if (chan->indio_dev->info->read_avail)
> > +             return chan->indio_dev->info->read_avail(chan->indio_dev,=
 chan->channel,
> > +                                                      vals, type, leng=
th, info);
> > +     return -EINVAL;
> >  }
> >
> >  int iio_read_avail_channel_attribute(struct iio_channel *chan,
> > @@ -917,8 +921,10 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
> >  static int iio_channel_write(struct iio_channel *chan, int val, int va=
l2,
> >                            enum iio_chan_info_enum info)
> >  {
> > -     return chan->indio_dev->info->write_raw(chan->indio_dev,
> > -                                             chan->channel, val, val2,=
 info);
> > +     if (chan->indio_dev->info->write_raw)
> > +             return chan->indio_dev->info->write_raw(chan->indio_dev,
> > +                                                     chan->channel, va=
l, val2, info);
> > +     return -EINVAL;
> >  }
> >
> >  int iio_write_channel_attribute(struct iio_channel *chan, int val, int=
 val2,
> >
> > ---
> > base-commit: 409b6d632f5078f3ae1018b6e43c32f2e12f6736
> > change-id: 20240528-iio-core-fix-segfault-aa74be7eee4a
> >
> > Best regards,
>

