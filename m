Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163DA75DE6B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jul 2023 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGVUHb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jul 2023 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGVUHa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jul 2023 16:07:30 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0EA11FE1;
        Sat, 22 Jul 2023 13:07:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,224,1684767600"; 
   d="scan'208";a="174116637"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jul 2023 05:07:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.35])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2F25C4005625;
        Sun, 23 Jul 2023 05:07:26 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/2] iio: accel: adxl313: Use i2c_get_match_data
Date:   Sat, 22 Jul 2023 21:07:18 +0100
Message-Id: <20230722200718.142366-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230722200718.142366-1-biju.das.jz@bp.renesas.com>
References: <20230722200718.142366-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace device_get_match_data() and i2c_match_id() by i2c_get_match
_data() as we have similar I2C and DT-based matching table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2:
 * Added Rb tag from Geert
 * Removed error check as all tables have data pointers.
 * retained Rb tag as the change is trivial.
---
 drivers/iio/accel/adxl313_i2c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index e0a860ab9e58..a4cf0cf2c5aa 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -65,9 +65,7 @@ static int adxl313_i2c_probe(struct i2c_client *client)
 	 * Retrieves device specific data as a pointer to a
 	 * adxl313_chip_info structure
 	 */
-	chip_data = device_get_match_data(&client->dev);
-	if (!chip_data)
-		chip_data = (const struct adxl313_chip_info *)i2c_match_id(adxl313_i2c_id, client)->driver_data;
+	chip_data = i2c_get_match_data(client);
 
 	regmap = devm_regmap_init_i2c(client,
 				      &adxl31x_i2c_regmap_config[chip_data->type]);
-- 
2.25.1

