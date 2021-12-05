Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B505E468D1C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 20:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbhLEUBT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLEUBT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:01:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E87C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 11:57:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44E29B80EDE
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 19:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BF0C341C4;
        Sun,  5 Dec 2021 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638734269;
        bh=8NUP/DVxUTf7zyc8zO9+ITqA5GpqvJM5iMm1N7poSoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdzPtX8F37aeMokzpyAKGNToYg2XrSItt/0BbP2GNkVIjMEpf35EFGn0sC3pqA1oN
         oLaSEQomW1iJvfPxHJ7hZqm42qALoBjKSUwXQ78VnbnImIL4N0L1sZIyx4oQIq56+W
         cY8sGwvYtDYHqDPMHLyAS1fYyc9HqvQ3SBb4g+WIM5TlpwN2hEzL3jx3gPyseSZKVN
         RfbTKzc4EY5Eg5jbIhMuEUCopSH1bXhiBHfguYxtAxQoBp5usQM4XPr6ee3eTvSj7S
         ihja1iRR18eRqGOqVSEd3sCQ3SQl1zZ36xZiM2qPV3h4p9r8Gc19iu2eEc3kjpkOTn
         /LfXwIFSOl3mw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/5] iio: accel: mma9551/mma9553: Drop explicit ACPI match support
Date:   Sun,  5 Dec 2021 20:02:46 +0000
Message-Id: <20211205200250.2840902-2-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205200250.2840902-1-jic23@kernel.org>
References: <20211205200250.2840902-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The IDs look highly suspicious as they are just the part numbers in
capitals, so lets drop these if no one screams.

Note:
- MMA is registered PNP ID for Micromedia AG (not a part of Freescale)
- Googling doesn't show any results for such ACPI _HID to be present
  in the wild

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
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
index 0570ab1cc064..97704c681098 100644
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
2.34.1

