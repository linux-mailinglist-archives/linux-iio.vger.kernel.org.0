Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B28AD5FD
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbfIIJpT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 05:45:19 -0400
Received: from first.geanix.com ([116.203.34.67]:49148 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbfIIJpS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 05:45:18 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 8297A6E017;
        Mon,  9 Sep 2019 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568022289; bh=vuSs5/jjkXEBPAvc6gOeiSFNjdnSYnIwqx1gbVjBjhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=P8gzlSRVLxZr/0PozDBMfiI0MUCDouQeZWSUu4s/gWjSWOEdVi5F7PciZi9GftfB4
         +vu6uBpS+Rx0E3HGoMEZrA59GSCG2a8ik3w9NTXI76xngBpHFC5ccDVWwMDpSRc7Gg
         ZQ3nxg1fxc5trxUYXpbLTA1rrxpEf3Id9Q6XNOtwtKGrYPsHnZtlzkohX2KiPF0O6h
         TjgHaEQwyxXa2d0LfmYGWaI8h1AeWpSaFPrBu9e1RwYnzN7PaI9lG0RAUTBsZsQDPm
         0qcFbO1if9G31jzH4Rdm24XpWT4vndj5vNSKlKbESwiZk2roevQu4ZbnKu+cEd2Mc7
         wuTm91cgFk7HA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v5 6/6] iio: imu: st_lsm6dsx: prohibit the use of events and buffered reads simultaneously
Date:   Mon,  9 Sep 2019 11:45:06 +0200
Message-Id: <20190909094506.51792-6-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909094506.51792-1-sean@geanix.com>
References: <20190909094506.51792-1-sean@geanix.com>
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

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index ef579650fd52..f9f27a42e49a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -603,6 +603,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
 
 	mutex_lock(&hw->conf_lock);
 
+	if (hw->enable_event)
+		return -EBUSY;
+
 	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
 		err = st_lsm6dsx_flush_fifo(hw);
 		if (err < 0)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 00ba14d15c13..b4df15a8558e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1340,6 +1340,8 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
+	mutex_unlock(&hw->conf_lock);
+
 	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
 		return -EBUSY;
 
@@ -1351,6 +1353,8 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (err < 0)
 		return err;
 
+	mutex_unlock(&hw->conf_lock);
+
 	err = st_lsm6dsx_sensor_set_enable(sensor, state);
 	if (err < 0)
 		return err;
-- 
2.23.0

