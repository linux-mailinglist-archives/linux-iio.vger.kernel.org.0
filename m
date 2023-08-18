Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9777812E9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379437AbjHRSby (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379446AbjHRSbf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 14:31:35 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2497BBF;
        Fri, 18 Aug 2023 11:31:34 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="173296643"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Aug 2023 03:31:33 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C4DB3400447D;
        Sat, 19 Aug 2023 03:31:30 +0900 (JST)
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
Subject: [PATCH v2] iio: chemical: atlas-ezo-sensor: Simplify probe()
Date:   Fri, 18 Aug 2023 19:31:28 +0100
Message-Id: <20230818183128.334233-1-biju.das.jz@bp.renesas.com>
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

Simplify the probe() by replacing device_get_match_data() and ID lookup
match by i2c_get_match_data() as we have similar I2C and DT-based matching
table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v1->v2:
 * Dropped the sentence for removing id from commit description.
 * Added Rb tag from Andy.
---
 drivers/iio/chemical/atlas-ezo-sensor.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index 8fc926a2d33b..761a853a4d17 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -203,7 +203,6 @@ MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
 
 static int atlas_ezo_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	const struct atlas_ezo_device *chip;
 	struct atlas_ezo_data *data;
 	struct iio_dev *indio_dev;
@@ -212,10 +211,7 @@ static int atlas_ezo_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	if (dev_fwnode(&client->dev))
-		chip = device_get_match_data(&client->dev);
-	else
-		chip = (const struct atlas_ezo_device *)id->driver_data;
+	chip = i2c_get_match_data(client);
 	if (!chip)
 		return -EINVAL;
 
-- 
2.25.1

