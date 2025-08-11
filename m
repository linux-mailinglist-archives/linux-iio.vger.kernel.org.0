Return-Path: <linux-iio+bounces-22563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5204AB20826
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AD117FFB7
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 11:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62242D12F5;
	Mon, 11 Aug 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="tajw3JHx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E289199223;
	Mon, 11 Aug 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912852; cv=none; b=ktanWHLNyYI1YbjPxWJ7Y1vxwi47hVJBe2f+npos3Bs9AwBlTaB4YKEU+Bk0zjTPvRZuJhcO6UptGcpQEsY1vMa5ROxw/2H3mEPn00+HEZbH+/txp/Z6MrGtRGLjfBHP048liWdGrvej/5Asp9qIC5CbfCcL/9vwlpwV3Y/wkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912852; c=relaxed/simple;
	bh=/p6Q049hw1l1zYvuZ+KcNIZ36piU6tuOii3hGZZoO/4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftCmwM9hq0/902VTXJOkZ8CTidkkjazmVYWpV7MK3kcAaHYJY8S1FiiFpdDJo8Q6Hth92aTK4rYmnAeq+agoG/dMZDRB1hytJkiwHBBG0Zt33iD2Y73c2zBa9jpKrNliFp/mRA506xsUilP12KvNCxVSixjEbIgpIMcPREg7B4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=tajw3JHx; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1754912846; x=1755172046;
	bh=DN21fo4yJLr20gLctH3PuCOSw+cuLOWAFF5dG6rvYwk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tajw3JHxzsSC2nDu9QJET1kVyECGqLIjyJG/39SwvCvWnOsmPATa9Jb7tM/pOZTM7
	 ArDRkZGLqo2H/IfihZtQwDaoG4BB4fAyyHoHLjyBPmCdeGZIf5biCHJO9/8Z8niU4t
	 41WNDT202Kr3HEZCwc3x85lHoti7xDlhhjj3kiKVk5sGjWCj9bOxzz9KnkH9uY6HOR
	 Fg7R6u3k96cCq79jp3toHkC2bXqZlRq7JBJg6W8NGrE5TgbBkzs0s2DEfQoE3wSw0Y
	 hsreveWq6K2IvsgkwaLeD74VXR1J05KOWgRQ9sWOH6W5rbXrXxJpRF8dBhjxifggEh
	 sw0lEYet9LufQ==
Date: Mon, 11 Aug 2025 11:47:23 +0000
To: Andy Shevchenko <andy.shevchenko@gmail.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/5] iio: imu: inv_icm42600: use guard() to release mutexes
Message-ID: <2g4hn5nulrstqdo4rjd2uyniyuoupbvwbuf34ng47wz6d5hih3@67mtm2t5yuhu>
In-Reply-To: <CAHp75VeA36CHbvmhHVesw3itRW0aGURTqCJPAtw_P=q12F_0Yw@mail.gmail.com>
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com> <20250808-icm42pmreg-v2-5-a480279e7721@geanix.com> <CAHp75VeA36CHbvmhHVesw3itRW0aGURTqCJPAtw_P=q12F_0Yw@mail.gmail.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 4e7266c2de6ef5d2b98ad893c99702cb3dce862d
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 08, 2025 at 11:52:35PM +0100, Andy Shevchenko wrote:
> On Fri, Aug 8, 2025 at 5:58=E2=80=AFPM Sean Nyekjaer <sean@geanix.com> wr=
ote:
> >
> > Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> > for cleaner and safer mutex handling.
>=20
> ...
>=20
> >         pm_runtime_get_sync(dev);
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> >         ret =3D inv_icm42600_set_accel_conf(st, &conf, NULL);
> >
> > -       mutex_unlock(&st->lock);
> >         pm_runtime_mark_last_busy(dev);
> >         pm_runtime_put_autosuspend(dev);
>=20
> This makes PM calls under the mutex. In some cases it may lead to deadloc=
ks.
> I think you wanted to use scoped_guard() here and in similar cases.

Oh, good catch :)

>=20
> ...
>=20
> >         struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_=
dev);
> >         int ret;
> >
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> >         st->fifo.watermark.accel =3D val;
> >         ret =3D inv_icm42600_buffer_update_watermark(st);
> >
> > -       mutex_unlock(&st->lock);
> > -
> >         return ret;
>=20
> Now remove ret and use return directly.
>=20
> >  }
>=20
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> >         ret =3D inv_icm42600_buffer_hwfifo_flush(st, count);
> >         if (!ret)
> >                 ret =3D st->fifo.nb.accel;
> >
> > -       mutex_unlock(&st->lock);
> > -
> >         return ret;
>=20
> In the similar way as above.
>=20
> ret =3D _flush();
> if (ret)
>   return ret;
>=20
> return ...nb.accel;
>=20
> ...
>=20
> >         struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_=
dev);
>=20
> >         int ret;
>=20
> Now unneeded, just return directly.
>=20
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> >         if (readval)
> >                 ret =3D regmap_read(st->map, reg, readval);
> >         else
> >                 ret =3D regmap_write(st->map, reg, writeval);
> >
> > -       mutex_unlock(&st->lock);
> > -
> >         return ret;
>=20
> ...
>=20
> >         int ret =3D 0;
>=20
> Now unneeded assignment.
>=20
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> >         st->suspended.gyro =3D st->conf.gyro.mode;
> >         st->suspended.accel =3D st->conf.accel.mode;
> >         st->suspended.temp =3D st->conf.temp_en;
> > -       if (pm_runtime_suspended(dev))
> > -               goto out_unlock;
> > +       ret =3D pm_runtime_suspended(dev);
> > +       if (ret)
> > +               return ret;
>=20
> ...
>=20
> >         /* disable vddio regulator if chip is sleeping */
> >         if (!wakeup)
> >                 regulator_disable(st->vddio_supply);
> >
> > -out_unlock:
> > -       mutex_unlock(&st->lock);
> >         return ret;
>=20
> Now return 0 to make it clear that this is a success.
>=20
> ...
>=20
> > @@ -881,10 +878,11 @@ static int inv_icm42600_resume(struct device *dev=
)
> >         bool wakeup;
> >         int ret =3D 0;
>=20
> Assignment is useless now.
>=20
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> > -       if (pm_runtime_suspended(dev))
> > -               goto out_unlock;
> > +       ret =3D pm_runtime_suspended(dev);
> > +       if (ret)
> > +               return ret;
>=20
> ...
>=20
> > -out_unlock:
> > -       mutex_unlock(&st->lock);
> >         return ret;
>=20
>   return 0;
>=20
> ?
>=20
> ...
>=20
> >         regulator_disable(st->vddio_supply);
> >
> > -error_unlock:
> > -       mutex_unlock(&st->lock);
> >         return ret;
>=20
> Ditto.
>=20
> >  }
>=20
> ...
>=20
> >         int ret;
>=20
> Now useless variable.
>=20
> >
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> >         ret =3D inv_icm42600_enable_regulator_vddio(st);
> >
> > -       mutex_unlock(&st->lock);
> >         return ret;
> >  }
>=20
> ...
>=20
> >         int ret;
>=20
> Ditto.
>=20
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> >         st->fifo.watermark.gyro =3D val;
> >         ret =3D inv_icm42600_buffer_update_watermark(st);
> >
> > -       mutex_unlock(&st->lock);
> > -
> >         return ret;
> >  }
>=20
> ...
>=20
> > -       mutex_lock(&st->lock);
> > +       guard(mutex)(&st->lock);
> >
> >         ret =3D inv_icm42600_buffer_hwfifo_flush(st, count);
> >         if (!ret)
> >                 ret =3D st->fifo.nb.gyro;
>=20
> Invert conditional and return ret directly.
>=20
> > -       mutex_unlock(&st->lock);
> > -
> >         return ret;
>=20
> --
> With Best Regards,
> Andy Shevchenko

Thanks for the review.

/Sean


