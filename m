Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCA729346
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2019 10:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389349AbfEXIka (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 04:40:30 -0400
Received: from mail-eopbgr780089.outbound.protection.outlook.com ([40.107.78.89]:39648
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389281AbfEXIka (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 May 2019 04:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyy1CLhxHJ7n1/U1/x2uB6HYYEAaAE+N4+tB9TyW0Ek=;
 b=MwQfjbN/Zj4Rw78WX4HpLYD+Oy2ALibKzNMSlXh3Gt0Ek/lt0kOISEJ/22UP8LHlmnk5Upx1jMNVkRVLYG7IM8npbVdqMzfhmWdnlCiJps/JldUI1+Fx4mk2xghDhwRudn0w/oAKz8l5jPWElCzamsJvwY0VM/cquvUY7FoBquM=
Received: from BN3PR03CA0090.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::50) by BN3PR03MB2260.namprd03.prod.outlook.com
 (2a01:111:e400:7bb9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.18; Fri, 24 May
 2019 08:40:22 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN3PR03CA0090.outlook.office365.com
 (2a01:111:e400:7a4d::50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16 via Frontend
 Transport; Fri, 24 May 2019 08:40:22 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Fri, 24 May 2019 08:40:22 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4O8eLwD014361
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 24 May 2019 01:40:21 -0700
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 24 May 2019 04:40:21 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 1/2] iio: frequency: adf4371: Add support for ADF4371 PLL
Date:   Fri, 24 May 2019 11:40:10 +0300
Message-ID: <1558687210-2813-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(199004)(189003)(77096007)(26005)(336012)(5820100001)(8676002)(186003)(126002)(486006)(426003)(2616005)(44832011)(476003)(50466002)(4326008)(107886003)(246002)(36756003)(70586007)(23676004)(7696005)(54906003)(70206006)(50226002)(7636002)(305945005)(8936002)(106002)(14444005)(316002)(478600001)(72206003)(6916009)(2351001)(966005)(2906002)(6306002)(47776003)(5660300002)(2870700001)(6666004)(356004)(30864003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2260;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 835d5a03-8d4b-4511-9564-08d6e02375b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BN3PR03MB2260;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2260:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN3PR03MB2260015962770F2194C03AF99D020@BN3PR03MB2260.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0047BC5ADE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: F89y4GRhUR4H0T6xb4wTeuk8xhNfPZTgzyRwyzI/m0p95fUKgYLXsc2bfDdh8dE0D3WSgaplgIAWFZ+VSQ81ULLxp5kZRFqf7ZsK7+Kv1b0DldzgCJJi5+CWH2Buik98h6EadrVVQpoLEElnwgm/SSDVz9q5nS9nkIm/BTK9Ynr57lbENfeh61DwOYLLQ05CUi0DwQH1nMDyX/VoN6WaJzXWTlcvriZsOtT5MC4L4HQ4gPD0eYfytypztUC7BgeMcxQo5BzxMkNd4CDi/yDP530boJzwQSOhOqxca2R/yp+LHk8keQvSAwO0ITX3NLad1r4HlQ+zjTeW5alJvTGB5I849+K3aIFsw8tZ+xbC5njz50mKaPsiGVsCpRkOF2hIsgZFntDnW8LzcFyHbjuiSy+xGGuNji87WuJEkir9RRI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2019 08:40:22.2021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835d5a03-8d4b-4511-9564-08d6e02375b8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2260
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADF4371 is a frequency synthesizer with an integrated voltage
controlled oscillator (VCO) for phase-locked loops (PLLs). The ADF4371
has an integrated VCO with a fundamental output frequency ranging from
4000 MHz to 8000 MHz. In addition, the VCO frequency is connected to
divide by 1, 2, 4, 8, 16, 32, or 64 circuits that allows the user to
generate radio frequency (RF) output frequencies as low as 62.5 MHz at
RF8x. A frequency multiplier at RF16x generates from 8 GHz to 16 GHz. A
frequency quadrupler generates frequencies from 16 GHz to 32 GHz at RF32x.
RFAUX8x duplicates the frequency range of RF8x or permits direct access to
the VCO output.

The driver takes the reference input frequency from the device tree and
uses it to calculate and maximize the PFD frequency (frequency of the phase
frequency detector). The PFD frequency is further used to calculate the
timeouts: synthesizer lock, VCO band selection, automatic level
calibration (ALC) and PLL settling time.

This initial driver exposes the attributes for setting the frequency and
enabling/disabling the different adf4371 channels.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adf4371.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Added a new sysfs-bus-iio-frequency-adf4371 file which documents the ABI
	  changes.
	- Modified the ADF4371_REG() macro to take the reg values in hex as params
	- ADF4371_MAX_MODULUS2 macro is now defined as BIT(14)
	- regmap_bulk_write() can't do DMA directly, so the buffer was forced into
	  it's own cacheline.
	- Fixed the multi line comment style.

 .../ABI/testing/sysfs-bus-iio-frequency-adf4371    |  33 ++
 drivers/iio/frequency/Kconfig                      |  10 +
 drivers/iio/frequency/Makefile                     |   1 +
 drivers/iio/frequency/adf4371.c                    | 572 +++++++++++++++++++++
 4 files changed, 616 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
 create mode 100644 drivers/iio/frequency/adf4371.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
new file mode 100644
index 0000000..37733eb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
@@ -0,0 +1,33 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_rf8_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_rfaux8_frequency
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Stores the PLL frequency in Hz for channels RF8x and RFAUX8x respectively.
+		Reading returns the actual frequency in Hz. RF output frequency range
+		for this channels: 62500000 Hz to 8000000000 Hz. RFAUX8x duplicates the frequency
+		range of RF8x or permits direct access to the VCO output.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_rf16_frequency
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Stores the PLL frequency in Hz for channel RF16x. Reading returns the actual
+		frequency in Hz. RF16 generates frequencies from 8000000000 Hz to 16000000000 Hz
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_rf32_frequency
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Stores the PLL frequency in Hz for channel RF32x. Reading returns the actual
+		frequency in Hz. RF32x generates frequencies from 16000000000 Hz to 32000000000 Hz
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_rf8_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_rfaux8_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_rf16_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_rf32_powerdown
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute allows the user to power down the PLL and it's RFOut buffers.
+		Writing 1 causes the specified channel to power down. Clearing returns to normal operation.
diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index dc5e0b7..e4a921f 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -38,5 +38,15 @@ config ADF4350
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4350.
 
+config ADF4371
+	tristate "Analog Devices ADF4371 Wideband Synthesizer"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices  ADF4371
+	  Wideband Synthesizer. The driver provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adf4371.
 endmenu
 endmenu
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index 2bca03f..2ddda77 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -5,3 +5,4 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
+obj-$(CONFIG_ADF4371) += adf4371.o
diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
new file mode 100644
index 0000000..2f8a9cf
--- /dev/null
+++ b/drivers/iio/frequency/adf4371.c
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices ADF4371 SPI Wideband Synthesizer driver
+ *
+ * Copyright 2019 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gcd.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+
+/* Registers address macro */
+#define ADF4371_REG(x)			(x)
+
+/* ADF4371_REG0 */
+#define ADF4371_ADDR_ASC_MSK		BIT(2)
+#define ADF4371_ADDR_ASC(x)		FIELD_PREP(ADF4371_ADDR_ASC_MSK, x)
+#define ADF4371_ADDR_ASC_R_MSK		BIT(5)
+#define ADF4371_ADDR_ASC_R(x)		FIELD_PREP(ADF4371_ADDR_ASC_R_MSK, x)
+#define ADF4371_RESET_CMD		0x81
+
+/* ADF4371_REG17 */
+#define ADF4371_FRAC2WORD_L_MSK		GENMASK(7, 1)
+#define ADF4371_FRAC2WORD_L(x)		FIELD_PREP(ADF4371_FRAC2WORD_L_MSK, x)
+#define ADF4371_FRAC1WORD_MSK		BIT(0)
+#define ADF4371_FRAC1WORD(x)		FIELD_PREP(ADF4371_FRAC1WORD_MSK, x)
+
+/* ADF4371_REG18 */
+#define ADF4371_FRAC2WORD_H_MSK		GENMASK(6, 0)
+#define ADF4371_FRAC2WORD_H(x)		FIELD_PREP(ADF4371_FRAC2WORD_H_MSK, x)
+
+/* ADF4371_REG1A */
+#define ADF4371_MOD2WORD_MSK		GENMASK(5, 0)
+#define ADF4371_MOD2WORD(x)		FIELD_PREP(ADF4371_MOD2WORD_MSK, x)
+
+/* ADF4371_REG24 */
+#define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
+#define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x)
+
+/* ADF4371_REG32 */
+#define ADF4371_TIMEOUT_MSK		GENMASK(1, 0)
+#define ADF4371_TIMEOUT(x)		FIELD_PREP(ADF4371_TIMEOUT_MSK, x)
+
+/* ADF4371_REG34 */
+#define ADF4371_VCO_ALC_TOUT_MSK	GENMASK(4, 0)
+#define ADF4371_VCO_ALC_TOUT(x)		FIELD_PREP(ADF4371_VCO_ALC_TOUT_MSK, x)
+
+/* Specifications */
+#define ADF4371_MIN_VCO_FREQ		4000000000ULL /* 4000 MHz */
+#define ADF4371_MAX_VCO_FREQ		8000000000ULL /* 8000 MHz */
+#define ADF4371_MAX_OUT_RF8_FREQ	ADF4371_MAX_VCO_FREQ /* Hz */
+#define ADF4371_MIN_OUT_RF8_FREQ	(ADF4371_MIN_VCO_FREQ / 64) /* Hz */
+#define ADF4371_MAX_OUT_RF16_FREQ	(ADF4371_MAX_VCO_FREQ * 2) /* Hz */
+#define ADF4371_MIN_OUT_RF16_FREQ	(ADF4371_MIN_VCO_FREQ * 2) /* Hz */
+#define ADF4371_MAX_OUT_RF32_FREQ	(ADF4371_MAX_VCO_FREQ * 4) /* Hz */
+#define ADF4371_MIN_OUT_RF32_FREQ	(ADF4371_MIN_VCO_FREQ * 4) /* Hz */
+
+#define ADF4371_MAX_FREQ_PFD		250000000UL /* Hz */
+#define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
+
+/* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
+#define ADF4371_MODULUS1		33554432ULL
+/* MOD2 is the programmable, 14-bit auxiliary fractional modulus */
+#define ADF4371_MAX_MODULUS2		BIT(14)
+
+#define ADF4371_CHECK_RANGE(freq, range) \
+	((freq > ADF4371_MAX_ ## range) || (freq < ADF4371_MIN_ ## range))
+
+enum {
+	ADF4371_FREQ,
+	ADF4371_POWER_DOWN
+};
+
+enum {
+	ADF4371_CH_RF8,
+	ADF4371_CH_RF16,
+	ADF4371_CH_RF32,
+	ADF4371_CH_RFAUX8
+};
+
+struct adf4371_pwrdown {
+	unsigned int reg;
+	unsigned int bit;
+};
+
+static const struct adf4371_pwrdown adf4371_pwrdown_ch[4] = {
+	[ADF4371_CH_RF8] = { ADF4371_REG(0x25), 2 },
+	[ADF4371_CH_RF16] = { ADF4371_REG(0x25), 3 },
+	[ADF4371_CH_RF32] = { ADF4371_REG(0x25), 4 },
+	[ADF4371_CH_RFAUX8] = { ADF4371_REG(0x72), 3 }
+};
+
+static const struct reg_sequence adf4371_reg_defaults[] = {
+	{ ADF4371_REG(0x0),  0x18 },
+	{ ADF4371_REG(0x12), 0x40 },
+	{ ADF4371_REG(0x1E), 0x48 },
+	{ ADF4371_REG(0x20), 0x14 },
+	{ ADF4371_REG(0x22), 0x00 },
+	{ ADF4371_REG(0x23), 0x00 },
+	{ ADF4371_REG(0x24), 0x80 },
+	{ ADF4371_REG(0x25), 0x07 },
+	{ ADF4371_REG(0x27), 0xC5 },
+	{ ADF4371_REG(0x28), 0x83 },
+	{ ADF4371_REG(0x2C), 0x44 },
+	{ ADF4371_REG(0x2D), 0x11 },
+	{ ADF4371_REG(0x2E), 0x12 },
+	{ ADF4371_REG(0x2F), 0x94 },
+	{ ADF4371_REG(0x32), 0x04 },
+	{ ADF4371_REG(0x35), 0xFA },
+	{ ADF4371_REG(0x36), 0x30 },
+	{ ADF4371_REG(0x39), 0x07 },
+	{ ADF4371_REG(0x3A), 0x55 },
+	{ ADF4371_REG(0x3E), 0x0C },
+	{ ADF4371_REG(0x3F), 0x80 },
+	{ ADF4371_REG(0x40), 0x50 },
+	{ ADF4371_REG(0x41), 0x28 },
+	{ ADF4371_REG(0x47), 0xC0 },
+	{ ADF4371_REG(0x52), 0xF4 },
+	{ ADF4371_REG(0x70), 0x03 },
+	{ ADF4371_REG(0x71), 0x60 },
+	{ ADF4371_REG(0x72), 0x32 },
+};
+
+static const struct regmap_config adf4371_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+};
+
+struct adf4371_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct clk *clkin;
+	struct mutex lock;
+	unsigned long clkin_freq;
+	unsigned long fpfd;
+	unsigned int integer;
+	unsigned int fract1;
+	unsigned int fract2;
+	unsigned int mod2;
+	unsigned int rf_div_sel;
+	unsigned int ref_div_factor;
+	u8 buf[10] ____cacheline_aligned;
+};
+
+static unsigned long long adf4371_pll_fract_n_get_rate(struct adf4371_state *st,
+						       u32 channel)
+{
+	unsigned long long val, tmp;
+	unsigned int ref_div_sel;
+
+	val = (((u64)st->integer * ADF4371_MODULUS1) + st->fract1) * st->fpfd;
+	tmp = (u64)st->fract2 * st->fpfd;
+	do_div(tmp, st->mod2);
+	val += tmp + ADF4371_MODULUS1 / 2;
+
+	if (channel == ADF4371_CH_RF8 || channel == ADF4371_CH_RFAUX8)
+		ref_div_sel = st->rf_div_sel;
+	else
+		ref_div_sel = 0;
+
+	do_div(val, ADF4371_MODULUS1 * (1 << ref_div_sel));
+
+	if (channel == ADF4371_CH_RF16)
+		val <<= 1;
+	else if (channel == ADF4371_CH_RF32)
+		val <<= 2;
+
+	return val;
+}
+
+static void adf4371_pll_fract_n_compute(unsigned long long vco,
+				       unsigned long long pfd,
+				       unsigned int *integer,
+				       unsigned int *fract1,
+				       unsigned int *fract2,
+				       unsigned int *mod2)
+{
+	unsigned long long tmp;
+	u32 gcd_div;
+
+	tmp = do_div(vco, pfd);
+	tmp = tmp * ADF4371_MODULUS1;
+	*fract2 = do_div(tmp, pfd);
+
+	*integer = vco;
+	*fract1 = tmp;
+
+	*mod2 = pfd;
+
+	while (*mod2 > ADF4371_MAX_MODULUS2) {
+		*mod2 >>= 1;
+		*fract2 >>= 1;
+	}
+
+	gcd_div = gcd(*fract2, *mod2);
+	*mod2 /= gcd_div;
+	*fract2 /= gcd_div;
+}
+
+static int adf4371_set_freq(struct adf4371_state *st, unsigned long long freq,
+			    unsigned int channel)
+{
+	u32 cp_bleed;
+	u8 int_mode = 0;
+	int ret;
+
+	switch (channel) {
+	case ADF4371_CH_RF8:
+	case ADF4371_CH_RFAUX8:
+		if (ADF4371_CHECK_RANGE(freq, OUT_RF8_FREQ))
+			return -EINVAL;
+
+		st->rf_div_sel = 0;
+
+		while (freq < ADF4371_MIN_VCO_FREQ) {
+			freq <<= 1;
+			st->rf_div_sel++;
+		}
+		break;
+	case ADF4371_CH_RF16:
+		/* ADF4371 RF16 8000...16000 MHz */
+		if (ADF4371_CHECK_RANGE(freq, OUT_RF16_FREQ))
+			return -EINVAL;
+
+		freq >>= 1;
+		break;
+	case ADF4371_CH_RF32:
+		/* ADF4371 RF32 16000...32000 MHz */
+		if (ADF4371_CHECK_RANGE(freq, OUT_RF32_FREQ))
+			return -EINVAL;
+
+		freq >>= 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	adf4371_pll_fract_n_compute(freq, st->fpfd, &st->integer, &st->fract1,
+				    &st->fract2, &st->mod2);
+	st->buf[0] = st->integer >> 8;
+	st->buf[1] = 0x40; /* REG12 default */
+	st->buf[2] = 0x00;
+	st->buf[3] = st->fract2 & 0xFF;
+	st->buf[4] = st->fract2 >> 7;
+	st->buf[5] = st->fract2 >> 15;
+	st->buf[6] = ADF4371_FRAC2WORD_L(st->fract2 & 0x7F) |
+		     ADF4371_FRAC1WORD(st->fract1 >> 23);
+	st->buf[7] = ADF4371_FRAC2WORD_H(st->fract2 >> 7);
+	st->buf[8] = st->mod2 & 0xFF;
+	st->buf[9] = ADF4371_MOD2WORD(st->mod2 >> 8);
+
+	ret = regmap_bulk_write(st->regmap, ADF4371_REG(0x11), st->buf, 10);
+	if (ret < 0)
+		return ret;
+	/*
+	 * The R counter allows the input reference frequency to be
+	 * divided down to produce the reference clock to the PFD
+	 */
+	ret = regmap_write(st->regmap, ADF4371_REG(0x1F), st->ref_div_factor);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADF4371_REG(0x24),
+				 ADF4371_RF_DIV_SEL_MSK,
+				 ADF4371_RF_DIV_SEL(st->rf_div_sel));
+	if (ret < 0)
+		return ret;
+
+	cp_bleed = DIV_ROUND_UP(400 * 1750, st->integer * 375);
+	cp_bleed = clamp(cp_bleed, 1U, 255U);
+	ret = regmap_write(st->regmap, ADF4371_REG(0x26), cp_bleed);
+	if (ret < 0)
+		return ret;
+	/*
+	 * Set to 1 when in INT mode (when FRAC1 = FRAC2 = 0),
+	 * and set to 0 when in FRAC mode.
+	 */
+	if (st->fract1 == 0 && st->fract2 == 0)
+		int_mode = 0x01;
+
+	ret = regmap_write(st->regmap, ADF4371_REG(0x2B), int_mode);
+	if (ret < 0)
+		return ret;
+
+	return regmap_write(st->regmap, ADF4371_REG(0x10), st->integer & 0xFF);
+}
+
+static ssize_t adf4371_read(struct iio_dev *indio_dev,
+			    uintptr_t private,
+			    const struct iio_chan_spec *chan,
+			    char *buf)
+{
+	struct adf4371_state *st = iio_priv(indio_dev);
+	unsigned long long val = 0;
+	unsigned int readval, reg, bit;
+	int ret;
+
+	switch ((u32)private) {
+	case ADF4371_FREQ:
+		val = adf4371_pll_fract_n_get_rate(st, chan->channel);
+		ret = regmap_read(st->regmap, ADF4371_REG(0x7C), &readval);
+		if (ret < 0)
+			break;
+
+		if (readval == 0x00) {
+			dev_dbg(&st->spi->dev, "PLL un-locked\n");
+			ret = -EBUSY;
+		}
+		break;
+	case ADF4371_POWER_DOWN:
+		reg = adf4371_pwrdown_ch[chan->channel].reg;
+		bit = adf4371_pwrdown_ch[chan->channel].bit;
+
+		ret = regmap_read(st->regmap, reg, &readval);
+		if (ret < 0)
+			break;
+
+		val = !(readval & BIT(bit));
+		break;
+	default:
+		ret = -EINVAL;
+		val = 0;
+		break;
+	}
+
+	return ret < 0 ? ret : sprintf(buf, "%llu\n", val);
+}
+
+static ssize_t adf4371_write(struct iio_dev *indio_dev,
+			     uintptr_t private,
+			     const struct iio_chan_spec *chan,
+			     const char *buf, size_t len)
+{
+	struct adf4371_state *st = iio_priv(indio_dev);
+	unsigned long long readin;
+	unsigned int bit, readval, reg;
+	int ret;
+
+	ret = kstrtoull(buf, 10, &readin);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+	switch ((u32)private) {
+	case ADF4371_FREQ:
+		ret = adf4371_set_freq(st, readin, chan->channel);
+		break;
+	case ADF4371_POWER_DOWN:
+		reg = adf4371_pwrdown_ch[chan->channel].reg;
+		bit = adf4371_pwrdown_ch[chan->channel].bit;
+		ret = regmap_read(st->regmap, reg, &readval);
+		if (ret < 0)
+			break;
+
+		readval &= ~BIT(bit);
+		readval |= (!readin << bit);
+
+		ret = regmap_write(st->regmap, reg, readval);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	mutex_unlock(&st->lock);
+
+	return ret ? ret : len;
+}
+
+#define _ADF4371_EXT_INFO(_name, _ident) { \
+		.name = _name, \
+		.read = adf4371_read, \
+		.write = adf4371_write, \
+		.private = _ident, \
+		.shared = IIO_SEPARATE, \
+}
+
+static const struct iio_chan_spec_ext_info adf4371_ext_info[] = {
+	/*
+	 * Ideally we use IIO_CHAN_INFO_FREQUENCY, but there are
+	 * values > 2^32 in order to support the entire frequency range
+	 * in Hz. Using scale is a bit ugly.
+	 */
+	_ADF4371_EXT_INFO("frequency", ADF4371_FREQ),
+	_ADF4371_EXT_INFO("powerdown", ADF4371_POWER_DOWN),
+	{ },
+};
+
+#define ADF4371_CHANNEL(_name, index) { \
+		.type = IIO_ALTVOLTAGE, \
+		.output = 1, \
+		.channel = index, \
+		.ext_info = adf4371_ext_info, \
+		.extend_name = _name, \
+	}
+
+static const struct iio_chan_spec adf4371_chan[] = {
+	ADF4371_CHANNEL("rf8", ADF4371_CH_RF8),
+	ADF4371_CHANNEL("rf16", ADF4371_CH_RF16),
+	ADF4371_CHANNEL("rf32", ADF4371_CH_RF32),
+	ADF4371_CHANNEL("rfaux8", ADF4371_CH_RFAUX8),
+};
+
+static int adf4371_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct adf4371_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_info adf4371_info = {
+	.debugfs_reg_access = &adf4371_reg_access,
+};
+
+static int adf4371_setup(struct adf4371_state *st)
+{
+	unsigned int synth_timeout = 2, timeout = 1, vco_alc_timeout = 1;
+	unsigned int vco_band_div, tmp;
+	int ret;
+
+	/* Perform a software reset */
+	ret = regmap_write(st->regmap, ADF4371_REG(0x0), ADF4371_RESET_CMD);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_multi_reg_write(st->regmap, adf4371_reg_defaults,
+				     ARRAY_SIZE(adf4371_reg_defaults));
+	if (ret < 0)
+		return ret;
+
+	/* Set address in ascending order, so the bulk_write() will work */
+	ret = regmap_update_bits(st->regmap, ADF4371_REG(0x0),
+				 ADF4371_ADDR_ASC_MSK | ADF4371_ADDR_ASC_R_MSK,
+				 ADF4371_ADDR_ASC(1) | ADF4371_ADDR_ASC_R(1));
+	if (ret < 0)
+		return ret;
+	/*
+	 * Calculate and maximize PFD frequency
+	 * fPFD = REFIN × ((1 + D)/(R × (1 + T)))
+	 * Where D is the REFIN doubler bit, T is the reference divide by 2,
+	 * R is the reference division factor
+	 * TODO: it is assumed D and T equal 0.
+	 */
+	do {
+		st->ref_div_factor++;
+		st->fpfd = st->clkin_freq / st->ref_div_factor;
+	} while (st->fpfd > ADF4371_MAX_FREQ_PFD);
+
+	/* Calculate Timeouts */
+	vco_band_div = DIV_ROUND_UP(st->fpfd, 2400000U);
+
+	tmp = DIV_ROUND_CLOSEST(st->fpfd, 1000000U);
+	do {
+		timeout++;
+		if (timeout > 1023) {
+			timeout = 2;
+			synth_timeout++;
+		}
+	} while (synth_timeout * 1024 + timeout <= 20 * tmp);
+
+	do {
+		vco_alc_timeout++;
+	} while (vco_alc_timeout * 1024 - timeout <= 50 * tmp);
+
+	st->buf[0] = vco_band_div;
+	st->buf[1] = timeout & 0xFF;
+	st->buf[2] = ADF4371_TIMEOUT(timeout >> 8) | 0x04;
+	st->buf[3] = synth_timeout;
+	st->buf[4] = ADF4371_VCO_ALC_TOUT(vco_alc_timeout);
+
+	return regmap_bulk_write(st->regmap, ADF4371_REG(0x30), st->buf, 5);
+}
+
+static void adf4371_clk_disable(void *data)
+{
+	struct adf4371_state *st = data;
+
+	clk_disable_unprepare(st->clkin);
+}
+
+static int adf4371_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adf4371_state *st;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_spi(spi, &adf4371_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+	st->regmap = regmap;
+	mutex_init(&st->lock);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &adf4371_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adf4371_chan;
+	indio_dev->num_channels = ARRAY_SIZE(adf4371_chan);
+
+	st->clkin = devm_clk_get(&spi->dev, "clkin");
+	if (IS_ERR(st->clkin))
+		return PTR_ERR(st->clkin);
+
+	ret = clk_prepare_enable(st->clkin);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, adf4371_clk_disable, st);
+	if (ret)
+		return ret;
+
+	st->clkin_freq = clk_get_rate(st->clkin);
+
+	ret = adf4371_setup(st);
+	if (ret < 0) {
+		dev_err(&spi->dev, "ADF4371 setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id adf4371_id_table[] = {
+	{ "adf4371", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adf4371_id_table);
+
+static const struct of_device_id adf4371_of_match[] = {
+	{ .compatible = "adi,adf4371" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adf4371_of_match);
+
+static struct spi_driver adf4371_driver = {
+	.driver = {
+		.name = "adf4371",
+		.of_match_table = adf4371_of_match,
+	},
+	.probe = adf4371_probe,
+	.id_table = adf4371_id_table,
+};
+module_spi_driver(adf4371_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADF4371 SPI PLL");
+MODULE_LICENSE("GPL");
-- 
2.7.4

