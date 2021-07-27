Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECBB3D7B1A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 18:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhG0QgI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 27 Jul 2021 12:36:08 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhG0QgI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 12:36:08 -0400
Received: from localhost ([31.220.117.216]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6sSV-1nGhPD0E3D-018J8k; Tue, 27 Jul 2021 18:35:20 +0200
Date:   Tue, 27 Jul 2021 18:35:19 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 2/2] iio: chemical: Add driver support for sgp40
Message-ID: <20210727163517.GA3468@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:zf19H+WeltgMl4Ho1Rx3zMUhWavnCWnlQR5mXu06sT8F1dOI2Hb
 JpwoGdqFJAS9qrrCJ1mskWOUCujt/hm9zE3nDWtRIvIgS9KuRHzVGVhaBoZc5i7UK6kZPmG
 gjvtZ3b5yW4nqRimCUB+6O1Pxq3A9HzS1KAEcMjdf3WaBTPZwKvX3S28Le8VigDJluYuI6n
 Vs+bEb3iw0v0SvZx3+POA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KA4Qa3V3adI=:tgocSEtbyzrRE3usiIwg1G
 ZYmm2EyDgnYdCwbNTOwnOo/sITScncTXGoZ3b/+1dEnJ8sPTjUbj8NLivKHyvr/H36kazDupU
 pH7qQ08cyX0nYQRDOcE7/Nb9JTFYweCijyPoJcS/2PIVjN3dduvSeHoGm1JHl4zmSVEjwNLnw
 c1J2I+hT0ttd5kQIjuY7p37WOJmbaRaRYm5IkLqjKeffOZrSdvDAAz6llVm+ADrQWGQ+IQOp5
 i3QSHj7M9AOTTJa2jCKZ7Kx0jsrSNZkzI2mYfPJmRuGf5+eQleon6ssL/YmzI/qErXJbYnqzL
 QvjO/qlDhuY1VyObhWVrLwQGwiYEP6wnqTar9VIMm2fpfX8ZGmxSySw9/hwTfolrdP7S1onOH
 7WZcxWX73kLXsO7pbgSeqBz6QpNxxCWiD0M09FYDbfOwgBTWlqqyM12sXKWNXVuELyPl7GBf6
 s7Z9xR10VdjOIzuQjvqY8d3cpZtUloY2lApNPDR7oHlyWL6diZ8PGv9CfSq5PZIo6nkiwbXfW
 L594FMKC1SuqFk9j/v2xMfAkvbM0JrHPUPjAcnUbC77xk5CsYiw1fqD9BOKfz0KERKcO69S7h
 3ejGYoWlSxMAuLuQqqT8iRz7CgVTvyw2By7iEbT+OMtYw3ul390UFkKo7D+bNd2B4eVqxNqNb
 KORABKcGXKio39kZLmYKhR8ZWJZsIvYWMWXNiSUGH+02Pj6Ez9qONMsqWg94YhynBjraF7vBs
 nqO6JVAmvYAIVLaVuZ5/zd1eiNeFnXxyMBHwc7UKlF0FmIfiKH44m1vLgpdJiMrezkZLoaL/t
 X6Ss6n5QNEQXQ9eaCEma65s1tc+RxXme+s2UxGXix0yPlg8WRBG8xWOgssXoJcRFukCNv2q
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

sgp40 is a gas sensor used for measuring the air quality.

This driver is reading the raw resistance value which can be passed to
a userspace algorithm for further calculation.

The raw value is also used to calculate an estimated absolute voc index
in the range from 0 to 500. For this purpose the raw_mean value of the
resistance for which the index value is 250 might be set up as a
calibration step.

Compensation of relative humidity and temperature is supported and can
be used by writing to device attributes of the driver.

There is a predecesor sensor type (sgp30) already existing. This driver
module was not extended because the new sensor is quite different in its
i2c telegrams.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS                   |   5 +
 drivers/iio/chemical/Kconfig  |  11 +
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/sgp40.c  | 413 ++++++++++++++++++++++++++++++++++
 4 files changed, 430 insertions(+)
 create mode 100644 drivers/iio/chemical/sgp40.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 19135a9d778e..ed8aae16559d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16707,6 +16707,11 @@ F:	drivers/iio/chemical/scd30_core.c
 F:	drivers/iio/chemical/scd30_i2c.c
 F:	drivers/iio/chemical/scd30_serial.c
 
+SENSIRION SGP40 GAS SENSOR DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+S:	Maintained
+F:	drivers/iio/chemical/sgp40.c
+
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index a4920646e9be..c03667e62732 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -131,6 +131,17 @@ config SENSIRION_SGP30
 	  To compile this driver as module, choose M here: the
 	  module will be called sgp30.
 
+config SENSIRION_SGP40
+	tristate "Sensirion SGP40 gas sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say Y here to build I2C interface to support Sensirion SGP40 gas
+	  sensor
+
+	  To compile this driver as module, choose M here: the
+	  module will be called sgp40.
+
 config SPS30
 	tristate
 	select IIO_BUFFER
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 4898690cc155..d07af581f234 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SCD30_CORE) += scd30_core.o
 obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
 obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
+obj-$(CONFIG_SENSIRION_SGP40)	+= sgp40.o
 obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
 obj-$(CONFIG_SPS30_SERIAL) += sps30_serial.o
diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
new file mode 100644
index 000000000000..7072c5f3c28d
--- /dev/null
+++ b/drivers/iio/chemical/sgp40.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * sgp40.c - Support for Sensirion SGP40 Gas Sensors
+ *
+ * Copyright (C) 2021 Andreas Klinger <ak@it-klinger.de>
+ *
+ * I2C slave address: 0x59
+ *
+ * Datasheets:
+ * https://www.sensirion.com/file/datasheet_sgp40
+ *
+ * There are two functionalities supported:
+ * 1) read raw logarithmic resistance value from sensor
+ *    --> useful to pass it to the algorithm of the sensor vendor for
+ *    measuring deteriorations and improvements of air quality.
+ * 2) calculate an estimated absolute voc index (0 - 500 index points) for
+ *    measuring the air quality.
+ *    For this purpose the mean value of the resistance can be set up using
+ *    a device attribute
+ *
+ * Compensation of relative humidity and temperature can be used by device
+ * attributes.
+ */
+
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/i2c.h>
+#include <linux/crc8.h>
+
+#define SGP40_CRC8_POLYNOMIAL			0x31
+#define SGP40_CRC8_INIT				0xff
+
+static u8 sgp40_measure_raw_tg[] = {0x26, 0x0F};
+
+DECLARE_CRC8_TABLE(sgp40_crc8_table);
+
+struct sgp40_data {
+	struct device		*dev;
+	struct i2c_client	*client;
+	int			rel_humidity;
+	int			temperature;
+	int			raw_mean;
+	struct mutex		lock;
+};
+
+static const struct iio_chan_spec sgp40_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_VOC,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+	{
+		.type = IIO_RESISTANCE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
+/*
+ * calculate e^x where n is the exponent multiplied with 100
+ *
+ * use taylor approximation which is accurate enough for the purpose of
+ * coming out with just 500 index points.
+ */
+int sqp40_exp100(int n)
+{
+	int x, xn, y, z;
+	int s = 1;
+
+	if (n < 0) {
+		s = -1;
+		n *= -1;
+	}
+
+	x = n;
+
+	y = 100 + x;
+	xn = x * x;
+	y += xn / 2 / 100;
+	xn = x * x * x;
+	y += xn / 6 / 10000;
+	xn = x * x * x * x;
+	y += xn / 24 / 1000000;
+
+	if (s == -1)
+		z = 10000 / y;
+	else
+		z = y;
+
+	return z;
+}
+
+static int sgp40_calc_voc(struct sgp40_data *data, u16 raw, int *voc)
+{
+	int x;
+	int ex = 0;
+
+	/* we calculate in 100's */
+	x = ((int)raw - data->raw_mean) * 65 / 100;
+
+	/* voc = 500 / (1 + e^x) */
+	if (x < -800)
+		*voc = 500;
+	else if (x > 800)
+		*voc = 0;
+	else {
+		ex = sqp40_exp100(x);
+		*voc = 50000 / (100 + ex);
+	}
+
+	dev_dbg(data->dev, "raw: %d raw_mean: %d x: %d ex: %d voc: %d\n",
+						raw, data->raw_mean, x, ex, *voc);
+
+	return 0;
+}
+
+static int sgp40_measure_raw(struct sgp40_data *data, u16 *raw)
+{
+	int ret;
+	struct i2c_client *client = data->client;
+	u16 buf_be16;
+	u8 buf[3];
+	u8 tg[8];
+	u32 ticks;
+	u8 crc;
+
+	memcpy(tg, sgp40_measure_raw_tg, 2);
+
+	ticks = (data->rel_humidity / 10) * 65535 / 10000;
+	buf_be16 = cpu_to_be16((u16)ticks);
+	memcpy(&tg[2], &buf_be16, 2);
+	tg[4] = crc8(sgp40_crc8_table, &tg[2], 2, SGP40_CRC8_INIT);
+
+	ticks = ((data->temperature + 45000) / 10) * 65535 / 17500;
+	buf_be16 = cpu_to_be16((u16)ticks);
+	memcpy(&tg[5], &buf_be16, 2);
+	tg[7] = crc8(sgp40_crc8_table, &tg[5], 2, SGP40_CRC8_INIT);
+
+	ret = i2c_master_send(client, (const char *)tg, sizeof(tg));
+	if (ret != sizeof(tg)) {
+		dev_warn(data->dev, "i2c_master_send ret: %d sizeof: %d\n", ret, sizeof(tg));
+		return -EIO;
+	}
+	msleep(30);
+
+	ret = i2c_master_recv(client, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(buf)) {
+		dev_warn(data->dev, "i2c_master_recv ret: %d sizeof: %d\n", ret, sizeof(buf));
+		return -EIO;
+	}
+
+	crc = crc8(sgp40_crc8_table, buf, 2, SGP40_CRC8_INIT);
+	if (crc != buf[2]) {
+		dev_err(data->dev, "CRC error while measure-raw\n");
+		return -EIO;
+	}
+
+	memcpy(&buf_be16, buf, sizeof(buf_be16));
+	*raw = be16_to_cpu(buf_be16);
+
+	return 0;
+}
+
+static int sgp40_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan, int *val,
+			int *val2, long mask)
+{
+	struct sgp40_data *data = iio_priv(indio_dev);
+	int ret;
+	u16 raw;
+	int voc;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->lock);
+		ret = sgp40_measure_raw(data, &raw);
+		if (ret) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+		*val = raw;
+		ret = IIO_VAL_INT;
+		mutex_unlock(&data->lock);
+		break;
+	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&data->lock);
+		ret = sgp40_measure_raw(data, &raw);
+		if (ret) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+		ret = sgp40_calc_voc(data, raw, &voc);
+		if (ret) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+		*val = voc;
+		ret = IIO_VAL_INT;
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static ssize_t rel_humidity_comp_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sgp40_data *data = iio_priv(indio_dev);
+	int ret;
+	u32 val;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 100000)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	data->rel_humidity = val;
+	mutex_unlock(&data->lock);
+
+	return len;
+}
+
+static ssize_t rel_humidity_comp_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sgp40_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->lock);
+	ret = snprintf(buf, PAGE_SIZE, "%d\n", data->rel_humidity);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static ssize_t temperature_comp_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sgp40_data *data = iio_priv(indio_dev);
+	int val;
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if ((val < -45000) || (val > 130000))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	data->temperature = val;
+	mutex_unlock(&data->lock);
+
+	return len;
+}
+
+static ssize_t temperature_comp_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sgp40_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->lock);
+	ret = snprintf(buf, PAGE_SIZE, "%d\n", data->temperature);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static ssize_t raw_mean_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sgp40_data *data = iio_priv(indio_dev);
+	u32 val;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if ((val < 20000) || (val > 52768))
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	data->raw_mean = val;
+	mutex_unlock(&data->lock);
+
+	return len;
+}
+
+static ssize_t raw_mean_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sgp40_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->lock);
+	ret = snprintf(buf, PAGE_SIZE, "%d\n", data->raw_mean);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static IIO_DEVICE_ATTR_RW(rel_humidity_comp, 0);
+static IIO_DEVICE_ATTR_RW(temperature_comp, 0);
+static IIO_DEVICE_ATTR_RW(raw_mean, 0);
+
+static struct attribute *sgp40_attrs[] = {
+	&iio_dev_attr_rel_humidity_comp.dev_attr.attr,
+	&iio_dev_attr_temperature_comp.dev_attr.attr,
+	&iio_dev_attr_raw_mean.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group sgp40_attr_group = {
+	.attrs = sgp40_attrs,
+};
+
+static const struct iio_info sgp40_info = {
+	.attrs		= &sgp40_attr_group,
+	.read_raw	= sgp40_read_raw,
+};
+
+static int sgp40_probe(struct i2c_client *client,
+		     const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct sgp40_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->dev = dev;
+
+	crc8_populate_msb(sgp40_crc8_table, SGP40_CRC8_POLYNOMIAL);
+
+	mutex_init(&data->lock);
+
+	/* set default values */
+	data->rel_humidity = 50000;	/* 50 % */
+	data->temperature = 25000;	/* 25 °C */
+	data->raw_mean = 30000;		/* resistance raw value for voc index of 250 */
+
+	indio_dev->info = &sgp40_info;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sgp40_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sgp40_channels);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "failed to register iio device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id sgp40_id[] = {
+	{ "sgp40" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, sgp40_id);
+
+static const struct of_device_id sgp40_dt_ids[] = {
+	{ .compatible = "sensirion,sgp40" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, sgp40_dt_ids);
+
+static struct i2c_driver sgp40_driver = {
+	.driver = {
+		.name = "sgp40",
+		.of_match_table = sgp40_dt_ids,
+	},
+	.probe = sgp40_probe,
+	.id_table = sgp40_id,
+};
+module_i2c_driver(sgp40_driver);
+
+MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
+MODULE_DESCRIPTION("Sensirion SGP40 gas sensors");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1
