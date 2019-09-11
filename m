Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3E9AF621
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2019 08:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfIKGue (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Sep 2019 02:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfIKGue (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Sep 2019 02:50:34 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C795721D79;
        Wed, 11 Sep 2019 06:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568184633;
        bh=N1XEaQNzfvx6K7xwaJxikVXHz/mtYudkHdSG6tSbo+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtHVYoZiUeOC0ptLogm5IW1ebH3dHDO3sWOD7bL9RxP3UDf6/WqAam91N3589I3Ib
         ANyRy3DozHKj8evVGdIQ28BbbB2NJvXu0dlpmJmF8Xa4m31gOU9URoxm23led2IPZ0
         1Hjlrskjdee5xv5zFVyp850zZh8SLqD7TA68Yqug=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     sean@geanix.com, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org, mario.tesi@st.com,
        armando.visconti@st.com, denis.ciocca@st.com
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: enable LIR for sensor events
Date:   Wed, 11 Sep 2019 08:50:03 +0200
Message-Id: <376b8e64aa95f686e46aa760934cd25d9f47833f.1568184231.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568184231.git.lorenzo@kernel.org>
References: <cover.1568184231.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable Latched interrupt by default for sensor events

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 35 ++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 5e3cd96b0059..3ea0dc13d101 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -215,6 +215,7 @@ struct st_lsm6dsx_ext_dev_settings {
  * @fs_table: Hw sensors gain table (gain + val).
  * @decimator: List of decimator register info (addr + mask).
  * @batch: List of FIFO batching register info (addr + mask).
+ * @lir: Latched interrupt register info (addr + mask).
  * @fifo_ops: Sensor hw FIFO parameters.
  * @ts_settings: Hw timer related settings.
  * @shub_settings: i2c controller related settings.
@@ -237,6 +238,7 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_fs_table_entry fs_table[2];
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
+	struct st_lsm6dsx_reg lir;
 	struct st_lsm6dsx_fifo_ops fifo_ops;
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2d3495560136..a208da865efe 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -237,6 +237,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.lir = {
+			.addr = 0x58,
+			.mask = BIT(0),
+		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_fifo,
@@ -349,6 +353,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.lir = {
+			.addr = 0x58,
+			.mask = BIT(0),
+		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_fifo,
@@ -470,6 +478,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(5, 3),
 			},
 		},
+		.lir = {
+			.addr = 0x58,
+			.mask = BIT(0),
+		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_fifo,
@@ -585,6 +597,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 4),
 			},
 		},
+		.lir = {
+			.addr = 0x56,
+			.mask = BIT(0),
+		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_tagged_fifo,
@@ -715,6 +731,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 4),
 			},
 		},
+		.lir = {
+			.addr = 0x56,
+			.mask = BIT(0),
+		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_tagged_fifo,
@@ -822,6 +842,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 4),
 			},
 		},
+		.lir = {
+			.addr = 0x56,
+			.mask = BIT(0),
+		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_tagged_fifo,
@@ -1416,6 +1440,17 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	if (err < 0)
 		return err;
 
+	/* enable Latched interrupts for device events */
+	if (hw->settings->lir.addr) {
+		unsigned int data;
+
+		data = ST_LSM6DSX_SHIFT_VAL(1, hw->settings->lir.mask);
+		err = regmap_update_bits(hw->regmap, hw->settings->lir.addr,
+					 hw->settings->lir.mask, data);
+		if (err < 0)
+			return err;
+	}
+
 	err = st_lsm6dsx_init_shub(hw);
 	if (err < 0)
 		return err;
-- 
2.21.0

