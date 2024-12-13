Return-Path: <linux-iio+bounces-13428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4159F12AD
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 17:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3B2188D790
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE8B1F1905;
	Fri, 13 Dec 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OK4NorgA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D31F0E3B;
	Fri, 13 Dec 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108324; cv=none; b=DmyyQEGwhYo5UpeC6l6nDJbBFyX32L2M52hK/3gkC5Lj3Xm/qx1q9zIyKJxjQhNXh/Y9XVF3G2sTRj6dCZpXa3m4hLRpF5yuBAM2NsJ4y2U121WMomzEoLsMZUta7V9P5K2DceHAbo9yKmD5xdfxOMUMGoOKtxelUFR8R27RxfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108324; c=relaxed/simple;
	bh=/rsvtlbgDr3s9t95f6wCMbzRMF3v9EolEmCt9E4Yk3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfTwpRt3ZYre5aTtZtmkntSS4a9i1la8zR7BsdfhIoALkRxlUEITaNFIFUpqpnmJMddgkDwCmsw+flMuuxG4lNZ1iw0h68zhoeIXaQBi5qOFqjKFyWLI9Lm5H5MGOdM5NDwDXiE8eK9+wVtjZBZ40hZNmfpOtwFkIQZQ9JjNJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OK4NorgA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEpigO023598;
	Fri, 13 Dec 2024 11:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hIFIB
	o/8x0P7V9hicTsmoTzNFMfVSARNrxQnVc0mz6A=; b=OK4NorgAKUGnQA2+T8Z9+
	SjwgV0k628fbXg6E+ZsnV4kSkkFgSxSIEGQ+/lnxqAse5z80sIR3JcVofC/pPYDQ
	41LWvR9dLpA3D4sjTFiNiYuuwO8O8wQyzH6c+++aSx5kl7E151DRdomnS7hPafac
	G6WAHLY8QrFmCkmMg7zrqS07IJTZNBnbBunrbp/twVAnqjg27TXi7Pn3JgnsFEEV
	uWtqY79hkhDD1yNS1ExwVPNbssItth9Bf3PQ4xFvXRYEOFwpZ0K+WWhG+wmPJhwN
	+JCxOx0p/c966pI18gSfeu9wDtKDvds2ywEmu4p+bQN1aDo57pmwed/ZrjGnKIxx
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43gju79jrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 11:45:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BDGjERL030884
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 11:45:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 13 Dec
 2024 11:45:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Dec 2024 11:45:13 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BDGipcI025509;
	Fri, 13 Dec 2024 11:45:08 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v8 8/8] iio: adc: ad4851: add ad485x driver
Date: Fri, 13 Dec 2024 18:44:45 +0200
Message-ID: <20241213164445.23195-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213164445.23195-1-antoniu.miclaus@analog.com>
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1VNNgfv66EH8V-veNeVIBTuJkyIEbd7N
X-Proofpoint-ORIG-GUID: 1VNNgfv66EH8V-veNeVIBTuJkyIEbd7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130117

Add support for the AD485X a fully buffered, 8-channel simultaneous
sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
differential, wide common-mode range inputs.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v8:
 - fix kernel bot warnings.
 - drop optional members from chip info struct
 - drop final line continuation
 - drop ext_scan_type and num_ext_scan_type duplicate set.
 - create common function for parsing channels to avoid code duplication.
 - add comment for fields not set in the parts chip info struct.
 - add safety margin for pwm duty cycle.
 - use FIELD_PREP where indicated.
 - use chip resolution instead of chan->scan_type.realbits where indicated.
 - move the reset procedure before setting refbuf/refsel registers.
 - use iio_get_current_scan_type where indicated.
 - refull and compute scales if osr is changed.
 - take into account the osr for the sampling frequency.
 - drop num_channels division by 2 which remained from v6.
 - drop ad4851_scan_type_16 since it is not used.
 - change sign based on diff in iio channel definition.
 - shrink same register writes into a single operation.
 drivers/iio/adc/Kconfig  |   13 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad4851.c | 1300 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1314 insertions(+)
 create mode 100644 drivers/iio/adc/ad4851.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6c4e74420fd2..0d97cd760d90 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -61,6 +61,19 @@ config AD4695
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4695.
 
+config AD4851
+	tristate "Analog Device AD4851 DAS Driver"
+	depends on SPI
+	select REGMAP_SPI
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices AD4851, AD4852,
+	  AD4853, AD4854, AD4855, AD4856, AD4857, AD4858, AD4858I high speed
+	  data acquisition system (DAS).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4851.
+
 config AD7091R
 	tristate
 
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7b91cd98c0e0..d83df8b5925d 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD4695) += ad4695.o
+obj-$(CONFIG_AD4851) += ad4851.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o
 obj-$(CONFIG_AD7091R8) += ad7091r8.o
diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
new file mode 100644
index 000000000000..a5dbf464a4b0
--- /dev/null
+++ b/drivers/iio/adc/ad4851.c
@@ -0,0 +1,1300 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD4851 DAS driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+
+#define AD4851_REG_INTERFACE_CONFIG_A	0x00
+#define AD4851_REG_INTERFACE_CONFIG_B	0x01
+#define AD4851_REG_PRODUCT_ID_L		0x04
+#define AD4851_REG_PRODUCT_ID_H		0x05
+#define AD4851_REG_DEVICE_CTRL		0x25
+#define AD4851_REG_PACKET		0x26
+#define AD4851_REG_OVERSAMPLE		0x27
+
+#define AD4851_REG_CH_CONFIG_BASE	0x2A
+#define AD4851_REG_CHX_SOFTSPAN(ch)	((0x12 * (ch)) + AD4851_REG_CH_CONFIG_BASE)
+#define AD4851_REG_CHX_OFFSET(ch)	(AD4851_REG_CHX_SOFTSPAN(ch) + 0x01)
+#define AD4851_REG_CHX_OFFSET_LSB(ch)	AD4851_REG_CHX_OFFSET(ch)
+#define AD4851_REG_CHX_OFFSET_MID(ch)	(AD4851_REG_CHX_OFFSET_LSB(ch) + 0x01)
+#define AD4851_REG_CHX_OFFSET_MSB(ch)	(AD4851_REG_CHX_OFFSET_MID(ch) + 0x01)
+#define AD4851_REG_CHX_GAIN(ch)		(AD4851_REG_CHX_OFFSET(ch) + 0x03)
+#define AD4851_REG_CHX_GAIN_LSB(ch)	AD4851_REG_CHX_GAIN(ch)
+#define AD4851_REG_CHX_GAIN_MSB(ch)	(AD4851_REG_CHX_GAIN(ch) + 0x01)
+#define AD4851_REG_CHX_PHASE(ch)	(AD4851_REG_CHX_GAIN(ch) + 0x02)
+#define AD4851_REG_CHX_PHASE_LSB(ch)	AD4851_REG_CHX_PHASE(ch)
+#define AD4851_REG_CHX_PHASE_MSB(ch)	(AD4851_REG_CHX_PHASE_LSB(ch) + 0x01)
+
+#define AD4851_REG_TESTPAT_0(c)		(0x38 + (c) * 0x12)
+#define AD4851_REG_TESTPAT_1(c)		(0x39 + (c) * 0x12)
+#define AD4851_REG_TESTPAT_2(c)		(0x3A + (c) * 0x12)
+#define AD4851_REG_TESTPAT_3(c)		(0x3B + (c) * 0x12)
+
+#define AD4851_SW_RESET			(BIT(7) | BIT(0))
+#define AD4851_SDO_ENABLE		BIT(4)
+#define AD4851_SINGLE_INSTRUCTION	BIT(7)
+#define AD4851_REFBUF_PD		BIT(2)
+#define AD4851_REFSEL_PD		BIT(1)
+#define AD4851_ECHO_CLOCK_MODE		BIT(0)
+
+#define AD4851_PACKET_FORMAT_0		0
+#define AD4851_PACKET_FORMAT_1		1
+#define AD4851_PACKET_FORMAT_MASK	GENMASK(1, 0)
+
+#define AD4851_OS_EN_MSK		BIT(7)
+#define AD4851_OS_RATIO_MSK		GENMASK(3, 0)
+
+#define AD4851_TEST_PAT			BIT(2)
+
+#define AD4858_PACKET_SIZE_20		0
+#define AD4858_PACKET_SIZE_24		1
+#define AD4858_PACKET_SIZE_32		2
+
+#define AD4857_PACKET_SIZE_16		0
+#define AD4857_PACKET_SIZE_24		1
+
+#define AD4851_TESTPAT_0_DEFAULT	0x2A
+#define AD4851_TESTPAT_1_DEFAULT	0x3C
+#define AD4851_TESTPAT_2_DEFAULT	0xCE
+#define AD4851_TESTPAT_3_DEFAULT(c)	(0x0A + (0x10 * (c)))
+
+#define AD4851_SOFTSPAN_0V_2V5		0
+#define AD4851_SOFTSPAN_N2V5_2V5	1
+#define AD4851_SOFTSPAN_0V_5V		2
+#define AD4851_SOFTSPAN_N5V_5V		3
+#define AD4851_SOFTSPAN_0V_6V25		4
+#define AD4851_SOFTSPAN_N6V25_6V25	5
+#define AD4851_SOFTSPAN_0V_10V		6
+#define AD4851_SOFTSPAN_N10V_10V	7
+#define AD4851_SOFTSPAN_0V_12V5		8
+#define AD4851_SOFTSPAN_N12V5_12V5	9
+#define AD4851_SOFTSPAN_0V_20V		10
+#define AD4851_SOFTSPAN_N20V_20V	11
+#define AD4851_SOFTSPAN_0V_25V		12
+#define AD4851_SOFTSPAN_N25V_25V	13
+#define AD4851_SOFTSPAN_0V_40V		14
+#define AD4851_SOFTSPAN_N40V_40V	15
+
+#define AD4851_MAX_LANES		8
+#define AD4851_MAX_IODELAY		32
+
+#define AD4851_T_CNVH_NS		40
+#define AD4851_T_CNVH_NS_MARGIN		10
+
+#define AD4841_MAX_SCALE_AVAIL		8
+
+#define AD4851_MAX_CH_NR		8
+#define AD4851_CH_START			0
+
+struct ad4851_scale {
+	unsigned int scale_val;
+	u8 reg_val;
+};
+
+static const struct ad4851_scale ad4851_scale_table_se[] = {
+	{ 2500, 0x0 },
+	{ 5000, 0x2 },
+	{ 6250, 0x4 },
+	{ 10000, 0x6 },
+	{ 12500, 0x8 },
+	{ 20000, 0xA },
+	{ 25000, 0xC },
+	{ 40000, 0xE },
+};
+
+static const struct ad4851_scale ad4851_scale_table_diff[] = {
+	{ 5000, 0x1 },
+	{ 10000, 0x3 },
+	{ 12500, 0x5 },
+	{ 20000, 0x7 },
+	{ 25000, 0x9 },
+	{ 40000, 0xB },
+	{ 50000, 0xD },
+	{ 80000, 0xF },
+};
+
+static const unsigned int ad4851_scale_avail_se[] = {
+	2500,
+	5000,
+	6250,
+	10000,
+	12500,
+	20000,
+	25000,
+	40000,
+};
+
+static const unsigned int ad4851_scale_avail_diff[] = {
+	5000,
+	10000,
+	12500,
+	20000,
+	25000,
+	40000,
+	50000,
+	80000,
+};
+
+struct ad4851_chip_info {
+	const char *name;
+	unsigned int product_id;
+	int num_scales;
+	unsigned long max_sample_rate_hz;
+	unsigned int resolution;
+	int (*parse_channels)(struct iio_dev *indio_dev);
+};
+
+enum {
+	AD4851_SCAN_TYPE_NORMAL,
+	AD4851_SCAN_TYPE_RESOLUTION_BOOST,
+};
+
+struct ad4851_state {
+	struct spi_device *spi;
+	struct pwm_device *cnv;
+	struct iio_backend *back;
+	/*
+	 * Synchronize access to members the of driver state, and ensure
+	 * atomicity of consecutive regmap operations.
+	 */
+	struct mutex lock;
+	struct regmap *regmap;
+	struct regulator *vrefbuf;
+	struct regulator *vrefio;
+	unsigned int num_channels;
+	const struct ad4851_chip_info *info;
+	struct gpio_desc *pd_gpio;
+	bool resolution_boost_enabled;
+	unsigned long cnv_trigger_rate_hz;
+	unsigned int osr;
+	unsigned int scales_se[AD4841_MAX_SCALE_AVAIL][2];
+	unsigned int scales_diff[AD4841_MAX_SCALE_AVAIL][2];
+};
+
+static int ad4851_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int ad4851_set_sampling_freq(struct ad4851_state *st, unsigned int freq)
+{
+	struct pwm_state cnv_state = {
+		.duty_cycle = AD4851_T_CNVH_NS + AD4851_T_CNVH_NS_MARGIN,
+		.enabled = true,
+	};
+	int ret;
+
+	freq = clamp(freq, 1, st->info->max_sample_rate_hz);
+
+	cnv_state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
+
+	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
+	if (ret)
+		return ret;
+
+	st->cnv_trigger_rate_hz = freq;
+
+	return 0;
+}
+
+static const int ad4851_oversampling_ratios[] = {
+	1, 2, 4, 8, 16,	32, 64, 128,
+	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
+	65536,
+};
+
+static int ad4851_osr_to_regval(unsigned int ratio)
+{
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(ad4851_oversampling_ratios); i++)
+		if (ratio == ad4851_oversampling_ratios[i])
+			return i - 1;
+
+	return -EINVAL;
+}
+
+static void __ad4851_get_scale(struct iio_dev *indio_dev, int scale_tbl,
+			       unsigned int *val, unsigned int *val2)
+{
+	const struct iio_scan_type *scan_type;
+	unsigned int tmp;
+
+	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
+
+	tmp = ((unsigned long long)scale_tbl * MICRO) >> scan_type->realbits;
+	*val = tmp / MICRO;
+	*val2 = tmp % MICRO;
+}
+
+static int ad4851_scale_fill(struct iio_dev *indio_dev)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+	unsigned int i, val1, val2;
+
+	for (i = 0; i < ARRAY_SIZE(ad4851_scale_avail_se); i++) {
+		__ad4851_get_scale(indio_dev, ad4851_scale_avail_se[i], &val1, &val2);
+		st->scales_se[i][0] = val1;
+		st->scales_se[i][1] = val2;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ad4851_scale_avail_diff); i++) {
+		__ad4851_get_scale(indio_dev, ad4851_scale_avail_diff[i], &val1, &val2);
+		st->scales_diff[i][0] = val1;
+		st->scales_diff[i][1] = val2;
+	}
+
+	return 0;
+}
+
+static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 unsigned int osr)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	guard(mutex)(&st->lock);
+
+	if (osr == 1) {
+		ret = regmap_clear_bits(st->regmap, AD4851_REG_OVERSAMPLE,
+					AD4851_OS_EN_MSK);
+		if (ret)
+			return ret;
+	} else {
+		val = ad4851_osr_to_regval(osr);
+		if (val < 0)
+			return -EINVAL;
+
+		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
+					 AD4851_OS_EN_MSK |
+					 AD4851_OS_RATIO_MSK,
+					 FIELD_PREP(AD4851_OS_EN_MSK, 1) |
+					 FIELD_PREP(AD4851_OS_RATIO_MSK, val));
+		if (ret)
+			return ret;
+	}
+
+	ret = iio_backend_oversampling_ratio_set(st->back, osr);
+	if (ret)
+		return ret;
+
+	switch (st->info->resolution) {
+	case 20:
+		switch (osr) {
+		case 0:
+			return -EINVAL;
+		case 1:
+			val = 20;
+			break;
+		default:
+			val = 24;
+			break;
+		}
+		break;
+	case 16:
+		val = 16;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = iio_backend_data_size_set(st->back, val);
+	if (ret)
+		return ret;
+
+	if (osr == 1 || st->info->resolution == 16) {
+		ret = regmap_clear_bits(st->regmap, AD4851_REG_PACKET,
+					AD4851_PACKET_FORMAT_MASK);
+		if (ret)
+			return ret;
+
+		st->resolution_boost_enabled = false;
+	} else {
+		ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,
+					 AD4851_PACKET_FORMAT_MASK,
+					 FIELD_PREP(AD4851_PACKET_FORMAT_MASK, 1));
+		if (ret)
+			return ret;
+
+		st->resolution_boost_enabled = true;
+	}
+
+	if (st->osr != osr) {
+		ret = ad4851_scale_fill(indio_dev);
+		if (ret)
+			return ret;
+
+		st->osr = osr;
+	}
+
+	return 0;
+}
+
+static int ad4851_get_oversampling_ratio(struct ad4851_state *st, unsigned int *val)
+{
+	unsigned int osr;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, AD4851_REG_OVERSAMPLE, &osr);
+	if (ret)
+		return ret;
+
+	if (!FIELD_GET(AD4851_OS_EN_MSK, osr))
+		*val = 1;
+	else
+		*val = ad4851_oversampling_ratios[FIELD_GET(AD4851_OS_RATIO_MSK, osr) + 1];
+
+	st->osr = *val;
+
+	return IIO_VAL_INT;
+}
+
+static void ad4851_reg_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static void ad4851_pwm_disable(void *data)
+{
+	pwm_disable(data);
+}
+
+static int ad4851_setup(struct ad4851_state *st)
+{
+	unsigned int product_id;
+	int ret;
+
+	if (st->pd_gpio) {
+		/* To initiate a global reset, bring the PD pin high twice */
+		gpiod_set_value(st->pd_gpio, 1);
+		fsleep(1);
+		gpiod_set_value(st->pd_gpio, 0);
+		fsleep(1);
+		gpiod_set_value(st->pd_gpio, 1);
+		fsleep(1);
+		gpiod_set_value(st->pd_gpio, 0);
+		fsleep(1000);
+	} else {
+		ret = regmap_set_bits(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
+				      AD4851_SW_RESET);
+		if (ret)
+			return ret;
+	}
+
+	if (!IS_ERR(st->vrefbuf)) {
+		ret = regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
+				      AD4851_REFBUF_PD);
+		if (ret)
+			return ret;
+
+		ret = regulator_enable(st->vrefbuf);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&st->spi->dev, ad4851_reg_disable,
+					       st->vrefbuf);
+		if (ret)
+			return ret;
+	}
+
+	if (!IS_ERR(st->vrefio)) {
+		ret = regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
+				      AD4851_REFSEL_PD);
+		if (ret)
+			return ret;
+
+		ret = regulator_enable(st->vrefio);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&st->spi->dev, ad4851_reg_disable,
+					       st->vrefio);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_B,
+			   AD4851_SINGLE_INSTRUCTION);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
+			   AD4851_SDO_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD4851_REG_PRODUCT_ID_L, &product_id);
+	if (ret)
+		return ret;
+
+	if (product_id != st->info->product_id)
+		dev_info(&st->spi->dev, "Unknown product ID: 0x%02X\n",
+			 product_id);
+
+	ret = regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
+			      AD4851_ECHO_CLOCK_MODE);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
+}
+
+static int ad4851_find_opt(bool *field, u32 size, u32 *ret_start)
+{
+	unsigned int i, cnt = 0, max_cnt = 0, max_start = 0;
+	int start;
+
+	for (i = 0, start = -1; i < size; i++) {
+		if (field[i] == 0) {
+			if (start == -1)
+				start = i;
+			cnt++;
+		} else {
+			if (cnt > max_cnt) {
+				max_cnt = cnt;
+				max_start = start;
+			}
+			start = -1;
+			cnt = 0;
+		}
+	}
+	/*
+	 * Find the longest consecutive sequence of false values from field
+	 * and return starting index.
+	 */
+	if (cnt > max_cnt) {
+		max_cnt = cnt;
+		max_start = start;
+	}
+
+	if (!max_cnt)
+		return -ENOENT;
+
+	*ret_start = max_start;
+
+	return max_cnt;
+}
+
+static int ad4851_calibrate(struct ad4851_state *st)
+{
+	unsigned int opt_delay, num_lanes, delay, i, s, c;
+	enum iio_backend_interface_type interface_type;
+	DECLARE_BITMAP(pn_status, AD4851_MAX_LANES * AD4851_MAX_IODELAY);
+	bool status;
+	int ret;
+
+	ret = iio_backend_interface_type_get(st->back, &interface_type);
+	if (ret)
+		return ret;
+
+	switch (interface_type) {
+	case IIO_BACKEND_INTERFACE_SERIAL_CMOS:
+		num_lanes = st->num_channels;
+		break;
+	case IIO_BACKEND_INTERFACE_SERIAL_LVDS:
+		num_lanes = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (st->info->resolution == 16) {
+		ret = iio_backend_data_size_set(st->back, 24);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD4851_REG_PACKET,
+				   AD4851_TEST_PAT | AD4857_PACKET_SIZE_24);
+		if (ret)
+			return ret;
+	} else {
+		ret = iio_backend_data_size_set(st->back, 32);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD4851_REG_PACKET,
+				   AD4851_TEST_PAT | AD4858_PACKET_SIZE_32);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < st->num_channels; i++) {
+		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_0(i),
+				   AD4851_TESTPAT_0_DEFAULT);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_1(i),
+				   AD4851_TESTPAT_1_DEFAULT);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_2(i),
+				   AD4851_TESTPAT_2_DEFAULT);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_3(i),
+				   AD4851_TESTPAT_3_DEFAULT(i));
+		if (ret)
+			return ret;
+
+		ret = iio_backend_chan_enable(st->back, i);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < num_lanes; i++) {
+		for (delay = 0; delay < AD4851_MAX_IODELAY; delay++) {
+			ret = iio_backend_iodelay_set(st->back, i, delay);
+			if (ret)
+				return ret;
+
+			ret = iio_backend_chan_status(st->back, i, &status);
+			if (ret)
+				return ret;
+
+			if (status)
+				set_bit(i * AD4851_MAX_IODELAY + delay, pn_status);
+			else
+				clear_bit(i * AD4851_MAX_IODELAY + delay, pn_status);
+		}
+	}
+
+	for (i = 0; i < num_lanes; i++) {
+		status = test_bit(i * AD4851_MAX_IODELAY, pn_status);
+		c = ad4851_find_opt(&status, AD4851_MAX_IODELAY, &s);
+		if (c < 0)
+			return c;
+
+		opt_delay = s + c / 2;
+		ret = iio_backend_iodelay_set(st->back, i, opt_delay);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < st->num_channels; i++) {
+		ret = iio_backend_chan_disable(st->back, i);
+		if (ret)
+			return ret;
+	}
+
+	ret = iio_backend_data_size_set(st->back, 20);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
+}
+
+static int ad4851_get_calibscale(struct ad4851_state *st, int ch, int *val, int *val2)
+{
+	unsigned int reg_val;
+	int gain;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch), &reg_val);
+	if (ret)
+		return ret;
+
+	gain = reg_val << 8;
+
+	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch), &reg_val);
+	if (ret)
+		return ret;
+
+	gain |= reg_val;
+
+	*val = gain;
+	*val2 = 32768;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int ad4851_set_calibscale(struct ad4851_state *st, int ch, int val,
+				 int val2)
+{
+	u64 gain;
+	u8 buf[2];
+	int ret;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	gain = val * MICRO + val2;
+	gain = DIV_U64_ROUND_CLOSEST(gain * 32768, MICRO);
+
+	put_unaligned_be16(gain, buf);
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_write(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch), buf[0]);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch), buf[1]);
+}
+
+static int ad4851_get_calibbias(struct ad4851_state *st, int ch, int *val)
+{
+	unsigned int lsb, mid, msb;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, AD4851_REG_CHX_OFFSET_MSB(ch),
+			  &msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD4851_REG_CHX_OFFSET_MID(ch),
+			  &mid);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD4851_REG_CHX_OFFSET_LSB(ch),
+			  &lsb);
+	if (ret)
+		return ret;
+
+	if (st->info->resolution == 16) {
+		*val = msb << 8;
+		*val |= mid;
+		*val = sign_extend32(*val, 15);
+	} else {
+		*val = msb << 12;
+		*val |= mid << 4;
+		*val |= lsb >> 4;
+		*val = sign_extend32(*val, 19);
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int ad4851_set_calibbias(struct ad4851_state *st, int ch, int val)
+{
+	u8 buf[3] = { 0 };
+	int ret;
+
+	if (val < 0)
+		return -EINVAL;
+
+	if (st->info->resolution == 16)
+		put_unaligned_be16(val, buf);
+	else
+		put_unaligned_be24(val << 4, buf);
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_write(st->regmap, AD4851_REG_CHX_OFFSET_LSB(ch), buf[2]);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4851_REG_CHX_OFFSET_MID(ch), buf[1]);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4851_REG_CHX_OFFSET_MSB(ch), buf[0]);
+}
+
+static int ad4851_set_scale(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan, int val, int val2)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+	unsigned int scale_val[2];
+	unsigned int i;
+	const struct ad4851_scale *scale_table;
+	size_t table_size;
+
+	if (chan->differential) {
+		scale_table = ad4851_scale_table_diff;
+		table_size = ARRAY_SIZE(ad4851_scale_table_diff);
+	} else {
+		scale_table = ad4851_scale_table_se;
+		table_size = ARRAY_SIZE(ad4851_scale_table_se);
+	}
+
+	for (i = 0; i < table_size; i++) {
+		__ad4851_get_scale(indio_dev, scale_table[i].scale_val,
+				   &scale_val[0], &scale_val[1]);
+		if (scale_val[0] != val || scale_val[1] != val2)
+			continue;
+
+		return regmap_write(st->regmap,
+				    AD4851_REG_CHX_SOFTSPAN(chan->channel),
+				    scale_table[i].reg_val);
+	}
+
+	return -EINVAL;
+}
+
+static int ad4851_get_scale(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan, int *val,
+			    int *val2)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+	const struct ad4851_scale *scale_table;
+	size_t table_size;
+	int i, softspan_val;
+	int ret;
+
+	if (chan->differential) {
+		scale_table = ad4851_scale_table_diff;
+		table_size = ARRAY_SIZE(ad4851_scale_table_diff);
+	} else {
+		scale_table = ad4851_scale_table_se;
+		table_size = ARRAY_SIZE(ad4851_scale_table_se);
+	}
+
+	ret = regmap_read(st->regmap, AD4851_REG_CHX_SOFTSPAN(chan->channel),
+			  &softspan_val);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < table_size; i++) {
+		if (softspan_val == scale_table[i].reg_val)
+			break;
+	}
+
+	if (i == table_size)
+		return -EIO;
+
+	__ad4851_get_scale(indio_dev, scale_table[i].scale_val, val, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ad4851_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->cnv_trigger_rate_hz / st->osr;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4851_get_calibscale(st, chan->channel, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return ad4851_get_scale(indio_dev, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad4851_get_calibbias(st, chan->channel, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return ad4851_get_oversampling_ratio(st, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4851_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4851_set_sampling_freq(st, val * st->osr);
+	case IIO_CHAN_INFO_SCALE:
+		return ad4851_set_scale(indio_dev, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4851_set_calibscale(st, chan->channel, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad4851_set_calibbias(st, chan->channel, val);
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return ad4851_set_oversampling_ratio(indio_dev, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4851_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	for (c = 0; c < st->num_channels; c++) {
+		if (test_bit(c, scan_mask))
+			ret = iio_backend_chan_enable(st->back, c);
+		else
+			ret = iio_backend_chan_disable(st->back, c);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad4851_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->differential) {
+			*vals = (const int *)st->scales_diff;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			/* Values are stored in a 2D matrix */
+			*length = ARRAY_SIZE(ad4851_scale_avail_diff) * 2;
+		} else {
+			*vals = (const int *)st->scales_se;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			/* Values are stored in a 2D matrix */
+			*length = ARRAY_SIZE(ad4851_scale_avail_se) * 2;
+		}
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4851_oversampling_ratios;
+		*length = ARRAY_SIZE(ad4851_oversampling_ratios);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_scan_type ad4851_scan_type_20_0[] = {
+	[AD4851_SCAN_TYPE_NORMAL] = {
+		.sign = 'u',
+		.realbits = 20,
+		.storagebits = 32,
+	},
+	[AD4851_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 'u',
+		.realbits = 24,
+		.storagebits = 32,
+	},
+};
+
+static const struct iio_scan_type ad4851_scan_type_20_1[] = {
+	[AD4851_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 20,
+		.storagebits = 32,
+	},
+	[AD4851_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+	},
+};
+
+static int ad4851_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4851_state *st = iio_priv(indio_dev);
+
+	return st->resolution_boost_enabled ? AD4851_SCAN_TYPE_RESOLUTION_BOOST
+					    : AD4851_SCAN_TYPE_NORMAL;
+}
+
+#define AD4851_IIO_CHANNEL(index, ch, diff)					\
+	.type = IIO_VOLTAGE,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
+		BIT(IIO_CHAN_INFO_CALIBBIAS) |					\
+		BIT(IIO_CHAN_INFO_SCALE),					\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
+	.info_mask_shared_by_all_available =					\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),		\
+	.indexed = 1,								\
+	.differential = diff,							\
+	.channel = ch,								\
+	.channel2 = ch + (diff * 8),						\
+	.scan_index = index,
+
+#define AD4858_IIO_CHANNEL(index, ch, diff)					\
+{										\
+	AD4851_IIO_CHANNEL(index, ch, diff)					\
+}
+
+#define AD4857_IIO_CHANNEL(index, ch, diff)					\
+{										\
+	AD4851_IIO_CHANNEL(index, ch, diff)					\
+	.scan_type = {								\
+		.sign = diff ? 's' : 'u',					\
+		.realbits = 16,							\
+		.storagebits = 16,						\
+	},									\
+}
+
+static int ad4851_parse_channels(struct iio_dev *indio_dev, struct iio_chan_spec **ad4851_channels,
+				 const struct iio_chan_spec ad4851_chan,
+				 const struct iio_chan_spec ad4851_chan_diff)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct ad4851_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *channels;
+	unsigned int num_channels, index = 0, reg;
+	int ret;
+
+	num_channels = device_get_child_node_count(dev);
+	if (num_channels > AD4851_MAX_CH_NR)
+		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
+				     num_channels);
+
+	channels = devm_kcalloc(dev, num_channels,
+				sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = num_channels;
+	st->num_channels = num_channels;
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing channel number\n");
+		if (fwnode_property_present(child, "bipolar")) {
+			*channels = ad4851_chan_diff;
+			channels->scan_index = index++;
+			channels->channel = reg;
+			channels->channel2 = reg + AD4851_MAX_CH_NR;
+
+		} else {
+			*channels = ad4851_chan;
+			channels->scan_index = index++;
+			channels->channel = reg;
+			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
+					   AD4851_SOFTSPAN_0V_40V);
+			if (ret)
+				return ret;
+		}
+		channels++;
+	}
+
+	*ad4851_channels = channels;
+
+	return 0;
+}
+
+static int ad4857_parse_channels(struct iio_dev *indio_dev)
+{
+	struct iio_chan_spec *ad4851_channels;
+	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL(0, 0, 0);
+	const struct iio_chan_spec ad4851_chan_diff = AD4857_IIO_CHANNEL(0, 0, 1);
+
+	return ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan, ad4851_chan_diff);
+}
+
+static int ad4858_parse_channels(struct iio_dev *indio_dev)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *ad4851_channels;
+	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL(0, 0, 0);
+	const struct iio_chan_spec ad4851_chan_diff = AD4858_IIO_CHANNEL(0, 0, 1);
+	unsigned int reg;
+	int ret;
+
+	ret = ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan, ad4851_chan_diff);
+	if (ret)
+		return ret;
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing channel number\n");
+		if (fwnode_property_present(child, "bipolar")) {
+			ad4851_channels->ext_scan_type = ad4851_scan_type_20_1;
+			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_1);
+
+		} else {
+			ad4851_channels->ext_scan_type = ad4851_scan_type_20_0;
+			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_0);
+		}
+		ad4851_channels++;
+	}
+
+	return 0;
+}
+
+/* parse_channel() function populates of the rest of the chip_info fields */
+static const struct ad4851_chip_info ad4851_info = {
+	.name = "ad4851",
+	.product_id = 0x67,
+	.max_sample_rate_hz = 250 * KILO,
+	.resolution = 16,
+	.parse_channels = ad4857_parse_channels,
+};
+
+static const struct ad4851_chip_info ad4852_info = {
+	.name = "ad4852",
+	.product_id = 0x66,
+	.max_sample_rate_hz = 250 * KILO,
+	.resolution = 20,
+	.parse_channels = ad4858_parse_channels,
+};
+
+static const struct ad4851_chip_info ad4853_info = {
+	.name = "ad4853",
+	.product_id = 0x65,
+	.max_sample_rate_hz = 1 * MEGA,
+	.resolution = 16,
+	.parse_channels = ad4857_parse_channels,
+};
+
+static const struct ad4851_chip_info ad4854_info = {
+	.name = "ad4854",
+	.product_id = 0x64,
+	.max_sample_rate_hz = 1 * MEGA,
+	.resolution = 20,
+	.parse_channels = ad4858_parse_channels,
+};
+
+static const struct ad4851_chip_info ad4855_info = {
+	.name = "ad4855",
+	.product_id = 0x63,
+	.max_sample_rate_hz = 250 * KILO,
+	.resolution = 16,
+	.parse_channels = ad4857_parse_channels,
+};
+
+static const struct ad4851_chip_info ad4856_info = {
+	.name = "ad4856",
+	.product_id = 0x62,
+	.max_sample_rate_hz = 250 * KILO,
+	.resolution = 20,
+	.parse_channels = ad4858_parse_channels,
+};
+
+static const struct ad4851_chip_info ad4857_info = {
+	.name = "ad4857",
+	.product_id = 0x61,
+	.max_sample_rate_hz = 1 * MEGA,
+	.resolution = 16,
+	.parse_channels = ad4857_parse_channels,
+};
+
+static const struct ad4851_chip_info ad4858_info = {
+	.name = "ad4858",
+	.product_id = 0x60,
+	.max_sample_rate_hz = 1 * MEGA,
+	.resolution = 20,
+	.parse_channels = ad4858_parse_channels,
+};
+
+static const struct ad4851_chip_info ad4858i_info = {
+	.name = "ad4858i",
+	.product_id = 0x6F,
+	.max_sample_rate_hz = 1 * MEGA,
+	.resolution = 20,
+	.parse_channels = ad4858_parse_channels,
+};
+
+static const struct iio_info ad4851_iio_info = {
+	.debugfs_reg_access = ad4851_reg_access,
+	.read_raw = ad4851_read_raw,
+	.write_raw = ad4851_write_raw,
+	.update_scan_mode = ad4851_update_scan_mode,
+	.get_current_scan_type = &ad4851_get_current_scan_type,
+	.read_avail = ad4851_read_avail,
+};
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+};
+
+static const char * const ad4851_power_supplies[] = {
+	"vcc",	"vdd", "vee", "vio",
+};
+
+static int ad4851_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct device *dev = &spi->dev;
+	struct ad4851_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(ad4851_power_supplies),
+					     ad4851_power_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get and enable supplies\n");
+
+	ret = devm_regulator_get_enable_optional(dev, "vddh");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable vddh voltage\n");
+
+	ret = devm_regulator_get_enable_optional(dev, "vddl");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable vddl voltage\n");
+
+	st->vrefbuf = devm_regulator_get_optional(dev, "vrefbuf");
+	if (IS_ERR(st->vrefbuf)) {
+		if (PTR_ERR(st->vrefbuf) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(st->vrefbuf),
+					     "Failed to get vrefbuf regulator\n");
+	}
+
+	st->vrefio = devm_regulator_get_optional(dev, "vrefio");
+	if (IS_ERR(st->vrefio)) {
+		if (PTR_ERR(st->vrefio) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(st->vrefio),
+					     "Failed to get vrefio regulator\n");
+	}
+
+	st->pd_gpio = devm_gpiod_get_optional(dev, "pd", GPIOD_OUT_LOW);
+	if (IS_ERR(st->pd_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->pd_gpio),
+				     "Error on requesting pd GPIO\n");
+
+	st->cnv = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv))
+		return dev_err_probe(dev, PTR_ERR(st->cnv),
+				     "Error on requesting pwm\n");
+
+	ret = devm_add_action_or_reset(&st->spi->dev, ad4851_pwm_disable,
+				       st->cnv);
+	if (ret)
+		return ret;
+
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
+	st->regmap = devm_regmap_init_spi(spi, &regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = ad4851_set_sampling_freq(st, HZ_PER_MHZ);
+	if (ret)
+		return ret;
+
+	ret = ad4851_setup(st);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->info->name;
+	indio_dev->info = &ad4851_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = st->info->parse_channels(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad4851_scale_fill(indio_dev);
+	if (ret)
+		return ret;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	ret = ad4851_calibrate(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad4851_of_match[] = {
+	{ .compatible = "adi,ad4851", .data = &ad4851_info, },
+	{ .compatible = "adi,ad4852", .data = &ad4852_info, },
+	{ .compatible = "adi,ad4853", .data = &ad4853_info, },
+	{ .compatible = "adi,ad4854", .data = &ad4854_info, },
+	{ .compatible = "adi,ad4855", .data = &ad4855_info, },
+	{ .compatible = "adi,ad4856", .data = &ad4856_info, },
+	{ .compatible = "adi,ad4857", .data = &ad4857_info, },
+	{ .compatible = "adi,ad4858", .data = &ad4858_info, },
+	{ .compatible = "adi,ad4858i", .data = &ad4858i_info, },
+	{ }
+};
+
+static const struct spi_device_id ad4851_spi_id[] = {
+	{ "ad4851", (kernel_ulong_t)&ad4851_info },
+	{ "ad4852", (kernel_ulong_t)&ad4852_info },
+	{ "ad4853", (kernel_ulong_t)&ad4853_info },
+	{ "ad4854", (kernel_ulong_t)&ad4854_info },
+	{ "ad4855", (kernel_ulong_t)&ad4855_info },
+	{ "ad4856", (kernel_ulong_t)&ad4856_info },
+	{ "ad4857", (kernel_ulong_t)&ad4857_info },
+	{ "ad4858", (kernel_ulong_t)&ad4858_info },
+	{ "ad4858i", (kernel_ulong_t)&ad4858i_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4851_spi_id);
+
+static struct spi_driver ad4851_driver = {
+	.probe = ad4851_probe,
+	.driver = {
+		.name = "ad4851",
+		.of_match_table = ad4851_of_match,
+	},
+	.id_table = ad4851_spi_id,
+};
+module_spi_driver(ad4851_driver);
+
+MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
+MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4851 DAS driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BACKEND);
-- 
2.47.1


