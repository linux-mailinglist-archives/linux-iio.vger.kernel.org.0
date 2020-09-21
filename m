Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022E5273273
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgIUTHB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 15:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgIUTHA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 15:07:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030872054F;
        Mon, 21 Sep 2020 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600715219;
        bh=TqV61yytQtsBu4RZ9lLMOLJKkQpG3APcAu9RbvfKIVQ=;
        h=Date:From:To:Subject:From;
        b=Mk80ShEAQUYOKoJGFhHaDTpd2PxNpbfWKvQ9WGLFJ3dDkA3YDO4UcOv3cZjQrjqG5
         paVUNZBUd4aPVQAujDHHmNAcX6OBTKaOtb3sF+w0mgzxDcANMpq71LmvRyAFzJnvLk
         MySuizsXRIeXM3zciulhFlRGXhFM19gAmyGJHjfY=
Date:   Mon, 21 Sep 2020 20:06:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL v2] Second set of features and cleanup for IIO in the 5.10 
 cycle.
Message-ID: <20200921200655.583b16cd@archlinux>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 2f0472a1f80e6230f126aa0af76e89f85abc37bd:

  drivers/iio/humidity/hdc2010.c:305:2-3: Unneeded semicolon (2020-09-06 16=
:05:56 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-5.10b-take2

for you to fetch changes up to 596fd0162ac70c2253041e60394ecb5cccb15b07:

  dt-bindings: iio: vishay,vcnl4000: add interrupts property (2020-09-21 20=
:01:51 +0100)

----------------------------------------------------------------
Second set of features and cleanups for IIO in 5.10

We have a couple of changes that apply to large sets of drivers, so
I have grouped those to keep this short.

There are a few late breaking fixes in here that can wait for the
merge window.

dt yaml conversions
-------------------

* adi,ad7768-1
* adi,ad7949
* aspeed,ast2400
* cosmic,10001-adc
* dlg,da9150-gpadc
* fsl,imx25-gcq
* fsl,imx7d-adc
* fsl,vf610
* holt,hi8435
* marvell,berlin2-adc
* motorola,cpcap-adc
* nuvoton,nau7802
* nuvoton,npcm750-adc
* nxp,lpc1850-adc
* nxp,lpc3220
* sprd,sc2720-adc
* st,stmpe-adc
* ti,adc12138
* ti,ads1015
* ti,ads7950
* ti,twl4030-madc

Features
--------

* adxrs290
  - Add triggered buffer support and expose data ready signal as a possible
    trigger. Includes updating bindings.
  - Add debugfs hooks for register access.
* mlx90632
  - Add a clear user interface to override the measured ambient temperature.
* vl53l0x
  - Add IRQ support including dt bindings.

Cleanups and minor fixes
------------------------
(groups)
Replace mlock with local lock:
  * adf4350
  * exynos-adc
  * fls-imx25-gcq
  * stm32-dac

devm use to simplify probe error handling and remove functions.
  * adis16201
  * adis16203
  * adis16209
  * adis16240
  * adis16136
  * adis16260
  * adis16400
  * adis16460
  * adis16480
  * adis library - drop unused adis_setup_buffer_and_trigger()

of_match_ptr removal and incorrect ACPI binding removal
  of_match_ptr() rarely makes sense in an IIO driver as space saving
  is trivial and it breaks ACPI PRP0001 based instantiation.
  Mostly this series is about removing examples that get copied into new
  drivers.
  * ad2s1200
  * ad5272
  * ad5446
  * ad5592r
  * ad5593r
  * ad5703
  * ak8974
  * ak8975
  * ams-iaq-core
  * as3935
  * atlas-sensor
  * ds1803
  * hdc100x
  * htu21
  * icp10100
  * lmp91000
  * pulsedlight
  * max30102
  * max5432
  * max5481
  * mcp4018
  * mcp4131
  * mcp4531
  * mcp4725
  * ms5611
  * ms5637
  * si7020
  * sgp30
  * ti-dac082s085
  * ti-dac5571
  * tmp007
  * tsys01
  * vz89x
  * zpa2326

kernel-doc fixes
  * iio-core
  * ad7303
  * ad7947
  * adis16080
  * adis16400
  * iio_dummy_evgen
  * sgp30

Fixes for buffer alignment when passed to iio_push_to_buffers_with_timestam=
p()
This is a long running effort.  There are a few more drivers to come.
  * inv_mpu6050
  * itg3200
  * si1145
  * st_lsm6dsx
  * ti-adc0832
  * ti-adc12138

(not driver focused)
* MAINTAINERS
  - Consolidate Analog Device IIO entries whilst removing Beniamin Bia.
  - Remove Hartmut Knaack as a listed IIO maintainer as he hasn't been
    active for a long time and people are getting intermitted bounces.
* Add __printf() markings to a few functions that were missing them.
* drop some rotted documentation from staging.
* rework buffer sysfs file creation (precursor to multiple buffer support)

(individual drivers)
* ad5592r
  - Fix use of true for IIO_SHARED_BY_TYPE
  - Tidy up locking and indentation.
* ad9467
  - Improve error message on chip-id missmatch.
  - Use more appropriate error value if chip-id not recognised.
* adis-library
  - Simplify burst mode handling.
* adxrs290
  - Make sure to switch device to standby mode during remove.
* as73211
  - Increase measurement timeout as seems some devices are slower.
* bma180
  - Fix use of true fo IIO_SHARED_BY_TYPE
* exynos_adc
  - Update binding to require second interrut with touch screen.
  - Update binding to not require syscon on S5Pv210
* hmc5843
  - Fix use of true for IIO_SHARED_BY_TYPE
* inv_mpu6050
  - Use regmap_noinc_read() for fifo reading.
* palmas_gpadc
  - Use module_platform_driver() to remove boilerplate.
* meson-saradc
  - style consistency fixes
* rockchip_saradc
  - Allow compile testing with !ARM.
* st_lsm6dsx
  - Changing scaling factor to use IIO_VAL_INT_PLUS_NANO to improve precisi=
on.
  - Fix an issue with unchecked return value.
* stm32-adc
  - Fix a missing return introduced in dev_err_probe() patch earlier in
    cycle.
* sx9310
  - Prefer async mode for probe as paticularly slow startup.
* vcnl4000
  - Add missing interrupt property to dt binding.

----------------------------------------------------------------
Alex Dewar (1):
      iio: adc: rockchip_saradc: Allow compile-testing with !ARM

Alexandru Ardelean (5):
      iio: adc: ad9467: refine mismatch vs unknown chip-id messages
      iio: adc: ad9467: return ENODEV vs EINVAL in ad9467_setup()
      iio: buffer: split buffer sysfs creation to take buffer as primary arg
      iio: dac: ad5592r: un-indent code-block for scale read
      iio: dac: ad5592r: localize locks only where needed in ad5592r_read_r=
aw()

Christian Eggers (1):
      iio: light: as73211: Increase measurement timeout

Crt Mori (1):
      iio: temperature: mlx90632: Interface to change object ambient temper=
ature

Douglas Anderson (1):
      iio: sx9310: Prefer async probe

Ivan Drobyshevskyi (2):
      dt-bindings: iio: proximity: vl53l0x: Add IRQ support
      iio: proximity: vl53l0x: Add IRQ support

Jonathan Cameron (76):
      dt-bindings: iio: adc: ti,adc12138 yaml conversion.
      dt-bindings: iio: adc: ti,ads7950 binding conversion
      staging:iio:dac:max517 remove documentation
      staging:iio:light: Move tsl2x7x ABI docs to correct location.
      staging:iio:light: drop stale ABI docs
      staging:iio:documentation: Drop most generic docs
      iio:imu:adis16400: Sort out missing kernel doc.
      iio:potentiometer:ad5272: Drop of_match_ptr and CONFIG_OF protections.
      iio:potentiometer:ds1803: Drop of_match_ptr and CONFIG_OF protections
      iio:potentiometer:max5432: Drop of_match_ptr and use generic fw acces=
sors
      iio:potentiometer:max5481: Drop of_match_ptr and CONFIG_OF protection=
s.
      iio:potentiometer:max5481: Drop invalid ACPI binding.
      iio:potentiometer:mcp4018: Drop of_match_ptr and CONFIG_OF protection=
s.
      iio:potentiometer:mcp4131: Drop of_match_ptr and use generic fw inter=
faces.
      iio:potentiometer:mcp4531: Drop of_match_ptr and CONFIG_OF protection=
s.
      iio:dac:ad5446: Drop of_match_ptr and CONFIG_OF protections
      iio:dac:ad5592r: Drop of_match_ptr and ACPI_PTR protections.
      iio:dac:ad5593r: Drop of_match_ptr and ACPI_PTR protections.
      iio:dac:ad7303: Drop of_match_ptr protection
      iio:dac:mcp4725: drop of_match_ptr and use generic fw properties
      iio:dac:ti-dac082s085: Drop of_match_ptr and CONFIG_OF protections
      iio:dac:ti-dac5571: Drop of_match_ptr and CONFIG_OF protections
      iio:potentiostat:lmp91000: Drop of_match_ptr and use generic fw acces=
sors
      iio:pressure:icp10100: Drop of_match_ptr and CONFIG_OF protections
      iio:pressure:ms5611: Drop of_match_ptr and CONFIG_OF protections
      iio:pressure:ms5637: Drop of_match_ptr protection
      iio:pressure:zpa2326: Drop of_match_ptr protection
      iio:temperature:tsys01: Drop of_match_ptr protection
      iio:temperature:tmp007: Drop of_match_ptr protection
      iio:resolver:ad2s1200: Drop of_match_ptr protection
      iio:chemical:ams-iaq-core: Drop of_match_ptr protection
      iio:chemical:atlas-sensor: Drop of_match_ptr and use generic fw acces=
sors
      iio:chemical:sgp30: Use local variable dev to simplify code
      iio:chemical:sgp30: Drop of_match_ptr and use generic fw accessors
      iio:chemical:vz89x: Introduce local struct device pointer.
      iio:chemical:vz89x: Drop of_match_ptr protection and use generic fw a=
ccessors
      iio:humidity:hdc100x: Drop of_match_ptr protection.
      iio:proximity:as3935: Use local struct device pointer to simplify cod=
e.
      iio:proximity:as3935: Drop of_match_ptr and use generic fw accessors
      iio:proximity:pulsedlight: Drop of_match_ptr protection
      iio:magn:ak8975: Drop of_match_ptr and ACPI_PTR protections.
      iio:magn:ak8974: Drop of_match_ptr protection
      iio:humidity:htu21: Drop of_match_ptr protection
      iio:humidity:si7020: Drop of_match_ptr protection
      iio:health:max30102: Drop of_match_ptr and use generic fw accessors
      iio:dac:ad5592r: Fix use of true for IIO_SHARED_BY_TYPE
      iio:core: Tidy up kernel-doc.
      iio: Add __printf() attributes to various allocation functions
      iio:magn:hmc5843: Fix passing true where iio_shared_by enum required.
      iio:accel:bma180: Fix use of true when should be iio_shared_by enum
      dt-bindings:iio:adc:fsl,vf610-adc conversion to yaml.
      dt-bindings:iio:adc:ti,twl4030-madc yaml conversion
      dt-bindings:iio:adc:st,stmpe-adc yaml conversion
      dt-bindings:iio:adc: aspeed,ast2400 yaml conversion
      dt-bindings:iio:adc:marvell,berlin2-adc yaml conversion
      dt-bindings:iio:adc:sprd,sc2720-adc yaml conversion.
      dt-bindings:iio:adc:nuvoton,nau7802 yaml conversion
      dt-bindings:iio:adc:nuvoton,npcm750-adc yaml conversion
      dt-bindings:iio:adc:cosmic,10001-adc yaml conversion
      dt-bindings:iio:adc:ti,ads1015 yaml conversion
      dt-bindings:iio:adc:fsl,imx7d-adc yaml conversion
      dt-bindings:iio:adc:fsl,imx25-gcq yaml conversion
      dt-bindings:iio:adc:nxp,lpc1850-adc yaml conversion
      dt-bindings:iio:adc:nxp,lpc3220-adc yaml conversion
      dt-bindings:iio:adc:motorola,cpcap-adc yaml conversion
      dt-bindings:iio:adc:dlg,da9150-gpadc yaml conversion
      dt-bindings:iio:adc:adi,ad7949 yaml conversion
      dt-bindings:iio:adc:adi,ad7768-1 yaml conversion
      dt-bindings:iio:adc:holt,hi8435 yaml conversion
      iio:gyro:itg3200: Fix timestamp alignment and prevent data leak.
      iio:light:si1145: Fix timestamp alignment and prevent data leak.
      iio:imu:st_lsm6dsx Fix alignment and data leak issues
      iio:adc:ti-adc0832 Fix alignment issue with timestamp
      iio:adc:ti-adc12138 Fix alignment issue with timestamp
      iio:imu:inv_mpu6050 Fix dma and ts alignment and data leak issues.
      iio:imu:inv_mpu6050: Use regmap_noinc_read for fifo reads.

Krzysztof Kozlowski (6):
      MAINTAINERS: Consolidate Analog Devices IIO entries and remove Beniam=
in Bia
      MAINTAINERS: Move Hartmut Knaack to Credits
      iio: adc: stm32: Fix missing return in booster error path
      dt-bindings: iio: adc: exynos-adc: require second interrupt with touc=
h screen
      dt-bindings: iio: adc: exynos-adc: do not require syscon on S5Pv210
      dt-bindings: iio: vishay,vcnl4000: add interrupts property

Lee Jones (6):
      iio: dac: ad7303: Complete 'struct ad7303_state' doc
      iio: dac: ad5064: Fix a few kerneldoc misdemeanours
      iio: adc: ad7949: Fix misspelling issue
      iio: dummy: iio_dummy_evgen: Demote file header and supply descriptio=
n for 'irq_sim_domain'
      iio: gyro: adis16080: Fix formatting issue
      iio: chemical: sgp30: Add description for sgp_read_cmd()'s 'duration_=
us'

Liu Shixin (1):
      iio: adc: palmas_gpadc: use module_platform_driver to simplify the co=
de

Mario Tesi (1):
      iio: imu: st_lsm6dsx: Scaling factor type set to IIO_VAL_INT_PLUS_NANO

Martin Blumenstingl (1):
      iio: adc: meson-saradc: Make the of_device_id array style consistent

Nishant Malpani (4):
      iio: gyro: adxrs290: use hook for devm resource unwinding
      iio: gyro: adxrs290: Add triggered buffer support
      dt-bindings: iio: gyro: adxrs290: Add interrupts support
      iio: gyro: adxrs290: Add debugfs register access support

Nuno S=C3=A1 (14):
      iio: adis16201: Use Managed device functions
      iio: adis16209: Use Managed device functions
      iio: adis16136: Use Managed device functions
      iio: adis16260: Use Managed device functions
      iio: adis16400: Use Managed device functions
      iio: adis16460: Use Managed device functions
      iio: adis16480: Use Managed device functions
      staging: iio: adis16203: Use Managed device functions
      staging: iio: adis16240: Use Managed device functions
      iio: adis: Drop non Managed device functions
      iio: adis: Move burst mode into adis_data
      iio: adis16400: Drop adis_burst usage
      iio: adis16475: Drop adis_burst usage
      iio: adis. Drop adis_burst struct

Sergiu Cuciurean (5):
      iio: stm32-dac: Replace indio_dev->mlock with own device lock
      iio: dac: ti-dac7612: Replace indio_dev->mlock with own device lock
      iio: frequency: adf4350: Replace indio_dev->mlock with own device lock
      iio: adc: fsl-imx25-gcq: Replace indio_dev->mlock with own device lock
      iio: adc: exynos_adc: Replace indio_dev->mlock with own device lock

Tom Rix (1):
      iio:imu:st_lsm6dsx: check st_lsm6dsx_shub_read_output return

 CREDITS                                            |   4 +
 Documentation/ABI/testing/sysfs-bus-iio            |   8 +
 .../ABI/testing/sysfs-bus-iio-light-tsl2772        |   0
 .../devicetree/bindings/iio/adc/ad7949.txt         |  16 --
 .../devicetree/bindings/iio/adc/adi,ad7768-1.txt   |  41 ---
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |  89 ++++++
 .../devicetree/bindings/iio/adc/adi,ad7949.yaml    |  57 ++++
 .../devicetree/bindings/iio/adc/ads1015.txt        |  73 -----
 .../bindings/iio/adc/aspeed,ast2400-adc.yaml       |  55 ++++
 .../devicetree/bindings/iio/adc/aspeed_adc.txt     |  22 --
 .../devicetree/bindings/iio/adc/berlin2_adc.txt    |  19 --
 .../devicetree/bindings/iio/adc/cc10001_adc.txt    |  22 --
 .../bindings/iio/adc/cosmic,10001-adc.yaml         |  59 ++++
 .../devicetree/bindings/iio/adc/cpcap-adc.txt      |  17 --
 .../devicetree/bindings/iio/adc/da9150-gpadc.txt   |  16 --
 .../bindings/iio/adc/dlg,da9150-gpadc.yaml         |  35 +++
 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  57 ----
 .../devicetree/bindings/iio/adc/fsl,imx25-gcq.yaml | 131 +++++++++
 .../devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml |  62 +++++
 .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml |  81 ++++++
 .../devicetree/bindings/iio/adc/hi8435.txt         |  21 --
 .../devicetree/bindings/iio/adc/holt,hi8435.yaml   |  50 ++++
 .../devicetree/bindings/iio/adc/imx7d-adc.txt      |  24 --
 .../devicetree/bindings/iio/adc/lpc1850-adc.txt    |  20 --
 .../devicetree/bindings/iio/adc/lpc32xx-adc.txt    |  21 --
 .../bindings/iio/adc/marvell,berlin2-adc.yaml      |  50 ++++
 .../bindings/iio/adc/motorola,cpcap-adc.yaml       |  53 ++++
 .../bindings/iio/adc/nuvoton,nau7802.yaml          |  50 ++++
 .../bindings/iio/adc/nuvoton,npcm-adc.txt          |  26 --
 .../bindings/iio/adc/nuvoton,npcm750-adc.yaml      |  64 +++++
 .../bindings/iio/adc/nuvoton-nau7802.txt           |  18 --
 .../bindings/iio/adc/nxp,lpc1850-adc.yaml          |  61 +++++
 .../bindings/iio/adc/nxp,lpc3220-adc.yaml          |  50 ++++
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |  15 +-
 .../bindings/iio/adc/sprd,sc2720-adc.yaml          |  72 +++++
 .../bindings/iio/adc/sprd,sc27xx-adc.txt           |  40 ---
 .../devicetree/bindings/iio/adc/st,stmpe-adc.yaml  |  45 ++++
 .../devicetree/bindings/iio/adc/stmpe-adc.txt      |  21 --
 .../devicetree/bindings/iio/adc/ti,adc12138.yaml   |  86 ++++++
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    | 112 ++++++++
 .../devicetree/bindings/iio/adc/ti,ads7950.yaml    |  65 +++++
 .../bindings/iio/adc/ti,twl4030-madc.yaml          |  48 ++++
 .../devicetree/bindings/iio/adc/ti-adc12138.txt    |  37 ---
 .../devicetree/bindings/iio/adc/ti-ads7950.txt     |  23 --
 .../devicetree/bindings/iio/adc/twl4030-madc.txt   |  24 --
 .../devicetree/bindings/iio/adc/vf610-adc.txt      |  36 ---
 .../bindings/iio/gyroscope/adi,adxrs290.yaml       |   6 +
 .../bindings/iio/light/vishay,vcnl4000.yaml        |   4 +
 .../devicetree/bindings/iio/proximity/vl53l0x.txt  |   6 +
 MAINTAINERS                                        |  56 +---
 drivers/iio/accel/adis16201.c                      |  26 +-
 drivers/iio/accel/adis16209.c                      |  25 +-
 drivers/iio/accel/bma180.c                         |   2 +-
 drivers/iio/adc/Kconfig                            |   2 +-
 drivers/iio/adc/ad7949.c                           |   2 +-
 drivers/iio/adc/ad9467.c                           |   5 +-
 drivers/iio/adc/exynos_adc.c                       |  20 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |  15 +-
 drivers/iio/adc/meson_saradc.c                     |  11 +-
 drivers/iio/adc/palmas_gpadc.c                     |  13 +-
 drivers/iio/adc/stm32-adc-core.c                   |   2 +-
 drivers/iio/adc/ti-adc0832.c                       |  11 +-
 drivers/iio/adc/ti-adc12138.c                      |  13 +-
 drivers/iio/chemical/ams-iaq-core.c                |   3 +-
 drivers/iio/chemical/atlas-sensor.c                |  10 +-
 drivers/iio/chemical/sgp30.c                       |  29 +-
 drivers/iio/chemical/vz89x.c                       |  18 +-
 drivers/iio/dac/ad5064.c                           |   6 +-
 drivers/iio/dac/ad5446.c                           |   5 +-
 drivers/iio/dac/ad5592r-base.c                     |  56 ++--
 drivers/iio/dac/ad5592r.c                          |   7 +-
 drivers/iio/dac/ad5593r.c                          |   7 +-
 drivers/iio/dac/ad7303.c                           |   6 +-
 drivers/iio/dac/mcp4725.c                          |  29 +-
 drivers/iio/dac/stm32-dac.c                        |  13 +-
 drivers/iio/dac/ti-dac082s085.c                    |   5 +-
 drivers/iio/dac/ti-dac5571.c                       |   7 +-
 drivers/iio/dac/ti-dac7612.c                       |  14 +-
 drivers/iio/dummy/iio_dummy_evgen.c                |   4 +-
 drivers/iio/frequency/adf4350.c                    |  21 +-
 drivers/iio/gyro/Kconfig                           |   2 +
 drivers/iio/gyro/adis16080.c                       |   2 +-
 drivers/iio/gyro/adis16136.c                       |  37 +--
 drivers/iio/gyro/adis16260.c                       |  33 +--
 drivers/iio/gyro/adxrs290.c                        | 298 +++++++++++++++++=
++--
 drivers/iio/gyro/itg3200_buffer.c                  |  15 +-
 drivers/iio/health/max30102.c                      |  11 +-
 drivers/iio/humidity/hdc100x.c                     |   3 +-
 drivers/iio/humidity/htu21.c                       |   3 +-
 drivers/iio/humidity/si7020.c                      |   3 +-
 drivers/iio/imu/adis16400.c                        |  72 +++--
 drivers/iio/imu/adis16460.c                        |  25 +-
 drivers/iio/imu/adis16475.c                        |  18 +-
 drivers/iio/imu/adis16480.c                        |  55 ++--
 drivers/iio/imu/adis_buffer.c                      |  76 +-----
 drivers/iio/imu/adis_trigger.c                     |  60 -----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  12 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  14 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   6 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  42 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 134 +++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   2 +
 drivers/iio/industrialio-buffer.c                  |  46 ++--
 drivers/iio/industrialio-core.c                    |   4 +-
 drivers/iio/industrialio-trigger.c                 |   3 +-
 drivers/iio/light/as73211.c                        |   5 +-
 drivers/iio/light/si1145.c                         |  19 +-
 drivers/iio/magnetometer/ak8974.c                  |   3 +-
 drivers/iio/magnetometer/ak8975.c                  |   8 +-
 drivers/iio/magnetometer/hmc5843_core.c            |   4 +-
 drivers/iio/potentiometer/ad5272.c                 |   5 +-
 drivers/iio/potentiometer/ds1803.c                 |   6 +-
 drivers/iio/potentiometer/max5432.c                |   8 +-
 drivers/iio/potentiometer/max5481.c                |  23 +-
 drivers/iio/potentiometer/mcp4018.c                |  12 +-
 drivers/iio/potentiometer/mcp4131.c                |   8 +-
 drivers/iio/potentiometer/mcp4531.c                |  11 +-
 drivers/iio/potentiostat/lmp91000.c                |  11 +-
 drivers/iio/pressure/icp10100.c                    |   3 +-
 drivers/iio/pressure/ms5611_i2c.c                  |   6 +-
 drivers/iio/pressure/ms5611_spi.c                  |   6 +-
 drivers/iio/pressure/ms5637.c                      |   3 +-
 drivers/iio/pressure/zpa2326_i2c.c                 |   6 +-
 drivers/iio/pressure/zpa2326_spi.c                 |   6 +-
 drivers/iio/proximity/as3935.c                     |  44 ++-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |   3 +-
 drivers/iio/proximity/sx9310.c                     |   7 +
 drivers/iio/proximity/vl53l0x-i2c.c                | 104 ++++++-
 drivers/iio/resolver/ad2s1200.c                    |   3 +-
 drivers/iio/temperature/mlx90632.c                 |   9 +-
 drivers/iio/temperature/tmp007.c                   |   4 +-
 drivers/iio/temperature/tsys01.c                   |   3 +-
 drivers/staging/iio/Documentation/dac/max517       |  41 ---
 drivers/staging/iio/Documentation/device.txt       |  74 -----
 drivers/staging/iio/Documentation/overview.txt     |  57 ----
 drivers/staging/iio/Documentation/ring.txt         |  47 ----
 .../staging/iio/Documentation/sysfs-bus-iio-light  |  79 ------
 drivers/staging/iio/Documentation/trigger.txt      |  31 ---
 drivers/staging/iio/accel/adis16203.c              |  26 +-
 drivers/staging/iio/accel/adis16240.c              |  25 +-
 include/linux/iio/iio.h                            |   3 +-
 include/linux/iio/imu/adis.h                       |  53 +---
 include/linux/iio/trigger_consumer.h               |   2 +-
 include/linux/iio/types.h                          |   1 +
 144 files changed, 2382 insertions(+), 1818 deletions(-)
 rename drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2x7x=
 =3D> Documentation/ABI/testing/sysfs-bus-iio-light-tsl2772 (100%)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.=
txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.=
yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7949.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ads1015.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast240=
0-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/cc10001_adc.t=
xt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cosmic,10001-=
adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/da9150-gpadc.=
txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/dlg,da9150-gp=
adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq=
.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq=
.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc=
.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/hi8435.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/holt,hi8435.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/lpc1850-adc.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/lpc32xx-adc.t=
xt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/marvell,berli=
n2-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/motorola,cpca=
p-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nau78=
02.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-=
adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm7=
50-adc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton-nau78=
02.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,lpc1850-a=
dc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-a=
dc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc2720-a=
dc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/sprd,sc27xx-a=
dc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc12138.y=
aml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1015.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7950.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl4030-ma=
dc.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads7950.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/twl4030-madc.=
txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
 delete mode 100644 drivers/staging/iio/Documentation/dac/max517
 delete mode 100644 drivers/staging/iio/Documentation/device.txt
 delete mode 100644 drivers/staging/iio/Documentation/overview.txt
 delete mode 100644 drivers/staging/iio/Documentation/ring.txt
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-light
 delete mode 100644 drivers/staging/iio/Documentation/trigger.txt
