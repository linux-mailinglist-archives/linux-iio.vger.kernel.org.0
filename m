Return-Path: <linux-iio+bounces-9297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B269970327
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 18:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009332831D5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008015ECD7;
	Sat,  7 Sep 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsYZPpg+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D314A4C7;
	Sat,  7 Sep 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725726458; cv=none; b=S6yzp/7FpY9Z57glCUUHY8JyIp87RbtZFKpqmoVfLo4HNRQMOW7xI3hZrEwUNHuXrg8PfsYL9Xk2+qpQTdPktgG0MpvNacCGPox1w8pzjHQBtEBplaR+qguqsAN6iEQ/hDu5uJD41eG5RPQ1Y0E5q9yIsr1xL5vbtkQlA9qOgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725726458; c=relaxed/simple;
	bh=J3MDv9Ne6AL4WYhqff9ERRTL9PNpkiTwIzUBy41mP38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9iS65Y/IRQ3EZgZ7DxfSc+zHgXbv8A05pSsj3e3Cy0/V2MlRrgkftVYBy0XmhpOlHdeI7K6J6892gyDt8cnYaKQBfJzaICs9pzTsOorcZfJT9Ax1NkFR4e4vV/IqAEwsmLe5/fLreFpDJ3G9R7gBifZ1fadNhWKFbSIkfpXOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsYZPpg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23584C4CEC2;
	Sat,  7 Sep 2024 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725726458;
	bh=J3MDv9Ne6AL4WYhqff9ERRTL9PNpkiTwIzUBy41mP38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VsYZPpg+d8v+8RreFy+2RTwR7Mz+RQCk39ArMFtB/ze7u6qToDyRfRqYIb7FLn0xH
	 9npb7lYITZBFvxsGmtxfA45us2riaW4IWkTIkUvy+bZPFzcjXSBZrvi+l0ss++SA0M
	 9E8OZ6uPWyQdymJRrEA6FmLzC1y3BSy9PkjBkuoLC11Y6PxNmTqhbScL9N4KT1N0bY
	 8WvgkpNMw6s6Xbv2GH/tBnz/kioNmdeHFJsrqeHhUOEu2hcyw1eNAXAyTC427Lxjb1
	 t9zgXiZr1qqhAbSCrGH/KBEAUS80mvlpx3YE88UfmOiwMECvw+3Ty3Nz/PdyzNiXML
	 QkGbg2lctlGyw==
Date: Sat, 7 Sep 2024 17:27:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gyeyoung <gye976@gmail.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to probe
 function
Message-ID: <20240907172732.6c8835d0@jic23-huawei>
In-Reply-To: <CAKbEznuKUDf4vUa3r52WWxWg9qmB5cYayGehqHe==RuF-1F+3Q@mail.gmail.com>
References: <20240903163302.105268-1-gye976@gmail.com>
	<FR3P281MB1757A2ECAB94077B8E250314CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<CAKbEznuKUDf4vUa3r52WWxWg9qmB5cYayGehqHe==RuF-1F+3Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Sep 2024 23:32:47 +0900
gyeyoung <gye976@gmail.com> wrote:

> Thank you for your response. I understand what you mean.
>=20
> But I think it's better to have 'wom_bits' in 'inv_mpu6050_state',
> because the 'wom_bits' variable is only a variable for bit operation
> with the 'INT_STATUS' register, not an actual register in register
> manual.
> Isn't it?

I'd like it somewhere static const.  Either in the register map
(which indeed currently only has register addresses) or in the
hw_info structures.  I'd prefer the reg_map.

The current handling as 'code' based on the ID should
be replaced with data.

Jonathan


>=20
> Thanks.
>=20
> On Thu, Sep 5, 2024 at 6:30=E2=80=AFPM Jean-Baptiste Maneyrol
> <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> >
> > Hello,
> >
> > nice improvement, thanks.
> >
> > But beware there is a fix pending in fixes-togreg branch and missing in=
 testing branch that is changing this part of code.
> > To avoid a painful merge, it should be better to wait for the fix to be=
 integrated inside testing.
> >
> > Is that correct Jonathan?
> >
> > And I would prefer the wom_bits being inside the inv_mpu6050_reg_map st=
ructure.
> >
> > Thanks,
> > JB
> >
> > ________________________________________
> > From: Gyeyoung Baek <gye976@gmail.com>
> > Sent: Tuesday, September 3, 2024 18:33
> > To: jic23@kernel.org <jic23@kernel.org>
> > Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; Gyeyoung Baek <gye976@gmai=
l.com>
> > Subject: [PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to prob=
e function
> >
> > This Message Is From an Untrusted Sender
> > You have not previously corresponded with this sender.
> >
> > 'wom_bits' variable is defined by chip type,
> > and chip type is statically defined by device tree.
> > so 'wom_bits' need to be set once during probe function.
> >
> > but before code set it every time using 'switch statement' during
> > threaded irq handler, so i move that to probe function.
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 16 +++++++++++++++
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  1 +
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 20 ++-----------------
> >  3 files changed, 19 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c
> > index 14d95f34e981..322ae664adc0 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -2076,6 +2076,22 @@ int inv_mpu_core_probe(struct regmap *regmap, in=
t irq, const char *name,
> >                 return result;
> >         }
> >
> > +       switch (chip_type) {
> > +       case INV_MPU6050:
> > +       case INV_MPU6500:
> > +       case INV_MPU6515:
> > +       case INV_MPU6880:
> > +       case INV_MPU6000:
> > +       case INV_MPU9150:
> > +       case INV_MPU9250:
> > +       case INV_MPU9255:
> > +               st->wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> > +               break;
> > +       default:
> > +               st->wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> > +               break;
> > +       }
> > +
> >         return 0;
> >
> >  error_power_off:
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h
> > index e1c0c5146876..a91b9c2b26e4 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > @@ -212,6 +212,7 @@ struct inv_mpu6050_state {
> >         bool level_shifter;
> >         u8 *data;
> >         s64 it_timestamp;
> > +       unsigned int wom_bits;
> >  };
> >
> >  /*register and associated bit definition*/
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_trigger.c
> > index 84273660ca2e..b19556df1801 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > @@ -243,26 +243,10 @@ static irqreturn_t inv_mpu6050_interrupt_handle(i=
nt irq, void *p)
> >  {
> >         struct iio_dev *indio_dev =3D p;
> >         struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > -       unsigned int int_status, wom_bits;
> > +       unsigned int int_status;
> >         u64 ev_code;
> >         int result;
> >
> > -       switch (st->chip_type) {
> > -       case INV_MPU6050:
> > -       case INV_MPU6500:
> > -       case INV_MPU6515:
> > -       case INV_MPU6880:
> > -       case INV_MPU6000:
> > -       case INV_MPU9150:
> > -       case INV_MPU9250:
> > -       case INV_MPU9255:
> > -               wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> > -               break;
> > -       default:
> > -               wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> > -               break;
> > -       }
> > -
> >         scoped_guard(mutex, &st->lock) {
> >                 /* ack interrupt and check status */
> >                 result =3D regmap_read(st->map, st->reg->int_status, &i=
nt_status);
> > @@ -272,7 +256,7 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int=
 irq, void *p)
> >                 }
> >
> >                 /* handle WoM event */
> > -               if (st->chip_config.wom_en && (int_status & wom_bits)) {
> > +               if (st->chip_config.wom_en && (int_status & st->wom_bit=
s)) {
> >                         ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, II=
O_MOD_X_OR_Y_OR_Z,
> >                                                      IIO_EV_TYPE_ROC, I=
IO_EV_DIR_RISING);
> >                         iio_push_event(indio_dev, ev_code, st->it_times=
tamp);
> > --
> > 2.34.1
> >
> > =20


