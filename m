Return-Path: <linux-iio+bounces-7715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9040937BB6
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 19:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF08E1C21B0A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D774146D6F;
	Fri, 19 Jul 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ucSzdfJW"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43E146A9A;
	Fri, 19 Jul 2024 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410792; cv=none; b=Vlg6EMy8nKtYx3eW/7wtJ1H2JUTAWIaJFk00gDqypGlyO5g653Sms2ckMSDuuGqWeyyQ4Sk351NWhm8lybpiAsEYi6sY0IHZbw2g8E4u+RE+AETg4CKzoRgVaMgKBCYXfBhx88+vXmcj7n4kW9jBL6lrBYqzby0uI/fLfinfwRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410792; c=relaxed/simple;
	bh=El0vuhkSoPwBro3DRvuCHeZsD9YafkcYx0ekgt3x2Mc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SS1EHhP8unxSahKS7Dfsc108XXnc2KPKu0hFMDgW7O3j37gQGWXKVJrsB+uYTQ1IjrNrMcWi3CUWcSs/ALrMe08BfBYgDyn3KGp08VD5yzZMobRYRPMGt55YvNxQRP+H0QjTY11gqCOPuvvO4mERwBVkclJp9YDxzd/p1zkKS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ucSzdfJW; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721410786; x=1752946786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=El0vuhkSoPwBro3DRvuCHeZsD9YafkcYx0ekgt3x2Mc=;
  b=ucSzdfJWmrWnX2AtFAVXSOllMC6DpgKDwnz37tSJWpauZwEAT2PuE9/B
   efST5p3mmeQ1JqpdeDgt60sEIQ1RoXJGTksbuwmgY7mGESerRXNQ7OBwr
   ISxeIUV8KBjtHl6GLhvq0vQ552oMmKogOLDg9Cw5rG47TO7vt0NEEUToV
   AJde8ZVBttipuJFZ4isNsG4XDC1Slxl//kpXrx2fV53IiN2G8N4C+oxPB
   rQC5sCNSAl/1lfZlBIXys9572Y3kCdMoG0JSlak5wrHicQYHYKK3KiDa3
   q/E+yyKvPjX80e9BxNpCZsnmnhxjC+mMD1A4ebRi6MmYNJlQYVOXyjUf4
   A==;
X-CSE-ConnectionGUID: QnXZCxylTLSfBXU/hmrkSg==
X-CSE-MsgGUID: NIxjdeVgSzC4Ux5ix1498Q==
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="29461289"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2024 10:39:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jul 2024 10:39:10 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Jul 2024 10:39:08 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v1 2/2] iio: adc: adding support for PAC194X
Date: Fri, 19 Jul 2024 20:38:55 +0300
Message-ID: <20240719173855.53261-3-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719173855.53261-1-marius.cristea@microchip.com>
References: <20240719173855.53261-1-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

This is the iio driver for Microchip PAC194X and PAC195X
series of Power Monitors with Accumulator.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-pac1944     |    9 +
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1944.c                     | 3528 +++++++++++++++++
 5 files changed, 3558 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
 create mode 100644 drivers/iio/adc/pac1944.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
new file mode 100644
index 000000000000..dbc00b581aa7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
@@ -0,0 +1,9 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistorY
+KernelVersion:	6.10
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The value of the shunt resistor may be known only at runtime
+		and set by a client application. This attribute allows to
+		set its value in micro-ohms. X is the IIO index of the device.
+		Y is the channel number. The value is used to calculate
+		current, power and accumulated energy.
diff --git a/MAINTAINERS b/MAINTAINERS
index bff979a507ba..39287db44cf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14793,6 +14793,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
 F:	drivers/iio/adc/pac1934.c
 
+MICROCHIP PAC1944 ADC DRIVER
+M:	Marius Cristea <marius.cristea@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
+F:	drivers/iio/adc/pac1944.c
+
 MICROCHIP PCI1XXXX GP DRIVER
 M:	Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
 M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5030319249c5..5ec11b07bdc4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -989,6 +989,19 @@ config PAC1934
 	  This driver can also be built as a module. If so, the module
 	  will be called pac1934.
 
+config PAC1944
+	tristate "Microchip Technology PAC1944/PAC1954 driver"
+	depends on I2C
+	depends on IIO
+	help
+	  Say yes here to build support for Microchip Technology's PAC1941,
+	  PAC1941-2, PAC1942, PAC1942-2, PAC1943, PAC1944, PAC1951,
+	  PAC1951-2, PAC1952, PAC1952-2, PAC1953, PAC1954
+	  Single/Multi-Channel Power Monitor with Accumulator.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pac1944.
+
 config PALMAS_GPADC
 	tristate "TI Palmas General Purpose ADC"
 	depends on MFD_PALMAS
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 37ac689a0209..bfc0cb61453d 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
 obj-$(CONFIG_PAC1934) += pac1934.o
+obj-$(CONFIG_PAC1944) += pac1944.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
diff --git a/drivers/iio/adc/pac1944.c b/drivers/iio/adc/pac1944.c
new file mode 100644
index 000000000000..c7540e30f2de
--- /dev/null
+++ b/drivers/iio/adc/pac1944.c
@@ -0,0 +1,3528 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for PAC194X and PAC195X series chips
+ *
+ * Copyright (C) 2022-2024 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Marius Cristea marius.cristea@microchip.com
+ *
+ * Datasheet for PAC1941, PAC1942, PAC1943 and PAC1944 can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
+ * Datasheet for PAC1951, PAC1952, PAC1953 and PAC1954 can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
+#include <asm/unaligned.h>
+
+/*
+ * Maximum (1092 * 60 * 1000), around 1092 minutes@1024 sps
+ * We will keep the refresh lower
+ */
+#define PAC1944_MAX_RFSH_LIMIT_MS		300000
+
+/* 50msec is the timeout for validity of the cached registers */
+#define PAC1944_MIN_POLLING_TIME_MS		50
+/*
+ * 1000usec is the minimum wait time for normal conversions when sample
+ * rate doesn't change
+ */
+#define PAC1944_MIN_UPDATE_WAIT_TIME_US		1000
+
+#define PAC1944_SHUNT_UOHMS_DEFAULT		100000
+
+/* 32000mV */
+#define PAC195X_VOLTAGE_MILLIVOLTS_MAX		32000
+/* 9000mV */
+#define PAC194X_VOLTAGE_MILLIVOLTS_MAX		9000
+
+/*
+ * Voltage bits resolution when set for unsigned values and
+ * HALF FSR signed values
+ */
+#define PAC1944_VOLTAGE_16B_RES			16
+/* Voltage bits resolution when set for signed values */
+#define PAC1944_VOLTAGE_15B_RES			15
+
+/* 100mV maximum voltage drop over the sense resistors */
+#define PAC1944_VSENSE_MILLIVOLTS_MAX		100
+
+/*
+ * Current bits resolution when set for unsigned values and
+ * HALF FSR signed values
+ */
+#define PAC1944_CURRENT_16B_RES			16
+
+/* Current bits resolution when set for signed values */
+#define PAC1944_CURRENT_15B_RES			15
+
+/* Power resolution is 30 bits when unsigned and HALF FSR signed values */
+#define PAC1944_POWER_30B_RES			30
+
+/* Power resolution is 29 bits when signed */
+#define PAC1944_POWER_29B_RES			29
+
+/* Accumulation register is 56 bits long for unipolar range */
+#define PAC1944_ENERGY_56B_RES			56
+
+/* Accumulation register is 56 bits long for bipolar range */
+#define PAC1944_ENERGY_55B_RES			55
+
+/* Maximum power-product value - 32 V * 0.1 V */
+#define PAC195X_PRODUCT_VOLTAGE_PV_FSR		3200000000000UL
+
+/* Maximum power-product value - 9 V * 0.1 V */
+#define PAC194X_PRODUCT_VOLTAGE_PV_FSR		900000000000UL
+
+#define PAC1944_MEAS_REG_SNAPSHOT_LEN		80
+#define PAC1944_CTRL_REG_SNAPSHOT_LEN		24
+
+#define PAC1944_DEFAULT_CHIP_SAMP_SPEED_HZ	1024
+
+/* Device register address map */
+#define PAC1944_REFRESH_REG_ADDR		0x00
+#define PAC1944_CTRL_REG_ADDR			0x01
+#define PAC1944_ACC_COUNT_REG_ADDR		0x02
+#define PAC1944_VACC_1_REG_ADDR			0x03
+#define PAC1944_VACC_2_REG_ADDR			0x04
+#define PAC1944_VACC_3_REG_ADDR			0x05
+#define PAC1944_VACC_4_REG_ADDR			0x06
+#define PAC1944_VBUS_1_ADDR			0x07
+#define PAC1944_VBUS_2_ADDR			0x08
+#define PAC1944_VBUS_3_ADDR			0x09
+#define PAC1944_VBUS_4_ADDR			0x0A
+#define PAC1944_VSENSE_1_ADDR			0x0B
+#define PAC1944_VSENSE_2_ADDR			0x0C
+#define PAC1944_VSENSE_3_ADDR			0x0D
+#define PAC1944_VSENSE_4_ADDR			0x0E
+#define PAC1944_VBUS_AVG_1_ADDR			0x0F
+#define PAC1944_VBUS_AVG_2_ADDR			0x10
+#define PAC1944_VBUS_AVG_3_ADDR			0x11
+#define PAC1944_VBUS_AVG_4_ADDR			0x12
+#define PAC1944_VSENSE_AVG_1_ADDR		0x13
+#define PAC1944_VSENSE_AVG_2_ADDR		0x14
+#define PAC1944_VSENSE_AVG_3_ADDR		0x15
+#define PAC1944_VSENSE_AVG_4_ADDR		0x16
+#define PAC1944_VPOWER_1_ADDR			0x17
+#define PAC1944_VPOWER_2_ADDR			0x18
+#define PAC1944_VPOWER_3_ADDR			0x19
+#define PAC1944_VPOWER_4_ADDR			0x1A
+
+/* Start of configurations registers */
+#define PAC1944_SMBUS_SETTINGS_REGS_ADDR	0x1C
+#define PAC1944_NEG_PWR_FSR_REG_ADDR		0x1D
+#define PAC1944_REFRESG_V_REG_ADDR		0x1E
+#define PAC1944_REFRESH_V_REG_ADDR		0x1F
+#define PAC1944_SLOW_REG_ADDR			0x20
+#define PAC1944_CTRL_ACT_REG_ADDR		0x21
+#define PAC1944_CTRL_LAT_REG_ADDR		0x23
+#define PAC1944_NEG_PWR_FSR_LAT_REG_ADDR	0x24
+#define PAC1944_ACCUM_CFG_REG_ADDR		0x25
+
+/*
+ * Registers related to alert functionality
+ */
+#define PAC1944_ALERT_STATUS_REG_ADDR		0x26
+#define PAC1944_SLOW_ALERT1_REG_ADDR		0x27
+#define PAC1944_GPIO_ALERT2_REG_ADDR		0x28
+#define PAC1944_ACC_FULLNESS_LIMITS_REG_ADDR	0x29
+#define PAC1944_OC_LIMIT_REG_ADDR		0x30
+#define PAC1944_UC_LIMIT_REG_ADDR		0x34
+#define PAC1944_OP_LIMIT_REG_ADDR		0x38
+#define PAC1944_OV_LIMIT_REG_ADDR		0x3C
+#define PAC1944_UV_LIMIT_REG_ADDR		0x40
+#define PAC1944_OC_LIMIT_NSAMPLES_REG_ADDR	0x44
+#define PAC1944_UC_LIMIT_NSAMPLES_REG_ADDR	0x45
+#define PAC1944_OP_LIMIT_NSAMPLES_REG_ADDR	0x46
+#define PAC1944_OV_LIMIT_NSAMPLES_REG_ADDR	0x47
+#define PAC1944_UV_LIMIT_NSAMPLES_REG_ADDR	0x48
+#define PAC1944_ALERT_ENABLE_REG_ADDR		0x49
+
+#define PAC1944_ALERT_ENABLE_REG_LEN		3
+#define PAC1944_ALERTS_REG_LEN			63
+
+#define PAC1944_PID_REG_ADDR			0xFD
+
+/* Alert Enable register */
+#define PAC1944_CH01OC_MASK			BIT(23)
+#define PAC1944_CH01OC_SET			BIT(23)
+#define PAC1944_CH02OC_MASK			BIT(22)
+#define PAC1944_CH02OC_SET			BIT(22)
+#define PAC1944_CH03OC_MASK			BIT(21)
+#define PAC1944_CH03OC_SET			BIT(21)
+#define PAC1944_CH04OC_MASK			BIT(20)
+#define PAC1944_CH04OC_SET			BIT(20)
+#define PAC1944_CH01UC_MASK			BIT(19)
+#define PAC1944_CH01UC_SET			BIT(19)
+#define PAC1944_CH02UC_MASK			BIT(18)
+#define PAC1944_CH02UC_SET			BIT(18)
+#define PAC1944_CH03UC_MASK			BIT(17)
+#define PAC1944_CH03UC_SET			BIT(17)
+#define PAC1944_CH04UC_MASK			BIT(16)
+#define PAC1944_CH04UC_SET			BIT(16)
+
+#define PAC1944_CH01OV_MASK			BIT(15)
+#define PAC1944_CH01OV_SET			BIT(15)
+#define PAC1944_CH02OV_MASK			BIT(14)
+#define PAC1944_CH02OV_SET			BIT(14)
+#define PAC1944_CH03OV_MASK			BIT(13)
+#define PAC1944_CH03OV_SET			BIT(13)
+#define PAC1944_CH04OV_MASK			BIT(12)
+#define PAC1944_CH04OV_SET			BIT(12)
+
+#define PAC1944_CH01UV_MASK			BIT(11)
+#define PAC1944_CH01UV_SET			BIT(11)
+#define PAC1944_CH02UV_MASK			BIT(10)
+#define PAC1944_CH02UV_SET			BIT(10)
+#define PAC1944_CH03UV_MASK			BIT(9)
+#define PAC1944_CH03UV_SET			BIT(9)
+#define PAC1944_CH04UV_MASK			BIT(8)
+#define PAC1944_CH04UV_SET			BIT(8)
+
+#define PAC1944_CH01OP_MASK			BIT(7)
+#define PAC1944_CH01OP_SET			BIT(7)
+#define PAC1944_CH02OP_MASK			BIT(6)
+#define PAC1944_CH02OP_SET			BIT(6)
+#define PAC1944_CH03OP_MASK			BIT(5)
+#define PAC1944_CH03OP_SET			BIT(5)
+#define PAC1944_CH04OP_MASK			BIT(4)
+#define PAC1944_CH04OP_SET			BIT(4)
+
+#define PAC1944_ACC_OVF_MASK			BIT(3)
+#define PAC1944_ACC_OVF_SET			BIT(3)
+
+#define PAC1944_ACC_COUNT_MASK			BIT(2)
+#define PAC1944_ACC_COUNT_SET			BIT(2)
+
+#define PAC1944_ALERT_CC1_MASK			BIT(1)
+#define PAC1944_ALERT_CC1_SET			BIT(1)
+
+#define PAC1944_ACC_REG_LEN			4
+#define PAC1944_VACC_REG_LEN			7
+#define PAC1944_VBUS_SENSE_REG_LEN		2
+#define PAC1944_VPOWER_REG_LEN			4
+#define PAC1944_CTRL_ACT_REG_LEN		2
+#define PAC1944_CTRL_LAT_REG_LEN		2
+#define PAC1944_MAX_REGISTER_LEN		6
+
+#define PAC1944_COMMON_DEVATTR			6
+#define PAC1944_ACC_DEVATTR			3
+#define PAC1944_SHARED_DEVATTRS_COUNT		5
+
+#define PAC1944_MID				0x5D
+#define PAC194x54_PID				0x5B
+#define PAC194x53_PID				0x5A
+#define PAC194x52_PID				0x59
+#define PAC194x51_PID				0x58
+
+#define PAC1944_MAX_CH				4
+
+/* PAC194X family */
+#define PAC_PRODUCT_ID_1941_1			0x68
+#define PAC_PRODUCT_ID_1942_1			0x69
+#define PAC_PRODUCT_ID_1943_1			0x6A
+#define PAC_PRODUCT_ID_1944_1			0x6B
+#define PAC_PRODUCT_ID_1941_2			0x6C
+#define PAC_PRODUCT_ID_1942_2			0x6D
+/* PAC195x family */
+#define PAC_PRODUCT_ID_1951_1			0x78
+#define PAC_PRODUCT_ID_1952_1			0x79
+#define PAC_PRODUCT_ID_1953_1			0x7A
+#define PAC_PRODUCT_ID_1954_1			0x7B
+#define PAC_PRODUCT_ID_1951_2			0x7C
+#define PAC_PRODUCT_ID_1952_2			0x7D
+
+#define PAC1944_ALERT				0x00
+#define PAC1944_GPIO_INPUT			0x01
+#define PAC1944_GPIO_OUTPUT			0x02
+#define PAC1944_SLOW				0x03
+
+#define PAC1944_CTRL_SAMPLE_MASK		GENMASK(15, 12)
+#define PAC1944_CTRL_GPIO_ALERT2_MASK		GENMASK(11, 10)
+#define PAC1944_CTRL_SLOW_ALERT1_MASK		GENMASK(9, 8)
+#define PAC1944_CTRL_CH_1_OFF_MASK		BIT(7)
+#define PAC1944_CTRL_CH_2_OFF_MASK		BIT(6)
+#define PAC1944_CTRL_CH_3_OFF_MASK		BIT(5)
+#define PAC1944_CTRL_CH_4_OFF_MASK		BIT(4)
+
+#define PAC1944_NEG_PWR_CFG_VS1_MASK		GENMASK(15, 14)
+#define PAC1944_NEG_PWR_CFG_VS2_MASK		GENMASK(13, 12)
+#define PAC1944_NEG_PWR_CFG_VS3_MASK		GENMASK(11, 10)
+#define PAC1944_NEG_PWR_CFG_VS4_MASK		GENMASK(9, 8)
+#define PAC1944_NEG_PWR_CFG_VB1_MASK		GENMASK(7, 6)
+#define PAC1944_NEG_PWR_CFG_VB3_MASK		GENMASK(5, 4)
+#define PAC1944_NEG_PWR_CFG_VB2_MASK		GENMASK(3, 2)
+#define PAC1944_NEG_PWR_CFG_VB4_MASK		GENMASK(1, 0)
+
+#define PAC1944_CFG_ACC4_SHIFT			0
+#define PAC1944_CFG_ACC3_SHIFT			2
+#define PAC1944_CFG_ACC2_SHIFT			4
+#define PAC1944_CFG_ACC1_SHIFT			6
+
+#define PAC1944_ACPI_GET_NAMES			1
+#define PAC1944_ACPI_GET_UOHMS_VALS		2
+#define PAC1944_ACPI_GET_BIPOLAR_SETTINGS	4
+#define PAC1944_ACPI_GET_SAMP			5
+
+/*
+ * Universal Unique Identifier (UUID),
+ * 721F1534-5D27-4B60-9DF4-41A3C4B7DA3A,
+ * is reserved to Microchip for the PAC194x and PAC195x.
+ */
+#define PAC1944_DSM_UUID	"721F1534-5D27-4B60-9DF4-41A3C4B7DA3A"
+
+#define ACCUM_REG(acc1_cfg, acc2_cfg, acc3_cfg, acc4_cfg)		   \
+			((((acc1_cfg) & 0x03) << PAC1944_CFG_ACC1_SHIFT) | \
+			 (((acc2_cfg) & 0x03) << PAC1944_CFG_ACC2_SHIFT) | \
+			 (((acc3_cfg) & 0x03) << PAC1944_CFG_ACC3_SHIFT) | \
+			 (((acc4_cfg) & 0x03) << PAC1944_CFG_ACC4_SHIFT))
+
+/*
+ * Accumulated power/energy formula (in mW-seconds):
+ * Energy = (Vacc/10^9)*[(10^9/2^30)*2^9]*3.2*10^3/Rsense
+ * Vacc - is the accumulated value per second
+ * Rsense - value of the shunt resistor in microOhms
+ *
+ * PAC195X_MAX_VPOWER_RSHIFTED_BY_29B = 3.2*((10^9)/(2^29))*10^9
+ * will be used to calculate the scale for accumulated power/energy
+ */
+#define PAC195X_MAX_VPOWER_RSHIFTED_BY_29B	5960464478UL
+
+/*
+ * PAC194X_MAX_VPOWER_RSHIFTED_BY_29B = 0.9*((10^9)/(2^29))*10^9
+ * will be used to calculate the scale for accumulated power/energy
+ */
+#define PAC194X_MAX_VPOWER_RSHIFTED_BY_29B	1676380634UL
+
+/* (100mV * 1000000) / (2^15)  used to calculate the scale for current */
+#define PAC1944_MAX_VSENSE_RSHIFTED_BY_15B	3052
+
+/*
+ * [(100mV * 1000000) / (2^15)]*10^9  used to calculate the scale
+ * for accumulated current/Coulomb counter
+ */
+#define PAC1944_MAX_VSENSE_NANO			3051757812500UL
+
+#define TO_PAC1944_CHIP_INFO(d) container_of(d, struct pac1944_chip_info, work_chip_rfsh)
+
+/*
+ * these indexes are exactly describing the element order within a single
+ * PAC1944/54 phys channel IIO channel descriptor; see the static const struct
+ * iio_chan_spec pac1944_single_channel[] declaration
+ */
+enum pac1944_ch_idx {
+	PAC1944_CH_POWER,
+	PAC1944_CH_VOLTAGE,
+	PAC1944_CH_CURRENT,
+	PAC1944_CH_VOLTAGE_AVERAGE,
+	PAC1944_CH_CURRENT_AVERAGE
+};
+
+/* IDs ordered based on Product ID */
+enum pac1944_ids {
+	PAC1941_1,
+	PAC1942_1,
+	PAC1943_1,
+	PAC1944_1,
+	PAC1941_2,
+	PAC1942_2,
+	PAC1951_1,
+	PAC1952_1,
+	PAC1953_1,
+	PAC1954_1,
+	PAC1951_2,
+	PAC1952_2
+};
+
+enum pac1944_acc_mode {
+	PAC1944_ACCMODE_VPOWER,
+	PAC1944_ACCMODE_VSENSE,
+	PAC1944_ACCMODE_VBUS
+};
+
+enum pac1944_ {
+	PAC1944_UNIPOLAR_FSR_CFG,
+	PAC1944_BIPOLAR_FSR_CFG,
+	PAC1944_BIPOLAR_HALF_FSR_CFG
+};
+
+enum pac1944_samps {
+	PAC1944_SAMP_1024SPS_ADAPT,
+	PAC1944_SAMP_256SPS_ADAPT,
+	PAC1944_SAMP_64SPS_ADAPT,
+	PAC1944_SAMP_8SPS_ADAPT,
+
+	PAC1944_SAMP_1024SPS,
+	PAC1944_SAMP_256SPS,
+	PAC1944_SAMP_64SPS,
+	PAC1944_SAMP_8SPS,
+
+	PAC1944_SAMP_SINGLE_SHOT,
+	PAC1944_SAMP_SINGLE_SHOT_8X,
+	PAC1944_SAMP_FAST_MODE,
+	PAC1944_SAMP_BURST_MODE,
+
+	PAC1944_RESERVED1,
+	PAC1944_RESERVED2,
+	PAC1944_RESERVED3,
+	PAC1944_RESERVED4
+};
+
+enum pac1944_number_of_active_channels {
+	PAC1944_1_CHANNEL_ACTIVE,
+	PAC1944_2_CHANNELS_ACTIVE,
+	PAC1944_3_CHANNELS_ACTIVE,
+	PAC1944_4_CHANNELS_ACTIVE,
+};
+
+static const unsigned int samp_rate_map_tbl[] = {
+	[PAC1944_SAMP_1024SPS_ADAPT] = 1024,
+	[PAC1944_SAMP_256SPS_ADAPT] = 256,
+	[PAC1944_SAMP_64SPS_ADAPT] = 64,
+	[PAC1944_SAMP_8SPS_ADAPT] = 8,
+	[PAC1944_SAMP_1024SPS] = 1024,
+	[PAC1944_SAMP_256SPS] = 256,
+	[PAC1944_SAMP_64SPS] = 64,
+	[PAC1944_SAMP_8SPS] = 8,
+	[PAC1944_SAMP_SINGLE_SHOT] = 1,
+	[PAC1944_SAMP_SINGLE_SHOT_8X] = 8,
+	[PAC1944_SAMP_FAST_MODE] = 0xff,
+	[PAC1944_SAMP_BURST_MODE] = 0xff,
+	[PAC1944_RESERVED1] = 0xff,
+	[PAC1944_RESERVED2] = 0xff,
+	[PAC1944_RESERVED3] = 0xff,
+	[PAC1944_RESERVED4] = 0xff
+};
+
+static const unsigned int shift_map_tbl[] = {
+	[PAC1944_SAMP_1024SPS_ADAPT] = 10,
+	[PAC1944_SAMP_256SPS_ADAPT] = 10,
+	[PAC1944_SAMP_64SPS_ADAPT] = 10,
+	[PAC1944_SAMP_8SPS_ADAPT] = 10,
+	[PAC1944_SAMP_1024SPS] = 10,
+	[PAC1944_SAMP_256SPS] = 8,
+	[PAC1944_SAMP_64SPS] = 6,
+	[PAC1944_SAMP_8SPS] = 3,
+	[PAC1944_SAMP_SINGLE_SHOT] = 10,
+	[PAC1944_SAMP_SINGLE_SHOT_8X] = 8,
+	[PAC1944_SAMP_FAST_MODE] = 0xff,
+	[PAC1944_SAMP_BURST_MODE] = 0xff,
+	[PAC1944_RESERVED1] = 0xff,
+	[PAC1944_RESERVED2] = 0xff,
+	[PAC1944_RESERVED3] = 0xff,
+	[PAC1944_RESERVED4] = 0xff
+};
+
+static const unsigned int samp_rate_burst_mode_tbl[] = {
+	[PAC1944_1_CHANNEL_ACTIVE] = 5120,
+	[PAC1944_2_CHANNELS_ACTIVE] = 2560,
+	[PAC1944_3_CHANNELS_ACTIVE] = 1706,
+	[PAC1944_4_CHANNELS_ACTIVE] = 1280
+};
+
+static const unsigned int samp_rate_fast_mode_tbl[] = {
+	[PAC1944_1_CHANNEL_ACTIVE] = 2560,
+	[PAC1944_2_CHANNELS_ACTIVE] = 1707,
+	[PAC1944_3_CHANNELS_ACTIVE] = 1280,
+	[PAC1944_4_CHANNELS_ACTIVE] = 1024
+};
+
+/* Available Sample Modes */
+static const char * const pac1944_frequency_avail[] = {
+	"1024_ADAP",
+	"256_ADAP",
+	"64_ADAP",
+	"8_ADAP",
+	"1024",
+	"256",
+	"64",
+	"8",
+	"single_shot_1x",
+	"single_shot_8x",
+	"fast",
+	"burst"
+};
+
+/**
+ * struct reg_data - data from the registers
+ * @vsense_mode:array of values, Full Scale Range (FSR) mode for V Sense
+ * @vbus_mode: array of values, Full Scale Range (FSR) mode for V Bus
+ * @accumulation_mode: array of values, accumulation mode for V Acc
+ * @meas_regs: snapshot of raw measurements registers
+ * @ctrl_act_reg: snapshot of the ctrl_act register
+ * @ctrl_lat_reg: snapshot of the ctrl_lat register
+ * @acc_count: snapshot of the acc_count register
+ * @total_samples_nr: accumulated values for acc_count (total number of samples)
+ * @acc_val: accumulated values per second
+ * @vacc: accumulated vpower values
+ * @vpower: snapshot of vpower registers
+ * @vbus: snapshot of vbus registers
+ * @vbus_avg: averages of vbus registers
+ * @vsense: snapshot of vsense registers
+ * @vsense_avg: averages of vsense registers
+ * @jiffies_tstamp: chip's uptime
+ */
+struct reg_data {
+	u8	vbus_mode[PAC1944_MAX_CH];
+	u8	vsense_mode[PAC1944_MAX_CH];
+	u8	accumulation_mode[PAC1944_MAX_CH];
+	u8	meas_regs[PAC1944_MEAS_REG_SNAPSHOT_LEN];
+	u16	ctrl_act_reg;
+	u16	ctrl_lat_reg;
+	u32	acc_count;
+	u32	total_samples_nr[PAC1944_MAX_CH];
+	s64	acc_val[PAC1944_MAX_CH];
+	s64	vacc[PAC1944_MAX_CH];
+	s32	vpower[PAC1944_MAX_CH];
+	s32	vbus[PAC1944_MAX_CH];
+	s32	vbus_avg[PAC1944_MAX_CH];
+	s32	vsense[PAC1944_MAX_CH];
+	s32	vsense_avg[PAC1944_MAX_CH];
+	unsigned long jiffies_tstamp;
+};
+
+/**
+ * struct pac1944_chip_info - chip configuration
+ * @channels: array of values, true means that channel is active
+ * @iio_info: pointer to iio_info structure
+ * @client: a pointer to the i2c client associated with the device
+ * @lock: lock to prevent concurrent reads/writes
+ * @work_chip_rfsh: chip refresh workqueue implementation
+ * @phys_channels: number of physical channels for the device
+ * @active_channels: array of values, true means that channel is active
+ * @chip_variant: stores the type of the device
+ * @chip_revision: store the silicon revision version of the device
+ * @shunts: array of values, shunt resistor values
+ * @chip_reg_data: pointer to structure, containing data from the device registers
+ * @sample_rate_value: sampling frequency
+ * @labels: array of string, name of each channel
+ * @is_pac195x_family: true if device is part of the PAC195x family
+ * @sampling_mode: sampling mode used by the device
+ * @num_enabled_channels: count of how many chip channels are currently enabled
+ * @slow_alert1: snapshot of slow/alert register
+ * @gpio_alert2: snapshot of gpio/alert register
+ * @acc_fullness: snapshot of accumulator fullness limit register
+ * @overcurrent: array of values, overcurrent limit
+ * @undercurrent: array of values, undercurrent limit
+ * @overpower: array of values, overpower limit
+ * @overvoltage:  array of values, overvoltage limit
+ * @undervoltage: array of values, undervoltage limit
+ * @oc_limit_nsamples: number of consecutive samples exceeding the overcurrent limit
+ * @uc_limit_nsamples: number of consecutive samples exceeding the undercurrent limit
+ * @op_limit_nsamples: number of consecutive samples exceeding the overpower limit
+ * @ov_limit_nsamples: number of consecutive samples exceeding the overvoltage limit
+ * @uv_limit_nsamples: number of consecutive samples exceeding the undervoltage limit
+ * @alert_enable: snapshot of alert enable register
+ * @enable_acc: array of values, true means that accumulation channel is measured
+ */
+struct pac1944_chip_info {
+	const struct iio_chan_spec  *channels;
+	struct iio_info		iio_info;
+	struct i2c_client	*client;
+	struct mutex		lock; /* lock to prevent concurrent reads/writes */
+	struct delayed_work	work_chip_rfsh;
+	u8		phys_channels;
+	bool		active_channels[PAC1944_MAX_CH];
+	u8		chip_variant;
+	u8		chip_revision;
+	u32		shunts[PAC1944_MAX_CH];
+	struct reg_data chip_reg_data;
+	s32		sample_rate_value;
+	char		*labels[PAC1944_MAX_CH];
+	bool		is_pac195x_family;
+	u8		sampling_mode;
+	u8		num_enabled_channels;
+	u32		slow_alert1;
+	u32		gpio_alert2;
+	u16		acc_fullness;
+	u16		overcurrent[PAC1944_MAX_CH];
+	u16		undercurrent[PAC1944_MAX_CH];
+	u32		overpower[PAC1944_MAX_CH];
+	u16		overvoltage[PAC1944_MAX_CH];
+	u16		undervoltage[PAC1944_MAX_CH];
+	u8		oc_limit_nsamples[PAC1944_MAX_CH];
+	u8		uc_limit_nsamples[PAC1944_MAX_CH];
+	u8		op_limit_nsamples[PAC1944_MAX_CH];
+	u8		ov_limit_nsamples[PAC1944_MAX_CH];
+	u8		uv_limit_nsamples[PAC1944_MAX_CH];
+	u32		alert_enable;
+	bool		enable_acc[PAC1944_MAX_CH];
+};
+
+/**
+ * struct pac1944_features - features of a pac194x instance
+ * @phys_channels:	number of physical channels supported by the chip
+ * @prod_id:		hardware ID
+ * @name:		chip's name
+ */
+struct pac1944_features {
+	u8 phys_channels;
+	u8 prod_id;
+	const char *name;
+};
+
+static const struct pac1944_features pac1944_chip_config[] = {
+	/* PAC194X Family */
+	[PAC1941_1] = {
+		.phys_channels = 1,
+		.prod_id = PAC_PRODUCT_ID_1941_1,
+		.name = "pac1941_1",
+	},
+	[PAC1942_1] = {
+		.phys_channels = 2,
+		.prod_id = PAC_PRODUCT_ID_1942_1,
+		.name = "pac1942_1",
+	},
+	[PAC1943_1] = {
+		.phys_channels = 3,
+		.prod_id = PAC_PRODUCT_ID_1943_1,
+		.name = "pac1943_1",
+	},
+	[PAC1944_1] = {
+		.phys_channels = 4,
+		.prod_id = PAC_PRODUCT_ID_1944_1,
+		.name = "pac1944_1",
+	},
+	[PAC1941_2] = {
+		.phys_channels = 1,
+		.prod_id = PAC_PRODUCT_ID_1941_2,
+		.name = "pac1941_2",
+	},
+	[PAC1942_2] = {
+		.phys_channels = 2,
+		.prod_id = PAC_PRODUCT_ID_1942_2,
+		.name = "pac1942_2",
+	},
+	/* PAC195X Family */
+	[PAC1951_1] = {
+		.phys_channels = 1,
+		.prod_id = PAC_PRODUCT_ID_1951_1,
+		.name = "pac1951_1",
+	},
+	[PAC1952_1] = {
+		.phys_channels = 2,
+		.prod_id = PAC_PRODUCT_ID_1952_1,
+		.name = "pac1952_1",
+	},
+	[PAC1953_1] = {
+		.phys_channels = 3,
+		.prod_id = PAC_PRODUCT_ID_1953_1,
+		.name = "pac1953_1",
+	},
+	[PAC1954_1] = {
+		.phys_channels = 4,
+		.prod_id = PAC_PRODUCT_ID_1954_1,
+		.name = "pac1954_1",
+	},
+	[PAC1951_2] = {
+		.phys_channels = 1,
+		.prod_id = PAC_PRODUCT_ID_1951_2,
+		.name = "pac1951_2",
+	},
+	[PAC1952_2] = {
+		.phys_channels = 2,
+		.prod_id = PAC_PRODUCT_ID_1952_2,
+		.name = "pac1952_2",
+	},
+};
+
+static inline u64 pac1944_get_unaligned_be56(u8 *p)
+{
+	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
+		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
+}
+
+/* Low-level I2c functions used to transfer more then 32 bytes at once */
+static int pac1944_i2c_read(struct i2c_client *client, u8 reg_addr,
+			    void *databuf, u8 len)
+{
+	struct i2c_msg msgs[2] = {
+		{ .addr = client->addr,
+		 .len = 1,
+		 .buf = (u8 *)&reg_addr,
+		 .flags = 0
+		},
+		{ .addr = client->addr,
+		 .len = len,
+		 .buf = databuf,
+		 .flags = I2C_M_RD
+		}
+	};
+
+	return i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+}
+
+static int pac1944_disable_alert_reg(struct device *dev, u32 mask, u8 *status)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret;
+	u32 val;
+	u8 buf[PAC1944_ALERT_ENABLE_REG_LEN];
+
+	ret = i2c_smbus_read_i2c_block_data(client,
+					    PAC1944_ALERT_ENABLE_REG_ADDR,
+					    PAC1944_ALERT_ENABLE_REG_LEN,
+					    status);
+	if (ret < 0) {
+		dev_err(dev, "failing %s\n", __func__);
+		return ret;
+	}
+
+	val =  get_unaligned_be24(status);
+	val = val & (~mask);
+	put_unaligned_be24(val, &buf[0]);
+
+	/* disable appropriate bit from the Alert enable register */
+	ret =  i2c_smbus_write_block_data(client, PAC1944_ALERT_ENABLE_REG_ADDR,
+					  PAC1944_ALERT_ENABLE_REG_LEN,
+					  (u8 *)&buf[0]);
+
+	return ret;
+}
+
+static int pac1944_restore_alert_reg(struct iio_dev *indio_dev, u8 *status)
+{
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret;
+
+	/* restoring the Alert enable register */
+	ret =  i2c_smbus_write_block_data(client, PAC1944_ALERT_ENABLE_REG_ADDR,
+					  PAC1944_ALERT_ENABLE_REG_LEN, status);
+	if (ret) {
+		dev_err(&client->dev, "failing to write %s\n", __func__);
+		return ret;
+	}
+
+	/* Sending a REFRESH_V to the chip, so the new settings take place */
+	ret = i2c_smbus_write_byte(info->client, PAC1944_REFRESH_V_REG_ADDR);
+	if (ret)
+		dev_err(&client->dev, "cannot send REFRESH_V\n");
+
+	return ret;
+}
+
+static int pac1944_update_alert_byte_data(struct device *dev, u8 addr,
+					  u32 mask, u8 value)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret;
+	u8 status[PAC1944_ALERT_ENABLE_REG_LEN];
+
+	ret = pac1944_disable_alert_reg(dev, mask, &status[0]);
+	if (ret) {
+		dev_err(dev, "failing to write %s\n", __func__);
+		return ret;
+	}
+
+	ret = i2c_smbus_write_byte_data(client, addr, value);
+	if (ret) {
+		dev_err(dev, "failing to write %s\n", __func__);
+		return ret;
+	}
+
+	return pac1944_restore_alert_reg(indio_dev, &status[0]);
+}
+
+static int pac1944_update_alert_16b(struct device *dev, u8 addr,
+				    u32 mask, u16 value)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret;
+	u16 tmp;
+	u8 status[PAC1944_ALERT_ENABLE_REG_LEN];
+
+	ret = pac1944_disable_alert_reg(dev, mask, &status[0]);
+	if (ret) {
+		dev_err(dev, "failing to write %s\n", __func__);
+		return ret;
+	}
+
+	tmp = value;
+	cpu_to_be16s(&tmp);
+
+	ret = i2c_smbus_write_word_data(client, addr, tmp);
+	if (ret) {
+		dev_err(dev, "failing to write %s\n", __func__);
+		return ret;
+	}
+
+	return pac1944_restore_alert_reg(indio_dev, &status[0]);
+}
+
+static int pac1944_update_alert_24b(struct device *dev, u8 addr,
+				    int mask, u32 value)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret;
+	u8 status[PAC1944_ALERT_ENABLE_REG_LEN], tmp[3];
+
+	ret = pac1944_disable_alert_reg(dev, mask, &status[0]);
+	if (ret) {
+		dev_err(dev, "failing to write %s\n", __func__);
+		return ret;
+	}
+
+	put_unaligned_be24(value, &tmp[0]);
+
+	ret =  i2c_smbus_write_block_data(client, addr, ARRAY_SIZE(tmp), (u8 *)&tmp[0]);
+	if (ret) {
+		dev_err(dev, "failing to write %s\n", __func__);
+		return ret;
+	}
+
+	return pac1944_restore_alert_reg(indio_dev, &status[0]);
+}
+
+/* Custom IIO Device Attributes */
+static ssize_t pac1944_shunt_value_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	return sysfs_emit(buf, "%u\n", info->shunts[this_attr->address]);
+}
+
+static ssize_t pac1944_shunt_value_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int sh_val;
+
+	if (kstrtouint(buf, 10, &sh_val)) {
+		dev_err(dev, "Shunt value is not valid\n");
+		return -EINVAL;
+	}
+
+	scoped_guard(mutex, &info->lock)
+		info->shunts[this_attr->address] = sh_val;
+
+	return count;
+}
+
+static ssize_t pac1944_acc_fullness_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%u\n", info->acc_fullness);
+}
+
+static ssize_t pac1944_acc_fullness_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	int ret;
+	u16 val;
+
+	if (kstrtou16(buf, 10, &val)) {
+		dev_err(dev, "value is not valid\n");
+		return -EINVAL;
+	}
+
+	scoped_guard(mutex, &info->lock) {
+		ret = pac1944_update_alert_16b(dev, PAC1944_ACC_FULLNESS_LIMITS_REG_ADDR,
+					       (int)(0xffffff), val);
+		if (!ret)
+			info->acc_fullness = val;
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_oc_limit_nsamples_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	return sysfs_emit(buf, "%u\n", info->oc_limit_nsamples[this_attr->address]);
+}
+
+static ssize_t pac1944_oc_limit_nsamples_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret, idx;
+	u8 val, val_tmp;
+
+	ret = kstrtou8(buf, 10, &val_tmp);
+	if (ret)
+		return ret;
+
+	if (val_tmp > 3)
+		return -EINVAL;
+
+	idx = this_attr->address;
+
+	scoped_guard(mutex, &info->lock) {
+		val = val_tmp << (6 - (idx * 2));
+		ret = pac1944_update_alert_byte_data(dev, PAC1944_OC_LIMIT_NSAMPLES_REG_ADDR,
+						     (int)(PAC1944_CH01OC_MASK >> idx), val);
+		if (!ret)
+			info->oc_limit_nsamples[idx] = val_tmp;
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_uc_limit_nsamples_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	return sysfs_emit(buf, "%u\n", info->uc_limit_nsamples[this_attr->address]);
+}
+
+static ssize_t pac1944_uc_limit_nsamples_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret, idx;
+	u8 val, val_tmp;
+
+	ret = kstrtou8(buf, 10, &val_tmp);
+	if (ret)
+		return ret;
+
+	if (val_tmp > 3)
+		return -EINVAL;
+
+	idx = this_attr->address;
+
+	scoped_guard(mutex, &info->lock) {
+		val = val_tmp << (6 - (idx * 2));
+		ret = pac1944_update_alert_byte_data(dev, PAC1944_UC_LIMIT_NSAMPLES_REG_ADDR,
+						     (int)(PAC1944_CH01UC_MASK >> idx), val);
+		if (!ret)
+			info->uc_limit_nsamples[idx] = val_tmp;
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_op_limit_nsamples_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	return sysfs_emit(buf, "%u\n", info->op_limit_nsamples[this_attr->address]);
+}
+
+static ssize_t pac1944_op_limit_nsamples_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret, idx;
+	u8 val, val_tmp;
+
+	ret = kstrtou8(buf, 10, &val_tmp);
+	if (ret)
+		return ret;
+
+	if (val_tmp > 3)
+		return -EINVAL;
+
+	idx = this_attr->address;
+
+	scoped_guard(mutex, &info->lock) {
+		val = val_tmp << (6 - (idx * 2));
+		ret = pac1944_update_alert_byte_data(dev, PAC1944_OP_LIMIT_NSAMPLES_REG_ADDR,
+						     (int)(PAC1944_CH01OP_MASK >> idx), val);
+		if (!ret)
+			info->op_limit_nsamples[idx] = val_tmp;
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_ov_limit_nsamples_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	return sysfs_emit(buf, "%u\n", info->ov_limit_nsamples[this_attr->address]);
+}
+
+static ssize_t pac1944_ov_limit_nsamples_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret, idx;
+	u8 val, val_tmp;
+
+	ret = kstrtou8(buf, 10, &val_tmp);
+	if (ret)
+		return ret;
+
+	if (val_tmp > 3)
+		return -EINVAL;
+
+	idx  = this_attr->address;
+
+	scoped_guard(mutex, &info->lock) {
+		val = val_tmp << (6 - (idx * 2));
+		ret = pac1944_update_alert_byte_data(dev, PAC1944_OV_LIMIT_NSAMPLES_REG_ADDR,
+						     (int)(PAC1944_CH01OV_MASK >> idx), val);
+		if (!ret)
+			info->ov_limit_nsamples[idx] = val_tmp;
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_uv_limit_nsamples_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	return sysfs_emit(buf, "%d\n", info->uv_limit_nsamples[this_attr->address]);
+}
+
+static ssize_t pac1944_uv_limit_nsamples_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret, idx;
+	u8 val, val_tmp;
+
+	ret = kstrtou8(buf, 10, &val_tmp);
+	if (ret)
+		return ret;
+
+	if (val_tmp > 3)
+		return -EINVAL;
+
+	idx  = this_attr->address;
+
+	scoped_guard(mutex, &info->lock) {
+		val = val_tmp << (6 - (idx * 2));
+		ret = pac1944_update_alert_byte_data(dev, PAC1944_UV_LIMIT_NSAMPLES_REG_ADDR,
+						     (int)(PAC1944_CH01UV_MASK >> idx), val);
+		if (!ret)
+			info->uv_limit_nsamples[idx] = val_tmp;
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_alert_enable_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%u\n", info->alert_enable);
+}
+
+static ssize_t pac1944_alert_enable_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	int ret;
+	u32 val;
+	u8 tmp[PAC1944_ALERT_ENABLE_REG_LEN];
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return -EINVAL;
+
+	put_unaligned_be24(val, &tmp[0]);
+
+	scoped_guard(mutex, &info->lock) {
+		ret = pac1944_restore_alert_reg(indio_dev, &tmp[0]);
+		if (ret) {
+			dev_err(dev, "failing to write %s\n", __func__);
+			return ret;
+		}
+
+		info->alert_enable = val;
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_slow_alert_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%u\n", info->slow_alert1);
+}
+
+static ssize_t pac1944_slow_alert_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret;
+	u32 val;
+	u8 tmp[3];
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return -EINVAL;
+
+	put_unaligned_be24(val, &tmp[0]);
+
+	scoped_guard(mutex, &info->lock) {
+		ret =  i2c_smbus_write_block_data(client, PAC1944_SLOW_ALERT1_REG_ADDR,
+						  ARRAY_SIZE(tmp), (u8 *)&tmp[0]);
+		if (ret) {
+			dev_err(dev, "failing to write %s\n", __func__);
+			return ret;
+		}
+
+		info->slow_alert1 = val;
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_gpio_alert_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%u\n", info->gpio_alert2);
+}
+
+static ssize_t pac1944_gpio_alert_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret;
+	u32 val;
+	u8 tmp[3];
+
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return -EINVAL;
+
+	put_unaligned_be24(val, &tmp[0]);
+
+	scoped_guard(mutex, &info->lock) {
+		ret =  i2c_smbus_write_block_data(client, PAC1944_GPIO_ALERT2_REG_ADDR,
+						  ARRAY_SIZE(tmp), (u8 *)&tmp[0]);
+		if (ret) {
+			dev_err(dev, "failing to write %s\n", __func__);
+			return ret;
+		}
+
+		info->gpio_alert2 = val;
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_alert_status_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret;
+	u32 tmp;
+	u8 status[3];
+
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_ALERT_STATUS_REG_ADDR,
+					    ARRAY_SIZE(status), (u8 *)status);
+	if (ret < 0) {
+		dev_err(dev, "%s - cannot read PAC1944 regs from 0x%02X\n",
+			__func__, PAC1944_ALERT_STATUS_REG_ADDR);
+		return 0;
+	}
+	tmp =  get_unaligned_be24(&status[0]);
+
+	return sysfs_emit(buf, "%u\n", tmp);
+}
+
+static IIO_DEVICE_ATTR(in_shunt_resistor1, 0644,
+		       pac1944_shunt_value_show, pac1944_shunt_value_store, 0);
+static IIO_DEVICE_ATTR(in_oc_limit_nsamples1, 0644,
+		       pac1944_oc_limit_nsamples_show, pac1944_oc_limit_nsamples_store, 0);
+static IIO_DEVICE_ATTR(in_uc_limit_nsamples1, 0644,
+		       pac1944_uc_limit_nsamples_show, pac1944_uc_limit_nsamples_store, 0);
+static IIO_DEVICE_ATTR(in_op_limit_nsamples1, 0644,
+		       pac1944_op_limit_nsamples_show, pac1944_op_limit_nsamples_store, 0);
+static IIO_DEVICE_ATTR(in_ov_limit_nsamples1, 0644,
+		       pac1944_ov_limit_nsamples_show, pac1944_ov_limit_nsamples_store, 0);
+static IIO_DEVICE_ATTR(in_uv_limit_nsamples1, 0644,
+		       pac1944_uv_limit_nsamples_show, pac1944_uv_limit_nsamples_store, 0);
+
+static IIO_DEVICE_ATTR(in_shunt_resistor2, 0644,
+		       pac1944_shunt_value_show, pac1944_shunt_value_store, 1);
+static IIO_DEVICE_ATTR(in_oc_limit_nsamples2, 0644,
+		       pac1944_oc_limit_nsamples_show, pac1944_oc_limit_nsamples_store, 1);
+static IIO_DEVICE_ATTR(in_uc_limit_nsamples2, 0644,
+		       pac1944_uc_limit_nsamples_show, pac1944_uc_limit_nsamples_store, 1);
+static IIO_DEVICE_ATTR(in_op_limit_nsamples2, 0644,
+		       pac1944_op_limit_nsamples_show, pac1944_op_limit_nsamples_store, 1);
+static IIO_DEVICE_ATTR(in_ov_limit_nsamples2, 0644,
+		       pac1944_ov_limit_nsamples_show, pac1944_ov_limit_nsamples_store, 1);
+static IIO_DEVICE_ATTR(in_uv_limit_nsamples2, 0644,
+		       pac1944_uv_limit_nsamples_show, pac1944_uv_limit_nsamples_store, 1);
+
+static IIO_DEVICE_ATTR(in_shunt_resistor3, 0644,
+		       pac1944_shunt_value_show, pac1944_shunt_value_store, 2);
+static IIO_DEVICE_ATTR(in_oc_limit_nsamples3, 0644,
+		       pac1944_oc_limit_nsamples_show, pac1944_oc_limit_nsamples_store, 2);
+static IIO_DEVICE_ATTR(in_uc_limit_nsamples3, 0644,
+		       pac1944_uc_limit_nsamples_show, pac1944_uc_limit_nsamples_store, 2);
+static IIO_DEVICE_ATTR(in_op_limit_nsamples3, 0644,
+		       pac1944_op_limit_nsamples_show, pac1944_op_limit_nsamples_store, 2);
+static IIO_DEVICE_ATTR(in_ov_limit_nsamples3, 0644,
+		       pac1944_ov_limit_nsamples_show, pac1944_ov_limit_nsamples_store, 2);
+static IIO_DEVICE_ATTR(in_uv_limit_nsamples3, 0644,
+		       pac1944_uv_limit_nsamples_show, pac1944_uv_limit_nsamples_store, 2);
+
+static IIO_DEVICE_ATTR(in_shunt_resistor4, 0644,
+		       pac1944_shunt_value_show, pac1944_shunt_value_store, 3);
+static IIO_DEVICE_ATTR(in_oc_limit_nsamples4, 0644,
+		       pac1944_oc_limit_nsamples_show, pac1944_oc_limit_nsamples_store, 3);
+static IIO_DEVICE_ATTR(in_uc_limit_nsamples4, 0644,
+		       pac1944_uc_limit_nsamples_show, pac1944_uc_limit_nsamples_store, 3);
+static IIO_DEVICE_ATTR(in_op_limit_nsamples4, 0644,
+		       pac1944_op_limit_nsamples_show, pac1944_op_limit_nsamples_store, 3);
+static IIO_DEVICE_ATTR(in_ov_limit_nsamples4, 0644,
+		       pac1944_ov_limit_nsamples_show, pac1944_ov_limit_nsamples_store, 3);
+static IIO_DEVICE_ATTR(in_uv_limit_nsamples4, 0644,
+		       pac1944_uv_limit_nsamples_show, pac1944_uv_limit_nsamples_store, 3);
+
+static IIO_DEVICE_ATTR(in_acc_fullness, 0644,
+		       pac1944_acc_fullness_show, pac1944_acc_fullness_store, 0);
+
+static IIO_DEVICE_ATTR(in_alert_enable, 0644,
+		       pac1944_alert_enable_show, pac1944_alert_enable_store, 0);
+
+static IIO_DEVICE_ATTR(in_slow_alert, 0644,
+		       pac1944_slow_alert_show, pac1944_slow_alert_store, 0);
+
+static IIO_DEVICE_ATTR(in_gpio_alert, 0644,
+		       pac1944_gpio_alert_show, pac1944_gpio_alert_store, 0);
+
+static IIO_DEVICE_ATTR(out_alert_status, 0644,
+		       pac1944_alert_status_show, NULL, 0);
+
+#define PAC1944_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
+
+static struct attribute *pac1944_all_attrs[] = {
+	PAC1944_DEV_ATTR(in_shunt_resistor1),
+	PAC1944_DEV_ATTR(in_oc_limit_nsamples1),
+	PAC1944_DEV_ATTR(in_uc_limit_nsamples1),
+	PAC1944_DEV_ATTR(in_op_limit_nsamples1),
+	PAC1944_DEV_ATTR(in_ov_limit_nsamples1),
+	PAC1944_DEV_ATTR(in_uv_limit_nsamples1),
+	PAC1944_DEV_ATTR(in_shunt_resistor2),
+	PAC1944_DEV_ATTR(in_oc_limit_nsamples2),
+	PAC1944_DEV_ATTR(in_uc_limit_nsamples2),
+	PAC1944_DEV_ATTR(in_op_limit_nsamples2),
+	PAC1944_DEV_ATTR(in_ov_limit_nsamples2),
+	PAC1944_DEV_ATTR(in_uv_limit_nsamples2),
+	PAC1944_DEV_ATTR(in_shunt_resistor3),
+	PAC1944_DEV_ATTR(in_oc_limit_nsamples3),
+	PAC1944_DEV_ATTR(in_uc_limit_nsamples3),
+	PAC1944_DEV_ATTR(in_op_limit_nsamples3),
+	PAC1944_DEV_ATTR(in_ov_limit_nsamples3),
+	PAC1944_DEV_ATTR(in_uv_limit_nsamples3),
+	PAC1944_DEV_ATTR(in_shunt_resistor4),
+	PAC1944_DEV_ATTR(in_oc_limit_nsamples4),
+	PAC1944_DEV_ATTR(in_uc_limit_nsamples4),
+	PAC1944_DEV_ATTR(in_op_limit_nsamples4),
+	PAC1944_DEV_ATTR(in_ov_limit_nsamples4),
+	PAC1944_DEV_ATTR(in_uv_limit_nsamples4),
+	PAC1944_DEV_ATTR(in_acc_fullness),
+	PAC1944_DEV_ATTR(in_alert_enable),
+	PAC1944_DEV_ATTR(in_slow_alert),
+	PAC1944_DEV_ATTR(in_gpio_alert),
+	PAC1944_DEV_ATTR(out_alert_status),
+	NULL
+};
+
+static const struct iio_event_spec pac1944_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_event_spec pac1944_single_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+#define PAC1944_VBUS_CHANNEL(_index, _si, _address, _ev_spec, _num_ev_spec) { \
+	.type = IIO_VOLTAGE,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index) + 1,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+	.event_spec = (_ev_spec),				\
+	.num_event_specs = (_num_ev_spec),			\
+	.ext_info =  pac1944_ext_info				\
+}
+
+#define PAC1944_VBUS_AVG_CHANNEL(_index, _si, _address) {	\
+	.type = IIO_VOLTAGE,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index) + 1,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_AVERAGE_RAW) |	\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+	.ext_info =  pac1944_ext_info				\
+}
+
+#define PAC1944_VSENSE_CHANNEL(_index, _si, _address, _ev_spec, _num_ev_spec) {\
+	.type = IIO_CURRENT,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index) + 1,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+	.event_spec = (_ev_spec),				\
+	.num_event_specs = (_num_ev_spec),			\
+	.ext_info =  pac1944_ext_info				\
+}
+
+#define PAC1944_VSENSE_AVG_CHANNEL(_index, _si, _address) {	\
+	.type = IIO_CURRENT,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index) + 1,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_AVERAGE_RAW) |	\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+	.ext_info =  pac1944_ext_info				\
+}
+
+#define PAC1944_VPOWER_CHANNEL(_index, _si, _address, _ev_spec, _num_ev_spec) {\
+	.type = IIO_POWER,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index) + 1,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 30,					\
+		.storagebits = 32,				\
+		.shift = 2,					\
+		.endianness = IIO_CPU,				\
+	},							\
+	.event_spec = (_ev_spec),				\
+	.num_event_specs = (_num_ev_spec),			\
+	.ext_info =  pac1944_ext_info				\
+}
+
+static int pac1944_send_refresh(struct pac1944_chip_info *info,
+				u8 refresh_cmd, u32 wait_time)
+{
+	struct i2c_client *client = info->client;
+	int ret;
+
+	/* Writing a REFRESH or a REFRESH_V command */
+	ret = i2c_smbus_write_byte(client, refresh_cmd);
+	if (ret) {
+		dev_err(&client->dev, "%s - cannot send Refresh cmd (0x%02X) to PAC1944\n",
+			__func__, refresh_cmd);
+		return ret;
+	}
+
+	/* Register data retrieval timestamp */
+	info->chip_reg_data.jiffies_tstamp = jiffies;
+	/* Wait till the data is available */
+	usleep_range(wait_time, wait_time + 100);
+
+	return ret;
+}
+
+static int pac1944_reg_snapshot(struct pac1944_chip_info *info,
+				bool do_refresh, u8 refresh_cmd, u32 wait_time)
+{
+	int ret;
+	struct i2c_client *client = info->client;
+	u8 shift, idx;
+	u8 *offset_reg_data_p;
+	int cnt;
+	u32 count, inc_count;
+	u32 fs = 0;
+	s64 stored_value, tmp_s64;
+	s64 inc = 0;
+	u16 tmp_u16;
+	bool is_unipolar;
+
+	guard(mutex)(&info->lock);
+
+	if (do_refresh) {
+		ret = pac1944_send_refresh(info, refresh_cmd, wait_time);
+		if (ret < 0) {
+			dev_err(&client->dev, "%s - cannot send refresh towards PAC1944\n",
+				__func__);
+			return ret;
+		}
+	}
+
+	/* Read the ctrl/status registers for this snapshot */
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_ACT_REG_ADDR,
+					    sizeof(tmp_u16), (u8 *)&tmp_u16);
+	if (ret < 0) {
+		dev_err(&client->dev, "%s - cannot read PAC1944 regs from 0x%02X\n",
+			__func__, PAC1944_CTRL_ACT_REG_ADDR);
+		return ret;
+	}
+
+	be16_to_cpus(&tmp_u16);
+	info->chip_reg_data.ctrl_act_reg = tmp_u16;
+
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_LAT_REG_ADDR,
+					    sizeof(tmp_u16), (u8 *)&tmp_u16);
+	if (ret < 0) {
+		dev_err(&client->dev, "%s - cannot read PAC1944 regs from 0x%02X\n",
+			__func__, PAC1944_CTRL_LAT_REG_ADDR);
+		return ret;
+	}
+
+	be16_to_cpus(&tmp_u16);
+	info->chip_reg_data.ctrl_lat_reg = tmp_u16;
+
+	/* Read the data registers */
+	ret = pac1944_i2c_read(client, PAC1944_ACC_COUNT_REG_ADDR,
+			       (u8 *)info->chip_reg_data.meas_regs,
+			       PAC1944_MEAS_REG_SNAPSHOT_LEN);
+	if (ret < 0) {
+		dev_err(&client->dev, "%s - cannot read PAC1944 regs from 0x%02X\n",
+			__func__, PAC1944_ACC_COUNT_REG_ADDR);
+		return ret;
+	}
+
+	offset_reg_data_p = &info->chip_reg_data.meas_regs[0];
+
+	info->chip_reg_data.acc_count = get_unaligned_be32(offset_reg_data_p);
+
+	offset_reg_data_p += PAC1944_ACC_REG_LEN;
+
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		/*
+		 * Check if the channel is active(within the data read from
+		 * the chip), skip all fields if disabled
+		 */
+		if ((info->chip_reg_data.ctrl_act_reg << cnt) & 0x80)
+			continue;
+
+		/* skip if the energy accumulation is disabled */
+		if (!info->enable_acc[cnt])
+			continue;
+
+		stored_value = info->chip_reg_data.acc_val[cnt];
+
+		info->chip_reg_data.vacc[cnt] =
+		pac1944_get_unaligned_be56(offset_reg_data_p);
+		is_unipolar = true;
+
+		switch (info->chip_reg_data.accumulation_mode[cnt]) {
+		case PAC1944_ACCMODE_VPOWER:
+			if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG ||
+			    info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
+				is_unipolar = FALSE;
+			break;
+		case PAC1944_ACCMODE_VBUS:
+			if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
+				is_unipolar = FALSE;
+			break;
+		case PAC1944_ACCMODE_VSENSE:
+			if (info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
+				is_unipolar = FALSE;
+			break;
+		}
+
+		if (!is_unipolar)
+			info->chip_reg_data.vacc[cnt] =
+			sign_extend64(info->chip_reg_data.vacc[cnt], 55);
+
+		if (info->chip_reg_data.accumulation_mode[cnt] != PAC1944_ACCMODE_VBUS) {
+			/*
+			 * Integrate the accumulated power or current over
+			 * the elapsed interval.
+			 */
+			tmp_u16 = info->chip_reg_data.ctrl_lat_reg >> 12;
+
+			tmp_s64 = info->chip_reg_data.vacc[cnt];
+			if (tmp_u16 < PAC1944_SAMP_FAST_MODE) {
+				/*
+				 * Find how much shift is required by the sample rate
+				 * The chip's sampling rate is 2^shift samples/sec
+				 */
+				shift = shift_map_tbl[tmp_u16];
+				inc = tmp_s64 >> shift;
+			} else if (tmp_u16 <= PAC1944_SAMP_BURST_MODE) {
+				idx = info->num_enabled_channels - 1;
+
+				if (tmp_u16 == PAC1944_SAMP_FAST_MODE)
+					fs = samp_rate_fast_mode_tbl[idx];
+				else
+					/* tmp_u16 == PAC1944_SAMP_BURST_MODE) */
+					fs = samp_rate_burst_mode_tbl[idx];
+
+				inc = div_u64(abs(tmp_s64), fs);
+				if (tmp_s64 < 0)
+					inc = -inc;
+			} else {
+				dev_err(&client->dev, "Invalid sample rate index: %d!\n",
+					tmp_u16);
+			}
+		} else {
+			count = info->chip_reg_data.total_samples_nr[cnt];
+			inc_count = info->chip_reg_data.acc_count;
+
+			/* Check if total number of samples will overflow */
+			if (unlikely(check_add_overflow(count, inc_count, &count))) {
+				dev_err(&client->dev,
+					"Number of samples on channel [%d] overflow!\n",
+					cnt + 1);
+				info->chip_reg_data.total_samples_nr[cnt] = 0;
+				info->chip_reg_data.acc_val[cnt] = 0;
+			}
+
+			info->chip_reg_data.total_samples_nr[cnt] += inc_count;
+
+			inc = info->chip_reg_data.vacc[cnt];
+		}
+
+		if (unlikely(check_add_overflow(stored_value, inc, &stored_value))) {
+			if (is_negative(stored_value))
+				info->chip_reg_data.acc_val[cnt] = S64_MIN;
+			else
+				info->chip_reg_data.acc_val[cnt] = S64_MAX;
+
+			dev_err(&client->dev, "Overflow detected on channel [%d]!\n",
+				cnt + 1);
+		} else {
+			info->chip_reg_data.acc_val[cnt] += inc;
+		}
+
+		offset_reg_data_p += PAC1944_VACC_REG_LEN;
+	}
+
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if ((info->chip_reg_data.ctrl_act_reg << cnt) & 0x80)
+			continue;
+
+		info->chip_reg_data.vbus[cnt] = get_unaligned_be16(offset_reg_data_p);
+
+		if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
+			info->chip_reg_data.vbus[cnt] =
+			sign_extend32(info->chip_reg_data.vbus[cnt], 15);
+
+		offset_reg_data_p += PAC1944_VBUS_SENSE_REG_LEN;
+	}
+
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if ((info->chip_reg_data.ctrl_act_reg << cnt) & 0x80)
+			continue;
+
+		info->chip_reg_data.vsense[cnt] = get_unaligned_be16(offset_reg_data_p);
+
+		if (info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
+			info->chip_reg_data.vsense[cnt] =
+			sign_extend32(info->chip_reg_data.vsense[cnt], 15);
+
+		offset_reg_data_p += PAC1944_VBUS_SENSE_REG_LEN;
+	}
+
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if ((info->chip_reg_data.ctrl_act_reg << cnt) & 0x80)
+			continue;
+
+		info->chip_reg_data.vbus_avg[cnt] = get_unaligned_be16(offset_reg_data_p);
+
+		if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
+			info->chip_reg_data.vbus_avg[cnt] =
+			sign_extend32(info->chip_reg_data.vbus_avg[cnt], 15);
+
+		offset_reg_data_p += PAC1944_VBUS_SENSE_REG_LEN;
+	}
+
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if ((info->chip_reg_data.ctrl_act_reg << cnt) & 0x80)
+			continue;
+
+		info->chip_reg_data.vsense_avg[cnt] = get_unaligned_be16(offset_reg_data_p);
+
+		if (info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
+			info->chip_reg_data.vsense_avg[cnt] =
+			sign_extend32(info->chip_reg_data.vsense_avg[cnt], 15);
+
+		offset_reg_data_p += PAC1944_VBUS_SENSE_REG_LEN;
+	}
+
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if ((info->chip_reg_data.ctrl_act_reg << cnt) & 0x80)
+			continue;
+
+		info->chip_reg_data.vpower[cnt] = get_unaligned_be32(offset_reg_data_p) >> 2;
+
+		if (info->chip_reg_data.vbus_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG ||
+		    info->chip_reg_data.vsense_mode[cnt] != PAC1944_UNIPOLAR_FSR_CFG)
+			info->chip_reg_data.vpower[cnt] =
+			sign_extend32(info->chip_reg_data.vpower[cnt], 29);
+
+		offset_reg_data_p += PAC1944_VPOWER_REG_LEN;
+	}
+
+	return 0;
+}
+
+static int pac1944_retrieve_data(struct pac1944_chip_info *info, u32 wait_time)
+{
+	int ret;
+	/*
+	 * Check if the minimal elapsed time has passed and if so,
+	 * re-read the chip, otherwise the cached info is just fine
+	 */
+	if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
+		       msecs_to_jiffies(PAC1944_MIN_POLLING_TIME_MS))) {
+		/*
+		 * We need to re-read the chip values
+		 * call the pac1944_reg_snapshot
+		 */
+		ret = pac1944_reg_snapshot(info, true,
+					   PAC1944_REFRESH_REG_ADDR,
+					   wait_time);
+		/*
+		 * Re-schedule the work for the read registers timeout
+		 * (to prevent chip regs saturation)
+		 */
+		cancel_delayed_work_sync(&info->work_chip_rfsh);
+		schedule_delayed_work(&info->work_chip_rfsh,
+				      msecs_to_jiffies(PAC1944_MAX_RFSH_LIMIT_MS));
+	}
+
+	return ret;
+}
+
+static ssize_t pac1944_in_power_acc_raw_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret;
+	s64 curr_energy, int_part;
+	int rem;
+
+	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return 0;
+
+	/*
+	 * Expresses the 64 bit energy value as a
+	 * 64 bit integer and a 32 bit nano value
+	 */
+	curr_energy = info->chip_reg_data.acc_val[this_attr->address];
+	int_part = div_s64_rem(curr_energy, 1000000000, &rem);
+
+	if (rem < 0)
+		return sysfs_emit(buf, "-%lld.%09u\n", abs(int_part),
+				  -rem);
+	else
+		return sysfs_emit(buf, "%lld.%09u\n", int_part, abs(rem));
+}
+
+static ssize_t pac1944_in_power_acc_scale_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned int shunt, rem;
+	u64 tmp, ref;
+
+	if (info->is_pac195x_family)
+		ref = (u64)PAC195X_MAX_VPOWER_RSHIFTED_BY_29B;
+	else
+		ref = (u64)PAC194X_MAX_VPOWER_RSHIFTED_BY_29B;
+
+	if ((info->chip_reg_data.vbus_mode[this_attr->address] == PAC1944_UNIPOLAR_FSR_CFG &&
+	     info->chip_reg_data.vsense_mode[this_attr->address] == PAC1944_UNIPOLAR_FSR_CFG) ||
+	    info->chip_reg_data.vbus_mode[this_attr->address] == PAC1944_BIPOLAR_HALF_FSR_CFG ||
+	    info->chip_reg_data.vsense_mode[this_attr->address] == PAC1944_BIPOLAR_HALF_FSR_CFG)
+		ref = ref >> 1;
+
+	shunt = info->shunts[this_attr->address];
+
+	tmp = div_u64(ref * 1000000000LL, shunt);
+	rem = do_div(tmp, 1000000000LL);
+
+	return sysfs_emit(buf, "%lld.%09u\n", tmp, rem);
+}
+
+static ssize_t pac1944_in_enable_acc_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	return sysfs_emit(buf, "%d\n", info->enable_acc[this_attr->address]);
+}
+
+static ssize_t pac1944_in_enable_acc_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int val;
+
+	if (kstrtouint(buf, 10, &val)) {
+		dev_err(dev, "Value is not valid\n");
+		return -EINVAL;
+	}
+
+	scoped_guard(mutex, &info->lock) {
+		info->enable_acc[this_attr->address] = val ? true : false;
+		if (!val) {
+			info->chip_reg_data.acc_val[this_attr->address] = 0;
+			info->chip_reg_data.total_samples_nr[this_attr->address] = 0;
+		}
+	}
+
+	return count;
+}
+
+static ssize_t pac1944_in_current_acc_raw_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret;
+
+	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return 0;
+
+	return sysfs_emit(buf, "%lld\n", info->chip_reg_data.acc_val[this_attr->address]);
+}
+
+static ssize_t pac1944_in_current_acc_scale_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int shunt, rem;
+	u64 tmp_u64, ref;
+
+	/*
+	 * Currents - scale for mA - depends on the channel's shunt value
+	 * (100mV * 1000000) / (2^16 * shunt(uOhm))
+	 */
+	ref = (u64)PAC1944_MAX_VSENSE_NANO;
+
+	switch (info->chip_reg_data.vsense_mode[this_attr->address]) {
+	case PAC1944_UNIPOLAR_FSR_CFG:
+	case PAC1944_BIPOLAR_HALF_FSR_CFG:
+		shunt = info->shunts[this_attr->address];
+		break;
+	case PAC1944_BIPOLAR_FSR_CFG:
+		ref = ref << 1;
+		shunt = info->shunts[this_attr->address];
+		break;
+	default:
+		return 0;
+	}
+
+	/*
+	 * Increasing precision
+	 * (100mV * 1000000 * 1000000000) / 2^16 )
+	 */
+	tmp_u64 = div_u64(ref, shunt);
+	rem = do_div(tmp_u64, 1000000000LL);
+
+	return sysfs_emit(buf, "%lld.%09u\n", tmp_u64, rem);
+}
+
+static ssize_t pac1944_in_voltage_acc_raw_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret;
+	s64 acc_voltage;
+	u32 samples_count;
+	u64 tmp_u64;
+
+	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return 0;
+
+	acc_voltage = info->chip_reg_data.acc_val[this_attr->address];
+	samples_count = info->chip_reg_data.total_samples_nr[this_attr->address];
+
+	tmp_u64 = div_u64(abs(acc_voltage), samples_count);
+
+	if (unlikely(is_negative(acc_voltage)))
+		return sysfs_emit(buf, "-%lld\n", tmp_u64);
+	else
+		return sysfs_emit(buf, "%lld\n", tmp_u64);
+}
+
+static ssize_t pac1944_in_voltage_acc_scale_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int vals[2];
+	unsigned long long tmp;
+
+	if (info->is_pac195x_family)
+		vals[0] = PAC195X_VOLTAGE_MILLIVOLTS_MAX;
+	else
+		vals[0] = PAC194X_VOLTAGE_MILLIVOLTS_MAX;
+
+	if (info->chip_reg_data.vbus_mode[this_attr->address] != PAC1944_BIPOLAR_FSR_CFG)
+		/* PAC1944_UNIPOLAR_FSR_CFG or PAC1944_BIPOLAR_HALF_FSR_CFG */
+		vals[1] = PAC1944_VOLTAGE_16B_RES;
+	else
+		vals[1] = PAC1944_VOLTAGE_15B_RES;
+
+	tmp = (s64)vals[0] * 1000000000LL >> vals[1];
+	vals[1] = do_div(tmp, 1000000000LL);
+	vals[0] = tmp;
+
+	return sysfs_emit(buf, "%d.%09u\n", vals[0], vals[1]);
+}
+
+static IIO_DEVICE_ATTR(in_energy1_raw, 0444,
+		       pac1944_in_power_acc_raw_show, NULL, 0);
+static IIO_DEVICE_ATTR(in_energy2_raw, 0444,
+		       pac1944_in_power_acc_raw_show, NULL, 1);
+static IIO_DEVICE_ATTR(in_energy3_raw, 0444,
+		       pac1944_in_power_acc_raw_show, NULL, 2);
+static IIO_DEVICE_ATTR(in_energy4_raw, 0444,
+		       pac1944_in_power_acc_raw_show, NULL, 3);
+
+static IIO_DEVICE_ATTR(in_energy1_scale, 0444,
+		       pac1944_in_power_acc_scale_show, NULL, 0);
+static IIO_DEVICE_ATTR(in_energy2_scale, 0444,
+		       pac1944_in_power_acc_scale_show, NULL, 1);
+static IIO_DEVICE_ATTR(in_energy3_scale, 0444,
+		       pac1944_in_power_acc_scale_show, NULL, 2);
+static IIO_DEVICE_ATTR(in_energy4_scale, 0444,
+		       pac1944_in_power_acc_scale_show, NULL, 3);
+
+static IIO_DEVICE_ATTR(in_energy1_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 0);
+static IIO_DEVICE_ATTR(in_energy2_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 1);
+static IIO_DEVICE_ATTR(in_energy3_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 2);
+static IIO_DEVICE_ATTR(in_energy4_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 3);
+
+static IIO_DEVICE_ATTR(in_current_acc1_raw, 0444,
+		       pac1944_in_current_acc_raw_show, NULL, 0);
+static IIO_DEVICE_ATTR(in_current_acc2_raw, 0444,
+		       pac1944_in_current_acc_raw_show, NULL, 1);
+static IIO_DEVICE_ATTR(in_current_acc3_raw, 0444,
+		       pac1944_in_current_acc_raw_show, NULL, 2);
+static IIO_DEVICE_ATTR(in_current_acc4_raw, 0444,
+		       pac1944_in_current_acc_raw_show, NULL, 3);
+
+static IIO_DEVICE_ATTR(in_current_acc1_scale, 0444,
+		       pac1944_in_current_acc_scale_show, NULL, 0);
+static IIO_DEVICE_ATTR(in_current_acc2_scale, 0444,
+		       pac1944_in_current_acc_scale_show, NULL, 1);
+static IIO_DEVICE_ATTR(in_current_acc3_scale, 0444,
+		       pac1944_in_current_acc_scale_show, NULL, 2);
+static IIO_DEVICE_ATTR(in_current_acc4_scale, 0444,
+		       pac1944_in_current_acc_scale_show, NULL, 3);
+
+static IIO_DEVICE_ATTR(in_current_acc1_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 0);
+static IIO_DEVICE_ATTR(in_current_acc2_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 1);
+static IIO_DEVICE_ATTR(in_current_acc3_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 2);
+static IIO_DEVICE_ATTR(in_current_acc4_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 3);
+
+static IIO_DEVICE_ATTR(in_voltage_acc1_raw, 0444,
+		       pac1944_in_voltage_acc_raw_show, NULL, 0);
+static IIO_DEVICE_ATTR(in_voltage_acc2_raw, 0444,
+		      pac1944_in_voltage_acc_raw_show, NULL, 1);
+static IIO_DEVICE_ATTR(in_voltage_acc3_raw, 0444,
+		      pac1944_in_voltage_acc_raw_show, NULL, 2);
+static IIO_DEVICE_ATTR(in_voltage_acc4_raw, 0444,
+		      pac1944_in_voltage_acc_raw_show, NULL, 3);
+
+static IIO_DEVICE_ATTR(in_voltage_acc1_scale, 0444,
+		      pac1944_in_voltage_acc_scale_show, NULL, 0);
+static IIO_DEVICE_ATTR(in_voltage_acc2_scale, 0444,
+		      pac1944_in_voltage_acc_scale_show, NULL, 1);
+static IIO_DEVICE_ATTR(in_voltage_acc3_scale, 0444,
+		      pac1944_in_voltage_acc_scale_show, NULL, 2);
+static IIO_DEVICE_ATTR(in_voltage_acc4_scale, 0444,
+		      pac1944_in_voltage_acc_scale_show, NULL, 3);
+
+static IIO_DEVICE_ATTR(in_voltage_acc1_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 0);
+static IIO_DEVICE_ATTR(in_voltage_acc2_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 1);
+static IIO_DEVICE_ATTR(in_voltage_acc3_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 2);
+static IIO_DEVICE_ATTR(in_voltage_acc4_en, 0644,
+		       pac1944_in_enable_acc_show, pac1944_in_enable_acc_store, 3);
+
+static struct attribute *pac1944_power_acc_attr[] = {
+	PAC1944_DEV_ATTR(in_energy1_raw),
+	PAC1944_DEV_ATTR(in_energy2_raw),
+	PAC1944_DEV_ATTR(in_energy3_raw),
+	PAC1944_DEV_ATTR(in_energy4_raw),
+	PAC1944_DEV_ATTR(in_energy1_scale),
+	PAC1944_DEV_ATTR(in_energy2_scale),
+	PAC1944_DEV_ATTR(in_energy3_scale),
+	PAC1944_DEV_ATTR(in_energy4_scale),
+	PAC1944_DEV_ATTR(in_energy1_en),
+	PAC1944_DEV_ATTR(in_energy2_en),
+	PAC1944_DEV_ATTR(in_energy3_en),
+	PAC1944_DEV_ATTR(in_energy4_en),
+	NULL
+};
+
+static struct attribute *pac1944_current_acc_attr[] = {
+	PAC1944_DEV_ATTR(in_current_acc1_raw),
+	PAC1944_DEV_ATTR(in_current_acc2_raw),
+	PAC1944_DEV_ATTR(in_current_acc3_raw),
+	PAC1944_DEV_ATTR(in_current_acc4_raw),
+	PAC1944_DEV_ATTR(in_current_acc1_scale),
+	PAC1944_DEV_ATTR(in_current_acc2_scale),
+	PAC1944_DEV_ATTR(in_current_acc3_scale),
+	PAC1944_DEV_ATTR(in_current_acc4_scale),
+	PAC1944_DEV_ATTR(in_current_acc1_en),
+	PAC1944_DEV_ATTR(in_current_acc2_en),
+	PAC1944_DEV_ATTR(in_current_acc3_en),
+	PAC1944_DEV_ATTR(in_current_acc4_en),
+	NULL
+};
+
+static struct attribute *pac1944_voltage_acc_attr[] = {
+	PAC1944_DEV_ATTR(in_voltage_acc1_raw),
+	PAC1944_DEV_ATTR(in_voltage_acc2_raw),
+	PAC1944_DEV_ATTR(in_voltage_acc3_raw),
+	PAC1944_DEV_ATTR(in_voltage_acc4_raw),
+	PAC1944_DEV_ATTR(in_voltage_acc1_scale),
+	PAC1944_DEV_ATTR(in_voltage_acc2_scale),
+	PAC1944_DEV_ATTR(in_voltage_acc3_scale),
+	PAC1944_DEV_ATTR(in_voltage_acc4_scale),
+	PAC1944_DEV_ATTR(in_voltage_acc1_en),
+	PAC1944_DEV_ATTR(in_voltage_acc2_en),
+	PAC1944_DEV_ATTR(in_voltage_acc3_en),
+	PAC1944_DEV_ATTR(in_voltage_acc4_en),
+	NULL
+};
+
+static int pac1944_prep_custom_attributes(struct pac1944_chip_info *info,
+					  struct iio_dev *indio_dev)
+{
+	int ch, i, j, idx;
+	int active_channels_count = 0;
+	struct attribute **pac1944_custom_attrs, **tmp_attr;
+	struct attribute_group *pac1944_group;
+	int custom_attr_cnt;
+	struct i2c_client *client = info->client;
+
+	for (i = 0 ; i < info->phys_channels; i++)
+		if (info->active_channels[i])
+			active_channels_count++;
+
+	pac1944_group = devm_kzalloc(&client->dev, sizeof(*pac1944_group), GFP_KERNEL);
+	if (!pac1944_group)
+		return -ENOMEM;
+
+	/*
+	 * Attributes for channel X:
+	 *	- in_shunt_value_X
+	 *	- in_oc_limit_nsamples
+	 *	- in_uc_limit_nsamples
+	 *	- in_op_limit_nsamples
+	 *	- in_ov_limit_nsamples
+	 *	- in_uv_limit_nsamples
+	 *	- one of pair attributes:
+	 *		- in_power_accX_raw and in_power_accX_scale
+	 *		- in_current_accX_raw and in_current_accX_scale
+	 *		- in_voltage_accX_raw and in_voltage_accX_scale
+	 * Shared attributes:
+	 *	- in_acc_fullness
+	 *	- in_alert_enable
+	 *	- in_slow_alert1
+	 *	- gpio_alert2
+	 *	- out_alert_status
+	 * NULL
+	 */
+	custom_attr_cnt = PAC1944_COMMON_DEVATTR * active_channels_count;
+	custom_attr_cnt += PAC1944_ACC_DEVATTR * active_channels_count;
+	custom_attr_cnt += PAC1944_SHARED_DEVATTRS_COUNT;
+
+	pac1944_custom_attrs = devm_kzalloc(&client->dev, custom_attr_cnt *
+					    sizeof(*pac1944_group) + 1, GFP_KERNEL);
+	if (!pac1944_custom_attrs)
+		return -ENOMEM;
+
+	j = 0;
+	for (ch = 0 ; ch < info->phys_channels; ch++) {
+		if (!info->active_channels[ch])
+			continue;
+
+		for (i = 0; i < PAC1944_COMMON_DEVATTR; i++)
+			pac1944_custom_attrs[j++] =
+				pac1944_all_attrs[PAC1944_COMMON_DEVATTR * ch + i];
+
+		idx = ch;
+		switch (info->chip_reg_data.accumulation_mode[ch]) {
+		case PAC1944_ACCMODE_VPOWER:
+			tmp_attr = pac1944_power_acc_attr;
+			break;
+		case PAC1944_ACCMODE_VSENSE:
+			tmp_attr = pac1944_current_acc_attr;
+			break;
+		case PAC1944_ACCMODE_VBUS:
+			tmp_attr = pac1944_voltage_acc_attr;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		pac1944_custom_attrs[j++] = tmp_attr[ch];
+		pac1944_custom_attrs[j++] = pac1944_power_acc_attr[PAC1944_MAX_CH + ch];
+		pac1944_custom_attrs[j++] = pac1944_power_acc_attr[2 * PAC1944_MAX_CH + ch];
+	}
+
+	for (i = 0; i < PAC1944_SHARED_DEVATTRS_COUNT; i++)
+		pac1944_custom_attrs[j++] =
+			pac1944_all_attrs[PAC1944_COMMON_DEVATTR * PAC1944_MAX_CH + i];
+
+	pac1944_group->attrs = pac1944_custom_attrs;
+	info->iio_info.attrs = pac1944_group;
+
+	return 0;
+}
+
+static int pac1944_frequency_set(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 unsigned int mode)
+{
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret;
+	u16 tmp_be16, tmp_u16;
+
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_ACT_REG_ADDR,
+					    sizeof(tmp_u16), (u8 *)&tmp_u16);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "%s - cannot read PAC1944 regs from 0x%02X\n",
+			__func__, PAC1944_CTRL_ACT_REG_ADDR);
+		return ret;
+	}
+
+	be16_to_cpus(&tmp_u16);
+	tmp_u16 &= (u16)0x00ff;
+	tmp_u16 |= (u16)(mode << 12);
+	tmp_be16 = tmp_u16;
+	cpu_to_be16s(&tmp_be16);
+
+	scoped_guard(mutex, &info->lock) {
+		ret = i2c_smbus_write_word_data(client, PAC1944_CTRL_REG_ADDR, tmp_be16);
+		if (ret < 0) {
+			dev_err(&indio_dev->dev, "Failed to configure sampling mode\n");
+			return ret;
+		}
+
+		info->sampling_mode = mode;
+		info->chip_reg_data.ctrl_act_reg = tmp_u16;
+	}
+
+	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int pac1944_frequency_get(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan)
+{
+	struct pac1944_chip_info *info;
+
+	info = iio_priv(indio_dev);
+
+	return info->sampling_mode;
+}
+
+static const struct iio_enum sampling_mode_enum = {
+	.items = pac1944_frequency_avail,
+	.num_items = ARRAY_SIZE(pac1944_frequency_avail),
+	.set = pac1944_frequency_set,
+	.get = pac1944_frequency_get,
+};
+
+static const struct iio_chan_spec_ext_info pac1944_ext_info[] = {
+	IIO_ENUM("sampling_frequency", IIO_SHARED_BY_ALL, &sampling_mode_enum),
+	{
+		.name = "sampling_frequency_available",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = iio_enum_available_read,
+		.private = (uintptr_t)&sampling_mode_enum,
+	},
+	{}
+};
+
+static int pac1944_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	int ret, idx;
+	u64 tmp;
+
+	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return ret;
+
+	/* into the datasheet channels are noted from 1 to 4 */
+	idx = chan->channel - 1;
+
+	/*
+	 * For AVG the index should be between 5 to 8.
+	 * To calculate PAC1944_CH_VOLTAGE_AVERAGE and
+	 * PAC1944_CH_CURRENT_AVERAGE real index, we need
+	 * to remove the added offset (PAC1944_MAX_CH).
+	 */
+	if (idx >= PAC1944_MAX_CH)
+		idx = idx - PAC1944_MAX_CH;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = info->chip_reg_data.vbus[idx];
+			return IIO_VAL_INT;
+		case IIO_CURRENT:
+			*val = info->chip_reg_data.vsense[idx];
+			return IIO_VAL_INT;
+		case IIO_POWER:
+			*val = info->chip_reg_data.vpower[idx];
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = info->chip_reg_data.vbus_avg[idx];
+			return IIO_VAL_INT;
+		case IIO_CURRENT:
+			*val = info->chip_reg_data.vsense_avg[idx];
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->address) {
+		case PAC1944_VBUS_1_ADDR:
+		case PAC1944_VBUS_2_ADDR:
+		case PAC1944_VBUS_3_ADDR:
+		case PAC1944_VBUS_4_ADDR:
+		case PAC1944_VBUS_AVG_1_ADDR:
+		case PAC1944_VBUS_AVG_2_ADDR:
+		case PAC1944_VBUS_AVG_3_ADDR:
+		case PAC1944_VBUS_AVG_4_ADDR:
+			if (info->is_pac195x_family)
+				*val = PAC195X_VOLTAGE_MILLIVOLTS_MAX;
+			else
+				*val = PAC194X_VOLTAGE_MILLIVOLTS_MAX;
+
+			switch (info->chip_reg_data.vbus_mode[idx]) {
+			case PAC1944_UNIPOLAR_FSR_CFG:
+			case PAC1944_BIPOLAR_HALF_FSR_CFG:
+				*val2 = PAC1944_VOLTAGE_16B_RES;
+				break;
+			case PAC1944_BIPOLAR_FSR_CFG:
+				*val2 = PAC1944_VOLTAGE_15B_RES;
+				break;
+			default:
+				return -EINVAL;
+			}
+			return IIO_VAL_FRACTIONAL_LOG2;
+		/*
+		 * Currents - scale for mA - depends on the
+		 * channel's shunt value
+		 * (100mV * 1000000) / (2^16 * shunt(microOhm))
+		 */
+		case PAC1944_VSENSE_1_ADDR:
+		case PAC1944_VSENSE_2_ADDR:
+		case PAC1944_VSENSE_3_ADDR:
+		case PAC1944_VSENSE_4_ADDR:
+		case PAC1944_VSENSE_AVG_1_ADDR:
+		case PAC1944_VSENSE_AVG_2_ADDR:
+		case PAC1944_VSENSE_AVG_3_ADDR:
+		case PAC1944_VSENSE_AVG_4_ADDR:
+			*val = PAC1944_MAX_VSENSE_RSHIFTED_BY_15B;
+			switch (info->chip_reg_data.vsense_mode[idx]) {
+			case PAC1944_UNIPOLAR_FSR_CFG:
+			case PAC1944_BIPOLAR_HALF_FSR_CFG:
+				*val = *val >> 1;
+				*val2 = info->shunts[idx];
+				break;
+			case PAC1944_BIPOLAR_FSR_CFG:
+				*val2 = info->shunts[idx];
+				break;
+			default:
+				return -EINVAL;
+			}
+			return IIO_VAL_FRACTIONAL;
+		/*
+		 * Power - mW - it will use the combined scale
+		 * for current and voltage
+		 * current(mA) * voltage(mV) = power (uW)
+		 */
+		case PAC1944_VPOWER_1_ADDR:
+		case PAC1944_VPOWER_2_ADDR:
+		case PAC1944_VPOWER_3_ADDR:
+		case PAC1944_VPOWER_4_ADDR:
+			if (info->is_pac195x_family)
+				tmp = PAC195X_PRODUCT_VOLTAGE_PV_FSR;
+			else
+				tmp = PAC194X_PRODUCT_VOLTAGE_PV_FSR;
+
+			do_div(tmp, info->shunts[idx]);
+			*val = (int)tmp;
+			if ((info->chip_reg_data.vbus_mode[idx] == PAC1944_UNIPOLAR_FSR_CFG &&
+			     info->chip_reg_data.vsense_mode[idx] == PAC1944_UNIPOLAR_FSR_CFG) ||
+			    info->chip_reg_data.vbus_mode[idx] == PAC1944_BIPOLAR_HALF_FSR_CFG ||
+			    info->chip_reg_data.vsense_mode[idx] == PAC1944_BIPOLAR_HALF_FSR_CFG)
+				*val2 = PAC1944_POWER_30B_RES;
+			else
+				*val2 = PAC1944_POWER_29B_RES;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int pac1944_read_label(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, char *label)
+{
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	int idx;
+
+	/* into the datasheet channels are noted from 1 to 4 */
+	idx = chan->channel - 1;
+
+	/*
+	 * For AVG the index should be between 5 to 8.
+	 * To calculate PAC1944_CH_VOLTAGE_AVERAGE and
+	 * PAC1944_CH_CURRENT_AVERAGE real index, we need
+	 * to remove the added offset (PAC1944_MAX_CH).
+	 */
+	if (idx >= PAC1944_MAX_CH)
+		idx = idx - PAC1944_MAX_CH;
+
+	switch (chan->address) {
+	case PAC1944_VBUS_1_ADDR:
+	case PAC1944_VBUS_2_ADDR:
+	case PAC1944_VBUS_3_ADDR:
+	case PAC1944_VBUS_4_ADDR:
+		if (info->labels[idx])
+			return sysfs_emit(label, "%s_VBUS_%d\n", info->labels[idx], idx + 1);
+		else
+			return sysfs_emit(label, "VBUS_%d\n", idx + 1);
+	case PAC1944_VBUS_AVG_1_ADDR:
+	case PAC1944_VBUS_AVG_2_ADDR:
+	case PAC1944_VBUS_AVG_3_ADDR:
+	case PAC1944_VBUS_AVG_4_ADDR:
+		if (info->labels[idx])
+			return sysfs_emit(label, "%s_VBUS_AVG_%d\n", info->labels[idx], idx + 1);
+		else
+			return sysfs_emit(label, "VBUS_AVG_%d\n", idx + 1);
+	case PAC1944_VSENSE_1_ADDR:
+	case PAC1944_VSENSE_2_ADDR:
+	case PAC1944_VSENSE_3_ADDR:
+	case PAC1944_VSENSE_4_ADDR:
+		if (info->labels[idx])
+			return sysfs_emit(label, "%s_IBUS_%d\n", info->labels[idx], idx + 1);
+		else
+			return sysfs_emit(label, "IBUS_%d\n", idx + 1);
+	case PAC1944_VSENSE_AVG_1_ADDR:
+	case PAC1944_VSENSE_AVG_2_ADDR:
+	case PAC1944_VSENSE_AVG_3_ADDR:
+	case PAC1944_VSENSE_AVG_4_ADDR:
+		if (info->labels[idx])
+			return sysfs_emit(label, "%s_IBUS_AVG_%d\n", info->labels[idx], idx + 1);
+		else
+			return sysfs_emit(label, "IBUS_AVG_%d\n", idx + 1);
+	case PAC1944_VPOWER_1_ADDR:
+	case PAC1944_VPOWER_2_ADDR:
+	case PAC1944_VPOWER_3_ADDR:
+	case PAC1944_VPOWER_4_ADDR:
+		if (info->labels[idx])
+			return sysfs_emit(label, "%s_POWER_%d\n", info->labels[idx], idx + 1);
+		else
+			return sysfs_emit(label, "POWER_%d\n", idx + 1);
+	}
+
+	return 0;
+}
+
+static int pac1944_read_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan, enum iio_event_type type,
+			       enum iio_event_direction dir, enum iio_event_info info,
+			       int *val, int *val2)
+{
+	struct pac1944_chip_info *chip_info = iio_priv(indio_dev);
+	int idx;
+
+	/* into the datasheet channels are noted from 1 to 4 */
+	idx = chan->channel - 1;
+
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			*val = chip_info->overvoltage[idx];
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			*val = chip_info->undervoltage[idx];
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CURRENT:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			*val = chip_info->overcurrent[idx];
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			*val = chip_info->undercurrent[idx];
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_POWER:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			*val = chip_info->overpower[idx];
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pac1944_write_thresh(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan, enum iio_event_type type,
+				enum iio_event_direction dir, enum iio_event_info info,
+				int val, int val2)
+{
+	struct pac1944_chip_info *chip_info = iio_priv(indio_dev);
+	int idx, ret;
+
+	/* into the datasheet channels are noted from 1 to 4 */
+	idx = chan->channel - 1;
+
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			scoped_guard(mutex, &chip_info->lock) {
+				ret = pac1944_update_alert_16b(&indio_dev->dev,
+							       PAC1944_OV_LIMIT_REG_ADDR + idx,
+							       (int)(PAC1944_CH01UV_MASK >> idx),
+							       val);
+				if (!ret)
+					chip_info->overvoltage[idx] = val;
+			}
+			return ret;
+		case IIO_EV_DIR_FALLING:
+			scoped_guard(mutex, &chip_info->lock) {
+				ret = pac1944_update_alert_16b(&indio_dev->dev,
+							       PAC1944_UV_LIMIT_REG_ADDR + idx,
+							       (int)(PAC1944_CH01UV_MASK >> idx),
+							       val);
+				if (!ret)
+					chip_info->undervoltage[idx] = val;
+			}
+			return ret;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CURRENT:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			scoped_guard(mutex, &chip_info->lock) {
+				ret = pac1944_update_alert_16b(&indio_dev->dev,
+							       PAC1944_OC_LIMIT_REG_ADDR + idx,
+							       (int)(PAC1944_CH01OC_MASK >> idx),
+							       val);
+				if (!ret)
+					chip_info->overcurrent[idx] = val;
+			}
+			return ret;
+		case IIO_EV_DIR_FALLING:
+			scoped_guard(mutex, &chip_info->lock) {
+				ret = pac1944_update_alert_16b(&indio_dev->dev,
+							       PAC1944_UC_LIMIT_REG_ADDR + idx,
+							       (int)(PAC1944_CH01UC_MASK >> idx),
+							       val);
+				if (!ret)
+					chip_info->undercurrent[idx] = val;
+			}
+			return ret;
+		default:
+			return -EINVAL;
+		}
+	case IIO_POWER:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			scoped_guard(mutex, &chip_info->lock) {
+				ret = pac1944_update_alert_24b(&indio_dev->dev,
+							       PAC1944_OP_LIMIT_REG_ADDR + idx,
+							       (int)(PAC1944_CH01OP_MASK >> idx),
+							       val);
+				if (!ret)
+					chip_info->overpower[idx] = val;
+			}
+			return ret;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pac1944_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	int idx;
+
+	/* into the datasheet channels are noted from 1 to 4 */
+	idx = chan->channel - 1;
+
+	scoped_guard(mutex, &info->lock) {
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				switch (idx) {
+				case 0:
+					return FIELD_GET(PAC1944_CH01OV_MASK, info->alert_enable);
+				case 1:
+					return FIELD_GET(PAC1944_CH02OV_MASK, info->alert_enable);
+				case 2:
+					return FIELD_GET(PAC1944_CH03OV_MASK, info->alert_enable);
+				case 3:
+					return FIELD_GET(PAC1944_CH04OV_MASK, info->alert_enable);
+				default:
+					return -EINVAL;
+				}
+			case IIO_EV_DIR_FALLING:
+				switch (idx) {
+				case 0:
+					return FIELD_GET(PAC1944_CH01UV_MASK, info->alert_enable);
+				case 1:
+					return FIELD_GET(PAC1944_CH02UV_MASK, info->alert_enable);
+				case 2:
+					return FIELD_GET(PAC1944_CH03UV_MASK, info->alert_enable);
+				case 3:
+					return FIELD_GET(PAC1944_CH04UV_MASK, info->alert_enable);
+				default:
+					return -EINVAL;
+				}
+			default:
+				return -EINVAL;
+			}
+		case IIO_CURRENT:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				switch (idx) {
+				case 0:
+					return FIELD_GET(PAC1944_CH01OC_MASK, info->alert_enable);
+				case 1:
+					return FIELD_GET(PAC1944_CH02OC_MASK, info->alert_enable);
+				case 2:
+					return FIELD_GET(PAC1944_CH03OC_MASK, info->alert_enable);
+				case 3:
+					return FIELD_GET(PAC1944_CH04OC_MASK, info->alert_enable);
+				default:
+					return -EINVAL;
+				}
+			case IIO_EV_DIR_FALLING:
+				switch (idx) {
+				case 0:
+					return FIELD_GET(PAC1944_CH01UC_MASK, info->alert_enable);
+				case 1:
+					return FIELD_GET(PAC1944_CH02UC_MASK, info->alert_enable);
+				case 2:
+					return FIELD_GET(PAC1944_CH03UC_MASK, info->alert_enable);
+				case 3:
+					return FIELD_GET(PAC1944_CH04UC_MASK, info->alert_enable);
+				default:
+					return -EINVAL;
+				}
+			default:
+				return -EINVAL;
+			}
+		case IIO_POWER:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				switch (idx) {
+				case 0:
+					return FIELD_GET(PAC1944_CH01OP_MASK, info->alert_enable);
+				case 1:
+					return FIELD_GET(PAC1944_CH02OP_MASK, info->alert_enable);
+				case 2:
+					return FIELD_GET(PAC1944_CH03OP_MASK, info->alert_enable);
+				case 3:
+					return FIELD_GET(PAC1944_CH04OP_MASK, info->alert_enable);
+				default:
+					return -EINVAL;
+				}
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+	}
+
+	unreachable();
+}
+
+static int pac1944_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct pac1944_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int idx, val, mask, ret;
+	bool update = false;
+	u8 tmp[PAC1944_ALERT_ENABLE_REG_LEN];
+
+	/* into the datasheet channels are noted from 1 to 4 */
+	idx = chan->channel - 1;
+
+	guard(mutex)(&info->lock);
+
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			switch (idx) {
+			case 0:
+				mask = PAC1944_CH01OV_MASK;
+				break;
+			case 1:
+				mask = PAC1944_CH02OV_MASK;
+				break;
+			case 2:
+				mask = PAC1944_CH03OV_MASK;
+				break;
+			case 3:
+				mask = PAC1944_CH04OV_MASK;
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_EV_DIR_FALLING:
+			switch (idx) {
+			case 0:
+				mask = PAC1944_CH01UV_MASK;
+				break;
+			case 1:
+				mask = PAC1944_CH02UV_MASK;
+				break;
+			case 2:
+				mask = PAC1944_CH03UV_MASK;
+				break;
+			case 3:
+				mask = PAC1944_CH04UV_MASK;
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CURRENT:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			switch (idx) {
+			case 0:
+				mask = PAC1944_CH01OC_MASK;
+				break;
+			case 1:
+				mask = PAC1944_CH02OC_MASK;
+				break;
+			case 2:
+				mask = PAC1944_CH03OC_MASK;
+				break;
+			case 3:
+				mask = PAC1944_CH04OC_MASK;
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_EV_DIR_FALLING:
+			switch (idx) {
+			case 0:
+				mask = PAC1944_CH01UC_MASK;
+				break;
+			case 1:
+				mask = PAC1944_CH02UC_MASK;
+				break;
+			case 2:
+				mask = PAC1944_CH03UC_MASK;
+				break;
+			case 3:
+				mask = PAC1944_CH04UC_MASK;
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_POWER:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			switch (idx) {
+			case 0:
+				mask = PAC1944_CH01OP_MASK;
+				break;
+			case 1:
+				mask = PAC1944_CH02OP_MASK;
+				break;
+			case 2:
+				mask = PAC1944_CH03OP_MASK;
+				break;
+			case 3:
+				mask = PAC1944_CH04OP_MASK;
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = info->alert_enable & mask;
+	if (state && !val) {
+		/* enable the event in hardware */
+		info->alert_enable |= mask;
+		update = true;
+	} else if (!state && val) {
+		/* disable the event in hardware */
+		info->alert_enable &= ~mask;
+		update = true;
+	}
+
+	/* do not update if not needed */
+	if (update) {
+		put_unaligned_be24(info->alert_enable, &tmp[0]);
+
+		/* update the Alert enable register */
+		ret = pac1944_restore_alert_reg(indio_dev, &tmp[0]);
+		if (ret) {
+			dev_err(&client->dev, "failing to write %s\n", __func__);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void pac1944_work_periodic_rfsh(struct work_struct *work)
+{
+	struct pac1944_chip_info *info = TO_PAC1944_CHIP_INFO((struct delayed_work *)work);
+	struct i2c_client *client = info->client;
+
+	dev_dbg(&client->dev, "%s - Periodic refresh\n", __func__);
+
+	pac1944_reg_snapshot(info, true, PAC1944_REFRESH_REG_ADDR,
+			     PAC1944_MIN_UPDATE_WAIT_TIME_US);
+
+	schedule_delayed_work(&info->work_chip_rfsh,
+			      msecs_to_jiffies(PAC1944_MAX_RFSH_LIMIT_MS));
+}
+
+/*
+ * documentation related to the ACPI device definition
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/UserGuides/PAC194X_5X-UEFI-BIOS-Integration-and-Microsoft-Windows-10-and-Windows-11-Energy-Meter-Interface-Device-Driver-Users-Guide-DS50003155.pdf
+ */
+static bool pac1944_acpi_parse_channel_config(struct i2c_client *client,
+					      struct pac1944_chip_info *info)
+{
+	acpi_handle handle;
+	union acpi_object *rez;
+	struct device *dev = &client->dev;
+	unsigned short bi_dir_mask;
+	int i;
+	guid_t guid;
+	const struct acpi_device_id *id;
+
+	handle = ACPI_HANDLE(dev);
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!id)
+		return false;
+
+	guid_parse(PAC1944_DSM_UUID, &guid);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1944_ACPI_GET_NAMES, NULL);
+	if (!rez)
+		return false;
+
+	for (i = 0; i < rez->package.count; i++) {
+		info->labels[i] = devm_kmemdup(dev, rez->package.elements[i].string.pointer,
+					       (size_t)rez->package.elements[i].string.length + 1,
+					       GFP_KERNEL);
+		info->labels[i][rez->package.elements[i].string.length] = '\0';
+	}
+
+	ACPI_FREE(rez);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1944_ACPI_GET_UOHMS_VALS, NULL);
+	if (!rez)
+		return false;
+
+	for (i = 0; i < rez->package.count; i++) {
+		info->shunts[i] = rez->package.elements[i].integer.value;
+		info->active_channels[i] = (info->shunts[i] != 0);
+	}
+
+	ACPI_FREE(rez);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1944_ACPI_GET_BIPOLAR_SETTINGS, NULL);
+	if (!rez)
+		return false;
+
+	for (i = 0; i < (rez->package.count >> 1); i++) {
+		if (!info->active_channels[i])
+			continue;
+
+		bi_dir_mask = rez->package.elements[i].integer.value;
+
+		if (bi_dir_mask == PAC1944_UNIPOLAR_FSR_CFG ||
+		    bi_dir_mask == PAC1944_BIPOLAR_FSR_CFG  ||
+		    bi_dir_mask == PAC1944_BIPOLAR_HALF_FSR_CFG) {
+			dev_dbg(dev, "VBUS{%d} mode set to: %d\n",
+				i, bi_dir_mask);
+			info->chip_reg_data.vbus_mode[i] = bi_dir_mask;
+		} else {
+			dev_err(dev, "invalid vbus-mode value on %i\n", i);
+		}
+
+		bi_dir_mask = rez->package.elements[i + PAC1944_MAX_CH].integer.value;
+
+		if (bi_dir_mask == PAC1944_UNIPOLAR_FSR_CFG ||
+		    bi_dir_mask == PAC1944_BIPOLAR_FSR_CFG  ||
+		    bi_dir_mask == PAC1944_BIPOLAR_HALF_FSR_CFG) {
+			dev_dbg(dev, "VSENSE{%d} mode set to: %d\n", i, bi_dir_mask);
+			info->chip_reg_data.vsense_mode[i] = bi_dir_mask;
+		} else {
+			dev_err(dev, "invalid vsense-mode value on %i\n", i);
+		}
+	}
+
+	ACPI_FREE(rez);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1944_ACPI_GET_SAMP, NULL);
+	if (!rez)
+		return false;
+
+	info->sample_rate_value = rez->package.elements[0].integer.value;
+
+	ACPI_FREE(rez);
+
+	return true;
+}
+
+static bool pac1944_of_parse_channel_config(struct i2c_client *client,
+					    struct pac1944_chip_info *info)
+{
+	struct fwnode_handle *node, *fwnode;
+	unsigned int current_channel;
+	int idx, ret;
+	int temp;
+
+	current_channel = 1;
+
+	fwnode = dev_fwnode(&client->dev);
+	fwnode_for_each_available_child_node(fwnode, node) {
+		ret = fwnode_property_read_u32(node, "reg", &idx);
+		if (ret) {
+			dev_err_probe(&client->dev, ret,
+				      "reading invalid channel index\n");
+			goto err_fwnode;
+		}
+		/* adjust idx to match channel index (1 to 4) from the datasheet */
+		idx--;
+
+		if (current_channel >= (info->phys_channels + 1) ||
+		    idx >= info->phys_channels || idx < 0) {
+			dev_err(&client->dev,
+				"invalid channel_index %d value on %s\n",
+				(idx + 1), fwnode_get_name(node));
+			goto err_fwnode;
+		}
+
+		/* enable channel */
+		info->active_channels[idx] = true;
+
+		ret = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
+					       &info->shunts[idx]);
+		if (ret) {
+			dev_err_probe(&client->dev, ret,
+				      "%s: invalid shunt-resistor value: %d\n",
+				      fwnode_get_name(node), info->shunts[idx]);
+			goto err_fwnode;
+		}
+
+		if (fwnode_property_present(node, "label")) {
+			fwnode_property_read_string(node, "label",
+						    (const char **)&info->labels[idx]);
+		}
+
+		ret = fwnode_property_read_u32(node, "microchip,vbus-mode", &temp);
+		if (ret) {
+			dev_err(&client->dev,
+				"invalid vbus-mode value on %s\n",
+				fwnode_get_name(node));
+			goto err_fwnode;
+		}
+		if (temp == PAC1944_UNIPOLAR_FSR_CFG ||
+		    temp == PAC1944_BIPOLAR_FSR_CFG  ||
+		    temp == PAC1944_BIPOLAR_HALF_FSR_CFG) {
+			dev_dbg(&client->dev,
+				"VBUS{%d} mode set to: %d\n",
+				idx, temp);
+			info->chip_reg_data.vbus_mode[idx] = temp;
+		} else {
+			dev_err(&client->dev,
+				"invalid vbus-mode value on %s\n",
+				fwnode_get_name(node));
+			goto err_fwnode;
+		}
+
+		ret = fwnode_property_read_u32(node, "microchip,vsense-mode", &temp);
+		if (ret) {
+			dev_err(&client->dev,
+				"invalid vsense-mode value on %s\n",
+				fwnode_get_name(node));
+			goto err_fwnode;
+		}
+		if (temp == PAC1944_UNIPOLAR_FSR_CFG ||
+		    temp == PAC1944_BIPOLAR_FSR_CFG  ||
+		    temp == PAC1944_BIPOLAR_HALF_FSR_CFG) {
+			dev_dbg(&client->dev,
+				"VSENSE{%d} mode set to: %d\n",
+				idx, temp);
+			info->chip_reg_data.vsense_mode[idx] = temp;
+		} else {
+			dev_err(&client->dev,
+				"invalid vsense-mode value on %s\n",
+				fwnode_get_name(node));
+			goto err_fwnode;
+		}
+
+		ret = fwnode_property_read_u32(node, "microchip,accumulation-mode", &temp);
+		if (ret) {
+			dev_err(&client->dev,
+				"invalid accumulation-mode value on %s\n",
+				fwnode_get_name(node));
+			goto err_fwnode;
+		}
+		if (temp == PAC1944_ACCMODE_VPOWER ||
+		    temp == PAC1944_ACCMODE_VSENSE ||
+		    temp == PAC1944_ACCMODE_VBUS) {
+			dev_dbg(&client->dev,
+				"Accumulation{%d} mode set to: %d\n",
+				idx, temp);
+			info->chip_reg_data.accumulation_mode[idx] = temp;
+		} else {
+			dev_err(&client->dev,
+				"invalid mode for accumulator value on %s\n",
+				fwnode_get_name(node));
+		}
+		current_channel++;
+	}
+
+	return true;
+
+err_fwnode:
+	fwnode_handle_put(node);
+
+	return false;
+}
+
+static void pac1944_cancel_delayed_work(void *dwork)
+{
+	cancel_delayed_work_sync(dwork);
+}
+
+static int pac1944_chip_identify(struct pac1944_chip_info *info)
+{
+	int ret = 0;
+	struct i2c_client *client = info->client;
+	u8 chip_rev_info[3];
+
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_PID_REG_ADDR,
+					    sizeof(chip_rev_info),
+					    chip_rev_info);
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot read revision\n");
+		return ret;
+	}
+
+	dev_info(&client->dev, "Chip revision: 0x%02X\n", chip_rev_info[2]);
+	info->chip_revision = chip_rev_info[2];
+	info->chip_variant = chip_rev_info[0];
+
+	switch (chip_rev_info[0]) {
+	case PAC_PRODUCT_ID_1941_1:
+	case PAC_PRODUCT_ID_1942_1:
+	case PAC_PRODUCT_ID_1943_1:
+	case PAC_PRODUCT_ID_1944_1:
+	case PAC_PRODUCT_ID_1941_2:
+	case PAC_PRODUCT_ID_1942_2:
+		info->is_pac195x_family = false;
+		return (chip_rev_info[0] - PAC_PRODUCT_ID_1941_1);
+	case PAC_PRODUCT_ID_1951_1:
+	case PAC_PRODUCT_ID_1952_1:
+	case PAC_PRODUCT_ID_1953_1:
+	case PAC_PRODUCT_ID_1954_1:
+	case PAC_PRODUCT_ID_1951_2:
+	case PAC_PRODUCT_ID_1952_2:
+		info->is_pac195x_family = true;
+		return ((chip_rev_info[0] - PAC_PRODUCT_ID_1951_1) +
+			(PAC_PRODUCT_ID_1942_2 - PAC_PRODUCT_ID_1941_1) + 1);
+	default:
+		dev_err(&client->dev,
+			"product ID (0x%02X, 0x%02X, 0x%02X) for this part doesn't match\n",
+			chip_rev_info[0], chip_rev_info[1], chip_rev_info[2]);
+		return -EINVAL;
+	}
+}
+
+static int pac1944_chip_configure(struct pac1944_chip_info *info)
+{
+	int cnt, ret = 0;
+	struct i2c_client *client = info->client;
+	u8 regs[PAC1944_ALERTS_REG_LEN];
+	u8 *offset_p;
+	u32 wait_time;
+	u8 tmp_u8;
+	u16 tmp_u16;
+
+	/*
+	 * Counting how many channels are enabled and store
+	 * this information within the driver data
+	 */
+	cnt = 0;
+	info->num_enabled_channels = 0;
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (info->active_channels[cnt])
+			info->num_enabled_channels++;
+	}
+
+	/* get sampling rate from PAC */
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_REG_ADDR,
+					    sizeof(tmp_u16), (u8 *)&tmp_u16);
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot read 0x%02X reg\n", PAC1944_CTRL_REG_ADDR);
+		return ret;
+	}
+	be16_to_cpus(&tmp_u16);
+
+	info->sampling_mode = FIELD_GET(PAC1944_CTRL_SAMPLE_MASK, tmp_u16);
+
+	/*
+	 * The current/voltage can be measured unidirectional, bidirectional or half FSR
+	 * no SLOW triggered REFRESH, clear POR
+	 */
+
+	tmp_u16 = FIELD_PREP(PAC1944_NEG_PWR_CFG_VS1_MASK, info->chip_reg_data.vsense_mode[0]) |
+		FIELD_PREP(PAC1944_NEG_PWR_CFG_VS2_MASK, info->chip_reg_data.vsense_mode[1]) |
+		FIELD_PREP(PAC1944_NEG_PWR_CFG_VS3_MASK, info->chip_reg_data.vsense_mode[2]) |
+		FIELD_PREP(PAC1944_NEG_PWR_CFG_VS4_MASK, info->chip_reg_data.vsense_mode[3]) |
+		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB1_MASK, info->chip_reg_data.vbus_mode[0]) |
+		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB2_MASK, info->chip_reg_data.vbus_mode[1]) |
+		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB3_MASK, info->chip_reg_data.vbus_mode[2]) |
+		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB4_MASK, info->chip_reg_data.vbus_mode[3]);
+
+	cpu_to_be16s(&tmp_u16);
+
+	ret = i2c_smbus_write_word_data(client, PAC1944_NEG_PWR_FSR_REG_ADDR, tmp_u16);
+	if (ret) {
+		dev_err(&client->dev, "cannot write 0x%02X reg\n",
+			PAC1944_NEG_PWR_FSR_REG_ADDR);
+		return ret;
+	}
+
+	tmp_u16 = 0;
+	ret = i2c_smbus_write_word_data(client, PAC1944_SLOW_REG_ADDR, tmp_u16);
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot write 0x%02X reg\n",
+			PAC1944_SLOW_REG_ADDR);
+		return ret;
+	}
+
+	/* Write the CHANNEL_N_OFF from CTRL REGISTER */
+	tmp_u16 = FIELD_PREP(PAC1944_CTRL_SAMPLE_MASK, info->sampling_mode) |
+		FIELD_PREP(PAC1944_CTRL_GPIO_ALERT2_MASK, 0) |
+		FIELD_PREP(PAC1944_CTRL_SLOW_ALERT1_MASK, 0) |
+		FIELD_PREP(PAC1944_CTRL_CH_1_OFF_MASK, !(info->active_channels[0])) |
+		FIELD_PREP(PAC1944_CTRL_CH_2_OFF_MASK, !(info->active_channels[1])) |
+		FIELD_PREP(PAC1944_CTRL_CH_3_OFF_MASK, !(info->active_channels[2])) |
+		FIELD_PREP(PAC1944_CTRL_CH_4_OFF_MASK, !(info->active_channels[3]));
+
+	cpu_to_be16s(&tmp_u16);
+
+	ret = i2c_smbus_write_word_data(client, PAC1944_CTRL_REG_ADDR, tmp_u16);
+	if (ret) {
+		dev_err(&client->dev, "cannot write 0x%02X reg\n",
+			PAC1944_CTRL_REG_ADDR);
+		return ret;
+	}
+
+	tmp_u8 = ACCUM_REG(info->chip_reg_data.accumulation_mode[0],
+			   info->chip_reg_data.accumulation_mode[1],
+			   info->chip_reg_data.accumulation_mode[2],
+			   info->chip_reg_data.accumulation_mode[3]);
+
+	ret = i2c_smbus_write_byte_data(client, PAC1944_ACCUM_CFG_REG_ADDR, tmp_u8);
+	if (ret) {
+		dev_err(&client->dev, "cannot write 0x%02X reg\n",
+			PAC1944_ACCUM_CFG_REG_ADDR);
+		return ret;
+	}
+
+	/* reading all alerts, status and limits related registers */
+	ret = pac1944_i2c_read(client, PAC1944_ALERT_STATUS_REG_ADDR,
+			       (u8 *)regs, sizeof(regs));
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot read 0x%02X reg\n",
+			PAC1944_ALERT_STATUS_REG_ADDR);
+		return ret;
+	}
+
+	offset_p = &regs[0];
+
+	/* skip alert_status register*/
+	offset_p += 3;
+
+	info->slow_alert1 =  get_unaligned_be24(offset_p);
+	offset_p += 3;
+
+	info->gpio_alert2 =  get_unaligned_be24(offset_p);
+	offset_p += 3;
+
+	tmp_u16 = get_unaligned_be16(offset_p);
+	offset_p += 2;
+
+	info->acc_fullness = get_unaligned_be16(offset_p);
+	offset_p += 2;
+
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
+		info->overcurrent[cnt] = get_unaligned_be16(offset_p);
+		offset_p += 2;
+	}
+
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
+		info->undercurrent[cnt] = get_unaligned_be16(offset_p);
+		offset_p += 2;
+	}
+
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
+		info->overpower[cnt] =  get_unaligned_be24(offset_p);
+		offset_p += 3;
+	}
+
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
+		info->overvoltage[cnt] = get_unaligned_be16(offset_p);
+		offset_p += 2;
+	}
+
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++) {
+		info->undervoltage[cnt] = get_unaligned_be16(offset_p);
+		offset_p += 2;
+	}
+
+	offset_p += 1;
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
+		info->oc_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
+
+	offset_p += 1;
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
+		info->uc_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
+
+	offset_p += 1;
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
+		info->op_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
+
+	offset_p += 1;
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
+		info->ov_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
+
+	offset_p += 1;
+	for (cnt = 0; cnt < PAC1944_MAX_CH; cnt++)
+		info->uv_limit_nsamples[cnt] = (*offset_p >> (2 * cnt)) & 0x03;
+
+	offset_p += 1;
+	info->alert_enable =  get_unaligned_be24(offset_p);
+
+	/*
+	 * Sending a REFRESH to the chip, so the new settings take place
+	 * as well as resetting the accumulators
+	 */
+	ret = i2c_smbus_write_byte(client, PAC1944_REFRESH_REG_ADDR);
+	if (ret) {
+		dev_err(&client->dev, "cannot write 0x%02X reg\n",
+			PAC1944_REFRESH_REG_ADDR);
+		return ret;
+	}
+
+	/*
+	 * Get the current (in the chip) sampling speed and compute the
+	 * required timeout based on its value the timeout is 1/sampling_speed
+	 * wait the maximum amount of time to be on the safe side - the
+	 * maximum wait time is for 8sps
+	 */
+	wait_time = (1024 / samp_rate_map_tbl[info->sampling_mode]) * 1000;
+	usleep_range(wait_time, wait_time + 100);
+
+	INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1944_work_periodic_rfsh);
+	/* Setup the latest moment for reading the regs before saturation */
+	schedule_delayed_work(&info->work_chip_rfsh,
+			      msecs_to_jiffies(PAC1944_MAX_RFSH_LIMIT_MS));
+
+	return devm_add_action_or_reset(&client->dev, pac1944_cancel_delayed_work,
+					&info->work_chip_rfsh);
+}
+
+static const struct iio_chan_spec pac1944_single_channel[] = {
+	PAC1944_VPOWER_CHANNEL(0, 0, PAC1944_VPOWER_1_ADDR, pac1944_single_event,
+			       ARRAY_SIZE(pac1944_single_event)),
+	PAC1944_VBUS_CHANNEL(0, 0, PAC1944_VBUS_1_ADDR, pac1944_events,
+			     ARRAY_SIZE(pac1944_events)),
+	PAC1944_VSENSE_CHANNEL(0, 0, PAC1944_VSENSE_1_ADDR, pac1944_events,
+			       ARRAY_SIZE(pac1944_events)),
+	PAC1944_VBUS_AVG_CHANNEL(0, 0, PAC1944_VBUS_AVG_1_ADDR),
+	PAC1944_VSENSE_AVG_CHANNEL(0, 0, PAC1944_VSENSE_AVG_1_ADDR),
+};
+
+static int pac1944_prep_iio_channels(struct pac1944_chip_info *info,
+				     struct iio_dev *indio_dev)
+{
+	struct device *dev = &info->client->dev;
+	struct iio_chan_spec *ch_sp;
+	int channel_size, attribute_count;
+	int cnt;
+	void *dyn_ch_struct, *tmp_data;
+
+	/* Finding out dynamically how many IIO channels we need */
+	attribute_count = 0;
+	channel_size = 0;
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (!info->active_channels[cnt])
+			continue;
+
+		/* add the size of the properties of one chip physical channel */
+		channel_size += sizeof(pac1944_single_channel);
+		/* count how many enabled channels we have */
+		attribute_count += ARRAY_SIZE(pac1944_single_channel);
+		dev_info(dev, ":%s: Channel %d active\n", __func__, cnt + 1);
+	}
+
+	dyn_ch_struct = devm_kzalloc(dev, channel_size, GFP_KERNEL);
+	if (!dyn_ch_struct)
+		return -EINVAL;
+
+	tmp_data = dyn_ch_struct;
+	/* Populate the dynamic channels and make all the adjustments */
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (!info->active_channels[cnt])
+			continue;
+
+		memcpy(tmp_data, pac1944_single_channel, sizeof(pac1944_single_channel));
+		ch_sp = (struct iio_chan_spec *)tmp_data;
+		ch_sp[PAC1944_CH_POWER].channel = cnt + 1;
+		ch_sp[PAC1944_CH_POWER].scan_index = cnt;
+		ch_sp[PAC1944_CH_POWER].address = cnt + PAC1944_VPOWER_1_ADDR;
+		ch_sp[PAC1944_CH_VOLTAGE].channel = cnt + 1;
+		ch_sp[PAC1944_CH_VOLTAGE].scan_index = cnt;
+		ch_sp[PAC1944_CH_VOLTAGE].address = cnt + PAC1944_VBUS_1_ADDR;
+		ch_sp[PAC1944_CH_CURRENT].channel = cnt + 1;
+		ch_sp[PAC1944_CH_CURRENT].scan_index = cnt;
+		ch_sp[PAC1944_CH_CURRENT].address = cnt + PAC1944_VSENSE_1_ADDR;
+		/*
+		 * In order to be able to use labels for PAC1944_CH_VOLTAGE and
+		 * PAC1944_CH_VOLTAGE_AVERAGE, respectively PAC1944_CH_CURRENT
+		 * and PAC1944_CH_CURRENT_AVERAGE we need to use different channel numbers.
+		 * We will add  +5 (+1 to maximum PAC channels).
+		 */
+		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].channel = cnt + 5;
+		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].scan_index = cnt;
+		ch_sp[PAC1944_CH_VOLTAGE_AVERAGE].address = cnt + PAC1944_VBUS_AVG_1_ADDR;
+		ch_sp[PAC1944_CH_CURRENT_AVERAGE].channel = cnt + 5;
+		ch_sp[PAC1944_CH_CURRENT_AVERAGE].scan_index = cnt;
+		ch_sp[PAC1944_CH_CURRENT_AVERAGE].address = cnt + PAC1944_VSENSE_AVG_1_ADDR;
+
+		/* advance the pointer */
+		tmp_data += sizeof(pac1944_single_channel);
+	}
+
+	/*
+	 * Send the updated dynamic channel structure information towards IIO
+	 * prepare the required field for IIO class registration
+	 */
+	indio_dev->num_channels = attribute_count;
+	indio_dev->channels = (const struct iio_chan_spec *)dyn_ch_struct;
+
+	return 0;
+}
+
+static void pac1944_mutex_destroy(void *data)
+{
+	struct mutex *lock = data;
+
+	mutex_destroy(lock);
+}
+
+static const struct iio_info pac1944_info = {
+	.read_raw = pac1944_read_raw,
+	.read_label = pac1944_read_label,
+	.read_event_value = pac1944_read_thresh,
+	.write_event_value = pac1944_write_thresh,
+	.read_event_config = pac1944_read_event_config,
+	.write_event_config = pac1944_write_event_config,
+};
+
+static int pac1944_probe(struct i2c_client *client)
+{
+	struct pac1944_chip_info *info;
+	struct iio_dev *indio_dev;
+	const struct pac1944_features *chip;
+	bool match = false;
+	int cnt, ret;
+	struct device *dev = &client->dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	info->client = client;
+
+	ret = pac1944_chip_identify(info);
+	if (ret < 0) {
+		/*
+		 * If failed to identify the hardware based on internal
+		 * registers,try using fallback compatible in device tree to
+		 * deal with some newer part number.
+		 */
+		chip = i2c_get_match_data(client);
+		if (!chip)
+			return -EINVAL;
+
+		info->chip_variant = chip->prod_id;
+		info->phys_channels = chip->phys_channels;
+		indio_dev->name = chip->name;
+	} else {
+		info->phys_channels = pac1944_chip_config[ret].phys_channels;
+		indio_dev->name = pac1944_chip_config[ret].name;
+	}
+
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		/* always start with accumulation channels enabled */
+		info->enable_acc[cnt] = true;
+	}
+
+	if (ACPI_HANDLE(dev))
+		match = pac1944_acpi_parse_channel_config(client, info);
+	else
+		match = pac1944_of_parse_channel_config(client, info);
+
+	if (!match)
+		return dev_err_probe(dev, -EINVAL,
+				     "parameter parsing returned an error\n");
+
+	mutex_init(&info->lock);
+	ret = devm_add_action_or_reset(&client->dev, pac1944_mutex_destroy,
+				       &info->lock);
+	if (ret < 0)
+		return ret;
+
+	ret = pac1944_chip_configure(info);
+	if (ret < 0)
+		return ret;
+
+	ret = pac1944_prep_iio_channels(info, indio_dev);
+	if (ret < 0)
+		return ret;
+
+	info->iio_info = pac1944_info;
+	indio_dev->info = &info->iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = pac1944_prep_custom_attributes(info, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Can't configure custom attributes for PAC194x/5x device\n");
+
+	ret = pac1944_reg_snapshot(info, true, false,
+				   PAC1944_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Can't register IIO device\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id pac1944_id[] = {
+	{ .name = "pac1941_1", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1941_1] },
+	{ .name = "pac1941_2", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1941_2] },
+	{ .name = "pac1942_1", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1942_1] },
+	{ .name = "pac1942_2", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1942_2] },
+	{ .name = "pac1943_1", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1943_1] },
+	{ .name = "pac1944_1", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1944_1] },
+	{ .name = "pac1951_1", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1951_1] },
+	{ .name = "pac1951_2", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1951_2] },
+	{ .name = "pac1952_1", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1952_1] },
+	{ .name = "pac1952_2", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1952_2] },
+	{ .name = "pac1953_1", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1953_1] },
+	{ .name = "pac1954_1", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1954_1] },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pac1944_id);
+
+static const struct of_device_id pac1944_of_match[] = {
+	{
+		.compatible = "microchip,pac1941_1",
+		.data = (void *)&pac1944_chip_config[PAC1941_1]
+	},
+	{
+		.compatible = "microchip,pac1941_2",
+		.data = (void *)&pac1944_chip_config[PAC1941_2]
+	},
+	{
+		.compatible = "microchip,pac1942_1",
+		.data = (void *)&pac1944_chip_config[PAC1942_1]
+	},
+	{
+		.compatible = "microchip,pac1942_2",
+		.data = (void *)&pac1944_chip_config[PAC1942_2]
+	},
+	{
+		.compatible = "microchip,pac1943_1",
+		.data = (void *)&pac1944_chip_config[PAC1943_1]
+	},
+	{
+		.compatible = "microchip,pac1944_1",
+		.data = (void *)&pac1944_chip_config[PAC1944_1]
+	},
+	{
+		.compatible = "microchip,pac1951_1",
+		.data = (void *)&pac1944_chip_config[PAC1951_1]
+	},
+	{
+		.compatible = "microchip,pac1951_2",
+		.data = (void *)&pac1944_chip_config[PAC1951_2]
+	},
+	{
+		.compatible = "microchip,pac1952_1",
+		.data = (void *)&pac1944_chip_config[PAC1952_1]
+	},
+	{
+		.compatible = "microchip,pac1952_2",
+		.data = (void *)&pac1944_chip_config[PAC1952_2]
+	},
+	{
+		.compatible = "microchip,pac1953_1",
+		.data = (void *)&pac1944_chip_config[PAC1953_1]
+	},
+	{
+		.compatible = "microchip,pac1954_1",
+		.data = (void *)&pac1944_chip_config[PAC1954_1]
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, pac1944_of_match);
+
+/* using MCHP1940 to be compatible with BIOS ACPI */
+static const struct acpi_device_id pac1944_acpi_match[] = {
+	{ "MCHP1940", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1944_1] },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, pac1944_acpi_match);
+
+static struct i2c_driver pac1944_driver = {
+	.driver = {
+		.name = "pac1944",
+		.of_match_table = pac1944_of_match,
+		.acpi_match_table = pac1944_acpi_match
+	},
+	.probe = pac1944_probe,
+	.id_table = pac1944_id,
+};
+
+module_i2c_driver(pac1944_driver);
+
+MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
+MODULE_DESCRIPTION("Microchip PAC194X and PAC195X Power Monitor");
+MODULE_LICENSE("GPL v2");
-- 
2.43.0


