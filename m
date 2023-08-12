Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675F377A130
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjHLQ5g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjHLQ5f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 12:57:35 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 587E510FC;
        Sat, 12 Aug 2023 09:57:36 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="176455615"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Aug 2023 01:57:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 76A1C403CD7C;
        Sun, 13 Aug 2023 01:57:32 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: chemical: sgp30: Convert enum->pointer for data in the match tables
Date:   Sat, 12 Aug 2023 17:57:30 +0100
Message-Id: <20230812165730.216180-1-biju.das.jz@bp.renesas.com>
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

Convert enum->pointer for data in the match tables, so that
device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
bus type match support added to it.

Add product_id variable to struct sgp_device and remove the local variable
product_id in probe() and replace enum->struct *sgp_device for data in the
match table. Simplify theprobe() by replacing device_get_match_data() and
ID lookup for retrieving data by i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/chemical/sgp30.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index b509cff9ce37..21730d62b5c8 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -114,6 +114,7 @@ struct sgp_data {
 };
 
 struct sgp_device {
+	unsigned long product_id;
 	const struct iio_chan_spec *channels;
 	int num_channels;
 };
@@ -182,10 +183,12 @@ static const struct iio_chan_spec sgpc3_channels[] = {
 
 static const struct sgp_device sgp_devices[] = {
 	[SGP30] = {
+		.product_id = SGP30,
 		.channels = sgp30_channels,
 		.num_channels = ARRAY_SIZE(sgp30_channels),
 	},
 	[SGPC3] = {
+		.product_id = SGPC3,
 		.channels = sgpc3_channels,
 		.num_channels = ARRAY_SIZE(sgpc3_channels),
 	},
@@ -491,28 +494,25 @@ static const struct iio_info sgp_info = {
 };
 
 static const struct of_device_id sgp_dt_ids[] = {
-	{ .compatible = "sensirion,sgp30", .data = (void *)SGP30 },
-	{ .compatible = "sensirion,sgpc3", .data = (void *)SGPC3 },
+	{ .compatible = "sensirion,sgp30", .data = &sgp_devices[SGP30] },
+	{ .compatible = "sensirion,sgpc3", .data = &sgp_devices[SGPC3] },
 	{ }
 };
 
 static int sgp_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct sgp_device *match_data;
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct sgp_data *data;
-	unsigned long product_id;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
-	if (dev_fwnode(dev))
-		product_id = (unsigned long)device_get_match_data(dev);
-	else
-		product_id = id->driver_data;
+	match_data = i2c_get_match_data(client);
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
@@ -528,15 +528,15 @@ static int sgp_probe(struct i2c_client *client)
 
 	data->feature_set = be16_to_cpu(data->buffer.raw_words[0].value);
 
-	ret = sgp_check_compat(data, product_id);
+	ret = sgp_check_compat(data, match_data->product_id);
 	if (ret)
 		return ret;
 
 	indio_dev->info = &sgp_info;
 	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = sgp_devices[product_id].channels;
-	indio_dev->num_channels = sgp_devices[product_id].num_channels;
+	indio_dev->channels = match_data->channels;
+	indio_dev->num_channels = match_data->num_channels;
 
 	sgp_init(data);
 
@@ -562,8 +562,8 @@ static void sgp_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sgp_id[] = {
-	{ "sgp30", SGP30 },
-	{ "sgpc3", SGPC3 },
+	{ "sgp30", (kernel_ulong_t)&sgp_devices[SGP30] },
+	{ "sgpc3", (kernel_ulong_t)&sgp_devices[SGPC3] },
 	{ }
 };
 
-- 
2.25.1

