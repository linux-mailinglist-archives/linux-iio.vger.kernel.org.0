Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9661EB3BED
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388190AbfIPN4i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 09:56:38 -0400
Received: from first.geanix.com ([116.203.34.67]:36396 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387994AbfIPN4i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 09:56:38 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 51C1F65693;
        Mon, 16 Sep 2019 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568642137; bh=VuziO2Y+pfrYCU7155vNDxm6gw1BNjzrOvUG9Jy8TQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GWfohSdv/WV5IPvWzdONab40RcfL5UF6OEv2GMFvF02Bj6Ff7Q4K6gBDahMQWViHz
         qNnkkwYGmBV0jSg3TNJKURy6FyHRQaYLOd3gTnSAoRAI7zQd7Ux0AaICJDgt/b9+te
         8m0vNpQJc7hr372+beiIZxLF7a3LZLWbegLcazQbD3accoWC6SMks5pUKqapVMEBPz
         3zSBhxdzWBsgykIg1SQZD8LqvbVpjL+x+Nf1V2YY90t8ZLuvRtZ0eebvAlrEY8m6X4
         w1ND9/8M+xMAMwnQJqOpxu/MQYEmm9Sv3Gf9RpwJRt2wFfl1h31BpPACKEosf+OM/A
         geDkSTPMSjTNA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v10 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Date:   Mon, 16 Sep 2019 15:56:28 +0200
Message-Id: <20190916135630.2211714-3-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916135630.2211714-1-sean@geanix.com>
References: <20190916135630.2211714-1-sean@geanix.com>
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

Changes since v7:
 * Add check for hw->enable_event
 * Moved disable_irq_wake section so it's called
 * Removed not neeeded continue from disable_irq_wake section

Changes since v8:
 * Using sensor->id instead of i in suspend/resume loops

Changes since v9:
 * None

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4198ba263d03..a7f12cf57f11 100644
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
@@ -1876,6 +1879,13 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
+		if (device_may_wakeup(dev) &&
+		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event) {
+			/* Enable wake from IRQ */
+			enable_irq_wake(hw->irq);
+			continue;
+		}
+
 		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT2)
@@ -1905,6 +1915,10 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 			continue;
 
 		sensor = iio_priv(hw->iio_devs[i]);
+		if (device_may_wakeup(dev) &&
+		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event)
+			disable_irq_wake(hw->irq);
+
 		if (!(hw->suspend_mask & BIT(sensor->id)))
 			continue;
 
-- 
2.23.0

