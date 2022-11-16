Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B013C62C83E
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 19:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiKPSxG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 13:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiKPSwe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 13:52:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A4663E0
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 10:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 035A661F53
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 18:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20E8C433D6;
        Wed, 16 Nov 2022 18:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668624643;
        bh=hE92SWG2MZSopN3ZDw3KPz7gU7z6jdfwbCi41K1t59w=;
        h=Date:From:To:Subject:From;
        b=k+1rmTihOfeuCujVo7gvJV4cyEVJrbRms8AsAG1rMjySYX/K5iFSqZWYjyPSCZEW1
         0nkZVXrbc+No9U8ScD2uTxIGvMJs1WzG+t56uNKk6kCcINNjNO6Cn+eGtyFJh+rdxV
         Jp5DyDxVuun1yqxKLpiDEa5CG7WeCP5jAGWdpxX5abqC3gaco+jIjVpnIU5KE6LEgu
         KJCHW+TB5kOaTTCPrxyGklcqGcHNYHwpAbgyARtygTNLEiIWpgz4NqKEfiWihkmgoY
         sSzTbvXgYQUxslKkpkGw7t7ji2cpYsSdEijQxOKaHKuc2a/mobxEHBaNCF2J8jAzaZ
         /99zSZbOL6BVQ==
Date:   Wed, 16 Nov 2022 19:03:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: First set of new device support, features and cleanup
 for 6.2
Message-ID: <20221116190308.76cfba5a@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.2a

for you to fetch changes up to 021882de1a48cffaa405aa8014bd1d48ca6d5c19:

  iio: pressure: bmp280: convert to i2c's .probe_new() (2022-11-14 20:39:09=
 +0000)

----------------------------------------------------------------
1st set of IIO new device support, feature and cleanup for 6.2

We have finally managed to take the mlock mutex entirely private so as
to avoid it being used for multiple purposes.  Now it is just used to
protect device mode transitions (typically to and from buffered capture).

Includes merge of an immutable i2c branch to get the new
i2c_client_get_device_id() (thanks to Wolfram for providing the branch).

Based on rc3 to pick up some precursor fixes from early in the cycle and
avoid an unnecessarily messy history.

New device support
* adi,ad4310
  - New driver to support this very flexible measurement device including
    a 24 bit ADC. Later fix for documentation build issue.
* adi,adxl355
  - Add support of the ADXL359 accelerometer.
* adi,ltc2983
  - Support additional variants of the temperatures sensor:
    LTC2984 with an EEPROM
    LTC2985, LTC2986 with only 10 channels.
* invensense,icm42600
  - Add support for icm42631 (needed only ID and WHOAMI)
* kionix,kx022a
  - New driver for this 3 axis accelerometer.
* maxim,max11401
  - New driver to support this 24-bit 10 channel ADC.
    Includes some new ABI to support configuration of notch filters.
* mediatek,mt6370
  - Add new driver to support the ADC part of the mt6370.
* st,lsm6dsx
  - Add support for LSM6DSV accelerometer and gyroscope. Simple additional
    of chip specific data and IDs.
  - Add support for LSM6DSV16X accelerometer and gyroscope.  Compatible with
    features currently implemented for the LSM6DSV.
* st,stm32-adc
  - Add support for stm32pm13x SoCs.

core / subsystem wide:
 - Add new IIO_STATIC_CONST_DEVICE_ATTR() which is a dance necessary to
   allow for the wrapping of attributes in the code that duplicates them
   for multiple buffers.
 - Harden against future issues with expectation that all buffer attributes
   are iio_dev_attrs by changing the code to take an array of pointers
   of the correct type.
 - Last transitions of drivers to local locks rather than missuses of mlock.
 - Add an iio_device_claim_buffer_mode() callback to avoid a race in the
   max30100 driver without directly using mlock.
 - Move mlock to the opaque IIO device structure to prevent misuse.
 - Add missing spi_device_id tables to support auto loading of modules.
 - Update some ADI maintainers in DT bindings.
 - A few more moves of bus drivers and core module sets to export
   name spaces.
 - Extensive use of new devm_regulator_get_enable() and friends.
 - Switch a bunch of i2c drivers to probe_new() including the bmp280
   which makes use of the new i2c_client_get_device_id() helper to
   simplify this change.

dt-bindings:
 - More use of spi-peripheral-props.yaml.

Features
* freescale,mpl115
  - Use runtime PM to implement shutdown GPIO support.
* melexis,mlx90632
  - More sophisticated runtime power management
  - Provide access to sampling frequency.
  - Trivial follow up fixes.
* microchip,mcp3911
  - Support control of PGA.
* st,lsm6dsx
  - Add support for software triggers for cases where the IRQ lines
    are not wired up.
* vishay,vcnl4000
  - Add control of integration time.

Minor cleanups and fixes
* adi,ad4130
  - Improve ABI documentation formatting.
  - Kconfig dependency fixup.
* adi,ad5758
  - Minor dt binding fix.
* adi,ad9834
  - Tidy up line breaks.
* adi,ade7854
  - Minor improvement in code clarity by replacing a ternary.
* adi,admv8818
  - Harden code against hardware returning wrong values.
* adi,adxl355
  - Warn only if unknown device ID detected to allow for fall back
    device tree compatibles on future devices.
* adi,ltc2983
  - dt-bindings clarifications and general improvements.
  - Ensure DMA safe buffer for bulk writes without relying on current
    regmap implementation choices.
* avago,adps9960
  - Fix up a disconnect between event enable attributes and what was
    enabled.
* bosch,bma400
  - Switch to dev_err_probe() from open coded EPROBE_DEFER handling.
* cosmic,cc10001
  - Fully devm managed probe() and related tidying up.
* meas,ms5611
  - Add an example of spi-max-frequency.
* meleixs,mlx90632
  - Tidy up confusing error return value.
  - Style improvements.
* multiplexer
  - Switch to dev_err_probe() from open coded EPROBE_DEFER handling.
* qcom,spmi-vadc
  - Minor dt binding improvements.
* rockchip,saradc
  - Add ID for rv1126.
* semtech,sx9360
  - Add SAMM0208 ACPI ID. Doesn't appear to be a valid vendor prefix
    but is in the wild.
* st,lsm6dsx
  - Factor out common code as _device_set_enable().
  - Fix up wrong docs after LSM6DSV addition.
* st,stm32-adc
  - Manage the min sampling time on all internal channels.
* trig,sysfs
  - Improve error labels.

----------------------------------------------------------------
Angel Iglesias (2):
      i2c: core: Introduce i2c_client_get_device_id helper function
      iio: pressure: bmp280: convert to i2c's .probe_new()

Bagas Sanjaya (1):
      Documentation: ad4130: format list of in_voltage-voltage_filter_mode_=
available modes

ChiaEn Wu (1):
      iio: adc: mt6370: Add MediaTek MT6370 support

Colin Ian King (1):
      iio: adc: ad4130: Fix spelling mistake "diffreential" -> "differentia=
l"

Cosmin Tanislav (16):
      dt-bindings: iio: adc: add AD4130
      iio: adc: ad4130: add AD4130 driver
      iio: temperature: ltc2983: make bulk write buffer DMA-safe
      dt-bindings: iio: temperature: ltc2983: add default values
      dt-bindings: iio: temperature: ltc2983: use hex for sensor address
      dt-bindings: iio: temperature: ltc2983: remove qutations from phandle=
 ref
      dt-bindings: iio: temperature: ltc2983: describe matrix items
      dt-bindings: iio: temperature: ltc2983: require custom sensor tables
      dt-bindings: iio: temperature: ltc2983: require 4 wire rtd for curren=
t rotate
      dt-bindings: iio: temperature: ltc2983: change default excitation for=
 custom thermistors
      dt-bindings: iio: temperature: ltc2983: refine descriptions
      dt-bindings: iio: temperature: ltc2983: describe broken mux delay pro=
perty
      dt-bindings: iio: temperature: ltc2983: use generic node name in exam=
ple
      dt-bindings: iio: temperature: ltc2983: support more parts
      iio: temperature: ltc2983: support more parts
      iio: adc: ad4130: depend on GPIOLIB

Crt Mori (4):
      iio: temperature: mlx90632 Add runtime powermanagement modes
      iio: temperature: mlx90632 Read sampling frequency
      iio: temperature: mlx90632 Change return value of sensor measurement =
channel
      iio: temperature: mlx90632 Style alignment for the driver

Deepak R Varma (2):
      staging: iio: frequency: ad9834: merge unnecessary split lines
      staging: iio: meter: replace ternary operator by if condition

Gwendal Grignou (1):
      iio: proximity: sx9360: Add a new ACPI hardware ID

Ibrahim Tilki (3):
      iio: adc: add max11410 adc driver
      dt-bindings: iio: adc: add adi,max11410.yaml
      Documentation: ABI: testing: add max11410 doc

Jagan Teki (1):
      dt-bindings: iio: adc: rockchip-saradc: Add saradc for rv1126

Jay Greco (2):
      iio: imu: inv_icm42600: Add support for icm42631
      dt-bindings: iio: imu: Add inv_icm42600 documentation

Jonathan Cameron (23):
      iio: accel: fxls8962af: Use new EXPORT_NS_GPL_DEV_PM_OPS()
      iio: gyro: fxas210002c: Move exports to IIO_FXAS210002C namespace.
      iio: imu: inv_icm42600: Move exports to IIO_ICM42600 namespace
      iio: imu: inv_mpu: Move exports to IIO_MPU6050 namespace
      iio: accel: adxl367: Use devm_regulator_bulk_get_enable()
      iio: accel: fxls8962af: Use devm_regulator_get_enable()
      iio: accel: kxcjk-1013: Use devm_regulator_bulk_get_enable()
      iio: accel: msa311: Use devm_regulator_get_enable()
      iio: cdc: ad7150: Use devm_regulator_get_enable()
      iio: st_sensors: core and lsm9ds0 switch to devm_regulator_bulk_get_e=
nable()
      iio: frequency: ad9523: Use devm_regulator_get_enable()
      iio: humidity: hts211: Use devm_regulator_get_enable()
      iio: light: ltr501: Use devm_regulator_bulk_get_enable()
      iio: light: noa1305: Use devm_regulator_get_enable()
      iio: proximity: sx_common: Use devm_regulator_bulk_get_enable()
      iio: adc: cc10001: Add local struct device *dev variable to avoid rep=
itition
      iio: adc: cc10001: Add devm_add_action_or_reset() to disable regulato=
r.
      iio: adc: cc10001: Use devm_clk_get_enabled() to avoid boilerplate.
      iio: adc: cc10001: Use devm_ to call device power down.
      iio: adc: cc10001: Switch remaining IIO calls in probe to devm_ forms.
      iio: temperature: mlx90632: Add error handling for devm_pm_runtime_en=
able()
      iio: temperature: mlx90632: Add missing static marking on devm_pm_ops
      Merge remote-tracking branch 'i2c/i2c/client_device_id_helper-immutab=
le' into togreg

Krzysztof Kozlowski (10):
      dt-bindings: iio: addac: adi,ad74413r: use spi-peripheral-props.yaml
      dt-bindings: iio: addac: adi,ad74413r: improve example
      dt-bindings: iio: frequency: use spi-peripheral-props.yaml
      dt-bindings: iio: gyroscope: use spi-peripheral-props.yaml
      dt-bindings: iio: imu: adi,adis16475: use spi-peripheral-props.yaml
      dt-bindings: iio: pressure: use spi-peripheral-props.yaml
      dt-bindings: iio: proximity: ams,as3935: use spi-peripheral-props.yaml
      dt-bindings: iio: resolver: adi,ad2s90: use spi-peripheral-props.yaml
      dt-bindings: iio: adc: qcom,spmi-vadc: simplify compatible enum
      dt-bindings: iio: adc: qcom,spmi-vadc: extend example

Lorenzo Bianconi (7):
      iio: imu: st_lsm6dsx: introduce st_lsm6dsx_device_set_enable routine
      iio: imu: st_lsm6dsx: introduce sw trigger support
      iio: imu: st_lsm6dsx: add support to LSM6DSV
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv device bindings
      iio: imu: st_lsm6dsx: add support to LSM6DSV16X
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsv16x
      iio: imu: st_lsm6dsx: fix LSM6DSV sensor description

Marcus Folkesson (1):
      iio: adc: mcp3911: add support to set PGA

Matti Vaittinen (18):
      iio: adc: ad7192: Simplify using devm_regulator_get_enable()
      iio: dac: ltc2688: Simplify using devm_regulator_*get_enable()
      iio: gyro: bmg160_core: Simplify using devm_regulator_*get_enable()
      iio: imu: st_lsm6dsx: Simplify using devm_regulator_*get_enable()
      iio: adc: ad7476: simplify using devm_regulator_get_enable()
      iio: adc: ad7606: simplify using devm_regulator_get_enable()
      iio: adc: max1241: simplify using devm_regulator_get_enable()
      iio: adc: max1363: simplify using devm_regulator_get_enable()
      iio: amplifier: hmc425a: simplify using devm_regulator_get_enable()
      dt-bindings: iio: Add KX022A accelerometer
      iio: accel: Support Kionix/ROHM KX022A accelerometer
      MAINTAINERS: Add KX022A maintainer entry
      iio: Add IIO_STATIC_CONST_DEVICE_ATTR
      iio: adxl367: Use IIO_STATIC_CONST_DEVICE_ATTR()
      iio: adxl372: Use IIO_STATIC_CONST_DEVICE_ATTR()
      iio: bmc150-accel-core: Use IIO_STATIC_CONST_DEVICE_ATTR()
      iio: at91-sama5d2_adc: Use IIO_STATIC_CONST_DEVICE_ATTR()
      iio: Don't silently expect attribute types

Mitja Spes (1):
      dt-bindings: iio: pressure: meas,ms5611: add max SPI frequency to the=
 example

M=C3=A5rten Lindahl (2):
      iio: light: vcnl4000: Preserve conf bits when toggle power
      iio: light: vcnl4000: Add ps_it attributes for vcnl4040

Nuno S=C3=A1 (19):
      iio: adc: ad_sigma_delta: do not use internal iio_dev lock
      iio: adc: ad799x: do not use internal iio_dev lock
      iio: adc: axp288_adc: do not use internal iio_dev lock
      iio: adc: imx7d_adc: do not use internal iio_dev lock
      iio: adc: lpc32xx_adc: do not use internal iio_dev lock
      iio: adc: ltc2947-core: do not use internal iio_dev lock
      iio: adc: meson_saradc: do not use internal iio_dev lock
      iio: adc: rockchip_saradc: do not use internal iio_dev lock
      iio: adc: sc27xx_adc: do not use internal iio_dev lock
      iio: adc: vf610_adc: add helper function to read samples
      iio: adc: vf610_adc: vf610_adc: do not use internal iio_dev lock
      iio: common: scmi_iio: do not use internal iio_dev lock
      iio: gyro: itg3200_core: do not use internal iio_dev lock
      dt-bindings: iio: dac: change ad5766 maintainer
      dt-bindings: iio: frequency: change admv4420 maintainer
      iio: core: introduce iio_device_{claim|release}_buffer_mode() APIs
      iio: health: max30100: do not use internal iio_dev lock
      iio: health: max30102: do not use internal iio_dev lock
      iio: core: move 'mlock' to 'struct iio_dev_opaque'

Olivier Moysan (3):
      dt-bindings: iio: adc: stm32-adc: add stm32mp13 compatibles
      iio: adc: stm32-adc: add stm32mp13 support
      iio: adc: stm32: manage min sampling time on all internal channels

Rajat Khandelwal (1):
      iio: pressure: mpl115: Implementing low power mode by shutdown gpio

Ramona Bolboaca (3):
      drivers: iio: accel: Use warning if invalid device id is detected
      dt-bindings: iio: accel: Add docs for ADXL359
      drivers: iio: accel: Add support for ADXL359 device

Rob Herring (1):
      dt-bindings: iio: dac: adi,ad5758: Drop 'contains' from 'adi,dc-dc-mo=
de'

Subhajit Ghosh (1):
      iio: light: apds9960: Fix iio_event_spec structures

Uwe Kleine-K=C3=B6nig (14):
      iio: accel: adxl367: Convert to i2c's .probe_new()
      iio: accel: da311: Convert to i2c's .probe_new()
      iio: accel: dmard06: Convert to i2c's .probe_new()
      iio: accel: dmard09: Convert to i2c's .probe_new()
      iio: accel: dmard10: Convert to i2c's .probe_new()
      iio: accel: kxsd9: Convert to i2c's .probe_new()
      iio: accel: mc3230: Convert to i2c's .probe_new()
      iio: accel: mma7660: Convert to i2c's .probe_new()
      iio: accel: mxc4005: Convert to i2c's .probe_new()
      iio: accel: mxc6255: Convert to i2c's .probe_new()
      iio: accel: stk8312: Convert to i2c's .probe_new()
      iio: accel: stk8ba50: Convert to i2c's .probe_new()
      iio: accel: st_magn: Convert to i2c's .probe_new()
      iio: accel: vl6180: Convert to i2c's .probe_new()

Wei Yongjun (6):
      iio: filter: admv8818: close potential out-of-bounds read in __admv88=
18_read_[h|l]pf_freq()
      iio: adc: ti-ads131e08: Silence no spi_device_id warnings
      iio: accel: sca3300: Silence no spi_device_id warning
      iio: adc: ad9467: Silence no spi_device_id warnings
      iio: adc: ad7192: Silence no spi_device_id warnings
      iio: adc: ad7124: Silence no spi_device_id warnings

Yang Yingliang (2):
      iio: multiplexer: Switch to use dev_err_probe() helper
      iio: trigger: sysfs: rename error label in iio_sysfs_trigger_probe()

Yuan Can (1):
      iio: accel: bma400: Switch to use dev_err_probe() helper

 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 |   46 +
 .../ABI/testing/sysfs-bus-iio-adc-max11410         |   13 +
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml |    8 +-
 .../bindings/iio/accel/kionix,kx022a.yaml          |   65 +
 .../devicetree/bindings/iio/adc/adi,ad4130.yaml    |  259 +++
 .../devicetree/bindings/iio/adc/adi,max11410.yaml  |  177 ++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           |  106 +-
 .../bindings/iio/adc/rockchip-saradc.yaml          |    1 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   68 +-
 .../bindings/iio/addac/adi,ad74413r.yaml           |   12 +-
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml    |    3 +-
 .../devicetree/bindings/iio/dac/adi,ad5766.yaml    |    2 +-
 .../bindings/iio/frequency/adi,adf4350.yaml        |    7 +-
 .../bindings/iio/frequency/adi,admv1013.yaml       |    5 +-
 .../bindings/iio/frequency/adi,admv1014.yaml       |    5 +-
 .../bindings/iio/frequency/adi,admv4420.yaml       |    8 +-
 .../bindings/iio/frequency/adi,adrf6780.yaml       |    5 +-
 .../bindings/iio/gyroscope/adi,adxrs290.yaml       |    5 +-
 .../bindings/iio/gyroscope/nxp,fxas21002c.yaml     |    5 +-
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |    3 +-
 .../bindings/iio/imu/invensense,icm42600.yaml      |    1 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    4 +
 .../bindings/iio/pressure/meas,ms5611.yaml         |    6 +-
 .../bindings/iio/pressure/murata,zpa2326.yaml      |    5 +-
 .../bindings/iio/proximity/ams,as3935.yaml         |    5 +-
 .../bindings/iio/resolver/adi,ad2s90.yaml          |    7 +-
 .../bindings/iio/temperature/adi,ltc2983.yaml      |  335 ++--
 MAINTAINERS                                        |   15 +
 drivers/i2c/i2c-core-base.c                        |   14 +
 drivers/iio/TODO                                   |    3 -
 drivers/iio/accel/Kconfig                          |   21 +
 drivers/iio/accel/Makefile                         |    3 +
 drivers/iio/accel/adxl355.h                        |   20 +-
 drivers/iio/accel/adxl355_core.c                   |   93 +-
 drivers/iio/accel/adxl355_i2c.c                    |   22 +-
 drivers/iio/accel/adxl355_spi.c                    |   19 +-
 drivers/iio/accel/adxl367.c                        |   57 +-
 drivers/iio/accel/adxl367_i2c.c                    |    5 +-
 drivers/iio/accel/adxl372.c                        |   29 +-
 drivers/iio/accel/bma400_core.c                    |   10 +-
 drivers/iio/accel/bmc150-accel-core.c              |   31 +-
 drivers/iio/accel/da311.c                          |    5 +-
 drivers/iio/accel/dmard06.c                        |    5 +-
 drivers/iio/accel/dmard09.c                        |    5 +-
 drivers/iio/accel/dmard10.c                        |    5 +-
 drivers/iio/accel/fxls8962af-core.c                |   40 +-
 drivers/iio/accel/fxls8962af-i2c.c                 |    2 +-
 drivers/iio/accel/fxls8962af-spi.c                 |    2 +-
 drivers/iio/accel/kionix-kx022a-i2c.c              |   51 +
 drivers/iio/accel/kionix-kx022a-spi.c              |   58 +
 drivers/iio/accel/kionix-kx022a.c                  | 1142 +++++++++++
 drivers/iio/accel/kionix-kx022a.h                  |   82 +
 drivers/iio/accel/kxcjk-1013.c                     |   25 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    5 +-
 drivers/iio/accel/mc3230.c                         |    5 +-
 drivers/iio/accel/mma7660.c                        |    5 +-
 drivers/iio/accel/msa311.c                         |   21 +-
 drivers/iio/accel/mxc4005.c                        |    5 +-
 drivers/iio/accel/mxc6255.c                        |    5 +-
 drivers/iio/accel/sca3300.c                        |   12 +-
 drivers/iio/accel/stk8312.c                        |    5 +-
 drivers/iio/accel/stk8ba50.c                       |    5 +-
 drivers/iio/adc/Kconfig                            |   40 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/ad4130.c                           | 2100 ++++++++++++++++=
++++
 drivers/iio/adc/ad7124.c                           |   10 +
 drivers/iio/adc/ad7192.c                           |   27 +-
 drivers/iio/adc/ad7476.c                           |   11 +-
 drivers/iio/adc/ad7606.c                           |   22 +-
 drivers/iio/adc/ad7606.h                           |    2 -
 drivers/iio/adc/ad799x.c                           |   20 +-
 drivers/iio/adc/ad9467.c                           |   11 +
 drivers/iio/adc/ad_sigma_delta.c                   |    8 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   33 +-
 drivers/iio/adc/axp288_adc.c                       |    9 +-
 drivers/iio/adc/cc10001_adc.c                      |   89 +-
 drivers/iio/adc/imx7d_adc.c                        |   14 +-
 drivers/iio/adc/lpc32xx_adc.c                      |   11 +-
 drivers/iio/adc/ltc2497-core.c                     |    7 +-
 drivers/iio/adc/ltc2497.h                          |    2 +
 drivers/iio/adc/max11410.c                         | 1050 ++++++++++
 drivers/iio/adc/max1241.c                          |   28 +-
 drivers/iio/adc/max1363.c                          |   12 +-
 drivers/iio/adc/mcp3911.c                          |  104 +-
 drivers/iio/adc/meson_saradc.c                     |   11 +-
 drivers/iio/adc/mt6370-adc.c                       |  305 +++
 drivers/iio/adc/rockchip_saradc.c                  |   15 +-
 drivers/iio/adc/sc27xx_adc.c                       |   14 +-
 drivers/iio/adc/stm32-adc-core.c                   |   30 +-
 drivers/iio/adc/stm32-adc-core.h                   |   30 +
 drivers/iio/adc/stm32-adc.c                        |  236 ++-
 drivers/iio/adc/ti-ads131e08.c                     |   11 +
 drivers/iio/adc/vf610_adc.c                        |  104 +-
 drivers/iio/amplifiers/hmc425a.c                   |   17 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    4 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |    4 +-
 drivers/iio/buffer/kfifo_buf.c                     |    2 +-
 drivers/iio/cdc/ad7150.c                           |   18 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |    6 +-
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |    8 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    9 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   39 +-
 drivers/iio/dac/ltc2688.c                          |   23 +-
 drivers/iio/filter/admv8818.c                      |    4 +-
 drivers/iio/frequency/ad9523.c                     |   22 +-
 drivers/iio/gyro/bmg160_core.c                     |   24 +-
 drivers/iio/gyro/fxas21002c_core.c                 |   21 +-
 drivers/iio/gyro/fxas21002c_i2c.c                  |    3 +-
 drivers/iio/gyro/fxas21002c_spi.c                  |    3 +-
 drivers/iio/gyro/itg3200_core.c                    |   10 +-
 drivers/iio/health/max30100.c                      |   15 +-
 drivers/iio/health/max30102.c                      |   19 +-
 drivers/iio/humidity/hts221.h                      |    2 -
 drivers/iio/humidity/hts221_core.c                 |   27 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |    2 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   26 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |    6 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |    6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   17 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    3 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   20 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   16 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  333 +++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   10 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   10 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |   65 +-
 drivers/iio/industrialio-buffer.c                  |   40 +-
 drivers/iio/industrialio-core.c                    |   58 +-
 drivers/iio/industrialio-event.c                   |    4 +-
 drivers/iio/industrialio-trigger.c                 |   12 +-
 drivers/iio/light/apds9960.c                       |   20 +-
 drivers/iio/light/ltr501.c                         |   27 +-
 drivers/iio/light/noa1305.c                        |   26 +-
 drivers/iio/light/vcnl4000.c                       |  185 +-
 drivers/iio/light/vl6180.c                         |    5 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |    5 +-
 drivers/iio/multiplexer/iio-mux.c                  |    8 +-
 drivers/iio/pressure/bmp280-i2c.c                  |    6 +-
 drivers/iio/pressure/mpl115.c                      |   62 +-
 drivers/iio/pressure/mpl115.h                      |    5 +
 drivers/iio/pressure/mpl115_i2c.c                  |    1 +
 drivers/iio/pressure/mpl115_spi.c                  |    1 +
 drivers/iio/proximity/sx9360.c                     |    1 +
 drivers/iio/proximity/sx_common.c                  |   23 +-
 drivers/iio/proximity/sx_common.h                  |    2 -
 drivers/iio/temperature/ltc2983.c                  |  193 +-
 drivers/iio/temperature/mlx90632.c                 |  474 ++++-
 drivers/iio/trigger/iio-trig-sysfs.c               |   14 +-
 drivers/staging/iio/frequency/ad9834.c             |    6 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |    5 +-
 include/linux/i2c.h                                |    1 +
 include/linux/iio/buffer_impl.h                    |    2 +-
 include/linux/iio/common/st_sensors.h              |    4 -
 include/linux/iio/gyro/itg3200.h                   |    2 +
 include/linux/iio/iio-opaque.h                     |    2 +
 include/linux/iio/iio.h                            |    5 +-
 include/linux/iio/kfifo_buf.h                      |    3 +-
 include/linux/iio/sysfs.h                          |   11 +
 include/linux/iio/triggered_buffer.h               |    6 +-
 162 files changed, 8083 insertions(+), 1307 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kx02=
2a.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.=
yaml
 create mode 100644 drivers/iio/accel/kionix-kx022a-i2c.c
 create mode 100644 drivers/iio/accel/kionix-kx022a-spi.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.c
 create mode 100644 drivers/iio/accel/kionix-kx022a.h
 create mode 100644 drivers/iio/adc/ad4130.c
 create mode 100644 drivers/iio/adc/max11410.c
 create mode 100644 drivers/iio/adc/mt6370-adc.c
