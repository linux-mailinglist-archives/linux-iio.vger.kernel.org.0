Return-Path: <linux-iio+bounces-6928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553F59173DD
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 23:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93C5B23D36
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F0F17F398;
	Tue, 25 Jun 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XMts/20K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72617E91D;
	Tue, 25 Jun 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352566; cv=none; b=aL6RGua8u6PqYsCVfRX87ipUNhgzbYN3LpzjNUhb9RZDwDJjwf7XbJwEyYQatImzQT1ipiOhh/BLY8l+WQtbZMF28abdtnhy2+sNvZZ/R7zVZXVWMLhIA6HnNDGAUTqqqMxbNyR9ejAfCwJWKGmJ0RL4i8JlLEJegwmF5ertZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352566; c=relaxed/simple;
	bh=XxF/uLfMlZ2yLq5hGg7dRrUSgT7mdGLmLdaueY/rQ28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXYEYE/e7giAH+McP+ThfRD0NnVPhplMnLrVrnd9VFHS6GlvVcYlufxapcc9RxPupFvPh33dwVCQHlAUbUwUTupsbGbildTpztbF2N5Yp31dHlLxluKO7pqwIoy4WYPl9YtDodxJ1YYpNci/3DM2nCcj0QCdw6l/ebMt2yvdtFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XMts/20K; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PI98lv019981;
	Tue, 25 Jun 2024 17:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=P614n
	NYhT+6MTJmBqLX+tbCDKDy9FlEwSkOz2O8yJkY=; b=XMts/20KgfKtpfD6tla39
	hRS3pyWH/yAvmxu+IIgmEsFOi/c7v4GWFX/gwwoAT/wXsv2FIXF7g4KjOubjsNFj
	6IZGzUI4lfgMRVoe73apyG4tNWd1K/0ZwMSsKtIwt9XBti82+Y7FkxzUltmrjFzv
	Jcf6l1thoV0BcMB/6sKfsf/dCVoTag/57fDxI6q04W8eYX7v3qLMOiDIlrpePZF6
	Scm1FpwvTWDKXRe4sxCrcY17lBycQPtl5WOqF/YyfcAX4JEXP6Y37DEJqr7WZZni
	Rr3ciwVyuEVr9apgr2zwF/TnOU/14uJCaPv/tghcRe9nH8EwaoeDE5dTfVZjxZNe
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ywrf3mpdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:55:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45PLtkLA003598
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 17:55:46 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:55:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:55:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 25 Jun 2024 17:55:45 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45PLtSnc013878;
	Tue, 25 Jun 2024 17:55:31 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 6/7] iio: adc: Add support for AD4000
Date: Tue, 25 Jun 2024 18:55:27 -0300
Message-ID: <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1719351923.git.marcelo.schmitt@analog.com>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: KXxo81UPhCsXJepEG7TsNw01sUPGnEUa
X-Proofpoint-GUID: KXxo81UPhCsXJepEG7TsNw01sUPGnEUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406250163

Add support for AD4000 series of low noise, low power, high speed,
successive approximation register (SAR) ADCs.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  12 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4000.c | 711 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 725 insertions(+)
 create mode 100644 drivers/iio/adc/ad4000.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9aa6531f7cf2..f4ffedada8ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1205,6 +1205,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+F:	drivers/iio/adc/ad4000.c
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b8184706c7d1..5bbe843916a3 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -21,6 +21,18 @@ config AD_SIGMA_DELTA
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 
+config AD4000
+	tristate "Analog Devices AD4000 ADC Driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices AD4000 high speed
+	  SPI analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4000.
+
 config AD4130
 	tristate "Analog Device AD4130 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 51298c52b223..f4361df40cca 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
+obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o
diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
new file mode 100644
index 000000000000..0b6293db68dc
--- /dev/null
+++ b/drivers/iio/adc/ad4000.c
@@ -0,0 +1,711 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD4000 SPI ADC driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/byteorder/generic.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+#include <linux/util_macros.h>
+#include <linux/iio/iio.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define AD4000_READ_COMMAND	0x54
+#define AD4000_WRITE_COMMAND	0x14
+
+#define AD4000_CONFIG_REG_DEFAULT	0xE1
+
+/* AD4000 Configuration Register programmable bits */
+#define AD4000_CFG_STATUS		BIT(4) /* Status bits output */
+#define AD4000_CFG_SPAN_COMP		BIT(3) /* Input span compression  */
+#define AD4000_CFG_HIGHZ		BIT(2) /* High impedance mode  */
+#define AD4000_CFG_TURBO		BIT(1) /* Turbo mode */
+
+#define AD4000_SCALE_OPTIONS		2
+
+#define AD4000_TQUIET1_NS		190
+#define AD4000_TQUIET2_NS		60
+#define AD4000_TCONV_NS			320
+
+#define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)	\
+{										\
+	.type = IIO_VOLTAGE,							\
+	.indexed = 1,								\
+	.differential = 1,							\
+	.channel = 0,								\
+	.channel2 = 1,								\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
+	.scan_type = {								\
+		.sign = _sign,							\
+		.realbits = _real_bits,						\
+		.storagebits = _storage_bits,					\
+		.shift = _storage_bits - _real_bits,				\
+		.endianness = IIO_BE,						\
+	},									\
+}
+
+#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access)			\
+	__AD4000_DIFF_CHANNEL((_sign), (_real_bits),				\
+				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
+
+#define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)\
+{										\
+	.type = IIO_VOLTAGE,							\
+	.indexed = 1,								\
+	.channel = 0,								\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      BIT(IIO_CHAN_INFO_OFFSET),			\
+	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
+	.scan_type = {								\
+		.sign = _sign,							\
+		.realbits = _real_bits,						\
+		.storagebits = _storage_bits,					\
+		.shift = _storage_bits - _real_bits,				\
+		.endianness = IIO_BE,						\
+	},									\
+}
+
+#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access)		\
+	__AD4000_PSEUDO_DIFF_CHANNEL((_sign), (_real_bits),			\
+				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
+
+enum ad4000_sdi {
+	/* datasheet calls this "4-wire mode" (controller CS goes to ADC SDI!) */
+	AD4000_SDI_MOSI,
+	/* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!) */
+	AD4000_SDI_VIO,
+	AD4000_SDI_CS,
+};
+
+/* maps adi,sdi-pin property value to enum */
+static const char * const ad4000_sdi_pin[] = {
+	[AD4000_SDI_MOSI] = "",
+	[AD4000_SDI_VIO] = "high",
+	[AD4000_SDI_CS] = "cs",
+};
+
+struct ad4000_chip_info {
+	const char *dev_name;
+	struct iio_chan_spec chan_spec;
+	struct iio_chan_spec reg_access_chan_spec;
+	bool has_hardware_gain;
+};
+
+static const struct ad4000_chip_info ad4000_chip_info = {
+	.dev_name = "ad4000",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
+};
+
+static const struct ad4000_chip_info ad4001_chip_info = {
+	.dev_name = "ad4001",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1),
+};
+
+static const struct ad4000_chip_info ad4002_chip_info = {
+	.dev_name = "ad4002",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
+};
+
+static const struct ad4000_chip_info ad4003_chip_info = {
+	.dev_name = "ad4003",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
+};
+
+static const struct ad4000_chip_info ad4004_chip_info = {
+	.dev_name = "ad4004",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
+};
+
+static const struct ad4000_chip_info ad4005_chip_info = {
+	.dev_name = "ad4005",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1),
+};
+
+static const struct ad4000_chip_info ad4006_chip_info = {
+	.dev_name = "ad4006",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
+};
+
+static const struct ad4000_chip_info ad4007_chip_info = {
+	.dev_name = "ad4007",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
+};
+
+static const struct ad4000_chip_info ad4008_chip_info = {
+	.dev_name = "ad4008",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
+};
+
+static const struct ad4000_chip_info ad4010_chip_info = {
+	.dev_name = "ad4010",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
+};
+
+static const struct ad4000_chip_info ad4011_chip_info = {
+	.dev_name = "ad4011",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
+};
+
+static const struct ad4000_chip_info ad4020_chip_info = {
+	.dev_name = "ad4020",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1),
+};
+
+static const struct ad4000_chip_info ad4021_chip_info = {
+	.dev_name = "ad4021",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1),
+};
+
+static const struct ad4000_chip_info ad4022_chip_info = {
+	.dev_name = "ad4022",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1),
+};
+
+static const struct ad4000_chip_info adaq4001_chip_info = {
+	.dev_name = "adaq4001",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1),
+	.has_hardware_gain = true,
+};
+
+static const struct ad4000_chip_info adaq4003_chip_info = {
+	.dev_name = "adaq4003",
+	.chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1),
+	.has_hardware_gain = true,
+};
+
+struct ad4000_state {
+	struct spi_device *spi;
+	struct gpio_desc *cnv_gpio;
+	struct spi_transfer xfers[2];
+	struct spi_message msg;
+	struct mutex lock; /* Protect read modify write cycle */
+	int vref_mv;
+	enum ad4000_sdi sdi_pin;
+	bool span_comp;
+	bool turbo_mode;
+	u16 gain_milli;
+	int scale_tbl[AD4000_SCALE_OPTIONS][2];
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the transfer buffers
+	 * to live in their own cache lines.
+	 */
+	struct {
+		union {
+			__be16 sample_buf16;
+			__be32 sample_buf32;
+		} data;
+		s64 timestamp __aligned(8);
+	} scan __aligned(IIO_DMA_MINALIGN);
+	u8 tx_buf[2];
+	u8 rx_buf[2];
+};
+
+static void ad4000_fill_scale_tbl(struct ad4000_state *st,
+				  struct iio_chan_spec const *chan)
+{
+	int val, tmp0, tmp1;
+	int scale_bits;
+	u64 tmp2;
+
+	/*
+	 * ADCs that output two's complement code have one less bit to express
+	 * voltage magnitude.
+	 */
+	if (chan->scan_type.sign == 's')
+		scale_bits = chan->scan_type.realbits - 1;
+	else
+		scale_bits = chan->scan_type.realbits;
+
+	/*
+	 * The gain is stored as a fraction of 1000 and, as we need to
+	 * divide vref_mv by the gain, we invert the gain/1000 fraction.
+	 * Also multiply by an extra MILLI to preserve precision.
+	 * Thus, we have MILLI * MILLI equals MICRO as fraction numerator.
+	 */
+	val = mult_frac(st->vref_mv, MICRO, st->gain_milli);
+	/* Would multiply by NANO here but we multiplied by extra MILLI */
+	tmp2 = shift_right((u64)val * MICRO, scale_bits);
+	tmp0 = div_s64_rem(tmp2, NANO, &tmp1);
+	/* Store scale for when span compression is disabled */
+	st->scale_tbl[0][0] = tmp0; /* Integer part */
+	st->scale_tbl[0][1] = abs(tmp1); /* Fractional part */
+	/* Store scale for when span compression is enabled */
+	st->scale_tbl[1][0] = tmp0;
+	/* The integer part is always zero so don't bother to divide it. */
+	if (chan->differential)
+		st->scale_tbl[1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 4, 5);
+	else
+		st->scale_tbl[1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 9, 10);
+}
+
+static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
+{
+	st->tx_buf[0] = AD4000_WRITE_COMMAND;
+	st->tx_buf[1] = val;
+	return spi_write(st->spi, st->tx_buf, ARRAY_SIZE(st->tx_buf));
+}
+
+static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
+{
+	struct spi_transfer t = {
+		.tx_buf = st->tx_buf,
+		.rx_buf = st->rx_buf,
+		.len = 2,
+	};
+	int ret;
+
+	st->tx_buf[0] = AD4000_READ_COMMAND;
+	ret = spi_sync_transfer(st->spi, &t, 1);
+	if (ret < 0)
+		return ret;
+
+	*val = st->tx_buf[1];
+	return ret;
+}
+
+/*
+ * This executes a data sample transfer for when the device connections are
+ * in "3-wire" mode, selected when the adi,sdi-pin device tree property is
+ * absent or set to "high". In this connection mode, the ADC SDI pin is
+ * connected to MOSI or to VIO and ADC CNV pin is connected either to a SPI
+ * controller CS or to a GPIO.
+ * AD4000 series of devices initiate conversions on the rising edge of CNV pin.
+ *
+ * If the CNV pin is connected to an SPI controller CS line (which is by default
+ * active low), the ADC readings would have a latency (delay) of one read.
+ * Moreover, since we also do ADC sampling for filling the buffer on triggered
+ * buffer mode, the timestamps of buffer readings would be disarranged.
+ * To prevent the read latency and reduce the time discrepancy between the
+ * sample read request and the time of actual sampling by the ADC, do a
+ * preparatory transfer to pulse the CS/CNV line.
+ */
+static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
+					     const struct iio_chan_spec *chan)
+{
+	unsigned int cnv_pulse_time = st->turbo_mode ? AD4000_TQUIET1_NS
+						     : AD4000_TCONV_NS;
+	struct spi_transfer *xfers = st->xfers;
+
+	xfers[0].cs_change = 1;
+	xfers[0].cs_change_delay.value = cnv_pulse_time;
+	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	xfers[1].rx_buf = &st->scan.data;
+	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].delay.value = AD4000_TQUIET2_NS;
+	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
+
+	return devm_spi_optimize_message(st->spi, &st->msg);
+}
+
+/*
+ * This executes a data sample transfer for when the device connections are
+ * in "4-wire" mode, selected when the adi,sdi-pin device tree property is
+ * set to "cs". In this connection mode, the controller CS pin is connected to
+ * ADC SDI pin and a GPIO is connected to ADC CNV pin.
+ * The GPIO connected to ADC CNV pin is set outside of the SPI transfer.
+ */
+static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
+					     const struct iio_chan_spec *chan)
+{
+	unsigned int cnv_to_sdi_time = st->turbo_mode ? AD4000_TQUIET1_NS
+						      : AD4000_TCONV_NS;
+	struct spi_transfer *xfers = st->xfers;
+
+	/*
+	 * Dummy transfer to cause enough delay between CNV going high and SDI
+	 * going low.
+	 */
+	xfers[0].cs_off = 1;
+	xfers[0].delay.value = cnv_to_sdi_time;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	xfers[1].rx_buf = &st->scan.data;
+	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+
+	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
+
+	return devm_spi_optimize_message(st->spi, &st->msg);
+}
+
+static int ad4000_convert_and_acquire(struct ad4000_state *st)
+{
+	int ret;
+
+	/*
+	 * In 4-wire mode, the CNV line is held high for the entire conversion
+	 * and acquisition process. In other modes, the CNV GPIO is optional
+	 * and, if provided, replaces controller CS. If CNV GPIO is not defined
+	 * gpiod_set_value_cansleep() has no effect.
+	 */
+	gpiod_set_value_cansleep(st->cnv_gpio, 1);
+	ret = spi_sync(st->spi, &st->msg);
+	gpiod_set_value_cansleep(st->cnv_gpio, 0);
+
+	return ret;
+}
+
+static int ad4000_single_conversion(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan, int *val)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+	u32 sample;
+	int ret;
+
+	ret = ad4000_convert_and_acquire(st);
+	if (ret < 0)
+		return ret;
+
+	if (chan->scan_type.storagebits > 16)
+		sample = be32_to_cpu(st->scan.data.sample_buf32);
+	else
+		sample = be16_to_cpu(st->scan.data.sample_buf16);
+
+	sample >>= chan->scan_type.shift;
+
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int ad4000_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long info)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return ad4000_single_conversion(indio_dev, chan, val);
+		unreachable();
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->scale_tbl[st->span_comp][0];
+		*val2 = st->scale_tbl[st->span_comp][1];
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 0;
+		if (st->span_comp)
+			*val = mult_frac(st->vref_mv, 1, 10);
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4000_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)st->scale_tbl;
+		*length = AD4000_SCALE_OPTIONS * 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static int ad4000_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+	unsigned int reg_val;
+	bool span_comp_en;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+
+		mutex_lock(&st->lock);
+		ret = ad4000_read_reg(st, &reg_val);
+		if (ret < 0)
+			goto err_unlock;
+
+		span_comp_en = val2 == st->scale_tbl[1][1];
+		reg_val &= ~AD4000_CFG_SPAN_COMP;
+		reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
+
+		ret = ad4000_write_reg(st, reg_val);
+		if (ret < 0)
+			goto err_unlock;
+
+		st->span_comp = span_comp_en;
+err_unlock:
+		iio_device_release_direct_mode(indio_dev);
+		mutex_unlock(&st->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t ad4000_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4000_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4000_convert_and_acquire(st);
+	if (ret < 0)
+		goto err_out;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
+
+err_out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info ad4000_reg_access_info = {
+	.read_raw = &ad4000_read_raw,
+	.read_avail = &ad4000_read_avail,
+	.write_raw = &ad4000_write_raw,
+	.write_raw_get_fmt = &ad4000_write_raw_get_fmt,
+};
+
+static const struct iio_info ad4000_info = {
+	.read_raw = &ad4000_read_raw,
+};
+
+static int ad4000_config(struct ad4000_state *st)
+{
+	unsigned int reg_val = AD4000_CONFIG_REG_DEFAULT;
+
+	if (device_property_present(&st->spi->dev, "adi,high-z-input"))
+		reg_val |= FIELD_PREP(AD4000_CFG_HIGHZ, 1);
+
+	return ad4000_write_reg(st, reg_val);
+}
+
+static int ad4000_probe(struct spi_device *spi)
+{
+	const struct ad4000_chip_info *chip;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad4000_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = spi_get_device_match_data(spi);
+	if (!chip)
+		return -EINVAL;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable VDD supply\n");
+
+	ret = devm_regulator_get_enable(dev, "vio");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable VIO supply\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to get ref regulator reference\n");
+	st->vref_mv = ret / 1000;
+
+	st->cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->cnv_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
+				     "Failed to get CNV GPIO");
+
+	ret = device_property_match_property_string(dev, "adi,sdi-pin",
+						    ad4000_sdi_pin,
+						    ARRAY_SIZE(ad4000_sdi_pin));
+	if (ret < 0 && ret != -EINVAL)
+		return dev_err_probe(dev, ret,
+				     "getting adi,sdi-pin property failed\n");
+
+	/* Default to usual SPI connections if pin properties are not present */
+	st->sdi_pin = ret == -EINVAL ? AD4000_SDI_MOSI : ret;
+	switch (st->sdi_pin) {
+	case AD4000_SDI_MOSI:
+		indio_dev->info = &ad4000_reg_access_info;
+		indio_dev->channels = &chip->reg_access_chan_spec;
+
+		/*
+		 * In "3-wire mode", the ADC SDI line must be kept high when
+		 * data is not being clocked out of the controller.
+		 * Request the SPI controller to make MOSI idle high.
+		 */
+		spi->mode |= SPI_MOSI_IDLE_HIGH;
+		ret = spi_setup(spi);
+		if (ret < 0)
+			return ret;
+
+		ret = ad4000_prepare_3wire_mode_message(st, indio_dev->channels);
+		if (ret)
+			return ret;
+
+		ret = ad4000_config(st);
+		if (ret < 0)
+			dev_warn(dev, "Failed to config device\n");
+
+		break;
+	case AD4000_SDI_VIO:
+		indio_dev->info = &ad4000_info;
+		indio_dev->channels = &chip->chan_spec;
+		ret = ad4000_prepare_3wire_mode_message(st, indio_dev->channels);
+		if (ret)
+			return ret;
+
+		break;
+	case AD4000_SDI_CS:
+		indio_dev->info = &ad4000_info;
+		indio_dev->channels = &chip->chan_spec;
+		ret = ad4000_prepare_4wire_mode_message(st, indio_dev->channels);
+		if (ret)
+			return ret;
+
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Unrecognized connection mode\n");
+	}
+
+	indio_dev->name = chip->dev_name;
+	indio_dev->num_channels = 1;
+
+	devm_mutex_init(dev, &st->lock);
+
+	st->gain_milli = 1000;
+	if (chip->has_hardware_gain) {
+		if (device_property_present(dev, "adi,gain-milli")) {
+			ret = device_property_read_u16(dev, "adi,gain-milli",
+						       &st->gain_milli);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to read gain property\n");
+		}
+	}
+
+	ad4000_fill_scale_tbl(st, indio_dev->channels);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad4000_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id ad4000_id[] = {
+	{ "ad4000", (kernel_ulong_t)&ad4000_chip_info },
+	{ "ad4001", (kernel_ulong_t)&ad4001_chip_info },
+	{ "ad4002", (kernel_ulong_t)&ad4002_chip_info },
+	{ "ad4003", (kernel_ulong_t)&ad4003_chip_info },
+	{ "ad4004", (kernel_ulong_t)&ad4004_chip_info },
+	{ "ad4005", (kernel_ulong_t)&ad4005_chip_info },
+	{ "ad4006", (kernel_ulong_t)&ad4006_chip_info },
+	{ "ad4007", (kernel_ulong_t)&ad4007_chip_info },
+	{ "ad4008", (kernel_ulong_t)&ad4008_chip_info },
+	{ "ad4010", (kernel_ulong_t)&ad4010_chip_info },
+	{ "ad4011", (kernel_ulong_t)&ad4011_chip_info },
+	{ "ad4020", (kernel_ulong_t)&ad4020_chip_info },
+	{ "ad4021", (kernel_ulong_t)&ad4021_chip_info },
+	{ "ad4022", (kernel_ulong_t)&ad4022_chip_info },
+	{ "adaq4001", (kernel_ulong_t)&adaq4001_chip_info },
+	{ "adaq4003", (kernel_ulong_t)&adaq4003_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4000_id);
+
+static const struct of_device_id ad4000_of_match[] = {
+	{ .compatible = "adi,ad4000", .data = &ad4000_chip_info },
+	{ .compatible = "adi,ad4001", .data = &ad4001_chip_info },
+	{ .compatible = "adi,ad4002", .data = &ad4002_chip_info },
+	{ .compatible = "adi,ad4003", .data = &ad4003_chip_info },
+	{ .compatible = "adi,ad4004", .data = &ad4004_chip_info },
+	{ .compatible = "adi,ad4005", .data = &ad4005_chip_info },
+	{ .compatible = "adi,ad4006", .data = &ad4006_chip_info },
+	{ .compatible = "adi,ad4007", .data = &ad4007_chip_info },
+	{ .compatible = "adi,ad4008", .data = &ad4008_chip_info },
+	{ .compatible = "adi,ad4010", .data = &ad4010_chip_info },
+	{ .compatible = "adi,ad4011", .data = &ad4011_chip_info },
+	{ .compatible = "adi,ad4020", .data = &ad4020_chip_info },
+	{ .compatible = "adi,ad4021", .data = &ad4021_chip_info },
+	{ .compatible = "adi,ad4022", .data = &ad4022_chip_info },
+	{ .compatible = "adi,adaq4001", .data = &adaq4001_chip_info },
+	{ .compatible = "adi,adaq4003", .data = &adaq4003_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4000_of_match);
+
+static struct spi_driver ad4000_driver = {
+	.driver = {
+		.name   = "ad4000",
+		.of_match_table = ad4000_of_match,
+	},
+	.probe          = ad4000_probe,
+	.id_table       = ad4000_id,
+};
+module_spi_driver(ad4000_driver);
+
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4000 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


