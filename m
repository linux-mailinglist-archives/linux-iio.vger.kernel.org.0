Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174A1BA19C
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2019 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfIVJTL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Sep 2019 05:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfIVJTL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Sep 2019 05:19:11 -0400
Received: from localhost.localdomain (unknown [151.66.30.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE98C208C0;
        Sun, 22 Sep 2019 09:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569143950;
        bh=6GKX0W0BiN3qKwl2BqTuyAyDwkQMcgpHHtM/UEDKaqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Q3evBS1qMU0D1am9EiuuxWbTwf9a/PRDMWAyVvoV+i046n/ZpHY5NxCt5aJYN9mP
         VY2/0M6TNZxuvz6OXyLBHTmRAiYh0Lqs5CtmMrP/rJ4GiD41048mR6ud2jD0Loc6+t
         7+k152JxSjCowq2cfBgy2bClPgY0yuh6epsLLQDA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm, rjones@gateworks.com
Subject: [PATCH 2/3] iio: imu: st_lsm6dsx: do not access active-low/open-drain regs if not supported
Date:   Sun, 22 Sep 2019 11:18:52 +0200
Message-Id: <9c8f80bf1b45e0144536220826558ff3b0bc18f7.1569143551.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1569143551.git.lorenzo@kernel.org>
References: <cover.1569143551.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move active low and open drain register definitions in hw_settings
register map in order to avoid to access them if the sensor does not
support them

Fixes: 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 29 ++++++-----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 48 +++++++++++++++++++
 3 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index b2c568aadd4c..c213ead31083 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -235,6 +235,8 @@ struct st_lsm6dsx_settings {
 		struct st_lsm6dsx_reg irq2;
 		struct st_lsm6dsx_reg lir;
 		struct st_lsm6dsx_reg clear_on_read;
+		struct st_lsm6dsx_reg hla;
+		struct st_lsm6dsx_reg od;
 	} irq_config;
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index b0f3da1976e4..21c2aad8c56a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -42,10 +42,6 @@
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
-#define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
-#define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
-#define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
 #define ST_LSM6DSX_REG_FIFO_MODE_ADDR		0x0a
 #define ST_LSM6DSX_FIFO_MODE_MASK		GENMASK(2, 0)
 #define ST_LSM6DSX_FIFO_ODR_MASK		GENMASK(6, 3)
@@ -704,6 +700,7 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 {
 	struct device_node *np = hw->dev->of_node;
 	struct st_sensors_platform_data *pdata;
+	const struct st_lsm6dsx_reg *reg;
 	struct iio_buffer *buffer;
 	unsigned long irq_type;
 	bool irq_active_low;
@@ -711,6 +708,7 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 
 	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
 
+	reg = &hw->settings->irq_config.hla;
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
 	case IRQF_TRIGGER_RISING:
@@ -718,6 +716,10 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 		break;
 	case IRQF_TRIGGER_LOW:
 	case IRQF_TRIGGER_FALLING:
+		if (!reg->addr) {
+			dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
+			return -EINVAL;
+		}
 		irq_active_low = true;
 		break;
 	default:
@@ -725,20 +727,23 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 		return -EINVAL;
 	}
 
-	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,
-				 ST_LSM6DSX_REG_HLACTIVE_MASK,
-				 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
-					    irq_active_low));
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
+		if (!reg->addr) {
+			dev_info(hw->dev, "open drain mode unsupported\n");
+			return -EINVAL;
+		}
+
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
 		if (err < 0)
 			return err;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c14441040a62..3675b10a638a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -245,6 +245,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(0),
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
@@ -369,6 +377,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(0),
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
@@ -502,6 +518,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(0),
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
@@ -633,6 +657,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -779,6 +811,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -902,6 +942,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
-- 
2.21.0

