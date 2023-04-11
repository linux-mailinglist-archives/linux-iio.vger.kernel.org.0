Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFFB6DE287
	for <lists+linux-iio@lfdr.de>; Tue, 11 Apr 2023 19:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDKRcM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Apr 2023 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDKRcM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2023 13:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC15B81
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 10:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21D9E629E8
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 17:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB3EC433D2;
        Tue, 11 Apr 2023 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681234329;
        bh=7e6F9gHxDUx9r8GH7jr1A7FxMQW8BO3jdx7iJsaWk0U=;
        h=Date:From:To:Subject:From;
        b=sapH9aXEnKkNaDuv9HKIg8bwuAqAJcY/m5Uv9TCW64+KNR4e9dwdgGgFk4zuuNrh3
         Mk2EdUFIEmw/aYTkWqRwKjSLtJs7uM6jqHKG9aIj6iFlUGeAOKQq/bnjA3sqAfN/wQ
         Z/iNkz3QWymsan/tGs6ixivCHsbrZOCLN5tHRBlT5DP47lOuvwjkFbI2868eNZYsRd
         wCx5L2Qzhqll6ZbZHrxLx1bQiUA9lRpMEbXnElFurAEVyI49Wsj4UVvBczyF/bnCyP
         rrt3LzDvRsyP4zB0cqq4w9OPFFCClykmUW0YTMX5Y/WlWkLuESfTs4TzIQutj/U/oV
         lOIfo6PgfV/tw==
Date:   Tue, 11 Apr 2023 18:32:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of new device support, features and cleanup for
 6.4
Message-ID: <20230411183206.6490be47@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.4a

for you to fetch changes up to c86b0e73f0bebbb0245ef2bac4cf269d61ff828c:

  MAINTAINERS: Add ROHM BU27034 (2023-04-10 12:26:35 +0100)

----------------------------------------------------------------
1st set of IIO new device support, features and cleanups for the 6.4 cycle.

New device support
* bosch,bmp280
  - Add support for BMP580 - includes significant refactoring and general
    driver cleanup + support for non-volatile memory for trimming and config
    parameters.
* rohm BU27034
  - New driver for this 3 channel ambient light sensor.
  - New support library for devices where both integration time and
    amplifier gain are configurable.  In these cases a scale change
    may require changing bother underlying values. This library module
    provides code to help with this.
* st,accel
  - Add support for IIS328DQ (ID only as compatible wtih LIS331DL)
* st,lsm6dsx
  - Add support for ASM330LHB automotive MEMS sensor.
* ti,ads1100, ads1000
  - New driver for these 16 bit ADCs.
* ti,tmp117
  - Add support for older tmp116 device. Includes some general driver clean=
up.

Staging driver drops
* adi,ade7854
  - Driver was a very long way from compliant with IIO infrastructure and A=
BI.
    If anyone wants a non staging version of this driver they are better off
    starting from scratch. Hence drop it and the associated meter.h header.

Features
* adi,ad7441r
  - Add DT binding to set sink current for digital input.
* semtech,sx9324,9360
  - Support older register mapping from firmware designed for windows.

Core improvements.
* Move iio_trigger_poll() docs to next to the implementation and add a note
  on expected caller context.
* Rename iio_trigger_poll_chained() to iio_trigger_poll_nested() so
  as to use more standard / common terminology.
* Improve main ABI docs references to offset and scale for raw values by
  making them consistent and clear.

Cleanups and minor fixes:
* adi,ad5592r
  - Add GPIO names - useful for debug.
* adi,ad7441r
  - Fix current input, loop powered mode configuration setup.
* adi,adis16475
  - Fix wrong commented value for minimum advised lower rate.
* adi,admv1013
  - Use devm_clk_get_enabled() to reduce boilerplate.
* adi,ads1210
  - Fix wrong bits for writing config register (late fix and has
    been broken a long time so not rushed upstream)
* amlogic,meson-saradc
  - Improve cleanup in error handling if BL30 handshake fails.
* apex-embedded,stx104
  - Migrate to regmap and use regmap_read_poll_timeout() to neatly handle
    retries.
  - Add local mutex to close various races.
  - Use define U16_MAX rather than value for limit.
  - Improve code readability with minor reorganization.
* atmel,ad91-sama5d2
  - Drop trivial dead code.
* kionix,kx022a
  - Drop unused structure element.
* linear,ltc2983
  - Reorganize bindings doc to enable unevaluatedProperties to be set
    in one place for all child nodes.
  - Make binding for adi,custom-thermocouple accept signed values.
* maxim,max44000
  - Add OF Device matching (of_match_table was not correctly set).
* maxim,max5522
  - Missing static
* measurement-computing,cio-dac
  - Fix wrong part name in comments.
  - Migrate to regmap.
  - Improve includes by replacing bitops.h with more direct bits.h
* qcom,pm8xxx-xoadc
  - Remove a check that can never fail.
* renesas,rcar-gyroadc
  - DT binding documentation improvements.
  - Tidy up an unused warning with __maybe_unused.
* semtech,sx_common
  - Drop docs for a structure element that doesn't exist.
* semtech,sx9500
  - Drop ACPI_PTR() and of_match_ptr() protections that just complicate
    the code / block some firmware registration types that would otherwise
    work.
* sensiron,sps30
  - Comment formatting tidy up.
* st,sensors
  - Drop duplicate text in DT binding.
* st,stm32-adc
  - Add some missing static markings.
* ti,ads1100
  - Use correct return code in dev_err_probe() call.
* x-powers,axp20x_adc - precursor series to simplify addition of AXP192.
  - General code cleanup / minor refactoring for better readabilty of code.
  - Switch from boolean value to mask for adc_en2 field to avoid hard coding
    a mask that will be different in AXP192

----------------------------------------------------------------
Aidan MacDonald (2):
      iio: adc: axp20x_adc: Minor code cleanups
      iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field

Angel Iglesias (7):
      iio: pressure: bmp280: Use chip_info pointers for each chip as driver=
 data
      iio: pressure: bmp280: Add preinit callback
      iio: pressure: bmp280: Make read calibration callback optional
      iio: pressure: Kconfig: Delete misleading I2C reference on bmp280 tit=
le
      iio: pressure: bmp280: Add support for new sensor BMP580
      dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
      iio: pressure: bmp280: Add nvmem operations for BMP580

Antoniu Miclaus (1):
      drivers: iio: dac: ad5592r: add gpio_chip names

Cheng Ziqiu (1):
      iio: adc: at91-sama5d2_adc: remove dead code in at91_adc_probe()

Dan Carpenter (1):
      iio: adc: ti-ads1100: fix error code in probe()

Geert Uytterhoeven (1):
      dt-bindings: iio: adc: renesas,rcar-gyroadc: Miscellaneous improvemen=
ts

Gwendal Grignou (1):
      iio: proximity: sx_common: Add old register mapping

Jonathan Cameron (2):
      iio: proximity: sx_common: Drop documentation of non existent struct =
element.
      staging: iio: meter: Drop ade7854 driver

Jonathan Neusch=C3=A4fer (1):
      iio: chemical: sps030: Reformat comment in a more readable way

Kasumov Ruslan (1):
      iio: adc: qcom-pm8xxx-xoadc: Remove useless condition in pm8xxx_xoadc=
_parse_channel()

Krzysztof Kozlowski (3):
      iio: adc: rcar-gyroadc: mark OF related data as maybe unused
      iio: light: max44009: add missing OF device matching
      iio: proximity: sx9500: Reference ACPI and OF ID data

Linus Walleij (1):
      dt-bindings: iio: st-sensors: Fix repeated text

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: discard samples during filters settling time
      iio: imu: st_lsm6dsx: add support to ASM330LHB
      dt-bindings: iio: imu: st_lsm6dsx: add asm330lhb

Marco Felsch (5):
      dt-bindings: iio: ti,tmp117: fix documentation link
      iio: temperature: tmp117: improve fallback capabilities
      dt-bindings: iio: ti,tmp117: add binding for the TMP116
      iio: temperature: tmp117: add TI TMP116 support
      iio: temperature: tmp117: cosmetic alignment cleanup

Matti Vaittinen (6):
      doc: Make sysfs-bus-iio doc more exact
      iio: light: Add gain-time-scale helpers
      MAINTAINERS: Add IIO gain-time-scale helpers
      dt-bindings: iio: light: Support ROHM BU27034
      iio: light: ROHM BU27034 Ambient Light Sensor
      MAINTAINERS: Add ROHM BU27034

Mehdi Djait (3):
      iio: accel: kionix-kx022a: Remove the unused member g_range
      iio: Improve the kernel-doc of iio_trigger_poll
      iio: Rename iio_trigger_poll_chained and add kernel-doc

Mike Looijmans (2):
      dt-bindings: iio: adc: Add TI ADS1100 and ADS1000
      iio: adc: Add TI ADS1100 and ADS1000

Nuno S=C3=A1 (2):
      iio: imu: adis16475: correct copy paste mistake in comment block
      staging: iio: resolver: ads1210: fix config mode

Rasmus Villemoes (3):
      dt-bindings: iio: ad74413r: allow setting sink current for digital in=
put
      iio: ad74413r: wire up support for drive-strength-microamp property
      iio: addac: ad74413r: fix Current Input, Loop Powered Mode

Rob Herring (2):
      dt-bindings: iio: temperature: ltc2983: Fix child node unevaluated pr=
operties
      dt-bindings: iio: temperature: ltc2983: Make 'adi,custom-thermocouple=
' signed

Stefan Wahren (2):
      dt-bindings: iio: st-sensors: Add IIS328DQ accelerometer
      iio: accel: add support for IIS328DQ variant

Tom Rix (2):
      iio: adc: stm32-adc: set some stm32-adc.c variables storage-class-spe=
cifier to static
      iio: dac: set variable max5522_channels storage-class-specifier to st=
atic

Uwe Kleine-K=C3=B6nig (2):
      iio: adc: meson_saradc: Better handle BL30 not releasing the hardware
      iio: frequency: admv1013: Benefit from devm_clk_get_enabled() to simp=
lify

William Breathitt Gray (9):
      iio: dac: cio-dac: Fix typo in comment listing supported devices
      iio: dac: cio-dac: Migrate to the regmap API
      iio: addac: stx104: Replace bitops.h header inclusion with bits.h
      iio: addac: stx104: Fix race condition for stx104_write_raw()
      iio: addac: stx104: Fix race condition when converting analog-to-digi=
tal
      iio: addac: stx104: Use define rather than hardcoded limit for write =
val
      iio: addac: stx104: Improve indentation in stx104_write_raw()
      iio: addac: stx104: Migrate to the regmap API
      iio: addac: stx104: Use regmap_read_poll_timeout() for conversion poll

 Documentation/ABI/testing/sysfs-bus-iio            |   13 +-
 .../bindings/iio/adc/renesas,rcar-gyroadc.yaml     |   60 +-
 .../devicetree/bindings/iio/adc/ti,ads1100.yaml    |   46 +
 .../bindings/iio/addac/adi,ad74413r.yaml           |    9 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    3 +
 .../bindings/iio/light/rohm,bu27034.yaml           |   46 +
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |    2 +
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    6 +-
 .../bindings/iio/temperature/adi,ltc2983.yaml      |   67 +-
 .../bindings/iio/temperature/ti,tmp117.yaml        |    8 +-
 MAINTAINERS                                        |   13 +
 drivers/iio/Kconfig                                |    3 +
 drivers/iio/Makefile                               |    1 +
 drivers/iio/accel/bma400_core.c                    |    2 +-
 drivers/iio/accel/kionix-kx022a.c                  |    3 +-
 drivers/iio/accel/mma8452.c                        |    2 +-
 drivers/iio/accel/msa311.c                         |    2 +-
 drivers/iio/accel/st_accel.h                       |    1 +
 drivers/iio/accel/st_accel_core.c                  |    1 +
 drivers/iio/accel/st_accel_i2c.c                   |    5 +
 drivers/iio/accel/st_accel_spi.c                   |    5 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7606.c                           |    2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    8 +-
 drivers/iio/adc/axp20x_adc.c                       |   77 +-
 drivers/iio/adc/max11410.c                         |    2 +-
 drivers/iio/adc/meson_saradc.c                     |   21 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    2 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    2 +-
 drivers/iio/adc/stm32-adc.c                        |    6 +-
 drivers/iio/adc/ti-ads1100.c                       |  445 ++++++
 drivers/iio/addac/Kconfig                          |    2 +
 drivers/iio/addac/ad74413r.c                       |   44 +-
 drivers/iio/addac/stx104.c                         |  462 +++---
 drivers/iio/chemical/sps30_i2c.c                   |    6 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |    4 +-
 drivers/iio/dac/Kconfig                            |    1 +
 drivers/iio/dac/ad5592r-base.c                     |    5 +
 drivers/iio/dac/cio-dac.c                          |   68 +-
 drivers/iio/dac/max5522.c                          |    2 +-
 drivers/iio/frequency/admv1013.c                   |   21 +-
 drivers/iio/gyro/fxas21002c_core.c                 |    2 +-
 drivers/iio/gyro/mpu3050-core.c                    |    2 +-
 drivers/iio/humidity/hts221_buffer.c               |    2 +-
 drivers/iio/imu/adis16475.c                        |    6 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   13 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   59 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   22 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    5 +
 drivers/iio/industrialio-gts-helper.c              | 1077 ++++++++++++++
 drivers/iio/industrialio-trigger.c                 |   17 +-
 drivers/iio/light/Kconfig                          |   14 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/acpi-als.c                       |    2 +-
 drivers/iio/light/max44009.c                       |   13 +-
 drivers/iio/light/rohm-bu27034.c                   | 1497 ++++++++++++++++=
++++
 drivers/iio/light/rpr0521.c                        |    2 +-
 drivers/iio/light/st_uvis25_core.c                 |    2 +-
 drivers/iio/light/vcnl4000.c                       |    2 +-
 drivers/iio/light/vcnl4035.c                       |    2 +-
 drivers/iio/potentiostat/lmp91000.c                |    2 +-
 drivers/iio/pressure/Kconfig                       |    6 +-
 drivers/iio/pressure/bmp280-core.c                 |  765 +++++++---
 drivers/iio/pressure/bmp280-i2c.c                  |   45 +-
 drivers/iio/pressure/bmp280-regmap.c               |   60 +
 drivers/iio/pressure/bmp280-spi.c                  |   47 +-
 drivers/iio/pressure/bmp280.h                      |  273 +++-
 drivers/iio/pressure/zpa2326.c                     |    2 +-
 drivers/iio/proximity/as3935.c                     |    2 +-
 drivers/iio/proximity/sx9324.c                     |   96 +-
 drivers/iio/proximity/sx9360.c                     |   32 +-
 drivers/iio/proximity/sx9500.c                     |    4 +-
 drivers/iio/proximity/sx_common.c                  |   21 +
 drivers/iio/proximity/sx_common.h                  |    6 +-
 drivers/iio/temperature/tmp117.c                   |   80 +-
 drivers/iio/trigger/iio-trig-loop.c                |    2 +-
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/meter/Kconfig                  |   37 -
 drivers/staging/iio/meter/Makefile                 |    8 -
 drivers/staging/iio/meter/ade7854-i2c.c            |  153 --
 drivers/staging/iio/meter/ade7854-spi.c            |  160 ---
 drivers/staging/iio/meter/ade7854.c                |  556 --------
 drivers/staging/iio/meter/ade7854.h                |  173 ---
 drivers/staging/iio/meter/meter.h                  |  398 ------
 drivers/staging/iio/resolver/ad2s1210.c            |    2 +-
 include/linux/iio/iio-gts-helper.h                 |  206 +++
 include/linux/iio/trigger.h                        |    8 +-
 91 files changed, 5146 insertions(+), 2238 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1100.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2703=
4.yaml
 create mode 100644 drivers/iio/adc/ti-ads1100.c
 create mode 100644 drivers/iio/industrialio-gts-helper.c
 create mode 100644 drivers/iio/light/rohm-bu27034.c
 delete mode 100644 drivers/staging/iio/meter/Kconfig
 delete mode 100644 drivers/staging/iio/meter/Makefile
 delete mode 100644 drivers/staging/iio/meter/ade7854-i2c.c
 delete mode 100644 drivers/staging/iio/meter/ade7854-spi.c
 delete mode 100644 drivers/staging/iio/meter/ade7854.c
 delete mode 100644 drivers/staging/iio/meter/ade7854.h
 delete mode 100644 drivers/staging/iio/meter/meter.h
 create mode 100644 include/linux/iio/iio-gts-helper.h
