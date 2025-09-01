Return-Path: <linux-iio+bounces-23615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701BB3EED5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B60485FF9
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DE932ED3D;
	Mon,  1 Sep 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="h0X/8HKd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E0326CE0C;
	Mon,  1 Sep 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756086; cv=none; b=RqMG9VDfbvMbhqGZhytXot50LN8KY3kVErCND7GfVdXCF2xgIsgYNPTWUZafHrve/6OB/9nnJQw/lgofFygwp+YnsJSPr0Ow71X3rJ6xpWP4+/BK5D6gUUFUq179NxeZvB9EYMK1t8b2u/4C6dhGeCCE2dQEg12TPMXgy3ZKUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756086; c=relaxed/simple;
	bh=K45IjixPrXgD03TC0E+tSKojr5KCH5C2CNhucTA/Dsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4p+PKNbJql6szmKB03i0XdxD9k1qp8+BPQonTAwPv7f8t/NnZYd5aE2Q9GfskmombyjTNwZ5wOHPKFZvUbVoYdRhx6iIa95QIbLZPONNwUWzMVPo87ofgcU/+ykHFtyIIRYBJ6JNaLxfZTUia/gKBJKUwbvUBPYh4IW4GY7qFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=h0X/8HKd; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 7A2C5173BF1;
	Mon, 01 Sep 2025 22:47:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZYGiqF2skMc3RyZgs/wuMISopg/ogYPdjYAoGSQNbg=;
	b=h0X/8HKdBhkkt97nQ6MCm0X/FDXqLcZrWuLkIG0OIbYMqLhBTZDjMeOam45RiUL+a8w8Rv
	SnFtsPoxSEUcNOJOiA+O3nRxwwRNWmVOiKs8352+Tyn6o271Vs4Fh/p/IDNz0HN88Etyf2
	rvy6ysWqQmi7Zav8Q2GvU97D5oQ8P4bES4C1GrurKpwlX+EjBCmJRk5leBUPGir0p3rXgQ
	SEZaPApx4TlTxNDq9x+Ldhz88P1ncwzONoAWudILzo0IiuxBkINVd3ZpKRQ8dNncbIed/s
	s/L7DhqAi1inVA8H2UxXMu932hzRD7sQT7aiXd1YK5x7ZuNCSTMZOhwvWOH4qA==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 09/10] iio: accel: BMA220 add event attrs
Date: Mon,  1 Sep 2025 22:47:35 +0300
Message-ID: <20250901194742.11599-10-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250901194742.11599-1-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add event attributes not directly covered by the IIO API.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_core.c | 178 +++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index c8da6cc2eaf3..7a1064b408bb 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -31,11 +31,18 @@
  *   enable/disable irq      | in_accel_*_thresh_either_en       | 0/1
  *   threshold (slope_th)    | in_accel_thresh_either_value      | 0-15
  *   duration (slope_dur)    | in_accel_thresh_either_period     | 0-3
+ *   filter (slope_filt)     | in_accel_slope_filt               | 0/1
+ * orientation               |                                   |
+ *   mounting (orient_ex)    | in_accel_orient_ex                | 0/1
+ *   blocking                | in_accel_orient_blocking          | see [1]
  * tap sensing               |                                   |
  *   enable/disable singletap| in_accel_*_gesture_singletap_en   | 0/1 [2]
  *   enable/disable doubletap| in_accel_*_gesture_doubletap_en   | 0/1 [2]
  *   threshold (tt_th)       | in_accel_gesture_singletap_value  | 0-15
  *   duration (tt_dur)       | in_accel_gesture_doubletap_period | see [1]
+ *   sample cnt (tt_samp)    | in_accel_gesture_tap_sample_cnt   | see [1]
+ *   filter (tt_filt)        | in_accel_gesture_tap_filt         | 0/1
+ * latch time (lat_int)      | in_accel_latch_time               | see [1]
  * ----------------------------------------------------------------------------
  *
  * [1] The event related sysfs interface provides and expects raw register values
@@ -269,6 +276,7 @@ struct bma220_data {
 	u8 lpf_3db_freq_idx;
 	u8 range_idx;
 	u8 tap_type;
+	bool irq_needs_clear_if;
 	struct iio_trigger *trig;
 	struct {
 		s8 chans[3];
@@ -1083,7 +1091,167 @@ static int bma220_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return regmap_write(data->regmap, reg, writeval);
 }

+/* Event related attributes not directly covered by the IIO API */
+enum bma220_attributes {
+	BMA220_ATTR_TT_FILT,
+	BMA220_ATTR_TT_SAMP,
+	BMA220_ATTR_SLOPE_FILT,
+	BMA220_ATTR_ORIENT_EX,
+	BMA220_ATTR_ORIENT_BLOCKING,
+	BMA220_ATTR_LATCH_TIME,
+};
+
+static ssize_t event_attr_reg_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct bma220_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
+	int ret = -EINVAL;
+	unsigned int reg_val, flags;
+
+	guard(mutex)(&data->lock);
+
+	switch (iattr->address) {
+	case BMA220_ATTR_TT_FILT:
+		ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
+		flags = FIELD_GET(BMA220_TT_FILT_MSK, reg_val);
+		break;
+	case BMA220_ATTR_TT_SAMP:
+		ret = regmap_read(data->regmap, BMA220_REG_CONF5, &reg_val);
+		flags = FIELD_GET(BMA220_TT_SAMP_MSK, reg_val);
+		break;
+	case BMA220_ATTR_SLOPE_FILT:
+		ret = regmap_read(data->regmap, BMA220_REG_CONF4, &reg_val);
+		flags = FIELD_GET(BMA220_SLOPE_FILT_MSK, reg_val);
+		break;
+	case BMA220_ATTR_ORIENT_EX:
+		ret = regmap_read(data->regmap, BMA220_REG_CONF4, &reg_val);
+		flags = FIELD_GET(BMA220_ORIENT_EX_MSK, reg_val);
+		break;
+	case BMA220_ATTR_ORIENT_BLOCKING:
+		ret = regmap_read(data->regmap, BMA220_REG_CONF5, &reg_val);
+		flags = FIELD_GET(BMA220_ORIENT_BLOCKING_MSK, reg_val);
+		break;
+	case BMA220_ATTR_LATCH_TIME:
+		ret = regmap_read(data->regmap, BMA220_REG_IE1, &reg_val);
+		flags = FIELD_GET(BMA220_INT_LATCH_MSK, reg_val);
+		break;
+	}
+
+	if (ret)
+		return ret;
+	return sysfs_emit(buf, "%d\n", flags);
+}
+
+static ssize_t event_attr_reg_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct bma220_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
+	int ret = -EINVAL;
+	int value;
+
+	if (kstrtoint(buf, 0, &value))
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+
+	switch (iattr->address) {
+	case BMA220_ATTR_TT_FILT:
+		if (!FIELD_FIT(BMA220_TT_FILT_MSK, value))
+			return -EINVAL;
+		ret = regmap_update_bits(data->regmap, BMA220_REG_CONF3,
+					 BMA220_TT_FILT_MSK,
+					 FIELD_PREP(BMA220_TT_FILT_MSK, value));
+		break;
+	case BMA220_ATTR_TT_SAMP:
+		if (!FIELD_FIT(BMA220_TT_SAMP_MSK, value))
+			return -EINVAL;
+		ret = regmap_update_bits(data->regmap, BMA220_REG_CONF5,
+					 BMA220_TT_SAMP_MSK,
+					 FIELD_PREP(BMA220_TT_SAMP_MSK, value));
+		break;
+	case BMA220_ATTR_SLOPE_FILT:
+		if (!FIELD_FIT(BMA220_SLOPE_FILT_MSK, value))
+			return -EINVAL;
+		ret = regmap_update_bits(data->regmap, BMA220_REG_CONF4,
+					 BMA220_SLOPE_FILT_MSK,
+					 FIELD_PREP(BMA220_SLOPE_FILT_MSK, value));
+		break;
+	case BMA220_ATTR_ORIENT_EX:
+		if (!FIELD_FIT(BMA220_ORIENT_EX_MSK, value))
+			return -EINVAL;
+		ret = regmap_update_bits(data->regmap, BMA220_REG_CONF4,
+					 BMA220_ORIENT_EX_MSK,
+					 FIELD_PREP(BMA220_ORIENT_EX_MSK, value));
+		break;
+	case BMA220_ATTR_ORIENT_BLOCKING:
+		if (!FIELD_FIT(BMA220_ORIENT_BLOCKING_MSK, value))
+			return -EINVAL;
+		ret = regmap_update_bits(data->regmap, BMA220_REG_CONF5,
+					 BMA220_ORIENT_BLOCKING_MSK,
+					 FIELD_PREP(BMA220_ORIENT_BLOCKING_MSK,
+						    value));
+		break;
+	case BMA220_ATTR_LATCH_TIME:
+		if (!FIELD_FIT(BMA220_INT_LATCH_MSK, value))
+			return -EINVAL;
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
+					 BMA220_INT_LATCH_MSK,
+					 FIELD_PREP(BMA220_INT_LATCH_MSK, value));
+		if (value == BMA220_INT_LATCH_MAX)
+			data->irq_needs_clear_if = true;
+		break;
+	}
+
+	if (ret < 0)
+		return -EINVAL;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(in_accel_gesture_tap_filt, 0644,
+		       event_attr_reg_show, event_attr_reg_store,
+		       BMA220_ATTR_TT_FILT);
+
+static IIO_DEVICE_ATTR(in_accel_gesture_tap_sample_cnt, 0644,
+		       event_attr_reg_show, event_attr_reg_store,
+		       BMA220_ATTR_TT_SAMP);
+
+static IIO_DEVICE_ATTR(in_accel_thresh_either_filt, 0644,
+		       event_attr_reg_show, event_attr_reg_store,
+		       BMA220_ATTR_SLOPE_FILT);
+
+static IIO_DEVICE_ATTR(in_accel_orient_ex, 0644,
+		       event_attr_reg_show, event_attr_reg_store,
+		       BMA220_ATTR_ORIENT_EX);
+
+static IIO_DEVICE_ATTR(in_accel_orient_blocking, 0644,
+		       event_attr_reg_show, event_attr_reg_store,
+		       BMA220_ATTR_ORIENT_BLOCKING);
+
+static IIO_DEVICE_ATTR(in_accel_latch_time, 0644,
+		       event_attr_reg_show, event_attr_reg_store,
+		       BMA220_ATTR_LATCH_TIME);
+
+static struct attribute *bma220_event_attributes[] = {
+	&iio_dev_attr_in_accel_gesture_tap_filt.dev_attr.attr,
+	&iio_dev_attr_in_accel_gesture_tap_sample_cnt.dev_attr.attr,
+	&iio_dev_attr_in_accel_thresh_either_filt.dev_attr.attr,
+	&iio_dev_attr_in_accel_orient_ex.dev_attr.attr,
+	&iio_dev_attr_in_accel_orient_blocking.dev_attr.attr,
+	&iio_dev_attr_in_accel_latch_time.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group bma220_event_attribute_group = {
+	.attrs = bma220_event_attributes,
+};
+
 static const struct iio_info bma220_info = {
+	.event_attrs		= &bma220_event_attribute_group,
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
 	.read_avail		= bma220_read_avail,
@@ -1207,6 +1375,7 @@ static int bma220_init(struct bma220_data *data)
 		}
 	}

+	data->irq_needs_clear_if = false;
 	data->tap_type = BMA220_TAP_TYPE_DOUBLE;

 	return 0;
@@ -1228,7 +1397,7 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct bma220_data *data = iio_priv(indio_dev);
-	int rv;
+	int rv, ret;
 	u8 bma220_reg_if[2];
 	s64 timestamp = iio_get_time_ns(indio_dev);

@@ -1283,6 +1452,13 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
 	}

 done:
+	if (data->irq_needs_clear_if) {
+		ret = bma220_reset_int(data);
+		if (ret)
+			dev_warn(data->dev,
+				 "Failed to clear interrupt flag (%pe)\n",
+				 ERR_PTR(ret));
+	}

 	return IRQ_HANDLED;
 }
--
2.49.1


