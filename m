Return-Path: <linux-iio+bounces-7895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85C93CB0F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 01:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA70A282213
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 23:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5F149C43;
	Thu, 25 Jul 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfWLyBEo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D913A40F;
	Thu, 25 Jul 2024 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949049; cv=none; b=j3McKzEj9+zrOrOFW10DfuIwQPlui6baxvLDQlXaNHeL3kIKip8dcNzYCAPIsi/v47iNoUqxkNFkEaCuIob7I5zeh5n8JnFmJI/uTWeu9Y8zX3fJe1HgLPZ+kkMi9kPHi47yg/KLNNTs7SEYyc0MY6/x/5G7xyzGDS/1LMU+aM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949049; c=relaxed/simple;
	bh=bU6g/1CewHrh3Y4eSpL2nkX2mIMfO2GJeDtVaICiEjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfviO0Lj1NA01C88XfKtsgA8YFP3gX9D4/MkFkQ6qHFpoNzPrgNMBLH8Elh1wYdGVBgYE7fKMDViXXquLq1KCMOwQs5Nx3tn/kPPmZuQMYQ9HZ29gU56RTq18oKWv2hyPknAMU+U2YxJdgI+Sc0+03hdWmUor/tUQJUKe9TfbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfWLyBEo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3687ea0521cso983676f8f.1;
        Thu, 25 Jul 2024 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721949046; x=1722553846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Pk3VNmmXeFSyUl6MZ453RlDn1WfDN/cfyqG4a/8dck=;
        b=TfWLyBEob+XarDnsI575FCrlbjpsk0xYLpq66bWfTcpJ6gL1eADjVdDORb8qYUxQf4
         VIBLs53iREhckMRJVchlSiJ/vxlLrkialZCXnAaZYfR7jGTtVqAZqAh548SuVZUz/ii7
         f2nBTLUyQHxs34l9Ao0qfc54PLl3/1iT+spr6KbpyqSj9foqsGTLu2PpFau/mV670gxm
         xgRRd0LaU/NHJJiCK2GtI593zbaVCwg1aUXIMVdmK6v6nG37mZEMorIGYCTCqKaP7AIv
         cL6oFEgUUP6ZwfKTbrLvl5bsRYo8dpNOU50DWtEwojQG5te9F/rYe/L3/SxZue5uwyUl
         C/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949046; x=1722553846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Pk3VNmmXeFSyUl6MZ453RlDn1WfDN/cfyqG4a/8dck=;
        b=d3QS0KpaHWqop5dDMuVU64uJF6h8DZbQd4dd1sJ5nNAp1tEYvhq1RGxq+J3pcwkElS
         mbjghGJsovZ1vyI5S5v6P3Hlg9B+YJDBOHdDOyX2ft/y7W4sQLx6GZEzbiWF0gwquNfh
         AtCh2lQIb5bgP4VHKEBrKKlTqNvmMcxrzUOW3gZ90yaI5pHv9eVpUY5Mvs+IgVgslH3a
         E6r9EEjvMOLPQQ4Ezy7CaG6N7X850f6hPZ6KG+QvLNJzxMSszt+lP67iw21VLTcpzQW4
         g6R+kX7VfvWJQSY4rufApgQAIRO41AouT6Pq91GW7ISbdpZ1m9SnlNpA6KHIouVO9U5o
         wGhg==
X-Forwarded-Encrypted: i=1; AJvYcCXtr0nX06u1HXve0spOFZ43xS4xX49Wd3u9wNSUlcAWSMqrfl8INlEK1QOsWaJdqx7Y/gFup/8HRWENzyrM6Lcf9SfSnAYJJuWn4lY3XOzx4PNIPP7lJ56mjnNysTkNxBzKlxFz0w9QrsxE/b0IbNzyj+mjRMmrbBJ253QxHiwRxOb4TA==
X-Gm-Message-State: AOJu0YywBirbisk1ZafHRu9DV9vXTupS3iq7aqjTjI7j/UzM0TEIc+ms
	2276sHhDXeYicO+iLACy/6uhxWzi/n+f2wMyYjvaaZGk2y+jeyj2HNEKYBaN500=
X-Google-Smtp-Source: AGHT+IFtGti7GttichkeNh5KbVtrBZYQrb4xY2QAIVOzFkS1RisYA1umVyrFy21fVhJdgpi2fWDDoQ==
X-Received: by 2002:a5d:648c:0:b0:368:6f64:307c with SMTP id ffacd0b85a97d-36b363c46dfmr3476283f8f.15.1721949046261;
        Thu, 25 Jul 2024 16:10:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b59:cba2:6db8:9f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236e3sm115429266b.25.2024.07.25.16.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:10:45 -0700 (PDT)
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
Subject: [PATCH v2 1/7] iio: pressure: bmp280: Use bulk read for humidity calibration data
Date: Fri, 26 Jul 2024 01:10:33 +0200
Message-Id: <20240725231039.614536-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240725231039.614536-1-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 62 ++++++++++--------------------
 drivers/iio/pressure/bmp280.h      |  6 +++
 2 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 3deaa57bb3f5..d5e5eb22667a 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -118,6 +118,12 @@ enum bmp580_odr {
  */
 enum { T1, T2, T3, P1, P2, P3, P4, P5, P6, P7, P8, P9 };
 
+/*
+ * These enums are used for indexing into the array of humidity parameters
+ * for BME280.
+ */
+enum { H2 = 0, H3 = 2, H4 = 3, H5 = 4, H6 = 6 };
+
 enum {
 	/* Temperature calib indexes */
 	BMP380_T1 = 0,
@@ -344,6 +350,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	struct device *dev = data->dev;
+	s16 h4_upper, h4_lower;
 	unsigned int tmp;
 	int ret;
 
@@ -352,14 +359,6 @@ static int bme280_read_calib(struct bmp280_data *data)
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
@@ -368,43 +367,24 @@ static int bme280_read_calib(struct bmp280_data *data)
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
index ccacc67c1473..9bea0b84d2f4 100644
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
@@ -423,6 +428,7 @@ struct bmp280_data {
 		/* Calibration data buffers */
 		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
+		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
 		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
 		/* Miscellaneous, endianness-aware data buffers */
 		__le16 le16;
-- 
2.25.1


