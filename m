Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9AE433A1D
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhJSPXR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 11:23:17 -0400
Received: from mail-dm3nam07on2045.outbound.protection.outlook.com ([40.107.95.45]:45985
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233772AbhJSPXP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 11:23:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocgJk0AWXWmEr36+/iZUFG1sSAHcaEK8EnrjPIH//e2kDl/qvFRcYNBmyE3Els60cz8i9fMLA2ioRNlBEDJMnH0+W+5VrH8zmdaWjcLvCwE6knPknaVjFJH37AV0+wQVMM5lMQ9sFTeVcPz3fbdMLnXJ81Scom6DOpLdlW+IRFp1l44QUG/bT87rRYe4CSxiKe73smTmlAdOmPyEb9J2sOFUnO3ZNGCODVv1eVVii7lzLb3O29sx4xDtDUcHPOmuvbpwdD9EU44Hm07BD1QjxdIdVYZpKoPdrrTV5+5NRGYhNL2S1r07wNGejkh/psbqZrFG+eLvAQDWbRNNC/tVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJlICimKQj5CVPeOLN6ct7lChzxeBLUhm7SvciPL3G8=;
 b=ObcN2YxvvfyP7CslepKkljBSsEcU0kOHKEOraOSIuGUfCxYES+e6tK7NU2xXXIEsQDJPvjMII+GeAYLTw3TigmgocxOnbzHCkYlPthIE6CaixE0gZBZibYvFYU/3WQSrT3KZDOzMmSTgRRAMdMA6tQeQseT2Sf7kYkczuU52rnBcy3VNNnLSeBD14gd0D4v6Pg1rudXQqzVSzSuVTcwmXRnGbp/a6mVTRaADWP3+oi86aItfsHsgldOYgnAGIcUxA0dblLyzOsHcQ4vyW2OHYcvUv+1rKer2MCQL0xucK1AOOImhYDrM4wU2EivNUpkt5dlpZyHpkRWVSwe9yL27uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJlICimKQj5CVPeOLN6ct7lChzxeBLUhm7SvciPL3G8=;
 b=khqn4SGcwJslsMJ7z5KXBFjPRfcgJzYIR4MdvO9n3EY+5g2pZAsAS0IKCXHBpcwLsRAVCNZE+NBtSgeGaXieJtmtOrgS+/B0ZWyYaXpGDRGWHvkr60LEskua8nYOM2r8CWbQNJTvHJqHgVeTb2aIfjG3plpO628FngX8k+iu8e4=
Received: from BN6PR13CA0029.namprd13.prod.outlook.com (2603:10b6:404:13e::15)
 by CO1PR02MB8458.namprd02.prod.outlook.com (2603:10b6:303:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 15:20:58 +0000
Received: from BN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::63) by BN6PR13CA0029.outlook.office365.com
 (2603:10b6:404:13e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.9 via Frontend
 Transport; Tue, 19 Oct 2021 15:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BN1NAM02FT013.mail.protection.outlook.com (10.13.2.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 15:20:58 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 16:20:56 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 16:20:56 +0100
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michal.simek@xilinx.com,
 manish.narani@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org
Received: from [10.71.188.1] (port=8251 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mcqv4-00030B-5j; Tue, 19 Oct 2021 16:20:50 +0100
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
Date:   Tue, 19 Oct 2021 16:20:46 +0100
Message-ID: <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c48bf316-951e-4272-5e3f-08d993140d57
X-MS-TrafficTypeDiagnostic: CO1PR02MB8458:
X-Microsoft-Antispam-PRVS: <CO1PR02MB845869C1A8BDB391C85585DAA9BD9@CO1PR02MB8458.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUB+BuIC84iCszKpejC5i8/v9GkmvMH/hNcglSWbuWsG+quzHwtP2uzmxaytzpRw5GtHn6m4XKbjsAPjY8INE44HCklIekQRMPMZBkJ+nyMf025DRoCPNjwEPX5QXH/qnxshUJEs5wq+a4LPwPpaQVwRjwXKc6FWoYO+y7DmkKuOO0H0xBtveWVZ1eaykbqP1YjMeNspkd578zW3iRft5ehG9fxl2A3TzRE/3dnw4qv3rMUTmLhRDdyMOm/sTJ5QlMBpzSuGiZjtTsUCd/0Gg9b0tNVQpDleVyv8B7FtMN6izk5yIEzzv7GntnZmDF4ahAS7nm4MrhCsYKMGZ6jJ5FPF0/NMjIeOP+5qm6wlO3s8fruWtZJ7/WMrceELs3eJid7MRB5Z/xNxIVJ2mI9INYZ8QSAq0PjTW+nXx6I2CNEdQ7uTPll5A8b6QBLfjTZfPPiG6ZoEXK/TLEWZ2AI2TaGS3POqtXu7gX7ljmZ3ICkqcCwxUwjtvQ9cON6KLfupYxLnC/8zhGRtAVynaLfwOO2ui3+QHzyBWUmORDCTOgpd5yiImHaza01cheURc2J/n3/tOMet7EqvkZeN/zhDB+g4qF6I+gxdd1WlHAeRZTYIMFs1POA0SFWMziNptFaq9R6bStKx8m0oErsxN0VMbC8nyPRcfwbPw+htym1uFYgAUsRmPOdiw9nmZ6uG/rQj8uSdLkwWkhDBVTzcD6YksPBCZ252wtachCjRaPzurik/3QOPkROP8LefcTPMCQ22
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(1076003)(83380400001)(70586007)(70206006)(8676002)(2616005)(7636003)(82310400003)(4326008)(30864003)(47076005)(356005)(8936002)(426003)(107886003)(186003)(110136005)(508600001)(36906005)(336012)(9786002)(26005)(2906002)(6666004)(316002)(5660300002)(36860700001)(54906003)(7696005)(103116003)(36756003)(102446001)(2101003)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:20:58.0205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c48bf316-951e-4272-5e3f-08d993140d57
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8458
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AMS includes an ADC as well as on-chip sensors that can be used to
sample external voltages and monitor on-die operating conditions, such
as temperature and supply voltage levels. The AMS has two SYSMON blocks.
PL-SYSMON block is capable of monitoring off chip voltage and
temperature.
PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
from external master. Out of these interface currently only DRP is
supported.
Other block PS-SYSMON is memory mapped to PS.
The AMS can use internal channels to monitor voltage and temperature as
well as one primary and up to 16 auxiliary channels for measuring
external voltages.
The voltage and temperature monitoring channels also have event
capability which allows to generate an interrupt when their value falls
below or raises above a set threshold.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
---
 drivers/iio/adc/Kconfig      |   13 +
 drivers/iio/adc/Makefile     |    1 +
 drivers/iio/adc/xilinx-ams.c | 1341 ++++++++++++++++++++++++++++++++++
 3 files changed, 1355 insertions(+)
 create mode 100644 drivers/iio/adc/xilinx-ams.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index af168e1c9fdb..0175e426c935 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1278,4 +1278,17 @@ config XILINX_XADC
 	  The driver can also be build as a module. If so, the module will be called
 	  xilinx-xadc.
 
+config XILINX_AMS
+	tristate "Xilinx AMS driver"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to have support for the Xilinx AMS.
+
+	  The driver supports Voltage and Temperature monitoring on Xilinx Ultrascale
+	  devices.
+
+	  The driver can also be built as a module. If so, the module will be called
+	  xilinx-ams.
+
 endmenu
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d68550f493e3..8ced2a3a153f 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -114,4 +114,5 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
new file mode 100644
index 000000000000..597cdda8a618
--- /dev/null
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -0,0 +1,1341 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx AMS driver
+ *
+ *  Copyright (C) 2021 Xilinx, Inc.
+ *
+ *  Manish Narani <mnarani@xilinx.com>
+ *  Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+static const unsigned int AMS_UNMASK_TIMEOUT_MS = 500;
+
+/* AMS registers definitions */
+#define AMS_ISR_0			0x010
+#define AMS_ISR_1			0x014
+#define AMS_IER_0			0x020
+#define AMS_IER_1			0x024
+#define AMS_IDR_0			0x028
+#define AMS_IDR_1			0x02c
+#define AMS_PS_CSTS			0x040
+#define AMS_PL_CSTS			0x044
+
+#define AMS_VCC_PSPLL0			0x060
+#define AMS_VCC_PSPLL3			0x06C
+#define AMS_VCCINT			0x078
+#define AMS_VCCBRAM			0x07C
+#define AMS_VCCAUX			0x080
+#define AMS_PSDDRPLL			0x084
+#define AMS_PSINTFPDDR			0x09C
+
+#define AMS_VCC_PSPLL0_CH		48
+#define AMS_VCC_PSPLL3_CH		51
+#define AMS_VCCINT_CH			54
+#define AMS_VCCBRAM_CH			55
+#define AMS_VCCAUX_CH			56
+#define AMS_PSDDRPLL_CH			57
+#define AMS_PSINTFPDDR_CH		63
+
+#define AMS_REG_CONFIG0			0x100
+#define AMS_REG_CONFIG1			0x104
+#define AMS_REG_CONFIG3			0x10C
+#define AMS_REG_SEQ_CH0			0x120
+#define AMS_REG_SEQ_CH1			0x124
+#define AMS_REG_SEQ_CH2			0x118
+
+#define AMS_TEMP			0x000
+#define AMS_SUPPLY1			0x004
+#define AMS_SUPPLY2			0x008
+#define AMS_VP_VN			0x00c
+#define AMS_VREFP			0x010
+#define AMS_VREFN			0x014
+#define AMS_SUPPLY3			0x018
+#define AMS_SUPPLY4			0x034
+#define AMS_SUPPLY5			0x038
+#define AMS_SUPPLY6			0x03c
+#define AMS_SUPPLY7			0x200
+#define AMS_SUPPLY8			0x204
+#define AMS_SUPPLY9			0x208
+#define AMS_SUPPLY10			0x20c
+#define AMS_VCCAMS			0x210
+#define AMS_TEMP_REMOTE			0x214
+
+#define AMS_REG_VAUX(x)			(0x40 + 4 * (x))
+
+#define AMS_PS_RESET_VALUE		0xFFFF
+#define AMS_PL_RESET_VALUE		0xFFFF
+
+#define AMS_CONF0_CHANNEL_NUM_MASK	GENMASK(6, 0)
+
+#define AMS_CONF1_SEQ_MASK		GENMASK(15, 12)
+#define AMS_CONF1_SEQ_DEFAULT		FIELD_PREP(AMS_CONF1_SEQ_MASK, 0)
+#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 1)
+#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK, 2)
+
+#define AMS_REG_SEQ0_MASK		GENMASK(15, 0)
+#define AMS_REG_SEQ2_MASK		GENMASK(21, 16)
+#define AMS_REG_SEQ1_MASK		GENMASK(37, 22)
+
+#define AMS_PS_SEQ_MASK			GENMASK(21, 0)
+#define AMS_PL_SEQ_MASK			GENMASK(59, 22)
+
+#define AMS_REGCFG1_ALARM_MASK		0xF0F
+#define AMS_REGCFG3_ALARM_MASK		0x3F
+
+#define AMS_ALARM_TEMP			0x140
+#define AMS_ALARM_SUPPLY1		0x144
+#define AMS_ALARM_SUPPLY2		0x148
+#define AMS_ALARM_SUPPLY3		0x160
+#define AMS_ALARM_SUPPLY4		0x164
+#define AMS_ALARM_SUPPLY5		0x168
+#define AMS_ALARM_SUPPLY6		0x16c
+#define AMS_ALARM_SUPPLY7		0x180
+#define AMS_ALARM_SUPPLY8		0x184
+#define AMS_ALARM_SUPPLY9		0x188
+#define AMS_ALARM_SUPPLY10		0x18c
+#define AMS_ALARM_VCCAMS		0x190
+#define AMS_ALARM_TEMP_REMOTE		0x194
+#define AMS_ALARM_THRESHOLD_OFF_10	0x10
+#define AMS_ALARM_THRESHOLD_OFF_20	0x20
+
+#define AMS_ALARM_THR_DIRECT_MASK	0x01
+#define AMS_ALARM_THR_MIN		0x0000
+#define AMS_ALARM_THR_MAX		0xFFFF
+
+#define AMS_NO_OF_ALARMS		32
+#define AMS_PL_ALARM_START		16
+#define AMS_PL_ALARM_MASK		0xFFFF0000U
+#define AMS_ISR0_ALARM_MASK		0xFFFFFFFFU
+#define AMS_ISR1_ALARM_MASK		0xE000001FU
+#define AMS_ISR1_EOC_MASK		0x00000008U
+#define AMS_ISR1_INTR_MASK		GENMASK(63, 32)
+#define AMS_ISR0_ALARM_2_TO_0_MASK	GENMASK(3, 1)
+#define AMS_ISR0_ALARM_6_TO_3_MASK	GENMASK(11, 8)
+#define AMS_ISR0_ALARM_12_TO_7_MASK	GENMASK(5, 0)
+#define AMS_CONF1_ALARM_2_TO_0_SHIFT	1
+#define AMS_CONF1_ALARM_6_TO_3_SHIFT	5
+#define AMS_CONF3_ALARM_12_TO_7_SHIFT	8
+
+#define AMS_PS_CSTS_PS_READY		0x08010000U
+#define AMS_PL_CSTS_ACCESS_MASK		0x00000001U
+
+#define AMS_PL_MAX_FIXED_CHANNEL	10
+#define AMS_PL_MAX_EXT_CHANNEL		20
+
+#define AMS_INIT_TIMEOUT_US		10000
+
+/*
+ * Following scale and offset value is derived from
+ * UG580 (v1.7) December 20, 2016
+ */
+#define AMS_SUPPLY_SCALE_1VOLT		1000
+#define AMS_SUPPLY_SCALE_3VOLT		3000
+#define AMS_SUPPLY_SCALE_6VOLT		6000
+#define AMS_SUPPLY_SCALE_DIV_BIT	16
+
+#define AMS_TEMP_SCALE			509314
+#define AMS_TEMP_SCALE_DIV_BIT		16
+#define AMS_TEMP_OFFSET			-((280230LL << 16) / 509314)
+
+enum ams_alarm_bit {
+	AMS_ALARM_BIT_TEMP,
+	AMS_ALARM_BIT_SUPPLY1,
+	AMS_ALARM_BIT_SUPPLY2,
+	AMS_ALARM_BIT_SUPPLY3,
+	AMS_ALARM_BIT_SUPPLY4,
+	AMS_ALARM_BIT_SUPPLY5,
+	AMS_ALARM_BIT_SUPPLY6,
+	AMS_ALARM_BIT_RESERVED,
+	AMS_ALARM_BIT_SUPPLY7,
+	AMS_ALARM_BIT_SUPPLY8,
+	AMS_ALARM_BIT_SUPPLY9,
+	AMS_ALARM_BIT_SUPPLY10,
+	AMS_ALARM_BIT_VCCAMS,
+	AMS_ALARM_BIT_TEMP_REMOTE
+};
+
+enum ams_seq {
+	AMS_SEQ_VCC_PSPLL,
+	AMS_SEQ_VCC_PSBATT,
+	AMS_SEQ_VCCINT,
+	AMS_SEQ_VCCBRAM,
+	AMS_SEQ_VCCAUX,
+	AMS_SEQ_PSDDRPLL,
+	AMS_SEQ_INTDDR
+};
+
+enum ams_ps_pl_seq {
+	AMS_SEQ_CALIB,
+	AMS_SEQ_RSVD_1,
+	AMS_SEQ_RSVD_2,
+	AMS_SEQ_TEST,
+	AMS_SEQ_RSVD_4,
+	AMS_SEQ_SUPPLY4,
+	AMS_SEQ_SUPPLY5,
+	AMS_SEQ_SUPPLY6,
+	AMS_SEQ_TEMP,
+	AMS_SEQ_SUPPLY2,
+	AMS_SEQ_SUPPLY1,
+	AMS_SEQ_VP_VN,
+	AMS_SEQ_VREFP,
+	AMS_SEQ_VREFN,
+	AMS_SEQ_SUPPLY3,
+	AMS_SEQ_CURRENT_MON,
+	AMS_SEQ_SUPPLY7,
+	AMS_SEQ_SUPPLY8,
+	AMS_SEQ_SUPPLY9,
+	AMS_SEQ_SUPPLY10,
+	AMS_SEQ_VCCAMS,
+	AMS_SEQ_TEMP_REMOTE,
+	AMS_SEQ_MAX
+};
+
+#define AMS_SEQ(x)		(AMS_SEQ_MAX + (x))
+#define AMS_VAUX_SEQ(x)		(AMS_SEQ_MAX + (x))
+
+#define AMS_PS_SEQ_MAX		AMS_SEQ_MAX
+#define PS_SEQ(x)		(x)
+#define PL_SEQ(x)		(AMS_PS_SEQ_MAX + (x))
+
+#define AMS_CHAN_TEMP(_scan_index, _addr) { \
+	.type = IIO_TEMP, \
+	.indexed = 1, \
+	.address = (_addr), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_OFFSET), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.event_spec = ams_temp_events, \
+	.scan_index = _scan_index, \
+	.num_event_specs = ARRAY_SIZE(ams_temp_events), \
+}
+
+#define AMS_CHAN_VOLTAGE(_scan_index, _addr, _alarm) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.address = (_addr), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+		BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.event_spec = (_alarm) ? ams_voltage_events : NULL, \
+	.scan_index = _scan_index, \
+	.num_event_specs = (_alarm) ? ARRAY_SIZE(ams_voltage_events) : 0, \
+}
+
+#define AMS_PS_CHAN_TEMP(_scan_index, _addr) \
+	AMS_CHAN_TEMP(PS_SEQ(_scan_index), _addr)
+#define AMS_PS_CHAN_VOLTAGE(_scan_index, _addr) \
+	AMS_CHAN_VOLTAGE(PS_SEQ(_scan_index), _addr, true)
+
+#define AMS_PL_CHAN_TEMP(_scan_index, _addr) \
+	AMS_CHAN_TEMP(PL_SEQ(_scan_index), _addr)
+#define AMS_PL_CHAN_VOLTAGE(_scan_index, _addr, _alarm) \
+	AMS_CHAN_VOLTAGE(PL_SEQ(_scan_index), _addr, _alarm)
+#define AMS_PL_AUX_CHAN_VOLTAGE(_auxno) \
+	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(_auxno)), \
+			AMS_REG_VAUX(_auxno), false)
+#define AMS_CTRL_CHAN_VOLTAGE(_scan_index, _addr) \
+	AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(AMS_SEQ(_scan_index))), \
+			_addr, false)
+
+/**
+ * struct ams - Driver data for xilinx-ams
+ * @base: physical base address of device
+ * @ps_base: physical base address of PS device
+ * @pl_base: physical base address of PL device
+ * @clk: clocks associated with the device
+ * @dev: pointer to device struct
+ * @lock: to handle multiple user interaction
+ * @intr_lock: to protect interrupt mask values
+ * @masked_alarm: currently masked due to alarm
+ * @alarm_mask: alarm configuration
+ * @interrupt_mask: interrupt configuration
+ * @irq: interrupt number of the sysmon
+ * @ams_unmask_work: re-enables event once the event condition disappears
+ *
+ * This structure contains necessary state for Sysmon driver to operate
+ */
+struct ams {
+	void __iomem *base;
+	void __iomem *ps_base;
+	void __iomem *pl_base;
+	struct clk *clk;
+	struct device *dev;
+	/* check kernel doc above */
+	struct mutex lock;
+	/* check kernel doc above */
+	spinlock_t intr_lock;
+	unsigned int alarm_mask;
+	unsigned int masked_alarm;
+	u64 intr_mask;
+	int irq;
+	struct delayed_work ams_unmask_work;
+};
+
+static inline void ams_ps_update_reg(struct ams *ams, unsigned int offset,
+				     u32 mask, u32 data)
+{
+	u32 val;
+
+	val = readl(ams->ps_base + offset);
+	writel((val & ~mask) | (data & mask), ams->ps_base + offset);
+}
+
+static inline void ams_pl_update_reg(struct ams *ams, unsigned int offset,
+				     u32 mask, u32 data)
+{
+	u32 val;
+
+	val = readl(ams->pl_base + offset);
+	writel((val & ~mask) | (data & mask), ams->pl_base + offset);
+}
+
+static void ams_update_intrmask(struct ams *ams, u64 mask, u64 val)
+{
+	ams->intr_mask &= ~mask;
+	ams->intr_mask |= (val & mask);
+
+	writel(~(ams->intr_mask | ams->masked_alarm), ams->base + AMS_IER_0);
+	writel(~(FIELD_GET(AMS_ISR1_INTR_MASK, ams->intr_mask)),
+	       ams->base + AMS_IER_1);
+	writel(ams->intr_mask | ams->masked_alarm, ams->base + AMS_IDR_0);
+	writel(FIELD_GET(AMS_ISR1_INTR_MASK, ams->intr_mask),
+	       ams->base + AMS_IDR_1);
+}
+
+static void ams_disable_all_alarms(struct ams *ams)
+{
+	/* disable PS module alarm */
+	if (ams->ps_base) {
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
+				  AMS_REGCFG1_ALARM_MASK);
+		ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
+				  AMS_REGCFG3_ALARM_MASK);
+	}
+
+	/* disable PL module alarm */
+	if (ams->pl_base) {
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1,
+				  AMS_REGCFG1_ALARM_MASK,
+				  AMS_REGCFG1_ALARM_MASK);
+		ams_pl_update_reg(ams, AMS_REG_CONFIG3,
+				  AMS_REGCFG3_ALARM_MASK,
+				  AMS_REGCFG3_ALARM_MASK);
+	}
+}
+
+static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
+{
+	u32 cfg;
+	unsigned long pl_alarm_mask;
+	unsigned long flags;
+
+	if (ams->ps_base) {
+		/* Configuring PS alarm enable */
+		cfg = ~((alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
+			       AMS_CONF1_ALARM_2_TO_0_SHIFT);
+		cfg &= ~((alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
+				AMS_CONF1_ALARM_6_TO_3_SHIFT);
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
+				  cfg);
+
+		cfg = ~((alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
+				AMS_ISR0_ALARM_12_TO_7_MASK);
+		ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
+				  cfg);
+	}
+
+	if (ams->pl_base) {
+		pl_alarm_mask = (alarm_mask >> AMS_PL_ALARM_START);
+		pl_alarm_mask = FIELD_GET(AMS_PL_ALARM_MASK, alarm_mask);
+		/* Configuring PL alarm enable */
+		cfg = ~((pl_alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
+			AMS_CONF1_ALARM_2_TO_0_SHIFT);
+		cfg &= ~((pl_alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
+			 AMS_CONF1_ALARM_6_TO_3_SHIFT);
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1,
+				  AMS_REGCFG1_ALARM_MASK, cfg);
+
+		cfg = ~((pl_alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
+			AMS_ISR0_ALARM_12_TO_7_MASK);
+		ams_pl_update_reg(ams, AMS_REG_CONFIG3,
+				  AMS_REGCFG3_ALARM_MASK, cfg);
+	}
+
+	spin_lock_irqsave(&ams->intr_lock, flags);
+	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
+	spin_unlock_irqrestore(&ams->intr_lock, flags);
+}
+
+static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
+{
+	int i;
+	unsigned long long scan_mask;
+	struct ams *ams = iio_priv(indio_dev);
+
+	/*
+	 * Enable channel sequence. First 22 bits of scan_mask represent
+	 * PS channels, and next remaining bits represent PL channels.
+	 */
+
+	/* Run calibration of PS & PL as part of the sequence */
+	scan_mask = 0x1 | BIT(AMS_PS_SEQ_MAX);
+	for (i = 0; i < indio_dev->num_channels; i++)
+		scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);
+
+	if (ams->ps_base) {
+		/* put sysmon in a soft reset to change the sequence */
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_DEFAULT);
+
+		/* configure basic channels */
+		writel(FIELD_GET(AMS_REG_SEQ0_MASK, scan_mask),
+		       ams->ps_base + AMS_REG_SEQ_CH0);
+		writel(FIELD_GET(AMS_REG_SEQ2_MASK, scan_mask),
+		       ams->ps_base + AMS_REG_SEQ_CH2);
+
+		/* set continuous sequence mode */
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_CONTINUOUS);
+	}
+
+	if (ams->pl_base) {
+		/* put sysmon in a soft reset to change the sequence */
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_DEFAULT);
+
+		/* configure basic channels */
+		scan_mask = FIELD_GET(AMS_PL_SEQ_MASK, scan_mask);
+		writel(FIELD_GET(AMS_REG_SEQ0_MASK, scan_mask),
+		       ams->pl_base + AMS_REG_SEQ_CH0);
+		writel(FIELD_GET(AMS_REG_SEQ2_MASK, scan_mask),
+		       ams->pl_base + AMS_REG_SEQ_CH2);
+		writel(FIELD_GET(AMS_REG_SEQ1_MASK, scan_mask),
+		       ams->pl_base + AMS_REG_SEQ_CH1);
+
+		/* set continuous sequence mode */
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_CONTINUOUS);
+	}
+}
+
+static int ams_init_device(struct ams *ams)
+{
+	u32 reg;
+	int ret;
+
+	/* reset AMS */
+	if (ams->ps_base) {
+		writel(AMS_PS_RESET_VALUE, ams->ps_base + AMS_VP_VN);
+
+		ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
+					 (reg & AMS_PS_CSTS_PS_READY) ==
+					 AMS_PS_CSTS_PS_READY, 0,
+					 AMS_INIT_TIMEOUT_US);
+		if (ret)
+			return ret;
+
+		/* put sysmon in a default state */
+		ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_DEFAULT);
+	}
+
+	if (ams->pl_base) {
+		writel(AMS_PL_RESET_VALUE, ams->pl_base + AMS_VP_VN);
+
+		ret = readl_poll_timeout(ams->base + AMS_PL_CSTS, reg,
+					 (reg & AMS_PL_CSTS_ACCESS_MASK) ==
+					 AMS_PL_CSTS_ACCESS_MASK, 0,
+					 AMS_INIT_TIMEOUT_US);
+		if (ret)
+			return ret;
+
+		/* put sysmon in a default state */
+		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+				  AMS_CONF1_SEQ_DEFAULT);
+	}
+
+	ams_disable_all_alarms(ams);
+
+	/* Disable interrupt */
+	ams_update_intrmask(ams, ~0, ~0);
+
+	/* Clear any pending interrupt */
+	writel(AMS_ISR0_ALARM_MASK, ams->base + AMS_ISR_0);
+	writel(AMS_ISR1_ALARM_MASK, ams->base + AMS_ISR_1);
+
+	return 0;
+}
+
+static int ams_enable_single_channel(struct ams *ams, unsigned int offset)
+{
+	u8 channel_num = 0;
+
+	switch (offset) {
+	case AMS_VCC_PSPLL0:
+		channel_num = AMS_VCC_PSPLL0_CH;
+		break;
+	case AMS_VCC_PSPLL3:
+		channel_num = AMS_VCC_PSPLL3_CH;
+		break;
+	case AMS_VCCINT:
+		channel_num = AMS_VCCINT_CH;
+		break;
+	case AMS_VCCBRAM:
+		channel_num = AMS_VCCBRAM_CH;
+		break;
+	case AMS_VCCAUX:
+		channel_num = AMS_VCCAUX_CH;
+		break;
+	case AMS_PSDDRPLL:
+		channel_num = AMS_PSDDRPLL_CH;
+		break;
+	case AMS_PSINTFPDDR:
+		channel_num = AMS_PSINTFPDDR_CH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set single channel, sequencer off mode */
+	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
+			  AMS_CONF1_SEQ_SINGLE_CHANNEL);
+
+	/* write the channel number */
+	ams_ps_update_reg(ams, AMS_REG_CONFIG0, AMS_CONF0_CHANNEL_NUM_MASK,
+			  channel_num);
+
+	return 0;
+}
+
+static int ams_read_vcc_reg(struct ams *ams, unsigned int offset, u32 *data)
+{
+	u32 reg;
+	int ret;
+
+	ret = ams_enable_single_channel(ams, offset);
+	if (ret)
+		return ret;
+
+	ret = readl_poll_timeout(ams->base + AMS_ISR_1, reg,
+				 (reg & AMS_ISR1_EOC_MASK) == AMS_ISR1_EOC_MASK,
+				 0, AMS_INIT_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	*data = readl(ams->base + offset);
+
+	return 0;
+}
+
+static int ams_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&ams->lock);
+		if (chan->scan_index >= (AMS_PS_SEQ_MAX * 3)) {
+			ret = ams_read_vcc_reg(ams, chan->address, val);
+			if (ret) {
+				mutex_unlock(&ams->lock);
+				return -EINVAL;
+			}
+			ams_enable_channel_sequence(indio_dev);
+		} else if (chan->scan_index >= AMS_PS_SEQ_MAX)
+			*val = readl(ams->pl_base + chan->address);
+		else
+			*val = readl(ams->ps_base + chan->address);
+		mutex_unlock(&ams->lock);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			switch (chan->address) {
+			case AMS_SUPPLY1:
+			case AMS_SUPPLY2:
+			case AMS_SUPPLY3:
+			case AMS_SUPPLY4:
+				*val = AMS_SUPPLY_SCALE_3VOLT;
+				break;
+			case AMS_SUPPLY5:
+			case AMS_SUPPLY6:
+				if (chan->scan_index < AMS_PS_SEQ_MAX)
+					*val = AMS_SUPPLY_SCALE_6VOLT;
+				else
+					*val = AMS_SUPPLY_SCALE_3VOLT;
+				break;
+			case AMS_SUPPLY7:
+			case AMS_SUPPLY8:
+				*val = AMS_SUPPLY_SCALE_6VOLT;
+				break;
+			case AMS_SUPPLY9:
+			case AMS_SUPPLY10:
+				if (chan->scan_index < AMS_PS_SEQ_MAX)
+					*val = AMS_SUPPLY_SCALE_3VOLT;
+				else
+					*val = AMS_SUPPLY_SCALE_6VOLT;
+				break;
+			case AMS_VCC_PSPLL0:
+			case AMS_VCC_PSPLL3:
+			case AMS_VCCINT:
+			case AMS_VCCBRAM:
+			case AMS_VCCAUX:
+			case AMS_PSDDRPLL:
+			case AMS_PSINTFPDDR:
+				*val = AMS_SUPPLY_SCALE_3VOLT;
+				break;
+			default:
+				*val = AMS_SUPPLY_SCALE_1VOLT;
+				break;
+			}
+			*val2 = AMS_SUPPLY_SCALE_DIV_BIT;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_TEMP:
+			*val = AMS_TEMP_SCALE;
+			*val2 = AMS_TEMP_SCALE_DIV_BIT;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		/* Only the temperature channel has an offset */
+		*val = AMS_TEMP_OFFSET;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
+{
+	int offset = 0;
+
+	if (scan_index >= AMS_PS_SEQ_MAX)
+		scan_index -= AMS_PS_SEQ_MAX;
+
+	if (dir == IIO_EV_DIR_FALLING) {
+		if (scan_index < AMS_SEQ_SUPPLY7)
+			offset = AMS_ALARM_THRESHOLD_OFF_10;
+		else
+			offset = AMS_ALARM_THRESHOLD_OFF_20;
+	}
+
+	switch (scan_index) {
+	case AMS_SEQ_TEMP:
+		return AMS_ALARM_TEMP + offset;
+	case AMS_SEQ_SUPPLY1:
+		return AMS_ALARM_SUPPLY1 + offset;
+	case AMS_SEQ_SUPPLY2:
+		return AMS_ALARM_SUPPLY2 + offset;
+	case AMS_SEQ_SUPPLY3:
+		return AMS_ALARM_SUPPLY3 + offset;
+	case AMS_SEQ_SUPPLY4:
+		return AMS_ALARM_SUPPLY4 + offset;
+	case AMS_SEQ_SUPPLY5:
+		return AMS_ALARM_SUPPLY5 + offset;
+	case AMS_SEQ_SUPPLY6:
+		return AMS_ALARM_SUPPLY6 + offset;
+	case AMS_SEQ_SUPPLY7:
+		return AMS_ALARM_SUPPLY7 + offset;
+	case AMS_SEQ_SUPPLY8:
+		return AMS_ALARM_SUPPLY8 + offset;
+	case AMS_SEQ_SUPPLY9:
+		return AMS_ALARM_SUPPLY9 + offset;
+	case AMS_SEQ_SUPPLY10:
+		return AMS_ALARM_SUPPLY10 + offset;
+	case AMS_SEQ_VCCAMS:
+		return AMS_ALARM_VCCAMS + offset;
+	case AMS_SEQ_TEMP_REMOTE:
+		return AMS_ALARM_TEMP_REMOTE + offset;
+	}
+
+	return 0;
+}
+
+static const struct iio_chan_spec
+*ams_event_to_channel(struct iio_dev *indio_dev, u32 event)
+{
+	int scan_index = 0, i;
+
+	if (event >= AMS_PL_ALARM_START) {
+		event -= AMS_PL_ALARM_START;
+		scan_index = AMS_PS_SEQ_MAX;
+	}
+
+	switch (event) {
+	case AMS_ALARM_BIT_TEMP:
+		scan_index += AMS_SEQ_TEMP;
+		break;
+	case AMS_ALARM_BIT_SUPPLY1:
+		scan_index += AMS_SEQ_SUPPLY1;
+		break;
+	case AMS_ALARM_BIT_SUPPLY2:
+		scan_index += AMS_SEQ_SUPPLY2;
+		break;
+	case AMS_ALARM_BIT_SUPPLY3:
+		scan_index += AMS_SEQ_SUPPLY3;
+		break;
+	case AMS_ALARM_BIT_SUPPLY4:
+		scan_index += AMS_SEQ_SUPPLY4;
+		break;
+	case AMS_ALARM_BIT_SUPPLY5:
+		scan_index += AMS_SEQ_SUPPLY5;
+		break;
+	case AMS_ALARM_BIT_SUPPLY6:
+		scan_index += AMS_SEQ_SUPPLY6;
+		break;
+	case AMS_ALARM_BIT_SUPPLY7:
+		scan_index += AMS_SEQ_SUPPLY7;
+		break;
+	case AMS_ALARM_BIT_SUPPLY8:
+		scan_index += AMS_SEQ_SUPPLY8;
+		break;
+	case AMS_ALARM_BIT_SUPPLY9:
+		scan_index += AMS_SEQ_SUPPLY9;
+		break;
+	case AMS_ALARM_BIT_SUPPLY10:
+		scan_index += AMS_SEQ_SUPPLY10;
+		break;
+	case AMS_ALARM_BIT_VCCAMS:
+		scan_index += AMS_SEQ_VCCAMS;
+		break;
+	case AMS_ALARM_BIT_TEMP_REMOTE:
+		scan_index += AMS_SEQ_TEMP_REMOTE;
+		break;
+	}
+
+	for (i = 0; i < indio_dev->num_channels; i++)
+		if (indio_dev->channels[i].scan_index == scan_index)
+			break;
+
+	return &indio_dev->channels[i];
+}
+
+static int ams_get_alarm_mask(int scan_index)
+{
+	int bit = 0;
+
+	if (scan_index >= AMS_PS_SEQ_MAX) {
+		bit = AMS_PL_ALARM_START;
+		scan_index -= AMS_PS_SEQ_MAX;
+	}
+
+	switch (scan_index) {
+	case AMS_SEQ_TEMP:
+		return BIT(AMS_ALARM_BIT_TEMP + bit);
+	case AMS_SEQ_SUPPLY1:
+		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
+	case AMS_SEQ_SUPPLY2:
+		return BIT(AMS_ALARM_BIT_SUPPLY2 + bit);
+	case AMS_SEQ_SUPPLY3:
+		return BIT(AMS_ALARM_BIT_SUPPLY3 + bit);
+	case AMS_SEQ_SUPPLY4:
+		return BIT(AMS_ALARM_BIT_SUPPLY4 + bit);
+	case AMS_SEQ_SUPPLY5:
+		return BIT(AMS_ALARM_BIT_SUPPLY5 + bit);
+	case AMS_SEQ_SUPPLY6:
+		return BIT(AMS_ALARM_BIT_SUPPLY6 + bit);
+	case AMS_SEQ_SUPPLY7:
+		return BIT(AMS_ALARM_BIT_SUPPLY7 + bit);
+	case AMS_SEQ_SUPPLY8:
+		return BIT(AMS_ALARM_BIT_SUPPLY8 + bit);
+	case AMS_SEQ_SUPPLY9:
+		return BIT(AMS_ALARM_BIT_SUPPLY9 + bit);
+	case AMS_SEQ_SUPPLY10:
+		return BIT(AMS_ALARM_BIT_SUPPLY10 + bit);
+	case AMS_SEQ_VCCAMS:
+		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
+	case AMS_SEQ_TEMP_REMOTE:
+		return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
+	}
+
+	return 0;
+}
+
+static int ams_read_event_config(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir)
+{
+	struct ams *ams = iio_priv(indio_dev);
+
+	return (ams->alarm_mask & ams_get_alarm_mask(chan->scan_index)) ? 1 : 0;
+}
+
+static int ams_write_event_config(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  int state)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	unsigned int alarm;
+
+	alarm = ams_get_alarm_mask(chan->scan_index);
+
+	mutex_lock(&ams->lock);
+
+	if (state)
+		ams->alarm_mask |= alarm;
+	else
+		ams->alarm_mask &= ~alarm;
+
+	ams_update_alarm(ams, ams->alarm_mask);
+
+	mutex_unlock(&ams->lock);
+
+	return 0;
+}
+
+static int ams_read_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info, int *val, int *val2)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
+
+	mutex_lock(&ams->lock);
+
+	if (chan->scan_index >= AMS_PS_SEQ_MAX)
+		*val = readl(ams->pl_base + offset);
+	else
+		*val = readl(ams->ps_base + offset);
+
+	mutex_unlock(&ams->lock);
+
+	return IIO_VAL_INT;
+}
+
+static int ams_write_event_value(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info, int val, int val2)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	unsigned int offset;
+
+	mutex_lock(&ams->lock);
+
+	/* Set temperature channel threshold to direct threshold */
+	if (chan->type == IIO_TEMP) {
+		offset = ams_get_alarm_offset(chan->scan_index,
+					      IIO_EV_DIR_FALLING);
+
+		if (chan->scan_index >= AMS_PS_SEQ_MAX)
+			ams_pl_update_reg(ams, offset,
+					  AMS_ALARM_THR_DIRECT_MASK,
+					  AMS_ALARM_THR_DIRECT_MASK);
+		else
+			ams_ps_update_reg(ams, offset,
+					  AMS_ALARM_THR_DIRECT_MASK,
+					  AMS_ALARM_THR_DIRECT_MASK);
+	}
+
+	offset = ams_get_alarm_offset(chan->scan_index, dir);
+	if (chan->scan_index >= AMS_PS_SEQ_MAX)
+		writel(val, ams->pl_base + offset);
+	else
+		writel(val, ams->ps_base + offset);
+
+	mutex_unlock(&ams->lock);
+
+	return 0;
+}
+
+static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
+{
+	const struct iio_chan_spec *chan;
+
+	chan = ams_event_to_channel(indio_dev, event);
+
+	if (chan->type == IIO_TEMP) {
+		/*
+		 * The temperature channel only supports over-temperature
+		 * events
+		 */
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			iio_get_time_ns(indio_dev));
+	} else {
+		/*
+		 * For other channels we don't know whether it is a upper or
+		 * lower threshold event. Userspace will have to check the
+		 * channel value if it wants to know.
+		 */
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			iio_get_time_ns(indio_dev));
+	}
+}
+
+static void ams_handle_events(struct iio_dev *indio_dev, unsigned long events)
+{
+	unsigned int bit;
+
+	for_each_set_bit(bit, &events, AMS_NO_OF_ALARMS)
+		ams_handle_event(indio_dev, bit);
+}
+
+/**
+ * ams_unmask_worker - ams alarm interrupt unmask worker
+ * @work :		work to be done
+ *
+ * The ZynqMP threshold interrupts are level sensitive. Since we can't make the
+ * threshold condition go way from within the interrupt handler, this means as
+ * soon as a threshold condition is present we would enter the interrupt handler
+ * again and again. To work around this we mask all active threshold interrupts
+ * in the interrupt handler and start a timer. In this timer we poll the
+ * interrupt status and only if the interrupt is inactive we unmask it again.
+ */
+static void ams_unmask_worker(struct work_struct *work)
+{
+	struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
+	unsigned int status, unmask;
+
+	spin_lock_irq(&ams->intr_lock);
+
+	status = readl(ams->base + AMS_ISR_0);
+
+	/* Clear those bits which are not active anymore */
+	unmask = (ams->masked_alarm ^ status) & ams->masked_alarm;
+
+	/* clear status of disabled alarm */
+	unmask |= ams->intr_mask;
+
+	ams->masked_alarm &= status;
+
+	/* Also clear those which are masked out anyway */
+	ams->masked_alarm &= ~ams->intr_mask;
+
+	/* Clear the interrupts before we unmask them */
+	writel(unmask, ams->base + AMS_ISR_0);
+
+	ams_update_intrmask(ams, 0, 0);
+
+	spin_unlock_irq(&ams->intr_lock);
+
+	/* if still pending some alarm re-trigger the timer */
+	if (ams->masked_alarm)
+		schedule_delayed_work(&ams->ams_unmask_work,
+				      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
+}
+
+static irqreturn_t ams_irq(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct ams *ams = iio_priv(indio_dev);
+	u32 isr0;
+
+	spin_lock(&ams->intr_lock);
+
+	isr0 = readl(ams->base + AMS_ISR_0);
+
+	/* only process alarms that are not masked */
+	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->masked_alarm);
+
+	if (!isr0)
+		return IRQ_NONE;
+
+	/* clear interrupt */
+	writel(isr0, ams->base + AMS_ISR_0);
+
+	/* Mask the alarm interrupts until cleared */
+	ams->masked_alarm |= isr0;
+	ams_update_intrmask(ams, 0, 0);
+
+	ams_handle_events(indio_dev, isr0);
+
+	schedule_delayed_work(&ams->ams_unmask_work,
+			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
+
+	spin_unlock(&ams->intr_lock);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_event_spec ams_temp_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+static const struct iio_event_spec ams_voltage_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec ams_ps_channels[] = {
+	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP),
+	AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP_REMOTE, AMS_TEMP_REMOTE),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10),
+	AMS_PS_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS),
+};
+
+static const struct iio_chan_spec ams_pl_channels[] = {
+	AMS_PL_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFP, AMS_VREFP, false),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFN, AMS_VREFN, false),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VP_VN, AMS_VP_VN, false),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, true),
+	AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, true),
+	AMS_PL_AUX_CHAN_VOLTAGE(0),
+	AMS_PL_AUX_CHAN_VOLTAGE(1),
+	AMS_PL_AUX_CHAN_VOLTAGE(2),
+	AMS_PL_AUX_CHAN_VOLTAGE(3),
+	AMS_PL_AUX_CHAN_VOLTAGE(4),
+	AMS_PL_AUX_CHAN_VOLTAGE(5),
+	AMS_PL_AUX_CHAN_VOLTAGE(6),
+	AMS_PL_AUX_CHAN_VOLTAGE(7),
+	AMS_PL_AUX_CHAN_VOLTAGE(8),
+	AMS_PL_AUX_CHAN_VOLTAGE(9),
+	AMS_PL_AUX_CHAN_VOLTAGE(10),
+	AMS_PL_AUX_CHAN_VOLTAGE(11),
+	AMS_PL_AUX_CHAN_VOLTAGE(12),
+	AMS_PL_AUX_CHAN_VOLTAGE(13),
+	AMS_PL_AUX_CHAN_VOLTAGE(14),
+	AMS_PL_AUX_CHAN_VOLTAGE(15),
+};
+
+static const struct iio_chan_spec ams_ctrl_channels[] = {
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSPLL, AMS_VCC_PSPLL0),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSBATT, AMS_VCC_PSPLL3),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCINT, AMS_VCCINT),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCBRAM, AMS_VCCBRAM),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCAUX, AMS_VCCAUX),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_PSDDRPLL, AMS_PSDDRPLL),
+	AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_INTDDR, AMS_PSINTFPDDR),
+};
+
+static int ams_get_ext_chan(struct device_node *chan_node,
+			    struct iio_chan_spec *channels, int num_channels)
+{
+	struct device_node *child;
+	unsigned int reg;
+	int ret;
+
+	for_each_child_of_node(chan_node, child) {
+		ret = of_property_read_u32(child, "reg", &reg);
+		if (ret || reg > (AMS_PL_MAX_EXT_CHANNEL + 30))
+			continue;
+
+		memcpy(&channels[num_channels], &ams_pl_channels[reg +
+		       AMS_PL_MAX_FIXED_CHANNEL - 30], sizeof(*channels));
+
+		if (of_property_read_bool(child, "xlnx,bipolar"))
+			channels[num_channels].scan_type.sign =	's';
+
+		num_channels++;
+	}
+
+	return num_channels;
+}
+
+static int ams_init_module(struct iio_dev *indio_dev, struct device_node *np,
+			   struct iio_chan_spec *channels)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	int num_channels = 0;
+
+	if (of_device_is_compatible(np, "xlnx,zynqmp-ams-ps")) {
+		ams->ps_base = of_iomap(np, 0);
+		if (!ams->ps_base)
+			return -ENXIO;
+
+		/* add PS channels to iio device channels */
+		memcpy(channels + num_channels, ams_ps_channels,
+		       sizeof(ams_ps_channels));
+		num_channels += ARRAY_SIZE(ams_ps_channels);
+	} else if (of_device_is_compatible(np, "xlnx,zynqmp-ams-pl")) {
+		ams->pl_base = of_iomap(np, 0);
+		if (!ams->pl_base)
+			return -ENXIO;
+
+		/* Copy only first 10 fix channels */
+		memcpy(channels + num_channels, ams_pl_channels,
+		       AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
+		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
+
+		num_channels = ams_get_ext_chan(np, channels,
+						num_channels);
+
+	} else if (of_device_is_compatible(np, "xlnx,zynqmp-ams")) {
+		/* add AMS channels to iio device channels */
+		memcpy(channels + num_channels, ams_ctrl_channels,
+		       sizeof(ams_ctrl_channels));
+		num_channels += ARRAY_SIZE(ams_ctrl_channels);
+	} else {
+		return -EINVAL;
+	}
+
+	return num_channels;
+}
+
+static int ams_parse_dt(struct iio_dev *indio_dev, struct platform_device *pdev)
+{
+	struct ams *ams = iio_priv(indio_dev);
+	struct iio_chan_spec *ams_channels, *dev_channels;
+	struct device_node *child_node = NULL, *np = pdev->dev.of_node;
+	int ret, vol_ch_cnt = 0, temp_ch_cnt = 0, i, rising_off, falling_off;
+	unsigned int num_channels = 0;
+
+	/* Initialize buffer for channel specification */
+	ams_channels = kzalloc(sizeof(ams_ps_channels) +
+			       sizeof(ams_pl_channels) +
+			       sizeof(ams_ctrl_channels), GFP_KERNEL);
+	if (!ams_channels)
+		return -ENOMEM;
+
+	if (of_device_is_available(np)) {
+		ret = ams_init_module(indio_dev, np, ams_channels);
+		if (ret < 0)
+			goto err;
+
+		num_channels += ret;
+	}
+
+	for_each_child_of_node(np, child_node) {
+		if (of_device_is_available(child_node)) {
+			ret = ams_init_module(indio_dev, child_node,
+					      ams_channels + num_channels);
+			if (ret < 0)
+				goto err;
+
+			num_channels += ret;
+		}
+	}
+
+	for (i = 0; i < num_channels; i++) {
+		if (ams_channels[i].type == IIO_VOLTAGE)
+			ams_channels[i].channel = vol_ch_cnt++;
+		else
+			ams_channels[i].channel = temp_ch_cnt++;
+
+		if (ams_channels[i].scan_index < (AMS_PS_SEQ_MAX * 3)) {
+			/* set threshold to max and min for each channel */
+			falling_off =
+				ams_get_alarm_offset(ams_channels[i].scan_index,
+						     IIO_EV_DIR_FALLING);
+			rising_off =
+				ams_get_alarm_offset(ams_channels[i].scan_index,
+						     IIO_EV_DIR_RISING);
+			if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
+				writel(AMS_ALARM_THR_MIN,
+				       ams->pl_base + falling_off);
+				writel(AMS_ALARM_THR_MAX,
+				       ams->pl_base + rising_off);
+			} else {
+				writel(AMS_ALARM_THR_MIN,
+				       ams->ps_base + falling_off);
+				writel(AMS_ALARM_THR_MAX,
+				       ams->ps_base + rising_off);
+			}
+		}
+	}
+
+	dev_channels = devm_kzalloc(&pdev->dev, sizeof(*dev_channels) *
+				    num_channels, GFP_KERNEL);
+	if (!dev_channels) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	memcpy(dev_channels, ams_channels,
+	       sizeof(*ams_channels) * num_channels);
+	indio_dev->channels = dev_channels;
+	indio_dev->num_channels = num_channels;
+
+	ret = 0;
+err:
+	kfree(ams_channels);
+
+	return ret;
+}
+
+static const struct iio_info iio_ams_info = {
+	.read_raw = &ams_read_raw,
+	.read_event_config = &ams_read_event_config,
+	.write_event_config = &ams_write_event_config,
+	.read_event_value = &ams_read_event_value,
+	.write_event_value = &ams_write_event_value,
+};
+
+static const struct of_device_id ams_of_match_table[] = {
+	{ .compatible = "xlnx,zynqmp-ams" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ams_of_match_table);
+
+static void ams_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static void ams_cancel_delayed_work(void *data)
+{
+	cancel_delayed_work(data);
+}
+
+static int ams_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct ams *ams;
+	int ret;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ams));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ams = iio_priv(indio_dev);
+	mutex_init(&ams->lock);
+	spin_lock_init(&ams->intr_lock);
+
+	indio_dev->name = "xilinx-ams";
+
+	indio_dev->info = &iio_ams_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ams->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ams->base))
+		return PTR_ERR(ams->base);
+
+	ams->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ams->clk))
+		return PTR_ERR(ams->clk);
+	clk_prepare_enable(ams->clk);
+	devm_add_action_or_reset(&pdev->dev, ams_clk_disable_unprepare,
+				 ams->clk);
+
+	INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
+	devm_add_action_or_reset(&pdev->dev, ams_cancel_delayed_work,
+				 &ams->ams_unmask_work);
+
+	ret = ams_init_device(ams);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize AMS\n");
+		return ret;
+	}
+
+	ret = ams_parse_dt(indio_dev, pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failure in parsing DT\n");
+		return ret;
+	}
+
+	ams_enable_channel_sequence(indio_dev);
+
+	ams->irq = platform_get_irq(pdev, 0);
+	if (ams->irq == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		return ret;
+	}
+
+	ret = devm_request_irq(&pdev->dev, ams->irq, &ams_irq, 0, "ams-irq",
+			       indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register interrupt\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+
+	return ret;
+}
+
+static int __maybe_unused ams_suspend(struct device *dev)
+{
+	struct ams *ams = iio_priv(dev_get_drvdata(dev));
+
+	clk_disable_unprepare(ams->clk);
+
+	return 0;
+}
+
+static int __maybe_unused ams_resume(struct device *dev)
+{
+	struct ams *ams = iio_priv(dev_get_drvdata(dev));
+
+	clk_prepare_enable(ams->clk);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ams_pm_ops, ams_suspend, ams_resume);
+
+static struct platform_driver ams_driver = {
+	.probe = ams_probe,
+	.driver = {
+		.name = "xilinx-ams",
+		.pm = &ams_pm_ops,
+		.of_match_table = ams_of_match_table,
+	},
+};
+module_platform_driver(ams_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Xilinx, Inc.");
-- 
2.17.1

