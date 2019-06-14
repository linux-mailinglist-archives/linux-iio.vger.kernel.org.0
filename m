Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE045CC5
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 14:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfFNM0V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 08:26:21 -0400
Received: from first.geanix.com ([116.203.34.67]:45580 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfFNM0V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Jun 2019 08:26:21 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 84CCC1548;
        Fri, 14 Jun 2019 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560515023; bh=ZmkwG02wMQXlzrHTHWpek33luyWYKF50qD/jcB95cyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q+TPIGNq5D4c685wlH3MJcu4KFKO2dBN7nq7PzYELm27r4dbt6vTUFrDekA6ud9Jv
         dqn+c90owJjRxXeRjdSSGgZqDc4ckxzcS237i/VToamcyJTrkM7t1T9K2ALsLDXE6+
         Y8TIJE3NOD2PAVLwgBK/kpN/Ze5Npn+uTApAYRv3hcUUsgAuzFfg4DFsHmZgbJPUfc
         dnqjM8A43PeOnhOgp24iRTP93wGqoLFCdCc6mylksSV89+LgKMOsPR3FYnWBjeTuNI
         csHMwekL5VmljVNldCopEW1cCKDNrBJZx5nlIy08BMgrp+yvyTVFJPBLUl1PrZRD0P
         77Yz48UpHJmCQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, martin@geanix.com
Subject: [RFC PATCH 1/3] iio: imu: st_lsm6dsx: add wake on accelerometer threshold
Date:   Fri, 14 Jun 2019 14:26:02 +0200
Message-Id: <20190614122604.52935-2-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190614122604.52935-1-sean@geanix.com>
References: <20190614122604.52935-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 796779db2bec
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Added wakeup-source option for waking on accelerometer events.
If the wakeup-source is specified, we activate this on our
way down to suspend. We start the accelerometer in
low power mode and wait for it to report a wake event.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index edcd838037cd..ef4327fd57d6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -147,6 +147,7 @@ struct st_lsm6dsx_hw {
 	struct device *dev;
 	struct regmap *regmap;
 	int irq;
+	bool irq_wake;
 
 	struct mutex fifo_lock;
 	struct mutex conf_lock;
@@ -155,6 +156,7 @@ struct st_lsm6dsx_hw {
 	u8 enable_mask;
 	u8 ts_sip;
 	u8 sip;
+	u8 wake_threshold;
 
 	u8 *buff;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index aebbe0ddd8d8..092c4d02bd4e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
@@ -71,6 +72,17 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
+#define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
+#define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
+#define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
+
+#define ST_LSM6DSX_DEFAULT_WAKE_THRESH		0
+#define ST_LSM6DSX_REG_WAKE_UP_THS_ADDR		0x5B
+#define ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK	GENMASK(5, 0)
+
+#define ST_LSM6DSX_REG_MD1_CFG_ADDR		0x5E
+#define ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK	BIT(5)
+
 #define ST_LSM6DSX_ACC_FS_2G_GAIN		IIO_G_TO_M_S_2(61)
 #define ST_LSM6DSX_ACC_FS_4G_GAIN		IIO_G_TO_M_S_2(122)
 #define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)
@@ -428,6 +440,19 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
 				  ST_LSM6DSX_SHIFT_VAL(val, reg->mask));
 }
 
+static int st_lsm6dsx_set_wake_threshold(struct st_lsm6dsx_hw *hw, u8 threshold)
+{
+	int err = 0;
+
+	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_WAKE_UP_THS_ADDR,
+				 ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK,
+				 threshold);
+	if (!err)
+		hw->wake_threshold = threshold;
+
+	return err;
+}
+
 int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
 {
 	int err;
@@ -754,6 +779,8 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	if (err < 0)
 		return err;
 
+	st_lsm6dsx_set_wake_threshold(hw, ST_LSM6DSX_DEFAULT_WAKE_THRESH);
+
 	return st_lsm6dsx_init_hw_timer(hw);
 }
 
@@ -853,6 +880,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 			return err;
 	}
 
+	if (dev->of_node)
+		if (of_property_read_bool(dev->of_node, "wakeup-source"))
+			device_init_wakeup(dev, true);
+
 	return 0;
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
@@ -879,6 +910,26 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
 		err = st_lsm6dsx_flush_fifo(hw);
 
+	if (device_may_wakeup(dev)) {
+		sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+		err = st_lsm6dsx_sensor_enable(sensor);
+
+		/* Enable inactivity function - low power ACC, GYRO powered-down */
+		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_TAP_CFG_ADDR,
+				ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
+				ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK,
+				ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
+				ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK);
+
+		/* Enable wakeup interrupt */
+		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_MD1_CFG_ADDR,
+				ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK,
+				ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK);
+
+		/* Enable wake from IRQ */
+		hw->irq_wake = (enable_irq_wake(hw->irq) == 0);
+	}
+
 	return err;
 }
 
@@ -888,6 +939,25 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 	struct st_lsm6dsx_sensor *sensor;
 	int i, err = 0;
 
+	if (device_may_wakeup(dev) && hw->irq_wake) {
+		disable_irq_wake(hw->irq);
+		hw->irq_wake = false;
+
+		sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+		err = st_lsm6dsx_sensor_disable(sensor);
+
+		/* Disable inactivity function */
+		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_TAP_CFG_ADDR,
+				ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
+				ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK,
+				0);
+
+		/* Disable wakeup interrupt */
+		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_MD1_CFG_ADDR,
+				ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK,
+				0);
+	}
+
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		sensor = iio_priv(hw->iio_devs[i]);
 		if (!(hw->enable_mask & BIT(sensor->id)))
-- 
2.22.0

