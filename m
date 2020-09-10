Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E252264B6B
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgIJRhn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgIJRgB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:01 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB73221EE;
        Thu, 10 Sep 2020 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759330;
        bh=mgqvfp59U/VE518HLZVxRkDBS9RAo+t9gBat3CNe6bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iP9wwDTlY4OnOysAijJLCua7B4dJPuBRcgtTAP0xpkiklixH+lQzpJMtKn610aYrZ
         DmU3IhF+lSK76VsJdxOoaXGw9X8kds6qCU4GfKFdJI4WROfA3aZas/H2qUBXjRJlRE
         pnPd9IA+lNwtfK184mWGaC+Uj/QL/WOclvxui8hA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 13/38] iio:dac:mcp4725: drop of_match_ptr and use generic fw properties
Date:   Thu, 10 Sep 2020 18:32:17 +0100
Message-Id: <20200910173242.621168-14-jic23@kernel.org>
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

This enables use of ACPI PRP0001 and removes an antipattern I am
trying to stop people copying in IIO.

This particular case is more complex than most because it allowed
probing via sysfs with out a fwnode but would presumably always
have then failed.   Now the code will assume that properties are
the defaults if not specified or the firmware node is not present.
This relaxation of the constraints should not break any existing
cases and may enable some new ones.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/dac/mcp4725.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index ee174d224110..beb9a15b7c74 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -16,8 +16,8 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
-#include <linux/of_device.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -357,29 +357,16 @@ static const struct iio_info mcp4725_info = {
 	.attrs = &mcp4725_attribute_group,
 };
 
-#ifdef CONFIG_OF
 static int mcp4725_probe_dt(struct device *dev,
 			    struct mcp4725_platform_data *pdata)
 {
-	struct device_node *np = dev->of_node;
-
-	if (!np)
-		return -ENODEV;
-
 	/* check if is the vref-supply defined */
-	pdata->use_vref = of_property_read_bool(np, "vref-supply");
+	pdata->use_vref = device_property_read_bool(dev, "vref-supply");
 	pdata->vref_buffered =
-		of_property_read_bool(np, "microchip,vref-buffered");
+		device_property_read_bool(dev, "microchip,vref-buffered");
 
 	return 0;
 }
-#else
-static int mcp4725_probe_dt(struct device *dev,
-			    struct mcp4725_platform_data *platform_data)
-{
-	return -ENODEV;
-}
-#endif
 
 static int mcp4725_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
@@ -398,8 +385,8 @@ static int mcp4725_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	if (client->dev.of_node)
-		data->id = (enum chip_id)of_device_get_match_data(&client->dev);
+	if (dev_fwnode(&client->dev))
+		data->id = (enum chip_id)device_get_match_data(&client->dev);
 	else
 		data->id = id->driver_data;
 	pdata = dev_get_platdata(&client->dev);
@@ -519,7 +506,6 @@ static const struct i2c_device_id mcp4725_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mcp4725_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id mcp4725_of_match[] = {
 	{
 		.compatible = "microchip,mcp4725",
@@ -532,12 +518,11 @@ static const struct of_device_id mcp4725_of_match[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp4725_of_match);
-#endif
 
 static struct i2c_driver mcp4725_driver = {
 	.driver = {
 		.name	= MCP4725_DRV_NAME,
-		.of_match_table = of_match_ptr(mcp4725_of_match),
+		.of_match_table = mcp4725_of_match,
 		.pm	= &mcp4725_pm_ops,
 	},
 	.probe		= mcp4725_probe,
-- 
2.28.0

