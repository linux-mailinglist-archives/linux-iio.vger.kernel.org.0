Return-Path: <linux-iio+bounces-14132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9EA0A3D8
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 14:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506CF3A6599
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1657BE46;
	Sat, 11 Jan 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBuc21Er"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FE31A724C
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601677; cv=none; b=fS1gUxxgnCtMrF8BAJ/N9CJwwUAl0dwoq6nL20PbglZwuOilYLSz51tJiYxQJ2sHz3Won02Ar+EnSyOcZS3y5hTJOTu0WmcTwaeyARLDBs55nH+OX++7Jpf4w1vWK7UrYD1qESOsvBnzLFF5fKq3mnBiLCLqR6znAo3MkxpXb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601677; c=relaxed/simple;
	bh=/nxh79xkS29+1lTBswn7Hd46iF2ZH4sgPK/kmhPnZ9Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=eo9JHsZPqP4PdUMMIHXe8KdtsQxkEsA9r0OrC9GkEVZ3Ln4q/nEdQyqeNyPiaWu2O1hPdikUJg6GiazJQhnDjB9VtnLJbmsmqRKvVL89uVOqKzPQXQiQZ0c4kvP6jQoGogIP8Lf8930p6opxa0a5IcF00pARj3CrLs8ZVwejGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBuc21Er; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF336C4CEDF;
	Sat, 11 Jan 2025 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736601677;
	bh=/nxh79xkS29+1lTBswn7Hd46iF2ZH4sgPK/kmhPnZ9Q=;
	h=Date:From:To:Subject:From;
	b=pBuc21ErMTOXYm5SKddULe2upzEW2qKg0CkJRxGhYPdGc2Xw1xIRpjLDASx0SXM2V
	 ly18lgsHiRbH+DRzgzLZXVaEuDKFLqlMqRlDd2TmUUysrjJrG9UJt4AUhEmO3RPrDA
	 387wMgmfmNfY86YEyKLARc9WOUGZ18hfRPhy0Oj1NG5mgRmJlgKhGwmKp8E9Lh/PmG
	 XQlFVFSKsylAiCE/OF7VxLpm1V+uC76/VDd1UqQl9r24IuPVNMZibvGKHd7q0S0RLi
	 xX8u7Kap1Y+l6TgYufvcpWR9cCNc+6QyvQK2O5sLzLsroeiI3B2R+LUY4DbjW6KWrb
	 VaeMyxS4XE4MQ==
Date: Sat, 11 Jan 2025 13:21:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of new device support, features and cleanup for
 6.14
Message-ID: <20250111132110.0b2d4fa2@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit cdd30ebb1b9f36159d66f088b61aee264e649d7a:

  module: Convert symbol namespace to string literal (2024-12-02 11:34:44 -=
0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.14a

for you to fetch changes up to 577a66e2e634f712384c57a98f504c44ea4b47da:

  iio: iio-mux: kzalloc instead of devm_kzalloc to ensure page alignment (2=
025-01-04 14:48:17 +0000)

----------------------------------------------------------------
IIO: 1st set of new device support, features and cleanup for 6.14

Fairly quiet cycle. Usual mix of new drivers, device support in
existing drivers, features and more general rework and cleanup.
There are a few late breaking or long standing but complex fixes
in here as well.

There is one expected merge conflict due to an upstream fix touching
neighboring code in ti-ads1119. The trivial resolution is the right one with
the result ending up as:

	struct {
		s16 sample;
		aligned_s64 timestamp;
	} scan;

New device support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

adi,ad4000
- Add support for many Pulsar ADC devices: AD7685, AD7686, AD7687, AD7688,
  AD7690, AD7691, AD7693, AD7942, AD7946, AD7980, AD7982, AD7983, AD7984,
  AD7988-1 and AD7988-5 ADCs. Generally similar to the AD4000 series
  but with lower sampling rates and no configuration registers.
  Includes addition of timestamp channels.
adi,adis16480
- Add support for ADIS16486, ADIS16487 and ADIS16489 IMUs. Required a few t=
weaks
  to existing driver and addition of tables.
kionix,kx022a
- Add support for KX134ACR-LBZ accelerometer that is similar to the
  KX132ACR-LBZ but with a wider (+-64G) sensor range.
- Add support for KX134-1211 accelerometer that is similar to the
  KX132-1211 but with a wider (+-16G) sensor range.
nxp,fxls8962af
- Add support for fxls8974cf and fxls8967af accelerometers, Both are
  compatible with fxls8962af but with different device IDs which are used in
  presence checks.
renesas,rzg2l
- Add support for Renesas RZ/GS3 SoC ADCs (various driver refactors
  precede this to allow for chip differences).
rohm,bd79704
- New driver for this 6 channel DAC.
st,mpu6050
- Support he IAM20380 which is effectively a cut down IAM20608 IMU with only
  a gyroscope (no accelerometer).
st,stm-timmer-trigger
- Add support for ADC trigger use case for the STM32MP25 SOC. Do not support
  the counter functionality in this driver as that is handled by the
  counter subsystem.
ti,opt4060
- New driver for this RGBW color sensor.

Driver drop
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

rohm,bu20008
- Drop as decision was made to not mass produce this light sensor after
  Matti had done all the work to get a driver upstream.

Features
=3D=3D=3D=3D=3D=3D=3D=3D

adi,ad_sigma_delta library + ad7124
- Allow for GPIO to check interrupt status, enabling this device on
  more platforms that don't obey prior (non general) assumptions on
  how the interrupt chips work.
- Allow variation in reset sequence length allowing chip specific
  optimizations rather than always using worst case.
adi,ad7124
- Add temperature channel support.
adi,ad7173
- Add support calibration modes for this family of ADCs.
adi,adxl345
- Binding update to allow specification of which interrupt line is
  connected (or none).
- Support interrupts and FIFO based data capture.
bosch,bme680
- Add regulators support. Note this required a new binding doc rather than
  use of trivial-devices
- Runtime PM support.
microchip,pac1921
- Add ACPI support including _DSM for shunt value and label.
renesas,rzg2l
- Enable runtime autosuspend.
- Add suspend and resume support.
tyhx,hx9023s
- Add loading of a firmware file used to set defaults for some
  configuration registers.
vishay,veml6030
- Support triggered buffers allowing efficient data capture at
  higher speeds.
- Add regmap cache to reduce access to device.

Cleanup and minor fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

cross-tree
- Another batch of conversions to devm_regulator_get_enable_read_voltage()
  helper and related conversions to full devm that this enables.
- Various patches using guard() to allow early returns and simpler
  code flow.
- Various conversions from s64 timestamp __aligned(8) to aligned_s64 type.
  Includes a few cleanups where this unsigned and it should have been
  signed.
- Fix up some missing types for drive-open-drain in dt-binding docs.
core
- Add missing documentation for iio_dmaengine_buffer_setup_ext()
- Add check that all buffers passed to iio_read_channel_ext_info()
  and iio_read_channel_label() are page sized and page aligned.
  Done this way because the callbacks are almost always only used
  to fill sysfs attributes. The check covers the tiny percentage
  of cases where use is made of this data in a consumer driver.
- Mark scan_timestamp memory of struct iio_dev private ensuring no
  drivers change the value which belongs to the IIO core.
documentation
- Various missing ABI docs added.
- ABI docs made to use Y consistently as the wildcard for channel
  number.
- Combine duplicate in_currentY_raw entries in ABI docs.
iio-mux
- Fix alignment of buffers passed to iio_channel_read_ext_info().
adi,ad_sigma_delta library
- Respect keep_cs_asserted flag in read path.
- Close a race condition around irq enabling and disabling.
- Use explicit unsigned int in place of unsigned.
adi,ad6695
- Move dt-binding header under adc sub-directory and fix include path in dt
  example.
adi,ad7124
- Check number of channels in DT doesn't exceed what the driver can handle.
- Check input specified in DT are possible.
- Improved error reporting during probe.
adi,ad7173
- Drop unused structure element.
adi,ad7293
- Ensure power is turned on before resetting.
adi,adxl345
- Some documentation simplification and parameter renames.
- Add a function than unifies handling of power up and power down.
- Add defines to have a complete set of registers defined.
- Add missing \n to end of error messages.
amlogic,meson_saradc
- Simplify handling of the REG11 register access.
awinic,aw96104
- Constify iio_info structure.
bosch,bmp085
- Add to dt-binding to indicate devices support SPI.
bosch,bmp280
- Use sizeof() to replace a somewhat magic 2.
- Rename sleep related variables so the unit is included and use
  fsleep() to replace usleep_range() calls.
bosch,bno055
- Constify struct bin_attribute
capella,cm3232
- Reset device before checking hardware ID inline with suggested flow
  from datasheet.
diolan,dln2
- Simplify zeroing of structure used to gather up data by just
  clearing the whole thing before writing rather than trying to
  clear out he padding after write.
freescale,vf610
- Use devm_ and dev_error_probe() to simplify code and allow dropping
  of explicit remove() callback.
invensense,timestamp library
- Use a cast to remove possibility of integer overflow.
kionix,kx022a
- Increase reset delay a little.
maxim,max1363
- Use a buffer of sufficient size in iio_priv() rather than allocating
  variable sized buffer at use time.
microchip,mcp4725
- Replace of_property_read_bool() with of_property_present() for
  detecting presence of regulator which is obviously not a bool.
nxp,fxls8962af
- Add wakeup-source property to the dt binding to allow these sensors
  to wake the system up from suspend.
- Enable finer grained build when not all bus types need to be supported.
renesas,rzg2l
- Use dev_err_probe(), improving handling of probe errors and simplifying
  code.
- Convert to devm_ based cleanup.
- Remove unnecessary runtime PM complexity as clocks are managed through
  PM domains.
- Switch pm_ptr() removing need for __maybe_unused markings.
- use read_poll_timeout() to replace open coded equivalent.
samsung, ssp_sensors
- Simplify code by always providing timestamp whether or not it
  is enabled.
st,lsm6dsx
- Avoid need to include linux/i3c/master by using i3cdev_to_dev() to
  get to the contained struct device.
st,stm32-timer-trigger
- Check for clk_enable() fails.
vishay,veml6030
- Use new gts-helper functions and fix the _scale attribute to take into
  account changes in gain and integration time.

Various other typo fixes in variable names + documentation and help text.
A few whitespace cleanup patches.

----------------------------------------------------------------
Christophe JAILLET (1):
      iio: proximity: aw96103: Constify struct iio_info=E2=80=8B

Cibil Pankiras (1):
      iio: light: cm3232: Reset before reading HW ID

Claudiu Beznea (12):
      iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
      iio: adc: rzg2l_adc: Use devres helpers to request pre-deasserted res=
et controls
      iio: adc: rzg2l_adc: Simplify the runtime PM code
      iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
      iio: adc: rzg2l_adc: Use read_poll_timeout()
      iio: adc: rzg2l_adc: Simplify the locking scheme in rzg2l_adc_read_ra=
w()
      iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
      iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
      iio: adc: rzg2l_adc: Add support for channel 8
      iio: adc: rzg2l_adc: Add suspend/resume support
      dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/G3S SoC
      iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S

Darius Berghe (3):
      iio: imu: adis16480: add devices to adis16480 driver
      iio: imu: adis16480: add devices to adis16480 - docs
      dt-bindings: iio: adis16480: add devices to adis16480

David Lechner (17):
      iio: adc: ad7173: remove unused field
      iio: dac: ad5624r: fix struct name in doc comment
      iio: dac: ad5686: fix struct name in doc comment
      iio: dac: ad5686: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad8801: use devm_regulator_get_enable_read_voltage()
      iio: dac ad8801: drop driver remove function
      iio: dac: ltc2632: use devm_regulator_get_enable_read_voltage()
      iio: dac ltc2632: drop driver remove function
      iio: dac: ltc2688: use devm_regulator_get_enable_read_voltage()
      iio: dac: max5821: use devm_regulator_get_enable_read_voltage()
      iio: adc: ad4695: move dt-bindings header
      dt-bindings: iio: adc: adi,ad4695: change include path
      iio: buffer-dmaengine: document iio_dmaengine_buffer_setup_ext
      iio: adc: ad_sigma_delta: add tab to align irq_line
      iio: ABI: use Y consistently as channel number
      iio: dac: ad7293: enable power before reset
      iio: ABI: combine current input sections

Fabrice Gasnier (1):
      iio: trigger: stm32-timer: add support for stm32mp25

Frank Li (2):
      iio: adc: vf610_adc: use devm_* and dev_err_probe() to simple code
      iio: adc: vf610_adc: limit i.MX6SX's channel number to 4

Guenter Roeck (1):
      iio: imu: lsm6dsx: Use i3cdev_to_dev to get device pointer

Guillaume Ranquet (2):
      iio: adc: ad7173: add calibration support
      iio: adc: ad-sigma-delta: Document ABI for sigma delta adc

Haibo Chen (1):
      iio: accel: fxls8962af: add fxls8974cf support

Han Xu (5):
      dt-bindings: iio: accel: fxls8962af: add compatible string 'nxp,fxls8=
967af'
      dt-bindings: iio: accel: fxls8962af: add compatible string 'nxp,fxls8=
974cf'
      iio: accel: fxls8962af: add fxls8967af support
      dt-bindings: iio: imu: mpu6050: Add invensense,iam20380 compatible st=
ring
      iio: gyro: Add support for iam20380 sensor

Javier Carrasco (7):
      iio: core: fix doc reference to iio_push_to_buffers_with_ts_unaligned
      iio: light: veml6030: add support for triggered buffer
      iio: ABI: document in_illuminance_hardwaregain
      iio: light: veml3235: fix code style
      iio: light: veml3235: extend regmap to add cache
      iio: gts-helper: add helpers to ease searches of gain_sel and new_gain
      iio: light: veml3235: fix scale to conform to ABI

Jiasheng Jiang (1):
      iio: trigger: stm32-timer-trigger: Add check for clk_enable()

Jonathan Cameron (18):
      iio: adc: ad7944: Fix sign and use aligned_s64 for timestamp.
      io: adc: ina2xx-adc: Fix sign and use aligned_s64 for timestamp.
      iio: temperature: tmp006: Use aligned_s64 instead of open coding alig=
nment.
      iio: resolver: ad2s1210: Use aligned_s64 instead of open coding align=
ment.
      iio: proximity: Use aligned_s64 instead of open coding alignment.
      iio: pressure: Use aligned_s64 instead of open coding alignment.
      iio: magnetometer: Use aligned_s64 instead of open coding alignment.
      iio: light: Use aligned_s64 instead of open coding alignment.
      iio: imu: Use aligned_s64 instead of open coding alignment.
      iio: humidity: Use aligned_s64 instead of open coding alignment.
      iio: gyro: Use aligned_s64 instead of open coding alignment.
      iio: chemical: Use aligned_s64 instead of open coding alignment.
      iio: adc: Use aligned_s64 instead of open coding alignment.
      iio: accel: bma220: Use aligned_s64 instead of open coding alignment.
      iio: adc: ti-lmp92064: Switch timestamp type from int64_t __aligned(8=
) to aligned_s64
      iio: chemical: scd4x: switch timestamp type from int64_t __aligned(8)=
 to aligned_s64
      iio: imu: inv_icm42600: switch timestamp type from int64_t __aligned(=
8) to aligned_s64
      iio: adc: rockchip: correct alignment of timestamp

Karan Sanghavi (2):
      iio: invensense: Prevent possible integer overflow while multiplicati=
on
      iio: dac: Fix converters spelling typo.

Lothar Rubusch (9):
      iio: accel: adxl345: refrase comment on probe
      iio: accel: adxl345: rename variable data to st
      iio: accel: adxl345: add function to switch measuring mode
      dt-bindings: iio: accel: adxl345: make interrupts not a required prop=
erty
      dt-bindings: iio: accel: adxl345: add interrupt-names
      iio: accel: adxl345: introduce interrupt handling
      iio: accel: adxl345: initialize FIFO delay value for SPI
      iio: accel: adxl345: add FIFO with watermark events
      iio: accel: adxl345: complete the list of defines

Marcelo Schmitt (4):
      dt-bindings: iio: adc: adi,ad4000: Add PulSAR
      iio: adc: ad4000: Add timestamp channel
      iio: adc: ad4000: Use device specific timing for SPI transfers
      iio: adc: ad4000: Add support for PulSAR devices

Martin Blumenstingl (3):
      iio: adc: meson: fix voltage reference selection field name typo
      iio: adc: meson: use tabs instead of spaces for some REG11 bit fields
      iio: adc: meson: simplify MESON_SAR_ADC_REG11 register access

Matteo Martelli (2):
      iio: consumers: ensure read buffers for labels and ext_info are page =
aligned
      iio: iio-mux: kzalloc instead of devm_kzalloc to ensure page alignment

Matti Vaittinen (16):
      iio: accel: kx022a: Improve reset delay
      iio: bu27034: simplify using guard(mutex)
      iio: bm1390: simplify using guard(mutex)
      iio: light: Drop BU27008 and BU27010
      dt-bindings: iio: light: Drop BU27008 and BU27010
      iio: accel: kx022a: Use cleanup.h helpers
      iio: accel: kx022a: Support ICs with different G-ranges
      dt-bindings: ROHM KX134ACR-LBZ
      iio: kx022a: Support ROHM KX134ACR-LBZ
      dt-bindings: iio: kx022a: Support KX134-1211
      iio: accel: kx022a: Support KX134-1211
      iio: kx022a: document new chip_info structure members
      iio: dac: ad5624r: Drop docs of missing members
      dt-bindings: Add ROHM BD79703
      iio: dac: Support ROHM BD79703 DAC
      MAINTAINERS: Add maintainer for ROHM BD79703

Per-Daniel Olsson (2):
      dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
      iio: light: Add support for TI OPT4060 color sensor

Rob Herring (Arm) (1):
      iio: dac: mcp4725: Use of_property_present() for non-boolean properti=
es

Robert Budai (1):
      iio: imu: adis: Remove documented not used elements

Sean Nyekjaer (2):
      dt-bindings: iio: accel: fxls8962af: add wakeup-source property
      iio: imu: st_lsm6dsx: don't always auto-enable I2C, I3C and SPI inter=
face drivers

Thomas Wei=C3=9Fschuh (1):
      iio: imu: bno055: constify 'struct bin_attribute'

Uwe Kleine-K=C3=B6nig (12):
      iio: adc: ad7124: Don't create more channels than the driver can hand=
le
      iio: adc: ad7124: Refuse invalid input specifiers
      dt-bindings: iio: adc: adi,ad7{124,173,192,780}: Allow specifications=
 of a gpio for irq line
      iio: adc: ad_sigma_delta: Add support for reading irq status using a =
GPIO
      iio: adc: ad_sigma_delta: Handle CS assertion as intended in ad_sd_re=
ad_reg_raw()
      iio: adc: ad_sigma_delta: Fix a race condition
      iio: adc: ad_sigma_delta: Store information about reset sequence leng=
th
      iio: adc: ad_sigma_delta: Check for previous ready signals
      iio: adc: ad7124: Add error reporting during probe
      iio: adc: ad7124: Implement temperature measurement
      iio: adc: ad_sigma_delta: Use `unsigned int` instead of plain `unsign=
ed`
      iio: adc: ad7625: Add ending newlines to error messages

Vasileios Amoiridis (13):
      dt-bindings: iio: bosch,bme680: Move from trivial-devices and add sup=
plies
      iio: chemical: bme680: add regulators
      iio: chemical: bme680: add power management
      iio: pressure: bmp280: Use sizeof() for denominator
      iio: pressure: bmp280: Make time vars intuitive and move to fsleep
      dt-bindings: iio: pressure: bmp085: Add SPI interface
      iio: adc: dln2-adc: zero full struct instead of just the padding
      iio: adc: max1363: Use a small fixed size buffer to replace dynamic a=
llocation
      iio: common: ssp_sensors: drop conditional optimization for simplicity
      iio: core: mark scan_timestamp as __private
      dt-bindings: iio: imu: bmi160: add boolean type for drive-open-drain
      dt-bindings: iio: imu: bmi270: add boolean type for drive-open-drain
      dt-bindings: iio: imu: bmi323: add boolean type for drive-open-drain

Victor Duicu (1):
      iio: adc: pac1921: Add ACPI support to Microchip pac1921

Yasin Lee (1):
      iio: proximity: hx9023s: Added firmware file parsing functionality

 Documentation/ABI/testing/sysfs-bus-iio            |   77 +-
 .../ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta   |   23 +
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 |   24 -
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |   11 +-
 .../bindings/iio/accel/kionix,kx022a.yaml          |   11 +-
 .../bindings/iio/accel/nxp,fxls8962af.yaml         |   20 +-
 .../devicetree/bindings/iio/adc/adi,ad4000.yaml    |   75 +-
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |   13 +
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |   12 +
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |   15 +
 .../devicetree/bindings/iio/adc/adi,ad7780.yaml    |   11 +
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |   37 +-
 .../bindings/iio/chemical/bosch,bme680.yaml        |   62 +
 .../devicetree/bindings/iio/dac/rohm,bd79703.yaml  |   62 +
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml |   42 +-
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |    1 +
 .../devicetree/bindings/iio/imu/bosch,bmi270.yaml  |    1 +
 .../devicetree/bindings/iio/imu/bosch,bmi323.yaml  |    1 +
 .../bindings/iio/imu/invensense,mpu6050.yaml       |    1 +
 .../bindings/iio/light/rohm,bu27008.yaml           |   49 -
 .../bindings/iio/light/rohm,bu27010.yaml           |   50 -
 .../devicetree/bindings/iio/light/ti,opt4060.yaml  |   51 +
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |   29 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 Documentation/iio/ad4695.rst                       |    2 +-
 Documentation/iio/adis16480.rst                    |    3 +
 Documentation/iio/index.rst                        |    1 +
 Documentation/iio/opt4060.rst                      |   61 +
 MAINTAINERS                                        |    8 +-
 drivers/iio/accel/adxl345.h                        |   81 +-
 drivers/iio/accel/adxl345_core.c                   |  417 ++++-
 drivers/iio/accel/adxl345_i2c.c                    |    2 +-
 drivers/iio/accel/adxl345_spi.c                    |    7 +-
 drivers/iio/accel/bma220_spi.c                     |    2 +-
 drivers/iio/accel/fxls8962af-core.c                |   14 +
 drivers/iio/accel/fxls8962af-i2c.c                 |    2 +
 drivers/iio/accel/fxls8962af.h                     |    2 +
 drivers/iio/accel/kionix-kx022a-i2c.c              |    4 +
 drivers/iio/accel/kionix-kx022a-spi.c              |    4 +
 drivers/iio/accel/kionix-kx022a.c                  |  169 +-
 drivers/iio/accel/kionix-kx022a.h                  |   14 +
 drivers/iio/adc/ad4000.c                           |  313 +++-
 drivers/iio/adc/ad4695.c                           |    2 +-
 drivers/iio/adc/ad7124.c                           |  217 ++-
 drivers/iio/adc/ad7173.c                           |  119 +-
 drivers/iio/adc/ad7192.c                           |    4 +-
 drivers/iio/adc/ad7625.c                           |    8 +-
 drivers/iio/adc/ad7791.c                           |    1 +
 drivers/iio/adc/ad7793.c                           |    3 +-
 drivers/iio/adc/ad7944.c                           |    2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |  194 ++-
 drivers/iio/adc/dln2-adc.c                         |   21 +-
 drivers/iio/adc/ina2xx-adc.c                       |    2 +-
 drivers/iio/adc/max1118.c                          |    2 +-
 drivers/iio/adc/max11410.c                         |    2 +-
 drivers/iio/adc/max1363.c                          |   30 +-
 drivers/iio/adc/mcp3911.c                          |    2 +-
 drivers/iio/adc/meson_saradc.c                     |   47 +-
 drivers/iio/adc/pac1921.c                          |   95 +-
 drivers/iio/adc/rockchip_saradc.c                  |    2 +-
 drivers/iio/adc/rtq6056.c                          |    2 +-
 drivers/iio/adc/rzg2l_adc.c                        |  429 ++---
 drivers/iio/adc/ti-adc081c.c                       |    2 +-
 drivers/iio/adc/ti-adc084s021.c                    |    2 +-
 drivers/iio/adc/ti-ads1015.c                       |    2 +-
 drivers/iio/adc/ti-ads1119.c                       |    2 +-
 drivers/iio/adc/ti-ads131e08.c                     |    2 +-
 drivers/iio/adc/ti-lmp92064.c                      |    2 +-
 drivers/iio/adc/ti-tsc2046.c                       |    2 +-
 drivers/iio/adc/vf610_adc.c                        |  100 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   19 +-
 drivers/iio/chemical/bme680.h                      |    2 +
 drivers/iio/chemical/bme680_core.c                 |  120 +-
 drivers/iio/chemical/bme680_i2c.c                  |    1 +
 drivers/iio/chemical/bme680_spi.c                  |    1 +
 drivers/iio/chemical/ccs811.c                      |    2 +-
 drivers/iio/chemical/ens160_core.c                 |    2 +-
 drivers/iio/chemical/scd30_core.c                  |    2 +-
 drivers/iio/chemical/scd4x.c                       |    2 +-
 .../iio/common/inv_sensors/inv_sensors_timestamp.c |    4 +-
 drivers/iio/common/ssp_sensors/ssp_iio.c           |   12 +-
 drivers/iio/dac/Kconfig                            |   10 +-
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5624r.h                          |    4 +-
 drivers/iio/dac/ad5686-spi.c                       |    6 -
 drivers/iio/dac/ad5686.c                           |   62 +-
 drivers/iio/dac/ad5686.h                           |    6 +-
 drivers/iio/dac/ad5696-i2c.c                       |    6 -
 drivers/iio/dac/ad7293.c                           |   68 +-
 drivers/iio/dac/ad8801.c                           |   81 +-
 drivers/iio/dac/ltc2632.c                          |   69 +-
 drivers/iio/dac/ltc2688.c                          |   44 +-
 drivers/iio/dac/max5821.c                          |   36 +-
 drivers/iio/dac/mcp4725.c                          |    2 +-
 drivers/iio/dac/rohm-bd79703.c                     |  162 ++
 drivers/iio/gyro/adxrs290.c                        |    2 +-
 drivers/iio/gyro/bmg160_core.c                     |    2 +-
 drivers/iio/gyro/itg3200_buffer.c                  |    2 +-
 drivers/iio/gyro/mpu3050-core.c                    |    2 +-
 drivers/iio/humidity/am2315.c                      |    2 +-
 drivers/iio/humidity/hdc100x.c                     |    2 +-
 drivers/iio/humidity/hts221.h                      |    2 +-
 drivers/iio/imu/adis16480.c                        |   75 +
 drivers/iio/imu/bmi323/bmi323_core.c               |    2 +-
 drivers/iio/imu/bno055/bno055.c                    |   10 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   25 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    5 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   18 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c        |    6 +-
 drivers/iio/industrialio-buffer.c                  |    2 +-
 drivers/iio/industrialio-gts-helper.c              |   77 +
 drivers/iio/inkern.c                               |   11 +
 drivers/iio/light/Kconfig                          |   32 +-
 drivers/iio/light/Makefile                         |    2 +-
 drivers/iio/light/adjd_s311.c                      |    2 +-
 drivers/iio/light/as73211.c                        |    2 +-
 drivers/iio/light/bh1745.c                         |    2 +-
 drivers/iio/light/cm3232.c                         |   18 +-
 drivers/iio/light/isl29125.c                       |    2 +-
 drivers/iio/light/ltr501.c                         |    2 +-
 drivers/iio/light/max44000.c                       |    2 +-
 drivers/iio/light/opt4060.c                        | 1343 ++++++++++++++++
 drivers/iio/light/rohm-bu27008.c                   | 1635 ----------------=
----
 drivers/iio/light/rohm-bu27034.c                   |   75 +-
 drivers/iio/light/rpr0521.c                        |    2 +-
 drivers/iio/light/st_uvis25.h                      |    2 +-
 drivers/iio/light/tcs3414.c                        |    2 +-
 drivers/iio/light/tcs3472.c                        |    2 +-
 drivers/iio/light/veml3235.c                       |  274 ++--
 drivers/iio/light/veml6030.c                       |   76 +
 drivers/iio/magnetometer/af8133j.c                 |    2 +-
 drivers/iio/magnetometer/ak8974.c                  |    2 +-
 drivers/iio/magnetometer/ak8975.c                  |    2 +-
 drivers/iio/magnetometer/bmc150_magn.c             |    2 +-
 drivers/iio/magnetometer/hmc5843.h                 |    2 +-
 drivers/iio/magnetometer/mag3110.c                 |    2 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    2 +-
 drivers/iio/multiplexer/iio-mux.c                  |   84 +-
 drivers/iio/pressure/bmp280-core.c                 |   39 +-
 drivers/iio/pressure/bmp280.h                      |    8 +-
 drivers/iio/pressure/hsc030pa.h                    |    2 +-
 drivers/iio/pressure/ms5611_core.c                 |    2 +-
 drivers/iio/pressure/rohm-bm1390.c                 |   80 +-
 drivers/iio/proximity/as3935.c                     |    2 +-
 drivers/iio/proximity/aw96103.c                    |    2 +-
 drivers/iio/proximity/hx9023s.c                    |   95 +-
 drivers/iio/proximity/mb1232.c                     |    2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |    2 +-
 drivers/iio/proximity/srf08.c                      |    2 +-
 drivers/iio/proximity/sx_common.h                  |    2 +-
 drivers/iio/resolver/ad2s1210.c                    |    2 +-
 drivers/iio/temperature/tmp006.c                   |    2 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |   69 +-
 include/dt-bindings/iio/{ =3D> adc}/adi,ad4695.h     |    0
 include/linux/iio/adc/ad_sigma_delta.h             |   10 +-
 include/linux/iio/buffer.h                         |    2 +-
 include/linux/iio/consumer.h                       |    4 +-
 include/linux/iio/iio-gts-helper.h                 |    6 +
 include/linux/iio/iio-opaque.h                     |    2 +-
 include/linux/iio/iio.h                            |    2 +-
 include/linux/iio/imu/adis.h                       |    1 -
 include/linux/iio/timer/stm32-timer-trigger.h      |    6 +
 167 files changed, 4813 insertions(+), 3176 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-de=
lta
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bm=
e680.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/rohm,bd79703.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2700=
8.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.=
yaml
 create mode 100644 Documentation/iio/opt4060.rst
 create mode 100644 drivers/iio/dac/rohm-bd79703.c
 create mode 100644 drivers/iio/light/opt4060.c
 delete mode 100644 drivers/iio/light/rohm-bu27008.c
 rename include/dt-bindings/iio/{ =3D> adc}/adi,ad4695.h (100%)

