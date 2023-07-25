Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0058D761FF1
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jul 2023 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGYRQf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jul 2023 13:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGYRQf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jul 2023 13:16:35 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0147BC;
        Tue, 25 Jul 2023 10:16:33 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,230,1684767600"; 
   d="scan'208";a="174450732"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jul 2023 02:16:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.3])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B1F08405617B;
        Wed, 26 Jul 2023 02:16:30 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        George Mois <george.mois@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 1/2] iio: accel: adxl313: Fix adxl313_i2c_id[] table
Date:   Tue, 25 Jul 2023 18:16:23 +0100
Message-Id: <20230725171624.331283-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230725171624.331283-1-biju.das.jz@bp.renesas.com>
References: <20230725171624.331283-1-biju.das.jz@bp.renesas.com>
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

The .driver_data in adxl313_i2c_id[] for adxl312 and adxl314 is
wrong. Fix this issue by adding corresponding adxl31x_chip_info
data.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/all/20230722172832.04ad7738@jic23-huawei
Fixes: a7a1c60bc4c9 ("drivers: iio: accel: adxl312 and adxl314 support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
 * Added Rb tag from Geert.
 * Added link to lore for Closes tag.
---
 drivers/iio/accel/adxl313_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index 524327ea3663..e0a860ab9e58 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -40,8 +40,8 @@ static const struct regmap_config adxl31x_i2c_regmap_config[] = {
 
 static const struct i2c_device_id adxl313_i2c_id[] = {
 	{ .name = "adxl312", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
-	{ .name = "adxl313", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
-	{ .name = "adxl314", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL312] },
+	{ .name = "adxl313", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL313] },
+	{ .name = "adxl314", .driver_data = (kernel_ulong_t)&adxl31x_chip_info[ADXL314] },
 	{ }
 };
 
-- 
2.25.1

