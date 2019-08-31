Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43531A443C
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2019 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfHaLSd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Aug 2019 07:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfHaLSd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Aug 2019 07:18:33 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.4.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEEF22CE9;
        Sat, 31 Aug 2019 11:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567250311;
        bh=TRewTE6s1uGyxLzysRknzdKJ4nBsjSm9PtWkWmTHLkE=;
        h=From:To:Cc:Subject:Date:From;
        b=jngkiNXbLZgAUbLji6aO1bAFgNx6YBn2ydNI0uZfbQz/iPyA/Zf5bCDndkLlZJSVu
         tVY0GkkTw3bb9AYE1f64qXdP1ingoimDlQYbEOYBaeUcdVBeoAMPZFBkPDbyfD8i3T
         +O3xiQFSV/So33zfGridY00MtLyPF3eUyOZRaorY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: forbid 0 sensor sensitivity
Date:   Sat, 31 Aug 2019 13:18:22 +0200
Message-Id: <012b091d36c0d04b136d9543dc6763db6345b66e.1567250140.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Do not allow configuring null sensor gain since it will force to 0
device outputs

Fixes: c8d4066c7246 ("iio: imu: st_lsm6dsx: remove invalid gain value for LSM9DS1")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 28 +++++++++++++-------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 11 +++-----
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 5e3cd96b0059..92d318b27fcd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -99,7 +99,9 @@ struct st_lsm6dsx_fs {
 #define ST_LSM6DSX_FS_LIST_SIZE		4
 struct st_lsm6dsx_fs_table_entry {
 	struct st_lsm6dsx_reg reg;
+
 	struct st_lsm6dsx_fs fs_avl[ST_LSM6DSX_FS_LIST_SIZE];
+	int fs_len;
 };
 
 /**
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2d3495560136..fd5ebe1e1594 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -145,6 +145,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] = { IIO_G_TO_M_S_2(732), 0x1 },
+				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -154,6 +155,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(245), 0x0 },
 				.fs_avl[1] = {  IIO_DEGREE_TO_RAD(500), 0x1 },
 				.fs_avl[2] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
+				.fs_len = 3,
 			},
 		},
 	},
@@ -215,6 +217,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -225,6 +228,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_len = 4,
 			},
 		},
 		.decimator = {
@@ -327,6 +331,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -337,6 +342,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_len = 4,
 			},
 		},
 		.decimator = {
@@ -448,6 +454,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -458,6 +465,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_len = 4,
 			},
 		},
 		.decimator = {
@@ -563,6 +571,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -573,6 +582,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_len = 4,
 			},
 		},
 		.batch = {
@@ -693,6 +703,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -703,6 +714,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_len = 4,
 			},
 		},
 		.batch = {
@@ -800,6 +812,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
 				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
 				.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
+				.fs_len = 4,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -810,6 +823,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
 				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
 				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
+				.fs_len = 4,
 			},
 		},
 		.batch = {
@@ -933,11 +947,12 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
 	int i, err;
 
 	fs_table = &sensor->hw->settings->fs_table[sensor->id];
-	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
+	for (i = 0; i < fs_table->fs_len; i++) {
 		if (fs_table->fs_avl[i].gain == gain)
 			break;
+	}
 
-	if (i == ST_LSM6DSX_FS_LIST_SIZE)
+	if (i == fs_table->fs_len)
 		return -EINVAL;
 
 	data = ST_LSM6DSX_SHIFT_VAL(fs_table->fs_avl[i].val,
@@ -1196,18 +1211,13 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
 	const struct st_lsm6dsx_fs_table_entry *fs_table;
-	enum st_lsm6dsx_sensor_id id = sensor->id;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int i, len = 0;
 
-	fs_table = &hw->settings->fs_table[id];
-	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++) {
-		if (!fs_table->fs_avl[i].gain)
-			break;
-
+	fs_table = &hw->settings->fs_table[sensor->id];
+	for (i = 0; i < fs_table->fs_len; i++)
 		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
 				 fs_table->fs_avl[i].gain);
-	}
 	buf[len - 1] = '\n';
 
 	return len;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 66fbcd94642d..f5fca2171954 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -61,6 +61,7 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
 				.gain = 1500,
 				.val = 0x0,
 			}, /* 1500 uG/LSB */
+			.fs_len = 1,
 		},
 		.temp_comp = {
 			.addr = 0x60,
@@ -555,13 +556,9 @@ static ssize_t st_lsm6dsx_shub_scale_avail(struct device *dev,
 	int i, len = 0;
 
 	settings = sensor->ext_info.settings;
-	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++) {
-		u16 val = settings->fs_table.fs_avl[i].gain;
-
-		if (val > 0)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
-					 val);
-	}
+	for (i = 0; i < settings->fs_table.fs_len; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
+				 settings->fs_table.fs_avl[i].gain);
 	buf[len - 1] = '\n';
 
 	return len;
-- 
2.21.0

