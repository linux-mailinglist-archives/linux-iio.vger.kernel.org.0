Return-Path: <linux-iio+bounces-7515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE892F0E2
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CFF1F2458E
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C61A01A5;
	Thu, 11 Jul 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOkSWY/X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F4E19FA8A;
	Thu, 11 Jul 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732585; cv=none; b=bTRAN0p7vL2eLRuDSTrBBn+882zJOEzKGaXm6VVDZzXQruJ92Vb7qoluD6ut+DNySg13E72Mp6MiZrj+LPCOGDsP4s0TT/vLH9IWhpk4qQWhVNEqRSFnWPCFr9+Tb7s1Eyqk6g/zw/eBOj255wVPNkDo5CtaqLFsveeNO5Rxu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732585; c=relaxed/simple;
	bh=iswt38ZDh5L35RqJMLBJbpHgastqMexyjy5NdMfQDk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAKYFXZ8LLO6Zey0/hFG5UpD/cRT+GFJ+dhagb0wHc976xk9wey9mwY/S1kKL9HFiHzNy5f1GOPazfCNYkajFat2Pb8Y6NCCHLkYB/LL8fX4Vdb/mImpOnKoOBTyRBdorK8KR2TEV+f29V1r/Up+r8yfDJbmUx16xEuByy5K0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOkSWY/X; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so4386655a12.0;
        Thu, 11 Jul 2024 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732582; x=1721337382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJzviKKMGlR+YckvWALlWpdSojxVWWeJ6E/wr0TtI5g=;
        b=IOkSWY/X+0RCzjBcjZoD8vPiV35vDBGGlt1zSM+4+O+X1aIwzu8SmlHFYU8rsYG6Q+
         Lt3w45FXAI3DKw95Cm+mRRZSUAdqoBKN0k6AyCOAgEsrCXYRoStjT1NTtdWr/PPRdndk
         jOWMT443AY8gPKIkS+bZGoHKl6TBakVmLICoaobnY46Mj3fWy4K0A02rm3i5rubnb7x8
         cC/Et530mbcrsPKc41huJ7Qj8lRBV+ZUzbWQ5UES2JCcOvJAINsmUJlLdrSqnaAwFJx3
         bYZFjBk6FI0SBFiy8w5tzM+fCpQC4Zug4ema5aBz/AtlrSnKym6v3BYd8dNX+0z82uHv
         mYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732582; x=1721337382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJzviKKMGlR+YckvWALlWpdSojxVWWeJ6E/wr0TtI5g=;
        b=QqP9MHTfnyiOHxybr+WicNUSDClh6LlN1k/eAeOWuVVoU70B/qP5ELzOftL2BCVF7h
         9Px5Aq22eBZKuXp5bPpD03Q6CWqANil4DkiGyPZdqiJlNCBsjfc5Oi7AYS4bbK8yMQBu
         DLht/C/Ho14P4FWVgR54N13VhWQUL4IrKRZTHLetp7CbuF3+FKVMsD8EkIU7WaxnkctS
         MGV+J11lw9rDPxtyBpBDGLVIVAeST4K2f/1CCam6vYV9Gudp12F8yvdAh5f7cfCEaZ2R
         d5iBYJ4h3Nbhuvaq7ecf1x1Lp3LtLhnCEryONA2QM5IE7rbPIqvZmR2EOsQD7EhV/u/Z
         15Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWEDnRQUVcPMfM19Jg9etaFHjgDwfI6ej3AiZM9HfBURGu8Ye9AFSfSHJIAgKWXb5R689I36QdRUsROHKFhaUEGTYnN5t5uzdE3Lrw6lxqBLw2jNrIj8FND6cb9d2vd+AWSzDGzzi2P1LFNR7gV5tMUnCWGQQVwYWDr7bYBRCqewgCrbQ==
X-Gm-Message-State: AOJu0YwQsmK+IObRsL/iAlMlhfJjgWD5dPmFcm2J9/8mA6eCwmqvqcPt
	b4cvczSMw526vX1YHy7SSxuk/Yo4Jo6e0PzcfPacwnl0wmlQmLFZ
X-Google-Smtp-Source: AGHT+IGpWELhWi4gemSWFK9z79m77Dok2T6N/te+SGPKg7gKeTxVmsr5r/QurBA+2htn2bVGiZ8Uqg==
X-Received: by 2002:a50:d744:0:b0:57c:a8e5:35f0 with SMTP id 4fb4d7f45d1cf-59963bf4683mr524904a12.2.1720732581863;
        Thu, 11 Jul 2024 14:16:21 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:21 -0700 (PDT)
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
Subject: [PATCH v1 04/10] iio: pressure: bmp280: Use bulk read for humidity calibration data
Date: Thu, 11 Jul 2024 23:15:52 +0200
Message-Id: <20240711211558.106327-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711211558.106327-1-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 57 +++++++++---------------------
 drivers/iio/pressure/bmp280.h      |  5 +++
 2 files changed, 21 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 3deaa57bb3f5..9c32266403bd 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -118,6 +118,8 @@ enum bmp580_odr {
  */
 enum { T1, T2, T3, P1, P2, P3, P4, P5, P6, P7, P8, P9 };
 
+enum { H2 = 0, H3 = 2, H4 = 3, H5 = 4, H6 = 6 };
+
 enum {
 	/* Temperature calib indexes */
 	BMP380_T1 = 0,
@@ -344,6 +346,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	struct device *dev = data->dev;
+	s16 h4_upper, h4_lower;
 	unsigned int tmp;
 	int ret;
 
@@ -352,14 +355,6 @@ static int bme280_read_calib(struct bmp280_data *data)
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
@@ -368,43 +363,23 @@ static int bme280_read_calib(struct bmp280_data *data)
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
-	if (ret) {
-		dev_err(dev, "failed to read H4 comp value\n");
-		return ret;
-	}
-	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
-				  (be16_to_cpu(data->be16) & 0xf), 11);
-
-	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
-			       &data->le16, sizeof(data->le16));
+			       data->bme280_humid_cal_buf,
+			       sizeof(data->bme280_humid_cal_buf));
 	if (ret) {
-		dev_err(dev, "failed to read H5 comp value\n");
+		dev_err(dev, "failed to read humidity calibration values\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
 
-	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
-	if (ret) {
-		dev_err(dev, "failed to read H6 comp value\n");
-		return ret;
-	}
-	calib->H6 = sign_extend32(tmp, 7);
+	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
+	calib->H3 = data->bme280_humid_cal_buf[H3];
+	h4_upper = FIELD_GET(BME280_COMP_H4_MASK_UP,
+			     get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
+	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,
+			     get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
+	calib->H4 = sign_extend32((h4_upper & ~BME280_COMP_H4_MASK_LOW) | h4_lower, 11);
+	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
+				  get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
+	calib->H6 = data->bme280_humid_cal_buf[H6];
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index ccacc67c1473..56c01f224728 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -257,8 +257,12 @@
 #define BME280_REG_COMP_H5		0xE5
 #define BME280_REG_COMP_H6		0xE7
 
+#define BME280_COMP_H4_MASK_UP		GENMASK(15, 4)
+#define BME280_COMP_H4_MASK_LOW		GENMASK(3, 0)
 #define BME280_COMP_H5_MASK		GENMASK(15, 4)
 
+#define BME280_CONTIGUOUS_CALIB_REGS	7
+
 #define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
 #define BME280_OSRS_HUMIDITY_SKIP	0
 #define BME280_OSRS_HUMIDITY_1X		1
@@ -423,6 +427,7 @@ struct bmp280_data {
 		/* Calibration data buffers */
 		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
+		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
 		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
 		/* Miscellaneous, endianness-aware data buffers */
 		__le16 le16;
-- 
2.25.1


