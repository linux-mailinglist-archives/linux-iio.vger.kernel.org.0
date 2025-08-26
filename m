Return-Path: <linux-iio+bounces-23275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 270A3B34FFB
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C3FC4E3A57
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823BA1B4223;
	Tue, 26 Aug 2025 00:10:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2B199949
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167017; cv=none; b=dkPdLPA9ZWeNVJf4iMkavQKlqzVZUtLceH7IRBgJL48MYVIII90EzVKrR3EnHeX0Ce1rcF0mPxKYVoIzv/RIPepG/8Y/tY0NPLd+D1NVvxg8HvLRTbmnepn2Ch6f67Li8eJniF3DWmzDhgzb8esFceComusv6yKJkxS0fklE9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167017; c=relaxed/simple;
	bh=KvB7AcGV2UhZn8qkyG31dPsX3MoMzJ4VsYwV8BaWMPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCZcqbDI13xrdqXUaiSMCXCFWp3/BnEudQPwvLwpqhN+DxsIoOc1QvyJAum/z33yUp52hcYfgn4t+GoYeX9BRNqXGlx0Nek0WBMNuWl4F8EFKnoR9Ub+oBXip1dWxqe7jD6MK1xU3LaqMsOmfWh4pmQQ7ry0+qeHpoMzWscX0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
Date: Mon, 25 Aug 2025 20:10:06 -0400
Subject: [PATCH v7 4/5] iio: mcp9600: Add support for IIR filter
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-mcp9600-iir-v7-4-2ba676a52589@kernel.org>
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
In-Reply-To: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Collins <bcollins@kernel.org>
X-Migadu-Flow: FLOW_OUT

MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
to allow get/set of this value.

Use filter_type[none, ema] for enabling the IIR filter.

Signed-off-by: Ben Collins <bcollins@kernel.org>
---
 drivers/iio/temperature/mcp9600.c | 147 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index aa42c2b1a369edbd36e0d6d6d1738ed0069fd990..d3309e30628ae5cdc74378403952ba285990f4c0 100644
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
@@ -119,6 +141,8 @@ struct mcp_chip_info {
 struct mcp9600_data {
 	struct i2c_client *client;
 	u32 thermocouple_type;
+	int filter_level;
+	int filter_enabled;
 };
 
 static int mcp9600_config(struct mcp9600_data *data)
@@ -129,6 +153,9 @@ static int mcp9600_config(struct mcp9600_data *data)
 
 	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
 			  mcp9600_type_map[data->thermocouple_type]);
+	/* The chip understands 0 as "none", and 1-7 as ema filter levels. */
+	if (data->filter_enabled)
+		FIELD_MODIFY(MCP9600_FILTER_MASK, &cfg, data->filter_level + 1);
 
 	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
 	if (ret < 0) {
@@ -146,7 +173,11 @@ static int mcp9600_config(struct mcp9600_data *data)
 			.address = MCP9600_HOT_JUNCTION,		       \
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
 					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
+					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
 					      BIT(IIO_CHAN_INFO_SCALE),	       \
+			.info_mask_separate_available =                        \
+					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+			.ext_info = mcp9600_ext_filter,			       \
 			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
 			.num_event_specs = hj_num_ev,			       \
 		},							       \
@@ -162,6 +193,57 @@ static int mcp9600_config(struct mcp9600_data *data)
 		},							       \
 	}
 
+static int mcp9600_get_filter(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+
+	return data->filter_enabled ? MCP9600_FILTER_TYPE_EMA :
+		MCP9600_FILTER_TYPE_NONE;
+}
+
+static int mcp9600_set_filter(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      unsigned int mode)
+{
+	struct mcp9600_data *data = iio_priv(indio_dev);
+	int new_type;
+
+	switch (mode) {
+	case MCP9600_FILTER_TYPE_NONE:
+		new_type = 0;
+		break;
+
+	case MCP9600_FILTER_TYPE_EMA:
+		new_type = 1;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* Do not reset the filter if we don't need to. */
+	if (data->filter_enabled == new_type)
+		return 0;
+
+	data->filter_enabled = new_type;
+	return mcp9600_config(data);
+}
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
@@ -216,6 +298,69 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
 		*val = mcp9600_tc_types[data->thermocouple_type];
 		return IIO_VAL_CHAR;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (!data->filter_enabled)
+			return IIO_VAL_EMPTY;
+
+		*val = mcp_iir_coefficients_avail[data->filter_level][0];
+		*val2 = mcp_iir_coefficients_avail[data->filter_level][1];
+		return IIO_VAL_INT_PLUS_MICRO;
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
+	struct mcp9600_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (!data->filter_enabled) {
+			*type = IIO_VAL_EMPTY;
+			return IIO_AVAIL_LIST;
+		}
+
+		*vals = (int *)mcp_iir_coefficients_avail;
+		*length = 2 * ARRAY_SIZE(mcp_iir_coefficients_avail);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
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
+		if (!data->filter_enabled)
+			return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(mcp_iir_coefficients_avail); i++) {
+			if (mcp_iir_coefficients_avail[i][0] == val &&
+			    mcp_iir_coefficients_avail[i][1] == val2)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(mcp_iir_coefficients_avail))
+			return -EINVAL;
+
+		/* Do not reset the filter if there's no change. */
+		if (data->filter_level == i)
+			return 0;
+
+		data->filter_level = i;
+		return mcp9600_config(data);
+
 	default:
 		return -EINVAL;
 	}
@@ -358,6 +503,8 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
 
 static const struct iio_info mcp9600_info = {
 	.read_raw = mcp9600_read_raw,
+	.read_avail = mcp9600_read_avail,
+	.write_raw = mcp9600_write_raw,
 	.read_event_config = mcp9600_read_event_config,
 	.write_event_config = mcp9600_write_event_config,
 	.read_event_value = mcp9600_read_thresh,

-- 
2.39.5


