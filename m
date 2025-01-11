Return-Path: <linux-iio+bounces-14135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09DA0A50D
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 18:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAADC3A9A8D
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E431B414E;
	Sat, 11 Jan 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4a43MRN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D4155C8C;
	Sat, 11 Jan 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736616401; cv=none; b=Xqqu0EO4TXt1Lggf5XNnbLWS6GHzrdMtfiN9CvATs80NJmw0n4XJZT8nDlluiMr+MpnUuQHgfxgroCatVyp0oAF55lS7N3W6q2EAR1bODMRKQgD5mnwWk1HwapRZgIZMaLT1nwLZmgZEZOofuQ5Byesk/UkMcMTGyCo0ECeudKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736616401; c=relaxed/simple;
	bh=SgenMkrlQ5nCduRhUC1N2c3jer05e+ZdPCrLLrnff+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GCI9nRqfMZ36bfRTWxeyLbZH7aBUkGQnLbfIJ/KZ10zHX+UNgcPFgt9dCYGTbXKmsUAHR8Y1yJl1FYOMSe2GrIaikmhGEnRsZTEm4LO6wIbe543cbzgGWDWrP8PF13Vs9onUwRuEO+jtYKn/lCZxv3dHFhkIcRoAH1SZnGZ2Lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4a43MRN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166022c5caso47463795ad.2;
        Sat, 11 Jan 2025 09:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736616399; x=1737221199; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5aR/AeCIqJJUNu9WuzkjvUUwCFCHJ6F4TqHoGh0Qm0=;
        b=Q4a43MRNzYIeg5OwZAEam8dr+m3cB4d+KvyDgjABH6slxJustRDpvyK5mkmUUbT+E/
         y2KLg+9X82q7ZhMq76EAHdNtJVvSOSDqQjNqEVja+ZTIMtpxYakGjjDab3RVVnZmlvJ7
         9RcvFxO0f53c4k5VTvbox/GGa62r5OfoxOcZSMs8az5F/QR0O/GIL5+G1XAyYlJtk5Wd
         BYbPeH/5EsPZ052S6fwGLilyfsxvyqj3mq0sXORTBTtmNkKVKVId87JwXyRN56xaJr3l
         72NQzAfRPjaJ0QkkcslEIURWLWFG0kSjLKt+kbRyrQa7+L/o2p4h2wiXM61dFDxT5PCM
         kHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736616399; x=1737221199;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5aR/AeCIqJJUNu9WuzkjvUUwCFCHJ6F4TqHoGh0Qm0=;
        b=YNB4NaP3S7A5XYpXoT8qrtqzgTcyih0oJ8I1FCzt5UQ5w6XqpBx/EOmij5Uy2sCW3A
         JqyUJXm5P3vb/5etLy3Q8EF3ltae7Gx7voCRTaz+xh0hSpzDPRJM1I2XblHePcltbWsJ
         C1aDcB3CValK6RwUbQ2tfW3WKkZLETIvsWgpGHVQ7L6SexpBA8C35ui/JTOBz6L/3Z5O
         J8Wy8121oKcmXxZ49EPcgxt1e7gvHZt6qyjs1cTGxOs9VYu+3lnR+euMe41ePIBq71fD
         bKtQ8rjDoh9aggnOhFQPHhRv1W9R0AOa5RmeeL51VWYwXVOS/j846mg4AeUrOiRtPcB/
         orcw==
X-Forwarded-Encrypted: i=1; AJvYcCW5lnGegv3qoezIcebQmELVhlYw7796/YEOVY3aPWkx3QcsFLEnENMVPALOwCRUjGsRHd98RQ9SQjUXtW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJNi+z+ynV+hx8POTLJkth76ox8Tmmw2nGT8pWlxpf3HccrVK
	Bxl/vzvMaKPmAM1Ta3Nsx9PjLDlfBAWB+fgqqZdpodjhuWVjELdJ
X-Gm-Gg: ASbGncs/FNiSSbWwVUmHL0/LxipVAc4tikBa8Xs3xaNzBqZpeuPiruck+sATE/NR5MY
	+8m7XrvIqaozflowF2KH6A+/Jr1PDsp4w4nejd+LruEsYNh2+kR+mh7zeYiEk97/dC0gMMTWrNi
	7zuEYNmI33nYxyGrPm8xGiwsRX8pHJWB1GbDNfeTskO8G37OQ64rn1ISp82fYSy7UR19UVT3s6N
	kfBq6qOyIvQu5ColR3Gndv32UGP+StJlclDuYPDC8QQEr6PJNyqMhIBc6ZidZ/j7mk=
X-Google-Smtp-Source: AGHT+IG86Cr71QbfW4k6OZuZJCAUVBbiCiD69lD5zanRuiGOWfzwTu+Cc5DdsnOAMZSqDTnB2LTb5A==
X-Received: by 2002:a05:6a20:c999:b0:1e4:80a9:b8fa with SMTP id adf61e73a8af0-1e88cfa6fc5mr26716705637.13.1736616399440;
        Sat, 11 Jan 2025 09:26:39 -0800 (PST)
Received: from [192.168.0.110] ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658bb4sm3250939b3a.86.2025.01.11.09.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 09:26:39 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Sat, 11 Jan 2025 14:26:18 -0300
Subject: [PATCH] iio: imu: bmi270: add temperature channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-bmi270-temp-v1-1-76ee38211bf2@gmail.com>
X-B4-Tracking: v=1; b=H4sIALmpgmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0ND3aTcTCNzA92S1NwC3VTLFCNTYzNDS0MLAyWgjoKi1LTMCrBp0bG
 1tQA4RonqXQAAAA==
X-Change-ID: 20250111-bmi270-temp-e9d253619180
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736616396; l=5316;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=SgenMkrlQ5nCduRhUC1N2c3jer05e+ZdPCrLLrnff+0=;
 b=C3GanxjtQLZzqqvS4FcYa3Ohd4O/smgzJWuVuawWldL9RVvWl7lIOJeYYy9DD5PDkrqErTsHu
 YpzYofs4T2+BWlT9KQqihB06z2Byg8g+Bwh/7TmX219GoXeP5XczOa/
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

The BMI270 IMU includes a temperature sensor. Add a channel for reading
the temperature.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 49 ++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 7fec52e0b48624f07031b63a9caf6c318f33f5dc..c7853923aa69f83a829a71979135f1f7a7ef29ec 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -5,6 +5,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -28,10 +29,11 @@
 #define BMI270_INTERNAL_STATUS_REG			0x21
 #define BMI270_INTERNAL_STATUS_MSG_MSK			GENMASK(3, 0)
 #define BMI270_INTERNAL_STATUS_MSG_INIT_OK		0x01
-
 #define BMI270_INTERNAL_STATUS_AXES_REMAP_ERR_MSK	BIT(5)
 #define BMI270_INTERNAL_STATUS_ODR_50HZ_ERR_MSK		BIT(6)
 
+#define BMI270_TEMPERATURE_0_REG			0x22
+
 #define BMI270_ACC_CONF_REG				0x40
 #define BMI270_ACC_CONF_ODR_MSK				GENMASK(3, 0)
 #define BMI270_ACC_CONF_ODR_100HZ			0x08
@@ -69,6 +71,10 @@
 #define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
 #define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
 
+/* See datasheet section 4.6.14, Temperature Sensor */
+#define BMI270_TEMP_OFFSET				11776
+#define BMI270_TEMP_SCALE				1953125
+
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
 
@@ -109,6 +115,7 @@ EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, "IIO_BMI270");
 enum bmi270_sensor_type {
 	BMI270_ACCEL	= 0,
 	BMI270_GYRO,
+	BMI270_TEMP,
 };
 
 struct bmi270_scale {
@@ -136,6 +143,10 @@ static const struct bmi270_scale bmi270_gyro_scale[] = {
 	{ 0, 66 },
 };
 
+static const struct bmi270_scale bmi270_temp_scale[] = {
+	{BMI270_TEMP_SCALE / MEGA, BMI270_TEMP_SCALE % MEGA},
+};
+
 struct bmi270_scale_item {
 	const struct bmi270_scale *tbl;
 	int num;
@@ -150,6 +161,10 @@ static const struct bmi270_scale_item bmi270_scale_table[] = {
 		.tbl	= bmi270_gyro_scale,
 		.num	= ARRAY_SIZE(bmi270_gyro_scale),
 	},
+	[BMI270_TEMP] = {
+		.tbl	= bmi270_temp_scale,
+		.num	= ARRAY_SIZE(bmi270_temp_scale),
+	},
 };
 
 static const struct bmi270_odr bmi270_accel_odr[] = {
@@ -255,7 +270,7 @@ static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 }
 
 static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
-			    int *uscale)
+			    int *scale, int *uscale)
 {
 	int ret;
 	unsigned int val;
@@ -280,6 +295,10 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
 		val = FIELD_GET(BMI270_GYR_CONF_RANGE_MSK, val);
 		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
 		break;
+	case IIO_TEMP:
+		val = 0;
+		bmi270_scale_item = bmi270_scale_table[BMI270_TEMP];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -287,6 +306,7 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
 	if (val >= bmi270_scale_item.num)
 		return -EINVAL;
 
+	*scale = bmi270_scale_item.tbl[val].scale;
 	*uscale = bmi270_scale_item.tbl[val].uscale;
 	return 0;
 }
@@ -399,6 +419,9 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
 	case IIO_ANGL_VEL:
 		reg = BMI270_ANG_VEL_X_REG + (axis - IIO_MOD_X) * 2;
 		break;
+	case IIO_TEMP:
+		reg = BMI270_TEMPERATURE_0_REG;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -427,12 +450,20 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		ret = bmi270_get_scale(bmi270_device, chan->type, val2);
+		ret = bmi270_get_scale(bmi270_device, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = BMI270_TEMP_OFFSET;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = bmi270_get_odr(bmi270_device, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+
 	default:
 		return -EINVAL;
 	}
@@ -544,6 +575,13 @@ static const struct iio_chan_spec bmi270_channels[] = {
 	BMI270_ANG_VEL_CHANNEL(X),
 	BMI270_ANG_VEL_CHANNEL(Y),
 	BMI270_ANG_VEL_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = -1, /* No buffer support */
+	},
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 
@@ -646,7 +684,8 @@ static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
 	ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
 			      BMI270_PWR_CTRL_AUX_EN_MSK |
 			      BMI270_PWR_CTRL_GYR_EN_MSK |
-			      BMI270_PWR_CTRL_ACCEL_EN_MSK);
+			      BMI270_PWR_CTRL_ACCEL_EN_MSK |
+			      BMI270_PWR_CTRL_TEMP_EN_MSK);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
 

---
base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
change-id: 20250111-bmi270-temp-e9d253619180

Best regards,
-- 
Gustavo Silva <gustavograzs@gmail.com>


