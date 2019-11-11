Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7306DF8042
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 20:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfKKThl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 14:37:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfKKThl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 Nov 2019 14:37:41 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FBA214E0;
        Mon, 11 Nov 2019 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573501060;
        bh=qMDV6PjpT33DoWXESph/Np5HKw4Rza+98D3ef2nWyqY=;
        h=Date:From:To:Subject:From;
        b=bh3ZnC37pleIDDzMv0fozXteaTij0+70Pz+k8GGiAhlMyi+ddC0mWgVEu7VJIkQLe
         p3MwEXG9/AAYYRqsvpXY1gQZ/OjlhPlA5AGMtzP4AzU80p9bMXqFDja8LHVokSwio2
         8y1g/6kM0HG/aD5CwumAFHxiYuO4C6XpCILwpAZQ=
Date:   Mon, 11 Nov 2019 19:37:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 3rd set of new device support, cleanups etc for IIO in the
 5.5 cycle.
Message-ID: <20191111193735.6c0e9472@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit f8be8d1ede50a5918faeda82e1f1fb45e9431b54:

  staging: rts5208: Eliminate the use of Camel Case in file sd.h (2019-11-0=
1 10:55:10 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-5.5c

for you to fetch changes up to 4c35b7a51e2f291471f7221d112c6a45c63e83bc:

  iio: adis16480: Add debugfs_reg_access entry (2019-11-11 18:38:13 +0000)

----------------------------------------------------------------
Third set of IIO new device support cleanups and fixes for the 5.5 cycle.

New device support
* ad5446
  - Support the ad5600 DAC (id only needed).
* ad7292 ADC DAC etc
  - New driver plus dt-bindings.
* veml6030 ambient light sensor
  - New driver plus dt-bindings and sysfs docs.

Features
* mpu6050
  - Explicit VDD control.
* stm32-adc
  - Allow limiting of max clock frequency from devicetree to ensure it's
    suitable for external circuitry.

yaml binding conversions
* ltc1660
* mcp3911

Fixes
* adis16480
  - Fix wrong scale factors.
  - Fix debugfs reg access by providing the callback.
* cros_ec_baro
  - Fixing missing mask entry to make available sample frequencies visible
    in sysfs.
* st_lsm6dsx
  - Explicitly handle different ODR table sizes.
  - Handle restrictions between slave ODR and accel ODR when
    both are enabled.
  - Allow ODR to be expressed more accurately by using miliHz.
* tools
  - Fix an issue with parallel builds.

Cleanups and warning fixes
* adis16136, adis16400, adis16460, adis-lib
  - Change some checks on return values to be for 0 rather than strictly
    negative. Avoids some fiddly issues with the compiler concluding some
    variables are initialized due to a mixture of error checks.
  - Assign values only on success of 'read' operations - avoiding any
    chance the compiler will falsly suggest they might be used uninitialize=
d.
  - Whitespace and simlar cleanups.
* aspeed adc
  - devm_platfom_ioremap_resource to reduce boilerplate.
* bcm-iproc-adc
  - Stray semicolon removal.
* cc10001
  - devm_platfom_ioremap_resource to reduce boilerplate.
* dln2-adc
  - Reorganise the buffered mode setup and tear down. Part of moving towards
    being able to refactor this area of the IIO core.
* hdc100x
  - Reorganise the buffered mode setup and tear down.
* ingenic-adc
  - devm_platfom_ioremap_resource to reduce boilerplate.
* lpc18xx-adc
  - devm_platfom_ioremap_resource to reduce boilerplate.
* lpc18xx-dac
  - devm_platfom_ioremap_resource to reduce boilerplate.
* mt6577
  - devm_platfom_ioremap_resource to reduce boilerplate.
* npcm
  - devm_platfom_ioremap_resource to reduce boilerplate.
* rcar-gyroadc
  - devm_platfom_ioremap_resource to reduce boilerplate.
* spear-adc
  - devm_platfom_ioremap_resource to reduce boilerplate.
* vf610-adc
  - devm_platfom_ioremap_resource to reduce boilerplate.
* vf610-dac
  - devm_platfom_ioremap_resource to reduce boilerplate.

----------------------------------------------------------------
Alexandru Ardelean (12):
      iio: dln2-adc: fix iio_triggered_buffer_postenable() position
      iio: hdc100x: fix iio_triggered_buffer_{predisable,postenable} positi=
ons
      iio: gyro: adis16136: check ret val for non-zero vs less-than-zero
      iio: imu: adis16400: check ret val for non-zero vs less-than-zero
      iio: imu: adis16460: check ret val for non-zero vs less-than-zero
      iio: imu: adis16480: check ret val for non-zero vs less-than-zero
      iio: imu: adis: check ret val for non-zero vs less-than-zero
      iio: imu: adis16480: fix indentation of return statement
      iio: imu: adis16480: prefer `unsigned int` over `unsigned`
      iio: imu: adis16480: assign bias value only if operation succeeded
      iio: imu: adis: assign read val in debugfs hook only if op successful
      iio: imu: adis: assign value only if return code zero in read funcs

Fabrice Gasnier (2):
      dt-bindings: iio: stm32-adc: add max clock rate property
      iio: adc: stm32: allow to tune analog clock

Gwendal Grignou (1):
      iio: cros_ec_baro: set info_mask_shared_by_all_available field

Jonathan Cameron (12):
      iio: adc: aspeed: use devm_platform_ioremap_resource
      iio: adc: mt6577_auxdac: use devm_platform_ioremap_resource
      iio: adc: bcm_iproc_adc: drop a stray semicolon
      iio: adc: cc10001: use devm_platform_ioremap_resource
      iio: adc: ingenic: Use devm_platform_ioremap_resource
      iio: adc: lpc18xx: use devm_platform_ioremap_resource
      iio: adc: npcm: use devm_platform_ioremap_resource
      iio: adc: rcar-gyroadc: use devm_platform_ioremap_resource
      iio: adc: spear_adc: Use devm_platform_ioremap_resource
      iio: adc: vf610: use devm_platform_ioremap_resource
      iio: dac: lpc18xx: Use devm_platform_ioremap_resource
      iio: dac: vf610: Use devm_platform_ioremap_resource

Laura Abbott (1):
      tools: iio: Correctly add make dependency for iio_utils

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: explicitly define odr table size
      iio: imu: st_lsm6dsx: fix ODR check in st_lsm6dsx_write_raw
      iio: imu: st_lsm6dsx: express odr in mHZ

Marcelo Schmitt (2):
      dt-bindings: iio: adc: Add dt-schema for AD7292
      iio: adc: Add driver support for AD7292

Marcus Folkesson (2):
      dt-bindings: iio: dac: Migrate LTC1660 documentation to yaml
      dt-bindings: iio: adc: Migrate MCP3911 documentation to yaml

Nuno S=C3=A1 (2):
      iio: adis16480: Fix scales factors
      iio: adis16480: Add debugfs_reg_access entry

Rishi Gupta (3):
      iio: light: add driver for veml6030 ambient light sensor
      dt-bindings: iio: light: add veml6030 ALS bindings
      iio: documentation: light: Add veml6030 sysfs documentation

Stefan Popa (1):
      iio: dac: ad5446: Add support for new AD5600 DAC

Stephan Gerhold (2):
      dt-bindings: iio: imu: mpu6050: add vdd-supply
      iio: imu: mpu6050: Add support for vdd-supply regulator

 Documentation/ABI/testing/sysfs-bus-iio            |  11 +
 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    | 104 +++
 .../devicetree/bindings/iio/adc/mcp3911.txt        |  30 -
 .../bindings/iio/adc/microchip,mcp3911.yaml        |  71 ++
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   2 +
 .../devicetree/bindings/iio/dac/lltc,ltc1660.yaml  |  49 ++
 .../devicetree/bindings/iio/dac/ltc1660.txt        |  21 -
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   1 +
 .../devicetree/bindings/iio/light/veml6030.yaml    |  62 ++
 MAINTAINERS                                        |  12 +-
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7292.c                           | 350 ++++++++
 drivers/iio/adc/aspeed_adc.c                       |   4 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |   2 +-
 drivers/iio/adc/cc10001_adc.c                      |   4 +-
 drivers/iio/adc/dln2-adc.c                         |  20 +-
 drivers/iio/adc/ingenic-adc.c                      |   4 +-
 drivers/iio/adc/lpc18xx_adc.c                      |   4 +-
 drivers/iio/adc/mt6577_auxadc.c                    |   4 +-
 drivers/iio/adc/npcm_adc.c                         |   4 +-
 drivers/iio/adc/rcar-gyroadc.c                     |   4 +-
 drivers/iio/adc/spear_adc.c                        |   4 +-
 drivers/iio/adc/stm32-adc-core.c                   |  16 +-
 drivers/iio/adc/vf610_adc.c                        |   4 +-
 drivers/iio/dac/Kconfig                            |   4 +-
 drivers/iio/dac/ad5446.c                           |   6 +
 drivers/iio/dac/lpc18xx_dac.c                      |   4 +-
 drivers/iio/dac/vf610_dac.c                        |   4 +-
 drivers/iio/gyro/adis16136.c                       |  24 +-
 drivers/iio/humidity/hdc100x.c                     |  19 +-
 drivers/iio/imu/adis.c                             |   5 +-
 drivers/iio/imu/adis16400.c                        |  22 +-
 drivers/iio/imu/adis16460.c                        |   8 +-
 drivers/iio/imu/adis16480.c                        | 116 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  43 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   8 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 235 +++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  45 +-
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml6030.c                       | 908 +++++++++++++++++=
++++
 drivers/iio/pressure/cros_ec_baro.c                |   3 +
 include/linux/iio/imu/adis.h                       |   6 +-
 tools/iio/Build                                    |   1 +
 tools/iio/Makefile                                 |  10 +-
 48 files changed, 1955 insertions(+), 339 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp=
3911.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.ya=
ml
 create mode 100644 drivers/iio/adc/ad7292.c
 create mode 100644 drivers/iio/light/veml6030.c
