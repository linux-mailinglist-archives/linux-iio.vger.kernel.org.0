Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A84220C800
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgF1MjH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgF1MjG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:06 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A56AE20738;
        Sun, 28 Jun 2020 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347946;
        bh=cyIhB9UJiXDOtLIWMJ2O9p1GGj0vCZZv7qByZCulUIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=veldQ0N9Xg/gvBQVxnw+R+/B36XoFvWjL+CLTJlTK+mdiEuu5QZZGYbC80ODblikn
         tdHKSQ3pERtxigZa1MUgneiv4WDgO0OPJKOsCv7f3AiJiUT8ibElGTD8yVI6MIigDY
         JCYHTJyZdkkMzthZoBAGdyUhVGtAryUGIav6tUiA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/23] iio:adc:max1363: Drop of_match_ptr and use generic device_get_match_data
Date:   Sun, 28 Jun 2020 13:36:36 +0100
Message-Id: <20200628123654.32830-6-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Allows driver to use ACPI PRP0001 binding and there was no particular
advantage in having the protections in this driver.

Mostly this part of an effort to remove as many OF specific bits
of handling from IIO and use the generic forms where possible.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max1363.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index d8da5da74b77..420e2ec154fc 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -22,8 +22,8 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -1529,8 +1529,6 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_OF
-
 #define MAX1363_COMPATIBLE(of_compatible, cfg) {		\
 			.compatible = of_compatible,		\
 			.data = &max1363_chip_info_tbl[cfg],	\
@@ -1578,7 +1576,6 @@ static const struct of_device_id max1363_of_match[] = {
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, max1363_of_match);
-#endif
 
 static int max1363_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
@@ -1613,7 +1610,7 @@ static int max1363_probe(struct i2c_client *client,
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
 
-	st->chip_info = of_device_get_match_data(&client->dev);
+	st->chip_info = device_get_match_data(&client->dev);
 	if (!st->chip_info)
 		st->chip_info = &max1363_chip_info_tbl[id->driver_data];
 	st->client = client;
@@ -1756,7 +1753,7 @@ MODULE_DEVICE_TABLE(i2c, max1363_id);
 static struct i2c_driver max1363_driver = {
 	.driver = {
 		.name = "max1363",
-		.of_match_table = of_match_ptr(max1363_of_match),
+		.of_match_table = max1363_of_match,
 	},
 	.probe = max1363_probe,
 	.remove = max1363_remove,
-- 
2.27.0

