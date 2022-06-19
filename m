Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB235550C21
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiFSQlJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 12:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFSQlJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 12:41:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7025CE34
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 09:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E084611E3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A552C34114;
        Sun, 19 Jun 2022 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655656866;
        bh=ALXNXfY9LW5stzXwG3UnG7Yf2a/38ZMYmZCtgmKNxrQ=;
        h=Date:From:To:Subject:From;
        b=nwSa5UBUblpOb4AdDEgAAlEdBFHQcuo66+3Uw8MckcCqRtrfL8dqonKqqtUnWZRXw
         etqJ0H3/vcH2tgiZVoJVeaEPC+oEPBHVpUovW/laqWCYGItOKsfBWK/DxmLpG4jrPg
         j0Mho2Jpj9Xcve9cwayG118ix7DT8LS5tZAFoNI93qfZ7AUpC2Khk4Ci1+Jbjp0mXM
         uptH3DrrAJRb35Kz9hkgSsMZ5AR+gQqb5aTdQr2FOkLcDVbnivZOCFPQDJdgDXwh9E
         J5HwX++v8ckexLBk4Hm1jh17EVC8lnDt8FyrvvL2ZBEFT/JMBqL+Uz9O2/pcBJgfBf
         uZPZgQfNTHgHw==
Date:   Sun, 19 Jun 2022 17:50:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for 5.19
Message-ID: <20220619175025.72b3edb4@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 57ae8a492116910bad2b3497ffe555b3a4b4180f:

  Merge tag 'driver-core-5.18-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2022-04-30 10:24:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.19a

for you to fetch changes up to 70171ed6dc53d2f580166d47f5b66cf51a6d0092:

  iio:proximity:sx9324: Check ret value of device_property_read_u32_array() (2022-06-19 17:22:49 +0100)

----------------------------------------------------------------
1st set of IIO fixes for the 5.19 cycle.

Most of these have been in next for a long time. Unfortunately there
was one stray patch in the branch (wasn't a fix), so I've just rebased
to remove that.

* testing
  - Fix a missing MODULE_LICENSE() warning by restricting possible build
    configs.
* Various drivers
  - Fix ordering of iio_get_trigger() being called before
    iio_trigger_register()
* adi,admv1014
  - Fix dubious x & !y warning.
* adi,axi-adc
  - Fix missing of_node_put() in error and normal paths.
* aspeed,adc
  - Add missing of_node_put()
* fsl,mma8452
  - Fix broken probing from device tree.
  - Drop check on return value of i2c write to device to cause reset as
    ACK will be missing (device reset before sending it).
* fsl,vf610
  - Fix documentation of in_conversion_mode ABI.
* iio-trig-sysfs
  - Ensure irq work has finished before freeing the trigger.
* invensense,mpu3050
 - Disable regulators in error path.
* invensense,icm42600
  - Fix collision of enum value of 0 with error path where 0 is no match.
* renesas,rzg2l_Adc
  - Add missing fwnode_handle_put() in error path.
* rescale
  - Fix a boolean logic bug for detection of raw + scale affecting an
    obscure corner case.
* semtech,sx9324
  - Check return value of read of pin_defs
* st,stm32-adc:
  - Fix interaction across ADC instances for some supported devices.
  - Drop false spurious IRQ messages.
  - Fix calibration value handling.  If we can't calibrate don't expose the
    vref_int channel.
  - Fix maximum clock rate for stm32pm15x
* ti,ads131e08
  - Add missing fwnode_handle_put() in error paths.
* xilinx,ams
  - Fix variable checked for error from platform_get_irq()
* x-powers,axp288
  - Overide TS_PIN bias current for boards where it is not correctly
    initialized.
* yamaha,yas530
  - Fix inverted check on calibration data being all zeros.

----------------------------------------------------------------
Aashish Sharma (1):
      iio:proximity:sx9324: Check ret value of device_property_read_u32_array()

Antoniu Miclaus (1):
      iio: freq: admv1014: Fix warning about dubious x & !y and improve readability

Baruch Siach (1):
      iio: adc: vf610: fix conversion mode sysfs node name

Dmitry Rokosov (5):
      iio:accel:bma180: rearrange iio trigger get and register
      iio:accel:kxcjk-1013: rearrange iio trigger get and register
      iio:accel:mxc4005: rearrange iio trigger get and register
      iio:chemical:ccs811: rearrange iio trigger get and register
      iio:humidity:hts221: rearrange iio trigger get and register

Haibo Chen (2):
      iio: mma8452: fix probe fail when device tree compatible is used.
      iio: accel: mma8452: ignore the return value of reset operation

Hans de Goede (1):
      iio: adc: axp288: Override TS pin bias current for some models

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: Fix broken icm42600 (chip id 0 value)

Jialin Zhang (2):
      iio: adc: rzg2l_adc: add missing fwnode_handle_put() in rzg2l_adc_parse_properties()
      iio: adc: ti-ads131e08: add missing fwnode_handle_put() in ads131e08_alloc_channels()

Liam Beguin (1):
      iio: test: fix missing MODULE_LICENSE for IIO_RESCALE=m

Linus Walleij (2):
      iio: magnetometer: yas530: Fix memchr_inv() misuse
      iio: afe: rescale: Fix boolean logic bug

Lv Ruyi (1):
      iio: adc: xilinx-ams: fix return error variable

Miaoqian Lin (2):
      iio: adc: aspeed: Fix refcount leak in aspeed_adc_set_trim_data
      iio: adc: adi-axi-adc: Fix refcount leak in adi_axi_adc_attach_client

Olivier Moysan (2):
      iio: adc: stm32: fix vrefint wrong calibration value handling
      iio: adc: stm32: fix maximum clock rate for stm32mp15x

Vincent Whitchurch (1):
      iio: trigger: sysfs: fix use-after-free on remove

Yannick Brosseau (2):
      iio: adc: stm32: Fix ADCs iteration in irq handler
      iio: adc: stm32: Fix IRQs on STM32F4 by removing custom spurious IRQs message

Zheyu Ma (1):
      iio: gyro: mpu3050: Fix the error handling in mpu3050_power_up()

 Documentation/ABI/testing/sysfs-bus-iio-vf610    |  2 +-
 drivers/iio/accel/bma180.c                       |  3 +-
 drivers/iio/accel/kxcjk-1013.c                   |  4 +--
 drivers/iio/accel/mma8452.c                      | 22 +++++++++-----
 drivers/iio/accel/mxc4005.c                      |  4 +--
 drivers/iio/adc/adi-axi-adc.c                    |  3 ++
 drivers/iio/adc/aspeed_adc.c                     |  1 +
 drivers/iio/adc/axp288_adc.c                     |  8 +++++
 drivers/iio/adc/rzg2l_adc.c                      |  8 +++--
 drivers/iio/adc/stm32-adc-core.c                 |  9 ++++--
 drivers/iio/adc/stm32-adc.c                      | 37 +++++++++++-------------
 drivers/iio/adc/ti-ads131e08.c                   | 10 +++++--
 drivers/iio/adc/xilinx-ams.c                     |  2 +-
 drivers/iio/afe/iio-rescale.c                    |  2 +-
 drivers/iio/chemical/ccs811.c                    |  4 +--
 drivers/iio/frequency/admv1014.c                 |  6 ++--
 drivers/iio/gyro/mpu3050-core.c                  |  1 +
 drivers/iio/humidity/hts221_buffer.c             |  5 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c |  2 +-
 drivers/iio/magnetometer/yamaha-yas530.c         |  2 +-
 drivers/iio/proximity/sx9324.c                   |  3 ++
 drivers/iio/test/Kconfig                         |  2 +-
 drivers/iio/test/Makefile                        |  2 +-
 drivers/iio/trigger/iio-trig-sysfs.c             |  1 +
 25 files changed, 92 insertions(+), 52 deletions(-)
