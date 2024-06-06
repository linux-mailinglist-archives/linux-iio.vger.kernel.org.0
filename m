Return-Path: <linux-iio+bounces-5955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C928FF6BF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E912886CB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848D919CD15;
	Thu,  6 Jun 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL8WOS+7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8B19B3D8;
	Thu,  6 Jun 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709048; cv=none; b=a9RTqPuWJGA/DEs6/nFohAlfcwnnM211efMi/fZyjCyudM+P/UqnIrlia1WlHvyyb10qgSlJ5hDZf1BOVLr3ftn0ImKfgwvQlOSPtgcPAEGffS3LmCmBHee/BdKcatMfsiTAmjKFhToE2fQV+ZptYQ/QkHB+96YtMfK/onN83nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709048; c=relaxed/simple;
	bh=7kpRsJ9DR2TtBQ4nmCfHpORXQM9PIu6cwpBFG48iQ2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKAy5sxeDjGs9KUMDP9uCQC2QlUv8NF7mRaJ7fIJgCz0lCXkgiHrIyoxfYnR+C5mQ3vi+2uWxAdV9cpGDoMZN9+Af+psDTebwZFXXmUnfnZjaWQaaX8pgx89rQPTFSPvzNif+y4eS4y9ZVNH3M/hyLp8nPetikfPOqYp1KGDmkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL8WOS+7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a691bbb7031so195142266b.1;
        Thu, 06 Jun 2024 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709045; x=1718313845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJizzfNOx7HrtlwTGiipVvgYiyOjeUKSsMLHTZf2fVM=;
        b=kL8WOS+7RXPJVlD9C2XSl4m4rGZj+Gego0rtsSGN02WXnBfGNl5OxGY4UYC4z/k9bd
         vuMWHIMoThQ3wzFluiLPUPzDH+UlDg5pZn8ZGhv+2BvjiWsLoyFmHg/F9ay0Rd+WB2iq
         SYAgyQ/USci6j6Pp1SFM6BG2Ow+z+llMUffklZV8KtwcmiYYdauxY3JlqhZj4jgauwSS
         LWMaEq0OkA2qR9SQ/ERjsDpu2MiRgN1L3xxFCcMwghqgCVmg2TY6kn3UNSFwHOQAHalj
         FRZewEg+GdDvpr8hZkmdzjxawo1PYz4y8m5BTzswGKxOBekNor8pPa6AZGxiaX05goCq
         G99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709045; x=1718313845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJizzfNOx7HrtlwTGiipVvgYiyOjeUKSsMLHTZf2fVM=;
        b=ZXaWXuvh71pIMRcytmfH6zZK0uK+ATMagJxVsSVljCplid3uE40CA65IJFVswafjBx
         RHX8R9wYDtaPrFoLh7cCOx07fEvR+149YLxIWWsfAB9B3eGn9RQq9FrXBuK6hy8UTgwZ
         g27mx004Nlj3+GkOXwiaV6Uw1bqgBqPzXpjDy5dW7vU/HAQ6WrGzbHbx/q6mUJh6WLl/
         tWYXYt/PXKpuAr6C0DfCC/rjhDeSOiNdPATSQGBcSFwlcqrdm2K0nYwDMZYUtrA52IpP
         fp49vzjWV17yN8zPFABE0ZTAFf8HM9ZL36NagZal+jzDafBfeBL3eUIsLQhQz+ZCJQYb
         O+nw==
X-Forwarded-Encrypted: i=1; AJvYcCX5o+K9Esa1sbe4Op9hSki6IcdF2S4pjizCpwrxpBr9uMYwtgh36kxeqdlV0azI1MEJaX5u2eSDeUJIsZ1LxFGh7gsgiqWART/RgZMYpS/3KG1TiZ30b+huQ+44XtDHi7/eberSGLB/
X-Gm-Message-State: AOJu0YzpYf95gqJMRucigTtD1SjX12F/kx4hNiba7iiWNyrL6zCtf5cW
	p5Cw+ZpjTXWMXTfHo4dI1bWCp/444O9zGu1Z+y+0PrDTLpItIXX+x50BIkR6aSE=
X-Google-Smtp-Source: AGHT+IGRl86RQfdkFDmfPIjmVCRQg0QCE7alS88TOGAQYkZ5TCeoBuoY1k4+ChYPPIj/xrghJ6LTrQ==
X-Received: by 2002:a17:906:b7c7:b0:a62:b36a:eafa with SMTP id a640c23a62f3a-a6cdaa0fa87mr52322966b.57.1717709044836;
        Thu, 06 Jun 2024 14:24:04 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:04 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 11/19] iio: chemical: bme680: Use bulk reads for calibration data
Date: Thu,  6 Jun 2024 23:23:03 +0200
Message-Id: <20240606212313.207550-12-vassilisamir@gmail.com>
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

Calibration data are located in contiguous-ish registers
inside the chip. For that reason we can use bulk reads as is
done as well in the BME68x Sensor API [1].

The arrays that are used for reading the data out of the sensor
are located inside DMA safe buffer.

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1769
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
index c1e191ed4955..f96cd4157c95 100644
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


