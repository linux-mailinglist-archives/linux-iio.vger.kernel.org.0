Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB44B25EDC7
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 14:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIFMkd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 08:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgIFMkE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 08:40:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1814F208B3;
        Sun,  6 Sep 2020 12:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599396002;
        bh=RZDuMEkAY5aIFebriDMtUucBvD/sAJjTu7J/e7Cp3lc=;
        h=Date:From:To:Cc:Subject:From;
        b=ZTS7Dy+jqceUZTuyBzWQtmiu+Th4LkQvBYKHUoTihpT04UsERlrKY0ADptf6GF92d
         /UXpJsqClNJ3ikAaM4ExB4UTZdXaTLZyFgcQFqSwmGmXDxY2LUl3ZklEBDrUpWwa5L
         KRIlIIAJLfY2EzdL3EYqyQCKp4U57sHy5xGfzunE=
Date:   Sun, 6 Sep 2020 13:39:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [PULL] IIO: First set of new device support etc for the 5.10 cycle
Message-ID: <20200906133958.6fec0a17@archlinux>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit bc752d2f345bf55d71b3422a6a24890ea03168dc:

  staging: hikey9xx: Kconfig: add regulator dependency (2020-08-18 19:15:47 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.10a

for you to fetch changes up to 1bebdcb928eba880f3a119bacb8149216206958a:

  drivers/iio/humidity/hdc2010.c:305:2-3: Unneeded semicolon (2020-09-03 19:41:00 +0100)

----------------------------------------------------------------
First set of new device support, features and cleanup for IIO in 5.10 cycle

A few changes to how I write this cover letter.
* Started to use manufacturer prefixes to group changes better.
* Stop list minor formatting etc changes.
* Whilst I appreciate those changes, we don't need to call them out here.

New device support:
* adi,adxrs290
  - New driver for this gyroscope with dt bindings. One fix follows.
* ams,as73211
  - New driver for this colour sensor with dt bindings. Also includes
    docs for XYZ modifiers as used for the CIE colour space. Sysfs docs.
* atlas,atlas-ezo-sensor
  - Support O_2 sensor, includes new modifier for concentration.
  - Support humidity sensor.
* ti,hdc2010
  - New driver support hdc2010 and hdc2080 humidity sensors. Includes dt
    bindings.

Cleanup, minor fixes and features
* core
  - Make the trigger related stub functions static inline, avoiding some build
   warnings.
  - buffer-dmaengine. Allow adjusting bytes_used with residue info.
* dev_error_probe to replace open coded equivalent in many drivers.
* docs and comment fixes
  - Fix some typos, doubled words, capitalisation and punctuation.
* dt binding conversions to yaml
  - lltc,ltc2497
  - lltc,ltc2632
  - maxim,max11100
  - maxim,max1118
  - maxim,max9611
  - microchip,mcp3201
  - microchip,mcp342x (add to trivial devices)
  - ti,adc0832
  - ti,adc108s102
  - ti,adc128s052
  - ti,adc161s626
  - ti,ads8344
  - ti,tlc4541 (includes adding an accidentally dropped original binding doc)
* adi,adi-axi-adc
  - Use kobj_to_dev instead of open coding.
* adi,ad5686
  - Constify iio_chan_spec
* adi,ad8366
  - Add HMC1119 to kconfig help text as the driver supports it.
* adi,ad9523
  - Use devm for reset of probe and drop remove.
* adi,adxl372
  - Tidy up alignment
  - Add OF table
  - Add peak mode support with some docs.
* bosch,bma220 (general tidy up)
  - Fix some return codes.
  - Use read_avail callback rather than open coding attrs.
  - Use dev_get_drvdata rather than dance via to_spi_device()
  - Mark PM functions as __maybe_unused rather than #ifdef fun.
  - Drop ACPI_PTR protections and ifdefs.
  - Tidy up header ordering.
  - BIT and GENMASK
* broadcom,bcm_iproc
  - Drop of_match_ptr protection and switch to mod_devicetable.h
    Part of general move to get this anti-pattern out of IIO.
* melexis,mlx90614
  - Simplify some calculations.
  - Add some kernel_doc
  - Use regmap poll loop rather than open coding.
  - Add extended calibration option.
* sensortec,sx9310, wide ranging set of fixes and cleanups.
  - Document dt-binding.
  - Rename some macros to align better with spec sheet
  - Fix some issues with irq handling.
  - Drop of_match_ptr and ACPI_PTR macros to avoid unused warnings etc.
  - Switch to probe_new
  - Fix memory alignment for iio_push_to_buffers_with_timestamp()
  - Use long for bitmaps to allow use of for_each_bit_set()
  - Use regmap_read_poll instead of opencoding.
  - Simplify error paths
  - Enabled regulators at probe.
  - Use trigger flags from firmware rather than forcing them in the driver.
* ti,adc081c
  - Drop ACPI IDs that are not likely to be official ones and we don't believe
    anyone is using.
* ti,adc108s102
  - Drop CONFIG_OF and of_match_ptr protections.
* ti,adc128s052
  - Drop of_match_ptr protection and include mod_devicetable.h
* ti,dac5571
  - Support powerdown for mutlichannel usecases.
* xpowers,axp20x
  - Convert from OF to generic fw / device properties. Unlikely anyone will
    use this with anything other than devicetree, but this is part of a
    general move across IIO.

----------------------------------------------------------------
Ahmad Fatoum (1):
      Documentation: ABI: iio: fix some spelling mistakes

Alexandru Ardelean (4):
      iio: frequency: ad9523: convert rest of driver to device managed functions
      iio: adxl372_spi: change indentation for of_table
      iio: Kconfig: ad8366: add entry for HMC1119 chip
      iio: buffer-dmaengine: adjust `bytes_used` with residue info

Alexandru Tachici (1):
      iio: accel: adxl372: Add additional trigger ABI docs

Andy Shevchenko (8):
      iio: accel: bma220: Fix returned codes from bma220_init(), bma220_deinit()
      iio: accel: bma220: Convert to use ->read_avail()
      iio: accel: bma220: Use dev_get_drvdata() directly
      iio: accel: bma220: Mark PM functions as __maybe_unused
      iio: accel: bma220: Drop ACPI_PTR() and accompanying ifdeffery
      iio: accel: bma220: Group IIO headers together
      iio: accel: bma220: Use BIT() and GENMASK() macros
      iio: accel: bma220: Remove unneeded blank lines

Ankit Baluni (1):
      Staging: iio: Fixed a punctuation and a spelling mistake.

Calvin Glisson (1):
      staging: iio: ad9834: Remove excess blank line

Chris Ruehl (1):
      iio/dac: convert ltc2632.txt to lltc,ltc2632.yaml

Christian Eggers (3):
      dt-bindings: iio: light: add AMS AS73211 support
      iio: light: as73211: New driver
      iio: documentation: light: Add as73211 sysfs documentation

Crt Mori (5):
      iio:temperature:mlx90632: Reduce number of equal calulcations
      iio:temperature:mlx90632: Add kerneldoc to the internal struct
      iio:temperature:mlx90632: Convert polling while loop to regmap
      iio:temperature:mlx90632: Adding extended calibration option
      iio:temperature:mlx90632: Some stylefixing leftovers

Daniel Campello (12):
      dt-bindings: iio: Add bindings for sx9310 sensor
      iio: sx9310: Update macros declarations
      iio: sx9310: Fix irq handling
      iio: sx9310: Remove acpi and of table macros
      iio: sx9310: Change from .probe to .probe_new
      iio: sx9310: Fixes various memory handling
      iio: sx9310: Use long instead of int for channel bitmaps
      iio: sx9310: Use regmap_read_poll_timeout() for compensation
      iio: sx9310: Update copyright
      iio: sx9310: Simplify error return handling
      iio: sx9310: Use variable to hold &client->dev
      iio: sx9310: Miscellaneous format fixes

Eugene Zaikonnikov (2):
      iio: humidity: Add TI HDC20x0 support
      dt-bindings: iio: humidity: Add TI HDC20x0 support

Gwendal Grignou (1):
      docs: abi: iio: Use What: consistently

Jonathan Cameron (17):
      dt-bindings: iio: adc: maxim,max11100 yaml conversion
      dt-bindings: iio: adc: maxim,max9611 yaml conversions
      dt-bindings: iio: adc: maxim,max1118 yaml conversion
      iio:adc:bcm_iproc: Drop of_match_ptr protection and switch to mod_devicetable.h
      iio:adc:ti-adc128s052: drop of_match_ptr protection
      iio:adc:ti-adc108s102: Drop CONFIG_OF and of_match_ptr protections
      iio:adc:ti-adc081c: Drop ACPI ids that seem very unlikely to be official.
      iio:adc:axp20x: Convert from OF to generic fw / device properties
      dt-bindings: trivial-devices: Add mcp342x ADCs and drop separate binding doc.
      dt-bindings: iio: adc: ti,adc108s102 yaml conversion
      dt-bindings: iio: adc: lltc,ltc2497 yaml conversion.
      dt-bindings: iio: adc: ti,adc161s626 yaml conversion.
      dt-bindings: iio: adc: ti,adc0832 yaml conversion.
      dt-bindings: iio: adc: ti,adc128s052 yaml conversion.
      dt-bindings: iio: adc: ti,ads8344 yaml conversion
      dt-bindings: iio: adc: ti,tlc4541 binding conversion
      dt-bindings: iio: adc: microchip,mcp3201 yaml conversion.

Krzysztof Kozlowski (18):
      iio: accel: bma180: Simplify with dev_err_probe()
      iio: accel: mma8452: Simplify with dev_err_probe()
      iio: adc: envelope-detector: Simplify with dev_err_probe()
      iio: adc: exynos_adc: Simplify with dev_err_probe()
      iio: adc: ltc2497: Simplify with dev_err_probe()
      iio: adc: meson_saradc: Simplify with dev_err_probe()
      iio: adc: rcar-gyroadc: Simplify with dev_err_probe()
      iio: adc: stm32: Simplify with dev_err_probe()
      iio: afe: iio-rescale: Simplify with dev_err_probe()
      iio: amplifiers: hmc425a: Simplify with dev_err_probe()
      iio: chemical: scd30: Simplify with dev_err_probe()
      iio: dac: dpot-dac: Simplify with dev_err_probe()
      iio: imu: inv_mpu6050: Simplify with dev_err_probe()
      iio: light: isl29018: Simplify with dev_err_probe()
      iio: light: tsl2772: Simplify with dev_err_probe()
      iio: magnetometer: ak8974: Simplify with dev_err_probe()
      iio: magnetometer: mag3110: Simplify with dev_err_probe()
      iio: multiplexer: iio-mux: Simplify with dev_err_probe()

Lars-Peter Clausen (1):
      iio: trigger: make stub functions static inline

Matt Ranostay (6):
      iio: add IIO_MOD_O2 modifier
      iio: chemical: atlas-ezo-sensor: add support for O2 sensor
      dt-bindings: iio: chemical: add O2 EZO module documentation
      iio: health: max30102: update author's email
      dt-bindings: iio: chemical: add Atlas EZO Humidity module documentation
      iio: chemical: atlas-ezo-sensor: add humidity sensor support

Nishant Malpani (3):
      iio: gyro: Add driver support for ADXRS290
      dt-bindings: iio: gyro: Add DT binding doc for ADXRS290
      iio: gyro: adxrs290: Insert missing mutex initialization call

Phil Reid (1):
      dt-bindings: iio: adc: tlc4541 - recover accidentally dropped binding doc

Randy Dunlap (1):
      platform_data: ad7793.h: drop a duplicated word

Rikard Falkeborn (1):
      iio: dac: ad5686: Constify static struct iio_chan_spec

Stefan Popa (2):
      iio: adxl372_i2c: Add OF device ID table
      iio: accel: adxl372: Add support for FIFO peak mode

Stephen Boyd (3):
      iio: sx9310: Drop channel_users[]
      iio: sx9310: Enable vdd and svdd regulators at probe
      iio: sx9310: Use irq trigger flags from firmware

Tian Tao (1):
      iio: adc: adi-axi-adc: Use kobj_to_dev() instead of container_of()

Vincent Whitchurch (1):
      iio: dac: dac5571: Support powerdown for multi-channel

kernel test robot (1):
      drivers/iio/humidity/hdc2010.c:305:2-3: Unneeded semicolon

 Documentation/ABI/testing/sysfs-bus-iio            |  82 ++-
 .../ABI/testing/sysfs-bus-iio-accel-adxl372        |   7 +
 .../ABI/testing/sysfs-bus-iio-humidity-hdc2010     |   9 +
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |  44 ++
 .../devicetree/bindings/iio/adc/ltc2497.txt        |  13 -
 .../devicetree/bindings/iio/adc/max11100.txt       |  18 -
 .../devicetree/bindings/iio/adc/max1118.txt        |  21 -
 .../devicetree/bindings/iio/adc/max9611.txt        |  27 -
 .../bindings/iio/adc/maxim,max11100.yaml           |  49 ++
 .../devicetree/bindings/iio/adc/maxim,max1118.yaml |  62 ++
 .../devicetree/bindings/iio/adc/maxim,max9611.yaml |  51 ++
 .../devicetree/bindings/iio/adc/mcp320x.txt        |  57 --
 .../devicetree/bindings/iio/adc/mcp3422.txt        |  19 -
 .../bindings/iio/adc/microchip,mcp3201.yaml        |  77 ++
 .../devicetree/bindings/iio/adc/ti,adc0832.yaml    |  56 ++
 .../devicetree/bindings/iio/adc/ti,adc108s102.yaml |  47 ++
 .../devicetree/bindings/iio/adc/ti,adc128s052.yaml |  59 ++
 .../devicetree/bindings/iio/adc/ti,adc161s626.yaml |  51 ++
 .../devicetree/bindings/iio/adc/ti,ads8344.yaml    |  51 ++
 .../devicetree/bindings/iio/adc/ti,tlc4541.yaml    |  52 ++
 .../devicetree/bindings/iio/adc/ti-adc0832.txt     |  19 -
 .../devicetree/bindings/iio/adc/ti-adc108s102.txt  |  18 -
 .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |  25 -
 .../devicetree/bindings/iio/adc/ti-adc161s626.txt  |  18 -
 .../devicetree/bindings/iio/adc/ti-ads8344.txt     |  19 -
 .../bindings/iio/chemical/atlas,sensor.yaml        |   4 +
 .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml  |  77 ++
 .../devicetree/bindings/iio/dac/ltc2632.txt        |  49 --
 .../bindings/iio/gyroscope/adi,adxrs290.yaml       |  53 ++
 .../bindings/iio/humidity/ti,hdc2010.yaml          |  45 ++
 .../devicetree/bindings/iio/light/ams,as73211.yaml |  54 ++
 .../bindings/iio/proximity/semtech,sx9310.yaml     |  65 ++
 .../devicetree/bindings/trivial-devices.yaml       |  16 +
 MAINTAINERS                                        |  14 +
 drivers/iio/accel/adxl372.c                        | 311 +++++++-
 drivers/iio/accel/adxl372_i2c.c                    |   8 +
 drivers/iio/accel/adxl372_spi.c                    |   4 +-
 drivers/iio/accel/bma180.c                         |  20 +-
 drivers/iio/accel/bma220_spi.c                     |  85 ++-
 drivers/iio/accel/mma8452.c                        |  20 +-
 drivers/iio/adc/Kconfig                            |   2 +-
 drivers/iio/adc/adi-axi-adc.c                      |   2 +-
 drivers/iio/adc/axp20x_adc.c                       |  14 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |   4 +-
 drivers/iio/adc/envelope-detector.c                |  16 +-
 drivers/iio/adc/exynos_adc.c                       |  10 +-
 drivers/iio/adc/ltc2497-core.c                     |  10 +-
 drivers/iio/adc/meson_saradc.c                     |   7 +-
 drivers/iio/adc/rcar-gyroadc.c                     |   9 +-
 drivers/iio/adc/stm32-adc-core.c                   |  75 +-
 drivers/iio/adc/stm32-adc.c                        |  10 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  10 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |   9 +-
 drivers/iio/adc/ti-adc081c.c                       |  24 +-
 drivers/iio/adc/ti-adc108s102.c                    |   5 +-
 drivers/iio/adc/ti-adc128s052.c                    |   3 +-
 drivers/iio/afe/iio-rescale.c                      |   8 +-
 drivers/iio/amplifiers/Kconfig                     |   1 +
 drivers/iio/amplifiers/hmc425a.c                   |   9 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   6 +-
 drivers/iio/chemical/atlas-ezo-sensor.c            |  88 ++-
 drivers/iio/chemical/scd30_core.c                  |   9 +-
 drivers/iio/dac/ad5686.c                           |   8 +-
 drivers/iio/dac/ad5686.h                           |   2 +-
 drivers/iio/dac/dpot-dac.c                         |  16 +-
 drivers/iio/dac/stm32-dac-core.c                   |   5 +-
 drivers/iio/dac/ti-dac5571.c                       |  29 +-
 drivers/iio/frequency/ad9523.c                     |  60 +-
 drivers/iio/gyro/Kconfig                           |  10 +
 drivers/iio/gyro/Makefile                          |   1 +
 drivers/iio/gyro/adxrs290.c                        | 446 ++++++++++++
 drivers/iio/health/max30102.c                      |   4 +-
 drivers/iio/humidity/Kconfig                       |  10 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc2010.c                     | 353 +++++++++
 drivers/iio/iio_core_trigger.h                     |   4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  20 +-
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/light/Kconfig                          |  15 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/as73211.c                        | 801 +++++++++++++++++++++
 drivers/iio/light/isl29018.c                       |   9 +-
 drivers/iio/light/tsl2772.c                        |  10 +-
 drivers/iio/magnetometer/ak8974.c                  |  11 +-
 drivers/iio/magnetometer/mag3110.c                 |  20 +-
 drivers/iio/multiplexer/iio-mux.c                  |   8 +-
 drivers/iio/proximity/sx9310.c                     | 420 +++++------
 drivers/iio/temperature/mlx90632.c                 | 274 ++++++-
 drivers/staging/iio/Documentation/overview.txt     |   4 +-
 drivers/staging/iio/frequency/ad9834.c             |   1 -
 include/linux/platform_data/ad7793.h               |   2 +-
 include/uapi/linux/iio/types.h                     |   1 +
 tools/iio/iio_event_monitor.c                      |   2 +
 93 files changed, 3696 insertions(+), 960 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-adxl372
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ltc2497.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max1118.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max9611.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11100.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1118.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max9611.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp320x.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3422.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc0832.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc108s102.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc161s626.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads8344.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tlc4541.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc0832.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc108s102.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc2632.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc2010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
 create mode 100644 drivers/iio/gyro/adxrs290.c
 create mode 100644 drivers/iio/humidity/hdc2010.c
 create mode 100644 drivers/iio/light/as73211.c
