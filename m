Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43C511742A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 19:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIS2K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 13:28:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:20627 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfLIS2J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Dec 2019 13:28:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 10:28:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="387326667"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2019 10:28:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CBAB8122; Mon,  9 Dec 2019 20:28:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v1 1/2] iio: pressure: bmp280: Drop ACPI support
Date:   Mon,  9 Dec 2019 20:28:04 +0200
Message-Id: <20191209182805.56249-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is no evidence of officially registered ACPI IDs for these devices.
Thus, revert ACPI support from the driver. All authors of the respective
changes are being informed here:

  d5c94568cc1d ("iio: add bmp280 pressure and temperature driver")
  6dba72eca7fb ("iio: pressure: bmp280: add support for BMP180")
  14beaa8f5ab1 ("iio: pressure: bmp280: add humidity support")

Above seems a cargo cult without paying attention to how ACPI IDs
are being allocated.

Cc: Vlad Dogaru <ddvlad@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/bmp280-i2c.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 3109c8e2cc11..06f90853c141 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 
@@ -38,15 +37,6 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 				   client->irq);
 }
 
-static const struct acpi_device_id bmp280_acpi_i2c_match[] = {
-	{"BMP0280", BMP280_CHIP_ID },
-	{"BMP0180", BMP180_CHIP_ID },
-	{"BMP0085", BMP180_CHIP_ID },
-	{"BME0280", BME280_CHIP_ID },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, bmp280_acpi_i2c_match);
-
 #ifdef CONFIG_OF
 static const struct of_device_id bmp280_of_i2c_match[] = {
 	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
@@ -72,7 +62,6 @@ MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
 static struct i2c_driver bmp280_i2c_driver = {
 	.driver = {
 		.name	= "bmp280",
-		.acpi_match_table = ACPI_PTR(bmp280_acpi_i2c_match),
 		.of_match_table = of_match_ptr(bmp280_of_i2c_match),
 		.pm = &bmp280_dev_pm_ops,
 	},
-- 
2.24.0

