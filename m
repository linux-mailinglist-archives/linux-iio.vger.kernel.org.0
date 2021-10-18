Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746414325C5
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhJRSAX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 18 Oct 2021 14:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231398AbhJRSAT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 14:00:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A1D860F0F;
        Mon, 18 Oct 2021 17:58:07 +0000 (UTC)
Date:   Mon, 18 Oct 2021 19:02:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PULL V2] 1st set of IIO new device support, features and
 cleanup for  the 5.16 cycle
Message-ID: <20211018190222.3584bc12@jic23-huawei>
In-Reply-To: <20211017113608.5d67605b@jic23-huawei>
References: <20211017113608.5d67605b@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Oct 2021 11:36:08 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.16a-split-v2
> 
> for you to fetch changes up to ec20da0c69b2c6d0f2864097e791fac1b04d3e4f:
> 
>   iio: imx8qxp-adc: mark PM functions as __maybe_unused (2021-10-17 11:06:07 +0100)

This one is bad because I forgot to fix up fixes tags after the rebase.


> 
> ----------------------------------------------------------------
> First set of IIO new device and feature support for the 5.16 cycle
> 
> Counter subsystem changes now sent separately.
> 
> This has been a busy cycle, so lots here and a few more stragglers to
> come next week.
> 
> Big new feature in this cycle is probably output buffer support.
> This has been in the works for a very long time so it's great to see
> Mihail pick up the challenge and build upon his predecessors work to finally
> bring this feature to mainline.
> 
> New device support
> ------------------
> 
> * adi,adxl313
>   - New driver and dt bindings for this low power accelerometer.
> * adi,adxl355
>   - New driver and dt bindings for this accelerometer.
>   - Later series adds buffer support.
> * asahi-kasei,ak8975
>   - Minor additions to driver to support ak09916
> * aspeed,aspeed-adc
>   - Substantial rework plus feature additions to add support for the
>     ast2600 including a new dt bindings doc.
> * atmel,at91_sama5d2
>   - Rework and support introduced for the sama7g5 parts.
> * maxim,max31865
>   - New driver and bindings for this RTD temperature sensor chip.
> * nxp,imx8qxp
>   - New driver and bindings for the ADC found on the i.MX 8QuadXPlus Soc.
> * senseair,sunrise
>   - New driver and bindings for this family of carbon dioxide gas sensors.
> * sensiron,scd4x
>   - New driver and bindings for this carbon dioxide gas sensor.
> 
> New features
> ------------
> 
> * Output buffer support.  Works in a similar fashion to input buffers, but
>   in this case userspace pushes data into the kfifo which is then drained
>   to the device when a trigger occurs.  Support added to the ad5766 DAC
>   driver.
> * Core, devm_iio_map_array_register() to avoid need for
>   devm_add_action_or_reset() based cleanup in fully managed allocation
>   drivers.
> * Core iio_push_to_buffers_with_ts_unaligned() function to safely handle a
>   few drivers where it really hard to ensure the correct data alignment in
>   an iio_push_to_buffers_with_timestamp() call. Note this uses a bounce
>   buffer so should be avoided whenever possible.  Used in the ti,adc108s102,
>   invense,mpu3050 and adi,adis16400.  This closes the last   known set
>   of drivers with alignment issues at this interface.
> * maxim,max1027
>   - Substantial rework to this driver main target of which was supporting
>     use of other triggers than it's own EOC interrupt.
>   - Transfer optimization.
> * nxp,fxls8962af
>   - Threshold even support including using it as a wakeup source.
> 
> Cleanups, minor fixes etc
> -------------------------
> 
> Chances of a common type to multiple drivers:
> 
> * devm_ conversion and drop of .remove() callbacks in:
>   - adi,ad5064
>   - adi,ad7291
>   - adi,ad7303
>   - adi,ad7746
>   - adi,ad9832
>   - adi,adis16080
>   - dialog,da9150-gpadc
>   - intel,mrfld_adc
>   - marvell,berlin2
>   - maxim,max1363
>   - maxim,max44000
>   - nuvoton,nau7802
>   - st_sensors (includes a lot of rework!)
>   - ti,ads8344
>   - ti,lp8788
> 
> * devm_platform_ioremap_resource() used to reduce boilerplate
>   - cirrus,ep93xx
>   - rockchip,saradc
>   - stm,stm32-dac
> 
> * Use dev_err_probe() in more places to both not print on deferred probe and
>   ensure a reason for the deferral is available for debug purposes.
>   - adi,ad8801
>   - capella,cm36651
>   - linear,ltc1660
>   - maxim,ds4424
>   - maxim,max5821
>   - microchip,mcp4922
>   - nxp,lpc18xx
>   - onnn,noa1305
>   - st,lsm9ds0
>   - st,st_sensors
>   - st,stm32-dac
>   - ti,afe4403
>   - ti,afe4404
>   - ti,dac7311
> 
> * Drop error returns in SPI and I2C remove() functions as they are ignored and
>   long term plan is to change these all over to returning void. In some cases
>   these patches just make it 'obvious' they always return 0 where it was the
>   case before but not easy to tell.
>   - adi,ad5380
>   - adi,ad5446
>   - adi,ad5686
>   - adi,ad5592r
>   - bosch,bma400
>   - bosch,bmc150
>   - fsl,mma7455
>   - honeywell,hmc5843
>   - kionix,kxsd9
>   - maxim,max5487
>   - meas,ms5611
>   - ti,afe4403
> 
> Driver specific changes
> 
> * adi,ad5770r
>   - Bring driver inline with documented bindings.
> * adi,ad7746
>   - Trivial style fix
> * adi,ad7949
>   - Express some magic values as the underlying parts via new #defines.
>   - Make it work with SPI controllers that don't support 14 or 16 bit messages
>   - Support selection of voltage reference from dt including expanding the
>     dt-bindings to cover this new functionality.
> * adi,ad799x
>   - Implement selection of external reference voltage on AD7991, AD7995 and
>     AD7999.
>   - Add missing dt-bindings doc for devices supported by this driver.
> * adi,adislib
>   - Move interrupt startup to better location in startup flow.
>   - Handle devices that cannot mask/unmask the drdy pin and must instead mask
>     at the interrupt controller.  Applies to the adis16460 and adis16475 from
>     which we then drop equivalent code.
> * adi,ltc2983
>   - Add support for optional reset pin.
>   - Fail to probe if no channels specified in dt binding.
> * asahi-kasei,ak8975
>   - dt-binding additions of missing vid-supply regulator.
> * aspeed,aspeed-adc
>   - Typo fix.
> * fsl,mma7660
>   - Mark acpi_device_id table __maybe_unused to avoid build warning.
> * fsl,imx25-gcq
>   - Avoid initializing regulators that aren't used.
> * invensense,mpu3050
>   - Drop a dead protection against a clash with the old input driver.
> * invensense,mpu6050
>   - Rework code to not use strcpy() and hence avoid possibility of wrong sized
>     buffers. Note this wasn't a bug, but the new code is a lot more readable.
>   - Mark acpi_device_id table __maybe_unused to avoid build warning.
> * kionix,kxcjk1013
>   - dt-binding addition to note it supports interrupts.
> * marvell,berlin2-adc
>   - Enable COMPILE_TEST building.
> * maxim,max1027
>   - Avoid returning success in an error path.
> * nxp,imx8qxp
>   - Fix warning when runtime pm not enabled via __maybe_unused.
> * ricoh,rn5t618
>   - Use the new devm_iio_map_array_register() instead of open coding the same.
> * samsung,exynos_adc
>   - Improve kconfig help text.
> * st,lsm6dsx
>   - Move max_fifo_size into the fifo_ops structure where the other configuration
>     parameters are found.
> * st,st_sensors:
>   - Reorder to ensure we turn the power off after removing userspace interfaces.
> * senseair,sunrise
>   - Add missing I2C dependency.
> * ti,twl6030
>   - Small code tidy up.
> 
> ----------------------------------------------------------------
> Alexander Vorwerk (1):
>       staging: iio: cdc: remove braces from single line if blocks
> 
> Alexandru Ardelean (24):
>       iio: st_sensors: disable regulators after device unregistration
>       iio: st_sensors: remove st_sensors_deallocate_trigger() function
>       iio: st_sensors: remove st_sensors_power_disable() function
>       iio: st_sensors: remove all driver remove functions
>       iio: st_sensors: remove reference to parent device object on st_sensor_data
>       iio: adc: ti-ads8344: convert probe to device-managed
>       iio: dac: ad7303: convert probe to full device-managed
>       staging: iio: ad9832: convert probe to device-managed
>       iio: dac: ad5064: convert probe to full device-managed
>       iio: gyro: adis16080: use devm_iio_device_register() in probe
>       iio: light: max44000: use device-managed functions in probe
>       iio: adc: fsl-imx25-gcq: initialize regulators as needed
>       iio: inkern: introduce devm_iio_map_array_register() short-hand function
>       iio: adc: intel_mrfld_adc: convert probe to full device-managed
>       iio: adc: axp288_adc: convert probe to full device-managed
>       iio: adc: lp8788_adc: convert probe to full-device managed
>       iio: adc: da9150-gpadc: convert probe to full-device managed
>       iio: adc: nau7802: convert probe to full device-managed
>       iio: adc: max1363: convert probe to full device-managed
>       iio: adc: rn5t618-adc: use devm_iio_map_array_register() function
>       iio: adc: berlin2-adc: convert probe to device-managed only
>       iio: adc: Kconfig: add COMPILE_TEST dep for berlin2-adc
>       iio: adc: ad7291: convert probe to device-managed only
>       iio: triggered-buffer: extend support to configure output buffers
> 
> Arnd Bergmann (1):
>       iio: imx8qxp-adc: mark PM functions as __maybe_unused
> 
> Billy Tsai (13):
>       dt-bindings: iio: adc: Add ast2600-adc bindings
>       iio: adc: aspeed: completes the bitfield declare.
>       iio: adc: aspeed: Keep model data to driver data.
>       iio: adc: aspeed: Restructure the model data
>       iio: adc: aspeed: Add vref config function
>       iio: adc: aspeed: Use model_data to set clk scaler.
>       iio: adc: aspeed: Use devm_add_action_or_reset.
>       iio: adc: aspeed: Support ast2600 adc.
>       iio: adc: aspeed: Fix the calculate error of clock.
>       iio: adc: aspeed: Add func to set sampling rate.
>       iio: adc: aspeed: Add compensation phase.
>       iio: adc: aspeed: Support battery sensing.
>       iio: adc: aspeed: Get and set trimming data.
> 
> Cai Huoqing (20):
>       iio: ep93xx: Make use of the helper function devm_platform_ioremap_resource()
>       iio: dac: stm32-dac: Make use of the helper function devm_platform_ioremap_resource()
>       iio: adc: rockchip_saradc: Make use of the helper function devm_platform_ioremap_resource()
>       iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC
>       dt-bindings: iio: adc: Add binding documentation for NXP IMX8QXP ADC
>       MAINTAINERS: Add the driver info of the NXP IMX8QXP
>       iio: dac: ad8801: Make use of the helper function dev_err_probe()
>       iio: dac: lpc18xx_dac: Make use of the helper function dev_err_probe()
>       iio: dac: ltc1660: Make use of the helper function dev_err_probe()
>       iio: dac: ds4424: Make use of the helper function dev_err_probe()
>       iio: dac: max5821: Make use of the helper function dev_err_probe()
>       iio: dac: mcp4922: Make use of the helper function dev_err_probe()
>       iio: dac: stm32-dac: Make use of the helper function dev_err_probe()
>       iio: dac: ti-dac7311: Make use of the helper function dev_err_probe()
>       iio: st_sensors: Make use of the helper function dev_err_probe()
>       iio: st_lsm9ds0: Make use of the helper function dev_err_probe()
>       iio: health: afe4403: Make use of the helper function dev_err_probe()
>       iio: health: afe4404: Make use of the helper function dev_err_probe()
>       iio: light: cm36651: Make use of the helper function dev_err_probe()
>       iio: light: noa1305: Make use of the helper function dev_err_probe()
> 
> Colin Ian King (1):
>       iio: adc: aspeed: Fix spelling mistake "battey" -> "battery"
> 
> Dan Carpenter (1):
>       iio: adc: max1027: fix error code in max1027_wait_eoc()
> 
> Daniel Palmer (2):
>       iio: imu: inv_mpu6050: Mark acpi match table as maybe unused
>       iio: accel: mma7660: Mark acpi match table as maybe unused
> 
> David Heidelberg (2):
>       dt-bindings: iio: kionix,kxcjk1013: driver support interrupts
>       dt-bindings: iio: magnetometer: asahi-kasei,ak8975 add vid reg
> 
> Eugen Hristev (8):
>       dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
>       iio: adc: at91-sama5d2_adc: initialize hardware after clock is started
>       iio: adc: at91-sama5d2_adc: remove unused definition
>       iio: adc: at91-sama5d2_adc: convert to platform specific data structures
>       iio: adc: at91-sama5d2_adc: add support for separate end of conversion registers
>       iio: adc: at91-sama5d2_adc: add helper for COR register
>       iio: adc: at91-sama5d2_adc: add support for sama7g5 device
>       iio: adc: at91-sama5d2_adc: update copyright and authors information
> 
> Florian Boor (2):
>       iio: adc: ad799x: Implement selecting external reference voltage input on AD7991, AD7995 and AD7999.
>       dt-bindings: iio: ad779x: Add binding document
> 
> Jacopo Mondi (4):
>       dt-bindings: iio: chemical: Document senseair,sunrise CO2 sensor
>       iio: ABI: docs: Document Senseair Sunrise ABI
>       iio: chemical: Add Senseair Sunrise 006-0-007 driver
>       iio: ABI: Document in_concentration_co2_scale
> 
> Jonathan Cameron (4):
>       iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()
>       iio: adc: ti-adc108s102: Fix alignment of buffer pushed to iio buffers.
>       iio: gyro: mpu3050: Fix alignment and size issues with buffers.
>       iio: imu: adis16400: Fix buffer alignment requirements.
> 
> Krzysztof Kozlowski (1):
>       iio: adc: exynos: describe drivers in KConfig
> 
> Lars-Peter Clausen (1):
>       iio: kfifo-buffer: Add output buffer support
> 
> Len Baker (1):
>       drivers/iio: Remove all strcpy() uses
> 
> Liam Beguin (5):
>       iio: adc: ad7949: define and use bitfield names
>       iio: adc: ad7949: enable use with non 14/16-bit controllers
>       iio: adc: ad7949: add vref selection support
>       dt-bindings: iio: adc: ad7949: update voltage reference bindings
>       iio: adc: ad7949: use devm managed functions
> 
> Lorenzo Bianconi (1):
>       iio: imu: st_lsm6dsx: move max_fifo_size in st_lsm6dsx_fifo_ops
> 
> Lucas Stankus (2):
>       dt-bindings: iio: accel: Add binding documentation for ADXL313
>       iio: accel: Add driver support for ADXL313
> 
> Lukas Bulwahn (1):
>       iio: gyro: remove dead config dependencies on INPUT_MPU3050
> 
> Matt Ranostay (1):
>       iio: magnetometer: ak8975: add AK09116 support
> 
> Mihail Chindris (2):
>       iio: Add output buffer support
>       drivers:iio:dac:ad5766.c: Add trigger buffer
> 
> Miquel Raynal (16):
>       iio: adc: max1027: Fix style
>       iio: adc: max1027: Drop extra warning message
>       iio: adc: max1027: Drop useless debug messages
>       iio: adc: max1027: Minimize the number of converted channels
>       iio: adc: max1027: Rename a helper
>       iio: adc: max1027: Create a helper to enable/disable the cnvst trigger
>       iio: adc: max1027: Simplify the _set_trigger_state() helper
>       iio: adc: max1027: Ensure a default cnvst trigger configuration
>       iio: adc: max1027: Create a helper to configure the channels to scan
>       iio: adc: max1027: Prevent single channel accesses during buffer reads
>       iio: adc: max1027: Separate the IRQ handler from the read logic
>       iio: adc: max1027: Introduce an end of conversion helper
>       iio: adc: max1027: Stop requesting a threaded IRQ
>       iio: adc: max1027: Use the EOC IRQ when populated for single reads
>       iio: adc: max1027: Allow all kind of triggers to be used
>       iio: adc: max1027: Don't reject external triggers when there is no IRQ
> 
> Navin Sankar Velliangiri (2):
>       iio: temperature: Add MAX31865 RTD Support
>       dt-bindings: iio: temperature: add MAXIM max31865 support
> 
> Nuno Sá (7):
>       iio: ad5770r: make devicetree property reading consistent
>       iio: ltc2983: add support for optional reset gpio
>       iio: ltc2983: fail probe if no channels are given
>       iio: adis: do not disabe IRQs in 'adis_init()'
>       iio: adis: handle devices that cannot unmask the drdy pin
>       iio: adis16475: make use of the new unmasked_drdy flag
>       iio: adis16460: make use of the new unmasked_drdy flag
> 
> Puranjay Mohan (4):
>       dt-bindings: iio: accel: Add DT binding doc for ADXL355
>       iio: accel: Add driver support for ADXL355
>       iio: accel: adxl355: use if(ret) in place of ret < 0
>       iio: accel: adxl355: Add triggered buffer support
> 
> Randy Dunlap (1):
>       iio: chemical: SENSEAIR_SUNRISE_CO2 depends on I2C
> 
> Roan van Dijk (4):
>       dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
>       MAINTAINERS: Add myself as maintainer of the scd4x driver
>       drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor
>       iio: documentation: Document scd4x calibration use
> 
> Sean Nyekjaer (2):
>       iio: accel: fxls8962af: add threshold event handling
>       iio: accel: fxls8962af: add wake on event
> 
> Tang Bin (1):
>       iio: adc: twl6030-gpadc: Use the defined variable to clean code
> 
> Uwe Kleine-König (13):
>       iio: accel: bma400: Make bma400_remove() return void
>       iio: accel: bmc150: Make bmc150_accel_core_remove() return void
>       iio: accel: bmi088: Make bmi088_accel_core_remove() return void
>       iio: accel: kxsd9: Make kxsd9_common_remove() return void
>       iio: accel: mma7455: Make mma7455_core_remove() return void
>       iio: dac: ad5380: Make ad5380_remove() return void
>       iio: dac: ad5446: Make ad5446_remove() return void
>       iio: dac: ad5592r: Make ad5592r_remove() return void
>       iio: dac: ad5686: Make ad5686_remove() return void
>       iio: health: afe4403: Don't return an error in .remove()
>       iio: magn: hmc5843: Make hmc5843_common_remove() return void
>       iio: potentiometer: max5487: Don't return an error in .remove()
>       iio: pressure: ms5611: Make ms5611_remove() return void
> 
>  Documentation/ABI/testing/sysfs-bus-iio            |  42 ++
>  .../ABI/testing/sysfs-bus-iio-chemical-sunrise-co2 |  38 +
>  Documentation/ABI/testing/sysfs-bus-iio-scd30      |  34 -
>  .../ABI/testing/sysfs-bus-iio-temperature-max31865 |  20 +
>  .../devicetree/bindings/iio/accel/adi,adxl313.yaml |  86 +++
>  .../devicetree/bindings/iio/accel/adi,adxl355.yaml |  88 +++
>  .../bindings/iio/accel/kionix,kxcjk1013.yaml       |   3 +
>  .../devicetree/bindings/iio/adc/adi,ad7949.yaml    |  51 +-
>  .../devicetree/bindings/iio/adc/adi,ad799x.yaml    |  73 ++
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 100 +++
>  .../bindings/iio/adc/atmel,sama5d2-adc.yaml        |   1 +
>  .../bindings/iio/adc/nxp,imx8qxp-adc.yaml          |  78 +++
>  .../bindings/iio/chemical/senseair,sunrise.yaml    |  55 ++
>  .../bindings/iio/chemical/sensirion,scd4x.yaml     |  46 ++
>  .../iio/magnetometer/asahi-kasei,ak8975.yaml       |   7 +
>  .../bindings/iio/temperature/maxim,max31865.yaml   |  52 ++
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  Documentation/driver-api/driver-model/devres.rst   |   1 +
>  MAINTAINERS                                        |  36 +
>  drivers/iio/accel/Kconfig                          |  62 ++
>  drivers/iio/accel/Makefile                         |   6 +
>  drivers/iio/accel/adxl313.h                        |  54 ++
>  drivers/iio/accel/adxl313_core.c                   | 332 +++++++++
>  drivers/iio/accel/adxl313_i2c.c                    |  66 ++
>  drivers/iio/accel/adxl313_spi.c                    |  92 +++
>  drivers/iio/accel/adxl355.h                        |  21 +
>  drivers/iio/accel/adxl355_core.c                   | 765 +++++++++++++++++++++
>  drivers/iio/accel/adxl355_i2c.c                    |  62 ++
>  drivers/iio/accel/adxl355_spi.c                    |  65 ++
>  drivers/iio/accel/adxl372.c                        |   1 +
>  drivers/iio/accel/bma400.h                         |   2 +-
>  drivers/iio/accel/bma400_core.c                    |   7 +-
>  drivers/iio/accel/bma400_i2c.c                     |   4 +-
>  drivers/iio/accel/bma400_spi.c                     |   4 +-
>  drivers/iio/accel/bmc150-accel-core.c              |   5 +-
>  drivers/iio/accel/bmc150-accel-i2c.c               |   4 +-
>  drivers/iio/accel/bmc150-accel-spi.c               |   4 +-
>  drivers/iio/accel/bmc150-accel.h                   |   2 +-
>  drivers/iio/accel/bmi088-accel-core.c              |   4 +-
>  drivers/iio/accel/bmi088-accel-spi.c               |   4 +-
>  drivers/iio/accel/bmi088-accel.h                   |   2 +-
>  drivers/iio/accel/fxls8962af-core.c                | 347 +++++++++-
>  drivers/iio/accel/kxsd9-i2c.c                      |   4 +-
>  drivers/iio/accel/kxsd9-spi.c                      |   4 +-
>  drivers/iio/accel/kxsd9.c                          |   4 +-
>  drivers/iio/accel/kxsd9.h                          |   2 +-
>  drivers/iio/accel/mma7455.h                        |   2 +-
>  drivers/iio/accel/mma7455_core.c                   |   4 +-
>  drivers/iio/accel/mma7455_i2c.c                    |   4 +-
>  drivers/iio/accel/mma7455_spi.c                    |   4 +-
>  drivers/iio/accel/mma7660.c                        |   2 +-
>  drivers/iio/accel/st_accel_core.c                  |  31 +-
>  drivers/iio/accel/st_accel_i2c.c                   |  23 +-
>  drivers/iio/accel/st_accel_spi.c                   |  23 +-
>  drivers/iio/adc/Kconfig                            |  18 +-
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ad7291.c                           |  70 +-
>  drivers/iio/adc/ad7949.c                           | 254 +++++--
>  drivers/iio/adc/ad799x.c                           |  68 +-
>  drivers/iio/adc/aspeed_adc.c                       | 598 +++++++++++++---
>  drivers/iio/adc/at91-sama5d2_adc.c                 | 598 +++++++++++-----
>  drivers/iio/adc/axp288_adc.c                       |  28 +-
>  drivers/iio/adc/berlin2-adc.c                      |  34 +-
>  drivers/iio/adc/da9150-gpadc.c                     |  27 +-
>  drivers/iio/adc/ep93xx_adc.c                       |   4 +-
>  drivers/iio/adc/fsl-imx25-gcq.c                    |  55 +-
>  drivers/iio/adc/imx8qxp-adc.c                      | 494 +++++++++++++
>  drivers/iio/adc/intel_mrfld_adc.c                  |  24 +-
>  drivers/iio/adc/lp8788_adc.c                       |  31 +-
>  drivers/iio/adc/max1027.c                          | 278 +++++---
>  drivers/iio/adc/max1363.c                          |  82 +--
>  drivers/iio/adc/nau7802.c                          |  50 +-
>  drivers/iio/adc/rn5t618-adc.c                      |  13 +-
>  drivers/iio/adc/rockchip_saradc.c                  |   4 +-
>  drivers/iio/adc/ti-adc108s102.c                    |  11 +-
>  drivers/iio/adc/ti-ads8344.c                       |  27 +-
>  drivers/iio/adc/twl6030-gpadc.c                    |   6 +-
>  drivers/iio/buffer/industrialio-triggered-buffer.c |   8 +-
>  drivers/iio/buffer/kfifo_buf.c                     |  50 ++
>  drivers/iio/chemical/Kconfig                       |  24 +
>  drivers/iio/chemical/Makefile                      |   2 +
>  drivers/iio/chemical/scd4x.c                       | 691 +++++++++++++++++++
>  drivers/iio/chemical/sunrise_co2.c                 | 537 +++++++++++++++
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |   5 +-
>  drivers/iio/common/st_sensors/st_sensors_core.c    |  48 +-
>  drivers/iio/common/st_sensors/st_sensors_i2c.c     |   1 -
>  drivers/iio/common/st_sensors/st_sensors_spi.c     |   1 -
>  drivers/iio/common/st_sensors/st_sensors_trigger.c |  53 +-
>  drivers/iio/dac/ad5064.c                           |  49 +-
>  drivers/iio/dac/ad5380.c                           |  15 +-
>  drivers/iio/dac/ad5446.c                           |  12 +-
>  drivers/iio/dac/ad5592r-base.c                     |   4 +-
>  drivers/iio/dac/ad5592r-base.h                     |   2 +-
>  drivers/iio/dac/ad5592r.c                          |   4 +-
>  drivers/iio/dac/ad5593r.c                          |   4 +-
>  drivers/iio/dac/ad5686-spi.c                       |   4 +-
>  drivers/iio/dac/ad5686.c                           |   4 +-
>  drivers/iio/dac/ad5686.h                           |   2 +-
>  drivers/iio/dac/ad5696-i2c.c                       |   4 +-
>  drivers/iio/dac/ad5766.c                           |  42 ++
>  drivers/iio/dac/ad5770r.c                          |   2 +-
>  drivers/iio/dac/ad7303.c                           |  47 +-
>  drivers/iio/dac/ad8801.c                           |  11 +-
>  drivers/iio/dac/ds4424.c                           |   9 +-
>  drivers/iio/dac/lpc18xx_dac.c                      |  14 +-
>  drivers/iio/dac/ltc1660.c                          |   7 +-
>  drivers/iio/dac/max5821.c                          |   9 +-
>  drivers/iio/dac/mcp4922.c                          |   7 +-
>  drivers/iio/dac/stm32-dac-core.c                   |  18 +-
>  drivers/iio/dac/ti-dac7311.c                       |   7 +-
>  drivers/iio/gyro/Kconfig                           |   1 -
>  drivers/iio/gyro/adis16080.c                       |  11 +-
>  drivers/iio/gyro/mpu3050-core.c                    |  24 +-
>  drivers/iio/gyro/st_gyro_core.c                    |  27 +-
>  drivers/iio/gyro/st_gyro_i2c.c                     |  23 +-
>  drivers/iio/gyro/st_gyro_spi.c                     |  23 +-
>  drivers/iio/health/afe4403.c                       |  14 +-
>  drivers/iio/health/afe4404.c                       |   8 +-
>  drivers/iio/iio_core.h                             |   4 +
>  drivers/iio/imu/adis.c                             |  17 +-
>  drivers/iio/imu/adis16400.c                        |  20 +-
>  drivers/iio/imu/adis16460.c                        |  18 +-
>  drivers/iio/imu/adis16475.c                        |  19 +-
>  drivers/iio/imu/adis_trigger.c                     |   4 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         |  36 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   4 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  16 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0.h            |   1 -
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |  29 +-
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   6 -
>  drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |   6 -
>  drivers/iio/industrialio-buffer.c                  | 173 ++++-
>  drivers/iio/industrialio-core.c                    |   1 +
>  drivers/iio/inkern.c                               |  17 +
>  drivers/iio/light/cm36651.c                        |   7 +-
>  drivers/iio/light/max44000.c                       |  17 +-
>  drivers/iio/light/noa1305.c                        |   7 +-
>  drivers/iio/magnetometer/Kconfig                   |   2 +-
>  drivers/iio/magnetometer/ak8975.c                  |  35 +
>  drivers/iio/magnetometer/hmc5843.h                 |   2 +-
>  drivers/iio/magnetometer/hmc5843_core.c            |   4 +-
>  drivers/iio/magnetometer/hmc5843_i2c.c             |   4 +-
>  drivers/iio/magnetometer/hmc5843_spi.c             |   4 +-
>  drivers/iio/magnetometer/st_magn_core.c            |  29 +-
>  drivers/iio/magnetometer/st_magn_i2c.c             |  23 +-
>  drivers/iio/magnetometer/st_magn_spi.c             |  23 +-
>  drivers/iio/potentiometer/max5487.c                |   7 +-
>  drivers/iio/pressure/ms5611.h                      |   2 +-
>  drivers/iio/pressure/ms5611_core.c                 |   4 +-
>  drivers/iio/pressure/ms5611_i2c.c                  |   4 +-
>  drivers/iio/pressure/ms5611_spi.c                  |   4 +-
>  drivers/iio/pressure/st_pressure_core.c            |  27 +-
>  drivers/iio/pressure/st_pressure_i2c.c             |  23 +-
>  drivers/iio/pressure/st_pressure_spi.c             |  23 +-
>  drivers/iio/temperature/Kconfig                    |  10 +
>  drivers/iio/temperature/Makefile                   |   1 +
>  drivers/iio/temperature/ltc2983.c                  |  16 +
>  drivers/iio/temperature/max31865.c                 | 349 ++++++++++
>  drivers/staging/iio/cdc/ad7746.c                   |   4 +-
>  drivers/staging/iio/frequency/ad9832.c             |  82 +--
>  include/linux/iio/buffer.h                         |  11 +
>  include/linux/iio/buffer_impl.h                    |  11 +
>  include/linux/iio/common/st_sensors.h              |  13 -
>  include/linux/iio/driver.h                         |  14 +
>  include/linux/iio/iio-opaque.h                     |   4 +
>  include/linux/iio/imu/adis.h                       |   2 +
>  include/linux/iio/triggered_buffer.h               |  11 +-
>  168 files changed, 6998 insertions(+), 1592 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad799x.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
>  create mode 100644 drivers/iio/accel/adxl313.h
>  create mode 100644 drivers/iio/accel/adxl313_core.c
>  create mode 100644 drivers/iio/accel/adxl313_i2c.c
>  create mode 100644 drivers/iio/accel/adxl313_spi.c
>  create mode 100644 drivers/iio/accel/adxl355.h
>  create mode 100644 drivers/iio/accel/adxl355_core.c
>  create mode 100644 drivers/iio/accel/adxl355_i2c.c
>  create mode 100644 drivers/iio/accel/adxl355_spi.c
>  create mode 100644 drivers/iio/adc/imx8qxp-adc.c
>  create mode 100644 drivers/iio/chemical/scd4x.c
>  create mode 100644 drivers/iio/chemical/sunrise_co2.c
>  create mode 100644 drivers/iio/temperature/max31865.c

