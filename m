Return-Path: <linux-iio+bounces-27055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21196CB9318
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 16:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F3AB30095DA
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3A320CAB;
	Fri, 12 Dec 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TBGx5NXX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14728F50F;
	Fri, 12 Dec 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554179; cv=none; b=PVALAw8z8SPcVWp56ZWMO7uUkBPXNkmoABSCEM5qA56lRCCO4Y0WiUfdoTmULRpavKXdEPzPfyyOYmYmkBQj23Vnh+Rwk9lNMuLVpxJrJDS59e4S9hrrbqJyvNadVs83ORb/QXdeEqJL6HIu2agBOKwraKXQBoFzZ38tCuQmdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554179; c=relaxed/simple;
	bh=jc+W3UqWU9UBPFcBx8tauk1jlgy5DbGJSjEYi76MhuA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1W4V6QV2tV3uL1aF02mvNLC4M2NQC2zV7KPaYGvbPR2NibkaoNtxXb4i6WtC6IGdaUBnSwXv21tCmrSGdYEe1Dbtqa+UHlwiw+gUlA/Dok466ivHppTx8Jom+8ZFddwwaerSk1O0GhogN8rA3EvrEyCl0pwFIbWdPxgsAWaIVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TBGx5NXX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BCBsFjx3366469;
	Fri, 12 Dec 2025 10:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fYpih
	qc4W2N9KRgWuRJ1Vsd8mbafzRTAER9w9OyXTys=; b=TBGx5NXXXKfNjVu6yPP9o
	Ud1k25kYmDldzozCOVBCfqqyK5denU/PgDLODMgLL5FuH/2PCvIOXvQpANciuEvZ
	jN+y/ztmC+CK4zoL3nCAGkH+cWSDzV3wE6zXNFVYyGYlGZmwX+VboPLlLU6V93EH
	N0lFgsGNgpIFM1Dkxz7Zm+re/7+1knAtFgiNXvYhW/lOvpgZaM9asHm9O4s2ug7t
	v3QzBukIfPfaWN3ctTwrAKY21kE63YcucyNRZ1d1kfMAF2mhjh+mzzBfcCfmKu6T
	sl4Qttl1Wcj7ZGT3aeYlLD4YmYf2IVOktK4RbZ9EceQuClZknKp4ogUyWV+Q247u
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4b05uhm8r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 10:42:43 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BCFgg8D049210
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Dec 2025 10:42:42 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 10:42:42 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 12 Dec 2025 10:42:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 12 Dec 2025 10:42:42 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BCFg2oU020112;
	Fri, 12 Dec 2025 10:42:34 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
Subject: [PATCH v7 2/2] iio: amplifiers: adl8113: add driver support
Date: Fri, 12 Dec 2025 17:38:26 +0200
Message-ID: <20251212153908.138422-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212153908.138422-1-antoniu.miclaus@analog.com>
References: <20251212153908.138422-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: cWL6Q_HHrSJDqB4_TyNEF3Suxi6OPV6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDEyNCBTYWx0ZWRfXwrgYKiDsUKQ0
 h/qgV52+8dz1+qnrcgAPp3QxgN62ZIIJ1qALzwpNOEEHieHg1qUTq1xsm63Vau4XLe99LhBS3xy
 tAMN8jg1VkukVWnY99g2YrWcodGU3NCkfR/Aj0mFq2znO1vRRmwkw/GFWsVmBDPemU0VPAH/IAg
 hDOM8X7fFSZ1jLGNM3YliNHuwsUK0AGnEH9yzXv59dH0wSPWCKrlFlreBxH47UMhogHelh0JXJD
 VL4V7p3qbaBYDkZqj3ck/NckeF4uVn+P//9UhZXH4uB7bKgs3hrC4sNQ9wiEHU/NeRJLyqHfRjS
 BClqcSugout6+1b6cn3jvWrFzFvmUari8B3X58h3juvdbC6gAmSqDhQfpbaGNIdx+SFYgFWDAAJ
 jQIjR/H5305YuMMlijohS748ALlYUg==
X-Proofpoint-ORIG-GUID: cWL6Q_HHrSJDqB4_TyNEF3Suxi6OPV6r
X-Authority-Analysis: v=2.4 cv=DeMaa/tW c=1 sm=1 tr=0 ts=693c37f3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=hAzo1ZWYCqDvnDRTSZMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512120124

Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
10MHz to 14GHz bypass switches.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v7:
 - Removed includes: limits.h, device.h, slab.h, sysfs.h
 - Added includes: bitmap.h, types.h, dev_printk.h, device/driver.h
 - Removed unused va and vb struct fields
 - Added trailing comma to supply names array
 - Changed num_gain_configs to unsigned int
 - Replaced bitmap operations with bitmap_write()
 - Enhanced comment showing bit mapping
 - Changed loop counters to unsigned int
 - Used compound literals for struct initialization
 - Fixed devm_kcalloc() line wrapping
 - Removed INT_MIN testing code
 - Removed duplicate gain validation
 - Fixed format specifier to %u for ndescs
 - Removed redundant blank line

 drivers/iio/amplifiers/Kconfig   |  12 ++
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/adl8113.c | 269 +++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+)
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
index 000000000000..b8a431b6616b
--- /dev/null
+++ b/drivers/iio/amplifiers/adl8113.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADL8113 Low Noise Amplifier with integrated bypass switches
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitmap.h>
+#include <linux/device/driver.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
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
+};
+
+struct adl8113_state {
+	struct gpio_descs *gpios;
+	struct adl8113_gain_config *gain_configs;
+	unsigned int num_gain_configs;
+	enum adl8113_signal_path current_path;
+};
+
+static const char * const adl8113_supply_names[] = {
+	"vdd1",
+	"vss2",
+	"vdd2",
+};
+
+static int adl8113_set_path(struct adl8113_state *st,
+			    enum adl8113_signal_path path)
+{
+	DECLARE_BITMAP(values, 2);
+	int ret;
+
+	/*
+	 * Determine GPIO values based on signal path.
+	 * Va: bit 0, Vb: bit 1.
+	 */
+	switch (path) {
+	case ADL8113_INTERNAL_AMP:
+		bitmap_write(values, 0x00, 0, 2);
+		break;
+	case ADL8113_INTERNAL_BYPASS:
+		bitmap_write(values, 0x03, 0, 2);
+		break;
+	case ADL8113_EXTERNAL_A:
+		bitmap_write(values, 0x02, 0, 2);
+		break;
+	case ADL8113_EXTERNAL_B:
+		bitmap_write(values, 0x01, 0, 2);
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
+	unsigned int i;
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
+	unsigned int i;
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
+	int external_a_gain, external_b_gain;
+	unsigned int i;
+
+	/*
+	 * Allocate for all 4 possible paths:
+	 * - Internal amp and bypass (always present)
+	 * - External bypass A and B (optional if configured)
+	 */
+	st->gain_configs = devm_kcalloc(dev, 4, sizeof(*st->gain_configs),
+					GFP_KERNEL);
+	if (!st->gain_configs)
+		return -ENOMEM;
+
+	/* Start filling the gain configurations with data */
+	i = 0;
+
+	/* Always include internal amplifier (14dB) */
+	st->gain_configs[i++] = (struct adl8113_gain_config) {
+		.path = ADL8113_INTERNAL_AMP,
+		.gain_db = 14,
+	};
+
+	/* Always include internal bypass (-2dB insertion loss) */
+	st->gain_configs[i++] = (struct adl8113_gain_config) {
+		.path = ADL8113_INTERNAL_BYPASS,
+		.gain_db = -2,
+	};
+
+	/* Add external bypass A if configured */
+	if (!device_property_read_u32(dev, "adi,external-bypass-a-gain-db",
+				      &external_a_gain)) {
+		st->gain_configs[i++] = (struct adl8113_gain_config) {
+			.path = ADL8113_EXTERNAL_A,
+			.gain_db = external_a_gain,
+		};
+	}
+
+	/* Add external bypass B if configured */
+	if (!device_property_read_u32(dev, "adi,external-bypass-b-gain-db",
+				      &external_b_gain)) {
+		st->gain_configs[i++] = (struct adl8113_gain_config) {
+			.path = ADL8113_EXTERNAL_B,
+			.gain_db = external_b_gain,
+		};
+	}
+
+	st->num_gain_configs = i;
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
+				     "expected 2 control GPIOs, got %u\n",
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
+module_platform_driver(adl8113_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADL8113 Low Noise Amplifier");
+MODULE_LICENSE("GPL");
-- 
2.43.0


