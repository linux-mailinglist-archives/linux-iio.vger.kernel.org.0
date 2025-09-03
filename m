Return-Path: <linux-iio+bounces-23674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC1EB41BD6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 12:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C1CE4E4012
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9C52F1FE2;
	Wed,  3 Sep 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAaTi6Y3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD3A2EB5AF
	for <linux-iio@vger.kernel.org>; Wed,  3 Sep 2025 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895287; cv=none; b=euR6skdx8IdX7YD0q2kVUlUYqFcXYNj+CnAnbptGbsfEgiava6QcFkzQM7UK+sC7wBi0eaXfaDe9CmoZrAY3hu1WfK+fu8kAK2cMMFIkA/umLIX96WozTz7myX0HQtN6E7hjfeBMV7GzDc6swSuRkOKLjtFG6KsGJyEnkc4XKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895287; c=relaxed/simple;
	bh=OKVZBRWaav06MzfrDM24pm8h608nlGHjz8Hnvv7WeIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIKXE2ERlEwKi5aHlXL96DQUC8Dkp3UyfaTsX92cogwEJH9q0FL80GZ58xXw0XhuAXfdjKL5wAP0L5SyoJiSvl0d99e1oONBujP1qDw6/zdXICV/5/nf2Pv7WSkFvDy4KUgz+zf/aOoIyhzs8OAoby3fZl20n8TXzULPgxhM6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yAaTi6Y3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b89147cfbso29911545e9.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Sep 2025 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756895282; x=1757500082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDQTThLBxnGZTNRKxJv2Os3qbuVp8wt0mBa9EnhVxl4=;
        b=yAaTi6Y3sqamrt6PYhnEkYCBcDKyJhI2yXHkEgyavp5LVZlE02grtVBKWMd/eQypdN
         6qN4WQRSVPvPx+8XOhtTKZhd1VsR7FCehs2Xl1Ow8cNsFS6N3j7SCyaQj48qnl9P8DjA
         EayAUJ5j4qClRPxW+HZaXGbqHbiEJbuwCtuuuFXRa96qmQGV/LsiHJzSh+pCXUKkRKHO
         jzj4bR03wtwyoTeY1uP8+u2URQcGzlzDkGN6EuMJzsrpm9Ld6wQUSYC3Soa59ZdLqAq4
         lhUEfRnYhKYzUNRW1BupuNPvT53h9ZzjbdEohyKq+2/hsgWaQVrlT5o8Nq6sWVgOk4cU
         Xn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895282; x=1757500082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDQTThLBxnGZTNRKxJv2Os3qbuVp8wt0mBa9EnhVxl4=;
        b=MGWBWY/6NWRuoEQ4nbMwnKi7uKahM15AU5397Vpvn9eD8J48VMUsvysvqgpda9tF86
         gx8vybJRJxBp/9qnD/o4ocNL3SDq1BpTfCg3eIy5gkJ8s4tRLFvkhbpVqa9DJRQtWS7N
         dFXZoeLy07hwF64gGvZE/t12JblB9jzNrHGT1pCRa37dsNTGVZ1PO27dBjwJ4dfzx6MF
         KipopT2pafXvlKoa1WunPnF1zLcPDVT34FhLPRAc0fiHxOdqq9l5mFI+gK0XnSVrRQ8A
         4+RtT14l+RIs470WAb2rxIewIBJ8amCRlqjR8ifYI1SaB/YyEXdGiVLHtu9VFVW1OfZd
         mj/g==
X-Gm-Message-State: AOJu0Yzwk5c955/3jPci7/m2PLgfHFvn6Zx4FIE5uue/ICnwk2QsHb/I
	/4lXlTPDHBGLlRN6DnpFAJddJLCjHkKKj7nvjc27UT1mBMX2rel/SY1m8N+w7Ybrss0=
X-Gm-Gg: ASbGncv54gKaIkk6xobbCpvhR/+hgxfPUkLj8QzXTW7WbN/CI6VFUFtWx9N2iw+z6Xr
	VsnN3hmBLvAzdRRqDxhxlf7gJEGLZ9XKIJueTy38MszadEpEswsDrhVNMwm8vhaf+Vkm83XMyS8
	mSyKFdA+XIPUgieMcbaI3zHmuNf94CaMFF1RwBwsKGHImPcXDWFpFizBYsLSwlkaIbKe57F7B0Q
	w8THfuwv4iRTlSlKNNKQ2h3Ww74/a++2rsKyBQIlhoGDIAP7SbQf8XppHjwx79/69PoHhCkInom
	GO/e2p/LxR0X2JXiecIdaZ6UQDvYH7y5Why3xSxS5KNVVMRdoLwLhL9e8//U0jD9VPblnVJd4KU
	WFYMh4dCr6CaaFLpJeE8WnXeWTRrERpQk+6d5fAdhWruQTluZxXXT8A==
X-Google-Smtp-Source: AGHT+IEmmtoTzf8gPoFrplEGAdcaMBM3K1AYf3Px4cGvPIqBJIgjb6r3OHhFgblQtwcH08OKOhqcWg==
X-Received: by 2002:a05:600c:c4ab:b0:45b:47e1:ef6a with SMTP id 5b1f17b1804b1-45b855bec54mr132648795e9.37.1756895282086;
        Wed, 03 Sep 2025 03:28:02 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2a30:223c:d73b:565a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9ab7c7dbsm55992855e9.11.2025.09.03.03.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:28:01 -0700 (PDT)
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
Subject: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms
Date: Wed,  3 Sep 2025 12:27:56 +0200
Message-ID: <20250903102756.1748596-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
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
 drivers/iio/adc/nxp-sar-adc.c | 1046 +++++++++++++++++++++++++++++++++
 3 files changed, 1060 insertions(+)
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
index 000000000000..666f907aa03b
--- /dev/null
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -0,0 +1,1046 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP SAR-ADC driver (adapted from Freescale Vybrid vf610 ADC driver
+ * by Fugang Duan <B38611@freescale.com>)
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ * Copyright 2017, 2020-2025 NXP
+ * Copyright 2025, Linaro Ltd
+ */
+#include <linux/circ_buf.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
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
+#define REG_ADC_MCR(__base)		(__base)
+
+#define REG_ADC_MCR_PWDN		BIT(0)
+#define REG_ADC_MCR_ACKO		BIT(5)
+#define REG_ADC_MCR_ADCLKSEL		BIT(8)
+#define REG_ADC_MCR_TSAMP_MASK		GENMASK(10, 9)
+#define REG_ADC_MCR_NRSMPL_32		BIT(11)
+#define REG_ADC_MCR_NRSMPL_128		BIT(12)
+#define REG_ADC_MCR_NRSMPL_512		(BIT(11) | BIT(12))
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
+#define NXP_SAR_ADC_CAL_TIMEOUT_US	100000
+#define NXP_SAR_ADC_WAIT_US		2000
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
+#define NXP_SAR_ADC_DMA_SAMPLE_SZ	DMA_SLAVE_BUSWIDTH_4_BYTES
+#define NXP_SAR_ADC_DMA_BUFF_SZ		(PAGE_SIZE * NXP_SAR_ADC_DMA_SAMPLE_SZ)
+#define NXP_SAR_ADC_DMA_SAMPLE_CNT	(NXP_SAR_ADC_DMA_BUFF_SZ / NXP_SAR_ADC_DMA_SAMPLE_SZ)
+
+struct nxp_sar_adc {
+	void __iomem *regs;
+	phys_addr_t regs_phys;
+	struct clk *clk;
+
+	u16 value;
+	u32 vref;
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
+	u32 vref;
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
+	ret = read_poll_timeout(readl, msr, !(msr & REG_ADC_MSR_CALBUSY),
+				NXP_SAR_ADC_WAIT_US,
+				NXP_SAR_ADC_CAL_TIMEOUT_US,
+				true, REG_ADC_MSR(base));
+	if (ret)
+		return ret;
+
+	if (!(msr & REG_ADC_MSR_CALFAIL))
+		return 0;
+
+	/*
+	 * If the calibration fails, the status register bit must be
+	 * cleared
+	 */
+	msr &= ~REG_ADC_MSR_CALFAIL;
+
+	writel(msr, REG_ADC_MSR(base));
+
+	return -EAGAIN;
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
+	int i, ret;
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
+		nxp_sar_adc_channels_enable(info, 1 >> chan->channel);
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
+		nxp_sar_adc_channels_disable(info, 1 >> chan->channel);
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
+		*val = info->vref;
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
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void nxp_sar_adc_dma_cb(void *data)
+{
+	struct nxp_sar_adc *info = iio_priv((struct iio_dev *)data);
+	struct iio_dev *indio_dev = data;
+	struct dma_tx_state state;
+	struct circ_buf *dma_buf;
+	struct device *dev_dma;
+	unsigned long flags;
+	u32 *dma_samples;
+	s64 timestamp;
+	int idx, ret;
+
+	dma_buf = &info->dma_buf;
+	dma_samples = (u32 *)dma_buf->buf;
+	dev_dma = info->dma_chan->device->dev;
+	spin_lock_irqsave(&info->lock, flags);
+	dmaengine_tx_status(info->dma_chan,
+			    info->cookie, &state);
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
+	spin_unlock_irqrestore(&info->lock, flags);
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
+	for_each_set_bit(channel, indio_dev->active_scan_mask, NXP_SAR_ADC_NR_CHANNELS) {
+		info->buffered_chan[info->channels_used++] = channel;
+	}
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
+	if (ret) {
+		nxp_sar_adc_dma_remove(info);
+		return ret;
+	}
+
+	return 0;
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
+	const u32 mcr_default	= 0x00003901;
+	const u32 msr_default	= 0x00000001;
+	const u32 ctr_default	= 0x00000014;
+	const u32 cimr_default	= 0x00000000;
+	const u32 ncmr_default	= 0x00000000;
+
+	writel(mcr_default, REG_ADC_MCR(info->regs));
+	writel(msr_default, REG_ADC_MSR(info->regs));
+	writel(ctr_default, REG_ADC_CTR0(info->regs));
+	writel(ctr_default, REG_ADC_CTR1(info->regs));
+	writel(cimr_default, REG_ADC_CIMR0(info->regs));
+	writel(cimr_default, REG_ADC_CIMR1(info->regs));
+	writel(ncmr_default, REG_ADC_NCMR0(info->regs));
+	writel(ncmr_default, REG_ADC_NCMR1(info->regs));
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
+	data = of_device_get_match_data(dev);
+
+	info->vref = data->vref;
+
+	info->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
+	if (IS_ERR(info->regs))
+		return dev_err_probe(dev, PTR_ERR(info->regs),
+				     "failed to get and remap resource");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "no irq resource\n");
+
+	ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
+			       dev_name(dev), indio_dev);
+	if (ret < 0)
+		dev_err_probe(dev, ret, "failed requesting irq, irq = %d\n", irq);
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
+	if (ret) {
+		dev_err(dev, "Failed to initialize the dma\n");
+		return ret;
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &nxp_sar_adc_trigger_handler,
+					      &iio_triggered_buffer_setup_ops);
+	if (ret < 0) {
+		dev_err(dev, "Couldn't initialise the buffer\n");
+		return ret;
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "Couldn't register the device.\n");
+		return ret;
+	}
+
+	dev_info(dev, "Device initialized successfully.\n");
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
+	iio_device_unregister(indio_dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
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
+#endif
+
+static SIMPLE_DEV_PM_OPS(nxp_sar_adc_pm_ops, nxp_sar_adc_suspend, nxp_sar_adc_resume);
+
+static const struct nxp_sar_adc_data s32g2_sar_adc_data = { .vref = 1800 };
+
+static const struct of_device_id nxp_sar_adc_match[] = {
+	{ .compatible = "nxp,s32g2-sar-adc", .data = &s32g2_sar_adc_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, nxp_sar_adc_match);
+
+static struct platform_driver nxp_sar_adc_driver = {
+	.probe          = nxp_sar_adc_probe,
+	.remove         = nxp_sar_adc_remove,
+	.driver         = {
+		.name   = DRIVER_NAME,
+		.of_match_table = nxp_sar_adc_match,
+#ifdef CONFIG_PM_SLEEP
+		.pm     = &nxp_sar_adc_pm_ops,
+#endif
+	},
+};
+
+module_platform_driver(nxp_sar_adc_driver);
+
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("NXP SAR-ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


