Return-Path: <linux-iio+bounces-19192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351AAABE10
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12AD4E3B7E
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53836264A9F;
	Tue,  6 May 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHKXg0tY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02119262FCB;
	Tue,  6 May 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522092; cv=none; b=UkPWtv0ocXYOG6f0W0+DUlhZP5Vl6/Cm/BmoZGuFCwdxdMDYlmvSoFkEBLx6ZtaEqlUyIB7ZEdqo6vwDGvukoNagpcubWfcQcQ+vy8Psk90hCjG08pOycpbrI5kdTDJPNtijqmi4TwY3IgKvr+Tc2VxdhxzM2NfeIUDrFad6AfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522092; c=relaxed/simple;
	bh=nw6d/SZSKNLBkkU8aJfTtZbRWP1PXjimyeHTGPVYBYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vr5/FH4QbAiHILCCn9s91AEoQWqX1sZXXL3dLoo9RMuZ7AaOOm5+YrImb6nZkiYRgr+x/sIAYycR7NHHdUX/ldPKIhBsXO4p+oRI/yttBcFNCLxbIk68DbJ4t1DJjpjojWMvt+i9AMrbbLb7SLO3JuPNZ5Ss++tEf8meZNt4E5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHKXg0tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71F84C4CEED;
	Tue,  6 May 2025 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746522091;
	bh=nw6d/SZSKNLBkkU8aJfTtZbRWP1PXjimyeHTGPVYBYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oHKXg0tY4u+3+W0qrYJ/oLIdyex39OiiWr9mDuj79f4nxW6puaOLnQVYBbrTXzYm5
	 dMkvO8vyIs8Uy77/dDEDbaYqMyio3a8kgixlMk5ng/bq6dnEW8cBaTTJJTSL+DsrjM
	 DgqWPDXojCBEcs2mEl6b8ccNJ5qNuB5dcU8lwncySjJzKmjmKSnvYtDqihciNe+Jwl
	 Svq9Y7LGafp2vPOQtmuh9WoIirKKwtj7BmycEAtazSwwGz8JqZi44bt++V0+E8420F
	 w6lHTi0/Ascdldhcr+mLEw0bHu8y6gKgu13nOcJirJNi2KXqKRzqN1EoaBQCEUL1Df
	 Y5ou1tJtRSzOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E98C3ABC3;
	Tue,  6 May 2025 09:01:31 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Date: Tue, 06 May 2025 11:01:16 +0200
Subject: [PATCH v4 2/2] iio: chemical: Add driver for SEN0322
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250506-iio-chemical-sen0322-v4-2-1465ac8dc190@gmail.com>
References: <20250506-iio-chemical-sen0322-v4-0-1465ac8dc190@gmail.com>
In-Reply-To: <20250506-iio-chemical-sen0322-v4-0-1465ac8dc190@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746522090; l=6662;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=+Ezp/DsTUmLfMfPAYh8WgNX/9ol2LZWhHTJ8ACAmRtg=;
 b=aMEQUwFvHlkNzOT8e93+ZxqWL1pHUg7JyEr7k76xhaiaIJKqVnvqvOZRtqjNDGqqkxG1LYWS0
 Su0Ws1cHlNZDTtxeCxvJblQVJWa+GuBCXcTZHzspLf5C9NuxUkeOEnN
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with
 auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: gomba007@gmail.com

From: Tóth János <gomba007@gmail.com>

Add support for the DFRobot SEN0322 oxygen sensor.

To instantiate (assuming device is connected to I2C-2):
	echo 'sen0322 0x73' > /sys/class/i2c-dev/i2c-2/device/new_device

To get the oxygen concentration (assuming device is iio:device0) multiply
the values read from:
	/sys/bus/iio/devices/iio:device0/in_concentration_raw
	/sys/bus/iio/devices/iio:device0/in_concentration_scale

Datasheet: https://wiki.dfrobot.com/Gravity_I2C_Oxygen_Sensor_SKU_SEN0322

Signed-off-by: Tóth János <gomba007@gmail.com>
---
 MAINTAINERS                    |   6 ++
 drivers/iio/chemical/Kconfig   |  10 +++
 drivers/iio/chemical/Makefile  |   1 +
 drivers/iio/chemical/sen0322.c | 163 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cbf9ac0d83f..6fda7a2f1248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6852,6 +6852,12 @@ L:	linux-rtc@vger.kernel.org
 S:	Maintained
 F:	drivers/rtc/rtc-sd2405al.c
 
+DFROBOT SEN0322 DRIVER
+M:	Tóth János <gomba007@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/chemical/sen0322.c
+
 DH ELECTRONICS DHSOM SOM AND BOARD SUPPORT
 M:	Christoph Niedermaier <cniedermaier@dh-electronics.com>
 M:	Marek Vasut <marex@denx.de>
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 330fe0af946f..60a81863d123 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -166,6 +166,16 @@ config SCD4X
 	  To compile this driver as a module, choose M here: the module will
 	  be called scd4x.
 
+config SEN0322
+	tristate "SEN0322 oxygen sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to build support for the DFRobot SEN0322 oxygen sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called sen0322.
+
 config SENSIRION_SGP30
 	tristate "Sensirion SGPxx gas sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 4866db06bdc9..deeff0e4e6f7 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SCD30_CORE) += scd30_core.o
 obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
 obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
 obj-$(CONFIG_SCD4X) += scd4x.o
+obj-$(CONFIG_SEN0322)	+= sen0322.o
 obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SENSIRION_SGP40)	+= sgp40.o
diff --git a/drivers/iio/chemical/sen0322.c b/drivers/iio/chemical/sen0322.c
new file mode 100644
index 000000000000..088f8947083e
--- /dev/null
+++ b/drivers/iio/chemical/sen0322.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the DFRobot SEN0322 oxygen sensor.
+ *
+ * Datasheet:
+ *	https://wiki.dfrobot.com/Gravity_I2C_Oxygen_Sensor_SKU_SEN0322
+ *
+ * Possible I2C slave addresses:
+ *	0x70
+ *	0x71
+ *	0x72
+ *	0x73
+ *
+ * Copyright (C) 2025 Tóth János <gomba007@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+
+#define SEN0322_REG_DATA	0x03
+#define SEN0322_REG_COEFF	0x0A
+
+struct sen0322 {
+	struct regmap	*regmap;
+};
+
+static int sen0322_read_data(struct sen0322 *sen0322)
+{
+	u8 data[3] = { 0 };
+	int ret;
+
+	ret = regmap_bulk_read(sen0322->regmap, SEN0322_REG_DATA, data,
+			       sizeof(data));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The actual value in the registers is:
+	 *	val = data[0] + data[1] / 10 + data[2] / 100
+	 * but it is multiplied by 100 here to avoid floating-point math
+	 * and the scale is divided by 100 to compensate this.
+	 */
+	ret = data[0] * 100 + data[1] * 10 + data[2];
+
+	return ret;
+}
+
+static int sen0322_read_scale(struct sen0322 *sen0322, int *num, int *den)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(sen0322->regmap, SEN0322_REG_COEFF, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val) {
+		*num = val;
+		*den = 100000;	/* Coeff is scaled by 1000 at calibration. */
+	} else { /* The device is not calibrated, using the factory-defaults. */
+		*num = 209;	/* Oxygen content in the atmosphere is 20.9%. */
+		*den = 120000;	/* Output of the sensor at 20.9% is 120 uA. */
+	}
+
+	dev_dbg(regmap_get_device(sen0322->regmap), "scale: %d/%d\n",
+		*num, *den);
+
+	return 0;
+}
+
+static int sen0322_read_raw(struct iio_dev *iio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct sen0322 *sen0322 = iio_priv(iio_dev);
+	int ret;
+
+	if (chan->type != IIO_CONCENTRATION)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = sen0322_read_data(sen0322);
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = sen0322_read_scale(sen0322, val, val2);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info sen0322_info = {
+	.read_raw = sen0322_read_raw,
+};
+
+static const struct regmap_config sen0322_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct iio_chan_spec sen0322_channel = {
+	.type = IIO_CONCENTRATION,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE),
+};
+
+static int sen0322_probe(struct i2c_client *client)
+{
+	struct sen0322 *sen0322;
+	struct iio_dev *iio_dev;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sen0322));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	sen0322 = iio_priv(iio_dev);
+
+	sen0322->regmap = devm_regmap_init_i2c(client, &sen0322_regmap_conf);
+	if (IS_ERR(sen0322->regmap))
+		return PTR_ERR(sen0322->regmap);
+
+	iio_dev->info = &sen0322_info;
+	iio_dev->name = "sen0322";
+	iio_dev->channels = &sen0322_channel;
+	iio_dev->num_channels = 1;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&client->dev, iio_dev);
+}
+
+static const struct of_device_id sen0322_of_match[] = {
+	{ .compatible = "dfrobot,sen0322" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sen0322_of_match);
+
+static struct i2c_driver sen0322_driver = {
+	.driver = {
+		.name = "sen0322",
+		.of_match_table = sen0322_of_match,
+	},
+	.probe = sen0322_probe,
+};
+module_i2c_driver(sen0322_driver);
+
+MODULE_AUTHOR("Tóth János <gomba007@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SEN0322 oxygen sensor driver");

-- 
2.34.1



