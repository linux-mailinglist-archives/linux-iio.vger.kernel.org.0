Return-Path: <linux-iio+bounces-13996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB51A04B39
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 21:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E274D7A1A79
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6C1F7577;
	Tue,  7 Jan 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEjDG/z0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F011F0E51;
	Tue,  7 Jan 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283035; cv=none; b=ctYgw7Yvw6w701AR4/AJxNbITNo6xFEG3pYg2TiE8gRygnCzy8WiggERtVsKgPBIscwADPqEss0+WnH7uenQfgKRT47ezl5CRliPmGMPGiwI7yu+65I9PloZhrN03RVQq4EDC+v14xvvE3duuEGO0ftltR8xkHuak2K46J3K4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283035; c=relaxed/simple;
	bh=Iienbc2qVz4mDNf7QRLkNge3CzYKtLbkTDkFgBYH+L4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R/ulW7+EwWgLbBnvjAW/3MJaZsC9KOP7PADyh/Z3/Fm1onFmtZghLVmYgldZb+/yX6gjamdjsRo7MubkmWhLsou33P9UJsrHJwx/ejjR7pEcNntxO87zIlYaWGqwR/pz6hk58UO88M3JSqZztHigkZ8XOOqyYO5+/seekBrdIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEjDG/z0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so128499f8f.0;
        Tue, 07 Jan 2025 12:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736283032; x=1736887832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1E1phjLhIpyJ0l80RZjpeovCq+rJJRSrgA/X9ld+Tg=;
        b=AEjDG/z0lp0dfElrYJTNXvuQja233Rywuwf1+TGlCiSQ0SUsBo9Yk2XOlgIXjkNqg0
         IBzmK0nZhG/gpyae6r0L2F3ynMCQq53T5e2aLGktgr3vx/ikh3mmJtAg1k8qqfUhx02x
         d007InVErpxfY6Bq+aGQb0zC0q77HDsCH7Mf/oWI6lFtiCipuy22CaG4piGeCfAHH1BE
         cK5Sv1w5XCkhLTYeAtNYgitl28mluKeF7C2AgnwYUc7sflUZ8FlcpQaw6qH65RTGCXvr
         UYwwDb3J4dh5rwk0vTEbXKfTuy/00KYdAGmbbUi7zZho1/3kCI0dWK8gTcyOgMDc7USG
         VBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736283032; x=1736887832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1E1phjLhIpyJ0l80RZjpeovCq+rJJRSrgA/X9ld+Tg=;
        b=LX2/R3pAs3jJJ6N6jQsi9DiyCPKxHKHn1sdSechggJRyjaYeTdVhZ9GdyrLPKc8oR2
         PiiGcCDbVVnT1Fu14GECtvp7DG272GX7pCsO21YnMbhlZA/YQqjCfhF4Y1lv0a70QLPZ
         3e08r3t0GREDEIaDQPUPChF4XKNFn1Zf1wF+D3dCV1HzCG1VNiKVHDdkgB9NKg9phKC+
         +ZmghSwZerqu9MGFCJ8NEKpf1kH2Bwv/MM3zXMUDc8fa/xgZwBZ0i+Bq1prxwhgqoxiU
         vZ+jx/yyvCb6oJPPQUY1HTdcSiRxg17My1kAYgkC3zuyRTMTrmEeTrKW9XnVzdT4Svoj
         C9ww==
X-Forwarded-Encrypted: i=1; AJvYcCULIeX9yTblZIls5/r0q6iYsQWBLlFUBTo9Jzwk57F/W6A7vIcIbTSzO2wbjpqdRotjKnzeck+FAejVru8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbuJwL0w4aCsxN+WuWkHUFTvW4Pod+D7FxnSvY54f4raafUqc
	2T0RW62gIbRfsGsz3kBIPIeRyXosQubCbKRcPSUwiATunSl4Jy8T
X-Gm-Gg: ASbGncsXQAirLVXiwg2x4JuNOIpkCvq+p5EvNC4+howSRJThkiTBfNTaDAsTMIra9NK
	fiaYSC56GOKd4ZBumJ/zRRDiZc/F2oEcMHY+PLlU979TbIgnEN01hpR/tadz23y/aUJfDDguXIn
	03lmkI2Rh+x7SjjOYN6qPW2j3xgmiSUd/Ls4oONQERvI7E4OBU+pHG9x0sP/D59k8G5Bi0MtEyv
	1LHd08riadsSA2DJQKr38r/vxOtro5zIwJOQ+rI6cSxbQKR1sOfgaIYJfO+0v0qm+s2ppR4Cqel
	amyV9XKdUVScb1UC5OVoDKrn6MC+yQtIgbwvjQmrgYnArH47QfzbhfsrXSCYO0Q/CriNnLsyNIx
	JpsE=
X-Google-Smtp-Source: AGHT+IF5m4Sw5sANSyJrlgKIPH0TtI8++0CBi8k9WFTSInzjxWHjGdmeA75PcWPkKZg0xruVM7mV1Q==
X-Received: by 2002:a5d:6d8f:0:b0:381:ed32:d604 with SMTP id ffacd0b85a97d-38a85e26990mr505847f8f.10.1736283031637;
        Tue, 07 Jan 2025 12:50:31 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d595-98be-71e7-371c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d595:98be:71e7:371c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a67c77a90sm13164132f8f.54.2025.01.07.12.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:50:30 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 07 Jan 2025 21:50:21 +0100
Subject: [PATCH 1/2] iio: light: veml6030: extend regmap to support
 regfields and caching
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-veml6030-scale-v1-1-1281e3ad012c@gmail.com>
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
In-Reply-To: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736283026; l=10381;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Iienbc2qVz4mDNf7QRLkNge3CzYKtLbkTDkFgBYH+L4=;
 b=ir5wm6wzX5KK6hwvKagOdNY81FMbVCTN0LTQdZZQgcs6Eke6AbDiqSGs1zB7VEuPyBYCMRCsL
 r++j/4u3lknC7siRNPkazJTPPivqS7VpLeBHktxWVoBptw/V2BdpCjX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The configuration registers are not volatile and are not affected
by read operations (i.e. not precious), making them suitable to be
cached in order to reduce the number of accesses to the device.

Add support for regfields as well to simplify register operations,
taking into account the different fields for the veml6030/veml7700 and
veml6035.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 141 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 116 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 9b71825eea9bee2146be17ed2f30f5a8f7ad37e3..a6385c6d3fba59a6b22845a3c5e252b619faed65 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -65,6 +65,11 @@ enum veml6030_scan {
 	VEML6030_SCAN_TIMESTAMP,
 };
 
+struct veml6030_rf {
+	struct regmap_field *it;
+	struct regmap_field *gain;
+};
+
 struct veml603x_chip {
 	const char *name;
 	const int(*scale_vals)[][2];
@@ -75,6 +80,7 @@ struct veml603x_chip {
 	int (*set_info)(struct iio_dev *indio_dev);
 	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
 	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
+	int (*regfield_init)(struct iio_dev *indio_dev);
 };
 
 /*
@@ -91,6 +97,7 @@ struct veml603x_chip {
 struct veml6030_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
+	struct veml6030_rf rf;
 	int cur_resolution;
 	int cur_gain;
 	int cur_integration_time;
@@ -319,28 +326,59 @@ static const struct iio_chan_spec veml7700_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(VEML6030_SCAN_TIMESTAMP),
 };
 
+static const struct regmap_range veml6030_readable_ranges[] = {
+	regmap_reg_range(VEML6030_REG_ALS_CONF, VEML6030_REG_ALS_INT),
+};
+
+static const struct regmap_access_table veml6030_readable_table = {
+	.yes_ranges = veml6030_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6030_readable_ranges),
+};
+
+static const struct regmap_range veml6030_writable_ranges[] = {
+	regmap_reg_range(VEML6030_REG_ALS_CONF, VEML6030_REG_ALS_PSM),
+};
+
+static const struct regmap_access_table veml6030_writable_table = {
+	.yes_ranges = veml6030_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6030_writable_ranges),
+};
+
+static const struct regmap_range veml6030_volatile_ranges[] = {
+	regmap_reg_range(VEML6030_REG_ALS_DATA, VEML6030_REG_WH_DATA),
+};
+
+static const struct regmap_access_table veml6030_volatile_table = {
+	.yes_ranges = veml6030_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6030_volatile_ranges),
+};
+
 static const struct regmap_config veml6030_regmap_config = {
 	.name = "veml6030_regmap",
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = VEML6030_REG_ALS_INT,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.rd_table = &veml6030_readable_table,
+	.wr_table = &veml6030_writable_table,
+	.volatile_table = &veml6030_volatile_table,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int veml6030_get_intgrn_tm(struct iio_dev *indio_dev,
 						int *val, int *val2)
 {
-	int ret, reg;
+	int it_idx, ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	ret = regmap_field_read(data->rf.it, &it_idx);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't read als conf register %d\n", ret);
 		return ret;
 	}
 
-	switch ((reg >> 6) & 0xF) {
+	switch (it_idx) {
 	case 0:
 		*val2 = 100000;
 		break;
@@ -405,8 +443,7 @@ static int veml6030_set_intgrn_tm(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-					VEML6030_ALS_IT, new_int_time);
+	ret = regmap_field_write(data->rf.it, new_int_time);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't update als integration time %d\n", ret);
@@ -510,23 +547,22 @@ static int veml6030_set_als_gain(struct iio_dev *indio_dev,
 	struct veml6030_data *data = iio_priv(indio_dev);
 
 	if (val == 0 && val2 == 125000) {
-		new_gain = 0x1000; /* 0x02 << 11 */
+		new_gain = 0x01;
 		gain_idx = 3;
 	} else if (val == 0 && val2 == 250000) {
-		new_gain = 0x1800;
+		new_gain = 0x11;
 		gain_idx = 2;
 	} else if (val == 1 && val2 == 0) {
 		new_gain = 0x00;
 		gain_idx = 1;
 	} else if (val == 2 && val2 == 0) {
-		new_gain = 0x800;
+		new_gain = 0x01;
 		gain_idx = 0;
 	} else {
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-					VEML6030_ALS_GAIN, new_gain);
+	ret = regmap_field_write(data->rf.gain, new_gain);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't set als gain %d\n", ret);
@@ -544,30 +580,31 @@ static int veml6035_set_als_gain(struct iio_dev *indio_dev, int val, int val2)
 	struct veml6030_data *data = iio_priv(indio_dev);
 
 	if (val == 0 && val2 == 125000) {
-		new_gain = VEML6035_SENS;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS);
 		gain_idx = 5;
 	} else if (val == 0 && val2 == 250000) {
-		new_gain = VEML6035_SENS | VEML6035_GAIN;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS |
+				      VEML6035_GAIN);
 		gain_idx = 4;
 	} else if (val == 0 && val2 == 500000) {
-		new_gain = VEML6035_SENS | VEML6035_GAIN |
-			VEML6035_DG;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS |
+				      VEML6035_GAIN | VEML6035_DG);
 		gain_idx = 3;
 	} else if (val == 1 && val2 == 0) {
 		new_gain = 0x0000;
 		gain_idx = 2;
 	} else if (val == 2 && val2 == 0) {
-		new_gain = VEML6035_GAIN;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_GAIN);
 		gain_idx = 1;
 	} else if (val == 4 && val2 == 0) {
-		new_gain = VEML6035_GAIN | VEML6035_DG;
+		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_GAIN |
+				      VEML6035_DG);
 		gain_idx = 0;
 	} else {
 		return -EINVAL;
 	}
 
-	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
-				 VEML6035_GAIN_M, new_gain);
+	ret = regmap_field_write(data->rf.gain, new_gain);
 	if (ret) {
 		dev_err(&data->client->dev, "can't set als gain %d\n", ret);
 		return ret;
@@ -581,17 +618,17 @@ static int veml6035_set_als_gain(struct iio_dev *indio_dev, int val, int val2)
 static int veml6030_get_als_gain(struct iio_dev *indio_dev,
 						int *val, int *val2)
 {
-	int ret, reg;
+	int gain, ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	ret = regmap_field_read(data->rf.gain, &gain);
 	if (ret) {
 		dev_err(&data->client->dev,
 				"can't read als conf register %d\n", ret);
 		return ret;
 	}
 
-	switch ((reg >> 11) & 0x03) {
+	switch (gain) {
 	case 0:
 		*val = 1;
 		*val2 = 0;
@@ -617,17 +654,17 @@ static int veml6030_get_als_gain(struct iio_dev *indio_dev,
 
 static int veml6035_get_als_gain(struct iio_dev *indio_dev, int *val, int *val2)
 {
-	int ret, reg;
+	int gain, ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	ret = regmap_field_read(data->rf.gain, &gain);
 	if (ret) {
 		dev_err(&data->client->dev,
-			"can't read als conf register %d\n", ret);
+				"can't read als conf register %d\n", ret);
 		return ret;
 	}
 
-	switch (FIELD_GET(VEML6035_GAIN_M, reg)) {
+	switch (gain) {
 	case 0:
 		*val = 1;
 		*val2 = 0;
@@ -990,6 +1027,52 @@ static int veml7700_set_info(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int veml6030_regfield_init(struct iio_dev *indio_dev)
+{
+	const struct reg_field it = REG_FIELD(VEML6030_REG_ALS_CONF, 6, 9);
+	const struct reg_field gain = REG_FIELD(VEML6030_REG_ALS_CONF, 11, 12);
+	struct veml6030_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = &data->client->dev;
+	struct regmap_field *rm_field;
+	struct veml6030_rf *rf = &data->rf;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, it);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->it = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, gain);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->gain = rm_field;
+
+	return 0;
+}
+
+static int veml6035_regfield_init(struct iio_dev *indio_dev)
+{
+	const struct reg_field it = REG_FIELD(VEML6030_REG_ALS_CONF, 6, 9);
+	const struct reg_field gain = REG_FIELD(VEML6030_REG_ALS_CONF, 10, 12);
+	struct veml6030_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = &data->client->dev;
+	struct regmap_field *rm_field;
+	struct veml6030_rf *rf = &data->rf;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, it);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->it = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, gain);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->gain = rm_field;
+
+	return 0;
+}
+
 /*
  * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
  * persistence to 1 x integration time and the threshold
@@ -1143,6 +1226,11 @@ static int veml6030_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = data->chip->regfield_init(indio_dev);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to init regfields\n");
+
 	ret = data->chip->hw_init(indio_dev, &client->dev);
 	if (ret < 0)
 		return ret;
@@ -1195,6 +1283,7 @@ static const struct veml603x_chip veml6030_chip = {
 	.set_info = veml6030_set_info,
 	.set_als_gain = veml6030_set_als_gain,
 	.get_als_gain = veml6030_get_als_gain,
+	.regfield_init = veml6030_regfield_init,
 };
 
 static const struct veml603x_chip veml6035_chip = {
@@ -1207,6 +1296,7 @@ static const struct veml603x_chip veml6035_chip = {
 	.set_info = veml6030_set_info,
 	.set_als_gain = veml6035_set_als_gain,
 	.get_als_gain = veml6035_get_als_gain,
+	.regfield_init = veml6035_regfield_init,
 };
 
 static const struct veml603x_chip veml7700_chip = {
@@ -1219,6 +1309,7 @@ static const struct veml603x_chip veml7700_chip = {
 	.set_info = veml7700_set_info,
 	.set_als_gain = veml6030_set_als_gain,
 	.get_als_gain = veml6030_get_als_gain,
+	.regfield_init = veml6030_regfield_init,
 };
 
 static const struct of_device_id veml6030_of_match[] = {

-- 
2.43.0


