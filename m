Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0865B6134AA
	for <lists+linux-iio@lfdr.de>; Mon, 31 Oct 2022 12:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJaLls (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Oct 2022 07:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJaLlr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2022 07:41:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B33BE0A1;
        Mon, 31 Oct 2022 04:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12AEF6111F;
        Mon, 31 Oct 2022 11:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E9DC433D6;
        Mon, 31 Oct 2022 11:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216505;
        bh=vh6nhL1UqV4vNokrz4ocfkdID/6N3bBCRhdjm7/YzH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5hErzxTgEWbOia0cRZt+eX1sTlhLFJPFatmgj9RnjWsFYUYigJmfzUGXuMzPl7Yd
         3n0U8mftKMqObIjqrtcTs3Cstf4QyyLz9KXwVbLH1pbNDCNY96H7YOF6YhC4Hvo0ev
         r3u6gjcloqDJJhBGVMBQWG91icB8kvE6rZoDzqyL3dhbBl3lq5vq1rPeQFBMVk5nbn
         4pvibkqWVdqOb1GtjL9GDviKhIeSJTdfVO/H/5CW/+wiL04vr+CDRbXMJ5WXJ1QBgu
         SShHiilivKqCG7ACqdGkuhXmGkFMa5cVpl56NQWvwTi2+LoPr8v/cOgXxyD4rxwJmv
         TG3NYMOHNreVw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to LSM6DSV
Date:   Mon, 31 Oct 2022 12:41:25 +0100
Message-Id: <aad879e7af0fe583bbf043a2b93e32fade79fa19.1667216004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667216004.git.lorenzo@kernel.org>
References: <cover.1667216004.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM LSM6DSV (accelerometer and gyroscope)
Mems sensor.

Datasheet: https://www.st.com/resource/en/datasheet/lsm6dsv.pdf
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig            |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 202 ++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
 6 files changed, 216 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 2ed2b3f40c0b..1c68bac94bce 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -13,7 +13,7 @@ config IIO_ST_LSM6DSX
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
 	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
-	  the accelerometer/gyroscope of lsm9ds1 and lsm6dst.
+	  lsm6dsv, the accelerometer/gyroscope of lsm9ds1 and lsm6dst.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 07ad8027de73..755f7117f0a0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -33,6 +33,7 @@
 #define ST_LSM6DSOP_DEV_NAME	"lsm6dsop"
 #define ST_ASM330LHHX_DEV_NAME	"asm330lhhx"
 #define ST_LSM6DSTX_DEV_NAME	"lsm6dstx"
+#define ST_LSM6DSV_DEV_NAME	"lsm6dsv"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -53,6 +54,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM6DSOP_ID,
 	ST_ASM330LHHX_ID,
 	ST_LSM6DSTX_ID,
+	ST_LSM6DSV_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 48fe6a45671b..7dd5205aea5b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -15,7 +15,7 @@
  * value of the decimation factor and ODR set for each FIFO data set.
  *
  * LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/LSM6DSRX/ISM330DHCX/
- * LSM6DST/LSM6DSOP/LSM6DSTX:
+ * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV:
  * The FIFO buffer can be configured to store data from gyroscope and
  * accelerometer. Each sample is queued with a tag (1B) indicating data
  * source (gyroscope, accelerometer, hw timer).
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index fe5fa08b68ac..74a891f3cb70 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1160,6 +1160,208 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+				.hw_id = ST_LSM6DSV_ID,
+				.name = ST_LSM6DSV_DEV_NAME,
+				.wai = 0x70,
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
+		.drdy_mask = {
+			.addr = 0x13,
+			.mask = BIT(3),
+		},
+		.odr_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x10,
+					.mask = GENMASK(3, 0),
+				},
+				.odr_avl[0] = {   7500, 0x02 },
+				.odr_avl[1] = {  15000, 0x03 },
+				.odr_avl[2] = {  30000, 0x04 },
+				.odr_avl[3] = {  60000, 0x05 },
+				.odr_avl[4] = { 120000, 0x06 },
+				.odr_avl[5] = { 240000, 0x07 },
+				.odr_avl[6] = { 480000, 0x08 },
+				.odr_avl[7] = { 960000, 0x09 },
+				.odr_len = 8,
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x11,
+					.mask = GENMASK(3, 0),
+				},
+				.odr_avl[0] = {   7500, 0x02 },
+				.odr_avl[1] = {  15000, 0x03 },
+				.odr_avl[2] = {  30000, 0x04 },
+				.odr_avl[3] = {  60000, 0x05 },
+				.odr_avl[4] = { 120000, 0x06 },
+				.odr_avl[5] = { 240000, 0x07 },
+				.odr_avl[6] = { 480000, 0x08 },
+				.odr_avl[7] = { 960000, 0x09 },
+				.odr_len = 8,
+			},
+		},
+		.fs_table = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.reg = {
+					.addr = 0x17,
+					.mask = GENMASK(1, 0),
+				},
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61000), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122000), 0x1 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244000), 0x2 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(488000), 0x3 },
+				.fs_len = 4,
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.reg = {
+					.addr = 0x15,
+					.mask = GENMASK(3, 0),
+				},
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750000), 0x1 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500000), 0x2 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000000), 0x3 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000000), 0x4 },
+				.fs_len = 4,
+			},
+		},
+		.irq_config = {
+			.irq1 = {
+				.addr = 0x0d,
+				.mask = BIT(3),
+			},
+			.irq2 = {
+				.addr = 0x0e,
+				.mask = BIT(3),
+			},
+			.lir = {
+				.addr = 0x56,
+				.mask = BIT(0),
+			},
+			.irq1_func = {
+				.addr = 0x5e,
+				.mask = BIT(5),
+			},
+			.irq2_func = {
+				.addr = 0x5f,
+				.mask = BIT(5),
+			},
+			.hla = {
+				.addr = 0x03,
+				.mask = BIT(4),
+			},
+			.od = {
+				.addr = 0x03,
+				.mask = BIT(3),
+			},
+		},
+		.batch = {
+			[ST_LSM6DSX_ID_ACC] = {
+				.addr = 0x09,
+				.mask = GENMASK(3, 0),
+			},
+			[ST_LSM6DSX_ID_GYRO] = {
+				.addr = 0x09,
+				.mask = GENMASK(7, 4),
+			},
+		},
+		.fifo_ops = {
+			.update_fifo = st_lsm6dsx_update_fifo,
+			.read_fifo = st_lsm6dsx_read_tagged_fifo,
+			.fifo_th = {
+				.addr = 0x07,
+				.mask = GENMASK(7, 0),
+			},
+			.fifo_diff = {
+				.addr = 0x1b,
+				.mask = GENMASK(8, 0),
+			},
+			.max_size = 512,
+			.th_wl = 1,
+		},
+		.ts_settings = {
+			.timer_en = {
+				.addr = 0x50,
+				.mask = BIT(6),
+			},
+			.decimator = {
+				.addr = 0x0a,
+				.mask = GENMASK(7, 6),
+			},
+			.freq_fine = 0x4f,
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
+				.addr = 0x03,
+				.mask = BIT(6),
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
+			.batch_en = BIT(3),
+		},
+		.event_settings = {
+			.enable_reg = {
+				.addr = 0x50,
+				.mask = BIT(7),
+			},
+			.wakeup_reg = {
+				.addr = 0x5b,
+				.mask = GENMASK(5, 0),
+			},
+			.wakeup_src_reg = 0x45,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
+		},
+	},
 };
 
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 307c8c436862..239c8920a31f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -109,6 +109,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm6dstx",
 		.data = (void *)ST_LSM6DSTX_ID,
 	},
+	{
+		.compatible = "st,lsm6dsv",
+		.data = (void *)ST_LSM6DSV_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -132,6 +136,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
 	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
 	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
+	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 6a4eecf4bb05..66705ef16ed0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -109,6 +109,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm6dstx",
 		.data = (void *)ST_LSM6DSTX_ID,
 	},
+	{
+		.compatible = "st,lsm6dsv",
+		.data = (void *)ST_LSM6DSV_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -132,6 +136,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
 	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
 	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
+	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.38.1

