Return-Path: <linux-iio+bounces-11027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6FE9AD60E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E841F21236
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 21:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02D71FF7AD;
	Wed, 23 Oct 2024 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hvptctuZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24C1FDFA3
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717180; cv=none; b=NJrX3dtXv00sl6D8JpPavPd80m0Cax4E8D1HTZcTlG0uTbtic9z9ZYF5eL9MaSiKhBkTIK9FzOVk3Jv399VmfB9EqExm8EQcX5h1pbMSygW5LimuwVB9KDwVFKZ1er/YVItya+3AiIMSLAEJhoPnZvNqUor3qtfBzNZQyd6FVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717180; c=relaxed/simple;
	bh=9Uoi/lsx5lDzmesX/dTqmB11w7iIVMU2MC+rAN+Xo0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrTNNDoSMSkegKKUoRwIWNZPyhDqHKGNNMWni6mX9EENNMHWpKTcLGSS0zAMTG/GzUjKPcJKNpbLuG05LbH9gsB8ttLK4CqxNzOGlZFW6XE/PlV4dxDsQcqDfc2qG9O2sjC+XHqyDd746db6whbLHdPp5vTkmY27YuFcKt0BkY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hvptctuZ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e5b5715607so131305eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717177; x=1730321977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJpBAkzSSYPV4RvQhjaw2/1DFd2kkl7hVgMR3+qjlgE=;
        b=hvptctuZQ5a5qjfBFSAo2mQX4Dubo1Q1glMKG2CfM3Y6QPqO8RZulJVrHr1fvWu7aj
         oqWvuydKGganITgmZoH+ssSdHVvszZ6xGtCQpAZ0P+tpoe/LlwvtR3zufBE6aat3GPAO
         vHoD3hCzUYLx1CfnlYZQKmKafxyFQC3ZfMiGQUkFVcWKxZZhGlfC5AP69LTa+bK0x3A4
         HiyMmkZf/GDBWWnwAt33PvLKY0KaZ9ZF3K4U6WGU3Gqwzrh3jb2D4+ijjZuRL/nVNLtB
         ux77Pc2/7OS5VT9v6/WdY8j+Wno/8MJ2D+kicx8WkJts4iJQAf3EzsStXR4ErjqmVcot
         1UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717177; x=1730321977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJpBAkzSSYPV4RvQhjaw2/1DFd2kkl7hVgMR3+qjlgE=;
        b=biKoSnhjAMB6DJOYhOQVuH99ToRqYSNcQySaW+0/xYsjDY6XzIoyjmMRueiBGhoZWg
         otIn34WKssYEcxn89582SOI46WhmRu7/6AtPz4yuYYyTEweX/gl57lLdu3Sc1VJIoARv
         tscQmUvqEfwtt0qsU88857jZbIoU24ApH2zGCnOf5NpxDN3y1T+y419qGcmH5d4P6mE3
         hDpUods9Ck6VkB/A5UKJDQzASu40Lk3rK74RZJaFMH3eRSriH2dz5ZASn/A4J7GPc38L
         VE0gfzFWQnHBRK1lREaX8ztrv0YqVcGpmlzbWvvz74D3YtwqeetI3sezEi1lXVT4BTjf
         sjaA==
X-Forwarded-Encrypted: i=1; AJvYcCUtghsdKVk+lQloRHLJbQigK0aK7USvaFrIUkvXcLRdjkpKF6xbFZSilcvAYotLYr2pyH6e7v5k2To=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomONezpoyrTf30wRMRpjhm2H8d1L90TqTSIFa4/E3+VkBTDq0
	9QQ/HABsUWAWGiyUz6fzJ4wB3VNnXclBJORij1x1UibnYY1exBnA0S657MNlsQw=
X-Google-Smtp-Source: AGHT+IHhgz4z/pNzeGgfxd28esWvpBib5iH9I1o0u1Snz5WDz9JUClIdWIVkcf1KuO2G++R03tqq+Q==
X-Received: by 2002:a05:6820:608:b0:5eb:c72e:e29f with SMTP id 006d021491bc7-5ebee0753aemr2275209eaf.1.1729717176874;
        Wed, 23 Oct 2024 13:59:36 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:14 -0500
Subject: [PATCH RFC v4 07/15] spi: add offload TX/RX streaming APIs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-7-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Most configuration of SPI offloads is handled opaquely using the offload
pointer that is passed to the various offload functions. However, there
are some offload features that need to be controlled on a per transfer
basis.

This patch adds a flag field to struct spi_transfer to allow specifying
such features. The first feature to be added is the ability to stream
data to/from a hardware sink/source rather than using a tx or rx buffer.
Additional flags can be added in the future as needed.

A flags field is also added to the offload struct for providers to
indicate which flags are supported. This allows for generic checking of
offload capabilities during __spi_validate() so that each offload
provider doesn't have to implement their own validation.

As a first users of this streaming capability, getter functions are
added to get a DMA channel that is directly connected to the offload.
Peripheral drivers will use this to get a DMA channel and configure it
to suit their needs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* DMA API's now automatically release DMA channels instead of leaving
  it up to the caller.

v3 changes:
* Added spi_offload_{tx,rx}_stream_get_dma_chan() functions.

v2 changes:
* This is also split out from "spi: add core support for controllers with
  offload capabilities".
* In the previous version, we were using (void *)-1 as a sentinel value
  that could be assigned, e.g. to rx_buf. But this was naive since there
  is core code that would try to dereference this pointer. So instead,
  we've added a new flags field to the spi_transfer structure for this
  sort of thing. This also has the advantage of being able to be used in
  the future for other arbitrary features.
---
 drivers/spi/spi-offload.c       | 76 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c               | 10 ++++++
 include/linux/spi/spi-offload.h | 24 +++++++++++++
 include/linux/spi/spi.h         |  3 ++
 4 files changed, 113 insertions(+)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 2a1f9587f27a..dd4cb3c2e985 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -8,6 +8,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/export.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -282,6 +283,81 @@ void spi_offload_trigger_disable(struct spi_offload *offload,
 }
 EXPORT_SYMBOL_GPL(spi_offload_trigger_disable);
 
+static void spi_offload_release_dma_chan(void *chan)
+{
+	dma_release_channel(chan);
+}
+
+/**
+ * spi_offload_tx_stream_request_dma_chan_info - Get the DMA channel info for the TX stream
+ * @spi: SPI device
+ * @id: Function ID if SPI device uses more than one offload or NULL.
+ *
+ * This is the DMA channel that will provide data to transfers that use the
+ * %SPI_OFFLOAD_XFER_TX_STREAM offload flag.
+ *
+ * The caller is responsible for calling spi_offload_free_dma_chan_info() on the
+ * returned pointer.
+ *
+ * Return: Pointer to DMA channel info, or negative error code
+ */
+struct dma_chan
+*devm_spi_offload_tx_stream_request_dma_chan(struct device *dev,
+					     struct spi_offload *offload)
+{
+	struct dma_chan *chan;
+	int ret;
+
+	if (!offload->ops || !offload->ops->tx_stream_request_dma_chan)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	chan = offload->ops->tx_stream_request_dma_chan(offload);
+	if (IS_ERR(chan))
+		return chan;
+
+	ret = devm_add_action_or_reset(dev, spi_offload_release_dma_chan, chan);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_tx_stream_request_dma_chan);
+
+/**
+ * spi_offload_rx_stream_request_dma_chan_info - Get the DMA channel info for the RX stream
+ * @spi: SPI device
+ * @id: Function ID if SPI device uses more than one offload or NULL.
+ *
+ * This is the DMA channel that will receive data from transfers that use the
+ * %SPI_OFFLOAD_XFER_RX_STREAM offload flag.
+ *
+ * The caller is responsible for calling spi_offload_free_dma_chan_info() on the
+ * returned pointer.
+ *
+ * Return: Pointer to DMA channel info, or negative error code
+ */
+struct dma_chan
+*devm_spi_offload_rx_stream_request_dma_chan(struct device *dev,
+					     struct spi_offload *offload)
+{
+	struct dma_chan *chan;
+	int ret;
+
+	if (!offload->ops || !offload->ops->rx_stream_request_dma_chan)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	chan = offload->ops->rx_stream_request_dma_chan(offload);
+	if (IS_ERR(chan))
+		return chan;
+
+	ret = devm_add_action_or_reset(dev, spi_offload_release_dma_chan, chan);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_rx_stream_request_dma_chan);
+
 /* Triggers providers */
 
 static void spi_offload_trigger_dev_release(struct device *dev)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7c5e76b15421..cb6184c0ae03 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -31,6 +31,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/sched/rt.h>
 #include <linux/slab.h>
+#include <linux/spi/spi-offload.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <uapi/linux/sched/types.h>
@@ -4159,6 +4160,15 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 		if (_spi_xfer_word_delay_update(xfer, spi))
 			return -EINVAL;
+
+		/* make sure controller supports required offload features */
+		if (xfer->offload_flags) {
+			if (!message->offload)
+				return -EINVAL;
+
+			if (xfer->offload_flags & ~message->offload->xfer_flags)
+				return -EINVAL;
+		}
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi-offload.h b/include/linux/spi/spi-offload.h
index 561cc1fb6f35..5d0e29b25977 100644
--- a/include/linux/spi/spi-offload.h
+++ b/include/linux/spi/spi-offload.h
@@ -25,6 +25,11 @@ struct device;
 struct fwnode_handle;
 struct spi_device;
 
+/* This is write xfer but TX uses external data stream rather than tx_buf. */
+#define SPI_OFFLOAD_XFER_TX_STREAM	BIT(0)
+/* This is read xfer but RX uses external data stream rather than rx_buf. */
+#define SPI_OFFLOAD_XFER_RX_STREAM	BIT(1)
+
 /* Offload can be triggered by external hardware event. */
 #define SPI_OFFLOAD_CAP_TRIGGER			BIT(0)
 /* Offload can record and then play back TX data when triggered. */
@@ -56,6 +61,8 @@ struct spi_offload {
 	void *priv;
 	/** @ops: callbacks for offload support */
 	const struct spi_offload_ops *ops;
+	/** @xfer_flags: %SPI_OFFLOAD_XFER_* flags supported by provider */
+	u32 xfer_flags;
 };
 
 enum spi_offload_trigger_type {
@@ -91,6 +98,18 @@ struct spi_offload_ops {
 	 * given offload instance.
 	 */
 	void (*trigger_disable)(struct spi_offload *offload);
+	/**
+	 * @tx_stream_request_dma_chan: Optional callback for controllers that
+	 * have an offload where the TX data stream is connected directly to a
+	 * DMA channel.
+	 */
+	struct dma_chan *(*tx_stream_request_dma_chan)(struct spi_offload *offload);
+	/**
+	 * @rx_stream_request_dma_chan: Optional callback for controllers that
+	 * have an offload where the RX data stream is connected directly to a
+	 * DMA channel.
+	 */
+	struct dma_chan *(*rx_stream_request_dma_chan)(struct spi_offload *offload);
 };
 
 struct spi_offload *devm_spi_offload_alloc(struct device *dev,
@@ -111,6 +130,11 @@ int spi_offload_trigger_enable(struct spi_offload *offload,
 void spi_offload_trigger_disable(struct spi_offload *offload,
 				 struct spi_offload_trigger *trigger);
 
+struct dma_chan *devm_spi_offload_tx_stream_request_dma_chan(struct device *dev,
+							     struct spi_offload *offload);
+struct dma_chan *devm_spi_offload_rx_stream_request_dma_chan(struct device *dev,
+							     struct spi_offload *offload);
+
 /* Trigger providers */
 
 struct spi_offload_trigger;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c230d6a209ee..fbb8b2d0b5ea 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1092,6 +1092,9 @@ struct spi_transfer {
 
 	u32		effective_speed_hz;
 
+	/* Use %SPI_OFFLOAD_XFER_* from spi-offload.h */
+	unsigned int	offload_flags;
+
 	unsigned int	ptp_sts_word_pre;
 	unsigned int	ptp_sts_word_post;
 

-- 
2.43.0


