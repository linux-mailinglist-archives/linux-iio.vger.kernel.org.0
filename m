Return-Path: <linux-iio+bounces-8470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1A5951F2B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 17:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F2D1F22888
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212451B86C5;
	Wed, 14 Aug 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9DBkfVJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63A28DC3
	for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650822; cv=none; b=a+YAr370V2T50ITbV/y/9HCJuc1bB8U8S0TOLKWm1ZxTehcMTTw24wSsbqiJdYSNIlgOJ9wLZjhb+GeHfULNl53dbPDEBEVpxVdeEn3M2bGOVnIOlGy1/GzDWyo1KeMsIv/qLJbMSNN82HALIDGd+RIiBFt7WpGEmlaZIZWYmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650822; c=relaxed/simple;
	bh=wqmBuxitOM1SSBFYBYMz3A86wZTn0df9aMESVe2w7fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oh+AvF+ISvOkXJ+gBEWso2zb5YyNwE505nGzd/UXecAb527uIfI5z2nRsImYQicyT7wijI2suIqoaVC6VVzI76Sl4lb+g9h9QqYg3+Bc/evtfVShaxmqirvdAuicHafrYSoB8jEVqWQeqAdnWu1eIncUeUEB7q891LYO9gglzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9DBkfVJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-368440b073bso653684f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723650819; x=1724255619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5OqrtvYmUWdF7PYz7Qbjht40gUYh7Tp/92j0KCvlBs=;
        b=S9DBkfVJU46yOePS3oknthOPjw4Si5u7o6BCmqcDmcvqLoUFKZPu8l74sjafKBuYej
         em99NJMGO74Cxtu7cv93r2mUkd3F6rE9i4Kyg2j9h0NDw0wzwnKqiYjYuxcccJEObsxK
         MNfF++xd14Hpz5lKFv8qGCudfwOl+7J9fFweMgUTNaZ45FjJ94RG+oaLHBLsFZlEBW0s
         Mdkh981d7pQxyJ57a75N4k8vcijFzcNvSUiXolU5yOJp02r5q+PsCNdJdVzL7iPsyoxe
         ukJMsBK/P0R9V5mYuvak0xISvB6987u4Ovb0yyObETdpqA1mnnkhesJ4o8mc2Ld22bIr
         SvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650819; x=1724255619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5OqrtvYmUWdF7PYz7Qbjht40gUYh7Tp/92j0KCvlBs=;
        b=iT9x4MsSO5MQg+nWP2fL8Ftc+PITGIQrVJC9IxLogARBxTt1jRpSIoZqOsc7+sUn0D
         NlPMk1M4VCmTg/cNHz1URPzlOInWH39i4a7X48znxmcj9kxpVEbsYI8Nnuzj/QzCVwYw
         t5gh/qJxEEqL4UaHRGm1hIViNJBfJ1urWiTuBAH3v4J0nl2DccsNtW/GP8akZ0P6oGCK
         4gk8NUJ3lJsWMZSd0IVfD5GR2Av922zvzhmlPZViz3jZZ2k2ZRnygZsWpcG6vkEydsII
         uUZiax4nNNnUmecEgdRN64r4m2edG3caXDGMGQ2U4gB8s08gwRRUFfqhSSgPhGkZWhA9
         I80Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy+NFesf/UYm2g8OSnqrm70yTMzJJjuvYLhla0iaxgQeYtAiz3GmLdk/5pcThZXlzp8N9OSPIY5OVP5VV5YT5HDE7sEUpKqYTS
X-Gm-Message-State: AOJu0YyfhfB9yRO/1D4w8uTVNtMllc44dQJJlP5H2m2qpaqgCEVodqmN
	gtgX5U8NgWAJJvjKuE6oeY9TeZyGylYJS2ceZ46SWI4cNQYmsh/MZUv9MDxFGzDzXKXXbxQwiVS
	eDDXztifo5uG8l5JBdshPvEI9ptM=
X-Google-Smtp-Source: AGHT+IHOHXog42vr+I7MDeTyCk8WjP6gfHf+e4IRkaoRu1s9eyN6g0tEYQ2xueDbxkTh1EhzmCzzOPoMBWDzZBLsyVg=
X-Received: by 2002:a5d:56d0:0:b0:367:40b6:b90b with SMTP id
 ffacd0b85a97d-37186bf4874mr53779f8f.10.1723650818010; Wed, 14 Aug 2024
 08:53:38 -0700 (PDT)
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
 <CAPVz0n0ibQq58R6Z8+wHZYPDmN8as_F4DCeuLexHXsxO=+_bug@mail.gmail.com> <FR3P281MB17572990CEACA9BB03CAD84CCE872@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB17572990CEACA9BB03CAD84CCE872@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 14 Aug 2024 18:53:26 +0300
Message-ID: <CAPVz0n2jBQEpZEzT3NvLZzVaiLkmTmvSbTWznsGLJCqoKuZYhQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 14 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 17:3=
9 Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello,
>
> I've sent the patch on the mailing list implementing the fix.
>
> Svyatoslav,
> can you test it and check that it is working correctly for your device?
>

Yes, sure. I have tested on P895 and asked my friend to test P880
which is similar device and it had same issue. Both work fine now.
Thanks!

> Thanks,
> JB
>
> ________________________________________
> From: Svyatoslav Ryhel <clamor95@gmail.com>
> Sent: Tuesday, August 13, 2024 18:09
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
> =D0=B2=D1=82, 13 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 19=
:06 Jean-Baptiste Maneyrol
> <Jean-Baptiste.Maneyrol@tdk.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hello,
> >
> > I was able to test the latest code with an old MPU-9150 (MPU-6050 + AKM=
 mag inside a single package), and everything is working well.
> >
> > We can suspect that some MPU-6050 chips have perhaps an issue when read=
ing interrupt status register. Explaining perhaps while the old implementat=
ion wasn't reading the interrupt status register before.
> >
> > 1 solution would be to delete this interrupt status register read for M=
PU-6050/MPU-9150 since WoM feature is not available on these chips. We can =
go back to original behavior of skipping interrupt status register read sin=
ce data ready interrupt is the only interrupt source for these chips.
> >
> > Would that be an acceptable fix for you?
> >
>
> Yes, sure. Thank you for response and fix.
>
> Best regards,
> Svyatoslav R.
>
> > Thanks for your response,
> > JB
> >
> > ________________________________________
> > From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > Sent: Wednesday, August 7, 2024 18:18
> > To: Svyatoslav Ryhel <clamor95@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; INV Git Commit <INV.git-commit=
@tdk.com>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <li=
nux-iio@vger.kernel.org>
> > Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt ha=
ndler for WoM events
> >
> > This Message Is From an External Sender
> > This message came from outside your organization.
> >
> > Thanks for the response.
> >
> > Are you able to modify the driver to print the whoami value? Otherwise,=
 you can also use the debug feature of iio to read manually the whoami regi=
ster if you know how to do it.
> >
> > Are you seeing some sensor data coming or nothing?
> >
> > Are you seeing the error when turning a sensor on, or are sensors turne=
d on automatically by the device?
> >
> > If you can explain the test case it would help to investigate.
> >
> > Thanks a lot,
> > JB
> >
> > ________________________________________
> > From: Svyatoslav Ryhel <clamor95@gmail.com>
> > Sent: Wednesday, August 7, 2024 18:03
> > To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; INV Git Commit <INV.git-commit=
@tdk.com>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <li=
nux-iio@vger.kernel.org>
> > Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt ha=
ndler for WoM events
> >
> > This Message Is From an Untrusted Sender
> > You have not previously corresponded with this sender.
> >
> > =D1=81=D1=80, 7 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 1=
8:48 Jean-Baptiste Maneyrol
> > <Jean-Baptiste.Maneyrol@tdk.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hello Jonathan and Svyatoslav,
> > >
> > > this is really strange because it is an I2C transaction error happeni=
ng.
> > > The chip is obviously on, otherwise it would not be able to send inte=
rrupt and have sensors running.
> > >
> > > For investigating the issue, we need to know what is the chip used in=
side this device. The driver is supporting a lot of chips that may have som=
e specific behaviors.
> > >
> > > Svyatoslav,
> > > can you give us the name of the chip in this LG device or the whoami =
value read by the driver?
> > >
> >
> > According to available schematics it is named as MPU-6050
> > Accelerometer embedded Gyro Sensor 4X4 QFN R/TP 24P One Chip Solution
> > INVENSENSE.
> >
> > > Thanks a lot for your help.
> > > JB
> > >
> > > ________________________________________
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Tuesday, August 6, 2024 18:53
> > > To: Svyatoslav Ryhel <clamor95@gmail.com>
> > > Cc: INV Git Commit <INV.git-commit@tdk.com>; lars@metafoo.de <lars@me=
tafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jean-Bapt=
iste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > > Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt =
handler for WoM events
> > >
> > > This Message Is From an External Sender
> > > This message came from outside your organization.
> > >
> > > On Tue, 23 Jul 2024 11:25:03 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > 11.03.24 6:05 =D0=BF=D0=BF, inv.git-commit@tdk.com:
> > > > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > > > >
> > > > > Add new interrupt handler for generating WoM event from int statu=
s register
> > > > > bits. Launch from interrupt the trigger poll function for data bu=
ffer.
> > > > >
> > > > > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk=
.com>
> > >
> > > Jean-Baptiste,
> > >
> > > Please take a look at this report.  I'd rather not revert the series
> > > if we can figure out what is wrong and get a fix on top in reasonably
> > > quickly.
> > >
> > > I'd guess a power problem so we are getting interrupts when device is=
 powered down?
> > > Hence the reads fail.
> > >
> > > Jonathan
> > >
> > > > > ---
> > > > >   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
> > > > >   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ---
> > > > >   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 69 ++++++++++++=
+++++--
> > > > >   3 files changed, 66 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/=
iio/imu/inv_mpu6050/inv_mpu_iio.h
> > > > > index d5b0465d1f74..ca5f7d45a6d4 100644
> > > > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > > > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > > > > @@ -185,6 +185,7 @@ struct inv_mpu6050_hw {
> > > > >    *  @magn_orient:       magnetometer sensor chip orientation if=
 available.
> > > > >    *  @suspended_sensors:   sensors mask of sensors turned off fo=
r suspend
> > > > >    *  @data:                read buffer used for bulk reads.
> > > > > + *  @it_timestamp: interrupt timestamp.
> > > > >    */
> > > > >   struct inv_mpu6050_state {
> > > > >     struct mutex lock;
> > > > > @@ -210,6 +211,7 @@ struct inv_mpu6050_state {
> > > > >     unsigned int suspended_sensors;
> > > > >     bool level_shifter;
> > > > >     u8 *data;
> > > > > +   s64 it_timestamp;
> > > > >   };
> > > > >
> > > > >   /*register and associated bit definition*/
> > > > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers=
/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > > > > index 13da6f523ca2..e282378ee2ca 100644
> > > > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > > > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > > > > @@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, vo=
id *p)
> > > > >     u32 fifo_period;
> > > > >     s64 timestamp;
> > > > >     u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
> > > > > -   int int_status;
> > > > >     size_t i, nb;
> > > > >
> > > > >     mutex_lock(&st->lock);
> > > > >
> > > > > -   /* ack interrupt and check status */
> > > > > -   result =3D regmap_read(st->map, st->reg->int_status, &int_sta=
tus);
> > > > > -   if (result) {
> > > > > -           dev_err(regmap_get_device(st->map),
> > > > > -                   "failed to ack interrupt\n");
> > > > > -           goto flush_fifo;
> > > > > -   }
> > > > > -   if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
> > > > > -           goto end_session;
> > > > > -
> > > > >     if (!(st->chip_config.accl_fifo_enable |
> > > > >             st->chip_config.gyro_fifo_enable |
> > > > >             st->chip_config.magn_fifo_enable))
> > > > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/driv=
ers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > > > index ec2398a87f45..2514966f6495 100644
> > > > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > > > > @@ -6,6 +6,7 @@
> > > > >   #include <linux/pm_runtime.h>
> > > > >
> > > > >   #include <linux/iio/common/inv_sensors_timestamp.h>
> > > > > +#include <linux/iio/events.h>
> > > > >
> > > > >   #include "inv_mpu_iio.h"
> > > > >
> > > > > @@ -223,6 +224,65 @@ static const struct iio_trigger_ops inv_mpu_=
trigger_ops =3D {
> > > > >     .set_trigger_state =3D &inv_mpu_data_rdy_trigger_set_state,
> > > > >   };
> > > > >
> > > > > +static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void=
 *p)
> > > > > +{
> > > > > +   struct iio_dev *indio_dev =3D p;
> > > > > +   struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > > > > +
> > > > > +   st->it_timestamp =3D iio_get_time_ns(indio_dev);
> > > > > +
> > > > > +   return IRQ_WAKE_THREAD;
> > > > > +}
> > > > > +
> > > > > +static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p=
)
> > > > > +{
> > > > > +   struct iio_dev *indio_dev =3D p;
> > > > > +   struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > > > > +   unsigned int int_status, wom_bits;
> > > > > +   u64 ev_code;
> > > > > +   int result;
> > > > > +
> > > > > +   switch (st->chip_type) {
> > > > > +   case INV_MPU6050:
> > > > > +   case INV_MPU6500:
> > > > > +   case INV_MPU6515:
> > > > > +   case INV_MPU6880:
> > > > > +   case INV_MPU6000:
> > > > > +   case INV_MPU9150:
> > > > > +   case INV_MPU9250:
> > > > > +   case INV_MPU9255:
> > > > > +           wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> > > > > +           break;
> > > > > +   default:
> > > > > +           wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> > > > > +           break;
> > > > > +   }
> > > > > +
> > > > > +   scoped_guard(mutex, &st->lock) {
> > > > > +           /* ack interrupt and check status */
> > > > > +           result =3D regmap_read(st->map, st->reg->int_status, =
&int_status);
> > > > > +           if (result) {
> > > > > +                   dev_err(regmap_get_device(st->map), "failed t=
o ack interrupt\n");
> > > > > +                   return IRQ_HANDLED;
> > > > > +           }
> > > > > +
> > > > > +           /* handle WoM event */
> > > > > +           if (st->chip_config.wom_en && (int_status & wom_bits)=
) {
> > > > > +                   ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, =
IIO_MOD_X_OR_Y_OR_Z,
> > > > > +                                                IIO_EV_TYPE_ROC,=
 IIO_EV_DIR_RISING);
> > > > > +                   iio_push_event(indio_dev, ev_code, st->it_tim=
estamp);
> > > > > +           }
> > > > > +   }
> > > > > +
> > > > > +   /* handle raw data interrupt */
> > > > > +   if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
> > > > > +           indio_dev->pollfunc->timestamp =3D st->it_timestamp;
> > > > > +           iio_trigger_poll_nested(st->trig);
> > > > > +   }
> > > > > +
> > > > > +   return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > >   int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int ir=
q_type)
> > > > >   {
> > > > >     int ret;
> > > > > @@ -235,11 +295,10 @@ int inv_mpu6050_probe_trigger(struct iio_de=
v *indio_dev, int irq_type)
> > > > >     if (!st->trig)
> > > > >             return -ENOMEM;
> > > > >
> > > > > -   ret =3D devm_request_irq(&indio_dev->dev, st->irq,
> > > > > -                          &iio_trigger_generic_data_rdy_poll,
> > > > > -                          irq_type,
> > > > > -                          "inv_mpu",
> > > > > -                          st->trig);
> > > > > +   ret =3D devm_request_threaded_irq(&indio_dev->dev, st->irq,
> > > > > +                                   &inv_mpu6050_interrupt_timest=
amp,
> > > > > +                                   &inv_mpu6050_interrupt_handle=
,
> > > > > +                                   irq_type, "inv_mpu", indio_de=
v);
> > > > >     if (ret)
> > > > >             return ret;
> > > > >
> > > >
> > > > Greetings!
> > > >
> > > > After this patch was applied to Linux kernel I faced a regression o=
n my
> > > > devices LG P895/P880.
> > > >
> > > > Dmesg is flooded with
> > > >
> > > > [ 50.035018] inv-mpu6050-i2c 0-0068: failed to ack interrupt -121
> > > >
> > > > and mpu6050 used on this device refuses to work. It did not occur b=
efore
> > > > WoM patches were
> > > >
> > > > applied and reverting patches restores normal work of mpu6050.
> > > >
> > > >
> > > > Best regards,
> > > >
> > > > Svyatoslav R.
> > > >
> > >

