Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFF56A5519
	for <lists+linux-iio@lfdr.de>; Tue, 28 Feb 2023 10:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjB1JFe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Feb 2023 04:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjB1JFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2023 04:05:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44E16897
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2023 01:05:31 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvvF-0002s8-V3; Tue, 28 Feb 2023 10:05:21 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvvE-000poD-HB; Tue, 28 Feb 2023 10:05:20 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvvD-002DrR-GG; Tue, 28 Feb 2023 10:05:19 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v6 4/5] iio: temperature: tmp117: add TI TMP116 support
Date:   Tue, 28 Feb 2023 10:05:17 +0100
Message-Id: <20230228090518.529811-5-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230228090518.529811-1-m.felsch@pengutronix.de>
References: <20230228090518.529811-1-m.felsch@pengutronix.de>
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
v6:
- fix compiling
v5:
- no changes
v4:
- split into two patches
  - 1st) handle fallback (Jonathan)
  - 2nd) this one, adding the support for tmp116
v3:
- use switch case within probe() as well
- don't hide smbus_read error within tmp117_identify()
- add dedicated compatible
v2:
- no changes

 drivers/iio/temperature/tmp117.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 8a3992d9ee937..9bfb818c3bf1d 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -32,9 +32,11 @@
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
@@ -109,6 +111,14 @@ static const struct iio_chan_spec tmp117_channels[] = {
 	},
 };
 
+static const struct iio_chan_spec tmp116_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
 static const struct iio_info tmp117_info = {
 	.read_raw = tmp117_read_raw,
 	.write_raw = tmp117_write_raw,
@@ -125,6 +135,7 @@ static int tmp117_identify(struct i2c_client *client)
 		return dev_id;
 
 	switch (dev_id) {
+	case TMP116_DEVICE_ID:
 	case TMP117_DEVICE_ID:
 		return dev_id;
 	}
@@ -172,6 +183,11 @@ static int tmp117_probe(struct i2c_client *client)
 	indio_dev->info = &tmp117_info;
 
 	switch (dev_id) {
+	case TMP116_DEVICE_ID:
+		indio_dev->channels = tmp116_channels;
+		indio_dev->num_channels = ARRAY_SIZE(tmp116_channels);
+		indio_dev->name = "tmp116";
+		break;
 	case TMP117_DEVICE_ID:
 		indio_dev->channels = tmp117_channels;
 		indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
@@ -183,12 +199,14 @@ static int tmp117_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id tmp117_of_match[] = {
+	{ .compatible = "ti,tmp116", .data = (void *)TMP116_DEVICE_ID },
 	{ .compatible = "ti,tmp117", .data = (void *)TMP117_DEVICE_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tmp117_of_match);
 
 static const struct i2c_device_id tmp117_id[] = {
+	{ "tmp116", TMP116_DEVICE_ID },
 	{ "tmp117", TMP117_DEVICE_ID },
 	{ }
 };
-- 
2.30.2

