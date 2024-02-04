Return-Path: <linux-iio+bounces-2166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA2848FC9
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 18:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5385E1C21FAF
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF0241E5;
	Sun,  4 Feb 2024 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2KGIhR7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577C225AD
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707068519; cv=none; b=iOWBxqJtvXzlqVzcYEkloopDGg51yuFgFUmwUCIAjG1+LPf6dU/x3ZfZVjHc1DXs/6eNlJ+BJbnF+uOOEa3FsWJKbR4VzC0hRLTyH+tYxJDp9xdycdqQ4H7m+yapxc4UtiRtpuNkdN2opAL1S/9MNYEWpuYTcIhShnRdw8bGzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707068519; c=relaxed/simple;
	bh=ePE7+MiQEqMf+5wZjB+7QB8gRoWJgGG8SowHA+BZ1e8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJvVhacicQ+ns7z32CcpwUCUHpIEaKHDsjUJbsrf6zNa/9adHC0IxxMLcvnAJOr+lc+j9Q55+FRb2mWSD60cwnBBTV5wW5uJw+wcr+Rlmu8J0TRCgtSg/In7ohyXPAvPGaAwGaBqLvHwPcOcVEG8wsLSwjboGVVKRXTDsW6VlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2KGIhR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756ADC433F1;
	Sun,  4 Feb 2024 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707068519;
	bh=ePE7+MiQEqMf+5wZjB+7QB8gRoWJgGG8SowHA+BZ1e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2KGIhR7K2Fi6Wv25OB3dxdWocuwrbY9QJ2h9HSqEzkJPOkdJmdccLGrq7gaDXaUh
	 pSXyY9PYsSq/rLqPoxzlSlurWbjjiErXUJv2x8bZNlOgbNZymkfnMzW5JR2KPWhlS6
	 riuhEb9iXZP40T95ojrx6XJPF5FbPbv5ZhbIlrG1eypzuzPsqzJ25oR/DjazN+UjdV
	 tr1CzTw9UWB851z9P0DHN743DtX7MmS/KNZtR1LTvFA/80u5O/94Fzt7jLzASZuRVN
	 8Hy0PcEYde1Odch4RQNqY1sK0rFdxwhn7quu09+mUxu0MQhPFSGRBIH7PPRYhf2hfD
	 KYZSLSRJZ9kCA==
Date: Sun, 4 Feb 2024 17:41:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: andy.shevchenko@gmail.com
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Peter
 Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/10] iio: dummy: Use automatic lock and direct mode
 cleanup.
Message-ID: <20240204174147.19c5a334@jic23-huawei>
In-Reply-To: <Zb-7ZUbZ65G-LoNW@surfacebook.localdomain>
References: <20240128150537.44592-1-jic23@kernel.org>
	<20240128150537.44592-3-jic23@kernel.org>
	<Zb-7ZUbZ65G-LoNW@surfacebook.localdomain>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Feb 2024 18:29:25 +0200
andy.shevchenko@gmail.com wrote:

> Sun, Jan 28, 2024 at 03:05:29PM +0000, Jonathan Cameron kirjoitti:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Given we now have iio_device_claim_direct_scoped() to perform automatic
> > releasing of direct mode at exit from the scope that follows it, this c=
an
> > be used in conjunction with guard(mutex) etc remove a lot of special ca=
se
> > handling.
> >=20
> > Note that in this particular example code, there is no real reason you =
can't
> > read channels via sysfs at the same time as filling the software buffer.
> > To make it look more like a real driver constrain raw and processed
> > channel reads from occurring whilst the buffer is in use. =20
>=20
> ...
>=20
> > +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > +			guard(mutex)(&st->lock);
> > +			switch (chan->type) {
> > +			case IIO_VOLTAGE:
> > +				if (chan->output) {
> > +					/* Set integer part to cached value */
> > +					*val =3D st->dac_val;
> > +					return IIO_VAL_INT;
> > +				} else if (chan->differential) {
> > +					if (chan->channel =3D=3D 1)
> > +						*val =3D st->differential_adc_val[0];
> > +					else
> > +						*val =3D st->differential_adc_val[1];
> > +					return IIO_VAL_INT;
> > +				} else {
> > +					*val =3D st->single_ended_adc_val;
> > +					return IIO_VAL_INT;
> > +				} =20
>=20
> Now you may go further and use only single return statement here.

True though this is an example driver and it's only really coincidence thos=
e returns
are the same so I'd rather keep it as explicitly matching *val with the ret=
urn.

>=20
> > +			case IIO_ACCEL:
> > +				*val =3D st->accel_val;
> > +				return IIO_VAL_INT;
> > +			default:
> > +				return -EINVAL;
> >  			} =20
>=20
> ...
>=20
> > +		unreachable(); =20
>=20
> Hmm... Is it really required? Why?

Try compiling without it. (I'm running with C=3D1 W=3D1 but think this will=
 show up anyway.

Seems it can't tell we never leave the for loop.

>=20
In file included from ./include/linux/preempt.h:11,                        =
                                                                           =
                                 =20
                 from ./include/linux/spinlock.h:56,                       =
                                                                           =
                                 =20
                 from ./include/linux/mmzone.h:8,                          =
                                                                           =
                                 =20
                 from ./include/linux/gfp.h:7,                             =
                                                                           =
                                 =20
                 from ./include/linux/slab.h:16,                           =
                                                                           =
                                 =20
                 from drivers/iio/dummy/iio_simple_dummy.c:15:             =
                                                                           =
                                 =20
drivers/iio/dummy/iio_simple_dummy.c: In function =E2=80=98iio_dummy_read_r=
aw=E2=80=99:                        =20
./include/linux/cleanup.h:173:9: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]
  173 |         for (CLASS(_name, scope)(args), \                          =
                         =20
      |         ^~~                                                        =
                    =20
./include/linux/iio/iio.h:667:9: note: in expansion of macro =E2=80=98scope=
d_cond_guard=E2=80=99               =20
  667 |         scoped_cond_guard(iio_claim_direct_try, fail, iio_dev)     =
                         =20
      |         ^~~~~~~~~~~~~~~~~                                          =
                    =20
drivers/iio/dummy/iio_simple_dummy.c:289:17: note: in expansion of macro =
=E2=80=98iio_device_claim_direct_scoped=E2=80=99
  289 |                 iio_device_claim_direct_scoped(return -EBUSY, indio=
_dev) {                           =20
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                     =
                         =20
drivers/iio/dummy/iio_simple_dummy.c:316:9: note: here                     =
                                  =20
  316 |         case IIO_CHAN_INFO_PROCESSED:                              =
                                  =20
      |         ^~~~                                     =20
> ...
>=20
> P.S> I hope you are using --histogram diff algo when preparing patches. =
=20
>=20


