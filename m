Return-Path: <linux-iio+bounces-20374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B58AD43CB
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3A017D0BB
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F9E265CAC;
	Tue, 10 Jun 2025 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v51JjhXK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701926560C;
	Tue, 10 Jun 2025 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587526; cv=none; b=fV1QD+4J5JY071aNTSxISQ1vJmQewjuh+0emT3ppGl8ydon4xgmUt/tjETXFAfAG+vsa9JD1kbYAk7MzjbmMsrSSjpq2HI4yyKJX0aRbFXskb7UJUqWV9hRR4GhEFuTLSLj/RbwFHeWXkCgBiUcndC3oHxwzkN8hg/uRIsmRHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587526; c=relaxed/simple;
	bh=bQTXM4LvxGqiRxwQAzHxsyFfx/K2U6FtWCi8v1sDUx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKHCrw7wlYXPEBPSCBLnUXyaX7i+xIoDaQ43NknWH0v4jDWJsTAxVkPE/tnKhJG2+veAcZs5zMryptFKYRVUNqLio1etnXx0vmypPm4u90H1eygKROI1aV9Z0hvW/OC4HGnW+pEX3cGgD7Hz5Up0maaM+TM76kqoV89eY7nrGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v51JjhXK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIBspF016855;
	Tue, 10 Jun 2025 16:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iPWfU
	so8LsR/DAEI/B8savl/fzXATYGRJOr2Gi24spc=; b=v51JjhXKju+9fDFSOiMW8
	fh0pXjsQ/YjqOW5CIHG8h/OK9MlChe99C1YVM4J/w7rdiqaiS4BoYIi3JK4XpUX8
	HZ/G6gF5wro/KB3u+XSNY8xVERtsQOIGnQwz7Up8n4PF4y044tIeh0xdYzVsYsRx
	jdSG/HOdLumxchTxDu5C5TKbNmZ++dM/uvEfWhrBMV9yIYKdL0ps3C6zWX0hiABO
	o/ILn9MCKAOmfayNAHG5DgALUUBj9x8W64Yj+k42IC0pbmd+nJ5pu6JyOp3diLNN
	FNCZImpgia+FHPAElcj+RJO+jVe5SOXGLv2FZEJS9rHfq+hkokme5sarpRlZrfEb
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 476n7yadnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:31:43 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55AKVfbs037625
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:31:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 16:31:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:31:41 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKVPot019884;
	Tue, 10 Jun 2025 16:31:28 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Ana-Maria Cusco <ana-maria.cusco@analog.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Date: Tue, 10 Jun 2025 17:31:25 -0300
Message-ID: <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1749582679.git.marcelo.schmitt@analog.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Z7TsHGRA c=1 sm=1 tr=0 ts=6848962f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=8YWtSZ-QMrtEnxTCorIA:9 a=RaWJKyVn9BWpbNug:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: X-nznX9rqWtfDnz5VGJatsE66aOqFqgh
X-Proofpoint-GUID: X-nznX9rqWtfDnz5VGJatsE66aOqFqgh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfXw1xBPns7zvH8
 miEjLNURwdGOmbvlfViqLqzP0m1oa4Qpn/ApTSPDkPWA6aHYAqRkA+65akrlOF8McLPrBhSQdhm
 3Ng0N/t1GxFnb3IN9+iHZjVkepPgIOmfomfnLaB4QlGPghT/o7umyEy+hlw/LWoHdpoOMFSDnWU
 AWTilt+2UDmJqwNCFk8gbbxpzkiuzKfeIfUrLIgfu0sxX7G/IiOLM14LjlfebJAL3sa9clJ6Wv0
 J4Uxn1Q+rkHlDn0gCwRPCsMulA/h1CNyjGElDkWKi2soApZo9rDS+vc9+Okrs84DFWXTP+r6mfI
 a0w5UkWBHtmflEEsVuQbBFL2iG+uUsyJH5GKChBUuX2dUCUVy25bEdTx1zdDZ6yfEK/90CuGney
 7v87D7i1pspWQ8HDc+H9sYdsPw7azWNgncTg/8mkzXLkHNl7H8KzAaO7Ay7xRvVUQL1BvfLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100166

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

The AD4170 is a multichannel, low noise, 24-bit precision sigma-delta
analog to digital converter. The AD4170 design offers a flexible data
acquisition solution with crosspoint multiplexed analog inputs,
configurable ADC voltage reference inputs, ultra-low noise integrated PGA,
digital filtering, wide range of configurable output data rates, internal
oscillator and temperature sensor, four GPIOs, and integrated features for
interfacing with load cell weigh scales, RTD, and thermocouple sensors.

Add basic support for the AD4170 ADC with the following features:
- Single-shot read.
- Analog front end PGA configuration.
- Differential and pseudo-differential input configuration.

Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Dropped 'ret' variable set but not used, warned by 0-day test bot.
- Rephrased comment about static_assert to clarify the reason for it's usage.
- Added missing includes.
- Did a few minor code readability improvements, complying with review suggestions.

 MAINTAINERS              |    1 +
 drivers/iio/adc/Kconfig  |   12 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad4170.c | 1535 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 1549 insertions(+)
 create mode 100644 drivers/iio/adc/ad4170.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 44735314a43e..66d261ebbaf8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1398,6 +1398,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
+F:	drivers/iio/adc/ad4170.c
 
 ANALOG DEVICES INC AD4695 DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3bd03df9a976..03966d07a721 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -84,6 +84,18 @@ config AD4130
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4130.
 
+
+config AD4170
+	tristate "Analog Device AD4170 ADC Driver"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD4170 SPI analog
+	  to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4170.
+
 config AD4695
 	tristate "Analog Device AD4695 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 6516ccb4d63b..d99c35ff9a1c 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4030) += ad4030.o
 obj-$(CONFIG_AD4080) += ad4080.o
 obj-$(CONFIG_AD4130) += ad4130.o
+obj-$(CONFIG_AD4170) += ad4170.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD4851) += ad4851.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
new file mode 100644
index 000000000000..d0628430ed14
--- /dev/null
+++ b/drivers/iio/adc/ad4170.c
@@ -0,0 +1,1535 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Analog Devices, Inc.
+ * Author: Ana-Maria Cusco <ana-maria.cusco@analog.com>
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+#include <linux/util_macros.h>
+
+/*
+ * AD4170 registers
+ * Multibyte register addresses point to the most significant byte which is the
+ * address to use to get the most significant byte first (address accessed is
+ * decremented by one for each data byte)
+ *
+ * Each register address define follows the AD4170_<REG_NAME>_REG form.
+ * Each mask follows the AD4170_<REG_NAME>_<FIELD_NAME> form.
+ * E.g. AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK is for accessing DIG_AUX1_CTRL field
+ * of PIN_MUXING_REG.
+ * Each constant follows the AD4170_<REG_NAME>_<FIELD_NAME>_<FUNCTION> form.
+ * E.g. AD4170_PIN_MUXING_DIG_AUX1_DISABLED is the value written to
+ * DIG_AUX1_CTRL field of PIN_MUXING register to disable DIG_AUX1 pin.
+ * Some register names and register field names are shortened versions of
+ * their datasheet counterpart names to provide better code readability.
+ */
+#define AD4170_CONFIG_A_REG				0x00
+#define AD4170_DATA_24B_REG				0x1E
+#define AD4170_PIN_MUXING_REG				0x69
+#define AD4170_ADC_CTRL_REG				0x71
+#define AD4170_CHAN_EN_REG				0x79
+#define AD4170_CHAN_SETUP_REG(x)			(0x81 + 4 * (x))
+#define AD4170_CHAN_MAP_REG(x)				(0x83 + 4 * (x))
+#define AD4170_MISC_REG(x)				(0xC1 + 14 * (x))
+#define AD4170_AFE_REG(x)				(0xC3 + 14 * (x))
+#define AD4170_FILTER_REG(x)				(0xC5 + 14 * (x))
+#define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
+#define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
+#define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+
+#define AD4170_REG_READ_MASK				BIT(14)
+
+/* AD4170_CONFIG_A_REG - INTERFACE_CONFIG_A REGISTER */
+#define AD4170_SW_RESET_MSK				(BIT(7) | BIT(0))
+
+/* AD4170_PIN_MUXING_REG */
+#define AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK		GENMASK(5, 4)
+
+/* AD4170_ADC_CTRL_REG */
+#define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
+#define AD4170_ADC_CTRL_MODE_MSK			GENMASK(3, 0)
+
+/* AD4170_CHAN_EN_REG */
+#define AD4170_CHAN_EN(ch)				BIT(ch)
+
+/* AD4170_CHAN_SETUP_REG */
+#define AD4170_CHAN_SETUP_SETUP_MSK			GENMASK(2, 0)
+
+/* AD4170_CHAN_MAP_REG */
+#define AD4170_CHAN_MAP_AINP_MSK			GENMASK(12, 8)
+#define AD4170_CHAN_MAP_AINM_MSK			GENMASK(4, 0)
+
+/* AD4170_AFE_REG */
+#define AD4170_AFE_REF_BUF_M_MSK			GENMASK(11, 10)
+#define AD4170_AFE_REF_BUF_P_MSK			GENMASK(9, 8)
+#define AD4170_AFE_REF_SELECT_MSK			GENMASK(6, 5)
+#define AD4170_AFE_BIPOLAR_MSK				BIT(4)
+#define AD4170_AFE_PGA_GAIN_MSK				GENMASK(3, 0)
+
+/* AD4170 register constants */
+
+/* AD4170_CHAN_MAP_REG constants */
+#define AD4170_CHAN_MAP_AIN(x)			(x)
+#define AD4170_CHAN_MAP_TEMP_SENSOR		17
+#define AD4170_CHAN_MAP_AVDD_AVSS_P		18
+#define AD4170_CHAN_MAP_AVDD_AVSS_N		18
+#define AD4170_CHAN_MAP_IOVDD_DGND_P		19
+#define AD4170_CHAN_MAP_IOVDD_DGND_N		19
+#define AD4170_CHAN_MAP_AVSS			23
+#define AD4170_CHAN_MAP_DGND			24
+#define AD4170_CHAN_MAP_REFIN1_P		25
+#define AD4170_CHAN_MAP_REFIN1_N		26
+#define AD4170_CHAN_MAP_REFIN2_P		27
+#define AD4170_CHAN_MAP_REFIN2_N		28
+#define AD4170_CHAN_MAP_REFOUT			29
+
+/* AD4170_PIN_MUXING_REG constants */
+#define AD4170_PIN_MUXING_DIG_AUX1_DISABLED		0x0
+#define AD4170_PIN_MUXING_DIG_AUX1_RDY			0x1
+
+/* AD4170_ADC_CTRL_REG constants */
+#define AD4170_ADC_CTRL_MODE_SINGLE			0x4
+#define AD4170_ADC_CTRL_MODE_IDLE			0x7
+
+/* Device properties and auxiliary constants */
+
+#define AD4170_NUM_ANALOG_PINS				9
+#define AD4170_MAX_CHANNELS				16
+#define AD4170_MAX_ANALOG_PINS				8
+#define AD4170_MAX_SETUPS				8
+#define AD4170_INVALID_SETUP				9
+#define AD4170_SPI_MAX_XFER_LEN				6
+
+#define AD4170_INT_REF_2_5V				2500000
+
+/* Internal and external clock properties */
+#define AD4170_INT_CLOCK_16MHZ				(16 * HZ_PER_MHZ)
+
+#define AD4170_NUM_PGA_OPTIONS				10
+
+#define AD4170_GAIN_REG_DEFAULT				0x555555
+
+static const unsigned int ad4170_reg_size[] = {
+	[AD4170_CONFIG_A_REG] = 1,
+	[AD4170_DATA_24B_REG] = 3,
+	[AD4170_PIN_MUXING_REG] = 2,
+	[AD4170_ADC_CTRL_REG] = 2,
+	[AD4170_CHAN_EN_REG] = 2,
+	/*
+	 * CHANNEL_SETUP and CHANNEL_MAP register are all 2 byte size each and
+	 * their addresses are interleaved such that we have CHANNEL_SETUP0
+	 * address followed by CHANNEL_MAP0 address, followed by CHANNEL_SETUP1,
+	 * and so on until CHANNEL_MAP15.
+	 * Thus, initialize the register size for them only once.
+	 */
+	[AD4170_CHAN_SETUP_REG(0) ... AD4170_CHAN_MAP_REG(AD4170_MAX_CHANNELS - 1)] = 2,
+	/*
+	 * MISC, AFE, FILTER, FILTER_FS, OFFSET, and GAIN register addresses are
+	 * also interleaved but MISC, AFE, FILTER, FILTER_FS, OFFSET are 16-bit
+	 * while OFFSET, GAIN are 24-bit registers so we can't init them all to
+	 * the same size.
+	 */
+	[AD4170_MISC_REG(0) ... AD4170_FILTER_FS_REG(0)] = 2,
+	[AD4170_MISC_REG(1) ... AD4170_FILTER_FS_REG(1)] = 2,
+	[AD4170_MISC_REG(2) ... AD4170_FILTER_FS_REG(2)] = 2,
+	[AD4170_MISC_REG(3) ... AD4170_FILTER_FS_REG(3)] = 2,
+	[AD4170_MISC_REG(4) ... AD4170_FILTER_FS_REG(4)] = 2,
+	[AD4170_MISC_REG(5) ... AD4170_FILTER_FS_REG(5)] = 2,
+	[AD4170_MISC_REG(6) ... AD4170_FILTER_FS_REG(6)] = 2,
+	[AD4170_MISC_REG(7) ... AD4170_FILTER_FS_REG(7)] = 2,
+	[AD4170_OFFSET_REG(0) ... AD4170_GAIN_REG(0)] = 3,
+	[AD4170_OFFSET_REG(1) ... AD4170_GAIN_REG(1)] = 3,
+	[AD4170_OFFSET_REG(2) ... AD4170_GAIN_REG(2)] = 3,
+	[AD4170_OFFSET_REG(3) ... AD4170_GAIN_REG(3)] = 3,
+	[AD4170_OFFSET_REG(4) ... AD4170_GAIN_REG(4)] = 3,
+	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
+	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
+	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+};
+
+enum ad4170_ref_buf {
+	AD4170_REF_BUF_PRE,	/* Pre-charge referrence buffer */
+	AD4170_REF_BUF_FULL,	/* Full referrence buffering */
+	AD4170_REF_BUF_BYPASS	/* Bypass referrence buffering */
+};
+
+enum ad4170_ref_select {
+	AD4170_REF_REFIN1,
+	AD4170_REF_REFIN2,
+	AD4170_REF_REFOUT,
+	AD4170_REF_AVDD
+};
+
+enum ad4170_regulator {
+	AD4170_AVDD_SUP,
+	AD4170_AVSS_SUP,
+	AD4170_IOVDD_SUP,
+	AD4170_REFIN1P_SUP,
+	AD4170_REFIN1N_SUP,
+	AD4170_REFIN2P_SUP,
+	AD4170_REFIN2N_SUP,
+	AD4170_MAX_SUP
+};
+
+enum ad4170_int_pin_sel {
+	AD4170_INT_PIN_SDO,
+	AD4170_INT_PIN_DIG_AUX1,
+};
+
+static const char * const ad4170_int_pin_names[] = {
+	[AD4170_INT_PIN_SDO] = "sdo",
+	[AD4170_INT_PIN_DIG_AUX1] = "dig_aux1",
+};
+
+struct ad4170_chip_info {
+	const char *name;
+};
+
+static const struct ad4170_chip_info ad4170_chip_info = {
+	.name = "ad4170",
+};
+
+static const struct ad4170_chip_info ad4190_chip_info = {
+	.name = "ad4190",
+};
+
+static const struct ad4170_chip_info ad4195_chip_info = {
+	.name = "ad4195",
+};
+
+/*
+ * There are 8 of each MISC, AFE, FILTER, FILTER_FS, OFFSET, and GAIN
+ * configuration registers. That is, there are 8 miscellaneous registers, MISC0
+ * to MISC7. Each MISC register is associated with a setup; MISCN is associated
+ * with setup number N. The other 5 above mentioned types of registers have
+ * analogous structure. A setup is a set of those registers. For example,
+ * setup 1 comprises of MISC1, AFE1, FILTER1, FILTER_FS1, OFFSET1, and GAIN1
+ * registers. Also, there are 16 CHANNEL_SETUP registers (CHANNEL_SETUP0 to
+ * CHANNEL_SETUP15). Each channel setup is associated with one of the 8 possible
+ * setups. Thus, AD4170 can support up to 16 channels but, since there are only
+ * 8 available setups, channels must share settings if more than 8 channels are
+ * configured.
+ *
+ * If this struct is modified, ad4170_setup_eq() will probably need to be
+ * updated too.
+ */
+struct ad4170_setup {
+	u16 misc;
+	u16 afe;
+	u16 filter;
+	u16 filter_fs;
+	u32 offset; /* For calibration purposes */
+	u32 gain; /* For calibration purposes */
+};
+
+struct ad4170_setup_info {
+	struct ad4170_setup setup;
+	unsigned int enabled_channels;
+	unsigned int channels;
+};
+
+struct ad4170_chan_info {
+	unsigned int input_range_uv;
+	unsigned int setup_num; /* Index to access state setup_infos array */
+	struct ad4170_setup setup; /* cached setup */
+	int offset_tbl[10];
+	u32 scale_tbl[10][2];
+	bool initialized;
+	bool enabled;
+};
+
+struct ad4170_state {
+	struct mutex lock; /* Protect read-modify-write and multi write sequences */
+	int vrefs_uv[AD4170_MAX_SUP];
+	u32 mclk_hz;
+	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
+	struct iio_chan_spec chans[AD4170_MAX_CHANNELS];
+	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct completion completion;
+	int pins_fn[AD4170_NUM_ANALOG_PINS];
+	u32 int_pin_sel;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the transfer buffers
+	 * to live in their own cache lines.
+	 */
+	u8 tx_buf[AD4170_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[4];
+};
+
+static int ad4170_debugfs_reg_access(struct iio_dev *indio_dev,
+				     unsigned int reg, unsigned int writeval,
+				     unsigned int *readval)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int ad4170_get_reg_size(struct ad4170_state *st, unsigned int reg,
+			       unsigned int *size)
+{
+	if (reg >= ARRAY_SIZE(ad4170_reg_size))
+		return -EINVAL;
+
+	*size = ad4170_reg_size[reg];
+
+	return 0;
+}
+
+static int ad4170_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct ad4170_state *st = context;
+	unsigned int size;
+	int ret;
+
+	ret = ad4170_get_reg_size(st, reg, &size);
+	if (ret)
+		return ret;
+
+	put_unaligned_be16(reg, st->tx_buf);
+	switch (size) {
+	case 3:
+		put_unaligned_be24(val, &st->tx_buf[2]);
+		break;
+	case 2:
+		put_unaligned_be16(val, &st->tx_buf[2]);
+		break;
+	case 1:
+		st->tx_buf[2] = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return spi_write(st->spi, st->tx_buf, size + 2);
+}
+
+static int ad4170_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct ad4170_state *st = context;
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = st->tx_buf,
+			.len = 2,
+		},
+		{
+			.rx_buf = st->rx_buf,
+		},
+	};
+	unsigned int size;
+	int ret;
+
+	ret = ad4170_get_reg_size(st, reg, &size);
+	if (ret)
+		return ret;
+
+	put_unaligned_be16(AD4170_REG_READ_MASK | reg, st->tx_buf);
+	t[1].len = size;
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret)
+		return ret;
+
+	switch (size) {
+	case 3:
+		*val = get_unaligned_be24(st->rx_buf);
+		return 0;
+	case 2:
+		*val = get_unaligned_be16(st->rx_buf);
+		return 0;
+	case 1:
+		*val = st->rx_buf[0];
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct regmap_config ad4170_regmap_config = {
+	.reg_read = ad4170_reg_read,
+	.reg_write = ad4170_reg_write,
+};
+
+static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
+{
+	/*
+	 * The use of static_assert() here is to make sure that, if
+	 * struct ad4170_setup is ever changed (e.g. a field is added to the
+	 * struct's declaration), the comparison below is adapted to keep
+	 * comparing each of struct ad4170_setup fields.
+	 */
+	static_assert(sizeof(*a) ==
+		      sizeof(struct {
+				     u16 misc;
+				     u16 afe;
+				     u16 filter;
+				     u16 filter_fs;
+				     u32 offset;
+				     u32 gain;
+			     }));
+
+	if (a->misc != b->misc ||
+	    a->afe != b->afe ||
+	    a->filter != b->filter ||
+	    a->filter_fs != b->filter_fs ||
+	    a->offset != b->offset ||
+	    a->gain != b->gain)
+		return false;
+
+	return true;
+}
+
+static int ad4170_find_setup(struct ad4170_state *st,
+			     struct ad4170_setup *target_setup,
+			     unsigned int *setup_num, bool *overwrite)
+{
+	unsigned int i;
+
+	*setup_num = AD4170_INVALID_SETUP;
+	*overwrite = false;
+
+	for (i = 0; i < AD4170_MAX_SETUPS; i++) {
+		struct ad4170_setup_info *setup_info = &st->setup_infos[i];
+
+		/* Immediately accept a matching setup. */
+		if (ad4170_setup_eq(target_setup, &setup_info->setup)) {
+			*setup_num = i;
+			return 0;
+		}
+
+		/* Ignore all setups which are used by enabled channels. */
+		if (setup_info->enabled_channels)
+			continue;
+
+		/* Find the least used slot. */
+		if (*setup_num == AD4170_INVALID_SETUP ||
+		    setup_info->channels < st->setup_infos[*setup_num].channels)
+			*setup_num = i;
+	}
+
+	if (*setup_num == AD4170_INVALID_SETUP)
+		return -EINVAL;
+
+	*overwrite = true;
+	return 0;
+}
+
+static void ad4170_unlink_channel(struct ad4170_state *st, unsigned int channel)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[channel];
+	struct ad4170_setup_info *setup_info = &st->setup_infos[chan_info->setup_num];
+
+	chan_info->setup_num = AD4170_INVALID_SETUP;
+	setup_info->channels--;
+}
+
+static int ad4170_unlink_setup(struct ad4170_state *st, unsigned int setup_num)
+{
+	unsigned int i;
+
+	for (i = 0; i < AD4170_MAX_CHANNELS; i++) {
+		struct ad4170_chan_info *chan_info = &st->chan_infos[i];
+
+		if (!chan_info->initialized || chan_info->setup_num != setup_num)
+			continue;
+
+		ad4170_unlink_channel(st, i);
+	}
+	return 0;
+}
+
+static int ad4170_link_channel_setup(struct ad4170_state *st,
+				     unsigned int chan_addr,
+				     unsigned int setup_num)
+{
+	struct ad4170_setup_info *setup_info = &st->setup_infos[setup_num];
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan_addr];
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, AD4170_CHAN_SETUP_REG(chan_addr),
+				 AD4170_CHAN_SETUP_SETUP_MSK,
+				 FIELD_PREP(AD4170_CHAN_SETUP_SETUP_MSK, setup_num));
+	if (ret)
+		return ret;
+
+	chan_info->setup_num = setup_num;
+	setup_info->channels++;
+	return 0;
+}
+
+static int ad4170_write_setup(struct ad4170_state *st, unsigned int setup_num,
+			      struct ad4170_setup *setup)
+{
+	int ret;
+
+	/*
+	 * It is recommended to place the ADC in standby mode or idle mode to
+	 * write to OFFSET and GAIN registers.
+	 */
+	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
+				 AD4170_ADC_CTRL_MODE_MSK,
+				 FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK,
+					    AD4170_ADC_CTRL_MODE_IDLE));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4170_MISC_REG(setup_num), setup->misc);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4170_AFE_REG(setup_num), setup->afe);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4170_FILTER_REG(setup_num),
+			   setup->filter);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4170_FILTER_FS_REG(setup_num),
+			   setup->filter_fs);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4170_OFFSET_REG(setup_num),
+			   setup->offset);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4170_GAIN_REG(setup_num), setup->gain);
+	if (ret)
+		return ret;
+
+	memcpy(&st->setup_infos[setup_num].setup, setup, sizeof(*setup));
+	return 0;
+}
+
+static int ad4170_write_channel_setup(struct ad4170_state *st,
+				      unsigned int chan_addr, bool on_enable)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan_addr];
+	bool overwrite;
+	int setup_num;
+	int ret;
+
+	/*
+	 * Similar to AD4130 driver, the following cases need to be handled.
+	 *
+	 * 1. Enabled and linked channel with setup changes:
+	 *    - Find a setup. If not possible, return error.
+	 *    - Unlink channel from current setup.
+	 *    - If the setup found has only disabled channels linked to it,
+	 *      unlink all channels, and write the new setup to it.
+	 *    - Link channel to new setup.
+	 *
+	 * 2. Soon to be enabled and unlinked channel:
+	 *    - Find a setup. If not possible, return error.
+	 *    - If the setup found has only disabled channels linked to it,
+	 *      unlink all channels, and write the new setup to it.
+	 *    - Link channel to the setup.
+	 *
+	 * 3. Disabled and linked channel with setup changes:
+	 *    - Unlink channel from current setup.
+	 *
+	 * 4. Soon to be enabled and linked channel:
+	 * 5. Disabled and unlinked channel with setup changes:
+	 *    - Do nothing.
+	 */
+
+	/* Cases 3, 4, and 5 */
+	if (chan_info->setup_num != AD4170_INVALID_SETUP) {
+		/* Case 4 */
+		if (on_enable)
+			return 0;
+
+		/* Case 3 */
+		if (!chan_info->enabled) {
+			ad4170_unlink_channel(st, chan_addr);
+			return 0;
+		}
+	} else if (!on_enable && !chan_info->enabled) {
+		/* Case 5 */
+		return 0;
+	}
+
+	/* Cases 1 & 2 */
+	ret = ad4170_find_setup(st, &chan_info->setup, &setup_num, &overwrite);
+	if (ret)
+		return ret;
+
+	if (chan_info->setup_num != AD4170_INVALID_SETUP)
+		/* Case 1 */
+		ad4170_unlink_channel(st, chan_addr);
+
+	if (overwrite) {
+		ret = ad4170_unlink_setup(st, setup_num);
+		if (ret)
+			return ret;
+
+		ret = ad4170_write_setup(st, setup_num, &chan_info->setup);
+		if (ret)
+			return ret;
+	}
+
+	return ad4170_link_channel_setup(st, chan_addr, setup_num);
+}
+
+static int ad4170_set_channel_enable(struct ad4170_state *st,
+				     unsigned int chan_addr, bool status)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan_addr];
+	struct ad4170_setup_info *setup_info;
+	int ret;
+
+	if (chan_info->enabled == status)
+		return 0;
+
+	if (status) {
+		ret = ad4170_write_channel_setup(st, chan_addr, true);
+		if (ret)
+			return ret;
+	}
+
+	setup_info = &st->setup_infos[chan_info->setup_num];
+
+	ret = regmap_update_bits(st->regmap, AD4170_CHAN_EN_REG,
+				 AD4170_CHAN_EN(chan_addr),
+				 status ? AD4170_CHAN_EN(chan_addr) : 0);
+	if (ret)
+		return ret;
+
+	setup_info->enabled_channels += status ? 1 : -1;
+	chan_info->enabled = status;
+	return 0;
+}
+
+static const struct iio_chan_spec ad4170_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.differential = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_OFFSET),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+	.scan_type = {
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_BE,
+	},
+};
+
+/*
+ * Receives the number of a multiplexed AD4170 input (ain_n), and stores the
+ * voltage (in µV) of the specified input into ain_voltage. If the input number
+ * is a ordinary analog input (AIN0 to AIN8), stores zero into ain_voltage.
+ * If a voltage regulator required by a special input is unavailable, return
+ * error code. Return 0 on success.
+ */
+static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
+				     int *ain_voltage)
+{
+	struct device *dev = &st->spi->dev;
+	int v_diff;
+
+	*ain_voltage = 0;
+	if (ain_n <= AD4170_CHAN_MAP_TEMP_SENSOR)
+		return 0;
+
+	switch (ain_n) {
+	case AD4170_CHAN_MAP_AVDD_AVSS_N:
+		v_diff = st->vrefs_uv[AD4170_AVDD_SUP] - st->vrefs_uv[AD4170_AVSS_SUP];
+		*ain_voltage = v_diff / 5;
+		return 0;
+	case AD4170_CHAN_MAP_IOVDD_DGND_N:
+		*ain_voltage = st->vrefs_uv[AD4170_IOVDD_SUP] / 5;
+		return 0;
+	case AD4170_CHAN_MAP_AVSS:
+		*ain_voltage = st->vrefs_uv[AD4170_AVSS_SUP];
+		return 0;
+	case AD4170_CHAN_MAP_DGND:
+		*ain_voltage = 0;
+		return 0;
+	case AD4170_CHAN_MAP_REFIN1_P:
+		if (st->vrefs_uv[AD4170_REFIN1P_SUP] == -ENODEV)
+			return dev_err_probe(dev, -ENODEV,
+					     "input set to REFIN+ but ref not provided\n");
+
+		*ain_voltage = st->vrefs_uv[AD4170_REFIN1P_SUP];
+		return 0;
+	case AD4170_CHAN_MAP_REFIN1_N:
+		if (st->vrefs_uv[AD4170_REFIN1N_SUP] == -ENODEV)
+			return dev_err_probe(dev, -ENODEV,
+					     "input set to REFIN- but ref not provided\n");
+
+		*ain_voltage = st->vrefs_uv[AD4170_REFIN1N_SUP];
+		return 0;
+	case AD4170_CHAN_MAP_REFIN2_P:
+		if (st->vrefs_uv[AD4170_REFIN2P_SUP] == -ENODEV)
+			return dev_err_probe(dev, -ENODEV,
+					     "input set to REFIN2+ but ref not provided\n");
+
+		*ain_voltage = st->vrefs_uv[AD4170_REFIN2P_SUP];
+		return 0;
+	case AD4170_CHAN_MAP_REFIN2_N:
+		if (st->vrefs_uv[AD4170_REFIN2N_SUP] == -ENODEV)
+			return dev_err_probe(dev, -ENODEV,
+					     "input set to REFIN2- but ref not provided\n");
+
+		*ain_voltage = st->vrefs_uv[AD4170_REFIN2N_SUP];
+		return 0;
+	case AD4170_CHAN_MAP_REFOUT:
+		/* REFOUT is 2.5V relative to AVSS so take that into account */
+		*ain_voltage = st->vrefs_uv[AD4170_AVSS_SUP] + AD4170_INT_REF_2_5V;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4170_validate_channel_input(struct ad4170_state *st, int pin, bool com)
+{
+	/* Check common-mode input pin is mapped to a special input. */
+	if (com && (pin < AD4170_CHAN_MAP_AVDD_AVSS_P || pin > AD4170_CHAN_MAP_REFOUT))
+		return dev_err_probe(&st->spi->dev, -EINVAL,
+				     "Invalid common-mode input pin number. %d\n",
+				     pin);
+
+	/* Check differential input pin is mapped to a analog input pin. */
+	if (!com && pin > AD4170_MAX_ANALOG_PINS)
+		return dev_err_probe(&st->spi->dev, -EINVAL,
+				     "Invalid analog input pin number. %d\n",
+				     pin);
+
+	return 0;
+}
+
+/*
+ * Verifies whether the channel input configuration is valid by checking the
+ * input numbers.
+ * Returns 0 on valid channel input configuration. -EINVAL otherwise.
+ */
+static int ad4170_validate_channel(struct ad4170_state *st,
+				   struct iio_chan_spec const *chan)
+{
+	int ret;
+
+	ret = ad4170_validate_channel_input(st, chan->channel, false);
+	if (ret)
+		return ret;
+
+	return ad4170_validate_channel_input(st, chan->channel2,
+					     !chan->differential);
+}
+
+/*
+ * Verifies whether the channel configuration is valid by checking the provided
+ * input type, polarity, and voltage references result in a sane input range.
+ * Returns negative error code on failure.
+ */
+static int ad4170_get_input_range(struct ad4170_state *st,
+				  struct iio_chan_spec const *chan,
+				  unsigned int ch_reg, unsigned int ref_sel)
+{
+	bool bipolar = chan->scan_type.sign == 's';
+	struct device *dev = &st->spi->dev;
+	int refp, refn, ain_voltage, ret;
+
+	switch (ref_sel) {
+	case AD4170_REF_REFIN1:
+		if (st->vrefs_uv[AD4170_REFIN1P_SUP] == -ENODEV ||
+		    st->vrefs_uv[AD4170_REFIN1N_SUP] == -ENODEV)
+			return dev_err_probe(dev, -ENODEV,
+					     "REFIN± selected but not provided\n");
+
+		refp = st->vrefs_uv[AD4170_REFIN1P_SUP];
+		refn = st->vrefs_uv[AD4170_REFIN1N_SUP];
+		break;
+	case AD4170_REF_REFIN2:
+		if (st->vrefs_uv[AD4170_REFIN2P_SUP] == -ENODEV ||
+		    st->vrefs_uv[AD4170_REFIN2N_SUP] == -ENODEV)
+			return dev_err_probe(dev, -ENODEV,
+					     "REFIN2± selected but not provided\n");
+
+		refp = st->vrefs_uv[AD4170_REFIN2P_SUP];
+		refn = st->vrefs_uv[AD4170_REFIN2N_SUP];
+		break;
+	case AD4170_REF_AVDD:
+		refp = st->vrefs_uv[AD4170_AVDD_SUP];
+		refn = st->vrefs_uv[AD4170_AVSS_SUP];
+		break;
+	case AD4170_REF_REFOUT:
+		/* REFOUT is 2.5 V relative to AVSS */
+		refp = st->vrefs_uv[AD4170_AVSS_SUP] + AD4170_INT_REF_2_5V;
+		refn = st->vrefs_uv[AD4170_AVSS_SUP];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Find out the analog input range from the channel type, polarity, and
+	 * voltage reference selection.
+	 * AD4170 channels are either differential or pseudo-differential.
+	 * Diff input voltage range: −VREF/gain to +VREF/gain (datasheet page 6)
+	 * Pseudo-diff input voltage range: 0 to VREF/gain (datasheet page 6)
+	 */
+	if (chan->differential) {
+		if (!bipolar)
+			return dev_err_probe(dev, -EINVAL,
+					     "Channel %u differential unipolar\n",
+					     ch_reg);
+
+		/*
+		 * Differential bipolar channel.
+		 * avss-supply is never above 0V.
+		 * Assuming refin1n-supply not above 0V.
+		 * Assuming refin2n-supply not above 0V.
+		 */
+		return refp + abs(refn);
+	}
+	/*
+	 * Some configurations can lead to invalid setups.
+	 * For example, if AVSS = -2.5V, REF_SELECT set to REFOUT (REFOUT/AVSS),
+	 * and pseudo-diff channel configuration set, then the input range
+	 * should go from 0V to +VREF (single-ended - datasheet pg 10), but
+	 * REFOUT/AVSS range would be -2.5V to 0V.
+	 * Check the positive reference is higher than 0V for pseudo-diff
+	 * channels.
+	 */
+	if (refp <= 0)
+		return dev_err_probe(dev, -EINVAL,
+				     "REF+ <= GND for pseudo-diff chan %u\n",
+				     ch_reg);
+
+	if (bipolar)
+		return refp;
+
+	/*
+	 * Pseudo-differential unipolar channel.
+	 * Input expected to swing from IN- to +VREF.
+	 */
+	ret = ad4170_get_ain_voltage_uv(st, chan->channel2, &ain_voltage);
+	if (ret)
+		return ret;
+
+	if (refp - ain_voltage <= 0)
+		return dev_err_probe(dev, -EINVAL,
+				     "Negative input >= REF+ for pseudo-diff chan %u\n",
+				     ch_reg);
+
+	return refp - ain_voltage;
+}
+
+static int __ad4170_read_sample(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int *val)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	unsigned long settling_time_ms;
+	int ret;
+
+	reinit_completion(&st->completion);
+	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
+				 AD4170_ADC_CTRL_MODE_MSK,
+				 FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK,
+					    AD4170_ADC_CTRL_MODE_SINGLE));
+	if (ret)
+		return ret;
+
+	/*
+	 * When a channel is manually selected by the user, the ADC needs an
+	 * extra time to provide the first stable conversion. The ADC settling
+	 * time depends on the filter type, filter frequency, and ADC clock
+	 * frequency (see datasheet page 53). The maximum settling time among
+	 * all filter configurations is 6291164 / fCLK. Use that formula to wait
+	 * for sufficient time whatever the filter configuration may be.
+	 */
+	settling_time_ms = DIV_ROUND_UP(6291164 * MILLI, st->mclk_hz);
+	ret = wait_for_completion_timeout(&st->completion,
+					  msecs_to_jiffies(settling_time_ms));
+	if (!ret)
+		dev_dbg(&st->spi->dev,
+			"No Data Ready signal. Reading after delay.\n");
+
+	ret = regmap_read(st->regmap, AD4170_DATA_24B_REG, val);
+	if (ret)
+		return ret;
+
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(*val, chan->scan_type.realbits - 1);
+
+	return 0;
+}
+
+static int ad4170_read_sample(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int *val)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	int ret, ret2;
+
+	/*
+	 * The ADC sequences through all enabled channels. That can lead to
+	 * incorrect channel being sampled if a previous read would have left a
+	 * different channel enabled. Thus, always enable and disable the
+	 * channel on single-shot read.
+	 */
+	ret = ad4170_set_channel_enable(st, chan->address, true);
+	if (ret)
+		return ret;
+
+	ret = __ad4170_read_sample(indio_dev, chan, val);
+	if (ret) {
+		dev_err(dev, "failed to read sample: %d\n", ret);
+
+		ret2 = ad4170_set_channel_enable(st, chan->address, false);
+		if (ret2)
+			dev_err(dev, "failed to disable channel: %d\n", ret2);
+
+		return ret;
+	}
+
+	ret = ad4170_set_channel_enable(st, chan->address, false);
+	if (ret)
+		return ret;
+
+	return IIO_VAL_INT;
+}
+
+static int ad4170_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	unsigned int pga;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ad4170_read_sample(indio_dev, chan, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
+		*val = chan_info->scale_tbl[pga][0];
+		*val2 = chan_info->scale_tbl[pga][1];
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
+		*val = chan_info->offset_tbl[pga];
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4170_fill_scale_tbl(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct device *dev = &st->spi->dev;
+	int bipolar = chan->scan_type.sign == 's' ? 1 : 0;
+	int precision_bits = chan->scan_type.realbits;
+	int pga, ainm_voltage, ret;
+	unsigned long long offset;
+
+	ainm_voltage = 0;
+	ret = ad4170_get_ain_voltage_uv(st, chan->channel2, &ainm_voltage);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to fill scale table\n");
+
+	for (pga = 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {
+		u64 nv;
+		unsigned int lshift, rshift;
+
+		/*
+		 * The PGA options are numbered from 0 to 9, with option 0 being
+		 * a gain of 2^0 (no actual gain), and 7 meaning a gain of 2^7.
+		 * Option 8, though, sets a gain of 0.5, so the input signal can
+		 * be attenuated by 2 rather than amplified. Option 9, allows
+		 * the signal to bypass the PGA circuitry (no gain).
+		 *
+		 * The scale factor to get ADC output codes to values in mV
+		 * units is given by:
+		 * _scale = (input_range / gain) / 2^precision
+		 * AD4170 gain is a power of 2 so the above can be written as
+		 * _scale = input_range / 2^(precision + gain)
+		 * Keep the input range in µV to avoid truncating the less
+		 * significan bits when right shifting it so to preserve scale
+		 * precision.
+		 */
+		nv = (u64)chan_info->input_range_uv * NANO;
+		lshift = !!(pga & BIT(3)); /* handle options 8 and 9 */
+		rshift = precision_bits - bipolar + (pga & GENMASK(2, 0)) - lshift;
+		chan_info->scale_tbl[pga][0] = 0;
+		chan_info->scale_tbl[pga][1] = div_u64(nv >> rshift, MILLI);
+
+		/*
+		 * If the negative input is not at GND, the conversion result
+		 * (which is relative to IN-) will be offset by the level at IN-.
+		 * Use the scale factor the other way around to go from a known
+		 * voltage to the corresponding ADC output code.
+		 * With that, we are able to get to what would be the output
+		 * code for the voltage at the negative input.
+		 * If the negative input is not fixed, there is no offset.
+		 */
+		offset = ((unsigned long long)abs(ainm_voltage)) * MICRO;
+		offset = DIV_ROUND_CLOSEST_ULL(offset, chan_info->scale_tbl[pga][1]);
+
+		/*
+		 * After divided by the scale, offset will always fit into 31
+		 * bits. For _raw + _offset to be relative to GND, the value
+		 * provided as _offset is of opposite sign than the real offset.
+		 */
+		if (ainm_voltage > 0)
+			chan_info->offset_tbl[pga] = -(int)(offset);
+		else
+			chan_info->offset_tbl[pga] = (int)(offset);
+	}
+	return 0;
+}
+
+static int ad4170_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)chan_info->scale_tbl;
+		*length = ARRAY_SIZE(chan_info->scale_tbl) * 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4170_set_pga(struct ad4170_state *st,
+			  struct iio_chan_spec const *chan, int val, int val2)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	unsigned int pga;
+
+	for (pga = 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {
+		if (val == chan_info->scale_tbl[pga][0] &&
+		    val2 == chan_info->scale_tbl[pga][1])
+			break;
+	}
+
+	if (pga == AD4170_NUM_PGA_OPTIONS)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	setup->afe &= ~AD4170_AFE_PGA_GAIN_MSK;
+	setup->afe |= FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, pga);
+
+	return ad4170_write_channel_setup(st, chan->address, false);
+}
+
+static int __ad4170_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long info)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad4170_set_pga(st, chan, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4170_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long info)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = __ad4170_write_raw(indio_dev, chan, val, val2, info);
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad4170_info = {
+	.read_raw = ad4170_read_raw,
+	.read_avail = ad4170_read_avail,
+	.write_raw = ad4170_write_raw,
+	.write_raw_get_fmt = ad4170_write_raw_get_fmt,
+	.debugfs_reg_access = ad4170_debugfs_reg_access,
+};
+
+static int ad4170_soft_reset(struct ad4170_state *st)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4170_CONFIG_A_REG,
+			   AD4170_SW_RESET_MSK);
+	if (ret)
+		return ret;
+
+	/* AD4170-4 requires 1 ms between reset and any register access. */
+	fsleep(1 * USEC_PER_MSEC);
+
+	return 0;
+}
+
+static int ad4170_parse_reference(struct ad4170_state *st,
+				  struct fwnode_handle *child,
+				  struct ad4170_setup *setup)
+{
+	struct device *dev = &st->spi->dev;
+	u32 aux;
+
+	/* Optional positive reference buffering */
+	aux = AD4170_REF_BUF_FULL; /* Default to full precharge buffer enabled. */
+	fwnode_property_read_u32(child, "adi,positive-reference-buffer", &aux);
+	if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid adi,positive-reference-buffer: %u\n",
+				     aux);
+
+	setup->afe |= FIELD_PREP(AD4170_AFE_REF_BUF_P_MSK, aux);
+
+	/* Optional negative reference buffering */
+	aux = AD4170_REF_BUF_FULL; /* Default to full precharge buffer enabled. */
+	fwnode_property_read_u32(child, "adi,negative-reference-buffer", &aux);
+	if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid adi,negative-reference-buffer: %u\n",
+				     aux);
+
+	setup->afe |= FIELD_PREP(AD4170_AFE_REF_BUF_M_MSK, aux);
+
+	/* Optional voltage reference selection */
+	aux = AD4170_REF_REFOUT; /* Default reference selection. */
+	fwnode_property_read_u32(child, "adi,reference-select", &aux);
+	if (aux > AD4170_REF_AVDD)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid reference selected %u\n",
+				     aux);
+
+	setup->afe |= FIELD_PREP(AD4170_AFE_REF_SELECT_MSK, aux);
+
+	return 0;
+}
+
+static int ad4170_parse_adc_channel_type(struct device *dev,
+					 struct fwnode_handle *child,
+					 struct iio_chan_spec *chan)
+{
+	int ret, ret2;
+	u32 pins[2];
+
+	/* Parse pseudo-differential channel configuration */
+	ret = fwnode_property_read_u32(child, "single-channel", &pins[0]);
+	ret2 = fwnode_property_read_u32(child, "common-mode-channel", &pins[1]);
+	if (!ret && ret2)
+		return dev_err_probe(dev, ret,
+			"single-ended channels must define common-mode-channel\n");
+
+	if (!ret && !ret2) {
+		chan->differential = false;
+		chan->channel = pins[0];
+		chan->channel2 = pins[1];
+		return 0;
+	}
+	/* Failed to parse pseudo-diff chan props so try diff chan */
+
+	/* Parse differential channel configuration */
+	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
+					     ARRAY_SIZE(pins));
+	if (!ret) {
+		chan->differential = true;
+		chan->channel = pins[0];
+		chan->channel2 = pins[1];
+		return 0;
+	}
+	return dev_err_probe(dev, ret,
+		"Channel must define one of diff-channels or single-channel.\n");
+}
+
+static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
+				     struct fwnode_handle *child,
+				     unsigned int chan_num)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	struct ad4170_chan_info *chan_info;
+	struct ad4170_setup *setup;
+	struct iio_chan_spec *chan;
+	unsigned int ref_select;
+	unsigned int ch_reg;
+	bool bipolar;
+	int ret;
+
+	ret = fwnode_property_read_u32(child, "reg", &ch_reg);
+	if (ret)
+		return dev_err_probe(dev, -EINVAL,
+				     "Failed to read channel reg\n");
+
+	if (ch_reg >= AD4170_MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Channel idx greater than no of channels\n");
+
+	chan = &st->chans[chan_num];
+	*chan = ad4170_channel_template;
+
+	chan->address = ch_reg;
+	chan->scan_index = ch_reg;
+	chan_info = &st->chan_infos[chan->address];
+
+	chan_info->setup_num = AD4170_INVALID_SETUP;
+	chan_info->initialized = true;
+
+	setup = &chan_info->setup;
+	ret = ad4170_parse_reference(st, child, setup);
+	if (ret)
+		return ret;
+
+	ret = ad4170_parse_adc_channel_type(dev, child, chan);
+	if (ret < 0)
+		return ret;
+
+	bipolar = fwnode_property_read_bool(child, "bipolar");
+	setup->afe |= FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
+	if (bipolar)
+		chan->scan_type.sign = 's';
+	else
+		chan->scan_type.sign = 'u';
+
+	ret = ad4170_validate_channel(st, chan);
+	if (ret < 0)
+		return ret;
+
+	ref_select = FIELD_GET(AD4170_AFE_REF_SELECT_MSK, setup->afe);
+	ret = ad4170_get_input_range(st, chan, ch_reg, ref_select);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Invalid input config\n");
+
+	chan_info->input_range_uv = ret;
+	return 0;
+}
+
+static int ad4170_parse_channels(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	unsigned int num_channels;
+	unsigned int chan_num = 0;
+	int ret;
+
+	num_channels = device_get_child_node_count(dev);
+
+	if (num_channels > AD4170_MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = ad4170_parse_channel_node(indio_dev, child, chan_num++);
+		if (ret)
+			return ret;
+	}
+
+	indio_dev->num_channels = num_channels;
+	indio_dev->channels = st->chans;
+
+	return 0;
+}
+
+static int ad4170_parse_firmware(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	int reg_data, ret;
+
+	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+
+	/* On power on, device defaults to using SDO pin for data ready signal */
+	st->int_pin_sel = AD4170_INT_PIN_SDO;
+	ret = device_property_match_property_string(dev, "interrupt-names",
+						    ad4170_int_pin_names,
+						    ARRAY_SIZE(ad4170_int_pin_names));
+	if (ret >= 0)
+		st->int_pin_sel = ret;
+
+	reg_data = FIELD_PREP(AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK,
+			      st->int_pin_sel == AD4170_INT_PIN_DIG_AUX1 ?
+			      AD4170_PIN_MUXING_DIG_AUX1_RDY :
+			      AD4170_PIN_MUXING_DIG_AUX1_DISABLED);
+
+	ret = regmap_update_bits(st->regmap, AD4170_PIN_MUXING_REG,
+				 AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK, reg_data);
+	if (ret)
+		return ret;
+
+	return ad4170_parse_channels(indio_dev);
+}
+
+static int ad4170_initial_config(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	unsigned int i;
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
+				 AD4170_ADC_CTRL_MODE_MSK,
+				 FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK,
+					    AD4170_ADC_CTRL_MODE_IDLE));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set ADC mode to idle\n");
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		struct ad4170_chan_info *chan_info;
+		struct iio_chan_spec const *chan;
+		struct ad4170_setup *setup;
+		unsigned int val;
+
+		chan = &indio_dev->channels[i];
+		chan_info = &st->chan_infos[chan->address];
+
+		setup = &chan_info->setup;
+		setup->gain = AD4170_GAIN_REG_DEFAULT;
+		ret = ad4170_write_channel_setup(st, chan->address, false);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to write channel setup\n");
+
+		val = FIELD_PREP(AD4170_CHAN_MAP_AINP_MSK, chan->channel) |
+		      FIELD_PREP(AD4170_CHAN_MAP_AINM_MSK, chan->channel2);
+
+		ret = regmap_write(st->regmap, AD4170_CHAN_MAP_REG(i), val);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to write CHAN_MAP_REG\n");
+
+		ret = ad4170_fill_scale_tbl(indio_dev, chan);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to fill scale tbl\n");
+	}
+
+	/* Disable all channels to avoid reading from unexpected channel */
+	ret = regmap_write(st->regmap, AD4170_CHAN_EN_REG, 0);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to disable channels\n");
+
+	/*
+	 * Configure channels to share the same data output register, i.e. data
+	 * can be read from the same register address regardless of channel
+	 * number.
+	 */
+	return regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
+				 AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK,
+				 AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK);
+}
+
+static irqreturn_t ad4170_irq_handler(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct ad4170_state *st = iio_priv(indio_dev);
+
+	complete(&st->completion);
+
+	return IRQ_HANDLED;
+};
+
+static int ad4170_regulator_setup(struct ad4170_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	/* Required regulators */
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get AVDD voltage.\n");
+
+	st->vrefs_uv[AD4170_AVDD_SUP] = ret;
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "iovdd");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get IOVDD voltage.\n");
+
+	st->vrefs_uv[AD4170_IOVDD_SUP] = ret;
+
+	/* Optional regulators */
+	ret = devm_regulator_get_enable_read_voltage(dev, "avss");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get AVSS voltage.\n");
+
+	/* Assume AVSS at GND (0V) if not provided */
+	st->vrefs_uv[AD4170_AVSS_SUP] = ret == -ENODEV ? 0 : -ret;
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin1p");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get REFIN+ voltage.\n");
+
+	st->vrefs_uv[AD4170_REFIN1P_SUP] = ret;
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin1n");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get REFIN- voltage.\n");
+
+	/* Negative supplies are assumed to provide negative voltage */
+	st->vrefs_uv[AD4170_REFIN1N_SUP] = ret == -ENODEV ? -ENODEV : -ret;
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin2p");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get REFIN2+ voltage.\n");
+
+	st->vrefs_uv[AD4170_REFIN2P_SUP] = ret;
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin2n");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get REFIN2- voltage.\n");
+
+	/* Negative supplies are assumed to provide negative voltage */
+	st->vrefs_uv[AD4170_REFIN2N_SUP] = ret == -ENODEV ? -ENODEV : -ret;
+
+	return 0;
+}
+
+static int ad4170_probe(struct spi_device *spi)
+{
+	const struct ad4170_chip_info *chip;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad4170_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
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
+	chip = spi_get_device_match_data(spi);
+	if (!chip)
+		return -EINVAL;
+
+	indio_dev->name = chip->name;
+	indio_dev->info = &ad4170_info;
+
+	st->regmap = devm_regmap_init(dev, NULL, st, &ad4170_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
+
+	ret = ad4170_regulator_setup(st);
+	if (ret)
+		return ret;
+
+	ret = ad4170_soft_reset(st);
+	if (ret)
+		return ret;
+
+	ret = ad4170_parse_firmware(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to parse firmware\n");
+
+	ret = ad4170_initial_config(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup device\n");
+
+	init_completion(&st->completion);
+
+	if (spi->irq) {
+		ret = devm_request_irq(dev, spi->irq, &ad4170_irq_handler,
+				       IRQF_ONESHOT, indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id ad4170_id_table[] = {
+	{ "ad4170", (kernel_ulong_t)&ad4170_chip_info },
+	{ "ad4190", (kernel_ulong_t)&ad4190_chip_info },
+	{ "ad4195", (kernel_ulong_t)&ad4195_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4170_id_table);
+
+static const struct of_device_id ad4170_of_match[] = {
+	{ .compatible = "adi,ad4170", .data = &ad4170_chip_info },
+	{ .compatible = "adi,ad4190", .data = &ad4190_chip_info },
+	{ .compatible = "adi,ad4195", .data = &ad4195_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4170_of_match);
+
+static struct spi_driver ad4170_driver = {
+	.driver = {
+		.name = "ad4170",
+		.of_match_table = ad4170_of_match,
+	},
+	.probe = ad4170_probe,
+	.id_table = ad4170_id_table,
+};
+module_spi_driver(ad4170_driver);
+
+MODULE_AUTHOR("Ana-Maria Cusco <ana-maria.cusco@analog.com>");
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4170 SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.47.2


