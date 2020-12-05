Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC232CFCB8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgLESTU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgLER7w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 12:59:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D7E22D2B;
        Sat,  5 Dec 2020 16:59:25 +0000 (UTC)
Date:   Sat, 5 Dec 2020 16:59:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [RFC PATCH 0/5] iio: move 'modes' initialization to core
Message-ID: <20201205165922.703acb3d@archlinux>
In-Reply-To: <20201203100423.77270-1-alexandru.ardelean@analog.com>
References: <20201203100423.77270-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 3 Dec 2020 12:04:18 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> I stumbled over this, while trying to implement some changes to the IIO
> buffer logic.
> Seems that most drivers have a INDIO_DIRECT_MODE, and some have
> INDIO_BUFFER_SOFTWARE only as a workaround for not having multiple IIO
> buffer-support-per-IIO-device (yet).

Examples of that particular corner case would be good from a discussion
point of view.

It's been a while though and those cases were always 'interesting'
so I may have misremembered how it works!

It is definitely also used to indicate cases where there is no trigger
to expose (usually devices doing DMA blocks or using a fifo).
That was the original intent IIRC.

> 
> Since a lot of drivers seem to only support INDIO_DIRECT_MODE, it begs the
> question whether this starts to make sense as a default 'modes'
> initialization.

Hmm. Do we need to set it at all, or can we just make it implicit?
I'm not sure if that is semantically worse than having it set by default
or not.  Thinking about it I think we do want to set it just for
consistency purposes.

I'm a bit in two minds about this set.  It obviously is a noop from
functional point of view, but it's kind of nice to see the modes
explicitly called out.  I guess we started walking down this route
anyway when we set IIO_TRIGGERED_BUFFER inside those setup routines.

The bit that bothers me is that it isn't really a 'default' as such
it just the most common value.  I wonder if we could be more clever
and set it only if there as a channel with _RAW or _PROCESSED
though that would involve moving it to the registration rather than
creation.

Jonathan

> 
> It opens up the idea of hiding 'indio_dev->modes' inside IIO core, with
> functions like '{devm_}iio_triggered_buffer_setup()' being able to extend
> the setup of these 'modes'.
> This idea is far from being ready, but I thought I'd try this RFC instead
> as a discussion starter in that direction.
> 
> Alexandru Ardelean (5):
>   iio: core: initialize 'modes' to INDIO_DIRECT_MODE by default
>   iio,counter: remove modes init for INDIO_DIRECT_MODE only drivers
>   iio: remove modes init for INDIO_DIRECT_MODE only drivers (manual)
>   iio: adc: ad7768-1: remove explicit modes initialization
>   iio: magnetometer: rm3100: remove explicit modes initialization
> 
>  drivers/counter/104-quad-8.c                      | 1 -
>  drivers/iio/accel/adis16201.c                     | 1 -
>  drivers/iio/accel/adis16209.c                     | 1 -
>  drivers/iio/accel/adxl345_core.c                  | 1 -
>  drivers/iio/accel/bma180.c                        | 1 -
>  drivers/iio/accel/bma220_spi.c                    | 1 -
>  drivers/iio/accel/bma400_core.c                   | 1 -
>  drivers/iio/accel/bmc150-accel-core.c             | 1 -
>  drivers/iio/accel/da280.c                         | 1 -
>  drivers/iio/accel/da311.c                         | 1 -
>  drivers/iio/accel/dmard06.c                       | 1 -
>  drivers/iio/accel/dmard09.c                       | 1 -
>  drivers/iio/accel/dmard10.c                       | 1 -
>  drivers/iio/accel/hid-sensor-accel-3d.c           | 1 -
>  drivers/iio/accel/kxcjk-1013.c                    | 1 -
>  drivers/iio/accel/kxsd9.c                         | 1 -
>  drivers/iio/accel/mc3230.c                        | 1 -
>  drivers/iio/accel/mma7455_core.c                  | 1 -
>  drivers/iio/accel/mma7660.c                       | 1 -
>  drivers/iio/accel/mma8452.c                       | 1 -
>  drivers/iio/accel/mma9551.c                       | 1 -
>  drivers/iio/accel/mma9553.c                       | 1 -
>  drivers/iio/accel/mxc4005.c                       | 1 -
>  drivers/iio/accel/mxc6255.c                       | 1 -
>  drivers/iio/accel/sca3000.c                       | 1 -
>  drivers/iio/accel/st_accel_core.c                 | 1 -
>  drivers/iio/accel/stk8312.c                       | 1 -
>  drivers/iio/accel/stk8ba50.c                      | 1 -
>  drivers/iio/adc/ab8500-gpadc.c                    | 1 -
>  drivers/iio/adc/ad7091r-base.c                    | 1 -
>  drivers/iio/adc/ad7124.c                          | 1 -
>  drivers/iio/adc/ad7192.c                          | 1 -
>  drivers/iio/adc/ad7266.c                          | 1 -
>  drivers/iio/adc/ad7291.c                          | 1 -
>  drivers/iio/adc/ad7292.c                          | 1 -
>  drivers/iio/adc/ad7298.c                          | 1 -
>  drivers/iio/adc/ad7476.c                          | 1 -
>  drivers/iio/adc/ad7606.c                          | 1 -
>  drivers/iio/adc/ad7766.c                          | 1 -
>  drivers/iio/adc/ad7768-1.c                        | 1 -
>  drivers/iio/adc/ad7780.c                          | 1 -
>  drivers/iio/adc/ad7791.c                          | 1 -
>  drivers/iio/adc/ad7793.c                          | 1 -
>  drivers/iio/adc/ad7887.c                          | 1 -
>  drivers/iio/adc/ad7923.c                          | 1 -
>  drivers/iio/adc/ad7949.c                          | 1 -
>  drivers/iio/adc/ad799x.c                          | 1 -
>  drivers/iio/adc/adi-axi-adc.c                     | 1 -
>  drivers/iio/adc/aspeed_adc.c                      | 1 -
>  drivers/iio/adc/at91_adc.c                        | 1 -
>  drivers/iio/adc/axp20x_adc.c                      | 1 -
>  drivers/iio/adc/axp288_adc.c                      | 1 -
>  drivers/iio/adc/bcm_iproc_adc.c                   | 1 -
>  drivers/iio/adc/berlin2-adc.c                     | 1 -
>  drivers/iio/adc/cc10001_adc.c                     | 1 -
>  drivers/iio/adc/da9150-gpadc.c                    | 1 -
>  drivers/iio/adc/dln2-adc.c                        | 1 -
>  drivers/iio/adc/ep93xx_adc.c                      | 1 -
>  drivers/iio/adc/exynos_adc.c                      | 1 -
>  drivers/iio/adc/hi8435.c                          | 1 -
>  drivers/iio/adc/hx711.c                           | 1 -
>  drivers/iio/adc/imx7d_adc.c                       | 1 -
>  drivers/iio/adc/intel_mrfld_adc.c                 | 1 -
>  drivers/iio/adc/lp8788_adc.c                      | 1 -
>  drivers/iio/adc/lpc18xx_adc.c                     | 1 -
>  drivers/iio/adc/lpc32xx_adc.c                     | 1 -
>  drivers/iio/adc/ltc2471.c                         | 1 -
>  drivers/iio/adc/ltc2485.c                         | 1 -
>  drivers/iio/adc/ltc2497-core.c                    | 1 -
>  drivers/iio/adc/max1027.c                         | 1 -
>  drivers/iio/adc/max11100.c                        | 1 -
>  drivers/iio/adc/max1118.c                         | 1 -
>  drivers/iio/adc/max1241.c                         | 1 -
>  drivers/iio/adc/max1363.c                         | 1 -
>  drivers/iio/adc/max9611.c                         | 1 -
>  drivers/iio/adc/mcp320x.c                         | 1 -
>  drivers/iio/adc/mcp3422.c                         | 1 -
>  drivers/iio/adc/mcp3911.c                         | 1 -
>  drivers/iio/adc/men_z188_adc.c                    | 1 -
>  drivers/iio/adc/meson_saradc.c                    | 1 -
>  drivers/iio/adc/mp2629_adc.c                      | 1 -
>  drivers/iio/adc/mt6360-adc.c                      | 1 -
>  drivers/iio/adc/mt6577_auxadc.c                   | 1 -
>  drivers/iio/adc/mxs-lradc-adc.c                   | 1 -
>  drivers/iio/adc/nau7802.c                         | 1 -
>  drivers/iio/adc/npcm_adc.c                        | 1 -
>  drivers/iio/adc/palmas_gpadc.c                    | 1 -
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c               | 1 -
>  drivers/iio/adc/qcom-spmi-adc5.c                  | 1 -
>  drivers/iio/adc/qcom-spmi-iadc.c                  | 1 -
>  drivers/iio/adc/qcom-spmi-vadc.c                  | 1 -
>  drivers/iio/adc/rcar-gyroadc.c                    | 1 -
>  drivers/iio/adc/rn5t618-adc.c                     | 1 -
>  drivers/iio/adc/rockchip_saradc.c                 | 1 -
>  drivers/iio/adc/sc27xx_adc.c                      | 1 -
>  drivers/iio/adc/spear_adc.c                       | 1 -
>  drivers/iio/adc/stm32-dfsdm-adc.c                 | 1 -
>  drivers/iio/adc/stmpe-adc.c                       | 1 -
>  drivers/iio/adc/stx104.c                          | 1 -
>  drivers/iio/adc/sun4i-gpadc-iio.c                 | 1 -
>  drivers/iio/adc/ti-adc081c.c                      | 1 -
>  drivers/iio/adc/ti-adc0832.c                      | 1 -
>  drivers/iio/adc/ti-adc084s021.c                   | 1 -
>  drivers/iio/adc/ti-adc108s102.c                   | 1 -
>  drivers/iio/adc/ti-adc12138.c                     | 1 -
>  drivers/iio/adc/ti-adc128s052.c                   | 1 -
>  drivers/iio/adc/ti-adc161s626.c                   | 1 -
>  drivers/iio/adc/ti-ads1015.c                      | 1 -
>  drivers/iio/adc/ti-ads124s08.c                    | 1 -
>  drivers/iio/adc/ti-ads7950.c                      | 1 -
>  drivers/iio/adc/ti-ads8344.c                      | 1 -
>  drivers/iio/adc/ti-ads8688.c                      | 1 -
>  drivers/iio/adc/ti-tlc4541.c                      | 1 -
>  drivers/iio/adc/ti_am335x_adc.c                   | 1 -
>  drivers/iio/adc/twl4030-madc.c                    | 1 -
>  drivers/iio/adc/twl6030-gpadc.c                   | 1 -
>  drivers/iio/adc/vf610_adc.c                       | 1 -
>  drivers/iio/adc/viperboard_adc.c                  | 1 -
>  drivers/iio/adc/xilinx-xadc-core.c                | 1 -
>  drivers/iio/afe/iio-rescale.c                     | 1 -
>  drivers/iio/amplifiers/ad8366.c                   | 1 -
>  drivers/iio/amplifiers/hmc425a.c                  | 1 -
>  drivers/iio/chemical/ams-iaq-core.c               | 1 -
>  drivers/iio/chemical/atlas-ezo-sensor.c           | 1 -
>  drivers/iio/chemical/bme680_core.c                | 1 -
>  drivers/iio/chemical/ccs811.c                     | 1 -
>  drivers/iio/chemical/pms7003.c                    | 1 -
>  drivers/iio/chemical/scd30_core.c                 | 1 -
>  drivers/iio/chemical/sgp30.c                      | 1 -
>  drivers/iio/chemical/sps30.c                      | 1 -
>  drivers/iio/chemical/vz89x.c                      | 1 -
>  drivers/iio/dac/ad5064.c                          | 1 -
>  drivers/iio/dac/ad5360.c                          | 1 -
>  drivers/iio/dac/ad5380.c                          | 1 -
>  drivers/iio/dac/ad5421.c                          | 1 -
>  drivers/iio/dac/ad5446.c                          | 1 -
>  drivers/iio/dac/ad5449.c                          | 1 -
>  drivers/iio/dac/ad5504.c                          | 1 -
>  drivers/iio/dac/ad5592r-base.c                    | 1 -
>  drivers/iio/dac/ad5624r_spi.c                     | 1 -
>  drivers/iio/dac/ad5686.c                          | 1 -
>  drivers/iio/dac/ad5755.c                          | 1 -
>  drivers/iio/dac/ad5758.c                          | 1 -
>  drivers/iio/dac/ad5761.c                          | 1 -
>  drivers/iio/dac/ad5764.c                          | 1 -
>  drivers/iio/dac/ad5770r.c                         | 1 -
>  drivers/iio/dac/ad5791.c                          | 1 -
>  drivers/iio/dac/ad7303.c                          | 1 -
>  drivers/iio/dac/ad8801.c                          | 1 -
>  drivers/iio/dac/cio-dac.c                         | 1 -
>  drivers/iio/dac/dpot-dac.c                        | 1 -
>  drivers/iio/dac/ds4424.c                          | 1 -
>  drivers/iio/dac/lpc18xx_dac.c                     | 1 -
>  drivers/iio/dac/ltc1660.c                         | 1 -
>  drivers/iio/dac/ltc2632.c                         | 1 -
>  drivers/iio/dac/m62332.c                          | 1 -
>  drivers/iio/dac/max517.c                          | 1 -
>  drivers/iio/dac/max5821.c                         | 1 -
>  drivers/iio/dac/mcp4725.c                         | 1 -
>  drivers/iio/dac/mcp4922.c                         | 1 -
>  drivers/iio/dac/stm32-dac.c                       | 1 -
>  drivers/iio/dac/ti-dac082s085.c                   | 1 -
>  drivers/iio/dac/ti-dac5571.c                      | 1 -
>  drivers/iio/dac/ti-dac7311.c                      | 1 -
>  drivers/iio/dac/ti-dac7612.c                      | 1 -
>  drivers/iio/dac/vf610_dac.c                       | 1 -
>  drivers/iio/dummy/iio_simple_dummy.c              | 3 ---
>  drivers/iio/frequency/ad9523.c                    | 1 -
>  drivers/iio/frequency/adf4350.c                   | 1 -
>  drivers/iio/frequency/adf4371.c                   | 1 -
>  drivers/iio/gyro/adis16080.c                      | 1 -
>  drivers/iio/gyro/adis16130.c                      | 1 -
>  drivers/iio/gyro/adis16136.c                      | 1 -
>  drivers/iio/gyro/adis16260.c                      | 1 -
>  drivers/iio/gyro/adxrs290.c                       | 1 -
>  drivers/iio/gyro/adxrs450.c                       | 1 -
>  drivers/iio/gyro/bmg160_core.c                    | 1 -
>  drivers/iio/gyro/fxas21002c_core.c                | 1 -
>  drivers/iio/gyro/hid-sensor-gyro-3d.c             | 1 -
>  drivers/iio/gyro/itg3200_core.c                   | 1 -
>  drivers/iio/gyro/mpu3050-core.c                   | 1 -
>  drivers/iio/gyro/st_gyro_core.c                   | 1 -
>  drivers/iio/health/afe4403.c                      | 1 -
>  drivers/iio/health/afe4404.c                      | 1 -
>  drivers/iio/humidity/am2315.c                     | 1 -
>  drivers/iio/humidity/dht11.c                      | 1 -
>  drivers/iio/humidity/hdc100x.c                    | 1 -
>  drivers/iio/humidity/hdc2010.c                    | 1 -
>  drivers/iio/humidity/hid-sensor-humidity.c        | 1 -
>  drivers/iio/humidity/hts221_core.c                | 1 -
>  drivers/iio/humidity/htu21.c                      | 1 -
>  drivers/iio/humidity/si7005.c                     | 1 -
>  drivers/iio/humidity/si7020.c                     | 1 -
>  drivers/iio/imu/adis16400.c                       | 1 -
>  drivers/iio/imu/adis16460.c                       | 1 -
>  drivers/iio/imu/adis16475.c                       | 1 -
>  drivers/iio/imu/adis16480.c                       | 1 -
>  drivers/iio/imu/bmi160/bmi160_core.c              | 1 -
>  drivers/iio/imu/fxos8700_core.c                   | 1 -
>  drivers/iio/imu/kmx61.c                           | 1 -
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c      | 1 -
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c      | 1 -
>  drivers/iio/industrialio-core.c                   | 1 +
>  drivers/iio/light/adjd_s311.c                     | 1 -
>  drivers/iio/light/adux1020.c                      | 1 -
>  drivers/iio/light/al3010.c                        | 1 -
>  drivers/iio/light/al3320a.c                       | 1 -
>  drivers/iio/light/apds9300.c                      | 1 -
>  drivers/iio/light/as73211.c                       | 1 -
>  drivers/iio/light/bh1750.c                        | 1 -
>  drivers/iio/light/bh1780.c                        | 1 -
>  drivers/iio/light/cm32181.c                       | 1 -
>  drivers/iio/light/cm3232.c                        | 1 -
>  drivers/iio/light/cm3323.c                        | 1 -
>  drivers/iio/light/cm3605.c                        | 1 -
>  drivers/iio/light/cm36651.c                       | 1 -
>  drivers/iio/light/gp2ap002.c                      | 1 -
>  drivers/iio/light/gp2ap020a00f.c                  | 1 -
>  drivers/iio/light/hid-sensor-als.c                | 1 -
>  drivers/iio/light/hid-sensor-prox.c               | 1 -
>  drivers/iio/light/iqs621-als.c                    | 1 -
>  drivers/iio/light/isl29018.c                      | 1 -
>  drivers/iio/light/isl29028.c                      | 1 -
>  drivers/iio/light/isl29125.c                      | 1 -
>  drivers/iio/light/jsa1212.c                       | 1 -
>  drivers/iio/light/lm3533-als.c                    | 1 -
>  drivers/iio/light/ltr501.c                        | 1 -
>  drivers/iio/light/lv0104cs.c                      | 1 -
>  drivers/iio/light/max44009.c                      | 1 -
>  drivers/iio/light/noa1305.c                       | 1 -
>  drivers/iio/light/opt3001.c                       | 1 -
>  drivers/iio/light/pa12203001.c                    | 1 -
>  drivers/iio/light/rpr0521.c                       | 1 -
>  drivers/iio/light/si1133.c                        | 1 -
>  drivers/iio/light/si1145.c                        | 1 -
>  drivers/iio/light/st_uvis25_core.c                | 1 -
>  drivers/iio/light/stk3310.c                       | 1 -
>  drivers/iio/light/tcs3414.c                       | 1 -
>  drivers/iio/light/tcs3472.c                       | 1 -
>  drivers/iio/light/tsl2563.c                       | 1 -
>  drivers/iio/light/tsl2583.c                       | 1 -
>  drivers/iio/light/tsl2772.c                       | 1 -
>  drivers/iio/light/tsl4531.c                       | 1 -
>  drivers/iio/light/us5182d.c                       | 1 -
>  drivers/iio/light/vcnl4000.c                      | 1 -
>  drivers/iio/light/vcnl4035.c                      | 1 -
>  drivers/iio/light/veml6030.c                      | 1 -
>  drivers/iio/light/veml6070.c                      | 1 -
>  drivers/iio/light/vl6180.c                        | 1 -
>  drivers/iio/light/zopt2201.c                      | 1 -
>  drivers/iio/magnetometer/ak8974.c                 | 1 -
>  drivers/iio/magnetometer/ak8975.c                 | 1 -
>  drivers/iio/magnetometer/bmc150_magn.c            | 1 -
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c     | 1 -
>  drivers/iio/magnetometer/hmc5843_core.c           | 1 -
>  drivers/iio/magnetometer/mag3110.c                | 1 -
>  drivers/iio/magnetometer/mmc35240.c               | 1 -
>  drivers/iio/magnetometer/rm3100-core.c            | 1 -
>  drivers/iio/magnetometer/st_magn_core.c           | 1 -
>  drivers/iio/multiplexer/iio-mux.c                 | 1 -
>  drivers/iio/orientation/hid-sensor-incl-3d.c      | 1 -
>  drivers/iio/orientation/hid-sensor-rotation.c     | 1 -
>  drivers/iio/position/iqs624-pos.c                 | 1 -
>  drivers/iio/potentiometer/max5481.c               | 1 -
>  drivers/iio/potentiometer/max5487.c               | 1 -
>  drivers/iio/potentiostat/lmp91000.c               | 1 -
>  drivers/iio/pressure/abp060mg.c                   | 1 -
>  drivers/iio/pressure/bmp280-core.c                | 1 -
>  drivers/iio/pressure/dlhl60d.c                    | 1 -
>  drivers/iio/pressure/dps310.c                     | 1 -
>  drivers/iio/pressure/hid-sensor-press.c           | 1 -
>  drivers/iio/pressure/hp03.c                       | 1 -
>  drivers/iio/pressure/hp206c.c                     | 1 -
>  drivers/iio/pressure/icp10100.c                   | 1 -
>  drivers/iio/pressure/mpl115.c                     | 1 -
>  drivers/iio/pressure/mpl3115.c                    | 1 -
>  drivers/iio/pressure/ms5611_core.c                | 1 -
>  drivers/iio/pressure/ms5637.c                     | 1 -
>  drivers/iio/pressure/st_pressure_core.c           | 1 -
>  drivers/iio/pressure/t5403.c                      | 1 -
>  drivers/iio/pressure/zpa2326.c                    | 1 -
>  drivers/iio/proximity/as3935.c                    | 1 -
>  drivers/iio/proximity/isl29501.c                  | 1 -
>  drivers/iio/proximity/mb1232.c                    | 1 -
>  drivers/iio/proximity/ping.c                      | 1 -
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 -
>  drivers/iio/proximity/rfd77402.c                  | 1 -
>  drivers/iio/proximity/srf04.c                     | 1 -
>  drivers/iio/proximity/srf08.c                     | 1 -
>  drivers/iio/proximity/sx9310.c                    | 1 -
>  drivers/iio/proximity/sx9500.c                    | 1 -
>  drivers/iio/proximity/vcnl3020.c                  | 1 -
>  drivers/iio/proximity/vl53l0x-i2c.c               | 1 -
>  drivers/iio/resolver/ad2s1200.c                   | 1 -
>  drivers/iio/resolver/ad2s90.c                     | 1 -
>  drivers/iio/temperature/hid-sensor-temperature.c  | 1 -
>  drivers/iio/temperature/iqs620at-temp.c           | 1 -
>  drivers/iio/temperature/ltc2983.c                 | 1 -
>  drivers/iio/temperature/max31856.c                | 1 -
>  drivers/iio/temperature/maxim_thermocouple.c      | 1 -
>  drivers/iio/temperature/mlx90614.c                | 1 -
>  drivers/iio/temperature/mlx90632.c                | 1 -
>  drivers/iio/temperature/tmp006.c                  | 1 -
>  drivers/iio/temperature/tmp007.c                  | 1 -
>  drivers/iio/temperature/tsys01.c                  | 1 -
>  drivers/iio/temperature/tsys02d.c                 | 1 -
>  drivers/input/touchscreen/tsc2007_iio.c           | 1 -
>  drivers/platform/x86/toshiba_acpi.c               | 1 -
>  drivers/staging/iio/accel/adis16203.c             | 1 -
>  drivers/staging/iio/accel/adis16240.c             | 1 -
>  drivers/staging/iio/adc/ad7280a.c                 | 1 -
>  drivers/staging/iio/adc/ad7816.c                  | 1 -
>  drivers/staging/iio/addac/adt7316.c               | 1 -
>  drivers/staging/iio/cdc/ad7150.c                  | 2 --
>  drivers/staging/iio/cdc/ad7746.c                  | 1 -
>  drivers/staging/iio/frequency/ad9832.c            | 1 -
>  drivers/staging/iio/frequency/ad9834.c            | 1 -
>  drivers/staging/iio/meter/ade7854.c               | 1 -
>  drivers/staging/iio/resolver/ad2s1210.c           | 1 -
>  319 files changed, 1 insertion(+), 321 deletions(-)
> 

