Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5747B0927
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 09:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfILHGZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 03:06:25 -0400
Received: from first.geanix.com ([116.203.34.67]:53086 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfILHGZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Sep 2019 03:06:25 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id ED64264D9B;
        Thu, 12 Sep 2019 07:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568271943; bh=BcSqBzf0CxDz+PUrGPgbpd6SF7a0AAz9Ru/Nv2tu+4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EcEpjHZnk9YMbEpOj1wTJjkIn9k5ikXXPYLPRIq+OfZ4J9IciB1r/KdfYqIS4yxPl
         uRrcITHL7sH9VD+Mdh1neLvxqMNGX5S3dUmKNbI8nuSubVqrXsx3Dru/vqRJYvJhQz
         9UYz0swdYNiXB4yzKmfnvI1m1d88tZ1N8ilUzR/EdRpKVAmT/OPYd/qrsQsC/ELBij
         0Jmj3OjPKBPGmfKV5i+0lbMvb0qviztAATYo0t/dW8GVqkqxjLnHkljgYIMBZ0CSrA
         Wbdhn1VT333q911R+ThLqmmizG5l4YKZfz1aaA8vKgoeLabAhQme3L1y3gPE+qpRPh
         oVBGFrITbhAXw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v7 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Date:   Thu, 12 Sep 2019 09:06:12 +0200
Message-Id: <20190912070614.1144169-4-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912070614.1144169-1-sean@geanix.com>
References: <20190912070614.1144169-1-sean@geanix.com>
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

This add ways for the SoC to wake from accelerometer wake events.

In the suspend function we skip disabling the sensor if wakeup-source
and events are activated.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v4:
 * More devices supports wakeup

Changes since v5:
 * None

Changes since v6:
 * None

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4198ba263d03..f79978a2870f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1858,6 +1858,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	return 0;
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
@@ -1876,6 +1879,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
+		if (device_may_wakeup(dev) && i == ST_LSM6DSX_ID_ACC) {
+			/* Enable wake from IRQ */
+			enable_irq_wake(hw->irq);
+			continue;
+		}
+
 		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT2)
@@ -1908,6 +1917,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 		if (!(hw->suspend_mask & BIT(sensor->id)))
 			continue;
 
+		if (device_may_wakeup(dev) && i == ST_LSM6DSX_ID_ACC) {
+			disable_irq_wake(hw->irq);
+			continue;
+		}
+
 		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT2)
-- 
2.23.0

