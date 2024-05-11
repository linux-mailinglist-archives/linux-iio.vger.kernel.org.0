Return-Path: <linux-iio+bounces-4942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341C8C2E01
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 02:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FB71F22F3F
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D711CAB;
	Sat, 11 May 2024 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kRhxpUBi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267B647
	for <linux-iio@vger.kernel.org>; Sat, 11 May 2024 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388601; cv=none; b=f4Q8uIRZwhxOwgKzObIHTgDiKoCtsK5p6JTF7MK1COxeOtNBggDJryvZwFQwlGgKlIet7ytAQP8maMGTrxOLibFcEISIG86tDIPi+/lRQAsGX94Nl68vVohMmxP0mir/v7VRNtnZiJrlsj1pKV+8XrlaMuzwX/RcMOpD3ljyVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388601; c=relaxed/simple;
	bh=trOA5E6cr+7SXCIy7MjCsAjJshllVgbE52T91gYWCS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UE0bwsPDqXdsb7wu8TaSz1sbY8x4T1Q1GsuwDtoHCb71hykjo5TRt9wMcN2/7DWdC46DiKnizxHF159/vYRW4rh751Pv78f4ifJGvYUYoRp6lxAoDrhG5nCnNtGKtGUCi+CZWbcEeMBnl42VbWyHnMOhVQKo7WeBmEWGpGko1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kRhxpUBi; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b273b9f1deso1270357eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715388598; x=1715993398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBA7sAKR0McttWE/pFL/rZ2xrhn9Dfe5dI0ynO4z2uI=;
        b=kRhxpUBiZ2bjt+Pk7yncaX4o5hIlhYYcwTsSx4AwKv1zEJT/VbOkwT/Wld6jeFghYF
         9IGAwXvb8ySiglq+nWSV+xYwTKsZdwdtfxvUzGG/CPvscF5hLo2r/yKs4z9WvPvaVgmR
         tTpg62W84DaCWrfK8ehvcxYVY3B+U0J4Tle8UNnCj7nQLEYdYhwFrph1TYghveG4wqfQ
         gbm8taHVEJXZl1Gk+Y8QznTsyuIakYZUPEjiM3196nVqj1x7ErlCYkL5gdaz6erV1C4x
         DxVyDXkHlfUO9Xi45w1vkovpYU+0Q+CAgWb0akDWBGRkH7mk45v5W4rKM2pWGv/9SMB6
         mZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715388598; x=1715993398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBA7sAKR0McttWE/pFL/rZ2xrhn9Dfe5dI0ynO4z2uI=;
        b=oUsZSbVo6Mmd6T+CyJhWeo8+ZMWicF0i846L1SUjvKSjzypobJezt48i+WOzcww1OW
         27WHOAWP/Oxu+h5+JwrHmJ8Rs5Bj5rZG+0T+7M4zRN81u51K3h1ec7roSnshgvmkXKPY
         snOLtF7GvJiKq+GU8/VBb72eFLAUY0mvdSmIvtWalECyWSzunPX1S5QAzzmJ0If9vBTw
         zwqOnKETKzpY93PXiY1R/gPGHZqkNYKc2HjlpbxqXqcUeQ7pECsQayhrIt/pmP/5JVOl
         wB4PnREOke4IbMmu7s8tBPGfFROHxyI/xgKR3g3+ZDHxzBMliTC86xyG+3b0JVt0QxUT
         uZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCXn7FjQGFSddpvc4vXouWMd+JO7mxXYXNz3gfYf+YqxrdU3Z67MmHOR4s835OYLzTQ/y1EumPEn0+7gYkPWjgiax8KQX2jnjIBf
X-Gm-Message-State: AOJu0Yx7QL+O7sl3boOhTSf5Fbi+FLRoa5ZHyfe18QxlLEujcbeeRr6j
	+l2muLyEyaw8Es3w2WuoBOfqL0QTgeJGtgB4Kqpe0L8ZKeahuSSq8j7tUz+KOXo=
X-Google-Smtp-Source: AGHT+IFRvVNIdqHmAFp3VONJKZ1EO7R2R6wKqwQ4CFLc4SE6uiCuGQ83poyhcFd37Cu9yDkUnFcxig==
X-Received: by 2002:a4a:5487:0:b0:5aa:596c:52d0 with SMTP id 006d021491bc7-5b2819a49dbmr4629752eaf.6.1715388598032;
        Fri, 10 May 2024 17:49:58 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b29015a3dbsm321132eaf.46.2024.05.10.17.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 17:49:57 -0700 (PDT)
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
Subject: [PATCH RFC v2 2/8] spi: add basic support for SPI offloading
Date: Fri, 10 May 2024 19:44:25 -0500
Message-ID: <20240510-dlech-mainline-spi-engine-offload-2-v2-2-8707a870c435@baylibre.com>
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

SPI offloading is a feature that allows the SPI controller to perform
complex transfers without CPU intervention. This is useful, e.g. for
high-speed data acquisition.

This patch adds the basic infrastructure to support SPI offloading. It
introduces new callbacks that are to be implemented by controllers with
offload capabilities.

On SPI device probe, the standard spi-offloads devicetree property is
parsed and passed to the controller driver to reserve the resources
requested by the peripheral via the map_channel() callback.

The peripheral driver can then use spi_offload_prepare() to load a SPI
message into the offload hardware.

If the controller supports it, this message can then be passed to the
SPI message queue as if it was a normal message. Future patches will
will also implement a way to use a hardware trigger to start the message
transfers rather than going through the message queue.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:

This is a rework of "spi: add core support for controllers with offload
capabilities" from v1.

The spi_offload_get() function that Nuno didn't like is gone. Instead,
there is now a mapping callback that uses the new generic devicetree
binding to request resources automatically when a SPI device is probed.

The spi_offload_enable/disable() functions for dealing with hardware
triggers are deferred to a separate patch.

This leaves adding spi_offload_prepare/unprepare() which have been
reworked to be a bit more robust.

In the previous review, Mark suggested that these functions should not
be separate from the spi_[un]optimize() functions. I understand the
reasoning behind that. However, it seems like there are two different
kinds of things going on here. Currently, spi_optimize() only performs
operations on the message data structures and doesn't poke any hardware.
This makes it free to be use by any peripheral without worrying about
tying up any hardware resources while the message is "optimized". On the
other hand, spi_offload_prepare() is poking hardware, so we need to be
more careful about how it is used. And in these cases, we need a way to
specify exactly which hardware resources it should use, which it is
currently doing with the extra ID parameter.
---
 drivers/spi/spi.c       | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  57 +++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 289feccca376..54b814cea54c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2477,6 +2477,28 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_hold, "spi-cs-hold-delay-ns");
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_inactive, "spi-cs-inactive-delay-ns");
 
+	/* Offloads */
+	rc = of_property_count_u32_elems(nc, "spi-offloads");
+	if (rc > 0) {
+		int num_ch = rc;
+
+		if (!ctlr->offload_ops) {
+			dev_err(&ctlr->dev, "SPI controller doesn't support offloading\n");
+			return -EINVAL;
+		}
+
+		for (idx = 0; idx < num_ch; idx++) {
+			of_property_read_u32_index(nc, "spi-offloads", idx, &value);
+
+			rc = ctlr->offload_ops->map_channel(spi, idx, value);
+			if (rc) {
+				dev_err(&ctlr->dev, "Failed to map offload channel %d: %d\n",
+					value, rc);
+				return rc;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -3231,6 +3253,11 @@ static int spi_controller_check_ops(struct spi_controller *ctlr)
 		}
 	}
 
+	if (ctlr->offload_ops && !(ctlr->offload_ops->map_channel &&
+				   ctlr->offload_ops->prepare &&
+				   ctlr->offload_ops->unprepare))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -4708,6 +4735,79 @@ int spi_write_then_read(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(spi_write_then_read);
 
+/**
+ * spi_offload_prepare - prepare offload hardware for a transfer
+ * @spi:	The spi device to use for the transfers.
+ * @id:		Unique identifier for SPI device with more than one offload.
+ * @msg:	The SPI message to use for the offload operation.
+ *
+ * Requests an offload instance with the specified ID and programs it with the
+ * provided message.
+ *
+ * The message must not be pre-optimized (do not call spi_optimize_message() on
+ * the message).
+ *
+ * Calls must be balanced with spi_offload_unprepare().
+ *
+ * Return: 0 on success, else a negative error code.
+ */
+int spi_offload_prepare(struct spi_device *spi, unsigned int id,
+			struct spi_message *msg)
+{
+	struct spi_controller *ctlr = spi->controller;
+	int ret;
+
+	if (!ctlr->offload_ops)
+		return -EOPNOTSUPP;
+
+	msg->offload = true;
+
+	ret = spi_optimize_message(spi, msg);
+	if (ret)
+		return ret;
+
+	mutex_lock(&ctlr->io_mutex);
+	ret = ctlr->offload_ops->prepare(spi, id, msg);
+	mutex_unlock(&ctlr->io_mutex);
+
+	if (ret) {
+		spi_unoptimize_message(msg);
+		msg->offload = false;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_offload_prepare);
+
+/**
+ * spi_offload_unprepare - releases any resources used by spi_offload_prepare()
+ * @spi:	The same SPI device passed to spi_offload_prepare()
+ * @id:		The same ID device passed to spi_offload_prepare()
+ * @msg:	The same SPI message passed to spi_offload_prepare()
+ *
+ * Callers must ensure that the offload is no longer in use before calling this
+ * function, e.g. no in-progress transfers.
+ */
+void spi_offload_unprepare(struct spi_device *spi, unsigned int id,
+			   struct spi_message *msg)
+{
+	struct spi_controller *ctlr = spi->controller;
+
+	if (!ctlr->offload_ops)
+		return;
+
+	mutex_lock(&ctlr->io_mutex);
+	ctlr->offload_ops->unprepare(spi, id);
+	mutex_unlock(&ctlr->io_mutex);
+
+	msg->offload = false;
+	msg->offload_state = NULL;
+
+	spi_unoptimize_message(msg);
+}
+EXPORT_SYMBOL_GPL(spi_offload_unprepare);
+
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_OF_DYNAMIC)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e8e1e798924f..a8fc16c6bf37 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -31,6 +31,7 @@ struct spi_transfer;
 struct spi_controller_mem_ops;
 struct spi_controller_mem_caps;
 struct spi_message;
+struct spi_controller_offload_ops;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
@@ -500,6 +501,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	     This field is optional and should only be implemented if the
  *	     controller has native support for memory like operations.
  * @mem_caps: controller capabilities for the handling of memory operations.
+ * @offload_ops: operations for controllers with offload support.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
  * @target_abort: abort the ongoing transfer request on an SPI target controller
@@ -745,6 +747,9 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 	const struct spi_controller_mem_caps *mem_caps;
 
+	/* Operations for controllers with offload support. */
+	const struct spi_controller_offload_ops *offload_ops;
+
 	/* GPIO chip select */
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
@@ -1114,6 +1119,7 @@ struct spi_transfer {
  * @pre_optimized: peripheral driver pre-optimized the message
  * @optimized: the message is in the optimized state
  * @prepared: spi_prepare_message was called for the this message
+ * @offload: message is to be used with offload hardware
  * @status: zero for success, else negative errno
  * @complete: called to report transaction completions
  * @context: the argument to complete() when it's called
@@ -1123,6 +1129,7 @@ struct spi_transfer {
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
  * @opt_state: for use by whichever driver currently owns the message
+ * @offload_state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
@@ -1151,6 +1158,8 @@ struct spi_message {
 
 	/* spi_prepare_message() was called for this message */
 	bool			prepared;
+	/* spi_offload_prepare() was called on this message */
+	bool			offload;
 
 	/*
 	 * REVISIT: we might want a flag affecting the behavior of the
@@ -1183,6 +1192,11 @@ struct spi_message {
 	 * __spi_optimize_message() and __spi_unoptimize_message().
 	 */
 	void			*opt_state;
+	/*
+	 * Optional state for use by controller driver between calls to
+	 * offload_ops->prepare() and offload_ops->unprepare().
+	 */
+	void			*offload_state;
 
 	/* List of spi_res resources when the SPI message is processed */
 	struct list_head        resources;
@@ -1546,6 +1560,49 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
 
 /*---------------------------------------------------------------------------*/
 
+/*
+ * Offloading support.
+ *
+ * Some SPI controllers support offloading of SPI transfers. Essentially,
+ * this allows the SPI controller to record SPI transfers and then play them
+ * back later in one go via a single trigger.
+ */
+
+/**
+ * struct spi_controller_offload_ops - callbacks for offload support
+ *
+ * Drivers for hardware with offload support need to implement all of these
+ * callbacks.
+ */
+struct spi_controller_offload_ops {
+	/**
+	 * @map_channel: Callback to reserve an offload instance for the given
+	 * SPI device. If a SPI device requires more than one instance, then
+	 * @id is used to differentiate between them. Channels must be unmapped
+	 * in the struct spi_controller::cleanup() callback.
+	 */
+	int (*map_channel)(struct spi_device *spi, unsigned int id,
+			   unsigned int channel);
+	/**
+	 * @prepare: Callback to prepare the offload for the given SPI message.
+	 * @msg and any of its members (including any xfer->tx_buf) is not
+	 * guaranteed to be valid beyond the lifetime of this call.
+	 */
+	int (*prepare)(struct spi_device *spi, unsigned int id,
+		       struct spi_message *msg);
+	/**
+	 * @unprepare: Callback to release any resources used by prepare().
+	 */
+	void (*unprepare)(struct spi_device *spi, unsigned int id);
+};
+
+extern int spi_offload_prepare(struct spi_device *spi, unsigned int id,
+			       struct spi_message *msg);
+extern void spi_offload_unprepare(struct spi_device *spi, unsigned int id,
+				  struct spi_message *msg);
+
+/*---------------------------------------------------------------------------*/
+
 /*
  * INTERFACE between board init code and SPI infrastructure.
  *

-- 
2.43.2


