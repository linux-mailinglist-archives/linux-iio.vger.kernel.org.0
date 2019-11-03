Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0DEED46B
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 20:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfKCTrt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 14:47:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfKCTrt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 14:47:49 -0500
Received: from localhost.localdomain (unknown [151.66.0.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F4021929;
        Sun,  3 Nov 2019 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572810467;
        bh=Hk1b540TESpTIzCvsRlMjbDrVVGWfyR1VsS6o6vjQEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IlJwi2cnMl/D9hc0g/1oPyrn/A/rJJfGiJ5MlgS5WN8FlnK22K08MRwmzuCKXoOI0
         YSGgyoKBGTqLR9A8nQsjQSbUOyZS421XzvU/Gol1OC+8KKrgBj2HimYfc8oPLMoq7M
         8omXPPt8m6lcCtR0N/4bmnquA/UIhCIZGra43S38=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, mario.tesi@st.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] iio: imu: st_lsm6dsx: express odr in mHZ
Date:   Sun,  3 Nov 2019 20:47:18 +0100
Message-Id: <2b3c301e7fc808e19c5ad04a34a3bf1fa301da3c.1572810064.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1572810064.git.lorenzo@kernel.org>
References: <cover.1572810064.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Express available frequencies in mHZ in order to support even
rational ODRs. This patch is need to fix an Android CTS failure

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   6 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   9 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 197 +++++++++---------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  31 +--
 4 files changed, 126 insertions(+), 117 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 9ffc8e06f73d..8ea969e1b72b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -106,7 +106,7 @@ struct st_lsm6dsx_sensor;
 struct st_lsm6dsx_hw;
 
 struct st_lsm6dsx_odr {
-	u16 hz;
+	u32 hz; /* expressed in mHZ */
 	u8 val;
 };
 
@@ -330,7 +330,7 @@ struct st_lsm6dsx_sensor {
 	struct st_lsm6dsx_hw *hw;
 
 	u32 gain;
-	u16 odr;
+	u32 odr;
 
 	u16 watermark;
 	u8 sip;
@@ -415,7 +415,7 @@ int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
 			     enum st_lsm6dsx_fifo_mode fifo_mode);
 int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
-int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val);
+int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
 int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name);
 int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 31cd90d2c60e..d416990ae309 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -91,7 +91,7 @@ static int st_lsm6dsx_get_decimator_val(u8 val)
 }
 
 static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
-				       u16 *max_odr, u16 *min_odr)
+				       u32 *max_odr, u32 *min_odr)
 {
 	struct st_lsm6dsx_sensor *sensor;
 	int i;
@@ -106,16 +106,17 @@ static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
-		*max_odr = max_t(u16, *max_odr, sensor->odr);
-		*min_odr = min_t(u16, *min_odr, sensor->odr);
+		*max_odr = max_t(u32, *max_odr, sensor->odr);
+		*min_odr = min_t(u32, *min_odr, sensor->odr);
 	}
 }
 
 static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
 {
-	u16 max_odr, min_odr, sip = 0, ts_sip = 0;
 	const struct st_lsm6dsx_reg *ts_dec_reg;
 	struct st_lsm6dsx_sensor *sensor;
+	u16 sip = 0, ts_sip = 0;
+	u32 max_odr, min_odr;
 	int err = 0, i;
 	u8 data;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2f9396745bc8..03e5cd0cfcba 100644
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
+				.odr_avl[0] = {  10000, 0x01 },
+				.odr_avl[1] = {  50000, 0x02 },
+				.odr_avl[2] = { 119000, 0x03 },
+				.odr_avl[3] = { 238000, 0x04 },
+				.odr_avl[4] = { 476000, 0x05 },
+				.odr_avl[5] = { 952000, 0x06 },
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
+				.odr_avl[0] = {  14900, 0x01 },
+				.odr_avl[1] = {  59500, 0x02 },
+				.odr_avl[2] = { 119000, 0x03 },
+				.odr_avl[3] = { 238000, 0x04 },
+				.odr_avl[4] = { 476000, 0x05 },
+				.odr_avl[5] = { 952000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
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
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
 				.odr_len = 6,
 			},
 		},
@@ -1358,7 +1358,7 @@ static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
 	return 0;
 }
 
-int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
+int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val)
 {
 	const struct st_lsm6dsx_odr_table_entry *odr_table;
 	int i;
@@ -1380,14 +1380,15 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
 	return odr_table->odr_avl[i].hz;
 }
 
-static u16 st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u16 odr,
-					   enum st_lsm6dsx_sensor_id id)
+static int
+st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u32 odr,
+				enum st_lsm6dsx_sensor_id id)
 {
 	struct st_lsm6dsx_sensor *ref = iio_priv(hw->iio_devs[id]);
 
 	if (odr > 0) {
 		if (hw->enable_mask & BIT(id))
-			return max_t(u16, ref->odr, odr);
+			return max_t(u32, ref->odr, odr);
 		else
 			return odr;
 	} else {
@@ -1395,7 +1396,8 @@ static u16 st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u16 odr,
 	}
 }
 
-static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 req_odr)
+static int
+st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
 {
 	struct st_lsm6dsx_sensor *ref_sensor = sensor;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
@@ -1409,7 +1411,7 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 req_odr)
 	case ST_LSM6DSX_ID_EXT1:
 	case ST_LSM6DSX_ID_EXT2:
 	case ST_LSM6DSX_ID_ACC: {
-		u16 odr;
+		u32 odr;
 		int i;
 
 		/*
@@ -1449,7 +1451,7 @@ int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 				 bool enable)
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
-	u16 odr = enable ? sensor->odr : 0;
+	u32 odr = enable ? sensor->odr : 0;
 	int err;
 
 	err = st_lsm6dsx_set_odr(sensor, odr);
@@ -1475,7 +1477,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	delay = 1000000 / sensor->odr;
+	delay = 1000000000 / sensor->odr;
 	usleep_range(delay, 2 * delay);
 
 	err = st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
@@ -1507,8 +1509,9 @@ static int st_lsm6dsx_read_raw(struct iio_dev *iio_dev,
 		iio_device_release_direct_mode(iio_dev);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = sensor->odr;
-		ret = IIO_VAL_INT;
+		*val = sensor->odr / 1000;
+		*val2 = (sensor->odr % 1000) * 1000;
+		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
@@ -1541,6 +1544,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		u8 data;
 
+		val = val * 1000 + val2 / 1000;
 		val = st_lsm6dsx_check_odr(sensor, val, &data);
 		if (val < 0)
 			err = val;
@@ -1730,8 +1734,9 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 
 	odr_table = &sensor->hw->settings->odr_table[sensor->id];
 	for (i = 0; i < odr_table->odr_len; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
-				 odr_table->odr_avl[i].hz);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
+				 odr_table->odr_avl[i].hz / 1000,
+				 odr_table->odr_avl[i].hz % 1000);
 	buf[len - 1] = '\n';
 
 	return len;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index e029cc05a17f..3a0cb71ce926 100644
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
+			.odr_avl[0] = {  10000, 0x0 },
+			.odr_avl[1] = {  20000, 0x1 },
+			.odr_avl[2] = {  50000, 0x2 },
+			.odr_avl[3] = { 100000, 0x3 },
 			.odr_len = 4,
 		},
 		.fs_table = {
@@ -94,11 +94,11 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
 static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
 {
 	struct st_lsm6dsx_sensor *sensor;
-	u16 odr;
+	u32 odr;
 
 	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
-	odr = (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 13;
-	msleep((2000U / odr) + 1);
+	odr = (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 12500;
+	msleep((2000000U / odr) + 1);
 }
 
 /**
@@ -318,7 +318,7 @@ st_lsm6dsx_shub_write_with_mask(struct st_lsm6dsx_sensor *sensor,
 
 static int
 st_lsm6dsx_shub_get_odr_val(struct st_lsm6dsx_sensor *sensor,
-			    u16 odr, u16 *val)
+			    u32 odr, u16 *val)
 {
 	const struct st_lsm6dsx_ext_dev_settings *settings;
 	int i;
@@ -337,7 +337,7 @@ st_lsm6dsx_shub_get_odr_val(struct st_lsm6dsx_sensor *sensor,
 }
 
 static int
-st_lsm6dsx_shub_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
+st_lsm6dsx_shub_set_odr(struct st_lsm6dsx_sensor *sensor, u32 odr)
 {
 	const struct st_lsm6dsx_ext_dev_settings *settings;
 	u16 val;
@@ -442,7 +442,7 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	delay = 1000000 / sensor->odr;
+	delay = 1000000000 / sensor->odr;
 	usleep_range(delay, 2 * delay);
 
 	len = min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
@@ -482,8 +482,9 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
 		iio_device_release_direct_mode(iio_dev);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = sensor->odr;
-		ret = IIO_VAL_INT;
+		*val = sensor->odr / 1000;
+		*val2 = (sensor->odr % 1000) * 1000;
+		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
@@ -514,6 +515,7 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		u16 data;
 
+		val = val * 1000 + val2 / 1000;
 		err = st_lsm6dsx_shub_get_odr_val(sensor, val, &data);
 		if (!err)
 			sensor->odr = val;
@@ -540,9 +542,10 @@ st_lsm6dsx_shub_sampling_freq_avail(struct device *dev,
 
 	settings = sensor->ext_info.settings;
 	for (i = 0; i < settings->odr_table.odr_len; i++) {
-		u16 val = settings->odr_table.odr_avl[i].hz;
+		u32 val = settings->odr_table.odr_avl[i].hz;
 
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", val);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
+				 val / 1000, val % 1000);
 	}
 	buf[len - 1] = '\n';
 
-- 
2.21.0

