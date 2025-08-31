Return-Path: <linux-iio+bounces-23536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CF6B3D40E
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A792A16BB49
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10421269CE6;
	Sun, 31 Aug 2025 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/MBP9Zr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3922475E3;
	Sun, 31 Aug 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653118; cv=none; b=M1ckmcgPhkvHkGsRZ4CR1PjMSEPNMQhTHnH6fU2495mUMHG05T63+KLf37Zq9ZDTXgySdpEd6KMmL4KTH2yxD50NqMxUoZcDc8JhVAz94qDMJ3h7hYN0jarrD5IPgmag1QUNtIGXfu0uo5BXFx3rBNhI2TkEA//LU1bP96lQSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653118; c=relaxed/simple;
	bh=PMOhehFjAr+Y6U5WtYoTo8MVwClIWB6s2ZXYACSLu5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRIy1iLuHe/iN4s/O7GZh7ay1zctWB4bX8T6/SlKdPnU/aSGH0c4hZixPL8vOFhZleseyxREvyxLEfuIINGavz6BY1bxkNR5uNv0gUmq1ChyRuds0PMIzgeA2EQpO+aj+f4BKHI56iEpoRCK44JxN3iFQART2+KCSKL/d1LGuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/MBP9Zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F49C4CEED;
	Sun, 31 Aug 2025 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756653118;
	bh=PMOhehFjAr+Y6U5WtYoTo8MVwClIWB6s2ZXYACSLu5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s/MBP9ZrfgyWY/y43OcsZ6d4j6zbZ97fOcAQcX1OUU+2nbk5Z2sEZSyZU0ThgsF1l
	 3OyD/wR6AoHje2LwiyM36Dsb/IKAOqcYiehSI8UmvKGWR2u5MxNlWrssYoOKIyPL2D
	 vCsQILU4u9MvVsYY9kgM+jAAnBWWkW3rqEio1rNznBQRr6kXbN4OcU12KQW3SF2xbW
	 84np0vmswcPVEsceFkhkSsRFH93jjTSMd2UH+IsDjC5W+6korWljkgNUgNWsTrXlBr
	 x1b1BNScnKXSSWXtsm99KiuclbV9ttmHt3abmdNR7jrjGShG9ErRS6ReowlTDeMxGZ
	 JNvX2fAlqGDOw==
Date: Sun, 31 Aug 2025 16:11:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
Message-ID: <20250831161149.27547d16@jic23-huawei>
In-Reply-To: <CAE3SzaSezCtZ24vz4_qSmLow_MfU3p7XgdVUBKD3Yj7LcAK-6g@mail.gmail.com>
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
	<20250830192538.3b508c5c@jic23-huawei>
	<CAE3SzaSezCtZ24vz4_qSmLow_MfU3p7XgdVUBKD3Yj7LcAK-6g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Aug 2025 11:09:26 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> On Sat, Aug 30, 2025 at 11:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Sat, 30 Aug 2025 17:05:00 +0530
> > Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
> > =20
> > > Implement runtime power management for the LTR390 sensor. The device
> > > autosuspends after 1s of idle time, reducing current consumption from
> > > 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the da=
tasheet.
> > >
> > > Ensure that interrupts continue to be delivered with runtime PM.
> > > Since the LTR390 cannot be used as a wakeup source during runtime
> > > suspend, therefore increment the runtime PM refcount when enabling
> > > events and decrement it when disabling events or powering down.
> > > This prevents event loss while still allowing power savings when IRQs
> > > are unused.
> > >
> > > Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com> =20
> >
> > Sorry it took me a while to reply to the last email on the v1 thread.
> > Busy week.
> >
> > I may have this all wrong though if the runtime pm disable you have
> > here (bit (1) of MAIN Control) restricts which other registers we can
> > access. Perhaps I'm missing where that is stated in the datasheet,
> > or maybe it's an omission and you have seen it to be the case
> > from experimentation?
> >
> > If that isn't required a lot of the runtime pm calls in here go away. =
=20
> bit (1) of the MAIN Control register simply puts the sensor in standby mo=
de.
> It does not restrict register access. The logic behind doing pm_resume
> is to increase the refcount before doing any IO on the sensor.
>=20

Why do we care about that refcount?  We care if the device is in a state
to perform IO. In this particular case runtime pm callbacks don't affect
that unless I'm missing something more complex!


> >
> > Also, we should just read the config register to find out if the
> > event is enabled, not bother having a separate cache of that one bit. =
=20
>=20
> I have seen the code. At Least 30+ drivers are maintaining this flag.
> If we go down the road of not using a flag, it would be an unnecessary
> load on the bus everytime an interrupt is configured.
> Consider a scenario, where instead of toggling, you are doing enable after
> enable or disable after disable. This is expected to be kind of a no-op.
> Here the callback will not do anything except for reading the interrupt c=
onfig
> register. I say why to read this register also when a simple flag can
> give us that
> information.

As per the other thread I'll agree to the flag, though to my mind it
is  an inferior solution and in many of those other drivers is there
because of the history of how they evolved, not because it is the best
solution.

> >
> > Jonathan
> >
> > =20
> > > ---
> > >
> > > Changes since v2:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > 1. Andy's feedback: =20
> > > -> Check return value of pm_runtime_resume_and_get().
> > > -> Do not check return value of pm_runtime_put_autosuspend(). =20
> > >
> > > 2. Set data->irq_enabled =3D true after checking return value of pm_r=
untime_resume_and_get() only.
> > >
> > > Changes since v1:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > 1. Andy's feedback: =20
> > > -> Refactor iio_info callbacks.
> > > -> Preserve the order of header file includes.
> > > -> Avoid redundant usage of pm_runtime_mark_last_busy.
> > > -> Dissolve the ltr390_set_power_state(data, [true|false]) function.
> > > -> Avoid macro usage which is internal to header file.
> > > -> Update changelog with reason of not using wakeup as a source =20
> > > capability.
> > >
> > > 2. David's feedback: =20
> > > -> Update Changelog with stats of power savings mentioned in datashee=
t.
> > > -> Dissolve ltr390_set_power_state() function. =20
> > >
> > > 3. Jonathan's feedback: =20
> > > -> Adopt the approach of increment refcount when event enable and =20
> > > vice-versa. =20
> > =20
> > > +static int __ltr390_write_event_value(struct iio_dev *indio_dev,
> > >                               const struct iio_chan_spec *chan,
> > >                               enum iio_event_type type,
> > >                               enum iio_event_direction dir,
> > > @@ -571,22 +639,55 @@ static int ltr390_write_event_value(struct iio_=
dev *indio_dev,
> > >       }
> > >  }
> > >
> > > +static int ltr390_write_event_value(struct iio_dev *indio_dev,
> > > +                             const struct iio_chan_spec *chan,
> > > +                             enum iio_event_type type,
> > > +                             enum iio_event_direction dir,
> > > +                             enum iio_event_info info,
> > > +                             int val, int val2)
> > > +{
> > > +     int ret;
> > > +     struct ltr390_data *data =3D iio_priv(indio_dev);
> > > +     struct device *dev =3D &data->client->dev;
> > > +
> > > +     ret =3D pm_runtime_resume_and_get(dev);
> > > +     if (ret < 0) {
> > > +             dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     ret =3D __ltr390_write_event_value(indio_dev, chan, type, dir,
> > > +                                     info, val, val2);
> > > +     pm_runtime_put_autosuspend(dev);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  static int ltr390_read_event_config(struct iio_dev *indio_dev,
> > >                               const struct iio_chan_spec *chan,
> > >                               enum iio_event_type type,
> > >                               enum iio_event_direction dir)
> > >  {
> > >       struct ltr390_data *data =3D iio_priv(indio_dev);
> > > +     struct device *dev =3D &data->client->dev;
> > >       int ret, status;
> > >
> > > +     ret =3D pm_runtime_resume_and_get(dev); =20
> > I may be misreading the datasheet but I'd kind of expect to be
> > able to read this register in the (slightly) powered down state.
> > =20
> > > +     if (ret < 0) {
> > > +             dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > >       ret =3D regmap_read(data->regmap, LTR390_INT_CFG, &status);
> > > +
> > > +     pm_runtime_put_autosuspend(dev);
> > > +
> > >       if (ret < 0)
> > >               return ret;
> > > -
> > >       return FIELD_GET(LTR390_LS_INT_EN, status);
> > >  }
> > >
> > > -static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > > +static int __ltr390_write_event_config(struct iio_dev *indio_dev,
> > >                               const struct iio_chan_spec *chan,
> > >                               enum iio_event_type type,
> > >                               enum iio_event_direction dir,
> > > @@ -598,7 +699,6 @@ static int ltr390_write_event_config(struct iio_d=
ev *indio_dev,
> > >       if (!state)
> > >               return regmap_clear_bits(data->regmap, LTR390_INT_CFG, =
LTR390_LS_INT_EN);
> > >
> > > -     guard(mutex)(&data->lock);
> > >       ret =3D regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS=
_INT_EN);
> > >       if (ret < 0)
> > >               return ret;
> > > @@ -623,18 +723,60 @@ static int ltr390_write_event_config(struct iio=
_dev *indio_dev,
> > >       }
> > >  }
> > >
> > > +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> > > +                             const struct iio_chan_spec *chan,
> > > +                             enum iio_event_type type,
> > > +                             enum iio_event_direction dir,
> > > +                             bool state)
> > > +{
> > > +     int ret;
> > > +     struct ltr390_data *data =3D iio_priv(indio_dev);
> > > +     struct device *dev =3D &data->client->dev;
> > > +
> > > +     guard(mutex)(&data->lock);
> > > + =20
> > As per v1 (late) reply. I'd expect to find query the register to find
> > out if what we are potentially setting here is already on or not and
> > exit early if we aren't changing that state.
> >
> > Then we don't need the data->irq_enabled, we can just use runtime pm re=
ference
> > counting to ensure the right things happen.
> > =20
> > > +     ret =3D __ltr390_write_event_config(indio_dev, chan, type, dir,=
 state);
> > > +
> > > +     if (!state && data->irq_enabled) {
> > > +             data->irq_enabled =3D false;
> > > +             pm_runtime_put_autosuspend(dev);
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > >  static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
> > >                                               unsigned int reg, unsig=
ned int writeval,
> > >                                               unsigned int *readval)
> > >  {
> > >       struct ltr390_data *data =3D iio_priv(indio_dev);
> > > +     struct device *dev =3D &data->client->dev;
> > > +     int ret;
> > >
> > > -     guard(mutex)(&data->lock);
> > > +     ret =3D pm_runtime_resume_and_get(dev); =20
> >
> > So this makes me wonder.  I'd been assuming our disable was only turnin=
g the
> > sensor off, not register access?  Seeing as it's controlled by a regist=
er
> > we can clearly access at least some.
> >
> > If that's the case why do we need to runtime resume for debug register
> > read/write?  We shouldn't care if the sensors are reading or not. In fa=
ct
> > if we do turn the power on we changed the state we are debugging which =
is
> > probably not a good plan. =20
> Are you suggesting to remove pm_runtime_* calls from all the functions or
> just the debugfs function?

All the ones where it's not needed.  So as far as I can see it is only
needed when actually grabbing date.

Jonathan

>=20
> Thanks,
> Akshay


