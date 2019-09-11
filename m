Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D28AF622
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2019 08:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfIKGuh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Sep 2019 02:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbfIKGug (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Sep 2019 02:50:36 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9486521A4C;
        Wed, 11 Sep 2019 06:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568184636;
        bh=RGeV+WKkRkFn1fkbLOfYy/j9Z7M/qKew358HaObcgDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpPrDo2jhYJEaex7w8SghOCDK/hzJAiHnoR5xUfW/ogVflGXQfGfnLKDy//A5QxqV
         X4mjZrGWfARaS6VlfOmWpcgW8zA1ucfjuax86Nl6nrhhnSthrQqfKvV3usXdfOavXt
         cT2WHDCbDnkY2EgdxNDWbz+c5Xf/RpGlTiHr+07E=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     sean@geanix.com, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org, mario.tesi@st.com,
        armando.visconti@st.com, denis.ciocca@st.com
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: enable clear on read for latched interrupts
Date:   Wed, 11 Sep 2019 08:50:04 +0200
Message-Id: <d2c9b90f277826a4b3403d44885fff1cd36d9245.1568184231.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1568184231.git.lorenzo@kernel.org>
References: <cover.1568184231.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable clear on read feature for latched interrupts. This bit allows
immediately clearing the latched interrupts of an event detection upon
the read of the corresponding status register.
It must be set to 1 together with LIR.
This feature is available just on LSM6DS0/LSM6DSR/ASM330LHH

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 24 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 3ea0dc13d101..fefd9042590a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -216,6 +216,7 @@ struct st_lsm6dsx_ext_dev_settings {
  * @decimator: List of decimator register info (addr + mask).
  * @batch: List of FIFO batching register info (addr + mask).
  * @lir: Latched interrupt register info (addr + mask).
+ * @clear_on_read: Clear on read register info (addr + mask).
  * @fifo_ops: Sensor hw FIFO parameters.
  * @ts_settings: Hw timer related settings.
  * @shub_settings: i2c controller related settings.
@@ -239,6 +240,7 @@ struct st_lsm6dsx_settings {
 	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
 	struct st_lsm6dsx_reg lir;
+	struct st_lsm6dsx_reg clear_on_read;
 	struct st_lsm6dsx_fifo_ops fifo_ops;
 	struct st_lsm6dsx_hw_ts_settings ts_settings;
 	struct st_lsm6dsx_shub_settings shub_settings;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a208da865efe..b65a6ca775e0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -601,6 +601,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x56,
 			.mask = BIT(0),
 		},
+		.clear_on_read = {
+			.addr = 0x56,
+			.mask = BIT(6),
+		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_tagged_fifo,
@@ -735,6 +739,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x56,
 			.mask = BIT(0),
 		},
+		.clear_on_read = {
+			.addr = 0x56,
+			.mask = BIT(6),
+		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_tagged_fifo,
@@ -846,6 +854,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x56,
 			.mask = BIT(0),
 		},
+		.clear_on_read = {
+			.addr = 0x56,
+			.mask = BIT(6),
+		},
 		.fifo_ops = {
 			.update_fifo = st_lsm6dsx_update_fifo,
 			.read_fifo = st_lsm6dsx_read_tagged_fifo,
@@ -1449,6 +1461,18 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 					 hw->settings->lir.mask, data);
 		if (err < 0)
 			return err;
+
+		/* enable clear on read for latched interrupts */
+		if (hw->settings->clear_on_read.addr) {
+			data = ST_LSM6DSX_SHIFT_VAL(1,
+					hw->settings->clear_on_read.mask);
+			err = regmap_update_bits(hw->regmap,
+					hw->settings->clear_on_read.addr,
+					hw->settings->clear_on_read.mask,
+					data);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	err = st_lsm6dsx_init_shub(hw);
-- 
2.21.0

