Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D210F1A5E32
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDLLNO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 07:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgDLLNO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:13:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 311ED2072D;
        Sun, 12 Apr 2020 11:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586689993;
        bh=FceBHPgTNrFsYCCRJs015ni9bMzW0ZZrrVsZE0Rm9WU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JsufFmEYaPNzsvzbzd0UZxQUmbRmEIvvfzqmlBgVC0dcGB+yYSpo0dirw8IrMccF8
         0RPWvLMTkg3jl9UKqdINrTf22/meqEPTbk7tvT6j0RqlX/Jixvy24JDm3+vHuEyo1Z
         4BLXpZNc0Hc4xrpJBmFBD/E6k4Gotidrnkp8CvuU=
Date:   Sun, 12 Apr 2020 12:13:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime
 power
Message-ID: <20200412121310.7eac7f6a@archlinux>
In-Reply-To: <MN2PR12MB44224D20FCD73D198639A5DAC4C20@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200331133850.23757-1-jmaneyrol@invensense.com>
        <20200405141549.0f773f5f@archlinux>
        <MN2PR12MB44224D20FCD73D198639A5DAC4C20@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Apr 2020 07:33:44 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello Jonathan,
>=20
> there were 2 issues with suspend/resume when the device was already suspe=
nded by runtime pm.
>=20
> When entering suspend, there was an error in logs because we were disabli=
ng vddio regulator although it was already disabled.
> And when resuming, the chip was pull back to full power but the pm_runtim=
e state was not updated. So it was believing it was still suspended.
>=20
> Do you need a new patch with full description?
>=20
I edited to the description to add this info.

Applied to the fixes-togreg branch of iio.git

Thanks

Jonathan


> Thanks,
> JB
>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
>=20
> Sent: Sunday, April 5, 2020 15:15
>=20
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
>=20
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
>=20
> Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runti=
me power
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
> On Tue, 31 Mar 2020 15:38:50 +0200
>=20
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>=20
>=20
>=20
> > Suspend/resume were not working correctly with pm runtime. =20
>=20
>=20
>=20
> Need more info than that!
>=20
> Anyhow, when you say "not working correctly" what is happening that
>=20
> is wrong?
>=20
>=20
>=20
> Jonathan
>=20
>=20
>=20
>=20
>=20
> > Now suspend check if the chip is already suspended, and =20
>=20
> > resume put runtime pm in the correct state. =20
>=20
> >  =20
>=20
> > Fixes: 4599cac84614 ("iio: imu: inv_mpu6050: use runtime pm with autosu=
spend") =20
>=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> =20
>=20
> > --- =20
>=20
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 11 ++++++++++- =20
>=20
> >=C2=A0 1 file changed, 10 insertions(+), 1 deletion(-) =20
>=20
> >  =20
>=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c =20
>=20
> > index e4b0d368c2f9..a58bab03f0b0 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =20
>=20
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =20
>=20
> > @@ -1636,6 +1636,10 @@ static int __maybe_unused inv_mpu_resume(struct =
device *dev) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (result) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_unlock; =20
>=20
> >=C2=A0  =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_disable(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_set_active(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_enable(dev); =20
>=20
> > + =20
>=20
>=20
>=20
> Looking at the docs, we should do this if we were previously suspended an=
d no longer
>=20
> are.=C2=A0 Not sure we should do it we weren't previously in runtime susp=
end?
>=20
>=20
>=20
> I guess it is idempotent anyway so if we were previously enabled we just =
set it again.
>=20
> So probably fine.
>=20
>=20
>=20
> Jonathan
>=20
>=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D inv_mpu6050_switch=
_engine(st, true, st->suspended_sensors); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (result) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_unlock; =20
>=20
> > @@ -1657,13 +1661,18 @@ static int __maybe_unused inv_mpu_suspend(struc=
t device *dev) =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> >=C2=A0  =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->suspended_sensors =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (pm_runtime_suspended(dev)) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 result =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_buffer_enabled(indio_=
dev)) { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 result =3D inv_mpu6050_prepare_fifo(st, false); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (result) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out=
_unlock; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> >=C2=A0  =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 st->suspended_sensors =3D 0; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.accl_en) =
=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 st->suspended_sensors |=3D INV_MPU6050_SENSOR_ACCL; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.gyro_en) =
=20
>=20
>=20
>=20

