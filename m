Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8CC2D4F01
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 00:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbgLIXty (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 18:49:54 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:57163 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgLIXtr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 18:49:47 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 96AC5240006;
        Wed,  9 Dec 2020 23:49:04 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/6] iio:pressure:ms5637: switch to probe_new
Date:   Thu, 10 Dec 2020 00:48:52 +0100
Message-Id: <20201209234857.1521453-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Switch to the modern i2c probe_new callback and drop the i2c_device_id
array.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/iio/pressure/ms5637.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 5b59a4137d32..7c3f0ccd917c 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -126,8 +126,7 @@ static const struct iio_info ms5637_info = {
 	.attrs = &ms5637_attribute_group,
 };
 
-static int ms5637_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int ms5637_probe(struct i2c_client *client)
 {
 	struct ms_tp_dev *dev_data;
 	struct iio_dev *indio_dev;
@@ -152,7 +151,7 @@ static int ms5637_probe(struct i2c_client *client,
 	mutex_init(&dev_data->lock);
 
 	indio_dev->info = &ms5637_info;
-	indio_dev->name = id->name;
+	indio_dev->name = device_get_match_data(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ms5637_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ms5637_channels);
@@ -170,27 +169,17 @@ static int ms5637_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-static const struct i2c_device_id ms5637_id[] = {
-	{"ms5637", 0},
-	{"ms5805", 0},
-	{"ms5837", 0},
-	{"ms8607-temppressure", 0},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, ms5637_id);
-
 static const struct of_device_id ms5637_of_match[] = {
-	{ .compatible = "meas,ms5637", },
-	{ .compatible = "meas,ms5805", },
-	{ .compatible = "meas,ms5837", },
-	{ .compatible = "meas,ms8607-temppressure", },
+	{ .compatible = "meas,ms5637", .data = "ms5637" },
+	{ .compatible = "meas,ms5805", .data = "ms5805" },
+	{ .compatible = "meas,ms5837", .data = "ms5837" },
+	{ .compatible = "meas,ms8607-temppressure", .data = "ms8607-temppressure" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ms5637_of_match);
 
 static struct i2c_driver ms5637_driver = {
-	.probe = ms5637_probe,
-	.id_table = ms5637_id,
+	.probe_new = ms5637_probe,
 	.driver = {
 		   .name = "ms5637",
 		   .of_match_table = ms5637_of_match,
-- 
2.28.0

