Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E83683E0
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 09:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfGOHHk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 03:07:40 -0400
Received: from first.geanix.com ([116.203.34.67]:53426 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfGOHHk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 03:07:40 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 163931837;
        Mon, 15 Jul 2019 07:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1563174436; bh=j4VtWezcu7jnb0yKDk5r3StBvebXCu01N1RbblwzIzA=;
        h=From:To:Cc:Subject:Date;
        b=OIs3gmu25uxIQG2l8Njs3FcpsKgjmB+L6dfoe6akzNcibFnO5M7DC730T5hg+1knm
         e8fXv2wO/qXbgCHmYfUmmLtuLZSO7nuqEfNQqX3SS8r3eaadkAny5VT5aRRI6DbvMu
         7WMJ9xlUD6OF7BEexVn+cdq/B6Urky12KRRBdgM9Pc8TGYJ3ZJueuZQkqzjryfo6cG
         cWYYBMrvppHa74A100ztd/+Aj2nEoZ5LqyLdiuFDcwhZpa9nl+VExJ94Jn0nAuTWHO
         0wAudLCTmkGQ9m/tgpTow7yMtnHP8YybElWdeZ5lvjYhTFZ/B9als6a/z9yrqehTcf
         +8fRE18DmJF3w==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH] iio: imu: st_lsm6dsx: flip irq return logic
Date:   Mon, 15 Jul 2019 09:07:15 +0200
Message-Id: <20190715070715.75976-1-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8945dcc0271d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

No need for using reverse logic in the irq return,
fix this by flip things around.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 38194f4d2b7e..1be1cec2ab23 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -670,7 +670,7 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 	count = hw->settings->fifo_ops.read_fifo(hw);
 	mutex_unlock(&hw->fifo_lock);
 
-	return !count ? IRQ_NONE : IRQ_HANDLED;
+	return count ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
-- 
2.22.0

