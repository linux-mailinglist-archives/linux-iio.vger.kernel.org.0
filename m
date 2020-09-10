Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195EC264B83
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgIJRjz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgIJRgu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:50 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128182220F;
        Thu, 10 Sep 2020 17:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759348;
        bh=ANDr36kbhRkXPrMr7XRTbOM5qPlEbp4wf/K4dJHBd9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rD0pwttYjRHgL/DdaNWVUHNpPkjRuN0OiE6Eto6kiCVVw9VQkUF+uM+PrfWU388II
         P/HFNR4gDQkdv0bmq3XG7WS92m6eCOLAWwUb66p4jn7uwyhL+qkY4xF9GGsOIF/dbH
         kZsr4y3Xvw44BImSPheGm2TFBwKFzWXuJbyESRNw=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: [PATCH 26/38] iio:chemical:sgp30: Use local variable dev to simplify code
Date:   Thu, 10 Sep 2020 18:32:30 +0100
Message-Id: <20200910173242.621168-27-jic23@kernel.org>
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

This cleans up the code at bit, but is primarily here as a precusor
to the next patch. I've only done this for the two functions
which use the dev pointer repeatedly.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Brauchli <andreas.brauchli@sensirion.com>
---
 drivers/iio/chemical/sgp30.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 2c4086c48136..410565aa20b6 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -409,6 +409,7 @@ static int sgp_read_raw(struct iio_dev *indio_dev,
 static int sgp_check_compat(struct sgp_data *data,
 			    unsigned int product_id)
 {
+	struct device *dev = &data->client->dev;
 	const struct sgp_version *supported_versions;
 	u16 ix, num_fs;
 	u16 product, generation, major, minor;
@@ -416,21 +417,20 @@ static int sgp_check_compat(struct sgp_data *data,
 	/* driver does not match product */
 	generation = SGP_VERS_GEN(data);
 	if (generation != 0) {
-		dev_err(&data->client->dev,
+		dev_err(dev,
 			"incompatible product generation %d != 0", generation);
 		return -ENODEV;
 	}
 
 	product = SGP_VERS_PRODUCT(data);
 	if (product != product_id) {
-		dev_err(&data->client->dev,
-			"sensor reports a different product: 0x%04hx\n",
+		dev_err(dev, "sensor reports a different product: 0x%04hx\n",
 			product);
 		return -ENODEV;
 	}
 
 	if (SGP_VERS_RESERVED(data))
-		dev_warn(&data->client->dev, "reserved bit is set\n");
+		dev_warn(dev, "reserved bit is set\n");
 
 	/* engineering samples are not supported: no interface guarantees */
 	if (SGP_VERS_ENG_BIT(data))
@@ -456,8 +456,7 @@ static int sgp_check_compat(struct sgp_data *data,
 		    minor >= supported_versions[ix].minor)
 			return 0;
 	}
-	dev_err(&data->client->dev, "unsupported sgp version: %d.%d\n",
-		major, minor);
+	dev_err(dev, "unsupported sgp version: %d.%d\n", major, minor);
 
 	return -ENODEV;
 }
@@ -499,17 +498,18 @@ static const struct of_device_id sgp_dt_ids[] = {
 static int sgp_probe(struct i2c_client *client,
 		     const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct sgp_data *data;
 	const struct of_device_id *of_id;
 	unsigned long product_id;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
-	of_id = of_match_device(sgp_dt_ids, &client->dev);
+	of_id = of_match_device(sgp_dt_ids, dev);
 	if (of_id)
 		product_id = (unsigned long)of_id->data;
 	else
@@ -541,9 +541,9 @@ static int sgp_probe(struct i2c_client *client,
 
 	sgp_init(data);
 
-	ret = devm_iio_device_register(&client->dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
-		dev_err(&client->dev, "failed to register iio device\n");
+		dev_err(dev, "failed to register iio device\n");
 		return ret;
 	}
 
-- 
2.28.0

