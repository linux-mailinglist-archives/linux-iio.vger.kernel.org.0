Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF60E11F2DB
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2019 17:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLNQx0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Dec 2019 11:53:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfLNQxZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Dec 2019 11:53:25 -0500
Received: from localhost.localdomain (209-213-91-242.bos.ma.meganet.net [209.213.91.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0785B2465B;
        Sat, 14 Dec 2019 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576342405;
        bh=WcXUXdxVKgqfKFLOq5wTLIQIS+PTpO47vOJ0/tatYEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=flhius4am02mm570aVgt9YYXVbqut9ATZEIwgY4GsJREQf1+1YdROOrOz7NPMuaeP
         5TU3FRKwmnatVof9cqA6BSKIasYey2Ug5tvfUsqMTqahAF0EKewOFpZpylj02zQIIQ
         AN6VdK4LboTzufkBA8PDjbSILPo4rhlLhPDq+Ti8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 3/6] iio: imu: st_lsm6dsx: check if pull_up is located in primary page
Date:   Sat, 14 Dec 2019 17:52:56 +0100
Message-Id: <7fbb267c585384fd39c2abe7e6250fd1c207bdd3.1576341963.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1576341963.git.lorenzo@kernel.org>
References: <cover.1576341963.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Check if the pull up register is located in the primary or in the
secondary memory page. This is a preliminary patch to support i2c master
controller on lsm6dsm devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  6 +++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 13 +++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 0f8f3fbde67a..b4bd02df2900 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -189,7 +189,11 @@ struct st_lsm6dsx_shub_settings {
 		u8 addr;
 		u8 mask;
 	} master_en;
-	struct st_lsm6dsx_reg pullup_en;
+	struct {
+		bool sec_page;
+		u8 addr;
+		u8 mask;
+	} pullup_en;
 	struct st_lsm6dsx_reg aux_sens;
 	struct st_lsm6dsx_reg wr_once;
 	u8 num_ext_dev;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index fe1aaaf68a9b..6adfc53ef8d0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -872,6 +872,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = BIT(2),
 			},
 			.pullup_en = {
+				.sec_page = true,
 				.addr = 0x14,
 				.mask = BIT(3),
 			},
@@ -1248,6 +1249,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = BIT(2),
 			},
 			.pullup_en = {
+				.sec_page = true,
 				.addr = 0x14,
 				.mask = BIT(3),
 			},
@@ -1863,16 +1865,19 @@ static int st_lsm6dsx_init_shub(struct st_lsm6dsx_hw *hw)
 	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
 	if ((np && of_property_read_bool(np, "st,pullups")) ||
 	    (pdata && pdata->pullups)) {
-		err = st_lsm6dsx_set_page(hw, true);
-		if (err < 0)
-			return err;
+		if (hub_settings->pullup_en.sec_page) {
+			err = st_lsm6dsx_set_page(hw, true);
+			if (err < 0)
+				return err;
+		}
 
 		data = ST_LSM6DSX_SHIFT_VAL(1, hub_settings->pullup_en.mask);
 		err = regmap_update_bits(hw->regmap,
 					 hub_settings->pullup_en.addr,
 					 hub_settings->pullup_en.mask, data);
 
-		st_lsm6dsx_set_page(hw, false);
+		if (hub_settings->pullup_en.sec_page)
+			st_lsm6dsx_set_page(hw, false);
 
 		if (err < 0)
 			return err;
-- 
2.21.0

