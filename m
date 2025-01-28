Return-Path: <linux-iio+bounces-14673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE69EA20A28
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43F93A4F69
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC38E1A23BF;
	Tue, 28 Jan 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaCKqIFO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA981B0406;
	Tue, 28 Jan 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065708; cv=none; b=V0FWLLupUPPYHSDUNfL4RI9ZKyxcvAqVCPRGpjAPD7xLYTSJ2Hw2SLsETniEAXxDbec+2vcBVO5/DDk2YtMknGhTcXSorsp3pGTRR0UMWPBH6HBXhSNuaC+61f7QyRLHrcAGnYcJgWSAVH3W8r2+OrnAXbSd7MKMuMpVYPUvfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065708; c=relaxed/simple;
	bh=eJcQe/ALyxl5u6qJWeYq3Zd/bq2kll+r5Ce/fqpotuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fInccv9t8wL38u/6AHmLCtnWNUBTPzrk1Es9V1TwFWFRFsywho/reim+XgGcpafeC4pTMpcSsUDKnc49+MNdWHyx4Dyfufg7FnydnruoFYBTPCUnUBswUxeHkKEEl4s1S2ImcEQwcpbjad2tuTk7xzKQ3h+Ol5F0sL8AXEBYQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaCKqIFO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa659775dd5so72135266b.0;
        Tue, 28 Jan 2025 04:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065704; x=1738670504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP32LcbMnrfeHU7TZ84P0nlILDpCVTWkGpH3nk2hrVk=;
        b=GaCKqIFOJkek//Jvq4YSaJsnbIBK+QE+21PgO6qaI/hg3jmUxcIUAFwakqNb9eLFNt
         SOojuyPMpfQO9bwVkCJTRLy7oN6IWEeMi6lKuvMyIPtcMlzOZA952Hmc+lnhmW5IvRqx
         VuUgCJGRaaDEBuQrPljzbfO431aEK4TY6EtQKz5hyCCygvGCNnLSvtHV+PySOpoR6/Xq
         uXx8thtD66R56rse1nXZPwQsDOt+ahDGJGg9un1u4JESpwaiBwXkFbNM3u9nleyuz1rI
         1Hd4TVF1t/KzGFnTSpSJ+x0erpUdStWWqWU6JQHG3H+byNJemcZnsnSXmzLuu7MgcR3Q
         UbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065704; x=1738670504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP32LcbMnrfeHU7TZ84P0nlILDpCVTWkGpH3nk2hrVk=;
        b=bdVgwi3kCQ6BOSRHWdUBEV3lYlN2sqRQ7LEhzfQdE+Msc33cORBBKk5vCRb0JcXyFE
         JciQ8UcRY44jOKvKkzkeyXJzkPcUmgY66iJUDyeNBnChiSufw04gLT1gRbMUSNX5NSLS
         bivIhSL+ikX5OXSKLn5GBRsh+qi8AGUYb6bj/PA/EpJqKt4pdLIQUqPjqHv1TnP/4UP7
         3JfJmq9XkxMt2EUcD000HgKoWP5lK5W6vQxNZq037v4Pl5r+aYPmIfrzbxM2Gx4I2E+U
         QAK9D5Li7KgqhhH4HHFFepUyUU++TcnN5RbzEIjmoav2tCSEUMu5DReJcMVfOgigG9wf
         zIOA==
X-Forwarded-Encrypted: i=1; AJvYcCWHpkKOU3CwikqF4By3IrsF9XopXf6cKo2aW7ADybT6BfnJU7/o5xwsBuONXZ4wTsNCXrk1tIObZ/w0fMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQM9aUgCj8xZPFuZjgctq1vB9h1CNveMEveKtT4j+jsSovgsC
	7D0h7LUXAnqwg+GI8Em3o+krc4Yn7bUbAXYhLy5EbXVJBvexKd4g
X-Gm-Gg: ASbGnctENAfBtaohaV+IqmhZVxY3v7XKPw9P4BpPUTGrx14XxJ/XyC2pQkEBs8eni2u
	UnqnvrtIK6vOpNxYOhXuS0s7Bb0GSdVqNHPZIi6WqKvF8+G4/138hXFfZyVv6K1UF6v6YjrkNN2
	wXyOF9/uSwXVFnGR65krjLP/Dt3ESOjYVMfuDgQQhwcW9Nj7XtHCAmk4VSveNysBqF7+KK2eNIe
	5g/uxvTuigvQJkGxJBY4Lf0OcSuDz+AyyUgWc0jEJ7ctwa5Hea1aR62iD+bO1dcrUEJ9HP/U4hd
	zL3eX3DiMKqorsaElvgrheBnmqvbUcKdVoKLTkg62FpqgWNtF1HA2Fw9v+JQpZ8GJP1Fvg==
X-Google-Smtp-Source: AGHT+IEoVxCgF7YIqwIlY+SpTzN02pWtMaX8Ajan3U/u4LzehyIv2yb5Pgcqd6TLvlJe+PRrXaoaJA==
X-Received: by 2002:a17:907:9803:b0:aa5:163c:69cb with SMTP id a640c23a62f3a-ab38b49a5cbmr1452836066b.12.1738065703568;
        Tue, 28 Jan 2025 04:01:43 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:43 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 10/12] iio: accel: adxl345: add freefall feature
Date: Tue, 28 Jan 2025 12:00:58 +0000
Message-Id: <20250128120100.205523-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128120100.205523-1-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the freefall detection of the sensor together with a threshold and
time parameter. Add sysfs handle to enable/disable the feature and
introduce another sysfs macro. This is the third sysfs macro for sysfs
handles of this sensor. The three sysfs macros allow to cover all
sensor features and parameters.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 127 +++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ef0a12fd59be..62d75d28b6fc 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -170,6 +170,9 @@ struct adxl345_state {
 	u32 tap_window_us;
 	bool tap_suppressed;
 
+	u8 ff_value;
+	u32 ff_time_ms;
+
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -187,6 +190,11 @@ static struct iio_event_spec adxl345_events[] = {
 		.dir = IIO_EV_DIR_DOUBLETAP,
 		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
 	},
+	{
+		/* free fall */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+	},
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -442,6 +450,61 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
 	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
 }
 
+/* ff */
+
+static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
+{
+	int ret;
+	unsigned int regval;
+
+	ret = adxl345_read_interrupts(st, &regval);
+	if (ret)
+		return ret;
+
+	*en = FIELD_GET(ADXL345_INT_FREE_FALL, st->int_map) > 0;
+
+	return 0;
+}
+
+static int adxl345_set_ff_en(struct adxl345_state *st, bool en)
+{
+	bool ff_en = en && st->ff_value > 0 && st->ff_time_ms > 0;
+
+	adxl345_intmap_switch_bit(st, ff_en, ADXL345_INT_FREE_FALL);
+
+	return adxl345_write_interrupts(st);
+}
+
+static int adxl345_set_ff_value(struct adxl345_state *st, u8 val)
+{
+	st->ff_value = val;
+
+	return regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
+}
+
+static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
+			       u32 val_fract_us)
+{
+	unsigned int regval;
+	int val_ms;
+
+	/*
+	 * max value is 255 * 5000 us = 1.275000 seconds
+	 *
+	 * Note: the scaling is similar to the scaling in the ADXL380
+	 */
+	if (1000000 * val_int + val_fract_us > 1275000)
+		return -EINVAL;
+
+	val_ms = val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
+	st->ff_time_ms = val_ms;
+
+	regval = DIV_ROUND_CLOSEST(val_ms, 5);
+
+	/* Values between 100ms and 350ms (0x14 to 0x46) are recommended. */
+	return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, 0xff));
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -711,6 +774,49 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+#define ADXL345_generate_iio_dev_attr_INT(A, B, C)			\
+	static ssize_t in_accel_##A##_##B##_##C##_show(struct device *dev, \
+						       struct device_attribute *attr, \
+						       char *buf)	\
+	{								\
+		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
+		struct adxl345_state *st = iio_priv(indio_dev);		\
+		int val;						\
+									\
+		val = st->B##_##C;					\
+									\
+		return iio_format_value(buf, IIO_VAL_INT, 1, &val);	\
+	}								\
+									\
+	static ssize_t in_accel_##A##_##B##_##C##_store(struct device *dev, \
+							struct device_attribute *attr, \
+							const char *buf, size_t len) \
+	{								\
+		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
+		struct adxl345_state *st = iio_priv(indio_dev);		\
+		int val, ret;						\
+									\
+		ret = kstrtoint(buf, 0, &val);				\
+		if (ret)						\
+			return ret;					\
+									\
+		if (val < 0 || val > 255)				\
+			return -EINVAL;					\
+									\
+		ret = adxl345_set_measure_en(st, false);		\
+		if (ret)						\
+			return ret;					\
+									\
+		adxl345_set_##B##_##C(st, val);				\
+									\
+		ret = adxl345_set_measure_en(st, true);			\
+		if (ret)						\
+			return ret;					\
+									\
+		return len;						\
+	}								\
+	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##B##_##C, 0)
+
 #define ADXL345_generate_iio_dev_attr_EN(A, B)				\
 	static ssize_t in_accel_##A##_##B##_en_show(struct device *dev, \
 						    struct device_attribute *attr, \
@@ -798,13 +904,20 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}								\
 	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##C##_##E, 0)
 
+ADXL345_generate_iio_dev_attr_INT(freefall, ff, value);
+
 ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO, us);
 ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, window, MICRO, us);
 ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, latent, MICRO, us);
+ADXL345_generate_iio_dev_attr_FRACTIONAL(freefall, ff, time, MILLI, ms);
 
+ADXL345_generate_iio_dev_attr_EN(freefall, ff);
 ADXL345_generate_iio_dev_attr_EN(gesture_doubletap, suppressed);
 
 static struct attribute *adxl345_event_attrs[] = {
+	&iio_dev_attr_in_accel_freefall_ff_en.dev_attr.attr,
+	&iio_dev_attr_in_accel_freefall_ff_value.dev_attr.attr,
+	&iio_dev_attr_in_accel_freefall_time_ms.dev_attr.attr,
 	&iio_dev_attr_in_accel_gesture_singletap_duration_us.dev_attr.attr,
 	&iio_dev_attr_in_accel_gesture_doubletap_suppressed_en.dev_attr.attr,
 	&iio_dev_attr_in_accel_gesture_doubletap_latent_us.dev_attr.attr,
@@ -1041,6 +1154,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_AND_Y_AND_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	return -ENOENT;
 }
 
@@ -1148,6 +1272,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_window_us = 20;			/*   20 [0x14] -> .025    */
 	st->tap_latent_us = 20;			/*   20 [0x14] -> .025    */
 
+	st->ff_value = 8;			/*    8 [0x08]            */
+	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.39.5


