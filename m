Return-Path: <linux-iio+bounces-23616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 165CAB3EED6
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F33318973C6
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA042EFDA1;
	Mon,  1 Sep 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="VsOjxw5h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E6726E6E3;
	Mon,  1 Sep 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756086; cv=none; b=oKzyNsvBb+/+upcFOSSK1ZLZxzYiQ07JoetkTFbbmBR7wXUpd1s7IsdwpYCzpZlMth1ou0WqbXkU83OvZyyOpKCHSv5ehAESVKRYg+2DvuldR4ihBWbEttXgOXkqJz8Nj+v4oCB3Fhrbi1RzrV5XcU8xYf+eoF3BG5au0DjohoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756086; c=relaxed/simple;
	bh=SPTDnuWXlsl3c6JOcsuOtHHrw9B9ptG+74FIDORUjXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmLuLhXTuiVvDv1qZVaLq/TlhXNpHerCqTBWMiz8C3/OQHpf3fyR8NNmKe5suWiRxERSM5JsijebOjKAIkV2NPj6iqJuU9QlYRKTZfbbRPM/uKR9me4Hcq6gPKCv+wtzaRvTTZ8ITL8lrcsz+0JjUctG3T+JL44P2htA6ilH8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=VsOjxw5h; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 3238E173BF0;
	Mon, 01 Sep 2025 22:47:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpOacFWMAeuverN5StFX9i0fstghOyKvYP+C9JNthCw=;
	b=VsOjxw5hWAPvfl75U7heUBGw9K2G7iY3+jk9cOAquCAAR35DAWKSlZd9LbdOQC5FUezS3J
	Raocoy42J+kyQIO3LtiQgs+0a5a8ENPYx/16ryw/7VlAM9MIptzJHF/0jyA58Lc3aDvKH5
	44v7dYFgf2fsBDmJbU2abKJ1hus7MrSuIx4tRY3CKqB6BEqVDs067eSe2Oj152XzlZu0SR
	gyprOBOHQ8DJke3eY+VY23dXSvhyroIAUpC2otd5aRz5gP5fORaKmUfKIOTevrxhFBW+tM
	9Xq/1Cb9Fbv94Ry2Dj1SBRRma1xY/euLeWWliqubEsmiBBlBPwcbVM3PnXyXjg==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 08/10] iio: accel: BMA220 add events
Date: Mon,  1 Sep 2025 22:47:34 +0300
Message-ID: <20250901194742.11599-9-petre.rodan@subdimension.ro>
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

Add events for tap detection and low-g, high-g, slope conditions.
Ignored the 80-column rule for readability.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_core.c | 686 ++++++++++++++++++++++++++++++++
 1 file changed, 686 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 41889cdcef76..c8da6cc2eaf3 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -13,6 +13,37 @@
  * scale (range)             | in_accel_scale                 | see _available
  * cut-off freq (filt_config)| in_accel_filter_low_pass_...   | see _available
  * ---------------------------------------------------------------------------
+ *
+ * Events:
+ * Register                  | IIO ABI (sysfs)                   | valid values
+ * --------------------------+-----------------------------------+------------
+ * high-g detection          |                                   |
+ *   enable/disable irq      | in_accel_*_thresh_rising_en       | 0/1
+ *   threshold (high_th)     | in_accel_thresh_rising_value      | 0-15
+ *   hysteresis (high_hy)    | in_accel_thresh_rising_hysteresis | 0-3
+ *   duration (high_dur)     | in_accel_thresh_rising_period     | 0-63
+ * low-g detection           |                                   |
+ *   enable/disable irq      | in_accel_*_thresh_falling_en      | 0/1
+ *   threshold (low_th)      | in_accel_thresh_falling_value     | 0-15
+ *   hysteresis (low_hy)     | in_accel_thresh_falling_hysteresis| 0-3
+ *   duration (low_dur)      | in_accel_thresh_falling_period    | 0-63
+ * slope detection           |                                   |
+ *   enable/disable irq      | in_accel_*_thresh_either_en       | 0/1
+ *   threshold (slope_th)    | in_accel_thresh_either_value      | 0-15
+ *   duration (slope_dur)    | in_accel_thresh_either_period     | 0-3
+ * tap sensing               |                                   |
+ *   enable/disable singletap| in_accel_*_gesture_singletap_en   | 0/1 [2]
+ *   enable/disable doubletap| in_accel_*_gesture_doubletap_en   | 0/1 [2]
+ *   threshold (tt_th)       | in_accel_gesture_singletap_value  | 0-15
+ *   duration (tt_dur)       | in_accel_gesture_doubletap_period | see [1]
+ * ----------------------------------------------------------------------------
+ *
+ * [1] The event related sysfs interface provides and expects raw register values
+ *         (unshifted bitfields) based on the chip specifications.
+ * [2] Do not mix singletap and doubletap interrupt enable flags.
+ *
+ * To be on the safe side do not enable two or more concurrent interrupt events
+ * of different types.
  */

 #include <linux/bits.h>
@@ -151,6 +182,48 @@
 #define BMA220_COF_64HZ				0x4
 #define BMA220_COF_32HZ				0x5

+#define BMA220_TAP_TYPE_DOUBLE			0x0
+#define BMA220_TAP_TYPE_SINGLE			0x1
+
+static const struct iio_event_spec bma220_events[] = {
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_SINGLETAP,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE)
+	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_DOUBLETAP,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+				       BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
 #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -162,6 +235,8 @@
 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |\
 	    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
 	.scan_index = index,						\
+	.event_spec = bma220_events,					\
+	.num_event_specs = ARRAY_SIZE(bma220_events),			\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = 6,						\
@@ -193,6 +268,7 @@ struct bma220_data {
 	struct mutex lock;
 	u8 lpf_3db_freq_idx;
 	u8 range_idx;
+	u8 tap_type;
 	struct iio_trigger *trig;
 	struct {
 		s8 chans[3];
@@ -299,6 +375,12 @@ static const struct iio_trigger_ops bma220_trigger_ops = {
 	.validate_device = &iio_trigger_validate_own_device,
 };

+static int bma220_reset_int(struct bma220_data *data)
+{
+	return regmap_update_bits(data->regmap, BMA220_REG_IE1, BMA220_INT_RST_MSK,
+				  FIELD_PREP(BMA220_INT_RST_MSK, 1));
+}
+
 static irqreturn_t bma220_trigger_handler(int irq, void *p)
 {
 	int ret;
@@ -433,6 +515,564 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
 	}
 }

+static int bma220_is_tap_en(struct bma220_data *data,
+			    enum iio_modifier axis,
+			    int type,
+			    bool *en)
+{
+	unsigned int reg_val, val;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMA220_REG_IE0, &reg_val);
+	if (ret)
+		return ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		*en = FIELD_GET(BMA220_INT_EN_TAP_X_MSK, reg_val);
+		break;
+	case IIO_MOD_Y:
+		*en = FIELD_GET(BMA220_INT_EN_TAP_Y_MSK, reg_val);
+		break;
+	case IIO_MOD_Z:
+		*en = FIELD_GET(BMA220_INT_EN_TAP_Z_MSK, reg_val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (*en) {
+		ret = regmap_read(data->regmap, BMA220_REG_CONF5, &reg_val);
+		if (ret)
+			return ret;
+		val = FIELD_GET(BMA220_TIP_EN_MSK, reg_val);
+		data->tap_type = val;
+/*
+ * the tip_en reg_flag  - if '1' it enables SingleTap, '0' DoubleTap
+ * truth table for the logic below, *en has to be switched to 0 in two cases:
+ *   ST  DT  reg_val  *en
+ *   1   0   0 (DT)    0
+ *   1   0   1 (ST)    1
+ *   0   1   0 (DT)    1
+ *   0   1   1 (ST)    0
+ */
+		if ((type == IIO_EV_DIR_DOUBLETAP) && val)
+			*en = false;
+		else if ((type == IIO_EV_DIR_SINGLETAP) && !val)
+			*en = false;
+	}
+
+	return 0;
+}
+
+static int bma220_is_slope_en(struct bma220_data *data,
+			      enum iio_modifier axis,
+			      bool *en)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMA220_REG_IE0, &reg_val);
+	if (ret)
+		return ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		*en = FIELD_GET(BMA220_INT_EN_SLOPE_X_MSK, reg_val);
+		break;
+	case IIO_MOD_Y:
+		*en = FIELD_GET(BMA220_INT_EN_SLOPE_Y_MSK, reg_val);
+		break;
+	case IIO_MOD_Z:
+		*en = FIELD_GET(BMA220_INT_EN_SLOPE_Z_MSK, reg_val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bma220_is_high_en(struct bma220_data *data,
+			      enum iio_modifier axis,
+			      bool *en)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMA220_REG_IE1, &reg_val);
+	if (ret)
+		return ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		*en = FIELD_GET(BMA220_INT_EN_HIGH_X_MSK, reg_val);
+		break;
+	case IIO_MOD_Y:
+		*en = FIELD_GET(BMA220_INT_EN_HIGH_Y_MSK, reg_val);
+		break;
+	case IIO_MOD_Z:
+		*en = FIELD_GET(BMA220_INT_EN_HIGH_Z_MSK, reg_val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bma220_set_tap_en(struct bma220_data *data,
+			     enum iio_modifier axis,
+			     int type,
+			     bool en)
+{
+	unsigned int flags = BMA220_TAP_TYPE_DOUBLE;
+	int ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
+					 BMA220_INT_EN_TAP_X_MSK,
+					 FIELD_PREP(BMA220_INT_EN_TAP_X_MSK, en));
+		break;
+	case IIO_MOD_Y:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
+					 BMA220_INT_EN_TAP_Y_MSK,
+					 FIELD_PREP(BMA220_INT_EN_TAP_Y_MSK, en));
+		break;
+	case IIO_MOD_Z:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
+					 BMA220_INT_EN_TAP_Z_MSK,
+					 FIELD_PREP(BMA220_INT_EN_TAP_Z_MSK, en));
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (ret)
+		return ret;
+
+	/* tip_en must be 1 to select singletap detection */
+	if (type == IIO_EV_DIR_SINGLETAP)
+		flags = BMA220_TAP_TYPE_SINGLE;
+
+	ret = regmap_update_bits(data->regmap, BMA220_REG_CONF5,
+				 BMA220_TIP_EN_MSK,
+				 FIELD_PREP(BMA220_TIP_EN_MSK, flags));
+	if (ret)
+		return ret;
+
+	data->tap_type = flags;
+
+	return 0;
+}
+
+static int bma220_set_slope_en(struct bma220_data *data,
+			       enum iio_modifier axis,
+			       bool en)
+{
+	int ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
+					 BMA220_INT_EN_SLOPE_X_MSK,
+					 FIELD_PREP(BMA220_INT_EN_SLOPE_X_MSK, en));
+		break;
+	case IIO_MOD_Y:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
+					 BMA220_INT_EN_SLOPE_Y_MSK,
+					 FIELD_PREP(BMA220_INT_EN_SLOPE_Y_MSK, en));
+		break;
+	case IIO_MOD_Z:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
+					 BMA220_INT_EN_SLOPE_Z_MSK,
+					 FIELD_PREP(BMA220_INT_EN_SLOPE_Z_MSK, en));
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int bma220_set_high_en(struct bma220_data *data,
+			      enum iio_modifier axis,
+			      bool en)
+{
+	int ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
+					 BMA220_INT_EN_HIGH_X_MSK,
+					 FIELD_PREP(BMA220_INT_EN_HIGH_X_MSK, en));
+		break;
+	case IIO_MOD_Y:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
+					 BMA220_INT_EN_HIGH_Y_MSK,
+					 FIELD_PREP(BMA220_INT_EN_HIGH_Y_MSK, en));
+		break;
+	case IIO_MOD_Z:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
+					 BMA220_INT_EN_HIGH_Z_MSK,
+					 FIELD_PREP(BMA220_INT_EN_HIGH_Z_MSK, en));
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+// find out if the event is enabled
+static int bma220_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+	bool int_en;
+	int ret;
+	unsigned int reg_val, val;
+
+	guard(mutex)(&data->lock);
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (dir) {
+		case IIO_EV_DIR_SINGLETAP:
+			ret = bma220_is_tap_en(data, chan->channel2,
+					       IIO_EV_DIR_SINGLETAP, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		case IIO_EV_DIR_DOUBLETAP:
+			ret = bma220_is_tap_en(data, chan->channel2,
+					       IIO_EV_DIR_DOUBLETAP, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_EITHER:
+			ret = bma220_is_slope_en(data, chan->channel2, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		case IIO_EV_DIR_RISING:
+			ret = bma220_is_high_en(data, chan->channel2, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(data->regmap, BMA220_REG_IE1,
+					  &reg_val);
+			if (ret)
+				return ret;
+			val = FIELD_GET(BMA220_INT_EN_LOW_MSK, reg_val);
+			return val;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+// set if the event is enabled
+static int bma220_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     bool state)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	guard(mutex)(&data->lock);
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (dir) {
+		case IIO_EV_DIR_SINGLETAP:
+			ret = bma220_set_tap_en(data, chan->channel2,
+						IIO_EV_DIR_SINGLETAP, state);
+			break;
+		case IIO_EV_DIR_DOUBLETAP:
+			ret = bma220_set_tap_en(data, chan->channel2,
+						IIO_EV_DIR_DOUBLETAP, state);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_EITHER:
+			ret = bma220_set_slope_en(data, chan->channel2, state);
+			break;
+		case IIO_EV_DIR_RISING:
+			ret = bma220_set_high_en(data, chan->channel2, state);
+			break;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
+						 BMA220_INT_EN_LOW_MSK,
+						 FIELD_PREP(BMA220_INT_EN_LOW_MSK, state));
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	return bma220_reset_int(data);
+}
+
+static int bma220_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int *val, int *val2)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+	unsigned int reg_val;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
+			*val = FIELD_GET(BMA220_TT_TH_MSK, reg_val);
+			break;
+		case IIO_EV_INFO_PERIOD:
+			ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
+			*val = FIELD_GET(BMA220_TT_DUR_MSK, reg_val);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_EITHER:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF4,
+						  &reg_val);
+				*val = FIELD_GET(BMA220_SLOPE_TH_MSK, reg_val);
+				break;
+			case IIO_EV_INFO_PERIOD:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF4,
+						  &reg_val);
+				*val = FIELD_GET(BMA220_SLOPE_DUR_MSK, reg_val);
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_EV_DIR_RISING:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF1,
+						  &reg_val);
+				*val = FIELD_GET(BMA220_HIGH_TH_MSK, reg_val);
+				break;
+			case IIO_EV_INFO_PERIOD:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF0,
+						  &reg_val);
+				*val = FIELD_GET(BMA220_HIGH_DUR_MSK, reg_val);
+				break;
+			case IIO_EV_INFO_HYSTERESIS:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF0,
+						  &reg_val);
+				*val = FIELD_GET(BMA220_HIGH_HY_MSK, reg_val);
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_EV_DIR_FALLING:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF1,
+						  &reg_val);
+				*val = FIELD_GET(BMA220_LOW_TH_MSK, reg_val);
+				break;
+			case IIO_EV_INFO_PERIOD:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF2,
+						  &reg_val);
+				*val = FIELD_GET(BMA220_LOW_DUR_MSK, reg_val);
+				break;
+			case IIO_EV_INFO_HYSTERESIS:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF2,
+						  &reg_val);
+				*val = FIELD_GET(BMA220_LOW_HY_MSK, reg_val);
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	return IIO_VAL_INT;
+}
+
+static int bma220_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int val, int val2)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			if (!FIELD_FIT(BMA220_TT_TH_MSK, val))
+				return -EINVAL;
+			ret = regmap_update_bits(data->regmap, BMA220_REG_CONF3,
+						 BMA220_TT_TH_MSK,
+						 FIELD_PREP(BMA220_TT_TH_MSK, val));
+			break;
+		case IIO_EV_INFO_PERIOD:
+			if (!FIELD_FIT(BMA220_TT_DUR_MSK, val))
+				return -EINVAL;
+			ret = regmap_update_bits(data->regmap, BMA220_REG_CONF3,
+						 BMA220_TT_DUR_MSK,
+						 FIELD_PREP(BMA220_TT_DUR_MSK, val));
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_EITHER:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				if (!FIELD_FIT(BMA220_SLOPE_TH_MSK, val))
+					return -EINVAL;
+				ret = regmap_update_bits(data->regmap,
+							 BMA220_REG_CONF4,
+							 BMA220_SLOPE_TH_MSK,
+							 FIELD_PREP(BMA220_SLOPE_TH_MSK, val));
+				break;
+			case IIO_EV_INFO_PERIOD:
+				if (!FIELD_FIT(BMA220_SLOPE_DUR_MSK, val))
+					return -EINVAL;
+				ret = regmap_update_bits(data->regmap,
+							 BMA220_REG_CONF4,
+							 BMA220_SLOPE_DUR_MSK,
+							 FIELD_PREP(BMA220_SLOPE_DUR_MSK, val));
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_EV_DIR_RISING:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				if (!FIELD_FIT(BMA220_HIGH_TH_MSK, val))
+					return -EINVAL;
+				ret = regmap_update_bits(data->regmap,
+							 BMA220_REG_CONF1,
+							 BMA220_HIGH_TH_MSK,
+							 FIELD_PREP(BMA220_HIGH_TH_MSK, val));
+				break;
+			case IIO_EV_INFO_PERIOD:
+				if (!FIELD_FIT(BMA220_HIGH_DUR_MSK, val))
+					return -EINVAL;
+				ret = regmap_update_bits(data->regmap,
+							 BMA220_REG_CONF0,
+							 BMA220_HIGH_DUR_MSK,
+							 FIELD_PREP(BMA220_HIGH_DUR_MSK, val));
+				break;
+			case IIO_EV_INFO_HYSTERESIS:
+				if (!FIELD_FIT(BMA220_HIGH_HY_MSK, val))
+					return -EINVAL;
+				ret = regmap_update_bits(data->regmap,
+							 BMA220_REG_CONF0,
+							 BMA220_HIGH_HY_MSK,
+							 FIELD_PREP(BMA220_HIGH_HY_MSK, val));
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_EV_DIR_FALLING:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				if (!FIELD_FIT(BMA220_LOW_TH_MSK, val))
+					return -EINVAL;
+				ret = regmap_update_bits(data->regmap,
+							 BMA220_REG_CONF1,
+							 BMA220_LOW_TH_MSK,
+							 FIELD_PREP(BMA220_LOW_TH_MSK, val));
+				break;
+			case IIO_EV_INFO_PERIOD:
+				if (!FIELD_FIT(BMA220_LOW_DUR_MSK, val))
+					return -EINVAL;
+				ret = regmap_update_bits(data->regmap,
+							 BMA220_REG_CONF2,
+							 BMA220_LOW_DUR_MSK,
+							 FIELD_PREP(BMA220_LOW_DUR_MSK, val));
+				break;
+			case IIO_EV_INFO_HYSTERESIS:
+				if (!FIELD_FIT(BMA220_LOW_HY_MSK, val))
+					return -EINVAL;
+				ret = regmap_update_bits(data->regmap,
+							 BMA220_REG_CONF2,
+							 BMA220_LOW_HY_MSK,
+							 FIELD_PREP(BMA220_LOW_HY_MSK, val));
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int bma220_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
@@ -447,6 +1087,10 @@ static const struct iio_info bma220_info = {
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
 	.read_avail		= bma220_read_avail,
+	.read_event_config	= bma220_read_event_config,
+	.write_event_config	= bma220_write_event_config,
+	.read_event_value	= bma220_read_event_value,
+	.write_event_value	= bma220_write_event_value,
 	.debugfs_reg_access	= &bma220_reg_access,
 };

@@ -563,6 +1207,8 @@ static int bma220_init(struct bma220_data *data)
 		}
 	}

+	data->tap_type = BMA220_TAP_TYPE_DOUBLE;
+
 	return 0;
 }

@@ -584,6 +1230,7 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
 	struct bma220_data *data = iio_priv(indio_dev);
 	int rv;
 	u8 bma220_reg_if[2];
+	s64 timestamp = iio_get_time_ns(indio_dev);

 	guard(mutex)(&data->lock);
 	rv = regmap_bulk_read(data->regmap, BMA220_REG_IF0, bma220_reg_if,
@@ -596,6 +1243,45 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
 		goto done;
 	}

+	if (FIELD_GET(BMA220_IF_HIGH, bma220_reg_if[1]))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+			       timestamp);
+	if (FIELD_GET(BMA220_IF_LOW, bma220_reg_if[1]))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
+			       timestamp);
+	if (FIELD_GET(BMA220_IF_SLOPE, bma220_reg_if[1]))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+			       timestamp);
+	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if[1])) {
+
+		if (data->tap_type == BMA220_TAP_TYPE_SINGLE)
+			iio_push_event(indio_dev,
+				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							  IIO_MOD_X_OR_Y_OR_Z,
+							  IIO_EV_TYPE_GESTURE,
+							  IIO_EV_DIR_SINGLETAP),
+				       timestamp);
+		else
+			iio_push_event(indio_dev,
+				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							  IIO_MOD_X_OR_Y_OR_Z,
+							  IIO_EV_TYPE_GESTURE,
+							  IIO_EV_DIR_DOUBLETAP),
+				       timestamp);
+	}
+
 done:

 	return IRQ_HANDLED;
--
2.49.1


