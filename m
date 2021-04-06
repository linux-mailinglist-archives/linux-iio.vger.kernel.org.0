Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8D3355D9F
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 23:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbhDFVFu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 17:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343556AbhDFVFt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Apr 2021 17:05:49 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B681613CD;
        Tue,  6 Apr 2021 21:05:40 +0000 (UTC)
Date:   Tue, 6 Apr 2021 22:05:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO features and cleanup etc for 5.13
Message-ID: <20210406220555.0d6bc9b6@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 9c15db92a8e56bcde0f58064ac1adc28c0579b51:

  Merge tag 'iio-for-5.13a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2021-03-26 12:09:47 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.13b

for you to fetch changes up to eaec775ae6ae9c72c3cb320bb2d2990fdf2263d8:

  iio: inv_mpu6050: Fully validate gyro and accel scale writes (2021-04-06 19:11:55 +0100)

----------------------------------------------------------------
2nd set of IIO features, cleanups etc for 5.13

A few of these are fixes for major rework earlier in cycle.
Bulk of patches are the ad7150 pre graduation cleanup, some link
fixes in maintainers and set using the new IRQF_NO_AUTOEN flag.

Note includes a merge of a tag from tip to get the IRQF_NO_AUTOEN
support (one patch only from Barry Song)

Staging graduation
* adi,ad7150 CDC
  - A lot of precursor patches cleaning it up first.
  - Includes core support for timeout event ABI where after a time
    a adaptive threshold jumps to fix slow tracking problems.

Cleanups and minor / late breaking fixes
* core
  - Use sysfs_emit() and sysfs_emit_at() as appropriate
  - Fix a bug introduced in this cycle for iio_read_channel_processed_scale()
  - Fix handling of getfd ioctl as IIO_IOCTL_UNHANDLED is a valid ioctl number
  - Tidy up some pointless type conversion in string formatting and odd
    indentation.
* dac
  - Use sysfs_emit() for powerdown attribute show() functions.
* docs
  - Fix dead links due to txt to yaml binding conversions.
* treewide
  - Use IRQF_NO_AUTOEN
* various
  - Typo fixes in comments.
* triggers/hr-timer-trigger
  - Fix an overflow handing issue.
* ad,ad7923
  - Device managed functions in probe()
* ad,ad9467
  - Fix kconfig dependency issue
* adi,adis16201
  - Fix a wrong axis assignment that stops the driver loading.
* invensense,mpu6050
  - Allow use as a standalone trigger (no channels enabled)
  - Drop unnecessary manual assignment of indio_dev->modes
  - Make device function in a basic way if no interrupt wired.
  - Sanity check scale writes.
* semtech,sx9310
  - Fix access to a variable length array in DT binding.
  - Sanity check input before writing debounce register.
* st,stm32-dfsdm
  - Drop __func__ from dev_dbg() and pr_debug().
* yamaha,yas530
  - Include asm/unaligned.h instead of be_byteshift.h
  - Fix an issue with return value on an error path.

----------------------------------------------------------------
Alexandru Ardelean (3):
      iio: buffer: return 0 for buffer getfd ioctl handler
      iio: buffer: use sysfs_attr_init() on allocated attrs
      iio: adc: Kconfig: make AD9467 depend on ADI_AXI_ADC symbol

Andy Shevchenko (2):
      iio: trigger: Replace explicit casting and wrong specifier with proper one
      iio: trigger: Fix strange (ladder-type) indentation

Barry Song (1):
      genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()

Bhaskar Chowdhury (1):
      iio: dac: Rudimentary typo fix

Guoqing Chi (1):
      iio:imu:mpu6050: Modify matricies to matrices

Gustavo A. R. Silva (1):
      iio: hrtimer-trigger: Fix potential integer overflow in iio_hrtimer_store_sampling_frequency

Gwendal Grignou (2):
      iio: sx9310: Fix access to variable DT array
      iio: sx9310: Fix write_.._debounce()

Jonathan Cameron (37):
      iio:accel:adis16201: Fix wrong axis assignment that prevents loading
      staging:iio:cdc:ad7150: use swapped reads/writes for i2c rather than open coding
      staging:iio:cdc:ad7150: Remove magnitude adaptive events
      staging:iio:cdc:ad7150: Refactor event parameter update
      staging:iio:cdc:ad7150: Timeout register covers both directions so both need updating
      staging:iio:cdc:ad7150: Drop platform data support
      staging:iio:cdc:ad7150: Handle variation in chan_spec across device and irq present or not
      staging:iio:cdc:ad7150: Simplify event handling by only using rising direction.
      staging:iio:cdc:ad7150: Drop noisy print in probe
      staging:iio:cdc:ad7150: Add sampling_frequency support
      iio:event: Add timeout event info type
      staging:iio:cdc:ad7150: Change timeout units to seconds and use core support
      staging:iio:cdc:ad7150: Rework interrupt handling.
      staging:iio:cdc:ad7150: More consistent register and field naming
      staging:iio:cdc:ad7150: Reorganize headers.
      staging:iio:cdc:ad7150: Tidy up local variable positioning.
      staging:iio:cdc:ad7150: Drop unnecessary block comments.
      staging:iio:cdc:ad7150: Shift the _raw readings by 4 bits.
      staging:iio:cdc:ad7150: Add scale and offset to info_mask_shared_by_type
      staging:iio:cdc:ad7150: Really basic regulator support.
      staging:iio:cdc:ad7150: Add of_match_table
      iio:Documentation:ABI Add missing elements as used by the adi,ad7150
      staging:iio:cdc:ad7150: Add copyright notice given substantial changes.
      dt-bindings:iio:cdc:adi,ad7150 binding doc
      iio:cdc:ad7150: Move driver out of staging.
      iio:adc: Drop false comment about lack of timestamp control
      Merge tag 'irq-no-autoen-2021-03-25' into togreg
      iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce boilerplate
      iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag rather than separate irq_disable()
      iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of request then disable
      iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag instead of request then disable
      iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq request then disable
      iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq request then disable
      iio:adc:ad_sigma_delta: Use IRQF_NO_AUTOEN rather than request and disable
      iio:adc:ad7476: Fix remove handling
      iio:adc: Fix trivial typo
      iio:cdc:ad7150: Fix use of uninitialized ret

Lars-Peter Clausen (7):
      iio: core: Use sysfs_emit() (trivial bits)
      iio: iio_enum_available_read(): Convert to sysfs_emit_at()
      iio: __iio_format_value(): Convert to sysfs_emit_at()
      iio: dac: Convert powerdown read callbacks to sysfs_emit()
      iio: inv_mpu6050: Remove superfluous indio_dev->modes assignment
      iio: inv_mpu6050: Make interrupt optional
      iio: inv_mpu6050: Fully validate gyro and accel scale writes

Linus Walleij (4):
      iio: imu: inv_mpu6050: Use as standalone trigger
      iio: Fix iio_read_channel_processed_scale()
      iio: magnetometer: yas530: Fix return value on error path
      iio: magnetometer: yas530: Include right header

Lucas Stankus (3):
      iio: adc: ad7923: use devm_add_action_or_reset for regulator disable
      iio: adc: ad7923: use device-managed function for triggered buffer
      iio: adc: ad7923: register device with devm_iio_device_register

Mauro Carvalho Chehab (14):
      MAINTAINERS: update adi,ad5758.yaml reference
      MAINTAINERS: update st,hts221.yaml reference
      MAINTAINERS: update dpot-dac.yaml reference
      MAINTAINERS: update envelope-detector.yaml reference
      MAINTAINERS: update current-sense-amplifier.yaml reference
      MAINTAINERS: update current-sense-shunt.yaml reference
      MAINTAINERS: update voltage-divider.yaml reference
      MAINTAINERS: update atmel,sama5d2-adc.yaml reference
      MAINTAINERS: update pni,rm3100.yaml reference
      MAINTAINERS: update renesas,rcar-gyroadc.yaml reference
      MAINTAINERS: update st,lsm6dsx.yaml reference
      MAINTAINERS: update st,vl53l0x.yaml reference
      MAINTAINERS: update ti,dac7612.yaml reference
      dt-bindings:iio:dac: update microchip,mcp4725.yaml reference

Mugilraj Dhavachelvan (1):
      iio: adc: stm32-dfsdm: drop __func__ while using Dynamic debug

 Documentation/ABI/testing/sysfs-bus-iio            |  33 +
 .../devicetree/bindings/iio/cdc/adi,ad7150.yaml    |  69 +++
 MAINTAINERS                                        |  26 +-
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/accel/adis16201.c                      |   2 +-
 drivers/iio/adc/Kconfig                            |   4 +-
 drivers/iio/adc/ad7298.c                           |   6 -
 drivers/iio/adc/ad7476.c                           |  18 +-
 drivers/iio/adc/ad7766.c                           |  15 +-
 drivers/iio/adc/ad7887.c                           |   6 -
 drivers/iio/adc/ad7923.c                           |  47 +-
 drivers/iio/adc/ad799x.c                           |   6 -
 drivers/iio/adc/ad_sigma_delta.c                   |   7 +-
 drivers/iio/adc/exynos_adc.c                       |   4 +-
 drivers/iio/adc/nau7802.c                          |   6 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  10 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |   4 +-
 drivers/iio/cdc/Kconfig                            |  17 +
 drivers/iio/cdc/Makefile                           |   6 +
 drivers/iio/cdc/ad7150.c                           | 673 +++++++++++++++++++++
 drivers/iio/chemical/scd30_core.c                  |  16 +-
 drivers/iio/dac/ad5064.c                           |   2 +-
 drivers/iio/dac/ad5360.c                           |   2 +-
 drivers/iio/dac/ad5380.c                           |   2 +-
 drivers/iio/dac/ad5446.c                           |   2 +-
 drivers/iio/dac/ad5504.c                           |   4 +-
 drivers/iio/dac/ad5624r_spi.c                      |   4 +-
 drivers/iio/dac/ad5686.c                           |   2 +-
 drivers/iio/dac/ad5755.c                           |   4 +-
 drivers/iio/dac/ad5758.c                           |   2 +-
 drivers/iio/dac/ad5766.c                           |   2 +-
 drivers/iio/dac/ad5770r.c                          |   2 +-
 drivers/iio/dac/ad5791.c                           |   2 +-
 drivers/iio/dac/ad7303.c                           |   2 +-
 drivers/iio/dac/ltc2632.c                          |   4 +-
 drivers/iio/dac/max5821.c                          |   2 +-
 drivers/iio/dac/mcp4725.c                          |   2 +-
 drivers/iio/dac/stm32-dac.c                        |   2 +-
 drivers/iio/dac/ti-dac082s085.c                    |   2 +-
 drivers/iio/dac/ti-dac5571.c                       |   2 +-
 drivers/iio/dac/ti-dac7311.c                       |   2 +-
 drivers/iio/imu/adis16460.c                        |   4 +-
 drivers/iio/imu/adis16475.c                        |   5 +-
 drivers/iio/imu/adis_trigger.c                     |  11 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  72 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  10 +
 drivers/iio/industrialio-buffer.c                  |  23 +-
 drivers/iio/industrialio-core.c                    |  70 +--
 drivers/iio/industrialio-event.c                   |   3 +-
 drivers/iio/industrialio-trigger.c                 |  32 +-
 drivers/iio/inkern.c                               |   2 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |   4 +-
 drivers/iio/proximity/sx9310.c                     |  52 +-
 drivers/iio/trigger/iio-trig-hrtimer.c             |   2 +-
 drivers/staging/iio/cdc/Kconfig                    |  10 -
 drivers/staging/iio/cdc/Makefile                   |   3 +-
 drivers/staging/iio/cdc/ad7150.c                   | 655 --------------------
 include/linux/iio/dac/mcp4725.h                    |   2 +-
 include/linux/iio/types.h                          |   1 +
 include/linux/interrupt.h                          |   4 +
 include/linux/platform_data/invensense_mpu6050.h   |   2 +-
 kernel/irq/manage.c                                |  11 +-
 63 files changed, 1077 insertions(+), 926 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
 create mode 100644 drivers/iio/cdc/Kconfig
 create mode 100644 drivers/iio/cdc/Makefile
 create mode 100644 drivers/iio/cdc/ad7150.c
 delete mode 100644 drivers/staging/iio/cdc/ad7150.c
