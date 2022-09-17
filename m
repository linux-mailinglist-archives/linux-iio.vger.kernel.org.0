Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5FB5BB854
	for <lists+linux-iio@lfdr.de>; Sat, 17 Sep 2022 15:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIQNDP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Sep 2022 09:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIQNDO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Sep 2022 09:03:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD6333435
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 06:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 064FEB80D4B
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 13:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9257C433D6;
        Sat, 17 Sep 2022 13:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663419788;
        bh=JJ8+v+vS+0UIbJLWToCoSb3rdjYygA3n2t34lT40ib8=;
        h=Date:From:To:Subject:From;
        b=AyqybZ+OxtA+L3D3rIhaQ1D4/OnXKT8fpduIaxL8iI8dMQ0SRnLYE1EgwMP0m0avJ
         w8Pe96uXg7UYUWNTYV5pX0EvzyFaJPqwQc0ynGLzfLiWyAB6rXNyImsxvNTrn7QOht
         fum+DnDM8RSQnfeTTwCGGS+sNjgDYXDy03ViMiHG5dXKQ2s0/0Z5tZgZaOhQvqBOjy
         UP8qIeTTx+Lq+vfCN5KsgTEjOJuvpYIrTtZU1zeoF6HLdT6wTefpX5yrLN7joc+LxZ
         X8cygxLvSjno69AMXSffj+ujqMUQRmxwkzGE3un5coyerfFnMFkQM+0sh8QxavNngP
         +qsGqOQVuZ6yQ==
Date:   Sat, 17 Sep 2022 14:03:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of new device support, cleanup and features for
 the 6.1 cycle.
Message-ID: <20220917140311.733566ae@jic23-huawei>
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

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.1a

for you to fetch changes up to 2f61ff8272967c9bdcba810aa978170814b08f7c:

  iio: pressure: icp10100: Switch from UNIVERSAL to DEFINE_RUNTIME_DEV_PM_O=
PS(). (2022-09-05 18:08:42 +0100)

----------------------------------------------------------------
1st set of IIO new device support, features and cleanup for 6.1

This includes Nuno Sa's work to move the IIO core over to generic firmware
properties rather than having DT specific code paths. Combined with Andy
Shevchenko's long term work on drivers, this leaves IIO in a good state for
handling other firmware types.

New device support
- liteon,ltrf216a
  * New driver and dt bindings to support this Light sensor.
- maxim,max11205
  * New driver for this 16bit single channel ADC.
- memsensing,msa311
  * New driver for this accelerometer. Includes a string helper for read/wr=
ite.
- richtek,rtq6056
  * New driver and dt binding to support this current monitor used to measu=
re
    power usage.
- yamaha,yas530
  * Support the YAS537 variant (series includes several fixes for other par=
ts
    and new driver features).

Staging graduation
- adi,ad7746 CDC. Cleanup conducted against set of roadtest tests using
  the posted RFC of that framework.

Features
- core
  * Large rework to make all the core IIO code use generic firmware propert=
ies.
    Includes switching some drivers over as well using newly provided
    generic interfaces and allowing removal of DT specific ones.
  * Support for gesture event types for single and double tap. Used in
    bosch,bma400.
- atmel,at91-sama5d2
  * Add support for temperature sensor which uses two muxed inputs to estim=
ate
    the temperature.
  * Handle trackx bits of EMR register to improve temp sampling accuracy.
  * Runtime PM support.
- liteon,ltrf216a
  * Add a _raw channel output to allow working around an issue with
    differing conversions equations that breaks some user space controls.
- mexelis,mlx90632
  * Support regulator control.
- ti,tsc2046
  * External reference voltage support.

Clean up and minor fixes
- Tree-wide
  * devm_clk_get_enabled() replacements of opencoded equivalent.
  * Remaining IIO_DMA_MINALIGN conversions (the staging/iio drivers).
  * Various minor warning and similar cleanup such as missing static
    markings.
  * strlcpy() to strscpy() for cases where return value not checked.
  * provide units.h entries for more HZ units and use them in drivers.
- dt-bindings cleanup
  * Drop maintainers listss where the email address is bouncing.
  * Switch spi devices over to using spi-peripheral.yaml
  * Add some missing unevaluatedProperties / additionalProperties: false
    entries.
- ABI docs
  * Add some missing channel type specific sampling frequency entries.
  * Add parameter names for callback parameters.
- MAINTAINERS
  * Fix wrong ADI forum links.
- core
  * lockdep class per device, to avoid an issue with nest when one IIO
    device is the consumer of another.
  * White space tweaks.
- asc,dlhl60d
  * Use get_unaligned_be24 to avoid some unusual data manipulation and mask=
ing.
- atmel,at91-sama5d2
  * Fix wrong max value.
  * Improve error handling when measuring pressure and touch.
  * Add locks to remove races on updating oversampling / sampling freq.
  * Add missing calls in suspend and resume path to ensure state is correct=
ly
    brought up if buffered capture was in use when suspend happened.
  * Error out of write_raw() callback if buffered capture enabled to avoid
    unpredictable behavior.
  * Handle different versions having different oversampling ratio support a=
nd
    drop excess error checking.
  * Cleanup magic value defines where the name is just the value and hence
    hurts readability.
  * Use read_avail() callback to provide info on possible oversampling rati=
os.
  * Correctly handle variable bit depth when doing oversampling on different
    supported parts. Also handle higher oversampling ratios.
- fsl,imx8qxp
  * Don't ignore errors from regulator_get_voltage() so as to avoid some
    very surprising scaling.
- invensense,icp10100
  * Switch from UNIVERSAL to DEFINE_RUNTIME_DEV_PM_OPS. UNIVERSAL rarely ma=
de
    sense and is now deprecated. In this driver we just avoid double disabl=
ing
    in some paths.
- maxim,max1363
  * Drop consumer channel map provision by platform data. There have been
    better ways of doing this for years and there are no in tree users.
- microchip,mcp3911
  * Update status to maintained.
- qcom,spmi-adc5
  * Support measurement of LDO output voltage.
- qcom,spmi-adc
  * Add missing channel available on SM6125 SoC.
- st,stmpe
  * Drop requirement on node name in binding now that driver correctly
    doesn't enforce it.
- stx104
  * Move to more appropriate addac directory
- ti,am335x
  * Document ti,am654-adc compatible already in use in tree.
- ti,hmc5843
  * Move dev_pm_ops out of header and use new pm macros to handle export.
- yamaha,yas530
  * Minor cleanups.

----------------------------------------------------------------
Andy Shevchenko (5):
      iio: pressure: dlhl60d: Don't take garbage into consideration when re=
ading data
      lib/string_helpers: Add str_read_write() helper
      iio: magnetometer: yamaha-yas530: Use pointers as driver data
      iio: magnetometer: yamaha-yas530: Make strings const in chip info
      iio: magnetometer: yamaha-yas530: Use dev_err_probe()

Antoniu Miclaus (2):
      iio: frequency: admv1014: return -EINVAL directly
      MAINTAINERS: fix Analog Devices forum links

ChiYuan Huang (3):
      dt-bindings: iio: adc: Add rtq6056 adc support
      iio: adc: Add rtq6056 support
      Documentation: ABI: testing: rtq6056: Update ABI docs

Claudiu Beznea (19):
      iio: adc: at91-sama5d2_adc: fix AT91_SAMA5D2_MR_TRACKTIM_MAX
      iio: adc: at91-sama5d2_adc: check return status for pressure and touch
      iio: adc: at91-sama5d2_adc: lock around oversampling and sample freq
      iio: adc: at91-sama5d2_adc: disable/prepare buffer on suspend/resume
      iio: adc: at91-sama5d2_adc: exit from write_raw() when buffers are en=
abled
      iio: adc: at91-sama5d2_adc: handle different EMR.OSR for different hw=
 versions
      iio: adc: at91-sama5d2_adc: move the check of oversampling in its fun=
ction
      iio: adc: at91-sama5d2_adc: drop AT91_OSR_XSAMPLES defines
      iio: adc: at91-sama5d2_adc: add .read_avail() chan_info ops
      iio: adc: at91-sama5d2_adc: adjust osr based on specific platform data
      iio: adc: at91-sama5d2_adc: add 64 and 256 oversampling ratio
      iio: adc: at91-sama5d2_adc: move oversampling storage in its function
      iio: adc: at91-sama5d2_adc: update trackx on emr
      iio: adc: at91-sama5d2_adc: add startup and tracktim as parameter for=
 at91_adc_setup_samp_freq()
      iio: adc: at91-sama5d2_adc: lock around at91_adc_read_info_raw()
      dt-bindings: iio: adc: at91-sama5d2_adc: add id for temperature chann=
el
      iio: adc: at91-sama5d2_adc: add support for temperature sensor
      iio: adc: at91-sama5d2_adc: add empty line after functions
      iio: adc: at91-sama5d2_adc: add runtime pm support

Crt Mori (2):
      iio: temperature: mlx90632 Add supply regulator to sensor
      dt-bindings: iio: mlx90632 Add supply regulator documentation

Dmitry Rokosov (6):
      units: complement the set of Hz units
      iio: accel: adxl345: use HZ macro from units.h
      iio: common: scmi_sensors: use HZ macro from units.h
      dt-bindings: vendor-prefixes: add MEMSensing Microsystems Co., Ltd.
      iio: add MEMSensing MSA311 3-axis accelerometer driver
      dt-bindings: iio: accel: add dt-binding schema for msa311 accel driver

Francesco Dolcini (1):
      dt-bindings: iio: adc: stmpe: Remove node name requirement

Jagath Jog J (2):
      iio: Add new event type gesture and use direction for single and doub=
le tap
      iio: accel: bma400: Add support for single and double tap events

Jakob Hauser (14):
      iio: magnetometer: yas530: Change data type of hard_offsets to signed
      iio: magnetometer: yas530: Change range of data in volatile register
      iio: magnetometer: yas530: Correct scaling of magnetic axes
      iio: magnetometer: yas530: Correct temperature handling
      iio: magnetometer: yas530: Change data type of calibration coefficien=
ts
      iio: magnetometer: yas530: Rename functions and registers
      iio: magnetometer: yas530: Move printk %*ph parameters out from stack
      iio: magnetometer: yas530: Apply documentation and style fixes
      iio: magnetometer: yas530: Introduce "chip_info" structure
      iio: magnetometer: yas530: Add volatile registers to "chip_info"
      iio: magnetometer: yas530: Add IIO scaling to "chip_info"
      iio: magnetometer: yas530: Add temperature calculation to "chip_info"
      iio: magnetometer: yas530: Add function pointers to "chip_info"
      iio: magnetometer: yas530: Add YAS537 variant

Joe Simmons-Talbott (4):
      iio: Add blank lines after declarations.
      iio: Fix indentation for multiline conditional.
      iio: Add names for function definition arguments.
      iio: Avoid multiple line dereference for mask

Jonathan Cameron (26):
      iio: ABI: Fix wrong format of differential capacitance channel ABI.
      staging: iio: cdc: ad7746: Use explicit be24 handling.
      staging: iio: cdc: ad7746: Push handling of supply voltage scale to u=
serspace.
      staging: iio: cdc: ad7746: Use local buffer for multi byte reads.
      staging: iio: cdc: ad7746: Factor out ad7746_read_channel()
      staging: iio: cdc: ad7764: Push locking down into case statements in =
read/write_raw
      staging: iio: cdc: ad7746: Break up use of chan->address and use FIEL=
D_PREP etc
      staging: iio: cdc: ad7746: Drop unused i2c_set_clientdata()
      staging: iio: cdc: ad7746: Use _raw and _scale for temperature channe=
ls.
      iio: core: Introduce _zeropoint for differential channels
      staging: iio: cdc: ad7746: Switch from _offset to _zeropoint for diff=
erential channels.
      staging: iio: cdc: ad7746: Use read_avail() rather than opencoding.
      staging: iio: ad7746: White space cleanup
      iio: cdc: ad7746: Add device specific ABI documentation.
      iio: cdc: ad7746: Move driver out of staging.
      iio: test: Mark file local structure arrays static.
      iio: light: cm32181: Mark the dev_pm_ops static.
      staging: iio: frequency: ad9834: Fix alignment for DMA safety
      staging: iio: meter: ade7854: Fix alignment for DMA safety
      staging: iio: resolver: ad2s1210: Fix alignment for DMA safety
      iio: adc: mt6360: Drop an incorrect __maybe_unused marking.
      iio: magn: hmc5843: Drop excessive indentation of assignments of hmc5=
843_driver
      iio: magn: hmc5843: Move struct dev_pm_ops out of header
      staging: iio: frequency: ad9832: Fix alignment for DMA safety
      iio: adc: max1363: Drop provision to provide an IIO channel map via p=
latform data
      iio: pressure: icp10100: Switch from UNIVERSAL to DEFINE_RUNTIME_DEV_=
PM_OPS().

Krzysztof Kozlowski (14):
      dt-bindings: iio: adc: ti,am3359-adc: add ti,am654-adc
      dt-bindings: iio: Drop Tomislav Denis
      iio: MAINTAINERS: Drop Tomislav Denis
      dt-bindings: iio: adc: Drop Patrick Vasseur
      dt-bindings: iio: adc: use spi-peripheral-props.yaml
      dt-bindings: iio: accel: use spi-peripheral-props.yaml
      dt-bindings: iio: amplifiers: adi,ada4250: use spi-peripheral-props.y=
aml
      dt-bindings: iio: dac: use spi-peripheral-props.yaml
      dt-bindings: iio: frequency: adf4371: use spi-peripheral-props.yaml
      dt-bindings: iio: health: ti,afe4403: use spi-peripheral-props.yaml
      dt-bindings: iio: imu: use spi-peripheral-props.yaml
      dt-bindings: iio: potentiometer: use spi-peripheral-props.yaml
      dt-bindings: iio: samsung,sensorhub-rinato: use spi-peripheral-props.=
yaml
      dt-bindings: iio: temperature: use spi-peripheral-props.yaml

Marcus Folkesson (1):
      MAINTAINERS: Update Microchip MCP3911 to Maintained

Marijn Suijten (1):
      iio: adc: qcom-spmi-adc5: Add missing VCOIN/GPIO[134] channels

Martin Larsson (1):
      iio: adc: imx8qxp-adc: propagate regulator_get_voltage error

Nuno S=C3=A1 (15):
      iio: inkern: only release the device node when done with it
      iio: inkern: fix return value in devm_of_iio_channel_get_by_name()
      iio: inkern: only return error codes in iio_channel_get_*() APIs
      iio: inkern: split of_iio_channel_get_by_name()
      iio: inkern: move to fwnode properties
      thermal: qcom: qcom-spmi-adc-tm5: convert to IIO fwnode API
      iio: adc: ingenic-adc: convert to IIO fwnode interface
      iio: adc: ab8500-gpadc: convert to device properties
      iio: adc: at91-sama5d2_adc: convert to device properties
      iio: adc: qcom-pm8xxx-xoadc: convert to device properties
      iio: adc: qcom-spmi-vadc: convert to device properties
      iio: adc: qcom-spmi-adc5: convert to device properties
      iio: adc: stm32-adc: convert to device properties
      iio: inkern: remove OF dependencies
      iio: inkern: fix coding style warnings

Oleksij Rempel (3):
      dt-bindings: iio: adc: ti,tsc2046: add vref-supply property
      iio: adc: tsc2046: add vref support
      iio: adc: tsc2046: silent spi_device_id warning

Ramona Bolboaca (2):
      dt-bindings: iio: adc: Add max11205 documentation file
      iio: adc: add max11205 adc driver

Rob Herring (1):
      dt-bindings: iio: Add missing (unevaluated|additional)Properties on c=
hild nodes

Robert Marko (1):
      iio: adc: qcom-spmi-adc5: add ADC5_VREF_VADC to rev2 ADC5

Shreeya Patel (3):
      dt-bindings: Document ltrf216a light sensor bindings
      iio: light: Add support for ltrf216a sensor
      iio: light: ltrf216a: Add raw attribute

Uwe Kleine-K=C3=B6nig (11):
      iio: adc: ad7124: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: ad7768-1: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: ad9467: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: ingenic-adc: Benefit from devm_clk_get_prepared() to simpli=
fy
      iio: adc: lpc18xx: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: ti-ads131e08: Benefit from devm_clk_get_enabled() to simpli=
fy
      iio: adc: xilinx-ams: Benefit from devm_clk_get_enabled() to simplify
      iio: adc: xilinx-xadc: Benefit from devm_clk_get_enabled() to simplify
      iio: frequency: adf4371: Benefit from devm_clk_get_enabled() to simpl=
ify
      iio: frequency: adrf6780: Benefit from devm_clk_get_enabled() to simp=
lify
      iio: imu: adis16475: Benefit from devm_clk_get_enabled() to simplify

Vincent Whitchurch (1):
      iio: Use per-device lockdep class for mlock

William Breathitt Gray (1):
      iio: stx104: Move to addac subdirectory

Wolfram Sang (2):
      iio: st_sensors: move from strlcpy with unused retval to strscpy
      iio: imu: inv_mpu6050: move from strlcpy with unused retval to strscpy

wangjianli (1):
      iio/accel: fix repeated words in comments

 Documentation/ABI/testing/sysfs-bus-iio            |  101 +-
 Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746 |   11 +
 .../bindings/iio/accel/adi,adis16201.yaml          |    7 +-
 .../bindings/iio/accel/adi,adis16240.yaml          |    7 +-
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml |    7 +-
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |    7 +-
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |    7 +-
 .../devicetree/bindings/iio/accel/adi,adxl367.yaml |    7 +-
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |    7 +-
 .../bindings/iio/accel/bosch,bma220.yaml           |    7 +-
 .../bindings/iio/accel/bosch,bma255.yaml           |    5 +-
 .../bindings/iio/accel/bosch,bmi088.yaml           |    7 +-
 .../devicetree/bindings/iio/accel/fsl,mma7455.yaml |    7 +-
 .../bindings/iio/accel/kionix,kxsd9.yaml           |    7 +-
 .../bindings/iio/accel/memsensing,msa311.yaml      |   53 +
 .../bindings/iio/accel/murata,sca3300.yaml         |    5 +-
 .../bindings/iio/accel/nxp,fxls8962af.yaml         |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7280a.yaml   |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7292.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7298.yaml    |    6 +-
 .../devicetree/bindings/iio/adc/adi,ad7476.yaml    |    8 +-
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml  |    7 +-
 .../devicetree/bindings/iio/adc/adi,ad7923.yaml    |    8 +-
 .../devicetree/bindings/iio/adc/adi,ad7949.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/holt,hi8435.yaml   |    7 +-
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |    8 +-
 .../devicetree/bindings/iio/adc/maxim,max1027.yaml |    5 +-
 .../bindings/iio/adc/maxim,max11100.yaml           |    7 +-
 .../devicetree/bindings/iio/adc/maxim,max1118.yaml |   26 +-
 .../bindings/iio/adc/maxim,max11205.yaml           |   69 +
 .../devicetree/bindings/iio/adc/maxim,max1241.yaml |    7 +-
 .../bindings/iio/adc/microchip,mcp3201.yaml        |    6 +-
 .../bindings/iio/adc/microchip,mcp3911.yaml        |    5 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |    1 +
 .../bindings/iio/adc/richtek,rtq6056.yaml          |   56 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |    2 +
 .../devicetree/bindings/iio/adc/st,stmpe-adc.yaml  |    3 +-
 .../devicetree/bindings/iio/adc/ti,adc0832.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/ti,adc084s021.yaml |    7 +-
 .../devicetree/bindings/iio/adc/ti,adc108s102.yaml |    6 +-
 .../devicetree/bindings/iio/adc/ti,adc12138.yaml   |    7 +-
 .../devicetree/bindings/iio/adc/ti,adc128s052.yaml |    7 +-
 .../devicetree/bindings/iio/adc/ti,adc161s626.yaml |    7 +-
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |    1 +
 .../devicetree/bindings/iio/adc/ti,ads124s08.yaml  |    7 +-
 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  |    9 +-
 .../devicetree/bindings/iio/adc/ti,ads8344.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/ti,ads8688.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/ti,am3359-adc.yaml |   11 +-
 .../devicetree/bindings/iio/adc/ti,tlc4541.yaml    |    7 +-
 .../devicetree/bindings/iio/adc/ti,tsc2046.yaml    |    8 +-
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml          |    1 +
 .../bindings/iio/addac/adi,ad74413r.yaml           |    1 +
 .../bindings/iio/amplifiers/adi,ada4250.yaml       |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |    1 +
 .../devicetree/bindings/iio/dac/adi,ad5064.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5360.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5380.yaml    |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad5421.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5449.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5624r.yaml   |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml    |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad5755.yaml    |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml    |    4 +-
 .../devicetree/bindings/iio/dac/adi,ad5761.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5764.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |   11 +-
 .../devicetree/bindings/iio/dac/adi,ad5791.yaml    |    9 +-
 .../devicetree/bindings/iio/dac/adi,ad8801.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ltc2688.yaml   |    1 +
 .../bindings/iio/dac/microchip,mcp4922.yaml        |    9 +-
 .../devicetree/bindings/iio/dac/ti,dac082s085.yaml |    9 +-
 .../devicetree/bindings/iio/dac/ti,dac7311.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/ti,dac7612.yaml    |    7 +-
 .../devicetree/bindings/iio/frequency/adf4371.yaml |    7 +-
 .../devicetree/bindings/iio/health/ti,afe4403.yaml |    9 +-
 .../devicetree/bindings/iio/imu/adi,adis16460.yaml |    7 +-
 .../devicetree/bindings/iio/imu/adi,adis16480.yaml |    9 +-
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |    7 +-
 .../bindings/iio/imu/invensense,icm42600.yaml      |    6 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |    5 +-
 .../devicetree/bindings/iio/imu/nxp,fxos8700.yaml  |    7 +-
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    9 +-
 .../bindings/iio/light/liteon,ltrf216a.yaml        |   49 +
 .../iio/potentiometer/microchip,mcp41010.yaml      |    9 +-
 .../iio/potentiometer/microchip,mcp4131.yaml       |    9 +-
 .../bindings/iio/pressure/asc,dlhl60d.yaml         |    2 +-
 .../bindings/iio/samsung,sensorhub-rinato.yaml     |    9 +-
 .../bindings/iio/temperature/maxim,max31855k.yaml  |    4 +-
 .../bindings/iio/temperature/maxim,max31856.yaml   |    6 +-
 .../bindings/iio/temperature/maxim,max31865.yaml   |    6 +-
 .../bindings/iio/temperature/melexis,mlx90632.yaml |    4 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |   40 +-
 drivers/iio/accel/Kconfig                          |   13 +
 drivers/iio/accel/Makefile                         |    2 +
 drivers/iio/accel/adxl345_core.c                   |    7 +-
 drivers/iio/accel/bma400.h                         |   14 +
 drivers/iio/accel/bma400_core.c                    |  343 ++++-
 drivers/iio/accel/kxcjk-1013.c                     |    2 +-
 drivers/iio/accel/msa311.c                         | 1321 ++++++++++++++++=
++++
 drivers/iio/adc/Kconfig                            |   45 +-
 drivers/iio/adc/Makefile                           |    3 +-
 drivers/iio/adc/ab8500-gpadc.c                     |   27 +-
 drivers/iio/adc/ad7124.c                           |   15 +-
 drivers/iio/adc/ad7768-1.c                         |   17 +-
 drivers/iio/adc/ad9467.c                           |   17 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |  714 +++++++++--
 drivers/iio/adc/imx8qxp-adc.c                      |    8 +-
 drivers/iio/adc/ingenic-adc.c                      |   23 +-
 drivers/iio/adc/lpc18xx_adc.c                      |   18 +-
 drivers/iio/adc/max11205.c                         |  183 +++
 drivers/iio/adc/max1363.c                          |    6 -
 drivers/iio/adc/mt6360-adc.c                       |    2 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |   58 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |   73 +-
 drivers/iio/adc/qcom-spmi-vadc.c                   |   44 +-
 drivers/iio/adc/rtq6056.c                          |  661 ++++++++++
 drivers/iio/adc/stm32-adc.c                        |  128 +-
 drivers/iio/adc/ti-ads131e08.c                     |   19 +-
 drivers/iio/adc/ti-tsc2046.c                       |   69 +-
 drivers/iio/adc/xilinx-ams.c                       |   15 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |   18 +-
 drivers/iio/addac/Kconfig                          |   16 +
 drivers/iio/addac/Makefile                         |    1 +
 drivers/iio/{adc =3D> addac}/stx104.c                |    0
 drivers/iio/cdc/Kconfig                            |   10 +
 drivers/iio/cdc/Makefile                           |    1 +
 drivers/{staging =3D> }/iio/cdc/ad7746.c             |  441 ++++---
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    8 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    2 +-
 drivers/iio/frequency/adf4371.c                    |   17 +-
 drivers/iio/frequency/admv1014.c                   |    3 +-
 drivers/iio/frequency/adrf6780.c                   |   16 +-
 drivers/iio/imu/adis16475.c                        |   15 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |    4 +-
 drivers/iio/industrialio-buffer.c                  |    5 +-
 drivers/iio/industrialio-core.c                    |   19 +-
 drivers/iio/industrialio-event.c                   |   14 +-
 drivers/iio/industrialio-trigger.c                 |    1 +
 drivers/iio/inkern.c                               |  272 ++--
 drivers/iio/light/Kconfig                          |   11 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/cm32181.c                        |    2 +-
 drivers/iio/light/ltrf216a.c                       |  550 ++++++++
 drivers/iio/magnetometer/Kconfig                   |    4 +-
 drivers/iio/magnetometer/hmc5843.h                 |   13 +-
 drivers/iio/magnetometer/hmc5843_core.c            |    8 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |    2 +-
 drivers/iio/magnetometer/hmc5843_spi.c             |   14 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |  855 ++++++++++---
 drivers/iio/pressure/dlhl60d.c                     |    5 +-
 drivers/iio/pressure/icp10100.c                    |   10 +-
 drivers/iio/temperature/mlx90632.c                 |   61 +-
 drivers/iio/test/iio-test-rescale.c                |    4 +-
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/cdc/Kconfig                    |   17 -
 drivers/staging/iio/cdc/Makefile                   |    6 -
 drivers/staging/iio/frequency/ad9832.c             |    4 +-
 drivers/staging/iio/frequency/ad9834.c             |    2 +-
 drivers/staging/iio/meter/ade7854.h                |    2 +-
 drivers/staging/iio/resolver/ad2s1210.c            |    4 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |    3 +-
 include/dt-bindings/iio/adc/at91-sama5d2_adc.h     |    3 +
 include/linux/iio/consumer.h                       |   28 +-
 include/linux/iio/iio-opaque.h                     |    2 +
 include/linux/iio/iio.h                            |    8 +-
 include/linux/iio/types.h                          |    3 +
 include/linux/string_helpers.h                     |    5 +
 include/linux/units.h                              |    3 +
 include/uapi/linux/iio/types.h                     |    3 +
 tools/iio/iio_event_monitor.c                      |    8 +-
 176 files changed, 5990 insertions(+), 1351 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746
 create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,=
msa311.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1120=
5.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq60=
56.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf=
216a.yaml
 create mode 100644 drivers/iio/accel/msa311.c
 create mode 100644 drivers/iio/adc/max11205.c
 create mode 100644 drivers/iio/adc/rtq6056.c
 rename drivers/iio/{adc =3D> addac}/stx104.c (100%)
 rename drivers/{staging =3D> }/iio/cdc/ad7746.c (66%)
 create mode 100644 drivers/iio/light/ltrf216a.c
 delete mode 100644 drivers/staging/iio/cdc/Kconfig
 delete mode 100644 drivers/staging/iio/cdc/Makefile
