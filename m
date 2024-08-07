Return-Path: <linux-iio+bounces-8313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE894AE65
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 18:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20FCB22797
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507913C669;
	Wed,  7 Aug 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwsPeyjO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9F2D05D
	for <linux-iio@vger.kernel.org>; Wed,  7 Aug 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049346; cv=none; b=SEBHWhkMBn136MCT/wZnB4WrQQB/4+bHaRQbZ45DfJHVL6Kd+jlFbQOxpnRSahqJ1aC1RtDz/y6elGP1iAq53FvUu/KMPgsZv/+T42gaziFzNZ5mwnQ0hVlitFOu4LFAe1MIo1wRq8X6xfa3fR+UWllPPk+iouN7Y6nESBP5P0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049346; c=relaxed/simple;
	bh=nS/V9SdhIo0pNLmubXPACAc/OP3CR/6Bd7wCPd3KE88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WL0SmRsfgGxXk3gn/s9ExBLHgKh7VqZgs9c6YgFwFb9HL2rkR1rMqlYT9w1mBBWyy4CicnBSOTn3bBfPyvpk5/oVdwwXwJv+My4kEhjdOMIy04LSe+G2S2bKahwW2AhJyVV2/x+Ao+EfQ7kuFm9GHs/v4lW/gQESvk6GllDVdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwsPeyjO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f025bc147so1278e87.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Aug 2024 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723049343; x=1723654143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WluElBvIafex0VotOkNsGmifmLxxc5gHPpx13kClYs=;
        b=jwsPeyjOehU03ALnzqxZ+EWLczG1BVjBhZuo1DkbpyknFoQUOpo2s4XJsRbpdvocK2
         ttWBcRgXEdmLrQBsBBJS8A/VfKySiozoS0C5pJNfG/mFtzak3L9TU/NkscZqNYqFE8/3
         ThzchI3hgGj9SBMhO3zlo6NbjK1y+1ysA3lrhn/MBWZB5dmLEAprhBcQFM46r6CNZKCY
         T1MvQhELs9AHLYqF5j9LL7QH0vjq9PJgBUBzd3zxkEYYACuKliKvs0ku/Ae3ynu+VNaq
         8Framx4HggIHEtHiUZLJcPJCDo6lkg/NRCDOFWIj3EyEygL+mtLW5HbOUi2Og5MZ15eK
         gCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723049343; x=1723654143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WluElBvIafex0VotOkNsGmifmLxxc5gHPpx13kClYs=;
        b=ukx9bB1h5ZG/PyIJ9RUR4Fk1RSN3JMIycVtp6R2oSKCF8PP4YeQiw7yyMi5qT+wfq1
         9ksfW/NG0G86XjGYvhPesGuTrJzROEXRzPs1uSfJspOylE22tlGeeBB7a/gwnNmOJjk5
         /3xmtd/DYAFqEjyZmX8Pw+MAtmBxdlrhnilIlN+w3v7p0HNUWRUQfgQlOYZDou8fYMnt
         G6KZYpUudMrVoeLazhUURVPSXv7ayIRmCwcL/AaSkbOut3uJrm3Ft8Q0PHhO7hVYQ4SY
         a+hHufAf17OZzvaiICxNdllhlV9h7X/GjQXGP6T17LjlpLBmWOGGXDL+XuS7m0ekFSkJ
         lwmg==
X-Forwarded-Encrypted: i=1; AJvYcCXEJlTDyL72qA3PDHcywKjzZ3atn8p6I92nKI2RsXqoFLiZwNabdFyxTWgyC2K/C+YOZNJ/zej186QhxydPOIt+tEds2jLceB54
X-Gm-Message-State: AOJu0Yy2iEG3f/e4HE6EK4dyfbWxbGPWdlafdFIX3p4YAhjbIqhE14hS
	KWNHa8/hQbIq229dAljNwHhud0uH7Tz/v1nXqsItdY9Z53xXtA+/4pcKSLp4PLTMsmnzYUBaVUP
	pG7ZOdvKe7VI8bTN/t4cV4UxpBk8=
X-Google-Smtp-Source: AGHT+IGq3wsT0WAyT43yoTwZO4Xzm+YfsV2OuZOtjOLBxJTkQYbfp17taCFNqcRtICHkDO9FqKQJ0xVmu9AaLkfFyPo=
X-Received: by 2002:a05:6512:1253:b0:52e:fa5f:b6b1 with SMTP id
 2adb3069b0e04-530bb3a69a8mr10508471e87.60.1723049342102; Wed, 07 Aug 2024
 09:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
 <20240311160557.437337-4-inv.git-commit@tdk.com> <0ea167a1-75d0-469d-a79f-ff2cb5e81bdc@gmail.com>
 <20240806175324.3eea67c7@jic23-huawei> <FR3P281MB175788FAFA8CEB3DDF1D9AC0CEB82@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <CAPVz0n3j_O45tonPY4LovAOeqkopq0q9r6CnbERyu5+Z5+_r-g@mail.gmail.com> <BE1P281MB1745EB41BE925B1E06774E39CEB82@BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <BE1P281MB1745EB41BE925B1E06774E39CEB82@BE1P281MB1745.DEUP281.PROD.OUTLOOK.COM>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 7 Aug 2024 19:48:50 +0300
Message-ID: <CAPVz0n3HxFezXwtrkOaVCYkxh8gn4aUGzEqdDYdOVLux=0aj2Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, INV Git Commit <INV.git-commit@tdk.com>, 
	"lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 7 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 19:18=
 Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Thanks for the response.
>
> Are you able to modify the driver to print the whoami value? Otherwise, y=
ou can also use the debug feature of iio to read manually the whoami regist=
er if you know how to do it.
>

Sure, here you go
[    5.498447] inv-mpu6050-i2c 0-0068: The required whoami value is
104, name MPU6050

> Are you seeing some sensor data coming or nothing?
>

Data is coming, sensors seem to work as expected. Only constant dmesg
flooding with
[ 50.035018] inv-mpu6050-i2c 0-0068: failed to ack interrupt -121

Data from sensors
accelerometer    mpu6050              /sys/bus/iio/devices/iio:device2
   working    0.13, 0.03, 10.64 g
gyroscope        mpu6050              /sys/bus/iio/devices/iio:device2
   working    -0.02, -0.01, 0.04 rad/s
temperature      mpu6050              /sys/bus/iio/devices/iio:device2
   working    36.2 deg C

accelerometer    mpu6050              /sys/bus/iio/devices/iio:device2
   working    10.04, -1.06, 1.02 g
gyroscope        mpu6050              /sys/bus/iio/devices/iio:device2
   working    0.01, -0.02, 0.02 rad/s
temperature      mpu6050              /sys/bus/iio/devices/iio:device2
   working    47.8 deg C

> Are you seeing the error when turning a sensor on, or are sensors turned =
on automatically by the device?

It is turned on automatically.

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

