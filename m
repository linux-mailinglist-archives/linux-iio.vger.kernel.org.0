Return-Path: <linux-iio+bounces-17708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F492A7CF2D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C39016C05F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29162190678;
	Sun,  6 Apr 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiZdYpqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC401487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960073; cv=none; b=UMZFBLhUc4kjZmKX1tFJydJ4bjl0OXYZufO1r6wbYbj0sU/bASmwqViAgkjeZ4NL0eXZB2sVqUrM/NN9R2fdIDZ8EJWAgoiwT/M8IeLXVNb8mfHAb4u9o2z692GoLjwGk5XlZF6Kr7uXU66wLFelpbVufRJP+Zfu4Yo8yOR3n50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960073; c=relaxed/simple;
	bh=yKTrtyJtsORhzbs/Q/E6Ysgguin49g4DjTe16XauQk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OupQKajA+xGiFyziiT5YnYryK8MvmVDxbEVHJ0e1of6yJ2TLyvfIWuYAkVo7T58UjiJtw74zZNMXGh8iGu//ETRnDX9rHMjfR1jTUI9oOqyevVl7BjkiyRsxLd7jsCNCYjCHfY6FDs4k7o2aH1zBxWCFsjPHUdJ9BkR6T5y4k1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiZdYpqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8749CC4CEE7;
	Sun,  6 Apr 2025 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960073;
	bh=yKTrtyJtsORhzbs/Q/E6Ysgguin49g4DjTe16XauQk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiZdYpqFDCHVjteI/IMZ0m5xhK+kmG14OC4Qwbx2LsGL0r8DVPIqIze3FMlrln8j4
	 kvwlhwx7wgI9Mg/4CvJqtAPCr1ewKioDp8zvKfT9CjAF3h+F786OYVqb6414++qgIV
	 BorVIOdjn+9WXBD7vYy44uMGFGJRMgy1hTHpIX8mXFg5hjSQf9JrQLvVJMRGuXix4E
	 TH8kTWkrIarfsCordR+J0k0YjKOlaS2JODwWhko8PeWpwr+cF7kdq+NycMVggYkdmJ
	 Ccq/EpLHFm3Ohq4TvEAe/HFR2wYpSqUwAawJz5L8a4DGuMUEBMeUVOGym3Hw2y+3aX
	 YsikdyxTVnFwQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 20/20] iio: magnetometer: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  6 Apr 2025 18:20:01 +0100
Message-ID: <20250406172001.2167607-21-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
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
index 44d8428a69b0..6b784af7d779 100644
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
2.49.0


