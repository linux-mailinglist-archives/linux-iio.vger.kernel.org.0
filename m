Return-Path: <linux-iio+bounces-8310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DFB94AD9B
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 18:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9978E283A5B
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5EB13212B;
	Wed,  7 Aug 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgu85WbJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A312F588
	for <linux-iio@vger.kernel.org>; Wed,  7 Aug 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046631; cv=none; b=trk4YIWBDxpzIlBwYUek45pDpbDH6eNNOcjRnqFp9ghZyuV2R0+nJ54PG4Tk94liIGoDYw10/7tFxC0p38y1k23hqPlyQuZDWItzEDn1IVEbTZOQjiEzec59U5cxD9jgw0/2FllCvtxk3R4PHkjdxuEUihgYBdQlIYcUBamd5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046631; c=relaxed/simple;
	bh=UHcPFY/LL0ufoOoXQpTD0kp5CsS6gXho2yTX7B0BXyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UavvLA1qw0gjr+A4rySgoKfuG1uqT0NzO4L7iISBmC2rCKa1v3IEcMDNzm3pPERPDCbYQ56xC6RUF8h42mZoJRWswjHEEmMklG3phS8Du0uQ6P0LXfNI8oI1/X2fOM/oNcVbqYnEJwZrSRfZqA0ViRmLg4UVlL3ZoFsyyldBNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgu85WbJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428101fa30aso166585e9.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Aug 2024 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723046627; x=1723651427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTPhBe2QExKnpLcJb29bXJlZlZGrdqwmpHKLUs3am1k=;
        b=Dgu85WbJM9jT8P+pNKFa8PX1SLFqHoawXz4pLU0OUpZQKmdXNh4DjWLOqkN6FzxvKG
         3ItPfqIiBNvzzRJfsa/D4z/qSRZFTa3ifoMVT3+S7WOgSUOabjIiSDtB+nc5RCzJ5yBg
         TIA6gMYeLaWHFMKVrvF5X4gGV6fXvQDI9PCIQtrAyPLj9gr/mlYs5XMKfGK06m9RWJMZ
         YbXiLQfy3+d67gurYoVrO1cC+2S9tCX4S7Gonx4VUig8rVNiOIPiGc1ltBR7FUQtRbdw
         4qt7NKO8c+a5bM0b9v+V7q+LjYd190EQnCWYayksk21Mq3LuyZYE+zGY2NrSE4mB7rWn
         cFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723046627; x=1723651427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTPhBe2QExKnpLcJb29bXJlZlZGrdqwmpHKLUs3am1k=;
        b=v8uq2MLCJwado/AJaJgszbgec13+ytmxIKwhnC74AfzmcET8BpBaH3ErqxR81HLYLA
         14TIQd/KEmVfuGmyP+/qu9z9JJpXJZJXDlBfvwH7l0A9D+BRo+2MEbzsYtomFPvBWjpx
         Hk67hFy3aLKZcEZYg2Djo0U5Up/PR7ZeHN/94/Q9mwSu95Ocgoj+KgMlF71igIbZbVEK
         zdX8Vr+7MULx/t4z4h9qlUSXVXaxH02PtAqupA8Kii66XzEo6Zqx/EHQ2fOTkn6bcIb4
         VNVuGZu9uAWyXvw5gvlkB/0uJPpZBF/jYaEGU5NXPri+XxWZQ6Mf6wOPVmIkDDmTD97Z
         rMBw==
X-Forwarded-Encrypted: i=1; AJvYcCXChg9eLbLJx4parzOUcNGW6VRDbIWKeCLWiNTqhCGy0LZfLnr7xuo5oSkMLDp2j844IQrB2wYa+GeQMqS41SuSdfkG3W83vwP8
X-Gm-Message-State: AOJu0YzASWYaIxETXE4gToFVf8mmhTO2JJ4SJcwgzrzSG5VXR4HwvGlC
	Ph9HQT06Vn2WLClQGQxxzua37T4S5N7eV5oj57c43H9iRncs2ycIt9/AEsNJVeigZFZFXGst7Yq
	HefL2zMp3KN4bE8X6BUiGTv4MfUM=
X-Google-Smtp-Source: AGHT+IGkhXHsp4pj3seOrIi4FHAZK5Cwfaq4azr1qY5PH1k5umMUfoYRlOWNqK+n991xevDXc9aFI647r052+0iBFwc=
X-Received: by 2002:a05:6000:128b:b0:368:7f4f:9ead with SMTP id
 ffacd0b85a97d-36bbc0b4f07mr12114696f8f.7.1723046627141; Wed, 07 Aug 2024
 09:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
 <20240311160557.437337-4-inv.git-commit@tdk.com> <0ea167a1-75d0-469d-a79f-ff2cb5e81bdc@gmail.com>
 <20240806175324.3eea67c7@jic23-huawei> <FR3P281MB175788FAFA8CEB3DDF1D9AC0CEB82@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB175788FAFA8CEB3DDF1D9AC0CEB82@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 7 Aug 2024 19:03:35 +0300
Message-ID: <CAPVz0n3j_O45tonPY4LovAOeqkopq0q9r6CnbERyu5+Z5+_r-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, INV Git Commit <INV.git-commit@tdk.com>, 
	"lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 7 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 18:48=
 Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello Jonathan and Svyatoslav,
>
> this is really strange because it is an I2C transaction error happening.
> The chip is obviously on, otherwise it would not be able to send interrup=
t and have sensors running.
>
> For investigating the issue, we need to know what is the chip used inside=
 this device. The driver is supporting a lot of chips that may have some sp=
ecific behaviors.
>
> Svyatoslav,
> can you give us the name of the chip in this LG device or the whoami valu=
e read by the driver?
>

According to available schematics it is named as MPU-6050
Accelerometer embedded Gyro Sensor 4X4 QFN R/TP 24P One Chip Solution
INVENSENSE.

> Thanks a lot for your help.
> JB
>
> ________________________________________
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Tuesday, August 6, 2024 18:53
> To: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: INV Git Commit <INV.git-commit@tdk.com>; lars@metafoo.de <lars@metafo=
o.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jean-Baptiste=
 Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt hand=
ler for WoM events
>
> This Message Is From an External Sender
> This message came from outside your organization.
>
> On Tue, 23 Jul 2024 11:25:03 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > 11.03.24 6:05 =D0=BF=D0=BF, inv.git-commit@tdk.com:
> > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > >
> > > Add new interrupt handler for generating WoM event from int status re=
gister
> > > bits. Launch from interrupt the trigger poll function for data buffer=
.
> > >
> > > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com=
>
>
> Jean-Baptiste,
>
> Please take a look at this report.  I'd rather not revert the series
> if we can figure out what is wrong and get a fix on top in reasonably
> quickly.
>
> I'd guess a power problem so we are getting interrupts when device is pow=
ered down?
> Hence the reads fail.
>
> Jonathan
>
> > > ---
> > >   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
> > >   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ---
> > >   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 69 ++++++++++++++++=
+--
> > >   3 files changed, 66 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_iio.h
> > > index d5b0465d1f74..ca5f7d45a6d4 100644
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > > @@ -185,6 +185,7 @@ struct inv_mpu6050_hw {
> > >    *  @magn_orient:       magnetometer sensor chip orientation if ava=
ilable.
> > >    *  @suspended_sensors:   sensors mask of sensors turned off for su=
spend
> > >    *  @data:                read buffer used for bulk reads.
> > > + *  @it_timestamp: interrupt timestamp.
> > >    */
> > >   struct inv_mpu6050_state {
> > >     struct mutex lock;
> > > @@ -210,6 +211,7 @@ struct inv_mpu6050_state {
> > >     unsigned int suspended_sensors;
> > >     bool level_shifter;
> > >     u8 *data;
> > > +   s64 it_timestamp;
> > >   };
> > >
> > >   /*register and associated bit definition*/
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio=
/imu/inv_mpu6050/inv_mpu_ring.c
> > > index 13da6f523ca2..e282378ee2ca 100644
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > > @@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *=
p)
> > >     u32 fifo_period;
> > >     s64 timestamp;
> > >     u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
> > > -   int int_status;
> > >     size_t i, nb;
> > >
> > >     mutex_lock(&st->lock);
> > >
> > > -   /* ack interrupt and check status */
> > > -   result =3D regmap_read(st->map, st->reg->int_status, &int_status)=
;
> > > -   if (result) {
> > > -           dev_err(regmap_get_device(st->map),
> > > -                   "failed to ack interrupt\n");
> > > -           goto flush_fifo;
> > > -   }
> > > -   if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
> > > -           goto end_session;
> > > -
> > >     if (!(st->chip_config.accl_fifo_enable |
> > >             st->chip_config.gyro_fifo_enable |
> > >             st->chip_config.magn_fifo_enable))
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/=
iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > index ec2398a87f45..2514966f6495 100644
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > @@ -6,6 +6,7 @@
> > >   #include <linux/pm_runtime.h>
> > >
> > >   #include <linux/iio/common/inv_sensors_timestamp.h>
> > > +#include <linux/iio/events.h>
> > >
> > >   #include "inv_mpu_iio.h"
> > >
> > > @@ -223,6 +224,65 @@ static const struct iio_trigger_ops inv_mpu_trig=
ger_ops =3D {
> > >     .set_trigger_state =3D &inv_mpu_data_rdy_trigger_set_state,
> > >   };
> > >
> > > +static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *p)
> > > +{
> > > +   struct iio_dev *indio_dev =3D p;
> > > +   struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > > +
> > > +   st->it_timestamp =3D iio_get_time_ns(indio_dev);
> > > +
> > > +   return IRQ_WAKE_THREAD;
> > > +}
> > > +
> > > +static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
> > > +{
> > > +   struct iio_dev *indio_dev =3D p;
> > > +   struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > > +   unsigned int int_status, wom_bits;
> > > +   u64 ev_code;
> > > +   int result;
> > > +
> > > +   switch (st->chip_type) {
> > > +   case INV_MPU6050:
> > > +   case INV_MPU6500:
> > > +   case INV_MPU6515:
> > > +   case INV_MPU6880:
> > > +   case INV_MPU6000:
> > > +   case INV_MPU9150:
> > > +   case INV_MPU9250:
> > > +   case INV_MPU9255:
> > > +           wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> > > +           break;
> > > +   default:
> > > +           wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> > > +           break;
> > > +   }
> > > +
> > > +   scoped_guard(mutex, &st->lock) {
> > > +           /* ack interrupt and check status */
> > > +           result =3D regmap_read(st->map, st->reg->int_status, &int=
_status);
> > > +           if (result) {
> > > +                   dev_err(regmap_get_device(st->map), "failed to ac=
k interrupt\n");
> > > +                   return IRQ_HANDLED;
> > > +           }
> > > +
> > > +           /* handle WoM event */
> > > +           if (st->chip_config.wom_en && (int_status & wom_bits)) {
> > > +                   ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_=
MOD_X_OR_Y_OR_Z,
> > > +                                                IIO_EV_TYPE_ROC, IIO=
_EV_DIR_RISING);
> > > +                   iio_push_event(indio_dev, ev_code, st->it_timesta=
mp);
> > > +           }
> > > +   }
> > > +
> > > +   /* handle raw data interrupt */
> > > +   if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
> > > +           indio_dev->pollfunc->timestamp =3D st->it_timestamp;
> > > +           iio_trigger_poll_nested(st->trig);
> > > +   }
> > > +
> > > +   return IRQ_HANDLED;
> > > +}
> > > +
> > >   int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_ty=
pe)
> > >   {
> > >     int ret;
> > > @@ -235,11 +295,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *i=
ndio_dev, int irq_type)
> > >     if (!st->trig)
> > >             return -ENOMEM;
> > >
> > > -   ret =3D devm_request_irq(&indio_dev->dev, st->irq,
> > > -                          &iio_trigger_generic_data_rdy_poll,
> > > -                          irq_type,
> > > -                          "inv_mpu",
> > > -                          st->trig);
> > > +   ret =3D devm_request_threaded_irq(&indio_dev->dev, st->irq,
> > > +                                   &inv_mpu6050_interrupt_timestamp,
> > > +                                   &inv_mpu6050_interrupt_handle,
> > > +                                   irq_type, "inv_mpu", indio_dev);
> > >     if (ret)
> > >             return ret;
> > >
> >
> > Greetings!
> >
> > After this patch was applied to Linux kernel I faced a regression on my
> > devices LG P895/P880.
> >
> > Dmesg is flooded with
> >
> > [ 50.035018] inv-mpu6050-i2c 0-0068: failed to ack interrupt -121
> >
> > and mpu6050 used on this device refuses to work. It did not occur befor=
e
> > WoM patches were
> >
> > applied and reverting patches restores normal work of mpu6050.
> >
> >
> > Best regards,
> >
> > Svyatoslav R.
> >
>

