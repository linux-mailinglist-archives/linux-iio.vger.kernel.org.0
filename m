Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F3D772CD5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Aug 2023 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHGR0C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Aug 2023 13:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjHGR0B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Aug 2023 13:26:01 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAA759F;
        Mon,  7 Aug 2023 10:25:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,262,1684767600"; 
   d="scan'208";a="175893230"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 08 Aug 2023 02:25:59 +0900
Received: from localhost.localdomain (unknown [10.226.92.227])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 15102403C9A4;
        Tue,  8 Aug 2023 02:25:54 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Crt Mori <cmo@melexis.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] iio: magnetometer: ak8975: Simplify probe()
Date:   Mon,  7 Aug 2023 18:25:48 +0100
Message-Id: <20230807172548.258247-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807172548.258247-1-biju.das.jz@bp.renesas.com>
References: <20230807172548.258247-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Simplify the probe() by replacing device_get_match_data() and
i2c_client_get_device_id by i2c_get_match_data() as we have similar I2C,
ACPI and DT matching table.

While at it, replace name->chipset to make error message consistent.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iio/magnetometer/ak8975.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index eb706d0bf70b..9c4d942ffab3 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -878,16 +878,13 @@ static irqreturn_t ak8975_handle_trigger(int irq, void *p)
 
 static int ak8975_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct ak8975_data *data;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *eoc_gpiod;
 	struct gpio_desc *reset_gpiod;
-	const void *match;
 	unsigned int i;
 	int err;
 	enum asahi_compass_chipset chipset;
-	const char *name = NULL;
 
 	/*
 	 * Grab and set up the supplied GPIO.
@@ -927,15 +924,8 @@ static int ak8975_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
-	/* id will be NULL when enumerated via ACPI */
-	match = device_get_match_data(&client->dev);
-	if (match) {
-		chipset = (uintptr_t)match;
-		name = dev_name(&client->dev);
-	} else if (id) {
-		chipset = (enum asahi_compass_chipset)(id->driver_data);
-		name = id->name;
-	} else
+	chipset = (uintptr_t)i2c_get_match_data(client);
+	if (!chipset)
 		return -ENOSYS;
 
 	for (i = 0; i < ARRAY_SIZE(ak_def_array); i++)
@@ -967,12 +957,13 @@ static int ak8975_probe(struct i2c_client *client)
 		dev_err(&client->dev, "Unexpected device\n");
 		goto power_off;
 	}
-	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
+	dev_dbg(&client->dev, "Asahi compass chip %d\n", chipset);
 
 	/* Perform some basic start-of-day setup of the device. */
 	err = ak8975_setup(client);
 	if (err < 0) {
-		dev_err(&client->dev, "%s initialization fails\n", name);
+		dev_err(&client->dev, "Initialization failed for chip %d\n",
+			chipset);
 		goto power_off;
 	}
 
@@ -982,7 +973,7 @@ static int ak8975_probe(struct i2c_client *client)
 	indio_dev->info = &ak8975_info;
 	indio_dev->available_scan_masks = ak8975_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = name;
+	indio_dev->name = dev_name(&client->dev);
 
 	err = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
 					 NULL);
-- 
2.25.1

