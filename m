Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD9E6512
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 20:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfJ0TVn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 15:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfJ0TVn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 15:21:43 -0400
Received: from localhost.localdomain (unknown [151.66.57.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D60120B7C;
        Sun, 27 Oct 2019 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572204102;
        bh=7JzrIUbEfDfJG8tuOVH8l2+DQLipNF/G/v9V4fflR2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BM/Im19+aTjx3N+jre+gatUEEeQ+8dyA8kg6cBIBf8PPMe6a1Afa6C9dHzqqmXvAC
         ON5xJq02KrEhZ42/zzTNnGE9j610FiOtkawWv4/kQ9yc2jhJ66owu74he2UDfWCVFC
         Vos2kXcRqCkvhAvRZGcC1K8/dbCCUFzkGApkwBeA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: express odr in HZ / 10
Date:   Sun, 27 Oct 2019 20:21:24 +0100
Message-Id: <3d1ffc5fd083dcbd007872e5e8f5261faac69503.1572203759.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1572203759.git.lorenzo@kernel.org>
References: <cover.1572203759.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Express available frequencies in HZ / 10 in order to support even
rational ODRs. This patch is need to fix an Android CTS failure

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 181 ++++++++++---------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  23 ++-
 3 files changed, 106 insertions(+), 100 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 9ffc8e06f73d..b32c6389f47b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -106,7 +106,7 @@ struct st_lsm6dsx_sensor;
 struct st_lsm6dsx_hw;
 
 struct st_lsm6dsx_odr {
-	u16 hz;
+	u16 hz; /* expressed in HZ / 10 */
 	u8 val;
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2f9396745bc8..63e113725499 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -127,12 +127,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x20,
 					.mask = GENMASK(7, 5),
 				},
-				.odr_avl[0] = {  10, 0x01 },
-				.odr_avl[1] = {  50, 0x02 },
-				.odr_avl[2] = { 119, 0x03 },
-				.odr_avl[3] = { 238, 0x04 },
-				.odr_avl[4] = { 476, 0x05 },
-				.odr_avl[5] = { 952, 0x06 },
+				.odr_avl[0] = {  100, 0x01 },
+				.odr_avl[1] = {  500, 0x02 },
+				.odr_avl[2] = { 1190, 0x03 },
+				.odr_avl[3] = { 2380, 0x04 },
+				.odr_avl[4] = { 4760, 0x05 },
+				.odr_avl[5] = { 9520, 0x06 },
 				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -140,12 +140,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(7, 5),
 				},
-				.odr_avl[0] = {  15, 0x01 },
-				.odr_avl[1] = {  60, 0x02 },
-				.odr_avl[2] = { 119, 0x03 },
-				.odr_avl[3] = { 238, 0x04 },
-				.odr_avl[4] = { 476, 0x05 },
-				.odr_avl[5] = { 952, 0x06 },
+				.odr_avl[0] = {  149, 0x01 },
+				.odr_avl[1] = {  595, 0x02 },
+				.odr_avl[2] = { 1190, 0x03 },
+				.odr_avl[3] = { 2380, 0x04 },
+				.odr_avl[4] = { 4760, 0x05 },
+				.odr_avl[5] = { 9520, 0x06 },
 				.odr_len = 6,
 			},
 		},
@@ -229,12 +229,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -242,12 +242,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 		},
@@ -395,12 +395,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -408,12 +408,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 		},
@@ -570,12 +570,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -583,12 +583,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 		},
@@ -747,12 +747,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -760,12 +760,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 		},
@@ -944,12 +944,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -957,12 +957,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 		},
@@ -1121,12 +1121,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
@@ -1134,12 +1134,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x11,
 					.mask = GENMASK(7, 4),
 				},
-				.odr_avl[0] = {  13, 0x01 },
-				.odr_avl[1] = {  26, 0x02 },
-				.odr_avl[2] = {  52, 0x03 },
-				.odr_avl[3] = { 104, 0x04 },
-				.odr_avl[4] = { 208, 0x05 },
-				.odr_avl[5] = { 416, 0x06 },
+				.odr_avl[0] = {  125, 0x01 },
+				.odr_avl[1] = {  260, 0x02 },
+				.odr_avl[2] = {  520, 0x03 },
+				.odr_avl[3] = { 1040, 0x04 },
+				.odr_avl[4] = { 2080, 0x05 },
+				.odr_avl[5] = { 4160, 0x06 },
 				.odr_len = 6,
 			},
 		},
@@ -1475,7 +1475,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	delay = 1000000 / sensor->odr;
+	delay = 10000000 / sensor->odr;
 	usleep_range(delay, 2 * delay);
 
 	err = st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
@@ -1507,8 +1507,9 @@ static int st_lsm6dsx_read_raw(struct iio_dev *iio_dev,
 		iio_device_release_direct_mode(iio_dev);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = sensor->odr;
-		ret = IIO_VAL_INT;
+		*val = sensor->odr / 10;
+		*val2 = (sensor->odr % 10) * 100000;
+		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
@@ -1541,6 +1542,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		u8 data;
 
+		val = val * 10 + val2 / 100000;
 		val = st_lsm6dsx_check_odr(sensor, val, &data);
 		if (val < 0)
 			err = val;
@@ -1730,8 +1732,9 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 
 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < odr_table->odr_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
-				 odr_table->odr_avl[i].hz);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%d ",
+				 odr_table->odr_avl[i].hz / 10,
+				 odr_table->odr_avl[i].hz % 10);
 	buf[len - 1] = '\n';
 
 	return len;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index e029cc05a17f..c3b124a73815 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -51,10 +51,10 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
 				.addr = 0x60,
 				.mask = GENMASK(3, 2),
 			},
-			.odr_avl[0] = {  10, 0x0 },
-			.odr_avl[1] = {  20, 0x1 },
-			.odr_avl[2] = {  50, 0x2 },
-			.odr_avl[3] = { 100, 0x3 },
+			.odr_avl[0] = {  100, 0x0 },
+			.odr_avl[1] = {  200, 0x1 },
+			.odr_avl[2] = {  500, 0x2 },
+			.odr_avl[3] = { 1000, 0x3 },
 			.odr_len = 4,
 		},
 		.fs_table = {
@@ -97,8 +97,8 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
 	u16 odr;
 
 	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
-	odr = (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 13;
-	msleep((2000U / odr) + 1);
+	odr = (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 125;
+	msleep((20000U / odr) + 1);
 }
 
 /**
@@ -442,7 +442,7 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	delay = 1000000 / sensor->odr;
+	delay = 10000000 / sensor->odr;
 	usleep_range(delay, 2 * delay);
 
 	len = min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
@@ -482,8 +482,9 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
 		iio_device_release_direct_mode(iio_dev);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = sensor->odr;
-		ret = IIO_VAL_INT;
+		*val = sensor->odr / 10;
+		*val2 = (sensor->odr % 10) * 100000;
+		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
@@ -514,6 +515,7 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		u16 data;
 
+		val = val * 10 + val2 / 100000;
 		err = st_lsm6dsx_shub_get_odr_val(sensor, val, &data);
 		if (!err)
 			sensor->odr = val;
@@ -542,7 +544,8 @@ st_lsm6dsx_shub_sampling_freq_avail(struct device *dev,
 	for (i = 0; i < settings->odr_table.odr_len; i++) {
 		u16 val = settings->odr_table.odr_avl[i].hz;
 
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", val);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%d ",
+				 val / 10, val % 10);
 	}
 	buf[len - 1] = '\n';
 
-- 
2.21.0

