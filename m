Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93F11D6B7B
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgEQRcK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 13:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgEQRcJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 13:32:09 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2549D207F9;
        Sun, 17 May 2020 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589736729;
        bh=FOrG8UWDVKJNMxjb0X/MNKghR0BM2Ws3q0sJ3IEFvUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgebiAvJycyKiIjO1BlFbkUER5jVJdtB8MiBYWiVSuX8ApGvElpQVNrEtVDSnlO95
         EjbfiiDmICyHW/uVE19elhBA2QnIIvA2dkm5QSnOFr8rwrtps+WPqyqwEkSFlryXyQ
         uDBDhNFrbdj5Iuha0de9UHqGYZUFb4fqO8VbD7bI=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 03/11] iio:accel:bmc150-accel: Fix timestamp alignment and prevent data leak.
Date:   Sun, 17 May 2020 18:29:52 +0100
Message-Id: <20200517173000.220819-4-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517173000.220819-1-jic23@kernel.org>
References: <20200517173000.220819-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses a 16 byte array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by moving
to a suitable structure in the iio_priv() data with alignment
ensured by use of an explicit c structure.  This data is allocated
with kzalloc so no data can leak appart from previous readings.

Fixes tag is beyond some major refactoring so likely manual backporting
would be needed to get that far back.

Fixes: 3bbec9773389 ("iio: bmc150_accel: add support for hardware fifo")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 121b4e89f038..b92e5a22feef 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -189,6 +189,14 @@ struct bmc150_accel_data {
 	struct mutex mutex;
 	u8 fifo_mode, watermark;
 	s16 buffer[8];
+	/*
+	 * Ensure there is sufficient space and correct alignment for
+	 * the timestamp if enabled
+	 */
+	struct {
+		__le16 channels[3];
+		s64 ts;
+	} scan;
 	u8 bw_bits;
 	u32 slope_dur;
 	u32 slope_thres;
@@ -922,15 +930,16 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 	 * now.
 	 */
 	for (i = 0; i < count; i++) {
-		u16 sample[8];
 		int j, bit;
 
 		j = 0;
 		for_each_set_bit(bit, indio_dev->active_scan_mask,
 				 indio_dev->masklength)
-			memcpy(&sample[j++], &buffer[i * 3 + bit], 2);
+			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
+			       2);
 
-		iio_push_to_buffers_with_timestamp(indio_dev, sample, tstamp);
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+						   tstamp);
 
 		tstamp += sample_period;
 	}
-- 
2.26.2

