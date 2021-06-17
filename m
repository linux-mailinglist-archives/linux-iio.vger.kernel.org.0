Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665D83AB603
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jun 2021 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhFQObi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Jun 2021 10:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232366AbhFQObi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Jun 2021 10:31:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 517B4613CB;
        Thu, 17 Jun 2021 14:29:28 +0000 (UTC)
Date:   Thu, 17 Jun 2021 15:31:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO and Counter features, cleanups etc for the
 5.14 cycle.
Message-ID: <20210617153132.495691a1@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 6771fb0b940eb74f1a68fe3f180a7668103397d3:

  Merge tag 'iio-for-5.14a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2021-06-09 12:11:49 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.14b

for you to fetch changes up to 7cd04c863f9e1655d607705455e7714f24451984:

  iio: light: tcs3472: do not free unallocated IRQ (2021-06-16 14:57:03 +0100)

----------------------------------------------------------------
Second set of Counter and IIO new device support, cleanups etc for 5.14

Counter
------

First part of general rework of counter subsystem to add a chrdev interface
for event drive data capture.  Most of it will hopefully land next cycle.

* Consolidate documentation to avoid multiple copies of same docs in per
  device files.
* Constify various arrays etc across subsystem.
* 104-quad-8:
  - Annotate the module config parameter to avoid using it when kernel is
    locked down.
  - Spelling and trivial comment drops etc
* Intel QEP
  - Follow up cleanups of trivial stuff from initial patch series.

IIO
---

Includes some cleanups as part of two ongoing audits
- runtime pm usage in IIO.
- Insufficient alignment on buffers passed to
iio_push_to_buffers_with_timstamp()

New device support
* bosch,bmc150
  - Add ID for BMA253

Minor features / cleanups / minor fixes / late breaking fixes
* iio_push_to_buffers_with_timestamp() alignment fixes.
  This set includes those where the best option is to mark the buffer as
  __aligned(8). Normally this choice was made because there is too high a degree
  of possible variation in number of channels enabled to be able to guarantee
  the timestamp was always in the same location.  This ruled out the more
  obvious structure form used in other drivers. Only one small class of
  related issues have patches under review and we can finally tighten up the
  explicit rules to reflect the hidden requirement.

* dummy
  - Kconfig build dependency fix.
* adi,ad_sigma_delta
  - General devm related simplifications for these devices.
* adi,adf4350
  - Fix some missing cleanup on error path.
* adi,adis, ADC drivers.
  - Clean out unneeded spi_set_drvdata()
* ams-taos,tcs3472
  - Fix a potential free of an irq that was never allocated.
* atlas,sensor
  - Drop unbalanced runtime pm call and use pm_runtime_resume_and_get()
    to reduce boilerplate.
* bosch,bma180
  - Fix bandwidth register values used.
* bosch,bmc150
  - Fix wrong pointer being dereferenced in remove.
  - Stop device trying unregister itself rather than the second device.
  - Refactor ACPI second device handing.
  - Add support for DUAL250E ACPI HID.
  - Move some stuff into the header to enable following patches to not
    add additional accessor functions. Drop existing accessors.
  - Add support for hinge angle setting with DUAL250E ACPI DSM to ensure
    keyboard and touchpad enabled correctly when in laptop mode and disabled
    otherwise.
  - Add label attr for the multiple sensor locations with DUAL250E ACPI HID.
  - Fix scale units for bma222
  - Various reordering of devices supported lists to be alphabetical order.
  - Drop unnecessary duplicated chip_info_tbl[] entries.
  - Document that some devices have two interrupts, even if not currently
    used by the driver.
  - Move bma254 over to the bma255 driver.
  - Move to more consistent scale values, based on assumption that some
    datasheets use lower precision in their calculations in comparison
    with others.
* hid-sensors
  - Use namespaces for exported symbols.
  - Update includes using manual inspection of output of the
    include-what-you-use tool.
* invensense,icp10100
  - Drop unbalanced runtime pm put. Use pm_runtime_resume_and_get() to cleanly
    handle potential error.
* invensense,mpu6050
  - Drop use of %hhx string formatting.
  - runtime pm boilerplate removal and drop an unbalanced call in remove.
* liteon,ltr501
  - Fix inaccurate volatile register list.
  - Fix wrong mode bit.
  - Add a missing leXX_to_cpu() conversion.
  - Mark ltr501_chip_info structure as const.
* pulsed-light-lidar:
  - Boilerplate removal using runtime_pm_resume_and_get()
* scmi-sensors
  - Formatting of SPDX fix.
* silabs,si1133
  - Fix a string format warning.
  - Drop remaining uses of %hhx string formatting.
* silabs,si1145
  - Drop use of %hhx string formatting.
* ti,ads1015
  - Drop unbalanced runtime pm call in remove and reduce boilerplate.

----------------------------------------------------------------
Alexandru Ardelean (9):
      iio: adc: ad_sigma_delta: introduct devm_ad_sd_setup_buffer_and_trigger()
      iio: adc: ad7793: convert to device-managed functions
      iio: adc: ad7791: convert to device-managed functions
      iio: adc: ad7780: convert to device-managed functions
      iio: adc: ad7192: use devm_clk_get_optional() for mclk
      iio: adc: ad7192: convert to device-managed functions
      iio: adc: ad_sigma_delta: remove ad_sd_{setup,cleanup}_buffer_and_trigger()
      iio: imu: remove unused private data assigned with spi_set_drvdata()
      iio: adc: remove unused private data assigned with spi_set_drvdata()

Andy Shevchenko (1):
      iio: hid-sensors: lighten exported symbols by moving to IIO_HID namespace

Arnd Bergmann (1):
      iio: si1133: fix format string warnings

Hans de Goede (9):
      iio: accel: bmc150: Fix dereferencing the wrong pointer in bmc150_get/set_second_device
      iio: accel: bmc150: Don't make the remove function of the second accelerometer unregister itself
      iio: accel: bmc150: Move check for second ACPI device into a separate function
      iio: accel: bmc150: Add support for dual-accelerometers with a DUAL250E HID
      iio: accel: bmc150: Move struct bmc150_accel_data definition to bmc150-accel.h
      iio: accel: bmc150: Remove bmc150_set/get_second_device() accessor functions
      iio: accel: bmc150: Add support for DUAL250E ACPI DSM for setting the hinge angle
      iio: accel: bmc150: Refactor bmc150_apply_acpi_orientation()
      iio: accel: bmc150: Set label based on accel-location for ACPI DUAL250E fwnodes

Jarkko Nikula (2):
      counter: intel-qep: Mark PM callbacks with __maybe_unused
      counter: intel-qep: Use to_pci_dev() helper

Jonathan Cameron (18):
      iio: light: si1133: Drop remaining uses of %hhx format string.
      iio: imu: inv_mpu6050: Drop use of %hhx format string.
      iio: light: si1145: Drop use of %hhx format specifier.
      iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop remove()
      iio: adc: at91-sama5d2: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: hx711: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: mxs-lradc: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: adc: ti-ads8688: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: magn: rm3100: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
      iio: light: vcnl4000: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: light: vcnl4035: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: prox: isl29501: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
      iio: imu: mpu6050: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: adc: ads1015: Balance runtime pm + pm_runtime_resume_and_get()
      iio: chemical: atlas-sensor: Balance runtime pm + pm_runtime_resume_and_get()
      iio: prox: pulsed-light-v2: Use pm_runtime_resume_and_get()
      iio: pressure: icp10100: Balance runtime pm + use pm_runtime_resume_and_get()
      iio: hid-sensors: Update header includes

Marc Kleine-Budde (2):
      iio: ltr501: mark register holding upper 8 bits of ALS_DATA{0,1} and PS_DATA as volatile, too
      iio: ltr501: mark ltr501_chip_info as const

Oliver Lang (2):
      iio: ltr501: ltr559: fix initialization of LTR501_ALS_CONTR
      iio: ltr501: ltr501_read_ps(): add missing endianness conversion

Stephan Gerhold (12):
      iio: accel: bma180: Fix BMA25x bandwidth register values
      iio: accel: bmc150: Fix bma222 scale unit
      iio: accel: bmc150: Clarify combo modules in Kconfig
      iio: accel: bmc150: Drop misleading/duplicate chip identifiers
      iio: accel: bmc150: Drop duplicated documentation of supported chips
      iio: accel: bmc150: Sort all chip names alphabetically / by chip ID
      dt-bindings: iio: accel: bma255: Document bosch,bma253
      iio: accel: bmc150: Add device IDs for BMA253
      dt-bindings: iio: bma255: Allow multiple interrupts
      dt-bindings: iio: accel: bma180/bma255: Move bma254 to bma255 schema
      iio: accel: bma180/bmc150: Move BMA254 to bmc150-accel driver
      iio: accel: bmc150: Use more consistent and accurate scale values

Tom Rix (1):
      iio: scmi: fix spelling of SPDX tag

Wei Yongjun (1):
      iio: dummy: Fix build error when CONFIG_IIO_TRIGGERED_BUFFER is not set

William Breathitt Gray (16):
      docs: counter: Consolidate Counter sysfs attributes documentation
      docs: counter: Fix spelling
      counter: 104-quad-8: Remove pointless comment
      counter: 104-quad-8: Annotate hardware config module parameter
      counter: 104-quad-8: Add const qualifiers for quad8_preset_register_set
      counter: 104-quad-8: Add const qualifier for functions_list array
      counter: interrupt-cnt: Add const qualifier for functions_list array
      counter: microchip-tcb-capture: Add const qualifier for functions_list array
      counter: stm32-lptimer-cnt: Add const qualifier for functions_list array
      counter: stm32-timer-cnt: Add const qualifier for functions_list array
      counter: 104-quad-8: Add const qualifier for actions_list array
      counter: ftm-quaddec: Add const qualifier for actions_list array
      counter: microchip-tcb-capture: Add const qualifier for actions_list array
      counter: stm32-lptimer-cnt: Add const qualifier for actions_list array
      counter: stm32-timer-cnt: Add const qualifier for actions_list array
      counter: interrupt-cnt: Add const qualifier for actions_list array

Yang Yingliang (1):
      iio: frequency: adf4350: disable reg and clk on error in adf4350_probe()

frank zago (1):
      iio: light: tcs3472: do not free unallocated IRQ

 Documentation/ABI/testing/sysfs-bus-counter        |  76 ++++++-
 .../ABI/testing/sysfs-bus-counter-104-quad-8       |  61 -----
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec      |  16 --
 .../bindings/iio/accel/bosch,bma180.yaml           |   3 +-
 .../bindings/iio/accel/bosch,bma255.yaml           |   9 +-
 Documentation/driver-api/generic-counter.rst       |   2 +-
 MAINTAINERS                                        |   4 +-
 drivers/counter/104-quad-8.c                       |  13 +-
 drivers/counter/ftm-quaddec.c                      |   2 +-
 drivers/counter/intel-qep.c                        |  10 +-
 drivers/counter/interrupt-cnt.c                    |   8 +-
 drivers/counter/microchip-tcb-capture.c            |   4 +-
 drivers/counter/stm32-lptimer-cnt.c                |   4 +-
 drivers/counter/stm32-timer-cnt.c                  |   4 +-
 drivers/iio/accel/Kconfig                          |  11 +-
 drivers/iio/accel/bma180.c                         |  97 ++------
 drivers/iio/accel/bmc150-accel-core.c              | 221 +++++++------------
 drivers/iio/accel/bmc150-accel-i2c.c               | 245 ++++++++++++++++-----
 drivers/iio/accel/bmc150-accel-spi.c               |  31 +--
 drivers/iio/accel/bmc150-accel.h                   |  72 +++++-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   6 +-
 drivers/iio/adc/ad7124.c                           |  48 ++--
 drivers/iio/adc/ad7192.c                           |  93 ++++----
 drivers/iio/adc/ad7476.c                           |   2 -
 drivers/iio/adc/ad7766.c                           |   2 -
 drivers/iio/adc/ad7768-1.c                         |   1 -
 drivers/iio/adc/ad7780.c                           |  38 +---
 drivers/iio/adc/ad7791.c                           |  44 ++--
 drivers/iio/adc/ad7793.c                           |  53 ++---
 drivers/iio/adc/ad7887.c                           |   1 -
 drivers/iio/adc/ad9467.c                           |   2 -
 drivers/iio/adc/ad_sigma_delta.c                   |  82 +++----
 drivers/iio/adc/at91-sama5d2_adc.c                 |   3 +-
 drivers/iio/adc/hi8435.c                           |   1 -
 drivers/iio/adc/hx711.c                            |   4 +-
 drivers/iio/adc/max1027.c                          |   2 -
 drivers/iio/adc/max1241.c                          |   2 -
 drivers/iio/adc/mxs-lradc-adc.c                    |   3 +-
 drivers/iio/adc/ti-adc084s021.c                    |   3 -
 drivers/iio/adc/ti-ads1015.c                       |   5 +-
 drivers/iio/adc/ti-ads124s08.c                     |   2 -
 drivers/iio/adc/ti-ads8688.c                       |   3 +-
 drivers/iio/adc/ti-tsc2046.c                       |   2 -
 drivers/iio/chemical/atlas-sensor.c                |  13 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  32 ++-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  14 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |   3 +
 drivers/iio/common/scmi_sensors/Makefile           |   2 +-
 drivers/iio/dummy/Kconfig                          |   1 +
 drivers/iio/frequency/adf4350.c                    |   6 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   6 +-
 drivers/iio/humidity/hid-sensor-humidity.c         |   2 +
 drivers/iio/imu/adis16400.c                        |   2 -
 drivers/iio/imu/adis16460.c                        |   2 -
 drivers/iio/imu/adis16475.c                        |   1 -
 drivers/iio/imu/adis16480.c                        |   2 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  24 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   6 +-
 drivers/iio/light/hid-sensor-als.c                 |   6 +-
 drivers/iio/light/hid-sensor-prox.c                |   6 +-
 drivers/iio/light/ltr501.c                         |  25 ++-
 drivers/iio/light/si1133.c                         |  18 +-
 drivers/iio/light/si1145.c                         |  10 +-
 drivers/iio/light/tcs3472.c                        |   6 +-
 drivers/iio/light/vcnl4000.c                       |   2 +-
 drivers/iio/light/vcnl4035.c                       |   3 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   7 +-
 drivers/iio/magnetometer/rm3100-core.c             |   3 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |   6 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |   5 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |   3 +
 drivers/iio/pressure/hid-sensor-press.c            |   6 +-
 drivers/iio/pressure/icp10100.c                    |   5 +-
 drivers/iio/proximity/isl29501.c                   |   2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   4 +-
 drivers/iio/temperature/hid-sensor-temperature.c   |   2 +
 drivers/rtc/rtc-hid-sensor-time.c                  |   1 +
 include/linux/iio/adc/ad_sigma_delta.h             |   4 +-
 78 files changed, 713 insertions(+), 822 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
