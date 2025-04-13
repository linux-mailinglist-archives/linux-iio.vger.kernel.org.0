Return-Path: <linux-iio+bounces-18053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F18EA87191
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05203B8168
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551A19F40B;
	Sun, 13 Apr 2025 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxeEAb0B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608919DF5F
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540519; cv=none; b=sgI/H8vNV4aZUIQ7nv7nkIn7V858CL8Ee15O0rVQNiEfJf5fAJ2EcMebz5g+2Dkt03ILCxfv7AZjMMiACEOfo3WugzNAqIrO8SAqIL3+xXYr+Uwvj/nyL/l5LRmY9aSgy1mD3et0/F3MOZ9ElHj58DRbxVPbuMuhiOCllPCdw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540519; c=relaxed/simple;
	bh=i6hzosEBfC5ImuMF3CYKLxATS0Pj915p8V+eG95LQT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nk4rBtWSd738CWUttWceM5QAhM4wMvHL1YGLAUzmw+wpMnN98lAn3k0K+oYVHOy+oFl//A+jsiH8bVbeknCHOW9rcvUD9hqeHlVHSE9lNqzyUbKeYLAKNpA2X6XY2rHbwQK3g4ZL7BxvvM10cYI0aCtJulZ+gH/EpVm24NV7MJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxeEAb0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC43C4CEEA;
	Sun, 13 Apr 2025 10:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540519;
	bh=i6hzosEBfC5ImuMF3CYKLxATS0Pj915p8V+eG95LQT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxeEAb0B/ZD38w+lveWNqQzgzF+tVqVAE4U9GYnQ9YcbFJ5lzwa3lD6DRD4LBecsu
	 QTfqWXjoYgbcUFiQHtRqDtKmBtG+tuzw8atoOtbIoTzWn8fa/LZuqVInJrQp9iD0jO
	 UBDfVmwleAS3gjjDVor5dyjvHnFoYgylqgRXyoWurpSa7pugrXARcvoBVQDfpTppEm
	 uWfrumaJDlcdMJqaiSHPKLlsukeRU3prPkq29qwYDXeBI5Uq+XIcnnvfzy4i8HAZjR
	 9q7gWSK6jPLtKrj3+rJFP6fONVrahFCffn+PXNMwKuA/oRLoTaa3fV+xxLNhoDCPBQ
	 Nr3+X008H+71Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 09/20] iio: adc: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun, 13 Apr 2025 11:34:32 +0100
Message-ID: <20250413103443.2420727-10-jic23@kernel.org>
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
v3:
- White space tweaks (Andy)
v2:
- ad4030, use &st->rx_data rather than st->rx_data.raw.
  Given that is the largest element of the union it isn't a bug, but
  the available space is more obvious if we use the whole union.
---
 drivers/iio/adc/ad4000.c          | 3 ++-
 drivers/iio/adc/ad4030.c          | 4 ++--
 drivers/iio/adc/ad4695.c          | 3 ++-
 drivers/iio/adc/ad7266.c          | 7 +++----
 drivers/iio/adc/ad7298.c          | 4 ++--
 drivers/iio/adc/ad7380.c          | 4 ++--
 drivers/iio/adc/ad7476.c          | 4 ++--
 drivers/iio/adc/ad7606.c          | 4 ++--
 drivers/iio/adc/ad7768-1.c        | 5 +++--
 drivers/iio/adc/ad7779.c          | 3 ++-
 drivers/iio/adc/ad7923.c          | 4 ++--
 drivers/iio/adc/dln2-adc.c        | 4 ++--
 drivers/iio/adc/ina2xx-adc.c      | 2 +-
 drivers/iio/adc/max1118.c         | 4 ++--
 drivers/iio/adc/max11410.c        | 4 ++--
 drivers/iio/adc/max1363.c         | 4 ++--
 drivers/iio/adc/mcp3911.c         | 4 ++--
 drivers/iio/adc/mxs-lradc-adc.c   | 3 ++-
 drivers/iio/adc/pac1921.c         | 3 ++-
 drivers/iio/adc/rockchip_saradc.c | 3 ++-
 drivers/iio/adc/rtq6056.c         | 3 ++-
 drivers/iio/adc/stm32-adc.c       | 4 ++--
 drivers/iio/adc/ti-adc081c.c      | 4 ++--
 drivers/iio/adc/ti-adc0832.c      | 4 ++--
 drivers/iio/adc/ti-adc084s021.c   | 4 ++--
 drivers/iio/adc/ti-adc12138.c     | 4 ++--
 drivers/iio/adc/ti-ads1015.c      | 4 ++--
 drivers/iio/adc/ti-ads1119.c      | 4 ++--
 drivers/iio/adc/ti-ads124s08.c    | 4 ++--
 drivers/iio/adc/ti-ads8688.c      | 4 ++--
 drivers/iio/adc/ti-lmp92064.c     | 4 ++--
 drivers/iio/adc/ti-tlc4541.c      | 4 ++--
 drivers/iio/adc/ti-tsc2046.c      | 5 +++--
 drivers/iio/adc/vf610_adc.c       | 6 +++---
 34 files changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index e69a9d2a3e8c..93ecaf401f27 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -793,7 +793,8 @@ static irqreturn_t ad4000_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    pf->timestamp);
 
 err_out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 636f9f33e66a..5aa26dc3a2ce 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -707,8 +707,8 @@ static irqreturn_t ad4030_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_data.raw,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &st->rx_data, sizeof(st->rx_data),
+				    pf->timestamp);
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 8222c8ab2940..68c6625db0d7 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -801,7 +801,8 @@ static irqreturn_t ad4695_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->buf, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, st->buf, sizeof(st->buf),
+				    pf->timestamp);
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 7fef2727f89e..3364ac6c4631 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -86,10 +86,9 @@ static irqreturn_t ad7266_trigger_handler(int irq, void *p)
 	int ret;
 
 	ret = spi_read(st->spi, st->data.sample, 4);
-	if (ret == 0) {
-		iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
-			    pf->timestamp);
-	}
+	if (ret == 0)
+		iio_push_to_buffers_with_ts(indio_dev, &st->data, sizeof(st->data),
+					    pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 28b88092b4aa..7c0538ea15c8 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -155,8 +155,8 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	if (b_sent)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, st->rx_buf, sizeof(st->rx_buf),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 190ab411739f..f93e6c67766a 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1361,8 +1361,8 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan_data, sizeof(st->scan_data),
+				    pf->timestamp);
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 37b0515cf4fc..ddb607ac1860 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -99,8 +99,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 	if (b_sent < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
+				    iio_get_time_ns(indio_dev));
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d36b2e212a08..aa96247d6757 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -605,8 +605,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	if (ret)
 		goto error_ret;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->data, sizeof(st->data),
+				    iio_get_time_ns(indio_dev));
 error_ret:
 	iio_trigger_notify_done(indio_dev->trig);
 	/* The rising edge of the CONVST signal starts a new conversion. */
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 50dee37d4b08..baa2d5440185 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -533,8 +533,9 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->data.scan,
+				    sizeof(st->data.scan),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index a5d87faa5e12..845adc510239 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -595,7 +595,8 @@ static irqreturn_t ad7779_trigger_handler(int irq, void *p)
 		goto exit_handler;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->data, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &st->data, sizeof(st->data),
+				    pf->timestamp);
 
 exit_handler:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 87945efb940b..0369151c7db1 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -207,8 +207,8 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
 	if (b_sent)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, st->rx_buf, sizeof(st->rx_buf),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 359e26e3f5bc..9dbd2c87938c 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -488,8 +488,8 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
 		       (void *)dev_data.values + t->from, t->length);
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data, sizeof(data),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 40d14faa71c5..857e1b69d6cd 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -766,7 +766,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 		chip->scan.chan[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &chip->scan, time);
+	iio_push_to_buffers_with_ts(indio_dev, &chip->scan, sizeof(chip->scan), time);
 
 	return 0;
 };
diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 565ca2e21c0c..7d7001e8e3d9 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -188,8 +188,8 @@ static irqreturn_t max1118_trigger_handler(int irq, void *p)
 		adc->scan.channels[i] = ret;
 		i++;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &adc->scan, sizeof(adc->scan),
+				    iio_get_time_ns(indio_dev));
 out:
 	mutex_unlock(&adc->lock);
 
diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index 437d9f24b5a1..511b2f14dfaf 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -632,8 +632,8 @@ static irqreturn_t max11410_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index d0546c681625..a7e9912fb44a 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1498,8 +1498,8 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	if (b_sent < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->data, sizeof(st->data),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 6748b44d568d..be18635ae616 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -516,8 +516,8 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 		adc->scan.channels[i] = get_unaligned_be24(&adc->rx_buf[scan_chan->channel * 3]);
 		i++;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &adc->scan, sizeof(adc->scan),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 8f1e6acea53b..92baf3f5f560 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -425,7 +425,8 @@ static irqreturn_t mxs_lradc_adc_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(iio, adc->buffer, pf->timestamp);
+	iio_push_to_buffers_with_ts(iio, adc->buffer, sizeof(adc->buffer),
+				    pf->timestamp);
 
 	iio_trigger_notify_done(iio->trig);
 
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index ef75e9e51c24..72aa4ca2e5a4 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1044,7 +1044,8 @@ static irqreturn_t pac1921_trigger_handler(int irq, void *p)
 		priv->scan.chan[ch++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(idev, &priv->scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(idev, &priv->scan, sizeof(priv->scan),
+				    pf->timestamp);
 
 done:
 	iio_trigger_notify_done(idev->trig);
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 9a099df79518..2162bff69913 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -425,7 +425,8 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(i_dev, &data, iio_get_time_ns(i_dev));
+	iio_push_to_buffers_with_ts(i_dev, &data, sizeof(data),
+				    iio_get_time_ns(i_dev));
 out:
 	mutex_unlock(&info->lock);
 
diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index 54239df61d86..6ff47415a222 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -666,7 +666,8 @@ static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
 		data.vals[i++] = raw;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data, sizeof(data),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	pm_runtime_mark_last_busy(dev);
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 27aec9a18a0f..5159908a2a61 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1858,8 +1858,8 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
 
 	/* reset buffer index */
 	adc->bufi = 0;
-	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, adc->buffer, sizeof(adc->buffer),
+				    pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	/* re-enable eoc irq */
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 1af9be071d8d..4f514db5c26e 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -140,8 +140,8 @@ static irqreturn_t adc081c_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto out;
 	data->scan.channel = ret;
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index e2dbd070c7c4..cfcdafbe284b 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -225,8 +225,8 @@ static irqreturn_t adc0832_trigger_handler(int irq, void *p)
 		adc->data[i] = ret;
 		i++;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, adc->data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, adc->data, sizeof(adc->data),
+				    iio_get_time_ns(indio_dev));
 out:
 	mutex_unlock(&adc->lock);
 
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index 9c845ee01697..50a474f4d9f5 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -151,8 +151,8 @@ static irqreturn_t adc084s021_buffer_trigger_handler(int irq, void *pollfunc)
 	if (adc084s021_adc_conversion(adc, adc->scan.channels) < 0)
 		dev_err(&adc->spi->dev, "Failed to read data\n");
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &adc->scan, sizeof(adc->scan),
+				    iio_get_time_ns(indio_dev));
 	mutex_unlock(&adc->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index 7f065f457b36..9dc465a10ffc 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -376,8 +376,8 @@ static irqreturn_t adc12138_trigger_handler(int irq, void *p)
 		}
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, adc->data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, adc->data, sizeof(adc->data),
+				    iio_get_time_ns(indio_dev));
 out:
 	mutex_unlock(&adc->lock);
 
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 705c146c7dc2..21181cc3bd85 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -467,8 +467,8 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
 	scan.chan = res;
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index f120e7e21cff..d280c949cf47 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -534,8 +534,8 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
 
 	scan.sample = ret;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 77c299bb4ebc..8ea1269f74db 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -297,8 +297,8 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer,
-			pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, priv->buffer, sizeof(priv->buffer),
+				    pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index a31658b760a4..b0bf46cae0b6 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -389,8 +389,8 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-			iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
+				    iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
index 86eef3320de9..3f375c1f586c 100644
--- a/drivers/iio/adc/ti-lmp92064.c
+++ b/drivers/iio/adc/ti-lmp92064.c
@@ -209,8 +209,8 @@ static irqreturn_t lmp92064_trigger_handler(int irq, void *p)
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data, sizeof(data),
+				    iio_get_time_ns(indio_dev));
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 5a138be983ed..f67945c62c99 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -99,8 +99,8 @@ static irqreturn_t tlc4541_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, st->rx_buf, sizeof(st->rx_buf),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 49560059f4b7..84a9a5e66526 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -418,8 +418,9 @@ static int tsc2046_adc_scan(struct iio_dev *indio_dev)
 	for (group = 0; group < priv->groups; group++)
 		priv->scan_buf.data[group] = tsc2046_adc_get_val(priv, group);
 
-	ret = iio_push_to_buffers_with_timestamp(indio_dev, &priv->scan_buf,
-						 iio_get_time_ns(indio_dev));
+	ret = iio_push_to_buffers_with_ts(indio_dev, &priv->scan_buf,
+					  sizeof(priv->scan_buf),
+					  iio_get_time_ns(indio_dev));
 	/* If the consumer is kfifo, we may get a EBUSY here - ignore it. */
 	if (ret < 0 && ret != -EBUSY) {
 		dev_err_ratelimited(dev, "Failed to push scan buffer %pe\n",
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 805e1973b090..6404b015234a 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -592,9 +592,9 @@ static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
 		info->value = vf610_adc_read_data(info);
 		if (iio_buffer_enabled(indio_dev)) {
 			info->scan.chan = info->value;
-			iio_push_to_buffers_with_timestamp(indio_dev,
-					&info->scan,
-					iio_get_time_ns(indio_dev));
+			iio_push_to_buffers_with_ts(indio_dev, &info->scan,
+						    sizeof(info->scan),
+						    iio_get_time_ns(indio_dev));
 			iio_trigger_notify_done(indio_dev->trig);
 		} else
 			complete(&info->completion);
-- 
2.49.0


