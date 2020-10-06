Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B23B284B56
	for <lists+linux-iio@lfdr.de>; Tue,  6 Oct 2020 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJFMIR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Oct 2020 08:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgJFMIR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Oct 2020 08:08:17 -0400
Received: from lore-desk.redhat.com (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37357206BE;
        Tue,  6 Oct 2020 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601986095;
        bh=dekU5nDwFuzun2JUmAJs7TvnoTazUqhaTUnvhwNzoxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p7TLBId8OoaNZDYE2Pv4SpP15I5GjHLqEqZe54dTn1Uz5UivmSlFiqsAJE0MycTRC
         WM4cHia0Hsa8+JU0f57AhUy9mI1VC9xLUJuzW/NpMaOLBM/J2Kp7ZORez4ahPHLJB+
         d15pu8lXkyFlWXxMXQrK6dIOfOiUFzBSBQ5utd+w=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, mario.tesi@st.com
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to LSM6DST
Date:   Tue,  6 Oct 2020 14:07:41 +0200
Message-Id: <835127b76ef5ad05aa2aac58298aee5f3073fb71.1601985763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601985763.git.lorenzo@kernel.org>
References: <cover.1601985763.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM LSM6DST (acc + gyro) Mems sensor
https://www.st.com/resource/en/datasheet/lsm6dst.pdf

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig            |   4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 207 +++++++++++++++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
 6 files changed, 221 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 28f59d09208a..76c7abbd1ae8 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -12,8 +12,8 @@ config IIO_ST_LSM6DSX
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
 	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
-	  ism330dhcx, lsm6dsrx, lsm6ds0 and the accelerometer/gyroscope
-	  of lsm9ds1.
+	  ism330dhcx, lsm6dsrx, lsm6ds0, the accelerometer/gyroscope
+	  of lsm9ds1 and lsm6dst.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 9275346a9cc1..1f31657a7a0e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -28,6 +28,7 @@
 #define ST_LSM9DS1_DEV_NAME	"lsm9ds1-imu"
 #define ST_LSM6DS0_DEV_NAME	"lsm6ds0"
 #define ST_LSM6DSRX_DEV_NAME	"lsm6dsrx"
+#define ST_LSM6DST_DEV_NAME	"lsm6dst"
 
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
@@ -44,6 +45,7 @@ enum st_lsm6dsx_hw_id {
 	ST_LSM9DS1_ID,
 	ST_LSM6DS0_ID,
 	ST_LSM6DSRX_ID,
+	ST_LSM6DST_ID,
 	ST_LSM6DSX_MAX_ID,
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 12ed0a2e55e4..49923503b75a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -14,7 +14,7 @@
  * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated depending on the
  * value of the decimation factor and ODR set for each FIFO data set.
  *
- * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/LSM6DSRX/ISM330DHCX:
+ * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/LSM6DSRX/ISM330DHCX/LSM6DST:
  * The FIFO buffer can be configured to store data from gyroscope and
  * accelerometer. Each sample is queued with a tag (1B) indicating data
  * source (gyroscope, accelerometer, hw timer).
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 42f485634d04..5e584c6026f1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -26,7 +26,7 @@
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 4KB
  *
- * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX:
+ * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX/LSM6DST:
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
@@ -1334,6 +1334,211 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.wakeup_src_x_mask = BIT(2),
 		}
 	},
+	{
+		.wai = 0x6d,
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
+		.max_fifo_size = 512,
+		.id = {
+			{
+				.hw_id = ST_LSM6DST_ID,
+				.name = ST_LSM6DST_DEV_NAME,
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
+			.clear_on_read = {
+				.addr = 0x56,
+				.mask = BIT(6),
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
+				.addr = 0x12,
+				.mask = BIT(5),
+			},
+			.od = {
+				.addr = 0x12,
+				.mask = BIT(4),
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
+				.mask = GENMASK(8, 0),
+			},
+			.fifo_diff = {
+				.addr = 0x3a,
+				.mask = GENMASK(9, 0),
+			},
+			.th_wl = 1,
+		},
+		.ts_settings = {
+			.timer_en = {
+				.addr = 0x19,
+				.mask = BIT(5),
+			},
+			.decimator = {
+				.addr = 0x0a,
+				.mask = GENMASK(7, 6),
+			},
+			.freq_fine = 0x63,
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
+			.batch_en = BIT(3),
+		},
+		.event_settings = {
+			.enable_reg = {
+				.addr = 0x58,
+				.mask = BIT(7),
+			},
+			.wakeup_reg = {
+				.addr = 0x5b,
+				.mask = GENMASK(5, 0),
+			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
+		},
+	},
 };
 
 int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 0fb32131afce..e0f945dde12d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -94,6 +94,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,lsm6dsrx",
 		.data = (void *)ST_LSM6DSRX_ID,
 	},
+	{
+		.compatible = "st,lsm6dst",
+		.data = (void *)ST_LSM6DST_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
@@ -113,6 +117,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
 	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
 	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
+	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index eb1086e4a951..c57895be8afe 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -94,6 +94,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,lsm6dsrx",
 		.data = (void *)ST_LSM6DSRX_ID,
 	},
+	{
+		.compatible = "st,lsm6dst",
+		.data = (void *)ST_LSM6DST_ID,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
@@ -113,6 +117,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
 	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
 	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
+	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
-- 
2.26.2

