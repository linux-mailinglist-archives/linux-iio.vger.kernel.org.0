Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441D954C7AC
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 13:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiFOLp6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiFOLp5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 07:45:57 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4062227CF6
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 04:45:57 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D9B4D200D42;
        Wed, 15 Jun 2022 13:45:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A39D7200D40;
        Wed, 15 Jun 2022 13:45:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7A555180219B;
        Wed, 15 Jun 2022 19:45:54 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     haibo.chen@nxp.com, hdegoede@redhat.com, linux-iio@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v2] iio: accel: mma8452: ignore the return value of reset operation
Date:   Wed, 15 Jun 2022 19:31:58 +0800
Message-Id: <1655292718-14287-1-git-send-email-haibo.chen@nxp.com>
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

On fxls8471, after set the reset bit, the device will reset immediately,
will not give ACK. So ignore the return value of this reset operation,
let the following code logic to check whether the reset operation works.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/iio/accel/mma8452.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index e0f0c0abed28..c7d9ca96dbaa 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1511,10 +1511,14 @@ static int mma8452_reset(struct i2c_client *client)
 	int i;
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
+	/*
+	 * Find on fxls8471, after config reset bit, it reset immediately,
+	 * and will not give ACK, so here do not check the return value.
+	 * The following code will read the reset register, and check whether
+	 * this reset works.
+	 */
+	i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG2,
 					MMA8452_CTRL_REG2_RST);
-	if (ret < 0)
-		return ret;
 
 	for (i = 0; i < 10; i++) {
 		usleep_range(100, 200);
-- 
2.25.1

