Return-Path: <linux-iio+bounces-8848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDD29632F6
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 22:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5D82862FE
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D49F1AD9E5;
	Wed, 28 Aug 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWy5tlc+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9B1AC420;
	Wed, 28 Aug 2024 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878300; cv=none; b=c9sznk9oWHBznqFAwUWydZcOp3lKhfRNJJKOdD9NnMC91OLIrk+nIw6OQPpIQlCcNIay7BGGhGOsHFifTmd8DLtRWl57o/6OWZIfV3J97SE+TY7FB1NxxXshVUu5eECQ5ABXSR8jfYJ8hHCeOq2ONFqe/bs1z7wNeJsM1SnBQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878300; c=relaxed/simple;
	bh=cdY/TENqpqXqAOnyRhO2/xpzQRllFMlVUbT6+Wo1keM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLX865FTv+yaIuvxBGqKqFLMuhOMXBNGgPon4aDSu4jcJ4CplbrMZF7NXInp+m9KP2181VtmmglxWibXr2aAGe+dxx/8Okdu4GnSPvGgC5lXdWVB+0QF7hHKRGkJ3VUZhJJzlFyVh9nfCm1RFHXgjYjfEGlIEdEY2OwkB2J9gUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWy5tlc+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso1918539a12.1;
        Wed, 28 Aug 2024 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878297; x=1725483097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhxstM4mID0lLB91lA10snaXJWiXlyBjKw1XE58PBaI=;
        b=GWy5tlc+rkbf3L87wDW+FuoWUXeqpG7ATeSgPwIetwTuu3SjAWrVQaM5Re6l2vZzte
         iwGaoGmuD1Yvo53/qfWJVLGlJ8ApLGCIVdHjimRyVGvUkxdOugwA5co72bEYCtAMQU4Z
         k1+AxZnAXbgX4223ZdnbsBLf8UnWGBdqe3osFcRBUmMW527bUcUXGJxrrX5jrFNtfo/A
         nMMOFBga8S/qyPfizFnNsqEukKVpLJ5WFW3CsJM2BD0DfGFly1DZhsN8oo+PSst69cdQ
         uQyj1BtDmVYTuKUqe0WB6NUn+UpyFXBY5u91QQ3FXz/ogH7l0yRlgsBCk1Rl1MelxBrF
         3nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878297; x=1725483097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhxstM4mID0lLB91lA10snaXJWiXlyBjKw1XE58PBaI=;
        b=Gm3yerQIynr1S5dVmQV1qDAgXILHyFmh4mRtjMYfxpFhbFDqPPCbwbkFPRsbvAVnNv
         6ESXdLviWxV194YtpA/9APBnlTYqa9V4U0ybBppDHL/rHE74tuzEJZlV8fmab/pIbVJ/
         WF3GE19RiE7D+b+32eR2Zj9Jj+cf9Fc/AAnhsjhj0qZ+tvA1xVdL/aveHYRdCVWYf8Rv
         RJH3RuO/u8MAH1crKR6F6eOJH9SZthYGeGFQWjLdl0LluYKSir7GPRLd0qe0gOECISPD
         vYuTvGy2Lb6jOCKT9fuCpZB2+a3jkBW5c5NKAZwYW3eSs8kjTpnEwPjKY0CeI6vfogvq
         8TRA==
X-Forwarded-Encrypted: i=1; AJvYcCU61pkFIAh1Qm8TrMaIa/ZcGZ+6PkkKDLryPO7GgZXy/Dd9x8VGPA818C9XZnhHQu8alNSvNQ44F11c@vger.kernel.org, AJvYcCUrN2QHyPbEapKGKZH/ZRg50Uk/277htLPoG9h5Bf0ZcN3Ch2ws2tm/iGdTIB39mvP0WZ3C6d5zV1+6@vger.kernel.org, AJvYcCWESRvYGAewlTVN6/jGPgwYSMlEFw1JAuRr+/u/4Z3sVAgcz/G2Xw4mO18zs/wZ/YaSyclOz83QXatzmlQI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9mJmYWkaBr3KjRPCTScVDofUY4BjQoSjwcNtnG2qDqQTpYD4
	H5YSxwtcd/Ys99goUEzj+sDgLbDHJRETMuktZeFkNTPie2ZyPDyC
X-Google-Smtp-Source: AGHT+IEj+40dFJIDo1+J116D5d3sOqiA9FK7FU4HJWxta4M0H2u6XIh6WLb5TbdqMvxHQuPQxDZPEA==
X-Received: by 2002:a05:6402:1ec7:b0:5bf:256a:a19e with SMTP id 4fb4d7f45d1cf-5c2200ddc2amr443158a12.4.1724878296021;
        Wed, 28 Aug 2024 13:51:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c2f53sm2646566a12.19.2024.08.28.13.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:51:35 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v4 1/7] iio: pressure: bmp280: Use bulk read for humidity calibration data
Date: Wed, 28 Aug 2024 22:51:21 +0200
Message-Id: <20240828205128.92145-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828205128.92145-1-vassilisamir@gmail.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert individual reads to a bulk read for the humidity calibration data.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 64 +++++++++++-------------------
 drivers/iio/pressure/bmp280.h      |  6 +++
 2 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 8383d1a73cf9..9c705f2c4a7b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -340,10 +340,19 @@ static int bmp280_read_calib(struct bmp280_data *data)
 	return 0;
 }
 
+/*
+ * These enums are used for indexing into the array of humidity parameters
+ * for BME280. Due to some weird indexing, unaligned BE/LE accesses co-exist in
+ * order to prepare the FIELD_{GET/PREP}() fields. Table 16 in Section 4.2.2 of
+ * the datasheet.
+ */
+enum { H2 = 0, H3 = 2, H4 = 3, H5 = 4, H6 = 6 };
+
 static int bme280_read_calib(struct bmp280_data *data)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	struct device *dev = data->dev;
+	s16 h4_upper, h4_lower, tmp_1, tmp_2;
 	unsigned int tmp;
 	int ret;
 
@@ -352,14 +361,6 @@ static int bme280_read_calib(struct bmp280_data *data)
 	if (ret)
 		return ret;
 
-	/*
-	 * Read humidity calibration values.
-	 * Due to some odd register addressing we cannot just
-	 * do a big bulk read. Instead, we have to read each Hx
-	 * value separately and sometimes do some bit shifting...
-	 * Humidity data is only available on BME280.
-	 */
-
 	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
 	if (ret) {
 		dev_err(dev, "failed to read H1 comp value\n");
@@ -368,43 +369,24 @@ static int bme280_read_calib(struct bmp280_data *data)
 	calib->H1 = tmp;
 
 	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
-			       &data->le16, sizeof(data->le16));
-	if (ret) {
-		dev_err(dev, "failed to read H2 comp value\n");
-		return ret;
-	}
-	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
-
-	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
-	if (ret) {
-		dev_err(dev, "failed to read H3 comp value\n");
-		return ret;
-	}
-	calib->H3 = tmp;
-
-	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
-			       &data->be16, sizeof(data->be16));
+			       data->bme280_humid_cal_buf,
+			       sizeof(data->bme280_humid_cal_buf));
 	if (ret) {
-		dev_err(dev, "failed to read H4 comp value\n");
+		dev_err(dev, "failed to read humidity calibration values\n");
 		return ret;
 	}
-	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
-				  (be16_to_cpu(data->be16) & 0xf), 11);
 
-	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
-			       &data->le16, sizeof(data->le16));
-	if (ret) {
-		dev_err(dev, "failed to read H5 comp value\n");
-		return ret;
-	}
-	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
-
-	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
-	if (ret) {
-		dev_err(dev, "failed to read H6 comp value\n");
-		return ret;
-	}
-	calib->H6 = sign_extend32(tmp, 7);
+	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
+	calib->H3 = data->bme280_humid_cal_buf[H3];
+	tmp_1 = get_unaligned_be16(&data->bme280_humid_cal_buf[H4]);
+	tmp_2 = FIELD_GET(BME280_COMP_H4_GET_MASK_UP, tmp_1);
+	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, tmp_2);
+	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,
+			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
+	calib->H4 = sign_extend32(h4_upper | h4_lower, 11);
+	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
+			get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
+	calib->H6 = data->bme280_humid_cal_buf[H6];
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index a853b6d5bdfa..4e675401d61b 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -257,8 +257,13 @@
 #define BME280_REG_COMP_H5		0xE5
 #define BME280_REG_COMP_H6		0xE7
 
+#define BME280_COMP_H4_GET_MASK_UP	GENMASK(15, 8)
+#define BME280_COMP_H4_PREP_MASK_UP	GENMASK(11, 4)
+#define BME280_COMP_H4_MASK_LOW		GENMASK(3, 0)
 #define BME280_COMP_H5_MASK		GENMASK(15, 4)
 
+#define BME280_CONTIGUOUS_CALIB_REGS	7
+
 #define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
 #define BME280_OSRS_HUMIDITY_SKIP	0
 #define BME280_OSRS_HUMIDITY_1X		1
@@ -426,6 +431,7 @@ struct bmp280_data {
 		/* Calibration data buffers */
 		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
+		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
 		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
 		/* Miscellaneous, endianness-aware data buffers */
 		__le16 le16;
-- 
2.25.1


