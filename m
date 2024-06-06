Return-Path: <linux-iio+bounces-5954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBDB8FF6BD
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB51F25FF5
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429D619B3F6;
	Thu,  6 Jun 2024 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1fP3k70"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93B19ADB5;
	Thu,  6 Jun 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709047; cv=none; b=svuopflRvI8Qq5DmvAqE6c8p4P/G9WjxBtgP24oO3fXhm29njmgaNyRspcW6gLKdXywM0/MeMjfzU0q3qmWtU+k0bmfoa96OXE0OMl+y4VHy5wQT1jiByE/FL0kRJ3XylggHfMYQYlZb4xONw/GvQPbpbuE/UyMrpf67cfvb6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709047; c=relaxed/simple;
	bh=Ta7SqwQrXrbENkewVxz0Ak99cgbEAJm3C02JLKjUyfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5yi31ZmKpTAM1APWCrNIMCtkJj85ON5cJcqouCOmj4CQULHzlmyuNl+0/YBCfsgDefeyrZoPF+cG37hBwpRxRuKsJ8s061raFkddIFvB6DqinE3/4pxZY6Us/vWFdkvXMg7rY4FLeH4R1kk6PPpVA2ajOHS+w0lheQ1Kj9KT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1fP3k70; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68bf84d747so139052866b.3;
        Thu, 06 Jun 2024 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709044; x=1718313844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+duZJpyTdjjpnaYpux8CIQijG0wZW+zlVh+jOIL25Y=;
        b=g1fP3k70imxQ4cxUb7CriR42U/NVSubCOxi3VlJCGpXv3ASljbcsDkLyxaS0nIC160
         Mcy3QKBLa69wZJq7BtyRCkbTrUpRMNnDGVwGiUyBnFe4ySDVmzbcBlbcv0hlqgZe66m1
         sV0DWvtTrV/mTBX+uewn8tQ4x9Re3r24kBaab/ksTjLc1tgWxD3Nw3SKL//BYqrrHop4
         D1X1g98zudZRli4fz+PG3popVjKqT+xJ3WXilCZcBDgej/yndlWrmU785G+acQgn6/1I
         KaRH2wn8geVfi39gc07kLSwOYvdmKc9OHoj0DnF6AiYbFZTVivQDm90P3gSRKP98iTAn
         rgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709044; x=1718313844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+duZJpyTdjjpnaYpux8CIQijG0wZW+zlVh+jOIL25Y=;
        b=nZmmuEY2oTjNcirDu8sjZfpgqagUxgxDiWdWJ7Y2LDzIPMztguyehroS0gnGU7Y+TI
         MoNn9lqJ1HWpwU8UDP3OqmSXzCqkyxpY3sDmuoiBbE2gBPCVdZtf/OCj2i5kWqkedGdz
         upTKT6YvaOe0URi9wCMkc6EPaNWZS/m7Olcs3ru0nVOA9yABx+IdxqztzGnC7VV45td8
         6jLEemoQZja6RkPm2dVYdrYA0eebOw6eldgHVjRBne+u9dvAAQVXRd9O2Jjm5V707vvI
         YcLam0JTdh0sNMRDT5QONj0D+5irbvw21IVLvCyIqc44YtWDBLYqZyBV6qcq5ipMlhF/
         PzJg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Y5hSMYCioyQFl1Dk1jaP0f8Q2klUhVdG1blqSrlDtKfJNSo6nvpGeRXYZcR0/UEh3zO+YiN+rpdfoh8N4jdzuLoeCfB+8Fx0OGsOiwgexgTKQIjZWyyxoS9mWhJQP7xrXKELWg4K
X-Gm-Message-State: AOJu0YzKyiBU/qaqV9LVc1o6I6K0goxWfndcOFSJ6F9hSYG/OlKOT3H6
	0TdC4vqqQrYRkvfN31MO6su8m3zQGqezNhP0bD+DNCUDh8iQUUpk
X-Google-Smtp-Source: AGHT+IF2AIyjpZNbSgxuHYF5scrf5EVkCY0Lz2vXJMguvEFFDK5xJ7fnkPJ9qu1t+qRXXuvZxMAIEQ==
X-Received: by 2002:a17:906:aac7:b0:a65:ab25:24da with SMTP id a640c23a62f3a-a6cd6f0076bmr46409866b.22.1717709043816;
        Thu, 06 Jun 2024 14:24:03 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:03 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 10/19] iio: chemical: bme680: Remove duplicate register read
Date: Thu,  6 Jun 2024 23:23:02 +0200
Message-Id: <20240606212313.207550-11-vassilisamir@gmail.com>
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

The LSB of the gas register was read first to check if the following
check was correct and then the MSB+LSB were read together. Simplify
this by reading together the MSB+LSB immediately.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  2 +-
 drivers/iio/chemical/bme680_core.c | 21 ++++++++-------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index c51bf2bdf504..b5f16ca81e70 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -46,7 +46,7 @@
 #define   BME680_RSERROR_MASK			GENMASK(7, 4)
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
-#define BME680_ADC_GAS_RES_SHIFT		6
+#define BME680_ADC_GAS_RES			GENMASK(15, 6)
 #define BME680_AMB_TEMP				25
 
 #define BME680_REG_CTRL_GAS_1			0x71
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 2466398aad05..c1e191ed4955 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -767,7 +767,7 @@ static int bme680_read_gas(struct bme680_data *data,
 	int ret;
 	__be16 tmp = 0;
 	unsigned int check;
-	u16 adc_gas_res;
+	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
 	/* Set heater settings */
@@ -792,11 +792,14 @@ static int bme680_read_gas(struct bme680_data *data,
 		return -EBUSY;
 	}
 
-	ret = regmap_read(data->regmap, BME680_REG_GAS_R_LSB, &check);
+	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
+			       &tmp, sizeof(tmp));
 	if (ret < 0) {
-		dev_err(dev, "failed to read gas_r_lsb register\n");
+		dev_err(dev, "failed to read gas resistance\n");
 		return ret;
 	}
+	gas_regs_val = be16_to_cpu(tmp);
+	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
 
 	/*
 	 * occurs if either the gas heating duration was insuffient
@@ -804,20 +807,12 @@ static int bme680_read_gas(struct bme680_data *data,
 	 * heater temperature was too high for the heater sink to
 	 * reach.
 	 */
-	if ((check & BME680_GAS_STAB_BIT) == 0) {
+	if ((gas_regs_val & BME680_GAS_STAB_BIT) == 0) {
 		dev_err(dev, "heater failed to reach the target temperature\n");
 		return -EINVAL;
 	}
 
-	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
-			       &tmp, sizeof(tmp));
-	if (ret < 0) {
-		dev_err(dev, "failed to read gas resistance\n");
-		return ret;
-	}
-
-	gas_range = check & BME680_GAS_RANGE_MASK;
-	adc_gas_res = be16_to_cpu(tmp) >> BME680_ADC_GAS_RES_SHIFT;
+	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
 
 	*val = bme680_compensate_gas(data, adc_gas_res, gas_range);
 	return IIO_VAL_INT;
-- 
2.25.1


