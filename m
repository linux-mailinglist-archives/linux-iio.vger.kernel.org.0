Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EB73FDA68
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbhIAMcJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61559 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244079AbhIAMbd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499436; x=1662035436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YjonSAGVh87Uwu3HpELIMjgI9nuSRZM1eb5EHylcRlg=;
  b=RLPy1wxovPgaeZbrqngXKjvHO0vTElF6df7/6UoNVLGkQR2zRLrsnvuR
   kWmC/qn1JGixXA1UvNyCdUMtLnJcMra6DAWlVmqQFuLESUhZiiMLHwbJi
   2Q1SHzJH/9WKXdok+lIRfiA5hIOPPsa1gziWeM3C580HY1nMBzvMXzvIu
   kiy3RYTPppQEtXqObAwpphZ+XTFg04DAvYIz/gTgdX85LJq0NTk3+Xvks
   63GWGLQ134dcBBN+lDbP1/E21h6Us/mEEvnBpTIirlxcf40BwIvJZ/NZf
   CyFmNckqo7aV0DSe6nA9seP4Dnqqs9wf5wMlplWMMT/HVQUfaNnrpZ5h2
   A==;
IronPort-SDR: DG++5L5s5MoBlxM5EBmuSiYuy81QurFAFHTCoZ1YNXotubEAPEbgxkd+nd/Ovma3wAcDxXWp6+
 hgFp3fG0zymnCc7NS47gMJkjDq2sNDd7TfGEAagRMTUdTX2CTSwHGwcFk0sDNGc5f/lNqxAcvt
 P5dyuKLgIe6fVk6Tzs57cFG2r9RSDwgUONWQPmoOQfNDjFoQEuJpglKRPqyc+GpPwSSb9PypLI
 FsCeQCJMKwZPOT6qMfp9loKQ3tCMj90V0deOsx/l6a2p/2AQe5x07C1qgP2rHhqP+9ONBK+MKz
 9VGpLCZ/pU2QEyyNL2vRmqcv
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="67859426"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:35 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:32 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 04/10] iio: adc: at91-sama5d2_adc: convert to platform specific data structures
Date:   Wed, 1 Sep 2021 15:30:07 +0300
Message-ID: <20210901123013.329792-5-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the driver to platform specific structures. This means:
- create a register layout struct that will hold offsets for registers
- create a platform struct that will hold platform information (number of
channels, indexes for different channels and pointer to layout struct)
- convert specific macros that are platform dependent into platform variables

This step is in fact a no-op, but allows the driver to be more flexible
and for future enhancement including adding new platforms that are partly
compatible with the current driver and differ slightly in register layout
or capabilities for example.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v3:
- fixed robot reported warning at uninitialized 'val' variable
- added max_index in platform struct to hold maximum index in the channels list
- fixed the indexes for differential, timestamp, and touchscreen channels
(version 2 broke this compared to current driver ABI )


 drivers/iio/adc/at91-sama5d2_adc.c | 417 +++++++++++++++++------------
 1 file changed, 253 insertions(+), 164 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 9d71dcffcf93..d81e16f13b3b 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -27,8 +27,9 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
 
+struct at91_adc_reg_layout {
 /* Control Register */
-#define AT91_SAMA5D2_CR		0x00
+	u16				CR;
 /* Software Reset */
 #define	AT91_SAMA5D2_CR_SWRST		BIT(0)
 /* Start Conversion */
@@ -39,7 +40,7 @@
 #define	AT91_SAMA5D2_CR_CMPRST		BIT(4)
 
 /* Mode Register */
-#define AT91_SAMA5D2_MR		0x04
+	u16				MR;
 /* Trigger Selection */
 #define	AT91_SAMA5D2_MR_TRGSEL(v)	((v) << 1)
 /* ADTRG */
@@ -82,19 +83,19 @@
 #define	AT91_SAMA5D2_MR_USEQ		BIT(31)
 
 /* Channel Sequence Register 1 */
-#define AT91_SAMA5D2_SEQR1	0x08
+	u16				SEQR1;
 /* Channel Sequence Register 2 */
-#define AT91_SAMA5D2_SEQR2	0x0c
+	u16				SEQR2;
 /* Channel Enable Register */
-#define AT91_SAMA5D2_CHER	0x10
+	u16				CHER;
 /* Channel Disable Register */
-#define AT91_SAMA5D2_CHDR	0x14
+	u16				CHDR;
 /* Channel Status Register */
-#define AT91_SAMA5D2_CHSR	0x18
+	u16				CHSR;
 /* Last Converted Data Register */
-#define AT91_SAMA5D2_LCDR	0x20
+	u16				LCDR;
 /* Interrupt Enable Register */
-#define AT91_SAMA5D2_IER	0x24
+	u16				IER;
 /* Interrupt Enable Register - TS X measurement ready */
 #define AT91_SAMA5D2_IER_XRDY   BIT(20)
 /* Interrupt Enable Register - TS Y measurement ready */
@@ -109,22 +110,23 @@
 #define AT91_SAMA5D2_IER_PEN    BIT(29)
 /* Interrupt Enable Register - No pen detect */
 #define AT91_SAMA5D2_IER_NOPEN  BIT(30)
+
 /* Interrupt Disable Register */
-#define AT91_SAMA5D2_IDR	0x28
+	u16				IDR;
 /* Interrupt Mask Register */
-#define AT91_SAMA5D2_IMR	0x2c
+	u16				IMR;
 /* Interrupt Status Register */
-#define AT91_SAMA5D2_ISR	0x30
+	u16				ISR;
 /* Interrupt Status Register - Pen touching sense status */
 #define AT91_SAMA5D2_ISR_PENS   BIT(31)
 /* Last Channel Trigger Mode Register */
-#define AT91_SAMA5D2_LCTMR	0x34
+	u16				LCTMR;
 /* Last Channel Compare Window Register */
-#define AT91_SAMA5D2_LCCWR	0x38
+	u16				LCCWR;
 /* Overrun Status Register */
-#define AT91_SAMA5D2_OVER	0x3c
+	u16				OVER;
 /* Extended Mode Register */
-#define AT91_SAMA5D2_EMR	0x40
+	u16				EMR;
 /* Extended Mode Register - Oversampling rate */
 #define AT91_SAMA5D2_EMR_OSR(V)			((V) << 16)
 #define AT91_SAMA5D2_EMR_OSR_MASK		GENMASK(17, 16)
@@ -134,22 +136,22 @@
 
 /* Extended Mode Register - Averaging on single trigger event */
 #define AT91_SAMA5D2_EMR_ASTE(V)		((V) << 20)
+
 /* Compare Window Register */
-#define AT91_SAMA5D2_CWR	0x44
+	u16				CWR;
 /* Channel Gain Register */
-#define AT91_SAMA5D2_CGR	0x48
-
+	u16				CGR;
 /* Channel Offset Register */
-#define AT91_SAMA5D2_COR	0x4c
+	u16				COR;
 #define AT91_SAMA5D2_COR_DIFF_OFFSET	16
 
 /* Analog Control Register */
-#define AT91_SAMA5D2_ACR	0x94
+	u16				ACR;
 /* Analog Control Register - Pen detect sensitivity mask */
 #define AT91_SAMA5D2_ACR_PENDETSENS_MASK        GENMASK(1, 0)
 
 /* Touchscreen Mode Register */
-#define AT91_SAMA5D2_TSMR	0xb0
+	u16				TSMR;
 /* Touchscreen Mode Register - No touch mode */
 #define AT91_SAMA5D2_TSMR_TSMODE_NONE           0
 /* Touchscreen Mode Register - 4 wire screen, no pressure measurement */
@@ -178,13 +180,13 @@
 #define AT91_SAMA5D2_TSMR_PENDET_ENA            BIT(24)
 
 /* Touchscreen X Position Register */
-#define AT91_SAMA5D2_XPOSR	0xb4
+	u16				XPOSR;
 /* Touchscreen Y Position Register */
-#define AT91_SAMA5D2_YPOSR	0xb8
+	u16				YPOSR;
 /* Touchscreen Pressure Register */
-#define AT91_SAMA5D2_PRESSR	0xbc
+	u16				PRESSR;
 /* Trigger Register */
-#define AT91_SAMA5D2_TRGR	0xc0
+	u16				TRGR;
 /* Mask for TRGMOD field of TRGR register */
 #define AT91_SAMA5D2_TRGR_TRGMOD_MASK GENMASK(2, 0)
 /* No trigger, only software trigger can start conversions */
@@ -203,30 +205,52 @@
 #define AT91_SAMA5D2_TRGR_TRGPER(x)             ((x) << 16)
 
 /* Correction Select Register */
-#define AT91_SAMA5D2_COSR	0xd0
+	u16				COSR;
 /* Correction Value Register */
-#define AT91_SAMA5D2_CVR	0xd4
+	u16				CVR;
 /* Channel Error Correction Register */
-#define AT91_SAMA5D2_CECR	0xd8
+	u16				CECR;
 /* Write Protection Mode Register */
-#define AT91_SAMA5D2_WPMR	0xe4
+	u16				WPMR;
 /* Write Protection Status Register */
-#define AT91_SAMA5D2_WPSR	0xe8
+	u16				WPSR;
 /* Version Register */
-#define AT91_SAMA5D2_VERSION	0xfc
-
-#define AT91_SAMA5D2_HW_TRIG_CNT 3
-#define AT91_SAMA5D2_SINGLE_CHAN_CNT 12
-#define AT91_SAMA5D2_DIFF_CHAN_CNT 6
-
-#define AT91_SAMA5D2_TIMESTAMP_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
-					 AT91_SAMA5D2_DIFF_CHAN_CNT + 1)
+	u16				VERSION;
+};
 
-#define AT91_SAMA5D2_TOUCH_X_CHAN_IDX (AT91_SAMA5D2_SINGLE_CHAN_CNT + \
-					 AT91_SAMA5D2_DIFF_CHAN_CNT * 2)
-#define AT91_SAMA5D2_TOUCH_Y_CHAN_IDX   (AT91_SAMA5D2_TOUCH_X_CHAN_IDX + 1)
-#define AT91_SAMA5D2_TOUCH_P_CHAN_IDX   (AT91_SAMA5D2_TOUCH_Y_CHAN_IDX + 1)
-#define AT91_SAMA5D2_MAX_CHAN_IDX	AT91_SAMA5D2_TOUCH_P_CHAN_IDX
+static const struct at91_adc_reg_layout sama5d2_layout = {
+	.CR =			0x00,
+	.MR =			0x04,
+	.SEQR1 =		0x08,
+	.SEQR2 =		0x0c,
+	.CHER =			0x10,
+	.CHDR =			0x14,
+	.CHSR =			0x18,
+	.LCDR =			0x20,
+	.IER =			0x24,
+	.IDR =			0x28,
+	.IMR =			0x2c,
+	.ISR =			0x30,
+	.LCTMR =		0x34,
+	.LCCWR =		0x38,
+	.OVER =			0x3c,
+	.EMR =			0x40,
+	.CWR =			0x44,
+	.CGR =			0x48,
+	.COR =			0x4c,
+	.ACR =			0x94,
+	.TSMR =			0xb0,
+	.XPOSR =		0xb4,
+	.YPOSR =		0xb8,
+	.PRESSR =		0xbc,
+	.TRGR =			0xc0,
+	.COSR =			0xd0,
+	.CVR =			0xd4,
+	.CECR =			0xd8,
+	.WPMR =			0xe4,
+	.WPSR =			0xe8,
+	.VERSION =		0xfc,
+};
 
 #define AT91_SAMA5D2_TOUCH_SAMPLE_PERIOD_US          2000    /* 2ms */
 #define AT91_SAMA5D2_TOUCH_PEN_DETECT_DEBOUNCE_US    200
@@ -235,18 +259,6 @@
 
 #define AT91_SAMA5D2_MAX_POS_BITS			12
 
-/*
- * Maximum number of bytes to hold conversion from all channels
- * without the timestamp.
- */
-#define AT91_BUFFER_MAX_CONVERSION_BYTES ((AT91_SAMA5D2_SINGLE_CHAN_CNT + \
-					 AT91_SAMA5D2_DIFF_CHAN_CNT) * 2)
-
-/* This total must also include the timestamp */
-#define AT91_BUFFER_MAX_BYTES (AT91_BUFFER_MAX_CONVERSION_BYTES + 8)
-
-#define AT91_BUFFER_MAX_HWORDS (AT91_BUFFER_MAX_BYTES / 2)
-
 #define AT91_HWFIFO_MAX_SIZE_STR	"128"
 #define AT91_HWFIFO_MAX_SIZE		128
 
@@ -255,12 +267,12 @@
 #define AT91_OSR_4SAMPLES		4
 #define AT91_OSR_16SAMPLES		16
 
-#define AT91_SAMA5D2_CHAN_SINGLE(num, addr)				\
+#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
 		.address = addr,					\
-		.scan_index = num,					\
+		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 'u',					\
 			.realbits = 14,					\
@@ -274,14 +286,14 @@
 		.indexed = 1,						\
 	}
 
-#define AT91_SAMA5D2_CHAN_DIFF(num, num2, addr)				\
+#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.differential = 1,					\
 		.channel = num,						\
 		.channel2 = num2,					\
 		.address = addr,					\
-		.scan_index = num + AT91_SAMA5D2_SINGLE_CHAN_CNT,	\
+		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 's',					\
 			.realbits = 14,					\
@@ -328,13 +340,51 @@
 		.datasheet_name = name,					\
 	}
 
-#define at91_adc_readl(st, reg)		readl_relaxed(st->base + reg)
-#define at91_adc_writel(st, reg, val)	writel_relaxed(val, st->base + reg)
+#define at91_adc_readl(st, reg)						\
+	readl_relaxed((st)->base + (st)->soc_info.platform->layout->reg)
+#define at91_adc_read_chan(st, reg)					\
+	readl_relaxed((st)->base + reg)
+#define at91_adc_writel(st, reg, val)					\
+	writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
+
+/**
+ * struct at91_adc_platform - at91-sama5d2 platform information struct
+ * @layout:		pointer to the reg layout struct
+ * @adc_channels:	pointer to an array of channels for registering in
+ *			the iio subsystem
+ * @nr_channels:	number of physical channels available
+ * @touch_chan_x:	index of the touchscreen X channel
+ * @touch_chan_y:	index of the touchscreen Y channel
+ * @touch_chan_p:	index of the touchscreen P channel
+ * @max_channels:	number of total channels
+ * @max_index:		highest channel index (highest index may be higher
+ *			than the total channel number)
+ * @hw_trig_cnt:	number of possible hardware triggers
+ */
+struct at91_adc_platform {
+	const struct at91_adc_reg_layout	*layout;
+	const struct iio_chan_spec		(*adc_channels)[];
+	unsigned int				nr_channels;
+	unsigned int				touch_chan_x;
+	unsigned int				touch_chan_y;
+	unsigned int				touch_chan_p;
+	unsigned int				max_channels;
+	unsigned int				max_index;
+	unsigned int				hw_trig_cnt;
+};
 
+/**
+ * struct at91_adc_soc_info - at91-sama5d2 soc information struct
+ * @startup_time:	device startup time
+ * @min_sample_rate:	minimum sample rate in Hz
+ * @max_sample_rate:	maximum sample rate in Hz
+ * @platform:		pointer to the platform structure
+ */
 struct at91_adc_soc_info {
 	unsigned			startup_time;
 	unsigned			min_sample_rate;
 	unsigned			max_sample_rate;
+	const struct at91_adc_platform	*platform;
 };
 
 struct at91_adc_trigger {
@@ -382,6 +432,15 @@ struct at91_adc_touch {
 	struct work_struct		workq;
 };
 
+/*
+ * Buffer size requirements:
+ * No channels * bytes_per_channel(2) + timestamp bytes (8)
+ * Divided by 2 because we need half words.
+ * We assume 32 channels for now, has to be increased if needed.
+ * Nobody minds a buffer being too big.
+ */
+#define AT91_BUFFER_MAX_HWORDS ((32 * 2 + 8) / 2)
+
 struct at91_adc_state {
 	void __iomem			*base;
 	int				irq;
@@ -437,29 +496,51 @@ static const struct at91_adc_trigger at91_adc_trigger_list[] = {
 	},
 };
 
-static const struct iio_chan_spec at91_adc_channels[] = {
-	AT91_SAMA5D2_CHAN_SINGLE(0, 0x50),
-	AT91_SAMA5D2_CHAN_SINGLE(1, 0x54),
-	AT91_SAMA5D2_CHAN_SINGLE(2, 0x58),
-	AT91_SAMA5D2_CHAN_SINGLE(3, 0x5c),
-	AT91_SAMA5D2_CHAN_SINGLE(4, 0x60),
-	AT91_SAMA5D2_CHAN_SINGLE(5, 0x64),
-	AT91_SAMA5D2_CHAN_SINGLE(6, 0x68),
-	AT91_SAMA5D2_CHAN_SINGLE(7, 0x6c),
-	AT91_SAMA5D2_CHAN_SINGLE(8, 0x70),
-	AT91_SAMA5D2_CHAN_SINGLE(9, 0x74),
-	AT91_SAMA5D2_CHAN_SINGLE(10, 0x78),
-	AT91_SAMA5D2_CHAN_SINGLE(11, 0x7c),
-	AT91_SAMA5D2_CHAN_DIFF(0, 1, 0x50),
-	AT91_SAMA5D2_CHAN_DIFF(2, 3, 0x58),
-	AT91_SAMA5D2_CHAN_DIFF(4, 5, 0x60),
-	AT91_SAMA5D2_CHAN_DIFF(6, 7, 0x68),
-	AT91_SAMA5D2_CHAN_DIFF(8, 9, 0x70),
-	AT91_SAMA5D2_CHAN_DIFF(10, 11, 0x78),
-	IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA5D2_TIMESTAMP_CHAN_IDX),
-	AT91_SAMA5D2_CHAN_TOUCH(AT91_SAMA5D2_TOUCH_X_CHAN_IDX, "x", IIO_MOD_X),
-	AT91_SAMA5D2_CHAN_TOUCH(AT91_SAMA5D2_TOUCH_Y_CHAN_IDX, "y", IIO_MOD_Y),
-	AT91_SAMA5D2_CHAN_PRESSURE(AT91_SAMA5D2_TOUCH_P_CHAN_IDX, "pressure"),
+static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
+	AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x50),
+	AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x54),
+	AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x58),
+	AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x5c),
+	AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x60),
+	AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x64),
+	AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x68),
+	AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x6c),
+	AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x70),
+	AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x74),
+	AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x78),
+	AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x7c),
+	/* original ABI has the differential channels with a gap in between */
+	AT91_SAMA5D2_CHAN_DIFF(12, 0, 1, 0x50),
+	AT91_SAMA5D2_CHAN_DIFF(14, 2, 3, 0x58),
+	AT91_SAMA5D2_CHAN_DIFF(16, 4, 5, 0x60),
+	AT91_SAMA5D2_CHAN_DIFF(18, 6, 7, 0x68),
+	AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x70),
+	AT91_SAMA5D2_CHAN_DIFF(22, 10, 11, 0x78),
+	IIO_CHAN_SOFT_TIMESTAMP(23),
+	AT91_SAMA5D2_CHAN_TOUCH(24, "x", IIO_MOD_X),
+	AT91_SAMA5D2_CHAN_TOUCH(25, "y", IIO_MOD_Y),
+	AT91_SAMA5D2_CHAN_PRESSURE(26, "pressure"),
+};
+
+static const struct at91_adc_platform sama5d2_platform = {
+	.layout = &sama5d2_layout,
+	.adc_channels = &at91_sama5d2_adc_channels,
+#define AT91_SAMA5D2_SINGLE_CHAN_CNT 12
+#define AT91_SAMA5D2_DIFF_CHAN_CNT 6
+	.nr_channels = AT91_SAMA5D2_SINGLE_CHAN_CNT +
+		       AT91_SAMA5D2_DIFF_CHAN_CNT,
+#define AT91_SAMA5D2_TOUCH_X_CHAN_IDX	(AT91_SAMA5D2_SINGLE_CHAN_CNT + \
+					AT91_SAMA5D2_DIFF_CHAN_CNT * 2)
+	.touch_chan_x = AT91_SAMA5D2_TOUCH_X_CHAN_IDX,
+#define AT91_SAMA5D2_TOUCH_Y_CHAN_IDX	(AT91_SAMA5D2_TOUCH_X_CHAN_IDX + 1)
+	.touch_chan_y = AT91_SAMA5D2_TOUCH_Y_CHAN_IDX,
+#define AT91_SAMA5D2_TOUCH_P_CHAN_IDX	(AT91_SAMA5D2_TOUCH_Y_CHAN_IDX + 1)
+	.touch_chan_p = AT91_SAMA5D2_TOUCH_P_CHAN_IDX,
+#define AT91_SAMA5D2_MAX_CHAN_IDX	AT91_SAMA5D2_TOUCH_P_CHAN_IDX
+	.max_channels = ARRAY_SIZE(at91_sama5d2_adc_channels),
+	.max_index = AT91_SAMA5D2_MAX_CHAN_IDX,
+#define AT91_SAMA5D2_HW_TRIG_CNT	3
+	.hw_trig_cnt = AT91_SAMA5D2_HW_TRIG_CNT,
 };
 
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
@@ -493,6 +574,7 @@ static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
 {
 	u32 mask = 0;
 	u8 bit;
+	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->num_channels) {
@@ -501,13 +583,13 @@ static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
 		mask |= BIT(chan->channel);
 	}
 
-	return mask & GENMASK(11, 0);
+	return mask & GENMASK(st->soc_info.platform->nr_channels, 0);
 }
 
 static void at91_adc_config_emr(struct at91_adc_state *st)
 {
 	/* configure the extended mode register */
-	unsigned int emr = at91_adc_readl(st, AT91_SAMA5D2_EMR);
+	unsigned int emr = at91_adc_readl(st, EMR);
 
 	/* select oversampling per single trigger event */
 	emr |= AT91_SAMA5D2_EMR_ASTE(1);
@@ -531,7 +613,7 @@ static void at91_adc_config_emr(struct at91_adc_state *st)
 		break;
 	}
 
-	at91_adc_writel(st, AT91_SAMA5D2_EMR, emr);
+	at91_adc_writel(st, EMR, emr);
 }
 
 static int at91_adc_adjust_val_osr(struct at91_adc_state *st, int *val)
@@ -584,9 +666,9 @@ static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
 
 	if (!state) {
 		/* disabling touch IRQs and setting mode to no touch enabled */
-		at91_adc_writel(st, AT91_SAMA5D2_IDR,
+		at91_adc_writel(st, IDR,
 				AT91_SAMA5D2_IER_PEN | AT91_SAMA5D2_IER_NOPEN);
-		at91_adc_writel(st, AT91_SAMA5D2_TSMR, 0);
+		at91_adc_writel(st, TSMR, 0);
 		return 0;
 	}
 	/*
@@ -612,26 +694,26 @@ static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
 	tsmr |= AT91_SAMA5D2_TSMR_PENDET_ENA;
 	tsmr |= AT91_SAMA5D2_TSMR_TSFREQ(2) & AT91_SAMA5D2_TSMR_TSFREQ_MASK;
 
-	at91_adc_writel(st, AT91_SAMA5D2_TSMR, tsmr);
+	at91_adc_writel(st, TSMR, tsmr);
 
-	acr =  at91_adc_readl(st, AT91_SAMA5D2_ACR);
+	acr =  at91_adc_readl(st, ACR);
 	acr &= ~AT91_SAMA5D2_ACR_PENDETSENS_MASK;
 	acr |= 0x02 & AT91_SAMA5D2_ACR_PENDETSENS_MASK;
-	at91_adc_writel(st, AT91_SAMA5D2_ACR, acr);
+	at91_adc_writel(st, ACR, acr);
 
 	/* Sample Period Time = (TRGPER + 1) / ADCClock */
 	st->touch_st.sample_period_val =
 				 round_up((AT91_SAMA5D2_TOUCH_SAMPLE_PERIOD_US *
 				 clk_khz / 1000) - 1, 1);
 	/* enable pen detect IRQ */
-	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_PEN);
+	at91_adc_writel(st, IER, AT91_SAMA5D2_IER_PEN);
 
 	return 0;
 }
 
 static u16 at91_adc_touch_pos(struct at91_adc_state *st, int reg)
 {
-	u32 val;
+	u32 val = 0;
 	u32 scale, result, pos;
 
 	/*
@@ -640,7 +722,11 @@ static u16 at91_adc_touch_pos(struct at91_adc_state *st, int reg)
 	 * max = 2^AT91_SAMA5D2_MAX_POS_BITS - 1
 	 */
 	/* first half of register is the x or y, second half is the scale */
-	val = at91_adc_readl(st, reg);
+	if (reg == st->soc_info.platform->layout->XPOSR)
+		val = at91_adc_readl(st, XPOSR);
+	else if (reg == st->soc_info.platform->layout->YPOSR)
+		val = at91_adc_readl(st, YPOSR);
+
 	if (!val)
 		dev_dbg(&st->indio_dev->dev, "pos is 0\n");
 
@@ -658,13 +744,13 @@ static u16 at91_adc_touch_pos(struct at91_adc_state *st, int reg)
 
 static u16 at91_adc_touch_x_pos(struct at91_adc_state *st)
 {
-	st->touch_st.x_pos = at91_adc_touch_pos(st, AT91_SAMA5D2_XPOSR);
+	st->touch_st.x_pos = at91_adc_touch_pos(st, st->soc_info.platform->layout->XPOSR);
 	return st->touch_st.x_pos;
 }
 
 static u16 at91_adc_touch_y_pos(struct at91_adc_state *st)
 {
-	return at91_adc_touch_pos(st, AT91_SAMA5D2_YPOSR);
+	return at91_adc_touch_pos(st, st->soc_info.platform->layout->YPOSR);
 }
 
 static u16 at91_adc_touch_pressure(struct at91_adc_state *st)
@@ -676,7 +762,7 @@ static u16 at91_adc_touch_pressure(struct at91_adc_state *st)
 	u32 factor = 1000;
 
 	/* calculate the pressure */
-	val = at91_adc_readl(st, AT91_SAMA5D2_PRESSR);
+	val = at91_adc_readl(st, PRESSR);
 	z1 = val & AT91_SAMA5D2_XYZ_MASK;
 	z2 = (val >> 16) & AT91_SAMA5D2_XYZ_MASK;
 
@@ -700,9 +786,9 @@ static int at91_adc_read_position(struct at91_adc_state *st, int chan, u16 *val)
 	*val = 0;
 	if (!st->touch_st.touching)
 		return -ENODATA;
-	if (chan == AT91_SAMA5D2_TOUCH_X_CHAN_IDX)
+	if (chan == st->soc_info.platform->touch_chan_x)
 		*val = at91_adc_touch_x_pos(st);
-	else if (chan == AT91_SAMA5D2_TOUCH_Y_CHAN_IDX)
+	else if (chan == st->soc_info.platform->touch_chan_y)
 		*val = at91_adc_touch_y_pos(st);
 	else
 		return -ENODATA;
@@ -715,7 +801,7 @@ static int at91_adc_read_pressure(struct at91_adc_state *st, int chan, u16 *val)
 	*val = 0;
 	if (!st->touch_st.touching)
 		return -ENODATA;
-	if (chan == AT91_SAMA5D2_TOUCH_P_CHAN_IDX)
+	if (chan == st->soc_info.platform->touch_chan_y)
 		*val = at91_adc_touch_pressure(st);
 	else
 		return -ENODATA;
@@ -727,7 +813,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st = iio_priv(indio);
-	u32 status = at91_adc_readl(st, AT91_SAMA5D2_TRGR);
+	u32 status = at91_adc_readl(st, TRGR);
 
 	/* clear TRGMOD */
 	status &= ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
@@ -736,7 +822,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 		status |= st->selected_trig->trgmod_value;
 
 	/* set/unset hw trigger */
-	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
+	at91_adc_writel(st, TRGR, status);
 
 	return 0;
 }
@@ -753,7 +839,7 @@ static void at91_adc_reenable_trigger(struct iio_trigger *trig)
 	enable_irq(st->irq);
 
 	/* Needed to ACK the DRDY interruption */
-	at91_adc_readl(st, AT91_SAMA5D2_LCDR);
+	at91_adc_readl(st, LCDR);
 }
 
 static const struct iio_trigger_ops at91_adc_trigger_ops = {
@@ -848,7 +934,7 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev)
 	}
 
 	/* enable general overrun error signaling */
-	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_GOVRE);
+	at91_adc_writel(st, IER, AT91_SAMA5D2_IER_GOVRE);
 	/* Issue pending DMA requests */
 	dma_async_issue_pending(st->dma_st.dma_chan);
 
@@ -878,7 +964,7 @@ static bool at91_adc_current_chan_is_touch(struct iio_dev *indio_dev)
 
 	return !!bitmap_subset(indio_dev->active_scan_mask,
 			       &st->touch_st.channels_bitmask,
-			       AT91_SAMA5D2_MAX_CHAN_IDX + 1);
+			       st->soc_info.platform->max_index + 1);
 }
 
 static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
@@ -915,7 +1001,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 		    chan->type == IIO_PRESSURE)
 			continue;
 
-		cor = at91_adc_readl(st, AT91_SAMA5D2_COR);
+		cor = at91_adc_readl(st, COR);
 
 		if (chan->differential)
 			cor |= (BIT(chan->channel) | BIT(chan->channel2)) <<
@@ -924,13 +1010,13 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 			cor &= ~(BIT(chan->channel) <<
 			       AT91_SAMA5D2_COR_DIFF_OFFSET);
 
-		at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
+		at91_adc_writel(st, COR, cor);
 
-		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
+		at91_adc_writel(st, CHER, BIT(chan->channel));
 	}
 
 	if (at91_adc_buffer_check_use_irq(indio_dev, st))
-		at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_DRDY);
+		at91_adc_writel(st, IER, AT91_SAMA5D2_IER_DRDY);
 
 	return 0;
 }
@@ -966,17 +1052,17 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 		    chan->type == IIO_PRESSURE)
 			continue;
 
-		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
+		at91_adc_writel(st, CHDR, BIT(chan->channel));
 
 		if (st->dma_st.dma_chan)
-			at91_adc_readl(st, chan->address);
+			at91_adc_read_chan(st, chan->address);
 	}
 
 	if (at91_adc_buffer_check_use_irq(indio_dev, st))
-		at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_DRDY);
+		at91_adc_writel(st, IDR, AT91_SAMA5D2_IER_DRDY);
 
 	/* read overflow register to clear possible overflow status */
-	at91_adc_readl(st, AT91_SAMA5D2_OVER);
+	at91_adc_readl(st, OVER);
 
 	/* if we are using DMA we must clear registers and end DMA */
 	if (st->dma_st.dma_chan)
@@ -1024,7 +1110,7 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
 	 * Check if the conversion is ready. If not, wait a little bit, and
 	 * in case of timeout exit with an error.
 	 */
-	while ((at91_adc_readl(st, AT91_SAMA5D2_ISR) & mask) != mask &&
+	while ((at91_adc_readl(st, ISR) & mask) != mask &&
 	       timeout) {
 		usleep_range(50, 100);
 		timeout--;
@@ -1052,7 +1138,7 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
 		 * Thus, emit a warning.
 		 */
 		if (chan->type == IIO_VOLTAGE) {
-			val = at91_adc_readl(st, chan->address);
+			val = at91_adc_read_chan(st, chan->address);
 			at91_adc_adjust_val_osr(st, &val);
 			st->buffer[i] = val;
 		} else {
@@ -1073,7 +1159,7 @@ static void at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
 	s64 interval;
 	int sample_index = 0, sample_count, sample_size;
 
-	u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
+	u32 status = at91_adc_readl(st, ISR);
 	/* if we reached this point, we cannot sample faster */
 	if (status & AT91_SAMA5D2_IER_GOVRE)
 		pr_info_ratelimited("%s: conversion overrun detected\n",
@@ -1125,7 +1211,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 	 * actually polling the trigger now.
 	 */
 	if (iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
-		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
+		at91_adc_writel(st, CR, AT91_SAMA5D2_CR_START);
 
 	if (st->dma_st.dma_chan)
 		at91_adc_trigger_handler_dma(indio_dev);
@@ -1172,11 +1258,11 @@ static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq)
 	startup = at91_adc_startup_time(st->soc_info.startup_time,
 					freq / 1000);
 
-	mr = at91_adc_readl(st, AT91_SAMA5D2_MR);
+	mr = at91_adc_readl(st, MR);
 	mr &= ~(AT91_SAMA5D2_MR_STARTUP_MASK | AT91_SAMA5D2_MR_PRESCAL_MASK);
 	mr |= AT91_SAMA5D2_MR_STARTUP(startup);
 	mr |= AT91_SAMA5D2_MR_PRESCAL(prescal);
-	at91_adc_writel(st, AT91_SAMA5D2_MR, mr);
+	at91_adc_writel(st, MR, mr);
 
 	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u\n",
 		freq, startup, prescal);
@@ -1196,7 +1282,7 @@ static void at91_adc_touch_data_handler(struct iio_dev *indio_dev)
 	int i = 0;
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 AT91_SAMA5D2_MAX_CHAN_IDX + 1) {
+			 st->soc_info.platform->max_index + 1) {
 		struct iio_chan_spec const *chan =
 					 at91_adc_chan_get(indio_dev, bit);
 
@@ -1222,12 +1308,11 @@ static void at91_adc_touch_data_handler(struct iio_dev *indio_dev)
 
 static void at91_adc_pen_detect_interrupt(struct at91_adc_state *st)
 {
-	at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_PEN);
-	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_NOPEN |
+	at91_adc_writel(st, IDR, AT91_SAMA5D2_IER_PEN);
+	at91_adc_writel(st, IER, AT91_SAMA5D2_IER_NOPEN |
 			AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
 			AT91_SAMA5D2_IER_PRDY);
-	at91_adc_writel(st, AT91_SAMA5D2_TRGR,
-			AT91_SAMA5D2_TRGR_TRGMOD_PERIODIC |
+	at91_adc_writel(st, TRGR, AT91_SAMA5D2_TRGR_TRGMOD_PERIODIC |
 			AT91_SAMA5D2_TRGR_TRGPER(st->touch_st.sample_period_val));
 	st->touch_st.touching = true;
 }
@@ -1236,16 +1321,15 @@ static void at91_adc_no_pen_detect_interrupt(struct iio_dev *indio_dev)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
-	at91_adc_writel(st, AT91_SAMA5D2_TRGR,
-			AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER);
-	at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_NOPEN |
+	at91_adc_writel(st, TRGR, AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER);
+	at91_adc_writel(st, IDR, AT91_SAMA5D2_IER_NOPEN |
 			AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
 			AT91_SAMA5D2_IER_PRDY);
 	st->touch_st.touching = false;
 
 	at91_adc_touch_data_handler(indio_dev);
 
-	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_PEN);
+	at91_adc_writel(st, IER, AT91_SAMA5D2_IER_PEN);
 }
 
 static void at91_adc_workq_handler(struct work_struct *workq)
@@ -1263,8 +1347,8 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 {
 	struct iio_dev *indio = private;
 	struct at91_adc_state *st = iio_priv(indio);
-	u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
-	u32 imr = at91_adc_readl(st, AT91_SAMA5D2_IMR);
+	u32 status = at91_adc_readl(st, ISR);
+	u32 imr = at91_adc_readl(st, IMR);
 	u32 rdy_mask = AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
 			AT91_SAMA5D2_IER_PRDY;
 
@@ -1285,9 +1369,9 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 		 * touching, but the measurements are not ready yet.
 		 * read and ignore.
 		 */
-		status = at91_adc_readl(st, AT91_SAMA5D2_XPOSR);
-		status = at91_adc_readl(st, AT91_SAMA5D2_YPOSR);
-		status = at91_adc_readl(st, AT91_SAMA5D2_PRESSR);
+		status = at91_adc_readl(st, XPOSR);
+		status = at91_adc_readl(st, YPOSR);
+		status = at91_adc_readl(st, PRESSR);
 	} else if (iio_buffer_enabled(indio) &&
 		   (status & AT91_SAMA5D2_IER_DRDY)) {
 		/* triggered buffer without DMA */
@@ -1299,7 +1383,7 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 		WARN(true, "Unexpected irq occurred\n");
 	} else if (!iio_buffer_enabled(indio)) {
 		/* software requested conversion */
-		st->conversion_value = at91_adc_readl(st, st->chan->address);
+		st->conversion_value = at91_adc_read_chan(st, st->chan->address);
 		st->conversion_done = true;
 		wake_up_interruptible(&st->wq_data_available);
 	}
@@ -1360,10 +1444,10 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		cor = (BIT(chan->channel) | BIT(chan->channel2)) <<
 		      AT91_SAMA5D2_COR_DIFF_OFFSET;
 
-	at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
-	at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
-	at91_adc_writel(st, AT91_SAMA5D2_IER, BIT(chan->channel));
-	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
+	at91_adc_writel(st, COR, cor);
+	at91_adc_writel(st, CHER, BIT(chan->channel));
+	at91_adc_writel(st, IER, BIT(chan->channel));
+	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_START);
 
 	ret = wait_event_interruptible_timeout(st->wq_data_available,
 					       st->conversion_done,
@@ -1379,11 +1463,11 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		st->conversion_done = false;
 	}
 
-	at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(chan->channel));
-	at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
+	at91_adc_writel(st, IDR, BIT(chan->channel));
+	at91_adc_writel(st, CHDR, BIT(chan->channel));
 
 	/* Needed to ACK the DRDY interruption */
-	at91_adc_readl(st, AT91_SAMA5D2_LCDR);
+	at91_adc_readl(st, LCDR);
 
 	mutex_unlock(&st->lock);
 
@@ -1455,14 +1539,15 @@ static void at91_adc_dma_init(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 	struct dma_slave_config config = {0};
+	/* we have 2 bytes for each channel */
+	unsigned int sample_size = st->soc_info.platform->nr_channels * 2;
 	/*
 	 * We make the buffer double the size of the fifo,
 	 * such that DMA uses one half of the buffer (full fifo size)
 	 * and the software uses the other half to read/write.
 	 */
 	unsigned int pages = DIV_ROUND_UP(AT91_HWFIFO_MAX_SIZE *
-					  AT91_BUFFER_MAX_CONVERSION_BYTES * 2,
-					  PAGE_SIZE);
+					  sample_size * 2, PAGE_SIZE);
 
 	if (st->dma_st.dma_chan)
 		return;
@@ -1486,7 +1571,7 @@ static void at91_adc_dma_init(struct platform_device *pdev)
 	/* Configure DMA channel to read data register */
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = (phys_addr_t)(st->dma_st.phys_addr
-			  + AT91_SAMA5D2_LCDR);
+			  + st->soc_info.platform->layout->LCDR);
 	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 	config.src_maxburst = 1;
 	config.dst_maxburst = 1;
@@ -1515,9 +1600,10 @@ static void at91_adc_dma_disable(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	/* we have 2 bytes for each channel */
+	unsigned int sample_size = st->soc_info.platform->nr_channels * 2;
 	unsigned int pages = DIV_ROUND_UP(AT91_HWFIFO_MAX_SIZE *
-					  AT91_BUFFER_MAX_CONVERSION_BYTES * 2,
-					  PAGE_SIZE);
+					  sample_size * 2, PAGE_SIZE);
 
 	/* if we are not using DMA, just return */
 	if (!st->dma_st.dma_chan)
@@ -1578,14 +1664,14 @@ static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	if (bitmap_subset(scan_mask, &st->touch_st.channels_bitmask,
-			  AT91_SAMA5D2_MAX_CHAN_IDX + 1))
+			  st->soc_info.platform->max_index + 1))
 		return 0;
 	/*
 	 * if the new bitmap is a combination of touchscreen and regular
 	 * channels, then we are not fine
 	 */
 	if (bitmap_intersects(&st->touch_st.channels_bitmask, scan_mask,
-			      AT91_SAMA5D2_MAX_CHAN_IDX + 1))
+			      st->soc_info.platform->max_index + 1))
 		return -EINVAL;
 	return 0;
 }
@@ -1594,13 +1680,13 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
-	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
-	at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
+	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_SWRST);
+	at91_adc_writel(st, IDR, 0xffffffff);
 	/*
 	 * Transfer field must be set to 2 according to the datasheet and
 	 * allows different analog settings for each channel.
 	 */
-	at91_adc_writel(st, AT91_SAMA5D2_MR,
+	at91_adc_writel(st, MR,
 			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
 
 	at91_adc_setup_samp_freq(indio_dev, st->soc_info.min_sample_rate);
@@ -1716,21 +1802,23 @@ static int at91_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	st = iio_priv(indio_dev);
+	st->indio_dev = indio_dev;
+
+	st->soc_info.platform = of_device_get_match_data(&pdev->dev);
+
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->info = &at91_adc_info;
-	indio_dev->channels = at91_adc_channels;
-	indio_dev->num_channels = ARRAY_SIZE(at91_adc_channels);
-
-	st = iio_priv(indio_dev);
-	st->indio_dev = indio_dev;
+	indio_dev->channels = *st->soc_info.platform->adc_channels;
+	indio_dev->num_channels = st->soc_info.platform->max_channels;
 
 	bitmap_set(&st->touch_st.channels_bitmask,
-		   AT91_SAMA5D2_TOUCH_X_CHAN_IDX, 1);
+		   st->soc_info.platform->touch_chan_x, 1);
 	bitmap_set(&st->touch_st.channels_bitmask,
-		   AT91_SAMA5D2_TOUCH_Y_CHAN_IDX, 1);
+		   st->soc_info.platform->touch_chan_y, 1);
 	bitmap_set(&st->touch_st.channels_bitmask,
-		   AT91_SAMA5D2_TOUCH_P_CHAN_IDX, 1);
+		   st->soc_info.platform->touch_chan_p, 1);
 
 	st->oversampling_ratio = AT91_OSR_1SAMPLES;
 
@@ -1770,7 +1858,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	st->selected_trig = NULL;
 
 	/* find the right trigger, or no trigger at all */
-	for (i = 0; i < AT91_SAMA5D2_HW_TRIG_CNT + 1; i++)
+	for (i = 0; i < st->soc_info.platform->hw_trig_cnt + 1; i++)
 		if (at91_adc_trigger_list[i].edge_type == edge_type) {
 			st->selected_trig = &at91_adc_trigger_list[i];
 			break;
@@ -1855,7 +1943,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 			 st->selected_trig->name);
 
 	dev_info(&pdev->dev, "version: %x\n",
-		 readl_relaxed(st->base + AT91_SAMA5D2_VERSION));
+		 readl_relaxed(st->base + st->soc_info.platform->layout->VERSION));
 
 	return 0;
 
@@ -1898,7 +1986,7 @@ static __maybe_unused int at91_adc_suspend(struct device *dev)
 	 * and can be used by for other devices.
 	 * Otherwise, ADC will hog them and we can't go to suspend mode.
 	 */
-	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
+	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_SWRST);
 
 	clk_disable_unprepare(st->per_clk);
 	regulator_disable(st->vref);
@@ -1958,6 +2046,7 @@ static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
 static const struct of_device_id at91_adc_dt_match[] = {
 	{
 		.compatible = "atmel,sama5d2-adc",
+		.data = (const void *)&sama5d2_platform,
 	}, {
 		/* sentinel */
 	}
-- 
2.25.1

