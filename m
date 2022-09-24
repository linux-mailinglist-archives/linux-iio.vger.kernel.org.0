Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A005E8D3A
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiIXOO2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 10:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiIXOOZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 10:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FE8220E9
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 07:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC7E560302
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 14:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93205C433D6;
        Sat, 24 Sep 2022 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664028863;
        bh=GjBMxtr8KElGBAu88KR/LieFp11ywmCcVEVvKg58a7Y=;
        h=Date:From:To:Subject:From;
        b=jxoIgl4W6awntOvgVEWhE7yA4bRQ4CW4dTubgP5CojJ6gRoeOgAkqx+0L/WEwabod
         D5yEIS24zrLHivDSaamsV9MBEZxPdZMYeACmw5YxC2sqkLSO/2ehxKcOs76HvjtxTv
         pH0Rk24DqTJ/tsWuV10zPzS29hCqVQ9JlU/M3nEj2vorlkNkp47Znz3QHE7SFBsAj6
         6XvOjOw/u3zSStpb15hiI4pCGhGvvJPcjxtt6rTkxk6y7CmzoD+yzUl3l4ceuuAid+
         2Re2ec3iaiQLHsUHNGRIeqbiLxpMmQRzLqfi/489KvT/zi5hsXbAz6WUyqQgprh4mp
         pduMD0SbzFH+w==
Date:   Sat, 24 Sep 2022 15:14:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of new device support, cleanup and features for
  the 6.1 cycle.
Message-ID: <20220924151432.312f5240@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 8be7dfc6a8eb54589100d4ea15b0039c2d01422b:

  Merge tag 'coresight-next-v6.1' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/coresight/linux into char-misc-next (2022-09-21 16:16:03 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.1b

for you to fetch changes up to 6d965885f4ea82f916d31f17f67b2ad771bdabac:

  iio: adc: mcp3911: add support for oversampling ratio (2022-09-21 21:15:1=
0 +0100)

----------------------------------------------------------------
Second set of IIO new device support, features and cleanup for the 6.1 cycl=
e.

Normal mixed bag of new device support with continuing trend that most new
devices are supported by extending existing drivers - a positive sign perha=
ps
that device manufacturers have somewhat stabilized their interfaces across
product generations. The BNO055 driver was however a substantial addition
including several additions to the IIO core.

There are a number of significant patch sets under review, so if the 6.0
cycle runs long I may send a 3rd pull request.

New device support
* adi,adxl313
  - Support for the ADXL312 and ADXL314 accelerometers.
* bosch,bmp280
  - Support for the BMP380 family of pressures sensors.
    Included considerable refactoring and modernization of the bmp280
    driver.
* bosch,bno055
  - New driver for this i2c/serial attached complex IMU.
* lltc,ltc2497
  - Support for the LTC2499 16 channel, 24bit ADC.
* st,pressure
  - Support for the LPS22DF pressure sensor
* st,lsm6dsx
  - Support for the LSM6DSTX (Mainly adding the ID and WAI)

Features
* core - to support the bosch,bno055 requirements
  - Support for linear acceleration channel type (effect  of gravity remove=
d)
  - Pitch, yaw and roll modifiers for angle channels.
  - Standard serialnumber attribute documentation.
  - Binary attributes - to allow for calibration save and restore.
* adi,ad7923
  - Support extended range (wider supported input voltage range).
* bosch,bmp280
  - Add filter controls for some supported parts.
* microchip,mcp3911
  - Buffered capture support for this ADC.
  - Data ready interrupt support, including hiz control for line.
  - Oversampling ratio support.
* st,stm32-adc
  - Support ID registers on parts where they are present, providing
    discoverability of some features.

Fixes - late breaking fixes that I judged could wait for the merge window.
* adi,ad5593r
  - Add a missing STOP condition between address write and data read.
  - Check for related i2c functionality.
* adi,ad7923
  - Fix shift reporting for some variants supported by the driver.
* infinion,dps310
  - Work around a hardware issue where a chip can hang by adding a
    timeout and reset path.

Cleanups
* Continuing work to switch to new pm macros.
* MAINTAINERS
  - Drop duplication of wild card covered entry in ADI block and
    add missing entries to cover ltc294x binding files.
* bosch,bma400
  - Fix trivial smatch warning.
* bosch,bmp280
  - Fix broken links to datasheets
* lltc,ltc2497
  - Fix missing entry for ltc2499
* mexelis,mlx90614
  - Switch to get_avail() callback for _available attributes.
* microchip,mcp3911
  - Move to devm_ resource management for all elements of probe()

----------------------------------------------------------------
Andrea Merello (14):
      iio: add modifiers for linear acceleration
      iio: document linear acceleration modifiers
      iio: event_monitor: add linear acceleration modifiers
      iio: add modifers for pitch, yaw, roll
      iio: document pitch, yaw, roll modifiers
      iio: event_monitor: add pitch, yaw and roll modifiers
      iio: add support for binary attributes
      iio: imu: add Bosch Sensortec BNO055 core driver
      iio: document bno055 private sysfs attributes
      iio: document "serialnumber" sysfs attribute
      dt-bindings: iio/imu: Add Bosch BNO055
      iio: imu: add BNO055 serdev driver
      iio: imu: add BNO055 I2C driver
      docs: iio: add documentation for BNO055 driver

Angel Iglesias (10):
      iio: pressure: bmp280: fix datasheet links
      iio: pressure: bmp280: reorder local variables following reverse xmas=
 tree
      iio: pressure: bmp280: use FIELD_GET, FIELD_PREP and GENMASK
      iio: pressure: bmp280: Simplify bmp280 calibration data reading
      iio: pressure: bmp280: simplify driver initialization logic
      iio: pressure: bmp280: Fix alignment for DMA safety
      iio: pressure: bmp280: reorder i2c device tables declarations
      iio: pressure: bmp280: Add support for BMP380 sensor family
      dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
      iio: pressure: bmp280: Add more tunable config parameters for BMP380

Ciprian Regus (5):
      MAINTAINERS: Remove duplicate matching entry
      dt-bindings: iio: adc: Add docs for LTC2499
      Add MAINTAINERS entries for LTC2497 and LTC2496
      drivers: iio: adc: ltc2497: LTC2499 support
      drivers: iio: adc: ltc2497: Rename the LTC2499 iio device

Crt Mori (1):
      iio: temperature: mlx90614 Refactoring available filter attributes

Eddie James (2):
      iio: pressure: dps310: Refactor startup procedure
      iio: pressure: dps310: Reset chip after timeout

George Mois (2):
      dt-bindings: iio: accel: adxl313: Add compatibles for adxl312 and adx=
l314
      drivers: iio: accel: adxl312 and adxl314 support

Jonathan Cameron (7):
      iio: proximity: sx9310: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_s=
leep_ptr()
      iio: proximity: sx9324: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_s=
leep_ptr()
      iio: proximity: sx9360: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_s=
leep_ptr()
      iio: proximity: srf04: Use pm_ptr() to remove unused struct dev_pm_ops
      iio: accel: bmi088: Use EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS() and pm_ptr=
()
      iio: light: st_uvis25: Use EXPORT_NS_SIMPLE_DEV_PM_OPS()
      iio: accel: bma400: Fix smatch warning based on use of unintialized v=
alue.

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: add support to LSM6DSTX
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dstx device bindings

Marcus Folkesson (5):
      iio: adc: mcp3911: use resource-managed version of iio_device_register
      iio: adc: mcp3911: add support for buffers
      iio: adc: mcp3911: add support for interrupts
      dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
      iio: adc: mcp3911: add support for oversampling ratio

Martyn Welch (2):
      dt-bindings: iio: st,st-sensors add LPS22DF.
      iio: pressure: st_pressure: Add support for LPS22DF

Michael Hennerich (1):
      iio: dac: ad5593r: Fix i2c read protocol requirements

Nuno S=C3=A1 (4):
      iio: dac: ad5593r: add check for i2c functionality
      iio: adc: ad7923: fix channel readings for some variants
      iio: adc: ad7923: support extended range
      dt-bindings: iio: adi,ad7923: add adi,range-double property

Olivier Moysan (1):
      iio: adc: stm32-adc: add id registers support

Uwe Kleine-K=C3=B6nig (1):
      iio: ltc2497: Fix reading conversion results

 Documentation/ABI/testing/sysfs-bus-iio            |   25 +
 Documentation/ABI/testing/sysfs-bus-iio-bno055     |   81 +
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml |   10 +-
 .../devicetree/bindings/iio/adc/adi,ad7923.yaml    |    4 +
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |    8 +-
 .../bindings/iio/adc/microchip,mcp3911.yaml        |    7 +
 .../devicetree/bindings/iio/imu/bosch,bno055.yaml  |   59 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    3 +
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |    4 +-
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    2 +
 Documentation/iio/bno055.rst                       |   51 +
 Documentation/iio/index.rst                        |    2 +
 MAINTAINERS                                        |    3 +-
 drivers/iio/accel/adxl313.h                        |   35 +-
 drivers/iio/accel/adxl313_core.c                   |  202 ++-
 drivers/iio/accel/adxl313_i2c.c                    |   74 +-
 drivers/iio/accel/adxl313_spi.c                    |   63 +-
 drivers/iio/accel/bma400_core.c                    |    3 +-
 drivers/iio/accel/bmi088-accel-core.c              |   15 +-
 drivers/iio/accel/bmi088-accel-spi.c               |    2 +-
 drivers/iio/adc/Kconfig                            |    2 +
 drivers/iio/adc/ad7923.c                           |   11 +-
 drivers/iio/adc/ltc2496.c                          |    9 +-
 drivers/iio/adc/ltc2497-core.c                     |   12 +-
 drivers/iio/adc/ltc2497.c                          |   77 +-
 drivers/iio/adc/ltc2497.h                          |    6 +
 drivers/iio/adc/mcp3911.c                          |  257 ++-
 drivers/iio/adc/stm32-adc-core.c                   |   59 +-
 drivers/iio/adc/stm32-adc-core.h                   |   31 +
 drivers/iio/dac/ad5593r.c                          |   50 +-
 drivers/iio/imu/Kconfig                            |    1 +
 drivers/iio/imu/Makefile                           |    1 +
 drivers/iio/imu/bno055/Kconfig                     |   25 +
 drivers/iio/imu/bno055/Makefile                    |   10 +
 drivers/iio/imu/bno055/bno055.c                    | 1685 ++++++++++++++++=
++++
 drivers/iio/imu/bno055/bno055.h                    |   13 +
 drivers/iio/imu/bno055/bno055_i2c.c                |   57 +
 drivers/iio/imu/bno055/bno055_ser_core.c           |  560 +++++++
 drivers/iio/imu/bno055/bno055_ser_trace.c          |   14 +
 drivers/iio/imu/bno055/bno055_ser_trace.h          |  104 ++
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    5 +
 drivers/iio/industrialio-core.c                    |   10 +-
 drivers/iio/light/st_uvis25_core.c                 |    9 +-
 drivers/iio/light/st_uvis25_i2c.c                  |    2 +-
 drivers/iio/light/st_uvis25_spi.c                  |    2 +-
 drivers/iio/pressure/Kconfig                       |    6 +-
 drivers/iio/pressure/bmp280-core.c                 |  974 +++++++++--
 drivers/iio/pressure/bmp280-i2c.c                  |   15 +-
 drivers/iio/pressure/bmp280-regmap.c               |   55 +
 drivers/iio/pressure/bmp280-spi.c                  |    5 +
 drivers/iio/pressure/bmp280.h                      |  164 +-
 drivers/iio/pressure/dps310.c                      |  262 +--
 drivers/iio/pressure/st_pressure.h                 |    2 +
 drivers/iio/pressure/st_pressure_core.c            |   70 +
 drivers/iio/pressure/st_pressure_i2c.c             |    5 +
 drivers/iio/pressure/st_pressure_spi.c             |    5 +
 drivers/iio/proximity/srf04.c                      |   10 +-
 drivers/iio/proximity/sx9310.c                     |    8 +-
 drivers/iio/proximity/sx9324.c                     |    8 +-
 drivers/iio/proximity/sx9360.c                     |    8 +-
 drivers/iio/temperature/mlx90614.c                 |   41 +-
 include/uapi/linux/iio/types.h                     |    7 +-
 tools/iio/iio_event_monitor.c                      |    6 +
 68 files changed, 4815 insertions(+), 519 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-bno055
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.=
yaml
 create mode 100644 Documentation/iio/bno055.rst
 create mode 100644 drivers/iio/imu/bno055/Kconfig
 create mode 100644 drivers/iio/imu/bno055/Makefile
 create mode 100644 drivers/iio/imu/bno055/bno055.c
 create mode 100644 drivers/iio/imu/bno055/bno055.h
 create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_core.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.c
 create mode 100644 drivers/iio/imu/bno055/bno055_ser_trace.h
