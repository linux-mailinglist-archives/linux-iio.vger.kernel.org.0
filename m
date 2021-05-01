Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFFB3707FA
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 18:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhEAQzm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 12:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEAQzm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 12:55:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AAA861459;
        Sat,  1 May 2021 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888092;
        bh=PEOILIYk7lWdgrDQVgxebujywNWQ6JLX3kDYv7lbgx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7PsdL7HBno3zb6nWMC+jhDhKUqDcqWVPPhoFIG5GGAboZl4IopDtNRgStiEyV+PQ
         JYTzouykBUcBJbeWdxAeuvoD6gVXPTTydrkPzSJpawMbSaoMfQP66J92owP9BcwkSK
         IK+pVBB3Nb878S28KVBj8K5GDlLlFXIY8Eb12m7rupFWzYpJP191BgM2rNneDmIyrR
         xu3y7lpZNeX7Zp0l37CWrpTM9T4swmrpccS1nV/p0nkHebjoPvd2J7n/3kkVMdrWZ6
         CqB21qMw4oP++BHxP9yLBkb/WNlStwj6Jg7vaAJL9K9cg0DGSh2zoTL1bNA6ghLP8r
         n62IpXVLxs8Aw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/2] iio: adc: ad7768-1: Fix too small buffer passed to iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 17:53:13 +0100
Message-Id: <20210501165314.511954-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501165314.511954-1-jic23@kernel.org>
References: <20210501165314.511954-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add space for the timestamp to be inserted.  Also ensure correct
alignment for passing to iio_push_to_buffers_with_timestamp()

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7768-1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c945f1349623..60f21fed6dcb 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -167,6 +167,10 @@ struct ad7768_state {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
+		struct {
+			__be32 chan;
+			s64 timestamp;
+		} scan;
 		__be32 d32;
 		u8 d8[2];
 	} data ____cacheline_aligned;
@@ -469,11 +473,11 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 
 	mutex_lock(&st->lock);
 
-	ret = spi_read(st->spi, &st->data.d32, 3);
+	ret = spi_read(st->spi, &st->data.scan.chan, 3);
 	if (ret < 0)
 		goto err_unlock;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.d32,
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
 					   iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.31.1

