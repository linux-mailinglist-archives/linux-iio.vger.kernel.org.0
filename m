Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE043F5793
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 07:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhHXFZK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 01:25:10 -0400
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:42096 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229885AbhHXFZK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 01:25:10 -0400
X-Greylist: delayed 1363 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 01:25:09 EDT
Received: from cmgw10.mail.unifiedlayer.com (unknown [10.0.90.125])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 51D2C803082A
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 05:01:39 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id IOZ6mA6V0KpssIOZ8mG78H; Tue, 24 Aug 2021 05:01:39 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=GIfNrsBK c=1 sm=1 tr=0 ts=61247d33
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=MhDmnRu9jo8A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=jtbBNqsHAAAA:8
 a=vU9dKmh3AAAA:8 a=VwQbUJbxAAAA:8 a=NFmCyV0TXFebMMqy87AA:9
 a=sfIEtMYjypgA:10:uccc_2email_address a=RWaeYqt-Cn-VcsFsiLGo:22
 a=rsP06fVo5MYu2ilr0aT5:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Atuf5vDslWlK/j+ayzma8B6zr4yU2LcjKZCjdWTi1o0=; b=dv4QOfNWkX4dngXQ3H4MBhZPnx
        r+zOgMkVNl4TT+UfSP+sxuBVI4GFh9twaY2xexXsC/mMzh3tLRm596/X0NTYc1N3zAneSWo6dsqCH
        pBRbnaQaolg9RC+BwZsIkjLKK39mwcQVn6mv7WJndswvsErDD9+4omXmsnQOb7BKJL+m7ZvrA9vkP
        LhY2yTWHYYgg/Eo65o83FKl7ZmQx23UxsVoJYyBUZyw/REQbn3GZlzbwtFmRjchaobo/P+YVMpNOt
        kYD+PEpGLBGySDXRYxrosIdFKQUS1xflCEyFs3ahVfLOyIr8ecqDFg96R0MdUOloBso6F6z2U+7zl
        k+3UOpiA==;
Received: from [117.193.211.180] (port=56146 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <navin@linumiz.com>)
        id 1mIOZ5-000LCM-TN; Tue, 24 Aug 2021 05:01:36 +0000
From:   Navin Sankar Velliangiri <navin@linumiz.com>
To:     jic23@kernel.org
Cc:     navin@linumiz.com, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, ardeleanalex@gmail.com
Subject: [PATCH v4 1/2] iio: temperature: Add MAX31865 RTD Support
Date:   Tue, 24 Aug 2021 10:31:23 +0530
Message-Id: <20210824050123.71289-1-navin@linumiz.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 117.193.211.180
X-Source-L: No
X-Exim-ID: 1mIOZ5-000LCM-TN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [117.193.211.180]:56146
X-Source-Auth: linumcmc
X-Email-Count: 2
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds support for Maxim MAX31865 RTD temperature
sensor support.

More information can be found in:
https://datasheets.maximintegrated.com/en/ds/MAX31865.pdf

Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>

---

Note:
Changes in v2:
	-> removed unnecessary header #include <linux/util_macros.h>
	-> implemented mutex to protect the device state
	-> Added __cacheline_aligned buffer to hold the raw temperature data
	-> implemented separate function to enable_bias() & disable_bias()
	-> call max31865_init() func when updating the filter
	-> Added ABI documentation for reference & testing
	-> dropped spi_set_drvdata()

Changes in v3:
	-> Moved buf[2] __cacheline_aligned to last element of struct
	max31865_data
	-> get_unaligned_be16 is used to express the raw temp data
	-> Added in_temp_filter_notch_frequency_avail to check available
	frequency
	-> removed mutex lock & unlock in max31865_probe() func

Changes in v4:
	-> use existing available attribute to show the available sampling
	frequency.
	-> use existing in_filter_notch_center_frequency attribute the set
	the notch filter.
---
 .../sysfs-bus-iio-temperature-max31865        |  20 +
 drivers/iio/temperature/Kconfig               |  10 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/max31865.c            | 349 ++++++++++++++++++
 4 files changed, 380 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
 create mode 100644 drivers/iio/temperature/max31865.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
new file mode 100644
index 000000000000..4b072da92218
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31865
@@ -0,0 +1,20 @@
+What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
+KernelVersion:	5.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Overvoltage or Undervoltage Input fault. The internal circuitry
+		is protected from excessive voltages applied to the thermocouple
+		cables at FORCE+, FORCE2, RTDIN+ & RTDIN-. This circuitry turn
+		off when the input voltage is negative or greater than VDD.
+
+		Reading returns '1' if input voltage is negative or greater
+		than VDD, otherwise '0'.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
+KernelVersion:	5.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Notch frequency in Hz for a noise rejection filter. Used i.e for
+		line noise rejection.
+
+		Valid notch filter values are 50 Hz and 60 Hz.
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 4df60082c1fa..c9412abca069 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -128,4 +128,14 @@ config MAX31856
 	  This driver can also be built as a module.  If so, the module
 	  will be called max31856.
 
+config MAX31865
+	tristate "MAX31865 RTD to Digital converter"
+	depends on SPI
+	help
+	  If you say yes here you get support for MAX31865
+	  thermocouple sensor chip connected via SPI.
+
+	  This driver can also be build as a module. If so, the module
+	  will be called max31865.
+
 endmenu
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 90c113115422..a8f3187258dc 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_LTC2983) += ltc2983.o
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
 obj-$(CONFIG_MAX31856) += max31856.o
+obj-$(CONFIG_MAX31865) += max31865.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_TMP006) += tmp006.o
diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
new file mode 100644
index 000000000000..4c8d6e6cf677
--- /dev/null
+++ b/drivers/iio/temperature/max31865.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) Linumiz 2021
+ *
+ * max31865.c - Maxim MAX31865 RTD-to-Digital Converter sensor driver
+ *
+ * Author: Navin Sankar Velliangiri <navin@linumiz.com>
+ */
+
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/spi/spi.h>
+#include <asm/unaligned.h>
+
+/*
+ * The MSB of the register value determines whether the following byte will
+ * be written or read. If it is 0, read will follow and if it is 1, write
+ * will follow.
+ */
+#define MAX31865_RD_WR_BIT			BIT(7)
+
+#define MAX31865_CFG_VBIAS			BIT(7)
+#define MAX31865_CFG_1SHOT			BIT(5)
+#define MAX31865_3WIRE_RTD			BIT(4)
+#define MAX31865_FAULT_STATUS_CLEAR		BIT(1)
+#define MAX31865_FILTER_50HZ			BIT(0)
+
+/* The MAX31865 registers */
+#define MAX31865_CFG_REG			0x00
+#define MAX31865_RTD_MSB			0x01
+#define MAX31865_FAULT_STATUS			0x07
+
+#define MAX31865_FAULT_OVUV			BIT(2)
+
+static const char max31865_show_samp_freq[] = "50 60";
+
+static const struct iio_chan_spec max31865_channels[] = {
+	{	/* RTD Temperature */
+		.type = IIO_TEMP,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
+	},
+};
+
+struct max31865_data {
+	struct spi_device *spi;
+	struct mutex lock;
+	bool filter_50hz;
+	bool three_wire;
+	u8 buf[2] ____cacheline_aligned;
+};
+
+static int max31865_read(struct max31865_data *data, u8 reg,
+			 unsigned int read_size)
+{
+	return spi_write_then_read(data->spi, &reg, 1, data->buf, read_size);
+}
+
+static int max31865_write(struct max31865_data *data, size_t len)
+{
+	return spi_write(data->spi, data->buf, len);
+}
+
+static int enable_bias(struct max31865_data *data)
+{
+	u8 cfg;
+	int ret;
+
+	ret = max31865_read(data, MAX31865_CFG_REG, 1);
+	if (ret)
+		return ret;
+
+	cfg = data->buf[0];
+
+	data->buf[0] = MAX31865_CFG_REG | MAX31865_RD_WR_BIT;
+	data->buf[1] = cfg | MAX31865_CFG_VBIAS;
+
+	return max31865_write(data, 2);
+}
+
+static int disable_bias(struct max31865_data *data)
+{
+	u8 cfg;
+	int ret;
+
+	ret = max31865_read(data, MAX31865_CFG_REG, 1);
+	if (ret)
+		return ret;
+
+	cfg = data->buf[0];
+	cfg &= ~MAX31865_CFG_VBIAS;
+
+	data->buf[0] = MAX31865_CFG_REG | MAX31865_RD_WR_BIT;
+	data->buf[1] = cfg;
+
+	return max31865_write(data, 2);
+}
+
+static int max31865_rtd_read(struct max31865_data *data, int *val)
+{
+	u8 reg;
+	int ret;
+
+	/* Enable BIAS to start the conversion */
+	ret = enable_bias(data);
+	if (ret)
+		return ret;
+
+	/* wait 10.5ms before initiating the conversion */
+	msleep(11);
+
+	ret = max31865_read(data, MAX31865_CFG_REG, 1);
+	if (ret)
+		return ret;
+
+	reg = data->buf[0];
+	reg |= MAX31865_CFG_1SHOT | MAX31865_FAULT_STATUS_CLEAR;
+	data->buf[0] = MAX31865_CFG_REG | MAX31865_RD_WR_BIT;
+	data->buf[1] = reg;
+
+	ret = max31865_write(data, 2);
+	if (ret)
+		return ret;
+
+	if (data->filter_50hz) {
+		/* 50Hz filter mode requires 62.5ms to complete */
+		msleep(63);
+	} else {
+		/* 60Hz filter mode requires 52ms to complete */
+		msleep(52);
+	}
+
+	ret = max31865_read(data, MAX31865_RTD_MSB, 2);
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_be16(&data->buf) >> 1;
+
+	return disable_bias(data);
+}
+
+static int max31865_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max31865_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->lock);
+		ret = max31865_rtd_read(data, val);
+		mutex_unlock(&data->lock);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* Temp. Data resolution is 0.03125 degree centigrade */
+		*val = 31;
+		*val2 = 250000; /* 1000 * 0.03125 */
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max31865_init(struct max31865_data *data)
+{
+	u8 cfg;
+	int ret;
+
+	ret = max31865_read(data, MAX31865_CFG_REG, 1);
+	if (ret)
+		return ret;
+
+	cfg = data->buf[0];
+
+	if (data->three_wire)
+		/* 3-wire RTD connection */
+		cfg |= MAX31865_3WIRE_RTD;
+
+	if (data->filter_50hz)
+		/* 50Hz noise rejection filter */
+		cfg |= MAX31865_FILTER_50HZ;
+
+	data->buf[0] = MAX31865_CFG_REG | MAX31865_RD_WR_BIT;
+	data->buf[1] = cfg;
+
+	return max31865_write(data, 2);
+}
+
+static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
+{
+	int ret;
+	bool fault;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31865_data *data = iio_priv(indio_dev);
+
+	ret = max31865_read(data, MAX31865_FAULT_STATUS, 1);
+	if (ret)
+		return ret;
+
+	fault = data->buf[0] & faultbit;
+
+	return sprintf(buf, "%d\n", fault);
+}
+
+static ssize_t show_fault_ovuv(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return show_fault(dev, MAX31865_FAULT_OVUV, buf);
+}
+
+static ssize_t show_filter(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31865_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->filter_50hz ? 50 : 60);
+}
+
+static ssize_t set_filter(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf,
+			  size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31865_data *data = iio_priv(indio_dev);
+	unsigned int freq;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	switch (freq) {
+	case 50:
+		data->filter_50hz = true;
+		break;
+	case 60:
+		data->filter_50hz = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&data->lock);
+	ret = max31865_init(data);
+	mutex_unlock(&data->lock);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(max31865_show_samp_freq);
+static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
+static IIO_DEVICE_ATTR(in_filter_notch_center_frequency, 0644,
+		    show_filter, set_filter, 0);
+
+static struct attribute *max31865_attributes[] = {
+	&iio_dev_attr_fault_ovuv.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_filter_notch_center_frequency.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group max31865_group = {
+	.attrs = max31865_attributes,
+};
+
+static const struct iio_info max31865_info = {
+	.read_raw = max31865_read_raw,
+	.attrs = &max31865_group,
+};
+
+static int max31865_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct iio_dev *indio_dev;
+	struct max31865_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->spi = spi;
+	data->filter_50hz = false;
+	mutex_init(&data->lock);
+
+	indio_dev->info = &max31865_info;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max31865_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max31865_channels);
+
+	if (of_property_read_bool(spi->dev.of_node, "maxim,3-wire")) {
+		/* select 3 wire */
+		data->three_wire = 1;
+	} else {
+		/* select 2 or 4 wire */
+		data->three_wire = 0;
+	}
+
+	ret = max31865_init(data);
+	if (ret) {
+		dev_err(&spi->dev, "error: Failed to configure max31865\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id max31865_id[] = {
+	{ "max31865", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max31865_id);
+
+static const struct of_device_id max31865_of_match[] = {
+	{ .compatible = "maxim,max31865" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max31865_of_match);
+
+static struct spi_driver max31865_driver = {
+	.driver = {
+		.name	= "max31865",
+		.of_match_table = max31865_of_match,
+	},
+	.probe = max31865_probe,
+	.id_table = max31865_id,
+};
+module_spi_driver(max31865_driver);
+
+MODULE_AUTHOR("Navin Sankar Velliangiri <navin@linumiz.com>");
+MODULE_DESCRIPTION("Maxim MAX31865 RTD-to-Digital Converter sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.32.0

