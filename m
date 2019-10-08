Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328DACF93A
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfJHMFi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 08:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbfJHMFh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Oct 2019 08:05:37 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B097206C2;
        Tue,  8 Oct 2019 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570536337;
        bh=xVqQPQ5lGscGg6K1pbOrh1rz7ImTJ0a2g05nsYqKMeQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kGh5R+UNECbH8E7eQdhNPme158T7j7tApiT0Xu/uRE8zX3DHTwettpOJG9W9PVlP6
         TQ0HjE/gfwGJ36GY/1RM5nw9dCORkzK0+j1ipcSIW7QX3y84xaiWj6iu+51PdRNG7R
         WjeiFTk6XgqQ18FTaDjSVg6/kf9xvdh3kInQs+Kk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, mario.tesi@st.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: enable drdy-mask if available
Date:   Tue,  8 Oct 2019 14:05:02 +0200
Message-Id: <3b163aa88b7f0090f3aadd377c08d344cd689ed1.1570536208.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable drdy mask if available in order to mark invalid samples during
sensor bootstrap phase

Tested-by: Mario Tesi <mario.tesi@st.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 ++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  6 ++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 21 +++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 36b3d67ce470..1b2ea4b6f472 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -251,6 +251,7 @@ struct st_lsm6dsx_ext_dev_settings {
  * @id: List of hw id/device name supported by the driver configuration.
  * @channels: IIO channels supported by the device.
  * @irq_config: interrupts related registers.
+ * @drdy_mask: register info for data-ready mask (addr + mask).
  * @odr_table: Hw sensors odr table (Hz + val).
  * @fs_table: Hw sensors gain table (gain + val).
  * @decimator: List of decimator register info (addr + mask).
@@ -283,6 +284,7 @@ struct st_lsm6dsx_settings {
 		struct st_lsm6dsx_reg hla;
 		struct st_lsm6dsx_reg od;
 	} irq_config;
+	struct st_lsm6dsx_reg drdy_mask;
 	struct st_lsm6dsx_odr_table_entry odr_table[2];
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index d7cacb9a0182..ffeb2596b97b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -449,13 +449,19 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	return read_len;
 }
 
+#define ST_LSM6DSX_INVALID_SAMPLE	0x7ffd
 static int
 st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
 			    u8 *data, s64 ts)
 {
+	s16 val = le16_to_cpu(*(__le16 *)data);
 	struct st_lsm6dsx_sensor *sensor;
 	struct iio_dev *iio_dev;
 
+	/* invalid sample during bootstrap phase */
+	if (val >= ST_LSM6DSX_INVALID_SAMPLE)
+		return -EINVAL;
+
 	/*
 	 * EXT_TAG are managed in FIFO fashion so ST_LSM6DSX_EXT0_TAG
 	 * corresponds to the first enabled channel, ST_LSM6DSX_EXT1_TAG
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index f5694636819f..6d1cf7c5d600 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -736,6 +736,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
 			},
 		},
+		.drdy_mask = {
+			.addr = 0x13,
+			.mask = BIT(3),
+		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.reg = {
@@ -929,6 +933,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
 			},
 		},
+		.drdy_mask = {
+			.addr = 0x13,
+			.mask = BIT(3),
+		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.reg = {
@@ -1099,6 +1107,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
 			},
 		},
+		.drdy_mask = {
+			.addr = 0x13,
+			.mask = BIT(3),
+		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
 				.reg = {
@@ -1983,6 +1995,15 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 		}
 	}
 
+	/* enable drdy-mas if available */
+	if (hw->settings->drdy_mask.addr) {
+		reg = &hw->settings->drdy_mask;
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
+		if (err < 0)
+			return err;
+	}
+
 	err = st_lsm6dsx_init_shub(hw);
 	if (err < 0)
 		return err;
-- 
2.21.0

