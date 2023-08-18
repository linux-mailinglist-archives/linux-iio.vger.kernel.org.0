Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1C78131B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 20:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379546AbjHRSzo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379542AbjHRSzk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 14:55:40 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32C673A98;
        Fri, 18 Aug 2023 11:55:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="173297301"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Aug 2023 03:55:37 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 413A84001DC3;
        Sat, 19 Aug 2023 03:55:33 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] iio: chemical: atlas-sensor: Convert enum->pointer for data in the match tables
Date:   Fri, 18 Aug 2023 19:55:31 +0100
Message-Id: <20230818185531.336672-1-biju.das.jz@bp.renesas.com>
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

Convert enum->pointer for data in the match tables, so that
device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
bus type match support added to it.

Replace enum->struct *atlas_device for data in the match table. Simplify
the probe() by replacing device_get_match_data() and ID lookup for
retrieving data by i2c_get_match_data().

While at it, add const qualifier to struct atlas_device and drop inner
trailing commas from OF table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v1->v2:
 * Added Rb tag from Andy
 * Dropped id variable removal sentance from commit description
 * Dropped inner trailing commas from commit description.
---
 drivers/iio/chemical/atlas-sensor.c | 32 +++++++++++++----------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index fb15bb216019..baf93e5e3ca7 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -87,7 +87,7 @@ enum {
 struct atlas_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
-	struct atlas_device *chip;
+	const struct atlas_device *chip;
 	struct regmap *regmap;
 	struct irq_work work;
 	unsigned int interrupt_enabled;
@@ -353,7 +353,7 @@ struct atlas_device {
 	int delay;
 };
 
-static struct atlas_device atlas_devices[] = {
+static const struct atlas_device atlas_devices[] = {
 	[ATLAS_PH_SM] = {
 				.channels = atlas_ph_channels,
 				.num_channels = 3,
@@ -589,30 +589,29 @@ static const struct iio_info atlas_info = {
 };
 
 static const struct i2c_device_id atlas_id[] = {
-	{ "atlas-ph-sm", ATLAS_PH_SM },
-	{ "atlas-ec-sm", ATLAS_EC_SM },
-	{ "atlas-orp-sm", ATLAS_ORP_SM },
-	{ "atlas-do-sm", ATLAS_DO_SM },
-	{ "atlas-rtd-sm", ATLAS_RTD_SM },
+	{ "atlas-ph-sm", (kernel_ulong_t)&atlas_devices[ATLAS_PH_SM] },
+	{ "atlas-ec-sm", (kernel_ulong_t)&atlas_devices[ATLAS_EC_SM] },
+	{ "atlas-orp-sm", (kernel_ulong_t)&atlas_devices[ATLAS_ORP_SM] },
+	{ "atlas-do-sm", (kernel_ulong_t)&atlas_devices[ATLAS_DO_SM] },
+	{ "atlas-rtd-sm", (kernel_ulong_t)&atlas_devices[ATLAS_RTD_SM] },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_id);
 
 static const struct of_device_id atlas_dt_ids[] = {
-	{ .compatible = "atlas,ph-sm", .data = (void *)ATLAS_PH_SM, },
-	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
-	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
-	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
-	{ .compatible = "atlas,rtd-sm", .data = (void *)ATLAS_RTD_SM, },
+	{ .compatible = "atlas,ph-sm", .data = &atlas_devices[ATLAS_PH_SM] },
+	{ .compatible = "atlas,ec-sm", .data = &atlas_devices[ATLAS_EC_SM] },
+	{ .compatible = "atlas,orp-sm", .data = &atlas_devices[ATLAS_ORP_SM] },
+	{ .compatible = "atlas,do-sm", .data = &atlas_devices[ATLAS_DO_SM] },
+	{ .compatible = "atlas,rtd-sm", .data = &atlas_devices[ATLAS_RTD_SM] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, atlas_dt_ids);
 
 static int atlas_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct atlas_data *data;
-	struct atlas_device *chip;
+	const struct atlas_device *chip;
 	struct iio_trigger *trig;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -621,10 +620,7 @@ static int atlas_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	if (!dev_fwnode(&client->dev))
-		chip = &atlas_devices[id->driver_data];
-	else
-		chip = &atlas_devices[(unsigned long)device_get_match_data(&client->dev)];
+	chip = i2c_get_match_data(client);
 
 	indio_dev->info = &atlas_info;
 	indio_dev->name = ATLAS_DRV_NAME;
-- 
2.25.1

