Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45065D1795
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2019 20:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfJIScp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Oct 2019 14:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJIScp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Oct 2019 14:32:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E4CE206C0;
        Wed,  9 Oct 2019 18:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570645963;
        bh=z1HwQ11MAagggHVl9h2z/Oo/3fToPeTj9A9N8WSMCFQ=;
        h=Date:From:To:Subject:From;
        b=QXfQXTxUgJeOrX/nXKpcHK8LJHP4m3iu9/1333jW4536pokO2LKtf/N+b6JxGCJl1
         YK6bion+NLNqECZ0G8h9lizw/O8sk5UmxhIepYJAm7YDEbt0oDpbCnB6Yd6Ta/l5IV
         y31udGNPVLFXXP7B4JnwTU8eS+p48thow5X83RN4=
Date:   Wed, 9 Oct 2019 19:32:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] 1st set of IIO fixes for the 5.4 cycle.
Message-ID: <20191009193239.694ff6ab@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit b33f56a1e40588214320926293585f088fb390b0:

  staging: rtl8723bs: hal: remove redundant variable n (2019-09-06 18:20:33 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.4a

for you to fetch changes up to a26e0fbe06e20077afdaa40d1a90092f16b0bc67:

  iio: Fix an undefied reference error in noa1305_probe (2019-10-09 19:11:29 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 5.4 cycle.

* adis16400
  - Make sure to free memory on a few failure paths.
* adxl372
  - Fix wrong fifo depth
  - Fix wrong indexing of data from the fifo.
  - Perform a reset at startup to avoid a problem with inconsistent state.
* axp288
  - This is a fix for a fix.  The original fix made sure we kept the
    configuration from some firmwares to preserve a bias current.
    Unfortunately it appears the previous behaviour was working around
    a buggy firmware by overwriting the wrong value it had.  Hence
    a regression was seen.
* bmc150
  - Fix the centre temperature.  This was due to an error in one of the
    datasheets.
* hx711
  - Fix an issue where a badly timed interrupt could lead to a control
    line being high long enough to put the device into a low power state.
* meson_sar_adc
  - Fix a case where the irq was enabled before everything it uses was
    allocated.
* st_lsm6dsx
  - Ensure we don't set the sensor sensitivity to 0 as it will force
    all readings to 0.
  - Fix a wait time for the slave i2c controller when the accelerometer
    is not enabled.
* stm32-adc
  - Precursor for fix. Move a set of register definitions to a header.
  - Fix a race when several ADCs are in use with some using interrupts
    to control the dataflow and some using DMA.
* vcnl4000
  - Fix a garbage of_match_table in which a string was passed instead
    of the intended enum.

----------------------------------------------------------------
Andreas Klinger (1):
      iio: adc: hx711: fix bug in sampling of data

David Frey (1):
      iio: light: opt3001: fix mutex unlock race

Fabrice Gasnier (2):
      iio: adc: stm32-adc: move registers definitions
      iio: adc: stm32-adc: fix a race when using several adcs with dma and irq

Hans de Goede (1):
      iio: adc: axp288: Override TS pin bias current for some models

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: forbid 0 sensor sensitivity
      iio: imu: st_lsm6dsx: fix waitime for st_lsm6dsx i2c controller

Marco Felsch (3):
      iio: light: fix vcnl4000 devicetree hooks
      iio: light: add missing vcnl4040 of_compatible
      iio: adc: ad799x: fix probe error handling

Navid Emamdoost (2):
      iio: imu: adis16400: release allocated memory on failure
      iio: imu: adis16400: fix memory leak

Pascal Bouwmann (1):
      iio: fix center temperature of bmc150-accel-core

Remi Pommarel (1):
      iio: adc: meson_saradc: Fix memory allocation order

Stefan Popa (3):
      iio: accel: adxl372: Fix/remove limitation for FIFO samples
      iio: accel: adxl372: Fix push to buffers lost samples
      iio: accel: adxl372: Perform a reset at start up

zhong jiang (1):
      iio: Fix an undefied reference error in noa1305_probe

 drivers/iio/accel/adxl372.c                  |  22 ++++-
 drivers/iio/accel/bmc150-accel-core.c        |   2 +-
 drivers/iio/adc/ad799x.c                     |   4 +-
 drivers/iio/adc/axp288_adc.c                 |  32 +++++++
 drivers/iio/adc/hx711.c                      |  10 +-
 drivers/iio/adc/meson_saradc.c               |  10 +-
 drivers/iio/adc/stm32-adc-core.c             |  70 ++++++++------
 drivers/iio/adc/stm32-adc-core.h             | 137 +++++++++++++++++++++++++++
 drivers/iio/adc/stm32-adc.c                  | 109 ---------------------
 drivers/iio/imu/adis_buffer.c                |  10 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  28 ++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  15 ++-
 drivers/iio/light/Kconfig                    |   1 +
 drivers/iio/light/opt3001.c                  |   6 +-
 drivers/iio/light/vcnl4000.c                 |  14 ++-
 16 files changed, 290 insertions(+), 182 deletions(-)
