Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7ED4C2B14
	for <lists+linux-iio@lfdr.de>; Thu, 24 Feb 2022 12:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiBXLjC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Feb 2022 06:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiBXLjB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Feb 2022 06:39:01 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9C1A58EA
        for <linux-iio@vger.kernel.org>; Thu, 24 Feb 2022 03:38:30 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 474AE2010F1;
        Thu, 24 Feb 2022 12:38:29 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F1272010E2;
        Thu, 24 Feb 2022 12:38:29 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D9B6A183AC8A;
        Thu, 24 Feb 2022 19:38:27 +0800 (+08)
From:   haibo.chen@nxp.com
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, haibo.chen@nxp.com, linux-imx@nxp.com
Subject: [PATCH] iio: imu: st_lsm6dsx: use dev_to_iio_dev() to get iio_dev struct
Date:   Thu, 24 Feb 2022 19:29:51 +0800
Message-Id: <1645702191-9400-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

After commit 8b7651f25962 ("iio: iio_device_alloc(): Remove
unnecessary self drvdata"), current driver will meet kernel dump,
kernel handle NULL pointer dereference.

Use dev_to_iio_dev() to get iio_dev struct.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 93f0c6bce502..b1d8d5a66f01 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1633,7 +1633,7 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
 	const struct st_lsm6dsx_odr_table_entry *odr_table;
 	int i, len = 0;
 
@@ -1651,7 +1651,7 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 					    struct device_attribute *attr,
 					    char *buf)
 {
-	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
 	const struct st_lsm6dsx_fs_table_entry *fs_table;
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int i, len = 0;
-- 
2.25.1

