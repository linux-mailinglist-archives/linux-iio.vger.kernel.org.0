Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C63722FC1
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jun 2023 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjFETZQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jun 2023 15:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFETZQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jun 2023 15:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0159E8
        for <linux-iio@vger.kernel.org>; Mon,  5 Jun 2023 12:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D50A629BD
        for <linux-iio@vger.kernel.org>; Mon,  5 Jun 2023 19:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4929C433EF;
        Mon,  5 Jun 2023 19:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685993113;
        bh=ra7M0ozjIMdxOQ/hCF27Wn1FBWgcgUNMkP08+aQCh/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PHyOZ3jkEscYkpehKoH2+Ttvr705HbB1NHzCy4mPUwhLYriB7PbeVoH+EYwOW79d7
         7u4nZgBhtF+YnTftB4oGEyEXxDcy46EPYhjQRie3pAhBdnsgH2zGjwzHP5xIDT0Yvl
         tUGKYwMRaQU8PdqI36X24KA0FmEmDqzOa7lm+2Khj5ax1k8gGSCJAuikX2NQWx1LMn
         Eaud3O6Mi1/36DSdnVas34Z7heGwSTH2/QCMPaGWLhiwf8zxIS+28qUY9BEzgGcnZO
         ZHUKzPedcnu1bhXOPO65mzTxhvKyHENyePLsjOqt3pzCJ2pd+ogF7gYCfxRbdBo+uO
         nGagrlye2F5sw==
Date:   Mon, 5 Jun 2023 20:25:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc:     INV Git Commit <INV.git-commit@tdk.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 2/4] iio: move inv_icm42600 timestamp module in common
Message-ID: <20230605202511.703e76d1@jic23-huawei>
In-Reply-To: <FR3P281MB1757824DF1984104059CA9D0CE4DA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230531142513.48507-1-inv.git-commit@tdk.com>
        <20230531142513.48507-3-inv.git-commit@tdk.com>
        <20230604115843.5f887bb4@jic23-huawei>
        <FR3P281MB1757824DF1984104059CA9D0CE4DA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Jun 2023 19:07:38 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
>=20
> currently only IMU drivers will be using this timestamp module. But we ha=
ve other new chips (pressure sensor for example) that could use it in the f=
uture.
>=20
> So I prefer keeping this module more general to avoid being obliged to mo=
ve it in the future.

Fair enough.  Perhaps add a note on that to the patch description.

Jonathan

>=20
> Thanks,
> JB
>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, June 4, 2023 12:58
> To: INV Git Commit <INV.git-commit@tdk.com>
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; lars@metafoo.d=
e <lars@metafoo.de>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Subject: Re: [PATCH 2/4] iio: move inv_icm42600 timestamp module in commo=
n=20
> =C2=A0
> [CAUTION] This is an EXTERNAL email. Do not click links or open attachmen=
ts unless you recognize the sender and know the content is safe.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> On Wed, 31 May 2023 14:25:11 +0000
> inv.git-commit@tdk.com wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > Create new inv_sensors common modules and move inv_icm42600
> > timestamp module inside.
> > Modify inv_icm42600 driver to use timestamp module.
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com> =
=20
> Hi Jean-Baptiste,
>=20
> Any plan to use this outside of IMU drivers?=C2=A0 If not I'd be tempted
> to keep it more local.
>=20
> drivers/iio/imu/inv_common/ or similar and avoid the global
> header by using a "../inv_common/" include path.
>=20
> Changes themselves look fine to me.
>=20
> Jonathan
>=20
> > ---
> >=C2=A0 drivers/iio/common/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> >=C2=A0 drivers/iio/common/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> >=C2=A0 drivers/iio/common/inv_sensors/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++++++
> >=C2=A0 drivers/iio/common/inv_sensors/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> >=C2=A0 .../inv_sensors}/inv_icm42600_timestamp.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++++--
> >=C2=A0 drivers/iio/imu/inv_icm42600/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> >=C2=A0 drivers/iio/imu/inv_icm42600/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> >=C2=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
> >=C2=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=C2=A0=C2=A0 |=
=C2=A0 2 +-
> >=C2=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 3 ++-
> >=C2=A0 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> >=C2=A0 .../linux/iio/common}/inv_icm42600_timestamp.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 0
> >=C2=A0 12 files changed, 31 insertions(+), 7 deletions(-)
> >=C2=A0 create mode 100644 drivers/iio/common/inv_sensors/Kconfig
> >=C2=A0 create mode 100644 drivers/iio/common/inv_sensors/Makefile
> >=C2=A0 rename drivers/iio/{imu/inv_icm42600 =3D> common/inv_sensors}/inv=
_icm42600_timestamp.c (91%)
> >=C2=A0 rename {drivers/iio/imu/inv_icm42600 =3D> include/linux/iio/commo=
n}/inv_icm42600_timestamp.h (100%)
> >=20
> > diff --git a/drivers/iio/common/Kconfig b/drivers/iio/common/Kconfig
> > index 0334b4954773..1ccb5ccf3706 100644
> > --- a/drivers/iio/common/Kconfig
> > +++ b/drivers/iio/common/Kconfig
> > @@ -5,6 +5,7 @@
> >=C2=A0=20
> >=C2=A0 source "drivers/iio/common/cros_ec_sensors/Kconfig"
> >=C2=A0 source "drivers/iio/common/hid-sensors/Kconfig"
> > +source "drivers/iio/common/inv_sensors/Kconfig"
> >=C2=A0 source "drivers/iio/common/ms_sensors/Kconfig"
> >=C2=A0 source "drivers/iio/common/scmi_sensors/Kconfig"
> >=C2=A0 source "drivers/iio/common/ssp_sensors/Kconfig"
> > diff --git a/drivers/iio/common/Makefile b/drivers/iio/common/Makefile
> > index fad40e1e1718..d3e952239a62 100644
> > --- a/drivers/iio/common/Makefile
> > +++ b/drivers/iio/common/Makefile
> > @@ -10,6 +10,7 @@
> >=C2=A0 # When adding new entries keep the list in alphabetical order
> >=C2=A0 obj-y +=3D cros_ec_sensors/
> >=C2=A0 obj-y +=3D hid-sensors/
> > +obj-y +=3D inv_sensors/
> >=C2=A0 obj-y +=3D ms_sensors/
> >=C2=A0 obj-y +=3D scmi_sensors/
> >=C2=A0 obj-y +=3D ssp_sensors/
> > diff --git a/drivers/iio/common/inv_sensors/Kconfig b/drivers/iio/commo=
n/inv_sensors/Kconfig
> > new file mode 100644
> > index 000000000000..28815fb43157
> > --- /dev/null
> > +++ b/drivers/iio/common/inv_sensors/Kconfig
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# TDK-InvenSense sensors common library
> > +#
> > +
> > +config IIO_INV_SENSORS_TIMESTAMP
> > +=C2=A0=C2=A0=C2=A0=C2=A0 tristate
> > diff --git a/drivers/iio/common/inv_sensors/Makefile b/drivers/iio/comm=
on/inv_sensors/Makefile
> > new file mode 100644
> > index 000000000000..93bddb9356b8
> > --- /dev/null
> > +++ b/drivers/iio/common/inv_sensors/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for TDK-InvenSense sensors module.
> > +#
> > +
> > +obj-$(CONFIG_IIO_INV_SENSORS_TIMESTAMP) +=3D inv_icm42600_timestamp.o
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c b/dr=
ivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
> > similarity index 91%
> > rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> > rename to drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
> > index ceae8ccb1747..411f561e1a24 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
> > +++ b/drivers/iio/common/inv_sensors/inv_icm42600_timestamp.c
> > @@ -5,9 +5,9 @@
> >=C2=A0=20
> >=C2=A0 #include <linux/kernel.h>
> >=C2=A0 #include <linux/math64.h>
> > +#include <linux/module.h>
> >=C2=A0 #include <linux/errno.h>
> > -
> > -#include "inv_icm42600_timestamp.h"
> > +#include <linux/iio/common/inv_icm42600_timestamp.h>
> >=C2=A0=20
> >=C2=A0 /* internal chip period is 32kHz, 31250ns */
> >=C2=A0 #define INV_ICM42600_TIMESTAMP_PERIOD=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 31250
> > @@ -54,6 +54,7 @@ void inv_icm42600_timestamp_init(struct inv_icm42600_=
timestamp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* use theoretical value for =
chip period */
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_update_acc(&ts->chip_peri=
od, INV_ICM42600_TIMESTAMP_PERIOD);
> >=C2=A0 }
> > +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_init, IIO_INV_SENSORS_TIME=
STAMP);
> >=C2=A0=20
> >=C2=A0 int inv_icm42600_timestamp_update_odr(struct inv_icm42600_timesta=
mp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t period, bool fifo)
> > @@ -66,6 +67,7 @@ int inv_icm42600_timestamp_update_odr(struct inv_icm4=
2600_timestamp *ts,
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >=C2=A0 }
> > +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_update_odr, IIO_INV_SENSOR=
S_TIMESTAMP);
> >=C2=A0=20
> >=C2=A0 static bool inv_validate_period(uint32_t period, uint32_t mult)
> >=C2=A0 {
> > @@ -153,6 +155,7 @@ void inv_icm42600_timestamp_interrupt(struct inv_ic=
m42600_timestamp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (valid)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 inv_align_timestamp_it(ts);
> >=C2=A0 }
> > +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_interrupt, IIO_INV_SENSORS=
_TIMESTAMP);
> >=C2=A0=20
> >=C2=A0 void inv_icm42600_timestamp_apply_odr(struct inv_icm42600_timesta=
mp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint32_t fifo_period, size_t fifo_nb,
> > @@ -184,3 +187,8 @@ void inv_icm42600_timestamp_apply_odr(struct inv_ic=
m42600_timestamp *ts,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ts->timestamp =3D ts->it.up - interval;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=C2=A0 }
> > +EXPORT_SYMBOL_NS_GPL(inv_icm42600_timestamp_apply_odr, IIO_INV_SENSORS=
_TIMESTAMP);
> > +
> > +MODULE_AUTHOR("InvenSense, Inc.");
> > +MODULE_DESCRIPTION("InvenSense sensors timestamp module");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv=
_icm42600/Kconfig
> > index 50cbcfcb6cf1..f56b0816cc4d 100644
> > --- a/drivers/iio/imu/inv_icm42600/Kconfig
> > +++ b/drivers/iio/imu/inv_icm42600/Kconfig
> > @@ -3,6 +3,7 @@
> >=C2=A0 config INV_ICM42600
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BUFFER
> > +=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_INV_SENSORS_TIMESTAMP
> >=C2=A0=20
> >=C2=A0 config INV_ICM42600_I2C
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "InvenSense ICM-426x=
x I2C driver"
> > diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/in=
v_icm42600/Makefile
> > index 291714d9aa54..0f49f6df3647 100644
> > --- a/drivers/iio/imu/inv_icm42600/Makefile
> > +++ b/drivers/iio/imu/inv_icm42600/Makefile
> > @@ -6,7 +6,6 @@ inv-icm42600-y +=3D inv_icm42600_gyro.o
> >=C2=A0 inv-icm42600-y +=3D inv_icm42600_accel.o
> >=C2=A0 inv-icm42600-y +=3D inv_icm42600_temp.o
> >=C2=A0 inv-icm42600-y +=3D inv_icm42600_buffer.o
> > -inv-icm42600-y +=3D inv_icm42600_timestamp.o
> >=C2=A0=20
> >=C2=A0 obj-$(CONFIG_INV_ICM42600_I2C) +=3D inv-icm42600-i2c.o
> >=C2=A0 inv-icm42600-i2c-y +=3D inv_icm42600_i2c.o
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/driver=
s/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > index c3f433ad3af6..1015de636a94 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > @@ -12,12 +12,12 @@
> >=C2=A0 #include <linux/math64.h>
> >=C2=A0 #include <linux/iio/iio.h>
> >=C2=A0 #include <linux/iio/buffer.h>
> > +#include <linux/iio/common/inv_icm42600_timestamp.h>
> >=C2=A0 #include <linux/iio/kfifo_buf.h>
> >=C2=A0=20
> >=C2=A0 #include "inv_icm42600.h"
> >=C2=A0 #include "inv_icm42600_temp.h"
> >=C2=A0 #include "inv_icm42600_buffer.h"
> > -#include "inv_icm42600_timestamp.h"
> >=C2=A0=20
> >=C2=A0 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drive=
rs/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> > index 32d7f8364230..4a39d31e911f 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> > @@ -11,9 +11,9 @@
> >=C2=A0 #include <linux/delay.h>
> >=C2=A0 #include <linux/iio/iio.h>
> >=C2=A0 #include <linux/iio/buffer.h>
> > +#include <linux/iio/common/inv_icm42600_timestamp.h>
> >=C2=A0=20
> >=C2=A0 #include "inv_icm42600.h"
> > -#include "inv_icm42600_timestamp.h"
> >=C2=A0 #include "inv_icm42600_buffer.h"
> >=C2=A0=20
> >=C2=A0 /* FIFO header: 1 byte */
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_core.c
> > index c34735b05830..f3e379f9733d 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > @@ -16,10 +16,10 @@
> >=C2=A0 #include <linux/property.h>
> >=C2=A0 #include <linux/regmap.h>
> >=C2=A0 #include <linux/iio/iio.h>
> > +#include <linux/iio/common/inv_icm42600_timestamp.h>
> >=C2=A0=20
> >=C2=A0 #include "inv_icm42600.h"
> >=C2=A0 #include "inv_icm42600_buffer.h"
> > -#include "inv_icm42600_timestamp.h"
> >=C2=A0=20
> >=C2=A0 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[]=
 =3D {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> > @@ -799,3 +799,4 @@ EXPORT_NS_GPL_DEV_PM_OPS(inv_icm42600_pm_ops, IIO_I=
CM42600) =3D {
> >=C2=A0 MODULE_AUTHOR("InvenSense, Inc.");
> >=C2=A0 MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");
> >=C2=A0 MODULE_LICENSE("GPL");
> > +MODULE_IMPORT_NS(IIO_INV_SENSORS_TIMESTAMP);
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > index 9d94a8518e3c..6caea7b8a344 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > @@ -12,12 +12,12 @@
> >=C2=A0 #include <linux/math64.h>
> >=C2=A0 #include <linux/iio/iio.h>
> >=C2=A0 #include <linux/iio/buffer.h>
> > +#include <linux/iio/common/inv_icm42600_timestamp.h>
> >=C2=A0 #include <linux/iio/kfifo_buf.h>
> >=C2=A0=20
> >=C2=A0 #include "inv_icm42600.h"
> >=C2=A0 #include "inv_icm42600_temp.h"
> >=C2=A0 #include "inv_icm42600_buffer.h"
> > -#include "inv_icm42600_timestamp.h"
> >=C2=A0=20
> >=C2=A0 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h b/in=
clude/linux/iio/common/inv_icm42600_timestamp.h
> > similarity index 100%
> > rename from drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
> > rename to include/linux/iio/common/inv_icm42600_timestamp.h =20

