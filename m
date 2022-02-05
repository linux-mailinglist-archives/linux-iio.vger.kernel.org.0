Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4114AAB01
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 19:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380974AbiBESoT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 13:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiBESoS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2022 13:44:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46754C061348
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 10:44:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01CFAB80B74
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 18:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FE0C340E8;
        Sat,  5 Feb 2022 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644086654;
        bh=XE4dC2lTWYcxO1HxeZXz3fmQRxoEUN5qz1irhZqMw2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YFUGEcDpnS8Mh/w8lEaYvy0UnbmdMoSkJgxGvzN3nYxSQonE+cdqGB2KFv8Fd8oZN
         4NoTRctTJVx47Jz0yhIMGFFaUccmphnlXR8ws6P/kYRRFxa7ENhRimqefju8Neev6C
         gyx5mIgh1cLJxluK+vK6tYCD2UB5FWJ7+mcT2ANUoVIpW8qznzCmqLkmIJRiHCxgSp
         jLtz949iuoGACXKCnoX5oPrwl+RqSwYsXAPcEFomQsWPtU/JAAK7jyrDFuJvv+gISa
         pOYcIvS6OasqDdsitkSS0JZa/zVOfQ+mBiUDYIcdfTPr/+XHPxmZxrElGxDcSKbfY9
         hEna7RrdfVOVA==
Date:   Sat, 5 Feb 2022 18:50:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 09/10] iio: core: Simplify the registration of kfifo
 buffers
Message-ID: <20220205185045.47ad3ea2@jic23-huawei>
In-Reply-To: <20220202090936.3621d0eb@xps13>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-10-miquel.raynal@bootlin.com>
        <CA+U=Dsoi2jPgqrqmbdq7GBknUiR9Y30t_tDQQo3ps3M2EmdsFw@mail.gmail.com>
        <20220115171246.59915cd2@jic23-huawei>
        <20220202090936.3621d0eb@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2 Feb 2022 09:09:36 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
>=20
> jic23@kernel.org wrote on Sat, 15 Jan 2022 17:12:46 +0000:
>=20
> > On Thu, 16 Dec 2021 09:52:38 +0200
> > Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> >  =20
> > > On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote:   =20
> > > >
> > > > Among all the users of the kfifo buffers, no one uses the
> > > > INDIO_BUFFER_HARDWARE mode. So let's take this as a general rule and
> > > > simplify a little bit the internals - overall the documentation - by
> > > > eliminating unused specific cases. Use the INDIO_BUFFER_SOFTWARE mo=
de by
> > > > default with kfifo buffers, which will basically mimic what all the=
 "non
> > > > direct" modes do.
> > > >     =20
> > >=20
> > > I think this patch here (and 10/10) can be part of a separate series.
> > > This discussion is important enough to have it's own series.
> > > It's a bit of an API discussion.
> > >   =20
> > One question inline.
> >   =20
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  drivers/iio/accel/fxls8962af-core.c                  |  1 -
> > > >  drivers/iio/accel/sca3000.c                          |  1 -
> > > >  drivers/iio/accel/ssp_accel_sensor.c                 |  1 -
> > > >  drivers/iio/adc/ina2xx-adc.c                         |  1 -
> > > >  drivers/iio/adc/ti_am335x_adc.c                      |  4 +---
> > > >  drivers/iio/buffer/kfifo_buf.c                       | 12 ++------=
----
> > > >  .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  3 +--
> > > >  drivers/iio/common/scmi_sensors/scmi_iio.c           |  1 -
> > > >  drivers/iio/gyro/ssp_gyro_sensor.c                   |  1 -
> > > >  drivers/iio/health/max30100.c                        |  1 -
> > > >  drivers/iio/health/max30102.c                        |  1 -
> > > >  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c    |  1 -
> > > >  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c     |  1 -
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c       |  1 -
> > > >  drivers/iio/light/apds9960.c                         |  1 -
> > > >  drivers/staging/iio/impedance-analyzer/ad5933.c      |  1 -
> > > >  include/linux/iio/kfifo_buf.h                        |  5 ++---
> > > >  17 files changed, 6 insertions(+), 31 deletions(-) =20
>=20
> [...]
>=20
> > > > --- a/drivers/iio/adc/ti_am335x_adc.c
> > > > +++ b/drivers/iio/adc/ti_am335x_adc.c
> > > > @@ -376,9 +376,7 @@ static int tiadc_iio_buffered_hardware_setup(st=
ruct device *dev,
> > > >  {
> > > >         int ret;
> > > >
> > > > -       ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev,
> > > > -                                         INDIO_BUFFER_SOFTWARE,
> > > > -                                         setup_ops);
> > > > +       ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, setup_o=
ps);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kf=
ifo_buf.c
> > > > index 416d35a61ae2..f17473e06ee8 100644
> > > > --- a/drivers/iio/buffer/kfifo_buf.c
> > > > +++ b/drivers/iio/buffer/kfifo_buf.c
> > > > @@ -197,7 +197,7 @@ static const struct iio_buffer_access_funcs kfi=
fo_access_funcs =3D {
> > > >         .set_length =3D &iio_set_length_kfifo,
> > > >         .release =3D &iio_kfifo_buffer_release,
> > > >
> > > > -       .modes =3D INDIO_BUFFER_SOFTWARE | INDIO_BUFFER_TRIGGERED,
> > > > +       .modes =3D INDIO_BUFFER_SOFTWARE,   =20
> >=20
> > Why is this safe to do?  Don't we need triggered buffers to match mode
> > when used with a kfifo?
> >=20
> > If I'm remembering / reading how the mode matching works, this breaks t=
he
> > industrialio-triggered-buffer.c case where it sets the mode to
> > INDIO_BUFFER_TRIGGERED (mostly I think to make sure we get a warning in
> > iio_verify_update() if no trigger is supplied - I can't remember what o=
ther
> > difference it makes (or if it does). =20
>=20
> Mmmh that's right, I overlooked that part. Indeed we still need to
> support the INDIO_BUFFER_TRIGGERED mode in the kfifo_access_funcs
> modes.
>=20
> Do you think the rest of the patch is still legit? I believe it stills
> simplifies the logic for the user but if you disagree I'll drop it off
> entirely.
>=20
yup. The rest was fine from what I recall.

J
> Thanks,
> Miqu=C3=A8l

