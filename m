Return-Path: <linux-iio+bounces-22674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5A2B24D17
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 17:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F7D7B7E9C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B82192E4;
	Wed, 13 Aug 2025 15:17:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DCF214A64
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098236; cv=none; b=gTY8OzhZWDXCBp5ham9moH7W/MzRn+kpq+0ZGjIeMLyHB/lOyNxWfIYVAcJ1Ob8kfF8jarBNUJQ3RMrDvRwTz2USXv9wNhS6fKPU4ueKFVI0OZqvOU1yT6tyFn3HK02w+afpn0xeQQCWE9BwLxw8Il3uppBwZmOA9d47WqccUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098236; c=relaxed/simple;
	bh=cvjCLEcOkiK4BcbgnXUpI166R37zKxUZkOm8pseZKGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuLHK/bEFvxM6edUEuDzSQsVN6dFd6AM0bpT4lYYyluMIuds6mjtMc10bAnqfYLfMWLQLWEB/5Ns/O1/NxW1S/4V6DXJQODexmJhKmTTeoPv+/sy1gcOnnI14I5o8HG6mm3q7k4E1/cv6weKcak1N1HdDpUO+nuDSFhZn6utOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.186
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
Subject: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
Date: Wed, 13 Aug 2025 15:15:55 +0000
Message-ID: <20250813151614.12098-6-bcollins@watter.com>
In-Reply-To: <20250813151614.12098-1-bcollins@watter.com>
References: <20250813151614.12098-1-bcollins@watter.com>
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
 drivers/iio/temperature/mcp9600.c | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 5ead565f1bd8c..5bed3a35ae65e 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -31,6 +31,7 @@
 #define MCP9600_STATUS_ALERT(x)		BIT(x)
 #define MCP9600_SENSOR_CFG		0x5
 #define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
+#define MCP9600_FILTER_MASK		GENMASK(2, 0)
 #define MCP9600_ALERT_CFG1		0x8
 #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
 #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
@@ -111,6 +112,7 @@ static const struct iio_event_spec mcp9600_events[] = {
 			.address = MCP9600_HOT_JUNCTION,		       \
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
 					      BIT(IIO_CHAN_INFO_SCALE) |       \
+					      BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |  \
 					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
 			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
 			.num_event_specs = hj_num_ev,			       \
@@ -149,6 +151,7 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
 struct mcp9600_data {
 	struct i2c_client *client;
 	u32 thermocouple_type;
+	u32 filter_level;
 };
 
 static int mcp9600_read(struct mcp9600_data *data,
@@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
 		*val = mcp9600_tc_types[data->thermocouple_type];
 		return IIO_VAL_CHAR;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*val = data->filter_level;
+		return IIO_VAL_INT;
 
 	default:
 		return -EINVAL;
@@ -199,6 +205,7 @@ static int mcp9600_config(struct mcp9600_data *data)
 
 	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
 			  mcp9600_type_map[data->thermocouple_type]);
+	cfg |= FIELD_PREP(MCP9600_FILTER_MASK, data->filter_level);
 
 	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
 	if (ret < 0) {
@@ -209,6 +216,37 @@ static int mcp9600_config(struct mcp9600_data *data)
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
+
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (val < 0 || val > 7)
+			return -EINVAL;
+
+		data->filter_level = val;
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
@@ -346,6 +384,8 @@ static int mcp9600_write_thresh(struct iio_dev *indio_dev,
 
 static const struct iio_info mcp9600_info = {
 	.read_raw = mcp9600_read_raw,
+	.write_raw = mcp9600_write_raw,
+	.write_raw_get_fmt = mcp9600_write_raw_get_fmt,
 	.read_event_config = mcp9600_read_event_config,
 	.write_event_config = mcp9600_write_event_config,
 	.read_event_value = mcp9600_read_thresh,
@@ -501,6 +541,9 @@ static int mcp9600_probe(struct i2c_client *client)
 				     "Invalid thermocouple-type property %d.\n",
 				     data->thermocouple_type);
 
+	/* Default filter level of the chip is 0 (off) */
+	data->filter_level = 0;
+
 	/* Set initial config. */
 	ret = mcp9600_config(data);
 	if (ret < 0)
-- 
2.50.1


