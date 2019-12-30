Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95F712D1F7
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2019 17:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfL3Q0z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Dec 2019 11:26:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfL3Q0z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Dec 2019 11:26:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D482320718;
        Mon, 30 Dec 2019 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577723212;
        bh=rMhEg8rtIqQAQ0vpgYRa4UT6NTJFbHh58DgFvrAzNqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ae9/7IK90S62ADev1ojnFmssSJp7r0QJ0DJYe/yyghWW/e5P5cg2odk9rz8tSeBs4
         IQo6cn0Rr+yESMF6glH+3tYqF40Px8BnpnkDSJHuVk9DhW4EwgIuqDoMMQXyfSJehZ
         Bt20McbfNRoOZRJZnx+LrHSsXm4hfXI62tNJTkoE=
Date:   Mon, 30 Dec 2019 16:26:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data
 support
Message-ID: <20191230162648.505bb0d9@archlinux>
In-Reply-To: <MN2PR12MB3373B2617FAD6FB24EAC0787C4290@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191118103406.9353-1-jmaneyrol@invensense.com>
        <20191118103406.9353-2-jmaneyrol@invensense.com>
        <20191123162256.386c085a@archlinux>
        <MN2PR12MB33739BF5EA2C9E402EDF4684C4430@MN2PR12MB3373.namprd12.prod.outlook.com>
        <MN2PR12MB3373B2617FAD6FB24EAC0787C4290@MN2PR12MB3373.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Dec 2019 09:17:05 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> any news about my 2nd patch ("[PATCH 2/2] iio: imu: inv_mpu6050: add fifo=
 temperature data support") now that the 1st is included inside fixes-togre=
g branch?
>=20
> The 1st one is still not yet available inside testing branch.
> Should I resend it now or wait for testing to be in sync with fixes-togre=
g?
I have it flagged in my email so in theory at least I will grab it
without a resend.  I think I'll do a pull request for togreg later this
week and after that I should be fine applying this.

Things got a bit slowed down for the holidays :)  Too easy to put
things off to tomorrow!

Jonathan

>=20
> Thanks,
> JB
>=20
>=20
>=20
>=20
>=20
>=20
> From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
>=20
> Sent: Monday, December 2, 2019 14:50
>=20
> To: Jonathan Cameron <jic23@kernel.org>
>=20
> Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data=
 support
>=20
> =C2=A0
>=20
>=20
> Hi Jonathan,
>=20
>=20
>=20
> just a reminder for not forgetting this patch now that the first is in fi=
xes-togreg branch.
>=20
>=20
>=20
> Thanks,
>=20
> JB
>=20
>=20
>=20
>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
>=20
>=20
>=20
> Sent: Saturday, November 23, 2019 17:22
>=20
>=20
>=20
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
>=20
>=20
>=20
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
>=20
>=20
>=20
> Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data=
 support
>=20
>=20
>=20
> =C2=A0
>=20
>=20
>=20
>=20
>=20
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> On Mon, 18 Nov 2019 11:34:06 +0100
>=20
>=20
>=20
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> > Add support of temperature data in fifo for all chips. =20
>=20
>=20
>=20
> > Enable unification of scan elements for icm20602. =20
>=20
>=20
>=20
> > Add macros for generating scan elements with and without temp. =20
>=20
>=20
>=20
> >  =20
>=20
>=20
>=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> =20
>=20
>=20
>=20
> Looks fine to me. I'll pick up once we've worked out what
>=20
>=20
>=20
> we are doing with patch 1.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Remind me if I seem to have lost it.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Thanks,
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> Jonathan
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> > --- =20
>=20
>=20
>=20
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=C2=A0=C2=A0=C2=A0 | 19=
4 +++++++----------- =20
>=20
>=20
>=20
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 22 +- =20
>=20
>=20
>=20
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 +- =20
>=20
>=20
>=20
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=C2=A0=C2=A0 3 + =
=20
>=20
>=20
>=20
> >=C2=A0 4 files changed, 84 insertions(+), 141 deletions(-) =20
>=20
>=20
>=20
> >  =20
>=20
>=20
>=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c =20
>=20
>=20
>=20
> > index 268240644adf..7c2f6951364d 100644 =20
>=20
>=20
>=20
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =20
>=20
>=20
>=20
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =20
>=20
>=20
>=20
> > @@ -104,6 +104,7 @@ static const struct inv_mpu6050_chip_config chip_co=
nfig_6050 =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .divider =3D INV_MPU6050_FIFO=
_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gyro_fifo_enable =3D false, =
=20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .accl_fifo_enable =3D false, =
=20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .temp_fifo_enable =3D false, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .magn_fifo_enable =3D false, =
=20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .accl_fs =3D INV_MPU6050_FS_0=
2G, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .user_ctrl =3D 0, =20
>=20
>=20
>=20
> > @@ -856,19 +857,27 @@ static const struct iio_chan_spec_ext_info inv_ex=
t_info[] =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .ext_info =3D inv_ext_info,=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > +#define INV_MPU6050_TEMP_CHAN(_index)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .type =3D IIO_TEMP,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET)=C2=A0=C2=A0=C2=A0=C2=
=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE),=C2=A0=C2=A0=C2=A0=C2=
=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_index =3D _index,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_type =3D {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sign =3D 's',=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .realbits =3D 16,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .storagebits =3D 16,=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 0,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D IIO_BE,=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> >=C2=A0 static const struct iio_chan_spec inv_mpu_channels[] =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_M=
PU6050_SCAN_TIMESTAMP), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 /* =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that temperature should only be =
via polled reading only, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not the final scan elements output. =
=20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 { =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .type =3D IIO_TEMP, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_index =3D -1, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),=
 =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL=
, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL=
, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL=
, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z), =20
>=20
>=20
>=20
> > @@ -878,22 +887,31 @@ static const struct iio_chan_spec inv_mpu_channel=
s[] =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, I=
IO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z), =20
>=20
>=20
>=20
> >=C2=A0 }; =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > +#define INV_MPU6050_SCAN_MASK_3AXIS_ACCEL=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_MPU6050_SCAN_ACCL_X)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)) =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> > +#define INV_MPU6050_SCAN_MASK_3AXIS_GYRO=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_MPU6050_SCAN_GYRO_X)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z)) =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> > +#define INV_MPU6050_SCAN_MASK_TEMP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_MPU6050_SCAN_TEMP)) =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> > +/* generate scan mask and a duplicate with temperature enabled */ =20
>=20
>=20
>=20
> > +#define INV_MPU6050_SCAN_MASK_DUP_TEMP(_mask)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 (_mask),=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 (_mask) | INV_MPU6050_SCAN_MASK_TEMP =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> >=C2=A0 static const unsigned long inv_mpu_scan_masks[] =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis accel */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SC=
AN_MASK_3AXIS_ACCEL), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis gyro */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_GYRO_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SC=
AN_MASK_3AXIS_GYRO), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis accel + gyro */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SC=
AN_MASK_3AXIS_ACCEL =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU6050_SCAN_MASK=
_3AXIS_GYRO), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, =20
>=20
>=20
>=20
> >=C2=A0 }; =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > @@ -917,17 +935,9 @@ static const unsigned long inv_mpu_scan_masks[] =
=3D { =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> >=C2=A0 static const struct iio_chan_spec inv_mpu9150_channels[] =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_M=
PU9X50_SCAN_TIMESTAMP), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 /* =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that temperature should only be =
via polled reading only, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not the final scan elements output. =
=20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 { =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .type =3D IIO_TEMP, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_index =3D -1, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),=
 =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL=
, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL=
, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL=
, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z), =20
>=20
>=20
>=20
> > @@ -944,17 +954,9 @@ static const struct iio_chan_spec inv_mpu9150_chan=
nels[] =3D { =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> >=C2=A0 static const struct iio_chan_spec inv_mpu9250_channels[] =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_M=
PU9X50_SCAN_TIMESTAMP), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 /* =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that temperature should only be =
via polled reading only, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not the final scan elements output. =
=20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 { =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .type =3D IIO_TEMP, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_index =3D -1, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),=
 =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL=
, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL=
, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL=
, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z), =20
>=20
>=20
>=20
> > @@ -969,98 +971,42 @@ static const struct iio_chan_spec inv_mpu9250_cha=
nnels[] =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU9X50_MAGN_CHAN(IIO_MOD=
_Z, 16, INV_MPU9X50_SCAN_MAGN_Z), =20
>=20
>=20
>=20
> >=C2=A0 }; =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > +#define INV_MPU9X50_SCAN_MASK_3AXIS_MAGN=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_MPU9X50_SCAN_MAGN_X)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z)) =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> >=C2=A0 static const unsigned long inv_mpu9x50_scan_masks[] =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis accel */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SC=
AN_MASK_3AXIS_ACCEL), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis gyro */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_GYRO_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SC=
AN_MASK_3AXIS_GYRO), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis magn */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU9X50_SCAN_MAGN_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU9X50_SC=
AN_MASK_3AXIS_MAGN), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis accel + gyro */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SC=
AN_MASK_3AXIS_ACCEL =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU6050_SCAN_MASK=
_3AXIS_GYRO), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis accel + magn */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SC=
AN_MASK_3AXIS_ACCEL =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU9X50_SCAN_MASK=
_3AXIS_MAGN), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis gyro + magn */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_GYRO_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SC=
AN_MASK_3AXIS_GYRO =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU9X50_SCAN_MASK=
_3AXIS_MAGN), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 9-axis accel + gyro + magn=
 */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SC=
AN_MASK_3AXIS_ACCEL =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU6050_SCAN_MASK=
_3AXIS_GYRO =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU9X50_SCAN_MASK=
_3AXIS_MAGN), =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, =20
>=20
>=20
>=20
> >=C2=A0 }; =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > -static const struct iio_chan_spec inv_icm20602_channels[] =3D { =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIM=
ESTAMP), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 { =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .type =3D IIO_TEMP, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_index =3D INV_ICM20602_SCAN_TEMP, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_type =3D { =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .sign =3D 's', =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .realbits =3D 16, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .storagebits =3D 16, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 0, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D IIO_BE, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
>=20
>=20
> > - =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV=
_ICM20602_SCAN_GYRO_X), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV=
_ICM20602_SCAN_GYRO_Y), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV=
_ICM20602_SCAN_GYRO_Z), =20
>=20
>=20
>=20
> > - =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_IC=
M20602_SCAN_ACCL_Y), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_IC=
M20602_SCAN_ACCL_X), =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_IC=
M20602_SCAN_ACCL_Z), =20
>=20
>=20
>=20
> > -}; =20
>=20
>=20
>=20
> > - =20
>=20
>=20
>=20
> >=C2=A0 static const unsigned long inv_icm20602_scan_masks[] =3D { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis accel + temp (manda=
tory) */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM20602_SCAN_ACCL_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_TEMP), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU60=
50_SCAN_MASK_TEMP, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis gyro + temp (mandat=
ory) */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM20602_SCAN_GYRO_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_TEMP), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU605=
0_SCAN_MASK_TEMP, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis accel + gyro + temp=
 (mandatory) */ =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM20602_SCAN_ACCL_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_GYRO_X) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | BIT(INV_ICM20602_SCAN_TEMP), =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU60=
50_SCAN_MASK_3AXIS_GYRO =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU6050_SCAN_MASK=
_TEMP, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, =20
>=20
>=20
>=20
> >=C2=A0 }; =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > @@ -1363,8 +1309,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int=
 irq, const char *name, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D inv_mpu9x50_scan_mas=
ks; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INV_ICM20602: =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 indio_dev->channels =3D inv_icm20602_channels; =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_icm20602_channels); =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 indio_dev->channels =3D inv_mpu_channels; =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu_channels); =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D inv_icm20602_scan_ma=
sks; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default: =20
>=20
>=20
>=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h =20
>=20
>=20
>=20
> > index b096e010d4ee..6158fca7f70e 100644 =20
>=20
>=20
>=20
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h =20
>=20
>=20
>=20
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h =20
>=20
>=20
>=20
> > @@ -86,6 +86,7 @@ enum inv_devices { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0 *=C2=A0 @accl_fs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accel full scale range. =20
>=20
>=20
>=20
> >=C2=A0=C2=A0 *=C2=A0 @accl_fifo_enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 enable accel data output =20
>=20
>=20
>=20
> >=C2=A0=C2=A0 *=C2=A0 @gyro_fifo_enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 enable gyro data output =20
>=20
>=20
>=20
> > + *=C2=A0 @temp_fifo_enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable=
 temp data output =20
>=20
>=20
>=20
> >=C2=A0=C2=A0 *=C2=A0 @magn_fifo_enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 enable magn data output =20
>=20
>=20
>=20
> >=C2=A0=C2=A0 *=C2=A0 @divider:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip sample rate divider (=
sample rate divider - 1) =20
>=20
>=20
>=20
> >=C2=A0=C2=A0 */ =20
>=20
>=20
>=20
> > @@ -95,6 +96,7 @@ struct inv_mpu6050_chip_config { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int accl_fs:2; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int accl_fifo_enable=
:1; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int gyro_fifo_enable=
:1; =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int temp_fifo_enable:1; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int magn_fifo_enable=
:1; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 divider; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 user_ctrl; =20
>=20
>=20
>=20
> > @@ -184,6 +186,7 @@ struct inv_mpu6050_state { =20
>=20
>=20
>=20
> >=C2=A0 #define INV_MPU6050_BIT_SLAVE_2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x04 =20
>=20
>=20
>=20
> >=C2=A0 #define INV_MPU6050_BIT_ACCEL_OUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x08 =20
>=20
>=20
>=20
> >=C2=A0 #define INV_MPU6050_BITS_GYRO_OUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x70 =20
>=20
>=20
>=20
> > +#define INV_MPU6050_BIT_TEMP_OUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x80 =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> >=C2=A0 #define INV_MPU6050_REG_I2C_MST_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x24 =20
>=20
>=20
>=20
> >=C2=A0 #define INV_MPU6050_BITS_I2C_MST_CLK_400KHZ 0x0D =20
>=20
>=20
>=20
> > @@ -268,8 +271,8 @@ struct inv_mpu6050_state { =20
>=20
>=20
>=20
> >=C2=A0 /* MPU9X50 9-axis magnetometer */ =20
>=20
>=20
>=20
> >=C2=A0 #define INV_MPU9X50_BYTES_MAGN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7 =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > -/* ICM20602 FIFO samples include temperature readings */ =20
>=20
>=20
>=20
> > -#define INV_ICM20602_BYTES_PER_TEMP_SENSOR=C2=A0=C2=A0 2 =20
>=20
>=20
>=20
> > +/* FIFO temperature sample size */ =20
>=20
>=20
>=20
> > +#define INV_MPU6050_BYTES_PER_TEMP_SENSOR=C2=A0=C2=A0 2 =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> >=C2=A0 /* mpu6500 registers */ =20
>=20
>=20
>=20
> >=C2=A0 #define INV_MPU6500_REG_ACCEL_CONFIG_2=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1D =20
>=20
>=20
>=20
> > @@ -298,7 +301,7 @@ struct inv_mpu6050_state { =20
>=20
>=20
>=20
> >=C2=A0 #define INV_ICM20608_TEMP_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 8170 =20
>=20
>=20
>=20
> >=C2=A0 #define INV_ICM20608_TEMP_SCALE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 3059976 =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > -/* 6 + 6 + 7 (for MPU9x50) =3D 19 round up to 24 and plus 8 */ =20
>=20
>=20
>=20
> > +/* 6 + 6 + 2 + 7 (for MPU9x50) =3D 21 round up to 24 and plus 8 */ =20
>=20
>=20
>=20
> >=C2=A0 #define INV_MPU6050_OUTPUT_DATA_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 32 =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> >=C2=A0 #define INV_MPU6050_REG_INT_PIN_CFG=C2=A0 0x37 =20
>=20
>=20
>=20
> > @@ -344,6 +347,7 @@ enum inv_mpu6050_scan { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_ACCL_X, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_ACCL_Y, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_ACCL_Z, =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_TEMP, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_GYRO_X, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_GYRO_Y, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_GYRO_Z, =20
>=20
>=20
>=20
> > @@ -355,18 +359,6 @@ enum inv_mpu6050_scan { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU9X50_SCAN_TIMESTAMP, =
=20
>=20
>=20
>=20
> >=C2=A0 }; =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > -/* scan element definition for ICM20602, which includes temperature */=
 =20
>=20
>=20
>=20
> > -enum inv_icm20602_scan { =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_ACCL_X, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_ACCL_Y, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_ACCL_Z, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_TEMP, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_X, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_Y, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_Z, =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_TIMESTAMP, =20
>=20
>=20
>=20
> > -}; =20
>=20
>=20
>=20
> > - =20
>=20
>=20
>=20
> >=C2=A0 enum inv_mpu6050_filter_e { =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_FILTER_256HZ_NOLP=
F2 =3D 0, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_FILTER_188HZ, =20
>=20
>=20
>=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_ring.c =20
>=20
>=20
>=20
> > index 10d16ec5104b..3755577dc449 100644 =20
>=20
>=20
>=20
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c =20
>=20
>=20
>=20
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c =20
>=20
>=20
>=20
> > @@ -142,6 +142,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev) =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 d |=3D INV_MPU6050_BITS_GYRO_OUT; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.accl_fifo=
_enable) =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 d |=3D INV_MPU6050_BIT_ACCEL_OUT; =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.temp_fifo_enable) =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 d |=3D INV_MPU6050_BIT_TEMP_OUT; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.magn_fifo=
_enable) =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 d |=3D INV_MPU6050_BIT_SLAVE_0; =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D regmap_write(st->m=
ap, st->reg->fifo_en, d); =20
>=20
>=20
>=20
> > @@ -200,8 +202,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
 =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.gyro_fifo=
_enable) =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bytes_per_datum +=3D INV_MPU6050_BYTES_PER_3AXIS_SENSOR;=
 =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_type =3D=3D INV_ICM20602) =20
>=20
>=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bytes_per_datum +=3D INV_ICM20602_BYTES_PER_TEMP_SENSOR; =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.temp_fifo_enable) =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bytes_per_datum +=3D INV_MPU6050_BYTES_PER_TEMP_SENSOR; =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.magn_fifo=
_enable) =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bytes_per_datum +=3D INV_MPU9X50_BYTES_MAGN; =20
>=20
>=20
>=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_trigger.c =20
>=20
>=20
>=20
> > index a9c75bc62f18..5199fe790c30 100644 =20
>=20
>=20
>=20
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c =20
>=20
>=20
>=20
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c =20
>=20
>=20
>=20
> > @@ -24,6 +24,9 @@ static void inv_scan_query_mpu6050(struct iio_dev *in=
dio_dev) =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
dio_dev->active_scan_mask) || =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 test_bit(INV_MPU6050_SCAN_ACCL_Z, =20
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
dio_dev->active_scan_mask); =20
>=20
>=20
>=20
> > + =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_config.temp_fifo_enable =3D =20
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 test_bit(INV_MPU6050_SCAN_TEMP, indio_dev->active_scan_mask); =20
>=20
>=20
>=20
> >=C2=A0 } =20
>=20
>=20
>=20
> >=C2=A0  =20
>=20
>=20
>=20
> >=C2=A0 static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev) =20
>=20
>=20
>=20
>=20
>=20
>=20
>=20

