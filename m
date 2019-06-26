Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF357176
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFZTVJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZTVI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 15:21:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B38208E3;
        Wed, 26 Jun 2019 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561576868;
        bh=MeUtiuq80Z0XHGc2cI3QcUP4twkdPZotPLeqSG+0VvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XBeVSqb3Ui14OL0VzT6ePpOYQxsNi3VBOhz8uJJQYuE+OxmmwASDuHezJBB+QtGvS
         GIZekyIrkKrykiDBQyVo9xN/Ky/d6S9QLrup9CO4iyF4VLLYyCa/AO49IfAB8t+/je
         PDlUnW3CV3lZ7/0XY2ymwXfCOoYbN2MNmy53fx6c=
Date:   Wed, 26 Jun 2019 20:21:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        dianders@chromium.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Support accelerometers for veyron_minnie
Message-ID: <20190626202103.07e27e5e@archlinux>
In-Reply-To: <5326bfb8-611f-765b-1c9c-c95032102c71@collabora.com>
References: <20190624225312.131745-1-gwendal@chromium.org>
        <5326bfb8-611f-765b-1c9c-c95032102c71@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jun 2019 19:09:50 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi,
>=20
> On 25/6/19 0:53, Gwendal Grignou wrote:
> > veyron_minnie - ASUS Chromebook Flip C100PA - embedded controller
> > controls two accelerometers, one in the lid, one in the base.
> > However, the EC firmware does not follow the new interface that
> > cros_ec_accel driver use.
> > Extend the legacy driver used on glimmer - Lenovo ThinkPad 11e
> > Chromebook - to veyron_minnie.
> > veyron_minnie being ARM based, issue command over the I2C bus to the EC
> > instead of relying on the shared registers over LPC.
> >=20
> > Gwendal Grignou (2):
> >   iio: cros_ec: Add sign vector in core for backward compatibility
> >   iio: cros_ec: Extend legacy support to ARM device
> >=20
> > Changes in v3:
> > - Fix commit message, add reviewed-by for first patch.
> >=20
> > Changes in v2:
> > - Readd empty line to reduce amount of change in patch.
> > - Remove Keywords used by ChromeOS commit queue.
> >=20
> >  drivers/iio/accel/Kconfig                     |   4 +-
> >  drivers/iio/accel/cros_ec_accel_legacy.c      | 350 ++++--------------
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +
> >  .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
> >  4 files changed, 84 insertions(+), 275 deletions(-)
> >  =20
>=20
> Just a side note that I think that this patch depends on [1] to have the =
legacy
> sensors working on veyron minnie.
>=20
> For the full series:
>=20
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Ah. I was assuming you mean a runtime dependency.  Whereas applying this
on it's own is giving me a build problem:

 drivers/iio/accel/cros_ec_accel_legacy.c: In function =E2=80=98cros_ec_acc=
el_legacy_read_cmd=E2=80=99:
drivers/iio/accel/cros_ec_accel_legacy.c:50:16: error: =E2=80=98struct <ano=
nymous>=E2=80=99 has no member named =E2=80=98max_sensor_count=E2=80=99
   50 |  st->param.dump.max_sensor_count =3D CROS_EC_SENSOR_LEGACY_NUM;
      |                ^
make[3]: *** [scripts/Makefile.build:285: drivers/iio/accel/cros_ec_accel_l=
egacy.o] Error 1
make[2]: *** [scripts/Makefile.build:489: drivers/iio/accel] Error 2
make[1]: *** [scripts/Makefile.build:489: drivers/iio] Error 2

Which I'll assume is related to that other set.

I'm happy for these to go another route to sit on top of that series.
If not I'll pick them up for the next cycle via IIO.

Should they go another route,

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for both of them.

>=20
>=20
> [1] https://lkml.org/lkml/2019/6/18/268

