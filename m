Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51517CED78
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 22:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJGUb5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 16:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGUb5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 16:31:57 -0400
Received: from lore-desk.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EFEB2084D;
        Mon,  7 Oct 2019 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570480316;
        bh=M1b1J9Znt3WYpAd7hz3lM570r3/LPpr9PgNQi6gNn1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=GOA2wnv/lwBCQ+Rtlb8OwzOTtln5NNnKM7NgzHcHnUYoB4u2ZCML96ZtuHA/bJzAh
         aME0hwNjU/q7fE6EX2xGfwfnROfwkneaqW4tPdYtDrKpynlCeVe6mSHTB5jWlpGa5S
         A+UgUahLbrEZOEBrODmtMkd+YlVRU2VP3Mwl7vlw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: explicitly define odr table size
Date:   Mon,  7 Oct 2019 22:31:49 +0200
Message-Id: <c85fd7c8101bd56e6f589e5fb2e023f14768f2dd.1570480230.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce odr_len in st_lsm6dsx_odr_table_entry data structure in order
to explicitly define odr table size and support devices with different
odr table map

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 26 +++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 30fd274ea8ae..ff7519475478 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -111,7 +111,9 @@ struct st_lsm6dsx_odr {
 #define ST_LSM6DSX_ODR_LIST_SIZE	6
 struct st_lsm6dsx_odr_table_entry {
 	struct st_lsm6dsx_reg reg;
+
 	struct st_lsm6dsx_odr odr_avl[ST_LSM6DSX_ODR_LIST_SIZE];
+	int odr_len;
 };
 
 struct st_lsm6dsx_fs {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 740912bbf941..98a1fa8d1454 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -131,6 +131,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 238, 0x04 },
 				.odr_avl[4] = { 476, 0x05 },
 				.odr_avl[5] = { 952, 0x06 },
+				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -143,6 +144,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 238, 0x04 },
 				.odr_avl[4] = { 476, 0x05 },
 				.odr_avl[5] = { 952, 0x06 },
+				.odr_len = 6,
 			},
 		},
 		.fs_table = {
@@ -230,6 +232,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -242,6 +245,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 		},
 		.fs_table = {
@@ -394,6 +398,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -406,6 +411,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 		},
 		.fs_table = {
@@ -567,6 +573,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -579,6 +586,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 		},
 		.fs_table = {
@@ -738,6 +746,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -750,6 +759,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 		},
 		.fs_table = {
@@ -928,6 +938,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -940,6 +951,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 		},
 		.fs_table = {
@@ -1095,6 +1107,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
@@ -1107,6 +1120,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.odr_avl[3] = { 104, 0x04 },
 				.odr_avl[4] = { 208, 0x05 },
 				.odr_avl[5] = { 416, 0x06 },
+				.odr_len = 6,
 			},
 		},
 		.fs_table = {
@@ -1329,7 +1343,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
 	int i;
 
 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
-	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
+	for (i = 0; i < odr_table->odr_len; i++)
 		/*
 		 * ext devices can run at different odr respect to
 		 * accel sensor
@@ -1337,7 +1351,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
 		if (odr_table->odr_avl[i].hz >= odr)
 			break;
 
-	if (i == ST_LSM6DSX_ODR_LIST_SIZE)
+	if (i == odr_table->odr_len)
 		return -EINVAL;
 
 	*val = odr_table->odr_avl[i].val;
@@ -1688,13 +1702,13 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 					  char *buf)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
-	enum st_lsm6dsx_sensor_id id = sensor->id;
-	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_odr_table_entry *odr_table;
 	int i, len = 0;
 
-	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
+	odr_table = &sensor->hw->settings->odr_table[sensor->id];
+	for (i = 0; i < odr_table->odr_len; i++)
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
-				 hw->settings->odr_table[id].odr_avl[i].hz);
+				 odr_table->odr_avl[i].hz);
 	buf[len - 1] = '\n';
 
 	return len;
-- 
2.21.0

