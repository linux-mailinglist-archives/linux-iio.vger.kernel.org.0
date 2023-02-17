Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0B69A83A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 10:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBQJha (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 04:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBQJh3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 04:37:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCA25CF0B
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 01:37:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pSxB5-0006hC-G3; Fri, 17 Feb 2023 10:37:15 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pSxB3-005YBW-8g; Fri, 17 Feb 2023 10:37:14 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pSxB3-007wJp-LL; Fri, 17 Feb 2023 10:37:13 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v3 3/4] iio: temperature: tmp117: add TI TMP116 support
Date:   Fri, 17 Feb 2023 10:37:10 +0100
Message-Id: <20230217093711.1891564-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230217093711.1891564-1-m.felsch@pengutronix.de>
References: <20230217093711.1891564-1-m.felsch@pengutronix.de>
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

The TMP116 is the predecessor of the TMP117. The TMP116 don't support
custom offset calibration data, instead this register is used as generic
EEPROM storage as well.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v3:
- use switch case within probe() as well
- don't hide smbus_read error within tmp117_identify()
- add dedicated compatible

v2:
- no changes

 drivers/iio/temperature/tmp117.c | 46 ++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index f9b8f2b570f6b..728538fbaf9ba 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -31,9 +31,11 @@
 #define TMP117_REG_DEVICE_ID		0xF
 
 #define TMP117_RESOLUTION_10UC		78125
-#define TMP117_DEVICE_ID		0x0117
 #define MICRODEGREE_PER_10MILLIDEGREE	10000
 
+#define TMP116_DEVICE_ID		0x1116
+#define TMP117_DEVICE_ID		0x0117
+
 struct tmp117_data {
 	struct i2c_client *client;
 	s16 calibbias;
@@ -105,6 +107,13 @@ static const struct iio_chan_spec tmp117_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
+};
+
+static const struct iio_chan_spec tmp116_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
@@ -120,25 +129,29 @@ static int tmp117_identify(struct i2c_client *client)
 	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
 	if (dev_id < 0)
 		return dev_id;
-	if (dev_id != TMP117_DEVICE_ID) {
-		dev_err(&client->dev, "TMP117 not found\n");
+
+	switch (dev_id) {
+	case TMP116_DEVICE_ID:
+	case TMP117_DEVICE_ID:
+		return dev_id;
+	default:
+		dev_err(&client->dev, "TMP116/117 not found\n");
 		return -ENODEV;
 	}
-	return 0;
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
@@ -148,24 +161,35 @@ static int tmp117_probe(struct i2c_client *client)
 	data->client = client;
 	data->calibbias = 0;
 
-	indio_dev->name = "tmp117";
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &tmp117_info;
 
-	indio_dev->channels = tmp117_channels;
-	indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
+	switch (dev_id) {
+	case TMP116_DEVICE_ID:
+		indio_dev->channels = tmp116_channels;
+		indio_dev->num_channels = ARRAY_SIZE(tmp116_channels);
+		indio_dev->name = "tmp116";
+		break;
+	case TMP117_DEVICE_ID:
+		indio_dev->channels = tmp117_channels;
+		indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
+		indio_dev->name = "tmp117";
+		break;
+	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct of_device_id tmp117_of_match[] = {
 	{ .compatible = "ti,tmp117", },
+	{ .compatible = "ti,tmp116", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tmp117_of_match);
 
 static const struct i2c_device_id tmp117_id[] = {
 	{ "tmp117", 0 },
+	{ "tmp116", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp117_id);
-- 
2.30.2

