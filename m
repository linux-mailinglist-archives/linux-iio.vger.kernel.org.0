Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9A68504
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 10:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfGOIP2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 04:15:28 -0400
Received: from first.geanix.com ([116.203.34.67]:55308 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729383AbfGOIP2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 04:15:28 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id BD99543620;
        Mon, 15 Jul 2019 08:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1563178503; bh=7aDigxqC+X0yPPBGZM/U6xh5Q966jFFnYHQLlR+CQTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fj8FAGLWQOy/O6hnu2BLSSbReEfmhvJu6zHxeDoq7HRrccI5LWijQgw1NWNYvO04j
         dsGfNNB28B9WVI4G1pW+m/yKixRCAlNYhRI3vKAvDPQuboeKeDSENVbY7rmwfpWBvz
         ddj5bfXcoJ+I0qndcJp08p/s88fwya+ZCrPUUVsG++6/ro7lVtVvQvM/vc8CaGXAFC
         tWLsKyVwGw8v0PffUzzV3zTxk+ZFO2e6ct3EZ7QRtspk9GGwkS2jtDCx1VhybpZKAO
         V8J3AkFcn0GXSm2/ITaFPUN24Ild0f95s70ljt+6QL0kKifoLE7V4oXPolEv9SalZ9
         5at3dSV5c0JUA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH v2 5/6] iio: imu: st_lsm6dsx: always enter interrupt thread
Date:   Mon, 15 Jul 2019 10:15:13 +0200
Message-Id: <20190715081514.81129-5-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715081514.81129-1-sean@geanix.com>
References: <20190715081514.81129-1-sean@geanix.com>
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

The interrupt source can come from multiple sources,
fifo and wake interrupts.
Enter interrupt thread to check which interrupt that has fired.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

Changes since v1:
 * None

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index fc450eeb9870..0503abab6efc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1215,19 +1215,19 @@ int st_lsm6dsx_event_setup(int id, struct st_lsm6dsx_hw *hw)
 
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 {
-	struct st_lsm6dsx_hw *hw = private;
-
-	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
+	return IRQ_WAKE_THREAD;
 }
 
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
-	int count;
+	int count = 0;
 
-	mutex_lock(&hw->fifo_lock);
-	count = st_lsm6dsx_read_fifo(hw);
-	mutex_unlock(&hw->fifo_lock);
+	if (hw->sip > 0) {
+		mutex_lock(&hw->fifo_lock);
+		count = st_lsm6dsx_read_fifo(hw);
+		mutex_unlock(&hw->fifo_lock);
+	}
 
 	return !count ? IRQ_NONE : IRQ_HANDLED;
 }
-- 
2.22.0

