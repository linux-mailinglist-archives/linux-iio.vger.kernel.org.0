Return-Path: <linux-iio+bounces-25765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C799C261EC
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BEF0467E9F
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6F2F49FC;
	Fri, 31 Oct 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h6GgfEQp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF93F2F39A2;
	Fri, 31 Oct 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926678; cv=none; b=akJDk0qKd8Lqq+frXpfyhl4Td2FGq2n3g8WSb1O8+MFmhHE8jkDbS7PjOAhUl4sUxBSXpnY2o/CPD0efaSvgNlfgS3mDiv+QZhZMIj8ouH1P+DYE0WU9yJMSfhxnI6A5C3q0fsRaF3fmo9CTQ6ikhUROQO8jo6OPTDPunLbDR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926678; c=relaxed/simple;
	bh=blVqUcUzKxEJJlIh6iG0LdcfhNncKpWXQAlkPsrzzVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QO/DGP8TP68zJv6mdfgYk1sXJt/WlNkblSeEVXUUEajytvb/WjRk6k02b276bqcEGc9/gj6IS5wE+MQD/rokqmnNSZSQz0a4PUEKR9113d5yhJNYa3ecEAdi1VLhq07LRB6JJ2RrPIPBInChJC99fS07g5r8HZLH3SN95fMFZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h6GgfEQp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VDvg0Z1108539;
	Fri, 31 Oct 2025 12:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=2S48F
	aLVKvvE61pzF2BaBmKyYzUkJR5ipows9oemtjA=; b=h6GgfEQp+eSFOy4xGpetK
	Xr95DIM0WHmh59MidKArQnBdw9iadsgeNEU3HyZzfbVNhyOuRttyJ2W5T+Oc+Ftg
	iFkPt1MkqLt1CEIvkJZ9whr4eB6L10Wgz6T4gpl/Pnvk1q1ChESC1FSvJsNywwcV
	W4yPAqt8fkDkpLPCJNVze5Zx/466f1Q+GlumlhDfhu1FQGThFXVJ64ZW8d3HedbI
	9mkfi3dfDg8fXfj7vFOMUV1jMO2M6gwqpC3LdCTanDivMT+ngUaW/Bl0raxbozrU
	zLFzjD5Vz8gclaf3Ph8mwvikwJgm0+/LafnBcKBtQxb3cN3thY0xd74O4kHXaZjT
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4a4p8atvfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 12:04:34 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59VG4WtU064375
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 Oct 2025 12:04:32 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Oct 2025 12:04:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 31 Oct 2025 12:04:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 31 Oct 2025 12:04:32 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59VG4K1M006874;
	Fri, 31 Oct 2025 12:04:28 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/3] iio: amplifiers: adl8113: add driver support
Date: Fri, 31 Oct 2025 16:04:04 +0000
Message-ID: <20251031160405.13286-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031160405.13286-1-antoniu.miclaus@analog.com>
References: <20251031160405.13286-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R4QO2NRX c=1 sm=1 tr=0 ts=6904de12 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=zrLN1I9oeIiPOX2w8Z4A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: iPjwVNdzILxibjbeMQwSC_jR-PJ_j2a9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE0NCBTYWx0ZWRfXwtMcWcXxKCpQ
 3qEdbu8KI9yEw3iVTUZu49zPDBHbQlahb54IotnvYqWmoX0npoRLbDdKcfuqwrJ+/PBIj5IWoFu
 uLOc0BfaFPAVW8JyCatA6TSs48Rq9W08WtaDtCcplD/ixtq+9Qus72Xh5WfV0TEfVDJ965ncJm7
 /x6ULR6BEtP0olFfafU/RGyIAZRnL6v1PaGs3Gk+XZexPlevs0hU+PMLGmDb+tBDuk+jNliwSVE
 1qNnd7E7c14ZhG/H5+NPexnNLlvxFKvloPI7utT1w7OxVCQiH6CfURXBEE+nckgOoLKz9yBTCTy
 et9elPIRzyCg64zwqo3Ntc0UJp7twMdmHQVmFTLqCquksB9J3OdRjfHzHUoS29/TwMVE/d+YF0v
 XIgaaDG65VaDU4kgWDabI2hKJuM0vg==
X-Proofpoint-GUID: iPjwVNdzILxibjbeMQwSC_jR-PJ_j2a9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310144

Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
10MHz to 14GHz bypass switches.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/amplifiers/Kconfig   |  12 ++
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/adl8113.c | 235 +++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/iio/amplifiers/adl8113.c

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index 55eb16b32f6c..a8a604863eed 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -36,6 +36,18 @@ config ADA4250
 	  To compile this driver as a module, choose M here: the
 	  module will be called ada4250.
 
+config ADL8113
+	tristate "Analog Devices ADL8113 Low Noise Amplifier"
+	depends on GPIOLIB
+	help
+	  Say yes here to build support for Analog Devices ADL8113 Low Noise
+	  Amplifier with integrated bypass switches. The device supports four
+	  operation modes controlled by GPIO pins: internal amplifier,
+	  internal bypass, and two external bypass modes.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adl8113.
+
 config HMC425
 	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
 	depends on GPIOLIB
diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
index 2126331129cf..0a76443be1aa 100644
--- a/drivers/iio/amplifiers/Makefile
+++ b/drivers/iio/amplifiers/Makefile
@@ -6,4 +6,5 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD8366) += ad8366.o
 obj-$(CONFIG_ADA4250) += ada4250.o
+obj-$(CONFIG_ADL8113) += adl8113.o
 obj-$(CONFIG_HMC425) += hmc425a.o
diff --git a/drivers/iio/amplifiers/adl8113.c b/drivers/iio/amplifiers/adl8113.c
new file mode 100644
index 000000000000..4a05c1497913
--- /dev/null
+++ b/drivers/iio/amplifiers/adl8113.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADL8113 Low Noise Amplifier with integrated bypass switches
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+enum adl8113_mode {
+	ADL8113_INTERNAL_AMPLIFIER,
+	ADL8113_INTERNAL_BYPASS,
+	ADL8113_EXTERNAL_BYPASS_A,
+	ADL8113_EXTERNAL_BYPASS_B
+};
+
+struct adl8113_state {
+	struct mutex lock; /* protect sensor state */
+	struct gpio_desc *gpio_va;
+	struct gpio_desc *gpio_vb;
+	enum adl8113_mode current_mode;
+};
+
+static const char * const adl8113_supply_names[] = {
+	"vdd1",
+	"vdd2",
+	"vss2"
+};
+
+static const char * const adl8113_mode_names[] = {
+	[ADL8113_INTERNAL_AMPLIFIER] = "internal_amplifier",
+	[ADL8113_INTERNAL_BYPASS] = "internal_bypass",
+	[ADL8113_EXTERNAL_BYPASS_A] = "external_bypass_a",
+	[ADL8113_EXTERNAL_BYPASS_B] = "external_bypass_b",
+};
+
+static int adl8113_set_mode(struct adl8113_state *st, enum adl8113_mode mode)
+{
+	switch (mode) {
+	case ADL8113_INTERNAL_AMPLIFIER:
+		gpiod_set_value(st->gpio_va, 0);
+		gpiod_set_value(st->gpio_vb, 0);
+		break;
+	case ADL8113_INTERNAL_BYPASS:
+		gpiod_set_value(st->gpio_va, 1);
+		gpiod_set_value(st->gpio_vb, 1);
+		break;
+	case ADL8113_EXTERNAL_BYPASS_A:
+		gpiod_set_value(st->gpio_va, 0);
+		gpiod_set_value(st->gpio_vb, 1);
+		break;
+	case ADL8113_EXTERNAL_BYPASS_B:
+		gpiod_set_value(st->gpio_va, 1);
+		gpiod_set_value(st->gpio_vb, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	st->current_mode = mode;
+	return 0;
+}
+
+static int adl8113_get_mode(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan)
+{
+	struct adl8113_state *st = iio_priv(indio_dev);
+
+	return st->current_mode;
+}
+
+static int adl8113_set_mode_enum(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 unsigned int mode)
+{
+	struct adl8113_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (mode >= ARRAY_SIZE(adl8113_mode_names))
+		return -EINVAL;
+
+	mutex_lock(&st->lock);
+	ret = adl8113_set_mode(st, mode);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static const struct iio_enum adl8113_mode_enum = {
+	.items = adl8113_mode_names,
+	.num_items = ARRAY_SIZE(adl8113_mode_names),
+	.get = adl8113_get_mode,
+	.set = adl8113_set_mode_enum,
+};
+
+static const struct iio_chan_spec_ext_info adl8113_ext_info[] = {
+	IIO_ENUM("mode", IIO_SHARED_BY_ALL, &adl8113_mode_enum),
+	IIO_ENUM_AVAILABLE("mode", IIO_SHARED_BY_ALL, &adl8113_mode_enum),
+	{ },
+};
+
+static const struct iio_chan_spec adl8113_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.indexed = 1,
+		.channel = 0,
+		.ext_info = adl8113_ext_info,
+	},
+};
+
+static int adl8113_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct adl8113_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		mutex_lock(&st->lock);
+		switch (st->current_mode) {
+		case ADL8113_INTERNAL_AMPLIFIER:
+			*val = 14;
+			*val2 = 0;
+			ret = IIO_VAL_INT_PLUS_MICRO_DB;
+			break;
+		case ADL8113_INTERNAL_BYPASS:
+		case ADL8113_EXTERNAL_BYPASS_A:
+		case ADL8113_EXTERNAL_BYPASS_B:
+			*val = 0;
+			*val2 = 0;
+			ret = IIO_VAL_INT_PLUS_MICRO_DB;
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		mutex_unlock(&st->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adl8113_info = {
+	.read_raw = adl8113_read_raw,
+};
+
+static int adl8113_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct adl8113_state *st;
+	struct iio_dev *indio_dev;
+	u32 initial_mode = ADL8113_INTERNAL_AMPLIFIER;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	mutex_init(&st->lock);
+
+	st->gpio_va = devm_gpiod_get(dev, "va", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_va))
+		return dev_err_probe(dev, PTR_ERR(st->gpio_va),
+				     "failed to get VA GPIO\n");
+
+	st->gpio_vb = devm_gpiod_get(dev, "vb", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_vb))
+		return dev_err_probe(dev, PTR_ERR(st->gpio_vb),
+				     "failed to get VB GPIO\n");
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(adl8113_supply_names),
+					     adl8113_supply_names);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get and enable supplies\n");
+
+	device_property_read_u32(dev, "adi,initial-mode", &initial_mode);
+	if (initial_mode >= ARRAY_SIZE(adl8113_mode_names))
+		return -EINVAL;
+
+	ret = adl8113_set_mode(st, initial_mode);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &adl8113_info;
+	indio_dev->name = "adl8113";
+	indio_dev->channels = adl8113_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adl8113_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "ADL8113 registered, initial mode: %s\n",
+		 adl8113_mode_names[initial_mode]);
+
+	return 0;
+}
+
+static const struct of_device_id adl8113_of_match[] = {
+	{ .compatible = "adi,adl8113" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, adl8113_of_match);
+
+static struct platform_driver adl8113_driver = {
+	.driver = {
+		.name = "adl8113",
+		.of_match_table = adl8113_of_match,
+	},
+	.probe = adl8113_probe,
+};
+
+module_platform_driver(adl8113_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADL8113 Low Noise Amplifier");
+MODULE_LICENSE("GPL");
-- 
2.43.0


