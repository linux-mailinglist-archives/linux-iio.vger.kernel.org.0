Return-Path: <linux-iio+bounces-8694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C995BE6E
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 20:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F5D1F25E48
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FAB1D0490;
	Thu, 22 Aug 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMBFgXhj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB541CE71D
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352258; cv=none; b=Ni8Wm/jjnmxl56rcWB8FIg+NGB2NbVBgK+eaXxrtIIBnvfHu1+ki0OnhU+08t7E6lQnZaXZ+lZEKPSN2+wf5C405xyA4B8TxLLTkzxaR/ZM98S0m/NGHSjIl2rGwic7x2d8Y/0o2jfTCrrO6XDk9e7GjefEEK9AGekTKv5SGt1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352258; c=relaxed/simple;
	bh=krHIdFn5bFi+6qrCIC3HRdBVV90gFP9UG4OejGx+M0M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=gkoWQha6dF5eieRaeDWINdCEVGk2T8GiOUPAzApl7tEtuzvkI7/dcsQVw8uhmdUejXep0TVF4Pn/LOr5fCM4awe9lX9dZjLhkRYY2RxC20PR8xzkl+8AeGl9cgb5/maTTqDSM9TqvIS59U4sQlcS1wGYJfqF2mx8/LCta74VoHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMBFgXhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E45C32782;
	Thu, 22 Aug 2024 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724352258;
	bh=krHIdFn5bFi+6qrCIC3HRdBVV90gFP9UG4OejGx+M0M=;
	h=Date:From:To:Subject:From;
	b=vMBFgXhjkriCsn/WiNOwy8WIk5mZVElzT3WIVkZNY/P4KrzUDxyQKFY6dosoaSg31
	 GiMDDY1TWjeoWhk8kiNusZtmcC1sHGq1WosyigZKFTvLeXgkWMIhazOElDuxt812my
	 +v/ZikuI5srqh8KxI8DUhreIevGd1TcEwFYkxX3r3hwSbqMHAPlm6uoIfdxyMZa7Mb
	 JKyUaPe7fR/ALEvjhD4PXIm5WowQmW1oVED3YHFl0GhYkgOFUgL/uEDKNE0Exhvblt
	 UtHiVdK+9dLbCQWhoqpFYdIiECYBRJYVnO+LhhG1r5fvw2cNGMqtWj/Dh7+4RUThqe
	 Zz3M7tfAX6JWA==
Date: Thu, 22 Aug 2024 19:44:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of New device support features and cleanup for
 6.12
Message-ID: <20240822194412.2b0f179e@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.12a

for you to fetch changes up to c4b43d8336e52dce6d124e428aa3b71703e62647:

  drivers:iio:Fix the NULL vs IS_ERR() bug for debugfs_create_dir() (2024-08-21 21:32:52 +0100)

----------------------------------------------------------------
IIO: 1st set of new device support, features and cleanup for 6.12

Includes a merge of spi-mos-config branch from spi.git that brings
support needed for the AD4000 driver.

Lots of new device support this time including 9 new drivers and substantial
changes to add new support to several more.

New device support
------------------

Given we have a lot of new support, I've subcategorized them:

Substantial changes, or new driver
**********************************

adi,ad4000
- New driver for this high speed ADC.
adi,ad4695
- New driver supporting AD4690, AD4696, AD4697 and AD4698 ADCs.
- Follow up series added triggered buffer support.
adi,ad7380
- Add support for single ended parts, AD7386, ADC7387, AD7388 and -4 variants.
  (driver previously only support differential parts).
  These variants have an additional front end MUX so only half the channels
  can be sampled efficiently.
adi,ad9467
- Refactor and extend driver to support ad9643, ad9449 and ad9652 high speed
  ADCs.
adi,adxl380
- New driver for this low power accelerometer.
adi,ltc2664
- New driver supporting LTC2664 and LTC2672 DACs.
microchip,pac1921
- New driver for this power/current monitor chip.
rohm,bh1745
- New driver for this RGBC colour sensor.
rohm,bu27034anuc
- The original bu27034 was canceled before mass production, so the
  driver is modified to support the BU27034ANUC which had some significant
  differences.  DT compatible changed to avoid chance of old driver ever
  binding to real hardware.
sciosense,ens210
- New driver for ens210, ens210a, ens211, ens212, ens213a, and ens215
  temperature and humidity sensors (all register compatible up to some
  conversion time differences)
sensiron,sdp500
- New driver for this differential pressure sensor.
tyhx,hx9023s
- New driver to support this capacitive proximity sensor.

Minor changes to support new devices
************************************

adi,adf4377
- Add support for the single output adf4378.
kionix,kxcjk-1013
- Add support for KX022-1020 accelerometer (binding and ID table only)
liteon,ltrf216a
- Add support for ltr-308.  A few minor differences in features set
rockchip,saradc
- Add ID for rk3576-saradc
sensortek,stk3310
- Add ID for stk3013 proximity sensor which (despite documentation) has
  an ambient light sensor and is compatible with existing parts.

Documentation updates
---------------------

Generalize ABI docs for shunt resistor attribute
Improve calibscale and calibbias related documentation.  A couple of follow
up patches to resolve duplicate documentation that resulted.

New core features
-----------------

backend
- Add option for debugfs - useful for test pattern control
- Use this for both adi-axi-adc and adi-axi-dac
trigger suspend
- Add functions to allow triggers to be suspended. This avoids problems
  when a device enters suspend to idle with a sysfs trigger. Use it for now
  in the bmi323 only.

New driver features
-------------------

adi,ad7192
- Add option to be a clock provider (+ additional clock config options)
adi,ad7380
- Add documentation for this fairly new driver.
adi,ad9461
- Provide control of test modes and backend validation blocks used
  to identify problems (via debugfs)
adi,ad9739
- Add backend debugfs and docs for what is provided via adi-axi-dac
avago,apds9960
- Add proximity and gesture calibration offset control
bosch,bmp280
- Triggered buffer support including adding raw+scale output for sysfs.
liteon,ltr390
- Add configuration of integration time and scale.
stm,dfsdm
- Convert this SD modulator driver to backend framework and add support
  for channel scaling + modern channel bindings.

Treewide cleanup
----------------

iio_dev->masklength: Making it private.
- Provide access function to read the core compute channel mask length
  and a macro to iterate over elements in the active_scan_mask.
- Enables marking masklength __private preventing drivers from
  writing it without triggering a build warning whilst minimizing overhead
  in what are typically hot paths.
- Convert all drivers and finally mark it private.
  Merge conflicts resolved in drivers applied after this point.
Constify regmap_bus
- These are never modified, so mark them const.

Core cleanup
------------

backend
- A few late breaking bits of feedback (unused variable, error messages)
dma-buffer
- Namespace exports.
core
- Drop unused assignment.

Driver cleanup
--------------

adi,ad4695
- Fixing binding to reflect that common-mode-channel is a scalar.
adi,ad7280a
- Use __free(kfree) to simplify freeing of receive buffer.
adi,ad7606
- Various dt-binding cleanup and improvements.
- Fix oversampling related gpio handling.
- Make polarity of standby gpio match documentation.
- use guard() to simplify lock handling.
adi,ad7768
- Use device_for_each_child_node_scoped() instead of fwnode equivalent.
adi,ad7124
- Reduce SPI transfers by avoiding separate writes to different fields
  in the same register.
- Start the ADC in idle mode.
adi,adis
- Drop ifdefs in favor of IS_ENABLED.
adi,admv8818
- Fix wrong ABI docs.
asahi-kasei,ak8975
- Drop a prefix free compatible accidentally added recently.
aspeed,adc
- Use of_property_present() instead of of_find_property() to see if the
  property is there or not.
atmel,at91,
- Use __free(kfree) to simplify freeing of channel related array.
bosch,bma400
- Use __free(kfree) to simplify freeing a locally allocated string.
bosch,bmc150
- Add missing mount-matrix binding docs.
bosch,bme680
- Fix read/write to ensure multiple necessary sequential reads without
  device configuration change.
- Drop unnecessary type casts and use more appropriate data types.
- Drop some left over ACPI code as ACPI support was removed due to invalid
  IDs (and no known users).
- Sort headers consistently.
- Avoid unnecessary duplicate read and redundant read of gas config.
- Use bulk reads to get calibration data.
- Reorder allocation of IIO device to be prior to device init.
- Add remaining read/write buffers to the union used already for all others.
- Tidy up error checks for consistency of style, including dev_err_probe()
- Bring the device startup procedure inline with the vendor code.
- Reorder code so mode forcing is more obvious occurring where needed.
- Tidy up data locality in reading functions so no magic data is stored
  in state structures just to get it across function calls.
- Make a local lookup table static to avoid placing it on the stack.
bosch,bmp280
- Fix BME280 regmap to not include registers it doesn't have.
- Wait a little longer after config to allow for maximum possible necessary
  wait.
- Reorganize headers.
- Make conversion_time_max array static to avoid placing it on the stack.
maxim,max1363
- Use __free(kfree) to simplify freeing transmission buffer.
microchip,mcp3964
- Use devm_regulator_get_enable_read_voltage()
microchip,mcp3911
- Use devm_regulator_get_enable_read_voltage()
microchip,mcp4728
- Use devm_regulator_get_enable_read_voltage()
microchip,mcp4922
- Use devm_regulator_get_enable_read_voltage() and devm_* to allow
  dropping of explicit remove() callback.
onnn,noa1305
- Various tidy up.
- Provide available scale values.
- Make integration time configurable.
- Fix up integration time look up (/2 error)
ti,dac7311
- Check if spi_setup() succeeded.
ti,tsc2046
- Use __free(kfree) to simplify freeing rx and tx buffers.
- Use devm_regulator_get_enable_read_voltage()

Various minor fixes not called out explicitly.

----------------------------------------------------------------
Abhash Jha (4):
      iio: light: ltr390: Add configurable gain and resolution
      iio: light: apds9960: Add proximity and gesture offset calibration
      iio: light: ltr390: Add ALS channel and support for gain and resolution
      iio: light: ltr390: Calculate 'counts_per_uvi' dynamically

Alisa-Dariana Roman (4):
      dt-bindings: iio: adc: ad7192: Update clock config
      iio: adc: ad7192: Update clock config
      dt-bindings: iio: adc: ad7192: Add clock provider
      iio: adc: ad7192: Add clock provider

Andreas Klinger (1):
      iio: sgp40: retain documentation in driver

Antoniu Miclaus (6):
      ABI: testing: fix admv8818 attr description
      dt-bindings: iio: accel: add ADXL380
      iio: accel: add ADXL380 driver
      docs: iio: add documentation for adxl380 driver
      dt-bindings: iio: adf4377: add adf4378 support
      iio: frequency: adf4377: add adf4378 support

Chen Ni (1):
      iio: dac: ti-dac7311: Add check for spi_setup

Colin Ian King (2):
      iio: pressure: bmp280-core: Make read-only const array conversion_time_max static
      iio: Fix spelling mistake "avaialable" -> "available"

Dan Carpenter (3):
      iio: dac: ltc2664: Fix off by one in ltc2664_channel_config()
      iio: adc: pac1921: add missing error return in probe()
      iio: proximity: hx9023s: Fix error code in hx9023s_property_get()

David Lechner (19):
      dt-bindings: iio: adc: add AD4695 and similar ADCs
      iio: adc: ad4695: Add driver for AD4695 and similar ADCs
      Documentation: iio: Document ad4695 driver
      iio: dac: mcp4728: rename err to ret in probe function
      iio: dac: mcp4728: use devm_regulator_get_enable_read_voltage()
      iio: dac: mcp4922: use devm_regulator_get_enable_read_voltage()
      iio: dac: mcp4922: drop remove() callback
      iio: adc: mcp3911: use devm_regulator_get_enable_read_voltage()
      iio: backend: spelling: continuous -> continuous
      iio: adc: mcp3564: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-tsc2046: use devm_regulator_get_enable_read_voltage()
      dt-bindings: iio: ad4695: fix common-mode-channel
      iio: adc: ad4695: implement triggered buffer
      doc: iio: ad4695: document buffered read
      iio: ABI: document calibscale_available attributes
      iio: ABI: sort calibscale attributes
      iio: ABI: add missing calibscale attributes
      iio: ABI: add missing calibbias attributes
      iio: ABI: remove duplicate in_resistance_calibbias

Denis Benato (2):
      iio: trigger: allow devices to suspend/resume theirs associated trigger
      iio: bmi323: suspend and resume triggering on relevant pm operations

Detlev Casanova (1):
      dt-bindings: iio: adc: Add rockchip,rk3576-saradc string

Dumitru Ceclan (2):
      iio: adc: ad7124: reduce the number of SPI transfers
      iio: adc: ad7124: set initial ADC mode to idle

Guillaume Stols (8):
      dt-bindings: iio: adc: adi,ad7606: normalize textwidth
      dt-bindings: iio: adc: adi,ad7606: improve descriptions
      dt-bindings: iio: adc: adi,ad7606: add supply properties
      dt-bindings: iio: adc: adi,ad7606: fix example
      dt-bindings: iio: adc: adi,ad7606: add conditions
      iio: adc: ad7606: fix oversampling gpio array
      iio: adc: ad7606: fix standby gpio state to match the documentation
      iio: adc: ad7606: switch mutexes to guard

Javier Carrasco (11):
      iio: accel: adxl367: Constify struct regmap_bus
      iio: accel: bma400: Constify struct regmap_bus
      iio: accel: bmi088: Constify struct regmap_bus
      iio: adc: ad7091r8: Constify struct regmap_bus
      iio: chemical: bme680: Constify struct regmap_bus
      iio: dac: ltc2688: Constify struct regmap_bus
      iio: imu: bmi323: Constify struct regmap_bus
      iio: imu: bno055: Constify struct regmap_bus
      iio: light: gp2ap002: Constify struct regmap_bus
      iio: pressure: bmp280: Constify struct regmap_bus
      iio: adc: ad7768-1: use device_* to iterate over device child nodes

Jonathan Cameron (1):
      Merge tag 'spi-mosi-config' into togreg

Joshua Felmeden (2):
      dt-bindings: iio: humidity: add ENS210 sensor family
      iio: humidity: Add support for ENS210

Julien Stephan (8):
      docs: iio: new docs for ad7380 driver
      dt-bindings: iio: adc: ad7380: add single-ended compatible parts
      iio: core: add function to retrieve active_scan_mask index
      iio: adc: ad7380: add missing trailing commas
      iio: adc: ad7380: prepare driver for single-ended parts support
      iio: adc: ad7380: add support for single-ended parts
      iio: adc: ad7380: enable sequencer for single-ended parts
      docs: iio: ad7380: add support for single-ended parts

Kaustabh Chakraborty (3):
      iio: light: stk3310: relax chipid check warning
      iio: light: stk3310: add support for stk3013
      dt-bindings: iio: light: stk33xx: add compatible for stk3013

Kim Seer Paller (6):
      iio: ABI: Generalize ABI documentation for DAC
      iio: ABI: add DAC 42kohm_to_gnd powerdown mode
      dt-bindings: iio: dac: Generalize DAC common properties
      dt-bindings: iio: dac: Add adi,ltc2664.yaml
      dt-bindings: iio: dac: Add adi,ltc2672.yaml
      iio: dac: ltc2664: Add driver for LTC2664 and LTC2672

Krzysztof Kozlowski (8):
      iio: accel: bma400: simplify with cleanup.h
      iio: adc: ad7280a: simplify with cleanup.h
      iio: adc: at91: simplify with cleanup.h
      iio: adc: max1363: simplify with cleanup.h
      iio: adc: ti-tsc2046: simplify with cleanup.h
      iio: magnetometer: ak8975: drop incorrect AK09116 compatible
      dt-bindings: iio: asahi-kasei,ak8975: drop incorrect AK09116 compatible
      dt-bindings: iio: st,stm32-adc: add top-level constraints

Marcelo Schmitt (7):
      spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
      spi: bitbang: Implement support for MOSI idle state configuration
      spi: spi-gpio: Add support for MOSI idle state configuration
      spi: spi-axi-spi-engine: Add support for MOSI idle configuration
      dt-bindings: iio: adc: Add AD4000
      iio: adc: Add support for AD4000
      Documentation: Add AD4000 documentation

Marek Vasut (8):
      dt-bindings: iio: light: ltrf216a: Document LTR-308 support
      iio: light: ltrf216a: Add LTR-308 support
      iio: light: noa1305: Simplify noa1305_read_raw()
      iio: light: noa1305: Assign val in noa1305_measure()
      iio: light: noa1305: Use static table lookup of scale values
      iio: light: noa1305: Report available scale values
      iio: light: noa1305: Make integration time configurable
      iio: light: noa1305: Fix up integration time look up

Matteo Martelli (4):
      iio: ABI: generalize shunt_resistor attribute
      dt-bindings: iio: adc: add binding for pac1921
      iio: adc: add support for pac1921
      iio: remove unneeded assignment in __iio_format_value

Matti Vaittinen (6):
      dt-bindings: iio: BU27034 => BU27034ANUC
      bu27034: ROHM BU27034NUC to BU27034ANUC
      bu27034: ROHM BU27034NUC to BU27034ANUC drop data2
      bu27034: ROHM BU27034ANUC correct gains and times
      bu27034: ROHM BU27034ANUC correct lux calculation
      iio: bu27034: Add a read only HARDWAREGAIN

Mudit Sharma (2):
      dt-bindings: iio: light: ROHM BH1745
      iio: light: ROHM BH1745 colour sensor

Nuno Sa (89):
      iio: core: add accessors 'masklength'
      iio: core: make use of iio_get_masklength()
      iio: buffer: make use of iio_get_masklength()
      iio: accel: adxl367: make use of iio_get_masklength()
      iio: accel: adxl372: make use of iio_get_masklength()
      iio: accel: bma180: make use of iio_for_each_active_channel()
      iio: accel: bmc150-accel-core: make use of iio_for_each_active_channel()
      iio: accel: cros_ec_accel_legacy: make use of iio_get_masklength()
      iio: accel: fxls8962af-core: make use of iio_for_each_active_channel()
      iio: accel: msa311: make use of iio_for_each_active_channel()
      iio: accel: sca3300: make use of iio_for_each_active_channel()
      iio: accel: stk8312: make use of iio_for_each_active_channel()
      iio: accel: stk8ba50: make use of iio_for_each_active_channel()
      iio: adc: ad7266: make use of iio_get_masklength()
      iio: adc: ad7298: make use of iio_get_masklength()
      iio: adc: ad799x: make use of iio_get_masklength()
      iio: adc: ad_sigma_delta: use new '.masklength' accessors
      iio: adc: at91_adc: make use of iio_for_each_active_channel()
      iio: imu: adis16475: make use of iio_for_each_active_channel()
      iio: imu: adis16480: make use of iio_for_each_active_channel()
      iio: adc: ad9467: support multiple channels calibration
      iio: adc: ad9467: add new chip_info variables
      iio: adc: ad9467: don't allow reading vref if not available
      dt-bindings: adc: ad9467: support new parts
      iio: adc: ad9467: support new parts
      iio: backend: remove unused parameter
      iio: backend: print message in case op is not implemented
      iio: adc: cc10001_adc: make use of iio_for_each_active_channel()
      iio: adc: dln2-adc: use new '.masklength' accessors
      iio: adc: hx711: make use of iio_for_each_active_channel()
      iio: dummy: iio_simple_dummy_buffer: use iio_for_each_active_channel()
      iio: health: afe4403: make use of iio_for_each_active_channel()
      iio: health: max30102: make use of iio_get_masklength()
      iio: health: afe4404: make use of iio_for_each_active_channel()
      iio: humidity: am2315: make use of iio_for_each_active_channel()
      iio: imu: bmi160_core: make use of iio_for_each_active_channel()
      iio: imu: bno055: make use of iio_get_masklength()
      iio: imu: kmx61: make use of iio_for_each_active_channel()
      iio: light: adjd_s311: make use of iio_for_each_active_channel()
      iio: light: gp2ap020a00f: make use of iio_for_each_active_channel()
      iio: light: isl29125: make use of iio_for_each_active_channel()
      iio: light: si1145: use new '.masklength' accessors
      iio: light: tcs3414: make use of iio_for_each_active_channel()
      iio: light: tcs3472: make use of iio_for_each_active_channel()
      iio: magnetometer: rm3100-core: make use of iio_get_masklength()
      iio: pressure: dlhl60d: make use of iio_for_each_active_channel()
      iio: proximity: hx9023s: make use of iio_for_each_active_channel()
      iio: proximity: sx9500: make use of iio_for_each_active_channel()
      iio: proximity: sx_common: make use of iio_for_each_active_channel()
      iio: accel: adxl380: make use of iio_get_masklength()
      iio: adc: max1118: make use of iio_for_each_active_channel()
      iio: adc: max1118: make use of iio_for_each_active_channel()
      iio: adc: mcp3911: make use of iio_for_each_active_channel()
      iio: adc: mt6360-adc: make use of iio_for_each_active_channel()
      iio: adc: rockchip_saradc: make use of iio_for_each_active_channel()
      iio: adc: rtq6056: make use of iio_for_each_active_channel()
      iio: adc: stm32-adc: make use of iio_get_masklength()
      iio: adc: stm32-dfsdm-adc: make use of iio_get_masklength()
      iio: adc: ti-adc0832: make use of iio_for_each_active_channel()
      iio: adc: ti-adc084s021: make use of iio_for_each_active_channel()
      iio: adc: ti-ads1015: make use of iio_get_masklength()
      iio: adc: ti-ads1119: make use of iio_get_masklength()
      iio: adc: ti-ads1298: make use of iio_for_each_active_channel()
      iio: adc: ti-adc12138: make use of iio_for_each_active_channel()
      iio: adc: ti-ads124s08: make use of iio_for_each_active_channel()
      iio: adc: ti-ads131e08: make use of iio_for_each_active_channel()
      iio: adc: ti-ads8688: make use of iio_for_each_active_channel()
      iio: adc: vf610_adc: make use of iio_get_masklength()
      iio: adc: xilinx-xadc-core: use new '.masklength' accessors
      iio: common: cros_ec_sensors_core: use new '.masklength' accessors
      staging: iio: impedance-analyzer: ad5933: make use of iio_get_masklength()
      iio: core: annotate masklength as __private
      iio: buffer-dma: Move exports into IIO_DMA_BUFFER namespace
      iio: backend: introduce struct iio_backend_info
      iio: backend: add debugFs interface
      iio: backend: add a modified prbs23 support
      iio: adc: adi-axi-adc: support modified prbs23
      iio: adc: adi-axi-adc: split axi_adc_chan_status()
      iio: adc: adi-axi-adc: implement backend debugfs interface
      iio: adc: ad9467: add backend test mode helpers
      iio: adc: ad9467: add digital interface test to debugfs
      iio: dac: adi-axi-dac: support debugfs direct_reg_access
      iio: dac: ad9739a: add backend debugfs interface
      MAINTAINERS: add entry for ad9467
      ABI: debugfs-iio-ad9467: document the debugfs interface
      iio: imu: adis16475: drop ifdef around CONFIG_DEBUG_FS
      iio: imu: adis16480: drop ifdef around CONFIG_DEBUG_FS
      iio: imu: adis16400: drop ifdef around CONFIG_DEBUG_FS
      iio: imu: adis16460: drop ifdef around CONFIG_DEBUG_FS

Olivier Moysan (9):
      iio: add read scale and offset services to iio backend framework
      iio: add enable and disable services to iio backend framework
      iio: add child nodes support in iio backend framework
      dt-bindings: iio: dfsdm: move to backend framework
      dt-bindings: iio: add backend support to sd modulator
      dt-bindings: iio: add vref support to sd modulator
      iio: adc: stm32-dfsdm: adopt generic channels bindings
      iio: add iio backend support to sd modulator
      iio: adc: stm32-dfsdm: add scaling support to dfsdm

Petar Stoykov (3):
      dt-bindings: iio: pressure: Add Sensirion SDP500
      iio: pressure: Add driver for Sensirion SDP500
      MAINTAINERS: Add Sensirion SDP500

Rayyan Ansari (3):
      dt-bindings: iio: kionix,kxcjk1013: Document KX022-1020
      iio: accel: kxcjk-1013: Add support for KX022-1020
      dt-bindings: iio: magnetometer: bmc150: Document mount-matrix

Rob Herring (Arm) (1):
      iio: adc: aspeed: Use of_property_present()

Thorsten Blum (1):
      iio: common: scmi_iio: Remove unnecessary u64 type cast

Vasileios Amoiridis (22):
      iio: chemical: bme680: Fix read/write ops to device by adding mutexes
      iio: chemical: bme680: Fix typo in define
      iio: chemical: bme680: Drop unnecessary casts and correct adc data types
      iio: chemical: bme680: Remove remaining ACPI-only stuff
      iio: chemical: bme680: Sort headers alphabetically
      iio: chemical: bme680: Remove duplicate register read
      iio: chemical: bme680: Use bulk reads for calibration data
      iio: chemical: bme680: Allocate IIO device before chip initialization
      iio: chemical: bme680: Add read buffers in read/write buffer union
      iio: chemical: bme680: Make error checks consistent
      iio: chemical: bme680: Modify startup procedure
      iio: chemical: bme680: Move probe errors to dev_err_probe()
      iio: chemical: bme680: Remove redundant gas configuration
      iio: chemical: bme680: Move forced mode setup in ->read_raw()
      iio: chemical: bme680: Refactorize reading functions
      iio: pressure: bmp280: Generalize read_*() functions
      iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
      iio: pressure: bmp280: Add triggered buffer support
      iio: pressure: bmp280: Fix regmap for BMP280 device
      iio: pressure: bmp280: Fix waiting time for BMP3xx configuration
      iio: pressure: bmp280: Sort headers alphabetically
      chemical: bme680: Convert to static the const lookup table

Yang Ruibin (1):
      drivers:iio:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()

Yasin Lee (3):
      dt-bindings: vendor-prefixes: add tyhx
      dt-bindings: iio: proximity: Add TYHX HX9023S
      iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor

 Documentation/ABI/testing/debugfs-iio-ad9467       |   39 +
 Documentation/ABI/testing/debugfs-iio-backend      |   20 +
 Documentation/ABI/testing/sysfs-bus-iio            |   73 +-
 .../ABI/testing/sysfs-bus-iio-adc-max9611          |   17 -
 .../ABI/testing/sysfs-bus-iio-chemical-sgp40       |   14 -
 Documentation/ABI/testing/sysfs-bus-iio-dac        |   61 +
 .../ABI/testing/sysfs-bus-iio-dac-ltc2688          |   31 -
 .../ABI/testing/sysfs-bus-iio-filter-admv8818      |    2 +-
 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc |    9 -
 .../devicetree/bindings/iio/accel/adi,adxl380.yaml |   92 +
 .../bindings/iio/accel/kionix,kxcjk1013.yaml       |    1 +
 .../devicetree/bindings/iio/adc/adi,ad4000.yaml    |  197 ++
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |  254 +++
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |   33 +-
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |   13 +
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  123 +-
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |    3 +
 .../bindings/iio/adc/microchip,pac1921.yaml        |   71 +
 .../bindings/iio/adc/rockchip-saradc.yaml          |    3 +
 .../bindings/iio/adc/sigma-delta-modulator.yaml    |   25 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |    4 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |  122 +-
 .../devicetree/bindings/iio/dac/adi,ltc2664.yaml   |  181 ++
 .../devicetree/bindings/iio/dac/adi,ltc2672.yaml   |  160 ++
 Documentation/devicetree/bindings/iio/dac/dac.yaml |   50 +
 .../bindings/iio/frequency/adi,adf4377.yaml        |   10 +
 .../bindings/iio/humidity/sciosense,ens210.yaml    |   55 +
 .../bindings/iio/light/liteon,ltrf216a.yaml        |    4 +-
 .../devicetree/bindings/iio/light/rohm,bh1745.yaml |   53 +
 .../{rohm,bu27034.yaml => rohm,bu27034anuc.yaml}   |   11 +-
 .../devicetree/bindings/iio/light/stk33xx.yaml     |   13 +-
 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |    1 -
 .../iio/magnetometer/bosch,bmc150_magn.yaml        |    3 +
 .../bindings/iio/pressure/sensirion,sdp500.yaml    |   46 +
 .../bindings/iio/proximity/tyhx,hx9023s.yaml       |   93 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 Documentation/iio/ad4000.rst                       |  131 ++
 Documentation/iio/ad4695.rst                       |  162 ++
 Documentation/iio/ad7380.rst                       |  130 ++
 Documentation/iio/adxl380.rst                      |  233 +++
 Documentation/iio/index.rst                        |    4 +
 Documentation/spi/spi-summary.rst                  |   83 +
 MAINTAINERS                                        |   73 +
 drivers/iio/accel/Kconfig                          |   27 +
 drivers/iio/accel/Makefile                         |    3 +
 drivers/iio/accel/adxl367.c                        |    2 +-
 drivers/iio/accel/adxl367_spi.c                    |    2 +-
 drivers/iio/accel/adxl372.c                        |    2 +-
 drivers/iio/accel/adxl380.c                        | 1905 ++++++++++++++++++++
 drivers/iio/accel/adxl380.h                        |   26 +
 drivers/iio/accel/adxl380_i2c.c                    |   64 +
 drivers/iio/accel/adxl380_spi.c                    |   66 +
 drivers/iio/accel/bma180.c                         |    3 +-
 drivers/iio/accel/bma400_core.c                    |   11 +-
 drivers/iio/accel/bma400_spi.c                     |    2 +-
 drivers/iio/accel/bmc150-accel-core.c              |    3 +-
 drivers/iio/accel/bmi088-accel-spi.c               |    2 +-
 drivers/iio/accel/cros_ec_accel_legacy.c           |    2 +-
 drivers/iio/accel/fxls8962af-core.c                |    3 +-
 drivers/iio/accel/kxcjk-1013.c                     |    8 +-
 drivers/iio/accel/msa311.c                         |    3 +-
 drivers/iio/accel/sca3300.c                        |    3 +-
 drivers/iio/accel/stk8312.c                        |    3 +-
 drivers/iio/accel/stk8ba50.c                       |    3 +-
 drivers/iio/adc/Kconfig                            |   38 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/ad4000.c                           |  722 ++++++++
 drivers/iio/adc/ad4695.c                           |  978 ++++++++++
 drivers/iio/adc/ad7091r8.c                         |    2 +-
 drivers/iio/adc/ad7124.c                           |   34 +-
 drivers/iio/adc/ad7192.c                           |  183 +-
 drivers/iio/adc/ad7266.c                           |    3 +-
 drivers/iio/adc/ad7280a.c                          |   10 +-
 drivers/iio/adc/ad7298.c                           |    3 +-
 drivers/iio/adc/ad7380.c                           |  525 +++++-
 drivers/iio/adc/ad7606.c                           |   47 +-
 drivers/iio/adc/ad7606_spi.c                       |    5 +-
 drivers/iio/adc/ad7768-1.c                         |    5 +-
 drivers/iio/adc/ad799x.c                           |    3 +-
 drivers/iio/adc/ad9467.c                           |  487 ++++-
 drivers/iio/adc/ad_sigma_delta.c                   |    6 +-
 drivers/iio/adc/adi-axi-adc.c                      |   71 +-
 drivers/iio/adc/aspeed_adc.c                       |    3 +-
 drivers/iio/adc/at91_adc.c                         |   17 +-
 drivers/iio/adc/cc10001_adc.c                      |    4 +-
 drivers/iio/adc/dln2-adc.c                         |    8 +-
 drivers/iio/adc/hx711.c                            |    5 +-
 drivers/iio/adc/ina2xx-adc.c                       |    3 +-
 drivers/iio/adc/max1118.c                          |    3 +-
 drivers/iio/adc/max1363.c                          |   34 +-
 drivers/iio/adc/mcp3564.c                          |   54 +-
 drivers/iio/adc/mcp3911.c                          |   61 +-
 drivers/iio/adc/mt6360-adc.c                       |    2 +-
 drivers/iio/adc/pac1921.c                          | 1261 +++++++++++++
 drivers/iio/adc/rockchip_saradc.c                  |    2 +-
 drivers/iio/adc/rtq6056.c                          |    2 +-
 drivers/iio/adc/sd_adc_modulator.c                 |   97 +-
 drivers/iio/adc/stm32-adc.c                        |    4 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  295 ++-
 drivers/iio/adc/ti-adc0832.c                       |    3 +-
 drivers/iio/adc/ti-adc084s021.c                    |    3 +-
 drivers/iio/adc/ti-adc12138.c                      |    3 +-
 drivers/iio/adc/ti-ads1015.c                       |    2 +-
 drivers/iio/adc/ti-ads1119.c                       |    4 +-
 drivers/iio/adc/ti-ads124s08.c                     |    3 +-
 drivers/iio/adc/ti-ads1298.c                       |    3 +-
 drivers/iio/adc/ti-ads131e08.c                     |    2 +-
 drivers/iio/adc/ti-ads8688.c                       |    4 +-
 drivers/iio/adc/ti-tsc2046.c                       |   83 +-
 drivers/iio/adc/vf610_adc.c                        |    2 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    5 +-
 drivers/iio/buffer/industrialio-buffer-cb.c        |    2 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |   36 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    1 +
 drivers/iio/buffer/industrialio-hw-consumer.c      |    4 +-
 drivers/iio/chemical/bme680.h                      |   41 +-
 drivers/iio/chemical/bme680_core.c                 |  633 +++----
 drivers/iio/chemical/bme680_spi.c                  |    2 +-
 drivers/iio/chemical/sgp40.c                       |   11 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |    8 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    2 +-
 drivers/iio/dac/Kconfig                            |   11 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad9739a.c                          |   13 +-
 drivers/iio/dac/adi-axi-dac.c                      |   21 +-
 drivers/iio/dac/ltc2664.c                          |  735 ++++++++
 drivers/iio/dac/ltc2688.c                          |    2 +-
 drivers/iio/dac/mcp4728.c                          |   45 +-
 drivers/iio/dac/mcp4922.c                          |   47 +-
 drivers/iio/dac/ti-dac7311.c                       |    4 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |    2 +-
 drivers/iio/frequency/adf4377.c                    |   35 +-
 drivers/iio/health/afe4403.c                       |    3 +-
 drivers/iio/health/afe4404.c                       |    3 +-
 drivers/iio/health/max30102.c                      |    2 +-
 drivers/iio/humidity/Kconfig                       |   11 +
 drivers/iio/humidity/Makefile                      |    1 +
 drivers/iio/humidity/am2315.c                      |    3 +-
 drivers/iio/humidity/ens210.c                      |  339 ++++
 drivers/iio/imu/adis16400.c                        |   18 +-
 drivers/iio/imu/adis16460.c                        |   18 +-
 drivers/iio/imu/adis16475.c                        |   12 +-
 drivers/iio/imu/adis16480.c                        |   20 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |    3 +-
 drivers/iio/imu/bmi323/bmi323.h                    |    1 +
 drivers/iio/imu/bmi323/bmi323_core.c               |   23 +
 drivers/iio/imu/bmi323/bmi323_i2c.c                |    3 +-
 drivers/iio/imu/bmi323/bmi323_spi.c                |    3 +-
 drivers/iio/imu/bno055/bno055.c                    |    2 +-
 drivers/iio/imu/bno055/bno055_ser_core.c           |    2 +-
 drivers/iio/imu/kmx61.c                            |    3 +-
 drivers/iio/industrialio-backend.c                 |  264 ++-
 drivers/iio/industrialio-buffer.c                  |   52 +-
 drivers/iio/industrialio-core.c                    |   46 +-
 drivers/iio/industrialio-trigger.c                 |   27 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/adjd_s311.c                      |    3 +-
 drivers/iio/light/apds9960.c                       |   55 +-
 drivers/iio/light/bh1745.c                         |  906 ++++++++++
 drivers/iio/light/gp2ap002.c                       |    2 +-
 drivers/iio/light/gp2ap020a00f.c                   |    9 +-
 drivers/iio/light/isl29125.c                       |    3 +-
 drivers/iio/light/ltr390.c                         |  241 ++-
 drivers/iio/light/ltrf216a.c                       |   53 +-
 drivers/iio/light/noa1305.c                        |  169 +-
 drivers/iio/light/rohm-bu27034.c                   |  337 +---
 drivers/iio/light/si1145.c                         |    7 +-
 drivers/iio/light/stk3310.c                        |    7 +-
 drivers/iio/light/tcs3414.c                        |    3 +-
 drivers/iio/light/tcs3472.c                        |    3 +-
 drivers/iio/magnetometer/ak8975.c                  |    1 -
 drivers/iio/magnetometer/rm3100-core.c             |    2 +-
 drivers/iio/pressure/Kconfig                       |   11 +
 drivers/iio/pressure/Makefile                      |    1 +
 drivers/iio/pressure/bmp280-core.c                 |  654 ++++++-
 drivers/iio/pressure/bmp280-i2c.c                  |    2 +-
 drivers/iio/pressure/bmp280-regmap.c               |   45 +-
 drivers/iio/pressure/bmp280-spi.c                  |   18 +-
 drivers/iio/pressure/bmp280.h                      |   37 +-
 drivers/iio/pressure/dlhl60d.c                     |    3 +-
 drivers/iio/pressure/sdp500.c                      |  156 ++
 drivers/iio/proximity/Kconfig                      |   14 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/hx9023s.c                    | 1144 ++++++++++++
 drivers/iio/proximity/sx9500.c                     |    3 +-
 drivers/iio/proximity/sx_common.c                  |    6 +-
 drivers/spi/spi-axi-spi-engine.c                   |   15 +-
 drivers/spi/spi-bitbang.c                          |   24 +
 drivers/spi/spi-gpio.c                             |   12 +-
 drivers/spi/spi.c                                  |    6 +
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    5 +-
 include/dt-bindings/iio/adi,ad4695.h               |    9 +
 include/linux/iio/backend.h                        |   62 +-
 include/linux/iio/iio.h                            |   39 +-
 include/linux/spi/spi_bitbang.h                    |    1 +
 include/uapi/linux/spi/spi.h                       |    5 +-
 197 files changed, 14743 insertions(+), 1805 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-iio-ad9467
 create mode 100644 Documentation/ABI/testing/debugfs-iio-backend
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/sciosense,ens210.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
 rename Documentation/devicetree/bindings/iio/light/{rohm,bu27034.yaml => rohm,bu27034anuc.yaml} (66%)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
 create mode 100644 Documentation/iio/ad4000.rst
 create mode 100644 Documentation/iio/ad4695.rst
 create mode 100644 Documentation/iio/ad7380.rst
 create mode 100644 Documentation/iio/adxl380.rst
 create mode 100644 drivers/iio/accel/adxl380.c
 create mode 100644 drivers/iio/accel/adxl380.h
 create mode 100644 drivers/iio/accel/adxl380_i2c.c
 create mode 100644 drivers/iio/accel/adxl380_spi.c
 create mode 100644 drivers/iio/adc/ad4000.c
 create mode 100644 drivers/iio/adc/ad4695.c
 create mode 100644 drivers/iio/adc/pac1921.c
 create mode 100644 drivers/iio/dac/ltc2664.c
 create mode 100644 drivers/iio/humidity/ens210.c
 create mode 100644 drivers/iio/light/bh1745.c
 create mode 100644 drivers/iio/pressure/sdp500.c
 create mode 100644 drivers/iio/proximity/hx9023s.c
 create mode 100644 include/dt-bindings/iio/adi,ad4695.h

