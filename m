Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C577E8E1
	for <lists+linux-iio@lfdr.de>; Wed, 16 Aug 2023 20:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjHPSkk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Aug 2023 14:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbjHPSkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Aug 2023 14:40:23 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C8A41B2;
        Wed, 16 Aug 2023 11:40:21 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173112494"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Aug 2023 03:40:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.33])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EC5F5406C46D;
        Thu, 17 Aug 2023 03:40:17 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: magnetometer: ak8975: Convert enum->pointer for data in the match tables
Date:   Wed, 16 Aug 2023 19:40:15 +0100
Message-Id: <20230816184015.12420-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert enum->pointer for data in the match tables to simplify the probe()
by replacing device_get_match_data() and i2c_client_get_device_id by
i2c_get_match_data() as we have similar I2C, ACPI and DT matching table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 * This patch is only compile tested.
---
 drivers/iio/magnetometer/ak8975.c | 75 +++++++++++++------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index eb706d0bf70b..104798549de1 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -813,13 +813,13 @@ static const struct iio_info ak8975_info = {
 };
 
 static const struct acpi_device_id ak_acpi_match[] = {
-	{"AK8975", AK8975},
-	{"AK8963", AK8963},
-	{"INVN6500", AK8963},
-	{"AK009911", AK09911},
-	{"AK09911", AK09911},
-	{"AKM9911", AK09911},
-	{"AK09912", AK09912},
+	{"AK8975", (kernel_ulong_t)&ak_def_array[AK8975] },
+	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
+	{"INVN6500", (kernel_ulong_t)&ak_def_array[AK8963] },
+	{"AK009911", (kernel_ulong_t)&ak_def_array[AK09911] },
+	{"AK09911", (kernel_ulong_t)&ak_def_array[AK09911] },
+	{"AKM9911", (kernel_ulong_t)&ak_def_array[AK09911] },
+	{"AK09912", (kernel_ulong_t)&ak_def_array[AK09912] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
@@ -883,10 +883,7 @@ static int ak8975_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct gpio_desc *eoc_gpiod;
 	struct gpio_desc *reset_gpiod;
-	const void *match;
-	unsigned int i;
 	int err;
-	enum asahi_compass_chipset chipset;
 	const char *name = NULL;
 
 	/*
@@ -928,27 +925,15 @@ static int ak8975_probe(struct i2c_client *client)
 		return err;
 
 	/* id will be NULL when enumerated via ACPI */
-	match = device_get_match_data(&client->dev);
-	if (match) {
-		chipset = (uintptr_t)match;
-		name = dev_name(&client->dev);
-	} else if (id) {
-		chipset = (enum asahi_compass_chipset)(id->driver_data);
-		name = id->name;
-	} else
-		return -ENOSYS;
-
-	for (i = 0; i < ARRAY_SIZE(ak_def_array); i++)
-		if (ak_def_array[i].type == chipset)
-			break;
-
-	if (i == ARRAY_SIZE(ak_def_array)) {
-		dev_err(&client->dev, "AKM device type unsupported: %d\n",
-			chipset);
+	data->def = i2c_get_match_data(client);
+	if (!data->def)
 		return -ENODEV;
-	}
 
-	data->def = &ak_def_array[i];
+	/* If enumerated via firmware node, fix the ABI */
+	if (dev_fwnode(&client->dev))
+		name = dev_name(&client->dev);
+	else
+		name = id->name;
 
 	/* Fetch the regulators */
 	data->vdd = devm_regulator_get(&client->dev, "vdd");
@@ -1077,28 +1062,28 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ak8975_dev_pm_ops, ak8975_runtime_suspend,
 				 ak8975_runtime_resume, NULL);
 
 static const struct i2c_device_id ak8975_id[] = {
-	{"ak8975", AK8975},
-	{"ak8963", AK8963},
-	{"AK8963", AK8963},
-	{"ak09911", AK09911},
-	{"ak09912", AK09912},
-	{"ak09916", AK09916},
+	{"ak8975", (kernel_ulong_t)&ak_def_array[AK8975] },
+	{"ak8963", (kernel_ulong_t)&ak_def_array[AK8963] },
+	{"AK8963", (kernel_ulong_t)&ak_def_array[AK8963] },
+	{"ak09911", (kernel_ulong_t)&ak_def_array[AK09911] },
+	{"ak09912", (kernel_ulong_t)&ak_def_array[AK09912] },
+	{"ak09916", (kernel_ulong_t)&ak_def_array[AK09916] },
 	{}
 };
 
 MODULE_DEVICE_TABLE(i2c, ak8975_id);
 
 static const struct of_device_id ak8975_of_match[] = {
-	{ .compatible = "asahi-kasei,ak8975", },
-	{ .compatible = "ak8975", },
-	{ .compatible = "asahi-kasei,ak8963", },
-	{ .compatible = "ak8963", },
-	{ .compatible = "asahi-kasei,ak09911", },
-	{ .compatible = "ak09911", },
-	{ .compatible = "asahi-kasei,ak09912", },
-	{ .compatible = "ak09912", },
-	{ .compatible = "asahi-kasei,ak09916", },
-	{ .compatible = "ak09916", },
+	{ .compatible = "asahi-kasei,ak8975", .data = &ak_def_array[AK8975] },
+	{ .compatible = "ak8975", .data = &ak_def_array[AK8975] },
+	{ .compatible = "asahi-kasei,ak8963", .data = &ak_def_array[AK8963] },
+	{ .compatible = "ak8963", .data = &ak_def_array[AK8963] },
+	{ .compatible = "asahi-kasei,ak09911", .data = &ak_def_array[AK09911] },
+	{ .compatible = "ak09911", .data = &ak_def_array[AK09911] },
+	{ .compatible = "asahi-kasei,ak09912", .data = &ak_def_array[AK09912] },
+	{ .compatible = "ak09912", .data = &ak_def_array[AK09912] },
+	{ .compatible = "asahi-kasei,ak09916", .data = &ak_def_array[AK09916] },
+	{ .compatible = "ak09916", .data = &ak_def_array[AK09916] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ak8975_of_match);
-- 
2.25.1

