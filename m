Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C955B3A65
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 14:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbfIPMfK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 08:35:10 -0400
Received: from first.geanix.com ([116.203.34.67]:58052 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfIPMfK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 08:35:10 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 99C1165755;
        Mon, 16 Sep 2019 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568637249; bh=mgLUqQmU29q5GX+cNaf2FP1401LJ+U6wiAK/KJ3/v48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QkeVl/aFeE5KcAGO29BHSJJd1ItYTUuJzHbBlb1ofkFZ+/Z8Y9JFwZdOSYj0C+54m
         7cnoH1NmJh9CAVqQim4KaEGKKQo42M/3H4HxTzmOZHaPvTX4I7pk7PqUBOHjAaajjn
         BEb8woOO1mKxuFksoC3eilWsUC/7xYEbJTsgVxGpt0bV0QbJ+qq32Lbz+/QASAqy70
         v+YflKLW17BfX/C2D+OQ/kZXiqvGN8cQ1w7caGcUkw23qg5e/gPqRglnVKxQ9TV62F
         QEClqJQ0b/Bm07oRu8X9FYDdgll1wQPMgjVFAEMw2jAyYQ7ZCyx2L/2lGa4ZuzS2ll
         yYwfCSzCu/thg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v9 6/6] iio: imu: st_lsm6dsx: filter motion events in driver
Date:   Mon, 16 Sep 2019 14:34:56 +0200
Message-Id: <20190916123456.1742253-6-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916123456.1742253-1-sean@geanix.com>
References: <20190916123456.1742253-1-sean@geanix.com>
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

Do not report non enabled motion events.
Wakeup will still be on all channels as it's not possible to do the
filtering in hw.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 38 +++++++++++++++-----
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 0a782af9445b..fd02d0e184f3 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -360,7 +360,7 @@ struct st_lsm6dsx_hw {
 	u8 sip;
 
 	u8 event_threshold;
-	bool enable_event;
+	u8 enable_event;
 	struct st_lsm6dsx_reg irq_routing;
 
 	u8 *buff;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 6b88d93dca2a..92fee4555dd5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1202,7 +1202,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	if (!hw->enable_event)
+	if (0 == hw->enable_event)
 		st_lsm6dsx_sensor_set_enable(sensor, false);
 
 	*val = (s16)le16_to_cpu(data);
@@ -1360,7 +1360,10 @@ static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	return hw->enable_event;
+	if (hw->enable_event & BIT(chan->channel2))
+		return 1;
+
+	return 0;
 }
 
 static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
@@ -1371,13 +1374,28 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
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
@@ -1388,7 +1406,8 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (err < 0)
 		return err;
 
-	hw->enable_event = state;
+out:
+	hw->enable_event = enable_event;
 
 	return 0;
 }
@@ -1745,7 +1764,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
 {
 	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 
-	if (data & hw->settings->event_settings.wakeup_src_z_mask)
+	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
+	    (hw->enable_event & BIT(IIO_MOD_Z)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1754,7 +1774,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if (data & hw->settings->event_settings.wakeup_src_y_mask)
+	if ((data & hw->settings->event_settings.wakeup_src_y_mask) &&
+	    (hw->enable_event & BIT(IIO_MOD_Y)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1763,7 +1784,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if (data & hw->settings->event_settings.wakeup_src_x_mask)
+	if ((data & hw->settings->event_settings.wakeup_src_x_mask) &&
+	    (hw->enable_event & BIT(IIO_MOD_X)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-- 
2.23.0

