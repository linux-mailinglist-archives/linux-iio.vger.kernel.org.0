Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA0D22793
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfESRRW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727055AbfESRRW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:17:22 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74CC721721;
        Sun, 19 May 2019 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558256318;
        bh=gmbAZO+BDOpBzqJYEGtOCuqP2GFL0t65d1w/4/mRNfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBxNtntbNAjNBtOdARgC3DY1GbdiX+aLeO1Qh30LYsFa+PosIphbOVDuzILluFgNa
         6rgDDBWOmBrCzeCozhbsqr7/ed2vl5cDUO+MgQFAZeDSmW2IWw2oOBNShAfOtXek7y
         UaSgFIdblBfkqTSpBrfn9aqu+bRYt/p2q6ik1+Hg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: fix PM support for st_lsm6dsx i2c controller
Date:   Sun, 19 May 2019 10:58:23 +0200
Message-Id: <a79978d7b8b9762954bf15cb205bada6dc66079a.1558256188.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558256188.git.lorenzo@kernel.org>
References: <cover.1558256188.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Properly suspend/resume i2c slaves connected to st_lsm6dsx master
controller if the CPU goes in suspended state

Fixes: c91c1c844ebd ("imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 25 +++++++++++++-------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 004a8a1a0027..6ef3577234a0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -271,6 +271,7 @@ struct st_lsm6dsx_sensor {
  * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
  * @page_lock: Mutex to prevent concurrent memory page configuration.
  * @fifo_mode: FIFO operating mode supported by the device.
+ * @suspend_mask: Suspended sensor bitmask.
  * @enable_mask: Enabled sensor bitmask.
  * @ts_sip: Total number of timestamp samples in a given pattern.
  * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
@@ -288,6 +289,7 @@ struct st_lsm6dsx_hw {
 	struct mutex page_lock;
 
 	enum st_lsm6dsx_fifo_mode fifo_mode;
+	u8 suspend_mask;
 	u8 enable_mask;
 	u8 ts_sip;
 	u8 sip;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index cf82c9049945..be5c87c8266d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1110,8 +1110,6 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 {
 	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
 	struct st_lsm6dsx_sensor *sensor;
-	const struct st_lsm6dsx_reg *reg;
-	unsigned int data;
 	int i, err = 0;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
@@ -1122,12 +1120,16 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
-		reg = &st_lsm6dsx_odr_table[sensor->id].reg;
-		data = ST_LSM6DSX_SHIFT_VAL(0, reg->mask);
-		err = st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask,
-						    data);
+		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
+		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
+		    sensor->id == ST_LSM6DSX_ID_EXT2)
+			err = st_lsm6dsx_shub_set_enable(sensor, false);
+		else
+			err = st_lsm6dsx_sensor_set_enable(sensor, false);
 		if (err < 0)
 			return err;
+
+		hw->suspend_mask |= BIT(sensor->id);
 	}
 
 	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
@@ -1147,12 +1149,19 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 			continue;
 
 		sensor = iio_priv(hw->iio_devs[i]);
-		if (!(hw->enable_mask & BIT(sensor->id)))
+		if (!(hw->suspend_mask & BIT(sensor->id)))
 			continue;
 
-		err = st_lsm6dsx_set_odr(sensor, sensor->odr);
+		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
+		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
+		    sensor->id == ST_LSM6DSX_ID_EXT2)
+			err = st_lsm6dsx_shub_set_enable(sensor, true);
+		else
+			err = st_lsm6dsx_sensor_set_enable(sensor, true);
 		if (err < 0)
 			return err;
+
+		hw->suspend_mask &= ~BIT(sensor->id);
 	}
 
 	if (hw->enable_mask)
-- 
2.21.0

