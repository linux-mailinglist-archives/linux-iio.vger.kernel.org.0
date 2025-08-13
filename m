Return-Path: <linux-iio+bounces-22672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0CB24D3C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E28B3BE289
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685491F12E9;
	Wed, 13 Aug 2025 15:17:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DC1EF38F
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098228; cv=none; b=EugFsnOW91W8IxOfDWN7HQY0z9+DlfVnu2sbbYsk15S31lhd+Sfh6KOy/K7s4AZj3BtplOvJhBvHTtGuhl8K2cbIEV5eJPhdgQ3XOqHoczxSaqolmuhMombWJ48JRuVpE3aHhshTDW/YP1wuhN5inITmc/j881r8gwTMRZ/0gAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098228; c=relaxed/simple;
	bh=wnzAn/fAPircupLsGVbotQzAckt8x9hpr/uYd4YwgJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNDJbG9d12OTGUa5toEp9KjDKp8GU6kp4attbY3gq4RUPS3xa9Dw984yuyBi3f4Vb2xBu57uvvuSz7okvm9tfxpMV3KbP7/zUY5UY8RrA9Pj+mJEPcHOf1XI2MzXbqVz1wZ7+RR1L72H872HPBwnja4Va/VY3t46u58ShEyPfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.177
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
Subject: [PATCH v2 3/5] iio: mcp9600: Add compatibility for mcp9601
Date: Wed, 13 Aug 2025 15:15:53 +0000
Message-ID: <20250813151614.12098-4-bcollins@watter.com>
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

MCP9601 is a super set of MCP9600. The drivers works without changes
on this chipset.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 drivers/iio/temperature/Kconfig   |  6 +++---
 drivers/iio/temperature/mcp9600.c | 31 +++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 1244d8e17d504..2a5d04b1d1c87 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -173,11 +173,11 @@ config MAX31865
 	  will be called max31865.
 
 config MCP9600
-	tristate "MCP9600 thermocouple EMF converter"
+	tristate "MCP9600 and similar thermocouple EMF converters"
 	depends on I2C
 	help
-	  If you say yes here you get support for MCP9600
-	  thermocouple EMF converter connected via I2C.
+	  If you say yes here you get support for MCP9600, MCP9601, and
+	  similar thermocouple EMF converters connected via I2C.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp9600.
diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index d53703c089031..104bc83de6da7 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -42,6 +42,7 @@
 
 /* MCP9600 device id value */
 #define MCP9600_DEVICE_ID_MCP9600	0x40
+#define MCP9600_DEVICE_ID_MCP9601	0x41
 
 #define MCP9600_ALERT_COUNT		4
 
@@ -418,14 +419,26 @@ static int mcp9600_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct mcp9600_data *data;
-	int ret, ch_sel;
+	int ret, ch_sel, dev_id;
+
+	dev_id = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
+	if (dev_id < 0)
+		return dev_err_probe(&client->dev, dev_id,
+				     "Failed to read device ID\n");
+
+	switch (dev_id) {
+	case MCP9600_DEVICE_ID_MCP9600:
+	case MCP9600_DEVICE_ID_MCP9601:
+		if (dev_id != id->driver_data)
+			dev_warn(&client->dev,
+				 "Expected id %x but detected %x. Ensure dt is correct\n",
+				 (u8)id->driver_data, (u8)dev_id);
+		break;
 
-	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
-	if (ret < 0)
-		return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");
-	if (ret != MCP9600_DEVICE_ID_MCP9600)
-		dev_warn(&client->dev, "Expected ID %x, got %x\n",
-				MCP9600_DEVICE_ID_MCP9600, ret);
+	default:
+		dev_warn(&client->dev, "Unknown id %x, using %x\n", (u8)dev_id,
+			(u8)id->driver_data);
+	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -448,13 +461,15 @@ static int mcp9600_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mcp9600_id[] = {
-	{ "mcp9600" },
+	{ "mcp9600", MCP9600_DEVICE_ID_MCP9600 },
+	{ "mcp9601", MCP9600_DEVICE_ID_MCP9601 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp9600_id);
 
 static const struct of_device_id mcp9600_of_match[] = {
 	{ .compatible = "microchip,mcp9600" },
+	{ .compatible = "microchip,mcp9601" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp9600_of_match);
-- 
2.50.1


