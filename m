Return-Path: <linux-iio+bounces-22775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 404F6B2844E
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 18:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59261D04F52
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402F2E5D1D;
	Fri, 15 Aug 2025 16:47:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463A2E5D17
	for <linux-iio@vger.kernel.org>; Fri, 15 Aug 2025 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276460; cv=none; b=i8J4iihXHCQIKvvjUWODhXs/YOwM6VFALcAWBXw/mV9vpv4UGEgytJycHfkC14YXr8w5AfNfqu238YmEaWqeCEqq3AjX3CHDLC9DquICrKGlQGOmVBGzR4UXOMjZRujPsk35wouxwSlwZhi19iVIiQuVVz5okJuBdLDgf3tzUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276460; c=relaxed/simple;
	bh=tLdq16+tT/SCDYe9EnIPIJ3s3zMQDVrtHieEdsXPFkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zwd3ZSpBkQgoiU9q7qwokAr/T7daO/8Cej5Bi70p9uCDPxwF3AbJQMvrWMVojwWzuAPzzCJB2yoZBJx13cjp28gmP/ejVK4dE8mdlNPyGgWrnri40YjSzeHqxuG/A3Ael3FcgKXNSeVrN7yy8JEPrW5d25ktkoNOc6kPBNNhLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com
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
Subject: [PATCH 5/5] iio: mcp9600: Add support for IIR filter
Date: Fri, 15 Aug 2025 16:46:07 +0000
Message-ID: <20250815164627.22002-6-bcollins@watter.com>
In-Reply-To: <20250815164627.22002-1-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
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

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 drivers/iio/temperature/mcp9600.c | 73 +++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 361572a241f06..896520ddf6d3c 100644
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
@@ -94,6 +95,10 @@ static const int mcp9600_tc_types[] = {
 	[THERMOCOUPLE_TYPE_R] = 'R',
 };
 
+static const int mcp_iir_coefficients_avail[] = {
+	1, 2, 4, 8, 16, 32, 64, 128,
+};
+
 static const struct iio_event_spec mcp9600_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -118,7 +123,10 @@ static const struct iio_event_spec mcp9600_events[] = {
 			.address = MCP9600_HOT_JUNCTION,		       \
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
 					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
+					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
 					      BIT(IIO_CHAN_INFO_SCALE),	       \
+			.info_mask_separate_available =                        \
+					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
 			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
 			.num_event_specs = hj_num_ev,			       \
 		},							       \
@@ -161,6 +169,7 @@ struct mcp_chip_info {
 struct mcp9600_data {
 	struct i2c_client *client;
 	u32 thermocouple_type;
+	u8 filter_level; /* Chip default is 0 */
 };
 
 static int mcp9600_read(struct mcp9600_data *data,
@@ -191,13 +200,36 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
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
+		*val = mcp_iir_coefficients_avail[data->filter_level];
+		return IIO_VAL_INT;
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
+		*vals = mcp_iir_coefficients_avail;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(mcp_iir_coefficients_avail);
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -211,6 +243,7 @@ static int mcp9600_config(struct mcp9600_data *data)
 
 	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
 			  mcp9600_type_map[data->thermocouple_type]);
+	FIELD_MODIFY(MCP9600_FILTER_MASK, &cfg, data->filter_level);
 
 	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
 	if (ret < 0) {
@@ -221,6 +254,43 @@ static int mcp9600_config(struct mcp9600_data *data)
 	return 0;
 }
 
+static int mcp9600_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return IIO_VAL_INT;
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
+			if (mcp_iir_coefficients_avail[i] == val)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(mcp_iir_coefficients_avail))
+			return -EINVAL;
+
+		data->filter_level = i;
+		return mcp9600_config(data);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
 {
 	if (channel2 == IIO_MOD_TEMP_AMBIENT) {
@@ -358,6 +428,9 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
 
 static const struct iio_info mcp9600_info = {
 	.read_raw = mcp9600_read_raw,
+	.read_avail = mcp9600_read_avail,
+	.write_raw = mcp9600_write_raw,
+	.write_raw_get_fmt = mcp9600_write_raw_get_fmt,
 	.read_event_config = mcp9600_read_event_config,
 	.write_event_config = mcp9600_write_event_config,
 	.read_event_value = mcp9600_read_thresh,
-- 
2.50.1


