Return-Path: <linux-iio+bounces-12287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F09C95F5
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97FAE1F22C11
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB831C3300;
	Thu, 14 Nov 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE4sgnFe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722D1C3021;
	Thu, 14 Nov 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625842; cv=none; b=M5CQrHP41PsiOWiAe5K+ASSfiFtkiLcRcaqwNt/HlvErf1EIA/nIP2OIv1tEhPVQwxStxfUUHMD5X3YJ+yaXdlrZupNekm+4yTFckt3zVBxNiGcHoMTJpNlVBUK2NahtvJUunOpcCPLHQDA3tLQeuWG/tkWhlhtZesbIWajX/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625842; c=relaxed/simple;
	bh=AOcx0u3Q57oRK1lQ25ugyv/KGeGnaRFT2BWpyL0ilY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIbHhIU5hYrfw8pml1sprlQ5mtI0u/3Ycp21miYJxbUVIv5NPKezvz9UvWBEKRBquLD+K1EaA3J+oB5m4dN6p5Ssz/CkrID1jko+BoEELuXftxMxx5714sxON2f8pp31VYyu6P1jQfEntKQ+wVvK/gxpFvPxmPNQD43f5DEPbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE4sgnFe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d5231f71cso161244f8f.2;
        Thu, 14 Nov 2024 15:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625839; x=1732230639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0VFauSqujulbnKXaeTxZ9RqE35ZagjP+SnH3hIrISE=;
        b=DE4sgnFek+bjjNytxabvs29UyYwtKRKH13zaHBujQ22A7ZYmZhjQSL3PmFR76ZZA4p
         FMQbt+yWmvyQhpDmrcHZFTkLKzPW6UIPvusK3kVE/NvPAg1kBDqHWTxlyZjiNxEjeuTw
         fk+sOhFFkAQ9NK8BgV9KLQVg1u+YvPcFhA+IIxy1ICrwihRnah5jeB46oJwM+dvPJt6Q
         PlsVtovXuoq3ukYH1lYCeIr+5VlbPtC7VDJrAiu15OGko6yXoSzRV0aXaVRESo4hAhq+
         DwnDgBdXmK99BxZtkadTw8pwHnWoDLOTREslomBvdpPZrsSTH+qYv1E8eKivzMY+a3au
         3Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625839; x=1732230639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0VFauSqujulbnKXaeTxZ9RqE35ZagjP+SnH3hIrISE=;
        b=aIyr3L2WgwbyXroHQGqSTDHOokseLzUMaZEoblPbGwFQDIryu2MUNUa6ZxpnDF+GBS
         /kq+1+ek1zHiXhiKc9NzHh8bL9vHzcdTMim8XMq7XoMK2XX79xEMQ+6K4/1XWEHiXr7R
         HY5OSp7GTQ5d2/RHpWnFMA5AHS/kpIiAnJxW1dkWau2n7kkRjbxYn3kMH9iidxeqfneA
         0ZjldeuFNNBvyQCxH/46AgYD+WrJOmGL8v0/Kg4sUtRlswUwmjxO7BWMuVLfEGdLxC4k
         8EdJAxqAl85EaEvBlHxV/Ly1CcO0g3CH6/giivyLTRuFXb6JHb8fEXRd2ESCP714+Gwl
         SYnA==
X-Forwarded-Encrypted: i=1; AJvYcCVOxVJGLY0UnUMpjdxg39g9x2Ebwdu4jIZQCgufce8vh2uXOZkwPhXPqjUId4NJPg/rFttTWvqEfbc=@vger.kernel.org, AJvYcCW669mIyV8zQQTnOLAHrJ9igqlasaMPvkI0Mwfm/ZuwQlklMb8y5UT6PLlo9Yfz2LC7vwNSXqGYAt1eTQzz@vger.kernel.org
X-Gm-Message-State: AOJu0YyvV91N+S+Y/PKomcrs0+tqoYmzikR1U4OjcbJa8jXeuVv00+OQ
	oPzwFrfXguo3+FhkSoZlwqloiAzC6dHgmC8SGtby79PszK2wg15f
X-Google-Smtp-Source: AGHT+IF4yaBvsDLjzUS7HN0s2JYpYZC4j/knJHgVQAIVFtx1wQaB5VbMWb84BrkqpPUESbt/iUMMMA==
X-Received: by 2002:a05:600c:1c1f:b0:430:52ec:1e2a with SMTP id 5b1f17b1804b1-432df790752mr1682095e9.7.1731625838922;
        Thu, 14 Nov 2024 15:10:38 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:37 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 19/22] iio: accel: adxl345: prepare FIFO watermark handling
Date: Thu, 14 Nov 2024 23:09:59 +0000
Message-Id: <20241114231002.98595-20-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
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
index a5b2efa69e..c99b8176f0 100644
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
@@ -333,7 +353,76 @@ static void adxl345_powerdown(void *ptr)
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
 
@@ -343,6 +432,7 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 
 static struct attribute *adxl345_attrs[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_watermark_en.dev_attr.attr,
 	NULL
 };
 
@@ -648,6 +738,7 @@ static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
+	.hwfifo_set_watermark = adxl345_set_watermark,
 };
 
 /**
@@ -705,6 +796,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	/* some reasonable pre-initialization */
 	st->data.act_axis_control = 0xFF;
 
+	/* default is all features turned off */
+	st->watermark_en = 0;
+
 	st->intio = ADXL345_INT1;
 
 	indio_dev->name = st->info->name;
-- 
2.39.2


