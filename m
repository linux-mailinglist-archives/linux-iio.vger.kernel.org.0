Return-Path: <linux-iio+bounces-19581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D374AB97A8
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7868CA20E55
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9592327A7;
	Fri, 16 May 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0Nyzax30"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CC22D4EB;
	Fri, 16 May 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384023; cv=none; b=GU75chwdDvxxicsN5kQ2CIt7/9Z1DRBFXXvZfBawxBy1n1LN+nyBQpVD4/Gi7iRFxk7bixNB2P0wp1d1Hli9+rLZRwnyoLsM55AJiMHDDXGBa11f9V1nFZV8A2XWMIrgBV0/mwzRJgZtAoyuguhyFgj0zjdi4scN/1LVAadkU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384023; c=relaxed/simple;
	bh=V4dbu7o5GxugvNEiDqVhETWdivv9mY9YWoXw3IYIhAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrWXQFW5B/0YBzxRpwJRQ9rGA3uvr3bcu1l2csMCCQ7RlDNWU6Vh6fno5F/5vEXCXJq8L6qRk2HLniz1XMzLflq6FWi41e9qK4ab+QfXs6+sJ8llvmLwWxsgDx/kAdX037Cg65P1YoAjySZnscm7uy7QXxGhQekJ9Vo7kgXrIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0Nyzax30; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5Je3x001264;
	Fri, 16 May 2025 04:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jLMrd
	hx45i4EVP4ZMXMDqSQxvSW9iK66a67dggCUVnM=; b=0Nyzax30YQ5hT7D10gKrs
	prrHnG4lsOujg2ErjwAXBQPkB4X7f01rPuqdtkDvsi7++icH2oIkIFCpOPkePW+4
	IJDf1Yp2IfwCB+wpMGmvw6tlUr571USrsDTm7zH2GwvINyOH/ZkGfljlcgyOhWiw
	6mIsGnGA2IFyY8sCXpk3mGiCv6L6BWkRS9jpeLav191r1xIiYqIC1MswuwI/NvVU
	OB1VC0c+B5CG/H5Ic0pd/s2RhP6FcD94jnAEVE/R46AuPBb6Q16GJOLCanfPWSWy
	73ookw5oiMXcGFESZp+CiVyzv6xz9Z971xQ3f3FkR0zK2hOt1V6OPsS1l10pSFL0
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46ny4a8qjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:26:58 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8Qv45033654
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:57 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:56 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwn031549;
	Fri, 16 May 2025 04:26:51 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 09/10] iio: adc: ad4080: add driver support
Date: Fri, 16 May 2025 11:26:29 +0300
Message-ID: <20250516082630.8236-10-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516082630.8236-1-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: KiT57I4d2xzrZv0uGMTR-ZF6wtBotYf6
X-Authority-Analysis: v=2.4 cv=MvdS63ae c=1 sm=1 tr=0 ts=6826f6d2 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=XWQM0tir05fXBLfBid0A:9
X-Proofpoint-ORIG-GUID: KiT57I4d2xzrZv0uGMTR-ZF6wtBotYf6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfX6pOqXvLu4kdQ
 TG2uhKYTqPGkreuU231+0hFeRBSwj5lGF2zKgw56q9gd0Rakm8bCJTrsLJAUySPEsWgtGYrR3mu
 H8p1+7vDANeBmKM/bRG0OFb95KzT5HrujcRVcFcAH4XEwA01ykEKPx9pDYwjLfWnJUhh/mQNQ66
 GnSHT+CD8V3t2udmwBiJaqmAl3hkZlRH8RjMgWZRcwymCdqtKwOEW7L2VXFxv8/TMmI9pBOuo/y
 q9mSOXW6l3QXTdCzsoKsoNXpssr7TDZICtHxrk/xmqFcuiDYvga1w9oCGR4ewKpWPnGvAr12e7E
 +XlmLUN0zZmvte6XKeLNrjhCTjgw4KaBuYutAi5BDEQrVOJyAyf8i0p9smXJSPjWQHFYAZ1PlOs
 uHMmI9spBbQ7zvM9BMNbvDfibeoSmG1r4jjv4obe8vjTidi7swAhPIJHyYobH0MBfSvwkha+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160079

Add support for AD4080 high-speed, low noise, low distortion,
20-bit, Easy Drive, successive approximation register (SAR)
analog-to-digital converter (ADC).

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - use _avail suffix
 - drop clk from ad4080_state
 - check ad4080_get_dec_rate return values for error codes
 - check if st->filter_type == FILTER_NONE and update read/write raw functions.
 - update read_avail function for different filter types.
 - add extra macros/comments where needed.
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  14 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4080.c | 620 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 636 insertions(+)
 create mode 100644 drivers/iio/adc/ad4080.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 244a4510bbc8..0038f7a078ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1323,6 +1323,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+F:	drivers/iio/adc/ad4080.c
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 27413516216c..17df328f5322 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -47,6 +47,20 @@ config AD4030
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4030.
 
+config AD4080
+	tristate "Analog Devices AD4080 high speed ADC"
+	depends on SPI
+	select REGMAP_SPI
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices AD4080
+	  high speed, low noise, low distortion, 20-bit, Easy Drive,
+	  successive approximation register (SAR) analog-to-digital
+	  converter (ADC). Supports iio_backended devices for AD4080.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4080.
+
 config AD4130
 	tristate "Analog Device AD4130 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9f26d5eca822..e6efed5b4e7a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4030) += ad4030.o
+obj-$(CONFIG_AD4080) += ad4080.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD4851) += ad4851.o
diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
new file mode 100644
index 000000000000..db79b754e065
--- /dev/null
+++ b/drivers/iio/adc/ad4080.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD4080 SPI ADC driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+/* Register Definition */
+#define AD4080_REG_INTERFACE_CONFIG_A				0x00
+#define AD4080_REG_INTERFACE_CONFIG_B				0x01
+#define AD4080_REG_DEVICE_CONFIG				0x02
+#define AD4080_REG_CHIP_TYPE					0x03
+#define AD4080_REG_PRODUCT_ID_L					0x04
+#define AD4080_REG_PRODUCT_ID_H					0x05
+#define AD4080_REG_CHIP_GRADE					0x06
+#define AD4080_REG_SCRATCH_PAD					0x0A
+#define AD4080_REG_SPI_REVISION					0x0B
+#define AD4080_REG_VENDOR_L					0x0C
+#define AD4080_REG_VENDOR_H					0x0D
+#define AD4080_REG_STREAM_MODE					0x0E
+#define AD4080_REG_TRANSFER_CONFIG				0x0F
+#define AD4080_REG_INTERFACE_CONFIG_C				0x10
+#define AD4080_REG_INTERFACE_STATUS_A				0x11
+#define AD4080_REG_DEVICE_STATUS				0x14
+#define AD4080_REG_ADC_DATA_INTF_CONFIG_A			0x15
+#define AD4080_REG_ADC_DATA_INTF_CONFIG_B			0x16
+#define AD4080_REG_ADC_DATA_INTF_CONFIG_C			0x17
+#define AD4080_REG_PWR_CTRL					0x18
+#define AD4080_REG_GPIO_CONFIG_A				0x19
+#define AD4080_REG_GPIO_CONFIG_B				0x1A
+#define AD4080_REG_GPIO_CONFIG_C				0x1B
+#define AD4080_REG_GENERAL_CONFIG				0x1C
+#define AD4080_REG_FIFO_WATERMARK_LSB				0x1D
+#define AD4080_REG_FIFO_WATERMARK_MSB				0x1E
+#define AD4080_REG_EVENT_HYSTERESIS_LSB				0x1F
+#define AD4080_REG_EVENT_HYSTERESIS_MSB				0x20
+#define AD4080_REG_EVENT_DETECTION_HI_LSB			0x21
+#define AD4080_REG_EVENT_DETECTION_HI_MSB			0x22
+#define AD4080_REG_EVENT_DETECTION_LO_LSB			0x23
+#define AD4080_REG_EVENT_DETECTION_LO_MSB			0x24
+#define AD4080_REG_OFFSET_LSB					0x25
+#define AD4080_REG_OFFSET_MSB					0x26
+#define AD4080_REG_GAIN_LSB					0x27
+#define AD4080_REG_GAIN_MSB					0x28
+#define AD4080_REG_FILTER_CONFIG				0x29
+
+/* AD4080_REG_INTERFACE_CONFIG_A Bit Definition */
+#define AD4080_INTERFACE_CONFIG_A_SW_RESET			(BIT(7) | BIT(0))
+#define AD4080_INTERFACE_CONFIG_A_ADDR_ASC			BIT(5)
+#define AD4080_INTERFACE_CONFIG_A_SDO_ENABLE			BIT(4)
+
+/* AD4080_REG_INTERFACE_CONFIG_B Bit Definition */
+#define AD4080_INTERFACE_CONFIG_B_SINGLE_INST			BIT(7)
+#define AD4080_INTERFACE_CONFIG_B_SHORT_INST			BIT(3)
+
+/* AD4080_REG_DEVICE_CONFIG Bit Definition */
+#define AD4080_DEVICE_CONFIG_OPERATING_MODES_MSK		GENMASK(1, 0)
+
+/* AD4080_REG_TRANSFER_CONFIG Bit Definition */
+#define AD4080_TRANSFER_CONFIG_KEEP_STREAM_LENGTH_VAL		BIT(2)
+
+/* AD4080_REG_INTERFACE_CONFIG_C Bit Definition */
+#define AD4080_INTERFACE_CONFIG_C_STRICT_REG_ACCESS		BIT(5)
+
+/* AD4080_REG_ADC_DATA_INTF_CONFIG_A Bit Definition */
+#define AD4080_ADC_DATA_INTF_CONFIG_A_RESERVED_CONFIG_A		BIT(6)
+#define AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN		BIT(4)
+#define AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES		BIT(2)
+#define AD4080_ADC_DATA_INTF_CONFIG_A_DATA_INTF_MODE		BIT(0)
+
+/* AD4080_REG_ADC_DATA_INTF_CONFIG_B Bit Definition */
+#define AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK	GENMASK(7, 4)
+#define AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_SELF_CLK_MODE	BIT(3)
+#define AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_EN		BIT(0)
+
+/* AD4080_REG_ADC_DATA_INTF_CONFIG_C Bit Definition */
+#define AD4080_ADC_DATA_INTF_CONFIG_C_LVDS_VOD_MSK		GENMASK(6, 4)
+
+/* AD4080_REG_PWR_CTRL Bit Definition */
+#define AD4080_PWR_CTRL_ANA_DIG_LDO_PD				BIT(1)
+#define AD4080_PWR_CTRL_INTF_LDO_PD				BIT(0)
+
+/* AD4080_REG_GPIO_CONFIG_A Bit Definition */
+#define AD4080_GPIO_CONFIG_A_GPO_1_EN				BIT(1)
+#define AD4080_GPIO_CONFIG_A_GPO_0_EN				BIT(0)
+
+/* AD4080_REG_GPIO_CONFIG_B Bit Definition */
+#define AD4080_GPIO_CONFIG_B_GPIO_1_SEL_MSK			GENMASK(7, 4)
+#define AD4080_GPIO_CONFIG_B_GPIO_0_SEL_MSK			GENMASK(3, 0)
+#define AD4080_GPIO_CONFIG_B_GPIO_SPI_SDO			0
+#define AD4080_GPIO_CONFIG_B_GPIO_FIFO_FULL			1
+#define AD4080_GPIO_CONFIG_B_GPIO_FIFO_READ_DONE		2
+#define AD4080_GPIO_CONFIG_B_GPIO_FILTER_RES_RDY		3
+#define AD4080_GPIO_CONFIG_B_GPIO_H_THRESH			4
+#define AD4080_GPIO_CONFIG_B_GPIO_L_THRESH			5
+#define AD4080_GPIO_CONFIG_B_GPIO_STATUS_ALERT			6
+#define AD4080_GPIO_CONFIG_B_GPIO_GPIO_DATA			7
+#define AD4080_GPIO_CONFIG_B_GPIO_FILTER_SYNC			8
+#define AD4080_GPIO_CONFIG_B_GPIO_EXTERNAL_EVENT		9
+
+/* AD4080_REG_FIFO_CONFIG Bit Definition */
+#define AD4080_FIFO_CONFIG_FIFO_MODE_MSK			GENMASK(1, 0)
+
+/* AD4080_REG_FILTER_CONFIG Bit Definition */
+#define AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK			GENMASK(6, 3)
+#define AD4080_FILTER_CONFIG_FILTER_SEL_MSK			GENMASK(1, 0)
+
+/* Miscellaneous Definitions */
+#define AD4080_SPI_READ						BIT(7)
+#define AD4080_CHIP_ID						GENMASK(2, 0)
+
+#define AD4080_LVDS_CNV_CLK_CNT_MAX				7
+
+#define AD4080_MAX_SAMP_FREQ					40000000
+#define AD4080_MIN_SAMP_FREQ					1250000
+
+enum ad4080_filter_type {
+	FILTER_NONE,
+	SINC_1,
+	SINC_5,
+	SINC_5_COMP
+};
+
+static const unsigned int ad4080_scale_table[][2] = {
+	{ 6000, 0 },
+};
+
+static const char *const ad4080_filter_type_iio_enum[] = {
+	[FILTER_NONE]      = "none",
+	[SINC_1]           = "sinc1",
+	[SINC_5]           = "sinc5",
+	[SINC_5_COMP]      = "sinc5+pf1",
+};
+
+static const int ad4080_dec_rate_avail[] = {
+	2, 4, 8, 16, 32, 64, 128, 256, 512, 1024,
+};
+
+static const int ad4080_dec_rate_none[] = { 1 };
+
+static const char * const ad4080_power_supplies[] = {
+	"vdd33", "vdd11", "vddldo", "iovdd", "vrefin",
+};
+
+struct ad4080_chip_info {
+	const char *name;
+	unsigned int product_id;
+	int num_scales;
+	const unsigned int (*scale_table)[2];
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
+struct ad4080_state {
+	struct regmap			*regmap;
+	struct iio_backend		*back;
+	const struct ad4080_chip_info	*info;
+	/*
+	 * Synchronize access to members the of driver state, and ensure
+	 * atomicity of consecutive regmap operations.
+	 */
+	struct mutex			lock;
+	unsigned int			num_lanes;
+	unsigned int			dec_rate;
+	unsigned long			clk_rate;
+	enum ad4080_filter_type		filter_type;
+	bool				lvds_cnv_en;
+};
+
+static const struct regmap_config ad4080_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+	.max_register = 0x29,
+};
+
+static int ad4080_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int ad4080_get_scale(struct ad4080_state *st, int *val, int *val2)
+{
+	unsigned int tmp;
+
+	tmp = (st->info->scale_table[0][0] * 1000000ULL) >>
+		    st->info->channels[0].scan_type.realbits;
+	*val = tmp / 1000000;
+	*val2 = tmp % 1000000;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static unsigned int ad4080_get_dec_rate(struct iio_dev *dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4080_state *st = iio_priv(dev);
+	int ret;
+	unsigned int data;
+
+	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	if (ret)
+		return ret;
+
+	return 1 << (FIELD_GET(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK, data) + 1);
+}
+
+static int ad4080_set_dec_rate(struct iio_dev *dev,
+			       const struct iio_chan_spec *chan,
+			       unsigned int mode)
+{
+	struct ad4080_state *st = iio_priv(dev);
+
+	guard(mutex)(&st->lock);
+
+	if ((st->filter_type >= SINC_5 && mode >= 512) || mode < 2)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
+				  AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
+				  FIELD_PREP(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
+					     (ilog2(mode) - 1)));
+}
+
+static int ad4080_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long m)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+	int dec_rate;
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad4080_get_scale(st, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		dec_rate = ad4080_get_dec_rate(indio_dev, chan);
+		if (dec_rate < 0)
+			return dec_rate;
+		if (st->filter_type == SINC_5_COMP)
+			dec_rate *= 2;
+		if (st->filter_type)
+			*val = DIV_ROUND_CLOSEST(st->clk_rate, dec_rate);
+		else
+			*val = st->clk_rate;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (st->filter_type == FILTER_NONE) {
+			*val = 1;
+		} else {
+			*val = ad4080_get_dec_rate(indio_dev, chan);
+			if (*val < 0)
+				return *val;
+		}
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4080_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (st->filter_type == FILTER_NONE && val > 1)
+			return -EINVAL;
+
+		return ad4080_set_dec_rate(indio_dev, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4080_lvds_sync_write(struct ad4080_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	int ret;
+
+	ret = regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+			      AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_interface_data_align(st->back, 10000);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Data alignment process failed\n");
+
+	dev_dbg(dev, "Success: Pattern correct and Locked!\n");
+	return regmap_clear_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+				 AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN);
+}
+
+static ssize_t ad4080_get_filter_type(struct iio_dev *dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct ad4080_state *st = iio_priv(dev);
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD4080_FILTER_CONFIG_FILTER_SEL_MSK, data);
+}
+
+static int ad4080_set_filter_type(struct iio_dev *dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int mode)
+{
+	struct ad4080_state *st = iio_priv(dev);
+	int dec_rate;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	dec_rate = ad4080_get_dec_rate(dev, chan);
+	if (dec_rate < 0)
+		return dec_rate;
+
+	if (mode >= SINC_5 && dec_rate >= 512)
+		return -EINVAL;
+
+	ret = iio_backend_filter_type_set(st->back, mode);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
+				 AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
+				 FIELD_PREP(AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
+					    mode));
+	if (ret)
+		return ret;
+
+	st->filter_type = mode;
+
+	return 0;
+}
+
+static int ad4080_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (st->filter_type) {
+		case FILTER_NONE:
+			*vals = ad4080_dec_rate_none;
+			*length = ARRAY_SIZE(ad4080_dec_rate_none);
+			break;
+		default:
+			*vals = ad4080_dec_rate_avail;
+			*length = st->filter_type >= SINC_5 ?
+				  (ARRAY_SIZE(ad4080_dec_rate_avail) - 2) :
+				  ARRAY_SIZE(ad4080_dec_rate_avail);
+			break;
+		}
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad4080_iio_info = {
+	.debugfs_reg_access = ad4080_reg_access,
+	.read_raw = ad4080_read_raw,
+	.write_raw = ad4080_write_raw,
+	.read_avail = ad4080_read_avail,
+};
+
+static const struct iio_enum ad4080_filter_type_enum = {
+	.items = ad4080_filter_type_iio_enum,
+	.num_items = ARRAY_SIZE(ad4080_filter_type_iio_enum),
+	.set = ad4080_set_filter_type,
+	.get = ad4080_get_filter_type,
+};
+
+static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad4080_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
+			   &ad4080_filter_type_enum),
+	{ }
+};
+
+static const struct iio_chan_spec ad4080_channel = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.channel = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	.ext_info = ad4080_ext_info,
+	.scan_index = 0,
+	.scan_type = {
+		.sign = 's',
+		.realbits = 20,
+		.storagebits = 32,
+	},
+};
+
+static const struct ad4080_chip_info ad4080_chip_info = {
+	.name = "AD4080",
+	.product_id = AD4080_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4080_channel,
+};
+
+static int ad4080_setup(struct iio_dev *indio_dev)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->regmap);
+	unsigned int id;
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
+			   AD4080_INTERFACE_CONFIG_A_SW_RESET);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
+			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
+	if (ret)
+		return ret;
+
+	if (id != AD4080_CHIP_ID)
+		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
+
+	ret = regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
+			      AD4080_GPIO_CONFIG_A_GPO_1_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
+			   FIELD_PREP(AD4080_GPIO_CONFIG_B_GPIO_1_SEL_MSK,
+				      AD4080_GPIO_CONFIG_B_GPIO_FILTER_RES_RDY));
+	if (ret)
+		return ret;
+
+	ret = iio_backend_num_lanes_set(st->back, st->num_lanes);
+	if (ret)
+		return ret;
+
+	if (!st->lvds_cnv_en)
+		return 0;
+
+	/* Set maximum LVDS Data Transfer Latency */
+	ret = regmap_update_bits(st->regmap,
+				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
+				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
+				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
+					    AD4080_LVDS_CNV_CLK_CNT_MAX));
+	if (ret)
+		return ret;
+
+	if (st->num_lanes > 1) {
+		ret = regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+				      AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_set_bits(st->regmap,
+			      AD4080_REG_ADC_DATA_INTF_CONFIG_B,
+			      AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_EN);
+	if (ret)
+		return ret;
+
+	return ad4080_lvds_sync_write(st);
+}
+
+static int ad4080_properties_parse(struct ad4080_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+
+	st->lvds_cnv_en = device_property_read_bool(dev, "adi,lvds-cnv-enable");
+
+	st->num_lanes = 1;
+	device_property_read_u32(dev, "adi,num-lanes", &st->num_lanes);
+	if (!st->num_lanes)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid 'adi,num-lanes' value: %u",
+				     st->num_lanes);
+
+	return 0;
+}
+
+static int ad4080_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct device *dev = &spi->dev;
+	struct ad4080_state *st;
+	struct clk *clk;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(ad4080_power_supplies),
+					     ad4080_power_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get and enable supplies\n");
+
+	st->regmap = devm_regmap_init_spi(spi, &ad4080_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->info = &ad4080_iio_info;
+
+	ret = ad4080_properties_parse(st);
+	if (ret)
+		return ret;
+
+	clk = devm_clk_get_enabled(&spi->dev, "cnv");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	st->clk_rate = clk_get_rate(clk);
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
+	ret = ad4080_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad4080_id[] = {
+	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4080_id);
+
+static const struct of_device_id ad4080_of_match[] = {
+	{ .compatible = "adi,ad4080", &ad4080_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4080_of_match);
+
+static struct spi_driver ad4080_driver = {
+	.driver = {
+		.name = "ad4080",
+		.of_match_table = ad4080_of_match,
+	},
+	.probe = ad4080_probe,
+	.id_table = ad4080_id,
+};
+module_spi_driver(ad4080_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_DESCRIPTION("Analog Devices AD4080");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.49.0


