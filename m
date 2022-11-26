Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96066397A7
	for <lists+linux-iio@lfdr.de>; Sat, 26 Nov 2022 19:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKZSf0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Nov 2022 13:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZSfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2022 13:35:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33301BC93
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 10:35:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE093B80953
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 18:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10C2C433C1;
        Sat, 26 Nov 2022 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669487721;
        bh=2LDxsD9fPkDbbV6uwc9VzFnYzz7MAjM5bkwc954RsKg=;
        h=Date:From:To:Subject:From;
        b=ZRpMs2BxQ+96DA6CycknZ4cCcW2adEzeVtMSV58DrgjwpdyzFz5tzhXYi9Ab0M6Z2
         UV3vuKSXaZ+DHee5c9Utpr2aHR8cCEBcQaLongPxSU2LyU2+JgI557sNieV8warv7t
         s1GNW1oJbpUR8s/DMo1S6oPJvgS4UfhBy/8J0Y1GYL5GukuGJ3EFZkxJBVoWThCb7q
         9e0SO8hy7HXiih0mDsOLRoUHNqNRqRGn4VH2qH47MPP0AHaWwiJ0+xExoyO2ce2tqH
         Zmf67jNhAKfWY4sxsGWJsrmgYAO0MdtV/i5g5BmOFs57azsaFM02jZnXYAkw9gCI+g
         4BwsDCCi0r1Kg==
Date:   Sat, 26 Nov 2022 18:47:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of new device support, cleanups and minor fixes
 for 6.2
Message-ID: <20221126184758.4dfe4af1@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

The following changes since commit 12491d35551df69709777bd7769e1e33641943cc:

  iio: pressure: bmp280: convert to i2c's .probe_new() (2022-11-23 20:01:38=
 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.2b

for you to fetch changes up to f84eec02b7248b6ae3bd8ef18a66f6f64eeab971:

  iio: addac: ad74413r: fix blank line after declaration warning (2022-11-2=
4 19:24:34 +0000)

----------------------------------------------------------------
2nd set of IIO new device support, cleanups etc for 6.2

Includes a few late breaking fixes for old issues.

Contains a large set of conversions from i2c probe() to probe_new()
as part of an attempt to finally get rid of the old style probe().

New devices support
* adi,ad74115
  - New driver for this complex input/output device with 16 bit ADCs,
    14 bit DACs amongst other features.
  - A few tidy ups / removal of unused data patches followed.
* adi,adf4377
  - New driver for this dual output integer-N phased locked loop and VCO
    chip.
* maxim,max30208
  - New driver for this high accuracy digital temperature sensor.
* st,lsm6dsx
  - Support for LSM6DS016IS (chip specific data)
  - Support for ISM330IS (id entry only)

Minor cleanups etc
* adi,adis
  - Fix a deadlock on device instance specific mutex.
  - Tidy up by calling unlocked form of __adis_initial_startup() in all
    cases and dropping the locked version.
* adi,ad4130
  - Reference spi-peripehral-props.yaml in the dt-binding.
* adi,ad74413r
  - Fix a bug brought on by integer promotion of signed value to unsigned t=
ype.
  - Add an spi_device_id table to allow module autoloading to work.
  - Add support for reset pin.
* adi,ad7606_par
  - devm_platform_get_and_ioremap_resource() instead of opencoding.
* adi,ad7923
  - Add dt-bindings docs for ad7927 via a fallback to ad7928 and do similar
    for ad7924.
* adi,ltc2983
  - Drop a now unneeded $ref for -nanoamp property as dt-schema no covers t=
his
    unit.
* maxim,max11410
  - Fix mask due to repeated use of VREFN instead of one of them being VREF=
P.
* qcom,spmi-iadc
  - Add fallback compatibles to dt-binding.
* renesas,rzg2l
  - Document use for RZ/Five SoC.
* st,stm32-adc
  - Improved calibration support with error logging and a debugfs
    interface to read back the result.
* ti,adc128s052
  - Fix an issue with missing data members in the adc128_of_match table that
    meant all device were being handled as adc128s052 ADCs.

----------------------------------------------------------------
Antoniu Miclaus (2):
      dt-bindings: iio: frequency: add adf4377 doc
      iio: frequency: adf4377: add support for ADF4377

Cosmin Tanislav (6):
      dt-bindings: iio: addac: add AD74115
      iio: addac: add AD74115 driver
      dt-bindings: iio: temperature: ltc2983: drop $ref for -nanoamp proper=
ties
      dt-bindings: iio: adc: ad4130: use spi-peripheral-props.yaml
      iio: addac: ad74115: remove unused ad74115_dac_slew_rate_hz_tbl
      iio: addac: ad74413r: fix blank line after declaration warning

Edmund Berenson (1):
      dt-bindings: iio: adc: ad7923: adjust documentation

Ibrahim Tilki (1):
      iio: adc: max11410: fix incomplete vref buffer mask

Lad Prabhakar (1):
      dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/Five SoC

Lorenzo Bianconi (4):
      iio: imu: st_lsm6dsx: add support to LSM6DSO16IS
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dso16is
      iio: imu: st_lsm6dsx: add support to ISM330IS
      dt-bindings: iio: imu: st_lsm6dsx: add ism330is

Luca Weiss (1):
      dt-bindings: iio/adc: qcom,spmi-iadc: use double compatibles

Minghao Chi (1):
      iio: use devm_platform_get_and_ioremap_resource()

Olivier Moysan (3):
      iio: adc: stm32-adc: smart calibration support
      iio: adc: stm32-adc: improve calibration error log
      iio: adc: stm32-adc: add debugfs to read raw calibration result

Rajat Khandelwal (1):
      iio: temperature: Add driver support for Maxim MAX30208

Ramona Bolboaca (9):
      iio: adis: add '__adis_enable_irq()' implementation
      iio: accel: adis16201: Call '__adis_initial_startup()' in probe
      iio: accel: adis16209: Call '__adis_initial_startup()' in probe
      iio: gyro: adis16136: Call '__adis_initial_startup()' in probe
      iio: gyro: adis16260: Call '__adis_initial_startup()' in probe
      iio: imu: adis16400: Call '__adis_initial_startup()' in probe
      staging: iio: accel: adis16203: Call '__adis_initial_startup()'
      staging: iio: accel: adis16240: Call '__adis_initial_startup()'
      iio: imu: adis: Remove adis_initial_startup function

Rasmus Villemoes (5):
      iio: addac: ad74413r: fix integer promotion bug in ad74413_get_input_=
current_offset()
      iio: addac: ad74413r: add spi_device_id table
      dt-bindings: iio: ad74413r: add optional reset-gpios
      iio: addac: ad74413r: add support for reset-gpio
      iio: adc128s052: add proper .data members in adc128_of_match table

Uwe Kleine-K=C3=B6nig (143):
      iio: accel: adxl372_i2c: Convert to i2c's .probe_new()
      iio: accel: bma180: Convert to i2c's .probe_new()
      iio: accel: bma400: Convert to i2c's .probe_new()
      iio: accel: bmc150: Convert to i2c's .probe_new()
      iio: accel: da280: Convert to i2c's .probe_new()
      iio: accel: kxcjk-1013: Convert to i2c's .probe_new()
      iio: accel: mma7455_i2c: Convert to i2c's .probe_new()
      iio: accel: mma8452: Convert to i2c's .probe_new()
      iio: accel: mma9551: Convert to i2c's .probe_new()
      iio: accel: mma9553: Convert to i2c's .probe_new()
      iio: adc: ad7091r5: Convert to i2c's .probe_new()
      iio: adc: ad7291: Convert to i2c's .probe_new()
      iio: adc: ad799x: Convert to i2c's .probe_new()
      iio: adc: ina2xx-adc: Convert to i2c's .probe_new()
      iio: adc: ltc2471: Convert to i2c's .probe_new()
      iio: adc: ltc2485: Convert to i2c's .probe_new()
      iio: adc: ltc2497: Convert to i2c's .probe_new()
      iio: adc: max1363: Convert to i2c's .probe_new()
      iio: adc: max9611: Convert to i2c's .probe_new()
      iio: adc: mcp3422: Convert to i2c's .probe_new()
      iio: adc: ti-adc081c: Convert to i2c's .probe_new()
      iio: adc: ti-ads1015: Convert to i2c's .probe_new()
      iio: cdc: ad7150: Convert to i2c's .probe_new()
      iio: cdc: ad7746: Convert to i2c's .probe_new()
      iio: chemical: ams-iaq-core: Convert to i2c's .probe_new()
      iio: chemical: atlas-ezo-sensor: Convert to i2c's .probe_new()
      iio: chemical: atlas-sensor: Convert to i2c's .probe_new()
      iio: chemical: bme680_i2c: Convert to i2c's .probe_new()
      iio: chemical: ccs811: Convert to i2c's .probe_new()
      iio: chemical: scd4x: Convert to i2c's .probe_new()
      iio: chemical: sgp30: Convert to i2c's .probe_new()
      iio: chemical: sgp40: Convert to i2c's .probe_new()
      iio: chemical: vz89x: Convert to i2c's .probe_new()
      iio: dac: ad5064: Convert to i2c's .probe_new()
      iio: dac: ad5380: Convert to i2c's .probe_new()
      iio: dac: ad5446: Convert to i2c's .probe_new()
      iio: dac: ad5593r: Convert to i2c's .probe_new()
      iio: dac: ad5696-i2c: Convert to i2c's .probe_new()
      iio: dac: ds4424: Convert to i2c's .probe_new()
      iio: dac: m62332: Convert to i2c's .probe_new()
      iio: dac: max517: Convert to i2c's .probe_new()
      iio: dac: max5821: Convert to i2c's .probe_new()
      iio: dac: mcp4725: Convert to i2c's .probe_new()
      iio: dac: ti-dac5571: Convert to i2c's .probe_new()
      iio: gyro: bmg160_i2c: Convert to i2c's .probe_new()
      iio: gyro: itg3200_core: Convert to i2c's .probe_new()
      iio: gyro: mpu3050-i2c: Convert to i2c's .probe_new()
      iio: gyro: st_gyro_i2c: Convert to i2c's .probe_new()
      iio: health: afe4404: Convert to i2c's .probe_new()
      iio: health: max30100: Convert to i2c's .probe_new()
      iio: health: max30102: Convert to i2c's .probe_new()
      iio: humidity: am2315: Convert to i2c's .probe_new()
      iio: humidity: hdc100x: Convert to i2c's .probe_new()
      iio: humidity: hdc2010: Convert to i2c's .probe_new()
      iio: humidity: hts221_i2c: Convert to i2c's .probe_new()
      iio: humidity: htu21: Convert to i2c's .probe_new()
      iio: humidity: si7005: Convert to i2c's .probe_new()
      iio: humidity: si7020: Convert to i2c's .probe_new()
      iio: imu: bmi160/bmi160_i2c: Convert to i2c's .probe_new()
      iio: imu: fxos8700_i2c: Convert to i2c's .probe_new()
      iio: imu: inv_mpu6050: Convert to i2c's .probe_new()
      iio: imu: kmx61: Convert to i2c's .probe_new()
      iio: imu: st_lsm6dsx: Convert to i2c's .probe_new()
      iio: light: adjd_s311: Convert to i2c's .probe_new()
      iio: light: adux1020: Convert to i2c's .probe_new()
      iio: light: al3010: Convert to i2c's .probe_new()
      iio: light: al3320a: Convert to i2c's .probe_new()
      iio: light: apds9300: Convert to i2c's .probe_new()
      iio: light: apds9960: Convert to i2c's .probe_new()
      iio: light: bh1750: Convert to i2c's .probe_new()
      iio: light: bh1780: Convert to i2c's .probe_new()
      iio: light: cm3232: Convert to i2c's .probe_new()
      iio: light: cm3323: Convert to i2c's .probe_new()
      iio: light: cm36651: Convert to i2c's .probe_new()
      iio: light: gp2ap002: Convert to i2c's .probe_new()
      iio: light: gp2ap020a00f: Convert to i2c's .probe_new()
      iio: light: isl29018: Convert to i2c's .probe_new()
      iio: light: isl29028: Convert to i2c's .probe_new()
      iio: light: isl29125: Convert to i2c's .probe_new()
      iio: light: jsa1212: Convert to i2c's .probe_new()
      iio: light: ltr501: Convert to i2c's .probe_new()
      iio: light: lv0104cs: Convert to i2c's .probe_new()
      iio: light: max44000: Convert to i2c's .probe_new()
      iio: light: noa1305: Convert to i2c's .probe_new()
      iio: light: opt3001: Convert to i2c's .probe_new()
      iio: light: pa12203001: Convert to i2c's .probe_new()
      iio: light: rpr0521: Convert to i2c's .probe_new()
      iio: light: si1133: Convert to i2c's .probe_new()
      iio: light: si1145: Convert to i2c's .probe_new()
      iio: light: st_uvis25_i2c: Convert to i2c's .probe_new()
      iio: light: stk3310: Convert to i2c's .probe_new()
      iio: light: tcs3414: Convert to i2c's .probe_new()
      iio: light: tcs3472: Convert to i2c's .probe_new()
      iio: light: tsl2563: Convert to i2c's .probe_new()
      iio: light: tsl2583: Convert to i2c's .probe_new()
      iio: light: tsl2772: Convert to i2c's .probe_new()
      iio: light: tsl4531: Convert to i2c's .probe_new()
      iio: light: us5182d: Convert to i2c's .probe_new()
      iio: light: vcnl4000: Convert to i2c's .probe_new()
      iio: light: vcnl4035: Convert to i2c's .probe_new()
      iio: light: veml6030: Convert to i2c's .probe_new()
      iio: light: veml6070: Convert to i2c's .probe_new()
      iio: light: zopt2201: Convert to i2c's .probe_new()
      iio: magnetometer: ak8974: Convert to i2c's .probe_new()
      iio: magnetometer: ak8975: Convert to i2c's .probe_new()
      iio: magnetometer: bmc150_magn_i2c: Convert to i2c's .probe_new()
      iio: magnetometer: hmc5843: Convert to i2c's .probe_new()
      iio: magnetometer: mag3110: Convert to i2c's .probe_new()
      iio: magnetometer: mmc35240: Convert to i2c's .probe_new()
      iio: magnetometer: yamaha-yas530: Convert to i2c's .probe_new()
      iio: potentiometer: ad5272: Convert to i2c's .probe_new()
      iio: potentiometer: ds1803: Convert to i2c's .probe_new()
      iio: potentiometer: max5432: Convert to i2c's .probe_new()
      iio: potentiometer: tpl0102: Convert to i2c's .probe_new()
      iio: potentiostat: lmp91000: Convert to i2c's .probe_new()
      iio: pressure: abp060mg: Convert to i2c's .probe_new()
      iio: pressure: dlhl60d: Convert to i2c's .probe_new()
      iio: pressure: dps310: Convert to i2c's .probe_new()
      iio: pressure: hp03: Convert to i2c's .probe_new()
      iio: pressure: hp206c: Convert to i2c's .probe_new()
      iio: pressure: icp10100: Convert to i2c's .probe_new()
      iio: pressure: mpl115_i2c: Convert to i2c's .probe_new()
      iio: pressure: mpl3115: Convert to i2c's .probe_new()
      iio: pressure: ms5611_i2c: Convert to i2c's .probe_new()
      iio: pressure: ms5637: Convert to i2c's .probe_new()
      iio: pressure: st_pressure_i2c: Convert to i2c's .probe_new()
      iio: pressure: t5403: Convert to i2c's .probe_new()
      iio: pressure: zpa2326_i2c: Convert to i2c's .probe_new()
      iio: proximity: isl29501: Convert to i2c's .probe_new()
      iio: proximity: mb1232: Convert to i2c's .probe_new()
      iio: proximity: pulsedlight-lidar-lite-v2: Convert to i2c's .probe_ne=
w()
      iio: proximity: rfd77402: Convert to i2c's .probe_new()
      iio: proximity: srf08: Convert to i2c's .probe_new()
      iio: proximity: sx9500: Convert to i2c's .probe_new()
      iio: temperature: mlx90614: Convert to i2c's .probe_new()
      iio: temperature: mlx90632: Convert to i2c's .probe_new()
      iio: temperature: tmp006: Convert to i2c's .probe_new()
      iio: temperature: tmp007: Convert to i2c's .probe_new()
      iio: temperature: tsys01: Convert to i2c's .probe_new()
      iio: temperature: tsys02d: Convert to i2c's .probe_new()
      staging: iio: adt7316: Convert to i2c's .probe_new()
      staging: iio: ad5933: Convert to i2c's .probe_new()
      staging: iio: ade7854: Convert to i2c's .probe_new()

 .../devicetree/bindings/iio/adc/adi,ad4130.yaml    |    5 +-
 .../devicetree/bindings/iio/adc/adi,ad7923.yaml    |   26 +-
 .../bindings/iio/adc/qcom,spmi-iadc.yaml           |    7 +-
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |    2 +-
 .../devicetree/bindings/iio/addac/adi,ad74115.yaml |  373 ++++
 .../bindings/iio/addac/adi,ad74413r.yaml           |    4 +
 .../bindings/iio/frequency/adi,adf4377.yaml        |   92 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    4 +
 .../bindings/iio/temperature/adi,ltc2983.yaml      |    1 -
 MAINTAINERS                                        |   22 +
 drivers/iio/accel/adis16201.c                      |    2 +-
 drivers/iio/accel/adis16209.c                      |    2 +-
 drivers/iio/accel/adxl372_i2c.c                    |    6 +-
 drivers/iio/accel/bma180.c                         |    6 +-
 drivers/iio/accel/bma400_i2c.c                     |    6 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |    6 +-
 drivers/iio/accel/da280.c                          |    6 +-
 drivers/iio/accel/kxcjk-1013.c                     |    6 +-
 drivers/iio/accel/mma7455_i2c.c                    |    6 +-
 drivers/iio/accel/mma8452.c                        |    6 +-
 drivers/iio/accel/mma9551.c                        |    6 +-
 drivers/iio/accel/mma9553.c                        |    6 +-
 drivers/iio/adc/ad7091r5.c                         |    6 +-
 drivers/iio/adc/ad7291.c                           |    6 +-
 drivers/iio/adc/ad7606_par.c                       |    3 +-
 drivers/iio/adc/ad799x.c                           |    6 +-
 drivers/iio/adc/ina2xx-adc.c                       |    6 +-
 drivers/iio/adc/ltc2471.c                          |    6 +-
 drivers/iio/adc/ltc2485.c                          |    6 +-
 drivers/iio/adc/ltc2497.c                          |    6 +-
 drivers/iio/adc/max11410.c                         |    2 +-
 drivers/iio/adc/max1363.c                          |    6 +-
 drivers/iio/adc/max9611.c                          |    5 +-
 drivers/iio/adc/mcp3422.c                          |    6 +-
 drivers/iio/adc/stm32-adc-core.h                   |    1 +
 drivers/iio/adc/stm32-adc.c                        |  135 +-
 drivers/iio/adc/ti-adc081c.c                       |    6 +-
 drivers/iio/adc/ti-adc128s052.c                    |   14 +-
 drivers/iio/adc/ti-ads1015.c                       |    6 +-
 drivers/iio/addac/Kconfig                          |   14 +
 drivers/iio/addac/Makefile                         |    1 +
 drivers/iio/addac/ad74115.c                        | 1943 ++++++++++++++++=
++++
 drivers/iio/addac/ad74413r.c                       |   32 +-
 drivers/iio/cdc/ad7150.c                           |    6 +-
 drivers/iio/cdc/ad7746.c                           |    6 +-
 drivers/iio/chemical/ams-iaq-core.c                |    5 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |    6 +-
 drivers/iio/chemical/atlas-sensor.c                |    6 +-
 drivers/iio/chemical/bme680_i2c.c                  |    6 +-
 drivers/iio/chemical/ccs811.c                      |    6 +-
 drivers/iio/chemical/scd4x.c                       |    4 +-
 drivers/iio/chemical/sgp30.c                       |    6 +-
 drivers/iio/chemical/sgp40.c                       |    6 +-
 drivers/iio/chemical/vz89x.c                       |    6 +-
 drivers/iio/dac/ad5064.c                           |    6 +-
 drivers/iio/dac/ad5380.c                           |    6 +-
 drivers/iio/dac/ad5446.c                           |    6 +-
 drivers/iio/dac/ad5593r.c                          |    6 +-
 drivers/iio/dac/ad5696-i2c.c                       |    6 +-
 drivers/iio/dac/ds4424.c                           |    6 +-
 drivers/iio/dac/m62332.c                           |    5 +-
 drivers/iio/dac/max517.c                           |    6 +-
 drivers/iio/dac/max5821.c                          |    6 +-
 drivers/iio/dac/mcp4725.c                          |    6 +-
 drivers/iio/dac/ti-dac5571.c                       |    6 +-
 drivers/iio/frequency/Kconfig                      |   10 +
 drivers/iio/frequency/Makefile                     |    1 +
 drivers/iio/frequency/adf4377.c                    |  994 ++++++++++
 drivers/iio/gyro/adis16136.c                       |    2 +-
 drivers/iio/gyro/adis16260.c                       |    2 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    6 +-
 drivers/iio/gyro/itg3200_core.c                    |    5 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |    6 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |    5 +-
 drivers/iio/health/afe4404.c                       |    5 +-
 drivers/iio/health/max30100.c                      |    5 +-
 drivers/iio/health/max30102.c                      |    6 +-
 drivers/iio/humidity/am2315.c                      |    5 +-
 drivers/iio/humidity/hdc100x.c                     |    5 +-
 drivers/iio/humidity/hdc2010.c                     |    5 +-
 drivers/iio/humidity/hts221_i2c.c                  |    5 +-
 drivers/iio/humidity/htu21.c                       |    6 +-
 drivers/iio/humidity/si7005.c                      |    5 +-
 drivers/iio/humidity/si7020.c                      |    5 +-
 drivers/iio/imu/adis.c                             |   28 +-
 drivers/iio/imu/adis16400.c                        |    2 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    6 +-
 drivers/iio/imu/fxos8700_i2c.c                     |    6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    7 +-
 drivers/iio/imu/kmx61.c                            |    6 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    4 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  132 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   16 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   10 +
 drivers/iio/light/adjd_s311.c                      |    5 +-
 drivers/iio/light/adux1020.c                       |    5 +-
 drivers/iio/light/al3010.c                         |    5 +-
 drivers/iio/light/al3320a.c                        |    5 +-
 drivers/iio/light/apds9300.c                       |    5 +-
 drivers/iio/light/apds9960.c                       |    5 +-
 drivers/iio/light/bh1750.c                         |    6 +-
 drivers/iio/light/bh1780.c                         |    5 +-
 drivers/iio/light/cm3232.c                         |    6 +-
 drivers/iio/light/cm3323.c                         |    5 +-
 drivers/iio/light/cm36651.c                        |    6 +-
 drivers/iio/light/gp2ap002.c                       |    5 +-
 drivers/iio/light/gp2ap020a00f.c                   |    6 +-
 drivers/iio/light/isl29018.c                       |    6 +-
 drivers/iio/light/isl29028.c                       |    6 +-
 drivers/iio/light/isl29125.c                       |    5 +-
 drivers/iio/light/jsa1212.c                        |    5 +-
 drivers/iio/light/ltr501.c                         |    6 +-
 drivers/iio/light/lv0104cs.c                       |    5 +-
 drivers/iio/light/max44000.c                       |    5 +-
 drivers/iio/light/noa1305.c                        |    5 +-
 drivers/iio/light/opt3001.c                        |    5 +-
 drivers/iio/light/pa12203001.c                     |    5 +-
 drivers/iio/light/rpr0521.c                        |    5 +-
 drivers/iio/light/si1133.c                         |    6 +-
 drivers/iio/light/si1145.c                         |    6 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    5 +-
 drivers/iio/light/stk3310.c                        |    5 +-
 drivers/iio/light/tcs3414.c                        |    5 +-
 drivers/iio/light/tcs3472.c                        |    5 +-
 drivers/iio/light/tsl2563.c                        |    5 +-
 drivers/iio/light/tsl2583.c                        |    5 +-
 drivers/iio/light/tsl2772.c                        |    6 +-
 drivers/iio/light/tsl4531.c                        |    5 +-
 drivers/iio/light/us5182d.c                        |    5 +-
 drivers/iio/light/vcnl4000.c                       |    6 +-
 drivers/iio/light/vcnl4035.c                       |    5 +-
 drivers/iio/light/veml6030.c                       |    5 +-
 drivers/iio/light/veml6070.c                       |    5 +-
 drivers/iio/light/zopt2201.c                       |    5 +-
 drivers/iio/magnetometer/ak8974.c                  |    5 +-
 drivers/iio/magnetometer/ak8975.c                  |    6 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    6 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    6 +-
 drivers/iio/magnetometer/mag3110.c                 |    6 +-
 drivers/iio/magnetometer/mmc35240.c                |    5 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    6 +-
 drivers/iio/potentiometer/ad5272.c                 |    6 +-
 drivers/iio/potentiometer/ds1803.c                 |    5 +-
 drivers/iio/potentiometer/max5432.c                |    5 +-
 drivers/iio/potentiometer/tpl0102.c                |    6 +-
 drivers/iio/potentiostat/lmp91000.c                |    5 +-
 drivers/iio/pressure/abp060mg.c                    |    6 +-
 drivers/iio/pressure/dlhl60d.c                     |    6 +-
 drivers/iio/pressure/dps310.c                      |    6 +-
 drivers/iio/pressure/hp03.c                        |    6 +-
 drivers/iio/pressure/hp206c.c                      |    6 +-
 drivers/iio/pressure/icp10100.c                    |    5 +-
 drivers/iio/pressure/mpl115_i2c.c                  |    6 +-
 drivers/iio/pressure/mpl3115.c                     |    6 +-
 drivers/iio/pressure/ms5611_i2c.c                  |    6 +-
 drivers/iio/pressure/ms5637.c                      |    6 +-
 drivers/iio/pressure/st_pressure_i2c.c             |    5 +-
 drivers/iio/pressure/t5403.c                       |    6 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |    6 +-
 drivers/iio/proximity/isl29501.c                   |    5 +-
 drivers/iio/proximity/mb1232.c                     |    6 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    5 +-
 drivers/iio/proximity/rfd77402.c                   |    5 +-
 drivers/iio/proximity/srf08.c                      |    6 +-
 drivers/iio/proximity/sx9500.c                     |    5 +-
 drivers/iio/temperature/Kconfig                    |   10 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/max30208.c                 |  252 +++
 drivers/iio/temperature/mlx90614.c                 |    6 +-
 drivers/iio/temperature/mlx90632.c                 |    6 +-
 drivers/iio/temperature/tmp006.c                   |    5 +-
 drivers/iio/temperature/tmp007.c                   |    6 +-
 drivers/iio/temperature/tsys01.c                   |    5 +-
 drivers/iio/temperature/tsys02d.c                  |    6 +-
 drivers/staging/iio/accel/adis16203.c              |    2 +-
 drivers/staging/iio/accel/adis16240.c              |    2 +-
 drivers/staging/iio/addac/adt7316-i2c.c            |    6 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    6 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |    5 +-
 include/linux/iio/imu/adis.h                       |   11 +-
 181 files changed, 4418 insertions(+), 545 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74115=
.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf=
4377.yaml
 create mode 100644 drivers/iio/addac/ad74115.c
 create mode 100644 drivers/iio/frequency/adf4377.c
 create mode 100644 drivers/iio/temperature/max30208.c
