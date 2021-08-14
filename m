Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E23EC406
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhHNRNT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 14 Aug 2021 13:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238793AbhHNRNT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Aug 2021 13:13:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E876460F48;
        Sat, 14 Aug 2021 17:12:49 +0000 (UTC)
Date:   Sat, 14 Aug 2021 18:15:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO + counter new device support, cleanups etc
 for 5.15
Message-ID: <20210814181547.5f3471ec@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.15a

for you to fetch changes up to 94a853eca720ac9e385e59f27e859b4a01123f58:

  counter: 104-quad-8: Describe member 'lock' in 'quad8' (2021-08-09 20:24:38 +0100)

----------------------------------------------------------------
First set of new IIO and counter device support, cleanups and features for 5.15

Usual mix of cleanups and new device support.

Counter
======

Cleanups and refactoring:
* treewide
  - Ensure attempts to set invalid modes result in -EINVAL return.
  - Rename counter_count_function to counter_function as the middle count
    is redundant.
  - Standardize error returns when limits are exceeded.
* 104-quad:
  - Document the lock.
  - Return an error if attempt to set the ceiling value in a mode that
    doesn't support it.
* intel-qep
  - Drop unused bitops.h include
,
IIO
===

New device support
* bma255
  - Add support fo the bosch,bmc156_accel which oddly only exposes the INT2
    interrupt pin and not INT1. Patch set includes enabling use of INT2.
* ingenic_adc
  - Add support for JZ4760 and similar and update bindings
  - Add support for JZ4760B and update bindings
* rockchip_saradc
  - Add support for rk3568 ADC (separate channel array as more channels)
* sgp40 gas sensor used to measure air quality
  - New driver including binding and ABI documentation.

Bindings
--------

* Add missing bindings for many DACs where the binding was effectively
  implicit due to fallback probe methods in I2C and SPI.
  adi,ad5064
  adi,ad5360
  adi,ad5380
  adi,ad5421
  adi,ad5449
  adi,ad5504
  adi,ad5624r
  adi,ad5686 / adi,ad5696
  adi,ad5761
  adi,ad5764
  adi,ad5791
  adi,ad8801
  capella,cm3323 (also add explicit of_device_id table)
  microchip,mcp4922
* bosch,bma255
  - Interrupt type in example was opposite of what the device expects.
    It's possible that a particular board had an inverter, but we
    definitely don't want the example to suggest this would be normal.
  - Add interrupt-names to allow for cases where only INT2 is connected.
  - Sort compatibles
  - Merge in very similar bosch,bma180 binding.

New feature
-----------

* Devices only allowed to provide either extended_name or a label for given
  channel. If extend_name is used (generally discouraged but can't be
  removed as it would be a userspaece ABI change), then the label sysfs
  attribute will provide the extended_name. This allows some userspace
  parser simplications and hardening.
* hid-sensors-pres
  - Add a timestamp channel (either from hardware, or locally filled).
* vcnl3020
  - Add periodic sensor mode used to provide IIO events.

Cleanups / minor fixes
----------------------

* core/buffers
  - Avoid unnecessary zeroing of bitmaps that are immediately overwritten.
  - Move a sanity check earlier to simplify error path.
* Quite a few cases of refactors to use devm_* for all of probe and drop
  remove
  - adjd_s311
  - adxl345
  - bma220
  - da280
  - dmard10
  - ds311
  - max5481
  - max5821
  - rfd77402
  - tcs3414
  - tmp006
* ad5624r
  - Fix incorrect handling of a regulator that was preventing use of
    internal regulators.
* adjd_s311
  - Allocate a buffer as part of iio_priv() structure as maximum size
    is small enough, no significant advantage in making it flexible sized.
* bma220
  - Make handling of suspend and resume closer to the probe() wrt to the
    rather odd interface, that suspend mode is entered by reading a register.
* ep93xx
  - Prepare clock before using (part of conversion to CCF)
* fsl-imx25-gcq
  - Use local device pointer.
  - Adjust handling of platform_get_irq() to not check for 0 as an error.
    The function is documented as never returning it.
* hid-sensors
  - Use devm_kmemdup() consistently across all drivers to simplify channel
    structure allocation management.
* meson-saradc
  - Drop BL30 integration on G12A and newer SoCs as not used.
  - Whitespace fixes.
* mpu6050
  - Add per device type startup times. This avoids an issue with having
    to dsicard initial data from gyroscopes when they were still stabilizing.
* rfd77402
  - Change from passing private data, to passing i2c_client where only
    that is needed, reducing back and forth in pm functions.
* si1145
  - Drop pointless continue
* st-sensors
  - Cleanup of includes to remove unused and add missing headers that are used.
  - Use some devm functions to simplify probe() and remove() - gets us part way
    towards a fully device managed driver.
* sx9310
  - Switch from of to generic properties to enable ACPI bindings.
* vcnl3020
  - Add DMA safe buffer for bulk transfers.
  - Drop use of iio_claim_direct() in a driver that has no mode changes.
    A local lock is more appropriate.

----------------------------------------------------------------
Alexander Sverdlin (1):
      iio: ep93xx: Prepare clock before using it

Alexandru Ardelean (19):
      iio: hid-sensors: bind IIO channels alloc to device object
      iio: light: adjd_s311: move buffer on adjd_s311_data object
      iio: light: adjd_s311: convert probe to device-managed functions
      iio: proximity: rfd77402: use i2c_client for rfd77402_{init,powerdown}()
      iio: proximity: rfd77402: convert probe to device-managed functions
      iio: accel: dmard10: convert probe to device-managed functions
      iio: accel: da311: convert probe to device-managed functions
      iio: accel: da280: convert probe to device-managed functions
      iio: accel: bma220: convert probe to device-managed functions
      iio: accel: bma220: make suspend state setting more robust
      iio: temperature: tmp006: convert probe to device-managed
      iio: temperature: tmp006: make sure the chip is powered up in probe
      iio: potentiometer: max5481: convert probe to device-managed
      iio: light: tcs3414: convert probe to device-managed routines
      iio: accel: adxl345: convert probe to device-managed functions
      iio: pressure: st_pressure: use devm_iio_triggered_buffer_setup() for buffer
      iio: accel: st_accel: use devm_iio_triggered_buffer_setup() for buffer
      iio: magn: st_magn: use devm_iio_triggered_buffer_setup() for buffer
      iio: gyro: st_gyro: use devm_iio_triggered_buffer_setup() for buffer

Andreas Klinger (2):
      dt-bindings: iio: chemical: Add trivial DT binding for sgp40
      iio: chemical: Add driver support for sgp40

Baptiste Mansuy (1):
      Add startup time for each chip using inv_mpu6050 driver

Christophe Branchereau (5):
      iio/adc: ingenic: rename has_aux2 to has_aux_md
      dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
      iio/adc: ingenic: add JZ4760 support to the sadc driver
      iio/adc: ingenic: add JZ4760B support to the sadc driver
      dt-bindings: iio/adc: ingenic: add the JZ4760(B) socs to the sadc Documentation

Christophe JAILLET (2):
      iio: buffer: Save a few cycles in 'iio_scan_mask_set()'
      iio: buffer: Move a sanity check at the beginning of 'iio_scan_mask_set()'

Colin Ian King (1):
      iio: light: si1145: remove redundant continue statement

Gwendal Grignou (1):
      iio: sx9310: Support ACPI property

Ivan Mikhaylov (3):
      iio: proximity: vcnl3020: add DMA safe buffer
      iio: proximity: vcnl3020: add periodic mode
      iio: proximity: vcnl3020: remove iio_claim/release_direct

Jarkko Nikula (1):
      counter: intel-qep: Remove linux/bitops.h include

Jonathan Cameron (15):
      dt-bindings: iio: dac: adi,ad5421: Add missing binding document.
      dt-bindings: iio: dac: adi,ad5064: Document bindings for many different DACs
      dt-bindings: iio: dac: adi,ad5360: Add missing binding document
      dt-bindings: iio: dac: ad5380: Add missing binding document
      dt-bindings: iio: dac: ad5449: Add missing binding document.
      dt-bindings: iio: dac: ad5504: Add missing binding document
      iio: dac: ad5624r: Fix incorrect handling of an optional regulator.
      dt-bindings: iio: dac: ad5624r: Add missing binding document
      dt-bindings: iio: dac: ad5686 and ad5696: Add missing binding document.
      dt-bindings: iio: dac: ad5761: Add missing binding doc.
      dt-bindings: iio: dac: adi,ad5764: Add missing binding document
      dt-bindings: iio: dac: adi,ad5791: Add missing bindings document
      dt-bindings: iio: dac: adi,ad8801: Add missing binding document.
      dt-bindings: iio: dac: microchip,mcp4922: Add missing binding document
      iio: st-sensors: Remove some unused includes and add some that should be there

Martin Blumenstingl (3):
      iio: adc: meson-saradc: Disable BL30 integration on G12A and newer SoCs
      iio: adc: meson-saradc: Add missing space between if and parenthesis
      iio: adc: meson-saradc: Fix indentation of arguments after a line-break

Paul Cercueil (2):
      iio: core: Forbid use of both labels and extended names
      iio: core: Support reading extended name as label

Siddharth Manthan (2):
      dt-bindings: Add bindings for Capella cm3323 Ambient Light Sensor
      iio: light: cm3323: Add of_device_id table

Simon Xue (2):
      dt-bindings: iio: adc: rockchip-saradc: add description for rk3568
      iio: adc: rockchip_saradc: add support for rk3568 saradc

Stephan Gerhold (7):
      dt-bindings: iio: accel: bma255: Fix interrupt type
      dt-bindings: iio: accel: bma255: Sort compatibles
      dt-bindings: iio: accel: bma255: Merge bosch,bma180 schema
      dt-bindings: iio: accel: bma255: Add interrupt-names
      dt-bindings: iio: accel: bma255: Add bosch,bmc156_accel
      iio: accel: bmc150: Make it possible to configure INT2 instead of INT1
      iio: accel: bmc150: Add support for BMC156

Tang Bin (2):
      iio: adc: fsl-imx25-gcq: Use the defined variable to clean code
      iio: adc: fsl-imx25-gcq: adjust irq check to match docs and simplify code

Théo Borém Fabris (1):
      iio: dac: max5821: convert device register to device managed function

William Breathitt Gray (6):
      counter: 104-quad-8: Return error when invalid mode during ceiling_write
      counter: Return error code on invalid modes
      counter: Standardize to ERANGE for limit exceeded errors
      counter: Rename counter_signal_value to counter_signal_level
      counter: Rename counter_count_function to counter_function
      counter: 104-quad-8: Describe member 'lock' in 'quad8'

Ye Xiang (1):
      iio: hid-sensor-press: Add timestamp channel

 .../ABI/testing/sysfs-bus-iio-chemical-sgp40       |  31 ++
 .../bindings/iio/accel/bosch,bma180.yaml           |  61 ----
 .../bindings/iio/accel/bosch,bma255.yaml           |  55 ++-
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml   |  19 ++
 .../bindings/iio/adc/rockchip-saradc.yaml          |   1 +
 .../devicetree/bindings/iio/dac/adi,ad5064.yaml    | 268 +++++++++++++++
 .../devicetree/bindings/iio/dac/adi,ad5360.yaml    |  79 +++++
 .../devicetree/bindings/iio/dac/adi,ad5380.yaml    |  70 ++++
 .../devicetree/bindings/iio/dac/adi,ad5421.yaml    |  51 +++
 .../devicetree/bindings/iio/dac/adi,ad5449.yaml    |  97 ++++++
 .../devicetree/bindings/iio/dac/adi,ad5504.yaml    |  50 +++
 .../devicetree/bindings/iio/dac/adi,ad5624r.yaml   |  47 +++
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |  75 ++++
 .../devicetree/bindings/iio/dac/adi,ad5761.yaml    |  60 ++++
 .../devicetree/bindings/iio/dac/adi,ad5764.yaml    |  62 ++++
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |  52 +++
 .../devicetree/bindings/iio/dac/adi,ad8801.yaml    |  60 ++++
 .../bindings/iio/dac/microchip,mcp4922.yaml        |  46 +++
 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 MAINTAINERS                                        |   6 +
 drivers/counter/104-quad-8.c                       |  47 ++-
 drivers/counter/counter.c                          |  50 +--
 drivers/counter/ftm-quaddec.c                      |   5 +-
 drivers/counter/intel-qep.c                        |   7 +-
 drivers/counter/interrupt-cnt.c                    |  11 +-
 drivers/counter/microchip-tcb-capture.c            |  16 +-
 drivers/counter/stm32-lptimer-cnt.c                |  18 +-
 drivers/counter/stm32-timer-cnt.c                  |  10 +-
 drivers/counter/ti-eqep.c                          |  37 +-
 drivers/iio/accel/Kconfig                          |   5 +-
 drivers/iio/accel/adxl345.h                        |   1 -
 drivers/iio/accel/adxl345_core.c                   |  29 +-
 drivers/iio/accel/adxl345_i2c.c                    |   6 -
 drivers/iio/accel/adxl345_spi.c                    |   6 -
 drivers/iio/accel/bma220_spi.c                     |  79 ++---
 drivers/iio/accel/bmc150-accel-core.c              |  78 ++++-
 drivers/iio/accel/bmc150-accel-i2c.c               |  10 +-
 drivers/iio/accel/bmc150-accel-spi.c               |  10 +-
 drivers/iio/accel/bmc150-accel.h                   |  20 +-
 drivers/iio/accel/da280.c                          |  26 +-
 drivers/iio/accel/da311.c                          |  26 +-
 drivers/iio/accel/dmard10.c                        |  27 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |  10 +-
 drivers/iio/accel/st_accel.h                       |   4 -
 drivers/iio/accel/st_accel_buffer.c                |  16 +-
 drivers/iio/accel/st_accel_core.c                  |  14 +-
 drivers/iio/accel/st_accel_i2c.c                   |   3 +-
 drivers/iio/accel/st_accel_spi.c                   |   2 +-
 drivers/iio/adc/ep93xx_adc.c                       |   6 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |  17 +-
 drivers/iio/adc/ingenic-adc.c                      | 102 +++++-
 drivers/iio/adc/meson_saradc.c                     |  20 +-
 drivers/iio/adc/rockchip_saradc.c                  |  22 +-
 drivers/iio/chemical/Kconfig                       |  11 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/sgp40.c                       | 378 +++++++++++++++++++++
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |   2 -
 drivers/iio/common/st_sensors/st_sensors_core.c    |   1 +
 drivers/iio/common/st_sensors/st_sensors_core.h    |   1 +
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |   3 +-
 drivers/iio/common/st_sensors/st_sensors_spi.c     |   3 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |   1 -
 drivers/iio/dac/ad5624r_spi.c                      |  18 +-
 drivers/iio/dac/max5821.c                          |  41 +--
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |  11 +-
 drivers/iio/gyro/st_gyro.h                         |   4 -
 drivers/iio/gyro/st_gyro_buffer.c                  |  16 +-
 drivers/iio/gyro/st_gyro_core.c                    |  15 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |   2 +-
 drivers/iio/gyro/st_gyro_spi.c                     |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  22 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  18 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  15 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |   1 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |   3 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |   3 +-
 drivers/iio/industrialio-buffer.c                  |   9 +-
 drivers/iio/industrialio-core.c                    |  33 +-
 drivers/iio/light/adjd_s311.c                      |  53 +--
 drivers/iio/light/cm3323.c                         |   7 +
 drivers/iio/light/hid-sensor-als.c                 |  11 +-
 drivers/iio/light/hid-sensor-prox.c                |  11 +-
 drivers/iio/light/si1145.c                         |   1 -
 drivers/iio/light/tcs3414.c                        |  48 ++-
 drivers/iio/magnetometer/st_magn.h                 |  12 -
 drivers/iio/magnetometer/st_magn_buffer.c          |  16 +-
 drivers/iio/magnetometer/st_magn_core.c            |  17 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |   2 +-
 drivers/iio/magnetometer/st_magn_spi.c             |   2 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |  11 +-
 drivers/iio/potentiometer/max5481.c                |  22 +-
 drivers/iio/pressure/hid-sensor-press.c            |  51 +--
 drivers/iio/pressure/st_pressure.h                 |   5 -
 drivers/iio/pressure/st_pressure_buffer.c          |  16 +-
 drivers/iio/pressure/st_pressure_core.c            |  16 +-
 drivers/iio/pressure/st_pressure_i2c.c             |   3 +-
 drivers/iio/pressure/st_pressure_spi.c             |   2 +-
 drivers/iio/proximity/rfd77402.c                   |  83 ++---
 drivers/iio/proximity/sx9310.c                     |  48 +--
 drivers/iio/proximity/vcnl3020.c                   | 351 ++++++++++++++++++-
 drivers/iio/temperature/tmp006.c                   |  53 +--
 include/dt-bindings/iio/adc/ingenic,adc.h          |   1 +
 include/linux/counter.h                            |  32 +-
 103 files changed, 2613 insertions(+), 809 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5064.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5360.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5380.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5421.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5449.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5624r.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5761.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5764.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8801.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
 create mode 100644 drivers/iio/chemical/sgp40.c
