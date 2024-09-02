Return-Path: <linux-iio+bounces-9021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119D8968DB6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3743D1C22198
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E814A1C62C5;
	Mon,  2 Sep 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDR6r2S5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314719CC11;
	Mon,  2 Sep 2024 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302550; cv=none; b=mqR6tugpN1M+iOGpQOULzfoLq2M2/QotXXBLB8Yu2x4OQg0mG/X5cJxGogOLZA8G8P6GSwSPLJsCTpUCcTBh77uUEIlt/cHgCANDaxFju/ZqVFDgOqRma6KVD7RYgJSOO/xQYoLVEJ8QAc4ZdkfSHo6e5j+Z5YIBxNSaz0cxKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302550; c=relaxed/simple;
	bh=HOK0g8c+oxKQNNbxQsPOZaeb4IYAdSGXTp+hdXNkatc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lu8A8scmxjdTwFHkzRh8nbi5rriakI0qCqFtq/+pWyO4xyeftHcT2sGYXJqoM4lPVURI0tMYup4T+HeAPBxPhAuuQCZUSuTsTrFTZeuuUAIQ+5Ur7cXSr4WVN1pC9n6LuTJyGEN9ikHoep+zcOJHvjsQBxDMCGlXhdJRw//RGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDR6r2S5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso4462145a12.0;
        Mon, 02 Sep 2024 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302547; x=1725907347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qOPxrqYeKueDE+9V5z0BX1gKk66+Q3HbGFskdXy1+o=;
        b=lDR6r2S5nacACxtmE+4bOjqOqI33lTwOIlcy7z5ZvlULVwUrhv4gy8cz31zVFAwt4A
         Ralg7S/P95bJv15D0SNXumqVp9rIO196jdLtCByk80SdH+317t7SvppD1RW8RaZVRy6I
         9bevWEou9cD8rxni8d/r+IP52kBrgEh7xvYdZpSFWq37vrMI+49OCQzIzJYRIwuFyNUJ
         oLUb0/Ao6bLf/ntKXoi7L3IJcNRFCbYIO33YYYgQsACO4YP6zh1kOkv946P2c3q21zmZ
         FbHpmerPjeQ6n3iwaPgLUmFSC0jj1bfotTTz8Z2RTLiO5fDTiu3QzYmC7khGjmQqCWYx
         doiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302547; x=1725907347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qOPxrqYeKueDE+9V5z0BX1gKk66+Q3HbGFskdXy1+o=;
        b=ar8yoDFO7RXfR6KNi7IqBVYstjr6+jb++1zM/yGSqgaeuSljx0cANFAF3RzsJ/gLs/
         8oEriquA+E05THMQQVfQwdD2wMhqJyZuCIwfH/5hJ3cfHGSQhNL8T6rZsE7KnTqo634h
         s5QOFA/9AMCNfxLFdRIsKL8tLhW9dNRBJj+5wYwO7MYvCpRcCZA9J1RSeyGLAKgEWDEP
         u1xr/9+qhB5fQjytKQFaXaxWWI2sh1bdz+Y8RA3QmBkn2+5lwonjjEv4BCmZZORKQhtC
         ktqxV1SjIWjLh0Q6O27HHo6FERmAYuNUvkwg3bPNxQ7XUR/K7Fh2opypP2QWE9yR1wvF
         Y9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0cCkuVeZJCworGeqSdODJ1ponT5qWHvpRSzBe7U4q61DOHQaDqV0XUnNQP+ITrP2XmooVIMlYXXoCnb33@vger.kernel.org, AJvYcCUPzrfzr4tJdwhbUhhjmN6QCG7kVB2JkGB89wcRe5B7l2l4jvNNybIHBP10AV+gPYZR1koPQlNv8fKG@vger.kernel.org, AJvYcCXXhMwW+2Kph2DnpeqwgMbHzATJNtOs9XG4xMfvr1QA20tH9NtwRyrkZl0UCr25UcXbqBz+2cg66s0r@vger.kernel.org
X-Gm-Message-State: AOJu0YyNr/l7KhFsgIZ1w8KB3ceBVrpOmN9r0Zt+qOF9FeDhYhZQjQdY
	JZafxuCYTJOlUSxpU8gjRgMkczAfZYiqRsbVbgcglz6QuhCxT5IY
X-Google-Smtp-Source: AGHT+IE95YWHgElKEcuGFQyi9I2WZjUWGW4BqeJGxmsJ4wWGcUjXyJVAuQnYgNGlh7KFmTqhOPamJQ==
X-Received: by 2002:a17:907:3e84:b0:a86:b448:cbe with SMTP id a640c23a62f3a-a89823c984amr1421166566b.10.1725302546680;
        Mon, 02 Sep 2024 11:42:26 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ec0asm590537966b.53.2024.09.02.11.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:42:26 -0700 (PDT)
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
Subject: [PATCH v5 1/7] iio: pressure: bmp280: Use bulk read for humidity calibration data
Date: Mon,  2 Sep 2024 20:42:16 +0200
Message-Id: <20240902184222.24874-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902184222.24874-1-vassilisamir@gmail.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 63 +++++++++++-------------------
 drivers/iio/pressure/bmp280.h      |  6 +++
 2 files changed, 28 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 8383d1a73cf9..3b221e16aa42 100644
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
+	s16 h4_upper, h4_lower, tmp_1, tmp_2, tmp_3;
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
@@ -368,43 +369,23 @@ static int bme280_read_calib(struct bmp280_data *data)
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
+	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW, tmp_1);
+	calib->H4 = sign_extend32(h4_upper | h4_lower, 11);
+	tmp_3 = get_unaligned_le16(&data->bme280_humid_cal_buf[H5]);
+	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, tmp_3), 11);
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

base-commit: 0f718e10da81446df0909c9939dff2b77e3b4e95
prerequisite-patch-id: e4f81f31f4fbb2aa872c0c74ed4511893eee0c9a
-- 
2.25.1


