Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B736537A740
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhEKNAE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 09:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhEKNAE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 May 2021 09:00:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E9B61932;
        Tue, 11 May 2021 12:58:56 +0000 (UTC)
Date:   Tue, 11 May 2021 14:00:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 5.13 cycle.
Message-ID: <20210511140003.7a6c6c30@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.13a

for you to fetch changes up to af0e1871d79cfbb91f732d2c6fa7558e45c31038:

  iio: tsl2583: Fix division by a zero lux_val (2021-05-10 14:01:48 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 5.13 cycle

A couple of high priority core fixes and the usual bits scattered
across individual drivers.

core:
* Fix ioctl handler double free.
* Fix an accidental ABI change wrt to error codes when an IOCTL is not
  supported.

gp2ap002:
* Runtime pm imbalance on error.
hid-sensors:
* Fix a Kconfig dependency issue in a particularly crazy config.
mpu3050:
* Fix wrong temperature calculation due to a type needing to be signed.
pulsedlight:
* Runtime pm imbalance on error.
tsl2583
* Fix a potential division by zero.

----------------------------------------------------------------
Alexandru Ardelean (2):
      iio: hid-sensors: select IIO_TRIGGERED_BUFFER under HID_SENSOR_IIO_TRIGGER
      iio: core: return ENODEV if ioctl is unknown

Colin Ian King (1):
      iio: tsl2583: Fix division by a zero lux_val

Dinghao Liu (2):
      iio: light: gp2ap002: Fix rumtime PM imbalance on error
      iio: proximity: pulsedlight: Fix rumtime PM imbalance on error

Dmitry Osipenko (1):
      iio: gyro: mpu3050: Fix reported temperature value

Tomasz Duszynski (1):
      iio: core: fix ioctl handlers removal

 drivers/iio/accel/Kconfig                         |  1 -
 drivers/iio/common/hid-sensors/Kconfig            |  1 +
 drivers/iio/gyro/Kconfig                          |  1 -
 drivers/iio/gyro/mpu3050-core.c                   | 13 +++++++++++--
 drivers/iio/humidity/Kconfig                      |  1 -
 drivers/iio/industrialio-core.c                   |  9 +--------
 drivers/iio/light/Kconfig                         |  2 --
 drivers/iio/light/gp2ap002.c                      |  5 +++--
 drivers/iio/light/tsl2583.c                       |  8 ++++++++
 drivers/iio/magnetometer/Kconfig                  |  1 -
 drivers/iio/orientation/Kconfig                   |  2 --
 drivers/iio/pressure/Kconfig                      |  1 -
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c |  1 +
 drivers/iio/temperature/Kconfig                   |  1 -
 14 files changed, 25 insertions(+), 22 deletions(-)
