Return-Path: <linux-iio+bounces-13356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535C19ED7BA
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 21:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E96188A2EC
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395123692A;
	Wed, 11 Dec 2024 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZROVsmWo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2286235C46
	for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950515; cv=none; b=rNDPC5iCtC70/If7+zYMGWhYoVyOxIVKzspfpip8A0vuSGUxCHu07Sr9YrJk9M3t02j93kEX+9FILpVnAHhgXYYqVbTlR842YpJCXOi0ZxfBJJAhYX2DmQSbQJvokooFGFfb6wvkzaujxyl/uu4XIe0XaHyr+7ISmhqwlIkUkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950515; c=relaxed/simple;
	bh=0Ok/5ZnOlSAk0SyWH0Ar/2/amiOP/dC0SnejVgYuWPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZGhk7LjP/Chx3EQXoaWg7MB8szOCWY2ea4wcAHIBDRpg1ZO7q02OixEyQ9fMYl3A7+o20GhvrMDrLiPc8/oeh/jfGl6WsT0a0XU6E9nwGc6WgDGrqVB9HSbGx/Cy7ISqN8jdnKfzu/rV/QGpBNMPqBcNehOqDeds13p5pGyH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZROVsmWo; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71deb3745easo917953a34.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Dec 2024 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950512; x=1734555312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xX2yx2vSa/aaxQ+2sqQV4bQgGy0uEeuXD04S3quCr0=;
        b=ZROVsmWo5qPGPrdI74wJ4S03IABj9S3L0HcLtBh8841WN6hldEimlHZ07KTuEJoKW4
         7i7calvW6GBPDvUXF9REPUzvJq8aCpeknkogdBAjcg5MZ+eoRnRICTzMm+8Ez3HOWEez
         wXQHQpNS/GysR5NEPhTgxedWjWhURlBvYXnThLGwHjbIQczuKijAo6mUGRe/sV5BPnAH
         ZrnE6fXsoTxuwQ4JoYDOSX6CQOHPOdTDOec7hoVLVBYfpPYnDGBUlNHMZ7Z+D5Ikg0FK
         J16rT8+PGgGy9aQKPvmsK/LKlNjFOh0T5kp71xdxBgkr8RLipFkDDgefXH4cY8wLrt6X
         Ws5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950512; x=1734555312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xX2yx2vSa/aaxQ+2sqQV4bQgGy0uEeuXD04S3quCr0=;
        b=VLkqd3z603zmg29lpDhhMLvPpyT5R+Io62eszqoO6Te/mtCHC4POmUQQe/QOefGnM3
         FVMDKJ95s2Bow0WTUV6/Y4re259YZlrkl9RtX5XqtnRoZRTiPjYv7xjrOXj3g9QC3RUh
         6A8sA8HMSALTkBnSQ2+YtjBcfgzarqJSuqbKojY6weYFlkQLKiOlE2Wbm0u7f+Ahzcxb
         CzxBbmpwtMhekKGevQrJfqiGSr6pHEz//ag6AteFsprzyF2MunyYUTivIsNzQvrt3W58
         P8Oq+XD6nOhV9cdjcT538pBu0I5yaCFswQTVMAMFQrYJFFQ7VbC3AxCF/EzW7YZA2nge
         Gc9w==
X-Forwarded-Encrypted: i=1; AJvYcCV5PXB61N+0lmqq5fj9klKheGhHkSU486wthN9fz65QgKgPv39+ZlY8w9w0PCqoEawMB5y9GJWQwok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHx4VtHO6WGZs4REO3aARdIAK37nmfBmtFt3hl7L55aD2liq8v
	PaOzBtH35Ao4ikdGTnnITmq+v6GzQgS+W9vOq2jSGvwDRxkpPh/pOtM8uoZ7d2Q=
X-Gm-Gg: ASbGncsE98iMNyXE69n57GmdCitFK3Fahz62WUnBtvdn/BJVjqUKrtHUcRkeKZZCMao
	pmodfsnrb1u87tE6ePzLESRv1Dha7bVx3VyT5eExLyS89se2SLmSUleOY0OosOVSXnrc/tiEOk1
	CinwruK7w1n3GRXGMh2fEs9i/1HLfqC/0KqhApSgZ0odUmOPzbVmB/9jmBNW3Wmqfa7n6kB0jo9
	kwElnC3G0aiAB5B5v9j9NLTang5z3c+hAiXwBwSAfaB/o91Ih8rgqc6V9IOCYrEkyuwckkb29Bi
	qs/m90Cegg==
X-Google-Smtp-Source: AGHT+IFNtplY01hYwghmbGt8YZ7/urTHWFQ5LfK7SnSy2+GwyAQ+mInY95pngCiueu62gcUzQpnmsw==
X-Received: by 2002:a05:6830:3695:b0:71e:155:9bf with SMTP id 46e09a7af769-71e29c95d48mr725956a34.25.1733950511793;
        Wed, 11 Dec 2024 12:55:11 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:46 -0600
Subject: [PATCH v6 09/17] iio: buffer-dmaengine: add
 devm_iio_dmaengine_buffer_setup_with_handle()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-9-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a new devm_iio_dmaengine_buffer_setup_with_handle() function to
handle cases where the DMA channel is managed by the caller rather than
being requested and released by the iio_dmaengine module.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Rename from devm_iio_dmaengine_buffer_setup_ext2()
* This patch now just adds the new function - prep work was split out
  to a separate patch

v5 changes: none

v4 changes:
* This replaces "iio: buffer-dmaengine: generalize requesting DMA channel"
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 38 ++++++++++++++++++++++
 include/linux/iio/buffer-dmaengine.h               |  5 +++
 2 files changed, 43 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 02847d3962fcbb43ec76167db6482ab951f20942..e9d9a7d39fe191c2b6e8c196a08cdd26cd3a8d4b 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -380,6 +380,44 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext, "IIO_DMAENGINE_BUFFER");
 
+static void devm_iio_dmaengine_buffer_free(void *buffer)
+{
+	iio_dmaengine_buffer_free(buffer);
+}
+
+/**
+ * devm_iio_dmaengine_buffer_setup_with_handle() - Setup a DMA buffer for an
+ *						   IIO device
+ * @dev: Device for devm ownership
+ * @indio_dev: IIO device to which to attach this buffer.
+ * @chan: DMA channel
+ * @dir: Direction of buffer (in or out)
+ *
+ * This allocates a new IIO buffer with devm_iio_dmaengine_buffer_alloc()
+ * and attaches it to an IIO device with iio_device_attach_buffer().
+ * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
+ * IIO device.
+ *
+ * This is the same as devm_iio_dmaengine_buffer_setup_ext() except that the
+ * caller manages requesting and releasing the DMA channel handle.
+ */
+int devm_iio_dmaengine_buffer_setup_with_handle(struct device *dev,
+						struct iio_dev *indio_dev,
+						struct dma_chan *chan,
+						enum iio_buffer_direction dir)
+{
+	struct iio_buffer *buffer;
+
+	buffer = __iio_dmaengine_buffer_setup_ext(indio_dev, chan, dir);
+	if (IS_ERR(buffer))
+		return PTR_ERR(buffer);
+
+	return devm_add_action_or_reset(dev, devm_iio_dmaengine_buffer_free,
+					buffer);
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_with_handle,
+		     "IIO_DMAENGINE_BUFFER");
+
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 72a2e3fd8a5bf5e8f27ee226ddd92979d233754b..37f27545f69f761c3327c307cc6311b02a751096 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -11,6 +11,7 @@
 
 struct iio_dev;
 struct device;
+struct dma_chan;
 
 void iio_dmaengine_buffer_teardown(struct iio_buffer *buffer);
 struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
@@ -26,6 +27,10 @@ int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					const char *channel,
 					enum iio_buffer_direction dir);
+int devm_iio_dmaengine_buffer_setup_with_handle(struct device *dev,
+						struct iio_dev *indio_dev,
+						struct dma_chan *chan,
+						enum iio_buffer_direction dir);
 
 #define devm_iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
 	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\

-- 
2.43.0


