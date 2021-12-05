Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DB468D20
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 20:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbhLEUBZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:01:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34668 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbhLEUBZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:01:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0DEDB80ED8
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 19:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB62C341C5;
        Sun,  5 Dec 2021 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638734275;
        bh=/NU6UZJGh5DWLI5CxwfZjrmnG9dR9wCd1kjKxL0C8Pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GO7RjegnzHXP/1q13KrrHfbO8PRonhh8Jy0XfsacUy1lHoiETTJtCzjEAopeHag8d
         kipA3sJorNhzSghhGh2GUiNwlcfNhXJ4jY0+Fo9FBf/XCSQBo1K8wqjzp9y40fV1/K
         Eh/y/kucqKFDIsit7w+x2/6hBL0KsyLzw0yTLiITKrJ/EssGB5t4ZaEvO7vLjW++N0
         5DlEzjejYMFhwbfztimUImuJS0pM1zY7WJs0fPHAICvYgc7qanjkTXOxFQk7fr4vqg
         nR+YM5GXk/yB6VosXcU9EGryNWopqjIgHVlXdh5zNWv6AXa3tNLnZV/R2PUFko0EYT
         9RMtfpG2LRJYw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 4/5] iio: accel: mma9551: Use devm managed functions to tidy up probe()
Date:   Sun,  5 Dec 2021 20:02:49 +0000
Message-Id: <20211205200250.2840902-5-jic23@kernel.org>
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
 drivers/iio/accel/mma9551.c | 71 ++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 537a7a04654a..a00a7e067883 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -389,6 +389,15 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void mma9551_disable_cb(void *_data)
+{
+	struct mma9551_data *data = _data;
+
+	mutex_lock(&data->mutex);
+	mma9551_set_device_state(data->client, false);
+	mutex_unlock(&data->mutex);
+}
+
 static int mma9551_init(struct mma9551_data *data)
 {
 	int ret;
@@ -397,7 +406,12 @@ static int mma9551_init(struct mma9551_data *data)
 	if (ret)
 		return ret;
 
-	return mma9551_set_device_state(data->client, true);
+	ret = mma9551_set_device_state(data->client, true);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&data->client->dev, mma9551_disable_cb,
+					data);
 }
 
 static int mma9551_irq_probe(struct iio_dev *indio_dev)
@@ -425,6 +439,16 @@ static int mma9551_irq_probe(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static void mma9551_rpm_susp(void *d)
+{
+	pm_runtime_set_suspended(d);
+}
+
+static void mma9551_rpm_disable(void *d)
+{
+	pm_runtime_disable(d);
+}
+
 static int mma9551_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -458,46 +482,28 @@ static int mma9551_probe(struct i2c_client *client,
 
 	ret = mma9551_irq_probe(indio_dev);
 	if (ret < 0)
-		goto out_poweroff;
+		return ret;
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		goto out_poweroff;
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev, mma9551_rpm_susp,
+				       &client->dev);
+	if (ret)
+		return ret;
 
 	pm_runtime_enable(&client->dev);
+	ret = devm_add_action_or_reset(&client->dev, mma9551_rpm_disable,
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
-	return 0;
-
-out_poweroff:
-	mma9551_set_device_state(client, false);
-
-	return ret;
-}
-
-static int mma9551_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct mma9551_data *data = iio_priv(indio_dev);
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
 
 static __maybe_unused int mma9551_runtime_suspend(struct device *dev)
@@ -552,7 +558,6 @@ static struct i2c_driver mma9551_driver = {
 		   .pm = &mma9551_pm_ops,
 		   },
 	.probe = mma9551_probe,
-	.remove = mma9551_remove,
 	.id_table = mma9551_id,
 };
 
-- 
2.34.1

