Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA1822365D
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 09:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQH7d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 03:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgGQH7a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jul 2020 03:59:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB7720704;
        Fri, 17 Jul 2020 07:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594972768;
        bh=SsOF7YCLU4OKHIM7FNLPsFiZI3XNlqNa7Jg+bm4B8Ps=;
        h=Date:From:To:Subject:From;
        b=zcYCOiK1h6Vt1vLt9FQAC/xTDp+CoGSpd5A2a90YWd3oIPSE/ZrGll1vMxWyWLePn
         DLFlemp0eX0DwY4EnmPW8NPfHE1ZT5gtnpTRCdQaZWpKGOrofiMzf5FcFN8TYXpNPa
         r/goXPD0ETgteJ+9MwS5T4KZsQMp4gCh0mb5J/SE=
Date:   Fri, 17 Jul 2020 08:59:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL V2] First set of new device support, cleanups and features
 for  IIO in the 5.9 cycle.
Message-ID: <20200717085925.2d965fa8@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit b791d1bdf9212d944d749a5c7ff6febdba241771:

  Merge tag 'locking-kcsan-2020-06-11' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tip/tip (2020-06-11 18:55:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.9a-take2

for you to fetch changes up to 62a30a292a8283b3022b602964ff7484d5824841:

  iio: buffer: fix attach/detach pollfunc order (2020-07-15 13:04:44 +0100)

----------------------------------------------------------------
First set of new device support, cleanups and features for IIO in the 5.9 c=
ycle

Some new devices, but particularly good this time is the core rework coming
from Alexandru. Some of this has been in Analog's tree a long time, but oth=
er
parts are motivated by closing down common mistakes in new drivers.

Changes since first try at this pull request:
* Add missed patch to actually remove iio_priv_to_dev and as a result
  also drop a few ingenic patches that need to be updated to take this
  into account.
* Fix an ordering issue int he pollfunc attach in the core rework.

New device support
* qcom pmic7 adc
  - New driver using common qcom-vadc library. Some associated cleanups and
    refactors.
* invensense icm42600
  - New driver supporting icm42600, icm42602, icm42605 and icm42622 via i2c
    or spi.  These are all 6 axis IMUs with gyro and accelerometers.
    Driver supports buffered modes using the hardware fifo and interpolation
    for accurate timestamps.
* sensirion scd30
  - New driver for this carbon dioxide sensor including i2c and serial
    interfaces + bindings.

Features
* ak8975
  - Add reset gpio support.
* bma400
  - Support SPI.
* bmc150
  - Document and add support for bmc156b and bmm150b, tidy up _magn endings.
* bmi160
  - Regulator and mount matrix support.
* mxc4005
  - Add ID for mxc6655
* rockchip-saradc
  - Triggered buffer support.

DT bindings
* qcom spmi-vadc converted to yaml + pmic7 bindings
* ak8975 tidy up and convert to yaml + add reset-gpio binding
* ingenic-adc -convert to yaml.

Core rework all carried through by Alexandru Ardelean.
* Assign parent device in the core rather than every driver. A few devices
  need to provide specific non standard parents, so there is support for
  overriding.
* Start to take parts of struct iio_dev opaque to the drivers.
  This will be a long term job, but should reduce the number of drivers
  we get that use parts that are currently only 'internal' by documentation.
* Move attach and detach of pollfunc to the core.  Every triggered buffer
  using driver had to do the same thing, so lets do it in the core.  The
  hard part here was getting all the drivers into canonical form so there
  would be no functional changes in this final patch.  That's taken quite
  a lot of work over last couple of cycles!

Cleanups and minor fixes.
* docs
  - Improve IIO_CONCENTRATION channel type description in ABI docs.
  - Drop doubled word cases.
  - Http to Https conversion.
* core
  - Make iio_device_get_drvdata take a const struct iio_dev * avoiding some
    nasty casts.
* ADCs
  - Drop lots of users of of_match_ptr macro, includes of mod_devicetable.h
    and CONFIG_OF protections.  These prevent use of ACPI PRP0001 with these
    drivers and get coppied into lots of new drivers.
* ad5380
  - Constify iio_chan_spec_ext_info
* ad5592r
  - Constify iio_chan_spec_ext_info
  - Avoid use of iio_priv_to_dev (precursor to taking parts of iio_dev opaq=
ue)
* ad8366
  - Make gpio optional as doesn't matter if its there or not.
* adis16480
  - Use irq types instead of the flags.
* atlas-ezo-sensor
  - Minimize scope of ret variable.
* at91-adc
  - Add COMPILE_TEST dependency to driver to improve build coverage.
  - Avoid use of iio_priv_to_dev (precursor to taking parts of iio_dev opaq=
ue)
* at91-sama5d2
  - Avoid use of iio_priv_to_dev (precursor to taking parts of iio_dev opaq=
ue)
  - Drop Ludovic as a co-maintaienr.
* cros_ec
  - Reapply the range after resume.
  - Add a read only frequency entry for legacy version.
  - Typo fixes
* hts221
  - Avoid use of iio_priv_to_dev (precursor to taking parts of iio_dev opaq=
ue)
* inv_mpu
  - Drop double check on ACPI companion device.
* iqs621
  - Avoid use of iio_priv_to_dev (precursor to taking parts of iio_dev opaq=
ue)
* iqs624
  - Avoid use of iio_priv_to_dev (precursor to taking parts of iio_dev opaq=
ue)
* max11100
  - Constify iio_chan_spec
* mmc35240
  - Constify reg_default
* rockchip-saradc
  - Move to managed allocators for everything in probe.
  - Use more distinctive prefix for channel macros.
* stk3310
  - Constify regmap_config.
* stm32-adc
  - Avoid use of iio_priv_to_dev (precursor to taking parts of iio_dev opaq=
ue)
* stm32-dfsdm-adc
  - Avoid use of iio_priv_to_dev (precursor to taking parts of iio_dev opaq=
ue)
* ti-am335x
  - Use managed allocations where straight forward in probe function.
* tsl2563
  - Avoid use of iio_priv_to_dev (precursor to taking parts of iio_dev opaq=
ue)

----------------------------------------------------------------
Alexander A. Klimov (2):
      Replace HTTP links with HTTPS ones: Documentation/devicetree/bindings=
/iio
      Replace HTTP links with HTTPS ones: drivers/iio

Alexandru Ardelean (26):
      iio: light: tsl2563: pass iio device as i2c_client private data
      iio: light: iqs621: remove usage of iio_priv_to_dev()
      iio: position: iqs624: remove usage of iio_priv_to_dev()
      iio: humidity: hts221: remove usage of iio_priv_to_dev()
      iio: dac: ad5592r: remove usage of iio_priv_to_dev() helper
      iio: stm32-adc: remove usage of iio_priv_to_dev() helper
      iio: Kconfig: at91_adc: add COMPILE_TEST dependency to driver
      iio: core: pass parent device as parameter during allocation
      iio: core: add iio_device_set_parent() helper
      iio: remove explicit IIO device parent assignment
      iio: remove left-over comments about parent assignment
      iio: light: lm3533-als: use iio_device_set_parent() to assign parent
      iio: remove left-over parent assignments
      iio: stm32-dfsdm-adc: remove usage of iio_priv_to_dev() helper
      iio: at91_adc: remove usage of iio_priv_to_dev() helper
      iio: at91-sama5d2_adc: remove usage of iio_priv_to_dev() helper
      iio: core: wrap IIO device into an iio_dev_opaque object
      iio: core: remove padding from private information
      iio: core: move debugfs data on the private iio dev info
      iio: core: move channel list & group to private iio device object
      iio: core: move iio_dev's buffer_list to the private iio device object
      iio: core: move event interface on the opaque struct
      iio: adc: ti_am335x_adc: alloc channels via devm_kcalloc()
      iio: adc: ti_am335x_adc: alloc kfifo & IRQ via devm_ functions
      iio: core: remove iio_priv_to_dev() helper
      iio: buffer: fix attach/detach pollfunc order

Andy Shevchenko (1):
      iio: imu: inv_mpu6050: Drop double check for ACPI companion device

Artur Rojek (1):
      dt-bindings: iio/adc: Convert ingenic-adc docs to YAML.

Christian Oder (1):
      iio: accel: mxc4005: add support for mxc6655

Chuhong Yuan (1):
      iio: amplifiers: ad8366: Change devm_gpiod_get() to optional and add =
the missed check

Dan Robertson (1):
      iio: accel: bma400: add support for bma400 spi

Gwendal Grignou (2):
      iio: cros_ec: Reapply range at resume
      iio: cros_ec_accel_legacy: Add Read Only frequency entries

Heiko Stuebner (2):
      iio: adc: rockchip_saradc: move all of probe to devm-functions
      iio: adc: rockchip_saradc: better prefix for channel constant

Jean-Baptiste Maneyrol (13):
      iio: imu: inv_icm42600: add core of new inv_icm42600 driver
      iio: imu: inv_icm42600: add I2C driver for inv_icm42600 driver
      iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver
      iio: imu: inv_icm42600: add gyroscope IIO device
      iio: imu: inv_icm42600: add accelerometer IIO device
      iio: imu: inv_icm42600: add temperature sensor support
      iio: imu: add Kconfig and Makefile for inv_icm42600 driver
      Documentation: ABI: add specific icm42600 documentation
      iio: imu: inv_icm42600: add device interrupt
      iio: imu: inv_icm42600: add buffer support in iio devices
      iio: imu: inv_icm42600: add accurate timestamping
      dt-bindings: iio: imu: Add inv_icm42600 documentation
      MAINTAINERS: add entry for inv_icm42600 6-axis imu sensor

Jishnu Prakash (7):
      iio: adc: Convert the QCOM SPMI ADC bindings to .yaml format
      iio: adc: Add PMIC7 ADC bindings
      iio: adc: Add info property under adc_data
      iio: adc: Add support for PMIC7 ADC
      iio: adc: Update return value checks
      iio: adc: Update debug prints
      iio: adc: Combine read functions for PMIC5 and PMIC7

Jonathan Albrieux (9):
      dt-bindings: iio: magnetometer: ak8975: reword gpios, add interrupts,=
 fix style
      dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add m=
aintainer
      dt-bindings: iio: magnetometer: ak8975: add gpio reset support
      iio: magnetometer: ak8975: Fix typo, uniform measurement unit style
      iio: magnetometer: ak8975: Add gpio reset support
      dt-bindings: iio: imu: bmi160: add regulators and mount-matrix
      iio: imu: bmi160: fix typo
      iio: imu: bmi160: added regulator support
      iio: imu: bmi160: added mount-matrix support

Jonathan Cameron (20):
      iio: make iio_device_get_drvdata take a const struct iio_dev *.
      iio:adc:lpc32xx: Drop of_match_ptr protection
      iio:adc:hi8435: Drop unused of_gpio.h header
      iio:adc:hi8435: Drop of_match_ptr protection.
      iio:adc:max1363: Drop of_match_ptr and use generic device_get_match_d=
ata
      iio:adc:max1027: drop of_match_ptr and CONFIG_OF protections
      iio:adc:ltc2496: Drop of_match_ptr and use mod_devicetable.h
      iio:adc:cpcap-adc: Drop of_match_ptr protection and use device_get_ma=
tch_data
      iio:adc:ltc2497 drop of_match_ptr protection
      iio:adc:max11100: Drop of_match_ptr protection / add mod_devicetable.=
h include
      iio:adc:max1118: Drop CONFIG_OF / of_match_ptr protections
      iio:adc:mcp320x: Drop CONFIG_OF and of_match_ptr protections
      iio:adc:mcp3422: remove CONFIG_OF and of_match_ptr protections
      iio:adc:sd_adc_modulator: Drop of_match_ptr and tweak includes
      iio:adc:ti-adc081c: Drop of_match_ptr and change to mod_devicetable.h
      iio:adc:ti-adc0832: drop CONFIG_OF and of_match_ptr protections
      iio:adc:ti-adc084s021: drop of_match_ptr protection
      iio:adc:ti-adc161s626: Drop of_match_ptr protection.
      iio:adc:ti-tlc4541: Drop CONFIG_OF and of_match_ptr protections.
      iio:adc:ingenic: drop of_match_ptr protection and include mod_devicet=
able.h

Keyur Patel (1):
      iio: cros_ec: fix spelling mistake

Krzysztof Kozlowski (2):
      dt-bindings: iio: bmc150_magn: Document and fix missing compatibles
      iio: magnetometer: bmc150: Add proper compatible for BMM150

Lars-Peter Clausen (2):
      iio: Remove superfluous of_node assignments
      iio: Move attach/detach of the poll func to the core

Ludovic Desroches (1):
      MAINTAINERS: adc: at91-sama5d2_adc: remove myself as co-maintainer

Matt Ranostay (1):
      iio: chemical: atlas-ezo-sensor: move ret variable scope in atlas_ezo=
_read_raw()

Nuno S=C3=A1 (1):
      iio: adis16480: Use irq types instead of flags

Randy Dunlap (2):
      Documentation/driver-api: generic-counter: drop doubled word
      Documentation/driver-api: iio/buffers: drop doubled word

Rikard Falkeborn (5):
      iio: adc: max11100: Constify struct iio_chan_spec
      iio: dac: ad5380: Constify struct iio_chan_spec_ext_info
      iio: dac: ad5592r-base: Constify struct iio_chan_spec_ext_info
      iio: light: stk3310: Constify regmap_config
      iio: magnetometer: mmc35240: Constify struct reg_default

Simon Xue (1):
      iio: adc: rockchip_saradc: Add support iio buffers

Tomasz Duszynski (5):
      iio: improve IIO_CONCENTRATION channel type description
      iio: chemical: scd30: add core driver
      iio: chemical: scd30: add I2C interface driver
      iio: chemical: scd30: add serial interface driver
      dt-bindings: iio: scd30: add device binding file

 Documentation/ABI/testing/sysfs-bus-iio            |   3 +-
 Documentation/ABI/testing/sysfs-bus-iio-icm42600   |  20 +
 Documentation/ABI/testing/sysfs-bus-iio-scd30      |  34 +
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |   4 +-
 .../devicetree/bindings/iio/adc/ingenic,adc.txt    |  49 --
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml   |  71 ++
 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 173 -----
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 278 +++++++
 .../bindings/iio/chemical/sensirion,scd30.yaml     |  68 ++
 .../devicetree/bindings/iio/dac/ti,dac7612.txt     |   2 +-
 .../devicetree/bindings/iio/iio-bindings.txt       |   2 +-
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |  14 +
 .../bindings/iio/imu/invensense,icm42600.yaml      |  90 +++
 .../devicetree/bindings/iio/light/apds9300.txt     |   2 +-
 .../devicetree/bindings/iio/light/apds9960.txt     |   2 +-
 .../devicetree/bindings/iio/light/opt3001.txt      |   2 +-
 .../devicetree/bindings/iio/light/vl6180.txt       |   2 +-
 .../bindings/iio/magnetometer/ak8975.txt           |  30 -
 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |  83 +++
 .../bindings/iio/magnetometer/bmc150_magn.txt      |   6 +-
 .../bindings/iio/potentiometer/mcp41010.txt        |   2 +-
 .../bindings/iio/potentiostat/lmp91000.txt         |   4 +-
 .../bindings/iio/pressure/asc,dlhl60d.yaml         |   2 +-
 .../bindings/iio/proximity/devantech-srf04.yaml    |   4 +-
 Documentation/driver-api/generic-counter.rst       |   2 +-
 Documentation/driver-api/iio/buffers.rst           |   2 +-
 MAINTAINERS                                        |  18 +-
 drivers/counter/104-quad-8.c                       |   1 -
 drivers/counter/stm32-lptimer-cnt.c                |   1 -
 drivers/iio/accel/Kconfig                          |   8 +-
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/adis16201.c                      |   1 -
 drivers/iio/accel/adis16209.c                      |   1 -
 drivers/iio/accel/adxl345_core.c                   |   3 +-
 drivers/iio/accel/adxl372.c                        |  21 +-
 drivers/iio/accel/bma180.c                         |   1 -
 drivers/iio/accel/bma220_spi.c                     |   1 -
 drivers/iio/accel/bma400_core.c                    |   1 -
 drivers/iio/accel/bma400_spi.c                     | 120 ++++
 drivers/iio/accel/bmc150-accel-core.c              |   5 +-
 drivers/iio/accel/cros_ec_accel_legacy.c           |  46 +-
 drivers/iio/accel/da280.c                          |   1 -
 drivers/iio/accel/da311.c                          |   1 -
 drivers/iio/accel/dmard06.c                        |   1 -
 drivers/iio/accel/dmard09.c                        |   1 -
 drivers/iio/accel/dmard10.c                        |   1 -
 drivers/iio/accel/hid-sensor-accel-3d.c            |   1 -
 drivers/iio/accel/kxcjk-1013.c                     |   3 -
 drivers/iio/accel/kxsd9.c                          |   3 -
 drivers/iio/accel/mc3230.c                         |   1 -
 drivers/iio/accel/mma7455_core.c                   |   1 -
 drivers/iio/accel/mma7660.c                        |   1 -
 drivers/iio/accel/mma8452.c                        |   1 -
 drivers/iio/accel/mma9551.c                        |   1 -
 drivers/iio/accel/mma9553.c                        |   1 -
 drivers/iio/accel/mxc4005.c                        |   3 +-
 drivers/iio/accel/mxc6255.c                        |   1 -
 drivers/iio/accel/sca3000.c                        |   1 -
 drivers/iio/accel/ssp_accel_sensor.c               |   2 -
 drivers/iio/accel/st_accel_buffer.c                |  22 +-
 drivers/iio/accel/stk8312.c                        |   3 -
 drivers/iio/accel/stk8ba50.c                       |   3 -
 drivers/iio/adc/Kconfig                            |   2 +-
 drivers/iio/adc/ab8500-gpadc.c                     |   2 -
 drivers/iio/adc/ad7091r-base.c                     |   1 -
 drivers/iio/adc/ad7124.c                           |   1 -
 drivers/iio/adc/ad7192.c                           |   1 -
 drivers/iio/adc/ad7266.c                           |   4 -
 drivers/iio/adc/ad7291.c                           |   2 -
 drivers/iio/adc/ad7292.c                           |   1 -
 drivers/iio/adc/ad7298.c                           |   2 -
 drivers/iio/adc/ad7476.c                           |   3 -
 drivers/iio/adc/ad7606.c                           |   4 +-
 drivers/iio/adc/ad7766.c                           |   3 -
 drivers/iio/adc/ad7768-1.c                         |   9 +-
 drivers/iio/adc/ad7780.c                           |   1 -
 drivers/iio/adc/ad7791.c                           |   2 -
 drivers/iio/adc/ad7793.c                           |   2 -
 drivers/iio/adc/ad7887.c                           |   5 -
 drivers/iio/adc/ad7923.c                           |   2 -
 drivers/iio/adc/ad7949.c                           |   4 +-
 drivers/iio/adc/ad799x.c                           |   2 -
 drivers/iio/adc/ad_sigma_delta.c                   |   5 -
 drivers/iio/adc/adi-axi-adc.c                      |   1 -
 drivers/iio/adc/aspeed_adc.c                       |   1 -
 drivers/iio/adc/at91-sama5d2_adc.c                 |  49 +-
 drivers/iio/adc/at91_adc.c                         |  31 +-
 drivers/iio/adc/axp20x_adc.c                       |   2 -
 drivers/iio/adc/axp288_adc.c                       |   1 -
 drivers/iio/adc/bcm_iproc_adc.c                    |   2 -
 drivers/iio/adc/berlin2-adc.c                      |   1 -
 drivers/iio/adc/cc10001_adc.c                      |   1 -
 drivers/iio/adc/cpcap-adc.c                        |  24 +-
 drivers/iio/adc/da9150-gpadc.c                     |   2 -
 drivers/iio/adc/dln2-adc.c                         |  13 +-
 drivers/iio/adc/envelope-detector.c                |   2 -
 drivers/iio/adc/ep93xx_adc.c                       |   1 -
 drivers/iio/adc/exynos_adc.c                       |   2 -
 drivers/iio/adc/fsl-imx25-gcq.c                    |   1 -
 drivers/iio/adc/hi8435.c                           |   8 +-
 drivers/iio/adc/hx711.c                            |   1 -
 drivers/iio/adc/imx7d_adc.c                        |   1 -
 drivers/iio/adc/ina2xx-adc.c                       |   4 +-
 drivers/iio/adc/ingenic-adc.c                      |   6 +-
 drivers/iio/adc/intel_mrfld_adc.c                  |   1 -
 drivers/iio/adc/lp8788_adc.c                       |   2 -
 drivers/iio/adc/lpc18xx_adc.c                      |   1 -
 drivers/iio/adc/lpc32xx_adc.c                      |   6 +-
 drivers/iio/adc/ltc2471.c                          |   1 -
 drivers/iio/adc/ltc2485.c                          |   1 -
 drivers/iio/adc/ltc2496.c                          |   4 +-
 drivers/iio/adc/ltc2497-core.c                     |   1 -
 drivers/iio/adc/ltc2497.c                          |   4 +-
 drivers/iio/adc/max1027.c                          |   7 +-
 drivers/iio/adc/max11100.c                         |   7 +-
 drivers/iio/adc/max1118.c                          |   8 +-
 drivers/iio/adc/max1241.c                          |   1 -
 drivers/iio/adc/max1363.c                          |  15 +-
 drivers/iio/adc/max9611.c                          |   2 -
 drivers/iio/adc/mcp320x.c                          |  15 +-
 drivers/iio/adc/mcp3422.c                          |  12 +-
 drivers/iio/adc/mcp3911.c                          |   2 -
 drivers/iio/adc/men_z188_adc.c                     |   1 -
 drivers/iio/adc/meson_saradc.c                     |   2 -
 drivers/iio/adc/mt6577_auxadc.c                    |   1 -
 drivers/iio/adc/mxs-lradc-adc.c                    |   3 -
 drivers/iio/adc/nau7802.c                          |   2 -
 drivers/iio/adc/npcm_adc.c                         |   1 -
 drivers/iio/adc/palmas_gpadc.c                     |   1 -
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   2 -
 drivers/iio/adc/qcom-spmi-adc5.c                   | 244 ++++++-
 drivers/iio/adc/qcom-spmi-iadc.c                   |   2 -
 drivers/iio/adc/qcom-spmi-vadc.c                   |   2 -
 drivers/iio/adc/qcom-vadc-common.c                 | 262 +++++++
 drivers/iio/adc/qcom-vadc-common.h                 |  15 +
 drivers/iio/adc/rcar-gyroadc.c                     |   2 -
 drivers/iio/adc/rn5t618-adc.c                      |   1 -
 drivers/iio/adc/rockchip_saradc.c                  | 219 ++++--
 drivers/iio/adc/sc27xx_adc.c                       |   1 -
 drivers/iio/adc/sd_adc_modulator.c                 |   7 +-
 drivers/iio/adc/spear_adc.c                        |   1 -
 drivers/iio/adc/stm32-adc.c                        | 155 ++--
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 105 +--
 drivers/iio/adc/stmpe-adc.c                        |   1 -
 drivers/iio/adc/stx104.c                           |   1 -
 drivers/iio/adc/sun4i-gpadc-iio.c                  |   2 -
 drivers/iio/adc/ti-adc081c.c                       |  14 +-
 drivers/iio/adc/ti-adc0832.c                       |  11 +-
 drivers/iio/adc/ti-adc084s021.c                    |   9 +-
 drivers/iio/adc/ti-adc108s102.c                    |   1 -
 drivers/iio/adc/ti-adc12138.c                      |   1 -
 drivers/iio/adc/ti-adc128s052.c                    |   8 +-
 drivers/iio/adc/ti-adc161s626.c                    |   5 +-
 drivers/iio/adc/ti-ads1015.c                       |   4 -
 drivers/iio/adc/ti-ads124s08.c                     |   4 +-
 drivers/iio/adc/ti-ads7950.c                       |   3 +-
 drivers/iio/adc/ti-ads8344.c                       |   4 +-
 drivers/iio/adc/ti-ads8688.c                       |   2 -
 drivers/iio/adc/ti-tlc4541.c                       |  10 +-
 drivers/iio/adc/ti_am335x_adc.c                    |  38 +-
 drivers/iio/adc/twl4030-madc.c                     |   4 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   1 -
 drivers/iio/adc/vf610_adc.c                        |   9 +-
 drivers/iio/adc/viperboard_adc.c                   |   1 -
 drivers/iio/adc/xilinx-xadc-core.c                 |   4 -
 drivers/iio/afe/iio-rescale.c                      |   1 -
 drivers/iio/amplifiers/ad8366.c                    |   8 +-
 drivers/iio/amplifiers/hmc425a.c                   |   1 -
 drivers/iio/buffer/industrialio-triggered-buffer.c |  10 +-
 drivers/iio/chemical/Kconfig                       |  33 +
 drivers/iio/chemical/Makefile                      |   3 +
 drivers/iio/chemical/ams-iaq-core.c                |   1 -
 drivers/iio/chemical/atlas-ezo-sensor.c            |   5 +-
 drivers/iio/chemical/atlas-sensor.c                |   7 +-
 drivers/iio/chemical/bme680_core.c                 |   1 -
 drivers/iio/chemical/ccs811.c                      |   1 -
 drivers/iio/chemical/pms7003.c                     |   1 -
 drivers/iio/chemical/scd30.h                       |  78 ++
 drivers/iio/chemical/scd30_core.c                  | 771 +++++++++++++++++=
+++
 drivers/iio/chemical/scd30_i2c.c                   | 139 ++++
 drivers/iio/chemical/scd30_serial.c                | 263 +++++++
 drivers/iio/chemical/sgp30.c                       |   1 -
 drivers/iio/chemical/sps30.c                       |   1 -
 drivers/iio/chemical/vz89x.c                       |   1 -
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |   5 +
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  24 +-
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |   1 -
 drivers/iio/common/st_sensors/st_sensors_spi.c     |   1 -
 drivers/iio/dac/ad5064.c                           |   1 -
 drivers/iio/dac/ad5360.c                           |   1 -
 drivers/iio/dac/ad5380.c                           |   3 +-
 drivers/iio/dac/ad5421.c                           |   1 -
 drivers/iio/dac/ad5446.c                           |   2 -
 drivers/iio/dac/ad5449.c                           |   1 -
 drivers/iio/dac/ad5504.c                           |   1 -
 drivers/iio/dac/ad5592r-base.c                     |   9 +-
 drivers/iio/dac/ad5624r_spi.c                      |   1 -
 drivers/iio/dac/ad5686.c                           |   1 -
 drivers/iio/dac/ad5755.c                           |   1 -
 drivers/iio/dac/ad5758.c                           |   1 -
 drivers/iio/dac/ad5761.c                           |   1 -
 drivers/iio/dac/ad5764.c                           |   1 -
 drivers/iio/dac/ad5770r.c                          |   1 -
 drivers/iio/dac/ad5791.c                           |   1 -
 drivers/iio/dac/ad7303.c                           |   1 -
 drivers/iio/dac/ad8801.c                           |   1 -
 drivers/iio/dac/cio-dac.c                          |   1 -
 drivers/iio/dac/dpot-dac.c                         |   1 -
 drivers/iio/dac/ds4424.c                           |   2 -
 drivers/iio/dac/lpc18xx_dac.c                      |   1 -
 drivers/iio/dac/ltc1660.c                          |   1 -
 drivers/iio/dac/ltc2632.c                          |   1 -
 drivers/iio/dac/m62332.c                           |   3 -
 drivers/iio/dac/max517.c                           |   3 -
 drivers/iio/dac/max5821.c                          |   1 -
 drivers/iio/dac/mcp4725.c                          |   1 -
 drivers/iio/dac/mcp4922.c                          |   1 -
 drivers/iio/dac/stm32-dac.c                        |   1 -
 drivers/iio/dac/ti-dac082s085.c                    |  13 +-
 drivers/iio/dac/ti-dac5571.c                       |  20 +-
 drivers/iio/dac/ti-dac7311.c                       |   4 +-
 drivers/iio/dac/ti-dac7612.c                       |   1 -
 drivers/iio/dac/vf610_dac.c                        |   2 -
 drivers/iio/dummy/iio_simple_dummy.c               |  14 +-
 drivers/iio/dummy/iio_simple_dummy_buffer.c        |  14 -
 drivers/iio/frequency/ad9523.c                     |   1 -
 drivers/iio/frequency/adf4350.c                    |   1 -
 drivers/iio/frequency/adf4371.c                    |   1 -
 drivers/iio/gyro/adis16080.c                       |   1 -
 drivers/iio/gyro/adis16130.c                       |   1 -
 drivers/iio/gyro/adis16136.c                       |   1 -
 drivers/iio/gyro/adis16260.c                       |   1 -
 drivers/iio/gyro/adxrs450.c                        |   1 -
 drivers/iio/gyro/bmg160_core.c                     |   3 -
 drivers/iio/gyro/fxas21002c_core.c                 |   1 -
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   1 -
 drivers/iio/gyro/itg3200_core.c                    |   1 -
 drivers/iio/gyro/mpu3050-core.c                    |   3 -
 drivers/iio/gyro/ssp_gyro_sensor.c                 |   1 -
 drivers/iio/gyro/st_gyro_buffer.c                  |  21 +-
 drivers/iio/health/afe4403.c                       |   3 +-
 drivers/iio/health/afe4404.c                       |   3 +-
 drivers/iio/health/afe440x.h                       |   2 +-
 drivers/iio/health/max30100.c                      |   1 -
 drivers/iio/health/max30102.c                      |   1 -
 drivers/iio/humidity/am2315.c                      |   1 -
 drivers/iio/humidity/dht11.c                       |   1 -
 drivers/iio/humidity/hdc100x.c                     |  23 +-
 drivers/iio/humidity/hid-sensor-humidity.c         |   1 -
 drivers/iio/humidity/hts221.h                      |   4 +-
 drivers/iio/humidity/hts221_buffer.c               |  11 +-
 drivers/iio/humidity/hts221_core.c                 |   5 +-
 drivers/iio/humidity/htu21.c                       |   1 -
 drivers/iio/humidity/si7005.c                      |   1 -
 drivers/iio/humidity/si7020.c                      |   1 -
 drivers/iio/iio_core_trigger.h                     |  17 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/adis16400.c                        |   1 -
 drivers/iio/imu/adis16460.c                        |   1 -
 drivers/iio/imu/adis16475.c                        |   1 -
 drivers/iio/imu/adis16480.c                        |   7 +-
 drivers/iio/imu/bmi160/bmi160.h                    |   3 +
 drivers/iio/imu/bmi160/bmi160_core.c               |  47 +-
 drivers/iio/imu/fxos8700_core.c                    |   1 -
 drivers/iio/imu/inv_icm42600/Kconfig               |  29 +
 drivers/iio/imu/inv_icm42600/Makefile              |  15 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        | 395 ++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 787 +++++++++++++++++=
+++
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 601 ++++++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |  98 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 786 +++++++++++++++++=
+++
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 798 +++++++++++++++++=
++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    | 101 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    | 100 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   |  84 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h   |  30 +
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.c  | 195 +++++
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.h  |  85 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   1 -
 drivers/iio/imu/kmx61.c                            |   1 -
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   1 -
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   1 -
 drivers/iio/industrialio-buffer.c                  |  58 +-
 drivers/iio/industrialio-core.c                    | 129 ++--
 drivers/iio/industrialio-event.c                   |  68 +-
 drivers/iio/industrialio-trigger.c                 |  22 +-
 drivers/iio/light/acpi-als.c                       |   1 -
 drivers/iio/light/adjd_s311.c                      |   1 -
 drivers/iio/light/adux1020.c                       |   1 -
 drivers/iio/light/al3010.c                         |   1 -
 drivers/iio/light/al3320a.c                        |   1 -
 drivers/iio/light/apds9300.c                       |   1 -
 drivers/iio/light/apds9960.c                       |   1 -
 drivers/iio/light/bh1750.c                         |   1 -
 drivers/iio/light/bh1780.c                         |   1 -
 drivers/iio/light/cm32181.c                        |   1 -
 drivers/iio/light/cm3232.c                         |   1 -
 drivers/iio/light/cm3323.c                         |   1 -
 drivers/iio/light/cm3605.c                         |   1 -
 drivers/iio/light/cm36651.c                        |   1 -
 drivers/iio/light/cros_ec_light_prox.c             |   6 +-
 drivers/iio/light/gp2ap002.c                       |   1 -
 drivers/iio/light/gp2ap020a00f.c                   |  11 -
 drivers/iio/light/hid-sensor-als.c                 |   1 -
 drivers/iio/light/hid-sensor-prox.c                |   1 -
 drivers/iio/light/iqs621-als.c                     |   7 +-
 drivers/iio/light/isl29018.c                       |   1 -
 drivers/iio/light/isl29028.c                       |   1 -
 drivers/iio/light/isl29125.c                       |  21 +-
 drivers/iio/light/jsa1212.c                        |   1 -
 drivers/iio/light/lm3533-als.c                     |   2 +-
 drivers/iio/light/ltr501.c                         |   1 -
 drivers/iio/light/lv0104cs.c                       |   3 +-
 drivers/iio/light/max44000.c                       |   1 -
 drivers/iio/light/max44009.c                       |   1 -
 drivers/iio/light/noa1305.c                        |   1 -
 drivers/iio/light/opt3001.c                        |   3 +-
 drivers/iio/light/pa12203001.c                     |   1 -
 drivers/iio/light/rpr0521.c                        |   3 -
 drivers/iio/light/si1133.c                         |   1 -
 drivers/iio/light/si1145.c                         |   3 -
 drivers/iio/light/st_uvis25_core.c                 |   3 -
 drivers/iio/light/stk3310.c                        |   3 +-
 drivers/iio/light/tcs3414.c                        |  21 +-
 drivers/iio/light/tcs3472.c                        |   1 -
 drivers/iio/light/tsl2563.c                        |  13 +-
 drivers/iio/light/tsl2583.c                        |   1 -
 drivers/iio/light/tsl2772.c                        |   1 -
 drivers/iio/light/tsl4531.c                        |   1 -
 drivers/iio/light/us5182d.c                        |   1 -
 drivers/iio/light/vcnl4000.c                       |  36 +-
 drivers/iio/light/vcnl4035.c                       |   1 -
 drivers/iio/light/veml6030.c                       |   1 -
 drivers/iio/light/veml6070.c                       |   1 -
 drivers/iio/light/vl6180.c                         |   1 -
 drivers/iio/light/zopt2201.c                       |   1 -
 drivers/iio/magnetometer/ak8974.c                  |   1 -
 drivers/iio/magnetometer/ak8975.c                  |  23 +-
 drivers/iio/magnetometer/bmc150_magn.c             |   3 -
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |   3 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   1 -
 drivers/iio/magnetometer/hmc5843_core.c            |   1 -
 drivers/iio/magnetometer/mag3110.c                 |   1 -
 drivers/iio/magnetometer/mmc35240.c                |   3 +-
 drivers/iio/magnetometer/rm3100-core.c             |   3 -
 drivers/iio/magnetometer/st_magn_buffer.c          |  26 +-
 drivers/iio/multiplexer/iio-mux.c                  |   1 -
 drivers/iio/orientation/hid-sensor-incl-3d.c       |   1 -
 drivers/iio/orientation/hid-sensor-rotation.c      |   1 -
 drivers/iio/position/iqs624-pos.c                  |   7 +-
 drivers/iio/potentiometer/ad5272.c                 |   3 +-
 drivers/iio/potentiometer/ds1803.c                 |   1 -
 drivers/iio/potentiometer/max5432.c                |   1 -
 drivers/iio/potentiometer/max5481.c                |   3 +-
 drivers/iio/potentiometer/max5487.c                |   1 -
 drivers/iio/potentiometer/mcp4018.c                |   1 -
 drivers/iio/potentiometer/mcp41010.c               |   3 +-
 drivers/iio/potentiometer/mcp4131.c                |   3 +-
 drivers/iio/potentiometer/mcp4531.c                |   1 -
 drivers/iio/potentiometer/tpl0102.c                |   1 -
 drivers/iio/potentiostat/lmp91000.c                |  14 +-
 drivers/iio/pressure/abp060mg.c                    |   1 -
 drivers/iio/pressure/bmp280-core.c                 |   1 -
 drivers/iio/pressure/cros_ec_baro.c                |   8 +-
 drivers/iio/pressure/dlhl60d.c                     |   4 +-
 drivers/iio/pressure/dps310.c                      |   1 -
 drivers/iio/pressure/hid-sensor-press.c            |   1 -
 drivers/iio/pressure/hp03.c                        |   1 -
 drivers/iio/pressure/hp206c.c                      |   1 -
 drivers/iio/pressure/icp10100.c                    |   1 -
 drivers/iio/pressure/mpl115.c                      |   1 -
 drivers/iio/pressure/mpl3115.c                     |   1 -
 drivers/iio/pressure/ms5611_core.c                 |   1 -
 drivers/iio/pressure/ms5637.c                      |   1 -
 drivers/iio/pressure/st_pressure_buffer.c          |  26 +-
 drivers/iio/pressure/t5403.c                       |   1 -
 drivers/iio/pressure/zpa2326.c                     |  28 +-
 drivers/iio/proximity/as3935.c                     |   1 -
 drivers/iio/proximity/isl29501.c                   |   1 -
 drivers/iio/proximity/mb1232.c                     |   1 -
 drivers/iio/proximity/ping.c                       |   1 -
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   1 -
 drivers/iio/proximity/rfd77402.c                   |   1 -
 drivers/iio/proximity/srf04.c                      |   3 +-
 drivers/iio/proximity/srf08.c                      |   7 +-
 drivers/iio/proximity/sx9310.c                     |   3 -
 drivers/iio/proximity/sx9500.c                     |  10 -
 drivers/iio/proximity/vcnl3020.c                   |   1 -
 drivers/iio/proximity/vl53l0x-i2c.c                |   1 -
 drivers/iio/resolver/ad2s1200.c                    |   1 -
 drivers/iio/resolver/ad2s90.c                      |   1 -
 drivers/iio/temperature/hid-sensor-temperature.c   |   1 -
 drivers/iio/temperature/iqs620at-temp.c            |   1 -
 drivers/iio/temperature/ltc2983.c                  |   1 -
 drivers/iio/temperature/max31856.c                 |   2 -
 drivers/iio/temperature/maxim_thermocouple.c       |   1 -
 drivers/iio/temperature/mlx90614.c                 |   1 -
 drivers/iio/temperature/mlx90632.c                 |   1 -
 drivers/iio/temperature/tmp006.c                   |   1 -
 drivers/iio/temperature/tmp007.c                   |   1 -
 drivers/iio/temperature/tsys01.c                   |   1 -
 drivers/iio/temperature/tsys02d.c                  |   1 -
 drivers/iio/trigger/stm32-timer-trigger.c          |   2 -
 drivers/input/touchscreen/tsc2007_iio.c            |   1 -
 drivers/platform/x86/toshiba_acpi.c                |   3 +-
 drivers/staging/iio/Documentation/device.txt       |   4 +-
 drivers/staging/iio/accel/adis16203.c              |   1 -
 drivers/staging/iio/accel/adis16240.c              |   1 -
 drivers/staging/iio/adc/ad7280a.c                  |   1 -
 drivers/staging/iio/adc/ad7816.c                   |   1 -
 drivers/staging/iio/addac/adt7316.c                |   1 -
 drivers/staging/iio/cdc/ad7150.c                   |   2 -
 drivers/staging/iio/cdc/ad7746.c                   |   2 -
 drivers/staging/iio/frequency/ad9832.c             |   1 -
 drivers/staging/iio/frequency/ad9834.c             |   1 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   1 -
 drivers/staging/iio/resolver/ad2s1210.c            |   1 -
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h    |  67 ++
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h   |  88 +++
 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h   |  46 ++
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h   |  28 +
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h   |  28 +
 include/dt-bindings/iio/qcom,spmi-vadc.h           |  78 +-
 include/linux/iio/common/cros_ec_sensors_core.h    |  11 +-
 include/linux/iio/iio-opaque.h                     |  36 +
 include/linux/iio/iio.h                            |  61 +-
 include/linux/iio/trigger_consumer.h               |   7 -
 429 files changed, 7973 insertions(+), 1642 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.t=
xt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vad=
c.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vad=
c.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirio=
n,scd30.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,ic=
m42600.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak89=
75.txt
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/asah=
i-kasei,ak8975.yaml
 create mode 100644 drivers/iio/accel/bma400_spi.c
 create mode 100644 drivers/iio/chemical/scd30.h
 create mode 100644 drivers/iio/chemical/scd30_core.c
 create mode 100644 drivers/iio/chemical/scd30_i2c.c
 create mode 100644 drivers/iio/chemical/scd30_serial.c
 create mode 100644 drivers/iio/imu/inv_icm42600/Kconfig
 create mode 100644 drivers/iio/imu/inv_icm42600/Makefile
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.h
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.c
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
 create mode 100644 include/linux/iio/iio-opaque.h
