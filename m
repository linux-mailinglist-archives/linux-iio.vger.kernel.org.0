Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847A88A7CC
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 22:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfHLUEd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 16:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfHLUEd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Aug 2019 16:04:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0839D2085A;
        Mon, 12 Aug 2019 20:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640271;
        bh=eCw4EvXsudrorQDYcjt4j2KSoVe7TXWudIaNQzxNcII=;
        h=Date:From:To:Subject:From;
        b=HhzBIf2DqeIaS0ULexXuC23utFhxdHfaOKrHK6hbbXkWM+9lVLAMQZPHY2l2qABg1
         mN8BCy+H7oiX8Y4fBRbQM2/vR0hiRx8rDFLJy+MI2tgVYV6oTYbs+C/NMaPxd9rlDa
         D93cbuHvgSG+epygeJfwk9SeD+dL1OJ99vmtorhs=
Date:   Mon, 12 Aug 2019 21:04:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of new device support, cleanups and features for
 IIO in the 5.4 cycle.
Message-ID: <20190812210428.1668b6d8@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit e59fc52529118aaad9aa666f25530dde6e2180e9:

  staging: rtl8192*: display ESSIDs using %pE (2019-07-25 14:38:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.4a

for you to fetch changes up to ef19ee60f9cf713518c1d5e15946466d51e9f00b:

  iio: hi8435: Drop hi8435_remove() by using devres for remaining elements =
(2019-08-11 09:59:38 +0100)

----------------------------------------------------------------
First set of new device support, features and cleanups for IIO in the 5.4 c=
ycle

Note includes a merge from i3c tree to get support needed for stm_lsm6dsx d=
river
support for l3c devices.  Done from immutable branch.

A counter subsystem patche in here as well.

Alongside the new device support (which is always good), Chuhong's work
on using devres managed APIs has cleaned up a number of drivers.

New device support
* adis16460
  - New driver based on ADIS framework which needed addition of support
    for cs_change_delay. Includes device tree binding.
* cros_ec
  - Support fo the veyron-minnie which uses an older interface.
* lsm6dsx
  - Support for LSM6DSTR-C gyro + magnetometer sensor (new IDs mainly)
  - Support for ISM330DHCX acc + gyro sensor (extensive rework needed!)
* Maxim 5432
  - New driver support MAX5432-MAX5435 family of potentiometers.
* noa1305
  - New driver for this ON Semiconductor Ambient light sensor.

Features and cleanups
* tree wide
  - Drop error prints after platform_get_irq as already prints errors
    internally if any occur.
* docs
  - Document mounting matrix.
  - Fix a missing newline at end of file.
* ad2s1210
  - Switch to device managed APIs for all of probe and drop explicit remove.
* ad7192
  - Add of_device_id array to explicity handling DT bindings.
* ad7606
  - Lots of rework leading to support for software configure modes in ad7616
    parts.
  - Debugfs register access support.
* am2315
  - Switch to device managed APIs for all of probe and drop explicit remove.
* apds9960
  - Typo in module description.
* cm36651
  - Convert to i2c_new_dummy_device.
  - Swithc to device managed APIs for all of probe adn drop explicit remove.
* cros_ec
  - Calibscale support for accel, gyro and magnetometer.
  - Tidy up some error codes to return the error from the stack rather than
    -EIO.
  - Determine protocol version.
  - Add a sign vector to the core to fix sensor rotation if necessary.
    Cannot just be done with mount matrix as already in use in many devices.
  - Tidy up INFO_SCALE being in both the separate and shared lists.
  - Drop a lot of dplicate code from the cros-ec-accel-legacy driver
    and use the core provided code instead.
  - Make frequency range available to userspace.
* counter / ftm-quaddec
  - Switch to device managed APIs for all of probe adn drop explicit remove.
* hdc100x
  - Switch to device managed APIs for all of probe and drop explicit remove.
* hi8435
  - Use gpiod_set_value_cansleep as we don't care here and there is a
    board out there where it needs to sleep.
  - Switch to device managed APIs for all of probe and drop explict remove.
* hp03
  - Convert to i2c_new_dummy_device.
* maxim thermocouple
  - Switch to device managed APIs for all of probe and drop explicit remove.
* mmc35240
  - Fix typo in constant naming.
* mpu6050
  - Use devm_add_action_or_reset in place of explicit error handling.
  - Make text in Kconfig more explicit about which parts are supported.
* mxc4005
  - Switch to device managed APIs for all of probe and drop explicit remove.
* pms7003
  - Convert device tree bindings to yaml.
  - Add a MAINTAINERS entry
* sc27xx
  - Introduce a local struct device *dev pointer to avoid lots of deref.
  - Use devm_add_action_or_reset in place of explicit error handling.
* sca3000
  - Typo fix in naming.
* si1145
  - Switch to device managed APIs for all of probe and drop explicit remove.
* st_sensors
  - Lots of rework to enable switch to regmap.
  - Regmap conversion at the end.
  - Tidy up some inconsistencies in buffer setup ops.
  - Tidy up an oddity by dropping get_irq_data_ready function in favour
    of direct access.
  - Stop allocating buffer in buffer enable in favour of just embedding
    a large enough constant size buffer in the iio_priv accessed structure.
* st_lsm6dsx
  - l3c device support (LSM6DSO and LSM6DSR)
  - tidy up irq return logic which was strangely written.
  - fix up an ABI quirk where this driver used separate scale
    attributes, even though they were always shared by type.
* stk33xx
  - Device tree bindings include manufacturer ID.
* stm32-adc
  - Add control for supply to analog switches including DT bindings.
* stm32 timer
  - Drop the quadrature mode support.  Believed there were no users so
    take this opportunity to drop this unwanted ABI.
* tsl2772
  - Switch to device mangage APIs for all of probe and drop explicit remove.
  - Use regulator_bulk_* APIs to reduce repitition.
* veml6070
  - Convert to i2c_new_dummy_device.

----------------------------------------------------------------
Alexandru Ardelean (3):
      iio: imu: adis: Add support for SPI transfer cs_change_delay
      iio: imu: Add support for the ADIS16460 IMU
      dt-bindings: iio: imu: add bindings for ADIS16460

Andrey Smirnov (2):
      iio: hi8435: Use gpiod_set_value_cansleep()
      iio: hi8435: Drop hi8435_remove() by using devres for remaining eleme=
nts

Beniamin Bia (5):
      iio: adc: ad7606: Move common channel definition to header
      iio: adc: ad7606: Move spi dependent features to spi file
      iio: adc: ad7606: Allow reconfigration after reset
      iio: adc: ad7606: Add support for software mode for ad7616
      iio: adc: ad7606: Add debug mode for ad7616

Benjamin Gaignard (1):
      IIO: stm32: Remove quadrature related functions from trigger driver

B=C3=A1rbara Fernandes (1):
      staging: iio: ad7192: create of_device_id array

Christophe JAILLET (3):
      iio: sca3000: Fix a typo
      iio: light: apds9960: Fix a typo
      iio: magnetometer: mmc35240: Fix a typo in the name of a constant

Chuhong Yuan (11):
      iio: maxim_thermocouple: Use device-managed APIs
      staging: iio: ad2s1210: Use device-managed API
      iio: humidity: Use device-managed APIs
      iio: mxc4005: Use device-managed APIs
      counter/ftm-quaddec: Use device-managed registration API
      iio: light: cm3323: Use device-managed APIs
      iio: light: si1145: Use device-managed APIs
      iio: tsl2772: Use devm_add_action_or_reset
      iio: tsl2772: Use devm_add_action_or_reset for tsl2772_chip_off
      iio: tsl2772: Use devm_iio_device_register
      iio: tsl2772: Use regulator_bulk_() APIs

Denis Ciocca (17):
      iio:common:st_sensors: add st_sensors_get_settings_index() helper fun=
ction
      iio:accel: introduce st_accel_get_settings() function
      iio:gyro: introduce st_gyro_get_settings() function
      iio:magn: introduce st_magn_get_settings() function
      iio:pressure: introduce st_press_get_settings() function
      iio:accel: device settings are set immediately during probe
      iio:gyro: device settings are set immediately during probe
      iio:magn: device settings are set immediately during probe
      iio:pressure: device settings are set immediately during probe
      iio: move 3-wire spi initialization to st_sensors_spi
      iio: make st_sensors drivers use regmap
      iio:accel: preenable/postenable/predisable fixup for ST accel buffer
      iio:gyro: preenable/postenable/predisable fixup for ST gyro buffer
      iio:magn: preenable/postenable/predisable fixup for ST magn buffer
      iio:pressure: preenable/postenable/predisable fixup for ST press buff=
er
      iio: remove get_irq_data_ready() function pointer and use IRQ number =
directly
      iio:st_sensors: remove buffer allocation at each buffer enable

Fabien Lahoudere (2):
      iio: common: cros_ec_sensors: determine protocol version
      iio: common: cros_ec_sensors: Expose cros_ec_sensors frequency range =
via iio sysfs

Fabrice Gasnier (2):
      dt-bindings: iio: adc: stm32: add analog switches supply control
      iio: adc: stm32-adc: add analog switches supply control

Fuqian Huang (3):
      iio: adc: sc27xx: Introduce local variable 'struct device *dev'
      iio: adc: sc27xx: Replace devm_add_action() followed by failure actio=
n with devm_add_action_or_reset()
      iio: imu: mpu6050: Replace devm_add_action() followed by failure acti=
on with devm_add_action_or_reset()

Geert Uytterhoeven (1):
      Documentation: ABI: iio: Add missing newline at end of file

Gwendal Grignou (6):
      iio: cros_ec: Add calibscale for 3d MEMS
      iio: cros_ec: Remove replacing error code with -EIO
      iio: cros_ec: Add sign vector in core for backward compatibility
      iio: cros_ec_accel_legacy: Fix incorrect channel setting
      iio: cros_ec_accel_legacy: Use cros_ec_sensors_core
      iio: cros_ec_accel_legacy: Add support for veyron-minnie

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: be more explicit on supported chips

Jonathan Cameron (1):
      Merge tag 'tags/i3c/export-i3c_device_match_id' into HEAD

Linus Walleij (1):
      iio: document bindings for mounting matrices

Lorenzo Bianconi (8):
      iio: imu: st_lsm6dsx: add support to LSM6DS3TR-C
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds3tr-c device bindings
      iio: imu: st_lsm6dsx: move odr_table in st_lsm6dsx_sensor_settings
      iio: imu: st_lsm6dsx: move fs_table in st_lsm6dsx_sensor_settings
      iio: imu: st_lsm6dsx: inline output acc/gyro output regs
      iio: imu: st_lsm6dsx: move iio chan definitions in st_lsm6dsx_sensor_=
settings
      iio: imu: st_lsm6dsx: add support to ISM330DHCX
      dt-bindings: iio: imu: st_lsm6dsx: add ism330dhcx device bindings

Luca Weiss (3):
      dt-bindings: Add vendor prefix for sensortek
      dt-bindings: iio: light: add stk33xx
      iio: light: stk3310: Add device tree support

Martin Kaiser (2):
      iio: potentiometer: add a driver for Maxim 5432-5435
      dt-bindings: iio: potentiometer: add max5432.yaml binding

Martin Kepplinger (1):
      iio: imu: st_lsm6dsx: make IIO_CHAN_INFO_SCALE shared by type

Martyn Welch (2):
      dt-bindings: Add binding document for NOA1305
      iio: light: noa1305: Add support for NOA1305

Sean Nyekjaer (1):
      iio: imu: st_lsm6dsx: flip irq return logic

Stephen Boyd (1):
      iio: Remove dev_err() usage after platform_get_irq()

Tomasz Duszynski (2):
      dt-bindings: iio: chemical: pms7003: convert bindings to yaml
      MAINTAINERS: add entry for plantower pms7003 driver

Vitor Soares (2):
      i3c: move i3c_device_match_id to device.c and export it
      iio: imu: st_lsm6dsx: add i3c basic support for LSM6DSO and LSM6DSR

Wolfram Sang (3):
      iio: light: cm36651: convert to i2c_new_dummy_device
      iio: light: veml6070: convert to i2c_new_dummy_device
      iio: pressure: hp03: convert to i2c_new_dummy_device

 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |   2 +-
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  23 -
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   6 +
 .../bindings/iio/chemical/plantower,pms7003.txt    |  26 --
 .../bindings/iio/chemical/plantower,pms7003.yaml   |  51 +++
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |  53 +++
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   2 +
 .../devicetree/bindings/iio/light/noa1305.yaml     |  44 ++
 .../devicetree/bindings/iio/light/stk33xx.yaml     |  49 +++
 .../devicetree/bindings/iio/mount-matrix.txt       | 203 +++++++++
 .../bindings/iio/potentiometer/max5432.yaml        |  44 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  14 +
 drivers/counter/ftm-quaddec.c                      |  30 +-
 drivers/i3c/device.c                               |  53 +++
 drivers/i3c/master.c                               |  45 --
 drivers/iio/accel/Kconfig                          |   4 +-
 drivers/iio/accel/cros_ec_accel_legacy.c           | 353 ++++-----------
 drivers/iio/accel/mxc4005.c                        |  40 +-
 drivers/iio/accel/sca3000.c                        |   2 +-
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_buffer.c                |  44 +-
 drivers/iio/accel/st_accel_core.c                  |  32 +-
 drivers/iio/accel/st_accel_i2c.c                   |  23 +-
 drivers/iio/accel/st_accel_spi.c                   |  20 +-
 drivers/iio/adc/ad7606.c                           |  91 ++--
 drivers/iio/adc/ad7606.h                           |  57 ++-
 drivers/iio/adc/ad7606_par.c                       |   4 +-
 drivers/iio/adc/ad7606_spi.c                       | 175 +++++++-
 drivers/iio/adc/at91_adc.c                         |   4 +-
 drivers/iio/adc/axp288_adc.c                       |   4 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |   7 +-
 drivers/iio/adc/da9150-gpadc.c                     |   4 +-
 drivers/iio/adc/envelope-detector.c                |   5 +-
 drivers/iio/adc/exynos_adc.c                       |   4 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |   1 -
 drivers/iio/adc/hi8435.c                           |  34 +-
 drivers/iio/adc/imx7d_adc.c                        |   4 +-
 drivers/iio/adc/lpc32xx_adc.c                      |   4 +-
 drivers/iio/adc/npcm_adc.c                         |   1 -
 drivers/iio/adc/rockchip_saradc.c                  |   4 +-
 drivers/iio/adc/sc27xx_adc.c                       |  45 +-
 drivers/iio/adc/spear_adc.c                        |   1 -
 drivers/iio/adc/stm32-adc-core.c                   | 194 +++++++-
 drivers/iio/adc/stm32-adc.c                        |   4 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   5 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |   4 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   4 +-
 drivers/iio/adc/vf610_adc.c                        |   4 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  54 ++-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 150 ++++++-
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |  10 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    | 118 ++---
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |  82 ++--
 drivers/iio/common/st_sensors/st_sensors_spi.c     | 148 +++----
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  31 +-
 drivers/iio/gyro/st_gyro.h                         |   1 +
 drivers/iio/gyro/st_gyro_buffer.c                  |  48 +-
 drivers/iio/gyro/st_gyro_core.c                    |  32 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |  22 +-
 drivers/iio/gyro/st_gyro_spi.c                     |  20 +-
 drivers/iio/humidity/am2315.c                      |  24 +-
 drivers/iio/humidity/hdc100x.c                     |  19 +-
 drivers/iio/imu/Kconfig                            |  12 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/adis.c                             |  12 +
 drivers/iio/imu/adis16460.c                        | 489 +++++++++++++++++=
++++
 drivers/iio/imu/inv_mpu6050/Kconfig                |  10 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   3 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |  11 +-
 drivers/iio/imu/st_lsm6dsx/Makefile                |   1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  17 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  17 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 483 ++++++++++++++++-=
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |  10 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c        |  57 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |  10 +
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/apds9960.c                       |   2 +-
 drivers/iio/light/cm3323.c                         |  33 +-
 drivers/iio/light/cm36651.c                        |  12 +-
 drivers/iio/light/cros_ec_light_prox.c             |  51 ++-
 drivers/iio/light/noa1305.c                        | 312 +++++++++++++
 drivers/iio/light/si1145.c                         |  42 +-
 drivers/iio/light/stk3310.c                        |   9 +
 drivers/iio/light/tsl2772.c                        | 124 ++----
 drivers/iio/light/veml6070.c                       |   6 +-
 drivers/iio/magnetometer/mmc35240.c                |   4 +-
 drivers/iio/magnetometer/st_magn.h                 |   1 +
 drivers/iio/magnetometer/st_magn_buffer.c          |  31 +-
 drivers/iio/magnetometer/st_magn_core.c            |  32 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |  22 +-
 drivers/iio/magnetometer/st_magn_spi.c             |  20 +-
 drivers/iio/potentiometer/Kconfig                  |  11 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/max5432.c                | 135 ++++++
 drivers/iio/pressure/cros_ec_baro.c                |  19 +-
 drivers/iio/pressure/hp03.c                        |   6 +-
 drivers/iio/pressure/st_pressure.h                 |   1 +
 drivers/iio/pressure/st_pressure_buffer.c          |  39 +-
 drivers/iio/pressure/st_pressure_core.c            |  32 +-
 drivers/iio/pressure/st_pressure_i2c.c             |  31 +-
 drivers/iio/pressure/st_pressure_spi.c             |  22 +-
 drivers/iio/temperature/maxim_thermocouple.c       |  25 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |  84 ----
 drivers/staging/iio/adc/ad7192.c                   |  12 +
 drivers/staging/iio/resolver/ad2s1210.c            |  12 +-
 include/linux/i3c/device.h                         |   4 +
 include/linux/iio/common/cros_ec_sensors_core.h    |  28 +-
 include/linux/iio/common/st_sensors.h              |  66 +--
 include/linux/iio/common/st_sensors_i2c.h          |   4 +-
 include/linux/iio/common/st_sensors_spi.h          |   4 +-
 include/linux/iio/imu/adis.h                       |   2 +
 114 files changed, 3455 insertions(+), 1518 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/plantowe=
r,pms7003.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantowe=
r,pms7003.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460=
.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/noa1305.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/stk33xx.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max=
5432.yaml
 create mode 100644 drivers/iio/imu/adis16460.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
 create mode 100644 drivers/iio/light/noa1305.c
 create mode 100644 drivers/iio/potentiometer/max5432.c
