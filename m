Return-Path: <linux-iio+bounces-18058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E746A87195
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C123BC8DE
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D105C1A00F0;
	Sun, 13 Apr 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAp6MJQ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291619D880
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540533; cv=none; b=QcmhDEfijz15nZklS30C96ena+VFHhOM2h/05amGZ0TnQD+kGxEBwJujQjybNwwWaksEzDjkLJHQWOe6QEaEF+veSR4HyNYavt7Hq7dfiqZNQAtmgpM08zpNEsduE+gHPmJTTVmNZOVgVDI8xRVTJ0frO09N5VfUODHogA02mc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540533; c=relaxed/simple;
	bh=ldM7JiBxVIgn5zP7iMOoq4BuJDeIr6CUwn4U3xHbIPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpcjtQZjKPH6GJTZRNj4CW4PEHznHdgvbIL0hQ6Yui6Do8j1CLr3yoKkLB3GYzQaqgRjiWmodlR0CCa9dIQFXKAHv6O7yUNsRE9NjWEpGo+hmsvITTS9fYoosuDwp33eJlyci19ZBDRPquusWNxMzc0tQ8V5Pmr+NJjeBIUV58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAp6MJQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18FBC4CEEA;
	Sun, 13 Apr 2025 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540533;
	bh=ldM7JiBxVIgn5zP7iMOoq4BuJDeIr6CUwn4U3xHbIPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAp6MJQ+IbrKsEOkT+dVMGvNeE4LLVx/Kjj2KOqdmQDc4cLuPQ5R3h+hcopmVKzYq
	 Fh8Xf4h0a/AOiQ4mlapW8AOxhgh50PMhQfF/9wOURz3rUYs7XcuJa3U/aFsllrapTf
	 0pTmiB/cfzTAKTKGmS4DDx5X5mK78pelbEYA8PnoWv5oydMUO1vsJseYgyujedXvGL
	 1pqtf+YkNa7oJ1vjzS4HhYT69B9MUaSLWWY+1oFfHy1eX0edQgFVKbdUlhLTR5OTyM
	 5a8oCZ3aEPq29jTAhXzsTck8XZLyJoQVlfXOQsdQoAUzeYlqr8e3ecxjMaAEWJ6byN
	 WOBe5jf6dH2lw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 14/20] iio: temperature: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun, 13 Apr 2025 11:34:37 +0100
Message-ID: <20250413103443.2420727-15-jic23@kernel.org>
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
 drivers/iio/temperature/hid-sensor-temperature.c | 5 +++--
 drivers/iio/temperature/maxim_thermocouple.c     | 5 +++--
 drivers/iio/temperature/tmp006.c                 | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 09f470bb0841..9f628a8e5cfb 100644
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
index dcfcbc434a90..cae8e84821d7 100644
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


