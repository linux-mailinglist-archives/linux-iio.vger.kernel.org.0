Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25077418944
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhIZOEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 10:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhIZOET (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 10:04:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0163260F39;
        Sun, 26 Sep 2021 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632664963;
        bh=v6jUXK8LEi4+BnA+yFWn/vVEN40DtA1tULZZTGjUji4=;
        h=From:To:Cc:Subject:Date:From;
        b=YaGSDxAVst58dDMpKg5/fOPp2dDA7mGPRJjRfQJjfOP4WT61HLTn5uW9mKV8KciCY
         Gxvhn1EKwLwYvMy3oT3cfSiiuhL+Xk+1oT/ghxutjvs/BpPO1QdYDEF2vNzBrlnmpw
         AqnCUQGyTyXwxGSKnu71BLZ4cc9oRTOGVNERUaOT2QaqNnkMhSPUa63IM76K9Fyxr/
         vzwAoQTVBs7FRoFr5Wjb849Zi9Ci5Rf2MXXT4sOaRYBmIYyo24sJmMBL5ja5cIUWHR
         ZMLMjs8jl9AV5Bg3dhz7NfkOL5fbL85ckeVoiQ999ozsnCC2x18Q/vjUlxdwGaG0Jh
         e9NcoaJ9RbEfg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2] iio: imu: st_lsm6dsx: move max_fifo_size in st_lsm6dsx_fifo_ops
Date:   Sun, 26 Sep 2021 16:02:30 +0200
Message-Id: <3262ad9d9d1497e19ea1bab208c495c2b9a98994.1632664866.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move max_fifo_size in st_lsm6dsx_fifo_ops in order to have all
FIFO configuration parameters in st_lsm6dsx_fifo_ops structure.
This patch does not introduce any logic change, just small code
rearrangement.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- improve commit message.
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  4 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 16 +++++++++-------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 5ef55763a6cc..6ac4eac36458 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -143,6 +143,7 @@ struct st_lsm6dsx_fs_table_entry {
  * @read_fifo: Read FIFO callback.
  * @fifo_th: FIFO threshold register info (addr + mask).
  * @fifo_diff: FIFO diff status register info (addr + mask).
+ * @max_size: Sensor max fifo length in FIFO words.
  * @th_wl: FIFO threshold word length.
  */
 struct st_lsm6dsx_fifo_ops {
@@ -156,6 +157,7 @@ struct st_lsm6dsx_fifo_ops {
 		u8 addr;
 		u16 mask;
 	} fifo_diff;
+	u16 max_size;
 	u8 th_wl;
 };
 
@@ -271,7 +273,6 @@ struct st_lsm6dsx_ext_dev_settings {
  * @reset: register address for reset.
  * @boot: register address for boot.
  * @bdu: register address for Block Data Update.
- * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id/device name supported by the driver configuration.
  * @channels: IIO channels supported by the device.
  * @irq_config: interrupts related registers.
@@ -288,7 +289,6 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_reg reset;
 	struct st_lsm6dsx_reg boot;
 	struct st_lsm6dsx_reg bdu;
-	u16 max_fifo_size;
 	struct {
 		enum st_lsm6dsx_hw_id hw_id;
 		const char *name;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index db45f1fc0b81..0f54df85134a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -102,7 +102,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x22,
 			.mask = BIT(6),
 		},
-		.max_fifo_size = 32,
 		.id = {
 			{
 				.hw_id = ST_LSM9DS1_ID,
@@ -194,6 +193,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = BIT(4),
 			},
 		},
+		.fifo_ops = {
+			.max_size = 32,
+		},
 	},
 	{
 		.reset = {
@@ -208,7 +210,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x12,
 			.mask = BIT(6),
 		},
-		.max_fifo_size = 1365,
 		.id = {
 			{
 				.hw_id = ST_LSM6DS3_ID,
@@ -329,6 +330,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x3a,
 				.mask = GENMASK(11, 0),
 			},
+			.max_size = 1365,
 			.th_wl = 3, /* 1LSB = 2B */
 		},
 		.ts_settings = {
@@ -374,7 +376,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x12,
 			.mask = BIT(6),
 		},
-		.max_fifo_size = 682,
 		.id = {
 			{
 				.hw_id = ST_LSM6DS3H_ID,
@@ -495,6 +496,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x3a,
 				.mask = GENMASK(11, 0),
 			},
+			.max_size = 682,
 			.th_wl = 3, /* 1LSB = 2B */
 		},
 		.ts_settings = {
@@ -540,7 +542,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x12,
 			.mask = BIT(6),
 		},
-		.max_fifo_size = 682,
 		.id = {
 			{
 				.hw_id = ST_LSM6DSL_ID,
@@ -677,6 +678,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x3a,
 				.mask = GENMASK(10, 0),
 			},
+			.max_size = 682,
 			.th_wl = 3, /* 1LSB = 2B */
 		},
 		.ts_settings = {
@@ -759,7 +761,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x12,
 			.mask = BIT(6),
 		},
-		.max_fifo_size = 512,
 		.id = {
 			{
 				.hw_id = ST_LSM6DSR_ID,
@@ -910,6 +911,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x3a,
 				.mask = GENMASK(9, 0),
 			},
+			.max_size = 512,
 			.th_wl = 1,
 		},
 		.ts_settings = {
@@ -984,7 +986,6 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x12,
 			.mask = BIT(6),
 		},
-		.max_fifo_size = 512,
 		.id = {
 			{
 				.hw_id = ST_ASM330LHH_ID,
@@ -1119,6 +1120,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x3a,
 				.mask = GENMASK(9, 0),
 			},
+			.max_size = 512,
 			.th_wl = 1,
 		},
 		.ts_settings = {
@@ -1603,7 +1605,7 @@ int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int err;
 
-	if (val < 1 || val > hw->settings->max_fifo_size)
+	if (val < 1 || val > hw->settings->fifo_ops.max_size)
 		return -EINVAL;
 
 	mutex_lock(&hw->conf_lock);
-- 
2.31.1

