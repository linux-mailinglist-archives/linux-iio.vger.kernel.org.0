Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E3F57335
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 22:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZU6Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 16:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZU6X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 16:58:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECE82086D;
        Wed, 26 Jun 2019 20:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561582702;
        bh=J6KbQPV2e/Zez6InThQEwTT6V7rv/8UmD15UJflw5nA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Lq/2Dh48jI9qaCJmOHGGEcqPy9X/mzuOm1kotGuT4quGwvE93yhRHhZoWbhm2vOa
         5/VaFXn320jKG4SMn4kRLUNWYsf1990mQ1owjNIa6Z8DVhsFyV94jQ+vbA5Gv4XPwl
         CfkJPbHM1erOJe3VmBnp0eLPpS8vKZFNyLxiBYjA=
Date:   Wed, 26 Jun 2019 21:58:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        dianders@chromium.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Support accelerometers for veyron_minnie
Message-ID: <20190626215817.06a56125@archlinux>
In-Reply-To: <882cf47c-c126-3e10-ba3a-23c926a68ce1@collabora.com>
References: <20190624225312.131745-1-gwendal@chromium.org>
        <5326bfb8-611f-765b-1c9c-c95032102c71@collabora.com>
        <20190626202103.07e27e5e@archlinux>
        <882cf47c-c126-3e10-ba3a-23c926a68ce1@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Jun 2019 22:40:00 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi Jonathan,
>=20
> On 26/6/19 21:21, Jonathan Cameron wrote:
> > On Tue, 25 Jun 2019 19:09:50 +0200
> > Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> >  =20
> >> Hi,
> >>
> >> On 25/6/19 0:53, Gwendal Grignou wrote: =20
> >>> veyron_minnie - ASUS Chromebook Flip C100PA - embedded controller
> >>> controls two accelerometers, one in the lid, one in the base.
> >>> However, the EC firmware does not follow the new interface that
> >>> cros_ec_accel driver use.
> >>> Extend the legacy driver used on glimmer - Lenovo ThinkPad 11e
> >>> Chromebook - to veyron_minnie.
> >>> veyron_minnie being ARM based, issue command over the I2C bus to the =
EC
> >>> instead of relying on the shared registers over LPC.
> >>>
> >>> Gwendal Grignou (2):
> >>>   iio: cros_ec: Add sign vector in core for backward compatibility
> >>>   iio: cros_ec: Extend legacy support to ARM device
> >>>
> >>> Changes in v3:
> >>> - Fix commit message, add reviewed-by for first patch.
> >>>
> >>> Changes in v2:
> >>> - Readd empty line to reduce amount of change in patch.
> >>> - Remove Keywords used by ChromeOS commit queue.
> >>>
> >>>  drivers/iio/accel/Kconfig                     |   4 +-
> >>>  drivers/iio/accel/cros_ec_accel_legacy.c      | 350 ++++------------=
--
> >>>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +
> >>>  .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
> >>>  4 files changed, 84 insertions(+), 275 deletions(-)
> >>>    =20
> >>
> >> Just a side note that I think that this patch depends on [1] to have t=
he legacy
> >> sensors working on veyron minnie.
> >>
> >> For the full series:
> >>
> >> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com> =20
> > Ah. I was assuming you mean a runtime dependency.  Whereas applying this
> > on it's own is giving me a build problem:
> >=20
> >  drivers/iio/accel/cros_ec_accel_legacy.c: In function =E2=80=98cros_ec=
_accel_legacy_read_cmd=E2=80=99:
> > drivers/iio/accel/cros_ec_accel_legacy.c:50:16: error: =E2=80=98struct =
<anonymous>=E2=80=99 has no member named =E2=80=98max_sensor_count=E2=80=99=
 =20
>=20
> Right, this also build depends on the immutable branch (ib-mfd-cros-v5.3).
Ah. I'd forgotten about that set.

>=20
>=20
> >    50 |  st->param.dump.max_sensor_count =3D CROS_EC_SENSOR_LEGACY_NUM;
> >       |                ^
> > make[3]: *** [scripts/Makefile.build:285: drivers/iio/accel/cros_ec_acc=
el_legacy.o] Error 1
> > make[2]: *** [scripts/Makefile.build:489: drivers/iio/accel] Error 2
> > make[1]: *** [scripts/Makefile.build:489: drivers/iio] Error 2
> >=20
> > Which I'll assume is related to that other set.
> >=20
> > I'm happy for these to go another route to sit on top of that series.
> > If not I'll pick them up for the next cycle via IIO.
> >=20
> > Should they go another route,
> >=20
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for both of th=
em. =20
>=20
> I'd be happy to pick this patch and add to the chrome-platform tree, idea=
lly
> once we manage to get [1] ready for land.
Let's go with that.  If you change your mind, let me know.

Thanks,

Jonathan

>=20
> Thanks,
> ~ Enric
>=20
> >  =20
> >>
> >>
> >> [1] https://lkml.org/lkml/2019/6/18/268 =20
> >  =20

