Return-Path: <linux-iio+bounces-22673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B7B24D30
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 17:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17411892B15
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B920B800;
	Wed, 13 Aug 2025 15:17:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E21F461A
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098232; cv=none; b=F1IRweefkNNUFGosLxOYRVzX/tDuQmcXJ9He9/OYaHejwlEHWR0eMDCc+j9mAZ20OlLTFp3O97xrFnHvW50bWcSHlL6zEO1oZevOcAnA6DZ3TCNhamtHLL+4AuVsVWpmxkoBUALR8ORYbPgNMzWU5QUzeZjQcbd/CaOj+9YJIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098232; c=relaxed/simple;
	bh=kY83MEA0MyYmUAF/l4YwMOoNdEjD5/JYM+v7+2fZNkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYw8PEyhqBDkJ5Wn3Za50RgZPELVl+xKiWBSMcz3ycGM6qFkzuY4j/o31oYNo1INIdTdqUsLZiPDK3dEMPh1zWxXDAq4LUXZHISM5v0J0BiJuIrYXW8St9OcPmgd7Gv+nUW53zSnrpU5uF8e92G7vQKKT8INk2VsTDeFliC/spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.181
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
Subject: [PATCH v2 4/5] iio: mcp9600: Add support for dtbinding of thermocouple-type
Date: Wed, 13 Aug 2025 15:15:54 +0000
Message-ID: <20250813151614.12098-5-bcollins@watter.com>
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

Adds dtbinding check for thermocouple-type and sets sensor config
to match. Add iio info attribute to show state as well.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 drivers/iio/temperature/mcp9600.c | 61 ++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 104bc83de6da7..5ead565f1bd8c 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -22,11 +22,15 @@
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 
+#include <dt-bindings/iio/temperature/thermocouple.h>
+
 /* MCP9600 registers */
 #define MCP9600_HOT_JUNCTION		0x0
 #define MCP9600_COLD_JUNCTION		0x2
 #define MCP9600_STATUS			0x4
 #define MCP9600_STATUS_ALERT(x)		BIT(x)
+#define MCP9600_SENSOR_CFG		0x5
+#define MCP9600_SENSOR_TYPE_MASK	GENMASK(6, 4)
 #define MCP9600_ALERT_CFG1		0x8
 #define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
 #define MCP9600_ALERT_CFG_ENABLE	BIT(0)
@@ -66,6 +70,23 @@ static const char * const mcp9600_alert_name[MCP9600_ALERT_COUNT] = {
 	[MCP9600_ALERT4] = "alert4",
 };
 
+/* Map dtbinding enums to mcp9600 sensor type */
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
+/* Map mcp9600 sensor type to char */
+static const int mcp9600_tc_types[] = {
+	'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'
+};
+
 static const struct iio_event_spec mcp9600_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -89,7 +110,8 @@ static const struct iio_event_spec mcp9600_events[] = {
 			.type = IIO_TEMP,				       \
 			.address = MCP9600_HOT_JUNCTION,		       \
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	       \
-					      BIT(IIO_CHAN_INFO_SCALE),	       \
+					      BIT(IIO_CHAN_INFO_SCALE) |       \
+					      BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE), \
 			.event_spec = &mcp9600_events[hj_ev_spec_off],	       \
 			.num_event_specs = hj_num_ev,			       \
 		},							       \
@@ -126,6 +148,7 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
 
 struct mcp9600_data {
 	struct i2c_client *client;
+	u32 thermocouple_type;
 };
 
 static int mcp9600_read(struct mcp9600_data *data,
@@ -160,11 +183,32 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 		*val = 62;
 		*val2 = 500000;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
+		*val = mcp9600_tc_types[data->thermocouple_type];
+		return IIO_VAL_CHAR;
+
 	default:
 		return -EINVAL;
 	}
 }
 
+static int mcp9600_config(struct mcp9600_data *data)
+{
+	struct i2c_client *client = data->client;
+	int ret, cfg;
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
 static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
 {
 	if (channel2 == IIO_MOD_TEMP_AMBIENT) {
@@ -417,6 +461,7 @@ static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
 
 static int mcp9600_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct iio_dev *indio_dev;
 	struct mcp9600_data *data;
 	int ret, ch_sel, dev_id;
@@ -447,6 +492,20 @@ static int mcp9600_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->client = client;
 
+	/* Accept type from dt with default of Type-K. */
+	data->thermocouple_type = THERMOCOUPLE_TYPE_K;
+	ret = device_property_read_u32(&client->dev, "thermocouple-type",
+				       &data->thermocouple_type);
+	if (data->thermocouple_type >= ARRAY_SIZE(mcp9600_type_map))
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "Invalid thermocouple-type property %d.\n",
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
2.50.1


