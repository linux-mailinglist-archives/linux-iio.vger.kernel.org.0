Return-Path: <linux-iio+bounces-18652-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8366FA9C9A8
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 14:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58B91C00727
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5785A255259;
	Fri, 25 Apr 2025 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MoDcY6y2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC4253959;
	Fri, 25 Apr 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585750; cv=none; b=J/I6a4wJMWuaCidUvFdolHzPGmux5iL9ucptZnLSn8uLCPYF3N+dMdZtIAxx//Fjg4wkDiMzKHYY3y738vNdzhB61xwNsVrIoKde5mhQzhbBk67K1A1CZ1G1y5U5zXEgrwNMFHyjFn2FySQoQ+Fszn/tz84bAdvou8y0jkj/OAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585750; c=relaxed/simple;
	bh=WHtPGdboK783WNI0ed/437ZXYSnVgW1zTOYWy7E4iiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KMVjNPBFpqAfxCXD2ziLDfgOhjpq/lcRj2pOjJfx/uQGhZ+lf5ZR4DcPIhClSuRiyTXyzUHKVk3Opx0oCSlTFTLwyBj3XiKGoNaOA+KcZzjDUjd7sTnL1n1h8IVp7p4TwfEsS7gdscNvJK0NjJ6v3Kf8tiNY09FhdcbMOtzkVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MoDcY6y2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCaNjp016633;
	Fri, 25 Apr 2025 08:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QV0px
	dB5KLEmQyLdJbC5TxpaYN1aL6w5F+79o0IZHkw=; b=MoDcY6y239AneuZGDWo73
	VuF/CqIicSm9yxvn3Zc1A3urk2MX79zf4rY30poYaQj925ZpCnlItBoZSyLXd8zJ
	x8DMl3pm/zmcrasBefIDi7TCDcoSIAxOvzuK0qiPNdea0/OYRxiBPNc6QMRzb2tb
	7kXA8UmfilNEvYGbIg6zvj+c93Y4MWX5zDfpFSHEHgqQsRFoF9kxto3/ST0M/CIg
	L5Uo1aLbio8f+Be8yzdVJugpzIjyCcBHrQ2I+1gvMMromSkJIq4O8X1NEiuOfGYD
	HdbFoJfq6yToH+yWCJck2vkl9kLKNXSLgaCtwZkxApZkWtDNKHPGZtRjN7v/h5mp
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46833ja4xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 08:55:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PCtVb7054036
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 08:55:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 08:55:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 08:55:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 08:55:31 -0400
Received: from LRADU-D01.ad.analog.com ([10.117.223.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PCsub1019034;
	Fri, 25 Apr 2025 08:55:21 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 25 Apr 2025 20:54:48 +0800
Subject: [PATCH v6 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250425-togreg-v6-3-47b6f9878ae5@analog.com>
References: <20250425-togreg-v6-0-47b6f9878ae5@analog.com>
In-Reply-To: <20250425-togreg-v6-0-47b6f9878ae5@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745585696; l=17362;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=WHtPGdboK783WNI0ed/437ZXYSnVgW1zTOYWy7E4iiA=;
 b=I26NU5CfZlS/nsvhwa3GroYxsocaEQQGbf/KhDkXOqYzuEzVzqR9wOizxEZHM575CseWR5kQZ
 7mv5uWkFTUNCz85GH++/giWbdr0dtmbluFF6ntZt7gH6a68x3ZIhTZ9
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: eGacySZMBgX2G9gllN7gNXH13aVeZzAE
X-Proofpoint-GUID: eGacySZMBgX2G9gllN7gNXH13aVeZzAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA5MyBTYWx0ZWRfX4Se3BGIFlpJd rtiXQqSfpQiLjGHm4Oi7UdAuRCufkODx2HcEGTmxPXSHNRbfhVQkla8B0JLjTrD8U1d1GGl1ddw D8QZfHEEzRyzR1jXfdfnNeb51ng+T/7GcuO07MOqhZpNi1SjIKTTz+DLIgCpmshRa20xvNZX2Yy
 m0dL5sxg/ZEY1TcKI2josKt6ubUdJDQc+GULyLs9hImQWYC5F25n1iHN8cfRLtUktXCGJoxJqAX yeBloRiB3SWl7R0M0yOL7gQTJTAFM+9HF2nnCU+Mc30uzhy2jG2fJHgpiklvfxREhA+JOVwvrYA k+SHs6oDf4FBAy2FIMnMrQTgZKLyg0WUVt0U3vCr/2EIO/wD3/lFC0ZWLs0i1ghm4/h6cxPY48p
 NQXGLxhIj+h2WeVkaJPUSoi1wtXXRqKv0FUpYUKI/x3nywKTDWS56k1hF78VDkC2Y6D/oiZr
X-Authority-Analysis: v=2.4 cv=Hu52G1TS c=1 sm=1 tr=0 ts=680b8645 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=gSiz_irBYLZb22r3yjwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250093

The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
low-power, 16-bit, buffered voltage output DACs with software-
programmable gain controls, providing full-scale output spans of 2.5V or
5V for reference voltages of 2.5V. These devices operate from a single
2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
variants include a 2.5V, 5ppm/°C internal reference, which is disabled
by default.

Support for monitoring internal die temperature, output voltages, and
current of a selected channel via the MUXOUT pin using an external ADC
is currently not implemented.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  11 +
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad3530r.c | 515 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 528 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ca59fc1bf25aa49fecf78a90b2e1b73f25a2c05..25356d5a1a09e5ff6e7ed8eaa98a8ea990e79d8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1306,6 +1306,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
+F:	drivers/iio/dac/ad3530r.c
 
 ANALOG DEVICES INC AD3552R DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 4811ea973125a0dea1f8a9cdee1e0c045bc21981..e0996dc014a3d538ab6b4e0d50ff54ede50f1527 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -6,6 +6,17 @@
 
 menu "Digital to analog converters"
 
+config AD3530R
+	tristate "Analog Devices AD3530R and Similar DACs driver"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD3530R, AD3531R
+	  Digital to Analog Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad3530r.
+
 config AD3552R_HS
 	tristate "Analog Devices AD3552R DAC High Speed driver"
 	select AD3552R_LIB
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 8dd6cce81ed1152be4cf0af9ef877b5482ceb347..3684cd52b7fa9bc0ad9f855323dcbb2e4965c404 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -4,6 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_AD3530R) += ad3530r.o
 obj-$(CONFIG_AD3552R_HS) += ad3552r-hs.o
 obj-$(CONFIG_AD3552R_LIB) += ad3552r-common.o
 obj-$(CONFIG_AD3552R) += ad3552r.o
diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
new file mode 100644
index 0000000000000000000000000000000000000000..2b3057e02e260a13add3237d8b93377fbd9aa81f
--- /dev/null
+++ b/drivers/iio/dac/ad3530r.c
@@ -0,0 +1,515 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
+ * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#define AD3530R_INTERFACE_CONFIG_A		0x00
+#define AD3530R_OUTPUT_OPERATING_MODE_0		0x20
+#define AD3530R_OUTPUT_OPERATING_MODE_1		0x21
+#define AD3530R_OUTPUT_CONTROL_0		0x2A
+#define AD3530R_REFERENCE_CONTROL_0		0x3C
+#define AD3530R_SW_LDAC_TRIG_A			0xE5
+#define AD3530R_INPUT_CH			0xEB
+#define AD3530R_MAX_REG_ADDR			0xF9
+
+#define AD3531R_SW_LDAC_TRIG_A			0xDD
+#define AD3531R_INPUT_CH			0xE3
+
+#define AD3530R_SLD_TRIG_A			BIT(7)
+#define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
+#define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
+#define AD3530R_REG_VAL_MASK			GENMASK(15, 0)
+#define AD3530R_OP_MODE_CHAN_MSK(chan)		(GENMASK(1, 0) << 2 * chan)
+
+#define AD3530R_SW_RESET			(BIT(7) | BIT(0))
+#define AD3530R_INTERNAL_VREF_mV		2500
+#define AD3530R_LDAC_PULSE_US			100
+
+#define AD3530R_DAC_MAX_VAL			GENMASK(15, 0)
+#define AD3530R_MAX_CHANNELS			8
+#define AD3531R_MAX_CHANNELS			4
+
+enum ad3530r_mode {
+	AD3530R_NORMAL_OP,
+	AD3530R_POWERDOWN_1K,
+	AD3530R_POWERDOWN_7K7,
+	AD3530R_POWERDOWN_32K,
+};
+
+struct ad3530r_chan {
+	enum ad3530r_mode powerdown_mode;
+	bool powerdown;
+};
+
+struct ad3530r_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	int (*input_ch_reg)(unsigned int channel);
+	unsigned int num_channels;
+	unsigned int sw_ldac_trig_reg;
+	bool internal_ref_support;
+};
+
+struct ad3530r_state {
+	struct regmap *regmap;
+	/* lock to protect against multiple access to the device and shared data */
+	struct mutex lock;
+	struct ad3530r_chan chan[AD3530R_MAX_CHANNELS];
+	const struct ad3530r_chip_info *chip_info;
+	struct gpio_desc *ldac_gpio;
+	int vref_mV;
+	/*
+	 * DMA (thus cache coherency maintenance) may require the transfer
+	 * buffers to live in their own cache lines.
+	 */
+	__be16 buf __aligned(IIO_DMA_MINALIGN);
+};
+
+static int ad3530r_input_ch_reg(unsigned int channel)
+{
+	return 2 * channel + AD3530R_INPUT_CH;
+}
+
+static int ad3531r_input_ch_reg(unsigned int channel)
+{
+	return 2 * channel + AD3531R_INPUT_CH;
+}
+
+static const char * const ad3530r_powerdown_modes[] = {
+	"1kohm_to_gnd",
+	"7.7kohm_to_gnd",
+	"32kohm_to_gnd",
+};
+
+static int ad3530r_get_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+	return st->chan[chan->channel].powerdown_mode - 1;
+}
+
+static int ad3530r_set_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      unsigned int mode)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+	st->chan[chan->channel].powerdown_mode = mode + 1;
+
+	return 0;
+}
+
+static const struct iio_enum ad3530r_powerdown_mode_enum = {
+	.items = ad3530r_powerdown_modes,
+	.num_items = ARRAY_SIZE(ad3530r_powerdown_modes),
+	.get = ad3530r_get_powerdown_mode,
+	.set = ad3530r_set_powerdown_mode,
+};
+
+static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 char *buf)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+	return sysfs_emit(buf, "%d\n", st->chan[chan->channel].powerdown);
+}
+
+static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 const char *buf, size_t len)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned int mask, val, reg, pdmode;
+	bool powerdown;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	mask = AD3530R_OP_MODE_CHAN_MSK(chan->channel);
+	reg = chan->channel < AD3531R_MAX_CHANNELS ?
+	      AD3530R_OUTPUT_OPERATING_MODE_0 :
+	      AD3530R_OUTPUT_OPERATING_MODE_1;
+	pdmode = powerdown ? st->chan[chan->channel].powerdown_mode : 0;
+	val = pdmode << 2 * chan->channel;
+
+	ret = regmap_update_bits(st->regmap, reg, mask, val);
+	if (ret)
+		return ret;
+
+	st->chan[chan->channel].powerdown = powerdown;
+
+	return len;
+}
+
+static int ad3530r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
+{
+	gpiod_set_value_cansleep(ldac_gpio, 1);
+	fsleep(AD3530R_LDAC_PULSE_US);
+	gpiod_set_value_cansleep(ldac_gpio, 0);
+
+	return 0;
+}
+
+static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
+			     unsigned int val)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+	st->buf = cpu_to_be16(val);
+
+	ret = regmap_bulk_write(st->regmap, st->chip_info->input_ch_reg(chan),
+				&st->buf, sizeof(st->buf));
+	if (ret)
+		return ret;
+
+	if (st->ldac_gpio)
+		return ad3530r_trigger_hw_ldac(st->ldac_gpio);
+
+	return regmap_set_bits(st->regmap, st->chip_info->sw_ldac_trig_reg,
+			       AD3530R_SLD_TRIG_A);
+}
+
+static int ad3530r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_bulk_read(st->regmap,
+				       st->chip_info->input_ch_reg(chan->channel),
+				       &st->buf, sizeof(st->buf));
+		if (ret)
+			return ret;
+
+		*val = FIELD_GET(AD3530R_REG_VAL_MASK, be16_to_cpu(st->buf));
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mV;
+		*val2 = 16;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad3530r_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val > AD3530R_DAC_MAX_VAL)
+			return -EINVAL;
+
+		return ad3530r_dac_write(st, chan->channel, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad3530r_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.shared = IIO_SEPARATE,
+		.read = ad3530r_get_dac_powerdown,
+		.write = ad3530r_set_dac_powerdown,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3530r_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
+			   &ad3530r_powerdown_mode_enum),
+	{ }
+};
+
+#define AD3530R_CHAN(_chan)					\
+{								\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = _chan,					\
+	.output = 1,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.ext_info = ad3530r_ext_info,				\
+}
+
+static const struct iio_chan_spec ad3530r_channels[] = {
+	AD3530R_CHAN(0),
+	AD3530R_CHAN(1),
+	AD3530R_CHAN(2),
+	AD3530R_CHAN(3),
+	AD3530R_CHAN(4),
+	AD3530R_CHAN(5),
+	AD3530R_CHAN(6),
+	AD3530R_CHAN(7),
+};
+
+static const struct iio_chan_spec ad3531r_channels[] = {
+	AD3530R_CHAN(0),
+	AD3530R_CHAN(1),
+	AD3530R_CHAN(2),
+	AD3530R_CHAN(3),
+};
+
+static const struct ad3530r_chip_info ad3530_chip = {
+	.name = "ad3530",
+	.channels = ad3530r_channels,
+	.num_channels = ARRAY_SIZE(ad3530r_channels),
+	.sw_ldac_trig_reg = AD3530R_SW_LDAC_TRIG_A,
+	.input_ch_reg = ad3530r_input_ch_reg,
+	.internal_ref_support = false,
+};
+
+static const struct ad3530r_chip_info ad3530r_chip = {
+	.name = "ad3530r",
+	.channels = ad3530r_channels,
+	.num_channels = ARRAY_SIZE(ad3530r_channels),
+	.sw_ldac_trig_reg = AD3530R_SW_LDAC_TRIG_A,
+	.input_ch_reg = ad3530r_input_ch_reg,
+	.internal_ref_support = true,
+};
+
+static const struct ad3530r_chip_info ad3531_chip = {
+	.name = "ad3531",
+	.channels = ad3531r_channels,
+	.num_channels = ARRAY_SIZE(ad3531r_channels),
+	.sw_ldac_trig_reg = AD3531R_SW_LDAC_TRIG_A,
+	.input_ch_reg = ad3531r_input_ch_reg,
+	.internal_ref_support = false,
+};
+
+static const struct ad3530r_chip_info ad3531r_chip = {
+	.name = "ad3531r",
+	.channels = ad3531r_channels,
+	.num_channels = ARRAY_SIZE(ad3531r_channels),
+	.sw_ldac_trig_reg = AD3531R_SW_LDAC_TRIG_A,
+	.input_ch_reg = ad3531r_input_ch_reg,
+	.internal_ref_support = true,
+};
+
+static int ad3530r_setup(struct ad3530r_state *st, int vref)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct gpio_desc *reset_gpio;
+	int i, ret;
+	u8 range_multiplier, val;
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	if (reset_gpio) {
+		/* Perform hardware reset */
+		fsleep(1 * USEC_PER_MSEC);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+	} else {
+		/* Perform software reset */
+		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
+					 AD3530R_SW_RESET, AD3530R_SW_RESET);
+		if (ret)
+			return ret;
+	}
+
+	fsleep(10 * USEC_PER_MSEC);
+
+	range_multiplier = 1;
+	if (device_property_read_bool(dev, "adi,range-double")) {
+		ret = regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
+				      AD3530R_OUTPUT_CONTROL_RANGE);
+		if (ret)
+			return ret;
+
+		range_multiplier = 2;
+	}
+
+	if (st->chip_info->internal_ref_support && vref == 0) {
+		ret = regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
+				      AD3530R_REFERENCE_CONTROL_SEL);
+		if (ret)
+			return ret;
+
+		st->vref_mV = range_multiplier * AD3530R_INTERNAL_VREF_mV;
+	}
+
+	if (vref > 0)
+		st->vref_mV = range_multiplier * vref / MILLI;
+
+	/* Set normal operating mode for all channels */
+	val = FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(0), AD3530R_NORMAL_OP) |
+	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(1), AD3530R_NORMAL_OP) |
+	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(2), AD3530R_NORMAL_OP) |
+	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(3), AD3530R_NORMAL_OP);
+
+	ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0, val);
+	if (ret)
+		return ret;
+
+	if (st->chip_info->num_channels > 4) {
+		ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1,
+				   val);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < st->chip_info->num_channels; i++)
+		st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
+
+	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
+	if (IS_ERR(st->ldac_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
+				     "Failed to get ldac GPIO\n");
+
+	return 0;
+}
+
+static const struct regmap_config ad3530r_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = AD3530R_MAX_REG_ADDR,
+};
+
+static const struct iio_info ad3530r_info = {
+	.read_raw = ad3530r_read_raw,
+	.write_raw = ad3530r_write_raw,
+	.debugfs_reg_access = ad3530r_reg_access,
+};
+
+static int ad3530r_probe(struct spi_device *spi)
+{
+	static const char * const regulators[] = { "vdd", "iovdd" };
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad3530r_state *st;
+	int ret, vref;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->regmap = devm_regmap_init_spi(spi, &ad3530r_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to init regmap");
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODEV;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
+
+	vref = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (vref < 0 && vref != -ENODEV)
+		return vref;
+
+	if (vref == -ENODEV)
+		vref = 0;
+
+	if (!st->chip_info->internal_ref_support && vref == 0)
+		return -ENODEV;
+
+	ret = ad3530r_setup(st, vref);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad3530r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad3530r_id[] = {
+	{ "ad3530", (kernel_ulong_t)&ad3530_chip },
+	{ "ad3530r", (kernel_ulong_t)&ad3530r_chip },
+	{ "ad3531", (kernel_ulong_t)&ad3531_chip },
+	{ "ad3531r", (kernel_ulong_t)&ad3531r_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad3530r_id);
+
+static const struct of_device_id ad3530r_of_match[] = {
+	{ .compatible = "adi,ad3530", .data = &ad3530_chip },
+	{ .compatible = "adi,ad3530r", .data = &ad3530r_chip },
+	{ .compatible = "adi,ad3531", .data = &ad3531_chip },
+	{ .compatible = "adi,ad3531r", .data = &ad3531r_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad3530r_of_match);
+
+static struct spi_driver ad3530r_driver = {
+	.driver = {
+		.name = "ad3530r",
+		.of_match_table = ad3530r_of_match,
+	},
+	.probe = ad3530r_probe,
+	.id_table = ad3530r_id,
+};
+module_spi_driver(ad3530r_driver);
+
+MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD3530R and Similar DACs Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


