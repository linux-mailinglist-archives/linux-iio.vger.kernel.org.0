Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6603272F589
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jun 2023 09:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFNHJH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jun 2023 03:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243199AbjFNHJD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jun 2023 03:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281819B6
        for <linux-iio@vger.kernel.org>; Wed, 14 Jun 2023 00:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECBFF63589
        for <linux-iio@vger.kernel.org>; Wed, 14 Jun 2023 07:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEA0C433C0;
        Wed, 14 Jun 2023 07:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686726540;
        bh=yAeyWZ82csOeYNfC1UCRR7GjgFKD5vJmOC9mA+LZGXs=;
        h=Date:From:To:Subject:From;
        b=BQCTZ7NpnwPgXFadBEWDDLzF6EyxyBYc+xhx/jcOTWhv+iVjMmqDCgFCVtQEmpSsP
         HCRqSCYbxagcjcz3FcQomPBr6yYC5WRfagVSblyDJepIRJsVEby2IpZxnSIqWw4nJa
         LRJnFXy5nBWxZoD0ydUl7ded3R1snCRIugmb5hkouxrBbpcuGn38R3rIUnjQ1QUL/w
         NEb/ijXok1LKRW7I7OYbDQbpk3OKsZaDVcwWSWX2DFe3BRnXmFKHaB6FdVWWzy+QNK
         Xk5JF1VY0ak4UdIa5O0btVLJm1H25WnjclcfmKPpUj5uKmnlixRn9R8/cPK6rR3mC9
         oE3x8sNIIguJw==
Date:   Wed, 14 Jun 2023 08:09:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of new device support, features and cleanups
 for 6.5
Message-ID: <20230614080900.1fe702f4@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.5a

for you to fetch changes up to 0cf9a77e80fa48e4392e408f8660e93c080cb78d:

  dt-bindings: iio: rockchip: Fix 'oneOf' condition failed warning (2023-06=
-10 19:22:24 +0100)

----------------------------------------------------------------
1st set of IIO new device support, features and cleanup for the 6.5 cycle.

New device support
- honeywell,mprls0025pa
  * New driver and dt-bindings for this series of pressure sensors.
- invensense,mpu6050
  * Add support for ICM 20600 IMU (ID, bindings and device data).
- melexis,mlx90614
  * Add support for mlx90615 Infra Red Thermometer after driver cleanup
    and refactoring to support the differences in this device.
- renesas,x9250
  * New driver and bindings for this quad potentiometer.
- rockchip,saradc
  * Add support for RK3588. Also included is a bunch of refactoring and
    cleanup for that driver.
- rohm,bu27008
  * New driver bindings etc for this 5 photodiode color sensor.
- st,lsm9ds0/st,st-sensors
  * ID added for LSM303D accelerometer and magnetometer including ACPI bind=
ing.
- ti,opt4001
  * New driver and bindings for this ambient light sensor.

Features
- core
  * Introduce iio_validate_own_trigger() for cases where a driver can only
    consumer a trigger it registered (detected via same parent device).
    Use it in the kionix,kx022a driver and new rohm,by27008 driver.
- dynaimage,al3320a
  * ACPI binding CALS0001 seen on Lenovo Yoga Table 2 devices.
- kionix,kx002a
  * Enable asynchronous probe.
- rohm,bu27034
  * Enable asynchronous probe.
- ti,tmp006
  * Explicit support for DT including binding documentation.

Cleanups, minor fixes and misc improvements.
- treewide
  * Switch I2C drivers from probe_new() back to probe() - part of the
    long process of getting rid of a parameter from probe()
  * Various whitespace and typo fixes not otherwise called out.
- core
  * industrialio-buffer,Style cleanup.
  * Add documentation to extend_name field of struct iio_chan_spec to
    direct people using it towards the label infrastructure instead.
    extend_name was a design mistake a long time back so directly people
    away from it may be useful.
- adi,ad7606
  * Add HAS_IOPORT dependency to prepare for some Kconfig changes.
- bosch,bma400
  * Drop pointless print of ret in a dev_err_probe() message.
- invensense,icm42600
  * Rework timestamp handling to reduce jitter.
- mediatek,mt7986-auxdac
  * Add DT binding for this part.
- qcom,spmi-vadc
  * Allow for 1/16th prescaling used on a few devices.
  * Various changes to channel labeling and naming, including dropping
    use of fwnode_name which generates odd channel names. Small ABI
    change as a result, but not thought to be a problem for users of this
    platform.
- st,lsm6dsx
  * dt-binding: Use common schema for mount-matrix via a reference.
- st,stm32
  * Add a debug print for when legacy channel config is used.
- ti,palmas-adc
  * Drop unused i2c.h include.

----------------------------------------------------------------
Andreas Klinger (3):
      dt-bindings: iio: pressure: Support Honeywell mprls0025pa sensor
      iio: pressure: Honeywell mprls0025pa pressure sensor
      MAINTAINERS: Add Honeywell mprls0025pa sensor

Anup Sharma (2):
      dt-bindings: iio: temperature: Add support for tmp006
      iio: temperature: tmp006: Add OF device matching support

Christophe JAILLET (2):
      iio: accel: bma400: Simplify an error message
      iio: adc: palmas: Remove the unneeded include <linux/i2c.h>

Frank Wunderlich (1):
      dt-bindings: iio: adc: Add support for MT7986

Franziska Naepelt (1):
      iio: amplifiers: ad8366 Fix whitespace issue

Geert Uytterhoeven (1):
      dt-bindings: iio: afe: voltage-divider: Spelling s/curcuit/circuit/

Hermes Zhang (2):
      dt-bindings: iio: imu: mpu6050: Add icm20600 bindings to mpu6050
      iio: imu: mpu6050: Add support for the ICM 20600 IMU

Herve Codina (3):
      dt-bindings: iio: potentiometer: Add the Renesas X9250 potentiometers
      iio: potentiometer: Add support for the Renesas X9250 potentiometers
      MAINTAINERS: add the Renesas X9250 driver entry

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: avoid frequent timestamp jitter

Krzysztof Kozlowski (1):
      dt-bindings: iio: st,lsm6dsx: reference common schema for mount-matrix

Luca Weiss (1):
      dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for pre-scaling

Marek Vasut (6):
      dt-bindings: iio: temperature: melexis,mlx90614: Document MLX90615 su=
pport
      iio: mlx90614: Sort headers
      iio: mlx90614: Drop unused register macros
      iio: mlx90614: Drop MLX90614_CONST_EMISSIVITY_RESOLUTION
      iio: mlx90614: Factor our register IO and constants into model specif=
ic descriptor
      iio: mlx90614: Add MLX90615 support

Marijn Suijten (6):
      dt-bindings: iio: adc: Require generic `channel` name for channel nod=
es
      iio: core: Point users of extend_name field to read_label callback
      iio: adc: qcom-spmi-adc5: Use driver datasheet_name instead of DT lab=
el
      iio: adc: qcom-spmi-adc5: Fall back to datasheet_name instead of fwno=
de name
      iio: adc: qcom-spmi-adc5: Remove unnecessary datasheet_name NULL check
      iio: adc: qcom-spmi-vadc: Propagate fw node label to userspace

Marius Hoch (7):
      iio: accel: st_accel: Add LSM303D
      iio: magnetometer: st_accel: Add LSM303D
      iio: st_sensors: Add lsm303d support to the LSM9DS0 IMU driver
      iio: st_sensors: Add ACPI support for lsm303d to the LSM9DS0 IMU driv=
er
      iio: Comment that the LSM303D also has the Magnetometer DRDY
      dt-bindings: iio: st-sensors: Add LSM303D accelerometer+magnetometer
      iio: light: al3320a: Handle ACPI device CALS0001

Matti Vaittinen (7):
      iio: bu27034: Probe asynchronously
      iio: kx022a: Probe asynchronously
      dt-bindings: iio: light: ROHM BU27008
      iio: trigger: Add simple trigger_validation helper
      iio: kx022a: Use new iio_validate_own_trigger()
      iio: light: ROHM BU27008 color sensor
      MAINTAINERS: Add ROHM BU27008

Niklas Schnelle (1):
      iio: ad7606: Kconfig: add HAS_IOPORT dependencies

Nuno S=C3=A1 (1):
      iio: buffer: fix coding style warnings

Sean Nyekjaer (1):
      iio: adc: stm32-adc: add debug info if dt uses legacy channel config

Shreeya Patel (6):
      iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled
      iio: adc: rockchip_saradc: Use of_device_get_match_data
      iio: adc: rockchip_saradc: Match alignment with open parenthesis
      iio: adc: rockchip_saradc: Use dev_err_probe
      dt-bindings: iio: adc: Add rockchip,rk3588-saradc string
      dt-bindings: iio: rockchip: Fix 'oneOf' condition failed warning

Simon Xue (2):
      iio: adc: rockchip_saradc: Add callback functions
      iio: adc: rockchip_saradc: Add support for RK3588

Stefan Windfeldt-Prytz (2):
      dt-bindings: iio: light: Document TI OPT4001 light sensor
      iio: light: Add support for TI OPT4001 light sensor

Uwe Kleine-K=C3=B6nig (2):
      iio: Switch i2c drivers back to use .probe()
      staging: iio: Switch i2c drivers back to use .probe()

 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |    1 +
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |   28 +-
 .../bindings/iio/adc/rockchip-saradc.yaml          |    1 +
 .../bindings/iio/afe/voltage-divider.yaml          |    2 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |    3 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    1 +
 .../bindings/iio/light/rohm,bu27008.yaml           |   49 +
 .../devicetree/bindings/iio/light/ti,opt4001.yaml  |   68 ++
 .../bindings/iio/potentiometer/renesas,x9250.yaml  |   78 ++
 .../iio/pressure/honeywell,mprls0025pa.yaml        |  104 ++
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    1 +
 .../bindings/iio/temperature/melexis,mlx90614.yaml |    6 +-
 .../bindings/iio/temperature/ti,tmp006.yaml        |   42 +
 MAINTAINERS                                        |   17 +-
 drivers/iio/accel/adxl313_i2c.c                    |    2 +-
 drivers/iio/accel/adxl345_i2c.c                    |    2 +-
 drivers/iio/accel/adxl355_i2c.c                    |    2 +-
 drivers/iio/accel/adxl367_i2c.c                    |    2 +-
 drivers/iio/accel/adxl372_i2c.c                    |    2 +-
 drivers/iio/accel/bma180.c                         |    2 +-
 drivers/iio/accel/bma400_core.c                    |    3 +-
 drivers/iio/accel/bma400_i2c.c                     |    2 +-
 drivers/iio/accel/bmc150-accel-i2c.c               |    2 +-
 drivers/iio/accel/da280.c                          |    2 +-
 drivers/iio/accel/da311.c                          |    2 +-
 drivers/iio/accel/dmard06.c                        |    2 +-
 drivers/iio/accel/dmard09.c                        |    2 +-
 drivers/iio/accel/dmard10.c                        |    2 +-
 drivers/iio/accel/fxls8962af-i2c.c                 |    2 +-
 drivers/iio/accel/kionix-kx022a-i2c.c              |    3 +-
 drivers/iio/accel/kionix-kx022a-spi.c              |    1 +
 drivers/iio/accel/kionix-kx022a.c                  |   13 +-
 drivers/iio/accel/kxcjk-1013.c                     |    2 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    2 +-
 drivers/iio/accel/mc3230.c                         |    2 +-
 drivers/iio/accel/mma7455_i2c.c                    |    2 +-
 drivers/iio/accel/mma7660.c                        |    2 +-
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/accel/mma9551.c                        |    2 +-
 drivers/iio/accel/mma9553.c                        |    2 +-
 drivers/iio/accel/msa311.c                         |    2 +-
 drivers/iio/accel/mxc4005.c                        |    2 +-
 drivers/iio/accel/mxc6255.c                        |    2 +-
 drivers/iio/accel/st_accel_core.c                  |    1 +
 drivers/iio/accel/st_accel_i2c.c                   |    2 +-
 drivers/iio/accel/stk8312.c                        |    2 +-
 drivers/iio/accel/stk8ba50.c                       |    2 +-
 drivers/iio/adc/Kconfig                            |    2 +-
 drivers/iio/adc/ad7091r5.c                         |    2 +-
 drivers/iio/adc/ad7291.c                           |    2 +-
 drivers/iio/adc/ad799x.c                           |    2 +-
 drivers/iio/adc/ina2xx-adc.c                       |    2 +-
 drivers/iio/adc/ltc2471.c                          |    2 +-
 drivers/iio/adc/ltc2485.c                          |    2 +-
 drivers/iio/adc/ltc2497.c                          |    2 +-
 drivers/iio/adc/max1363.c                          |    2 +-
 drivers/iio/adc/max9611.c                          |    2 +-
 drivers/iio/adc/mcp3422.c                          |    2 +-
 drivers/iio/adc/nau7802.c                          |    2 +-
 drivers/iio/adc/palmas_gpadc.c                     |    1 -
 drivers/iio/adc/qcom-spmi-adc5.c                   |   15 +-
 drivers/iio/adc/qcom-spmi-vadc.c                   |   19 +-
 drivers/iio/adc/rockchip_saradc.c                  |  246 +++--
 drivers/iio/adc/rtq6056.c                          |    2 +-
 drivers/iio/adc/stm32-adc.c                        |    2 +
 drivers/iio/adc/ti-adc081c.c                       |    2 +-
 drivers/iio/adc/ti-ads1015.c                       |    2 +-
 drivers/iio/adc/ti-ads1100.c                       |    2 +-
 drivers/iio/adc/ti-ads7924.c                       |    2 +-
 drivers/iio/amplifiers/ad8366.c                    |    2 +-
 drivers/iio/cdc/ad7150.c                           |    2 +-
 drivers/iio/cdc/ad7746.c                           |    2 +-
 drivers/iio/chemical/ams-iaq-core.c                |    2 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |    2 +-
 drivers/iio/chemical/atlas-sensor.c                |    2 +-
 drivers/iio/chemical/bme680_i2c.c                  |    2 +-
 drivers/iio/chemical/ccs811.c                      |    2 +-
 drivers/iio/chemical/scd30_i2c.c                   |    2 +-
 drivers/iio/chemical/scd4x.c                       |    2 +-
 drivers/iio/chemical/sgp30.c                       |    2 +-
 drivers/iio/chemical/sgp40.c                       |    2 +-
 drivers/iio/chemical/sps30_i2c.c                   |    2 +-
 drivers/iio/chemical/sunrise_co2.c                 |    2 +-
 drivers/iio/chemical/vz89x.c                       |    2 +-
 drivers/iio/dac/ad5064.c                           |    2 +-
 drivers/iio/dac/ad5380.c                           |    2 +-
 drivers/iio/dac/ad5446.c                           |    2 +-
 drivers/iio/dac/ad5593r.c                          |    2 +-
 drivers/iio/dac/ad5696-i2c.c                       |    2 +-
 drivers/iio/dac/ds4424.c                           |    2 +-
 drivers/iio/dac/m62332.c                           |    2 +-
 drivers/iio/dac/max517.c                           |    2 +-
 drivers/iio/dac/max5821.c                          |    2 +-
 drivers/iio/dac/mcp4725.c                          |    2 +-
 drivers/iio/dac/ti-dac5571.c                       |    2 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    2 +-
 drivers/iio/gyro/fxas21002c_i2c.c                  |    2 +-
 drivers/iio/gyro/itg3200_core.c                    |    2 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |    2 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |    2 +-
 drivers/iio/health/afe4404.c                       |    2 +-
 drivers/iio/health/max30100.c                      |    2 +-
 drivers/iio/health/max30102.c                      |    2 +-
 drivers/iio/humidity/am2315.c                      |    2 +-
 drivers/iio/humidity/hdc100x.c                     |    2 +-
 drivers/iio/humidity/hdc2010.c                     |    2 +-
 drivers/iio/humidity/hts221_i2c.c                  |    2 +-
 drivers/iio/humidity/htu21.c                       |    2 +-
 drivers/iio/humidity/si7005.c                      |    2 +-
 drivers/iio/humidity/si7020.c                      |    2 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    2 +-
 drivers/iio/imu/bno055/bno055_i2c.c                |    2 +-
 drivers/iio/imu/fxos8700_i2c.c                     |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.c  |   49 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |    4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   10 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    5 +
 drivers/iio/imu/kmx61.c                            |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    2 +-
 drivers/iio/imu/st_lsm9ds0/Kconfig                 |    3 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   14 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |    5 +
 drivers/iio/industrialio-buffer.c                  |   98 +-
 drivers/iio/industrialio-trigger.c                 |   22 +-
 drivers/iio/light/Kconfig                          |   25 +
 drivers/iio/light/Makefile                         |    2 +
 drivers/iio/light/adjd_s311.c                      |    2 +-
 drivers/iio/light/adux1020.c                       |    2 +-
 drivers/iio/light/al3010.c                         |    2 +-
 drivers/iio/light/al3320a.c                        |   10 +-
 drivers/iio/light/apds9300.c                       |    2 +-
 drivers/iio/light/apds9960.c                       |    2 +-
 drivers/iio/light/as73211.c                        |    2 +-
 drivers/iio/light/bh1750.c                         |    2 +-
 drivers/iio/light/bh1780.c                         |    2 +-
 drivers/iio/light/cm32181.c                        |    2 +-
 drivers/iio/light/cm3232.c                         |    2 +-
 drivers/iio/light/cm3323.c                         |    2 +-
 drivers/iio/light/cm36651.c                        |    2 +-
 drivers/iio/light/gp2ap002.c                       |    2 +-
 drivers/iio/light/gp2ap020a00f.c                   |    2 +-
 drivers/iio/light/isl29018.c                       |    2 +-
 drivers/iio/light/isl29028.c                       |    2 +-
 drivers/iio/light/isl29125.c                       |    2 +-
 drivers/iio/light/jsa1212.c                        |    2 +-
 drivers/iio/light/ltr501.c                         |    2 +-
 drivers/iio/light/ltrf216a.c                       |    2 +-
 drivers/iio/light/lv0104cs.c                       |    2 +-
 drivers/iio/light/max44000.c                       |    2 +-
 drivers/iio/light/max44009.c                       |    2 +-
 drivers/iio/light/noa1305.c                        |    2 +-
 drivers/iio/light/opt3001.c                        |    2 +-
 drivers/iio/light/opt4001.c                        |  467 +++++++++
 drivers/iio/light/pa12203001.c                     |    2 +-
 drivers/iio/light/rohm-bu27008.c                   | 1026 ++++++++++++++++=
++++
 drivers/iio/light/rohm-bu27034.c                   |    3 +-
 drivers/iio/light/rpr0521.c                        |    2 +-
 drivers/iio/light/si1133.c                         |    2 +-
 drivers/iio/light/si1145.c                         |    2 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    2 +-
 drivers/iio/light/stk3310.c                        |    2 +-
 drivers/iio/light/tcs3414.c                        |    2 +-
 drivers/iio/light/tcs3472.c                        |    2 +-
 drivers/iio/light/tsl2563.c                        |    2 +-
 drivers/iio/light/tsl2583.c                        |    2 +-
 drivers/iio/light/tsl2591.c                        |    2 +-
 drivers/iio/light/tsl2772.c                        |    2 +-
 drivers/iio/light/tsl4531.c                        |    2 +-
 drivers/iio/light/us5182d.c                        |    2 +-
 drivers/iio/light/vcnl4000.c                       |    2 +-
 drivers/iio/light/vcnl4035.c                       |    2 +-
 drivers/iio/light/veml6030.c                       |    2 +-
 drivers/iio/light/veml6070.c                       |    2 +-
 drivers/iio/light/vl6180.c                         |    2 +-
 drivers/iio/light/zopt2201.c                       |    2 +-
 drivers/iio/magnetometer/ak8974.c                  |    2 +-
 drivers/iio/magnetometer/ak8975.c                  |    2 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    2 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    2 +-
 drivers/iio/magnetometer/mag3110.c                 |    2 +-
 drivers/iio/magnetometer/mmc35240.c                |    2 +-
 drivers/iio/magnetometer/rm3100-i2c.c              |    2 +-
 drivers/iio/magnetometer/st_magn_core.c            |    1 +
 drivers/iio/magnetometer/st_magn_i2c.c             |    2 +-
 drivers/iio/magnetometer/tmag5273.c                |    2 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    2 +-
 drivers/iio/potentiometer/Kconfig                  |   10 +
 drivers/iio/potentiometer/Makefile                 |    1 +
 drivers/iio/potentiometer/ad5110.c                 |    2 +-
 drivers/iio/potentiometer/ad5272.c                 |    2 +-
 drivers/iio/potentiometer/ds1803.c                 |    2 +-
 drivers/iio/potentiometer/max5432.c                |    2 +-
 drivers/iio/potentiometer/mcp4018.c                |    2 +-
 drivers/iio/potentiometer/mcp4531.c                |    2 +-
 drivers/iio/potentiometer/tpl0102.c                |    2 +-
 drivers/iio/potentiometer/x9250.c                  |  220 +++++
 drivers/iio/potentiostat/lmp91000.c                |    2 +-
 drivers/iio/pressure/Kconfig                       |   13 +
 drivers/iio/pressure/Makefile                      |    1 +
 drivers/iio/pressure/abp060mg.c                    |    2 +-
 drivers/iio/pressure/bmp280-i2c.c                  |    2 +-
 drivers/iio/pressure/dlhl60d.c                     |    2 +-
 drivers/iio/pressure/dps310.c                      |    2 +-
 drivers/iio/pressure/hp03.c                        |    2 +-
 drivers/iio/pressure/hp206c.c                      |    2 +-
 drivers/iio/pressure/icp10100.c                    |    2 +-
 drivers/iio/pressure/mpl115_i2c.c                  |    2 +-
 drivers/iio/pressure/mpl3115.c                     |    2 +-
 drivers/iio/pressure/mprls0025pa.c                 |  450 +++++++++
 drivers/iio/pressure/ms5611_i2c.c                  |    2 +-
 drivers/iio/pressure/ms5637.c                      |    2 +-
 drivers/iio/pressure/st_pressure_i2c.c             |    2 +-
 drivers/iio/pressure/t5403.c                       |    2 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |    2 +-
 drivers/iio/proximity/isl29501.c                   |    2 +-
 drivers/iio/proximity/mb1232.c                     |    2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    2 +-
 drivers/iio/proximity/rfd77402.c                   |    2 +-
 drivers/iio/proximity/srf08.c                      |    2 +-
 drivers/iio/proximity/sx9310.c                     |    2 +-
 drivers/iio/proximity/sx9324.c                     |    2 +-
 drivers/iio/proximity/sx9360.c                     |    2 +-
 drivers/iio/proximity/sx9500.c                     |    2 +-
 drivers/iio/proximity/vcnl3020.c                   |    2 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |    2 +-
 drivers/iio/temperature/max30208.c                 |    2 +-
 drivers/iio/temperature/mlx90614.c                 |  239 +++--
 drivers/iio/temperature/mlx90632.c                 |    2 +-
 drivers/iio/temperature/tmp006.c                   |   10 +-
 drivers/iio/temperature/tmp007.c                   |    2 +-
 drivers/iio/temperature/tmp117.c                   |    2 +-
 drivers/iio/temperature/tsys01.c                   |    2 +-
 drivers/iio/temperature/tsys02d.c                  |    2 +-
 drivers/staging/iio/addac/adt7316-i2c.c            |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    2 +-
 include/linux/iio/common/st_sensors.h              |    1 +
 include/linux/iio/iio.h                            |    3 +
 include/linux/iio/trigger.h                        |    1 +
 include/linux/platform_data/st_sensors_pdata.h     |    2 +-
 242 files changed, 3313 insertions(+), 473 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2700=
8.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4001.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ren=
esas,x9250.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywel=
l,mprls0025pa.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tm=
p006.yaml
 create mode 100644 drivers/iio/light/opt4001.c
 create mode 100644 drivers/iio/light/rohm-bu27008.c
 create mode 100644 drivers/iio/potentiometer/x9250.c
 create mode 100644 drivers/iio/pressure/mprls0025pa.c
