Return-Path: <linux-iio+bounces-5956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC4F8FF6C0
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E674284145
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB919B58E;
	Thu,  6 Jun 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSmrK+eJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE619B3FF;
	Thu,  6 Jun 2024 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709048; cv=none; b=hqBcZ6NJvNz6ie+0tPdEYVG4yrQhPgYedqS20Iu6PdsdWaKASviHzaTuCDP+bYlSDtTXylhGERG2STjtKYOS+S8lhmKdJ0PjRD77FdPFF5ErC9zACW7dB1qbf04ITygqVh1P2+SyTjmwWGs0+azw24mnUSe82NyFf0KF9UfAqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709048; c=relaxed/simple;
	bh=sYfKjrl9ZKUiAdoE6IMECebcFxxH1sMa9MbwjyeN9O8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSiaOpXo4gbf+M20J8QMaN+wlc4Kp26ClwZg4/CrvwEgHT+2iBWu3j7ArMo4Oj7PXhISZAi2l69v1E/zoOnN3RU0dQX9ExJ9fDUUkJ119263AYGo7e/BRDD1RypqZXIrVeE4aPGlELvwd86uP0IrnTQQFqiQA1w+uFPQM1BrTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSmrK+eJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68fc86acfaso230258266b.1;
        Thu, 06 Jun 2024 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709046; x=1718313846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnwHnvW5yFZ1H4ue2cPFcV1vzyXiNyUsD+Kfb9v7TxY=;
        b=nSmrK+eJmoLb/H6mRTJkRvVnhkPt22p6ue+pSSTzNMJH56PhUT2/ZtOxRRe9aLJe+5
         kyvxhzj3D20v8MopsqeRlh0/OYb8w0YuZpdV3xBMFWFOy3jZyLxZyl8o79ypxLGTnMHT
         RjZuw7dBHOxT8Uh9VqecFFgXsFUxHKu818ZMs3HG6K6jK5C3tdAlegCqldB1kcPDg6IR
         Xq8uAi2Zo6ptY25WHTvF6Y+/3POaPM1ZzUx5D3Z/x4VmZ8wVyPLZFv3uh5dO3AgLmEse
         ep9kWpDENeufwgNpTW1k4nBGMT5uM/x5cubBDtaPKntv7Js2LauDI+yUnFz7NH58ftry
         h77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709046; x=1718313846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnwHnvW5yFZ1H4ue2cPFcV1vzyXiNyUsD+Kfb9v7TxY=;
        b=jzu2O3U6I6WqUs7LW2VkS6bHYtgVsorze8PIK/N9E0V5rffftRLAH0BvWrPILYI1W8
         NcC7vsT5rXFNvW1rBYckLIdJnssmSAj4dKSzR0DWGa5zjGic3lqF6jPGi2Tn7FMmyNXK
         qg7MKhzsc4BTww0/mOKIUXFTwxhVxoDVHdFm+ls7yVQzj/sFaFZ+IJD4j0rJOqXWH7++
         yRZlDB5NBInULSk7Ptte3wfLo72nXusM1GvIXH0atM3HJdRMZqoKLcDXfQ7mhgMCsBkh
         OyegAv6GbXq7No2QfTpXCDVM3ixLxvynuEb2+3DFCPYgUbqGCDj7Tbk27lO/VxrIVS9E
         k1KA==
X-Forwarded-Encrypted: i=1; AJvYcCWiAn6oeZtvHUR/U1J+CcV+CN+XeSOu4DO7ier0xJ9qHk69AbdnexIzwFpVS9OD3n/UwTXUQ0UA+ppYnCij4r9s9e2QuZpN9Yib06uDkDLFMkE0CQDZCMhqdToXL7X/PwzsfSiDOpGC
X-Gm-Message-State: AOJu0Yxp7XFAVw9WRH4/cn5YH2EOf/jYaWY4c5iSEBhYublzDfoY3mUC
	no6TQC7ZtJ0wt+fn0qQYPp2Yo9PK8MAhaEbEx07SE60cUpBVnSB3HptbF8W9KpE=
X-Google-Smtp-Source: AGHT+IERW3+GzIMieJrPC9ajVs+Yc79VVDWip5E+OTbhafFhNWgBjeEhxlFY20Ov0kgJ11M2he9iMw==
X-Received: by 2002:a17:906:e218:b0:a68:a476:6957 with SMTP id a640c23a62f3a-a6c7650a2ffmr311918066b.24.1717709045862;
        Thu, 06 Jun 2024 14:24:05 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:05 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 12/19] iio: chemical: bme680: Allocate IIO device before chip initialization
Date: Thu,  6 Jun 2024 23:23:04 +0200
Message-Id: <20240606212313.207550-13-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the IIO device allocation before the actual initialization
of the chip to be more consistent with most IIO drivers and also
to have the ability to use any driver specific data for the chip
initialization.

While at it, fix also a misaligned line.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 38 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index f96cd4157c95..9d33952e5d01 100644
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


