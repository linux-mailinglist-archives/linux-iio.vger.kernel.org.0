Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3C46D087
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 11:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhLHKJV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 8 Dec 2021 05:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhLHKJV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 05:09:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F7C0617A2
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 02:05:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CE735CE20CC
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 10:05:47 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 4822FC00446;
        Wed,  8 Dec 2021 10:05:44 +0000 (UTC)
Date:   Wed, 8 Dec 2021 10:10:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 2nd set of IIO fixes for 5.16
Message-ID: <20211208101050.50ef90e8@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.16b

for you to fetch changes up to 893621e0606747c5bbefcaf2794d12c7aa6212b7:

  iio: trigger: stm32-timer: fix MODULE_ALIAS (2021-12-04 15:37:02 +0000)

----------------------------------------------------------------
2nd set of IIO fixes for 5.16

Note 1st set were before the merge window.

Biggest set in here fix what happens when things go wrong in
the interrupt handlers for an IIO trigger.

Otherwise normal mix of recent and ancient bugs.

trigger core
 - Fix reference counting bug that was preventing the iio_trig
   structures from being released.
adxrs290
 - Correctly sign extend the rate and temperature data.
at91-sama5d2
 - Fix sign extension from the wrong bit and use the scan_type
   values to avoid it being open coded in two places (which were
   out of sync)
axp20x_adc
 - Fix current reporting bit depth.
dln2-adc
 - Fix a lock ordering issue and lockdep complaint that results.
 - Add error handling for failure to register the trigger.
imx8qxp
 - Wrong config dependency
kxcjk-1013
 - Potential leak due to wrong guard on cleanup.
ltr501, kxsd9, stk3310, itg3200, ad7768
 - Don't return error codes from interrupt handler and call
   iio_trigger_notify_done() on all paths to avoid leaving
   trigger disabled on an intermittent fault.
mma8452
 - Fix missing iio_trigger_get() that could lead to use after free.
stm32
 - Fix a current leak.
 - Avoid null pointer derefence on defer_probe error due to wrong
   struct device being passed.
stm32-timer
 - Drop space in MODULE_ALIAS.

----------------------------------------------------------------
Alyssa Ross (1):
      iio: trigger: stm32-timer: fix MODULE_ALIAS

Evgeny Boger (1):
      iio: adc: axp20x_adc: fix charging current reporting on AXP22x

Fabrice Gasnier (1):
      iio: adc: stm32: fix a current leak by resetting pcsel before disabling vdda

Gwendal Grignou (1):
      iio: at91-sama5d2: Fix incorrect sign extension

Kister Genesis Jimenez (1):
      iio: gyro: adxrs290: fix data signedness

Lars-Peter Clausen (8):
      iio: ltr501: Don't return error code in trigger handler
      iio: kxsd9: Don't return error code in trigger handler
      iio: stk3310: Don't return error code in interrupt handler
      iio: mma8452: Fix trigger reference couting
      iio: trigger: Fix reference counting
      iio: dln2: Check return value of devm_iio_trigger_register()
      iio: itg3200: Call iio_trigger_notify_done() on error
      iio: ad7768-1: Call iio_trigger_notify_done() on error

Lukas Bulwahn (1):
      iio: imx8qxp-adc: fix dependency to the intended ARCH_MXC config

Noralf Trønnes (1):
      iio: dln2-adc: Fix lockdep complaint

Olivier Moysan (1):
      iio: adc: stm32: fix null pointer on defer_probe error

Yang Yingliang (1):
      iio: accel: kxcjk-1013: Fix possible memory leak in probe and remove

 drivers/iio/accel/kxcjk-1013.c            |  5 ++---
 drivers/iio/accel/kxsd9.c                 |  6 +++---
 drivers/iio/accel/mma8452.c               |  2 +-
 drivers/iio/adc/Kconfig                   |  2 +-
 drivers/iio/adc/ad7768-1.c                |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c        |  3 ++-
 drivers/iio/adc/axp20x_adc.c              | 18 +++---------------
 drivers/iio/adc/dln2-adc.c                | 21 ++++++++++++---------
 drivers/iio/adc/stm32-adc.c               |  3 ++-
 drivers/iio/gyro/adxrs290.c               |  5 +++--
 drivers/iio/gyro/itg3200_buffer.c         |  2 +-
 drivers/iio/industrialio-trigger.c        |  1 -
 drivers/iio/light/ltr501.c                |  2 +-
 drivers/iio/light/stk3310.c               |  6 +++---
 drivers/iio/trigger/stm32-timer-trigger.c |  2 +-
 15 files changed, 36 insertions(+), 44 deletions(-)
