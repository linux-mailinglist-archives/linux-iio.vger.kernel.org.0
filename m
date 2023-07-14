Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E999A753E4D
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jul 2023 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbjGNPBr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jul 2023 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjGNPBp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jul 2023 11:01:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145E35B5;
        Fri, 14 Jul 2023 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689346888; x=1720882888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CN1Fy8aXuXEpCoWtlgV6/TFJM3DkTmBgB1Jm2U+opNg=;
  b=SCJHT4Fle3CIq4fFe1HQcwiP80QzgOXsberviXhiE+UdtYAbrwNPxq8O
   5ianO3cpVB+XrqtMS7kEvutsnrF0WpBcj64TzLG0p4avbHcTd+T3DBZSw
   dLsZ+hQ+A1FHH+RBXqgpNmupltWC0eJTzwHA88RyAr97Q9ImlYncj9SHx
   SpNMw6lzM6Ljy3qFrwI66q3Ixyi6eccpCeWgLNSD5clBSRjPilYqjIf6a
   nj/70fkmy0pMPrrX6vVV8CSXGRLX33KzrRC3jjeasHob5ROvedqJyKLeJ
   t4UtPODMMKLxOWFVefsKM+WwOLi08VXJQgFNn1RzgRWljDhFQ7Def1Y5s
   g==;
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="161388996"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jul 2023 08:01:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 14 Jul 2023 08:01:24 -0700
Received: from marius-VM.mshome.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 14 Jul 2023 08:01:22 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v2 2/2] iio: adc: adding support for MCP3564 ADC
Date:   Fri, 14 Jul 2023 18:00:51 +0300
Message-ID: <20230714150051.637952-3-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714150051.637952-1-marius.cristea@microchip.com>
References: <20230714150051.637952-1-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

This is the iio driver for Microchip family of 153.6 ksps,
Low-Noise 16/24-Bit Delta-Sigma ADCs with an SPI interface
(Microchip's  MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
MCP3562R and MCP3564R analog to digital converters).

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-mcp3564     |   53 +
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/mcp3564.c                     | 1485 +++++++++++++++++
 5 files changed, 1559 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
 create mode 100644 drivers/iio/adc/mcp3564.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564 b/Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
new file mode 100644
index 000000000000..50393258be70
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-mcp3564
@@ -0,0 +1,53 @@
+What:		/sys/bus/iio/devices/iio:deviceX/boost_current
+KernelVersion:	6.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to set the biasing circuit of the
+		Delta-Sigma modulator. The different BOOST settings are applied
+		to the entire modulator circuit, including the voltage reference
+		buffers.
+
+What:		/sys/bus/iio/devices/iio:deviceX/boost_current_available
+KernelVersion:	6.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a list with the possible values for
+		the current biasing circuit of the Delta-Sigma modulator.
+
+What:		/sys/bus/iio/devices/iio:deviceX/enable_auto_zeroing_mux
+KernelVersion:	6.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to enable the analog input multiplexer
+		auto-zeroing algorithm (the input multiplexer and the ADC
+		include an offset cancellation algorithm that cancels the offset
+		contribution of the ADC). When the offset cancellation algorithm
+		is enabled, ADC takes two conversions, one with the differential
+		input as VIN+/VIN-, one with VIN+/VIN- inverted. In this case the
+		conversion time is multiplied by two compared to the default
+		case where the algorithm is disabled. This technique allows the
+		cancellation of the ADC offset error and the achievement of
+		ultra-low offset without any digital calibration. The resulting
+		offset is the residue of the difference between the two
+		conversions, which is on the order of magnitude of the noise
+		floor. This offset is effectively canceled at every conversion,
+		so the residual offset error temperature drift is extremely low.
+		Write '1' to enable it, write '0' to disable it.
+
+What:		/sys/bus/iio/devices/iio:deviceX/enable_auto_zeroing_ref
+KernelVersion:	6.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is used to enable the chopping algorithm for the 
+		internal voltage reference buffer. This setting has no effect
+		when external voltage reference is selected.
+		Internal voltage reference buffer injects a certain quantity of
+		1/f noise into the system that can be modulated with the
+		incoming input signals and can limit the SNR performance at
+		higher Oversampling Ratio values (over 256). To overcome this
+		limitation, the buffer includes an auto-zeroing algorithm that
+		greatly reduces (cancels out) the 1/f noise and cancels the
+		offset value of the reference buffer. As a result, the SNR of
+		the system is not affected by this 1/f noise component of the
+		reference buffer, even at maximum oversampling ratio values.
+		Write '1' to enable it, write '0' to disable it.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6969a2962ffe..50c879f85e1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13798,6 +13798,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
 F:	drivers/regulator/mcp16502.c
 
+MICROCHIP MCP3564 ADC DRIVER
+M:      Marius Cristea <marius.cristea@microchip.com>
+L:      linux-iio@vger.kernel.org
+S:      Supported
+F:      Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
+F:      drivers/iio/adc/mcp3564.c
+
 MICROCHIP MCP3911 ADC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 M:	Kent Gustavsson <kent@minoris.se>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 53098aca06ea..782bf5eec8ed 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -768,6 +768,19 @@ config MCP3422
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp3422.
 
+config MCP3564
+        tristate "Microchip Technology MCP3461/2/4/R, MCP3561/2/4/R driver"
+        depends on SPI
+        depends on IIO
+        help
+          Say yes here to build support for Microchip Technology's MCP3461,
+          MCP3462, MCP3464, MCP3461R, MCP3462R, MCP3464R, MCP3561, MCP3562,
+          MCP3564, MCP3561R, MCP3562R and MCP3564R analog to digital
+          converters.
+
+          This driver can also be built as a module. If so, the module will be
+          called mcp3564.
+
 config MCP3911
 	tristate "Microchip Technology MCP3911 driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index e07e4a3e6237..91f713af574f 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
+obj-$(CONFIG_MCP3564) += mcp3564.o
 obj-$(CONFIG_MCP3911) += mcp3911.o
 obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
 obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
new file mode 100644
index 000000000000..42828abb3db1
--- /dev/null
+++ b/drivers/iio/adc/mcp3564.c
@@ -0,0 +1,1485 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for MCP356X/MCP356XR and MCP346X/MCP346XR series ADC chip family
+ *
+ * Copyright (C) 2022-2023 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Marius Cristea <marius.cristea@microchip.com>
+ *
+ * Datasheet for MCP3561, MCP3562, MCP3564 can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP3561-2-4-Family-Data-Sheet-DS20006181C.pdf
+ * Datasheet for MCP3561R, MCP3562R, MCP3564R can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3561_2_4R-Data-Sheet-DS200006391C.pdf
+ * Datasheet for MCP3461, MCP3462, MCP3464 can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3461-2-4-Two-Four-Eight-Channel-153.6-ksps-Low-Noise-16-Bit-Delta-Sigma-ADC-Data-Sheet-20006180D.pdf
+ * Datasheet for MCP3461R, MCP3462R, MCP3464R can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3461-2-4R-Family-Data-Sheet-DS20006404C.pdf
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+#include <linux/util_macros.h>
+#include <asm/unaligned.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define MCP3564_ADCDATA		0x00
+#define MCP3564_CONFIG0		0x01
+#define MCP3564_CONFIG1		0x02
+#define MCP3564_CONFIG2		0x03
+#define MCP3564_CONFIG3		0x04
+#define MCP3564_IRQ		0x05
+#define MCP3564_MUX		0x06
+#define MCP3564_SCAN		0x07
+#define MCP3564_TIMER		0x08
+#define MCP3564_OFFSETCAL	0x09
+#define MCP3564_GAINCAL		0x0A
+#define MCP3564_RESERVED_B	0x0B
+#define MCP3564_RESERVED_C	0x0C
+#define MCP3564_LOCK		0x0D
+#define MCP3564_RESERVED_E	0x0E
+#define MCP3564_CRCCFG		0x0F
+
+#define MCP3564_CMD_HW_ADDR_MASK	GENMASK(7, 6)
+#define MCP3564_CMD_HW_ADDR_SET(x)	((u8)FIELD_PREP(MCP3564_CMD_HW_ADDR_MASK, (x)))
+#define MCP3564_CMD_ADDR_MASK		GENMASK(5, 2)
+#define MCP3564_CMD_ADDR_SET(x)		((u8)FIELD_PREP(MCP3564_CMD_ADDR_MASK, (x)))
+
+#define MCP3564_FASTCMD_START	0x0A
+#define MCP3564_FASTCMD_RESET	0x0E
+
+#define MCP3461_HW_ID		0x0008
+#define MCP3462_HW_ID		0x0009
+#define MCP3464_HW_ID		0x000B
+
+#define MCP3561_HW_ID		0x000C
+#define MCP3562_HW_ID		0x000D
+#define MCP3564_HW_ID		0x000F
+#define MCP3564_HW_ID_MASK	GENMASK(3, 0)
+
+#define MCP3564_REG_C_DEFAULT	0x50
+#define MCP3564R_REG_C_DEFAULT	0x30
+
+#define MCP3564R_INT_VREF_MV	2400
+
+/* MUX_VIN Input Selection */
+#define MCP3564_CH0		0
+#define MCP3564_CH1		1
+#define MCP3564_CH2		2
+#define MCP3564_CH3		3
+#define MCP3564_CH4		4
+#define MCP3564_CH5		5
+#define MCP3564_CH6		6
+#define MCP3564_CH7		7
+#define MCP3564_AGND		8
+#define MCP3564_AVDD		9
+#define MCP3564_RESERVED	10 /* do not use */
+#define MCP3564_REFIN_POZ	11
+#define MCP3564_REFIN_NEG	12
+#define MCP3564_TEMP_DIODE_P	13
+#define MCP3564_TEMP_DIODE_M	14
+#define MCP3564_INTERNAL_VCM	15
+
+/* CONFIG 0 Register */
+#define MCP3564_ADC_MODE_DEFAULT		0x00
+#define MCP3564_ADC_MODE_SHUTDOWN		0x01
+#define MCP3564_ADC_MODE_STANDBY		0x02
+#define MCP3564_ADC_MODE_CONVERSION		0x03
+#define MCP3564_ADC_MODE_MASK			GENMASK(1, 0)
+#define MCP3564_ADC_MODE_MASK_SET(x)		((u8)FIELD_PREP(MCP3564_ADC_MODE_MASK, (x)))
+
+#define MCP3564_CS_SEL_MASK			GENMASK(3, 2)
+#define MCP3564_CS_SEL_SET(x)			((u8)FIELD_PREP(MCP3564_CS_SEL_MASK, (x)))
+
+/*
+ * 0b11 = Internal clock is selected and AMCLK is present on the analog master clock output pin.
+ * 0b10 = Internal clock is selected and no clock output is present on the CLK pin.
+ * 0b01 = External digital clock
+ * 0b00 = External digital clock (default)
+ */
+#define MCP3564_USE_INTERNAL_CLK_OUTPUT_EN	0x03
+#define MCP3564_USE_INTERNAL_CLK		0x02
+#define MCP3564_USE_EXTERNAL_CLK		0x01
+#define MCP3564_USE_EXTERNAL_CLK_DEFAULT	0x00
+#define MCP3564_CLK_SEL_MASK			GENMASK(5, 4)
+#define MCP3564_CLK_SEL_SET(x)			((u8)FIELD_PREP(MCP3564_CLK_SEL_MASK, (x)))
+
+#define MCP3456_CONFIG0_BIT6_DEFAULT		BIT(6)
+
+#define MCP3456_CONFIG0_VREF_MASK		BIT(7)
+#define MCP3564_VREF_SET(x)			((u8)FIELD_PREP(MCP3456_CONFIG0_VREF_MASK, (x)))
+
+/* CONFIG 1 Register */
+#define MCP3564_OVERSPL_RATIO_MASK		GENMASK(5, 2)
+#define MCP3564_OVERSAMPLING_RATIO_SET(x)	((u8)FIELD_PREP(MCP3564_OVERSPL_RATIO_MASK, (x)))
+
+/* CONFIG 2 Register */
+#define MCP3564_BOOST_CURRENT_x0_50	0x00
+#define MCP3564_BOOST_CURRENT_x0_66	0x01
+#define MCP3564_BOOST_CURRENT_x1_00	0x02
+#define MCP3564_BOOST_CURRENT_x2_00	0x03
+
+#define MCP3564_BOOST_CURRENT_MASK	GENMASK(7, 6)
+#define MCP3564_BOOST_CURRENT_SET(x)	((u8)FIELD_PREP(MCP3564_BOOST_CURRENT_MASK, (x)))
+
+#define MCP3564_DEFAULT_HARDWARE_GAIN	0x01
+#define MCP3564_HARDWARE_GAIN_MASK	GENMASK(5, 3)
+#define MCP3564_HARDWARE_GAIN_SET(x)	((u8)FIELD_PREP(MCP3564_HARDWARE_GAIN_MASK, (x)))
+
+/* Auto-Zeroing MUX Setting */
+#define MCP3564_AZ_MUX_MASK		BIT(2)
+#define MCP3564_AZ_MUX_SET(x)		((u8)FIELD_PREP(MCP3564_AZ_MUX_MASK, (x)))
+
+/* Auto-Zeroing REF Setting */
+#define MCP3564_AZ_REF_MASK		BIT(1)
+#define MCP3564_AZ_REF_SET(x)		((u8)FIELD_PREP(MCP3564_AZ_REF_MASK, (x)))
+
+/*
+ * CONFIG 3 Register - Conversion Mode Selection
+ * 0b11 = Continuous Conversion mode or continuous conversion cycle in SCAN mode.
+ * 0b10 = One-shot conversion or one-shot cycle in SCAN mode. It sets ADC_MODE[1:0] to ‘10’
+ *        (standby) at the end of the conversion or at the end of the conversion cycle in SCAN mode.
+ * 0b0x = One-shot conversion or one-shot cycle in SCAN mode. It sets ADC_MODE[1:0] to ‘0x’ (ADC
+ *        Shutdown) at the end of the conversion or at the end of the conversion cycle in SCAN
+ *        mode (default).
+ */
+#define MCP3464_CONV_MODE_CONTINUOUS		3
+#define MCP3464_CONV_MODE_ONE_SHOT_STANDBY	2
+#define MCP3464_CONV_MODE_ONE_SHOT_SHUTDOWN	0
+#define MCP3464_CONV_MODE_MASK			GENMASK(7, 6)
+#define MCP3564_CONV_MODE_SET(x)		((u8)FIELD_PREP(MCP3464_CONV_MODE_MASK, (x)))
+
+/*
+ * CONFIG 3 Register - ADC Output Data Format Selection
+ * 0b11 = 32-bit (25-bit right justified data + Channel ID):
+ *        CHID[3:0] + SGN extension (4 bits) + 24-bit ADC data.
+ *        It allows overrange with the SGN extension.
+ * 0b10 = 32-bit (25-bit right justified data):
+ *        SGN extension (8-bit) + 24-bit ADC data.
+ *        It allows overrange with the SGN extension.
+ * 0b01 = 32-bit (24-bit left justified data):
+ *        24-bit ADC data + 0x00 (8-bit).
+ *        It does not allow overrange (ADC code locked to 0xFFFFFF or 0x800000).
+ * 0b00 = 24-bit (default ADC coding): 24-bit ADC data.
+ *        It does not allow overrange (ADC code locked to 0xFFFFFF or 0x800000).
+ */
+#define MCP3456_DATA_FORMAT_32B_WITH_CH_ID	3
+#define MCP3456_DATA_FORMAT_32B_SGN_EXT		2
+#define MCP3456_DATA_FORMAT_32B_LEFT_JUSTIFIED	1
+#define MCP3456_DATA_FORMAT_24B			0
+#define MCP3464_DATA_FORMAT_MASK		GENMASK(5, 4)
+#define MCP3564_DATA_FORMAT_SET(x)		((u8)FIELD_PREP(MCP3464_DATA_FORMAT_MASK, (x)))
+
+#define MCP3464_CRC_FORMAT		BIT(3)
+#define MCP3464_EN_CRCCOM		BIT(2)
+#define MCP3464_EN_OFFCAL		BIT(1)
+#define MCP3464_EN_GAINCAL		BIT(0)
+
+/* IRQ REGISTER */
+#define MCP3564_DATA_READY_MASK		BIT(6)
+#define MCP3564_CRCCFG_STATUS		BIT(5)
+#define MCP3564_POR_STATUS		BIT(4)
+#define MCP3464_IRQ_MODE_1		BIT(3)
+#define MCP3464_IRQ_MODE_0		BIT(2)
+#define MCP3464_EN_FASTCMD		BIT(1)
+#define MCP3464_EN_STP			BIT(0)
+
+/* MULTIPLEXER (MUX) REGISTER */
+#define MCP3564_MUX_VIN_P_MASK		GENMASK(7, 4)
+#define MCP3564_MUX_VIN_N_MASK		GENMASK(3, 0)
+#define MCP3564_MUX_SET(x, y)		((u8)FIELD_PREP(MCP3564_MUX_VIN_P_MASK, (x)) |	\
+					 (u8)FIELD_PREP(MCP3564_MUX_VIN_N_MASK, (y)))
+
+/* SCAN REGISTER */
+#define MCP3564_DELAY_TIME_MASK		GENMASK(23, 21)
+#define MCP3564_DELAY_TIME_SET(x)	((u32)FIELD_PREP(MCP3564_DELAY_TIME_MASK, (x)))
+
+#define MCP3564_SCAN_DEFAULT_VALUE	0
+#define MCP3564_SCAN_CH_SEL_MASK	GENMASK(15, 0)
+#define MCP3564_SCAN_CH_SEL_SET(x)	((u32)FIELD_PREP(MCP3564_SCAN_CH_SEL_MASK, (x)))
+
+/* TIMER REGISTER */
+#define MCP3564_TIMER_DEFAULT_VALUE	0
+#define MCP3564_TIMER_MASK		GENMASK(23, 0)
+#define MCP3564_TIMER_SET(x)		((u32)FIELD_PREP(MCP3564_TIMER_MASK, (x)))
+
+/* OFFSETCAL REGISTER */
+#define MCP3564_DEFAULT_OFFSETCAL	0
+#define MCP3564_OFFSETCAL_MASK		GENMASK(23, 0)
+#define MCP3564_OFFSETCAL_SET(x)	((u32)FIELD_PREP(MCP3564_OFFSETCAL_MASK, (x)))
+
+/* GAINCAL REGISTER */
+#define MCP3564_DEFAULT_GAINCAL		0x00800000
+#define MCP3564_GAINCAL_MASK		GENMASK(23, 0)
+#define MCP3564_GAINCAL_SET(x)		((u32)FIELD_PREP(MCP3564_GAINCAL_MASK, (x)))
+
+#define MCP3564_DATA_READY_TIMEOUT_MS	2000
+
+#define MCP3564_LOCK_WRITE_ACCESS_PASSWORD	0xA5
+
+#define MCP3564_MAX_PGA				8
+#define MCP3564_MAX_BURNOUT_IDX			4
+
+#define MCP3564_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
+
+enum mcp3564_ids {
+	mcp3461,
+	mcp3462,
+	mcp3464,
+	mcp3561,
+	mcp3562,
+	mcp3564,
+	mcp3461r,
+	mcp3462r,
+	mcp3464r,
+	mcp3561r,
+	mcp3562r,
+	mcp3564r,
+};
+
+enum mcp3564_delay_time {
+	MCP3564_NO_DELAY,
+	MCP3564_DELAY_8_DMCLK,
+	MCP3564_DELAY_16_DMCLK,
+	MCP3564_DELAY_32_DMCLK,
+	MCP3564_DELAY_64_DMCLK,
+	MCP3564_DELAY_128_DMCLK,
+	MCP3564_DELAY_256_DMCLK,
+	MCP3564_DELAY_512_DMCLK
+};
+
+enum mcp3564_burnout {
+	MCP3564_CS_SEL_0_0_uA,
+	MCP3564_CS_SEL_0_9_uA,
+	MCP3564_CS_SEL_3_7_uA,
+	MCP3564_CS_SEL_15_uA
+};
+
+enum mcp3564_oversampling {
+	MCP3564_OVERSAMPLING_RATIO_32,
+	MCP3564_OVERSAMPLING_RATIO_64,
+	MCP3564_OVERSAMPLING_RATIO_128,
+	MCP3564_OVERSAMPLING_RATIO_256,
+	MCP3564_OVERSAMPLING_RATIO_512,
+	MCP3564_OVERSAMPLING_RATIO_1024,
+	MCP3564_OVERSAMPLING_RATIO_2048,
+	MCP3564_OVERSAMPLING_RATIO_4096,
+	MCP3564_OVERSAMPLING_RATIO_8192,
+	MCP3564_OVERSAMPLING_RATIO_16384,
+	MCP3564_OVERSAMPLING_RATIO_20480,
+	MCP3564_OVERSAMPLING_RATIO_24576,
+	MCP3564_OVERSAMPLING_RATIO_40960,
+	MCP3564_OVERSAMPLING_RATIO_49152,
+	MCP3564_OVERSAMPLING_RATIO_81920,
+	MCP3564_OVERSAMPLING_RATIO_98304
+};
+
+static const unsigned int mcp3564_oversampling_avail[] = {
+	[MCP3564_OVERSAMPLING_RATIO_32] = 32,
+	[MCP3564_OVERSAMPLING_RATIO_64] = 64,
+	[MCP3564_OVERSAMPLING_RATIO_128] = 128,
+	[MCP3564_OVERSAMPLING_RATIO_256] = 256,
+	[MCP3564_OVERSAMPLING_RATIO_512] = 512,
+	[MCP3564_OVERSAMPLING_RATIO_1024] = 1024,
+	[MCP3564_OVERSAMPLING_RATIO_2048] = 2048,
+	[MCP3564_OVERSAMPLING_RATIO_4096] = 4096,
+	[MCP3564_OVERSAMPLING_RATIO_8192] = 8192,
+	[MCP3564_OVERSAMPLING_RATIO_16384] = 16384,
+	[MCP3564_OVERSAMPLING_RATIO_20480] = 20480,
+	[MCP3564_OVERSAMPLING_RATIO_24576] = 24576,
+	[MCP3564_OVERSAMPLING_RATIO_40960] = 40960,
+	[MCP3564_OVERSAMPLING_RATIO_49152] = 49152,
+	[MCP3564_OVERSAMPLING_RATIO_81920] = 81920,
+	[MCP3564_OVERSAMPLING_RATIO_98304] = 98304
+};
+
+/*
+ * Current Source/Sink Selection Bits for Sensor Bias (source on VIN+/sink on VIN-)
+ */
+static const int mcp3564_burnout_avail[][2] = {
+	[MCP3564_CS_SEL_0_0_uA] = {0, 0},
+	[MCP3564_CS_SEL_0_9_uA] = {0, 900},
+	[MCP3564_CS_SEL_3_7_uA] = {0, 3700},
+	[MCP3564_CS_SEL_15_uA] = {0, 15000}
+};
+
+/*
+ * BOOST[1:0]: ADC Bias Current Selection
+ */
+static const char * const mcp3564_boost_current_avail[] = {
+	[MCP3564_BOOST_CURRENT_x0_50] = "0.5",
+	[MCP3564_BOOST_CURRENT_x0_66] = "0.66",
+	[MCP3564_BOOST_CURRENT_x1_00] = "1",
+	[MCP3564_BOOST_CURRENT_x2_00] = "2",
+};
+
+/*
+ * Calibration bias values
+ */
+static const int mcp3564_calib_bias[] = {
+	-8388608,	/* min: -2^23		*/
+	 1,		/* step: 1		*/
+	 8388607	/* max:  2^23 - 1	*/
+};
+
+/*
+ * Calibration scale values
+ * The Gain Error Calibration register (GAINCAL) is an
+ * unsigned 24-bit register that holds the digital gain error
+ * calibration value, GAINCAL which could be calculated by
+ * GAINCAL (V/V) = (GAINCAL[23:0])/8388608
+ * The gain error calibration value range in equivalent voltage is [0; 2-2^(-23)]
+ */
+static const unsigned int mcp3564_calib_scale[] = {
+	0,		/* min:  0		*/
+	1,		/* step: 1/8388608	*/
+	16777215	/* max:  2 - 2^(-23)	*/
+};
+
+/* Programmable hardware gain x1/3, x1, x2, x4, x8, x16, x32, x64 */
+static const int mcp3564_hwgain_frac[] = {
+	3, 10,
+	1, 1,
+	2, 1,
+	4, 1,
+	8, 1,
+	16, 1,
+	32, 1,
+	64, 1
+};
+
+/**
+ * struct mcp3564_chip_info - chip specific data
+ * @channels:		struct iio_chan_spec matching the device's capabilities
+ * @num_channels:	number of channels
+ * @resolution:		ADC resolution
+ */
+struct mcp3564_chip_info {
+	const char	*name;
+	unsigned int	num_channels;
+	unsigned int	resolution;
+};
+
+/**
+ * struct mcp3564_state - working data for a ADC device
+ * @chip_info:		chip specific data
+ * @spi:		SPI device structure
+ * @vref:		the regulator device used as a voltage reference in case
+ *			external voltage reference is used
+ * @vref_mv:		voltage reference value in miliVolts
+ * @lock:		Synchronize access to driver's state members
+ * @dev_addr:		hardware device address
+ * @oversampling:	the index inside oversampling list of the ADC
+ * @hwgain:		the index inside hardware gain list of the ADC
+ * @scale_tbls		table with precalculated scale
+ * @calib_bias:		calibration bias value
+ * @calib_scale:	calibration scale value
+ * @current_boost_mode:	the index inside current boost list of the ADC
+ * @burnout:		the index inside current bias list of the ADC
+ * @auto_zeroing_mux:	set if ADC auto-zeroing algorithm is enabled
+ * @auto_zeroing_ref:	set if ADC auto-Zeroing Reference Buffer Setting is enabled
+ * @has_vref:		Does the ADC has an internal voltage reference?
+ */
+struct mcp3564_state {
+	const struct mcp3564_chip_info	*chip_info;
+	struct spi_device		*spi;
+	struct regulator		*vref;
+	unsigned short			vref_mv;
+	struct mutex			lock; /* Synchronize access to driver's state members */
+	u8				dev_addr;
+	enum mcp3564_oversampling	oversampling;
+	unsigned int			hwgain;
+	unsigned int			scale_tbls[MCP3564_MAX_PGA][2];
+	int				calib_bias;
+	int				calib_scale;
+	unsigned int			current_boost_mode;
+	enum mcp3564_burnout		burnout_mode;
+	bool				auto_zeroing_mux;
+	bool				auto_zeroing_ref;
+	bool				has_vref;
+};
+
+static inline u8 mcp3564_cmd_write(u8 chip_addr, u8 reg)
+{
+	return MCP3564_CMD_HW_ADDR_SET(chip_addr) | MCP3564_CMD_ADDR_SET(reg) | BIT(1);
+}
+
+static inline u8 mcp3564_cmd_read(u8 chip_addr, u8 reg)
+{
+	return MCP3564_CMD_HW_ADDR_SET(chip_addr) | MCP3564_CMD_ADDR_SET(reg) | BIT(0);
+}
+
+static int mcp3564_read_8bits(struct mcp3564_state *adc, u8 reg, u8 *val)
+{
+	int ret;
+	u8 tx_buf;
+	u8 rx_buf;
+
+	tx_buf = mcp3564_cmd_read(adc->dev_addr, reg);
+
+	ret = spi_write_then_read(adc->spi, &tx_buf, sizeof(tx_buf),
+				  &rx_buf, sizeof(rx_buf));
+	*val = rx_buf;
+
+	return ret;
+}
+
+static int mcp3564_read_16bits(struct mcp3564_state *adc, u8 reg, u16 *val)
+{
+	int ret;
+	u8 tx_buf;
+	u8 rx_buf[2];
+
+	tx_buf = mcp3564_cmd_read(adc->dev_addr, reg);
+
+	ret = spi_write_then_read(adc->spi, &tx_buf, sizeof(tx_buf),
+				  rx_buf, sizeof(rx_buf));
+	*val = get_unaligned_be16(rx_buf);
+
+	return ret;
+}
+
+static int mcp3564_read_32bits(struct mcp3564_state *adc, u8 reg, u32 *val)
+{
+	int ret;
+	u8 tx_buf;
+	u8 rx_buf[4];
+
+	tx_buf = mcp3564_cmd_read(adc->dev_addr, reg);
+
+	ret = spi_write_then_read(adc->spi, &tx_buf, sizeof(tx_buf),
+				  rx_buf, sizeof(rx_buf));
+	*val = get_unaligned_be32(rx_buf);
+
+	return ret;
+}
+
+static int mcp3564_write_8bits(struct mcp3564_state *adc, u8 reg, u8 val)
+{
+	u8 tmp;
+	u8 tx_buf[2];
+
+	tx_buf[0] = mcp3564_cmd_write(adc->dev_addr, reg);
+	tx_buf[1] = val;
+
+	return spi_write_then_read(adc->spi, tx_buf, sizeof(tx_buf), &tmp, 0);
+}
+
+static int mcp3564_write_24bits(struct mcp3564_state *adc, u8 reg, u32 val)
+{
+	u8 tmp;
+	__be32 val_be;
+
+	val |= (mcp3564_cmd_write(adc->dev_addr, reg) << 24);
+	put_unaligned_be32(val, &val_be);
+
+	return spi_write_then_read(adc->spi, &val_be, sizeof(val_be), &tmp, 0);
+}
+
+static int mcp3564_fast_cmd(struct mcp3564_state *adc, u8 fast_cmd)
+{
+	u8 val;
+	u8 tmp;
+
+	val = MCP3564_CMD_HW_ADDR_SET(adc->dev_addr) | MCP3564_CMD_ADDR_SET(fast_cmd);
+
+	return spi_write_then_read(adc->spi, &val, 1, &tmp, 0);
+}
+
+static int mcp3564_update_8bits(struct mcp3564_state *adc, u8 reg, u32 mask, u8 val)
+{
+	u8 tmp;
+	int ret;
+
+	ret = mcp3564_read_8bits(adc, reg, &tmp);
+	if (ret < 0)
+		return ret;
+
+	val &= mask;
+	val |= tmp & ~mask;
+	ret = mcp3564_write_8bits(adc, reg, val);
+
+	return ret;
+}
+
+static int mcp3564_set_current_boost_mode(struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan,
+					  unsigned int mode)
+{
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+	int ret;
+
+	dev_dbg(&indio_dev->dev, "%s: %d\n", __func__, mode);
+
+	mutex_lock(&adc->lock);
+	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2, MCP3564_BOOST_CURRENT_MASK,
+				   MCP3564_BOOST_CURRENT_SET(mode));
+
+	if (ret)
+		dev_err(&indio_dev->dev, "Failed to configure CONFIG2 register\n");
+	else
+		adc->current_boost_mode = mode;
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static int mcp3564_get_current_boost_mode(struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan)
+{
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+
+	return adc->current_boost_mode;
+}
+
+static const struct iio_enum mcp3564_current_boost_mode_enum = {
+	.items = mcp3564_boost_current_avail,
+	.num_items = ARRAY_SIZE(mcp3564_boost_current_avail),
+	.set = mcp3564_set_current_boost_mode,
+	.get = mcp3564_get_current_boost_mode,
+};
+
+static const struct iio_chan_spec_ext_info mcp3564_ext_info[] = {
+	IIO_ENUM("boost_current", IIO_SHARED_BY_ALL, &mcp3564_current_boost_mode_enum),
+	{
+		.name = "boost_current_available",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = iio_enum_available_read,
+		.private = (uintptr_t)&mcp3564_current_boost_mode_enum,
+	},
+	{}
+};
+
+static ssize_t mcp3564_auto_zeroing_mux_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", adc->auto_zeroing_mux);
+}
+
+static ssize_t mcp3564_auto_zeroing_mux_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+	bool auto_zero;
+	int ret;
+
+	ret = kstrtobool(buf, &auto_zero);
+	if (ret)
+		return ret;
+
+	mutex_lock(&adc->lock);
+	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2, MCP3564_AZ_MUX_MASK,
+				   MCP3564_AZ_MUX_SET(auto_zero));
+
+	if (ret)
+		dev_err(&indio_dev->dev, "Failed to update CONFIG2 register\n");
+	else
+		adc->auto_zeroing_mux = auto_zero;
+
+	mutex_unlock(&adc->lock);
+
+	return ret ? ret : len;
+}
+
+static ssize_t mcp3564_auto_zeroing_ref_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%d\n", adc->auto_zeroing_ref);
+}
+
+static ssize_t mcp3564_auto_zeroing_ref_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+	bool auto_zero;
+	int ret;
+
+	ret = kstrtobool(buf, &auto_zero);
+	if (ret)
+		return ret;
+
+	mutex_lock(&adc->lock);
+	ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2, MCP3564_AZ_REF_MASK,
+				   MCP3564_AZ_REF_SET(auto_zero));
+
+	if (ret)
+		dev_err(&indio_dev->dev, "Failed to update CONFIG2 register\n");
+	else
+		adc->auto_zeroing_ref = auto_zero;
+
+	mutex_unlock(&adc->lock);
+
+	return ret ? ret : len;
+}
+
+static const struct iio_chan_spec mcp3564_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.differential = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_all  = BIT(IIO_CHAN_INFO_SCALE)		|
+				BIT(IIO_CHAN_INFO_CALIBSCALE)		|
+				BIT(IIO_CHAN_INFO_CALIBBIAS)		|
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SCALE)	|
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS)		|
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	.ext_info = mcp3564_ext_info,
+	.scan_type = {
+		.sign = 's',
+		.storagebits = 32,
+		.endianness = IIO_BE,
+	},
+};
+
+static const struct iio_chan_spec mcp3564_temp_channel_template = {
+	.type = IIO_TEMP,
+	.channel = 0,
+	.address = ((MCP3564_TEMP_DIODE_P << 4) | MCP3564_TEMP_DIODE_M),
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_all  = BIT(IIO_CHAN_INFO_SCALE)		|
+			BIT(IIO_CHAN_INFO_CALIBSCALE)			|
+			BIT(IIO_CHAN_INFO_CALIBBIAS)			|
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SCALE)	|
+			BIT(IIO_CHAN_INFO_CALIBSCALE) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS)			|
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	.scan_type = {
+		.sign = 'u',
+		.storagebits = 32,
+		.endianness = IIO_BE,
+	},
+};
+
+static const struct iio_chan_spec mcp3564_burnout_channel_template = {
+	.extend_name = "burnout",
+	.type = IIO_CURRENT,
+	.output = true,
+	.channel = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
+};
+
+static const struct mcp3564_chip_info mcp3564_chip_infos_tbl[] = {
+	[mcp3461] = {
+		.name = "mcp3461",
+		.num_channels = 6,
+		.resolution = 16,
+	},
+	[mcp3462] = {
+		.name = "mcp3462",
+		.num_channels = 18,
+		.resolution = 16,
+	},
+	[mcp3464] = {
+		.name = "mcp3464",
+		.num_channels = 66,
+		.resolution = 16,
+	},
+	[mcp3561] = {
+		.name = "mcp3561",
+		.num_channels = 6,
+		.resolution = 24,
+	},
+	[mcp3562] = {
+		.name = "mcp3562",
+		.num_channels = 18,
+		.resolution = 24,
+	},
+	[mcp3564] = {
+		.name = "mcp3564",
+		.num_channels = 66,
+		.resolution = 24,
+	},
+	[mcp3461r] = {
+		.name = "mcp3461r",
+		.num_channels = 6,
+		.resolution = 16,
+	},
+	[mcp3462r] = {
+		.name = "mcp3462r",
+		.num_channels = 18,
+		.resolution = 16,
+	},
+	[mcp3464r] = {
+		.name = "mcp3464r",
+		.num_channels = 66,
+		.resolution = 16,
+	},
+	[mcp3561r] = {
+		.name = "mcp3561r",
+		.num_channels = 6,
+		.resolution = 24,
+	},
+	[mcp3562r] = {
+		.name = "mcp3562r",
+		.num_channels = 18,
+		.resolution = 24,
+	},
+	[mcp3564r] = {
+		.name = "mcp3564r",
+		.num_channels = 66,
+		.resolution = 24,
+	},
+};
+
+static int mcp3564_read_single_value(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *channel,
+				     int *val)
+{
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+	int ret;
+	u8 tmp;
+	int ret_read = 0;
+
+	ret = mcp3564_write_8bits(adc, MCP3564_MUX, channel->address);
+	if (ret)
+		return ret;
+
+	/* Start ADC Conversion using fast command (overwrites ADC_MODE[1:0] = 11) */
+	ret = mcp3564_fast_cmd(adc, MCP3564_FASTCMD_START);
+	if (ret)
+		return ret;
+
+	/*
+	 * Check if the conversion is ready. If not, wait a little bit, and
+	 * in case of timeout exit with an error.
+	 */
+	ret = read_poll_timeout(mcp3564_read_8bits, ret_read,
+				ret_read || !(tmp & MCP3564_DATA_READY_MASK),
+				20000, MCP3564_DATA_READY_TIMEOUT_MS * 1000, true,
+				adc, MCP3564_IRQ, &tmp);
+
+	/* failed to read status register */
+	if (ret_read)
+		return ret;
+
+	if (ret)
+		return -ETIMEDOUT;
+
+	if (tmp & MCP3564_DATA_READY_MASK)
+		/* failing to finish conversion */
+		return -EBUSY;
+
+	ret = mcp3564_read_32bits(adc, MCP3564_ADCDATA, val);
+
+	return ret;
+}
+
+static int mcp3564_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *channel,
+			      const int **vals, int *type,
+			      int *length, long mask)
+{
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (channel->output) {
+			*vals = mcp3564_burnout_avail[0];
+			*length = ARRAY_SIZE(mcp3564_burnout_avail) * 2;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = mcp3564_oversampling_avail;
+		*length = ARRAY_SIZE(mcp3564_oversampling_avail);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)adc->scale_tbls;
+		*length = ARRAY_SIZE(adc->scale_tbls) * 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*vals = mcp3564_calib_bias;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*vals = mcp3564_calib_scale;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp3564_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel,
+			    int *val, int *val2, long mask)
+{
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (channel->output) {
+			*val = mcp3564_burnout_avail[adc->burnout_mode][0];
+			*val2 = mcp3564_burnout_avail[adc->burnout_mode][1];
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+
+		ret = mcp3564_read_single_value(indio_dev, channel, val);
+		if (ret)
+			return -EINVAL;
+		else
+			return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		mutex_lock(&adc->lock);
+		*val = adc->scale_tbls[adc->hwgain][0];
+		*val2 = adc->scale_tbls[adc->hwgain][1];
+		mutex_unlock(&adc->lock);
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = mcp3564_oversampling_avail[adc->oversampling];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = adc->calib_bias;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*val = adc->calib_scale;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp3564_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE:
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp3564_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *channel, int val,
+			     int val2, long mask)
+{
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+	int tmp;
+	unsigned int hwgain;
+	enum mcp3564_burnout burnout;
+	int ret = 0;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (channel->output) {
+			for (burnout = 0; burnout < MCP3564_MAX_BURNOUT_IDX; burnout++) {
+				if (val == mcp3564_burnout_avail[burnout][0] &&
+				    val2 == mcp3564_burnout_avail[burnout][1])
+					break;
+			}
+
+			if (burnout == MCP3564_MAX_BURNOUT_IDX)
+				return -EINVAL;
+
+			if (burnout == adc->burnout_mode)
+				return ret;
+
+			mutex_lock(&adc->lock);
+			ret = mcp3564_update_8bits(adc, MCP3564_CONFIG0,
+						   MCP3564_CS_SEL_MASK,
+						   MCP3564_CS_SEL_SET(burnout));
+
+			if (ret)
+				dev_err(&indio_dev->dev, "Failed to configure burnout current\n");
+			else
+				adc->burnout_mode = burnout;
+			break;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])
+			return -EINVAL;
+
+		mutex_lock(&adc->lock);
+		ret = mcp3564_write_24bits(adc, MCP3564_OFFSETCAL, val);
+		if (!ret)
+			adc->calib_bias = val;
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])
+			return -EINVAL;
+
+		if (adc->calib_scale == val)
+			return ret;
+
+		mutex_lock(&adc->lock);
+		ret = mcp3564_write_24bits(adc, MCP3564_GAINCAL, val);
+		if (!ret)
+			adc->calib_scale = val;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (val < 0)
+			return -EINVAL;
+
+		tmp = find_closest(val, mcp3564_oversampling_avail,
+				   ARRAY_SIZE(mcp3564_oversampling_avail));
+
+		if (adc->oversampling == tmp)
+			return ret;
+
+		mutex_lock(&adc->lock);
+		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG1, MCP3564_OVERSPL_RATIO_MASK,
+					   MCP3564_OVERSAMPLING_RATIO_SET(adc->oversampling));
+		if (!ret)
+			adc->oversampling = tmp;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		for (hwgain = 0; hwgain < MCP3564_MAX_PGA; hwgain++) {
+			if (val == adc->scale_tbls[hwgain][0] &&
+			    val2 == adc->scale_tbls[hwgain][1])
+				break;
+		}
+
+		if (hwgain == MCP3564_MAX_PGA)
+			return -EINVAL;
+
+		if (hwgain == adc->hwgain)
+			return ret;
+
+		mutex_lock(&adc->lock);
+		/* Update GAIN in CONFIG2[5:3] -> GAIN[2:0]*/
+		ret = mcp3564_update_8bits(adc, MCP3564_CONFIG2, MCP3564_HARDWARE_GAIN_MASK,
+					   MCP3564_HARDWARE_GAIN_SET(hwgain));
+		if (!ret)
+			adc->hwgain = hwgain;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
+{
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+	struct device *dev = &adc->spi->dev;
+	struct iio_chan_spec *channels;
+	struct fwnode_handle *child;
+	struct iio_chan_spec chanspec = mcp3564_channel_template;
+	struct iio_chan_spec temp_chanspec = mcp3564_temp_channel_template;
+	struct iio_chan_spec burnout_chanspec = mcp3564_burnout_channel_template;
+	int chan_idx = 0;
+	unsigned int num_ch;
+	u32 inputs[2];
+	const char *node_name;
+	int ret;
+
+	num_ch = device_get_child_node_count(dev);
+	if (num_ch == 0)
+		return dev_err_probe(&indio_dev->dev, -ENODEV,
+				     "FW has no channels defined\n");
+
+	/* Reserve space for temperature channel and burnout */
+	num_ch += 2;
+
+	if (num_ch > adc->chip_info->num_channels) {
+		return dev_err_probe(dev, -EINVAL, "Too many channels %d > %d\n",
+				     num_ch, adc->chip_info->num_channels);
+	}
+
+	channels = devm_kcalloc(dev, num_ch, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return dev_err_probe(dev, -ENOMEM, "Can't allocate memory\n");
+
+	device_for_each_child_node(dev, child) {
+		node_name = fwnode_get_name(child);
+
+		if (fwnode_property_present(child, "diff-channels")) {
+			ret = fwnode_property_read_u32_array(child,
+							     "diff-channels",
+							     inputs,
+							     ARRAY_SIZE(inputs));
+
+			chanspec.differential = 1;
+			dev_info(dev, "-> %s: diff-channels %d - %d\n",
+				 node_name, inputs[0], inputs[1]);
+		} else {
+			ret = fwnode_property_read_u32(child, "reg", &inputs[0]);
+
+			chanspec.differential = 0;
+			inputs[1] = MCP3564_AGND;
+			dev_info(dev, "-> %s: channel %d - AGND\n", node_name, inputs[0]);
+		}
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+
+		if (inputs[0] > MCP3564_INTERNAL_VCM ||
+		    inputs[1] > MCP3564_INTERNAL_VCM) {
+			fwnode_handle_put(child);
+			return dev_err_probe(&indio_dev->dev, -EINVAL,
+					     "Channel index > %d, for %s\n",
+					     MCP3564_INTERNAL_VCM + 1,
+					     node_name);
+		}
+
+		chanspec.address = (inputs[0] << 4) | inputs[1];
+		chanspec.channel = inputs[0];
+		chanspec.channel2 = inputs[1];
+		chanspec.scan_type.realbits = adc->chip_info->resolution;
+
+		channels[chan_idx] = chanspec;
+		chan_idx++;
+	}
+
+	/* Add burnout current channel */
+	channels[chan_idx] = burnout_chanspec;
+	chan_idx++;
+
+	/* Add temperature channel */
+	temp_chanspec.scan_type.realbits = adc->chip_info->resolution;
+	channels[chan_idx] = temp_chanspec;
+	chan_idx++;
+
+	indio_dev->num_channels = chan_idx;
+	indio_dev->channels = channels;
+
+	return 0;
+}
+
+static void mcp3564_disable_reg(void *reg)
+{
+	if (reg)
+		regulator_disable(reg);
+}
+
+static void mcp3564_fill_scale_tbls(struct mcp3564_state *adc)
+{
+	unsigned int pow = adc->chip_info->resolution - 1;
+	int ref;
+	unsigned int i;
+	int tmp0, tmp1;
+	u64 tmp2;
+
+	for (i = 0; i < MCP3564_MAX_PGA; i++) {
+		ref = adc->vref_mv;
+		tmp2 = shift_right((u64)ref * NANO, pow);
+		tmp0 = (int)div_u64_rem(tmp2, NANO, &tmp1);
+
+		tmp2 = tmp2 * mcp3564_hwgain_frac[(2 * i) + 1];
+		tmp1 = (int)div_u64(tmp2, mcp3564_hwgain_frac[2 * i]);
+
+		adc->scale_tbls[i][1] = tmp1;
+	}
+}
+
+static int mcp3564_config(struct iio_dev *indio_dev)
+{
+	struct mcp3564_state *adc = iio_priv(indio_dev);
+	struct device *dev = &adc->spi->dev;
+	u8 tmp_reg;
+	u16 tmp_u16;
+	enum mcp3564_ids ids;
+	int ret = 0;
+	unsigned int tmp = 0x01;
+
+	/*
+	 * The address is set on a per-device basis by fuses in the factory,
+	 * configured on request. If not requested, the fuses are set for 0x1.
+	 * The device address is part of the device markings to avoid
+	 * potential confusion. This address is coded on two bits, so four possible
+	 * addresses are available when multiple devices are present on the same
+	 * SPI bus with only one Chip Select line for all devices.
+	 */
+	device_property_read_u32(dev, "microchip,hw-device-address", &tmp);
+
+	if (tmp > 3) {
+		dev_err_probe(dev, tmp,
+			      "invalid device address. Must be in range 0-3.\n");
+		return -EINVAL;
+	}
+
+	adc->dev_addr = 0xff & tmp;
+
+	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
+
+	ret = mcp3564_read_8bits(adc, MCP3564_RESERVED_C, &tmp_reg);
+	if (ret < 0)
+		return ret;
+
+	switch (tmp_reg) {
+	case MCP3564_REG_C_DEFAULT:
+		adc->has_vref = false;
+		break;
+	case MCP3564R_REG_C_DEFAULT:
+		adc->has_vref = true;
+		break;
+	default:
+		dev_err_probe(dev, tmp_reg, "Unknown chip found\n");
+		return -EINVAL;
+	}
+
+	ret = mcp3564_read_16bits(adc, MCP3564_RESERVED_E, &tmp_u16);
+	if (ret < 0)
+		return ret;
+
+	switch (tmp_u16 & MCP3564_HW_ID_MASK) {
+	case MCP3461_HW_ID:
+		if (adc->has_vref)
+			ids = mcp3461r;
+		else
+			ids = mcp3461;
+		break;
+	case MCP3462_HW_ID:
+		if (adc->has_vref)
+			ids = mcp3462r;
+		else
+			ids = mcp3462;
+		break;
+	case MCP3464_HW_ID:
+		if (adc->has_vref)
+			ids = mcp3464r;
+		else
+			ids = mcp3464;
+		break;
+	case MCP3561_HW_ID:
+		if (adc->has_vref)
+			ids = mcp3561r;
+		else
+			ids = mcp3561;
+		break;
+	case MCP3562_HW_ID:
+		if (adc->has_vref)
+			ids = mcp3562r;
+		else
+			ids = mcp3562;
+		break;
+	case MCP3564_HW_ID:
+		if (adc->has_vref)
+			ids = mcp3564r;
+		else
+			ids = mcp3564;
+		break;
+	default:
+		dev_err_probe(dev, tmp_u16, "Unknown chip found\n");
+		return -EINVAL;
+	}
+
+	adc->chip_info = &mcp3564_chip_infos_tbl[ids];
+
+	dev_dbg(dev, "Found %s chip\n", adc->chip_info->name);
+
+	adc->vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(adc->vref)) {
+		if (PTR_ERR(adc->vref) == -ENODEV) {
+			/* Check if chip has internal vref */
+			if (!adc->has_vref)
+				return dev_err_probe(dev, -EINVAL,
+					     "Unknown Vref\n");
+			adc->vref = NULL;
+			dev_dbg(dev, "%s: Using internal Vref\n", __func__);
+		} else {
+			return dev_err_probe(dev, PTR_ERR(adc->vref),
+					     "failed to get regulator\n");
+		}
+	} else {
+		ret = regulator_enable(adc->vref);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, mcp3564_disable_reg,
+					       adc->vref);
+		if (ret)
+			return ret;
+
+		dev_dbg(dev, "%s: Using External Vref\n", __func__);
+
+		ret = regulator_get_voltage(adc->vref);
+		if (ret < 0) {
+			return dev_err_probe(dev, ret,
+					     "Failed to read vref regulator\n");
+		}
+
+		adc->vref_mv = ret / MILLI;
+	}
+
+	ret = mcp3564_parse_fw_children(indio_dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Command sequence that ensures a recovery with the desired settings
+	 * in any cases of loss-of-power scenario (Full Chip Reset):
+	 *  - Write LOCK register to 0xA5
+	 *  - Write IRQ register to 0x03
+	 *  - Send "Device Full Reset" fast command
+	 */
+	ret = mcp3564_write_8bits(adc, MCP3564_LOCK, MCP3564_LOCK_WRITE_ACCESS_PASSWORD);
+	if (ret)
+		return ret;
+
+	ret = mcp3564_write_8bits(adc, MCP3564_IRQ, 0x03);
+	if (ret)
+		return ret;
+
+	ret = mcp3564_fast_cmd(adc, MCP3564_FASTCMD_RESET);
+	if (ret)
+		return ret;
+
+	mdelay(1);
+
+	/* set a gain of 1x for GAINCAL */
+	ret = mcp3564_write_24bits(adc, MCP3564_GAINCAL,
+				   MCP3564_GAINCAL_SET(MCP3564_DEFAULT_GAINCAL));
+	if (ret)
+		return ret;
+
+	adc->calib_scale = MCP3564_GAINCAL_SET(MCP3564_DEFAULT_GAINCAL);
+
+	ret = mcp3564_write_24bits(adc, MCP3564_OFFSETCAL,
+				   MCP3564_OFFSETCAL_SET(MCP3564_DEFAULT_OFFSETCAL));
+	if (ret)
+		return ret;
+
+	ret = mcp3564_write_24bits(adc, MCP3564_TIMER,
+				   MCP3564_TIMER_SET(MCP3564_TIMER_DEFAULT_VALUE));
+	if (ret)
+		return ret;
+
+	ret = mcp3564_write_24bits(adc, MCP3564_SCAN,
+				   MCP3564_DELAY_TIME_SET(MCP3564_NO_DELAY) |
+				   MCP3564_SCAN_CH_SEL_SET(MCP3564_SCAN_DEFAULT_VALUE));
+	if (ret)
+		return ret;
+
+	ret = mcp3564_write_8bits(adc, MCP3564_MUX, MCP3564_MUX_SET(MCP3564_CH0, MCP3564_CH1));
+	if (ret)
+		return ret;
+
+	ret = mcp3564_write_8bits(adc, MCP3564_IRQ, MCP3464_EN_FASTCMD | MCP3464_EN_STP);
+	if (ret)
+		return ret;
+
+	tmp_reg = MCP3564_CONV_MODE_SET(MCP3464_CONV_MODE_ONE_SHOT_STANDBY);
+	tmp_reg |= MCP3564_DATA_FORMAT_SET(MCP3456_DATA_FORMAT_32B_SGN_EXT);
+	tmp_reg |= MCP3464_EN_OFFCAL;
+	tmp_reg |= MCP3464_EN_GAINCAL;
+
+	ret = mcp3564_write_8bits(adc, MCP3564_CONFIG3, tmp_reg);
+	if (ret)
+		return ret;
+
+	tmp_reg = MCP3564_BOOST_CURRENT_SET(MCP3564_BOOST_CURRENT_x1_00);
+	tmp_reg |= MCP3564_HARDWARE_GAIN_SET(0x01);
+	tmp_reg |= MCP3564_AZ_MUX_SET(1);
+
+	ret = mcp3564_write_8bits(adc, MCP3564_CONFIG2, tmp_reg);
+	if (ret)
+		return ret;
+
+	adc->hwgain = 0x01;
+	adc->auto_zeroing_mux = true;
+	adc->auto_zeroing_ref = false;
+	adc->current_boost_mode = MCP3564_BOOST_CURRENT_x1_00;
+
+	tmp_reg = MCP3564_OVERSAMPLING_RATIO_SET(MCP3564_OVERSAMPLING_RATIO_98304);
+
+	ret = mcp3564_write_8bits(adc, MCP3564_CONFIG1, tmp_reg);
+	if (ret)
+		return ret;
+
+	adc->oversampling = MCP3564_OVERSAMPLING_RATIO_98304;
+
+	tmp_reg = MCP3564_ADC_MODE_MASK_SET(MCP3564_ADC_MODE_STANDBY);
+	tmp_reg |= MCP3564_CS_SEL_SET(MCP3564_CS_SEL_0_0_uA);
+	tmp_reg |= MCP3564_CLK_SEL_SET(MCP3564_USE_INTERNAL_CLK);
+	tmp_reg |= MCP3456_CONFIG0_BIT6_DEFAULT;
+
+	if (!adc->vref) {
+		tmp_reg |= MCP3564_VREF_SET(1);
+		adc->vref_mv = MCP3564R_INT_VREF_MV;
+	}
+
+	ret = mcp3564_write_8bits(adc, MCP3564_CONFIG0, tmp_reg);
+
+	adc->burnout_mode = MCP3564_CS_SEL_0_0_uA;
+
+	return ret;
+}
+
+static IIO_DEVICE_ATTR(enable_auto_zeroing_ref, 0644,
+		       mcp3564_auto_zeroing_ref_show,
+		       mcp3564_auto_zeroing_ref_store, 0);
+
+static IIO_DEVICE_ATTR(enable_auto_zeroing_mux, 0644,
+		       mcp3564_auto_zeroing_mux_show,
+		       mcp3564_auto_zeroing_mux_store, 0);
+
+static struct attribute *mcp3564_attributes[] = {
+	MCP3564_DEV_ATTR(enable_auto_zeroing_mux),
+	NULL
+};
+
+static struct attribute *mcp3564r_attributes[] = {
+	MCP3564_DEV_ATTR(enable_auto_zeroing_mux),
+	MCP3564_DEV_ATTR(enable_auto_zeroing_ref),
+	NULL
+};
+
+static struct attribute_group mcp3564_attribute_group = {
+	.attrs = mcp3564_attributes,
+};
+
+static struct attribute_group mcp3564r_attribute_group = {
+	.attrs = mcp3564r_attributes,
+};
+
+static const struct iio_info mcp3564_info = {
+	.read_raw = mcp3564_read_raw,
+	.read_avail = mcp3564_read_avail,
+	.write_raw = mcp3564_write_raw,
+	.write_raw_get_fmt = mcp3564_write_raw_get_fmt,
+	.attrs = &mcp3564_attribute_group,
+};
+
+static const struct iio_info mcp3564r_info = {
+	.read_raw = mcp3564_read_raw,
+	.read_avail = mcp3564_read_avail,
+	.write_raw = mcp3564_write_raw,
+	.write_raw_get_fmt = mcp3564_write_raw_get_fmt,
+	.attrs = &mcp3564r_attribute_group,
+};
+
+static int mcp3564_probe(struct spi_device *spi)
+{
+	int ret;
+	struct iio_dev *indio_dev;
+	struct mcp3564_state *adc;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	if (!indio_dev) {
+		dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
+			      "Can't allocate iio device\n");
+		return -ENOMEM;
+	}
+
+	adc = iio_priv(indio_dev);
+	adc->spi = spi;
+
+	dev_dbg(&spi->dev, "%s: probe(spi = 0x%p)\n", __func__, spi);
+
+	/*
+	 * Do any chip specific initialization, e.g:
+	 * read/write some registers
+	 * enable/disable certain channels
+	 * change the sampling rate to the requested value
+	 */
+	ret = mcp3564_config(indio_dev);
+	if (ret) {
+		return dev_err_probe(&spi->dev, ret,
+				     "Can't configure MCP356X device\n");
+	}
+
+	dev_dbg(&spi->dev, "%s: Vref (mV): %d\n", __func__, adc->vref_mv);
+
+	mcp3564_fill_scale_tbls(adc);
+
+	indio_dev->name = adc->chip_info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	if (adc->has_vref)
+		indio_dev->info = &mcp3564r_info;
+	else
+		indio_dev->info = &mcp3564_info;
+
+	mutex_init(&adc->lock);
+
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret) {
+		return dev_err_probe(&spi->dev, ret,
+				     "Can't register IIO device\n");
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mcp3564_dt_ids[] = {
+	{ .compatible = "microchip,mcp3461", .data = &mcp3564_chip_infos_tbl[mcp3461] },
+	{ .compatible = "microchip,mcp3462", .data = &mcp3564_chip_infos_tbl[mcp3462] },
+	{ .compatible = "microchip,mcp3464", .data = &mcp3564_chip_infos_tbl[mcp3464] },
+	{ .compatible = "microchip,mcp3561", .data = &mcp3564_chip_infos_tbl[mcp3561] },
+	{ .compatible = "microchip,mcp3562", .data = &mcp3564_chip_infos_tbl[mcp3562] },
+	{ .compatible = "microchip,mcp3564", .data = &mcp3564_chip_infos_tbl[mcp3564] },
+	{ .compatible = "microchip,mcp3461r", .data = &mcp3564_chip_infos_tbl[mcp3461r] },
+	{ .compatible = "microchip,mcp3462r", .data = &mcp3564_chip_infos_tbl[mcp3462r] },
+	{ .compatible = "microchip,mcp3464r", .data = &mcp3564_chip_infos_tbl[mcp3464r] },
+	{ .compatible = "microchip,mcp3561r", .data = &mcp3564_chip_infos_tbl[mcp3561r] },
+	{ .compatible = "microchip,mcp3562r", .data = &mcp3564_chip_infos_tbl[mcp3562r] },
+	{ .compatible = "microchip,mcp3564r", .data = &mcp3564_chip_infos_tbl[mcp3564r] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp3564_dt_ids);
+
+static const struct spi_device_id mcp3564_id[] = {
+	{ "mcp3461", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3461] },
+	{ "mcp3462", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3462] },
+	{ "mcp3464", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3464] },
+	{ "mcp3561", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3561] },
+	{ "mcp3562", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3562] },
+	{ "mcp3564", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3564] },
+	{ "mcp3461r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3461r] },
+	{ "mcp3462r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3462r] },
+	{ "mcp3464r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3464r] },
+	{ "mcp3561r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3561r] },
+	{ "mcp3562r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3562r] },
+	{ "mcp3564r", (kernel_ulong_t)&mcp3564_chip_infos_tbl[mcp3564r] },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(spi, mcp3564_id);
+
+static struct spi_driver mcp3564_driver = {
+	.driver = {
+		.name = "mcp3564",
+		.of_match_table = mcp3564_dt_ids,
+	},
+	.probe = mcp3564_probe,
+	.id_table = mcp3564_id,
+};
+
+module_spi_driver(mcp3564_driver);
+
+MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
+MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP346xR ADCs");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

