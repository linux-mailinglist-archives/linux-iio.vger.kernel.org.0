Return-Path: <linux-iio+bounces-5373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C038D09FF
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B701C28283E
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375415FA76;
	Mon, 27 May 2024 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOmz+gDL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA31667F6;
	Mon, 27 May 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835106; cv=none; b=BYvZRB+d3PLee79qzK93HR5dapNOaxrZ3KDYffhr8oNeriHLhQ/KNLkxNFMGWkimVs9amUluK/IWNfklVjwYAV0DAcWFRTIxP7KdKWjy8H4n+vmeowLrdC17IAg8UKbqzJsq/W0XaSj6WarD/EgzIxpbjqo/AZhGlq+PHfIAcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835106; c=relaxed/simple;
	bh=3K1S5hRSYK31me4jnx1h8KifUo9Gn9XsOKn09ofMSXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgZYZn3/PVdT7wxzqNV1tD3Y1olI9UsURXNn0c0TZ/jjBxFhOe09H+OhN5tEbqRDuHexs/6V6BVizezh6oiBF4E1HB1gGhpQoGc5mzlmxTUGZzwpcgyXjvZ3mxs4trYA0Fc9hx+DhwOpwunD7uSQnMSSBdMBqe7iI/jpyUUlR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOmz+gDL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso30865a12.0;
        Mon, 27 May 2024 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835102; x=1717439902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlSEHjIcvqW+lxV4cQ1l5QsI7RM0a/cM01/bSjIyPEA=;
        b=IOmz+gDLpKw6dLS8NE+jubNeJtm/MyeAOKO/BmQP5lSsZEsHiG8FZAzqYHl/vm5Ot4
         fpESI9HuV77plGmUYRZPy51IPm7iwTc83756L+Tn6BFqKozhFfK6/jA7ZStmfMRsio4t
         bMRW9GHDXJry7v2XXeQBVcfFR3QcWKGDLbRhTaIxnzwBrzT8nj0u8AZkBRNiKBIMhVoI
         Hka19zpcA5yDOrDJdKx/cfWQ5SVlo0T9eADz2EEan2Q48h7V4YvDl9Saw8jmQ1WjGM8p
         /7zH10pzY4HD0y78NnGyt6XVQDO5DZDl+EBhELGcp/XJOcxBVX/1+Whj382XkvLAQ91R
         +2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835102; x=1717439902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlSEHjIcvqW+lxV4cQ1l5QsI7RM0a/cM01/bSjIyPEA=;
        b=QWu0jL7ycjtIISrzznb/dPxLX4Kbwb2J7Ul7+CjBMC6aG8rkLwMV1FXd2vVdY60d6/
         RNhxMRSSw4YGhNahGoiLVmDhz2/1yLf/PdKWRFEfJhXOh49170UFn3oD2vqjv6CmLds4
         Ix4EHeENk4OJXxWrx156tZHbysjAYDIevOLZhYmin46mSrMxV5IXTy7ekRxli+NtbaRa
         yQPEsoiuOX+9/xDSTGSmBDLu02iRqYJxA1f1iNhKC7aYCC+8rb1+uvutzSJQbGpheP2l
         Tm8H146il2t6VRgcDRwWvDETktr1mp0itmdiyOLT4Wa3oVhdULcbqE/SjGvKdcT4g/Bg
         il5A==
X-Forwarded-Encrypted: i=1; AJvYcCW/ow8S7OaJFJ+1HWf8UdEAPVAFYU+0I4l2gnHXQpKk7ygMMPdaWYixg8jkfTxaFJtocjAse3Po3kAMtHlxCrWmMTLwNn3W5TyUzd/9rF9Z1/+37AuL23/JO1so4/mMCWi1wG/AM16x
X-Gm-Message-State: AOJu0YwkCdhiysb98aKifGztlxGin3aTRUYdL6XAY7oZwXIxojbcRfIL
	7+fhqCxiesZ3DCRzDYlIAdQMU3r75SxIZKhdB8DPeCCN2d+ublMK
X-Google-Smtp-Source: AGHT+IF/xMluxJ1pyGrj+l9MU9edHXAF0+v+a/2f6XJAP+5QyF46qLuzn0J7bdX0BE2IpHGKi7A9aA==
X-Received: by 2002:a17:906:e84:b0:a59:c9ad:bd28 with SMTP id a640c23a62f3a-a62641a5722mr612527866b.13.1716835102352;
        Mon, 27 May 2024 11:38:22 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:21 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 10/17] iio: chemical: bme680: Remove duplicate register read
Date: Mon, 27 May 2024 20:37:58 +0200
Message-Id: <20240527183805.311501-11-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
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
 drivers/iio/chemical/bme680_core.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 96423861c79a..681f271f9b06 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -748,7 +748,7 @@ static int bme680_read_gas(struct bme680_data *data,
 	int ret;
 	__be16 tmp = 0;
 	unsigned int check;
-	u16 adc_gas_res;
+	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
 	/* Set heater settings */
@@ -771,11 +771,14 @@ static int bme680_read_gas(struct bme680_data *data,
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
+	adc_gas_res = gas_regs_val >> BME680_ADC_GAS_RES_SHIFT;
 
 	/*
 	 * occurs if either the gas heating duration was insuffient
@@ -783,20 +786,12 @@ static int bme680_read_gas(struct bme680_data *data,
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
+	gas_range = gas_regs_val & BME680_GAS_RANGE_MASK;
 
 	*val = bme680_compensate_gas(data, adc_gas_res, gas_range);
 	return IIO_VAL_INT;
-- 
2.25.1


