Return-Path: <linux-iio+bounces-24292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58204B8A18B
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ABF175B39
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA8316189;
	Fri, 19 Sep 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZaF92X4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE973316197
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293484; cv=none; b=kywdc6aFtI2tizRRQtwsi0MAzaeObvkyUO8ljQ0x03Ml74rgEv051Ydlwl9D7D0FUiNHICrezisnKjF88TotW4S+LFrTNSxiI2ofQ3jOULxePbWriFTmd3i3sZ8sjJ9BQD8cgNz4MvRrBJkH9cEqVf1WOG0yNzURnC2wevOUQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293484; c=relaxed/simple;
	bh=p+1m6VoDXnK2m0vqbmga7XabUI3QdhU/Tg0x869EsUM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=k0vvojYD+uqtwv6tPjEi+WkrJPLPnmh4GKC+XiCbMBxSuv+1elPmGhI6KwkVEFwKCz6YCD80aeSx0Up+sYdP+TbvxomSG6vmUNhtVpOVI3zr/AFybY0U9zFftoCwPa8FSFYpzSJptU1N+CQv1Dht3Kppl1pHZUezyrV+bvNwr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZaF92X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562EAC4CEF1;
	Fri, 19 Sep 2025 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758293484;
	bh=p+1m6VoDXnK2m0vqbmga7XabUI3QdhU/Tg0x869EsUM=;
	h=Date:From:To:Subject:From;
	b=MZaF92X4GdJRE+5p70X1pavtuKqxDvm4O/EWBHowh6oa5s/vJukT1tkAPyQRcgPZJ
	 +r4MVVMZiOZOPGdrKBh4Tn6sDX6QukzQ5Nj707CEsF4omIfPzFVeONeLu+RTND8SgD
	 E9vG1Wm/fDtpZ6+kWXUbl5TmKaGBgjr6am37DzCeYCe88uo48nma/cN9TPL8pFE+S/
	 wqzjnx5vdGmkBM8t46JfIrjau581XILMa1107CwnumnurBxmL4XxMJ3anL8NcG4Q4N
	 bieLcu97zeerPJcwi0+RkmMpNv36bRFyKg/WX7fnh+3pmng3rYF5z21ebOFHPSBL3c
	 TGn/ePsHG9xVg==
Date: Fri, 19 Sep 2025 15:51:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: New device support, features and cleanup for 6.18
Message-ID: <20250919155117.4ebe23e3@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.18a

for you to fetch changes up to 561285d048053fec8a3d6d1e3ddc60df11c393a0:

  MAINTAINERS: Support ROHM BD79112 ADC (2025-09-15 21:12:32 +0100)

----------------------------------------------------------------
IIO: New device support, features and cleanup for 6.18

New device support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ad,ade9000
- New driver for this complex energy and power monitoring ADC.
infineon,tlv493d
- New driver for this 3D magnetic sensor.
intel,dollar
- New driver for this TI PMIC (part number unknown)
marvel,88pm886
- Driver for this PMIC ADC.
microchip,mcp9600
- Add explicit support for the mcp9601 which has some additional features
  over the mcp9600.
rohm,bd79112
- New driver for this ADC / GPIO Chip.

Features
=3D=3D=3D=3D=3D=3D=3D=3D
Core
- New helper to multiply data expressed in IIO types.
- Add KUnit tests.
- New IIO_ALTCURRENT type, similar to existing IIO_ALTVOLTAGE
- Add some channel modifiers related to energy and power, such as
  reactive.
adi,ad7124
- Support external clocks sources and output of the internal clocks.
- Filter control.
adi,ad7173
- Add filter support. Some fiddly interactions with other parameters on this
  device.
adi,ad7779
- Add backend support which required control of the number of lanes used.
liteon,ltr390
- Add runtime PM support.
microchip,mcp9600
- Add support for different thermocouple types.

Cleanup and minor fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

core
- Switch info_mask fields to be unsigned. Not clear why they were ever
  signed.
- Fix handling of negative channel scale in iio_convert_raw_to_processed()
- Fix offset handling for channels without a scale attribute.
- Improve the precision of scaling slightly.
- Drop apparent handling of IIO_CHAN_INFO_PROCESSED for devices that don't
  have any such channels.
various
- Drop many pm_runtime_mark_last_busy() calls now
  pm_runtime_put_autosuspend() calls it internally.
- Drop dev_err_probe() calls where the error code is hard coded as -ENOMEM
  as they don't do anything.
- Drop dev_err() calls where the error code is -ENOMEM. This will reduce
  error prints, but memory failures generate a lot of messages anyway
  so unlikely we need these prints.
current-sense-amplifier
- Add #io-channels property this channel to be used by a consumer driver.
adi,ad7124
- Fix incorrect clocks dt-binding property.
- Make the mclk clock optional in DT - this is internal to the ADC so should
  never have been in he binding.
- Fix up sample rate to comply with ABI.
- Use read_avail() callback rather than opencoding similar.
- Deploy guard() to clean up some lock handling.
adi,ad7768
- Use devm_regulator_get_enable_read_voltage() to replace similar code.
adi,ad7816
- Drop an unnecessary dev_set_drvdata() call as nothing uses the data.
ad,adxl345
- Fix missing blank line before bullet list in documentation.
arm,scmi
- Use devm_kcalloc() for an array allocation rather than devm_kzalloc().
bosch,bmi270
- Match an ACPI ID seen in the wild. It is not spec compliant but we can't
  do much about that.
bosch,bmp280
- Drop overly noisy dev_info()
- Allow for sleeping gpio controllers.
gogle,cros-ec
- Drop unused location attribute that has been replaced by label.
invense,icm42600
- Simplify the power management.
- Use guard() to simplify some locking.
maxim,max1238
- Add io-channel-cells property to dt-binding as there is an in tree
  consumer.
microchip,mcp9600
- Specify a default value in dt-binding for the thermocouple type
- General whitespace cleanup.
samsung,exynos
- Drop support for the S3C2410 including bindings, and touchscreen support
  as nothing else uses that.
- Drop platform ID based binding as not used.
st,vl53l0x
- Fix returning the wrong variable in an error path.
ti,pac1934
- Replace open coded devm_mutex_init().
xilinx,ams
- Update maintainers entry.

----------------------------------------------------------------
Akshay Bansod (1):
      iio: st_lsm6dsx: Replace scnprintf() with sysfs_emit()

Akshay Jindal (3):
      iio: light: ltr390: Add debugfs register access support
      iio: light: ltr390: Add device powerdown functionality via devm api
      iio: light: ltr390: Implement runtime PM support

Andreas Klinger (3):
      dt-bindings: iio: light: veml6046x00: add color sensor
      iio: light: add support for veml6046x00 RGBIR color sensor
      MAINTAINER: add maintainer for veml6046x00

Andrew Davis (2):
      iio: health: afe4403: Do not store dev pointer in device struct
      iio: health: afe4404: Do not store dev pointer in device struct

Antoniu Miclaus (6):
      iio: add IIO_ALTCURRENT channel type
      iio: add power and energy measurement modifiers
      dt-bindings: iio: adc: add ade9000
      iio: adc: add ade9000 support
      docs: iio: add documentation for ade9000 driver
      Documentation: ABI: iio: add sinc4+lp

Ben Collins (6):
      iio: iio_format_list() should set stride=3D1 for IIO_VAL_CHAR
      dt-bindings: iio: mcp9600: Set default 3 for thermocouple-type
      dt-bindings: iio: mcp9600: Add microchip,mcp9601 and add constraints
      iio: mcp9600: White space and fixed width cleanup
      iio: mcp9600: Recognize chip id for mcp9601
      iio: mcp9600: Add support for thermocouple-type

Chandra Mohan Sundar (1):
      iio: adc: ad7768-1: Remove logically dead code

Christophe JAILLET (1):
      iio: adc: PAC1934: Use devm_mutex_init()

Colin Ian King (2):
      iio: magnetometer: Fix spelling mistake "Magenetometer" -> "Magnetome=
ter"
      iio: light: vl6180: remove space before \n newline

Cryolitia PukNgae (1):
      iio: imu: bmi270: Match PNP ID found on newer GPD firmware

Dan Carpenter (1):
      iio: proximity: vl53l0x-i2c: Fix error code in probe()

David Lechner (25):
      iio: proximity: mb1232: use stack allocated scan struct
      iio: proximity: pulsedlight-lidar-lite-v2: use stack allocated scan s=
truct
      iio: proximity: vl53l0x-i2c: use stack allocated scan struct
      iio: fix iio_push_to_buffers_with_ts() typo
      iio: proximity: sx9500: use stack allocated struct for scan data
      iio: proximity: srf08: use stack allocated scan buffer
      iio: accel: bma180: use stack allocated buffer for scan
      iio: adc: ti-adc081c: use individual model structures instead of array
      iio: adc: ad7173: add SPI offload support
      iio: ABI: alphabetize filter types
      dt-bindings: iio: adc: adi,ad7124: fix clocks properties
      iio: adc: ad7124: do not require mclk
      iio: adc: ad7124: add external clock support
      iio: adc: ad7124: add clock output support
      iio: adc: ad7124: fix sample rate for multi-channel use
      iio: adc: ad7124: use clamp()
      iio: adc: ad7124: use read_avail() for scale_available
      iio: adc: ad7124: use guard(mutex) to simplify return paths
      iio: adc: ad7124: support fractional sampling_frequency
      iio: adc: ad7124: add filter support
      iio: ABI: document "sinc4+rej60" filter_type
      iio: adc: ad7173: rename ad7173_chan_spec_ext_info
      iio: adc: ad7173: rename odr field
      iio: adc: ad7173: support changing filter type
      iio: ABI: add filter types for ad7173

Dixit Parmar (14):
      iio: accel: Drop unnecessary -ENOMEM messages
      iio: adc: Drop unnecessary -ENOMEM messages
      iio: dac: Drop unnecessary -ENOMEM messages
      iio: health: Drop unnecessary -ENOMEM messages
      iio: humidity: Drop unnecessary -ENOMEM messages
      iio: light: Drop unnecessary -ENOMEM messages
      iio: potentiostat: Drop unnecessary -ENOMEM messages
      iio: pressure: Drop unnecessary -ENOMEM messages
      iio: proximity: Drop unnecessary -ENOMEM messages
      iio: temperature: Drop unnecessary -ENOMEM messages
      dt-bindings: iio: magnetometer: Infineon TLV493D 3D Magnetic sensor
      iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor
      iio: magnetometer: als31300: remove unused IIO_CHAN_INFO_PROCESSED ha=
ndling
      iio: magnetometer: tmag5273: remove unused IIO_CHAN_INFO_PROCESSED ha=
ndling

Duje Mihanovi=C4=87 (2):
      dt-bindings: mfd: 88pm886: Add #io-channel-cells
      iio: adc: Add driver for Marvell 88PM886 PMIC ADC

Erick Setubal Bacurau (1):
      docs: iio: bno055: Correct wording in driver documentation

Frank Li (1):
      dt-bindings: iio: adc: max1238: Add #io-channel-cells property

Gwendal Grignou (1):
      Documentation: iio: Remove location attribute

Haibo Chen (2):
      iio: adc: imx93_adc: keep one style of the hex values
      iio: adc: imx93_adc: load calibrated values even calibration failed

Hans de Goede (6):
      iio: consumers: Fix handling of negative channel scale in iio_convert=
_raw_to_processed()
      iio: consumers: Fix offset handling in iio_convert_raw_to_processed()
      iio: consumers: Add an iio_multiply_value() helper function
      iio: Improve iio_read_channel_processed_scale() precision
      iio: test: Add KUnit tests for iio_multiply_value()
      iio: adc: Add Intel Dollar Cove TI PMIC ADC driver

Ioana Risteiu (4):
      iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
      dt-bindings: iio: adc: add IIO backend support
      iio: adc: extract setup function without backend
      iio: adc: update ad7779 to use IIO backend

Jonas Karlman (1):
      dt-bindings: iio: adc: rockchip-saradc: Allow use of a power-domain

Jonathan Cameron (12):
      iio: light: acpi-als: Use a structure for layout of data to push to b=
uffer.
      iio: light: acpi-als: Use iio_push_to_buffers_with_ts() to allow runt=
ime source size check
      iio: light: adjd_s311: Use iio_push_to_buffers_with_ts() to allow sou=
rce size runtime check
      iio: light: isl29125: Use iio_push_to_buffers_with_ts() to allow sour=
ce size runtime check
      iio: light: max44000: Use iio_push_to_buffers_with_ts() to allow sour=
ce size runtime check
      iio: light: st_uvis25: Use iio_push_to_buffers_with_ts() to allow sou=
rce size runtime check
      iio: light: tcs3414: Use iio_push_to_buffers_with_ts() to allow sourc=
e size runtime check
      iio: light: tcs3472: Use iio_push_to_buffers_with_ts() to allow sourc=
e size runtime check
      iio: light: vcnl4000: Use a structure to make buffer arrangement expl=
icit.
      iio: light: vl6180: Use iio_push_to_buffers_with_ts() to allow source=
 size runtime check
      iio: light: Simple conversions to iio_push_to_buffers_with_ts()
      Merge tag 'v6.17-rc3' into togreg

Jonathan Santos (1):
      iio: adc: ad7768-1: use devm_regulator_get_enable_read_voltage()

Jorge Marques (1):
      docs: iio: ad3552r: Fix malformed code-block directive

Junjie Cao (1):
      iio: core: switch info_mask fields to unsigned long to match find_bit=
 helpers

Krzysztof Kozlowski (12):
      dt-bindings: iio: Drop unused header includes in examples
      dt-bindings: iio: adc: Replace hard-coded GPIO/IRQ flag with a define
      dt-bindings: iio: adc: samsung,exynos-adc: Use correct IRQ level in e=
xample
      dt-bindings: iio: light: Simplify interrupts property in the example
      iio: adc: ti-adc12138: Simplify with devm_clk_get_enabled()
      dt-bindings: iio: Replace bouncing Analog emails
      dt-bindings: iio: adi,ltc2664: Minor whitespace cleanup in example
      iio: adc: exynos_adc: Drop S3C2410 support
      iio: adc: exynos_adc: Drop touchscreen support
      iio: adc: exynos_adc: Drop platform data support
      dt-bindings: iio: adc: samsung,exynos: Drop S3C2410
      dt-bindings: iio: adc: samsung,exynos: Drop touchscreen support

Lothar Rubusch (7):
      iio: accel: adxl345: simplify tap suppress bit
      iio: accel: adxl345: add activity event feature
      iio: accel: adxl345: add inactivity feature
      iio: accel: adxl345: add coupling detection for activity/inactivity
      iio: accel: adxl345: extend inactivity time for less than 1s
      docs: iio: add documentation for adxl345 driver
      docs: iio: describe inactivity and free-fall detection on the ADXL345

Marcelo Schmitt (1):
      MAINTAINERS: Update max30208 maintainership

Matti Vaittinen (18):
      iio: adc: ad7476: Simplify chip type detection
      iio: adc: ad7476: Simplify scale handling
      iio: adc: ad7476: Use mV for internal reference
      iio: adc: ad7476: Use correct channel for bit info
      iio: adc: ad7476: use *_cansleep GPIO APIs
      iio: adc: ad7476: Drop convstart chan_spec
      iio: adc: ad7476: Conditionally call convstart
      dt-bindings: iio: adc: ad7476: Drop redundant prop: true
      dt-bindings: iio: adc: ad7476: Add ROHM bd79105
      iio: adc: ad7476: Support ROHM BD79105
      MAINTAINERS: A driver for simple 1-channel SPI ADCs
      dt-bindings: iio: adc: Add BD7910[0,1,2,3]
      iio: adc: adc128s052: Simplify matching chip_data
      iio: adc: adc128s052: Rename channel structs
      iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
      dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
      iio: adc: Support ROHM BD79112 ADC/GPIO
      MAINTAINERS: Support ROHM BD79112 ADC

Nuno S=C3=A1 (3):
      iio: buffer: buffer-cb: drop double initialization of demux list
      iio: imu: adis16475: remove extra line
      iio: dac: ad5791: drop unused member of struct ad5791_state

Primoz Fiser (1):
      dt-bindings: iio: afe: current-sense-amplifier: Add io-channel-cells

Qianfeng Rong (2):
      iio: imu: inv_icm42600: use min() to improve code
      iio: common: scmi_iio: use kcalloc() instead of kzalloc()

Rodrigo Gobbi (2):
      iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample bef=
ore setting register
      dt-bindings: iio: pressure: add invensense,icp10100

Sakari Ailus (12):
      iio: accel: Remove redundant pm_runtime_mark_last_busy() calls
      iio: adc: Remove redundant pm_runtime_mark_last_busy() calls
      iio: chemical: Remove redundant pm_runtime_mark_last_busy() calls
      iio: common: Remove redundant pm_runtime_mark_last_busy() calls
      iio: gyro: Remove redundant pm_runtime_mark_last_busy() calls
      iio: imu: Remove redundant pm_runtime_mark_last_busy() calls
      iio: light: Remove redundant pm_runtime_mark_last_busy() calls
      iio: magnetometer: Remove redundant pm_runtime_mark_last_busy() calls
      iio: pressure: Remove redundant pm_runtime_mark_last_busy() calls
      iio: proximity: Remove redundant pm_runtime_mark_last_busy() calls
      iio: temperature: Remove redundant pm_runtime_mark_last_busy() calls
      iio: dac: Remove redundant pm_runtime_mark_last_busy() calls

Salah Triki (3):
      staging: iio: adc: ad7816: Drop unnecessary dev_set_drvdata() call
      iio: pressure: bmp280: Remove noisy dev_info()
      iio: pressure: bmp280: Use gpiod_set_value_cansleep()

Salih Erim (1):
      MAINTAINERS: Update xilinx-ams driver maintainers

Sean Nyekjaer (5):
      iio: imu: inv_icm42600: Simplify pm_runtime setup
      iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in=
 resume
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspe=
nded
      iio: imu: inv_icm42600: Use devm_regulator_get_enable() for vdd regul=
ator
      iio: imu: inv_icm42600: use guard() to release mutexes

Stefano Manni (2):
      iio: adc: ad799x: add reference voltage capability to chip_info
      iio: adc: ad799x: add reference voltage to ad7994

Waqar Hameed (1):
      iio: Remove error prints for devm_add_action_or_reset()

Wolfram Sang (1):
      iio: remove unneeded 'fast_io' parameter in regmap_config

Xichao Zhao (8):
      iio: adc: ti-tsc2046: use us_to_ktime() where appropriate
      iio: accel: msa311: Remove dev_err_probe() if error is -ENOMEM
      iio: adc: Remove dev_err_probe() if error is -ENOMEM
      iio: chemical: Remove dev_err_probe() if error is -ENOMEM
      iio: imu: bmi323: Remove dev_err_probe() if error is -ENOMEM
      iio: light: Remove dev_err_probe() if error is -ENOMEM
      iio: proximity: Remove dev_err_probe() if error is -ENOMEM
      iio: temperature: mlx90635: Remove dev_err_probe() if error is -ENOMEM

Xing Guo (1):
      docs: iio: Fix unexpected indentation for adxl345.

 Documentation/ABI/testing/sysfs-bus-iio            |   56 +-
 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |   10 -
 .../bindings/iio/accel/adi,adis16240.yaml          |    4 +-
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml |    2 -
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |    2 -
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |    2 -
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |    5 +-
 .../bindings/iio/accel/bosch,bma255.yaml           |    1 -
 .../bindings/iio/accel/bosch,bma400.yaml           |    1 -
 .../bindings/iio/accel/kionix,kxsd9.yaml           |    1 -
 .../devicetree/bindings/iio/adc/adi,ad7091r5.yaml  |    1 -
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |   24 +-
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |    1 -
 .../devicetree/bindings/iio/adc/adi,ad7476.yaml    |  100 +-
 .../devicetree/bindings/iio/adc/adi,ad7779.yaml    |   44 +-
 .../devicetree/bindings/iio/adc/adi,ade9000.yaml   |   95 ++
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |    1 -
 .../devicetree/bindings/iio/adc/maxim,max1238.yaml |    3 +
 .../devicetree/bindings/iio/adc/maxim,max1241.yaml |    2 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |    1 -
 .../bindings/iio/adc/rockchip-saradc.yaml          |    3 +
 .../devicetree/bindings/iio/adc/rohm,bd79104.yaml  |   11 +-
 .../devicetree/bindings/iio/adc/rohm,bd79112.yaml  |  104 ++
 .../devicetree/bindings/iio/adc/rohm,bd79124.yaml  |    2 +-
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |   33 +-
 .../devicetree/bindings/iio/adc/ti,adc128s052.yaml |    1 -
 .../devicetree/bindings/iio/adc/ti,ads1298.yaml    |    1 -
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |    3 +-
 .../bindings/iio/afe/current-sense-amplifier.yaml  |    4 +
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |    3 +-
 .../devicetree/bindings/iio/dac/adi,ltc2664.yaml   |    2 +-
 .../devicetree/bindings/iio/frequency/adf4371.yaml |    3 +-
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |    1 -
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml |    3 +-
 .../bindings/iio/imu/invensense,icm42600.yaml      |    2 -
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |    2 -
 .../bindings/iio/light/dynaimage,al3010.yaml       |    2 +-
 .../bindings/iio/light/dynaimage,al3320a.yaml      |    2 +-
 .../devicetree/bindings/iio/light/st,vl6180.yaml   |    1 -
 .../bindings/iio/light/vishay,veml6046x00.yaml     |   51 +
 .../iio/magnetometer/infineon,tlv493d-a1b6.yaml    |   45 +
 .../iio/magnetometer/voltafield,af8133j.yaml       |    1 -
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |    1 -
 .../bindings/iio/pressure/invensense,icp10100.yaml |   52 +
 .../iio/temperature/microchip,mcp9600.yaml         |   56 +-
 .../bindings/mfd/marvell,88pm886-a1.yaml           |    4 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 Documentation/iio/ad3552r.rst                      |    3 +-
 Documentation/iio/ade9000.rst                      |  268 +++
 Documentation/iio/adxl345.rst                      |  443 +++++
 Documentation/iio/bno055.rst                       |   12 +-
 Documentation/iio/index.rst                        |    2 +
 MAINTAINERS                                        |   34 +-
 drivers/iio/accel/adxl345_core.c                   |  782 ++++++++-
 drivers/iio/accel/bma180.c                         |   13 +-
 drivers/iio/accel/bma220_spi.c                     |    4 +-
 drivers/iio/accel/bmc150-accel-core.c              |    7 +-
 drivers/iio/accel/bmi088-accel-core.c              |    3 -
 drivers/iio/accel/dmard06.c                        |    4 +-
 drivers/iio/accel/dmard09.c                        |    4 +-
 drivers/iio/accel/dmard10.c                        |    4 +-
 drivers/iio/accel/fxls8962af-core.c                |    1 -
 drivers/iio/accel/kxcjk-1013.c                     |    4 +-
 drivers/iio/accel/kxsd9.c                          |    3 -
 drivers/iio/accel/mc3230.c                         |    4 +-
 drivers/iio/accel/mma7660.c                        |    4 +-
 drivers/iio/accel/mma8452.c                        |    7 +-
 drivers/iio/accel/mma9551_core.c                   |    5 +-
 drivers/iio/accel/msa311.c                         |   16 +-
 drivers/iio/accel/stk8312.c                        |    4 +-
 drivers/iio/accel/stk8ba50.c                       |    4 +-
 drivers/iio/adc/88pm886-gpadc.c                    |  393 +++++
 drivers/iio/adc/Kconfig                            |   54 +
 drivers/iio/adc/Makefile                           |    4 +
 drivers/iio/adc/ab8500-gpadc.c                     |    1 -
 drivers/iio/adc/ad4130.c                           |    3 +-
 drivers/iio/adc/ad7124.c                           |  563 ++++--
 drivers/iio/adc/ad7173.c                           |  221 ++-
 drivers/iio/adc/ad7476.c                           |  461 ++---
 drivers/iio/adc/ad7768-1.c                         |   37 +-
 drivers/iio/adc/ad7779.c                           |  192 ++-
 drivers/iio/adc/ad7949.c                           |    4 +-
 drivers/iio/adc/ad799x.c                           |   30 +-
 drivers/iio/adc/ade9000.c                          | 1799 ++++++++++++++++=
++++
 drivers/iio/adc/adi-axi-adc.c                      |    1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 |   13 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |    4 +-
 drivers/iio/adc/cpcap-adc.c                        |    6 +-
 drivers/iio/adc/da9150-gpadc.c                     |    5 +-
 drivers/iio/adc/dln2-adc.c                         |    9 +-
 drivers/iio/adc/exynos_adc.c                       |  286 +---
 drivers/iio/adc/hx711.c                            |    2 +-
 drivers/iio/adc/imx7d_adc.c                        |    4 +-
 drivers/iio/adc/imx8qxp-adc.c                      |    6 +-
 drivers/iio/adc/imx93_adc.c                        |   26 +-
 drivers/iio/adc/intel_dc_ti_adc.c                  |  328 ++++
 drivers/iio/adc/mcp3564.c                          |    2 +-
 drivers/iio/adc/meson_saradc.c                     |    2 +-
 drivers/iio/adc/mt6577_auxadc.c                    |    3 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |    4 +-
 drivers/iio/adc/pac1921.c                          |    3 +-
 drivers/iio/adc/pac1934.c                          |   11 +-
 drivers/iio/adc/palmas_gpadc.c                     |    4 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    8 +-
 drivers/iio/adc/rn5t618-adc.c                      |    4 +-
 drivers/iio/adc/rockchip_saradc.c                  |    6 +-
 drivers/iio/adc/rohm-bd79112.c                     |  556 ++++++
 drivers/iio/adc/rzg2l_adc.c                        |    2 -
 drivers/iio/adc/spear_adc.c                        |   12 +-
 drivers/iio/adc/stm32-adc-core.c                   |    1 -
 drivers/iio/adc/stm32-adc.c                        |    7 -
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    4 +-
 drivers/iio/adc/stmpe-adc.c                        |    4 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    3 -
 drivers/iio/adc/ti-adc081c.c                       |   40 +-
 drivers/iio/adc/ti-adc084s021.c                    |    4 +-
 drivers/iio/adc/ti-adc12138.c                      |   30 +-
 drivers/iio/adc/ti-adc128s052.c                    |  132 +-
 drivers/iio/adc/ti-ads1015.c                       |    6 +-
 drivers/iio/adc/ti-ads1100.c                       |    1 -
 drivers/iio/adc/ti-ads1119.c                       |   11 +-
 drivers/iio/adc/ti-ads131e08.c                     |    8 +-
 drivers/iio/adc/ti-ads7924.c                       |    9 +-
 drivers/iio/adc/ti-tsc2046.c                       |    6 +-
 drivers/iio/adc/ti_am335x_adc.c                    |    5 +-
 drivers/iio/adc/twl4030-madc.c                     |    4 +-
 drivers/iio/adc/vf610_adc.c                        |    2 +-
 drivers/iio/adc/viperboard_adc.c                   |    4 +-
 drivers/iio/buffer/industrialio-buffer-cb.c        |    1 -
 drivers/iio/chemical/atlas-sensor.c                |    2 -
 drivers/iio/chemical/bme680_core.c                 |    3 -
 drivers/iio/chemical/ens160_core.c                 |    3 +-
 drivers/iio/chemical/scd30_core.c                  |    2 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |    1 -
 drivers/iio/common/scmi_sensors/scmi_iio.c         |   10 +-
 drivers/iio/dac/ad5380.c                           |    4 +-
 drivers/iio/dac/ad5764.c                           |    4 +-
 drivers/iio/dac/ad5791.c                           |    4 -
 drivers/iio/dac/ds4424.c                           |    4 +-
 drivers/iio/dac/stm32-dac.c                        |   19 +-
 drivers/iio/dac/ti-dac7311.c                       |    4 +-
 drivers/iio/frequency/adf4350.c                    |    3 +-
 drivers/iio/gyro/bmg160_core.c                     |    4 +-
 drivers/iio/gyro/fxas21002c_core.c                 |    2 -
 drivers/iio/gyro/mpu3050-core.c                    |    3 -
 drivers/iio/gyro/mpu3050-i2c.c                     |    1 -
 drivers/iio/health/afe4403.c                       |   48 +-
 drivers/iio/health/afe4404.c                       |   48 +-
 drivers/iio/humidity/am2315.c                      |    4 +-
 drivers/iio/humidity/dht11.c                       |    4 +-
 drivers/iio/imu/adis16475.c                        |    1 -
 drivers/iio/imu/bmi270/bmi270_i2c.c                |    2 +
 drivers/iio/imu/bmi323/bmi323_core.c               |    3 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |    1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   29 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   65 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  117 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   29 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |    1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    6 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |    1 -
 drivers/iio/imu/kmx61.c                            |    6 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   14 +-
 drivers/iio/industrialio-core.c                    |   11 +-
 drivers/iio/inkern.c                               |   81 +-
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/acpi-als.c                       |   19 +-
 drivers/iio/light/adjd_s311.c                      |   12 +-
 drivers/iio/light/al3000a.c                        |    2 +-
 drivers/iio/light/apds9306.c                       |    4 +-
 drivers/iio/light/apds9960.c                       |    1 -
 drivers/iio/light/bh1745.c                         |    7 +-
 drivers/iio/light/bh1780.c                         |    1 -
 drivers/iio/light/gp2ap002.c                       |    2 -
 drivers/iio/light/hid-sensor-als.c                 |    5 +-
 drivers/iio/light/isl29028.c                       |   11 +-
 drivers/iio/light/isl29125.c                       |   14 +-
 drivers/iio/light/ltr390.c                         |  197 ++-
 drivers/iio/light/ltr501.c                         |    4 +-
 drivers/iio/light/ltrf216a.c                       |    1 -
 drivers/iio/light/max44000.c                       |   18 +-
 drivers/iio/light/opt4001.c                        |    3 +-
 drivers/iio/light/opt4060.c                        |    7 +-
 drivers/iio/light/pa12203001.c                     |   11 +-
 drivers/iio/light/rohm-bu27034.c                   |    3 +-
 drivers/iio/light/rpr0521.c                        |   10 +-
 drivers/iio/light/si1145.c                         |    5 +-
 drivers/iio/light/st_uvis25.h                      |    5 -
 drivers/iio/light/st_uvis25_core.c                 |   12 +-
 drivers/iio/light/stk3310.c                        |    4 +-
 drivers/iio/light/tcs3414.c                        |   15 +-
 drivers/iio/light/tcs3472.c                        |   14 +-
 drivers/iio/light/tsl2583.c                        |   12 +-
 drivers/iio/light/tsl2591.c                        |    2 -
 drivers/iio/light/us5182d.c                        |   12 +-
 drivers/iio/light/vcnl4000.c                       |   22 +-
 drivers/iio/light/vcnl4035.c                       |   11 +-
 drivers/iio/light/veml6030.c                       |    2 +-
 drivers/iio/light/veml6040.c                       |    3 +-
 drivers/iio/light/veml6046x00.c                    | 1030 +++++++++++
 drivers/iio/light/vl6180.c                         |   16 +-
 drivers/iio/magnetometer/Kconfig                   |   15 +-
 drivers/iio/magnetometer/Makefile                  |    2 +
 drivers/iio/magnetometer/ak8974.c                  |    2 -
 drivers/iio/magnetometer/ak8975.c                  |    1 -
 drivers/iio/magnetometer/als31300.c                |    5 +-
 drivers/iio/magnetometer/bmc150_magn.c             |   13 +-
 drivers/iio/magnetometer/tlv493d.c                 |  526 ++++++
 drivers/iio/magnetometer/tmag5273.c                |    5 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    2 -
 drivers/iio/potentiostat/lmp91000.c                |    4 +-
 drivers/iio/pressure/bmp280-core.c                 |    8 +-
 drivers/iio/pressure/dlhl60d.c                     |    4 +-
 drivers/iio/pressure/icp10100.c                    |    1 -
 drivers/iio/pressure/mpl115.c                      |    2 -
 drivers/iio/pressure/zpa2326.c                     |    2 -
 drivers/iio/proximity/d3323aa.c                    |    3 +-
 drivers/iio/proximity/hx9023s.c                    |    3 +-
 drivers/iio/proximity/irsd200.c                    |    6 +-
 drivers/iio/proximity/mb1232.c                     |   15 +-
 drivers/iio/proximity/ping.c                       |    4 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   16 +-
 drivers/iio/proximity/srf04.c                      |    8 +-
 drivers/iio/proximity/srf08.c                      |   18 +-
 drivers/iio/proximity/sx9500.c                     |   27 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |   27 +-
 drivers/iio/temperature/Kconfig                    |    8 +-
 drivers/iio/temperature/mcp9600.c                  |  151 +-
 drivers/iio/temperature/mlx90614.c                 |    1 -
 drivers/iio/temperature/mlx90632.c                 |    5 +-
 drivers/iio/temperature/mlx90635.c                 |    9 +-
 drivers/iio/test/Kconfig                           |   12 +
 drivers/iio/test/Makefile                          |    1 +
 drivers/iio/test/iio-test-multiply.c               |  212 +++
 drivers/staging/iio/adc/ad7816.c                   |    2 -
 include/linux/iio/consumer.h                       |   18 +
 include/linux/iio/iio.h                            |   20 +-
 include/linux/iio/types.h                          |    1 +
 include/linux/mfd/88pm886.h                        |   58 +
 include/linux/platform_data/touchscreen-s3c2410.h  |   22 -
 include/uapi/linux/iio/types.h                     |    5 +
 tools/iio/iio_event_monitor.c                      |   10 +
 243 files changed, 9187 insertions(+), 1859 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79112.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml=
6046x00.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/infi=
neon,tlv493d-a1b6.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/invensen=
se,icp10100.yaml
 create mode 100644 Documentation/iio/ade9000.rst
 create mode 100644 Documentation/iio/adxl345.rst
 create mode 100644 drivers/iio/adc/88pm886-gpadc.c
 create mode 100644 drivers/iio/adc/ade9000.c
 create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79112.c
 create mode 100644 drivers/iio/light/veml6046x00.c
 create mode 100644 drivers/iio/magnetometer/tlv493d.c
 create mode 100644 drivers/iio/test/iio-test-multiply.c
 delete mode 100644 include/linux/platform_data/touchscreen-s3c2410.h

