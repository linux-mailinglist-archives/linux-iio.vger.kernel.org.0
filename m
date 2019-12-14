Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD2211F2DE
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2019 17:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfLNQx2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Dec 2019 11:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfLNQx2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Dec 2019 11:53:28 -0500
Received: from localhost.localdomain (209-213-91-242.bos.ma.meganet.net [209.213.91.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF4792467D;
        Sat, 14 Dec 2019 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576342407;
        bh=3j2NPGVeLStDO6FBq8zu+0nw7ImJoYVxDPtkSrZ80pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkgs9Ce4fG69uGn684LkXFNFCuBFYRc/mphcM5DeE6ZuuI7j7HzGgRm/ODay7KyJE
         +LKwBf7wAEixwte7UDUcLW6FYqDZDNXdMjZ/uxdqP8O8pjOJIhrVBiqiMDED52ORuD
         lq3ZoMSx8HkUitA39T5Cf2MyNtE7zyTfPgJV+yXM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 6/6] iio: imu: st_lsm6dsx: enable sensor-hub support for lsm6dsm
Date:   Sat, 14 Dec 2019 17:52:59 +0100
Message-Id: <aceae99afa9f51f533607c81f1eb1009fe0975d1.1576341963.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1576341963.git.lorenzo@kernel.org>
References: <cover.1576341963.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enabled i2c master controller support for LSM6DSM sensor. Enable
ext_sensor0 for lsm6dsm. This series has been tested using LIS2MDL as
slave device connected to the i2c controller of the LSM6DSM

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 ++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 27 ++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 47 +++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 31 ++++++++----
 4 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c2d00c3dd044..1c528b7aefdf 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -176,11 +176,13 @@ struct st_lsm6dsx_hw_ts_settings {
  * @pullup_en: i2c controller pull-up register info (addr + mask).
  * @aux_sens: aux sensor register info (addr + mask).
  * @wr_once: write_once register info (addr + mask).
+ * @emb_func:  embedded function register info (addr + mask).
  * @num_ext_dev: max number of slave devices.
  * @shub_out: sensor hub first output register info.
  * @slv0_addr: slave0 address in secondary page.
  * @dw_slv0_addr: slave0 write register address in secondary page.
  * @batch_en: Enable/disable FIFO batching.
+ * @pause: controller pause value.
  */
 struct st_lsm6dsx_shub_settings {
 	struct st_lsm6dsx_reg page_mux;
@@ -196,6 +198,7 @@ struct st_lsm6dsx_shub_settings {
 	} pullup_en;
 	struct st_lsm6dsx_reg aux_sens;
 	struct st_lsm6dsx_reg wr_once;
+	struct st_lsm6dsx_reg emb_func;
 	u8 num_ext_dev;
 	struct {
 		bool sec_page;
@@ -204,6 +207,7 @@ struct st_lsm6dsx_shub_settings {
 	u8 slv0_addr;
 	u8 dw_slv0_addr;
 	u8 batch_en;
+	u8 pause;
 };
 
 struct st_lsm6dsx_event_settings {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index d416990ae309..cc2b19b60d61 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -332,12 +332,13 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
  */
 int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 {
+	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor, *ext_sensor = NULL;
+	int err, acc_sip, gyro_sip, ts_sip, ext_sip, read_len, offset;
 	u16 fifo_len, pattern_len = hw->sip * ST_LSM6DSX_SAMPLE_SIZE;
 	u16 fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
-	int err, acc_sip, gyro_sip, ts_sip, read_len, offset;
-	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor;
 	u8 gyro_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
 	u8 acc_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
+	u8 ext_buff[ST_LSM6DSX_IIO_BUFF_SIZE];
 	bool reset_ts = false;
 	__le16 fifo_status;
 	s64 ts = 0;
@@ -360,6 +361,8 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 
 	acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
+	if (hw->iio_devs[ST_LSM6DSX_ID_EXT0])
+		ext_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EXT0]);
 
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
@@ -387,12 +390,13 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 		 * following pattern is repeated every 9 samples:
 		 *   - Gx, Gy, Gz, Ax, Ay, Az, Ts, Gx, Gy, Gz, Ts, Gx, ..
 		 */
+		ext_sip = ext_sensor ? ext_sensor->sip : 0;
 		gyro_sip = gyro_sensor->sip;
 		acc_sip = acc_sensor->sip;
 		ts_sip = hw->ts_sip;
 		offset = 0;
 
-		while (acc_sip > 0 || gyro_sip > 0) {
+		while (acc_sip > 0 || gyro_sip > 0 || ext_sip > 0) {
 			if (gyro_sip > 0) {
 				memcpy(gyro_buff, &hw->buff[offset],
 				       ST_LSM6DSX_SAMPLE_SIZE);
@@ -403,6 +407,11 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 				       ST_LSM6DSX_SAMPLE_SIZE);
 				offset += ST_LSM6DSX_SAMPLE_SIZE;
 			}
+			if (ext_sip > 0) {
+				memcpy(ext_buff, &hw->buff[offset],
+				       ST_LSM6DSX_SAMPLE_SIZE);
+				offset += ST_LSM6DSX_SAMPLE_SIZE;
+			}
 
 			if (ts_sip-- > 0) {
 				u8 data[ST_LSM6DSX_SAMPLE_SIZE];
@@ -436,6 +445,10 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 				iio_push_to_buffers_with_timestamp(
 					hw->iio_devs[ST_LSM6DSX_ID_ACC],
 					acc_buff, acc_sensor->ts_ref + ts);
+			if (ext_sip-- > 0)
+				iio_push_to_buffers_with_timestamp(
+					hw->iio_devs[ST_LSM6DSX_ID_EXT0],
+					ext_buff, ext_sensor->ts_ref + ts);
 		}
 	}
 
@@ -628,12 +641,12 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
 		err = st_lsm6dsx_sensor_set_enable(sensor, enable);
 		if (err < 0)
 			goto out;
-
-		err = st_lsm6dsx_set_fifo_odr(sensor, enable);
-		if (err < 0)
-			goto out;
 	}
 
+	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
+	if (err < 0)
+		goto out;
+
 	err = st_lsm6dsx_update_decimators(hw);
 	if (err < 0)
 		goto out;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 679831d84d78..1f00b0d74b25 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -655,6 +655,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x08,
 				.mask = GENMASK(5, 3),
 			},
+			[ST_LSM6DSX_ID_EXT0] = {
+				.addr = 0x09,
+				.mask = GENMASK(2, 0),
+			},
 		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
@@ -687,6 +691,39 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.shub_settings = {
+			.page_mux = {
+				.addr = 0x01,
+				.mask = BIT(7),
+			},
+			.master_en = {
+				.addr = 0x1a,
+				.mask = BIT(0),
+			},
+			.pullup_en = {
+				.addr = 0x1a,
+				.mask = BIT(3),
+			},
+			.aux_sens = {
+				.addr = 0x04,
+				.mask = GENMASK(5, 4),
+			},
+			.wr_once = {
+				.addr = 0x07,
+				.mask = BIT(5),
+			},
+			.emb_func = {
+				.addr = 0x19,
+				.mask = BIT(2),
+			},
+			.num_ext_dev = 1,
+			.shub_out = {
+				.addr = 0x2e,
+			},
+			.slv0_addr = 0x02,
+			.dw_slv0_addr = 0x0e,
+			.pause = 0x7,
+		},
 		.event_settings = {
 			.enable_reg = {
 				.addr = 0x58,
@@ -1901,6 +1938,16 @@ static int st_lsm6dsx_init_shub(struct st_lsm6dsx_hw *hw)
 					 hub_settings->aux_sens.mask, data);
 
 		st_lsm6dsx_set_page(hw, false);
+
+		if (err < 0)
+			return err;
+	}
+
+	if (hub_settings->emb_func.addr) {
+		data = ST_LSM6DSX_SHIFT_VAL(1, hub_settings->emb_func.mask);
+		err = regmap_update_bits(hw->regmap,
+					 hub_settings->emb_func.addr,
+					 hub_settings->emb_func.mask, data);
 	}
 
 	return err;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index dc739dfb36f2..eea555617d4a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -221,16 +221,21 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
 		     u8 *data, int len)
 {
 	const struct st_lsm6dsx_shub_settings *hub_settings;
+	u8 config[3], slv_addr, slv_config = 0;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
-	u8 config[3], slv_addr;
+	const struct st_lsm6dsx_reg *aux_sens;
 	int err;
 
 	hub_settings = &hw->settings->shub_settings;
 	slv_addr = ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
+	aux_sens = &hw->settings->shub_settings.aux_sens;
+	/* do not overwrite aux_sens */
+	if (slv_addr + 2 == aux_sens->addr)
+		slv_config = ST_LSM6DSX_SHIFT_VAL(3, aux_sens->mask);
 
 	config[0] = (sensor->ext_info.addr << 1) | 1;
 	config[1] = addr;
-	config[2] = len & ST_LS6DSX_READ_OP_MASK;
+	config[2] = (len & ST_LS6DSX_READ_OP_MASK) | slv_config;
 
 	err = st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
 					sizeof(config));
@@ -248,7 +253,9 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
 
 	st_lsm6dsx_shub_master_enable(sensor, false);
 
-	memset(config, 0, sizeof(config));
+	config[0] = hub_settings->pause;
+	config[1] = 0;
+	config[2] = slv_config;
 	return st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
 					 sizeof(config));
 }
@@ -305,7 +312,8 @@ st_lsm6dsx_shub_write(struct st_lsm6dsx_sensor *sensor, u8 addr,
 		st_lsm6dsx_shub_master_enable(sensor, false);
 	}
 
-	memset(config, 0, sizeof(config));
+	config[0] = hub_settings->pause;
+	config[1] = 0;
 	return st_lsm6dsx_shub_write_reg(hw, slv_addr, config, sizeof(config));
 }
 
@@ -697,14 +705,19 @@ st_lsm6dsx_shub_check_wai(struct st_lsm6dsx_hw *hw, u8 *i2c_addr,
 			  const struct st_lsm6dsx_ext_dev_settings *settings)
 {
 	const struct st_lsm6dsx_shub_settings *hub_settings;
+	u8 config[3], data, slv_addr, slv_config = 0;
+	const struct st_lsm6dsx_reg *aux_sens;
 	struct st_lsm6dsx_sensor *sensor;
-	u8 config[3], data, slv_addr;
 	bool found = false;
 	int i, err;
 
+	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	hub_settings = &hw->settings->shub_settings;
+	aux_sens = &hw->settings->shub_settings.aux_sens;
 	slv_addr = ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
-	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
+	/* do not overwrite aux_sens */
+	if (slv_addr + 2 == aux_sens->addr)
+		slv_config = ST_LSM6DSX_SHIFT_VAL(3, aux_sens->mask);
 
 	for (i = 0; i < ARRAY_SIZE(settings->i2c_addr); i++) {
 		if (!settings->i2c_addr[i])
@@ -713,7 +726,7 @@ st_lsm6dsx_shub_check_wai(struct st_lsm6dsx_hw *hw, u8 *i2c_addr,
 		/* read wai slave register */
 		config[0] = (settings->i2c_addr[i] << 1) | 0x1;
 		config[1] = settings->wai.addr;
-		config[2] = 0x1;
+		config[2] = 0x1 | slv_config;
 
 		err = st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
 						sizeof(config));
@@ -742,7 +755,9 @@ st_lsm6dsx_shub_check_wai(struct st_lsm6dsx_hw *hw, u8 *i2c_addr,
 	}
 
 	/* reset SLV0 channel */
-	memset(config, 0, sizeof(config));
+	config[0] = hub_settings->pause;
+	config[1] = 0;
+	config[2] = slv_config;
 	err = st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
 					sizeof(config));
 	if (err < 0)
-- 
2.21.0

