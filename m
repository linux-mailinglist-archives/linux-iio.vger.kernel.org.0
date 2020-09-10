Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D67264B88
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgIJRkH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbgIJRgH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:07 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1101C206A1;
        Thu, 10 Sep 2020 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759340;
        bh=EfAWBIN9frRch8G2sNi2HkkIqXjbdjByclva8hteT/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGzSV+img0h5e08FE/Xdv6trNbfJY5VJuxRSJ+3Xa/Jer+IbULtZGvQP4Y1FRP/3c
         YQbksUnniAspImbFI9iLma1eWTTVURAwWm8n7GiZAz95eKPmfvRlXd9bd680WVnGzg
         ZSthg9MneDD4ViuWsHzcuhrs31ftG/nob27hya9A=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH 20/38] iio:pressure:zpa2326: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:24 +0100
Message-Id: <20200910173242.621168-21-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910173242.621168-1-jic23@kernel.org>
References: <20200910173242.621168-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This prevents use of this driver with ACPI via PRP0001 and is
an example of an anti pattern I'm trying to remove from IIO.
Hence drop from this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/zpa2326_i2c.c | 6 ++----
 drivers/iio/pressure/zpa2326_spi.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326_i2c.c b/drivers/iio/pressure/zpa2326_i2c.c
index 1a65791ba279..95d9739444c4 100644
--- a/drivers/iio/pressure/zpa2326_i2c.c
+++ b/drivers/iio/pressure/zpa2326_i2c.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/i2c.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include "zpa2326.h"
 
 /*
@@ -66,18 +66,16 @@ static const struct i2c_device_id zpa2326_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, zpa2326_i2c_ids);
 
-#if defined(CONFIG_OF)
 static const struct of_device_id zpa2326_i2c_matches[] = {
 	{ .compatible = "murata,zpa2326" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, zpa2326_i2c_matches);
-#endif
 
 static struct i2c_driver zpa2326_i2c_driver = {
 	.driver = {
 		.name           = "zpa2326-i2c",
-		.of_match_table = of_match_ptr(zpa2326_i2c_matches),
+		.of_match_table = zpa2326_i2c_matches,
 		.pm             = ZPA2326_PM_OPS,
 	},
 	.probe    = zpa2326_probe_i2c,
diff --git a/drivers/iio/pressure/zpa2326_spi.c b/drivers/iio/pressure/zpa2326_spi.c
index f37a4c738c75..85201a4bae44 100644
--- a/drivers/iio/pressure/zpa2326_spi.c
+++ b/drivers/iio/pressure/zpa2326_spi.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include "zpa2326.h"
 
 /*
@@ -70,18 +70,16 @@ static const struct spi_device_id zpa2326_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, zpa2326_spi_ids);
 
-#if defined(CONFIG_OF)
 static const struct of_device_id zpa2326_spi_matches[] = {
 	{ .compatible = "murata,zpa2326" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, zpa2326_spi_matches);
-#endif
 
 static struct spi_driver zpa2326_spi_driver = {
 	.driver = {
 		.name           = "zpa2326-spi",
-		.of_match_table = of_match_ptr(zpa2326_spi_matches),
+		.of_match_table = zpa2326_spi_matches,
 		.pm             = ZPA2326_PM_OPS,
 	},
 	.probe    = zpa2326_probe_spi,
-- 
2.28.0

