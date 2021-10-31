Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2214440F80
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 17:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhJaQtK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 12:49:10 -0400
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:53720
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229579AbhJaQtK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 12:49:10 -0400
Received: from icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwBXd8eGyH5hkA7JBA--.60400S2;
        Mon, 01 Nov 2021 00:47:02 +0800 (CST)
Received: from ubuntu-laptop.lan (unknown [46.253.189.78])
        by mail (Coremail) with SMTP id AQAAfwAnOe1kyH5hLzwAAA--.2684S3;
        Mon, 01 Nov 2021 00:46:31 +0800 (CST)
From:   Maslov Dmitry <maslovdmitry@seeed.cc>
To:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, north_sea@qq.com, baozhu.zuo@seeed.cc,
        jian.xiong@seeed.cc
Cc:     Maslov Dmitry <maslovdmitry@seeed.cc>
Subject: [PATCH v3] iio: light: ltr501: Added ltr303 driver support
Date:   Sun, 31 Oct 2021 17:46:03 +0100
Message-Id: <20211031164603.4343-1-maslovdmitry@seeed.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAnOe1kyH5hLzwAAA--.2684S3
X-CM-SenderInfo: xpdvz0pygpx31u162vxhhghubf/
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=maslovdmit
        ry@seeed.cc;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr47Kw17Kr4rGrWDJryfCrg_yoW5Xr4kpF
        13WF15WF1rXF1fu3Z8JFs7ZFy5GrsrC3yjvryxK347Za9xG34Dua43t3WYkFn3XrWaqr4S
        qF9FvFy09F15GFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
 drivers/iio/light/ltr501.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

It is a fix of previous commit, that simplified ltr303 support
and removed a lot of unnecessary code. Filename has also been removed
from the file.
Additionally, in v3 of the patch, unused ltr_max was removed
and description of the driver was changed to more general, i.e.
"LTR501 and similar ambient light and proximity sensors."

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7e51aaac0bf..4c8672547fd 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * ltr501.c - Support for Lite-On LTR501 ambient light and proximity sensor
+ * Support for Lite-On LTR501 and similar ambient light and proximity sensors.
  *
  * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
@@ -98,6 +98,7 @@ enum {
 	ltr501 = 0,
 	ltr559,
 	ltr301,
+	ltr303,
 };
 
 struct ltr501_gain {
@@ -1231,6 +1232,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
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
@@ -1597,6 +1610,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
 	{"LTER0501", ltr501},
 	{"LTER0559", ltr559},
 	{"LTER0301", ltr301},
+	{"LTER0303", ltr303},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
@@ -1605,6 +1619,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ "ltr501", ltr501},
 	{ "ltr559", ltr559},
 	{ "ltr301", ltr301},
+	{ "ltr303", ltr303},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
@@ -1613,6 +1628,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr501", },
 	{ .compatible = "liteon,ltr559", },
 	{ .compatible = "liteon,ltr301", },
+	{ .compatible = "liteon,ltr303", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);
-- 
2.25.1

