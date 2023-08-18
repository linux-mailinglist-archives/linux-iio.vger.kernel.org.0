Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014E07812FD
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379461AbjHRSlD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 14:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379464AbjHRSko (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 14:40:44 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 461623A80;
        Fri, 18 Aug 2023 11:40:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="176990467"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Aug 2023 03:40:42 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5C6F74071A6C;
        Sat, 19 Aug 2023 03:40:39 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 RESEND 1/2] iio: accel: mma8452: Convert enum->pointer for data in the ID table
Date:   Fri, 18 Aug 2023 19:40:32 +0100
Message-Id: <20230818184033.335502-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818184033.335502-1-biju.das.jz@bp.renesas.com>
References: <20230818184033.335502-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v1->v2 resend:
* Added Rb tag from Hans de Goede.
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

