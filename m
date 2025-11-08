Return-Path: <linux-iio+bounces-26047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FABC43256
	for <lists+linux-iio@lfdr.de>; Sat, 08 Nov 2025 18:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2F5188D988
	for <lists+linux-iio@lfdr.de>; Sat,  8 Nov 2025 17:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853A72727EE;
	Sat,  8 Nov 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yQZwfQpr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880B26C39F;
	Sat,  8 Nov 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623861; cv=none; b=tzcV9SwoGl8UrNI7GvtqaWl/YxLiDL6hMXdeyeR9r8LOwQmCk/RoNnA6XpGFyPMv7Luc1J8243uWtwfIsd0N9H9XrUi1Oj9luzJLP1nU2pxc/gM6rl7saLL6edg1U4weEiBbU9qjDT0zO3swez//a6ausg2vtaY2DzbHrpbkTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623861; c=relaxed/simple;
	bh=9odIXia73mWpFwTYGmvtR/z9/wOjDPbjWMkSq7anWN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExKAnLAM5YCb507Iuv97l35cSuonPbDyJAdcALkeKhzymt451oiLZwf1mcRxAFmRNteZlvGGY4eOh5/D3xC9LVWvLQfJQK1csotnWUXo+7V4TgGKrOzm6IxadN0E+bZFhVUQxup8/D0F62yeVXw7xOygCqWjEAZlJfb8bgbJZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yQZwfQpr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8HOdaT4004306;
	Sat, 8 Nov 2025 12:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xi/ru
	2reSNRqNlJrQiz1POgyIwtuZqoUWtNqyrDU69g=; b=yQZwfQprywzUbeIli7vpv
	hwLjn5frV51yoJL/fk+7aGI/8tcuCY5xLYEjChywOSWNExuLyj7vffVfrmV+tAiY
	DSmu9f8lBaeATeWMVm0naJF7FA0pMf/I+TUKSgPhvGvIkUMhEP9D4ju8q7umgLJy
	A7UK6q59HurCN3PVwJY2x96chamOgBCQZ0l9jfJ7nsHI4U8pFDZoFC7ww3eI3GB7
	jxioq1opI6RCsdGZQIxrf11DiC94EYubphzEs6h6WHAkNpiJGYV6RHHFp/F8Y71z
	187J2eExqRvQDqHNI3x9TX8VYtG7PzE57C85w+GPr4h3UjaN+V9kMbiinJpFz5TD
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aa3n69cd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Nov 2025 12:44:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5A8HiFge010288
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 8 Nov 2025 12:44:15 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 8 Nov
 2025 12:44:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 8 Nov 2025 12:44:15 -0500
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5A8Hi4Xj028553;
	Sat, 8 Nov 2025 12:44:11 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 2/3] iio: amplifiers: adl8113: add driver support
Date: Sat, 8 Nov 2025 17:43:53 +0000
Message-ID: <20251108174357.3748-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251108174357.3748-1-antoniu.miclaus@analog.com>
References: <20251108174357.3748-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=JoD8bc4C c=1 sm=1 tr=0 ts=690f8170 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=1dhURQ85q9Mw_Kxh2T0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: eAe5sbFaaCzNhPqaWNzAtfvCOEUA_swW
X-Proofpoint-ORIG-GUID: eAe5sbFaaCzNhPqaWNzAtfvCOEUA_swW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0MyBTYWx0ZWRfX27BM05+HhtZF
 0ewqPRnWGZ8u09HQon78o53/SBIeZQ702jeucD5pOtSgjmqM6IO8FSBggwAG+8nDK085HO34f9I
 hzRvXn1RAyQLY8MfjNv3e623gXfj4wPnk0Ffa8i64LqJBIM6XtaqEllEfol3FEtQ5B89IHNCICD
 rrSj/qWrytbTWE/FT0RP0KGfa9+j9yhl/b0hP6gOhxSn5po2Lhvboky74ZRlCI0tsm9nVqH982R
 RfoVHBRY4e9BJj5EAeBkRctSgnOpOnTj85Zr1A263bBMq/qt+LZfgPSpMuoKyK/ETvrzNAia66R
 pP5kfplaeUvryHm8PAPDhaQ1bf4Z/8gF6+PRMXUrcDxq1+fvGmb2h0pgP1ML1s82orOMiBTWYiZ
 yB+WxXQGwRxeJ2PYfpDwxzEmbwgHgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511080143

Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
10MHz to 14GHz bypass switches.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---

Changes in v2:
- Add linux/array_size.h include for ARRAY_SIZE macro usage
- Remove linux/kernel.h and linux/mutex.h includes (no longer needed)
- Remove mutex lock from struct adl8113_state (simplify concurrency model)
- Add trailing comma to ADL8113_EXTERNAL_BYPASS_B enum value for consistency
- Simplify adl8113_set_mode_enum() by removing mutex locking and direct return
- Reorder case statements in adl8113_read_raw() for external bypass modes
- Remove mutex locking from hardware gain reading operation
- Remove adi,initial-mode device property support and related logic
- Simplify probe function by removing initial_mode variable and property reading
- Always initialize device to ADL8113_INTERNAL_AMPLIFIER mode
- Remove device registration success message and simplify return logic
- Fix of_device_id array formatting (spacing)
 drivers/iio/amplifiers/Kconfig   |  12 ++
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/adl8113.c | 213 +++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)
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
index 000000000000..8c234f0a1b6a
--- /dev/null
+++ b/drivers/iio/amplifiers/adl8113.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADL8113 Low Noise Amplifier with integrated bypass switches
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
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
+	ADL8113_EXTERNAL_BYPASS_B,
+};
+
+struct adl8113_state {
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
+
+	if (mode >= ARRAY_SIZE(adl8113_mode_names))
+		return -EINVAL;
+
+	return adl8113_set_mode(st, mode);
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
+		switch (st->current_mode) {
+		case ADL8113_INTERNAL_AMPLIFIER:
+			*val = 14;
+			*val2 = 0;
+			ret = IIO_VAL_INT_PLUS_MICRO_DB;
+			break;
+		case ADL8113_INTERNAL_BYPASS:
+			*val = 0;
+			*val2 = 0;
+			ret = IIO_VAL_INT_PLUS_MICRO_DB;
+			break;
+		case ADL8113_EXTERNAL_BYPASS_A:
+		case ADL8113_EXTERNAL_BYPASS_B:
+		default:
+			ret = -EINVAL;
+		}
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
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
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
+	ret = adl8113_set_mode(st, ADL8113_INTERNAL_AMPLIFIER);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &adl8113_info;
+	indio_dev->name = "adl8113";
+	indio_dev->channels = adl8113_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adl8113_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id adl8113_of_match[] = {
+	{ .compatible = "adi,adl8113" },
+	{ }
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


