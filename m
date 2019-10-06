Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F7ECD216
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfJFNWj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:39 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B3D2080F;
        Sun,  6 Oct 2019 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368158;
        bh=4K9yshLJ6nsCgdbzwOhPEwWXE3AxMJgFLFT4CWr9oAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyxEwnCOP3fm8SreM3Icz5xg01OrirspNuXA4l5kcyh2RCzU0i6Hq/ABDCpMmgh0l
         6i9MhNXdHVbgRkd0SxtpigdvFNZMoMoeIwswqw7DFSwi4wpJEZXyEMd7hBhJklU09/
         tqD0dHnV8w/fJqYMpMvpDIuLFAOmoLimIGBFbgPY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 07/13] iio: imu: st_lsm6dsx: rely on st_lsm6dsx_update_bits_locked configuring events
Date:   Sun,  6 Oct 2019 15:22:01 +0200
Message-Id: <903ebb1b14412abdee3029417ae146515e49c685.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rely on st_lsm6dsx_update_bits_locked in st_lsm6dsx_write_event and
st_lsm6dsx_event_setup routines since they can run concurrently with
sensor hub configuration

Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 25 +++++++++++---------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 7e9e1ef81742..023646762b4a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1483,6 +1483,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
 {
 	const struct st_lsm6dsx_reg *reg;
+	unsigned int data;
 	int err;
 
 	if (!hw->settings->irq_config.irq1_func.addr)
@@ -1490,17 +1491,17 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
 
 	reg = &hw->settings->event_settings.enable_reg;
 	if (reg->addr) {
-		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
-					 ST_LSM6DSX_SHIFT_VAL(state, reg->mask));
+		data = ST_LSM6DSX_SHIFT_VAL(state, reg->mask);
+		err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
+						    reg->mask, data);
 		if (err < 0)
 			return err;
 	}
 
 	/* Enable wakeup interrupt */
-	return regmap_update_bits(hw->regmap, hw->irq_routing->addr,
-				  hw->irq_routing->mask,
-				  ST_LSM6DSX_SHIFT_VAL(state,
-					hw->irq_routing->mask));
+	data = ST_LSM6DSX_SHIFT_VAL(state, hw->irq_routing->mask);
+	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing->addr,
+					     hw->irq_routing->mask, data);
 }
 
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
@@ -1531,6 +1532,8 @@ static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_reg *reg;
+	unsigned int data;
 	int err;
 
 	if (type != IIO_EV_TYPE_THRESH)
@@ -1539,11 +1542,11 @@ static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (val < 0 || val > 31)
 		return -EINVAL;
 
-	err = regmap_update_bits(hw->regmap,
-				 hw->settings->event_settings.wakeup_reg.addr,
-				 hw->settings->event_settings.wakeup_reg.mask,
-				 val);
-	if (err)
+	reg = &hw->settings->event_settings.wakeup_reg;
+	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
+	err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
+					    reg->mask, data);
+	if (err < 0)
 		return -EINVAL;
 
 	hw->event_threshold = val;
-- 
2.21.0

