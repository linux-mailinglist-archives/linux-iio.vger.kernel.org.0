Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB9B36CA
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfIPJCf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:02:35 -0400
Received: from first.geanix.com ([116.203.34.67]:49640 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbfIPJCf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 05:02:35 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 80BE7EEE;
        Mon, 16 Sep 2019 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568624494; bh=JRBdpd/Dypggjjy7uQoFAAeWaTPVfMzS4k1lgYY2mv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PND4v/btTpyZF9XjwbC7tC9OsTLhZgVRkC9/9t0GIp7DvJMv7uyMCX8bXSV/BTMkK
         wNywtnD+0WTxtArIP2YXMSKyn90EtLRJPebOfc2diDL8fFakBaBw+nhTJ5DHEBxkTL
         BN8TeTUXh4yI7n09K3VSjJLsOyL0qasbHbQxdRkstICtVSopMJ0GK8b5DXUqHd+vsy
         DkL/RJOYum0kTY1kuSYE08f9NAxx98/lJehwmaxNTGlbnYh6r52B8DG7+BMj+rI/Wn
         SHFdP+0EJ5/KzDHeBLY2V7ucv2BhZuQcwuDnJZrY4XsvHGySeqNfE3w0XXLdWUGEvs
         WxELumktYp8cg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [RFC PATCH] iio: imu: st_lsm6dsx: filter motion events in driver
Date:   Mon, 16 Sep 2019 11:02:22 +0200
Message-Id: <20190916090222.597444-1-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190915143548.25383eb4@archlinux>
References: 
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
Hope it's okay to do this as an RFC. To get the most obvious stuff
reviewed before v9

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 938192212485..dd46209f94e8 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -362,6 +362,7 @@ struct st_lsm6dsx_hw {
 
 	u8 event_threshold;
 	bool enable_event;
+	u8 event_en_mask;
 	struct st_lsm6dsx_reg irq_routing;
 
 	u8 *buff;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 7596a6ed7d97..2d66e3758921 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1377,9 +1377,12 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
+	if (hw->event_en_mask & BIT(chan->channel2))
+		goto out;
+
 	/* do not enable events if they are already enabled */
 	if (state && hw->enable_event)
-		return 0;
+		goto out;
 
 	err = st_lsm6dsx_event_setup(hw, state);
 	if (err < 0)
@@ -1391,6 +1394,12 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 
 	hw->enable_event = state;
 
+out:
+	if (state)
+		hw->event_en_mask |= BIT(chan->channel2);
+	else
+		hw->event_en_mask &= ~BIT(chan->channel2);
+
 	return 0;
 }
 
@@ -1746,7 +1755,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
 {
 	s64 timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 
-	if (data & hw->settings->event_settings.wakeup_src_z_mask)
+	if (data & hw->settings->event_settings.wakeup_src_z_mask &&
+	    hw->event_en_mask & BIT(IIO_MOD_Z))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1755,7 +1765,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if (data & hw->settings->event_settings.wakeup_src_y_mask)
+	if (data & hw->settings->event_settings.wakeup_src_y_mask &&
+	    hw->event_en_mask & BIT(IIO_MOD_Y))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1764,7 +1775,8 @@ void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if (data & hw->settings->event_settings.wakeup_src_x_mask)
+	if (data & hw->settings->event_settings.wakeup_src_x_mask &&
+	    hw->event_en_mask & BIT(IIO_MOD_X))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-- 
2.23.0

