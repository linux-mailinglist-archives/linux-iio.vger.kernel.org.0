Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913D41F410
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2019 14:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfEOMTZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 May 2019 08:19:25 -0400
Received: from mail-eopbgr800045.outbound.protection.outlook.com ([40.107.80.45]:14220
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727458AbfEOLAe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 May 2019 07:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFz5dJw6Sxbq+eWUel44vT+FSHrZFNLcMoHzWRELTKA=;
 b=jZ6q23RftpapVLSyxEzt91ivQYAgbEFgwJlH4ja5lgnzJbmWPVYgc3FK+feHJt3D8iJ7zSuuKkp5JlKhCzlS0KH/EjUgqPEOgRL0dKB/GonAnOkoFr6a+JEBtyslZg86uKKK44PLwioj7RS6rOzebk/4gqKwuO6MmVPRVF33TPs=
Received: from MWHPR03CA0006.namprd03.prod.outlook.com (10.175.133.144) by
 BN6PR03MB3121.namprd03.prod.outlook.com (10.174.232.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Wed, 15 May 2019 11:00:31 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR03CA0006.outlook.office365.com
 (2603:10b6:300:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Wed, 15 May 2019 11:00:30 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 15 May 2019 11:00:29 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4FB0QjJ019304
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 15 May 2019 04:00:26 -0700
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 15 May 2019 07:00:25 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 1/2] iio: frequency: adf4371: Add support for ADF4371 PLL
Date:   Wed, 15 May 2019 14:00:14 +0300
Message-ID: <1557918014-25614-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(199004)(189003)(336012)(476003)(106002)(305945005)(6306002)(54906003)(426003)(2616005)(5660300002)(478600001)(8676002)(8936002)(6916009)(30864003)(316002)(7636002)(6666004)(356004)(2906002)(70206006)(486006)(36756003)(246002)(14444005)(107886003)(50466002)(186003)(77096007)(47776003)(50226002)(26005)(2351001)(966005)(4326008)(23676004)(2870700001)(7696005)(70586007)(5820100001)(72206003)(44832011)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3121;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 213fa0ec-3c76-4272-3603-08d6d9248bc0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BN6PR03MB3121;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3121:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN6PR03MB312193BBBFEE72D4B160E4C69D090@BN6PR03MB3121.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0038DE95A2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: A6H8aeqTc9EQfGZ4Q1O6+obvGRl6GHBHrclM4+RhNhgpUNYR6C0V+rStZpHw184VFFJ45F0pVsLmm0KXWozrKagjHvIf8Hteysb/9esnu+3Yjd6lqYGsmu/t4D8WLEwZ4A7zMxzYWDTy5VNYvOlVQHoBYM2bFwK12cgTu7PZ4892/Dh0s9heKt6mXkiV/bxs+cFrX7P9bC01Siuz+2jclZROcJvuZIui54UMNEL6bKIbNofBOB0B7o6l/EY/hf5TbNrdKo3zRM+R+a9xQg/RXBtimaT077WK5smNOkixOLffeGTEKMqvUd0irc0uZMA67NJ+aJaD3ET59mdiJtQWPS7bOCOSHnM/dkTYdz9NHqwMJWvZ0CN8TNnR2UZ68QBJ/4Rm5cSqObtfhinP+H45SPt662PofAaQdrTj9Ex79hQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2019 11:00:29.8897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 213fa0ec-3c76-4272-3603-08d6d9248bc0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3121
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
 drivers/iio/frequency/Kconfig   |  10 +
 drivers/iio/frequency/Makefile  |   1 +
 drivers/iio/frequency/adf4371.c | 573 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 584 insertions(+)
 create mode 100644 drivers/iio/frequency/adf4371.c

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
index 0000000..fd968d5
--- /dev/null
+++ b/drivers/iio/frequency/adf4371.c
@@ -0,0 +1,573 @@
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
+#define ADF4371_REG(x) (0x ## x)
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
+#define ADF4371_MAX_MODULUS2		16384
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
+	[ADF4371_CH_RF8] = { ADF4371_REG(25), 2 },
+	[ADF4371_CH_RF16] = { ADF4371_REG(25), 3 },
+	[ADF4371_CH_RF32] = { ADF4371_REG(25), 4 },
+	[ADF4371_CH_RFAUX8] = { ADF4371_REG(72), 3 }
+};
+
+static const struct reg_sequence adf4371_reg_defaults[] = {
+	{ ADF4371_REG(0),  0x18 },
+	{ ADF4371_REG(12), 0x40 },
+	{ ADF4371_REG(1E), 0x48 },
+	{ ADF4371_REG(20), 0x14 },
+	{ ADF4371_REG(22), 0x00 },
+	{ ADF4371_REG(23), 0x00 },
+	{ ADF4371_REG(24), 0x80 },
+	{ ADF4371_REG(25), 0x07 },
+	{ ADF4371_REG(27), 0xC5 },
+	{ ADF4371_REG(28), 0x83 },
+	{ ADF4371_REG(2C), 0x44 },
+	{ ADF4371_REG(2D), 0x11 },
+	{ ADF4371_REG(2E), 0x12 },
+	{ ADF4371_REG(2F), 0x94 },
+	{ ADF4371_REG(32), 0x04 },
+	{ ADF4371_REG(35), 0xFA },
+	{ ADF4371_REG(36), 0x30 },
+	{ ADF4371_REG(39), 0x07 },
+	{ ADF4371_REG(3A), 0x55 },
+	{ ADF4371_REG(3E), 0x0C },
+	{ ADF4371_REG(3F), 0x80 },
+	{ ADF4371_REG(40), 0x50 },
+	{ ADF4371_REG(41), 0x28 },
+	{ ADF4371_REG(47), 0xC0 },
+	{ ADF4371_REG(52), 0xF4 },
+	{ ADF4371_REG(70), 0x03 },
+	{ ADF4371_REG(71), 0x60 },
+	{ ADF4371_REG(72), 0x32 },
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
+	u8 buf[10], int_mode = 0;
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
+	buf[0] = st->integer >> 8;
+	buf[1] = 0x40; /* REG12 default */
+	buf[2] = 0x00;
+	buf[3] = st->fract2 & 0xFF;
+	buf[4] = st->fract2 >> 7;
+	buf[5] = st->fract2 >> 15;
+	buf[6] = ADF4371_FRAC2WORD_L(st->fract2 & 0x7F) |
+		 ADF4371_FRAC1WORD(st->fract1 >> 23);
+	buf[7] = ADF4371_FRAC2WORD_H(st->fract2 >> 7);
+	buf[8] = st->mod2 & 0xFF;
+	buf[9] = ADF4371_MOD2WORD(st->mod2 >> 8);
+
+	ret = regmap_bulk_write(st->regmap, ADF4371_REG(11),
+				buf, ARRAY_SIZE(buf));
+	if (ret < 0)
+		return ret;
+	/*
+	 * The R counter allows the input reference frequency to be
+	 * divided down to produce the reference clock to the PFD
+	 */
+	ret = regmap_write(st->regmap, ADF4371_REG(1F), st->ref_div_factor);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADF4371_REG(24),
+				 ADF4371_RF_DIV_SEL_MSK,
+				 ADF4371_RF_DIV_SEL(st->rf_div_sel));
+	if (ret < 0)
+		return ret;
+
+	cp_bleed = DIV_ROUND_UP(400 * 1750, st->integer * 375);
+	cp_bleed = clamp(cp_bleed, 1U, 255U);
+	ret = regmap_write(st->regmap, ADF4371_REG(26), cp_bleed);
+	if (ret < 0)
+		return ret;
+	/*
+	 * Set to 1 when in INT mode (when FRAC1 = FRAC2 = 0),
+	 * and set to 0 when in FRAC mode.
+	 */
+	if (st->fract1 == 0 && st->fract2 == 0)
+		int_mode = 0x01;
+
+	ret = regmap_write(st->regmap, ADF4371_REG(2B), int_mode);
+	if (ret < 0)
+		return ret;
+
+	return regmap_write(st->regmap, ADF4371_REG(10), st->integer & 0xFF);
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
+		ret = regmap_read(st->regmap, ADF4371_REG(7C), &readval);
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
+	/* Ideally we use IIO_CHAN_INFO_FREQUENCY, but there are
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
+	u8 buf[5];
+	int ret;
+
+	/* Perform a software reset */
+	ret = regmap_write(st->regmap, ADF4371_REG(0), ADF4371_RESET_CMD);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_multi_reg_write(st->regmap, adf4371_reg_defaults,
+				     ARRAY_SIZE(adf4371_reg_defaults));
+	if (ret < 0)
+		return ret;
+
+	/* Set address in ascending order, so the bulk_write() will work */
+	ret = regmap_update_bits(st->regmap, ADF4371_REG(0),
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
+	buf[0] = vco_band_div;
+	buf[1] = timeout & 0xFF;
+	buf[2] = ADF4371_TIMEOUT(timeout >> 8) | 0x04;
+	buf[3] = synth_timeout;
+	buf[4] = ADF4371_VCO_ALC_TOUT(vco_alc_timeout);
+
+	return regmap_bulk_write(st->regmap, ADF4371_REG(30),
+				 buf, ARRAY_SIZE(buf));
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

