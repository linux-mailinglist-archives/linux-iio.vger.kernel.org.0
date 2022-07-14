Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45728574CB6
	for <lists+linux-iio@lfdr.de>; Thu, 14 Jul 2022 14:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiGNMDE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Jul 2022 08:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiGNMDD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2022 08:03:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A75C367
        for <linux-iio@vger.kernel.org>; Thu, 14 Jul 2022 05:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 413BACE2694
        for <linux-iio@vger.kernel.org>; Thu, 14 Jul 2022 12:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1509C34114;
        Thu, 14 Jul 2022 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657800176;
        bh=5+0VodghMrPEC3tBTAQXxOAMgu7ysprobMqDPe853Qo=;
        h=Date:From:To:Subject:From;
        b=PEoY0HRfjx1TR2xYYcgLsFZRbibq5/CfIECf5tY9YKdRhDCwGRCDj4VmnjK1DXngK
         406Zrbv1AeJ3YfFHHqlCgYhqJRWqA2lM22wi1Sh2I95xVdHhQ12008Gp5aPRvfrPKo
         +AJqam8NQWlRohMGPvADCLWMg4DW+5CPunlA1Wx756NxvEcjZdSEltO0Bo/FGaH2JY
         +qD9bBxFy6MhObGtRNpooYLs5AFYI/SsZcZQ2FhyRjQCSuO01amgvjPIKD40YI0XU5
         MV+A1jciHwFBZovxA5KMFOe/qFcYI6rkaEnUvdn7SDp/sK3xOHrqCbFqI2gIvU24C6
         2QbnnhGWkMcsQ==
Date:   Thu, 14 Jul 2022 13:12:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: New device support, features, cleanup and minor fixes
 for 5.20
Message-ID: <20220714131247.4e07146f@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-5.20a

for you to fetch changes up to 568f6869e680c7492c5e38df9094af86fe9d6364:

  iio: adc: xilinx-xadc: Drop duplicate NULL check in xadc_parse_dt() (2022=
-07-13 17:11:43 +0100)

----------------------------------------------------------------
IIO new device support, features and minor fixes for 5.20

Several on-running cleanup efforts dominate this time, plus the DMA
safety alignment issue identified due to improved understanding of
the restrictions as a result of Catalin Marinas' efforts in that area.

One immutable branch in here due to MFD and SPMI elements needed for
the qcom-rradc driver.

Device support
* bmi088
  - Add support for bmi085 (accelerometer part of IMU)
  - Add support for bmi090l (accelerometer part of IMU)
* mcp4922
  - Add support for single channel device MCP4921
* rzg2l-adc
  - Add compatible and minor tweaks to support RZ/G2UL ADC
* sca3300
  - Add support for scl3300 including refactoring driver to support
    multiple device types and cleanup noticed whilst working on driver.
* spmi-rradc
  - New driver for Qualcomm SPMI Round Robin ADC including necessary
    additional utility functions in SPMI core and related MFD driver.
* ti-dac55781
  - Add compatible for DAC121C081 which is very similar to existing parts.

Features
* core
  - Warn on iio_trigger_get() on an unregistered IIO trigger.
* bma400
  - Triggered buffer support
  - Activity and step counting
  - Misc driver improvements such as devm and header ordering
* cm32181
  - Add PM support.
* cros_ec
  - Sensor location support
* sx9324
  - Add precharge resistor setting
  - Add internal compensation resistor setting
  - Add CS idle/sleep mode.
* sx9360
  - Add precharge resistor setting
* vl53l0x
  - Handle reset GPIO, regulator and relax handling of irq type.

Cleanup and minor fixes:

Treewide changes
- Cleanup of error handling in remove functions in many drivers.
- Update dt-binding maintainers for a number of ADI bindings.
- Several sets of conversion of drivers from device tree specific to
  generic device properties. Includes fixing up various related
  header and Kconfig issues.
- Drop include of of.h from iio.h and fix up drivers that need to include
  it directly.
- More moves of clusters of drivers into appropriate IIO_XXX namespaces.
- Tree wide fix of a long running bug around DMA safety requirements.
  IIO was using __cacheline_aligned to pad iio_priv() structures. This
  worked for a long time by coincidence, but correct alignment is
  ARCH_KMALLOC_MINALIGN.  As there is activity around this area, introduce
  an IIO local IIO_DMA_MINALIGN to allow for changing it in one place rather
  than every driver in future. Note, there have been no reports of this
  bug in the wild, and it may not happen on any platforms supported by
  upstream, so no rush to backport these fixes.

Other cleanup
* core
  - Switch to ida_alloc()/free()
  - Drop unused iio_get_time_res()
  - Octal permissions and DEVICE_ATTR_* macros.
  - Cleanup bared unsigned usage.
* MAINTAINERS
  - Add include/dt-bindings/iio/ to the main IIO entry.
* ad5380
  - Comment syntax fix.
* ad74413r
  - Call to for_each_set_bit_from(), with from value as 0 replaced.
* ad7768-1
  - Drop explicit setting of INDIO_BUFFER_TRIGGERED as now done by the core.
* adxl345
  - Fix wrong address in dt-binding example.
* adxl367
  - Drop extra update of FIFO watermark.
* at91-sama5d2
  - Limit requested watermark to the hwfifo size.
* bmg160, bme680
  - Typos
* cio-dac
  - Switch to iomap rather than direct use of ioports
* kxsd9
  - Replace CONFIG_PM guards with new PM macros that let the compiler
    cleanly remove the unused code and structures when !CONFIG_PM
* lsm6dsx
  - Use new pm_sleep_ptr() and EXPORT_SIMPLE_DEV_PM_OPS(). Then move
    to Namespace.
* meson_saradc - general cleanup.
  - Avoid attaching resources to iio_dev->dev
  - Use same struct device for all error messages
  - Convert to dev_err_probe() and use local struct device *dev to
    reduce code complexity.
  - Use devm_clk_get_optional() instead of hand rolling.
  - Use regmap_read_poll_timeout() instead of hand rolling.
* mma7660
  - Drop ACPI_PTR() use that is unhelpful.
* mpu3050
  - Stop exporting symbols not used outside of module
  - Switch to new DEFINE_RUNTIME_DEV_PM_OPS() macro and move to Namespace.
* ping
  - Typo fix
* qcom-spmi-rradc
  - Typo fix
* sc27xx
  - Convert to generic struct u32_fract
* srf08
  - Drop a redundant check on !val
* st_lsm6dsx
  - Limit the requested watermark to the hwfifo size.
* stm32-adc
  - Use generic_handle_domain_irq() instead of opencoding.
  - Fix handling of ADC disable.
* stm32-dac
  - Use str_enabled_disable() instead of open coding.
* stx104
  - Switch to iomap rather than direct use of ioports
* tsc2046
  - Drop explicit setting of INDIO_BUFFER_TRIGGERED as now done by the core.
* tsl2563
  - Replace flush_scheduled_work() with cancel_delayed_work_sync()
  - Replace cancel_delayed_work() with cancel_delayed_work_sync()
* vl53l0x
  - Make the VDD regulator optional by allowing a dummy regulator.

----------------------------------------------------------------
Alexandru Tachici (5):
      dt-bindings: iio: accel: ADIS16240: update maintainers
      dt-bindings: iio: adc: AD9467: update maintainers
      dt-bindings: iio: adc: axi-adc: update maintainers
      dt-bindings: iio: dac: AD5770R: update maintainers
      dt-bindings: iio: imu: adis16480: update maintainers

Andy Shevchenko (22):
      iio: trigger: stm32-lptimer-trigger: Make use of device properties
      iio: proximity: srf04: Make use of device properties
      iio: imu: st_lsm6dsx: Switch from of headers to mod_devicetable.h
      iio: adc: sd_adc_modulator: Drop dependency on OF
      iio: adc: envelope-detector: Drop dependency on OF
      iio: adc: lpc18xx_adc: Switch from of headers to mod_devicetable.h
      iio: dac: ad5592r: Get rid of OF specifics
      iio: adc: vf610_adc: Make use of device properties
      iio: adc: nau7802: Convert driver to use ->probe_new()
      iio: adc: nau7802: Make use of device properties
      iio: adc: intel_mrfld_adc: explicitly add proper header files
      iio: adc: sc27xx_adc: Re-use generic struct u32_fract
      iio: adc: meson_saradc: Don't attach managed resource to IIO device o=
bject
      iio: adc: meson_saradc: Align messages to be with physical device pre=
fix
      iio: adc: meson_saradc: Convert to use dev_err_probe()
      iio: adc: meson_saradc: Use devm_clk_get_optional()
      iio: adc: meson_saradc: Use temporary variable for struct device
      iio: adc: meson_saradc: Use regmap_read_poll_timeout() for busy wait
      iio: accel: mma7660: Drop wrong use of ACPI_PTR()
      iio: dac: stm32-dac: Replace open coded str_enable_disable()
      iio: adc: xilinx-xadc: Make use of device properties
      iio: adc: xilinx-xadc: Drop duplicate NULL check in xadc_parse_dt()

Biju Das (2):
      dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
      iio: adc: rzg2l_adc: Remove unnecessary channel check from rzg2l_adc_=
read_label()

Caleb Connolly (5):
      spmi: add a helper to look up an SPMI device from a device node
      mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
      mfd: qcom-spmi-pmic: read fab id on supported PMICs
      dt-bindings: iio: adc: document qcom-spmi-rradc
      iio: adc: qcom-spmi-rradc: introduce round robin adc

Colin Ian King (1):
      iio: adc: qcom-spmi-rradc: Fix spelling mistake "coherrency" -> "cohe=
rency"

Cosmin Tanislav (2):
      iio: accel: adxl367: do not update FIFO watermark on scan mode update
      iio: addac: ad74413r: for_each_set_bit_from -> for_each_set_bit

Dmitry Rokosov (1):
      iio: trigger: warn about non-registered iio trigger getting attempt

Gwendal Grignou (11):
      iio: ABI: Add a new location label
      iio: common: cros_ec_sensors: Add label attribute
      iio: sx9324: Fix register field spelling
      dt-bindings: iio: sx9324: Add precharge resistor setting
      iio: sx9324: Add precharge internal resistance setting
      dt-bindings: iio: sx9324: Add internal compensation resistor setting
      iio: sx9324: Add Setting for internal compensation resistor
      dt-bindings: iio: sx9324: Add input analog gain
      iio: sx9324: Add Setting for internal analog gain
      dt-bindings: iio: sx9360: Add precharge resistor setting
      iio: sx9360: Add pre-charge resistor setting

Jagath Jog J (8):
      iio: accel: bma400: Fix the scale min and max macro values
      iio: accel: bma400: Reordering of header files
      iio: accel: bma400: conversion to device-managed function
      iio: accel: bma400: Add triggered buffer support
      iio: accel: bma400: Add separate channel for step counter
      iio: accel: bma400: Add step change event
      iio: accel: bma400: Add activity recognition support
      iio: accel: bma400: Add support for activity and inactivity events

Jiang Jian (1):
      iio: dac: ad5380: align '*' each line and drop unneeded blank line

Joe Simmons-Talbott (2):
      iio: Use octal permissions and DEVICE_ATTR_{RO,RW}.
      iio: Don't use bare "unsigned"

Jonathan Cameron (105):
      iio: core: drop iio_get_time_res()
      iio: adc: adi-axi: Move exported symbols into IIO_ADI_AXI namespace.
      iio: gyro: mpu3050: Drop unused symbol exports.
      iio: gyro: mpu3050: Use pm_ptr() and DEFINE_RUNTIME_DEV_PM_OPS()
      iio: core: Fix IIO_ALIGN and rename as it was not sufficiently large
      iio: accel: adxl313: Fix alignment for DMA safety
      iio: accel: adxl355: Fix alignment for DMA safety
      iio: accel: adxl367: Fix alignment for DMA safety
      iio: accel: bma220: Fix alignment for DMA safety
      iio: accel: bmi088: Fix alignment for DMA safety
      iio: accel: sca3000: Fix alignment for DMA safety
      iio: accel: sca3300: Fix alignment for DMA safety
      iio: adc: ad7266: Fix alignment for DMA safety
      iio: adc: ad7280a: Fix alignment for DMA safety
      iio: adc: ad7292: Fix alignment for DMA safety
      iio: adc: ad7298: Fix alignment for DMA safety
      iio: adc: ad7476: Fix alignment for DMA safety
      iio: adc: ad7606: Fix alignment for DMA safety
      iio: adc: ad7766: Fix alignment for DMA safety
      iio: adc: ad7768-1: Fix alignment for DMA safety
      iio: adc: ad7887: Fix alignment for DMA safety
      iio: adc: ad7923: Fix alignment for DMA safety
      iio: adc: ad7949: Fix alignment for DMA safety
      iio: adc: hi8435: Fix alignment for DMA safety
      iio: adc: ltc2496: Fix alignment for DMA safety
      iio: adc: ltc2497: Fix alignment for DMA safety
      iio: adc: max1027: Fix alignment for DMA safety
      iio: adc: max11100: Fix alignment for DMA safety
      iio: adc: max1118: Fix alignment for DMA safety
      iio: adc: max1241: Fix alignment for DMA safety
      iio: adc: mcp320x: Fix alignment for DMA safety
      iio: adc: ti-adc0832: Fix alignment for DMA safety
      iio: adc: ti-adc084s021: Fix alignment for DMA safety
      iio: adc: ti-adc108s102: Fix alignment for DMA safety
      iio: adc: ti-adc12138: Fix alignment for DMA safety
      iio: adc: ti-adc128s052: Fix alignment for DMA safety
      iio: adc: ti-adc161s626: Fix alignment for DMA safety
      iio: adc: ti-ads124s08: Fix alignment for DMA safety
      iio: adc: ti-ads131e08: Fix alignment for DMA safety
      iio: adc: ti-ads7950: Fix alignment for DMA safety
      iio: adc: ti-ads8344: Fix alignment for DMA safety
      iio: adc: ti-ads8688: Fix alignment for DMA safety
      iio: adc: ti-tlc4541: Fix alignment for DMA safety
      iio: addac: ad74413r: Fix alignment for DMA safety
      iio: amplifiers: ad8366: Fix alignment for DMA safety
      iio: common: ssp: Fix alignment for DMA safety
      iio: dac: ad5064: Fix alignment for DMA safety
      iio: dac: ad5360: Fix alignment for DMA safety
      iio: dac: ad5421: Fix alignment for DMA safety
      iio: dac: ad5449: Fix alignment for DMA safety
      iio: dac: ad5504: Fix alignment for DMA safety
      iio: dac: ad5592r: Fix alignment for DMA safety
      iio: dac: ad5686: Fix alignment for DMA safety
      iio: dac: ad5755: Fix alignment for DMA safety
      iio: dac: ad5761: Fix alignment for DMA safety
      iio: dac: ad5764: Fix alignment for DMA safety
      iio: dac: ad5766: Fix alignment for DMA safety
      iio: dac: ad5770r: Fix alignment for DMA safety
      iio: dac: ad5791: Fix alignment for DMA saftey
      iio: dac: ad7293: Fix alignment for DMA safety
      iio: dac: ad7303: Fix alignment for DMA safety
      iio: dac: ad8801: Fix alignment for DMA safety
      iio: dac: ltc2688: Fix alignment for DMA safety
      iio: dac: mcp4922: Fix alignment for DMA safety
      iio: dac: ti-dac082s085: Fix alignment for DMA safety
      iio: dac: ti-dac5571: Fix alignment for DMA safety
      iio: dac: ti-dac7311: Fix alignment for DMA safety
      iio: dac: ti-dac7612: Fix alignment for DMA safety
      iio: frequency: ad9523: Fix alignment for DMA safety
      iio: frequency: adf4350: Fix alignment for DMA safety
      iio: frequency: adf4371: Fix alignment for DMA safety
      iio: frequency: admv1013: Fix alignment for DMA safety
      iio: frequency: admv1014: Fix alignment for DMA safety
      iio: frequency: admv4420: Fix alignment for DMA safety
      iio: frequency: adrf6780: Fix alignment for DMA safety
      iio: gyro: adis16080: Fix alignment for DMA safety
      iio: gyro: adis16130: Fix alignment for DMA safety
      iio: gyro: adxrs450: Fix alignment for DMA safety
      iio: gyro: fxas210002c: Fix alignment for DMA safety
      iio: imu: fxos8700: Fix alignment for DMA safety
      iio: imu: inv_icm42600: Fix alignment for DMA safety
      iio: imu: inv_icm42600: Fix alignment for DMA safety in buffer code.
      iio: imu: mpu6050: Fix alignment for DMA safety
      iio: potentiometer: ad5110: Fix alignment for DMA safety
      iio: potentiometer: ad5272: Fix alignment for DMA safety
      iio: potentiometer: max5481: Fix alignment for DMA safety
      iio: potentiometer: mcp41010: Fix alignment for DMA safety
      iio: potentiometer: mcp4131: Fix alignment for DMA safety
      iio: pressure: dlhl60d: Drop unnecessary alignment forcing.
      iio: proximity: as3935: Fix alignment for DMA safety
      iio: proximity: vcnl3020: Drop unnecessary alignment requirement for =
i2c device
      iio: resolver: ad2s1200: Fix alignment for DMA safety
      iio: resolver: ad2s90: Fix alignment for DMA safety
      iio: temp: ltc2983: Fix alignment for DMA safety
      iio: temp: max31865: Fix alignment for DMA safety
      iio: temp: maxim_thermocouple: Fix alignment for DMA safety
      iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() etc
      iio: humidity: hts221: Use EXPORT_SIMPLE_DEV_PM_OPS() to allow compil=
er to remove dead code.
      iio: humidity: hts221: Move symbol exports into IIO_HTS221 namespace
      iio: imu: lsm6dsx: Use new pm_sleep_ptr() and EXPORT_SIMPLE_DEV_PM_OP=
S()
      iio: imu: lsm6dsx: Move exported symbols to the IIO_LSM6DSX namespace
      Merge branch 'immutable-qcom-spmi-rradc' into togreg
      iio: imu: bmi160: Move exported symbols to IIO_BMI160 namespace
      iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace
      iio: chemical: sps30: Move symbol exports into IIO_SPS30 namespace

Julia Lawall (2):
      iio: proximity: ping: fix typo in comment
      iio: chemical: bme680: fix typo in comment

Kai-Heng Feng (1):
      iio: light: cm32181: Add PM support

Kory Maincent (2):
      iio: dac: mcp4922: add support to mcp4921
      dt-bindings: iio: dac: mcp4922: expand for mcp4921 support

LI Qingwu (11):
      iio: accel: bmi088: Modified the scale calculate
      iio: accel: bmi088: Make it possible to config scales
      iio: accel: bmi088: modified the device name
      iio: accel: bmi088: Add support for bmi085 accel
      iio: accel: bmi088: Add support for bmi090l accel
      dt-bindings: iio: accel: Add bmi085 and bmi090l bindings
      dt-bindings: iio: accel: sca3300: Document murata,scl3300
      iio: accel: sca3300: add define for temp channel for reuse.
      iio: accel: sca3300: modified to support multi chips
      iio: accel: sca3300: Add support for SCL3300
      iio: accel: sca3300: Add inclination channels

Li Zhengyu (1):
      iio: srf08: Remove redundant if statement

Luca Weiss (1):
      proximity: vl53l0x: Make VDD regulator actually optional

Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/iio to IIO SUBSYSTEM AND DRIVERS

Marcus Folkesson (2):
      iio: adc: ti-tsc2046: do not explicity set INDIO_BUFFER_TRIGGERED mode
      iio: adc: ad778-1: do not explicity set INDIO_BUFFER_TRIGGERED mode

Marek Vasut (1):
      dt-bindings: iio/accel: Fix adi,adxl345/6 example I2C address

Markuss Broks (4):
      dt-bindings: proximity: vl53l0x: Document optional supply and GPIO pr=
operties
      proximity: vl53l0x: Prefer pre-initialized interrupt flags
      proximity: vl53l0x: Handle the VDD regulator
      proximity: vl53l0x: Handle the reset GPIO

Nuno S=C3=A1 (19):
      iio: adc: ad7606: explicitly add proper header files
      iio: adc: ad7606_par: explicitly add proper header files
      iio: adc: berlin2-adc: explicitly add proper header files
      iio: adc: imx7d_adc: explicitly add proper header files
      iio: adc: imx8qxp-adc: explicitly add proper header files
      iio: adc: ingenic-adc: explicitly add proper header files
      iio: adc: mp2629_adc: explicitly add proper header files
      iio: adc: mt6360-adc: explicitly add proper header files
      iio: adc: npcm_adc: explicitly add proper header files
      iio: adc: rzg2l_adc: explicitly add proper header files
      iio: common: cros_ec_lid_angle: explicitly add proper header files
      iio: common: cros_ec_sensors: explicitly add proper header files
      iio: dac: stm32-dac: explicitly add proper header files
      iio: dac: vf610_dac: explicitly add proper header files
      iio: humidity: hts221_buffer: explicitly add proper header files
      iio: light: cros_ec_light_prox: explicitly add proper header files
      iio: pressure: cros_ec_baro: explicitly add proper header files
      iio: trigger: stm32-lptimer-trigger: explicitly add proper header fil=
es
      iio: core: drop of.h from iio.h

Olivier Moysan (2):
      iio: adc: stm32-adc: make safe adc disable
      iio: adc: stm32-adc: disable adc before calibration

Paul Cercueil (2):
      iio: imu: st_lsm6dsx: Limit requested watermark value to hwfifo size
      iio: at91-sama5d2: Limit requested watermark value to hwfifo size

Peter Rosin (2):
      dt-bindings: iio: ti-dac5571: Add ti,dac121c081
      iio: dac: ti-dac5571: add support for ti,dac121c081

Sebastian Andrzej Siewior (1):
      iio: adc: stm32-adc: Use generic_handle_domain_irq()

Stephen Boyd (2):
      dt-bindings: iio: sx9324: Add CS idle/sleep mode
      iio: sx9324: Add setting for CS idle mode

Tetsuo Handa (2):
      iio: light: tsl2563: Replace flush_scheduled_work() with cancel_delay=
ed_work_sync().
      iio:light:tsl2563: Replace cancel_delayed_work() with cancel_delayed_=
work_sync().

Uwe Kleine-K=C3=B6nig (19):
      iio:accel:mc3230: Remove duplicated error reporting in .remove()
      iio:accel:stk8312: Remove duplicated error reporting in .remove()
      iio:accel:stk8ba50: Remove duplicated error reporting in .remove()
      iio:light:bh1780: Remove duplicated error reporting in .remove()
      iio:light:isl29028: Remove duplicated error reporting in .remove()
      iio:light:jsa1212: Remove duplicated error reporting in .remove()
      iio:light:opt3001: Remove duplicated error reporting in .remove()
      iio:light:stk3310: Remove duplicated error reporting in .remove()
      iio:light:tsl2583: Remove duplicated error reporting in .remove()
      iio: health: afe4404: Remove duplicated error reporting in .remove()
      iio:adc:ina2xx: Improve error reporting for problems during .remove()
      iio:adc:ti-ads1015: Improve error reporting for problems during .remo=
ve()
      iio:chemical:atlas: Improve error reporting for problems during .remo=
ve()
      iio:chemical:ccs811: Improve error reporting for problems during .rem=
ove()
      iio:light:pa12203001: Improve error reporting for problems during .re=
move()
      iio:light:us5182d: Improve error reporting for problems during .remov=
e()
      iio:light:vcnl4000: Improve error reporting for problems during .remo=
ve()
      iio:light:vcnl4035: Improve error reporting for problems during .remo=
ve()
      iio:magnetometer:mbc150: Make bmc150_magn_remove() return void

William Breathitt Gray (2):
      iio: adc: stx104: Utilize iomap interface
      iio: dac: cio-dac: Utilize iomap interface

Xiang wangx (2):
      iio: accel: sca3000: Fix syntax errors in comments
      iio: gyro: bmg160: Fix typo in comment

keliu (1):
      iio: Directly use ida_alloc()/free()

 Documentation/ABI/testing/sysfs-bus-iio            |    5 +
 .../bindings/iio/accel/adi,adis16240.yaml          |    2 +-
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |    2 +-
 .../bindings/iio/accel/bosch,bmi088.yaml           |    2 +
 .../bindings/iio/accel/murata,sca3300.yaml         |    1 +
 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |    1 -
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |    1 -
 .../bindings/iio/adc/qcom,spmi-rradc.yaml          |   51 +
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |   28 +-
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |    2 +-
 .../bindings/iio/dac/microchip,mcp4922.yaml        |    1 +
 .../devicetree/bindings/iio/dac/ti,dac5571.yaml    |    1 +
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml |    2 +-
 .../bindings/iio/proximity/semtech,sx9324.yaml     |   39 +
 .../bindings/iio/proximity/semtech,sx9360.yaml     |    9 +
 .../bindings/iio/proximity/st,vl53l0x.yaml         |    5 +
 MAINTAINERS                                        |    1 +
 drivers/iio/accel/Kconfig                          |    2 +
 drivers/iio/accel/adxl313_core.c                   |    2 +-
 drivers/iio/accel/adxl355_core.c                   |    2 +-
 drivers/iio/accel/adxl367.c                        |   48 +-
 drivers/iio/accel/adxl367_spi.c                    |    8 +-
 drivers/iio/accel/bma220_spi.c                     |    2 +-
 drivers/iio/accel/bma400.h                         |   50 +-
 drivers/iio/accel/bma400_core.c                    |  710 +++++++++++++-
 drivers/iio/accel/bma400_i2c.c                     |   10 +-
 drivers/iio/accel/bma400_spi.c                     |    8 +-
 drivers/iio/accel/bmi088-accel-core.c              |   99 +-
 drivers/iio/accel/bmi088-accel-spi.c               |   17 +-
 drivers/iio/accel/bmi088-accel.h                   |    9 +-
 drivers/iio/accel/cros_ec_accel_legacy.c           |    2 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    2 +-
 drivers/iio/accel/kxsd9-spi.c                      |    2 +-
 drivers/iio/accel/kxsd9.c                          |   11 +-
 drivers/iio/accel/mc3230.c                         |    4 +-
 drivers/iio/accel/mma7660.c                        |    6 +-
 drivers/iio/accel/sca3000.c                        |    6 +-
 drivers/iio/accel/sca3300.c                        |  325 +++++--
 drivers/iio/accel/stk8312.c                        |    4 +-
 drivers/iio/accel/stk8ba50.c                       |    4 +-
 drivers/iio/adc/Kconfig                            |   17 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7266.c                           |    4 +-
 drivers/iio/adc/ad7280a.c                          |    2 +-
 drivers/iio/adc/ad7292.c                           |    2 +-
 drivers/iio/adc/ad7298.c                           |    2 +-
 drivers/iio/adc/ad7476.c                           |    5 +-
 drivers/iio/adc/ad7606.c                           |    1 +
 drivers/iio/adc/ad7606.h                           |    4 +-
 drivers/iio/adc/ad7606_par.c                       |    1 +
 drivers/iio/adc/ad7766.c                           |    5 +-
 drivers/iio/adc/ad7768-1.c                         |    6 +-
 drivers/iio/adc/ad7887.c                           |    5 +-
 drivers/iio/adc/ad7923.c                           |    4 +-
 drivers/iio/adc/ad7949.c                           |    2 +-
 drivers/iio/adc/ad9467.c                           |    1 +
 drivers/iio/adc/adi-axi-adc.c                      |   11 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    2 +-
 drivers/iio/adc/berlin2-adc.c                      |    2 +
 drivers/iio/adc/hi8435.c                           |    2 +-
 drivers/iio/adc/imx7d_adc.c                        |    1 +
 drivers/iio/adc/imx8qxp-adc.c                      |    1 +
 drivers/iio/adc/ina2xx-adc.c                       |   10 +-
 drivers/iio/adc/ingenic-adc.c                      |    2 +
 drivers/iio/adc/intel_mrfld_adc.c                  |    1 +
 drivers/iio/adc/lpc18xx_adc.c                      |    3 +-
 drivers/iio/adc/ltc2496.c                          |    4 +-
 drivers/iio/adc/ltc2497.c                          |    4 +-
 drivers/iio/adc/max1027.c                          |    2 +-
 drivers/iio/adc/max11100.c                         |    4 +-
 drivers/iio/adc/max1118.c                          |    2 +-
 drivers/iio/adc/max1241.c                          |    2 +-
 drivers/iio/adc/mcp320x.c                          |    2 +-
 drivers/iio/adc/meson_saradc.c                     |  177 ++--
 drivers/iio/adc/mp2629_adc.c                       |    1 +
 drivers/iio/adc/mt6360-adc.c                       |    1 +
 drivers/iio/adc/nau7802.c                          |   16 +-
 drivers/iio/adc/npcm_adc.c                         |    1 +
 drivers/iio/adc/qcom-spmi-rradc.c                  | 1022 ++++++++++++++++=
++++
 drivers/iio/adc/rzg2l_adc.c                        |    4 +-
 drivers/iio/adc/sc27xx_adc.c                       |   15 +-
 drivers/iio/adc/stm32-adc-core.c                   |    2 +-
 drivers/iio/adc/stm32-adc.c                        |    6 +
 drivers/iio/adc/stx104.c                           |   56 +-
 drivers/iio/adc/ti-adc0832.c                       |    2 +-
 drivers/iio/adc/ti-adc084s021.c                    |    4 +-
 drivers/iio/adc/ti-adc108s102.c                    |    4 +-
 drivers/iio/adc/ti-adc12138.c                      |    2 +-
 drivers/iio/adc/ti-adc128s052.c                    |    2 +-
 drivers/iio/adc/ti-adc161s626.c                    |    2 +-
 drivers/iio/adc/ti-ads1015.c                       |    8 +-
 drivers/iio/adc/ti-ads124s08.c                     |    2 +-
 drivers/iio/adc/ti-ads131e08.c                     |    2 +-
 drivers/iio/adc/ti-ads7950.c                       |    4 +-
 drivers/iio/adc/ti-ads8344.c                       |    2 +-
 drivers/iio/adc/ti-ads8688.c                       |    2 +-
 drivers/iio/adc/ti-tlc4541.c                       |    4 +-
 drivers/iio/adc/ti-tsc2046.c                       |    2 +-
 drivers/iio/adc/vf610_adc.c                        |   15 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |   69 +-
 drivers/iio/addac/ad74413r.c                       |   12 +-
 drivers/iio/amplifiers/ad8366.c                    |    4 +-
 drivers/iio/chemical/atlas-sensor.c                |    8 +-
 drivers/iio/chemical/bme680_core.c                 |    2 +-
 drivers/iio/chemical/ccs811.c                      |   10 +-
 drivers/iio/chemical/sps30.c                       |    2 +-
 drivers/iio/chemical/sps30_i2c.c                   |    1 +
 drivers/iio/chemical/sps30_serial.c                |    1 +
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |    1 +
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |    1 +
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   30 +-
 drivers/iio/common/ssp_sensors/ssp.h               |    3 +-
 drivers/iio/dac/Kconfig                            |    2 +-
 drivers/iio/dac/ad5064.c                           |    4 +-
 drivers/iio/dac/ad5360.c                           |    4 +-
 drivers/iio/dac/ad5380.c                           |    4 +-
 drivers/iio/dac/ad5421.c                           |    4 +-
 drivers/iio/dac/ad5449.c                           |    4 +-
 drivers/iio/dac/ad5504.c                           |    2 +-
 drivers/iio/dac/ad5592r-base.c                     |    2 +-
 drivers/iio/dac/ad5592r-base.h                     |    4 +-
 drivers/iio/dac/ad5686.h                           |    6 +-
 drivers/iio/dac/ad5755.c                           |    4 +-
 drivers/iio/dac/ad5761.c                           |    4 +-
 drivers/iio/dac/ad5764.c                           |    4 +-
 drivers/iio/dac/ad5766.c                           |    2 +-
 drivers/iio/dac/ad5770r.c                          |    2 +-
 drivers/iio/dac/ad5791.c                           |    2 +-
 drivers/iio/dac/ad7293.c                           |    2 +-
 drivers/iio/dac/ad7303.c                           |    4 +-
 drivers/iio/dac/ad8801.c                           |    2 +-
 drivers/iio/dac/cio-dac.c                          |   14 +-
 drivers/iio/dac/ltc2688.c                          |    4 +-
 drivers/iio/dac/mcp4922.c                          |   13 +-
 drivers/iio/dac/stm32-dac.c                        |    6 +-
 drivers/iio/dac/ti-dac082s085.c                    |    2 +-
 drivers/iio/dac/ti-dac5571.c                       |    5 +-
 drivers/iio/dac/ti-dac7311.c                       |    2 +-
 drivers/iio/dac/ti-dac7612.c                       |    4 +-
 drivers/iio/dac/vf610_dac.c                        |    1 +
 drivers/iio/frequency/ad9523.c                     |    6 +-
 drivers/iio/frequency/adf4350.c                    |    6 +-
 drivers/iio/frequency/adf4371.c                    |    2 +-
 drivers/iio/frequency/admv1013.c                   |    2 +-
 drivers/iio/frequency/admv1014.c                   |    2 +-
 drivers/iio/frequency/admv4420.c                   |    2 +-
 drivers/iio/frequency/adrf6780.c                   |    2 +-
 drivers/iio/gyro/adis16080.c                       |    2 +-
 drivers/iio/gyro/adis16130.c                       |    2 +-
 drivers/iio/gyro/adxrs450.c                        |    2 +-
 drivers/iio/gyro/bmg160_core.c                     |    2 +-
 drivers/iio/gyro/fxas21002c_core.c                 |    6 +-
 drivers/iio/gyro/mpu3050-core.c                    |   14 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |    2 +-
 drivers/iio/health/afe4404.c                       |    4 +-
 drivers/iio/humidity/hts221_buffer.c               |    1 +
 drivers/iio/humidity/hts221_core.c                 |   12 +-
 drivers/iio/humidity/hts221_i2c.c                  |    3 +-
 drivers/iio/humidity/hts221_spi.c                  |    3 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |    6 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |    1 +
 drivers/iio/imu/bmi160/bmi160_spi.c                |    1 +
 drivers/iio/imu/fxos8700_core.c                    |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |    2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h |    2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   16 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c        |    5 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    3 +-
 drivers/iio/industrialio-buffer.c                  |   66 +-
 drivers/iio/industrialio-core.c                    |   70 +-
 drivers/iio/industrialio-sw-device.c               |    2 +-
 drivers/iio/industrialio-sw-trigger.c              |    2 +-
 drivers/iio/industrialio-trigger.c                 |   37 +-
 drivers/iio/light/bh1780.c                         |    7 +-
 drivers/iio/light/cm32181.c                        |   22 +
 drivers/iio/light/cros_ec_light_prox.c             |    3 +-
 drivers/iio/light/isl29028.c                       |    4 +-
 drivers/iio/light/jsa1212.c                        |    4 +-
 drivers/iio/light/opt3001.c                        |    3 +-
 drivers/iio/light/pa12203001.c                     |    8 +-
 drivers/iio/light/stk3310.c                        |    4 +-
 drivers/iio/light/tsl2563.c                        |    7 +-
 drivers/iio/light/tsl2583.c                        |    4 +-
 drivers/iio/light/us5182d.c                        |    8 +-
 drivers/iio/light/vcnl4000.c                       |    8 +-
 drivers/iio/light/vcnl4035.c                       |   10 +-
 drivers/iio/magnetometer/bmc150_magn.c             |    3 +-
 drivers/iio/magnetometer/bmc150_magn.h             |    2 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c         |    4 +-
 drivers/iio/potentiometer/ad5110.c                 |    4 +-
 drivers/iio/potentiometer/ad5272.c                 |    2 +-
 drivers/iio/potentiometer/max5481.c                |    2 +-
 drivers/iio/potentiometer/mcp41010.c               |    2 +-
 drivers/iio/potentiometer/mcp4131.c                |    2 +-
 drivers/iio/pressure/bmp280-core.c                 |    2 +-
 drivers/iio/pressure/bmp280-i2c.c                  |    1 +
 drivers/iio/pressure/bmp280-regmap.c               |    4 +-
 drivers/iio/pressure/bmp280-spi.c                  |    1 +
 drivers/iio/pressure/cros_ec_baro.c                |    3 +-
 drivers/iio/pressure/dlhl60d.c                     |    2 +-
 drivers/iio/proximity/as3935.c                     |    2 +-
 drivers/iio/proximity/ping.c                       |    2 +-
 drivers/iio/proximity/srf04.c                      |   11 +-
 drivers/iio/proximity/srf08.c                      |    2 +-
 drivers/iio/proximity/sx9324.c                     |   76 +-
 drivers/iio/proximity/sx9360.c                     |   15 +-
 drivers/iio/proximity/vcnl3020.c                   |    4 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |   55 +-
 drivers/iio/resolver/ad2s1200.c                    |    2 +-
 drivers/iio/resolver/ad2s90.c                      |    2 +-
 drivers/iio/temperature/ltc2983.c                  |    4 +-
 drivers/iio/temperature/max31865.c                 |    2 +-
 drivers/iio/temperature/maxim_thermocouple.c       |    2 +-
 drivers/iio/trigger/stm32-lptimer-trigger.c        |    4 +-
 drivers/mfd/qcom-spmi-pmic.c                       |  272 ++++--
 drivers/spmi/spmi.c                                |   17 +
 include/linux/iio/common/cros_ec_sensors_core.h    |    2 -
 include/linux/iio/iio.h                            |   14 +-
 include/linux/iio/trigger.h                        |    5 +
 include/linux/spmi.h                               |    3 +
 include/soc/qcom/qcom-spmi-pmic.h                  |   61 ++
 223 files changed, 3287 insertions(+), 909 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rra=
dc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h
