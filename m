Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A14264B82
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgIJRjy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgIJRgw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:52 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 212C522224;
        Thu, 10 Sep 2020 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759352;
        bh=whA4YHQvkK0isrTXudsdfk48GtxCvnci4OPZJuiK4Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oddIwj1jsFDudYX2iLh5XVmh/WukmKaDMJIprwLJJJvfpmSLm3jDg95fr2ZI2StOI
         Y+u1ub8Gg+FLxKIkd7lwbpcYnGfhxZ+o4zXE9A3L1+8Ook3HLaZ81vDZ43RYSNcSm8
         hrzJ7YQ1kyAnS8m5s+U9B8eTFWSnMJlVp2VjdS80=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 29/38] iio:chemical:vz89x: Drop of_match_ptr protection and use generic fw accessors
Date:   Thu, 10 Sep 2020 18:32:33 +0100
Message-Id: <20200910173242.621168-30-jic23@kernel.org>
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
device_get_match_data() doesn't distinguish between no match, and
a match but with NULL data.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/vz89x.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 3cd469578590..23b22a5f5c1c 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -10,8 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -355,7 +354,6 @@ static int vz89x_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct vz89x_data *data;
-	const struct of_device_id *of_id;
 	int chip_id;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -371,11 +369,10 @@ static int vz89x_probe(struct i2c_client *client,
 	else
 		return -EOPNOTSUPP;
 
-	of_id = of_match_device(vz89x_dt_ids, dev);
-	if (!of_id)
+	if (!dev_fwnode(dev))
 		chip_id = id->driver_data;
 	else
-		chip_id = (unsigned long)of_id->data;
+		chip_id = (unsigned long)device_get_match_data(dev);
 
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
@@ -403,7 +400,7 @@ MODULE_DEVICE_TABLE(i2c, vz89x_id);
 static struct i2c_driver vz89x_driver = {
 	.driver = {
 		.name	= "vz89x",
-		.of_match_table = of_match_ptr(vz89x_dt_ids),
+		.of_match_table = vz89x_dt_ids,
 	},
 	.probe = vz89x_probe,
 	.id_table = vz89x_id,
-- 
2.28.0

