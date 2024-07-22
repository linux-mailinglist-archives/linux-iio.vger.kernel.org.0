Return-Path: <linux-iio+bounces-7810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D052E939630
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 00:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF051F21015
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4226D12D1E8;
	Mon, 22 Jul 2024 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sYSgEzQU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969B5FEED
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685696; cv=none; b=oPC/yua8kBM8BJ9gBWSILu3tt4PsHU3J9WDLUO46gnJVhynJiXu7Tcpsy8V6Yfv8PHqvf6wZNn5Nc0co/8VUlmZ5DCX6WJbylAonQSBku046q/Zs/Nz9+cmWmMgITc1xp3Md/jTka7mpbbUX+oTAznoC0DjjnpFfBzKs/zSiHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685696; c=relaxed/simple;
	bh=i5fq6dLu/xqxt+O3YmVoa2/fRQ4pONuNiDxOd0O+2Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRlB4Gh5h9u0+lBklb1fjfYl7XScsB6gDLxadKDUimG9Gfiey56avS283gwQ7D10i0mOejTT9ZMuoDP7+snl+Z0FJdNwL3wp5jjyKpAXda+wr1HxlW25oT9WA8KzM8S2EtttzfD9CnIP3/eQJ0Q8ZVQr2aknNM3EVqVuXxV9hD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sYSgEzQU; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-260e12aac26so2866604fac.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685692; x=1722290492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUzyivP6VRGWHx7tYSGIOnQeCUO67RlyYPuJMRsarok=;
        b=sYSgEzQUaPhQlhgxExvZTEhKkqmTexrzn9x01IiClSRZ820BO/6Kzdb3KPXzNrbuPY
         G8cFs+ptsK/i0KwoM6wC+X9/KKty848/XxoFyEbwFe52tii4iX42KLoXuWxlrQBGavuz
         YkeOmkPS2imnqmlda6mJoZgybW6kxu+jEnMuZw4QY8bc0gQIQhoD3nqVjHVKLyiogpyc
         1k/qr6Z2EU52AOkTDlvU7KLGjzc3cqVOGXvUx6lbeoJ3m8LABmOQcLRULNL0NGpih1qo
         Dks7RtJTKGvsmW+UakR8zHDG2l7NO5FZqz/7QkWSCGf9xTrA9ZnGJU83EAxfHlyOzNrq
         /rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685692; x=1722290492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUzyivP6VRGWHx7tYSGIOnQeCUO67RlyYPuJMRsarok=;
        b=sDkYTFwgjp/P57ECcVbBf7nhvMYBFfWlj8kP7C0JP2pzXlNagoi2OeuQuew6xC8PW7
         7CSmMPXdEikfZghU66SfoTcAiqKfmnnfLG5u690bnCnVCHQr771Mj9D6ZzVFXMDjP5Em
         KscSeWj9vQEkGQuVqIVc4Id2/kkO7DiooXXU1DLB8dTwLOKEuQU4mX73hB8SjUJU8mcR
         1E4sf5HzpeGWmuLScvX1JlSVmhnDEbXk+KUTNKkTrCNcttnBnvM3qFvpRiPAVt+VhlvN
         l7lpCJA66qJR8NHLxu4LqeFHuF+bQOwfdoVSMmYAFnZlMvhbMzwTxi5x6g6RcTZmOHYg
         6uwA==
X-Forwarded-Encrypted: i=1; AJvYcCXma6d7XGhVG7SejNmsKVWvsQ76zVrBaGCjKYpqTbTO+cmy+mWdO32QAUigJ1QuRtnCCQ/nN2fBmj0TiJtTkfM2QzGzS/k/4I8Q
X-Gm-Message-State: AOJu0YzD42jjp09eph19gY1TgjNkwt6UJziBVG05IDIAVn6qizQeSJF/
	4NgfrHiAcBvnyeeN787TNEuHy4TgquG/SLbTErf1K7bpTmKfqmxXiYgjs1BS5axGiNKIqM3ZcRe
	t
X-Google-Smtp-Source: AGHT+IG5zMAelzP4qmAGblsSVB30TFvvH9JUw3U45Gd0sjE2FY39ATDcxmH98Vjz6qqSktUc2PQf+A==
X-Received: by 2002:a05:6870:a10d:b0:260:e093:ff8d with SMTP id 586e51a60fabf-264692a6d2cmr912634fac.45.1721685692314;
        Mon, 22 Jul 2024 15:01:32 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v3 7/9] iio: buffer-dmaengine: generalize requesting DMA channel
Date: Mon, 22 Jul 2024 16:57:14 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-7-7420e45df69b@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This patch generalizes the iio_dmaengine_buffer_setup_ext() functions
by passing the pointer to the DMA channel as an argument rather than
the channel name. This will allow future callers of the function to
use other methods to get the DMA channel pointer.

This aims to keep it as easy to use as possible by stealing ownership
of the dma_chan pointer from the caller. This way, dma_request_chan()
can be called inline in the function call without any extra error
handling.

Signed-off-by: David Lechner <dlechner@baylibre.com>

v3 changes:
* This is a new patch in v3.
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 39 +++++++++++++---------
 drivers/iio/dac/adi-axi-dac.c                      |  3 +-
 include/linux/iio/buffer-dmaengine.h               | 11 +++---
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 918f6f8d65b6..44c3b4fe0643 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -163,32 +163,34 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
 /**
  * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DMAengine
  * @dev: Parent device for the buffer
- * @channel: DMA channel name, typically "rx".
+ * @chan: DMA channel.
  *
  * This allocates a new IIO buffer which internally uses the DMAengine framework
  * to perform its transfers. The parent device will be used to request the DMA
  * channel.
  *
+ * This "steals" the @chan pointer, so the caller must not call
+ * dma_release_channel() on it. @chan is also checked for error, so callers
+ * can pass the result of dma_request_chan() directly.
+ *
  * Once done using the buffer iio_dmaengine_buffer_free() should be used to
  * release it.
  */
 static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel)
+						     struct dma_chan *chan)
 {
 	struct dmaengine_buffer *dmaengine_buffer;
 	unsigned int width, src_width, dest_width;
 	struct dma_slave_caps caps;
-	struct dma_chan *chan;
 	int ret;
 
-	dmaengine_buffer = kzalloc(sizeof(*dmaengine_buffer), GFP_KERNEL);
-	if (!dmaengine_buffer)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(chan))
+		return ERR_CAST(chan);
 
-	chan = dma_request_chan(dev, channel);
-	if (IS_ERR(chan)) {
-		ret = PTR_ERR(chan);
-		goto err_free;
+	dmaengine_buffer = kzalloc(sizeof(*dmaengine_buffer), GFP_KERNEL);
+	if (!dmaengine_buffer) {
+		ret = -ENOMEM;
+		goto err_release;
 	}
 
 	ret = dma_get_slave_caps(chan, &caps);
@@ -221,6 +223,9 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 err_free:
 	kfree(dmaengine_buffer);
+err_release:
+	dma_release_channel(chan);
+
 	return ERR_PTR(ret);
 }
 
@@ -244,13 +249,13 @@ EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
 
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 						  struct iio_dev *indio_dev,
-						  const char *channel,
+						  struct dma_chan *chan,
 						  enum iio_buffer_direction dir)
 {
 	struct iio_buffer *buffer;
 	int ret;
 
-	buffer = iio_dmaengine_buffer_alloc(dev, channel);
+	buffer = iio_dmaengine_buffer_alloc(dev, chan);
 	if (IS_ERR(buffer))
 		return ERR_CAST(buffer);
 
@@ -277,22 +282,26 @@ static void __devm_iio_dmaengine_buffer_free(void *buffer)
  * devm_iio_dmaengine_buffer_setup_ext() - Setup a DMA buffer for an IIO device
  * @dev: Parent device for the buffer
  * @indio_dev: IIO device to which to attach this buffer.
- * @channel: DMA channel name, typically "rx".
+ * @chan: DMA channel.
  * @dir: Direction of buffer (in or out)
  *
  * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
  * and attaches it to an IIO device with iio_device_attach_buffer().
  * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
  * IIO device.
+ *
+ * This "steals" the @chan pointer, so the caller must not call
+ * dma_release_channel() on it. @chan is also checked for error, so callers
+ * can pass the result of dma_request_chan() directly.
  */
 int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
-					const char *channel,
+					struct dma_chan *chan,
 					enum iio_buffer_direction dir)
 {
 	struct iio_buffer *buffer;
 
-	buffer = iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel, dir);
+	buffer = iio_dmaengine_buffer_setup_ext(dev, indio_dev, chan, dir);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 880d83a014a1..7e6225920e49 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -124,7 +124,8 @@ static struct iio_buffer *axi_dac_request_buffer(struct iio_backend *back,
 	if (device_property_read_string(st->dev, "dma-names", &dma_name))
 		dma_name = "tx";
 
-	return iio_dmaengine_buffer_setup_ext(st->dev, indio_dev, dma_name,
+	return iio_dmaengine_buffer_setup_ext(st->dev, indio_dev,
+					      dma_request_chan(st->dev, dma_name),
 					      IIO_BUFFER_DIRECTION_OUT);
 }
 
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 81d9a19aeb91..a80397c3b198 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -7,6 +7,7 @@
 #ifndef __IIO_DMAENGINE_H__
 #define __IIO_DMAENGINE_H__
 
+#include <linux/dmaengine.h>
 #include <linux/iio/buffer.h>
 
 struct iio_dev;
@@ -15,20 +16,22 @@ struct device;
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
 						  struct iio_dev *indio_dev,
-						  const char *channel,
+						  struct dma_chan *chan,
 						  enum iio_buffer_direction dir);
 
 #define iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
-	iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
+	iio_dmaengine_buffer_setup_ext(dev, indio_dev,		\
+				       dma_request_chan(dev, channel),\
 				       IIO_BUFFER_DIRECTION_IN)
 
 int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
-					const char *channel,
+					struct dma_chan *chan,
 					enum iio_buffer_direction dir);
 
 #define devm_iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
-	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
+	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev,		\
+					    dma_request_chan(dev, channel), \
 					    IIO_BUFFER_DIRECTION_IN)
 
 #endif

-- 
2.43.0


