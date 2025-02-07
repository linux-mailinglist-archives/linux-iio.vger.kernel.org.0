Return-Path: <linux-iio+bounces-15132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51939A2CD99
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A23A8607
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119051A0BC5;
	Fri,  7 Feb 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EzeE5Wt6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008219F116
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958967; cv=none; b=C3hgDM/4iYioOKh605UPYkPNCMShoCXKUMcn+4v8UwIwRnUIn0v3tVD5dWK3vlavh9fg5yddOiZ87/NNeE9yctDQzOXxHHxV5IavhzPHEq+4prA6FYU+ny4+OVPiR6uDh0GaXZL9R5y8OGMuUJ04m6VgLPrZJa03n1gqW0vA5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958967; c=relaxed/simple;
	bh=DexCFkIwb7kCSU7k+T5cJi4HF/AtPekUbcbblQWUBck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/isergl4qeMiI3rdAGx2ZWRtj/ktKqCRGwAZ/g+68SP6BBfUsxTwK6zjZMP0GhVlBdFNwqU8Pghz1OMSjY4Hs1nPdnm59x5WoU7mqBjLpDDB3ZhNqJhUZ5XjtgKu1rAmKyYj+5bOiWoRgYWxZg6Iz/JMdzMlYIeIfryE5bE/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EzeE5Wt6; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fa28eaa52cso1381084eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958964; x=1739563764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSiA57XtGHi5YPHg4AJxsYI7A3iQnygs8wmimjPUAuY=;
        b=EzeE5Wt6Wu13eHBRmqBf7vOhBQ/iytxwBziTFHYOmKHTctt3ZPiyzyS7cs2wJM2CTW
         2dWTmySrKuvAxQjywYMJfBQ8wj7QXrN4oPZ8sWovpm5KYK2KV4RLQ5bGK8mtnoCm3j/n
         CqCXLDdd3C8R5Ql7YmEMfdiar9YBsTT2hTiVJvAmRdD8HGDJZlbPyNH3iSBJiDcqYC+o
         +rBHp38MvTA2U/nGrx7Y59zCP5gbs1WwJijwEPLQUAakjzNRUGZFhRdj0/uE5Aibk2wC
         HfW/HvDyRdiki23ssHdD8bfXwmNFS/1e6cKe/C95r/K4H23P2VpsJeJSr36tkHkXOKYb
         wKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958964; x=1739563764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSiA57XtGHi5YPHg4AJxsYI7A3iQnygs8wmimjPUAuY=;
        b=eOpDggCIr1Bhs/0drCRZSm50vPopBHkM5ZCRaCEAQFuoA9v9QA8G3IDUuevZzC+Pwv
         nNNhVLt/85Hom3w5M6q945WyctzCC77beGfYfrE7uWRbn5yVu+RzGSbXUpFwZtwspQsv
         F4W/Ab4qL3PoPwRXZZo2rTaKIgsbLhWYKayrqnMj53P2L+iZB1Dn7R6RpJRXfbRdCE0g
         Ot3xXaBA8AWPU0YA2ezm7ayP0Llw7nTOyMk9ojn0E1GhVMS6OgDJEcyJhWfwnoqwouFM
         IndgSj9/cYPQ5NeEmN8bSTe9EN0TgGCbe9kjgJK9VF6/lUNCgQth8JBZ/EGapoJCDI5g
         6SjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpyp2pNMeLRbDFeKzHT2DUs6oI0xfUDhfqQ8LVWMOTbxBjn5LjmO2ilDCQwUb2a9DybCWrjaEe0co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeKb1U0aBS8LasNPmU6rbY0TTDKLebIOtAJNphbIwm1thPx2d
	flhTUeg9YiWu0e8mwlECORbB/3H9CupD6B3JtNqC/uQ6GJ420gZQmWMZJPf54gA=
X-Gm-Gg: ASbGncuCuiqXkDZW+/lxXgI6JmOhCRmC11+bpeIWjLrJE/EtlBF997IWJjlcSRvcD7y
	v3DnOn0SAZbnhuirTylXESM/RTUptspZP6FPli72vPbESa/DGKtZK7R3jJddlQslu2EEVl3WdbK
	CHRRm+aHbODsQGXwRXRQK9NGcXC+i/AY7pEjqvdo6WURMKE2kXKO42ZoDk+WhY5sn1M5eb0ww16
	zBUKFDpo8ITItaKN7eTIj0QDfuiGMYQuD7d0f3WHnWvdCt2NLLn6/tIl1kodfiXO3Y/Ty9pPOF6
	7Qi9LNG1i5qUw0J4rCeOx6xasfQUYmERXQL4IzHvE50s6Us=
X-Google-Smtp-Source: AGHT+IE7KQ3cuNJVemjQC2JwAlq9Av5fmoKVdn2T75eGuUT7pUNjksv50Biph0SGiEMEvxWKE+hX+Q==
X-Received: by 2002:a05:6820:80a:b0:5fa:7bdc:e86 with SMTP id 006d021491bc7-5fc5e74bd59mr2870122eaf.8.1738958964432;
        Fri, 07 Feb 2025 12:09:24 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:23 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:08:58 -0600
Subject: [PATCH v8 01/17] spi: add basic support for SPI offloading
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-1-e48a489be48c@baylibre.com>
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

Add the basic infrastructure to support SPI offload providers and
consumers.

SPI offloading is a feature that allows the SPI controller to perform
transfers without any CPU intervention. This is useful, e.g. for
high-speed data acquisition.

SPI controllers with offload support need to implement the get_offload
and put_offload callbacks and can use the devm_spi_offload_alloc() to
allocate offload instances.

SPI peripheral drivers will call devm_spi_offload_get() to get a
reference to the matching offload instance. This offload instance can
then be attached to a SPI message to request offloading that message.

It is expected that SPI controllers with offload support will check for
the offload instance in the SPI message in the ctlr->optimize_message()
callback and handle it accordingly.

CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
consumer and provider drivers should `select SPI_OFFLOAD` in their
Kconfig to ensure that the SPI core is built with offload support.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Drop use of PTR_ERR_OR_ZERO().
* Split header into types.h/provider.h/consumer.h.
* Remove unused spi_controller_offload_ops forward declaration.

v5 changes:
* Don't include linux/property.h (moved to later patch).
* Only allocate single offload instance instead of array.
* Allocate *priv separately to avoid alignment issues.
* Add put_offload() callback instead of assuming devm semantics.
* Drop struct spi_offload::spi. It was only being used as a flag.
* Don't get/put struct spi_offload::provider_dev.
* Add MAINTAINERS entry for me as reviewer for anything related to
  SPI offload.

v4 changes:
* SPI offload functions moved to a separate file instead of spi.c
  (spi.c is already too long).
* struct spi_offload and devm_spi_offload_get() are back, similar to
  but improved over v1. This avoids having to pass the function ID
  string to every function call and re-lookup the offload instance.
* offload message prepare/unprepare functions are removed. Instead the
  existing optimize/unoptimize functions should be used. Setting
  spi_message::offload pointer is used as a flag to differentiate
  between an offloaded message and a regular message.

v3 changes:
* Minor changes to doc comments.
* Changed to use phandle array for spi-offloads.
* Changed id to string to make use of spi-offload-names.

v2 changes:
* This is a rework of "spi: add core support for controllers with offload
  capabilities" from v1.
* The spi_offload_get() function that Nuno didn't like is gone. Instead,
  there is now a mapping callback that uses the new generic devicetree
  binding to request resources automatically when a SPI device is probed.
* The spi_offload_enable/disable() functions for dealing with hardware
  triggers are deferred to a separate patch.
* This leaves adding spi_offload_prepare/unprepare() which have been
  reworked to be a bit more robust.
---
 MAINTAINERS                          |   6 ++
 drivers/spi/Kconfig                  |   3 +
 drivers/spi/Makefile                 |   1 +
 drivers/spi/spi-offload.c            | 114 +++++++++++++++++++++++++++++++++++
 include/linux/spi/offload/consumer.h |  22 +++++++
 include/linux/spi/offload/provider.h |  19 ++++++
 include/linux/spi/offload/types.h    |  43 +++++++++++++
 include/linux/spi/spi.h              |  17 ++++++
 8 files changed, 225 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4f5d8f6858170e63339aaa3380c3845cc08ab84..c37504e2e19f067b9835a28708dfd1d25700a608 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22342,6 +22342,12 @@ F:	Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
 F:	drivers/mtd/spi-nor/
 F:	include/linux/mtd/spi-nor.h
 
+SPI OFFLOAD
+R:	David Lechner <dlechner@baylibre.com>
+F:	drivers/spi/spi-offload.c
+F:	include/linux/spi/spi-offload.h
+K:	spi_offload
+
 SPI SUBSYSTEM
 M:	Mark Brown <broonie@kernel.org>
 L:	linux-spi@vger.kernel.org
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ea8a310329274bb2701e265cd152a56fb4e0f3a7..02064a4e292815ec0213e2e446b4f90ed8855a52 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -55,6 +55,9 @@ config SPI_MEM
 	  This extension is meant to simplify interaction with SPI memories
 	  by providing a high-level interface to send memory-like commands.
 
+config SPI_OFFLOAD
+	bool
+
 comment "SPI Master Controller Drivers"
 
 config SPI_AIROHA_SNFI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9db7554c1864bf9b37dcf59c16eb76f5af03a7e8..bb5fc20df21332232533c2e70c0cc230f6bcf27f 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -10,6 +10,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 obj-$(CONFIG_SPI_MEM)			+= spi-mem.o
 obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
+obj-$(CONFIG_SPI_OFFLOAD)		+= spi-offload.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 
diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
new file mode 100644
index 0000000000000000000000000000000000000000..3a40ef30debf09c6fd7b2c14526f3e5976e2b21f
--- /dev/null
+++ b/drivers/spi/spi-offload.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ */
+
+/*
+ * SPI Offloading support.
+ *
+ * Some SPI controllers support offloading of SPI transfers. Essentially, this
+ * is the ability for a SPI controller to perform SPI transfers with minimal
+ * or even no CPU intervention, e.g. via a specialized SPI controller with a
+ * hardware trigger or via a conventional SPI controller using a non-Linux MCU
+ * processor core to offload the work.
+ */
+
+#define DEFAULT_SYMBOL_NAMESPACE "SPI_OFFLOAD"
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/mutex.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
+#include <linux/spi/offload/types.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+struct spi_controller_and_offload {
+	struct spi_controller *controller;
+	struct spi_offload *offload;
+};
+
+/**
+ * devm_spi_offload_alloc() - Allocate offload instance
+ * @dev: Device for devm purposes and assigned to &struct spi_offload.provider_dev
+ * @priv_size: Size of private data to allocate
+ *
+ * Offload providers should use this to allocate offload instances.
+ *
+ * Return: Pointer to new offload instance or error on failure.
+ */
+struct spi_offload *devm_spi_offload_alloc(struct device *dev,
+					   size_t priv_size)
+{
+	struct spi_offload *offload;
+	void *priv;
+
+	offload = devm_kzalloc(dev, sizeof(*offload), GFP_KERNEL);
+	if (!offload)
+		return ERR_PTR(-ENOMEM);
+
+	priv = devm_kzalloc(dev, priv_size, GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	offload->provider_dev = dev;
+	offload->priv = priv;
+
+	return offload;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_alloc);
+
+static void spi_offload_put(void *data)
+{
+	struct spi_controller_and_offload *resource = data;
+
+	resource->controller->put_offload(resource->offload);
+	kfree(resource);
+}
+
+/**
+ * devm_spi_offload_get() - Get an offload instance
+ * @dev: Device for devm purposes
+ * @spi: SPI device to use for the transfers
+ * @config: Offload configuration
+ *
+ * Peripheral drivers call this function to get an offload instance that meets
+ * the requirements specified in @config. If no suitable offload instance is
+ * available, -ENODEV is returned.
+ *
+ * Return: Offload instance or error on failure.
+ */
+struct spi_offload *devm_spi_offload_get(struct device *dev,
+					 struct spi_device *spi,
+					 const struct spi_offload_config *config)
+{
+	struct spi_controller_and_offload *resource;
+	int ret;
+
+	if (!spi || !config)
+		return ERR_PTR(-EINVAL);
+
+	if (!spi->controller->get_offload)
+		return ERR_PTR(-ENODEV);
+
+	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
+	if (!resource)
+		return ERR_PTR(-ENOMEM);
+
+	resource->controller = spi->controller;
+	resource->offload = spi->controller->get_offload(spi, config);
+	if (IS_ERR(resource->offload)) {
+		kfree(resource);
+		return resource->offload;
+	}
+
+	ret = devm_add_action_or_reset(dev, spi_offload_put, resource);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return resource->offload;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_get);
diff --git a/include/linux/spi/offload/consumer.h b/include/linux/spi/offload/consumer.h
new file mode 100644
index 0000000000000000000000000000000000000000..05543dbedf3086fb4befcd149cff3c8c70a88825
--- /dev/null
+++ b/include/linux/spi/offload/consumer.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ */
+
+#ifndef __LINUX_SPI_OFFLOAD_CONSUMER_H
+#define __LINUX_SPI_OFFLOAD_CONSUMER_H
+
+#include <linux/module.h>
+#include <linux/spi/offload/types.h>
+#include <linux/types.h>
+
+MODULE_IMPORT_NS("SPI_OFFLOAD");
+
+struct device;
+struct spi_device;
+
+struct spi_offload *devm_spi_offload_get(struct device *dev, struct spi_device *spi,
+					 const struct spi_offload_config *config);
+
+#endif /* __LINUX_SPI_OFFLOAD_CONSUMER_H */
diff --git a/include/linux/spi/offload/provider.h b/include/linux/spi/offload/provider.h
new file mode 100644
index 0000000000000000000000000000000000000000..278c4edfcdb7b1f43870ca99d2ba252bf2820576
--- /dev/null
+++ b/include/linux/spi/offload/provider.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ */
+
+#ifndef __LINUX_SPI_OFFLOAD_PROVIDER_H
+#define __LINUX_SPI_OFFLOAD_PROVIDER_H
+
+#include <linux/module.h>
+#include <linux/types.h>
+
+MODULE_IMPORT_NS("SPI_OFFLOAD");
+
+struct device;
+
+struct spi_offload *devm_spi_offload_alloc(struct device *dev, size_t priv_size);
+
+#endif /* __LINUX_SPI_OFFLOAD_PROVIDER_H */
diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
new file mode 100644
index 0000000000000000000000000000000000000000..a74f8d84541b10062353e81a638f05628b696394
--- /dev/null
+++ b/include/linux/spi/offload/types.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ */
+
+#ifndef __LINUX_SPI_OFFLOAD_TYPES_H
+#define __LINUX_SPI_OFFLOAD_TYPES_H
+
+#include <linux/types.h>
+
+struct device;
+
+/* Offload can be triggered by external hardware event. */
+#define SPI_OFFLOAD_CAP_TRIGGER			BIT(0)
+/* Offload can record and then play back TX data when triggered. */
+#define SPI_OFFLOAD_CAP_TX_STATIC_DATA		BIT(1)
+/* Offload can get TX data from an external stream source. */
+#define SPI_OFFLOAD_CAP_TX_STREAM_DMA		BIT(2)
+/* Offload can send RX data to an external stream sink. */
+#define SPI_OFFLOAD_CAP_RX_STREAM_DMA		BIT(3)
+
+/**
+ * struct spi_offload_config - offload configuration
+ *
+ * This is used to request an offload with specific configuration.
+ */
+struct spi_offload_config {
+	/** @capability_flags: required capabilities. See %SPI_OFFLOAD_CAP_* */
+	u32 capability_flags;
+};
+
+/**
+ * struct spi_offload - offload instance
+ */
+struct spi_offload {
+	/** @provider_dev: for get/put reference counting */
+	struct device *provider_dev;
+	/** @priv: provider driver private data */
+	void *priv;
+};
+
+#endif /* __LINUX_SPI_OFFLOAD_TYPES_H */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8497f4747e24d4ecd85b74f49609ac1c82c73535..98bdc8c16c20521c0a94e5f72f5e71c4f6d7d11e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -31,6 +31,8 @@ struct spi_transfer;
 struct spi_controller_mem_ops;
 struct spi_controller_mem_caps;
 struct spi_message;
+struct spi_offload;
+struct spi_offload_config;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
@@ -496,6 +498,10 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @mem_ops: optimized/dedicated operations for interactions with SPI memory.
  *	     This field is optional and should only be implemented if the
  *	     controller has native support for memory like operations.
+ * @get_offload: callback for controllers with offload support to get matching
+ *	offload instance. Implementations should return -ENODEV if no match is
+ *	found.
+ * @put_offload: release the offload instance acquired by @get_offload.
  * @mem_caps: controller capabilities for the handling of memory operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @target_abort: abort the ongoing transfer request on an SPI target controller
@@ -740,6 +746,10 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 	const struct spi_controller_mem_caps *mem_caps;
 
+	struct spi_offload *(*get_offload)(struct spi_device *spi,
+					   const struct spi_offload_config *config);
+	void (*put_offload)(struct spi_offload *offload);
+
 	/* GPIO chip select */
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
@@ -1108,6 +1118,7 @@ struct spi_transfer {
  * @state: for use by whichever driver currently owns the message
  * @opt_state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
+ * @offload: (optional) offload instance used by this message
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1168,6 +1179,12 @@ struct spi_message {
 	 */
 	void			*opt_state;
 
+	/*
+	 * Optional offload instance used by this message. This must be set
+	 * by the peripheral driver before calling spi_optimize_message().
+	 */
+	struct spi_offload	*offload;
+
 	/* List of spi_res resources when the SPI message is processed */
 	struct list_head        resources;
 };

-- 
2.43.0


