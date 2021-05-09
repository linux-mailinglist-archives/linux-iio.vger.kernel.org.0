Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E538377659
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhEILiA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhEILh7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:37:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3700B613F0;
        Sun,  9 May 2021 11:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560216;
        bh=JoSRT0A6ceDRVtGT0yRgUMKUXJujQvpSDyvqSXuKFhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1tx/WecwjmxlJtrAcT/tLT1Bb2hXYbov1+lluXWgvCtotySITRPah1kWKKrYTMUk
         iLrmtwv6CwAuklndLAmJ0JOVvwycMipUYsAr360tJjnHfqsbOx5gRY7okbdrURUpnw
         QskPLr1lM84cIJPu40Wx3n65C0Y8ncEsouT9ek2cWPWrS3HtkvHrOe4XxR8HsSH5a4
         uP+YwuqkRjRwVLRLhN+Sp81LDTpcXO0tZbOtJjedma0CIh0H4hzVrA7fbmxfepgXvv
         DZtMHTqdWZz7rmWiKnvzsOpHdRSDXFGl1ro7zhhXjGicX+gf8vVJWH3AXlCkV4rOrj
         xHIldUqzAhogA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Brian Masney <masneyb@onstation.org>
Subject: [PATCH 03/28] iio: light: tsl2583: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:29 +0100
Message-Id: <20210509113354.660190-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Error paths in read_raw() and write_raw() callbacks failed to perform and
type of runtime pm put().  Remove called pm_runtime_put_noidle()
but there is no equivalent get (this is safe because the reference
count is protected against going below zero, but it is misleading.

Whilst here use pm_runtime_resume_and_get() to replace boilerplate.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/tsl2583.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 0f787bfc88fc..1f4ad4047a86 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -636,9 +636,7 @@ static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
 	int ret;
 
 	if (on) {
-		ret = pm_runtime_get_sync(&chip->client->dev);
-		if (ret < 0)
-			pm_runtime_put_noidle(&chip->client->dev);
+		ret = pm_runtime_resume_and_get(&chip->client->dev);
 	} else {
 		pm_runtime_mark_last_busy(&chip->client->dev);
 		ret = pm_runtime_put_autosuspend(&chip->client->dev);
@@ -721,8 +719,10 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 read_done:
 	mutex_unlock(&chip->als_mutex);
 
-	if (ret < 0)
+	if (ret < 0) {
+		tsl2583_set_pm_runtime_busy(chip, false);
 		return ret;
+	}
 
 	/*
 	 * Preserve the ret variable if the call to
@@ -783,8 +783,10 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->als_mutex);
 
-	if (ret < 0)
+	if (ret < 0) {
+		tsl2583_set_pm_runtime_busy(chip, false);
 		return ret;
+	}
 
 	ret = tsl2583_set_pm_runtime_busy(chip, false);
 	if (ret < 0)
@@ -872,7 +874,6 @@ static int tsl2583_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 
 	return tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_OFF);
 }
-- 
2.31.1

