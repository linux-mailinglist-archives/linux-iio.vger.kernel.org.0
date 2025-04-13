Return-Path: <linux-iio+bounces-18064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D163A8719C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BF216EB9D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E51A08AB;
	Sun, 13 Apr 2025 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCnhGAgd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51931191F91
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540549; cv=none; b=slIlQPeMNwPtLQ9JUc4WyBfkbl72o7CJzZ5+J4igLcK1JfQYUzERzrMaCS331z2fjaLSTbDVTfVJb5jm14GsLqNL1nlt/YMeOMBld2Plrt9zKLoogkge1YUvde43ihujEHyXpTfY15dBtIbitZIx+oul0W4Vs3elCaRyeZjvQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540549; c=relaxed/simple;
	bh=GlsI+wkq7cKwF7XxxzJyw0aNOV4TLBHaoiAvYb/qAvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAa8A/OLxIu1n/al6p3PPs66ahlVV5FgUhdhkrUw+ehrS+WCbI6RXFJrb4EUpjsSWojygJ1cvZIylKJlp6f+6BhGYdKdqY6T7dr1pO2NVc4Kt5VzfuQcysh/4Lo3A7f01eP+JbjM8qNEDrL+pVdwlj1S06u1REYTa3nFs427lMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCnhGAgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776A8C4CEDD;
	Sun, 13 Apr 2025 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540548;
	bh=GlsI+wkq7cKwF7XxxzJyw0aNOV4TLBHaoiAvYb/qAvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCnhGAgdkMeK/8YebISm1510vlU6okmhf7S7baWumpjApGhVBE/izH6tD4YkBsZa3
	 /1yZmtMJr1PhruXtRX/MLPJGKcuD+V7JwfzVmokOeHp46tMLTRt9tZijrzZzIkYqvQ
	 PrOEjhsEl7ousVDnl1kLUhfE0nAs4zpyWx1ckHTt8rsbgYES8qkO49PwOW0sm8Ch5M
	 Q7zXszP7omWUVgNt8SPcUkRhQCzScakeemjMgcY+nJUEzMx7XP06GBGNmh1ndiT+O/
	 69mv436HzptyJPwb1GVMqgz6xmgIGWAnkYnG+lXDZFolKnfKH/JuvWFTvHvWyTlwnJ
	 AOujNtM767B3Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 20/20] iio: magnetometer: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun, 13 Apr 2025 11:34:43 +0100
Message-ID: <20250413103443.2420727-21-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This new function allows us to perform debug checks in the helper to ensure
that the overrun does not occur.  Use it in all the simple cases where
either a static buffer or a structure is used in the drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/af8133j.c       | 3 ++-
 drivers/iio/magnetometer/ak8974.c        | 4 ++--
 drivers/iio/magnetometer/ak8975.c        | 4 ++--
 drivers/iio/magnetometer/als31300.c      | 3 +--
 drivers/iio/magnetometer/bmc150_magn.c   | 4 ++--
 drivers/iio/magnetometer/hmc5843.h       | 2 +-
 drivers/iio/magnetometer/hmc5843_core.c  | 4 ++--
 drivers/iio/magnetometer/mag3110.c       | 4 ++--
 drivers/iio/magnetometer/rm3100-core.c   | 4 ++--
 drivers/iio/magnetometer/yamaha-yas530.c | 4 ++--
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
index c1fc339e85b4..192ba2da94e2 100644
--- a/drivers/iio/magnetometer/af8133j.c
+++ b/drivers/iio/magnetometer/af8133j.c
@@ -370,7 +370,8 @@ static irqreturn_t af8133j_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out_done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &sample, timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &sample, sizeof(sample),
+				    timestamp);
 
 out_done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 7cc4690b5cdd..f9e92e3cb385 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -673,8 +673,8 @@ static void ak8974_fill_buffer(struct iio_dev *indio_dev)
 		goto out_unlock;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &ak8974->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &ak8974->scan, sizeof(ak8974->scan),
+				    iio_get_time_ns(indio_dev));
 
  out_unlock:
 	mutex_unlock(&ak8974->lock);
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index f8393576f463..a1e92b2abffd 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -882,8 +882,8 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 	data->scan.channels[1] = clamp_t(s16, le16_to_cpu(fval[1]), -def->range, def->range);
 	data->scan.channels[2] = clamp_t(s16, le16_to_cpu(fval[2]), -def->range, def->range);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 
 	return;
 
diff --git a/drivers/iio/magnetometer/als31300.c b/drivers/iio/magnetometer/als31300.c
index 85eb1428a849..f72af829715f 100644
--- a/drivers/iio/magnetometer/als31300.c
+++ b/drivers/iio/magnetometer/als31300.c
@@ -245,8 +245,7 @@ static irqreturn_t als31300_trigger_handler(int irq, void *p)
 	scan.channels[0] = x;
 	scan.channels[1] = y;
 	scan.channels[2] = z;
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
 
 trigger_out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 88bb673e40d8..f9c51ceae011 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -678,8 +678,8 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
 
 err:
 	mutex_unlock(&data->mutex);
diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index ffd669b1ee7c..7a3faf7ffed4 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -34,7 +34,7 @@ enum hmc5843_ids {
  * @regmap:		hardware access register maps
  * @variant:		describe chip variants
  * @scan:		buffer to pack data for passing to
- *			iio_push_to_buffers_with_timestamp()
+ *			iio_push_to_buffers_with_ts()
  */
 struct hmc5843_data {
 	struct device *dev;
diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 2fc84310e2cc..fc16ebd314f7 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -452,8 +452,8 @@ static irqreturn_t hmc5843_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 92d4511ed372..ff09250a06e7 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -404,8 +404,8 @@ static irqreturn_t mag3110_trigger_handler(int irq, void *p)
 		data->scan.temperature = ret;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index e5162ee64e01..2b2884425746 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -515,8 +515,8 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 	 * Always using the same buffer so that we wouldn't need to set the
 	 * paddings to 0 in case of leaking any data.
 	 */
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, data->buffer, sizeof(data->buffer),
+				    pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 46bc64e676b1..340607111d9a 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -674,8 +674,8 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
 	yas5xx->scan.channels[1] = x;
 	yas5xx->scan.channels[2] = y;
 	yas5xx->scan.channels[3] = z;
-	iio_push_to_buffers_with_timestamp(indio_dev, &yas5xx->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &yas5xx->scan, sizeof(yas5xx->scan),
+				    iio_get_time_ns(indio_dev));
 }
 
 static irqreturn_t yas5xx_handle_trigger(int irq, void *p)
-- 
2.49.0


