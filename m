Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2EA9D4F45
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 13:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJLLTw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 07:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfJLLTw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 07:19:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D01221850;
        Sat, 12 Oct 2019 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570879191;
        bh=84ZGLUZDLDjLUegyzJlzYRasBt60/l3ianZpwXXUNq4=;
        h=Date:From:To:Subject:From;
        b=vaW+TmpfsIt5cpxBU6RDrQ49ALkWIMn9FrlNmAJ68YZhQL7Sj4JgxqkhrSS2FiNpU
         YqHko5i1eaSTfYlBMwmvrHa7xtGWhSvgL/ohi8U2+TAeSf5NjHcc8ZbqVi0XykGPG4
         aZmX8g56U0Je7fvBSbAX6EYvWo3fn4DTgBGd7UF0=
Date:   Sat, 12 Oct 2019 12:19:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL v2] First set of iio new device support etc for the 5.5 cycle
Message-ID: <20191012121946.051b646f@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit b73b93a2af3392b9b7b8ba7e818ee767499f9655:

  iio: adc: ad7192: Add sysfs ABI documentation (2019-09-08 10:34:49 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.5a-take2

for you to fetch changes up to 4e716deff4c0b5bdb1bb7c41bdfe0fac2cf64c27:

  iio: imu: adis16400: fix compiler warnings (2019-10-12 12:11:37 +0100)

----------------------------------------------------------------
First set of IIO new device support, cleanups and features for the 5.5 cycle

Second version of pull has an additional patch to fix some build
warnings from the adis16400.

The usual mixed backs of new device support being added to drivers,
long term reworks continuing and little per driver cleanups and
features.

Also a few trivial counter subsystem tidy ups on behalf of William.

Core new feature
* Device label support.  A long requested feature no one got around to
  implementing before.  Allows DT based provision of a 'label' that
  identifies a device uniquely within a system.  This differs from existing
  'name' which is meant to be the part number.
New device support
* ingenic-adc
  - Support for the JZ4770 SoC ADC including bindings.
* inv_mpu6050
  - Add support for magnetometer in MPU925x parts.
    Fiddly to do as this is actually a separate device sitting inside the
    package, but with the master device being able to schedule reads etc.
    Will only run if the auxiliary bus is not in use for any other devices.

Features
* ad7192
  - Userspace calibration controls to do zero and full scale.
* st_lsm6dsx
  - Enable latched interrupts by default for sensors events with related clear.
  - Motion events and related wakeup source.  This needed quite a bit of
    refactoring as well.

Cleanups and minor features
* ad7192
  - sysfs ABI docs
* ad7949
  - Remove code to readback configuration word as driver never actually enabled
    it.
  - Fix incorrect xfer length.  Not actually known to cause problems other
    than wasted bus usage.
* adis library and drivers
  - Locking rework to simplify locking in general and avoid using the
    core mlock except for it's intending use to protect IIO state changes.
* adis16080
  - Replace core mlock usage with local lock with more appropriate scope.
* adis16130
  - Remove pointless mlock usage.
* adis16240
  - Remove include of gpio.h as no gpio usage.
* adis16400
  - Fix some uninitialized variable build warnings.
* atlas-ph-sensor
  - Improve logical ordering of buffer predisable / postenable functions.
    This is part of a longer term rework Alexandru is driving towards.
* bh1750
  - Fix up a static compiler warning and make the code more readable.
  - yaml conversion of binding + MAINTAINERS entry.
* bmp280
  - Drop a stray newline.
* cm36651
  - Drop a redundant assignment
* itg3200
  - Alignment cleanup.
* max31856
  - Add missing of_node and parent references, useful to identify the device.
* sc27xx_adc
  - Use devm_hwspin_lock_request_specific rather than local rolled version.
* stm32-lptimer counter
  - kernel-doc warning.
* stm32-timer counter
  - kernel-doc warning.
  - Alignment cleanup.
* sx9500
  - Improve logical ordering of buffer predisable / postenable functions.
    This is part of a longer term rework Alexandru is driving towards.
* tcs3414
  - Improve logical ordering of buffer predisable / postenable functions.
    This is part of a longer term rework Alexandru is driving towards.

----------------------------------------------------------------
Alexandru Ardelean (16):
      iio: tcs3414: fix iio_triggered_buffer_{pre,post}enable positions
      iio: gyro: adis16130: remove mlock usage
      iio: gyro: adis16080: replace mlock with own lock
      iio: proximity: sx9500: fix iio_triggered_buffer_{predisable,postenable} positions
      iio: imu: adis: rename txrx_lock -> state_lock
      iio: imu: adis: add unlocked read/write function versions
      iio: imu: adis[16480]: group RW into a single lock in adis_enable_irq()
      iio: imu: adis: create an unlocked version of adis_check_status()
      iio: imu: adis: create an unlocked version of adis_reset()
      iio: imu: adis: protect initial startup routine with state lock
      iio: imu: adis: group single conversion under a single state lock
      iio: imu: adis16400: rework locks using ADIS library's state lock
      iio: gyro: adis16136: rework locks using ADIS library's state lock
      iio: imu: adis16480: use state lock for filter freq set
      iio: chemical: atlas-ph-sensor: fix iio_triggered_buffer_predisable() position
      iio: imu: adis16400: fix compiler warnings

Andrea Merello (3):
      iio: ad7949: kill pointless "readback"-handling code
      iio: max31856: add missing of_node and parent references to iio_dev
      iio: ad7949: fix incorrect SPI xfer len

Artur Rojek (3):
      dt-bindings: iio/adc: Add a compatible string for JZ4770 SoC ADC
      dt-bindings: iio/adc: Add AUX2 channel idx for JZ4770 SoC ADC
      IIO: Ingenic JZ47xx: Add support for JZ4770 SoC ADC.

Baolin Wang (1):
      iio: adc: sc27xx: Use devm_hwspin_lock_request_specific() to simplify code

Bartosz Golaszewski (1):
      iio: pressure: bmp280: remove stray newline

Colin Ian King (3):
      iio: light: cm36651: redundant assignment to variable ret
      counter: stm32: clean up indentation issue
      iio: gyro: clean up indentation issue

Fabrice Gasnier (2):
      counter: stm32-timer-cnt: fix a kernel-doc warning
      counter: stm32-lptimer-cnt: fix a kernel-doc warning

Jean-Baptiste Maneyrol (7):
      iio: imu: inv_mpu6050: disable i2c mux for MPU925x
      iio: imu: inv_mpu6050: add header include protection macro
      iio: imu: inv_mpu6050: add defines for supporting 9-axis chips
      iio: imu: inv_mpu6050: fix objects syntax in Makefile
      iio: imu: inv_mpu6050: helpers for using i2c master on auxiliary bus
      iio: imu: inv_mpu6050: add MPU925x magnetometer support
      iio: imu: inv_mpu6050: add fifo support for magnetometer data

Krzysztof Wilczynski (1):
      iio: light: bh1750: Resolve compiler warning and make code more readable

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: enable LIR for sensor events
      iio: imu: st_lsm6dsx: enable clear on read for latched interrupts

Mircea Caprioru (2):
      iio: adc: ad_sigma_delta: Export ad_sd_calibrate
      staging: iio: adc: ad7192: Add system calibration support

Phil Reid (2):
      dt-binding: iio: Add optional label property
      iio: core: Add optional symbolic label to device attributes

Rohit Sarkar (1):
      staging: iio: ADIS16240: Remove unused include

Sean Nyekjaer (5):
      iio: imu: st_lsm6dsx: move interrupt thread to core
      iio: imu: st_lsm6dsx: add motion events
      iio: imu: st_lsm6dsx: add wakeup-source option
      iio: imu: st_lsm6dsx: always enter interrupt thread
      iio: imu: st_lsm6dsx: add motion report function and call from interrupt

Tomasz Duszynski (2):
      dt-bindings: iio: light: bh1750: convert bindings to yaml
      MAINTAINERS: add entry for ROHM BH1750 driver

 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 |  24 ++
 .../devicetree/bindings/iio/adc/ingenic,adc.txt    |   1 +
 .../devicetree/bindings/iio/iio-bindings.txt       |   5 +
 .../devicetree/bindings/iio/light/bh1750.txt       |  18 -
 .../devicetree/bindings/iio/light/bh1750.yaml      |  43 ++
 MAINTAINERS                                        |   6 +
 drivers/counter/stm32-lptimer-cnt.c                |   2 +-
 drivers/counter/stm32-timer-cnt.c                  |   6 +-
 drivers/iio/adc/ad7949.c                           |  33 +-
 drivers/iio/adc/ad_sigma_delta.c                   |   3 +-
 drivers/iio/adc/ingenic-adc.c                      | 149 +++++--
 drivers/iio/adc/sc27xx_adc.c                       |  16 +-
 drivers/iio/chemical/atlas-ph-sensor.c             |   8 +-
 drivers/iio/gyro/adis16080.c                       |   8 +-
 drivers/iio/gyro/adis16130.c                       |   2 -
 drivers/iio/gyro/adis16136.c                       |  31 +-
 drivers/iio/gyro/itg3200_core.c                    |   2 +-
 drivers/iio/imu/adis.c                             |  95 ++---
 drivers/iio/imu/adis16400.c                        |  61 ++-
 drivers/iio/imu/adis16480.c                        |  17 +-
 drivers/iio/imu/adis_buffer.c                      |   4 +-
 drivers/iio/imu/inv_mpu6050/Makefile               |   7 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c          | 204 ++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h          |  19 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 152 +++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  60 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  70 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         | 356 +++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h         |  36 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  11 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  86 +++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  50 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  78 +---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 434 ++++++++++++++++++++-
 drivers/iio/industrialio-core.c                    |  17 +
 drivers/iio/light/bh1750.c                         |   4 +-
 drivers/iio/light/cm36651.c                        |   2 +-
 drivers/iio/light/tcs3414.c                        |  30 +-
 drivers/iio/pressure/bmp280-core.c                 |   1 -
 drivers/iio/proximity/sx9500.c                     |  16 +-
 drivers/iio/temperature/max31856.c                 |   2 +
 drivers/staging/iio/accel/adis16240.c              |   1 -
 drivers/staging/iio/adc/ad7192.c                   |  79 +++-
 include/dt-bindings/iio/adc/ingenic,adc.h          |   1 +
 include/linux/iio/adc/ad_sigma_delta.h             |   2 +
 include/linux/iio/iio.h                            |   2 +
 include/linux/iio/imu/adis.h                       | 154 +++++++-
 47 files changed, 2082 insertions(+), 326 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.yaml
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
