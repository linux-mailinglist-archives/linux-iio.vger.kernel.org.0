Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36511A729A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfICSga (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 14:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfICSga (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 14:36:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C620217D7;
        Tue,  3 Sep 2019 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567535788;
        bh=HB2dLdasLzN5fRmkQ9a3ick021NMJhRgQax3Lxtf2Ks=;
        h=Date:From:To:Subject:From;
        b=XJhh7s2e8YSA2RDRclxoRVutqvKZDOG6+CCCdhpkSuTgutitp+Ian2bOm9EzrxeGj
         DRVKi7wW90KBhJ93M6u+G/u+6LWMA+N+h2SaAhG383jr3sPcrCEweU5N/TZ97m76nM
         GmZJE4J4DKwDN95VFV9khNRXGu4hw8ApFJYuiFXQ=
Date:   Tue, 3 Sep 2019 19:36:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL v2] Second set of new device support, cleanups etc for IIO in
  the 5.4 cycle.
Message-ID: <20190903193624.170e3c34@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 81e0da703fdba1ee126868bf8350592c79cdba13:

  staging: sm750fb: fix odd license text (2019-08-15 14:43:57 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4b-take2

for you to fetch changes up to 90ff60239e9dae03aa8f518afccf79d77f6a6645:

  iio: imu: st_lsm6dsx: rely on IIO_G_TO_M_S_2 for gain definition for LSM9DS1 (2019-09-03 18:56:10 +0100)

----------------------------------------------------------------
Second set of new device support, cleanups and features for IIO in the 5.4 cycle

Revised pull request to fix up a missing Signed-off-by and roll in
a fix in the lsm9ds1 support after I broke it when applying.

A few fixes in here that could have gone a faster path but aren't quite
worth the rush for 5.3.

New device support
* ad7606
  - Support the ad7606b which adds a software controlled mode alongside
    the pin controlled only approach of the ad7606. Including dt-bindings.
* lsm6dsx
  - Add support for the gyro and accelerometer part of the lsm9ds1 which is
    a compound device also including a magnetometer (st_sensors driver).
    Includes bindings and precursor rework of the driver.

Features
* ad7192
  - Add support for low pass filter control.
  - DT binding docs.

Cleanups and minor fixes
* MAINTAINERS
  - Fix a typo in a path.
  - Add entry for ad7606
* ad5380
  - Fix a failure to dereference a pointer before atempting to assign the
    value.
* ad7192
  - Drop platform data as not used in mainline and we now have full DT bindings.
* ad7606
  - YAML conversion for dt-bindings.
* adis16240
  - Rework write_raw to make it more readable using GENMASK.
* adis16460
  - Fix and issue with an unsigned variable holding potential negatives.
* cros_ec
  - Fix missing default of calibration vector so that we get 'something'
    before calibration is complete on a given axis.
* hid-sensors
  - Use int_pow instead of opencoding.
* isl29501
  - rename dt-binding docs to include renesas inline with other renesas parts
    and general current convention.
* kxcjk1013
  - Improve comments on the 'unusual' ACPI ids used to identify which sensor
    is which in certain laptops.
* lsm6dsx
  - Add one bit to the fifo status masks for a number of parts.
  - Drop a reserved entry from the sensitivity values to tidy up interface.
  - Use core conversion macro from G to m/s^2 for lsm9ds1 to make it easier
    to relate to the datasheet and consistent with other parts supported.
* max1027
  - Use device managed APIs to avoid manual error handling and cleanup.
* rfd77402
  - Typo in Kconfig help.
* sc27xx
  - Switch to polling mode from interrupts as interrupt handling typically
    to slow for very short sleeps.
* st-sensors
  - Fix some missing selects for regmap.
* tools
  - Add a .gitignore containing the binary outputs.

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: imu: adis16460: fix variable signedness

Andy Shevchenko (1):
      iio: hid-sensor-attributes: Convert to use int_pow()

Bartosz Golaszewski (1):
      tools: iio: add .gitignore

Beniamin Bia (3):
      MAINTAINERS: Add Beniamin Bia for AD7606 driver
      dt-bindings: iio: adc: Migrate AD7606 documentation to yaml
      dt-bindings: iio: adc: Add AD7606B ADC documentation

Christophe JAILLET (1):
      Kconfig: Fix the reference to the RFD77402 ToF sensor in the 'help' section

Chuhong Yuan (1):
      iio: adc: max1027: Use device-managed APIs

Colin Ian King (1):
      iio: dac: ad5380: fix incorrect assignment to val

Denis Efremov (1):
      MAINTAINERS: ftm-quaddec: Fix typo in a filepath

Freeman Liu (1):
      iio: adc: sc27xx: Change to polling mode to read data

Gwendal Grignou (1):
      iio: cros_ec: set calibscale for 3d MEMS to unit vector

Hans de Goede (1):
      iio: accel: kxcjk1013: Improve comments on KIOX010A and KIOX020A ACPI ids

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: introduce update_fifo function pointer
      iio: imu: st_lsm6dsx: remove invalid gain value for LSM9DS1
      iio: imu: st_lsm6dsx: rely on IIO_G_TO_M_S_2 for gain definition for LSM9DS1

Martin Kepplinger (3):
      iio: imu: st_lsm6dsx: move register definitions to sensor_settings struct
      iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1
      dt-bindings: iio: imu: st_lsm6dsx: add lsm9ds1 device bindings

Mircea Caprioru (3):
      staging: iio: adc: ad7192: Remove platform data
      staging: iio: adc: ad7192: Add low_pass_3db_filter_frequency
      dt-bindings: iio: adc: ad7192: Add binding documentation for AD7192

Rodrigo Ribeiro (1):
      staging: iio: accel: adis16240: Improve readability on write_raw function

Simon Horman (1):
      dt-bindings: iio: light: isl29501: Rename bindings documentation file

Stefan Popa (1):
      iio: adc: ad7606: Add support for AD7606B ADC

YueHaibing (1):
      iio: st_sensors: Fix build error

mario tesi (1):
      iio: imu: st_lsm6dsx: Fix FIFO diff mask for tagged fifo

 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    | 121 +++++++++++++++
 .../devicetree/bindings/iio/adc/adi,ad7606.txt     |  66 ---------
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 138 +++++++++++++++++
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   1 +
 .../light/{isl29501.txt => renesas,isl29501.txt}   |   0
 MAINTAINERS                                        |   5 +-
 drivers/iio/accel/kxcjk-1013.c                     |   4 +-
 drivers/iio/adc/ad7606.c                           |  13 +-
 drivers/iio/adc/ad7606.h                           |   4 +
 drivers/iio/adc/ad7606_spi.c                       | 109 +++++++++++++-
 drivers/iio/adc/max1027.c                          |  38 +----
 drivers/iio/adc/sc27xx_adc.c                       |  81 ++++------
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   5 +-
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  53 +++----
 drivers/iio/common/st_sensors/Kconfig              |   2 +
 drivers/iio/dac/ad5380.c                           |   2 +-
 drivers/iio/imu/adis16460.c                        |   2 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |  12 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  19 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 139 ++++++++++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   5 +
 drivers/iio/proximity/Kconfig                      |   2 +-
 drivers/staging/iio/accel/adis16240.c              |   5 +-
 drivers/staging/iio/adc/ad7192.c                   | 163 +++++++++++++++++----
 drivers/staging/iio/adc/ad7192.h                   |  37 -----
 tools/iio/.gitignore                               |   4 +
 28 files changed, 756 insertions(+), 281 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
 rename Documentation/devicetree/bindings/iio/light/{isl29501.txt => renesas,isl29501.txt} (100%)
 delete mode 100644 drivers/staging/iio/adc/ad7192.h
 create mode 100644 tools/iio/.gitignore
