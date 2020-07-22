Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AAC2299E6
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgGVOQo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 10:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbgGVOQo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 10:16:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BF820709;
        Wed, 22 Jul 2020 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595427403;
        bh=TrAjIznXudwZFfFqQOw+FNmHSFTGZ6xEmJRdN35autE=;
        h=Date:From:To:Subject:From;
        b=MmLTISIi5WdTp6TH8IpDU4Ic7q4BKI7vJkwrhnSYRpzhv68xfNwELFoOXKmnjQeUD
         QKBqdJfM1UuoWNcsaqLLvqF4CjNd8JXcXDhQnvYxT/Xu5GU4439FsAYeQpkJW8tC89
         jIaBKOEwaMUkLoQhzFZ2f0y77C/eDHVpQrIpfJSI=
Date:   Wed, 22 Jul 2020 15:16:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO cleanups, features etc for the 5.9 cycle.
Message-ID: <20200722151639.1bde9bfb@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 263771dbc85bc6573b344c193351980c27fd2faa:

  Merge 5.8-rc6 into staging-next (2020-07-20 09:37:31 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.9b

for you to fetch changes up to a1bab9396c2d98c601ce81c27567159dfbc10c19:

  iio: imu: st_lsm6dsx: reset hw ts after resume (2020-07-22 14:55:43 +0100)

----------------------------------------------------------------
Second set of new device support, cleanups etc for IIO/Counters in the 5.9 cycle

There are two merge commits in here of immutable branches that may
also be picked up through other trees (clocksource and input)

I've put a few late breaking fixes in here that aren't worth rushing
in before the  merge window.  One major fix for an issue introduced
in the last set that can result in devices not having their parent set.

This set is dominated by W=1 cleanups from Lee Jones. I won't list them
all separately.  They are mostly:
* Kernel doc fixes
* Unused variable removal.
* Suppression of unused stuff that is static in headers.

Counters subsystem
* atmel-tcb
  - New counter driver after various cleanups of existing tcb code and bindings.

Device support
* stk311
  - Trivial addition of ID for STK311-X variant.

yaml conversions
* kionix,kxsd9
* ti,ads8688

Features
* jz47xx
  - Add support for touch screen channels. In this particular case the
    boards in question actually wire a joystick to them so we want them
    as simple voltage channels. The joystick driver will probably go
    via the input tree.

Cleanups + fixes
* core
  - A rebase issue in recent major refactoring dropped the assignment of
    of the device parent in the core. Put it back.
* ad5592r
  - Fix unbalanced mutex unlocks in *_read_raw()
* ad7124
  - Move chip ID and name to the chip_info table plus add a read of the
    revision register to check the device is working during probe.
* ad7192
  - Ridy up ordering to put the match table near the end fo the file where it
    is used.
* lsm6dsx
  - Reset the hardware timestamp after a resume to avoid an issue with
    missaligned timestamps after suspend.
* jz47xx
  - Error checks on clk_enable() calls.
  - xlate callaback to find channel index.
  - Use separate chan_spec arrays for different variants rather than
    parts of a single list.  Simplifies code.

----------------------------------------------------------------
Alexandre Belloni (2):
      dt-bindings: atmel-tcb: convert bindings to json-schema
      dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible

Alexandru Ardelean (4):
      iio: adc: ad7192: move ad7192_of_match table closer to the end of the file
      iio: adc: ad7124: move chip ID & name on the chip_info table
      iio: core: fix/re-introduce back parent assignment
      iio: dac: ad5592r: fix unbalanced mutex unlocks in ad5592r_read_raw()

Artur Rojek (4):
      IIO: Ingenic JZ47xx: Error check clk_enable calls.
      IIO: Ingenic JZ47xx: Add xlate cb to retrieve correct channel idx
      dt-bindings: iio/adc: Add touchscreen idx for JZ47xx SoC ADC
      IIO: Ingenic JZ47xx: Add touchscreen mode.

Icenowy Zheng (1):
      iio: light: stk3310: add chip id for STK3311-X variant

Jonathan Cameron (4):
      dt-bindings: iio: accel: kionix,kxsd9 yaml conversion.
      dt-bindings: iio: ti,ads8688 yaml conversion
      Merge branch 'ib-5.8-jz47xx-ts' into HEAD Immutable branch may be needed in input for a joystick set that is dependent on it.
      Merge branch 'ib-5.8-tcb' into HEAD

Kamel Bouhara (3):
      ARM: at91: add atmel tcb capabilities
      dt-bindings: counter: microchip-tcb-capture counter
      counter: Add microchip TCB capture counter

Lee Jones (51):
      iio: adc: ad_sigma_delta: Remove unused variable 'ret'
      iio: accel: bma220_spi: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
      iio: common: ms_sensors: ms_sensors_i2c: Fix misspelling of parameter 'client'
      iio: adc: ad7298: Demote obvious misuse of kerneldoc to standard comment blocks
      iio: adc: ad7923: Demote obvious misuse of kerneldoc to standard comment blocks
      iio: dac: ad5360: Fix kerneldoc attribute formatting for 'lock'
      iio: dac: ad5380: Fix kerneldoc attribute formatting for 'lock'
      iio: dummy: iio_simple_dummy: Demote unworthy kerneldocs and correct wrong parameter in docs
      iio: dummy: iio_simple_dummy: Add newline after function-end
      iio: dac: ad5421: Fix kerneldoc attribute formatting for 'lock'
      iio: dummy: iio_simple_dummy_events: Demote file header and supply descriptions for val2 params
      iio: dac: ad5064: Value returned by ad5064_vref_name may not be 'const * const'
      iio: adc: ad7887: Demote seemingly unintentional kerneldoc header
      iio: dummy: iio_simple_dummy_buffer: Demote file header and correct misspelling
      iio: dac: ad5446: Complete 'struct ad5446_state' doc and demote unworthy kerneldocs
      iio: dac: ad5449: Fix kerneldoc attribute formatting for 'lock'
      iio: dac: ad5755: Fix kerneldoc attribute formatting for 'lock'
      iio: dac: ad5758: Move and fix-up kerneldoc header and demote unworthy kerneldoc
      iio: dac: ad5761: Fix kerneldoc attribute formatting for 'lock'
      iio: dac: ad5764: Fix misdocumenting and formatting error
      iio: dac: ad5791: Complete 'struct ad5791_chip_info' documentation
      iio: light: cm32181: Fix formatting and docrot issues in cm32181_acpi_get_cpm()
      iio: magnetometer: mmc35240: Fix function header formatting
      iio: imu: kmx61: Fix formatting in kerneldoc function headers
      iio: adc: ti_am335x_adc: Remove a couple of unused 'read' variables
      iio: adc: twl4030-madc: Remove set but unused variables 'len'
      iio: adc: twl4030-madc: Fix misnamed struct attribute
      iio: magnetometer: hmc5843: 'hmc5843_pm_ops' is unused in 1 of 3 files including hmc5843_core.h
      iio: adc: twl6030-gpadc: Fix some misdocumentation and formatting issues
      iio: dac: ltc2632: Fix formatting in kerneldoc struct header
      iio: light: si1145: Demote obvious misuse of kerneldoc to standard comment blocks
      iio: temperature: mlx90632: Function parameter descriptions must match exactly
      iio: light: us5182d: Fix formatting in kerneldoc function block
      iio: adc: ad799x: Demote seemingly unintentional kerneldoc header
      iio: dac: ad5504: Fix formatting errors and demote non-compliant kerneldoc
      iio: adc: at91_adc: Fix 'bad line' warning
      iio: adc: at91-sama5d2_adc: Struct kerneldoc titles need to start with 'struct '
      iio: adc: cpcap-adc: Demote seemingly unintentional kerneldoc header
      iio: accel: sca3000: Fix 2 misspellings and demote nonconforming kerneldocs
      iio: gyro: fxas21002c: Move 'fxas21002c_reg_fields' to the only file its used
      iio: imu: st_lsm6dsx: st_lsm6dsx: Reorder 'inline' declaration
      iio: adc: max1363: Fix kerneldoc attribute formatting for 'lock'
      iio: adc: max9611: Demote obvious misuse of kerneldoc to standard comment blocks
      iio: adc: palmas_gpadc: Demote non-conforming kerneldoc header
      iio: imu: inv_mpu6050: inv_mpu_core: Demote obvious misuse of kerneldoc to standard comment blocks
      iio: imu: inv_mpu6050: inv_mpu_ring: Demote seemingly unintentional kerneldoc header
      iio: adc: qcom-pm8xxx-xoadc: Demote standard comment block and supply missing description
      iio: magnetometer: ak8974: Add description for ak8974's 'scan' attribute
      iio: imu: st_lsm6dsx: st_lsm6dsx_shub: Demote obvious misuse of kerneldoc to standard comment blocks
      iio: imu: st_lsm6dsx: st_lsm6dsx: Mark 'st_lsm6dsx_accel_ext_info' as __maybe_unused
      iio: adc: rockchip_saradc: Demote seemingly unintentional kerneldoc header

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: reset hw ts after resume

Paul Cercueil (1):
      iio/adc: ingenic: Retrieve channels list from soc data struct

 .../devicetree/bindings/iio/accel/kionix,kxsd9.txt |  22 --
 .../bindings/iio/accel/kionix,kxsd9.yaml           |  65 ++++
 .../devicetree/bindings/iio/adc/ti,ads8688.yaml    |  45 +++
 .../devicetree/bindings/iio/adc/ti-ads8688.txt     |  20 --
 .../devicetree/bindings/mfd/atmel-tcb.txt          |  56 ---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml        | 181 ++++++++++
 drivers/counter/Kconfig                            |  11 +
 drivers/counter/Makefile                           |   1 +
 drivers/counter/microchip-tcb-capture.c            | 397 +++++++++++++++++++++
 drivers/iio/accel/bma220_spi.c                     |   2 +
 drivers/iio/accel/sca3000.c                        |  12 +-
 drivers/iio/adc/Kconfig                            |   1 +
 drivers/iio/adc/ad7124.c                           |  73 +++-
 drivers/iio/adc/ad7192.c                           |  18 +-
 drivers/iio/adc/ad7298.c                           |   8 +-
 drivers/iio/adc/ad7887.c                           |   2 +-
 drivers/iio/adc/ad7923.c                           |   8 +-
 drivers/iio/adc/ad799x.c                           |   2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |   7 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   4 +-
 drivers/iio/adc/at91_adc.c                         |   2 +-
 drivers/iio/adc/cpcap-adc.c                        |   6 +-
 drivers/iio/adc/ingenic-adc.c                      | 391 +++++++++++++++++---
 drivers/iio/adc/max1363.c                          |   2 +-
 drivers/iio/adc/max9611.c                          |   4 +-
 drivers/iio/adc/palmas_gpadc.c                     |   3 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   3 +-
 drivers/iio/adc/rockchip_saradc.c                  |   2 +-
 drivers/iio/adc/ti_am335x_adc.c                    |   8 +-
 drivers/iio/adc/twl4030-madc.c                     |  14 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   4 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c     |   2 +-
 drivers/iio/dac/ad5064.c                           |   2 +-
 drivers/iio/dac/ad5360.c                           |   2 +-
 drivers/iio/dac/ad5380.c                           |   2 +-
 drivers/iio/dac/ad5421.c                           |   2 +-
 drivers/iio/dac/ad5446.c                           |  11 +-
 drivers/iio/dac/ad5449.c                           |   2 +-
 drivers/iio/dac/ad5504.c                           |   7 +-
 drivers/iio/dac/ad5592r-base.c                     |   4 +-
 drivers/iio/dac/ad5755.c                           |   2 +-
 drivers/iio/dac/ad5758.c                           |  18 +-
 drivers/iio/dac/ad5761.c                           |   2 +-
 drivers/iio/dac/ad5764.c                           |   5 +-
 drivers/iio/dac/ad5791.c                           |  10 +-
 drivers/iio/dac/ltc2632.c                          |   6 +-
 drivers/iio/dummy/iio_simple_dummy.c               |   7 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |   4 +-
 drivers/iio/dummy/iio_simple_dummy_events.c        |   4 +-
 drivers/iio/gyro/fxas21002c.h                      |  66 ----
 drivers/iio/gyro/fxas21002c_core.c                 |  66 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  14 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   2 +-
 drivers/iio/imu/kmx61.c                            |  14 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   8 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  23 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   8 +-
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/light/cm32181.c                        |   8 +-
 drivers/iio/light/si1145.c                         |   6 +-
 drivers/iio/light/stk3310.c                        |   2 +
 drivers/iio/light/us5182d.c                        |   8 +-
 drivers/iio/magnetometer/ak8974.c                  |   1 +
 drivers/iio/magnetometer/hmc5843.h                 |   6 +-
 drivers/iio/magnetometer/mmc35240.c                |   2 +-
 drivers/iio/temperature/mlx90632.c                 |   4 +-
 include/dt-bindings/iio/adc/ingenic,adc.h          |   6 +
 include/soc/at91/atmel_tcb.h                       |   5 +
 69 files changed, 1350 insertions(+), 368 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.txt
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads8688.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
 create mode 100644 drivers/counter/microchip-tcb-capture.c
