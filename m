Return-Path: <linux-iio+bounces-12362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C419F9D0527
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DE6B22818
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B51DE3C8;
	Sun, 17 Nov 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BImxTpUc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADED1DB546;
	Sun, 17 Nov 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868118; cv=none; b=XUUShoMHe5yS/v/yTCB+gQ2xqXFSOcSXUIcg2WUVGIXzt1nEu5P+12vNPKtl2SS9NRGJdTaNrD6+FV1Hp+UoP/Ofxl2n8UJjS8NMVC0X1wWFM/jv/L72fSHR7AmLT2XaGqSWcXpVojMpvPI3JWR1yj2Nia7JxZ29P5Ott8JwjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868118; c=relaxed/simple;
	bh=FJa+BezbGPvPK7+Lh6efUwtb5l4qmZJ2kHSzKX3W0Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LFBMax2hmo5/Qgi6BsqC0epoCzD5Uzze4DHrXIQ7tTRlGK6ohG8NyCvR7uyuU7pU0g3VyRzhx8AhmrAcLNgWm8QuTsgcTSPfkmjdATd07gIjQ1K4ZsT6k9TLVHHAsXC+Q6mV3Tf1isotvzP8VGT2QIxfME8hjZ5KlBWqRZ+HUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BImxTpUc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315b0bd4ddso3683955e9.3;
        Sun, 17 Nov 2024 10:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868115; x=1732472915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuFWDVSr0TH1qAG16py992MdgJFvQfRVNyd51fPsQGM=;
        b=BImxTpUcBiQ36g6zfB7GwGrYLaYlK6Pu7h4Zfqa78TX7yUanmx1GM7ZWF9u9Z1AKwH
         WZ2HbH/4kO6iz6M4mmszm7Q9x+G3O2mxBiGfH/kvcje9hyt2cz2+QtKc7xr82rc74Si4
         lbdlo7pId6nykk4EjsFuSbgTq2mDbeBvUWsIk3bjLowqW2HLRztHTtw3IjGLXzAhmLSZ
         Ne2DpNzskEs5yUKTVoHW5zAin2Xfu0OWSWorcJxggm+O0U4vHLtUfrUA2vCkO4Dc5NjN
         BGFbVtEvRDYctnpL1SQZnSsYyU+yRlCDpP3j1DcFUPRm/DcBNFOdrmyYeFW+xd4uqv8F
         n/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868115; x=1732472915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuFWDVSr0TH1qAG16py992MdgJFvQfRVNyd51fPsQGM=;
        b=uELDLnlQsoS/lq6p72MTMrb+RMjPxDi+DoBEsybNyqVcD2Vij3qeBhh7GbYdXjDG7d
         3yqmg9uEoaJ1BSVL5PiUXMsRNOaOhRjsAotVt0q7jjeIR0kkI9+Vpg65jjN+yLgqPcX/
         NbGhYXBP9Ym+vObwaEao23icomSiDBF51FFbJQErZMfd9pxlPX2Xi4aSfySO9n8lQkar
         JaFYe04fCY0fW7ZRqHVc9cjy7/zxgyk9G1auPtxyA8qd21yLStZAU7DRcO8wGhGSY0rz
         xsec8L1ajy5KysztIybEfgGN0qt46vft8lk+IsV0a/o1YQVA+r8Hogf/YgKlgAgBSMgx
         zvDg==
X-Forwarded-Encrypted: i=1; AJvYcCUqmN6DKjNhwAZ2eZjClFl7I9KPkE5H4VPlGT0xduXa0Nr+P2VhJ8PVoBjfaLnYLY+mu9Bimrpqjq8bFHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRPG3sYQc8jGvl6MDqOABhyO4IvPDvJMr5wO+Fqqj8hOH+YuDo
	KDAyLEO/1pmzPiI99o69wZzvPl6x/E3m3wNGcOawGeySIfxk1a7Q
X-Google-Smtp-Source: AGHT+IGmV5mhFROTH/8fZc+TO/kHurvSvIfZfrAaAwWv7OXGY+E7ZcdQp6DrCP6KKhIHJDlVef6Glw==
X-Received: by 2002:a05:600c:45d4:b0:431:5632:4480 with SMTP id 5b1f17b1804b1-432df793c51mr35023695e9.6.1731868115057;
        Sun, 17 Nov 2024 10:28:35 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:34 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 19/22] iio: accel: adxl345: prepare FIFO watermark handling
Date: Sun, 17 Nov 2024 18:26:48 +0000
Message-Id: <20241117182651.115056-20-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the feature of the adxl345 and related sensors to manage a FIFO in
stream mode by a watermark level. Provide means to set the watermark
through the IIO api and sysfs interface.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 94 ++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b57a123ac9..f7b937fb16 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -288,6 +288,26 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
+{
+	struct adxl34x_state *st = iio_priv(indio_dev);
+	struct adxl34x_platform_data *data = &st->data;
+	unsigned int fifo_mask = 0x1F;
+	int ret;
+
+	if (value > ADXL34x_FIFO_SIZE)
+		value = ADXL34x_FIFO_SIZE;
+	pr_debug("%s(): set watermark to 0x%02x\n", __func__, value);
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_FIFO_CTL,
+				 fifo_mask, value);
+	if (ret)
+		return ret;
+
+	data->watermark = value;
+	return 0;
+}
+
 static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *chan,
 				     long mask)
@@ -335,7 +355,76 @@ static void adxl345_powerdown(void *ptr)
 	adxl345_set_measure_en(st, false);
 }
 
+/* fifo */
+
+static ssize_t adxl345_get_fifo_enabled(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl34x_state *st = iio_priv(indio_dev);
+	struct adxl34x_platform_data *data = &st->data;
+
+	return sysfs_emit(buf, "%d\n", data->fifo_mode);
+}
+
+static ssize_t adxl345_get_fifo_watermark(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl34x_state *st = iio_priv(indio_dev);
+	struct adxl34x_platform_data *data = &st->data;
+
+	return sprintf(buf, "%d\n", data->watermark);
+}
+
+static ssize_t watermark_en_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl34x_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", st->watermark_en);
+}
+
+static ssize_t watermark_en_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl34x_state *st = iio_priv(indio_dev);
+	bool val;
+
+	if (kstrtobool(buf, &val))
+		return -EINVAL;
+	st->watermark_en = val;
+	return len;
+}
+
+/*
+ * NB: The buffer/hwfifo_watermark is a read-only entry to display the
+ * currently set hardware FIFO watermark. First set a value to buffer0/length.
+ * This allows to configure buffer0/watermark. After enabling buffer0/enable
+ * the hwfifo_watermark shall show the configured FIFO watermark value.
+ *
+ * ref: Documentation/ABI/testing/sysfs-bus-iio
+ */
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
+IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
+			     __stringify(ADXL34x_FIFO_SIZE));
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       adxl345_get_fifo_watermark, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       adxl345_get_fifo_enabled, NULL, 0);
+
+static IIO_DEVICE_ATTR_RW(watermark_en, 0);
+
 static const struct iio_dev_attr *adxl345_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_watermark_min,
+	&iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,
+	&iio_dev_attr_hwfifo_enabled,
 	NULL,
 };
 
@@ -345,6 +434,7 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 
 static struct attribute *adxl345_attrs[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_watermark_en.dev_attr.attr,
 	NULL
 };
 
@@ -664,6 +754,7 @@ static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
+	.hwfifo_set_watermark = adxl345_set_watermark,
 };
 
 /**
@@ -721,6 +812,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	/* some reasonable pre-initialization */
 	st->data.act_axis_control = 0xFF;
 
+	/* default is all features turned off */
+	st->watermark_en = 0;
+
 	st->intio = ADXL345_INT1;
 
 	indio_dev->name = st->info->name;
-- 
2.39.5


