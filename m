Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FE370811
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhEAREG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231656AbhEAREE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:04:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5537D60FEB;
        Sat,  1 May 2021 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888594;
        bh=CZaWdYvJfSheM3gn+Kj753t6keyx1hku+m4Q1HlhPqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RuXN01rVSMswmERoBiMU6bOl0/99RYffBEjIAxfSxP5l0c+7P6lbIEVmws+pnLpEM
         7Wyt7bEH4r9e0/wi4rHX6FR9M4I5k+7Up18ZvUeNaTzhENMJzEKQE6MSZeHQJfa8GT
         d81YWsEjs7FVehL9l7cXdJU6+EglU/8Vy+LPt9nViu0BHtRbc/+VbghiSAjG+OOWEf
         QOKxYGATvaTTHUjd3HgnJIj6IqVQZFeLUzxKGSgaI43PlkBoHKAsez7SupsuD5gfpB
         llAl33De2kdPoBenqZrMzcAxBzBseX4ySZFGxWmN025hhly0URimfScGOhGhcU+WFs
         drzhQA63w1mpw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 14/19] iio: prox: as3935: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:16 +0100
Message-Id: <20210501170121.512209-15-jic23@kernel.org>
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

Fixes: 37b1ba2c68cf ("iio: proximity: as3935: fix buffer stack trashing")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/as3935.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index edc4a35ae66d..1d5ace2bde44 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -59,7 +59,11 @@ struct as3935_state {
 	unsigned long noise_tripped;
 	u32 tune_cap;
 	u32 nflwdth_reg;
-	u8 buffer[16]; /* 8-bit data + 56-bit padding + 64-bit timestamp */
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u8 chan;
+		s64 timestamp __aligned(8);
+	} scan;
 	u8 buf[2] ____cacheline_aligned;
 };
 
@@ -225,8 +229,8 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
 	if (ret)
 		goto err_read;
 
-	st->buffer[0] = val & AS3935_DATA_MASK;
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
+	st->scan.chan = val & AS3935_DATA_MASK;
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
 					   iio_get_time_ns(indio_dev));
 err_read:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.31.1

