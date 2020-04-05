Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCB219EA6B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 12:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgDEKgd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 06:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgDEKgd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 06:36:33 -0400
Received: from localhost.localdomain (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE9920675;
        Sun,  5 Apr 2020 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586082993;
        bh=znrSgh2x/IC4B/MrB1nVE9CjuJwQivqvjaspxIsUhaE=;
        h=From:To:Cc:Subject:Date:From;
        b=E9j60K/E7xEDX7KAK47ErWBwMDSpcMwt2pXjHq5hUc2OPXKLZuHTU/E7Rintf7e/K
         /pxE1SGfXzTZ8DTFp7rfbiFaQU6QyeYHJWn2ijA509g/QqS8YdTEKlSFghdkUZzUOl
         1ryNt7q7KrHFLqYZyjW0OXe2uhdz8VDM1jWIfVOA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: remove duplicated macro
Date:   Sun,  5 Apr 2020 12:36:26 +0200
Message-Id: <f7c16e9f25debe726645f25df6c9c18aa44f0a1f.1586082819.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove ST_LSM6DSX_REG_WHOAMI_ADDR duplicated macro and rely on ST sensor
common definitions

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 84d219ae6aee..f3cf13b29d18 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -58,12 +58,11 @@
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
 
+#include <linux/iio/common/st_sensors.h>
 #include <linux/platform_data/st_sensors_pdata.h>
 
 #include "st_lsm6dsx.h"
 
-#define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
-
 #define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
 
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
@@ -1364,7 +1363,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
 		return -ENODEV;
 	}
 
-	err = regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
+	err = regmap_read(hw->regmap, ST_SENSORS_DEFAULT_WAI_ADDRESS, &data);
 	if (err < 0) {
 		dev_err(hw->dev, "failed to read whoami register\n");
 		return err;
-- 
2.25.1

