Return-Path: <linux-iio+bounces-26304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C5C6B1E6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 19:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 667F52A0A9
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956930F52B;
	Tue, 18 Nov 2025 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub72S/9A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F629BD8E
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489427; cv=none; b=U0BvH8D6+cNRn2y+ig3ZNwlhhrR1MONiI/2h5kOyYSI0d8u7qodG6/++kdY/R0y957aYhb+Fm+u6zHewVCLUYtf65BO2cnn3gxGaNBEL9YnDpG7Qy81sjVw9kTWkS1D+77eVb7bhcTlI+YYKl3ozY0RGTDhs/dstHjI5VBD4o+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489427; c=relaxed/simple;
	bh=OpIJGLDRZqnAT53wt4XDvRr7qFYy52quYyHhUMsAK+A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=lgyku6fdFAfgOQ7xCP2Wbqwbf1h8bDMb80A9kfv5VTKIvqzJ/lk8GdcuhI6lk9ohVS+Y8B7wRCpXfrWVs7oKj3BnVRydJJNzaOfdQGxPDChvn1zQzk6pcC/FtFquWKSRh+wHJY8D6XUHeeeKnh4caU/6D29dFjlTSc6Td1nMJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub72S/9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D53C2BCB2;
	Tue, 18 Nov 2025 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763489426;
	bh=OpIJGLDRZqnAT53wt4XDvRr7qFYy52quYyHhUMsAK+A=;
	h=Date:From:To:Subject:From;
	b=Ub72S/9AQSrQ+E+vXh4LHvRbkBmRynlEzHX+eVWskSodP7dafRbitStcFf6FWyhB7
	 eqb3QfHBmtnWQ6Xbs83vkiHo3bgkhMQDGwzS3dUvgpPS4Qegr46ev2Pi4VYqba2SYQ
	 tY6vsJgnkI3Lgsk5uHTI1ttHk21o5QaGd6VQq4yl/wnlNHtpzvaL6zNGrz+lXKABss
	 8XzUx+BqRdl5/QWs7UbQ9bak2tjDKh9WXGPYYp+4vH7gZcSskzNcciH73igXHxD36I
	 vO9tFyeM4/DMn/pgRxiz2NO8LFlzYv0QbceqKwjaMBqbChXzGQ2f/3ZnWRV6aquMtw
	 aRYiJ2u3XAEjw==
Date: Tue, 18 Nov 2025 18:10:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: New device support, features and cleanup for 6.19
Message-ID: <20251118181020.4df5e18c@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.19a

for you to fetch changes up to f9e05791642810a0cf6237d39fafd6fec5e0b4bb:

  staging: iio: adt7316: replace sprintf() with sysfs_emit() (2025-11-16 15=
:25:08 +0000)

----------------------------------------------------------------
IIO: New device support, features and cleanup for 6.19

The usual bunch of new device support, but also quite a bit of cleanup
of the core and older drivers which is always good to see.

New device support
------------------

adi,ad4080
- Add support for AD4081, AD4083, AD4084, AD4086 and AD4087 ADCs with
  slightly different features to existing supported parts (max CNV clock
  count, resolution etc)
adi,adxl380
- Add support for ADXL318 and ADXL319 which have reduced functionality
  compared to other supported parts, particularly around event detection.
aosong,adp810
- New driver for this differential pressure and temperature sensor.
aspeed,adc
- Add support for the AST2700 SoC ADCs which differ in small ways from
  already supported parts.
bosch,sm330
- New driver for this IMU (accelerometer + gyroscop) with I2C and SPI bus
  support.
invensense,icm45600
- New driver for this family of IMUs with sub drivers for accelerometer
  and gyroscope elements. I2C, I3C and SPI busses all supported.
  * Supports ICM45605, ICM45606, ICM45608, ICM45634, ICM45686, ICM45687,
    ICM45688P, ICM45689.
  * Support basic features and FIFO.
maxim,max14001
- New driver for the MAX14001 and MAX14002 ADCs.
renesas,rzt2h
- New driver supporting the RZ/T2H and RZ/N2H ADCs found in various SoCs.
renesas,rznl
- New driver supporting the RZ/NL ADC found in various SoCs.

Features
--------

adi,ad5446
- Add a DT binding doc for the 29 variants currently covered by the driver.
- Add adi,ad5542 which is compatiable with the adi,ad5542a which was
  already supported.
bosch,bma220
- I2C support including an I2C bus watchdog.
- Power supply control
- Data ready trigger.
- Low pass filter control.
- Debugfs register access.
- Add Petre Rodan as a maintainer of this driver (thanks!)
bosch,bmi270
- Add support for motion events.
fsl,mpl3115
- Add a dataready trigger and related sampling frequency control.
- Add threshold events.
infineon,dps310
- Add a specific device tree binding.
maxim,max30100
- Allow control of LED pulse-width in dt-binding. Optimum value depends
  on physical characteristics of the device which contains this sensor.
mediatek,mt2701
- Add dt compatible for the mt8189.
rockchip,saradc
- Add rk3506 compatible which is functionally the same as the already
  supported rk3528 (which is therefore the fallback)
st,lsm6dsx
- Make sampling more flexible when both fifo and events are of interest
  by decoupling the FIFO fill rate from actual sampling.

Cleanup and minor fixes
-----------------------

core
- Document and add might_sleep() to iio_push_to_buffers_with_ts_unaligned()
  as it allocates a buffer, typically just on 1st call.
- Add documentation for iio_push_to_buffers_with_ts() which is being used
  to replace iio_push_to_buffers_with_timestamp() in new code as it
  validates the buffer size.  Make the deprecation of the old function
  clear.
- Document that the store_to() callback in struct iio_buffer_access_funcs
  may be called from contexts that cannot sleep.
- Document that the cb() provided to a callback buffer may be called
  from contexts that cannot sleep.
- Cleanup up industrialio-backend.c comments.
- Call mutex_destroy() in cleanup of buffers.
- Call device_initialize() later to avoid having to call device_put()
  before configuration is otherwise complete.
- Use mutex_init_with_key() to replace opencoded version.
- Use dma_buf_unmap_attachment_unlocked() to replace opencoded version.
- Reorder Makefile for pressure sensors.
various
- Uses sysfs_emit() to replace sprintf() in read_label() and other
  callbacks that typically are used to write data to sysfs buffers.
- Switch to REGCACHE_MAPLE in various drivers.
adi,docs
- Fix up formatting of cross references and other kernel-doc issues.
adi,ad4080
- Fix wrong masking of product IDs.
adi,ad5446
- Use DMA safe buffers as needed for SPI.
- Drop a duplicate device chip specific data structure where two parts
  are functionally identical.
- Fail probe if reference is not available.
- Split up the massive array of chip type specific structures into
  separate structures as this tends to be easier to read and maintain.
- Add explicit of_device_id entries for all supported parts.
- Split I2C and SPI parts away from core to avoid ifdef complexity.
- Switch to devm_mutex_init().
- Make use of guard() to simplify code.
- Applying IWYU principles and reorder headers.
- Various other minor cleanup.
adi,ad7124
- Add debugfs to support single cycle mode, typically only used for cases
  such as validate performance of the ADC.
- Various other minor cleanup including removing some layers of indirection
  that weren't necessary.
- Add extended attributes to the temperature channel which follows the same
  signal path as other channels.
- Replace the setup register allocation strategy with a simpler more
  predictable one (a fix for OOB from this code follows later in this pull
  request).
adi,adxl345
- Ensure dt-binding allows for both interrupt wired at the same time.
arm,scmi
- Replace const_ilog2() with the resulting value which ends up simpler
  to read.
bosch,bma220
- Add correct SPI mode specification to the device tree binding.
- Fix up interrupt type in dt binding example to match that the driver
  expects.
- Relax hard constraint on matching chip ID with a message only so as to
  enable fallback DT compatibles to work.
- Use local struct device *dev to replaces lots of indirect look ups.
- Improve includes on approximate IWYU basis.
- Explicit of_match_table.
- Reset some registers during probe.
- Move to regmap.
- Ensure a timestamp is available when filling the buffer by using a
  locally acquired one rather than relying on trigger top half running.
- Add a utility function to search value pair tables for a match.
- Various other minor improvements.
- Move code to avoid a false dependency of the core code on the I2C module.
bosch,bma400
- Improve register and field naming + organization. Use with FIELD_GET()
  and FIELD_PREP() to allow dropping of shift defines.
- Use macros to define event related fields.
- Switch to an address lookup based on an index variable to replace lots of
  very similar register macros.
- Rename activity_event_en() to generic_event_en() to better reflect what
  it does.
- Improve comments around interrupt register handling.
fsl,mpl3115
- Factor out code for triggered buffer data collection.
- Use more consistent register field naming style.
- Use get_unaligned_be24() to get the pressure.
invensense,mpu6050
- Drop false requirement in DT binding for the interrupt. The driver will
  be able to do less if one is not provided, but some features are still
  available.
invensense,icm45600_i3c
- Fix missing return on failure to match part.
linear,ltc2688
- Use devm_mutex_init() so mutex_destroy() is called in tear down path.
- Use guard() to simplify lock handling in error return paths.
qcom,vadc
- Fix up some kernel-doc related warnings.
rohm,bd79112 and bd79124
- Use regmap_reg_range() helper to set the ranges.
st,lsm6dsx
- Fix units of ODR in structure documentation.
ti,am335x
- Add range checks to avoid a compiler warning.
ti,pac1934
- Switch to system_percpu_wq.

Various other minor typo fixes etc.

----------------------------------------------------------------
Akhilesh Patil (3):
      dt-bindings: iio: pressure: Add Aosong adp810
      iio: pressure: adp810: Add driver for adp810 sensor
      iio: pressure: Arrange Makefile alphabetically

Akshay Jindal (6):
      iio: accel: bma400: Reorganize and rename register and field macros
      iio: accel: bma400: Use macros for generic event configuration values
      iio: accel: bma400: Use index-based register addressing and lookup
      iio: accel: bma400: Replace bit shifts with FIELD_PREP() and FIELD_GE=
T()
      iio: accel: bma400: Rename activity_event_en() to generic_event_en()
      iio: accel: bma400: Add detail to comments in GEN INTR configuration

Andy Shevchenko (4):
      iio: common: scmi_sensors: Get rid of const_ilog2()
      iio: core: add missing mutex_destroy in iio_dev_release()
      iio: core: Clean up device correctly on iio_device_alloc() failure
      iio: core: Replace lockdep_set_class() + mutex_init() by combined call

Antoni Pokusinski (8):
      dt-bindings: iio: pressure: add binding for mpl3115
      iio: mpl3115: add separate function for triggered buffer data collect=
ion
      iio: mpl3115: rename CTRL_REG1 field macros
      iio: mpl3115: add support for DRDY interrupt
      iio: mpl3115: add support for sampling frequency
      iio: mpl3115: use get_unaligned_be24() to retrieve pressure data
      iio: mpl3115: add threshold events support
      iio: ABI: document pressure event attributes

Antoniu Miclaus (12):
      iio: adc: ad4080: fix chip identification
      iio: adc: ad4080: prepare driver for multi-part support
      dt-bindings: iio: adc: adi,ad4080: add support for AD4084
      iio: adc: ad4080: add support for AD4084
      dt-bindings: iio: adc: adi,ad4080: add support for AD4081
      iio: adc: ad4080: add support for AD4081
      dt-bindings: iio: adc: adi,ad4080: add support for AD4083
      iio: adc: ad4080: add support for AD4083
      dt-bindings: iio: adc: adi,ad4080: add support for AD4086
      iio: adc: ad4080: add support for AD4086
      dt-bindings: iio: adc: adi,ad4080: add support for AD4087
      iio: adc: ad4080: add support for AD4087

Bagas Sanjaya (1):
      Documentation: iio: ade9000, adis*, adx*: Convert IIO subsystem cross=
-references

Billy Tsai (2):
      dt-bindings: iio: adc: Add AST2700 ADC compatible strings
      iio: adc: aspeed: Add AST2700 ADC support

Chu Guangqing (4):
      iio: adc: ade9000: convert to use maple tree register cache
      iio: light: veml3235: convert to use maple tree register cache
      iio: light: apds9306: convert to use maple tree register cache
      iio: light: apds9960: convert to use maple tree register cache

Cosmin Tanislav (2):
      dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
      iio: adc: add RZ/T2H / RZ/N2H ADC driver

Dan Carpenter (1):
      iio: imu: inv_icm45600: Add a missing return statement in probe()

David Lechner (16):
      iio: adc: ad7124: add debugfs to disable single cycle mode
      iio: adc: ad7124: inline ad7124_enable_channel()
      iio: adc: ad7124: remove unused `nr` field
      iio: adc: ad7124: use AD7124_MAX_CHANNELS
      iio: adc: ad7124: use devm_mutex_init()
      iio: adc: ad7124: remove __ad7124_set_channel()
      iio: buffer: document iio_push_to_buffers_with_ts_unaligned() may sle=
ep
      iio: buffer: iio_push_to_buffers_with_ts_unaligned() might_sleep()
      iio: buffer: document iio_push_to_buffers_with_ts()
      iio: buffer: deprecated iio_push_to_buffers_with_timestamp()
      iio: buffer: document iio_push_to_buffers() calling context
      iio: buffer: document store_to() callback may be called in any context
      iio: buffer: document that buffer callback must be context safe
      iio: adc: ad7124: add ext attributes to temperature channel
      iio: adc: ad7124: change setup reg allocation strategy
      iio: adc: ad7124: fix possible OOB array access

Dixit Parmar (1):
      iio: adc: ti-ads131e08: return correct error code

Eddie James (1):
      dt-bindings: iio: Add Infineon DPS310 sensor documentation

Francesco Lavra (2):
      iio: imu: st_lsm6dsx: Fix measurement unit for odr struct member
      iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate

Frank Li (1):
      dt-bindings: iio: imu: mpu6050: remove interrupts from required list

Gustavo Silva (2):
      iio: imu: bmi270: add support for motion events
      iio: ABI: document accelerometer event attributes

Heiko Stuebner (1):
      dt-bindings: iio: adc: Add rockchip,rk3506-saradc variant

Herve Codina (Schneider Electric) (3):
      dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
      iio: adc: Add support for the Renesas RZ/N1 ADC
      MAINTAINERS: Add the Renesas RZ/N1 ADC driver entry

Jack Hsu (1):
      dt-bindings: iio: adc: Support MediaTek MT8189 evb board auxadc

Jianping Shen (2):
      dt-bindings: iio: imu: smi330: Add binding
      iio: imu: smi330: Add driver

Jonathan Santos (2):
      dt-bindings: iio: accel: adxl380: add new supported parts
      iio: accel: adxl380: add support for ADXL318 and ADXL319

Kriish Sharma (1):
      iio: backend: fix kernel-doc to avoid warnings and ensure consistency

Liang Jie (1):
      iio: buffer: use dma_buf_unmap_attachment_unlocked() helper

Marco Crivellari (1):
      iio: adc: pac1934: replace use of system_wq with system_percpu_wq

Marilene Andrade Garcia (2):
      dt-bindings: iio: adc: add max14001
      iio: adc: max14001: New driver

Matti Vaittinen (2):
      iio: adc: rohm-bd79112: Use regmap_reg_range()
      iio: adc: rohm-bd79124: Use regmap_reg_range()

Michael Hennerich (1):
      iio: dac: ad5446: Add AD5542 to the spi id table

Nuno S=C3=A1 (22):
      iio: dac: ltc2688: make use of devm_mutex_init()
      iio: adc: ad4030: replace sprintf() with sysfs_emit()
      iio: adc: ad7768-1: replace sprintf() with sysfs_emit()
      iio: adc: mcp3564: replace sprintf() with sysfs_emit()
      iio: adc: meson_saradc: replace sprintf() with sysfs_emit()
      iio: adc: mt6360-adc: replace snprintf() with sysfs_emit()
      iio: adc: pac1921: replace sprintf() with sysfs_emit()
      iio: adc: qcom-spmi-rradc: replace snprintf() with sysfs_emit()
      iio: position: hid-sensor-custom-intel-hinge: replace sprintf() with =
sysfs_emit()
      iio: resolver: ad2s1210: replace sprintf() with sysfs_emit()
      iio: dac: ltc2688: use the auto lock API
      dt-bindings: iio: dac: Document AD5446 and similar devices
      iio: dac: ad5446: Use DMA safe buffer for transfers
      iio: dac: ad5446: Drop duplicated spi_id entry
      iio: dac: ad5446: Don't ignore missing regulator
      iio: dac: ad5446: Move to single chip_info structures
      iio: dac: ad5456: Add missing DT compatibles
      iio: dac: ad5446: Separate I2C/SPI into different drivers
      iio: dac: ad5446: Make use of devm_mutex_init()
      iio: dac: ad5446: Make use of the cleanup helpers
      iio: dac: ad5446: Refactor header inclusion
      iio: dac: ad5446: Fix coding style issues

Pei Xiao (1):
      iio: adc: ti_am335x_adc: Limit step_avg to valid range for gcc compla=
ins

Petre Rodan (25):
      dt-bindings: iio: accel: bosch,bma220 cleanup typo
      dt-bindings: iio: accel: bosch,bma220 setup SPI clock mode
      dt-bindings: iio: accel: bosch,bma220 set irq type in example block
      iio: accel: bma220: remove incorrect kernel-doc marking
      iio: accel: bma220: relax constraints during probe()
      iio: accel: bma220: cleanup license string
      iio: accel: bma220: shorten spi->dev calls
      iio: accel: bma220: move bma220_power function
      iio: accel: bma220: cleanup includes
      iio: accel: bma220: split original driver
      iio: accel: bma220: add open firmware table
      iio: accel: bma220: turn power supplies on
      iio: accel: bma220: reset registers during init stage
      iio: accel: bma220: migrate to regmap API
      iio: accel: bma220: populate buffer ts in trigger handler
      iio: accel: bma220: use find_match_table fct
      iio: accel: bma220: add i2c module
      iio: accel: bma220: add i2c watchdog feature
      iio: accel: bma220: add interrupt trigger
      iio: accel: bma220: add LPF cut-off frequency mapping
      iio: accel: bma220: add debugfs reg access
      iio: accel: bma220: add maintainer
      iio: accel: bma220: white space cleanup
      iio: accel: bma220: remove useless include
      iio: accel: bma220: move set_wdt() out of bma220_core

Randy Dunlap (2):
      iio: adc: qcom-vadc-common: fix vadc_scale_fn_type kernel-doc
      iio: imu: adis: fix all kernel-doc warnings in header file

Remi Buisson (10):
      dt-bindings: iio: imu: Add inv_icm45600
      iio: imu: inv_icm45600: add new inv_icm45600 driver
      iio: imu: inv_icm45600: add buffer support in iio devices
      iio: imu: inv_icm45600: add IMU IIO gyroscope device
      iio: imu: inv_icm45600: add IMU IIO accelerometer device
      iio: imu: inv_icm45600: add I2C driver for inv_icm45600 driver
      iio: imu: inv_icm45600: add SPI driver for inv_icm45600 driver
      iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver
      MAINTAINERS: add entry for inv_icm45600 6-axis imu sensor
      iio: imu: inv_icm45600: Initializes inv_icm45600_buffer_postdisable()=
 sleep

Rodrigo Gobbi (1):
      iio: imu: bmi270: fix dev_err_probe error msg

Sameeksha Sankpal (1):
      iio: light: ltr390: Fix typo in variable name

Shi Hao (1):
      staging: iio: adt7316: replace sprintf() with sysfs_emit()

Shrikant Raskar (2):
      dt-bindings: iio: health: max30100: Add LED pulse-width property
      iio: health: max30100: Make LED pulse-width configurable via DT

Taimoor Zaeem (1):
      staging: iio: ad9834: remove empty ad9834.h file

Wolfram Sang (1):
      dt-bindings: iio: accel: adxl345: document second interrupt

 Documentation/ABI/testing/sysfs-bus-iio            |  36 +
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |  11 +-
 .../devicetree/bindings/iio/accel/adi,adxl380.yaml |  11 +-
 .../bindings/iio/accel/bosch,bma220.yaml           |   9 +-
 .../devicetree/bindings/iio/adc/adi,ad4080.yaml    |   5 +
 .../devicetree/bindings/iio/adc/adi,max14001.yaml  |  89 ++
 .../bindings/iio/adc/aspeed,ast2600-adc.yaml       |   2 +
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |   1 +
 .../bindings/iio/adc/renesas,r9a09g077-adc.yaml    | 135 +++
 .../bindings/iio/adc/renesas,rzn1-adc.yaml         | 111 +++
 .../bindings/iio/adc/rockchip-saradc.yaml          |   3 +
 .../devicetree/bindings/iio/dac/adi,ad5446.yaml    | 138 +++
 .../bindings/iio/health/maxim,max30100.yaml        |   8 +
 .../devicetree/bindings/iio/imu/bosch,smi330.yaml  |  90 ++
 .../bindings/iio/imu/invensense,icm45600.yaml      |  90 ++
 .../bindings/iio/imu/invensense,mpu6050.yaml       |   1 -
 .../bindings/iio/pressure/aosong,adp810.yaml       |  45 +
 .../bindings/iio/pressure/fsl,mpl3115.yaml         |  71 ++
 .../bindings/iio/pressure/infineon,dps310.yaml     |  54 ++
 .../devicetree/bindings/trivial-devices.yaml       |   4 -
 Documentation/iio/ade9000.rst                      |   2 +-
 Documentation/iio/adis16475.rst                    |   4 +-
 Documentation/iio/adis16480.rst                    |   4 +-
 Documentation/iio/adis16550.rst                    |   4 +-
 Documentation/iio/adxl345.rst                      |   4 +-
 Documentation/iio/adxl380.rst                      |   4 +-
 MAINTAINERS                                        |  59 ++
 drivers/iio/accel/Kconfig                          |  19 +-
 drivers/iio/accel/Makefile                         |   4 +-
 drivers/iio/accel/adxl380.c                        | 134 ++-
 drivers/iio/accel/adxl380.h                        |   4 +
 drivers/iio/accel/adxl380_i2c.c                    |   4 +
 drivers/iio/accel/adxl380_spi.c                    |   4 +
 drivers/iio/accel/bma220.h                         |  28 +
 drivers/iio/accel/bma220_core.c                    | 585 ++++++++++++
 drivers/iio/accel/bma220_i2c.c                     |  69 ++
 drivers/iio/accel/bma220_spi.c                     | 318 +------
 drivers/iio/accel/bma400.h                         | 155 ++--
 drivers/iio/accel/bma400_core.c                    | 349 ++++----
 drivers/iio/adc/Kconfig                            |  31 +
 drivers/iio/adc/Makefile                           |   3 +
 drivers/iio/adc/ad4030.c                           |   4 +-
 drivers/iio/adc/ad4080.c                           | 126 ++-
 drivers/iio/adc/ad7124.c                           | 295 +++---
 drivers/iio/adc/ad7768-1.c                         |   2 +-
 drivers/iio/adc/ade9000.c                          |   2 +-
 drivers/iio/adc/aspeed_adc.c                       |  34 +
 drivers/iio/adc/max14001.c                         | 391 ++++++++
 drivers/iio/adc/mcp3564.c                          |   2 +-
 drivers/iio/adc/meson_saradc.c                     |   6 +-
 drivers/iio/adc/mt6360-adc.c                       |   2 +-
 drivers/iio/adc/pac1921.c                          |   8 +-
 drivers/iio/adc/pac1934.c                          |   2 +-
 drivers/iio/adc/qcom-spmi-rradc.c                  |   2 +-
 drivers/iio/adc/rohm-bd79112.c                     |  13 +-
 drivers/iio/adc/rohm-bd79124.c                     |  39 +-
 drivers/iio/adc/rzn1-adc.c                         | 490 ++++++++++
 drivers/iio/adc/rzt2h_adc.c                        | 304 +++++++
 drivers/iio/adc/ti-ads131e08.c                     |   2 +-
 drivers/iio/adc/ti_am335x_adc.c                    |   2 +-
 drivers/iio/buffer/industrialio-buffer-cb.c        |   1 +
 drivers/iio/common/scmi_sensors/scmi_iio.c         |   5 +-
 drivers/iio/dac/Kconfig                            |  31 +-
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/ad5446-i2c.c                       | 102 +++
 drivers/iio/dac/ad5446-spi.c                       | 252 ++++++
 drivers/iio/dac/ad5446.c                           | 506 ++---------
 drivers/iio/dac/ad5446.h                           |  77 ++
 drivers/iio/dac/ltc2688.c                          |  32 +-
 drivers/iio/health/max30100.c                      |  38 +-
 drivers/iio/imu/Kconfig                            |   2 +
 drivers/iio/imu/Makefile                           |   2 +
 drivers/iio/imu/bmi270/bmi270_core.c               | 383 +++++++-
 drivers/iio/imu/bmi270/bmi270_spi.c                |   2 +-
 drivers/iio/imu/inv_icm45600/Kconfig               |  70 ++
 drivers/iio/imu/inv_icm45600/Makefile              |  16 +
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        | 385 ++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c  | 782 ++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c | 558 ++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h | 101 +++
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c   | 988 +++++++++++++++++=
++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c   | 791 +++++++++++++++++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c    |  98 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c    |  79 ++
 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c    | 108 +++
 drivers/iio/imu/smi330/Kconfig                     |  33 +
 drivers/iio/imu/smi330/Makefile                    |   7 +
 drivers/iio/imu/smi330/smi330.h                    |  25 +
 drivers/iio/imu/smi330/smi330_core.c               | 918 +++++++++++++++++=
++
 drivers/iio/imu/smi330/smi330_i2c.c                | 133 +++
 drivers/iio/imu/smi330/smi330_spi.c                |  85 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  71 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   2 +
 drivers/iio/industrialio-backend.c                 |   8 +-
 drivers/iio/industrialio-buffer.c                  |  12 +-
 drivers/iio/industrialio-core.c                    |  18 +-
 drivers/iio/light/apds9306.c                       |   2 +-
 drivers/iio/light/apds9960.c                       |   2 +-
 drivers/iio/light/ltr390.c                         |   8 +-
 drivers/iio/light/veml3235.c                       |   2 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |   2 +-
 drivers/iio/pressure/Kconfig                       |  12 +
 drivers/iio/pressure/Makefile                      |   8 +-
 drivers/iio/pressure/adp810.c                      | 225 +++++
 drivers/iio/pressure/mpl3115.c                     | 549 +++++++++++-
 drivers/iio/resolver/ad2s1210.c                    |  30 +-
 drivers/staging/iio/addac/adt7316.c                | 102 +--
 drivers/staging/iio/frequency/ad9834.c             |   3 +-
 drivers/staging/iio/frequency/ad9834.h             |  10 -
 include/linux/iio/adc/qcom-vadc-common.h           |  27 +-
 include/linux/iio/buffer.h                         |  22 +-
 include/linux/iio/buffer_impl.h                    |   3 +-
 include/linux/iio/consumer.h                       |   3 +-
 include/linux/iio/imu/adis.h                       |  45 +-
 116 files changed, 10724 insertions(+), 1493 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09=
g077-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzn1-=
adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5446.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi330.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,ic=
m45600.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/aosong,a=
dp810.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3=
115.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon=
,dps310.yaml
 create mode 100644 drivers/iio/accel/bma220.h
 create mode 100644 drivers/iio/accel/bma220_core.c
 create mode 100644 drivers/iio/accel/bma220_i2c.c
 create mode 100644 drivers/iio/adc/max14001.c
 create mode 100644 drivers/iio/adc/rzn1-adc.c
 create mode 100644 drivers/iio/adc/rzt2h_adc.c
 create mode 100644 drivers/iio/dac/ad5446-i2c.c
 create mode 100644 drivers/iio/dac/ad5446-spi.c
 create mode 100644 drivers/iio/dac/ad5446.h
 create mode 100644 drivers/iio/imu/inv_icm45600/Kconfig
 create mode 100644 drivers/iio/imu/inv_icm45600/Makefile
 create mode 100644 drivers/iio/imu/inv_icm45600/inv_icm45600.h
 create mode 100644 drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c
 create mode 100644 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.c
 create mode 100644 drivers/iio/imu/inv_icm45600/inv_icm45600_buffer.h
 create mode 100644 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
 create mode 100644 drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c
 create mode 100644 drivers/iio/imu/inv_icm45600/inv_icm45600_i2c.c
 create mode 100644 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
 create mode 100644 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c
 create mode 100644 drivers/iio/imu/smi330/Kconfig
 create mode 100644 drivers/iio/imu/smi330/Makefile
 create mode 100644 drivers/iio/imu/smi330/smi330.h
 create mode 100644 drivers/iio/imu/smi330/smi330_core.c
 create mode 100644 drivers/iio/imu/smi330/smi330_i2c.c
 create mode 100644 drivers/iio/imu/smi330/smi330_spi.c
 create mode 100644 drivers/iio/pressure/adp810.c
 delete mode 100644 drivers/staging/iio/frequency/ad9834.h

