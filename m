Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD77D779DE7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 09:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjHLHY0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHLHY0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 03:24:26 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AD5112A;
        Sat, 12 Aug 2023 00:24:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,167,1684767600"; 
   d="scan'208";a="176432361"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2023 16:24:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.36])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5BFDF417E7A2;
        Sat, 12 Aug 2023 16:24:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: adc: max1363: Use i2c_get_match_data()
Date:   Sat, 12 Aug 2023 08:24:19 +0100
Message-Id: <20230812072419.42645-1-biju.das.jz@bp.renesas.com>
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

Replace device_get_match_data() and i2c_match_id() by
i2c_get_match_data() by making similar I2C and DT-based matching
table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
This patch is only compile tested.
---
 drivers/iio/adc/max1363.c | 87 ++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index b31581616ce3..7c2a98b8c3a9 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1599,9 +1599,7 @@ static int max1363_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	st->chip_info = device_get_match_data(&client->dev);
-	if (!st->chip_info)
-		st->chip_info = &max1363_chip_info_tbl[id->driver_data];
+	st->chip_info = i2c_get_match_data(client);
 	st->client = client;
 
 	st->vref_uv = st->chip_info->int_vref_mv * 1000;
@@ -1669,46 +1667,51 @@ static int max1363_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+#define MAX1363_ID_TABLE(_name, cfg) {				\
+	.name = _name,						\
+	.driver_data = (kernel_ulong_t)&max1363_chip_info_tbl[cfg],	\
+}
+
 static const struct i2c_device_id max1363_id[] = {
-	{ "max1361", max1361 },
-	{ "max1362", max1362 },
-	{ "max1363", max1363 },
-	{ "max1364", max1364 },
-	{ "max1036", max1036 },
-	{ "max1037", max1037 },
-	{ "max1038", max1038 },
-	{ "max1039", max1039 },
-	{ "max1136", max1136 },
-	{ "max1137", max1137 },
-	{ "max1138", max1138 },
-	{ "max1139", max1139 },
-	{ "max1236", max1236 },
-	{ "max1237", max1237 },
-	{ "max1238", max1238 },
-	{ "max1239", max1239 },
-	{ "max11600", max11600 },
-	{ "max11601", max11601 },
-	{ "max11602", max11602 },
-	{ "max11603", max11603 },
-	{ "max11604", max11604 },
-	{ "max11605", max11605 },
-	{ "max11606", max11606 },
-	{ "max11607", max11607 },
-	{ "max11608", max11608 },
-	{ "max11609", max11609 },
-	{ "max11610", max11610 },
-	{ "max11611", max11611 },
-	{ "max11612", max11612 },
-	{ "max11613", max11613 },
-	{ "max11614", max11614 },
-	{ "max11615", max11615 },
-	{ "max11616", max11616 },
-	{ "max11617", max11617 },
-	{ "max11644", max11644 },
-	{ "max11645", max11645 },
-	{ "max11646", max11646 },
-	{ "max11647", max11647 },
-	{}
+	MAX1363_ID_TABLE("max1361", max1361),
+	MAX1363_ID_TABLE("max1362", max1362),
+	MAX1363_ID_TABLE("max1363", max1363),
+	MAX1363_ID_TABLE("max1364", max1364),
+	MAX1363_ID_TABLE("max1036", max1036),
+	MAX1363_ID_TABLE("max1037", max1037),
+	MAX1363_ID_TABLE("max1038", max1038),
+	MAX1363_ID_TABLE("max1039", max1039),
+	MAX1363_ID_TABLE("max1136", max1136),
+	MAX1363_ID_TABLE("max1137", max1137),
+	MAX1363_ID_TABLE("max1138", max1138),
+	MAX1363_ID_TABLE("max1139", max1139),
+	MAX1363_ID_TABLE("max1236", max1236),
+	MAX1363_ID_TABLE("max1237", max1237),
+	MAX1363_ID_TABLE("max1238", max1238),
+	MAX1363_ID_TABLE("max1239", max1239),
+	MAX1363_ID_TABLE("max11600", max11600),
+	MAX1363_ID_TABLE("max11601", max11601),
+	MAX1363_ID_TABLE("max11602", max11602),
+	MAX1363_ID_TABLE("max11603", max11603),
+	MAX1363_ID_TABLE("max11604", max11604),
+	MAX1363_ID_TABLE("max11605", max11605),
+	MAX1363_ID_TABLE("max11606", max11606),
+	MAX1363_ID_TABLE("max11607", max11607),
+	MAX1363_ID_TABLE("max11608", max11608),
+	MAX1363_ID_TABLE("max11609", max11609),
+	MAX1363_ID_TABLE("max11610", max11610),
+	MAX1363_ID_TABLE("max11611", max11611),
+	MAX1363_ID_TABLE("max11612", max11612),
+	MAX1363_ID_TABLE("max11613", max11613),
+	MAX1363_ID_TABLE("max11614", max11614),
+	MAX1363_ID_TABLE("max11615", max11615),
+	MAX1363_ID_TABLE("max11616", max11616),
+	MAX1363_ID_TABLE("max11617", max11617),
+	MAX1363_ID_TABLE("max11644", max11644),
+	MAX1363_ID_TABLE("max11645", max11645),
+	MAX1363_ID_TABLE("max11646", max11646),
+	MAX1363_ID_TABLE("max11647", max11647),
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(i2c, max1363_id);
-- 
2.25.1

