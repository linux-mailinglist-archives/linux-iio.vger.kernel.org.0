Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF677A164
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjHLR1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 13:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLR1Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 13:27:25 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C446710DD;
        Sat, 12 Aug 2023 10:27:27 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="176457130"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Aug 2023 02:27:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7623C404EBD4;
        Sun, 13 Aug 2023 02:27:24 +0900 (JST)
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
Subject: [PATCH] iio: chemical: vz89x: Convert enum->pointer for data in the match tables
Date:   Sat, 12 Aug 2023 18:27:18 +0100
Message-Id: <20230812172718.232718-1-biju.das.jz@bp.renesas.com>
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

Replace enum->struct *vz89x_chip_data for data in the match table. Simplify
the probe() by replacing device_get_match_data() and ID lookup for
retrieving data by i2c_get_match_data().

While at it, drop unused variables id and chip_id from probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/chemical/vz89x.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 13555f4f401a..5b358bcd311b 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -342,19 +342,17 @@ static const struct vz89x_chip_data vz89x_chips[] = {
 };
 
 static const struct of_device_id vz89x_dt_ids[] = {
-	{ .compatible = "sgx,vz89x", .data = (void *) VZ89X },
-	{ .compatible = "sgx,vz89te", .data = (void *) VZ89TE },
+	{ .compatible = "sgx,vz89x", .data = &vz89x_chips[VZ89X] },
+	{ .compatible = "sgx,vz89te", .data = &vz89x_chips[VZ89TE] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
 
 static int vz89x_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct vz89x_data *data;
-	int chip_id;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -369,14 +367,10 @@ static int vz89x_probe(struct i2c_client *client)
 	else
 		return -EOPNOTSUPP;
 
-	if (!dev_fwnode(dev))
-		chip_id = id->driver_data;
-	else
-		chip_id = (unsigned long)device_get_match_data(dev);
+	data->chip = i2c_get_match_data(client);
 
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	data->chip = &vz89x_chips[chip_id];
 	data->last_update = jiffies - HZ;
 	mutex_init(&data->lock);
 
@@ -391,8 +385,8 @@ static int vz89x_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id vz89x_id[] = {
-	{ "vz89x", VZ89X },
-	{ "vz89te", VZ89TE },
+	{ "vz89x", (kernel_ulong_t)&vz89x_chips[VZ89X] },
+	{ "vz89te", (kernel_ulong_t)&vz89x_chips[VZ89TE] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vz89x_id);
-- 
2.25.1

