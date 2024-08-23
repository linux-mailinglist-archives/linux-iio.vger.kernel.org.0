Return-Path: <linux-iio+bounces-8720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB6595D522
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1843B20CD2
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BA61922FD;
	Fri, 23 Aug 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCLurHyO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A44191F64;
	Fri, 23 Aug 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437043; cv=none; b=fRqL0j8nnq26qdhloW1ZIxJmTDPp66KGMn99uXjqd2NKfpOqEBBEgA8WhF3ZKqAH18GEZa01b14Pvg3EqWnUuMN6pLzd6DsZJbEn6O8iQ0BF1wBaCj6CEg+QpuBvSDt9dfFgxupt8ZHIFlDxPNK1BbiWaN0F/Ce9AG+q/pZuXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437043; c=relaxed/simple;
	bh=Dm3pIlii8u9e0jZ0Y6BnPz8p5SELz+k6jzyoRF0YADw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R87w5Ks+jyHnXdw06i3mc/Y3RmO/9fpmUT+bZOkDWgWc68d0ff8E5I+pk8wi2QI5z8yVZ/Rebwgdz9o6wEdSZGk1CodNZNzBh+yv8PEj5o/hxrG1xRX80+H5Hi4pMehRZ0jJKnUzsSDU5siajeYLR10cKlDerOj2dhvZ/GaFvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCLurHyO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428e1915e18so17268215e9.1;
        Fri, 23 Aug 2024 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724437040; x=1725041840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrwIpvLrRFP7oKPLvCMon+/Vo0FO1x4rOnetJCQOaDQ=;
        b=aCLurHyOP5xe0/zvjStPINBKd83xT3fqVDFH7VdXFqcBMYOplHHPHtY80ry8NgUzDw
         6tEXp9eMq6MqbpZg/YNdyJHUoV2mkJSn2ND0lJ84VG8BNxXwmPAyocyjZ1teRYg2YKYB
         upVjJEAgPbI6wfqQoLk+jBKAs52/qEcr0LcYEu6vvuqitRb7187F3d0Kixa3RxHceUM5
         cr2DWLDK7YP9XFg2yPUtMlY1PH2W3hzXGBdM5s9++gJ6ux3CvyFNiN97IxMCEI9v/gF7
         QjzUbjNKrH0cZ5vrIVzgCQRENgEWbgE9PeJ6/Rf+oOTrMDgEQqLWRbZAeWCMHE99lErg
         NN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437040; x=1725041840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrwIpvLrRFP7oKPLvCMon+/Vo0FO1x4rOnetJCQOaDQ=;
        b=JUUBSHOEcaPNVaAlQIL1mH01czZLlfRqJg4nIUpU0tRaSRCGK6jLCkUi2bL2LaeStG
         uEZoyTF05SBopVkj/ueLtdpy5L5kG8mq2EHxmdH8LOe5xNg6QTEw0de03S2Iasy+qwvz
         nTCWrMNDCG3Ozy+y4N9GkcN/pgM+Rl8eNQdDAeeunGESQWuGXZoBwxznHh0lf9zpEqiS
         mhzmfEuAm/aQwkzy+e+T9XkokBK8bJ7yoJf+4bs0voS4DXFEFj7VLBYM2RlHcaPXTkgn
         Su9TtW3VFy59HW243NdqVpiytZUdWisGQPEPEWcTYuNFpMY6THnMQahBXiW3hBTKH88S
         2eSw==
X-Forwarded-Encrypted: i=1; AJvYcCUUzY1FlUOeeiulyShgo/bZd8saHNoBOV/5xAW2VxPZip9nQNTiP5O9P2CqbevJ4xIyHb/4AdrjwkJn@vger.kernel.org, AJvYcCVCMiuqzE6OOHgvNmojTFLzEuYNAm4rSEG+UBcmvp5bd3Iwi2+oaEEllQaZ0g3GIzaqlxNi0kzmCUJ1@vger.kernel.org, AJvYcCXh2tOasCQ5d1uc+tnXO57d04HUFvo7Uhb+pV5T6Ci+47Gy4o6kiiIJgTQicGUfooTB6gydhMzPt20cL/27@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoq+NXgLns4vTwtXUG/cm1tVJBHL4fusssAFynsc0LnN4qknOj
	y23wGG0WesVPZUujQDQBdzLmnuIPZxLVZw4VaBfUya9BIaLean1+
X-Google-Smtp-Source: AGHT+IGf9aiwjdXfuWRZQ4W3pm5m9vOVmjrMWCxz6sdZm3VeG34KgzLdAKIdrsetsaqAw1pq3sCpZw==
X-Received: by 2002:a05:6000:8:b0:371:7d84:9bef with SMTP id ffacd0b85a97d-3731187d118mr2122192f8f.28.1724437039709;
        Fri, 23 Aug 2024 11:17:19 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:f90d:5a72:8d56:a041])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm4677939f8f.44.2024.08.23.11.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:17:19 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] iio: pressure: bmp280: Use bulk read for humidity calibration data
Date: Fri, 23 Aug 2024 20:17:08 +0200
Message-Id: <20240823181714.64545-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823181714.64545-1-vassilisamir@gmail.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
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
index 8383d1a73cf9..c23515048081 100644
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
+	s16 h4_upper, h4_lower;
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
+	h4_upper = FIELD_GET(BME280_COMP_H4_GET_MASK_UP,
+			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
+	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, h4_upper);
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


