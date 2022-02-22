Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DD84BF173
	for <lists+linux-iio@lfdr.de>; Tue, 22 Feb 2022 06:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiBVFd2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Feb 2022 00:33:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiBVFdL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2022 00:33:11 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ECC11A39
        for <linux-iio@vger.kernel.org>; Mon, 21 Feb 2022 21:32:45 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7580A1A170F;
        Tue, 22 Feb 2022 05:54:21 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C9821A23FF;
        Tue, 22 Feb 2022 05:54:21 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 193B7183AC94;
        Tue, 22 Feb 2022 12:54:20 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        pmeerw@pmeerw.net
Cc:     haibo.chen@nxp.com, linux-imx@nxp.com
Subject: [PATCH] iio: accel: mma8452: remove the reset operation during driver probe
Date:   Tue, 22 Feb 2022 12:45:51 +0800
Message-Id: <1645505151-5789-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Though Sensor Datasheet define this reset bit in it's CTRL_REG2
register, but seems the actual hardware behavior do not align with
the doc expect. Once the reset bit is set, sensor can’t give back
an I2C ack, which will cause the probe fail. So just remove this
reset operation.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/accel/mma8452.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 0016bb947c10..ec9e26fdfb2a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1481,30 +1481,6 @@ static void mma8452_trigger_cleanup(struct iio_dev *indio_dev)
 		iio_trigger_unregister(indio_dev->trig);
 }
 
-static int mma8452_reset(struct i2c_client *client)
-{
-	int i;
-	int ret;
-
-	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
-					MMA8452_CTRL_REG2_RST);
-	if (ret < 0)
-		return ret;
-
-	for (i = 0; i < 10; i++) {
-		usleep_range(100, 200);
-		ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG2);
-		if (ret == -EIO)
-			continue; /* I2C comm reset */
-		if (ret < 0)
-			return ret;
-		if (!(ret & MMA8452_CTRL_REG2_RST))
-			return 0;
-	}
-
-	return -ETIMEDOUT;
-}
-
 static const struct of_device_id mma8452_dt_ids[] = {
 	{ .compatible = "fsl,mma8451", .data = &mma_chip_info_table[mma8451] },
 	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
@@ -1591,10 +1567,6 @@ static int mma8452_probe(struct i2c_client *client,
 	indio_dev->num_channels = data->chip_info->num_channels;
 	indio_dev->available_scan_masks = mma8452_scan_masks;
 
-	ret = mma8452_reset(client);
-	if (ret < 0)
-		goto disable_regulators;
-
 	data->data_cfg = MMA8452_DATA_CFG_FS_2G;
 	ret = i2c_smbus_write_byte_data(client, MMA8452_DATA_CFG,
 					data->data_cfg);
-- 
2.25.1

