Return-Path: <linux-iio+bounces-26796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC9BCA8028
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 15:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6A7318A093
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5324414;
	Fri,  5 Dec 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="L9PDiLwg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3D2EE612;
	Fri,  5 Dec 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764945979; cv=none; b=nGD30Dw0rs+Ez0U02IxPt1YDNGi+A6nTXudGkdHOP4ecFMrSLCSds5ikDbUEnywBVWYN70QSGzNvJjW32zPqDXCjTWMW/rwthcrTs7IL6s30//6nf0GMeLoRmkZw5fBMN//545HnePrYUZEZVkwykKMsRbhCpqg+a5PGYtGMmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764945979; c=relaxed/simple;
	bh=JKXb85u4cNpTeHEG9tETKKZfZA1kbFK9jYzy0rJKJmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCuqvG4hMXL3vwoF1MdfClBj3uaikFrj3HdQ3rMszVf+HJN6dpbtk027RANfWHEhXmu4xzob4oidhMtVqAeLYpwY/CqPhYZACMSOeuADx0qa+l3avg1BHiCP51jQ8SIoK5QKVvCeXQ9iqOdBLVlC/wj919IUSuWLyHbVCqAa+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=L9PDiLwg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5Bei1A626481;
	Fri, 5 Dec 2025 09:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ETAW3
	V6hj1FWVF02ap0R+GL9znK5gYM4f1ORPkNLE80=; b=L9PDiLwgs3ZgI4LWCgCdz
	ygWlvUhILr+bCLbNR5pnojtC/tWgNCnBjhWU4NbYl48QDQ/3uLykvfGCwSBDg9I9
	RhKtvKeNv8nxM47gzXsGklQpUbEYvb8qrJehopiobsvdQ2YPLNnZiIh2vGn6IVha
	j9Nv6VCFhHh9Fk4SmvFd35k3zt62QvxgD0ED0uxuckvm3eyUABDjCb7I48+6AGC6
	DZMKElCPgAlyYoKixNzFRVGeC6SvJfq9fOiUFUDOLdRlf8SzjtAV9oyUVtZUrIKP
	Z7JiyfH3Cq7wcD5mAz7kC818fpNARloXp/T6RIR/5snPufxiyI2AzAJOq4S/21aX
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4auhwwm1mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 09:45:59 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5Ejv4o029937
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 09:45:57 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 5 Dec
 2025 09:45:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 09:45:57 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5EjRaa028130;
	Fri, 5 Dec 2025 09:45:52 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/2] iio: amplifiers: adl8113: add driver support
Date: Fri, 5 Dec 2025 16:40:41 +0200
Message-ID: <20251205144058.1918-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205144058.1918-1-antoniu.miclaus@analog.com>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Y531cxeN c=1 sm=1 tr=0 ts=6932f027 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=hAzo1ZWYCqDvnDRTSZMA:9
X-Proofpoint-GUID: Z3S5qkdUHojIbWMJ2YNTAeT7nGqTbcG4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwNiBTYWx0ZWRfX7VwM2mOMsE6Z
 5IalJTQDERRbrJRHhguwjPRvqgWMcNgtma32VCa96135HuZO9XUGQbfAOyLceluVr9Stz+7HDCa
 UfZvBo8gr2zA3Wz0E98IzUhuUWoXctK3CyJQYY4AbwZhDJfQhbwwZW/8Qf43arxAIVbacAM2rvR
 4AG+JXlkRENix8Fue29xmtPpSD/2xUhMF39oMs8Y/7IPIpebqDh0I6da0lTCpuToK9m7QNDwP/+
 OzllG/t2Tq/l+lH/RdXwcoQ8n1LzNcVqzu9jl6oHeKb5R7cYh85SpoNcny5AHeyZF3xTP5FrlHg
 y6xbj5LJorX92HwKWwr772WxhpEV7ZS5Gi6zjjFfejXJINPfKvLKtNyiiXp2TbPakvmMz+a6Va+
 237NMoKd+qSULGOZK5got8VHHa49oA==
X-Proofpoint-ORIG-GUID: Z3S5qkdUHojIbWMJ2YNTAeT7nGqTbcG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050106

Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
10MHz to 14GHz bypass switches.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
 drivers/iio/amplifiers/Kconfig   |  12 ++
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/adl8113.c | 290 +++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
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
index 000000000000..eed5fe69280b
--- /dev/null
+++ b/drivers/iio/amplifiers/adl8113.c
@@ -0,0 +1,290 @@
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
+	struct gpio_descs *gpios;
+	struct adl8113_gain_config *gain_configs;
+	int num_gain_configs;
+	enum adl8113_signal_path current_path;
+};
+
+static const char * const adl8113_supply_names[] = {
+	"vdd1",
+	"vss2",
+	"vdd2"
+};
+
+static int adl8113_set_path(struct adl8113_state *st,
+			    enum adl8113_signal_path path)
+{
+	DECLARE_BITMAP(values, 2);
+	int ret;
+
+	bitmap_zero(values, 2);
+
+	/* Determine GPIO values based on signal path */
+	switch (path) {
+	case ADL8113_INTERNAL_AMP:
+		/* va=0, vb=0 - already zero */
+		break;
+	case ADL8113_INTERNAL_BYPASS:
+		/* va=1, vb=1 */
+		__set_bit(0, values);
+		__set_bit(1, values);
+		break;
+	case ADL8113_EXTERNAL_A:
+		/* va=0, vb=1 */
+		__set_bit(1, values);
+		break;
+	case ADL8113_EXTERNAL_B:
+		/* va=1, vb=0 */
+		__set_bit(0, values);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
+					     st->gpios->info, values);
+	if (ret)
+		return ret;
+
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
+			return config_idx;
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
+	int external_a_gain, external_b_gain, i = 0, j;
+
+	/*
+	 * Allocate for all 4 possible paths:
+	 * - Internal amp and bypass (always present)
+	 * - External bypass A and B (optional, or INT_MIN for testing)
+	 */
+	st->gain_configs = devm_kcalloc(dev, 4,
+					sizeof(*st->gain_configs), GFP_KERNEL);
+	if (!st->gain_configs)
+		return -ENOMEM;
+
+	/* Always include internal amplifier (14dB) */
+	st->gain_configs[i].path = ADL8113_INTERNAL_AMP;
+	st->gain_configs[i].gain_db = 14;
+	i++;
+
+	/* Always include internal bypass (-2dB insertion loss) */
+	st->gain_configs[i].path = ADL8113_INTERNAL_BYPASS;
+	st->gain_configs[i].gain_db = -2;
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
+	/*
+	 * If there's a free external bypass path, add one with INT_MIN gain
+	 * to represent "nothing connected" for testing purposes
+	 */
+	if (!device_property_present(dev, "adi,external-bypass-a-gain-db")) {
+		st->gain_configs[i].path = ADL8113_EXTERNAL_A;
+		st->gain_configs[i].gain_db = INT_MIN;
+		i++;
+	} else if (!device_property_present(dev, "adi,external-bypass-b-gain-db")) {
+		st->gain_configs[i].path = ADL8113_EXTERNAL_B;
+		st->gain_configs[i].gain_db = INT_MIN;
+		i++;
+	}
+
+	st->num_gain_configs = i;
+
+	/* Check for duplicate gain values */
+	for (i = 0; i < st->num_gain_configs - 1; i++) {
+		for (j = i + 1; j < st->num_gain_configs; j++) {
+			if (st->gain_configs[i].gain_db == st->gain_configs[j].gain_db)
+				return dev_err_probe(dev, -EINVAL,
+						     "Duplicate gain values not allowed: %d dB\n",
+						     st->gain_configs[i].gain_db);
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
+	st->gpios = devm_gpiod_get_array(dev, "ctrl", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpios))
+		return dev_err_probe(dev, PTR_ERR(st->gpios),
+				     "failed to get control GPIOs\n");
+
+	if (st->gpios->ndescs != 2)
+		return dev_err_probe(dev, -EINVAL,
+				     "expected 2 control GPIOs, got %d\n",
+				     st->gpios->ndescs);
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


