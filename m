Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE284A14C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 14:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFRM76 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 08:59:58 -0400
Received: from first.geanix.com ([116.203.34.67]:37332 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRM76 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 08:59:58 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 55362DC4;
        Tue, 18 Jun 2019 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560862790; bh=HC76rtz1BqlQle1pi1tUszth6UkoHp3UTu+zJSmQ7ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cFrOpWsdh0rl6Dk6pjCQnA2rdASXIEv2pHqC5jKt3C1DVq0iyj9P8/cxmOJonwgAB
         fFXn6IoeqFTW6qDNTVpYActSEll0nlfi6z6l6RPRmiZJZQTOmYyr7FvDh/0gtw8HU4
         llmrnb+QFu4/CY1Y8YoPUUV3tEwsfcUmIFwsKAyim+0MEn4xqlCIzKU8mg8lk1x2Wb
         my+bt06CHBhvXEsplY3KijOGtTKQEK4UFCZAqGz4VgqdifbLGsye1VXMY6T4o2cpsS
         0O/DRxRCyLkPqwdh1CzO0iTJUxo2+y9hd5WPBhDUtZ/KIn7BAuzGaMgrOQn2tk3V3r
         T4CrldgHEg4AA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH 4/5] iio: imu: st_lsm6dsx: always enter interrupt thread
Date:   Tue, 18 Jun 2019 14:59:38 +0200
Message-Id: <20190618125939.105903-5-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618125939.105903-1-sean@geanix.com>
References: <20190618125939.105903-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The interrupt source can come from multiple sources, fifo and wake interrupts.
Enter interrupt thread to check which interrupt that has fired.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 59a34894e495..76aec5024d83 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -78,6 +78,12 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR		0x1B
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK	BIT(0)
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK	BIT(1)
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK	BIT(2)
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK	BIT(4)
+
 #define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
 #define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
 #define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
@@ -946,19 +952,29 @@ int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw)
 
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
+	int data, err;
+
+	if (hw->enable_event) {
+		err = regmap_read(hw->regmap,
+				  ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR, &data);
+		if (err < 0)
+			goto try_fifo;
+
+	}
 
-	mutex_lock(&hw->fifo_lock);
-	count = st_lsm6dsx_read_fifo(hw);
-	mutex_unlock(&hw->fifo_lock);
+try_fifo:
+	if (hw->sip > 0) {
+		mutex_lock(&hw->fifo_lock);
+		count = st_lsm6dsx_read_fifo(hw);
+		mutex_unlock(&hw->fifo_lock);
+	}
 
 	return !count ? IRQ_NONE : IRQ_HANDLED;
 }
-- 
2.22.0

