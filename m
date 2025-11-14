Return-Path: <linux-iio+bounces-26215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B2AC5CFD1
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 13:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E6014E88DF
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D90316909;
	Fri, 14 Nov 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m0IGUP9Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEDD309DB4;
	Fri, 14 Nov 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121548; cv=none; b=YXVCUoV1r8xA2xyoNCCmx8q/Oa8cWAWw0U9HGiFUTAuru3C3tjD4XKaE5Y8/zus4SjOLM3WxFzESRmvYUSTCOHn0yowAWfnlSW0/UHbodXlTzUilIxzrP9ETPmADj8JZhKqLb5Zofi+m6lCv3v0PwPVqW5/c18dgCcLd5UJCcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121548; c=relaxed/simple;
	bh=yY5+NFuoa4dQGrpHp8S8B6JuVsSyNV7MofF1eDK9AYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bt8w9wqLo20FVL5VXxtHHl374QxNkLdSdRyZM4XGWdyB9PxjSA3iZ7GWdbiIctzVGEuzYz7U3DLKEC79ARt9M48XDYACib7x1ql81XOPUchv2w8V9YYhZWoDG2+vT3fcoOoJbwN+onGLPapL0QrzbLLGbcrrJ4fb6GxwvoQlf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m0IGUP9Q; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEADISe182922;
	Fri, 14 Nov 2025 06:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0smta
	RxADYyUgby7El4Ufc6SVsESNV2PYpQVpgBXHI8=; b=m0IGUP9QoBojQwsIh5+oA
	i8DLKSYJSHrP4uJuyMKl2XEqlSKMou2qoGBQcjwR9jswEmFvyFvFlG4QpQlbuxKD
	PbYT/dE+NnghcUN+t5q5BYR+E3bZ+zoOHHU8e0Fr0gxO5ntnAKl3X7nf3FIJr0OY
	2bu/QWCKHyRMobEfCYnmMDCbjL6rWDhPuFZ8mBzI6tsomRI7mCGlsLR1Fa738z8y
	Eag6yNYRjCp4oZhmE7rb6f+mJqHkbb0LwUsDpDWju/Kcmr+2aFphf76ECjgej9b5
	wEIDRUz5AqLMZGXny16Qy446rJLIEoYAXhWk83QUf48fWtlmdlMQ3+OjEZ6Lqtnl
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ady1fhdjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:59:03 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AEBx2CF044608
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 06:59:02 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 06:59:02 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 06:59:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 06:59:02 -0500
Received: from Ubuntu.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AEBwodi018389;
	Fri, 14 Nov 2025 06:58:58 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 2/3] iio: amplifiers: adl8113: add driver support
Date: Fri, 14 Nov 2025 11:57:24 +0000
Message-ID: <20251114115725.5660-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114115725.5660-1-antoniu.miclaus@analog.com>
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=YcywJgRf c=1 sm=1 tr=0 ts=69171987 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=1dhURQ85q9Mw_Kxh2T0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: adLy2muIFh2VEvzhHKZocGT3gDdFvNEH
X-Proofpoint-GUID: adLy2muIFh2VEvzhHKZocGT3gDdFvNEH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5NSBTYWx0ZWRfX5HsBRyzowmfu
 BvW99MJf+sPsE5joCRRtwgzeNWwh/3UWbsQkvdakpJCp4jZb9XaRK/PPaoa4SgRJZ2OfW0gjshw
 6k36eJoLcoXBmL1cASCt2jjE5hWW9ChFtYAXzV8eYMEa5gcSR8AUxvIdEq2HkH8jFvBfqCBwETD
 S4E1SinRL7ijN/+QxQG0n5CF27+iBvcPyM5ol6FCcngO5+G/RqjN7cNNh8N0bDZZs1MKhlMUzga
 TH/L+XqE4xaMzZjI8i0dYXhVruUZrItGuJZ3prWKlS2lsFUsgevWEYSp1UOwrT9aO+SPcc3QEka
 lHCKXw3TBiDlBCbkE7NzF5cG+0a60HmE2qtTQhOHFhA9Zs6kgbJx8nArvvkD5JHVcd3wduWxtIG
 dlt0jwn4GLECuzJCrGPcoBj+FehEaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140095

Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
10MHz to 14GHz bypass switches.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---

Changes in v3:
- Major architecture refactor: separate gain mode and signal path controls
- Replace single "mode" enum with separate gain_mode and signal_path enums
- Add write_raw support for IIO_CHAN_INFO_HARDWAREGAIN to control amplifier (14dB) vs bypass (0dB)
- Replace mode attribute with signal_path attribute for controlling routing
- Automatically enforce constraints: external paths require bypass mode
- Remove linux/iio/sysfs.h include (no longer needed)
- Add comprehensive GPIO state validation in adl8113_update_gpio()
- Enhance error handling with proper -EINVAL returns for invalid combinations
---
 drivers/iio/amplifiers/Kconfig   |  12 ++
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/adl8113.c | 252 +++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
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
index 000000000000..155291f4ec89
--- /dev/null
+++ b/drivers/iio/amplifiers/adl8113.c
@@ -0,0 +1,252 @@
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
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+enum adl8113_gain_mode {
+	ADL8113_AMPLIFIER,
+	ADL8113_BYPASS,
+};
+
+enum adl8113_signal_path {
+	ADL8113_INTERNAL,
+	ADL8113_EXTERNAL_A,
+	ADL8113_EXTERNAL_B,
+};
+
+struct adl8113_state {
+	struct gpio_desc *gpio_va;
+	struct gpio_desc *gpio_vb;
+	enum adl8113_gain_mode gain_mode;
+	enum adl8113_signal_path signal_path;
+};
+
+static const char * const adl8113_supply_names[] = {
+	"vdd1",
+	"vdd2",
+	"vss2"
+};
+
+static const char * const adl8113_signal_path_names[] = {
+	[ADL8113_INTERNAL] = "internal",
+	[ADL8113_EXTERNAL_A] = "external_a",
+	[ADL8113_EXTERNAL_B] = "external_b",
+};
+
+static int adl8113_update_gpio(struct adl8113_state *st)
+{
+	int va, vb;
+
+	/* Determine GPIO values based on gain mode and signal path */
+	switch (st->gain_mode) {
+	case ADL8113_AMPLIFIER:
+		if (st->signal_path != ADL8113_INTERNAL)
+			return -EINVAL;
+		va = 0; vb = 0; /* Internal amplifier */
+		break;
+	case ADL8113_BYPASS:
+		switch (st->signal_path) {
+		case ADL8113_INTERNAL:
+			va = 1; vb = 1; /* Internal bypass */
+			break;
+		case ADL8113_EXTERNAL_A:
+			va = 0; vb = 1; /* External bypass A */
+			break;
+		case ADL8113_EXTERNAL_B:
+			va = 1; vb = 0; /* External bypass B */
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	gpiod_set_value(st->gpio_va, va);
+	gpiod_set_value(st->gpio_vb, vb);
+	return 0;
+}
+
+static int adl8113_get_signal_path(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan)
+{
+	struct adl8113_state *st = iio_priv(indio_dev);
+
+	return st->signal_path;
+}
+
+static int adl8113_set_signal_path(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   unsigned int path)
+{
+	struct adl8113_state *st = iio_priv(indio_dev);
+
+	if (path >= ARRAY_SIZE(adl8113_signal_path_names))
+		return -EINVAL;
+
+	/* External paths require bypass mode, so switch to it automatically */
+	if (path != ADL8113_INTERNAL)
+		st->gain_mode = ADL8113_BYPASS;
+
+	st->signal_path = path;
+	return adl8113_update_gpio(st);
+}
+
+static const struct iio_enum adl8113_signal_path_enum = {
+	.items = adl8113_signal_path_names,
+	.num_items = ARRAY_SIZE(adl8113_signal_path_names),
+	.get = adl8113_get_signal_path,
+	.set = adl8113_set_signal_path,
+};
+
+static const struct iio_chan_spec_ext_info adl8113_ext_info[] = {
+	IIO_ENUM("signal_path", IIO_SHARED_BY_ALL, &adl8113_signal_path_enum),
+	IIO_ENUM_AVAILABLE("signal_path", IIO_SHARED_BY_ALL,
+			   &adl8113_signal_path_enum),
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
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		if (st->gain_mode == ADL8113_AMPLIFIER) {
+			/* Amplifier mode: 14dB gain */
+			*val = 14;
+			*val2 = 0;
+			return IIO_VAL_INT_PLUS_MICRO_DB;
+		}
+
+		/* Bypass mode: 0dB gain */
+		*val = 0;
+		*val2 = 0;
+		return IIO_VAL_INT_PLUS_MICRO_DB;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adl8113_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct adl8113_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		/* Accept dB values: 0dB (bypass) or 14dB (amplifier) */
+		if (val == 0 && val2 == 0) {
+			st->gain_mode = ADL8113_BYPASS;
+		} else if (val == 14 && val2 == 0) {
+			st->gain_mode = ADL8113_AMPLIFIER;
+			/* Force internal path for amplifier mode */
+			st->signal_path = ADL8113_INTERNAL;
+		} else {
+			return -EINVAL;
+		}
+		return adl8113_update_gpio(st);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adl8113_info = {
+	.read_raw = adl8113_read_raw,
+	.write_raw = adl8113_write_raw,
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
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(adl8113_supply_names),
+					     adl8113_supply_names);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get and enable supplies\n");
+
+	/* Initialize to amplifier mode with internal path */
+	st->gain_mode = ADL8113_AMPLIFIER;
+	st->signal_path = ADL8113_INTERNAL;
+	ret = adl8113_update_gpio(st);
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


