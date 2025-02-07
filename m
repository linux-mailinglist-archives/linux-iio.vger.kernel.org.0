Return-Path: <linux-iio+bounces-15136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2115A2CDAA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89353188DBFB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338911B4250;
	Fri,  7 Feb 2025 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KWWYFPLU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06EC1ACEDF
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958975; cv=none; b=YU2iSmEDk/kISXqDAR85hUE2FlmrytulQ8/LqIZVmgK3IK1WN3Ftunne6AsKHx0kyTNwi7LLpI/wGw4FNDN1y+kkzedfcK+7xu5SygioECGOW4owwL+Efdxj1w1v7kIqgMQKH7YI1vI3oCUxiTF4jFxfdO6B9lewKPKQkDDOS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958975; c=relaxed/simple;
	bh=ksRH+xsE5ndXaOQbEaFG6Nxn71f/QpIEGr1SY3yQYAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Arc5XHNNU0TG21nhMMQNzJHkvoxWumYt+n4i6gMbrjVgISaP9wEnLhXlKUX51YPfJa3nO6OAk5Bw+RpKrPzbdyYsTx0iLStjBb2fTmq3aMj3Szi9YCOduzg2V2ABimZIgQpSOJpROrAOniJhOs5xwzyuyLtDwFptYyxID5Bc8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KWWYFPLU; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-724a5d0427fso1729733a34.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958973; x=1739563773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeedPY/yxMeILi8lrC5AeC6wSQDrSEJfG5XlwStWNys=;
        b=KWWYFPLUmmqfSok6BJCoqi4aTCRDPEoFOPYzQ5/JJRtW86uqzeeqQea+G3Btb9vWBe
         uRSELTmj8Sz17nkBX6SOOtqMUSz0aN8p7vxLd+clI1vVArWtuRZqQqrn7FaQ3QDCi/4B
         2QLQA9LsIZS8RQxjUmxmX9zUE+jVYFrR86qizPvhobIKgfff5OPEp9MHrejvGmSuFTTa
         K91RlFzm9OsQ8Adyhj+JwL15rLAT1BK86ZIy7rm73bbeJtZc2GMwIR69jfypXBvy2OzM
         6FvcQQL7bZGWA/AjixBEkwf0SBjxSFdsN5/sn1I8Smjz5N035hKgNOwa/Xo7mqtKc4HL
         fjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958973; x=1739563773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeedPY/yxMeILi8lrC5AeC6wSQDrSEJfG5XlwStWNys=;
        b=jVj4sziO+/RNe76pqLR5xsswWFppJ2/xgHgB0Bu0U20uK+fpg/hYktAcuRN5eT2e8A
         vdZ6OCHdAoukNuALy5lLcoi/XWIEmTlfgrNtMUSWcGYUNzScZBnfDeYBcPVSLpz3epAu
         kHnuFZRB7eFpXlvjN2sP6FYPwS3q9d2/KfbYuSj0b+G71FSKKX+9O/PZ41dOr30gD423
         z7R7uHzoHpF9CgUsfwNIxbjRJcqhaQ3q/kzFHdqj1dbhUbcEybDWp9725bZTg1+x5tDj
         nKg0Ho1emmTQ01l2m5VcOYte2IUPDBn0PPbHHliD3JCp+E2RALIrECQUEKKnPJLbj8l4
         Elfw==
X-Forwarded-Encrypted: i=1; AJvYcCVse3k7iu9vwf6gYPrunRbu2//LVZjza3GxN44qf7rzo9hXWUH0nsziB1Inez+ysAYoSMmufIc7AtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBhZnTRLCQIayfS/UgWII6A5AI99EWII1Eq7GgwjwVSPinisv
	FH/oYlQ62Be3us+vdo08Kec4vnWRZb7dfaWg6RqfgRRoRsFp8bpQGCuOQ3NhBXo=
X-Gm-Gg: ASbGncsh6hm4WaB9JN68+QQJJhq8A63++dCafAYUYVG8C0YxdK6Y+KCjOunM+3TSM0Q
	Da8Xqnbj/yaqM3nR6bb3gA+6JbQ8D8lc3oEQb0XEpTfcJPSdmAvNtFBZnijyLw+dmOI+PIj/GrG
	cYQCiANUnvW5QZm6khmnQCrXRx6iJXKfIqeJM62uKojoJAYjynTJXsJyDmENKCQwoXWZ8WNAKBI
	OEVjR9MpLivIGhPsZyUo2Hw0nNYNJyhd5Lf5A4gk9RevWjgf82ozF/1/0h7RQxq70Us2vRqsUCd
	ieLABg8SeNGMuizEmNUvigDNI1sdrtxu7MuBVnrbw3cBOtk=
X-Google-Smtp-Source: AGHT+IE1ryxCotw0T1fE7BhGPd527F38UG/3XYjYBlRBCNfoaSyKJg91agbDLZBdJ6cr3rXIY1UsWQ==
X-Received: by 2002:a05:6830:7001:b0:71d:de27:8d32 with SMTP id 46e09a7af769-726b87b457bmr3273826a34.2.1738958972882;
        Fri, 07 Feb 2025 12:09:32 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:32 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:02 -0600
Subject: [PATCH v8 05/17] spi: add offload TX/RX streaming APIs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-5-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Update for header file split.
* Fix wrong kernel-doc comments.

v5 change:
* Remove incorrect comment about caller needing to release DMA channels.

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
 drivers/spi/spi-offload.c            | 70 ++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c                    | 10 ++++++
 include/linux/spi/offload/consumer.h |  5 +++
 include/linux/spi/offload/types.h    | 19 ++++++++++
 include/linux/spi/spi.h              |  3 ++
 5 files changed, 107 insertions(+)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 43582e50e279c4b1b958765fec556aaa91180e55..df5e963d5ee29d37833559595536a460c530bc81 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -18,6 +18,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/export.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -332,6 +333,75 @@ void spi_offload_trigger_disable(struct spi_offload *offload,
 }
 EXPORT_SYMBOL_GPL(spi_offload_trigger_disable);
 
+static void spi_offload_release_dma_chan(void *chan)
+{
+	dma_release_channel(chan);
+}
+
+/**
+ * devm_spi_offload_tx_stream_request_dma_chan - Get the DMA channel info for the TX stream
+ * @dev: Device for devm purposes.
+ * @offload: Offload instance
+ *
+ * This is the DMA channel that will provide data to transfers that use the
+ * %SPI_OFFLOAD_XFER_TX_STREAM offload flag.
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
+ * devm_spi_offload_rx_stream_request_dma_chan - Get the DMA channel info for the RX stream
+ * @dev: Device for devm purposes.
+ * @offload: Offload instance
+ *
+ * This is the DMA channel that will receive data from transfers that use the
+ * %SPI_OFFLOAD_XFER_RX_STREAM offload flag.
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
 
 static void spi_offload_trigger_unregister(void *data)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 68e6758771681bf272314a76b4b600f48e37f7c5..6d63ec291e88cc852fa1160e59ad3de70fdfc396 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -31,6 +31,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/sched/rt.h>
 #include <linux/slab.h>
+#include <linux/spi/offload/types.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <uapi/linux/sched/types.h>
@@ -4155,6 +4156,15 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 		if (_spi_xfer_word_delay_update(xfer, spi))
 			return -EINVAL;
+
+		/* Make sure controller supports required offload features. */
+		if (xfer->offload_flags) {
+			if (!message->offload)
+				return -EINVAL;
+
+			if (xfer->offload_flags & ~message->offload->xfer_flags)
+				return -EINVAL;
+		}
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/offload/consumer.h b/include/linux/spi/offload/consumer.h
index 5a0ec5303d600728959594bcdbd0cb2baeba7c77..cd7d5daa21e69b61c16eba6c10c855345a4f3297 100644
--- a/include/linux/spi/offload/consumer.h
+++ b/include/linux/spi/offload/consumer.h
@@ -31,4 +31,9 @@ int spi_offload_trigger_enable(struct spi_offload *offload,
 void spi_offload_trigger_disable(struct spi_offload *offload,
 				 struct spi_offload_trigger *trigger);
 
+struct dma_chan *devm_spi_offload_tx_stream_request_dma_chan(struct device *dev,
+							     struct spi_offload *offload);
+struct dma_chan *devm_spi_offload_rx_stream_request_dma_chan(struct device *dev,
+							     struct spi_offload *offload);
+
 #endif /* __LINUX_SPI_OFFLOAD_CONSUMER_H */
diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
index 7476f2073b02ee0f9edd3ae75e587b075746fa92..86d0e8cb9495bb43e177378b2041067de8ea8786 100644
--- a/include/linux/spi/offload/types.h
+++ b/include/linux/spi/offload/types.h
@@ -11,6 +11,11 @@
 
 struct device;
 
+/* This is write xfer but TX uses external data stream rather than tx_buf. */
+#define SPI_OFFLOAD_XFER_TX_STREAM	BIT(0)
+/* This is read xfer but RX uses external data stream rather than rx_buf. */
+#define SPI_OFFLOAD_XFER_RX_STREAM	BIT(1)
+
 /* Offload can be triggered by external hardware event. */
 #define SPI_OFFLOAD_CAP_TRIGGER			BIT(0)
 /* Offload can record and then play back TX data when triggered. */
@@ -40,6 +45,8 @@ struct spi_offload {
 	void *priv;
 	/** @ops: callbacks for offload support */
 	const struct spi_offload_ops *ops;
+	/** @xfer_flags: %SPI_OFFLOAD_XFER_* flags supported by provider */
+	u32 xfer_flags;
 };
 
 enum spi_offload_trigger_type {
@@ -75,6 +82,18 @@ struct spi_offload_ops {
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
 
 #endif /* __LINUX_SPI_OFFLOAD_TYPES_H */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 98bdc8c16c20521c0a94e5f72f5e71c4f6d7d11e..4c087009cf974595f23036b1b7a030a45913420c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1093,6 +1093,9 @@ struct spi_transfer {
 
 	u32		effective_speed_hz;
 
+	/* Use %SPI_OFFLOAD_XFER_* from spi-offload.h */
+	unsigned int	offload_flags;
+
 	unsigned int	ptp_sts_word_pre;
 	unsigned int	ptp_sts_word_post;
 

-- 
2.43.0


