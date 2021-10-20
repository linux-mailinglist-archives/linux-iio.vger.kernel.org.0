Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F325D434601
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 09:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhJTHnG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 03:43:06 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:49611
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229544AbhJTHnG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Oct 2021 03:43:06 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Oct 2021 03:43:06 EDT
Received: from icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwCXK7iBxm9hLFeyBQ--.2534S2;
        Wed, 20 Oct 2021 15:34:25 +0800 (CST)
Received: from ubuntu-laptop.lan (unknown [46.253.189.78])
        by mail (Coremail) with SMTP id AQAAfwCXd166xm9h6hkAAA--.1111S3;
        Wed, 20 Oct 2021 15:35:24 +0800 (CST)
From:   Maslov Dmitry <maslovdmitry@seeed.cc>
To:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Cc:     Maslov Dmitry <maslovdmitry@seeed.cc>
Subject: [PATCH] iio: light: ltr501: Added ltr303 driver support
Date:   Wed, 20 Oct 2021 09:35:18 +0200
Message-Id: <20211020073518.3191-1-maslovdmitry@seeed.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXd166xm9h6hkAAA--.1111S3
X-CM-SenderInfo: xpdvz0pygpx31u162vxhhghubf/
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=maslovdmit
        ry@seeed.cc;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr47Kw45Cw15Kw1rWrWkCrg_yoWrGr1DpF
        ZxCF15tF4rAF4fGF4DJrnYvFy3Kr4xC3y2vryxKw12yay7Gwn8Wa43J34akFn7JrZFqr4Y
        qrZFqFWj9FZ8CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
        UUUUU
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Previously ltr501 driver supported a number of light and,
proximity sensors including ltr501, ltr559 and ltr301.
This adds support for another light sensor ltr303
used in Seeed Studio reTerminal, a carrier board
for Raspberry Pi 4 CM.

Signed-off-by: Maslov Dmitry <maslovdmitry@seeed.cc>
---
 drivers/iio/light/ltr501.c | 46 +++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7e51aaac0bf..733f9224bd1 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * ltr501.c - Support for Lite-On LTR501 ambient light and proximity sensor
+ * ltr.c - Support for Lite-On LTR501, LTR509, LTR301, LTR303 ambient light
+ * and proximity sensors (only LTR5xx)
  *
  * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
@@ -16,6 +17,8 @@
 #include <linux/regmap.h>
 #include <linux/acpi.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
@@ -65,11 +68,15 @@
 #define LTR501_ALS_DEF_PERIOD 500000
 #define LTR501_PS_DEF_PERIOD 100000
 
+#define LTR501_ALS_DEF_GAIN		(BIT(4) | BIT(3) | BIT(2))
+
 #define LTR501_REGMAP_NAME "ltr501_regmap"
 
 #define LTR501_LUX_CONV(vis_coeff, vis_data, ir_coeff, ir_data) \
 			((vis_coeff * vis_data) - (ir_coeff * ir_data))
 
+static const struct i2c_device_id ltr501_id[];
+
 static const int int_time_mapping[] = {100000, 50000, 200000, 400000};
 
 static const struct reg_field reg_field_it =
@@ -98,6 +105,9 @@ enum {
 	ltr501 = 0,
 	ltr559,
 	ltr301,
+	ltr303,
+
+	ltr_max
 };
 
 struct ltr501_gain {
@@ -1231,6 +1241,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
 		.channels = ltr301_channels,
 		.no_channels = ARRAY_SIZE(ltr301_channels),
 	},
+	[ltr303] = {
+		.partid = 0x0A,
+		.als_gain = ltr559_als_gain_tbl,
+		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
+		.als_mode_active = BIT(0),
+		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
+		.als_gain_shift = 2,
+		.info = &ltr301_info,
+		.info_no_irq = &ltr301_info_no_irq,
+		.channels = ltr301_channels,
+		.no_channels = ARRAY_SIZE(ltr301_channels),
+	},
 };
 
 static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
@@ -1337,7 +1359,7 @@ static int ltr501_init(struct ltr501_data *data)
 	if (ret < 0)
 		return ret;
 
-	data->als_contr = status | data->chip_info->als_mode_active;
+	data->als_contr = status | data->chip_info->als_mode_active | LTR501_ALS_DEF_GAIN;
 
 	ret = regmap_read(data->regmap, LTR501_PS_CONTR, &status);
 	if (ret < 0)
@@ -1504,7 +1526,23 @@ static int ltr501_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	if (id) {
+	if (client->dev.of_node) {
+		int i = 0;
+
+		chip_idx = (int)of_device_get_match_data(&client->dev);
+		for (i = 0; i < ltr_max; i++) {
+			if (ltr501_id[i].name == NULL) {
+				break;
+			}
+			if (ltr501_id[i].driver_data == chip_idx) {
+				name = ltr501_id[i].name;
+				break;
+			}
+		}
+		if (i >= ltr_max) {
+			name = LTR501_DRV_NAME;
+		}
+	} else if (id) {
 		name = id->name;
 		chip_idx = id->driver_data;
 	} else  if (ACPI_HANDLE(&client->dev)) {
@@ -1597,6 +1635,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
 	{"LTER0501", ltr501},
 	{"LTER0559", ltr559},
 	{"LTER0301", ltr301},
+	{"LTER0303", ltr303},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
@@ -1605,6 +1644,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ "ltr501", ltr501},
 	{ "ltr559", ltr559},
 	{ "ltr301", ltr301},
+	{ "ltr303", ltr303},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
-- 
2.25.1

