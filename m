Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7F568502
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 10:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfGOIP1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 04:15:27 -0400
Received: from first.geanix.com ([116.203.34.67]:55302 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfGOIP1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 04:15:27 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id B81394361D;
        Mon, 15 Jul 2019 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1563178502; bh=ImJrCnp61KHcPzIUn7tTxAsJTCx0JL12z5dzII4tKAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NKztfCHNcrd9R8i2polMzIOI/vXToTwu1lP+MxCpACy7BMjr0hGC8iNZdf0xn2IJD
         TFgQIazblWfB7/4QXd3DZ4HldhRijTw8y+lYUwZ3oC626JPKpl/KN2GV47IWdR8brj
         mRhjEXf/4oiDxq0pyYgHPugEFsThBaLFfOizB0qCo2RaGNteR/Spbv7oQwWCDss+QS
         RY9dJCWMe4olcQ48ne8i9cRtHIb7C3y1OyPCaX5sGdOkghYUYrV5RHStPFlEiE60++
         oj4U4obZ7P5zjnBEd8nFVI5heZ0awTXWZow2gwpgC69tnfg29rd/w4O2c6DqO9wgs9
         ZL2JoZrQr6v9g==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        martin@geanix.com
Subject: [PATCH v2 4/6] iio: imu: st_lsm6dsx: add wakeup-source option
Date:   Mon, 15 Jul 2019 10:15:12 +0200
Message-Id: <20190715081514.81129-4-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715081514.81129-1-sean@geanix.com>
References: <20190715081514.81129-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8945dcc0271d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This add ways for the SoC to wake from accelerometer wake events.

In the suspend function we skip disabling the sensor if wakeup-source
and events are activated.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

Changes since v1:
 * none, as the call to st_lsm6dsx_flush_fifo will put the fifo in
   bypass mode.

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 6decb0846f1a..fc450eeb9870 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1358,6 +1358,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (dev->of_node)
+		if (of_property_read_bool(dev->of_node, "wakeup-source"))
+			device_init_wakeup(dev, true);
+
 	return 0;
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
@@ -1372,6 +1376,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 		if (!hw->iio_devs[i])
 			continue;
 
+		if (device_may_wakeup(dev) && (i == ST_LSM6DSX_ID_ACC)) {
+			/* Enable wake from IRQ */
+			enable_irq_wake(hw->irq);
+			continue;
+		}
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
@@ -1404,6 +1414,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 		if (!hw->iio_devs[i])
 			continue;
 
+		if (device_may_wakeup(dev) && (i == ST_LSM6DSX_ID_ACC)) {
+			disable_irq_wake(hw->irq);
+			continue;
+		}
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (!(hw->suspend_mask & BIT(sensor->id)))
 			continue;
-- 
2.22.0

