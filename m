Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94446CD20F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfJFNWe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:33 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FDB120684;
        Sun,  6 Oct 2019 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368152;
        bh=b4uVfeTKNSxGsaAGqAUEO5pMHiL+u9bjLP3wHVv8vIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zk24TjL1hQwUgNvcQo2kV114KbGlDrxx0co0Ch2G+SJjQMVDQUfYhAV2xA0NSzB6K
         eGuEvf5r6WAvoUg6vmTIQik2rZ/PUqaRpwKCEouwdudWYrZ1kwmi5f9/PuuPTAZZY1
         sjRf0d+ZCaBW/6E2wLANodZi0Pe3tbnvQDa8Wxy4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 04/13] iio: imu: st_lsm6dsx: do not access active-low/open-drain regs if not supported
Date:   Sun,  6 Oct 2019 15:21:58 +0200
Message-Id: <7db02b38f42c3ca784e463aac2df98cd0d15d21c.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move active low and open drain register definitions in hw_settings
register map since not all supported sensors (e.g lsm9ds1) rely on the
same definitions

Fixes: 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 79 ++++++++++++++++----
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 873ec3b8fd69..8e002a51595e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -268,6 +268,8 @@ struct st_lsm6dsx_settings {
 		struct st_lsm6dsx_reg irq2_func;
 		struct st_lsm6dsx_reg lir;
 		struct st_lsm6dsx_reg clear_on_read;
+		struct st_lsm6dsx_reg hla;
+		struct st_lsm6dsx_reg od;
 	} irq_config;
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 23d67caa24ed..a598cc8e9343 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -67,11 +67,6 @@
 #define ST_LSM6DSX_REG_BDU_ADDR			0x12
 #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
 
-#define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
-#define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
-#define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
-#define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
-
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
@@ -170,6 +165,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x0d,
 				.mask = BIT(3),
 			},
+			.hla = {
+				.addr = 0x22,
+				.mask = BIT(5),
+			},
+			.od = {
+				.addr = 0x22,
+				.mask = BIT(4),
+			},
 		},
 	},
 	{
@@ -261,6 +264,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5f,
 				.mask = BIT(5),
 			},
+			.hla = {
+				.addr = 0x12,
+				.mask = BIT(5),
+			},
+			.od = {
+				.addr = 0x12,
+				.mask = BIT(4),
+			},
 		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -404,6 +415,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5f,
 				.mask = BIT(5),
 			},
+			.hla = {
+				.addr = 0x12,
+				.mask = BIT(5),
+			},
+			.od = {
+				.addr = 0x12,
+				.mask = BIT(4),
+			},
 		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -556,6 +575,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5f,
 				.mask = BIT(5),
 			},
+			.hla = {
+				.addr = 0x12,
+				.mask = BIT(5),
+			},
+			.od = {
+				.addr = 0x12,
+				.mask = BIT(4),
+			},
 		},
 		.decimator = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -702,6 +729,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x56,
 				.mask = BIT(6),
 			},
+			.hla = {
+				.addr = 0x12,
+				.mask = BIT(5),
+			},
+			.od = {
+				.addr = 0x12,
+				.mask = BIT(4),
+			},
 		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -856,6 +891,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5f,
 				.mask = BIT(5),
 			},
+			.hla = {
+				.addr = 0x12,
+				.mask = BIT(5),
+			},
+			.od = {
+				.addr = 0x12,
+				.mask = BIT(4),
+			},
 		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -1002,6 +1045,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x5f,
 				.mask = BIT(5),
 			},
+			.hla = {
+				.addr = 0x12,
+				.mask = BIT(5),
+			},
+			.od = {
+				.addr = 0x12,
+				.mask = BIT(4),
+			},
 		},
 		.batch = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -1900,8 +1951,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 
 static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 {
-	struct st_sensors_platform_data *pdata;
 	struct device_node *np = hw->dev->of_node;
+	struct st_sensors_platform_data *pdata;
+	const struct st_lsm6dsx_reg *reg;
 	unsigned long irq_type;
 	bool irq_active_low;
 	int err;
@@ -1922,20 +1974,19 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 		return -EINVAL;
 	}
 
-	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,
-				 ST_LSM6DSX_REG_HLACTIVE_MASK,
-				 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
-					    irq_active_low));
+	reg = &hw->settings->irq_config.hla;
+	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+				 ST_LSM6DSX_SHIFT_VAL(irq_active_low,
+						      reg->mask));
 	if (err < 0)
 		return err;
 
 	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
 	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
 	    (pdata && pdata->open_drain)) {
-		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_ADDR,
-					 ST_LSM6DSX_REG_PP_OD_MASK,
-					 FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
-						    1));
+		reg = &hw->settings->irq_config.od;
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
 		if (err < 0)
 			return err;
 
-- 
2.21.0

