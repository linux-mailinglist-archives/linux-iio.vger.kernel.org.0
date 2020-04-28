Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D591BB5F0
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 07:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1Fm0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 01:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgD1FmZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 01:42:25 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1974C03C1AD
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 22:42:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k28so15818774lfe.10
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 22:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2u3+hiLcio3RfiSLRkdrsj4+dj8Bs6f6GNM5IncuNgw=;
        b=DiBkmGX68Dci8L0NY+4z2PUc0Oahob1CBPCJrvQ7GOfQoh4Sninsj4anXkS0+JaUSz
         ErA49qgJw2yIZC+i295bPZaH0SGp3kY+GIMiymufexrwhrdZdcD+ISsO2HxJa8sjSP2B
         0Vura1sziSIyrjyGo1OVb/ICyH1H9OaAR1ht8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2u3+hiLcio3RfiSLRkdrsj4+dj8Bs6f6GNM5IncuNgw=;
        b=Kz97ctoS7ui8vle2RMK+xP5pMQejxnNoXHzLBs4VHY/Zpska7+S1vZ1awEQfIyMcz4
         fsV2yALfLUXrXpn9n19rJIyzyYsNMQrNSTFgvRDEOZnkvFXmpY128Ez/Gznp9kja7NQl
         U/q7jQvJi8SQwf5DCdCjMycMo7EqGGcOom0tPjb/ysv7f3yWlIfWOaSIjM+RUMiCff+V
         a4XiIAQuF6GACt+nSJCCHVg7aREsuuNbpLjqTGxdG8DhUOBn7OloeRurSNudeL1NQ6/w
         YV20JwH4bUXa2rdtlJd4Hk1k7XaoMuHLoFeTPci3GirS0IS9R/bN4OgxeoKLj7c/K7lX
         petw==
X-Gm-Message-State: AGi0Puau+o0I70hHDwJc+IeaFWIpvUY8LsaLQ5jB+iM9c/w+8z2ZGu7g
        8zBq4jkiGM0owqL0BaKDd1wh9A==
X-Google-Smtp-Source: APiQypLbe5tLM0/OWOpZcEgg6yLhKzxRjeuHnueZeJedT3vEvXVTT0fsPx1STtxSOmZBAm1kdBHTZA==
X-Received: by 2002:ac2:569b:: with SMTP id 27mr18064855lfr.134.1588052543169;
        Mon, 27 Apr 2020 22:42:23 -0700 (PDT)
Received: from taos-chr.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id c4sm13240035lfg.82.2020.04.27.22.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 22:42:22 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 2/2] iio: chemical: add atlas-ezo-sensor initial support
Date:   Tue, 28 Apr 2020 08:41:07 +0300
Message-Id: <20200428054107.16061-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428054107.16061-1-matt.ranostay@konsulko.com>
References: <20200428054107.16061-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver for Atlas EZO line of sensors with initial support for
CO2 the sensor. This is effectively ASCII strings proxied over I2C
due to these series of sensors being by default UART.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/Kconfig            |  11 ++
 drivers/iio/chemical/Makefile           |   1 +
 drivers/iio/chemical/atlas-ezo-sensor.c | 173 ++++++++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 drivers/iio/chemical/atlas-ezo-sensor.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index a7e65a59bf42..7f21afd73b1c 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -22,6 +22,17 @@ config ATLAS_PH_SENSOR
 	  To compile this driver as module, choose M here: the
 	  module will be called atlas-ph-sensor.
 
+config ATLAS_EZO_SENSOR
+	tristate "Atlas Scientific EZO sensors"
+	depends on I2C
+	help
+	  Say Y here to build I2C interface support for the following
+	  Atlas Scientific EZO sensors
+	    * CO2 EZO Sensor
+
+	  To compile this driver as module, choose M here: the
+	  module will be called atlas-ezo-sensor.
+
 config BME680
 	tristate "Bosch Sensortec BME680 sensor driver"
 	depends on (I2C || SPI)
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 33d3a595dda9..aba4167db745 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -5,6 +5,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-sensor.o
+obj-$(CONFIG_ATLAS_EZO_SENSOR)	+= atlas-ezo-sensor.o
 obj-$(CONFIG_BME680) += bme680_core.o
 obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
 obj-$(CONFIG_BME680_SPI) += bme680_spi.o
diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
new file mode 100644
index 000000000000..1f972f525a46
--- /dev/null
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * atlas-ezo-sensor.c - Support for Atlas Scientific EZO sensors
+ *
+ * Copyright (C) 2020 Konsulko Group
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include <linux/iio/iio.h>
+
+#define ATLAS_EZO_DRV_NAME		"atlas-ezo-sensor"
+#define ATLAS_CO2_INT_TIME_IN_MS	950
+
+enum {
+	ATLAS_CO2_EZO,
+};
+
+struct atlas_ezo_device {
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	int delay;
+};
+
+struct atlas_ezo_data {
+	struct i2c_client *client;
+	struct atlas_ezo_device *chip;
+	struct mutex lock;
+	u8 buffer[8];
+};
+
+static const struct iio_chan_spec atlas_co2_ezo_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.modified = 1,
+		.channel2 = IIO_MOD_CO2,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+};
+
+static struct atlas_ezo_device atlas_ezo_devices[] = {
+	[ATLAS_CO2_EZO] = {
+		.channels = atlas_co2_ezo_channels,
+		.num_channels = 1,
+		.delay = ATLAS_CO2_INT_TIME_IN_MS,
+	},
+};
+
+static int atlas_ezo_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	struct atlas_ezo_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int ret = 0;
+
+	if (chan->type != IIO_CONCENTRATION)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		int tmp;
+
+		mutex_lock(&data->lock);
+
+		tmp = i2c_smbus_write_byte(client, 'R');
+
+		if (tmp < 0) {
+			mutex_unlock(&data->lock);
+			return tmp;
+		}
+
+		msleep(data->chip->delay);
+
+		tmp = i2c_master_recv(client, data->buffer, sizeof(data->buffer));
+
+		// Confirm response code is 1 for success
+		if (tmp < 0 || data->buffer[0] != 1) {
+			mutex_unlock(&data->lock);
+			return -EBUSY;
+		}
+
+		ret = kstrtol(data->buffer + 1, 10, (long *) val);
+
+		mutex_unlock(&data->lock);
+
+		return ret ? ret : IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+		*val2 = 10000; /* 0.0001 */
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	return ret;
+}
+
+static const struct iio_info atlas_info = {
+	.read_raw = atlas_ezo_read_raw,
+};
+
+static const struct i2c_device_id atlas_ezo_id[] = {
+	{ "atlas-co2-ezo", ATLAS_CO2_EZO },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
+
+static const struct of_device_id atlas_ezo_dt_ids[] = {
+	{ .compatible = "atlas,co2-ezo", .data = (void *)ATLAS_CO2_EZO, },
+	{}
+};
+MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
+
+static int atlas_ezo_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct atlas_ezo_data *data;
+	struct atlas_ezo_device *chip;
+	const struct of_device_id *of_id;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	of_id = of_match_device(atlas_dt_ids, &client->dev);
+	if (!of_id)
+		chip = &atlas_ezo_devices[id->driver_data];
+	else
+		chip = &atlas_ezo_devices[(unsigned long)of_id->data];
+
+	indio_dev->info = &atlas_info;
+	indio_dev->name = ATLAS_EZO_DRV_NAME;
+	indio_dev->channels = chip->channels;
+	indio_dev->num_channels = chip->num_channels;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &client->dev;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->chip = chip;
+	mutex_init(&data->lock);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+};
+
+static struct i2c_driver atlas_ezo_driver = {
+	.driver = {
+		.name	= ATLAS_EZO_DRV_NAME,
+		.of_match_table	= atlas_ezo_dt_ids,
+	},
+	.probe		= atlas_ezo_probe,
+	.id_table	= atlas_ezo_id,
+};
+module_i2c_driver(atlas_ezo_driver);
+
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
+MODULE_DESCRIPTION("Atlas Scientific EZO sensors");
+MODULE_LICENSE("GPL");
-- 
2.20.1

