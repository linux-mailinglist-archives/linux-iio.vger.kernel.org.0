Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB8178127B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 19:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbjHRR6s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379387AbjHRR6m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 13:58:42 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7892A4222;
        Fri, 18 Aug 2023 10:58:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="176988663"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Aug 2023 02:58:24 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E10A1404C291;
        Sat, 19 Aug 2023 02:58:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] iio: proximity: sx9310: Convert enum->pointer for match data table
Date:   Fri, 18 Aug 2023 18:58:19 +0100
Message-Id: <20230818175819.325663-1-biju.das.jz@bp.renesas.com>
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

Convert enum->pointer for data in match data table, so that
device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
bus type match support added to it.

Add struct sx931x_info and replace enum->sx931x_info in the match table
and simplify sx9310_check_whoami().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v1->v2:
 * Replaced EINVAL->ENODEV if there is a mismatch in whoami against
   whoami match data from device_get_match_data().
 * Kept trailing comma for sx9310_info and sx9311_info.
 * Added Rb tag from Andy.
---
 drivers/iio/proximity/sx9310.c | 46 +++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index d977aacb7491..0d230a0dff56 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -159,6 +159,11 @@ static_assert(SX9310_NUM_CHANNELS <= SX_COMMON_MAX_NUM_CHANNELS);
 }
 #define SX9310_CHANNEL(idx) SX9310_NAMED_CHANNEL(idx, NULL)
 
+struct sx931x_info {
+	const char *name;
+	unsigned int whoami;
+};
+
 static const struct iio_chan_spec sx9310_channels[] = {
 	SX9310_CHANNEL(0),			/* CS0 */
 	SX9310_CHANNEL(1),			/* CS1 */
@@ -902,7 +907,7 @@ static int sx9310_check_whoami(struct device *dev,
 			       struct iio_dev *indio_dev)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
-	unsigned int long ddata;
+	const struct sx931x_info *ddata;
 	unsigned int whoami;
 	int ret;
 
@@ -910,20 +915,11 @@ static int sx9310_check_whoami(struct device *dev,
 	if (ret)
 		return ret;
 
-	ddata = (uintptr_t)device_get_match_data(dev);
-	if (ddata != whoami)
-		return -EINVAL;
-
-	switch (whoami) {
-	case SX9310_WHOAMI_VALUE:
-		indio_dev->name = "sx9310";
-		break;
-	case SX9311_WHOAMI_VALUE:
-		indio_dev->name = "sx9311";
-		break;
-	default:
+	ddata = device_get_match_data(dev);
+	if (ddata->whoami != whoami)
 		return -ENODEV;
-	}
+
+	indio_dev->name = ddata->name;
 
 	return 0;
 }
@@ -1015,23 +1011,33 @@ static int sx9310_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
 
+static const struct sx931x_info sx9310_info = {
+	.name = "sx9310",
+	.whoami = SX9310_WHOAMI_VALUE,
+};
+
+static const struct sx931x_info sx9311_info = {
+	.name = "sx9311",
+	.whoami = SX9311_WHOAMI_VALUE,
+};
+
 static const struct acpi_device_id sx9310_acpi_match[] = {
-	{ "STH9310", SX9310_WHOAMI_VALUE },
-	{ "STH9311", SX9311_WHOAMI_VALUE },
+	{ "STH9310", (kernel_ulong_t)&sx9310_info },
+	{ "STH9311", (kernel_ulong_t)&sx9311_info },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
 
 static const struct of_device_id sx9310_of_match[] = {
-	{ .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
-	{ .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
+	{ .compatible = "semtech,sx9310", &sx9310_info },
+	{ .compatible = "semtech,sx9311", &sx9311_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sx9310_of_match);
 
 static const struct i2c_device_id sx9310_id[] = {
-	{ "sx9310", SX9310_WHOAMI_VALUE },
-	{ "sx9311", SX9311_WHOAMI_VALUE },
+	{ "sx9310", (kernel_ulong_t)&sx9310_info },
+	{ "sx9311", (kernel_ulong_t)&sx9311_info },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, sx9310_id);
-- 
2.25.1

