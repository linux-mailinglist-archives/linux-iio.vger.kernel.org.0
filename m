Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D0A3A5938
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhFMPKv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231782AbhFMPKu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:10:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DAA661285;
        Sun, 13 Jun 2021 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623596926;
        bh=KVrdJaAQ5hLeF6HsSxPKqs8ME0ny2DG/KFMmusvANTo=;
        h=From:To:Cc:Subject:Date:From;
        b=NFGELbjL3xQ5YnhI48FWwXw8w8rLwnMiCYH2H145n0+nBC9j6iZmYvxTM8qDclJHz
         qadvc/PZLNSfI5Isir7coDmZLswtH0wyNsJU1S4gY9SH4BN4OvwgbBl97erQjINp0C
         p2ndF2uPutxEBMd3pBVRFoVVKuqimWNca2rA53boHv43lONSSfLvkMbM8Nan9jGb+8
         /OejCNerYWU9QyAnXyoCtDAut4xW18kT0QExqFRx7bhypUl6gq6sVDQ51dngbIAZu8
         59Q7NEnDv84bk/xIBYabAf1J1wGRSTiV2bfblc44NbFkPdrwinX2TMqqBY5a1p/O4+
         ytYrt0dWH+7dA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/4] IIO: Alignment fixes part 4 - bounce buffers for the hard cases.
Date:   Sun, 13 Jun 2021 16:10:35 +0100
Message-Id: <20210613151039.569883-1-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks to Andy and Nuno for reviews.

Chances since V1/RFC:
* Renamed the function to iio_push_to_buffer_with_ts_unaligned()
* Fixed the various bugs people pointed out.
* Used more standard realloc handling to be more 'obviously' correct.
* Added some additional comments on the sizing of the copy to explain why
  it is a conservative estimate and may copy more than strictly necessary.

A few things we discussed I didn't do (for now)...

I decided against adding explicit bounce buffer allocation calls for now,
though I'm open to doing that in future if we find doing the somewhat hidden
realloc to be a problem.

I haven't computed a more precise data_sz as I don't thing the benefits
of a more precise copy or not passing the size, make it worth the slight
reduction in complexity for the callers.  Again, open to revisiting this
in future!

I tested it by hacking the dummy driver to shift it's data by one
byte and call iio_push_to_buffers_with_ts_unaligned().

Strictly a hack. I definitely don't want to move this driver over to this
new interface as it might encourage inappropriate use.

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 59aa60d4ca37..b47af7df8efc 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -19,6 +19,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <asm/unaligned.h>
 
 #include "iio_simple_dummy.h"
 
@@ -78,12 +79,13 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
                        j = find_next_bit(indio_dev->active_scan_mask,
                                          indio_dev->masklength, j);
                        /* random access read from the 'device' */
-                       data[i] = fakedata[j];
+//                     data[i] = fakedata[j];
+                       put_unaligned_le16(fakedata[j], ((u8 *)(&data[i])) + 1);
                        len += 2;
                }
        }
 
-       iio_push_to_buffers_with_timestamp(indio_dev, data,
+       iio_push_to_buffers_with_ts_unaligned(indio_dev, ((u8 *)(data)) + 1, indio_dev->scan_bytes - 8,
                                           iio_get_time_ns(indio_dev));


v1 description:

I finally got around to do a manual audit of all the calls to
iio_push_to_buffers_with_timestamp() which has the somewhat odd requirements
of:
1. 8 byte alignment of the provided buffer.
2. space for an 8 byte naturally aligned timestamp to be inserted at the
   end.

Unfortunately there were rather a lot of these left, but time to bite the bullet
and clean them up.

As discussed previous in
https://lore.kernel.org/linux-iio/20200920112742.170751-1-jic23@kernel.org/
it is not easy to fix the alignment issue without requiring a bounce buffer.
This final part of the 4 sets of fixes is concerned with the cases where
bounce buffers are the proposed solutions.

In these cases we have hardware that reads a prefix that we wish to
drop. That makes it hard to directly read the data into the correct location.

Rather than implementing bouce buffers in each case, this set provides some
magic in the core to handle them via a new function.
iio_push_to_buffers_with_ts_na() - non aligned

Note this is totally untested as I don't have suitable hardware or emulation.
I can fake something up in the dummy driver or via QEMU but I definitely want
both eyes and testing on this series!

Jonathan Cameron (4):
  iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()
  iio: adc: ti-adc108s102: Fix alignment of buffer pushed to iio
    buffers.
  iio: gyro: mpu3050: Fix alignment and size issues with buffers.
  iio: imu: adis16400: Fix buffer alignment requirements.

 drivers/iio/adc/ti-adc108s102.c   | 11 ++++----
 drivers/iio/gyro/mpu3050-core.c   | 24 ++++++++--------
 drivers/iio/imu/adis16400.c       | 20 ++++++++++----
 drivers/iio/industrialio-buffer.c | 46 +++++++++++++++++++++++++++++++
 include/linux/iio/buffer.h        |  4 +++
 include/linux/iio/iio-opaque.h    |  4 +++
 6 files changed, 86 insertions(+), 23 deletions(-)

-- 
2.32.0

