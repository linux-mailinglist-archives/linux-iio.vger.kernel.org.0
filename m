Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF3E130808
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2020 13:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgAEMuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jan 2020 07:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgAEMuD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jan 2020 07:50:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 897C7207FD;
        Sun,  5 Jan 2020 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578228601;
        bh=O1UGEn/YdKHldywL1vkqHSMq3qAdEN6IN+nJme5bnGU=;
        h=Date:From:To:Subject:From;
        b=rP2PKNtI8Hv6lvvShyT1aKzueukrF60jfTOm/h8tfVBKo7Kjvd5w83ukK0KmphOuZ
         4E33cdRkgzzT4iWP8G9C9/nfaYy999zWOkoonyMhzZEDgI9FRzPil49tH4CcAlO5tN
         wdfRwAjFjef4i1KIQBUcgqYexQ25LD4ZRcLpE0YU=
Date:   Sun, 5 Jan 2020 12:49:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO new device support, features and cleanups
 for the 5.6 cycle
Message-ID: <20200105124957.7acd54b5@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 2611045e3555cd0d75837ae69ffd70ef51e28bf7:

  staging: vchiq: Refactor indentation in vchiq_platform_conn_state_changed=
() (2019-11-15 14:14:55 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.6a

for you to fetch changes up to c1d1c4a62db5c4745b9e15cfee0daf0f774f73fc:

  iio: accel: bma180: BMA254 support (2019-12-30 16:29:09 +0000)

----------------------------------------------------------------
First set of new device support, features and cleanups for IIO in the 5.6 c=
ycle

New device support

* ad7091r5 ADC
  - New driver with follow up patch adding scale and vref support.
  - DT bindings
* ad7923
  - Support for ad7908, ad7918 and ad7928 added to driver.
* bma180
  - Support the BMA254 accelerometer. Required fairly substantial rework
    to allow for small differences between this an existing parts.
* bma400 accelerometer
  - New driver with follow up patch for regulator support.
  - DT bindings.
* asc dlhl60d
  - New driver support this range of pressure and temperature sensors.
  - DT bindings.
* ltc2496 ADC
  - New driver to support this ADC.
  - Split the existing LTC2497 driver generic component out and reuse.
  - DT bindings.
* parallax ping
  - New driver supporting ultrasonic and laser tof distance sensors.
  - Bindings for these sensors.

New features

* core
  - New char type for read_raw returns, used for thermocouple types.
  - Rename read_first_n callback to read.   The reasons behind the original
    naming are lost to the mists of time.
* ad799x
  - Allow pm_ops to disable device completely allowing regulator power down.
* bma180
  - Enable basic regulator support.
* dmaengine buffer
  - Report platform data alignment requirements via new ABI.
* max31856
  - Add option to set mains filter rejection frequency and document
    new in_temp_filter_notch_center_frequency ABI.
  - Add support for configuring HW averaging (oversampling ratio)
  - Add runtime configuration of thermocouple type and document new ABI.
* maxim-thermocouple
  - Add read only access to thermocouple type using new ABI, includes
    adding more specific compatibles to reflect which variant of the
    chip is being used.
* mpu6050
  - Provide option to support the PMU9150 in package magnetometer directly
    rather than via auxiliary bus.
* stm32_adc
  - Add overrun interrupt checks to detect if this happens.
* st_lsm6dsx
  - Enable the sensor-hub support for lsm6dsm. Includes various reworks to
    allow this.

Cleanups and minor fixes

* Subsystem wide
  - Tidy up indentation in Kconfig and fix alphabetical order of AD7091R5.
  - Drop linux/gpio.h and linux/of_gpio.h from drivers that don't use them.
* ad7266
  - Convert to GPIO descriptors.
* ad7303
  - Avoid a dance with checking if the regulator is supplied by just
    using the optional request interface.
* ad7887
  - Simplify channel specification assignment to enable adding more devices.
* ad7923
  - Drop some unused and largely pointless defines of BOB_N=3D=3DN variety.
  - Tidy up checkpatch warnings.
  - Add missing of_device_id table.
* adf4350
  - Convert to GPIO descriptors.
* ak8975
  - Convert to GPIO descriptors.
* ADIS library and drivers
  - Expand scope of txrx_lock to cover all state and rename as state_lock
  - Add unlocked read / write to allow grouping of consecutive calls under
    single lock / unlock.
  - Add unlocked check_status, reset to allow grouping under single
    lock / unlock.
  - Remove remaining uses of core mlock for local state protection.
    mlock should never be used directly as it protects tightly defined
    core IIO device management state.
* adis16240
  - Enforce only supported SPI mode on driver load + add DT binding doc.
* atlas-ph-sensor
  - Rename to atlas-sensor given it now covers things beyond ph sensors.
* bma180
  - Use local dev variable to tidy up code.
  - Use c99 style explicity .member assignment to make driver more readable.
* bmp280
  - Drop ACPI support. No evidence this was used and appropriate ID is not
    registered.
  - Allow ACPI to bind device via PRP0001
* dmaengine buffer
  - Use dma_request_chan instead of dma_request_slave_channel_reason as that
    ABI is going away.
  - Add module info to avoid tainting the kernel.
* hts221
  - Avoid magic number defines when only used to fill structure elements
    that are self describing.
* lm3533
  - Drop a stray semicolon.
* max9611
  - Cleanup enum handling to be more resilient to future changes.
* mpu6050
  - Delete MPU9150 from supported SPI devices as doesn't provide SPI.
  - Select I2C_MUX again after kbuild issue fixed elsewhere.
* stm32-timer
  - Drop an unnecessary register update.
* ssp_sensors
  - Convert to GPIO descriptors.
* st_sensors
  - drop !CONFIG_ACPI defines as ACPI_PTR() will stop them being used
    anyway.
  - Make default platform data structures __maybe_unsued.
  - Fill in some missing kernel-doc function parameters.
* st_lsm6dsx
  - white space fixes.
  - Mark some constants that aren't always used as __maybe_unused.
  - Drop of ID table guards as they just pervent use under ACPI.
  - Switch to device properties to allow ACPI usage.
* st_uvis25
  - Drop acpi.h include as no ACPI APIs used.
* ti-ads1015
  - Drop legacy platform data as no one seems to be using it.
  - Use the device property API instead of OF specific.
* ti-ads7950
  - typo fix in error message.

----------------------------------------------------------------
Alexandru Ardelean (11):
      iio: imu: adis: rename txrx_lock -> state_lock
      iio: imu: adis: add unlocked read/write function versions
      iio: imu: adis[16480]: group RW into a single lock in adis_enable_irq=
()
      iio: imu: adis: create an unlocked version of adis_check_status()
      iio: imu: adis: create an unlocked version of adis_reset()
      iio: imu: adis: protect initial startup routine with state lock
      iio: imu: adis: group single conversion under a single state lock
      iio: imu: adis16400: rework locks using ADIS library's state lock
      iio: gyro: adis16136: rework locks using ADIS library's state lock
      iio: imu: adis16480: use state lock for filter freq set
      iio: gyro: adis16260: replace mlock with ADIS lib's state_lock

Alexandru Tachici (1):
      iio: dac: ad7303: use regulator get optional to check for ext supply

Andrea Merello (9):
      iio: max31856: add option for setting mains filter rejection frequency
      Documentation: ABI: document IIO in_temp_filter_notch_center_frequenc=
y file
      iio: max31856: add support for configuring the HW averaging
      iio: core: add char type for sysfs attributes
      iio: core: add thermocouple_type standard attribute
      Documentation: ABI: document IIO thermocouple_type file
      iio: max31856: add support for runtime-configuring the thermocouple t=
ype
      iio: maxim_thermocouple: add thermocouple_type sysfs attribute
      dt-bindings: iio: maxim_thermocouple: document new 'compatible' strin=
gs

Andreas Klinger (4):
      dt-bindings: add vendor prefix parallax
      dt-bindings: add parallax ping sensors
      MAINTAINERS: add maintainer for ping iio sensors
      iio: ping: add parallax ping sensors

Andy Shevchenko (14):
      iio: adc: ti-ads1015: Get rid of legacy platform data
      iio: adc: ti-ads1015: Make use of device property API
      iio: st_lsm6dsx: Mark predefined constants with __maybe_unused
      iio: st_lsm6dsx: Drop unneeded OF code
      iio: st_lsm6dsx: Make use of device properties
      iio: light: st_uvis25: Drop unneeded header inclusion
      iio: accel: st_accel: Drop unnecessary #else branch for ACPI
      iio: pressure: st_press: Drop unnecessary #else branch for ACPI
      iio: gyro: st_gyro: Mark gyro_pdata with __maybe_unused
      iio: accel: st_accel: Mark default_accel_pdata with __maybe_unused
      iio: pressure: st_press: Mark default_press_pdata with __maybe_unused
      iio: st_sensors: Describe function parameters in kernel-doc
      iio: pressure: bmp280: Drop ACPI support
      iio: pressure: bmp280: Allow device to be enumerated from ACPI

Beniamin Bia (4):
      dt-binding: iio: Add documentation for AD7091R5
      MAINTAINERS: add entry for AD7091R5 driver
      iio: adc: ad7887: Cleanup channel assignment
      iio: adc: Move AD7091R5 entry in a alphabetical order in Makefile

Chen Zhou (1):
      iio: light: remove unneeded semicolon

Christophe JAILLET (1):
      iio: adc: ti-ads7950: Fix a typo in an error message

Dan Robertson (3):
      dt-bindings: iio: accel: bma400: add bindings
      iio: accel: Add driver for the BMA400
      iio: accel: bma400: basic regulator support

Daniel Junho (4):
      iio: adc: ad7923: Remove the unused defines
      iio: adc: ad7923: Fix checkpatch warning
      iio: adc: ad7923: Add of_device_id table
      iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928

Fabrice Gasnier (2):
      iio: trigger: stm32-timer: remove unnecessary update event
      iio: adc: stm32-adc: Add check on overrun interrupt

Geert Uytterhoeven (1):
      iio: adc: max9611: Make enum relations more future proof

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_mpu6050: delete not existing MPU9150 spi support
      iio: imu: inv_mpu6050: add support of MPU9150 magnetometer

Krzysztof Kozlowski (1):
      iio: Fix Kconfig indentation

Lars-Peter Clausen (3):
      iio: buffer-dmaengine: Add module information
      iio: buffer-dmaengine: Report buffer length requirements
      iio: buffer: rename 'read_first_n' callback to 'read'

Linus Walleij (16):
      iio: imu: inv_mpu6050: Select I2C_MUX again
      iio: ak8975: Convert to use GPIO descriptor
      iio: as3935: Drop GPIO includes
      iio: si1145: Drop GPIO include
      iio: ad2s1200: Drop legacy include
      iio: apds9960: Drop GPIO includes
      iio: itg3200: Drop GPIO include
      iio: adf4350: Convert to use GPIO descriptor
      iio: ad5592r: Drop surplus GPIO header
      iio: ad7266: Convert to use GPIO descriptors
      iio: atlas-ph-sensor: Drop GPIO include
      iio: ssp_sensors: Convert to use GPIO descriptors
      iio: accel: bma180: Add dev helper variable
      iio: accel: bma180: Basic regulator support
      iio: accel: bma180: Use explicit member assignment
      iio: accel: bma180: BMA254 support

Lorenzo Bianconi (8):
      iio: imu: st_lsm6dsx: fix checkpatch warning
      iio: humidity: hts221: move register definitions to sensor structs
      iio: imu: st_lsm6dsx: export max num of slave devices in st_lsm6dsx_s=
hub_settings
      iio: imu: st_lsm6dsx: check if master_enable is located in primary pa=
ge
      iio: imu: st_lsm6dsx: check if pull_up is located in primary page
      iio: imu: st_lsm6dsx: check if shub_output reg is located in primary =
page
      iio: imu: st_lsm6dsx: rename st_lsm6dsx_shub_read_reg in st_lsm6dsx_s=
hub_read_output
      iio: imu: st_lsm6dsx: enable sensor-hub support for lsm6dsm

Marco Felsch (1):
      iio: adc: ad799x: add pm_ops to disable the device completely

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: rename atlas-ph-sensor to atlas-sensor

Olivier Moysan (1):
      dt-bindings: iio: adc: convert sd modulator to json-schema

Paul Cercueil (2):
      iio: adc: Add support for AD7091R5 ADC
      iio: adc: ad7091r5: Add scale and external VREF support

Peter Ujfalusi (1):
      iio: buffer-dmaengine: Use dma_request_chan() directly for channel re=
quest

Rodrigo Carvalho (2):
      staging: iio: accel: adis16240: enforce SPI mode on probe function
      dt-bindings: iio: accel: add binding documentation for ADIS16240

Tomislav Denis (3):
      iio: pressure: Add driver for DLH pressure sensors
      dt-bindings: Add asc vendor
      bindings: iio: pressure: Add documentation for dlh driver

Uwe Kleine-K=C3=B6nig (3):
      iio: adc: ltc2496: provide device tree binding document
      iio: adc: ltc2497: split protocol independent part in a separate modu=
le
      iio: adc: new driver to support Linear technology's ltc2496

 Documentation/ABI/testing/sysfs-bus-iio            |  13 +
 Documentation/ABI/testing/sysfs-bus-iio-dma-buffer |  19 +
 .../bindings/iio/accel/adi,adis16240.yaml          |  49 ++
 .../devicetree/bindings/iio/accel/bma180.txt       |   7 +-
 .../bindings/iio/accel/bosch,bma400.yaml           |  54 ++
 .../devicetree/bindings/iio/adc/adi,ad7091r5.yaml  |  54 ++
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |  47 ++
 .../bindings/iio/adc/sigma-delta-modulator.txt     |  13 -
 .../bindings/iio/adc/sigma-delta-modulator.yaml    |  37 +
 .../bindings/iio/pressure/asc,dlhl60d.yaml         |  51 ++
 .../bindings/iio/proximity/parallax-ping.yaml      |  51 ++
 .../iio/temperature/maxim_thermocouple.txt         |   7 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   4 +
 MAINTAINERS                                        |  32 +-
 drivers/iio/accel/Kconfig                          |  20 +-
 drivers/iio/accel/Makefile                         |   2 +
 drivers/iio/accel/bma180.c                         | 225 +++++-
 drivers/iio/accel/bma400.h                         |  99 +++
 drivers/iio/accel/bma400_core.c                    | 852 +++++++++++++++++=
++++
 drivers/iio/accel/bma400_i2c.c                     |  61 ++
 drivers/iio/accel/st_accel.h                       |   2 +-
 drivers/iio/accel/st_accel_i2c.c                   |   2 -
 drivers/iio/adc/Kconfig                            |  17 +
 drivers/iio/adc/Makefile                           |   4 +-
 drivers/iio/adc/ad7091r-base.c                     | 298 +++++++
 drivers/iio/adc/ad7091r-base.h                     |  26 +
 drivers/iio/adc/ad7091r5.c                         | 113 +++
 drivers/iio/adc/ad7266.c                           |  29 +-
 drivers/iio/adc/ad7887.c                           |  82 +-
 drivers/iio/adc/ad7923.c                           |  64 +-
 drivers/iio/adc/ad799x.c                           |  66 +-
 drivers/iio/adc/ltc2496.c                          | 108 +++
 drivers/iio/adc/ltc2497-core.c                     | 243 ++++++
 drivers/iio/adc/ltc2497.c                          | 234 +-----
 drivers/iio/adc/ltc2497.h                          |  18 +
 drivers/iio/adc/max9611.c                          |  36 +-
 drivers/iio/adc/stm32-adc-core.c                   |  14 +-
 drivers/iio/adc/stm32-adc-core.h                   |   9 +
 drivers/iio/adc/stm32-adc.c                        |  55 +-
 drivers/iio/adc/ti-ads1015.c                       |  73 +-
 drivers/iio/adc/ti-ads7950.c                       |   2 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |   2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  30 +-
 drivers/iio/buffer/kfifo_buf.c                     |   5 +-
 drivers/iio/chemical/Makefile                      |   2 +-
 .../chemical/{atlas-ph-sensor.c =3D> atlas-sensor.c} |  11 +-
 drivers/iio/common/ssp_sensors/ssp.h               |  14 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c           |  29 +-
 drivers/iio/common/ssp_sensors/ssp_spi.c           |   8 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |   3 +
 drivers/iio/dac/ad5592r-base.c                     |   1 -
 drivers/iio/dac/ad7303.c                           |  25 +-
 drivers/iio/frequency/adf4350.c                    |  30 +-
 drivers/iio/gyro/Kconfig                           |  32 +-
 drivers/iio/gyro/adis16136.c                       |  31 +-
 drivers/iio/gyro/adis16260.c                       |   6 +-
 drivers/iio/gyro/itg3200_core.c                    |   1 -
 drivers/iio/gyro/st_gyro.h                         |   2 +-
 drivers/iio/humidity/hts221_core.c                 |  19 +-
 drivers/iio/iio_core.h                             |   8 +-
 drivers/iio/imu/adis.c                             |  94 +--
 drivers/iio/imu/adis16400.c                        |  51 +-
 drivers/iio/imu/adis16480.c                        |  17 +-
 drivers/iio/imu/adis_buffer.c                      |   4 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |   9 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  57 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         |  80 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  30 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  27 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 110 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  76 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   3 +-
 drivers/iio/industrialio-buffer.c                  |  10 +-
 drivers/iio/industrialio-core.c                    |  25 +-
 drivers/iio/light/apds9960.c                       |   2 -
 drivers/iio/light/lm3533-als.c                     |   2 +-
 drivers/iio/light/si1145.c                         |   1 -
 drivers/iio/light/st_uvis25_i2c.c                  |   1 -
 drivers/iio/magnetometer/ak8975.c                  |  54 +-
 drivers/iio/pressure/Kconfig                       |  12 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/bmp280-i2c.c                  |  18 +-
 drivers/iio/pressure/dlhl60d.c                     | 375 +++++++++
 drivers/iio/pressure/st_pressure.h                 |   2 +-
 drivers/iio/pressure/st_pressure_i2c.c             |   2 -
 drivers/iio/proximity/Kconfig                      |  15 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/as3935.c                     |   3 -
 drivers/iio/proximity/ping.c                       | 335 ++++++++
 drivers/iio/resolver/ad2s1200.c                    |   1 -
 drivers/iio/temperature/max31856.c                 | 134 +++-
 drivers/iio/temperature/maxim_thermocouple.c       |  44 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |   3 -
 drivers/staging/iio/accel/adis16240.c              |   7 +
 include/Kbuild                                     |   1 -
 include/linux/iio/buffer_impl.h                    |   6 +-
 include/linux/iio/frequency/adf4350.h              |   4 -
 include/linux/iio/imu/adis.h                       | 150 +++-
 include/linux/iio/magnetometer/ak8975.h            |   2 -
 include/linux/iio/types.h                          |   2 +
 include/linux/platform_data/ad7266.h               |   3 -
 include/linux/platform_data/ads1015.h              |  23 -
 106 files changed, 4394 insertions(+), 861 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis162=
40.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma40=
0.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-m=
odulator.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-m=
odulator.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlhl=
60d.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/paralla=
x-ping.yaml
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c
 create mode 100644 drivers/iio/adc/ad7091r-base.c
 create mode 100644 drivers/iio/adc/ad7091r-base.h
 create mode 100644 drivers/iio/adc/ad7091r5.c
 create mode 100644 drivers/iio/adc/ltc2496.c
 create mode 100644 drivers/iio/adc/ltc2497-core.c
 create mode 100644 drivers/iio/adc/ltc2497.h
 rename drivers/iio/chemical/{atlas-ph-sensor.c =3D> atlas-sensor.c} (98%)
 create mode 100644 drivers/iio/pressure/dlhl60d.c
 create mode 100644 drivers/iio/proximity/ping.c
 delete mode 100644 include/linux/platform_data/ads1015.h
