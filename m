Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B637B11F2D9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2019 17:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfLNQxX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Dec 2019 11:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfLNQxX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Dec 2019 11:53:23 -0500
Received: from localhost.localdomain (209-213-91-242.bos.ma.meganet.net [209.213.91.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74AE22465B;
        Sat, 14 Dec 2019 16:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576342402;
        bh=dw61T4ETDf6DsYqgt4xBXF7ab9VSdevyz41jbISFsDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGxLVVXr2Kxrr2WiwQwh6yOwWiNlmb8/W+B7YauxAos9OGyLWjAFrtAbXI094mdIX
         gBCF3NgqNuSpLXtlVI5ZNWFZ7hmUo9gijllz+tUYiwYwJFa8nMvs2+/5h2UoaL+kDL
         5irM4/AQTdpp9wLo08XAzVa1w15rlGwZ79HbMTiM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 1/6] iio: imu: st_lsm6dsx: export max num of slave devices in st_lsm6dsx_shub_settings
Date:   Sat, 14 Dec 2019 17:52:54 +0100
Message-Id: <9c4945c59f4ac63d28de6180da2409a95c60aee5.1576341963.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1576341963.git.lorenzo@kernel.org>
References: <cover.1576341963.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Export max number of slave devices supported by the i2c master
controller in st_lsm6dsx_shub_settings data structure.
This is a preliminary patch to support i2c master controller
on lsm6dsm sensors

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 3 +--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c605b153be41..fb76e0d6770d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -176,6 +176,7 @@ struct st_lsm6dsx_hw_ts_settings {
  * @pullup_en: i2c controller pull-up register info (addr + mask).
  * @aux_sens: aux sensor register info (addr + mask).
  * @wr_once: write_once register info (addr + mask).
+ * @num_ext_dev: max number of slave devices.
  * @shub_out: sensor hub first output register info.
  * @slv0_addr: slave0 address in secondary page.
  * @dw_slv0_addr: slave0 write register address in secondary page.
@@ -187,6 +188,7 @@ struct st_lsm6dsx_shub_settings {
 	struct st_lsm6dsx_reg pullup_en;
 	struct st_lsm6dsx_reg aux_sens;
 	struct st_lsm6dsx_reg wr_once;
+	u8 num_ext_dev;
 	u8 shub_out;
 	u8 slv0_addr;
 	u8 dw_slv0_addr;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a4ed72aef93e..bf995b58c333 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -882,6 +882,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x14,
 				.mask = BIT(6),
 			},
+			.num_ext_dev = 3,
 			.shub_out = 0x02,
 			.slv0_addr = 0x15,
 			.dw_slv0_addr = 0x21,
@@ -1256,6 +1257,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x14,
 				.mask = BIT(6),
 			},
+			.num_ext_dev = 3,
 			.shub_out = 0x02,
 			.slv0_addr = 0x15,
 			.dw_slv0_addr = 0x21,
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index fa5d1001a46c..5684e663d0aa 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -30,7 +30,6 @@
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_MAX_SLV_NUM			3
 #define ST_LSM6DSX_SLV_ADDR(n, base)		((base) + (n) * 3)
 #define ST_LSM6DSX_SLV_SUB_ADDR(n, base)	((base) + 1 + (n) * 3)
 #define ST_LSM6DSX_SLV_CONFIG(n, base)		((base) + 2 + (n) * 3)
@@ -770,7 +769,7 @@ int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name)
 		if (err < 0)
 			return err;
 
-		if (++num_ext_dev >= ST_LSM6DSX_MAX_SLV_NUM)
+		if (++num_ext_dev >= hw->settings->shub_settings.num_ext_dev)
 			break;
 		id++;
 	}
-- 
2.21.0

