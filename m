Return-Path: <linux-iio+bounces-17241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825FBA6D91D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 12:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C15D16D1A8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078725E45F;
	Mon, 24 Mar 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qf3vbu5Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18525DCE0;
	Mon, 24 Mar 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815474; cv=none; b=RggkPLnj7igAUmop3vaSFwvtAQHV4Of0FgWy+RYRNyMuZTaH7V1mJ/HQwrG5licU1PBopLdftqamRpt7ieKg1+leIsg7HLJbinFvNG02G11Vr6yoP9IqEWOTM2hDrlcc5fP3z6j7v1TUbkJzRcbho5XPcEkjIy3N16zDPf+pY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815474; c=relaxed/simple;
	bh=o3NCOydOHsPLfm+8UDPnC3MoUQTW6nUYIgKliVukn2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qlwZugPjW+Fq8IlTUpViInkQYT1L9z0sO7oaB4jNWzRdDRWvMCPI/PWmJQUyeOL1Da1cumYy58gB4kmFcV3wOb/S2OPThZzRVp9tXX0hJciIj8eK9pwQAjC/Hsyl0+CVGShGskPSy54NnZWyejY7ZN3HkbywnJDMuYCcUsZHU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qf3vbu5Y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OBC3JY015962;
	Mon, 24 Mar 2025 07:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=U8D9o
	yJaBoVLYsYhEIrspyWdRYgmqxGK3HO+Vzip2+s=; b=qf3vbu5YTDQZMpMtQQ8KM
	FCK2VUMZ8VyH7VN1Ie2+NdyAJqUtQHoLwjnmPoyMx+9C1Y6RI4S46PWjZvpWf16p
	qDa4QekgYuq6QXZjD+r4ae7pVp5sHlMmpbp57imHVHafrMy5mL/GuLyC277g4PIh
	KBGXqFrf6AD9+RSfUrIwaYU9905JmligXF4uofNXqFtArpp1dpfjA44jewDanCap
	rsHPSMA3S1JZMgVya5xpsdKNhUDwA449WVo2BfwfybBEuRWrpflxz8jsPwKiDhR3
	WeBzHFt7Rsb+2T7wKViReQJGmKHursemyzRMIsCT6i95Q3rdPPU0vVTRShNJSh3n
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45k6af825a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:24:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52OBO5kt052283
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 07:24:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:24:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:24:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 07:24:05 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.117.223.46])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52OBNb9k007643;
	Mon, 24 Mar 2025 07:23:56 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 24 Mar 2025 19:22:58 +0800
Subject: [PATCH v2 4/4] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250324-togreg-v2-4-f211d781923e@analog.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
In-Reply-To: <20250324-togreg-v2-0-f211d781923e@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742815405; l=19591;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=o3NCOydOHsPLfm+8UDPnC3MoUQTW6nUYIgKliVukn2w=;
 b=cc0pRLq3ENNFUsNM9eSNjsarGsauzl5gQ8jawHJdDFOR++54zlYG6XzbeuWWOxYGsITNb04xN
 lfTpWvUQ4NwAn4lr1yDarxquMV8/50dv/5U4NXa1s1YMbFH9bHqkISH
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: zgXjHMtCjTgWQv7fR7E-ve8Z61aoqW8t
X-Proofpoint-GUID: zgXjHMtCjTgWQv7fR7E-ve8Z61aoqW8t
X-Authority-Analysis: v=2.4 cv=FPEbx/os c=1 sm=1 tr=0 ts=67e140e2 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=Kq99qKDDN7JEbRGF57kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240083

The AD3530R/AD3530 is an 8-Channel, 16-Bit Voltage Output DAC, while the
AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC. These devices
include software-programmable gain controls that provide full-scale
output spans of 2.5V or 5V for reference voltages of 2.5V. They operate
from a single supply voltage range of 2.7V to 5.5V and are guaranteed to
be monotonic by design. Additionally, these devices features a 2.5V,
5ppm/°C internal reference, which is disabled by default.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  11 +
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad3530r.c | 586 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 599 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7862469226f52375adc219115ef68d03662127be..ff99f4fb3d675d6012dc5d30ef4d6b17b11313b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1296,6 +1296,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ad3530r
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
index 0000000000000000000000000000000000000000..6fe657220f33d7adb41b1307a514f509127ebbe4
--- /dev/null
+++ b/drivers/iio/dac/ad3530r.c
@@ -0,0 +1,586 @@
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
+#include <linux/kernel.h>
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
+#define AD3530R_MUX_OUT_SELECT			0x93
+#define AD3530R_SW_LDAC_TRIG_A			0xE5
+#define AD3530R_INPUT_CH(c)			(2 * (c) + 0xEB)
+
+#define AD3531R_SW_LDAC_TRIG_A			0xDD
+#define AD3531R_INPUT_CH(c)			(2 * (c) + 0xE3)
+
+#define AD3530R_SW_LDAC_TRIG_MASK		BIT(7)
+#define AD3530R_OUTPUT_CONTROL_MASK		BIT(2)
+#define AD3530R_REFERENCE_CONTROL_MASK		BIT(0)
+#define AD3530R_REG_VAL_MASK			GENMASK(15, 0)
+
+#define AD3530R_SW_RESET			(BIT(7) | BIT(0))
+#define AD3530R_MAX_CHANNELS			8
+#define AD3531R_MAX_CHANNELS			4
+#define AD3530R_CH(c)				(c)
+#define AD3530R_32KOHM_POWERDOWN_MODE		3
+#define AD3530R_INTERNAL_VREF_MV		2500
+#define AD3530R_LDAC_PULSE_US			100
+
+enum {
+	AD3530R_MUXOUT_POWERED_DOWN,
+	AD3530R_MUXOUT_VOUT0,
+	AD3530R_MUXOUT_IOUT0_SOURCE,
+	AD3530R_MUXOUT_IOUT0_SINK,
+	AD3530R_MUXOUT_VOUT1,
+	AD3530R_MUXOUT_IOUT1_SOURCE,
+	AD3530R_MUXOUT_IOUT1_SINK,
+	AD3530R_MUXOUT_VOUT2,
+	AD3530R_MUXOUT_IOUT2_SOURCE,
+	AD3530R_MUXOUT_IOUT2_SINK,
+	AD3530R_MUXOUT_VOUT3,
+	AD3530R_MUXOUT_IOUT3_SOURCE,
+	AD3530R_MUXOUT_IOUT3_SINK,
+	AD3530R_MUXOUT_VOUT4,
+	AD3530R_MUXOUT_IOUT4_SOURCE,
+	AD3530R_MUXOUT_IOUT4_SINK,
+	AD3530R_MUXOUT_VOUT5,
+	AD3530R_MUXOUT_IOUT5_SOURCE,
+	AD3530R_MUXOUT_IOUT5_SINK,
+	AD3530R_MUXOUT_VOUT6,
+	AD3530R_MUXOUT_IOUT6_SOURCE,
+	AD3530R_MUXOUT_IOUT6_SINK,
+	AD3530R_MUXOUT_VOUT7,
+	AD3530R_MUXOUT_IOUT7_SOURCE,
+	AD3530R_MUXOUT_IOUT7_SINK,
+	AD3530R_MUXOUT_DIE_TEMP,
+	AD3530R_MUXOUT_AGND,
+};
+
+struct ad3530r_chan {
+	unsigned int powerdown_mode;
+	bool powerdown;
+};
+
+struct ad3530r_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	int (*input_ch_reg)(unsigned int c);
+	const int iio_chan;
+	unsigned int num_channels;
+	unsigned int sw_ldac_trig_reg;
+};
+
+struct ad3530r_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct mutex lock; /* protect the state of the device */
+	struct ad3530r_chan chan[AD3530R_MAX_CHANNELS];
+	const struct ad3530r_chip_info *chip_info;
+	struct gpio_desc *ldac_gpio;
+	int vref_mv;
+	u8 ldac;
+	bool range_multiplier;
+};
+
+static int ad3530r_input_ch_reg(unsigned int c)
+{
+	return AD3530R_INPUT_CH(c);
+}
+
+static int ad3531r_input_ch_reg(unsigned int c)
+{
+	return AD3531R_INPUT_CH(c);
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
+	unsigned int mask, val;
+	bool powerdown;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	switch (chan->channel) {
+	case AD3530R_CH(0) ... AD3530R_CH(AD3531R_MAX_CHANNELS - 1):
+		mask = GENMASK(chan->channel * 2 + 1, chan->channel * 2);
+		val = (powerdown ? st->chan[chan->channel].powerdown_mode : 0)
+		      << (chan->channel * 2);
+
+		ret = regmap_update_bits(st->regmap,
+					 AD3530R_OUTPUT_OPERATING_MODE_0,
+					 mask, val);
+		if (ret)
+			return ret;
+
+		st->chan[chan->channel].powerdown = powerdown;
+		return len;
+	case AD3530R_CH(AD3531R_MAX_CHANNELS) ...
+	     AD3530R_CH(AD3530R_MAX_CHANNELS - 1):
+		mask = GENMASK((chan->channel - 4) * 2 + 1,
+			       (chan->channel - 4) * 2);
+		val = (powerdown ? st->chan[chan->channel].powerdown_mode : 0)
+		      << ((chan->channel - 4) * 2);
+
+		ret = regmap_update_bits(st->regmap,
+					 AD3530R_OUTPUT_OPERATING_MODE_1,
+					 mask, val);
+		if (ret)
+			return ret;
+
+		st->chan[chan->channel].powerdown = powerdown;
+		return len;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const char * const ad3530r_muxout_select[] = {
+	[AD3530R_MUXOUT_POWERED_DOWN] = "powered_down",
+	[AD3530R_MUXOUT_VOUT0] = "vout0",
+	[AD3530R_MUXOUT_IOUT0_SOURCE] = "iout0_source",
+	[AD3530R_MUXOUT_IOUT0_SINK] = "iout0_sink",
+	[AD3530R_MUXOUT_VOUT1] = "vout1",
+	[AD3530R_MUXOUT_IOUT1_SOURCE] = "iout1_source",
+	[AD3530R_MUXOUT_IOUT1_SINK] = "iout1_sink",
+	[AD3530R_MUXOUT_VOUT2] = "vout2",
+	[AD3530R_MUXOUT_IOUT2_SOURCE] = "iout2_source",
+	[AD3530R_MUXOUT_IOUT2_SINK] = "iout2_sink",
+	[AD3530R_MUXOUT_VOUT3] = "vout3",
+	[AD3530R_MUXOUT_IOUT3_SOURCE] = "iout3_source",
+	[AD3530R_MUXOUT_IOUT3_SINK] = "iout3_sink",
+	[AD3530R_MUXOUT_VOUT4] = "vout4",
+	[AD3530R_MUXOUT_IOUT4_SOURCE] = "iout4_source",
+	[AD3530R_MUXOUT_IOUT4_SINK] = "iout4_sink",
+	[AD3530R_MUXOUT_VOUT5] = "vout5",
+	[AD3530R_MUXOUT_IOUT5_SOURCE] = "iout5_source",
+	[AD3530R_MUXOUT_IOUT5_SINK] = "iout5_sink",
+	[AD3530R_MUXOUT_VOUT6] = "vout6",
+	[AD3530R_MUXOUT_IOUT6_SOURCE] = "iout6_source",
+	[AD3530R_MUXOUT_IOUT6_SINK] = "iout6_sink",
+	[AD3530R_MUXOUT_VOUT7] = "vout7",
+	[AD3530R_MUXOUT_IOUT7_SOURCE] = "iout7_source",
+	[AD3530R_MUXOUT_IOUT7_SINK] = "iout7_sink",
+	[AD3530R_MUXOUT_DIE_TEMP] = "die_temp",
+	[AD3530R_MUXOUT_AGND] = "agnd",
+};
+
+static int ad3530r_get_muxout_select(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD3530R_MUX_OUT_SELECT, &val);
+	if (ret)
+		return ret;
+
+	return val;
+}
+
+static int ad3530r_set_muxout_select(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     unsigned int val)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+
+	return regmap_write(st->regmap, AD3530R_MUX_OUT_SELECT, val);
+}
+
+static const struct iio_enum ad3530r_muxout_select_enum = {
+	.items = ad3530r_muxout_select,
+	.num_items = ARRAY_SIZE(ad3530r_muxout_select),
+	.get = ad3530r_get_muxout_select,
+	.set = ad3530r_set_muxout_select,
+};
+
+static int ad3530r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
+{
+	gpiod_set_value_cansleep(ldac_gpio, 0);
+	usleep_range(AD3530R_LDAC_PULSE_US, AD3530R_LDAC_PULSE_US + 10);
+	gpiod_set_value_cansleep(ldac_gpio, 1);
+
+	return 0;
+}
+
+static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
+			     unsigned int val)
+{
+	int ret;
+	__be16 reg_val;
+
+	guard(mutex)(&st->lock);
+	reg_val = cpu_to_be16(val);
+
+	ret = regmap_bulk_write(st->regmap, st->chip_info->input_ch_reg(chan),
+				&reg_val, 2);
+	if (ret)
+		return ret;
+
+	if (st->ldac_gpio)
+		return ad3530r_trigger_hw_ldac(st->ldac_gpio);
+
+	return regmap_update_bits(st->regmap, st->chip_info->sw_ldac_trig_reg,
+				  AD3530R_SW_LDAC_TRIG_MASK,
+				  FIELD_PREP(AD3530R_SW_LDAC_TRIG_MASK, 1));
+}
+
+static int ad3530r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	int ret;
+	__be16 reg_val;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_bulk_read(st->regmap,
+				       st->chip_info->input_ch_reg(chan->channel),
+				       &reg_val, 2);
+		if (ret)
+			return ret;
+
+		*val = FIELD_GET(AD3530R_REG_VAL_MASK, be16_to_cpu(reg_val));
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mv;
+		*val2 = 16;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 0;
+
+		return IIO_VAL_INT;
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
+#define AD3530R_CHAN_EXT_INFO(_name, _what, _read, _write) {		\
+	.name = (_name),						\
+	.read = (_read),						\
+	.write = (_write),						\
+	.private = (_what),						\
+	.shared = IIO_SEPARATE,						\
+}
+
+static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
+	AD3530R_CHAN_EXT_INFO("powerdown", 0, ad3530r_get_dac_powerdown,
+			      ad3530r_set_dac_powerdown),
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3530r_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
+			   &ad3530r_powerdown_mode_enum),
+	IIO_ENUM("muxout_select", IIO_SHARED_BY_ALL, &ad3530r_muxout_select_enum),
+	IIO_ENUM_AVAILABLE("muxout_select", IIO_SHARED_BY_ALL,
+			   &ad3530r_muxout_select_enum),
+	{ },
+};
+
+#define AD3530R_CHAN(_chan) {						\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = _chan,						\
+	.output = 1,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_SCALE) |		\
+			      BIT(IIO_CHAN_INFO_OFFSET),		\
+	.ext_info = ad3530r_ext_info,					\
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
+static const struct ad3530r_chip_info ad3530r_chip = {
+	.name = "ad3530r",
+	.channels = ad3530r_channels,
+	.num_channels = ARRAY_SIZE(ad3530r_channels),
+	.sw_ldac_trig_reg = AD3530R_SW_LDAC_TRIG_A,
+	.input_ch_reg = ad3530r_input_ch_reg,
+};
+
+static const struct ad3530r_chip_info ad3531r_chip = {
+	.name = "ad3531r",
+	.channels = ad3531r_channels,
+	.num_channels = ARRAY_SIZE(ad3531r_channels),
+	.sw_ldac_trig_reg = AD3531R_SW_LDAC_TRIG_A,
+	.input_ch_reg = ad3531r_input_ch_reg,
+};
+
+static int ad3530r_setup(struct ad3530r_state *st)
+{
+	const struct ad3530r_chip_info *chip_info = st->chip_info;
+	struct device *dev = &st->spi->dev;
+	struct gpio_desc *reset_gpio;
+	int i, ret;
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	if (reset_gpio) {
+		/* Perform hardware reset */
+		usleep_range(20, 25);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+	} else {
+		/* Perform software reset */
+		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
+					 AD3530R_SW_RESET, AD3530R_SW_RESET);
+		if (ret)
+			return ret;
+	}
+
+	usleep_range(10000, 15000);
+
+	/* Set operating mode to normal operation. */
+	ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0, 0);
+	if (ret)
+		return ret;
+
+	if (chip_info->num_channels > AD3531R_MAX_CHANNELS) {
+		ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1, 0);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < chip_info->num_channels; i++)
+		st->chan[i].powerdown_mode = AD3530R_32KOHM_POWERDOWN_MODE;
+
+	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->ldac_gpio))
+		return dev_err_probe(&st->spi->dev, PTR_ERR(st->ldac_gpio),
+				     "Failed to get ldac GPIO\n");
+
+	if (device_property_present(dev, "adi,double-output-range")) {
+		st->range_multiplier = true;
+
+		return regmap_update_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
+					  AD3530R_OUTPUT_CONTROL_MASK,
+					  FIELD_PREP(AD3530R_OUTPUT_CONTROL_MASK, 1));
+	}
+
+	return 0;
+}
+
+static const struct regmap_config ad3530r_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+};
+
+static const struct iio_info ad3530r_info = {
+	.read_raw = ad3530r_read_raw,
+	.write_raw = ad3530r_write_raw,
+	.debugfs_reg_access = &ad3530r_reg_access,
+};
+
+static int ad3530r_probe(struct spi_device *spi)
+{
+	static const char * const regulators[] = { "vdd", "iovdd" };
+	const struct ad3530r_chip_info *chip_info;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad3530r_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	st->regmap = devm_regmap_init_spi(spi, &ad3530r_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to init regmap");
+
+	mutex_init(&st->lock);
+
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODEV;
+
+	st->chip_info = chip_info;
+
+	ret = ad3530r_setup(st);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+
+	if (ret > 0) {
+		st->vref_mv = st->range_multiplier ? 2 * ret / 1000 : ret / 1000;
+	} else {
+		/* Internal reference. */
+		ret = regmap_update_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
+					 AD3530R_REFERENCE_CONTROL_MASK,
+					 FIELD_PREP(AD3530R_REFERENCE_CONTROL_MASK, 1));
+		if (ret)
+			return ret;
+
+		st->vref_mv = st->range_multiplier ?
+			      2 * AD3530R_INTERNAL_VREF_MV :
+			      AD3530R_INTERNAL_VREF_MV;
+	}
+
+	indio_dev->name = chip_info->name;
+	indio_dev->info = &ad3530r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = chip_info->num_channels;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad3530r_id[] = {
+	{ "ad3530r", (kernel_ulong_t)&ad3530r_chip },
+	{ "ad3531r", (kernel_ulong_t)&ad3531r_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad3530r_id);
+
+static const struct of_device_id ad3530r_of_match[] = {
+	{ .compatible = "adi,ad3530r", .data = &ad3530r_chip },
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


