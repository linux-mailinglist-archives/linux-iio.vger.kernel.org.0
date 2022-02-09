Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF514AF09E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Feb 2022 13:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiBIMDp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 9 Feb 2022 07:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiBIMDP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Feb 2022 07:03:15 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5F5C050CFB
        for <linux-iio@vger.kernel.org>; Wed,  9 Feb 2022 03:41:39 -0800 (PST)
Date:   Wed, 09 Feb 2022 11:41:26 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 00/50]  iio: Tree wide switch from CONFIG_PM* to
 pm_[sleep]_ptr etc.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
Message-Id: <2HC17R.WS259RW5BMQ73@crapouillou.net>
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

for the whole series.

Cheers,
-Paul


Le dim., janv. 30 2022 at 19:30:57 +0000, Jonathan Cameron 
<jic23@kernel.org> a écrit :
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Note that I have cc'd no one for a number of drivers touched in this
> set because we don't have a known active maintainer, so if anyone
> has time to sanity check those it would be much appreciated.
> 
> Now that Paul Cercueil's rework of the pm_ptr() and related macro 
> magic
> to ensure we the compiler can remove unused struct dev_pm_ops and 
> related
> functions when either CONFIG_PM_SLEEP is not set or both that and
> CONFIG_PM are not set is upstream [1], lets revisit this series of
> cleanup of CONFIG_PM* guards in IIO.
> 
> Changes since v2:
> 1) Move to new macros where relevant.
> 2) Add static as the macros no longer include it
>    DEFINE_SIMPLE_DEV_PM_OPS etc.
> 3) Drop complex cases (I've noted those in reply to v2 so won't
>    go into specifics here.  I'll revisit all these but after this 
> massive
>    set is in place. Some of these are due to interaction with
>    the ongoing namespace work in IIO.
> 4) Use the new DEFINE_RUNTIME_DEV_PM_OPS for cases where the
>    force runtime functions were used for sleep ops.
> 5) Add a few cases that I'd missed the first time around.
> 
> Note that there are some drivers that provide runtime callbacks
> but not sleep ones.  The chances are high that it would be
> sensible to use the force runtime pm calls for those, but
> I considered that a separate change which should potentially be
> part of a follow up patch set.
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d8619190031af0a314bee865262d8975473e4dd
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Anson Huang <anson.huang@nxp.com>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Crt Mori <cmo@melexis.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> Cc: Icenowy Zheng <icenowy@aosc.io>
> Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Luca Weiss <luca@z3ntu.xyz>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Martijn Braam <martijn@brixit.nl>
> Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com
> Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Cc: Vaishnav M A <vaishnav@beagleboard.org>
> Jonathan Cameron (50):
>   iio:accel:da311: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:accel:da280: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:accel:dmard06: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:accel:dmard10: Switch from CONFIG_PM guards to pm_sleep_ptr() 
> etc
>   iio:accel:mc3230: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:accel:mma7660: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr()
>   iio:accel:mma9551: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio:accel:mma9553: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio:accel:stk8ba50: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr()
>   iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr()
>   iio:adc:rockchip: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:adc:twl6030: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:adc:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
>     etc
>   iio:common:ssp: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
>     etc
>   iio:dac:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
>     etc
>   iio:light:apds9300: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:light:cm3232: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:light:isl29018: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr()
>   iio:light:isl29125: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:light:jsa1212: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:light:ltr501: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:light:stk3310: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:light:tcs3414: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:light:tcs3472: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:light:tsl2563: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:light:tsl4531: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:magn:ak8975: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio:magn:mag3110: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:magn:mmc35240: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:pressure:mpl3115: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:proximity:as3935: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:proximity:rfd77492: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:proximity:sx9500: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:temperature:tmp006: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:temperature:tmp007: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:accel:stk8312: Switch from CONFIG_PM_SLEEP guards to
>     pm_sleep_ptr() etc
>   iio:accel:bma180: Switch from CONFIG_PM_SLEEP guards to 
> pm_sleep_ptr()
>     etc
>   iio:dac:m62332: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
>     etc
>   iio:imu:kmx61: Switch from CONFIG_PM* guards to pm_ptr() etc
>   iio:temperature:mlx90614: Switch from CONFIG_PM* guards to pm_ptr()
>     etc
>   iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio:adc:stm32:Switch from CONFIG_PM guards to pm_ptr()
>   iio:adc:rcar: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio:light:bh1780: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio:proximity:pulsedlight: Switch from CONFIG_PM guards to pm_ptr()
>     etc
>   iio:chemical:atlas: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio:light:rpr0521: Switch from CONFIG_PM guards to pm_ptr() etc
>   iio:adc:stm32*: Use pm[_sleep]_ptr() etc to avoid need to make pm
>     __maybe_unused
> 
>  drivers/iio/accel/bma180.c                    |  9 ++-------
>  drivers/iio/accel/da280.c                     |  6 ++----
>  drivers/iio/accel/da311.c                     |  6 ++----
>  drivers/iio/accel/dmard06.c                   | 10 +++-------
>  drivers/iio/accel/dmard10.c                   |  7 +++----
>  drivers/iio/accel/mc3230.c                    |  6 ++----
>  drivers/iio/accel/mma7660.c                   | 11 +++--------
>  drivers/iio/accel/mma9551.c                   | 11 +++--------
>  drivers/iio/accel/mma9553.c                   | 11 +++--------
>  drivers/iio/accel/stk8312.c                   | 11 +++--------
>  drivers/iio/accel/stk8ba50.c                  | 11 +++--------
>  drivers/iio/adc/ab8500-gpadc.c                | 13 +++----------
>  drivers/iio/adc/at91_adc.c                    |  7 +++----
>  drivers/iio/adc/exynos_adc.c                  |  9 +++------
>  drivers/iio/adc/palmas_gpadc.c                | 10 +++-------
>  drivers/iio/adc/rcar-gyroadc.c                |  6 ++----
>  drivers/iio/adc/rockchip_saradc.c             |  9 ++++-----
>  drivers/iio/adc/stm32-adc-core.c              | 17 ++++++-----------
>  drivers/iio/adc/stm32-adc.c                   | 12 ++++--------
>  drivers/iio/adc/stm32-dfsdm-adc.c             | 11 ++++++-----
>  drivers/iio/adc/stm32-dfsdm-core.c            | 19 
> +++++++++----------
>  drivers/iio/adc/twl6030-gpadc.c               |  8 +++-----
>  drivers/iio/adc/vf610_adc.c                   |  7 +++----
>  drivers/iio/chemical/atlas-sensor.c           |  7 ++-----
>  drivers/iio/common/ssp_sensors/ssp_dev.c      |  8 ++------
>  drivers/iio/dac/m62332.c                      | 11 ++---------
>  drivers/iio/dac/stm32-dac-core.c              | 16 ++++++++--------
>  drivers/iio/dac/stm32-dac.c                   |  9 ++++-----
>  drivers/iio/dac/vf610_dac.c                   |  7 +++----
>  drivers/iio/imu/kmx61.c                       | 10 +++-------
>  drivers/iio/light/apds9300.c                  | 10 +++-------
>  drivers/iio/light/bh1780.c                    | 12 +++---------
>  drivers/iio/light/cm3232.c                    |  9 ++-------
>  drivers/iio/light/isl29018.c                  | 10 +++-------
>  drivers/iio/light/isl29125.c                  |  7 +++----
>  drivers/iio/light/jsa1212.c                   | 11 +++--------
>  drivers/iio/light/ltr501.c                    |  6 ++----
>  drivers/iio/light/rpr0521.c                   |  7 ++-----
>  drivers/iio/light/stk3310.c                   | 11 +++--------
>  drivers/iio/light/tcs3414.c                   |  7 +++----
>  drivers/iio/light/tcs3472.c                   |  7 +++----
>  drivers/iio/light/tsl2563.c                   | 10 +++-------
>  drivers/iio/light/tsl4531.c                   | 10 +++-------
>  drivers/iio/magnetometer/ak8975.c             | 12 +++---------
>  drivers/iio/magnetometer/mag3110.c            | 10 +++-------
>  drivers/iio/magnetometer/mmc35240.c           |  9 +++------
>  drivers/iio/pressure/mpl3115.c                | 10 +++-------
>  drivers/iio/proximity/as3935.c                | 10 ++--------
>  .../iio/proximity/pulsedlight-lidar-lite-v2.c |  7 ++-----
>  drivers/iio/proximity/rfd77402.c              |  7 +++----
>  drivers/iio/proximity/sx9500.c                |  8 ++------
>  drivers/iio/temperature/mlx90614.c            | 12 ++++--------
>  drivers/iio/temperature/tmp006.c              |  6 ++----
>  drivers/iio/temperature/tmp007.c              |  6 ++----
>  drivers/iio/trigger/stm32-timer-trigger.c     | 12 ++++++------
>  55 files changed, 173 insertions(+), 348 deletions(-)
> 
> --
> 2.35.1
> 


