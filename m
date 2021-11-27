Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067854600CF
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 18:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhK0SC2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 27 Nov 2021 13:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355952AbhK0SA1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 13:00:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B972C061759
        for <linux-iio@vger.kernel.org>; Sat, 27 Nov 2021 09:57:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B2CC60EBC
        for <linux-iio@vger.kernel.org>; Sat, 27 Nov 2021 17:57:12 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id A73CDC53FBF;
        Sat, 27 Nov 2021 17:57:03 +0000 (UTC)
Date:   Sat, 27 Nov 2021 18:02:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Anson Huang <anson.huang@nxp.com>,
        Brian Masney <masneyb@onstation.org>,
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
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/49] iio: Tree wide switch from CONFIG_PM* to
 __maybe_unused etc.
Message-ID: <20211127180203.5a33c59e@jic23-huawei>
In-Reply-To: <KMP13R.I8M265PNR9RU@crapouillou.net>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <KMP13R.I8M265PNR9RU@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 22:11:08 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> Cc'd Arnd who may have some interest in the topic.
> 
> Le mar., nov. 23 2021 at 21:09:30 +0000, Jonathan Cameron 
> <jic23@kernel.org> a écrit :
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Note this series includes many drivers that are quite old and I'm not
> > sure have active maintainers.  Hence if anyone has time to look at 
> > some
> > of these beyond their own drivers and sanity check them it would be 
> > much
> > appreciated!
> > 
> > Two motivations behind this set.
> > 1 - General code reduction and improvement in readability in these 
> > drivers.
> > 2 - Reduce change I'll have to ask people to change how they do this 
> > in
> >     future patches.
> > 
> > Mostly this is just a case of letting the compiler work out it can 
> > remove
> > the PM related functions rather than using #ifdefs in the code to do 
> > so.
> > 
> > The __maybe_unused markings make it clear we are intentionally 
> > building
> > functions that the compiler can see are unused and remove in some 
> > build
> > configurations.
> > 
> > The new pm_ptr() macro is rather convenient to got futher than many of
> > the drivers were and when CONFIG_PM is not define ensure that the
> > struct dev_pm_ops can also be removed.  Note there is a subtlty in 
> > that
> > we only remove that whe CONFIG_PM is not defined whereas a few of 
> > these
> > drivers were using CONFIG_PM_SLEEP which is a tighter condition (will
> > remove the structure in more configurations).  I think that's a small
> > price to pay for the convenience this macro brings.
> > 
> > I did this set as one patch per driver, as personally I prefer that
> > option for all but the most trivial patches because it makes backports
> > that cross with this series simpler and also avoid the complex
> > tag giving we get for sets touching code from many authors.
> > 
> > All comments welcome.  
> 
> One word about the pm_ptr() macro. Right now it's defined as:
>   #ifdef CONFIG_PM
>   #define pm_ptr(_ptr) (_ptr)
>   #else
>   #define pm_ptr(_ptr) NULL
>   #endif
> 
> It could be possible to define it like this instead:
>   #define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
> 
> The difference is that if !CONFIG_PM, in the first case the (_ptr) is 
> not visible by the compiler and the __maybe_unused is required, while 
> in the second case the (_ptr) is always visible by the compiler, but 
> discarded as dead code. The reason we'd want that is the same reason we 
> use IS_ENABLED() instead of macro guards; and you wouldn't need the 
> __maybe_unused attribute anywhere.
> 
> The problem then is that the SET_*_PM_OPS macros are defined 
> differently according to CONFIG_PM, so their definition would need to 
> be changed to use the (redefined) pm_ptr() macro and a corresponding 
> pm_sleep_ptr() macro.

Small question here.  Why would these macros need to use pm_ptr() macro at all?

Why not just stop them being conditional on CONFIG_PM at all and let dead
code removal kill them off for us?  You might want to do something different
for the CONFIG_PM_SLEEP ones though if we care about having it that fine
grained.

Obviously still need new macros to do this, so doesn't change the
fundamental question.

> Unfortunately since the SET_*_PM_OPS macros are 
> used everywhere with code wrapped around #ifdef CONFIG_PM guards, it 
> wouldn't be easy to change them, and it would just be easier to 
> introduce new macros.
> 
> The patchset looks fine as-is and I am not asking you to work on 
> anything I just said, I just thought it was worth mentioning.
> 
> Cheers,
> -Paul
> 
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Anson Huang <anson.huang@nxp.com>
> > Cc: Brian Masney <masneyb@onstation.org>
> > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> > Cc: Icenowy Zheng <icenowy@aosc.io>
> > Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Luca Weiss <luca@z3ntu.xyz>
> > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> > Cc: Manivannan Sadhasivam <mani@kernel.org>
> > Cc: Martijn Braam <martijn@brixit.nl>
> > Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com
> > Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> > Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> > Cc: Vaishnav M A <vaishnav@beagleboard.org>
> > 
> > 
> > Jonathan Cameron (49):
> >   iio:accel:da311: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:accel:da280: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:accel:dmard06: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:accel:dmard10: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:accel:mc3230: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:accel:mma7660: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:accel:mma9551: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:accel:mma9553: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:accel:stk8ba50: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:adc:ad7606: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP guards to 
> > pm_ptr() /
> >     __maybe_unused
> >   iio:adc:stm32:Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:adc:rcar: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:adc:rockchip: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:adc:twl6030: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:adc:vf610: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:common:ssp: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:dac:vf610: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:apds9300: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:bh1780: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:cm3232: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:isl29018: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:isl29125: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:jsa1212: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:ltr501: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:stk3310: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:tcs3414: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:tcs3472: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:tsl2563: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:tsl4531: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:light:us5182: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:magn:ak8975: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:magn:hmc5843: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:magn:mag3110: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:magn:mmc35240: Switch from CONFIG_PM_SLEEP guards to pm_ptr() /
> >     __maybe_unused
> >   iio:pressure:mpl3115: Switch from CONFIG_PM_SLEEP guards to 
> > pm_ptr() /
> >     __maybe_unused
> >   iio:pressure:bmp280: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:proximity:as3935: Switch from CONFIG_PM_SLEEP guards to 
> > pm_ptr() /
> >     __maybe_unused
> >   iio:proximity:pulsedlight: Switch from CONFIG_PM guards to pm_ptr() 
> > /
> >     __maybe_unused
> >   iio:proximity:rfd77492: Switch from CONFIG_PM_SLEEP guards to 
> > pm_ptr()
> >     / __maybe_unused
> >   iio:proximity:sx9500: Switch from CONFIG_PM_SLEEP guards to 
> > pm_ptr() /
> >     __maybe_unused
> >   iio:temperature:tmp006: Switch from CONFIG_PM_SLEEP guards to 
> > pm_ptr()
> >     / __maybe_unused
> >   iio:temperature:tmp007: Switch from CONFIG_PM_SLEEP guards to 
> > pm_ptr()
> >     / __maybe_unused
> >   iio:gyro:mpu3050: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> >   iio:chemical:atlas: Switch from CONFIG_PM guards to pm_ptr() /
> >     __maybe_unused
> > 
> >  drivers/iio/accel/da280.c                        |  6 ++----
> >  drivers/iio/accel/da311.c                        |  8 +++-----
> >  drivers/iio/accel/dmard06.c                      | 12 ++++--------
> >  drivers/iio/accel/dmard10.c                      |  9 ++++-----
> >  drivers/iio/accel/kxsd9-i2c.c                    |  2 +-
> >  drivers/iio/accel/kxsd9-spi.c                    |  2 +-
> >  drivers/iio/accel/kxsd9.c                        |  8 +++-----
> >  drivers/iio/accel/mc3230.c                       |  8 +++-----
> >  drivers/iio/accel/mma7660.c                      | 12 +++---------
> >  drivers/iio/accel/mma9551.c                      | 16 
> > ++++++----------
> >  drivers/iio/accel/mma9553.c                      | 16 
> > ++++++----------
> >  drivers/iio/accel/stk8ba50.c                     | 12 +++---------
> >  drivers/iio/adc/ab8500-gpadc.c                   | 10 ++++------
> >  drivers/iio/adc/ad7606.c                         |  8 ++------
> >  drivers/iio/adc/ad7606.h                         |  5 -----
> >  drivers/iio/adc/ad7606_par.c                     |  2 +-
> >  drivers/iio/adc/ad7606_spi.c                     |  2 +-
> >  drivers/iio/adc/at91_adc.c                       |  8 +++-----
> >  drivers/iio/adc/exynos_adc.c                     |  8 +++-----
> >  drivers/iio/adc/palmas_gpadc.c                   | 14 ++++++--------
> >  drivers/iio/adc/rcar-gyroadc.c                   | 10 ++++------
> >  drivers/iio/adc/rockchip_saradc.c                |  8 +++-----
> >  drivers/iio/adc/stm32-adc-core.c                 | 12 +++++-------
> >  drivers/iio/adc/stm32-adc.c                      | 16 
> > ++++++----------
> >  drivers/iio/adc/twl6030-gpadc.c                  |  8 +++-----
> >  drivers/iio/adc/vf610_adc.c                      |  8 +++-----
> >  drivers/iio/chemical/atlas-sensor.c              | 10 ++++------
> >  drivers/iio/common/ssp_sensors/ssp_dev.c         | 12 ++++--------
> >  drivers/iio/dac/vf610_dac.c                      |  8 +++-----
> >  drivers/iio/gyro/mpu3050-core.c                  |  8 +++-----
> >  drivers/iio/gyro/mpu3050-i2c.c                   |  2 +-
> >  drivers/iio/light/apds9300.c                     | 11 +++--------
> >  drivers/iio/light/bh1780.c                       | 10 ++++------
> >  drivers/iio/light/cm3232.c                       | 13 ++++---------
> >  drivers/iio/light/isl29018.c                     | 11 +++--------
> >  drivers/iio/light/isl29125.c                     |  8 +++-----
> >  drivers/iio/light/jsa1212.c                      | 12 +++---------
> >  drivers/iio/light/ltr501.c                       |  8 +++-----
> >  drivers/iio/light/stk3310.c                      | 12 +++---------
> >  drivers/iio/light/tcs3414.c                      |  8 +++-----
> >  drivers/iio/light/tcs3472.c                      |  8 +++-----
> >  drivers/iio/light/tsl2563.c                      | 11 +++--------
> >  drivers/iio/light/tsl4531.c                      | 11 +++--------
> >  drivers/iio/light/us5182d.c                      | 10 ++++------
> >  drivers/iio/magnetometer/ak8975.c                | 10 ++++------
> >  drivers/iio/magnetometer/hmc5843.h               |  5 -----
> >  drivers/iio/magnetometer/hmc5843_i2c.c           |  2 +-
> >  drivers/iio/magnetometer/hmc5843_spi.c           |  2 +-
> >  drivers/iio/magnetometer/mag3110.c               | 11 +++--------
> >  drivers/iio/magnetometer/mmc35240.c              | 12 ++++--------
> >  drivers/iio/pressure/bmp280-core.c               |  6 ++----
> >  drivers/iio/pressure/bmp280-i2c.c                |  2 +-
> >  drivers/iio/pressure/bmp280-spi.c                |  2 +-
> >  drivers/iio/pressure/mpl3115.c                   | 11 +++--------
> >  drivers/iio/proximity/as3935.c                   | 12 +++---------
> >  .../iio/proximity/pulsedlight-lidar-lite-v2.c    | 10 ++++------
> >  drivers/iio/proximity/rfd77402.c                 |  8 +++-----
> >  drivers/iio/proximity/sx9500.c                   | 12 ++++--------
> >  drivers/iio/temperature/tmp006.c                 |  8 +++-----
> >  drivers/iio/temperature/tmp007.c                 |  8 +++-----
> >  60 files changed, 180 insertions(+), 344 deletions(-)
> > 
> > --
> > 2.34.0
> >   
> 
> 

