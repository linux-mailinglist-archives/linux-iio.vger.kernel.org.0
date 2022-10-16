Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8446600158
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJPQdz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJPQdy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:33:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1E32051
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 013E4B80CD9
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41A7C433C1;
        Sun, 16 Oct 2022 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938030;
        bh=isFHu2/ita8FShRHPIZPZBmsA1N1GUXjD3akqiSbFOg=;
        h=From:To:Cc:Subject:Date:From;
        b=KyI3x+6+FAHpW26/9pe7ds6rM79R2z0RB/G1Pu0z1tlZoDYmfb++m8XlXXIXAoQ15
         NfapUGlx+jhSx2t7q9b+XXnhqGCsXayrsXLdeAkhjIYiZoIjduzx/HOOflU5vUUDy/
         9987aTDJxiBqpJrP0zbLTQOHqN4Xzc10qBfE5G25SfayrKkUwZwgUsolWx7yi/EYpL
         c8mT4/QWhWWmwzVIAkPSmMXqdNdrjX5cib1EDM0PUoEDPG0fe3tJGKcaYSduDvnl6w
         o2QGCfKYhCKScdyIVAc1YauUgfWonS1PbrFzEMukMN4Hx+ngIMbgfUuD9dmye+kivt
         0LsXaF5eb8EwA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/14] IIO: More devm_regulator[_bulk]_get_enable() users
Date:   Sun, 16 Oct 2022 17:33:55 +0100
Message-Id: <20221016163409.320197-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also one general devm conversion that was too easy to ignore after
dealing with the regulators.

These new macros allow dropping of some boilerplate.  They are not
useful in many cases in IIO because they do not expose the
struct regulator, however for simple drivers that just turn the power
on at probe() they ensure that it is turned off again at remove.

Jonathan Cameron (14):
  iio: accel: adxl367: Use devm_regulator_bulk_get_enable()
  iio: accel: bma400: Use devm_regulator_bulk_get_enable()
  iio: accel: fxls8962af: Use devm_regulator_get_enable()
  iio: accel: kxcjk-1013: Use devm_regulator_bulk_get_enable()
  iio: accel: msa311: Use devm_regulator_get_enable()
  iio: cdc: ad7150: Use devm_regulator_get_enable()
  iio: st_sensors: core and lsm9ds0 switch to
    devm_regulator_bulk_get_enable()
  iio: frequency: ad9523: Use devm_regulator_get_enable()
  iio: humidity: hts211: Use devm_regulator_get_enable()
  iio: light: ltr501: Use devm_regulator_bulk_get_enable()
  iio: light: noa1305: Use devm_regulator_get_enable()
  iio: proximity: sx_common: Use devm_regulator_bulk_get_enable()
  iio: pressure: ms5611: Use devm_regulator_get_enable()
  iio: pressure: ms5611: Switch to fully devm_ managed registration.

 drivers/iio/accel/adxl367.c                   | 28 ++------
 drivers/iio/accel/bma400.h                    |  4 --
 drivers/iio/accel/bma400_core.c               | 29 ++-------
 drivers/iio/accel/fxls8962af-core.c           | 24 +------
 drivers/iio/accel/kxcjk-1013.c                | 25 ++-----
 drivers/iio/accel/msa311.c                    | 21 +-----
 drivers/iio/cdc/ad7150.c                      | 18 +----
 .../iio/common/st_sensors/st_sensors_core.c   | 39 ++---------
 drivers/iio/frequency/ad9523.c                | 22 +------
 drivers/iio/humidity/hts221.h                 |  2 -
 drivers/iio/humidity/hts221_core.c            | 27 ++------
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  | 65 ++-----------------
 drivers/iio/light/ltr501.c                    | 27 ++------
 drivers/iio/light/noa1305.c                   | 26 +-------
 drivers/iio/pressure/ms5611.h                 |  4 --
 drivers/iio/pressure/ms5611_core.c            | 49 +++-----------
 drivers/iio/pressure/ms5611_i2c.c             |  6 --
 drivers/iio/pressure/ms5611_spi.c             |  6 --
 drivers/iio/proximity/sx_common.c             | 23 +------
 drivers/iio/proximity/sx_common.h             |  2 -
 include/linux/iio/common/st_sensors.h         |  4 --
 21 files changed, 57 insertions(+), 394 deletions(-)

-- 
2.37.2

