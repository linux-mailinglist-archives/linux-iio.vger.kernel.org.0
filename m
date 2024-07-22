Return-Path: <linux-iio+bounces-7804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E6C939616
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 00:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41591F225E7
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9A4965D;
	Mon, 22 Jul 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0PCVOU+K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2B4597F
	for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685690; cv=none; b=F8KpQ67QvG/fq/U6dImkwbYmyzINWWgX8ojRMuxCyyXSJdWvi/uxbWtT6BgKhYzCdfpgF9l5mOQ51M2kwau6GaVJ1hPTd+FtatnSPi8Rx/hAnrr0AOKvPv+OT0WOK/8fOhdQX4GgVAXV2LvSWKlQWqcye18jozPSeNyRK4eJbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685690; c=relaxed/simple;
	bh=1B09Jui1kz07R/7PfI7iAgF3gynzk4/nQZkjsJp+2XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkXw5yVycMW4hEPaaFDWyYU7GCWv9mNORlKgTwPC86xcOrR/6MP9un7rIGOq3WvOcz3ZUjFQN5+CVICJf+BDxJ+YJdryu0k/YP+B30fRKPyA/OQ7DJE4ahLGzIVbipT2epWQqAj6YELknbyz03zZnb7P8zSaKU5P3GwgNrbBLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0PCVOU+K; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7044bda722fso2822918a34.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jul 2024 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685688; x=1722290488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZOa0K1V/Ey7BU+5ST8W2wQBmjXJNycuVFCgasaNz1A=;
        b=0PCVOU+KxNLEFZl631kP1zaD0OwKvE+Em958h0KVfIiS3DmhzZ4XdGgVVV/hSFxOYa
         rVFNwovE/9tFwaVEItN5gih0vziAH0T430HpZPK3NzWct8wu5JL9Zefqt15PQKXZQ3+O
         PJEP+JYXKN+lr2X4f7gJGfE1dJVeP9yPaeYJkylaE6kundlX2/5aLGxsEJmJxryKeURZ
         bSoL7GZ0RsBeLhj06zcwe3WRlwIVp4vuoehJlnijsGS/sEZXcdvfkfpthoFuvOlZf8tz
         db8jMJa4d+DOBlZC3sQWq2/SCbQTwv8UxrpcR3vhHwR5sa7pPzKEwhll/NZ7l3TNqhV1
         69Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685688; x=1722290488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZOa0K1V/Ey7BU+5ST8W2wQBmjXJNycuVFCgasaNz1A=;
        b=Z/xYDGlhkAVDRqjgn9bAYIT5D2fG6EAUfvb621LHSk957M2bV2VTnsUJ3GP0n9GJhX
         X1qWBIbMqxfUGs6LSstcdlBu4pAocl0a8WOlfY/IzAcznDaAy+YLHrKFl6Fabf6w/24Q
         ps9GTo+e0BJAoTsEJLWjYm6cm1FcLLgnJli263mc2h0A9yp+pT4yY+KTnxX4qQFZ8uRu
         XdKH7UqqU1h+M0CAIrK9YyhK30/RYbaUz7w6Qfie3AAYceMcu2nvZxUcJVY8+r5A6kOH
         c3MnYmZUU0xXnazcWnNeK10TiCv7VW1UxYa9H6/jlFwwopv2CLs2D6uQdKMR464F9Jhe
         IB1A==
X-Forwarded-Encrypted: i=1; AJvYcCXEguR0CJ7CGhseuBbE7ESvAkdDSvy4ZWPL+6/3RiN9Enl3UD2OvO2odnQkSQLDBSmTbbRZFTOmrbqoe2lst8JkRclu2xDxQNJU
X-Gm-Message-State: AOJu0YzZLOvphBOunSdJYaQdtV+yZYUlJLTR1STeFMeBncuJZPEaTDRu
	YjCVLRneLtdcjcsjIKQKSc/JJTj4i1n4JqvDlGi7QeDk2LQdCsbh6YTADLccuR0=
X-Google-Smtp-Source: AGHT+IFo70BHNM9xbD19IHbLstor6jVOhrw5/iz2IMYdO2fmxYUL8cwptC+z293AWKKBiO8ujc4HOg==
X-Received: by 2002:a05:6830:488c:b0:708:b46d:5c76 with SMTP id 46e09a7af769-709008dd3abmr9920745a34.17.1721685687669;
        Mon, 22 Jul 2024 15:01:27 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:27 -0700 (PDT)
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
Subject: [PATCH RFC v3 2/9] spi: add basic support for SPI offloading
Date: Mon, 22 Jul 2024 16:57:09 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-2-7420e45df69b@baylibre.com>
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

SPI offloading is a feature that allows the SPI controller to perform
transfers without any CPU intervention. This is useful, e.g. for
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

v3 changes:
* Minor changes to doc comments.
* Changed to use phandle array for spi-offloads.
* Changed id to string to make use of spi-offload-names.

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
 drivers/spi/spi.c       | 123 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  57 ++++++++++++++++++++++
 2 files changed, 180 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d4da5464dbd0..d01b2e5c8c44 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2477,6 +2477,51 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_hold, "spi-cs-hold-delay-ns");
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_inactive, "spi-cs-inactive-delay-ns");
 
+	/* Offloads */
+	rc = of_count_phandle_with_args(nc, "spi-offloads", "#spi-offload-cells");
+	if (rc > 0) {
+		int num_offload = rc;
+
+		if (!ctlr->offload_ops) {
+			dev_err(&ctlr->dev, "SPI controller doesn't support offloading\n");
+			return -EINVAL;
+		}
+
+		for (idx = 0; idx < num_offload; idx++) {
+			struct of_phandle_args args;
+			const char *offload_name = NULL;
+
+			rc = of_parse_phandle_with_args(nc, "spi-offloads",
+							"#spi-offload-cells",
+							idx, &args);
+			if (rc) {
+				dev_err(&spi->dev, "Failed to parse offload phandle %d: %d\n",
+					idx, rc);
+				return rc;
+			}
+
+			if (args.np != ctlr->dev.of_node) {
+				dev_err(&spi->dev, "Offload phandle %d is not for this SPI controller\n",
+					idx);
+				of_node_put(args.np);
+				return -EINVAL;
+			}
+
+			of_property_read_string_index(nc, "spi-offload-names",
+						      idx, &offload_name);
+
+			rc = ctlr->offload_ops->map_channel(spi, offload_name,
+							    args.args,
+							    args.args_count);
+			of_node_put(args.np);
+			if (rc) {
+				dev_err(&spi->dev, "Failed to map offload channel %d: %d\n",
+					value, rc);
+				return rc;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -3231,6 +3276,11 @@ static int spi_controller_check_ops(struct spi_controller *ctlr)
 		}
 	}
 
+	if (ctlr->offload_ops && !(ctlr->offload_ops->map_channel &&
+				   ctlr->offload_ops->prepare &&
+				   ctlr->offload_ops->unprepare))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -4751,6 +4801,79 @@ int spi_write_then_read(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(spi_write_then_read);
 
+/**
+ * spi_offload_prepare - prepare offload hardware for a transfer
+ * @spi:	The spi device to use for the transfers.
+ * @id:		Function ID if SPI device uses more than one offload or NULL.
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
+int spi_offload_prepare(struct spi_device *spi, const char *id,
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
+void spi_offload_unprepare(struct spi_device *spi, const char *id,
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
index d7a16e0adf44..4998b48ea7fd 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -31,6 +31,7 @@ struct spi_transfer;
 struct spi_controller_mem_ops;
 struct spi_controller_mem_caps;
 struct spi_message;
+struct spi_controller_offload_ops;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
@@ -499,6 +500,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	     This field is optional and should only be implemented if the
  *	     controller has native support for memory like operations.
  * @mem_caps: controller capabilities for the handling of memory operations.
+ * @offload_ops: operations for controllers with offload support.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
  * @target_abort: abort the ongoing transfer request on an SPI target controller
@@ -746,6 +748,9 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 	const struct spi_controller_mem_caps *mem_caps;
 
+	/* Operations for controllers with offload support. */
+	const struct spi_controller_offload_ops *offload_ops;
+
 	/* GPIO chip select */
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
@@ -1122,6 +1127,7 @@ struct spi_transfer {
  * @pre_optimized: peripheral driver pre-optimized the message
  * @optimized: the message is in the optimized state
  * @prepared: spi_prepare_message was called for the this message
+ * @offload: message is to be used with offload hardware
  * @status: zero for success, else negative errno
  * @complete: called to report transaction completions
  * @context: the argument to complete() when it's called
@@ -1131,6 +1137,7 @@ struct spi_transfer {
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
  * @opt_state: for use by whichever driver currently owns the message
+ * @offload_state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
@@ -1159,6 +1166,8 @@ struct spi_message {
 
 	/* spi_prepare_message() was called for this message */
 	bool			prepared;
+	/* spi_offload_prepare() was called on this message */
+	bool			offload;
 
 	/*
 	 * REVISIT: we might want a flag affecting the behavior of the
@@ -1191,6 +1200,11 @@ struct spi_message {
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
@@ -1556,6 +1570,49 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
 
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
+	 * @map_channel: Required callback to reserve an offload instance for
+	 * the given SPI device. If a SPI device requires more than one instance,
+	 * then @id is used to differentiate between them. Channels must be
+	 * unmapped in the struct spi_controller::cleanup() callback.
+	 */
+	int (*map_channel)(struct spi_device *spi, const char *id,
+			   const unsigned int *args, unsigned int num_args);
+	/**
+	 * @prepare: Required callback to prepare the offload for the given SPI
+	 * message. @msg and any of its members (including any xfer->tx_buf) is
+	 * not guaranteed to be valid beyond the lifetime of this call.
+	 */
+	int (*prepare)(struct spi_device *spi, const char *id,
+		       struct spi_message *msg);
+	/**
+	 * @unprepare: Required callback to release any resources used by prepare().
+	 */
+	void (*unprepare)(struct spi_device *spi, const char *id);
+};
+
+extern int spi_offload_prepare(struct spi_device *spi, const char *id,
+			       struct spi_message *msg);
+extern void spi_offload_unprepare(struct spi_device *spi, const char *id,
+				  struct spi_message *msg);
+
+/*---------------------------------------------------------------------------*/
+
 /*
  * INTERFACE between board init code and SPI infrastructure.
  *

-- 
2.43.0


