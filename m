Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1711CFDE3
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgELS6G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 14:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELS6G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 May 2020 14:58:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D934207BC;
        Tue, 12 May 2020 18:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589309885;
        bh=TUm2Aztl1iyTKdD4z+uDUeY2Qb2n9yj2Y/UEmd7gSBw=;
        h=Date:From:To:Subject:From;
        b=GjrBBB/Xxxsk2q1WWbSi74TB9gesxjGTJ061i4h2kZ+007fW3FTdOWFtoC9S4S+Jo
         Q3fjFpD+1HKg9qOYMrPbLACiog/utnaEb2/EyDg+JHFhDdp0E5vmFFtLN4mmIgcxnT
         n/VkH752HZTx+4Ea1ASKQ4PTQ5JvI/2J7fa/v2+k=
Date:   Tue, 12 May 2020 19:58:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO new device support, features and cleanups for
 the 5.8 cycle.
Message-ID: <20200512195801.28e6fafe@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit bf42304b55f59af5e71c86e46291705023dce62e:

  staging: vt6656: Use fls instead of for loop in vnt_update_top_rates (202=
0-04-23 13:39:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.8b

for you to fetch changes up to 6b46ddb51eab245c64b6b9c55c189e45967d213f:

  iio: light: ltr501: Constify structs (2020-05-11 20:19:19 +0100)

----------------------------------------------------------------
Second set of new device support, cleanups and features for IIO in the 5.8 =
cycle

Usual mixed back but with a few subsystem wide or device type
wide cleanups.

New device support

* adis16475
  - New driver supporting adis16470, adis16475, adis16477, adis16465,
    adis16467, adis16500, adis16505 and adis16507.
    Includes some rework of the adis library to simplify using it
    for this new driver.
* ak8974
  - Add support for Alps hscdt008a. ID only. Related patches add support
    for scale.
* atlas-sensor
  - Add support for RTD-SM OEM temperature sensor.
* cm32181
  - Add support for CM3218 including support for SMBUS alert via
    ACPI resources.
* ltc2632
  - Add support for ltc2634-12/10/8 DACS including handling per
    device type numbers of channels.

Major Features

* cm32181
  - ACPI bindings including parsing CPM0 and CPM1 custom ACPI tables.
    Includes minor tidy ups and fixes.
* vcnl4000
  - Add event support
  - Add buffered data capture support
  - Add control of sampling frequency

Cleanups and minor fixes.

* core
  - Trivial rework of iio_device_alloc to use an early return and
    improve readability.
  - Precursors to addition of multiple buffer support. So far
    minor refactoring.
* subsystem wide
  - Use get_unaligned_be24 slightly improve readability over open
    coding it.
* adis drivers
  - Use iio_get_debugfs_dentry access function.
* bh1780, cm32181, cm3232, gp2ap02a00f, opt3001, st_uvis25, vl6180,
  dmard06, kxsd9
  - Drop use of of_match_ptr to allow ACPI based probing via PRP0001.
    Part of clear out of this to avoid cut and paste into new drivers.
* ad5592r, ad5593r
  - Fix typos
* ad5933
  - Use managed interfaces to automate error handling and remove.
* ak8974
  - Fix wrong number of 'real bits' for buffered data.
  - Refactor to pull measurement code out as separate function.
    bmp280
  - Fix lack of clamp on range during data capture.
* at91-sama5d2_adc
  - Handle unfinished conversions correctly.
  - Allow use of triggers other than it's own.
  - Reorganize buffer setup and tear down as part of long running
    subsystem wide rework.
* ccs811
  - Add DT binding docs and match table.
  - Support external reset and wakeup pins.
* hid-sensors
  - Reorganize buffer setup and tear down as part of long running
    subsystem wide rework.
* ltr501
  - Constify some structs.
* vcnl4000
  - Fix an endian issue by using explicit byte swapped i2c accessors.

----------------------------------------------------------------
Alexandru Ardelean (6):
      iio: at91-sama5d2_adc: split at91_adc_current_chan_is_touch() helper
      iio: at91-sama5d2_adc: adjust iio_triggered_buffer_{predisable,posten=
able} positions
      iio: buffer: extend short-hand use for 'indio_dev->buffer'
      iio: imu: adis16xxx: use helper to access iio core debugfs dir
      iio: hid-sensors: move triggered buffer setup into hid_sensor_setup_t=
rigger
      staging: iio: ad5933: attach life-cycle of kfifo buffer to parent dev=
ice and use managed calls throughout

Andreas Klinger (1):
      iio: bmp280: fix compensation of humidity

Andy Shevchenko (16):
      iio: adc: ad_sigma_delta: Use {get,put}_unaligned_be24()
      iio: adc: mpc3422: Use get_unaligned_beXX()
      iio: adc: ti-ads124s08: Use get_unaligned_be24()
      iio: dac: ltc2632: Use put_unaligned_be24()
      iio: dac: ad5624r_spi: Use put_unaligned_be24()
      iio: dac: ad5446: Use put_unaligned_be24()
      iio: gyro: adis16130: Use get_unaligned_be24()
      iio: health: afe4403: Use get_unaligned_be24()
      iio: light: si1133: Use get_unaligned_be24()
      iio: light: zopt2201: Use get_unaligned_le24()
      iio: magnetometer: rm3100: Use get_unaligned_be24()
      iio: pressure: hp206c: Use get_unaligned_be24()
      iio: pressure: ms5611: Use get_unaligned_be24()
      iio: pressure: zpa2326: Use get_unaligned_le24()
      iio: temperature: max31856: Use get_unaligned_beXX()
      iio: st_sensors: Use get_unaligned_be24() and sign_extend32()

Chris Ruehl (2):
      iio: documentation ltc2632_chip_info add num_channels
      iio: DAC extension for ltc2634-12/10/8

Christophe JAILLET (2):
      iio: dac: ad5593r: Fix a typo in MODULE_DESCRIPTION
      iio: dac: ad5592r: Fix a typo in the name of a function

Colin Ian King (1):
      iio: adc: ad7476: remove redundant null check on an array

Eugen Hristev (2):
      iio: adc: at91-sama5d2_adc: handle unfinished conversions
      iio: adc: at91-sama5d2_adc: update for other trigger usage

Hans de Goede (11):
      iio: light: cm32181: Switch to new style i2c-driver probe function
      iio: light: cm32181: Add support for ACPI enumeration
      iio: light: cm32181: Add some extra register defines
      iio: light: cm32181: Add support for the CM3218
      iio: light: cm32181: Clean up the probe function a bit
      iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources
      iio: light: cm32181: Change reg_init to use a bitmap of which registe=
rs to init
      iio: light: cm32181: Use units of 1/100000th for calibscale and lux_p=
er_bit
      iio: light: cm32181: Make lux_per_bit and lux_per_bit_base_it runtime=
 settings
      iio: light: cm32181: Add support for parsing CPM0 and CPM1 ACPI tables
      iio: light: cm32181: Fix integartion time typo

Jonathan Cameron (8):
      iio: light: bh1780: use mod_devicetable.h and drop of_match_ptr macro
      iio: light: cm32181: Add mod_devicetable.h and remove of_match_ptr
      iio: light: cm3232: Add mod_devicetable.h include and drop of_match_p=
tr
      iio: light: gp2ap020a00f: Swap of.h for mod_devicetable.h + drop of_m=
atch_ptr
      iio: light: opt3001: Add mod_devicetable.h and drop use of of_match_p=
tr
      iio: light: st_uvis25: Add mod_devicetable.h and drop of_match_ptr
      iio: light: vl6180: add include of mod_devicetable.h and drop of_matc=
h_ptr
      iio: Use an early return in iio_device_alloc to simplify code.

Linus Walleij (3):
      iio: magnetometer: ak8974: Correct realbits
      iio: magnetometer: ak8974: Break out measurement
      iio: magnetometer: ak8974: Provide scaling

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: enable 833Hz sample frequency for tagged sensors

Manivannan Sadhasivam (3):
      dt-bindings: iio: chemical: Add binding for CCS811 VOC sensor
      iio: chemical: Add support for external Reset and Wakeup in CCS811
      iio: chemical: Add OF match table for CCS811 VOC sensor

Mathieu Othacehe (5):
      iio: vcnl4000: Fix i2c swapped word reading.
      iio: vcnl4000: Factorize data reading and writing.
      iio: vcnl4000: Add event support for VCNL4010/20.
      iio: vcnl4000: Add sampling frequency support for VCNL4010/20.
      iio: vcnl4000: Add buffer support for VCNL4010/20.

Matt Ranostay (2):
      dt-bindings: iio: chemical: add Atlas Scientific RTD-SM sensor docs
      iio: chemical: atlas-sensor: add RTD-SM module support

Nick Reitemeyer (2):
      dt-bindings: magnetometer: ak8974: Add Alps hscdtd008a
      iio: magnetometer: ak8974: add Alps hscdtd008a

Nishant Malpani (2):
      iio: accel: dmard06: Use mod_devicetable.h and drop of_match_ptr macro
      iio: accel: kxsd9-i2c: Use mod_devicetable.h and drop of_match_ptr ma=
cro

Nuno S=C3=A1 (6):
      iio: imu: adis: Add Managed device functions
      iio: imu: adis: Add irq flag variable
      iio: adis: Add adis_update_bits() APIs
      iio: adis: Support different burst sizes
      iio: imu: Add support for adis16475
      dt-bindings: iio: Add adis16475 documentation

Rikard Falkeborn (1):
      iio: light: ltr501: Constify structs

 .../bindings/iio/chemical/ams,ccs811.yaml          |   53 +
 .../bindings/iio/chemical/atlas,sensor.yaml        |    2 +
 .../devicetree/bindings/iio/dac/ltc2632.txt        |    8 +-
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |  137 ++
 .../bindings/iio/magnetometer/ak8974.txt           |    4 +-
 MAINTAINERS                                        |    8 +
 drivers/iio/accel/dmard06.c                        |    3 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |   18 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    7 +-
 drivers/iio/adc/ad7476.c                           |    2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |    8 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |  233 ++--
 drivers/iio/adc/mcp3422.c                          |    5 +-
 drivers/iio/adc/ti-ads124s08.c                     |    7 +-
 drivers/iio/chemical/atlas-sensor.c                |   29 +
 drivers/iio/chemical/ccs811.c                      |  112 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   18 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |    3 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    7 +-
 drivers/iio/dac/Kconfig                            |    6 +-
 drivers/iio/dac/ad5446.c                           |    6 +-
 drivers/iio/dac/ad5592r.c                          |    4 +-
 drivers/iio/dac/ad5593r.c                          |    2 +-
 drivers/iio/dac/ad5624r_spi.c                      |    8 +-
 drivers/iio/dac/ltc2632.c                          |   67 +-
 drivers/iio/gyro/adis16130.c                       |    4 +-
 drivers/iio/gyro/adis16136.c                       |   10 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |   18 +-
 drivers/iio/health/afe4403.c                       |   14 +-
 drivers/iio/humidity/hid-sensor-humidity.c         |   12 +-
 drivers/iio/imu/Kconfig                            |   13 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/adis.c                             |   25 +
 drivers/iio/imu/adis16400.c                        |   12 +-
 drivers/iio/imu/adis16460.c                        |   10 +-
 drivers/iio/imu/adis16475.c                        | 1338 ++++++++++++++++=
++++
 drivers/iio/imu/adis16480.c                        |   16 +-
 drivers/iio/imu/adis_buffer.c                      |   58 +-
 drivers/iio/imu/adis_trigger.c                     |   72 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   21 +-
 drivers/iio/industrialio-buffer.c                  |   61 +-
 drivers/iio/industrialio-core.c                    |   38 +-
 drivers/iio/light/Kconfig                          |    2 +
 drivers/iio/light/bh1780.c                         |    6 +-
 drivers/iio/light/cm32181.c                        |  271 +++-
 drivers/iio/light/cm3232.c                         |    3 +-
 drivers/iio/light/gp2ap020a00f.c                   |    6 +-
 drivers/iio/light/hid-sensor-als.c                 |   18 +-
 drivers/iio/light/hid-sensor-prox.c                |   18 +-
 drivers/iio/light/ltr501.c                         |   39 +-
 drivers/iio/light/opt3001.c                        |    3 +-
 drivers/iio/light/si1133.c                         |   18 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    3 +-
 drivers/iio/light/st_uvis25_spi.c                  |    3 +-
 drivers/iio/light/vcnl4000.c                       |  753 ++++++++++-
 drivers/iio/light/vl6180.c                         |    3 +-
 drivers/iio/light/zopt2201.c                       |    4 +-
 drivers/iio/magnetometer/ak8974.c                  |  194 ++-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |   18 +-
 drivers/iio/magnetometer/rm3100-core.c             |    5 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |   18 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |   18 +-
 drivers/iio/pressure/bmp280-core.c                 |    2 +
 drivers/iio/pressure/hid-sensor-press.c            |   18 +-
 drivers/iio/pressure/hp206c.c                      |    8 +-
 drivers/iio/pressure/ms5611_i2c.c                  |    4 +-
 drivers/iio/pressure/ms5611_spi.c                  |    4 +-
 drivers/iio/pressure/zpa2326.c                     |    9 +-
 drivers/iio/temperature/hid-sensor-temperature.c   |   12 +-
 drivers/iio/temperature/max31856.c                 |    5 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   77 +-
 include/linux/iio/imu/adis.h                       |   87 +-
 72 files changed, 3459 insertions(+), 650 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs8=
11.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16475=
.yaml
 create mode 100644 drivers/iio/imu/adis16475.c
