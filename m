Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D0F3A593C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhFMPK4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhFMPKz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:10:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DBAF611C0;
        Sun, 13 Jun 2021 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623596934;
        bh=NuLD9nXi+L3dTsAfhpzZdAOEKP0d7QlNkroYcf+j7lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WCgLBfjWd9syT9jMuHK64PNqfW9hOBPEvdhCtx0AT0YQ170p2eR1FGlQQVaDXQf/4
         EdWl4XxUrNYI19uqzKF0DeGzAD0/+kTUOHMJWL0RoqudFNTYSEsulrarHyI7VSqEmP
         sXmBc2yS8JUvsui5nFhXHNdbIEE9dzmUbFMYfpXlUn9zzezqgmw+/Q9oR1eAn79AJV
         WS9b1CTpgBeJyME9mKDu2T/swjxhFkAQaRnh5JogQL3tLyk26lXhUs9RxBgNY5P7cL
         4SoGqBNX79zXoM+K2mceBOhxAJ16m87/PEkc1N/08HnXOXt2ZOpCwqJwF/5PxhS7hr
         Z37zD/wC/i68g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 3/4] iio: gyro: mpu3050: Fix alignment and size issues with buffers.
Date:   Sun, 13 Jun 2021 16:10:38 +0100
Message-Id: <20210613151039.569883-4-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613151039.569883-1-jic23@kernel.org>
References: <20210613151039.569883-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fix a set of closely related issues.
1. When using fifo_values() there was not enough space for the timestamp to
   be inserted by iio_push_to_buffers_with_timestamp()
2. fifo_values() did not meet the alignment requirement of
   iio_push_to_buffers_with_timestamp()
3. hw_values did not meet the alignment requirement either.

1 and 2 fixed by using new iio_push_to_buffers_with_ts_unaligned() which has
no alignment or space padding requirements.
3 fixed by introducing a structure that makes the space and alignment
requirements explicit.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 3225de1f023b..ea387efab62d 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -471,13 +471,10 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
 	int ret;
-	/*
-	 * Temperature 1*16 bits
-	 * Three axes 3*16 bits
-	 * Timestamp 64 bits (4*16 bits)
-	 * Sum total 8*16 bits
-	 */
-	__be16 hw_values[8];
+	struct {
+		__be16 chans[4];
+		s64 timestamp __aligned(8);
+	} scan;
 	s64 timestamp;
 	unsigned int datums_from_fifo = 0;
 
@@ -572,9 +569,10 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 				fifo_values[4]);
 
 			/* Index past the footer (fifo_values[0]) and push */
-			iio_push_to_buffers_with_timestamp(indio_dev,
-							   &fifo_values[1],
-							   timestamp);
+			iio_push_to_buffers_with_ts_unaligned(indio_dev,
+							      &fifo_values[1],
+							      sizeof(__be16) * 4,
+							      timestamp);
 
 			fifocnt -= toread;
 			datums_from_fifo++;
@@ -632,15 +630,15 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 		goto out_trigger_unlock;
 	}
 
-	ret = regmap_bulk_read(mpu3050->map, MPU3050_TEMP_H, &hw_values,
-			       sizeof(hw_values));
+	ret = regmap_bulk_read(mpu3050->map, MPU3050_TEMP_H, scan.chans,
+			       sizeof(scan.chans));
 	if (ret) {
 		dev_err(mpu3050->dev,
 			"error reading axis data\n");
 		goto out_trigger_unlock;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, hw_values, timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, timestamp);
 
 out_trigger_unlock:
 	mutex_unlock(&mpu3050->lock);
-- 
2.32.0

