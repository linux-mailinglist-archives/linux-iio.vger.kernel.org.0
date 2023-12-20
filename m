Return-Path: <linux-iio+bounces-1142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2181A1BF
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 16:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342941C2443B
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2843D989;
	Wed, 20 Dec 2023 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVpofYce"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7369F3D981
	for <linux-iio@vger.kernel.org>; Wed, 20 Dec 2023 15:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FEFC433C9;
	Wed, 20 Dec 2023 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703084418;
	bh=6pUkqVknauVkcHRpqrpZ25OnM0JL3kCIXsI/VB3nNWQ=;
	h=Date:From:To:Subject:From;
	b=WVpofYce0hP90OxcdZsfAB/7jD3V+vLLKH4K4fctnC5SQ+v5SJ1DhKas+TVu1FpEL
	 SK/OgEbC+SVHmmafUxCdms5VaM2TKdccobREW028FLgJDno16X2FYTNgdibq5qla2W
	 kJ304rPwfaBP9Ak4zBU/YeJ3OSV/Ms54j3LJlmWQlbbhpDWky0jR3etHTUVM9aRaYN
	 Feag+zWpA6SA9kbynFh4n6/Sqw0plS8mmBtbzVF4Qcf2iBJTn30YO5uO4xy++lwfT8
	 9B3TLTbK3idpny42YlxZOP2xVYclL1zQ/Ofvz4o1XnmWW4988VbZPll4x/lY+bUP4F
	 kV/AP//Txr/fg==
Date: Wed, 20 Dec 2023 15:00:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: First set of new device support etc for 6.8
Message-ID: <20231220150007.200d5183@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.8a

for you to fetch changes up to 2dfef50589aef3b9a2fa2190ae95b328fb664f89:

  iio: adc: ad7091r: Align arguments to function call parenthesis (2023-12-17 14:56:45 +0000)

----------------------------------------------------------------
1st set of IIO new device support, features and cleanup for 6.8

New device support
------------------

adi,hmc425a
  * Add support for ADRF5740 attenuators.  Minor changes to driver needed
    alongside new IDs.
aosong,ags02ma
  * New driver for this volatile organic compounds sensor.
bosch,bmp280
  * Add BMP390 (small amount of refactoring + ID)
bosch,bmi323
  * New driver to support the BMI323 6-axis IMU.
honeywell,hsc030pa
  * New driver supporting a huge number of SSC and HSC series pressure and
    temperature sensors.
isil,isl76682
  * New driver for this simple Ambient Light sensor.
liteon,ltr390
  * New driver for this ambient and ultraviolet light sensor.
maxim,max34408
  * New driver to support the MAX34408 and MAX34409 current monitoring ADCs.
melexis,mlx90635
  * New driver for this Infrared contactless temperature sensor.
mirochip,mcp9600
  * New driver for this thermocouple EMF convertor.
ti,hdc3020
  * New driver for this integrated relative humidity and temperature
    sensor.
vishay,veml6075
  * New driver for this UVA and UVB light sensor.

General features
----------------

Device properties
  * Add fwnode_property_match_property_string() helper to allow matching
    single value property against an array of predefined strings.
  * Use fwnode_property_string_array_count() inside
    fwnode_property_match_string() instead of open coding the same.
checkpatch.pl
  * Add exclusion of __aligned() from a warning reducing false positives
    on IIO drivers (and hopefully beyond)

IIO Features
------------

core
  * New light channel modifiers for UVA and UVB.
  * Add IIO_CHAN_INFO_TROUGH as counterpart to IIO_CHAN_INFO_PEAK so that
    we can support device that keep running track of the lowest value they
    have seen in similar fashion to the existing peak tracking.
adi,adis library
  * Use spi cs inactive delay even when a burst reading is performed.
    As it's now used every time, can centralize the handling in the SPI
    setup code in the driver.
adi,ad2s1210
  * Support for fixed-mode to this resolver driver where the A0 and A1
    pins are hard wired to config mode in which case position and config
    must be read from appropriate config registers.
  * Support reset GPIO if present.
adi,ad5791
  * Allow configuration of presence of external amplifier in DT binding.
adi,adis16400
  * Add spi-cs-inactive-delay-ns to bindings to allow it to be tweaked
    if default delays are not quite enough for a specific board.
adi,adis16475
  * Add spi-cs-inactive-delay-ns to bindings to allow it to be tweaked
    if default delays are not quite enough for a specific board.
bosch,bmp280
  * Enable multiple chip IDs per family of devices.
rohm,bu27008
  * Add an illuminance channel calculated from RGB and IR data.

Cleanup
-------

Minor white space, typos and tidy up not explicitly called out.

Core
  * Check that the available_scan_masks array passed to the IIO core
    by a driver is sensible by ensuring the entries are ordered so the
    minimum number of channels is enabled in the earlier entries (as they
    will be selected if sufficient for the requested channels).
  * Document that the available_scan_masks infrastructure doesn't currently
    handle masks that don't fit in a long int.
  * Improve intensity documentation to reflect that there is no expectation
    of sensible units (it's dependent on a frequency sensitivity curve)
Various
  * Use new device_property_match_property_string() to replace open coded
    versions of the same thing.
  * Fix a few MAINTAINERS filenames.
  * i2c_get_match_data() and spi_get_device_match_data() pushed into
    more drivers reducing boilerplate handling.
  * Some unnecessary headers removed.
  * ACPI_PTR() removals. It's rarely worth using this.
adi,ad7091r (early part of a series adding device support - useful in
  their own right)
  * Pass iio_dev directly an event handler rather than relying
    on broken use of dev_get_drvdata() as drvdata is never set in this driver.
  * Make sure alert is turned on.
adi,ad9467 (general driver fixing up as precursor to iio-backend proposal
  which is under review for 6.9)
  * Fix reset gpio handling to match expected polarity.
  * Always handle error codes from spi_writes.
  * Add a driver instance local mutex to avoid some races.
  * Fix scale setting to align with available scale values.
  * Split array of chip_info structures up into named individual elements.
  * Convert to regmap.
honeywell,mprls0025pa
  * Drop now unnecessary type references in DT binding for properties in
    pascals.
invensense,mpu6050
  * Don't eat a potentially useful return value from regmap_bulk_write()
invensense,icm42600
  * Use max macro to improve code readability and save a few lines.
liteon,ltrf216a
  * Improve prevision of light intensity.
microchip,mcp3911
  * Use cleanup.h magic.
qcom,spmi*
  * Fix wrong descriptions of SPMI reg fields in bindings.

Other
----

mailmap
  * Update for Matt Ranostay

----------------------------------------------------------------
Amit Dhingra (1):
      MAINTAINERS: correct file entry IIO LIGHT SENSOR GAIN-TIME_SCALE HELPERS

Ana-Maria Cusco (2):
      dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator
      iio: amplifiers: hmc425a: add support for ADRF5740 Attenuator

Andrew Hepp (2):
      dt-bindings: iio: Add MCP9600 thermocouple EMF converter
      iio: temperature: Add MCP9600 thermocouple EMF converter

Andy Shevchenko (6):
      device property: Use fwnode_property_string_array_count()
      device property: Add fwnode_property_match_property_string()
      iio: frequency: adf4377: Switch to device_property_match_property_string()
      iio: frequency: admv1014: Switch to device_property_match_property_string()
      iio: magnetometer: tmag5273: Switch to device_property_match_property_string()
      iio: proximity: sx9324: Switch to device_property_match_property_string()

Angel Iglesias (4):
      iio: pressure: bmp280: Use spi_get_device_match_data()
      iio: pressure: bmp280: Rearrange vars in reverse xmas tree order
      iio: pressure: bmp280: Allow multiple chips id per family of devices
      iio: pressure: bmp280: Add support for BMP390

Anshul Dalal (5):
      dt-bindings: iio: light: add ltr390
      iio: light: driver for Lite-On ltr390
      dt-bindings: vendor-prefixes: add aosong
      dt-bindings: iio: chemical: add aosong,ags02ma
      iio: chemical: add support for Aosong AGS02MA

Biju Das (1):
      iio: pressure: bmp280: Use i2c_get_match_data()

Bragatheswaran Manickavel (1):
      iio/imu: inv_icm42600: Use max() helper macros

Colin Ian King (1):
      iio: imu: Fix spelling mistake "accelrometer" -> "accelerometer"

Crt Mori (2):
      iio: temperature: mlx90635 MLX90635 IR Temperature sensor
      dt-bindings: iio: temperature: add MLX90635 device

David Lechner (2):
      iio: resolver: ad2s1210: add support for adi,fixed-mode
      iio: resolver: ad2s1210: add reset gpio support

Ivan Mikhaylov (2):
      dt-bindings: adc: provide max34408/9 device tree binding document
      iio: adc: Add driver support for MAX34408/9

Jagath Jog J (3):
      dt-bindings: iio: imu: Add Bosch BMI323
      iio: imu: Add driver for BMI323 IMU
      iio: imu: bmi323: Make the local structures static

Javier Carrasco (5):
      iio: add modifiers for A and B ultraviolet light
      dt-bindings: iio: light: add support for Vishay VEML6075
      iio: light: add VEML6075 UVA and UVB light sensor driver
      iio: core: introduce trough info element for minimum values
      iio: ABI: document temperature and humidity peak/trough raw attributes

Jiapeng Chong (1):
      iio: light: isl76682: remove unreachable code

Johan Hovold (6):
      dt-bindings: iio/adc: qcom,spmi-iadc: fix reg description
      dt-bindings: iio/adc: qcom,spmi-iadc: fix example node name
      dt-bindings: iio/adc: qcom,spmi-iadc: clean up example
      dt-bindings: iio/adc: qcom,spmi-rradc: clean up example
      dt-bindings: iio/adc: qcom,spmi-vadc: fix example node names
      dt-bindings: iio/adc: qcom,spmi-vadc: clean up examples

Jonathan Cameron (1):
      iio: light: pa1203001: Drop ACPI_PTR() protection.

Jun Yan (1):
      iio: accel: bmi088: update comments and Kconfig

Krzysztof Kozlowski (1):
      dt-bindings: iio: honeywell,mprls0025pa: drop ref from pressure properties

Li peiyu (3):
      iio: pressure: fix some word spelling errors
      iio: humidity: Add driver for ti HDC302x humidity sensors
      dt-bindings: iio: humidity: Add TI HDC302x support

Linus Walleij (1):
      iio: proximity: irsd200: Drop unused include

Lukas Bulwahn (2):
      MAINTAINERS: correct file entry in BOSCH SENSORTEC BMI323 IMU IIO DRIVER
      MAINTAINERS: improve section MICROCHIP MCP3564 ADC DRIVER

Marcelo Schmitt (4):
      scripts: checkpatch: Add __aligned to the list of attribute notes
      iio: adc: ad7091r: Pass iio_dev to event handler
      iio: adc: ad7091r: Set alert bit in config register
      iio: adc: ad7091r: Align arguments to function call parenthesis

Marcus Folkesson (1):
      iio: adc: mcp3911: simplify code with guard macro

Marek Vasut (3):
      dt-bindings: iio: light: isl76682: Document ISL76682
      iio: light: isl76682: Add ISL76682 driver
      doc: iio: Document intensity scale as poorly defined

Matt Ranostay (1):
      mailmap: Change email mapping from previous employers

Matti Vaittinen (3):
      iio: bu27008: Add illuminance channel
      iio: sanity check available_scan_masks array
      iio: buffer: document known issue

Michael Hennerich (2):
      dt-bindings: adi,ad5791: Add support for controlling RBUF
      iio: dac: ad5791: Add support for controlling RBUF via devicetree

Nuno Sa (8):
      iio: adc: ad9467: fix reset gpio handling
      iio: adc: ad9467: don't ignore error codes
      iio: adc: ad9467: add mutex to struct ad9467_state
      iio: adc: ad9467: fix scale setting
      iio: adc: ad9467: use spi_get_device_match_data()
      iio: adc: ad9467: use chip_info variables instead of array
      iio: adc: ad9467: use the more common !val NULL check
      iio: adc: adi-axi-adc: convert to regmap

Petre Rodan (2):
      dt-bindings: iio: pressure: add honeywell,hsc030
      iio: pressure: driver for Honeywell HSC/SSC series

Ramona Gradinariu (3):
      iio: imu: adis: Use spi cs inactive delay
      dt-bindings: adis16475: Add 'spi-cs-inactive-delay-ns' property
      dt-bindings: adis16460: Add 'spi-cs-inactive-delay-ns' property

Rob Herring (1):
      dt-bindings: iio/adc: ti,palmas-gpadc: Drop incomplete example

Shreeya Patel (1):
      iio: light: ltrf216a: Return floating point values

Su Hui (1):
      iio: imu: inv_mpu6050: return callee's error code rather than -EINVAL

 .mailmap                                           |    7 +-
 Documentation/ABI/testing/sysfs-bus-iio            |   42 +-
 .../bindings/iio/adc/maxim,max34408.yaml           |  139 ++
 .../bindings/iio/adc/qcom,spmi-iadc.yaml           |   10 +-
 .../bindings/iio/adc/qcom,spmi-rradc.yaml          |    4 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |    9 +-
 .../bindings/iio/adc/ti,palmas-gpadc.yaml          |   15 -
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |    4 +
 .../bindings/iio/chemical/aosong,ags02ma.yaml      |   47 +
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |    5 +
 .../bindings/iio/humidity/ti,hdc3020.yaml          |   55 +
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |    4 +
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |    4 +
 .../devicetree/bindings/iio/imu/bosch,bmi323.yaml  |   77 +
 .../bindings/iio/light/liteon,ltr390.yaml          |   56 +
 .../bindings/iio/light/vishay,veml6075.yaml        |   39 +
 .../bindings/iio/pressure/honeywell,hsc030pa.yaml  |  142 ++
 .../iio/pressure/honeywell,mprls0025pa.yaml        |    2 -
 .../bindings/iio/temperature/melexis,mlx90632.yaml |   19 +-
 .../iio/temperature/microchip,mcp9600.yaml         |   70 +
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |   56 +-
 drivers/base/property.c                            |   37 +-
 drivers/iio/accel/Kconfig                          |    7 +-
 drivers/iio/accel/bmi088-accel-core.c              |    2 +
 drivers/iio/accel/bmi088-accel-spi.c               |    2 +
 drivers/iio/adc/Kconfig                            |   13 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7091r-base.c                     |   15 +-
 drivers/iio/adc/ad9467.c                           |  207 +-
 drivers/iio/adc/adi-axi-adc.c                      |  159 +-
 drivers/iio/adc/max34408.c                         |  276 +++
 drivers/iio/adc/mcp3911.c                          |   64 +-
 drivers/iio/amplifiers/hmc425a.c                   |   23 +
 drivers/iio/chemical/Kconfig                       |   11 +
 drivers/iio/chemical/Makefile                      |    1 +
 drivers/iio/chemical/ags02ma.c                     |  165 ++
 drivers/iio/dac/ad5791.c                           |    9 +-
 drivers/iio/frequency/adf4377.c                    |   16 +-
 drivers/iio/frequency/admv1014.c                   |   31 +-
 drivers/iio/humidity/hdc3020.c                     |  473 +++++
 drivers/iio/imu/Kconfig                            |    1 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/adis.c                             |   18 +-
 drivers/iio/imu/bmi323/Kconfig                     |   33 +
 drivers/iio/imu/bmi323/Makefile                    |    7 +
 drivers/iio/imu/bmi323/bmi323.h                    |  209 ++
 drivers/iio/imu/bmi323/bmi323_core.c               | 2139 ++++++++++++++++++++
 drivers/iio/imu/bmi323/bmi323_i2c.c                |  121 ++
 drivers/iio/imu/bmi323/bmi323_spi.c                |   92 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |    5 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |    5 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |    5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    9 +-
 drivers/iio/industrialio-buffer.c                  |   16 +
 drivers/iio/industrialio-core.c                    |   66 +
 drivers/iio/light/Kconfig                          |   37 +
 drivers/iio/light/Makefile                         |    3 +
 drivers/iio/light/isl76682.c                       |  345 ++++
 drivers/iio/light/ltr390.c                         |  196 ++
 drivers/iio/light/ltrf216a.c                       |   10 +-
 drivers/iio/light/pa12203001.c                     |    2 +-
 drivers/iio/light/rohm-bu27008.c                   |  201 +-
 drivers/iio/light/veml6075.c                       |  474 +++++
 drivers/iio/magnetometer/tmag5273.c                |   10 +-
 drivers/iio/pressure/Kconfig                       |   22 +
 drivers/iio/pressure/Makefile                      |    3 +
 drivers/iio/pressure/bmp280-core.c                 |   42 +-
 drivers/iio/pressure/bmp280-i2c.c                  |    8 +-
 drivers/iio/pressure/bmp280-spi.c                  |   10 +-
 drivers/iio/pressure/bmp280.h                      |    6 +-
 drivers/iio/pressure/hsc030pa.c                    |  494 +++++
 drivers/iio/pressure/hsc030pa.h                    |   74 +
 drivers/iio/pressure/hsc030pa_i2c.c                |   69 +
 drivers/iio/pressure/hsc030pa_spi.c                |   61 +
 drivers/iio/proximity/irsd200.c                    |    1 -
 drivers/iio/proximity/sx9324.c                     |   24 +-
 drivers/iio/resolver/ad2s1210.c                    |  162 +-
 drivers/iio/temperature/Kconfig                    |   22 +
 drivers/iio/temperature/Makefile                   |    2 +
 drivers/iio/temperature/mcp9600.c                  |  139 ++
 drivers/iio/temperature/mlx90635.c                 | 1097 ++++++++++
 include/linux/iio/adc/adi-axi-adc.h                |    4 +
 include/linux/iio/types.h                          |    1 +
 include/linux/property.h                           |   12 +
 include/uapi/linux/iio/types.h                     |    2 +
 scripts/checkpatch.pl                              |    1 +
 tools/iio/iio_event_monitor.c                      |    2 +
 89 files changed, 8176 insertions(+), 409 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
 create mode 100644 drivers/iio/adc/max34408.c
 create mode 100644 drivers/iio/chemical/ags02ma.c
 create mode 100644 drivers/iio/humidity/hdc3020.c
 create mode 100644 drivers/iio/imu/bmi323/Kconfig
 create mode 100644 drivers/iio/imu/bmi323/Makefile
 create mode 100644 drivers/iio/imu/bmi323/bmi323.h
 create mode 100644 drivers/iio/imu/bmi323/bmi323_core.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_i2c.c
 create mode 100644 drivers/iio/imu/bmi323/bmi323_spi.c
 create mode 100644 drivers/iio/light/isl76682.c
 create mode 100644 drivers/iio/light/ltr390.c
 create mode 100644 drivers/iio/light/veml6075.c
 create mode 100644 drivers/iio/pressure/hsc030pa.c
 create mode 100644 drivers/iio/pressure/hsc030pa.h
 create mode 100644 drivers/iio/pressure/hsc030pa_i2c.c
 create mode 100644 drivers/iio/pressure/hsc030pa_spi.c
 create mode 100644 drivers/iio/temperature/mcp9600.c
 create mode 100644 drivers/iio/temperature/mlx90635.c

