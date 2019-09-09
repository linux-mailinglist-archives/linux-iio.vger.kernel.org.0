Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0A0AD626
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390100AbfIIJ4e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 05:56:34 -0400
Received: from first.geanix.com ([116.203.34.67]:49810 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390099AbfIIJ4e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 05:56:34 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 854FF2D7;
        Mon,  9 Sep 2019 09:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568022964; bh=R5cG56f0q+XDCR3ctVXu3+cAUW1m2hVyyIMFOwh0VCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bze3XWQv/ueac37Jz7A8QJzWHY5wVqBFn17O5Fs2NluSeeHT5mBmSYzYeMVnMHhvZ
         EXxa9Z47JooQs9AvbsIipo8I5so2gDzEq8De4gd/R/3StlSWJMOoEWyAF0CFTCZJee
         jB6lvzMX4E4cLNkebWaSKgGZHcjmuptqcTlGFmaXE/jhJPok6DJqlOnZEWCFECqHdX
         DNfib3SHF9K7zjfx2KbI+YM+CEulgWlgsKDGM0RxEH95Bo0wIa05wTuC//jAaPBqHI
         PLmUtDnI67nA253KPu28vpIBwRnz2wF74896wFHJ9p8z753IEwOB9oM0xYizAJaXMS
         oHdr4bwyZL8lA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v5.1 6/6] iio: imu: st_lsm6dsx: prohibit the use of events and buffered reads simultaneously
Date:   Mon,  9 Sep 2019 11:56:18 +0200
Message-Id: <20190909095618.70801-1-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909094506.51792-6-sean@geanix.com>
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

When events and buffered reads is enabled simultaneously, and the first
event accours the interrupt pin stays high.

This can be reverted when we find a solution to allow events and
buffered reads simultaneously.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v4:
 * Use fifo configuration mutex to prevent a race in hw->enable_event
   check.

Changes since v5:
 * Updated do not return without unlocking mutexes

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 13 ++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index ef579650fd52..b87a1872bc60 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -603,6 +603,11 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
 
 	mutex_lock(&hw->conf_lock);
 
+	if (hw->enable_event) {
+		err = -EBUSY;
+		goto out;
+	}
+
 	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
 		err = st_lsm6dsx_flush_fifo(hw);
 		if (err < 0)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 00ba14d15c13..a13d0c154b82 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1340,8 +1340,12 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
-		return -EBUSY;
+	mutex_unlock(&hw->conf_lock);
+
+	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
+		err = -EBUSY;
+		goto out;
+	}
 
 	/* do not enable events if they are already enabled */
 	if (state && hw->enable_event)
@@ -1357,7 +1361,10 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 
 	hw->enable_event = state;
 
-	return 0;
+out:
+	mutex_unlock(&hw->conf_lock);
+
+	return err;
 }
 
 int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
-- 
2.23.0

