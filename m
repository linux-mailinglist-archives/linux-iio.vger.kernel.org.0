Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374A1482B1F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiABMu4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:50:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50042 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiABMuz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:50:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57DCDB80D61
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B900DC36AEE;
        Sun,  2 Jan 2022 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127853;
        bh=2v9lfT36H8aYFxQyJs0lHyNgZmyubOYtuY2vHkYuPs4=;
        h=From:To:Cc:Subject:Date:From;
        b=iSBs64KcGtcP5s1lgjViZH2f21ev9Wnd5D/idYQvEmuC4K06A6tjAWuoCzXVwIKt9
         BL6/U1X+VR2eDyCMqiAZIliSIl+b56HyyHbQpS6x1hv9tQ+Jtz9JPEyDfMHWrhmEMX
         JdwuS/j3JnMhn1kUP3yx2LwWvCyfuZ33WbvW+UFWZWO0NAnWlye4hdbhD0zRFoGELY
         vdkOJ6oY5lpsmSkuB9S7Fgsc8GX3nwkDDpkLpi5Nh45ts0f8oKj6kRXURSm08vtchF
         JjubsqhrZx1AyU4OCgtXx04Bo9qpMUDlh74nC2cES8lqfR6RQoY7kdHT5sOm6YCQP+
         f6PZKfZZmNT+A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anson Huang <anson.huang@nxp.com>,
        Brian Masney <masneyb@onstation.org>,
        Crt Mori <cmo@melexis.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Martijn Braam <martijn@brixit.nl>,
        Maslov Dmitry <maslovdmitry@seeed.cc>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Vaishnav M A <vaishnav@beagleboard.org>
Subject: [PATCH v2 00/51] iio: Tree wide switch from CONFIG_PM* to pm_[sleep]_ptr etc.
Date:   Sun,  2 Jan 2022 12:55:26 +0000
Message-Id: <20220102125617.1259804-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Previously "iio: Tree wide switch from CONFIG_PM* to __maybe_unused etc."

Note I've kept tags given for v1 having concluded the changes were fairly
minor, but if anyone wants me to drop a tag let me know (it was a bit
borderline in my view).

I have a follow up series to convert the existing cases that looked like the
results of the v1 version of this series but will sit on that until this
has had some review given this set is already rather too large.  For those
I'll probably do some groupings rather than one patch per file.

In the discussion of v1 Paul proposed a change to how pm_ptr() and
related macros are defined to remove the need to mark the various
functions as __maybe_unused.  That culminated in the patch:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=1a3c7bb088266fa2db017be299f91f1c1894c857

which is currently queued up by Rafael in the linux-pm tree for the
merge window.  This series depends on that patch.

So the main changes since v1:

* Drop all the __maybe_unused markings
* Switch from SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
* Switch from SET_RUNTIME_PM_OPS() to RUNTIME_PM_OPS()
* Switch from SET_SYSTEM_SLEEP_PM_OPS() to SYSTEM_SLEEP_PM_OPS()
* Use pm_sleep_ptr() with DEFINE_SIMPLE_DEV_PM_OPS() cases
* Use pm_ptr() with al other cases
* Drop patches change cases where the dev_pm_ops structure is exported
  to other modules as the compiler can't remove those cases automatically
  and more thought is needed.
* Add some additional drivers that I'd missed on the first round.

Note this does not cover all cases of CONFIG_PM* in IIO as some are
considerably more complicated and this approach may not be suitable.

Overall motivation for the series remains the same as for V1:
* Code reduction and improvement in readability.
* Reduce the chance I'll have to ask people to change how they do
  this in future drivers (cut and paste fun)

Note that in some cases letting the compiler remove the code results
in small reductions in module size, particularly when CONFIG_PM_SLEEP
is not defined.

I've kept this at one patch per driver as personally I prefer to
do this for all but most trivial of patches as it makes backports that
cross with this series simpler (though they will now require the
dependency called out above). It also avoids the complexity of tagging
when people wish to call out the subset they have reviewed.

Note there are drivers in here where the author has probably moved
onto other things, so if people have time to review patches in addition
to those I've explicitly cc'd them on that would be great!

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Anson Huang <anson.huang@nxp.com>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Crt Mori <cmo@melexis.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Luca Weiss <luca@z3ntu.xyz>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Martijn Braam <martijn@brixit.nl>
Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: Matt Ranostay <matt.ranostay@konsulko.com
Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: Vaishnav M A <vaishnav@beagleboard.org>

Jonathan Cameron (51):
  iio:accel:da311: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:accel:da280: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:accel:dmard06: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:accel:dmard10: Switch from CONFIG_PM guards to pm_sleep_ptr() etc
  iio:accel:mc3230: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:accel:mma7660: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr()
  iio:accel:mma9551: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:accel:mma9553: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:accel:stk8ba50: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr()
  iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr()
  iio:adc:stm32:Switch from CONFIG_PM guards to pm_ptr()
  iio:adc:rcar: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:adc:rockchip: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:adc:twl6030: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:adc:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:common:ssp: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:dac:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:light:apds9300: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:light:bh1780: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:light:cm3232: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:light:isl29018: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr()
  iio:light:isl29125: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:light:jsa1212: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:light:ltr501: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:light:stk3310: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:light:tcs3414: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:light:tcs3472: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:light:tsl2563: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:light:tsl4531: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:light:us5182: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:magn:ak8975: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:magn:mag3110: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:magn:mmc35240: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:pressure:mpl3115: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:proximity:as3935: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:proximity:pulsedlight: Switch from CONFIG_PM guards to pm_ptr()
    etc
  iio:proximity:rfd77492: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:proximity:sx9500: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:temperature:tmp006: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:temperature:tmp007: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:chemical:atlas: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:accel:stk8312: Switch from CONFIG_PM_SLEEP guards to
    pm_sleep_ptr() etc
  iio:accel:bma180: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:dac:m62332: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
    etc
  iio:imu:kmx61: Switch from CONFIG_PM* guards to pm_ptr() etc
  iio:light:rpr0521: Switch from CONFIG_PM guards to pm_ptr() etc
  iio:temperature:mlx90614: Switch from CONFIG_PM* guards to pm_ptr()
    etc

 drivers/iio/accel/bma180.c                        |  9 ++-------
 drivers/iio/accel/da280.c                         |  6 ++----
 drivers/iio/accel/da311.c                         |  6 ++----
 drivers/iio/accel/dmard06.c                       | 10 +++-------
 drivers/iio/accel/dmard10.c                       |  7 +++----
 drivers/iio/accel/kxsd9-i2c.c                     |  2 +-
 drivers/iio/accel/kxsd9-spi.c                     |  2 +-
 drivers/iio/accel/kxsd9.c                         |  8 ++------
 drivers/iio/accel/mc3230.c                        |  6 ++----
 drivers/iio/accel/mma7660.c                       | 10 ++--------
 drivers/iio/accel/mma9551.c                       | 11 +++--------
 drivers/iio/accel/mma9553.c                       | 11 +++--------
 drivers/iio/accel/stk8312.c                       | 10 ++--------
 drivers/iio/accel/stk8ba50.c                      | 10 ++--------
 drivers/iio/adc/ab8500-gpadc.c                    | 12 ++++--------
 drivers/iio/adc/at91_adc.c                        |  6 ++----
 drivers/iio/adc/exynos_adc.c                      | 10 ++++------
 drivers/iio/adc/palmas_gpadc.c                    | 10 +++-------
 drivers/iio/adc/rcar-gyroadc.c                    |  6 ++----
 drivers/iio/adc/rockchip_saradc.c                 |  6 ++----
 drivers/iio/adc/stm32-adc-core.c                  | 13 +++++--------
 drivers/iio/adc/stm32-adc.c                       | 12 ++++--------
 drivers/iio/adc/twl6030-gpadc.c                   |  8 +++-----
 drivers/iio/adc/vf610_adc.c                       |  6 ++----
 drivers/iio/chemical/atlas-sensor.c               |  7 ++-----
 drivers/iio/common/ssp_sensors/ssp_dev.c          |  8 ++------
 drivers/iio/dac/m62332.c                          |  9 ++-------
 drivers/iio/dac/vf610_dac.c                       |  6 ++----
 drivers/iio/imu/kmx61.c                           | 10 +++-------
 drivers/iio/light/apds9300.c                      |  9 ++-------
 drivers/iio/light/bh1780.c                        | 10 +++-------
 drivers/iio/light/cm3232.c                        |  9 ++-------
 drivers/iio/light/isl29018.c                      |  9 ++-------
 drivers/iio/light/isl29125.c                      |  6 ++----
 drivers/iio/light/jsa1212.c                       | 10 ++--------
 drivers/iio/light/ltr501.c                        |  6 ++----
 drivers/iio/light/rpr0521.c                       |  7 ++-----
 drivers/iio/light/stk3310.c                       | 10 ++--------
 drivers/iio/light/tcs3414.c                       |  6 ++----
 drivers/iio/light/tcs3472.c                       |  6 ++----
 drivers/iio/light/tsl2563.c                       |  9 ++-------
 drivers/iio/light/tsl4531.c                       |  9 ++-------
 drivers/iio/light/us5182d.c                       |  8 +++-----
 drivers/iio/magnetometer/ak8975.c                 | 10 +++-------
 drivers/iio/magnetometer/mag3110.c                |  9 ++-------
 drivers/iio/magnetometer/mmc35240.c               |  8 ++------
 drivers/iio/pressure/mpl3115.c                    |  9 ++-------
 drivers/iio/proximity/as3935.c                    | 10 ++--------
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c |  7 ++-----
 drivers/iio/proximity/rfd77402.c                  |  6 ++----
 drivers/iio/proximity/sx9500.c                    |  8 ++------
 drivers/iio/temperature/mlx90614.c                | 12 ++++--------
 drivers/iio/temperature/tmp006.c                  |  6 ++----
 drivers/iio/temperature/tmp007.c                  |  6 ++----
 54 files changed, 127 insertions(+), 315 deletions(-)

-- 
2.34.1

