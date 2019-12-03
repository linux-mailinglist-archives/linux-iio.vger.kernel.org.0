Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14E10FC60
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2019 12:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfLCLR6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Dec 2019 06:17:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:45287 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbfLCLR6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Dec 2019 06:17:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 03:17:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="213396737"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2019 03:17:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4C4B0FC; Tue,  3 Dec 2019 13:17:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] iio: adc: ti-ads1015: Make use of device property API
Date:   Tue,  3 Dec 2019 13:17:53 +0200
Message-Id: <20191203111753.55146-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203111753.55146-1-andriy.shevchenko@linux.intel.com>
References: <20191203111753.55146-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of device property API in this driver so that both OF based
system and ACPI based system can use this driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-ads1015.c | 59 +++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 3b123b4f0b99..a128236ec3cc 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -12,10 +12,10 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/pm_runtime.h>
 #include <linux/mutex.h>
@@ -77,6 +77,7 @@
 #define ADS1015_DEFAULT_CHAN		0
 
 enum chip_ids {
+	ADSXXXX = 0,
 	ADS1015,
 	ADS1115,
 };
@@ -843,65 +844,58 @@ static const struct iio_info ads1115_info = {
 	.attrs          = &ads1115_attribute_group,
 };
 
-#ifdef CONFIG_OF
-static int ads1015_get_channels_config_of(struct i2c_client *client)
+static int ads1015_client_get_channels_config(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
-	struct device_node *node;
+	struct device *dev = &client->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev), *child;
+	int i = -1;
 
-	if (!client->dev.of_node ||
-	    !of_get_next_child(client->dev.of_node, NULL))
-		return -EINVAL;
-
-	for_each_child_of_node(client->dev.of_node, node) {
+	fwnode_for_each_child_node(fwnode, child) {
 		u32 pval;
 		unsigned int channel;
 		unsigned int pga = ADS1015_DEFAULT_PGA;
 		unsigned int data_rate = ADS1015_DEFAULT_DATA_RATE;
 
-		if (of_property_read_u32(node, "reg", &pval)) {
-			dev_err(&client->dev, "invalid reg on %pOF\n",
-				node);
+		if (fwnode_property_read_u32(child, "reg", &pval)) {
+			dev_err(dev, "invalid reg on %pfw\n", child);
 			continue;
 		}
 
 		channel = pval;
 		if (channel >= ADS1015_CHANNELS) {
-			dev_err(&client->dev,
-				"invalid channel index %d on %pOF\n",
-				channel, node);
+			dev_err(dev, "invalid channel index %d on %pfw\n",
+				channel, child);
 			continue;
 		}
 
-		if (!of_property_read_u32(node, "ti,gain", &pval)) {
+		if (!fwnode_property_read_u32(child, "ti,gain", &pval)) {
 			pga = pval;
 			if (pga > 6) {
-				dev_err(&client->dev, "invalid gain on %pOF\n",
-					node);
-				of_node_put(node);
+				dev_err(dev, "invalid gain on %pfw\n", child);
+				fwnode_handle_put(child);
 				return -EINVAL;
 			}
 		}
 
-		if (!of_property_read_u32(node, "ti,datarate", &pval)) {
+		if (!fwnode_property_read_u32(child, "ti,datarate", &pval)) {
 			data_rate = pval;
 			if (data_rate > 7) {
-				dev_err(&client->dev,
-					"invalid data_rate on %pOF\n",
-					node);
-				of_node_put(node);
+				dev_err(dev, "invalid data_rate on %pfw\n", child);
+				fwnode_handle_put(child);
 				return -EINVAL;
 			}
 		}
 
 		data->channel_data[channel].pga = pga;
 		data->channel_data[channel].data_rate = data_rate;
+
+		i++;
 	}
 
-	return 0;
+	return i < 0 ? -EINVAL : 0;
 }
-#endif
 
 static void ads1015_get_channels_config(struct i2c_client *client)
 {
@@ -910,10 +904,9 @@ static void ads1015_get_channels_config(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
 
-#ifdef CONFIG_OF
-	if (!ads1015_get_channels_config_of(client))
+	if (!ads1015_client_get_channels_config(client))
 		return;
-#endif
+
 	/* fallback on default configuration */
 	for (k = 0; k < ADS1015_CHANNELS; ++k) {
 		data->channel_data[k].pga = ADS1015_DEFAULT_PGA;
@@ -951,9 +944,8 @@ static int ads1015_probe(struct i2c_client *client,
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (client->dev.of_node)
-		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
-	else
+	chip = (enum chip_ids)device_get_match_data(&client->dev);
+	if (chip == ADSXXXX)
 		chip = id->driver_data;
 	switch (chip) {
 	case ADS1015:
@@ -968,6 +960,9 @@ static int ads1015_probe(struct i2c_client *client,
 		indio_dev->info = &ads1115_info;
 		data->data_rate = (unsigned int *) &ads1115_data_rate;
 		break;
+	default:
+		dev_err(&client->dev, "Unknown chip %d\n", chip);
+		return -EINVAL;
 	}
 
 	data->event_channel = ADS1015_CHANNELS;
-- 
2.24.0

