Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F237080B
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEARDz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhEARDx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7922460FEB;
        Sat,  1 May 2021 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888583;
        bh=WNasbTZXsu/8eJqrzYPHut0vsXilpL75Rl/IMxcLfIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gq93P7WMH/P43Kf+Uw3jjDz82HD8wyt64ImGwSfGovQIi+Xxp8KJdWgJQaQOuIFHq
         +1QbHoMCAmguFUZKZSxHnDLrI7y2Bp3x2mnkgh/wPvpSS3L0Q9/iQ0a2UMW4Gicpd6
         5D8+yc8xBFbBlFkP7iJoW5LJfe3nzvSmbet/boHt164+VMqi+1rttFU1T2xlOM4BFZ
         9xj1fXgq+gAGMDiODJelR0wddsuDrmaLuBy7g7yRVM50nyjEtY0V+gp9iGe0yZRnKL
         XpuaFi89Bwtvn1o2JQIw/gwRGUHLxs6ZxadWBbkHSpUzM9fzg71xU/7+gOKnluU6gb
         0QoA21b11LthA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 08/19] iio: adc: ti-ads1015: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:10 +0100
Message-Id: <20210501170121.512209-9-jic23@kernel.org>
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

Fixes: ecc24e72f437 ("iio: adc: Add TI ADS1015 ADC driver support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-ads1015.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9fef39bcf997..5b828428be77 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -395,10 +395,14 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ads1015_data *data = iio_priv(indio_dev);
-	s16 buf[8]; /* 1x s16 ADC val + 3x s16 padding +  4x s16 timestamp */
+	/* Ensure natural alignment of timestamp */
+	struct {
+		s16 chan;
+		s64 timestamp __aligned(8);
+	} scan;
 	int chan, ret, res;
 
-	memset(buf, 0, sizeof(buf));
+	memset(&scan, 0, sizeof(scan));
 
 	mutex_lock(&data->lock);
 	chan = find_first_bit(indio_dev->active_scan_mask,
@@ -409,10 +413,10 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
 		goto err;
 	}
 
-	buf[0] = res;
+	scan.chan = res;
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 
 err:
-- 
2.31.1

