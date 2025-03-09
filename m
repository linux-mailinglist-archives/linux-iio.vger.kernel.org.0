Return-Path: <linux-iio+bounces-16642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C8A5872D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6625F188C2B4
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8325206F15;
	Sun,  9 Mar 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr/OV4YH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792AA202C4C
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544537; cv=none; b=D2XRGDbmFfrBhs2iD7SCpHdUfL5BZT3dXNwxCzEb5fKdzbzRm3YpL39kWcrtVBkizp8jdxiIEpGCuZdIJKYyEGyxBw2NjdQyuLn1lIkowVSHF+xP1xtw1jrf8yU9PaAi8YJ6AmThBeGajwJ+uaMsRku1+v2NSyWsBEPetnmJWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544537; c=relaxed/simple;
	bh=KSE9cjrLMi/OJOEeOyOC9VIXoCStaGR8bJg9kr20Dqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXNfvqe8lzbwv227oSaoymOTlnv5DAFjQ+l5H3VrEPUvUK3YgRCJ3jcFkM9vtzExrX+RofdfnGsKQ1c6ux1onmM0Jgv1j9fXbSZf2rgTfzWYSq54ADlx2etAGEPMh9oBtXL4vioA+G7nLggIcsHR7ZDtxThng+jku2+5kkC0YgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr/OV4YH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC2DC4CEE3;
	Sun,  9 Mar 2025 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544536;
	bh=KSE9cjrLMi/OJOEeOyOC9VIXoCStaGR8bJg9kr20Dqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dr/OV4YHpd2h9CYEEJIs0zNAQwM1DgQS3HYMIq4EjX8Uw3WZg1UzUpwU8UXDVUDl0
	 WjlA7nt/z/5RN0I/ZdnvG40FBAJTL9aIpd6/ZLSNKynQcgps+i/qMkP5l3HTTZMPP0
	 V5kKs5xVb/nKLUrm61bgsU/A1riVsGBdUxiOgUOW215ZzMUVxHvJBB+8iZrv/JGDOM
	 EBqgpqEOjYI0n+Qjqx5KZnbmhLalVfnBjGjqD+GDULfAUXPZ/GXdtH5PPrRzt2nC07
	 OeYzdR7hJxeo9GpHp9OsKkg0cpAzg99ShDQSNjJR0mWJGswcxrGIlYwaOFmJXqdVoy
	 ThloLRfTk2qDQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 16/16] iio: magnetometer: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  9 Mar 2025 18:21:00 +0000
Message-ID: <20250309182100.1351128-17-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309182100.1351128-1-jic23@kernel.org>
References: <20250309182100.1351128-1-jic23@kernel.org>
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
 drivers/iio/magnetometer/ak8974.c        | 5 +++--
 drivers/iio/magnetometer/ak8975.c        | 4 ++--
 drivers/iio/magnetometer/als31300.c      | 4 ++--
 drivers/iio/magnetometer/bmc150_magn.c   | 4 ++--
 drivers/iio/magnetometer/hmc5843.h       | 2 +-
 drivers/iio/magnetometer/hmc5843_core.c  | 4 ++--
 drivers/iio/magnetometer/mag3110.c       | 4 ++--
 drivers/iio/magnetometer/rm3100-core.c   | 4 ++--
 drivers/iio/magnetometer/yamaha-yas530.c | 5 +++--
 10 files changed, 21 insertions(+), 18 deletions(-)

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
index 08975c60e325..4fba9f4ded28 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -673,8 +673,9 @@ static void ak8974_fill_buffer(struct iio_dev *indio_dev)
 		goto out_unlock;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &ak8974->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &ak8974->scan,
+				    sizeof(ak8974->scan),
+				    iio_get_time_ns(indio_dev));
 
  out_unlock:
 	mutex_unlock(&ak8974->lock);
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index ef1363126cc2..abe9f4fccf00 100644
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
index 87b60c4e81fa..d5db4c8343ce 100644
--- a/drivers/iio/magnetometer/als31300.c
+++ b/drivers/iio/magnetometer/als31300.c
@@ -245,8 +245,8 @@ static irqreturn_t als31300_trigger_handler(int irq, void *p)
 	scan.channels[0] = x;
 	scan.channels[1] = y;
 	scan.channels[2] = z;
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    pf->timestamp);
 
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
index e5162ee64e01..81da063fb38c 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -515,8 +515,8 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 	 * Always using the same buffer so that we wouldn't need to set the
 	 * paddings to 0 in case of leaking any data.
 	 */
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+				    sizeof(data->buffer), pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 28012b20c64f..6ff34b3b6a62 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -674,8 +674,9 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
 	yas5xx->scan.channels[1] = x;
 	yas5xx->scan.channels[2] = y;
 	yas5xx->scan.channels[3] = z;
-	iio_push_to_buffers_with_timestamp(indio_dev, &yas5xx->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &yas5xx->scan,
+				    sizeof(yas5xx->scan),
+				    iio_get_time_ns(indio_dev));
 }
 
 static irqreturn_t yas5xx_handle_trigger(int irq, void *p)
-- 
2.48.1


