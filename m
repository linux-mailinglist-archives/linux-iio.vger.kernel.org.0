Return-Path: <linux-iio+bounces-4474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC398AF66C
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D5B1C22A1C
	for <lists+linux-iio@lfdr.de>; Tue, 23 Apr 2024 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0A13E3FE;
	Tue, 23 Apr 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uELqo4rx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853F13E3EB
	for <linux-iio@vger.kernel.org>; Tue, 23 Apr 2024 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896474; cv=none; b=NOQgDpA4aQma2vMi/H8pp4nkoF2E+/Jjwkrl12IyeXynkHjJDgiN+ncWiQEcJ7FSZkqcuGkXXoqer/YSFyORtgfim5aP2JTMgsbZgCnbtB8cAZrusVjjWFbGNvyC6B9nhgGRiH6FOqqjqtbUbo3YsN6rDRh1advV2GQbUmVMRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896474; c=relaxed/simple;
	bh=ibZyPErUAIfjwbt1CXCfGltIP5BxIq4OQEymVNRTKZ0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=GZ3NcK9Prhi6mcUb8pCDlR2ZaOhv/8po41ncrdgUGbMuSXX59bumh1Y+GlofsWZMNmb48W6yXcIj8ke7j129KvW1XHsCHp73+bc6OkGIMi/QL8rozJgVjIHRCFpNqCRc1YW0UoYKLNBiXbxLao+sGdCqHeavJHDedP8/9ySwUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uELqo4rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14B1C116B1;
	Tue, 23 Apr 2024 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713896474;
	bh=ibZyPErUAIfjwbt1CXCfGltIP5BxIq4OQEymVNRTKZ0=;
	h=Date:From:To:Subject:From;
	b=uELqo4rxD3BbZuTh+wqxIBnLR9XAp/nL/wNmaXy26/iFPkEE1gtuH9Q+wKKRQIfYN
	 dPARfB50W4ae56q/HrHbnSqJ+lrMy9utraE0zC+xrhVgEnV/pGspm4TxCVtjkppHe0
	 v6BZU7sVt0S1l7IBwoRrmvQlB370Iae+oF/FAANwPyFBzbFF4Z3OteJPilfy2f3Kan
	 b0O61OOzfibgcDK7RZ8bHBxn8wJV/UXu7vNclDc2Tf2TX7deBRit7ZK/oNlwmSWbTA
	 N8n3OkOZ9FPxFURqYMVcAM6wiUWCXVoH5WhLDl45pzASJ7eEpmyaWsUnjkG/u0fzxL
	 hwPb7wOOj2+CA==
Date: Tue, 23 Apr 2024 19:21:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of new device support, features and cleanup for
 6.10
Message-ID: <20240423192104.385c59d6@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.10a

for you to fetch changes up to b80ad8e3cd2712b78b98804d1f59199680d8ed91:

  iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped() to simplify error paths. (2024-04-21 18:42:33 +0100)

----------------------------------------------------------------
IIO: 1st set of new device support, features and cleanup for 6.10

The Analog Device team (Paul Cercueil and Nuno Sa) have been working on
improving high speed device handling. They have had some support in their
own tree for many years, so it is great to see them bring it to upstream.
Some of that is seen here, with the first output device using the
IIO dmaengine infrastructure and a new DAC backend FPGA IP driver.
This makes use of a new set of interfaces to allow backend and
front end driver communication in a fashion that in theory at least
allows for a single driver for a given ADC / DAC independent of
the IP to which is being used to deal with the data bus and DMA aspects
of working with these devices. It is early days for this new
generic way of handling split devices, but as it's kernel internals only
we can merrily change anything about it as a wider diversity of devices
show up and we get a better feel for what works.

Alongside the usual set of new drivers and features we have
the automatic cleanup of fwnode_handle_put() which didn't quite make
it in last cycle. The equivalent DT version was merged by Rob Herring
via the DT binding tree and one patch using that in IIO can also be
found in this pull request. Rob has been making extensive use of that
infrastructure in the DT core which is good to see and provides more
evidence this basic approach is useful.

In some cases, the IIO driver was converted over from DT only to
using the generic firmware description handling of property.h
including using the new macros. The general preference for IIO
is to use this more generic handling where possible - a bunch of other
drivers have been converted this cycle as well.

New device support
==================

adi,ad7173
- New driver supporting AD7172-2, AD7172-4 AD7173-9, AD7175-2, AD7175-8,
  AD7176-2 and AD7177-2 ADCs.
- Follow up fix for an accidental use of logic not instead of bitwise.

adi,ad7944
- New driver supporting AD7944, AD7985 and AD7986 pin compatible ADCs.
- Later patch added use of new spi_optimize_message() to reduce overheads
  of setting up a reused message.
- Additional changes later in series reduced code duplication.

adi,ad9739a RF DAC
- New driver for this 14-bit 2.5 GSPS DAC via an LVDS interface.

adi,axi-dac
- Support for this FPGA IP used to send data to high performance DACs over
  an interface such as JESD204B/C or parallel interfaces.  Used in
  conjunction with a DAC driver. The initial user is the ad9739a.
  The dmaengine-buffer needed various changes to make it bidirectional.

avago,apds9306
- New driver for this ambient light sensor.
- Fix much later in this pull for an off by 1 error.

New device IDs
==============

For these at most an ID and a instance of chip specific data was needed.
Always nice to see manufacturers sticking to an existing software interface
for new parts.

allwinner,sun20i
- Add support for h616.
invensense,mpu6050
- Add support for ICM42688
maxim,max30102
- Add compatible for MAX30101
ti,dac5571
- Add compatible for DAC081C081

General
=======

fwnode_handle
- Support for cleanup.h based __free(fwnode_handle)
- Loop macro using this for looping over child nodes without needing to
  call fwnode_handle_put() in ever early exit from the loop.
- Used in:
  * adi,ad3552r
  * adi,ad4130
  * adi,ad5770r
  * adi,ad74413r
  * adi,ad7173
  * adi,adfm2000
  * linear,ltc2688
  * linear,ltc2983
  * maxim,max11410
  * microchip,pac1934
  * qcom,spmi-adc
  * renesas,rz2gl
  * st,ab8500
  * st,stm32 (Fix for failure to set return value precedes this patch,
    providing an example of why enabling direct returns makes bugs
    less likely)
- Conversions to fwnode also using the cleanup logic
  * adi,ad7124
  * adi,ad7292
  * freescale,fsl-imx25-gcq

- Other conversions to fwnode where the new cleanup handling isn't useful
  * adi,ad7192
  * avia,hx711
  * freescale,mma8452
  * nxp,fxls8962af
  * st,spear
  * ti,twl4030

Features
========

adi,adxl345
- Support SPI_3WIRE mode.

adi,ad9944
- Support 3-wire mode, note this isn't normal 3-wire SPI (unlike the
  adxl345 change above), but rather   a wiring scheme where the SPI
  chip select is used to trigger conversions rather than using a
  separate pin.
- Add some device specific documentation, mostly around the various wiring
  schemes.

invensense,mpu6050
- Add Wake on Motion support as an IIO event and as a wake-up source.

linear,ltc2983
- Add vdd-supply.

ti,hdc3020
- Add power management using trigger on demand mode and adding suspend and
  resume handling.
- Use reset GPIO if available.

Cleanup and fixes
================

iio core
- Use the various autocleanup and lock guards from cleanup.h to simplify
  the IIO core.
- Don't set the pointer used for iio_priv() if it is zero sized as that
  points beyond the end of the allocation. No driver actually uses it
  in that case but good to clean this up.

various drivers
- Drop unnecessary casts of other pointer types to void *

docs
- Add missing ABI entry for in_temp_input.

adi,adx345
- General cleanup prior to adding spi-3wire mode.

adi,axi-adc
- Be more flexible and allow minor version changes as these are expected
  to be backwards compatible.

avago,apds9300/9600
- Merge near identical bindings. The drivers are quite different, but
  the bindings can be shared. The apds9306 binding introduced in this
  series uses this shared binding doc as well.
- Add missing vdd-supply
- Update binding to use IRQ_TYPE_LEVEL_LOW instead of 8.

bosch,bmp280
- Organize headers

freescale,fxl-imx25-gcq
- Use devm_ for remaining probe() time setup allowing dropping
  of specific error handling and remove() functions.

infineon,dps310
- Fix handling of negative temperatures
- Bring style of other similar calls inline with the form needed
  for temperatures
- Ensure error handling of regmap calls is consistent within the driver.
- Simplify scale reading logic.

invensense,mpu6050
- Flip logic in binding to exclude devices without i2c-gate instead
  of opting in.  The list is expected to be much shorter as all recent
  devices support this feature.

honeywell,hsc030pa
- Use spi_read() instead of opening coding.

renesas,rcar
- Use device_for_each_child_of_node_scoped() to remove need to manually
  release. Left over from series the rest of which went in during 6.9.

st,ab8500
- Fix naming of function parameters in kernel-doc

----------------------------------------------------------------
Andy Shevchenko (4):
      iio: adc: spear_adc: Make use of device properties
      iio: core: Leave private pointer NULL when no private data supplied
      iio: core: Calculate alloc_size only once in iio_device_alloc()
      iio: adc: twl4030-madc: Make use of device properties

Chris Morgan (1):
      dt-bindings: iio: adc: Add GPADC for Allwinner H616

Christophe JAILLET (1):
      iio: pressure: hsc030pa: Use spi_read()

Colin Ian King (1):
      iio: accel: adxl367: Remove second semicolon

Dan Carpenter (2):
      iio: light: apds9306: Fix off by one in apds9306_sampling_freq_get()
      iio: adc: ad7173: Fix ! vs ~ typo in ad7173_sel_clk()

David Lechner (8):
      dt-bindings: iio: adc: add ad7944 ADCs
      iio: adc: ad7944: add driver for AD7944/AD7985/AD7986
      iio: adc: ad7944: Add support for "3-wire mode"
      MAINTAINERS: add Documentation/iio/ to IIO subsystem
      docs: iio: new docs for ad7944 driver
      iio: adc: ad7944: simplify adi,spi-mode property parsing
      iio: adc: ad7944: use spi_optimize_message()
      iio: adc: ad7944: Consolidate spi_sync() wrapper

Dumitru Ceclan (6):
      dt-bindings: adc: add AD7173
      iio: adc: ad_sigma_delta: Add optional irq selection
      iio: adc: ad7173: add AD7173 driver
      dt-bindings: adc: ad7173: add support for additional models
      iio: adc: ad7173: improve chip id's defines
      iio: adc: ad7173: add support for additional models

Javier Carrasco (8):
      io: light: st_uvis25: drop casting to void in dev_set_drvdata
      iio: humidity: hts211: drop casting to void in dev_set_drvdata
      iio: imu: st_lsm6dsx: drop casting to void in dev_set_drvdata
      iio: humidity: hdc3020: add power management
      dt-bindings: iio: humidity: hdc3020: add reset-gpios
      iio: humidity: hdc3020: add reset management
      dt-bindings: iio: health: maxim,max30102: add max30101
      iio: health: max30102: add support for max30101

Jean-Baptiste Maneyrol (6):
      iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
      iio: imu: inv_mpu6050: add WoM event as accel event
      iio: imu: inv_mpu6050: add new interrupt handler for WoM events
      iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode
      dt-bindings: iio: imu: add icm42688 inside inv_icm42600
      iio: imu: inv_icm42600: add support of ICM-42688-P

Jonathan Cameron (29):
      device property: Move fwnode_handle_put() into property.h
      device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
      device property: Introduce device_for_each_child_node_scoped()
      iio: adc: max11410: Use device_for_each_child_node_scoped()
      iio: addac: ad74413r: Use device_for_each_child_node_scoped()
      iio: dac: ltc2688: Use device_for_each_child_node_scoped()
      iio: adc: fsl-imx25-gcq: Switch from of specific handing to fwnode based.
      iio: adc: fsl-imx25-gcq: Use devm_* and dev_err_probe() to simplify probe
      iio: adc: ad7124: Switch from of specific to fwnode based property handling
      iio: adc: ad7292: Switch from of specific to fwnode property handling
      iio: adc: ad7192: Convert from of specific to fwnode property handling
      iio: accel: mma8452: Switch from of specific to fwnode property handling.
      iio: accel: fxls8962af: Switch from of specific to fwnode based properties.
      iio: adc: hx711: Switch from of specific to fwnode property handling.
      iio: temp: ltc2983: Use __free(fwnode_handle) and device_for_each_node_scoped()
      iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()
      iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()
      iio: dac: ad3552r: Use device_for_each_child_node_scoped()
      iio: dac: ad5770r: Use device_for_each_child_node_scoped()
      iio: adc: ab8500-gpadc: Fix kernel-doc parameter names.
      iio: adc: ab8500-gpadc: Use device_for_each_child_node_scoped() to simplify erorr paths.
      iio: adc: ad4130: Use device_for_each_child_node_scoped() to simplify error paths.
      iio: adc: ad7173: Use device_for_each_child_node_scoped() to simplify error paths.
      iio: frequency: admfm2000: Use device_for_each_child_node_scoped() to simplify error paths.
      iio: dac: ad3552: Use __free(fwnode_handle) to simplify error handling.
      iio: adc: pac1934: Use device_for_each_available_child_node_scoped() to simplify error handling.
      iio: adc: stm32: Fixing err code to not indicate success
      iio: adc: stm32: Use device_for_each_child_node_scoped()
      iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scoped()

Krzysztof Kozlowski (1):
      iio: dac: ad5755: make use of of_device_id table

Laurent Pinchart (2):
      dt-bindings: iio: dac: ti,dac5571: Add DAC081C081 support
      iio: dac: ti-dac5571: Add DAC081C081 support

Lorenzo Bertin Salvador (1):
      iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped() to simplify error paths.

Lothar Rubusch (8):
      iio: accel: adxl345: Make data_range obsolete
      iio: accel: adxl345: Group bus configuration
      iio: accel: adxl345: Move defines to header
      dt-bindings: iio: accel: adxl345: Add spi-3wire
      iio: accel: adxl345: Pass function pointer to core
      iio: accel: adxl345: Reorder probe initialization
      iio: accel: adxl345: Add comment to probe
      iio: accel: adxl345: Add spi-3wire option

Luca Weiss (2):
      Documentation: ABI: document in_temp_input file
      dt-bindings: iio: imu: mpu6050: Improve i2c-gate disallow list

Nuno Sa (13):
      iio: core: move to cleanup.h magic
      iio: trigger: move to the cleanup.h magic
      iio: buffer: iio: core: move to the cleanup.h magic
      iio: inkern: move to the cleanup.h magic
      dt-bindings: iio: temperature: ltc2983: document power supply
      iio: temperature: ltc2983: support vdd regulator
      iio: buffer-dma: add iio_dmaengine_buffer_setup()
      dt-bindings: iio: dac: add docs for AXI DAC IP
      dt-bindings: iio: dac: add docs for AD9739A
      iio: backend: add new functionality
      iio: dac: add support for AXI DAC IP core
      iio: dac: support the ad9739a RF DAC
      iio: adc: adi-axi-adc: only error out in major version mismatch

Paul Cercueil (4):
      iio: buffer-dma: Rename iio_dma_buffer_data_available()
      iio: buffer-dma: Enable buffer write support
      iio: buffer-dmaengine: Support specifying buffer direction
      iio: buffer-dmaengine: Enable write support

Subhajit Ghosh (6):
      dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas
      dt-bindings: iio: light: adps9300: Add missing vdd-supply
      dt-bindings: iio: light: adps9300: Update interrupt definitions
      dt-bindings: iio: light: Avago APDS9306
      iio: light: Add support for APDS9306 Light Sensor
      iio: light: apds9306: Improve apds9306_write_event_config()

Thomas Haemmerle (4):
      iio: pressure: dps310: support negative temperature values
      iio: pressure: dps310: introduce consistent error handling
      iio: pressure: dps310: consistently check return value of `regmap_read`
      iio: pressure: dps310: simplify scale factor reading

Vasileios Amoiridis (1):
      iio: pressure: BMP280 core driver headers sorting

 Documentation/ABI/testing/sysfs-bus-iio            |    3 +-
 Documentation/ABI/testing/sysfs-bus-iio-ad9739a    |   19 +
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |    2 +
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |  279 ++++
 .../devicetree/bindings/iio/adc/adi,ad7944.yaml    |  213 +++
 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   |   95 ++
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |   62 +
 .../devicetree/bindings/iio/dac/ti,dac5571.yaml    |    1 +
 .../bindings/iio/health/maxim,max30102.yaml        |   12 +-
 .../bindings/iio/humidity/ti,hdc3020.yaml          |    5 +
 .../bindings/iio/imu/invensense,icm42600.yaml      |    1 +
 .../bindings/iio/imu/invensense,mpu6050.yaml       |   17 +-
 .../bindings/iio/light/avago,apds9300.yaml         |   20 +-
 .../bindings/iio/light/avago,apds9960.yaml         |   44 -
 .../bindings/iio/temperature/adi,ltc2983.yaml      |    4 +
 Documentation/iio/ad7944.rst                       |  130 ++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   28 +
 drivers/base/property.c                            |   14 -
 drivers/iio/accel/adxl345.h                        |   36 +-
 drivers/iio/accel/adxl345_core.c                   |   92 +-
 drivers/iio/accel/adxl345_i2c.c                    |    2 +-
 drivers/iio/accel/adxl345_spi.c                    |   10 +-
 drivers/iio/accel/adxl367.c                        |    2 +-
 drivers/iio/accel/fxls8962af-core.c                |   10 +-
 drivers/iio/accel/mma8452.c                        |    6 +-
 drivers/iio/adc/Kconfig                            |   27 +
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ab8500-gpadc.c                     |    8 +-
 drivers/iio/adc/ad4130.c                           |    7 +-
 drivers/iio/adc/ad7124.c                           |   55 +-
 drivers/iio/adc/ad7173.c                           | 1180 +++++++++++++++++
 drivers/iio/adc/ad7192.c                           |   38 +-
 drivers/iio/adc/ad7292.c                           |   13 +-
 drivers/iio/adc/ad7944.c                           |  524 ++++++++
 drivers/iio/adc/ad_sigma_delta.c                   |   23 +-
 drivers/iio/adc/adi-axi-adc.c                      |   20 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |  140 +-
 drivers/iio/adc/hx711.c                            |    5 +-
 drivers/iio/adc/max11410.c                         |   27 +-
 drivers/iio/adc/pac1934.c                          |   77 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |    7 +-
 drivers/iio/adc/rcar-gyroadc.c                     |   21 +-
 drivers/iio/adc/rzg2l_adc.c                        |   11 +-
 drivers/iio/adc/spear_adc.c                        |   25 +-
 drivers/iio/adc/stm32-adc.c                        |   61 +-
 drivers/iio/adc/ti-ads131e08.c                     |   12 +-
 drivers/iio/adc/twl4030-madc.c                     |   19 +-
 drivers/iio/addac/ad74413r.c                       |   10 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |  100 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   86 +-
 drivers/iio/dac/Kconfig                            |   37 +
 drivers/iio/dac/Makefile                           |    2 +
 drivers/iio/dac/ad3552r.c                          |  110 +-
 drivers/iio/dac/ad5755.c                           |   24 +-
 drivers/iio/dac/ad5770r.c                          |   19 +-
 drivers/iio/dac/ad9739a.c                          |  463 +++++++
 drivers/iio/dac/adi-axi-dac.c                      |  635 +++++++++
 drivers/iio/dac/ltc2688.c                          |   28 +-
 drivers/iio/dac/ti-dac5571.c                       |    3 +
 drivers/iio/frequency/admfm2000.c                  |   24 +-
 drivers/iio/health/max30102.c                      |    2 +
 drivers/iio/humidity/hdc3020.c                     |  111 +-
 drivers/iio/humidity/hts221_core.c                 |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |    2 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |    5 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    3 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |    3 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  542 +++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   36 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   17 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   83 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    2 +-
 drivers/iio/industrialio-backend.c                 |  179 +++
 drivers/iio/industrialio-buffer.c                  |  120 +-
 drivers/iio/industrialio-core.c                    |   49 +-
 drivers/iio/industrialio-trigger.c                 |   71 +-
 drivers/iio/inkern.c                               |  263 ++--
 drivers/iio/light/Kconfig                          |   12 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/apds9306.c                       | 1361 ++++++++++++++++++++
 drivers/iio/light/st_uvis25_core.c                 |    2 +-
 drivers/iio/pressure/bmp280-core.c                 |   16 +-
 drivers/iio/pressure/dps310.c                      |  138 +-
 drivers/iio/pressure/hsc030pa_spi.c                |    7 +-
 drivers/iio/temperature/ltc2983.c                  |  142 +-
 include/linux/iio/adc/ad_sigma_delta.h             |    3 +
 include/linux/iio/backend.h                        |   49 +
 include/linux/iio/buffer-dma.h                     |    4 +-
 include/linux/iio/buffer-dmaengine.h               |   24 +-
 include/linux/property.h                           |   22 +-
 92 files changed, 6964 insertions(+), 1267 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad9739a
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
 create mode 100644 Documentation/iio/ad7944.rst
 create mode 100644 drivers/iio/adc/ad7173.c
 create mode 100644 drivers/iio/adc/ad7944.c
 create mode 100644 drivers/iio/dac/ad9739a.c
 create mode 100644 drivers/iio/dac/adi-axi-dac.c
 create mode 100644 drivers/iio/light/apds9306.c

