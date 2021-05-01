Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D983937080A
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEARDy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231617AbhEARDw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27BDD61477;
        Sat,  1 May 2021 17:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888582;
        bh=yjn/eN2UBLrUOcdE+GFkeqeqLcjw9Twboe8KcaW4vxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3+RfnJenKLsEDMgr4W+UJsvQAQ1N9SQPWchhdoiKfkDOHu2jehAO9Eq1iMA2PXM4
         FQOmnavKouBIPNxEe4UxK3eN1NtdKexIEFbFELU/aetOERCimH5DC9wxLSuBx25EXU
         6nPqcw9z2hibm23q0BMVcjUnBy9qXmllEU0zmrdHC0s1EwtVvxiM2dWGm/HkcAW56J
         nZv+mg+ItAgyDXa7EQbrIioiu5LrzB5SUJF1HqednBD+LoAXl+MOZx2jaJaw1W77JS
         5wuFiKG5HOF4y90rRqLiP6StrEvr7xypComxQQM6Qi99PQooVFW0qjGs1/cvdDrIBO
         ocTsi0KdXWqWg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/19] iio: accel: stk8ba50: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:09 +0100
Message-Id: <20210501170121.512209-8-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501170121.512209-1-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To make code more readable, use a structure to express the channel
layout and ensure the timestamp is 8 byte aligned.

Found during an audit of all calls of this function.

Fixes: db6a19b8251f ("iio: accel: Add trigger support for STK8BA50")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/stk8ba50.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 7cf9cb7e8666..eb9daa4e623a 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -91,12 +91,11 @@ struct stk8ba50_data {
 	u8 sample_rate_idx;
 	struct iio_trigger *dready_trig;
 	bool dready_trigger_on;
-	/*
-	 * 3 x 16-bit channels (10-bit data, 6-bit padding) +
-	 * 1 x 16 padding +
-	 * 4 x 16 64-bit timestamp
-	 */
-	s16 buffer[8];
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		s16 chans[3];
+		s64 timetamp __aligned(8);
+	} scan;
 };
 
 #define STK8BA50_ACCEL_CHANNEL(index, reg, axis) {			\
@@ -324,7 +323,7 @@ static irqreturn_t stk8ba50_trigger_handler(int irq, void *p)
 		ret = i2c_smbus_read_i2c_block_data(data->client,
 						    STK8BA50_REG_XOUT,
 						    STK8BA50_ALL_CHANNEL_SIZE,
-						    (u8 *)data->buffer);
+						    (u8 *)data->scan.chans);
 		if (ret < STK8BA50_ALL_CHANNEL_SIZE) {
 			dev_err(&data->client->dev, "register read failed\n");
 			goto err;
@@ -337,10 +336,10 @@ static irqreturn_t stk8ba50_trigger_handler(int irq, void *p)
 			if (ret < 0)
 				goto err;
 
-			data->buffer[i++] = ret;
+			data->scan.chans[i++] = ret;
 		}
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   pf->timestamp);
 err:
 	mutex_unlock(&data->lock);
-- 
2.31.1

