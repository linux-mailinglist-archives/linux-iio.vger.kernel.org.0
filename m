Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5334A7F1B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2019 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfIDJRs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Sep 2019 05:17:48 -0400
Received: from first.geanix.com ([116.203.34.67]:60386 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfIDJRr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Sep 2019 05:17:47 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id DA1DB62F97;
        Wed,  4 Sep 2019 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567588660; bh=0a00ra6GIFWzzt2I6ONtJW3Wb0NHxpxoV3quQxcq1RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IIWO6MNyRPOCbiEkEwKOBf9cV03kePMqUwHImKIQiE/kX7j/qFuASMDCOrmsJa0lc
         7czSJ5Pl2VfLm8kQCpFULSFe0xQF+JmLz83HgQO8pnAK6y8wGO17Yy8aa+xik4RpK6
         wMq7tiKVv0+YHj4mMq4j35skKb4gK5PzXvpJvLbA0oTJZ4pBTQJa9ZJ+p3MikZx/YE
         q/YWXVaT9lgmIARxGyA8sjXAn4xT9f4r7wpvRHfO3xF5XnVVvgdZghyG/cvrKTvxx3
         /DudieoBgpOvGlprgo8Qtth3LSNvV+Xho/nWTbjDN4atIpNjSpALcpNGsRPrHdknt+
         o9S4F1zPRKKcA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v3 4/6] iio: imu: st_lsm6dsx: always enter interrupt thread
Date:   Wed,  4 Sep 2019 11:17:30 +0200
Message-Id: <20190904091732.112281-4-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904091732.112281-1-sean@geanix.com>
References: <20190904091732.112281-1-sean@geanix.com>
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
Changes since v1:
 * None

Changes since v2:
 * None

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index bb72800bf99b..513506caa460 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1613,19 +1613,19 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 
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
-	count = hw->settings->fifo_ops.read_fifo(hw);
-	mutex_unlock(&hw->fifo_lock);
+	if (hw->sip > 0) {
+		mutex_lock(&hw->fifo_lock);
+		count = st_lsm6dsx_read_fifo(hw);
+		mutex_unlock(&hw->fifo_lock);
+	}
 
 	return count ? IRQ_HANDLED : IRQ_NONE;
 }
-- 
2.23.0

