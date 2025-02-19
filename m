Return-Path: <linux-iio+bounces-15819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634AAA3CDF4
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 00:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872BD7A8B0A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9695C264624;
	Wed, 19 Feb 2025 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cG+DWFnV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD28262167;
	Wed, 19 Feb 2025 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009311; cv=none; b=dC/FS6EqpHcQsC+Vipd9yiyohPPktR1XcYZeviEaviqOSeO+h7rO4wE2s5hJDaSOBRWZydH5FqUNwenZgED9WdtDep+PbEHgGRkxxUwNlrvq7BYQX4wbbVtkhvhQB0Sz/eGC8sbzfnDEiNQGgUqIfrx74OEjyDNeiTuyk3TJ1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009311; c=relaxed/simple;
	bh=hTcLwEP4S3gf0tzFa5ZUUbIwCu2vhQVudtV3dnw8GmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1EWCdmu9D08Y8DL4GMZTkKnRo4rC7e3itnVNkC5vCFy+4gky/hCeRBmgqy+wzJs0auw00iEfmEJqSUZE8Gl8YVnQ19WxnWoKUQ+UOKn7a212sWyTLV9Wzxl/kiCLL4A6auWX4ChJ8mq5ZK+Avc1mJQfL+glDX1HFpWdHEG9XFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cG+DWFnV; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7273b01fe35so217617a34.2;
        Wed, 19 Feb 2025 15:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740009309; x=1740614109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRYyO1CXUDeKcrX+ZVAYykEmcwzklTx3AVuD/mZ5rgg=;
        b=cG+DWFnVto2SRSjsMkr2HcuaAgwnO2pCYNNQscPP/9BzKPPS7S0JhYmW1l1m6JznDm
         +GWYeBCfL/5CNhb7/Jm1VTv98uT7UoZKQ7iLERqwsuELtbyjbRYYELfA42MB5ZRNxJiL
         7JAsEDlnhyNvwaTiC/ND73Zii2WVvW6tGrzSk74G2njPXMljjpFGu6L5k1aKgrTMuFVJ
         2P8Dq5WKjbGfyP25lCBDvghMJttc0HGnRjaTZRDAYtCBMqx3hz2qxPhKsHnSXJDcjsK2
         jWTt3farPgnwhfoiKWqyDwfQOFPjVuroMWjSS/K+bOabEQQEt3MosyI1j/kM/X7CTk9g
         wTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740009309; x=1740614109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRYyO1CXUDeKcrX+ZVAYykEmcwzklTx3AVuD/mZ5rgg=;
        b=T1ExTCIVhJuJzaeS1p82pWSN5HBXytmCwGQ2d/VpHbHcDeLTgcl2Pq+YjU99VAShl4
         YHRExF4yn1IEs7XfvF7Otbd7GB+xKRoFIA1v7FwUsKJ2nRN+6D/zbunduE5la3i4lI79
         HxMuJtlC2Pp1cgttflnQYBFpBsqd6hXzYwUxLrPRGk14tnvTA5w3PRlarlvbd8oU5dWQ
         U7ENdYWHhokpWUmrtaOYyI4Buf5oCSGCbdGx12eOwShEaqd1DKpqKH22gt+UE4hHEE/O
         GWg2UB4RdoI+gl5ysHVYemz3SpwiTcn56ORlSuz2WcYS0LQ3l51Z/WqSbUxAoTrAD6nr
         HVUg==
X-Forwarded-Encrypted: i=1; AJvYcCViaSlu01BHh95K4vCBetgTdCX2OaGcytjqZjH31WtyTZTVZ9UHugzNCvyBDYXZctYw3pZueoCiHWRcvQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzTUgLmDUSGaxKf1+GawNDwZdZ7DlDOzYjL2vIBXKupbfoTx6
	WqjcVl04e0+ofl9iL7s9RNCbeMfVShnAQYI3AhJuoS0jDt7TC3Yx
X-Gm-Gg: ASbGncsO0eI2yHQaS/ci8CjEg9a7hPVzuonMtoOk8jI1hTVUlc3lNiK/Dq2iEk7+Uid
	EjHTA8rxZeMuEuZjadJEoR+Lg4NT58AXUHZFqHlfvVPl5Jb+xQzsbqKbeX4aVijeRdaTtO9voHn
	efWkcUwhvaM47Tx6slTruXjjqgyU0eT0+aSo6qyb5JtAjvtl4qdCpiHCSxMNE0oexPfLw+7Dr26
	tR+qxuldTQ2jtGjmPZKN2KF7pd5BvJ7CNqPrqmOcxGWlbU+3so8UiZ5a50yBK1Mgt3r+wuP/M6+
	mtbh7V5q
X-Google-Smtp-Source: AGHT+IGh0iRbe48Sh2mxGvCQj8Ei78KxaT2Yv9RZBiIhVcOuQXvC9zvd9zk4gSDj75YMWsVQdceUsg==
X-Received: by 2002:a05:6830:6516:b0:726:ef94:11cb with SMTP id 46e09a7af769-727120a845amr12995808a34.17.1740009308641;
        Wed, 19 Feb 2025 15:55:08 -0800 (PST)
Received: from [192.168.0.107] ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7273a14070esm658173a34.49.2025.02.19.15.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:55:08 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Wed, 19 Feb 2025 20:54:46 -0300
Subject: [PATCH 2/3] iio: imu: bmi270: rename variable bmi270_device to
 data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-bmi270-irq-v1-2-145d02bbca3b@gmail.com>
References: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
In-Reply-To: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740009298; l=8170;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=hTcLwEP4S3gf0tzFa5ZUUbIwCu2vhQVudtV3dnw8GmQ=;
 b=m8ShZiJX1ieBHqj76qAvtKbX5PUP32GVsnTCPpVcKwtsVXsIfVjtB0iIJzrcOYAjzmH4aLsNk
 SIe7vQ1s+s3DYPrHacAiDPf8QG/2DIubzklZJ1wML7O8orV1IITftGH
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

Rename all instances of 'struct bmi270_data' to 'data', to ensure
consistency across the driver.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 79 ++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 9f24d4044ed6f00f67fd3a8f5adda821c3140a18..56ebd887fcec94b684dc23f1b4503b719fb39239 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -90,7 +90,7 @@ struct bmi270_data {
 	struct {
 		__le16 channels[6];
 		aligned_s64 timestamp;
-	} data __aligned(IIO_DMA_MINALIGN);
+	} buffer __aligned(IIO_DMA_MINALIGN);
 };
 
 enum bmi270_scan {
@@ -284,7 +284,7 @@ static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 	return -EINVAL;
 }
 
-static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
+static int bmi270_get_scale(struct bmi270_data *data, int chan_type,
 			    int *scale, int *uscale)
 {
 	int ret;
@@ -293,7 +293,7 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
 
 	switch (chan_type) {
 	case IIO_ACCEL:
-		ret = regmap_read(bmi270_device->regmap,
+		ret = regmap_read(data->regmap,
 				  BMI270_ACC_CONF_RANGE_REG, &val);
 		if (ret)
 			return ret;
@@ -302,7 +302,7 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
 		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
 		break;
 	case IIO_ANGL_VEL:
-		ret = regmap_read(bmi270_device->regmap,
+		ret = regmap_read(data->regmap,
 				  BMI270_GYR_CONF_RANGE_REG, &val);
 		if (ret)
 			return ret;
@@ -403,24 +403,24 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
+	struct bmi270_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = regmap_bulk_read(bmi270_device->regmap, BMI270_ACCEL_X_REG,
-			       &bmi270_device->data.channels,
-			       sizeof(bmi270_device->data.channels));
+	ret = regmap_bulk_read(data->regmap, BMI270_ACCEL_X_REG,
+			       &data->buffer.channels,
+			       sizeof(data->buffer.channels));
 
 	if (ret)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &bmi270_device->data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
 }
 
-static int bmi270_get_data(struct bmi270_data *bmi270_device,
+static int bmi270_get_data(struct bmi270_data *data,
 			   int chan_type, int axis, int *val)
 {
 	__le16 sample;
@@ -441,7 +441,7 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
 		return -EINVAL;
 	}
 
-	ret = regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
+	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(sample));
 	if (ret)
 		return ret;
 
@@ -455,17 +455,17 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	int ret;
-	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
+	struct bmi270_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = bmi270_get_data(bmi270_device, chan->type, chan->channel2, val);
+		ret = bmi270_get_data(data, chan->type, chan->channel2, val);
 		if (ret)
 			return ret;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = bmi270_get_scale(bmi270_device, chan->type, val, val2);
+		ret = bmi270_get_scale(data, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
@@ -476,7 +476,7 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = bmi270_get_odr(bmi270_device, chan->type, val, val2);
+		ret = bmi270_get_odr(data, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
@@ -599,12 +599,12 @@ static const struct iio_chan_spec bmi270_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 
-static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
+static int bmi270_validate_chip_id(struct bmi270_data *data)
 {
 	int chip_id;
 	int ret;
-	struct device *dev = bmi270_device->dev;
-	struct regmap *regmap = bmi270_device->regmap;
+	struct device *dev = data->dev;
+	struct regmap *regmap = data->regmap;
 
 	ret = regmap_read(regmap, BMI270_CHIP_ID_REG, &chip_id);
 	if (ret)
@@ -618,24 +618,24 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
 	if (chip_id == BMI160_CHIP_ID_VAL)
 		return -ENODEV;
 
-	if (chip_id != bmi270_device->chip_info->chip_id)
+	if (chip_id != data->chip_info->chip_id)
 		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
 
 	if (chip_id == bmi260_chip_info.chip_id)
-		bmi270_device->chip_info = &bmi260_chip_info;
+		data->chip_info = &bmi260_chip_info;
 	else if (chip_id == bmi270_chip_info.chip_id)
-		bmi270_device->chip_info = &bmi270_chip_info;
+		data->chip_info = &bmi270_chip_info;
 
 	return 0;
 }
 
-static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
+static int bmi270_write_calibration_data(struct bmi270_data *data)
 {
 	int ret;
 	int status = 0;
 	const struct firmware *init_data;
-	struct device *dev = bmi270_device->dev;
-	struct regmap *regmap = bmi270_device->regmap;
+	struct device *dev = data->dev;
+	struct regmap *regmap = data->regmap;
 
 	ret = regmap_clear_bits(regmap, BMI270_PWR_CONF_REG,
 				BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
@@ -656,8 +656,7 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
 		return dev_err_probe(dev, ret,
 				     "Failed to prepare device to load init data");
 
-	ret = request_firmware(&init_data,
-			       bmi270_device->chip_info->fw_name, dev);
+	ret = request_firmware(&init_data, data->chip_info->fw_name, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to load init data file");
 
@@ -689,11 +688,11 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
 	return 0;
 }
 
-static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
+static int bmi270_configure_imu(struct bmi270_data *data)
 {
 	int ret;
-	struct device *dev = bmi270_device->dev;
-	struct regmap *regmap = bmi270_device->regmap;
+	struct device *dev = data->dev;
+	struct regmap *regmap = data->regmap;
 
 	ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
 			      BMI270_PWR_CTRL_AUX_EN_MSK |
@@ -730,38 +729,38 @@ static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
 	return 0;
 }
 
-static int bmi270_chip_init(struct bmi270_data *bmi270_device)
+static int bmi270_chip_init(struct bmi270_data *data)
 {
 	int ret;
 
-	ret = bmi270_validate_chip_id(bmi270_device);
+	ret = bmi270_validate_chip_id(data);
 	if (ret)
 		return ret;
 
-	ret = bmi270_write_calibration_data(bmi270_device);
+	ret = bmi270_write_calibration_data(data);
 	if (ret)
 		return ret;
 
-	return bmi270_configure_imu(bmi270_device);
+	return bmi270_configure_imu(data);
 }
 
 int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 		      const struct bmi270_chip_info *chip_info)
 {
 	int ret;
-	struct bmi270_data *bmi270_device;
+	struct bmi270_data *data;
 	struct iio_dev *indio_dev;
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*bmi270_device));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
-	bmi270_device = iio_priv(indio_dev);
-	bmi270_device->dev = dev;
-	bmi270_device->regmap = regmap;
-	bmi270_device->chip_info = chip_info;
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+	data->regmap = regmap;
+	data->chip_info = chip_info;
 
-	ret = bmi270_chip_init(bmi270_device);
+	ret = bmi270_chip_init(data);
 	if (ret)
 		return ret;
 

-- 
2.48.1


