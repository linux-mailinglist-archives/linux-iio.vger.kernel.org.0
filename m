Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC3378122F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 19:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379150AbjHRRju (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 13:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379145AbjHRRjT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 13:39:19 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00C6E2102;
        Fri, 18 Aug 2023 10:39:17 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="176988069"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Aug 2023 02:39:17 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3720640029B7;
        Sat, 19 Aug 2023 02:39:13 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/2] iio: dac: ti-dac5571: Use i2c_get_match_data()
Date:   Fri, 18 Aug 2023 18:39:06 +0100
Message-Id: <20230818173907.323640-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818173907.323640-1-biju.das.jz@bp.renesas.com>
References: <20230818173907.323640-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
v1->v2:
 * No change.
---
 drivers/iio/dac/ti-dac5571.c | 48 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index bab11b9adc25..2bb3f76569ee 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -313,7 +313,6 @@ static int dac5571_probe(struct i2c_client *client)
 	const struct dac5571_spec *spec;
 	struct dac5571_data *data;
 	struct iio_dev *indio_dev;
-	enum chip_id chip_id;
 	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -329,12 +328,7 @@ static int dac5571_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = dac5571_channels;
 
-	if (dev_fwnode(dev))
-		chip_id = (uintptr_t)device_get_match_data(dev);
-	else
-		chip_id = id->driver_data;
-
-	spec = &dac5571_spec[chip_id];
+	spec = i2c_get_match_data(client);
 
 	indio_dev->num_channels = spec->num_channels;
 	data->spec = spec;
@@ -392,31 +386,31 @@ static void dac5571_remove(struct i2c_client *i2c)
 }
 
 static const struct of_device_id dac5571_of_id[] = {
-	{.compatible = "ti,dac5571", .data = (void *)single_8bit},
-	{.compatible = "ti,dac6571", .data = (void *)single_10bit},
-	{.compatible = "ti,dac7571", .data = (void *)single_12bit},
-	{.compatible = "ti,dac5574", .data = (void *)quad_8bit},
-	{.compatible = "ti,dac6574", .data = (void *)quad_10bit},
-	{.compatible = "ti,dac7574", .data = (void *)quad_12bit},
-	{.compatible = "ti,dac5573", .data = (void *)quad_8bit},
-	{.compatible = "ti,dac6573", .data = (void *)quad_10bit},
-	{.compatible = "ti,dac7573", .data = (void *)quad_12bit},
-	{.compatible = "ti,dac121c081", .data = (void *)single_12bit},
+	{.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
+	{.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
+	{.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
+	{.compatible = "ti,dac5574", .data = &dac5571_spec[quad_8bit] },
+	{.compatible = "ti,dac6574", .data = &dac5571_spec[quad_10bit] },
+	{.compatible = "ti,dac7574", .data = &dac5571_spec[quad_12bit] },
+	{.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
+	{.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
+	{.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
+	{.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dac5571_of_id);
 
 static const struct i2c_device_id dac5571_id[] = {
-	{"dac5571", single_8bit},
-	{"dac6571", single_10bit},
-	{"dac7571", single_12bit},
-	{"dac5574", quad_8bit},
-	{"dac6574", quad_10bit},
-	{"dac7574", quad_12bit},
-	{"dac5573", quad_8bit},
-	{"dac6573", quad_10bit},
-	{"dac7573", quad_12bit},
-	{"dac121c081", single_12bit},
+	{"dac5571", (kernel_ulong_t)&dac5571_spec[single_8bit] },
+	{"dac6571", (kernel_ulong_t)&dac5571_spec[single_10bit] },
+	{"dac7571", (kernel_ulong_t)&dac5571_spec[single_12bit] },
+	{"dac5574", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
+	{"dac6574", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
+	{"dac7574", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
+	{"dac5573", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
+	{"dac6573", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
+	{"dac7573", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
+	{"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, dac5571_id);
-- 
2.25.1

