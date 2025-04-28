Return-Path: <linux-iio+bounces-18771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3417BA9F0A9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 14:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB585A3536
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAFF269AE7;
	Mon, 28 Apr 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QfXQ/b6a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B5268C41;
	Mon, 28 Apr 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843323; cv=none; b=CchK9V32tsTn/nZ2G2FU0/61cp/84V4JgAKUdrzAPQpwCNd/jNcOnEEdXEybW7IEyCayJfmHKKyPTsqD0oL1TGXiAOdQKcvrTxw+TSTB29WrPLTjPQyADyRZZvOF43ErExHYZfTRDhxDJ6jPVRAMILOdrEmVwchgkq4aDCYKeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843323; c=relaxed/simple;
	bh=gwZaewwq6BW/w1QlAAmvJbBKusg/8/gYbqzPUpLiTNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twKaCKEwFbMuRvLqxowzokFaGyBUu50iRd+MMpr2zXk+v4xDy6gfMZwzI7hCln6W5qLl2R3p3xt10C51oBduGoQevYBsFeTkmo8r6h0CLnAP4gDjt6SKShJEHqOwE1cIoP3yE7A9JDR1vVgNhzrUeix2sKZ3TgLspyRNB2jbBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QfXQ/b6a; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SCNmr1027375;
	Mon, 28 Apr 2025 08:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=l4ejH
	8A1DdSasesBKkUE6hKPZEitBKwHroFYZss9CzU=; b=QfXQ/b6asjvYycqsz3WOG
	8DJnc3DQ63zrnl21PENfTqn+5eYMMuFlkc38A93f3PQOMHPgvZgtxtdbz9mOnXTx
	nvCBaOKtKu4BViODX2dTytryr4g2KrpJyytqaLxsAj6YtqGWpWNGqII4PS7nFnF7
	aueegQSBZNPl+DA3XFDuiatmBXKfTu/Piugvead7iMQ2LOeUvJ70jD9eEqVVinIV
	BWigSA1qcZI8RT+MQ0bgHw452CoXZtQ/aQ6YsD2/mjUwoe5IqEVxT//yHpZZtMn6
	W1OF/FOzuQ5TUvcDwvHCHXLVxyLWhjMjFGyETTEbig5UhnRJ0tzTgTVr+ZMOr2t7
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgh6bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 08:28:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53SCSJVs038115
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 08:28:19 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 08:28:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 08:28:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 08:28:19 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53SCS4b6032512;
	Mon, 28 Apr 2025 08:28:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ana-Maria Cusco <ana-maria.cusco@analog.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 2/7] iio: adc: Add basic support for AD4170
Date: Mon, 28 Apr 2025 09:28:03 -0300
Message-ID: <01ac3a81f9aa7f1fe48478ff60c0033dd02aefb1.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEwMiBTYWx0ZWRfX1sowzl6hY9TU TQM/hsxFFA3mMh1pe7Yr0MjyxhJh3k/mh7S59v00EQ7YgC+dWfIhE0qWD0ERoGD0fVRrZgY/A72 pIe3BgCLmkywLAiSBrH57z7m4K52Z+4VB0cd0nw8QTNl++83xkV9dfB3g9DGSdG1iKWha/3md7b
 0uFmcwGt6JD4soYONv5q/vCo8N14eTOhnuHLP9WN236UdyOa+wX2lIq4Teq3+nw5I+0ZMme5nqI jxTM66BZCPyOnfUcfS5ukfmAce6OuJLpd8j9/UN6ueYDnptamKNZ2thyuFLDxO/g0Rd46PMjOHu 8/PHLcXgsoKW2jPkTJfKMY56iUJpj43TjWKDohD0+ts2QEY5BA4kcRpQARiUG6Rt3agsyizAR13
 g3Y92pAQ5DDix8flHcBTcmMYweqYQr3S72Fk8Syg3436yAD4vHeDFnhcV97a20jIPNhT7OCK
X-Proofpoint-ORIG-GUID: JNxfWEIsJMDqQSsSXpwjqw1oE-5wFX4x
X-Proofpoint-GUID: JNxfWEIsJMDqQSsSXpwjqw1oE-5wFX4x
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680f7465 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=ATOk87ZngED3yrVVWyUA:9 a=LQQa1AT6e60pgmaU:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504280102

From: Ana-Maria Cusco <ana-maria.cusco@analog.com>

Add support for the AD4170 ADC with the following features:
- Single-shot read.
- Analog front end PGA configuration.
- Digital filter and sampling frequency configuration.
- Calibration gain and offset configuration.
- Differential and pseudo-differential input configuration.

Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
changes since v1
- Replaced 3 regmap configs by regmap with custom reg_read/write implementation.

 MAINTAINERS              |    1 +
 drivers/iio/adc/Kconfig  |   12 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad4170.c | 1888 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 1902 insertions(+)
 create mode 100644 drivers/iio/adc/ad4170.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 991b6e2e373a..56cd87028dfd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1343,6 +1343,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
+F:	drivers/iio/adc/ad4170.c
 
 ANALOG DEVICES INC AD4695 DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 636469392945..d5d0308da007 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -70,6 +70,18 @@ config AD4130
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
index 07d4b832c42e..d3a1376d1f96 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4030) += ad4030.o
 obj-$(CONFIG_AD4130) += ad4130.o
+obj-$(CONFIG_AD4170) += ad4170.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD4851) += ad4851.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
new file mode 100644
index 000000000000..4d0af15cb48d
--- /dev/null
+++ b/drivers/iio/adc/ad4170.c
@@ -0,0 +1,1888 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Analog Devices, Inc.
+ * Author: Ana-Maria Cusco <ana-maria.cusco@analog.com>
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
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
+ * E.g. AD4170_PIN_MUXING_DIG_AUX2_CTRL_MSK is for accessing DIG_AUX2_CTRL field
+ * of PIN_MUXING_REG.
+ * Each constant follows the AD4170_<REG_NAME>_<FIELD_NAME>_<FUNCTION> form.
+ * E.g. AD4170_PIN_MUXING_DIG_AUX2_DISABLED is the value written to
+ * DIG_AUX2_CTRL field of PIN_MUXING register to disable DIG_AUX2 pin.
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
+#define AD4170_PIN_MUXING_DIG_AUX2_CTRL_MSK		GENMASK(7, 6)
+#define AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK		GENMASK(5, 4)
+#define AD4170_PIN_MUXING_SYNC_CTRL_MSK			GENMASK(3, 2)
+
+/* AD4170_ADC_CTRL_REG */
+#define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
+#define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
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
+/* AD4170_MISC_REG */
+#define AD4170_MISC_CHOP_IEXC_MSK			GENMASK(15, 14)
+#define AD4170_MISC_CHOP_ADC_MSK			GENMASK(9, 8)
+#define AD4170_MISC_BURNOUT_MSK				GENMASK(1, 0)
+
+/* AD4170_AFE_REG */
+#define AD4170_AFE_REF_BUF_M_MSK			GENMASK(11, 10)
+#define AD4170_AFE_REF_BUF_P_MSK			GENMASK(9, 8)
+#define AD4170_AFE_REF_SELECT_MSK			GENMASK(6, 5)
+#define AD4170_AFE_BIPOLAR_MSK				BIT(4)
+#define AD4170_AFE_PGA_GAIN_MSK				GENMASK(3, 0)
+
+/* AD4170_FILTER_REG */
+#define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
+
+/* AD4170 register constants */
+
+/* AD4170_CHAN_MAP_REG constants */
+#define AD4170_CHAN_MAP_AIN0			0
+#define AD4170_CHAN_MAP_AIN1			1
+#define AD4170_CHAN_MAP_AIN2			2
+#define AD4170_CHAN_MAP_AIN3			3
+#define AD4170_CHAN_MAP_AIN4			4
+#define AD4170_CHAN_MAP_AIN5			5
+#define AD4170_CHAN_MAP_AIN6			6
+#define AD4170_CHAN_MAP_AIN7			7
+#define AD4170_CHAN_MAP_AIN8			8
+#define AD4170_CHAN_MAP_TEMP_SENSOR		17
+#define AD4170_CHAN_MAP_AVDD_AVSS_P		18
+#define AD4170_CHAN_MAP_AVDD_AVSS_N		18
+#define AD4170_CHAN_MAP_IOVDD_DGND_P		19
+#define AD4170_CHAN_MAP_IOVDD_DGND_N		19
+#define AD4170_CHAN_MAP_DAC_P			20
+#define AD4170_CHAN_MAP_DAC_N			20
+#define AD4170_CHAN_MAP_ALDO			21
+#define AD4170_CHAN_MAP_DLDO			22
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
+#define AD4170_PIN_MUXING_DIG_AUX1_SYNC			0x2
+
+#define AD4170_PIN_MUXING_DIG_AUX2_DISABLED		0x0
+#define AD4170_PIN_MUXING_DIG_AUX2_LDAC			0x1
+#define AD4170_PIN_MUXING_DIG_AUX2_SYNC			0x2
+
+#define AD4170_PIN_MUXING_SYNC_DISABLED			0x0
+#define AD4170_PIN_MUXING_SYNC_STANDARD			0x1
+#define AD4170_PIN_MUXING_SYNC_ALTERNATE		0x2
+
+/* AD4170_ADC_CTRL_REG constants */
+#define AD4170_ADC_CTRL_CONT_READ_DISABLE		0x0
+#define AD4170_ADC_CTRL_CONT_READ_ENABLE		0x1
+
+#define AD4170_ADC_CTRL_MODE_CONT			0x0
+#define AD4170_ADC_CTRL_MODE_SINGLE			0x4
+#define AD4170_ADC_CTRL_MODE_IDLE			0x7
+
+/* AD4170_FILTER_REG constants */
+#define AD4170_FILTER_FILTER_TYPE_SINC5_AVG		0x0
+#define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
+#define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
+
+/* Device properties and auxiliary constants */
+
+#define AD4170_NUM_ANALOG_PINS				9
+#define AD4170_MAX_CHANNELS				16
+#define AD4170_MAX_ANALOG_PINS				8
+#define AD4170_MAX_SETUPS				8
+#define AD4170_INVALID_SETUP				9
+#define AD4170_SPI_MAX_XFER_LEN				6
+#define AD4170_NUM_CURRENT_SRC				4
+#define AD4170_DEFAULT_SAMP_RATE			(125 * KILO)
+
+/* Internal and external clock properties */
+#define AD4170_INT_CLOCK_16MHZ				(16 * MEGA)
+#define AD4170_EXT_CLOCK_MHZ_MIN			(1 * MEGA)
+#define AD4170_EXT_CLOCK_MHZ_MAX			(17 * MEGA)
+
+#define AD4170_NUM_PGA_OPTIONS				10
+
+/* Digital filter properties */
+#define AD4170_SINC3_MIN_FS				4
+#define AD4170_SINC3_MAX_FS				65532
+#define AD4170_SINC5_MIN_FS				1
+#define AD4170_SINC5_MAX_FS				256
+
+#define AD4170_GAIN_REG_DEFAULT				0x555555
+
+#define AD4170_ADC_CTRL_CONT_READ_EXIT			0xA5
+
+/* Analog pin functions  */
+#define AD4170_PIN_UNASIGNED				0x00
+#define AD4170_PIN_ANALOG_IN				0x01
+#define AD4170_PIN_CURRENT_OUT				0x02
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
+	/* Init OFFSET register size */
+	/* Init GAIN register size */
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
+enum ad4170_filter_type {
+	AD4170_SINC5_AVG,
+	AD4170_SINC5,
+	AD4170_SINC3,
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
+static const unsigned int ad4170_sinc3_filt_fs_tbl[] = {
+	4, 8, 12, 16, 20, 40, 48, 80, 100, 256, 500, 1000, 5000, 8332, 10000,
+	25000, 50000, 65532,
+};
+
+#define AD4170_MAX_FS_TBL_SIZE		ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl)
+
+static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
+	1, 2, 4, 8, 12, 16, 20, 40, 48, 80, 100, 256,
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
+	int setup_num; /* Index to access state setup_infos array */
+	struct ad4170_setup setup; /* cached setup */
+	int input_range_uv;
+	u32 scale_tbl[10][2];
+	int offset_tbl[10];
+	bool initialized;
+	bool enabled;
+};
+
+static const char * const ad4170_filt_names[] = {
+	[AD4170_SINC5_AVG] = "sinc5+avg",
+	[AD4170_SINC5] = "sinc5",
+	[AD4170_SINC3] = "sinc3",
+};
+
+struct ad4170_state {
+	struct regmap *regmap;
+	struct spi_device *spi;
+	int vrefs_uv[AD4170_MAX_SUP];
+	struct mutex lock; /* Protect read-modify-write and multi write sequences */
+	struct iio_chan_spec chans[AD4170_MAX_CHANNELS];
+	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
+	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
+	u32 mclk_hz;
+	int pins_fn[AD4170_NUM_ANALOG_PINS];
+	u32 int_pin_sel;
+	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
+	struct completion completion;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the transfer buffers
+	 * to live in their own cache lines.
+	 */
+	u8 tx_buf[AD4170_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[AD4170_SPI_MAX_XFER_LEN];
+};
+
+static void ad4170_fill_sps_tbl(struct ad4170_state *st)
+{
+	unsigned int tmp0, tmp1, i;
+
+	/*
+	 * The ODR can be calculated the same way for sinc5+avg, sinc5, and
+	 * sinc3 filter types with the exception that sinc5 filter has a
+	 * narrowed range of allowed FILTER_FS values.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl); i++) {
+		tmp0 = div_u64_rem(st->mclk_hz, 32 * ad4170_sinc3_filt_fs_tbl[i],
+				   &tmp1);
+		tmp1 = mult_frac(tmp1, MICRO, 32 * ad4170_sinc3_filt_fs_tbl[i]);
+		/* Fill sinc5+avg filter SPS table */
+		st->sps_tbl[AD4170_SINC5_AVG][i][0] = tmp0; /* Integer part */
+		st->sps_tbl[AD4170_SINC5_AVG][i][1] = tmp1; /* Fractional part */
+
+		/* Fill sinc3 filter SPS table */
+		st->sps_tbl[AD4170_SINC3][i][0] = tmp0; /* Integer part */
+		st->sps_tbl[AD4170_SINC3][i][1] = tmp1; /* Fractional part */
+	}
+	/* Sinc5 filter ODR doesn't use all FILTER_FS bits */
+	for (i = 0; i < ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl); i++) {
+		tmp0 = div_u64_rem(st->mclk_hz, 32 * ad4170_sinc5_filt_fs_tbl[i],
+				   &tmp1);
+		tmp1 = mult_frac(tmp1, MICRO, 32 * ad4170_sinc5_filt_fs_tbl[i]);
+		/* Fill sinc5 filter SPS table */
+		st->sps_tbl[AD4170_SINC5][i][0] = tmp0; /* Integer part */
+		st->sps_tbl[AD4170_SINC5][i][1] = tmp1; /* Fractional part */
+	}
+}
+
+static int ad4170_debugfs_reg_access(struct iio_dev *indio_dev,
+				     unsigned int reg, unsigned int writeval,
+				     unsigned int *readval)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	return ret;
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
+		break;
+	case 2:
+		*val = get_unaligned_be16(st->rx_buf);
+		break;
+	case 1:
+		*val = st->rx_buf[0];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct regmap_config ad4170_regmap_config = {
+	.reg_read = ad4170_reg_read,
+	.reg_write = ad4170_reg_write,
+};
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
+		if (!memcmp(target_setup, &setup_info->setup,
+			    sizeof(*target_setup))) {
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
+				 FIELD_PREP(AD4170_CHAN_SETUP_SETUP_MSK,
+					    setup_num));
+	if (ret)
+		return ret;
+
+	chan_info->setup_num = setup_num;
+	setup_info->channels++;
+	return 0;
+}
+
+/*
+ * Sets the ADC operating mode. Supported modes are
+ * - Continuous conversion mode (default)
+ * - Single conversion mode
+ * - Idle mode
+ */
+static int ad4170_set_mode(struct ad4170_state *st, unsigned int mode)
+{
+	return regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
+				  AD4170_ADC_CTRL_MODE_MSK,
+				  FIELD_PREP(AD4170_ADC_CTRL_MODE_MSK, mode));
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
+	ret = ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
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
+	/* Case 4 */
+	if (on_enable && chan_info->setup_num != AD4170_INVALID_SETUP)
+		return 0;
+
+	if (!on_enable && !chan_info->enabled) {
+		if (chan_info->setup_num != AD4170_INVALID_SETUP)
+			/* Case 3 */
+			ad4170_unlink_channel(st, chan_addr);
+
+		/* Cases 3 & 5 */
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
+static int __ad4170_get_filter_type(unsigned int filter)
+{
+	u16 f_conf = FIELD_GET(AD4170_FILTER_FILTER_TYPE_MSK, filter);
+
+	switch (f_conf) {
+	case AD4170_FILTER_FILTER_TYPE_SINC5_AVG:
+		return AD4170_SINC5_AVG;
+	case AD4170_FILTER_FILTER_TYPE_SINC5:
+		return AD4170_SINC5;
+	case AD4170_FILTER_FILTER_TYPE_SINC3:
+		return AD4170_SINC3;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4170_set_filter_type(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  unsigned int val)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	unsigned int old_filter_fs, old_filter, filter_type_conf;
+	int ret = 0;
+
+	switch (val) {
+	case AD4170_SINC5_AVG:
+		filter_type_conf = AD4170_FILTER_FILTER_TYPE_SINC5_AVG;
+		break;
+	case AD4170_SINC5:
+		filter_type_conf = AD4170_FILTER_FILTER_TYPE_SINC5;
+		break;
+	case AD4170_SINC3:
+		filter_type_conf = AD4170_FILTER_FILTER_TYPE_SINC3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+	/*
+	 * The filters provide the same ODR for a given filter_fs value but
+	 * there are different minimum and maximum filter_fs limits for each
+	 * filter. The filter_fs value will be adjusted if the current filter_fs
+	 * is out of the limits of the just requested filter. Since the
+	 * filter_fs value affects the ODR (sampling_frequency), changing the
+	 * filter may lead to a change in the sampling frequency.
+	 */
+	old_filter = setup->filter;
+	old_filter_fs = setup->filter_fs;
+	if (val == AD4170_SINC5_AVG || val == AD4170_SINC3) {
+		if (setup->filter_fs < AD4170_SINC3_MIN_FS)
+			setup->filter_fs = AD4170_SINC3_MIN_FS;
+		if (setup->filter_fs > AD4170_SINC3_MAX_FS)
+			setup->filter_fs = AD4170_SINC3_MAX_FS;
+
+	} else if (val == AD4170_SINC5) {
+		if (setup->filter_fs < AD4170_SINC5_MIN_FS)
+			setup->filter_fs = AD4170_SINC5_MIN_FS;
+		if (setup->filter_fs > AD4170_SINC5_MAX_FS)
+			setup->filter_fs = AD4170_SINC5_MAX_FS;
+	}
+
+	setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;
+	setup->filter |= FIELD_PREP(AD4170_FILTER_FILTER_TYPE_MSK,
+				    filter_type_conf);
+
+	ret = ad4170_write_channel_setup(st, chan->address, false);
+	if (ret) {
+		setup->filter = old_filter;
+		setup->filter_fs = old_filter_fs;
+	}
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4170_get_filter_type(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+
+	return __ad4170_get_filter_type(setup->filter);
+}
+
+static const struct iio_enum ad4170_filter_type_enum = {
+	.items = ad4170_filt_names,
+	.num_items = ARRAY_SIZE(ad4170_filt_names),
+	.get = ad4170_get_filter_type,
+	.set = ad4170_set_filter_type,
+};
+
+static const struct iio_chan_spec_ext_info ad4170_filter_type_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4170_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
+			   &ad4170_filter_type_enum),
+	{ }
+};
+
+static const struct iio_chan_spec ad4170_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.differential = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.ext_info = ad4170_filter_type_ext_info,
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
+
+	*ain_voltage = 0;
+	if (ain_n <= AD4170_CHAN_MAP_TEMP_SENSOR)
+		return 0;
+
+	switch (ain_n) {
+	case AD4170_CHAN_MAP_AVDD_AVSS_N:
+		*ain_voltage = (st->vrefs_uv[AD4170_AVDD_SUP]
+				- st->vrefs_uv[AD4170_AVSS_SUP]) / 5;
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
+		*ain_voltage = st->vrefs_uv[AD4170_AVSS_SUP] + (2500 * MILLI);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int ad4170_validate_analog_input(struct ad4170_state *st, int pin)
+{
+	if (pin <= AD4170_MAX_ANALOG_PINS) {
+		if (st->pins_fn[pin] & AD4170_PIN_CURRENT_OUT)
+			return dev_err_probe(&st->spi->dev, -EINVAL,
+					     "Pin %d already used with fn %u.\n",
+					     pin, st->pins_fn[pin]);
+
+		st->pins_fn[pin] |= AD4170_PIN_ANALOG_IN;
+	}
+	return 0;
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
+	return ad4170_validate_analog_input(st, pin);
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
+	if (ret < 0)
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
+					     "REFIN+, REFIN− selected but not provided\n");
+
+		refp = st->vrefs_uv[AD4170_REFIN1P_SUP];
+		refn = st->vrefs_uv[AD4170_REFIN1N_SUP];
+		break;
+	case AD4170_REF_REFIN2:
+		if (st->vrefs_uv[AD4170_REFIN2P_SUP] == -ENODEV ||
+		    st->vrefs_uv[AD4170_REFIN2N_SUP] == -ENODEV)
+			return dev_err_probe(dev, -ENODEV,
+					     "REFIN2+, REFIN2− selected but not provided\n");
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
+		refp = st->vrefs_uv[AD4170_AVSS_SUP] + (2500 * MILLI);
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
+			return dev_err_probe(&st->spi->dev, -EINVAL,
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
+		return dev_err_probe(&st->spi->dev, -EINVAL,
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
+	if (ret < 0)
+		return ret;
+
+	if (refp - ain_voltage <= 0)
+		return dev_err_probe(&st->spi->dev, -EINVAL,
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
+	int settling_time_ms, ret;
+
+	ret = ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_SINGLE);
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
+	reinit_completion(&st->completion);
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
+	int ret;
+
+	guard(mutex)(&st->lock);
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
+	if (ret)
+		dev_err(&st->spi->dev, "failed to read sample: %d\n", ret);
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
+	enum ad4170_filter_type f_type;
+	unsigned int pga, fs_idx;
+	int ret;
+
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
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		f_type = __ad4170_get_filter_type(setup->filter);
+		switch (f_type) {
+		case AD4170_SINC5_AVG:
+		case AD4170_SINC3:
+			fs_idx = find_closest(setup->filter_fs,
+					      ad4170_sinc3_filt_fs_tbl,
+					      ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl));
+			*val = st->sps_tbl[f_type][fs_idx][0];
+			*val2 = st->sps_tbl[f_type][fs_idx][1];
+			break;
+		case AD4170_SINC5:
+			fs_idx = find_closest(setup->filter_fs,
+					      ad4170_sinc5_filt_fs_tbl,
+					      ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl));
+			*val = st->sps_tbl[f_type][fs_idx][0];
+			*val2 = st->sps_tbl[f_type][fs_idx][1];
+			break;
+		default:
+			return -EINVAL;
+		}
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = setup->offset;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*val = setup->gain;
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
+	int bipolar = chan->scan_type.sign == 's' ? 1 : 0;
+	int precision_bits = chan->scan_type.realbits;
+	int pga, ainm_voltage, ret;
+	unsigned long long offset;
+
+	ainm_voltage = 0;
+	ret = ad4170_get_ain_voltage_uv(st, chan->channel2, &ainm_voltage);
+	if (ret < 0)
+		return dev_err_probe(&st->spi->dev, ret,
+				     "Failed to fill scale table\n");
+
+	for (pga = 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {
+		u64 nv;
+		unsigned int lshift, rshift;
+
+		/*
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
+		lshift = (pga >> 3 & 1);  /* handle cases 8 and 9 */
+		rshift = precision_bits - bipolar + (pga & 0x7) - lshift;
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
+	enum ad4170_filter_type f_type;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)chan_info->scale_tbl;
+		*length = ARRAY_SIZE(chan_info->scale_tbl) * 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		f_type = ad4170_get_filter_type(indio_dev, chan);
+		switch (f_type) {
+		case AD4170_SINC5_AVG:
+			fallthrough;
+		case AD4170_SINC3:
+			*vals = (int *)st->sps_tbl[f_type];
+			*length = ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl) * 2;
+			break;
+		case AD4170_SINC5:
+			*vals = (int *)st->sps_tbl[f_type];
+			*length = ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl) * 2;
+			break;
+		default:
+			return -EINVAL;
+		}
+		*type = IIO_VAL_INT_PLUS_MICRO;
+
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
+	unsigned int old_pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
+	unsigned int pga;
+	int ret;
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
+	if (pga == old_pga)
+		return 0;
+
+	guard(mutex)(&st->lock);
+	setup->afe &= ~AD4170_AFE_PGA_GAIN_MSK;
+	setup->afe |= FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, pga);
+
+	ret = ad4170_write_channel_setup(st, chan->address, false);
+	if (ret) {
+		setup->afe &= ~AD4170_AFE_PGA_GAIN_MSK;
+		setup->afe |= FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, old_pga);
+	}
+
+	return ret;
+}
+
+static int ad4170_set_channel_freq(struct ad4170_state *st,
+				   struct iio_chan_spec const *chan, int val,
+				   int val2)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	enum ad4170_filter_type f_type = __ad4170_get_filter_type(setup->filter);
+	int filt_fs_tbl_size, ret, i;
+	unsigned int old_filter_fs;
+
+	switch (f_type) {
+	case AD4170_SINC5_AVG:
+		fallthrough;
+	case AD4170_SINC3:
+		filt_fs_tbl_size = ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl);
+		break;
+	case AD4170_SINC5:
+		filt_fs_tbl_size = ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl);
+		break;
+	}
+
+	for (i = 0; i < filt_fs_tbl_size; i++) {
+		if (st->sps_tbl[f_type][i][0] == val &&
+		    st->sps_tbl[f_type][i][1] == val2)
+			break;
+	}
+	if (i >= filt_fs_tbl_size)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+	old_filter_fs = setup->filter_fs;
+	if (f_type == AD4170_SINC5)
+		setup->filter_fs = ad4170_sinc5_filt_fs_tbl[i];
+	else
+		setup->filter_fs = ad4170_sinc3_filt_fs_tbl[i];
+
+	ret = ad4170_write_channel_setup(st, chan->address, false);
+	if (ret)
+		setup->filter_fs = old_filter_fs;
+
+	return ret;
+}
+
+static int ad4170_set_calib_offset(struct ad4170_state *st,
+				   struct iio_chan_spec const *chan, int val)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	u32 old_offset;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	old_offset = setup->offset;
+	setup->offset = val;
+
+	ret = ad4170_write_channel_setup(st, chan->address, false);
+	if (ret)
+		setup->offset = old_offset;
+
+	return ret;
+}
+
+static int ad4170_set_calib_gain(struct ad4170_state *st,
+				 struct iio_chan_spec const *chan, int val)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	u32 old_gain;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	old_gain = setup->gain;
+	setup->gain = val;
+
+	ret = ad4170_write_channel_setup(st, chan->address, false);
+	if (ret)
+		setup->gain = old_gain;
+
+	return ret;
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
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4170_set_channel_freq(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad4170_set_calib_offset(st, chan, val);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4170_set_calib_gain(st, chan, val);
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
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return IIO_VAL_INT;
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
+	fsleep(MILLI);
+
+	return 0;
+}
+
+static int ad4170_parse_reference(struct ad4170_state *st,
+				  struct fwnode_handle *child,
+				  struct ad4170_setup *setup)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+	u8 aux;
+
+	/* Optional positive reference buffering, if omitted we use the default */
+	aux = AD4170_REF_BUF_FULL; /* Default to full precharge buffer enabled. */
+	ret = fwnode_property_read_u8(child, "adi,buffered-positive", &aux);
+	if (!ret) {
+		if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid adi,buffered-positive: %u\n",
+					     aux);
+	}
+	setup->afe |= FIELD_PREP(AD4170_AFE_REF_BUF_P_MSK, aux);
+
+	/* Optional negative reference buffering, if omitted we use the default */
+	aux = AD4170_REF_BUF_FULL; /* Default to full precharge buffer enabled. */
+	ret = fwnode_property_read_u8(child, "adi,buffered-negative", &aux);
+	if (!ret) {
+		if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid adi,buffered-negative: %u\n",
+					     aux);
+	}
+	setup->afe |= FIELD_PREP(AD4170_AFE_REF_BUF_M_MSK, aux);
+
+	/* Optional voltage reference selection, if omitted we use the default */
+	aux = AD4170_REF_REFOUT; /* Default reference selection. */
+	ret = fwnode_property_read_u8(child, "adi,reference-select", &aux);
+	if (!ret) {
+		if (aux > AD4170_REF_AVDD)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid reference selected %u\n",
+					     aux);
+	}
+	setup->afe |= FIELD_PREP(AD4170_AFE_REF_SELECT_MSK, aux);
+
+	return 0;
+}
+
+static int ad4170_parse_adc_channel_type(struct device *dev,
+					 struct fwnode_handle *child,
+					 struct iio_chan_spec *chan)
+{
+	u32 pins[2];
+	int ret, ret2;
+
+	ret = fwnode_property_read_u32(child, "single-channel", &pins[0]);
+	ret2 = fwnode_property_read_u32(child, "common-mode-channel", &pins[1]);
+	if (!ret && ret2)
+		return dev_err_probe(dev, ret,
+			"single-ended channels must define common-mode-channel\n");
+	if (!ret) {
+		chan->differential = false;
+		chan->channel = pins[0];
+		chan->channel2 = pins[1];
+		return 0;
+	}
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
+	unsigned int ch_reg;
+	u8 ref_select;
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
+	ref_select = FIELD_GET(AD4170_AFE_REF_SELECT_MSK, setup->afe);
+	ret = ad4170_validate_channel(st, chan);
+	if (ret < 0)
+		return ret;
+
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
+	unsigned int chan_num;
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
+	return 0;
+}
+
+static int ad4170_parse_firmware(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	int reg_data, ret, i;
+
+	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+
+	for (i = 0; i < AD4170_NUM_ANALOG_PINS; i++)
+		st->pins_fn[i] = AD4170_PIN_UNASIGNED;
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
+	int i, ret;
+
+	ad4170_fill_sps_tbl(st);
+
+	ret = ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
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
+		ret = ad4170_set_channel_freq(st, chan,
+					      AD4170_DEFAULT_SAMP_RATE, 0);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set channel freq\n");
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
+	st->spi = spi;
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
+		ret = devm_request_irq(&st->spi->dev, st->spi->irq,
+				       &ad4170_irq_handler, IRQF_ONESHOT,
+				       indio_dev->name, indio_dev);
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


