Return-Path: <linux-iio+bounces-17468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D8A76622
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DDF16AA67
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002681E5B60;
	Mon, 31 Mar 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuqeWSHu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DB1E47B4;
	Mon, 31 Mar 2025 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424601; cv=none; b=VgSsDW8RyalID6Tv0ed//4q0wPJFDMQpx+U7E7tnwzWmMrgnIkIPlArGuMGlPC3p1gnmiWT1MiGRDAu2nL6Wt4HXA2QbZqiA2a9SCwIiPKfHLHDq6Twsjzz31BQtXIGFnVTgJp6XXbxjkYCwG2JnVnHVnspaEIFKn20pB/QrDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424601; c=relaxed/simple;
	bh=HpbaK4zMAdqazzak29BwALJAc9M3zvgIDlqTytH8Etg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQEesDrg5BfxBHZwr58iDZ7o9lTxZF4ZG6Le4P+2Dy99Zo1Yr/Bd0y6bM+Bgr6PAIoZ9HZZ3UfzYJU1Ane/5gzcEN/9GUzORgqY8fs7Ags7uMmrFpSvsqy2YyuoVfRO9XeMe3v/LehP2L+XPJtkpOkTJVdh8JVa0AzmEh8aXLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuqeWSHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A42C4CEE3;
	Mon, 31 Mar 2025 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743424601;
	bh=HpbaK4zMAdqazzak29BwALJAc9M3zvgIDlqTytH8Etg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QuqeWSHucf//6sXOO9j3WVLBZEcHN7RqhNTq27erPT0c+43gPI99+aP1jPGeJhQ6+
	 lUCA6x95hsW/ateSEspgolul2epZ0Gd6mdivTUiMP7hZPWW6SvLLyZb+SgN/HoW7ix
	 GgHIWjlrK2D2EeHHPVDhBwPkq2HL6g16ZbGxyuINfYTUylDq4cmhhYuIOqmsgivVQS
	 ne/KlhJKQlcWdIwBqLsgsvDbBuiSNpMI7tu3y7GK9GHJFFKDmuY0PUd7/oQVbNXE6i
	 VmQg8Nlb08dKp1sB5MB1Ec9HJenDpGW9GiZdVXoTGJejQBFdPN83+wRMhn6td7VV5Q
	 bGck4+ve3B3HA==
Date: Mon, 31 Mar 2025 13:36:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 05/14] iio: accel: adxl345: add single tap feature
Message-ID: <20250331133633.370bc50b@jic23-huawei>
In-Reply-To: <CAFXKEHZ+4OyA4AFPkAayetoK3pWfzf8ubrbozJjcjTqTAnHqFw@mail.gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-6-l.rubusch@gmail.com>
	<20250316112057.638626bd@jic23-huawei>
	<CAFXKEHZ+4OyA4AFPkAayetoK3pWfzf8ubrbozJjcjTqTAnHqFw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2025 00:08:24 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, Mar 16, 2025 at 12:22=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Thu, 13 Mar 2025 16:50:40 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add the single tap feature with a threshold in 62.5mg/LSB points and a
> > > scaled duration in us. Keep singletap threshold in regmap cache but
> > > the scaled value of duration in us as member variable.
> > >
> > > Both use IIO channels for individual enable of the x/y/z axis. Initia=
lizes
> > > threshold and duration with reasonable content. When an interrupt is
> > > caught it will be pushed to the according IIO channel.
> > > =20
> > =20
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> >
> > Hi Lothar,
> >
> > A few things in here are from the discussion that was continuing
> > on v3 so I may have said more replying to that.
> >
> > Anyhow, for now I'll hold off on applying from this point on as
> > a few more things to respond to inline.
> >
> > Jonathan
> > =20
> > >
> > >  #include "adxl345.h"
> > > @@ -31,6 +33,33 @@
> > >  #define ADXL345_INT1                 0
> > >  #define ADXL345_INT2                 1
> > >
> > > +#define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0)
> > > +
> > > +enum adxl345_axis {
> > > +     ADXL345_Z_EN =3D BIT(0),
> > > +     ADXL345_Y_EN =3D BIT(1),
> > > +     ADXL345_X_EN =3D BIT(2),
> > > +     /* Suppress double tap detection if value > tap threshold */
> > > +     ADXL345_TAP_SUPPRESS =3D BIT(3),
> > > +}; =20
> > As per feedback (after you sent this!) on v3, I'd drop
> > the last value out of the enum, or just use defines and a u8 for
> > the one place this is used for local variable storage.
> >
> > =20
> > > @@ -198,6 +387,132 @@ static int adxl345_write_raw(struct iio_dev *in=
dio_dev,
> > >       return -EINVAL;
> > >  }
> > >
> > > +static int adxl345_read_event_config(struct iio_dev *indio_dev,
> > > +                                  const struct iio_chan_spec *chan,
> > > +                                  enum iio_event_type type,
> > > +                                  enum iio_event_direction dir)
> > > +{
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     bool int_en;
> > > +     int ret =3D -EFAULT; =20
> > Not used?
> > =20
> > > +
> > > +     switch (type) {
> > > +     case IIO_EV_TYPE_GESTURE:
> > > +             switch (dir) {
> > > +             case IIO_EV_DIR_SINGLETAP:
> > > +                     ret =3D adxl345_is_tap_en(st, chan->channel2,
> > > +                                             ADXL345_SINGLE_TAP, &in=
t_en);
> > > +                     if (ret)
> > > +                             return ret;
> > > +                     return int_en;
> > > +             default:
> > > +                     return -EINVAL;
> > > +             }
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +} =20
> > =20
> > > +static int adxl345_write_event_value(struct iio_dev *indio_dev,
> > > +                                  const struct iio_chan_spec *chan,
> > > +                                  enum iio_event_type type,
> > > +                                  enum iio_event_direction dir,
> > > +                                  enum iio_event_info info,
> > > +                                  int val, int val2)
> > > +{
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     int ret;
> > > +
> > > +     ret =3D adxl345_set_measure_en(st, false);
> > > +     if (ret)
> > > +             return ret;
> > > + =20
> > So in my brief reply to the v3 discussion I suggested perhaps
> > factoring out everything from here... =20
> > > +     switch (type) {
> > > +     case IIO_EV_TYPE_GESTURE:
> > > +             switch (info) {
> > > +             case IIO_EV_INFO_VALUE:
> > > +                     ret =3D regmap_write(st->regmap, ADXL345_REG_TH=
RESH_TAP,
> > > +                                        min(val, 0xFF));
> > > +                     break;
> > > +             case IIO_EV_INFO_TIMEOUT:
> > > +                     ret =3D adxl345_set_tap_duration(st, val, val2);
> > > +                     break;
> > > +             default:
> > > +                     ret =3D -EINVAL;
> > > +                     break;
> > > +             }
> > > +             break;
> > > +     default:
> > > +             ret =3D -EINVAL;
> > > +             break;
> > > +     } =20
> > to here, so as to allow simple direct returns.
> >
> > I think that will make the code more readable given the need to reenable
> > measurements and that you want to leave it off on error.
> > =20
>=20
> Sorry for replying again on this topic. Pls, find my solution in v5.
>=20
> After some thinking, I implemented it now using returns directly leaving =
the
> measurement on/off as is. I'm unsure if it actually makes sense, after an=
 error
> here to turn measurement on again? I can imagine a situation where a wrong
> input might result in an error. Nothing is changed, and measurement
> could/should continue. Now, it will probably stop, in case of wrong
> input. But is
> wrong input actually an issue here?

If a userspace control input is out of range etc, then returning an error
but leaving things on makes sense.  If what we see is a comms error
it gets less clear on what we should do. =20

>=20
> As other alternative, I can think of is to shift measurement on/off
> into the called
> functions directly. I think, this approach was used also in the
> ADXL380 and seems
> to be common. Let me know what you think.
>=20
Moving it up or down a layer can work by allowing direct returns and always
trying to reenable if that makes sense.

Sadly in error handling there is often not a right answer on what to do!

Jonathan

> > > +
> > > +     if (ret)
> > > +             return ret; /* measurement stays off */
> > > +
> > > +     return adxl345_set_measure_en(st, true);
> > > +} =20
> > =20


