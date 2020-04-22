Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512F81B4E5C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 22:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDVUbv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 16:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVUbu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Apr 2020 16:31:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4219720857;
        Wed, 22 Apr 2020 20:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587587509;
        bh=ELT7Sm1QLkTd+iAqGWAgqJwtPXELHEv/nf2mufAfaqo=;
        h=Date:From:To:Subject:From;
        b=OLqefCFb+d/SQykc7mdR2Eh+4DJGz8y66RLt9DiiCc2TQH19Q1QuSCsIy2btBjtIc
         7ZZR+h8+G2R/YTI1okLeujglZyfqX/BeNIdwn+K8/EufT8Faqu7djluTvoRWQM8nqT
         wvRQm0ro6vJl68PzXJgIroQGktVjsmUt/vIRkbKM=
Date:   Wed, 22 Apr 2020 21:31:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO new device support, cleanups etc for the
 5.8 cycle
Message-ID: <20200422213145.6b0f8c9d@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 825c6f470c62da05195fab57bb6561ccc1bdafcd:

  staging: mt7621-pci: be sure gpio descriptor is null on fails (2020-03-20=
 15:10:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.8a

for you to fetch changes up to 2de8c02349f02d014e51b43f306d28fc7a23ea6e:

  iio: magnetometer: ak8974: Silence deferred-probe error (2020-04-19 16:56=
:43 +0100)

----------------------------------------------------------------
First set of new IIO device support, features and cleanup for the 5.8 cycle

Usual mix of new drivers, new support in old drivers and lots of minor
cleanup. Yaml conversions also continue to trickle in (plenty more to go!)

New device support
* ad7476
  - Add ad7091 support (ID only)
* ad9467
  - New driver for this 200/250 MSPS adi-axi-adc and SPI attached ADC.
* adi-axi-adc
  - New driver to support ADIs generic AXI ADC IP core, used to provide
    high speed interfaces to ADCs (JESD204B/C or parallel interfaces). Usua=
lly
    paired with a device using a slow configuration interface (spi etc)
    Includes DT bindings and some fixes for fpga headers.
* bmg160
  - Add support for BMI088 (ID only)
* max1241
  - New driver for this ADC.
* st_sensors
  - Add support for LIS2HH12 accelerometer
* sx9310
  - New driver supporting sx9310 and sx9311 proximity sensors.

Yaml DT binding conversions
* rockchip-saradc (including adding some missing parts)
* stm32-dac
* tsl2563
* vcnl4000

Features
* st_lsm6dsx
  - Add LIS3MDL as a possible sensor hub device.
* vcnl4000
  - Add new concept of near level (from DT) to provide to userspace which
    often needs to have some calibrated concept of 'near'.

Cleanups, minor fixes etc.
* core
  - Use snprintf for functions where strings are built and there is
    potential for overflow.
  - Correct docs to indicate mlock should not be used directly by drivers.
  - Fix up accidental dropping of a patch to use bitmap_zalloc.
  - Stop allowing enabling of buffers with no channels enabled.
  - Drop unused 'stufftoread' from iio_buffer.
  - Drop scan_el_attrs form iio_buffer as unused.
  - Reorder sanity checks in __iio_device_register to fail earlier.
  - Drop all the devm_ runregister / free functions from IIO as they
    were never used and encourage poor design.
* dma-buffer
  - Tidy up includes.
* dma-engine-buffer
  - Provide dev-managed allocator.
  - Fix an issue with printing a size_t
* cross subsystem (kxsd9, bmg160, mpu3050, bmi160, mpu6050, bmc150)
  - Replace some unnecessary casts of error ptrs and whilst there.
    use the %pe printf parameter to print them in a more useful fashion.
* cross subsystem
  - Drop casts in calls to regmap_bulk_read as they make no sense.
  - Use devm_platform_ioremap_resource to reduce boilerplate.
  - Fix typos in Analog Devices.
* counters/104-quad
  - Add Syed Nayyar Waris as an additional maintainer.
* ad7476
  - Generate CONVST signal internally rather than requiring external
    trigger.  Add sysfs read back as can now do so.
  - use devm_add_action_or_reset to tidy up error and remove handling.
* ad7793
  - Switch to read_avail from explicit attribute. Mostly done to avoid
    confusing people with a - sign (without surounding spaces) that
    was correct but checkpatch didn't like.
* adis library
  - Add missing newlines at end of error messages.
* adis16400
  - Use DEFINE_DEBUGS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTR.
* adis16460
  - Use DEFINE_DEBUGS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTR.
* ad_sigma_delta
  - Move some channel definitions into individual drivers to avoid
    having to deal with complex options.
* ak8974
  - Silence an error on deffered probe.
* bmp280
  - Harden against IRQ before registration.
  - Convert to read_avail instead of opencoding the equivalent.
  - Explicitly mark GPIO as optional.
  - Cleanup casts.
  - Remove line breaks from strings.
* htts221
  - Replace direct access to platform_data with dev_get_platdata().
  - Use device properties rather than device tree ones to allow ACPI
    probing.
  - Casting cleanups.
* intel_mrfld_adc
  - Don't use unaligned accessor for aligned data.
* isl29125
  - Reorder buer pre and post hooks to allow for coming core rework.
* ltc2983
  - Remove comp to bool.
* max1363
  - Stop using mlock from the iio_dev directly in favour of a local lock
    with clearly defined scope.
* max30100
  - Use generic device properties to allow ACPI probe.
* mpu6050
  - Convert to i2c_new_client_device.
  - Add debugfs register access.
* st_lsm6dsx
  - Provide means of configuring full scale on slave device if supported.
  - Drop include of st_sensors header to get one value. Its not otherwise
    used by this driver.
* st-sensors
  - Replace direct access to platform_data with dev_get_platdata().
  - Casting cleanups.
  - Avoid splitting strings.
* st_uvis25
  - Casting cleanups.
* tsl2563
  - Typo fix.
* tsl2772
  - scnprintf in a non obvious string building usecase. Note also 'fixes'
    a wrong calculation of remaining space that couldn't actually cause
    any trouble as there was lots of room.
* xilinx-xadc
  - Fix Lars-Peter spelling his own name wrong :) + additional typos.

----------------------------------------------------------------
Aishwarya Ramakrishnan (3):
      iio: adc: sun4i-gpadc-iio: Use devm_platform_ioremap_resource
      iio: adc: at91-adc: Use devm_platform_ioremap_resource
      iio: adc: fsl-imx25-gcq: Use devm_platform_ioremap_resource

Alexandru Ardelean (24):
      iio: adc: ad7780: define/use own IIO channel macros
      iio: adc: ad7791: define/use own IIO channel macros
      iio: adc: ad7793: define/use own IIO channel macros
      iio: ad_sigma_delta: remove unused IIO channel macros
      iio: buffer: re-introduce bitmap_zalloc() for trialmask
      iio: adc: ad7793: use read_avail iio hook for scale available
      iio: buffer: drop left-over 'stufftoread' field
      include: fpga: adi-axi-common.h: fixup whitespace tab -> space
      include: fpga: adi-axi-common.h: add version helper macros
      iio: buffer-dmaengine: use %zu specifier for sprintf(align)
      iio: buffer-dmaengine: add dev-managed calls for buffer alloc
      dt-bindings: iio: adc: add bindings doc for AXI ADC driver
      dt-bindings: iio: adc: add bindings doc for AD9467 ADC
      iio: buffer: remove 'scan_el_attrs' attribute group from buffer struct
      iio: move 'indio_dev->info' null check first in __iio_device_register=
()
      iio: core: drop devm_iio_device_unregister() API call
      iio: core: drop devm_iio_triggered_buffer_cleanup() API call
      iio: core: drop devm_iio_device_free() API call
      iio: core: drop devm_iio_trigger_unregister() API call
      iio: core: drop devm_iio_trigger_free() API call
      iio: inkern: drop devm_iio_channel_release{_all} API calls
      iio: buffer: drop devm_iio_hw_consumer_free() API call
      iio: buffer: drop devm_iio_kfifo_free() API call
      iio: light: isl29125: fix iio_triggered_buffer_{predisable,postenable=
} positions

Alexandru Lazar (2):
      dt-bindings: iio: adc: Add MAX1241 bindings
      iio: adc: Add MAX1241 driver

Andy Shevchenko (14):
      iio: light: st_uvis25: Drop unneeded casting when print error code
      iio: st_sensors: Use dev_get_platdata() to get platform_data
      iio: st_sensors: Drop unneeded explicit castings
      iio: st_sensors: Drop unneeded casting when print error code
      iio: st_sensors: Join string literals back
      iio: humidity: hts221: Use dev_get_platdata() to get platform_data
      iio: humidity: hts221: Make use of device properties
      iio: humidity: hts221: Drop unneeded casting when print error code
      iio: adc: intel_mrfld_adc: Use be16_to_cpu() instead of get_unaligned=
_be16()
      iio: pressure: bmp280: Tolerate IRQ before registering
      iio: pressure: bmp280: Convert to use ->read_avail()
      iio: pressure: bmp280: Explicitly mark GPIO optional
      iio: pressure: bmp280: Drop unneeded explicit castings
      iio: pressure: bmp280: Join string literals back

Beniamin Bia (1):
      iio: adc: ad7476: implement devm_add_action_or_reset

Christophe JAILLET (1):
      iio: imu: adis: Add a missing '\n' in a log message

Daniel Campello (1):
      iio: Add SEMTECH SX9310/9311 sensor driver

Dmitry Osipenko (1):
      iio: magnetometer: ak8974: Silence deferred-probe error

Dragos Bogdan (3):
      iio: adc: ad7476: Generate CONVST signal internally
      iio: adc: ad7476: Add IIO_CHAN_INFO_RAW for AD7091R
      iio: adc: ad7476: Add AD7091 support

Fabrice Gasnier (1):
      dt-bindings: iio: dac: stm32-dac: convert bindings to json-schema

Ga=C3=ABtan Andr=C3=A9 (2):
      dt-bindings: st_sensors: add st,lis2hh12 compatible entry
      iio: accel: st_sensors: add support for LIS2HH12

Geert Uytterhoeven (1):
      iio: Fix misspellings of "Analog Devices"

Guido G=C3=BCnther (5):
      dt-bindings: iio: vcnl4000: convert bindings to YAML format
      dt-bindings: iio: Introduce common properties for iio sensors
      dt-bindings: iio: light: vcnl4000: Add proximity-near-level
      iio: vcnl4000: Export near level property for proximity sensor
      Documentation: ABI: document IIO in_proximity_nearlevel file

Jimmy Assarsson (2):
      iio: imu: st_lsm6dsx: Increase ODR_LIST_SIZE
      iio: imu: st_lsm6dsx: Add sensor hub device LIS3MDL

Johan Jonker (3):
      dt-bindings: iio: adc: convert rockchip saradc bindings to yaml
      dt-bindings: iio: adc: rockchip-saradc: add description for rk3308
      dt-bindings: iio: adc: rockchip-saradc: add description for px30

Jonathan Cameron (6):
      iio:accel:mxc4005: Drop unnecessary explicit casts in regmap_bulk_rea=
d calls
      iio:chemical:atlas-sensor: Drop unnecessary explicit casts in regmap_=
bulk_read calls
      iio:chemical:bme680: Tidy up parameters to regmap_bulk_read
      iio:imu:mpu6050: Tidy up parameters to regmap_bulk functions.
      iio:magn:mmc35240: Drop unnecessary casts of val parameter in regmap_=
bulk*
      iio:light:ltr501: Drop unnecessary cast of parameter in regmap_bulk_r=
ead

Lars-Peter Clausen (4):
      iio: xilinx-xadc: Fix typo in author's name
      iio: buffer: Don't allow buffers without any channels enabled to be a=
ctivated
      iio: dma-buffer: Cleanup buffer.h/buffer_impl.h includes
      iio: xilinx-xadc: Fix typo

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: configure full scale on slave device if support=
ed
      iio: imu: st_lsm6dsx: drop huge include in sensor-hub driver

Michael Hennerich (2):
      iio: adc: adi-axi-adc: add support for AXI ADC IP core
      iio: adc: ad9467: add support AD9467 ADC

Mike Looijmans (1):
      iio/gyro/bmg160: Add support for BMI088 chip

Nishant Malpani (11):
      iio: light: tsl2563: Rename macro to fix typo
      iio: accel: kxsd9: Use vsprintf extension %pe for symbolic error name
      iio: gyro: bmg160_i2c: Use vsprintf extension %pe for symbolic error =
name
      iio: gyro: bmg160_spi: Use vsprintf extension %pe for symbolic error =
name
      iio: gyro: mpu3050: Use vsprintf extension %pe for symbolic error name
      iio: imu: bmi160_i2c: Use vsprintf extension %pe for symbolic error n=
ame
      iio: imu: bmi160_spi: Use vsprintf extension %pe for symbolic error n=
ame
      iio: imu: inv_mpu6050_i2c: Use vsprintf extension %pe for symbolic er=
ror name
      iio: imu: inv_mpu6050_spi: Use vsprintf extension %pe for symbolic er=
ror name
      iio: magn: bmc150: Use vsprintf extension %pe for symbolic error name
      dt-bindings: iio: tsl2563: convert bindings to YAML

Rohit Sarkar (7):
      iio: core: Make mlock internal to the iio core
      iio: health: max30100: use generic property handler
      iio: adc: max1363: replace uses of mlock
      iio: imu: inv_mpu6050: add debugfs register r/w interface
      iio: temperature: ltc2983: remove redundant comparison to bool
      iio: imu: adis16400: use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_S=
IMPLE_ATTRIBUTE
      iio: imu: adis16460: use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_S=
IMPLE_ATTRIBUTE

Syed Nayyar Waris (1):
      MAINTAINERS: Add Syed Nayyar Waris to ACCES 104-QUAD-8 driver

Takashi Iwai (2):
      iio: core: Use scnprintf() for avoiding potential buffer overflow
      iio: tsl2772: Use scnprintf() for avoiding potential buffer overflow

Wolfram Sang (1):
      iio: imu: inv_mpu6050: convert to use i2c_new_client_device()

 Documentation/ABI/testing/sysfs-bus-iio-proximity  |   10 +
 Documentation/ABI/testing/sysfs-bus-iio-sx9310     |   10 +
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   65 ++
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   62 ++
 .../devicetree/bindings/iio/adc/maxim,max1241.yaml |   63 ++
 .../bindings/iio/adc/rockchip-saradc.txt           |   37 -
 .../bindings/iio/adc/rockchip-saradc.yaml          |   80 ++
 Documentation/devicetree/bindings/iio/common.yaml  |   35 +
 .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |   63 --
 .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  |  110 ++
 .../devicetree/bindings/iio/gyroscope/bmg160.txt   |    2 +-
 .../bindings/iio/light/amstaos,tsl2563.yaml        |   49 +
 .../devicetree/bindings/iio/light/tsl2563.txt      |   19 -
 .../devicetree/bindings/iio/light/vcnl4000.txt     |   24 -
 .../bindings/iio/light/vishay,vcnl4000.yaml        |   50 +
 .../devicetree/bindings/iio/st-sensors.txt         |    1 +
 Documentation/driver-api/driver-model/devres.rst   |    8 -
 Documentation/driver-api/iio/triggers.rst          |    2 -
 MAINTAINERS                                        |    1 +
 drivers/iio/accel/Kconfig                          |    2 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    4 +-
 drivers/iio/accel/mxc4005.c                        |    4 +-
 drivers/iio/accel/st_accel.h                       |    2 +
 drivers/iio/accel/st_accel_buffer.c                |    3 +-
 drivers/iio/accel/st_accel_core.c                  |   83 +-
 drivers/iio/accel/st_accel_i2c.c                   |    5 +
 drivers/iio/adc/Kconfig                            |   45 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/ad7476.c                           |   59 +-
 drivers/iio/adc/ad7780.c                           |   27 +-
 drivers/iio/adc/ad7791.c                           |   64 +-
 drivers/iio/adc/ad7793.c                           |  144 ++-
 drivers/iio/adc/ad9467.c                           |  422 ++++++++
 drivers/iio/adc/adi-axi-adc.c                      |  482 +++++++++
 drivers/iio/adc/at91_adc.c                         |    5 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |    4 +-
 drivers/iio/adc/intel_mrfld_adc.c                  |    6 +-
 drivers/iio/adc/max1241.c                          |  227 +++++
 drivers/iio/adc/max1363.c                          |   32 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    4 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |    4 +-
 drivers/iio/adc/xilinx-xadc-events.c               |    2 +-
 drivers/iio/adc/xilinx-xadc.h                      |    2 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |    1 -
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   41 +-
 drivers/iio/buffer/industrialio-hw-consumer.c      |   31 -
 drivers/iio/buffer/industrialio-triggered-buffer.c |   11 -
 drivers/iio/buffer/kfifo_buf.c                     |   22 -
 drivers/iio/chemical/atlas-sensor.c                |    7 +-
 drivers/iio/chemical/bme680_core.c                 |   36 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    6 +-
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |    4 +-
 drivers/iio/common/st_sensors/st_sensors_spi.c     |    6 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |   13 +-
 drivers/iio/gyro/Kconfig                           |    2 +-
 drivers/iio/gyro/bmg160_i2c.c                      |    6 +-
 drivers/iio/gyro/bmg160_spi.c                      |    5 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |    4 +-
 drivers/iio/gyro/st_gyro_buffer.c                  |    3 +-
 drivers/iio/gyro/st_gyro_core.c                    |    9 +-
 drivers/iio/health/max30100.c                      |    7 +-
 drivers/iio/humidity/hts221_buffer.c               |    6 +-
 drivers/iio/humidity/hts221_i2c.c                  |    6 +-
 drivers/iio/humidity/hts221_spi.c                  |    6 +-
 drivers/iio/imu/adis.c                             |    2 +-
 drivers/iio/imu/adis16400.c                        |   19 +-
 drivers/iio/imu/adis16460.c                        |   27 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    4 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |    4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |    8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   23 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   96 ++
 drivers/iio/industrialio-buffer.c                  |   18 +-
 drivers/iio/industrialio-core.c                    |   88 +-
 drivers/iio/industrialio-trigger.c                 |   53 -
 drivers/iio/inkern.c                               |   27 -
 drivers/iio/light/isl29125.c                       |   28 +-
 drivers/iio/light/ltr501.c                         |    2 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    4 +-
 drivers/iio/light/st_uvis25_spi.c                  |    4 +-
 drivers/iio/light/tsl2563.c                        |    2 +-
 drivers/iio/light/tsl2772.c                        |    6 +-
 drivers/iio/light/vcnl4000.c                       |   25 +
 drivers/iio/magnetometer/ak8974.c                  |    7 +-
 drivers/iio/magnetometer/bmc150_magn_spi.c         |    4 +-
 drivers/iio/magnetometer/mmc35240.c                |    4 +-
 drivers/iio/magnetometer/st_magn_core.c            |    3 +-
 drivers/iio/pressure/bmp280-core.c                 |   98 +-
 drivers/iio/pressure/st_pressure_core.c            |    7 +-
 drivers/iio/proximity/Kconfig                      |   13 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/sx9310.c                     | 1069 ++++++++++++++++=
++++
 drivers/iio/temperature/ltc2983.c                  |    4 +-
 drivers/iio/trigger/iio-trig-hrtimer.c             |    2 +-
 drivers/staging/iio/Documentation/overview.txt     |    2 +-
 include/linux/fpga/adi-axi-common.h                |    6 +-
 include/linux/iio/adc/ad_sigma_delta.h             |   58 --
 include/linux/iio/adc/adi-axi-adc.h                |   64 ++
 include/linux/iio/buffer-dma.h                     |    2 +-
 include/linux/iio/buffer-dmaengine.h               |    3 +
 include/linux/iio/buffer_impl.h                    |    9 -
 include/linux/iio/consumer.h                       |   18 -
 include/linux/iio/hw-consumer.h                    |    1 -
 include/linux/iio/iio.h                            |   10 +-
 include/linux/iio/kfifo_buf.h                      |    1 -
 include/linux/iio/trigger.h                        |    3 -
 include/linux/iio/triggered_buffer.h               |    2 -
 110 files changed, 3625 insertions(+), 774 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-proximity
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9310
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad9467.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-sara=
dc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-sara=
dc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/common.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.=
txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/amstaos,tsl=
2563.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,vcnl=
4000.yaml
 create mode 100644 drivers/iio/adc/ad9467.c
 create mode 100644 drivers/iio/adc/adi-axi-adc.c
 create mode 100644 drivers/iio/adc/max1241.c
 create mode 100644 drivers/iio/proximity/sx9310.c
 create mode 100644 include/linux/iio/adc/adi-axi-adc.h
