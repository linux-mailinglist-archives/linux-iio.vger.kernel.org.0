Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8EE370808
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhEARDt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhEARDt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6136E61477;
        Sat,  1 May 2021 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888579;
        bh=g9zGHi6VqZegmJQ4m0Fgb/DTAkWVtIQaXtwK3z+zsCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yu5IHfQOjC5bi4dYYtfriMuFXCRlZBbqH77YV7+jCZkfJ8033uynketwtSnCQEd+P
         qnvGFao9m7KV2UVBpqzqCsOMV5HH4ROP3Zyj4Zj8+tp15QjZiBjwYdTI0nD0+WXlxp
         iN35v//gbyBuRJ7wGVzmVt3a1C0a+RpgvxqJ6Hk6McCBXA3Rojx4PYS2sQPk4Xz6S8
         QoKSq5YOjS1W5QF9NC0GlETx0c9K3Fn9kkAbbRBoVu7v74W78Jlt6yiMpnFxS2G97X
         DqYrdrwq/XwdthvCoPYpo4v6XxUodCOAg5eeb3W1rF2HSkjMOuaErJ6ZGznmsmaP6D
         siMqJUDpenZ2w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/19] iio: accel: mxc4005: Fix overread of data and alignment issue.
Date:   Sat,  1 May 2021 18:01:07 +0100
Message-Id: <20210501170121.512209-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501170121.512209-1-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The bulk read size is based on the size of an array that also has
space for the timestamp alongside the channels.
Fix that and also fix alignment of the buffer passed
to iio_push_to_buffers_with_timestamp.

Found during an audit of all calls to this function.

Fixes: 1ce0eda0f757 ("iio: mxc4005: add triggered buffer mode for mxc4005")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mxc4005.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index fb3cbaa62bd8..9e6066c6a2df 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -56,7 +56,11 @@ struct mxc4005_data {
 	struct mutex mutex;
 	struct regmap *regmap;
 	struct iio_trigger *dready_trig;
-	__be16 buffer[8];
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		__be16 chans[3];
+		s64 timestamp;
+	} scan;
 	bool trigger_enabled;
 };
 
@@ -135,7 +139,7 @@ static int mxc4005_read_xyz(struct mxc4005_data *data)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, MXC4005_REG_XOUT_UPPER,
-			       data->buffer, sizeof(data->buffer));
+			       data->scan.chans, sizeof(data->scan.chans));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read axes\n");
 		return ret;
@@ -301,7 +305,7 @@ static irqreturn_t mxc4005_trigger_handler(int irq, void *private)
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   pf->timestamp);
 
 err:
-- 
2.31.1

