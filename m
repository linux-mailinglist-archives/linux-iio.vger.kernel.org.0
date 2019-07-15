Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2673E68501
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 10:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfGOIP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 04:15:29 -0400
Received: from first.geanix.com ([116.203.34.67]:55302 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbfGOIP3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 04:15:29 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id A85DD43622;
        Mon, 15 Jul 2019 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1563178504; bh=lVqSq+le5R0lOTxxKv0TS3Uo4mRe6V2OIsKZqy7jQkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XRf5h5lrptn8I5raX6Iy88pwl8fEFob3b+VCDufnHsXdWnFLgzfrJTzVhHKDKQbJO
         j8OmkZPvDwecRMQOblpzJdVeZSCEEWDqpSl+5VmpxfEcqlc5wmL0u3Rj35GhIfSH+w
         i//NnklCokGl9C+cfYvXOFuVoQQi7N3srzJApUXsIa+JEIdbEfxMMThtucmLhAEaO4
         hbhlqW3rfUjAtHfsiz3UECm/dWCxM4qN+EzRmF7yHossIiOdstp3vezVCdU4fS9FU7
         MGPZnSLMP0vWfqgwbDaQQaJsVzxCYszw7sq+P4mYjtUHbANnIqNbuqOz85T/QihAHQ
         Z+ufO8J2ueI8A==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH v2 6/6] iio: imu: st_lsm6dsx: add motion report function and call from interrupt
Date:   Mon, 15 Jul 2019 10:15:14 +0200
Message-Id: <20190715081514.81129-6-sean@geanix.com>
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

Report iio motion events to iio subsystem

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

Changes since v1:
 * none

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 0503abab6efc..acc653d5e00e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -39,6 +39,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
@@ -76,6 +77,12 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR		0x1B
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK	BIT(0)
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK	BIT(1)
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK	BIT(2)
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK	BIT(3)
+
 #define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
 #define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
 
@@ -1212,6 +1219,39 @@ int st_lsm6dsx_event_setup(int id, struct st_lsm6dsx_hw *hw)
 
 	return err;
 }
+int st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
+{
+	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+
+	if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK)
+		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+						  timestamp);
+
+	if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK)
+		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_Y,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+						  timestamp);
+
+	if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK)
+		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_X,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+						  timestamp);
+
+	return 0;
+}
 
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 {
@@ -1222,7 +1262,19 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
 	int count = 0;
+	int data, err;
+
+	if (hw->enable_event) {
+		err = regmap_read(hw->regmap,
+				  ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR, &data);
+		if (err < 0)
+			goto try_fifo;
+
+		if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK)
+			st_lsm6dsx_report_motion_event(hw, data);
+	}
 
+try_fifo:
 	if (hw->sip > 0) {
 		mutex_lock(&hw->fifo_lock);
 		count = st_lsm6dsx_read_fifo(hw);
-- 
2.22.0

