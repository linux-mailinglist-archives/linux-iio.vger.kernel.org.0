Return-Path: <linux-iio+bounces-19257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F2AAEC35
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2388C98418C
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739328DF58;
	Wed,  7 May 2025 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoSM3Him"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77B28983F
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646359; cv=none; b=KChI0g4foRYJ9qZz0QQP3pPM6xI+exC+Z1s7Qme5FwXJK0sMEEnWlDUT6GK6BwdniYH304OHizyFj4lUNtOYY92G1Rc8+y22yo39VNq61IzoULtuFS3TKAfdkqJfIib+zOgBN+mZp1FYwym+lFbz/uQEmohWJDZ5KJNDARi/j+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646359; c=relaxed/simple;
	bh=lie8MvR2wRdBg+uuO+/ezbhXi4JlWdcsCAIFgDVH1+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMmDvSm2xbdQcftJ7LCJOmRWsIPgrUo26ocuVtfnUjXkxIkvUcx4cOlvtxiAS7npfQYpk/bWYsZ09qrXub1oso34n2Z+8u0xJFGayqG1V04JpT6fmyxmukHZ/0bGDqod7MokR95EzKb/vnEwWJec8MuyvbC5frZHcym3avg8GBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoSM3Him; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e3b069f23so2768185ad.2
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746646357; x=1747251157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfe78zTD0fNGcvxk2IjmCdu42FaEJGXOaBJ2FOCXuN0=;
        b=UoSM3Him1IyCkTH0g+BPbKFD28QCG8LiXCrXmBHSq/IuI0DmZ0xydpI6yL70Jdtkks
         4RjIibq1St1YdaGgS6TjKTywLsvEA9lcebM5yoxqYsX5sv0wm2iqGk0wfKPJyFZy2z3e
         v+0bWyAhK0jmGc3SZYdre1ixm38jSB9m68GE0m2zwbuK66NsLu92OfDCOcQ9bBWcwmCk
         aE1XwkaVqM3TNwQ/mevsMhLScC0TN7Gmi7uQSz0XwYhKXFm9W75zV1CZ49EShsW7LpH1
         A8nZ7ZAfgS3M/ycPaFvKgxmKpEYf5X5ccM4fNF+yz5GRBXlLQrnNPX6crNFIcAZkC+gP
         v51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746646357; x=1747251157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfe78zTD0fNGcvxk2IjmCdu42FaEJGXOaBJ2FOCXuN0=;
        b=GBvJO0e3gyTAkRKANFQXsZ1RTJeiJh98wRNMOPBynVpRX0h5BvhGPCo/TY7XWoQMRa
         cCqhvP+kxnVmKkSsaIHXGFFwa1A8oBOwpd+ZZGV2SZMW8szwRCA6RtYOsCmKPijrGtKK
         Zgm4ZVWBlBcuM0a2sXeoi6PJwj/uykzNJbmSeqrvepRDFkqoH0kmFma/HLCZAAO59ImF
         6W+btp/jUJBdGKuIy9Gf+8tMYtTM73zLTzwGmLbWB5wPnR7Rc6AiTwkMe2ivAAOI6nVt
         M9Q7/xNgkLfsXH3uRe8mKqgWVg6eCfp8yyfXiRioLQQC04sCTUpoLs36+o+cRvg0kbac
         DK7Q==
X-Gm-Message-State: AOJu0YziKcotU3lcNy7ewEcNkdN2uIcFBnrU3sxVBSBh+t2HegU0Y5QY
	IWBV++k2U44F5+VBw858IDSptIVscrDevnp0M6jfVIdUYBtJat1WMB8N59nfjyU=
X-Gm-Gg: ASbGncujgH277rGkydeSja+Qo6N8bGRoThtXW4mFph55UhTdEJFt5BYFKs7gbHQvRK4
	E2uAxaCmIHLX0ACJVmCxUCe6XpkvN/pXYHGZOOHgcQc7D2wXBGReLyMU6V7SDzMrdXSlMacWBJA
	E73lLUYQjCM3oMNQMmPELDLEX40GmntBwNLptB++iroj/8Suh9NUyXdhz6S88SgPsQXs4op2LI4
	5lcaTV+x+hPXQT8AZRZvOiG9mJruUxnLp6Yq0MakT3u2BuKzjTp7eM4ydN2bx58OC/C2GIU4hiD
	EXDfWd7Oj/PRN92TpU05CMTnwZph88DWpuGSdm14OKYX8z0P5WME6H3vf8EP
X-Google-Smtp-Source: AGHT+IHsU6KsrvkbZWYooI83xBQFSzczL/nFJTpk36mWfOv+20wX0F9WbgVbKYyIGLldqTJgCMN/QA==
X-Received: by 2002:a17:902:daca:b0:223:5379:5e4e with SMTP id d9443c01a7336-22e5ea70aedmr84574675ad.10.1746646356595;
        Wed, 07 May 2025 12:32:36 -0700 (PDT)
Received: from localhost.localdomain ([103.205.130.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f62sm97769815ad.168.2025.05.07.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 12:32:36 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v1 2/3] iio: magnetometer: qmc5883l: add extended sysfs attributes and configuration options
Date: Wed,  7 May 2025 20:32:18 +0100
Message-Id: <20250507193219.52965-3-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507193219.52965-1-brajeshpatil11@gmail.com>
References: <20250507193219.52965-1-brajeshpatil11@gmail.com>
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
 1 file changed, 273 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
index 9462794a51ef..53a225fab798 100644
--- a/drivers/iio/magnetometer/qmc5883l.c
+++ b/drivers/iio/magnetometer/qmc5883l.c
@@ -53,6 +53,19 @@
 #define QMC5883L_OSR_64             0x03
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
 
 static const int qmc5883l_odr_map[] = {
 	[QMC5883L_ODR_10HZ]  = 10,
@@ -82,6 +95,12 @@ struct qmc5883l_data {
 
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
@@ -142,6 +161,102 @@ static const struct regmap_config qmc5883l_regmap_config = {
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
@@ -154,11 +269,44 @@ static int qmc5883l_set_mode(struct qmc5883l_data *data, unsigned int mode)
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
@@ -172,7 +320,7 @@ static int qmc5883l_wait_measurement(struct qmc5883l_data *data)
 
 		if (val & QMC5883L_DRDY)
 			return 0;
-		usleep_range(5000, 6000);
+		usleep_range(delay, delay + 1000);
 	}
 
 	dev_err(&data->client->dev, "data not ready\n");
@@ -208,6 +356,65 @@ static int qmc5883l_read_measurement(struct qmc5883l_data *data,
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
@@ -275,6 +482,54 @@ static int qmc5883l_read_raw(struct iio_dev *indio_dev,
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
@@ -321,6 +576,7 @@ static irqreturn_t qmc5883l_trigger_handler(int irq, void *p)
 		.storagebits = 16,          \
 		.endianness = IIO_LE,           \
 	},                      \
+	.ext_info = qmc5883l_ext_info,      \
 }
 
 static const struct iio_chan_spec qmc5883l_channels[] = {
@@ -337,6 +593,18 @@ static const struct iio_chan_spec qmc5883l_channels[] = {
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
@@ -382,7 +650,10 @@ static int qmc5883l_init(struct qmc5883l_data *data)
 }
 
 static const struct iio_info qmc5883l_info = {
+	.attrs = &qmc5883l_attribute_group,
 	.read_raw = &qmc5883l_read_raw,
+	.write_raw = &qmc5883l_write_raw,
+	.write_raw_get_fmt = &qmc5883l_write_raw_get_fmt,
 };
 
 static const unsigned long qmc5883l_scan_masks[] = {0x7, 0};
@@ -468,4 +739,3 @@ module_i2c_driver(qmc5883l_driver);
 MODULE_AUTHOR("Brajesh Patil <brajeshpatil11@gmail.com>");
 MODULE_DESCRIPTION("QMC5883L Driver");
 MODULE_LICENSE("GPL");
-
-- 
2.39.5


