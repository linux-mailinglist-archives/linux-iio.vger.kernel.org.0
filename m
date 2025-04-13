Return-Path: <linux-iio+bounces-18061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD6A87199
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882311890EFC
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3787D1A0728;
	Sun, 13 Apr 2025 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X244P7Vu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B019D880
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540542; cv=none; b=Uwsd1qzvgP7fzm0+D8l8hqb+O7RFOyPACD7VV7utrcn5I/IEI+qA7Bx6kssRjGhZQki3OqNdenUKtVoKSoLJLID80A9Nw+Ib/xtyZyqOXhb60qzZYEw1bGZzHsIBslH9pJzObhyu90mPZfLdgVyubYMdLTw3aOzWsV067GwbwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540542; c=relaxed/simple;
	bh=1gKVZKU5wXiQAjF+2FL8EMVU35MVsQHfFJGdAQZiHBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tv5lECaRdD79mC2NF8qU2wtcxa+QNdEUDaJU6ImZDmyM45e3atZeLIHCib3YBS+ZaZwmDA5EWZbwpdYCreQ8wTODSx1fB4NXV6Vl+J8bXFQTGlNB9i/i1pJIu3QegW83mF140vJrLdRnN5fd1odH25IC3woHKdj42RQFZqmAJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X244P7Vu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9E7C4CEEA;
	Sun, 13 Apr 2025 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540541;
	bh=1gKVZKU5wXiQAjF+2FL8EMVU35MVsQHfFJGdAQZiHBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X244P7Vu+5/Oj4CNKkrEvqab/NS8u9dtXE97lcBehzAP8hiPI+/rgsi47/nFcDTAm
	 2cLpH8TBzOxVQxt7KT60srisQ/MTrvxqvEk0nDL5HZ6GObFO0PntBpQOiBRkWsQLA9
	 4dUluyU8fLKGQXPSh4fFk7SamxzyeRPBRG7nRksdZ1aqMAtOWQWdd4w2z0PAmcjNfm
	 Iic46DzUa1GaOknPjffZVL29T711liAGbR0lQKWH82geCt5ov368HN9I8HJJ5m5Xcw
	 YCTLl75intHnIRcWzzASnE306/N8uv31142NpXMIY9pUYt9EAv6wANGHBggqCVNCkK
	 zuEHrDTzIRHxQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 17/20] iio: proximity: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun, 13 Apr 2025 11:34:40 +0100
Message-ID: <20250413103443.2420727-18-jic23@kernel.org>
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
that the overrun does not occur. Use it in all the simple cases where
either a static buffer or a structure is used in the drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/as3935.c                    | 4 ++--
 drivers/iio/proximity/hx9023s.c                   | 4 ++--
 drivers/iio/proximity/mb1232.c                    | 4 ++--
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 5 +++--
 drivers/iio/proximity/srf08.c                     | 4 ++--
 drivers/iio/proximity/sx_common.c                 | 4 ++--
 drivers/iio/proximity/vl53l0x-i2c.c               | 4 ++--
 7 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index d48d7b572878..f1018b14aecf 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -231,8 +231,8 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
 		goto err_read;
 
 	st->scan.chan = val & AS3935_DATA_MASK;
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    iio_get_time_ns(indio_dev));
 err_read:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index f2037fd99a8d..33781c314728 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -953,8 +953,8 @@ static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
 		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
+				    sizeof(data->buffer), pf->timestamp);
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index 24524edae0b4..01783486bc7d 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -125,8 +125,8 @@ static irqreturn_t mb1232_trigger_handler(int irq, void *p)
 	if (data->scan.distance < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index fbf9f8513055..1deaf70e92ce 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -238,8 +238,9 @@ static irqreturn_t lidar_trigger_handler(int irq, void *private)
 
 	ret = lidar_get_measurement(data, &data->scan.chan);
 	if (!ret) {
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-						   iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan),
+					    iio_get_time_ns(indio_dev));
 	} else if (ret != -EINVAL) {
 		dev_err(&data->client->dev, "cannot read LIDAR measurement");
 	}
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 940fad6aeaa4..6e32fdfd161b 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -191,8 +191,8 @@ static irqreturn_t srf08_trigger_handler(int irq, void *p)
 	mutex_lock(&data->lock);
 
 	data->scan.chan = sensor_data;
-	iio_push_to_buffers_with_timestamp(indio_dev,
-					   &data->scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
 
 	mutex_unlock(&data->lock);
 err:
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index f70198a1f0d1..59b35e40739b 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -379,8 +379,8 @@ static irqreturn_t sx_common_trigger_handler(int irq, void *private)
 		data->buffer.channels[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
+				    sizeof(data->buffer), pf->timestamp);
 
 out:
 	mutex_unlock(&data->mutex);
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 87d10faaff9b..ef4aa7b2835e 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -94,8 +94,8 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
 		return -EREMOTEIO;
 
 	data->scan.chan = get_unaligned_be16(&buffer[10]);
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
 	vl53l0x_clear_irq(data);
-- 
2.49.0


