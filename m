Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B09E267
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfH0I0p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 04:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbfH0I0p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:45 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B305217F5;
        Tue, 27 Aug 2019 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566894404;
        bh=z4KtC7QkXijzuTtuz1ZINyI5k5QS7jD4lKfZluCEn9I=;
        h=From:To:Cc:Subject:Date:From;
        b=uRJPdUaDtMsn2k2jJ5vpZGXe7cjvlkT275FB4sMZthbjo2cE8dnaubN2ySt3/yqsT
         mubLcc86IK5q3TNWnw3W0swqsryz2IpF7PFRwjdmMRzKKeY9c+876TiHwjOkpsZGlt
         Rj/Mwep/YMQ+FicbmD9iWS+hSYloaFg98x6MiGok=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: [PATCH] iio: imu: st_lsm6dsx: remove invalid gain value for LSM9DS1
Date:   Tue, 27 Aug 2019 10:26:35 +0200
Message-Id: <f2be2f0e064bc7785f9d8f7f6a8598c325b39a45.1566894261.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Get rid of invalid sensitivity value for LSM9DS1 gyro sensor

Fixes: 687a60feb9c6 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index fd152fff0a8c..c85c8be3a024 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -151,10 +151,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(4, 3),
 				},
-				.fs_avl[0] = { IIO_DEGREE_TO_RAD(245), 0x0 },
-				.fs_avl[1] = { IIO_DEGREE_TO_RAD(500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(0), 0x2 },
-				.fs_avl[3] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(245), 0x0 },
+				.fs_avl[1] = {  IIO_DEGREE_TO_RAD(500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
 			},
 		},
 	},
@@ -1196,13 +1195,19 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 					    char *buf)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
+	const struct st_lsm6dsx_fs_table_entry *fs_table;
 	enum st_lsm6dsx_sensor_id id = sensor->id;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int i, len = 0;
 
-	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
+	fs_table = &hw->settings->fs_table[id];
+	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++) {
+		if (!fs_table->fs_avl[i].gain)
+			break;
+
 		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
-				 hw->settings->fs_table[id].fs_avl[i].gain);
+				 fs_table->fs_avl[i].gain);
+	}
 	buf[len - 1] = '\n';
 
 	return len;
-- 
2.21.0

