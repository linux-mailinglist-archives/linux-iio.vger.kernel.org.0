Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E6337080E
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhEARD7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhEARD7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EF5560FEB;
        Sat,  1 May 2021 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888589;
        bh=4veJh2qzjTOWO3quX7QHsQN4m2CMLuUdQF/FColF4AQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUwrDz+xbMsCVr4W3nNn4GURnm31dDz3u8rtIta1fijCsllI1pdQRQPo++tuCNvMI
         ImTcNpMBr6N7StQWZNps7NLJSCQntvZWKbFDCaYFVy80/HIEhTXIb09uFNhwTf718Z
         sAJyh/x4Xfrq8sL8E4IsNX5MXxbWGXGRm2tu4E+hGQFw8B0YMvQ4/Q+bGrz+StRvIK
         h03BC0J3voX3L7yg+r7NMKtd1meZ8TYvII5YajqsogdpRnzqibgBFkftMzxrpwC5U/
         fYzBQcQ8D2gOxEWDX0wV3aIiZWxFEZOSce/L/Ht/ZCpia990W13UPJdU7iVeHG255F
         ObjRwSRXljWoQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/19] iio: humidity: am2315: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:13 +0100
Message-Id: <20210501170121.512209-12-jic23@kernel.org>
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

Found during an audit of all calls of uses of
iio_push_to_buffers_with_timestamp()

Fixes: 0d96d5ead3f7 ("iio: humidity: Add triggered buffer support for AM2315")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/humidity/am2315.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 23bc9c784ef4..248d0f262d60 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -33,7 +33,11 @@
 struct am2315_data {
 	struct i2c_client *client;
 	struct mutex lock;
-	s16 buffer[8]; /* 2x16-bit channels + 2x16 padding + 4x16 timestamp */
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		s16 chans[2];
+		s64 timestamp __aligned(8);
+	} scan;
 };
 
 struct am2315_sensor_data {
@@ -167,20 +171,20 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->lock);
 	if (*(indio_dev->active_scan_mask) == AM2315_ALL_CHANNEL_MASK) {
-		data->buffer[0] = sensor_data.hum_data;
-		data->buffer[1] = sensor_data.temp_data;
+		data->scan.chans[0] = sensor_data.hum_data;
+		data->scan.chans[1] = sensor_data.temp_data;
 	} else {
 		i = 0;
 		for_each_set_bit(bit, indio_dev->active_scan_mask,
 				 indio_dev->masklength) {
-			data->buffer[i] = (bit ? sensor_data.temp_data :
-						 sensor_data.hum_data);
+			data->scan.chans[i] = (bit ? sensor_data.temp_data :
+					       sensor_data.hum_data);
 			i++;
 		}
 	}
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.31.1

