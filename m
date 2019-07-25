Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7E2744F3
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 07:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403820AbfGYFcX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 01:32:23 -0400
Received: from comms.puri.sm ([159.203.221.185]:59546 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403815AbfGYFcW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Jul 2019 01:32:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 25F62E0494;
        Wed, 24 Jul 2019 22:32:21 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Px4CIUBDYA_0; Wed, 24 Jul 2019 22:32:20 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 3/5] iio: imu: st_lsm6sdx: move register definitions to sensor_settings struct
Date:   Thu, 25 Jul 2019 07:31:30 +0200
Message-Id: <20190725053132.9589-4-martin.kepplinger@puri.sm>
In-Reply-To: <20190725053132.9589-1-martin.kepplinger@puri.sm>
References: <20190725053132.9589-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move some register definitions to the per-device array of struct
st_lsm6dsx_sensor_settings in order to simplify adding new sensor
devices to the driver.

Also, remove completely unused register definitions.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  6 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index ab1c66615d67..3c47f5d27d30 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -198,6 +198,9 @@ struct st_lsm6dsx_ext_dev_settings {
 /**
  * struct st_lsm6dsx_settings - ST IMU sensor settings
  * @wai: Sensor WhoAmI default value.
+ * @int1_addr: Control Register address for INT1
+ * @int2_addr: Control Register address for INT2
+ * @reset_addr: register address for reset/reboot
  * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id/device name supported by the driver configuration.
  * @odr_table: Hw sensors odr table (Hz + val).
@@ -210,6 +213,9 @@ struct st_lsm6dsx_ext_dev_settings {
  */
 struct st_lsm6dsx_settings {
 	u8 wai;
+	u8 int1_addr;
+	u8 int2_addr;
+	u8 reset_addr;
 	u16 max_fifo_size;
 	struct {
 		enum st_lsm6dsx_hw_id hw_id;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 9aa109428a52..e0d2149625cc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -49,17 +49,12 @@
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_REG_INT1_ADDR		0x0d
-#define ST_LSM6DSX_REG_INT2_ADDR		0x0e
 #define ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK	BIT(3)
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
-#define ST_LSM6DSX_REG_RESET_ADDR		0x12
 #define ST_LSM6DSX_REG_RESET_MASK		BIT(0)
 #define ST_LSM6DSX_REG_BOOT_MASK		BIT(7)
 #define ST_LSM6DSX_REG_BDU_ADDR			0x12
 #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
-#define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
-#define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
 
 #define ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR		0x28
 #define ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR		0x2a
@@ -72,6 +67,9 @@
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
 		.wai = 0x69,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 1365,
 		.id = {
 			{
@@ -170,6 +168,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x69,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
 			{
@@ -268,6 +269,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6a,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 682,
 		.id = {
 			{
@@ -375,6 +379,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6c,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
 			{
@@ -494,6 +501,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
 			{
@@ -584,6 +594,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	},
 	{
 		.wai = 0x6b,
+		.int1_addr = 0x0d,
+		.int2_addr = 0x0e,
+		.reset_addr = 0x12,
 		.max_fifo_size = 512,
 		.id = {
 			{
@@ -1117,10 +1130,10 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
 
 	switch (drdy_pin) {
 	case 1:
-		*drdy_reg = ST_LSM6DSX_REG_INT1_ADDR;
+		*drdy_reg = hw->settings->int1_addr;
 		break;
 	case 2:
-		*drdy_reg = ST_LSM6DSX_REG_INT2_ADDR;
+		*drdy_reg = hw->settings->int2_addr;
 		break;
 	default:
 		dev_err(hw->dev, "unsupported data ready pin\n");
@@ -1220,7 +1233,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	int err;
 
 	/* device sw reset */
-	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
+	err = regmap_update_bits(hw->regmap, hw->settings->reset_addr,
 				 ST_LSM6DSX_REG_RESET_MASK,
 				 FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
 	if (err < 0)
@@ -1229,7 +1242,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	msleep(50);
 
 	/* reload trimming parameter */
-	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
+	err = regmap_update_bits(hw->regmap, hw->settings->reset_addr,
 				 ST_LSM6DSX_REG_BOOT_MASK,
 				 FIELD_PREP(ST_LSM6DSX_REG_BOOT_MASK, 1));
 	if (err < 0)
-- 
2.20.1

