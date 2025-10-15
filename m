Return-Path: <linux-iio+bounces-25107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D711DBDF9F7
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 18:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDFB1A21B37
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D43376AF;
	Wed, 15 Oct 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oy42KK08"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B23375D3;
	Wed, 15 Oct 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545220; cv=none; b=QkhtSDhHowqOisLjeqaYJ5iW0OHtOzKfE9otHLHMpK1Lvq6zLYytU/1KiLjqeFtzTsA5UCATgIYFmV61wlcgqpzGifgVYZXq831wCf0vO3YoGYxxL08ev0OVncKSQrcPsyEEx5JZpglx3hYcqIqs5AwbeDGor59iz1Joudq2q3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545220; c=relaxed/simple;
	bh=ok0SeTupu1POHX6qmb3V49MioaQuHhwPV+K+AiRZsWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FhQB+JJtA3apDu/3+hGhmaLJDZ3xi3fKhvNaHt8xDo2ry6GnKfW7gvX+kO6VtpmQ+Ct3Hmlt+JXGSQvIbbrgUsKGqbBcV1vZhBSZbkkhaCHrbHUdBazW/jJKmqXZdWcEFSmTrej0mCLKHSKe3wR+UrODrJV8MXHZxqEijtRnl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oy42KK08; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760545217; x=1792081217;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ok0SeTupu1POHX6qmb3V49MioaQuHhwPV+K+AiRZsWw=;
  b=oy42KK0816L3Vp68CT/ux7uyHq29XoRq6ebdJ+rN29wKbyNIxoFwT52A
   XitlX5miu+GblLanumJEQGC0GT5dHbAH6kDoWkvUFCokKh7T8R3KV4C2s
   PhTA08ONXxf77W91rotivA+TABB8qKZ3n5cAILgdOe6GqBrBaXeyFm9j1
   YwP0N3V6zeUEW+V/lypEaD+6smJlP+y53GRLNLIWtN205OiPDJbJ5DKsD
   3oGBq+4kcecsuLW3qV+WJuOXHCIIPwjbb30lcxhFhSMktJLJlZ+Bs/fcy
   wQPQ1X87OpZU0m/HPiqCRvNE/ObYEDD3uS2tQt8ChSIYiJ17ABnHt2oEv
   w==;
X-CSE-ConnectionGUID: M1xrWlSdRa+eGCjzifwSqQ==
X-CSE-MsgGUID: wyLs3a85QLiLCyPvEtIxCA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="47204433"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 09:20:09 -0700
Received: from chn-vm-ex1.mchp-main.com (10.10.87.30) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 15 Oct 2025 09:19:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Wed, 15 Oct 2025 09:19:52 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 15 Oct 2025 09:19:49 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 15 Oct 2025 13:12:16 +0300
Subject: [PATCH 2/2] iio: adc: adding support for PAC1711
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251015-pac1711-v1-2-976949e36367@microchip.com>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
In-Reply-To: <20251015-pac1711-v1-0-976949e36367@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760523137; l=48825;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=ok0SeTupu1POHX6qmb3V49MioaQuHhwPV+K+AiRZsWw=;
 b=QLubU19T7IJTz/3lhjD/4Yo0TpT3ca8oK3IrQ+I8Saxoc3NR0Q6ShQHP7XoaXIMJb0QV3tJao
 RqAxTii3+RBDVNK/ft9lIN89Tni2brC+v9CctL0BLHOigqMWClGSa1C
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the iio driver for Microchip PAC1711 single-channel power monitor
with accumulator. The device uses 12-bit resolution for voltage and current
measurements and 24 bits power calculations. The device supports one 56-bit
accumulator register.

PAC1711 measures up to 42V Full-Scale Range.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-pac1711          |   57 +
 MAINTAINERS                                        |    2 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/pac1711.c                          | 1448 ++++++++++++++++++++
 5 files changed, 1518 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
new file mode 100644
index 0000000000000000000000000000000000000000..7f6ab50d29ff064d57b80df0a0c162a4c98764f8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
@@ -0,0 +1,57 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The value of the shunt resistor may be known only at runtime and
+		set by a client application. This attribute allows to set its
+		value in micro-ohms. X is the IIO index of the device. The value
+		is used to calculate current, power and accumulated energy.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current_acc_raw
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to read the accumulated voltage measured
+		on the shunt resistor (Coulomb counter). Units after application
+		of scale are mA. X is the IIO index of the device.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current_acc_scale
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If known for a device, scale to be applied to in_current_raw in
+		order to obtain the measured value in mA units. X is the IIO
+		index of the device.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current_acc_en
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, is used to enable digital
+		accumulation of VSENSE measurements. X is the IIO index of the
+		device.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_acc_raw
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to read the accumulated voltage on VBUS.
+		Units after application of scale are mV. X is the IIO index of
+		the device.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_acc_scale
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If known for a device, scale to be applied to in_voltage_raw
+		in order to obtain the measured value in mV units. X is the IIO
+		index of the device.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_acc_en
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, is used to enable digital
+		accumulation of VBUS measurements. X is the IIO index of the
+		device.
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 7686e2516c90442aa3e23d19cfb08e280a44ba76..d4d4e303ad278cbf8f628b52e3b5ebe60fb1bf09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16341,7 +16341,9 @@ MICROCHIP PAC1711 DAC DRIVER
 M:	Ariana Lazar <ariana.lazar@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
+F:	Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
 F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
+F:	drivers/iio/adc/pac1711.c
 
 MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
 M:	Matteo Martelli <matteomartelli3@gmail.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ea3ba139739281de82848e25fd2b6ca479a939dc..c91c66e583d1ce07aa1813a84d461ebd3fb6344d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1125,6 +1125,16 @@ config NPCM_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called npcm_adc.
 
+config PAC1711
+        tristate "Microchip Technology PAC1711 driver"
+        depends on I2C
+        help
+          Say yes here to build support for Microchip Technology's PAC1711
+          Single-Channel Power Monitor with Accumulator.
+
+          This driver can also be built as a module. If so, the module
+          will be called pac1711.
+
 config PAC1921
 	tristate "Microchip Technology PAC1921 driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 09ae6edb26504991f011def6618efc3f4cf4df4c..d039a23cde02d442b161730ad2c939c7d035a4c6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_NCT7201) += nct7201.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
+obj-$(CONFIG_PAC1711) += pac1711.o
 obj-$(CONFIG_PAC1921) += pac1921.o
 obj-$(CONFIG_PAC1934) += pac1934.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
diff --git a/drivers/iio/adc/pac1711.c b/drivers/iio/adc/pac1711.c
new file mode 100644
index 0000000000000000000000000000000000000000..30929af202e009c2d80ba91d5c137a26a03f09d7
--- /dev/null
+++ b/drivers/iio/adc/pac1711.c
@@ -0,0 +1,1448 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for PAC1711 Multi-Channel DC Power/Energy Monitor
+ *
+ * Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ariana Lazar <ariana.lazar@microchip.com>
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/unaligned.h>
+
+/*
+ * maximum accumulation time should be 1,165 hours at 1,024 sps
+ * till PAC1711 accumulation registers starts to saturate
+ */
+#define PAC1711_MAX_RFSH_LIMIT_MS		60000
+/* 50msec is the timeout for validity of the cached registers */
+#define PAC1711_MIN_POLLING_TIME_MS		50
+/*
+ * 1000usec is the minimum wait time for normal conversions when sample
+ * rate doesn't change
+ */
+#define PAC1711_MIN_UPDATE_WAIT_TIME_US		1000
+
+/* 42000mV */
+#define PAC1711_VOLTAGE_MILLIVOLTS_MAX	42000
+
+/* voltage bits resolution when set for unsigned values */
+#define PAC1711_VOLTAGE_12B_RES			12
+/* voltage bits resolution when set for signed values */
+#define PAC1711_VOLTAGE_11B_RES			11
+
+/* Power resolution is 24 bits when contains unsigned values */
+#define PAC1711_POWER_24B_RES			24
+/* Power resolution is 24 bits when contains signed values */
+#define PAC1711_POWER_23B_RES			23
+
+/* Maximum power-product value - 42 V * 0.1 V */
+#define PAC1711_PRODUCT_VOLTAGE_PV_FSR		4200000000000UL
+
+/* Scale constant = (10^3 * 4.2 * 10^9 / 2^24) for mili Watt-second */
+#define PAC1711_SCALE_CONSTANT			250340
+
+/* (100mV * 1000000) / (2^12)  used to calculate the scale for current */
+#define PAC1711_MAX_VSENSE_RSHIFTED_BY_12B	24414
+
+/*
+ * [(100mV * 1000000) / (2^12)]*10^9  used to calculate the scale
+ * for accumulated current/Coulomb counter
+ */
+#define PAC1711_MAX_VSENSE_NANO			24414062500000UL
+
+/* I2C address map */
+#define PAC1711_REFRESH_REG_ADDR		0x00
+#define PAC1711_CTRL_REG_ADDR			0x01
+#define PAC1711_ACC_COUNT_REG_ADDR		0x02
+#define PAC1711_VACC_ADDR			0x03
+#define PAC1711_VBUS_ADDR			0x04
+#define PAC1711_VSENSE_ADDR			0x05
+#define PAC1711_VBUS_AVG_ADDR			0x06
+#define PAC1711_VSENSE_AVG_ADDR			0x07
+#define PAC1711_VPOWER_ADDR			0x08
+
+/* Start of configurations registers */
+#define PAC1711_CTRL_LAT_REG_ADDR		0x0F
+#define PAC1711_NEG_PWR_FSR_REG_ADDR		0x13
+#define PAC1711_SLOW_REG_ADDR			0x16
+#define PAC1711_CTRL_ACT_REG_ADDR		0x17
+#define PAC1711_PID_REG_ADDR			0xFD
+#define PAC1711_REVISION_ID_REG_ADDR		0xFF
+
+#define PAC1711_ACC_DEVATTR			3
+#define PAC1711_COMMON_DEVATTR			1
+#define PAC1711_MEAS_REG_SNAPSHOT_LEN		23
+#define PAC1711_ACC_REG_LEN			4
+#define PAC1711_VACC_REG_LEN			7
+#define PAC1711_VBUS_SENSE_REG_LEN		2
+
+/* PRODUCT IDs */
+#define PAC_PRODUCT_ID_1711			0x80
+
+/* CTRL reg */
+#define PAC1711_CTRL_SAMPLE_MODE_MASK		GENMASK(15, 12)
+
+/* NEG_PWR_CFG reg */
+#define PAC1711_NEG_PWR_CFG_VS_MASK		GENMASK(3, 2)
+#define PAC1711_NEG_PWR_CFG_VB_MASK		GENMASK(1, 0)
+#define PAC1711_SAMPLING_MODE_MASK		GENMASK(11, 0)
+
+#define PAC1711_DEV_ATTR(name)			(&iio_dev_attr_##name.dev_attr.attr)
+
+enum pac1711_ch_idx {
+	PAC1711_CH_POWER,
+	PAC1711_CH_VOLTAGE,
+	PAC1711_CH_CURRENT,
+	PAC1711_CH_VOLTAGE_AVERAGE,
+	PAC1711_CH_CURRENT_AVERAGE,
+};
+
+enum pac1711_acc_mode {
+	PAC1711_ACCMODE_VPOWER,
+	PAC1711_ACCMODE_VSENSE,
+	PAC1711_ACCMODE_VBUS,
+};
+
+enum pac1711_fsr {
+	PAC1711_FULL_RANGE_UNIPOLAR,
+	PAC1711_FULL_RANGE_BIPOLAR,
+	PAC1711_HALF_RANGE_BIPOLAR,
+};
+
+static const int pac1711_vbus_range_tbl[][2] = {
+	[PAC1711_FULL_RANGE_UNIPOLAR] = {0, 42000000},
+	[PAC1711_FULL_RANGE_BIPOLAR] = {-42000000, 42000000},
+	[PAC1711_HALF_RANGE_BIPOLAR] = {-21000000, 21000000},
+};
+
+static const int pac1711_vsense_range_tbl[][2] = {
+	[PAC1711_FULL_RANGE_UNIPOLAR] = {0, 100000},
+	[PAC1711_FULL_RANGE_BIPOLAR] = {-100000, 100000},
+	[PAC1711_HALF_RANGE_BIPOLAR] = {-50000, 50000},
+};
+
+enum pac1711_samps {
+	PAC1711_SAMP_8192SPS,
+	PAC1711_SAMP_4096SPS,
+	PAC1711_SAMP_1024SPS,
+	PAC1711_SAMP_256SPS,
+	PAC1711_SAMP_64SPS,
+	PAC1711_SAMP_8SPS,
+};
+
+static const unsigned int pac1711_samp_rate_map_tbl[] = {
+	[PAC1711_SAMP_8192SPS] = 8192,
+	[PAC1711_SAMP_4096SPS] = 4096,
+	[PAC1711_SAMP_1024SPS] = 1024, // default
+	[PAC1711_SAMP_256SPS] = 256,
+	[PAC1711_SAMP_64SPS] = 64,
+	[PAC1711_SAMP_8SPS] = 8,
+};
+
+static const unsigned int pac1711_shift_map_tbl[] = {
+	[PAC1711_SAMP_8192SPS] = 13,
+	[PAC1711_SAMP_4096SPS] = 12,
+	[PAC1711_SAMP_1024SPS] = 10,
+	[PAC1711_SAMP_256SPS] = 8,
+	[PAC1711_SAMP_64SPS] = 6,
+	[PAC1711_SAMP_8SPS] = 3,
+};
+
+/* Available Sample Modes */
+static const char * const pac1711_frequency_avail[] = {
+	"8192",
+	"4096",
+	"1024",
+	"256",
+	"64",
+	"8",
+};
+
+/**
+ * struct pac1711_features - features of a pac1711 instance
+ * @prod_id: hardware ID
+ * @name: chip's name
+ */
+struct pac1711_features {
+	u8 prod_id;
+	const char *name;
+};
+
+static const struct pac1711_features pac1711_chip_features = {
+	.name = "pac1711",
+	.prod_id = PAC_PRODUCT_ID_1711,
+};
+
+/**
+ * struct reg_data - data from the registers
+ * @meas_regs:		snapshot of raw measurements registers
+ * @jiffies_tstamp:	timestamp
+ * @total_samples_nr:	total number of samples
+ * @ctrl_act_reg:	the ctrl_act register
+ * @ctrl_lat_reg:	the ctrl_lat register
+ * @vsense_avg:		averages of vsense registers
+ * @acc_count:		the acc_count register
+ * @vbus_avg:		averages of vbus registers
+ * @acc_val:		accumulated values per second
+ * @vpower:		vpower registers
+ * @vsense:		vsense registers
+ * @vacc:		accumulated vpower value
+ * @vbus:		vbus registers
+ */
+struct reg_data {
+	u8	meas_regs[PAC1711_MEAS_REG_SNAPSHOT_LEN];
+	unsigned long jiffies_tstamp;
+	u32	total_samples_nr;
+	u16	ctrl_act_reg;
+	u16	ctrl_lat_reg;
+	s32	vsense_avg;
+	u32	acc_count;
+	s32	vbus_avg;
+	s64	acc_val;
+	s32	vpower;
+	s32	vsense;
+	s32	vbus;
+	s64	vacc;
+};
+
+/**
+ * struct pac1711_chip_info - information about the chip
+ * @accumulation_mode:	accumulation mode for hardware accumulator
+ * @sample_rate_value:	sampling frequency
+ * @work_chip_rfsh:	work queue used for refresh commands
+ * @sampling_mode:	sampling mode used by the device
+ * @chip_reg_data:	chip reg data
+ * @chip_variant:	chip variant
+ * @vsense_mode:	Full Scale Range (FSR) mode for VSense
+ * @enable_acc:		true means that accumulation channel is measured
+ * @vbus_mode:		Full Scale Range (FSR) mode for VBus
+ * @iio_info:		iio_info
+ * @client:		the i2c-client attached to the device
+ * @label:		channel label
+ * @shunt:		shunt resistor value
+ * @lock:		synchronize access to driver's state members
+ */
+struct pac1711_chip_info {
+	u8			accumulation_mode;
+	s32			sample_rate_value;
+	struct delayed_work	work_chip_rfsh;
+	u8			sampling_mode;
+	struct reg_data		chip_reg_data;
+	u8			chip_variant;
+	u8			vsense_mode;
+	bool			enable_acc;
+	u8			vbus_mode;
+	struct iio_info		iio_info;
+	struct i2c_client	*client;
+	char			*label;
+	u32			shunt;
+	struct mutex		lock; /* synchronize access to driver's state members */
+};
+
+static inline u64 pac1711_get_unaligned_be56(u8 *p)
+{
+	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
+		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
+}
+
+static int pac1711_send_refresh(struct pac1711_chip_info *info, u8 refresh_cmd,
+				u32 wait_time)
+{
+	struct i2c_client *client = info->client;
+	int ret;
+
+	/* Writing a REFRESH or a REFRESH_V command */
+	ret = i2c_smbus_write_byte(client, refresh_cmd);
+	if (ret) {
+		dev_err(&client->dev, "%s - cannot send Refresh cmd (0x%02X)\n",
+			__func__, refresh_cmd);
+		return ret;
+	}
+
+	/* Register data retrieval timestamp */
+	info->chip_reg_data.jiffies_tstamp = jiffies;
+	/* Wait till the data is available */
+	usleep_range(wait_time, wait_time + 100);
+
+	return 0;
+}
+
+static int pac1711_reg_snapshot(struct pac1711_chip_info *info,
+				bool do_refresh, u8 refresh_cmd, u32 wait_time)
+{
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	s64 stored_value, tmp_s64;
+	u8 *offset_reg_data_p;
+	u32 count, inc_count;
+	bool is_bipolar;
+	s64 inc = 0;
+	u16 tmp_u16;
+	u8 shift;
+	int ret;
+
+	guard(mutex)(&info->lock);
+
+	if (do_refresh) {
+		ret = pac1711_send_refresh(info, refresh_cmd, wait_time);
+		if (ret < 0) {
+			dev_err(dev, "cannot send refresh\n");
+			return ret;
+		}
+	}
+
+	/* Read the ctrl/status registers for this snapshot */
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
+					    sizeof(tmp_u16), (u8 *)&tmp_u16);
+	if (ret < 0) {
+		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
+			__func__, PAC1711_CTRL_ACT_REG_ADDR);
+		return ret;
+	}
+
+	be16_to_cpus(&tmp_u16);
+	info->chip_reg_data.ctrl_act_reg = tmp_u16;
+
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_LAT_REG_ADDR,
+					    sizeof(tmp_u16), (u8 *)&tmp_u16);
+	if (ret < 0) {
+		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
+			__func__, PAC1711_CTRL_LAT_REG_ADDR);
+		return ret;
+	}
+
+	be16_to_cpus(&tmp_u16);
+	info->chip_reg_data.ctrl_lat_reg = tmp_u16;
+
+	/* Read the data registers */
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_ACC_COUNT_REG_ADDR,
+					    PAC1711_MEAS_REG_SNAPSHOT_LEN,
+					    (u8 *)info->chip_reg_data.meas_regs);
+	if (ret < 0) {
+		dev_err(dev, "%s - cannot read regs from 0x%02X\n",
+			__func__, PAC1711_ACC_COUNT_REG_ADDR);
+		return ret;
+	}
+
+	offset_reg_data_p = &info->chip_reg_data.meas_regs[0];
+	info->chip_reg_data.acc_count = get_unaligned_be32(offset_reg_data_p);
+	offset_reg_data_p += PAC1711_ACC_REG_LEN;
+
+	/* skip if the energy accumulation is disabled */
+	if (info->enable_acc) {
+		stored_value = info->chip_reg_data.acc_val;
+
+		info->chip_reg_data.vacc = pac1711_get_unaligned_be56(offset_reg_data_p);
+		is_bipolar = false;
+
+		switch (info->accumulation_mode) {
+		case PAC1711_ACCMODE_VPOWER:
+			if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR ||
+			    info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+				is_bipolar = true;
+			break;
+		case PAC1711_ACCMODE_VBUS:
+			if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+				is_bipolar = true;
+			break;
+		case PAC1711_ACCMODE_VSENSE:
+			if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+				is_bipolar = true;
+			break;
+		}
+
+		if (is_bipolar)
+			info->chip_reg_data.vacc = sign_extend64(info->chip_reg_data.vacc, 55);
+
+		if (info->accumulation_mode != PAC1711_ACCMODE_VBUS) {
+			/* VACC */
+			/*
+			 * Integrate the accumulated power or current over
+			 * the elapsed interval.
+			 */
+			tmp_u16 = FIELD_GET(PAC1711_CTRL_SAMPLE_MODE_MASK,
+					    info->chip_reg_data.ctrl_lat_reg);
+			tmp_s64 = info->chip_reg_data.vacc;
+
+			if (tmp_u16 <= PAC1711_SAMP_8SPS) {
+				shift = pac1711_shift_map_tbl[tmp_u16];
+				inc = tmp_s64 >> shift;
+			} else {
+				dev_err(dev, "Invalid sample rate index: %d!\n", tmp_u16);
+			}
+		} else {
+			count = info->chip_reg_data.total_samples_nr;
+			inc_count = info->chip_reg_data.acc_count;
+
+			/* Check if total number of samples will overflow */
+			if (check_add_overflow(count, inc_count, &count)) {
+				dev_err(dev, "Number of samples overflow!\n");
+				info->chip_reg_data.total_samples_nr = 0;
+				info->chip_reg_data.acc_val = 0;
+			}
+
+			info->chip_reg_data.total_samples_nr += inc_count;
+			inc = info->chip_reg_data.vacc;
+		}
+
+		if (check_add_overflow(stored_value, inc, &stored_value)) {
+			if (is_negative(stored_value))
+				info->chip_reg_data.acc_val = S64_MIN;
+			else
+				info->chip_reg_data.acc_val = S64_MAX;
+
+			dev_err(dev, "Overflow detected!\n");
+		} else {
+			info->chip_reg_data.acc_val += inc;
+		}
+	}
+
+	offset_reg_data_p += PAC1711_VACC_REG_LEN;
+
+	/* VBUS */
+	info->chip_reg_data.vbus = get_unaligned_be16(offset_reg_data_p) >> 4;
+
+	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+		info->chip_reg_data.vbus = sign_extend32(info->chip_reg_data.vbus, 11);
+
+	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
+
+	/* VSENSE */
+	info->chip_reg_data.vsense = get_unaligned_be16(offset_reg_data_p) >> 4;
+
+	if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+		info->chip_reg_data.vsense = sign_extend32(info->chip_reg_data.vsense, 11);
+
+	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
+
+	/* VBUS_AVG */
+	info->chip_reg_data.vbus_avg = get_unaligned_be16(offset_reg_data_p) >> 4;
+
+	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+		info->chip_reg_data.vbus_avg = sign_extend32(info->chip_reg_data.vbus_avg, 11);
+
+	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
+
+	/* VSENSE_AVG */
+	info->chip_reg_data.vsense_avg = get_unaligned_be16(offset_reg_data_p) >> 4;
+
+	if (info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+		info->chip_reg_data.vsense_avg = sign_extend32(info->chip_reg_data.vsense_avg, 11);
+
+	offset_reg_data_p += PAC1711_VBUS_SENSE_REG_LEN;
+
+	/* VPOWER */
+	info->chip_reg_data.vpower = get_unaligned_be32(offset_reg_data_p) >> 8;
+
+	if (info->vbus_mode != PAC1711_FULL_RANGE_UNIPOLAR ||
+	    info->vsense_mode != PAC1711_FULL_RANGE_UNIPOLAR)
+		info->chip_reg_data.vpower = sign_extend32(info->chip_reg_data.vpower, 23);
+
+	return 0;
+}
+
+static int pac1711_retrieve_data(struct pac1711_chip_info *info,
+				 u32 wait_time)
+{
+	int ret;
+
+	/*
+	 * check if the minimal elapsed time has passed and if so,
+	 * re-read the chip, otherwise the cached info is just fine
+	 */
+	if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
+			msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS))) {
+		ret = pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
+					   wait_time);
+
+		/*
+		 * Re-schedule the work for the read registers timeout
+		 * (to prevent chip regs saturation)
+		 */
+		cancel_delayed_work_sync(&info->work_chip_rfsh);
+		schedule_delayed_work(&info->work_chip_rfsh,
+				      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
+	}
+
+	return ret;
+}
+
+static int pac1711_frequency_set(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				 unsigned int mode)
+{
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	u16 tmp_u16;
+	int ret;
+
+	guard(mutex)(&info->lock);
+
+	ret = i2c_smbus_read_word_swapped(client, PAC1711_CTRL_ACT_REG_ADDR);
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot read regs from 0x%02X\n",
+			PAC1711_CTRL_ACT_REG_ADDR);
+		return ret;
+	}
+
+	tmp_u16 = ret;
+	tmp_u16 &= ~PAC1711_CTRL_SAMPLE_MODE_MASK;
+	tmp_u16 |= FIELD_PREP(PAC1711_CTRL_SAMPLE_MODE_MASK, mode);
+
+	ret = i2c_smbus_write_word_swapped(client, PAC1711_CTRL_REG_ADDR, tmp_u16);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to configure sampling mode\n");
+		return ret;
+	}
+
+	info->sampling_mode = mode;
+	info->chip_reg_data.ctrl_act_reg = tmp_u16;
+
+	return pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
+}
+
+static int pac1711_frequency_get(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan)
+{
+	struct pac1711_chip_info *info;
+
+	info = iio_priv(indio_dev);
+
+	return info->sampling_mode;
+}
+
+static const struct iio_enum sampling_mode_enum = {
+	.items = pac1711_frequency_avail,
+	.num_items = ARRAY_SIZE(pac1711_frequency_avail),
+	.set = pac1711_frequency_set,
+	.get = pac1711_frequency_get,
+};
+
+static const struct iio_chan_spec_ext_info pac1711_ext_info[] = {
+	IIO_ENUM("sampling_frequency", IIO_SHARED_BY_ALL, &sampling_mode_enum),
+	{
+		.name = "sampling_frequency_available",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = iio_enum_available_read,
+		.private = (uintptr_t)&sampling_mode_enum,
+	},
+	{ }
+};
+
+#define TO_PAC1711_CHIP_INFO(d) container_of(d, struct pac1711_chip_info, work_chip_rfsh)
+
+#define PAC1711_VBUS_CHANNEL(_index, _si, _address) {		\
+	.type = IIO_VOLTAGE,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 12,					\
+		.storagebits = 16,				\
+		.shift = 4,					\
+		.endianness = IIO_CPU,				\
+	},							\
+	.ext_info =  pac1711_ext_info				\
+}
+
+#define PAC1711_VBUS_AVG_CHANNEL(_index, _si, _address) {	\
+	.type = IIO_VOLTAGE,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index) + 1,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_AVERAGE_RAW) |	\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 12,					\
+		.storagebits = 16,				\
+		.shift = 4,					\
+		.endianness = IIO_CPU,				\
+	},							\
+	.ext_info =  pac1711_ext_info				\
+}
+
+#define PAC1711_VSENSE_CHANNEL(_index, _si, _address) {		\
+	.type = IIO_CURRENT,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 12,					\
+		.storagebits = 16,				\
+		.shift = 4,					\
+		.endianness = IIO_CPU,				\
+	},							\
+	.ext_info =  pac1711_ext_info				\
+}
+
+#define PAC1711_VSENSE_AVG_CHANNEL(_index, _si, _address) {	\
+	.type = IIO_CURRENT,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index) + 1,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_AVERAGE_RAW) |	\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 12,					\
+		.storagebits = 16,				\
+		.shift = 4,					\
+		.endianness = IIO_CPU,				\
+	},							\
+	.ext_info =  pac1711_ext_info				\
+}
+
+#define PAC1711_VPOWER_CHANNEL(_index, _si, _address) {		\
+	.type = IIO_POWER,					\
+	.address = (_address),					\
+	.indexed = 1,						\
+	.channel = (_index),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = (_si),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 24,					\
+		.storagebits = 32,				\
+		.shift = 8,					\
+		.endianness = IIO_CPU,				\
+	},							\
+	.ext_info =  pac1711_ext_info				\
+}
+
+static int pac1711_get_samp_rate_idx(struct pac1711_chip_info *info, u32 new_samp_rate)
+{
+	int cnt;
+
+	for (cnt = 0; cnt < ARRAY_SIZE(pac1711_samp_rate_map_tbl); cnt++)
+		if (new_samp_rate == pac1711_samp_rate_map_tbl[cnt])
+			return cnt;
+
+	/* not a valid sample rate value */
+	return -EINVAL;
+}
+
+static ssize_t pac1711_shunt_value_show(struct device *dev, struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%u\n", info->shunt);
+}
+
+static ssize_t pac1711_shunt_value_store(struct device *dev, struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	int sh_val;
+
+	if (kstrtouint(buf, 10, &sh_val)) {
+		dev_err(dev, "Shunt value is not valid\n");
+		return -EINVAL;
+	}
+
+	scoped_guard(mutex, &info->lock)
+		info->shunt = sh_val;
+
+	return count;
+}
+
+static ssize_t pac1711_in_power_acc_raw_show(struct device *dev, struct device_attribute *attr,
+					     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	s64 curr_energy, int_part;
+	int ret, rem;
+
+	ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return 0;
+
+	/*
+	 * Expresses the 64 bit energy value as a
+	 * 64 bit integer and a 32 bit nano value
+	 */
+	curr_energy = info->chip_reg_data.acc_val;
+	int_part = div_s64_rem(curr_energy, 1000000000, &rem);
+
+	if (rem < 0)
+		return sysfs_emit(buf, "-%lld.%09u\n", abs(int_part), -rem);
+	else
+		return sysfs_emit(buf, "%lld.%09u\n", int_part, abs(rem));
+}
+
+static ssize_t pac1711_in_power_acc_scale_show(struct device *dev, struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	unsigned int rem;
+	u64 tmp, ref;
+
+	ref = (u64)PAC1711_SCALE_CONSTANT;
+	tmp = div_u64(ref * 1000000000LL, info->shunt);
+	rem = do_div(tmp, 1000000000LL);
+
+	return sysfs_emit(buf, "%lld.%09u\n", tmp, rem);
+}
+
+static ssize_t pac1711_in_enable_acc_show(struct device *dev, struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", info->enable_acc);
+}
+
+static ssize_t pac1711_in_enable_acc_store(struct device *dev, struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	int val;
+
+	if (kstrtouint(buf, 10, &val)) {
+		dev_err(dev, "Value is not valid\n");
+		return -EINVAL;
+	}
+
+	scoped_guard(mutex, &info->lock) {
+		info->enable_acc = val ? true : false;
+		if (!val) {
+			info->chip_reg_data.acc_val = 0;
+			info->chip_reg_data.total_samples_nr = 0;
+		}
+	}
+
+	return count;
+}
+
+static ssize_t pac1711_in_current_acc_raw_show(struct device *dev, struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	int ret;
+
+	ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return 0;
+
+	return sysfs_emit(buf, "%lld\n", info->chip_reg_data.acc_val);
+}
+
+static ssize_t pac1711_in_current_acc_scale_show(struct device *dev, struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	u64 tmp_u64, ref;
+	int rem;
+
+	/*
+	 * Currents - scale for mA - depends on the channel's shunt value
+	 * (100mV * 1000000) / (2^12 * shunt(uOhm))
+	 */
+	ref = (u64)PAC1711_MAX_VSENSE_NANO;
+
+	if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
+		ref = ref << 1;
+
+	/*
+	 * Increasing precision
+	 * (100mV * 1000000 * 1000000000) / 2^12)
+	 */
+	tmp_u64 = div_u64(ref, info->shunt);
+	rem = do_div(tmp_u64, 1000000000LL);
+
+	return sysfs_emit(buf, "%lld.%09u\n", tmp_u64, rem);
+}
+
+static ssize_t pac1711_in_voltage_acc_raw_show(struct device *dev, struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	u32 samples_count;
+	s64 acc_voltage;
+	u64 tmp_u64;
+	int ret;
+
+	ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return 0;
+
+	acc_voltage = info->chip_reg_data.acc_val;
+	samples_count = info->chip_reg_data.total_samples_nr;
+
+	tmp_u64 = div_u64(abs(acc_voltage), samples_count);
+
+	if (is_negative(acc_voltage))
+		return sysfs_emit(buf, "-%lld\n", tmp_u64);
+	else
+		return sysfs_emit(buf, "%lld\n", tmp_u64);
+}
+
+static ssize_t pac1711_in_voltage_acc_scale_show(struct device *dev, struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	unsigned long long tmp;
+	int vals[2];
+
+	vals[0] = PAC1711_VOLTAGE_MILLIVOLTS_MAX;
+
+	if (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR)
+		vals[1] = PAC1711_VOLTAGE_12B_RES;
+	else
+		/* PAC1711_FULL_RANGE_UNIPOLAR or PAC1711_HALF_RANGE_BIPOLAR */
+		vals[1] = PAC1711_VOLTAGE_11B_RES;
+
+	tmp = (s64)vals[0] * 1000000000LL >> vals[1];
+	vals[1] = do_div(tmp, 1000000000LL);
+	vals[0] = tmp;
+
+	return sysfs_emit(buf, "%d.%09u\n", vals[0], vals[1]);
+}
+
+static IIO_DEVICE_ATTR(in_shunt_resistor, 0644, pac1711_shunt_value_show,
+		       pac1711_shunt_value_store, 0);
+
+static struct attribute *pac1711_all_attrs[] = {
+	PAC1711_DEV_ATTR(in_shunt_resistor),
+	NULL
+};
+
+static int pac1711_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	int ret;
+	u64 tmp;
+
+	ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = info->chip_reg_data.vbus;
+			return IIO_VAL_INT;
+		case IIO_CURRENT:
+			*val = info->chip_reg_data.vsense;
+			return IIO_VAL_INT;
+		case IIO_POWER:
+			*val = info->chip_reg_data.vpower;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = info->chip_reg_data.vbus_avg;
+			return IIO_VAL_INT;
+		case IIO_CURRENT:
+			*val = info->chip_reg_data.vsense_avg;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->address) {
+		/* Voltages - scale for millivolts */
+		case PAC1711_VBUS_ADDR:
+		case PAC1711_VBUS_AVG_ADDR:
+			switch (info->chip_variant) {
+			case PAC_PRODUCT_ID_1711:
+				*val = PAC1711_VOLTAGE_MILLIVOLTS_MAX;
+				break;
+			default:
+				return -EINVAL;
+			}
+			switch (info->vbus_mode) {
+			case PAC1711_FULL_RANGE_UNIPOLAR:
+			case PAC1711_HALF_RANGE_BIPOLAR:
+				*val2 = PAC1711_VOLTAGE_12B_RES;
+				break;
+			case PAC1711_FULL_RANGE_BIPOLAR:
+				*val2 = PAC1711_VOLTAGE_11B_RES;
+				break;
+			default:
+				return -EINVAL;
+			}
+			return IIO_VAL_FRACTIONAL_LOG2;
+		/*
+		 * Currents - scale for mA - depends on the
+		 * channel's shunt value
+		 * (100mV * 1000000) / (2^16 * shunt(uohm))
+		 */
+		case PAC1711_VSENSE_ADDR:
+		case PAC1711_VSENSE_AVG_ADDR:
+			*val = PAC1711_MAX_VSENSE_RSHIFTED_BY_12B;
+			*val2 = info->shunt;
+
+			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
+				*val = *val << 1;
+
+			return IIO_VAL_FRACTIONAL;
+		/*
+		 * Power - uW - it will use the combined scale
+		 * for current and voltage
+		 * current(mA) * voltage(mV) = power (uW)
+		 */
+		case PAC1711_VPOWER_ADDR:
+			switch (info->chip_variant) {
+			case PAC_PRODUCT_ID_1711:
+				tmp = PAC1711_PRODUCT_VOLTAGE_PV_FSR;
+				break;
+			}
+
+			do_div(tmp, info->shunt);
+			*val = (int)tmp;
+			if (info->vsense_mode == PAC1711_FULL_RANGE_UNIPOLAR &&
+			    info->vbus_mode == PAC1711_FULL_RANGE_UNIPOLAR)
+				*val2 = PAC1711_POWER_24B_RES;
+			else
+				*val2 = PAC1711_POWER_23B_RES;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = info->sample_rate_value;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pac1711_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	struct device *dev = &info->client->dev;
+	int ret = -EINVAL;
+	s32 old_samp_rate;
+	u8 ctrl_reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = pac1711_get_samp_rate_idx(info, val);
+		if (ret < 0)
+			return ret;
+
+		/* write the new sampling value and trigger a snapshot */
+		scoped_guard(mutex, &info->lock) {
+			ctrl_reg = FIELD_PREP(PAC1711_CTRL_SAMPLE_MODE_MASK, ret);
+			ret = i2c_smbus_write_byte_data(client, PAC1711_CTRL_REG_ADDR, ctrl_reg);
+			if (ret) {
+				dev_err(dev, "%s - can't update sample rate\n", __func__);
+				return ret;
+			}
+		}
+
+		old_samp_rate = info->sample_rate_value;
+		info->sample_rate_value = val;
+
+		/*
+		 * now, force a snapshot with refresh - call retrieve
+		 * data in order to update the refresh timer
+		 * alter the timestamp in order to force trigger a
+		 * register snapshot and a timestamp update
+		 */
+		info->chip_reg_data.jiffies_tstamp -= msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS);
+		ret = pac1711_retrieve_data(info, (1024 / old_samp_rate) * 1000);
+		if (ret < 0) {
+			dev_err(dev, "%s - cannot snapshot ctrl and measurement regs\n", __func__);
+			return ret;
+		}
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pac1711_read_label(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, char *label)
+{
+	struct pac1711_chip_info *info = iio_priv(indio_dev);
+
+	switch (chan->address) {
+	case PAC1711_VBUS_ADDR:
+		return sysfs_emit(label, "%s_VBUS\n", info->label);
+	case PAC1711_VBUS_AVG_ADDR:
+		return sysfs_emit(label, "%s_VBUS_AVG\n", info->label);
+	case PAC1711_VSENSE_ADDR:
+		return sysfs_emit(label, "%s_IBUS\n", info->label);
+	case PAC1711_VSENSE_AVG_ADDR:
+		return sysfs_emit(label, "%s_IBUS_AVG\n", info->label);
+	case PAC1711_VPOWER_ADDR:
+		return sysfs_emit(label, "%s_POWER\n", info->label);
+	}
+
+	return 0;
+}
+
+static void pac1711_work_periodic_rfsh(struct work_struct *work)
+{
+	struct pac1711_chip_info *info = TO_PAC1711_CHIP_INFO((struct delayed_work *)work);
+	struct device *dev = &info->client->dev;
+
+	dev_dbg(dev, "%s - Periodic refresh\n", __func__);
+
+	/* do a REFRESH, then read */
+	pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
+			     PAC1711_MIN_UPDATE_WAIT_TIME_US);
+
+	schedule_delayed_work(&info->work_chip_rfsh,
+			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
+}
+
+static int pac1711_chip_identify(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
+{
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	u8 chip_rev_info[3];
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_PID_REG_ADDR,
+					    sizeof(chip_rev_info), chip_rev_info);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "cannot read product ID reg\n");
+
+	info->chip_variant = chip_rev_info[0];
+	switch (info->chip_variant) {
+	case PAC_PRODUCT_ID_1711:
+		indio_dev->name = pac1711_chip_features.name;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "product ID (0x%02X, 0x%02X, 0x%02X) not recognized\n",
+				     chip_rev_info[0], chip_rev_info[1], chip_rev_info[2]);
+	}
+
+	return 0;
+}
+
+static int pac1711_check_range(s32 *vals, const int ranges[][2], int num_ranges)
+{
+	int i;
+
+	for (i = 0; i < num_ranges; i++) {
+		if (vals[0] == ranges[i][0] && vals[1] == ranges[i][1])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int pac1711_setup_vbus_range(struct pac1711_chip_info *info)
+{
+	const char *prop_name = "microchip,vbus-input-range-microvolt";
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	unsigned int tbl_len, ret;
+	s32 vals[2];
+
+	/* default value is unipolar and Full Scale Range */
+	ret = device_property_read_u32_array(dev, prop_name, vals, 2);
+	if (!ret) {
+		tbl_len = ARRAY_SIZE(pac1711_vbus_range_tbl);
+		ret = pac1711_check_range(vals, pac1711_vbus_range_tbl, tbl_len);
+		if (ret < 0)
+			return dev_err_probe(dev, -EINVAL, "Invalid value %d, %d for prop %s\n",
+					     vals[0], vals[1], prop_name);
+
+		info->vbus_mode = ret;
+	}
+
+	return 0;
+}
+
+static int pac1711_setup_vsense_range(struct pac1711_chip_info *info)
+{
+	const char *prop_name = "microchip,vsense-input-range-microvolt";
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	unsigned int tbl_len, ret;
+	s32 vals[2];
+
+	/* default value is unipolar and Full Scale Range */
+	ret = device_property_read_u32_array(dev, prop_name, vals, 2);
+	if (!ret) {
+		tbl_len = ARRAY_SIZE(pac1711_vsense_range_tbl);
+		ret = pac1711_check_range(vals, pac1711_vsense_range_tbl, tbl_len);
+		if (ret < 0)
+			return dev_err_probe(dev, -EINVAL, "Invalid value %d, %d for prop %s\n",
+					     vals[0], vals[1], prop_name);
+
+		info->vsense_mode = ret;
+	}
+
+	return 0;
+}
+
+static bool pac1711_of_parse_channel_config(struct i2c_client *client,
+					    struct pac1711_chip_info *info)
+{
+	struct device *dev = &client->dev;
+	int ret, temp;
+
+	if (device_property_present(dev, "shunt-resistor-micro-ohms")) {
+		ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms", &info->shunt);
+		if (ret)
+			return dev_err_probe(dev, ret, "Write default shunt-resistor value %d\n",
+					     info->shunt);
+	} else {
+		return dev_err_probe(dev, ret, "shunt-resistor property does not exist\n");
+	}
+
+	if (device_property_present(dev, "label")) {
+		ret = device_property_read_string(dev, "label", (const char **)&info->label);
+		if (ret)
+			return dev_err_probe(dev, ret, "invalid rail-name value\n");
+	}
+
+	ret = pac1711_setup_vbus_range(info);
+	if (ret)
+		return ret;
+
+	ret = pac1711_setup_vsense_range(info);
+	if (ret)
+		return ret;
+
+	ret = device_property_read_u32(dev, "microchip,accumulation-mode", &temp);
+	if (ret)
+		return dev_err_probe(dev, ret, "invalid accumulation-mode value %d\n", temp);
+
+	if (temp == PAC1711_ACCMODE_VPOWER || temp == PAC1711_ACCMODE_VSENSE ||
+	    temp == PAC1711_ACCMODE_VBUS) {
+		dev_dbg(dev, "Accumulation mode set to: %d\n", temp);
+		info->accumulation_mode = temp;
+	} else {
+		return dev_err_probe(dev, -EINVAL, "invalid accumulation-mode value %d\n", temp);
+	}
+
+	return 0;
+}
+
+static void pac1711_cancel_delayed_work(void *dwork)
+{
+	cancel_delayed_work_sync(dwork);
+}
+
+static int pac1711_chip_configure(struct pac1711_chip_info *info)
+{
+	struct i2c_client *client = info->client;
+	struct device *dev = &client->dev;
+	u32 wait_time;
+	u16 tmp_u16;
+	int ret = 0;
+	u8 tmp_u8;
+
+	/* get sampling rate from PAC */
+	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
+					    sizeof(tmp_u16), (u8 *)&tmp_u16);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "cannot read 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
+
+	be16_to_cpus(&tmp_u16);
+	info->sampling_mode = FIELD_GET(PAC1711_CTRL_SAMPLE_MODE_MASK, tmp_u16);
+
+	/*
+	 * The current/voltage can be measured unidirectional, bidirectional or half FSR
+	 * no SLOW triggered REFRESH, clear POR
+	 */
+	tmp_u8 = FIELD_PREP(PAC1711_NEG_PWR_CFG_VS_MASK, info->vsense_mode) |
+		FIELD_PREP(PAC1711_NEG_PWR_CFG_VB_MASK, info->vbus_mode);
+
+	ret = i2c_smbus_write_byte_data(client, PAC1711_NEG_PWR_FSR_REG_ADDR, tmp_u8);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
+				     PAC1711_NEG_PWR_FSR_REG_ADDR);
+
+	tmp_u8 = 0;
+	ret = i2c_smbus_write_byte_data(client, PAC1711_SLOW_REG_ADDR, tmp_u8);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_SLOW_REG_ADDR);
+
+	tmp_u16 = 0;
+	cpu_to_be16s(&tmp_u16);
+
+	ret = i2c_smbus_write_word_data(client, PAC1711_CTRL_REG_ADDR, tmp_u16);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
+
+	/*
+	 * Sending a REFRESH to the chip, so the new settings take place
+	 * as well as resetting the accumulators
+	 */
+	ret = i2c_smbus_write_byte(client, PAC1711_REFRESH_REG_ADDR);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
+				     PAC1711_REFRESH_REG_ADDR);
+
+	usleep_range(125, 500);
+
+	/*
+	 * Get the current (in the chip) sampling speed and compute the
+	 * required timeout based on its value the timeout is 1/sampling_speed
+	 * wait the maximum amount of time to be on the safe side - the
+	 * maximum wait time is for 8sps
+	 */
+	wait_time = (1024 / pac1711_samp_rate_map_tbl[info->sampling_mode]) * 1000;
+	usleep_range(wait_time, wait_time + 100);
+
+	INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1711_work_periodic_rfsh);
+	/* Setup the latest moment for reading the regs before saturation */
+	schedule_delayed_work(&info->work_chip_rfsh,
+			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
+
+	return devm_add_action_or_reset(&client->dev, pac1711_cancel_delayed_work,
+					&info->work_chip_rfsh);
+}
+
+static struct iio_chan_spec pac1711_single_channel[] = {
+	PAC1711_VPOWER_CHANNEL(0, 0, PAC1711_VPOWER_ADDR),
+	PAC1711_VBUS_CHANNEL(0, 0, PAC1711_VBUS_ADDR),
+	PAC1711_VSENSE_CHANNEL(0, 0, PAC1711_VSENSE_ADDR),
+	PAC1711_VBUS_AVG_CHANNEL(0, 0, PAC1711_VBUS_AVG_ADDR),
+	PAC1711_VSENSE_AVG_CHANNEL(0, 0, PAC1711_VSENSE_AVG_ADDR),
+};
+
+static IIO_DEVICE_ATTR(in_energy_raw, 0444,
+		       pac1711_in_power_acc_raw_show, NULL, 0);
+
+static IIO_DEVICE_ATTR(in_energy_scale, 0444,
+		       pac1711_in_power_acc_scale_show, NULL, 0);
+
+static IIO_DEVICE_ATTR(in_energy_en, 0644,
+		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
+
+static IIO_DEVICE_ATTR(in_current_acc_raw, 0444,
+		       pac1711_in_current_acc_raw_show, NULL, 0);
+
+static IIO_DEVICE_ATTR(in_current_acc_scale, 0444,
+		       pac1711_in_current_acc_scale_show, NULL, 0);
+
+static IIO_DEVICE_ATTR(in_current_acc_en, 0644,
+		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
+
+static IIO_DEVICE_ATTR(in_voltage_acc_raw, 0444,
+		       pac1711_in_voltage_acc_raw_show, NULL, 0);
+
+static IIO_DEVICE_ATTR(in_voltage_acc_scale, 0444,
+		      pac1711_in_voltage_acc_scale_show, NULL, 0);
+
+static IIO_DEVICE_ATTR(in_voltage_acc_en, 0644,
+		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
+
+static struct attribute *pac1711_power_acc_attr[] = {
+	PAC1711_DEV_ATTR(in_energy_raw),
+	PAC1711_DEV_ATTR(in_energy_scale),
+	PAC1711_DEV_ATTR(in_energy_en),
+	NULL
+};
+
+static struct attribute *pac1711_current_acc_attr[] = {
+	PAC1711_DEV_ATTR(in_current_acc_raw),
+	PAC1711_DEV_ATTR(in_current_acc_scale),
+	PAC1711_DEV_ATTR(in_current_acc_en),
+	NULL
+};
+
+static struct attribute *pac1711_voltage_acc_attr[] = {
+	PAC1711_DEV_ATTR(in_voltage_acc_raw),
+	PAC1711_DEV_ATTR(in_voltage_acc_scale),
+	PAC1711_DEV_ATTR(in_voltage_acc_en),
+	NULL
+};
+
+static int pac1711_prep_custom_attributes(struct pac1711_chip_info *info,
+					  struct iio_dev *indio_dev)
+{
+	struct attribute **pac1711_custom_attrs, **tmp_attr;
+	struct device *dev = &info->client->dev;
+	struct attribute_group *pac1711_group;
+	int custom_attr_cnt, j, i;
+
+	pac1711_group = devm_kzalloc(dev, sizeof(*pac1711_group), GFP_KERNEL);
+	if (!pac1711_group)
+		return -ENOMEM;
+
+	custom_attr_cnt = PAC1711_COMMON_DEVATTR + PAC1711_ACC_DEVATTR;
+
+	pac1711_custom_attrs = devm_kzalloc(dev, custom_attr_cnt * sizeof(*pac1711_group) + 1,
+					    GFP_KERNEL);
+
+	if (!pac1711_custom_attrs)
+		return -ENOMEM;
+
+	j = 0;
+
+	for (i = 0; i < PAC1711_COMMON_DEVATTR; i++)
+		pac1711_custom_attrs[j++] = pac1711_all_attrs[i];
+
+	switch (info->accumulation_mode) {
+	case PAC1711_ACCMODE_VPOWER:
+		tmp_attr = pac1711_power_acc_attr;
+		break;
+	case PAC1711_ACCMODE_VSENSE:
+		tmp_attr = pac1711_current_acc_attr;
+		break;
+	case PAC1711_ACCMODE_VBUS:
+		tmp_attr = pac1711_voltage_acc_attr;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pac1711_custom_attrs[j++] = tmp_attr[0];
+	pac1711_custom_attrs[j++] = tmp_attr[1];
+	pac1711_custom_attrs[j++] = tmp_attr[2];
+
+	pac1711_group->attrs = pac1711_custom_attrs;
+	info->iio_info.attrs = pac1711_group;
+
+	return 0;
+}
+
+static const struct iio_info pac1711_info = {
+	.read_raw = pac1711_read_raw,
+	.write_raw = pac1711_write_raw,
+	.read_label = pac1711_read_label,
+};
+
+static int pac1711_probe(struct i2c_client *client)
+{
+	const struct pac1711_features *chip;
+	struct device *dev = &client->dev;
+	struct pac1711_chip_info *info;
+	struct iio_dev *indio_dev;
+	int ret, err;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	info->client = client;
+
+	ret = pac1711_chip_identify(indio_dev, info);
+	if (ret < 0) {
+		/*
+		 * If failed to identify the hardware based on internal
+		 * registers, try using fallback compatible in device tree
+		 * to deal with some newer part number.
+		 */
+		chip = i2c_get_match_data(client);
+		if (!chip)
+			return -EINVAL;
+
+		info->chip_variant = chip->prod_id;
+		indio_dev->name = chip->name;
+	}
+
+	/* always start with accumulation channels enabled */
+	info->enable_acc = true;
+	err = pac1711_of_parse_channel_config(client, info);
+	if (err)
+		return dev_err_probe(dev, err, "Error parsing devicetree data\n");
+
+	ret = devm_mutex_init(dev, &info->lock);
+	if (ret)
+		return ret;
+
+	/*
+	 * do now any chip specific initialization (e.g. read/write
+	 * some registers), enable/disable certain channels, change the sampling
+	 * rate to the requested value
+	 */
+	ret = pac1711_chip_configure(info);
+	if (ret < 0)
+		return ret;
+
+	/* prepare the channel information */
+	indio_dev->num_channels = ARRAY_SIZE(pac1711_single_channel);
+	indio_dev->channels = pac1711_single_channel;
+	info->iio_info = pac1711_info;
+	indio_dev->info = &info->iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = pac1711_prep_custom_attributes(info, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Can't configure custom attributes for PAC1711 device\n");
+
+	/*
+	 * read whatever has been accumulated in the chip so far
+	 * and reset the accumulators
+	 */
+	ret = pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
+				   PAC1711_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Can't register IIO device\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id pac1711_id[] = {
+	{ .name = "pac1711", .driver_data = (kernel_ulong_t)&pac1711_chip_features },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pac1711_id);
+
+static const struct of_device_id pac1711_of_match[] = {
+	{
+		.compatible = "microchip,pac1711",
+		.data = &pac1711_chip_features
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, pac1711_of_match);
+
+static struct i2c_driver pac1711_driver = {
+	.driver	 = {
+		.name = "pac1711",
+		.of_match_table = pac1711_of_match,
+	},
+	.probe = pac1711_probe,
+	.id_table = pac1711_id,
+};
+
+module_i2c_driver(pac1711_driver);
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for PAC1711 DC Power/Energy Monitor");
+MODULE_LICENSE("GPL");

-- 
2.43.0


