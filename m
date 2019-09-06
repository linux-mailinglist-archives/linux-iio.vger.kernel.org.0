Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881DDAB7F9
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 14:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391967AbfIFMR3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 08:17:29 -0400
Received: from first.geanix.com ([116.203.34.67]:41590 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391966AbfIFMR3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Sep 2019 08:17:29 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 6EDBF6394C;
        Fri,  6 Sep 2019 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567772231; bh=FHr7KRgGYTeybsvF5DFtbV+yCCHQ8iAdddDfUKoHIfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mo57x2z8k/ewMBprc/188lAY4hZuEgV+ff9m8BUdTYCYii7R0Xn1XsQye6+Aao1/G
         WuSXmd+soODqsv22gD8cmlUJDe8RFhiV/746ksD7lkS2RKkwckktWhQ3aeqkzSWtNR
         ++mmImdwIiPC1WSuNan/TpD2+V8ks7o3V6DcAp0Y4WngPfFsTS03gDSsaHPe9fjNBv
         wRP+Ep1Zj6C/FZISlepbs7+kbYVHt2i/qh+gIhDZOnFQ7EHrfhWjXiBNBBa6AqdVwx
         j3Td8JavbI9SwQ1N+K2wJPU6msuVgJ0Sr6K5gDOjF2a8MFW0dLscYrgHYW5bSUCbm8
         QcRW2NiSUTrbw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v4 5/6] iio: imu: st_lsm6dsx: add motion report function and call from interrupt
Date:   Fri,  6 Sep 2019 14:17:15 +0200
Message-Id: <20190906121716.66194-5-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906121716.66194-1-sean@geanix.com>
References: <20190906121716.66194-1-sean@geanix.com>
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
Changes since v3:
 * added wakeup_src_reg and masks to device settings

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 51 ++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index d04473861fba..015b837f366f 100644
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
index ce467308eadd..470821b54933 100644
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
@@ -520,6 +521,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5B,
 				.mask = GENMASK(5, 0),
 			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(4),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -1612,6 +1618,40 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
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
+
+	return;
+}
+
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 {
 	return IRQ_WAKE_THREAD;
@@ -1621,6 +1661,17 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
 	int count;
+	int data, err;
+
+	if (hw->enable_event) {
+		err = regmap_read(hw->regmap,
+				  hw->settings->event_settings.wakeup_src_reg, &data);
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

