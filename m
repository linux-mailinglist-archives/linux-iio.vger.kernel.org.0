Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591B637765C
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhEILiG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhEILiG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D65A46128C;
        Sun,  9 May 2021 11:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560223;
        bh=COlNwdsy8cN95NksVrFjzekcFOqH+PQtUQxdo+BsKOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8W0mwfEilUglq7rYNhvankmA1RctnW131NWbTTNiRhUVJXLuGLebRhRWYpkAFQOw
         V+5HMq287fpC0CKfjhfdTeixsm6YqJIPrPy0vhTeMRV8g6z6UeP+T0CbIFGyd3mSI8
         FFVcX/6EmL7vaV8RL3yiiXdtq74pGNak07KQ5eI30G2W62iuCUxg9W41OJfA4JbGxY
         7P2sUlaJ0gmKmje4UdiRoAg7Xyw4SCLxUOlVsJNuWxmW8uOZjMYbCwpJWqEtPXe6CC
         3uc9wWV24uRONobzXOYiTH+DoElI/PmlrqItWxdMVpKcuKWcC7f8TfbDMlV5oxYx+m
         +GDtLED/S0GhA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/28] iio: accel: mma9551/3: Balance untime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:32 +0100
Message-Id: <20210509113354.660190-7-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Both these drivers call pm_runtime_put_no_idle() when the reference
count should already be zero as there is no matching get()

Whilst here use pm_runtime_resume_and_get() rather than open coding.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma9551.c      | 1 -
 drivers/iio/accel/mma9551_core.c | 4 +---
 drivers/iio/accel/mma9553.c      | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 08a2303cc9df..4c359fb05480 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -515,7 +515,6 @@ static int mma9551_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 
 	mutex_lock(&data->mutex);
 	mma9551_set_device_state(data->client, false);
diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 666e7a04a7d7..fbf2e2c45678 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -664,7 +664,7 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
 	int ret;
 
 	if (on)
-		ret = pm_runtime_get_sync(&client->dev);
+		ret = pm_runtime_resume_and_get(&client->dev);
 	else {
 		pm_runtime_mark_last_busy(&client->dev);
 		ret = pm_runtime_put_autosuspend(&client->dev);
@@ -673,8 +673,6 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"failed to change power state to %d\n", on);
-		if (on)
-			pm_runtime_put_noidle(&client->dev);
 
 		return ret;
 	}
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index c15908faa381..ba3ecb3b57dc 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1154,7 +1154,6 @@ static int mma9553_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 
 	mutex_lock(&data->mutex);
 	mma9551_set_device_state(data->client, false);
-- 
2.31.1

