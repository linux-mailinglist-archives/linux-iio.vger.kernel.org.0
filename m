Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD4370815
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhEAREL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhEAREK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:04:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9436661477;
        Sat,  1 May 2021 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888600;
        bh=MAt3aC5al6Sv9K15KjrI9e2/IKOQ8IyL4jK5DAJXg9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkH6m9wEjwkO8ObM5g2a8v08hRvGa9Q8gwlCBD+tgZlAT9Fsvfph/yOabPdhi19k+
         KIyT8BRohV1ojub8f/9czvf0s+QD6P6Bg1erkQexzkzcQBz/IVGkP8F9XY/oxI7xEi
         v+dtnbtfXQ8dJaggrtlrSDjxM0Oxm2UEsIg+9298pgkxON3Dxjc5O2J5QHuwQJY1OL
         xAZh5O4EE4TnSmAJcJL2PvRDBe6wGdn2dfeQsxksbiRR4bSSInUV1GsUd1sv1MKXqt
         PrIhxcNY+OQ28cm6NzvFFKF/pyUsnh5CrvPe01JHLnjHvBSPUV7RYWfpgWpIvvtCVs
         G6wDItW39x3fA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 18/19] iio: light: tcs3414: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:20 +0100
Message-Id: <20210501170121.512209-19-jic23@kernel.org>
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

Fixes: a244e7b57f0f ("iio: Add driver for AMS/TAOS tcs3414 digital color sensor")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/tcs3414.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 6fe5d46f80d4..0593abd600ec 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -53,7 +53,11 @@ struct tcs3414_data {
 	u8 control;
 	u8 gain;
 	u8 timing;
-	u16 buffer[8]; /* 4x 16-bit + 8 bytes timestamp */
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u16 chans[4];
+		s64 timestamp __aligned(8);
+	} scan;
 };
 
 #define TCS3414_CHANNEL(_color, _si, _addr) { \
@@ -209,10 +213,10 @@ static irqreturn_t tcs3414_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			goto done;
 
-		data->buffer[j++] = ret;
+		data->scan.chans[j++] = ret;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 		iio_get_time_ns(indio_dev));
 
 done:
-- 
2.31.1

