Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D975977A058
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 16:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjHLOKu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjHLOKt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 10:10:49 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B10410E4;
        Sat, 12 Aug 2023 07:10:52 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="176447202"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2023 23:10:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5B7744003FAE;
        Sat, 12 Aug 2023 23:10:48 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Crt Mori <cmo@melexis.com>, Rob Herring <robh@kernel.org>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: accel: bma180: Convert enum->pointer for data in the match table
Date:   Sat, 12 Aug 2023 15:10:44 +0100
Message-Id: <20230812141044.151520-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert enum->pointer for data in the match table, so that
device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
bus type match support added to it.

Replace enum->struct *bma180_part_info for data in the match table and
simplify bma180_probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/accel/bma180.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 13439f52d26d..ab4fccb24b6c 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -926,7 +926,6 @@ static int bma180_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct bma180_data *data;
 	struct iio_dev *indio_dev;
-	enum chip_ids chip;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -936,11 +935,7 @@ static int bma180_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	if (client->dev.of_node)
-		chip = (uintptr_t)of_device_get_match_data(dev);
-	else
-		chip = id->driver_data;
-	data->part_info = &bma180_part_info[chip];
+	data->part_info = i2c_get_match_data(client);
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
@@ -1092,11 +1087,11 @@ static int bma180_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 
 static const struct i2c_device_id bma180_ids[] = {
-	{ "bma023", BMA023 },
-	{ "bma150", BMA150 },
-	{ "bma180", BMA180 },
-	{ "bma250", BMA250 },
-	{ "smb380", BMA150 },
+	{ "bma023", (kernel_ulong_t)&bma180_part_info[BMA023] },
+	{ "bma150", (kernel_ulong_t)&bma180_part_info[BMA150] },
+	{ "bma180", (kernel_ulong_t)&bma180_part_info[BMA180] },
+	{ "bma250", (kernel_ulong_t)&bma180_part_info[BMA250] },
+	{ "smb380", (kernel_ulong_t)&bma180_part_info[BMA150] },
 	{ }
 };
 
@@ -1105,23 +1100,23 @@ MODULE_DEVICE_TABLE(i2c, bma180_ids);
 static const struct of_device_id bma180_of_match[] = {
 	{
 		.compatible = "bosch,bma023",
-		.data = (void *)BMA023
+		.data = &bma180_part_info[BMA023]
 	},
 	{
 		.compatible = "bosch,bma150",
-		.data = (void *)BMA150
+		.data = &bma180_part_info[BMA150]
 	},
 	{
 		.compatible = "bosch,bma180",
-		.data = (void *)BMA180
+		.data = &bma180_part_info[BMA180]
 	},
 	{
 		.compatible = "bosch,bma250",
-		.data = (void *)BMA250
+		.data = &bma180_part_info[BMA250]
 	},
 	{
 		.compatible = "bosch,smb380",
-		.data = (void *)BMA150
+		.data = &bma180_part_info[BMA150]
 	},
 	{ }
 };
-- 
2.25.1

