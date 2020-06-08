Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0967B1F12EA
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 08:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgFHGiB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 02:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbgFHGiB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 02:38:01 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB426C08C5C3;
        Sun,  7 Jun 2020 23:38:00 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a3so2337320oid.4;
        Sun, 07 Jun 2020 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYjY5oF2O6MS6UGrpHPOi+8Flg5ETLIKr6sURMjVj1Q=;
        b=D/W37xpRxnPtnsSNTweWygGgOBcm2N312ft4GjXdld/IH7Y6PrVmSNDeu8weGuh4cd
         S601MJ7AOV8FhF9WZSkEyZGZ3YkCDg6JezTmACLryt0GnCJbV49Dn/S/iNv49wcIW/h2
         xhLHFXvSmvHCvf5q2h+ThrFRmIgeAn9CLIHDUNtSpr9jGC4ncTB7rj1kRYCnsMHnJp2B
         TcH2As7HSF83kSL6RsHtp2Mq4vug8B9E7qrXc8qkXcYiqnCTCz3LMlX7lm6vR3zGleDG
         n3HzLZdnDpfm1926M9LjeztqTke+An9tAMrrjzbKHMxlvxkdLt9OtyLy+0zI2sbPni9x
         KhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYjY5oF2O6MS6UGrpHPOi+8Flg5ETLIKr6sURMjVj1Q=;
        b=JYzF6jc6HlKGmn9nKMzoWYNBIDRJE9NWmbg8yzB/a+fKuBA5fC/JeJUHXUAiKvxnuM
         BeQdNh+XiQULuBs4Q+S64BPGvYKu9T31c5FOMf9mQtOWEDs1aq/qR0RbTDHKhssVVT9D
         BDwMHW/Dw8T2gcpsaqhgQUPiKjjwmiLklTaskip/8L/vPvE94oslMqnqStX/ullR1LFw
         m54Scg2stwlGYP4H9ubB0czNvZD1CWeaPPSq/PKC5cDU41dD2Ausn5GXySfUVVuseE86
         WLlZ3+dEZ5oFImJIPJRWgBrybWJ/En7eB4+KCzqqy7Exoh/3+CHQZpjSIuDcxeZ18TUL
         gP8w==
X-Gm-Message-State: AOAM532HVfeyVKh8pOGS++9wLEc6CtEQDPfs7kzuGLkqSZRPZ+BKkaYx
        S0Hy8wiBKp25eyhfb2h0dm406UJW8nLiiU97GMQ=
X-Google-Smtp-Source: ABdhPJyatjFA2zt9FhiSeo49H5o2GbZKdeoI358nQ7sU2fxQO4AjbLnkxq9Qu2m8f+sCz6jgjmNs0Tquadx+ysoipYo=
X-Received: by 2002:aca:de8b:: with SMTP id v133mr5943656oig.124.1591598280085;
 Sun, 07 Jun 2020 23:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114023.175102-1-alexandru.ardelean@analog.com>
 <0049dcc6f543e41978bbb7c731b43ab20e6f647d.camel@analog.com>
 <20200604183440.00003fb3@Huawei.com> <20200606170246.4efc4fd7@archlinux>
In-Reply-To: <20200606170246.4efc4fd7@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 8 Jun 2020 09:37:48 +0300
Message-ID: <CA+U=Dso8ijzXOKcbu5-tTxg7GR-nEGEugZU=SRo_qdB7AFdTKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] iio: core: pass parent device as parameter during allocation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "johan@kernel.org" <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 6, 2020 at 7:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 4 Jun 2020 18:34:40 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Wed, 3 Jun 2020 11:41:52 +0000
> > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> >
> > > On Wed, 2020-06-03 at 14:40 +0300, Alexandru Ardelean wrote:
> > > > This patch updates the {devm_}iio_device_alloc() functions to automatically
> > > > assign the parent device on allocation.
> > > > For iio_device_alloc() this means a new parameter.
> > > > For devm_iio_device_alloc() this means a new behavior; the device object is
> > > > the parent. For this one, this is the common case for most drivers (except
> > > > one: 'lm3533-als').
> > > >
> > > > For the special cases an iio_device_set_parent() has been created to change
> > > > the parent betwee allocation & registration.
> > > > The purpose of this helper, is mostly to highlight the new behavior of
> > > > devm_iio_device_alloc().
> > > >
> > > > This patchset also removes explicit parent assignments from most IIO
> > > > drivers (except for lm3533-als).
> > > >
> > > > Using a semantic patch, about 303 drivers are updated, and some needed some
> > > > manual attention. This is probably due to some limitations of spatch. At
> > > > least in some cases the parent device is not the same variable as passed to
> > > > devm_iio_device_alloc(), OR the parent assignment is moved to a separate
> > > > function than where devm_iio_device_alloc() is called.
> > > >
> > >
> > > Forgot to explicitly CC Jonathan.
> > > But I'm hoping this shows up from the list.
> >
> > No problem.  I filter anything going to the list into the same folder
> > whether or not I'm cc'd :) Well several folders on different machines via
> > different email addresses, but you get the idea...
>
> Patch 3 doesn't seem to have made it to me or the list.
>

hmm, that's weird;
i'll check my work email inbox and see if it got there;
i'm in a short vacation this week; and left everything at work [intentionally]

> I assumed no change from patch 2 in previous set and applied that.
>
that looks like the spatch patch;
nothing changed there;

> After applying the rest of the series, there were left over cases in:
>
> vcnl3020 (new)
> ms5611 (hidden via an extra call)
> st_sensors_spi (hidden via an extra call)
> st_sensors_i2c (hidden via an extra call)
> cros_ec_sensors_core (hidden via an extra call)
>
> I've added them to patch 6 - with a note to say why.
> If you could do a quick sanity check that would be great.
>

did you push the branch anywhere?
i can't seem to find the patches

> Thanks,
>
> Jonathan
>
>
> Thanks,
>
> Jonathan
>
> >
> >
> > >
> > > > Changelog v1 -> v2:
> > > > * added iio_device_set_parent() helper (new commit)
> > > > * update commit for lm3533-als to use iio_device_set_parent()
> > > >
> > > > Alexandru Ardelean (6):
> > > >   iio: core: pass parent device as parameter during allocation
> > > >   iio: core: add iio_device_set_parent() helper
> > > >   iio: remove explicit IIO device parent assignment
> > > >   iio: remove left-over comments about parent assignment
> > > >   iio: light: lm3533-als: use iio_device_set_parent() to assign parent
> > > >   iio: remove left-over parent assignments
> > > >
> > > >  drivers/counter/104-quad-8.c                  |  1 -
> > > >  drivers/counter/stm32-lptimer-cnt.c           |  1 -
> > > >  drivers/iio/accel/adis16201.c                 |  1 -
> > > >  drivers/iio/accel/adis16209.c                 |  1 -
> > > >  drivers/iio/accel/adxl345_core.c              |  1 -
> > > >  drivers/iio/accel/adxl372.c                   |  1 -
> > > >  drivers/iio/accel/bma180.c                    |  1 -
> > > >  drivers/iio/accel/bma220_spi.c                |  1 -
> > > >  drivers/iio/accel/bma400_core.c               |  1 -
> > > >  drivers/iio/accel/bmc150-accel-core.c         |  1 -
> > > >  drivers/iio/accel/da280.c                     |  1 -
> > > >  drivers/iio/accel/da311.c                     |  1 -
> > > >  drivers/iio/accel/dmard06.c                   |  1 -
> > > >  drivers/iio/accel/dmard09.c                   |  1 -
> > > >  drivers/iio/accel/dmard10.c                   |  1 -
> > > >  drivers/iio/accel/hid-sensor-accel-3d.c       |  1 -
> > > >  drivers/iio/accel/kxcjk-1013.c                |  1 -
> > > >  drivers/iio/accel/kxsd9.c                     |  1 -
> > > >  drivers/iio/accel/mc3230.c                    |  1 -
> > > >  drivers/iio/accel/mma7455_core.c              |  1 -
> > > >  drivers/iio/accel/mma7660.c                   |  1 -
> > > >  drivers/iio/accel/mma8452.c                   |  1 -
> > > >  drivers/iio/accel/mma9551.c                   |  1 -
> > > >  drivers/iio/accel/mma9553.c                   |  1 -
> > > >  drivers/iio/accel/mxc4005.c                   |  1 -
> > > >  drivers/iio/accel/mxc6255.c                   |  1 -
> > > >  drivers/iio/accel/sca3000.c                   |  1 -
> > > >  drivers/iio/accel/ssp_accel_sensor.c          |  1 -
> > > >  drivers/iio/accel/stk8312.c                   |  1 -
> > > >  drivers/iio/accel/stk8ba50.c                  |  1 -
> > > >  drivers/iio/adc/ab8500-gpadc.c                |  1 -
> > > >  drivers/iio/adc/ad7091r-base.c                |  1 -
> > > >  drivers/iio/adc/ad7124.c                      |  1 -
> > > >  drivers/iio/adc/ad7192.c                      |  1 -
> > > >  drivers/iio/adc/ad7266.c                      |  1 -
> > > >  drivers/iio/adc/ad7291.c                      |  1 -
> > > >  drivers/iio/adc/ad7292.c                      |  1 -
> > > >  drivers/iio/adc/ad7298.c                      |  1 -
> > > >  drivers/iio/adc/ad7476.c                      |  2 --
> > > >  drivers/iio/adc/ad7606.c                      |  1 -
> > > >  drivers/iio/adc/ad7766.c                      |  1 -
> > > >  drivers/iio/adc/ad7768-1.c                    |  1 -
> > > >  drivers/iio/adc/ad7780.c                      |  1 -
> > > >  drivers/iio/adc/ad7791.c                      |  1 -
> > > >  drivers/iio/adc/ad7793.c                      |  1 -
> > > >  drivers/iio/adc/ad7887.c                      |  2 --
> > > >  drivers/iio/adc/ad7923.c                      |  1 -
> > > >  drivers/iio/adc/ad7949.c                      |  1 -
> > > >  drivers/iio/adc/ad799x.c                      |  1 -
> > > >  drivers/iio/adc/adi-axi-adc.c                 |  1 -
> > > >  drivers/iio/adc/aspeed_adc.c                  |  1 -
> > > >  drivers/iio/adc/at91-sama5d2_adc.c            |  1 -
> > > >  drivers/iio/adc/at91_adc.c                    |  1 -
> > > >  drivers/iio/adc/axp20x_adc.c                  |  1 -
> > > >  drivers/iio/adc/axp288_adc.c                  |  1 -
> > > >  drivers/iio/adc/bcm_iproc_adc.c               |  1 -
> > > >  drivers/iio/adc/berlin2-adc.c                 |  1 -
> > > >  drivers/iio/adc/cc10001_adc.c                 |  1 -
> > > >  drivers/iio/adc/cpcap-adc.c                   |  1 -
> > > >  drivers/iio/adc/da9150-gpadc.c                |  1 -
> > > >  drivers/iio/adc/dln2-adc.c                    |  1 -
> > > >  drivers/iio/adc/envelope-detector.c           |  1 -
> > > >  drivers/iio/adc/ep93xx_adc.c                  |  1 -
> > > >  drivers/iio/adc/exynos_adc.c                  |  1 -
> > > >  drivers/iio/adc/fsl-imx25-gcq.c               |  1 -
> > > >  drivers/iio/adc/hi8435.c                      |  1 -
> > > >  drivers/iio/adc/hx711.c                       |  1 -
> > > >  drivers/iio/adc/imx7d_adc.c                   |  1 -
> > > >  drivers/iio/adc/ina2xx-adc.c                  |  1 -
> > > >  drivers/iio/adc/ingenic-adc.c                 |  1 -
> > > >  drivers/iio/adc/intel_mrfld_adc.c             |  1 -
> > > >  drivers/iio/adc/lp8788_adc.c                  |  1 -
> > > >  drivers/iio/adc/lpc18xx_adc.c                 |  1 -
> > > >  drivers/iio/adc/lpc32xx_adc.c                 |  1 -
> > > >  drivers/iio/adc/ltc2471.c                     |  1 -
> > > >  drivers/iio/adc/ltc2485.c                     |  1 -
> > > >  drivers/iio/adc/max1027.c                     |  1 -
> > > >  drivers/iio/adc/max11100.c                    |  1 -
> > > >  drivers/iio/adc/max1118.c                     |  1 -
> > > >  drivers/iio/adc/max1241.c                     |  1 -
> > > >  drivers/iio/adc/max1363.c                     |  2 --
> > > >  drivers/iio/adc/max9611.c                     |  1 -
> > > >  drivers/iio/adc/mcp320x.c                     |  1 -
> > > >  drivers/iio/adc/mcp3422.c                     |  1 -
> > > >  drivers/iio/adc/mcp3911.c                     |  1 -
> > > >  drivers/iio/adc/men_z188_adc.c                |  1 -
> > > >  drivers/iio/adc/meson_saradc.c                |  1 -
> > > >  drivers/iio/adc/mt6577_auxadc.c               |  1 -
> > > >  drivers/iio/adc/mxs-lradc-adc.c               |  1 -
> > > >  drivers/iio/adc/nau7802.c                     |  1 -
> > > >  drivers/iio/adc/npcm_adc.c                    |  1 -
> > > >  drivers/iio/adc/palmas_gpadc.c                |  1 -
> > > >  drivers/iio/adc/qcom-pm8xxx-xoadc.c           |  1 -
> > > >  drivers/iio/adc/qcom-spmi-adc5.c              |  1 -
> > > >  drivers/iio/adc/qcom-spmi-iadc.c              |  1 -
> > > >  drivers/iio/adc/qcom-spmi-vadc.c              |  1 -
> > > >  drivers/iio/adc/rcar-gyroadc.c                |  1 -
> > > >  drivers/iio/adc/rn5t618-adc.c                 |  1 -
> > > >  drivers/iio/adc/rockchip_saradc.c             |  1 -
> > > >  drivers/iio/adc/sc27xx_adc.c                  |  1 -
> > > >  drivers/iio/adc/sd_adc_modulator.c            |  1 -
> > > >  drivers/iio/adc/spear_adc.c                   |  1 -
> > > >  drivers/iio/adc/stm32-adc.c                   |  1 -
> > > >  drivers/iio/adc/stm32-dfsdm-adc.c             |  1 -
> > > >  drivers/iio/adc/stmpe-adc.c                   |  1 -
> > > >  drivers/iio/adc/stx104.c                      |  1 -
> > > >  drivers/iio/adc/sun4i-gpadc-iio.c             |  1 -
> > > >  drivers/iio/adc/ti-adc081c.c                  |  1 -
> > > >  drivers/iio/adc/ti-adc0832.c                  |  1 -
> > > >  drivers/iio/adc/ti-adc084s021.c               |  1 -
> > > >  drivers/iio/adc/ti-adc108s102.c               |  1 -
> > > >  drivers/iio/adc/ti-adc12138.c                 |  1 -
> > > >  drivers/iio/adc/ti-adc128s052.c               |  1 -
> > > >  drivers/iio/adc/ti-adc161s626.c               |  1 -
> > > >  drivers/iio/adc/ti-ads1015.c                  |  1 -
> > > >  drivers/iio/adc/ti-ads124s08.c                |  1 -
> > > >  drivers/iio/adc/ti-ads7950.c                  |  1 -
> > > >  drivers/iio/adc/ti-ads8344.c                  |  1 -
> > > >  drivers/iio/adc/ti-ads8688.c                  |  1 -
> > > >  drivers/iio/adc/ti-tlc4541.c                  |  1 -
> > > >  drivers/iio/adc/ti_am335x_adc.c               |  1 -
> > > >  drivers/iio/adc/twl4030-madc.c                |  1 -
> > > >  drivers/iio/adc/twl6030-gpadc.c               |  1 -
> > > >  drivers/iio/adc/vf610_adc.c                   |  1 -
> > > >  drivers/iio/adc/viperboard_adc.c              |  1 -
> > > >  drivers/iio/adc/xilinx-xadc-core.c            |  1 -
> > > >  drivers/iio/afe/iio-rescale.c                 |  1 -
> > > >  drivers/iio/amplifiers/ad8366.c               |  1 -
> > > >  drivers/iio/amplifiers/hmc425a.c              |  1 -
> > > >  drivers/iio/chemical/ams-iaq-core.c           |  1 -
> > > >  drivers/iio/chemical/atlas-sensor.c           |  1 -
> > > >  drivers/iio/chemical/bme680_core.c            |  1 -
> > > >  drivers/iio/chemical/ccs811.c                 |  1 -
> > > >  drivers/iio/chemical/pms7003.c                |  1 -
> > > >  drivers/iio/chemical/sgp30.c                  |  1 -
> > > >  drivers/iio/chemical/sps30.c                  |  1 -
> > > >  drivers/iio/chemical/vz89x.c                  |  1 -
> > > >  drivers/iio/dac/ad5064.c                      |  1 -
> > > >  drivers/iio/dac/ad5360.c                      |  1 -
> > > >  drivers/iio/dac/ad5380.c                      |  1 -
> > > >  drivers/iio/dac/ad5421.c                      |  1 -
> > > >  drivers/iio/dac/ad5446.c                      |  2 --
> > > >  drivers/iio/dac/ad5449.c                      |  1 -
> > > >  drivers/iio/dac/ad5504.c                      |  1 -
> > > >  drivers/iio/dac/ad5592r-base.c                |  1 -
> > > >  drivers/iio/dac/ad5624r_spi.c                 |  1 -
> > > >  drivers/iio/dac/ad5686.c                      |  1 -
> > > >  drivers/iio/dac/ad5755.c                      |  1 -
> > > >  drivers/iio/dac/ad5758.c                      |  1 -
> > > >  drivers/iio/dac/ad5761.c                      |  1 -
> > > >  drivers/iio/dac/ad5764.c                      |  1 -
> > > >  drivers/iio/dac/ad5770r.c                     |  1 -
> > > >  drivers/iio/dac/ad5791.c                      |  1 -
> > > >  drivers/iio/dac/ad7303.c                      |  1 -
> > > >  drivers/iio/dac/ad8801.c                      |  1 -
> > > >  drivers/iio/dac/cio-dac.c                     |  1 -
> > > >  drivers/iio/dac/dpot-dac.c                    |  1 -
> > > >  drivers/iio/dac/ds4424.c                      |  1 -
> > > >  drivers/iio/dac/lpc18xx_dac.c                 |  1 -
> > > >  drivers/iio/dac/ltc1660.c                     |  1 -
> > > >  drivers/iio/dac/ltc2632.c                     |  1 -
> > > >  drivers/iio/dac/m62332.c                      |  3 ---
> > > >  drivers/iio/dac/max517.c                      |  3 ---
> > > >  drivers/iio/dac/max5821.c                     |  1 -
> > > >  drivers/iio/dac/mcp4725.c                     |  1 -
> > > >  drivers/iio/dac/mcp4922.c                     |  1 -
> > > >  drivers/iio/dac/stm32-dac.c                   |  1 -
> > > >  drivers/iio/dac/ti-dac082s085.c               |  1 -
> > > >  drivers/iio/dac/ti-dac5571.c                  |  1 -
> > > >  drivers/iio/dac/ti-dac7311.c                  |  1 -
> > > >  drivers/iio/dac/ti-dac7612.c                  |  1 -
> > > >  drivers/iio/dac/vf610_dac.c                   |  1 -
> > > >  drivers/iio/dummy/iio_simple_dummy.c          | 14 ++++++-----
> > > >  drivers/iio/frequency/ad9523.c                |  1 -
> > > >  drivers/iio/frequency/adf4350.c               |  1 -
> > > >  drivers/iio/frequency/adf4371.c               |  1 -
> > > >  drivers/iio/gyro/adis16080.c                  |  1 -
> > > >  drivers/iio/gyro/adis16130.c                  |  1 -
> > > >  drivers/iio/gyro/adis16136.c                  |  1 -
> > > >  drivers/iio/gyro/adis16260.c                  |  1 -
> > > >  drivers/iio/gyro/adxrs450.c                   |  1 -
> > > >  drivers/iio/gyro/bmg160_core.c                |  1 -
> > > >  drivers/iio/gyro/fxas21002c_core.c            |  1 -
> > > >  drivers/iio/gyro/hid-sensor-gyro-3d.c         |  1 -
> > > >  drivers/iio/gyro/itg3200_core.c               |  1 -
> > > >  drivers/iio/gyro/mpu3050-core.c               |  1 -
> > > >  drivers/iio/gyro/ssp_gyro_sensor.c            |  1 -
> > > >  drivers/iio/health/afe4403.c                  |  1 -
> > > >  drivers/iio/health/afe4404.c                  |  1 -
> > > >  drivers/iio/health/max30100.c                 |  1 -
> > > >  drivers/iio/health/max30102.c                 |  1 -
> > > >  drivers/iio/humidity/am2315.c                 |  1 -
> > > >  drivers/iio/humidity/dht11.c                  |  1 -
> > > >  drivers/iio/humidity/hdc100x.c                |  1 -
> > > >  drivers/iio/humidity/hid-sensor-humidity.c    |  1 -
> > > >  drivers/iio/humidity/hts221_core.c            |  1 -
> > > >  drivers/iio/humidity/htu21.c                  |  1 -
> > > >  drivers/iio/humidity/si7005.c                 |  1 -
> > > >  drivers/iio/humidity/si7020.c                 |  1 -
> > > >  drivers/iio/imu/adis16400.c                   |  1 -
> > > >  drivers/iio/imu/adis16460.c                   |  1 -
> > > >  drivers/iio/imu/adis16475.c                   |  1 -
> > > >  drivers/iio/imu/adis16480.c                   |  1 -
> > > >  drivers/iio/imu/bmi160/bmi160_core.c          |  1 -
> > > >  drivers/iio/imu/fxos8700_core.c               |  1 -
> > > >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  1 -
> > > >  drivers/iio/imu/kmx61.c                       |  1 -
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  1 -
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  1 -
> > > >  drivers/iio/industrialio-core.c               | 11 +++++----
> > > >  drivers/iio/light/acpi-als.c                  |  1 -
> > > >  drivers/iio/light/adjd_s311.c                 |  1 -
> > > >  drivers/iio/light/adux1020.c                  |  1 -
> > > >  drivers/iio/light/al3010.c                    |  1 -
> > > >  drivers/iio/light/al3320a.c                   |  1 -
> > > >  drivers/iio/light/apds9300.c                  |  1 -
> > > >  drivers/iio/light/apds9960.c                  |  1 -
> > > >  drivers/iio/light/bh1750.c                    |  1 -
> > > >  drivers/iio/light/bh1780.c                    |  1 -
> > > >  drivers/iio/light/cm32181.c                   |  1 -
> > > >  drivers/iio/light/cm3232.c                    |  1 -
> > > >  drivers/iio/light/cm3323.c                    |  1 -
> > > >  drivers/iio/light/cm3605.c                    |  1 -
> > > >  drivers/iio/light/cm36651.c                   |  1 -
> > > >  drivers/iio/light/gp2ap002.c                  |  1 -
> > > >  drivers/iio/light/gp2ap020a00f.c              |  1 -
> > > >  drivers/iio/light/hid-sensor-als.c            |  1 -
> > > >  drivers/iio/light/hid-sensor-prox.c           |  1 -
> > > >  drivers/iio/light/iqs621-als.c                |  1 -
> > > >  drivers/iio/light/isl29018.c                  |  1 -
> > > >  drivers/iio/light/isl29028.c                  |  1 -
> > > >  drivers/iio/light/isl29125.c                  |  1 -
> > > >  drivers/iio/light/jsa1212.c                   |  1 -
> > > >  drivers/iio/light/lm3533-als.c                |  2 +-
> > > >  drivers/iio/light/ltr501.c                    |  1 -
> > > >  drivers/iio/light/lv0104cs.c                  |  1 -
> > > >  drivers/iio/light/max44000.c                  |  1 -
> > > >  drivers/iio/light/max44009.c                  |  1 -
> > > >  drivers/iio/light/noa1305.c                   |  1 -
> > > >  drivers/iio/light/opt3001.c                   |  1 -
> > > >  drivers/iio/light/pa12203001.c                |  1 -
> > > >  drivers/iio/light/rpr0521.c                   |  1 -
> > > >  drivers/iio/light/si1133.c                    |  1 -
> > > >  drivers/iio/light/si1145.c                    |  1 -
> > > >  drivers/iio/light/st_uvis25_core.c            |  1 -
> > > >  drivers/iio/light/stk3310.c                   |  1 -
> > > >  drivers/iio/light/tcs3414.c                   |  1 -
> > > >  drivers/iio/light/tcs3472.c                   |  1 -
> > > >  drivers/iio/light/tsl2563.c                   |  1 -
> > > >  drivers/iio/light/tsl2583.c                   |  1 -
> > > >  drivers/iio/light/tsl2772.c                   |  1 -
> > > >  drivers/iio/light/tsl4531.c                   |  1 -
> > > >  drivers/iio/light/us5182d.c                   |  1 -
> > > >  drivers/iio/light/vcnl4000.c                  |  1 -
> > > >  drivers/iio/light/vcnl4035.c                  |  1 -
> > > >  drivers/iio/light/veml6030.c                  |  1 -
> > > >  drivers/iio/light/veml6070.c                  |  1 -
> > > >  drivers/iio/light/vl6180.c                    |  1 -
> > > >  drivers/iio/light/zopt2201.c                  |  1 -
> > > >  drivers/iio/magnetometer/ak8974.c             |  1 -
> > > >  drivers/iio/magnetometer/ak8975.c             |  1 -
> > > >  drivers/iio/magnetometer/bmc150_magn.c        |  1 -
> > > >  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  1 -
> > > >  drivers/iio/magnetometer/hmc5843_core.c       |  1 -
> > > >  drivers/iio/magnetometer/mag3110.c            |  1 -
> > > >  drivers/iio/magnetometer/mmc35240.c           |  1 -
> > > >  drivers/iio/magnetometer/rm3100-core.c        |  1 -
> > > >  drivers/iio/multiplexer/iio-mux.c             |  1 -
> > > >  drivers/iio/orientation/hid-sensor-incl-3d.c  |  1 -
> > > >  drivers/iio/orientation/hid-sensor-rotation.c |  1 -
> > > >  drivers/iio/position/iqs624-pos.c             |  1 -
> > > >  drivers/iio/potentiometer/ad5272.c            |  1 -
> > > >  drivers/iio/potentiometer/ds1803.c            |  1 -
> > > >  drivers/iio/potentiometer/max5432.c           |  1 -
> > > >  drivers/iio/potentiometer/max5481.c           |  1 -
> > > >  drivers/iio/potentiometer/max5487.c           |  1 -
> > > >  drivers/iio/potentiometer/mcp4018.c           |  1 -
> > > >  drivers/iio/potentiometer/mcp41010.c          |  1 -
> > > >  drivers/iio/potentiometer/mcp4131.c           |  1 -
> > > >  drivers/iio/potentiometer/mcp4531.c           |  1 -
> > > >  drivers/iio/potentiometer/tpl0102.c           |  1 -
> > > >  drivers/iio/potentiostat/lmp91000.c           |  1 -
> > > >  drivers/iio/pressure/abp060mg.c               |  1 -
> > > >  drivers/iio/pressure/bmp280-core.c            |  1 -
> > > >  drivers/iio/pressure/dlhl60d.c                |  1 -
> > > >  drivers/iio/pressure/dps310.c                 |  1 -
> > > >  drivers/iio/pressure/hid-sensor-press.c       |  1 -
> > > >  drivers/iio/pressure/hp03.c                   |  1 -
> > > >  drivers/iio/pressure/hp206c.c                 |  1 -
> > > >  drivers/iio/pressure/icp10100.c               |  1 -
> > > >  drivers/iio/pressure/mpl115.c                 |  1 -
> > > >  drivers/iio/pressure/mpl3115.c                |  1 -
> > > >  drivers/iio/pressure/ms5637.c                 |  1 -
> > > >  drivers/iio/pressure/t5403.c                  |  1 -
> > > >  drivers/iio/pressure/zpa2326.c                |  1 -
> > > >  drivers/iio/proximity/as3935.c                |  1 -
> > > >  drivers/iio/proximity/isl29501.c              |  1 -
> > > >  drivers/iio/proximity/mb1232.c                |  1 -
> > > >  drivers/iio/proximity/ping.c                  |  1 -
> > > >  .../iio/proximity/pulsedlight-lidar-lite-v2.c |  1 -
> > > >  drivers/iio/proximity/rfd77402.c              |  1 -
> > > >  drivers/iio/proximity/srf04.c                 |  1 -
> > > >  drivers/iio/proximity/srf08.c                 |  1 -
> > > >  drivers/iio/proximity/sx9310.c                |  1 -
> > > >  drivers/iio/proximity/sx9500.c                |  1 -
> > > >  drivers/iio/proximity/vl53l0x-i2c.c           |  1 -
> > > >  drivers/iio/resolver/ad2s1200.c               |  1 -
> > > >  drivers/iio/resolver/ad2s90.c                 |  1 -
> > > >  .../iio/temperature/hid-sensor-temperature.c  |  1 -
> > > >  drivers/iio/temperature/iqs620at-temp.c       |  1 -
> > > >  drivers/iio/temperature/ltc2983.c             |  1 -
> > > >  drivers/iio/temperature/max31856.c            |  1 -
> > > >  drivers/iio/temperature/maxim_thermocouple.c  |  1 -
> > > >  drivers/iio/temperature/mlx90614.c            |  1 -
> > > >  drivers/iio/temperature/mlx90632.c            |  1 -
> > > >  drivers/iio/temperature/tmp006.c              |  1 -
> > > >  drivers/iio/temperature/tmp007.c              |  1 -
> > > >  drivers/iio/temperature/tsys01.c              |  1 -
> > > >  drivers/iio/temperature/tsys02d.c             |  1 -
> > > >  drivers/iio/trigger/stm32-timer-trigger.c     |  1 -
> > > >  drivers/input/touchscreen/tsc2007_iio.c       |  1 -
> > > >  drivers/platform/x86/toshiba_acpi.c           |  3 +--
> > > >  drivers/staging/iio/Documentation/device.txt  |  4 +---
> > > >  drivers/staging/iio/accel/adis16203.c         |  1 -
> > > >  drivers/staging/iio/accel/adis16240.c         |  1 -
> > > >  drivers/staging/iio/adc/ad7280a.c             |  1 -
> > > >  drivers/staging/iio/adc/ad7816.c              |  1 -
> > > >  drivers/staging/iio/addac/adt7316.c           |  1 -
> > > >  drivers/staging/iio/cdc/ad7150.c              |  2 --
> > > >  drivers/staging/iio/cdc/ad7746.c              |  2 --
> > > >  drivers/staging/iio/frequency/ad9832.c        |  1 -
> > > >  drivers/staging/iio/frequency/ad9834.c        |  1 -
> > > >  .../staging/iio/impedance-analyzer/ad5933.c   |  1 -
> > > >  drivers/staging/iio/resolver/ad2s1210.c       |  1 -
> > > >  include/linux/iio/iio.h                       | 24 +++++++++++++++++--
> > > >  335 files changed, 39 insertions(+), 358 deletions(-)
> > > >
> >
> >
>
