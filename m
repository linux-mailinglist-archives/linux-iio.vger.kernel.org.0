Return-Path: <linux-iio+bounces-6283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6009097AB
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77EAFB21FE1
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA4928DC7;
	Sat, 15 Jun 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWsQMtD2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDAC10A11
	for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718447674; cv=none; b=UjyTJLkdI+n/neQbsByoHsIpNthlXqaXrBfZ7y+T1QvDnRPNOKsB3iXZkwjNYt8iphV6Gm0VZHHb+XF+bfpWSWZsfUeycwfJ3BVSghlpPeJ1l/ZPQ1FrZVf4CsYZV+YW4OSt4iEd2+/wnQB+GRvVuPqsDDPdlqm555zcxesMZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718447674; c=relaxed/simple;
	bh=jQSVCIe/CfcRwHdtWxNxWcdmwvpBqW/AK5+dJiuBP8A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=JH7eGkiYl4cCvi86/KX3VFateZCK5n8m5aIfISUEnnFFdU9IV/h6Zcbxtm7njLyjgTy4PKMvRwhxe4thT9Nk01ki0eamDls7cn2PBy5o8M8HqnDSSU35sys4qGr04rmTNnwDu5A43r42E+J+PID/88gyj3cJABMXQv9MMeFXAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWsQMtD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98311C116B1;
	Sat, 15 Jun 2024 10:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718447673;
	bh=jQSVCIe/CfcRwHdtWxNxWcdmwvpBqW/AK5+dJiuBP8A=;
	h=Date:From:To:Subject:From;
	b=EWsQMtD2x7jh4Un4E727RZ46UyCk272MyPOgojxSwErpRONHuMxeJ8tZwtH69/rHI
	 wZ0uJPm807F/sF0rNW4G3jJF57/Cz9o2Q5LmJJO1i8ZA2Y9RGRyFA/0wgQ3cd6n3WK
	 DrKe1NQq9Mn+W85HBCljp0BNC3tmB+8VxgW1OK4nBooEFEdx+03/c01ldYVg6w6dXu
	 jHHK9t+BN6vO84OQjZKqpKuENaohRg4HzlYvtYfmCSh9c9ii2joYJ8AmdfAzUbkB+d
	 L8LNnVF6X31uSoV6NhLyd3WBClI8f+/xUuZKI2RPoO67+aFD4goK67C55d2jZK1Vwo
	 V0lyjoni9Op7g==
Date: Sat, 15 Jun 2024 11:34:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: First set of new device support, features and cleanup
 for 6.11
Message-ID: <20240615113428.680f6ba5@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.11a

for you to fetch changes up to 07d4d0bb4a8ddcc463ed599b22f510d5926c2495:

  iio: imu: inv_icm42600: add support of accel low-power mode (2024-06-13 1=
9:19:26 +0100)

----------------------------------------------------------------
IIO: 1st set of new device support, cleanups etc for 6.11

Lots of new device support and 3 entirely new drivers.

Early pull request this cycle to allow for clean picking up of fixes
that are dependencies for some queued patch sets.

Device support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

adi,ad3552r
- Add AD3541R and AD3551R - single output variants of already supported
  DACs.

adi,ad7192
- Add support for ad7194 24-bit ADC with integrated PGA.

adi,ad7380
- New ADC driver built up in a number of steps. Supports
  - 2 channel differential ADCs: AD7380, AD7381
  - 4 channel differential ADCs: AD7380-4, AD7381-4
  - 2 channel pseudo-differential ADCs: AD7383, AD7384
  - 4 channel pseudo-differential ADCs: AD7383-4, AD7384-4

adi,adis16475
- Support ADS16501 variant - ID and some different scale factors from
  parts already supported.
- Driver refactoring then enables support for 6 more IMUs:
  - ADIS16575-[2,3]
  - ADIS16576-[2,3]
  - ADIS16577-[2,3]

adi,adsi16480
- Driver refactoring and feature additions leading to support for 6 more
  IMUs - with new delta angle and delta velocity feature:
  - ADIS16545-[1,2,3]
  - ADIS16547-[1,2,3]

bosch,bmi160
- Support for the bmi120 IMU: ID only. Also relax ID checking to warn
  only on mismatch allowing use of fallback compatibles for new devices.

sciosense,ens160
- New driver for this metal oxide multi-gas sensor for indoor
  air quality monitoring.

sensortek,stk3110
- Support for stk3311a and stk3311s34 light sensor variants. Relax ID
  checking to warn only on a mismatch allowing use of fallback compatibles
  for new devices.

vishay,veml6040
- New driver for this RGBW light sensor. Note that whilst the register
  interface is very different, the dt-binding similar enough that it is
  shared with the existing vishay,veml6075 binding

x-powers,axp20x
- Add support for axp192, very similar to another supported PMIC ADC variant
  but with a few more GPIO channels.

Dt-binding only
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ti,ads1015
- Add binding (no driver support yet) for ti,tla2021

New features
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
core
- Variable scan type support.  We have papered over this for a long time
  so good to finally resolve it.
  Some devices will change their data output format (typically resolution)
  dependent on settings such as oversampling.  A new callback is added
  to enable this. First used in the ad7380 driver.
- Harden the core against missing callback functions.

dt-binding:
- Add a single-channel property that can be used in per channel nodes
  instead of reg to indicate which device channel.  This is important
  in devices with a mixture of differential and single ended channels
  as reg already just acted as an index for the differential channels
  making things inconsistent if it had more meaning for single ended
  channels.

adi,ad7380
- Use spi_optimize_message() to reduce reading message setup overhead.
- Add oversampling support using the new core functionality to allow
  a device support multiple scan types.

invense,icm42600
- Support for low-power accelerometer modes.  When a given sampling
  frequency is only supported at one power mode, use that. Otherwise
  default to low power at the cost of some noise unless overridden
  via a new sysfs attribute.

silicon-labs,si70720
- Add control of the heater.

Cleanups and minor fixes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

core
- Cleanup use of sizeof(struct xxxx) in favor of sizeof(*variable)

Makefile
- Resort the iio/adc/Makefile which has drifted away from alphabetical
  order.

gts library
- Fix sorting of lists with a zero in the middle. Doesn't happen with
  upstream drivers, but good to harden this code.  Add a related unit test.

multiple drivers
- Add missing MODULE_DESCRIPTION()
- Drop some unused structure fields.
- Drop some entirely unused structure definitions.
- Stop pointless initialization of i2c_device_id::driver_data to 0 in drive=
rs
  where it isn't used.
- Use spi_get_device_match_data() to replace open-coded equivalent.

adi,ad3552r
- Fix dt gain parameter names to reflect what the driver does. Note
  discussion in patch to justify fixing it in the binding not the
  driver.
- Tidy up some naming.

adi,ad7192
- Use read_avail() callback to handle the low pass filter.
- Add an aincom supply for pseudo differential operation.

adi,ad7606
- Use iio_device_claim_direct_scoped() to simplify error paths.

adi,ad7944
- Drop an unused function parameter.

adi,adrf6780
- Drop unused header.

adi,ad9467
- Use a DMA safe buffer for SPI transfers.
- Stop using tabs to pad structure field names. It was creating a lot
  of noise.

adi,axi-adc
- Prevent races between enable and disable calls.
- Ensure the DRP (dynamic reconfiguration port) is locked. Not used
  in most real designs, but better safe than sorry.
- Limit build to COMPILE_TEST or platforms for which the IP exists.

adi,axi-dac
- Limit build to COMPILE_TEST or platforms for which the IP exists.

ams,iaq
- Use __packed instead of ___attribute__((__packed__))

bosch,bmp280
- White space cleanup.
- Use BME280 prefix for registers that do not exist on the BMP280.
- Add parameter names to callback function definitions.
- Rename measure function to better reflect what it does which is wait
  for a measurement to happen.
- Drop a redundant error check.
- Improve error messages
- Make error checks consistent as if (ret)
- Use unsigned types for inherently unsigned data.
- Refactor reading functions to not rely on a hidden t_fine variable.
- Make use of cleanup.h

freescale,mma7660
- Add mount matrix support.

invense,icm42600
- Enable the regmap cache to reduce bus accesses.

amlogic,meson-saradc
- Add dt-binding support for power-domains.

ti,adc161s626
- Use iio_device_claim_direct_scoped() to simplify error handling.

----------------------------------------------------------------
Aidan MacDonald (1):
      iio: adc: axp20x_adc: Add support for AXP192

Alisa-Dariana Roman (6):
      iio: adc: ad7192: Use standard attribute
      dt-bindings: iio: adc: ad7192: Add aincom supply
      iio: adc: ad7192: Add aincom supply
      dt-bindings: iio: adc: Add single-channel property
      dt-bindings: iio: adc: ad7192: Add AD7194 support
      iio: adc: ad7192: Add AD7194 support

Angelo Dureghello (6):
      dt-bindings: iio: dac: fix ad3552r gain parameter names
      dt-bindings: iio: dac: add ad35xxr single output variants
      iio: dac: ad3552r: add model data structure
      iio: dac: ad3552r: add support for ad3541r and ad3551r
      iio: dac: ad3552r: change AD3552R_NUM_CH define name
      iio: dac: ad3552r: uniform structure names

Antoni Pokusinski (1):
      iio: humidity: si7020: add heater support

Antoniu Miclaus (1):
      iio: frequency: adrf6780: rm clk provider include

Arthur Becker (2):
      iio: light: driver for Vishay VEML6040
      dt-bindings: iio: light: add VEML6040 RGBW-LS

Barnab=C3=A1s Cz=C3=A9m=C3=A1n (3):
      iio: light: stk3310: relax failure to match id
      iio: light: stk3310: make chip id check expandable
      iio: light: stk3310: support more stk3311 variants

Bruna Bispo (1):
      iio: chemical: ams-iaq-core: clean up codestyle warning

Chenyuan Yang (1):
      iio: Fix the sorting functionality in iio_gts_build_avail_time_table

Christophe JAILLET (4):
      iio: temperature: max30208: Remove an unused field in struct max30208=
_data
      iio: multiplexer: Remove an unused field in struct mux
      iio: tmag5273: Remove some unused field in struct tmag5273_data
      iio: light: gp2ap020a00f: Remove some unused field in struct gp2ap020=
a00f_data

Danila Tikhonov (2):
      iio: imu: bmi160: add support for bmi120
      dt-bindings: iio: imu: bmi160: add bmi120

David Lechner (10):
      iio: adc: sort Makefile
      iio: adc: ad7944: remove unused parameter
      dt-bindings: iio: adc: Add binding for AD7380 ADCs
      iio: adc: ad7380: new driver for AD7380 ADCs
      dt-bindings: iio: adc: ad7380: add pseudo-differential parts
      iio: adc: ad7380: add support for pseudo-differential parts
      iio: introduce struct iio_scan_type
      iio: buffer: use struct iio_scan_type to simplify code
      iio: add support for multiple scan types per channel
      iio: adc: ad7380: use spi_optimize_message()

Denis Benato (1):
      iio: imu: bmi323: Use iio read_acpi_mount_matrix() helper

Dimitri Fedrau (1):
      iio: temperature: mcp9600: add threshold events support

Dr. David Alan Gilbert (4):
      iio: accel: bmi088: remove unused struct 'bmi088_scale_info'
      iio: adc: pac1934: remove unused struct 'samp_rate_mapping'
      iio: light: rohm-bu27034: remove unused struct 'bu27034_result'
      staging: iio: adt7316: remove unused struct 'adt7316_limit_regs'

Erick Archer (1):
      iio: event: use sizeof(*pointer) instead of sizeof(type)

Gustavo Silva (6):
      dt-bindings: vendor-prefixes: add ScioSense
      dt-bindings: iio: chemical: add ENS160 sensor
      iio: chemical: add driver for ENS160 sensor
      iio: chemical: ens160: add triggered buffer support
      iio: chemical: ens160: add power management support
      MAINTAINERS: Add ScioSense ENS160

Gustavo Ueti Fukunaga (1):
      iio: adc: ti-adc161s626: make use of iio_device_claim_direct_scoped()

Jean-Baptiste Maneyrol (3):
      iio: imu: inv_icm42600: add register caching in the regmap
      iio: document inv_icm42600 driver private sysfs attributes
      iio: imu: inv_icm42600: add support of accel low-power mode

Jeff Johnson (1):
      iio: add missing MODULE_DESCRIPTION() macros

Jorge Harrisonn (1):
      iio: adc: ad7606: using claim_direct_scoped for code simplification

Josua Mayer (1):
      dt-bindings: iio: adc: ti,ads1015: add compatible for tla2021

Julien Stephan (5):
      iio: adc: ad7380: prepare for parts with more channels
      dt-bindings: iio: adc: ad7380: add support for ad738x-4 4 channels va=
riants
      iio: adc: ad7380: add support for ad738x-4 4 channels variants
      iio: adc: ad7380: add oversampling support
      driver: iio: add missing checks on iio_info's callback access

Krzysztof Kozlowski (8):
      iio: accel: adxl313: simplify with spi_get_device_match_data()
      iio: accel: adxl355: simplify with spi_get_device_match_data()
      iio: adc: max11205: simplify with spi_get_device_match_data()
      iio: adc: ti-ads131e08: simplify with spi_get_device_match_data()
      iio: adc: ti-tsc2046: simplify with spi_get_device_match_data()
      iio: addac: ad74413r: simplify with spi_get_device_match_data()
      iio: dac: max5522: simplify with spi_get_device_match_data()
      iio: adc: mcp3564: drop redundant open-coded spi_get_device_match_dat=
a()

Matti Vaittinen (1):
      iio: test: gts: test available times and gains sorting

Neil Armstrong (1):
      dt-bindings: iio: adc: amlogic,meson-saradc: add optional power-domai=
ns

Nuno Sa (6):
      iio: adc: ad9467: use DMA safe buffer for spi
      iio: adc: ad9467: change struct members padding
      iio: adc: adi-axi-adc: don't allow concurrent enable/disable calls
      iio: adc: adi-axi-adc: make sure DRP is locked on enable
      iio: adc: adi-axi-adc: add platform dependencies
      iio: dac: adi-axi-dac: add platform dependencies

Ramona Gradinariu (15):
      dt-bindings: iio: imu: Add ADIS16501 compatibles
      drivers: iio: imu: Add support for ADIS16501
      iio: imu: adis_buffer: Add buffer setup API with buffer attributes
      iio: imu: adis16475: Create push single sample API
      drivers: iio: imu: adis16475: generic computation for sample rate
      iio: imu: adis_trigger: Allow level interrupts for FIFO readings
      iio: imu: adis16475: Re-define ADIS16475_DATA
      dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
      drivers: iio: imu: Add support for adis1657x family
      iio: adis16480: make the burst_max_speed configurable
      iio: imu: adis16480.c: Add delta angle and delta velocity channels
      dt-bindings: iio: imu: Add ADIS16545/47 compatibles
      iio: adis16480: add support for adis16545/7 families
      docs: iio: add documentation for interfacing tools
      docs: iio: add documentation for adis16480 driver

Uwe Kleine-K=C3=B6nig (2):
      iio: Drop explicit initialization of struct i2c_device_id::driver_dat=
a to 0
      staging: iio: Drop explicit initialization of struct i2c_device_id::d=
river_data to 0

Val Packett (1):
      iio: accel: mma7660: add mount-matrix support

Vasileios Amoiridis (10):
      iio: pressure: bmp280: Improve indentation and line wrapping
      iio: pressure: bmp280: Use BME prefix for BME280 specifics
      iio: pressure: bmp280: Add identifier names in function definitions
      iio: pressure: bmp280: Add more intuitive name for bmp180_measure()
      iio: pressure: bmp280: Remove dead error checks
      iio: pressure: bmp280: Remove, add and update error messages
      iio: pressure: bmp280: Make error checks consistent
      iio: pressure: bmp280: Use unsigned data types for raw sensor data
      iio: pressure: bmp280: Refactorize reading functions
      iio: pressure: bmp280: Introduce new cleanup routines

 .../ABI/testing/sysfs-bus-iio-inv_icm42600         |  18 +
 Documentation/devicetree/bindings/iio/adc/adc.yaml |  19 +
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |  95 +++
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 148 ++++
 .../bindings/iio/adc/amlogic,meson-saradc.yaml     |   3 +
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |   1 +
 .../bindings/iio/chemical/sciosense,ens160.yaml    |  70 ++
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  43 +-
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |  31 +
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml |   6 +
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |   6 +-
 .../bindings/iio/light/vishay,veml6075.yaml        |   9 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/iio/adis16475.rst                    |  23 +-
 Documentation/iio/adis16480.rst                    | 443 +++++++++++
 Documentation/iio/iio_tools.rst                    |  27 +
 Documentation/iio/index.rst                        |   2 +
 MAINTAINERS                                        |  19 +
 drivers/iio/accel/adxl313_spi.c                    |   8 +-
 drivers/iio/accel/adxl355_spi.c                    |  10 +-
 drivers/iio/accel/adxl367_i2c.c                    |   4 +-
 drivers/iio/accel/adxl372_i2c.c                    |   2 +-
 drivers/iio/accel/bma400_i2c.c                     |   2 +-
 drivers/iio/accel/bmi088-accel-core.c              |   5 -
 drivers/iio/accel/da311.c                          |   2 +-
 drivers/iio/accel/dmard06.c                        |   6 +-
 drivers/iio/accel/dmard09.c                        |   4 +-
 drivers/iio/accel/dmard10.c                        |   2 +-
 drivers/iio/accel/kxsd9-i2c.c                      |   4 +-
 drivers/iio/accel/mc3230.c                         |   2 +-
 drivers/iio/accel/mma7455_i2c.c                    |   4 +-
 drivers/iio/accel/mma7660.c                        |  52 +-
 drivers/iio/accel/mma9551.c                        |   2 +-
 drivers/iio/accel/mma9553.c                        |   4 +-
 drivers/iio/accel/mxc4005.c                        |   6 +-
 drivers/iio/accel/mxc6255.c                        |   4 +-
 drivers/iio/accel/stk8312.c                        |   4 +-
 drivers/iio/accel/stk8ba50.c                       |   2 +-
 drivers/iio/adc/Kconfig                            |  28 +-
 drivers/iio/adc/Makefile                           |  25 +-
 drivers/iio/adc/ad7192.c                           | 273 +++++--
 drivers/iio/adc/ad7291.c                           |   2 +-
 drivers/iio/adc/ad7380.c                           | 833 +++++++++++++++++=
++++
 drivers/iio/adc/ad7606.c                           |  19 +-
 drivers/iio/adc/ad7944.c                           |   8 +-
 drivers/iio/adc/ad9467.c                           | 103 ++-
 drivers/iio/adc/adi-axi-adc.c                      |  18 +-
 drivers/iio/adc/axp20x_adc.c                       | 279 +++++++
 drivers/iio/adc/ingenic-adc.c                      |   1 +
 drivers/iio/adc/ltc2485.c                          |   2 +-
 drivers/iio/adc/max11205.c                         |   5 +-
 drivers/iio/adc/mcp3564.c                          |   6 -
 drivers/iio/adc/nau7802.c                          |   2 +-
 drivers/iio/adc/pac1934.c                          |   5 -
 drivers/iio/adc/ti-adc161s626.c                    |  18 +-
 drivers/iio/adc/ti-ads131e08.c                     |   4 +-
 drivers/iio/adc/ti-ads7924.c                       |   2 +-
 drivers/iio/adc/ti-tsc2046.c                       |   7 +-
 drivers/iio/adc/xilinx-ams.c                       |   1 +
 drivers/iio/addac/ad74413r.c                       |  13 +-
 drivers/iio/buffer/kfifo_buf.c                     |   1 +
 drivers/iio/chemical/Kconfig                       |  20 +
 drivers/iio/chemical/Makefile                      |   3 +
 drivers/iio/chemical/ams-iaq-core.c                |   4 +-
 drivers/iio/chemical/bme680_i2c.c                  |   4 +-
 drivers/iio/chemical/ccs811.c                      |   2 +-
 drivers/iio/chemical/ens160.h                      |  10 +
 drivers/iio/chemical/ens160_core.c                 | 367 +++++++++
 drivers/iio/chemical/ens160_i2c.c                  |  62 ++
 drivers/iio/chemical/ens160_spi.c                  |  61 ++
 drivers/iio/dac/Kconfig                            |   1 +
 drivers/iio/dac/ad3552r.c                          | 140 ++--
 drivers/iio/dac/max5522.c                          |  11 +-
 drivers/iio/dac/mcp4728.c                          |   2 +-
 drivers/iio/frequency/adrf6780.c                   |   1 -
 drivers/iio/gyro/bmg160_i2c.c                      |   6 +-
 drivers/iio/gyro/fxas21002c_i2c.c                  |   2 +-
 drivers/iio/gyro/itg3200_core.c                    |   2 +-
 drivers/iio/health/afe4404.c                       |   2 +-
 drivers/iio/health/max30100.c                      |   2 +-
 drivers/iio/humidity/am2315.c                      |   2 +-
 drivers/iio/humidity/hdc100x.c                     |  12 +-
 drivers/iio/humidity/si7005.c                      |   4 +-
 drivers/iio/humidity/si7020.c                      | 141 +++-
 drivers/iio/imu/Kconfig                            |   4 +-
 drivers/iio/imu/adis16475.c                        | 807 +++++++++++++++++=
---
 drivers/iio/imu/adis16480.c                        | 393 ++++++++--
 drivers/iio/imu/adis_buffer.c                      |  32 +-
 drivers/iio/imu/adis_trigger.c                     |  37 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |  26 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |   5 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |   3 +
 drivers/iio/imu/bmi323/bmi323_core.c               |   8 +-
 drivers/iio/imu/bno055/bno055_i2c.c                |   2 +-
 drivers/iio/imu/fxos8700_i2c.c                     |   2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   4 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 124 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  71 ++
 drivers/iio/imu/kmx61.c                            |   2 +-
 drivers/iio/industrialio-buffer.c                  | 129 +++-
 drivers/iio/industrialio-core.c                    |   7 +-
 drivers/iio/industrialio-event.c                   |  13 +-
 drivers/iio/industrialio-gts-helper.c              |   7 +-
 drivers/iio/inkern.c                               |  32 +-
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/adjd_s311.c                      |   2 +-
 drivers/iio/light/adux1020.c                       |   2 +-
 drivers/iio/light/al3320a.c                        |   2 +-
 drivers/iio/light/apds9300.c                       |   2 +-
 drivers/iio/light/apds9960.c                       |   2 +-
 drivers/iio/light/bh1780.c                         |   4 +-
 drivers/iio/light/cm3232.c                         |   2 +-
 drivers/iio/light/cm3323.c                         |   2 +-
 drivers/iio/light/cm36651.c                        |   2 +-
 drivers/iio/light/gp2ap002.c                       |   4 +-
 drivers/iio/light/gp2ap020a00f.c                   |   3 +-
 drivers/iio/light/isl29028.c                       |   4 +-
 drivers/iio/light/isl29125.c                       |   2 +-
 drivers/iio/light/jsa1212.c                        |   2 +-
 drivers/iio/light/lv0104cs.c                       |   2 +-
 drivers/iio/light/max44000.c                       |   2 +-
 drivers/iio/light/max44009.c                       |   2 +-
 drivers/iio/light/noa1305.c                        |   2 +-
 drivers/iio/light/opt3001.c                        |   2 +-
 drivers/iio/light/pa12203001.c                     |   2 +-
 drivers/iio/light/rohm-bu27034.c                   |   6 -
 drivers/iio/light/rpr0521.c                        |   2 +-
 drivers/iio/light/si1133.c                         |   2 +-
 drivers/iio/light/stk3310.c                        |  37 +-
 drivers/iio/light/tcs3414.c                        |   2 +-
 drivers/iio/light/tcs3472.c                        |   2 +-
 drivers/iio/light/tsl4531.c                        |   2 +-
 drivers/iio/light/us5182d.c                        |   2 +-
 drivers/iio/light/vcnl4035.c                       |   2 +-
 drivers/iio/light/veml6030.c                       |   2 +-
 drivers/iio/light/veml6040.c                       | 281 +++++++
 drivers/iio/light/veml6070.c                       |   2 +-
 drivers/iio/light/vl6180.c                         |   2 +-
 drivers/iio/light/zopt2201.c                       |   2 +-
 drivers/iio/magnetometer/af8133j.c                 |   2 +-
 drivers/iio/magnetometer/ak8974.c                  |   8 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |   6 +-
 drivers/iio/magnetometer/mag3110.c                 |   2 +-
 drivers/iio/magnetometer/mmc35240.c                |   2 +-
 drivers/iio/magnetometer/tmag5273.c                |   2 -
 drivers/iio/multiplexer/iio-mux.c                  |   1 -
 drivers/iio/potentiostat/lmp91000.c                |   4 +-
 drivers/iio/pressure/bmp280-core.c                 | 783 +++++++++++------=
--
 drivers/iio/pressure/bmp280-regmap.c               |   8 +-
 drivers/iio/pressure/bmp280-spi.c                  |   4 +-
 drivers/iio/pressure/bmp280.h                      |  65 +-
 drivers/iio/pressure/dps310.c                      |   2 +-
 drivers/iio/pressure/hp03.c                        |   4 +-
 drivers/iio/pressure/icp10100.c                    |   2 +-
 drivers/iio/pressure/mpl115_i2c.c                  |   2 +-
 drivers/iio/pressure/mpl3115.c                     |   2 +-
 drivers/iio/pressure/t5403.c                       |   2 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |   4 +-
 drivers/iio/proximity/isl29501.c                   |   2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   6 +-
 drivers/iio/proximity/rfd77402.c                   |   2 +-
 drivers/iio/proximity/sx9500.c                     |   4 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |   2 +-
 drivers/iio/temperature/max30208.c                 |   1 -
 drivers/iio/temperature/mcp9600.c                  | 363 ++++++++-
 drivers/iio/temperature/mlx90632.c                 |   2 +-
 drivers/iio/temperature/tmp006.c                   |   2 +-
 drivers/iio/temperature/tmp007.c                   |   2 +-
 drivers/iio/temperature/tsys01.c                   |   2 +-
 drivers/iio/temperature/tsys02d.c                  |   2 +-
 drivers/iio/test/iio-test-gts.c                    |   8 +-
 drivers/staging/iio/addac/adt7316-i2c.c            |  12 +-
 drivers/staging/iio/addac/adt7316.c                |   9 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   4 +-
 include/linux/iio/iio.h                            |  94 ++-
 include/linux/iio/imu/adis.h                       |  21 +-
 177 files changed, 6041 insertions(+), 1125 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7380.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sciosens=
e,ens160.yaml
 create mode 100644 Documentation/iio/adis16480.rst
 create mode 100644 Documentation/iio/iio_tools.rst
 create mode 100644 drivers/iio/adc/ad7380.c
 create mode 100644 drivers/iio/chemical/ens160.h
 create mode 100644 drivers/iio/chemical/ens160_core.c
 create mode 100644 drivers/iio/chemical/ens160_i2c.c
 create mode 100644 drivers/iio/chemical/ens160_spi.c
 create mode 100644 drivers/iio/light/veml6040.c

