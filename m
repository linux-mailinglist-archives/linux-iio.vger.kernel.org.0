Return-Path: <linux-iio+bounces-23940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F992B51CB3
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E09D17A6B0
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB9335BB9;
	Wed, 10 Sep 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAhZ+D8/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702932ED55
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519896; cv=none; b=VZds4yPc0pnkfFRObextgs+YEgPodWlow7ujL5zJ6URdmQHlCwH4uAzCuZF7knoBmT7W/e1IBdc45Hpc1e5zbe3bcWIl5VRFBLJhaNn5JUqHjaI7aLa3zyPxItDIY0zjv/Kzi6hkDtu2xPuKKVJy/Os172mf3ITwx4+rpv1cZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519896; c=relaxed/simple;
	bh=FYZFQeqoBXp64+/fnns5U5ss2pJ/VuQwzixnOHD8juc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUZ8Mf3syz5YoOw0ykTMDTsU41mtG9fAv0NLrJCvkjByV8irF+ALfrLyhi5J5lYccYJ/x5Q0EdRc5/Ug60wVT+McODLo7XJjPl3Cx1PwkBNY39fAye8P2LuqhY7MlGBFo4sK/3yQ7goXKWSqI6uJThsGszndAYF8pbu+7W4Tqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xAhZ+D8/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3da4c14a5f9so520428f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757519892; x=1758124692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YRjcIprvWcsr/D31KYIGrjBBFibsdGokXzFjFspD+4=;
        b=xAhZ+D8/XUG4xVpi5Q1WpGEyhUMgbjMUlA2xh9jKsl848hBpI7pXjFq+pq1D9kdzY3
         GGOeW+G+cxAGCbjCxBerN0+/eFRGv1SxsRCsz6MWYz/jxDNZSuYnKbcA3yCUEdvSZ6NI
         /kfOYkraqFEqC6wuaQomCgzWl3s26de9A0ArpzuPO6rncdFiODXVnXBNHwjbMutxTPyU
         VXMd0rDG5/qaglxrzcX+X4Qg6QKGC4RBtNXwDXKSdlj3vaH/1w2mX2wN4mBdJeNnZuCT
         wXhNlfENjNMXknXGI9yd2QCaPRgNYbL82BXgLWRmTykqawFpZbd5yvX6DhitI63Wtnuy
         UVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519892; x=1758124692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YRjcIprvWcsr/D31KYIGrjBBFibsdGokXzFjFspD+4=;
        b=c/EK6rRACYYJrQowuf4FRhjrCKKTFv6VAln9i0M2/YzW8o4NAe6C96vFfKfH0tZMGL
         DAXwH37c4ZFU//K6oi32pWbmw0gV6wodXY4b1fJrZVfOjgKs7MPDoZizWBGWBoEz41pO
         qRfzMzyDkrfnhLqzxMImkdcpfi7xOkbLKdf08gReJ/FzcBCVKlFkd9lBKNRG50EIDHZq
         n26OpaT1mpgMjRpBNFJMixFl3/chTqBVZ8E1068KQYw68tp8tShI8HspzF26V5lwvLvS
         SpLOa0KiDROq/MiHPSqDxJ0ItdPIfgIDZlPet5sc9/2epwlKGAsq1KCK3W4TUdVElPF/
         JBnA==
X-Gm-Message-State: AOJu0YwafHF+Jp0TTo9izxF0ikcc1YEX13lB6fAfjazNRAkZB/7G6lKd
	cj1J8T519Mgf9aDO2RKSD8WojKDRdI6/3hsMoLkjDRmAWQXCcE7rC1A79uMmSvEemj3CAGZwKfR
	nQQJG
X-Gm-Gg: ASbGncun7w4tVf3gjH6LJjHpGbGa0tkPAxgc6zTR8/QrPJFaAKnFlTe1Y7l7FvGBYfv
	YUmvUj3+SQor1VCBljMYYu6iktwVyBGP6BrSOmGc8FuZZZDET5uTC5kJ90O2cWlGIlurEKB/hiS
	h1UZExvbn+bCqvdL6L+WphiYLttaoB3UjhTuPYWtGxpaHNfd1CAMJ6UreUsjeOTOlLWpr5h6Idv
	tg3aMZw64XJ513cp7/VB7zlWcqLUopb+/bmPd9NTDX1u5Nf5fhQCD0v/tZptiA/Lv1y0dxeKsyV
	CEC/enlLGyPNAEhGQtavNzJ490anqxGJfv++xGlZwrvmIlwnQJ3dkGMIbJv9KIBCs3ZY2aqAH7o
	GmctQJSbDWtkIG3Ybt69Gg9GdYhmfalGYcZ/kJwT9PA66ZCNR+4nkeQ==
X-Google-Smtp-Source: AGHT+IHAoGth/zPg9RD9vlJS3NoSjYx1EtSrYCdpFXrK7FRUM6ti8BVy2ATVYqwgy/fZfEheHX1YYQ==
X-Received: by 2002:a5d:5885:0:b0:3e1:ca94:3199 with SMTP id ffacd0b85a97d-3e75e0eda07mr102788f8f.14.1757519891408;
        Wed, 10 Sep 2025 08:58:11 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9717:723a:79cf:4f4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223ea3csm7490325f8f.49.2025.09.10.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:58:10 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms
Date: Wed, 10 Sep 2025 17:57:56 +0200
Message-ID: <20250910155759.75380-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910155759.75380-1-daniel.lezcano@linaro.org>
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>

The NXP S32G2 and S32G3 platforms integrate a successive approximation
register (SAR) ADC. Two instances are available, each providing 8
multiplexed input channels with 12-bit resolution. The conversion rate
is up to 1 Msps depending on the configuration and sampling window.

The SAR ADC supports raw, buffer, and trigger modes. It can operate
in both single-shot and continuous conversion modes, with optional
hardware triggering through the cross-trigger unit (CTU) or external
events. An internal prescaler allows adjusting the sampling clock,
while per-channel programmable sampling times provide fine-grained
trade-offs between accuracy and latency. Automatic calibration is
performed at probe time to minimize offset and gain errors.

The driver is derived from the BSP implementation and has been partly
rewritten to comply with upstream requirements. For this reason, all
contributors are listed as co-developers, while the author refers to
the initial BSP driver file creator.

All modes have been validated on the S32G274-RDB2 platform using an
externally generated square wave captured by the ADC. Tests covered
buffered streaming via IIO, trigger synchronization, and accuracy
verification against a precision laboratory signal source.

Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/iio/adc/Kconfig       |   13 +
 drivers/iio/adc/Makefile      |    1 +
 drivers/iio/adc/nxp-sar-adc.c | 1026 +++++++++++++++++++++++++++++++++
 3 files changed, 1040 insertions(+)
 create mode 100644 drivers/iio/adc/nxp-sar-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6de2abad0197..4c2473a1fa20 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1168,6 +1168,19 @@ config NPCM_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called npcm_adc.
 
+config NXP_SAR_ADC
+	tristate "NXP S32G SAR-ADC driver"
+	depends on ARCH_S32 || COMPILE_TEST
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select IIO_SYSFS_TRIGGER
+	help
+	  Say yes here to build support for S32G platforms
+	  analog-to-digital converter.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called nxp_sar_adc.
+
 config PAC1921
 	tristate "Microchip Technology PAC1921 driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1c6ca5fd4b6d..d1d939753bcc 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
 obj-$(CONFIG_ROHM_BD79124) += rohm-bd79124.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
+obj-$(CONFIG_NXP_SAR_ADC) += nxp-sar-adc.o
 obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
 obj-$(CONFIG_SOPHGO_CV1800B_ADC) += sophgo-cv1800b-adc.o
diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
new file mode 100644
index 000000000000..421ce42ad9ec
--- /dev/null
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -0,0 +1,1026 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP SAR-ADC driver (adapted from Freescale Vybrid vf610 ADC driver
+ * by Fugang Duan <B38611@freescale.com>)
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ * Copyright 2017, 2020-2025 NXP
+ * Copyright 2025, Linaro Ltd
+ */
+#include <linux/bitops.h>
+#include <linux/circ_buf.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+/* This will be the driver name the kernel reports */
+#define DRIVER_NAME "nxp-sar-adc"
+
+/* SAR ADC registers */
+#define REG_ADC_CDR(__base, __channel)	(((__base) + 0x100) + ((__channel) * 0x4))
+
+#define REG_ADC_CDR_CDATA_MASK		GENMASK(11, 0)
+#define REG_ADC_CDR_VALID		BIT(19)
+
+/* Main Configuration Register */
+#define REG_ADC_MCR(__base)		((__base) + 0x00)
+
+#define REG_ADC_MCR_PWDN		BIT(0)
+#define REG_ADC_MCR_ACKO		BIT(5)
+#define REG_ADC_MCR_ADCLKSEL		BIT(8)
+#define REG_ADC_MCR_TSAMP_MASK		GENMASK(10, 9)
+#define REG_ADC_MCR_NRSMPL_MASK		GENMASK(12, 11)
+#define REG_ADC_MCR_AVGEN		BIT(13)
+#define REG_ADC_MCR_CALSTART		BIT(14)
+#define REG_ADC_MCR_NSTART		BIT(24)
+#define REG_ADC_MCR_MODE		BIT(29)
+#define REG_ADC_MCR_OWREN		BIT(31)
+
+/* Main Status Register */
+#define REG_ADC_MSR(__base)		((__base) + 0x04)
+
+#define REG_ADC_MSR_CALBUSY		BIT(29)
+#define REG_ADC_MSR_CALFAIL		BIT(30)
+
+/* Interrupt Status Register */
+#define REG_ADC_ISR(__base)		((__base) + 0x10)
+
+#define REG_ADC_ISR_ECH			BIT(0)
+
+/*  Channel Pending Register */
+#define REG_ADC_CEOCFR0(__base)		((__base) + 0x14)
+#define REG_ADC_CEOCFR1(__base)		((__base) + 0x18)
+
+#define REG_ADC_EOC_CH(c)		BIT((c) % 32)
+
+/* Interrupt Mask Register */
+#define REG_ADC_IMR(__base)		((__base) + 0x20)
+
+/* Channel Interrupt Mask Register */
+#define REG_ADC_CIMR0(__base)		((__base) + 0x24)
+#define REG_ADC_CIMR1(__base)		((__base) + 0x28)
+
+/* DMA Setting Register */
+#define REG_ADC_DMAE(__base)		((__base) + 0x40)
+
+#define REG_ADC_DMAE_DMAEN		BIT(0)
+#define REG_ADC_DMAE_DCLR		BIT(1)
+
+/* DMA Control register */
+#define REG_ADC_DMAR0(__base)		((__base) + 0x44)
+#define REG_ADC_DMAR1(__base)		((__base) + 0x48)
+
+/* Conversion Timing Register */
+#define REG_ADC_CTR0(__base)		((__base) + 0x94)
+#define REG_ADC_CTR1(__base)		((__base) + 0x98)
+
+#define REG_ADC_CTR_INPSAMP_MIN		8
+#define REG_ADC_CTR_INPSAMP_MAX		0xFF
+
+/* Normal Conversion Mask Register */
+#define REG_ADC_NCMR0(__base)		((__base) + 0xa4)
+#define REG_ADC_NCMR1(__base)		((__base) + 0xa8)
+
+/* Normal Conversion Mask Register field define */
+#define REG_ADC_CH_MASK			GENMASK(7, 0)
+
+/* Other field define */
+#define NXP_SAR_ADC_CONV_TIMEOUT_MS	100
+#define NXP_SAR_ADC_CAL_TIMEOUT_US	(100 * USEC_PER_MSEC)
+#define NXP_SAR_ADC_WAIT_US		(2 * USEC_PER_MSEC)
+#define NXP_SAR_ADC_RESOLUTION		12
+
+/* Duration of conversion phases */
+#define NXP_SAR_ADC_TPT			2
+#define NXP_SAR_ADC_DP			2
+#define NXP_SAR_ADC_CT			((NXP_SAR_ADC_RESOLUTION + 2) * 4)
+#define NXP_SAR_ADC_CONV_TIME		(NXP_SAR_ADC_TPT + NXP_SAR_ADC_CT + NXP_SAR_ADC_DP)
+
+#define NXP_SAR_ADC_NR_CHANNELS	8
+
+#define NXP_SAR_ADC_IIO_BUFF_SZ		(NXP_SAR_ADC_NR_CHANNELS + (sizeof(u64) / sizeof(u16)))
+
+#define NXP_PAGE_SIZE			SZ_4K
+#define NXP_SAR_ADC_DMA_SAMPLE_SZ	DMA_SLAVE_BUSWIDTH_4_BYTES
+#define NXP_SAR_ADC_DMA_BUFF_SZ		(NXP_PAGE_SIZE * NXP_SAR_ADC_DMA_SAMPLE_SZ)
+#define NXP_SAR_ADC_DMA_SAMPLE_CNT	(NXP_SAR_ADC_DMA_BUFF_SZ / NXP_SAR_ADC_DMA_SAMPLE_SZ)
+
+struct nxp_sar_adc {
+	void __iomem *regs;
+	phys_addr_t regs_phys;
+	struct clk *clk;
+
+	u16 value;
+	u32 vref_mV;
+	u8 current_channel;
+	u8 channels_used;
+
+	struct completion completion;
+
+	u16 buffer[NXP_SAR_ADC_IIO_BUFF_SZ];
+	u16 buffered_chan[NXP_SAR_ADC_NR_CHANNELS];
+
+	struct circ_buf dma_buf;
+	struct dma_chan	*dma_chan;
+	struct dma_slave_config dma_config;
+	dma_addr_t rx_dma_buf;
+	dma_cookie_t cookie;
+
+	/* Protect circular buffers access. */
+	spinlock_t lock;
+
+	/*
+	 * Save and restore context
+	 */
+	u32 inpsamp;
+	u32 pwdn;
+};
+
+struct nxp_sar_adc_data {
+	u32 vref_mV;
+};
+
+#define ADC_CHAN(_idx, _chan_type) {				\
+	.type = (_chan_type),					\
+	.indexed = 1,						\
+	.channel = (_idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = (_idx),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 12,					\
+		.storagebits = 16,				\
+	},							\
+}
+
+static const struct iio_chan_spec nxp_sar_adc_iio_channels[] = {
+	ADC_CHAN(0, IIO_VOLTAGE),
+	ADC_CHAN(1, IIO_VOLTAGE),
+	ADC_CHAN(2, IIO_VOLTAGE),
+	ADC_CHAN(3, IIO_VOLTAGE),
+	ADC_CHAN(4, IIO_VOLTAGE),
+	ADC_CHAN(5, IIO_VOLTAGE),
+	ADC_CHAN(6, IIO_VOLTAGE),
+	ADC_CHAN(7, IIO_VOLTAGE),
+	IIO_CHAN_SOFT_TIMESTAMP(32),
+};
+
+static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
+{
+	if (enable)
+		writel(REG_ADC_ISR_ECH, REG_ADC_IMR(info->regs));
+	else
+		writel(0, REG_ADC_IMR(info->regs));
+}
+
+static bool __nxp_sar_adc_enable(struct nxp_sar_adc *info, bool enable)
+{
+	u32 mcr;
+	bool pwdn;
+
+	mcr = readl(REG_ADC_MCR(info->regs));
+
+	/*
+	 * Return the current state
+	 */
+	pwdn = mcr & REG_ADC_MCR_PWDN;
+
+	if (enable)
+		mcr &= ~REG_ADC_MCR_PWDN;
+	else
+		mcr |= REG_ADC_MCR_PWDN;
+
+	writel(mcr, REG_ADC_MCR(info->regs));
+
+	/*
+	 * Ensure there are at least three cycles between the
+	 * configuration of NCMR and the setting of NSTART
+	 */
+	if (enable)
+		ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * 3U));
+
+	return pwdn;
+}
+
+static inline bool nxp_sar_adc_enable(struct nxp_sar_adc *info)
+{
+	return __nxp_sar_adc_enable(info, true);
+}
+
+static inline bool nxp_sar_adc_disable(struct nxp_sar_adc *info)
+{
+	return __nxp_sar_adc_enable(info, false);
+}
+
+static inline void nxp_sar_adc_calibration_start(void __iomem *base)
+{
+	u32 mcr = readl(REG_ADC_MCR(base));
+
+	mcr |= REG_ADC_MCR_CALSTART;
+
+	writel(mcr, REG_ADC_MCR(base));
+}
+
+static inline int nxp_sar_adc_calibration_wait(void __iomem *base)
+{
+	u32 msr, ret;
+
+	ret = readl_poll_timeout(REG_ADC_MSR(base), msr, !(msr & REG_ADC_MSR_CALBUSY),
+				 NXP_SAR_ADC_WAIT_US,
+				 NXP_SAR_ADC_CAL_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	if (msr & REG_ADC_MSR_CALFAIL) {
+		/*
+		 * If the calibration fails, the status register bit
+		 * must be cleared
+		 */
+		msr &= ~REG_ADC_MSR_CALFAIL;
+		writel(msr, REG_ADC_MSR(base));
+
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static int nxp_sar_adc_calibration(struct nxp_sar_adc *info)
+{
+	int ret;
+
+	/*
+	 * Calibration works only if the adc is powered up
+	 */
+	nxp_sar_adc_enable(info);
+
+	/*
+	 * The calibration operation starts
+	 */
+	nxp_sar_adc_calibration_start(info->regs);
+
+	ret = nxp_sar_adc_calibration_wait(info->regs);
+
+	/*
+	 * Calibration works only if the adc is powered up. However
+	 * the calibration is called from the probe function where the
+	 * iio is not enabled, so we disable after the calibration
+	 */
+	nxp_sar_adc_disable(info);
+
+	return ret;
+}
+
+static void nxp_sar_adc_conversion_timing_set(struct nxp_sar_adc *info, u32 inpsamp)
+{
+	inpsamp = clamp(inpsamp, REG_ADC_CTR_INPSAMP_MIN, REG_ADC_CTR_INPSAMP_MAX);
+
+	writel(inpsamp, REG_ADC_CTR0(info->regs));
+}
+
+static u32 nxp_sar_adc_conversion_timing_get(struct nxp_sar_adc *info)
+{
+	return readl(REG_ADC_CTR0(info->regs));
+}
+
+static void nxp_sar_adc_read_notify(struct nxp_sar_adc *info)
+{
+	writel(REG_ADC_CH_MASK, REG_ADC_CEOCFR0(info->regs));
+	writel(REG_ADC_CH_MASK, REG_ADC_CEOCFR1(info->regs));
+}
+
+static int nxp_sar_adc_read_data(struct nxp_sar_adc *info, unsigned int chan)
+{
+	u32 ceocfr, cdr;
+
+	ceocfr = readl(REG_ADC_CEOCFR0(info->regs));
+	if (!(ceocfr & REG_ADC_EOC_CH(chan)))
+		return -EIO;
+
+	cdr = readl(REG_ADC_CDR(info->regs, chan));
+	if (!(cdr & REG_ADC_CDR_VALID))
+		return -EIO;
+
+	return cdr & REG_ADC_CDR_CDATA_MASK;
+}
+
+static void nxp_sar_adc_isr_buffer(struct iio_dev *indio_dev)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < info->channels_used; i++) {
+		ret = nxp_sar_adc_read_data(info, info->buffered_chan[i]);
+		if (ret < 0) {
+			nxp_sar_adc_read_notify(info);
+			return;
+		}
+
+		info->buffer[i] = ret;
+	}
+
+	nxp_sar_adc_read_notify(info);
+	iio_push_to_buffers_with_timestamp(indio_dev,
+					   info->buffer,
+					   iio_get_time_ns(indio_dev));
+	iio_trigger_notify_done(indio_dev->trig);
+}
+
+static void nxp_sar_adc_isr_read_raw(struct iio_dev *indio_dev)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	int ret;
+
+	ret = nxp_sar_adc_read_data(info, info->current_channel);
+	nxp_sar_adc_read_notify(info);
+	if (ret < 0)
+		return;
+
+	info->value = ret;
+	complete(&info->completion);
+}
+
+static irqreturn_t nxp_sar_adc_isr(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = (struct iio_dev *)dev_id;
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	int isr;
+
+	isr = readl(REG_ADC_ISR(info->regs));
+	if (!(isr & REG_ADC_ISR_ECH))
+		return IRQ_NONE;
+
+	if (iio_buffer_enabled(indio_dev))
+		nxp_sar_adc_isr_buffer(indio_dev);
+	else
+		nxp_sar_adc_isr_read_raw(indio_dev);
+
+	writel(REG_ADC_ISR_ECH, REG_ADC_ISR(info->regs));
+
+	return IRQ_HANDLED;
+}
+
+static void nxp_sar_adc_channels_disable(struct nxp_sar_adc *info, u32 mask)
+{
+	u32 ncmr, cimr;
+
+	ncmr = readl(REG_ADC_NCMR0(info->regs));
+	cimr = readl(REG_ADC_CIMR0(info->regs));
+
+	ncmr &= ~mask;
+	cimr &= ~mask;
+
+	writel(ncmr, REG_ADC_NCMR0(info->regs));
+	writel(cimr, REG_ADC_CIMR0(info->regs));
+}
+
+static void nxp_sar_adc_channels_enable(struct nxp_sar_adc *info, u32 mask)
+{
+	u32 ncmr, cimr;
+
+	ncmr = readl(REG_ADC_NCMR0(info->regs));
+	cimr = readl(REG_ADC_CIMR0(info->regs));
+
+	ncmr |= mask;
+	cimr |= mask;
+
+	writel(ncmr, REG_ADC_NCMR0(info->regs));
+	writel(cimr, REG_ADC_CIMR0(info->regs));
+}
+
+static void nxp_sar_adc_dma_channels_enable(struct nxp_sar_adc *info, u32 mask)
+{
+	u32 dmar;
+
+	dmar = readl(REG_ADC_DMAR0(info->regs));
+
+	dmar |= mask;
+
+	writel(dmar, REG_ADC_DMAR0(info->regs));
+}
+
+static void nxp_sar_adc_dma_channels_disable(struct nxp_sar_adc *info, u32 mask)
+{
+	u32 dmar;
+
+	dmar = readl(REG_ADC_DMAR0(info->regs));
+
+	dmar &= ~mask;
+
+	writel(dmar, REG_ADC_DMAR0(info->regs));
+}
+
+static void nxp_sar_adc_dma_cfg(struct nxp_sar_adc *info, bool enable)
+{
+	u32 dmae;
+
+	dmae = readl(REG_ADC_DMAE(info->regs));
+	if (enable)
+		dmae |= REG_ADC_DMAE_DMAEN;
+	else
+		dmae &= ~REG_ADC_DMAE_DMAEN;
+	writel(dmae, REG_ADC_DMAE(info->regs));
+}
+
+static void nxp_sar_adc_stop_conversion(struct nxp_sar_adc *info)
+{
+	u32 mcr;
+
+	mcr = readl(REG_ADC_MCR(info->regs));
+	mcr &= ~REG_ADC_MCR_NSTART;
+	writel(mcr, REG_ADC_MCR(info->regs));
+
+	/*
+	 * On disable, we have to wait for the transaction to finish.
+	 * ADC does not abort the transaction if a chain conversion
+	 * is in progress.
+	 * Wait for the worst case scenario - 80 ADC clk cycles.
+	 */
+	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80U);
+}
+
+static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
+{
+	u32 mcr;
+
+	mcr = readl(REG_ADC_MCR(info->regs));
+	mcr |= REG_ADC_MCR_NSTART;
+
+	if (raw)
+		mcr &= ~REG_ADC_MCR_MODE;
+	else
+		mcr |= REG_ADC_MCR_MODE;
+
+	writel(mcr, REG_ADC_MCR(info->regs));
+
+	return 0;
+}
+
+static int sar_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	u32 inpsamp;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		info->current_channel = chan->channel;
+		nxp_sar_adc_channels_enable(info, BIT(chan->channel));
+		nxp_sar_adc_irq_cfg(info, true);
+		nxp_sar_adc_enable(info);
+
+		reinit_completion(&info->completion);
+		ret = nxp_sar_adc_start_conversion(info, true);
+		if (ret < 0)
+			goto out_iio_chan_info_raw;
+
+		ret = wait_for_completion_interruptible_timeout
+			(&info->completion,
+			msecs_to_jiffies(NXP_SAR_ADC_CONV_TIMEOUT_MS));
+
+		nxp_sar_adc_channels_disable(info, BIT(chan->channel));
+		nxp_sar_adc_irq_cfg(info, false);
+		nxp_sar_adc_stop_conversion(info);
+		nxp_sar_adc_disable(info);
+
+		if (ret == 0) {
+			ret = -ETIMEDOUT;
+			goto out_iio_chan_info_raw;
+		}
+
+		if (ret < 0)
+			goto out_iio_chan_info_raw;
+
+		*val = info->value;
+		ret = IIO_VAL_INT;
+
+out_iio_chan_info_raw:
+		iio_device_release_direct(indio_dev);
+		return ret;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = info->vref_mV;
+		*val2 = NXP_SAR_ADC_RESOLUTION;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		inpsamp = nxp_sar_adc_conversion_timing_get(info);
+		*val = clk_get_rate(info->clk) / (inpsamp + NXP_SAR_ADC_CONV_TIME);
+		return IIO_VAL_INT;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int sar_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			 int val, int val2, long mask)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	u32 inpsamp;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		/*
+		 * Configures the sample period duration in terms of
+		 * the SAR controller clock. The minimum acceptable
+		 * value is 8. Configuring to a value lower than 8
+		 * sets the sample period to 8 cycles.  We read the
+		 * clock value and divide by the sampling timing which
+		 * gives us the number of cycles expected. The value
+		 * is 8 bits wide, consequently the max value is 0xFF
+		 */
+		inpsamp = clk_get_rate(info->clk) / val - NXP_SAR_ADC_CONV_TIME;
+		nxp_sar_adc_conversion_timing_set(info, inpsamp);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static void nxp_sar_adc_dma_cb(void *data)
+{
+	struct nxp_sar_adc *info = iio_priv((struct iio_dev *)data);
+	struct iio_dev *indio_dev = data;
+	struct dma_tx_state state;
+	struct circ_buf *dma_buf;
+	struct device *dev_dma;
+	u32 *dma_samples;
+	s64 timestamp;
+	int idx, ret;
+
+	guard(spinlock_irqsave)(&info->lock);
+
+	dma_buf = &info->dma_buf;
+	dma_samples = (u32 *)dma_buf->buf;
+	dev_dma = info->dma_chan->device->dev;
+
+	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
+
+	dma_sync_single_for_cpu(dev_dma, info->rx_dma_buf,
+				NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
+	/* Current head position */
+	dma_buf->head = (NXP_SAR_ADC_DMA_BUFF_SZ - state.residue) /
+			NXP_SAR_ADC_DMA_SAMPLE_SZ;
+
+	/* If everything transferred, avoid an off by one error. */
+	if (!state.residue)
+		dma_buf->head--;
+
+	/* Something went wrong and nothing transferred. */
+	if (state.residue == NXP_SAR_ADC_DMA_BUFF_SZ)
+		goto out;
+
+	/* Make sure that head is multiple of info->channels_used */
+	dma_buf->head -= dma_buf->head % info->channels_used;
+
+	/* dma_buf->tail != dma_buf->head condition will become false
+	 * because dma_buf->tail will be incremented with 1.
+	 */
+	while (dma_buf->tail != dma_buf->head) {
+		idx = dma_buf->tail % info->channels_used;
+		info->buffer[idx] = dma_samples[dma_buf->tail];
+		dma_buf->tail = (dma_buf->tail + 1) % NXP_SAR_ADC_DMA_SAMPLE_CNT;
+		if (idx != info->channels_used - 1)
+			continue;
+
+		/* iio_push_to_buffers_with_timestamp should not be called
+		 * with dma_samples as parameter. The samples will be smashed
+		 * if timestamp is enabled.
+		 */
+		timestamp = iio_get_time_ns(indio_dev);
+		ret = iio_push_to_buffers_with_timestamp(indio_dev,
+							 info->buffer,
+							 timestamp);
+		if (ret < 0 && ret != -EBUSY)
+			dev_err_ratelimited(&indio_dev->dev,
+					    "failed to push iio buffer: %d",
+					    ret);
+	}
+
+	dma_buf->tail = dma_buf->head;
+out:
+	dma_sync_single_for_device(dev_dma, info->rx_dma_buf,
+				   NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
+}
+
+static int nxp_sar_adc_start_cyclic_dma(struct iio_dev *indio_dev)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	struct dma_slave_config *config = &info->dma_config;
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+
+	info->dma_buf.head = 0;
+	info->dma_buf.tail = 0;
+
+	config->src_addr = REG_ADC_CDR(info->regs_phys, info->buffered_chan[0]);
+	config->src_port_window_size = info->channels_used;
+	config->src_maxburst = info->channels_used;
+	ret = dmaengine_slave_config(info->dma_chan, config);
+	if (ret < 0)
+		return ret;
+
+	desc = dmaengine_prep_dma_cyclic(info->dma_chan,
+					 info->rx_dma_buf,
+					 NXP_SAR_ADC_DMA_BUFF_SZ,
+					 NXP_SAR_ADC_DMA_BUFF_SZ / 2,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!desc)
+		return -EINVAL;
+
+	desc->callback = nxp_sar_adc_dma_cb;
+	desc->callback_param = indio_dev;
+	info->cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(info->cookie);
+	if (ret) {
+		dmaengine_terminate_async(info->dma_chan);
+		return ret;
+	}
+
+	dma_async_issue_pending(info->dma_chan);
+
+	return 0;
+}
+
+static void __nxp_sar_adc_buffer_software_predisable(struct iio_dev *indio_dev)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+
+	/*
+	 * The ADC DMAEN bit should be cleared before DMA transaction
+	 * is canceled.
+	 */
+	nxp_sar_adc_dma_channels_disable(info, *indio_dev->active_scan_mask);
+	nxp_sar_adc_dma_cfg(info, false);
+	dmaengine_terminate_sync(info->dma_chan);
+}
+
+static int __nxp_sar_adc_buffer_software_postenable(struct iio_dev *indio_dev)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	int ret;
+
+	nxp_sar_adc_dma_channels_enable(info, *indio_dev->active_scan_mask);
+
+	nxp_sar_adc_dma_cfg(info, true);
+
+	ret = nxp_sar_adc_start_cyclic_dma(indio_dev);
+	if (ret)
+		goto out_dma_channels_disable;
+
+	ret = nxp_sar_adc_start_conversion(info, false);
+	if (ret)
+		goto out_stop_cyclic_dma;
+
+	return 0;
+
+out_stop_cyclic_dma:
+	dmaengine_terminate_sync(info->dma_chan);
+
+out_dma_channels_disable:
+	nxp_sar_adc_dma_cfg(info, false);
+	nxp_sar_adc_dma_channels_disable(info, *indio_dev->active_scan_mask);
+
+	return ret;
+}
+
+static void __nxp_sar_adc_buffer_trigger_predisable(struct iio_dev *indio_dev)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+
+	nxp_sar_adc_irq_cfg(info, false);
+}
+
+static int __nxp_sar_adc_buffer_trigger_postenable(struct iio_dev *indio_dev)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+
+	nxp_sar_adc_irq_cfg(info, true);
+
+	return 0;
+}
+
+static int nxp_sar_adc_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	int current_mode = iio_device_get_current_mode(indio_dev);
+	unsigned long channel;
+	int ret;
+
+	info->channels_used = 0;
+
+	/*
+	 * The SAR-ADC has two groups of channels.
+	 *
+	 *	- Group #0:
+	 *	* bit 0-7  : channel 0 -> channel 7
+	 *	* bit 8-31 : reserved
+	 *
+	 *	- Group #32:
+	 *	* bit 0-7  : Internal
+	 *	* bit 8-31 : reserved
+	 *
+	 * The 8 channels from group #0 are used in this driver for
+	 * ADC as described when declaring the IIO device and the
+	 * mapping is the same. That means the active_scan_mask can be
+	 * used directly to write the channel interrupt mask.
+	 */
+	nxp_sar_adc_channels_enable(info, *indio_dev->active_scan_mask);
+
+	for_each_set_bit(channel, indio_dev->active_scan_mask, NXP_SAR_ADC_NR_CHANNELS)
+		info->buffered_chan[info->channels_used++] = channel;
+
+	nxp_sar_adc_enable(info);
+
+	if (current_mode == INDIO_BUFFER_SOFTWARE)
+		ret = __nxp_sar_adc_buffer_software_postenable(indio_dev);
+	else
+		ret = __nxp_sar_adc_buffer_trigger_postenable(indio_dev);
+	if (ret)
+		goto out_postenable;
+
+	return 0;
+
+out_postenable:
+	nxp_sar_adc_stop_conversion(info);
+	nxp_sar_adc_disable(info);
+	nxp_sar_adc_channels_disable(info, *indio_dev->active_scan_mask);
+
+	return ret;
+}
+
+static int nxp_sar_adc_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	int currentmode = iio_device_get_current_mode(indio_dev);
+
+	nxp_sar_adc_stop_conversion(info);
+
+	if (currentmode == INDIO_BUFFER_SOFTWARE)
+		__nxp_sar_adc_buffer_software_predisable(indio_dev);
+	else
+		__nxp_sar_adc_buffer_trigger_predisable(indio_dev);
+
+	nxp_sar_adc_channels_disable(info, *indio_dev->active_scan_mask);
+	nxp_sar_adc_disable(info);
+
+	return 0;
+}
+
+static irqreturn_t nxp_sar_adc_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	int ret;
+
+	ret = nxp_sar_adc_start_conversion(info, true);
+	if (ret < 0)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
+	.postenable = nxp_sar_adc_buffer_postenable,
+	.predisable = nxp_sar_adc_buffer_predisable,
+};
+
+static const struct iio_info nxp_sar_adc_iio_info = {
+	.read_raw  = sar_read_raw,
+	.write_raw = sar_write_raw,
+};
+
+static void nxp_sar_adc_dma_remove(void *data)
+{
+	struct nxp_sar_adc *info = data;
+
+	dma_free_coherent(info->dma_chan->device->dev, NXP_SAR_ADC_DMA_BUFF_SZ,
+			  info->dma_buf.buf, info->rx_dma_buf);
+}
+
+static int nxp_sar_adc_dma_probe(struct device *dev, struct nxp_sar_adc *info)
+{
+	struct device *dev_dma;
+	int ret;
+	u8 *rx_buf;
+
+	info->dma_chan = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(info->dma_chan))
+		return PTR_ERR(info->dma_chan);
+
+	dev_dma = info->dma_chan->device->dev;
+	rx_buf = dma_alloc_coherent(dev_dma, NXP_SAR_ADC_DMA_BUFF_SZ,
+				    &info->rx_dma_buf, GFP_KERNEL);
+	if (!rx_buf)
+		return -ENOMEM;
+
+	info->dma_buf.buf = rx_buf;
+
+	info->dma_config.direction = DMA_DEV_TO_MEM;
+	info->dma_config.src_addr_width = NXP_SAR_ADC_DMA_SAMPLE_SZ;
+	info->dma_config.src_maxburst = 1;
+
+	ret = devm_add_action_or_reset(dev, nxp_sar_adc_dma_remove, info);
+	if (ret)
+		nxp_sar_adc_dma_remove(info);
+
+	return ret;
+}
+
+/*
+ * The documentation describes the reset values for the
+ * registers. However some registers do not have these values after a
+ * reset. It is a not desirable situation. In some other SoC family
+ * documentation NXP recommend to not assume the default values are
+ * set and to initialize the registers conforming to the documentation
+ * reset information to prevent this situation. Assume the same rule
+ * applies here as there is a discrepancy between what is read from
+ * the registers at reset time and the documentation.
+ */
+static void nxp_sar_adc_set_default_values(struct nxp_sar_adc *info)
+{
+	writel(0x00003901, REG_ADC_MCR(info->regs));
+	writel(0x00000001, REG_ADC_MSR(info->regs));
+	writel(0x00000014, REG_ADC_CTR0(info->regs));
+	writel(0x00000014, REG_ADC_CTR1(info->regs));
+	writel(0x00000000, REG_ADC_CIMR0(info->regs));
+	writel(0x00000000, REG_ADC_CIMR1(info->regs));
+	writel(0x00000000, REG_ADC_NCMR0(info->regs));
+	writel(0x00000000, REG_ADC_NCMR1(info->regs));
+}
+
+static int nxp_sar_adc_probe(struct platform_device *pdev)
+{
+	const struct nxp_sar_adc_data *data;
+	struct nxp_sar_adc *info;
+	struct iio_dev *indio_dev;
+	struct resource *mem;
+	struct device *dev = &pdev->dev;
+	int irq;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct nxp_sar_adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+
+	data = device_get_match_data(dev);
+
+	info->vref_mV = data->vref_mV;
+
+	info->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
+	if (IS_ERR(info->regs))
+		return dev_err_probe(dev, PTR_ERR(info->regs),
+				     "failed to get and remap resource");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
+			       dev_name(dev), indio_dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed requesting irq, irq = %d\n", irq);
+
+	info->regs_phys = mem->start;
+	spin_lock_init(&info->lock);
+
+	info->clk = devm_clk_get_enabled(dev, "adc");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(dev, PTR_ERR(info->clk),
+				     "failed to get the clock\n");
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	init_completion(&info->completion);
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->info = &nxp_sar_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->channels = nxp_sar_adc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(nxp_sar_adc_iio_channels);
+
+	nxp_sar_adc_set_default_values(info);
+
+	ret = nxp_sar_adc_calibration(info);
+	if (ret) {
+		dev_err(dev, "Calibration failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = nxp_sar_adc_dma_probe(dev, info);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize the dma\n");
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &nxp_sar_adc_trigger_handler,
+					      &iio_triggered_buffer_setup_ops);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Couldn't initialise the buffer\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't register the device\n");
+
+	return 0;
+}
+
+static void nxp_sar_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+
+	nxp_sar_adc_stop_conversion(info);
+	nxp_sar_adc_channels_disable(info, REG_ADC_CH_MASK);
+	nxp_sar_adc_dma_channels_disable(info, REG_ADC_CH_MASK);
+	nxp_sar_adc_dma_cfg(info, false);
+	nxp_sar_adc_disable(info);
+	dmaengine_terminate_sync(info->dma_chan);
+}
+
+static int nxp_sar_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+
+	info->pwdn = nxp_sar_adc_disable(info);
+	info->inpsamp = nxp_sar_adc_conversion_timing_get(info);
+
+	clk_disable_unprepare(info->clk);
+
+	return 0;
+}
+
+static int nxp_sar_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct nxp_sar_adc *info = iio_priv(indio_dev);
+	int ret;
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret)
+		return ret;
+
+	nxp_sar_adc_conversion_timing_set(info, info->inpsamp);
+
+	if (!info->pwdn)
+		nxp_sar_adc_enable(info);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(nxp_sar_adc_pm_ops, nxp_sar_adc_suspend, nxp_sar_adc_resume);
+
+static const struct nxp_sar_adc_data s32g2_sar_adc_data = { .vref_mV = 1800 };
+
+static const struct of_device_id nxp_sar_adc_match[] = {
+	{ .compatible = "nxp,s32g2-sar-adc", .data = &s32g2_sar_adc_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nxp_sar_adc_match);
+
+static struct platform_driver nxp_sar_adc_driver = {
+	.probe          = nxp_sar_adc_probe,
+	.remove         = nxp_sar_adc_remove,
+	.driver         = {
+		.name   = DRIVER_NAME,
+		.of_match_table = nxp_sar_adc_match,
+		.pm     = pm_ptr(&nxp_sar_adc_pm_ops),
+	},
+};
+module_platform_driver(nxp_sar_adc_driver);
+
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("NXP SAR-ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


