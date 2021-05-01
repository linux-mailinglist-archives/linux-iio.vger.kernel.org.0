Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66037083F
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhEAR1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231724AbhEAR1d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:27:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B18A26157E;
        Sat,  1 May 2021 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619890003;
        bh=JoCp7na093tHRDNFCpVgawLhstlanRFN7EVE+Cga+pE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sA7tZEWL8WY1zutbQAI4E6H6SzQTiNw5paHUZnzXNUtzzabdI64KiR/SJkdudSyJV
         DJGufWsEb/7y9LPHU2yq8RRkvhbNBTFH98MZgtWxHjLTo6MBNhraUe0r5nuVTpUTIz
         iK+4Zre2qQsMvCIlIcGp/jMizn79n3lw5F7meuwn2HItDucfjA0N1KTZ+AuA/1+L1b
         99d1o7FDdbH7N57U2um245xuthiqKN/xTC1508kTDrfplsIhMycTZ0M9rEE6xzByvs
         WqS7v1dzvUdX3OdiLCqScjjncAcwTiqBDe05xgOEV05Oai42JrYw8XlLTv73eVgJTc
         D3niLPguI/7tg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFC PATCH 3/4] iio: gyro: mpu3050: Fix alignment and size issues with buffers.
Date:   Sat,  1 May 2021 18:25:14 +0100
Message-Id: <20210501172515.513486-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501172515.513486-1-jic23@kernel.org>
References: <20210501172515.513486-1-jic23@kernel.org>
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

1 and 2 fixed by using new iio_push_to_buffers_with_ts_na() which has
no alignment or space padding requirements.
3 fixed by introducing a structure that makes the space and alignment
requirements explicit.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ac90be03332a..a7fdfe811258 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -462,13 +462,10 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
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
 
@@ -563,9 +560,10 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 				fifo_values[4]);
 
 			/* Index past the footer (fifo_values[0]) and push */
-			iio_push_to_buffers_with_timestamp(indio_dev,
-							   &fifo_values[1],
-							   timestamp);
+			iio_push_to_buffers_with_ts_na(indio_dev,
+						       &fifo_values[1],
+						       sizeof(__be16) * 4,
+						       timestamp);
 
 			fifocnt -= toread;
 			datums_from_fifo++;
@@ -623,15 +621,15 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
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
2.31.1

