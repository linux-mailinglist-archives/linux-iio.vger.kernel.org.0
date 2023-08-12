Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBCC77A10E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHLQe3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHLQe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 12:34:29 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 409571702;
        Sat, 12 Aug 2023 09:34:32 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="172770314"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Aug 2023 01:34:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4FC6D402E068;
        Sun, 13 Aug 2023 01:34:28 +0900 (JST)
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
Subject: [PATCH] iio: chemical: atlas-ezo-sensor: Simplify probe()
Date:   Sat, 12 Aug 2023 17:34:25 +0100
Message-Id: <20230812163425.206044-1-biju.das.jz@bp.renesas.com>
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

Simplify the probe() by replacing device_get_match_data() and ID lookup
match by i2c_get_match_data() as we have similar I2C and DT-based matching
table.

While at it, drop id variable from probe() as it is unused.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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

