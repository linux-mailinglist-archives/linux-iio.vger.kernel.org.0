Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E098FA7F1D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2019 11:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfIDJRt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Sep 2019 05:17:49 -0400
Received: from first.geanix.com ([116.203.34.67]:60394 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfIDJRt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Sep 2019 05:17:49 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id E851062F96;
        Wed,  4 Sep 2019 09:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567588661; bh=8hBhcSkd5c2hFJV54eOlvBJns2icJgkGtUjcszz+w+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=S49FXs9OIwC3xvdOqvB758f8DU0qZYHia2GpXksqZsJZ/703/rVN5tVacDCHJ3tk2
         o7J3pk76yIpQvCDNJYZxD3L5tb58IgKYul8fZKln2aeOQ5xmEDUF5N2m29Z10buwxx
         0MKCmS8kxZ4u/cy2cjXIqxbRv2sQrNlbizZPNQFM59uqa/1IccMi7g/oIr7WwHAd4E
         7WYBd8uSrGVg0aQNCgz0QWcPmVOyUnO8BfM47RVdb1QbC7o4D97qp1Kn63cxkXx7D+
         cFds0hDumW8AsOgmnJreSMjnLEfLzRAD9f3f0oSOZjffWUfzbixhYBeswdQqD47EZV
         adgqzcKhriE8A==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v3 5/6] iio: imu: st_lsm6dsx: add motion report function and call from interrupt
Date:   Wed,  4 Sep 2019 11:17:31 +0200
Message-Id: <20190904091732.112281-5-sean@geanix.com>
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

Report iio motion events to iio subsystem

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v1:
 * none

Changes since v2:
 * none

Should we include these new defines in device settings?

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 513506caa460..2114c3c78888 100644
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
@@ -72,6 +73,12 @@
 #define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
 #define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
 
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR		0x1B
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK	BIT(0)
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK	BIT(1)
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK	BIT(2)
+#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK	BIT(4)
+
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
@@ -1611,6 +1618,40 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	return iio_dev;
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
+
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 {
 	return IRQ_WAKE_THREAD;
@@ -1620,7 +1661,19 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
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
2.23.0

