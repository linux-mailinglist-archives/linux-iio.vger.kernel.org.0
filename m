Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A15058B1C
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2019 21:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfF0Ttu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jun 2019 15:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfF0Ttt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Jun 2019 15:49:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3611D20665;
        Thu, 27 Jun 2019 19:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561664988;
        bh=dySYDwDbfBvRAri9nie8pkZ2kL3XhXlZigeFBG/iUSc=;
        h=Date:From:To:Subject:From;
        b=d3FC2DvMBJSKvS3iKbag20qodwr6uXjl+aFNxC3urM7qdaA8Ydx9KUb9ym/nvTVjt
         Td8Ma2C1RrgLsPl8fAIiF6BJTqnfdzwGP0BLUOTZ66gOV7dfuI/iTIKtrkahU2kB+O
         N+dRZ4IU5X/HeMq/AJnebMeFuZx9VYoujfOm+nuM=
Date:   Thu, 27 Jun 2019 20:49:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PULL] Second set of IIO new device support, features and cleanups
 for the 5.3 cycle.
Message-ID: <20190627204945.104a3af2@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 1f48d056287d58f425c4f36705764f2ba802feba:

  MAINTAINERS: Add entry for anybuss drivers (2019-05-24 21:20:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.3b

for you to fetch changes up to 208a68c8393d6041a90862992222f3d7943d44d6:

  iio: iio-utils: Fix possible incorrect mask calculation (2019-06-27 20:38=
:19 +0100)

----------------------------------------------------------------
Second set of IIO device support, features, cleanups and minor fixes for 5.=
3.

A few bits for the counters subsystem mixed in here as well.
There are some late breaking fixes as well, which aren't so urgent
they can't wait for the merge window.

New Device Support
* adf4371
  - New driver + bindings.
  - Support the adf4372 PLL. Mostly ID and bindings.
* ad8366 (note includes rework of driver needed to allow support for these).
  - Support the ADL5240 variable gain amplifier (VGA).
  - Support the ADA4961 digital gain amplifier (DGA).
* dps310
  - New driver, in several parts from different authors for this temp
    and pressure sensor.
  - Includes errata workaround for a temperature reading issue.
* stk3310
  - Support the stk3335, mostly ID.

Features and cleanups
* core
  - drop error handling on debugfs registration.
  - harden by making sure we don't overrun iio_chan_info_postfix.
* docs
  - convert remaining docs to rst. At somepoint we'll fit these few
    into the main IIO docs.
  - improve sampling_frequency_available docs but explaining the
    range form.
* ad_sigma_delta
  - Drop a pointless goto.
* ad2s1210
  - Drop pointless platform data null check seeing as we don't actually
    use platform data anymore.
* ad7124
  - Relax limitation on channel numbers to allow pseudo different channels.
  - Support control of whether the input is buffered via DT.
  - Use dynamic allocation for channel configuration to make it easier
    to support new devices.
  - YAML binding conversion.
* ad7150
  - Comment tidy up.
  - Consistent and simple if (ret) handling of i2c errors.
  - FIELD_GET and GENMASK.
  - Ternary rather than !!(condition) for readability.
  - Use macros to avoid repetition of channel definitions.
* ad7606
  - Add software channel config (rather that pin controlled)
  - Refactor to simplify addition of new part in future.
* ad7746
  - of_deivce_id table.
* ad7780
  - MAINTAINERS entry
  - YAML DT bindings.
* ad8366
  - Stop using core mlock in favour of well scoped local lock.
  - SPDX + copyright date update.
* ad9834
  - of_device_id table
* adf4371
  - Add support for output stage muting before lock on has occured.
* adis library
  - MAINTAINERS entry to reflect that this now Alexandru's problem ;)
* adis162xx:
  - Fix a slightly incorrect set of comments and print statements on
    minimum supported voltage.
* adis16203
  - of_device_id table.
* adis16240
  - Add of_device_id table (in two parts as first patch only used it for
    MODULE_DEVICE_TABLE.)
* adt7316-spi
  - of_device_id table
* adxl372
  - YAML DT binding conversion.
  - Cleanup use of buffer callback functions (precursor to core rework).
* bh1710
  - Simplify getting the i2c adapter from the client.
* dht11
  - Mote to newer GPIO consumer interface.
* kxcjk-1013.c
  - Add binding for sensor in display of some ultrabooks after userspace
    tools updated for it not be a problem to report two similar sensors.
* imx7d
  - drop unused variables.
  - white space
  - define instead of variable for clock frequency that is fixed.
  - drop pointless error message.
* messon_saradc
  - SPDX
* sps30
  - MAINTAINERS entry
  - YAML binding conversion.
* st_accel
  - Tidy up ordering in various buffer related callbacks. This is
    part of a long running effort to simplify the core code.
* stm32-dfsdm:
  - Manage the resolution cleanly in triggerd modes.
  - Add fast mode support which allows more flexible filter choices.
  - Add a comment on the reason for a 16 bit record when technically
    not 'required'.
* st_lsm6dsx
  - Embed device name in the sensor_settings struct as i3c doesn't
    have a convenient name field to use for this.
* xilinx-adc
  - Relax constraints on supported platforms to reflect that this
    can used with FPGAs on PCIe cards and hence many architectures.
* counters/ftm-quaddec
  - Fix some formatting io MODULE_AUTHOR
  - MAINTAINERS entry

Fixes
* tools
  - fix incorrect handling of 32 bit channels.
* sca3000
  - Potential endian bug that is unlikely to bite anyone (be64 host
    seems unlikely for this old part).
* stm32-adc
  - Add vdda-supply. On some boards it needs to be turned on to supply
    the ADC.  DT bindings included.
* stm32-dfsdm
  - Fix output resolution to work with filter orders other than 3.
  - Fix output datatype as it's signed and previously claimed not to be.

----------------------------------------------------------------
Alexandru Ardelean (10):
      staging: iio: ad2s1210: Remove platform data NULL check in probe
      iio: adxl372: fix iio_triggered_buffer_{pre,post}enable positions
      iio: amplifiers: update license information
      iio: amplifiers: ad8366: use own lock to guard state
      iio: amplifiers: ad8366: rework driver to allow other chips
      iio: amplifiers: ad8366: Add support for ADL5240 VGA
      iio: ad_sigma_delta: return directly in ad_sd_buffer_postenable()
      iio: st_accel: fix iio_triggered_buffer_{pre,post}enable positions
      iio: adis162xx: fix low-power docs & reports
      MAINTAINERS: add ADIS IMU driver library entry

Bastien Nocera (1):
      iio: iio-utils: Fix possible incorrect mask calculation

Beniamin Bia (2):
      iio: adc: ad7606: Move oversampling and scale options to chip info
      iio: adc: ad7606: Add software configuration

B=C3=A1rbara Fernandes (2):
      staging: iio: cdc: ad7150: create macro for capacitance channels
      staging: iio: adt7316: create of_device_id array

Christopher Bostic (1):
      iio: dps310: Temperature measurement errata

Dan Carpenter (1):
      iio: sca3000: Potential endian bug in sca3000_read_event_value()

Eddie James (1):
      iio: dps310: Add pressure sensing capability

Fabien Lahoudere (1):
      docs: iio: add precision about sampling_frequency_available

Fabio Estevam (4):
      iio: imx7d_adc: Remove unneeded error message
      iio: imx7d_adc: Introduce a definition for the input clock
      iio: imx7d_adc: Fit into a single line
      iio: imx7d_adc: Remove unneeded 'average_en' member

Fabrice Gasnier (2):
      dt-bindings: iio: adc: stm32: add missing vdda supply
      iio: adc: stm32-adc: add missing vdda-supply

Greg Kroah-Hartman (1):
      iio: core: no need to check return value of debugfs_create functions

Joel Stanley (1):
      iio: Add driver for Infineon DPS310

Jo=C3=A3o Seckler (1):
      staging: iio: ad7746: add device tree support

Jo=C3=A3o Victor Marques de Oliveira (1):
      staging: iio: ad9834: add of_device_id table

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: get device name from st_lsm6dsx_sensor_settings

Lucas Oshiro (2):
      staging: iio: adis16240: add device to module device table
      dt-bindings: iio: accel: adxl372: switch to YAML bindings

Lu=C3=ADs Ferreira (1):
      iio: accel: add missing sensor for some 2-in-1 based ultrabooks

Martijn Braam (1):
      iio: light: stk3310: Add support for stk3335

Mauro Carvalho Chehab (1):
      docs: iio: convert to ReST

Melissa Wen (4):
      staging: iio: ad7150: use ternary operating to ensure 0/1 value
      staging: iio: ad7150: use FIELD_GET and GENMASK
      staging: iio: ad7150: simplify i2c SMBus return treatment
      staging: iio: ad7150: clean up of comments

Mircea Caprioru (5):
      iio: adc: ad7124: Remove input number limitation
      iio: adc: ad7124: Add buffered input support
      iio: adc: ad7124: Shift to dynamic allocation for channel configurati=
on
      Convert AD7124 bindings documentation to YAML format.
      dt-bindings: iio: adc: Add buffered input property

Neil Armstrong (1):
      iio: adc: meson_saradc: update with SPDX Licence identifier

Olivier Moysan (5):
      iio: adc: stm32-dfsdm: fix output resolution
      iio: adc: stm32-dfsdm: fix data type
      iio: adc: stm32-dfsdm: manage data resolution in trigger mode
      iio: adc: stm32-dfsdm: add fast mode support
      iio: adc: stm32-dfsdm: add comment for 16 bits record

Patrick Havelange (2):
      MAINTAINERS: add counter/ftm-quaddec driver entry
      counter/ftm-quaddec: Add missing '>' in MODULE_AUTHOR

Paul Cercueil (1):
      iio: amplifiers: ad8366: Add support for the ADA4961 DGA

Renato Lui Geh (2):
      dt-bindings: iio: adc: add adi,ad7780.yaml binding
      MAINTAINERS: add entry for ad7780 adc driver

Robert Hancock (1):
      iio: adc: xilinx: support all platforms

Rodrigo Ribeiro (1):
      staging: iio: adis16240: add of_match_table entry

Shobhit Kukreti (1):
      iio: humidity: Replace older GPIO APIs with GPIO Consumer APIs for th=
e dht11 sensor

Stefan Popa (5):
      iio: frequency: adf4371: Add support for ADF4371 PLL
      dt-bindings: iio: frequency: Add docs for ADF4371 PLL
      iio: frequency: adf4371: Add support for ADF4372 PLL
      dt-bindings: iio: frequency: Add ADF4372 PLL documentation
      iio: frequency: adf4371: Add support for output stage mute

Thiago Estrela (1):
      staging: iio: adis16203: Add of_device_id table

Tomasz Duszynski (2):
      dt-bindings: iio: chemical: sps30: convert bindings to yaml
      MAINTAINERS: add entry for sensirion sps30 driver

Wolfram Sang (1):
      iio: light: bh1780: simplify getting the adapter of a client

Young Xiao (1):
      iio:core: Fix bug in length of event info_mask and catch unhandled bi=
ts set in masks.

 Documentation/ABI/testing/sysfs-bus-iio            |   7 +-
 .../ABI/testing/sysfs-bus-iio-frequency-adf4371    |  44 ++
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |  63 ++
 .../devicetree/bindings/iio/accel/adxl372.txt      |  33 -
 .../devicetree/bindings/iio/adc/adi,ad7124.txt     |  75 --
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    | 155 ++++
 .../devicetree/bindings/iio/adc/adi,ad7780.txt     |  48 --
 .../devicetree/bindings/iio/adc/adi,ad7780.yaml    |  87 +++
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   1 +
 .../bindings/iio/chemical/sensirion,sps30.txt      |  12 -
 .../bindings/iio/chemical/sensirion,sps30.yaml     |  39 +
 .../devicetree/bindings/iio/frequency/adf4371.yaml |  63 ++
 .../iio/{ep93xx_adc.txt =3D> ep93xx_adc.rst}         |  15 +-
 .../iio/{iio_configfs.txt =3D> iio_configfs.rst}     |  52 +-
 Documentation/iio/index.rst                        |  12 +
 MAINTAINERS                                        |  38 +-
 drivers/counter/ftm-quaddec.c                      |   4 +-
 drivers/iio/Kconfig                                |   2 +-
 drivers/iio/accel/adis16201.c                      |   4 +-
 drivers/iio/accel/adis16209.c                      |   4 +-
 drivers/iio/accel/adxl372.c                        |  27 +-
 drivers/iio/accel/kxcjk-1013.c                     |   1 +
 drivers/iio/accel/sca3000.c                        |   7 +-
 drivers/iio/accel/st_accel_buffer.c                |  22 +-
 drivers/iio/adc/Kconfig                            |   1 -
 drivers/iio/adc/ad7124.c                           |  33 +-
 drivers/iio/adc/ad7606.c                           |  97 ++-
 drivers/iio/adc/ad7606.h                           |  17 +-
 drivers/iio/adc/ad_sigma_delta.c                   |   3 +-
 drivers/iio/adc/imx7d_adc.c                        |  24 +-
 drivers/iio/adc/meson_saradc.c                     |   8 +-
 drivers/iio/adc/stm32-adc-core.c                   |  21 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 233 ++++--
 drivers/iio/adc/stm32-dfsdm.h                      |  24 +-
 drivers/iio/amplifiers/Kconfig                     |  12 +-
 drivers/iio/amplifiers/ad8366.c                    | 147 +++-
 drivers/iio/frequency/Kconfig                      |  10 +
 drivers/iio/frequency/Makefile                     |   1 +
 drivers/iio/frequency/adf4371.c                    | 632 ++++++++++++++++
 drivers/iio/humidity/dht11.c                       |  28 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  53 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   3 +-
 drivers/iio/industrialio-core.c                    |  37 +-
 drivers/iio/light/bh1780.c                         |   2 +-
 drivers/iio/light/stk3310.c                        |   6 +-
 drivers/iio/pressure/Kconfig                       |  11 +
 drivers/iio/pressure/Makefile                      |   1 +
 drivers/iio/pressure/dps310.c                      | 827 +++++++++++++++++=
++++
 drivers/staging/iio/accel/adis16203.c              |  12 +-
 drivers/staging/iio/accel/adis16240.c              |   9 +-
 drivers/staging/iio/addac/adt7316-spi.c            |  13 +
 drivers/staging/iio/cdc/ad7150.c                   |  59 +-
 drivers/staging/iio/cdc/ad7746.c                   |  10 +
 drivers/staging/iio/frequency/ad9834.c             |  11 +
 drivers/staging/iio/resolver/ad2s1210.c            |   3 -
 tools/iio/iio_utils.c                              |   4 +-
 58 files changed, 2706 insertions(+), 473 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf43=
71
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl372=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirio=
n,sps30.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirio=
n,sps30.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4371=
.yaml
 rename Documentation/iio/{ep93xx_adc.txt =3D> ep93xx_adc.rst} (71%)
 rename Documentation/iio/{iio_configfs.txt =3D> iio_configfs.rst} (73%)
 create mode 100644 Documentation/iio/index.rst
 create mode 100644 drivers/iio/frequency/adf4371.c
 create mode 100644 drivers/iio/pressure/dps310.c
