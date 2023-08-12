Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C3F779E36
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 10:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjHLIcJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 04:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbjHLIcI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 04:32:08 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DC71271E;
        Sat, 12 Aug 2023 01:32:10 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,167,1684767600"; 
   d="scan'208";a="172750607"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Aug 2023 17:32:09 +0900
Received: from localhost.localdomain (unknown [10.226.92.36])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5D4EF4196927;
        Sat, 12 Aug 2023 17:32:06 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH RFC/RFT] iio: imu: lsm6dsx: Use i2c_get_match_data()
Date:   Sat, 12 Aug 2023 09:32:04 +0100
Message-Id: <20230812083204.55346-1-biju.das.jz@bp.renesas.com>
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

Replace device_get_match_data() and id lookup for retrieving match data
by i2c_get_match_data() by converting enum->pointer for data in the
match table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 126 ++++++++++++--------
 1 file changed, 74 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 911444ec57c0..a2def435c9c2 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -16,6 +16,30 @@
 
 #include "st_lsm6dsx.h"
 
+static const int lsm6ds3 = ST_LSM6DS3_ID;
+static const int lsm6ds3h = ST_LSM6DS3H_ID;
+static const int lsm6dsl = ST_LSM6DSL_ID;
+static const int lsm6dsm = ST_LSM6DSM_ID;
+static const int ism330dlc = ST_ISM330DLC_ID;
+static const int lsm6dso = ST_LSM6DSO_ID;
+static const int asm330lhh = ST_ASM330LHH_ID;
+static const int lsm6dsox = ST_LSM6DSOX_ID;
+static const int lsm6dsr = ST_LSM6DSR_ID;
+static const int lsm6ds3tr_c = ST_LSM6DS3TRC_ID;
+static const int ism330dhcx = ST_ISM330DHCX_ID;
+static const int lsm9ds1_imu = ST_LSM9DS1_ID;
+static const int lsm6ds0 = ST_LSM6DS0_ID;
+static const int lsm6dsrx = ST_LSM6DSRX_ID;
+static const int lsm6dst = ST_LSM6DST_ID;
+static const int lsm6dsop = ST_LSM6DSOP_ID;
+static const int asm330lhhx = ST_ASM330LHHX_ID;
+static const int lsm6dstx = ST_LSM6DSTX_ID;
+static const int lsm6dsv = ST_LSM6DSV_ID;
+static const int lsm6dsv16x = ST_LSM6DSV16X_ID;
+static const int lsm6dso16is = ST_LSM6DSO16IS_ID;
+static const int ism330is = ST_ISM330IS_ID;
+static const int asm330lhb = ST_ASM330LHB_ID;
+
 static const struct regmap_config st_lsm6dsx_i2c_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -23,12 +47,10 @@ static const struct regmap_config st_lsm6dsx_i2c_regmap_config = {
 
 static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
 {
-	int hw_id;
+	const int *hw_id;
 	struct regmap *regmap;
 
-	hw_id = (kernel_ulong_t)device_get_match_data(&client->dev);
-	if (!hw_id)
-		hw_id = i2c_client_get_device_id(client)->driver_data;
+	hw_id = i2c_get_match_data(client);
 	if (!hw_id)
 		return -EINVAL;
 
@@ -38,136 +60,136 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
-	return st_lsm6dsx_probe(&client->dev, client->irq, hw_id, regmap);
+	return st_lsm6dsx_probe(&client->dev, client->irq, *hw_id, regmap);
 }
 
 static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 	{
 		.compatible = "st,lsm6ds3",
-		.data = (void *)ST_LSM6DS3_ID,
+		.data = &lsm6ds3,
 	},
 	{
 		.compatible = "st,lsm6ds3h",
-		.data = (void *)ST_LSM6DS3H_ID,
+		.data = &lsm6ds3h,
 	},
 	{
 		.compatible = "st,lsm6dsl",
-		.data = (void *)ST_LSM6DSL_ID,
+		.data = &lsm6dsl,
 	},
 	{
 		.compatible = "st,lsm6dsm",
-		.data = (void *)ST_LSM6DSM_ID,
+		.data = &lsm6dsm,
 	},
 	{
 		.compatible = "st,ism330dlc",
-		.data = (void *)ST_ISM330DLC_ID,
+		.data = &ism330dlc,
 	},
 	{
 		.compatible = "st,lsm6dso",
-		.data = (void *)ST_LSM6DSO_ID,
+		.data = &lsm6dso,
 	},
 	{
 		.compatible = "st,asm330lhh",
-		.data = (void *)ST_ASM330LHH_ID,
+		.data = &asm330lhh,
 	},
 	{
 		.compatible = "st,lsm6dsox",
-		.data = (void *)ST_LSM6DSOX_ID,
+		.data = &lsm6dsox,
 	},
 	{
 		.compatible = "st,lsm6dsr",
-		.data = (void *)ST_LSM6DSR_ID,
+		.data = &lsm6dsr,
 	},
 	{
 		.compatible = "st,lsm6ds3tr-c",
-		.data = (void *)ST_LSM6DS3TRC_ID,
+		.data = &lsm6ds3tr_c,
 	},
 	{
 		.compatible = "st,ism330dhcx",
-		.data = (void *)ST_ISM330DHCX_ID,
+		.data = &ism330dhcx,
 	},
 	{
 		.compatible = "st,lsm9ds1-imu",
-		.data = (void *)ST_LSM9DS1_ID,
+		.data = &lsm9ds1_imu,
 	},
 	{
 		.compatible = "st,lsm6ds0",
-		.data = (void *)ST_LSM6DS0_ID,
+		.data = &lsm6ds0,
 	},
 	{
 		.compatible = "st,lsm6dsrx",
-		.data = (void *)ST_LSM6DSRX_ID,
+		.data = &lsm6dsrx,
 	},
 	{
 		.compatible = "st,lsm6dst",
-		.data = (void *)ST_LSM6DST_ID,
+		.data = &lsm6dst,
 	},
 	{
 		.compatible = "st,lsm6dsop",
-		.data = (void *)ST_LSM6DSOP_ID,
+		.data = &lsm6dsop,
 	},
 	{
 		.compatible = "st,asm330lhhx",
-		.data = (void *)ST_ASM330LHHX_ID,
+		.data = &asm330lhhx,
 	},
 	{
 		.compatible = "st,lsm6dstx",
-		.data = (void *)ST_LSM6DSTX_ID,
+		.data = &lsm6dstx,
 	},
 	{
 		.compatible = "st,lsm6dsv",
-		.data = (void *)ST_LSM6DSV_ID,
+		.data = &lsm6dsv,
 	},
 	{
 		.compatible = "st,lsm6dsv16x",
-		.data = (void *)ST_LSM6DSV16X_ID,
+		.data = &lsm6dsv16x,
 	},
 	{
 		.compatible = "st,lsm6dso16is",
-		.data = (void *)ST_LSM6DSO16IS_ID,
+		.data = &lsm6dso16is,
 	},
 	{
 		.compatible = "st,ism330is",
-		.data = (void *)ST_ISM330IS_ID,
+		.data = &ism330is,
 	},
 	{
 		.compatible = "st,asm330lhb",
-		.data = (void *)ST_ASM330LHB_ID,
+		.data = &asm330lhb,
 	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
-	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
+	{ "SMO8B30", (kernel_ulong_t)&lsm6ds3tr_c, },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
 
 static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
-	{ ST_LSM6DS3_DEV_NAME, ST_LSM6DS3_ID },
-	{ ST_LSM6DS3H_DEV_NAME, ST_LSM6DS3H_ID },
-	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
-	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
-	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
-	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
-	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
-	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
-	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
-	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
-	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
-	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
-	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
-	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
-	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
-	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
-	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
-	{ ST_LSM6DSTX_DEV_NAME, ST_LSM6DSTX_ID },
-	{ ST_LSM6DSV_DEV_NAME, ST_LSM6DSV_ID },
-	{ ST_LSM6DSV16X_DEV_NAME, ST_LSM6DSV16X_ID },
-	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
-	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
-	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
+	{ ST_LSM6DS3_DEV_NAME, (kernel_ulong_t)&lsm6ds3 },
+	{ ST_LSM6DS3H_DEV_NAME, (kernel_ulong_t)&lsm6ds3h },
+	{ ST_LSM6DSL_DEV_NAME, (kernel_ulong_t)&lsm6dsl },
+	{ ST_LSM6DSM_DEV_NAME, (kernel_ulong_t)&lsm6dsm },
+	{ ST_ISM330DLC_DEV_NAME, (kernel_ulong_t)&ism330dlc },
+	{ ST_LSM6DSO_DEV_NAME, (kernel_ulong_t)&lsm6dso },
+	{ ST_ASM330LHH_DEV_NAME, (kernel_ulong_t)&asm330lhh },
+	{ ST_LSM6DSOX_DEV_NAME, (kernel_ulong_t)&lsm6dsox },
+	{ ST_LSM6DSR_DEV_NAME, (kernel_ulong_t)&lsm6dsr },
+	{ ST_LSM6DS3TRC_DEV_NAME, (kernel_ulong_t)&lsm6ds3tr_c },
+	{ ST_ISM330DHCX_DEV_NAME, (kernel_ulong_t)&ism330dhcx },
+	{ ST_LSM9DS1_DEV_NAME, (kernel_ulong_t)&lsm9ds1_imu },
+	{ ST_LSM6DS0_DEV_NAME, (kernel_ulong_t)&lsm6ds0 },
+	{ ST_LSM6DSRX_DEV_NAME, (kernel_ulong_t)&lsm6dsrx },
+	{ ST_LSM6DST_DEV_NAME, (kernel_ulong_t)&lsm6dst },
+	{ ST_LSM6DSOP_DEV_NAME, (kernel_ulong_t)&lsm6dsop },
+	{ ST_ASM330LHHX_DEV_NAME, (kernel_ulong_t)&asm330lhhx },
+	{ ST_LSM6DSTX_DEV_NAME, (kernel_ulong_t)&lsm6dstx },
+	{ ST_LSM6DSV_DEV_NAME, (kernel_ulong_t)&lsm6dsv },
+	{ ST_LSM6DSV16X_DEV_NAME, (kernel_ulong_t)&lsm6dsv16x },
+	{ ST_LSM6DSO16IS_DEV_NAME, (kernel_ulong_t)&lsm6dso16is },
+	{ ST_ISM330IS_DEV_NAME, (kernel_ulong_t)&ism330is },
+	{ ST_ASM330LHB_DEV_NAME, (kernel_ulong_t)&asm330lhb },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
-- 
2.25.1

