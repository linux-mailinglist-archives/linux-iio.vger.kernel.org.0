Return-Path: <linux-iio+bounces-4943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6368C2E07
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 02:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69C42841AD
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 00:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54F168DE;
	Sat, 11 May 2024 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="km0bM8UU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498909461
	for <linux-iio@vger.kernel.org>; Sat, 11 May 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388602; cv=none; b=SxlnmotVpsLoec33EKOaSn95yxH2Xn02SRup6IUOKMBFxEmXJdtcAtRxVKg0u/U7pVbJsWDJtDP+6NYsTJ9b4lK9YWlOVfO5rcQBlo6a/xoKCKab9k96qZZDjgfNannd4fJxqxzAQvQSDixr0g/nxcSV/Llzr5tNYeopnnDz1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388602; c=relaxed/simple;
	bh=BHMojD3X9bY4SHi0jcrxW7Ha4u/3zvtngRqxXFgXZyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUOdR4sdVRC5jqumU34/VZRb+835RMlxY3iZq0lVIoPV5TFZ+fSBxY2bleocpcGVbb7v/kUsiQr18Ic0BK5NMqbCC4JopiOwqm0Dpdn/r0euFzZfzDEGT2esegPgIkzDY7F80TM27923n2EbgC7bT9hLNObpYCbzL/smF2QKGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=km0bM8UU; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b27c5603ddso905388eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715388599; x=1715993399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArLD9QvQN8sa7KIiLAad1A60GsgZ86+t2OLdgGnWFFI=;
        b=km0bM8UUJOi6Az92hpAatdEWngS05loIKia78sDktc0fZL0f2zFWzJn3rNx3oYoo6/
         5+uFKVMhgoNHJ4gV9tVd6/riWPPn/n70/WuSs79lB41t7iwErFSCKq4pX/CBqOXl/yv5
         GUuypa/S1N1RmSBFUllJA2mmOdJBINBtfGBD2RTEdFR6g1cAlAwVbjyVytoKQ29zM9yH
         mQqlAm0CaiK7ABdBWkcDG/ptbZLndKYBVgmQCi/hhZBhQaMN0sSuAi5KOwtTD5Pq2uLQ
         BI/z4+DU4Bd9NLlOqrLftD8Jks4+SHzvKIqBqUuYh4X0xDro0d/IE04kM7fxyjvxOXs9
         WsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388599; x=1715993399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArLD9QvQN8sa7KIiLAad1A60GsgZ86+t2OLdgGnWFFI=;
        b=Ctmo4aMf7HB7hOJ3FnDDGbFFRgpz3LtO63cJhqo30hPtJV57w+V1KwKA9OxpPbwgO6
         Ge3iY7S6cob7xyZxcQ0CaRKr1w619QmxS+Nqz8AKkZk1UfZqRf8HJOfFxgW53C6b87Vs
         PRz/8aUefX8hBOSxgirt7p8YEp1jAIgOx3erWfiJBGMUBcD21Pdtg6z8moEgW2+tEJHM
         uReREFlaeZ7a/ITGkTfygKYdU8xUzHcDFF5bFE3Og0TxmbI+Z4Tdy33BJt6d9r2VquKB
         DlokjNTDuWtSXi8XkOmaOthTZv2ukaiqAsk5pooeqAXnI7gYwapgfI/mdmRQPoowDRRK
         PN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrlLkO+snyCGVr/1c73sOQsYNTBp4tHRuaUmtwhL1mS5C+BF9fw8utR2glLRODSRY348E2m4/VJbDmnYqy1s7OvGLY8esIv2kT
X-Gm-Message-State: AOJu0Ywo2Lrfala6SDk+dNNeV9A23+qZsZ9bPvHoXOFa3hmydbBhJwuS
	rNexrI526PeyKAE0cPQkyTReJUKf5SI2t/XFZFDF3brHwtQRiTkqFaxR05a7rw4=
X-Google-Smtp-Source: AGHT+IF67/09uCWR5zHPVGAVldQwFwFzVymB/igxM1Xhk/7xfxTF3T4a8rb7utqBzvpAVGATVOiRkw==
X-Received: by 2002:a4a:8c08:0:b0:5a4:9977:446b with SMTP id 006d021491bc7-5b2819ad3d5mr3654225eaf.6.1715388599120;
        Fri, 10 May 2024 17:49:59 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b29015a3dbsm321132eaf.46.2024.05.10.17.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 17:49:58 -0700 (PDT)
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
Subject: [PATCH RFC v2 3/8] spi: add support for hardware triggered offload
Date: Fri, 10 May 2024 19:44:26 -0500
Message-ID: <20240510-dlech-mainline-spi-engine-offload-2-v2-3-8707a870c435@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This extends the SPI framework to support hardware triggered offloading.
This allows an arbitrary hardware trigger to be used to start a SPI
transfer that was previously set up with spi_offload_prepare().

Since the hardware trigger can happen at any time, this means the SPI
bus must be reserved for exclusive use as long as the hardware trigger
is enabled. Since a hardware trigger could be enabled indefinitely,
we can't use the existing spi_bus_lock() and spi_bus_unlock() functions,
otherwise this could cause deadlocks. So we introduce a new flag so that
any attempt to lock or use the bus will fail with -EBUSY as long as the
hardware trigger is enabled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:

This is split out from "spi: add core support for controllers with
offload capabilities".

Mark suggested that the standard SPI APIs should be aware that the
hardware trigger is enabled. So I've added some locking for this. Nuno
suggested that this might be overly strict though, and that we should
let each individual controller driver decide what to do. For our use
case though, I think we generally are going to have a single peripheral
on the SPI bus, so this seems like a reasonable starting place anyway.

TODO: Currently, spi_bus_lock() always returns 0, so none of the callers
check the return value. All callers will need to be updated first before
this can be merged.
---
 drivers/spi/spi.c       | 92 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/spi/spi.h | 17 +++++++++
 2 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 54b814cea54c..9ad7b04c26a6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4427,7 +4427,7 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 
 	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
 
-	if (ctlr->bus_lock_flag)
+	if (ctlr->bus_lock_flag || ctlr->offload_hw_trigger_enabled)
 		ret = -EBUSY;
 	else
 		ret = __spi_async(spi, message);
@@ -4572,6 +4572,12 @@ int spi_sync(struct spi_device *spi, struct spi_message *message)
 	int ret;
 
 	mutex_lock(&spi->controller->bus_lock_mutex);
+
+	if (spi->controller->offload_hw_trigger_enabled) {
+		mutex_unlock(&spi->controller->bus_lock_mutex);
+		return -EBUSY;
+	}
+
 	ret = __spi_sync(spi, message);
 	mutex_unlock(&spi->controller->bus_lock_mutex);
 
@@ -4614,7 +4620,7 @@ EXPORT_SYMBOL_GPL(spi_sync_locked);
  * exclusive access is over. Data transfer must be done by spi_sync_locked
  * and spi_async_locked calls when the SPI bus lock is held.
  *
- * Return: always zero.
+ * Return: 0 on success, -EBUSY if the bus is reserved by offload hardware.
  */
 int spi_bus_lock(struct spi_controller *ctlr)
 {
@@ -4622,6 +4628,11 @@ int spi_bus_lock(struct spi_controller *ctlr)
 
 	mutex_lock(&ctlr->bus_lock_mutex);
 
+	if (ctlr->offload_hw_trigger_enabled) {
+		mutex_unlock(&ctlr->bus_lock_mutex);
+		return -EBUSY;
+	}
+
 	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
 	ctlr->bus_lock_flag = 1;
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
@@ -4808,6 +4819,83 @@ void spi_offload_unprepare(struct spi_device *spi, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(spi_offload_unprepare);
 
+/**
+ * spi_offload_hw_trigger_enable - enables hardware trigger for offload
+ * @spi:	The spi device to use for the transfers.
+ * @id:		Unique identifier for SPI device with more than one offload.
+ *
+ * There must be a prepared offload instance with the specified ID (i.e.
+ * spi_offload_prepare() was called with the same ID). This will also reserve
+ * the bus for exclusive use by the offload instance until the hardware trigger
+ * is disabled. Any other attempts to send a transfer or lock the bus will fail
+ * with -EBUSY during this time.
+ *
+ * Calls must be balanced with spi_offload_hw_trigger_disable().
+ *
+ * Context: can sleep
+ * Return: 0 on success, else a negative error code.
+ */
+int spi_offload_hw_trigger_enable(struct spi_device *spi, unsigned int id)
+{
+	struct spi_controller *ctlr = spi->controller;
+	unsigned long flags;
+	int ret;
+
+	if (!ctlr->offload_ops || !ctlr->offload_ops->hw_trigger_enable)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&ctlr->bus_lock_mutex);
+
+	if (ctlr->offload_hw_trigger_enabled) {
+		mutex_unlock(&ctlr->bus_lock_mutex);
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
+	ctlr->offload_hw_trigger_enabled = true;
+	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
+
+	/* TODO: how to wait for empty message queue? */
+
+	mutex_lock(&ctlr->io_mutex);
+	ret = ctlr->offload_ops->hw_trigger_enable(spi, id);
+	mutex_unlock(&ctlr->io_mutex);
+
+	if (ret) {
+		ctlr->offload_hw_trigger_enabled = false;
+		mutex_unlock(&ctlr->bus_lock_mutex);
+		return ret;
+	}
+
+	mutex_unlock(&ctlr->bus_lock_mutex);
+
+	return 0;
+}
+
+/**
+ * spi_offload_hw_trigger_disable - disables hardware trigger for offload
+ * @spi:	The same SPI device passed to spi_offload_hw_trigger_enable()
+ * @id:		The same ID device passed to spi_offload_hw_trigger_enable()
+ *
+ * Disables the hardware trigger for the offload instance with the specified ID
+ * and releases the bus for use by other clients.
+ *
+ * Context: can sleep
+ */
+void spi_offload_hw_trigger_disable(struct spi_device *spi, unsigned int id)
+{
+	struct spi_controller *ctlr = spi->controller;
+
+	if (!ctlr->offload_ops || !ctlr->offload_ops->hw_trigger_disable)
+		return;
+
+	mutex_lock(&ctlr->io_mutex);
+	ctlr->offload_ops->hw_trigger_disable(spi, id);
+	mutex_unlock(&ctlr->io_mutex);
+
+	ctlr->offload_hw_trigger_enabled = false;
+}
+
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_OF_DYNAMIC)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a8fc16c6bf37..ec8d875d31ff 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -632,6 +632,9 @@ struct spi_controller {
 	/* Flag indicating that the SPI bus is locked for exclusive use */
 	bool			bus_lock_flag;
 
+	/* Flag indicating the bus is reserved for use by hardware trigger */
+	bool			offload_hw_trigger_enabled;
+
 	/*
 	 * Setup mode and clock, etc (SPI driver may call many times).
 	 *
@@ -1594,12 +1597,26 @@ struct spi_controller_offload_ops {
 	 * @unprepare: Callback to release any resources used by prepare().
 	 */
 	void (*unprepare)(struct spi_device *spi, unsigned int id);
+
+	/**
+	 * @hw_trigger_enable: Callback to enable the hardware trigger for the
+	 * given offload instance.
+	 */
+
+	int (*hw_trigger_enable)(struct spi_device *spi, unsigned int id);
+	/**
+	 * @hw_trigger_disable: Callback to disable the hardware trigger for the
+	 * given offload instance.
+	 */
+	void (*hw_trigger_disable)(struct spi_device *spi, unsigned int id);
 };
 
 extern int spi_offload_prepare(struct spi_device *spi, unsigned int id,
 			       struct spi_message *msg);
 extern void spi_offload_unprepare(struct spi_device *spi, unsigned int id,
 				  struct spi_message *msg);
+extern int spi_offload_hw_trigger_enable(struct spi_device *spi, unsigned int id);
+extern void spi_offload_hw_trigger_disable(struct spi_device *spi, unsigned int id);
 
 /*---------------------------------------------------------------------------*/
 

-- 
2.43.2


