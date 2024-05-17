Return-Path: <linux-iio+bounces-5079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4728C81AA
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 09:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94CF2824DB
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E529421;
	Fri, 17 May 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP1RaDp7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8522318;
	Fri, 17 May 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932082; cv=none; b=tpc5ywJgE5OrLzF9FDU5+Blcu99P2M7nA7jSyEdG584roRe+DVyqp+3cQqJbgov9ZnhyOz1rD5GV9na5NFk1n2fsHh9dDeBpPR1En2/miIzMi0NnYC92/hRL8unRBfIneod89qVtS0vAOa5B9ki6sI1r9DyOIbXeooPm2NvbHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932082; c=relaxed/simple;
	bh=9HevsJM5XUsmEvlkIIVfzx3FRsLbJfnHrlwstqp3h5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B373MW/o0qqWPIbQCBvzYoCkkKojdr3uMUfaUh86MpkzZuZVhQ6nQmMx8bf/qfJ84hERwvfMsBtBuQZ4SMWzpnOcwMggB41iWz3EADhRzgRyKYMzBdWsiJWUuZyT7tzsdun542G93vFVRjk0qOEQp0j2GaFojXiX0Ot2w1vljW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP1RaDp7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41fc5645bb1so63731645e9.1;
        Fri, 17 May 2024 00:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932079; x=1716536879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g236R+RZmtuFlo3Zhfk591fflsL4iIQnLtdeagpYx9w=;
        b=IP1RaDp7f2Q9hNXuZJsc0ddd9bgsD+/YsX5y10a3QmLVpnFtMftIkDEKK0mYI+djiS
         EAJR6jaEBsdEjJ8o0KJhbqwiWbe3hZ3xAhKNSTlUyJ0ZqFus2rjvGmg+qaY/rVnYNvf3
         lUT6LdEGqOrJjWLX0KjNq/FOsyYkEta4MafNJ54nEedoOeOYHmx7nQMEb9Kc5I06oH/O
         DKjtq2WfwITHCMNtKLSQ5m+AvQ/dcA2OOOvJKN5z7FWhrddGp4I3o3oaZwseoKmGjOjy
         de9exA1B3Ee+KDBhLCDQQToYQSEMelPvRzp2eye7EsZfNfc9/le59/fk/3dNFO430i+n
         8uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932079; x=1716536879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g236R+RZmtuFlo3Zhfk591fflsL4iIQnLtdeagpYx9w=;
        b=exIEzhMvE+Zo275COrFEj/E9jzeCSIn0kKF46q6UoTgjKeu2Xfk+RCXDPyhiQqtTX8
         oaGd6Igavt2bgBquTMcddLarPptHgjwhe2FUBTLobnnttUhXkdOFveBPDMtqajLHRQli
         gaDvGwbmol0Ae4tFD4YB4z8OgL1gqIr1eS94iRDy1Zc+qmHkpx9b5oPUE0YbbAvJSh8L
         UPJDR935fbnz+V+IVnHsQhfOXyfYwRfl8KwGqzhxZrrTEHX515cEw/QoektVwApfTu0b
         K/d90fm5Yx25dsPkXMM40pEJa1/+cPUhr6ZCetMuEm58hm3RQE2QhlhgB2jl6f5hGZwK
         WQYw==
X-Forwarded-Encrypted: i=1; AJvYcCUhT+X7kvs9jIUmR6zmckC1Y8husxmHvr26pOSmvS8GFu2f+vq7jQEisE1zqksjjOosggg+oB1wdUHJKGfzQahBOf55H7VkYt75c1FXcKgQzDCmj115QJmV9JcNuwf4m6835EhQUg==
X-Gm-Message-State: AOJu0YwcIyMvgqwdLT0XVrETtlQuKCFj6y5ipQ0p/dFM1NJrOqLbmoI4
	qC4WnJPQ5t9cNQfDfZmJe2OJ8Omqy1oxV6TMGU9iZEZTe7gCBjAxPfdDS7GLWH0=
X-Google-Smtp-Source: AGHT+IHUxeU6ppYBGhf1mfvBbCw51vspu8doyPEPzQhVty9r4p7bFoUwzim12Pn8dJy8jnUNrl27Jg==
X-Received: by 2002:a5d:698d:0:b0:34d:354:b9ba with SMTP id ffacd0b85a97d-3504a73e32dmr15046456f8f.30.1715932078815;
        Fri, 17 May 2024 00:47:58 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm21104207f8f.85.2024.05.17.00.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:47:58 -0700 (PDT)
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
Subject: [PATCH v3 4/9] iio: imu: adis_buffer: Add buffer setup API with buffer attributes
Date: Fri, 17 May 2024 10:47:45 +0300
Message-Id: <20240517074750.87376-5-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
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
changes in v3:
 - added forward declaration for iio_dev_attr
 drivers/iio/imu/adis_buffer.c | 32 ++++++++++++++++++--------------
 include/linux/iio/imu/adis.h  | 19 +++++++++++++++----
 2 files changed, 33 insertions(+), 18 deletions(-)

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
index 8898966bc0f0..8dda3cfa5773 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -21,6 +21,7 @@
 #define ADIS_REG_PAGE_ID 0x00

 struct adis;
+struct iio_dev_attr;

 /**
  * struct adis_timeouts - ADIS chip variant timeouts
@@ -515,11 +516,19 @@ int adis_single_conversion(struct iio_dev *indio_dev,
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

@@ -529,8 +538,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
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


