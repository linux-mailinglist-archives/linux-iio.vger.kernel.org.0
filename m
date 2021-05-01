Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C1F370816
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhEAREM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhEAREL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:04:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E235E60FEB;
        Sat,  1 May 2021 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888601;
        bh=azOZ3oWPqPEnv/ZvwfFE6MgbISiEG91E4Ssn035gjJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHghj0weI9OFXBCP8hbrGrFs3XViReITm1/GJ+YTAAWwyVrWD6rS3pOkxzpgit8as
         5v/0GhyiVHgP7J16ju0Qib+vvSWx2wbMUefcZoWOVap7h4toA/77SdoRvqILq+dzM3
         dZokT5OxpfW5C0ul6hfxi+ukHg6h/1UYDBLu6OExsRRxCGF+NSvr1jd09knzIZwnNi
         2CEKqJT0srBNqWEi5gHXLjUIXqVMhvzERsUqHSWTCT32M3eRpinuAGxs4dxyc/ntSD
         cN1GjLEvLGLl24aBxD81IQzjEtNaYXR2FKFz7vbv7+3nUWYULkF0yLXEb+Bo0ME9VT
         69kUz0VWzYmug==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 19/19] iio: light: tcs3472: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:21 +0100
Message-Id: <20210501170121.512209-20-jic23@kernel.org>
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

Fixes tag is not strictly accurate as prior to that patch there was
potentially an unaligned write.  However, any backport past there will
need to be done manually.

Fixes: 0624bf847dd0 ("iio:tcs3472: Use iio_push_to_buffers_with_timestamp()")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/tcs3472.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index a0dc447aeb68..90dc3fef59e6 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -64,7 +64,11 @@ struct tcs3472_data {
 	u8 control;
 	u8 atime;
 	u8 apers;
-	u16 buffer[8]; /* 4 16-bit channels + 64-bit timestamp */
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u16 chans[4];
+		s64 timestamp __aligned(8);
+	} scan;
 };
 
 static const struct iio_event_spec tcs3472_events[] = {
@@ -386,10 +390,10 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
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

