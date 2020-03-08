Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C561217D0B7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 01:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCHAGM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 19:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgCHAGM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 19:06:12 -0500
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237E22075A;
        Sun,  8 Mar 2020 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583625972;
        bh=kVrmIMcq3dIdNdK/mIva+g3EOGTbG3iaJ3zc3cdpH9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=MbqoZO+HuHYnN9Y97fDst6GkrVZxtj9+OOWgSQKV9rOKurvWcGTFFBbagD4GnLONT
         hdjT8Z53GGRrmvYABKoPifaIH7exJA9rggzOEfPiG//+6XNI+fgLg/zeAwEbx6Ydji
         2jhXc2ki3i79M6hJ8zlvKxvOPX4fPwanXP09pFLA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        mario.tesi@st.com, vitor.soares@synopsys.com
Subject: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during device reset
Date:   Sun,  8 Mar 2020 01:06:03 +0100
Message-Id: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Disable MIPI I3C during device reset in order to avoid
possible races on interrupt line 1. If the first interrupt
line is asserted during hw reset the device will work in
I3C-only mode

Reported-by: Mario Tesi <mario.tesi@st.com>
Fixes: 2660b0080bb2 ("iio: imu: st_lsm6dsx: add i3c basic support for LSM6DSO and LSM6DSR")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- fix comment syntax
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index f2113a63721a..dfcbe7c42493 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -266,6 +266,7 @@ struct st_lsm6dsx_ext_dev_settings {
  * @wai: Sensor WhoAmI default value.
  * @reset: register address for reset.
  * @boot: register address for boot.
+ * @i3c_disable:  register address for enabling/disabling I3C (addr + mask).
  * @bdu: register address for Block Data Update.
  * @max_fifo_size: Sensor max fifo length in FIFO words.
  * @id: List of hw id/device name supported by the driver configuration.
@@ -284,6 +285,7 @@ struct st_lsm6dsx_settings {
 	u8 wai;
 	struct st_lsm6dsx_reg reset;
 	struct st_lsm6dsx_reg boot;
+	struct st_lsm6dsx_reg i3c_disable;
 	struct st_lsm6dsx_reg bdu;
 	u16 max_fifo_size;
 	struct {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 84d219ae6aee..a2e775d6eaa0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -751,6 +751,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x12,
 			.mask = BIT(7),
 		},
+		.i3c_disable = {
+			.addr = 0x18,
+			.mask = BIT(1),
+		},
 		.bdu = {
 			.addr = 0x12,
 			.mask = BIT(6),
@@ -1128,6 +1132,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.addr = 0x12,
 			.mask = BIT(7),
 		},
+		.i3c_disable = {
+			.addr = 0x18,
+			.mask = BIT(1),
+		},
 		.bdu = {
 			.addr = 0x12,
 			.mask = BIT(6),
@@ -2041,6 +2049,20 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	const struct st_lsm6dsx_reg *reg;
 	int err;
 
+	/*
+	 * disable MIPI I3C during device reset in order to avoid
+	 * possible races on interrupt line 1. If the first interrupt
+	 * line is asserted during hw reset the device will work in
+	 * I3C-only mode
+	 */
+	if (hw->settings->i3c_disable.addr) {
+		reg = &hw->settings->i3c_disable;
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
+		if (err < 0)
+			return err;
+	}
+
 	/* device sw reset */
 	reg = &hw->settings->reset;
 	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
@@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 
 	msleep(50);
 
+	/* enable MIPI I3C */
+	if (hw->settings->i3c_disable.addr) {
+		reg = &hw->settings->i3c_disable;
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
+		if (err < 0)
+			return err;
+	}
+
 	/* enable Block Data Update */
 	reg = &hw->settings->bdu;
 	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
-- 
2.24.1

