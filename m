Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01A457B7FC
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jul 2022 15:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbiGTN51 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jul 2022 09:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTN50 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2022 09:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA228E04
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 06:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AC23617BF
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 13:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF678C3411E;
        Wed, 20 Jul 2022 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658325444;
        bh=7KLjulLcpwN0TOZpHMF4+juPXodUldYVA5Osk2x4xvU=;
        h=Date:From:To:Subject:From;
        b=CH14NF1aVl9cZ18Bz2+0TK+6HuVN3ZIEOznPDLxX/rULfJZbacKMotxHYdgNHrblt
         Sx0o/id3Htuxn+uW1lKrXEaOywYoIFVw2X5M7B+gK+YnjTh3xp4v5+rxmqux/l6Q9K
         XbDKzlGhs/EihRBgRMvG1v8G2td6W12v/fbSDEbc3yeDagTF3MVDxdOV3dKInR22mB
         IxYsbRbIT0qCjisKO9OGio2B+3M5L29xg3MjW+hSVwTFXQ8f1e7zts1v2K32qXJeMQ
         JiEM3Yic63A4qMcwVyaG41qB19JU0FDBIsOP6YYa7CRqqh0CUm9P2hnRKvh7WmW3FD
         hP5Dxnjf0+r9w==
Date:   Wed, 20 Jul 2022 15:07:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd IIO pull request for 5.20
Message-ID: <20220720150723.262e2084@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit e0e1824bf69e9a342eb4854cf10ce2ba4c840e36:

  Merge tag 'extcon-next-for-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next (2022-07-16 07:24:37 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.20b

for you to fetch changes up to 180c6cb6b9b79c55b79e8414f4c0208f2463af7d:

  dt-bindings: iio: adc: Add compatible for MT8188 (2022-07-19 13:20:22 +0100)

----------------------------------------------------------------
2nd set of IIO new device support, cleanup etc for 5.20

Given the slight delay in the likely start of the merge cycle lets get
a few more things in for IIO.  A few late breaking fixes also included.
Bulk in number of patches is mechanical conversion to new PM macros.

New device support
* npcm
  - Add support for NPCM8XX with different resolution and voltage references
    from previously supported parts.

Tree wide
* pm_ptr()/pm_sleep_ptr()/DEFINE_[SIMPLE/RUNTIME]_DEV_PM_OPS() conversions
  - Convert all the low hanging fruit to the new macros. The remaining
    cases will need more careful consideration.

Tidy-up, fixes and minor features.
* Documentation
  - Fix duplicate ABI definitions and a missing blank line to squash all
    remaining docs build issues in IIO.
* core
  - Make iio_format_avail_range() handle non IIO_VAL_INT cases.
* core/trigger
  - Move the setup of trigger->owner to allocation rather than registration.
    There doesn't seem to be any advantage in doing this late and a few bugs
    have occurred because of mis-balanced module reference counting.
  - coding style fix-ups.
* tests
  - Allow kunit tests to be built as a module.
* ad7949
  - Fix a reversed error message.
* cio-dac
  - Use structures for register map to improve readability.
* cros_ec
  - Register fifo callback only after the sensor is registered. Closes
    a theoretical race.
* hmc5843
  - Duplicate word fix.
* isl29028
  - Fix mixed devm_ and non devm_ for iio_device_register().
* max1027
  - Fix missing unlocks in error paths.
* rm3100
  - Let core code handle setting INDIO_BUFFER_TRIGGERED.
* sca3000
  - Fix ordering and buffer size issue.
* sx_common
  - Don't use the IIO device to get device properties when the parent struct
    device is readily available.
  - Allow the IIO core to connect up the firmware node.
* stx104
  - Use structures for register map to improve readability.
* vf610-adc
  - Add compatible entries for imx6ul and imx6sx with fallback to
    fsl,vf610-adc.

----------------------------------------------------------------
Akira Yokosawa (1):
      iio: proximity: sx9324: add empty line in front of bullet list

Alexander Stein (1):
      dt-bindings: iio: adc: Add imx6ul & imx6sx compatibles

Andy Shevchenko (2):
      iio: proximity: sx_common: Don't use IIO device for properties
      iio: proximity: sx_common: Allow IIO core to take care of firmware node

Dan Carpenter (1):
      iio: adc: max1027: unlock on error path in max1027_read_single_value()

Dmitry Rokosov (1):
      iio: trigger: move trig->owner init to trigger allocate() stage

Fawzi Khaber (1):
      iio: fix iio_format_avail_range() printing for none IIO_VAL_INT

Gwendal Grignou (1):
      iio: cros: Register FIFO callback after sensor is registered

Hui.Liu (1):
      dt-bindings: iio: adc: Add compatible for MT8188

Jiang Jian (1):
      iio: magnetometer: hmc5843: Remove duplicate 'the'

Joe Simmons-Talbott (2):
      iio: Use parens with sizeof
      iio: Be consistent with allocation result tests.

Jonathan Cameron (40):
      iio: ABI: temperature: Unify documentation for thermocouple fault detection.
      iio: ABI: max31865: Drop in_filter_notch_centre_frequency as in main docs.
      iio: ABI: stm32-timer-trigger: Fuse unusual ABI into main doc.
      iio: adc: ti-ads124s08: Drop unused parameter to ads124s_read()
      iio: accel: bma220: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: ad799x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: at91-sam5d2: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: imx7d_adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: meson_saradc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: mt6577_auxadc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: stmpe-adc: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: ti-am335x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: adc: xilinx-ams: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: chemical: scd4x: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: ds4424: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: ltc1660: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: max517: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: max5821: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: dac: mcp4725: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: gyro: itg3200: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: health: afe4403: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: health: afe4404: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: al3010: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: al3320a: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: as73211: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: bh1750: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: cm3605: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: proximity: cros_ec_mkbp: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: temperature: ltc2983: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      iio: light: us5182: Switch from CONFIG_PM guards to pm_ptr() etc
      iio: adc: imx8qxp: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
      iio: light: gp2ap002: Switch to DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
      iio: light: isl29028: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
      iio: light: tsl2583: Use DEFINE_RUNTIME_DEV_PM_OPS and pm_ptr()
      iio: light: tsl2591: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr()
      iio: light: vcnl4000: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
      iio: light: vcnl4035: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
      iio: light: veml6030: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
      iio: magnetometer: ak8974: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
      iio: magn: yas530: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros

LI Qingwu (1):
      iio: accel: sca3300: Extend the trigger buffer from 16 to 32 bytes

Liam Beguin (5):
      iio: test: rescale: add MODULE_* information
      iio: test: format: add MODULE_* information
      iio: test: format: follow CONFIG_ naming convention
      iio: afe: rescale: export symbols used during testing
      iio: test: rework Kconfig to support modules

Marcus Folkesson (1):
      iio: magnetometer: rm3100: do not explicity set INDIO_BUFFER_TRIGGERED mode

Thorsten Scherer (1):
      iio: adc: ad7949: Fix error message

Tomer Maimon (2):
      dt-bindings: iio: adc: npcm: Add npcm845 compatible string
      iio: adc: npcm: Add NPCM8XX support

William Breathitt Gray (2):
      iio: adc: stx104: Implement and utilize register structures
      iio: dac: cio-dac: Cleanup indexing for DAC writes

Zheyu Ma (1):
      iio: light: isl29028: Fix the warning in isl29028_remove()

 Documentation/ABI/testing/sysfs-bus-iio            |  3 +
 Documentation/ABI/testing/sysfs-bus-iio-sx9324     |  1 +
 .../ABI/testing/sysfs-bus-iio-temperature-max31856 | 31 ---------
 .../ABI/testing/sysfs-bus-iio-temperature-max31865 | 20 ------
 .../ABI/testing/sysfs-bus-iio-thermocouple         | 18 ++++++
 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  8 ---
 .../devicetree/bindings/iio/adc/fsl,vf610-adc.yaml |  9 ++-
 .../bindings/iio/adc/mediatek,mt2701-auxadc.yaml   |  1 +
 .../bindings/iio/adc/nuvoton,npcm750-adc.yaml      |  7 +-
 drivers/iio/accel/bma220_spi.c                     |  8 +--
 drivers/iio/accel/cros_ec_accel_legacy.c           |  4 +-
 drivers/iio/accel/sca3300.c                        | 30 +++++----
 drivers/iio/adc/ad7949.c                           |  2 +-
 drivers/iio/adc/ad799x.c                           |  8 +--
 drivers/iio/adc/at91-sama5d2_adc.c                 |  9 +--
 drivers/iio/adc/imx7d_adc.c                        |  5 +-
 drivers/iio/adc/imx8qxp-adc.c                      | 13 ++--
 drivers/iio/adc/max1027.c                          |  6 +-
 drivers/iio/adc/meson_saradc.c                     | 10 +--
 drivers/iio/adc/mt6577_auxadc.c                    | 12 ++--
 drivers/iio/adc/npcm_adc.c                         | 36 +++++++++--
 drivers/iio/adc/stmpe-adc.c                        |  6 +-
 drivers/iio/adc/stx104.c                           | 74 +++++++++++++++-------
 drivers/iio/adc/ti-ads124s08.c                     |  6 +-
 drivers/iio/adc/ti_am335x_adc.c                    |  8 +--
 drivers/iio/adc/xilinx-ams.c                       |  8 +--
 drivers/iio/afe/iio-rescale.c                      |  2 +
 drivers/iio/chemical/scd4x.c                       |  8 +--
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c |  4 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  6 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 58 ++++++++++++-----
 drivers/iio/dac/cio-dac.c                          | 10 +--
 drivers/iio/dac/ds4424.c                           |  8 +--
 drivers/iio/dac/ltc1660.c                          |  9 +--
 drivers/iio/dac/max517.c                           |  8 +--
 drivers/iio/dac/max5821.c                          |  9 +--
 drivers/iio/dac/mcp4725.c                          |  9 +--
 drivers/iio/gyro/itg3200_core.c                    |  9 +--
 drivers/iio/health/afe4403.c                       |  9 +--
 drivers/iio/health/afe4404.c                       |  9 +--
 drivers/iio/industrialio-core.c                    | 18 +++++-
 drivers/iio/industrialio-trigger.c                 | 52 ++++++++-------
 drivers/iio/light/al3010.c                         |  8 +--
 drivers/iio/light/al3320a.c                        |  9 +--
 drivers/iio/light/as73211.c                        |  9 +--
 drivers/iio/light/bh1750.c                         |  6 +-
 drivers/iio/light/cm3605.c                         | 13 ++--
 drivers/iio/light/cros_ec_light_prox.c             |  6 +-
 drivers/iio/light/gp2ap002.c                       | 14 ++--
 drivers/iio/light/isl29028.c                       | 15 ++---
 drivers/iio/light/tsl2583.c                        | 13 ++--
 drivers/iio/light/tsl2591.c                        | 12 ++--
 drivers/iio/light/us5182d.c                        |  8 +--
 drivers/iio/light/vcnl4000.c                       | 14 ++--
 drivers/iio/light/vcnl4035.c                       | 14 ++--
 drivers/iio/light/veml6030.c                       | 14 ++--
 drivers/iio/magnetometer/ak8974.c                  | 14 ++--
 drivers/iio/magnetometer/hmc5843_core.c            |  2 +-
 drivers/iio/magnetometer/rm3100-core.c             |  2 +-
 drivers/iio/magnetometer/yamaha-yas530.c           | 14 ++--
 drivers/iio/pressure/cros_ec_baro.c                |  6 +-
 drivers/iio/proximity/cros_ec_mkbp_proximity.c     |  8 +--
 drivers/iio/proximity/sx_common.c                  | 10 +--
 drivers/iio/temperature/ltc2983.c                  |  9 +--
 drivers/iio/test/Kconfig                           | 26 +++++---
 drivers/iio/test/Makefile                          |  2 +-
 drivers/iio/test/iio-test-format.c                 |  4 ++
 drivers/iio/test/iio-test-rescale.c                |  5 ++
 include/linux/iio/common/cros_ec_sensors_core.h    |  7 +-
 include/linux/iio/iio.h                            |  9 ++-
 include/linux/iio/trigger.h                        | 21 +++---
 71 files changed, 468 insertions(+), 397 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-thermocouple
