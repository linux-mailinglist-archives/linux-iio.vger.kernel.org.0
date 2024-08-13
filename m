Return-Path: <linux-iio+bounces-8452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43BF9509DF
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83387B28B89
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1C1A08B1;
	Tue, 13 Aug 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSrlMhb6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7E1A0709
	for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565389; cv=none; b=tw56eMU0ic61U2S9TGcabQg9iau0rbryhCfcObscr+S3xNdtoGtfuo2eUt1w9/rCppkaOPZ4EEMdZ8awyRKCCQzHoKsqTtZljRXatxWmjcnigDWoncMSskEkHK95bXd0oRd0DvtOceNiqF+vJzECP/y3R1tdCRfeaM6DJ/VEo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565389; c=relaxed/simple;
	bh=q8FlFD+tmMc736eKwVHOetEj6wiH6qITMcurt3yEZso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3RoY23CSZ9tOWbsVVvSMXaRK+olhcF4Uy/rYQ6unwGfBx9tf2WtK4zSuc/7NzeaZOiTfc6VU0ZJ35ats93QOvcVDhhrRAkcJ+O9fIkc6rawS1MWATeIjNr7BiFeuQiqFikYDfZeNyIBMY9TTpT9AbEbr94CLN2yxnzVDfIeYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSrlMhb6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42816ca782dso43700855e9.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723565386; x=1724170186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+k01pxdnwO2a/au6GQeOrVlOko8AACkF9XnjqpQWFw=;
        b=WSrlMhb6tZ5MsT/fXssJRvOJU+hmbQK1uTU4fWWeE1iozuHQD6l1N+BVjPV1AhbOyO
         oDddVP76khTbAtO/ag2IwTeN5lPQDQLkmbMoylsBLgZLvuwforu6Lbds5iSi2YBOeVFY
         MgNdywpAZ2fwYd/d5GSBwiDJow5DTpfzjnM+i+HF6S4hUk8Wxz9IHqE4XF6WiDoKjASI
         4hY7zXP7Mw261t/d1ww/Bp59drGF0HLzUwoSTN9wNKklLMOhYbgp7ilhe6WtTaKCujGN
         FO1k1hnuFC4QlDAeHIEyPytPxoPxXGSMN1YQ4twMVjH2IjGd7QwR3kTufnCHEgEpI8G/
         L/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723565386; x=1724170186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+k01pxdnwO2a/au6GQeOrVlOko8AACkF9XnjqpQWFw=;
        b=ayWhBsPUXgeviCoYcCM9WTWOKY04f/NhuYFn26vlP7M5jxofn40LAqdmitGGm/LYnf
         QvEgteVodIo/NZfO/R6rCNd8uKd9uVJp59Ukq3kJEoIaUk2BBrgCMfDMeTYHD0FzuWnf
         nyECniVjgNtTDMDg/aKhUHf3tHEGhh1QvSs61hcnNkw1x5HW0MpkNeHRrhpkvtIcfRMJ
         rpnUBNg7lhmXoEGWYYKVAE2s3ZsUx3zqZzv7j1JeRk/h8p3EGnLnD8aXvKWgMkrDQSyr
         iCTGb1N4ghnqc84PwQPMsBfL0bY6PE2POgvHcpDzXD5bEfV1txV03WyjmkNP29ixY70k
         3jaA==
X-Forwarded-Encrypted: i=1; AJvYcCWpTq8QoTjgCGDTjqmbooZE7OJDY0TvSx+2+G27qen86AdfaMvW9ZdLvLz7ghxSsAFuXofEI5W0NxcYAnYE8zeOzGxoUeACe951
X-Gm-Message-State: AOJu0YxoOAXtwbhgTZjYvvwHywBNy7GwXtMN/NW2+rxLRc2qyg+OB7CV
	HwKWYW1n1pCa9eFIfkw4+BLBYzAg5kiHqqVbJ7IL8xoOGho0yH2dqCDJNtvegR2Lx0cDP2B7ygd
	k0OjZbGx2N2zNKiCHaQWq6riwju4=
X-Google-Smtp-Source: AGHT+IFNIIT+gRII/SXQJkt1LFvdGWMzC8MdnzH3ixDQWzPqYkqnZcjMzhIeLLOjNA3kAq1lZxHIZLAcgPkWwPZSJAs=
X-Received: by 2002:a05:6000:b85:b0:36b:d21e:bf85 with SMTP id
 ffacd0b85a97d-37177824825mr54025f8f.51.1723565385305; Tue, 13 Aug 2024
 09:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
 <20240311160557.437337-4-inv.git-commit@tdk.com> <0ea167a1-75d0-469d-a79f-ff2cb5e81bdc@gmail.com>
 <20240806175324.3eea67c7@jic23-huawei> <FR3P281MB175788FAFA8CEB3DDF1D9AC0CEB82@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <CAPVz0n3j_O45tonPY4LovAOeqkopq0q9r6CnbERyu5+Z5+_r-g@mail.gmail.com>
 <BE1P281MB1745EB41BE925B1E06774E39CEB82@BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM>
 <FR3P281MB17572E9470BF9D54E1CCF5D7CE862@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB17572E9470BF9D54E1CCF5D7CE862@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 13 Aug 2024 19:09:34 +0300
Message-ID: <CAPVz0n0ibQq58R6Z8+wHZYPDmN8as_F4DCeuLexHXsxO=+_bug@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, INV Git Commit <INV.git-commit@tdk.com>, 
	"lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 13 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 19:0=
6 Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello,
>
> I was able to test the latest code with an old MPU-9150 (MPU-6050 + AKM m=
ag inside a single package), and everything is working well.
>
> We can suspect that some MPU-6050 chips have perhaps an issue when readin=
g interrupt status register. Explaining perhaps while the old implementatio=
n wasn't reading the interrupt status register before.
>
> 1 solution would be to delete this interrupt status register read for MPU=
-6050/MPU-9150 since WoM feature is not available on these chips. We can go=
 back to original behavior of skipping interrupt status register read since=
 data ready interrupt is the only interrupt source for these chips.
>
> Would that be an acceptable fix for you?
>

Yes, sure. Thank you for response and fix.

Best regards,
Svyatoslav R.

> Thanks for your response,
> JB
>
> ________________________________________
> From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Sent: Wednesday, August 7, 2024 18:18
> To: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; INV Git Commit <INV.git-commit@t=
dk.com>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linu=
x-iio@vger.kernel.org>
> Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt hand=
ler for WoM events
>
> This Message Is From an External Sender
> This message came from outside your organization.
>
> Thanks for the response.
>
> Are you able to modify the driver to print the whoami value? Otherwise, y=
ou can also use the debug feature of iio to read manually the whoami regist=
er if you know how to do it.
>
> Are you seeing some sensor data coming or nothing?
>
> Are you seeing the error when turning a sensor on, or are sensors turned =
on automatically by the device?
>
> If you can explain the test case it would help to investigate.
>
> Thanks a lot,
> JB
>
> ________________________________________
> From: Svyatoslav Ryhel <clamor95@gmail.com>
> Sent: Wednesday, August 7, 2024 18:03
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; INV Git Commit <INV.git-commit@t=
dk.com>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linu=
x-iio@vger.kernel.org>
> Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt hand=
ler for WoM events
>
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
>
> =D1=81=D1=80, 7 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 18:=
48 Jean-Baptiste Maneyrol
> <Jean-Baptiste.Maneyrol@tdk.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hello Jonathan and Svyatoslav,
> >
> > this is really strange because it is an I2C transaction error happening=
.
> > The chip is obviously on, otherwise it would not be able to send interr=
upt and have sensors running.
> >
> > For investigating the issue, we need to know what is the chip used insi=
de this device. The driver is supporting a lot of chips that may have some =
specific behaviors.
> >
> > Svyatoslav,
> > can you give us the name of the chip in this LG device or the whoami va=
lue read by the driver?
> >
>
> According to available schematics it is named as MPU-6050
> Accelerometer embedded Gyro Sensor 4X4 QFN R/TP 24P One Chip Solution
> INVENSENSE.
>
> > Thanks a lot for your help.
> > JB
> >
> > ________________________________________
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Tuesday, August 6, 2024 18:53
> > To: Svyatoslav Ryhel <clamor95@gmail.com>
> > Cc: INV Git Commit <INV.git-commit@tdk.com>; lars@metafoo.de <lars@meta=
foo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jean-Baptis=
te Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt ha=
ndler for WoM events
> >
> > This Message Is From an External Sender
> > This message came from outside your organization.
> >
> > On Tue, 23 Jul 2024 11:25:03 +0300
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> >
> > > 11.03.24 6:05 =D0=BF=D0=BF, inv.git-commit@tdk.com:
> > > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > > >
> > > > Add new interrupt handler for generating WoM event from int status =
register
> > > > bits. Launch from interrupt the trigger poll function for data buff=
er.
> > > >
> > > > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.c=
om>
> >
> > Jean-Baptiste,
> >
> > Please take a look at this report.  I'd rather not revert the series
> > if we can figure out what is wrong and get a fix on top in reasonably
> > quickly.
> >
> > I'd guess a power problem so we are getting interrupts when device is p=
owered down?
> > Hence the reads fail.
> >
> > Jonathan
> >
> > > > ---
> > > >   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
> > > >   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ---
> > > >   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 69 ++++++++++++++=
+++--
> > > >   3 files changed, 66 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_iio.h
> > > > index d5b0465d1f74..ca5f7d45a6d4 100644
> > > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > > > @@ -185,6 +185,7 @@ struct inv_mpu6050_hw {
> > > >    *  @magn_orient:       magnetometer sensor chip orientation if a=
vailable.
> > > >    *  @suspended_sensors:   sensors mask of sensors turned off for =
suspend
> > > >    *  @data:                read buffer used for bulk reads.
> > > > + *  @it_timestamp: interrupt timestamp.
> > > >    */
> > > >   struct inv_mpu6050_state {
> > > >     struct mutex lock;
> > > > @@ -210,6 +211,7 @@ struct inv_mpu6050_state {
> > > >     unsigned int suspended_sensors;
> > > >     bool level_shifter;
> > > >     u8 *data;
> > > > +   s64 it_timestamp;
> > > >   };
> > > >
> > > >   /*register and associated bit definition*/
> > > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/i=
io/imu/inv_mpu6050/inv_mpu_ring.c
> > > > index 13da6f523ca2..e282378ee2ca 100644
> > > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > > > @@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void=
 *p)
> > > >     u32 fifo_period;
> > > >     s64 timestamp;
> > > >     u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
> > > > -   int int_status;
> > > >     size_t i, nb;
> > > >
> > > >     mutex_lock(&st->lock);
> > > >
> > > > -   /* ack interrupt and check status */
> > > > -   result =3D regmap_read(st->map, st->reg->int_status, &int_statu=
s);
> > > > -   if (result) {
> > > > -           dev_err(regmap_get_device(st->map),
> > > > -                   "failed to ack interrupt\n");
> > > > -           goto flush_fifo;
> > > > -   }
> > > > -   if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
> > > > -           goto end_session;
> > > > -
> > > >     if (!(st->chip_config.accl_fifo_enable |
> > > >             st->chip_config.gyro_fifo_enable |
> > > >             st->chip_config.magn_fifo_enable))
> > > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/driver=
s/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > > index ec2398a87f45..2514966f6495 100644
> > > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > > @@ -6,6 +6,7 @@
> > > >   #include <linux/pm_runtime.h>
> > > >
> > > >   #include <linux/iio/common/inv_sensors_timestamp.h>
> > > > +#include <linux/iio/events.h>
> > > >
> > > >   #include "inv_mpu_iio.h"
> > > >
> > > > @@ -223,6 +224,65 @@ static const struct iio_trigger_ops inv_mpu_tr=
igger_ops =3D {
> > > >     .set_trigger_state =3D &inv_mpu_data_rdy_trigger_set_state,
> > > >   };
> > > >
> > > > +static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *=
p)
> > > > +{
> > > > +   struct iio_dev *indio_dev =3D p;
> > > > +   struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > > > +
> > > > +   st->it_timestamp =3D iio_get_time_ns(indio_dev);
> > > > +
> > > > +   return IRQ_WAKE_THREAD;
> > > > +}
> > > > +
> > > > +static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
> > > > +{
> > > > +   struct iio_dev *indio_dev =3D p;
> > > > +   struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > > > +   unsigned int int_status, wom_bits;
> > > > +   u64 ev_code;
> > > > +   int result;
> > > > +
> > > > +   switch (st->chip_type) {
> > > > +   case INV_MPU6050:
> > > > +   case INV_MPU6500:
> > > > +   case INV_MPU6515:
> > > > +   case INV_MPU6880:
> > > > +   case INV_MPU6000:
> > > > +   case INV_MPU9150:
> > > > +   case INV_MPU9250:
> > > > +   case INV_MPU9255:
> > > > +           wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> > > > +           break;
> > > > +   default:
> > > > +           wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> > > > +           break;
> > > > +   }
> > > > +
> > > > +   scoped_guard(mutex, &st->lock) {
> > > > +           /* ack interrupt and check status */
> > > > +           result =3D regmap_read(st->map, st->reg->int_status, &i=
nt_status);
> > > > +           if (result) {
> > > > +                   dev_err(regmap_get_device(st->map), "failed to =
ack interrupt\n");
> > > > +                   return IRQ_HANDLED;
> > > > +           }
> > > > +
> > > > +           /* handle WoM event */
> > > > +           if (st->chip_config.wom_en && (int_status & wom_bits)) =
{
> > > > +                   ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, II=
O_MOD_X_OR_Y_OR_Z,
> > > > +                                                IIO_EV_TYPE_ROC, I=
IO_EV_DIR_RISING);
> > > > +                   iio_push_event(indio_dev, ev_code, st->it_times=
tamp);
> > > > +           }
> > > > +   }
> > > > +
> > > > +   /* handle raw data interrupt */
> > > > +   if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
> > > > +           indio_dev->pollfunc->timestamp =3D st->it_timestamp;
> > > > +           iio_trigger_poll_nested(st->trig);
> > > > +   }
> > > > +
> > > > +   return IRQ_HANDLED;
> > > > +}
> > > > +
> > > >   int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_=
type)
> > > >   {
> > > >     int ret;
> > > > @@ -235,11 +295,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev =
*indio_dev, int irq_type)
> > > >     if (!st->trig)
> > > >             return -ENOMEM;
> > > >
> > > > -   ret =3D devm_request_irq(&indio_dev->dev, st->irq,
> > > > -                          &iio_trigger_generic_data_rdy_poll,
> > > > -                          irq_type,
> > > > -                          "inv_mpu",
> > > > -                          st->trig);
> > > > +   ret =3D devm_request_threaded_irq(&indio_dev->dev, st->irq,
> > > > +                                   &inv_mpu6050_interrupt_timestam=
p,
> > > > +                                   &inv_mpu6050_interrupt_handle,
> > > > +                                   irq_type, "inv_mpu", indio_dev)=
;
> > > >     if (ret)
> > > >             return ret;
> > > >
> > >
> > > Greetings!
> > >
> > > After this patch was applied to Linux kernel I faced a regression on =
my
> > > devices LG P895/P880.
> > >
> > > Dmesg is flooded with
> > >
> > > [ 50.035018] inv-mpu6050-i2c 0-0068: failed to ack interrupt -121
> > >
> > > and mpu6050 used on this device refuses to work. It did not occur bef=
ore
> > > WoM patches were
> > >
> > > applied and reverting patches restores normal work of mpu6050.
> > >
> > >
> > > Best regards,
> > >
> > > Svyatoslav R.
> > >
> >

