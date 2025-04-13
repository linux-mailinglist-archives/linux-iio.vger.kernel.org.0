Return-Path: <linux-iio+bounces-18054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB2FA87192
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C15F7A87BF
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFAC19F471;
	Sun, 13 Apr 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhvG9bhr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F119D880
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540522; cv=none; b=EHNFUlTTXn8GuNP6IDKRxhH/IqlAfi0JS+Pe3aCUeJmQa04zjf1nfsSUy9O4Vlvy3uMTue53QjHdNogd4pQb9D1+Xba6K+Ws2O6qN5OadQmpyiIxqz3vD9lRdYe3fAm3d2GVB/i+lZnmqJ4aD4Fdugxu5Q18E0DCUvrHlSJcrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540522; c=relaxed/simple;
	bh=EUd8/B5OnW6v00Q/S2n0Vu4jeTVNiDvpkap+3whu2Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVWKGf7dj7pUck8wdYRXdaoDcifSAiPyNbzvtszIkgBda3KW7POx6rRBBKERM8LG6aHD2J7QwYTZoMHVBLif7+Lojrlb+5UwBFDuzH5X8Gkgr+J21DRnLBmXEnpuvUjww602LE4F69JyU0WFBbX9vRJA3iVDV54JAGDBKmeANQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhvG9bhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF2C4CEDD;
	Sun, 13 Apr 2025 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540522;
	bh=EUd8/B5OnW6v00Q/S2n0Vu4jeTVNiDvpkap+3whu2Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhvG9bhrKlmUTTipfS1TQbTlo6A684oJg9n+7fePGPu9SpnWAs9maHZRU54S6UAPK
	 VswUHMx5JkYhKKjcbG/5AnuDDg+UzjF6LfDCNX4zq3J23vs9QrLcP1UdK3kk4N9WDH
	 KRSxPv+GiGGQ9nstmRz9FsqhgZFQQI4WMuX6fvqICVv1oAwE+oXhcFtx4y2Rcb2xTa
	 QTlSknmEhjO6G4vkbMjORsIVtuZ2muA5j39WR9ImKcNUzdoUADyWEOs3e9SgvL0EOu
	 g/HewQ3BUu1hATKwiG6jFFspgXbBkb9zuDAvy56b7wHHlomt81ZXZ0iws/3TkOtD0f
	 1LuN6rkbqSJLA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 10/20] iio: accel: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun, 13 Apr 2025 11:34:33 +0100
Message-ID: <20250413103443.2420727-11-jic23@kernel.org>
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
v3: White space tweaks (Andy)
---
 drivers/iio/accel/adxl355_core.c    | 4 ++--
 drivers/iio/accel/bma180.c          | 2 +-
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
 drivers/iio/accel/stk8312.c         | 4 ++--
 drivers/iio/accel/stk8ba50.c        | 4 ++--
 14 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index cbac622ef821..2e00fd51b4d5 100644
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
index aa664a923f91..93a868678722 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -887,7 +887,7 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 
 	mutex_unlock(&data->mutex);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan), time_ns);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 978108fb74e9..38f7498431ee 100644
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
index fb14b875e20d..cfc31265cdd0 100644
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
index c9c4bab08a81..1075c8ce0e37 100644
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
index 9b00a3d7056d..1132bbaba75b 100644
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
index d3ff1287c017..dfac2e44191f 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -460,8 +460,8 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 	}
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index e5fed3eac2c8..05d4fd540eb2 100644
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
2.49.0


