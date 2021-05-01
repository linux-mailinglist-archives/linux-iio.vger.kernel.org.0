Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B058637080D
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhEARD6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhEARD6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 453FC61481;
        Sat,  1 May 2021 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888587;
        bh=YhgPQNVhD2LLf3qbyBKimqGaJBG0GcllGE/6daIATZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCCzHz5Hmb0p4gzwMjABEYMJqh/WzSEC6yDwGUKcDi4wsKFkU6MW/KWNVgw+hSk/Z
         fVfpIgnEy8f/17rhSF0BZBxH5rfy6hD2EJasnykA4tlFRZDDlFERnpUOEuY1PDRsyk
         FM6lsBn/wUhGPQtzamWUIdAuIVIbCUyI/kkaCaflFSmGordI6Xrw5kctrGGP6a/AVs
         F9nCSnYeITZNQRCWe3l2IW53bmqR2Sl3JseCk/y/25AUljiBZUr7CbT7cOb/SeGPuT
         Qp8pihJRwgQFbq7nxw20mVovIVviiDEcu5BqMFTn7N+xeRLraLZI7W2w1tlFnhjMVN
         5qPYqvEw4Sy2g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 10/19] iio: gyro: bmg160: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:12 +0100
Message-Id: <20210501170121.512209-11-jic23@kernel.org>
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

Fixes: 13426454b649 ("iio: bmg160: Separate i2c and core driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/iio/gyro/bmg160_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index b11ebd9bb7a4..7bc13ff2c3ac 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -98,7 +98,11 @@ struct bmg160_data {
 	struct iio_trigger *motion_trig;
 	struct iio_mount_matrix orientation;
 	struct mutex mutex;
-	s16 buffer[8];
+	/* Ensure naturally aligned timestamp */
+	struct {
+		s16 chans[3];
+		s64 timestamp __aligned(8);
+	} scan;
 	u32 dps_range;
 	int ev_enable_state;
 	int slope_thres;
@@ -882,12 +886,12 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 	ret = regmap_bulk_read(data->regmap, BMG160_REG_XOUT_L,
-			       data->buffer, AXIS_MAX * 2);
+			       data->scan.chans, AXIS_MAX * 2);
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.31.1

