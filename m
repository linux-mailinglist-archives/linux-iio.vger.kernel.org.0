Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB31CCFC8
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 04:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgEKCcY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 22:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729379AbgEKCcY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 May 2020 22:32:24 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7543C061A0C
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2020 19:32:23 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so6162995lfd.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2020 19:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tcZ2/XdH1pRuHBuNoOFr6pSbND6BZrixZsFbbSeRljQ=;
        b=aLYGtzYdVAuBwdr+NWKcdMf+eab7Go1mxVzM0sNH5KDjAehhaCA0mL8QNtVzpHnKH6
         CNZ8mcuA+j3R3Y0/WPEC+OjSv5Ky61sZyQ6kMAk082ONbJOH/a6DUu2apbEzheqJmvnq
         48Jsf7yG56IjQDrdFbJqP3298oppdtNpkCvdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tcZ2/XdH1pRuHBuNoOFr6pSbND6BZrixZsFbbSeRljQ=;
        b=c5U2LtLcSSQNAH9DeoeYnd0NrmGyxI5TRhYAjnTkC8sCYcEsCBZBQwvSpRxynT2wQ6
         GXdtDnDfYAIQiNVgn80IHTVwkjf4P9NZSZACrWjxW6umWzzDIe9qIQ6bUFT0Bc/9Wa6R
         abHy3QsnabmmHPKBkfy0UZNFC+0+2Dzza+pJbhfwiCEvtCoMm53sgEdzNJ5OYyWY1eCI
         OOv0ld0ggZ6wTHQsjtYE6ZRISW+0H2XQo9qJsKX3w74s0P3aOGc3ZlV1MUjlUSwDG8U+
         LGxjzxdOAuyK/AKyJX/FJ0+q44rfv+7nlqSzTumfPGTN8LRLcdf1AAqg8r5lt/ozf4vZ
         /QSw==
X-Gm-Message-State: AOAM532lK/wOxHhmzQqkOxG55V3eefA5FVKBUHn+joyDf8tCvQsKrrfk
        //CIqIKcy3yV+Y+OP9Sptlvj7uIKdPs=
X-Google-Smtp-Source: ABdhPJzy2YLg/ymiMAgIsMNnWRZ+2nqna+l+lFNu9QZN1NK0L8pJEg9KCeM8/8QTTEddSUwFTZIskg==
X-Received: by 2002:ac2:4145:: with SMTP id c5mr9435769lfi.91.1589164341796;
        Sun, 10 May 2020 19:32:21 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id p6sm8624051lfc.15.2020.05.10.19.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 19:32:21 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 2/2] iio: chemical: add atlas-ezo-sensor initial support
Date:   Mon, 11 May 2020 05:32:14 +0300
Message-Id: <20200511023214.14704-3-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511023214.14704-1-matt.ranostay@konsulko.com>
References: <20200511023214.14704-1-matt.ranostay@konsulko.com>
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
 drivers/iio/chemical/atlas-ezo-sensor.c | 178 ++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
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
index 000000000000..009bfad49546
--- /dev/null
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -0,0 +1,178 @@
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
+
+	// locking mutex to avoid multiple concurrent read calls
+	struct mutex lock;
+
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
+		long tmp;
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
+		ret = kstrtol(data->buffer + 1, 10, &tmp);
+
+		*val = tmp;
+
+		mutex_unlock(&data->lock);
+
+		return ret ? ret : IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = 100; /* 0.0001 */
+		return IIO_VAL_INT_PLUS_MICRO;
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
+	of_id = of_match_device(atlas_ezo_dt_ids, &client->dev);
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

