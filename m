Return-Path: <linux-iio+bounces-12062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FC39C2C1E
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 12:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751541F21C64
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0314EC51;
	Sat,  9 Nov 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4g6bQ0w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF756A8D2
	for <linux-iio@vger.kernel.org>; Sat,  9 Nov 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151133; cv=none; b=rirK5w8aP0C5wVGMwUFnKDOgA9GktebQvrh9fSKzjROAS3wSUqThqhFDFYtfG263E9gMnbCeyDD0XvyUJ08T6WrXasZ7G/90pWB9E9pBZ1zsTPVFc41DeBkZCS/mJImB7XVilCoVC3jSuf0jTFDmla+lNelVPTqw/Btvo8ThW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151133; c=relaxed/simple;
	bh=1TdAVxiBzj5ve7Iv+OSMV7mJyVWCftd9rzrq5/ZZKxA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ZELub7jszzwoU4veVZECuBwxeZ2MiiN2swEporYyD1crqkQ0qi1c0s9mKqfSxBdKFpwJ8MN7ZvnDA3WFyLx0561itgv+xfOGH63QwDN/Ydt4eGo9wMgfGZ6vzkRsj0HcfUGg4AqIqDKqwG2mCXSBwQgj2ZAhzad1/hUz1Lpr7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4g6bQ0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E05C4CECE;
	Sat,  9 Nov 2024 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731151133;
	bh=1TdAVxiBzj5ve7Iv+OSMV7mJyVWCftd9rzrq5/ZZKxA=;
	h=Date:From:To:Subject:From;
	b=r4g6bQ0wKKw3S+rkXf1A0ERtSHGjz3ochexTr0y9B35MECgL1/vH1SXYxToIG2cel
	 L8DL/UrqLsFptXp3bKUbT5gQSwVJ+9BXj0cgkojqKn1Ja42VuIf1hvTrcOs29bI8Am
	 i7gc/B1s/JtU4n3JNMzJL+yUcDFMl99PYVgJ5x/KPS8ugzg46Mx5XEwC0DADOV2Zoq
	 YnYvAmfmXKC1aru24z71wI8p/VNMkBtkWmTFpYaQIB0RtDP5ecrZ+161brEqzw5cPs
	 h/WrubgSEsbxOgVnTNtQqp/abdjnTewRdcde0uDNu7v1WKfBB6DU4iEECc3h9/VbTR
	 PO0Bhfr4EI9hg==
Date: Sat, 9 Nov 2024 11:18:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of new device support, features and cleanup for
 6.13
Message-ID: <20241109111845.31155f91@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9365f0de4303f82ed4c2db1c39d3de824b249d80:

  Merge 6.12-rc6 into char-misc-next (2024-11-05 09:36:29 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.13b

for you to fetch changes up to 20fd1383cd616d61b2a79967da1221dc6cfb8430:

  iio: Move __private marking before struct element priv in struct iio_dev =
(2024-11-09 10:42:13 +0000)

----------------------------------------------------------------
IIO: 2nd set of new device support, features and cleanup for 6.13

Alongside new drivers and device support there are several large
cleanups going on across the IIO tree and we see part of some of those
in this pull request.

Merged char-misc-next at point of 6.12-rc6 merge to avoid a
conflict with a fix for the ad7380 merged earlier this cycle.
Note that I previously messed this merge up and had to reconstruct
it this morning so a coherent pull request was possible. The new
stuff is all the same as has been in linux-next for some time with
the exception of the kernel-doc related __private ordering fix
that went in yesterday.

New device support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

adi,ad7380
- Support for adaq4370-4 and adaq4370 quad channel ADCs.
adi,ad7606
- Various cleanups preceeding support of AD7607, AD7608 and AD7609 ADCs.
adi,ad7779
- New driver supproting AD7770, AD7771 and AD7779 ADCs.
allegro,als31300
- New driver for this 3D Linear Hall Effect sensor.
bosch,bmi270
- Add support BMI260 which is similar but requires a different firmware ima=
ge.
bosch,smi240
- New driver for this IMU.
ti,opt3001
- Add support opt3002 light sensor which has a wider spectral range than
  the opt3001.
vishay,veml3235
- New driver for this ambient light sensor.

Features
=3D=3D=3D=3D=3D=3D=3D=3D

hid-sensors
- Add support Human Proximity Range and Attention detection (requiring
  a new classification style channel type)
adi,ad3552r
- Add backend support and related platform driver to support use
  with an FPGA IP to allow QSPI + DDR bus operation and much higher
  data aquisition rates.  (various rework preceeded this feature)
adi,ad7606
- Various cleanup prior to enabling use with an IIO Backend and PWM trigger
  enabling much higher speed data capture.
bosch,bme680
- Support control of preheat current
- Support triggered buffer capture
- Add SCALE and RAW channels (needed to enable the buffered capture).
bosch,bmp280
- Enable sleeping to save power.
- Add interrupt support for bmp3xx and bmp5xx devices. Also update bmp085
  to new approach.
- Enable data ready trigger.
bosch,bmi270
- Add triggered buffer support
- Add scale and sampling frequency control.
vishay,veml6070
- Support integration time via DT binding for an external resistor value.

Cleanup and minor fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

core
- Fix a longstanding issue with event codes for differential channels.
  Note that not all drivers are yet fixed, but macros have been added
  to avoid potential repeats of this in future.
- Tidy up handling in iio_read_acpi_mount matrix.
- Mark iio_dev::priv with __private. Later move the marking before the
  field name to avoid a kernel-doc issue.
treewide
- Drop some pointless default n entries in Kconfig.
- Add an iio_get_acpi_device_name_and_data() handler to replace some
  commonly repeated code.
- simplify use of 'state' in write_event_config() callback  as it is
  effectively a boolean. Once done make it a boolean (lots of drivers
  were updated to enable this)
- some more use of devm_regulator_get_enable_read_voltage( to replace
  open coded versions.  Where this enables it convert all of remove
  handling to devm based and drop the remove callback.
- check returns from devm_mutex_init()
accel drivers
- Use aligned_s64 instead of s64 __aligned(8)
adi,ad5791
- Add some missing GPIOs and power supplies that presumably were always
  hard wired on previous boards.
- Refactor to use chip_info in device id tables.
- Convert probe entirely to devm based simplify code and allowing remove()
  callback to be dropped.
adi,ad7192
- Check return from spi_get_device_match_data()
adi,ad74413r
- Don't keep an unnecessary copy of the gpio after probe.
- Use devm_regulator_get_enable_read_voltage() instead of open coding.
- Apply cleanup.h approach to reduce complexity.
adi,dac8460
- Fix a wrong compaitble ID due to a stray space.
- Add an spi_device_id table.
bosch,bmc150
- Drop some likely false ACPI IDs.
- Drop left over unused ACPI specific code.
bosch,bme680
- Add mising regmap.h include.
- Reduce excessive sleep on startup.
- Drop some cammelcase usage.
- Use fsleep
- Generalize read functions to allow for reuse.
- Use s16 variable to avoid some incorrect casting
bosch,bmg150
- Drop some likely false ACPI IDs.
bosch,bmi270
- Drop unused FREQUENCY and SCALE attributes that always returned an
  error (they wil be back impelmented correctly).
- Factor out the chip specific data into a structure to enable simple
  support for additional devices.
isil,isl29018
- Drop ACPI_PTR() and CONFIG_ACPI guards as not worth the trouble for very
  minor saving.
invensense,mpu6050
- Use much simpler test for ACPI firmware.
kionix,kxcjk-1013
- Drop unnecessary ACPI entry in the i2c_device_id table.
- Drop support KX022-1020 to fix a bug that was introduced with that change.
  Hopefully a fixed version will replace it soon.
- Drop CONFIG guards for PM in favor of pm_ptr() and the compiler removing
  dead code.
- Switch from enum to chip_info structure and add ODR times to that structu=
re.
- Deduplicate one of those ODR structures
- Drop ACPI_PTR() and move ID table out of config guards.
- Minor additional cleanup.
liteon,ltr401
- Drop some likely false ACPI Ids and add LTER0303 which is know to be in u=
se.
microchip,pac1934
- Use much simpler test for ACPI firmware.
vishay,veml6070
- Use unsigned int instead of just unsigned.
- Use FIELD_PREP to make setting of field value explicit.

Various other minor fixes to documentation

----------------------------------------------------------------
Alexandru Ardelean (5):
      iio: adc: ad7606: fix/persist oversampling_ratio setting
      iio: adc: ad7606: use realbits for sign-extending in scan_direct
      iio: adc: ad7606: rework scale-available to be static
      dt-bindings: iio: adc: adi,ad7606: document AD760{7,8,9} parts
      iio: adc: ad7606: add support for AD760{7,8,9} parts

Andy Shevchenko (32):
      iio: gyro: bmg160: Drop most likely fake ACPI IDs
      iio: magnetometer: bmc150_magn: Drop most likely fake ACPI IDs
      iio: light: Remove "default n" entries
      iio: adc: Remove "default n" entries
      iio: magnetometer: bmc150: Drop dead code from the driver
      iio: adc: pac1934: Replace strange way of checking type of enumeration
      iio: imu: inv_mpu6050: Replace strange way of checking type of enumer=
ation
      iio: acpi: Improve iio_read_acpi_mount_matrix()
      iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
      iio: accel: kxcjk-1013: Remove redundant I=C2=B2C ID
      iio: accel: kxcjk-1013: Revert "Add support for KX022-1020"
      iio: accel: kxcjk-1013: Switch from CONFIG_PM guards to pm_ptr() etc
      iio: accel: kxcjk-1013: Use local variable for regs
      iio: accel: kxcjk-1013: Rename kxcjk1013_info
      iio: accel: kxcjk-1013: Start using chip_info variables instead of en=
um
      iio: accel: kxcjk-1013: Move odr_start_up_times up in the code
      iio: accel: kxcjk-1013: Convert ODR times array to variable in chip_i=
nfo
      iio: accel: kxcjk-1013: Get rid of enum kx_chipset
      iio: accel: kxcjk-1013: Replace a variant of iio_get_acpi_device_name=
_and_data()
      iio: accel: kxcjk-1013: drop ACPI_PTR() and move ID out of CONFIG_ACP=
I guards
      iio: accel: mma9551: Replace custom implementation of iio_get_acpi_de=
vice_name()
      iio: accel: mma9553: Replace custom implementation of iio_get_acpi_de=
vice_name()
      iio: gyro: bmg160: Replace custom implementation of iio_get_acpi_devi=
ce_name()
      iio: light: isl29018: Replace a variant of iio_get_acpi_device_name_a=
nd_data()
      iio: light: isl29018: drop ACPI_PTR() and CONFIG_ACPI guards
      iio: light: ltr501: Drop most likely fake ACPI IDs
      iio: light: ltr501: Add LTER0303 to the supported devices
      iio: light: ltr501: Replace a variant of iio_get_acpi_device_name_and=
_data()
      iio: adc: ad4000: Check for error code from devm_mutex_init() call
      iio: adc: pac1921: Check for error code from devm_mutex_init() call
      iio: accel: kxcjk-1013: Deduplicate ODR startup time array
      iio: Mark iio_dev::priv member with __private

Angelo Dureghello (8):
      dt-bindings: iio: dac: ad3552r: add iio backend support
      dt-bindings: iio: dac: adi-axi-dac: add ad3552r axi variant
      iio: backend: extend features
      iio: dac: adi-axi-dac: extend features
      iio: dac: ad3552r: changes to use FIELD_PREP
      iio: dac: ad3552r: extract common code (no changes in behavior intend=
ed)
      iio: dac: ad3552r: add high-speed platform driver
      iio: dac: adi-axi-dac: add registering of child fdt node

Axel Haslam (6):
      dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios
      dt-bindings: iio: dac: ad5791: Add required voltage supplies
      iio: dac: ad5791: Include chip_info in device match tables
      iio: dac: ad5791: Add reset, clr and ldac gpios
      iio: dac: ad5791: Use devm_regulator_get_enable_read_voltage
      iio: dac: ad5791: Use devm_iio_device_register

David Lechner (16):
      iio: dac: ad8460: fix DT compatible
      iio: dac: ad8460: add SPI device match table
      iio: dac: ad5380: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5380: drop driver remove callbacks
      iio: dac: ad5446: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5446: drop driver remove callbacks
      iio: dac: ad5504: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5504: drop driver remove callback
      iio: dac: ad5624r: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5624r: drop driver remove callback
      iio: dac: ad5761: use devm_regulator_get_enable_read_voltage()
      iio: dac: ad5761: drop driver remove callback
      iio: dac: ad5770r: use devm_regulator_get_enable_read_voltage()
      iio: dummy: use specialized event code macros
      iio: accel: mma9553: use specialized event code macros
      iio: events: make IIO_EVENT_CODE macro private

Emil Gedenryd (2):
      dt-bindings: iio: light: opt3001: add compatible for opt3002
      iio: light: opt3001: add support for TI's opt3002 light sensor

Guillaume Stols (8):
      dt-bindings: iio: adc: ad7606: Remove spi-cpha from required
      dt-bindings: iio: adc: ad7606: Add iio backend bindings
      Documentation: iio: Document ad7606 driver
      iio: adc: ad7606: Add PWM support for conversion trigger
      iio: adc: ad7606: Add compatibility to fw_nodes
      iio: adc: ad7606: Introduce num_adc_channels
      iio: adc: ad7606: Add iio-backend support
      iio: adc: ad7606: Disable PWM usage for non backend version

Javier Carrasco (6):
      iio: light: veml6070: use unsigned int instead of unsigned
      iio: light: veml6070: use field to set integration time
      dt-bindings: iio: light: veml6030: add veml3235
      iio: light: add support for veml3235
      dt-bindings: iio: light: veml6075: document vishay,rset-ohms
      iio: light: veml6070: add support for integration time

Jonathan Cameron (3):
      iio: accel: replace s64 __aligned(8) with aligned_s64
      Merge commit '9365f0de4303f82ed4c2db1c39d3de824b249d80' into HEAD
      iio: Move __private marking before struct element priv in struct iio_=
dev

Julien Stephan (28):
      iio: light: bh1745: simplify code in write_event_config callback
      iio: light: ltr501: simplify code in write_event_config callback
      iio: light: veml6030: simplify code in write_event_config callback
      iio: imu: inv_mpu6050: simplify code in write_event_config callback
      iio: light: stk3310: simplify code in write_event_config callback
      iio: gyro: bmg160_core: remove trailing tab
      iio: light: ltr390: simplify code in write_event_config callback
      iio: proximity: hx9023s: simplify code in write_event_config callback
      iio: light: tsl2772: simplify code in write_event_config callback
      iio: proximity: irsd200: simplify code in write_event_config callback
      iio: proximity: sx9500: simplify code in write_event_config callback
      iio: light: adux1020: write_event_config: use local variable for inte=
rrupt value
      iio: fix write_event_config signature
      iio: accel: mma9551: use bool for event state
      iio: accel: sca3000: use bool for event state
      iio: imu: bmi323: use bool for event state
      iio: imu: st_lsm6dsx: use bool for event state
      iio: light: apds9300: use bool for event state
      iio: light: apds9306: simplifies if branch in apds9306_write_event_co=
nfig
      iio: light: apds9960: convert als_int and pxs_int to bool
      iio: light: apds9960: remove useless return
      iio: events.h: add event identifier macros for differential channel
      iio: adc: ad7280a: use IIO_DIFF_EVENT_CODE macro helper
      dt-bindings: iio: adc: ad7380: add adaq4370-4 and adaq4380-4 compatib=
le parts
      iio: adc: ad7380: fix oversampling formula
      iio: adc: ad7380: use local dev variable to shorten long lines
      iio: adc: ad7380: add support for adaq4370-4 and adaq4380-4
      docs: iio: ad7380: add adaq4370-4 and adaq4380-4

Justin Weiss (6):
      iio: imu: bmi270: Remove unused FREQUENCY / SCALE attributes
      iio: imu: bmi270: Provide chip info as configuration structure
      iio: imu: bmi270: Add triggered buffer for Bosch BMI270 IMU
      iio: imu: bmi270: Add scale and sampling frequency to BMI270 IMU
      dt-bindings: iio: imu: bmi270: Add Bosch BMI260
      iio: imu: bmi270: Add support for BMI260

Neil Armstrong (3):
      dt-bindings: vendor-prefixes: Add Allegro MicroSystems, Inc
      dt-bindings: iio: magnetometer: document the Allegro MicroSystems ALS=
31300 3-D Linear Hall Effect Sensor
      iio: magnetometer: add Allegro MicroSystems ALS31300 3-D Linear Hall =
Effect driver

Nuno Sa (4):
      iio: adc: ad7192: properly check spi_get_device_match_data()
      iio: addac: ad74413r: drop reset_gpio from struct ad74413r_state
      iio: addac: ad74413r: use devm_regulator_get_enable_read_voltage()
      iio: addac: ad74413r: simplify with cleanup.h

Ramona Alexandra Nechita (3):
      dt-bindings: iio: adc: add ad7779 doc
      Documentation: ABI: added filter mode doc in sysfs-bus-iio
      drivers: iio: adc: add support for ad777x family

Ricardo Ribalda (5):
      iio: hid-sensors: Add proximity and attention IDs
      iio: hid-sensors-prox: Factor-in hid_sensor_push_data
      iio: Add channel type for attention
      iio: hid-sensors-prox: Make proximity channel indexed
      iio: hid-sensor-prox: Add support for more channels

Shen Jianping (2):
      dt-bindings: iio: imu: smi240: add Bosch smi240
      iio: imu: smi240: add driver

Vasileios Amoiridis (15):
      iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
      dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP=
5xx devices
      iio: pressure: bmp280: Add data ready trigger support
      iio: pressure: bmp280: Move bmp085 interrupt to new configuration
      iio: chemical: bme680: Add missing regmap.h include
      iio: chemical: bme680: optimize startup time
      iio: chemical: bme680: avoid using camel case
      iio: chemical: bme680: move to fsleep()
      iio: chemical: bme680: Fix indentation and unnecessary spaces
      iio: chemical: bme680: generalize read_*() functions
      iio: chemical: bme680: use s16 variable for temp value to avoid casti=
ng
      iio: chemical: bme680: refactorize set_mode() mode
      iio: chemical: bme680: Add SCALE and RAW channels
      iio: chemical: bme680: Add triggered buffer support
      iio: chemical: bme680: Add support for preheat current

WangYuli (1):
      iio: accel: adxl355: Fix typo "accelaration"

Yo-Jung (Leo) Lin (1):
      iio: gyro: list adis16137 in Kconfig description

 Documentation/ABI/testing/sysfs-bus-iio            |  32 +
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 |  46 --
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 120 +++
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  81 +-
 .../devicetree/bindings/iio/adc/adi,ad7779.yaml    | 110 +++
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |   7 +
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |  39 +
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  69 +-
 .../devicetree/bindings/iio/imu/bosch,bmi270.yaml  |   4 +-
 .../devicetree/bindings/iio/imu/bosch,smi240.yaml  |  51 ++
 .../devicetree/bindings/iio/light/ti,opt3001.yaml  |   4 +-
 .../bindings/iio/light/vishay,veml6030.yaml        |   5 +-
 .../bindings/iio/light/vishay,veml6075.yaml        |  18 +
 .../iio/magnetometer/allegromicro,als31300.yaml    |  46 ++
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |  22 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/iio/ad7380.rst                       |  16 +
 Documentation/iio/ad7606.rst                       | 144 ++++
 Documentation/iio/index.rst                        |   1 +
 MAINTAINERS                                        |   8 +-
 drivers/iio/accel/adxl355_core.c                   |   2 +-
 drivers/iio/accel/adxl367.c                        |   2 +-
 drivers/iio/accel/adxl372.c                        |   2 +-
 drivers/iio/accel/adxl380.c                        |   2 +-
 drivers/iio/accel/bma180.c                         |   3 +-
 drivers/iio/accel/bma220_spi.c                     |   1 +
 drivers/iio/accel/bma400_core.c                    |   4 +-
 drivers/iio/accel/bmc150-accel-core.c              |   2 +-
 drivers/iio/accel/bmc150-accel.h                   |   3 +-
 drivers/iio/accel/fxls8962af-core.c                |   5 +-
 drivers/iio/accel/kionix-kx022a.c                  |   3 +-
 drivers/iio/accel/kxcjk-1013.c                     | 442 +++++-----
 drivers/iio/accel/kxsd9.c                          |   3 +-
 drivers/iio/accel/mma7455_core.c                   |   3 +-
 drivers/iio/accel/mma8452.c                        |   5 +-
 drivers/iio/accel/mma9551.c                        |  27 +-
 drivers/iio/accel/mma9553.c                        |  46 +-
 drivers/iio/accel/msa311.c                         |   3 +-
 drivers/iio/accel/mxc4005.c                        |   3 +-
 drivers/iio/accel/sca3000.c                        |   6 +-
 drivers/iio/accel/stk8312.c                        |   3 +-
 drivers/iio/accel/stk8ba50.c                       |   3 +-
 drivers/iio/adc/Kconfig                            |  15 +-
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad4000.c                           |   4 +-
 drivers/iio/adc/ad7091r-base.c                     |   3 +-
 drivers/iio/adc/ad7192.c                           |   3 +
 drivers/iio/adc/ad7280a.c                          |  14 +-
 drivers/iio/adc/ad7291.c                           |   2 +-
 drivers/iio/adc/ad7380.c                           | 178 +++-
 drivers/iio/adc/ad7606.c                           | 797 +++++++++++++-----
 drivers/iio/adc/ad7606.h                           |  60 +-
 drivers/iio/adc/ad7606_par.c                       | 127 ++-
 drivers/iio/adc/ad7606_spi.c                       | 138 +++-
 drivers/iio/adc/ad7779.c                           | 914 +++++++++++++++++=
++++
 drivers/iio/adc/ad799x.c                           |   2 +-
 drivers/iio/adc/hi8435.c                           |   2 +-
 drivers/iio/adc/max1363.c                          |   2 +-
 drivers/iio/adc/pac1921.c                          |   7 +-
 drivers/iio/adc/pac1934.c                          |   2 +-
 drivers/iio/adc/palmas_gpadc.c                     |   2 +-
 drivers/iio/adc/ti-ads1015.c                       |   2 +-
 drivers/iio/adc/xilinx-ams.c                       |   2 +-
 drivers/iio/adc/xilinx-xadc-events.c               |   2 +-
 drivers/iio/adc/xilinx-xadc.h                      |   2 +-
 drivers/iio/addac/ad74413r.c                       |  81 +-
 drivers/iio/cdc/ad7150.c                           |   2 +-
 drivers/iio/chemical/Kconfig                       |   2 +
 drivers/iio/chemical/bme680.h                      |  11 +-
 drivers/iio/chemical/bme680_core.c                 | 366 +++++++--
 drivers/iio/dac/Kconfig                            |  19 +
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/ad3552r-common.c                   | 249 ++++++
 drivers/iio/dac/ad3552r-hs.c                       | 529 ++++++++++++
 drivers/iio/dac/ad3552r-hs.h                       |  19 +
 drivers/iio/dac/ad3552r.c                          | 557 ++-----------
 drivers/iio/dac/ad3552r.h                          | 228 +++++
 drivers/iio/dac/ad5380.c                           |  85 +-
 drivers/iio/dac/ad5421.c                           |   2 +-
 drivers/iio/dac/ad5446.c                           |  77 +-
 drivers/iio/dac/ad5504.c                           |  59 +-
 drivers/iio/dac/ad5624r.h                          |   1 -
 drivers/iio/dac/ad5624r_spi.c                      |  71 +-
 drivers/iio/dac/ad5761.c                           | 109 +--
 drivers/iio/dac/ad5770r.c                          |  41 +-
 drivers/iio/dac/ad5791.c                           | 203 +++--
 drivers/iio/dac/ad8460.c                           |  11 +-
 drivers/iio/dac/adi-axi-dac.c                      | 312 ++++++-
 drivers/iio/dummy/iio_simple_dummy.h               |   2 +-
 drivers/iio/dummy/iio_simple_dummy_events.c        |  32 +-
 drivers/iio/gyro/Kconfig                           |   2 +-
 drivers/iio/gyro/bmg160_core.c                     |  19 +-
 drivers/iio/gyro/bmg160_i2c.c                      |   6 +-
 drivers/iio/imu/Kconfig                            |  14 +
 drivers/iio/imu/Makefile                           |   2 +
 drivers/iio/imu/bmi270/Kconfig                     |   1 +
 drivers/iio/imu/bmi270/bmi270.h                    |  21 +-
 drivers/iio/imu/bmi270/bmi270_core.c               | 441 +++++++++-
 drivers/iio/imu/bmi270/bmi270_i2c.c                |  20 +-
 drivers/iio/imu/bmi270/bmi270_spi.c                |  13 +-
 drivers/iio/imu/bmi323/bmi323_core.c               |  10 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |   5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   9 +-
 drivers/iio/imu/kmx61.c                            |   2 +-
 drivers/iio/imu/smi240.c                           | 621 ++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   4 +-
 drivers/iio/industrialio-acpi.c                    |  48 +-
 drivers/iio/industrialio-backend.c                 |  78 ++
 drivers/iio/industrialio-core.c                    |   3 +-
 drivers/iio/light/Kconfig                          |  14 +-
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/adux1020.c                       |  12 +-
 drivers/iio/light/apds9300.c                       |  20 +-
 drivers/iio/light/apds9306.c                       |   7 +-
 drivers/iio/light/apds9960.c                       |  10 +-
 drivers/iio/light/bh1745.c                         |  50 +-
 drivers/iio/light/cm36651.c                        |   2 +-
 drivers/iio/light/gp2ap002.c                       |   2 +-
 drivers/iio/light/gp2ap020a00f.c                   |   2 +-
 drivers/iio/light/hid-sensor-prox.c                | 195 +++--
 drivers/iio/light/iqs621-als.c                     |   2 +-
 drivers/iio/light/isl29018.c                       |  38 +-
 drivers/iio/light/ltr390.c                         |   7 +-
 drivers/iio/light/ltr501.c                         |  35 +-
 drivers/iio/light/max44009.c                       |   2 +-
 drivers/iio/light/opt3001.c                        | 191 ++++-
 drivers/iio/light/stk3310.c                        |   5 +-
 drivers/iio/light/tcs3472.c                        |   2 +-
 drivers/iio/light/tsl2563.c                        |   2 +-
 drivers/iio/light/tsl2591.c                        |   2 +-
 drivers/iio/light/tsl2772.c                        |   6 +-
 drivers/iio/light/us5182d.c                        |   2 +-
 drivers/iio/light/vcnl4000.c                       |   5 +-
 drivers/iio/light/veml3235.c                       | 495 +++++++++++
 drivers/iio/light/veml6030.c                       |   5 +-
 drivers/iio/light/veml6070.c                       | 138 +++-
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/als31300.c                | 494 +++++++++++
 drivers/iio/magnetometer/bmc150_magn.c             |  15 -
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |   9 -
 drivers/iio/magnetometer/bmc150_magn_spi.c         |   9 -
 drivers/iio/position/iqs624-pos.c                  |   2 +-
 drivers/iio/pressure/bmp280-core.c                 | 536 +++++++++++-
 drivers/iio/pressure/bmp280-i2c.c                  |   4 +-
 drivers/iio/pressure/bmp280-spi.c                  |   4 +-
 drivers/iio/pressure/bmp280.h                      |  43 +
 drivers/iio/proximity/aw96103.c                    |   2 +-
 drivers/iio/proximity/cros_ec_mkbp_proximity.c     |   2 +-
 drivers/iio/proximity/hx9023s.c                    |   4 +-
 drivers/iio/proximity/irsd200.c                    |   5 +-
 drivers/iio/proximity/sx9500.c                     |   6 +-
 drivers/iio/proximity/sx_common.c                  |   2 +-
 drivers/iio/proximity/sx_common.h                  |   2 +-
 drivers/iio/proximity/vcnl3020.c                   |   2 +-
 drivers/iio/temperature/mcp9600.c                  |   2 +-
 drivers/iio/temperature/tmp007.c                   |   2 +-
 include/linux/hid-sensor-ids.h                     |   2 +
 include/linux/iio/backend.h                        |  17 +
 include/linux/iio/events.h                         |  31 +-
 include/linux/iio/iio.h                            |  16 +-
 include/uapi/linux/iio/types.h                     |   1 +
 tools/iio/iio_event_monitor.c                      |   2 +
 163 files changed, 8327 insertions(+), 2221 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/alle=
gromicro,als31300.yaml
 create mode 100644 Documentation/iio/ad7606.rst
 create mode 100644 drivers/iio/adc/ad7779.c
 create mode 100644 drivers/iio/dac/ad3552r-common.c
 create mode 100644 drivers/iio/dac/ad3552r-hs.c
 create mode 100644 drivers/iio/dac/ad3552r-hs.h
 create mode 100644 drivers/iio/dac/ad3552r.h
 create mode 100644 drivers/iio/imu/smi240.c
 create mode 100644 drivers/iio/light/veml3235.c
 create mode 100644 drivers/iio/magnetometer/als31300.c

