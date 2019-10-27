Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749F2E64C3
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfJ0SCv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 14:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfJ0SCv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 14:02:51 -0400
Received: from localhost.localdomain (unknown [151.66.57.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E19921726;
        Sun, 27 Oct 2019 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572199371;
        bh=/2B5IqnccsrpUBxxVLeECUIrA4xrmZ7h0/HaC05SvtY=;
        h=From:To:Cc:Subject:Date:From;
        b=rsKYpcKo70buCJZZ1tXRQ2WN3eBKBIhDshFdQMIOgWIvyYRmI+7MDOx0tamXApmvK
         GfsVLnkRI9ak9RQjfxOxLUOf0PyDdPCke0p9kJR+IRU3v9EMiba/cDmWkgFC7qWlDc
         aGH1UD9qyvj8BOpepZgX5odOzqYys30rYdhx0yzI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: fix ODR check in st_lsm6dsx_write_raw
Date:   Sun, 27 Oct 2019 19:02:30 +0100
Message-Id: <eda7fb795fb47c41b6c6d617255cb8eec486c355.1572199100.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since st_lsm6dsx i2c master controller relies on accel device as trigger
and slave devices can run at different ODRs we must select an accel_odr >=
slave_odr. Report real accel ODR in st_lsm6dsx_check_odr() in order to
properly set sensor frequency in st_lsm6dsx_write_raw and avoid to
report unsupported frequency

Fixes: 6ffb55e5009ff ("iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 1f28a7733fc0..c53c03ec2423 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1362,8 +1362,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val)
 		return -EINVAL;
 
 	*val = odr_table->odr_avl[i].val;
-
-	return 0;
+	return odr_table->odr_avl[i].hz;
 }
 
 static u16 st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u16 odr,
@@ -1527,8 +1526,10 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		u8 data;
 
-		err = st_lsm6dsx_check_odr(sensor, val, &data);
-		if (!err)
+		val = st_lsm6dsx_check_odr(sensor, val, &data);
+		if (val < 0)
+			err = val;
+		else
 			sensor->odr = val;
 		break;
 	}
-- 
2.21.0

