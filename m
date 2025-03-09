Return-Path: <linux-iio+bounces-16639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D181A5872B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FEB1662AD
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4E620297A;
	Sun,  9 Mar 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvjGAJ9g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188361F8752
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544530; cv=none; b=pcCspBDmEjh+8yqfIwPtXSi8dNFOJQEux3saNLN6RQRCJCdgUtWKKmVd4CS6BB+9YjTNYLlSpKQsFZTInVr5qc6UttU2TK+gmLk1KRyY+VKlryPRpOit7NghFcDIySq7qbq+Trz/nsEy/pv847UPoBfkd4xow7r+viGybGUV/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544530; c=relaxed/simple;
	bh=1tenLYdzXxn9TYgd37zhG/UrIgi03hBcz9+GPJXIqsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tkj78LpGPr7Gp2GvAeYuWdQ5JbFuafhNq1t+w2E+rJB9yKC5Z3m51jFeuq0Bl2Y19GyEo0ff6xKG3XO2BC0pGHSBuho/YMe59fO9KzoGdbJ9CkRbNPNu0LP3bOG6CDhCXbQO8V0KSb+xQ2mUrqdIp+uswaV+Aj69NwUwR8ry6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvjGAJ9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CABBC4CEE3;
	Sun,  9 Mar 2025 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544529;
	bh=1tenLYdzXxn9TYgd37zhG/UrIgi03hBcz9+GPJXIqsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvjGAJ9gufKfdtypcsCz+nVCcFbjy5Fy3AOoIaGat+dUMkqIjGqSF/bpJD8GQr9FF
	 GHwxdAupzcI3n6b9eBmblgbPCcRjknT4xGIGPCPmX7LLD04njvlvO02rjpf8HNopSz
	 ulhoHa1ueKCA9qP6qSKeeVvOJBMZwLmVMXq7kYYaLPw+UKIByFzwv0gwgF8R9jUVRY
	 VwoUSOfuGDpe8/S1UTpaS6vKLqL5gQPMqYG7hZ+sIADAn2gG4+570bJy3RsjFtRebl
	 cJq9WXE75zGfhrdXSiogMOgVllUvLlCiorflq6WfPcD5pzyQ49fT41jj+t1xgdFhoC
	 t3ZgKtAsq5EyQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/16] iio: proximity: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  9 Mar 2025 18:20:57 +0000
Message-ID: <20250309182100.1351128-14-jic23@kernel.org>
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
index 9d3caf2bef18..d91a1fefe74e 100644
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
index 0ec6b4b28d08..15f9315e49b1 100644
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
index cfc75d001f20..1c3a23b6dfe3 100644
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
index 86cab113ef3d..694c943455aa 100644
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
2.48.1


