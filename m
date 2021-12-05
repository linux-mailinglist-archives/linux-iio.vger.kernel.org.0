Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E731D468D1D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 20:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhLEUBV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:01:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34628 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLEUBU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:01:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86F93B80EE0
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 19:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79F4C341C5;
        Sun,  5 Dec 2021 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638734271;
        bh=HHQctzYHOYHfJmCh7EqeCuhjsHLhns4gKEtadyitDI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uy0M7oetjxW4pNpVKdOIg1DHg4D+RYRmzRlH3kDstF4hGxfg30y6IQs8On2IXG4/4
         yRCiPWJvH1bYW1F35/C+UUTsnvdkbY5y6Xnzr245ckm8REEsvOWcACT/JBnrkAxLaU
         AZ3poaQeVUqsGEOHc96/jya7oC07E5DnSj7Anvwh5csmLCaj5LvKCPMmyHSiuws2AL
         Ten6yS4J4oMAlVnexr3WCrOw13zy4gdwfsb9X7JUPrmvmjxOz16PZuGprvh+K5OAsf
         RgQn67+4FOzIVzVjEP7PaQWcVbeYPrjg+BGinQhk9NC/kac8fZQY02i31IC0fEDI6+
         1ErzRNf9tV0MQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 2/5] iio: accel: mma9551/mma9553: Simplify pm logic
Date:   Sun,  5 Dec 2021 20:02:47 +0000
Message-Id: <20211205200250.2840902-3-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205200250.2840902-1-jic23@kernel.org>
References: <20211205200250.2840902-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I can't see why we shouldn't sleep in the system resume path to allow
the device firmware to fully wakeup.  Having done that, the runtime
system functions are identical (down to an error print) so use
pm_runtime_force_suspend() and pm_runtime_force_resume() to reduce
repitition.

General preference in IIO is now to mark these functions __maybe_unused
instead of using ifdefs as it is easy to get them wrong.
Here they appear correct, but provide a less than desirable example
to copy into other drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/mma9551.c | 37 ++++--------------------------------
 drivers/iio/accel/mma9553.c | 38 ++++---------------------------------
 2 files changed, 8 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 2b74f67536a3..1b4a8b27f14a 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -510,8 +510,7 @@ static int mma9551_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mma9551_runtime_suspend(struct device *dev)
+static __maybe_unused int mma9551_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9551_data *data = iio_priv(indio_dev);
@@ -522,13 +521,13 @@ static int mma9551_runtime_suspend(struct device *dev)
 	mutex_unlock(&data->mutex);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "powering off device failed\n");
-		return -EAGAIN;
+		return ret;
 	}
 
 	return 0;
 }
 
-static int mma9551_runtime_resume(struct device *dev)
+static __maybe_unused int mma9551_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9551_data *data = iio_priv(indio_dev);
@@ -542,38 +541,10 @@ static int mma9551_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
-
-#ifdef CONFIG_PM_SLEEP
-static int mma9551_suspend(struct device *dev)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct mma9551_data *data = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret = mma9551_set_device_state(data->client, false);
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-
-static int mma9551_resume(struct device *dev)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct mma9551_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = mma9551_set_device_state(data->client, true);
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-#endif
 
 static const struct dev_pm_ops mma9551_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mma9551_suspend, mma9551_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(mma9551_runtime_suspend,
 			   mma9551_runtime_resume, NULL)
 };
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 97704c681098..c24384089714 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1149,8 +1149,7 @@ static int mma9553_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mma9553_runtime_suspend(struct device *dev)
+static __maybe_unused int mma9553_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9553_data *data = iio_priv(indio_dev);
@@ -1161,13 +1160,13 @@ static int mma9553_runtime_suspend(struct device *dev)
 	mutex_unlock(&data->mutex);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "powering off device failed\n");
-		return -EAGAIN;
+		return ret;
 	}
 
 	return 0;
 }
 
-static int mma9553_runtime_resume(struct device *dev)
+static __maybe_unused int mma9553_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mma9553_data *data = iio_priv(indio_dev);
@@ -1181,38 +1180,9 @@ static int mma9553_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
-
-#ifdef CONFIG_PM_SLEEP
-static int mma9553_suspend(struct device *dev)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct mma9553_data *data = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret = mma9551_set_device_state(data->client, false);
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-
-static int mma9553_resume(struct device *dev)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct mma9553_data *data = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret = mma9551_set_device_state(data->client, true);
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-#endif
 
 static const struct dev_pm_ops mma9553_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mma9553_suspend, mma9553_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(mma9553_runtime_suspend,
 			   mma9553_runtime_resume, NULL)
 };
-- 
2.34.1

