Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827CB62BFB6
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 14:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiKPNkc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 08:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiKPNkY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 08:40:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E71C317D1;
        Wed, 16 Nov 2022 05:40:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0A1261DF8;
        Wed, 16 Nov 2022 13:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77C1C433D6;
        Wed, 16 Nov 2022 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668606022;
        bh=DVknX3WbfzTopzdi/HiySfgBZWzKFf7LMZ06y7nuN0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLS3m+khqvlB9fX9epRRCg2CXXeTdjnac1uc4zEliAXzpj8lVPJFryk7YBU2N0Hnc
         gbOFuhIpQV2v/fYx0GFYDY+lZMDnLITunBup45mDIluT25b1kWqAFL4cbuz0dHLQhc
         u+7T5t9EkFRedfdciwW9hS9i2pyY6zWIxHLSfQ34F1urm1T7uQwt1zJfrMIe3OOILz
         GpXJ0a5lOBdL+TM+O8m2DrhvSeX40tEcwDRznqqazObMXFzwZxhSUOvSo97ABHhCpU
         QIsHK0Wdtfe9pERQlVgiKwNOG9B3+0HEmQiPLotl1A3dw4UKMBXb+DjmwTtjDOwV2u
         NZnZ47Uqdkq3Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     mario.tesi@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to LSM6DSO16IS
Date:   Wed, 16 Nov 2022 14:40:03 +0100
Message-Id: <df6a9d4653cd69f7204190f8b6a9b618fd48bd23.1668605631.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668605631.git.lorenzo@kernel.org>
References: <cover.1668605631.git.lorenzo@kernel.org>
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

Add support to STM LSM6DSO16IS (accelerometer and gyroscope) Mems sensor.

Datasheet: https://www.st.com/resource/en/datasheet/lsm6dso16is.pdf
Tested-by: Mario Tesi <mario.tesi@st.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig           |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 128 ++++++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |   5 +
 5 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 37d02e0fc227..0096035728cd 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -13,8 +13,8 @@ config IIO_ST_LSM6DSX
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
 	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
-	  lsm6dsv, lsm6dsv16x, the accelerometer/gyroscope of lsm9ds1
-	  and lsm6dst.
+	  lsm6dsv, lsm6dsv16x, lsm6dso16is, the accelerometer/gyroscope
+	  of lsm9ds1 and lsm6dst.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 683cfadcf62e..abf14a2ce0e9 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -35,6 +35,7 @@
 #define ST_LSM6DSTX_DEV_NAME	"lsm6dstx"
 #define ST_LSM6DSV_DEV_NAME	"lsm6dsv"
 #define ST_LSM6DSV16X_DEV_NAME	"lsm6dsv16x"
+#define ST_LSM6DSO16IS_DEV_NAME	"lsm6dso16is"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -57,6 +58,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DSTX_ID,
 	ST_LSM6DSV_ID,
 	ST_LSM6DSV16X_ID,
+	ST_LSM6DSO16IS_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b680682f9833..57a79bf35bba 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -27,7 +27,7 @@
  *   - FIFO size: 4KB
  *
  * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP/
- *   LSM6DSTX:
+ *   LSM6DSTX/LSM6DSO16IS:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
@@ -1375,6 +1375,132 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.wakeup_src_x_mask = BIT(2),
 		},
 	},
+	{
+		.reset = {
+			.addr = 0x12,
+			.mask = BIT(0),
+		},
+		.boot = {
+			.addr = 0x12,
+			.mask = BIT(7),
+		},
+		.bdu = {
+			.addr = 0x12,
+			.mask = BIT(6),
+		},
+		.id = {
+			{
+				.hw_id = ST_LSM6DSO16IS_ID,
+				.name = ST_LSM6DSO16IS_DEV_NAME,
+				.wai = 0x22,
+			},
+		},
+		.channels = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.chan = st_lsm6dsx_acc_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.chan = st_lsm6dsx_gyro_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
+			},
+		},
+		.odr_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
+				.odr_avl[6] = { 833000, 0x07 },
+				.odr_len = 7,
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(7, 4),
+				},
+				.odr_avl[0] = {  12500, 0x01 },
+				.odr_avl[1] = {  26000, 0x02 },
+				.odr_avl[2] = {  52000, 0x03 },
+				.odr_avl[3] = { 104000, 0x04 },
+				.odr_avl[4] = { 208000, 0x05 },
+				.odr_avl[5] = { 416000, 0x06 },
+				.odr_avl[6] = { 833000, 0x07 },
+				.odr_len = 7,
+			},
+		},
+		.fs_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x1 },
+				.fs_len = 4,
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(3, 2),
+				},
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x3 },
+				.fs_len = 4,
+			},
+		},
+		.irq_config = {
+			.hla = {
+				.addr = 0x12,
+				.mask = BIT(5),
+			},
+			.od = {
+				.addr = 0x12,
+				.mask = BIT(4),
+			},
+		},
+		.shub_settings = {
+			.page_mux = {
+				.addr = 0x01,
+				.mask = BIT(6),
+			},
+			.master_en = {
+				.sec_page = true,
+				.addr = 0x14,
+				.mask = BIT(2),
+			},
+			.pullup_en = {
+				.sec_page = true,
+				.addr = 0x14,
+				.mask = BIT(3),
+			},
+			.aux_sens = {
+				.addr = 0x14,
+				.mask = GENMASK(1, 0),
+			},
+			.wr_once = {
+				.addr = 0x14,
+				.mask = BIT(6),
+			},
+			.num_ext_dev = 3,
+			.shub_out = {
+				.sec_page = true,
+				.addr = 0x02,
+			},
+			.slv0_addr = 0x15,
+			.dw_slv0_addr = 0x21,
+		},
+	},
 };
 
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 0faf1b4c11af..d5929c6e4c5f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -117,6 +117,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm6dsv16x",
 		.data = (void *)ST_LSM6DSV16X_ID,
 	},
+	{
+		.compatible = "st,lsm6dso16is",
+		.data = (void *)ST_LSM6DSO16IS_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -142,6 +146,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
 	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
 	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
+	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 57597aaa2a92..24d5e51a8662 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -117,6 +117,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm6dsv16x",
 		.data = (void *)ST_LSM6DSV16X_ID,
 	},
+	{
+		.compatible = "st,lsm6dso16is",
+		.data = (void *)ST_LSM6DSO16IS_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -142,6 +146,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
 	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
 	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
+	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.38.1

