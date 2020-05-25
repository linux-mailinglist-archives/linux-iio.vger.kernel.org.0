Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB21E132E
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389222AbgEYRJD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbgEYRJD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:03 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D887320776;
        Mon, 25 May 2020 17:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426542;
        bh=8VyojAOydO4gMx0fVEeQ9THwMx6ke3f/D4KfGqm/9rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5VDneET9AZNpE1pHh++tKh2g859K30o+w4jagIi2B0IPKmgCxUZYZrECBhYkEFaJ
         Bj9GfjmX6FSX715HLWQL60FwwPimq3hzgM91v4PabOExxy5I7EMsUeSJDZRZj83UgI
         3NZHt9Fk429hHTlXJXPnpvP+tKgLmwxG5tpV54QA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/25] iio:light:max44000 Fix timestamp alignment and prevent data leak.
Date:   Mon, 25 May 2020 18:06:05 +0100
Message-Id: <20200525170628.503283-3-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525170628.503283-1-jic23@kernel.org>
References: <20200525170628.503283-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses a 16 byte array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv().
This data is allocated with kzalloc so no data can leak appart
from previous readings.

Fixes: 06ad7ea10e2b ("max44000: Initial triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/max44000.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index d6d8007ba430..d27b6170792d 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -75,6 +75,11 @@
 struct max44000_data {
 	struct mutex lock;
 	struct regmap *regmap;
+	/* Ensure naturally aligned timestamp */
+	struct {
+		u16 channels[2];
+		s64 ts;
+	} scan;
 };
 
 /* Default scale is set to the minimum of 0.03125 or 1 / (1 << 5) lux */
@@ -488,7 +493,6 @@ static irqreturn_t max44000_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max44000_data *data = iio_priv(indio_dev);
-	u16 buf[8]; /* 2x u16 + padding + 8 bytes timestamp */
 	int index = 0;
 	unsigned int regval;
 	int ret;
@@ -498,17 +502,17 @@ static irqreturn_t max44000_trigger_handler(int irq, void *p)
 		ret = max44000_read_alsval(data);
 		if (ret < 0)
 			goto out_unlock;
-		buf[index++] = ret;
+		data->scan.channels[index++] = ret;
 	}
 	if (test_bit(MAX44000_SCAN_INDEX_PRX, indio_dev->active_scan_mask)) {
 		ret = regmap_read(data->regmap, MAX44000_REG_PRX_DATA, &regval);
 		if (ret < 0)
 			goto out_unlock;
-		buf[index] = regval;
+		data->scan.channels[index] = regval;
 	}
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.26.2

