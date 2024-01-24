Return-Path: <linux-iio+bounces-1889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0D083A73A
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jan 2024 11:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31511C21B9E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jan 2024 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F293E199DC;
	Wed, 24 Jan 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME8pA0DZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC84199AB;
	Wed, 24 Jan 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093565; cv=none; b=aPPGh8arikC71x4poraOjHugZnQcNfmYE2VD4ncTMeIe7fcswBRut1wb/jfla7Y61Gs8S+bCVEg3wftrJRJCXfbIovUgCJ9GCEJC6PCt9iN2eAsHvFJptMNd3ppCHfoRNUARVijOXebq4ZGm9JW2k5WHCFB7Fza9WnxMMkAaeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093565; c=relaxed/simple;
	bh=7cDEgL9V45/CMsRG42fV1Tz5gt3iQyKlD3KZvXJAVqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sg7v5mcf4tEwo9pRAjR56bgw0ruOFW55YBDtd40YPchBD2EwQZWQUZwH1rT2dvxwySbsm1y2Z46fmS+tC6raz0W6py78/a2d4Bq3ip21h6BMQtNWLzKmmJEjNtshXNgKL50vCG1A632/vru0F1sFuaD6FMpdJjDJlxJnr8Ta98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME8pA0DZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF44FC43390;
	Wed, 24 Jan 2024 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706093565;
	bh=7cDEgL9V45/CMsRG42fV1Tz5gt3iQyKlD3KZvXJAVqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ME8pA0DZgjKZs87wLCjxjxckuD4mXERHpZ+prDpPXvisViNC1rpSilJRVNwYT4ANh
	 E1ugWi/0Ta5LlVnMeXvTgI+bnst0GMVz+kFy4v1zb3ZwyjmzEDStyogLK38wz6m6pH
	 seLp+dPb8sXYtdvV7owNShFCnYq25Rxr5TGhuqq6rg1/GauMUV8oXjuryLc4PPln5f
	 QB2wFUZ0bNrYTYDT4VO7EBID5CI6hXsrTcQAktSINsrFe3/mitcEHG4imurNzImi8F
	 4m0JCk9qDAYrulje0hPDFKoOO/odW5VjdzKwW6L5JsAzfFfvuwkWlvAFY1OieSAvaJ
	 Sy9EhLGxkDcqg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
Date: Wed, 24 Jan 2024 11:52:33 +0100
Message-ID: <eda2aac7da048e4ef1e1ea659ed4993f424ac810.1706093274.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706093274.git.lorenzo@kernel.org>
References: <cover.1706093274.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to STM ASM330LHHXG1 (accelerometer and gyroscope) Mems
sensor.
The ASM330LHHXG1 sensor can use ASM330LHHX as fallback device since it
implements all the ASM330LHHXG1 features currently implemented in
st_lsm6dsx.

Link: https://www.st.com/resource/en/datasheet/asm330lhhxg1.pdf
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig            |  4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 48 ++++++++++---------
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  6 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 ++
 6 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 5865a295a4df..645039edd606 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -14,8 +14,8 @@ config IIO_ST_LSM6DSX
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
 	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
-	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, lsm6dst
-	  and the accelerometer/gyroscope of lsm9ds1.
+	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, asm330lhhxg1,
+	  lsm6dst and the accelerometer/gyroscope of lsm9ds1.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c19237717e81..78d12d3c2759 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -15,29 +15,30 @@
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
 
-#define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
-#define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
-#define ST_LSM6DSL_DEV_NAME	"lsm6dsl"
-#define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
-#define ST_ISM330DLC_DEV_NAME	"ism330dlc"
-#define ST_LSM6DSO_DEV_NAME	"lsm6dso"
-#define ST_ASM330LHH_DEV_NAME	"asm330lhh"
-#define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
-#define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
-#define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
-#define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
-#define ST_LSM9DS1_DEV_NAME	"lsm9ds1-imu"
-#define ST_LSM6DS0_DEV_NAME	"lsm6ds0"
-#define ST_LSM6DSRX_DEV_NAME	"lsm6dsrx"
-#define ST_LSM6DST_DEV_NAME	"lsm6dst"
-#define ST_LSM6DSOP_DEV_NAME	"lsm6dsop"
-#define ST_ASM330LHHX_DEV_NAME	"asm330lhhx"
-#define ST_LSM6DSTX_DEV_NAME	"lsm6dstx"
-#define ST_LSM6DSV_DEV_NAME	"lsm6dsv"
-#define ST_LSM6DSV16X_DEV_NAME	"lsm6dsv16x"
-#define ST_LSM6DSO16IS_DEV_NAME	"lsm6dso16is"
-#define ST_ISM330IS_DEV_NAME	"ism330is"
-#define ST_ASM330LHB_DEV_NAME	"asm330lhb"
+#define ST_LSM6DS3_DEV_NAME		"lsm6ds3"
+#define ST_LSM6DS3H_DEV_NAME		"lsm6ds3h"
+#define ST_LSM6DSL_DEV_NAME		"lsm6dsl"
+#define ST_LSM6DSM_DEV_NAME		"lsm6dsm"
+#define ST_ISM330DLC_DEV_NAME		"ism330dlc"
+#define ST_LSM6DSO_DEV_NAME		"lsm6dso"
+#define ST_ASM330LHH_DEV_NAME		"asm330lhh"
+#define ST_LSM6DSOX_DEV_NAME		"lsm6dsox"
+#define ST_LSM6DSR_DEV_NAME		"lsm6dsr"
+#define ST_LSM6DS3TRC_DEV_NAME		"lsm6ds3tr-c"
+#define ST_ISM330DHCX_DEV_NAME		"ism330dhcx"
+#define ST_LSM9DS1_DEV_NAME		"lsm9ds1-imu"
+#define ST_LSM6DS0_DEV_NAME		"lsm6ds0"
+#define ST_LSM6DSRX_DEV_NAME		"lsm6dsrx"
+#define ST_LSM6DST_DEV_NAME		"lsm6dst"
+#define ST_LSM6DSOP_DEV_NAME		"lsm6dsop"
+#define ST_ASM330LHHX_DEV_NAME		"asm330lhhx"
+#define ST_LSM6DSTX_DEV_NAME		"lsm6dstx"
+#define ST_LSM6DSV_DEV_NAME		"lsm6dsv"
+#define ST_LSM6DSV16X_DEV_NAME		"lsm6dsv16x"
+#define ST_LSM6DSO16IS_DEV_NAME		"lsm6dso16is"
+#define ST_ISM330IS_DEV_NAME		"ism330is"
+#define ST_ASM330LHB_DEV_NAME		"asm330lhb"
+#define ST_ASM330LHHXG1_DEV_NAME	"asm330lhhxg1"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID = 1,
@@ -63,6 +64,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DSO16IS_ID,
 	ST_ISM330IS_ID,
 	ST_ASM330LHB_ID,
+	ST_ASM330LHHXG1_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 066fe561c5e8..5d9539822ec6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -15,7 +15,7 @@
  * value of the decimation factor and ODR set for each FIFO data set.
  *
  * LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/LSM6DSRX/ISM330DHCX/
- * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV/ASM330LHB:
+ * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV/ASM330LHB/ASM330LHHXG1:
  * The FIFO buffer can be configured to store data from gyroscope and
  * accelerometer. Each sample is queued with a tag (1B) indicating data
  * source (gyroscope, accelerometer, hw timer).
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b6e6b1df8a61..27ecf2a5d0bc 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -27,7 +27,7 @@
  *   - FIFO size: 4KB
  *
  * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP/
- *   LSM6DSTX/LSM6DSO16IS/ISM330IS:
+ *   LSM6DSTX/LSM6DSO16IS/ISM330IS/ASM330LHHXG1:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
@@ -820,6 +820,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.hw_id = ST_ASM330LHHX_ID,
 				.name = ST_ASM330LHHX_DEV_NAME,
 				.wai = 0x6b,
+			}, {
+				.hw_id = ST_ASM330LHHXG1_ID,
+				.name = ST_ASM330LHHXG1_DEV_NAME,
+				.wai = 0x6b,
 			}, {
 				.hw_id = ST_LSM6DSTX_ID,
 				.name = ST_LSM6DSTX_DEV_NAME,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 911444ec57c0..cddf41cc0ca9 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -134,6 +134,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,asm330lhb",
 		.data = (void *)ST_ASM330LHB_ID,
 	},
+	{
+		.compatible = "st,asm330lhhxg1",
+		.data = (void *)ST_ASM330LHHXG1_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -168,6 +172,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
 	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
 	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
+	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index f56c170c41a9..c122c8831365 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -129,6 +129,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,asm330lhb",
 		.data = (void *)ST_ASM330LHB_ID,
 	},
+	{
+		.compatible = "st,asm330lhhxg1",
+		.data = (void *)ST_ASM330LHHXG1_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -157,6 +161,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
 	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
 	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
+	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.43.0


