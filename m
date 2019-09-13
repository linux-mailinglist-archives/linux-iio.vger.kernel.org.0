Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF55B1A72
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbfIMJHZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 05:07:25 -0400
Received: from first.geanix.com ([116.203.34.67]:49578 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387798AbfIMJHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Sep 2019 05:07:25 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id CE175650D3;
        Fri, 13 Sep 2019 09:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568365592; bh=JQ4faEhDP3V6ZmCM2mD2ZRnO+wFy3nsQBN01f9pt02w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=boGpFXfCe6soDdAFv/Uv6ciVM2M5O3iTP7PR2LN4Q4TGZyO2CGK22yKZkNAuXL54E
         N81o1q57gRUUsVvanyIqm/58Qo2JGZao6O6IQBEHbKBakAsqypqajqJBQ5yFqy3zmp
         6tqEpDXEsrmayrpUiLWwqxR4m8bO/4aTTiDJrzBBN48Gl/3Hd85KVKMY0MSmE9bfKT
         pEYzebcsCZaB0eS2Ad+MbgqRR0YazpO6lsi7YzQY9BwtDlS6yKpkPlbkVvLHiXM6NK
         gvcCeGFFslTe4VN8mymvQw5+fC/LPzdvIUf1l6NZWWe/X27C1GIkxCA/+csPhJCeSn
         R3zsb8bQKa0oQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v8 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Date:   Fri, 13 Sep 2019 11:07:06 +0200
Message-Id: <20190913090708.1442057-4-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913090708.1442057-1-sean@geanix.com>
References: <20190913090708.1442057-1-sean@geanix.com>
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

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4198ba263d03..810807c52d5f 100644
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
 
+		if (device_may_wakeup(dev) && i == ST_LSM6DSX_ID_ACC &&
+		    hw->enable_event) {
+			/* Enable wake from IRQ */
+			enable_irq_wake(hw->irq);
+			continue;
+		}
+
 		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT2)
@@ -1904,6 +1914,10 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 		if (!hw->iio_devs[i])
 			continue;
 
+		if (device_may_wakeup(dev) && i == ST_LSM6DSX_ID_ACC &&
+		    hw->enable_event)
+			disable_irq_wake(hw->irq);
+
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (!(hw->suspend_mask & BIT(sensor->id)))
 			continue;
-- 
2.23.0

