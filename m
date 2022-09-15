Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB85BA06A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Sep 2022 19:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIORfP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Sep 2022 13:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIORfN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2022 13:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD98979C0;
        Thu, 15 Sep 2022 10:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F604625AE;
        Thu, 15 Sep 2022 17:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684E8C433D6;
        Thu, 15 Sep 2022 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663263310;
        bh=AbjFP12sx7PcbBqvtQfHbLrQWS+qhGCVHJkKoCajivI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTCW7uAIzRchSRSL6IKsNbLzIYfZLIn7UD8fyfz0+3shGRVh4gGV3JVVmQ8qUjU1z
         TeAVGlGYF3/hme0u4IV5UNEII24L36yZUOzs/al4qWXMo3077d9otWPnoIagwZW8Bj
         3ourjJXfWAWgqBjYVziwOgUEkVkwhDvnEeqepYkIS4cXcLNeet0DTKlUTJaP8YGDS+
         653pHzL8Sxss0GkyUHM0Z//ZiuBLOV8T0BzJjnL7IorvCpL2fWkCkwV/Dm/OlDAeOC
         jzbSubOANrbZXchGRyh8yP+tHngHmF7rny4ys6IY32iAbAhbAx4PpdcVbM04631VGW
         76iPR6aRlWzIg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to LSM6DSTX
Date:   Thu, 15 Sep 2022 19:34:59 +0200
Message-Id: <573a232b0f320b2ec92c56fa24393cfb275183fb.1663262890.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663262890.git.lorenzo@kernel.org>
References: <cover.1663262890.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM LSM6DSTX (acc + gyro) Mems sensor.
The LSM6DSTX sensor can use LSM6DST as fallback device since it
implements all the LSM6DSTX features currently implemented in
st_lsm6dsx.

Datasheet: https://www.st.com/resource/en/datasheet/lsm6dstx.pdf
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig             | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 7 ++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
 6 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index fefd0b939100..2ed2b3f40c0b 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -12,7 +12,7 @@ config IIO_ST_LSM6DSX
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
-	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop,
+	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
 	  the accelerometer/gyroscope of lsm9ds1 and lsm6dst.
 
 	  To compile this driver as a module, choose M here: the module
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index a86dd29a4738..6b57d47be69e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -32,6 +32,7 @@
 #define ST_LSM6DST_DEV_NAME	"lsm6dst"
 #define ST_LSM6DSOP_DEV_NAME	"lsm6dsop"
 #define ST_ASM330LHHX_DEV_NAME	"asm330lhhx"
+#define ST_LSM6DSTX_DEV_NAME	"lsm6dstx"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -51,6 +52,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DST_ID,
 	ST_LSM6DSOP_ID,
 	ST_ASM330LHHX_ID,
+	ST_LSM6DSTX_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index c7d3730ab1c5..e49f2d120ed3 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -15,7 +15,7 @@
  * value of the decimation factor and ODR set for each FIFO data set.
  *
  * LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/LSM6DSRX/ISM330DHCX/
- * LSM6DST/LSM6DSOP:
+ * LSM6DST/LSM6DSOP/LSM6DSTX:
  * The FIFO buffer can be configured to store data from gyroscope and
  * accelerometer. Each sample is queued with a tag (1B) indicating data
  * source (gyroscope, accelerometer, hw timer).
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b5e4a4113652..f8bbb005718e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -26,7 +26,8 @@
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 4KB
  *
- * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP:
+ * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP/
+ *   LSM6DSTX:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
@@ -791,6 +792,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.hw_id = ST_ASM330LHHX_ID,
 				.name = ST_ASM330LHHX_DEV_NAME,
 				.wai = 0x6b,
+			}, {
+				.hw_id = ST_LSM6DSTX_ID,
+				.name = ST_LSM6DSTX_DEV_NAME,
+				.wai = 0x6d,
 			},
 		},
 		.channels = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 2ea34c0d3a8c..307c8c436862 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -105,6 +105,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,asm330lhhx",
 		.data = (void *)ST_ASM330LHHX_ID,
 	},
+	{
+		.compatible = "st,lsm6dstx",
+		.data = (void *)ST_LSM6DSTX_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -127,6 +131,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
 	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
 	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
+	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 6a8883f022a8..6a4eecf4bb05 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -105,6 +105,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,asm330lhhx",
 		.data = (void *)ST_ASM330LHHX_ID,
 	},
+	{
+		.compatible = "st,lsm6dstx",
+		.data = (void *)ST_LSM6DSTX_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -127,6 +131,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
 	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
 	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
+	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.37.3

