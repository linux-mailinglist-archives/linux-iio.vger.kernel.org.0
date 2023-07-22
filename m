Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DDA75DE6A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jul 2023 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGVUH3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jul 2023 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGVUH2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jul 2023 16:07:28 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65A9F1FDF;
        Sat, 22 Jul 2023 13:07:27 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,224,1684767600"; 
   d="scan'208";a="174116633"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jul 2023 05:07:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.35])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D8F5B4004473;
        Sun, 23 Jul 2023 05:07:23 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        George Mois <george.mois@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/2] iio: accel: adxl313: Fix adxl313_i2c_id[] table
Date:   Sat, 22 Jul 2023 21:07:17 +0100
Message-Id: <20230722200718.142366-2-biju.das.jz@bp.renesas.com>
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

The .driver_data in adxl313_i2c_id[] for adxl312 and adxl314 is
wrong. Fix this issue by adding corresponding adxl31x_chip_info
data.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230716175218.130557-3-biju.das.jz@bp.renesas.com/#25436658
Fixes: a7a1c60bc4c9 ("drivers: iio: accel: adxl312 and adxl314 support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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

