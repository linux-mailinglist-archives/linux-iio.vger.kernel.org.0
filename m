Return-Path: <linux-iio+bounces-14671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC352A20A25
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347331635FD
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D8F1B4132;
	Tue, 28 Jan 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMgbLT5W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B71ACEBF;
	Tue, 28 Jan 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065707; cv=none; b=NhE6Pvr4vqlnli+49VdjsbFLmVyrE1HnNl0p+WJlK+En6R6xDqMYvoddehk7fmCSmhynedCQYsJ3/2FN69a7Ghmfwiu5cGesZIR39lcvJpaTHFJIpgRbfEUH2fU44nuG6AG85Ji8w4BvTmfplqDblB+mJpm8bpiUSx/p1SsgSz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065707; c=relaxed/simple;
	bh=smBYyuU1n5MHiHwK6AtDzGI8tE9oqWL1TJdVd7NEdkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tsTE4/BH9Bz0dHJUQ9B2+SjUiPlAfzXMTcLFv5vkb0kdrEJG0rVzkXbBT+WFV9aBV4wyVjGpw6ris6RpKCu+mE9cAOI5fvhHjwWToYvHpW+RKCkI2e1yF86x8ANvJh0uSL40MJGiE3eXDrz3rPuK8eEUzsCCt26ZojjGhucTQIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMgbLT5W; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab30614c1d6so107598966b.1;
        Tue, 28 Jan 2025 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065703; x=1738670503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI/nnzNJ193vlwe+KhpBZKRWN7AdPR78xeiJg6BW9/8=;
        b=jMgbLT5WRot/10BbyDXf4o1qctt2MpoSphomh0n/OoJhSkTb9SBMAyYLSgTvOjBGcE
         V0RQXN0GR9HlyiUP2p51hCC1bD945wgXK7TTOIByl9/aqd7ZNznUzwNobJ/LyETycgnY
         oLNqobgEn37ImxbI5K0PrmIvdViWnNc612lmxuLbzaOwFqs9xtzRpjwNQjOXkt85vnbw
         E5ocvi8KxdmyHYm0M0iYJLu862YMxFeISyTfqENkXiSzDTgu5r9QN1OiiWpgFGUtfhyj
         mXsIZz7RAOYRbe6FfWvc8FEF1RHmu2uyN5RZPG7zeHbhfgwoZDwWDPO360eEmOMgQs7f
         RKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065703; x=1738670503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI/nnzNJ193vlwe+KhpBZKRWN7AdPR78xeiJg6BW9/8=;
        b=vj8MOvaM0K4PRctDQulUV8TQV689GU+eC2uuOs0QQx66PXtRT9HW3KeM1ZcBDDgzcJ
         +q+n+SokZ/caQ7pueFc+ziQO5bPv9gQyg5O57qYzVpBPwHvjwoSiNLqM5mQsYHc6BZas
         izK8I8mEgYxIsHboGXZQwSC9u4RUOwa2bHBx8Yw1pOkQW6FM2R0TzXz/UONpOuAIHjX7
         deTuv0naoDL53qPWhLOl2BG0fnm9C3jhmp1Qmxz9huv1C5lTswdzg4JrUJLDgG7TP7+H
         i7oxUFBEenMlGui7usi3zeIhNsbcQ9kKarcolFSp8aXcRcy0CeGeSVAD/56wg+xTohkJ
         y/5g==
X-Forwarded-Encrypted: i=1; AJvYcCXhWx3vkOrhCTw0Ht7wMZFIVkzwhUEoRN0lZRJTNKCMf1+3p1cplIw1e917hdle1mACaewYzrHhdfH+8vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqID5A1Ra4iQc+JxpZg2i34P+zcPfTfuVSanxd1vm3TKg6z1d
	+VCBI2LkpGDiGIBvMAAvFKg7zFV+lDj5BkWN1iPnxMPDdjQ27VJN
X-Gm-Gg: ASbGncuoRXOpx9tkWL6+vG4BYrsMfsgEk3V3NPFv8M2jgmabdjFBPtcLMC5ydyjpgnl
	RkeLDM9k1BrpLykm4uwPD2IU3n2l/avhyjJ3lR+xuYceyt5z9BkUNTzvN9xhiYAZSc8hDY7nCvk
	x7aYh90P7S0ytFDtTaJkfN5SbMjnFyUDvF7wamW0fskFLyrf61ObEbZ1gLB5OBPNfkA0zAEAIjj
	n3kTNlDkRmihu4Tw9Y2H4aB6wcSL9fpr7vM5W+tU6z7vRycaGoB4141KPQoBLu4iPrzgRsyE2D+
	x7+H/8VzqY3mbTFhH+UEwQCtomfymk4pMwScAzRIor9ZSEa7jtLx7lUD5goLKJkNRHUwWQ==
X-Google-Smtp-Source: AGHT+IE0si5YhOptbTHq1ER708uHctoL4MG4LmhhcIjfWXdwIwzQIZWmOkPXdGjGCqK5dHksg+r9LQ==
X-Received: by 2002:a17:907:3e0d:b0:aac:619:6411 with SMTP id a640c23a62f3a-ab65167653cmr976882966b.11.1738065702649;
        Tue, 28 Jan 2025 04:01:42 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:42 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 09/12] iio: accel: adxl345: add double tap suppress bit
Date: Tue, 28 Jan 2025 12:00:57 +0000
Message-Id: <20250128120100.205523-10-l.rubusch@gmail.com>
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

Add the suppress bit feature to make double tap (in)sensitive to the
configured threshold value for the tap feature. The feature is being
enabled by a sysfs handle for enabling. This is also needed for further
features in follow up patches.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 67 ++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index f9e5f47ba303..ef0a12fd59be 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -120,6 +120,7 @@
 #define ADXL345_INT2			1
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -167,6 +168,7 @@ struct adxl345_state {
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
+	bool tap_suppressed;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -346,6 +348,22 @@ static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
 	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
 }
 
+static int adxl345_is_suppressed_en(struct adxl345_state *st, bool *en)
+{
+	*en = st->tap_suppressed;
+
+	return 0;
+}
+
+static int adxl345_set_suppressed_en(struct adxl345_state *st, bool en)
+{
+	st->tap_suppressed = en;
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+				  ADXL345_REG_TAP_SUPPRESS_MSK,
+				  en ? ADXL345_TAP_SUPPRESS : ~ADXL345_TAP_SUPPRESS);
+}
+
 static int adxl345_set_tap_value(struct adxl345_state *st, u8 val)
 {
 	st->tap_threshold = val;
@@ -693,6 +711,52 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+#define ADXL345_generate_iio_dev_attr_EN(A, B)				\
+	static ssize_t in_accel_##A##_##B##_en_show(struct device *dev, \
+						    struct device_attribute *attr, \
+						    char *buf)		\
+	{								\
+		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
+		struct adxl345_state *st = iio_priv(indio_dev);		\
+		bool en;						\
+		int val, ret;						\
+									\
+		ret = adxl345_is_##B##_en(st, &en);			\
+		if (ret)						\
+			return ret;					\
+		val = en ? 1 : 0;					\
+									\
+		return iio_format_value(buf, IIO_VAL_INT, 1, &val);	\
+	}								\
+									\
+	static ssize_t in_accel_##A##_##B##_en_store(struct device *dev, \
+						     struct device_attribute *attr, \
+						     const char *buf, size_t len) \
+	{								\
+		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
+		struct adxl345_state *st = iio_priv(indio_dev);		\
+		int val, ret;						\
+									\
+		ret = kstrtoint(buf, 0, &val);				\
+		if (ret)						\
+			return ret;					\
+									\
+		ret = adxl345_set_measure_en(st, false);		\
+		if (ret)						\
+			return ret;					\
+									\
+		ret = adxl345_set_##B##_en(st, val > 0);		\
+		if (ret)						\
+			return ret;					\
+									\
+		ret =  adxl345_set_measure_en(st, true);		\
+		if (ret)						\
+			return ret;					\
+									\
+		return len;						\
+	}								\
+	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##B##_en, 0)
+
 #define ADXL345_generate_iio_dev_attr_FRACTIONAL(A, B, C, D, E)		\
 	static ssize_t in_accel_##A##_##C##_##E##_show(struct device *dev, \
 						       struct device_attribute *attr, \
@@ -738,8 +802,11 @@ ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO
 ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, window, MICRO, us);
 ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, latent, MICRO, us);
 
+ADXL345_generate_iio_dev_attr_EN(gesture_doubletap, suppressed);
+
 static struct attribute *adxl345_event_attrs[] = {
 	&iio_dev_attr_in_accel_gesture_singletap_duration_us.dev_attr.attr,
+	&iio_dev_attr_in_accel_gesture_doubletap_suppressed_en.dev_attr.attr,
 	&iio_dev_attr_in_accel_gesture_doubletap_latent_us.dev_attr.attr,
 	&iio_dev_attr_in_accel_gesture_doubletap_window_us.dev_attr.attr,
 	NULL
-- 
2.39.5


