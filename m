Return-Path: <linux-iio+bounces-16631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E15A58725
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E154216A3D3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEBA1F8751;
	Sun,  9 Mar 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chmJ9+u5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF461F874A
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544511; cv=none; b=gCzBGewwpUdYao7mFoeqPWikL7lSp08y/9N/zjVZDaadNtSDH/6jaAAdj+4/Lv6nywrQHbleqllKE7bIkG15+zac8Ud7lfc0pJFG8t1nsLrX4iIOa9vX/VtLk52EzFT2H/3nMNzfOinbt4U2O8sZu4D0jc/irGS8R29kzIm4OxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544511; c=relaxed/simple;
	bh=KJ1lOZhXzYISJ+s/1AaLUpNs7BbtsbL4OjNNItZQDho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD0l62HFWXgtZ86JRLkOsImlMdcVQ6FNt+u/a9gpAahm6ab7NuPJ0qnIk2F9SURuPUpk6MXtQNxcT/93EeXJNbJgN3ozCa0vQkzb192+j+oyXKdCYDJnz9tiRxOcE4tNP68XHuT8RdIoQOZSG5KSKm0/zQHPZCmPyPS0Gl3xFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chmJ9+u5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097ECC4CEE5;
	Sun,  9 Mar 2025 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544510;
	bh=KJ1lOZhXzYISJ+s/1AaLUpNs7BbtsbL4OjNNItZQDho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chmJ9+u5Lc4+tZbKRaz7AIfqihv1xEwYCAHqyxt/ZTknOSN+rB6/+sAbb2Am6wG9E
	 vHN0GF1V5TFaMYmZE5Qs2uuyVc02nptpPelFOacOXzex/V5bEhta9Ue4RH4BXoT8LZ
	 dw+zMLfuPcv39ltv5A7hfqDaiMD0B724Qk7QE+gYRBRnR0W/8c0jIkgFr/rq51lm0P
	 Qm2hXW2oYZFFFr1dVmvTqyzl26RiqZ2ETRGbz9KsBd8cgrHSk/++669z9UQkp2fBdg
	 q2D0TK7Z7U6EbLVV9NphGM5A9usqLRQcjG7xS4DFIaJNDul0sGa26MrVs1V84mOmRg
	 kYSaHy3Z7DKMQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/16] iio: adc: Use iio_push_to_buffers_with_ts() to provide length for runtime checks.
Date: Sun,  9 Mar 2025 18:20:49 +0000
Message-ID: <20250309182100.1351128-6-jic23@kernel.org>
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
 drivers/iio/adc/ad4000.c          | 3 ++-
 drivers/iio/adc/ad4030.c          | 5 +++--
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
 34 files changed, 75 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 4fe8dee48da9..08ceaaafef50 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -645,7 +645,8 @@ static irqreturn_t ad4000_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    pf->timestamp);
 
 err_out:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 9a020680885d..77c5dd414d36 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -706,8 +706,9 @@ static irqreturn_t ad4030_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_data.raw,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, st->rx_data.raw,
+				    sizeof(st->rx_data.raw),
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
index 18559757f908..4217d3963455 100644
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
index 407930f1f5dd..80856d1a4d96 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -962,8 +962,9 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
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
index 631e83717167..3ffa11b2e060 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -679,8 +679,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
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
index 5a863005aca6..4eb586d473ce 100644
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
index a1e48a756a7b..5ffb4b5f5c99 100644
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
index 1c28df132e9f..7c0787741e45 100644
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
index 729977b611ec..2193379c4232 100644
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
index 7dde5713973f..1a3dd2b628a2 100644
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
2.48.1


