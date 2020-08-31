Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB51F2576E6
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgHaJwR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgHaJwP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:52:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241072098B;
        Mon, 31 Aug 2020 09:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598867534;
        bh=OzJlyv6zfpLrfE/xsKIDjF9+3akmz0L+WDLmlsU0RIA=;
        h=Date:From:To:Subject:From;
        b=eu+c4byJW4Xzl0Jmf2qpflHXmQEni1zUR8QTI2/bWV/NRHTnyzloQkxXBOJ4rGLBr
         ++MMMUhGBu38gE5S8pKHlXDVXgnJTDV+lnXqtS5BW2oWgJbT3JSl633y8HTRRw70qj
         x+E8HmsbHZtVR+mWKCCypI8+BtBrVzTcszTr1yik=
Date:   Mon, 31 Aug 2020 10:52:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO fixes for 5.9 set 1
Message-ID: <20200831104333.6ceffa04@archlinux>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 1dffeb8b8b4c261c45416d53c75ea51e6ece1770:

  staging: greybus: audio: fix uninitialized value issue (2020-08-18 16:12:54 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.9a

for you to fetch changes up to 3f1093d83d7164e4705e4232ccf76da54adfda85:

  iio: adc: mcp3422: fix locking scope (2020-08-31 10:47:53 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 5.9 cycle

Most of the fixes this time are for a long term issue that Lars-Peter
Clausen identified recently.

IIO assumes that any data pushed to the buffer interface (either kfifo
or another in kernel consumer) are naturally aligned.  Unfortunately
this isn't true in a number of drivers, mostly by failing to ensure
the buffer used is aligned suitably for an s64 timestamp.

For the ones covered this time we use a structure to enforce this
alignment, with the added need for __aligned(8) to ensure 8 byte
alignment of the timestamp on x86_32 and similar platforms where
it would be 4 byte aligned giving different padded from some other
architectures.

Patches to make this requirement clearer and potentially cause an
error print will follow once we've cleaned up existing cases.
Note that it is a very hard to hit problem and as a result of this
as we only have one bug report despite the problem being present
for many years.

Other fixes:
* cros_ec:
  - set gyroscope default frequency. For some older boards not having
    this set can lead to a choice that doesn't work.
* counter,microchip-tcb-capture:
  - Fix a wrong value check in error check.
* mcp3422
  - Fix locking to protect against race condition.
* meson-adc
  - Use right device when looking up fuse values for calibration.
* rockchip-adc
  - Fix missing Kconfig dependency.
* ti-ads1015:
  - Fix reading when CONFIG_PM not set.

----------------------------------------------------------------
Angelo Compagnucci (1):
      iio: adc: mcp3422: fix locking scope

Dan Carpenter (1):
      counter: microchip-tcb-capture: check the correct variable

Gwendal Grignou (1):
      iio: cros_ec: Set Gyroscope default frequency to 25Hz

Jonathan Cameron (13):
      iio: accel: kxsd9: Fix alignment of local buffer.
      iio:accel:mma8452: Fix timestamp alignment and prevent data leak.
      iio:accel:bmc150-accel: Fix timestamp alignment and prevent data leak.
      iio:accel:mma7455: Fix timestamp alignment and prevent data leak.
      iio:proximity:mb1232: Fix timestamp alignment and prevent data leak.
      iio:chemical:ccs811: Fix timestamp alignment and prevent data leak.
      iio:light:max44000 Fix timestamp alignment and prevent data leak.
      iio:light:ltr501 Fix timestamp alignment issue.
      iio:magnetometer:ak8975 Fix alignment and data leak issues.
      iio:adc:ti-adc081c Fix alignment and data leak issues
      iio:adc:ti-adc084s021 Fix alignment and data leak issues.
      iio:adc:ina2xx Fix timestamp alignment issue.
      iio:adc:max1118 Fix alignment of timestamp and data leak issues

Martin Blumenstingl (1):
      iio: adc: meson-saradc: Use the parent device to look up the calib data

Maxim Kochetkov (1):
      iio: adc: ti-ads1015: fix conversion when CONFIG_PM is not set

Michael Walle (1):
      iio: adc: rockchip_saradc: select IIO_TRIGGERED_BUFFER

 drivers/counter/microchip-tcb-capture.c                 |  4 ++--
 drivers/iio/accel/bmc150-accel-core.c                   | 15 ++++++++++++---
 drivers/iio/accel/kxsd9.c                               | 16 +++++++++++-----
 drivers/iio/accel/mma7455_core.c                        | 16 ++++++++++++----
 drivers/iio/accel/mma8452.c                             | 11 ++++++++---
 drivers/iio/adc/Kconfig                                 |  2 ++
 drivers/iio/adc/ina2xx-adc.c                            | 11 +++++++----
 drivers/iio/adc/max1118.c                               | 10 +++++++---
 drivers/iio/adc/mcp3422.c                               | 12 +++++++-----
 drivers/iio/adc/meson_saradc.c                          |  2 +-
 drivers/iio/adc/ti-adc081c.c                            | 11 ++++++++---
 drivers/iio/adc/ti-adc084s021.c                         | 10 +++++++---
 drivers/iio/adc/ti-ads1015.c                            | 10 ++++++++++
 drivers/iio/chemical/ccs811.c                           | 13 +++++++++----
 .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c   |  5 ++++-
 drivers/iio/light/ltr501.c                              | 15 +++++++++------
 drivers/iio/light/max44000.c                            | 12 ++++++++----
 drivers/iio/magnetometer/ak8975.c                       | 16 +++++++++++-----
 drivers/iio/proximity/mb1232.c                          | 17 +++++++++--------
 19 files changed, 144 insertions(+), 64 deletions(-)
