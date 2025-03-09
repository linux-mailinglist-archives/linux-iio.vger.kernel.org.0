Return-Path: <linux-iio+bounces-16632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD15CA58732
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E583A39D2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403561F9F5C;
	Sun,  9 Mar 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmA/pQte"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24DF1F09AA
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544514; cv=none; b=OdvHvcV5iRiWs7S+Q1Lb7XPUYx1rmLOoJuFfoXYVKvpPngEoxFZZnrITMME91tEUXA/1AaQU8TzoeBjCpOR60Jyt2UF8fEWGmeqAp+xXfewWSw/adVpuoyaw/EUSs9mAW0n+z5VxLbQuKukppI30AMxRQz7arR7+maSW/G9lA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544514; c=relaxed/simple;
	bh=k6HFcbf8TP8YmNlCDzXJ7OxYDFc2NOFHC5YDDgAxetc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8sSM/jZ57xMaHHmh8ECisaHLgvFW8nrtwsfNo36Nm9psgxm1QJNoIIpUNTwzucPW/qRK21+CPT75uwPDDXbEGEa+kySdwkwRY/RQug7T4qwSbmhQs3zT3Bftatylq8Mk1twxw+GzyzsjprKwZgQ6budLl/5GBgSc6PxPqZyDMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmA/pQte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B63C4CEE3;
	Sun,  9 Mar 2025 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544513;
	bh=k6HFcbf8TP8YmNlCDzXJ7OxYDFc2NOFHC5YDDgAxetc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmA/pQte9lCZzrqmTYJcDgFZIaHipT3+XIZnaKdMDJW3lg0kuJNgrCQsJICwjfq+U
	 47OJ+l/CCRDHFJRIRA7b+fPb8PG7ANmN5E1MFXhDT79g8iakt0YV7lEMPau0H8AL3W
	 7yVGLmdbsBZnoNnnjrTREWkDBpQsRoSEA/r048P9BU1liBE5E3sxbAKbGgLzkeDjK+
	 0Anrk2NoXi1zQTpZtQWaZDIUmUGYnVPIwgbXtEhAJfEWjx7j5foT9Z+7TxcHOirqbM
	 qRKc29zwfQxkBbwwH+FCNXVnHch85kX9OKVFVz7PlqOSImIhae/K/DjemmlpZ2oy48
	 cqROyydW0eSCQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/16] iio: accel: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  9 Mar 2025 18:20:50 +0000
Message-ID: <20250309182100.1351128-7-jic23@kernel.org>
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
 drivers/iio/accel/adxl355_core.c    | 4 ++--
 drivers/iio/accel/bma180.c          | 3 ++-
 drivers/iio/accel/bma220_spi.c      | 4 ++--
 drivers/iio/accel/bma400_core.c     | 5 +++--
 drivers/iio/accel/fxls8962af-core.c | 4 ++--
 drivers/iio/accel/kxcjk-1013.c      | 4 ++--
 drivers/iio/accel/kxsd9.c           | 5 ++---
 drivers/iio/accel/mma7455_core.c    | 5 +++--
 drivers/iio/accel/mma8452.c         | 5 +++--
 drivers/iio/accel/msa311.c          | 4 ++--
 drivers/iio/accel/mxc4005.c         | 4 ++--
 drivers/iio/accel/sca3300.c         | 5 +++--
 drivers/iio/accel/stk8312.c         | 2 +-
 drivers/iio/accel/stk8ba50.c        | 4 ++--
 14 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index e8cd21fa77a6..ae949ada6db5 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -666,8 +666,8 @@ static irqreturn_t adxl355_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out_unlock_notify;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
+				    sizeof(data->buffer), pf->timestamp);
 
 out_unlock_notify:
 	mutex_unlock(&data->lock);
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index aa664a923f91..a3af0026f679 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -887,7 +887,8 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 
 	mutex_unlock(&data->mutex);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+				    sizeof(data->scan), time_ns);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 96ba028157ee..2d27a592a61e 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -103,8 +103,8 @@ static irqreturn_t bma220_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
 err:
 	mutex_unlock(&data->lock);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 23f5e1ce9cc4..85e23badf733 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1591,8 +1591,9 @@ static irqreturn_t bma400_trigger_handler(int irq, void *p)
 		data->buffer.temperature = temp;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
+				    sizeof(data->buffer),
+				    iio_get_time_ns(indio_dev));
 
 	mutex_unlock(&data->mutex);
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 48e4282964a0..6d23da3e7aa2 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -983,8 +983,8 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 			       sizeof(data->scan.channels[0]));
 		}
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-						   tstamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index f2496cad8ec2..971b76c98606 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1253,8 +1253,8 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   data->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    data->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 0ededf8cfdca..558a79b48967 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -229,9 +229,8 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev,
-					   &hw_values,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &hw_values, sizeof(hw_values),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index 30746621052c..a2b5bdf14dde 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -103,8 +103,9 @@ static irqreturn_t mma7455_trigger_handler(int irq, void *p)
 	if (ret)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &mma7455->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &mma7455->scan,
+				    sizeof(mma7455->scan),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 05f5482f366e..aba444a980d9 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1103,8 +1103,9 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
+				    sizeof(data->buffer),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index d31c11fbbe68..c31c53abc3d0 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -919,8 +919,8 @@ static irqreturn_t msa311_buffer_thread(int irq, void *p)
 
 	mutex_unlock(&msa311->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &buf,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &buf, sizeof(buf),
+				    iio_get_time_ns(indio_dev));
 
 notify_done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index cb5c4e354fc0..e97026a18046 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -335,8 +335,8 @@ static irqreturn_t mxc4005_trigger_handler(int irq, void *private)
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ca0ce83e42b2..b5f3e2175248 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -505,8 +505,9 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 		channels[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+				    sizeof(data->buffer),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 471c154c3631..139234da82d4 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -460,7 +460,7 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 	}
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
 					   pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index cab592a68622..a96324ef9869 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -340,8 +340,8 @@ static irqreturn_t stk8ba50_trigger_handler(int irq, void *p)
 			data->scan.chans[i++] = ret;
 		}
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
 err:
 	mutex_unlock(&data->lock);
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.48.1


