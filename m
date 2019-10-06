Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4ACD211
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfJFNWg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:36 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26BAA2133F;
        Sun,  6 Oct 2019 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368154;
        bh=ZInNTo0B0GFPLzASupH5y0zb+HGFmLKUn4+Wc0CNYSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0a8YYtKodU+hqaZUXBnmXwDI/5cHwRz33WRh9sUlkT+8iVnOpTlCotGbweqUOiTlT
         ZzOIZ6qFo5KJpWKN33TUV4TE3JgFk/OtB24noVbG9n0SqsaSsjFS3iHdNnJ3JxFs4p
         f5yPvnfd40Ss5NQHdHkHCqm9VyjRWvYmlryPKTKE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 05/13] iio: imu: st_lsm6dsx: move bdu/boot and reset register info in hw_settings
Date:   Sun,  6 Oct 2019 15:21:59 +0200
Message-Id: <05ed5aab740bcf07ee5b32e4d3248d29b6ad31f7.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move bdu, boot and reset register definitions in hw_settings register
map since not all supported sensors (e.g lsm9ds1) rely on the same
definitions

Fixes: 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   8 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 113 +++++++++++++++----
 2 files changed, 99 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 8e002a51595e..5692ea695f04 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -236,7 +236,9 @@ struct st_lsm6dsx_ext_dev_settings {
 /**
  * struct st_lsm6dsx_settings - ST IMU sensor settings
  * @wai: Sensor WhoAmI default value.
- * @reset_addr: register address for reset/reboot
+ * @reset: register address for reset.
+ * @boot: register address for boot.
+ * @bdu: register address for Block Data Update.
  * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id/device name supported by the driver configuration.
  * @channels: IIO channels supported by the device.
@@ -251,7 +253,9 @@ struct st_lsm6dsx_ext_dev_settings {
  */
 struct st_lsm6dsx_settings {
 	u8 wai;
-	u8 reset_addr;
+	struct st_lsm6dsx_reg reset;
+	struct st_lsm6dsx_reg boot;
+	struct st_lsm6dsx_reg bdu;
 	u16 max_fifo_size;
 	struct {
 		enum st_lsm6dsx_hw_id hw_id;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a598cc8e9343..5df382b9d8f9 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -62,10 +62,6 @@
 #include "st_lsm6dsx.h"
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
-#define ST_LSM6DSX_REG_RESET_MASK		BIT(0)
-#define ST_LSM6DSX_REG_BOOT_MASK		BIT(7)
-#define ST_LSM6DSX_REG_BDU_ADDR			0x12
-#define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
 
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
@@ -91,7 +87,18 @@ static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.wai = 0x68,
-		.reset_addr = 0x22,
+		.reset = {
+			.addr = 0x22,
+			.mask = BIT(0),
+		},
+		.boot = {
+			.addr = 0x22,
+			.mask = BIT(7),
+		},
+		.bdu = {
+			.addr = 0x22,
+			.mask = BIT(6),
+		},
 		.max_fifo_size = 32,
 		.id = {
 			{
@@ -177,7 +184,18 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x69,
-		.reset_addr = 0x12,
+		.reset = {
+			.addr = 0x12,
+			.mask = BIT(0),
+		},
+		.boot = {
+			.addr = 0x12,
+			.mask = BIT(7),
+		},
+		.bdu = {
+			.addr = 0x12,
+			.mask = BIT(6),
+		},
 		.max_fifo_size = 1365,
 		.id = {
 			{
@@ -328,7 +346,18 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x69,
-		.reset_addr = 0x12,
+		.reset = {
+			.addr = 0x12,
+			.mask = BIT(0),
+		},
+		.boot = {
+			.addr = 0x12,
+			.mask = BIT(7),
+		},
+		.bdu = {
+			.addr = 0x12,
+			.mask = BIT(6),
+		},
 		.max_fifo_size = 682,
 		.id = {
 			{
@@ -479,7 +508,18 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6a,
-		.reset_addr = 0x12,
+		.reset = {
+			.addr = 0x12,
+			.mask = BIT(0),
+		},
+		.boot = {
+			.addr = 0x12,
+			.mask = BIT(7),
+		},
+		.bdu = {
+			.addr = 0x12,
+			.mask = BIT(6),
+		},
 		.max_fifo_size = 682,
 		.id = {
 			{
@@ -643,7 +683,18 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6c,
-		.reset_addr = 0x12,
+		.reset = {
+			.addr = 0x12,
+			.mask = BIT(0),
+		},
+		.boot = {
+			.addr = 0x12,
+			.mask = BIT(7),
+		},
+		.bdu = {
+			.addr = 0x12,
+			.mask = BIT(6),
+		},
 		.max_fifo_size = 512,
 		.id = {
 			{
@@ -800,7 +851,18 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
-		.reset_addr = 0x12,
+		.reset = {
+			.addr = 0x12,
+			.mask = BIT(0),
+		},
+		.boot = {
+			.addr = 0x12,
+			.mask = BIT(7),
+		},
+		.bdu = {
+			.addr = 0x12,
+			.mask = BIT(6),
+		},
 		.max_fifo_size = 512,
 		.id = {
 			{
@@ -951,7 +1013,18 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
-		.reset_addr = 0x12,
+		.reset = {
+			.addr = 0x12,
+			.mask = BIT(0),
+		},
+		.boot = {
+			.addr = 0x12,
+			.mask = BIT(7),
+		},
+		.bdu = {
+			.addr = 0x12,
+			.mask = BIT(6),
+		},
 		.max_fifo_size = 512,
 		.id = {
 			{
@@ -1778,27 +1851,27 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	int err;
 
 	/* device sw reset */
-	err = regmap_update_bits(hw->regmap, hw->settings->reset_addr,
-				 ST_LSM6DSX_REG_RESET_MASK,
-				 FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
+	reg = &hw->settings->reset;
+	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+				 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
 	if (err < 0)
 		return err;
 
 	msleep(50);
 
 	/* reload trimming parameter */
-	err = regmap_update_bits(hw->regmap, hw->settings->reset_addr,
-				 ST_LSM6DSX_REG_BOOT_MASK,
-				 FIELD_PREP(ST_LSM6DSX_REG_BOOT_MASK, 1));
+	reg = &hw->settings->boot;
+	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+				 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
 	if (err < 0)
 		return err;
 
 	msleep(50);
 
 	/* enable Block Data Update */
-	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_BDU_ADDR,
-				 ST_LSM6DSX_REG_BDU_MASK,
-				 FIELD_PREP(ST_LSM6DSX_REG_BDU_MASK, 1));
+	reg = &hw->settings->bdu;
+	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+				 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
 	if (err < 0)
 		return err;
 
-- 
2.21.0

