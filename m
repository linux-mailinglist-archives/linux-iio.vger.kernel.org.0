Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132C2370812
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhEAREH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhEAREG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:04:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D80D961477;
        Sat,  1 May 2021 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888595;
        bh=ZOWV2SDaDrkdtQVbWb2Z/szrXi2HdONNTe26hCRcAi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2d0iXJG/chMjiUGfuVGbt565jEZyUE/Zj4x9x5wXopsCPLnvk7Unr9TDIHg1wlLQ
         3XMkYBUQGypVQnJ0ozNQ9e6vrqG5PTP4+lIR4xbDV2xac8k/xZp1tjsLV5VXq3eqx7
         xKbxPwWklb/0JdY9S2fvRmHusaOmeFf5Fd2oVHqsTqT7sYjv4bn71Dkhxbm5VSUUIT
         Bnkgyo/hlvujSoUaHJxdusPjd/wvyJd4S4Arrl/iIHApt54yPk/MzM8euSSTbZj2T7
         WcrDAYQZeNLwvs2bLNtwYA23i3GLHUCX+cHjzun24nL9ZqDXZkeS+Hpch7BXMagIk2
         3n5/VbAG34C5w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/19] iio: magn: hmc5843: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:17 +0100
Message-Id: <20210501170121.512209-16-jic23@kernel.org>
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

Fixes: 7247645f6865 ("iio: hmc5843: Move hmc5843 out of staging")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/hmc5843.h      | 8 ++++++--
 drivers/iio/magnetometer/hmc5843_core.c | 4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index 3f6c0b662941..242f742f2643 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -33,7 +33,8 @@ enum hmc5843_ids {
  * @lock:		update and read regmap data
  * @regmap:		hardware access register maps
  * @variant:		describe chip variants
- * @buffer:		3x 16-bit channels + padding + 64-bit timestamp
+ * @scan:		buffer to pack data for passing to
+ *			iio_push_to_buffers_with_timestamp()
  */
 struct hmc5843_data {
 	struct device *dev;
@@ -41,7 +42,10 @@ struct hmc5843_data {
 	struct regmap *regmap;
 	const struct hmc5843_chip_info *variant;
 	struct iio_mount_matrix orientation;
-	__be16 buffer[8];
+	struct {
+		__be16 chans[3];
+		s64 timestamp __aligned(8);
+	} scan;
 };
 
 int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 780faea61d82..221563e0c18f 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -446,13 +446,13 @@ static irqreturn_t hmc5843_trigger_handler(int irq, void *p)
 	}
 
 	ret = regmap_bulk_read(data->regmap, HMC5843_DATA_OUT_MSB_REGS,
-			       data->buffer, 3 * sizeof(__be16));
+			       data->scan.chans, sizeof(data->scan.chans));
 
 	mutex_unlock(&data->lock);
 	if (ret < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
 
 done:
-- 
2.31.1

