Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1800355B5E
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbhDFS3W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbhDFS3U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 14:29:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F15C06174A;
        Tue,  6 Apr 2021 11:29:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a12so11048043pfc.7;
        Tue, 06 Apr 2021 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GIL7rCODKF/xXDJXa/SMy996Dbick98n/f2XKrRaD7U=;
        b=Caaj1zABlixtHGW+cg9/Fzfai9mIWGQel39ECmacW7GjFbsqXuH+4ZXxojnEwieaDL
         zYZy29t+GcOjD4OvzCzLEefEyjmrnAbOCp5p/tNzuBN0vejf81ho1pywPcsZGbwciGsj
         WWCstTxS3YlsIWWplANMqsaxzFq/exROdpLRkGrinf0ex5v4IseGOyIucWjy30FiX4N7
         VjbbKZI5nibx+R3gN1YKZijlfJRLWl+6x547+ZOMSY+NgUlGrYgEBw9N5JNTsHmqXuAk
         zbEdOPZ0/VjZGa8x9/i6fg/2IyAeASXBaRFV6HQXD+KXhFuZiscuc5eaGafU5Uyxgxjm
         TNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GIL7rCODKF/xXDJXa/SMy996Dbick98n/f2XKrRaD7U=;
        b=ZDrakz9OEUmPc69Oa70xc1PunpgFnKgC/YlnlNnWXGzbg2YJYrcoZsuwQ7lFeMWhp3
         Ojad/tJeBpzyN/sGarcSdzfqOlUz7+aNYUsyxr2Qu4K32DeceJgxkCww8SY/TdQpQDCl
         TRo9+3LMlXxq8YBnTBa96BnFkVKEC7vpcwi3tLgbTSpZ2E1p3/agWngzSPTCde5UtcFm
         wtiAsAYPhq3yKZHYzRLy+TeWynnzXNX5o1COWnuqCo2sSh4bgo68w2m7pg1AOtz5P0su
         mXDhgm8nsTpBrJCoDq2kMVr1NTy3bDcyezyQdutaKWmplePnYKzpRjvnzs/0IS8hEN6F
         nyAw==
X-Gm-Message-State: AOAM531vHj6+eWbRsTiDZ5tuKFvPAcUjjQ+o3/feuF0WOHy1eDlHk+LV
        4pWLF+Gzip1b1nGkTl1XM6E=
X-Google-Smtp-Source: ABdhPJzIuqvHcT3T4EW7OlWXJNKpGpbCCF9v+9JkoBV47e1xBym3cG4T6ZvqRuPUKtfmUqBoQR6qkg==
X-Received: by 2002:a05:6a00:b89:b029:22f:dce:9fd5 with SMTP id g9-20020a056a000b89b029022f0dce9fd5mr28275846pfj.78.1617733752291;
        Tue, 06 Apr 2021 11:29:12 -0700 (PDT)
Received: from localhost.localdomain ([124.253.94.185])
        by smtp.googlemail.com with ESMTPSA id x25sm19652383pfn.81.2021.04.06.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:29:11 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v3 2/2] iio: temperature: add driver support for ti tmp117
Date:   Tue,  6 Apr 2021 23:58:52 +0530
Message-Id: <20210406182852.263605-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210406182852.263605-1-puranjay12@gmail.com>
References: <20210406182852.263605-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

TMP117 is a Digital temperature sensor with integrated NV memory.
Add support for tmp117 driver in iio subsystem.

Datasheet: https://www.ti.com/lit/gpn/tmp117
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 MAINTAINERS                      |   7 ++
 drivers/iio/temperature/Kconfig  |  10 ++
 drivers/iio/temperature/Makefile |   1 +
 drivers/iio/temperature/tmp117.c | 182 +++++++++++++++++++++++++++++++
 4 files changed, 200 insertions(+)
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
index 000000000..c3ff2913b
--- /dev/null
+++ b/drivers/iio/temperature/tmp117.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Digital temperature sensor with integrated NV memory
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
+		off = clamp(val, -32768, 32767);
+		if (off == data->calibbias)
+			return 0;
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

