Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400F6B1A74
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 11:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbfIMJH2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 05:07:28 -0400
Received: from first.geanix.com ([116.203.34.67]:49600 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387819AbfIMJH2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Sep 2019 05:07:28 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id CCC67650D8;
        Fri, 13 Sep 2019 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568365601; bh=r6yVAxTUTN+vHLjY4d7Kpt31iINSpu9L3J2wNdMctKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Xnz64SnJSnblB6TntNDxGZwFvPqaiA0c3FftktSPeMqog2ulSH11VL0ykuIVmk5g1
         MtCveEk6LPS6oQ4bUGEWNzVju2Uc8fsInLefKBKP4ZDO21G9BoWkbrmoigZr4V1Ldm
         TqSnX7whbXB6dj29NBXyZDUrV6dLMIQjRulM5Y8x2qDuS+0B84Iv3UTQpyTPBd0q45
         8Mo5dgyHHUgfbInq6YwbS9Fy/ysC6LbzYCt3ax8Qx+q9YU61HIMcFU10L2CTKkcWr/
         OZqYJIdLh96oXcc6IZKMaPuKQ2i5A2gImQQLj9sr0ujEz3lw43P+VDQghu/Oq0oYya
         tYpnkVHmPJ9Cw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v8 5/5] iio: imu: st_lsm6dsx: add motion report function and call from interrupt
Date:   Fri, 13 Sep 2019 11:07:08 +0200
Message-Id: <20190913090708.1442057-6-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913090708.1442057-1-sean@geanix.com>
References: <20190913090708.1442057-1-sean@geanix.com>
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

Report iio motion events to iio subsystem

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v4:
 * Updated bitmask as pr Jonathans comments

Changes since v5:
 * None

Changes since v6:
 * None

Changes since v7:
 * None

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 449c2798f7ed..7c50fac7b85c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -186,6 +186,11 @@ struct st_lsm6dsx_shub_settings {
 struct st_lsm6dsx_event_settings {
 	struct st_lsm6dsx_reg enable_reg;
 	struct st_lsm6dsx_reg wakeup_reg;
+	u8 wakeup_src_reg;
+	u8 wakeup_src_status_mask;
+	u8 wakeup_src_z_mask;
+	u8 wakeup_src_y_mask;
+	u8 wakeup_src_x_mask;
 };
 
 enum st_lsm6dsx_ext_sensor_id {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 80a94335175f..66700c20920d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -48,6 +48,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
@@ -287,6 +288,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5B,
 				.mask = GENMASK(5, 0),
 			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -412,6 +418,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5B,
 				.mask = GENMASK(5, 0),
 			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -550,6 +561,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5B,
 				.mask = GENMASK(5, 0),
 			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -816,6 +832,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5B,
 				.mask = GENMASK(5, 0),
 			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -970,6 +991,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5B,
 				.mask = GENMASK(5, 0),
 			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
 		}
 	},
 };
@@ -1715,6 +1741,38 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	return iio_dev;
 }
 
+void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
+{
+	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+
+	if (data & hw->settings->event_settings.wakeup_src_z_mask)
+		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+						  timestamp);
+
+	if (data & hw->settings->event_settings.wakeup_src_x_mask)
+		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_Y,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+						  timestamp);
+
+	if (data & hw->settings->event_settings.wakeup_src_x_mask)
+		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_X,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+						  timestamp);
+}
+
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 {
 	return IRQ_WAKE_THREAD;
@@ -1724,6 +1782,18 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
 	int count;
+	int data, err;
+
+	if (hw->enable_event) {
+		err = regmap_read(hw->regmap,
+				  hw->settings->event_settings.wakeup_src_reg,
+				  &data);
+		if (err < 0)
+			return IRQ_NONE;
+
+		if (data & hw->settings->event_settings.wakeup_src_status_mask)
+			st_lsm6dsx_report_motion_event(hw, data);
+	}
 
 	mutex_lock(&hw->fifo_lock);
 	count = hw->settings->fifo_ops.read_fifo(hw);
-- 
2.23.0

