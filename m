Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE071174D5
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfLISsY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 13:48:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:44738 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfLISsY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Dec 2019 13:48:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 10:28:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,296,1571727600"; 
   d="scan'208";a="210169385"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2019 10:28:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D89AAA0; Mon,  9 Dec 2019 20:28:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] iio: pressure: bmp280: Allow device to be enumerated from ACPI
Date:   Mon,  9 Dec 2019 20:28:05 +0200
Message-Id: <20191209182805.56249-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209182805.56249-1-andriy.shevchenko@linux.intel.com>
References: <20191209182805.56249-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is no need to limit the driver use by OF/platform code.
In this case we simple remove redundant OF parts from the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/bmp280-i2c.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 06f90853c141..8b03ea15c0d0 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/of.h>
 #include <linux/regmap.h>
 
 #include "bmp280.h"
@@ -37,7 +36,6 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 				   client->irq);
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id bmp280_of_i2c_match[] = {
 	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
 	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
@@ -46,9 +44,6 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
-#else
-#define bmp280_of_i2c_match NULL
-#endif
 
 static const struct i2c_device_id bmp280_i2c_id[] = {
 	{"bmp280", BMP280_CHIP_ID },
@@ -62,7 +57,7 @@ MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
 static struct i2c_driver bmp280_i2c_driver = {
 	.driver = {
 		.name	= "bmp280",
-		.of_match_table = of_match_ptr(bmp280_of_i2c_match),
+		.of_match_table = bmp280_of_i2c_match,
 		.pm = &bmp280_dev_pm_ops,
 	},
 	.probe		= bmp280_i2c_probe,
-- 
2.24.0

