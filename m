Return-Path: <linux-iio+bounces-5957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3BC8FF6C1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DE7286D2F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB2319D072;
	Thu,  6 Jun 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbefpSuB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2FF19AD5F;
	Thu,  6 Jun 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709049; cv=none; b=aZ3LPyqcF5woys6tbxpJFNnnLcQ36FM7VBy5RMEDO3R32G3Qa38uSoy0nhE9GAjjmbBmio++9/ISNTMfgm5EGo6/WhVGDaw3VMk0v5RrrWdH28nonUbTTT5VGNYfFqmiOxkY2C7x/PhZ12ds+a3wPFQgM0dYqDNP9H/86zivu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709049; c=relaxed/simple;
	bh=CSMmb3T0fKDhA6MFNEPevOEvIzmO0a2jl7kzoeqyjXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mv//QljKqGhEquPlP/j0fOv4IXO6z7gqijrlSegHXbcPS0yt4z7LSVxp/AJQdPJN58gsGBwbAX4h5B1vOOZwejkL3AtrsHTxn47XPI8Mg0I3WCwrKYthpbdRDStghAnAjM7K16NhHE2cell2bXzIq9dxK++PhFE+QBJA9zq4EKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbefpSuB; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a62ef52e837so190895966b.3;
        Thu, 06 Jun 2024 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709042; x=1718313842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzTbYlq74oj4OjHFQuy8JjHg0rPUKiRwywLTZbcw5Ko=;
        b=nbefpSuBoqIKaf0CWmkiEH+l0W1216XUgGnZNhkW0xET9qCp/xtO31uoZMe6fKbxSu
         A38uF7s4VWkZnCIqaB+0GXJ5Y7kKUAG6PHG9G8cBVOjErG7hTui5ZM2DStm9rraMgKjR
         NZ55h//qsNMcHfFFY2HibuCArjhKqROYjTT/reCQiI+ribyv02tsClmZaME7Ppr6waVY
         1/A2obSKt/poBoEYQkAxvThCgQmwCJbB7bx2KKgTtIX88pocuXu1so/K5CV7FxvYg7qC
         VQWRPJWfUb/26sqE9wfXi+2LXzSsH7KQDu0P5WvBBwND71Jk6TWZYsSD5ttHKWdOAZmZ
         6qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709042; x=1718313842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzTbYlq74oj4OjHFQuy8JjHg0rPUKiRwywLTZbcw5Ko=;
        b=oDW46lGPcY4wNWrdl6pJw68PRH7e9nwQW1Jt3c51ctVr5LPrK7bcSQJBJfs8zXkJoM
         40+Hn5xGhRTRbxIObEav286Jm3mZrH4hBXysKXD5y/Ehjwv1lm4Gt+8caTXfYnRXNAx8
         mhN3IjLvYO/Jlv8K5rVKBh8S3t16OJFplQIISyfdCLczcAUApW6bMICDBkbct9kzb616
         l7MLdGEs0lfhPwCaPGLs3QeFrE5hwI56LKUPjgV7GDmdW+tymiilI4YXHBQL92RTU/fz
         M87NllY53zJ5aKjzPh8m5D1xCSuLuiU8/D1evtFtyiFZ/7++yo4+s2oFdm9CPTgO83LV
         RTOw==
X-Forwarded-Encrypted: i=1; AJvYcCUDgMiZgJP5Puet1mr8H/bcJfMLLXL/9Efp90+WGRtMusXYmehKWtF5JLxH58JlGTed/0tVwI667fMTrTFXSNe602qZCEpa1cYNr1a5uB3gVttSyqBLLld0LGHvai0227fCfHSYM3xU
X-Gm-Message-State: AOJu0YzNNilgGdEPuHBg/iZSon56NNm4R4vpdiGVBy+VoHnzKCnO2vuN
	bQliRYioThzABPwJBBCgd1j8gilSx6QzIk5HEPCsf//wBk4mDTHaEf9NTpm+gaQ=
X-Google-Smtp-Source: AGHT+IE8xe4OBvlY4TYeSQhFK7N8gYwFryZIvAEO/SzEyRG9zPrcx9kx1VBK9QNnNhHE5fSuNVgDcg==
X-Received: by 2002:a17:907:7295:b0:a69:1122:7c51 with SMTP id a640c23a62f3a-a6cdc0e7a1fmr64739766b.75.1717709041696;
        Thu, 06 Jun 2024 14:24:01 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:01 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 08/19] iio: chemical: bme680: Remove remaining ACPI-only stuff
Date: Thu,  6 Jun 2024 23:23:00 +0200
Message-Id: <20240606212313.207550-9-vassilisamir@gmail.com>
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

The ACPI ID table was removed with the following 2 commits:
Commit b73d21dccf68 ("iio: bme680_i2c: Remove acpi_device_id table")
Commit f0e4057e97c1 ("iio: bme680_spi: Remove acpi_device_id table")

Remove the remaining ACPI related stuff to this driver since they are
not directly used.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index acca2e516157..1956b456141d 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -8,7 +8,6 @@
  * Datasheet:
  * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME680-DS001-00.pdf
  */
-#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
@@ -927,17 +926,6 @@ static const struct iio_info bme680_info = {
 	.attrs = &bme680_attribute_group,
 };
 
-static const char *bme680_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name)
 {
@@ -969,9 +957,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	if (!name && ACPI_HANDLE(dev))
-		name = bme680_match_acpi_device(dev);
-
 	data = iio_priv(indio_dev);
 	mutex_init(&data->lock);
 	dev_set_drvdata(dev, indio_dev);
-- 
2.25.1


