Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33526377663
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhEILiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhEILiW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B74C6613D6;
        Sun,  9 May 2021 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560239;
        bh=NWbDf8vvr8Gm+S0uBrLWZ+h++EgCVr/4Rs9Pm18Mf24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UeVNuIqgQWIfqVcNEMmBXCZL83/697pN2st1sIYGCqcH01MhpEIztRQ3JwokWKyVk
         NdCwJ37vp5CbXCEzyPh9Q8IU5BCNsAoDmzBmRVRAHzd45HRZYCWQSyO/4Dmh/c5jIg
         8j/gsNlMkS/o1rLHWsobU0a4Z03NsSzBRy3xQdtCPCpcBW8iKmDJeA224KYNq94VU4
         mU5e03JgObG4ZusUIw/R9CcKl/An6lP/WW5YJhS5Bo6EWreanx625MRs2w1Z8Hdoin
         gWqPGSlhN03CIsyqjsjBNyG2O0xc4DKCmGYKQ8Q8x04oPfoOFuz3nH1VfZskklElwI
         xR4OamxDGQTJw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/28] iio: imu: mpu6050: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:39 +0100
Message-Id: <20210509113354.660190-14-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found using coccicheck script under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

pm_runtime_resume_and_get() returns <= 0 only so simplify related checks
to bring this more inline with nearby calls.

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 18 ++++++------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 ++----
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 6244a07048df..06b9c84f6bfb 100644
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

