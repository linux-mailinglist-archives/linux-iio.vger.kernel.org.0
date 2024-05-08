Return-Path: <linux-iio+bounces-4879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2538BFE21
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0288E285C8E
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150D8120A;
	Wed,  8 May 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwW98qHH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B77D07D;
	Wed,  8 May 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174002; cv=none; b=ndZDgzuQAGfKprvAmgwiJz5ro/w+ddxv7KWUEXkhX6B+yir7aGr++YfC4TESVo8/HXNCgNkwtXON/IR4iLOZOBLSl6hOEhwv4637NeBiwQ7Sl7/Ytm8KqS25oVEhEdUZOoNcJ6bQkNDhuEV1AsHmjU5wEy5VxUt4q/PF1PiBkNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174002; c=relaxed/simple;
	bh=/hxidpLe13OPcx56CUWThrgp3iDqwvLmEXTMMwiVPC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UE6P8JraHSSK0FyyciIkwXG773n+xU7P2FoW8lAmki3RBPtWWBCjsBHqE6yQIifnbdyfTMXuCgPsM+5iTlCNBMZf3FSKY39PV7Y5mzeJhnwIqp8yJntLweidnwZmq0eu0VyCQB/W8s+LvEn426dLT60yE3SOqmXk+JRfN7Ci1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwW98qHH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso34068165e9.1;
        Wed, 08 May 2024 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715173998; x=1715778798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX7up5eWH/9CCekzsp/5nu52BFvIQXcilVrxqGOX/RU=;
        b=TwW98qHHh/59ZeoWU5tJC+kwp//paml9JdfWZJdOVz8WO77NZY0+K85kko+Jp/UHuq
         vgbJFesGTobizqVzXAfHuo/N1ZPlAYPTC6s9yJAdEfUFMW0W1aEL0nNk+i5DC9TmVen5
         bX62xLvkyLDczFmFkwTqdMb52HBRb6sJrLzqwUCMbKY43vEXhVMY+51otzUPRX+j9tLM
         huTu/CUVQEMtyTAxRZVu0CQeXbIYeggAflgHz/vuxXs4d4dKQjnMFMcFjQNHTl8PSv3j
         yr9pHi9msl5VfgCGvmvEE5c7ce7u0jO18tH1c/qttV4n+nFqp+GaMwjG9bX5wB8m/aGa
         fzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715173998; x=1715778798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XX7up5eWH/9CCekzsp/5nu52BFvIQXcilVrxqGOX/RU=;
        b=Hu8TehSxO2LkxGUN3XtxEfPlIH7TuZksLkkcW6w07PpucEE6T4DSyZBPL2O9zUXfDr
         Q7DRxv2aQ6ibL8Ub0EQsIM5PqXldn7XCf7X4onx+uT3dhE+LGh2UjcHj2SXWhWcu0Fuq
         BpIIePoShu8Rae862xZ+YOx6BDEonEqJseP05fv91GhsqbZVDWhFcuOf5rM/HXQxeLVg
         5OGc4dusKPs1eUrtB37dg0/2HlUWAzK0/Dk0Spg80fC6qHMFqjanMAj0zQz6uKBmy7oJ
         96euwyTbGF/uA1/gZPbGzx7qjDNn8g7KMx8EP0T6nIQbzsWYZsxlYkdh1WbVI42YF+CT
         ac1g==
X-Forwarded-Encrypted: i=1; AJvYcCUF8Hi0z+E0XInCSzmpcAEBtmnxpbGDfYSnsSIHt5W2rcyte/+xaybgYFIrJS9jML2WjWafx8JaHNXQLczpBrLmCaHz0oYjw27NPYBAjBMNZX4A3XydFFwQAliWHuMQ4roM6Zd1GQ==
X-Gm-Message-State: AOJu0Yx610w2aAfu3HsWAjci5dV41jN89BbXQDF7wlEi3tjBDLYIVMOF
	wLOU/Vro0r2wbEJyARHbbKfW6C7ntgLTdv13XNaV8QM9eY0AVJHrM4EQM5Qlljs=
X-Google-Smtp-Source: AGHT+IGzSh5sfY/ZdNOiyWG4TLAUO60X8y1VJ1MquOGcWv+nwT0AmMljQDPE8+ayo2+/FNFvCMBw/w==
X-Received: by 2002:a05:600c:1c24:b0:41a:ff7d:2473 with SMTP id 5b1f17b1804b1-41f719d36acmr22703675e9.4.1715173998492;
        Wed, 08 May 2024 06:13:18 -0700 (PDT)
Received: from rbolboac.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm22848365e9.29.2024.05.08.06.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:13:18 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v2 4/8] iio: imu: adis_buffer: Add buffer setup API with buffer attributes
Date: Wed,  8 May 2024 16:13:06 +0300
Message-Id: <20240508131310.880479-5-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
References: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new API called devm_adis_setup_buffer_and_trigger_with_attrs() which
also takes buffer attributes as a parameter.
Rewrite devm_adis_setup_buffer_and_trigger() implementation such that it
calls devm_adis_setup_buffer_and_trigger_with_attrs() with buffer
attributes parameter NULL

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v2:
 - use iio_dev_attr type instead of attribute type
 drivers/iio/imu/adis_buffer.c | 32 ++++++++++++++++++--------------
 include/linux/iio/imu/adis.h  | 18 ++++++++++++++----
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 928933027ae3..871b78b225e2 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -175,31 +175,36 @@ static void adis_buffer_cleanup(void *arg)
 }

 /**
- * devm_adis_setup_buffer_and_trigger() - Sets up buffer and trigger for
- *					  the managed adis device
+ * devm_adis_setup_buffer_and_trigger_with_attrs() - Sets up buffer and trigger
+ * for the managed adis device with buffer attributes.
  * @adis: The adis device
  * @indio_dev: The IIO device
- * @trigger_handler: Optional trigger handler, may be NULL.
+ * @trigger_handler: Trigger handler: should handle the buffer readings.
+ * @ops: Optional buffer setup functions, may be NULL.
+ * @buffer_attrs: Extra buffer attributes.
  *
  * Returns 0 on success, a negative error code otherwise.
  *
- * This function sets up the buffer and trigger for a adis devices.  If
- * 'trigger_handler' is NULL the default trigger handler will be used. The
- * default trigger handler will simply read the registers assigned to the
- * currently active channels.
+ * This function sets up the buffer (with buffer setup functions and extra
+ * buffer attributes) and trigger for a adis devices with buffer attributes.
  */
 int
-devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
-				   irq_handler_t trigger_handler)
+devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis, struct iio_dev *indio_dev,
+					      irq_handler_t trigger_handler,
+					      const struct iio_buffer_setup_ops *ops,
+					      const struct iio_dev_attr **buffer_attrs)
 {
 	int ret;

 	if (!trigger_handler)
 		trigger_handler = adis_trigger_handler;

-	ret = devm_iio_triggered_buffer_setup(&adis->spi->dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup_ext(&adis->spi->dev, indio_dev,
+						  &iio_pollfunc_store_time,
+						  trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN,
+						  ops,
+						  buffer_attrs);
 	if (ret)
 		return ret;

@@ -212,5 +217,4 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
 	return devm_add_action_or_reset(&adis->spi->dev, adis_buffer_cleanup,
 					adis);
 }
-EXPORT_SYMBOL_NS_GPL(devm_adis_setup_buffer_and_trigger, IIO_ADISLIB);
-
+EXPORT_SYMBOL_NS_GPL(devm_adis_setup_buffer_and_trigger_with_attrs, IIO_ADISLIB);
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 8898966bc0f0..42825c91fd59 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -515,11 +515,19 @@ int adis_single_conversion(struct iio_dev *indio_dev,
 #define ADIS_ROT_CHAN(mod, addr, si, info_sep, info_all, bits) \
 	ADIS_MOD_CHAN(IIO_ROT, mod, addr, si, info_sep, info_all, bits)

+#define devm_adis_setup_buffer_and_trigger(adis, indio_dev, trigger_handler)	\
+	devm_adis_setup_buffer_and_trigger_with_attrs((adis), (indio_dev),	\
+						      (trigger_handler), NULL,	\
+						      NULL)
+
 #ifdef CONFIG_IIO_ADIS_LIB_BUFFER

 int
-devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
-				   irq_handler_t trigger_handler);
+devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis,
+					      struct iio_dev *indio_dev,
+					      irq_handler_t trigger_handler,
+					      const struct iio_buffer_setup_ops *ops,
+					      const struct iio_dev_attr **buffer_attrs);

 int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);

@@ -529,8 +537,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 #else /* CONFIG_IIO_BUFFER */

 static inline int
-devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
-				   irq_handler_t trigger_handler)
+devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis, struct iio_dev *indio_dev,
+					      irq_handler_t trigger_handler,
+					      const struct iio_buffer_setup_ops *ops,
+					      const struct iio_dev_attr **buffer_attrs)
 {
 	return 0;
 }
--
2.34.1


