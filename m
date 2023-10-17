Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558837CCC2C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 21:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjJQTYW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjJQTYV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 15:24:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5611EE8
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 12:24:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54364C433C7;
        Tue, 17 Oct 2023 19:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697570658;
        bh=A8LXrnWpAoWWVlfzSgTNflVWMgy3Bs0rqJxYko0Qv3E=;
        h=Date:From:To:Cc:Subject:From;
        b=casdXRJxXdGVzuPZNzF0K5/0DFXuLFiXITUauC0Zf78gs1NpKQrkfSz7NxmW9Fn7T
         cpHvHJYeFvxTiHndCNK8P+RNZq0meQiD2N6Ouqe5Vn9fFPVu6MytOZO9ajhb6tFATp
         B9LbV6BynhMia2B+V7E9xipf88zdRiZF60Phg8osHihrYTRRpH3IAx9sFL1J60BF8b
         WVZKexcST3234voKwGQ/nepUdkuGDPiTh0nqUrYzC7VC99LTvGKXnvk7cO9uu49XcJ
         jKg9FFOKv1lbMmFE2NQhm+g32dUIDmsZv3YzTy9cwT1wBsZVUee3LEeh5v84AEU2xL
         YbwQNVVty9AFw==
Date:   Tue, 17 Oct 2023 20:24:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [PULL] IIO: 1st set of new device support, features and cleanup for
 6.7
Message-ID: <20231017202438.2ace1422@jic23-huawei>
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

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-6.7a

for you to fetch changes up to 89a1d2f064d2ae77a9cd6a8c7ac42b3c1647efa5:

  iio: Use device_get_match_data() (2023-10-14 17:18:36 +0100)

----------------------------------------------------------------
IIO: 1st set of new device support, features and cleanup for 6.7

Particularly great to see a resolver driver move out of staging via a
massive set of changes.  Only took 13 years :)

One small patch added then reverted due to a report of test breakage
(ashai-kasei,ak8975: Drop deprecated enums.)

An immutable branch was used for some hid-senors changes in case
there was a need to take them into the HID tree as well.

New device support
-----------------

adi,hmc425a
  - Add support for HMC540SLP3E broadband 4-bit digital attenuator.
kionix,kx022a
  - Add support for the kx132-1211 accelerometer. Require significant
    driver rework to enable this including add a chip type specific
    structure to deal with the chip differences.
  - Add support for the kx132acr-lbz accelerometer (subset of the kx022a
    feature set).
lltc,ltc2309
  - New driver for this 8 channel ADC.
microchip,mcp3911
  - Add support for rest of mcp391x family of ADCs (there are various
    differences beyond simple channel count variation.
    Series includes some general driver cleanup.
microchip,mcp3564
  - New driver for MCP3461, MCP3462, MCP3464, MCP3541, MCP3562, MCP3564
    and their R variants of 16/24bit ADCs. A few minor fixed followed.
rohm,bu1390
  - New driver for this pressure sensor.

Staging graduation
------------------

adi,ad1210 (after 13 or so years :)
  - More or less a complete (step-wise) rewrite of this resolver driver
    to bring it up to date with modern IIO standards.  The fault signal
    handling mapping to event channels was particularly complex and
    significant part of the changes.

Features
--------

iio-core
 - Add chromacity and color temperature channel types.
adi,ad7192
  - Oversampling ratio control (called fast settling in datasheet).
adi,adis16475
  - Add core support and then driver support for delta angle and delta
    velocity channels. These are intended for summation to establish
    angle and velocity changes over larger timescales.  Fix was
    needed for alignment after the temperature channel.  Further fix
    reduced set of devices for which the buffer support was applicable
    as seems burst reads don't cover these on all devices.
hid-sensors-als
  - Chromacity and color temperatures support including in amd sfh.
stx104
  - Add support for counter subsystem to this multipurpose device.
ti,twl6030
  - Add missing device tree binding description.

Clean up and minor fixes.
------------------------

treewide
  - Drop some unused declarations across IIO.
  - Make more use of device_get_match_data() instead of OF specific
    approaches.
Similar cleanup to sets of drivers.
  - Stop platform remove callbacks returning anything by using the
    temporary remove_new() callback.
  - Use i2c_get_match_data() to cope nicely with all types of ID table
    entry.
  - Use device_get_match_data() for various platform device to cope
    with more types of firmware.
  - Convert from enum to pointer in ID tables allowing use of
    i2c_get_match_data().
  - Fix sorting on some ID tables.
  - Include specific string helper headers rather than simply string_helper=
s.h
docs
  - Better description of the ordering requirements etc for
    available_scan_masks.
tools
  - Handle alignment of mixed sizes where the last element isn't the biggest
    correctly. Seems that doesn't happen often!
adi,ad2s1210
  - Lots of work from David Lechner on this driver including a few fixes
    that are going with the rework to avoid slowing that down.
adi,ad4310
  - Replace deprecated devm_clk_register()
adi,ad74413r
  - Bring the channel function setting inline with the datasheet.
adi,ad7192
  - Change to FIELD_PREP(), FIELD_GET().
  - Calculate f_order from the sinc filter and chop filter states.
  - Move more per chip config into data in struct ad7192_chip_info
  - Cleanup unused parameter in channel macros.
adi,adf4350
  - Make use of devm_* to simplify error handling for many of the setup
    calls in probe() / tear down in remove() and error paths.  Some more
    work to be done on this one.
  - Use dev_err_probe() for errors in probe() callback.
adi,adf4413
  - Typo in function name prefix.
adi,adxl345
  - Add channel scale to the chip type specific structure and drop
    using a type field previously used for indirection.
asahi,ak8985
  - Fix a mismatch introduced when switching from enum->pointers
    in the match tables.
amlogic,meson
  - Expand error logging during probe.
invensense,mpu6050
  - Support level-shifter control. Whilst no one is sure exactly what this
    is doing it is needed for some old boards.
  - Document mount-matrix dt-binding.
mediatek,mt6577
  - Use devm_clk_get_enabled() to replace open coded version and move
    everything over to being device managed. Drop now empty remove()
    callback. Fix follows to put the drvdata back.
  - Use dev_err_probe() for error reporting in probe() callback.
memsic,mxc4005
  - Add of_match_table.
microchip,mcp4725
  - Move various chip specific data from being looked up by chip ID to
    data in the chip type specific structure.
silicon-labs,si7005
  - Add of_match_table and entry in trivial-devices.yaml
st,lsm6dsx
  - Add missing mount-matrix dt binding documentation.
st,spear
  - Use devm_clk_get_enabled() and some other devm calls to move everything
    over to being device managed.  Drop now empty remove() callback.
  - Use dev_err_probe() to better handled deferred probing and tidy up
    error reporting in probe() callback.
st,stm32-adc
  - Add a bit of additional checking in probe() to protect against a NULL
    pointer (no known path to trigger it today).
  - Replace deprecated strncpy()
ti,ads1015
  - Allow for edge triggers.
  - Document interrupt in dt-bindings.

----------------------------------------------------------------
Alisa-Dariana Roman (5):
      iio: adc: ad7192: Use bitfield access macros
      iio: adc: ad7192: Improve f_order computation
      iio: adc: ad7192: Organize chip info
      iio: adc: ad7192: Remove unused member
      iio: adc: ad7192: Add fast settling support

Ana-Maria Cusco (1):
      dt-bindings: iio: hmc425a: add entry for HMC540S

Andreas Kemnade (3):
      dt-bindings: iio: adc: Add TI TWL603X GPADC
      dt-bindings: iio: imu: mpu6050: Add level shifter
      iio: imu: mpu6050: add level shifter flag

Andr=C3=A9 Apitzsch (1):
      iio: magnetometer: ak8975: Fix 'Unexpected device' error

Andy Shen Shen (1):
      iio: adc: palmas_gpadc: Drop duplicated the in comment.

Andy Shevchenko (3):
      iio: accel: kionix-kx022a: Use correct header(s) instead of string_he=
lpers.h
      iio: accel: msa311: Use correct header(s) instead of string_helpers.h
      iio: dac: stm32-dac: Use correct header(s) instead of string_helpers.h

AngeloGioacchino Del Regno (1):
      iio: adc: mt6577_auxadc: Fix kernel panic on suspend

Antoniu Miclaus (3):
      iio: addac: ad74413r: fix function prefix typo
      iio: addac: ad74413r: update channel function set
      MAINTAINERS: fix Analog Devices website link

Basavaraj Natikar (9):
      iio: hid-sensor-als: Use channel index to support more hub attributes
      iio: Add channel type light color temperature
      iio: hid-sensor-als: Add light color temperature support
      HID: amd_sfh: Add support for light color temperature
      HID: amd_sfh: Add support for SFH1.1 light color temperature
      iio: Add channel type for chromaticity
      iio: hid-sensor-als: Add light chromaticity support
      HID: amd_sfh: Add light chromaticity support
      HID: amd_sfh: Add light chromaticity for SFH1.1

Biju Das (30):
      iio: accel: mma8452: Convert enum->pointer for data in the ID table
      iio: accel: mma8452: Sort match tables
      iio: chemical: vz89x: Convert enum->pointer for data in the match tab=
les
      iio: chemical: atlas-sensor: Convert enum->pointer for data in the ma=
tch tables
      iio: chemical: atlas-ezo-sensor: Simplify probe()
      iio: proximity: sx9310: Convert enum->pointer for match data table
      iio: dac: ti-dac5571: Use i2c_get_match_data()
      iio: dac: ti-dac5571: Sort match tables
      iio: magnetometer: yamaha-yas530: Use i2c_get_match_data()
      iio: adc: max1363: Use i2c_get_match_data()
      iio: accel: bma180: Convert enum->pointer for data in the match table
      iio: mlx90614: Use i2c_get_match_data()
      iio: magnetometer: ak8975: Convert enum->pointer for data in the matc=
h tables
      iio: magnetometer: ak8975: Sort ID and ACPI tables
      dt-bindings: iio: magnetometer: asahi-kasei,ak8975: Drop deprecated e=
nums
      iio: chemical: sgp30: Convert enum->pointer for data in the match tab=
les
      iio: potentiometer: ds1803: Convert enum->pointer for data in the ID =
table
      iio: potentiometer: ad5110: Use i2c_get_match_data()
      iio: light: opt4001: Use i2c_get_match_data()
      iio: temperature: tmp117: Convert enum->pointer for data in the match=
 tables
      iio: adc: ti-adc081c: Simplify probe()
      iio: adc: ti-ads1015: Simplify probe()
      iio: adc: ltc2497: Simplify probe()
      iio: accel: adxl345: Convert enum->pointer for data in match data tab=
le
      iio: accel: adxl345: Simplify adxl345_read_raw()
      iio: dac: mcp4725: Replace variable 'id' from struct mcp4725_data
      iio: dac: mcp4725: Use i2c_get_match_data()
      iio: dac: mcp4725: Add use_ext_ref_voltage to struct mcp4725_chip_info
      iio: dac: mcp4725: Add dac_reg_offset to struct mcp4725_chip_info
      iio: pressure: ms5637: Use i2c_get_match_data()

David Lechner (39):
      staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault
      staging: iio: resolver: ad2s1210: fix not restoring sample gpio in ch=
annel read
      staging: iio: resolver: ad2s1210: fix use before initialization
      staging: iio: resolver: ad2s1210: remove call to spi_setup()
      staging: iio: resolver: ad2s1210: check return of ad2s1210_initial()
      staging: iio: resolver: ad2s1210: remove spi_set_drvdata()
      staging: iio: resolver: ad2s1210: sort imports
      staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
      staging: iio: resolver: ad2s1210: implement IIO_CHAN_INFO_SCALE
      staging: iio: resolver: ad2s1210: use devicetree to get CLKIN rate
      staging: iio: resolver: ad2s1210: use regmap for config registers
      staging: iio: resolver: ad2s1210: add debugfs reg access
      staging: iio: resolver: ad2s1210: remove config attribute
      staging: iio: resolver: ad2s1210: rework gpios
      staging: iio: resolver: ad2s1210: refactor setting excitation frequen=
cy
      staging: iio: resolver: ad2s1210: read excitation frequency from cont=
rol register
      dt-bindings: iio: resolver: add devicetree bindings for ad2s1210
      staging: iio: resolver: ad2s1210: do not use fault register for dummy=
 read
      staging: iio: resolver: ad2s1210: implement hysteresis as channel attr
      staging: iio: resolver: ad2s1210: convert fexcit to channel attribute
      staging: iio: resolver: ad2s1210: convert resolution to devicetree pr=
operty
      staging: iio: resolver: ad2s1210: add phase lock range support
      staging: iio: resolver: ad2s1210: add triggered buffer support
      staging: iio: resolver: ad2s1210: convert LOT threshold attrs to even=
t attrs
      staging: iio: resolver: ad2s1210: convert LOS threshold to event attr
      staging: iio: resolver: ad2s1210: convert DOS overrange threshold to =
event attr
      staging: iio: resolver: ad2s1210: convert DOS mismatch threshold to e=
vent attr
      staging: iio: resolver: ad2s1210: rename DOS reset min/max attrs
      iio: event: add optional event label support
      staging: iio: resolver: ad2s1210: implement fault events
      staging: iio: resolver: ad2s1210: add register/fault support summary
      staging: iio: resolver: ad2s1210: add label attribute support
      staging: iio: resolver: ad2s1210: remove fault attribute
      staging: iio: resolver: ad2s1210: refactor sample toggle
      staging: iio: resolver: ad2s1210: clear faults after soft reset
      staging: iio: resolver: ad2s1210: simplify code with guard(mutex)
      iio: resolver: ad2s1210: move out of staging
      iio: resolver: ad2s1210: remove DRV_NAME macro
      iio: resolver: ad2s1210: remove of_match_ptr()

George Stark (1):
      iio: adc: meson: improve error logging at probe stage

Javier Carrasco (2):
      iio: si7005: Add device tree support
      dt-bindings: trivial-devices: add silabs,si7005

Jinjie Ruan (10):
      iio: adc: mt6577_auxadc: Use devm_clk_get_enabled() helper function
      iio: adc: spear_adc: Use device managed function
      iio: adc: spear_adc: Use dev_err_probe()
      iio: adc: mt6577_auxadc: Simplify with dev_err_probe()
      iio: adc: mt6577_auxadc: Simplify with device managed function
      staging: iio: Use devm_clk_get_enabled() helper function
      iio: frequency: adf4350: Use device managed functions and fix power d=
own issue.
      iio: adc: at91_adc: Use devm_request_irq() helper function
      iio: adc: at91_adc: Use devm_clk_get_enabled() helper function
      iio: adc: at91_adc: Simplify with dev_err_probe()

Jonathan Cameron (2):
      Merge branch 'ib-iio-hid-sensors-v6.6-rc1' into togreg
      Revert "dt-bindings: iio: magnetometer: asahi-kasei,ak8975: Drop depr=
ecated enums"

Justin Stitt (1):
      iio: adc: stm32-adc: Replace deprecated strncpy() with strscpy()

Lars-Peter Clausen (1):
      iio: ad4310: Replace devm_clk_register() with devm_clk_hw_register()

Liam Beguin (2):
      dt-bindings: iio: adc: add lltc,ltc2309 bindings
      iio: adc: add ltc2309 support

Luca Ceresoli (1):
      iio: accel: mxc4005: allow module autoloading via OF compatible

Marcus Folkesson (6):
      dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx fam=
ily
      iio: adc: mcp3911: make use of dev_err_probe()
      iio: adc: mcp3911: simplify usage of spi->dev
      iio: adc: mcp3911: fix indentation
      iio: adc: mcp3911: avoid ambiguity parameters in macros
      iio: adc: mcp3911: add support for the whole MCP39xx family

Marek Vasut (2):
      iio: adc: ti-ads1015: Add edge trigger support
      dt-bindings: iio: adc: ti,ads1015: Document optional interrupt line

Marius Cristea (4):
      dt-bindings: iio: adc: adding MCP3564 ADC
      iio: adc: adding support for MCP3564 ADC
      iio: adc: MCP3564: fix the static checker warning
      iio: adc: MCP3564: fix warn: unsigned '__x' is never less than zero.

Martin Kepplinger (1):
      dt-bindings: iio: imu: st,lsm6dsx: add mount-matrix property

Matti Vaittinen (7):
      iio: improve doc for available_scan_mask
      dt-bindings: Add ROHM BM1390 pressure sensor
      iio: pressure: Support ROHM BU1390
      MAINTAINERS: Add ROHM BM1390
      dt-bindings: iio: Add KX132ACR-LBZ accelerometer
      iio: kx022a: Support ROHM KX132ACR-LBZ
      tools: iio: iio_generic_buffer ensure alignment

Mehdi Djait (7):
      dt-bindings: iio: Add KX132-1211 accelerometer
      iio: accel: kionix-kx022a: Remove blank lines
      iio: accel: kionix-kx022a: Warn on failed matches and assume compatib=
ility
      iio: accel: kionix-kx022a: Add an i2c_device_id table
      iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
      iio: accel: kionix-kx022a: Add a function to retrieve number of bytes=
 in buffer
      iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer

Michael Hennerich (1):
      iio: amplifiers: hmc425a: Add Support HMC540S 4-bit Attenuator

Ramona Bolboaca (3):
      iio: Add IIO_DELTA_ANGL channel type
      iio: Add IIO_DELTA_VELOCITY channel type
      iio: imu: adis16475.c: Add delta angle and delta velocity channels

Ramona Gradinariu (2):
      iio: imu: adis16475: Add buffer padding after temp channel
      drivers: imu: adis16475.c: Remove scan index from delta channels

Rob Herring (1):
      iio: Use device_get_match_data()

Uwe Kleine-K=C3=B6nig (49):
      iio: accel: hid-sensor-accel-3d: Convert to platform remove callback =
returning void
      iio: adc: ab8500-gpadc: Convert to platform remove callback returning=
 void
      iio: adc: at91-sama5d2: Convert to platform remove callback returning=
 void
      iio: adc: at91: Convert to platform remove callback returning void
      iio: adc: axp20x: Convert to platform remove callback returning void
      iio: adc: bcm_iproc: Convert to platform remove callback returning vo=
id
      iio: adc: dln2: Convert to platform remove callback returning void
      iio: adc: ep93xx: Convert to platform remove callback returning void
      iio: adc: exynos: Convert to platform remove callback returning void
      iio: adc: fsl-imx25-gcq: Convert to platform remove callback returnin=
g void
      iio: adc: hx711: Convert to platform remove callback returning void
      iio: adc: imx8qxp: Convert to platform remove callback returning void
      iio: adc: imx93: Convert to platform remove callback returning void
      iio: adc: meson_saradc: Convert to platform remove callback returning=
 void
      iio: adc: mp2629: Convert to platform remove callback returning void
      iio: adc: mxs-lradc: Convert to platform remove callback returning vo=
id
      iio: adc: npcm: Convert to platform remove callback returning void
      iio: adc: qcom-pm8xxx-xoadc: Convert to platform remove callback retu=
rning void
      iio: adc: rcar-gyroadc: Convert to platform remove callback returning=
 void
      iio: adc: stm32-adc-core: Convert to platform remove callback returni=
ng void
      iio: adc: stm32-adc: Convert to platform remove callback returning vo=
id
      iio: adc: stm32-dfsdm-adc: Convert to platform remove callback return=
ing void
      iio: adc: stm32-dfsdm-core: Convert to platform remove callback retur=
ning void
      iio: adc: sun4i-gpadc-iio: Convert to platform remove callback return=
ing void
      iio: adc: ti_am335x_adc: Convert to platform remove callback returnin=
g void
      iio: adc: twl4030-madc: Convert to platform remove callback returning=
 void
      iio: adc: twl6030-gpadc: Convert to platform remove callback returnin=
g void
      iio: adc: vf610_adc: Convert to platform remove callback returning vo=
id
      iio: dac: dpot-dac: Convert to platform remove callback returning void
      iio: dac: lpc18xx_dac: Convert to platform remove callback returning =
void
      iio: dac: stm32-dac-core: Convert to platform remove callback returni=
ng void
      iio: dac: stm32-dac: Convert to platform remove callback returning vo=
id
      iio: dac: vf610: Convert to platform remove callback returning void
      iio: gyro: hid-sensor-gyro-3d: Convert to platform remove callback re=
turning void
      iio: humidity: hid-sensor-humidity: Convert to platform remove callba=
ck returning void
      iio: light: cm3605: Convert to platform remove callback returning void
      iio: light: hid-sensor-als: Convert to platform remove callback retur=
ning void
      iio: light: hid-sensor-prox: Convert to platform remove callback retu=
rning void
      iio: light: lm3533-als: Convert to platform remove callback returning=
 void
      iio: magnetometer: hid-sensor-magn-3d: Convert to platform remove cal=
lback returning void
      iio: orientation: hid-sensor-incl-3d: Convert to platform remove call=
back returning void
      iio: orientation: hid-sensor-rotation: Convert to platform remove cal=
lback returning void
      iio: position: hid-sensor-custom-intel-hinge: Convert to platform rem=
ove callback returning void
      iio: pressure: hid-sensor: Convert to platform remove callback return=
ing void
      iio: proximity: cros_ec_mkbp: Convert to platform remove callback ret=
urning void
      iio: proximity: srf04: Convert to platform remove callback returning =
void
      iio: temperature: hid-sensor: Convert to platform remove callback ret=
urning void
      iio: trigger: iio-trig-interrupt: Convert to platform remove callback=
 returning void
      iio: trigger: stm32-timer: Convert to platform remove callback return=
ing void

William Breathitt Gray (1):
      iio: addac: stx104: Add 8254 Counter/Timer support

Yue Haibing (1):
      iio: Remove unused declarations

Zhang Shurong (1):
      iio: adc: stm32-adc: harden against NULL pointer deref in stm32_adc_p=
robe()

 Documentation/ABI/testing/sysfs-bus-iio            |   75 +
 .../ABI/testing/sysfs-bus-iio-adc-mcp3564          |   53 +
 .../ABI/testing/sysfs-bus-iio-resolver-ad2s1210    |   27 +
 .../bindings/iio/accel/kionix,kx022a.yaml          |   14 +-
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |   20 +-
 .../bindings/iio/adc/microchip,mcp3564.yaml        |  205 +++
 .../bindings/iio/adc/microchip,mcp3911.yaml        |    6 +
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |    3 +
 .../bindings/iio/adc/ti,twl6030-gpadc.yaml         |   43 +
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |   12 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |    5 +
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |    3 +
 .../bindings/iio/pressure/rohm,bm1390.yaml         |   52 +
 .../bindings/iio/resolver/adi,ad2s1210.yaml        |  177 +++
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 MAINTAINERS                                        |   19 +-
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  |    7 +
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  |    3 +
 .../hid_descriptor/amd_sfh_hid_report_desc.h       |   21 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |    9 +
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h |   15 +
 drivers/iio/accel/Kconfig                          |   10 +-
 drivers/iio/accel/adxl345.h                        |   21 +-
 drivers/iio/accel/adxl345_core.c                   |   47 +-
 drivers/iio/accel/adxl345_i2c.c                    |   20 +-
 drivers/iio/accel/adxl345_spi.c                    |   20 +-
 drivers/iio/accel/bma180.c                         |   27 +-
 drivers/iio/accel/fxls8962af.h                     |    1 -
 drivers/iio/accel/hid-sensor-accel-3d.c            |    6 +-
 drivers/iio/accel/kionix-kx022a-i2c.c              |   24 +-
 drivers/iio/accel/kionix-kx022a-spi.c              |   19 +-
 drivers/iio/accel/kionix-kx022a.c                  |  351 ++++-
 drivers/iio/accel/kionix-kx022a.h                  |  114 +-
 drivers/iio/accel/mma8452.c                        |   28 +-
 drivers/iio/accel/msa311.c                         |    2 +-
 drivers/iio/accel/mxc4005.c                        |    8 +
 drivers/iio/adc/Kconfig                            |   29 +-
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ab8500-gpadc.c                     |    6 +-
 drivers/iio/adc/ad4130.c                           |   15 +-
 drivers/iio/adc/ad7192.c                           |  269 ++--
 drivers/iio/adc/at91-sama5d2_adc.c                 |    6 +-
 drivers/iio/adc/at91_adc.c                         |  114 +-
 drivers/iio/adc/axp20x_adc.c                       |    6 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |    6 +-
 drivers/iio/adc/dln2-adc.c                         |    5 +-
 drivers/iio/adc/ep93xx_adc.c                       |    6 +-
 drivers/iio/adc/exynos_adc.c                       |    6 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |    6 +-
 drivers/iio/adc/hx711.c                            |    6 +-
 drivers/iio/adc/imx8qxp-adc.c                      |    6 +-
 drivers/iio/adc/imx93_adc.c                        |    6 +-
 drivers/iio/adc/ltc2309.c                          |  246 ++++
 drivers/iio/adc/ltc2497.c                          |    5 +-
 drivers/iio/adc/max1363.c                          |   87 +-
 drivers/iio/adc/mcp3564.c                          | 1513 ++++++++++++++++=
+++
 drivers/iio/adc/mcp3911.c                          |  562 ++++++--
 drivers/iio/adc/meson_saradc.c                     |   22 +-
 drivers/iio/adc/mp2629_adc.c                       |    6 +-
 drivers/iio/adc/mt6577_auxadc.c                    |   72 +-
 drivers/iio/adc/mxs-lradc-adc.c                    |    6 +-
 drivers/iio/adc/npcm_adc.c                         |    6 +-
 drivers/iio/adc/palmas_gpadc.c                     |    2 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c                |    6 +-
 drivers/iio/adc/rcar-gyroadc.c                     |    6 +-
 drivers/iio/adc/spear_adc.c                        |   64 +-
 drivers/iio/adc/stm32-adc-core.c                   |   12 +-
 drivers/iio/adc/stm32-adc.c                        |    8 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    6 +-
 drivers/iio/adc/stm32-dfsdm-core.c                 |    6 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                  |    8 +-
 drivers/iio/adc/ti-adc081c.c                       |   12 +-
 drivers/iio/adc/ti-ads1015.c                       |    7 +-
 drivers/iio/adc/ti_am335x_adc.c                    |    6 +-
 drivers/iio/adc/twl4030-madc.c                     |    6 +-
 drivers/iio/adc/twl6030-gpadc.c                    |   16 +-
 drivers/iio/adc/vf610_adc.c                        |    6 +-
 drivers/iio/addac/Kconfig                          |    1 +
 drivers/iio/addac/ad74413r.c                       |   24 +-
 drivers/iio/addac/stx104.c                         |   61 +-
 drivers/iio/amplifiers/hmc425a.c                   |   17 +
 drivers/iio/chemical/atlas-ezo-sensor.c            |    6 +-
 drivers/iio/chemical/atlas-sensor.c                |   32 +-
 drivers/iio/chemical/sgp30.c                       |   24 +-
 drivers/iio/chemical/vz89x.c                       |   16 +-
 drivers/iio/dac/dpot-dac.c                         |    6 +-
 drivers/iio/dac/lpc18xx_dac.c                      |    6 +-
 drivers/iio/dac/mcp4725.c                          |   42 +-
 drivers/iio/dac/stm32-dac-core.c                   |   15 +-
 drivers/iio/dac/stm32-dac.c                        |    9 +-
 drivers/iio/dac/ti-dac5571.c                       |   48 +-
 drivers/iio/dac/vf610_dac.c                        |    6 +-
 drivers/iio/frequency/adf4350.c                    |   75 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |    6 +-
 drivers/iio/humidity/hid-sensor-humidity.c         |    6 +-
 drivers/iio/humidity/si7005.c                      |    7 +
 drivers/iio/iio_core.h                             |    3 -
 drivers/iio/imu/adis16475.c                        |  238 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c          |   13 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    3 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +-
 drivers/iio/industrialio-core.c                    |    4 +
 drivers/iio/industrialio-event.c                   |   55 +
 drivers/iio/light/cm3605.c                         |    6 +-
 drivers/iio/light/hid-sensor-als.c                 |  136 +-
 drivers/iio/light/hid-sensor-prox.c                |    6 +-
 drivers/iio/light/lm3533-als.c                     |    6 +-
 drivers/iio/light/opt4001.c                        |    2 +-
 drivers/iio/magnetometer/ak8975.c                  |   97 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    6 +-
 drivers/iio/magnetometer/yamaha-yas530.c           |    4 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c       |    6 +-
 drivers/iio/orientation/hid-sensor-rotation.c      |    6 +-
 .../iio/position/hid-sensor-custom-intel-hinge.c   |    6 +-
 drivers/iio/potentiometer/ad5110.c                 |   21 +-
 drivers/iio/potentiometer/ds1803.c                 |   13 +-
 drivers/iio/pressure/Kconfig                       |    9 +
 drivers/iio/pressure/Makefile                      |    1 +
 drivers/iio/pressure/hid-sensor-press.c            |    6 +-
 drivers/iio/pressure/ms5637.c                      |    6 +-
 drivers/iio/pressure/rohm-bm1390.c                 |  934 ++++++++++++
 drivers/iio/proximity/cros_ec_mkbp_proximity.c     |    6 +-
 drivers/iio/proximity/srf04.c                      |    6 +-
 drivers/iio/proximity/sx9310.c                     |   46 +-
 drivers/iio/resolver/Kconfig                       |   13 +
 drivers/iio/resolver/Makefile                      |    1 +
 drivers/iio/resolver/ad2s1210.c                    | 1519 ++++++++++++++++=
++++
 drivers/iio/temperature/hid-sensor-temperature.c   |    6 +-
 drivers/iio/temperature/mlx90614.c                 |    2 +-
 drivers/iio/temperature/tmp117.c                   |   94 +-
 drivers/iio/trigger/iio-trig-interrupt.c           |    6 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |    6 +-
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/frequency/ad9832.c             |   15 +-
 drivers/staging/iio/frequency/ad9834.c             |   21 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   22 +-
 drivers/staging/iio/resolver/Kconfig               |   18 -
 drivers/staging/iio/resolver/Makefile              |    6 -
 drivers/staging/iio/resolver/ad2s1210.c            |  716 ---------
 include/linux/hid-sensor-ids.h                     |    4 +
 include/linux/iio/iio.h                            |   12 +-
 include/linux/iio/sw_device.h                      |    3 -
 include/linux/iio/sw_trigger.h                     |    3 -
 include/uapi/linux/iio/types.h                     |    4 +
 tools/iio/iio_event_monitor.c                      |    8 +
 tools/iio/iio_generic_buffer.c                     |   13 +-
 147 files changed, 7205 insertions(+), 2002 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-resolver-ad2s12=
10
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp=
3564.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6030-gp=
adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/rohm,bm1=
390.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/adi,ad2s=
1210.yaml
 create mode 100644 drivers/iio/adc/ltc2309.c
 create mode 100644 drivers/iio/adc/mcp3564.c
 create mode 100644 drivers/iio/pressure/rohm-bm1390.c
 create mode 100644 drivers/iio/resolver/ad2s1210.c
 delete mode 100644 drivers/staging/iio/resolver/Kconfig
 delete mode 100644 drivers/staging/iio/resolver/Makefile
 delete mode 100644 drivers/staging/iio/resolver/ad2s1210.c
