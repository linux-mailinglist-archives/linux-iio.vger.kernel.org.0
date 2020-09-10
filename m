Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED8D264B84
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgIJRj6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgIJRgu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:50 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D95520C09;
        Thu, 10 Sep 2020 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759349;
        bh=lacLNbGl4/2YzTZ+mj4TMgbfYzm7gBmGfKlrbUCBWks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8RLYS0KWwhXnv3Qb8S9SDMqMJMsNTvOXbi1vFlt96g3FWPzoJGU07lb8NvgvJLGG
         u+Qutk3UMGffofZ5BiR0OeeWpZPa+8zNlfby0mq31HshKUrfzQ9Kr+SPN3TdGS/VUZ
         D+QrnsoCQT8Z8PVJOA5WJzVxAe0z1R16mWkXma+s=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: [PATCH 27/38] iio:chemical:sgp30: Drop of_match_ptr and use generic fw accessors
Date:   Thu, 10 Sep 2020 18:32:31 +0100
Message-Id: <20200910173242.621168-28-jic23@kernel.org>
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

This change allow the driver to be used with ACPI PRP0001 and removes
an antipattern that I want to avoid being copied into new IIO drivers.

The handling of match_data uses a different approach as
device_get_match_data doesn't distinguish between no match, and
a match but with NULL data.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Brauchli <andreas.brauchli@sensirion.com>
---
 drivers/iio/chemical/sgp30.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
index 410565aa20b6..c2d93b9796ce 100644
--- a/drivers/iio/chemical/sgp30.c
+++ b/drivers/iio/chemical/sgp30.c
@@ -20,9 +20,9 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/i2c.h>
-#include <linux/of_device.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
@@ -501,7 +501,6 @@ static int sgp_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct sgp_data *data;
-	const struct of_device_id *of_id;
 	unsigned long product_id;
 	int ret;
 
@@ -509,9 +508,8 @@ static int sgp_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	of_id = of_match_device(sgp_dt_ids, dev);
-	if (of_id)
-		product_id = (unsigned long)of_id->data;
+	if (dev_fwnode(dev))
+		product_id = (unsigned long)device_get_match_data(dev);
 	else
 		product_id = id->driver_data;
 
@@ -576,7 +574,7 @@ MODULE_DEVICE_TABLE(of, sgp_dt_ids);
 static struct i2c_driver sgp_driver = {
 	.driver = {
 		.name = "sgp30",
-		.of_match_table = of_match_ptr(sgp_dt_ids),
+		.of_match_table = sgp_dt_ids,
 	},
 	.probe = sgp_probe,
 	.remove = sgp_remove,
-- 
2.28.0

