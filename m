Return-Path: <linux-iio+bounces-15254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A9AA2EA63
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F52168737
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0265B1DED71;
	Mon, 10 Feb 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjNUDGLh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F21E47B4;
	Mon, 10 Feb 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185304; cv=none; b=pmETT5FqffQWRpDBiP9Fyz7JKg7kaCo7WFTqc3WQZDamMJ9i/wB/uuuZb/59Wvh1ywd6mL842+6nse5kjC5wVMbl9gcFJP6uNSx1fYR2U7cdXg9SCcmW2Me1TPIYiaOFWxhDFvfa4wfgRq5c0UgAS4d4MUgW6l92+EsbhPth350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185304; c=relaxed/simple;
	bh=CkhotK32JDptjtcWapjSsSJF6V93X4D9d/b7DoqBsKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBokpTIe7NYUK0B3MQILZZiNvMGO+qD1SQfUFmkfarW4p5CwAiLYWFgwZ17rgsh1s2nZiW3QuZ9fOdL1rqQjw7YJvWFDKQD9UfHMAs+6P5P/fvnCjNQjVAqD+pz6zc6XR4KwHJD0t5zeKEU29HBzObPtUfDfveW0zR4NIxBaV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjNUDGLh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7c4350826so8207266b.3;
        Mon, 10 Feb 2025 03:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185301; x=1739790101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsBWRk8zfnkA3uoBf9V6a0nw7PSVQIDTY9KmDxfKDmU=;
        b=TjNUDGLhoncfUg/Xm+LPvHxwkjC17Iyedl4eVkrQjDJDLFUmPxqIjmcUaJLiCfwNEe
         58/fnfBHmf+pN995G4NLaXS+7YHBnKVIdtQH4mV48vmwM8CRG50ErLPUFGJS46LG+wCo
         rnd2WLc7EEkgiQoyQVNlhFGdg5ZRxGgDxddgOJCTQ4R0QR2uXpOzN0B0gdvgE7uAyEgi
         vx8OcHtiZjNvIzyCyCO1wtwpBpSrTbXTvonykiWF2eRG9oTAtRbDOGTdGg6yAWhU34gf
         cEvRHXnixhx5Uhr3XxYuXeSNj/Sbwe2yTLiO/GDhZ7EVYrfnN5C8zcM0KYX3sp9nzZ2q
         YIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185301; x=1739790101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsBWRk8zfnkA3uoBf9V6a0nw7PSVQIDTY9KmDxfKDmU=;
        b=jPisSpSc8aGiyQiY5qNLm4w7iWnlh24PdjKwktz+3yafW7Z8A696ll49T7mNSpibcQ
         idkwTvtXfuNEf9/lpCg74+cEM4eTH5tcpsZDrp8LlP8UGYQlGH40cV9iw+CFA2iHjpaL
         7jr6Xo7XA59qtKd0y8clUHFAE+BjS1Rn5CpWsrwdJNKhi5rh6EvNgUfojttZTIjiQVfB
         wTg1ZiDs5A/qMea7nHRSCYI964XXQsop1ZaFbeFiZMcPhQ/HGCXISyq1cmGox8i8zZiT
         TMHhCeTTrDND+QIoJ4r7vGPXNrurrFpzzyE0Dfd3nPwLdvetBx5v9zKDq4S0dXXZUtOK
         krZw==
X-Forwarded-Encrypted: i=1; AJvYcCVy1B5tv1sYi15PIG1ew0g86OFamnwidoaZRdNxPNJqtL2B1rCPOx6n3C+skgWiGzFkiogjv8G4ry+qTdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/ZqLX3De7O+qqOD//HRw50dnn7pcBoJLWdQA2plE8O1UR+hZ
	fSS8nJ0A6gGhorGECeUewB8VF2chALRKght5P4TSpseGC0s1Tey7
X-Gm-Gg: ASbGncvszeAMGyZiT1vAygL8RkOCKr0KgY73PL8OSNgUVXUvnyHpwGsDsS7FDd0O7tj
	a1krg9pQBmkF7JNpkc8Pjo9wjITYRTporrrwTY1XRHc5ojpsY++MPFmA9ET1JMpWu//H48xsBcB
	Dhi2XSowxz/7oKCQgOctvnstqKrYbFK35A9gjNMANYrOjeklAhh31PBzdhTKoqfa9H3BCYm9Lq3
	oesr1I1DqZogSZuArXOUKjVCuE8atY7REUIRIUXNiN1X45tT7aRpkztxAsENdvreK1uyEQVuKY+
	Bsgiud+uS5WGFQEZLtdcTixsy13d51US8bGO5TDr9Ry5J+NceMs6kCaFRZp1IgZ0DAZSxA==
X-Google-Smtp-Source: AGHT+IF9ssgmeS3AEmbjcXyrDfumw80AGCvMhYW3vqQ4mtp2XnoXC4+8KON3DPDQl8m/6DxI8YxRsg==
X-Received: by 2002:a17:906:dc95:b0:ab7:5fcd:d4be with SMTP id a640c23a62f3a-ab789adeb97mr548815866b.1.1739185300790;
        Mon, 10 Feb 2025 03:01:40 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:40 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 07/14] iio: accel: adxl345: add double tap suppress bit
Date: Mon, 10 Feb 2025 11:01:12 +0000
Message-Id: <20250210110119.260858-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the suppress bit feature to the double tap feature.

Any tap event is defined by a rising signal edge above threshold, i.e.
duration time starts counting; and the falling edge under threshold
within duration time, i.e. then the tap event is issued. This means
duration is used individually for each tap event.

For double tap detection after a single tap, a latency time needs to be
specified. Usually tap events, i.e. spikes above and returning below
threshold will be ignored within latency. After latency, the window
time starts counting for a second tap detection which has to happen
within a duration time.

If the suppress bit is not set, spikes within latency time are ignored.
Setting the suppress bit will invalidate the double tap function. The
sensor will thus be able to save the window time for double tap
detection, and follow a more strict definition of what signal qualifies
for a double tap.

This brings in a new ABI functionality.
---
Q: Perhaps there is already some IIO ABI for it? If not, please let me
know which ABI documentation to extend. There will be a documentation
patch also later in this series.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index cf35a8f9f432..b6966fee3e3d 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -34,6 +34,7 @@
 #define ADXL345_INT2			1
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -81,6 +82,7 @@ struct adxl345_state {
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
+	bool tap_suppressed;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -243,6 +245,31 @@ static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
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
+	unsigned long regval = 0;
+	int ret;
+
+	en ? __set_bit(ilog2(ADXL345_TAP_SUPPRESS), &regval)
+		: __clear_bit(ilog2(ADXL345_TAP_SUPPRESS), &regval);
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+				 ADXL345_REG_TAP_SUPPRESS_MSK, regval);
+	if (ret)
+		return ret;
+
+	st->tap_suppressed = en;
+
+	return 0;
+}
+
 static int adxl345_set_tap_threshold(struct adxl345_state *st, u8 val)
 {
 	int ret;
@@ -616,6 +643,60 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t in_accel_gesture_doubletap_suppressed_en_show(struct device *dev,
+							     struct device_attribute *attr,
+							     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
+	bool en;
+	int val, ret;
+
+	ret = adxl345_is_suppressed_en(st, &en);
+	if (ret)
+		return ret;
+	val = en ? 1 : 0;
+
+	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
+}
+
+static ssize_t in_accel_gesture_doubletap_suppressed_en_store(struct device *dev,
+							      struct device_attribute *attr,
+							      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_suppressed_en(st, val > 0);
+	if (ret)
+		return ret;
+
+	ret =  adxl345_set_measure_en(st, true);
+	if (ret)
+		return ret;
+
+	return len;
+}
+static IIO_DEVICE_ATTR_RW(in_accel_gesture_doubletap_suppressed_en, 0);
+
+static struct attribute *adxl345_event_attrs[] = {
+	&iio_dev_attr_in_accel_gesture_doubletap_suppressed_en.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adxl345_event_attrs_group = {
+	.attrs = adxl345_event_attrs,
+};
+
 static void adxl345_powerdown(void *ptr)
 {
 	struct adxl345_state *st = ptr;
@@ -899,6 +980,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 
 static const struct iio_info adxl345_info = {
 	.attrs		= &adxl345_attrs_group,
+	.event_attrs	= &adxl345_event_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
-- 
2.39.5


