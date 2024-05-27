Return-Path: <linux-iio+bounces-5374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0DE8D0A00
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCA21F22D05
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C759167295;
	Mon, 27 May 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koSYMXib"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D801667F3;
	Mon, 27 May 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835106; cv=none; b=Wm6RowzPMPX9IWZwqt1AnNu0QhzFhkb6dAJ2TyCqu1+bBfo0D1FzkHQ2ACPXf3ZFnodfx3a/IXYXb1dkhNbo0WHWEDX9+TfrP6zLXCs+j5ImSAw+gYGNQLSw6A9AjDGFKawyE1MJ1/V8A4BsAGs1EQBwq1WNRvYyM8HJ46+BuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835106; c=relaxed/simple;
	bh=ykscsYCCyhgNHO05aM4Rh85SDORxcXBSPMYX9rXWtGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LypdineDpKA3eucEjbaybhnwj31YesN06gnDWAqGM+V2m5CvXR4/rfOyVKox9oh3b28u0nW7zCRvK0EiI5cFmNtCyQLGJwjBAYik/ZGm7QJiP+qtF/+qF4ijbTLoKiK5OHeGyPSnKsDT3oubTZsGz6zpRPwfnvbgTJLxpi/t4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koSYMXib; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5785f861868so11618a12.2;
        Mon, 27 May 2024 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835103; x=1717439903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl31DSqAuaYSaUAdIXX4MtfeWlKhLyQWtpVC8KlB5nw=;
        b=koSYMXibEDi78tEJvK8yym3MR2dVR0s52sODOuIxBqglTx6wpvh3P9TFrKqXaFyQp5
         EOe14ewaXJrRbc09Uhbz+DnLH4/NtrbNJ/W55okm/dAqhsCMHozlNbI+N//sn/8ymdnf
         8mPPC8WBfOS69G+BpBFBA2/zICFLgvN9qU3Avvh/XNWnryQ2suw1uZ448x8h50qZDktG
         UQL5Qayty+KDG8akEE/E5oyznTDYdR/pR6BAEbodNd+MoGqwFeJLbK/jmKtRICv+DWzm
         CP9tfis6k9AuVHv+VJxx0x7RlORFYATKC5tOxHSwhCVdQ6EQfkStDU5tHHnR5mvhCE3S
         j2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835103; x=1717439903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl31DSqAuaYSaUAdIXX4MtfeWlKhLyQWtpVC8KlB5nw=;
        b=lVtlNIbAVgsGqyAWJXwpHTKy7SVMk6n+owICEgQWZlOEHyCRIpQ0r99dslcZJu/5vf
         F2of7doimPGexlorUAZVv02X6I1xcDnEHN/g1+WY8yJdby9YNqf+93mRKQVr6FzfROUH
         4b63aLzaiUUHgam36LXxXqu9NSXdLcpopO7g0XXqJFIctqaUCpj58t5z72cxDJtZaq39
         9BcfpBM5neB0ml1K/XLxSl4/Tht9DceH4jfgRwH96CtHr1f3UDTVZ8CeDg474ln5lsJt
         ge3OOip3QUk6O5Sp4pRA45rEi1qfMovH0p57MkIyXrrKn5B+sKXRrtmV/wCukJ5+/XOT
         rdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUFdqA1KKhIG8hGOBU2ySNvY7F6EFT6GNtp6K4LmS5KoQ6MzpGirgHLxrxNNzf6FCHG/4aj6WzR2uuRIk9BjJAFWk/reP81AO5QqNWhYyaVB0L1SHsKK8TgU4gO0onIoJeDSxCdpE0
X-Gm-Message-State: AOJu0YxAV/04JBx988xqbVtBXg8vEhCWI9oj0Z27tjMmWDLiT4dperLs
	DXKMgDXgkTCbVBvM7WofZxqp/ZFVoGALsT5qxVDUU07uJkc7vLjW
X-Google-Smtp-Source: AGHT+IGzR74hzgBNu7nOyEfTbrBMiapKvBXfNxm91qV77whUvbb9ChhsTrvv7FTJjHV/7VaY8H0Dow==
X-Received: by 2002:a17:906:a0a:b0:a5a:4683:e961 with SMTP id a640c23a62f3a-a6264f0eeaemr661579966b.52.1716835103220;
        Mon, 27 May 2024 11:38:23 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:22 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 11/17] iio: chemical: bme680: Use bulk reads for calibration data
Date: Mon, 27 May 2024 20:37:59 +0200
Message-Id: <20240527183805.311501-12-vassilisamir@gmail.com>
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

Calibration data are located in contiguous-ish registers
inside the chip. For that reason we can use bulk reads as is
done as well in the BME68x Sensor API [1].

The arrays that are used for reading the data out of the sensor
are located inside DMA safe buffer.

[1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1769
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  28 +--
 drivers/iio/chemical/bme680_core.c | 283 ++++++++++-------------------
 2 files changed, 101 insertions(+), 210 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 3133d624270a..5f602170a3af 100644
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
@@ -58,31 +56,13 @@
 
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
index 681f271f9b06..ed4cdb4d64af 100644
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
@@ -64,6 +109,16 @@ struct bme680_data {
 	 * and humidity compensation calculations.
 	 */
 	s32 t_fine;
+
+	/*
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	union {
+		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
+		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
+		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
+	} __aligned(IIO_DMA_MINALIGN);
 };
 
 static const struct regmap_range bme680_volatile_ranges[] = {
@@ -112,217 +167,73 @@ static int bme680_read_calib(struct bme680_data *data,
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
+			       &data->bme680_cal_buf_1[0],
+			       sizeof(data->bme680_cal_buf_1));
 	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_T2_LSB_REG\n");
+		dev_err(dev, "failed to read 1st set of calib data;\n");
 		return ret;
 	}
-	calib->par_t2 = le16_to_cpu(buf);
 
-	ret = regmap_read(data->regmap, BME680_T3_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_T3_REG\n");
-		return ret;
-	}
-	calib->par_t3 = tmp;
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
 
-	/* Pressure related coefficients */
-	ret = regmap_bulk_read(data->regmap, BME680_P1_LSB_REG,
-			       &buf, sizeof(buf));
+	ret = regmap_bulk_read(data->regmap, BME680_H2_MSB_REG,
+			       &data->bme680_cal_buf_2[0],
+			       sizeof(data->bme680_cal_buf_2));
 	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P1_LSB_REG\n");
+		dev_err(dev, "failed to read 2nd set of calib data;\n");
 		return ret;
 	}
-	calib->par_p1 = le16_to_cpu(buf);
 
-	ret = regmap_bulk_read(data->regmap, BME680_P2_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P2_LSB_REG\n");
-		return ret;
-	}
-	calib->par_p2 = le16_to_cpu(buf);
-
-	ret = regmap_read(data->regmap, BME680_P3_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P3_REG\n");
-		return ret;
-	}
-	calib->par_p3 = tmp;
-
-	ret = regmap_bulk_read(data->regmap, BME680_P4_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P4_LSB_REG\n");
-		return ret;
-	}
-	calib->par_p4 = le16_to_cpu(buf);
-
-	ret = regmap_bulk_read(data->regmap, BME680_P5_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_P5_LSB_REG\n");
-		return ret;
-	}
-	calib->par_p5 = le16_to_cpu(buf);
-
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
-
-	ret = regmap_read(data->regmap, BME680_H4_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H4_REG\n");
-		return ret;
-	}
-	calib->par_h4 = tmp;
-
-	ret = regmap_read(data->regmap, BME680_H5_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H5_REG\n");
-		return ret;
-	}
-	calib->par_h5 = tmp;
-
-	ret = regmap_read(data->regmap, BME680_H6_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H6_REG\n");
-		return ret;
-	}
-	calib->par_h6 = tmp;
+	calib->par_h3 = data->bme680_cal_buf_2[H3];
+	calib->par_h4 = data->bme680_cal_buf_2[H4];
+	calib->par_h5 = data->bme680_cal_buf_2[H5];
+	calib->par_h6 = data->bme680_cal_buf_2[H6];
+	calib->par_h7 = data->bme680_cal_buf_2[H7];
+	calib->par_t1 = get_unaligned_le16(&data->bme680_cal_buf_2[T1_LSB]);
+	calib->par_gh2 = get_unaligned_le16(&data->bme680_cal_buf_2[GH2_LSB]);
+	calib->par_gh1 = data->bme680_cal_buf_2[GH1];
+	calib->par_gh3 = data->bme680_cal_buf_2[GH3];
 
-	ret = regmap_read(data->regmap, BME680_H7_REG, &tmp);
+	ret = regmap_bulk_read(data->regmap, BME680_REG_RES_HEAT_VAL,
+			       &data->bme680_cal_buf_3[0],
+			       sizeof(data->bme680_cal_buf_3));
 	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_H7_REG\n");
+		dev_err(dev, "failed to read 3rd set of calib data;\n");
 		return ret;
 	}
-	calib->par_h7 = tmp;
 
-	/* Gas heater related coefficients */
-	ret = regmap_read(data->regmap, BME680_GH1_REG, &tmp);
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_GH1_REG\n");
-		return ret;
-	}
-	calib->par_gh1 = tmp;
+	calib->res_heat_val = data->bme680_cal_buf_3[RES_HEAT_VAL];
 
-	ret = regmap_bulk_read(data->regmap, BME680_GH2_LSB_REG,
-			       &buf, sizeof(buf));
-	if (ret < 0) {
-		dev_err(dev, "failed to read BME680_GH2_LSB_REG\n");
-		return ret;
-	}
-	calib->par_gh2 = le16_to_cpu(buf);
+	calib->res_heat_range = FIELD_GET(BME680_RHRANGE_MASK,
+					data->bme680_cal_buf_3[RES_HEAT_RANGE]);
 
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


