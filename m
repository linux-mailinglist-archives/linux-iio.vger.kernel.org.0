Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE56A51AF0F
	for <lists+linux-iio@lfdr.de>; Wed,  4 May 2022 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiEDUcU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 May 2022 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiEDUcT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2022 16:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05D4F9CE
        for <linux-iio@vger.kernel.org>; Wed,  4 May 2022 13:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D759F616A3
        for <linux-iio@vger.kernel.org>; Wed,  4 May 2022 20:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1418EC385AE;
        Wed,  4 May 2022 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651696120;
        bh=yhx79Xfl+cpboIDqnDNMSNy/fw1PY86VdlL8rNx9eZY=;
        h=Date:From:To:Subject:From;
        b=ImXjMtJ1DMZFUh/mSN0aqgt1Gm42grIxmmDoGEMucVV/bKWnphJjs6r8MbDn6S7gA
         Ico+Nkb3r4lq0jxi13v2HzhMOZj7/NsjlUP0Tx/axrgsdqvG38MgP2oY287wgxEoGq
         2Ds4NnK9d1pY5QIaHrOtiOcQmki9dukzSDceWRN7mY6+a2uOUbGxAgw9aDTYXhO/KD
         yFaLK6g6EJvTzWwXxS6roEvcuf52HFqI6ArPOiFZY4wOx5VducNfHog8522Y7RoOJq
         5q6o3dwQH/WysVLIkzZSoN9AKbGCFvmsRSTNmsu0bNlIrFZtkVGku6KdGLZXFIo/xS
         vcQIV33vUTzbg==
Date:   Wed, 4 May 2022 21:37:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO new device support, features and cleanup for
 5.19
Message-ID: <20220504213700.7e2b8ba5@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fo=
r-5.19a

for you to fetch changes up to eda75f8238b079a41aa11383bd47dc3297e74cb1:

  iio: ti-ads8688: use of_device_id for OF matching (2022-05-01 19:01:13 +0=
100)

----------------------------------------------------------------
First set of IIO new device support, features and cleanup for 5.19

Usual mixed bag. Stand out this time is Andy Shevchenko's continuing
effort to move drivers over the generic firmware interfaces.

Device support
* sprd,sc2720
  - upm9620 binding addition.
  - Refactor and support for sc2720, sc2721 and sc2730.
* ti,ads1015
  - Refactor driver and add support for TLA2024.

Device support (IDs only)
* invensense,mpu6050
  - Add ID for ICM-20608-D.
* st,accel:
  -  Add ID for lis302dl.
* st,lsm6dsx
  - Add support for ASM330LHHX (can fallback to LSM6DSR.)

Features
* convert drivers to device properties
  - IIO core
  - adi,ad7266
  - adi,adis16480
  - adi,adxl355
  - bosch,bmi160
  - domintech,dmard06
  - fsl,fxas21002c
  - invensense,mpu3050
  - linear,ltc2983
  - linear,ltc2632
  - maxbotix,mb1232
  - maxim,max31856
  - maxim,max31865
  - multiplexer
  - ping
  - rescale
  - taos,tsl2772
* core
  - Add runtime check on whether realbits fit in storagebits for each
    channel.
* adi,ad_sigma_delta
  - Add sequencer support and relevant update_scan_mode callbacks for
    adi,ad7192 and adi,ad7124.

Cleanup and minor fixes
* MAINTAINERS
  - Update Lorenzo Bianconi's email address for IIO drivers.
  - Add entry for ad3552r and update maintainer in dt-binding doc.
* tree-wide
  - Replace strtobool() with kstrtobool().
  - Drop false OF dependencies.
* core
  - Tidy up and document IIO modes.
  - Take iio_buffer_enabled() out of header allowing current_mode to be
    moved to the opaque structure.
  - As all kfifo buffers use the same mode value, drop that parameter
    and set it unconditionally.
  - White space fixes and similar.
  - Drop use of list iterator variable for
    list_for_each_entry_continue_reverse and use list_prepare_entry to
    restart.
* sysfs-trigger
  - Replace use of 'found' variable with dedicate list iterator variable.
* adi,ad7124
  - Drop misleading shift.
* adi,ad2s1210
  - Remove redundant local variable assignment.
* adi,adis16480
  - Use local device pointer to reduce repetition.
  - Improve handling of clocks.
* domintech,dmard09
  - White space.
* dummy driver
  - Improve error handling.
* fsl,mma8452
  - Add missing documentation of name element.
* invensense,mpu3050
  - Stop remove() returning non 0.
* kionix,kxsd9
  - White space.
* linear,ltc2688
  - Use local variable for struct device.
  - Combine of_node_put() error handling paths.
* linear,ltc2983
  - Avoid use of constants in messages where a define is available.
* microchip,mcp4131
  - Fix compatible in dt example.
* pni,rm3100
  - Stop directly accessing iio_dev->current_mode just to find out
    if the buffer is enabled.
* renesas,rzg2l
  - Relax kconfig constraint to include newer devices.
* sprd,sc27xx
  - Fix wrong scaling mask.
  - Improve the calibration values.
* samsung,ssp
  - Replace a 'found' variable in favor of an explicit value that was
    found.
* sensortek,stk3xx
  - Add proximity-near-level binding and driver support.
* st,st_sensors:
  - Drop unused accel_type enum.
  - Return early in *_write_raw()
  - Drop unnecessary locking in _avail functions.
  - Add local lock to protect odr against concurrent updates allowing
    mlock to no longer be used outside of the core.
  - Use iio_device_claim_direct_mode() rather than racy checking of
    the current mode.
* st,stmpe-adc
  - Fix checks on wait_for_completion_timeout().
  - Allow use of of_device_id for matching.
* st,stm32-dfsdm
  - Stop accessing iio_dev->current_mode to find out if the buffer
    is enabled (so we can hide that variable in the opaque structure)
* st,vl53l0x
  - Fix checks on wait_for_completion_timeout.
* ti,ads1015
  - Add missing ID for ti,ads1115 in binding doc.
  - Convert from repeated chip ID look up to selecting static const
    data.
  - Switch to read_avail() callback.
* ti,ads8688
  - Use of_device_id for driver matching.
* ti,palmas-adc
  - Drop a warning on minor calibration mismatch leading to slightly
    negative values after applying the calibration.

----------------------------------------------------------------
Alexander Vorwerk (1):
      iio: core: fix a few code style issues

Alexandru Tachici (5):
      iio: adc: ad7124: Remove shift from scan_type
      iio: adc: ad7124: Add update_scan_mode
      iio: adc: ad7192: Add update_scan_mode
      iio: adc: ad7124: add sequencer support
      iio: adc: ad7192: add sequencer support

Andy Shevchenko (25):
      iio: dac: ltc2688: Use temporary variable for struct device
      iio: multiplexer: Make use of device properties
      iio: temperature: ltc2983: Don't hard code defined constants in messa=
ges
      iio: temperature: ltc2983: Use single error path to put OF node
      iio: temperature: ltc2983: Make use of device properties
      iio: imu: bmi160: Make use of device properties
      iio: dac: vf610: Drop dependency on OF
      iio: dac: lpc18xx: Drop dependency on OF
      iio: dac: dpot: Drop dependency on OF
      iio: afe: rescale: Make use of device properties
      iio: accel: dmard06: Drop dependency on OF
      iio: temperature: max31856: Make use of device properties
      iio: light: cm3605: Drop dependency on OF
      iio: magnetometer: ak8974: Drop dependency on OF
      iio: proximity: ping: Replace OF specific code by device_get_match_da=
ta()
      iio: light: tsl2772: Make use of device properties
      iio: core: Convert to use firmware node handle instead of OF node
      iio: gyro: mpu3050: Make use of device properties
      iio: gyro: fxas21002c: Make use of device properties
      iio: imu: adis16480: Make use of device properties
      iio: imu: adis16480: Use temporary variable for struct device
      iio: imu: adis16480: Improve getting the optional clocks
      iio: proximity: mb1232: Switch to use fwnode_irq_get()
      iio: temperature: max31865: Make use of device properties
      iio: dac: ltc2632: Make use of device properties

Arnaud Ferraris (2):
      dt-bindings: iio: light: stk33xx: Add proximity-near-level
      iio: proximity: stk3310: Export near level property for proximity sen=
sor

Biju Das (1):
      dt-bindings: iio: adc: Document Renesas RZ/V2L ADC

Cixi Geng (7):
      dt-bindings:iio:adc: add sprd,ump9620-adc dt-binding
      iio: adc: sc27xx: fix read big scale voltage not right
      iio: adc: sc27xx: Fine tune the scale calibration values
      iio: adc: sc27xx: structure adjustment and optimization
      iio: adc: sc27xx: refactor some functions for support more PMiCs
      iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
      iio: adc: sc27xx: add support for PMIC sc2730

Colin Ian King (1):
      staging: iio: ad2s1210: remove redundant assignment to variable negat=
ive

H. Nikolaus Schaller (1):
      iio: palmas: shut up warning about calibration mismatch (due to noise)

Jakob Koschel (3):
      iio: buffer: remove usage of list iterator variable for list_for_each=
_entry_continue_reverse()
      iio: ssp_sensors: replace usage of found with dedicated list iterator=
 variable
      iio: sysfs-trigger: replace usage of found with dedicated list iterat=
or variable

Jonathan Cameron (1):
      iio: accel: mma8452: Add missing documentation for name element of ch=
ip_info

Krzysztof Kozlowski (2):
      iio: stmpe-adc: use of_device_id for OF matching
      iio: ti-ads8688: use of_device_id for OF matching

Lad Prabhakar (1):
      iio: adc: Kconfig: Make RZG2L_ADC depend on ARCH_RZG2L

Lars-Peter Clausen (2):
      iio: adc: ad_sigma_delta: Add sequencer support
      iio: Replace strtobool() with kstrtobool()

Lorenzo Bianconi (3):
      MAINTAINERS: updated Lorenzo's email address
      iio: imu: st_lsm6dsx: add support to ASM330LHHX
      dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx device bindings

Marek Vasut (11):
      iio: core: Print error and fail iio_device_register() in case sample =
bits do not fit storage bits
      dt-bindings: iio: adc: ti,ads1015: Add missing ADS1115 compatible str=
ing
      dt-bindings: iio: adc: ti,ads1015: Add TLA2024 compatible string
      iio: adc: ti-ads1015: Switch to static const writeable ranges table
      iio: adc: ti-ads1015: Deduplicate channel macros
      iio: adc: ti-ads1015: Make channel event_spec optional
      iio: adc: ti-ads1015: Add TLA2024 support
      iio: adc: ti-ads1015: Add static assert to test if shifted realbits f=
it into storagebits
      iio: adc: ti-ads1015: Convert to OF match data
      iio: adc: ti-ads1015: Replace data_rate with chip data struct ads1015=
_data
      iio: adc: ti-ads1015: Switch to read_avail

Ma=C3=ADra Canal (1):
      iio: adc: ad7266: convert probe to full device-managed

Miaoqian Lin (2):
      iio: adc: stmpe-adc: Fix wait_for_completion_timeout return value che=
ck
      iio: proximity: vl53l0x: Fix return value check of wait_for_completio=
n_timeout

Michael Srba (2):
      dt-bindings: iio: imu: mpu6050: Document invensense,icm20608d
      iio: imu: inv_mpu6050: Add support for ICM-20608-D

Miquel Raynal (13):
      iio: core: Enhance the kernel doc of modes and currentmodes iio_dev e=
ntries
      iio: magnetometer: rm3100: Stop abusing the ->currentmode
      iio: adc: stm32-dfsdm: Avoid dereferencing ->currentmode
      iio: st_sensors: Return as early as possible from the _write_raw() ca=
llbacks
      iio: st_sensors: Drop the protection on _avail functions
      iio: st_sensors: Add a local lock for protecting odr
      iio: st_sensors: Stop abusing mlock to ensure internal coherency
      iio: st_sensors: Use iio_device_claim/release_direct_mode() when rele=
vant
      iio: Un-inline iio_buffer_enabled()
      iio: core: Hide read accesses to iio_dev->currentmode
      iio: core: Move the currentmode entry to the opaque structure
      iio: core: Simplify the registration of kfifo buffers
      iio: core: Clarify the modes

Nuno S=C3=A1 (2):
      dt-bindings: iio: dac: change ad3552r maintainer
      MAINTAINERS: add ad3552r

Paul Lemmermann (2):
      iio: accel: dmard09: fixed code styling issues
      iio: accel: kxsd9-spi: changed leading spaces to tabs

Puranjay Mohan (1):
      iio: accel: adxl355: use fwnode_irq_get_byname()

Rob Herring (1):
      dt-bindings: iio: Fix incorrect compatible strings in examples

Sicelo A. Mhlongo (3):
      dt-bindings: iio: st,st-sensors add LIS302DL
      iio: accel: Remove unused enum in st_accel
      iio: accel: add support for LIS302DL variant

Uwe Kleine-K=C3=B6nig (1):
      iio: gyro: mpu3050: Make mpu3050_common_remove() return void

Xiaoke Wang (1):
      iio: dummy: iio_simple_dummy: check the return value of kstrdup()

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |   3 +-
 .../bindings/iio/adc/sprd,sc2720-adc.yaml          |  60 ++-
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |   7 +-
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |   2 +-
 .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml  |   2 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |  34 +-
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |  38 +-
 .../devicetree/bindings/iio/light/stk33xx.yaml     |   6 +
 .../iio/potentiometer/microchip,mcp4131.yaml       |   2 +-
 .../devicetree/bindings/iio/st,st-sensors.yaml     |   1 +
 MAINTAINERS                                        |  12 +-
 drivers/iio/accel/Kconfig                          |   1 -
 drivers/iio/accel/adxl355_core.c                   |   7 +-
 drivers/iio/accel/adxl367.c                        |   1 -
 drivers/iio/accel/bmc150-accel-core.c              |   4 +-
 drivers/iio/accel/dmard09.c                        |   2 +-
 drivers/iio/accel/fxls8962af-core.c                |   1 -
 drivers/iio/accel/kxsd9-spi.c                      |   4 +-
 drivers/iio/accel/mma8452.c                        |   1 +
 drivers/iio/accel/sca3000.c                        |   1 -
 drivers/iio/accel/ssp_accel_sensor.c               |   1 -
 drivers/iio/accel/st_accel.h                       |  28 +-
 drivers/iio/accel/st_accel_core.c                  |  14 +-
 drivers/iio/accel/st_accel_i2c.c                   |   5 +
 drivers/iio/accel/st_accel_spi.c                   |   5 +
 drivers/iio/adc/Kconfig                            |   2 +-
 drivers/iio/adc/ad7124.c                           |  86 +++-
 drivers/iio/adc/ad7192.c                           |  68 ++-
 drivers/iio/adc/ad7266.c                           |  44 +-
 drivers/iio/adc/ad7280a.c                          |   2 +-
 drivers/iio/adc/ad_sigma_delta.c                   | 143 ++++++-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   4 +-
 drivers/iio/adc/ina2xx-adc.c                       |   3 +-
 drivers/iio/adc/palmas_gpadc.c                     |   3 +-
 drivers/iio/adc/sc27xx_adc.c                       | 470 +++++++++++++++++=
++--
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   5 +-
 drivers/iio/adc/stmpe-adc.c                        |  21 +-
 drivers/iio/adc/ti-ads1015.c                       | 398 +++++++++--------
 drivers/iio/adc/ti-ads8688.c                       |   1 +
 drivers/iio/adc/ti_am335x_adc.c                    |   4 +-
 drivers/iio/afe/Kconfig                            |   1 -
 drivers/iio/afe/iio-rescale.c                      |   5 +-
 drivers/iio/buffer/kfifo_buf.c                     |  10 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   5 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |   1 -
 drivers/iio/common/ssp_sensors/ssp_spi.c           |  13 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  50 ++-
 drivers/iio/dac/Kconfig                            |   4 +-
 drivers/iio/dac/ad5064.c                           |   2 +-
 drivers/iio/dac/ad5360.c                           |   2 +-
 drivers/iio/dac/ad5380.c                           |   2 +-
 drivers/iio/dac/ad5446.c                           |   2 +-
 drivers/iio/dac/ad5504.c                           |   2 +-
 drivers/iio/dac/ad5624r_spi.c                      |   2 +-
 drivers/iio/dac/ad5686.c                           |   2 +-
 drivers/iio/dac/ad5755.c                           |   2 +-
 drivers/iio/dac/ad5791.c                           |   2 +-
 drivers/iio/dac/ad7303.c                           |   2 +-
 drivers/iio/dac/ltc2632.c                          |   8 +-
 drivers/iio/dac/ltc2688.c                          |  19 +-
 drivers/iio/dac/max5821.c                          |   2 +-
 drivers/iio/dac/mcp4725.c                          |   4 +-
 drivers/iio/dac/stm32-dac.c                        |   2 +-
 drivers/iio/dac/ti-dac082s085.c                    |   2 +-
 drivers/iio/dac/ti-dac5571.c                       |   2 +-
 drivers/iio/dac/ti-dac7311.c                       |   2 +-
 drivers/iio/dummy/iio_simple_dummy.c               |  20 +-
 drivers/iio/frequency/ad9523.c                     |   2 +-
 drivers/iio/gyro/fxas21002c_core.c                 |   8 +-
 drivers/iio/gyro/mpu3050-core.c                    |  14 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |   4 +-
 drivers/iio/gyro/mpu3050.h                         |   2 +-
 drivers/iio/gyro/ssp_gyro_sensor.c                 |   1 -
 drivers/iio/gyro/st_gyro_core.c                    |  15 +-
 drivers/iio/health/max30100.c                      |   1 -
 drivers/iio/health/max30102.c                      |   1 -
 drivers/iio/imu/adis16480.c                        |  91 ++--
 drivers/iio/imu/bmi160/bmi160_core.c               |  27 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |  13 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |  18 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |   1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |   1 -
 drivers/iio/imu/inv_mpu6050/Kconfig                |   4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |   9 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   5 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   6 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   6 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   5 +
 drivers/iio/industrialio-buffer.c                  |  42 +-
 drivers/iio/industrialio-core.c                    |  46 +-
 drivers/iio/industrialio-event.c                   |   2 +-
 drivers/iio/industrialio-trigger.c                 |   2 +-
 drivers/iio/light/Kconfig                          |   1 -
 drivers/iio/light/apds9960.c                       |   1 -
 drivers/iio/light/stk3310.c                        |  25 ++
 drivers/iio/light/tsl2772.c                        |  25 +-
 drivers/iio/magnetometer/Kconfig                   |   1 -
 drivers/iio/magnetometer/rm3100-core.c             |  15 +-
 drivers/iio/magnetometer/st_magn_core.c            |  15 +-
 drivers/iio/multiplexer/Kconfig                    |   1 -
 drivers/iio/multiplexer/iio-mux.c                  |  49 +--
 drivers/iio/pressure/st_pressure_core.c            |   8 +-
 drivers/iio/proximity/mb1232.c                     |   8 +-
 drivers/iio/proximity/ping.c                       |   5 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |   7 +-
 drivers/iio/temperature/ltc2983.c                  | 236 ++++++-----
 drivers/iio/temperature/max31856.c                 |   6 +-
 drivers/iio/temperature/max31865.c                 |   4 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |  11 +-
 drivers/staging/iio/cdc/ad7746.c                   |   2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   1 -
 drivers/staging/iio/resolver/ad2s1210.c            |   1 -
 include/linux/iio/adc/ad_sigma_delta.h             |  38 ++
 include/linux/iio/common/st_sensors.h              |   3 +
 include/linux/iio/iio-opaque.h                     |   4 +
 include/linux/iio/iio.h                            |  70 ++-
 include/linux/iio/kfifo_buf.h                      |   5 +-
 122 files changed, 1718 insertions(+), 835 deletions(-)
