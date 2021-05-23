Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E7A38DBE6
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhEWQZ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 12:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231821AbhEWQZ3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 May 2021 12:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F55E6117A;
        Sun, 23 May 2021 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621787042;
        bh=+nVxAJ/PfEMJfyNe2C1fd113hNSpgLW7/UQow6+A4Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJ9jwfj9hBV1a9X8qYUxQJJWftiOCLKBJpkPwPc0M9JgzxN63YvzjOsov5u8T8iy0
         J91SfcVu7doUTMFyJhwHcY4xxMHFLvNOlYrDCb+Km9L1gqSQDQe5Xd2OUU7/9qwgqa
         eYwVvKm5Bs1tUyxtuMOcz4SQURG+5C2D12X24mWd8rxUs5g+qSLHEp5Aa2PzhsSTcQ
         WBrB5EazEXGsBbrcu1jfqarkkEYFmqYtMxtDGd9fCF6V/Hi1NNfH1u7P8Z2F3UNhwN
         LadJI/zG5NOkJMHIP11sU8ni9PoZYXykSwUIMYbPdWRb+XjF2aRvsSkOUSLVrRcZTG
         8uhYQtiPsl+PQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/5] iio: accel: mma9551/mma9553: Drop explicit ACPI match support
Date:   Sun, 23 May 2021 17:23:11 +0100
Message-Id: <20210523162315.1965869-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210523162315.1965869-1-jic23@kernel.org>
References: <20210523162315.1965869-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The IDs look highly suspicious as they are just the part numbers in
capitals, so lets drop these if no one screams.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/accel/mma9551.c | 21 ---------------------
 drivers/iio/accel/mma9553.c | 21 ---------------------
 2 files changed, 42 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 4c359fb05480..2b74f67536a3 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -435,17 +435,6 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static const char *mma9551_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 static int mma9551_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -464,8 +453,6 @@ static int mma9551_probe(struct i2c_client *client,
 
 	if (id)
 		name = id->name;
-	else if (ACPI_HANDLE(&client->dev))
-		name = mma9551_match_acpi_device(&client->dev);
 
 	ret = mma9551_init(data);
 	if (ret < 0)
@@ -591,13 +578,6 @@ static const struct dev_pm_ops mma9551_pm_ops = {
 			   mma9551_runtime_resume, NULL)
 };
 
-static const struct acpi_device_id mma9551_acpi_match[] = {
-	{"MMA9551", 0},
-	{},
-};
-
-MODULE_DEVICE_TABLE(acpi, mma9551_acpi_match);
-
 static const struct i2c_device_id mma9551_id[] = {
 	{"mma9551", 0},
 	{}
@@ -608,7 +588,6 @@ MODULE_DEVICE_TABLE(i2c, mma9551_id);
 static struct i2c_driver mma9551_driver = {
 	.driver = {
 		   .name = MMA9551_DRV_NAME,
-		   .acpi_match_table = ACPI_PTR(mma9551_acpi_match),
 		   .pm = &mma9551_pm_ops,
 		   },
 	.probe = mma9551_probe,
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index ba3ecb3b57dc..32c9a79ebfec 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1062,17 +1062,6 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static const char *mma9553_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 static int mma9553_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1091,8 +1080,6 @@ static int mma9553_probe(struct i2c_client *client,
 
 	if (id)
 		name = id->name;
-	else if (ACPI_HANDLE(&client->dev))
-		name = mma9553_match_acpi_device(&client->dev);
 	else
 		return -ENOSYS;
 
@@ -1230,13 +1217,6 @@ static const struct dev_pm_ops mma9553_pm_ops = {
 			   mma9553_runtime_resume, NULL)
 };
 
-static const struct acpi_device_id mma9553_acpi_match[] = {
-	{"MMA9553", 0},
-	{},
-};
-
-MODULE_DEVICE_TABLE(acpi, mma9553_acpi_match);
-
 static const struct i2c_device_id mma9553_id[] = {
 	{"mma9553", 0},
 	{},
@@ -1247,7 +1227,6 @@ MODULE_DEVICE_TABLE(i2c, mma9553_id);
 static struct i2c_driver mma9553_driver = {
 	.driver = {
 		   .name = MMA9553_DRV_NAME,
-		   .acpi_match_table = ACPI_PTR(mma9553_acpi_match),
 		   .pm = &mma9553_pm_ops,
 		   },
 	.probe = mma9553_probe,
-- 
2.31.1

