Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3C3426E7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 21:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhCSUaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhCSUa0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 16:30:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E4C06175F;
        Fri, 19 Mar 2021 13:30:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q5so6696435pfh.10;
        Fri, 19 Mar 2021 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5j0sTm2TZ+noRw1eX3qioz97sDkjolAFj+256L6lDMk=;
        b=iyGDOuGhbcCxvczX2Inm0CLvgmxLs+UkSfxbqFwVT17RlSyhYRUnDMMY5fHZsTqWrQ
         mh8uuor+rw7CAIB572NRn7FcksqbhCU3olOEtkRCDkqkh0Dfe5w3uWovrxM2iD+UA0bB
         17iEcijQWbf1aK9ACCEvmXXWTZrbUJbCMNKcE5XlgcX4Xw4o4xNTuqBBWjFqf+u6KUMN
         GXBV4PJ8jJqhLe54FxJstmV1yL9Q1CEmAFWFijA/PBjumrCpsd5+eep/Qu/+Jt7pvuKG
         rhEh+hGY7q+Gs2BEXOqCsYYJg+7Xx1D8Mc5m8OwZL05s9JGGej3uttZ3nZS/N6KyplIT
         k2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5j0sTm2TZ+noRw1eX3qioz97sDkjolAFj+256L6lDMk=;
        b=aIXGLnuZ6825NXFUSDEcFopXJBkSXdx6QjcDxgarzJBPTjUYyVsgqOQvrnLe0xTaQ9
         5/qVBau/aV6ZSils2ItRfMZ+uBXJhdDR2EtcPqIKjQk6zyCis2JIaQPWZPrnopETBdfY
         nS3cXbakt6wgUqkSPhbRlTmC3844YhalsYwUmJZIGxoQRxI3rtkojja5kaht2y+gQvhG
         IiDHhHbSFMFLb159MwToBH5Ddq4ueZOB/EY+kKgbNl010X6pxmzErTcehFWisMdPmJY0
         qarqsZtZJtV/eB88tOpofiGd/FcXkDYNZroQXKF4FA07S+V5v8U5Hy+aujGNw8FdU36U
         aLfA==
X-Gm-Message-State: AOAM533y4ll/8iWz4ZhdUDhKJFh4uIdo0UDnK8+AullJVmYgqvBrI47w
        UaQnu/cR6NoQ2jcdPPPjU/Q=
X-Google-Smtp-Source: ABdhPJy73E8p5mXusoQSDzuUfKMMe4UbwZ/pAPpFHXcvKnt54qvxT4EQMZ2WlST7oIv+3VVM9CJTfQ==
X-Received: by 2002:a63:fc12:: with SMTP id j18mr12885222pgi.334.1616185825647;
        Fri, 19 Mar 2021 13:30:25 -0700 (PDT)
Received: from localhost.localdomain ([27.255.182.86])
        by smtp.googlemail.com with ESMTPSA id m21sm6340406pff.61.2021.03.19.13.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:30:25 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 2/2] iio: temperature: add driver support for ti tmp117
Date:   Sat, 20 Mar 2021 02:00:07 +0530
Message-Id: <20210319203007.287802-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319203007.287802-1-puranjay12@gmail.com>
References: <20210319203007.287802-1-puranjay12@gmail.com>
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
 drivers/iio/temperature/Kconfig  |  11 ++
 drivers/iio/temperature/Makefile |   1 +
 drivers/iio/temperature/tmp117.c | 196 +++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 drivers/iio/temperature/tmp117.c

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 3f11ed870..200efc880 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -86,6 +86,17 @@ config TMP007
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
+
 config TSYS01
 	tristate "Measurement Specialties TSYS01 temperature sensor using I2C bus connection"
 	depends on I2C
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index e4e0bad5a..7f2a95ed2 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_TMP006) += tmp006.o
 obj-$(CONFIG_TMP007) += tmp007.o
+obj-$(CONFIG_TMP117) += tmp117.o
 obj-$(CONFIG_TSYS01) += tsys01.o
 obj-$(CONFIG_TSYS02D) += tsys02d.o
 obj-$(CONFIG_LTC2983) += ltc2983.o
diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
new file mode 100644
index 000000000..15cdf590e
--- /dev/null
+++ b/drivers/iio/temperature/tmp117.c
@@ -0,0 +1,196 @@
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
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/bitops.h>
+#include <linux/of.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
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
+#define TMP117_REG_EEPROM3		0x7
+#define TMP117_REG_TEMP_OFFSET		0x7
+#define TMP117_REG_EEPROM4		0x8
+#define TMP117_REG_DEVICE_ID		0xF
+
+#define TMP117_RESOLUTION		78125       /* in tens of uCelsius*/
+#define TMP117_RESOLUTION_DIV		10000000
+
+#define TMP117_DEVICE_ID		0x0117
+
+struct tmp117_data {
+	struct i2c_client *client;
+	struct mutex lock;
+};
+
+static int tmp117_read_reg(struct tmp117_data *data, u8 reg)
+{
+
+	return i2c_smbus_read_word_swapped(data->client, reg);
+}
+
+static int tmp117_write_reg(struct tmp117_data *data, u8 reg, int val)
+{
+
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
+	case IIO_CHAN_INFO_PROCESSED:
+		tmp = tmp117_read_reg(data, TMP117_REG_TEMP);
+		*val = ((int16_t)tmp * (int32_t)TMP117_RESOLUTION) / 10000000;
+		*val2 = ((int16_t)tmp * (int32_t)TMP117_RESOLUTION) % 10000000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CHAN_INFO_OFFSET:
+		off = tmp117_read_reg(data, TMP117_REG_TEMP_OFFSET);
+		*val = ((int16_t)off * (int32_t)TMP117_RESOLUTION) / 10000000;
+		*val2 = ((int16_t)off * (int32_t)TMP117_RESOLUTION) % 10000000;
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
+	u16 off;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
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
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				BIT(IIO_CHAN_INFO_OFFSET),
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
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = "tmp117";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &tmp117_info;
+
+	indio_dev->channels = tmp117_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tmp117_channels);
+
+	return iio_device_register(indio_dev);
+}
+
+static int tmp117_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	return 0;
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
+	.remove		= tmp117_remove,
+	.id_table	= tmp117_id,
+};
+module_i2c_driver(tmp117_driver);
+
+MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
+MODULE_DESCRIPTION("TI TMP117 Temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.30.1

