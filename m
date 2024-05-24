Return-Path: <linux-iio+bounces-5254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75888CE2C4
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DDB1C2127D
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DD912AAF4;
	Fri, 24 May 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQVW1GXj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19612AAC3;
	Fri, 24 May 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541247; cv=none; b=O15qUMXPoUpatKG4lUwLmedq6QUOEEEbcGeuwqQfo5qsu+HbLgGnqxuOrU3jvq5UQGbhuTu8fUCxyy5WbDBlhjBG3uzmKDsN7PhlToB+kza7qZ9wwjRyBDAUm1rfsbaxBR/kKcEGKONFejOJdq8tMhO6tYdDU80jg/x6pWZfbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541247; c=relaxed/simple;
	bh=+ncD8XxCsjn1JO9JXYfQaG7MMFKhgUCIZY6bXS+Exs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeBQhrCW9xYEipP3oYa67M77T5zouOTX/rJffZpVp4qqvIuyonvVoeRckLAcFEg8+CjCIdB6FZ4+YEo8tjSJEj8roWzqqa73wWCuhJilcl1DXlZp9Xq4JdtZYJEBipob5pHBmeXgCyOTtJMb3OMWngkp1ZiHPW2qqgSr2efy10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQVW1GXj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d3ccf7so63297866b.0;
        Fri, 24 May 2024 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541243; x=1717146043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdIJTxDz373t92nzbtq5KxcQvr6iSpjtsZdj9sCY/Pc=;
        b=VQVW1GXjI+CCSaBXl5yox/2B697jykeodJz2U5ZLUIOgomRhIXilUzZt1o1E7kcTBD
         uzEfAcLVQIWnfgzCRNrvV45EBpqQ5W1G2eom99i5ei/k8PGWKrY5eXPtF4b9Fsg8f1e/
         ObHkTmpmv0mc6TcpEwUE7qKU1KFNgeC2RZWZn5K4gYOjjxSLSAs4hKn3MFXCt3mA2ceh
         y4yqauHfv9PHloudtMLHITx/VoR/a73Rw4+AoDQj5xlS9FpUtnLVUS28SP7oj91I2GLp
         fyFh3RbI5WWozbL42Ll0V75pDpnPl1gstvvR5O072LhpK7CC5YyM20wWySze7yDrjW7e
         qabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541243; x=1717146043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdIJTxDz373t92nzbtq5KxcQvr6iSpjtsZdj9sCY/Pc=;
        b=Alq7FkW/jV51LuaQN9RBqqiAKiygCn+E8VnM4vZ+rikQliJPyUjPMZvikTjeiLfQ9x
         WMBRxCbZ20Xx51soznOUlIKsHJGY42H6nExQr8H39LjZPlOkHsrzk+sqN3FBjvbQuq2W
         BEH/4rmp2LpIHplWBepYSMMOK0uzX/8S9J6qEBoUQ5NlFo9KRX6n5lE14ykUfFBzF8Tn
         4/aItAiZ78tRUoHegCwz/V3pqPhrRjWrBXrk24o6DWn1w2kYRZf6PlyzgJpk8lbvkYdW
         p1OfIhOmLh26Z4DujbniimKTUtpe/j6tmbeE2UeuicJ6ZppkUbmsqK8K2ECa+VPUXRG7
         2raQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVuWnSstYBkOAyNLx6JsxxXgVqXGkFqPJyXDCpaOGc4e286vjIM0Vs0nKX0z6vCpBuLK5yQ0pk89ctvtAmlSlWNJbKEmNsIH/7h3LwhBlRHLtV1UfZMfL6D5EJMHbuVEswunfRWg==
X-Gm-Message-State: AOJu0YzEgqR2lS/xTPOYAnLBOzHRSSdeVNs7SUFPnyau+SMfOgM6/ILk
	ts5t4kSEOUbOtS1wMRrCMRQvQ7BLquliBxovvn8mGjRx8W0K3ZykMQImpjCuS4U=
X-Google-Smtp-Source: AGHT+IFHyWK/uaWsLvv9poOVLUEhH/ZDCJS5IgtXsVyAJjzG84LoKo7VKlObsyZucZbuS6acTRUJPg==
X-Received: by 2002:a17:906:13c4:b0:a59:c39b:6bc3 with SMTP id a640c23a62f3a-a6264f0e4d6mr109087666b.49.1716541243176;
        Fri, 24 May 2024 02:00:43 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:42 -0700 (PDT)
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
Subject: [PATCH v4 04/10] iio: imu: adis_buffer: Add buffer setup API with buffer attributes
Date: Fri, 24 May 2024 12:00:25 +0300
Message-Id: <20240524090030.336427-5-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
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
no changes in v4
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


