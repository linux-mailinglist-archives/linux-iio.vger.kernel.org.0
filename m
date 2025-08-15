Return-Path: <linux-iio+bounces-22774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491AB28452
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7047B1D0425A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFC32145B;
	Fri, 15 Aug 2025 16:47:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C70321431
	for <linux-iio@vger.kernel.org>; Fri, 15 Aug 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276452; cv=none; b=JYixJlpnSzGcGxAinpNG2L6CyKZRjjvcdqnp7jqTiuVNhF5F029pxOVEkzIzn44SO9sETfCY8sU465+5RH1Y0gFRf/z9Pr3PuqV/jnrRdA3dIuOi+bnea4tssFM89ToOM90jvmJMP1EehYZKrt3JULU/nEu/1jVZ31r/Fj7Yoxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276452; c=relaxed/simple;
	bh=GnLf98a0XvBXfLq1B2oc1iFXcdrbZqoXmlyUC+Wy7h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6mDGTo4CIW4iHi696jI0NvemlXluHvQRMVzTyJL5Tkk8RaZ19h31/0kX3psM0jJC+nMmF5MkqICPA1Dm9rinc/gRrmIRDtre8rNFCpu1WKB6jc3KqFvw2Aa1wuwAeC7+/yKFS1XQH1lYGu2A3rrpH3LLoTFh7qWZ+McH6WNYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.188
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
Subject: [PATCH 3/5] iio: mcp9600: Recognize chip id for mcp9601
Date: Fri, 15 Aug 2025 16:46:05 +0000
Message-ID: <20250815164627.22002-4-bcollins@watter.com>
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

The current driver works with mcp9601, but emits a warning because it
does not recognize the chip id.

MCP9601 is a superset of MCP9600. The drivers works without changes
on this chipset.

However, the 9601 chip supports open/closed-circuit detection if wired
properly, so we'll need to be able to differentiate between them.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 drivers/iio/temperature/Kconfig   |  8 +++--
 drivers/iio/temperature/mcp9600.c | 51 +++++++++++++++++++++++++------
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 1244d8e17d504..e14ea6ebc7a24 100644
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
+	  If you say yes here you get support for:
+	  - MCP9600
+	  - MCP9601
+	  and similar thermocouple EMF converters connected via I2C.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp9600.
diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 40906bb200ec9..c18ae17b6d82f 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -42,6 +42,7 @@
 
 /* MCP9600 device id value */
 #define MCP9600_DEVICE_ID_MCP9600	0x40
+#define MCP9600_DEVICE_ID_MCP9601	0x41
 
 #define MCP9600_ALERT_COUNT		4
 
@@ -123,6 +124,11 @@ static const struct iio_chan_spec mcp9600_channels[][2] = {
 	MCP9600_CHANNELS(2, 0, 2, 0), /* Alerts: 1 2 3 4 */
 };
 
+struct mcp_chip_info {
+	u8 chip_id;
+	const char *chip_name;
+};
+
 struct mcp9600_data {
 	struct i2c_client *client;
 };
@@ -416,16 +422,29 @@ static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
 
 static int mcp9600_probe(struct i2c_client *client)
 {
+	const struct mcp_chip_info *chip_info = i2c_get_match_data(client);
 	struct iio_dev *indio_dev;
 	struct mcp9600_data *data;
-	int ret, ch_sel;
+	int ch_sel, dev_id, ret;
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
+				"Expected id %02x, but device responded with %02\n",
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
@@ -439,7 +458,7 @@ static int mcp9600_probe(struct i2c_client *client)
 		return ch_sel;
 
 	indio_dev->info = &mcp9600_info;
-	indio_dev->name = "mcp9600";
+	indio_dev->name = chip_info->chip_name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mcp9600_channels[ch_sel];
 	indio_dev->num_channels = ARRAY_SIZE(mcp9600_channels[ch_sel]);
@@ -447,14 +466,26 @@ static int mcp9600_probe(struct i2c_client *client)
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
2.50.1


