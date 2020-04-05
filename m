Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7706919ED45
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgDESGF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 14:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgDESGE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 14:06:04 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D4620678;
        Sun,  5 Apr 2020 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586109964;
        bh=ID/jqjHYdnnsesPLM7ENzlshpNNWM4Io+glhCXAM+pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKXifLsnV1Xprj11ODEeEEdTHgWzT2QgHaWGmmesZgVjdw7ZzAbDy6nmK3dkOWX8d
         HvpOyYr+VL7tz1K29VaUhUDdSDGYkWThynJAMyGa+5X/8jDv7Z+VDzxI/huPoKgPKp
         QGd7Zk2TFAxhhei86ezw6g5BlPw9w8BXlHsvphL4=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/6] iio:light:ltr501: Drop unnecessary cast of parameter in regmap_bulk_read
Date:   Sun,  5 Apr 2020 19:03:21 +0100
Message-Id: <20200405180321.1737310-7-jic23@kernel.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405180321.1737310-1-jic23@kernel.org>
References: <20200405180321.1737310-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This only occurs once in the driver and isn't needed in this case either,
so drop it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 71f99d2a22c1..0626927251bb 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1263,7 +1263,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 
 	if (mask & LTR501_STATUS_ALS_RDY) {
 		ret = regmap_bulk_read(data->regmap, LTR501_ALS_DATA1,
-				       (u8 *)als_buf, sizeof(als_buf));
+				       als_buf, sizeof(als_buf));
 		if (ret < 0)
 			return ret;
 		if (test_bit(0, indio_dev->active_scan_mask))
-- 
2.26.0

