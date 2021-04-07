Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8076357424
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355185AbhDGSWQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 14:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348459AbhDGSWQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 14:22:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E055C06175F;
        Wed,  7 Apr 2021 11:22:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w10so8205797pgh.5;
        Wed, 07 Apr 2021 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IGYZAVfgcsrU+ojtg5qL02pvo31P7Jjed2ZxYj9lsc=;
        b=sr+ODArPmC6mjBs94wSRaCVe7OAEvWQJAmcNXe8vwskK1zyik3V8bSPW1nIY8pFUcM
         iY6ZRyN7l9jS3TReKGJsPKXEg4MMY4eIAF4gdzV0sx71KXy0YuBotGt/zZkETnt6Lk3l
         1Yx7RZVCWh9naWX3Jitk/IkBOUXfQEe+2US1I2byOXUUhAEHNFtN3kLpg4FKXFoSvalX
         y6t+HrsqLZxWL5KT4GeBdDn9HU+ntH2ijQA5kPLdwXYT/6Z+9CeDQNJVZWrgzZySKSXk
         SBtHLqivmbJrh/JFBtMkyekTtRgc78Vtq3TCwwvQ1iZIMrmjJNEtlLu6xgi0LALVdS9x
         7e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IGYZAVfgcsrU+ojtg5qL02pvo31P7Jjed2ZxYj9lsc=;
        b=tURlZIIn8yDQctxOfmv9vuJdg4HTKcSG3txyoTLKJzV2aIl8V3hb51TTCfifPc0akR
         8CIe/MQT1tjuEX4in+PjkTwo+lNj0c027WBQblVUtGX8EmBx0o18UC/3LycXqzu5/Xrv
         32NugqH+tYJekpfP3gbP/bw3r9YHLrAWxaRNFKRLVjbvks6p+h2OTkzdY5q+wJTA7OEo
         2hPRq5FtkTSjmLJwIPhN19qPQWz64UVdMIxKwZxjOcYj0M6Oo8D0MOJSXUSQZIIxymtz
         m6h2r5U/HWPLIEaa04vTnNbOreDtM21HNpoc6AP/CCvb+49tsq+QPG2lsAHb8rwy9VWK
         fLHw==
X-Gm-Message-State: AOAM533f2sWOQnWS7bZ/Ww82wHt3OulqhItwwY/zNde1t3Hm9mnSY1oe
        08u1z9xmDuDZselYy3bHJ2c=
X-Google-Smtp-Source: ABdhPJy5b5rKKturLwWajYfoByEFBlDIXs/gNZiSmOk8tjBmuaJCyG1IEB4RGVflZq0yWj3GmJaN7Q==
X-Received: by 2002:a63:5725:: with SMTP id l37mr4534806pgb.422.1617819725701;
        Wed, 07 Apr 2021 11:22:05 -0700 (PDT)
Received: from localhost.localdomain ([49.156.71.81])
        by smtp.googlemail.com with ESMTPSA id q22sm20563015pfk.2.2021.04.07.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 11:22:05 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v4 2/2] iio: temperature: add driver support for ti tmp117
Date:   Wed,  7 Apr 2021 23:51:47 +0530
Message-Id: <20210407182147.77221-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210407182147.77221-1-puranjay12@gmail.com>
References: <20210407182147.77221-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

TMP117 is a Digital temperature sensor with integrated Non-Volatile memory.
Add support for tmp117 driver in iio subsystem.

Datasheet: https://www.ti.com/lit/gpn/tmp117
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 MAINTAINERS                      |   7 ++
 drivers/iio/temperature/Kconfig  |  10 ++
 drivers/iio/temperature/Makefile |   1 +
 drivers/iio/temperature/tmp117.c | 184 +++++++++++++++++++++++++++++++
 4 files changed, 202 insertions(+)
 create mode 100644 drivers/iio/temperature/tmp117.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 60ed2963e..c9b806b63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16666,6 +16666,13 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
 
+TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
+M:	Puranjay Mohan <puranjay12@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+F:	drivers/iio/temperature/tmp117.c
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index f1f2a1499..c5482983f 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -97,6 +97,16 @@ config TMP007
 	  This driver can also be built as a module. If so, the module will
 	  be called tmp007.
 
+config TMP117
+	tristate "TMP117 Digital temperature sensor with integrated NV memory"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Texas Instruments
+	  TMP117 Digital temperature sensor with integrated NV memory.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called tmp117.
+
 config TSYS01
 	tristate "Measurement Specialties TSYS01 temperature sensor using I2C bus connection"
 	depends on I2C
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 90c113115..e3392c4b2 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_TMP006) += tmp006.o
 obj-$(CONFIG_TMP007) += tmp007.o
+obj-$(CONFIG_TMP117) += tmp117.o
 obj-$(CONFIG_TSYS01) += tsys01.o
 obj-$(CONFIG_TSYS02D) += tsys02d.o
diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
new file mode 100644
index 000000000..e2536e53f
--- /dev/null
+++ b/drivers/iio/temperature/tmp117.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Digital temperature sensor with integrated Non-volatile memory
+ * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
+ *
+ * Driver for the Texas Instruments TMP117 Temperature Sensor
+ * (7-bit I2C slave address (0x48 - 0x4B), changeable via ADD pins)
+ *
+ * Note: This driver assumes that the sensor has been calibrated beforehand.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+
+#include <linux/iio/iio.h>
+
+#define TMP117_REG_TEMP			0x0
+#define TMP117_REG_CFGR			0x1
+#define TMP117_REG_HIGH_LIM		0x2
+#define TMP117_REG_LOW_LIM		0x3
+#define TMP117_REG_EEPROM_UL		0x4
+#define TMP117_REG_EEPROM1		0x5
+#define TMP117_REG_EEPROM2		0x6
+#define TMP117_REG_TEMP_OFFSET		0x7
+#define TMP117_REG_EEPROM3		0x8
+#define TMP117_REG_DEVICE_ID		0xF
+
+#define TMP117_RESOLUTION_10UC		78125
+#define TMP117_DEVICE_ID		0x0117
+#define MICRODEGREE_PER_10MILLIDEGREE	10000
+
+struct tmp117_data {
+	struct i2c_client *client;
+	s16 calibbias;
+};
+
+static int tmp117_read_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *channel, int *val,
+		int *val2, long mask)
+{
+	struct tmp117_data *data = iio_priv(indio_dev);
+	s32 ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = i2c_smbus_read_word_swapped(data->client,
+						TMP117_REG_TEMP);
+		if (ret < 0)
+			return ret;
+		*val = sign_extend32(ret, 15);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = i2c_smbus_read_word_swapped(data->client,
+					TMP117_REG_TEMP_OFFSET);
+		if (ret < 0)
+			return ret;
+		*val = sign_extend32(ret, 15);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/* Conversion from 10s of uC to mC
+		 * as IIO reports temperature in mC
+		 */
+		*val = TMP117_RESOLUTION_10UC / MICRODEGREE_PER_10MILLIDEGREE;
+		*val2 = (TMP117_RESOLUTION_10UC %
+					MICRODEGREE_PER_10MILLIDEGREE) * 100;
+
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tmp117_write_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *channel, int val,
+		int val2, long mask)
+{
+	struct tmp117_data *data = iio_priv(indio_dev);
+	s16 off;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		off = clamp(val, S16_MIN, S16_MAX);
+		if (off == data->calibbias)
+			return 0;
+		data->calibbias = off;
+		return i2c_smbus_write_word_swapped(data->client,
+						TMP117_REG_TEMP_OFFSET, off);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec tmp117_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static const struct iio_info tmp117_info = {
+	.read_raw = tmp117_read_raw,
+	.write_raw = tmp117_write_raw,
+};
+
+static int tmp117_identify(struct i2c_client *client)
+{
+	int dev_id;
+
+	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
+	if (dev_id < 0)
+		return dev_id;
+	if (dev_id != TMP117_DEVICE_ID) {
+		dev_err(&client->dev, "TMP117 not found\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static int tmp117_probe(struct i2c_client *client)
+{
+	struct tmp117_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	ret = tmp117_identify(client);
+	if (ret < 0)
+		return ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->calibbias = 0;
+
+	indio_dev->name = "tmp117";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &tmp117_info;
+
+	indio_dev->channels = tmp117_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct of_device_id tmp117_of_match[] = {
+	{ .compatible = "ti,tmp117", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tmp117_of_match);
+
+static const struct i2c_device_id tmp117_id[] = {
+	{ "tmp117", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tmp117_id);
+
+static struct i2c_driver tmp117_driver = {
+	.driver = {
+		.name	= "tmp117",
+		.of_match_table = tmp117_of_match,
+	},
+	.probe_new	= tmp117_probe,
+	.id_table	= tmp117_id,
+};
+module_i2c_driver(tmp117_driver);
+
+MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
+MODULE_DESCRIPTION("TI TMP117 Temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.30.1

