Return-Path: <linux-iio+bounces-6126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0E9018B1
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801A328134B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED74274074;
	Sun,  9 Jun 2024 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbkdsQ93"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130673539;
	Sun,  9 Jun 2024 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976322; cv=none; b=RHFdF9ao1PD4MOv65Bw3wo/c/4RW3cFsFBelCribDIMBMgcHEuNwhGlhYGRz5DvBNjy/bZP9npMdXxDS0P/zYI2vb3efbWza/fPXJCaODgENAEkd4Ghfl5p/xEh0n5QERRfp2MnRrezdcVcx/V3IzGp33CfaJv9io7ar236mCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976322; c=relaxed/simple;
	bh=Hfb3FXLY0jr5pWcGc5sD5mDS5XumgG1uHHXw/e5JYu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jv3OdALG+h0bJJKhYQQMIkalMba+JUmtVAMYTaFYpsqZ5nbXY4yoCkXemm5ubSrFbkOtIw8r6ZyDlxw8Z9A4LRZwJV8j8g99bvHb/c5TVp1jWUq33aeRyGCXMSkE4fv5sMLTTs+WAotqHCoxYLOP3c1cccjYkRI/ZS5mXLDNBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbkdsQ93; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso370786966b.1;
        Sun, 09 Jun 2024 16:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976320; x=1718581120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DCTb+Pv7ST7rOA5pIjw+wTL/eb7fOtCFb+LXYKEqh8=;
        b=lbkdsQ93C+nsUWE88O0qmiGMBKe8gF/j5p4MjeSDc+cPsTZpbzDvEJLjbf5nqcBLqa
         gibv+zIfiKCUHgFcCPFEZoJktAAyXl72BcjzJRhUht5CgAkBWBtLlUrR/dK3fT5Ey7oT
         oVT2gbVBTXlH86n2S5Omc0rtZ/ujuFxOSwWlilWNCfJBnOJ0LJCvypjLALkJ8GNz0Z7B
         xGq5A5jGftgkcZM40VtuBauvD+TGmULG0v013mDEUkoaYlC4DzgLgNL7X0VYprLCs7rX
         GzbkkPQXZqGYdLOWBYgzVesLQ6zRLL5AgQ1eBYGZclf7/8YlGUnmV2XZ7pD1+KEkPXBg
         cR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976320; x=1718581120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DCTb+Pv7ST7rOA5pIjw+wTL/eb7fOtCFb+LXYKEqh8=;
        b=MilnMGSqGsKfhuiTgzwEG1o/2X/w0XzcZAtEwQ/PUznTe1Pa0t49tJOQVbblu0cNOY
         fFX5HEXl5DEF+VpedLIswQJMD42inXEMRYnh/8YbscwCh3PeNr879P5o/0OpaosiPJYu
         yWKwSqFE+5zhrpw4jXGx7/yiKxFuH2rww3l/7D1YGCIGeuSmJwSrAjHeygqRT2LJaQu4
         vAtYXdUP5jDfGg80mHiAkW8zjujX8JsTIhBq+nQ8prAbCZYeYLpA43wp0yU3Cqxl8DDg
         SuXJZJ1YCFXg4Qy6Ne3v3b8eTGp9O0mlha549VJmcJJLuQzEgumrGIQ+hd+EjDsw4fw8
         qAMA==
X-Forwarded-Encrypted: i=1; AJvYcCWCHIJZIaNwC0u4Rm1432BWEOQ8ufaG7vhBvK79kp8piNFbZ+fufxHX5I63+Appv+DMg2Fw49SUUocjlkjS0Q6MAm+6tT7efxEV9tRO6yGz3tYIDqUHGGRVzk8BUZ15sZc/EwlN4reY
X-Gm-Message-State: AOJu0YyP3cYuh6wsEWNzyAB2IMxUiJNDscV0J/fQSPsVdxZRibxcZiPM
	qnXGD5kYL0YScnWxcjj8yJeGnEkGyUd+t8xYgqSAcuJ92DT2AFOYQCMsXQ==
X-Google-Smtp-Source: AGHT+IFHLm7IU2p83vb2gx+K5EKm7HQ/WiO1JOj+Qus0le7+FIaREqjV4iFyWKLqCKC5C0wD9NhvUQ==
X-Received: by 2002:a17:906:5589:b0:a6e:feb8:eb15 with SMTP id a640c23a62f3a-a6efeb8f4f8mr283786166b.38.1717976319585;
        Sun, 09 Jun 2024 16:38:39 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:39 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 08/15] iio: chemical: bme680: Allocate IIO device before chip initialization
Date: Mon, 10 Jun 2024 01:38:19 +0200
Message-Id: <20240609233826.330516-9-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the IIO device allocation before the actual initialization of the
chip to be more consistent with most IIO drivers and also to have the
ability to use any driver specific data for the chip initialization.

While at it, fix also a misaligned line.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 38 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 493d190f4461..7dfe4bf2f2ae 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -837,25 +837,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	unsigned int val;
 	int ret;
 
-	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
-			   BME680_CMD_SOFTRESET);
-	if (ret < 0) {
-		dev_err(dev, "Failed to reset chip\n");
-		return ret;
-	}
-
-	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
-	if (ret < 0) {
-		dev_err(dev, "Error reading chip ID\n");
-		return ret;
-	}
-
-	if (val != BME680_CHIP_ID_VAL) {
-		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
-				val, BME680_CHIP_ID_VAL);
-		return -ENODEV;
-	}
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -877,6 +858,25 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	data->heater_temp = 320; /* degree Celsius */
 	data->heater_dur = 150;  /* milliseconds */
 
+	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
+			   BME680_CMD_SOFTRESET);
+	if (ret < 0) {
+		dev_err(dev, "Failed to reset chip\n");
+		return ret;
+	}
+
+	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
+	if (ret < 0) {
+		dev_err(dev, "Error reading chip ID\n");
+		return ret;
+	}
+
+	if (val != BME680_CHIP_ID_VAL) {
+		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
+			val, BME680_CHIP_ID_VAL);
+		return -ENODEV;
+	}
+
 	ret = bme680_chip_config(data);
 	if (ret < 0) {
 		dev_err(dev, "failed to set chip_config data\n");
-- 
2.25.1


