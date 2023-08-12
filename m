Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB59A77A010
	for <lists+linux-iio@lfdr.de>; Sat, 12 Aug 2023 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjHLNBe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Aug 2023 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjHLNBe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Aug 2023 09:01:34 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E9B7EA;
        Sat, 12 Aug 2023 06:01:36 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,168,1684767600"; 
   d="scan'208";a="176445098"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2023 22:01:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D8E114002950;
        Sat, 12 Aug 2023 22:01:32 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] iio: proximity: sx9310: Convert enum->pointer for match data table
Date:   Sat, 12 Aug 2023 14:01:30 +0100
Message-Id: <20230812130130.123243-1-biju.das.jz@bp.renesas.com>
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

Convert enum->pointer for data in match data table, so that
device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
bus type match support added to it.

Add struct sx931x_info and replace enum->sx931x_info in the match table
and simplify sx9310_check_whoami().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/proximity/sx9310.c | 44 +++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index d977aacb7491..0f1d5226a585 100644
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
+	ddata = device_get_match_data(dev);
+	if (ddata->whoami != whoami)
 		return -EINVAL;
 
-	switch (whoami) {
-	case SX9310_WHOAMI_VALUE:
-		indio_dev->name = "sx9310";
-		break;
-	case SX9311_WHOAMI_VALUE:
-		indio_dev->name = "sx9311";
-		break;
-	default:
-		return -ENODEV;
-	}
+	indio_dev->name = ddata->name;
 
 	return 0;
 }
@@ -1015,23 +1011,33 @@ static int sx9310_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
 
+static const struct sx931x_info sx9310_info = {
+	.name = "sx9310",
+	.whoami = SX9310_WHOAMI_VALUE
+};
+
+static const struct sx931x_info sx9311_info = {
+	.name = "sx9311",
+	.whoami = SX9311_WHOAMI_VALUE
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

