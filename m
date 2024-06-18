Return-Path: <linux-iio+bounces-6469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9000F90C9D1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825081C2121C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66418156F3F;
	Tue, 18 Jun 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F1sxsSj0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8161459E9;
	Tue, 18 Jun 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707984; cv=none; b=GSCNOJ4tBgE2pgJLjj7yY23TBfBgGyskDUAzK+6JWvu+7GMhirO8EMJWmnIfbDuc8uPRRd0/UZ2JzhiNEUcV9zSI50X7a7hWK9xXMHC99dJBK51GNWJBzgEc+ZPciUL99nzgVOp+Pqpu4clciJVy18FAB+mFaEH81Zy4FJWreNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707984; c=relaxed/simple;
	bh=DlaWxmItk9whbPKsvbqT620h52E0BqkAThgQDwyvz8E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0l8l3vF0eMvTd7y2hh25IV7lt01TD0bj7oUIGzNB6T5DPtVvMdAdyuiKX0aNZLeb1rJPSo3z+Qswd/5Vgn7kw8SsitLn5bXIw2xdg0qzLEUefUSB6LkT53JTfG6K+Af28IMd3q3ft9uNZiOUH0Ebwv2rn2zuW1TycWW+7kjIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F1sxsSj0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I6jETh001623;
	Tue, 18 Jun 2024 06:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/i1GT
	dKqWwLh/QQOvgQ5fUpDlUKD3pE5fHBsuFZY1SM=; b=F1sxsSj0bpUNlApCSxRKO
	DC1IrthJKZZIVT9z5zqchqmorj1VFz1KiLeg04RWF94U7LevSeyIgR7B1QHQALsl
	hGjjaB/X80ivBp0Y6FjwgWRGIhV13tUVbySLK0K+apmZCVR5KM1S3j7gX5y6Bulk
	jauHquTRqVgy1d6izgn1x2Eu6tTPqEZunYB2UM7yHkeDLtPUBtoNheB3hms0yQ/M
	HBwfY5/rPtGkyQgp2Dq0PD/P3MWoe4rP+dDf9wyYK9lSTS4YcLRFHDtzEJTY2tw0
	8OZQ5Gm1QIHCVgaqff9wQji3fwt08yzjRvLBUx8P/Xx648449hqHAo+fO2PcM5FD
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yu02qj0ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 06:52:40 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45IAqder055830
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 06:52:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 18 Jun
 2024 06:52:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 06:52:38 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IAq1xn010996;
	Tue, 18 Jun 2024 06:52:29 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Jun Yan <jerrysteve1101@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Mario
 Limonciello <mario.limonciello@amd.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 2/3] iio: accel: add ADXL380 driver
Date: Tue, 18 Jun 2024 13:50:55 +0300
Message-ID: <20240618105150.38141-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618105150.38141-1-antoniu.miclaus@analog.com>
References: <20240618105150.38141-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GCV1-nPoszY3MY6q6Ka-f7_NEDj50_g4
X-Proofpoint-GUID: GCV1-nPoszY3MY6q6Ka-f7_NEDj50_g4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180080

From: Ramona Gradinariu <ramona.gradinariu@analog.com>

The ADXL380/ADXL382 is a low noise density, low power, 3-axis
accelerometer with selectable measurement ranges. The ADXL380 supports
the +/-4 g, +/-8 g, and +/-16 g ranges, and the ADXL382 supports
+/-15 g, +/-30 g and +/-60 g ranges.
The ADXL380/ADXL382 offers industry leading noise, enabling precision
applications with minimal calibration. The low noise, and low power
ADXL380/ADXL382 enables accurate measurement in an environment with
high vibration, heart sounds and audio.

In addition to its low power consumption, the ADXL380/ADXL382 has many
features to enable true system level performance. These include a
built-in micropower temperature sensor, single / double / triple tap
detection and a state machine to prevent a false triggering. In
addition, the ADXL380/ADXL382 has provisions for external control of
the sampling time and/or an external clock.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 MAINTAINERS                     |    4 +
 drivers/iio/accel/Kconfig       |   27 +
 drivers/iio/accel/Makefile      |    3 +
 drivers/iio/accel/adxl380.c     | 1918 +++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl380.h     |   26 +
 drivers/iio/accel/adxl380_i2c.c |   74 ++
 drivers/iio/accel/adxl380_spi.c |   73 ++
 7 files changed, 2125 insertions(+)
 create mode 100644 drivers/iio/accel/adxl380.c
 create mode 100644 drivers/iio/accel/adxl380.h
 create mode 100644 drivers/iio/accel/adxl380_i2c.c
 create mode 100644 drivers/iio/accel/adxl380_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2adee5198891..869bc086cbce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -614,6 +614,10 @@ M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
+F:	drivers/iio/accel/adxl380.c
+F:	drivers/iio/accel/adxl380.h
+F:	drivers/iio/accel/adxl380_i2c.c
+F:	drivers/iio/accel/adxl380_spi.c
 
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
 M:	Ondřej Jirman <megi@xff.cz>
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index c2da5066e9a7..6572ab447e14 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -177,6 +177,33 @@ config ADXL372_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called adxl372_i2c.
 
+config ADXL380
+	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+
+config ADXL380_SPI
+	tristate "Analog Devices ADXL380 3-Axis Accelerometer SPI Driver"
+	depends on SPI
+	select ADXL380
+	select REGMAP_SPI
+	help
+	  Say yes here to add support for the Analog Devices ADXL380 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl380_spi.
+
+config ADXL380_I2C
+	tristate "Analog Devices ADXL380 3-Axis Accelerometer I2C Driver"
+	depends on I2C
+	select ADXL380
+	select REGMAP_I2C
+	help
+	  Say yes here to add support for the Analog Devices ADXL380 triaxial
+	  acceleration sensor.
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl380_i2c.
+
 config BMA180
 	tristate "Bosch BMA023/BMA1x0/BMA250 3-Axis Accelerometer Driver"
 	depends on I2C && INPUT_BMA150=n
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index db90532ba24a..ca8569e25aba 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -21,6 +21,9 @@ obj-$(CONFIG_ADXL367_SPI) += adxl367_spi.o
 obj-$(CONFIG_ADXL372) += adxl372.o
 obj-$(CONFIG_ADXL372_I2C) += adxl372_i2c.o
 obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
+obj-$(CONFIG_ADXL380) += adxl380.o
+obj-$(CONFIG_ADXL380_I2C) += adxl380_i2c.o
+obj-$(CONFIG_ADXL380_SPI) += adxl380_spi.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMA400) += bma400_core.o
diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
new file mode 100644
index 000000000000..f1712ad2dd57
--- /dev/null
+++ b/drivers/iio/accel/adxl380.c
@@ -0,0 +1,1918 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL380 3-Axis Digital Accelerometer core driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/kfifo_buf.h>
+#include <asm/unaligned.h>
+
+#include "adxl380.h"
+
+#define ADXL380_ID_VAL			380
+#define ADXL382_ID_VAL			382
+
+#define ADXL380_DEVID_AD		0x00
+#define ADLX380_PART_ID			0x02
+#define ADXL380_STATUS_0		0x11
+
+#define ADXL380_X_DATA_H		0x15
+#define ADXL380_Y_DATA_H		0x17
+#define ADXL380_Z_DATA_H		0x19
+#define ADXL380_T_DATA_H		0x1B
+
+#define ADXL380_MISC_1			0x20
+
+#define ADXL380_X_DSM_OFFSET		0x4D
+
+#define ADXL380_ACT_INACT_CTL		0x37
+#define ADXL380_INACT_EN_MSK		BIT(2)
+#define ADXL380_ACT_EN_MSK		BIT(0)
+
+#define ADXL380_SNSR_AXIS_EN		0x38
+#define ADXL380_ACT_INACT_AXIS_EN_MSK	GENMASK(2, 0)
+
+#define ADXL380_THRESH_ACT_H		0x39
+#define ADXL380_TIME_ACT_H		0x3B
+#define ADXL380_THRESH_INACT_H		0x3E
+#define ADXL380_TIME_INACT_H		0x40
+#define ADXL380_THRESH_MAX		GENMASK(12, 0)
+#define ADXL380_TIME_MAX		GENMASK(24, 0)
+
+#define ADXL380_FIFO_CONFIG_0		0x30
+#define ADXL380_FIFO_SAMPLES_8_MSK	BIT(0)
+#define ADXL380_FIFO_MODE_MSK		GENMASK(5, 4)
+
+#define ADXL380_FIFO_CONFIG_1		0x31
+#define ADXL380_FIFO_STATUS_0		0x1E
+
+#define ADXL380_TAP_THRESH		0x43
+#define ADXL380_TAP_DUR			0x44
+#define ADXL380_TAP_LATENT		0x45
+#define ADXL380_TAP_WINDOW		0x46
+#define ADXL380_TAP_TIME_MAX		GENMASK(7, 0)
+
+#define ADXL380_TAP_CFG			0x47
+#define ADXL380_TAP_AXIS_MSK		GENMASK(1, 0)
+
+#define ADXL380_TRIG_CFG		0x49
+#define ADXL380_TRIG_CFG_DEC_2X_MSK	BIT(7)
+#define ADXL380_TRIG_CFG_SINC_RATE_MSK	BIT(6)
+
+#define ADXL380_FILTER			0x50
+#define ADXL380_FILTER_EQ_FILT_MSK	BIT(6)
+#define ADXL380_FILTER_LPF_MODE_MSK	GENMASK(5, 4)
+#define ADXL380_FILTER_HPF_PATH_MSK	BIT(3)
+#define ADXL380_FILTER_HPF_CORNER_MSK	GENMASK(2, 0)
+
+#define ADXL380_OP_MODE			0x26
+#define ADXL380_OP_MODE_RANGE_MSK	GENMASK(7, 6)
+#define ADXL380_OP_MODE_OP_MODE_MSK	GENMASK(3, 0)
+
+#define ADXL380_DIG_EN			0x27
+#define ADXL380_CHAN_EN_MSK(chan)	BIT(4 + (chan))
+#define ADXL380_FIFO_EN_MSK		BIT(3)
+
+#define ADXL380_INT0_MAP0		0x2B
+#define ADXL380_FIFO_WM_INT0_MSK	BIT(3)
+#define ADXL380_ACT_INT0_MSK		BIT(5)
+#define ADXL380_INACT_INT0_MSK		BIT(6)
+#define ADXL380_INT0_MAP1		0x2C
+#define ADXL380_SINGLE_TAP_INT0_MSK	BIT(0)
+#define ADXL380_DOUBLE_TAP_INT0_MSK	BIT(1)
+
+#define ADXL380_INT0			0x5D
+#define ADXL380_INT0_POL_MSK		BIT(7)
+
+#define ADXL380_RESET			0x2A
+#define ADXL380_FIFO_DATA		0x1D
+
+#define ADXL380_DEVID_AD_VAL		0xAD
+#define ADXL380_RESET_CODE		0x52
+
+/* ADXL380_STATUS_0 */
+#define ADXL380_STATUS_0_FIFO_FULL(x)		(((x) >> 1) & 0x1)
+#define ADXL380_STATUS_0_FIFO_WM(x)		(((x) >> 3) & 0x1)
+
+/* ADXL380_STATUS_2 */
+#define ADXL380_STATUS_1_INACT(x)		(((x) >> 6) & 0x1)
+#define ADXL380_STATUS_1_ACT(x)			(((x) >> 5) & 0x1)
+#define ADXL380_STATUS_1_DOUBLE_TAP(x)		(((x) >> 1) & 0x1)
+#define ADXL380_STATUS_1_SINGLE_TAP(x)		(((x) >> 0) & 0x1)
+
+#define ADXL380_FIFO_SAMPLES			315UL
+
+enum adxl380_channels {
+	ADXL380_ACCEL_X,
+	ADXL380_ACCEL_Y,
+	ADXL380_ACCEL_Z,
+	ADXL380_TEMP,
+	ADXL380_CH_NUM,
+};
+
+enum adxl380_axis {
+	ADXL380_X_AXIS,
+	ADXL380_Y_AXIS,
+	ADXL380_Z_AXIS,
+};
+
+enum adxl380_op_mode {
+	ADXL380_STANDBY,
+	ADXL380_HEART_SOUND,
+	ADXL380_ULP,
+	ADXL380_VLP,
+	ADXL380_LP,
+	ADXL380_LP_ULP = 6,
+	ADXL380_LP_VLP,
+	ADXL380_RBW,
+	ADXL380_RBW_ULP = 10,
+	ADXL380_RBW_VLP,
+	ADXL380_HP,
+	ADXL380_HP_ULP = 14,
+	ADXL380_HP_VLP,
+};
+
+enum adxl380_range {
+	ADXL380_4G_RANGE = 0,
+	ADXL382_15G_RANGE = 0,
+	ADXL380_8G_RANGE = 1,
+	ADXL382_30G_RANGE = 1,
+	ADXL380_16G_RANGE = 2,
+	ADXL382_60G_RANGE = 2,
+};
+
+enum adxl380_activity_type {
+	ADXL380_ACTIVITY,
+	ADXL380_INACTIVITY,
+};
+
+enum adxl380_tap_type {
+	ADXL380_SINGLE_TAP,
+	ADXL380_DOUBLE_TAP,
+};
+
+enum adxl380_tap_time_type {
+	ADXL380_TAP_TIME_LATENT,
+	ADXL380_TAP_TIME_WINDOW,
+};
+
+enum adxl380_activity_axis {
+	ADXL380_NO_AXIS,
+	ADXL380_X_AXIS_EN,
+	ADXL380_Y_AXIS_EN,
+	ADXL380_X_Y_AXIS_EN,
+	ADXL380_Z_AXIS_EN,
+	ADXL380_X_Z_AXIS_EN,
+	ADXL380_Y_Z_AXIS_EN,
+	ADXL380_X_Y_Z_AXIS_EN,
+};
+
+enum adxl380_hpf_3db {
+	ADXL380_HPF_OFF,
+	ADXL380_HPF_24_7,
+	ADXL380_HPF_6_2084,
+	ADXL380_HPF_1_5545,
+	ADXL380_HPF_0_3862,
+	ADXL380_HPF_0_0954,
+	ADXL380_HPF_0_0238,
+};
+
+enum adxl380_fifo_mode {
+	ADXL380_FIFO_DISABLED,
+	ADXL380_FIFO_NORMAL,
+	ADXL380_FIFO_STREAMED,
+	ADXL380_FIFO_TRIGGERED,
+};
+
+/*
+ * At +/- 4g with 16-bit resolution, scale is given in datasheet
+ * as 133.3ug/LSB = 0.0001333 * 9.80665 = 0.001307226 m/s^2.
+ */
+#define ADXL380_RANGE_SCALE_TBL							\
+{										\
+	[ADXL380_4G_RANGE] = {0, 1307226},					\
+	[ADXL380_8G_RANGE] = {0, 2615434},					\
+	[ADXL380_16G_RANGE] = {0, 5229886},					\
+}
+
+/*
+ * At +/- 15g with 16-bit resolution, scale is given in datasheet
+ * as 500ug/LSB = 0.0005 * 9.80665 = 0.004903325 m/s^2.
+ */
+#define ADXL382_RANGE_SCALE_TBL							\
+{										\
+	[ADXL382_15G_RANGE] = {0, 4903325},					\
+	[ADXL382_30G_RANGE] = {0, 9806650},					\
+	[ADXL382_60G_RANGE] = {0, 19613300},					\
+}
+
+static const int adxl380_range_scale_factor_tbl[] = {1, 2, 4};
+
+const struct adxl380_chip_info adxl380_chip_info = {
+	.name = "adxl380",
+	.chip_id = ADXL380_ID_VAL,
+	.scale_tbl = ADXL380_RANGE_SCALE_TBL,
+	.samp_freq_tbl = {8000, 16000, 32000},
+	/*
+	 * The datasheet defines an intercept of 470 LSB at 25 degC
+	 * and a sensitivity of 10.2 LSB/C.
+	 */
+	.temp_offset =  25 * 102 / 10 - 470,
+
+};
+EXPORT_SYMBOL_NS_GPL(adxl380_chip_info, IIO_ADXL380);
+
+const struct adxl380_chip_info adxl382_chip_info = {
+	.name = "adxl382",
+	.chip_id = ADXL382_ID_VAL,
+	.scale_tbl = ADXL382_RANGE_SCALE_TBL,
+	.samp_freq_tbl = {16000, 32000, 64000},
+	/*
+	 * The datasheet defines an intercept of 570 LSB at 25 degC
+	 * and a sensitivity of 10.2 LSB/C.
+	 */
+	.temp_offset =  25 * 102 / 10 - 570,
+};
+EXPORT_SYMBOL_NS_GPL(adxl382_chip_info, IIO_ADXL380);
+
+static const unsigned int adxl380_th_reg_high_addr[2] = {
+	[ADXL380_ACTIVITY] = ADXL380_THRESH_ACT_H,
+	[ADXL380_INACTIVITY] = ADXL380_THRESH_INACT_H,
+};
+
+static const unsigned int adxl380_time_reg_high_addr[2] = {
+	[ADXL380_ACTIVITY] = ADXL380_TIME_ACT_H,
+	[ADXL380_INACTIVITY] = ADXL380_TIME_INACT_H,
+};
+
+static const unsigned int adxl380_tap_time_reg[2] = {
+	[ADXL380_TAP_TIME_LATENT] = ADXL380_TAP_LATENT,
+	[ADXL380_TAP_TIME_WINDOW] = ADXL380_TAP_WINDOW,
+};
+
+struct adxl380_state {
+	int irq;
+	struct device *dev;
+	struct regmap *regmap;
+	const struct adxl380_chip_info *chip_info;
+	/*
+	 * Synchronize access to members of driver state, and ensure atomicity
+	 * of consecutive regmap operations.
+	 */
+	struct mutex lock;
+	enum adxl380_range range;
+	u8 odr;
+	u32 act_time_ms;
+	u32 act_threshold;
+	u32 inact_time_ms;
+	u32 inact_threshold;
+	u32 tap_latent_us;
+	u32 tap_window_us;
+	u32 tap_duration_us;
+	u32 tap_threshold;
+	enum adxl380_axis tap_axis_en;
+	u8 fifo_set_size;
+	u16 watermark;
+	int lpf_tbl[4];
+	int hpf_tbl[7][2];
+	u8 transf_buf[3];
+	__be16 fifo_buf[ADXL380_FIFO_SAMPLES];
+};
+
+bool adxl380_readable_noinc_reg(struct device *dev, unsigned int reg)
+{
+	return (reg == ADXL380_FIFO_DATA);
+}
+EXPORT_SYMBOL_NS_GPL(adxl380_readable_noinc_reg, IIO_ADXL380);
+
+static int _adxl380_set_measure_en(struct adxl380_state *st, bool en)
+{
+	int ret;
+	unsigned int act_inact_ctl;
+	enum adxl380_op_mode op_mode = ADXL380_STANDBY;
+
+	if (en) {
+		ret = regmap_read(st->regmap, ADXL380_ACT_INACT_CTL, &act_inact_ctl);
+		if (ret)
+			return ret;
+
+		/* Activity/ Inactivity detection available only in VLP/ULP mode */
+		if (FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
+		    FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl))
+			op_mode = ADXL380_VLP;
+		else
+			op_mode = ADXL380_HP;
+	}
+
+	return regmap_update_bits(st->regmap, ADXL380_OP_MODE,
+				 ADXL380_OP_MODE_OP_MODE_MSK,
+				 FIELD_PREP(ADXL380_OP_MODE_OP_MODE_MSK, op_mode));
+}
+
+static void _adxl380_scale_act_inact_thresholds(struct adxl380_state *st,
+						enum adxl380_range old_range,
+						enum adxl380_range new_range)
+{
+	st->act_threshold = mult_frac(st->act_threshold,
+				      adxl380_range_scale_factor_tbl[old_range],
+				      adxl380_range_scale_factor_tbl[new_range]);
+	st->inact_threshold = mult_frac(st->inact_threshold,
+					adxl380_range_scale_factor_tbl[old_range],
+					adxl380_range_scale_factor_tbl[new_range]);
+}
+
+static int _adxl380_write_act_inact_threshold(struct adxl380_state *st,
+					      enum adxl380_activity_type act,
+					      unsigned int th)
+{
+	int ret;
+	u8 reg = adxl380_th_reg_high_addr[act];
+
+	if (th > ADXL380_THRESH_MAX)
+		return -EINVAL;
+
+	ret = regmap_write(st->regmap, reg + 1, th & GENMASK(7, 0));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, reg, GENMASK(2, 0), th >> 8);
+	if (ret)
+		return ret;
+
+	if (act == ADXL380_ACTIVITY)
+		st->act_threshold = th;
+	else
+		st->inact_threshold = th;
+
+	return 0;
+}
+
+static int adxl380_set_act_inact_threshold(struct iio_dev *indio_dev,
+					   enum adxl380_activity_type act,
+					   u16 th)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_write_act_inact_threshold(st, act, th);
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int adxl380_set_tap_threshold_value(struct iio_dev *indio_dev, u8 th)
+{
+	int ret;
+	struct adxl380_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL380_TAP_THRESH, th);
+	if (ret)
+		return ret;
+
+	st->tap_threshold = th;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int _adxl380_write_tap_time_us(struct adxl380_state *st,
+				      enum adxl380_tap_time_type tap_time_type,
+				      u32 us)
+{
+	u8 reg = adxl380_tap_time_reg[tap_time_type];
+	unsigned int reg_val;
+	int ret;
+
+	/* scale factor for tap window is 1250us / LSB */
+	reg_val = DIV_ROUND_CLOSEST(us, 1250);
+	if (reg_val > ADXL380_TAP_TIME_MAX)
+		reg_val = ADXL380_TAP_TIME_MAX;
+
+	ret = regmap_write(st->regmap, reg, reg_val);
+	if (ret)
+		return ret;
+
+	if (tap_time_type == ADXL380_TAP_TIME_WINDOW)
+		st->tap_window_us = us;
+	else
+		st->tap_latent_us = us;
+
+	return 0;
+}
+
+static int adxl380_write_tap_time_us(struct adxl380_state *st,
+				     enum adxl380_tap_time_type tap_time_type, u32 us)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_write_tap_time_us(st, tap_time_type, us);
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int _adxl380_write_tap_dur_us(struct iio_dev *indio_dev, u32 us)
+{
+	int ret;
+	unsigned int reg_val;
+	struct adxl380_state *st = iio_priv(indio_dev);
+
+	/* 625us per code is the scale factor of TAP_DUR register */
+	reg_val = DIV_ROUND_CLOSEST(us, 625);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL380_TAP_DUR, reg_val);
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int adxl380_read_chn(struct adxl380_state *st, u8 addr)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_bulk_read(st->regmap, addr, &st->transf_buf, 2);
+	if (ret)
+		return ret;
+
+	return get_unaligned_be16(st->transf_buf);
+}
+
+static int _adxl380_get_odr(struct adxl380_state *st, int *odr)
+{
+	int ret;
+	unsigned int trig_cfg, odr_idx;
+
+	ret = regmap_read(st->regmap, ADXL380_TRIG_CFG, &trig_cfg);
+	if (ret)
+		return ret;
+
+	odr_idx = (FIELD_GET(ADXL380_TRIG_CFG_SINC_RATE_MSK, trig_cfg) << 1) |
+		  (FIELD_GET(ADXL380_TRIG_CFG_DEC_2X_MSK, trig_cfg) & 1);
+
+	*odr = st->chip_info->samp_freq_tbl[odr_idx];
+
+	return 0;
+}
+
+static const int adxl380_lpf_div[] = {
+	1, 4, 8, 16,
+};
+
+static int _adxl380_fill_lpf_tbl(struct adxl380_state *st)
+{
+	int ret, i;
+	int odr;
+
+	ret = _adxl380_get_odr(st, &odr);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(st->lpf_tbl); i++)
+		st->lpf_tbl[i] = DIV_ROUND_CLOSEST(odr, adxl380_lpf_div[i]);
+
+	return 0;
+}
+
+static const int adxl380_hpf_mul[] = {
+	0, 247000, 62084, 15545, 3862, 954, 238,
+};
+
+static int _adxl380_fill_hpf_tbl(struct adxl380_state *st)
+{
+	int i, ret, odr_hz;
+	u32 multiplier;
+	u64 div, rem, odr;
+
+	ret =  _adxl380_get_odr(st, &odr_hz);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(adxl380_hpf_mul); i++) {
+		odr = mul_u64_u32_shr(odr_hz, MEGA, 0);
+		multiplier = adxl380_hpf_mul[i];
+		div = div64_u64_rem(mul_u64_u32_shr(odr, multiplier, 0),
+				    TERA * 100, &rem);
+
+		st->hpf_tbl[i][0] = div;
+		st->hpf_tbl[i][1] = div_u64(rem, MEGA * 100);
+	}
+
+	return 0;
+}
+
+static int adxl380_set_odr(struct adxl380_state *st, u8 odr)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL380_TRIG_CFG,
+				 ADXL380_TRIG_CFG_DEC_2X_MSK,
+				 FIELD_PREP(ADXL380_TRIG_CFG_DEC_2X_MSK, (odr & 1)));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL380_TRIG_CFG,
+				 ADXL380_TRIG_CFG_SINC_RATE_MSK,
+				 FIELD_PREP(ADXL380_TRIG_CFG_SINC_RATE_MSK, (odr >> 1)));
+	if (ret)
+		return ret;
+
+	ret = _adxl380_set_measure_en(st, true);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_fill_lpf_tbl(st);
+	if (ret)
+		return ret;
+
+	return _adxl380_fill_hpf_tbl(st);
+}
+
+static int _adxl380_find_match_1d_tbl(const int *array,
+				      unsigned int size,
+				      int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val == array[i])
+			return i;
+	}
+
+	return size - 1;
+}
+
+static int _adxl380_find_match_2d_tbl(const int (*freq_tbl)[2], int n, int val, int val2)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (freq_tbl[i][0] == val && freq_tbl[i][1] == val2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl380_get_lpf(struct adxl380_state *st, int *lpf)
+{
+	int ret;
+	unsigned int trig_cfg, lpf_idx;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, ADXL380_FILTER, &trig_cfg);
+	if (ret)
+		return ret;
+
+	lpf_idx = FIELD_GET(ADXL380_FILTER_LPF_MODE_MSK, trig_cfg);
+
+	*lpf = st->lpf_tbl[lpf_idx];
+
+	return 0;
+}
+
+static int adxl380_set_lpf(struct adxl380_state *st, u8 lpf)
+{
+	int ret;
+	u8 eq_bypass = 0;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	if (lpf)
+		eq_bypass = 1;
+
+	ret = regmap_update_bits(st->regmap, ADXL380_FILTER,
+				 ADXL380_FILTER_EQ_FILT_MSK,
+				 FIELD_PREP(ADXL380_FILTER_EQ_FILT_MSK, eq_bypass));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL380_FILTER,
+				 ADXL380_FILTER_LPF_MODE_MSK,
+				 FIELD_PREP(ADXL380_FILTER_LPF_MODE_MSK, lpf));
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int adxl380_get_hpf(struct adxl380_state *st, int *hpf_int, int *hpf_frac)
+{
+	int ret;
+	unsigned int trig_cfg, hpf_idx;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, ADXL380_FILTER, &trig_cfg);
+	if (ret)
+		return ret;
+
+	hpf_idx = FIELD_GET(ADXL380_FILTER_HPF_CORNER_MSK, trig_cfg);
+
+	*hpf_int = st->hpf_tbl[hpf_idx][0];
+	*hpf_frac = st->hpf_tbl[hpf_idx][1];
+
+	return 0;
+}
+
+static int adxl380_set_hpf(struct adxl380_state *st, u8 hpf)
+{
+	int ret;
+	u8 hpf_path = 0;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	if (hpf)
+		hpf_path = 1;
+
+	ret = regmap_update_bits(st->regmap, ADXL380_FILTER,
+				 ADXL380_FILTER_HPF_PATH_MSK,
+				 FIELD_PREP(ADXL380_FILTER_HPF_PATH_MSK, hpf_path));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL380_FILTER,
+				 ADXL380_FILTER_HPF_CORNER_MSK,
+				 FIELD_PREP(ADXL380_FILTER_HPF_CORNER_MSK, hpf));
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int _adxl380_set_act_inact_time_ms(struct adxl380_state *st,
+					  enum adxl380_activity_type act,
+					  u32 ms)
+{
+	u8 reg = adxl380_time_reg_high_addr[act];
+	unsigned int reg_val;
+	int ret;
+
+	/* 500us per code is the scale factor of TIME_ACT / TIME_INACT registers */
+	reg_val = DIV_ROUND_CLOSEST(ms * 1000, 500);
+	if (reg_val > ADXL380_TIME_MAX)
+		reg_val = ADXL380_TIME_MAX;
+
+	st->transf_buf[0] = reg_val >> 16;
+	st->transf_buf[1] = reg_val >> 8;
+	st->transf_buf[2] = reg_val;
+
+	ret = regmap_bulk_write(st->regmap, reg, st->transf_buf, sizeof(st->transf_buf));
+	if (ret)
+		return ret;
+
+	if (act == ADXL380_ACTIVITY)
+		st->act_time_ms = ms;
+	else
+		st->inact_time_ms = ms;
+
+	return 0;
+}
+
+static int adxl380_set_act_inact_time_ms(struct adxl380_state *st,
+					 enum adxl380_activity_type act,
+					 u32 ms)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_set_act_inact_time_ms(st, act, ms);
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int adxl380_set_range(struct adxl380_state *st, enum adxl380_range range)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap,
+				 ADXL380_OP_MODE,
+				 ADXL380_OP_MODE_RANGE_MSK,
+				 FIELD_PREP(ADXL380_OP_MODE_RANGE_MSK, range));
+
+	if (ret)
+		return ret;
+
+	_adxl380_scale_act_inact_thresholds(st, st->range, range);
+
+	/* Activity thresholds depend on range */
+	ret = _adxl380_write_act_inact_threshold(st,
+						 ADXL380_ACTIVITY,
+						 st->act_threshold);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_write_act_inact_threshold(st,
+						 ADXL380_INACTIVITY,
+						 st->inact_threshold);
+	if (ret)
+		return ret;
+
+	st->range = range;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int _adxl380_write_act_inact_en(struct adxl380_state *st,
+				       enum adxl380_activity_type type,
+				       bool en)
+{
+	if (type == ADXL380_ACTIVITY)
+		return regmap_update_bits(st->regmap, ADXL380_ACT_INACT_CTL,
+					  ADXL380_ACT_EN_MSK,
+					  FIELD_PREP(ADXL380_ACT_EN_MSK, en));
+
+	return regmap_update_bits(st->regmap, ADXL380_ACT_INACT_CTL,
+				  ADXL380_INACT_EN_MSK,
+				  FIELD_PREP(ADXL380_INACT_EN_MSK, en));
+}
+
+static int adxl380_read_act_inact_int(struct adxl380_state *st,
+				      enum adxl380_activity_type type,
+				      bool *en)
+{
+	int ret;
+	unsigned int reg_val;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, ADXL380_INT0_MAP0, &reg_val);
+	if (ret)
+		return ret;
+
+	if (type == ADXL380_ACTIVITY)
+		*en = FIELD_GET(ADXL380_ACT_INT0_MSK, reg_val);
+	else
+		*en = FIELD_GET(ADXL380_INACT_INT0_MSK, reg_val);
+
+	return 0;
+}
+
+static int _adxl380_write_act_inact_int(struct adxl380_state *st,
+					enum adxl380_activity_type act,
+					bool en)
+{
+	if (act == ADXL380_ACTIVITY)
+		return regmap_update_bits(st->regmap, ADXL380_INT0_MAP0,
+					  ADXL380_ACT_INT0_MSK,
+					  FIELD_PREP(ADXL380_ACT_INT0_MSK, en));
+
+	return regmap_update_bits(st->regmap, ADXL380_INT0_MAP0,
+				  ADXL380_INACT_INT0_MSK,
+				  FIELD_PREP(ADXL380_INACT_INT0_MSK, en));
+}
+
+static int adxl380_act_inact_config(struct adxl380_state *st,
+				    enum adxl380_activity_type type,
+				    bool en)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_write_act_inact_en(st, type, en);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_write_act_inact_int(st, type, en);
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int _adxl380_write_tap_axis(struct adxl380_state *st,
+				   enum adxl380_axis axis)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL380_TAP_CFG,
+				 ADXL380_TAP_AXIS_MSK,
+				 FIELD_PREP(ADXL380_TAP_AXIS_MSK, axis));
+
+	if (ret)
+		return ret;
+
+	st->tap_axis_en = axis;
+
+	return 0;
+}
+
+static int _adxl380_read_tap_int(struct adxl380_state *st, enum adxl380_tap_type type, bool *en)
+{
+	int ret;
+	unsigned int reg_val;
+
+	ret = regmap_read(st->regmap, ADXL380_INT0_MAP1, &reg_val);
+	if (ret)
+		return ret;
+
+	if (type == ADXL380_SINGLE_TAP)
+		*en = FIELD_GET(ADXL380_SINGLE_TAP_INT0_MSK, reg_val);
+	else
+		*en = FIELD_GET(ADXL380_DOUBLE_TAP_INT0_MSK, reg_val);
+
+	return 0;
+}
+
+static int _adxl380_write_tap_int(struct adxl380_state *st, enum adxl380_tap_type type, bool en)
+{
+	if (type == ADXL380_SINGLE_TAP)
+		return regmap_update_bits(st->regmap, ADXL380_INT0_MAP1,
+					  ADXL380_SINGLE_TAP_INT0_MSK,
+					  FIELD_PREP(ADXL380_SINGLE_TAP_INT0_MSK, en));
+
+	return regmap_update_bits(st->regmap, ADXL380_INT0_MAP1,
+				  ADXL380_DOUBLE_TAP_INT0_MSK,
+				  FIELD_PREP(ADXL380_DOUBLE_TAP_INT0_MSK, en));
+}
+
+static int adxl380_tap_config(struct adxl380_state *st,
+			      enum adxl380_axis axis,
+			      enum adxl380_tap_type type,
+			      bool en)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_write_tap_axis(st, axis);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_write_tap_int(st, type, en);
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int _adxl380_set_fifo_samples(struct adxl380_state *st)
+{
+	int ret;
+	u16 fifo_samples = st->watermark * st->fifo_set_size;
+
+	ret = regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0,
+				 ADXL380_FIFO_SAMPLES_8_MSK,
+				 FIELD_PREP(ADXL380_FIFO_SAMPLES_8_MSK, (fifo_samples & BIT(8))));
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap,
+			    ADXL380_FIFO_CONFIG_1, fifo_samples & 0xFF);
+}
+
+static int _adxl380_get_status(struct adxl380_state *st,
+			       u8 *status0, u8 *status1)
+{
+	u16 val;
+	int ret;
+
+	/* STATUS0, STATUS1 are adjacent regs */
+	ret = regmap_bulk_read(st->regmap, ADXL380_STATUS_0,
+			       &st->transf_buf, 2);
+	if (ret)
+		return ret;
+
+	val = get_unaligned_be16(st->transf_buf);
+
+	*status0 = (val >> 8) & 0xFF;
+	*status1 = val & 0xFF;
+
+	return 0;
+}
+
+static int adxl380_get_fifo_entries(struct adxl380_state *st, u16 *fifo_entries)
+{
+	u16 val;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, ADXL380_FIFO_STATUS_0,
+			       &st->transf_buf, 2);
+	if (ret)
+		return ret;
+
+	val = get_unaligned_be16(st->transf_buf);
+
+	*fifo_entries = ((val >> 8) & 0xFF) | ((BIT(0) & val) << 8);
+
+	return 0;
+}
+
+static void adxl380_push_event(struct iio_dev *indio_dev, s64 timestamp,
+			       u8 status1)
+{
+	if (ADXL380_STATUS_1_ACT(status1))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+			       timestamp);
+
+	if (ADXL380_STATUS_1_INACT(status1))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+			       timestamp);
+	if (ADXL380_STATUS_1_SINGLE_TAP(status1))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_GESTURE, IIO_EV_DIR_SINGLETAP),
+			       timestamp);
+
+	if (ADXL380_STATUS_1_DOUBLE_TAP(status1))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_GESTURE, IIO_EV_DIR_DOUBLETAP),
+			       timestamp);
+}
+
+static irqreturn_t adxl380_irq_handler(int irq, void  *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct adxl380_state *st = iio_priv(indio_dev);
+	u8 status0, status1;
+	u16 fifo_entries;
+	int i;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_get_status(st, &status0, &status1);
+	if (ret)
+		goto exit;
+
+	adxl380_push_event(indio_dev, iio_get_time_ns(indio_dev), status1);
+
+	if (ADXL380_STATUS_0_FIFO_WM(status0)) {
+		ret = adxl380_get_fifo_entries(st, &fifo_entries);
+		if (ret)
+			goto exit;
+
+		for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
+			ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
+						&st->fifo_buf[i],
+						2 * st->fifo_set_size);
+			if (ret)
+				goto exit;
+			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
+		}
+	}
+
+exit:
+	return IRQ_HANDLED;
+}
+
+static int adxl380_write_calibbias_value(struct adxl380_state *st,
+					 unsigned long chan_addr,
+					 u8 calibbias)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL380_X_DSM_OFFSET + chan_addr, calibbias);
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int adxl380_read_calibbias_value(struct adxl380_state *st,
+					unsigned long chan_addr,
+					int *calibbias)
+{
+	int ret;
+	unsigned int reg_val;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, ADXL380_X_DSM_OFFSET + chan_addr, &reg_val);
+	if (ret)
+		return ret;
+
+	*calibbias = sign_extend32(reg_val, 7);
+
+	return 0;
+}
+
+static ssize_t hwfifo_watermark_min_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "1\n");
+}
+
+static ssize_t hwfifo_watermark_max_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", ADXL380_FIFO_SAMPLES);
+}
+
+static ssize_t adxl380_get_fifo_watermark(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl380_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", st->watermark);
+}
+
+static ssize_t adxl380_get_fifo_enabled(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl380_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned int reg_val;
+
+	ret = regmap_read(st->regmap, ADXL380_DIG_EN, &reg_val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%lu\n", FIELD_GET(ADXL380_FIFO_EN_MSK, reg_val));
+}
+
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
+static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
+		       adxl380_get_fifo_watermark, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       adxl380_get_fifo_enabled, NULL, 0);
+
+static const struct iio_dev_attr *adxl380_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_watermark_min,
+	&iio_dev_attr_hwfifo_watermark_max,
+	&iio_dev_attr_hwfifo_watermark,
+	&iio_dev_attr_hwfifo_enabled,
+	NULL,
+};
+
+static int adxl380_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+	int i;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap,
+				 ADXL380_INT0_MAP0,
+				 ADXL380_FIFO_WM_INT0_MSK,
+				 FIELD_PREP(ADXL380_FIFO_WM_INT0_MSK, 1));
+	if (ret)
+		return ret;
+
+	for_each_clear_bit(i, indio_dev->active_scan_mask, ADXL380_CH_NUM) {
+		ret = regmap_update_bits(st->regmap, ADXL380_DIG_EN,
+					 ADXL380_CHAN_EN_MSK(i),
+					 0 << (4 + i));
+		if (ret)
+			return ret;
+	}
+
+	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
+					  indio_dev->masklength);
+
+	if ((st->watermark * st->fifo_set_size) > ADXL380_FIFO_SAMPLES)
+		st->watermark = (ADXL380_FIFO_SAMPLES  / st->fifo_set_size);
+
+	ret = _adxl380_set_fifo_samples(st);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL380_DIG_EN, ADXL380_FIFO_EN_MSK,
+				 FIELD_PREP(ADXL380_FIFO_EN_MSK, 1));
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static int adxl380_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+	int ret, i;
+
+	guard(mutex)(&st->lock);
+
+	ret = _adxl380_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap,
+				 ADXL380_INT0_MAP0,
+				 ADXL380_FIFO_WM_INT0_MSK,
+				 FIELD_PREP(ADXL380_FIFO_WM_INT0_MSK, 0));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		ret = regmap_update_bits(st->regmap, ADXL380_DIG_EN,
+					 ADXL380_CHAN_EN_MSK(i),
+					 1 << (4 + i));
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_update_bits(st->regmap, ADXL380_DIG_EN, ADXL380_FIFO_EN_MSK,
+				 FIELD_PREP(ADXL380_FIFO_EN_MSK, 0));
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+static const struct iio_buffer_setup_ops adxl380_buffer_ops = {
+	.postenable = adxl380_buffer_postenable,
+	.predisable = adxl380_buffer_predisable,
+};
+
+static int adxl380_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = adxl380_read_chn(st, chan->address);
+
+		iio_device_release_direct_mode(indio_dev);
+
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			scoped_guard(mutex, &st->lock) {
+				*val = st->chip_info->scale_tbl[st->range][0];
+				*val2 = st->chip_info->scale_tbl[st->range][1];
+			}
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_TEMP:
+			/* 10.2 LSB / Degree Celsius */
+			*val = 10000;
+			*val2 = 102;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = st->chip_info->temp_offset;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			ret = adxl380_read_calibbias_value(st, chan->scan_index, val);
+			if (ret)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = _adxl380_get_odr(st, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret =  adxl380_get_lpf(st, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		ret =  adxl380_get_hpf(st, val, val2);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl380_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+		*vals = (const int *)st->chip_info->scale_tbl;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(st->chip_info->scale_tbl) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)st->chip_info->samp_freq_tbl;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(st->chip_info->samp_freq_tbl);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (const int *)st->lpf_tbl;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(st->lpf_tbl);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (const int *)st->hpf_tbl;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = ARRAY_SIZE(st->hpf_tbl) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl380_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+	int odr_index, lpf_index, hpf_index, range_index;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		odr_index = _adxl380_find_match_1d_tbl(st->chip_info->samp_freq_tbl,
+						       ARRAY_SIZE(st->chip_info->samp_freq_tbl),
+						       val);
+		return adxl380_set_odr(st, odr_index);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return adxl380_write_calibbias_value(st, chan->scan_index, val);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		lpf_index = _adxl380_find_match_1d_tbl(st->lpf_tbl,
+						       ARRAY_SIZE(st->lpf_tbl),
+						       val);
+		if (lpf_index < 0)
+			return lpf_index;
+		return adxl380_set_lpf(st, lpf_index);
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		hpf_index = _adxl380_find_match_2d_tbl(st->hpf_tbl,
+						       ARRAY_SIZE(st->hpf_tbl),
+						       val, val2);
+		if (hpf_index < 0)
+			return hpf_index;
+		return adxl380_set_hpf(st, hpf_index);
+	case IIO_CHAN_INFO_SCALE:
+		range_index = _adxl380_find_match_2d_tbl(st->chip_info->scale_tbl,
+							 ARRAY_SIZE(st->chip_info->scale_tbl),
+							 val, val2);
+		if (range_index < 0)
+			return range_index;
+		return adxl380_set_range(st, range_index);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl380_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static int adxl380_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type, enum iio_event_direction dir)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+	int ret;
+	bool int_en;
+	bool tap_axis_en = false;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		tap_axis_en = st->tap_axis_en == ADXL380_X_AXIS;
+		break;
+	case IIO_MOD_Y:
+		tap_axis_en = st->tap_axis_en == ADXL380_Y_AXIS;
+		break;
+	case IIO_MOD_Z:
+		tap_axis_en = st->tap_axis_en == ADXL380_Z_AXIS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = adxl380_read_act_inact_int(st, ADXL380_ACTIVITY, &int_en);
+		if (ret)
+			return ret;
+		return int_en;
+	case IIO_EV_DIR_FALLING:
+		ret = adxl380_read_act_inact_int(st, ADXL380_INACTIVITY, &int_en);
+		if (ret)
+			return ret;
+		return int_en;
+	case IIO_EV_DIR_SINGLETAP:
+		ret = _adxl380_read_tap_int(st, ADXL380_SINGLE_TAP, &int_en);
+		if (ret)
+			return ret;
+		return int_en && tap_axis_en;
+	case IIO_EV_DIR_DOUBLETAP:
+		ret = _adxl380_read_tap_int(st, ADXL380_DOUBLE_TAP, &int_en);
+		if (ret)
+			return ret;
+		return int_en && tap_axis_en;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl380_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type, enum iio_event_direction dir,
+				      int state)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+	enum adxl380_axis axis;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		axis = ADXL380_X_AXIS;
+		break;
+	case IIO_MOD_Y:
+		axis = ADXL380_Y_AXIS;
+		break;
+	case IIO_MOD_Z:
+		axis = ADXL380_Z_AXIS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl380_act_inact_config(st, ADXL380_ACTIVITY, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl380_act_inact_config(st, ADXL380_INACTIVITY, state);
+	case IIO_EV_DIR_SINGLETAP:
+		return adxl380_tap_config(st, axis, ADXL380_SINGLE_TAP, state);
+	case IIO_EV_DIR_DOUBLETAP:
+		return adxl380_tap_config(st, axis, ADXL380_DOUBLE_TAP, state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl380_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type, enum iio_event_direction dir,
+				    enum iio_event_info info, int *val, int *val2)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+
+	guard(mutex)(&st->lock);
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE: {
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				*val = st->act_threshold;
+				return IIO_VAL_INT;
+			case IIO_EV_DIR_FALLING:
+				*val = st->inact_threshold;
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+		}
+		case IIO_EV_INFO_PERIOD:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				*val = st->act_time_ms;
+				*val2 = 1000;
+				return IIO_VAL_FRACTIONAL;
+			case IIO_EV_DIR_FALLING:
+				*val = st->inact_time_ms;
+				*val2 = 1000;
+				return IIO_VAL_FRACTIONAL;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			*val = st->tap_threshold;
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			*val = st->tap_window_us;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			*val = st->tap_latent_us;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl380_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type, enum iio_event_direction dir,
+				     enum iio_event_info info, int val, int val2)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+	u32 val_ms, val_us;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				return adxl380_set_act_inact_threshold(indio_dev, ADXL380_ACTIVITY, val);
+			case IIO_EV_DIR_FALLING:
+				return adxl380_set_act_inact_threshold(indio_dev, ADXL380_INACTIVITY, val);
+			default:
+				return -EINVAL;
+			}
+		case IIO_EV_INFO_PERIOD:
+			val_ms = val * 1000 + DIV_ROUND_UP(val2, 1000);
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				return adxl380_set_act_inact_time_ms(st, ADXL380_ACTIVITY, val_ms);
+			case IIO_EV_DIR_FALLING:
+				return adxl380_set_act_inact_time_ms(st, ADXL380_INACTIVITY, val_ms);
+			default:
+				return -EINVAL;
+			}
+
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			return adxl380_set_tap_threshold_value(indio_dev, val);
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			val_us = val * 1000000 + val2;
+			return adxl380_write_tap_time_us(st, ADXL380_TAP_TIME_WINDOW, val_us);
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			val_us = val * 1000000 + val2;
+			return adxl380_write_tap_time_us(st, ADXL380_TAP_TIME_LATENT, val_us);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t in_accel_gesture_tap_maxtomin_time_show(struct device *dev,
+						       struct device_attribute *attr,
+						       char *buf)
+{
+	int vals[2];
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl380_state *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	vals[0] = st->tap_duration_us;
+	vals[1] = 1000000;
+
+	ret  = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, vals);
+
+	return ret;
+}
+
+static ssize_t in_accel_gesture_tap_maxtomin_time_store(struct device *dev,
+							struct device_attribute *attr,
+							const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl380_state *st = iio_priv(indio_dev);
+	int ret, val_int, val_fract_us;
+
+	guard(mutex)(&st->lock);
+
+	ret = iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract_us);
+	if (ret)
+		return ret;
+
+	/* maximum value is 255 * 625 us = 0.159375 seconds */
+	if (val_int || val_fract_us > 159375)
+		return -EINVAL;
+
+	ret = _adxl380_write_tap_dur_us(indio_dev, val_fract_us);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RW(in_accel_gesture_tap_maxtomin_time, 0);
+
+static struct attribute *adxl380_event_attributes[] = {
+	&iio_dev_attr_in_accel_gesture_tap_maxtomin_time.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adxl380_event_attribute_group = {
+	.attrs = adxl380_event_attributes,
+};
+
+static int adxl380_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct adxl380_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int adxl380_set_watermark(struct iio_dev *indio_dev, unsigned int val)
+{
+	struct adxl380_state *st  = iio_priv(indio_dev);
+
+	if (val > ADXL380_FIFO_SAMPLES)
+		val = ADXL380_FIFO_SAMPLES;
+
+	st->watermark = val;
+
+	return 0;
+}
+
+static const struct iio_info adxl380_info = {
+	.read_raw = adxl380_read_raw,
+	.read_avail = &adxl380_read_avail,
+	.write_raw = adxl380_write_raw,
+	.write_raw_get_fmt = adxl380_write_raw_get_fmt,
+	.read_event_config = adxl380_read_event_config,
+	.write_event_config = adxl380_write_event_config,
+	.read_event_value = adxl380_read_event_value,
+	.write_event_value = adxl380_write_event_value,
+	.event_attrs = &adxl380_event_attribute_group,
+	.debugfs_reg_access = &adxl380_reg_access,
+	.hwfifo_set_watermark = adxl380_set_watermark,
+};
+
+static const struct iio_event_spec adxl380_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+				       BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+				       BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD),
+	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_SINGLETAP,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_RESET_TIMEOUT),
+	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_DOUBLETAP,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
+				       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
+	},
+};
+
+#define ADXL380_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_CALIBBIAS),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.info_mask_shared_by_all_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |	\
+		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |	\
+		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_BE,					\
+	},								\
+	.event_spec = adxl380_events,					\
+	.num_event_specs = ARRAY_SIZE(adxl380_events)			\
+}
+
+static const struct iio_chan_spec adxl380_channels[] = {
+	ADXL380_ACCEL_CHANNEL(0, ADXL380_X_DATA_H, X),
+	ADXL380_ACCEL_CHANNEL(1, ADXL380_Y_DATA_H, Y),
+	ADXL380_ACCEL_CHANNEL(2, ADXL380_Z_DATA_H, Z),
+	{
+		.type = IIO_TEMP,
+		.address = ADXL380_T_DATA_H,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 12,
+			.storagebits = 16,
+			.shift = 4,
+			.endianness = IIO_BE,
+		},
+	},
+};
+
+static int _adxl380_config_irq(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct irq_data *desc;
+	unsigned long irq_flag;
+	u32 irq_type;
+	u8 polarity;
+	struct adxl380_state *st = iio_priv(indio_dev);
+
+	desc = irq_get_irq_data(st->irq);
+	if (!desc)
+		return dev_err_probe(st->dev, -EINVAL, "Could not find IRQ %d\n", st->irq);
+
+	irq_type = irqd_get_trigger_type(desc);
+	if (irq_type == IRQ_TYPE_LEVEL_HIGH) {
+		polarity = 0;
+		irq_flag = IRQF_TRIGGER_HIGH;
+	} else if (irq_type == IRQ_TYPE_LEVEL_LOW) {
+		polarity = 1;
+		irq_flag = IRQF_TRIGGER_LOW;
+	} else {
+		return dev_err_probe(st->dev, -EINVAL, "Invalid interrupt type 0x%x specified\n",
+			irq_type);
+	}
+
+	ret = regmap_update_bits(st->regmap, ADXL380_INT0,
+				 ADXL380_INT0_POL_MSK,
+				 FIELD_PREP(ADXL380_INT0_POL_MSK, polarity));
+	if (ret)
+		return ret;
+
+	return devm_request_threaded_irq(st->dev, st->irq, NULL,
+					 adxl380_irq_handler,
+					 IRQF_ONESHOT | irq_flag,
+					 indio_dev->name, indio_dev);
+}
+
+static int _adxl380_setup(struct iio_dev *indio_dev)
+{
+	unsigned int reg_val;
+	u16 part_id, chip_id = ADXL380_ID_VAL;
+	int ret, i;
+	struct adxl380_state *st = iio_priv(indio_dev);
+
+	ret = regmap_read(st->regmap, ADXL380_DEVID_AD, &reg_val);
+	if (ret)
+		return ret;
+
+	if (reg_val != ADXL380_DEVID_AD_VAL)
+		dev_warn(st->dev, "Invalid device id %x\n", reg_val);
+
+	ret = regmap_bulk_read(st->regmap, ADLX380_PART_ID,
+			       &st->transf_buf, 2);
+	if (ret)
+		return ret;
+
+	part_id = get_unaligned_be16(st->transf_buf);
+	part_id >>= 4;
+
+	if (part_id != ADXL380_ID_VAL)
+		dev_warn(st->dev, "Invalid part id %x\n", part_id);
+
+	ret = regmap_read(st->regmap, ADXL380_MISC_1, &reg_val);
+	if (ret)
+		return ret;
+
+	/* Bit to differentiate between ADXL380/382. */
+	if (reg_val & BIT(7))
+		chip_id = ADXL382_ID_VAL;
+
+	if (chip_id != st->chip_info->chip_id)
+		dev_warn(st->dev, "Invalid chip id %x\n", chip_id);
+
+	/*
+	 * Perform a software reset to make sure the device is in a consistent
+	 * state after start up.
+	 */
+	ret = regmap_write(st->regmap, ADXL380_RESET, ADXL380_RESET_CODE);
+	if (ret)
+		return ret;
+
+	/* Delay required after software reset. */
+	fsleep(500);
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		ret = regmap_update_bits(st->regmap, ADXL380_DIG_EN,
+					 ADXL380_CHAN_EN_MSK(i),
+					 1 << (4 + i));
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0,
+				 ADXL380_FIFO_MODE_MSK,
+				 FIELD_PREP(ADXL380_FIFO_MODE_MSK, ADXL380_FIFO_STREAMED));
+	if (ret)
+		return ret;
+
+	/* Select all 3 axis for act/inact detection. */
+	ret = regmap_update_bits(st->regmap, ADXL380_SNSR_AXIS_EN,
+				 ADXL380_ACT_INACT_AXIS_EN_MSK,
+				 FIELD_PREP(ADXL380_ACT_INACT_AXIS_EN_MSK, ADXL380_X_Y_Z_AXIS_EN));
+	if (ret)
+		return ret;
+
+	ret = _adxl380_config_irq(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_fill_lpf_tbl(st);
+	if (ret)
+		return ret;
+
+	ret = _adxl380_fill_hpf_tbl(st);
+	if (ret)
+		return ret;
+
+	return _adxl380_set_measure_en(st, true);
+}
+
+int adxl380_probe(struct device *dev, struct regmap *regmap,
+		  int irq, const struct adxl380_chip_info *chip_info)
+{
+	struct iio_dev *indio_dev;
+	struct adxl380_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->dev = dev;
+	st->regmap = regmap;
+	st->irq = irq;
+	st->chip_info = chip_info;
+
+	mutex_init(&st->lock);
+
+	indio_dev->channels = adxl380_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl380_channels);
+	indio_dev->name = chip_info->name;
+	indio_dev->info = &adxl380_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = _adxl380_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_kfifo_buffer_setup_ext(st->dev, indio_dev,
+					      &adxl380_buffer_ops,
+					      adxl380_fifo_attributes);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_NS_GPL(adxl380_probe, IIO_ADXL380);
+
+MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL380 3-axis accelerometer driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/adxl380.h b/drivers/iio/accel/adxl380.h
new file mode 100644
index 000000000000..132d480915be
--- /dev/null
+++ b/drivers/iio/accel/adxl380.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * ADXL380 3-Axis Digital Accelerometer
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#ifndef _ADXL380_H_
+#define _ADXL380_H_
+
+struct adxl380_chip_info {
+	const char *name;
+	const int scale_tbl[3][2];
+	const int samp_freq_tbl[3];
+	const int temp_offset;
+	const u16 chip_id;
+};
+
+extern const struct adxl380_chip_info adxl380_chip_info;
+extern const struct adxl380_chip_info adxl382_chip_info;
+
+int adxl380_probe(struct device *dev, struct regmap *regmap,
+		  int irq, const struct adxl380_chip_info *chip_info);
+bool adxl380_readable_noinc_reg(struct device *dev, unsigned int reg);
+
+#endif /* _ADXL380_H_ */
diff --git a/drivers/iio/accel/adxl380_i2c.c b/drivers/iio/accel/adxl380_i2c.c
new file mode 100644
index 000000000000..b5b846d8c07a
--- /dev/null
+++ b/drivers/iio/accel/adxl380_i2c.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL380 3-Axis Digital Accelerometer I2C driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "adxl380.h"
+
+static const struct regmap_config adxl380_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.readable_noinc_reg = adxl380_readable_noinc_reg,
+};
+
+static int adxl380_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+	const struct adxl380_chip_info *chip_data;
+	const struct i2c_device_id *adxl380;
+
+	chip_data = device_get_match_data(&client->dev);
+	if (!chip_data) {
+		adxl380 = to_i2c_driver(client->dev.driver)->id_table;
+		if (!adxl380)
+			return -EINVAL;
+
+		chip_data = (void *)i2c_match_id(adxl380, client)->driver_data;
+		if (!chip_data)
+			return -EINVAL;
+	}
+
+	regmap = devm_regmap_init_i2c(client, &adxl380_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return adxl380_probe(&client->dev, regmap, client->irq, chip_data);
+}
+
+static const struct i2c_device_id adxl380_i2c_id[] = {
+	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info},
+	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adxl380_i2c_id);
+
+static const struct of_device_id adxl380_of_match[] = {
+	{ .compatible = "adi,adxl380", .data = &adxl380_chip_info},
+	{ .compatible = "adi,adxl382", .data = &adxl382_chip_info},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adxl380_of_match);
+
+static struct i2c_driver adxl380_i2c_driver = {
+	.driver = {
+		.name = "adxl380_i2c",
+		.of_match_table = adxl380_of_match,
+	},
+	.probe = adxl380_i2c_probe,
+	.id_table = adxl380_i2c_id,
+};
+
+module_i2c_driver(adxl380_i2c_driver);
+
+MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL380 3-axis accelerometer I2C driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_ADXL380);
diff --git a/drivers/iio/accel/adxl380_spi.c b/drivers/iio/accel/adxl380_spi.c
new file mode 100644
index 000000000000..13bbe6c0bed1
--- /dev/null
+++ b/drivers/iio/accel/adxl380_spi.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL380 3-Axis Digital Accelerometer SPI driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+
+#include "adxl380.h"
+
+static const struct regmap_config adxl380_spi_regmap_config = {
+	.reg_bits = 7,
+	.pad_bits = 1,
+	.val_bits = 8,
+	.read_flag_mask = BIT(0),
+	.readable_noinc_reg = adxl380_readable_noinc_reg,
+};
+
+static int adxl380_spi_probe(struct spi_device *spi)
+{
+	const struct adxl380_chip_info *chip_data;
+	struct regmap *regmap;
+
+	chip_data = device_get_match_data(&spi->dev);
+	if (!chip_data) {
+		chip_data = (void *)spi_get_device_id(spi)->driver_data;
+
+		if (!chip_data)
+			return -EINVAL;
+	}
+
+	regmap = devm_regmap_init_spi(spi, &adxl380_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return adxl380_probe(&spi->dev, regmap, spi->irq, chip_data);
+}
+
+static const struct spi_device_id adxl380_spi_id[] = {
+	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info },
+	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adxl380_spi_id);
+
+static const struct of_device_id adxl380_of_match[] = {
+	{ .compatible = "adi,adxl380", .data = &adxl380_chip_info },
+	{ .compatible = "adi,adxl382", .data = &adxl382_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adxl380_of_match);
+
+static struct spi_driver adxl380_spi_driver = {
+	.driver = {
+		.name = "adxl380_spi",
+		.of_match_table = adxl380_of_match,
+	},
+	.probe = adxl380_spi_probe,
+	.id_table = adxl380_spi_id,
+};
+
+module_spi_driver(adxl380_spi_driver);
+
+MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL380 3-axis accelerometer SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_ADXL380);
-- 
2.45.2


