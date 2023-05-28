Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3991713BE3
	for <lists+linux-iio@lfdr.de>; Sun, 28 May 2023 20:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjE1Svz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 May 2023 14:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjE1Svy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 May 2023 14:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066FFBE
        for <linux-iio@vger.kernel.org>; Sun, 28 May 2023 11:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9148160EF9
        for <linux-iio@vger.kernel.org>; Sun, 28 May 2023 18:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A13CC433D2;
        Sun, 28 May 2023 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685299912;
        bh=0/Oi9JHb0gCVBONSDKy3vCr+sXCXtB7QcKSOuNPabaw=;
        h=Date:From:To:Subject:From;
        b=K30xQccKtddWMbi3bc695Ge7qZgfBb1avxr69yx3yLo/EOW95R5kkmb46bvhEa5su
         AfonorgMbrm5vsmLyoljxbxvRA+bwyHDoHZxGWy3h4TCwq2u+uX17gvubn4RO4VCkf
         RvW0/D5YSxbzyR/H/gnjCia0GIbwi/dXM4YXe4HCyZafhbxahfTrMov6mug4h97MBp
         b3Gib2xkO8fsgHisxzE9HqcD3YPbwYnNEiMPfANyW1PSx0JTxgxWpoZu/MQ1Xd9v4/
         5B4lHacN8DL8wWS2R2sltIafp7H1kjqbAT0C15rm/MeXvWlr+TV3FK9asM/L9umtsO
         8CaMpJx0kVVyQ==
Date:   Sun, 28 May 2023 20:08:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for the 6.4 cycle.
Message-ID: <20230528200811.11b15e04@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.4a

for you to fetch changes up to bbaae0c79ebd49f61ad942a8bf9e12bfc7f821bb:

  iio: imu: inv_icm42600: fix timestamp reset (2023-05-20 17:33:14 +0100)

----------------------------------------------------------------
1st set of IIO fixes for the 6.4 cycle.

Usual mixed bag of issues in new code for this cycle and old issues
that have surfaced in the last few weeks.

- adi,ad_sigma_delta
  * Ensure irq lazy disable handing is not used as it breaks completion
    detection.
- adi,ad4130
  * Fix failure to remove clock provider.
- adi,ad5758
  * Wrong CONFIG variable used to control driver build.
- adi,ad7192
  * Fix repeated channel index by just expressing shorted channels
    as differential channel between a channel and itself.
- adi,ad74413
  * Fix error handling for resistance input processing to not fail
    in case of success.
- rohm,bu27034
  * Fix integration time in wrong units (should be seconds not usecs)
  * Ensure reset is actually written not detected as already set from
    regcache.
- gts helper
  * Fix wrong parameter docs.
  * Fix integration time in wrong units (should be seconds not usecs)
- fsl,imx8qxp-adc
  * Add missing vref-supply to binding doc (already used by driver)
- fsl,imx93
  * Fix sign bug in read_raw() so that error check didn't work.
- inv,icm42600
  * Fix reset of timestamp to work even if a particular sensor is off when
    the chip is first enabled.
- kionix,kx022a
  * Fix irq get form fw node to not include the 0 value.
- microchip,mcp4725
  * Fix return value from i2c_master_send() handling to nto assume 0 on
    success.
- mediatek,mt6370
  * Fix incorrect scaling of a few currents on devices with particular
    vendor IDs.
- fsl,mxs-lradc
  * Cleanup ordering issue fix.
- renesas,rcar-adc bindings
  * Fix missing vendor prefix for adi,ad7476
- st,st_accel
  * Fix handling when no ACPI _ONT method present.
- st,stm32-adc
  * Handle no adc-diff-channel present case (all single ended)
  * Handle no adc-channels present case (all differential)
- ti,palmas
  * Fix off by one bug that could allow out of bounds read if callers
    provided wrong value.
- ti,tmag5273
  * Fix a runtime PM leak on measurement error
- vishay,vcnl4035
  * Correctly mask chip ID so devices with different addresses
    don't fail the test.

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: iio: imx8qxp-adc: add missing vref-supply

ChiaEn Wu (1):
      iio: adc: mt6370: Fix ibus and ibat scaling value of some specific vendor ID chips

Dan Carpenter (2):
      iio: adc: imx93: fix a signedness bug in imx93_adc_read_raw()
      iio: adc: palmas: fix off by one bugs

Frank Li (1):
      iio: light: vcnl4035: fixed chip ID check

Geert Uytterhoeven (1):
      dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix adi,ad7476 compatible value

Hans de Goede (1):
      iio: accel: st_accel: Fix invalid mount_matrix on devices without ACPI _ONT method

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: fix timestamp reset

Jiakai Luo (1):
      iio: adc: mxs-lradc: fix the order of two cleanup operations

Lars-Peter Clausen (2):
      iio: tmag5273: Fix runtime PM leak on measurement error
      iio: ad4130: Make sure clock provider gets removed

Lukas Bulwahn (1):
      iio: dac: build ad5758 driver when AD5758 is selected

Marek Vasut (1):
      iio: dac: mcp4725: Fix i2c_master_send() return value handling

Masahiro Honda (1):
      iio: adc: ad_sigma_delta: Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag

Matti Vaittinen (5):
      iio: fix doc for iio_gts_find_sel_by_int_time
      iio: bu27034: Fix integration time
      iio: gts-helpers: fix integration time units
      iio: bu27034: Ensure reset is written
      iio: accel: kx022a fix irq getting

Paul Cercueil (1):
      iio: adc: ad7192: Change "shorted" channels to differential

Rasmus Villemoes (1):
      iio: addac: ad74413: fix resistance input processing

Sean Nyekjaer (2):
      iio: adc: stm32-adc: skip adc-diff-channels setup if none is present
      iio: adc: stm32-adc: skip adc-channels setup if none is present

 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml          |  7 +++
 .../bindings/iio/adc/renesas,rcar-gyroadc.yaml     |  2 +-
 drivers/iio/accel/kionix-kx022a.c                  |  2 +-
 drivers/iio/accel/st_accel_core.c                  |  4 +-
 drivers/iio/adc/ad4130.c                           | 12 ++++-
 drivers/iio/adc/ad7192.c                           |  8 +--
 drivers/iio/adc/ad_sigma_delta.c                   |  4 ++
 drivers/iio/adc/imx93_adc.c                        |  7 ++-
 drivers/iio/adc/mt6370-adc.c                       | 53 ++++++++++++++++++-
 drivers/iio/adc/mxs-lradc-adc.c                    | 10 ++--
 drivers/iio/adc/palmas_gpadc.c                     | 10 ++--
 drivers/iio/adc/stm32-adc.c                        | 61 ++++++++++++----------
 drivers/iio/addac/ad74413r.c                       |  2 +-
 drivers/iio/dac/Makefile                           |  2 +-
 drivers/iio/dac/mcp4725.c                          | 16 +++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 10 ++--
 drivers/iio/industrialio-gts-helper.c              | 42 +++++++++++----
 drivers/iio/light/rohm-bu27034.c                   | 26 ++++++---
 drivers/iio/light/vcnl4035.c                       |  3 ++
 drivers/iio/magnetometer/tmag5273.c                |  5 +-
 include/linux/iio/iio-gts-helper.h                 |  2 +-
 21 files changed, 204 insertions(+), 84 deletions(-)
