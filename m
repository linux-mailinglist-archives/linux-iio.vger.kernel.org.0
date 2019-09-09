Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41BAD950
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfIIMpa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 08:45:30 -0400
Received: from first.geanix.com ([116.203.34.67]:56986 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbfIIMp3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 08:45:29 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id B66C56E016;
        Mon,  9 Sep 2019 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568033099; bh=e3MFIztuXnV4YD5HX69NFXAfs1NSofr409kzk5SLCrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LsmQ1B9Yh5f3Rt02GmulYaL9x8jcih20JbkLWgCY3z/m0TZMXGBfun9yaGBVs+207
         Mv3QwZKdA466VAG4JmmX6iiijLLb0mhQk/mcOTsJ/somtxTf8yyoaI6KiWqZEJIXCZ
         S11Rd3+lGGpxKZfoDxO3I8oDa3gXQfbT74COT4vtZWGRbGV7ilBkfcBTJPqrNlJo9h
         a53ov1pASFp//uM+WUXUbdtn0KSsBS8IJU8LruTcZdg/uTlxkywsUTkciplr0xDpUZ
         JPCT8KUHK+agxWHuoZnTCdb+Tq2KMXcTIEHYjweTLFQ+HXFZ4qS07S5pcUy6E0wb2A
         tN5stxuE4AgSA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v6.1 6/6] iio: imu: st_lsm6dsx: prohibit the use of events and buffered reads simultaneously
Date:   Mon,  9 Sep 2019 14:45:18 +0200
Message-Id: <20190909124518.84025-1-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909112846.55280-6-sean@geanix.com>
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
 * Use fifo configuration mutex to prevent a race in hw->enable_event check.

Changes since v5:
 * Updated do not return without unlocking mutexes
 * Lock mutex before unlock
 * Runtime tested 
 * Make sure we unlock the mutex in case of failure

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 18 ++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

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
index de6bddd91471..fb658cb69c9d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1340,21 +1340,31 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
+	mutex_lock(&hw->conf_lock);
+
+	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
+		err = -EBUSY;
+		goto out;
+	}
+
 	/* do not enable events if they are already enabled */
 	if (state && hw->enable_event)
-		return 0;
+		goto out;
 
 	err = st_lsm6dsx_event_setup(hw, state);
 	if (err < 0)
-		return err;
+		goto out;
 
 	err = st_lsm6dsx_sensor_set_enable(sensor, state);
 	if (err < 0)
-		return err;
+		goto out;
 
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

