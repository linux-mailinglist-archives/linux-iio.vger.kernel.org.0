Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1D16819D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 16:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBUP3n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 10:29:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgBUP3n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 10:29:43 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7186208E4;
        Fri, 21 Feb 2020 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582298981;
        bh=r66+jzAvdq0t25YQvqPtCWG37L3y2l35pmPbQFiKBXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=schKAKAnhSOoTzWV0hXK59PqI8K/hiRPFOqBK9HfHivcYAnSUlEV9bwTX5Uid4LJn
         PmWap3MEm7ScUCL74o2iHtFpfac61cGCh2ElrUWeZW0j0tQ1T1wAh4gsRBx6NrEp52
         w1iaJ76J3DERICW3nalk9dCm7xib8rBgHLKpO/68=
Date:   Fri, 21 Feb 2020 15:29:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 09/13] iio: imu: inv_mpu6050: fix data polling
 interface
Message-ID: <20200221152931.161a0217@archlinux>
In-Reply-To: <CH2PR12MB418170EDD66763FDF8A2DB65C4120@CH2PR12MB4181.namprd12.prod.outlook.com>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
        <20200219143958.3548-10-jmaneyrol@invensense.com>
        <20200221113450.379fe556@archlinux>
        <CH2PR12MB418170EDD66763FDF8A2DB65C4120@CH2PR12MB4181.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 21 Feb 2020 14:03:39 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> this is not something we want to backport. Mainly because it is heavly de=
pendant on the rework of the power and sensor engines.
>=20
> And polling interface without pm_runtime autosuspend is not really releve=
nt.

Fair enough. I'll add a note to try and prevent it getting automatically
picked up as a fix.

Thanks,

Jonathan

>=20
> Thanks,
> JB
>=20
>=20
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> o=
n behalf of Jonathan Cameron <jic23@kernel.org>
>=20
> Sent: Friday, February 21, 2020 12:34
>=20
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
>=20
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
>=20
> Subject: Re: [PATCH v2 09/13] iio: imu: inv_mpu6050: fix data polling int=
erface
>=20
> =C2=A0
>=20
>=20
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
>=20
>=20
> On Wed, 19 Feb 2020 15:39:54 +0100
>=20
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>=20
>=20
>=20
> > When reading data with the polling interface, we need to wait =20
>=20
> > at 1 sampling period to have a sample. =20
>=20
> > For gyroscope and magnetometer, we need to wait for 2 periods =20
>=20
> > before having a correct sample. =20
>=20
> >  =20
>=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> =20
>=20
>=20
>=20
> I should have raised this before, but is this something we might want to
>=20
> backport? I don't really want this whole cleanup series getting backporte=
d,
>=20
> so is there a more minimal change for older kernels? (probably just sleep=
 too
>=20
> long in all cases!)
>=20
>=20
>=20
> Applied,
>=20
>=20
>=20
> Jonathan
>=20
>=20
>=20
> > --- =20
>=20
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 36 +++++++++++++++++=
+++-- =20
>=20
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 21 ------------- =20
>=20
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h |=C2=A0 3 ++ =20
>=20
> >=C2=A0 3 files changed, 37 insertions(+), 23 deletions(-) =20
>=20
> >  =20
>=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c =20
>=20
> > index a51efc4c941b..aeee39696d3a 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =20
>=20
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =20
>=20
> > @@ -563,9 +563,14 @@ static int inv_mpu6050_read_channel_data(struct ii=
o_dev *indio_dev, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int *val) =20
>=20
> >=C2=A0 { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_mpu6050_state *st =
=3D iio_priv(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int freq_hz, period_us, min_sleep_us=
, max_sleep_us; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int result; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> >=C2=A0  =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* compute sample period */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 freq_hz =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(=
st->chip_config.divider); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 period_us =3D 1000000 / freq_hz; =20
>=20
> > + =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D inv_mpu6050_set_po=
wer_itg(st, true); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (result) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return result; =20
>=20
> > @@ -576,6 +581,10 @@ static int inv_mpu6050_read_channel_data(struct ii=
o_dev *indio_dev, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SENSOR_GYRO); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (result) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err=
or_power_off; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* need to wait 2 periods to have first valid sample */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 min_sleep_us =3D 2 * period_us; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 max_sleep_us =3D 2 * (period_us + period_us / 2); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 usleep_range(min_sleep_us, max_sleep_us); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D inv_mpu6050_sensor_show(st, st->reg->raw_gyro, =
=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chan->channel2, val); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 result =3D inv_mpu6050_switch_engine(st, false, =20
>=20
> > @@ -588,6 +597,10 @@ static int inv_mpu6050_read_channel_data(struct ii=
o_dev *indio_dev, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SENSOR_ACCL); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (result) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err=
or_power_off; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* wait 1 period for first sample availability */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 min_sleep_us =3D period_us; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 max_sleep_us =3D period_us + period_us / 2; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 usleep_range(min_sleep_us, max_sleep_us); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D inv_mpu6050_sensor_show(st, st->reg->raw_accl, =
=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chan->channel2, val); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 result =3D inv_mpu6050_switch_engine(st, false, =20
>=20
> > @@ -600,8 +613,10 @@ static int inv_mpu6050_read_channel_data(struct ii=
o_dev *indio_dev, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SENSOR_TEMP); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (result) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err=
or_power_off; =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* wait for stablization */ =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msleep(INV_MPU6050_TEMP_UP_TIME); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* wait 1 period for first sample availability */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 min_sleep_us =3D period_us; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 max_sleep_us =3D period_us + period_us / 2; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 usleep_range(min_sleep_us, max_sleep_us); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D inv_mpu6050_sensor_show(st, st->reg->temperature=
, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_MOD_X, val); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 result =3D inv_mpu6050_switch_engine(st, false, =20
>=20
> > @@ -610,7 +625,24 @@ static int inv_mpu6050_read_channel_data(struct ii=
o_dev *indio_dev, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err=
or_power_off; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MAGN: =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 result =3D inv_mpu6050_switch_engine(st, true, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SENSOR_MAGN); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (result) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error_power_off; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* frequency is limited for magnetometer */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq_hz =3D INV_MPU_MAG=
N_FREQ_HZ_MAX; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 period_us =3D 1000000 /=
 freq_hz; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* need to wait 2 periods to have first valid sample */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 min_sleep_us =3D 2 * period_us; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 max_sleep_us =3D 2 * (period_us + period_us / 2); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 usleep_range(min_sleep_us, max_sleep_us); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D inv_mpu_magn_read(st, chan->channel2, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 result =3D inv_mpu6050_switch_engine(st, false, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SENSOR_MAGN); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (result) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error_power_off; =
=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default: =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL; =20
>=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_magn.c =20
>=20
> > index 3f402fa56d95..f282e9cc34c5 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c =20
>=20
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c =20
>=20
> > @@ -44,9 +44,6 @@ =20
>=20
> >=C2=A0 #define INV_MPU_MAGN_REG_ASAY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x11 =20
>=20
> >=C2=A0 #define INV_MPU_MAGN_REG_ASAZ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x12 =20
>=20
> >=C2=A0  =20
>=20
> > -/* Magnetometer maximum frequency */ =20
>=20
> > -#define INV_MPU_MAGN_FREQ_HZ_MAX=C2=A0=C2=A0=C2=A0=C2=A0 50 =20
>=20
> > - =20
>=20
> >=C2=A0 static bool inv_magn_supported(const struct inv_mpu6050_state *st=
) =20
>=20
> >=C2=A0 { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (st->chip_type) { =20
>=20
> > @@ -321,7 +318,6 @@ int inv_mpu_magn_read(struct inv_mpu6050_state *st,=
 int axis, int *val) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int status; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be16 data; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t addr; =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int freq_hz, period_ms; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* quit if chip is not suppor=
ted */ =20
>=20
> > @@ -344,23 +340,6 @@ int inv_mpu_magn_read(struct inv_mpu6050_state *st=
, int axis, int *val) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr +=3D INV_MPU6050_REG_EXT=
_SENS_DATA; =20
>=20
> >=C2=A0  =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 /* compute period depending on current sampli=
ng rate */ =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 freq_hz =3D INV_MPU6050_DIVIDER_TO_FIFO_RATE(=
st->chip_config.divider); =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 if (freq_hz > INV_MPU_MAGN_FREQ_HZ_MAX) =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 freq_hz =3D INV_MPU_MAGN_FREQ_HZ_MAX; =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 period_ms =3D 1000 / freq_hz; =20
>=20
> > - =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_mpu6050_switch_engine(st, true, I=
NV_MPU6050_SENSOR_MAGN); =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > - =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 /* need to wait 2 periods + half-period margi=
n */ =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 msleep(period_ms * 2 + period_ms / 2); =20
>=20
> > - =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_mpu6050_switch_engine(st, false, =
INV_MPU6050_SENSOR_MAGN); =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > - =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* check i2c status and read =
raw data */ =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(st->map, =
INV_MPU6050_REG_I2C_MST_STATUS, &status); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_magn.h =20
>=20
> > index f7ad50ca6c1b..185c000c697c 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h =20
>=20
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h =20
>=20
> > @@ -10,6 +10,9 @@ =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 #include "inv_mpu_iio.h" =20
>=20
> >=C2=A0  =20
>=20
> > +/* Magnetometer maximum frequency */ =20
>=20
> > +#define INV_MPU_MAGN_FREQ_HZ_MAX=C2=A0=C2=A0=C2=A0=C2=A0 50 =20
>=20
> > + =20
>=20
> >=C2=A0 int inv_mpu_magn_probe(struct inv_mpu6050_state *st); =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 /** =20
>=20
>=20
>=20

