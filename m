Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDCF468D21
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 20:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbhLEUBZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:01:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58246 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLEUBZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:01:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDAF26114C
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 19:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ECAC00446;
        Sun,  5 Dec 2021 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638734277;
        bh=HJ2qDXrCnFW236Tkw7i8hopQQpEehu5wYEx70lpM8Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeGby41FSg1o1j7L2Co9Eq2Hi3qmPya4rJKQjLvqe564CJGV4WljRuLWv9J40SEVG
         G3FsvdsfeIzoGsuaaXJuzxPiWhA7chJYTwucYu93beoJvjaFonMYPA5KpPcyG13SGC
         O1Y6OGJmxwWO5sXV9eySjfpfgoD0EnOX5yVOE5VkZ4ngGxrJoHOGpnau2kpGwZ82rO
         JNtYZ3rJ+2FvrAXHwhQg5RUZYBMz3eQcyNTPK4n55U+yZVQ33hxZ4F6uEzQWWAKZMO
         AxPYfbvlSa8cfxKhrQbbQqiIImMcb90aeyE5OTHkgtpNG5pa70Uz6e+JH46t7uNn5k
         c915YwMbhFYoA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 5/5] iio: accel: mma9553: Use devm managed functions to tidy up probe()
Date:   Sun,  5 Dec 2021 20:02:50 +0000
Message-Id: <20211205200250.2840902-6-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205200250.2840902-1-jic23@kernel.org>
References: <20211205200250.2840902-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The error handling in here left runtime pm enabled, and didn't do the
same steps as occurred in remove.  Moving over to fully devm_ managed
makes it harder to get this stuff wrong, so let's do that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/mma9553.c | 70 ++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index c24384089714..72b50495c842 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -375,6 +375,15 @@ static int mma9553_conf_gpio(struct mma9553_data *data)
 	return 0;
 }
 
+static void mma9553_disable_cb(void *_data)
+{
+	struct mma9553_data *data = _data;
+
+	mutex_lock(&data->mutex);
+	mma9551_set_device_state(data->client, false);
+	mutex_unlock(&data->mutex);
+}
+
 static int mma9553_init(struct mma9553_data *data)
 {
 	int ret;
@@ -430,7 +439,11 @@ static int mma9553_init(struct mma9553_data *data)
 		return ret;
 	}
 
-	return mma9551_set_device_state(data->client, true);
+	ret = mma9551_set_device_state(data->client, true);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&data->client->dev, mma9553_disable_cb, data);
 }
 
 static int mma9553_read_status_word(struct mma9553_data *data, u16 reg,
@@ -1062,6 +1075,16 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void mma9553_rpm_set_susp(void *d)
+{
+	pm_runtime_set_suspended(d);
+}
+
+static void mma9553_rpm_disable(void *d)
+{
+	pm_runtime_disable(d);
+}
+
 static int mma9553_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1105,48 +1128,30 @@ static int mma9553_probe(struct i2c_client *client,
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
 				client->irq);
-			goto out_poweroff;
+			return ret;
 		}
 	}
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		goto out_poweroff;
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev, mma9553_rpm_set_susp,
+				       &client->dev);
+	if (ret)
+		return ret;
 
 	pm_runtime_enable(&client->dev);
+	ret = devm_add_action_or_reset(&client->dev, mma9553_rpm_disable,
+				       &client->dev);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 MMA9551_AUTO_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
-		goto out_poweroff;
-	}
-
-	dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
-	return 0;
-
-out_poweroff:
-	mma9551_set_device_state(client, false);
-	return ret;
-}
-
-static int mma9553_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct mma9553_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
-	mutex_lock(&data->mutex);
-	mma9551_set_device_state(data->client, false);
-	mutex_unlock(&data->mutex);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static __maybe_unused int mma9553_runtime_suspend(struct device *dev)
@@ -1200,7 +1205,6 @@ static struct i2c_driver mma9553_driver = {
 		   .pm = &mma9553_pm_ops,
 		   },
 	.probe = mma9553_probe,
-	.remove = mma9553_remove,
 	.id_table = mma9553_id,
 };
 
-- 
2.34.1

