Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88426264B85
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgIJRkC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbgIJRgk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:40 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF06922210;
        Thu, 10 Sep 2020 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759346;
        bh=NLISiQ3mz76FOuNlkNOVftUmh3IA1PiRrRW2tBzQnLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yiutdbcPNkBpdYcZWgxEeWAP826fk669v3YNd3/Uj9YOg0/KrE6I2Qvz4SLVycMLC
         US45wiVkTIH6GOoc/trkGUYLMMDoUkatAYFjaWncqFPwKERshbshfRxy11IFHGHpZm
         IPa6AIHpOGXEqTTUrDrzlV63TYivALsbd1W89b1s=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 25/38] iio:chemical:atlas-sensor: Drop of_match_ptr and use generic fw accessors
Date:   Thu, 10 Sep 2020 18:32:29 +0100
Message-Id: <20200910173242.621168-26-jic23@kernel.org>
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

of_match_ptr() prevents use of this driver with ACPI via PRP0001 and is
an example of an anti pattern I'm trying to remove from IIO.
Hence drop from this driver and use generic fw accessors to check
if there is a fw_node and get the id.

It might be neater to use pointers rather than indexes for
the device_data but that is another issue and should be handled
separately.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 43069636fcd5..cdab9d04dedd 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -15,7 +15,7 @@
 #include <linux/irq.h>
 #include <linux/irq_work.h>
 #include <linux/i2c.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -620,7 +620,6 @@ static int atlas_probe(struct i2c_client *client,
 {
 	struct atlas_data *data;
 	struct atlas_device *chip;
-	const struct of_device_id *of_id;
 	struct iio_trigger *trig;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -629,11 +628,10 @@ static int atlas_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	of_id = of_match_device(atlas_dt_ids, &client->dev);
-	if (!of_id)
+	if (!dev_fwnode(&client->dev))
 		chip = &atlas_devices[id->driver_data];
 	else
-		chip = &atlas_devices[(unsigned long)of_id->data];
+		chip = &atlas_devices[(unsigned long)device_get_match_data(&client->dev)];
 
 	indio_dev->info = &atlas_info;
 	indio_dev->name = ATLAS_DRV_NAME;
@@ -775,7 +773,7 @@ static const struct dev_pm_ops atlas_pm_ops = {
 static struct i2c_driver atlas_driver = {
 	.driver = {
 		.name	= ATLAS_DRV_NAME,
-		.of_match_table	= of_match_ptr(atlas_dt_ids),
+		.of_match_table	= atlas_dt_ids,
 		.pm	= &atlas_pm_ops,
 	},
 	.probe		= atlas_probe,
-- 
2.28.0

