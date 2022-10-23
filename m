Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679C6609333
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJWNC5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiJWNCz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0FF70E62
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE6AF60DFD
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 13:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79898C433D6;
        Sun, 23 Oct 2022 13:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666530173;
        bh=arCYzP7tVYanF/qwh+Tdl2nT132u6js9dQkky3unc3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oL0EhtblIkYyLw3C1T4RlV7KBNwzkzAHDA9kzvDtCNF+UPJGVGwY6j6VIf/c5wfmr
         vgzzIxNJk/BoJvdnZ3qdLquW4bICUe24h4PDTXG+z3P6ddV3rkWSJ4dt6bZjrx/9Tv
         sw1Dy24Vk9bWPQ4+sxLXCSlJ5dle5OnHB14WjMkfTjnwG/mj7NGM3cCWVh+MHUzJbn
         6rXNJGUz3HWdJoLoaqW9l35Fh8udcGAEV91z0xIXRz4gBPn+E4zZ3kLJ2bhXOjJtk6
         1BwvJD7Kl6jR63tVwc1sMwgxuBF5BTOtcbfnhsnn5F4iQ6D7V6PvQxp6LbNiKJEejS
         6CUJv8++PG9cw==
Date:   Sun, 23 Oct 2022 14:03:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/14] IIO: More devm_regulator[_bulk]_get_enable()
 users
Message-ID: <20221023140326.19f7d5ea@jic23-huawei>
In-Reply-To: <SJ0PR03MB6778419C9CE3DC0C5DF33BDF99299@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221016163409.320197-1-jic23@kernel.org>
        <SJ0PR03MB6778419C9CE3DC0C5DF33BDF99299@SJ0PR03MB6778.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Oct 2022 11:27:18 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, October 16, 2022 6:34 PM
> > To: linux-iio@vger.kernel.org
> > Cc: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> > <matti.vaittinen@fi.rohmeurope.com>; Tanislav, Cosmin
> > <Cosmin.Tanislav@analog.com>; Jagath Jog J <jagathjog1996@gmail.com>;
> > Sean Nyekjaer <sean@geanix.com>; Dmitry Rokosov
> > <DDRokosov@sberdevices.ru>; Linus Walleij <linus.walleij@linaro.org>;
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Hennerich,
> > Michael <Michael.Hennerich@analog.com>; Lorenzo Bianconi
> > <lorenzo@kernel.org>; Martyn Welch <martyn.welch@collabora.com>;
> > Gwendal Grignou <gwendal@chromium.org>; Stephen Boyd
> > <swboyd@chromium.org>; Tomasz Duszynski <tduszyns@gmail.com>;
> > Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Subject: [PATCH 00/14] IIO: More devm_regulator[_bulk]_get_enable()
> > users
> >=20
> > [External]
> >=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Also one general devm conversion that was too easy to ignore after
> > dealing with the regulators.
> >=20
> > These new macros allow dropping of some boilerplate.  They are not
> > useful in many cases in IIO because they do not expose the
> > struct regulator, however for simple drivers that just turn the power
> > on at probe() they ensure that it is turned off again at remove.
> >=20
> > Jonathan Cameron (14):
> >   iio: accel: adxl367: Use devm_regulator_bulk_get_enable()
> >   iio: accel: bma400: Use devm_regulator_bulk_get_enable()
> >   iio: accel: fxls8962af: Use devm_regulator_get_enable()
> >   iio: accel: kxcjk-1013: Use devm_regulator_bulk_get_enable()
> >   iio: accel: msa311: Use devm_regulator_get_enable()
> >   iio: cdc: ad7150: Use devm_regulator_get_enable()
> >   iio: st_sensors: core and lsm9ds0 switch to
> >     devm_regulator_bulk_get_enable()
> >   iio: frequency: ad9523: Use devm_regulator_get_enable()
> >   iio: humidity: hts211: Use devm_regulator_get_enable()
> >   iio: light: ltr501: Use devm_regulator_bulk_get_enable()
> >   iio: light: noa1305: Use devm_regulator_get_enable()
> >   iio: proximity: sx_common: Use devm_regulator_bulk_get_enable()
> >   iio: pressure: ms5611: Use devm_regulator_get_enable()
> >   iio: pressure: ms5611: Switch to fully devm_ managed registration.
> >=20
> >  drivers/iio/accel/adxl367.c                   | 28 ++------
> >  drivers/iio/accel/bma400.h                    |  4 --
> >  drivers/iio/accel/bma400_core.c               | 29 ++-------
> >  drivers/iio/accel/fxls8962af-core.c           | 24 +------
> >  drivers/iio/accel/kxcjk-1013.c                | 25 ++-----
> >  drivers/iio/accel/msa311.c                    | 21 +-----
> >  drivers/iio/cdc/ad7150.c                      | 18 +----
> >  .../iio/common/st_sensors/st_sensors_core.c   | 39 ++---------
> >  drivers/iio/frequency/ad9523.c                | 22 +------
> >  drivers/iio/humidity/hts221.h                 |  2 -
> >  drivers/iio/humidity/hts221_core.c            | 27 ++------
> >  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  | 65 ++-----------------
> >  drivers/iio/light/ltr501.c                    | 27 ++------
> >  drivers/iio/light/noa1305.c                   | 26 +-------
> >  drivers/iio/pressure/ms5611.h                 |  4 --
> >  drivers/iio/pressure/ms5611_core.c            | 49 +++-----------
> >  drivers/iio/pressure/ms5611_i2c.c             |  6 --
> >  drivers/iio/pressure/ms5611_spi.c             |  6 --
> >  drivers/iio/proximity/sx_common.c             | 23 +------
> >  drivers/iio/proximity/sx_common.h             |  2 -
> >  include/linux/iio/common/st_sensors.h         |  4 --
> >  21 files changed, 57 insertions(+), 394 deletions(-)
> >=20
> > --
> > 2.37.2 =20
>=20
> For all patches but patch 13/14,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> For that one, you can add my tag after addressing Matti's comment.
Tweaked the patch description on that one. The other comment is covered
in patch 14 as Matti observed in response to that one.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

>=20
> - Nuno S=C3=A1

