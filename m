Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67A1264B61
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgIJRgw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgIJRgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99E70221EB;
        Thu, 10 Sep 2020 17:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759334;
        bh=xVW61def85Uv0/fHWE76hr7db86tAYKWR+K1Cfw3w6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00FBS4IWTiSEGd12SWPOextXxbgtfzNhh+8z64wnNC6Bgb/Gb3SQKzBdtlBjm9/7b
         sbzoc7nY0ReXXMwYOo3cph1zJRU9ciJ2z/F3KGcw7cF7cc/d55qkry2H5HvnIuhTsa
         vKjrVlUgGUw6SGRiupmh6ersw/a0WTQ4ngXiDp/U=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 16/38] iio:potentiostat:lmp91000: Drop of_match_ptr and use generic fw accessors
Date:   Thu, 10 Sep 2020 18:32:20 +0100
Message-Id: <20200910173242.621168-17-jic23@kernel.org>
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

This change allows use of this driver with ACPI via PRP0001 and removes
an example of an anti pattern I'm trying to remove from IIO.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/potentiostat/lmp91000.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 67ae635a05f3..f34ca769dc20 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -205,13 +205,12 @@ static const struct iio_info lmp91000_info = {
 static int lmp91000_read_config(struct lmp91000_data *data)
 {
 	struct device *dev = data->dev;
-	struct device_node *np = dev->of_node;
 	unsigned int reg, val;
 	int i, ret;
 
-	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
+	ret = device_property_read_u32(dev, "ti,tia-gain-ohm", &val);
 	if (ret) {
-		if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
+		if (!device_property_read_bool(dev, "ti,external-tia-resistor")) {
 			dev_err(dev, "no ti,tia-gain-ohm defined and external resistor not specified\n");
 			return ret;
 		}
@@ -232,7 +231,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 		return ret;
 	}
 
-	ret = of_property_read_u32(np, "ti,rload-ohm", &val);
+	ret = device_property_read_u32(dev, "ti,rload-ohm", &val);
 	if (ret) {
 		val = 100;
 		dev_info(dev, "no ti,rload-ohm defined, default to %d\n", val);
@@ -422,7 +421,7 @@ MODULE_DEVICE_TABLE(i2c, lmp91000_id);
 static struct i2c_driver lmp91000_driver = {
 	.driver = {
 		.name = LMP91000_DRV_NAME,
-		.of_match_table = of_match_ptr(lmp91000_of_match),
+		.of_match_table = lmp91000_of_match,
 	},
 	.probe = lmp91000_probe,
 	.remove = lmp91000_remove,
-- 
2.28.0

