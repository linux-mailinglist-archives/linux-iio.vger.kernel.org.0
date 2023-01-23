Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4859667866A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jan 2023 20:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjAWTd5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Jan 2023 14:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAWTd4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2023 14:33:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6031E29
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2023 11:33:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46F3B61026
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2023 19:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A53C433D2;
        Mon, 23 Jan 2023 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674502430;
        bh=mgJWgGjjZ2kSnTcJCQxgldyBfGgrVo2mkMhxGvoJYxI=;
        h=Date:From:To:Subject:From;
        b=TW29qCM401ID20EX3XMb2REYgVA3NOdftsN/WEXO71t3KUPQM6muR7t9SUqwmGmnH
         ErkxB+ol0N5Mcx6kMeVmWrZiUzosRHElt/FGqrSymoo/zWIH0Hh+5nKXO02+iJC45j
         pqYyoCiil3A4y0X14jZdblNcMrCrd7LSvBkuh5ds+GwmX3Mc4an/0Pcp90pzMe8wi7
         g0VAGQal2Xna/6JA/Wue/BWvWP2S1u8IYsBtoelQHeupgaL6u5gMh8V5nLvIoxLcu3
         hqon8Z+bBOZUUVgjUi12+werqJDekEGVpOaq49eVo3xF5rd06ekp8qH7DJKg9hUCq7
         U31wL2kymWx8g==
Date:   Mon, 23 Jan 2023 19:47:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO fixes for 6.2 - set 1
Message-ID: <20230123194738.25eb2a1a@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.2a

for you to fetch changes up to 2acd031347f645871959a799238a7caf6803aa18:

  iio: imu: fxos8700: fix MAGN sensor scale and unit (2023-01-21 18:15:19 +0000)

----------------------------------------------------------------
1st set of IIO fixes for the 6.2 cycle.

The usual mixed bag - with a bunch of issues found by Carlos Song
in the fxos8700 IMU driver dominating.

hid-accel,gyro
 - Fix wrong returned value when read succeeds.
marvell,berlin-adc
 - Missing of_node_put() in an error path.
nxp,fxos8700 (freescale)
 - Wrong channel type match.
 - Swapped channel read back.
 - Incomplete channel read back (not enough bytes).
 - Missing shift of acceleration data.
 - Range selection didn't work (datasheet bug)
 - Wrong ODR mode read back due to wrong field offset.
 - Drop unused, but wrong define.
 - Fix issue with magnetometer scale an units.
nxp,imx8qxp
- Fix an irq flood due to not reading data early enough.
st,lsm6dsx
 - Add CONFIG_IIO_TRIGGERED_BUFFER select.
st,stm32-adc
 - Fix missing MODULE_DEVICE_TABLE() needed for module aliases.
ti,twl6030
 - Fix missing enable of some channels.
 - Fix a typo in previous patch that meant one channel still wasn't enabled.
xilinx,xadc
 - Carrying on incorrectly after allocation error.

----------------------------------------------------------------
Andreas Kemnade (2):
      iio:adc:twl6030: Enable measurements of VUSB, VBAT and others
      iio:adc:twl6030: Enable measurement of VAC

Carlos Song (9):
      iio: imu: fxos8700: fix map label of channel type to MAGN sensor
      iio: imu: fxos8700: fix swapped ACCEL and MAGN channels readback
      iio: imu: fxos8700: fix incomplete ACCEL and MAGN channels readback
      iio: imu: fxos8700: fix IMU data bits returned to user space
      iio: imu: fxos8700: fix ACCEL measurement range selection
      iio: imu: fxos8700: fix incorrect ODR mode readback
      iio: imu: fxos8700: fix failed initialization ODR mode assignment
      iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
      iio: imu: fxos8700: fix MAGN sensor scale and unit

Dmitry Perchanov (2):
      iio: hid: fix the retval in accel_3d_capture_sample
      iio: hid: fix the retval in gyro_3d_capture_sample

Frank Li (1):
      iio: imx8qxp-adc: fix irq flood when call imx8qxp_adc_read_raw()

Kai-Heng Feng (1):
      iio: light: cm32181: Fix PM support on system with 2 I2C resources

Marco Pagani (1):
      iio: adc: xilinx-ams: fix devm_krealloc() return value check

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: fill module aliases

Vladimir Oltean (1):
      iio: imu: st_lsm6dsx: fix build when CONFIG_IIO_TRIGGERED_BUFFER=m

Xiongfeng Wang (1):
      iio: adc: berlin2-adc: Add missing of_node_put() in error path

 drivers/iio/accel/hid-sensor-accel-3d.c |   1 +
 drivers/iio/adc/berlin2-adc.c           |   4 +-
 drivers/iio/adc/imx8qxp-adc.c           |  11 +++-
 drivers/iio/adc/stm32-dfsdm-adc.c       |   1 +
 drivers/iio/adc/twl6030-gpadc.c         |  32 +++++++++
 drivers/iio/adc/xilinx-ams.c            |   2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c   |   1 +
 drivers/iio/imu/fxos8700_core.c         | 111 +++++++++++++++++++++++++-------
 drivers/iio/imu/st_lsm6dsx/Kconfig      |   1 +
 drivers/iio/light/cm32181.c             |   9 +--
 10 files changed, 143 insertions(+), 30 deletions(-)
