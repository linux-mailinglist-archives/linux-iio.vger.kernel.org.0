Return-Path: <linux-iio+bounces-21762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C369B09BCE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 08:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BF61C26EA3
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5971620B7F4;
	Fri, 18 Jul 2025 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/KyNeBM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19647191F91
	for <linux-iio@vger.kernel.org>; Fri, 18 Jul 2025 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752821782; cv=none; b=SJlT1kfkt4ngxsR5b5pRsqGejDcA1c/N2Kk01QQ8hnSHX5/EWAbIbOtGktIOjyFOMa/c/CzmaBz8fkwwX6Gyj+kMkkT1dzu9OyG2CUKjUhzhPWzNY4BoN5sKcBn0JY74/IjVL3sQzpejCeLoyewoQyccl2uOiRgolm8ynq4T0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752821782; c=relaxed/simple;
	bh=J+3ZsPGtuOO4kWrAjQdfij0prek4fOSM/cJiJGwzaFU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=oNiitaGLjwwRuRb5ZDLdn1GJiWCkLfHoLFwlUXQyK1sCsMPxP3eq5wBca1xXNB8HkUYEAW5JsbsfEXFfzBmVHQ4257PvSuFTeFFJvOIfsB/tl3/tX4lTxR43m5umrIbykDQw5yJHOdJAz7Kj5Geqf6YioTY+le2/UsTWPAHdj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/KyNeBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029B9C4CEED;
	Fri, 18 Jul 2025 06:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752821780;
	bh=J+3ZsPGtuOO4kWrAjQdfij0prek4fOSM/cJiJGwzaFU=;
	h=Date:From:To:Subject:From;
	b=C/KyNeBMszfhtbiGIJektTDWwaDrh7Gy6MZeoukohoFMFuDitOR4nzOBn6zW1Ae/n
	 Dg/0mqI44xGh9QLOwIGxWN7fFt0PG2rdzP9fcYDGYy0LVtmZaeaPDb+69YHSkiHzq5
	 zrB56XLx93XKcXM5TruTalsvX01x+rf3e8xTHvfYk8yO2FoOyJRLHqVAZuqL35AxBO
	 CflMz4pfAYsRtYEZAn1yiuIZHHmRYfoFZPqUFDaj+955GqMHywhnqFMZS2Fn7iyG4m
	 8FPzcFweg/MfPSRI5rjM8ER8knu/+j/fhisWKK2mkmRf+hR4czc4wXtzib8sw1YHRn
	 +XfIArNxP/09A==
Date: Fri, 18 Jul 2025 07:56:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: New driver support, features etc for 6.17
Message-ID: <20250718075616.5c79192f@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.17a

for you to fetch changes up to 0a686b9c4f847dc21346df8e56d5b119918fefef:

  iio: adc: ad_sigma_delta: Select IIO_BUFFER_DMAENGINE and SPI_OFFLOAD (2025-07-16 08:50:41 +0100)

----------------------------------------------------------------
IIO: New device support, features, late breaking fixes and cleanup for 6.17

The normal mixed bag. A few more fixes than usual as I failed to send
them out earlier.

New device support
==================

adi,ad4080
- New driver for this high speed ADC. Includes extensions to iio-backends
  necessary to support filter config, variable data lands and data
  alignment control.
adi,ad4170-4
- New driver for this 24-bit very feature rich ADC suited for weigh scale
  and thermocouple applications.
adi,ad7405
- New driver for this single channel isolated ADC with backend support
  (adi-axi-adc)
google,cros_ec_activity
- Add activity detection to the existing set of cros_ec drivers covering
  both human body and significant motion detection.
mediatek,mt6359
- Add support for MT6363 and MT6373 PMIC Auxiliary ADCs.
nicera,d3-323-aa
- New driver for this configurable Passive InfraRed sensor.

Device ID only
==============

mediatek,mt7981-auxadc
- Add ID to mt2701 driver as fully compatible with mt7986-auxadc.
rohm,bu79100g
- Add ID to ad7476 driver as fully compatible with TI ADS7866.

Features
========
Core
- New in_voltageY_convdelay to allow for devices to control timing
  offsets between sampling different channels.
adi,ad-sigma-delta-library
- Support SPI offload (later fix for missing Kconfig dependency)
adi,ad4851
- SPI 3-wire support.
adi,ad7606
- Power supply control.
- convdelay and calibbias support for calibration purposes.
- gain calibration support based on external filter resistance provided
  from device tree.
adi,ad7768-1
- Add output regulator for VCM output, typically used for preconditioning
  circuits.
- Add gpio controller for the 4 GPIOs.
- Multiple scan type support to enable 16-bit modes.
- Support synchronization over SPI.
- Filter type and oversampling ratio control.
- Low pass filter cut off read only attribute.
adi,adxl313
- FIFO support
- DC activity, inactivity detection with power-save on inactivity
- AC coupled activity detection
- Documentation for this complex driver.
- debugfs register access.
adi,adxl345
- Sampling frequency and sensor range controls.
bosch,bmi270
- Add step counter support.
invensense,icm42600
- Wake on motion support.

Cleanup and fixes
=================

backend
- Drop unused parameter from iio_backend_ovesampling_ratio_set()
docs
- Fix ABI docs around I and Q modifiers.
treewide
- Switch remaining drives to use maple tree regcache.
- Drop use of DRIVER_NAME style definitions when only used in one
  place.
- Drop unused export.h includes.
- Use = { } in place of memset in various drivers.
- Constify various info structures and related.
- Switch some drivers from array of chip_info structures to individual
  named structures.
adi,ad-sigma_delta library
- Fix over allocation of scan buffer. (bits/bytes confusion)
- Sort includes and apply iwyu principles to ensure sensible set.
- Use u8 instead of uint8_t
- Replace hard coded type sizes with sizeof() and BITS_TO_BYTES() as
  appropriate.
- Factor out setting of read address to reduce duplication.
- Switch to buffer predisable so error handling on buffer enable
  functions correctly (balanced against postenable).
adi,ad4000
- Don't use sift_right() on an unsigned value.
adi,ad7173
- Add missing check on spi_setup() succeeding.
- Simplify clock enable disable code using devm_clk_get_enabled()
- Fix channel index for syscalib_mode
- Fix number of configuration slots for some devics.
- Fix the channel used for calibration.
- Fix setting ODR up in probe.
adi,ad7380
- Drop unused oversampling_ratio getter function call as value never
  used.
adi,ad7606
- Exit if invalid dt_schema encountered rather than carrying on with
  unknown config.
adi,ad7768-1
- Ensure SYNC_IN pulse is long enough.
- Switch sampling_frequency_available to read_avail() callback.
adi,ada4250
- Ensuring a dma-safe buffer for regmap_bulk_read()
- Use a local dev variable to simplify code
- Relax chip ID matching to allow for fallback dt compatibles.
- Make use of devm_regulator_get_enabled_read_voltage() to replace
  equivalent code.
- Shuffle elements around in struct to improve logical groupings and
  reduce holes.
- Use dev_err_probe()
adi,adxl313
- Use regcache to reduce traffic.
- Factor out enabling of measurement.
adi,adxl345
- Drop irq from struct as only used locally in code
- Simplify measure enable function using regmap_update_bits()
- Replace some magic numbers by units.h defines
- Simplify interrupt mapping code
- Simplify FIFO read out.
adi,axi-dac
- Factor out code to check for bus free to reduce duplication.
avago,apds9306
- Use a helper to get register address in both get and set functions.
bosch,bmi160+bmi270
- Ensure triggers suspended and resumed correctly.
bosch,bmo055
- Fix theoretical OOB acces to hw_xlate array.
freescale,vf610
- Drop -ENOMEM error message as plenty of existing prints if memory
  allocation fails.
- Use dev_err_probe() and devm_clk_geT_enabled() to simplify probe().
kionix,kx022a
- Apply include what you use principles to includes.
invensense,itg3200
- Add missing dt-binding for this gyroscope.
invensense,icm42600
- Switch from int64_t and similar to s64 and other kernel types.
- Simplify arrangement of DMA safe buffers and potentially reduce
  structure size a little.
invensense,mpu6050
- Reduce duplication in aux read/write code.
- Use sysfs_emit() to replace scnprintf()
murata,irsd200
- Drop duplicate printing of ret in dev_err_probe()
nxp,lpc3220-adc
- Add missing clocks property to dt-binding.
st,spear600
- Convert dt-binding that got left behind in staging to yaml in the main
  tree.
st,stm32-adc
- Use dev_fwnode() rather than directly accessing the of_node.
vti,sca3000
- Use direct returns instead of gotos where simple.

Various other minor typo and white space fixes.

----------------------------------------------------------------
Aleksander Jan Bajkowski (1):
      dt-bindings: iio: adc: Add support for MT7981

Ana-Maria Cusco (1):
      iio: adc: Add basic support for AD4170-4

Andrew Ijano (1):
      iio: accel: sca3000: replace error_ret labels by simple returns

Andy Shevchenko (1):
      iio: imu: inv_icm42600: Convert to uXX and sXX integer types

Angelo Dureghello (10):
      iio: dac: adi-axi-dac: use unique bus free check
      iio: adc: ad7606: enable Vdrive power supply
      iio: adc: ad7606: add enabling of optional Vrefin voltage
      Documentation: ABI: IIO: add new convdelay documentation
      iio: core: add ADC delay calibration definition
      iio: adc: ad7606: add offset and phase calibration support
      dt-bindings: iio: adc: adi,ad7606: add gain calibration support
      iio: adc: ad7606: exit for invalid fdt dt_schema properties
      iio: adc: ad7606: rename chan_scale to a more generic chan_info
      iio: adc: ad7606: add gain calibration support

AngeloGioacchino Del Regno (6):
      dt-bindings: iio: adc: mt6359: Add MT6363 PMIC AuxADC
      dt-bindings: iio: adc: mt6359: Add MT6373 PMIC AuxADC
      iio: adc: mt6359: Add ready register index and mask to channel data
      iio: adc: mt6359: Move reference voltage to platform data
      iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC
      iio: adc: mt6359: Add support for MediaTek MT6373 PMIC AUXADC

Antonio Borneo (3):
      iio: adc: stm32-dfsdm: Fix build warnings about export.h
      iio: trigger: stm32-timer: Fix build warnings about export.h
      iio: trigger: stm32-lptimer: Fix build warnings about export.h

Antoniu Miclaus (12):
      iio: backend: add support for filter config
      iio: backend: add support for data alignment
      iio: backend: add support for number of lanes
      dt-bindings: iio: adc: add ad408x axi variant
      iio: adc: adi-axi-adc: add filter type config
      iio: adc: adi-axi-adc: add data align process
      iio: adc: adi-axi-adc: add num lanes support
      dt-bindings: iio: adc: add ad4080
      iio: adc: ad4080: add driver support
      Documentation: ABI: add sinc1 and sinc5+pf1 filter
      dt-bindings: iio: adc: ad4851: add spi-3wire
      iio: adc: ad4851: add spi 3-wire support

Chelsy Ratnawat (1):
      iio: imu: inv_mpu6050: Replace scnprintf with sysfs_emit

Colin Ian King (1):
      iio: adc: ti-ads131e08: Fix spelling mistake "tweek" -> "tweak"

David Lechner (80):
      iio: amplifiers: ada4250: use DMA-safe memory for regmap_bulk_read()
      iio: adc: ad7173: check return value of spi_setup()
      iio: amplifiers: ada4250: used dev local variable
      iio: amplifiers: ada4250: don't fail on bad chip ID
      iio: amplifiers: ada4250: use devm_regulator_get_enable_read_voltage()
      iio: amplifiers: ada4250: move offset_uv in struct
      iio: amplifiers: ada4250: use dev_err_probe()
      iio: accel: adxl372: use = { } instead of memset()
      iio: accel: msa311: use = { } instead of memset()
      iio: adc: dln2-adc: use = { } instead of memset()
      iio: adc: mt6360-adc: use = { } instead of memset()
      iio: adc: rockchip_saradc: use = { } instead of memset()
      iio: adc: rtq6056: use = { } instead of memset()
      iio: adc: stm32-adc: use = { } instead of memset()
      iio: adc: ti-ads1015: use = { } instead of memset()
      iio: adc: ti-ads1119: use = { } instead of memset()
      iio: adc: ti-lmp92064: use = { } instead of memset()
      iio: adc: ti-tsc2046: use = { } instead of memset()
      iio: chemical: scd4x: use = { } instead of memset()
      iio: chemical: scd30: use = { } instead of memset()
      iio: chemical: sunrise_co2: use = { } instead of memset()
      iio: dac: ad3552r: use = { } instead of memset()
      iio: imu: inv_icm42600: use = { } instead of memset()
      iio: imu: inv_mpu6050: use = { } instead of memset()
      iio: light: bh1745: use = { } instead of memset()
      iio: light: ltr501: use = { } instead of memset()
      iio: light: opt4060: use = { } instead of memset()
      iio: light: veml6030: use = { } instead of memset()
      iio: magnetometer: af8133j: use = { } instead of memset()
      iio: pressure: bmp280: use = { } instead of memset()
      iio: pressure: mpl3115: use = { } instead of memset()
      iio: pressure: mprls0025pa: use = { } instead of memset()
      iio: pressure: zpa2326: use = { } instead of memset()
      iio: proximity: irsd200: use = { } instead of memset()
      iio: temperature: tmp006: use = { } instead of memset()
      iio: adc: ad7173: simplify clock enable/disable
      iio: adc: ad7380: remove unused oversampling_ratio getter
      iio: accel: adxl345: make adxl345_events const
      iio: accel: mma9553: make mma9553_event_info const
      iio: adc: ad7091r5: make ad7091r5_init_info const
      iio: adc: ad7091r8: make ad7091r_init_info const
      iio: adc: at91_adc: make at91_adc_caps const
      iio: adc: axp20x_adc: make axp717_maps const
      iio: adc: mp2629_adc: make mp2629_channels const
      iio: adc: qcom-vadc: make scale_adc5_fn const
      iio: adc: stm32-adc: make stm32_adc_trig_info const
      iio: amplifiers: ad8366: make ad8366_info const
      iio: chemical: atlas-ezo-sensor: make atlas_ezo_devices const
      iio: common: hid-sensor-attributes: make unit_conversion const
      iio: dac: ad5770r: make ad5770r_rng_tbl const
      iio: dac: ltc2688: make ltc2688_dither_ext_info const
      iio: imu: bmi160: make bmi160_regs const
      iio: light: isl76682: make isl76682_range_table const
      iio: light: zopt2201: make zopt2201_scale const
      iio: pressure: abp060mg: make abp_config const
      iio: proximity: vcnl3020: pass struct vcnl3020_property by pointer
      iio: proximity: vcnl3020: make vcnl3020_property const
      iio: adc: ad7124: Use separate structures rather than array for chip info
      iio: imu: adis16400: Use separate structures rather than an array for chip info
      iio: light: cm3232: move calibscale to struct cm3232_chip
      iio: light: cm3232: make struct cm3232_als_info const
      iio: pressure: dlhl60d: Use separate structures rather than an array for chip info
      iio: adc: ad_sigma_delta: don't overallocate scan buffer
      iio: adc: ad_sigma_delta: sort includes
      iio: adc: ad_sigma_delta: use u8 instead of uint8_t
      iio: adc: ad_sigma_delta: use sizeof() in ALIGN()
      iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
      iio: adc: ad_sigma_delta: audit included headers
      iio: adc: ad_sigma_delta: refactor setting read address
      iio: adc: ad_sigma_delta: use spi_optimize_message()
      iio: adc: ad_sigma_delta: add SPI offload support
      iio: adc: ad4000: don't use shift_right()
      iio: imu: bno055: fix OOB access of hw_xlate array
      iio: imu: bno055: make bno055_sysfs_attr const
      iio: ABI: fix correctness of I and Q modifiers
      iio: adc: ad_sigma_delta: change to buffer predisable
      iio: adc: ad7173: fix channels index for syscalib_mode
      iio: adc: ad7173: fix num_slots
      iio: adc: ad7173: fix calibration channel
      iio: adc: ad7173: fix setting ODR in probe

Denis Benato (2):
      iio: bmi270: suspend and resume triggering on relevant pm operations
      iio: bmi160: suspend and resume triggering on relevant pm operations

Frank Li (1):
      dt-bindings: iio: adc: nxp,lpc3220-adc: allow clocks property

Gustavo Silva (2):
      iio: imu: bmi270: add channel for step counter
      iio: imu: bmi270: add step counter watermark event

Gwendal Grignou (1):
      iio: cros_ec_sensors: add cros_ec_activity driver

Gyeyoung Baek (1):
      iio: buffer: Fix checkpatch.pl warning

Isabella Caselli (1):
      iio: imu: inv_mpu6050: refactor aux read/write to use shared xfer logic

Jean-Baptiste Maneyrol (3):
      iio: imu: inv_icm42600: reorganize DMA aligned buffers in structure
      iio: imu: inv_icm42600: add WoM support
      iio: imu: inv_icm42600: add wakeup functionality for Wake-on-Motion

Jiri Slaby (SUSE) (1):
      iio: adc: stm32-adc: Use dev_fwnode()

Jonathan Cameron (2):
      iio: potentiometer: Drop unused export.h includes
      iio: accel: kionix-kx022a: Apply approximate iwyu principles to includes

Jonathan Santos (11):
      iio: adc: ad7768-1: Ensure SYNC_IN pulse minimum timing requirement
      dt-bindings: trigger-source: add generic GPIO trigger source
      dt-bindings: iio: adc: ad7768-1: document regulator provider property
      dt-bindings: iio: adc: ad7768-1: Document GPIO controller
      dt-bindings: iio: adc: ad7768-1: add trigger-sources property
      iio: adc: ad7768-1: add regulator to control VCM output
      iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
      iio: adc: ad7768-1: add support for Synchronization over SPI
      iio: adc: ad7768-1: replace manual attribute declaration
      iio: adc: ad7768-1: add filter type and oversampling ratio attributes
      iio: adc: ad7768-1: add low pass -3dB cutoff attribute

Krzysztof Kozlowski (3):
      iio: adc: vf610: Drop -ENOMEM error message
      iio: adc: vf610: Simplify with dev_err_probe
      iio: dac: vf610: Simplify with devm_clk_get_enabled()

Lothar Rubusch (16):
      iio: accel: adxl345: extend sample frequency adjustments
      iio: accel: adxl345: add g-range configuration
      iio: accel: adxl313: add debug register
      iio: accel: adxl345: make data struct variable irq function local
      iio: accel: adxl345: simplify measure enable
      iio: accel: adxl345: replace magic numbers by unit expressions
      iio: accel: adxl313: make use of regmap cache
      iio: accel: adxl313: add function to enable measurement
      iio: accel: adxl313: add buffered FIFO watermark with interrupt handling
      iio: accel: adxl313: add activity sensing
      iio: accel: adxl313: add inactivity sensing
      iio: accel: adxl313: implement power-save on inactivity
      iio: accel: adxl313: add AC coupled activity/inactivity events
      docs: iio: add ADXL313 accelerometer
      iio: accel: adxl345: simplify interrupt mapping
      iio: accel: adxl345: simplify reading the FIFO

Marcelo Schmitt (11):
      dt-bindings: iio: adc: Add AD4170-4
      iio: adc: ad4170-4: Add support for calibration gain
      iio: adc: ad4170-4: Add support for calibration bias
      Documentation: ABI: IIO: Add sinc5+avg to the filter_type_available list
      iio: adc: ad4170-4: Add digital filter and sample frequency config support
      iio: adc: ad4170-4: Add support for buffered data capture
      iio: adc: ad4170-4: Add timestamp channel
      iio: adc: ad4170-4: Add clock provider support
      iio: adc: ad4170-4: Add GPIO controller support
      iio: adc: ad4170-4: Add support for internal temperature sensor
      iio: adc: ad4170-4: Add support for weigh scale, thermocouple, and RTD sens

Matti Vaittinen (1):
      iio: adc: ad7476: Support ROHM BU79100G

Nathan Chancellor (1):
      iio: adc: ad_sigma_delta: Select IIO_BUFFER_DMAENGINE and SPI_OFFLOAD

Nattan Ferreira (1):
      iio: light: apds9306: Refactor threshold get/set functions to use helper

Pop Ioan Daniel (5):
      iio: adc: ad4851: ad4851_set_oversampling_ratio parameters update
      iio: backend: update iio_backend_oversampling_ratio_set
      iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
      dt-bindings: iio: adc: add ad7405
      iio: adc: ad7405: add ad7405 driver

Rodrigo Gobbi (2):
      dt-bindings: iio: adc: st,spear600-adc: txt to yaml format conversion.
      dt-bindings: iio: gyroscope: invensense,itg3200: add binding

Sergiu Cuciurean (1):
      iio: adc: ad7768-1: Add GPIO controller support

Waqar Hameed (8):
      iio: irsd200: Remove print of error code from dev_err_probe
      iio: Remove single use of macro definition for driver name
      iio: Remove single use of macro definition for IRQ name
      iio: Remove single use of macro definition for regmap name
      iio: Remove unused macro definition for driver and IRQ name
      dt-bindings: vendor-prefixes: Add Nicera
      dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR sensor
      iio: Add driver for Nicera D3-323-AA PIR sensor

chuguangqing (10):
      iio: chemical: bme680: convert to use maple tree register cache
      iio: dac: ad5380: convert to use maple tree register cache
      iio: dac: bd79703: convert to use maple tree register cache
      iio: health: afe4403: convert to use maple tree register cache
      iio: health: afe4404: convert to use maple tree register cache
      iio: imu: icm42600: convert to use maple tree register cache
      iio: imu: bno055: convert to use maple tree register cache
      iio: light: isl29028: convert to use maple tree register cache
      iio: light: ltr501: convert to use maple tree register cache
      iio: light: opt4060: convert to use maple tree register cache

 Documentation/ABI/obsolete/sysfs-bus-iio           |   12 -
 Documentation/ABI/testing/sysfs-bus-iio            |   67 +-
 .../ABI/testing/sysfs-bus-iio-frequency-admv1013   |    4 +-
 .../devicetree/bindings/iio/adc/adi,ad4080.yaml    |   96 +
 .../devicetree/bindings/iio/adc/adi,ad4170-4.yaml  |  554 ++++
 .../devicetree/bindings/iio/adc/adi,ad4851.yaml    |    2 +
 .../devicetree/bindings/iio/adc/adi,ad7405.yaml    |   60 +
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   29 +
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |   68 +-
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |    2 +
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |    4 +
 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |    2 +
 .../bindings/iio/adc/nxp,lpc3220-adc.yaml          |    3 +
 .../bindings/iio/adc/st,spear600-adc.yaml          |   69 +
 .../bindings/iio/gyroscope/invensense,itg3200.yaml |   59 +
 .../bindings/iio/proximity/nicera,d3323aa.yaml     |   62 +
 .../bindings/staging/iio/adc/spear-adc.txt         |   24 -
 .../bindings/trigger-source/gpio-trigger.yaml      |   40 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/iio/adxl313.rst                      |  293 ++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   21 +-
 drivers/iio/accel/adxl313.h                        |   33 +-
 drivers/iio/accel/adxl313_core.c                   |  923 +++++-
 drivers/iio/accel/adxl313_i2c.c                    |    6 +
 drivers/iio/accel/adxl313_spi.c                    |    6 +
 drivers/iio/accel/adxl345.h                        |    3 +-
 drivers/iio/accel/adxl345_core.c                   |  288 +-
 drivers/iio/accel/adxl372.c                        |    3 +-
 drivers/iio/accel/bma180.c                         |    3 -
 drivers/iio/accel/bmc150-accel-core.c              |    5 +-
 drivers/iio/accel/kionix-kx022a.c                  |   12 +-
 drivers/iio/accel/kxcjk-1013.c                     |    7 +-
 drivers/iio/accel/mma9551.c                        |    6 +-
 drivers/iio/accel/mma9553.c                        |   11 +-
 drivers/iio/accel/msa311.c                         |    4 +-
 drivers/iio/accel/mxc4005.c                        |    6 +-
 drivers/iio/accel/mxc6255.c                        |    3 +-
 drivers/iio/accel/sca3000.c                        |   29 +-
 drivers/iio/accel/sca3300.c                        |    4 +-
 drivers/iio/accel/stk8312.c                        |    3 +-
 drivers/iio/accel/stk8ba50.c                       |    3 +-
 drivers/iio/adc/Kconfig                            |   43 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/ad4000.c                           |    2 +-
 drivers/iio/adc/ad4080.c                           |  619 ++++
 drivers/iio/adc/ad4170-4.c                         | 3027 ++++++++++++++++++++
 drivers/iio/adc/ad4851.c                           |   16 +-
 drivers/iio/adc/ad7091r5.c                         |    2 +-
 drivers/iio/adc/ad7091r8.c                         |    6 +-
 drivers/iio/adc/ad7124.c                           |   36 +-
 drivers/iio/adc/ad7173.c                           |   78 +-
 drivers/iio/adc/ad7380.c                           |    5 -
 drivers/iio/adc/ad7405.c                           |  253 ++
 drivers/iio/adc/ad7476.c                           |    7 +
 drivers/iio/adc/ad7606.c                           |  361 ++-
 drivers/iio/adc/ad7606.h                           |   22 +-
 drivers/iio/adc/ad7768-1.c                         |  918 +++++-
 drivers/iio/adc/ad_sigma_delta.c                   |  299 +-
 drivers/iio/adc/adi-axi-adc.c                      |   96 +-
 drivers/iio/adc/at91_adc.c                         |   10 +-
 drivers/iio/adc/axp20x_adc.c                       |    2 +-
 drivers/iio/adc/dln2-adc.c                         |    4 +-
 drivers/iio/adc/hi8435.c                           |    4 +-
 drivers/iio/adc/max9611.c                          |    4 +-
 drivers/iio/adc/mp2629_adc.c                       |    2 +-
 drivers/iio/adc/mt6359-auxadc.c                    |  440 ++-
 drivers/iio/adc/mt6360-adc.c                       |    3 +-
 drivers/iio/adc/qcom-vadc-common.c                 |    2 +-
 drivers/iio/adc/rockchip_saradc.c                  |    4 +-
 drivers/iio/adc/rtq6056.c                          |    4 +-
 drivers/iio/adc/stm32-adc-core.c                   |    3 +-
 drivers/iio/adc/stm32-adc.c                        |    9 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    1 +
 drivers/iio/adc/stm32-dfsdm-core.c                 |    1 +
 drivers/iio/adc/ti-ads1015.c                       |    4 +-
 drivers/iio/adc/ti-ads1119.c                       |    4 +-
 drivers/iio/adc/ti-ads131e08.c                     |   10 +-
 drivers/iio/adc/ti-lmp92064.c                      |    4 +-
 drivers/iio/adc/ti-tsc2046.c                       |    3 +-
 drivers/iio/adc/vf610_adc.c                        |    5 +-
 drivers/iio/amplifiers/ad8366.c                    |    6 +-
 drivers/iio/amplifiers/ada4250.c                   |   55 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |    2 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |    2 +-
 drivers/iio/chemical/atlas-sensor.c                |    3 +-
 drivers/iio/chemical/bme680_core.c                 |    2 +-
 drivers/iio/chemical/scd30_core.c                  |    3 +-
 drivers/iio/chemical/scd4x.c                       |    3 +-
 drivers/iio/chemical/sunrise_co2.c                 |    6 +-
 drivers/iio/common/cros_ec_sensors/Kconfig         |    9 +
 drivers/iio/common/cros_ec_sensors/Makefile        |    1 +
 .../iio/common/cros_ec_sensors/cros_ec_activity.c  |  307 ++
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   10 +
 .../iio/common/hid-sensors/hid-sensor-attributes.c |    2 +-
 drivers/iio/dac/ad3552r.c                          |    3 +-
 drivers/iio/dac/ad5380.c                           |    2 +-
 drivers/iio/dac/ad5770r.c                          |    2 +-
 drivers/iio/dac/adi-axi-dac.c                      |   42 +-
 drivers/iio/dac/ltc2688.c                          |    2 +-
 drivers/iio/dac/max517.c                           |    4 +-
 drivers/iio/dac/mcp4725.c                          |    4 +-
 drivers/iio/dac/rohm-bd79703.c                     |    2 +-
 drivers/iio/dac/vf610_dac.c                        |   23 +-
 drivers/iio/gyro/bmg160_core.c                     |    4 +-
 drivers/iio/health/afe4403.c                       |    2 +-
 drivers/iio/health/afe4404.c                       |    2 +-
 drivers/iio/health/max30100.c                      |    3 +-
 drivers/iio/health/max30102.c                      |    3 +-
 drivers/iio/humidity/dht11.c                       |    4 +-
 drivers/iio/imu/adis16400.c                        |  314 +-
 drivers/iio/imu/bmi160/bmi160.h                    |    2 +
 drivers/iio/imu/bmi160/bmi160_core.c               |   21 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    2 +
 drivers/iio/imu/bmi160/bmi160_spi.c                |    2 +
 drivers/iio/imu/bmi270/bmi270.h                    |    2 +
 drivers/iio/imu/bmi270/bmi270_core.c               |  327 ++-
 drivers/iio/imu/bmi270/bmi270_i2c.c                |    2 +
 drivers/iio/imu/bmi270/bmi270_spi.c                |    2 +
 drivers/iio/imu/bno055/bno055.c                    |   58 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   62 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  360 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   24 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |   10 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  107 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   41 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |    6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |    4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c          |   56 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |    6 +-
 drivers/iio/imu/kmx61.c                            |    7 +-
 drivers/iio/industrialio-backend.c                 |   61 +-
 drivers/iio/industrialio-core.c                    |    1 +
 drivers/iio/light/adux1020.c                       |    3 +-
 drivers/iio/light/apds9160.c                       |    4 +-
 drivers/iio/light/apds9300.c                       |    3 +-
 drivers/iio/light/apds9306.c                       |   36 +-
 drivers/iio/light/apds9960.c                       |    3 +-
 drivers/iio/light/bh1745.c                         |    4 +-
 drivers/iio/light/cm3232.c                         |   18 +-
 drivers/iio/light/isl29028.c                       |    2 +-
 drivers/iio/light/isl76682.c                       |    2 +-
 drivers/iio/light/jsa1212.c                        |    3 +-
 drivers/iio/light/ltr501.c                         |   14 +-
 drivers/iio/light/opt4060.c                        |    6 +-
 drivers/iio/light/rpr0521.c                        |    6 +-
 drivers/iio/light/stk3310.c                        |    6 +-
 drivers/iio/light/vcnl4035.c                       |    6 +-
 drivers/iio/light/veml6030.c                       |    4 +-
 drivers/iio/light/zopt2201.c                       |    6 +-
 drivers/iio/magnetometer/af8133j.c                 |    4 +-
 drivers/iio/magnetometer/bmc150_magn.c             |    5 +-
 drivers/iio/magnetometer/mmc35240.c                |    3 +-
 drivers/iio/potentiometer/ds1803.c                 |    1 -
 drivers/iio/potentiometer/mcp4131.c                |    1 -
 drivers/iio/pressure/abp060mg.c                    |    4 +-
 drivers/iio/pressure/bmp280-core.c                 |    5 +-
 drivers/iio/pressure/dlhl60d.c                     |   47 +-
 drivers/iio/pressure/mpl3115.c                     |    3 +-
 drivers/iio/pressure/mprls0025pa_i2c.c             |    5 +-
 drivers/iio/pressure/zpa2326.c                     |    4 +-
 drivers/iio/proximity/Kconfig                      |    9 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/d3323aa.c                    |  816 ++++++
 drivers/iio/proximity/irsd200.c                    |   22 +-
 drivers/iio/proximity/sx9500.c                     |    3 +-
 drivers/iio/proximity/vcnl3020.c                   |   16 +-
 drivers/iio/resolver/ad2s1200.c                    |    3 +-
 drivers/iio/temperature/tmp006.c                   |    4 +-
 drivers/iio/trigger/stm32-lptimer-trigger.c        |    1 +
 drivers/iio/trigger/stm32-timer-trigger.c          |    1 +
 include/dt-bindings/iio/adc/adi,ad7768-1.h         |   10 +
 .../dt-bindings/iio/adc/mediatek,mt6363-auxadc.h   |   24 +
 .../dt-bindings/iio/adc/mediatek,mt6373-auxadc.h   |   19 +
 include/linux/iio/adc/ad_sigma_delta.h             |   27 +-
 include/linux/iio/backend.h                        |   22 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |    1 +
 include/linux/iio/types.h                          |    1 +
 include/linux/platform_data/cros_ec_commands.h     |   26 +-
 180 files changed, 11047 insertions(+), 1310 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170-4.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
 delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
 create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
 create mode 100644 Documentation/iio/adxl313.rst
 create mode 100644 drivers/iio/adc/ad4080.c
 create mode 100644 drivers/iio/adc/ad4170-4.c
 create mode 100644 drivers/iio/adc/ad7405.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
 create mode 100644 drivers/iio/proximity/d3323aa.c
 create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h

