Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 962254F652
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFVO50 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO50 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:57:26 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE94D20449;
        Sat, 22 Jun 2019 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215445;
        bh=j935Tv6qDA7STP636RvvyBwjYWz+e6Ww+7V6XBuDiGg=;
        h=From:To:Cc:Subject:Date:From;
        b=lQl5/+Exwb80nc2sFRKmrVQn+l3bz8CU8bHaJHOPR/e/IYovmG2zY8TJmidP9m9RD
         B87eqMZ20+PmgTucvBxcGUtevckBZZkYHGn61x8NPu8BYTqPed0ntA92TdeL1FWNaS
         RcACsJ98fiZO6fdYccJ1Unisgz19Ffr+6Wv/vgQM=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/14] iio: SPDX headers for core + non device driver parts.
Date:   Sat, 22 Jun 2019 15:55:02 +0100
Message-Id: <20190622145516.3231-1-jic23@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is a general movement towards ensuring all of the kernel source
files have SPDX headers.  I have previously expressed the view, that,
like many cleanups it would be better to do these when otherwise touching
the relevant part of the code, rather than creating noise throughout.

Time to change my mind on that, and push through adding these to IIO.

Even in the core code, I was less than entirely consistent with the
existing license markings, so there are places where the file headers
don't match with the MODULE_LICENSE macro.
There were also headers that gained default SPDX license markings
that actually aren't quite correct given the related c files sometimes
did have well stated licenses.

If someone has time to check my logic on the these that would be great.

For the drivers, my intent is to use random periods of boredom
(I'm on some long haul flights in the near future) to see if I can
plough through them.  If anyone wants to get ahead of the game and
do their own drivers that would be great.  This is particularly true
in the big octopus drivers that spread throughout the IIO directories
and beyond.  I'd love it if other people took those on.

If in doubt, don't do a given file or put out a clearly worded email
to the list asking for help!

Jonathan Cameron (14):
  iio: core: SPDX headers for core files. Note fix to MODULE_LICENSE
  iio:configfs: SPDX headers.
  iio: sw-device: SPDX headers
  iio: sw-trigger: SPDX headers.
  iio: triggered-event: Add SPDX and fix header license to match the
    code.
  iio:buffer-dma: SPDX headers.
  iio: buffer-cb: SPDX headers
  iio: kfifo-buf: Add SPDX header
  iio: buffer-dmaengine: SPDX GPL-2.0+
  iio: triggered-buffer: SPDX + fix MODULE_LICENSE to GPLv2
  iio: trig-hrtimer: SPDX header GPLv2
  iio: trig-interrupt: SPDX headers. GPLv2
  iio: trig-loop: SPDX headers GPL-v2
  iio: trig-sysfs: SPDX headers GPLv2.

 drivers/iio/buffer/industrialio-buffer-cb.c        |  8 +++-----
 drivers/iio/buffer/industrialio-buffer-dma.c       |  3 +--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  3 +--
 drivers/iio/buffer/industrialio-triggered-buffer.c |  9 +++------
 drivers/iio/buffer/kfifo_buf.c                     |  1 +
 drivers/iio/iio_core.h                             |  8 +++-----
 drivers/iio/iio_core_trigger.h                     |  2 +-
 drivers/iio/industrialio-buffer.c                  |  8 +++-----
 drivers/iio/industrialio-configfs.c                |  5 +----
 drivers/iio/industrialio-core.c                    | 10 ++++------
 drivers/iio/industrialio-event.c                   |  4 +++-
 drivers/iio/industrialio-sw-device.c               |  5 +----
 drivers/iio/industrialio-sw-trigger.c              |  5 +----
 drivers/iio/industrialio-trigger.c                 |  8 +++-----
 drivers/iio/industrialio-triggered-event.c         |  6 +-----
 drivers/iio/inkern.c                               |  8 +++-----
 drivers/iio/trigger/iio-trig-hrtimer.c             |  6 +-----
 drivers/iio/trigger/iio-trig-interrupt.c           |  5 +----
 drivers/iio/trigger/iio-trig-loop.c                |  3 +--
 drivers/iio/trigger/iio-trig-sysfs.c               |  4 +---
 include/linux/iio/buffer-dma.h                     |  3 +--
 include/linux/iio/buffer-dmaengine.h               |  3 +--
 include/linux/iio/buffer.h                         |  8 +++-----
 include/linux/iio/configfs.h                       |  5 +----
 include/linux/iio/consumer.h                       |  5 +----
 include/linux/iio/driver.h                         |  5 +----
 include/linux/iio/events.h                         |  8 +++-----
 include/linux/iio/iio.h                            |  9 +++------
 include/linux/iio/kfifo_buf.h                      |  2 +-
 include/linux/iio/machine.h                        |  5 +----
 include/linux/iio/sw_device.h                      |  5 +----
 include/linux/iio/sw_trigger.h                     |  5 +----
 include/linux/iio/sysfs.h                          | 10 ++++------
 include/linux/iio/trigger.h                        |  5 +----
 include/linux/iio/trigger_consumer.h               |  8 +++-----
 include/linux/iio/triggered_event.h                |  2 +-
 include/linux/iio/types.h                          |  8 +++-----
 37 files changed, 67 insertions(+), 140 deletions(-)

-- 
2.22.0

