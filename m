Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F38355D05B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiF0XOK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 19:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbiF0XOJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 19:14:09 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0E22BC2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 16:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656371641; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/NQhZf5rO+I7DdVtxW+DdaVCMBgcFmJi5YI6/9Il9k=;
        b=G7jwiDBud4LttlJfvPYJv2pkXbWm8rddscvB6UknAtxqlOpS/+fsnrpXB4XVB0UJYTeu8x
        VQsWmCPtpXyWf8EA77yTtnjxi4mZCiy/i8mA8KymGhdTl+cbkwRDdPqxy7ZykpZiOx4IIW
        X9wnaAgCsSNhK1hrOyGhIw+Liax3eHo=
Date:   Tue, 28 Jun 2022 00:13:45 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 00/36] IIO: switch easy cases to new simpler PM related
 macros.
To:     Jonathan Cameron <jic23@kernel.org>
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
        Nuno =?iso-8859-1?b?U+E=?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <XIS5ER.NROX8YVIQ1881@crapouillou.net>
In-Reply-To: <20220621202719.13644-1-jic23@kernel.org>
References: <20220621202719.13644-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Every patch looks fine to me, so:

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

for the whole series.

Cheers,
-Paul


Le mar., juin 21 2022 at 21:26:43 +0100, Jonathan Cameron=20
<jic23@kernel.org> a =E9crit :
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> After Paul's work [1] to cleanup us the PM related macros allow
> use of pm_ptr() and pm_sleep_ptr() making the compiler figure
> out what structures and functions can be dropped without=20
> __maybe_unused
> mess, I've been working through converting IIO.
> [1]=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/include/linux/pm.h?id=3Dc06ef740d401d0f4ab188882bf6f8d9cf0f75eaf
>=20
> This particular set is the low hanging fruit. The majority of
> the remainder in IIO require more thought because:
>=20
> 1) They only have runtime pm callbacks, but no sleep ones. Need to=20
> check
>    there is no reason we can't use use the force_runtime_suspend=20
> approach.
> 2) Odd cases like using same functions for sleep and runtime pm but=20
> not
>    via force runtime suspend.
> 3) Other weird corner cases where I want to take a closer look before
>    sending them out (I think some of them are buggy).
>=20
> Anyhow, whilst I've CC'd a lot of people I suspect some will no longer
> be active on these addresses - hence if anyone has time to look at a=20
> few
> patches rather than just the ones for drivers they maintain that would
> be much appreciated. In some cases I haven't CC'd anyone on a=20
> particular
> patch because I'm fairly sure the author is not longer at the same
> address. Any review of those ones in particular would be great.
>=20
> Thanks,
>=20
> Jonathan
>=20
> Jonathan Cameron (36):
>   iio: accel: bma220: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: adc: ad799x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: adc: at91-sam5d2:  Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: adc: imx7d_adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: adc: meson_saradc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: adc: mt6577_auxadc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: adc: stmpe-adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: adc: ti-am335x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: adc: xilinx-ams: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: chemical: scd4x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: dac: ds4424: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: dac: ltc1660: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: dac: max517: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: dac: max5821: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: dac: mcp4725: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: gyro: itg3200: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: health: afe4403: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: health: afe4404: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: light: al3010: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: light: al3320a: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: light: as73211: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: light: bh1750: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: light: cm3605: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: proximity: cros_ec_mkbp: Switch to DEFINE_SIMPLE_DEV_PM_OPS()=20
> and
>     pm_sleep_ptr()
>   iio: temperature: ltc2983: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
>     pm_sleep_ptr()
>   iio: light: us5182: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio: adc: imx8qxp: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
>   iio: light: gp2ap002: Switch to DEFINE_RUNTIME_DEV_PM_OPS and=20
> pm_ptr()
>   iio: light: isl29028: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
>   iio: light: tsl2583: Use DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
>   iio: light: tsl2591: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
>   iio: light: vcnl4000: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
>     macros
>   iio: light: vcnl4035: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
>     macros
>   iio: light: veml6030: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
>     macros
>   iio: magnetometer: ak8974: Use DEFINE_RUNTIME_DEV_PM_OPS() and
>     pm_ptr() macros
>   iio: magn: yas530: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()=20
> macros
>=20
>  drivers/iio/accel/bma220_spi.c                 |  8 ++++----
>  drivers/iio/adc/ad799x.c                       |  8 ++++----
>  drivers/iio/adc/at91-sama5d2_adc.c             |  9 +++++----
>  drivers/iio/adc/imx7d_adc.c                    |  5 +++--
>  drivers/iio/adc/imx8qxp-adc.c                  | 13 ++++++-------
>  drivers/iio/adc/meson_saradc.c                 | 10 +++++-----
>  drivers/iio/adc/mt6577_auxadc.c                | 12 ++++++------
>  drivers/iio/adc/stmpe-adc.c                    |  6 +++---
>  drivers/iio/adc/ti_am335x_adc.c                |  8 ++++----
>  drivers/iio/adc/xilinx-ams.c                   |  8 ++++----
>  drivers/iio/chemical/scd4x.c                   |  8 ++++----
>  drivers/iio/dac/ds4424.c                       |  8 ++++----
>  drivers/iio/dac/ltc1660.c                      |  9 +++++----
>  drivers/iio/dac/max517.c                       |  8 ++++----
>  drivers/iio/dac/max5821.c                      |  9 +++++----
>  drivers/iio/dac/mcp4725.c                      |  9 +++++----
>  drivers/iio/gyro/itg3200_core.c                |  9 +++++----
>  drivers/iio/health/afe4403.c                   |  9 +++++----
>  drivers/iio/health/afe4404.c                   |  9 +++++----
>  drivers/iio/light/al3010.c                     |  8 ++++----
>  drivers/iio/light/al3320a.c                    |  9 +++++----
>  drivers/iio/light/as73211.c                    |  9 +++++----
>  drivers/iio/light/bh1750.c                     |  6 +++---
>  drivers/iio/light/cm3605.c                     | 13 +++++--------
>  drivers/iio/light/gp2ap002.c                   | 14 +++++---------
>  drivers/iio/light/isl29028.c                   | 13 +++++--------
>  drivers/iio/light/tsl2583.c                    | 13 +++++--------
>  drivers/iio/light/tsl2591.c                    | 12 +++++-------
>  drivers/iio/light/us5182d.c                    |  8 +++-----
>  drivers/iio/light/vcnl4000.c                   | 14 +++++---------
>  drivers/iio/light/vcnl4035.c                   | 14 +++++---------
>  drivers/iio/light/veml6030.c                   | 14 +++++---------
>  drivers/iio/magnetometer/ak8974.c              | 14 +++++---------
>  drivers/iio/magnetometer/yamaha-yas530.c       | 14 +++++---------
>  drivers/iio/proximity/cros_ec_mkbp_proximity.c |  8 ++++----
>  drivers/iio/temperature/ltc2983.c              |  9 +++++----
>  36 files changed, 165 insertions(+), 192 deletions(-)
>=20
> --
> 2.36.1
>=20


