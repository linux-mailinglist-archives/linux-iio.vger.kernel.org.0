Return-Path: <linux-iio+bounces-16474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C896A54CF3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091411895E5D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBAD1714CF;
	Thu,  6 Mar 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="azOSy4fo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5314A4E9;
	Thu,  6 Mar 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269898; cv=none; b=IiMZ2WNn+4FSoexTxkWzOWqXodeyiNosH5EzfEO8MHS2hXIXvC/fX4keIsvhiTUj2reaXD1NXFdGfc5Ry4SEIlKZ3weZNPGfqx5y58k0WBJeGmqJLkfVlMltwj5F9AAsQ4Qbgw4HLhopIoUO1aywbCUj+ims2wzdNrjz1ztGRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269898; c=relaxed/simple;
	bh=eO0tQGiqbNKYfDURs5/PzezStpe+qbSS/xX0KQMeGQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=puHomRz50hQAngriO1H8jNx82MCmyxvbV82TvcdJsV+7dAEXQtqxq5gf/HwEJhMeVGHgXmzCW79LRfJzlwACHOugjwFsVrGSc9feP8pVtp2Rb6GjCU3gQUe3JS/iInqTnoItdWyPb45jg1KJIRrXCXwGyOzoyoZyj0mXHAul9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=azOSy4fo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526C7tUh004818;
	Thu, 6 Mar 2025 09:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BlIex
	dqR7GRkDDyvwGHsR3DNeKR/3lQysVxxFUnB9Sk=; b=azOSy4foHafVmkmxFoNjX
	CbEEvnCAv8tMqnnsOnjBaJVZy/fhZygd+qM00YFuywl8P+aSQHSetUb5ORwzHIdb
	zV/1X5HaDRn3f/ND1I5TKkGoqOJu7xYSVAiBbMqiegMvATIE8nB/SjRW3J7H0tzR
	n1m/ubn5/vGZmdTf6dLlAwjmDLPKVMv4c3IwoCW1TS2jynAC2FVUG7RfCSBx71G9
	fMJ4QT+Arl4AobDaJ6tLBzM2yD8UrwzLcbsZ6RTsb7I3NoS3n4bRQgll4LlInhOV
	Rl6C0gvNNwvCr/Aus6Y2KgVY/HLlDNC0JVBUH+Y8PullQdO45pnXMsXH0EaSPx39
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4577p69mna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:04:31 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 526E4UWK064967
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 09:04:30 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Mar 2025
 09:04:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 09:04:30 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.71])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526E4CqV024033;
	Thu, 6 Mar 2025 09:04:24 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Thu, 6 Mar 2025 15:03:17 +0100
Subject: [PATCH 4/4] iio: adc: add support for ad4052
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
In-Reply-To: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Lechner
	<dlechner@baylibre.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741269851; l=38244;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=eO0tQGiqbNKYfDURs5/PzezStpe+qbSS/xX0KQMeGQw=;
 b=Z6V030k0LVIJwnWgO/p5g6Mzvku8cglL+WZCA/3vrPlN5WOroPh09/cXBvRTMBsCtnaRb7ZPY
 TMckfvvnUVUDjKuwxEP0NhNAwczEsJQLBNU9EkL6gMxVSgB/2HyQhcT
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: XaDsD7lHL-XoU_NStugHx_F7S2DYJkvi
X-Proofpoint-ORIG-GUID: XaDsD7lHL-XoU_NStugHx_F7S2DYJkvi
X-Authority-Analysis: v=2.4 cv=GNDyEvNK c=1 sm=1 tr=0 ts=67c9ab70 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=Z5te2bzPO5YcmB3IdvwA:9 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060107

The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
successive approximation register (SAR) analog-to-digital converter (ADC)
that enables low-power, high-density data acquisition solutions without
sacrificing precision.
This ADC offers a unique balance of performance and power efficiency,
plus innovative features for seamlessly switching between high-resolution
and low-power modes tailored to the immediate needs of the system.
The AD4052/AD4058/AD4050/AD4056 are ideal for battery-powered,
compact data acquisition and edge sensing applications.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 MAINTAINERS              |    1 +
 drivers/iio/adc/Kconfig  |   14 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad4052.c | 1289 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1305 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 312b2cf94b8f06298b1cbe5975ee32e2cf9a74d8..275e2bace4731d37a3ef8eab173d11514e482e72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1323,6 +1323,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
 F:	Documentation/iio/ad4052.rst
+F:	drivers/iio/adc/ad4052.c
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 27413516216cb3f83cf1d995b9ffc22bf01776a4..f518dadbdd3a6b0543d0b78206fcbc203898454c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -62,6 +62,20 @@ config AD4130
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4130.
 
+config AD4052
+	tristate "Analog Devices AD4052 Driver"
+	depends on SPI
+	select SPI_OFFLOAD
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD4052 SPI analog
+	  to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4052.
+
 config AD4695
 	tristate "Analog Device AD4695 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9f26d5eca8225e28f308b3db437e25eb45b41a3c..412e35dfeb9be244c47e384d3abb67cef943a0f0 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4030) += ad4030.o
 obj-$(CONFIG_AD4130) += ad4130.o
+obj-$(CONFIG_AD4052) += ad4052.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD4851) += ad4851.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
new file mode 100644
index 0000000000000000000000000000000000000000..29452963fb15ab1b11e3a2fc59c34a2579f25910
--- /dev/null
+++ b/drivers/iio/adc/ad4052.c
@@ -0,0 +1,1289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD4052 SPI ADC driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+
+#define AD4052_REG_INTERFACE_CONFIG_A	0x00
+#define AD4052_REG_DEVICE_CONFIG	0x02
+#define AD4052_REG_PROD_ID_1		0x05
+#define AD4052_REG_DEVICE_GRADE		0x06
+#define AD4052_REG_SCRATCH_PAD		0x0A
+#define AD4052_REG_VENDOR_H		0x0D
+#define AD4052_REG_STREAM_MODE		0x0E
+#define AD4052_REG_INTERFACE_STATUS	0x11
+#define AD4052_REG_MODE_SET		0x20
+#define AD4052_REG_ADC_MODES		0x21
+#define AD4052_REG_AVG_CONFIG		0x23
+#define AD4052_REG_GP_CONFIG		0x24
+#define AD4052_REG_INTR_CONFIG		0x25
+#define AD4052_REG_TIMER_CONFIG		0x27
+#define AD4052_REG_MAX_LIMIT		0x29
+#define AD4052_REG_MIN_LIMIT		0x2B
+#define AD4052_REG_MAX_HYST		0x2C
+#define AD4052_REG_MIN_HYST		0x2D
+#define AD4052_REG_MON_VAL		0x2F
+#define AD4052_REG_FUSE_CRC		0x40
+#define AD4052_REG_DEVICE_STATUS	0x41
+#define AD4052_REG_MIN_SAMPLE		0x45
+#define AD4052_MAX_REG			0x45
+/* GP_CONFIG */
+#define AD4052_GP_MODE_MSK(x)		(GENMASK(2, 0) << (x) * 4)
+/* INTR_CONFIG */
+#define AD4052_INTR_EN_MSK(x)		(GENMASK(1, 0) << (x) * 4)
+/* ADC_MODES */
+#define AD4052_DATA_FORMAT		BIT(7)
+/* DEVICE_CONFIG */
+#define AD4052_POWER_MODE_MSK		GENMASK(1, 0)
+#define AD4052_LOW_POWER_MODE		3
+/* DEVICE_STATUS */
+#define AD4052_DEVICE_RESET		BIT(6)
+#define AD4052_THRESH_OVERRUN		BIT(4)
+#define AD4052_MAX_FLAG			BIT(3)
+#define AD4052_MIN_FLAG			BIT(2)
+#define AD4052_EVENT_CLEAR		(AD4052_THRESH_OVERRUN | AD4052_MAX_FLAG | AD4052_MIN_FLAG)
+/* TIMER_CONFIG */
+#define AD4052_FS_MASK			GENMASK(7, 4)
+#define AD4052_300KSPS			0x2
+
+#define AD4052_SPI_VENDOR		0x0456
+
+#define AD4050_MAX_AVG			0x7
+#define AD4052_MAX_AVG			0xB
+#define AD4052_CHECK_OVERSAMPLING(x, y)	({typeof(y) y_ = (y); \
+					  ((y_) < 0 || (y_) > BIT((x) + 1)); })
+#define AD4052_MAX_RATE(x)		((x) == AD4052_500KSPS ? 500000 : 2000000)
+#define AD4052_CHECK_RATE(x, y)		({typeof(y) y_ = (y);				\
+					  ((y_) > AD4052_MAX_RATE(x) || (y_) <= 0); })
+#define AD4052_FS_OFFSET(g)		((g) == AD4052_500KSPS ? 2 : 0)
+#define AD4052_FS(g)			(&ad4052_sample_rates[AD4052_FS_OFFSET(g)])
+#define AD4052_FS_LEN(g)		(ARRAY_SIZE(ad4052_sample_rates) - (AD4052_FS_OFFSET(g)))
+
+enum ad4052_grade {
+	AD4052_2MSPS,
+	AD4052_500KSPS,
+};
+
+enum ad4052_operation_mode {
+	AD4052_SAMPLE_MODE = 0,
+	AD4052_BURST_AVERAGING_MODE = 1,
+	AD4052_MONITOR_MODE = 3,
+};
+
+enum ad4052_gp_mode {
+	AD4052_GP_DISABLED,
+	AD4052_GP_INTR,
+	AD4052_GP_DRDY,
+};
+
+enum ad4052_interrupt_en {
+	AD4052_INTR_EN_NEITHER,
+	AD4052_INTR_EN_MIN,
+	AD4052_INTR_EN_MAX,
+	AD4052_INTR_EN_EITHER,
+};
+
+struct ad4052_chip_info {
+	const struct iio_chan_spec channels[1];
+	const struct iio_chan_spec offload_channels[1];
+	const char *name;
+	u16 prod_id;
+	u8 max_avg;
+	u8 grade;
+};
+
+enum {
+	AD4052_SCAN_TYPE_SAMPLE,
+	AD4052_SCAN_TYPE_BURST_AVG,
+	AD4052_SCAN_TYPE_OFFLOAD_SAMPLE,
+	AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG,
+};
+
+static const struct iio_scan_type ad4052_scan_type_12_s[] = {
+	[AD4052_SCAN_TYPE_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_OFFLOAD_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+};
+
+static const struct iio_scan_type ad4052_scan_type_16_s[] = {
+	[AD4052_SCAN_TYPE_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_OFFLOAD_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+};
+
+struct ad4052_state {
+	const struct ad4052_bus_ops *ops;
+	const struct ad4052_chip_info *chip;
+	enum ad4052_operation_mode mode;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	unsigned long offload_trigger_hz;
+	struct spi_device *spi;
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
+	struct spi_transfer xfer;
+	struct spi_message msg;
+	struct gpio_desc *cnv_gp;
+	struct completion completion;
+	struct regmap *regmap;
+	bool wait_event;
+	int gp1_irq;
+	u8 data_format;
+	union {
+		__be16 d16;
+		__be32 d32;
+	} __aligned(IIO_DMA_MINALIGN);
+	u8 buf_reset_pattern[18];
+};
+
+static const struct regmap_range ad4052_regmap_rd_ranges[] = {
+	regmap_reg_range(AD4052_REG_INTERFACE_CONFIG_A, AD4052_REG_DEVICE_GRADE),
+	regmap_reg_range(AD4052_REG_SCRATCH_PAD, AD4052_REG_INTERFACE_STATUS),
+	regmap_reg_range(AD4052_REG_MODE_SET, AD4052_REG_MON_VAL),
+	regmap_reg_range(AD4052_REG_FUSE_CRC, AD4052_REG_MIN_SAMPLE),
+};
+
+static const struct regmap_access_table ad4052_regmap_rd_table = {
+	.yes_ranges = ad4052_regmap_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad4052_regmap_rd_ranges),
+};
+
+static const struct regmap_range ad4052_regmap_wr_ranges[] = {
+	regmap_reg_range(AD4052_REG_INTERFACE_CONFIG_A, AD4052_REG_DEVICE_CONFIG),
+	regmap_reg_range(AD4052_REG_SCRATCH_PAD, AD4052_REG_SCRATCH_PAD),
+	regmap_reg_range(AD4052_REG_STREAM_MODE, AD4052_REG_INTERFACE_STATUS),
+	regmap_reg_range(AD4052_REG_MODE_SET, AD4052_REG_MON_VAL),
+	regmap_reg_range(AD4052_REG_FUSE_CRC, AD4052_REG_DEVICE_STATUS),
+};
+
+static const struct regmap_access_table ad4052_regmap_wr_table = {
+	.yes_ranges = ad4052_regmap_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad4052_regmap_wr_ranges),
+};
+
+static const struct iio_event_spec ad4052_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE)
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS)
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS)
+	}
+};
+
+static const int ad4052_sample_rate_avail[] = {
+	2000000, 1000000, 300000, 100000, 33300,
+	10000, 3000, 500, 333, 250, 200,
+	166, 140, 125, 111
+};
+
+static const char *const ad4052_sample_rates[] = {
+	"2000000", "1000000", "300000", "100000", "33300",
+	"10000", "3000", "500", "333", "250", "200",
+	"166", "140", "124", "111",
+};
+
+static int ad4052_iio_device_claim_direct(struct iio_dev *indio_dev,
+					  struct ad4052_state *st)
+{
+	if (!iio_device_claim_direct(indio_dev))
+		return false;
+
+	/**
+	 * If the device is in monitor mode, no register access is allowed,
+	 * since it would put the device back in configuration mode.
+	 */
+	if (st->wait_event) {
+		iio_device_release_direct(indio_dev);
+		return false;
+	}
+	return true;
+}
+
+static int ad4052_sample_rate_get(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret, val;
+
+	if (!ad4052_iio_device_claim_direct(indio_dev, st))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD4052_REG_TIMER_CONFIG, &val);
+	val = FIELD_GET(AD4052_FS_MASK, val);
+
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : val - AD4052_FS_OFFSET(st->chip->grade);
+}
+
+static int ad4052_sample_rate_set(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int val)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!ad4052_iio_device_claim_direct(indio_dev, st))
+		return -EBUSY;
+
+	val += AD4052_FS_OFFSET(st->chip->grade);
+	val = FIELD_PREP(AD4052_FS_MASK, val);
+	ret = regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG, val);
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static const struct iio_enum AD4052_500KSPS_sample_rate_enum = {
+	.items = AD4052_FS(AD4052_500KSPS),
+	.num_items = AD4052_FS_LEN(AD4052_500KSPS),
+	.set = ad4052_sample_rate_set,
+	.get = ad4052_sample_rate_get,
+};
+
+static const struct iio_enum AD4052_2MSPS_sample_rate_enum = {
+	.items = AD4052_FS(AD4052_2MSPS),
+	.num_items = AD4052_FS_LEN(AD4052_2MSPS),
+	.set = ad4052_sample_rate_set,
+	.get = ad4052_sample_rate_get,
+};
+
+#define AD4052_EXT_INFO(grade)								\
+static struct iio_chan_spec_ext_info grade##_ext_info[] = {				\
+	IIO_ENUM("sample_rate", IIO_SHARED_BY_ALL, &grade##_sample_rate_enum),		\
+	IIO_ENUM_AVAILABLE("sample_rate", IIO_SHARED_BY_ALL, &grade##_sample_rate_enum),\
+	{}										\
+}
+
+AD4052_EXT_INFO(AD4052_2MSPS);
+AD4052_EXT_INFO(AD4052_500KSPS);
+
+#define AD4052_CHAN(bits, grade) {							\
+	.type = IIO_VOLTAGE,								\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
+				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.info_mask_shared_by_type_available =  BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+	.indexed = 1,									\
+	.channel = 0,									\
+	.event_spec = ad4052_events,							\
+	.num_event_specs = ARRAY_SIZE(ad4052_events),					\
+	.has_ext_scan_type = 1,								\
+	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
+	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
+	.ext_info = grade##_ext_info,							\
+}
+
+#define AD4052_OFFLOAD_CHAN(bits, grade) {						\
+	.type = IIO_VOLTAGE,								\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
+				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available =  BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+	.indexed = 1,									\
+	.channel = 0,									\
+	.event_spec = ad4052_events,							\
+	.num_event_specs = ARRAY_SIZE(ad4052_events),					\
+	.has_ext_scan_type = 1,								\
+	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
+	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
+	.ext_info = grade##_ext_info,							\
+}
+
+const struct ad4052_chip_info ad4050_chip_info = {
+	.name = "ad4050",
+	.channels = { AD4052_CHAN(12, AD4052_2MSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(12, AD4052_2MSPS) },
+	.prod_id = 0x70,
+	.max_avg = AD4050_MAX_AVG,
+	.grade = AD4052_2MSPS,
+};
+
+const struct ad4052_chip_info ad4052_chip_info = {
+	.name = "ad4052",
+	.channels = { AD4052_CHAN(16, AD4052_2MSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(16, AD4052_2MSPS) },
+	.prod_id = 0x72,
+	.max_avg = AD4052_MAX_AVG,
+	.grade = AD4052_2MSPS,
+};
+
+const struct ad4052_chip_info ad4056_chip_info = {
+	.name = "ad4056",
+	.channels = { AD4052_CHAN(12, AD4052_500KSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(12, AD4052_500KSPS) },
+	.prod_id = 0x70,
+	.max_avg = AD4050_MAX_AVG,
+	.grade = AD4052_500KSPS,
+};
+
+const struct ad4052_chip_info ad4058_chip_info = {
+	.name = "ad4058",
+	.channels = { AD4052_CHAN(16, AD4052_500KSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(16, AD4052_500KSPS) },
+	.prod_id = 0x72,
+	.max_avg = AD4052_MAX_AVG,
+	.grade = AD4052_500KSPS,
+};
+
+static void ad4052_update_xfer_raw(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	struct spi_transfer *xfer = &st->xfer;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+
+	xfer->bits_per_word = scan_type->realbits;
+	xfer->len = BITS_TO_BYTES(scan_type->storagebits);
+}
+
+static int ad4052_update_xfer_offload(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	struct spi_transfer *xfer = &st->xfer;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+
+	xfer = &st->offload_xfer;
+	xfer->bits_per_word = scan_type->realbits;
+	xfer->len = BITS_TO_BYTES(scan_type->storagebits);
+
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return spi_optimize_message(st->spi, &st->offload_msg);
+}
+
+static int ad4052_set_oversampling_ratio(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 unsigned int val)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (AD4052_CHECK_OVERSAMPLING(st->chip->max_avg, val))
+		return -EINVAL;
+
+	/* 0 or 1 disables oversampling */
+	if (val == 0 || val == 1) {
+		st->mode = AD4052_SAMPLE_MODE;
+	} else {
+		val = ilog2(val);
+		st->mode = AD4052_BURST_AVERAGING_MODE;
+		ret = regmap_write(st->regmap, AD4052_REG_AVG_CONFIG, val - 1);
+		if (ret)
+			return ret;
+	}
+
+	ad4052_update_xfer_raw(indio_dev, chan);
+
+	return 0;
+}
+
+static int ad4052_get_oversampling_ratio(struct ad4052_state *st,
+					 unsigned int *val)
+{
+	int ret;
+
+	if (st->mode == AD4052_SAMPLE_MODE) {
+		*val = 0;
+		return 0;
+	}
+
+	ret = regmap_read(st->regmap, AD4052_REG_AVG_CONFIG, val);
+	if (ret)
+		return ret;
+
+	*val = BIT(*val + 1);
+
+	return 0;
+}
+
+static int ad4052_assert(struct ad4052_state *st)
+{
+	int ret;
+	u16 val;
+
+	ret = regmap_bulk_read(st->regmap, AD4052_REG_PROD_ID_1, &st->d16, 2);
+	if (ret)
+		return ret;
+
+	val = be16_to_cpu(st->d16);
+	if (val != st->chip->prod_id)
+		return -ENODEV;
+
+	ret = regmap_bulk_read(st->regmap, AD4052_REG_VENDOR_H, &st->d16, 2);
+	if (ret)
+		return ret;
+
+	val = be16_to_cpu(st->d16);
+	if (val != AD4052_SPI_VENDOR)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int ad4052_exit_command(struct ad4052_state *st)
+{
+	struct spi_device *spi = st->spi;
+	const u8 val = 0xA8;
+
+	return spi_write(spi, &val, 1);
+}
+
+static int ad4052_set_operation_mode(struct ad4052_state *st, enum ad4052_operation_mode mode)
+{
+	u8 val = st->data_format | mode;
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4052_REG_ADC_MODES, val);
+	if (ret)
+		return ret;
+
+	val = BIT(0);
+	return regmap_write(st->regmap, AD4052_REG_MODE_SET, val);
+}
+
+static int __ad4052_set_sampling_freq(struct ad4052_state *st, unsigned int freq)
+{
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = freq,
+		},
+	};
+	int ret;
+
+	ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+	if (ret)
+		return ret;
+
+	st->offload_trigger_hz = config.periodic.frequency_hz;
+
+	return 0;
+}
+
+static int ad4052_soft_reset(struct ad4052_state *st)
+{
+	int ret;
+
+	memset(st->buf_reset_pattern, 0xFF, sizeof(st->buf_reset_pattern));
+	for (int i = 0; i < 3; i++)
+		st->buf_reset_pattern[6 * (i + 1) - 1] = 0xFE;
+
+	ret = spi_write(st->spi, st->buf_reset_pattern,
+			sizeof(st->buf_reset_pattern));
+	if (ret)
+		return ret;
+
+	/* Wait AD4052 reset delay */
+	fsleep(5000);
+
+	return 0;
+}
+
+static int ad4052_set_non_defaults(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+
+	u8 val = FIELD_PREP(AD4052_GP_MODE_MSK(0), AD4052_GP_INTR) |
+		 FIELD_PREP(AD4052_GP_MODE_MSK(1), AD4052_GP_DRDY);
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, AD4052_REG_GP_CONFIG,
+				 AD4052_GP_MODE_MSK(1) | AD4052_GP_MODE_MSK(0),
+				 val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(AD4052_INTR_EN_MSK(0), (AD4052_INTR_EN_EITHER)) |
+	      FIELD_PREP(AD4052_INTR_EN_MSK(1), (AD4052_INTR_EN_NEITHER));
+
+	ret = regmap_update_bits(st->regmap, AD4052_REG_INTR_CONFIG,
+				 AD4052_INTR_EN_MSK(0) | AD4052_INTR_EN_MSK(1),
+				 val);
+	if (ret)
+		return ret;
+
+	val = 0;
+	if (scan_type->sign == 's')
+		val |= AD4052_DATA_FORMAT;
+
+	st->data_format = val;
+
+	if (st->chip->grade == AD4052_500KSPS) {
+		ret = regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG,
+				   FIELD_PREP(AD4052_FS_MASK, AD4052_300KSPS));
+		if (ret)
+			return ret;
+	}
+
+	return regmap_write(st->regmap, AD4052_REG_ADC_MODES, val);
+}
+
+static irqreturn_t ad4052_irq_handler_thresh(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+
+	iio_push_event(indio_dev,
+		       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_EITHER),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ad4052_irq_handler_drdy(int irq, void *private)
+{
+	struct ad4052_state *st = private;
+
+	complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int ad4052_request_irq(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	int ret = 0;
+
+	ret = fwnode_irq_get(dev_fwnode(&st->spi->dev), 0);
+	if (ret <= 0)
+		return ret ? ret : -EINVAL;
+
+	ret = devm_request_threaded_irq(dev,
+					ret, NULL, ad4052_irq_handler_thresh,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = fwnode_irq_get(dev_fwnode(&st->spi->dev), 1);
+	if (ret <= 0)
+		return ret ? ret : -EINVAL;
+
+	st->gp1_irq = ret;
+	ret = devm_request_threaded_irq(dev,
+					ret, NULL, ad4052_irq_handler_drdy,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					indio_dev->name, st);
+	return ret;
+}
+
+static const int ad4052_oversampling_avail[] = {
+	0, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096
+};
+
+static int ad4052_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, const int **vals,
+			     int *type, int *len, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4052_oversampling_avail;
+		*len = ARRAY_SIZE(ad4052_oversampling_avail);
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ad4052_set_sampling_freq(struct ad4052_state *st, unsigned int val)
+{
+	int ret;
+
+	if (AD4052_CHECK_RATE(st->chip->grade, val))
+		return -EINVAL;
+
+	ret = __ad4052_set_sampling_freq(st, val);
+
+	return ret;
+}
+
+static int __ad4052_read_chan_raw(struct ad4052_state *st, int *val)
+{
+	struct spi_device *spi = st->spi;
+	int ret;
+	struct spi_transfer t_cnv = {
+		.len = 0
+	};
+
+	reinit_completion(&st->completion);
+
+	if (st->cnv_gp) {
+		gpiod_set_value_cansleep(st->cnv_gp, 1);
+		gpiod_set_value_cansleep(st->cnv_gp, 0);
+	} else {
+		ret = spi_sync_transfer(spi, &t_cnv, 1);
+		if (ret)
+			return ret;
+	}
+	/*
+	 * Single sample read should be used only for oversampling and
+	 * sampling frequency pairs that take less than 1 sec.
+	 */
+	ret = wait_for_completion_timeout(&st->completion,
+					  msecs_to_jiffies(1000));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	ret = spi_sync_transfer(spi, &st->xfer, 1);
+	if (ret)
+		return ret;
+
+	if (st->xfer.len == 2) {
+		*val = st->d16;
+		if (st->data_format & AD4052_DATA_FORMAT)
+			*val = sign_extend32(*val, 15);
+	} else {
+		*val = st->d32;
+		if (st->data_format & AD4052_DATA_FORMAT)
+			*val = sign_extend32(*val, 23);
+	}
+
+	return ret;
+}
+
+static int ad4052_read_chan_raw(struct iio_dev *indio_dev, int *val)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&st->spi->dev);
+	if (ret)
+		return ret;
+
+	ret = ad4052_set_operation_mode(st, st->mode);
+	if (ret)
+		goto out_error;
+
+	ret = __ad4052_read_chan_raw(st, val);
+	if (ret)
+		goto out_error;
+
+	ret = ad4052_exit_command(st);
+
+out_error:
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+	return ret;
+}
+
+static int ad4052_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!ad4052_iio_device_claim_direct(indio_dev, st))
+		return -EBUSY;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ad4052_read_chan_raw(indio_dev, val);
+		if (ret)
+			goto out_release;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = ad4052_get_oversampling_ratio(st, val);
+		if (ret)
+			goto out_release;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->offload_trigger_hz;
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long info)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!ad4052_iio_device_claim_direct(indio_dev, st))
+		return -EBUSY;
+
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = ad4052_set_oversampling_ratio(indio_dev, chan, val);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ad4052_set_sampling_freq(st, val);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret, state;
+
+	if (!ad4052_iio_device_claim_direct(indio_dev, st))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD4052_REG_GP_CONFIG, &state);
+
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : state & AD4052_GP_MODE_MSK(0);
+}
+
+static int ad4052_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     bool state)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret = -EBUSY;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event == state)
+		goto out_release;
+
+	if (state) {
+		ret = pm_runtime_resume_and_get(&st->spi->dev);
+		if (ret)
+			goto out_release;
+
+		ret = ad4052_set_operation_mode(st, AD4052_MONITOR_MODE);
+		if (ret)
+			goto out_err_suspend;
+	} else {
+		pm_runtime_mark_last_busy(&st->spi->dev);
+		pm_runtime_put_autosuspend(&st->spi->dev);
+
+		ret = ad4052_exit_command(st);
+	}
+	st->wait_event = state;
+	iio_device_release_direct(indio_dev);
+	return ret;
+
+out_err_suspend:
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info, int *val,
+				   int *val2)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	u8 reg, size = 1;
+	int ret;
+
+	if (!ad4052_iio_device_claim_direct(indio_dev, st))
+		return -EBUSY;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (dir == IIO_EV_DIR_RISING)
+			reg = AD4052_REG_MAX_LIMIT;
+		else
+			reg = AD4052_REG_MIN_LIMIT;
+		size++;
+		break;
+	case IIO_EV_INFO_HYSTERESIS:
+		if (dir == IIO_EV_DIR_RISING)
+			reg = AD4052_REG_MAX_HYST;
+		else
+			reg = AD4052_REG_MIN_HYST;
+		break;
+	default:
+		iio_device_release_direct(indio_dev);
+		return -EINVAL;
+	}
+
+	ret = regmap_bulk_read(st->regmap, reg, &st->d32, size);
+	if (ret) {
+		iio_device_release_direct(indio_dev);
+		return ret;
+	}
+
+	if (reg == AD4052_REG_MAX_LIMIT || reg == AD4052_REG_MIN_LIMIT) {
+		*val = be16_to_cpu(st->d16);
+		if (st->data_format & AD4052_DATA_FORMAT)
+			*val = sign_extend32(*val, 11);
+	} else {
+		*val = st->d32;
+	}
+
+	iio_device_release_direct(indio_dev);
+	return IIO_VAL_INT;
+}
+
+static int ad4052_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int val,
+				    int val2)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret = -EINVAL;
+	u8 reg, size = 1;
+
+	if (!ad4052_iio_device_claim_direct(indio_dev, st))
+		return -EBUSY;
+
+	st->d16 = cpu_to_be16(val);
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			if (st->data_format & AD4052_DATA_FORMAT) {
+				if (val > 2047 || val < -2048)
+					goto out_release;
+			} else if (val > 4095 || val < 0) {
+				goto out_release;
+			}
+			if (dir == IIO_EV_DIR_RISING)
+				reg = AD4052_REG_MAX_LIMIT;
+			else
+				reg = AD4052_REG_MIN_LIMIT;
+			size++;
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			if (val & BIT(7))
+				goto out_release;
+			if (dir == IIO_EV_DIR_RISING)
+				reg = AD4052_REG_MAX_HYST;
+			else
+				reg = AD4052_REG_MIN_HYST;
+			st->d16 >>= 8;
+			break;
+		default:
+			goto out_release;
+		}
+		break;
+	default:
+		goto out_release;
+	}
+
+	ret = regmap_bulk_write(st->regmap, reg, &st->d16, size);
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = st->offload_trigger_hz,
+		},
+	};
+	int ret;
+
+	if (st->wait_event)
+		return -EBUSY;
+
+	ret = pm_runtime_resume_and_get(&st->spi->dev);
+	if (ret)
+		return ret;
+
+	ret = ad4052_set_operation_mode(st, st->mode);
+	if (ret)
+		goto out_error;
+
+	ret = ad4052_update_xfer_offload(indio_dev, indio_dev->channels);
+	if (ret)
+		goto out_error;
+
+	disable_irq(st->gp1_irq);
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &config);
+	if (ret)
+		goto out_offload_error;
+
+	return 0;
+
+out_offload_error:
+	enable_irq(st->gp1_irq);
+out_error:
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+
+	return ret;
+}
+
+static int ad4052_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	spi_unoptimize_message(&st->offload_msg);
+	enable_irq(st->gp1_irq);
+
+	ret = ad4052_exit_command(st);
+
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4052_buffer_setup_ops = {
+	.preenable = &ad4052_buffer_preenable,
+	.postdisable = &ad4052_buffer_postdisable,
+};
+
+static int ad4052_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				     unsigned int writeval, unsigned int *readval)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!ad4052_iio_device_claim_direct(indio_dev, st))
+		return -EBUSY;
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+
+	/*
+	 * REVISIT: the supported offload has a fixed length of 32-bits
+	 * to fit the 24-bits oversampled case, requiring the additional
+	 * offload scan types.
+	 */
+	if (iio_buffer_enabled(indio_dev))
+		return st->mode == AD4052_BURST_AVERAGING_MODE ?
+				   AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG :
+				   AD4052_SCAN_TYPE_OFFLOAD_SAMPLE;
+
+	return st->mode == AD4052_BURST_AVERAGING_MODE ?
+			   AD4052_SCAN_TYPE_BURST_AVG :
+			   AD4052_SCAN_TYPE_SAMPLE;
+}
+
+static const struct iio_info ad4052_info = {
+	.read_raw = ad4052_read_raw,
+	.write_raw = ad4052_write_raw,
+	.read_avail = ad4052_read_avail,
+	.read_event_config = &ad4052_read_event_config,
+	.write_event_config = &ad4052_write_event_config,
+	.read_event_value = &ad4052_read_event_value,
+	.write_event_value = &ad4052_write_event_value,
+	.get_current_scan_type = &ad4052_get_current_scan_type,
+	.debugfs_reg_access = &ad4052_debugfs_reg_access,
+};
+
+static const struct regmap_config ad4052_regmap_config = {
+	.name = "ad4052",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AD4052_MAX_REG,
+	.read_flag_mask = BIT(7),
+	.can_sleep = true,
+};
+
+static const struct spi_offload_config ad4052_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+static int ad4052_request_offload(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	struct dma_chan *rx_dma;
+	int ret;
+
+	indio_dev->setup_ops = &ad4052_buffer_setup_ops;
+
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	st->offload_trigger = devm_spi_offload_trigger_get(dev,
+							   st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+
+	if (IS_ERR(st->offload_trigger))
+		return PTR_ERR(st->offload_trigger);
+
+	ret = __ad4052_set_sampling_freq(st, AD4052_MAX_RATE(st->chip->grade));
+	if (ret)
+		return ret;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev,
+							     st->offload);
+	if (IS_ERR(rx_dma))
+		return PTR_ERR(rx_dma);
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
+static int ad4052_probe(struct spi_device *spi)
+{
+	const struct ad4052_chip_info *chip;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad4052_state *st;
+	int ret;
+	u8 buf;
+
+	chip = spi_get_device_match_data(spi);
+	if (!chip)
+		return dev_err_probe(dev, -ENODEV,
+				     "Could not find chip info data\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	spi_set_drvdata(spi, st);
+	init_completion(&st->completion);
+
+	st->regmap = devm_regmap_init_spi(spi, &ad4052_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev,  PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
+
+	st->mode = AD4052_SAMPLE_MODE;
+	st->wait_event = false;
+	st->chip = chip;
+
+	st->cnv_gp = devm_gpiod_get_optional(dev, "cnv",
+					     GPIOD_OUT_LOW);
+	if (IS_ERR(st->cnv_gp))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_gp),
+				    "Failed to get cnv gpio\n");
+
+	indio_dev->modes = INDIO_BUFFER_HARDWARE | INDIO_DIRECT_MODE;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ad4052_info;
+	indio_dev->name = chip->name;
+
+	st->offload = devm_spi_offload_get(dev, spi, &ad4052_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get offload\n");
+
+	if (ret == -ENODEV) {
+		st->offload_trigger = NULL;
+		indio_dev->channels = chip->channels;
+	} else {
+		indio_dev->channels = chip->offload_channels;
+		ret = ad4052_request_offload(indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to configure offload\n");
+	}
+
+	st->xfer.rx_buf = &st->d32;
+
+	ret = ad4052_soft_reset(st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "AD4052 failed to soft reset\n");
+
+	ret = ad4052_assert(st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "AD4052 fields assertions failed\n");
+
+	ret = ad4052_set_non_defaults(indio_dev, indio_dev->channels);
+	if (ret)
+		return ret;
+
+	buf = AD4052_DEVICE_RESET;
+	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS, buf);
+	if (ret)
+		return ret;
+
+	ret = ad4052_request_irq(indio_dev);
+	if (ret)
+		return ret;
+
+	ad4052_update_xfer_raw(indio_dev, indio_dev->channels);
+
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable pm_runtime\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int ad4052_runtime_suspend(struct device *dev)
+{
+	u8 val = FIELD_PREP(AD4052_POWER_MODE_MSK, AD4052_LOW_POWER_MODE);
+	struct ad4052_state *st = dev_get_drvdata(dev);
+
+	return regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG, val);
+}
+
+static int ad4052_runtime_resume(struct device *dev)
+{
+	struct ad4052_state *st = dev_get_drvdata(dev);
+	u8 val = FIELD_PREP(AD4052_POWER_MODE_MSK, 0);
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG, val);
+	if (ret)
+		return ret;
+
+	fsleep(2000);
+	return 0;
+}
+
+static const struct dev_pm_ops ad4052_pm_ops = {
+	RUNTIME_PM_OPS(ad4052_runtime_suspend, ad4052_runtime_resume, NULL)
+};
+
+static const struct spi_device_id ad4052_id_table[] = {
+	{"ad4050", (kernel_ulong_t)&ad4050_chip_info },
+	{"ad4052", (kernel_ulong_t)&ad4052_chip_info },
+	{"ad4056", (kernel_ulong_t)&ad4056_chip_info },
+	{"ad4058", (kernel_ulong_t)&ad4058_chip_info },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad4052_id_table);
+
+static const struct of_device_id ad4052_of_match[] = {
+	{ .compatible = "adi,ad4050", .data = &ad4050_chip_info },
+	{ .compatible = "adi,ad4052", .data = &ad4052_chip_info },
+	{ .compatible = "adi,ad4056", .data = &ad4056_chip_info },
+	{ .compatible = "adi,ad4058", .data = &ad4058_chip_info },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad4052_of_match);
+
+static struct spi_driver ad4052_driver = {
+	.driver = {
+		.name = "ad4052",
+		.of_match_table = ad4052_of_match,
+		.pm = pm_ptr(&ad4052_pm_ops),
+	},
+	.probe = ad4052_probe,
+	.id_table = ad4052_id_table,
+};
+module_spi_driver(ad4052_driver);
+
+MODULE_AUTHOR("Jorge Marques <jorge.marques@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4052");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.48.1


