Return-Path: <linux-iio+bounces-9869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B67989511
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 13:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AF328347C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817F716E892;
	Sun, 29 Sep 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRUz+ety"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238F169397;
	Sun, 29 Sep 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727609122; cv=none; b=PrR8Tgnms9Qk6e72v+FgU08tulM52nZrCWU5u1vEwBTBw+dVbdeW/pUpkp+D8Ez7Jpo5ObXzqiHyzcMLbMzqaJh09yLgbIfRZqAAfE9F3ysq9b6+KNx5asOy+VGEYZ857hCg0KTENnNlY+ZzjQu2S6fmn9R0p/O8BY+nfxai6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727609122; c=relaxed/simple;
	bh=gxxA7ivFjr7HRIAjjFplPqLBO2UpR0l/wOIidePeYAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U1Z1S/U8MyVTfHIsKZnp0oN9F0UHFiV/Z+3IijiVBwEbZpzBRqRZhZPu7lAPODHsHYUTQbUPkuqnqbTdIG8SCxZDPEn53bzFCk8eYANaSdScJFmVx60L6DPm+hVZfriWpbIaep7tjAKfZvhAYr9t4TonUGiRDHOkHqkzPMArkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRUz+ety; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so27890985e9.3;
        Sun, 29 Sep 2024 04:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727609119; x=1728213919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4S0wSFiMXvjsH1D6RegaYvTzs4XY/u0KzJSxFKGOBg=;
        b=gRUz+etyRlvYgTtunEyQ5fsg+Ze8JLOFrG5ei2PqZqRIhy3AKTiv7dOlF61kGVcJT3
         7zA+BdgJ0lTUdS728b+XIH8U6+cYOsLVKhGsMrTxnDTnsTPn41Qe6drFdbhCR8tQYN1x
         17TiRf7o1IFzGM0gL/dYCyDnSzrJuVUguW6wIm0QGnnJfys0/1N9a3WoAef5iFc5kGpo
         +XF6+Cii+UAYWGx4qYuc9wbroBvjt1wx9qcBRCwuvDkK3RMKz9V7BdL7Bar+VH8dvnQH
         vrjA8tuAfl7Gzoor/PKtJ6bUWkLNyC/GSBRKvlKMl0GT6YRLFjEODqNNFDbBWm4xAlc4
         lGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727609119; x=1728213919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4S0wSFiMXvjsH1D6RegaYvTzs4XY/u0KzJSxFKGOBg=;
        b=PtT3rnjbqx6U+22tLxB6HvTk/oogcABbFfDS9+huIljgdtwG3CPcrzn2wGTo9v0olb
         IZrjokgz8QxL9NNJBCWDi9y9FDL80YyTDoIzLq4bPCnDjUmzixoGXowAroUEhKA2BwVm
         EOqkpN/DPXUPBwpytXFnxbYPeItVyFS8LLOc0rmjAyOOIiBi83Dbw//808WC/i4JCU8/
         IYVBXWS4zX7jRojK/tCItf8ucTtmTZOqM9uOJoezPNSWHyKv5kcsdJ7WTgGczP+rOmFb
         lG1SDMegv5ZOujbS0E8wkM0fD73BeOZH9UXruOtmIaVASOOIOfAu/txG/L889c3fxEGx
         imwA==
X-Forwarded-Encrypted: i=1; AJvYcCUjs11HJGIRBm8VfCGaV/v5ol0CN61XieQZif41vOz6KLEqrP0wTQuV8AwJGP7PqyHWlL4kd4fi7uHNs7kW@vger.kernel.org, AJvYcCXHg+3vpQHCcB68AdjHUalu/Ln+YUtn+XT+uMEUPyY4Z73lcu6AIiOYNLpjN8msIMmOFFliXjXg4NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6v3y+KkdzhTM+WqpVuvo6RH4VRXIGH0jsmbovHqs966QKCK58
	aiqxG1o2ZvFnVAyPqnZUqDaZlmnTK1hrGMBJ9bZSTXVPfKUMXG+f
X-Google-Smtp-Source: AGHT+IFPeppOHhODTxr3htPy4n0zQokuoKB5riVLiHmZoDcNVKgvc3++7qVL7a9F4ApNFr3qxT/3pA==
X-Received: by 2002:a05:600c:510d:b0:42c:c08e:c315 with SMTP id 5b1f17b1804b1-42f584481b5mr68498465e9.16.1727609118771;
        Sun, 29 Sep 2024 04:25:18 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:df60:d786:cd5:d3c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57de1192sm74717325e9.14.2024.09.29.04.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 04:25:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 1/2] iio: pressure: bmp280: Fix type for raw values
Date: Sun, 29 Sep 2024 13:25:10 +0200
Message-Id: <20240929112511.100292-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240929112511.100292-1-vassilisamir@gmail.com>
References: <20240929112511.100292-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adc values coming directly from the sensor in the BM{E,P}{2,3}xx
sensors are unsigned values so treat them as such.

Fixes: 80cd23f43ddc ("iio: pressure: bmp280: Add triggered buffer support")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6c2606f34ec4..472a6696303b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1023,7 +1023,8 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	s32 adc_temp, adc_press, t_fine;
+	u32 adc_temp, adc_press;
+	s32 t_fine;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1137,7 +1138,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	s32 adc_temp, adc_press, adc_humidity, t_fine;
+	u32 adc_temp, adc_press, adc_humidity;
+	s32 t_fine;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1616,7 +1618,8 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	s32 adc_temp, adc_press, t_fine;
+	u32 adc_temp, adc_press;
+	s32 t_fine;
 	int ret;
 
 	guard(mutex)(&data->lock);
-- 
2.25.1


