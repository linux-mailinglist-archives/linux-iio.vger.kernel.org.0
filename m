Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F2141726
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 12:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgARLK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 06:10:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbgARLK2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 06:10:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3AA2468B;
        Sat, 18 Jan 2020 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579345825;
        bh=Om87ZlQDjSE7fntT7W3nN3FtR4CL6Xb46u/3G+FTcvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qNvElUXXPVh2Ysdrzegc1Z7WidAPpIY7xb3eNW4qalJj3lLnvbTVIRLHs0q5KtVYy
         yzBbJYxm2JEY3fr99f4QY+Ss5U0FlEiDppCocHl4hUaY0CwiLLd3/r2pS3s7YN8En4
         Su4zH9aoBoJrpHU2QCv5AGqbT8jQhtryZPCBbSZE=
Date:   Sat, 18 Jan 2020 11:10:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data
 support
Message-ID: <20200118111016.52a45eec@archlinux>
In-Reply-To: <MN2PR12MB3373CA90D67E5B17DCE76A8BC4340@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191118103406.9353-1-jmaneyrol@invensense.com>
        <20191118103406.9353-2-jmaneyrol@invensense.com>
        <20191123162256.386c085a@archlinux>
        <MN2PR12MB33739BF5EA2C9E402EDF4684C4430@MN2PR12MB3373.namprd12.prod.outlook.com>
        <MN2PR12MB3373B2617FAD6FB24EAC0787C4290@MN2PR12MB3373.namprd12.prod.outlook.com>
        <20191230162648.505bb0d9@archlinux>
        <MN2PR12MB3373CA90D67E5B17DCE76A8BC4340@MN2PR12MB3373.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Jan 2020 09:22:59 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> a kind reminder about this patch still waiting. Now testing branch is rea=
dy for it to be applied.
>=20
> I've got a good number of other patches just waiting for this one to be a=
ccepted before sending.
Applied to the togreg branch of iio.git and pushed out as testing.

For some reason I got confused and thought there was still a question on pa=
tch 1
so kept ignoring patch 2 despite having applied patch 1.

Sorry about that.

Jonathan

>=20
> Thanks,
> JB
>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
>=20
> Sent: Monday, December 30, 2019 17:26
>=20
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
>=20
> Cc: linux-iio <linux-iio@vger.kernel.org>
>=20
> Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data=
 support
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
> On Tue, 24 Dec 2019 09:17:05 +0000
>=20
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
>=20
>=20
>=20
> > Hi Jonathan, =20
>=20
> >  =20
>=20
> > any news about my 2nd patch ("[PATCH 2/2] iio: imu: inv_mpu6050: add fi=
fo temperature data support") now that the 1st is included inside fixes-tog=
reg branch? =20
>=20
> >  =20
>=20
> > The 1st one is still not yet available inside testing branch. =20
>=20
> > Should I resend it now or wait for testing to be in sync with fixes-tog=
reg? =20
>=20
> I have it flagged in my email so in theory at least I will grab it
>=20
> without a resend.=C2=A0 I think I'll do a pull request for togreg later t=
his
>=20
> week and after that I should be fine applying this.
>=20
>=20
>=20
> Things got a bit slowed down for the holidays :)=C2=A0 Too easy to put
>=20
> things off to tomorrow!
>=20
>=20
>=20
> Jonathan
>=20
>=20
>=20
> >  =20
>=20
> > Thanks, =20
>=20
> > JB =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com> =20
>=20
> >  =20
>=20
> > Sent: Monday, December 2, 2019 14:50 =20
>=20
> >  =20
>=20
> > To: Jonathan Cameron <jic23@kernel.org> =20
>=20
> >  =20
>=20
> > Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature da=
ta support =20
>=20
> >  =20
>=20
> > =C2=A0 =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Hi Jonathan, =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > just a reminder for not forgetting this patch now that the first is in =
fixes-togreg branch. =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Thanks, =20
>=20
> >  =20
>=20
> > JB =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > From: Jonathan Cameron <jic23@kernel.org> =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Sent: Saturday, November 23, 2019 17:22 =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com> =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org> =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature da=
ta support =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > =C2=A0 =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > =C2=A0CAUTION: This email originated from outside of the organization. =
Please make sure the sender is who they say they are and do not click links=
 or open attachments unless you recognize the sender and know the content i=
s safe. =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > On Mon, 18 Nov 2019 11:34:06 +0100 =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote: =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > Add support of temperature data in fifo for all chips.=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > Enable unification of scan elements for icm20602.=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > Add macros for generating scan elements with and without temp.=C2=A0 =
 =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Looks fine to me. I'll pick up once we've worked out what =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > we are doing with patch 1. =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Remind me if I seem to have lost it. =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Thanks, =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > Jonathan =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > ---=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=C2=A0=C2=A0=C2=A0 | =
194 +++++++-----------=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 22 +-=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 +-=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=C2=A0=C2=A0 3 +=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 4 files changed, 84 insertions(+), 141 deletions(-)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio=
/imu/inv_mpu6050/inv_mpu_core.c=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > index 268240644adf..7c2f6951364d 100644=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -104,6 +104,7 @@ static const struct inv_mpu6050_chip_config chip_=
config_6050 =3D {=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .divider =3D INV_MPU6050_FI=
FO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE),=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .gyro_fifo_enable =3D false=
,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .accl_fifo_enable =3D false=
,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 .temp_fifo_enable =3D false,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .magn_fifo_enable =3D false=
,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .accl_fs =3D INV_MPU6050_FS=
_02G,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .user_ctrl =3D 0,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -856,19 +857,27 @@ static const struct iio_chan_spec_ext_info inv_=
ext_info[] =3D {=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .ext_info =3D inv_ext_info,=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +#define INV_MPU6050_TEMP_CHAN(_index)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .type =3D IIO_TEMP,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)=C2=A0=C2=A0=C2=A0 \=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET)=C2=A0=C2=A0=C2=A0=
=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE),=C2=A0=C2=A0=C2=A0=
=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .scan_index =3D _index,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .scan_type =3D {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sign =3D 's',=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .realbits =3D 16,=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0 =
 =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .storagebits =3D 16,=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 0,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D IIO_=
BE,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 static const struct iio_chan_spec inv_mpu_channels[] =3D {=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV=
_MPU6050_SCAN_TIMESTAMP),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 /*=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that temperature should only b=
e via polled reading only,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not the final scan elements output.=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .type =3D IIO_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .scan_index =3D -1,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 },=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP=
),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_V=
EL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_V=
EL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_V=
EL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -878,22 +887,31 @@ static const struct iio_chan_spec inv_mpu_chann=
els[] =3D {=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL,=
 IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 };=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +#define INV_MPU6050_SCAN_MASK_3AXIS_ACCEL=C2=A0=C2=A0=C2=A0 \=C2=A0 =
 =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_MPU6050_SCAN_ACCL_X)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z))=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +#define INV_MPU6050_SCAN_MASK_3AXIS_GYRO=C2=A0=C2=A0=C2=A0=C2=A0 \=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_MPU6050_SCAN_GYRO_X)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z))=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +#define INV_MPU6050_SCAN_MASK_TEMP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_MPU6050_SCAN_TEMP))=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +/* generate scan mask and a duplicate with temperature enabled */=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +#define INV_MPU6050_SCAN_MASK_DUP_TEMP(_mask)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 (_mask),=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 (_mask) | INV_MPU6050_SCAN_MASK_TEMP=C2=A0 =
 =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 static const unsigned long inv_mpu_scan_masks[] =3D {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis accel */=C2=A0  =
=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_=
SCAN_MASK_3AXIS_ACCEL),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis gyro */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_=
SCAN_MASK_3AXIS_GYRO),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis accel + gyro */=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_=
SCAN_MASK_3AXIS_ACCEL=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU6050_SCAN_M=
ASK_3AXIS_GYRO),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 };=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -917,17 +935,9 @@ static const unsigned long inv_mpu_scan_masks[] =
=3D {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 static const struct iio_chan_spec inv_mpu9150_channels[] =3D {=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV=
_MPU9X50_SCAN_TIMESTAMP),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 /*=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that temperature should only b=
e via polled reading only,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not the final scan elements output.=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .type =3D IIO_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .scan_index =3D -1,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 },=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP=
),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_V=
EL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_V=
EL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_V=
EL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -944,17 +954,9 @@ static const struct iio_chan_spec inv_mpu9150_ch=
annels[] =3D {=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 static const struct iio_chan_spec inv_mpu9250_channels[] =3D {=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV=
_MPU9X50_SCAN_TIMESTAMP),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 /*=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note that temperature should only b=
e via polled reading only,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not the final scan elements output.=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .type =3D IIO_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .scan_index =3D -1,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 },=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP=
),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_V=
EL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_V=
EL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_V=
EL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -969,98 +971,42 @@ static const struct iio_chan_spec inv_mpu9250_c=
hannels[] =3D {=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU9X50_MAGN_CHAN(IIO_M=
OD_Z, 16, INV_MPU9X50_SCAN_MAGN_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 };=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +#define INV_MPU9X50_SCAN_MASK_3AXIS_MAGN=C2=A0=C2=A0=C2=A0=C2=A0 \=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_MPU9X50_SCAN_MAGN_X)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z))=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 static const unsigned long inv_mpu9x50_scan_masks[] =3D {=C2=A0=
  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis accel */=C2=A0  =
=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_=
SCAN_MASK_3AXIS_ACCEL),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis gyro */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_=
SCAN_MASK_3AXIS_GYRO),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis magn */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU9X50_SCAN_MAGN_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU9X50_=
SCAN_MASK_3AXIS_MAGN),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis accel + gyro */=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_=
SCAN_MASK_3AXIS_ACCEL=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU6050_SCAN_M=
ASK_3AXIS_GYRO),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis accel + magn */=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_=
SCAN_MASK_3AXIS_ACCEL=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU9X50_SCAN_M=
ASK_3AXIS_MAGN),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis gyro + magn */=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_=
SCAN_MASK_3AXIS_GYRO=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU9X50_SCAN_M=
ASK_3AXIS_MAGN),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 9-axis accel + gyro + ma=
gn */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_=
SCAN_MASK_3AXIS_ACCEL=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU6050_SCAN_M=
ASK_3AXIS_GYRO=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU9X50_SCAN_M=
ASK_3AXIS_MAGN),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 };=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -static const struct iio_chan_spec inv_icm20602_channels[] =3D {=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_T=
IMESTAMP),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .type =3D IIO_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .scan_index =3D INV_ICM20602_SCAN_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .scan_type =3D {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sign =3D 's',=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 .realbits =3D 16,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 .storagebits =3D 16,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 0,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D IIO_BE,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 },=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 },=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, I=
NV_ICM20602_SCAN_GYRO_X),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, I=
NV_ICM20602_SCAN_GYRO_Y),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, I=
NV_ICM20602_SCAN_GYRO_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_=
ICM20602_SCAN_ACCL_Y),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_=
ICM20602_SCAN_ACCL_X),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_=
ICM20602_SCAN_ACCL_Z),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -};=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 static const unsigned long inv_icm20602_scan_masks[] =3D {=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis accel + temp (man=
datory) */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM20602_SCAN_ACCL_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_TEMP),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU=
6050_SCAN_MASK_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis gyro + temp (mand=
atory) */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM20602_SCAN_GYRO_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_TEMP),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU6=
050_SCAN_MASK_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 6-axis accel + gyro + te=
mp (mandatory) */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM20602_SCAN_ACCL_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_GYRO_X)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | BIT(INV_ICM20602_SCAN_TEMP),=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU=
6050_SCAN_MASK_3AXIS_GYRO=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | INV_MPU6050_SCAN_M=
ASK_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 };=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -1363,8 +1309,8 @@ int inv_mpu_core_probe(struct regmap *regmap, i=
nt irq, const char *name,=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D inv_mpu9x50_scan_=
masks;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case INV_ICM20602:=C2=A0  =
=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 indio_dev->channels =3D inv_icm20602_channels;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_icm20602_channels);=C2=A0=
  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 indio_dev->channels =3D inv_mpu_channels;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu_channels);=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D inv_icm20602_scan=
_masks;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_iio.h=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > index b096e010d4ee..6158fca7f70e 100644=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -86,6 +86,7 @@ enum inv_devices {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0 *=C2=A0 @accl_fs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accel full scale range.=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0 *=C2=A0 @accl_fifo_enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enable accel data output=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0 *=C2=A0 @gyro_fifo_enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enable gyro data output=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > + *=C2=A0 @temp_fifo_enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enab=
le temp data output=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0 *=C2=A0 @magn_fifo_enable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 enable magn data output=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0 *=C2=A0 @divider:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip sample rate divide=
r (sample rate divider - 1)=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0 */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -95,6 +96,7 @@ struct inv_mpu6050_chip_config {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int accl_fs:2;=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int accl_fifo_enab=
le:1;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int gyro_fifo_enab=
le:1;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int temp_fifo_enable:1;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int magn_fifo_enab=
le:1;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 divider;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 user_ctrl;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -184,6 +186,7 @@ struct inv_mpu6050_state {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_MPU6050_BIT_SLAVE_2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x04=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_MPU6050_BIT_ACCEL_OUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x08=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_MPU6050_BITS_GYRO_OUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x70=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +#define INV_MPU6050_BIT_TEMP_OUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x80=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_MPU6050_REG_I2C_MST_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x24=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_MPU6050_BITS_I2C_MST_CLK_400KHZ 0x0D=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -268,8 +271,8 @@ struct inv_mpu6050_state {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 /* MPU9X50 9-axis magnetometer */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_MPU9X50_BYTES_MAGN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -/* ICM20602 FIFO samples include temperature readings */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -#define INV_ICM20602_BYTES_PER_TEMP_SENSOR=C2=A0=C2=A0 2=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +/* FIFO temperature sample size */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +#define INV_MPU6050_BYTES_PER_TEMP_SENSOR=C2=A0=C2=A0 2=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 /* mpu6500 registers */=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_MPU6500_REG_ACCEL_CONFIG_2=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1D=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -298,7 +301,7 @@ struct inv_mpu6050_state {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_ICM20608_TEMP_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 8170=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_ICM20608_TEMP_SCALE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 3059976=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -/* 6 + 6 + 7 (for MPU9x50) =3D 19 round up to 24 and plus 8 */=C2=A0=
  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +/* 6 + 6 + 2 + 7 (for MPU9x50) =3D 21 round up to 24 and plus 8 */=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_MPU6050_OUTPUT_DATA_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 32=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 #define INV_MPU6050_REG_INT_PIN_CFG=C2=A0 0x37=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -344,6 +347,7 @@ enum inv_mpu6050_scan {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_ACCL_X,=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_ACCL_Y,=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_ACCL_Z,=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_GYRO_X,=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_GYRO_Y,=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_GYRO_Z,=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -355,18 +359,6 @@ enum inv_mpu6050_scan {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU9X50_SCAN_TIMESTAMP,=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 };=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -/* scan element definition for ICM20602, which includes temperature =
*/=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -enum inv_icm20602_scan {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_ACCL_X,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_ACCL_Y,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_ACCL_Z,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_TEMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_X,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_Y,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_Z,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_TIMESTAMP,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -};=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 enum inv_mpu6050_filter_e {=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_FILTER_256HZ_NO=
LPF2 =3D 0,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_FILTER_188HZ,=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio=
/imu/inv_mpu6050/inv_mpu_ring.c=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > index 10d16ec5104b..3755577dc449 100644=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -142,6 +142,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 d |=3D INV_MPU6050_BITS_GYRO_OUT;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.accl_fi=
fo_enable)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 d |=3D INV_MPU6050_BIT_ACCEL_OUT;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.temp_fifo_enable)=C2=A0=
  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 d |=3D INV_MPU6050_BIT_TEMP_OUT;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.magn_fi=
fo_enable)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 d |=3D INV_MPU6050_BIT_SLAVE_0;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D regmap_write(st-=
>map, st->reg->fifo_en, d);=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -200,8 +202,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *=
p)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.gyro_fi=
fo_enable)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bytes_per_datum +=3D INV_MPU6050_BYTES_PER_3AXIS_SENS=
OR;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_type =3D=3D INV_ICM20602)=C2=
=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bytes_per_datum +=3D INV_ICM20602_BYTES_PER_TEMP_SENSOR;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.temp_fifo_enable)=C2=A0=
  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bytes_per_datum +=3D INV_MPU6050_BYTES_PER_TEMP_SENSOR;=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.magn_fi=
fo_enable)=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bytes_per_datum +=3D INV_MPU9X50_BYTES_MAGN;=C2=A0  =
=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/=
iio/imu/inv_mpu6050/inv_mpu_trigger.c=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > index a9c75bc62f18..5199fe790c30 100644=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > @@ -24,6 +24,9 @@ static void inv_scan_query_mpu6050(struct iio_dev *=
indio_dev)=C2=A0 =20
>=20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 indio_dev->active_scan_mask) ||=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 test_bit(INV_MPU6050_SCAN_ACCL_Z,=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 indio_dev->active_scan_mask);=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_config.temp_fifo_enable =3D=C2=A0 =
 =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 test_bit(INV_MPU6050_SCAN_TEMP, indio_dev->active_scan_mask);=C2=A0 =
 =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 }=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0=C2=A0=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> > >=C2=A0 static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)=
=C2=A0  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
> >  =20
>=20
>=20
>=20

