Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708003000DD
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 11:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbhAVJ1K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 04:27:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbhAVJKN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Jan 2021 04:10:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E850D239EE;
        Fri, 22 Jan 2021 09:09:29 +0000 (UTC)
Date:   Fri, 22 Jan 2021 09:09:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of new IIO device support, features and cleanups for
 the 5.12 cycle
Message-ID: <20210122090927.2fd2e3c1@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit d61adf609c48b9e91a84e9a943f0b3bcd84c3cad:

  staging: unisys: visorhba: enhance visorhba to use channel_interrupt (2021-01-07 16:57:50 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.12a

for you to fetch changes up to 1994a922eb6a7fc577b9c9b909e0fe1fefd961fa:

  Merge branch 'ib-iio-thermal-5.11-rc1' into togreg (2021-01-22 08:52:26 +0000)

----------------------------------------------------------------
First set of IIO new device support, cleanups etc for 5.12

Includes one immutable branch, to support some qcom-vadc patches
going through IIO and thermal.

Late rebase to drop a patch that should go through the hid tree.

New device support:
* adi,ad5766
  - New driver supporting AD5766 and AD5767 16 channel DACs.
* adi,ad7476
  - Support for LTC2314-14 14 bit ADC (trivial to add)
* hid-sensors-hinge
  - New driver including HID custom sensor support.
* invensense,mpu6050
  - Add support for the MPU-6880 (chip info all that is needed)
* memsic,ms5637
  - Add support for ms5803 device after a bunch of rework.
* xilinx-xadc
  - Add support for Ultrascale System Monitor.
* yamaha,yas530
  - New driver for this magnetometer supporting YAS530, YAS532 adn YAS 533.

Dt-binding conversions to yaml
* invensense,mpu3050
* invensense,mpu6050

Cleanups and minor features
* core
  - Copy iio_info.attrs->is_visible along with the attrs themselves.
  - Handle enumerate properties with gaps (i.e. reserved values in
    the middle of otherwise used values).
  - Add an of_iio_channel_get_by_name() function.
* adi,adf4350
  - Drop an unnecessary NULL check.
* amstaos,tsl2583
  - Use DIV_ROUND_CLOSEST in place of open coding.
* avago,apds9960
  - Add MSHW0184 ACPI id seen in the Microsoft Surface Book 3 and Surface
    Pro 7.
* bosch,bmc150_magn
  - Basic regulator support.
* bosch,bme680
  - Use DIV_ROUND_CLOSEST in place of opencoding.
* bosch,bmg160
  - Basic regulator support.
* hid-sensors
  - Add timestamp channels to all sensors types.
* kionix,kxcjk1013
  - Basic regulator support.
* memsic
  - Fix ordering in trivial-device.yaml
* microchip,mcp4725
  - More flexible restrictions in DT binding.
* plantower,pms7003
  - Fix comma that should be semicolon.
* qcom-vadc
  - Refactors to support addition of ADC-TM5 driver
  - Addition of a fixp_linear_interpolate function to support this common
    operation.
* sprd,sc27xx_adc
  - Use DIV_ROUND_CLOSEST in place of opencoding.
* st,ab8500-adc
  - Enable non-hw-conversion as AB505 doesn't support it.
* st,stm32-adc
  - Drop unneeded NULL check.
* st,stm32-dfsdm
  - Drop unneeded NULL check.
* st,vl6180
  - Use DIV_ROUND_CLOSEST in place of opencoding.
* xilinx-xadc
  - Local var for &pdev->dev to avoid excessive repetition.
  - devm_ throughout and drop remove()

----------------------------------------------------------------
Alexandre Belloni (6):
      dt-bindings: trivial-devices: reorder memsic devices
      iio:pressure:ms5637: introduce hardware differentiation
      iio:pressure:ms5637: limit available sample frequencies
      iio:common:ms_sensors:ms_sensors_i2c: rework CRC calculation helper
      iio:common:ms_sensors:ms_sensors_i2c: add support for alternative PROM layout
      iio:pressure:ms5637: add ms5803 support

Bartosz Golaszewski (3):
      iio: adc: xilinx: use helper variable for &pdev->dev
      iio: adc: xilinx: use devm_krealloc() instead of kfree() + kcalloc()
      iio: adc: xilinx: use more devres helpers and remove remove()

Craig Tatlor (1):
      fixp-arith: add a linear interpolation function

Cristian Pop (3):
      dt-bindings: iio: dac: AD5766 yaml documentation
      Documentation/ABI/testing: Add documentation for AD5766 new ABI
      iio: dac: ad5766: add driver support for AD5766

Devajith V S (2):
      dt-bindings: iio: accel: kxcjk1013: Document regulator supplies
      iio: accel: kxcjk1013: Add rudimentary regulator support

Dmitry Baryshkov (9):
      iio: adc: qcom-vadc: move several adc5 functions to common file
      iio: adc: qcom-vadc-common: use fixp_linear_interpolate
      iio: adc: move qcom-vadc-common.h to include dir
      iio: adc: qcom-spmi-adc5: use of_device_get_match_data
      iio: provide of_iio_channel_get_by_name() and devm_ version it
      iio: adc: move vadc_map_pt from header to the source file
      iio: adc: qcom-vadc-common: rewrite vadc7 die temp calculation
      iio: adc: qcom-vadc-common: simplify qcom_vadc_map_voltage_temp
      iio: adc: qcom-vadc-common: scale adcmap_100k_104ef_104fb

Dragos Bogdan (1):
      iio: adc: ad7476: Add LTC2314-14 support

Hans de Goede (1):
      iio: core: Copy iio_info.attrs->is_visible into iio_dev_opaque.chan_attr_group.is_visible

Jonathan Cameron (3):
      dt-bindings:iio:imu:invensense,mpu6050: txt to yaml conversion
      dt-bindings:iio:gyro:invensense,mpu3050: txt to yaml format conversion.
      Merge branch 'ib-iio-thermal-5.11-rc1' into togreg

Lars-Peter Clausen (7):
      dt-bindings:iio:xilinx-xadc: Add Xilinx System Management Wizard binding docs
      iio: xilinx-xadc: Add basic support for Ultrascale System Monitor
      iio: vl6180: Use DIV_ROUND_CLOSEST() instead of open-coding it
      iio: bme680: Use DIV_ROUND_CLOSEST() instead of open-coding it
      iio: tsl2583: Use DIV_ROUND_CLOSEST() instead of open-coding it
      iio: sc27xx_adc: Use DIV_ROUND_CLOSEST() instead of open-coding it
      iio: Handle enumerated properties with gaps

Linus Walleij (3):
      iio: accel: yamaha-yas530: Add DT bindings
      iio: magnetometer: Add driver for Yamaha YAS530
      iio: adc: ab8500-gpadc: Support non-hw-conversion

Max Leiter (1):
      iio:light:apds9960 add detection for MSHW0184 ACPI device in apds9960 driver

Stephan Gerhold (6):
      dt-bindings: iio: imu: mpu6050: Document invensense,mpu6880
      iio: imu: inv_mpu6050: Add support for MPU-6880
      dt-bindings: iio: gyroscope: bmg160: Document regulator supplies
      iio: gyro: bmg160: Add rudimentary regulator support
      dt-bindings: iio: magnetometer: bmc150: Document regulator supplies
      iio: magnetometer: bmc150: Add rudimentary regulator support

Tomas Novotny (1):
      dt-bindings:iio:dac:microchip,mcp4725: fix properties for mcp4726

Xu Wang (3):
      iio: frequency: adf4350: Remove redundant null check before clk_disable_unprepare
      iio: adc: stm32-adc: Remove redundant null check before clk_prepare_enable/clk_disable_unprepare
      iio: adc: stm32-dfsdm: Remove redundant null check before clk_disable_unprepare

Ye Xiang (9):
      HID: hid-sensor-custom: Add custom sensor iio support
      iio: hid-sensors: Add hinge sensor driver
      iio:Documentation: Add documentation for hinge sensor channels
      iio: hid-sensor-accel-3d: Add timestamp channel for gravity sensor
      iio: hid-sensor-gyro-3d: Add timestamp channel
      iio: hid-sensor-als: Add timestamp channel
      iio: hid-sensor-magn-3d: Add timestamp channel
      iio: hid-sensor-incl-3d: Add timestamp channel
      iio: hid-sensor-rotation: Add timestamp channel

Zheng Yongjun (1):
      iio: chemical: pms7003: convert comma to semicolon

 Documentation/ABI/testing/sysfs-bus-iio            |   11 +
 Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766 |   31 +
 .../bindings/iio/accel/kionix,kxcjk1013.yaml       |    3 +
 .../devicetree/bindings/iio/adc/xilinx-xadc.txt    |   49 +-
 .../devicetree/bindings/iio/dac/adi,ad5766.yaml    |   63 ++
 .../bindings/iio/dac/microchip,mcp4725.yaml        |   31 +-
 .../bindings/iio/gyroscope/bosch,bmg160.yaml       |    3 +
 .../bindings/iio/gyroscope/invensense,mpu3050.txt  |   45 -
 .../bindings/iio/gyroscope/invensense,mpu3050.yaml |   70 ++
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   67 --
 .../bindings/iio/imu/invensense,mpu6050.yaml       |  104 ++
 .../iio/magnetometer/bosch,bmc150_magn.yaml        |    3 +
 .../bindings/iio/magnetometer/yamaha,yas530.yaml   |  112 +++
 .../devicetree/bindings/trivial-devices.yaml       |   10 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 drivers/hid/hid-sensor-custom.c                    |  143 +++
 drivers/iio/accel/hid-sensor-accel-3d.c            |    6 +-
 drivers/iio/accel/kxcjk-1013.c                     |   32 +
 drivers/iio/adc/Kconfig                            |   11 +-
 drivers/iio/adc/ab8500-gpadc.c                     |   30 +-
 drivers/iio/adc/ad7476.c                           |    6 +
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    3 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |   95 +-
 drivers/iio/adc/qcom-spmi-vadc.c                   |    3 +-
 drivers/iio/adc/qcom-vadc-common.c                 |  229 +++--
 drivers/iio/adc/sc27xx_adc.c                       |    2 +-
 drivers/iio/adc/stm32-adc-core.c                   |   29 +-
 drivers/iio/adc/stm32-adc.c                        |   14 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |    3 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |  364 ++++---
 drivers/iio/adc/xilinx-xadc-events.c               |    9 +-
 drivers/iio/adc/xilinx-xadc.h                      |    6 +
 drivers/iio/chemical/bme680_core.c                 |    2 +-
 drivers/iio/chemical/pms7003.c                     |    2 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c |    2 +
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   76 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.h     |   15 +-
 drivers/iio/dac/Kconfig                            |   10 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5766.c                           |  643 ++++++++++++
 drivers/iio/frequency/adf4350.c                    |    6 +-
 drivers/iio/gyro/bmg160_core.c                     |   25 +
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   40 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |    8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    9 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    5 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    5 +
 drivers/iio/industrialio-core.c                    |   44 +-
 drivers/iio/inkern.c                               |   34 +-
 drivers/iio/light/apds9960.c                       |    8 +
 drivers/iio/light/hid-sensor-als.c                 |   39 +-
 drivers/iio/light/tsl2583.c                        |    8 +-
 drivers/iio/light/vl6180.c                         |    2 +-
 drivers/iio/magnetometer/Kconfig                   |   15 +
 drivers/iio/magnetometer/Makefile                  |    2 +
 drivers/iio/magnetometer/bmc150_magn.c             |   26 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   48 +-
 drivers/iio/magnetometer/yamaha-yas530.c           | 1049 ++++++++++++++++++++
 drivers/iio/orientation/hid-sensor-incl-3d.c       |   43 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |   46 +-
 drivers/iio/position/Kconfig                       |   16 +
 drivers/iio/position/Makefile                      |    1 +
 .../iio/position/hid-sensor-custom-intel-hinge.c   |  385 +++++++
 drivers/iio/pressure/ms5637.c                      |   77 +-
 include/linux/fixp-arith.h                         |   19 +
 include/linux/hid-sensor-ids.h                     |   14 +
 .../linux}/iio/adc/qcom-vadc-common.h              |   28 +-
 include/linux/iio/consumer.h                       |   36 +
 69 files changed, 3714 insertions(+), 666 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
 create mode 100644 drivers/iio/dac/ad5766.c
 create mode 100644 drivers/iio/magnetometer/yamaha-yas530.c
 create mode 100644 drivers/iio/position/hid-sensor-custom-intel-hinge.c
 rename {drivers => include/linux}/iio/adc/qcom-vadc-common.h (92%)
