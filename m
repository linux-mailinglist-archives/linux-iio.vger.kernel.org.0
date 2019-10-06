Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD26CD213
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJFNWh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:37 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F0B72087E;
        Sun,  6 Oct 2019 13:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368156;
        bh=x4JU9PoYK88zVApCo9zd7hj9YzT1ehWfIDDSXB28k4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pZ+5XzuxpWveb5HqMjAAcbxmIDSOR1xtkHEaqbVy9akWbKT9jH6BdWA6SZ6WmwLBb
         rXbJ/DH5Uo+lat1oKNQXBgPEuKjU/KK0J/NPx2lImiylMP9WZj4HIPizbNEw4UtSgj
         PtgAkNByNNgGES5bWjo5a8rRiEVnyKZ6L5RAoYwA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 06/13] iio: imu: st_lsm6dsx: always check enable_reg in st_lsm6dsx_event_setup
Date:   Sun,  6 Oct 2019 15:22:00 +0200
Message-Id: <837ea533a4094d6da572999e8f863687fa4cae1b.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Check if enable_reg of event_settings data structure is defined before
writing on it

Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 23 ++++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 5df382b9d8f9..7e9e1ef81742 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1482,26 +1482,25 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 
 static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
 {
+	const struct st_lsm6dsx_reg *reg;
 	int err;
-	u8 enable = 0;
 
 	if (!hw->settings->irq_config.irq1_func.addr)
 		return -ENOTSUPP;
 
-	enable = state ? hw->settings->event_settings.enable_reg.mask : 0;
-
-	err = regmap_update_bits(hw->regmap,
-				 hw->settings->event_settings.enable_reg.addr,
-				 hw->settings->event_settings.enable_reg.mask,
-				 enable);
-	if (err < 0)
-		return err;
-
-	enable = state ? hw->irq_routing->mask : 0;
+	reg = &hw->settings->event_settings.enable_reg;
+	if (reg->addr) {
+		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
+					 ST_LSM6DSX_SHIFT_VAL(state, reg->mask));
+		if (err < 0)
+			return err;
+	}
 
 	/* Enable wakeup interrupt */
 	return regmap_update_bits(hw->regmap, hw->irq_routing->addr,
-				  hw->irq_routing->mask, enable);
+				  hw->irq_routing->mask,
+				  ST_LSM6DSX_SHIFT_VAL(state,
+					hw->irq_routing->mask));
 }
 
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
-- 
2.21.0

