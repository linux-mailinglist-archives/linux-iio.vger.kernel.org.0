Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D774C37766E
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhEILir (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhEILir (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E65B1613D6;
        Sun,  9 May 2021 11:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560264;
        bh=G86oKthfBTbE6RFM+J9h/HyBpkVw/lQIkO42NvpTY2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMwb8KTwV9KJ6keiqQjvANmKpD37j3ufn8cvkp8gNo2jhmlyF1EFrU6kRh/3utnl6
         lR78MW41TF6nZ7j743OnXBBIjDEbmgjEI+KC2I+kH5hwR9SBPtiu2ODVA+DOqs+Gs9
         nimpXiqL6e+vC24XT3OrYLBENEkYBGREga4LLFMfdFHEBTXShFM5D8pJEyDGNSWUQL
         UfgAMA8FHVNpMx93P/IBXDQNm1vNsU1n6/5S4b3OjbkYkQMy0NR0/nPd/xNy40sSP1
         WeAFIJ0OWQo3l3XS3jVWk9jNVee5fj0UTCj+METu1hnfPZscEfqJ232W1r3SMjeRlK
         7mELja68MH7Vw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 24/28] iio: temp: mlx90614: Handle failure in pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:50 +0100
Message-Id: <20210509113354.660190-25-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Converts from using pm_runtime_get_sync() with no error handling over
to pm_runtime_resume_and_get() which will ensure we don't end up
holding a reference.  Ensure this error return is then handled at
calls to mlx90614_power_get(). These are all direct returns.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/mlx90614.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index ef0fec94d269..afcb10ea7c44 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -176,11 +176,14 @@ static inline s32 mlx90614_iir_search(const struct i2c_client *client,
 static int mlx90614_power_get(struct mlx90614_data *data, bool startup)
 {
 	unsigned long now;
+	int ret;
 
 	if (!data->wakeup_gpio)
 		return 0;
 
-	pm_runtime_get_sync(&data->client->dev);
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret < 0)
+		return ret;
 
 	if (startup) {
 		now = jiffies;
@@ -267,7 +270,10 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		*val = MLX90614_CONST_SCALE;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
-		mlx90614_power_get(data, false);
+		ret = mlx90614_power_get(data, false);
+		if (ret < 0)
+			return ret;
+
 		mutex_lock(&data->lock);
 		ret = i2c_smbus_read_word_data(data->client,
 					       MLX90614_EMISSIVITY);
@@ -287,7 +293,10 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
 							     FIR = 1024 */
-		mlx90614_power_get(data, false);
+		ret = mlx90614_power_get(data, false);
+		if (ret < 0)
+			return ret;
+
 		mutex_lock(&data->lock);
 		ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
 		mutex_unlock(&data->lock);
@@ -319,7 +328,10 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 		val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
 			val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
 
-		mlx90614_power_get(data, false);
+		ret = mlx90614_power_get(data, false);
+		if (ret < 0)
+			return ret;
+
 		mutex_lock(&data->lock);
 		ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY,
 					  val);
@@ -331,7 +343,10 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 		if (val < 0 || val2 < 0)
 			return -EINVAL;
 
-		mlx90614_power_get(data, false);
+		ret = mlx90614_power_get(data, false);
+		if (ret < 0)
+			return ret;
+
 		mutex_lock(&data->lock);
 		ret = mlx90614_iir_search(data->client,
 					  val * 100 + val2 / 10000);
-- 
2.31.1

