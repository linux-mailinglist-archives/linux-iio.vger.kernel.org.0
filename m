Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1753D17D5C0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 20:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCHTGr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 15:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgCHTGr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Mar 2020 15:06:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366EB206D7;
        Sun,  8 Mar 2020 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583694405;
        bh=lR3vSIwRJ6PNPvBGMB6t6yrz/aJjq6lusV3QExXQY5o=;
        h=Date:From:To:Subject:From;
        b=Yg8vjxJrN37lQn8jyzD7fFoel48FNpbU2TGHOPirFRd6DW3DiAdPLSepgjK8bzvpA
         yA5CHyezAH89n9iGn1BfDqin0RH1/nbPXZapKDkUZKx+EjQ0gC9ksyZL2n62u1ZtWK
         wHWPKBSLsnoyw+rELAYstdKuAO9Tw2QnTNS4oTRo=
Date:   Sun, 8 Mar 2020 19:06:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of new IIO device support, features and cleanups
 in the 5.7 cycle.
Message-ID: <20200308190642.1ceced2c@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 8ef0c4f06432b5b2f4e32f37b81708eae1e20c8c:

  Revert "staging/octeon: Mark Ethernet driver as BROKEN" (2020-02-12 13:50=
:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-5.7a

for you to fetch changes up to fe297f8f048a7a0663479dcf6447ec450b53b905:

  iio: dac: Kconfig: sort symbols alphabetically (2020-03-08 17:28:54 +0000)

----------------------------------------------------------------
First set of new IIO device support, fatures and cleanups for the 5.7 cycle

Includes changes for the counter subsystem

Core Feature
* Explicitly handle sysfs values in dB, including correctly handling the
  needed postfix dB.
* Add a TODO to suggest suitable activities for new contributors to IIO now
  the vast majority of drivers are out of staging (and the remaining ones
  there are 'hard'). Also update the TODO in staging to remove stale entrie=
s.

Staging graduations
* ad7192 ADC.

New device support
* ad5770r
  - New driver for this 6 channel DAC including DT bindings.
* ad8366
  - Add supprot for the hmc1119 attenuator.
* al3010
  - New driver supporting this Dyna-image light sensors.
  - Power management and DT bindings added in additional patches.
* atlas-sensor
  - Add support for atlas DO-SM device.  Reads disolved oxygen in a solutio=
n.
* gpap002x00f
  - New driver and bindings to support the GP2AP002A00F and GP2AP002S00F li=
ght
    and proximity sensors. There is some limited existing support in
    input.  The intent is to drop this driver once IIO driver is in place.
* hmc425a
  - New driver for this attenuator.
* icp10100
  - New driver for this presure sensor.
* ltc2632
  - Add support for the ltc2636 8 channel DAC. Includes bindings and some
    tidying up of the driver.
* inv_mpu6050
  - Support IAM20680, ICM20609, ICM20689 and ICM20690.
    Includes related tidy up and rework of low pass filter bandwidth
    handling to give suitable values for all chips.

Binding conversions to yaml or missing bindings docs.
* atlas-sensor, including consolidation of previous 3 separate docs into 1.
* ad7923, previously no doc.
* max1363, split into max1238 and max1363 to simplify yaml.
* stm32-adc

Features
* (counter) 104-quad-8
  - Support a filter clock prescaler.
  - Support reporting of encoder cable status.
* ad7124
  - Low pass filter support.
  - Debugfs interface to access registers directly.
* ad8366
  - Support control of hardware gain.
* inv_mpu6050
  - Runtime pm with autosuspend.
* npcm adc
  - Add reset support. This is a breaking change if DT is not in sync,
    however this device is a BMC so the ecosystem is closed enought that
    this should not be a problem.
* srf04
  - Add power management with DT bindings for the GPIO.
* stm32-timer-trigger
  - Power management.
* (counter) stm32-timer-cnt
  - Power management.
* vcnl4000
  - Enable runtime PM for devices that don't use on demand measurement.

Cleanups and minor fixes
* core
  - Avoid double read when using debugfs.  Whilst we provide no guarantees
    on lack of side effects using the debugfs interfaces, this one is
    generate unexpected results so let us tidy it up.
* dac/Kconfig
  - Alphabetic order.
* ad5755
  - Grammar and minor other fixes.
* ad7124
  - Fail probe if get_voltage fails as no meaningful readings can be had
    without knowing the external reference.
  - Switch to selection between different channel attributes rather than
    building the arrays at runtime.
  - Remove the spi_device_id table as the driver cannot be probled without
    more information that can be provided without dt.
  - Update sysfs docs to provide more inormation and bring remaining docs f=
or
    this part out of staging.
* ad9292
  - Use new SPI transfer delay structure.
* adis library
  - Add unlocked version of adis_initial_startup and refactor the function.
  - Add a product ID santiy check.
  - Add support for different self test registers.
  - Use new SPI delay structure.
  - Add new docs and tidy up existing.
* adis16136
  - Initialize adis_data statically.
* adis16400
  - Initialize adis_data statically.
* adis16460
  - Use core __adis_initial_Startup now it supports everything needed.
* adis16480
  - Initialize adis_data statically.
  - Use core __adis_initial_startup now it supports everything needed.
* al3320a
  - Add missing DT binding docs.
  - Tidy up code formatting.
  - Simplify error paths using devm_add_action_or_reset.
  - Ensure autoloading works by adding the of_match_table.
* atlas-sensor
  - Drop false requirement for interrupt line, the value can be polled using
    a sysfs or hrtimer type trigger.
* exynos-adc
  - Silence warning message on deferring probe.
* gp2ap002
  - Greatly simplify the Lux LUT.
  - Reorder actions around buffer setup and tear down as part of a sub-syst=
em
    wide standardization of these.
* inv_mpu6050
  - Various lttle tidyups.
  - Simpliy I2C aux MUX handling by enabling it only at startup. It never
    needs to be disabled.
  - Simplify polling rate when magnetometer enabled by putting only under
    control of userspace.
  - Always execute full reset on devices supporting spi. It does no harm
    when using i2c and makes for simpler code.
  - Reduce over the top sleep times for vddio regulator power up.
  - Greatly simplify power and engine management.
  - Fix some delays in polled reads (only visible due to other changes)
  - Stop preventing sampling rate changes whilst running as there is no
    adverse consequence of doing so.
  - Prevent attempting to read the temperature if neither accel nor
    gyro is enabled.
* lmp9100
  - Reorder actions around buffer setup and tear down as part of a sub-syst=
em
    wide standardization of these.
* max1118
  - Use new SPI transfer delay structure.
* mcp320x
  - Use new SPI transfer delay structure.
* si1133
  - Read full 24 bit signed integer instead o dropping last 8 bits of value.
    Not a critical fix as just adds precision.
* st_sensors
  - Use st_sensors_dev_name_probe instead of open coded version in st_accel
  - Handle potential memory allocation failure.
* st_lsm6dsx
  - Fix some wrong structure element naming in documentation.
  - Add missing return value check.
* stm32_timer_cnt
  - Drop some unused left over IIO headers from this count subsystem driver.
  - Ensure the clock is enabled in master mode.  Theoretical issue rather
    than one known to happen in the wild.
* tlc4541
  - Use new SPI delay structure.

----------------------------------------------------------------
Alexandru Ardelean (11):
      iio: imu: adis16480: initialize adis_data statically
      iio: imu: adis16400: initialize adis_data statically
      iio: gyro: adis16136: initialize adis_data statically
      iio: imu: adis: add unlocked __adis_initial_startup()
      iio: imu: adis: add support product ID check in adis_initial_startup
      iio: imu: adis: add doc-string for 'adis' struct
      iio: imu: adis: update 'adis_data' struct doc-string
      iio: imu: adis: add a note better explaining state_lock
      iio: potentiostat: lmp9100: fix iio_triggered_buffer_{predisable,post=
enable} positions
      iio: light: gp2ap020a00f: fix iio_triggered_buffer_{predisable,posten=
able} positions
      iio: dac: Kconfig: sort symbols alphabetically

Alexandru Tachici (9):
      iio: adc: ad7124: add 3db filter
      staging: iio: adc: ad7192: fail probe on get_voltage
      staging: iio: adc: ad7192: modify iio_chan_spec array
      staging: iio: adc: ad7192: removed spi_device_id
      Documentation: ABI: testing: ad7192: update sysfs docs
      staging: iio: adc: ad7192: move out of staging
      iio: dac: ad5770r: Add AD5770R support
      dt-bindings: iio: dac: Add docs for AD5770R DAC
      iio: industrialio-core: Fix debugfs read

Andreas Klinger (2):
      dt-bindings: devantech-srf04.yaml: add pm feature
      iio: srf04: add power management feature

Andy Shevchenko (1):
      iio: accel: st_accel: Use st_sensors_dev_name_probe()

Beniamin Bia (3):
      iio: core: Handle 'dB' suffix in core
      iio: amplifiers: ad8366: Add write_raw_get_fmt function
      MAINTAINERS: add entry for hmc425a driver.

Colin Ian King (2):
      iio: ad5755: fix spelling mistake "to" -> "too" and grammar plus form=
atting
      iio: st_sensors: handle memory allocation failure to fix null pointer=
 dereference

Daniel Junho (1):
      dt-bindings: iio: adc: ad7923: Add binding documentation for AD7928

David Heidelberg (7):
      dt-bindings: iio: light: add support for Dyna-Image AL3320A
      dt-bindings: iio: light: add support for Dyna-Image AL3010
      iio: light: al3320a slightly improve code formatting
      iio: light: add Dyna-Image AL3010 driver
      iio: light: al3320a implement suspend support
      iio: light: al3320a implement devm_add_action_or_reset
      iio: light: al3320a allow module autoload and polish

Fabrice Gasnier (6):
      dt-bindings: iio: adc: stm32-adc: convert bindings to json-schema
      counter: stm32-timer-cnt: add power management support
      counter: stm32-timer-cnt: remove iio headers
      iio: trigger: stm32-timer: enable clock when in master mode
      iio: trigger: stm32-timer: rename enabled flag
      iio: trigger: stm32-timer: add power management support

Gregor Riepl (1):
      iio: light: Simplify the current to lux LUT

Guido G=C3=BCnther (2):
      iio: vcnl4000: Use a single return when getting IIO_CHAN_INFO_RAW
      iio: vcnl4000: Enable runtime pm for vcnl4200/4040

Jean-Baptiste Maneyrol (20):
      iio: imu: inv_mpu6050: cleanup of/acpi support
      iio: imu: inv_mpu6050: add support of ICM20609 & ICM20689
      iio: imu: inv_mpu6050: add support of IAM20680
      iio: imu: inv_mpu6050: add support of ICM20690
      iio: imu: inv_mpu6050: update LPF bandwidth settings
      dt-bindings: add description for new supported chips
      iio: imu: inv_mpu6050: enable i2c aux mux bypass only once
      iio: imu: inv_mpu6050: delete useless check
      iio: imu: inv_mpu6050: set power on/off only once during all init
      iio: imu: inv_mpu6050: simplify polling magnetometer
      iio: imu: inv_mpu6050: early init of chip_config for use at setup
      iio: imu: inv_mpu6050: add all signal path resets at init
      iio: imu: inv_mpu6050: reduce sleep time when turning regulators on
      iio: imu: inv_mpu6050: rewrite power and engine management
      iio: imu: inv_mpu6050: fix data polling interface
      iio: imu: inv_mpu6050: factorize fifo enable/disable
      iio: imu: inv_mpu6050: dynamic sampling rate change
      iio: imu: inv_mpu6050: use runtime pm with autosuspend
      iio: imu: inv_mpu6050: temperature only work with accel/gyro
      iio: pressure: icp10100: add driver for InvenSense ICP-101xx

JieunKim (1):
      iio: imu: st_lsm6dsx: Fix mismatched comments

Jonathan Cameron (1):
      dt-bindings: iio: adc: max1363 etc i2c ADC binding conversion

Linus Walleij (2):
      iio: light: Add DT bindings for GP2AP002
      iio: light: Add a driver for Sharp GP2AP002x00F

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: check return value from st_lsm6dsx_sensor_set_e=
nable

Marek Szyprowski (1):
      iio: adc: exynos: Silence warning about regulators during deferred pr=
obe

Matt Ranostay (3):
      iio: chemical: atlas-sensor: allow probe without interrupt line
      iio: chemical: atlas-sensor: add DO-SM module support
      dt-bindings: iio: chemical: consolidate atlas-sensor docs

Maxime Roussin-B=C3=A9langer (1):
      iio: si1133: read 24-bit signed integer for measurement

Michael Hennerich (2):
      iio: amplifiers: hmc425a: Add support for HMC425A attenuator
      dt-bindings: iio: amplifiers: Add docs for HMC425A Step Attenuator

Mircea Caprioru (1):
      iio: adc: ad7124: Add direct reg access

Nuno S=C3=A1 (4):
      iio: imu: adis: Add self_test_reg variable
      iio: imu: adis: Refactor adis_initial_startup
      iio: adis16480: Make use of __adis_initial_startup
      iio: adis16460: Make use of __adis_initial_startup

Rohit Sarkar (2):
      staging: iio: update TODO
      iio: add a TODO

Sergiu Cuciurean (6):
      iio: amplifiers: ad8366: add support for HMC1119 Attenuator
      iio: adc: ad9292: Use new structure for SPI transfer delays
      iio: adc: max1118: Use new structure for SPI transfer delays
      iio: adc: mcp320x: Use new structure for SPI transfer delays
      iio: adc: ti-tlc4541: Use new structure for SPI transfer delays
      iio: imu: adis_buffer: Use new structure for SPI transfer delays

Tomer Maimon (2):
      dt-binding: iio: add NPCM ADC reset support
      iio: adc: modify NPCM reset support

Uwe Kleine-K=C3=B6nig (4):
      dt-bindings: iio: ltc2632: expand for ltc2636 support
      iio: dac: ltc2632: drop some duplicated data
      iio: dac: ltc2632: add support for LTC2636 family
      iio: dac: ltc2632: remove some unused defines

William Breathitt Gray (2):
      counter: 104-quad-8: Support Filter Clock Prescaler
      counter: 104-quad-8: Support Differential Encoder Cable Status

 .../ABI/testing/sysfs-bus-counter-104-quad-8       |  25 +
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 |  24 +-
 .../devicetree/bindings/iio/adc/adi,ad7923.yaml    |  65 ++
 .../devicetree/bindings/iio/adc/max1363.txt        |  63 --
 .../devicetree/bindings/iio/adc/maxim,max1238.yaml |  76 +++
 .../devicetree/bindings/iio/adc/maxim,max1363.yaml |  50 ++
 .../bindings/iio/adc/nuvoton,npcm-adc.txt          |   2 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 149 -----
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 458 +++++++++++++
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |  49 ++
 .../bindings/iio/chemical/atlas,ec-sm.txt          |  21 -
 .../bindings/iio/chemical/atlas,orp-sm.txt         |  21 -
 .../bindings/iio/chemical/atlas,ph-sm.txt          |  21 -
 .../bindings/iio/chemical/atlas,sensor.yaml        |  53 ++
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   | 185 ++++++
 .../devicetree/bindings/iio/dac/ltc2632.txt        |   8 +-
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   5 +
 .../bindings/iio/light/dynaimage,al3010.yaml       |  43 ++
 .../bindings/iio/light/dynaimage,al3320a.yaml      |  43 ++
 .../bindings/iio/light/sharp,gp2ap002.yaml         |  85 +++
 .../bindings/iio/proximity/devantech-srf04.yaml    |  18 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  25 +
 drivers/counter/104-quad-8.c                       | 136 +++-
 drivers/counter/stm32-timer-cnt.c                  |  66 +-
 drivers/iio/TODO                                   |  19 +
 drivers/iio/accel/adis16201.c                      |   1 +
 drivers/iio/accel/adis16209.c                      |   1 +
 drivers/iio/accel/st_accel_i2c.c                   |   5 +-
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7124.c                           |  99 ++-
 drivers/{staging =3D> }/iio/adc/ad7192.c             | 152 +++--
 drivers/iio/adc/ad7292.c                           |   5 +-
 drivers/iio/adc/exynos_adc.c                       |   6 +-
 drivers/iio/adc/max1118.c                          |  10 +-
 drivers/iio/adc/mcp320x.c                          |   3 +-
 drivers/iio/adc/npcm_adc.c                         |  30 +-
 drivers/iio/adc/ti-tlc4541.c                       |   3 +-
 drivers/iio/amplifiers/Kconfig                     |  10 +
 drivers/iio/amplifiers/Makefile                    |   1 +
 drivers/iio/amplifiers/ad8366.c                    |  30 +
 drivers/iio/amplifiers/hmc425a.c                   | 248 +++++++
 drivers/iio/chemical/atlas-sensor.c                |  97 ++-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   4 +
 drivers/iio/dac/Kconfig                            |  71 +-
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5755.c                           |  22 +-
 drivers/iio/dac/ad5770r.c                          | 695 +++++++++++++++++=
+++
 drivers/iio/dac/ltc2632.c                          | 102 ++-
 drivers/iio/gyro/adis16136.c                       |  62 +-
 drivers/iio/gyro/adis16260.c                       |   1 +
 drivers/iio/imu/adis.c                             |  68 +-
 drivers/iio/imu/adis16400.c                        | 140 ++--
 drivers/iio/imu/adis16460.c                        |  40 +-
 drivers/iio/imu/adis16480.c                        | 197 +++---
 drivers/iio/imu/adis_buffer.c                      |   3 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |  12 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 651 ++++++++++++++---=
--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          | 111 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  58 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         |  49 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h         |   5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  57 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |  74 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      | 160 +++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   5 +-
 drivers/iio/industrialio-core.c                    |  54 +-
 drivers/iio/light/Kconfig                          |  21 +
 drivers/iio/light/Makefile                         |   2 +
 drivers/iio/light/al3010.c                         | 242 +++++++
 drivers/iio/light/al3320a.c                        |  72 ++-
 drivers/iio/light/gp2ap002.c                       | 720 +++++++++++++++++=
++++
 drivers/iio/light/gp2ap020a00f.c                   |  23 +-
 drivers/iio/light/si1133.c                         |  37 +-
 drivers/iio/light/vcnl4000.c                       | 144 ++++-
 drivers/iio/potentiostat/lmp91000.c                |  18 +-
 drivers/iio/pressure/Kconfig                       |  11 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/icp10100.c                    | 658 +++++++++++++++++=
++
 drivers/iio/proximity/srf04.c                      |  96 ++-
 drivers/iio/trigger/stm32-timer-trigger.c          | 161 ++++-
 .../staging/iio/Documentation/sysfs-bus-iio-ad7192 |  20 -
 drivers/staging/iio/TODO                           |   8 +-
 drivers/staging/iio/accel/adis16203.c              |   1 +
 drivers/staging/iio/accel/adis16240.c              |   1 +
 drivers/staging/iio/adc/Kconfig                    |  12 -
 drivers/staging/iio/adc/Makefile                   |   1 -
 include/linux/iio/iio.h                            |   2 +
 include/linux/iio/imu/adis.h                       |  51 +-
 91 files changed, 6045 insertions(+), 1329 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7923.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1238=
.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1363=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.=
txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hm=
c425a.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec=
-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,or=
p-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph=
-sm.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,se=
nsor.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/light/dynaimage,a=
l3010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/dynaimage,a=
l3320a.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/sharp,gp2ap=
002.yaml
 create mode 100644 drivers/iio/TODO
 rename drivers/{staging =3D> }/iio/adc/ad7192.c (90%)
 create mode 100644 drivers/iio/amplifiers/hmc425a.c
 create mode 100644 drivers/iio/dac/ad5770r.c
 create mode 100644 drivers/iio/light/al3010.c
 create mode 100644 drivers/iio/light/gp2ap002.c
 create mode 100644 drivers/iio/pressure/icp10100.c
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
