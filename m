Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAA9779DD2
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 08:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjHLG54 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 02:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHLG54 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 02:57:56 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E19192D43;
        Fri, 11 Aug 2023 23:57:54 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,167,1684767600"; 
   d="scan'208";a="172746837"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Aug 2023 15:57:54 +0900
Received: from localhost.localdomain (unknown [10.226.92.36])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8EFBE4174399;
        Sat, 12 Aug 2023 15:57:51 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/2] iio: magnetometer: yamaha-yas530: Drop enum chip_ids
Date:   Sat, 12 Aug 2023 07:57:41 +0100
Message-Id: <20230812065741.20990-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812065741.20990-1-biju.das.jz@bp.renesas.com>
References: <20230812065741.20990-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Drop the unnecessary enum chip_ids by splitting the array
yas5xx_chip_info_tbl[] as individual variables.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch.
---
 drivers/iio/magnetometer/yamaha-yas530.c | 146 +++++++++++------------
 1 file changed, 70 insertions(+), 76 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 7b041bb38693..0ff3d81e24b4 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -133,13 +133,6 @@
 /* Turn off device regulators etc after 5 seconds of inactivity */
 #define YAS5XX_AUTOSUSPEND_DELAY_MS	5000
 
-enum chip_ids {
-	yas530,
-	yas532,
-	yas533,
-	yas537,
-};
-
 static const int yas530_volatile_reg[] = {
 	YAS530_ACTUATE_INIT_COIL,
 	YAS530_MEASURE,
@@ -1321,67 +1314,68 @@ static int yas537_power_on(struct yas5xx *yas5xx)
 	return 0;
 }
 
-static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
-	[yas530] = {
-		.devid = YAS530_DEVICE_ID,
-		.product_name = "YAS530 MS-3E",
-		.version_names = { "A", "B" },
-		.volatile_reg = yas530_volatile_reg,
-		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
-		.scaling_val2 = 100000000, /* picotesla to Gauss */
-		.t_ref = 182, /* counts */
-		.min_temp_x10 = -620, /* 1/10:s degrees Celsius */
-		.get_measure = yas530_get_measure,
-		.get_calibration_data = yas530_get_calibration_data,
-		.dump_calibration = yas530_dump_calibration,
-		.measure_offsets = yas530_measure_offsets,
-		.power_on = yas530_power_on,
-	},
-	[yas532] = {
-		.devid = YAS532_DEVICE_ID,
-		.product_name = "YAS532 MS-3R",
-		.version_names = { "AB", "AC" },
-		.volatile_reg = yas530_volatile_reg,
-		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
-		.scaling_val2 = 100000, /* nanotesla to Gauss */
-		.t_ref = 390, /* counts */
-		.min_temp_x10 = -500, /* 1/10:s degrees Celsius */
-		.get_measure = yas530_get_measure,
-		.get_calibration_data = yas532_get_calibration_data,
-		.dump_calibration = yas530_dump_calibration,
-		.measure_offsets = yas530_measure_offsets,
-		.power_on = yas530_power_on,
-	},
-	[yas533] = {
-		.devid = YAS532_DEVICE_ID,
-		.product_name = "YAS533 MS-3F",
-		.version_names = { "AB", "AC" },
-		.volatile_reg = yas530_volatile_reg,
-		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
-		.scaling_val2 = 100000, /* nanotesla to Gauss */
-		.t_ref = 390, /* counts */
-		.min_temp_x10 = -500, /* 1/10:s degrees Celsius */
-		.get_measure = yas530_get_measure,
-		.get_calibration_data = yas532_get_calibration_data,
-		.dump_calibration = yas530_dump_calibration,
-		.measure_offsets = yas530_measure_offsets,
-		.power_on = yas530_power_on,
-	},
-	[yas537] = {
-		.devid = YAS537_DEVICE_ID,
-		.product_name = "YAS537 MS-3T",
-		.version_names = { "v0", "v1" }, /* version naming unknown */
-		.volatile_reg = yas537_volatile_reg,
-		.volatile_reg_qty = ARRAY_SIZE(yas537_volatile_reg),
-		.scaling_val2 = 100000, /* nanotesla to Gauss */
-		.t_ref = 8120, /* counts */
-		.min_temp_x10 = -3860, /* 1/10:s degrees Celsius */
-		.get_measure = yas537_get_measure,
-		.get_calibration_data = yas537_get_calibration_data,
-		.dump_calibration = yas537_dump_calibration,
-		/* .measure_offets is not needed for yas537 */
-		.power_on = yas537_power_on,
-	},
+static const struct yas5xx_chip_info yas530_chip_info = {
+	.devid = YAS530_DEVICE_ID,
+	.product_name = "YAS530 MS-3E",
+	.version_names = { "A", "B" },
+	.volatile_reg = yas530_volatile_reg,
+	.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+	.scaling_val2 = 100000000, /* picotesla to Gauss */
+	.t_ref = 182, /* counts */
+	.min_temp_x10 = -620, /* 1/10:s degrees Celsius */
+	.get_measure = yas530_get_measure,
+	.get_calibration_data = yas530_get_calibration_data,
+	.dump_calibration = yas530_dump_calibration,
+	.measure_offsets = yas530_measure_offsets,
+	.power_on = yas530_power_on,
+};
+
+static const struct yas5xx_chip_info yas532_chip_info = {
+	.devid = YAS532_DEVICE_ID,
+	.product_name = "YAS532 MS-3R",
+	.version_names = { "AB", "AC" },
+	.volatile_reg = yas530_volatile_reg,
+	.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+	.scaling_val2 = 100000, /* nanotesla to Gauss */
+	.t_ref = 390, /* counts */
+	.min_temp_x10 = -500, /* 1/10:s degrees Celsius */
+	.get_measure = yas530_get_measure,
+	.get_calibration_data = yas532_get_calibration_data,
+	.dump_calibration = yas530_dump_calibration,
+	.measure_offsets = yas530_measure_offsets,
+	.power_on = yas530_power_on,
+};
+
+static const struct yas5xx_chip_info yas533_chip_info = {
+	.devid = YAS532_DEVICE_ID,
+	.product_name = "YAS533 MS-3F",
+	.version_names = { "AB", "AC" },
+	.volatile_reg = yas530_volatile_reg,
+	.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+	.scaling_val2 = 100000, /* nanotesla to Gauss */
+	.t_ref = 390, /* counts */
+	.min_temp_x10 = -500, /* 1/10:s degrees Celsius */
+	.get_measure = yas530_get_measure,
+	.get_calibration_data = yas532_get_calibration_data,
+	.dump_calibration = yas530_dump_calibration,
+	.measure_offsets = yas530_measure_offsets,
+	.power_on = yas530_power_on,
+};
+
+static const struct yas5xx_chip_info yas537_chip_info = {
+	.devid = YAS537_DEVICE_ID,
+	.product_name = "YAS537 MS-3T",
+	.version_names = { "v0", "v1" }, /* version naming unknown */
+	.volatile_reg = yas537_volatile_reg,
+	.volatile_reg_qty = ARRAY_SIZE(yas537_volatile_reg),
+	.scaling_val2 = 100000, /* nanotesla to Gauss */
+	.t_ref = 8120, /* counts */
+	.min_temp_x10 = -3860, /* 1/10:s degrees Celsius */
+	.get_measure = yas537_get_measure,
+	.get_calibration_data = yas537_get_calibration_data,
+	.dump_calibration = yas537_dump_calibration,
+	/* .measure_offets is not needed for yas537 */
+	.power_on = yas537_power_on,
 };
 
 static int yas5xx_probe(struct i2c_client *i2c)
@@ -1580,19 +1574,19 @@ static DEFINE_RUNTIME_DEV_PM_OPS(yas5xx_dev_pm_ops, yas5xx_runtime_suspend,
 				 yas5xx_runtime_resume, NULL);
 
 static const struct i2c_device_id yas5xx_id[] = {
-	{"yas530", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas530] },
-	{"yas532", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas532] },
-	{"yas533", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas533] },
-	{"yas537", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas537] },
+	{"yas530", (kernel_ulong_t)&yas530_chip_info },
+	{"yas532", (kernel_ulong_t)&yas532_chip_info },
+	{"yas533", (kernel_ulong_t)&yas533_chip_info },
+	{"yas537", (kernel_ulong_t)&yas537_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, yas5xx_id);
 
 static const struct of_device_id yas5xx_of_match[] = {
-	{ .compatible = "yamaha,yas530", &yas5xx_chip_info_tbl[yas530] },
-	{ .compatible = "yamaha,yas532", &yas5xx_chip_info_tbl[yas532] },
-	{ .compatible = "yamaha,yas533", &yas5xx_chip_info_tbl[yas533] },
-	{ .compatible = "yamaha,yas537", &yas5xx_chip_info_tbl[yas537] },
+	{ .compatible = "yamaha,yas530", &yas530_chip_info },
+	{ .compatible = "yamaha,yas532", &yas532_chip_info },
+	{ .compatible = "yamaha,yas533", &yas533_chip_info },
+	{ .compatible = "yamaha,yas537", &yas537_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, yas5xx_of_match);
-- 
2.25.1

