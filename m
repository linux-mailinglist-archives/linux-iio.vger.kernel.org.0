Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D3A113B
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 07:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfH2FvE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 01:51:04 -0400
Received: from comms.puri.sm ([159.203.221.185]:49584 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfH2FvE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Aug 2019 01:51:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8F372E04AD;
        Wed, 28 Aug 2019 22:51:03 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8RPJF6EW5_xT; Wed, 28 Aug 2019 22:51:02 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     jic23@kernel.org, lorenzo@kernel.org, lorenzo.bianconi@redhat.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] Revert "iio: imu: st_lsm6dsx: remove invalid gain value for LSM9DS1"
Date:   Thu, 29 Aug 2019 07:50:24 +0200
Message-Id: <20190829055024.559-1-martin.kepplinger@puri.sm>
In-Reply-To: <37cb0888-50b6-40d2-1289-a78499a90b7c@puri.sm>
References: <37cb0888-50b6-40d2-1289-a78499a90b7c@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The st_lsm6dsx_sensor_settings struct's fs_avl[] array is expected to
be of size 4. We can't define it to be of size 3 and try to access
the 4th element below.

Commit c8d4066c7246 ("iio: imu: st_lsm6dsx: remove invalid gain value
for LSM9DS1") which is a "cleanup" change, results in an Ooops here
so revert it.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2d3495560136..499745424c1e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -151,9 +151,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(4, 3),
 				},
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(245), 0x0 },
-				.fs_avl[1] = {  IIO_DEGREE_TO_RAD(500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
+				.fs_avl[0] = { IIO_DEGREE_TO_RAD(245), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(0), 0x2 },
+				.fs_avl[3] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
 			},
 		},
 	},
@@ -1195,19 +1196,13 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 					    char *buf)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
-	const struct st_lsm6dsx_fs_table_entry *fs_table;
 	enum st_lsm6dsx_sensor_id id = sensor->id;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int i, len = 0;
 
-	fs_table = &hw->settings->fs_table[id];
-	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++) {
-		if (!fs_table->fs_avl[i].gain)
-			break;
-
+	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
 		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
-				 fs_table->fs_avl[i].gain);
-	}
+				 hw->settings->fs_table[id].fs_avl[i].gain);
 	buf[len - 1] = '\n';
 
 	return len;
-- 
2.20.1

