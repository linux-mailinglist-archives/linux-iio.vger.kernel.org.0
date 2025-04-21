Return-Path: <linux-iio+bounces-18443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333CEA951B4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000C7188BBA2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE41C84D5;
	Mon, 21 Apr 2025 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpQCjKI6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1821DA5F;
	Mon, 21 Apr 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242322; cv=none; b=cwbMuz8JFUWhdzSiD0hqIzJr4xAchtaYgRZvgy5P9vJPSAzFiXyYH9R4QzE32iyc+EDPI5XtPMmLik+b5vLBzH44W1J+8mtmwR0nfjKVvmDKfWL5525Qi++NEXOSMzSQIlSYhDUfj7g5fls4MJrUXr/3WbwBUG3BpEbwt3g8zYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242322; c=relaxed/simple;
	bh=SOUXB+XLo3RVrqun/1dqKWWgzYLhD3puqKOiWbAEb6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pz4NZ8EbOzSY8AkaRdAnXSvVjXe6I+9WhrFLNwyrQoamukg6hi+KMXuPG+NzXbELgBJsXYHrrx4RRKDhzCOuNNhiwVDcc/d3yy4iQEdevNpJm4iJlxdB2I5f/AR891gNhvIlrau8KzveU99Ji5w5i4WgwSv1kybRAekAi5mr0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpQCjKI6; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e707fba5a16so526300276.3;
        Mon, 21 Apr 2025 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745242315; x=1745847115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtWwnMSHkXzYpJzc0lLyFE6GguOxoOAADBGVqqmTflo=;
        b=IpQCjKI6Buz2HI1vYb/ZRyVe9T6LsvK231HGBSr2R/OtPNr8DKwrdEyQC505kPqWd3
         9b5nQalcApD7TMMCSla2N1oA/poT4PYI74xkat0wdW4Qwa1vtRd1ZBVhG3Xzdge8ZqlI
         3FnHhd0K5sS8zojZL5io5VmN2s2u/+m8zddrSgunxsX9AqUF1WWeXikDSDfD60bB0Ph2
         +WzUXK12pKM9To/QWAukCVWe0IqfbijVobq1GdP8yJd9w74+UXSdVK18NMgUsWUiNYfd
         laBCYbUMJrioaL+ky2Bq2SeyUwSH/9qW5hP8wiFn84u12VGNV/y30JiPtMTNs0RFhUAr
         9veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745242315; x=1745847115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtWwnMSHkXzYpJzc0lLyFE6GguOxoOAADBGVqqmTflo=;
        b=GUew5oqHByH7FXqj8qkIrBOtQM6h8RxbCuZbwPdXqHuPOfhFsISk39N7Nq21GYFDQr
         EpCKqtn332EgLbZvobBiPFDkF/9gfpzcHUrGjC+lhwxgoZTySwxF4pjq3P/YTWtz6IDY
         iafcj/DJpFW8+10xe9fmRXKFg5w5l8FIOaqWFdQ7d9To4Fr4gIgJLIhFXQiWIxxYLFzZ
         /MrbLKULD7B9OPQJXWmp73lxHYV8xX/J7d+XD3MVGGmCQaUXG4D3YgiXLP5wMMDpF15s
         sE32ioJ5pExD42abiOhCsNdI1VAd4xjBueRF+KAOc+6eysTiVpE44VciyCwHxMiH2Btx
         vjZA==
X-Forwarded-Encrypted: i=1; AJvYcCVG0ep7+okU4msByFxbQFB0axbWmvUMkBL9JGnPKE3xohXZRlzSLIXRhE8iuCzg47wCYGUcE5euwVM=@vger.kernel.org, AJvYcCW7HNQhvc1JdR7T4UIO30aQzpmtmMirwRS3uDh9U5FqxLo3/u7EH4HkMDqvk7wiaISqazpmb23jJdvTb0l5@vger.kernel.org
X-Gm-Message-State: AOJu0YyCObLcg4oVBLUD5HJ/6GluZTp8HXw8eBdbt5tWHb6U9fJT7/HL
	DMt4n5z4PxlqQh/toy6LD5hX85XMYMgsshOSH1UJ+5zL196YAL0N29W+CG5+gjkFzcg9KFB/ITP
	LSbQezs9cl3hCEpAc1gKHKZTXkEw=
X-Gm-Gg: ASbGncsqi9QNA7BJAoZJ+mzLOmRMh/eKAaSLHeDpOhsa/TLC6/p/w2UoxoWivWw3bO+
	HETF6yubue/TEtPSxhoUVUGJXUCeCHmck/lVFhwzS7MlfMV25JXMGF4G9N0mdrNNp/cV1CGKAVX
	+QrgxeT5DIuIB0F5GFxLd585sAINex8wjo
X-Google-Smtp-Source: AGHT+IF40leAatmdukvCRVcVVdM/HT0iH36Z1JrSV4ebiR9mZodiv0beXxuBkeElt4YKO1uW7LSJjXNIs4eynI/uwtQ=
X-Received: by 2002:a05:6902:2489:b0:e5d:ad43:9b33 with SMTP id
 3f1490d57ef6-e7297d9350emr7222586276.1.1745242315388; Mon, 21 Apr 2025
 06:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414184245.100280-1-l.rubusch@gmail.com> <20250414184245.100280-6-l.rubusch@gmail.com>
 <20250418192254.0becd27d@jic23-huawei> <CAFXKEHZNmUsUmheyDdh1bDDf97-7ZTpsm2xqqbwT+hq3K58F5A@mail.gmail.com>
 <20250421111641.1cb83848@jic23-huawei>
In-Reply-To: <20250421111641.1cb83848@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 21 Apr 2025 15:31:19 +0200
X-Gm-Features: ATxdqUFsiAzU-ZTy1-eqcj_UGy5kYSRwQDOvQuoeQd2lnps6w20CrBjxei8B-QI
Message-ID: <CAFXKEHaG2EBkoc5Zx=oCEePA3nwApRWAg1pGsQ-_68OY2esYVQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] iio: accel: adxl345: add freefall feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 12:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sun, 20 Apr 2025 23:26:47 +0200
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Happy Easter!
> >
> > On Fri, Apr 18, 2025 at 8:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Mon, 14 Apr 2025 18:42:39 +0000
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > Add the freefall detection of the sensor together with a threshold =
and
> > > > time parameter. A freefall event is detected if the measuring signa=
l
> > > > falls below the threshold.
> > > >
> > > > Introduce a freefall threshold stored in regmap cache, and a freefa=
ll
> > > > time, having the scaled time value stored as a member variable in t=
he
> > > > state instance.
> > > >
> > > Reading this I wondered whether we had the event code consistent for
> > > freefall detectors... Or indeed inactivity ones (which are kind of si=
milarish)
> > >
> > > :( We don't it seems.  The issue is that
> > > freefall is actually that all channels are simultaneously under the t=
he magnitude
> > > threshold, not one of them.  So it should I think be
> > > X_AND_Y_AND_Z not X_OR_Y_OR_Z
> > >
> >
> > I change to X_AND_Y_AND_Z.
> >
> > > This is as opposed to activity detectors which tend to be any axis sh=
ows
> > > activity and X_OR_Y_OR_Z applies.
> > >
> > > Anyhow upshot is I think I lead you astray on this and we should make=
 this
> > > one IIO_MOD_X_AND_Y_AND_Z
> > >
> > > A few other things inline.
> > >
> > > Unfortunately we don't deal with these events that often so I forget
> > > what we did before :(
> > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > ---
> > > >  drivers/iio/accel/adxl345_core.c | 125 +++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 125 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/a=
dxl345_core.c
> > > > index c464c87033fb..ae02826e552b 100644
> > > > --- a/drivers/iio/accel/adxl345_core.c
> > > > +++ b/drivers/iio/accel/adxl345_core.c
> > > > @@ -75,6 +75,7 @@ struct adxl345_state {
> > > >       u32 tap_duration_us;
> > > >       u32 tap_latent_us;
> > > >       u32 tap_window_us;
> > > > +     u32 ff_time_ms;
> > > >
> > > >       __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __align=
ed(IIO_DMA_MINALIGN);
> > > >  };
> > > > @@ -96,6 +97,14 @@ static struct iio_event_spec adxl345_events[] =
=3D {
> > > >                       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> > > >                       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> > > >       },
> > > > +     {
> > > > +             /* free fall */
> > > > +             .type =3D IIO_EV_TYPE_MAG,
> > > > +             .dir =3D IIO_EV_DIR_FALLING,
> > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE) |
> > > > +                     BIT(IIO_EV_INFO_VALUE) |
> > > > +                     BIT(IIO_EV_INFO_PERIOD),
> > > > +     },
> > > This is creating separate per axis enables, values and period. Does t=
hat make
> > > sense?  If not you need to spin a kind of virtual channel (with mod X=
_AND_Y_AND_Z)
> > > and add the events to it.
> > >
> > > See how the sca3000 does it for example.
> >
> > Hum, I'm not sure if I understand you correctly. In my driver, I'm
> > using .mask_shared_by_type, and I verified there appears only one
> > enable, one value and one period handle.
> > # ls -l /sys/bus/iio/devices/iio:device0/events/
> > total 0
> > ...
> > -rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_en
> > -rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_period
> > -rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_value
> > ...
> >
> > In the sources of sca3000.c I saw this setup with .mask_separate. So,
> > there I'd expect to see separate enables per axis, or am I wrong? In
> > the case of the ADXL345, there should only be one freefall enable (in
> > my driver) and not per axis. So, isn't this what is currently there?
> >
> > So far I only adjust the or'ing to and'ing the axis for freefall.
>
> So this is a messy corner of the ABI (because these are tricky to describ=
e).
> Shared by type usually means there is one attribute applying to all the
> axis, but that they are reported separately, or potentially multiple even=
ts
> / _OR_ form used if we can distinguish exactly what the event is.
>
> In this case there is no way for userspace to anticipate that the event
> that might be generate is X_AND_Y_AND_Z.  So for this
> the ABI solution we came up with is that virtual channel and separate.
>
> So you get something along the lines of
> in_accel_x&y&z_mag_falling_en
> in_accel_x&y&z_mag_falling_period
> etc
>
> The tricky remaining corner is this only makes sense if we always enable
> all axis (which is typical for a freefall detector). If we get a device
> that oddly has per axis free fall enables, then it would be hard and I
> might argue nonsense to enable them separately anyway.  Not true
> here though I think.
>
> Note that we may well have drivers using the ABI slightly differently for
> freefall events which will be at least partly because I'd forgotten how
> we resolved all this complexity long ago (that sca3000 driver is ancient!=
)
> ABI like this is tricky to fix up, but we might want to consider some dup=
lication
> in those drivers so we standardize on one form for freefall (even if we h=
ave some
> stray ABI from other possible solutions).
>
> What we should definitely do is pull together some documentation on multi=
 channel
> event handling as the ABI docs are probably not enough.
>

As I (begin to) understand now, in case of the sca3000, the virtual
channel is literally an extra channel. That means, we're talking
probably about this here down below, right?
...
 512 static const struct iio_chan_spec sca3000_channels[] =3D {
 513         SCA3000_CHAN(0, IIO_MOD_X),
 514         SCA3000_CHAN(1, IIO_MOD_Y),
 515         SCA3000_CHAN(2, IIO_MOD_Z),
 516         {
 517                 .type =3D IIO_ACCEL,
 518                 .modified =3D 1,
 519                 .channel2 =3D IIO_MOD_X_AND_Y_AND_Z,
 520                 .scan_index =3D -1, /* Fake channel */
 521                 .event_spec =3D &sca3000_freefall_event_spec,
 522                 .num_event_specs =3D 1,
 523         },
 524 };
...
<taken from sca3000.c>

What's now missing for freefall and the ADXL345 and v7 in particular?
- I need to provide a similar channel setup as in  the sca3000 snippet
above, the virtual channel
- I need to AND the axis for this channel
- Now, with the virtual channel usage will be "separate" instead of
"shared", which will result in a single enable handle in sysfs

Is this correct?

Sry, I needed to re-read your answer several times. What confuses me
is still a bit the "virtual extra-channel". Probably, I need to build
up a bit more practical experience with the channels. Providing just a
single enable handle already looks good to me. I still don't grok
entirely where this can be / is problematic in such case, but no need
to explain it now in full detail. If the TODOs match at least with my
understanding I will try to implement the above points.

> Jonathan
>

