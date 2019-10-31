Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63824EB88D
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2019 21:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfJaUqD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Oct 2019 16:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbfJaUqD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 31 Oct 2019 16:46:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECA8C2086D;
        Thu, 31 Oct 2019 20:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572554761;
        bh=8O6/asejFujYQyoy6ZS5P1919dJ6jJl6pFuxcawlf+8=;
        h=Date:From:To:Subject:From;
        b=TNGN+WEnKNPU/T5IINFfKwlB4tuUnDqjkI4sKq1ZqUMOr4bbgrXRPBewwYzVuKUsP
         9w8Fn1LBtSeQMIR0zrjY/Ci3HCuRGOkMjTu0Ps9tEZPbYqog2IY9BzH6ON63hxhPuh
         Rex965ScVlgckOG5SUCi+G8DJMhyoSpKqWMaZLuo=
Date:   Thu, 31 Oct 2019 20:45:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO + counter new device support, features etc
 for the 5.5 cycle.
Message-ID: <20191031204557.1ed83e95@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 88d0facf186c6c652c2203536fecd77089b43a4e:

  staging: wfx: fix potential vulnerability to spectre (2019-10-14 15:37:19=
 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-5.5b

for you to fetch changes up to 5a3436dc3610f63d5cdf5e34af22097a6ed29a9f:

  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsrx device bindings (2019-10-=
27 16:39:48 +0000)

----------------------------------------------------------------
Second set of IIO + counter new device support, features etc for the 5.5 cy=
cle.

Note two merge commits in here, both for immutable branches based
of 5.4-rc1.
1. Ti eqep driver because of some file moves in precursor patches.
   I suspect no one else will pull this one.
2. ab8500 refactor as changes in power supply, hwmon and mfd trees.
   This may come via numerous trees as well as IIO.

Counter subsystem related
* ti eqep
  - New device support with bindings.
  - Includes prior file move to reflect more general use of ti-pwmss.
* Counter core
  - simplify count_read and count_write callbacks + document change.
  - fix a typo in docs.

Various subsystems related
* AB8500
  - ab8500_btemp driver converted to be an IIO consumer driver.
  - ab8500_charger driver converted to be an IIO consumer driver.
  - ab8500_fg fuel gauge driver converted to be an IIO consumer driver.
  - ab8500 hwmon driver converted to be an IIO consumer driver.
  - mfd bindings augmented with the adc channels to make the above work.
  - drop original mfd driver.

New device support
* ab8500
  - new ADC driver used by the above other subystems via the IIO consumer
    interface.
* adux1020 photometric sensor
  - new driver and dt bindings.
* fxos877cq
  - new driver for this simple(ish) IMU with DT bindings.
* intel_mrfld_adc
  -  new driver for the ADC found on Intel Merrifield platforms.
* ltc2983
  - new driver for this multi-sensor type temperature interface.
    Includes complex DT bindings.
* max1027
  - support for 12 bit devices, max1227, max1229 and max1231 + add to trivi=
al
    bindings.
* st_lsm6dsx
  - support for the LSM6DS0 6 axis MEMs sensor.
    Note different from the LSM6DSO which the driver already supports *sigh*
  - support for the LSM6DSRX 6 axis MEMs sensor.

Features and cleanups
* ad7303
  - replace use of core mlock with a local lock with cleanly defined scope.
* ad9834
  - add a check for devm_clk_get failing.
* at91-sama5d2
  - tidy up a 0 as NULL warning.
* bmp280
  - endian type tidy ups.
  - use bulk regulator ops for a small reduction in code.
  - use devm_add_action... to simplify error path handling.
* exynos
  - drop stray semicolon.
  - use devm_platform_ioremap_resource to reduce boilerplate.
* hx711
  - various tricks to improve the frequency of read out possible.
* max1027
  - debugfs support.
  - make interrupts optional.
  - reset at probe to get clean state.
  - refactors to allow addition of new device support.
* maxim thermocouple
  - drop an unneeded semicolon.
* mb1232
  - yaml binding conversion.
* mcp320x
  - tidy up an endian types in cast warning.
* meson_saradc
  - use devm_platform_ioremap_resource to reduce boilerplate.
* mpu3050
  - make a poison value explicity big endian to supress a warning.
* pulsedlight v2
  - endian type tidy ups.
* sgp30
  - drop an excess semicolon.
* sps30
  - make truncation explicit with masking to clean up a warning.
* st sensors
  - drop gpio include as none of these support gpios.
* st_lsm6dsx
  - tidy up some alignment issues.
  - refactors to allow addition of new device support.
    * allow varients of irq related reg definitions.
    * avoid accessing active-low, open-drain regs if not provided.
    * allow varients of bdu/boot and reset regs.
    * allow for enabling or disabling wakeup sources through platform
      data (seems someone still uses this).
  - enable wake-up events for LSM6DS0
  - use the drdy mask to avoid some invalid samples during initial start
    of sensor.
  - Add support to trim the timestamp.
* stm32_adc
  - kernel-doc fixes.
* stm32_dac
  - power management support.
* stmpe-adc
  - Fix endian type of local variable.
* twl4030
  - use false / true instead of 0 / 1 for booleans.
* xilinx-xadc
  - use devm_platform_ioremap_resouce to reduce boilerplate.
* zpa2326
  - reorganise buffer handling setup to be more consistent.

Fixes (mostly recent additions)
* cpcap-adc
  - Fix mising IRQF_ONESHOT that would cause warnings to be printed.
* st_lsm6dsx
  - Sanity check the read_fifo pointer is set.
  - use locked read and update functions to prevent some races.
  - avoid accessing enable_reg if not provided.
  - take a lock to prevent a race in updating the config.
  - kernel-doc fixes.
  - document wakeup-source property in dt binding.
  - fix lsm9ds1 gyro gain definitions.

----------------------------------------------------------------
Alexandru Ardelean (2):
      iio: dac: ad7303: replace mlock with own lock
      iio: pressure: zpa2326: fix iio_triggered_buffer_postenable position

Andreas Klinger (2):
      dt-bindings: iio: maxbotix,mb1232.yaml: transform to yaml
      iio: adc: hx711: optimize performance in read cycle

Bartosz Golaszewski (2):
      iio: pressure: bmp280: use bulk regulator ops
      iio: pressure: bmp280: use devm action and remove labels from probe

Chuhong Yuan (1):
      staging: iio: ad9834: add a check for devm_clk_get

David Lechner (3):
      bus/ti-pwmss: move TI PWMSS driver from PWM to bus subsystem
      dt-bindings: counter: new bindings for TI eQEP
      counter: new TI eQEP driver

Fabrice Gasnier (2):
      iio: dac: stm32: add power management support
      iio: adc: stm32-adc: fix kernel-doc warnings

Jonathan Cameron (17):
      Merge branch 'ib-ti-eqep-5.4-rc1' into togreg
      Merge branch 'ib-ab8500-5.4-rc1' into HEAD
      iio: adc: at91-sama5d2: Replace 0 with NULL when clearing some pointe=
rs.
      iio: adc: mcp320x: Tidy up endian types in type cast.
      iio: adc: stmpe-adc: Cleanup endian type of local variable
      iio: chemical: sps30: Explicity truncate constant by masking
      iio: gyro: mpu3050: Explicity make a 'poison' value big endian
      iio: pressure: bmp280 endian tidy ups
      iio: proximity: pulsedlight v2: Tidy up an endian issue
      iio: adc: exynos: Drop a stray semicolon
      iio: adc: exynos: use devm_platform_ioremap_resource
      iio: adc: meson_saradc: use devm_platform_ioremap_resource
      iio: adc: cpcap-adc: Fix missing IRQF_ONESHOT as only threaded handle=
r.
      iio: temp: maxim thermocouple: Drop unneeded semi colon.
      iio: adc: xilinx-xadc: use devm_platform_ioremap_resource
      iio: adc: twl4030: Use false / true instead of 0 / 1 with booleans
      iio: chemical: sgp30: drop excess semicolon

Linus Walleij (8):
      power: supply: ab8500_btemp: Convert to IIO ADC
      power: supply: ab8500_charger: Convert to IIO ADC
      power: supply: ab8500_fg: Convert to IIO ADC
      hwmon: ab8500: Convert to IIO ADC
      mfd: ab8500: Augment DT bindings
      iio: adc: New driver for the AB8500 GPADC
      mfd: Switch the AB8500 GPADC to IIO
      iio: st: Drop GPIO include

Lorenzo Bianconi (19):
      iio: imu: st_lsm6dsx: use st_lsm6dsx_read_locked in st_lsm6dsx_report=
_motion_event
      iio: imu: st_lsm6dsx: add sanity check for read_fifo pointer
      iio: imu: st_lsm6dsx: move irq related definitions in irq_config
      iio: imu: st_lsm6dsx: do not access active-low/open-drain regs if not=
 supported
      iio: imu: st_lsm6dsx: move bdu/boot and reset register info in hw_set=
tings
      iio: imu: st_lsm6dsx: always check enable_reg in st_lsm6dsx_event_set=
up
      iio: imu: st_lsm6dsx: rely on st_lsm6dsx_update_bits_locked configuri=
ng events
      iio: imu: st_lsm6dsx: grab conf mutex in st_lsm6dsx_write_event_config
      iio: imu: st_lsm6dsx: fix checkpatch warning
      iio: imu: st_lsm6dsx: add wakeup_source in st_sensors_platform_data
      iio: imu: st_lsm6dsx: add missing kernel documenation
      dt-bindings: iio: imu: st_lsm6dsx: document missing wakeup-source pro=
perty
      iio: imu: st_lsm6dsx: enable wake-up event for LSM6DSO
      iio: imu: st_lsm6dsx: enable drdy-mask if available
      iio: imu: st_lsm6dsx: fix gyro gain definitions for LSM9DS1
      iio: imu: st_lsm6dsx: add support to LSM6DS0
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds0 device bindings
      iio: imu: st_lsm6dsx: add support to LSM6DSRX
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsrx device bindings

Manivannan Sadhasivam (2):
      dt-bindings: iio: light: Add binding for ADUX1020
      iio: light: Add support for ADUX1020 sensor

Mario Tesi (1):
      iio: imu: st_lsm6dsx: add odr calibration feature

Miquel Raynal (8):
      iio: adc: max1027: Add debugfs register read support
      iio: adc: max1027: Make it optional to use interrupts
      iio: adc: max1027: Reset the device at probe time
      iio: adc: max1027: Prepare the introduction of different resolutions
      iio: adc: max1027: Introduce 12-bit devices support
      dt-bindings: iio: adc: max1027: Mark interrupts as optional
      dt-bindings: Add 1027/1029/1031 SPI ADCs as trivial devices
      dt-bindings: Add max12xx SPI ADC series as trivial devices

Nuno S=C3=A1 (2):
      iio: temperature: Add support for LTC2983
      dt-bindings: iio: Add ltc2983 documentation

Robert Jones (2):
      dt-bindings: iio: imu: add fxos8700 imu binding
      iio: imu: Add support for the FXOS8700 IMU

Vincent Pelletier (1):
      iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver

William Breathitt Gray (3):
      counter: Simplify the count_read and count_write callbacks
      docs: driver-api: generic-counter: Update Count and Signal data types
      counter: Fix typo in action_get description

 .../devicetree/bindings/counter/ti-eqep.yaml       |   50 +
 .../devicetree/bindings/iio/adc/max1027-adc.txt    |   20 -
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |   76 +
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |    3 +
 .../devicetree/bindings/iio/light/adux1020.yaml    |   47 +
 .../bindings/iio/proximity/maxbotix,mb1232.txt     |   29 -
 .../bindings/iio/proximity/maxbotix,mb1232.yaml    |   60 +
 .../bindings/iio/temperature/adi,ltc2983.yaml      |  480 ++++++
 Documentation/devicetree/bindings/mfd/ab8500.txt   |  119 ++
 .../devicetree/bindings/trivial-devices.yaml       |   12 +
 Documentation/driver-api/generic-counter.rst       |  162 +-
 MAINTAINERS                                        |   15 +
 drivers/bus/Kconfig                                |    9 +
 drivers/bus/Makefile                               |    1 +
 drivers/{pwm/pwm-tipwmss.c =3D> bus/ti-pwmss.c}      |    0
 drivers/counter/104-quad-8.c                       |   33 +-
 drivers/counter/Kconfig                            |   11 +
 drivers/counter/Makefile                           |    1 +
 drivers/counter/counter.c                          |  101 +-
 drivers/counter/ftm-quaddec.c                      |   14 +-
 drivers/counter/stm32-lptimer-cnt.c                |    5 +-
 drivers/counter/stm32-timer-cnt.c                  |   17 +-
 drivers/counter/ti-eqep.c                          |  466 ++++++
 drivers/hwmon/Kconfig                              |    3 +-
 drivers/hwmon/ab8500.c                             |   65 +-
 drivers/iio/accel/st_accel_core.c                  |    1 -
 drivers/iio/adc/Kconfig                            |   25 +-
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ab8500-gpadc.c                     | 1218 +++++++++++++++
 drivers/iio/adc/at91-sama5d2_adc.c                 |    4 +-
 drivers/iio/adc/cpcap-adc.c                        |    2 +-
 drivers/iio/adc/exynos_adc.c                       |    6 +-
 drivers/iio/adc/hx711.c                            |   22 +-
 drivers/iio/adc/intel_mrfld_adc.c                  |  262 ++++
 drivers/iio/adc/max1027.c                          |  180 ++-
 drivers/iio/adc/mcp320x.c                          |    2 +-
 drivers/iio/adc/meson_saradc.c                     |    4 +-
 drivers/iio/adc/stm32-adc-core.c                   |   11 +-
 drivers/iio/adc/stm32-adc.c                        |   21 +-
 drivers/iio/adc/stmpe-adc.c                        |    2 +-
 drivers/iio/adc/twl4030-madc.c                     |   18 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    4 +-
 drivers/iio/chemical/sgp30.c                       |    2 +-
 drivers/iio/chemical/sps30.c                       |    2 +-
 drivers/iio/dac/ad7303.c                           |   13 +-
 drivers/iio/dac/stm32-dac-core.c                   |  138 +-
 drivers/iio/dac/stm32-dac.c                        |   94 +-
 drivers/iio/gyro/mpu3050-core.c                    |    2 +-
 drivers/iio/gyro/st_gyro_core.c                    |    1 -
 drivers/iio/imu/Kconfig                            |   27 +
 drivers/iio/imu/Makefile                           |    5 +
 drivers/iio/imu/fxos8700.h                         |   10 +
 drivers/iio/imu/fxos8700_core.c                    |  649 ++++++++
 drivers/iio/imu/fxos8700_i2c.c                     |   71 +
 drivers/iio/imu/fxos8700_spi.c                     |   59 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   45 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   22 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  645 +++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   10 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   10 +
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/adux1020.c                       |  849 +++++++++++
 drivers/iio/magnetometer/st_magn_core.c            |    1 -
 drivers/iio/pressure/bmp280-core.c                 |  129 +-
 drivers/iio/pressure/bmp280-i2c.c                  |    6 -
 drivers/iio/pressure/bmp280-spi.c                  |    6 -
 drivers/iio/pressure/bmp280.h                      |    1 -
 drivers/iio/pressure/st_pressure_core.c            |    1 -
 drivers/iio/pressure/zpa2326.c                     |   16 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    5 +-
 drivers/iio/temperature/Kconfig                    |   11 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/ltc2983.c                  | 1557 ++++++++++++++++=
++++
 drivers/iio/temperature/maxim_thermocouple.c       |    2 +-
 drivers/mfd/Kconfig                                |    7 -
 drivers/mfd/Makefile                               |    1 -
 drivers/mfd/ab8500-debugfs.c                       |  715 ---------
 drivers/mfd/ab8500-gpadc.c                         | 1075 --------------
 drivers/power/supply/Kconfig                       |    2 +-
 drivers/power/supply/ab8500_btemp.c                |   41 +-
 drivers/power/supply/ab8500_charger.c              |   78 +-
 drivers/power/supply/ab8500_fg.c                   |   23 +-
 drivers/pwm/Kconfig                                |    9 -
 drivers/pwm/Makefile                               |    1 -
 drivers/staging/iio/frequency/ad9834.c             |    4 +
 include/linux/counter.h                            |   76 +-
 include/linux/mfd/abx500/ab8500-gpadc.h            |   75 -
 include/linux/platform_data/st_sensors_pdata.h     |    2 +
 90 files changed, 7368 insertions(+), 2729 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max1027-adc.t=
xt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/nxp,fxos8700.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/maxboti=
x,mb1232.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxboti=
x,mb1232.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,l=
tc2983.yaml
 rename drivers/{pwm/pwm-tipwmss.c =3D> bus/ti-pwmss.c} (100%)
 create mode 100644 drivers/counter/ti-eqep.c
 create mode 100644 drivers/iio/adc/ab8500-gpadc.c
 create mode 100644 drivers/iio/adc/intel_mrfld_adc.c
 create mode 100644 drivers/iio/imu/fxos8700.h
 create mode 100644 drivers/iio/imu/fxos8700_core.c
 create mode 100644 drivers/iio/imu/fxos8700_i2c.c
 create mode 100644 drivers/iio/imu/fxos8700_spi.c
 create mode 100644 drivers/iio/light/adux1020.c
 create mode 100644 drivers/iio/temperature/ltc2983.c
 delete mode 100644 drivers/mfd/ab8500-gpadc.c
 delete mode 100644 include/linux/mfd/abx500/ab8500-gpadc.h
