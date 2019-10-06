Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB72CD209
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfJFNWX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:23 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3837C20684;
        Sun,  6 Oct 2019 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368142;
        bh=sGBTyWy/S9tZ1AyR58GqQiuHQqD7gC5cLUeyfanM5tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SB1tHp8GbhLtNXycY3NCLFrKLVY+J8mdbjAtKbaNYRpwoPvQZmK6Aw6C6d9iZ4ub1
         WJ9aTlb4dyLU4eMjW0S3Cfb2kGXEwW/MWruzFmdQW+6q9mBL/maPe3pFvSZ0R71RUv
         hqDSnTzbA0Bijk0eBqaZUAd3xkEdPG0fgAgZ3398=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 01/13] iio: imu: st_lsm6dsx: use st_lsm6dsx_read_locked in st_lsm6dsx_report_motion_event
Date:   Sun,  6 Oct 2019 15:21:55 +0200
Message-Id: <a837aedc32b5726e09b14ae6a883655576184869.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rely on st_lsm6dsx_read_locked in st_lsm6dsx_report_motion_event since
it can run concurrently with sensor hub configuration. Move event
related code in st_lsm6dsx_report_motion_event

Fixes: 1aabad1fb5e9 ("iio: imu: st_lsm6dsx: add motion report function and call from interrupt")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 34 ++++++++++++--------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 8a813ddba19c..df270905f21d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1757,10 +1757,23 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	return iio_dev;
 }
 
-static void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
+static bool
+st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 {
-	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+	const struct st_lsm6dsx_event_settings *event_settings;
+	int err, data;
+	s64 timestamp;
 
+	if (!hw->enable_event)
+		return false;
+
+	event_settings = &hw->settings->event_settings;
+	err = st_lsm6dsx_read_locked(hw, event_settings->wakeup_src_reg,
+				     &data, sizeof(data));
+	if (err < 0)
+		return false;
+
+	timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_Z)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
@@ -1790,30 +1803,23 @@ static void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
+
+	return data & event_settings->wakeup_src_status_mask;
 }
 
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
+	bool event;
 	int count;
-	int data, err;
-
-	if (hw->enable_event) {
-		err = regmap_read(hw->regmap,
-				  hw->settings->event_settings.wakeup_src_reg,
-				  &data);
-		if (err < 0)
-			return IRQ_NONE;
 
-		if (data & hw->settings->event_settings.wakeup_src_status_mask)
-			st_lsm6dsx_report_motion_event(hw, data);
-	}
+	event = st_lsm6dsx_report_motion_event(hw);
 
 	mutex_lock(&hw->fifo_lock);
 	count = hw->settings->fifo_ops.read_fifo(hw);
 	mutex_unlock(&hw->fifo_lock);
 
-	return count ? IRQ_HANDLED : IRQ_NONE;
+	return count || event ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
-- 
2.21.0

