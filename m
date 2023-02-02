Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054B668859F
	for <lists+linux-iio@lfdr.de>; Thu,  2 Feb 2023 18:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjBBRkt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Feb 2023 12:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBBRks (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Feb 2023 12:40:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B338B6D
        for <linux-iio@vger.kernel.org>; Thu,  2 Feb 2023 09:40:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16269B826AB
        for <linux-iio@vger.kernel.org>; Thu,  2 Feb 2023 17:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2255DC433D2;
        Thu,  2 Feb 2023 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675359641;
        bh=OFUs2T+7X+4BMzw08Zdv6VwUj81zPn4OsDY+WQXJyGA=;
        h=Date:From:To:Cc:Subject:From;
        b=QZYmZ5Wg/aAUGNqn5cAW00RJFCSwqeMz3yE2CB55m5S8X1XSznA9xB1BgKiK2ne31
         eoxe/9ASi14gGtvYqv3sGI29vXffW/6gIntr9QKrZr7nX+Nf6e7kInYt+TnCu3kLFx
         fIIMhhGVoYFz4LszW66SXWPUb4M5uE9usiqM/Nc1Cpww2TPyJxQxNaSiC2G9ujmxxv
         0U9/11xuZciE0NVRZFe8MP+/jFZ8e/t0exjCYTdtZVOdtNCLgtySGdKIdnOtwleo3U
         pQOKCzgBIIWKi+hV64Joc7QCyiEctIc/a90NL7AcIvlwqR1a3ui2YX8C7vgS95F5g4
         cA5jIBOH42Rcw==
Date:   Thu, 2 Feb 2023 17:54:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of new device support etc for 6.3
Message-ID: <20230202175440.5579e52e@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.3a

for you to fetch changes up to 4ae612e4af95d72e36f478cad66d47c06b86de68:

  iio: adc: ad7291: Fix indentation error by adding extra spaces (2023-01-2=
8 18:08:47 +0000)

----------------------------------------------------------------
1st set of IIO new device support, features and cleanups for the 6.3 cycle

The usual mixed bag. So far this has been a quiet cycle for IIO.

New device support
* adi,ad8686
  - Add support for the AD5337 DAC - ID and 8 bit channel support.
* maxim,max5522
  - New driver for this 2 channel DAC.
* nxp,imx93-adc
  - New driver for this SoC ADC which is a fresh IP that will probably
    turn up in additional SoCs going forwards.
* st,magn
  - Add support for magnetometer part of LSM303C which is very similar
    to standalone LIS3MDL already supported.
* ti,ads7924
  - New driver for this 4 channel, 12-bit I2C ADC.
* ti,lmp92064
  - New driver for this 12 bit SPI ADC.
* ti,tmag5273
  - New driver for this 3D Hall-Effect Sensor.

Features
* core
  - Add a standard structure for the value pairs in IIO_VAL_INT_PLUS_MICRO
    available attributes and similar.
* cirrus,ep93xx
  - Add DT binding docs and convert driver to DT based probing.
  - Enable testing building with CONFIG_COMPILE_TEST.
* st,stm32-dfsdm
  - Enable ID register support for discovery of hardware capabilities on
    some devices.

Cleanups and minor fixes
* core
  - Drop the custom iio_sysfs_match_string_with_gaps().
    The special ability of this function to skip gaps in an array
    was never used by any upstream driver.
  - Sort headers whilst touching this file.
* tools
  - Fix memory leak in iio_utils.c
* various
  - leftover i2c probe_new() conversions.
  - scnprintf() -> sysfs_emit() cleanups.
  - hand rolled devm enables -> devm_regulator[_bulk]_get_enable()
  - typo fixes
  - dt-binding cleanup (whitespace, excess quotes and similar)
* adi,ad7746
  - Set variable without pointless conditional.
* fsl,mma9551
  - Squash false positives about use of uninitialized variable where
    garbage undergoes an endian conversion before being ignored.
* measspec,ms5611
  - Switch to fully devm_ managed probe() and so drop explicit remove()
* qcom,spmi-adc
  - Use dev_err_probe() to suppress deferred print.
* qcom,spmi-adc5
  - Define a missing channel used for battery identification.
* qcom,spmi-iadc
  - Document a compatible seen in wild.
* semtech,sx9360
  - Fix units on semtech,resolution dt-binding.
* sensiron,scd30
  - dev_err_probe() usage to simplify error paths a little.
* st,lsm6dsx
  - Add missing mount matrix for the gyro IIO device.
* taos,tsl2563
  - Respect firmware configured interrupt polarity if present.
  - Use i2c_smbus_write_word_data() in a few cases not previously covered.
  - Factor out duplicated interrupt configuration.
  - Switch to GENMASK() / BIT() from hand coded equivalents.
  - Tidy up unused definitions.
  - Use dev_err_probe() as appropriate.
  - Drop platform_data as no in kernel users and there are better ways to
    do equivalent if any are added.
  - Add local struct device variable to tidy up code.
  - Avoid dance via i2c_client to get the drvdata.
  - Tidy up headers ordering and Makefile ordering.
* ti,adc128s052
  - Use new spi_get_device_match_data().
  - Drop ACPI_PTR() protection.
  - Sort headers whilst here.
  - Use asm instead of incorrect include of asm-generic/unaligned.h
* vishay,vcn4000
  - Interrupt support for vcnl4040 (lots of refactoring needed)
* xilinx,ams
  - Use fwnode_device_is_compatible() instead of open coding it.

----------------------------------------------------------------
Alexander Sverdlin (2):
      dt-bindings: iio: adc: ep93xx: Add cirrus,ep9301-adc description
      iio: adc: ep93xx: Add OF support

Alexander Vorwerk (1):
      drivers: iio: cdc: Drop redundant if check

Andy Shevchenko (19):
      iio: light: tsl2563: Use i2c_smbus_write_word_data() in tsl2563_confi=
gure()
      iio: light: tsl2563: Configure INT in one place
      iio: light: tsl2563: Make use of the macros from bits.h
      iio: light: tsl2563: Drop unused defintion(s)
      iio: light: tsl2563: Simplify with dev_err_probe
      iio: light: tsl2563: Drop legacy platform data code
      iio: light: tsl2563: Utilise temporary variable for struct device
      iio: light: tsl2563: Use dev_get_drvdata() directly in PM callbacks
      iio: light: tsl2563: sort header inclusion alphabetically
      iio: light: tsl2563: Keep Makefile sorted by module name
      iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()
      iio: adc: ti-adc128s052: Drop anti-pattern of ACPI_PTR() use
      iio: adc: ti-adc128s052: Sort headers
      iio: adc: max11410: Use asm intead of asm-generic
      iio: chemical: scd30_core: use sysfs_emit() to instead of scnprintf()
      iio: chemical: scd30_core: Switch to use dev_err_probe()
      iio: adc: xilinx-ams: Convert to use fwnode_device_is_compatible()
      iio: core: Replace iio_sysfs_match_string_with_gaps() by __sysfs_matc=
h_string()
      iio: core: Sort headers

Angelo Dureghello (1):
      iio: dac: add support for max5522

Anup Sharma (1):
      iio: adc: ad7291: Fix indentation error by adding extra spaces

Colin Ian King (2):
      iio: imu: kmx61: Fix spelling mistake "Errow" -> "Error"
      iio: adc: imx93: Fix spelling mistake "geting" -> "getting"

Fabio Estevam (3):
      dt-bindings: iio: dac: ad5686: Add an entry for AD5337
      iio: dac: ad5686: Add support for AD5337
      dt-bindings: iio: adc: max1238: Fix a typo in the description

Ferry Toth (1):
      iio: light: tsl2563: Do not hardcode interrupt trigger type

Gerald Loacker (3):
      iio: add struct declaration for iio types
      dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
      iio: magnetometer: add ti tmag5273 driver

Haibo Chen (2):
      iio: adc: add imx93 adc support
      dt-bindings: iio: adc: Add NXP IMX93 ADC

Harshit Mogalapalli (2):
      iio: accel: mma9551_core: Prevent uninitialized variable in mma9551_r=
ead_status_word()
      iio: accel: mma9551_core: Prevent uninitialized variable in mma9551_r=
ead_config_word()

Hugo Villeneuve (2):
      iio: adc: ti-ads7924: add Texas Instruments ADS7924 driver
      dt-bindings: iio: adc: add Texas Instruments ADS7924

Jonathan Cameron (5):
      iio: accel: bma400: Use devm_regulator_bulk_get_enable()
      iio: pressure: ms5611: Use devm_regulator_get_enable()
      iio: pressure: ms5611: Switch to fully devm_ managed registration.
      iio: adc: ep93xx: Enable wider build testing with COMPILE_TEST
      dt-bindings: iio: dac: Maxim max5522 DAC

Krzysztof Kozlowski (6):
      dt-bindings: iio: adc: maxim,max1363: fix interface typo
      dt-bindings: iio: drop unneeded quotes
      dt-bindings: iio: minor whitespace cleanups
      dt-bindings: iio: correct node names in examples
      dt-bindings: iio: use lowercase hex in examples
      dt-bindings: iio: cleanup examples - indentation

Leonard G=C3=B6hrs (2):
      dt-bindings: iio: adc: add TI LMP92064 controller
      iio: adc: add ADC driver for the TI LMP92064 controller

Luca Weiss (1):
      iio: adc: qcom-spmi-adc5: define ADC5_BAT_ID_100K_PU channel

Marijn Suijten (1):
      iio: adc: qcom-spmi-adc5: Suppress probe-deferral error message

M=C3=A5rten Lindahl (3):
      iio: light: vcnl4000: Prepare for more generic setup
      iio: light: vcnl4000: Make irq handling more generic
      iio: light: vcnl4000: Add interrupt support for vcnl4040

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: add id registers support

Philippe De Muyter (2):
      iio: imu: st_lsm6dsx: fix naming of 'struct iio_info' in st_lsm6dsx_s=
hub.c.
      iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry to gyro channel.

Rayyan Ansari (1):
      dt-bindings: iio/adc: qcom,spmi-iadc: document PM8226 compatible

Rob Herring (1):
      dt-bindings: iio/proximity: semtech,sx9360: Fix 'semtech,resolution' =
type

Samuel Holland (1):
      dt-bindings: iio: adc: ti,adc081c: Document the binding

Stephan Gerhold (3):
      dt-bindings: iio: st-sensors: Add LSM303C accelerometer+magnetometer
      iio: accel: st_accel: Add LSM303C
      iio: magnetometer: st_magn: Add LSM303C

Tom Rix (1):
      iio: imu: fix spdx format

Uwe Kleine-K=C3=B6nig (1):
      iio: light: max44009: Convert to i2c's .probe_new()

Yulong Zhang (1):
      tools/iio/iio_utils:fix memory leak

ye xingchen (2):
      iio: adc: at91-sama5d2_adc: use sysfs_emit() to instead of scnprintf()
      iio: common: scmi_iio: use sysfs_emit() to instead of scnprintf()

 .../bindings/iio/accel/adi,adis16201.yaml          |   2 +-
 .../bindings/iio/accel/adi,adis16240.yaml          |   2 +-
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml |   2 +-
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |   4 +-
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |  52 +-
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |  48 +-
 .../bindings/iio/accel/bosch,bma220.yaml           |   2 +-
 .../bindings/iio/accel/kionix,kxcjk1013.yaml       |   2 +-
 .../bindings/iio/accel/memsensing,msa311.yaml      |   5 +-
 .../bindings/iio/accel/nxp,fxls8962af.yaml         |   4 +-
 .../devicetree/bindings/iio/adc/adi,ad7091r5.yaml  |   8 +-
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |   2 +-
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |  42 +-
 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |   2 +-
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  40 +-
 .../devicetree/bindings/iio/adc/adi,ad7780.yaml    |   2 +-
 .../devicetree/bindings/iio/adc/adi,ad799x.yaml    |  18 +-
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   8 +-
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |  10 +-
 .../bindings/iio/adc/atmel,sama5d2-adc.yaml        |   2 +-
 .../devicetree/bindings/iio/adc/avia-hx711.yaml    |   4 +-
 .../bindings/iio/adc/cirrus,ep9301-adc.yaml        |  47 ++
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml   |  18 +-
 .../devicetree/bindings/iio/adc/maxim,max1027.yaml |   4 +-
 .../devicetree/bindings/iio/adc/maxim,max1238.yaml |   2 +-
 .../devicetree/bindings/iio/adc/maxim,max1241.yaml |   4 +-
 .../devicetree/bindings/iio/adc/maxim,max1363.yaml |   2 +-
 .../bindings/iio/adc/microchip,mcp3911.yaml        |   4 +-
 .../devicetree/bindings/iio/adc/nxp,imx93-adc.yaml |  81 +++
 .../bindings/iio/adc/qcom,pm8018-adc.yaml          |   2 +-
 .../bindings/iio/adc/qcom,spmi-iadc.yaml           |   3 +-
 .../bindings/iio/adc/qcom,spmi-rradc.yaml          |  16 +-
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |   2 +-
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |   6 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   8 +-
 .../devicetree/bindings/iio/adc/st,stmpe-adc.yaml  |   8 +-
 .../devicetree/bindings/iio/adc/ti,adc081c.yaml    |  55 ++
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |   8 +-
 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  |   2 +-
 .../devicetree/bindings/iio/adc/ti,ads7924.yaml    | 110 +++
 .../devicetree/bindings/iio/adc/ti,lmp92064.yaml   |  70 ++
 .../devicetree/bindings/iio/adc/ti,tsc2046.yaml    |  34 +-
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  40 +-
 .../devicetree/bindings/iio/dac/adi,ad5380.yaml    |   1 +
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |   1 +
 .../devicetree/bindings/iio/dac/adi,ad5766.yaml    |  22 +-
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |  88 +--
 .../devicetree/bindings/iio/dac/adi,ltc2688.yaml   |  52 +-
 .../devicetree/bindings/iio/dac/lltc,ltc1660.yaml  |   4 +-
 .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml  |  20 +-
 .../devicetree/bindings/iio/dac/maxim,max5522.yaml |  49 ++
 .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  |   4 +-
 .../devicetree/bindings/iio/dac/ti,dac5571.yaml    |   2 +-
 .../devicetree/bindings/iio/frequency/adf4371.yaml |  12 +-
 .../bindings/iio/gyroscope/adi,adxrs290.yaml       |  14 +-
 .../bindings/iio/gyroscope/nxp,fxas21002c.yaml     |  30 +-
 .../devicetree/bindings/iio/health/ti,afe4403.yaml |   2 +-
 .../devicetree/bindings/iio/health/ti,afe4404.yaml |   2 +-
 .../devicetree/bindings/iio/humidity/dht11.yaml    |   2 +-
 .../bindings/iio/humidity/ti,hdc2010.yaml          |  16 +-
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |   2 +-
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |  24 +-
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |  32 +-
 .../bindings/iio/imu/invensense,icm42600.yaml      |  34 +-
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |  26 +-
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |   2 +-
 .../bindings/iio/magnetometer/ti,tmag5273.yaml     |  75 +++
 .../bindings/iio/magnetometer/yamaha,yas530.yaml   |  18 +-
 .../bindings/iio/potentiometer/adi,ad5272.yaml     |   2 +-
 .../bindings/iio/pressure/asc,dlhl60d.yaml         |   2 +-
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |  24 +-
 .../bindings/iio/proximity/ams,as3935.yaml         |   2 +-
 .../proximity/google,cros-ec-mkbp-proximity.yaml   |   1 -
 .../bindings/iio/proximity/semtech,sx9360.yaml     |   2 +-
 .../devicetree/bindings/iio/st,st-sensors.yaml     |   2 +
 .../bindings/iio/temperature/adi,ltc2983.yaml      | 137 ++--
 .../bindings/iio/temperature/maxim,max31865.yaml   |  12 +-
 .../bindings/iio/temperature/ti,tmp117.yaml        |   6 +-
 MAINTAINERS                                        |  28 +-
 drivers/iio/accel/Kconfig                          |   2 +-
 drivers/iio/accel/bma400.h                         |   4 -
 drivers/iio/accel/bma400_core.c                    |  29 +-
 drivers/iio/accel/mma9551_core.c                   |  10 +-
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  |   1 +
 drivers/iio/accel/st_accel_i2c.c                   |   5 +
 drivers/iio/accel/st_accel_spi.c                   |   5 +
 drivers/iio/adc/Kconfig                            |  34 +-
 drivers/iio/adc/Makefile                           |   3 +
 drivers/iio/adc/ad7291.c                           |   2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   4 +-
 drivers/iio/adc/ep93xx_adc.c                       |   8 +
 drivers/iio/adc/imx93_adc.c                        | 484 ++++++++++++++
 drivers/iio/adc/max11410.c                         |   3 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |   8 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |  99 ++-
 drivers/iio/adc/stm32-dfsdm.h                      |  60 +-
 drivers/iio/adc/ti-adc128s052.c                    |  54 +-
 drivers/iio/adc/ti-ads7924.c                       | 474 +++++++++++++
 drivers/iio/adc/ti-lmp92064.c                      | 332 +++++++++
 drivers/iio/adc/xilinx-ams.c                       |   9 +-
 drivers/iio/cdc/ad7746.c                           |   3 +-
 drivers/iio/chemical/scd30_core.c                  |  46 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |   4 +-
 drivers/iio/dac/Kconfig                            |  21 +-
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5686.c                           |   7 +
 drivers/iio/dac/ad5686.h                           |   1 +
 drivers/iio/dac/ad5696-i2c.c                       |   2 +
 drivers/iio/dac/max5522.c                          | 207 ++++++
 drivers/iio/imu/bno055/bno055_ser_trace.c          |   2 +-
 drivers/iio/imu/kmx61.c                            |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   5 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  12 +-
 drivers/iio/industrialio-core.c                    |  64 +-
 drivers/iio/light/Makefile                         |   2 +-
 drivers/iio/light/max44009.c                       |   5 +-
 drivers/iio/light/tsl2563.c                        | 189 +++---
 drivers/iio/light/vcnl4000.c                       | 449 +++++++++----
 drivers/iio/magnetometer/Kconfig                   |  14 +-
 drivers/iio/magnetometer/Makefile                  |   2 +
 drivers/iio/magnetometer/st_magn.h                 |   1 +
 drivers/iio/magnetometer/st_magn_core.c            |   1 +
 drivers/iio/magnetometer/st_magn_i2c.c             |   5 +
 drivers/iio/magnetometer/st_magn_spi.c             |   5 +
 drivers/iio/magnetometer/tmag5273.c                | 743 +++++++++++++++++=
++++
 drivers/iio/pressure/ms5611.h                      |   4 -
 drivers/iio/pressure/ms5611_core.c                 |  49 +-
 drivers/iio/pressure/ms5611_i2c.c                  |   6 -
 drivers/iio/pressure/ms5611_spi.c                  |   6 -
 include/linux/iio/iio.h                            |   5 +
 include/linux/platform_data/tsl2563.h              |   9 -
 tools/iio/iio_utils.c                              |  23 +-
 133 files changed, 4018 insertions(+), 1047 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cirrus,ep9301=
-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc=
.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc081c.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,lmp92064.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/maxim,max5522=
.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ti,t=
mag5273.yaml
 create mode 100644 drivers/iio/adc/imx93_adc.c
 create mode 100644 drivers/iio/adc/ti-ads7924.c
 create mode 100644 drivers/iio/adc/ti-lmp92064.c
 create mode 100644 drivers/iio/dac/max5522.c
 create mode 100644 drivers/iio/magnetometer/tmag5273.c
 delete mode 100644 include/linux/platform_data/tsl2563.h
