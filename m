Return-Path: <linux-iio+bounces-23509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A61F1B3D0FE
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 07:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BEF188CF75
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 05:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C2219A7D;
	Sun, 31 Aug 2025 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvV8fNNN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C5322E;
	Sun, 31 Aug 2025 05:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756618782; cv=none; b=Afzsczdt7uewDal61STAx7MYUevnp6iF9qxRxJEteO3g6ifuTO3+irh0Cg3GZXKPv8M0QDK25lMAwnrRLA498QarHzVLltjxFq+a9tq1G+AEhbZJv5iRQdywljF/AcnyhaK39UV6hi0OIerKeDcHihzmefWKeEdBOpKRpz8DHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756618782; c=relaxed/simple;
	bh=ZEDjqRou0x7QyAzDKo+ZHSBpmCk6HTsSCWQNsvMV9nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGGe82mRKcOUulAk5wA+q2lsG7GDcUAoOsc+9M9Jy7/HjrthzbgxqaBntAlzTl/D4q6QGaBlGZnBYFgv6ex8LxrHmTbn6X8Q4B0ZM9sBfDnqHitWD2LkUB1d3CG+Nj4uRmdTJdNgWUtEpKuxKTAQWqtIFXZhKXxHprDCzmaLguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvV8fNNN; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-336c2194a65so10270231fa.2;
        Sat, 30 Aug 2025 22:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756618778; x=1757223578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QscixRFaC53IASPKkWKF/cJ9bqxZobh83dxVhfExlRw=;
        b=dvV8fNNNNMzjoft4AgB9Tk2P0ARGM3MpVKOwEtUXhezKjrEwncusvARu8YpkCfQf+X
         VU6k5h9L4SDomE0c0Oa5fA/cFSDVD/bYtrIq2a4l/AU9zUkFjd53sKQDP1vxOUmPQxOh
         gdae+/2nR71/GiPiV4feG8Cvh3zSfK2SdqaydwiMQrqoqYtnrpWwRaQuhtto0ZPQAYOj
         UbHs7CBhbqsCKyO8OXcvE7eO/llibvHWsqZWd23DyWstEVTgsBKN0tHJiU12kNkuqPMF
         7H2/OWrgNgKkOznhiKiUrC3Yu0Q1Zz5Kj9s2IcShOKJKQ/96jlk5UbXbdJMl4jGQanwZ
         YqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756618778; x=1757223578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QscixRFaC53IASPKkWKF/cJ9bqxZobh83dxVhfExlRw=;
        b=LYcBMnx1BWLxLszVQn2rmiuM8g9y93iQQoWdZOABNCHd6jV0Ej/J/1w1UoU2VpMhe1
         eNKhOj/yD/CBGYsaNyOyo7yI8DuvJI+KMy0mmJLhdCsFH+oqnuxePYcuf4uUIH+lWUfn
         2OlTZvTDjbqs2rzdvmLcQn0cWShMdp2frBYo8d/8/X3xmxs2OTyEGNjtwcfYFqM9aVdf
         9QEOZGfRWYyreHJRc49woXd6PCLeFFa1l6/VMXW/ynV5+mTodJNNePINWbyaXxu6rF/4
         OGxogz+M2ToSfTKVXDMIdY1hFUc4gP+KJe76n5aSpwhjO8QnuQQivKTynh8KiEuqSPYr
         7z3A==
X-Forwarded-Encrypted: i=1; AJvYcCVaNgsSgB4MEvGbb0jhMZ/teMPtfYARiiHBwI9f9ShzswYb3MjDXYTDcuNLpxC8Td/HUEj/VK1jQP1qLvm/@vger.kernel.org, AJvYcCXc+SG8HJ6emremMQukhdBnioM0PIr6nwc0WbdzCDu/NusRWlpK11ulGRs5gcf1CD3WxKFk12kyGbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfW463nT9bjaLfjJvBR7+wIfVw+LmqYRURhQsg3FTBQy5zqo9+
	HeA0MhN0RzYWDOr1JaMP9ISJulEO8Dd+3ES7n9xlTPDDfP5Yqslc7X7GBnaTqWue7T2WRDyB8+p
	dYyMW6G8dOAEa2p8tH5O4emODOBQOqdo=
X-Gm-Gg: ASbGncukvDoKA6Ql9v489FfVp5Q20AocGZAXl9hDd673MGtIKH5i61W5eGTGGO3+0TM
	QvFKVFZDBNb5AybEHo6+2+MDRrwFIofmVf13ghVc6hx7FJ4CuDjWb1UOQ4cVShPj0vsxZpO9E8I
	9qwTYzdeZwDW95/2ocN6WwyeaAXamsU202PWfvXjwHb/ioRF9sW1H/bmUgYPLozTg6cPR8fuHrz
	B3PHOR5NzkzFf2ONg==
X-Google-Smtp-Source: AGHT+IFhHc/SAdyT5NmkARP+hrAIyJYIGUgFgZ15VyUmXIMsAEtDQo9afvPEn017CvRwRpWdsg3U6M9hCyR2Md4nvaQ=
X-Received: by 2002:a05:651c:3255:10b0:336:9232:fb91 with SMTP id
 38308e7fff4ca-336ca913952mr7137321fa.4.1756618777835; Sat, 30 Aug 2025
 22:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com> <20250830192538.3b508c5c@jic23-huawei>
In-Reply-To: <20250830192538.3b508c5c@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Sun, 31 Aug 2025 11:09:26 +0530
X-Gm-Features: Ac12FXwFXB1dR6rjJziuscfI4C-MGz0KehR0ns_CiUSgbMdu33dCKoikIymMFSs
Message-ID: <CAE3SzaSezCtZ24vz4_qSmLow_MfU3p7XgdVUBKD3Yj7LcAK-6g@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
To: Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 11:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sat, 30 Aug 2025 17:05:00 +0530
> Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
>
> > Implement runtime power management for the LTR390 sensor. The device
> > autosuspends after 1s of idle time, reducing current consumption from
> > 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the data=
sheet.
> >
> > Ensure that interrupts continue to be delivered with runtime PM.
> > Since the LTR390 cannot be used as a wakeup source during runtime
> > suspend, therefore increment the runtime PM refcount when enabling
> > events and decrement it when disabling events or powering down.
> > This prevents event loss while still allowing power savings when IRQs
> > are unused.
> >
> > Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
>
> Sorry it took me a while to reply to the last email on the v1 thread.
> Busy week.
>
> I may have this all wrong though if the runtime pm disable you have
> here (bit (1) of MAIN Control) restricts which other registers we can
> access. Perhaps I'm missing where that is stated in the datasheet,
> or maybe it's an omission and you have seen it to be the case
> from experimentation?
>
> If that isn't required a lot of the runtime pm calls in here go away.
bit (1) of the MAIN Control register simply puts the sensor in standby mode=
.
It does not restrict register access. The logic behind doing pm_resume
is to increase the refcount before doing any IO on the sensor.

>
> Also, we should just read the config register to find out if the
> event is enabled, not bother having a separate cache of that one bit.

I have seen the code. At Least 30+ drivers are maintaining this flag.
If we go down the road of not using a flag, it would be an unnecessary
load on the bus everytime an interrupt is configured.
Consider a scenario, where instead of toggling, you are doing enable after
enable or disable after disable. This is expected to be kind of a no-op.
Here the callback will not do anything except for reading the interrupt con=
fig
register. I say why to read this register also when a simple flag can
give us that
information.
>
> Jonathan
>
>
> > ---
> >
> > Changes since v2:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Andy's feedback:
> > -> Check return value of pm_runtime_resume_and_get().
> > -> Do not check return value of pm_runtime_put_autosuspend().
> >
> > 2. Set data->irq_enabled =3D true after checking return value of pm_run=
time_resume_and_get() only.
> >
> > Changes since v1:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Andy's feedback:
> > -> Refactor iio_info callbacks.
> > -> Preserve the order of header file includes.
> > -> Avoid redundant usage of pm_runtime_mark_last_busy.
> > -> Dissolve the ltr390_set_power_state(data, [true|false]) function.
> > -> Avoid macro usage which is internal to header file.
> > -> Update changelog with reason of not using wakeup as a source
> > capability.
> >
> > 2. David's feedback:
> > -> Update Changelog with stats of power savings mentioned in datasheet.
> > -> Dissolve ltr390_set_power_state() function.
> >
> > 3. Jonathan's feedback:
> > -> Adopt the approach of increment refcount when event enable and
> > vice-versa.
>
> > +static int __ltr390_write_event_value(struct iio_dev *indio_dev,
> >                               const struct iio_chan_spec *chan,
> >                               enum iio_event_type type,
> >                               enum iio_event_direction dir,
> > @@ -571,22 +639,55 @@ static int ltr390_write_event_value(struct iio_de=
v *indio_dev,
> >       }
> >  }
> >
> > +static int ltr390_write_event_value(struct iio_dev *indio_dev,
> > +                             const struct iio_chan_spec *chan,
> > +                             enum iio_event_type type,
> > +                             enum iio_event_direction dir,
> > +                             enum iio_event_info info,
> > +                             int val, int val2)
> > +{
> > +     int ret;
> > +     struct ltr390_data *data =3D iio_priv(indio_dev);
> > +     struct device *dev =3D &data->client->dev;
> > +
> > +     ret =3D pm_runtime_resume_and_get(dev);
> > +     if (ret < 0) {
> > +             dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D __ltr390_write_event_value(indio_dev, chan, type, dir,
> > +                                     info, val, val2);
> > +     pm_runtime_put_autosuspend(dev);
> > +
> > +     return ret;
> > +}
> > +
> >  static int ltr390_read_event_config(struct iio_dev *indio_dev,
> >                               const struct iio_chan_spec *chan,
> >                               enum iio_event_type type,
> >                               enum iio_event_direction dir)
> >  {
> >       struct ltr390_data *data =3D iio_priv(indio_dev);
> > +     struct device *dev =3D &data->client->dev;
> >       int ret, status;
> >
> > +     ret =3D pm_runtime_resume_and_get(dev);
> I may be misreading the datasheet but I'd kind of expect to be
> able to read this register in the (slightly) powered down state.
>
> > +     if (ret < 0) {
> > +             dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> >       ret =3D regmap_read(data->regmap, LTR390_INT_CFG, &status);
> > +
> > +     pm_runtime_put_autosuspend(dev);
> > +
> >       if (ret < 0)
> >               return ret;
> > -
> >       return FIELD_GET(LTR390_LS_INT_EN, status);
> >  }
> >
> > -static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > +static int __ltr390_write_event_config(struct iio_dev *indio_dev,
> >                               const struct iio_chan_spec *chan,
> >                               enum iio_event_type type,
> >                               enum iio_event_direction dir,
> > @@ -598,7 +699,6 @@ static int ltr390_write_event_config(struct iio_dev=
 *indio_dev,
> >       if (!state)
> >               return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LT=
R390_LS_INT_EN);
> >
> > -     guard(mutex)(&data->lock);
> >       ret =3D regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_I=
NT_EN);
> >       if (ret < 0)
> >               return ret;
> > @@ -623,18 +723,60 @@ static int ltr390_write_event_config(struct iio_d=
ev *indio_dev,
> >       }
> >  }
> >
> > +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > +                             const struct iio_chan_spec *chan,
> > +                             enum iio_event_type type,
> > +                             enum iio_event_direction dir,
> > +                             bool state)
> > +{
> > +     int ret;
> > +     struct ltr390_data *data =3D iio_priv(indio_dev);
> > +     struct device *dev =3D &data->client->dev;
> > +
> > +     guard(mutex)(&data->lock);
> > +
> As per v1 (late) reply. I'd expect to find query the register to find
> out if what we are potentially setting here is already on or not and
> exit early if we aren't changing that state.
>
> Then we don't need the data->irq_enabled, we can just use runtime pm refe=
rence
> counting to ensure the right things happen.
>
> > +     ret =3D __ltr390_write_event_config(indio_dev, chan, type, dir, s=
tate);
> > +
> > +     if (!state && data->irq_enabled) {
> > +             data->irq_enabled =3D false;
> > +             pm_runtime_put_autosuspend(dev);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
> >                                               unsigned int reg, unsigne=
d int writeval,
> >                                               unsigned int *readval)
> >  {
> >       struct ltr390_data *data =3D iio_priv(indio_dev);
> > +     struct device *dev =3D &data->client->dev;
> > +     int ret;
> >
> > -     guard(mutex)(&data->lock);
> > +     ret =3D pm_runtime_resume_and_get(dev);
>
> So this makes me wonder.  I'd been assuming our disable was only turning =
the
> sensor off, not register access?  Seeing as it's controlled by a register
> we can clearly access at least some.
>
> If that's the case why do we need to runtime resume for debug register
> read/write?  We shouldn't care if the sensors are reading or not. In fact
> if we do turn the power on we changed the state we are debugging which is
> probably not a good plan.
Are you suggesting to remove pm_runtime_* calls from all the functions or
just the debugfs function?

Thanks,
Akshay

