Return-Path: <linux-iio+bounces-16641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F32EA5872E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34381168238
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E1206F1F;
	Sun,  9 Mar 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1HPKCdV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79334202F9A
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544537; cv=none; b=J/2jdHPdQcH0LEXu/roRo3YqRSkD47l+umpmHCgHFywbAAHy7i89YzN165cISnkYGG9SOheyf8l6AMChNfO+pdy/6WDJbl4sA1Ki0JCqzPvXTeDsbFfkGiShxuaL7YaDf3UMcDHZqSXeCLulSjzeNgn0KTRlxH4zQAYTvktmFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544537; c=relaxed/simple;
	bh=5MU6SHmsNMtneQbiN07b7senk9egsocyu8qoVDSMi44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSkPoLmg7k8GZE9pu1QD9GGt/LvCCvZTodlzmYsXPAdqUgNX3st/chcFZzlwnNL4w+kRGT9uYynrTVImlbt4QnQrhXJbiO0ihoG03//3MC5Oh+k08CEczuy5bK69s0FdNnEAIYPpwS4Ta05kMztVZ2TL7FTl53TDUgqAYnfAHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1HPKCdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EF9C4CEE5;
	Sun,  9 Mar 2025 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544534;
	bh=5MU6SHmsNMtneQbiN07b7senk9egsocyu8qoVDSMi44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1HPKCdVx17hxXms9loE4/7ZPIe80orO5O87JXOBig0wSpyPbiq8vGkhr6mAS5XjR
	 5Knn6Gh4sZ5/EvUpfPiO2MjE9Pdd0JIFt3fdTjK1A1EfHBJdhqnF/kdTr78qMKjhqH
	 UObv97gLZrsj6Af9EHX+M3gbq9S13UlX3NVN5SZoZsPUfRu23Z/tD6IwVm0k72yr1E
	 Ael4ac/u6PZ9/lCWpOi5o+Umwc45dsalXRcosxo3ALHUoxNVU9RDd1CNj6bvAFK+yo
	 8kzju858BZRgg581jD+xd4oFnFT1QeoGdEB22FrsohsEyUl9zfX4wH5OIn2vlD006m
	 DcoxT0Y8vyV/A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/16] iio: pressure: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  9 Mar 2025 18:20:59 +0000
Message-ID: <20250309182100.1351128-16-jic23@kernel.org>
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
 drivers/iio/pressure/bmp280-core.c      | 25 +++++++++++++++----------
 drivers/iio/pressure/hid-sensor-press.c |  5 +++--
 drivers/iio/pressure/hsc030pa.c         |  4 ++--
 drivers/iio/pressure/mpl3115.c          |  4 ++--
 drivers/iio/pressure/rohm-bm1390.c      |  3 ++-
 drivers/iio/pressure/zpa2326.c          |  4 ++--
 6 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index d44ab65c94cb..c20cc4a98c9c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1142,8 +1142,9 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	chans[0] = comp_press;
 	chans[1] = comp_temp;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
+				    sizeof(data->sensor_data),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -1273,8 +1274,9 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	chans[1] = comp_temp;
 	chans[2] = comp_humidity;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
+				    sizeof(data->sensor_data),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -1936,8 +1938,9 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	chans[0] = comp_press;
 	chans[1] = comp_temp;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
+				    sizeof(data->sensor_data),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -2630,8 +2633,9 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 	/* Temperature calculations */
 	memcpy(&data->sensor_data[offset], &data->buf[0], 3);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
+				    sizeof(data->sensor_data),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -2969,8 +2973,9 @@ static irqreturn_t bmp180_trigger_handler(int irq, void *p)
 	chans[0] = comp_press;
 	chans[1] = comp_temp;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
+				    sizeof(data->sensor_data),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index f7273d30c5f0..a8561df9f666 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -176,8 +176,9 @@ static int press_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!press_state->timestamp)
 			press_state->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(
-			indio_dev, &press_state->scan, press_state->timestamp);
+		iio_push_to_buffers_with_ts(
+			indio_dev, &press_state->scan,
+			sizeof(press_state->scan), press_state->timestamp);
 	}
 
 	return 0;
diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
index 168245818cfe..2d00c0656259 100644
--- a/drivers/iio/pressure/hsc030pa.c
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -314,8 +314,8 @@ static irqreturn_t hsc_trigger_handler(int irq, void *private)
 	memcpy(&data->scan.chan[0], &data->buffer[0], 2);
 	memcpy(&data->scan.chan[1], &data->buffer[2], 2);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 
 error:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 8397155555bd..d6715997f137 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -191,8 +191,8 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	}
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index c48231739f48..cf5f48874a68 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -652,7 +652,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 		}
 	}
 
-	iio_push_to_buffers_with_timestamp(idev, &data->buf, data->timestamp);
+	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
+				    data->timestamp);
 	iio_trigger_notify_done(idev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 30f007794f5b..1640aa3717ed 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -618,8 +618,8 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
 	 */
 	zpa2326_dbg(indio_dev, "filling raw samples buffer");
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &sample,
-					   private->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &sample, sizeof(sample),
+				    private->timestamp);
 
 	return 0;
 }
-- 
2.48.1


