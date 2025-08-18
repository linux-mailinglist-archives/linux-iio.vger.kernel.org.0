Return-Path: <linux-iio+bounces-22887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA1CB29779
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 05:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B9D1967414
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B425DCF0;
	Mon, 18 Aug 2025 03:51:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F64262FE4
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489082; cv=none; b=hsFIn1SZ606zf0ZrhIbWu4UxWaheJcxgdHFh0MKccSx2PSYa2J35Dm/T21yd59h4W4lOv5DlwfwfIh3qqfYFi2ZQIvZ1iGsaa55HEJpZCCIMwE14BvxGpgXnyNEcL74lFUn4cAopiIw4a1BgMkFtmjbSoVS2r1YXUgjmt9mJAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489082; c=relaxed/simple;
	bh=9g6aOwtRTEnHwdBL5mLwauA4T3HFwa2BJuLwwqQV68o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rv9MUP8Ru68O5pIt10KRUjdAjL7w8ReiIaom+ueZA0ns8x/n8GG8NgTZSEn57vouPYzJuPMq4gdaQ6ULG9uU9AcoK0uU26ZrgkyEXBiHRKHiNGuoJF8w+OAJEWd72rdrcHPMkYw41AUqaxxB9YHMyqJUjDENSoNLXv7QA4tgG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Ben Collins <bcollins@watter.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] iio: mcp9600: Add support for IIR filter
Date: Sun, 17 Aug 2025 23:50:53 -0400
Message-Id: <20250818035053.32626-6-bcollins@watter.com>
In-Reply-To: <20250818035053.32626-1-bcollins@watter.com>
References: <20250818035053.32626-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
to allow get/set of this value.

Use a filter_type[none, ema] for enabling the IIR filter.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 drivers/iio/temperature/mcp9600.c | 155 ++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index fa382a988a991..32eddaea0239e 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -31,6 +31,7 @@
 #define MCP9600_STATUS_ALERT(x)		BIT(x)
 #define MCP9600_SENSOR_CFG		0x05
 #define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
+#define MCP9600_FILTER_MASK		GENMASK(2, 0)
 #define MCP9600_ALERT_CFG1		0x08
 #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
 #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
@@ -94,6 +95,27 @@ static const int mcp9600_tc_types[] = {
 	[THERMOCOUPLE_TYPE_R] = 'R',
 };
 
+enum mcp9600_filter {
+	MCP9600_FILTER_TYPE_NONE,
+	MCP9600_FILTER_TYPE_EMA,
+};
+
+static const char * const mcp9600_filter_type[] = {
+	[MCP9600_FILTER_TYPE_NONE] = "none",
+	[MCP9600_FILTER_TYPE_EMA] = "ema",
+};
+
+static const int mcp_iir_coefficients_avail[7][2] = {
+	/* Level 0 is no filter */
+	{ 0, 524549 },
+	{ 0, 243901 },
+	{ 0, 119994 },
+	{ 0,  59761 },
+	{ 0,  29851 },
+	{ 0,  14922 },
+	{ 0,   7461 },
+};
+
 static const struct iio_event_spec mcp9600_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -118,7 +140,11 @@ static const struct iio_event_spec mcp9600_events[] = {
 			.address = MCP9600_HOT_JUNCTION,		       \
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
 					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
+					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
 					      BIT(IIO_CHAN_INFO_SCALE),	       \
+			.info_mask_separate_available =                        \
+					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+			.ext_info = mcp9600_ext_filter,			       \
 			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
 			.num_event_specs = hj_num_ev,			       \
 		},							       \
@@ -134,6 +160,26 @@ static const struct iio_event_spec mcp9600_events[] = {
 		},							       \
 	}
 
+static int mcp9600_get_filter(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan);
+static int mcp9600_set_filter(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      unsigned int mode);
+
+static const struct iio_enum mcp9600_filter_enum = {
+	.items = mcp9600_filter_type,
+	.num_items = ARRAY_SIZE(mcp9600_filter_type),
+	.get = mcp9600_get_filter,
+	.set = mcp9600_set_filter,
+};
+
+static const struct iio_chan_spec_ext_info mcp9600_ext_filter[] = {
+	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &mcp9600_filter_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
+			   &mcp9600_filter_enum),
+	{ }
+};
+
 static const struct iio_chan_spec mcp9600_channels[][2] = {
 	MCP9600_CHANNELS(0, 0, 0, 0), /* Alerts: - - - - */
 	MCP9600_CHANNELS(1, 0, 0, 0), /* Alerts: 1 - - - */
@@ -161,6 +207,8 @@ struct mcp_chip_info {
 struct mcp9600_data {
 	struct i2c_client *client;
 	u32 thermocouple_type;
+	/* Filter enabled is 1-7, with 0 being off (filter_type none) */
+	u8 filter_level;
 };
 
 static int mcp9600_read(struct mcp9600_data *data,
@@ -191,13 +239,43 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SCALE:
 		*val = 62;
 		*val2 = 500000;
 		return IIO_VAL_INT_PLUS_MICRO;
+
 	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
 		*val = mcp9600_tc_types[data->thermocouple_type];
 		return IIO_VAL_CHAR;
+
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (data->filter_level == 0)
+			return -EINVAL;
+
+		*val = mcp_iir_coefficients_avail[data->filter_level - 1][0];
+		*val2 = mcp_iir_coefficients_avail[data->filter_level - 1][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9600_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (data->filter_level == 0)
+			return -EINVAL;
+
+		*vals = (int *)mcp_iir_coefficients_avail;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = 2 * ARRAY_SIZE(mcp_iir_coefficients_avail);
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -211,6 +289,7 @@ static int mcp9600_config(struct mcp9600_data *data)
 
 	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
 			  mcp9600_type_map[data->thermocouple_type]);
+	FIELD_MODIFY(MCP9600_FILTER_MASK, &cfg, data->filter_level);
 
 	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
 	if (ret < 0) {
@@ -221,6 +300,79 @@ static int mcp9600_config(struct mcp9600_data *data)
 	return 0;
 }
 
+static int mcp9600_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9600_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		for (i = 0; i < ARRAY_SIZE(mcp_iir_coefficients_avail); i++) {
+			if (mcp_iir_coefficients_avail[i][0] == val &&
+			    mcp_iir_coefficients_avail[i][1] == val2)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(mcp_iir_coefficients_avail))
+			return -EINVAL;
+
+		data->filter_level = i + 1;
+		return mcp9600_config(data);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9600_get_filter(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+
+	if (data->filter_level == 0)
+		return MCP9600_FILTER_TYPE_NONE;
+
+	return MCP9600_FILTER_TYPE_EMA;
+}
+
+static int mcp9600_set_filter(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      unsigned int mode)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+
+	switch (mode) {
+	case MCP9600_FILTER_TYPE_NONE:
+		data->filter_level = 0;
+		return mcp9600_config(data);
+
+	case MCP9600_FILTER_TYPE_EMA:
+		if (data->filter_level == 0) {
+			/* Minimum filter by default */
+			data->filter_level = 1;
+			return mcp9600_config(data);
+		}
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
 {
 	if (channel2 == IIO_MOD_TEMP_AMBIENT) {
@@ -358,6 +510,9 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
 
 static const struct iio_info mcp9600_info = {
 	.read_raw = mcp9600_read_raw,
+	.read_avail = mcp9600_read_avail,
+	.write_raw = mcp9600_write_raw,
+	.write_raw_get_fmt = mcp9600_write_raw_get_fmt,
 	.read_event_config = mcp9600_read_event_config,
 	.write_event_config = mcp9600_write_event_config,
 	.read_event_value = mcp9600_read_thresh,
-- 
2.39.5


