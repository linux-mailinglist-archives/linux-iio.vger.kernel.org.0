Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD01846866E
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355598AbhLDRLS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355602AbhLDRLR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC020C061751
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 09:07:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D334B80D35
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF2AC341C2;
        Sat,  4 Dec 2021 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637669;
        bh=yI4iIrJOf116Satm5JvC8WucjCvAuqgKBWIra0qeQ6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjrMla2WjKAViJFqOdDO/LR3Odhc9iuBOEx4FNIO7gPXZlfQwbhX5khgAiNQeskly
         pTuwmwA+7Le92mxDFSJDBcyPpAXdovEaSc7vEBkuxNdTouz42aVHP6n8/BTkYdB9Ws
         r/X08nsKhIH0jb34fpsuXm13uYfguvJm6KJRy8T0aqZIP5EbabdMDfWIRMbndh8g5P
         Yndluvn/APbBQO/lxD/ffyNXO8iBiB6YEfZvwXUhGajdTWfxVd9kNvG/ZSm6eKLdID
         xSOhgZJxEDeWwxh5HNR6LoRO57ykVOclzapxM5W4gmEDPGdDmLnyG/Rx1CV7k1qrGo
         yJwSgQs/tVurQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 07/12] iio:adc:max9611: Switch to generic firmware properties.
Date:   Sat,  4 Dec 2021 17:12:32 +0000
Message-Id: <20211204171237.2769210-8-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note the handling of the device tree node in this driver was somewhat
unusual.  I have cleaned that up whilst also moving over to generic
properties.

Part of a general attempt to move all IIO drivers over to generic
firmware properties both as a general improvement and to avoid sources
of cut and paste into future drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max9611.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 052ab23f10b2..01a4275e9c46 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -22,7 +22,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 #define DRIVER_NAME			"max9611"
 
@@ -513,11 +514,9 @@ static int max9611_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
-	const struct device_node *of_node = client->dev.of_node;
-	const struct of_device_id *of_id =
-		of_match_device(max9611_of_table, &client->dev);
 	struct max9611_dev *max9611;
 	struct iio_dev *indio_dev;
+	struct device *dev = &client->dev;
 	unsigned int of_shunt;
 	int ret;
 
@@ -528,15 +527,14 @@ static int max9611_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 
 	max9611			= iio_priv(indio_dev);
-	max9611->dev		= &client->dev;
+	max9611->dev		= dev;
 	max9611->i2c_client	= client;
 	mutex_init(&max9611->lock);
 
-	ret = of_property_read_u32(of_node, shunt_res_prop, &of_shunt);
+	ret = device_property_read_u32(dev, shunt_res_prop, &of_shunt);
 	if (ret) {
-		dev_err(&client->dev,
-			"Missing %s property for %pOF node\n",
-			shunt_res_prop, of_node);
+		dev_err(dev, "Missing %s property for %pfw node\n",
+			shunt_res_prop, dev_fwnode(dev));
 		return ret;
 	}
 	max9611->shunt_resistor_uohm = of_shunt;
@@ -545,13 +543,13 @@ static int max9611_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	indio_dev->name		= of_id->data;
+	indio_dev->name		= device_get_match_data(dev);
 	indio_dev->modes	= INDIO_DIRECT_MODE;
 	indio_dev->info		= &indio_info;
 	indio_dev->channels	= max9611_channels;
 	indio_dev->num_channels	= ARRAY_SIZE(max9611_channels);
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static struct i2c_driver max9611_driver = {
-- 
2.34.1

