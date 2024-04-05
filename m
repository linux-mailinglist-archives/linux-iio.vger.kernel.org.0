Return-Path: <linux-iio+bounces-4089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C94B89A05B
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 16:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E581F23AED
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D06616F8EE;
	Fri,  5 Apr 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WwFOgtrO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96116F820;
	Fri,  5 Apr 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329039; cv=none; b=m8ugX0HwC8g5Q9+pHQ7SLwMPRRQaia4CJny144swykRh3wpUpa+vGfPlpHG4emuMtGv7SR1lIx4a66/0nK7n/EAxMfqhu3A5VeS2dQV6Br0SNhvS9ruNWLVTQxPq6kManLvBCxMG0DHYoM1Jf5o8FTZpkEM7BnpJdItfuv0X4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329039; c=relaxed/simple;
	bh=1w0GxauY/xRSQldbL8OdnykulHM4xhau/QlQNP9L+oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DnqI00I5qN1BjVFrDzxUEwk8J89/fi2vjaa03hxF4i7rWd+XE8qAjyqqpbkqH4p6tlb86YMiiJKjnbHbSE8aQs4+mZ1h/T59IYyCUpxQL+XXT+nrh+c1TSCzKO6NuRap078t9GtANIbTohNkXrNcvLJWZl+bm0WKQu6JTbJUedQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WwFOgtrO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435EeSTQ002541;
	Fri, 5 Apr 2024 10:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=RRoKbHvGfv87WCc0gta/QzktbJejLAsd9xeLuoMaomg=; b=
	WwFOgtrORHoqM1UFjXMiMjFiBVW4KT+bUmNWf9kR1i87RH33nR/8c7tw4pZQj10K
	PkrQLUPCGKNNyhUnU8YaNxJWrJmS0BFezV5kLUxdasynqHPuQRuMXIZHIC1U2E/7
	tQjwpIa6C4mRKD9JMGEib6uNJoKPVBtig//KT7+gVQwcxhWqhSBu0ibOzLFSzyzW
	+s++jdPTGjkS9pOnLJdqgnQTrtXIYx90Iy1vtJCSF6O7WnBTCUsdIIz1vXCVtk2z
	E/90r5F2sbANhFArqxfW3qD/sb2ME8i3frmExw19tPcFICkdOaN27K5sWFMBJdlT
	a3TVH5MnOuE40gjZj4MzPw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xak96r2k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:56:58 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 435Euv3d064546
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 10:56:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 5 Apr 2024
 10:56:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 5 Apr 2024 10:56:56 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 435EuSI8019011;
	Fri, 5 Apr 2024 10:56:52 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 5 Apr 2024 17:00:08 +0200
Subject: [PATCH v2 10/11] iio: dac: add support for AXI DAC IP core
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-iio-backend-axi-dac-v2-10-293bab7d5552@analog.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
In-Reply-To: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Dragos Bogdan <dragos.bogdan@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712329201; l=20761;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1w0GxauY/xRSQldbL8OdnykulHM4xhau/QlQNP9L+oc=;
 b=3ijWVCDSuprZZQM+JXDPEjfBtgIZSNEfwyaPXrgu4AGtAl6n0Ophd5leniCBQpv09F3AE5CX3
 axqrdjaJzdfAz5ElmCAJnXgFll6Sb2I9n4VwUex753lJSHudwefayZU
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: iwA0GkwEP0dj1yb_1fOSymlEfMN-uRHM
X-Proofpoint-GUID: iwA0GkwEP0dj1yb_1fOSymlEfMN-uRHM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050106

Support the Analog Devices Generic AXI DAC IP core. The IP core is used
for interfacing with digital-to-analog (DAC) converters that require either
a high-speed serial interface (JESD204B/C) or a source synchronous parallel
interface (LVDS/CMOS). Typically (for such devices) SPI will be used for
configuration only, while this IP core handles the streaming of data into
memory via DMA.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 MAINTAINERS                   |   1 +
 drivers/iio/dac/Kconfig       |  21 ++
 drivers/iio/dac/Makefile      |   1 +
 drivers/iio/dac/adi-axi-dac.c | 635 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 658 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 76e872e320d7..505f28dc6da6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1413,6 +1413,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
+F:	drivers/iio/dac/adi-axi-dac.c
 
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 34eb40bb9529..7c0a8caa9a34 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -131,6 +131,27 @@ config AD5624R_SPI
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
+config ADI_AXI_DAC
+	tristate "Analog Devices Generic AXI DAC IP core driver"
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
+	select REGMAP_MMIO
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices Generic
+	  AXI DAC IP core. The IP core is used for interfacing with
+	  digital-to-analog (DAC) converters that require either a high-speed
+	  serial interface (JESD204B/C) or a source synchronous parallel
+	  interface (LVDS/CMOS).
+	  Typically (for such devices) SPI will be used for configuration only,
+	  while this IP core handles the streaming of data into memory via DMA.
+
+	  Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adi-axi-dac.
+
 config LTC2688
 	tristate "Analog Devices LTC2688 DAC spi driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 55bf89739d14..6bcaa65434b2 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_AD5696_I2C) += ad5696-i2c.o
 obj-$(CONFIG_AD7293) += ad7293.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_AD8801) += ad8801.o
+obj-$(CONFIG_ADI_AXI_DAC) += adi-axi-dac.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
 obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
 obj-$(CONFIG_DS4424) += ds4424.o
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
new file mode 100644
index 000000000000..9047c5aec0ff
--- /dev/null
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -0,0 +1,635 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices Generic AXI DAC IP core
+ * Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+ *
+ * Copyright 2016-2024 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/limits.h>
+#include <linux/kstrtox.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <linux/fpga/adi-axi-common.h>
+#include <linux/iio/backend.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+
+/*
+ * Register definitions:
+ *   https://wiki.analog.com/resources/fpga/docs/axi_dac_ip#register_map
+ */
+
+/* Base controls */
+#define AXI_DAC_REG_CONFIG		0x0c
+#define	   AXI_DDS_DISABLE		BIT(6)
+
+ /* DAC controls */
+#define AXI_DAC_REG_RSTN		0x0040
+#define   AXI_DAC_RSTN_CE_N		BIT(2)
+#define   AXI_DAC_RSTN_MMCM_RSTN	BIT(1)
+#define   AXI_DAC_RSTN_RSTN		BIT(0)
+#define AXI_DAC_REG_CNTRL_1		0x0044
+#define   AXI_DAC_SYNC			BIT(0)
+#define AXI_DAC_REG_CNTRL_2		0x0048
+#define	  ADI_DAC_R1_MODE		BIT(4)
+#define AXI_DAC_DRP_STATUS		0x0074
+#define   AXI_DAC_DRP_LOCKED		BIT(17)
+/* DAC Channel controls */
+#define AXI_DAC_REG_CHAN_CNTRL_1(c)	(0x0400 + (c) * 0x40)
+#define AXI_DAC_REG_CHAN_CNTRL_3(c)	(0x0408 + (c) * 0x40)
+#define   AXI_DAC_SCALE_SIGN		BIT(15)
+#define   AXI_DAC_SCALE_INT		BIT(14)
+#define   AXI_DAC_SCALE			GENMASK(14, 0)
+#define AXI_DAC_REG_CHAN_CNTRL_2(c)	(0x0404 + (c) * 0x40)
+#define AXI_DAC_REG_CHAN_CNTRL_4(c)	(0x040c + (c) * 0x40)
+#define   AXI_DAC_PHASE			GENMASK(31, 16)
+#define   AXI_DAC_FREQUENCY		GENMASK(15, 0)
+#define AXI_DAC_REG_CHAN_CNTRL_7(c)	(0x0418 + (c) * 0x40)
+#define   AXI_DAC_DATA_SEL		GENMASK(3, 0)
+
+/* 360 degrees in rad */
+#define AXI_DAC_2_PI_MEGA		6283190
+enum {
+	AXI_DAC_DATA_INTERNAL_TONE,
+	AXI_DAC_DATA_DMA = 2,
+};
+
+struct axi_dac_state {
+	struct regmap *regmap;
+	struct device *dev;
+	/*
+	 * lock to protect multiple accesses to the device registers and global
+	 * data/variables.
+	 */
+	struct mutex lock;
+	u64 dac_clk;
+	u32 reg_config;
+	bool int_tone;
+};
+
+static int axi_dac_enable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	unsigned int __val;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_RSTN,
+			      AXI_DAC_RSTN_MMCM_RSTN);
+	if (ret)
+		return ret;
+	/*
+	 * Make sure the DRP (Dynamic Reconfiguration Port) is locked. Not all
+	 * designs really use it but if they don't we still get the lock bit
+	 * set. So let's do it all the time so the code is generic.
+	 */
+	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_DRP_STATUS, __val,
+				       __val & AXI_DAC_DRP_LOCKED, 100, 1000);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_RSTN,
+			       AXI_DAC_RSTN_RSTN | AXI_DAC_RSTN_MMCM_RSTN);
+}
+
+static void axi_dac_disable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	guard(mutex)(&st->lock);
+	regmap_write(st->regmap, AXI_DAC_REG_RSTN, 0);
+}
+
+static struct iio_buffer *axi_dac_request_buffer(struct iio_backend *back,
+						 struct iio_dev *indio_dev)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	const char *dma_name;
+
+	if (device_property_read_string(st->dev, "dma-names", &dma_name))
+		dma_name = "tx";
+
+	return iio_dmaengine_buffer_setup_ext(st->dev, indio_dev, dma_name,
+					      IIO_BUFFER_DIRECTION_OUT);
+}
+
+static void axi_dac_free_buffer(struct iio_backend *back,
+				struct iio_buffer *buffer)
+{
+	iio_dmaengine_buffer_free(buffer);
+}
+
+enum {
+	AXI_DAC_FREQ_TONE_1,
+	AXI_DAC_FREQ_TONE_2,
+	AXI_DAC_SCALE_TONE_1,
+	AXI_DAC_SCALE_TONE_2,
+	AXI_DAC_PHASE_TONE_1,
+	AXI_DAC_PHASE_TONE_2,
+};
+
+static int __axi_dac_frequency_get(struct axi_dac_state *st, unsigned int chan,
+				   unsigned int tone_2, unsigned int *freq)
+{
+	u32 reg, raw;
+	int ret;
+
+	if (!st->dac_clk) {
+		dev_err(st->dev, "Sampling rate is 0...\n");
+		return -EINVAL;
+	}
+
+	if (tone_2)
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan);
+
+	ret = regmap_read(st->regmap, reg, &raw);
+	if (ret)
+		return ret;
+
+	raw = FIELD_GET(AXI_DAC_FREQUENCY, raw);
+	*freq = DIV_ROUND_CLOSEST_ULL(raw * st->dac_clk, BIT(16));
+
+	return 0;
+}
+
+static int axi_dac_frequency_get(struct axi_dac_state *st,
+				 const struct iio_chan_spec *chan, char *buf,
+				 unsigned int tone_2)
+{
+	unsigned int freq;
+	int ret;
+
+	scoped_guard(mutex, &st->lock) {
+		ret = __axi_dac_frequency_get(st, chan->channel, tone_2, &freq);
+		if (ret)
+			return ret;
+	}
+
+	return sysfs_emit(buf, "%u\n", freq);
+}
+
+static int axi_dac_scale_get(struct axi_dac_state *st,
+			     const struct iio_chan_spec *chan, char *buf,
+			     unsigned int tone_2)
+{
+	unsigned int scale, sign;
+	int ret, vals[2];
+	u32 reg, raw;
+
+	if (tone_2)
+		reg = AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
+
+	ret = regmap_read(st->regmap, reg, &raw);
+	if (ret)
+		return ret;
+
+	sign = FIELD_GET(AXI_DAC_SCALE_SIGN, raw);
+	raw = FIELD_GET(AXI_DAC_SCALE, raw);
+	scale = DIV_ROUND_CLOSEST_ULL((u64)raw * MEGA, AXI_DAC_SCALE_INT);
+
+	vals[0] = scale / MEGA;
+	vals[1] = scale % MEGA;
+
+	if (sign) {
+		vals[0] *= -1;
+		if (!vals[0])
+			vals[1] *= -1;
+	}
+
+	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(vals),
+				vals);
+}
+
+static int axi_dac_phase_get(struct axi_dac_state *st,
+			     const struct iio_chan_spec *chan, char *buf,
+			     unsigned int tone_2)
+{
+	u32 reg, raw, phase;
+	int ret, vals[2];
+
+	if (tone_2)
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+
+	ret = regmap_read(st->regmap, reg, &raw);
+	if (ret)
+		return ret;
+
+	raw = FIELD_GET(AXI_DAC_PHASE, raw);
+	phase = DIV_ROUND_CLOSEST_ULL((u64)raw * AXI_DAC_2_PI_MEGA, U16_MAX);
+
+	vals[0] = phase / MEGA;
+	vals[1] = phase % MEGA;
+
+	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(vals),
+				vals);
+}
+
+static int __axi_dac_frequency_set(struct axi_dac_state *st, unsigned int chan,
+				   u64 sample_rate, unsigned int freq,
+				   unsigned int tone_2)
+{
+	u32 reg;
+	u16 raw;
+	int ret;
+
+	if (!sample_rate || freq > sample_rate / 2) {
+		dev_err(st->dev, "Invalid frequency(%u) dac_clk(%llu)\n",
+			freq, sample_rate);
+		return -EINVAL;
+	}
+
+	if (tone_2)
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan);
+
+	raw = DIV64_U64_ROUND_CLOSEST((u64)freq * BIT(16), sample_rate);
+
+	ret = regmap_update_bits(st->regmap,  reg, AXI_DAC_FREQUENCY, raw);
+	if (ret)
+		return ret;
+
+	/* synchronize channels */
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+}
+
+static int axi_dac_frequency_set(struct axi_dac_state *st,
+				 const struct iio_chan_spec *chan,
+				 const char *buf, size_t len, unsigned int tone_2)
+{
+	unsigned int freq;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	ret = __axi_dac_frequency_set(st, chan->channel, st->dac_clk, freq,
+				      tone_2);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int axi_dac_scale_set(struct axi_dac_state *st,
+			     const struct iio_chan_spec *chan,
+			     const char *buf, size_t len, unsigned int tone_2)
+{
+	int integer, frac, scale;
+	u32 raw = 0, reg;
+	int ret;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
+	if (ret)
+		return ret;
+
+	scale = integer * MEGA + frac;
+	if (scale <= -2 * (int)MEGA || scale >= 2 * (int)MEGA)
+		return -EINVAL;
+
+	/*  format is 1.1.14 (sign, integer and fractional bits) */
+	if (scale < 0) {
+		raw = FIELD_PREP(AXI_DAC_SCALE_SIGN, 1);
+		scale *= -1;
+	}
+
+	raw |= div_u64((u64)scale * AXI_DAC_SCALE_INT, MEGA);
+
+	if (tone_2)
+		reg = AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
+
+	guard(mutex)(&st->lock);
+	ret = regmap_write(st->regmap, reg, raw);
+	if (ret)
+		return ret;
+
+	/* synchronize channels */
+	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int axi_dac_phase_set(struct axi_dac_state *st,
+			     const struct iio_chan_spec *chan,
+			     const char *buf, size_t len, unsigned int tone_2)
+{
+	int integer, frac, phase;
+	u32 raw, reg;
+	int ret;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
+	if (ret)
+		return ret;
+
+	phase = integer * MEGA + frac;
+	if (phase < 0 || phase > AXI_DAC_2_PI_MEGA)
+		return -EINVAL;
+
+	raw = DIV_ROUND_CLOSEST_ULL((u64)phase * U16_MAX, AXI_DAC_2_PI_MEGA);
+
+	if (tone_2)
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+
+	guard(mutex)(&st->lock);
+	ret = regmap_update_bits(st->regmap, reg, AXI_DAC_PHASE,
+				 FIELD_PREP(AXI_DAC_PHASE, raw));
+	if (ret)
+		return ret;
+
+	/* synchronize channels */
+	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int axi_dac_ext_info_set(struct iio_backend *back, uintptr_t private,
+				const struct iio_chan_spec *chan,
+				const char *buf, size_t len)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (private) {
+	case AXI_DAC_FREQ_TONE_1:
+	case AXI_DAC_FREQ_TONE_2:
+		return axi_dac_frequency_set(st, chan, buf, len,
+					     private - AXI_DAC_FREQ_TONE_1);
+	case AXI_DAC_SCALE_TONE_1:
+	case AXI_DAC_SCALE_TONE_2:
+		return axi_dac_scale_set(st, chan, buf, len,
+					 private - AXI_DAC_SCALE_TONE_1);
+	case AXI_DAC_PHASE_TONE_1:
+	case AXI_DAC_PHASE_TONE_2:
+		return axi_dac_phase_set(st, chan, buf, len,
+					 private - AXI_DAC_PHASE_TONE_2);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int axi_dac_ext_info_get(struct iio_backend *back, uintptr_t private,
+				const struct iio_chan_spec *chan, char *buf)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (private) {
+	case AXI_DAC_FREQ_TONE_1:
+	case AXI_DAC_FREQ_TONE_2:
+		return axi_dac_frequency_get(st, chan, buf,
+					     private - AXI_DAC_FREQ_TONE_1);
+	case AXI_DAC_SCALE_TONE_1:
+	case AXI_DAC_SCALE_TONE_2:
+		return axi_dac_scale_get(st, chan, buf,
+					 private - AXI_DAC_SCALE_TONE_1);
+	case AXI_DAC_PHASE_TONE_1:
+	case AXI_DAC_PHASE_TONE_2:
+		return axi_dac_phase_get(st, chan, buf,
+					 private - AXI_DAC_PHASE_TONE_1);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct iio_chan_spec_ext_info axi_dac_ext_info[] = {
+	IIO_BACKEND_EX_INFO("frequency0", IIO_SEPARATE, AXI_DAC_FREQ_TONE_1),
+	IIO_BACKEND_EX_INFO("frequency1", IIO_SEPARATE, AXI_DAC_FREQ_TONE_2),
+	IIO_BACKEND_EX_INFO("scale0", IIO_SEPARATE, AXI_DAC_SCALE_TONE_1),
+	IIO_BACKEND_EX_INFO("scale1", IIO_SEPARATE, AXI_DAC_SCALE_TONE_2),
+	IIO_BACKEND_EX_INFO("phase0", IIO_SEPARATE, AXI_DAC_PHASE_TONE_1),
+	IIO_BACKEND_EX_INFO("phase1", IIO_SEPARATE, AXI_DAC_PHASE_TONE_2),
+	{}
+};
+
+static int axi_dac_extend_chan(struct iio_backend *back,
+			       struct iio_chan_spec *chan)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	if (chan->type != IIO_ALTVOLTAGE)
+		return -EINVAL;
+	if (st->reg_config & AXI_DDS_DISABLE)
+		/* nothing to extend */
+		return 0;
+
+	chan->ext_info = axi_dac_ext_info;
+
+	return 0;
+}
+
+static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
+				   enum iio_backend_data_source data)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (data) {
+	case IIO_BACKEND_INTERNAL_CONTINUOS_WAVE:
+		return regmap_update_bits(st->regmap,
+					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
+					  AXI_DAC_DATA_SEL,
+					  AXI_DAC_DATA_INTERNAL_TONE);
+	case IIO_BACKEND_EXTERNAL:
+		return regmap_update_bits(st->regmap,
+					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
+					  AXI_DAC_DATA_SEL, AXI_DAC_DATA_DMA);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
+				   u64 sample_rate)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	unsigned int freq;
+	int ret, tone;
+
+	if (!sample_rate)
+		return -EINVAL;
+	if (st->reg_config & AXI_DDS_DISABLE)
+		/* sample_rate has no meaning if DDS is disabled */
+		return 0;
+
+	guard(mutex)(&st->lock);
+	/*
+	 * If dac_clk is 0 then this must be the first time we're being notified
+	 * about the interface sample rate. Hence, just update our internal
+	 * variable and bail... If it's not 0, then we get the current DDS
+	 * frequency (for the old rate) and update the registers for the new
+	 * sample rate.
+	 */
+	if (!st->dac_clk) {
+		st->dac_clk = sample_rate;
+		return 0;
+	}
+
+	for (tone = 0; tone <= AXI_DAC_FREQ_TONE_2; tone++) {
+		ret = __axi_dac_frequency_get(st, chan, tone, &freq);
+		if (ret)
+			return ret;
+
+		ret = __axi_dac_frequency_set(st, chan, sample_rate, tone, freq);
+		if (ret)
+			return ret;
+	}
+
+	st->dac_clk = sample_rate;
+
+	return 0;
+}
+
+static const struct iio_backend_ops axi_dac_generic = {
+	.enable = axi_dac_enable,
+	.disable = axi_dac_disable,
+	.request_buffer = axi_dac_request_buffer,
+	.free_buffer = axi_dac_free_buffer,
+	.extend_chan_spec = axi_dac_extend_chan,
+	.ext_info_set = axi_dac_ext_info_set,
+	.ext_info_get = axi_dac_ext_info_get,
+	.data_source_set = axi_dac_data_source_set,
+	.set_sample_rate = axi_dac_set_sample_rate,
+};
+
+static const struct regmap_config axi_dac_regmap_config = {
+	.val_bits = 32,
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x0800,
+};
+
+static int axi_dac_probe(struct platform_device *pdev)
+{
+	const unsigned int *expected_ver;
+	struct axi_dac_state *st;
+	void __iomem *base;
+	unsigned int ver;
+	struct clk *clk;
+	int ret;
+
+	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	expected_ver = device_get_match_data(&pdev->dev);
+	if (!expected_ver)
+		return -ENODEV;
+
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	st->dev = &pdev->dev;
+	st->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					   &axi_dac_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	/*
+	 * Force disable the core. Up to the frontend to enable us. And we can
+	 * still read/write registers...
+	 */
+	ret = regmap_write(st->regmap, AXI_DAC_REG_RSTN, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, ADI_AXI_REG_VERSION, &ver);
+	if (ret)
+		return ret;
+
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
+		dev_err(&pdev->dev,
+			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
+			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
+			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
+			ADI_AXI_PCORE_VER_MAJOR(ver),
+			ADI_AXI_PCORE_VER_MINOR(ver),
+			ADI_AXI_PCORE_VER_PATCH(ver));
+		return -ENODEV;
+	}
+
+	/* Let's get the core read only configuration */
+	ret = regmap_read(st->regmap, AXI_DAC_REG_CONFIG, &st->reg_config);
+	if (ret)
+		return ret;
+
+	/*
+	 * In some designs, setting the R1_MODE bit to 0 (which is the default
+	 * value) causes all channels of the frontend to be routed to the same
+	 * DMA (so they are sampled together). This is for things like
+	 * Multiple-Input and Multiple-Output (MIMO). As most of the times we
+	 * want independent channels let's override the core's default value and
+	 * set the R1_MODE bit.
+	 */
+	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2, ADI_DAC_R1_MODE);
+	if (ret)
+		return ret;
+
+	mutex_init(&st->lock);
+	ret = devm_iio_backend_register(&pdev->dev, &axi_dac_generic, st);
+	if (ret)
+		return ret;
+
+	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
+		 ADI_AXI_PCORE_VER_MAJOR(ver),
+		 ADI_AXI_PCORE_VER_MINOR(ver),
+		 ADI_AXI_PCORE_VER_PATCH(ver));
+
+	return 0;
+}
+
+static unsigned int axi_dac_9_1_b_info = ADI_AXI_PCORE_VER(9, 1, 'b');
+
+static const struct of_device_id axi_dac_of_match[] = {
+	{ .compatible = "adi,axi-dac-9.1.b", .data = &axi_dac_9_1_b_info },
+	{}
+};
+MODULE_DEVICE_TABLE(of, axi_dac_of_match);
+
+static struct platform_driver axi_dac_driver = {
+	.driver = {
+		.name = "adi-axi-dac",
+		.of_match_table = axi_dac_of_match,
+	},
+	.probe = axi_dac_probe,
+};
+module_platform_driver(axi_dac_driver);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices Generic AXI DAC IP core driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.44.0


