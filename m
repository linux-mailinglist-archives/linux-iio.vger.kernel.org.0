Return-Path: <linux-iio+bounces-23023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E021EB2D054
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 01:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578EF3BC6C0
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 23:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71EF21B905;
	Tue, 19 Aug 2025 23:45:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62932222B4;
	Tue, 19 Aug 2025 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755647116; cv=none; b=CRQbEWozTJCHrtbe1FYKekyWhO8D+fq6R/Wi5vhYKyIiKIv6VPs29TzKDYxzyLok0OCy7+4UMDzKy09dHMMDnjQrTB14tQ1URH5Ao8u3SLIdSX4gXYlWRFuQDUZj1I9UFwXCMTj4V048y1mpYbYwBxhZ7vJkb3isUZPdgjXdEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755647116; c=relaxed/simple;
	bh=o4xhybGLiYeo9HSG8QGmk5mTIUGqeV/gTxlf/i14Mtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTJAmEdxyfYwymAYiKQEkSnX+l4ZSoyImRMzjLGZknAnTruldrpPFSpL3v3OG8bUB3gwmgOyBt89WbA5+QBZXRIJt5fWoja3oVBckOg8zUya2JSS0drdtpxvkAdyqlnrIOX0FhaRLl2xQbp5xYoOvPJqsZ8nyaJHqn+BVpTBvgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
Date: Tue, 19 Aug 2025 19:44:45 -0400
Subject: [PATCH v7 4/5] iio: mcp9600: Recognize chip id for mcp9601
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-upstream-changes-v7-4-88a33aa78f6a@watter.com>
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

The current driver works with mcp9601, but emits a warning because it
does not recognize the chip id.

MCP9601 is a superset of MCP9600. The drivers works without changes
on this chipset.

However, the 9601 chip supports open/closed-circuit detection if wired
properly, so we'll need to be able to differentiate between them.

Moved "struct mcp9600_data" up in the file since a later patch will
need it and chip_info before the declerations.

Signed-off-by: Ben Collins <bcollins@watter.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/temperature/Kconfig   |  8 +++--
 drivers/iio/temperature/mcp9600.c | 63 ++++++++++++++++++++++++++++++---------
 2 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 1244d8e17d50..9328b2250ace 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -173,11 +173,13 @@ config MAX31865
 	  will be called max31865.
 
 config MCP9600
-	tristate "MCP9600 thermocouple EMF converter"
+	tristate "MCP9600 and similar thermocouple EMF converters"
 	depends on I2C
 	help
-	  If you say yes here you get support for MCP9600
-	  thermocouple EMF converter connected via I2C.
+	  If you say yes here you get support for...
+	  - MCP9600
+	  - MCP9601
+	  ...thermocouple EMF converters connected via I2C.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp9600.
diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 40906bb200ec..4654b3aaaf2a 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -42,6 +42,7 @@
 
 /* MCP9600 device id value */
 #define MCP9600_DEVICE_ID_MCP9600	0x40
+#define MCP9600_DEVICE_ID_MCP9601	0x41
 
 #define MCP9600_ALERT_COUNT		4
 
@@ -82,6 +83,15 @@ static const struct iio_event_spec mcp9600_events[] = {
 	},
 };
 
+struct mcp_chip_info {
+	u8 chip_id;
+	const char *chip_name;
+};
+
+struct mcp9600_data {
+	struct i2c_client *client;
+};
+
 #define MCP9600_CHANNELS(hj_num_ev, hj_ev_spec_off, cj_num_ev, cj_ev_spec_off) \
 	{								       \
 		{							       \
@@ -123,10 +133,6 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
 	MCP9600_CHANNELS(2, 0, 2, 0), /* Alerts: 1 2 3 4 */
 };
 
-struct mcp9600_data {
-	struct i2c_client *client;
-};
-
 static int mcp9600_read(struct mcp9600_data *data,
 			struct iio_chan_spec const *chan, int *val)
 {
@@ -416,16 +422,33 @@ static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
 
 static int mcp9600_probe(struct i2c_client *client)
 {
+	const struct mcp_chip_info *chip_info = i2c_get_match_data(client);
 	struct iio_dev *indio_dev;
 	struct mcp9600_data *data;
-	int ret, ch_sel;
+	int ch_sel, dev_id, ret;
+
+	if (!chip_info)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "No chip-info found for device\n");
+
+	dev_id = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
+	if (dev_id < 0)
+		return dev_err_probe(&client->dev, dev_id,
+				     "Failed to read device ID\n");
+
+	switch (dev_id) {
+	case MCP9600_DEVICE_ID_MCP9600:
+	case MCP9600_DEVICE_ID_MCP9601:
+		if (dev_id != chip_info->chip_id)
+			dev_warn(&client->dev,
+				 "Expected id %02x, but device responded with %02x\n",
+				 chip_info->chip_id, dev_id);
+		break;
 
-	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
-	if (ret < 0)
-		return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");
-	if (ret != MCP9600_DEVICE_ID_MCP9600)
-		dev_warn(&client->dev, "Expected ID %x, got %x\n",
-				MCP9600_DEVICE_ID_MCP9600, ret);
+	default:
+		dev_warn(&client->dev, "Unknown id %x, using %x\n", dev_id,
+			 chip_info->chip_id);
+	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -439,7 +462,7 @@ static int mcp9600_probe(struct i2c_client *client)
 		return ch_sel;
 
 	indio_dev->info = &mcp9600_info;
-	indio_dev->name = "mcp9600";
+	indio_dev->name = chip_info->chip_name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mcp9600_channels[ch_sel];
 	indio_dev->num_channels = ARRAY_SIZE(mcp9600_channels[ch_sel]);
@@ -447,14 +470,26 @@ static int mcp9600_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct mcp_chip_info mcp9600_chip_info = {
+	.chip_id   = MCP9600_DEVICE_ID_MCP9600,
+	.chip_name = "mcp9600",
+};
+
+static const struct mcp_chip_info mcp9601_chip_info = {
+	.chip_id   = MCP9600_DEVICE_ID_MCP9601,
+	.chip_name = "mcp9601",
+};
+
 static const struct i2c_device_id mcp9600_id[] = {
-	{ "mcp9600" },
+	{ "mcp9600", .driver_data = (kernel_ulong_t)&mcp9600_chip_info },
+	{ "mcp9601", .driver_data = (kernel_ulong_t)&mcp9601_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp9600_id);
 
 static const struct of_device_id mcp9600_of_match[] = {
-	{ .compatible = "microchip,mcp9600" },
+	{ .compatible = "microchip,mcp9600", .data = &mcp9600_chip_info },
+	{ .compatible = "microchip,mcp9601", .data = &mcp9601_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp9600_of_match);

-- 
2.39.5


