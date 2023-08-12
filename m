Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B7E77A086
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 16:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjHLOlK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 10:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLOlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 10:41:10 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70CA4113;
        Sat, 12 Aug 2023 07:41:11 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="176449370"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2023 23:41:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3BBF742009AE;
        Sat, 12 Aug 2023 23:41:07 +0900 (JST)
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
Subject: [PATCH] iio: potentiometer: ds1803: Convert enum->pointer for data in the ID table
Date:   Sat, 12 Aug 2023 15:41:06 +0100
Message-Id: <20230812144106.163355-1-biju.das.jz@bp.renesas.com>
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

Replace enum->struct *ds1803_cfg for data in the ID table and simplify
ds1803_probe() by replacing device_get_match_data() with
i2c_get_match_data().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/potentiometer/ds1803.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index fc183e0790da..e0526dd0e3cb 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -204,7 +204,6 @@ static const struct iio_info ds1803_info = {
 
 static int ds1803_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct device *dev = &client->dev;
 	struct ds1803_data *data;
 	struct iio_dev *indio_dev;
@@ -217,9 +216,7 @@ static int ds1803_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	data->cfg = device_get_match_data(dev);
-	if (!data->cfg)
-		data->cfg = &ds1803_cfg[id->driver_data];
+	data->cfg = i2c_get_match_data(client);
 
 	indio_dev->info = &ds1803_info;
 	indio_dev->channels = data->cfg->channels;
@@ -239,10 +236,10 @@ static const struct of_device_id ds1803_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
 
 static const struct i2c_device_id ds1803_id[] = {
-	{ "ds1803-010", DS1803_010 },
-	{ "ds1803-050", DS1803_050 },
-	{ "ds1803-100", DS1803_100 },
-	{ "ds3502", DS3502 },
+	{ "ds1803-010", (kernel_ulong_t)&ds1803_cfg[DS1803_010] },
+	{ "ds1803-050", (kernel_ulong_t)&ds1803_cfg[DS1803_050] },
+	{ "ds1803-100", (kernel_ulong_t)&ds1803_cfg[DS1803_100] },
+	{ "ds3502", (kernel_ulong_t)&ds1803_cfg[DS3502] },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ds1803_id);
-- 
2.25.1

