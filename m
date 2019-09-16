Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4AB3BF0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbfIPN4m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 09:56:42 -0400
Received: from first.geanix.com ([116.203.34.67]:36396 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387994AbfIPN4l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 09:56:41 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 88F8E65766;
        Mon, 16 Sep 2019 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568642139; bh=4DXx1B3VsIcL5HGYgSRRsPZxTB4wEWy3u29dSGPNdNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=S1OHbG0ppLKohEwmoY4yrmo/M/imIIfcp1qVgK79pqOZW4OR+S3k09Po7f9qLpdOZ
         +6Xssqz1/6UsCzBy92NG7UvrjaCZ6RdosllIH20cKhStIeiOwqI1zmdAaHv7eIr/vW
         qBeNgh//6t1oIwiwc7tZXO/L49kV/MUg4X+Y9XvQMmi+gfiPiDidkfeZ4Ka4IsrSNH
         qyUSan89YOd4EmTVsayxH7tfHqngTfWWpubPsMuIKM05daXUE+yLhsdzbV2IruyP3G
         kpLBAUhMLP6rBf3gczhVAZEVmR0FvdGImPAO4X8/S3oF4NlK3UFc9Jw6LVVtNn/WMx
         OJbluINRWqmmA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v10 5/5] iio: imu: st_lsm6dsx: add motion report function and call from interrupt
Date:   Mon, 16 Sep 2019 15:56:30 +0200
Message-Id: <20190916135630.2211714-5-sean@geanix.com>
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

Report iio motion events to iio subsystem and filter motion events.
Wakeup will still be on all channels as it's not possible to do the filtering
in hw.

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

Changes since v8:
 * None

Changes since v9:
 * Merged with "iio: imu: st_lsm6dsx: filter motion events in driver"

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 97 +++++++++++++++++++-
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 6b0ba48394eb..fd02d0e184f3 100644
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
index 6b03c50f4732..f4f71cf4187a 100644
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
@@ -1334,7 +1360,7 @@ static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	return hw->enable_event;
+	return !!(hw->enable_event & BIT(chan->channel2));
 }
 
 static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
@@ -1345,13 +1371,28 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	u8 enable_event;
 	int err = 0;
 
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	/* do not enable events if they are already enabled */
-	if (state && hw->enable_event)
+	if (state) {
+		enable_event = hw->enable_event | BIT(chan->channel2);
+
+		/* do not enable events if they are already enabled */
+		if (hw->enable_event)
+			goto out;
+	} else {
+		enable_event = hw->enable_event & ~BIT(chan->channel2);
+
+		/* only turn off sensor if no events is enabled */
+		if (enable_event)
+			goto out;
+	}
+
+	/* stop here if no changes have been made */
+	if (hw->enable_event == enable_event)
 		return 0;
 
 	err = st_lsm6dsx_event_setup(hw, state);
@@ -1362,7 +1403,8 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (err < 0)
 		return err;
 
-	hw->enable_event = state;
+out:
+	hw->enable_event = enable_event;
 
 	return 0;
 }
@@ -1715,10 +1757,57 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	return iio_dev;
 }
 
+void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
+{
+	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+
+	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
+	    (hw->enable_event & BIT(IIO_MOD_Z)))
+		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+						  timestamp);
+
+	if ((data & hw->settings->event_settings.wakeup_src_y_mask) &&
+	    (hw->enable_event & BIT(IIO_MOD_Y)))
+		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_Y,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+						  timestamp);
+
+	if ((data & hw->settings->event_settings.wakeup_src_x_mask) &&
+	    (hw->enable_event & BIT(IIO_MOD_X)))
+		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+						  0,
+						  IIO_MOD_X,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+						  timestamp);
+}
+
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
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

