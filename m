Return-Path: <linux-iio+bounces-18106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DAEA88B8B
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C71A189A363
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F59192D6B;
	Mon, 14 Apr 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2KmabLj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4D28BA85;
	Mon, 14 Apr 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656174; cv=none; b=Bph8sN6UruqCxX2Mgxr8yc5o2Oqs/AbfLT+DgrX1Q0JXhHNHOHO7u6po+SI0aF9Jlnw9Ym+GdpkWwfwnGhgn6wn1m2dxyuFdkzTH3qGx+OMVHva14YDTpzqtmu+YtTvHoo9t0v/HKOtGzjo26LRxMc1++Tab0Lv+UNFJciJoHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656174; c=relaxed/simple;
	bh=fM3+KC/UZ31kXPGTb5S0rsSfrRmlbZY6btYAdurQouc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e21YUCE5BCGaCsvLNsaIZmKnmcYs/htphqkSMQov3KWR/wBvHu8ZBeT1/EUPgxBDEl4tuw2/2CuTzBiDwMrQ6L3SPrGmdXYUvHSHhDas3RvXnSioP/85lN47zFwS9Z1AWjox8BndgyJFo7UsaQPFdLwljCT4/rsf4fMSSFY1+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2KmabLj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac3f58b9156so57826166b.1;
        Mon, 14 Apr 2025 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656171; x=1745260971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL1NluBLKnVOXTYYd19e7pbv7E9LsYXKQXHoL8wk6rg=;
        b=e2KmabLjVPcz75xXzzGsB3qBO3DzmsSaiFPOoF7Cf6uE/qg7oRBm5DLGpmZLky7cw/
         Y/dzwHXnNJLmT/DS5VJ8iLfulTlGSxcskI+1eUQYSlS2RDDKmM+TkHqfDBQ0mxydvKE6
         tn1BbVhK4n3Zsmou3JatmA5teHE+L1QGXsDvCOOCNGI7ffQltnGdA6P193O4lBNeak7W
         WZNfKSuKLRlJx36YCQeri1Vu1DM/2t52TZPVMOEf9XnI+Fnh6FP9ZRUJf3835ZYzKFOY
         9Hzu3ObPJrIY02B7wORtwdQNsAVOX1t5CS4Lkapm9FkbfySet/ONvxaZQa89Z6/a4y8e
         NPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656171; x=1745260971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL1NluBLKnVOXTYYd19e7pbv7E9LsYXKQXHoL8wk6rg=;
        b=qDBaNv0N6FARrCQV3hGPmBztWtZCR9497H8epwLS71VvctTPwhB6voHmla4/2yLPNH
         ta8z95/cGPt591mpEupy6fo+/uSw1g9QSHhlCLCmXU67+jvW4hU+j4RZqGKYArkAMPfO
         PKm1GIi+bTqlUACtODdSWyhlnqaftPX5uWbnW4Ocra9xCGfuWye8KKF6dY3Ytvz75YsU
         l/WPuUbfIAMDJKG67J+yXbLLy4KrfapCVTPcn2chSEHOOi/m/dnLmw5gXvT8xFs6k/Uq
         AuVj7A3pkCJQAmyHdGrKF7k5b0wbHjbXv6OyRxqHFGdqauy0I4Nsle4+71s5A8yz/mRA
         H4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWT+12EY7TTgUzFKNW8oIvJjD0yWHXMfjsYVr3pM/hn5kW+ZYQ0CjvjPYuE8aQTlXU6K+xRLiUVIRDjaEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3QiUJUnAdBaYI96cbHEnYM/sLSU8hoRBKo39TOGLPFoHIZCxf
	qOhlVFUc5L7vvRWuNPW1CHRTKA+xim//2oFmNJMn5XnjXIGbrv/B
X-Gm-Gg: ASbGncuCp1Zt1Uw9zBSC73yMkoz/zQIqf4fk6K6sbRdPxZ85+Bb4srLDoSoulqZqcKD
	vvevWhvoCXyWRI5XJqOiD6mfKziBebq0s7TEE4O75iQIoh4tZQvDf4N4NsJgKikg8sZ8DCuAjdH
	duLMBlY0HRCpoWe7YsOZpV9T1PjZM6rYHACMN0iRaVSf/FIF1pn344X8EizKK8J9TkBKi35vFy8
	av4+Af+4lRzVDrbaxS2qUhmXOm3oDcog5kPoK7OzTODH6ONTM2+XMfL8B/ggEkVKJ1GtkJ9ZdV3
	MQkBK6BTQqFt/ci6FhA3wV7KOaHmDl51g6LE/9GeGhokK3kekAZN7B/oYWeqmlXkCF7DH8ndnnr
	OvVk16pgEklyngUI1K6LudxMdZTOaBQ==
X-Google-Smtp-Source: AGHT+IGFOPrgXPclowiGFYIQKb812Qh2MFB6TP+Vy9uyAexDlY8mHJLLmm0XlxO0VSkg0mlGaPssHA==
X-Received: by 2002:a17:907:db08:b0:ac7:3910:16ad with SMTP id a640c23a62f3a-acad36db7c9mr406154566b.16.1744656170581;
        Mon, 14 Apr 2025 11:42:50 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:50 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 01/11] iio: accel: adxl345: introduce adxl345_push_event function
Date: Mon, 14 Apr 2025 18:42:35 +0000
Message-Id: <20250414184245.100280-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414184245.100280-1-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the fifo handling into a separate function. This is a preparation
for a generic handling of the interrupt status register results. The
function is supposed to handle particular sensor events, and later to
forward them to the iio channel. This is needed to read out the interrupt
status register.

The function shall return occurring errors, if any, or 0 in case of
handled events or read fifo content. Thus migrate fifo read-out and push
fifo content to iio channels into this function to be built up with
additional event handling.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 1b4d9e60c87d..a98fb7fc748e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -416,6 +416,23 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int samples;
+
+	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
+		samples = adxl345_get_samples(st);
+		if (samples < 0)
+			return -EINVAL;
+
+		if (adxl345_fifo_push(indio_dev, samples) < 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * adxl345_irq_handler() - Handle irqs of the ADXL345.
  * @irq: The irq being handled.
@@ -428,19 +445,12 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct iio_dev *indio_dev = p;
 	struct adxl345_state *st = iio_priv(indio_dev);
 	int int_stat;
-	int samples;
 
 	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
-		samples = adxl345_get_samples(st);
-		if (samples < 0)
-			goto err;
-
-		if (adxl345_fifo_push(indio_dev, samples) < 0)
-			goto err;
-	}
+	if (adxl345_push_event(indio_dev, int_stat))
+		goto err;
 
 	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
 		goto err;
-- 
2.39.5


