Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00AF381FC0
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhEPQXR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhEPQXP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:23:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EED6610CA;
        Sun, 16 May 2021 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621182120;
        bh=cjiaeV4CHYOMvMhEtpFe6vThP4kt6L9eT0GKs9Usf/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdpZsgCPwlJGdnN2A/bPF9WfCrnS3EGWzXo8LY0Yx+87CRlt/uFm5Fg7qRZgW6N8/
         fBSvRVJvEW2oZnwn2sa2DfwmmGLsbBb6yd3K5faOXWm3Y7L2dSSTHFy50t4u/+zvaQ
         ValRWZrBUt08WIcZHoHQZONlom78KsWu/fbGNsjUV4xoIm32VstWxYucrVQxQFCIq9
         rp7gAyldcJwNz/yhXT0notU8ef7RPBOXh/5wgF1LY+7ppaGun6qpdoCsHfQkJWuktW
         RuR3m3slW9gqmLYmSO5Su61enWOpkvFKhlWIssVIL2fxwMj78iV5DmBv6gkp5ov9vl
         OwfKdN3xZWxLg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 1/6] iio: imu: mpu6050: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun, 16 May 2021 17:20:58 +0100
Message-Id: <20210516162103.1332291-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516162103.1332291-1-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Remove an unblanced pm_runtime_put_sync_suspend() call
in inv_pu_pm_disable().  Not this call is not a bug, because the runtime
pm core will not allow the reference counter to go negative.  It is
however confusing and serves no purpose.

pm_runtime_resume_and_get() case found using coccicheck script under
review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

pm_runtime_resume_and_get() returns <= 0 only so simplify related checks
to bring this more inline with nearby calls.

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 19 ++++++-------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 ++----
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6244a07048df..4cae3765e327 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -570,11 +570,9 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
 	period_us = 1000000 / freq_hz;
 
-	result = pm_runtime_get_sync(pdev);
-	if (result < 0) {
-		pm_runtime_put_noidle(pdev);
+	result = pm_runtime_resume_and_get(pdev);
+	if (result)
 		return result;
-	}
 
 	switch (chan->type) {
 	case IIO_ANGL_VEL:
@@ -812,11 +810,9 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 		return result;
 
 	mutex_lock(&st->lock);
-	result = pm_runtime_get_sync(pdev);
-	if (result < 0) {
-		pm_runtime_put_noidle(pdev);
+	result = pm_runtime_resume_and_get(pdev);
+	if (result)
 		goto error_write_raw_unlock;
-	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -930,11 +926,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 		result = 0;
 		goto fifo_rate_fail_unlock;
 	}
-	result = pm_runtime_get_sync(pdev);
-	if (result < 0) {
-		pm_runtime_put_noidle(pdev);
+	result = pm_runtime_resume_and_get(pdev);
+	if (result)
 		goto fifo_rate_fail_unlock;
-	}
 
 	result = regmap_write(st->map, st->reg->sample_rate_div, d);
 	if (result)
@@ -1422,7 +1416,6 @@ static void inv_mpu_pm_disable(void *data)
 {
 	struct device *dev = data;
 
-	pm_runtime_put_sync_suspend(dev);
 	pm_runtime_disable(dev);
 }
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index e21ba778595a..2d0e8cdd4848 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -173,11 +173,9 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 
 	if (enable) {
 		scan = inv_scan_query(indio_dev);
-		result = pm_runtime_get_sync(pdev);
-		if (result < 0) {
-			pm_runtime_put_noidle(pdev);
+		result = pm_runtime_resume_and_get(pdev);
+		if (result)
 			return result;
-		}
 		/*
 		 * In case autosuspend didn't trigger, turn off first not
 		 * required sensors.
-- 
2.31.1

