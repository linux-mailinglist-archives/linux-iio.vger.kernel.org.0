Return-Path: <linux-iio+bounces-25056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7F5BDAAEC
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1948B3AC474
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7719E302CBD;
	Tue, 14 Oct 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ntkBAQnk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84E2D876F;
	Tue, 14 Oct 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460206; cv=none; b=fRaZ4XZbSBGo3gZ4WXNFenOJvR3DmqnU0Rba3yuySGXjq0d0M27rM/xdqPsn9VdCEnIAh0afvL5p6T4Dkre77f2miy363xVGA9q7hNgRUI8Q2VkbIN7VrbCu5ek0UicjqNx2sFqhPFKwt+DHTIhyvXkPHVqGBaDT1rfYaET/5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460206; c=relaxed/simple;
	bh=5PMsbpkyQZ7AM3kLcCD/2MwVttAqWGXNIay5Tw+CVZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5OED5gesa8BtnkHe6GMKcgCtLRdiiMw+FPQfsgpocx62cSFWcyl+V9kyaxNl3J6qf4B+qHk1MBpQz8S+tnCDwir0OiuvaPwznnwroML4TkjW1v6TBS83m5P1hiHeOfh5/NuOJ7V+2FnA887hsGQRJxUxfCfl2evRvGVRrIpzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=ntkBAQnk; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 2FB4C173BE2;
	Tue, 14 Oct 2025 19:43:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1760460196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3SJtc9caFRZkRBqkfFSSmg4tCIibjt8q8fWiS2+e2o=;
	b=ntkBAQnkFCBzRE6qsXCL57Sb4pROfEk43GyjiggphYRyjuR5zOnXUHwz34TE/Oey+RG/We
	h3DOqgmo87wnlBrUBhpy1uhABnuz247eBoGzpURTxtR9V2cx/8M3sRiITkmD+ubyf0VZqO
	OiYlrbi7bitXxeoZjvdESscmGsxutnEG1MWexmSWPDMLHnkKcJ0me2mPQgBUzlTOxao5+U
	JLgnlxUFNg2hlEw057aWu7mGwrFVxopZh50VFJBOXm1UJvx0DOr9Ofi9Ures0Dfzy6HAGx
	z4shBU/6vgQ139CXdrcwYM5zpI/a0lu1omcAKgpsLf5Xp8Hg3mX5zGyrPWMFZA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Tue, 14 Oct 2025 19:42:59 +0300
Subject: [PATCH 3/6] iio: accel: bma220: add tap detection
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-bma220_events-v1-3-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
In-Reply-To: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10335;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=5PMsbpkyQZ7AM3kLcCD/2MwVttAqWGXNIay5Tw+CVZE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2p1Zlp0QXNuYWgvVWE3WjJZSFRKdUNJVGcrClg0cGhnVnZZRVd6N1RqdEZn
 MXpCMW9rQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzduMmJ
 BQW9KRUhRcko2ZGpPa2xqVDlvUC9pR2NRdzBYWUY5dExFT1RBcUNWOHhEaEdqSktZK3FXdzJKcQ
 oyVXdYTHRnQmFtNVM3eFJSK0tOK1JsTDc2eTdITzloSkd6VDI1YkRxVG1sRmgxZmRReEZ0blVpY
 lRnQisrdkZ3CnBpK01hc1ozS1hzeEVvVnh0bzRuVFdYNjk2KzRDNGdzc1NRQXJVYTdRU0RRUngz
 QllhYVRuakkzVkI0NlV4dFYKYk96ZS8yWlZYVGdFaERDYU0vbVg4Z2Y2UUhaU0hrVzN5VnNiaXR
 tVml2UHQ2WVVRU1g4UXN6SnBXNUdMNDZoOQo3MHFjVUdyTzBMY0NsT2JrRHRzS2JScVFOdm1BQX
 AzZVRnRm9iNkE5NXpoYWRoV3J6ZVBUR2puYjdrTU5kT2tJClpFL3V1Wk5OTDNacFpFVUd5bzQrU
 ktzZjhLSGJmd2VwRkF0MWJBbHB1eVMrUUR2TFFoL0hyUDlyZStRbFZMaXAKcndwNnZOT2s5S2s1
 WVpOajc3U3cyTGIyRnNHUVdWSWhFaXd1K0J3bEhXQnc5d2JuY1BzNGIzbXNMSU5qeEl5Tgo0Vzl
 JQnBsY3JyMEdzM3plbSs4TVZIcHF3VlZKWHdVS3NSZDI1UFZNeCtvL2x3bkdpREdIWEltZWY0QV
 h0d3cyCnFadk52Qmh4SENEUG5qQjRzOEoyUkxlM2FFclhCVFFFZEVnWWpYb1ZNUCttUW56dDhpT
 nhjSGtCZ2V4WXJHWEMKa0pZSEFmbmFhSUcxdElFOVFHYTZmbUhOcDlBMTJ1THoyeXRtWjZUS0lW
 OXB2NFI0Um8zU2VjSUxRck5DZ3RlbgpPREd3UWhxbUdPL3F1SGk2a2llN2dBQVNqL1h1QzZ2T2l
 qY29Fcy91S0JlRVlmTmExSmh4ZHhWL0lJMlVobFZhCm9kOWZoL0FCMWZVWnNnPT0KPWw5OUMKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add support for tap events.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
Please advise on where should I should be using the mutex guard()
(single regmap reads vs single writes vs more complex read/write combo)
---
 drivers/iio/accel/bma220_core.c | 296 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 295 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 871342d21456..c4bebf3e5548 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -101,6 +102,25 @@
 #define BMA220_COF_64Hz				0x4
 #define BMA220_COF_32Hz				0x5
 
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
+};
+
 #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
 	.address = reg,							\
@@ -112,6 +132,8 @@
 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |\
 	    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
 	.scan_index = index,						\
+	.event_spec = bma220_events,					\
+	.num_event_specs = ARRAY_SIZE(bma220_events),			\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = 6,						\
@@ -136,6 +158,7 @@ struct bma220_data {
 	struct mutex lock;
 	u8 lpf_3dB_freq_idx;
 	u8 range_idx;
+	u8 tap_type;
 	struct iio_trigger *trig;
 	struct {
 		s8 chans[3];
@@ -231,6 +254,13 @@ static const struct iio_trigger_ops bma220_trigger_ops = {
 	.validate_device = &iio_trigger_validate_own_device,
 };
 
+static int bma220_reset_int(struct bma220_data *data)
+{
+	return regmap_update_bits(data->regmap, BMA220_REG_IE1,
+				  BMA220_INT_RST_MSK,
+				  FIELD_PREP(BMA220_INT_RST_MSK, 1));
+}
+
 static irqreturn_t bma220_trigger_handler(int irq, void *p)
 {
 	int ret;
@@ -376,6 +406,241 @@ static int bma220_read_avail(struct iio_dev *indio_dev,
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
+ * truth table for the logic below, *en has to be switched to false in two cases:
+ *   ST  DT  reg_flag  *en
+ *   1   0   0 (DT)    false
+ *   1   0   1 (ST)    true
+ *   0   1   0 (DT)    true
+ *   0   1   1 (ST)    false
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
+static int bma220_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+	bool int_en;
+	int ret;
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
+	default:
+		return -EINVAL;
+	}
+}
+
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
+			if (ret)
+				return ret;
+			*val = FIELD_GET(BMA220_TT_TH_MSK, reg_val);
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_PERIOD:
+			ret = regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
+			if (ret)
+				return ret;
+			*val = FIELD_GET(BMA220_TT_DUR_MSK, reg_val);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
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
+
+	guard(mutex)(&data->lock);
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			if (!FIELD_FIT(BMA220_TT_TH_MSK, val))
+				return -EINVAL;
+			return regmap_update_bits(data->regmap, BMA220_REG_CONF3,
+						  BMA220_TT_TH_MSK,
+						  FIELD_PREP(BMA220_TT_TH_MSK, val));
+		case IIO_EV_INFO_PERIOD:
+			if (!FIELD_FIT(BMA220_TT_DUR_MSK, val))
+				return -EINVAL;
+			return regmap_update_bits(data->regmap, BMA220_REG_CONF3,
+						  BMA220_TT_DUR_MSK,
+						  FIELD_PREP(BMA220_TT_DUR_MSK, val));
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 static int bma220_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
@@ -390,6 +655,10 @@ static const struct iio_info bma220_info = {
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
 	.read_avail		= bma220_read_avail,
+	.read_event_config	= bma220_read_event_config,
+	.write_event_config	= bma220_write_event_config,
+	.read_event_value	= bma220_read_event_value,
+	.write_event_value	= bma220_write_event_value,
 	.debugfs_reg_access	= &bma220_reg_access,
 };
 
@@ -484,6 +753,8 @@ static int bma220_init(struct device *dev, struct bma220_data *data)
 					     "Failed to set i2c watchdog\n");
 	}
 
+	data->tap_type = BMA220_TAP_TYPE_DOUBLE;
+
 	return 0;
 }
 
@@ -506,13 +777,36 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
 	struct bma220_data *data = iio_priv(indio_dev);
 	int ret;
 	unsigned int bma220_reg_if1;
+	s64 timestamp = iio_get_time_ns(indio_dev);
+
+	guard(mutex)(&data->lock);
 
 	ret = regmap_read(data->regmap, BMA220_REG_IF1, &bma220_reg_if1);
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1))
+	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1)) {
 		iio_trigger_poll_nested(data->trig);
+		return IRQ_HANDLED;
+	}
+
+	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if1)) {
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
 
 	return IRQ_HANDLED;
 }

-- 
2.49.1


