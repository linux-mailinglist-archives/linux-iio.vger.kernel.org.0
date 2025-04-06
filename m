Return-Path: <linux-iio+bounces-17702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BBBA7CF27
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C9316BD7F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233FA187346;
	Sun,  6 Apr 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVYHUsRv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B71487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960057; cv=none; b=gtbE/RzRDpjtiaTk6HJQcKH7s7g9vh5tR2UIACacRsZjSXXjz0XxAuCLBJu3lCywb1ZD/aGsp121GdKEutVz+UU23I6QY/l2dcGG7KsfMuY8xo5XlQaTN0/je4t2v+yc04qVG5zONgb7U8S4Z6CzNb5qCcapM5d5PZaNA8Hp5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960057; c=relaxed/simple;
	bh=n7wIqSLwJOIAOMsQrvyspqYXyNkAYFwi+RB/2RRduzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y35azBXlYRA42nlIVS+o8x3c34tvbk7j00bh3XpCE75YtXRdcHtF2p5Kut0OnIxIhETsga2D6Y0YB460+boo6JtwvA7VULJMjcwGSdoscWMPOa4ixMQhv8ZzqVLpWUT/vb8VyYBYq6H1YWM0AD12I91t6LjMFF1uLG4xOg0tRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVYHUsRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16203C4CEE3;
	Sun,  6 Apr 2025 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960057;
	bh=n7wIqSLwJOIAOMsQrvyspqYXyNkAYFwi+RB/2RRduzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVYHUsRvyaDzauNi6iUxqYZP8Jlg4889Q8V8Gt5obDW4wHuQvsoKH+D/KSkdHYvO9
	 4pONtKOW+9xAhEebhr8rIS5cDFbs4VAZbgdIbiQnFzXs1z7/Xwdhh41Guk56YZlgfI
	 AcuJz4Te+3bxj5jgiXpqJ7hdl/Xnkc3ks/Dt3cdg8siF6v49KhXrd6LIfw0ABg9cZN
	 SA5lFHxJB80YTX3bKHm0Ob8eL/tv+wgeQe8V1uaCWxX/6XM9lZWInjiHgA8Q3xj5BK
	 CljoGtps4grCoMArfGAOD7yvrrX3NgOTYIQ4plsayagKy5zw/FPpZo3fujdOjlkb4r
	 zk1G2c1pu6WzQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 14/20] iio: temperature: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  6 Apr 2025 18:19:55 +0100
Message-ID: <20250406172001.2167607-15-jic23@kernel.org>
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
 drivers/iio/temperature/hid-sensor-temperature.c | 5 +++--
 drivers/iio/temperature/maxim_thermocouple.c     | 5 +++--
 drivers/iio/temperature/tmp006.c                 | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 692520e1c497..005106a9e03b 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -131,8 +131,9 @@ static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct temperature_state *temp_st = iio_priv(indio_dev);
 
 	if (atomic_read(&temp_st->common_attributes.data_ready))
-		iio_push_to_buffers_with_timestamp(indio_dev, &temp_st->scan,
-						   iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_ts(indio_dev, &temp_st->scan,
+					    sizeof(temp_st->scan),
+					    iio_get_time_ns(indio_dev));
 
 	return 0;
 }
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index db2149d5f78c..2db13d381dbd 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -168,8 +168,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
 
 	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
 	if (!ret) {
-		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-						   iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+					    sizeof(data->buffer),
+					    iio_get_time_ns(indio_dev));
 	}
 
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index b5c94b7492f5..29bff9d8859d 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -269,8 +269,8 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
 		goto err;
 	scan.channels[1] = ret;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.49.0


