Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2521211F2DC
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2019 17:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfLNQx1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Dec 2019 11:53:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfLNQx1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Dec 2019 11:53:27 -0500
Received: from localhost.localdomain (209-213-91-242.bos.ma.meganet.net [209.213.91.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DDD2467B;
        Sat, 14 Dec 2019 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576342406;
        bh=0OmDDmZEzTVAvBDYoaF/R4fktuVS2aM8ibzjVEQY+Ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n79LPICfS0btKGBEAQB/qTjlcsrafAm9AGzds0JcODQ4ZQ3RppJ+Iv2v8cmTxmob4
         LpWGyFis61oC1ZEILrDKoDGWgWLP1pRwm1g3D3zFvqj06ie3X0J497k1hDw4VDkd8V
         H18ss3qn5974R4H0LOslU9negFMCZMT63DyNAbbA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 5/6] iio: imu: st_lsm6dsx: rename st_lsm6dsx_shub_read_reg in st_lsm6dsx_shub_read_output
Date:   Sat, 14 Dec 2019 17:52:58 +0100
Message-Id: <3b95fb08efff46b9ea0de33bf332d23a207f903c.1576341963.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1576341963.git.lorenzo@kernel.org>
References: <cover.1576341963.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rename st_lsm6dsx_shub_read_reg routine in st_lsm6dsx_shub_read_output
since it is used to read from sensorhub channel0 output register

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index ccc59682cb66..dc739dfb36f2 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -101,13 +101,13 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
 }
 
 /**
- * st_lsm6dsx_shub_read_reg - read i2c controller register
+ * st_lsm6dsx_shub_read_output - read i2c controller register
  *
  * Read st_lsm6dsx i2c controller register
  */
 static int
-st_lsm6dsx_shub_read_reg(struct st_lsm6dsx_hw *hw, u8 *data,
-			 int len)
+st_lsm6dsx_shub_read_output(struct st_lsm6dsx_hw *hw, u8 *data,
+			    int len)
 {
 	const struct st_lsm6dsx_shub_settings *hub_settings;
 	int err;
@@ -243,7 +243,8 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
 
 	st_lsm6dsx_shub_wait_complete(hw);
 
-	err = st_lsm6dsx_shub_read_reg(hw, data, len & ST_LS6DSX_READ_OP_MASK);
+	err = st_lsm6dsx_shub_read_output(hw, data,
+					  len & ST_LS6DSX_READ_OP_MASK);
 
 	st_lsm6dsx_shub_master_enable(sensor, false);
 
@@ -725,7 +726,7 @@ st_lsm6dsx_shub_check_wai(struct st_lsm6dsx_hw *hw, u8 *i2c_addr,
 
 		st_lsm6dsx_shub_wait_complete(hw);
 
-		err = st_lsm6dsx_shub_read_reg(hw, &data, sizeof(data));
+		err = st_lsm6dsx_shub_read_output(hw, &data, sizeof(data));
 
 		st_lsm6dsx_shub_master_enable(sensor, false);
 
-- 
2.21.0

