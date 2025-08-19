Return-Path: <linux-iio+bounces-23025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A39B2D05C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 01:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4F66875F0
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 23:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421FF27B34B;
	Tue, 19 Aug 2025 23:45:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB6277CB6
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647119; cv=none; b=Z9GBILRNMW9dPRbVfhRe3YlUAehldGj19FvpVOF1L4HSYxwfSKFuObIM2xTJ4fNXZbSYPrUSGGL0U4EwF/Z5d6JhA17JBeOyY9NslgsIroXdJiWMME8MZ4HtmKBvdpnRMvx5ZjIlnvReNZ3y07fRi+OUi2eSbsBzKlTzwE4qang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647119; c=relaxed/simple;
	bh=Kbg4kCcOfqnSkOACGBz38mpEKOLEwmk7jtHfzfX9H70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFeSyOMwIh8nbmuDEYv2N56paZBR1c16JZ0NnK47zyfg+u2r8hK6RQ4U+Qt/3RTsFEBYHgtS6dpmWtT0uAiWmzIcHJkrlbr5zW7dcvXK7BitBFmc8jcK0FIclAoD9/XKcFQP4DjsSj+/mtcG+EB6366kMtegNb1OJEm3kNwZgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
Date: Tue, 19 Aug 2025 19:44:46 -0400
Subject: [PATCH v7 5/5] iio: mcp9600: Add support for thermocouple-type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-upstream-changes-v7-5-88a33aa78f6a@watter.com>
References: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com>
In-Reply-To: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Collins <bcollins@watter.com>
X-Migadu-Flow: FLOW_OUT

dt-bindings documentation for this driver claims to support
thermocouple-type, but the driver does not actually make use of
the property.

Implement usage of the property to configure the chip for the
selected thermocouple-type.

Signed-off-by: Ben Collins <bcollins@watter.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/temperature/mcp9600.c | 69 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 4654b3aaaf2a..cd46f48e47d6 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -22,11 +22,15 @@
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
+#include <dt-bindings/iio/temperature/thermocouple.h>
+
 /* MCP9600 registers */
 #define MCP9600_HOT_JUNCTION		0x00
 #define MCP9600_COLD_JUNCTION		0x02
 #define MCP9600_STATUS			0x04
 #define MCP9600_STATUS_ALERT(x)		BIT(x)
+#define MCP9600_SENSOR_CFG		0x05
+#define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
 #define MCP9600_ALERT_CFG1		0x08
 #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
 #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
@@ -66,6 +70,30 @@ static const char * const mcp9600_alert_name[MCP9600_ALERT_COUNT] = {
 	[MCP9600_ALERT4] = "alert4",
 };
 
+/* Map between dt-bindings enum and the chip's type value */
+static const unsigned int mcp9600_type_map[] = {
+	[THERMOCOUPLE_TYPE_K] = 0,
+	[THERMOCOUPLE_TYPE_J] = 1,
+	[THERMOCOUPLE_TYPE_T] = 2,
+	[THERMOCOUPLE_TYPE_N] = 3,
+	[THERMOCOUPLE_TYPE_S] = 4,
+	[THERMOCOUPLE_TYPE_E] = 5,
+	[THERMOCOUPLE_TYPE_B] = 6,
+	[THERMOCOUPLE_TYPE_R] = 7,
+};
+
+/* Map thermocouple type to a char for iio info in sysfs */
+static const int mcp9600_tc_types[] = {
+	[THERMOCOUPLE_TYPE_K] = 'K',
+	[THERMOCOUPLE_TYPE_J] = 'J',
+	[THERMOCOUPLE_TYPE_T] = 'T',
+	[THERMOCOUPLE_TYPE_N] = 'N',
+	[THERMOCOUPLE_TYPE_S] = 'S',
+	[THERMOCOUPLE_TYPE_E] = 'E',
+	[THERMOCOUPLE_TYPE_B] = 'B',
+	[THERMOCOUPLE_TYPE_R] = 'R',
+};
+
 static const struct iio_event_spec mcp9600_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -90,14 +118,34 @@ struct mcp_chip_info {
 
 struct mcp9600_data {
 	struct i2c_client *client;
+	u32 thermocouple_type;
 };
 
+static int mcp9600_config(struct mcp9600_data *data)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+	u8 cfg;
+
+	cfg  = FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
+			  mcp9600_type_map[data->thermocouple_type]);
+
+	ret = i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to set sensor configuration\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 #define MCP9600_CHANNELS(hj_num_ev, hj_ev_spec_off, cj_num_ev, cj_ev_spec_off) \
 	{								       \
 		{							       \
 			.type = IIO_TEMP,				       \
 			.address = MCP9600_HOT_JUNCTION,		       \
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
+					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE) | \
 					      BIT(IIO_CHAN_INFO_SCALE),	       \
 			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
 			.num_event_specs = hj_num_ev,			       \
@@ -165,6 +213,9 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 		*val = 62;
 		*val2 = 500000;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+		*val = mcp9600_tc_types[data->thermocouple_type];
+		return IIO_VAL_CHAR;
 	default:
 		return -EINVAL;
 	}
@@ -457,6 +508,24 @@ static int mcp9600_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->client = client;
 
+	/* Accept type from dt with default of Type-K. */
+	data->thermocouple_type = THERMOCOUPLE_TYPE_K;
+	ret = device_property_read_u32(&client->dev, "thermocouple-type",
+				       &data->thermocouple_type);
+	if (ret < 0 && ret != -EINVAL)
+		return dev_err_probe(&client->dev, ret,
+				     "Error reading thermocouple-type property\n");
+
+	if (data->thermocouple_type >= ARRAY_SIZE(mcp9600_type_map))
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Invalid thermocouple-type property %u.\n",
+				     data->thermocouple_type);
+
+	/* Set initial config. */
+	ret = mcp9600_config(data);
+	if (ret < 0)
+		return ret;
+
 	ch_sel = mcp9600_probe_alerts(indio_dev);
 	if (ch_sel < 0)
 		return ch_sel;

-- 
2.39.5


