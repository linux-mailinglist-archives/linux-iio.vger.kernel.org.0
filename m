Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7281BD5597
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfJMKFA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 06:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfJMKFA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 06:05:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B7920659;
        Sun, 13 Oct 2019 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570961100;
        bh=ul0ea144YkbbpdGwY5NIxh6t/dhmfGD0euBqYGbBvJ4=;
        h=From:To:Cc:Subject:Date:From;
        b=RZJtPYcrPB9culf2NM3RJYEDD4ATzZhvefKR7dPvGRYeCMGiXcY7Gj5QESUMCpEAM
         6RE8nlTP+uJP3dFJPTQQ8+9KPcjWbuxiFZKGRNTqaBxFxvzEL7p1XI4MSZGqkEOPPf
         /47HYMdNTI8wv9sUKxae23Y9wHuTx4JL7s63F9ww=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: gyro: mpu3050: Explicity make a 'poison' value big endian
Date:   Sun, 13 Oct 2019 11:02:55 +0100
Message-Id: <20191013100255.1445528-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This clearly has no actual affect but it does show sparse and similar
static analysers that we are doing this intentionally.

CHECK   drivers/iio/gyro/mpu3050-core.c
drivers/iio/gyro/mpu3050-core.c:546:48: warning: incorrect type in assignment (different base types)
drivers/iio/gyro/mpu3050-core.c:546:48:    expected restricted __be16 <noident>
drivers/iio/gyro/mpu3050-core.c:546:48:    got int

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 80154bca18b6..8e908a749f95 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -543,7 +543,7 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 				toread = bytes_per_datum;
 				offset = 1;
 				/* Put in some dummy value */
-				fifo_values[0] = 0xAAAA;
+				fifo_values[0] = cpu_to_be16(0xAAAA);
 			}
 
 			ret = regmap_bulk_read(mpu3050->map,
-- 
2.23.0

