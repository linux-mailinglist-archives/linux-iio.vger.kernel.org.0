Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A86141932
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 20:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgARTgc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 14:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbgARTgb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 14:36:31 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613CB24683;
        Sat, 18 Jan 2020 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579376190;
        bh=kTLxi7ppWw9x+J/dtuURhywkcK2c3hqymu4VTgw8zTo=;
        h=Date:From:To:Cc:Subject:From;
        b=WlG85AstyARGhBZBnR/B6U9JK47AmQCcLtxQjm3crwhPsHwlfrO32oEzFmT4Pg7F7
         /nVX6XgIPUQY43JXTZu87XsvHPnIv6dxf1LxQWlJopnltK4JpZXcINiadYNNhn7evo
         6NHKCN/WUMmdRtSWuuLB+T3TJUzzbPJpcdHBIb/4=
Date:   Sat, 18 Jan 2020 19:36:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO new device support, cleanups and minor
 fixes for the 5.6 cycle.
Message-ID: <20200118193627.2a384228@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit e895bc1ebb31750f3baa74e074617d3cc5d0cee2:

  staging: vc04_services: remove header include path to vc04_services (2020=
-01-10 17:33:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.6b

for you to fetch changes up to d344961f55fd6321937d3bc92ad3930dea31189f:

  iio: dac: stm32-dac: better handle reset controller failures (2020-01-18 =
14:32:01 +0000)

----------------------------------------------------------------
Second set of new device support, features and minor fixes for IIO in the 5=
.6 cycle

Just a small set this time.

As we are very near the merge window, I've rolled a few fixes in here
rather than adding noise just before release.  A short delay here will
do little harm.

New device support
* adis16480
  - Add support for adis16490. After earlier rework this is simple ID plus
    chip info.

Features
* kxcjk1013
  - mount matrix support.
* lsm_6dsx
  - mount matrix support.

Cleanups / minor or late breaking fixes
* ad7124
  - add support to ad-sigma-delta and use it in this driver to allow
    the the interrupt type to be IRQF_TRIGGER_LOW unlike most other devices
    using this framework.
* adis
  - use delay structure now available in SPI to handle transfer delays
  - introduce a timeouts structure to allow support of new devices
* ak8975
  - drop platform data support.  No one is using it and it adds complexity.
  - use device_get_match_data rather than open coding much the same thing.
* dht11
  - drop meaningless todo
* at91-samad2_adc
  - switch to dma_request_chan
* altas-sensor
  - add a helper function to compute number of channels.  Needed for new de=
vice
    support that is under review.
* bma400
  - add a lower bound check on scale.
* inv_mpu6050
  - add support for temperature data in the fifos for all chips.
  - support an odd situation where a board supports only interrupt triggeri=
ng
    on both edges.
* st_lsm6dsx
  - check and handle potential error return.
* st_sensors
  - fix some values for the LSM9DS0 which is ever so slightly different from
    other devices using the same whoami value.
  - switch over to generic functions from dt ones, avoiding need for separa=
te
    ACPI support.
* stm32-adc
  - switch to dma_request_chan
  - suppress an error print in deferred probe case.
* stm32-dac
  - drop private data structure element for reset controller as only used in
    probe.
  - reflect more cleanly that the reset controller is optional whilst ensur=
ing
    that if is specified any errors are caught.
* stm32-dfsdm
  - switch to dma_request_chan
  - fix missing application of formatting to single conversions.
  - ensure the sampling rate is updated when the oversampling ratio is chan=
ged.

----------------------------------------------------------------
Alexandru Ardelean (2):
      iio: imu: adis: use new `delay` structure for SPI transfer delays
      dt-bindings: iio: adis16480: add compatible entry for ADIS16490

Alexandru Tachici (2):
      iio: adc: ad-sigma-delta: Allow custom IRQ flags
      iio: adc: ad7124: Set IRQ type to falling

Andy Shevchenko (5):
      iio: st_gyro: Correct data for LSM9DS0 gyro
      iio: st_sensors: Drop redundant parameter from st_sensors_of_name_pro=
be()
      iio: st_sensors: Make use of device properties
      iio: magnetometer: ak8975: Get rid of platform data
      iio: magnetometer: ak8975: Convert to use device_get_match_data()

Dan Carpenter (1):
      iio: accel: bma400: prevent setting accel scale too low

Dmitry Osipenko (2):
      iio: accel: kxcjk1013: Support orientation matrix
      dt-bindings: iio: accel: kxcjk1013: Document mount-matrix property

Etienne Carriere (3):
      iio: adc: stm32-adc: don't print an error on probe deferral
      iio: dac: stm32-dac: use reset controller only at probe time
      iio: dac: stm32-dac: better handle reset controller failures

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: add fifo temperature data support

Kent Gustavsson (1):
      iio: humidity: dht11 remove TODO since it doesn't make sense

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: check return value from st_lsm6dsx_sensor_set_e=
nable

Martin Kepplinger (1):
      iio: imu: st_lsm6dsx: add mount matrix support

Matt Ranostay (1):
      iio: chemical: atlas-sensor: add helper function atlas_buffer_num_cha=
nnels()

Micha=C5=82 Miros=C5=82aw (1):
      iio: imu/mpu6050: support dual-edge IRQ

Nuno S=C3=A1 (2):
      iio: adis: Introduce timeouts structure
      iio: adis: Remove startup_delay

Olivier Moysan (2):
      iio: adc: stm32-dfsdm: fix single conversion
      iio: adc: stm32-dfsdm: adapt sampling rate to oversampling ratio

Peter Ujfalusi (3):
      iio: adc: stm32-dfsdm: Use dma_request_chan() instead dma_request_sla=
ve_channel()
      iio: adc: stm32-adc: Use dma_request_chan() instead dma_request_slave=
_channel()
      iio: adc: at91-sama5d2_adc: Use dma_request_chan() instead dma_reques=
t_slave_channel()

Stefan Popa (1):
      iio: imu: adis16480: Add support for ADIS16490

 .../bindings/iio/accel/kionix,kxcjk1013.txt        |   7 +
 .../devicetree/bindings/iio/imu/adi,adis16480.txt  |   1 +
 drivers/iio/accel/adis16201.c                      |   8 +-
 drivers/iio/accel/adis16209.c                      |   8 +-
 drivers/iio/accel/bma400_core.c                    |   3 +-
 drivers/iio/accel/kxcjk-1013.c                     |  27 ++-
 drivers/iio/accel/st_accel_i2c.c                   |   6 +-
 drivers/iio/accel/st_accel_spi.c                   |   9 +-
 drivers/iio/adc/ad7124.c                           |   2 +
 drivers/iio/adc/ad7780.c                           |   1 +
 drivers/iio/adc/ad7791.c                           |   1 +
 drivers/iio/adc/ad7793.c                           |   1 +
 drivers/iio/adc/ad_sigma_delta.c                   |   2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   6 +-
 drivers/iio/adc/stm32-adc-core.c                   |   9 +-
 drivers/iio/adc/stm32-adc.c                        |  16 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  55 ++++--
 drivers/iio/chemical/atlas-sensor.c                |  13 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  45 ++---
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |  21 ---
 drivers/iio/common/st_sensors/st_sensors_spi.c     |  12 +-
 drivers/iio/dac/stm32-dac-core.c                   |  19 +-
 drivers/iio/gyro/adis16136.c                       |  41 ++++-
 drivers/iio/gyro/adis16260.c                       |   8 +-
 drivers/iio/gyro/st_gyro_core.c                    |  75 +++++++-
 drivers/iio/gyro/st_gyro_i2c.c                     |   9 +-
 drivers/iio/gyro/st_gyro_spi.c                     |   9 +-
 drivers/iio/humidity/dht11.c                       |   1 -
 drivers/iio/imu/adis.c                             |  45 +++--
 drivers/iio/imu/adis16400.c                        |  64 ++++++-
 drivers/iio/imu/adis16460.c                        |   7 +
 drivers/iio/imu/adis16480.c                        |  75 +++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 202 ++++++++---------=
----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  22 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  11 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   3 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  19 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  11 +-
 drivers/iio/magnetometer/ak8975.c                  |  53 ++----
 drivers/iio/magnetometer/st_magn_i2c.c             |   9 +-
 drivers/iio/magnetometer/st_magn_spi.c             |   9 +-
 drivers/iio/pressure/st_pressure_i2c.c             |  20 +-
 drivers/iio/pressure/st_pressure_spi.c             |   9 +-
 drivers/staging/iio/accel/adis16203.c              |   8 +-
 drivers/staging/iio/accel/adis16240.c              |   8 +-
 include/linux/iio/accel/kxcjk_1013.h               |   3 +
 include/linux/iio/adc/ad_sigma_delta.h             |   2 +
 include/linux/iio/common/st_sensors.h              |  12 +-
 include/linux/iio/common/st_sensors_i2c.h          |  10 -
 include/linux/iio/imu/adis.h                       |  14 +-
 include/linux/iio/magnetometer/ak8975.h            |  15 --
 51 files changed, 645 insertions(+), 401 deletions(-)
 delete mode 100644 include/linux/iio/magnetometer/ak8975.h
