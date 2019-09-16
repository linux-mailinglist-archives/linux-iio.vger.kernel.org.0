Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB94B3BEF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbfIPN4k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 09:56:40 -0400
Received: from first.geanix.com ([116.203.34.67]:36404 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388189AbfIPN4j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 09:56:39 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 618AF65749;
        Mon, 16 Sep 2019 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568642138; bh=eC038n6360joDRmxDuCFPLlQaMDh0L2Ih0gpEIy294w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YoNZciEzqmcNU59S57i8TtIRwan2O85injpLGNsBaTapdl0WJwKCp0iyzGVBBh068
         N5GlSw6tuhMvtI4x1420otCcSn4GVvKT6dncRSbDMW4m8YzSyAUle08KKDxr+KshAF
         o5Wl6Db+8v2L2NzZVNevViYY7lFH68YbEx3Mjz89e654DEwXr2DfTJh0oAoSEe8o8H
         hZ7L2WSiy33tt3hlcwcrZJukGHcMFkJjEuVHscU3HXlljomAX9nlVJeP/KRsoJL0OF
         DebwJkgspmyTc4TGQg+XJutYZZxAiP6d8+M7jFAUAG47CNR5VFdb9K6efcE2rdvDE5
         p9buybMRSSbDw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v10 4/5] iio: imu: st_lsm6dsx: always enter interrupt thread
Date:   Mon, 16 Sep 2019 15:56:29 +0200
Message-Id: <20190916135630.2211714-4-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916135630.2211714-1-sean@geanix.com>
References: <20190916135630.2211714-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=4.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The interrupt source can come from multiple sources,
fifo and wake interrupts.
Enter interrupt thread to check which interrupt that has fired.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v8:
 * Remove st_lsm6dsx_handler_irq function to enter interrupt thread
   at every interrupt

Changes since v9:
 * None

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a7f12cf57f11..6b03c50f4732 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1715,13 +1715,6 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	return iio_dev;
 }
 
-static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
-{
-	struct st_lsm6dsx_hw *hw = private;
-
-	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
-}
-
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
@@ -1779,7 +1772,7 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 	}
 
 	err = devm_request_threaded_irq(hw->dev, hw->irq,
-					st_lsm6dsx_handler_irq,
+					NULL,
 					st_lsm6dsx_handler_thread,
 					irq_type | IRQF_ONESHOT,
 					"lsm6dsx", hw);
-- 
2.23.0

