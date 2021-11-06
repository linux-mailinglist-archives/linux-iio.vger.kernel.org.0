Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA7446F67
	for <lists+linux-iio@lfdr.de>; Sat,  6 Nov 2021 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhKFRoz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Nov 2021 13:44:55 -0400
Received: from azure-sdnproxy.icoremail.net ([52.229.168.213]:48849 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S229551AbhKFRoy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Nov 2021 13:44:54 -0400
Received: from icoremail.net (unknown [10.12.1.20])
        by hzbj-icmmx-1 (Coremail) with SMTP id AQAAfwB3SbYsvoZhpMIMBw--.18502S2;
        Sun, 07 Nov 2021 01:41:00 +0800 (CST)
Received: from ubuntu-laptop.lan (unknown [46.253.189.78])
        by mail (Coremail) with SMTP id AQAAfwCX+JVnvoZhGWAAAA--.4681S3;
        Sun, 07 Nov 2021 01:42:02 +0800 (CST)
From:   Maslov Dmitry <maslovdmitry@seeed.cc>
To:     jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, north_sea@qq.com, baozhu.zuo@seeed.cc,
        jian.xiong@seeed.cc
Cc:     Maslov Dmitry <maslovdmitry@seeed.cc>
Subject: [PATCH v4] iio: light: ltr501: Added ltr303 driver support
Date:   Sat,  6 Nov 2021 18:41:37 +0100
Message-Id: <20211106174137.6783-1-maslovdmitry@seeed.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX+JVnvoZhGWAAAA--.4681S3
X-CM-SenderInfo: xpdvz0pygpx31u162vxhhghubf/
Authentication-Results: hzbj-icmmx-1; spf=neutral smtp.mail=maslovdmit
        ry@seeed.cc;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr47Kw17Kr4rGrWDJryfCrg_yoW5Gr43pF
        W3uFy5WF1rZF1S93Z8JFn7ZFW5GrsrC3yjyryxK34UAa9xG34Dua43t3WYkF93Xry7Zr4F
        qFsFvFy09a1UGFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
 drivers/iio/light/ltr501.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

It is a fix of previous commits, that simplified ltr303 support
and removed a lot of unnecessary code. Filename has also been removed
from the file.
Additionally, in v3 of the patch, unused ltr_max was removed
and description of the driver was changed to more general, i.e.
"LTR501 and similar ambient light and proximity sensors."
In v4 of the patch, ltr303 entry was removed from ACPI match table,
since ACPI ID is not present in acpi id list.

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7e51aaac0bf..bab5b78f2e3 100644
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
@@ -1605,6 +1618,7 @@ static const struct i2c_device_id ltr501_id[] = {
 	{ "ltr501", ltr501},
 	{ "ltr559", ltr559},
 	{ "ltr301", ltr301},
+	{ "ltr303", ltr303},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr501_id);
@@ -1613,6 +1627,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr501", },
 	{ .compatible = "liteon,ltr559", },
 	{ .compatible = "liteon,ltr301", },
+	{ .compatible = "liteon,ltr303", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);
-- 
2.25.1

