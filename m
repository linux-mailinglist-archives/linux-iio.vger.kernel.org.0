Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8488014543F
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2020 13:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAVMPl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jan 2020 07:15:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30028 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726204AbgAVMPl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jan 2020 07:15:41 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MCF6qR012257;
        Wed, 22 Jan 2020 07:15:17 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkvrbjpxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 07:15:17 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 00MCFGZW041101
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 22 Jan 2020 07:15:16 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 22 Jan
 2020 07:15:14 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 22 Jan 2020 04:15:14 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00MCF511031122;
        Wed, 22 Jan 2020 07:15:05 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 1/3] iio: amplifiers: hmc425a: Add support for HMC425A step attenuator with gpio interface
Date:   Wed, 22 Jan 2020 14:17:00 +0200
Message-ID: <20200122121702.30494-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001220112
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds support for the HMC425A 0.5 dB LSB GaAs MMIC 6-BIT
DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/amplifiers/Kconfig   |  10 ++
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/hmc425a.c | 251 +++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/iio/amplifiers/hmc425a.c

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index da7f126d197b..9b02c9a2bc8a 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -22,4 +22,14 @@ config AD8366
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad8366.
 
+config HMC425
+	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
+	depends on GPIOLIB
+	help
+	  Say yes here to build support for Analog Devices HMC425A and similar
+	  gain amplifiers or step attenuators.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hmc425a.
+
 endmenu
diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
index 9abef2ebe9bc..19a89db1d9b1 100644
--- a/drivers/iio/amplifiers/Makefile
+++ b/drivers/iio/amplifiers/Makefile
@@ -5,3 +5,4 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD8366) += ad8366.o
+obj-$(CONFIG_HMC425) += hmc425a.o
\ No newline at end of file
diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
new file mode 100644
index 000000000000..0a412d56eb8f
--- /dev/null
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMC425A and similar Gain Amplifiers
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+
+enum hmc425a_type {
+	ID_HMC425A,
+};
+
+struct hmc425a_chip_info {
+	const char			*name;
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
+	unsigned int			num_gpios;
+	int				gain_min;
+	int				gain_max;
+	int				default_gain;
+};
+
+struct hmc425a_state {
+	struct	regulator *reg;
+	struct	mutex lock; /* protect sensor state */
+	struct	hmc425a_chip_info *chip_info;
+	struct	gpio_descs *gpios;
+	enum	hmc425a_type type;
+	u32	gain;
+};
+
+static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
+{
+	struct hmc425a_state *st = iio_priv(indio_dev);
+	int i, *values;
+
+	values = kmalloc_array(st->chip_info->num_gpios, sizeof(int),
+			       GFP_KERNEL);
+	if (!values)
+		return -ENOMEM;
+
+	for (i = 0; i < st->chip_info->num_gpios; i++)
+		values[i] = (value >> i) & 1;
+
+	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
+				       values);
+	kfree(values);
+	return 0;
+}
+
+static int hmc425a_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long m)
+{
+	struct hmc425a_state *st = iio_priv(indio_dev);
+	int code, gain = 0;
+	int ret;
+
+	mutex_lock(&st->lock);
+	switch (m) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		code = st->gain;
+
+		switch (st->type) {
+		case ID_HMC425A:
+			gain = ~code * -500;
+			break;
+		}
+
+		*val = gain / 1000;
+		*val2 = (gain % 1000) * 1000;
+
+		ret = IIO_VAL_INT_PLUS_MICRO_DB;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+};
+
+static int hmc425a_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct hmc425a_state *st = iio_priv(indio_dev);
+	struct hmc425a_chip_info *inf = st->chip_info;
+	int code = 0, gain;
+	int ret;
+
+	if (val < 0)
+		gain = (val * 1000) - (val2 / 1000);
+	else
+		gain = (val * 1000) + (val2 / 1000);
+
+	if (gain > inf->gain_max || gain < inf->gain_min)
+		return -EINVAL;
+
+	switch (st->type) {
+	case ID_HMC425A:
+		code = ~((abs(gain) / 500) & 0x3F);
+		break;
+	}
+
+	mutex_lock(&st->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		st->gain = code;
+
+		ret = hmc425a_write(indio_dev, st->gain);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static const struct iio_info hmc425a_info = {
+	.read_raw = &hmc425a_read_raw,
+	.write_raw = &hmc425a_write_raw,
+};
+
+#define HMC425A_CHAN(_channel)                                          \
+{                                                                      \
+	.type = IIO_VOLTAGE, .output = 1, .indexed = 1,                \
+	.channel = _channel,                                           \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),         \
+}
+
+static const struct iio_chan_spec hmc425a_channels[] = {
+	HMC425A_CHAN(0),
+};
+
+/* Match table for of_platform binding */
+static const struct of_device_id hmc425a_of_match[] = {
+	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hmc425a_of_match);
+
+static void hmc425a_reg_disable(void *data)
+{
+	struct hmc425a_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
+static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
+	[ID_HMC425A] = {
+		.name = "hmc425a",
+		.channels = hmc425a_channels,
+		.num_channels = ARRAY_SIZE(hmc425a_channels),
+		.num_gpios = 6,
+		.gain_min = -31500,
+		.gain_max = 0,
+		.default_gain = -0x40, /* set default gain -31.5db*/
+	},
+};
+
+static int hmc425a_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *id;
+	struct iio_dev *indio_dev;
+	struct hmc425a_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	id = of_match_device(hmc425a_of_match, &pdev->dev);
+	if (!id)
+		ret = -ENODEV;
+
+	st->type = (enum hmc425a_type)id->data;
+
+	st->chip_info = &hmc425a_chip_info_tbl[st->type];
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->name = st->chip_info->name;
+	st->gain = st->chip_info->default_gain;
+
+	st->gpios = devm_gpiod_get_array(&pdev->dev, "ctrl", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpios)) {
+		ret = PTR_ERR(st->gpios);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get gpios\n");
+		return ret;
+	}
+
+	if (st->gpios->ndescs != st->chip_info->num_gpios) {
+		dev_err(&pdev->dev, "%d GPIOs needed to operate\n",
+			st->chip_info->num_gpios);
+		return -ENODEV;
+	}
+
+	st->reg = devm_regulator_get_optional(&pdev->dev, "vcc-supply");
+	if (IS_ERR(st->reg)) {
+		if (PTR_ERR(st->reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		st->reg = NULL;
+	} else {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(&pdev->dev, hmc425a_reg_disable,
+					       st);
+		if (ret)
+			return ret;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+	mutex_init(&st->lock);
+
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &hmc425a_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver hmc425a_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = hmc425a_of_match,
+	},
+	.probe = hmc425a_probe,
+};
+module_platform_driver(hmc425a_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices HMC425A and similar GPIO control Gain Amplifiers");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

