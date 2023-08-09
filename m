Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B94776642
	for <lists+linux-iio@lfdr.de>; Wed,  9 Aug 2023 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjHIRTi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Aug 2023 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjHIRTi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Aug 2023 13:19:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF4E1FEF
        for <linux-iio@vger.kernel.org>; Wed,  9 Aug 2023 10:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6230F6428E
        for <linux-iio@vger.kernel.org>; Wed,  9 Aug 2023 17:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE38C433C8;
        Wed,  9 Aug 2023 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691601575;
        bh=YIsuOh+/vvh3kwaiwc6ABwgb0HjB/Mjcf1aad4pA8KQ=;
        h=Date:From:To:Subject:From;
        b=kcoCrL9/whl2DH8ifZkn4cLBl/uJAxBm6A5rTQu5V45FLSZbmMFDrbC74ZL5u54+n
         VWgxDZkhXLh17AxqClsGSM8rnocJWe9xOIpxpIBSlcy2mK8KlsCL1FbQNqR0KgbKbZ
         Ir9/lf7vMja50SsSzBw4y7WobxpawlCZnNwiWrWIQ1IiDm3B6vnWc9VKkCz9R+MSNt
         BNhy1W05QmzhRpqUOBmr1xXwuH3Nrk1msdscvyRemZRGFLhfUq0E7QXcsvWbCnYFPw
         Prv9+pnvL2Bw5z837b4He7uzgBB5DpqBjRse2dFFy3DKRGVlX719UcQpyrXNJU66r6
         Hyoeh5dHKTLxQ==
Date:   Wed, 9 Aug 2023 18:19:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of new device support, features and cleanup for
 6.6
Message-ID: <20230809181935.7cbdb77a@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.6a

for you to fetch changes up to 14b7447cec15ee8dfdfe0da66ba1e280ded7e00a:

  Documentation: ABI: testing: admv8818: add bypass (2023-08-08 09:51:06 +0=
100)

----------------------------------------------------------------
1st set of IIO new device support, features and cleanup for 6.6

New device support
* adi,ad8366
  - Add support for the HMC792 digital attenuator (mostly chip specific dat=
a)
* alwinner,sun20i-gpadc
  - New driver for the integrated ADC on a number of allwinner SoCs
    including dt-binding documentation.
* microchip,mcp4728
  - New driver for this quad channel DAC. Includes dt-bindings.
* miramems, da280
  - Add ID for DA217 accelerometer which is compatible with the da280.
* murata,irs-d200
  - New driver for this passive infrared sensor typically used for human
    detection. Includes bindings and a few pieces of new ABI to
    cover a case of needing to count a number of repeats of an event
    before reporting it.
* rohm,bu27008
  - Add initial support for the BU27010 RGB + flickering sensor to this
    driver. Substantial refactoring was needed to enable this.

Features
* adi,admv8818
  - Add mode that bypasses the input and output filters.
* amlogic,meson
  - Support control of the MUX on channel 7, exposed as multiple channels.
  - Support channel labels.
* sensirion,scd4x
  - Add pressure compensation. Controlled via an 'output' pressure channel.
* ti,lmp92040
  - Add IIO buffered supported (read via chrdev).
* vishay,vcnl4000
  - Add proximity interrupt support for vcnl4200.
  - Add proximity integration time control for vcnl4200.
  - Add illuminance integration time control for vcnl4040 and vcnl4200.
  - Add calibration bias, proximity and illuminance event period, and
    oversampling ratio control for vcnl4040 and vncl4200.

Cleanup and minor fixes
* core
  - Tidy up handling of set_trigger_state() callback return values
    to consistently assume no positive return values.
  - Use min() rather than min_t() in a case where types were clearly
    the same.
  - Drop some else statements that follow continue with a loop or
    a returns.
  - White space and comment format cleanup.
  - Use sysfs_match_string() helper to improve readability.
  - Use krealloc_array() to make it explicit a krealloc is for an array
    of structures, not just one.
* tools
  - Tidy up potential overflow in array index.
* tree wide
  - Fix up includes for DT related headers.
  - Drop some error prints in places where as similar error message
    is printed by the function being called.
  - Tidy up handling of return value from platform_get_irq() to no longer
    take into account 0 as a value that might be returned. Similar for
    fwnode_irq_get().
* adi,ad7192
  - Add missing error check and improved debug logging.
  - Use sysfs_emit_at() rather than open coded variant.
* adi,adis16475
  - Drop unused scan element enum entries.
  - Specify that a few more devices support burst32 mode.
* adi,admv1013
  - Enable all required regulators and document as required in the
    dt-binding.
* adi,admv1014
  - Make all regulators required in the dt-binding as the device needs
    them all enabled.
* adi,adxl313
  - Fix wrong enum values being used in the i2c_device_id table.
  - Use i2c_get_match_data() to reduce open coded handling of the
    various id tables.
* allwinner,gpadc
  - Make the kconfig text more specific to make space for separate drivers
    for other Allwinner devices.
* amlogic,meson
  - Drop unused timestamp channels as no buffer support.
  - Various minor reorganizations to enable addition of support channel 7
    MUX.
  - Initialize some default values to account for potential previous user
    since reboot.
* qcom,spmi-adc5
  - Add ADC5_GPIO2_100K_PU support to driver to line up with bindings.
* qcom,spmi-adc7
  - Use predefined channel ID definitions rather than values.
* invensense, common
  - Factor out the timestamp handling to a module used by both mpu6050 and
    icm42600.
* invensense,mpu6050
  - Read as many FIFO elements as possible in one bus access.
* men,s188
  - Drop redundant initialization of driver owner field.
* microchip,mcp4018 and mcp4531
  - Use i2c_get_match_data() instead of open coding. Includes making the
    data format the same for the i2c_device_id and firmware match
    tables.
* semtech,sx9310
  - dt-bindings: Add reference to IIO schema to provide the label property.
* semtech,sx9324
  - dt-bindings: Add reference to IIO schema to provide the label property.
* st,stm32-adc
  - Use devm_platform_get_and_ioremap_resource() instead of open coded
    version.
* st,stm-lptimer-trigger
  - Drop setting platform drvdata as it wasn't then used.
* ti,ads1015
  - Fix wrong dt binding description of ti,datarate for some devices.
* vishay,vcnl4200
  - Move to switch statements for channel type checking to make later
    additions simpler.

----------------------------------------------------------------
Alisa Roman (1):
      iio: adc: ad7192: Use sysfs_emit_at

Andrea Collamati (2):
      dt-bindings: iio: dac: add mcp4728.yaml
      iio: add MCP4728 I2C DAC driver

Andrei Coardos (1):
      iio: trigger: stm32-lptimer-trigger: remove unneeded platform_set_drv=
data()

Andy Shevchenko (6):
      iio: core: Use min() instead of min_t() to make code more robust
      iio: core: Get rid of redundant 'else'
      iio: core: Improve indentation in a few places
      iio: core: Use sysfs_match_string() helper
      iio: core: Switch to krealloc_array()
      iio: core: Fix issues and style of the comments

Antoniu Miclaus (5):
      dt-bindings: iio: admv1014: make all regs required
      dt-bindings: iio: admv1013: add vcc regulators
      drivers: iio: admv1013: add vcc regulators
      drivers: iio: filter: admv8818: add bypass mode
      Documentation: ABI: testing: admv8818: add bypass

Astrid Rost (8):
      iio: light: vcnl4000: Add proximity irq for vcnl4200
      iio: light: vcnl4000: Add proximity ps_it for vcnl4200
      iio: light: vcnl4000: Check type with switch case
      iio: light: vcnl4000: Add als_it for vcnl4040/4200
      iio: light: vcnl4000: add illuminance irq vcnl4040/4200
      iio: light: vcnl4000: Add period for vcnl4040/4200
      iio: light: vcnl4000: Add oversampling_ratio for 4040/4200
      iio: light: vcnl4000: Add calibration bias for 4040/4200

Biju Das (5):
      iio: accel: adxl355: Simplify probe()
      iio: accel: adxl313: Fix adxl313_i2c_id[] table
      iio: accel: adxl313: Use i2c_get_match_data
      iio: potentiometer: mcp4018: Use i2c_get_match_data()
      iio: potentiometer: mcp4531: Use i2c_get_match_data()

Chenyuan Mi (1):
      tools: iio: iio_generic_buffer: Fix some integer type and calculation

Christophe JAILLET (1):
      iio: adc: ad7192: Simplify using devm_clk_get_optional_enabled()

Dmitry Baryshkov (1):
      dt-bindings: iio: adc: qcom,spmi-adc7: use predefined channel ids

George Stark (9):
      iio: adc: meson: remove unused timestamp channel
      iio: adc: meson: move enums declaration before variables declaration
      iio: adc: meson: move meson_sar_adc_set_chan7_mux routine upper
      iio: adc: meson: add enum for iio channel numbers
      iio: adc: meson: add channel labels
      iio: adc: meson: support reading from channel 7 mux inputs
      iio: adc: meson: init channels 0,1 input muxes
      iio: adc: meson: init internal continuous ring counter
      iio: adc: meson: init voltage control bits

Hans de Goede (1):
      iio: accel: da280: Add support for the DA217 accelerometer

Jean-Baptiste Maneyrol (5):
      iio: imu: inv_icm42600: make timestamp module chip independent
      iio: move inv_icm42600 timestamp module in common
      iio: make invensense timestamp module generic
      iio: imu: inv_mpu6050: use the common inv_sensors timestamp module
      iio: imu: inv_mpu6050: read the full fifo when processing data

Kim Seer Paller (1):
      iio: amplifiers: ad8366: add support for HMC792A Attenuator

Konrad Dybcio (1):
      iio: adc: qcom-spmi-adc5: Add ADC5_GPIO2_100K_PU

Krzysztof Kozlowski (2):
      dt-bindings: iio: semtech,sx9310: reference common schema for label
      dt-bindings: iio: semtech,sx9324: reference common schema for label

Leonard G=C3=B6hrs (1):
      iio: adc: ti-lmp92064: add buffering support

Li Zetao (1):
      iio: adc: men_z188_adc: Remove redundant initialization owner in men_=
z188_driver

Maksim Kiselev (3):
      iio: adc: Kconfig change description for Allwinner GPADC
      iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
      dt-bindings: iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC

Marco Felsch (1):
      dt-bindings: iio: adc: ti,ads1015: fix datarate max value and meaning

Markus Burri (1):
      iio: adi: ad7192: Add error check and more debug log

Matti Vaittinen (5):
      iio: mb1232: relax return value check for IRQ get
      iio: cdc: ad7150: relax return value check for IRQ get
      dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor
      iio: light: bu27008: add chip info
      iio: light: bd27008: Support BD27010 RGB

Ramona Bolboaca (2):
      iio: imu: adis16475.c: Remove unused enum elements
      iio: imu: adis16475.c: Add has_burst32 flag to adis16477 devices

Roan van Dijk (1):
      iio: chemical: scd4x: Add pressure compensation

Rob Herring (1):
      iio: adc: Explicitly include correct DT includes

Ruan Jinjie (2):
      iio: adc: Remove redundant dev_err_probe()
      iio: adc: fix the return value handle for platform_get_irq()

Waqar Hameed (4):
      iio: Make return value check for set_trigger_state() consistent
      dt-bindings: iio: proximity: Add Murata IRS-D200
      iio: Add event enums for running period and count
      iio: Add driver for Murata IRS-D200

Yangtao Li (1):
      iio: adc: stm32-adc: Use devm_platform_get_and_ioremap_resource()

 Documentation/ABI/testing/sysfs-bus-iio            |  16 +
 .../ABI/testing/sysfs-bus-iio-filter-admv8818      |   2 +
 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         |  91 ++
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |  15 +-
 .../bindings/iio/dac/microchip,mcp4728.yaml        |  49 ++
 .../bindings/iio/frequency/adi,admv1013.yaml       |  60 ++
 .../bindings/iio/frequency/adi,admv1014.yaml       |   8 +
 .../bindings/iio/light/rohm,bu27010.yaml           |  49 ++
 .../bindings/iio/proximity/murata,irsd200.yaml     |  60 ++
 .../bindings/iio/proximity/semtech,sx9310.yaml     |   5 +-
 .../bindings/iio/proximity/semtech,sx9324.yaml     |   5 +-
 drivers/iio/accel/adxl313_i2c.c                    |   8 +-
 drivers/iio/accel/adxl355_i2c.c                    |  15 +-
 drivers/iio/accel/adxl372_spi.c                    |   1 -
 drivers/iio/accel/bma180.c                         |   1 -
 drivers/iio/accel/da280.c                          |  11 +-
 drivers/iio/accel/kxsd9-spi.c                      |   1 -
 drivers/iio/accel/mma8452.c                        |   2 +-
 drivers/iio/adc/Kconfig                            |  12 +-
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ab8500-gpadc.c                     |   6 +-
 drivers/iio/adc/ad7124.c                           |   2 +-
 drivers/iio/adc/ad7192.c                           |  31 +-
 drivers/iio/adc/ad9467.c                           |   2 +-
 drivers/iio/adc/adi-axi-adc.c                      |   3 +-
 drivers/iio/adc/at91_adc.c                         |   1 -
 drivers/iio/adc/bcm_iproc_adc.c                    |   4 +-
 drivers/iio/adc/cc10001_adc.c                      |   1 -
 drivers/iio/adc/imx7d_adc.c                        |   2 +-
 drivers/iio/adc/ina2xx-adc.c                       |   2 +-
 drivers/iio/adc/lpc32xx_adc.c                      |   4 +-
 drivers/iio/adc/men_z188_adc.c                     |   1 -
 drivers/iio/adc/meson_saradc.c                     | 243 +++++-
 drivers/iio/adc/npcm_adc.c                         |   4 +-
 drivers/iio/adc/palmas_gpadc.c                     |   7 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |   2 +
 drivers/iio/adc/qcom-spmi-iadc.c                   |   1 -
 drivers/iio/adc/rockchip_saradc.c                  |   3 +-
 drivers/iio/adc/sc27xx_adc.c                       |   1 -
 drivers/iio/adc/spear_adc.c                        |   4 +-
 drivers/iio/adc/stm32-adc-core.c                   |   5 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   3 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |   4 +-
 drivers/iio/adc/stmpe-adc.c                        |   2 +-
 drivers/iio/adc/sun20i-gpadc-iio.c                 | 276 ++++++
 drivers/iio/adc/sun4i-gpadc-iio.c                  |   1 -
 drivers/iio/adc/ti-lmp92064.c                      |  53 ++
 drivers/iio/adc/ti_am335x_adc.c                    |   1 -
 drivers/iio/amplifiers/Kconfig                     |   1 +
 drivers/iio/amplifiers/ad8366.c                    |  15 +
 drivers/iio/cdc/ad7150.c                           |  10 +-
 drivers/iio/chemical/scd4x.c                       |  79 +-
 drivers/iio/common/Kconfig                         |   1 +
 drivers/iio/common/Makefile                        |   1 +
 drivers/iio/common/inv_sensors/Kconfig             |   7 +
 drivers/iio/common/inv_sensors/Makefile            |   6 +
 .../inv_sensors/inv_sensors_timestamp.c}           | 100 ++-
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/mcp4728.c                          | 618 +++++++++++++
 drivers/iio/filter/admv8818.c                      |  65 +-
 drivers/iio/frequency/admv1013.c                   |  14 +
 drivers/iio/imu/adis16475.c                        |   5 +-
 drivers/iio/imu/inv_icm42600/Kconfig               |   1 +
 drivers/iio/imu/inv_icm42600/Makefile              |   1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  35 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  33 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  14 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  35 +-
 .../iio/imu/inv_icm42600/inv_icm42600_timestamp.h  |  85 --
 drivers/iio/imu/inv_mpu6050/Kconfig                |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  33 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  22 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         | 102 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   6 +-
 drivers/iio/industrialio-core.c                    | 161 ++--
 drivers/iio/industrialio-event.c                   |   2 +
 drivers/iio/industrialio-trigger.c                 |   2 +-
 drivers/iio/light/cm3605.c                         |   2 +-
 drivers/iio/light/rohm-bu27008.c                   | 630 +++++++++++---
 drivers/iio/light/vcnl4000.c                       | 710 +++++++++++++--
 drivers/iio/potentiometer/mcp4018.c                |  35 +-
 drivers/iio/potentiometer/mcp4531.c                | 139 +--
 drivers/iio/proximity/Kconfig                      |  12 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/irsd200.c                    | 958 +++++++++++++++++=
++++
 drivers/iio/proximity/isl29501.c                   |   2 +-
 drivers/iio/proximity/mb1232.c                     |   7 +-
 drivers/iio/temperature/mlx90614.c                 |   2 +-
 drivers/iio/trigger/stm32-lptimer-trigger.c        |   9 +-
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h    |  88 +-
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h   | 124 +--
 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h   |  50 +-
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h   |  22 +-
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h   |  22 +-
 include/linux/iio/common/inv_sensors_timestamp.h   |  95 ++
 include/linux/iio/types.h                          |   2 +
 tools/iio/iio_generic_buffer.c                     |  17 +-
 98 files changed, 4535 insertions(+), 940 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun=
20i-d1-gpadc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp=
4728.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/murata,=
irsd200.yaml
 create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
 create mode 100644 drivers/iio/common/inv_sensors/Kconfig
 create mode 100644 drivers/iio/common/inv_sensors/Makefile
 rename drivers/iio/{imu/inv_icm42600/inv_icm42600_timestamp.c =3D> common/=
inv_sensors/inv_sensors_timestamp.c} (56%)
 create mode 100644 drivers/iio/dac/mcp4728.c
 delete mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_timestamp.h
 create mode 100644 drivers/iio/proximity/irsd200.c
 create mode 100644 include/linux/iio/common/inv_sensors_timestamp.h
