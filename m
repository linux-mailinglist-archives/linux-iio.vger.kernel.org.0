Return-Path: <linux-iio+bounces-5330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5238D04F1
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D761C21527
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18C174ED1;
	Mon, 27 May 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3gXwsC2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E717333E;
	Mon, 27 May 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819991; cv=none; b=AVEbmmeu41KzYsU2IPYGIORKfoaLp5qC7YeTeDbFnLn3evAOE1ckAe02dd+olymNsujX+5R6cMfdEr3w3bxoovSsQewMdjME7gkQjenx1Ilrm7JtLL/2Cb6wWV1U+KhYcb2ad/o05/rXaUy/SRJfv/nlfn0N9acV2za9DOFdA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819991; c=relaxed/simple;
	bh=RMPXJYEwFOZroUgmkuxwKqtKKgiemJd22bvUxZqSvWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntlGuYZ6Xqp2h9RzpGU9b5aCwKBXv8+GA2iKVD1HYW8egZcSc8YZV5uzkfw1DUsBIiOeUTr7dFiOvOha3RBxZ7dbp8ZgiDsPqwtfqOApqCApNzvReQH8HJk3SvXlGzAmC80BAKSfQNtYOTyAGplzPHeoC/KwQ9ScKOUrYuGuiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3gXwsC2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e96f298fbdso23707271fa.1;
        Mon, 27 May 2024 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819987; x=1717424787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKDi0ODpalwh7XFfa3z0kEIRqjnKQETIGu0AgUCOPmo=;
        b=Z3gXwsC2/prMXEsD464jCP4mZAv37X2Q39uH8KIloMEfvVO7ShwiZ4YvjLyJoSywPm
         C7oBxXJ+C558Cu2lmze+uB4mH0ssV9TbT2RrTttnZ9HNZjqvZakfQ9zuJTF/5nvDf/Rn
         PFn31sMArqV32sfO9n0nGcahvKuR2+yAknOY1b8py4pxdfbkvnbZuXzuboPgZh2VLEGc
         yUkBI2h/cijiP9zmA2Al6pit/o5BfKFpud2VFcj37eexEKv3QqBLOn0a+LQWWUxzvbyS
         pvtvjsnWVoGwB5eQn/BOQ/necU7fQlsf4Jy6fh/YZdTpisgzIELFua2P3fBUhcPe+bsH
         EoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819987; x=1717424787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKDi0ODpalwh7XFfa3z0kEIRqjnKQETIGu0AgUCOPmo=;
        b=SKAYpkYf5lMCXjB8FDXaCtEosiZIdf6OS57sTnFK2VBKWP0f5UWvCFaMijHcy1MHEu
         Y09afhhg1R26NL5Fk4pmC/8Cu5QH5TxrSn0IhEt/vxSgTJ0atTBtr8mNb/q9wXVtzayh
         lZYw1fNxOCNAeNvMcvREpoSlyuC/Rdhkz37eZMvZNZ/CqB4Bl64n7Bf+gY1RL1xvNdwD
         /a5nZ7fxIU+95TSd1cMmBVn76hTLKgEmTzh2RCYh1fpp4/rZxG1g+Ye69C6yfFUCldJf
         B7HajSECrXLGfKwqPM+IhwUV8b2YacKPS2G+chskb1/Sa/N1Ke1ZLcN2SZo2zMmvhZJ9
         p0kg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Fv9knysFDaPKjwSdPWZEAM+xEfu6dXaCKlbazuoHdpQCh1LDASvdMxQOIUpbNpCBx/laaxmjJB6PcP77jcKmO2c3ikIguPWlvraB53mACfMWNepAPSUZ1teDS52EBhnHfdreUw==
X-Gm-Message-State: AOJu0YzDl1+ySKH/paY5UNE+rWUVbQF9mzCKtbpiZu9YmjRXB09hE3u5
	RjHnJI5r6Ne5qSNiRACjnvhn54H/Z9Gg+x7RAZQjMjNPKEe5qi0QyVzXDM3in2o=
X-Google-Smtp-Source: AGHT+IERT67ezaWwD+jVSrKGh3jzVEvnAAmbHcjAERdxJl6xF+uiKlcoE5xSiJNPR7jFbUU6gGVEMw==
X-Received: by 2002:a2e:2a45:0:b0:2e9:820b:c38d with SMTP id 38308e7fff4ca-2e9820bc6ffmr6699461fa.36.1716819987269;
        Mon, 27 May 2024 07:26:27 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:9c9:f6ef:e79b:45ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm110537875e9.38.2024.05.27.07.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:26 -0700 (PDT)
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
Subject: [PATCH v5 3/9] iio: imu: adis_buffer: Add buffer setup API with buffer attributes
Date: Mon, 27 May 2024 17:26:12 +0300
Message-Id: <20240527142618.275897-4-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
References: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
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

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v5:
 - added line break after adis in devm_adis_setup_buffer_and_trigger_with_attrs
 drivers/iio/imu/adis_buffer.c | 32 ++++++++++++++++++--------------
 include/linux/iio/imu/adis.h  | 20 ++++++++++++++++----
 2 files changed, 34 insertions(+), 18 deletions(-)

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
index 8898966bc0f0..0fe3a2f63033 100644
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

@@ -529,8 +538,11 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 #else /* CONFIG_IIO_BUFFER */

 static inline int
-devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
-				   irq_handler_t trigger_handler)
+devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis,
+					      struct iio_dev *indio_dev,
+					      irq_handler_t trigger_handler,
+					      const struct iio_buffer_setup_ops *ops,
+					      const struct iio_dev_attr **buffer_attrs)
 {
 	return 0;
 }
--
2.34.1


