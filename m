Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A205553B56
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352707AbiFUUSJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiFUUSI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:18:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AA0BDA
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329B8617DE
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0986C3411C;
        Tue, 21 Jun 2022 20:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842686;
        bh=bbw+AuXrecw6FIeSykdkgV+JMeRrbT+pDW+1BVH/6S0=;
        h=From:To:Cc:Subject:Date:From;
        b=I3PAS5OMpZ/SjHoIr4juXhheie1XkUK+KIaX8/EIwLVv2cK77d+G1qLRY/ZTG/OLw
         A4rYHsA57XR/lc/mEZAgOpq2enhchlmzFoLhp3hvcSbShm5gisMq4bxGwIK/ggXiuL
         kGfo0ZwUDpYOryCIEVsY/nqtal8k72loL+RkqCUz0k17zqPPsQAQZGLecSiBe2vn0c
         1DvcUSTqXZ8eA12yxgTBu4zUswY4Dc9ZDsb0TcZTeRviHk1O1UiUuo0wl+24wJva0c
         M56mRbF72wEvo3xcx4tjQtso2nygTDUpOJH7piDcDP+N1X7uDi0YeLQAH2v3opBUEw
         lM+/dvwZPZqXg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/36] IIO: switch easy cases to new simpler PM related macros.
Date:   Tue, 21 Jun 2022 21:26:43 +0100
Message-Id: <20220621202719.13644-1-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

After Paul's work [1] to cleanup us the PM related macros allow
use of pm_ptr() and pm_sleep_ptr() making the compiler figure
out what structures and functions can be dropped without __maybe_unused
mess, I've been working through converting IIO.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/pm.h?id=c06ef740d401d0f4ab188882bf6f8d9cf0f75eaf

This particular set is the low hanging fruit. The majority of
the remainder in IIO require more thought because:

1) They only have runtime pm callbacks, but no sleep ones. Need to check
   there is no reason we can't use use the force_runtime_suspend approach.
2) Odd cases like using same functions for sleep and runtime pm but not
   via force runtime suspend.
3) Other weird corner cases where I want to take a closer look before
   sending them out (I think some of them are buggy).

Anyhow, whilst I've CC'd a lot of people I suspect some will no longer
be active on these addresses - hence if anyone has time to look at a few
patches rather than just the ones for drivers they maintain that would
be much appreciated. In some cases I haven't CC'd anyone on a particular
patch because I'm fairly sure the author is not longer at the same
address. Any review of those ones in particular would be great.

Thanks,

Jonathan

Jonathan Cameron (36):
  iio: accel: bma220: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: adc: ad799x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: adc: at91-sam5d2:  Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: adc: imx7d_adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: adc: meson_saradc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: adc: mt6577_auxadc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: adc: stmpe-adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: adc: ti-am335x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: adc: xilinx-ams: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: chemical: scd4x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: dac: ds4424: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: dac: ltc1660: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: dac: max517: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: dac: max5821: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: dac: mcp4725: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: gyro: itg3200: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: health: afe4403: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: health: afe4404: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: light: al3010: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: light: al3320a: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: light: as73211: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: light: bh1750: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: light: cm3605: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: proximity: cros_ec_mkbp: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: temperature: ltc2983: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and
    pm_sleep_ptr()
  iio: light: us5182: Switch from CONFIG_PM guards to pm_ptr() etc
  iio: adc: imx8qxp: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
  iio: light: gp2ap002: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
  iio: light: isl29028: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
  iio: light: tsl2583: Use DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
  iio: light: tsl2591: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
  iio: light: vcnl4000: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
    macros
  iio: light: vcnl4035: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
    macros
  iio: light: veml6030: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
    macros
  iio: magnetometer: ak8974: Use DEFINE_RUNTIME_DEV_PM_OPS() and
    pm_ptr() macros
  iio: magn: yas530: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros

 drivers/iio/accel/bma220_spi.c                 |  8 ++++----
 drivers/iio/adc/ad799x.c                       |  8 ++++----
 drivers/iio/adc/at91-sama5d2_adc.c             |  9 +++++----
 drivers/iio/adc/imx7d_adc.c                    |  5 +++--
 drivers/iio/adc/imx8qxp-adc.c                  | 13 ++++++-------
 drivers/iio/adc/meson_saradc.c                 | 10 +++++-----
 drivers/iio/adc/mt6577_auxadc.c                | 12 ++++++------
 drivers/iio/adc/stmpe-adc.c                    |  6 +++---
 drivers/iio/adc/ti_am335x_adc.c                |  8 ++++----
 drivers/iio/adc/xilinx-ams.c                   |  8 ++++----
 drivers/iio/chemical/scd4x.c                   |  8 ++++----
 drivers/iio/dac/ds4424.c                       |  8 ++++----
 drivers/iio/dac/ltc1660.c                      |  9 +++++----
 drivers/iio/dac/max517.c                       |  8 ++++----
 drivers/iio/dac/max5821.c                      |  9 +++++----
 drivers/iio/dac/mcp4725.c                      |  9 +++++----
 drivers/iio/gyro/itg3200_core.c                |  9 +++++----
 drivers/iio/health/afe4403.c                   |  9 +++++----
 drivers/iio/health/afe4404.c                   |  9 +++++----
 drivers/iio/light/al3010.c                     |  8 ++++----
 drivers/iio/light/al3320a.c                    |  9 +++++----
 drivers/iio/light/as73211.c                    |  9 +++++----
 drivers/iio/light/bh1750.c                     |  6 +++---
 drivers/iio/light/cm3605.c                     | 13 +++++--------
 drivers/iio/light/gp2ap002.c                   | 14 +++++---------
 drivers/iio/light/isl29028.c                   | 13 +++++--------
 drivers/iio/light/tsl2583.c                    | 13 +++++--------
 drivers/iio/light/tsl2591.c                    | 12 +++++-------
 drivers/iio/light/us5182d.c                    |  8 +++-----
 drivers/iio/light/vcnl4000.c                   | 14 +++++---------
 drivers/iio/light/vcnl4035.c                   | 14 +++++---------
 drivers/iio/light/veml6030.c                   | 14 +++++---------
 drivers/iio/magnetometer/ak8974.c              | 14 +++++---------
 drivers/iio/magnetometer/yamaha-yas530.c       | 14 +++++---------
 drivers/iio/proximity/cros_ec_mkbp_proximity.c |  8 ++++----
 drivers/iio/temperature/ltc2983.c              |  9 +++++----
 36 files changed, 165 insertions(+), 192 deletions(-)

-- 
2.36.1

