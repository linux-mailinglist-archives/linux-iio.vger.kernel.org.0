Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A364A578898
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 19:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiGRRj2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbiGRRj1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 13:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991BA220E6
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 10:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 212D9615A0
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 17:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C6AC341C0;
        Mon, 18 Jul 2022 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658165965;
        bh=dfO04JqHcehFGdvHYYaw2A75Z3sfjV3iIo9otlH9wrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s4ipda9IXHSEWRRLZqtpV9U9cF9XjX7oCHBt/8WlqPpvXyd/1JM/qXaXADZ63xbDz
         0ZO4NCDJCVuVurIQRcMeDyRj9YQSefuLDdAA3FMnGdcA8oT5qxqABOX9q6uNtF1kWr
         VApftZA0PHzpD9mgKnRgZwmbrWJJs0pD3QYJRgrPdPirnfgXhR0CEOBPG78XDQE/a9
         bEpWTy8AyXAThYOUH079nnVeDvCQn0e5Hj5jx/ukqg+ncakxEdBusOIHZ93sVCVP91
         +Tx0+hnlXSpdDDAmMC2lVyU2DlFglKsMpe0WwG3yqHaiux1tHYy152uPUKNi7Adwgc
         tUMIWi1tNF0FA==
Date:   Mon, 18 Jul 2022 18:49:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-iio@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/36] IIO: switch easy cases to new simpler PM related
 macros.
Message-ID: <20220718184915.65a95a7d@jic23-huawei>
In-Reply-To: <XIS5ER.NROX8YVIQ1881@crapouillou.net>
References: <20220621202719.13644-1-jic23@kernel.org>
        <XIS5ER.NROX8YVIQ1881@crapouillou.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jun 2022 00:13:45 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
>=20
> Every patch looks fine to me, so:
>=20
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Thanks!

Series applied to the togreg branch of iio.git and pushed out as
testing for a very brief exposure to 0-day before letting next see
them.

Thanks,

Jonathan

>=20
> for the whole series.
>=20
> Cheers,
> -Paul
>=20
>=20
> Le mar., juin 21 2022 at 21:26:43 +0100, Jonathan Cameron=20
> <jic23@kernel.org> a =C3=A9crit :
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > After Paul's work [1] to cleanup us the PM related macros allow
> > use of pm_ptr() and pm_sleep_ptr() making the compiler figure
> > out what structures and functions can be dropped without=20
> > __maybe_unused
> > mess, I've been working through converting IIO.
> > [1]=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/include/linux/pm.h?id=3Dc06ef740d401d0f4ab188882bf6f8d9cf0f75eaf
> >=20
> > This particular set is the low hanging fruit. The majority of
> > the remainder in IIO require more thought because:
> >=20
> > 1) They only have runtime pm callbacks, but no sleep ones. Need to=20
> > check
> >    there is no reason we can't use use the force_runtime_suspend=20
> > approach.
> > 2) Odd cases like using same functions for sleep and runtime pm but=20
> > not
> >    via force runtime suspend.
> > 3) Other weird corner cases where I want to take a closer look before
> >    sending them out (I think some of them are buggy).
> >=20
> > Anyhow, whilst I've CC'd a lot of people I suspect some will no longer
> > be active on these addresses - hence if anyone has time to look at a=20
> > few
> > patches rather than just the ones for drivers they maintain that would
> > be much appreciated. In some cases I haven't CC'd anyone on a=20
> > particular
> > patch because I'm fairly sure the author is not longer at the same
> > address. Any review of those ones in particular would be great.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> > Jonathan Cameron (36):
> >   iio: accel: bma220: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: adc: ad799x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: adc: at91-sam5d2:  Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: adc: imx7d_adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: adc: meson_saradc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: adc: mt6577_auxadc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: adc: stmpe-adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: adc: ti-am335x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: adc: xilinx-ams: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: chemical: scd4x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: dac: ds4424: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: dac: ltc1660: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: dac: max517: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: dac: max5821: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: dac: mcp4725: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: gyro: itg3200: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: health: afe4403: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: health: afe4404: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: light: al3010: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: light: al3320a: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: light: as73211: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: light: bh1750: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: light: cm3605: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: proximity: cros_ec_mkbp: Switch to DEFINE_SIMPLE_DEV_PM_OPS()=20
> > and
> >     pm_sleep_ptr()
> >   iio: temperature: ltc2983: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
> >     pm_sleep_ptr()
> >   iio: light: us5182: Switch from CONFIG_PM guards to pm_ptr() etc
> >   iio: adc: imx8qxp: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
> >   iio: light: gp2ap002: Switch to DEFINE_RUNTIME_DEV_PM_OPS and=20
> > pm_ptr()
> >   iio: light: isl29028: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
> >   iio: light: tsl2583: Use DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
> >   iio: light: tsl2591: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
> >   iio: light: vcnl4000: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
> >     macros
> >   iio: light: vcnl4035: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
> >     macros
> >   iio: light: veml6030: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
> >     macros
> >   iio: magnetometer: ak8974: Use DEFINE_RUNTIME_DEV_PM_OPS() and
> >     pm_ptr() macros
> >   iio: magn: yas530: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()=20
> > macros
> >=20
> >  drivers/iio/accel/bma220_spi.c                 |  8 ++++----
> >  drivers/iio/adc/ad799x.c                       |  8 ++++----
> >  drivers/iio/adc/at91-sama5d2_adc.c             |  9 +++++----
> >  drivers/iio/adc/imx7d_adc.c                    |  5 +++--
> >  drivers/iio/adc/imx8qxp-adc.c                  | 13 ++++++-------
> >  drivers/iio/adc/meson_saradc.c                 | 10 +++++-----
> >  drivers/iio/adc/mt6577_auxadc.c                | 12 ++++++------
> >  drivers/iio/adc/stmpe-adc.c                    |  6 +++---
> >  drivers/iio/adc/ti_am335x_adc.c                |  8 ++++----
> >  drivers/iio/adc/xilinx-ams.c                   |  8 ++++----
> >  drivers/iio/chemical/scd4x.c                   |  8 ++++----
> >  drivers/iio/dac/ds4424.c                       |  8 ++++----
> >  drivers/iio/dac/ltc1660.c                      |  9 +++++----
> >  drivers/iio/dac/max517.c                       |  8 ++++----
> >  drivers/iio/dac/max5821.c                      |  9 +++++----
> >  drivers/iio/dac/mcp4725.c                      |  9 +++++----
> >  drivers/iio/gyro/itg3200_core.c                |  9 +++++----
> >  drivers/iio/health/afe4403.c                   |  9 +++++----
> >  drivers/iio/health/afe4404.c                   |  9 +++++----
> >  drivers/iio/light/al3010.c                     |  8 ++++----
> >  drivers/iio/light/al3320a.c                    |  9 +++++----
> >  drivers/iio/light/as73211.c                    |  9 +++++----
> >  drivers/iio/light/bh1750.c                     |  6 +++---
> >  drivers/iio/light/cm3605.c                     | 13 +++++--------
> >  drivers/iio/light/gp2ap002.c                   | 14 +++++---------
> >  drivers/iio/light/isl29028.c                   | 13 +++++--------
> >  drivers/iio/light/tsl2583.c                    | 13 +++++--------
> >  drivers/iio/light/tsl2591.c                    | 12 +++++-------
> >  drivers/iio/light/us5182d.c                    |  8 +++-----
> >  drivers/iio/light/vcnl4000.c                   | 14 +++++---------
> >  drivers/iio/light/vcnl4035.c                   | 14 +++++---------
> >  drivers/iio/light/veml6030.c                   | 14 +++++---------
> >  drivers/iio/magnetometer/ak8974.c              | 14 +++++---------
> >  drivers/iio/magnetometer/yamaha-yas530.c       | 14 +++++---------
> >  drivers/iio/proximity/cros_ec_mkbp_proximity.c |  8 ++++----
> >  drivers/iio/temperature/ltc2983.c              |  9 +++++----
> >  36 files changed, 165 insertions(+), 192 deletions(-)
> >=20
> > --
> > 2.36.1
> >  =20
>=20
>=20

