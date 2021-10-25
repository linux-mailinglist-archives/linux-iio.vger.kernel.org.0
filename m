Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6D43A5EA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 23:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhJYVdb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 17:33:31 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:49721
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S233800AbhJYVda (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 17:33:30 -0400
Received: from icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwCnzc0pIndhsr59BA--.3263S2;
        Tue, 26 Oct 2021 05:31:21 +0800 (CST)
Received: from ubuntu-laptop.lan (unknown [46.253.189.78])
        by mail (Coremail) with SMTP id AQAAfwA377gEIndhwQAAAA--.58S3;
        Tue, 26 Oct 2021 05:30:47 +0800 (CST)
From:   Maslov Dmitry <maslovdmitry@seeed.cc>
To:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        maslovdmitry@seeed.cc, andy.shevchenko@gmail.com, north_sea@qq.com,
        baozhu.zuo@seeed.cc, jian.xiong@seeed.cc
Subject: [PATCH] iio: light: ltr501: Added ltr303 driver support
Date:   Mon, 25 Oct 2021 23:30:23 +0200
Message-Id: <20211025213023.7309-1-maslovdmitry@seeed.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwA377gEIndhwQAAAA--.58S3
X-CM-SenderInfo: xpdvz0pygpx31u162vxhhghubf/
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=maslovdmit
        ry@seeed.cc;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr47Kw1DZr13AF1fWw4Uurg_yoW5Gr18pF
        13uF15WF1rZF1fu3Z8JrykZFy5Grs7C3yjvryxK347Za9xG34Dua43t3WakFn7Xr4aqr4a
        qFZFvFy09F15W3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

It is a fix of previous commit, that simplified ltr303 support
and removed a lot of unnecessary code. Filename has also been removed
from the file.

Signed-off-by: Maslov Dmitry <maslovdmitry@seeed.cc>
---
 drivers/iio/light/ltr501.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7e51aaac0bf..d92d324d5e3 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * ltr501.c - Support for Lite-On LTR501 ambient light and proximity sensor
+ * Support for Lite-On LTR501, LTR509, LTR301, LTR303 ambient light
+ * and proximity sensors (only LTR5xx)
  *
  * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
@@ -98,6 +99,9 @@ enum {
 	ltr501 = 0,
 	ltr559,
 	ltr301,
+	ltr303,
+
+	ltr_max
 };
 
 struct ltr501_gain {
@@ -1231,6 +1235,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
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
@@ -1597,6 +1613,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
 	{"LTER0501", ltr501},
 	{"LTER0559", ltr559},
 	{"LTER0301", ltr301},
+	{"LTER0303", ltr303},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
@@ -1605,6 +1622,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ "ltr501", ltr501},
 	{ "ltr559", ltr559},
 	{ "ltr301", ltr301},
+	{ "ltr303", ltr303},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
@@ -1613,6 +1631,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr501", },
 	{ .compatible = "liteon,ltr559", },
 	{ .compatible = "liteon,ltr301", },
+	{ .compatible = "liteon,ltr303", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);
-- 
2.25.1

