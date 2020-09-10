Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E69264B6F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgIJRiL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 13:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgIJRgw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:52 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C012822211;
        Thu, 10 Sep 2020 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759350;
        bh=A+rbBZcSwA1vVV+gXrbuzEKrGKprbEimgMWYsizCN5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJS/gzlT85w+GcyJ6uuCZKJqUyRZVwZ2S5mfzsmaIgx/W99QLj3YJ47amWyuPfxbX
         tPP1KL3INZ3qLpD8AAcwFJZVo6cy0AozRcl94VGS8rADc9uFWdvOQ3RhYVqJIXzM5d
         HqsWa8btlnXt/5cMNEYKGAYNQlvQ69m38+3Z/tWg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 28/38] iio:chemical:vz89x: Introduce local struct device pointer.
Date:   Thu, 10 Sep 2020 18:32:32 +0100
Message-Id: <20200910173242.621168-29-jic23@kernel.org>
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

Avoids lots of repition of &client->dev and will make the next
patch tidier.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/vz89x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 5586eb8e12cd..3cd469578590 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -352,12 +352,13 @@ MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
 static int vz89x_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct vz89x_data *data;
 	const struct of_device_id *of_id;
 	int chip_id;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 	data = iio_priv(indio_dev);
@@ -370,7 +371,7 @@ static int vz89x_probe(struct i2c_client *client,
 	else
 		return -EOPNOTSUPP;
 
-	of_id = of_match_device(vz89x_dt_ids, &client->dev);
+	of_id = of_match_device(vz89x_dt_ids, dev);
 	if (!of_id)
 		chip_id = id->driver_data;
 	else
@@ -383,13 +384,13 @@ static int vz89x_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	indio_dev->info = &vz89x_info;
-	indio_dev->name = dev_name(&client->dev);
+	indio_dev->name = dev_name(dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels = data->chip->channels;
 	indio_dev->num_channels = data->chip->num_channels;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct i2c_device_id vz89x_id[] = {
-- 
2.28.0

