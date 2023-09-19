Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F367A6A30
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjISRvD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjISRu4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DA9F7
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierE-0006Jj-CX; Tue, 19 Sep 2023 19:49:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier4-007VVT-A1; Tue, 19 Sep 2023 19:49:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier3-0034WI-Qd; Tue, 19 Sep 2023 19:49:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        George Stark <gnstark@sberdevices.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        linux-amlogic@lists.infradead.org,
        Saravanan Sekar <sravanhome@gmail.com>,
        Jiakai Luo <jkluo@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        openbmc@lists.ozlabs.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Zhang Shurong <zhang_shurong@foxmail.com>,
        Yangtao Li <frank.li@vivo.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Sean Nyekjaer <sean@geanix.com>, Tom Rix <trix@redhat.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mark Brown <broonie@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-sunxi@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Peter Rosin <peda@axentia.se>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH 00/49] iio: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:42 +0200
Message-Id: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8269; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cuk3jxOiXgIUBikmjG+zsljm9zaWYjBmeiLtAd8rO9k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd7vIlP2VeriuGG1jpId5rgS1c3dyBe3FAkva bOz+Cms2ZmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQne7wAKCRCPgPtYfRL+ TsaKCACYcNf6TucJIdrcTmQocW5rXVUHd8FGg6zjf77q9iaRUcrRyMgufZi9kHX8CoIc2VNzbsv Sde9oTXarxauVNSU2DTuCbLLiugw9ge4kE3wo0PdLHL9coUwmk305A07oPwBGaGcdefyG/pv0mS 7mgPmofLk6Td5oOSGwnSqH4xwnrUxuSzcFX4MpqRhtkP32Fzg+DnME4I4s2cGFXTFIqg/vAGlsa Uwoc2RCCeY71MmhjdOQIxaY3AhrFWMB+ykVE9omgDbWdXlwtJTMvje2RVVEzY+gNAnN8MTMBoE4 21HS4CQJwqcc/GDvaxBw4owlQCUlt+760qbqOvyBf33TGiQz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

this series converts all platform drivers below drivers/iio to use
.remove_new(). The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side. As all platform drivers return zero unconditionally in their
remove callback up to now, the conversions are "trivial".

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

There are no interdependencies between the patches. As there are still
quite a few drivers to convert, I'm happy about every patch that makes
it in. So even if there is a merge conflict with one patch until you
apply or I picked a wrong subject prefix, please apply the remainder of
this series anyhow.

Best regards
Uwe

Uwe Kleine-König (49):
  iio: accel: hid-sensor-accel-3d: Convert to platform remove callback
    returning void
  iio: adc: ab8500-gpadc: Convert to platform remove callback returning
    void
  iio: adc: at91-sama5d2: Convert to platform remove callback returning
    void
  iio: adc: at91: Convert to platform remove callback returning void
  iio: adc: axp20x: Convert to platform remove callback returning void
  iio: adc: bcm_iproc: Convert to platform remove callback returning
    void
  iio: adc: dln2: Convert to platform remove callback returning void
  iio: adc: ep93xx: Convert to platform remove callback returning void
  iio: adc: exynos: Convert to platform remove callback returning void
  iio: adc: fsl-imx25-gcq: Convert to platform remove callback returning
    void
  iio: adc: hx711: Convert to platform remove callback returning void
  iio: adc: imx8qxp: Convert to platform remove callback returning void
  iio: adc: imx93: Convert to platform remove callback returning void
  iio: adc: meson_saradc: Convert to platform remove callback returning
    void
  iio: adc: mp2629: Convert to platform remove callback returning void
  iio: adc: mxs-lradc: Convert to platform remove callback returning
    void
  iio: adc: npcm: Convert to platform remove callback returning void
  iio: adc: qcom-pm8xxx-xoadc: Convert to platform remove callback
    returning void
  iio: adc: rcar-gyroadc: Convert to platform remove callback returning
    void
  iio: adc: stm32-adc-core: Convert to platform remove callback
    returning void
  iio: adc: stm32-adc: Convert to platform remove callback returning
    void
  iio: adc: stm32-dfsdm-adc: Convert to platform remove callback
    returning void
  iio: adc: stm32-dfsdm-core: Convert to platform remove callback
    returning void
  iio: adc: sun4i-gpadc-iio: Convert to platform remove callback
    returning void
  iio: adc: ti_am335x_adc: Convert to platform remove callback returning
    void
  iio: adc: twl4030-madc: Convert to platform remove callback returning
    void
  iio: adc: twl6030-gpadc: Convert to platform remove callback returning
    void
  iio: adc: vf610_adc: Convert to platform remove callback returning
    void
  iio: dac: dpot-dac: Convert to platform remove callback returning void
  iio: dac: lpc18xx_dac: Convert to platform remove callback returning
    void
  iio: dac: stm32-dac-core: Convert to platform remove callback
    returning void
  iio: dac: stm32-dac: Convert to platform remove callback returning
    void
  iio: dac: vf610: Convert to platform remove callback returning void
  iio: gyro: hid-sensor-gyro-3d: Convert to platform remove callback
    returning void
  iio: humidity: hid-sensor-humidity: Convert to platform remove
    callback returning void
  iio: light: cm3605: Convert to platform remove callback returning void
  iio: light: hid-sensor-als: Convert to platform remove callback
    returning void
  iio: light: hid-sensor-prox: Convert to platform remove callback
    returning void
  iio: light: lm3533-als: Convert to platform remove callback returning
    void
  iio: magnetometer: hid-sensor-magn-3d: Convert to platform remove
    callback returning void
  iio: orientation: hid-sensor-incl-3d: Convert to platform remove
    callback returning void
  iio: orientation: hid-sensor-rotation: Convert to platform remove
    callback returning void
  iio: position: hid-sensor-custom-intel-hinge: Convert to platform
    remove callback returning void
  iio: pressure: hid-sensor: Convert to platform remove callback
    returning void
  iio: proximity: cros_ec_mkbp: Convert to platform remove callback
    returning void
  iio: proximity: srf04: Convert to platform remove callback returning
    void
  iio: temperature: hid-sensor: Convert to platform remove callback
    returning void
  iio: trigger: iio-trig-interrupt: Convert to platform remove callback
    returning void
  iio: trigger: stm32-timer: Convert to platform remove callback
    returning void

 drivers/iio/accel/hid-sensor-accel-3d.c              | 6 ++----
 drivers/iio/adc/ab8500-gpadc.c                       | 6 ++----
 drivers/iio/adc/at91-sama5d2_adc.c                   | 6 ++----
 drivers/iio/adc/at91_adc.c                           | 6 ++----
 drivers/iio/adc/axp20x_adc.c                         | 6 ++----
 drivers/iio/adc/bcm_iproc_adc.c                      | 6 ++----
 drivers/iio/adc/dln2-adc.c                           | 5 ++---
 drivers/iio/adc/ep93xx_adc.c                         | 6 ++----
 drivers/iio/adc/exynos_adc.c                         | 6 ++----
 drivers/iio/adc/fsl-imx25-gcq.c                      | 6 ++----
 drivers/iio/adc/hx711.c                              | 6 ++----
 drivers/iio/adc/imx8qxp-adc.c                        | 6 ++----
 drivers/iio/adc/imx93_adc.c                          | 6 ++----
 drivers/iio/adc/meson_saradc.c                       | 6 ++----
 drivers/iio/adc/mp2629_adc.c                         | 6 ++----
 drivers/iio/adc/mxs-lradc-adc.c                      | 6 ++----
 drivers/iio/adc/npcm_adc.c                           | 6 ++----
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                  | 6 ++----
 drivers/iio/adc/rcar-gyroadc.c                       | 6 ++----
 drivers/iio/adc/stm32-adc-core.c                     | 6 ++----
 drivers/iio/adc/stm32-adc.c                          | 6 ++----
 drivers/iio/adc/stm32-dfsdm-adc.c                    | 6 ++----
 drivers/iio/adc/stm32-dfsdm-core.c                   | 6 ++----
 drivers/iio/adc/sun4i-gpadc-iio.c                    | 8 +++-----
 drivers/iio/adc/ti_am335x_adc.c                      | 6 ++----
 drivers/iio/adc/twl4030-madc.c                       | 6 ++----
 drivers/iio/adc/twl6030-gpadc.c                      | 6 ++----
 drivers/iio/adc/vf610_adc.c                          | 6 ++----
 drivers/iio/dac/dpot-dac.c                           | 6 ++----
 drivers/iio/dac/lpc18xx_dac.c                        | 6 ++----
 drivers/iio/dac/stm32-dac-core.c                     | 6 ++----
 drivers/iio/dac/stm32-dac.c                          | 6 ++----
 drivers/iio/dac/vf610_dac.c                          | 6 ++----
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 6 ++----
 drivers/iio/humidity/hid-sensor-humidity.c           | 6 ++----
 drivers/iio/light/cm3605.c                           | 6 ++----
 drivers/iio/light/hid-sensor-als.c                   | 6 ++----
 drivers/iio/light/hid-sensor-prox.c                  | 6 ++----
 drivers/iio/light/lm3533-als.c                       | 6 ++----
 drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 6 ++----
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 6 ++----
 drivers/iio/orientation/hid-sensor-rotation.c        | 6 ++----
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 6 ++----
 drivers/iio/pressure/hid-sensor-press.c              | 6 ++----
 drivers/iio/proximity/cros_ec_mkbp_proximity.c       | 6 ++----
 drivers/iio/proximity/srf04.c                        | 6 ++----
 drivers/iio/temperature/hid-sensor-temperature.c     | 6 ++----
 drivers/iio/trigger/iio-trig-interrupt.c             | 6 ++----
 drivers/iio/trigger/stm32-timer-trigger.c            | 6 ++----
 49 files changed, 99 insertions(+), 196 deletions(-)


base-commit: 29e400e3ea486bf942b214769fc9778098114113
-- 
2.40.1

