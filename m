Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D94342BC2
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 12:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCTLMi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 07:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCTLM0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 07:12:26 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BBAC05BD11;
        Sat, 20 Mar 2021 04:11:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x26so7674932pfn.0;
        Sat, 20 Mar 2021 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bzk3gv3neOHFmq66OkXdKmbZpftj7BOZ5l77TBbGY94=;
        b=rhUTZS8YqCUXMYjfPPXrM1TnN7x3rop1/Wl8sCSZ9mKxlmKGTwBm4Y8j7etds+P9XT
         2kpYPhBWkiRxh2xi6FIoHa3H8SxYPIAl1oJIyzvW7MKLOWp1RrLio3hqJq632NSCNOxC
         zFwXsKiWAHyB6plRHs4KMl8xAS9Zl3YRVoguKNMVB0N5heLS0Mkr/HkCGzszJ7SOomc+
         vYtez6uJSmeyBPiyh0rSDsFP0mtfzsXW1P3thWTKDNoZjDrEqkdzAKw2EbMCriUZ40kc
         YFpHP7VWgrbshBjzdc2YNd69mVC606PExIXbS7FCXBLpbysU1LyY57adSttoGg9IpXsW
         P3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bzk3gv3neOHFmq66OkXdKmbZpftj7BOZ5l77TBbGY94=;
        b=rdNC/SZz3hy1XIgt0qrGF1WKppt8NqTZ1POWsseHqzYa11LNeoe6HOgfXrmb0XY2vw
         joYTwhiIVeiCDg1RN+03zR/VV544zvwi88flVT3PlE7DBMGU2ZOlOuMqwMjyfLuR1Rwa
         8UKJxG8k9FsyYlPcdSfLRJTEWjmGX1486qfn8fh0J4oJITM0VscAchMNaLZgvsRdts2y
         3s3UN5iaIN8TrCS9I+TdC0wdyldbIHO1MMl1uqDGTmF/ost+A5d05FK/Lu/NYTRVn/KV
         4m7cIjdQBAvK42HPBwARGPctpeG9Cs+KtjsDR2mMlKZl2/Bf7+AJHv7lFWZSZNKkdW8m
         NNxQ==
X-Gm-Message-State: AOAM5306BSXzKbRAQEF2y5iME5WAAgCjvAc2Nd6fzD/czLsMtAPu5hz1
        QwfGRkgomhtynNlZURAUws7tmKTHDVxCzw==
X-Google-Smtp-Source: ABdhPJwD/pukcp33GPw+UUEfS1fHczAzJFx4vEaIACljNQo0OSvd1kKYTy7dfcF4ePCrFToGLax3aQ==
X-Received: by 2002:a62:5b43:0:b029:1ef:21ad:846 with SMTP id p64-20020a625b430000b02901ef21ad0846mr12690031pfb.51.1616222725402;
        Fri, 19 Mar 2021 23:45:25 -0700 (PDT)
Received: from localhost.localdomain ([27.255.177.158])
        by smtp.googlemail.com with ESMTPSA id f15sm7237887pgr.90.2021.03.19.23.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 23:45:24 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v1 2/2] iio: temperature: add driver support for ti tmp117
Date:   Sat, 20 Mar 2021 12:15:09 +0530
Message-Id: <20210320064509.119878-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210320064509.119878-1-puranjay12@gmail.com>
References: <20210320064509.119878-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

TMP117 is a Digital temperature sensor with integrated NV memory.

Add support for tmp117 driver in iio subsystem.

Datasheet:-https://www.ti.com/lit/gpn/tmp117

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 drivers/iio/temperature/Kconfig  |  10 ++
 drivers/iio/temperature/Makefile |   1 +
 drivers/iio/temperature/tmp117.c | 182 +++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/iio/temperature/tmp117.c

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
index 000000000..194820700
--- /dev/null
+++ b/drivers/iio/temperature/tmp117.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * tmp117.c - Digital temperature sensor with integrated NV memory
+ *
+ * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
+ *
+ * Driver for the Texas Instruments TMP117 Temperature Sensor
+ *
+ * (7-bit I2C slave address (0x48 - 0x4B), changeable via ADD pins)
+ *
+ * Note: This driver assumes that the sensor has been calibrated beforehand.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/of.h>
+#include <linux/irq.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
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
+#define TMP117_SCALE			7812500       /* in uCelsius*/
+#define TMP117_RESOLUTION		78125
+#define TMP117_DEVICE_ID		0x0117
+
+struct tmp117_data {
+	struct i2c_client *client;
+	struct mutex lock;
+};
+
+static int tmp117_read_reg(struct tmp117_data *data, u8 reg)
+{
+	return i2c_smbus_read_word_swapped(data->client, reg);
+}
+
+static int tmp117_write_reg(struct tmp117_data *data, u8 reg, int val)
+{
+	return i2c_smbus_write_word_swapped(data->client, reg, val);
+}
+
+static int tmp117_read_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *channel, int *val,
+		int *val2, long mask)
+{
+	struct tmp117_data *data = iio_priv(indio_dev);
+	u16 tmp, off;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		tmp = tmp117_read_reg(data, TMP117_REG_TEMP);
+		*val = tmp;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+		off = tmp117_read_reg(data, TMP117_REG_TEMP_OFFSET);
+		*val = ((int16_t)off * (int32_t)TMP117_RESOLUTION) / 10000000;
+		*val2 = ((int16_t)off * (int32_t)TMP117_RESOLUTION) % 10000000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = TMP117_SCALE;
+		return IIO_VAL_INT_PLUS_NANO;
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
+	u16 off;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		off = ((val * 10000000) + (val2 * 10))
+						/ (int32_t)TMP117_RESOLUTION;
+		return tmp117_write_reg(data, TMP117_REG_TEMP_OFFSET, off);
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
+static bool tmp117_identify(struct i2c_client *client)
+{
+	int dev_id;
+
+	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
+	if (dev_id < 0)
+		return false;
+
+	return (dev_id == TMP117_DEVICE_ID);
+}
+
+static int tmp117_probe(struct i2c_client *client,
+			const struct i2c_device_id *tmp117_id)
+{
+	struct tmp117_data *data;
+	struct iio_dev *indio_dev;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	if (!tmp117_identify(client)) {
+		dev_err(&client->dev, "TMP117 not found\n");
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
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
+	{ },
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
+		.of_match_table = of_match_ptr(tmp117_of_match),
+	},
+	.probe		= tmp117_probe,
+	.id_table	= tmp117_id,
+};
+module_i2c_driver(tmp117_driver);
+
+MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
+MODULE_DESCRIPTION("TI TMP117 Temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.30.1

