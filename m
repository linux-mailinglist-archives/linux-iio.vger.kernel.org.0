Return-Path: <linux-iio+bounces-26360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C6C783EA
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CF933515F9
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540EB34253D;
	Fri, 21 Nov 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fcrkXKaA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF834252C;
	Fri, 21 Nov 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718747; cv=none; b=jnmm0QHQdhBPiqJb0HEd/kx0dPOxsiCQXGO8P+KXn8O5j8JzitRpHwfzOBa+WAL5+MvNAozPSIdjj9hz6uyZgh/Ur1c6yUoRL4x1qdg2sUaJZga2NpvAbnI4XM8cGOwZA1q3mW0d2w+kZELUBUr7wPiSHOV9vX2zO2hLvXXjizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718747; c=relaxed/simple;
	bh=x0sQHyOqkAbfR6yDtyVXBo3nRfA4iuIfKZVaa/mdaZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5JTUNF0kieJOgHi3X96w+EGDsn2EOKDViHUlZrz81bDoudTBVPjtP+zqsFDNyPurHB1EqEu8ZQF1mFwHnfPhJihVFg5T+f+W1MW3yVsvJywjK+bgYMbIdlzv6BkLiHn3lFMa6/5K763UqPb6gaddHzDuE4+wj0fKdmfP46RSSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fcrkXKaA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL6KbB12557258;
	Fri, 21 Nov 2025 04:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3fQkj
	fTsBeAwys5lYtDstiLxVERISxme+IzAlW2KZp4=; b=fcrkXKaAlxGfmk9KKYoZT
	6wDNIw3s57GSC9WKipLRwVTYl+xlL097YnXNrgQ+KP0+LUCBW0gLOiNyAyRxVBjT
	/+ECU+SgnY5qBjpIwDNNtob2IvcmUUfwa5s/pNTEaXSMgDmvLAuru8osXwvV4tA3
	ZHjBTFSgCeJbY3lrkd2KLWPU3lYXuLG0DnDgeROmMlWMxQzGMCs72RhXmIfjIjN2
	BQqASGjbMdglnX5yBiMGW+rheh4ZPF/i2dxM0bCtyLg2dE2GWJ4ONOj6Fyzsssxt
	nmAWFpyZh8cFfIQyw7DZjMmtkiiEe0paZNVosvS8WhHOQShjjPXkowV/YRaHRIMv
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ajjqjrvm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 04:52:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AL9qLJk014851
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Nov 2025 04:52:21 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 21 Nov
 2025 04:52:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Nov 2025 04:52:21 -0500
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AL9q9RE026882;
	Fri, 21 Nov 2025 04:52:16 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 2/2] iio: amplifiers: adl8113: add driver support
Date: Fri, 21 Nov 2025 09:52:03 +0000
Message-ID: <20251121095204.18574-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121095204.18574-1-antoniu.miclaus@analog.com>
References: <20251121095204.18574-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: _CI66C0pVFefan4Y4N1GZp-NsfxbfYpL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NCBTYWx0ZWRfXzR+FKf8fpvj9
 HHyB/GJ2TvZOKx5QuvPgVRG8vcAJyGxnPY+11R19OV4aZanyMH5Gvxv6T7uqXgAiXPCpsmhCNsi
 fHlIspPlnrmp/a6bfQqJztPTJE0Nywshvv98EjheXgceXG2KWkuyUa38zOlpXbSQOhJfIQI3Isd
 RLvGpJTbTWy1KdPaql6bbbaeP/je2Tpv/5HmA20bR+I0UDMQLmM4qKY1JZSVdcG62wKoNnZKzlJ
 rLKfEFDmFLUU1ioKV2ekOYgyAppRYcZLsshI6xzndpWF8RRqs6OMnfr0UCH0Uv36JMPMFWBMFpm
 KAyW6VWw4RgJpU9oyI+sugExetN41J22wc1tDKTmD3ziV08g7dim8dNK1LGa+N4X/g/LHTgADM3
 +6iN9ccIQrTyAeGiGz3wv90Aj5gTug==
X-Proofpoint-ORIG-GUID: _CI66C0pVFefan4Y4N1GZp-NsfxbfYpL
X-Authority-Analysis: v=2.4 cv=ffygCkQF c=1 sm=1 tr=0 ts=69203656 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=dNNqtZCZDWkXVLnPP10A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210074

Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
10MHz to 14GHz bypass switches.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---

Changes in v4:
- Replace signal_path sysfs attribute with hardwaregain-only control
- Add support for external bypass amplifiers via DT properties
- Introduce dynamic gain configuration system with adl8113_gain_config structure
---
 drivers/iio/amplifiers/Kconfig   |  12 ++
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/adl8113.c | 277 +++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+)
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
index 000000000000..118789aa2c19
--- /dev/null
+++ b/drivers/iio/amplifiers/adl8113.c
@@ -0,0 +1,277 @@
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
+enum adl8113_signal_path {
+	ADL8113_INTERNAL_AMP,
+	ADL8113_INTERNAL_BYPASS,
+	ADL8113_EXTERNAL_A,
+	ADL8113_EXTERNAL_B,
+};
+
+struct adl8113_gain_config {
+	enum adl8113_signal_path path;
+	int gain_db;
+	int va;
+	int vb;
+};
+
+struct adl8113_state {
+	struct gpio_desc *gpio_va;
+	struct gpio_desc *gpio_vb;
+	struct adl8113_gain_config *gain_configs;
+	int num_gain_configs;
+	enum adl8113_signal_path current_path;
+};
+
+static const char * const adl8113_supply_names[] = {
+	"vdd1",
+	"vdd2",
+	"vss2"
+};
+
+static int adl8113_set_path(struct adl8113_state *st,
+			    enum adl8113_signal_path path)
+{
+	int va, vb;
+
+	/* Determine GPIO values based on signal path */
+	switch (path) {
+	case ADL8113_INTERNAL_AMP:
+		va = 0; vb = 0; /* Internal amplifier */
+		break;
+	case ADL8113_INTERNAL_BYPASS:
+		va = 1; vb = 1; /* Internal bypass */
+		break;
+	case ADL8113_EXTERNAL_A:
+		va = 0; vb = 1; /* External bypass A */
+		break;
+	case ADL8113_EXTERNAL_B:
+		va = 1; vb = 0; /* External bypass B */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	gpiod_set_value(st->gpio_va, va);
+	gpiod_set_value(st->gpio_vb, vb);
+	st->current_path = path;
+	return 0;
+}
+
+static int adl8113_find_gain_config(struct adl8113_state *st, int gain_db)
+{
+	int i;
+
+	for (i = 0; i < st->num_gain_configs; i++) {
+		if (st->gain_configs[i].gain_db == gain_db)
+			return i;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_chan_spec adl8113_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.indexed = 1,
+		.channel = 0,
+	},
+};
+
+static int adl8113_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct adl8113_state *st = iio_priv(indio_dev);
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		/* Find current gain configuration */
+		for (i = 0; i < st->num_gain_configs; i++) {
+			if (st->gain_configs[i].path == st->current_path) {
+				*val = st->gain_configs[i].gain_db;
+				*val2 = 0;
+				return IIO_VAL_INT_PLUS_MICRO_DB;
+			}
+		}
+		return -EINVAL;
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
+	int config_idx;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		if (val2 != 0)
+			return -EINVAL;
+
+		config_idx = adl8113_find_gain_config(st, val);
+		if (config_idx < 0)
+			return -EINVAL;
+
+		return adl8113_set_path(st, st->gain_configs[config_idx].path);
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
+static int adl8113_init_gain_configs(struct device *dev, struct adl8113_state *st)
+{
+	int external_a_gain, external_b_gain;
+	int num_configs = 2; /* Always have internal amp and internal bypass */
+	int i = 0;
+
+	/* Check for optional external bypass amplifier gains */
+	if (!device_property_read_u32(dev, "adi,external-bypass-a-gain-db",
+				      &external_a_gain))
+		num_configs++;
+
+	if (!device_property_read_u32(dev, "adi,external-bypass-b-gain-db",
+				      &external_b_gain))
+		num_configs++;
+
+	st->gain_configs = devm_kcalloc(dev, num_configs,
+					sizeof(*st->gain_configs), GFP_KERNEL);
+	if (!st->gain_configs)
+		return -ENOMEM;
+
+	/* Always include internal amplifier (14dB) */
+	st->gain_configs[i].path = ADL8113_INTERNAL_AMP;
+	st->gain_configs[i].gain_db = 14;
+	i++;
+
+	/* Always include internal bypass (0dB) */
+	st->gain_configs[i].path = ADL8113_INTERNAL_BYPASS;
+	st->gain_configs[i].gain_db = 0;
+	i++;
+
+	/* Add external bypass A if configured */
+	if (!device_property_read_u32(dev, "adi,external-bypass-a-gain-db",
+				      &external_a_gain)) {
+		st->gain_configs[i].path = ADL8113_EXTERNAL_A;
+		st->gain_configs[i].gain_db = external_a_gain;
+		i++;
+	}
+
+	/* Add external bypass B if configured */
+	if (!device_property_read_u32(dev, "adi,external-bypass-b-gain-db",
+				      &external_b_gain)) {
+		st->gain_configs[i].path = ADL8113_EXTERNAL_B;
+		st->gain_configs[i].gain_db = external_b_gain;
+		i++;
+	}
+
+	st->num_gain_configs = num_configs;
+
+	/* Check for duplicate gain values */
+	for (i = 0; i < num_configs - 1; i++) {
+		for (int j = i + 1; j < num_configs; j++) {
+			if (st->gain_configs[i].gain_db == st->gain_configs[j].gain_db) {
+				dev_err(dev, "Duplicate gain values not allowed: %d dB\n",
+					st->gain_configs[i].gain_db);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
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
+	/* Initialize gain configurations from devicetree */
+	ret = adl8113_init_gain_configs(dev, st);
+	if (ret)
+		return ret;
+
+	/* Initialize to internal amplifier path (14dB) */
+	ret = adl8113_set_path(st, ADL8113_INTERNAL_AMP);
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


