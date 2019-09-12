Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49E0B092A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfILHG2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 03:06:28 -0400
Received: from first.geanix.com ([116.203.34.67]:53086 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfILHG1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Sep 2019 03:06:27 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 157FC64D9F;
        Thu, 12 Sep 2019 07:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568271945; bh=pLlBO35Sn5UbqZ1HN+8wwUU118j9Qzk2WKZWC8WzV2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hBbQy6tabMjpGrXiYrBrWycMVHywG7a72wtor/jlQX2mGGfs70ESRH67IKtqcn8W3
         0fclwOoevcGofLX1JWwEuf2CBluaVKvBCpofiBke1hJs1YoHm89T4cHmRTaY0+UT41
         9OKIRM5lHk+Xd9c73TYDDtbxy4rcGCWPiHclap/BhC9pNE50gCsGFm5FOvDcG6+65L
         4AylqVzjy+aZe8T8d5abBFXdF7u1aWbjH3qGtQLvYSqolzlGKrJYs4T4m1tvVelYQm
         oCoguDwocKET/mc10LKhrTDhUeQRobvHObUr0z+h6HSj0O5Fd5Rc6AHeyzrCMrNJQj
         17YGQYzICGDZw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v7 5/5] iio: imu: st_lsm6dsx: add motion report function and call from interrupt
Date:   Thu, 12 Sep 2019 09:06:14 +0200
Message-Id: <20190912070614.1144169-6-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912070614.1144169-1-sean@geanix.com>
References: <20190912070614.1144169-1-sean@geanix.com>
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
index c0568ab69a77..c6d2006d722c 100644
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

