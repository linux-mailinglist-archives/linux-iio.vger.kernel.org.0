Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3746038DBEA
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 18:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhEWQZg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 12:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231821AbhEWQZg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 May 2021 12:25:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAC666117A;
        Sun, 23 May 2021 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621787049;
        bh=Z0P4r1dCUgEDfsa4CtP560vDgjEiLt5/rkR+lk+HPYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NF/2GOUBFK8Mq86YxlR2m1l9iJeoaHEbUuBgPQhmS+QqJTF5HvvuIX2DZthlcEjpg
         T490Z+06r9jF90mO423skhGa5V7t/90k6cFexjTgL+TFAQwtl4cY/KgbC1ylMZ8vGb
         tkkt1YgsQX9YJYkQZGDhYw1SdvR9QVNCXAzs4SlwWQu8Oxd3suOuYKd5V1JWHtgsOr
         YHyomTUnpDm3hWdBQQIX6zhMYevEzao6jQ3nQ/vrk3/4AZ5D2NkPAEkoQJjc2a17CO
         GPNq3uzIkw8iE0om9yCtqTo2q03hN9t8+MZZouRe9OXLyIdrRD8Spov/qUMKDC6/x3
         +cbVGAhFg6cXg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/5] iio: accel: mma9553: Use devm managed functions to tidy up probe()
Date:   Sun, 23 May 2021 17:23:15 +0100
Message-Id: <20210523162315.1965869-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210523162315.1965869-1-jic23@kernel.org>
References: <20210523162315.1965869-1-jic23@kernel.org>
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
---
 drivers/iio/accel/mma9553.c | 70 ++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index dc2a3316c1a3..14a9d5fedc06 100644
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
2.31.1

