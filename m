Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1288B267F38
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgIMKWf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 06:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgIMKWf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 06:22:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20AA820709;
        Sun, 13 Sep 2020 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599992554;
        bh=VjtbrwFeUIaNBlmRVt0IUVaHfpAQ7vtVrZrm9A23mcY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RRzfYYSFADPgfh68uCeXXMNFRCJEs9eKGw92ImOz5696tiYATv/roGQjfhRQCznrv
         99YeeYsO+CwRDjFNSaWC/y5Mm5wLYUi2kOIrfMDmHyJcXfNtGUVtVtTqb1TDiK/NpS
         ZaGRW8F1MGQHS+Rnb/frJ5LeO0iqMI6N9dlqLUK8=
Date:   Sun, 16 Aug 2020 09:58:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        =?UTF-8?B?TWljaGE=?= =?UTF-8?B?xYIgTWlyb3PFgmF3?= 
        <mirq-linux@rere.qmqm.pl>, Lee Jones <lee.jones@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: check for temp_fifo_enable
Message-ID: <20200816095830.64650d0a@archlinux>
In-Reply-To: <MN2PR12MB43905A48FB51A0B33198CC56C4430@MN2PR12MB4390.namprd12.prod.outlook.com>
References: <20200809155936.16898-1-trix@redhat.com>
        <CAHp75VdEBjxYS_4g2j=ofjFWuGyTK5Me=9mMNcy5ienUUs67Ag@mail.gmail.com>
        <MN2PR12MB43905A48FB51A0B33198CC56C4430@MN2PR12MB4390.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Aug 2020 08:04:06 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello,
>=20
> this is a case that should never be happening since available scan mask o=
nly advertise Accel + Temp, Gyro + Temp, or Accel + Gyro + Temp.
> More than that, temperature sensor is not working when MEMS engine is off=
. (it's only purpose it to measure temperature of the MEMS to do data tempe=
rature compensation).
>=20
> So I think we can let this check as it is currently, since this is not a =
supported configuration.
>=20

Perhaps a good option would be to add a suitably positioned comment to make
this clear so we don't get further patches 'fixing' this in the future?

Thanks,

Jonathan

> Best regards,
> JB
>=20
>=20
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> Sent: Monday, August 10, 2020 10:02
> To: trix@redhat.com <trix@redhat.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>=
; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald <pmeerw@pmeerw.net>;=
 Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Micha=C5=82 Miros=C5=82=
aw <mirq-linux@rere.qmqm.pl>; Lee Jones <lee.jones@linaro.org>; linux-iio <=
linux-iio@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.ke=
rnel.org>
> Subject: Re: [PATCH] iio: imu: inv_mpu6050: check for temp_fifo_enable=20
> =C2=A0
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
> On Sun, Aug 9, 2020 at 7:00 PM <trix@redhat.com> wrote:
> >
> > From: Tom Rix <trix@redhat.com>
> >
> > clang static analysis reports this problem
> >
> > inv_mpu_ring.c:181:18: warning: Division by zero
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb =3D fifo_count / byt=
es_per_datum;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> >
> > This is a false positive.
> > Dividing by 0 is protected by this check
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(st->chip_config.a=
ccl_fifo_enable |
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_config.gyro_fifo_enable |
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_config.magn_fifo_enable))
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto end_session;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes_per_datum =3D 0;
> >
> > But there is another fifo, temp_fifo
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.tem=
p_fifo_enable)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bytes_per_datum +=3D INV_MPU6050_BYTES_PER_TEMP_SE=
NSOR;
> >
> > Which would be skipped if it was the only enabled fifo.
> > So add to the check.
> > =20
>=20
> > Fixes: 2e4c0a5e2576 ("iio: imu: inv_mpu6050: add fifo temperature data =
support")
> >
> > Signed-off-by: Tom Rix <trix@redhat.com> =20
>=20
> There shouldn't be a blank line in between.
>=20
> Other than that,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
>=20
>=20
> > ---
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 1 +
> >=C2=A0 1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_ring.c
> > index b533fa2dad0a..5240a400dcb4 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > @@ -141,6 +141,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> >
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(st->chip_config.a=
ccl_fifo_enable |
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_config.gyro_fifo_enable |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 st->chip_config.temp_fifo_enable |
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_config.magn_fifo_enable))
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto end_session;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes_per_datum =3D 0;
> > --
> > 2.18.1
> > =20
>=20
>=20
> --
> With Best Regards,
> Andy Shevchenko
