Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC440221D5B
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 09:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgGPHZu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 03:25:50 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:10078 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbgGPHZt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 03:25:49 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G7I7YH004937;
        Thu, 16 Jul 2020 03:25:48 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 327ab4xwja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 03:25:48 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06G7PlbV021831
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 16 Jul 2020 03:25:47 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jul 2020 03:25:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Jul 2020 03:25:45 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Jul 2020 03:25:45 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06G7PgcL025456;
        Thu, 16 Jul 2020 03:25:43 -0400
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [RFC PATCH] one-bit-adc-dac: Add initial version of one bit ADC, DAC
Date:   Thu, 16 Jul 2020 10:27:37 +0300
Message-ID: <20200716072737.9535-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_04:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160056
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Implementation for 1-bit ADC (comparator) and a 1-bit DAC (switch)

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 drivers/iio/addac/one-bit-adc-dac.c | 229 ++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)
 create mode 100644 drivers/iio/addac/one-bit-adc-dac.c

diff --git a/drivers/iio/addac/one-bit-adc-dac.c b/drivers/iio/addac/one-bit-adc-dac.c
new file mode 100644
index 000000000000..8e2a8a09fedb
--- /dev/null
+++ b/drivers/iio/addac/one-bit-adc-dac.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices ONE_BIT_ADC_DAC
+ * Digital to Analog Converters driver
+ *
+ * Copyright 2019 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
+
+enum ch_direction {
+	CH_IN,
+	CH_OUT,
+};
+
+struct one_bit_adc_dac_state {
+	struct platform_device  *pdev;
+	struct gpio_descs       *in_gpio_descs;
+	struct gpio_descs       *out_gpio_descs;
+};
+
+ #define ONE_BIT_ADC_DAC_CHANNEL(idx, direction)			\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = idx,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.output = direction,					\
+	}
+
+static int one_bit_adc_dac_read_raw(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, int *val, int *val2, long info)
+{
+	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
+	int in_num_ch = 0, out_num_ch = 0;
+	int channel = chan->channel;
+
+	if (st->in_gpio_descs)
+		in_num_ch = st->in_gpio_descs->ndescs;
+
+	if (st->out_gpio_descs)
+		out_num_ch = st->out_gpio_descs->ndescs;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (channel < in_num_ch) {
+			*val = gpiod_get_value_cansleep(
+				st->in_gpio_descs->desc[channel]);
+		} else {
+			channel -= in_num_ch;
+			*val = gpiod_get_value_cansleep(
+				st->out_gpio_descs->desc[channel]);
+		}
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int one_bit_adc_dac_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long info)
+{
+	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
+	int in_num_ch = 0, out_num_ch = 0;
+	int channel = chan->channel;
+
+	if (st->in_gpio_descs)
+		in_num_ch = st->in_gpio_descs->ndescs;
+
+	if (st->out_gpio_descs)
+		out_num_ch = st->out_gpio_descs->ndescs;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (channel < in_num_ch) {
+			gpiod_set_value_cansleep(
+				st->in_gpio_descs->desc[channel], val);
+		} else {
+			channel -= in_num_ch;
+			gpiod_set_value_cansleep(
+				st->out_gpio_descs->desc[channel], val);
+		}
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info one_bit_adc_dac_info = {
+	.read_raw = &one_bit_adc_dac_read_raw,
+	.write_raw = &one_bit_adc_dac_write_raw,
+};
+
+static int one_bit_adc_dac_set_ch(struct iio_dev *indio_dev,
+					struct iio_chan_spec *channels,
+					const char *propname,
+					int num_ch,
+					enum ch_direction direction,
+					int offset)
+{
+	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
+	const char **gpio_names;
+	int ret, i;
+
+	if (num_ch <= 0)
+		return 0;
+
+	gpio_names = devm_kcalloc(indio_dev->dev.parent,
+					num_ch,
+					sizeof(char *),
+					GFP_KERNEL);
+	if (!gpio_names)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(&st->pdev->dev,
+					propname,
+					gpio_names,
+					num_ch);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < num_ch; i++) {
+		channels[i] = (struct iio_chan_spec)ONE_BIT_ADC_DAC_CHANNEL(i +
+							offset,
+							direction);
+		channels[i].extend_name = gpio_names[i];
+	}
+
+	return 0;
+}
+
+static int one_bit_adc_dac_parse_dt(struct iio_dev *indio_dev)
+{
+	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *channels;
+	int ret, in_num_ch = 0, out_num_ch = 0;
+
+	st->in_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev,
+						"in", GPIOD_IN);
+	if (IS_ERR(st->in_gpio_descs))
+		return PTR_ERR(st->in_gpio_descs);
+
+	if (st->in_gpio_descs)
+		in_num_ch = st->in_gpio_descs->ndescs;
+
+	st->out_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev,
+						"out", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->out_gpio_descs))
+		return PTR_ERR(st->out_gpio_descs);
+
+	if (st->out_gpio_descs)
+		out_num_ch = st->out_gpio_descs->ndescs;
+
+	channels = devm_kcalloc(indio_dev->dev.parent, (in_num_ch + out_num_ch),
+				sizeof(struct iio_chan_spec), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	ret = one_bit_adc_dac_set_ch(indio_dev, &channels[0],
+					"in-gpio-names", in_num_ch,
+					CH_IN, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = one_bit_adc_dac_set_ch(indio_dev, &channels[in_num_ch],
+					"out-gpio-names", out_num_ch,
+					CH_OUT, in_num_ch);
+	if (ret < 0)
+		return ret;
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = in_num_ch + out_num_ch;
+
+	return 0;
+}
+
+static int one_bit_adc_dac_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct one_bit_adc_dac_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->pdev = pdev;
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = "one-bit-adc-dac";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &one_bit_adc_dac_info;
+
+	ret = one_bit_adc_dac_parse_dt(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, indio_dev);
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
+}
+
+static const struct of_device_id one_bit_adc_dac_dt_match[] = {
+	{ .compatible = "adi,one-bit-adc-dac" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, one_bit_adc_dac_dt_match);
+
+static struct platform_driver one_bit_adc_dac_driver = {
+	.driver = {
+		.name = "one-bit-adc-dac",
+		.of_match_table = one_bit_adc_dac_dt_match,
+	},
+	.probe = one_bit_adc_dac_probe,
+};
+
+module_platform_driver(one_bit_adc_dac_driver);
+
+MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ONE_BIT_ADC_DAC");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

