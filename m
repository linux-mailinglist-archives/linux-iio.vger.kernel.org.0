Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56ED14A14E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFRM77 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 08:59:59 -0400
Received: from first.geanix.com ([116.203.34.67]:37326 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfFRM77 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 08:59:59 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 3C17CDB6;
        Tue, 18 Jun 2019 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560862791; bh=n8NXeJFYKKTMe6So+r4nZzbcykPTURi8xePP+HJDBQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a0o5wohcdHMn2vnBf3EmtnPWb4aJOnjByfp32bWV5ZzaIJfcH4OZ/CnCRt/jSQUhs
         Wql6z0xYsWDTQCF+1Wijn6T62guipT4X1nm5TC2T4OQOBSFaJCVs1XKdTOKVWJd19c
         JkFaGj/oSHErRE8LoNw1k7fYr3jnCrah+/88Lco4F15Bc4v88FYt750F4+fpqW/6yT
         96Q10middFj5MRWklQ0KNLh4WZiGDm7to4IelQqL5yOBBSP4MwDgORbtJTYBvSMKaD
         SkLRwgIUAv74UDpJEMVMoRo4TtYsSV1D9xm1GjQoatvPKsPSlfHdVCwtospUD4oM9C
         kWRB9B3f4Ou6w==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH 5/5] iio: imu: st_lsm6dsx: add motion report function and call from interrupt
Date:   Tue, 18 Jun 2019 14:59:39 +0200
Message-Id: <20190618125939.105903-6-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618125939.105903-1-sean@geanix.com>
References: <20190618125939.105903-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Report iio motion events to iio subsystem

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 76aec5024d83..7b66799acf4d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -34,6 +34,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
@@ -949,6 +950,39 @@ int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw)
 
 	return err;
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
 
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
 {
@@ -967,6 +1001,8 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 		if (err < 0)
 			goto try_fifo;
 
+		if (data && ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK)
+			st_lsm6dsx_report_motion_event(hw, data);
 	}
 
 try_fifo:
-- 
2.22.0

