Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6DA377662
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhEILiU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhEILiU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 609A6613E5;
        Sun,  9 May 2021 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560237;
        bh=Bt6iH9LmLdkBHOSApLIgZ9nj8aZXC9374Cw5CiyHiNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOZz+rFNcai7AwQ+ZFl1CPbUFFafkaDK8Gpy5H7yywRC9t4hreRj76o9FXTJWATPh
         3Cesd5fHN0czUgf0eMC1tMIoiZGC+RY3ktil4O3i8NagLQcac1aTmq22zpVo4DsWyo
         TKn2XbwAcQVXK9Hh7nKApJ2HDnDpjC85YT2yWVKot0+D4RlUDBvslo5qzhr3nQ2BWF
         tOlytWkNpBPuzQJdvVuOxqLhS0C7LpKcu5+UPpt8i17Yv3ZTNnZaJn2fgg0rTN+aQY
         BiMsdTlPA5kvyMEkLFqFTxYs8dkbG4sUoA6GLirZYcVEtXDbjqUWIlIJ+LixPpyTCA
         Tp0zzF9kGXKng==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 12/28] iio: accel: bmi088: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:38 +0100
Message-Id: <20210509113354.660190-13-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The call to pm_runtime_put_noidle() in remove() is not balanced by a get so
drop it.

Using pm_runtime_resume_and_get() allows for simple introduction of
error handling to allow for runtime resume failing.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/accel/bmi088-accel-core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 61aaaf48c040..a06dae5c971d 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -285,11 +285,17 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_TEMP:
-			pm_runtime_get_sync(dev);
+			ret = pm_runtime_resume_and_get(dev);
+			if (ret)
+				return ret;
+
 			ret = bmi088_accel_get_temp(data, val);
 			goto out_read_raw_pm_put;
 		case IIO_ACCEL:
-			pm_runtime_get_sync(dev);
+			ret = pm_runtime_resume_and_get(dev);
+			if (ret)
+				return ret;
+
 			ret = iio_device_claim_direct_mode(indio_dev);
 			if (ret)
 				goto out_read_raw_pm_put;
@@ -319,7 +325,10 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 			*val = BMI088_ACCEL_TEMP_UNIT;
 			return IIO_VAL_INT;
 		case IIO_ACCEL:
-			pm_runtime_get_sync(dev);
+			ret = pm_runtime_resume_and_get(dev);
+			if (ret)
+				return ret;
+
 			ret = regmap_read(data->regmap,
 					  BMI088_ACCEL_REG_ACC_RANGE, val);
 			if (ret)
@@ -334,7 +343,10 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		pm_runtime_get_sync(dev);
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			return ret;
+
 		ret = bmi088_accel_get_sample_freq(data, val, val2);
 		goto out_read_raw_pm_put;
 	default:
@@ -376,7 +388,10 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		pm_runtime_get_sync(dev);
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			return ret;
+
 		ret = bmi088_accel_set_sample_freq(data, val);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
@@ -530,7 +545,6 @@ int bmi088_accel_core_remove(struct device *dev)
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_put_noidle(dev);
 	bmi088_accel_power_down(data);
 
 	return 0;
-- 
2.31.1

