Return-Path: <linux-iio+bounces-18063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF3EA8719B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F63816E935
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846D31A08A0;
	Sun, 13 Apr 2025 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV9uN2z2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533519D880
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540546; cv=none; b=KUVoMmXPgajZ2s4BicYGZ0Rg2Y4JUt0SQBEORBtj5fB/QQA3MLGpLRAB/wd9Mt0lfVz48PCr9CjePnlfioq53+oiwR8vG9r/zHGvXKWxknQkOB2xXqcE4tUyYW/VG0jteQ5PItLxkWUByKNF0tP7Vso2svd8i6dnWLid6FvCiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540546; c=relaxed/simple;
	bh=caQH8ecAiQuANOIPUSePBk6TVuIqiI38+yGX+UyLsZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WP4+0kTtQUHPdCb6x+92cUlHeBReslSId3j4dMmdnt6pp836OIo+hAp9AZ83MmnYGpQaFMnwRYq4mu9HXKtqUo3iNl8RIbm482aSaZwFFdnMMCDewRMGMxPWFujgJ0CQZder02txvs0sAuZt2kxnXpCC5OHuFEn0VLHwemkrSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV9uN2z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE02C4CEEC;
	Sun, 13 Apr 2025 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540545;
	bh=caQH8ecAiQuANOIPUSePBk6TVuIqiI38+yGX+UyLsZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gV9uN2z2ETOpSCRtO+acai79d71Uy6vGFNEQ7+wvVgWB7mNMyjyK60nEbKq9+x5+f
	 G/4h2NjPClvYs3xttP6n06WoAWjt7ko1ekcmi5SgllY1GzV4Kua8mioUS+JAsn5YGt
	 4o+FhqcjYclS9uOYi+nYPnrS21TJdplI4P0co/GDhrfh69jeAOzaMFLpJZtXuldI2a
	 75wZ/OS/IuJ4vwGXI0CUxwSwjmqtWpUgrKtT4PgbUyoymOA1Plbu0BQ70MnHI5omJa
	 7s27bgpylUPO1tF+SV+U7tRmqPr4UxpmOV80VpmnUN79jsbvN11N0qWXFi6Q4k1dxp
	 4mtbz2VvaCLOg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v3 19/20] iio: pressure: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun, 13 Apr 2025 11:34:42 +0100
Message-ID: <20250413103443.2420727-20-jic23@kernel.org>
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

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com> # ROHM BM1390
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
index bffeddff5e91..5f1d6abda3e4 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -176,8 +176,9 @@ static int press_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!press_state->timestamp)
 			press_state->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(
-			indio_dev, &press_state->scan, press_state->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, &press_state->scan,
+					    sizeof(press_state->scan),
+					    press_state->timestamp);
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
index c651ead080df..dac27fd359ad 100644
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


