Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD2969CAEF
	for <lists+linux-iio@lfdr.de>; Mon, 20 Feb 2023 13:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjBTM0t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Feb 2023 07:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjBTM0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2023 07:26:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BFA1C7C9
        for <linux-iio@vger.kernel.org>; Mon, 20 Feb 2023 04:26:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pU5Ex-0003Dp-3t; Mon, 20 Feb 2023 13:25:55 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pU5Eu-006GFN-HE; Mon, 20 Feb 2023 13:25:53 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pU5Eu-003sk3-Tj; Mon, 20 Feb 2023 13:25:52 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v4 2/5] iio: temperature: tmp117: improve fallback capabilities
Date:   Mon, 20 Feb 2023 13:25:49 +0100
Message-Id: <20230220122552.925216-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230220122552.925216-1-m.felsch@pengutronix.de>
References: <20230220122552.925216-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Don't error if the device-id found don't match the device-id for the
TMP117 sensor since other TMPxxx might be compatible to the TMP117. The
fallback mechanism tries to gather the required information from the
of_device_id or from the i2c_client information.

The commit also prepares the driver for adding new devices more easily
by making use of switch-case at the relevant parts.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v4:
- new patch to implement possible fallback (Jonathan)

 drivers/iio/temperature/tmp117.c | 67 +++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index f9b8f2b570f6b..4ddb8cf9a29ab 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/property.h>
 
 #include <linux/iio/iio.h>
 
@@ -113,32 +114,60 @@ static const struct iio_info tmp117_info = {
 	.write_raw = tmp117_write_raw,
 };
 
+static const struct of_device_id tmp117_of_match[] = {
+	{ .compatible = "ti,tmp117", .data = (void *)TMP117_DEVICE_ID },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tmp117_of_match);
+
+static const struct i2c_device_id tmp117_id[] = {
+	{ "tmp117", TMP117_DEVICE_ID },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tmp117_id);
+
 static int tmp117_identify(struct i2c_client *client)
 {
+	unsigned long match_data;
 	int dev_id;
 
 	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
 	if (dev_id < 0)
 		return dev_id;
-	if (dev_id != TMP117_DEVICE_ID) {
-		dev_err(&client->dev, "TMP117 not found\n");
-		return -ENODEV;
+
+	switch (dev_id) {
+	case TMP117_DEVICE_ID:
+		return dev_id;
 	}
-	return 0;
+
+	dev_info(&client->dev, "Unknown device id (0x%x), use fallback compatible\n",
+		 dev_id);
+
+	match_data = (uintptr_t)device_get_match_data(&client->dev);
+	if (match_data)
+		return match_data;
+
+	match_data = i2c_match_id(tmp117_id, client)->driver_data;
+	if (match_data)
+		return match_data;
+
+	dev_err(&client->dev, "error: No valid fallback found\n");
+
+	return -ENODEV;
 }
 
 static int tmp117_probe(struct i2c_client *client)
 {
 	struct tmp117_data *data;
 	struct iio_dev *indio_dev;
-	int ret;
+	int dev_id;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
-	ret = tmp117_identify(client);
-	if (ret < 0)
-		return ret;
+	dev_id = tmp117_identify(client);
+	if (dev_id < 0)
+		return dev_id;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -148,28 +177,20 @@ static int tmp117_probe(struct i2c_client *client)
 	data->client = client;
 	data->calibbias = 0;
 
-	indio_dev->name = "tmp117";
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &tmp117_info;
 
-	indio_dev->channels = tmp117_channels;
-	indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
+	switch (dev_id) {
+	case TMP117_DEVICE_ID:
+		indio_dev->channels = tmp117_channels;
+		indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
+		indio_dev->name = "tmp117";
+		break;
+	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-static const struct of_device_id tmp117_of_match[] = {
-	{ .compatible = "ti,tmp117", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, tmp117_of_match);
-
-static const struct i2c_device_id tmp117_id[] = {
-	{ "tmp117", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, tmp117_id);
-
 static struct i2c_driver tmp117_driver = {
 	.driver = {
 		.name	= "tmp117",
-- 
2.30.2

