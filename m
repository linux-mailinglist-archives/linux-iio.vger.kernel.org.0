Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D734264B7C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgIJRjK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgIJRhm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:42 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828EB2222C;
        Thu, 10 Sep 2020 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759364;
        bh=hPyt21/+/dzyq2e1Ad7oyy9C4nHZn+khIrRfxc6UA3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6srSpKvmM45xEokP7P0uIH/jVtLwYptI8SocKupXb1rrMLfGu52aUFrpJ/sS61Zw
         prygQzh02NUGVhrSW3keE3zkjTT5FM3uH/PfQrySz9VWB+5sPvYlrk/zcGoSHXN8a9
         DWyqjpro2pHaFLpdNr42+QHdKVe+0hMAv4XAZziA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 38/38] iio:health:max30102: Drop of_match_ptr and use generic fw accessors
Date:   Thu, 10 Sep 2020 18:32:42 +0100
Message-Id: <20200910173242.621168-39-jic23@kernel.org>
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

This enables use of the driver with ACPI PRP0001 and also removes
an antipattern that I am trying to clear out of IIO to avoid
it being coppied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/health/max30102.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index bb504e993f19..543021d8df34 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -19,7 +19,7 @@
 #include <linux/irq.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -323,11 +323,10 @@ static int max30102_get_current_idx(unsigned int val, int *reg)
 static int max30102_led_init(struct max30102_data *data)
 {
 	struct device *dev = &data->client->dev;
-	struct device_node *np = dev->of_node;
 	unsigned int val;
 	int reg, ret;
 
-	ret = of_property_read_u32(np, "maxim,red-led-current-microamp", &val);
+	ret = device_property_read_u32(dev, "maxim,red-led-current-microamp", &val);
 	if (ret) {
 		dev_info(dev, "no red-led-current-microamp set\n");
 
@@ -346,7 +345,7 @@ static int max30102_led_init(struct max30102_data *data)
 		return ret;
 
 	if (data->chip_id == max30105) {
-		ret = of_property_read_u32(np,
+		ret = device_property_read_u32(dev,
 			"maxim,green-led-current-microamp", &val);
 		if (ret) {
 			dev_info(dev, "no green-led-current-microamp set\n");
@@ -368,7 +367,7 @@ static int max30102_led_init(struct max30102_data *data)
 			return ret;
 	}
 
-	ret = of_property_read_u32(np, "maxim,ir-led-current-microamp", &val);
+	ret = device_property_read_u32(dev, "maxim,ir-led-current-microamp", &val);
 	if (ret) {
 		dev_info(dev, "no ir-led-current-microamp set\n");
 
@@ -624,7 +623,7 @@ MODULE_DEVICE_TABLE(of, max30102_dt_ids);
 static struct i2c_driver max30102_driver = {
 	.driver = {
 		.name	= MAX30102_DRV_NAME,
-		.of_match_table	= of_match_ptr(max30102_dt_ids),
+		.of_match_table	= max30102_dt_ids,
 	},
 	.probe		= max30102_probe,
 	.remove		= max30102_remove,
-- 
2.28.0

