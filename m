Return-Path: <linux-iio+bounces-1861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD5838899
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 09:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34910285471
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B8B56450;
	Tue, 23 Jan 2024 08:11:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B455E6E;
	Tue, 23 Jan 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997515; cv=none; b=ntuqCjd6bMLIb1SNPEwmJ5EuQNNki6E0FiOEHVw6X/fm+HV7EI1CxmZ8vTnJdVsSr/LSReUgnVVL6oD8RjtkuPW+RBwvU5YqTN1HhZ9bjyy0UtMsIx3SEAv0KZrn6shCG+PKy2SuKlJEbIEd/BuqCXwZqcKwjQDwKDdUYQAiVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997515; c=relaxed/simple;
	bh=5t4rlDqowBi60YxyRbmb3awuAXVen9xeXsK14gLnFOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5GWzBXZaF8g4VC04EmwqacDHE0hIo0Tkt0tmkqKvUkwOc8gq0x/AWPzxHIVPjzy6EbhOEnDLNCPRaPGI+fw18RpECKx2/ijEmYoI1E0Sumb8VjF/288gPct3rJ1/FiuXy69zx6WIEaDCekHIXizzlEnS3rczRLdbQ3E7Q7VqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N3Git6008380;
	Tue, 23 Jan 2024 03:11:37 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vrby7380w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 03:11:36 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 40N8BZDx023442
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 03:11:35 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 23 Jan 2024 03:11:34 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 23 Jan 2024 03:11:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 23 Jan 2024 03:11:34 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.34])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40N8BAa5032262;
	Tue, 23 Jan 2024 03:11:23 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, "Crt
 Mori" <cmo@melexis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v8 2/2] iio: frequency: admfm2000: New driver
Date: Tue, 23 Jan 2024 16:10:59 +0800
Message-ID: <20240123081059.5746-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123081059.5746-1-kimseer.paller@analog.com>
References: <20240123081059.5746-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -3ilConIpXRreR9iHcBpuFy_RfcBB5sm
X-Proofpoint-ORIG-GUID: -3ilConIpXRreR9iHcBpuFy_RfcBB5sm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_02,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401230058

Dual microwave down converter module with input RF and LO frequency
ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
for each down conversion path.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V7 -> V8: No changes.
V6 -> V7: Removed unnecessary include. Used fwnode_property_present for
	  checking mixer mode property. Reduced code duplicate in channel
	  config function. Misc changes(extra spaces, year, etc.)
V5 -> V6: Used devm_fwnode_gpiod_get_index for getting array of gpios.
V4 -> V5: Added missing return -ENODEV in setup function. Reordered variable
	  declarations in probe function.
V1 -> V4: No changes.

 MAINTAINERS                       |   1 +
 drivers/iio/frequency/Kconfig     |  10 ++
 drivers/iio/frequency/Makefile    |   1 +
 drivers/iio/frequency/admfm2000.c | 282 ++++++++++++++++++++++++++++++
 4 files changed, 294 insertions(+)
 create mode 100644 drivers/iio/frequency/admfm2000.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f7cd2e848de..e2bd41485107 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1273,6 +1273,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
+F:	drivers/iio/frequency/admfm2000.c
 
 ANALOG DEVICES INC ADMV1013 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 9e85dfa58508..c455be7d4a1c 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -60,6 +60,16 @@ config ADF4377
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4377.
 
+config ADMFM2000
+	tristate "Analog Devices ADMFM2000 Dual Microwave Down Converter"
+	depends on GPIOLIB
+	help
+	  Say yes here to build support for Analog Devices ADMFM2000 Dual
+	  Microwave Down Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called admfm2000.
+
 config ADMV1013
 	tristate "Analog Devices ADMV1013 Microwave Upconverter"
 	depends on SPI && COMMON_CLK
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index b616c29b4a08..70d0e0b70e80 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
 obj-$(CONFIG_ADF4377) += adf4377.o
+obj-$(CONFIG_ADMFM2000) += admfm2000.o
 obj-$(CONFIG_ADMV1013) += admv1013.o
 obj-$(CONFIG_ADMV1014) += admv1014.o
 obj-$(CONFIG_ADMV4420) += admv4420.o
diff --git a/drivers/iio/frequency/admfm2000.c b/drivers/iio/frequency/admfm2000.c
new file mode 100644
index 000000000000..c34d79e55a7c
--- /dev/null
+++ b/drivers/iio/frequency/admfm2000.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADMFM2000 Dual Microwave Down Converter
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#define ADMFM2000_MIXER_MODE		0
+#define ADMFM2000_DIRECT_IF_MODE	1
+#define ADMFM2000_DSA_GPIOS		5
+#define ADMFM2000_MODE_GPIOS		2
+#define ADMFM2000_MAX_GAIN		0
+#define ADMFM2000_MIN_GAIN		-31000
+#define ADMFM2000_DEFAULT_GAIN		-0x20
+
+struct admfm2000_state {
+	struct mutex			lock; /* protect sensor state */
+	struct gpio_desc		*sw1_ch[2];
+	struct gpio_desc		*sw2_ch[2];
+	struct gpio_desc		*dsa1_gpios[5];
+	struct gpio_desc		*dsa2_gpios[5];
+	u32				gain[2];
+};
+
+static int admfm2000_mode(struct iio_dev *indio_dev, u32 chan, u32 mode)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int i;
+
+	switch (mode) {
+	case ADMFM2000_MIXER_MODE:
+		for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
+			gpiod_set_value_cansleep(st->sw1_ch[i], (chan == 0) ? 1 : 0);
+			gpiod_set_value_cansleep(st->sw2_ch[i], (chan == 0) ? 0 : 1);
+		}
+		return 0;
+	case ADMFM2000_DIRECT_IF_MODE:
+		for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
+			gpiod_set_value_cansleep(st->sw1_ch[i], (chan == 0) ? 0 : 1);
+			gpiod_set_value_cansleep(st->sw2_ch[i], (chan == 0) ? 1 : 0);
+		}
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admfm2000_attenuation(struct iio_dev *indio_dev, u32 chan, u32 value)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int i;
+
+	switch (chan) {
+	case 0:
+		for (i = 0; i < ADMFM2000_DSA_GPIOS; i++)
+			gpiod_set_value_cansleep(st->dsa1_gpios[i], value & (1 << i));
+		return 0;
+	case 1:
+		for (i = 0; i < ADMFM2000_DSA_GPIOS; i++)
+			gpiod_set_value_cansleep(st->dsa2_gpios[i], value & (1 << i));
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admfm2000_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int *val,
+			      int *val2, long mask)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int gain;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		mutex_lock(&st->lock);
+		gain = ~(st->gain[chan->channel]) * -1000;
+		*val = gain / 1000;
+		*val2 = (gain % 1000) * 1000;
+		mutex_unlock(&st->lock);
+
+		return IIO_VAL_INT_PLUS_MICRO_DB;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admfm2000_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan, int val,
+			       int val2, long mask)
+{
+	struct admfm2000_state *st = iio_priv(indio_dev);
+	int gain, ret;
+
+	if (val < 0)
+		gain = (val * 1000) - (val2 / 1000);
+	else
+		gain = (val * 1000) + (val2 / 1000);
+
+	if (gain > ADMFM2000_MAX_GAIN || gain < ADMFM2000_MIN_GAIN)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		mutex_lock(&st->lock);
+		st->gain[chan->channel] = ~((abs(gain) / 1000) & 0x1F);
+
+		ret = admfm2000_attenuation(indio_dev, chan->channel,
+					    st->gain[chan->channel]);
+		mutex_unlock(&st->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int admfm2000_write_raw_get_fmt(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return IIO_VAL_INT_PLUS_MICRO_DB;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info admfm2000_info = {
+	.read_raw = &admfm2000_read_raw,
+	.write_raw = &admfm2000_write_raw,
+	.write_raw_get_fmt = &admfm2000_write_raw_get_fmt,
+};
+
+#define ADMFM2000_CHAN(_channel) {					\
+	.type = IIO_VOLTAGE,						\
+	.output = 1,							\
+	.indexed = 1,							\
+	.channel = _channel,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
+}
+
+static const struct iio_chan_spec admfm2000_channels[] = {
+	ADMFM2000_CHAN(0),
+	ADMFM2000_CHAN(1),
+};
+
+static int admfm2000_channel_config(struct admfm2000_state *st,
+				    struct iio_dev *indio_dev)
+{
+	struct platform_device *pdev = to_platform_device(indio_dev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *child;
+	struct gpio_desc **dsa;
+	struct gpio_desc **sw;
+	int ret, i;
+	bool mode;
+	u32 reg;
+
+	device_for_each_child_node(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, ret,
+					     "Failed to get reg property\n");
+		}
+
+		if (reg >= indio_dev->num_channels) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL, "reg bigger than: %d\n",
+					     indio_dev->num_channels);
+		}
+
+		if (fwnode_property_present(child, "adi,mixer-mode"))
+			mode = ADMFM2000_MIXER_MODE;
+		else
+			mode = ADMFM2000_DIRECT_IF_MODE;
+
+		switch (reg) {
+		case 0:
+			sw = st->sw1_ch;
+			dsa = st->dsa1_gpios;
+			break;
+		case 1:
+			sw = st->sw2_ch;
+			dsa = st->dsa2_gpios;
+			break;
+		default:
+			fwnode_handle_put(child);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < ADMFM2000_MODE_GPIOS; i++) {
+			sw[i] = devm_fwnode_gpiod_get_index(dev, child, "switch",
+							    i, GPIOD_OUT_LOW, NULL);
+			if (IS_ERR(sw[i])) {
+				fwnode_handle_put(child);
+				return dev_err_probe(dev, PTR_ERR(sw[i]),
+						     "Failed to get gpios\n");
+			}
+		}
+
+		for (i = 0; i < ADMFM2000_DSA_GPIOS; i++) {
+			dsa[i] = devm_fwnode_gpiod_get_index(dev, child,
+							     "attenuation", i,
+							     GPIOD_OUT_LOW, NULL);
+			if (IS_ERR(dsa[i])) {
+				fwnode_handle_put(child);
+				return dev_err_probe(dev, PTR_ERR(dsa[i]),
+						     "Failed to get gpios\n");
+			}
+		}
+
+		ret = admfm2000_mode(indio_dev, reg, mode);
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int admfm2000_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct admfm2000_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	indio_dev->name = "admfm2000";
+	indio_dev->num_channels = ARRAY_SIZE(admfm2000_channels);
+	indio_dev->channels = admfm2000_channels;
+	indio_dev->info = &admfm2000_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	st->gain[0] = ADMFM2000_DEFAULT_GAIN;
+	st->gain[1] = ADMFM2000_DEFAULT_GAIN;
+
+	mutex_init(&st->lock);
+
+	ret = admfm2000_channel_config(st, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id admfm2000_of_match[] = {
+	{ .compatible = "adi,admfm2000" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, admfm2000_of_match);
+
+static struct platform_driver admfm2000_driver = {
+	.driver = {
+		.name = "admfm2000",
+		.of_match_table = admfm2000_of_match,
+	},
+	.probe = admfm2000_probe,
+};
+module_platform_driver(admfm2000_driver);
+
+MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
+MODULE_DESCRIPTION("ADMFM2000 Dual Microwave Down Converter");
+MODULE_LICENSE("GPL");
-- 
2.34.1


