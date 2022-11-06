Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4761E298
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 15:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiKFOhV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 09:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKFOhU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 09:37:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42058DEB8;
        Sun,  6 Nov 2022 06:37:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9DFE60BB8;
        Sun,  6 Nov 2022 14:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B4CC433D6;
        Sun,  6 Nov 2022 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667745438;
        bh=4i5/oO2DnQdiX65Xd954AyBD/QCyBR/0pcEc9LquQh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4LtARYdQ0J/7ka2GxmrWiD0G0ANrvgf8/a3zEc+52pRj/wCWB0yucVrwUQtTf8oL
         +8qgDJIBRshqHSyj1Z63B6rGz/jzOBp9/cZtn6+I+8quqfNPf+TUu0LM3r/gB/7ENW
         VM9zR4D7FSX4xQ/+WH9tNN68NYMRTY8ibq4L6H/my2RfKWgfYHiviIhUP7bHgqOocy
         NGStsNigH9H9NdSOxz5dCFZr4uVsbECvI/QYdzbsmETuXFIyzTQYNLnnJEQbCkmtUU
         tzYIBDOBnVI0aXcHNDVuj/3A7yj80tDABTrd6O3+GxMI5pAxOu/kvFftfq3dB0bcIp
         CiI2/sjGS1kqg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to LSM6DSV16X
Date:   Sun,  6 Nov 2022 15:36:53 +0100
Message-Id: <284b251f861dff30c399e5736a843c8e3a497249.1667745215.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667745215.git.lorenzo@kernel.org>
References: <cover.1667745215.git.lorenzo@kernel.org>
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

Add support to STM LSM6DSV16X (accelerometer and gyroscope) Mems sensor.
The LSM6DSV16X sensor can use LSM6DSV as fallback device since it
implements all the LSM6DSV16X features currently implemented in
st_lsm6dsx.

Datasheet: https://www.st.com/resource/en/datasheet/lsm6dsv16x.pdf
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig           | 3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  | 5 +++++
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 1c68bac94bce..37d02e0fc227 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -13,7 +13,8 @@ config IIO_ST_LSM6DSX
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
 	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
-	  lsm6dsv, the accelerometer/gyroscope of lsm9ds1 and lsm6dst.
+	  lsm6dsv, lsm6dsv16x, the accelerometer/gyroscope of lsm9ds1
+	  and lsm6dst.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index ab61895cf072..683cfadcf62e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -34,6 +34,7 @@
 #define ST_ASM330LHHX_DEV_NAME	"asm330lhhx"
 #define ST_LSM6DSTX_DEV_NAME	"lsm6dstx"
 #define ST_LSM6DSV_DEV_NAME	"lsm6dsv"
+#define ST_LSM6DSV16X_DEV_NAME	"lsm6dsv16x"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -55,6 +56,7 @@ enum st_lsm6dsx_hw_id {
 	ST_ASM330LHHX_ID,
 	ST_LSM6DSTX_ID,
 	ST_LSM6DSV_ID,
+	ST_LSM6DSV16X_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 5e716a5071fd..acb6101aec5d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -27,7 +27,7 @@
  *   - FIFO size: 4KB
  *
  * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP/
- *   LSM6DSTX:
+ *   LSM6DSTX/LSM6DSV/LSM6DSV16X:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
@@ -1180,6 +1180,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.hw_id = ST_LSM6DSV_ID,
 				.name = ST_LSM6DSV_DEV_NAME,
 				.wai = 0x70,
+			}, {
+				.hw_id = ST_LSM6DSV16X_ID,
+				.name = ST_LSM6DSV16X_DEV_NAME,
+				.wai = 0x70,
 			},
 		},
 		.channels = {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 239c8920a31f..0faf1b4c11af 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -113,6 +113,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm6dsv",
 		.data = (void *)ST_LSM6DSV_ID,
 	},
+	{
+		.compatible = "st,lsm6dsv16x",
+		.data = (void *)ST_LSM6DSV16X_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -137,6 +141,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
 	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
 	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
+	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 66705ef16ed0..57597aaa2a92 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -113,6 +113,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm6dsv",
 		.data = (void *)ST_LSM6DSV_ID,
 	},
+	{
+		.compatible = "st,lsm6dsv16x",
+		.data = (void *)ST_LSM6DSV16X_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -137,6 +141,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
 	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
 	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
+	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.38.1

