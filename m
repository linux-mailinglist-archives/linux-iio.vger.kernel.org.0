Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C504BB867
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 12:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiBRLlG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 06:41:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiBRLlA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 06:41:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD86D381
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 03:40:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7435FB825DE
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 11:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B6CC340E9;
        Fri, 18 Feb 2022 11:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645184441;
        bh=zfSOv3A+lmCSVJN9uuuXVfmJGrvuTMd/wGf2HqpLcqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BjnEdnVvw0kZrGex+XXnBtT8JG1tuGDkOIMp/zLklx61dCqVv/VTh4JQOopGs6TDe
         NWku8d0qr+1LYT5NbO6HCGv834VtPrbrZ10XR9Wg1L69aeD8ZZ0XLTGt65USLLAbQH
         D4APLK0EMTStctuqAXtmQZciLEMxO5GSIjUP/RVGq7thkzcNIhAcMtAMyovvNhA9ZH
         y4hEnRNnewwJ4jG56rAJMWG1Hy1JFMhknrqeZr1ayurCeXzXIgivHqBEKsd+9yqfsD
         TMnNmpH0OoeSmi782jCZjCKQUkflthW9E+IrfMTY0Rm5n8CAQ1232fTxxnlqGxDmIb
         gFFC7as4JHJgg==
Date:   Fri, 18 Feb 2022 11:47:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
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
Subject: Re: [PATCH v3 00/50]  iio: Tree wide switch from CONFIG_PM* to
 pm_[sleep]_ptr etc.
Message-ID: <20220218114725.5c3c80ee@jic23-huawei>
In-Reply-To: <2HC17R.WS259RW5BMQ73@crapouillou.net>
References: <20220130193147.279148-1-jic23@kernel.org>
        <2HC17R.WS259RW5BMQ73@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Feb 2022 11:41:26 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
>=20
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>=20
> for the whole series.

Thanks!

Series applied with a bit of fuzz to the togreg branch of iio.git and
pushed out as testing to let the autobuilders see if they can find
anything we missed

Thanks,

Jonathan

>=20
> Cheers,
> -Paul
>=20
>=20
> Le dim., janv. 30 2022 at 19:30:57 +0000, Jonathan Cameron=20
> <jic23@kernel.org> a =C3=A9crit :
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Note that I have cc'd no one for a number of drivers touched in this
> > set because we don't have a known active maintainer, so if anyone
> > has time to sanity check those it would be much appreciated.
> >=20
> > Now that Paul Cercueil's rework of the pm_ptr() and related macro=20
> > magic
> > to ensure we the compiler can remove unused struct dev_pm_ops and=20
> > related
> > functions when either CONFIG_PM_SLEEP is not set or both that and
> > CONFIG_PM are not set is upstream [1], lets revisit this series of
> > cleanup of CONFIG_PM* guards in IIO.
> >=20
> > Changes since v2:
> > 1) Move to new macros where relevant.
> > 2) Add static as the macros no longer include it
> >    DEFINE_SIMPLE_DEV_PM_OPS etc.
> > 3) Drop complex cases (I've noted those in reply to v2 so won't
> >    go into specifics here.  I'll revisit all these but after this=20
> > massive
> >    set is in place. Some of these are due to interaction with
> >    the ongoing namespace work in IIO.
> > 4) Use the new DEFINE_RUNTIME_DEV_PM_OPS for cases where the
> >    force runtime functions were used for sleep ops.
> > 5) Add a few cases that I'd missed the first time around.
> >=20
> > Note that there are some drivers that provide runtime callbacks
> > but not sleep ones.  The chances are high that it would be
> > sensible to use the force runtime pm calls for those, but
> > I considered that a separate change which should potentially be
> > part of a follow up patch set.
> >=20
> > [1]=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D9d8619190031af0a314bee865262d8975473e4dd
> >=20
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Anson Huang <anson.huang@nxp.com>
> > Cc: Brian Masney <masneyb@onstation.org>
> > Cc: Crt Mori <cmo@melexis.com>
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
> > Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
> > Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> > Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> > Cc: Vaishnav M A <vaishnav@beagleboard.org>
> > Jonathan Cameron (50):
> >   iio:accel:da311: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:accel:da280: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:accel:dmard06: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:accel:dmard10: Switch from CONFIG_PM guards to pm_sleep_ptr()=20
> > etc
> >   iio:accel:mc3230: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:accel:mma7660: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr()
> >   iio:accel:mma9551: Switch from CONFIG_PM guards to pm_ptr() etc
> >   iio:accel:mma9553: Switch from CONFIG_PM guards to pm_ptr() etc
> >   iio:accel:stk8ba50: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr()
> >   iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr()
> >   iio:adc:rockchip: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:adc:twl6030: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:adc:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
> >     etc
> >   iio:common:ssp: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
> >     etc
> >   iio:dac:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
> >     etc
> >   iio:light:apds9300: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:light:cm3232: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:light:isl29018: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr()
> >   iio:light:isl29125: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:light:jsa1212: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:light:ltr501: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:light:stk3310: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:light:tcs3414: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:light:tcs3472: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:light:tsl2563: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:light:tsl4531: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:magn:ak8975: Switch from CONFIG_PM guards to pm_ptr() etc
> >   iio:magn:mag3110: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:magn:mmc35240: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:pressure:mpl3115: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:proximity:as3935: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:proximity:rfd77492: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:proximity:sx9500: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:temperature:tmp006: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:temperature:tmp007: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:accel:stk8312: Switch from CONFIG_PM_SLEEP guards to
> >     pm_sleep_ptr() etc
> >   iio:accel:bma180: Switch from CONFIG_PM_SLEEP guards to=20
> > pm_sleep_ptr()
> >     etc
> >   iio:dac:m62332: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
> >     etc
> >   iio:imu:kmx61: Switch from CONFIG_PM* guards to pm_ptr() etc
> >   iio:temperature:mlx90614: Switch from CONFIG_PM* guards to pm_ptr()
> >     etc
> >   iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() etc
> >   iio:adc:stm32:Switch from CONFIG_PM guards to pm_ptr()
> >   iio:adc:rcar: Switch from CONFIG_PM guards to pm_ptr() etc
> >   iio:light:bh1780: Switch from CONFIG_PM guards to pm_ptr() etc
> >   iio:proximity:pulsedlight: Switch from CONFIG_PM guards to pm_ptr()
> >     etc
> >   iio:chemical:atlas: Switch from CONFIG_PM guards to pm_ptr() etc
> >   iio:light:rpr0521: Switch from CONFIG_PM guards to pm_ptr() etc
> >   iio:adc:stm32*: Use pm[_sleep]_ptr() etc to avoid need to make pm
> >     __maybe_unused
> >=20
> >  drivers/iio/accel/bma180.c                    |  9 ++-------
> >  drivers/iio/accel/da280.c                     |  6 ++----
> >  drivers/iio/accel/da311.c                     |  6 ++----
> >  drivers/iio/accel/dmard06.c                   | 10 +++-------
> >  drivers/iio/accel/dmard10.c                   |  7 +++----
> >  drivers/iio/accel/mc3230.c                    |  6 ++----
> >  drivers/iio/accel/mma7660.c                   | 11 +++--------
> >  drivers/iio/accel/mma9551.c                   | 11 +++--------
> >  drivers/iio/accel/mma9553.c                   | 11 +++--------
> >  drivers/iio/accel/stk8312.c                   | 11 +++--------
> >  drivers/iio/accel/stk8ba50.c                  | 11 +++--------
> >  drivers/iio/adc/ab8500-gpadc.c                | 13 +++----------
> >  drivers/iio/adc/at91_adc.c                    |  7 +++----
> >  drivers/iio/adc/exynos_adc.c                  |  9 +++------
> >  drivers/iio/adc/palmas_gpadc.c                | 10 +++-------
> >  drivers/iio/adc/rcar-gyroadc.c                |  6 ++----
> >  drivers/iio/adc/rockchip_saradc.c             |  9 ++++-----
> >  drivers/iio/adc/stm32-adc-core.c              | 17 ++++++-----------
> >  drivers/iio/adc/stm32-adc.c                   | 12 ++++--------
> >  drivers/iio/adc/stm32-dfsdm-adc.c             | 11 ++++++-----
> >  drivers/iio/adc/stm32-dfsdm-core.c            | 19=20
> > +++++++++----------
> >  drivers/iio/adc/twl6030-gpadc.c               |  8 +++-----
> >  drivers/iio/adc/vf610_adc.c                   |  7 +++----
> >  drivers/iio/chemical/atlas-sensor.c           |  7 ++-----
> >  drivers/iio/common/ssp_sensors/ssp_dev.c      |  8 ++------
> >  drivers/iio/dac/m62332.c                      | 11 ++---------
> >  drivers/iio/dac/stm32-dac-core.c              | 16 ++++++++--------
> >  drivers/iio/dac/stm32-dac.c                   |  9 ++++-----
> >  drivers/iio/dac/vf610_dac.c                   |  7 +++----
> >  drivers/iio/imu/kmx61.c                       | 10 +++-------
> >  drivers/iio/light/apds9300.c                  | 10 +++-------
> >  drivers/iio/light/bh1780.c                    | 12 +++---------
> >  drivers/iio/light/cm3232.c                    |  9 ++-------
> >  drivers/iio/light/isl29018.c                  | 10 +++-------
> >  drivers/iio/light/isl29125.c                  |  7 +++----
> >  drivers/iio/light/jsa1212.c                   | 11 +++--------
> >  drivers/iio/light/ltr501.c                    |  6 ++----
> >  drivers/iio/light/rpr0521.c                   |  7 ++-----
> >  drivers/iio/light/stk3310.c                   | 11 +++--------
> >  drivers/iio/light/tcs3414.c                   |  7 +++----
> >  drivers/iio/light/tcs3472.c                   |  7 +++----
> >  drivers/iio/light/tsl2563.c                   | 10 +++-------
> >  drivers/iio/light/tsl4531.c                   | 10 +++-------
> >  drivers/iio/magnetometer/ak8975.c             | 12 +++---------
> >  drivers/iio/magnetometer/mag3110.c            | 10 +++-------
> >  drivers/iio/magnetometer/mmc35240.c           |  9 +++------
> >  drivers/iio/pressure/mpl3115.c                | 10 +++-------
> >  drivers/iio/proximity/as3935.c                | 10 ++--------
> >  .../iio/proximity/pulsedlight-lidar-lite-v2.c |  7 ++-----
> >  drivers/iio/proximity/rfd77402.c              |  7 +++----
> >  drivers/iio/proximity/sx9500.c                |  8 ++------
> >  drivers/iio/temperature/mlx90614.c            | 12 ++++--------
> >  drivers/iio/temperature/tmp006.c              |  6 ++----
> >  drivers/iio/temperature/tmp007.c              |  6 ++----
> >  drivers/iio/trigger/stm32-timer-trigger.c     | 12 ++++++------
> >  55 files changed, 173 insertions(+), 348 deletions(-)
> >=20
> > --
> > 2.35.1
> >  =20
>=20
>=20

