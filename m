Return-Path: <linux-iio+bounces-17707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A982A7CF2C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3060E188D5CF
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFC18FDD2;
	Sun,  6 Apr 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeRR/IhY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAE1487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960072; cv=none; b=R07eIYwt8LQn83MG3zW0udKghk/T1pcdkKmoaxhGPHkNK9TpUc2K1vMfmaiyEBP90NmCMe0w9Lad36ArP8fzTxLKZHY7dvPPXFomsd5AcXEbJnqrXi8rjbXUkjyyQKRE7efKNAhjIpnbgVIxn7V0BJZZVJXV3IYdrMpBec1KP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960072; c=relaxed/simple;
	bh=Jso09oURncs+WA7m5qihotdrpcfVf4B+AAstsv0BA0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6cQ2utGRn3yRMIBT09bk17cU1bOVIk3wH9bRWUzOPGrzrKZsYD10rkb3wtMitRCCmwEbnYPcVBGwsrxixKKVqBah1V3gDEn3pH2+ARnLH+z9rmxgDLIaxnzQMaKEwktba8Ksn2VKpDG70f732C/V9DW1ek+30idRWWMrdBP53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeRR/IhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC58C4CEE3;
	Sun,  6 Apr 2025 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960070;
	bh=Jso09oURncs+WA7m5qihotdrpcfVf4B+AAstsv0BA0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VeRR/IhYjvD4fNqKS31hfbdAydX4xOMxC07FQUjJ1VKXXNQl+31HFuvlfBX3rEwLH
	 FNYaN2WzO0zkL6JJeoMsIQrXDrvTCVGpdU7hw4RfXtfjXvl6eFzFfYnX10jxCkIxc+
	 FqWuZcurrpqH6Mq3ce/E8JuctuKZl6tKLxE0vtOUaqBS5iU3TN7ksPvS0sfbID4IfX
	 GFeVyeuGMz7qvre3N7LM/4ujb6a8CwT7nzPXJchD7B5Gucx8+7JZ3zNWnpYxJn2h51
	 N1eGlW5H9pgsa1jGvUbjoIWRpo4YKSWWt52MKB1yZDt6a0IdCRY7TuB+d6BulW3JXi
	 /bnck1acW/skQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 19/20] iio: pressure: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  6 Apr 2025 18:20:00 +0100
Message-ID: <20250406172001.2167607-20-jic23@kernel.org>
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
2.49.0


