Return-Path: <linux-iio+bounces-18397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A511A94BEE
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 06:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4BA3B016A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 04:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F81258CE3;
	Mon, 21 Apr 2025 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="li1lAH8B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE492586E6;
	Mon, 21 Apr 2025 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745209558; cv=none; b=FXE6Z2OF7IxG93qEVcJDSsNRK7qupP4xW/g4Ne8kGk9anU9IdYakjVdS5xX11so/aa2etxaE7jS6Z3IeL3611/E4GB9fSRqwt4uIy/yZk17vJHULv1og0is1Mi++z+quFXm+K6aWrDgeXGxSmVePWMY8I+nu0HIAhSUys18V16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745209558; c=relaxed/simple;
	bh=HnRY5Dux9JSF0fXtq+61SeUb80no9Q0BmwJ5uCmKA3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hCzXEfCKNDRQnWOTGkhYVGc+fGg4Z3kWtjd+gxPFW9L49sXLzVBSoD/RSc1mXR+FQSJlZx46JaPKVwlTOyOtNgIV1kn9wK7N2SsT9q+F9PPOH6CJ0XI2WU1V5Z6g6GxRgbpQVrIZSqqksPaabUSfzfwlPs4OJU3pxMIju/41NxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=li1lAH8B; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L39opo029954;
	Mon, 21 Apr 2025 00:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aYk/T
	Tw2ZW0De6O4oL54hWizwId4pwNk4MdUE828QaE=; b=li1lAH8BtcCs0+ZwtqHQI
	ckR05X6VZ5yuea7sxpT9zO0bXgtP2vu7J5Q89jhu9pTvbRi6lHGrE+kziYliNaCr
	iL/3IX7XkK9ZxLhL3QlashZa7Z/ffUcW9uJWtynmg4YuyVvC9xAcPAVPtnYcrQxO
	nkm0vXu5iKhYc/4CeqsiJvUyI4lM5mFtUPTcKlEK7bQWzlWytvDsl/u3PFJGkSOJ
	BBctUTNXWWDjfHAfLPhjmeS4fkAX7/1ISnQzb1LzP4eJBigN58jdAd64Eqit5hQq
	qVNAwO8qqPvraaQ/T2DzF2/PI6pt0JPKwc2DYEWkkor0K2WiZv3FB5AcaFFJeDQ8
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 464t5gbf12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 00:25:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53L4PcTF006821
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Apr 2025 00:25:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Apr 2025 00:25:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Apr 2025 00:25:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 21 Apr 2025 00:25:38 -0400
Received: from analog.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53L4P3oi002018;
	Mon, 21 Apr 2025 00:25:30 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 21 Apr 2025 12:24:54 +0800
Subject: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250421-togreg-v5-3-94341574240f@analog.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
In-Reply-To: <20250421-togreg-v5-0-94341574240f@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745209504; l=16992;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=HnRY5Dux9JSF0fXtq+61SeUb80no9Q0BmwJ5uCmKA3c=;
 b=P+w0wInfO0Ri4Jn/4hCJAh7rPD5rmNie8Cc9Go6nzY7VsuQaT/TJ8WaRFztTmWH/EVVnmESz/
 9ZRt8j7MXMuAF7dVzKjnrucmXY/MrnRMMkuxoFoB1Qblgn9e7cj6pAy
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RaiQC0tv c=1 sm=1 tr=0 ts=6805c8c4 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=gSiz_irBYLZb22r3yjwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: E3RhaH7uRftKniaF3QC0UVXV9HcnGZhP
X-Proofpoint-ORIG-GUID: E3RhaH7uRftKniaF3QC0UVXV9HcnGZhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210031

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

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  11 +
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad3530r.c | 503 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 516 insertions(+)

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
index 0000000000000000000000000000000000000000..05bd191e5225bd267f42ba36bbd42a18e6f22291
--- /dev/null
+++ b/drivers/iio/dac/ad3530r.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
+ * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
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
+
+#define AD3530R_SW_RESET			(BIT(7) | BIT(0))
+#define AD3530R_MAX_CHANNELS			8
+#define AD3531R_MAX_CHANNELS			4
+#define AD3530R_INTERNAL_VREF_MV		2500
+#define AD3530R_LDAC_PULSE_US			100
+
+enum ad3530r_mode {
+	AD3530R_NORMAL_OPERATION,
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
+	int (*input_ch_reg)(unsigned int c);
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
+	int vref_mv;
+	/*
+	 * DMA (thus cache coherency maintenance) may require the transfer
+	 * buffers to live in their own cache lines.
+	 */
+	__be16 buf __aligned(IIO_DMA_MINALIGN);
+};
+
+static int ad3530r_input_ch_reg(unsigned int c)
+{
+	return 2 * c + AD3530R_INPUT_CH;
+}
+
+static int ad3531r_input_ch_reg(unsigned int c)
+{
+	return 2 * c + AD3531R_INPUT_CH;
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
+	unsigned int mask, val, reg;
+	bool powerdown;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	mask = GENMASK(chan->address + 1, chan->address);
+	reg = chan->channel < AD3531R_MAX_CHANNELS ?
+	      AD3530R_OUTPUT_OPERATING_MODE_0 :
+	      AD3530R_OUTPUT_OPERATING_MODE_1;
+	val = (powerdown ? st->chan[chan->channel].powerdown_mode : 0)
+	       << chan->address;
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
+		*val = st->vref_mv;
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
+		if (val < 0 || val > U16_MAX)
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
+#define AD3530R_CHAN(_chan, _pos) {					\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = _chan,						\
+	.address = _pos,						\
+	.output = 1,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_SCALE),			\
+	.ext_info = ad3530r_ext_info,					\
+}
+
+static const struct iio_chan_spec ad3530r_channels[] = {
+	AD3530R_CHAN(0, 0),
+	AD3530R_CHAN(1, 2),
+	AD3530R_CHAN(2, 4),
+	AD3530R_CHAN(3, 6),
+	AD3530R_CHAN(4, 0),
+	AD3530R_CHAN(5, 2),
+	AD3530R_CHAN(6, 4),
+	AD3530R_CHAN(7, 6),
+};
+
+static const struct iio_chan_spec ad3531r_channels[] = {
+	AD3530R_CHAN(0, 0),
+	AD3530R_CHAN(1, 2),
+	AD3530R_CHAN(2, 4),
+	AD3530R_CHAN(3, 6),
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
+static int ad3530r_setup(struct ad3530r_state *st, int vref,
+			 bool has_external_vref)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct gpio_desc *reset_gpio;
+	int i, ret;
+	u8 range_multiplier;
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	if (reset_gpio) {
+		/* Perform hardware reset */
+		fsleep(1000);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+	} else {
+		/* Perform software reset */
+		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
+					 AD3530R_SW_RESET, AD3530R_SW_RESET);
+		if (ret)
+			return ret;
+	}
+
+	fsleep(10000);
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
+	if (!has_external_vref && st->chip_info->internal_ref_support) {
+		ret = regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
+				      AD3530R_REFERENCE_CONTROL_SEL);
+		if (ret)
+			return ret;
+
+		st->vref_mv = range_multiplier * AD3530R_INTERNAL_VREF_MV;
+	}
+
+	if (has_external_vref)
+		st->vref_mv = range_multiplier * vref / 1000;
+
+	/* Set operating mode to normal operation. */
+	ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0,
+			   AD3530R_NORMAL_OPERATION);
+	if (ret)
+		return ret;
+
+	if (st->chip_info->num_channels > AD3531R_MAX_CHANNELS) {
+		ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1,
+				   AD3530R_NORMAL_OPERATION);
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
+	bool has_external_vref;
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
+	has_external_vref = vref != -ENODEV;
+
+	if (!st->chip_info->internal_ref_support && !has_external_vref)
+		return -ENODEV;
+
+	ret = ad3530r_setup(st, vref, has_external_vref);
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


