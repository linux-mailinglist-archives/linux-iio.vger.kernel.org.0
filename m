Return-Path: <linux-iio+bounces-19681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A0ABC09D
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5443BEC72
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE0C284B20;
	Mon, 19 May 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj8PTqYY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E6284687;
	Mon, 19 May 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664780; cv=none; b=HLNz03Pp6XkaQDPV2ymQKuEAnQ0k+ucUsXyPABclQalF1U7fFGbt82Wbbyd1cwr5guphxZaif0D7McnJf1qWI2BbDTWcKkRZ7q/YLFzV85lzQ25jWIJwQhEfyJ1tK3fjMXA6etChdovZnvz2BPDn+IEy5RQ3BloEXzqd8u3Zjik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664780; c=relaxed/simple;
	bh=6tyw7//S3oDV1Ghtwcm8ZMKZS9mcRgS9Mvb26goqhVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma6/lP+lVyA+KMfEtBjoiTX2gbzSVDIMDYmVF0ZuFrzZrcq7s6GwXI+YWFigdIW9csQA1EjG/CTxFQYIgwQj05W9tR3eBigsqrkm3Eg0qGjGX8ZSqI+aoiCCfKeIHiiy5OSthDRRRSBj56eCbYy8B+W/mO+bbSODRvjs/E3w9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj8PTqYY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74068f95d9fso4014066b3a.0;
        Mon, 19 May 2025 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664778; x=1748269578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUObscyqJyDseU1fD1f5U5y4CmFZFif/DcNZ9LyKzkA=;
        b=dj8PTqYYoCwLHH40Fs96FsPSYoJ1OrVEGk5RXzYG55kuXhwno1vmFqZDImv8lWzCXN
         6ebVtY1GTrTG5ilfX9B9bzi9fnwAyEWI5bG3WUHf5JxJGfRRvN2g47XWhsx/OBFK44FM
         A+GNroyFIf5rDHJhjl6Cf8KpkncfA1rq6TwEnhKg+Az8vSqPtm473SfuxP3ggA7JBnJS
         bO/TjRrWuwQTZZo6fuY/nU31g9ujrJFdgI6HdIIDnZB/dudRw9IBZhVmvjrOaYfTeHIQ
         GzygEGXadXzkeu8/ZfgpyO67b/pSGx625j0WwPglRONOi3P11pRbD1JJbJ057sbKEHA4
         d6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664778; x=1748269578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUObscyqJyDseU1fD1f5U5y4CmFZFif/DcNZ9LyKzkA=;
        b=q118gdiFcOuRiY3pF3dSawKoKlBL4VNRQoMhfnHpxnZZM9pYaps+/zCNs9OlSNdmFO
         NCwfi34yMsww1xf1nUai0Fu6p5shCRdI6HYHJNPcn0J9ToOYhFxD0W96z9fq7Zb0EPUi
         RFWlKRZTBZMVHEdLz5JpZQ6u/ne4XjdM7u4OPPLbZQyoZjXTvq2HcrZ2Xkbwd79PhCTi
         ETzZaJHjs3zefeBDVvbQNJL6Qfv1/OjnmHXzyUAMeldWSB+jUMlpllH6j795lPAihCKh
         A5enzYFDX1TN31ZrzxDKlEunADbHrn0MGVfdxl37WFDN7DRpwgZK8kP09uso3LNTCfrM
         ekbw==
X-Forwarded-Encrypted: i=1; AJvYcCW0eX3CuSPcSLUrSwEMnsVyfbDXGAdypTz1NMRHk320FT5aFz5jfnejmHlva5y+976vHCADpFSQPMvwjcnE@vger.kernel.org, AJvYcCXcLYkE5n86+vZmUvbZH7y+SgFfyHWi18Kx/bm75qLVM/SSeZm/k6R0of6jt4H3eekvUePp5jlxNWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIVGTyKdJKITbvRfLXzxEcrEy9LAV+FTrRMc4Dod/bQYgR26N
	JBs2lL34TcRLk9XUOaA1g1WOmnt4Z6Ju387r1nDqeH0nrxXi5lHxdxx3
X-Gm-Gg: ASbGncsJcLHaQ2JqT/L4X5it7rhd220zh3R3cN06WwpHbrZsKqnkQ+aKIesaBxg2qGW
	C4pZLS0U5PtA11zkKXEE8zV4/fkb5Fvi6VQcvwvvRJWQvgvNAwpxiT6245blW5NG6h3Fa1IOx8G
	yxgUS47jf4eFWfurJbKs7/RPl7t0VaTSjE9FdtI9EWHJ3QhCcD/L45vtk8EqGoPedsbrHXa+gFA
	NLaOv1tuQrLesrkpWBNWCMJuoyLIMTQRD0X++JYDR0UfKcrZ5Wh6WbMRQuEIbEZdUllVBYXVA78
	Up6KKAyN5lElqf9OIs3uDS0h3/cNdJ+KKcUK7Tw3g3lTy1T0FYTgch8jVQ==
X-Google-Smtp-Source: AGHT+IFsS0XnWQ0f2eIOvnxtKkwQc1+JFiTGu1N0s36x0OlGwdwYRVGQDl3qXGcSQ44C5fzJHPotKw==
X-Received: by 2002:a05:6a00:4642:b0:736:4fe0:2661 with SMTP id d2e1a72fcca58-742acce00ddmr15279541b3a.11.1747664778176;
        Mon, 19 May 2025 07:26:18 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:17 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/9] iio: consumer: Add new APIs of triggered_buffer_setup() family
Date: Mon, 19 May 2025 23:25:55 +0900
Message-ID: <20250519-timestamp-v1-3-fcb4f6c2721c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add new versions of the `iio_triggered_buffer_setup_ext()` APIs.
(API names are tentative)
	iio_triggered_buffer_setup_new
	iio_triggered_buffer_setup_ext_new
	devm_iio_triggered_buffer_setup_new
	devm_iio_triggered_buffer_setup_ext_new
	iio_alloc_pollfunc_new
these APIs take a bool parameter named `timestamp_enabled`.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 82 ++++++++++++++++++++++
 drivers/iio/industrialio-trigger.c                 | 33 +++++++++
 include/linux/iio/trigger_consumer.h               |  7 ++
 include/linux/iio/triggered_buffer.h               | 25 +++++++
 4 files changed, 147 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 9bf75dee7ff8..9b99bf884ccb 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -14,6 +14,68 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+int iio_triggered_buffer_setup_ext_new(struct iio_dev *indio_dev,
+					irqreturn_t (*thread)(int irq, void *p),
+					bool timestamp_enabled,
+					enum iio_buffer_direction direction,
+					const struct iio_buffer_setup_ops *setup_ops,
+					const struct iio_dev_attr **buffer_attrs)
+{
+	struct iio_buffer *buffer;
+	int ret;
+
+	/*
+	 * iio_triggered_buffer_cleanup() assumes that the buffer allocated here
+	 * is assigned to indio_dev->buffer but this is only the case if this
+	 * function is the first caller to iio_device_attach_buffer(). If
+	 * indio_dev->buffer is already set then we can't proceed otherwise the
+	 * cleanup function will try to free a buffer that was not allocated here.
+	 */
+	if (indio_dev->buffer)
+		return -EADDRINUSE;
+
+	buffer = iio_kfifo_allocate();
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	indio_dev->pollfunc = iio_alloc_pollfunc_new(thread,
+							timestamp_enabled,
+							IRQF_ONESHOT,
+							indio_dev,
+							"%s_consumer%d",
+							indio_dev->name,
+							iio_device_id(indio_dev));
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
+		goto error_kfifo_free;
+	}
+
+	/* Ring buffer functions - here trigger setup related */
+	indio_dev->setup_ops = setup_ops;
+
+	/* Flag that polled ring buffering is possible */
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
+
+	buffer->direction = direction;
+	buffer->attrs = buffer_attrs;
+
+	ret = iio_device_attach_buffer(indio_dev, buffer);
+	if (ret < 0)
+		goto error_dealloc_pollfunc;
+
+	return 0;
+
+error_dealloc_pollfunc:
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
+error_kfifo_free:
+	iio_kfifo_free(buffer);
+error_ret:
+	return ret;
+}
+EXPORT_SYMBOL(iio_triggered_buffer_setup_ext_new);
+
 /**
  * iio_triggered_buffer_setup_ext() - Setup triggered buffer and pollfunc
  * @indio_dev:		IIO device structure
@@ -114,6 +176,26 @@ static void devm_iio_triggered_buffer_clean(void *indio_dev)
 	iio_triggered_buffer_cleanup(indio_dev);
 }
 
+int devm_iio_triggered_buffer_setup_ext_new(struct device *dev,
+						struct iio_dev *indio_dev,
+						irqreturn_t (*thread)(int irq, void *p),
+						bool timestamp_enabled,
+						enum iio_buffer_direction direction,
+						const struct iio_buffer_setup_ops *ops,
+						const struct iio_dev_attr **buffer_attrs)
+{
+	int ret;
+
+	ret = iio_triggered_buffer_setup_ext_new(indio_dev, thread, timestamp_enabled, direction,
+						     ops, buffer_attrs);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_iio_triggered_buffer_clean,
+					indio_dev);
+}
+EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup_ext_new);
+
 int devm_iio_triggered_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					irqreturn_t (*h)(int irq, void *p),
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..527c3cf84be0 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -361,6 +361,39 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p)
 }
 EXPORT_SYMBOL(iio_pollfunc_store_time);
 
+struct iio_poll_func
+*iio_alloc_pollfunc_new(irqreturn_t (*thread)(int irq, void *p),
+			bool timestamp_enabled,
+			int type,
+			struct iio_dev *indio_dev,
+			const char *fmt,
+			...)
+{
+	va_list vargs;
+	struct iio_poll_func *pf;
+
+	pf = kmalloc(sizeof(*pf), GFP_KERNEL);
+	if (!pf)
+		return NULL;
+	va_start(vargs, fmt);
+	pf->name = kvasprintf(GFP_KERNEL, fmt, vargs);
+	va_end(vargs);
+	if (pf->name == NULL) {
+		kfree(pf);
+		return NULL;
+	}
+	pf->timestamp_enabled = timestamp_enabled;
+	pf->h = NULL;
+	pf->thread = thread;
+	pf->type = type;
+	pf->indio_dev = indio_dev;
+
+	pf->timestamp = 0;
+	pf->timestamp_type = 0;
+	return pf;
+}
+EXPORT_SYMBOL_GPL(iio_alloc_pollfunc_new);
+
 struct iio_poll_func
 *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
 		    irqreturn_t (*thread)(int irq, void *p),
diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index 5e6ff8738386..213cd8560518 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -50,6 +50,13 @@ struct iio_poll_func {
 	bool timestamp_enabled;
 };
 
+__printf(5, 6) struct iio_poll_func
+*iio_alloc_pollfunc_new(irqreturn_t (*thread)(int irq, void *p),
+			bool timestamp_enabled,
+			int type,
+			struct iio_dev *indio_dev,
+			const char *fmt,
+			...);
 
 __printf(5, 6) struct iio_poll_func
 *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
index 29e1fe146879..5648c382a506 100644
--- a/include/linux/iio/triggered_buffer.h
+++ b/include/linux/iio/triggered_buffer.h
@@ -9,6 +9,13 @@ struct iio_dev;
 struct iio_dev_attr;
 struct iio_buffer_setup_ops;
 
+int iio_triggered_buffer_setup_ext_new(struct iio_dev *indio_dev,
+	irqreturn_t (*thread)(int irq, void *p),
+	bool timestamp_enabled,
+	enum iio_buffer_direction direction,
+	const struct iio_buffer_setup_ops *setup_ops,
+	const struct iio_dev_attr **buffer_attrs);
+
 int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 	irqreturn_t (*h)(int irq, void *p),
 	irqreturn_t (*thread)(int irq, void *p),
@@ -17,11 +24,24 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 	const struct iio_dev_attr **buffer_attrs);
 void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
 
+#define iio_triggered_buffer_setup_new(indio_dev, h, timestamp_enabled, setup_ops)	\
+	iio_triggered_buffer_setup_ext_new((indio_dev), (h), (timestamp_enabled),	\
+					IIO_BUFFER_DIRECTION_IN, (setup_ops),		\
+					NULL)
+
 #define iio_triggered_buffer_setup(indio_dev, h, thread, setup_ops)		\
 	iio_triggered_buffer_setup_ext((indio_dev), (h), (thread),		\
 					IIO_BUFFER_DIRECTION_IN, (setup_ops),	\
 					NULL)
 
+int devm_iio_triggered_buffer_setup_ext_new(struct device *dev,
+					struct iio_dev *indio_dev,
+					irqreturn_t (*thread)(int irq, void *p),
+					bool timestamp_enabled,
+					enum iio_buffer_direction direction,
+					const struct iio_buffer_setup_ops *ops,
+					const struct iio_dev_attr **buffer_attrs);
+
 int devm_iio_triggered_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					irqreturn_t (*h)(int irq, void *p),
@@ -30,6 +50,11 @@ int devm_iio_triggered_buffer_setup_ext(struct device *dev,
 					const struct iio_buffer_setup_ops *ops,
 					const struct iio_dev_attr **buffer_attrs);
 
+#define devm_iio_triggered_buffer_setup_new(dev, indio_dev, thread, timestamp_enabled, setup_ops)	\
+	devm_iio_triggered_buffer_setup_ext_new((dev), (indio_dev), (thread), (timestamp_enabled),	\
+					    IIO_BUFFER_DIRECTION_IN,					\
+					    (setup_ops), NULL)
+
 #define devm_iio_triggered_buffer_setup(dev, indio_dev, h, thread, setup_ops)	\
 	devm_iio_triggered_buffer_setup_ext((dev), (indio_dev), (h), (thread),	\
 					    IIO_BUFFER_DIRECTION_IN,		\

-- 
2.43.0

