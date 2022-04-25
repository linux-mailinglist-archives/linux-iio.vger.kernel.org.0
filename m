Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D3850DBB1
	for <lists+linux-iio@lfdr.de>; Mon, 25 Apr 2022 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiDYIzc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Apr 2022 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiDYIzb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2022 04:55:31 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A6E0DB
        for <linux-iio@vger.kernel.org>; Mon, 25 Apr 2022 01:52:26 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C3BA820180D;
        Mon, 25 Apr 2022 10:52:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7BCF0201805;
        Mon, 25 Apr 2022 10:52:24 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1A8F8180031A;
        Mon, 25 Apr 2022 16:52:23 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     haibo.chen@nxp.com, hdegoede@redhat.com, linux-iio@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] iio: mma8452: fix probe fail when device tree compatible is used.
Date:   Mon, 25 Apr 2022 16:41:00 +0800
Message-Id: <1650876060-17577-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Correct the logic for the probe. First check of_match_table, if
not meet, then check i2c_driver.id_table. If both not meet, then
return fail.

Fixes: a47ac019e7e8 ("iio: mma8452: Fix probe failing when an i2c_device_id is used")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/accel/mma8452.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 9c02c681c84c..4156d216c640 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1556,11 +1556,13 @@ static int mma8452_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	data->chip_info = device_get_match_data(&client->dev);
-	if (!data->chip_info && id) {
-		data->chip_info = &mma_chip_info_table[id->driver_data];
-	} else {
-		dev_err(&client->dev, "unknown device model\n");
-		return -ENODEV;
+	if (!data->chip_info) {
+		if (id) {
+			data->chip_info = &mma_chip_info_table[id->driver_data];
+		} else {
+			dev_err(&client->dev, "unknown device model\n");
+			return -ENODEV;
+		}
 	}
 
 	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
-- 
2.25.1

