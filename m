Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060637D6E06
	for <lists+linux-iio@lfdr.de>; Wed, 25 Oct 2023 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjJYNoq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Oct 2023 09:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjJYNoo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Oct 2023 09:44:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA3132;
        Wed, 25 Oct 2023 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698241479; x=1729777479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/zP0aq68GhfjCkCBsSl+5vL7rlcZrEnA4UpqlX0u/M=;
  b=Uu6k8qd7VabQZr+/fC+2NiSqLg4YiniNcqjcoy9FvCDyz71nZ2e7cw/T
   llKg14L2Ngr/CgqlfcyGu+MFJoT+Riah2eEEdhe11bBnXq+qmDfghAo8L
   kaqIvJlUQ9itZ9NOeziORd498VeCTej6Curum89LqQgmixSYMneAh718M
   jo7vo8scaqqv3akx39qmWokR5UKbShrZMFLj9lyJie2h01O0EDYpQwrIe
   qlVz6J5IarDua5hbMzrR9OxWBVY59BrfG73swI4A4naFuF+1Yplvw3jsR
   30/EQTTUZJVpRmUmIbAdtew6zzcZ6MA/3nAKTnoDxnn3MlZ1HrKcPF92Q
   Q==;
X-CSE-ConnectionGUID: 0glr9WvsTTKB7/1tnc1ysA==
X-CSE-MsgGUID: YGPW9hpMTsaFezgCVzmy2Q==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="241332154"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 06:44:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 06:44:24 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 25 Oct 2023 06:44:21 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v2 2/2] iio: adc: adding support for pac193x
Date:   Wed, 25 Oct 2023 16:44:04 +0300
Message-ID: <20231025134404.131485-3-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025134404.131485-1-marius.cristea@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

This is the iio driver for Microchip
PAC193X series of Power Monitor with Accumulator chip family.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-pac1934     |   15 +
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/pac1934.c                     | 1775 +++++++++++++++++
 5 files changed, 1810 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
 create mode 100644 drivers/iio/adc/pac1934.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
new file mode 100644
index 000000000000..ea43df292b9c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
@@ -0,0 +1,15 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor_X
+KernelVersion:	6.6
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The value of the shunt resistor may be known only at runtime and set
+		by a client application. This attribute allows to set its value
+		in micro-ohms. X is the IIO index of the device. The value is
+		used to calculate current, power and accumulated energy.
+
+What:		/sys/bus/iio/devices/iio:deviceX/reset_accumulators
+KernelVersion:	6.6
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Writing any value resets the accumulated power device's statistics
+		for all enabled channels.
diff --git a/MAINTAINERS b/MAINTAINERS
index 337a4244ee30..c966551604a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14054,6 +14054,13 @@ F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 F:	drivers/nvmem/microchip-otpc.c
 F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 
+MICROCHIP PAC1934 POWER/ENERGY MONITOR DRIVER
+M:	Marius Cristea <marius.cristea@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
+F:	drivers/iio/adc/pac1934.c
+
 MICROCHIP PCI1XXXX GP DRIVER
 M:	Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
 M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 35f9867da12c..07faf793795d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -903,6 +903,18 @@ config NPCM_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called npcm_adc.
 
+config PAC1934
+	tristate "Microchip Technology PAC1934 driver"
+	depends on I2C
+	depends on IIO
+	help
+	  Say yes here to build support for Microchip Technology's PAC1931,
+	  PAC1932, PAC1933, PAC1934 Single/Multi-Channel Power Monitor with
+	  Accumulator.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pac1934.
+
 config PALMAS_GPADC
 	tristate "TI Palmas General Purpose ADC"
 	depends on MFD_PALMAS
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index bee11d442af4..bb066c827e78 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
 obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
+obj-$(CONFIG_PAC1934) += pac1934.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
new file mode 100644
index 000000000000..7bed0d9bde54
--- /dev/null
+++ b/drivers/iio/adc/pac1934.c
@@ -0,0 +1,1775 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for PAC1934 Multi-Channel DC Power/Energy Monitor
+ *
+ * Copyright (C) 2017-2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Bogdan Bolocan <bogdan.bolocan@microchip.com>
+ * Author: Victor Tudose
+ * Author: Marius Cristea <marius.cristea@microchip.com>
+ *
+ * Datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <asm/unaligned.h>
+
+/*
+ * maximum accumulation time should be (17 * 60 * 1000) around 17 minutes@1024 sps
+ * till PAC1934 accumulation registers starts to saturate
+ */
+#define PAC1934_MAX_RFSH_LIMIT_MS		60000
+/* 50msec is the timeout for validity of the cached registers */
+#define PAC1934_MIN_POLLING_TIME_MS		50
+/*
+ * 1000usec is the minimum wait time for normal conversions when sample
+ * rate doesn't change
+ */
+#define PAC1934_MIN_UPDATE_WAIT_TIME_US		1000
+
+/* 32000mV */
+#define PAC1934_VOLTAGE_MILLIVOLTS_MAX		32000
+/* voltage bits resolution when set for unsigned values */
+#define PAC1934_VOLTAGE_U_RES			16
+/* voltage bits resolution when set for signed values */
+#define PAC1934_VOLTAGE_S_RES			15
+/* voltage bits resolution when set for unsigned values */
+#define PAC1934_CURRENT_U_RES			16
+/* voltage bits resolution when set for signed values */
+#define PAC1934_CURRENT_S_RES			15
+
+/* power resolution is 28 bits when unsigned */
+#define PAC1934_POWER_U_RES			28
+/* power resolution is 27 bits when signed */
+#define PAC1934_POWER_S_RES			27
+
+/* energy accumulation is 48 bits long */
+#define PAC1934_ENERGY_U_RES			48
+
+#define PAC1934_ENERGY_S_RES			47
+
+/*
+ * max signed value that can be stored on 32 bits and 8 digits fractional value
+ * (2^31 - 1) * 10^8 + 99999999
+ */
+#define PAC_193X_MAX_POWER_ACC			214748364799999999LL
+/*
+ * min signed value that can be stored on 32 bits and 8 digits fractional value
+ * -(2^31) * 10^8 - 99999999
+ */
+#define PAC_193X_MIN_POWER_ACC			-214748364899999999LL
+
+#define PAC1934_MAX_NUM_CHANNELS		4
+#define PAC1934_CH_1				0
+#define PAC1934_CH_2				1
+#define PAC1934_CH_3				2
+#define PAC1934_CH_4				3
+#define PAC1934_MEAS_REG_LEN			76
+#define PAC1934_CTRL_REG_LEN			12
+
+#define PAC1934_DEFAULT_CHIP_SAMP_SPEED		1024
+
+/* I2C address map */
+#define PAC1934_REFRESH_REG_ADDR		0x00
+#define PAC1934_CTRL_REG_ADDR			0x01
+#define PAC1934_ACC_COUNT_REG_ADDR		0x02
+#define PAC1934_VPOWER_ACC_1_ADDR		0x03
+#define PAC1934_VPOWER_ACC_2_ADDR		0x04
+#define PAC1934_VPOWER_ACC_3_ADDR		0x05
+#define PAC1934_VPOWER_ACC_4_ADDR		0x06
+#define PAC1934_VBUS_1_ADDR			0x07
+#define PAC1934_VBUS_2_ADDR			0x08
+#define PAC1934_VBUS_3_ADDR			0x09
+#define PAC1934_VBUS_4_ADDR			0x0A
+#define PAC1934_VSENSE_1_ADDR			0x0B
+#define PAC1934_VSENSE_2_ADDR			0x0C
+#define PAC1934_VSENSE_3_ADDR			0x0D
+#define PAC1934_VSENSE_4_ADDR			0x0E
+#define PAC1934_VBUS_AVG_1_ADDR			0x0F
+#define PAC1934_VBUS_AVG_2_ADDR			0x10
+#define PAC1934_VBUS_AVG_3_ADDR			0x11
+#define PAC1934_VBUS_AVG_4_ADDR			0x12
+#define PAC1934_VSENSE_AVG_1_ADDR		0x13
+#define PAC1934_VSENSE_AVG_2_ADDR		0x14
+#define PAC1934_VSENSE_AVG_3_ADDR		0x15
+#define PAC1934_VSENSE_AVG_4_ADDR		0x16
+#define PAC1934_VPOWER_1_ADDR			0x17
+#define PAC1934_VPOWER_2_ADDR			0x18
+#define PAC1934_VPOWER_3_ADDR			0x19
+#define PAC1934_VPOWER_4_ADDR			0x1A
+#define PAC1934_REFRESH_V_REG_ADDR		0x1F
+#define PAC1934_CTRL_STAT_REGS_ADDR		0x1C
+#define PAC1934_PID_REG_ADDR			0xFD
+#define PAC1934_MID_REG_ADDR			0xFE
+#define PAC1934_RID_REG_ADDR			0xFF
+
+/* PRODUCT ID REGISTER + MANUFACTURER ID REGISTER + REVISION ID REGISTER */
+#define PAC1934_ID_REG_LEN			3
+#define PAC1934_PID_IDX				0
+#define PAC1934_MID_IDX				1
+#define PAC1934_RID_IDX				2
+
+#define PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS	1
+#define PAC1934_ACPI_GET_UOHMS_VALS		2
+#define PAC1934_ACPI_GET_BIPOLAR_SETTINGS	4
+#define PAC1934_ACPI_GET_SAMP			5
+
+#define PAC1934_SAMPLE_RATE_SHIFT		6
+
+/*
+ * these indexes are exactly describing the element order within a single
+ * PAC1934 phys channel IIO channel descriptor; see the static const struct
+ * iio_chan_spec pac1934_single_channel[] declaration
+ */
+#define IIO_EN					0
+#define IIO_POW					1
+#define IIO_VOLT				2
+#define IIO_CRT					3
+#define IIO_VOLTAVG				4
+#define IIO_CRTAVG				5
+
+#define PAC1934_VBUS_SENSE_REG_LEN		2
+#define PAC1934_ACC_REG_LEN			3
+#define PAC1934_VPOWER_REG_LEN			4
+#define PAC1934_VPOWER_ACC_REG_LEN		6
+#define PAC1934_MAX_REGISTER_LENGTH		6
+
+#define PAC1934_CUSTOM_ATTR_FOR_CHANNEL		1
+#define PAC1934_SHARED_DEVATTRS_COUNT		1
+
+/*
+ * relative offsets when using multi-byte reads/writes even though these
+ * bytes are read one after the other, they are not at adjacent memory
+ * locations within the I2C memory map. The chip can skip some addresses
+ */
+#define PAC1934_CHANNEL_DIS_REG_OFF		0
+#define PAC1934_NEG_PWR_REG_OFF			1
+
+/*
+ * when reading/writing multiple bytes from offset PAC1934_CHANNEL_DIS_REG_OFF,
+ * the chip jumps over the 0x1E (REFRESH_G) and 0x1F (REFRESH_V) offsets
+ */
+#define PAC1934_SLOW_REG_OFF			2
+#define PAC1934_CTRL_ACT_REG_OFF		3
+#define PAC1934_CHANNEL_DIS_ACT_REG_OFF		4
+#define PAC1934_NEG_PWR_ACT_REG_OFF		5
+#define PAC1934_CTRL_LAT_REG_OFF		6
+#define PAC1934_CHANNEL_DIS_LAT_REG_OFF		7
+#define PAC1934_NEG_PWR_LAT_REG_OFF		8
+#define PAC1934_PID_REG_OFF			9
+#define PAC1934_MID_REG_OFF			10
+#define PAC1934_REV_REG_OFF			11
+#define PAC1934_CTRL_STATUS_INFO_LEN		12
+
+#define PAC1934_MID				0x5D
+#define PAC1931_PID				0x58
+#define PAC1932_PID				0x59
+#define PAC1933_PID				0x5A
+#define PAC1934_PID				0x5B
+
+/* Scale constant = (10^3 * 3.2 * 10^9 / 2^28) for mili Watt-second */
+#define PAC1934_SCALE_CONSTANT			11921
+
+#define PAC1934_MAX_VPOWER_RSHIFTED_BY_28B	11921
+#define PAC1934_MAX_VSENSE_RSHIFTED_BY_16B	1525
+
+#define PAC1934_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
+
+#define PAC1934_CRTL_SAMPLE_RATE_MASK	GENMASK(7, 6)
+#define PAC1934_CHAN_SLEEP_MASK		BIT(5)
+#define PAC1934_CHAN_SLEEP_SET		BIT(5)
+#define PAC1934_CHAN_SINGLE_MASK	BIT(4)
+#define PAC1934_CHAN_SINGLE_SHOT_SET	BIT(4)
+#define PAC1934_CHAN_ALERT_MASK		BIT(3)
+#define PAC1934_CHAN_ALERT_EN		BIT(3)
+#define PAC1934_CHAN_ALERT_CC_MASK	BIT(2)
+#define PAC1934_CHAN_ALERT_CC_EN	BIT(2)
+#define PAC1934_CHAN_OVF_ALERT_MASK	BIT(1)
+#define PAC1934_CHAN_OVF_ALERT_EN	BIT(1)
+#define PAC1934_CHAN_OVF_MASK		BIT(0)
+
+#define PAC1934_CHAN_DIS_CH1_OFF_MASK	BIT(7)
+#define PAC1934_CHAN_DIS_CH2_OFF_MASK	BIT(6)
+#define PAC1934_CHAN_DIS_CH3_OFF_MASK	BIT(5)
+#define PAC1934_CHAN_DIS_CH4_OFF_MASK	BIT(4)
+#define PAC1934_SMBUS_TIMEOUT_MASK	BIT(3)
+#define PAC1934_SMBUS_BYTECOUNT_MASK	BIT(2)
+#define PAC1934_SMBUS_NO_SKIP_MASK	BIT(1)
+
+#define PAC1934_NEG_PWR_CH1_BIDI_MASK	BIT(7)
+#define PAC1934_NEG_PWR_CH2_BIDI_MASK	BIT(6)
+#define PAC1934_NEG_PWR_CH3_BIDI_MASK	BIT(5)
+#define PAC1934_NEG_PWR_CH4_BIDI_MASK	BIT(4)
+#define PAC1934_NEG_PWR_CH1_BIDV_MASK	BIT(3)
+#define PAC1934_NEG_PWR_CH2_BIDV_MASK	BIT(2)
+#define PAC1934_NEG_PWR_CH3_BIDV_MASK	BIT(1)
+#define PAC1934_NEG_PWR_CH4_BIDV_MASK	BIT(0)
+
+/*
+ * Universal Unique Identifier (UUID),
+ * 033771E0-1705-47B4-9535-D1BBE14D9A09, is
+ * reserved to Microchip for the PAC1934 and must not be changed
+ */
+#define PAC1934_DSM_UUID		"033771E0-1705-47B4-9535-D1BBE14D9A09"
+
+enum pac1934_ids {
+	PAC1931,
+	PAC1932,
+	PAC1933,
+	PAC1934
+};
+
+enum pac1934_samps {
+	PAC1934_SAMP_1024SPS,
+	PAC1934_SAMP_256SPS,
+	PAC1934_SAMP_64SPS,
+	PAC1934_SAMP_8SPS
+};
+
+/**
+ * struct pac1934_features - features of a pac1934 instance
+ * @phys_channels:	number of physical channels supported by the chip
+ */
+struct pac1934_features {
+	u8 phys_channels;
+};
+
+struct samp_rate_mapping {
+	u16 samp_rate;
+	u8 shift2value;
+};
+
+static const unsigned int samp_rate_map_tbl[] = {
+	[PAC1934_SAMP_1024SPS] = 1024,
+	[PAC1934_SAMP_256SPS] = 256,
+	[PAC1934_SAMP_64SPS] = 64,
+	[PAC1934_SAMP_8SPS] = 8,
+};
+
+static const struct pac1934_features pac1934_chip_config[] = {
+	[PAC1931] = {
+	    .phys_channels = 1,
+	},
+	[PAC1932] = {
+	    .phys_channels = 2,
+	},
+	[PAC1933] = {
+	    .phys_channels = 3,
+	},
+	[PAC1934] = {
+	    .phys_channels = 4,
+	},
+};
+
+/**
+ * struct reg_data - data from the registers
+ * @meas_regs:			snapshot of raw measurements registers
+ * @ctrl_regs:			snapshot of control registers
+ * @energy_sec_acc:		snapshot of energy values
+ * @vpower_acc:			accumulated vpower values
+ * @vpower:			snapshot of vpower registers
+ * @vbus:			snapshot of vbus registers
+ * @vbus_avg:			averages of vbus registers
+ * @vsense:			snapshot of vsense registers
+ * @vsense_avg:			averages of vsense registers
+ * @num_enabled_channels:	count of how many chip channels are currently enabled
+ */
+struct reg_data {
+	u8	meas_regs[PAC1934_MEAS_REG_LEN];
+	u8	ctrl_regs[PAC1934_CTRL_REG_LEN];
+	s64	energy_sec_acc[PAC1934_MAX_NUM_CHANNELS];
+	s64	vpower_acc[PAC1934_MAX_NUM_CHANNELS];
+	s32	vpower[PAC1934_MAX_NUM_CHANNELS];
+	s32	vbus[PAC1934_MAX_NUM_CHANNELS];
+	s32	vbus_avg[PAC1934_MAX_NUM_CHANNELS];
+	s32	vsense[PAC1934_MAX_NUM_CHANNELS];
+	s32	vsense_avg[PAC1934_MAX_NUM_CHANNELS];
+	u8	num_enabled_channels;
+};
+
+/**
+ * struct pac1934_chip_info - information about the chip
+ * @client:			the i2c-client attached to the device
+ * @lock:			lock used by the chip's mutex
+ * @work_chip_rfsh:		work queue used for refresh commands
+ * @phys_channels:		phys channels count
+ * @active_channels:		array of values, true means that channel is active
+ * @bi_dir:			array of bools, true means that channel is bidirectional
+ * @chip_variant:		chip variant
+ * @chip_revision:		chip revision
+ * @shunts:			shunts
+ * @chip_reg_data:		chip reg data
+ * @sample_rate_value:		sampling frequency
+ * @labels:			table with channels labels
+ * @pac1934_info:		pac1934_info
+ * @crt_samp_spd_bitfield:	the current sampling speed
+ * @jiffies_tstamp:		chip's uptime
+ */
+struct pac1934_chip_info {
+	struct i2c_client	*client;
+	struct mutex		lock; /* lock to prevent concurrent reads/writes */
+	struct delayed_work	work_chip_rfsh;
+	u8			phys_channels;
+	bool			active_channels[PAC1934_MAX_NUM_CHANNELS];
+	bool			bi_dir[PAC1934_MAX_NUM_CHANNELS];
+	u8			chip_variant;
+	u8			chip_revision;
+	u32			shunts[PAC1934_MAX_NUM_CHANNELS];
+	struct reg_data		chip_reg_data;
+	s32			sample_rate_value;
+	char			*labels[PAC1934_MAX_NUM_CHANNELS];
+	struct iio_info		pac1934_info;
+	u8			crt_samp_spd_bitfield;
+	unsigned long		jiffies_tstamp;
+};
+
+#define TO_PAC1934_CHIP_INFO(d) container_of(d, struct pac1934_chip_info, work_chip_rfsh)
+
+/* macros to extract the parameters */
+#define PAC1934_MVBUS_SENSES(x)		sign_extend32((u32)(x), 15)
+
+#define PAC1934_VPOWER_ACC_CHANNEL(_index, _si, _address) {			\
+	.type = IIO_ENERGY,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|			\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = (_si),							\
+	.scan_type = {								\
+		.sign = 'u',							\
+		.realbits = PAC1934_ENERGY_U_RES,				\
+		.storagebits = PAC1934_ENERGY_U_RES,				\
+		.endianness = IIO_CPU,						\
+	}									\
+}
+
+#define PAC1934_VBUS_CHANNEL(_index, _si, _address) {				\
+	.type = IIO_VOLTAGE,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|			\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = (_si),							\
+	.scan_type = {								\
+		.sign = 'u',							\
+		.realbits = PAC1934_VOLTAGE_U_RES,				\
+		.storagebits = PAC1934_VOLTAGE_U_RES,				\
+		.endianness = IIO_CPU,						\
+	}									\
+}
+
+#define PAC1934_VBUS_AVG_CHANNEL(_index, _si, _address) {			\
+	.type = IIO_VOLTAGE,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_AVERAGE_RAW)	|		\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = (_si),							\
+	.scan_type = {								\
+		.sign = 'u',							\
+		.realbits = PAC1934_VOLTAGE_U_RES,				\
+		.storagebits = PAC1934_VOLTAGE_U_RES,				\
+		.endianness = IIO_CPU,						\
+	}									\
+}
+
+#define PAC1934_VSENSE_CHANNEL(_index, _si, _address) {				\
+	.type = IIO_CURRENT,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|			\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = (_si),							\
+	.scan_type = {								\
+		.sign = 'u',							\
+		.realbits = PAC1934_CURRENT_U_RES,				\
+		.storagebits = PAC1934_CURRENT_U_RES,				\
+		.endianness = IIO_CPU,						\
+	}									\
+}
+
+#define PAC1934_VSENSE_AVG_CHANNEL(_index, _si, _address) {			\
+	.type = IIO_CURRENT,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_AVERAGE_RAW)	|		\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = (_si),							\
+	.scan_type = {								\
+		.sign = 'u',							\
+		.realbits = PAC1934_CURRENT_U_RES,				\
+		.storagebits = PAC1934_CURRENT_U_RES,				\
+		.endianness = IIO_CPU,						\
+	}									\
+}
+
+#define PAC1934_VPOWER_CHANNEL(_index, _si, _address) {				\
+	.type = IIO_POWER,							\
+	.address = (_address),							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|			\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = (_si),							\
+	.scan_type = {								\
+		.sign = 'u',							\
+		.realbits = PAC1934_POWER_U_RES,				\
+		.storagebits = 32,						\
+		.shift = 4,							\
+		.endianness = IIO_CPU,						\
+	}									\
+}
+
+static const struct iio_chan_spec pac1934_single_channel[] = {
+	PAC1934_VPOWER_ACC_CHANNEL(0, 0, PAC1934_VPOWER_ACC_1_ADDR),
+	PAC1934_VPOWER_CHANNEL(0, 0, PAC1934_VPOWER_1_ADDR),
+	PAC1934_VBUS_CHANNEL(0, 0, PAC1934_VBUS_1_ADDR),
+	PAC1934_VSENSE_CHANNEL(0, 0, PAC1934_VSENSE_1_ADDR),
+	PAC1934_VBUS_AVG_CHANNEL(0, 0, PAC1934_VBUS_AVG_1_ADDR),
+	PAC1934_VSENSE_AVG_CHANNEL(0, 0, PAC1934_VSENSE_AVG_1_ADDR),
+};
+
+/* Low-level I2c functions */
+static int pac1934_i2c_read(struct i2c_client *client, u8 reg_addr, void *databuf, u8 len)
+{
+	int ret;
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
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int pac1934_i2c_write(struct i2c_client *client, u8 reg_addr, u8 *data, int len)
+{
+	int ret;
+	u8 send[PAC1934_MAX_REGISTER_LENGTH + 1];
+
+	send[0] = reg_addr;
+	memcpy(&send[1], data, len * sizeof(u8));
+
+	ret = i2c_master_send(client, send, len + 1);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"failed writing data from register 0x%02X\n", reg_addr);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pac1934_match_samp_rate(struct pac1934_chip_info *info, u32 new_samp_rate)
+{
+	int cnt;
+
+	for (cnt = 0; cnt < ARRAY_SIZE(samp_rate_map_tbl); cnt++) {
+		if (new_samp_rate == samp_rate_map_tbl[cnt]) {
+			info->crt_samp_spd_bitfield = cnt;
+			return 0;
+		}
+	}
+
+	/* not a valid sample rate value */
+	return -EINVAL;
+}
+
+static ssize_t shunt_value_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1934_chip_info *info = iio_priv(indio_dev);
+	int len = 0;
+	int target = (int)(attr->attr.name[strlen(attr->attr.name) - 1] - '0') - 1;
+
+	len += sprintf(buf, "%u\n", info->shunts[target]);
+
+	return len;
+}
+
+static ssize_t shunt_value_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1934_chip_info *info = iio_priv(indio_dev);
+	int sh_val, target;
+
+	target = (int)(attr->attr.name[strlen(attr->attr.name) - 1] - '0') - 1;
+	if (kstrtouint(buf, 10, &sh_val)) {
+		dev_err(dev, "Shunt value is not valid\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&info->lock);
+	info->shunts[target] = sh_val;
+	mutex_unlock(&info->lock);
+
+	return count;
+}
+
+static int pac1934_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *channel,
+			      const int **vals, int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = samp_rate_map_tbl;
+		*length = ARRAY_SIZE(samp_rate_map_tbl);
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
+static int pac1934_send_refresh(struct pac1934_chip_info *info,
+				u8 refresh_cmd, u32 wait_time)
+{
+	/* this function only sends REFRESH or REFRESH_V */
+	struct i2c_client *client = info->client;
+	int ret;
+	u8 bidir_reg;
+	bool revision_bug = false;
+
+	if (info->chip_revision == 2 || info->chip_revision == 3) {
+		/*
+		 * chip rev 2 and 3 bug workaround
+		 * see: PAC1934 Family Data Sheet Errata DS80000836A.pdf
+		 */
+		revision_bug = true;
+
+		bidir_reg =
+			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDI_MASK, info->bi_dir[PAC1934_CH_1]) |
+			FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDI_MASK, info->bi_dir[PAC1934_CH_2]) |
+			FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDI_MASK, info->bi_dir[PAC1934_CH_3]) |
+			FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDI_MASK, info->bi_dir[PAC1934_CH_4]) |
+			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDV_MASK, info->bi_dir[PAC1934_CH_1]) |
+			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDV_MASK, info->bi_dir[PAC1934_CH_1]) |
+			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDV_MASK, info->bi_dir[PAC1934_CH_1]) |
+			FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDV_MASK, info->bi_dir[PAC1934_CH_1]);
+
+		ret = i2c_smbus_write_byte_data(client,
+						PAC1934_CTRL_STAT_REGS_ADDR +
+						PAC1934_NEG_PWR_REG_OFF,
+						bidir_reg);
+		if (ret)
+			return ret;
+	}
+
+	ret = i2c_smbus_write_byte(client, refresh_cmd);
+	if (ret) {
+		dev_err(&client->dev, "%s - cannot send 0x%02X\n",
+			__func__, refresh_cmd);
+		return ret;
+	}
+
+	if (revision_bug) {
+		/*
+		 * chip rev 2 and 3 bug workaround - write again the same register
+		 * write the updated registers back
+		 */
+		ret = i2c_smbus_write_byte_data(client,
+						PAC1934_CTRL_STAT_REGS_ADDR +
+						PAC1934_NEG_PWR_REG_OFF, bidir_reg);
+		if (ret)
+			return ret;
+	}
+
+	/* register data retrieval timestamp */
+	info->jiffies_tstamp = jiffies;
+
+	/* wait till the data is available */
+	usleep_range(wait_time, wait_time + 100);
+
+	return ret;
+}
+
+static int pac1934_reg_snapshot(struct pac1934_chip_info *info,
+				bool do_refresh, u8 refresh_cmd, u32 wait_time)
+{
+	int ret;
+	struct i2c_client *client = info->client;
+	u8 samp_shift, ctrl_regs_tmp;
+	u8 *offset_reg_data_p;
+	u16 tmp_value;
+	u32 samp_rate, cnt, tmp;
+	s64 curr_energy, inc;
+	u64 tmp_energy;
+	struct reg_data *reg_data;
+
+	mutex_lock(&info->lock);
+
+	if (do_refresh) {
+		ret = pac1934_send_refresh(info, refresh_cmd, wait_time);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"%s - cannot send refresh\n",
+				__func__);
+			goto reg_snapshot_err;
+		}
+	}
+
+	/* read the ctrl/status registers for this snapshot */
+	ret = pac1934_i2c_read(client, PAC1934_CTRL_STAT_REGS_ADDR,
+			       (u8 *)info->chip_reg_data.ctrl_regs,
+			       PAC1934_CTRL_REG_LEN);
+	if (ret) {
+		dev_err(&client->dev,
+			"%s - cannot read ctrl/status registers\n",
+			__func__);
+		goto reg_snapshot_err;
+	}
+
+	reg_data = &info->chip_reg_data;
+
+	/* read the data registers */
+	ret = pac1934_i2c_read(client, PAC1934_ACC_COUNT_REG_ADDR,
+			       (u8 *)reg_data->meas_regs, PAC1934_MEAS_REG_LEN);
+	if (ret) {
+		dev_err(&client->dev,
+			"%s - cannot read ACC_COUNT register: %d:%d\n",
+			__func__, ret, PAC1934_MEAS_REG_LEN);
+		goto reg_snapshot_err;
+	}
+
+	/* see how much shift is required by the sample rate */
+	samp_rate = samp_rate_map_tbl[((reg_data->ctrl_regs[PAC1934_CTRL_LAT_REG_OFF]) >> 6)];
+	samp_shift = get_count_order(samp_rate);
+
+	ctrl_regs_tmp = reg_data->ctrl_regs[PAC1934_CHANNEL_DIS_LAT_REG_OFF];
+	offset_reg_data_p = &reg_data->meas_regs[PAC1934_ACC_REG_LEN];
+
+	/* start with VPOWER_ACC */
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		/* check if the channel is active, skip all fields if disabled */
+		if (((ctrl_regs_tmp << cnt) & 0x80) == 0) {
+			curr_energy = info->chip_reg_data.energy_sec_acc[cnt];
+
+			tmp_energy = get_unaligned_be48(offset_reg_data_p);
+
+			if (info->bi_dir[cnt])
+				reg_data->vpower_acc[cnt] = sign_extend64(tmp_energy, 47);
+			else
+				reg_data->vpower_acc[cnt] = tmp_energy;
+
+			/*
+			 * compute the scaled to 1 second accumulated energy value;
+			 * energy accumulator scaled to 1sec = VPOWER_ACC/2^samp_shift
+			 * the chip's sampling rate is 2^samp_shift samples/sec
+			 */
+			inc = (reg_data->vpower_acc[cnt] >> samp_shift);
+
+			/* add the power_acc field */
+			curr_energy += inc;
+
+			/* check if we have reached the upper/lower limit */
+			if (curr_energy > (s64)PAC_193X_MAX_POWER_ACC)
+				curr_energy = PAC_193X_MAX_POWER_ACC;
+			else if (curr_energy < ((s64)PAC_193X_MIN_POWER_ACC))
+				curr_energy = PAC_193X_MIN_POWER_ACC;
+
+			reg_data->energy_sec_acc[cnt] = curr_energy;
+
+			offset_reg_data_p += PAC1934_VPOWER_ACC_REG_LEN;
+		}
+	}
+
+	/* continue with VBUS */
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (((ctrl_regs_tmp << cnt) & 0x80) == 0) {
+			tmp_value = get_unaligned_be16(offset_reg_data_p);
+
+			if (info->bi_dir[cnt])
+				reg_data->vbus[cnt] = PAC1934_MVBUS_SENSES(tmp_value);
+			else
+				reg_data->vbus[cnt] = tmp_value;
+
+			offset_reg_data_p += PAC1934_VBUS_SENSE_REG_LEN;
+		}
+	}
+
+	/* VSENSE */
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (((ctrl_regs_tmp << cnt) & 0x80) == 0) {
+			tmp_value = get_unaligned_be16(offset_reg_data_p);
+
+			if (info->bi_dir[cnt])
+				reg_data->vsense[cnt] = PAC1934_MVBUS_SENSES(tmp_value);
+			else
+				reg_data->vsense[cnt] = tmp_value;
+
+			offset_reg_data_p += PAC1934_VBUS_SENSE_REG_LEN;
+		}
+	}
+
+	/* VBUS_AVG */
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (((ctrl_regs_tmp << cnt) & 0x80) == 0) {
+			tmp_value = get_unaligned_be16(offset_reg_data_p);
+
+			if (info->bi_dir[cnt])
+				reg_data->vbus_avg[cnt] = PAC1934_MVBUS_SENSES(tmp_value);
+			else
+				reg_data->vbus_avg[cnt] = tmp_value;
+
+			offset_reg_data_p += PAC1934_VBUS_SENSE_REG_LEN;
+		}
+	}
+
+	/* VSENSE_AVG */
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (((ctrl_regs_tmp << cnt) & 0x80) == 0) {
+			tmp_value = get_unaligned_be16(offset_reg_data_p);
+
+			if (info->bi_dir[cnt])
+				reg_data->vsense_avg[cnt] = PAC1934_MVBUS_SENSES(tmp_value);
+			else
+				reg_data->vsense_avg[cnt] = tmp_value;
+
+			offset_reg_data_p += PAC1934_VBUS_SENSE_REG_LEN;
+		}
+	}
+
+	/* VPOWER */
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (((ctrl_regs_tmp << cnt) & 0x80) == 0) {
+			tmp = get_unaligned_be32(offset_reg_data_p) >> 4;
+
+			if (info->bi_dir[cnt])
+				reg_data->vpower[cnt] = sign_extend32(tmp, 27);
+			else
+				reg_data->vpower[cnt] = tmp;
+
+			offset_reg_data_p += PAC1934_VPOWER_REG_LEN;
+		}
+	}
+
+reg_snapshot_err:
+	mutex_unlock(&info->lock);
+
+	return ret;
+}
+
+static int pac1934_retrieve_data(struct pac1934_chip_info *info,
+				 u32 wait_time)
+{
+	int ret = 0;
+
+	/*
+	 * check if the minimal elapsed time has passed and if so,
+	 * re-read the chip, otherwise the cached info is just fine
+	 */
+	if (time_after(jiffies, info->jiffies_tstamp +
+					 msecs_to_jiffies(PAC1934_MIN_POLLING_TIME_MS))) {
+		ret = pac1934_reg_snapshot(info, true, PAC1934_REFRESH_REG_ADDR,
+					   wait_time);
+
+		/*
+		 * Re-schedule the work for the read registers on timeout
+		 * (to prevent chip regs saturation)
+		 */
+		cancel_delayed_work_sync(&info->work_chip_rfsh);
+		schedule_delayed_work(&info->work_chip_rfsh,
+				      msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
+	}
+
+	return ret;
+}
+
+static int pac1934_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct pac1934_chip_info *info = iio_priv(indio_dev);
+	s64 curr_energy;
+	int ret, channel = chan->channel - 1;
+
+	ret = pac1934_retrieve_data(info, PAC1934_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			switch (chan->address) {
+			case PAC1934_VBUS_1_ADDR:
+			case PAC1934_VBUS_2_ADDR:
+			case PAC1934_VBUS_3_ADDR:
+			case PAC1934_VBUS_4_ADDR:
+				*val = info->chip_reg_data.vbus[channel];
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_CURRENT:
+			switch (chan->address) {
+			case PAC1934_VSENSE_1_ADDR:
+			case PAC1934_VSENSE_2_ADDR:
+			case PAC1934_VSENSE_3_ADDR:
+			case PAC1934_VSENSE_4_ADDR:
+				*val = info->chip_reg_data.vsense[channel];
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_POWER:
+			switch (chan->address) {
+			case PAC1934_VPOWER_1_ADDR:
+			case PAC1934_VPOWER_2_ADDR:
+			case PAC1934_VPOWER_3_ADDR:
+			case PAC1934_VPOWER_4_ADDR:
+				*val = info->chip_reg_data.vpower[channel];
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_ENERGY:
+			switch (chan->address) {
+			case PAC1934_VPOWER_ACC_1_ADDR:
+			case PAC1934_VPOWER_ACC_2_ADDR:
+			case PAC1934_VPOWER_ACC_3_ADDR:
+			case PAC1934_VPOWER_ACC_4_ADDR:
+				curr_energy = info->chip_reg_data.energy_sec_acc[channel];
+				*val = (u32)curr_energy;
+				*val2 = (u32)(curr_energy >> 32);
+				return IIO_VAL_INT_64;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_AVERAGE_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			switch (chan->address) {
+			case PAC1934_VBUS_AVG_1_ADDR:
+			case PAC1934_VBUS_AVG_2_ADDR:
+			case PAC1934_VBUS_AVG_3_ADDR:
+			case PAC1934_VBUS_AVG_4_ADDR:
+				*val = info->chip_reg_data.vbus_avg[channel];
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_CURRENT:
+			switch (chan->address) {
+			case PAC1934_VSENSE_AVG_1_ADDR:
+			case PAC1934_VSENSE_AVG_2_ADDR:
+			case PAC1934_VSENSE_AVG_3_ADDR:
+			case PAC1934_VSENSE_AVG_4_ADDR:
+				*val = info->chip_reg_data.vsense_avg[channel];
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->address) {
+		/* Voltages - scale for millivolts */
+		case PAC1934_VBUS_1_ADDR:
+		case PAC1934_VBUS_2_ADDR:
+		case PAC1934_VBUS_3_ADDR:
+		case PAC1934_VBUS_4_ADDR:
+		case PAC1934_VBUS_AVG_1_ADDR:
+		case PAC1934_VBUS_AVG_2_ADDR:
+		case PAC1934_VBUS_AVG_3_ADDR:
+		case PAC1934_VBUS_AVG_4_ADDR:
+			*val = PAC1934_VOLTAGE_MILLIVOLTS_MAX;
+			if (chan->scan_type.sign == 'u')
+				*val2 = PAC1934_VOLTAGE_U_RES;
+			else
+				*val2 = PAC1934_VOLTAGE_S_RES;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		/*
+		 * Currents - scale for mA - depends on the
+		 * channel's shunt value
+		 * (100mV * 1000000) / (2^16 * shunt(uohm))
+		 */
+		case PAC1934_VSENSE_1_ADDR:
+		case PAC1934_VSENSE_2_ADDR:
+		case PAC1934_VSENSE_3_ADDR:
+		case PAC1934_VSENSE_4_ADDR:
+		case PAC1934_VSENSE_AVG_1_ADDR:
+		case PAC1934_VSENSE_AVG_2_ADDR:
+		case PAC1934_VSENSE_AVG_3_ADDR:
+		case PAC1934_VSENSE_AVG_4_ADDR:
+			*val = PAC1934_MAX_VSENSE_RSHIFTED_BY_16B;
+			if (chan->scan_type.sign == 'u')
+				*val2 = info->shunts[channel];
+			else
+				*val2 = info->shunts[channel] >> 1;
+			return IIO_VAL_FRACTIONAL;
+		/*
+		 * Power - uW - it will use the combined scale
+		 * for current and voltage
+		 * current(mA) * voltage(mV) = power (uW)
+		 */
+		case PAC1934_VPOWER_1_ADDR:
+		case PAC1934_VPOWER_2_ADDR:
+		case PAC1934_VPOWER_3_ADDR:
+		case PAC1934_VPOWER_4_ADDR:
+			*val = PAC1934_MAX_VPOWER_RSHIFTED_BY_28B;
+			if (chan->scan_type.sign == 'u')
+				*val2 = info->shunts[channel];
+			else
+				*val2 = info->shunts[channel] >> 1;
+			return IIO_VAL_FRACTIONAL;
+		case PAC1934_VPOWER_ACC_1_ADDR:
+		case PAC1934_VPOWER_ACC_2_ADDR:
+		case PAC1934_VPOWER_ACC_3_ADDR:
+		case PAC1934_VPOWER_ACC_4_ADDR:
+			/*
+			 * expresses the 32 bit scale value
+			 * here compute the scale for energy (mili Watt-second or miliJoule)
+			 */
+			*val = PAC1934_SCALE_CONSTANT;
+
+			if (chan->scan_type.sign == 'u')
+				*val2 = info->shunts[channel];
+			else
+				*val2 = info->shunts[channel] >> 1;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = info->sample_rate_value;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int pac1934_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct pac1934_chip_info *info = iio_priv(indio_dev);
+	struct i2c_client *client = info->client;
+	int ret = -EINVAL;
+	s32 old_samp_rate;
+	u8 ctrl_reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = pac1934_match_samp_rate(info, val);
+		if (ret)
+			return ret;
+
+		old_samp_rate = info->sample_rate_value;
+		info->sample_rate_value = val;
+
+		/* write the new sampling value and trigger a snapshot(incl refresh) */
+		mutex_lock(&info->lock);
+
+		ctrl_reg = FIELD_PREP(PAC1934_CRTL_SAMPLE_RATE_MASK, info->crt_samp_spd_bitfield);
+		ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_REG_ADDR, ctrl_reg);
+		if (ret) {
+			dev_err(&client->dev, "%s - can't update sample rate\n", __func__);
+			info->sample_rate_value = old_samp_rate;
+			mutex_unlock(&info->lock);
+			return ret;
+		}
+
+		mutex_unlock(&info->lock);
+
+		/*
+		 * now, force a snapshot with refresh - call retrieve
+		 * data in order to update the refresh timer
+		 * alter the timestamp in order to force trigger a
+		 * register snapshot and a timestamp update
+		 */
+		info->jiffies_tstamp -=
+			msecs_to_jiffies(PAC1934_MIN_POLLING_TIME_MS);
+		ret = pac1934_retrieve_data(info, (1024 / old_samp_rate) * 1000);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"%s - cannot snapshot ctrl and measurement regs\n",
+				__func__);
+			return ret;
+		}
+
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int pac1934_read_label(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, char *label)
+{
+	struct pac1934_chip_info *info = iio_priv(indio_dev);
+
+	switch (chan->address) {
+	case PAC1934_VBUS_1_ADDR:
+	case PAC1934_VBUS_2_ADDR:
+	case PAC1934_VBUS_3_ADDR:
+	case PAC1934_VBUS_4_ADDR:
+		return sprintf(label, "%s_VBUS_%d\n",
+			       info->labels[chan->scan_index],
+			       chan->scan_index + 1);
+	case PAC1934_VBUS_AVG_1_ADDR:
+	case PAC1934_VBUS_AVG_2_ADDR:
+	case PAC1934_VBUS_AVG_3_ADDR:
+	case PAC1934_VBUS_AVG_4_ADDR:
+		return sprintf(label, "%s_VBUS_AVG_%d\n",
+			       info->labels[chan->scan_index],
+			       chan->scan_index + 1);
+	case PAC1934_VSENSE_1_ADDR:
+	case PAC1934_VSENSE_2_ADDR:
+	case PAC1934_VSENSE_3_ADDR:
+	case PAC1934_VSENSE_4_ADDR:
+		return sprintf(label, "%s_IBUS_%d\n",
+			       info->labels[chan->scan_index],
+			       chan->scan_index + 1);
+	case PAC1934_VSENSE_AVG_1_ADDR:
+	case PAC1934_VSENSE_AVG_2_ADDR:
+	case PAC1934_VSENSE_AVG_3_ADDR:
+	case PAC1934_VSENSE_AVG_4_ADDR:
+		return sprintf(label, "%s_IBUS_AVG_%d\n",
+			       info->labels[chan->scan_index],
+			       chan->scan_index + 1);
+	case PAC1934_VPOWER_1_ADDR:
+	case PAC1934_VPOWER_2_ADDR:
+	case PAC1934_VPOWER_3_ADDR:
+	case PAC1934_VPOWER_4_ADDR:
+		return sprintf(label, "%s_POWER_%d\n",
+			       info->labels[chan->scan_index],
+			       chan->scan_index + 1);
+	case PAC1934_VPOWER_ACC_1_ADDR:
+	case PAC1934_VPOWER_ACC_2_ADDR:
+	case PAC1934_VPOWER_ACC_3_ADDR:
+	case PAC1934_VPOWER_ACC_4_ADDR:
+		return sprintf(label, "%s_ENERGY_%d\n",
+			       info->labels[chan->scan_index],
+			       chan->scan_index + 1);
+	}
+
+	return 0;
+}
+
+static void pac1934_work_periodic_rfsh(struct work_struct *work)
+{
+	struct pac1934_chip_info *info = TO_PAC1934_CHIP_INFO((struct delayed_work *)work);
+	struct i2c_client *client = info->client;
+
+	dev_dbg(&client->dev, "%s - Periodic refresh\n", __func__);
+
+	/* do a REFRESH, then read */
+	pac1934_reg_snapshot(info, true, PAC1934_REFRESH_REG_ADDR,
+			     PAC1934_MIN_UPDATE_WAIT_TIME_US);
+
+	schedule_delayed_work(&info->work_chip_rfsh,
+			      msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
+}
+
+static int pac1934_read_revision(struct pac1934_chip_info *info, u8 *buf)
+{
+	int ret;
+	struct i2c_client *client = info->client;
+
+	ret = pac1934_i2c_read(client, PAC1934_PID_REG_ADDR, buf, PAC1934_ID_REG_LEN);
+	if (ret) {
+		dev_err(&client->dev, "cannot read revision\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pac1934_chip_identify(struct pac1934_chip_info *info)
+{
+	u8 rev_info[PAC1934_ID_REG_LEN];
+	struct i2c_client *client = info->client;
+	int ret = 0;
+
+	ret = pac1934_read_revision(info, (u8 *)rev_info);
+	if (!ret) {
+		info->chip_variant = rev_info[PAC1934_PID_IDX];
+		info->chip_revision = rev_info[PAC1934_RID_IDX];
+
+		dev_dbg(&client->dev, "Chip variant: 0x%02X\n", info->chip_variant);
+		dev_dbg(&client->dev, "Chip revision: 0x%02X\n", info->chip_revision);
+
+		switch (info->chip_variant) {
+		case PAC1934_PID:
+			info->phys_channels = pac1934_chip_config[PAC1934].phys_channels;
+			break;
+		case PAC1933_PID:
+			info->phys_channels = pac1934_chip_config[PAC1933].phys_channels;
+			break;
+		case PAC1932_PID:
+			info->phys_channels = pac1934_chip_config[PAC1932].phys_channels;
+			break;
+		case PAC1931_PID:
+			info->phys_channels = pac1934_chip_config[PAC1931].phys_channels;
+			break;
+		default:
+			info->phys_channels = 0;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * documentation related to the ACPI device definition
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
+ */
+static const char *pac1934_match_acpi_device(struct i2c_client *client,
+					     struct pac1934_chip_info *info)
+{
+	const char *name;
+	acpi_handle handle;
+	union acpi_object *rez;
+	struct device *dev = &client->dev;
+	unsigned short bi_dir_mask;
+	int idx, i;
+	guid_t guid;
+	const struct acpi_device_id *id;
+
+	handle = ACPI_HANDLE(&client->dev);
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!id)
+		return NULL;
+
+	name = dev_name(dev);
+	if (!name)
+		return NULL;
+
+	guid_parse(PAC1934_DSM_UUID, &guid);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
+	if (!rez)
+		return NULL;
+
+	for (i = 0; i < rez->package.count; i += 2) {
+		idx = i / 2;
+		info->labels[idx] =
+			devm_kmemdup(&client->dev, rez->package.elements[i].string.pointer,
+				     (size_t)rez->package.elements[i].string.length + 1,
+				     GFP_KERNEL);
+		info->labels[idx][rez->package.elements[i].string.length] = '\0';
+		info->shunts[idx] =
+			rez->package.elements[i + 1].integer.value * 1000;
+		info->active_channels[idx] = (info->shunts[idx] != 0);
+	}
+
+	kfree(rez);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_UOHMS_VALS, NULL);
+	if (!rez) {
+		/*
+		 * initializing with default values
+		 * we assume all channels are unidirectional(the mask is zero)
+		 * and assign the default sampling rate
+		 */
+		info->sample_rate_value = PAC1934_DEFAULT_CHIP_SAMP_SPEED;
+		return name;
+	}
+
+	for (i = 0; i < rez->package.count; i++) {
+		idx = i;
+		info->shunts[idx] = rez->package.elements[i].integer.value;
+		info->active_channels[idx] = (info->shunts[idx] != 0);
+	}
+
+	kfree(rez);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_BIPOLAR_SETTINGS, NULL);
+	if (!rez)
+		return NULL;
+
+	bi_dir_mask = rez->package.elements[0].integer.value;
+	info->bi_dir[0] = ((bi_dir_mask & (1 << 3)) | (bi_dir_mask & (1 << 7))) != 0;
+	info->bi_dir[1] = ((bi_dir_mask & (1 << 2)) | (bi_dir_mask & (1 << 6))) != 0;
+	info->bi_dir[2] = ((bi_dir_mask & (1 << 1)) | (bi_dir_mask & (1 << 5))) != 0;
+	info->bi_dir[3] = ((bi_dir_mask & (1 << 0)) | (bi_dir_mask & (1 << 4))) != 0;
+
+	kfree(rez);
+
+	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_SAMP, NULL);
+	if (!rez)
+		return NULL;
+
+	info->sample_rate_value = rez->package.elements[0].integer.value;
+
+	kfree(rez);
+
+	return name;
+}
+
+static const char *pac1934_match_of_device(struct i2c_client *client,
+					   struct pac1934_chip_info *info)
+{
+	struct fwnode_handle *node, *fwnode;
+	unsigned int current_channel;
+	const struct pac1934_features *chip;
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const char *name;
+	int idx, ret;
+
+	name = id->name;
+
+	if (!info->phys_channels) {
+		/*
+		 * If failed to identify the hardware based on internal registers,
+		 * try using fallback compatible in device tree to deal with some newer part number.
+		 */
+		chip = device_get_match_data(&client->dev);
+		if (!chip)
+			chip = (struct pac1934_features *)id->driver_data;
+
+		if (!chip) {
+			dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
+			return NULL;
+		}
+
+		info->phys_channels = chip->phys_channels;
+	}
+
+	info->sample_rate_value = 1024;
+	current_channel = 1;
+
+	fwnode = dev_fwnode(&client->dev);
+	fwnode_for_each_available_child_node(fwnode, node) {
+		ret = fwnode_property_read_u32(node, "reg", &idx);
+		if (ret) {
+			dev_err_probe(&client->dev, ret,
+				      "reading invalid channel index\n");
+			fwnode_handle_put(node);
+			return NULL;
+		}
+		/* adjust idx to match channel index (1 to 4) from the datasheet */
+		idx--;
+
+		if (current_channel >= (info->phys_channels + 1) ||
+		    idx >= info->phys_channels || idx < 0) {
+			dev_err_probe(&client->dev, -EINVAL,
+				      "%s: invalid channel_index %d value\n",
+				      fwnode_get_name(node), idx);
+			fwnode_handle_put(node);
+			return NULL;
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
+			fwnode_handle_put(node);
+			return NULL;
+		}
+
+		ret = fwnode_property_read_string(node, "label",
+						  (const char **)&info->labels[idx]);
+		if (ret) {
+			dev_err_probe(&client->dev, ret,
+				      "%s: invalid rail-name value\n",
+				      fwnode_get_name(node));
+			fwnode_handle_put(node);
+			return NULL;
+		}
+
+		info->bi_dir[idx] = fwnode_property_read_bool(node, "bipolar");
+
+		current_channel++;
+	}
+
+	return name;
+}
+
+static int pac1934_chip_configure(struct pac1934_chip_info *info)
+{
+	int cnt, ret;
+	struct i2c_client *client = info->client;
+	u8 regs[PAC1934_CTRL_STATUS_INFO_LEN], idx, ctrl_reg;
+	u32 wait_time;
+
+	cnt = 0;
+	info->chip_reg_data.num_enabled_channels = 0;
+	while (cnt < info->phys_channels) {
+		if (info->active_channels[cnt])
+			info->chip_reg_data.num_enabled_channels++;
+		cnt++;
+	}
+
+	/*
+	 * read whatever information was gathered before the driver was loaded
+	 * establish which channels are enabled/disabled and then establish the
+	 * information retrieval mode (using SKIP or no).
+	 * Read the chip ID values
+	 */
+	ret = pac1934_i2c_read(client, PAC1934_CTRL_STAT_REGS_ADDR,
+			       (u8 *)regs, sizeof(regs));
+	if (ret) {
+		dev_err_probe(&client->dev, ret,
+			      "%s - cannot read regs from 0x%02X\n",
+			      __func__, PAC1934_CTRL_STAT_REGS_ADDR);
+		return ret;
+	}
+
+	/* write the CHANNEL_DIS and the NEG_PWR registers */
+	regs[PAC1934_CHANNEL_DIS_REG_OFF] =
+		FIELD_PREP(PAC1934_CHAN_DIS_CH1_OFF_MASK, !(info->active_channels[PAC1934_CH_1])) |
+		FIELD_PREP(PAC1934_CHAN_DIS_CH2_OFF_MASK, !(info->active_channels[PAC1934_CH_2])) |
+		FIELD_PREP(PAC1934_CHAN_DIS_CH3_OFF_MASK, !(info->active_channels[PAC1934_CH_3])) |
+		FIELD_PREP(PAC1934_CHAN_DIS_CH4_OFF_MASK, !(info->active_channels[PAC1934_CH_4])) |
+		FIELD_PREP(PAC1934_SMBUS_TIMEOUT_MASK, 0) |
+		FIELD_PREP(PAC1934_SMBUS_BYTECOUNT_MASK, 0) |
+		FIELD_PREP(PAC1934_SMBUS_NO_SKIP_MASK, 0);
+
+	regs[PAC1934_NEG_PWR_REG_OFF] =
+		FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDI_MASK, info->bi_dir[PAC1934_CH_1]) |
+		FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDI_MASK, info->bi_dir[PAC1934_CH_2]) |
+		FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDI_MASK, info->bi_dir[PAC1934_CH_3]) |
+		FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDI_MASK, info->bi_dir[PAC1934_CH_4]) |
+		FIELD_PREP(PAC1934_NEG_PWR_CH1_BIDV_MASK, info->bi_dir[PAC1934_CH_1]) |
+		FIELD_PREP(PAC1934_NEG_PWR_CH2_BIDV_MASK, info->bi_dir[PAC1934_CH_2]) |
+		FIELD_PREP(PAC1934_NEG_PWR_CH3_BIDV_MASK, info->bi_dir[PAC1934_CH_3]) |
+		FIELD_PREP(PAC1934_NEG_PWR_CH4_BIDV_MASK, info->bi_dir[PAC1934_CH_4]);
+
+	/* no SLOW triggered REFRESH, clear POR */
+	regs[PAC1934_SLOW_REG_OFF] = 0;
+
+	ret = pac1934_i2c_write(client, PAC1934_CTRL_STAT_REGS_ADDR, (u8 *)regs, 3);
+	if (ret)
+		return ret;
+
+	ctrl_reg = FIELD_PREP(PAC1934_CRTL_SAMPLE_RATE_MASK, info->crt_samp_spd_bitfield);
+
+	ret = i2c_smbus_write_byte_data(client, PAC1934_CTRL_REG_ADDR, ctrl_reg);
+	if (ret)
+		return ret;
+
+	/*
+	 * send a REFRESH to the chip, so the new settings take place
+	 * as well as resetting the accumulators
+	 */
+	ret = i2c_smbus_write_byte(client, PAC1934_REFRESH_REG_ADDR);
+	if (ret) {
+		dev_err(&client->dev,
+			"%s - cannot send 0x%02X\n",
+			__func__, PAC1934_REFRESH_REG_ADDR);
+		return ret;
+	}
+
+	/*
+	 * get the current(in the chip) sampling speed and compute the
+	 * required timeout based on its value
+	 * the timeout is 1/sampling_speed
+	 */
+	idx = regs[PAC1934_CTRL_ACT_REG_OFF] >> PAC1934_SAMPLE_RATE_SHIFT;
+	wait_time = (1024 / samp_rate_map_tbl[idx]) * 1000;
+
+	/*
+	 * wait the maximum amount of time to be on the safe side
+	 * the maximum wait time is for 8sps
+	 */
+	usleep_range(wait_time, wait_time + 100);
+
+	INIT_DELAYED_WORK(&info->work_chip_rfsh, pac1934_work_periodic_rfsh);
+	/* Setup the latest moment for reading the regs before saturation */
+	schedule_delayed_work(&info->work_chip_rfsh,
+			      msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
+
+	return 0;
+}
+
+static int pac1934_prep_iio_channels(struct pac1934_chip_info *info, struct iio_dev *indio_dev)
+{
+	struct i2c_client *client;
+	struct iio_chan_spec *ch_sp;
+	int channel_size, attribute_count, cnt;
+	void *dyn_ch_struct, *tmp_data;
+
+	client = info->client;
+
+	/* find out dynamically how many IIO channels we need */
+	attribute_count = 0;
+	channel_size = 0;
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (info->active_channels[cnt]) {
+			/* add the size of the properties of one chip physical channel */
+			channel_size += sizeof(pac1934_single_channel);
+			/* count how many enabled channels we have */
+			attribute_count += ARRAY_SIZE(pac1934_single_channel);
+			dev_info(&client->dev, ":%s: Channel %d active\n", __func__, cnt + 1);
+		}
+	}
+
+	dyn_ch_struct = kzalloc(channel_size, GFP_KERNEL);
+	if (!dyn_ch_struct)
+		return -EINVAL;
+
+	tmp_data = dyn_ch_struct;
+
+	/* populate the dynamic channels and make all the adjustments */
+	for (cnt = 0; cnt < info->phys_channels; cnt++) {
+		if (info->active_channels[cnt]) {
+			memcpy(tmp_data, pac1934_single_channel, sizeof(pac1934_single_channel));
+			ch_sp = (struct iio_chan_spec *)tmp_data;
+			ch_sp[IIO_EN].channel = cnt + 1;
+			ch_sp[IIO_EN].scan_index = cnt;
+			ch_sp[IIO_EN].address = cnt + PAC1934_VPOWER_ACC_1_ADDR;
+			ch_sp[IIO_POW].channel = cnt + 1;
+			ch_sp[IIO_POW].scan_index = cnt;
+			ch_sp[IIO_POW].address = cnt + PAC1934_VPOWER_1_ADDR;
+			ch_sp[IIO_VOLT].channel = cnt + 1;
+			ch_sp[IIO_VOLT].scan_index = cnt;
+			ch_sp[IIO_VOLT].address = cnt + PAC1934_VBUS_1_ADDR;
+			ch_sp[IIO_CRT].channel = cnt + 1;
+			ch_sp[IIO_CRT].scan_index = cnt;
+			ch_sp[IIO_CRT].address = cnt + PAC1934_VSENSE_1_ADDR;
+			ch_sp[IIO_VOLTAVG].channel = cnt + 5;
+			ch_sp[IIO_VOLTAVG].scan_index = cnt;
+			ch_sp[IIO_VOLTAVG].address = cnt + PAC1934_VBUS_AVG_1_ADDR;
+			ch_sp[IIO_CRTAVG].channel = cnt + 5;
+			ch_sp[IIO_CRTAVG].scan_index = cnt;
+			ch_sp[IIO_CRTAVG].address = cnt + PAC1934_VSENSE_AVG_1_ADDR;
+
+			/*
+			 * now modify the parameters in all channels if the
+			 * whole chip rail(channel) is bi-directional
+			 */
+			if (info->bi_dir[cnt]) {
+				ch_sp[IIO_EN].scan_type.sign = 's';
+				ch_sp[IIO_EN].scan_type.realbits = PAC1934_ENERGY_S_RES;
+				ch_sp[IIO_POW].scan_type.sign = 's';
+				ch_sp[IIO_POW].scan_type.realbits = PAC1934_POWER_S_RES;
+				ch_sp[IIO_VOLT].scan_type.sign = 's';
+				ch_sp[IIO_VOLT].scan_type.realbits = PAC1934_VOLTAGE_S_RES;
+				ch_sp[IIO_CRT].scan_type.sign = 's';
+				ch_sp[IIO_CRT].scan_type.realbits = PAC1934_CURRENT_S_RES;
+				ch_sp[IIO_VOLTAVG].scan_type.sign = 's';
+				ch_sp[IIO_VOLTAVG].scan_type.realbits = PAC1934_VOLTAGE_S_RES;
+				ch_sp[IIO_CRTAVG].scan_type.sign = 's';
+				ch_sp[IIO_CRTAVG].scan_type.realbits = PAC1934_CURRENT_S_RES;
+			}
+			tmp_data += sizeof(pac1934_single_channel);
+		}
+	}
+
+	/*
+	 * send the updated dynamic channel structure information towards IIO
+	 * prepare the required field for IIO class registration
+	 */
+	indio_dev->num_channels = attribute_count;
+	indio_dev->channels = devm_kmemdup(&client->dev,
+					   (const struct iio_chan_spec *)dyn_ch_struct,
+					   channel_size, GFP_KERNEL);
+
+	kfree(dyn_ch_struct);
+
+	if (!indio_dev->channels)
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t reset_accumulators_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct pac1934_chip_info *info = iio_priv(indio_dev);
+	int ret, i;
+	u8 refresh_cmd = PAC1934_REFRESH_REG_ADDR;
+
+	ret = i2c_smbus_write_byte(info->client, refresh_cmd);
+	if (ret) {
+		dev_err(&indio_dev->dev,
+			"%s - cannot send 0x%02X\n",
+			__func__, refresh_cmd);
+	}
+
+	for (i = 0 ; i < info->phys_channels; i++)
+		info->chip_reg_data.energy_sec_acc[i] = 0;
+
+	return count;
+}
+
+static IIO_DEVICE_ATTR(in_shunt_resistor_1, 0644, shunt_value_show, shunt_value_store, 0);
+static IIO_DEVICE_ATTR(in_shunt_resistor_2, 0644, shunt_value_show, shunt_value_store, 0);
+static IIO_DEVICE_ATTR(in_shunt_resistor_3, 0644, shunt_value_show, shunt_value_store, 0);
+static IIO_DEVICE_ATTR(in_shunt_resistor_4, 0644, shunt_value_show, shunt_value_store, 0);
+static IIO_DEVICE_ATTR(reset_accumulators, 0200, NULL, reset_accumulators_store, 0);
+
+static struct attribute *pac1934_all_attributes[] = {
+	PAC1934_DEV_ATTR(in_shunt_resistor_1),
+	PAC1934_DEV_ATTR(in_shunt_resistor_2),
+	PAC1934_DEV_ATTR(in_shunt_resistor_3),
+	PAC1934_DEV_ATTR(in_shunt_resistor_4),
+	PAC1934_DEV_ATTR(reset_accumulators),
+	NULL
+};
+
+static int pac1934_prep_custom_attributes(struct pac1934_chip_info *info,
+					  struct iio_dev *indio_dev)
+{
+	int i, j, active_channels_count = 0;
+	struct attribute **pac1934_custom_attributes;
+	struct attribute_group *pac1934_group;
+	struct i2c_client *client = info->client;
+
+	for (i = 0 ; i < info->phys_channels; i++)
+		if (info->active_channels[i])
+			active_channels_count++;
+
+	pac1934_group = devm_kzalloc(&client->dev, sizeof(*pac1934_group), GFP_KERNEL);
+
+	pac1934_custom_attributes = devm_kzalloc(&client->dev,
+						 (PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
+						 active_channels_count +
+						 PAC1934_SHARED_DEVATTRS_COUNT)
+						 * sizeof(*pac1934_group) + 1,
+						 GFP_KERNEL);
+	j = 0;
+
+	for (i = 0 ; i < info->phys_channels; i++) {
+		if (info->active_channels[i]) {
+			pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * j] =
+			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * i];
+			pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * j + 1] =
+			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL * i + 1];
+			j++;
+		}
+	}
+
+	for (i = 0; i < PAC1934_SHARED_DEVATTRS_COUNT; i++)
+		pac1934_custom_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
+			active_channels_count + i] =
+			pac1934_all_attributes[PAC1934_CUSTOM_ATTR_FOR_CHANNEL *
+			info->phys_channels + i];
+
+	pac1934_group->attrs = pac1934_custom_attributes;
+	info->pac1934_info.attrs = pac1934_group;
+
+	return 0;
+}
+
+static void pac1934_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(&client->dev);
+	struct pac1934_chip_info *info = iio_priv(indio_dev);
+
+	cancel_delayed_work_sync(&info->work_chip_rfsh);
+}
+
+static int pac1934_probe(struct i2c_client *client)
+{
+	struct pac1934_chip_info *info;
+	struct iio_dev *indio_dev;
+	const char *name = NULL;
+	int cnt, ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+
+	i2c_set_clientdata(client, indio_dev);
+	info->client = client;
+
+	/*
+	 * load default settings - all channels disabled,
+	 * uni directional flow
+	 */
+	for (cnt = 0; cnt < PAC1934_MAX_NUM_CHANNELS; cnt++) {
+		info->active_channels[cnt] = false;
+		info->bi_dir[cnt] = false;
+	}
+
+	info->crt_samp_spd_bitfield = PAC1934_SAMP_1024SPS;
+
+	ret = pac1934_chip_identify(info);
+	if (ret)
+		return -EINVAL;
+
+	if (ACPI_HANDLE(&client->dev)) {
+		if (!info->phys_channels)
+			/* failed to identify part number, unknown number of channels available */
+			return -EINVAL;
+
+		name = pac1934_match_acpi_device(client, info);
+	} else {
+		name = pac1934_match_of_device(client, info);
+	}
+
+	if (!name) {
+		dev_dbg(&client->dev, "parameter parsing returned an error\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&info->lock);
+
+	/*
+	 * do now any chip specific initialization (e.g. read/write
+	 * some registers), enable/disable certain channels, change the sampling
+	 * rate to the requested value
+	 */
+	ret = pac1934_chip_configure(info);
+	if (ret < 0)
+		goto fail;
+
+	/* prepare the channel information */
+	ret = pac1934_prep_iio_channels(info, indio_dev);
+	if (ret < 0)
+		goto fail;
+
+	ret = pac1934_prep_custom_attributes(info, indio_dev);
+	if (ret < 0) {
+		dev_err_probe(&indio_dev->dev, ret,
+			      "Can't configure custom attributes for PAC1934 device\n");
+		goto fail;
+	}
+
+	info->pac1934_info.read_raw = pac1934_read_raw;
+	info->pac1934_info.read_avail = pac1934_read_avail;
+	info->pac1934_info.write_raw = pac1934_write_raw;
+	info->pac1934_info.read_label = pac1934_read_label;
+
+	indio_dev->info = &info->pac1934_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/*
+	 * read whatever has been accumulated in the chip so far
+	 * and reset the accumulators
+	 */
+	ret = pac1934_reg_snapshot(info, true, PAC1934_REFRESH_REG_ADDR,
+				   PAC1934_MIN_UPDATE_WAIT_TIME_US);
+	if (ret < 0)
+		goto fail;
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret < 0) {
+		dev_err_probe(&indio_dev->dev, ret,
+			      "Can't register IIO device\n");
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	cancel_delayed_work_sync(&info->work_chip_rfsh);
+
+	return ret;
+}
+
+static const struct i2c_device_id pac1934_id[] = {
+	{ .name = "pac1931", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1931] },
+	{ .name = "pac1932", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1932] },
+	{ .name = "pac1933", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1933] },
+	{ .name = "pac1934", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pac1934_id);
+
+static const struct of_device_id pac1934_of_match[] = {
+	{
+		.compatible = "microchip,pac1931",
+		.data = &pac1934_chip_config[PAC1931]
+	},
+	{
+		.compatible = "microchip,pac1932",
+		.data = &pac1934_chip_config[PAC1932]
+	},
+	{
+		.compatible = "microchip,pac1933",
+		.data = &pac1934_chip_config[PAC1933]
+	},
+	{
+		.compatible = "microchip,pac1934",
+		.data = &pac1934_chip_config[PAC1934]
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, pac1934_of_match);
+
+/* using MCHP1930 to be compatible with WINDOWS ACPI */
+static const struct acpi_device_id pac1934_acpi_match[] = {
+	{"MCHP1930", 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(acpi, pac1934_acpi_match);
+
+static struct i2c_driver pac1934_driver = {
+	.driver	 = {
+		.name = "pac1934",
+		.of_match_table = pac1934_of_match,
+		.acpi_match_table = ACPI_PTR(pac1934_acpi_match)
+		},
+	.probe_new = pac1934_probe,
+	.remove = pac1934_remove,
+	.id_table = pac1934_id,
+};
+
+module_i2c_driver(pac1934_driver);
+
+MODULE_AUTHOR("Bogdan Bolocan <bogdan.bolocan@microchip.com>");
+MODULE_AUTHOR("Victor Tudose");
+MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for PAC1934 Multi-Channel DC Power/Energy Monitor");
+MODULE_LICENSE("GPL");
-- 
2.34.1

