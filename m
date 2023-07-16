Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C50775502B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jul 2023 19:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGPRwb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jul 2023 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGPRwa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jul 2023 13:52:30 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3DD0E5D;
        Sun, 16 Jul 2023 10:52:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,210,1684767600"; 
   d="scan'208";a="169303058"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Jul 2023 02:52:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D1AD7400941A;
        Mon, 17 Jul 2023 02:52:26 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/4] iio: accel: adxl313: Use i2c_get_match_data
Date:   Sun, 16 Jul 2023 18:52:16 +0100
Message-Id: <20230716175218.130557-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
_data() as we have similar I2C and DT-based matching table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/accel/adxl313_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index 524327ea3663..6d252190207b 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -65,9 +65,9 @@ static int adxl313_i2c_probe(struct i2c_client *client)
 	 * Retrieves device specific data as a pointer to a
 	 * adxl313_chip_info structure
 	 */
-	chip_data = device_get_match_data(&client->dev);
+	chip_data = i2c_get_match_data(client);
 	if (!chip_data)
-		chip_data = (const struct adxl313_chip_info *)i2c_match_id(adxl313_i2c_id, client)->driver_data;
+		return -ENODEV;
 
 	regmap = devm_regmap_init_i2c(client,
 				      &adxl31x_i2c_regmap_config[chip_data->type]);
-- 
2.25.1

