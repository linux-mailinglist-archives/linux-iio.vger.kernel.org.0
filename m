Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9037E609395
	for <lists+linux-iio@lfdr.de>; Sun, 23 Oct 2022 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiJWNXh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Oct 2022 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiJWNXa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2022 09:23:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D976FC4A
        for <linux-iio@vger.kernel.org>; Sun, 23 Oct 2022 06:23:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawX-0006qH-Vo; Sun, 23 Oct 2022 15:23:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawW-000ygH-4u; Sun, 23 Oct 2022 15:23:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1omawV-00A3Qk-DM; Sun, 23 Oct 2022 15:23:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 03/23] iio: accel: bma400: Convert to i2c's .probe_new
Date:   Sun, 23 Oct 2022 15:22:42 +0200
Message-Id: <20221023132302.911644-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LFfCPOIAMk+cTROD/thqfLSzOM/JB9AegkaUfckA+jY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjVT9IZLkBQIYChZWJldf7a7/KlVJ8XEKyYnuPe2++ n8S+mCSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY1U/SAAKCRDB/BR4rcrsCfInB/ 9/c0s4rOpEarUjTJmCgIU5xNDbFXNFOlHqBWD2lUVfgTBbetEcisosqLXb9wvyKSwM6HW46RTtHIa7 uAYUvJ7As/b8aCvorj6iA3RQBPplHbVsxXklYycOTT6MdrFZOxgaFPR0pfmqmiFY67nP4Dv61zSfDk RmsR32gff6itS9YbYff0YqYLiNfWUMwZ8dynD3SJ7PQB4oyWhszsjnMGBrTH5EzKbdNcRM5PkxyhYZ KhMKeD/r8ZzQBDCV4TIUKVJzwI5ZofaYxXTUab/irEAkaXAavc0KDHPsWRZtemPmNHDmo3makPxURY JwQYyjmRc7quqUWmxtZpgxH4IoVwVI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

.probe_new() doesn't get the i2c_device_id * parameter, so determine
that explicitly in .probe(). The device_id array has to move up for that
to work.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/bma400_i2c.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
index 1ba2a982ea73..cf7a830d6baf 100644
--- a/drivers/iio/accel/bma400_i2c.c
+++ b/drivers/iio/accel/bma400_i2c.c
@@ -13,10 +13,16 @@
 
 #include "bma400.h"
 
-static int bma400_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static const struct i2c_device_id bma400_i2c_ids[] = {
+	{ "bma400", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bma400_i2c_ids);
+
+static int bma400_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
+	const struct i2c_device_id *id = i2c_match_id(bma400_i2c_ids, client);
 
 	regmap = devm_regmap_init_i2c(client, &bma400_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -27,12 +33,6 @@ static int bma400_i2c_probe(struct i2c_client *client,
 	return bma400_probe(&client->dev, regmap, client->irq, id->name);
 }
 
-static const struct i2c_device_id bma400_i2c_ids[] = {
-	{ "bma400", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, bma400_i2c_ids);
-
 static const struct of_device_id bma400_of_i2c_match[] = {
 	{ .compatible = "bosch,bma400" },
 	{ }
@@ -44,7 +44,7 @@ static struct i2c_driver bma400_i2c_driver = {
 		.name = "bma400",
 		.of_match_table = bma400_of_i2c_match,
 	},
-	.probe    = bma400_i2c_probe,
+	.probe_new = bma400_i2c_probe,
 	.id_table = bma400_i2c_ids,
 };
 
-- 
2.37.2

