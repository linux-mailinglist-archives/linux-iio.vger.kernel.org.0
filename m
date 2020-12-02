Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1F2CBDF4
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 14:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgLBNJD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 2 Dec 2020 08:09:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbgLBNIl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Dec 2020 08:08:41 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47EAE2222F;
        Wed,  2 Dec 2020 13:07:59 +0000 (UTC)
Date:   Wed, 2 Dec 2020 13:07:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO new device support, cleanups and yaml
 conversions for the 5.11 cycle
Message-ID: <20201202130752.530970c6@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 749c1e1481e1d242ded9dd1bf210ddb7c0d22a4f:

  Merge tag 'iio-for-5.11a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2020-11-24 08:30:08 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.11b

for you to fetch changes up to 17d88536687df78673f395d5b7d5e7381c20b96c:

  iio: adc: rockchip_saradc: fix missing clk_disable_unprepare() on error in rockchip_saradc_resume (2020-12-01 13:02:14 +0000)

----------------------------------------------------------------
2nd set of IIO device support, features, cleanups and yaml conversions for 5.11

Includes low priority/late breaking/long standing bug fixes.

Note this includes the last few patches that were listed in the description
for the previous pull request but weren't actually in the PULL.

New devices support
* bosch,bmc150-accel
  - Support for BMA222, including adding binding doc that was previously
    missing.
* st,lsm6dsx
  - Support LSM6DSOP accelerometer + gyroscope sensor.

yaml-conversions by manufacturer
* core
  - adc
  - iio-binding (drop as now in dt-schema)
  - temperature (drop as not clear it is generic)
* generic (no specific manufacturer)
  - dpot-dac
  - current-sense-amplifier
  - current-sense-shunt
  - envelope-detector
  - voltage-divider
* adi,ad5592r adi,ad7124 adi,ad7292 adi,adf4350
* atmel,sama9260-adc
* bosch,bma180 bosch,bmg180
* brcm,iproc-static-adc
* capella,cm3605
* fsl,mma8452
* kionix,kxcjk1013
* maxim,max1027 (from trivial)
* mediatek,mt2701-auxdac
* microchip,mcp4531 (from trivial)
* qcom,pm8018-adc qcom,spi-iadc
* st,st-sensors
* ti,ads124s08 ti,afe4403 ti,afe4404 ti,lmp91000 ti,palmas-gpadc

Features
* bosch,bmc150
  - Handle unusual ACPI binding where two devices are provided in a single
    ACPI device (BOSC0200).
  - ACPI based mount matrix handling
* st,hts221
  - regulator control
* st,lsm6dsx
  - regulator control

Cleanup + minor fixes
* core
  - Reduce duplication in iio_format_avail_{list,range}() and iio_format_list()
  - Fix an issue in the demux update code that could lead to misaligned data.
    Possible no existing driver hits this. Been there a very long time with
    no bug reports.
  - Improve iio_map_array_register() error handling.
  - Avoid polling driver again if try_reenable() callback returns non 0.
    Only users of this were bugs so also drop the return value.
* core/cb_buffer
  - Return an error if no callback provided (include adding a dummy for one
    unusual case where no callback is valid).
* trigger/hrtimer-trig, sysfs-trig
  - Fix an issue seen with PREEMPT_RT by marking irq_work as expiring in hard
    interrupt context.
* adi,ad_sigma_delta library
  - Avoid putting SPI transfer buffers on stack for DMA safety reasons
* adi,ad5272
  - Fix discrepancy in polarity of reset line between binding documentation
    (which was right) and driver.
* adi,ad7298
  - Use devm for all of probe
* atmel,at91_adc
  - Drop at91_adc_ids as only support DT probe
  - Simplify resolution selection and bindings
  - Drop binding for triggers and move into driver based on compatible.
  - Merge at91_adc_probe_dt() into main at91_adc_probe()
* bosch,bmc150
  - Drop unused structure member.
* bosch,bmi160
  - Fix overly long buffer due to wrong channel count.
  - Fix potential buffer alignment into iio_push_to_buffers_with_timestamp()
* fsl,mag3110
  - Fix potential buffer alignment into iio_push_to_buffers_with_timestamp()
* fsl,mpl3115
  - Fix potential buffer alignment into iio_push_to_buffers_with_timestamp()
* invn,mpu3050
  - Use 64 bit local variable and FIELD_GET to simplify code that extracts
    values from OTP.
* qcom,spmi-vadc
  - Drop wrong use of io-channel-ranges in binding doc.
* rockchip,saradc
  - Fix a missing clk_disable_unprepare() in an error path.
* rohm,rpr0521
  - Fix potential buffer alignment into iio_push_to_buffers_with_timestamp()
* samsung,exynos-adc
  - Drop wrong use of io-channel-ranges in binding doc.
* st,lsm6dsx
  - Reduce duplication in the chip model specific tables.
  - Fix an issue with missed edge-interrupts that can occur when using
    the FIFO.
* st,uvis21
  - Fix potential buffer alignment into iio_push_to_buffers_with_timestamp()
* ti,adc084s021
  - Tidy up endian types to clear a warning.
* ti,ads124s08
  - Fix too long a buffer.
  - Fix potential buffer alignment into iio_push_to_buffers_with_timestamp()

Counter
* microchip,tcb-counter
  - Add Kamel Bouhara to MAINTAINERS
  - Fix CMR value check

----------------------------------------------------------------
Alexandre Belloni (6):
      iio: adc: at91_adc: remove at91_adc_ids
      iio: adc: at91_adc: rework resolution selection
      dt-bindings:iio:adc:remove atmel, adc-res and atmel, adc-res-names
      iio: adc: at91_adc: rework trigger definition
      dt-bindings:iio:adc:remove triggers
      iio: adc: at91_adc: merge at91_adc_probe_dt back in at91_adc_probe

Alexandru Ardelean (2):
      iio: adc: ad7298: convert probe to device-managed functions
      iio: adc: ad7298: check regulator for null in ad7298_get_ref_voltage()

Hans de Goede (2):
      iio: accel: bmc150: Removed unused bmc150_accel_dat irq member
      iio: accel: bmc150: Get mount-matrix from ACPI

Jeremy Cline (1):
      iio: accel: bmc150: Check for a second ACPI device for BOSC0200

Jonathan Cameron (44):
      dt-bindings:iio:adc:brcm,iproc-static-adc: txt to yaml conversion
      dt-bindings:iio:adc:mediatek,mt2701-auxadc: rename and yaml conversion.
      dt-bindings:iio:adc:ti,palmas-gpadc: txt to yaml format conversion.
      dt-bindings:iio:adc:qcom,pm8018-adc: yaml conversion and rename.
      dt-bindings:iio:adc:qcom,spmi-iadc: txt to yaml format conversion.
      dt-binding:iio:adc:ti,ads124s08: txt to yaml format conversion.
      dt-bindings:iio:dac:ad5592r: txt to yaml format conversion.
      dt-bindings:iio:accel:bosch,bma180: txt to yaml format conversion.
      dt-bindings:iio:accel:kionix,kxcjk1013: txt to yaml format conversion.
      dt-bindings:iio:accel:fsl,mma8452: txt to yaml conversion.
      dt-bindings:iio:gyro:bosch,bmg180: txt to yaml format conversion.
      dt-bindings:iio:st,st-sensors: txt to yaml conversion.
      dt-bindings:iio:frequency:adi,adf4350: txt to yaml format conversion.
      dt-bindings:iio:temperature: Drop generic binding file.
      dt-bindings:iio:qcom-spmi-vadc drop incorrect io-channel-ranges from example
      dt-bindings:iio:samsung, exynos-adc: drop missuse of io-channel-ranges
      dt-bindings:iio:health:ti,afe4403: txt to yaml binding
      dt-bindings:iio:health:ti,afe4404: txt to yaml conversion
      dt-bindings:iio:adc: convert adc.txt to yaml
      dt-bindings:iio:adc:adi,ad7124: Use the new adc.yaml channel binding
      dt-bindings:iio:adc:adi,ad7292: Use new adc.yaml binding for channels.
      dt-bindings:iio:iio-binding.txt Drop file as content now in dt-schema
      dt-bindings:iio:dac:dpot-dac: yaml conversion.
      dt-bindings:iio:potentiometer: give microchip,mcp4531 its own binding
      dt-bindings:iio:adc:envelope-detector: txt to yaml conversion.
      dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.
      dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.
      dt-bindings:iio:adc:maxim,max1027: Pull out to separate binding doc.
      dt-bindings:iio:afe:voltage-divider: txt to yaml conversion
      dt-bindings:iio:light:capella,cm3605: txt to yaml conversion.
      dt-bindings:iio:potentiostat:ti,lmp91000: txt to yaml conversion.
      dt-bindings:iio:adc:atmel, sama9260-adc: conversion to yaml from at91_adc.txt
      iio: Fix: Do not poll the driver again if try_reenable() callback returns non 0.
      iio:trigger: rename try_reenable() to reenable() plus return void
      iio:adc:ti-adc084s021 Tidy up endian types
      iio:light:rpr0521: Fix timestamp alignment and prevent data leak.
      iio:light:st_uvis25: Fix timestamp alignment and prevent data leak.
      iio:magnetometer:mag3110: Fix alignment and data leak issues.
      iio:imu:bmi160: Fix too large a buffer.
      iio:imu:bmi160: Fix alignment and data leak issues
      iio:pressure:mpl3115: Force alignment of buffer
      iio:adc:ti-ads124s08: Fix buffer being too long.
      iio:adc:ti-ads124s08: Fix alignment and data leak issues.
      iio:gyro:mpu3050 Treat otp value as a __le64 and use FIELD_GET() to break up

Lars-Peter Clausen (5):
      iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack
      iio: core: Consolidate iio_format_avail_{list,range}()
      iio: core: Simplify iio_format_list()
      iio: hrtimer-trigger: Mark hrtimer to expire in hard interrupt context
      iio: sysfs-trigger: Mark irq_work to expire in hardirq context

Lino Sanfilippo (2):
      iio:core: Introduce unlocked version of iio_map_array_unregister()
      io:core: In iio_map_array_register() cleanup in case of error

Linus Walleij (3):
      iio: accel: bmc150-accel: Add DT bindings
      iio: accel: bmc150-accel: Add support for BMA222
      iio: accel: bmc150-accel: Add rudimentary regulator support

Lorenzo Bianconi (8):
      iio: imu: st_lsm6dsx: add vdd-vddio voltage regulator
      dt-bindings: iio: imu: st_lsm6dsx: introduce vdd-vddio regulators bindings
      iio: humidity: hts221: add vdd voltage regulator
      dt-bindings: iio: humidity: hts221: introduce vdd regulator bindings
      iio: imu: st_lsmdsx: compact st_lsm6dsx_sensor_settings table
      iio: imu: st_lsm6dsx: add support to LSM6DSOP
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsop device bindings
      iio: imu: st_lsm6dsx: fix edge-trigger interrupts

Nuno Sá (2):
      iio: buffer: Return error if no callback is given
      iio: buffer: Fix demux update

Olivier Moysan (1):
      ASoC: stm32: dfsdm: add stm32_adfsdm_dummy_cb() callback

Phil Reid (1):
      iio: potentiometer: ad5272: Correct polarity of reset

Qinglang Miao (1):
      iio: adc: rockchip_saradc: fix missing clk_disable_unprepare() on error in rockchip_saradc_resume

William Breathitt Gray (2):
      MAINTAINERS: Add Kamel Bouhara as TCB counter driver maintainer
      counter: microchip-tcb-capture: Fix CMR value check

 .../devicetree/bindings/iio/accel/bma180.txt       |  35 --
 .../bindings/iio/accel/bosch,bma180.yaml           |  62 +++
 .../bindings/iio/accel/bosch,bma255.yaml           |  73 +++
 .../devicetree/bindings/iio/accel/fsl,mma8452.yaml |  65 +++
 .../bindings/iio/accel/kionix,kxcjk1013.txt        |  24 -
 .../bindings/iio/accel/kionix,kxcjk1013.yaml       |  46 ++
 .../devicetree/bindings/iio/accel/mma8452.txt      |  35 --
 Documentation/devicetree/bindings/iio/adc/adc.txt  |  29 --
 Documentation/devicetree/bindings/iio/adc/adc.yaml |  42 ++
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |  14 +-
 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |   8 +-
 .../devicetree/bindings/iio/adc/at91_adc.txt       |  83 ----
 .../bindings/iio/adc/atmel,sama9260-adc.yaml       | 121 +++++
 .../bindings/iio/adc/brcm,iproc-static-adc.txt     |  40 --
 .../bindings/iio/adc/brcm,iproc-static-adc.yaml    |  70 +++
 .../bindings/iio/adc/envelope-detector.txt         |  54 ---
 .../bindings/iio/adc/envelope-detector.yaml        |  86 ++++
 .../devicetree/bindings/iio/adc/maxim,max1027.yaml |  65 +++
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |  77 +++
 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |  34 --
 .../devicetree/bindings/iio/adc/palmas-gpadc.txt   |  48 --
 .../bindings/iio/adc/qcom,pm8018-adc.yaml          | 166 +++++++
 .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 157 -------
 .../devicetree/bindings/iio/adc/qcom,spmi-iadc.txt |  46 --
 .../bindings/iio/adc/qcom,spmi-iadc.yaml           |  60 +++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |   3 -
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |   4 -
 .../devicetree/bindings/iio/adc/ti,ads124s08.yaml  |  52 ++
 .../bindings/iio/adc/ti,palmas-gpadc.yaml          |  87 ++++
 .../devicetree/bindings/iio/adc/ti-ads124s08.txt   |  25 -
 .../bindings/iio/afe/current-sense-amplifier.txt   |  26 -
 .../bindings/iio/afe/current-sense-amplifier.yaml  |  54 +++
 .../bindings/iio/afe/current-sense-shunt.txt       |  41 --
 .../bindings/iio/afe/current-sense-shunt.yaml      |  64 +++
 .../bindings/iio/afe/voltage-divider.txt           |  53 ---
 .../bindings/iio/afe/voltage-divider.yaml          |  86 ++++
 .../devicetree/bindings/iio/dac/ad5592r.txt        | 155 ------
 .../devicetree/bindings/iio/dac/adi,ad5592r.yaml   | 204 ++++++++
 .../devicetree/bindings/iio/dac/dpot-dac.txt       |  41 --
 .../devicetree/bindings/iio/dac/dpot-dac.yaml      |  64 +++
 .../devicetree/bindings/iio/frequency/adf4350.txt  |  86 ----
 .../bindings/iio/frequency/adi,adf4350.yaml        | 190 ++++++++
 .../devicetree/bindings/iio/gyroscope/bmg160.txt   |  20 -
 .../bindings/iio/gyroscope/bosch,bmg160.yaml       |  46 ++
 .../devicetree/bindings/iio/health/afe4403.txt     |  33 --
 .../devicetree/bindings/iio/health/afe4404.txt     |  29 --
 .../devicetree/bindings/iio/health/ti,afe4403.yaml |  54 +++
 .../devicetree/bindings/iio/health/ti,afe4404.yaml |  51 ++
 .../bindings/iio/humidity/st,hts221.yaml           |   2 +
 .../devicetree/bindings/iio/iio-bindings.txt       | 102 ----
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |   7 +
 .../bindings/iio/light/capella,cm3605.yaml         |  79 ++++
 .../devicetree/bindings/iio/light/cm3605.txt       |  41 --
 .../iio/potentiometer/microchip,mcp4531.yaml       | 116 +++++
 .../bindings/iio/potentiostat/lmp91000.txt         |  33 --
 .../bindings/iio/potentiostat/ti,lmp91000.yaml     |  68 +++
 .../devicetree/bindings/iio/st,st-sensors.yaml     | 123 +++++
 .../devicetree/bindings/iio/st-sensors.txt         |  82 ----
 .../iio/temperature/temperature-bindings.txt       |   7 -
 .../devicetree/bindings/trivial-devices.yaml       | 140 ------
 MAINTAINERS                                        |   7 +
 drivers/counter/microchip-tcb-capture.c            |  16 +-
 drivers/iio/accel/bma180.c                         |   9 +-
 drivers/iio/accel/bmc150-accel-core.c              | 194 +++++++-
 drivers/iio/accel/bmc150-accel-i2c.c               |  45 +-
 drivers/iio/accel/bmc150-accel-spi.c               |   2 +
 drivers/iio/accel/bmc150-accel.h                   |   3 +
 drivers/iio/accel/kxcjk-1013.c                     |  10 +-
 drivers/iio/accel/mxc4005.c                        |  16 +-
 drivers/iio/adc/ad7298.c                           |  48 +-
 drivers/iio/adc/ad_sigma_delta.c                   |  18 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   8 +-
 drivers/iio/adc/at91_adc.c                         | 294 +++++-------
 drivers/iio/adc/rockchip_saradc.c                  |   2 +-
 drivers/iio/adc/ti-adc084s021.c                    |  10 +-
 drivers/iio/adc/ti-ads124s08.c                     |  13 +-
 drivers/iio/buffer/industrialio-buffer-cb.c        |   5 +
 drivers/iio/gyro/adxrs290.c                        |   6 +-
 drivers/iio/gyro/bmg160_core.c                     |  12 +-
 drivers/iio/gyro/mpu3050-core.c                    |  28 +-
 drivers/iio/humidity/hts221.h                      |   2 +
 drivers/iio/humidity/hts221_core.c                 |  37 ++
 drivers/iio/imu/bmi160/bmi160.h                    |   7 +
 drivers/iio/imu/bmi160/bmi160_core.c               |   6 +-
 drivers/iio/imu/kmx61.c                            |  10 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   8 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 521 ++++-----------------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   5 +
 drivers/iio/industrialio-buffer.c                  |   6 +-
 drivers/iio/industrialio-core.c                    |  94 ++--
 drivers/iio/industrialio-trigger.c                 |   6 +-
 drivers/iio/inkern.c                               |  29 +-
 drivers/iio/light/rpr0521.c                        |  17 +-
 drivers/iio/light/st_uvis25.h                      |   5 +
 drivers/iio/light/st_uvis25_core.c                 |   8 +-
 drivers/iio/magnetometer/bmc150_magn.c             |  10 +-
 drivers/iio/magnetometer/mag3110.c                 |  13 +-
 drivers/iio/potentiometer/ad5272.c                 |   4 +-
 drivers/iio/pressure/mpl3115.c                     |   9 +-
 drivers/iio/trigger/iio-trig-hrtimer.c             |   4 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |   1 +
 include/linux/iio/adc/ad_sigma_delta.h             |   6 +-
 include/linux/iio/trigger.h                        |   4 +-
 sound/soc/stm/stm32_adfsdm.c                       |  12 +-
 107 files changed, 3014 insertions(+), 2373 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/bma180.txt
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma180.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad5592r.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5592r.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4350.txt
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/health/afe4403.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt
 create mode 100644 Documentation/devicetree/bindings/iio/health/ti,afe4403.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/health/ti,afe4404.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/iio-bindings.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/cm3605.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4531.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
 create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/ti,lmp91000.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/st,st-sensors.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/st-sensors.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/temperature/temperature-bindings.txt
