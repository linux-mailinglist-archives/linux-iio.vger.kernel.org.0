Return-Path: <linux-iio+bounces-19290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFBCAAF965
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182299C5CE8
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA1F224254;
	Thu,  8 May 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWhnnCuY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA67226188;
	Thu,  8 May 2025 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706164; cv=none; b=gacDeqjQhq5wjE+ygBrdrWhVhmRmqnxv2OdqHxtzfSo2qJsAWiaDcFZmnxM0n9yuA5fmtV8/7fHoNKm0zp/WaHV4ZDSFZ06u8eR/A91tlDs4dNMbLuW5T+gbrqd377h5o+rB4lDWp6BmObJd8c6pzcGOGeb9E7EIgc4TyGpNurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706164; c=relaxed/simple;
	bh=TBUfwO2T0U4DocGKoLltDr5ioEdc1QfcAil9yy9biYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgsIvC0pgUbnf8zZgkXvWytO70KIF1ZRA4eVuZu2cfPzg21xRc1wFse4wVBdivfNW1h+L6qi+eSH+rdWenMLSHHyj5AzeOHs5a9nPiZBTjZdfbS+rQ0+A/rlkQAqBNtOUufBVqEI8RjZJ9nY8wq96dhVmNOSDQg1p8IJj3o4wuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWhnnCuY; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-403407e998eso696784b6e.0;
        Thu, 08 May 2025 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746706162; x=1747310962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNDRBxLfsk4+M0avzl6GUpiqZjU4kRKaiyecZBpvAnU=;
        b=TWhnnCuYV7LIizdUeats/C4uhcLzH7/dx2MOOo6BQKMmwWjFa0ZUGy0jkgm8C6jJ7f
         FdejApySzYdYU1Jt+ZEgbU6vkkUDlnAxeMBnts/mrvI7npcjwwPCMyobaCOHj89uAMoH
         8rN7A5IgWp+SPkYy0B/hPx80FP9en9QAu5WDXIx/yhpMxk3EB6cW3NItUAVJ4ncXGCYp
         fwtxLeXn55+E/uGXTns0cNJA5TukysX8n8wCBUW+xHAbZNXK/0CeBva+Jtk+FbO9T+pC
         vWMli2O3lvPTKMqDfO4BTVREewcvaBtyRT1RtnHtPUOr9qxGFnWLOoAV/Bq5SQ0rmdtS
         6emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746706162; x=1747310962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNDRBxLfsk4+M0avzl6GUpiqZjU4kRKaiyecZBpvAnU=;
        b=dh9v8KD/IPZr1Q79hFvHppPZG6RrL1wzYJ/WskQehpTt+oPlvpiIk2Va7nPJbyacOn
         gEJIsgzbWg/hGW0Kwfqf8nBsYDi9rn6ZRNl5m1YzTnip/lCJIK3OnI4A38EcDUahjKOs
         wEwtq7anRr3l15JlKn0phjb6KEmjGZG8FKSxQRcK+zr4vshxRXlCVXfKUP1iUMdCw753
         BITS67bRiDLXz345wjxSjc86tuDNr/r1EyI9iTdV2Yi5Ua/W0rv+kVf+zjlI/XlgC57N
         hlGKUYkVGl/XXFHmSimSMtVws4rjk5idBRsTYiizLMvNNf8XNg73Rcpbf3aISvY2eO3I
         WbAg==
X-Forwarded-Encrypted: i=1; AJvYcCXz6sxpe3oTtOdYOSlypYuCDCmXJUaI8aHN+VKj7IcYTAbm9jSTT22WC31kb+tQEyTVJH0hHsG6SjDLYVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCxwfLo8omhkkdYZUTBeK4GJDdCetZupMiGwMn9zupQ8g87o3
	fq91LG1J7apd5H99Y2oDXJsINfclBDC/DlaDG4bzn+7LSniWACHPrNFkyHyBFc4=
X-Gm-Gg: ASbGnctOmOYt5jRLK8zkNK1IvHIuT6/FJm879/fEjI8xPRpbH86bmMF1OLoFFbET7+K
	hlJP+EsrFQv6rlTPg8AAIXb4uH0rtuwcXIBpa4Jg8G8EalGjmht8WDkrV4K2RDJInGdX7mGX4cr
	9Ktv3OXJb4YNWWl8Cdn13X7TzEZgmhG1dxB9WD3gLfE59Sp3qLM6dfKMrKK8t10XSyfr54d8a7r
	3hh6um+UuDileKit6oouz3j+JvIfOw6i/oGFXEZ6fpDcyO4qXNKkGlJ2cV3Z/kUd0K+R7oAV79N
	nJU5qDKHb4Pbv5s3ZBkHYWPCGFOpaEf7XKirjrZWLSur1hNACHv9ijFXcBpa
X-Google-Smtp-Source: AGHT+IEwScS5OtaezJYH73xWFcz5LKZZk1IBbouEVwXAzugjNTlGBsG6KKqIo1cG66Cpm5+5a+PLaw==
X-Received: by 2002:a05:6a00:f0e:b0:740:6fa3:e429 with SMTP id d2e1a72fcca58-740a99b0dc8mr4686830b3a.11.1746706150928;
        Thu, 08 May 2025 05:09:10 -0700 (PDT)
Received: from localhost.localdomain ([103.205.130.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a20bsm13503134b3a.10.2025.05.08.05.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:09:10 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v2 4/5] iio: magnetometer: qmc5883l: add extended sysfs attributes and configuration options
Date: Thu,  8 May 2025 13:08:59 +0100
Message-Id: <20250508120900.114348-2-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250508120900.114348-1-brajeshpatil11@gmail.com>
References: <20250508120900.114348-1-brajeshpatil11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
---
 drivers/iio/magnetometer/qmc5883l.c | 276 +++++++++++++++++++++++++++-
 1 file changed, 274 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
index 68597cdd0ca8..07c65f193def 100644
--- a/drivers/iio/magnetometer/qmc5883l.c
+++ b/drivers/iio/magnetometer/qmc5883l.c
@@ -54,6 +54,20 @@
 #define QMC5883L_OSR_MASK           0xC0
 #define QMC5883L_OSR_SHIFT          6

+static const char *const qmc5883l_modes[] = {
+	"standby", "continuous"
+};
+
+static const int qmc5883l_odr_avail[][2] = {
+	{10, 0}, {50, 0}, {100, 0}, {200, 0}
+};
+
+static const char *const qmc5883l_osr_avail[] = {
+	"512", "256", "128", "64"
+};
+
+static const int qmc5883l_scale_avail[] = {2, 8};
+
 static const int qmc5883l_odr_map[] = {
 	[QMC5883L_ODR_10HZ]  = 10,
 	[QMC5883L_ODR_50HZ]  = 50,
@@ -82,6 +96,12 @@ struct qmc5883l_data {

 static int qmc5883l_init(struct qmc5883l_data *data);
 static int qmc5883l_set_mode(struct qmc5883l_data *data, unsigned int mode);
+static ssize_t qmc5883l_show_odr_avail(struct device *dev,
+				       struct device_attribute *attr, char *buf);
+static ssize_t qmc5883l_show_scale_avail(struct device *dev,
+					 struct device_attribute *attr, char *buf);
+static ssize_t qmc5883l_show_status(struct device *dev,
+				    struct device_attribute *attr, char *buf);

 static int qmc5883l_buffer_preenable(struct iio_dev *indio_dev)
 {
@@ -142,6 +162,102 @@ static const struct regmap_config qmc5883l_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };

+static int qmc5883l_set_osr(struct qmc5883l_data *data, unsigned int osr)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = regmap_update_bits(data->regmap, QMC5883L_CONTROL_REG_1,
+				 QMC5883L_OSR_MASK, osr << QMC5883L_OSR_SHIFT);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int qmc5883l_get_osr(struct qmc5883l_data *data)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(data->regmap, QMC5883L_CONTROL_REG_1, &val);
+	if (ret < 0)
+		return ret;
+
+	return (val & QMC5883L_OSR_MASK) >> QMC5883L_OSR_SHIFT;
+}
+
+static int qmc5883l_get_osr_iio(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan)
+{
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+
+	return qmc5883l_get_osr(data);
+}
+
+static int qmc5883l_set_osr_iio(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				unsigned int osr)
+{
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+
+	return qmc5883l_set_osr(data, osr);
+}
+
+static s32 qmc5883l_set_rng(struct qmc5883l_data *data, u8 rng)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = regmap_update_bits(data->regmap, QMC5883L_CONTROL_REG_1,
+				 QMC5883L_RNG_MASK, rng << QMC5883L_RNG_SHIFT);
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static s32 qmc5883l_set_odr(struct qmc5883l_data *data, u8 odr)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = regmap_update_bits(data->regmap, QMC5883L_CONTROL_REG_1,
+				 QMC5883L_ODR_MASK, odr << QMC5883L_ODR_SHIFT);
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int qmc5883l_get_odr(struct qmc5883l_data *data, unsigned int *odr)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, QMC5883L_CONTROL_REG_1, &val);
+	if (ret < 0)
+		return ret;
+
+	*odr = (val & QMC5883L_ODR_MASK) >> QMC5883L_ODR_SHIFT;
+	return 0;
+}
+
+static int qmc5883l_get_delay_based_on_odr(struct qmc5883l_data *data)
+{
+	unsigned int odr;
+	int ret;
+
+	ret = qmc5883l_get_odr(data, &odr);
+	if (ret < 0)
+		return ret;
+
+	switch (odr) {
+	case QMC5883L_ODR_10HZ: return 100000;
+	case QMC5883L_ODR_50HZ: return 20000;
+	case QMC5883L_ODR_100HZ: return 10000;
+	case QMC5883L_ODR_200HZ: return 5000;
+	default:
+		dev_err(&data->client->dev, "Invalid ODR value: %u\n", odr);
+		return -EINVAL;
+	}
+}
+
 static int qmc5883l_set_mode(struct qmc5883l_data *data, unsigned int mode)
 {
 	int ret;
@@ -154,11 +270,44 @@ static int qmc5883l_set_mode(struct qmc5883l_data *data, unsigned int mode)
 	return ret;
 }

+static int qmc5883l_get_mode(struct qmc5883l_data *data)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(data->regmap, QMC5883L_CONTROL_REG_1, &val);
+	if (ret < 0)
+		return ret;
+
+	return (val & QMC5883L_MODE_MASK) >> QMC5883L_MODE_SHIFT;
+}
+
+static int qmc5883l_get_mode_iio(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan)
+{
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+
+	return qmc5883l_get_mode(data);
+}
+
+static int qmc5883l_set_mode_iio(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 unsigned int mode)
+{
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+
+	return qmc5883l_set_mode(data, mode);
+}
+
 static int qmc5883l_wait_measurement(struct qmc5883l_data *data)
 {
 	int tries = 150;
 	unsigned int val;
-	int ret;
+	int ret, delay;
+
+	delay = qmc5883l_get_delay_based_on_odr(data);
+	if (delay < 0)
+		return delay;

 	while (tries-- > 0) {
 		ret = regmap_read(data->regmap, QMC5883L_STATUS_REG, &val);
@@ -172,7 +321,7 @@ static int qmc5883l_wait_measurement(struct qmc5883l_data *data)

 		if (val & QMC5883L_DRDY)
 			return 0;
-		usleep_range(5000, 6000);
+		usleep_range(delay, delay + 1000);
 	}

 	dev_err(&data->client->dev, "data not ready\n");
@@ -208,6 +357,65 @@ static int qmc5883l_read_measurement(struct qmc5883l_data *data,
 	return IIO_VAL_INT;
 }

+static const struct iio_enum qmc5883l_mode_enum = {
+	.items = qmc5883l_modes,
+	.num_items = ARRAY_SIZE(qmc5883l_modes),
+	.get = qmc5883l_get_mode_iio,
+	.set = qmc5883l_set_mode_iio,
+};
+
+static const struct iio_enum qmc5883l_osr_enum = {
+	.items = qmc5883l_osr_avail,
+	.num_items = ARRAY_SIZE(qmc5883l_osr_avail),
+	.get = qmc5883l_get_osr_iio,
+	.set = qmc5883l_set_osr_iio,
+};
+
+static const struct iio_chan_spec_ext_info qmc5883l_ext_info[] = {
+	IIO_ENUM("mode", IIO_SHARED_BY_TYPE, &qmc5883l_mode_enum),
+	IIO_ENUM_AVAILABLE("mode", IIO_SHARED_BY_TYPE, &qmc5883l_mode_enum),
+	IIO_ENUM("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
+	IIO_ENUM_AVAILABLE("oversampling_ratio", IIO_SHARED_BY_TYPE, &qmc5883l_osr_enum),
+	{ }
+};
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(qmc5883l_show_odr_avail);
+static IIO_DEVICE_ATTR(scale_available, 0444, qmc5883l_show_scale_avail, NULL, 0);
+static IIO_DEVICE_ATTR(data_ready, 0444, qmc5883l_show_status, NULL, 0);
+static IIO_DEVICE_ATTR(overflow, 0444, qmc5883l_show_status, NULL, 0);
+
+static ssize_t qmc5883l_show_odr_avail(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "10 50 100 200\n");
+}
+
+static ssize_t qmc5883l_show_scale_avail(struct device *dev,
+					 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "2 8\n");
+}
+
+static ssize_t qmc5883l_show_status(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(data->regmap, QMC5883L_STATUS_REG, &val);
+	if (ret < 0)
+		return ret;
+
+	if (attr == (struct device_attribute *)&iio_dev_attr_data_ready.dev_attr.attr)
+		return sprintf(buf, "%d\n", !!(val & QMC5883L_DRDY));
+	else if (attr == (struct device_attribute *)&iio_dev_attr_overflow.dev_attr.attr)
+		return sprintf(buf, "%d\n", !!(val & QMC5883L_OVL));
+
+	return -EINVAL;
+}
+
 static int qmc5883l_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -275,6 +483,54 @@ static int qmc5883l_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }

+static int qmc5883l_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+	int odr, range;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val == 10 && val2 == 0)
+			odr = QMC5883L_ODR_10HZ;
+		else if (val == 50 && val2 == 0)
+			odr = QMC5883L_ODR_50HZ;
+		else if (val == 100 && val2 == 0)
+			odr = QMC5883L_ODR_100HZ;
+		else if (val == 200 && val2 == 0)
+			odr = QMC5883L_ODR_200HZ;
+		else
+			return -EINVAL;
+
+		return qmc5883l_set_odr(data, odr);
+	case IIO_CHAN_INFO_SCALE:
+		if (val == 2 && val2 == 0)
+			range = QMC5883L_RNG_2G;
+		else if (val == 8 && val2 == 0)
+			range = QMC5883L_RNG_8G;
+		else
+			return -EINVAL;
+
+		return qmc5883l_set_rng(data, range << QMC5883L_RNG_SHIFT);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int qmc5883l_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
 static irqreturn_t qmc5883l_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -321,6 +577,7 @@ static irqreturn_t qmc5883l_trigger_handler(int irq, void *p)
 		.storagebits = 16,          \
 		.endianness = IIO_LE,           \
 	},                      \
+	.ext_info = qmc5883l_ext_info,      \
 }

 static const struct iio_chan_spec qmc5883l_channels[] = {
@@ -337,6 +594,18 @@ static const struct iio_chan_spec qmc5883l_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };

+static struct attribute *qmc5883l_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_scale_available.dev_attr.attr,
+	&iio_dev_attr_data_ready.dev_attr.attr,
+	&iio_dev_attr_overflow.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group qmc5883l_attribute_group = {
+	.attrs = qmc5883l_attributes,
+};
+
 static int qmc5883l_init(struct qmc5883l_data *data)
 {
 	int ret;
@@ -382,7 +651,10 @@ static int qmc5883l_init(struct qmc5883l_data *data)
 }

 static const struct iio_info qmc5883l_info = {
+	.attrs = &qmc5883l_attribute_group,
 	.read_raw = &qmc5883l_read_raw,
+	.write_raw = &qmc5883l_write_raw,
+	.write_raw_get_fmt = &qmc5883l_write_raw_get_fmt,
 };

 static const unsigned long qmc5883l_scan_masks[] = {0x7, 0};
--
2.39.5


