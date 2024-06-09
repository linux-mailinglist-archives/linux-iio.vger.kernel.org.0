Return-Path: <linux-iio+bounces-6125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F371C9018B0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6013BB20C44
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50EC74068;
	Sun,  9 Jun 2024 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMZMpFl4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855ED55897;
	Sun,  9 Jun 2024 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976322; cv=none; b=LNrz7IILvDiFmaZL92EpVtIz6ep1EzihJ1K681OiIoHD1q/Vj1eJxnk/gzlZaaW/IZw8WfPjK9E4b/S47DC7QO0FkScz8IwrdOpA1SdkdAUS1jQSdUdMXyGSCWKJj0+dA+yY/JCLtPxPprxZsL5y+fzS3Yer930mU0mBR3r4u+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976322; c=relaxed/simple;
	bh=MEpRwkTcXF8fGMudUp/0Z+NjZveVb9d8lnKtIxjL/yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ehEn9mQyHWJkQ0kIighYr3X51zk8kMrtLwWAG/cf5ZFYF+fVKQ1AfwG5wEzd6jRleQNl5BhTa0oP9To3TAaETtNGX99RzJIjS8P/Yd97LU7JYItet2dT1Vfg7Sn0FrmBF2dEmWTmHJrLAjfIfGUc1//cHE9bcKnkFaQu845RMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMZMpFl4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso92996466b.0;
        Sun, 09 Jun 2024 16:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976319; x=1718581119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Akx/LH5j97MyicpoI+1LYxFCgcz5jTd5QgQsZULyeEw=;
        b=nMZMpFl45IH3P9W4/bxN58gq3/zUwW6dpxjgNvSzLc8cjGWrSvdhYRWRRkjRU/NCeq
         axWXJ7Nnd0JunpBhiHndtMfsmQLQuTElX6KPhTnPSP6r7B78/eOYfKI6Y5o6QYN5CxQD
         pMAZ89E7K4HnErIZo00E8f/Vou++8N8fFJ/ZcyKKyOEYYK747jMbf3T6F72q6Hs9ngTn
         nEolGl6LIjlCIRbKZUFYigcHe6ZIEEVX9w5CGcEW3iCZWJ/ecMQ2Tn2WiwFyx7s3giYM
         P+TstP2vtGUR++n+HvYZjXOHb5yOuNi3MDp2xuXfh3Yn26HRaDKd9xd/gEmQTWfecqCJ
         UOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976319; x=1718581119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Akx/LH5j97MyicpoI+1LYxFCgcz5jTd5QgQsZULyeEw=;
        b=XYFDeYnGLaEzpU5hPe3FuWtv32LpFEj2EPS+HVHv2LmqfNuhs4OotKfk6Vj5+aYkbA
         kRKYceyESUsBmwRXrt3C88UfEYLT9eiIM7fdsLsniZ4ODYgwWuBYr1rFDJ9O6bcR5mfK
         ClQztI+5iYwq6xWThBq6JNlzI/uxsInWAUqMnAxY6az/JYQ2mLMjUgqPjhmknLTFnn2N
         kF/hZf1VOhouEU/N5KrcOXO2KlUS9SrIfROG4YxHDL7TGsnKEZGl/xF47JP1wCRE8vCc
         9BPEPxNVld2+1CWWgUt6WxcJAqC/MmxFOAPnU7BD5qgZED97263XYt5N2bi8oVF8sdb0
         cJFw==
X-Forwarded-Encrypted: i=1; AJvYcCW9snoX5OBPl0YojZ/iYIH46bkW1iDk7AIphRzm2SJtI6qrVkmctgwQsmZ8nglH3qB6ZSZfGllVL6j518QuC3on+bmnKlmUTKf8xv8XhQJgzcgbzazGrhl5QYTL0TbVhO0rBMvV3nqf
X-Gm-Message-State: AOJu0YzPtSA0jVXzWPiEnJQ/+vcWJN6FfA90ZLUSw9I5FW2j/35+TSOn
	e/ml1EnRFoYP53ut22t1t87zBXpknInLfqthXZitBncOnkUkk6bk
X-Google-Smtp-Source: AGHT+IHzSsHI+5gEb12SEy4XvA80z2fcZKOmVFw2SA18AJ0eSSRENcdocc3TsSKaTgPyedxB8F8zsw==
X-Received: by 2002:a17:906:2341:b0:a6f:e55:ba1c with SMTP id a640c23a62f3a-a6f0e55cb79mr250122266b.14.1717976318422;
        Sun, 09 Jun 2024 16:38:38 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:38 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 07/15] iio: chemical: bme680: Use bulk reads for calibration data
Date: Mon, 10 Jun 2024 01:38:18 +0200
Message-Id: <20240609233826.330516-8-vassilisamir@gmail.com>
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

Calibration data are located in contiguous-ish registers inside the chip.
For that reason we can use bulk reads as is done as well in the BME68x
Sensor API [1].

The arrays that are used for reading the data out of the sensor
are located inside DMA safe buffer.

Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1769 # [1]
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  28 +--
 drivers/iio/chemical/bme680_core.c | 279 ++++++++++-------------------
 2 files changed, 97 insertions(+), 210 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index b5f16ca81e70..8d0f53c05d7d 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -39,10 +39,8 @@
 #define BME680_HUM_REG_SHIFT_VAL		4
 #define BME680_BIT_H1_DATA_MASK			GENMASK(3, 0)
 
-#define BME680_REG_RES_HEAT_RANGE		0x02
 #define   BME680_RHRANGE_MASK			GENMASK(5, 4)
 #define BME680_REG_RES_HEAT_VAL			0x00
-#define BME680_REG_RANGE_SW_ERR			0x04
 #define   BME680_RSERROR_MASK			GENMASK(7, 4)
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
@@ -60,31 +58,13 @@
 
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
-#define BME680_T3_REG		0x8C
-#define BME680_P1_LSB_REG	0x8E
-#define BME680_P2_LSB_REG	0x90
-#define BME680_P3_REG		0x92
-#define BME680_P4_LSB_REG	0x94
-#define BME680_P5_LSB_REG	0x96
-#define BME680_P7_REG		0x98
-#define BME680_P6_REG		0x99
-#define BME680_P8_LSB_REG	0x9C
-#define BME680_P9_LSB_REG	0x9E
-#define BME680_P10_REG		0xA0
-#define BME680_H2_LSB_REG	0xE2
 #define BME680_H2_MSB_REG	0xE1
-#define BME680_H1_MSB_REG	0xE3
-#define BME680_H1_LSB_REG	0xE2
-#define BME680_H3_REG		0xE4
-#define BME680_H4_REG		0xE5
-#define BME680_H5_REG		0xE6
-#define BME680_H6_REG		0xE7
-#define BME680_H7_REG		0xE8
-#define BME680_T1_LSB_REG	0xE9
-#define BME680_GH2_LSB_REG	0xEB
-#define BME680_GH1_REG		0xED
 #define BME680_GH3_REG		0xEE
 
+#define BME680_CALIB_RANGE_1_LEN               23
+#define BME680_CALIB_RANGE_2_LEN               14
+#define BME680_CALIB_RANGE_3_LEN               5
+
 extern const struct regmap_config bme680_regmap_config;
 
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 9660ec3854a1..493d190f4461 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -19,8 +19,53 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+#include <asm/unaligned.h>
+
 #include "bme680.h"
 
+/* 1st set of calibration data */
+enum {
+	/* Temperature calib indexes */
+	T2_LSB = 0,
+	T3 = 2,
+	/* Pressure calib indexes */
+	P1_LSB = 4,
+	P2_LSB = 6,
+	P3 = 8,
+	P4_LSB = 10,
+	P5_LSB = 12,
+	P7 = 14,
+	P6 = 15,
+	P8_LSB = 18,
+	P9_LSB = 20,
+	P10 = 22,
+};
+
+/* 2nd set of calibration data */
+enum {
+	/* Humidity calib indexes */
+	H2_MSB = 0,
+	H1_LSB = 1,
+	H3 = 3,
+	H4 = 4,
+	H5 = 5,
+	H6 = 6,
+	H7 = 7,
+	/* Stray T1 calib index */
+	T1_LSB = 8,
+	/* Gas heater calib indexes */
+	GH2_LSB = 10,
+	GH1 = 12,
+	GH3 = 13,
+};
+
+/* 3rd set of calibration data */
+enum {
+	RES_HEAT_VAL = 0,
+	RES_HEAT_RANGE = 2,
+	RANGE_SW_ERR = 4,
+};
+
 struct bme680_calib {
 	u16 par_t1;
 	s16 par_t2;
@@ -64,6 +109,12 @@ struct bme680_data {
 	 * and humidity compensation calculations.
 	 */
 	s32 t_fine;
+
+	union {
+		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
+		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
+		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
+	};
 };
 
 static const struct regmap_range bme680_volatile_ranges[] = {
@@ -112,217 +163,73 @@ static int bme680_read_calib(struct bme680_data *data,
 			     struct bme680_calib *calib)
 {
 	struct device *dev = regmap_get_device(data->regmap);
-	unsigned int tmp, tmp_msb, tmp_lsb;
+	unsigned int tmp_msb, tmp_lsb;
 	int ret;
-	__le16 buf;
-
-	/* Temperature related coefficients */
-	ret = regmap_bulk_read(data->regmap, BME680_T1_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_T1_LSB_REG\n");
-		return ret;
-	}
-	calib->par_t1 = le16_to_cpu(buf);
 
 	ret = regmap_bulk_read(data->regmap, BME680_T2_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_T2_LSB_REG\n");
-		return ret;
-	}
-	calib->par_t2 = le16_to_cpu(buf);
-
-	ret = regmap_read(data->regmap, BME680_T3_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_T3_REG\n");
-		return ret;
-	}
-	calib->par_t3 = tmp;
-
-	/* Pressure related coefficients */
-	ret = regmap_bulk_read(data->regmap, BME680_P1_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P1_LSB_REG\n");
-		return ret;
-	}
-	calib->par_p1 = le16_to_cpu(buf);
-
-	ret = regmap_bulk_read(data->regmap, BME680_P2_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P2_LSB_REG\n");
-		return ret;
-	}
-	calib->par_p2 = le16_to_cpu(buf);
-
-	ret = regmap_read(data->regmap, BME680_P3_REG, &tmp);
+			       data->bme680_cal_buf_1,
+			       sizeof(data->bme680_cal_buf_1));
 	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P3_REG\n");
+		dev_err(dev, "failed to read 1st set of calib data;\n");
 		return ret;
 	}
-	calib->par_p3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BME680_P4_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P4_LSB_REG\n");
-		return ret;
-	}
-	calib->par_p4 = le16_to_cpu(buf);
+	calib->par_t2 = get_unaligned_le16(&data->bme680_cal_buf_1[T2_LSB]);
+	calib->par_t3 = data->bme680_cal_buf_1[T3];
+	calib->par_p1 = get_unaligned_le16(&data->bme680_cal_buf_1[P1_LSB]);
+	calib->par_p2 = get_unaligned_le16(&data->bme680_cal_buf_1[P2_LSB]);
+	calib->par_p3 = data->bme680_cal_buf_1[P3];
+	calib->par_p4 = get_unaligned_le16(&data->bme680_cal_buf_1[P4_LSB]);
+	calib->par_p5 = get_unaligned_le16(&data->bme680_cal_buf_1[P5_LSB]);
+	calib->par_p7 = data->bme680_cal_buf_1[P7];
+	calib->par_p6 = data->bme680_cal_buf_1[P6];
+	calib->par_p8 = get_unaligned_le16(&data->bme680_cal_buf_1[P8_LSB]);
+	calib->par_p9 = get_unaligned_le16(&data->bme680_cal_buf_1[P9_LSB]);
+	calib->par_p10 = data->bme680_cal_buf_1[P10];
 
-	ret = regmap_bulk_read(data->regmap, BME680_P5_LSB_REG,
-			       &buf, sizeof(buf));
+	ret = regmap_bulk_read(data->regmap, BME680_H2_MSB_REG,
+			       data->bme680_cal_buf_2,
+			       sizeof(data->bme680_cal_buf_2));
 	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P5_LSB_REG\n");
+		dev_err(dev, "failed to read 2nd set of calib data;\n");
 		return ret;
 	}
-	calib->par_p5 = le16_to_cpu(buf);
 
-	ret = regmap_read(data->regmap, BME680_P6_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P6_REG\n");
-		return ret;
-	}
-	calib->par_p6 = tmp;
-
-	ret = regmap_read(data->regmap, BME680_P7_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P7_REG\n");
-		return ret;
-	}
-	calib->par_p7 = tmp;
-
-	ret = regmap_bulk_read(data->regmap, BME680_P8_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P8_LSB_REG\n");
-		return ret;
-	}
-	calib->par_p8 = le16_to_cpu(buf);
-
-	ret = regmap_bulk_read(data->regmap, BME680_P9_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P9_LSB_REG\n");
-		return ret;
-	}
-	calib->par_p9 = le16_to_cpu(buf);
-
-	ret = regmap_read(data->regmap, BME680_P10_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P10_REG\n");
-		return ret;
-	}
-	calib->par_p10 = tmp;
-
-	/* Humidity related coefficients */
-	ret = regmap_read(data->regmap, BME680_H1_MSB_REG, &tmp_msb);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H1_MSB_REG\n");
-		return ret;
-	}
-	ret = regmap_read(data->regmap, BME680_H1_LSB_REG, &tmp_lsb);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H1_LSB_REG\n");
-		return ret;
-	}
+	tmp_lsb = data->bme680_cal_buf_2[H1_LSB];
+	tmp_msb = data->bme680_cal_buf_2[H1_LSB + 1];
 	calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
 			(tmp_lsb & BME680_BIT_H1_DATA_MASK);
 
-	ret = regmap_read(data->regmap, BME680_H2_MSB_REG, &tmp_msb);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H2_MSB_REG\n");
-		return ret;
-	}
-	ret = regmap_read(data->regmap, BME680_H2_LSB_REG, &tmp_lsb);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H2_LSB_REG\n");
-		return ret;
-	}
+	tmp_msb = data->bme680_cal_buf_2[H2_MSB];
+	tmp_lsb = data->bme680_cal_buf_2[H2_MSB + 1];
 	calib->par_h2 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
 			(tmp_lsb >> BME680_HUM_REG_SHIFT_VAL);
 
-	ret = regmap_read(data->regmap, BME680_H3_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H3_REG\n");
-		return ret;
-	}
-	calib->par_h3 = tmp;
+	calib->par_h3 = data->bme680_cal_buf_2[H3];
+	calib->par_h4 = data->bme680_cal_buf_2[H4];
+	calib->par_h5 = data->bme680_cal_buf_2[H5];
+	calib->par_h6 = data->bme680_cal_buf_2[H6];
+	calib->par_h7 = data->bme680_cal_buf_2[H7];
+	calib->par_t1 = get_unaligned_le16(&data->bme680_cal_buf_2[T1_LSB]);
+	calib->par_gh2 = get_unaligned_le16(&data->bme680_cal_buf_2[GH2_LSB]);
+	calib->par_gh1 = data->bme680_cal_buf_2[GH1];
+	calib->par_gh3 = data->bme680_cal_buf_2[GH3];
 
-	ret = regmap_read(data->regmap, BME680_H4_REG, &tmp);
+	ret = regmap_bulk_read(data->regmap, BME680_REG_RES_HEAT_VAL,
+			       data->bme680_cal_buf_3,
+			       sizeof(data->bme680_cal_buf_3));
 	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H4_REG\n");
+		dev_err(dev, "failed to read 3rd set of calib data;\n");
 		return ret;
 	}
-	calib->par_h4 = tmp;
 
-	ret = regmap_read(data->regmap, BME680_H5_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H5_REG\n");
-		return ret;
-	}
-	calib->par_h5 = tmp;
+	calib->res_heat_val = data->bme680_cal_buf_3[RES_HEAT_VAL];
 
-	ret = regmap_read(data->regmap, BME680_H6_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H6_REG\n");
-		return ret;
-	}
-	calib->par_h6 = tmp;
+	calib->res_heat_range = FIELD_GET(BME680_RHRANGE_MASK,
+					data->bme680_cal_buf_3[RES_HEAT_RANGE]);
 
-	ret = regmap_read(data->regmap, BME680_H7_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H7_REG\n");
-		return ret;
-	}
-	calib->par_h7 = tmp;
-
-	/* Gas heater related coefficients */
-	ret = regmap_read(data->regmap, BME680_GH1_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_GH1_REG\n");
-		return ret;
-	}
-	calib->par_gh1 = tmp;
-
-	ret = regmap_bulk_read(data->regmap, BME680_GH2_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_GH2_LSB_REG\n");
-		return ret;
-	}
-	calib->par_gh2 = le16_to_cpu(buf);
-
-	ret = regmap_read(data->regmap, BME680_GH3_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_GH3_REG\n");
-		return ret;
-	}
-	calib->par_gh3 = tmp;
-
-	/* Other coefficients */
-	ret = regmap_read(data->regmap, BME680_REG_RES_HEAT_RANGE, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read resistance heat range\n");
-		return ret;
-	}
-	calib->res_heat_range = FIELD_GET(BME680_RHRANGE_MASK, tmp);
-
-	ret = regmap_read(data->regmap, BME680_REG_RES_HEAT_VAL, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read resistance heat value\n");
-		return ret;
-	}
-	calib->res_heat_val = tmp;
-
-	ret = regmap_read(data->regmap, BME680_REG_RANGE_SW_ERR, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read range software error\n");
-		return ret;
-	}
-	calib->range_sw_err = FIELD_GET(BME680_RSERROR_MASK, tmp);
+	calib->range_sw_err = FIELD_GET(BME680_RSERROR_MASK,
+					data->bme680_cal_buf_3[RANGE_SW_ERR]);
 
 	return 0;
 }
-- 
2.25.1


