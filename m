Return-Path: <linux-iio+bounces-17697-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F08A7CF22
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B379A3A71B0
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092CE17A2F5;
	Sun,  6 Apr 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcFlxbtt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B61487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960044; cv=none; b=BkR5XvtK4CGNZRUyZ6lunjEso1/KgbKid7s7C2Bs5ObWnAZ5w36jyTvrD9va4FXD0LZp6NCfIY9titcg3X8nPyuHCrH8KZgAO0bTEli4blfX5KtHBaWJS4xs3y3iwa2WQWtCzur/bWszCJE2foz2kaXh9G64ELGKXWo6R+jkwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960044; c=relaxed/simple;
	bh=RRyuYTn3tFg4hg2wAdgl7DeHbUBjabe/zZgJayOghvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csoZtlqGuLKNapJ8fzQVxUwFcScD7EYHTSWzqWVvdHjcv3HjsRrYI1AVM5f8TJeRHDADdWq1kVj5k84SxSikJvPca4mhee0Ye9af707hs1TKE2O4Iz30BA7JaVw33squsQSd71ptbn7SdUYa83OgJg9xHLM5j02abMm5uGFTSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcFlxbtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27FFC4CEE7;
	Sun,  6 Apr 2025 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960044;
	bh=RRyuYTn3tFg4hg2wAdgl7DeHbUBjabe/zZgJayOghvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcFlxbtt0huunJgIW+riQhauJ8EQrfW+cPFkclsdGa4d3+QvW2lpF0c8XwKeCoJTY
	 Lx9A4CIn8tZX88d42kc6DkNY8nizUhoTrtPgSLvDE0ACCrXAzSj2qJn/GqtozbY9JW
	 5jmS8A0mf5xt0MTLzXA75W+F0CFz9Np9jQ1TtktLN8i8NLszUJo/P6GqMiJzXAVGAV
	 +Mfj9jJN/xH5WCJ7+8Lct9zTNuyNwBIGOa287pY/Jzv1DOudmXN6A0esmgSl4g6JC3
	 ENQRHsRyw6NeeFxWfB59b+RY7vlvAcfOCEKTfc+xzCPkezN8OzeyFV0MqfBiYQt5fa
	 Bch31M43zfw3w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 09/20] iio: adc: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  6 Apr 2025 18:19:50 +0100
Message-ID: <20250406172001.2167607-10-jic23@kernel.org>
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
v2:
- ad4030, use &st->rx_data rather than st->rx_data.raw.
  Given that is the largest element of the union it isn't a bug, but
  the available space is more obvious if we use the whole union.
---
 drivers/iio/adc/ad4000.c          | 3 ++-
 drivers/iio/adc/ad4030.c          | 4 ++--
 drivers/iio/adc/ad4695.c          | 3 ++-
 drivers/iio/adc/ad7266.c          | 5 +++--
 drivers/iio/adc/ad7298.c          | 5 +++--
 drivers/iio/adc/ad7380.c          | 5 +++--
 drivers/iio/adc/ad7476.c          | 4 ++--
 drivers/iio/adc/ad7606.c          | 4 ++--
 drivers/iio/adc/ad7768-1.c        | 5 +++--
 drivers/iio/adc/ad7779.c          | 3 ++-
 drivers/iio/adc/ad7923.c          | 4 ++--
 drivers/iio/adc/dln2-adc.c        | 4 ++--
 drivers/iio/adc/ina2xx-adc.c      | 3 ++-
 drivers/iio/adc/max1118.c         | 2 +-
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
 drivers/iio/adc/vf610_adc.c       | 7 ++++---
 34 files changed, 74 insertions(+), 60 deletions(-)

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
index 7fef2727f89e..e681a2120abb 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -87,8 +87,9 @@ static irqreturn_t ad7266_trigger_handler(int irq, void *p)
 
 	ret = spi_read(st->spi, st->data.sample, 4);
 	if (ret == 0) {
-		iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
-			    pf->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, &st->data,
+					    sizeof(st->data),
+					    pf->timestamp);
 	}
 
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 28b88092b4aa..def5f91dc343 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -155,8 +155,9 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 	if (b_sent)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, st->rx_buf,
+				    sizeof(st->rx_buf),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 4fcb49fdf566..2aacc74b1994 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1328,8 +1328,9 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan_data,
+				    sizeof(st->scan_data),
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
index 60a4e599af1f..dccb26010517 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -594,8 +594,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
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
index 5e0be36af0c5..127867f0c9e4 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -474,8 +474,9 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
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
index 40d14faa71c5..9a1a7749624b 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -766,7 +766,8 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 		chip->scan.chan[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &chip->scan, time);
+	iio_push_to_buffers_with_ts(indio_dev, &chip->scan, sizeof(chip->scan),
+				    time);
 
 	return 0;
 };
diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 565ca2e21c0c..e140fa30a385 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -188,7 +188,7 @@ static irqreturn_t max1118_trigger_handler(int irq, void *p)
 		adc->scan.channels[i] = ret;
 		i++;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
+	iio_push_to_buffers_with_ts(indio_dev, &adc->scan, sizeof(adc->scan),
 					   iio_get_time_ns(indio_dev));
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
index 35717ec082ce..928c9ab04a4d 100644
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
index beb5511c4504..d8fcad514ec4 100644
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
index 5dbf5f136768..32e7938b3892 100644
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
index 77c299bb4ebc..d068b6e71be4 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -297,8 +297,8 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer,
-			pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, priv->buffer,
+				    sizeof(priv->buffer), pf->timestamp);
 
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
index 1e4a78677fe5..1fc2fe91a206 100644
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
index f506ca4150b1..a67da9dd1811 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -592,9 +592,10 @@ static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
 		info->value = vf610_adc_read_data(info);
 		if (iio_buffer_enabled(indio_dev)) {
 			info->scan.chan = info->value;
-			iio_push_to_buffers_with_timestamp(indio_dev,
-					&info->scan,
-					iio_get_time_ns(indio_dev));
+			iio_push_to_buffers_with_ts(indio_dev,
+						    &info->scan,
+						    sizeof(info->scan),
+						    iio_get_time_ns(indio_dev));
 			iio_trigger_notify_done(indio_dev->trig);
 		} else
 			complete(&info->completion);
-- 
2.49.0


