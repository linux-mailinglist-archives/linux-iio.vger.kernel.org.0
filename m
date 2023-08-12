Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44777A07E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjHLObF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjHLObE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 10:31:04 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FA80CA;
        Sat, 12 Aug 2023 07:31:07 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="172764721"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Aug 2023 23:31:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3844541FE80D;
        Sat, 12 Aug 2023 23:31:02 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: accel: mma8452: Convert enum->pointer for data in the ID table
Date:   Sat, 12 Aug 2023 15:31:00 +0100
Message-Id: <20230812143100.159700-1-biju.das.jz@bp.renesas.com>
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

Convert enum->pointer for data in the ID table, so that
device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
bus type match support added to it.

Replace enum->struct *mma_chip_info for data in the ID table and simplify
mma8452_probe() by replacing device_get_match_data() with
i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/accel/mma8452.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index f42a88711486..5864ad726e97 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1547,7 +1547,6 @@ MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
 
 static int mma8452_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct mma8452_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -1560,15 +1559,10 @@ static int mma8452_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 
-	data->chip_info = device_get_match_data(&client->dev);
-	if (!data->chip_info) {
-		if (id) {
-			data->chip_info = &mma_chip_info_table[id->driver_data];
-		} else {
-			dev_err(&client->dev, "unknown device model\n");
-			return -ENODEV;
-		}
-	}
+	data->chip_info = i2c_get_match_data(client);
+	if (!data->chip_info)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "unknown device model\n");
 
 	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
 	if (ret)
@@ -1830,12 +1824,12 @@ static const struct dev_pm_ops mma8452_pm_ops = {
 };
 
 static const struct i2c_device_id mma8452_id[] = {
-	{ "mma8451", mma8451 },
-	{ "mma8452", mma8452 },
-	{ "mma8453", mma8453 },
-	{ "mma8652", mma8652 },
-	{ "mma8653", mma8653 },
-	{ "fxls8471", fxls8471 },
+	{ "mma8451", (kernel_ulong_t)&mma_chip_info_table[mma8451] },
+	{ "mma8452", (kernel_ulong_t)&mma_chip_info_table[mma8452] },
+	{ "mma8453", (kernel_ulong_t)&mma_chip_info_table[mma8453] },
+	{ "mma8652", (kernel_ulong_t)&mma_chip_info_table[mma8652] },
+	{ "mma8653", (kernel_ulong_t)&mma_chip_info_table[mma8653] },
+	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mma8452_id);
-- 
2.25.1

