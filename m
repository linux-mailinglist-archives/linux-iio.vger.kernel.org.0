Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF13E338E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 07:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhHGFKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 01:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhHGFKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 01:10:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B44C0613CF;
        Fri,  6 Aug 2021 22:10:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so25713130pjr.1;
        Fri, 06 Aug 2021 22:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xzYlq+A0LjL1Pnh8pKBqoDR/IjWA3bqDTt8ASZ72oZg=;
        b=M/MERwO6Dp687Ku1C7KAUTLYP0EAzUDlsfuQVg9Tsyws8gwEa95vS2TZye5HhXqhO+
         MQp+4U42Qj2jg/6J4MXtjCvYX9zqppqXYJAj/b4XPkgk3Aeb72fcMdusTcdnLpIQXP/8
         TGy1ZLJ9aI/U2YjzQUPwxEkRIMxrrX8CgLpuDfEAOlZsgG2X8N/6ezxrOTNAgO44vKVR
         kXLQaasGs6ELyVd+UTA70dX+iNcHW8zIzd0QfCwhs7kRNyzH973ZkHRIL+h4LYvoYof9
         e4hQhNGPpJzi3WRGLzLoSITajdjnZMFfwcOIoMNOu3T71D/jYAlqseQxsOZmu2SzGn+a
         VLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzYlq+A0LjL1Pnh8pKBqoDR/IjWA3bqDTt8ASZ72oZg=;
        b=q2+V0Jep/WPzqP2zRjEIXcz0GjnJDI4xeQEwaA4HEqq/rTMFUW/NSWuN9LK1ML+j0F
         zPhFab9NiVlw2VG7BWaRc+Rb8/Diodqz1GyVai7zDgpy0hXaTPSOtM2x87i9uzi5M75F
         EutGDaE+7+xG1wqOgHh/T0Fr0H6exN40yCvLFZ0IKzHp1BtGdJ5WNIne9g6YE8poXdjV
         rKHSdaezfZnL0PpnSOE7bh6XRaRXJPv308iqZ6l4VdC6MXhsj4GMBEvvCMOWpbRUxilh
         lFWAiyxGDpL4/xSkq70ZT30MzseAQZS28q91w2qEdblOJ/c1lVcLSOBR5P0zVkinIiry
         memw==
X-Gm-Message-State: AOAM533PqhTh/Dzg6qJpfLufxKAW08vG7plfEAXDvICT0/s+ygfz//si
        6AabZFh9km919adCW9D7L6c=
X-Google-Smtp-Source: ABdhPJzpudGMeLT1appuDnSoYiWHgUW+pPbhAeDp64ffoEXShg/Gdrch7/hQt2EwZhtnkjyzsaL7ag==
X-Received: by 2002:aa7:96fc:0:b029:3ab:8eff:ca39 with SMTP id i28-20020aa796fc0000b02903ab8effca39mr14011589pfq.62.1628313018083;
        Fri, 06 Aug 2021 22:10:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:92:61e9:aa2d:89ae:905d:dacf])
        by smtp.googlemail.com with ESMTPSA id l14sm14433011pjz.19.2021.08.06.22.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 22:10:17 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
To:     Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: potentiometer: Add driver support for AD5110
Date:   Sat,  7 Aug 2021 10:38:55 +0530
Message-Id: <20210807050900.10075-3-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807050900.10075-1-dmugil2000@gmail.com>
References: <20210807050900.10075-1-dmugil2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD5110/AD5112/AD5114 provide a nonvolatile solution
for 128-/64-/32-position adjustment applications, offering
guaranteed low resistor tolerance errors of ±8% and up to
±6 mA current density.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5110_5112_5114.pdf
Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 MAINTAINERS                        |   6 +
 drivers/iio/potentiometer/Kconfig  |  10 +
 drivers/iio/potentiometer/Makefile |   1 +
 drivers/iio/potentiometer/ad5110.c | 333 +++++++++++++++++++++++++++++
 4 files changed, 350 insertions(+)
 create mode 100644 drivers/iio/potentiometer/ad5110.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c120f..cf6e73b87b6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -452,6 +452,12 @@ S:	Maintained
 W:	https://parisc.wiki.kernel.org/index.php/AD1889
 F:	sound/pci/ad1889.*
 
+AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
+M:	Mugilraj Dhavachelvan <dmugil2000@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/potentiometer/ad5110.c
+
 AD525X ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 4cac0173db8b..832df8da2bc6 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -6,6 +6,16 @@
 
 menu "Digital potentiometers"
 
+config AD5110
+	tristate "Analog Devices AD5110 and similar Digital Potentiometer driver"
+	depends on I2C
+	help
+	  Say yes here to build support for the Analog Devices AD5110, AD5112 
+	  and AD5114 digital potentiometer chip.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5110.
+
 config AD5272
 	tristate "Analog Devices AD5272 and similar Digital Potentiometer driver"
 	depends on I2C
diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
index 091adf3cdd0b..5ebb8e3bbd76 100644
--- a/drivers/iio/potentiometer/Makefile
+++ b/drivers/iio/potentiometer/Makefile
@@ -4,6 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_AD5110) += ad5110.o
 obj-$(CONFIG_AD5272) += ad5272.o
 obj-$(CONFIG_DS1803) += ds1803.o
 obj-$(CONFIG_MAX5432) += max5432.o
diff --git a/drivers/iio/potentiometer/ad5110.c b/drivers/iio/potentiometer/ad5110.c
new file mode 100644
index 000000000000..26eb7a7aa15b
--- /dev/null
+++ b/drivers/iio/potentiometer/ad5110.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Analog Devices AD5110 digital potentiometer driver
+ *
+ * Copyright (C) 2021 Mugilraj Dhavachelvan <dmugil2000@gmail.com>
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5110_5112_5114.pdf
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* AD5110 commands */
+#define AD5110_EEPROM_WR	1
+#define AD5110_RDAC_WR	2
+#define AD5110_SHUTDOWN	3
+#define AD5110_RESET	4
+#define AD5110_RDAC_RD	5
+#define AD5110_EEPROM_RD	6
+
+/* AD5110_EEPROM_RD data */
+#define AD5110_WIPER_POS	0
+#define AD5110_RESISTOR_TOL	1
+
+#define WIPER_RESISTANCE	70
+
+struct ad5110_cfg {
+	int max_pos;
+	int kohms;
+	int shift;
+};
+
+enum ad5110_type {
+	AD5110_10,
+	AD5110_80,
+	AD5112_05,
+	AD5112_10,
+	AD5112_80,
+	AD5114_10,
+	AD5114_80,
+};
+
+static const struct ad5110_cfg ad5110_cfg[] = {
+	[AD5110_10] = { .max_pos = 128, .kohms = 10 },
+	[AD5110_80] = { .max_pos = 128, .kohms = 80 },
+	[AD5112_05] = { .max_pos = 64, .kohms = 5, .shift = 1 },
+	[AD5112_10] = { .max_pos = 64, .kohms = 10, .shift = 1 },
+	[AD5112_80] = { .max_pos = 64, .kohms = 80, .shift = 1 },
+	[AD5114_10] = { .max_pos = 32, .kohms = 10, .shift = 2 },
+	[AD5114_80] = { .max_pos = 32, .kohms = 80, .shift = 2 },
+};
+
+struct ad5110_data {
+	struct i2c_client       *client;
+	s16			tol;		/* resistor tolerance */
+	bool			enable;
+	struct mutex            lock;
+	const struct ad5110_cfg	*cfg;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u8			buf[2] ____cacheline_aligned;
+};
+
+static const struct iio_chan_spec ad5110_channels[] = {
+	{
+		.type = IIO_RESISTANCE,
+		.output = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+						BIT(IIO_CHAN_INFO_ENABLE),
+	}
+};
+
+static int ad5110_read(struct ad5110_data *data, u8 cmd, int *val)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	data->buf[0] = cmd;
+	data->buf[1] = *val;
+
+	ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
+	if (ret < 0)
+		goto error;
+
+	ret = i2c_master_recv_dmasafe(data->client, data->buf, 1);
+	if (ret < 0)
+		goto error;
+
+	*val = data->buf[0];
+	ret = 0;
+
+error:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int ad5110_write(struct ad5110_data *data, u8 cmd, u8 val)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	data->buf[0] = cmd;
+	data->buf[1] = val;
+
+	ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
+	mutex_unlock(&data->lock);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int ad5110_resistor_tol(struct ad5110_data *data, u8 cmd, int val)
+{
+	int ret;
+
+	ret = ad5110_read(data, cmd, &val);
+	if (ret)
+		return ret;
+
+	data->tol = FIELD_GET(GENMASK(6, 3), val);
+	data->tol = ((val & GENMASK(2, 0)) * 1000 / 8) + data->tol * 1000;
+	data->tol = data->cfg->kohms * data->tol / 100;
+	if (!(val & BIT(7)))
+		data->tol *= -1;
+
+	return 0;
+}
+
+static ssize_t ad5110_eeprom_read(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad5110_data *data = iio_priv(indio_dev);
+	int val = AD5110_WIPER_POS;
+	int ret;
+
+	ret = ad5110_read(data, AD5110_EEPROM_RD, &val);
+	if (ret)
+		return ret;
+
+	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
+}
+
+static ssize_t ad5110_eeprom_write(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad5110_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad5110_write(data, AD5110_EEPROM_WR, 0);
+	if (ret) {
+		dev_err(&data->client->dev, "RDAC to EEPROM write failed\n");
+		return ret;
+	}
+	msleep(20);
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(wiper_pos_eeprom, 0644,
+		       ad5110_eeprom_read,
+		       ad5110_eeprom_write, 0);
+
+static struct attribute *ad5110_attributes[] = {
+	&iio_dev_attr_wiper_pos_eeprom.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad5110_attribute_group = {
+	.attrs = ad5110_attributes,
+};
+
+static int ad5110_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad5110_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ad5110_read(data, AD5110_RDAC_RD, val);
+		if (ret)
+			return ret;
+
+		*val = *val >> data->cfg->shift;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = WIPER_RESISTANCE * data->cfg->max_pos;
+		*val2 = 1000 * data->cfg->kohms + data->tol;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1000 * data->cfg->kohms + data->tol;
+		*val2 = data->cfg->max_pos;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_ENABLE:
+		*val = data->enable;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5110_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad5110_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val >= data->cfg->max_pos || val < 0)
+			return -EINVAL;
+
+		return ad5110_write(data, AD5110_RDAC_WR, val << data->cfg->shift);
+	case IIO_CHAN_INFO_ENABLE:
+		if (val < 0 || val > 1)
+			return -EINVAL;
+		if (data->enable == val)
+			return 0;
+		ret = ad5110_write(data, AD5110_SHUTDOWN, val);
+		if (ret)
+			return ret;
+		data->enable = val;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad5110_info = {
+	.read_raw = ad5110_read_raw,
+	.write_raw = ad5110_write_raw,
+	.attrs = &ad5110_attribute_group,
+};
+
+#define AD5110_COMPATIBLE(of_compatible, cfg) {	\
+			.compatible = of_compatible,	\
+			.data = &ad5110_cfg[cfg],	\
+}
+
+static const struct of_device_id ad5110_of_match[] = {
+	AD5110_COMPATIBLE("adi,ad5110-10", AD5110_10),
+	AD5110_COMPATIBLE("adi,ad5110-80", AD5110_80),
+	AD5110_COMPATIBLE("adi,ad5112-05", AD5112_05),
+	AD5110_COMPATIBLE("adi,ad5112-10", AD5112_10),
+	AD5110_COMPATIBLE("adi,ad5112-80", AD5112_80),
+	AD5110_COMPATIBLE("adi,ad5114-10", AD5114_10),
+	AD5110_COMPATIBLE("adi,ad5114-80", AD5114_80),
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5110_of_match);
+
+static const struct i2c_device_id ad5110_id[] = {
+	{ "ad5110-10", AD5110_10 },
+	{ "ad5110-80", AD5110_80 },
+	{ "ad5112-05", AD5112_05 },
+	{ "ad5112-10", AD5112_10 },
+	{ "ad5112-80", AD5112_80 },
+	{ "ad5114-10", AD5114_10 },
+	{ "ad5114-80", AD5114_80 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ad5110_id);
+
+static int ad5110_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct ad5110_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+	data->cfg = device_get_match_data(dev);
+	if (!data->cfg)
+		data->cfg = &ad5110_cfg[i2c_match_id(ad5110_id, client)->driver_data];
+
+	/* refresh RDAC register with EEPROM */
+	ret = ad5110_write(data, AD5110_RESET, 0);
+	if (ret) {
+		dev_err(dev, "Refresh RDAC with EEPROM failed\n");
+		return ret;
+	}
+
+	ret = ad5110_resistor_tol(data, AD5110_EEPROM_RD, AD5110_RESISTOR_TOL);
+	if (ret) {
+		dev_err(dev, "Read resistor tolerance failed\n");
+		return ret;
+	}
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad5110_info;
+	indio_dev->channels = ad5110_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5110_channels);
+	indio_dev->name = client->name;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static struct i2c_driver ad5110_driver = {
+	.driver = {
+		.name	= "ad5110",
+		.of_match_table = ad5110_of_match,
+	},
+	.probe_new	= ad5110_probe,
+	.id_table	= ad5110_id,
+};
+
+module_i2c_driver(ad5110_driver);
+
+MODULE_AUTHOR("Mugilraj Dhavachelvan <dmugil2000@gmail.com>");
+MODULE_DESCRIPTION("AD5110 digital potentiometer");
+MODULE_LICENSE("GPL v2");
+
-- 
2.25.1

