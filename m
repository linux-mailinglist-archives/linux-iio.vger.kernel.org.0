Return-Path: <linux-iio+bounces-6124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7800F9018AE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDED1F20ED2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442ED74041;
	Sun,  9 Jun 2024 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5WflYKU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1566F304;
	Sun,  9 Jun 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976321; cv=none; b=YgYRXpwlCWaECCmW6IYnrhYEPS/s8E7CmUjeBrBtBQDH5q89amP8CQ6RcjFAVIdqm1sVfHQQKKxw4D7E5K4sbLqmYCQ6EmOeMW4WE53q+dddQYWkxLfyHTQKrDqax7DQqTQBsDVJrplHuXUVTo88qah8NvsSQUoLGuOnyhNQRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976321; c=relaxed/simple;
	bh=kT+N+A6B1z60I6KgFrmJu/OyAxrx0C8tvVp8Z/JEa84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uw9HjnAgMKVzX05m7F24IJR5vQ3zwWs1mtRHSbio+wFx0ht5MFb5S/r0PAKa+kvZCB30dGrAJ7WrQ7Ez43s+e0stJIe9FmKodn/arhWB9uX6M5kTabqdYxHlvNdXv9Bq4x0IA8xJPLjSTrCNZ1PCwl94g45NAyw3/e5o+Ml9lSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5WflYKU; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eabd22d441so61733621fa.2;
        Sun, 09 Jun 2024 16:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976317; x=1718581117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LfV168pmmLldnkKP0bzQoHl57vTq1AfdoTWFyVDYg4=;
        b=f5WflYKUpgPFTiEorjnk3MwvxCwiU+GvdPgAo8iqAPZubVPpxskfYiCjfJQj+ACGY3
         wZJWiLXh2zkcQ7sp6Tg7j+iCcFpsDtXZl6gYrehOX2TGAF2YTcJXHUUscYpv9baTAOO8
         sPhXHUiDPoaMl/vd1l9w+zNczCLIUr2XyKGQv3lJdtSFTEXNC2uDJRZq/k+XOVmB/FwT
         mRUfTtYPYbXYKKzRN0UTuOj+9HOCGB9NYaN+UjTuVY9fjtdQXhydeLg6PPP+I16tbzPq
         XEAzhip8vl2ZGW+kJOBu7fEJPybCtzMgD4jEybGLoAxsn+65GBv7drx6Gjn9GTcPjNKN
         AhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976317; x=1718581117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LfV168pmmLldnkKP0bzQoHl57vTq1AfdoTWFyVDYg4=;
        b=Mh1nTgc4+4eB747sy7AhdC7cbpkQEuFqZnlTi9FpDUUJu74kuGHcEkw1VSp5LKhMJt
         3H5Cg2lSHcpmGvsHQDxyhrpH4l+HoAc4Gc+xfUl7Vj8njXcd6+YmtX3ZMyQCcRyQvW5j
         x3b9+3xiCkvdT6W8+9uGlZpwOjvl//G40/VxJHqJB8Ar+QzUdww/XMS6ih0/Z7AJSl4Q
         VrxTOamq1PKEolLivU+RCqZvd7TSw8655YjXggR1ViGwwoK+eezBDkpPx038VY+X5zyh
         tdG4qg1NCKxCAQFeXKEWB40fk57XhLZiKKYqmavhh7n+evCEkrBkEOvFtP18Cf6RgdMK
         JsfA==
X-Forwarded-Encrypted: i=1; AJvYcCUmpdMgNMR/lYQ4lldj92oaPBJIHZh1usCgv2cN1ofBtBP2T6GwOlv9QTQek24fsxeaLX1zJMOfN778iPt4AxiPcHVX/BlA+lcVFuzjneTprI+umH3Afc/WCQ+ZbXw41CiqtcgBOqAh
X-Gm-Message-State: AOJu0YxJeZALHnt6tbokh5Hg6ooSa90dXgk4T9tQB10WG9OelThSOG0Q
	E4jBELqZ2dgY40nh+NsPN1ZV/1h4YaNejPz8FHI/2zdfzYZNhruEYj9MGQ==
X-Google-Smtp-Source: AGHT+IHN5IV6XhKrwE8W6PFjmTX8OUYpO3itZ9BaCpE60+X7cGuaA7G5fdWbmS+iYq0WjTw0OkMf5w==
X-Received: by 2002:ac2:54a9:0:b0:52c:816c:28cd with SMTP id 2adb3069b0e04-52c816c2966mr2837351e87.37.1717976317239;
        Sun, 09 Jun 2024 16:38:37 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:36 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 06/15] iio: chemical: bme680: Remove duplicate register read
Date: Mon, 10 Jun 2024 01:38:17 +0200
Message-Id: <20240609233826.330516-7-vassilisamir@gmail.com>
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

The LSB of the gas register was read first to check if the following
check was correct and then the MSB+LSB were read together. Simplify this
by reading together the MSB+LSB immediately.

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
index 72bd5445b6c0..9660ec3854a1 100644
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


