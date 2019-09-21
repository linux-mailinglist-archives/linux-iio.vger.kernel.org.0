Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6764FB9D00
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2019 10:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390953AbfIUIG6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Sep 2019 04:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390938AbfIUIG6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Sep 2019 04:06:58 -0400
Received: from localhost.localdomain (unknown [151.66.30.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A896217F5;
        Sat, 21 Sep 2019 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569053216;
        bh=ZM5Lkl5sCYE/g3lU0VmhaJ4tSNMTWaSPk9aOHIK/m50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McATrKslVqrtOjtENqWB7wKhc+ypkgv3wGfz3+i0v/j49Sg35pWbi7j+jUO7w3BH1
         PsYRKgdwD+JgG2YvvvY29Ivs+r0IXmCqa/sX8gHnrMlSlfwzy9mLjf7PPM6Y8SjPrb
         JooOTW+vtwhBa8z32m5xHaCDBIu59JAPBq+ZzzLg=
Date:   Sat, 21 Sep 2019 10:06:51 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Bobby Jones <rjones@gateworks.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: LSM9DS1 testing with st_lsm6dsx driver
Message-ID: <20190921080651.GA15821@localhost.localdomain>
References: <CALAE=UCTTOhvUofvk1ZrLZ2aNoSMYyFq8dHoaDxRc2aOdbV8jA@mail.gmail.com>
 <20190920064214.GA31900@lore-desk-wlan.lan>
 <CALAE=UDmg_+q=zt9Z6D5BrsnpFXi7dVMdTMVdHk2SMXCtxoJTw@mail.gmail.com>
 <20190920215542.GA16493@localhost.localdomain>
 <CALAE=UBH8ESTkXzrzK2_Tvt-vzVeOiewJFi_g4g2NsoUqwge1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <CALAE=UBH8ESTkXzrzK2_Tvt-vzVeOiewJFi_g4g2NsoUqwge1w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > > LSM9DS1 does not support hw FIFO for the moment. Are you trying to =
enable
> > > > buffered reading?
> > >
> > > I am not manually interacting with the device at all when this
> > > exception occurs. This happens during the driver probe.
> > >
> > > > Could you please try if the following patch helps? (just compiled)
> > >
> > > I no longer receive the exception with this patch and it makes sense,=
 thanks.
> >
> > Hi Bobby,
> >
> > thx a lot for testing. Could you please try to drop the previous patch =
and
> > apply the following one? Does it fix the issue as well?
>=20
> No problem, happy to help. I just tested, and unfortunately the issue
> is still present with this patch.

re-looking at the code this patch will actually does not anything since in =
the
current implementation st_lsm6dsx_handler_irq will return IRQ_NONE and the
thread handler will not be run. Anyway since st_lsm6dsx_handler_irq will be
removed soon I will respin this patch ontop of Sean series.

> I gave the datasheet and the hardware reference manual of the
> connected CPU a closer look and suspected a problem with my pin
> config. However even after various combinations of pull ups/downs and
> IRQ_TYPE_LEVEL_LOW/IRQ_TYPE_LEVEL_HIGH the same exception occurs, so I
> don't think that there's an issue with pin config stopping the
> interrupt line from being deasserted.

are you able to monitor the line activity through an oscilloscope?
The issue is the irq line is never asserted and the kernel complains about
lot of interrupts not managed

Looking at the datasheet, LSM9DS1 does not support IRQ_TYPE_LEVEL_LOW.
ST_LSM6DSX_REG_HLACTIVE_ADDR and ST_LSM6DSX_REG_PP_OD_ADDR registers are
actually not defined for LSM9DS1 and I will move them in hw_settings map.

@Jonathan: do you prefer this patch to be ontop of Sean's series?

Regards,
Lorenzo

>=20
> >
> > iio: imu: st_lsm6dsx: check read_fifo pointer in st_lsm6dsx_handler_thr=
ead
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index b0f3da1976e4..f4fd4842bd79 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -666,6 +666,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int ir=
q, void *private)
> >         struct st_lsm6dsx_hw *hw =3D private;
> >         int count;
> >
> > +       if (!hw->settings->fifo_ops.read_fifo)
> > +               return IRQ_NONE;
> > +
> >         mutex_lock(&hw->fifo_lock);
> >         count =3D hw->settings->fifo_ops.read_fifo(hw);
> >         mutex_unlock(&hw->fifo_lock);
> > --
> > 2.21.0
> >
> > >
> > > For context I'm working with a board that has every data ready and
> > > interrupt signal connected to the LSM9DS1. Could you clarify what the
> > > proper usage of the "st,drdy-int-pin" would be in this case and
> > > whether or not I need more than one interrupt called out in my device
> > > tree node?
> > > I'm not really understanding how they're currently being utilized for
> > > this device in the driver.
> >
> > For the moment irq line in lsm9ds1 (acc/gyro) is not used at all,
> > so you can omit the "st,drdy-int-pin" property
> >
> > >
> > > Also, I know support for this device was added recently and the combo
> > > device hardware FIFO is complex, but is support for this something
> > > that's currently being worked on?
> >
> > It is actually in my ToDo list but I have no this device at the moment,=
 so
> > patches are welcome :)
> >
> > Regards,
> > Lorenzo
> >
> > >
> > > Thanks,
> > > Bobby Jones
> > >
> > > > Regards,
> > > > Lorenzo
> > > >
> > > > iio: imu: st_lsm6dsx: do not configure the fifo if not supported
> > > >
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index b65a6ca775e0..90a0e5ce44e5 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -1572,7 +1572,7 @@ int st_lsm6dsx_probe(struct device *dev, int =
irq, int hw_id,
> > > >                         return err;
> > > >         }
> > > >
> > > > -       if (hw->irq > 0) {
> > > > +       if (hw->irq > 0 && hw->settings->fifo_ops.update_fifo) {
> > > >                 err =3D st_lsm6dsx_fifo_setup(hw);
> > > >                 if (err < 0)
> > > >                         return err;
> > > > --
> > > > 2.21.0
> > > >
> > > >

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXYXaGAAKCRA6cBh0uS2t
rLj4AP93/SNpCD8dPfVKFXWkg8YreQJpIL66lPk5pRTSk0OVbgD+K0KEq0VpCauB
SgSJaYM1SgOAwt2aFZniNuVDu5HG0AQ=
=Jhmt
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
