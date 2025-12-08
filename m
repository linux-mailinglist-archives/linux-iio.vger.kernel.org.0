Return-Path: <linux-iio+bounces-26927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C76ECABEE1
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 04:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5238305B7D9
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 03:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C802EBDFB;
	Mon,  8 Dec 2025 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bwz/Xdq2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D262E9729
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163148; cv=none; b=UKEI9vBPko/fmyaF76XHlCB0z77OlUB68RFCqz7+k8T+oxmuzpBSZxURIXff7Jmrhe5PrSammIcabksdAq8+UIZsKaioYB5w6wVwuDIdpiPpyYW1SD+eZCGRDpmo0/c7/j1MJkS28ggebl1xlOdIow7FxeZtsBHvFxvrf+iWxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163148; c=relaxed/simple;
	bh=o3uFZj8uwjErxHYmJWATmCtv0noJuvIaMeGBEzIYSyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTDAZ7u4z9ALc2POJgCysbXCx0Yf+jnrekwgJy0TE95rzAMiUAQRGaMEiTkAE6dng1nPJB641Ghbsps6eNx4N9yhmBCFXzdnMGMvV1aswVzuSvI3iAftv8ljNYABV9GZzkxfi8E0QZhuH/WG/wY6P+2xPp3kmvMdmDcnPgScLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bwz/Xdq2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775ae77516so48068515e9.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 19:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765163140; x=1765767940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2AFPBdB+zIHc08SUXdUENK7CVx17JwYuHGmDp1Nvo4=;
        b=Bwz/Xdq2bKa9zah8N8WzqLASazk8UycUJsNjIdB+MXrfQgPaPJGBSO7o6FMZki402O
         fIVxgrRH0srotRMF5s+y5MpsOF0tkxc8NbA3fpNezJ6B2TJGTfIsCjJw+b4DhgdXZzGy
         ggUjt6Qw+cdVNXqlYwuSt4x+NFjNdY22/TIc1K8GXstQ1WyIOLk3Q+5l09DGUI7kcicb
         KGwB4MJ9TaF3DbM3Ce2zk+Jw1hAg41B27ENq8dWXDn9X5k8qxfyxam+BURUquHo5pFcw
         xxD6QwCt8Iqf/O4tvjcaHTp+2N+iToNF5wxgLU9V57j0dBaNTTbMoPnIr5qTsiDElyAa
         6fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765163140; x=1765767940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2AFPBdB+zIHc08SUXdUENK7CVx17JwYuHGmDp1Nvo4=;
        b=uJzItRlFU/R52Sa3QgNX7C1BsQ9RHKkc2LseAg+mP9pWYuy/ba43mHvohWCNLHClWY
         8LYkc8GA631NQ8vXggGb894VXVOUqnPLBPvlXCdpZYRlfULH72lUEOHrrJQumNpVf9Hc
         fxRSQyehmFZ3nkVMKTM1dh1ERQsTzsuS6CFS3W6DnGYUkrD1zvMfSQYc/iNmZUFH+K87
         yPeTm12uUFSPHfq6hhbdX/8iYg1LcEm5mIq5YbwVFoO2HxtUjjgHjnKItQxJedTXg8LN
         KG1EQh7CoT9ZcHcVaZCiAXs6H9auyQPuo5ZFR6kDPoQmubVMiKKKt1K1mo7wwmzw2+4U
         ro2A==
X-Forwarded-Encrypted: i=1; AJvYcCVAPRQjzNyIXxhjm24c1GA1qDX3Yo35dO1bgrmwuz+Znm/7Q3ViGc3rJtlwabExDfV1LtcJxqCNGJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7coU0ZZZKBSMO/iLZSzE8W9NyCVjSkIOAIDw7PEzrtsnZedC7
	hGAwd7LHquYPChCYxbmBRk4hWlizDubyJPcm1Y91Ngw+gQMdGbRhrov7XP5e2D2Ztpg=
X-Gm-Gg: ASbGnctV/Hzsp44EQ6BUOUSs60SLOrigkiWm8+D1QCPHkkTcDjy7V0OSLDlVSaos9QI
	45uRRCzuV+Rj/Nj9BsnnPpb2Ne+2FCOx3IBt/A/NpHMW7q4wdf88nOgySgqTg/uYZWXLLdvzR1H
	pVqxwcOTy9tUm42ITO2lNMBtSwEEsK6kkns6YEHsvh7ZSCrc2LdmHgvD+NTDt6l0p8wRobIUIpK
	GgqEf+OEKmCpuazZI7AAOwtgFFJYSSjN1ykb688jueF+z/ld63zkWn34kb7twm9U2D+90VG7etC
	mvlppZPKYZPOU9fcsEhDqF7IBCfX44vvkyL140a1uMlC8Lx1uBZ1GgHSjYkHSBdz0EuhIVvL4VN
	4ojfDNUujZK5WUaj0EVGxCXploEr2rU85Lagb1BCpS5G9KpZsfiUti7rr0yBkAXfHb/RKNtURUv
	cVh0ixbXeijS9Mmp2KJLXPWmEeC22GSWw=
X-Google-Smtp-Source: AGHT+IGKLOklsf1nDrQut6uW4Yzz55UBXj5Llc2oBlZGsMPLq6LC9TWgCrTRW+nJfU3U0GEBAcsBew==
X-Received: by 2002:a05:600c:190d:b0:477:ae31:1311 with SMTP id 5b1f17b1804b1-47939dfa526mr61080905e9.13.1765163140067;
        Sun, 07 Dec 2025 19:05:40 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310b8e70sm220564885e9.5.2025.12.07.19.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:05:39 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v1 3/3] counter: Add STM based counter
Date: Mon,  8 Dec 2025 04:04:13 +0100
Message-ID: <20251208030413.3117660-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208030413.3117660-1-daniel.lezcano@linaro.org>
References: <20251208030413.3117660-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP S32G2 automotive platform integrates four Cortex-A53 cores and
three Cortex-M7 cores, along with a large number of timers and
counters. These hardware blocks can be used as clocksources or
clockevents, or as timestamp counters shared across the various
subsystems running alongside the Linux kernel, such as firmware
components. Their actual usage depends on the overall platform
software design.

In a Linux-based system, the kernel controls the counter, which is a
read-only shared resource for the other subsystems. One of its primary
purposes is to act as a common timestamp source for messages or
traces, allowing correlation of events occurring in different
operating system contexts.

These changes introduce a basic counter driver that can start, stop,
and reset the counter. It also handles overflow accounting and
configures the prescaler value.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/counter/Kconfig       |  10 +
 drivers/counter/Makefile      |   1 +
 drivers/counter/nxp-stm-cnt.c | 387 ++++++++++++++++++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 drivers/counter/nxp-stm-cnt.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index d30d22dfe577..bf5b281f194c 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -90,6 +90,16 @@ config MICROCHIP_TCB_CAPTURE
 	  To compile this driver as a module, choose M here: the
 	  module will be called microchip-tcb-capture.
 
+config NXP_STM_CNT
+	tristate "NXP System Timer Module Counter driver"
+	depends on ARCH_S32 || COMPILE_TEST
+	help
+	  Select this option to enable the NXP System Timer Module
+	  Counter driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called nxp_stm_cnt.
+
 config RZ_MTU3_CNT
 	tristate "Renesas RZ/G2L MTU3a counter driver"
 	depends on RZ_MTU3
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 40e644948e7a..196b3c216875 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_I8254)			+= i8254.o
 obj-$(CONFIG_INTEL_QEP)			+= intel-qep.o
 obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
 obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
+obj-$(CONFIG_NXP_STM_CNT)		+= nxp-stm-cnt.o
 obj-$(CONFIG_RZ_MTU3_CNT)		+= rz-mtu3-cnt.o
 obj-$(CONFIG_STM32_TIMER_CNT)		+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)		+= stm32-lptimer-cnt.o
diff --git a/drivers/counter/nxp-stm-cnt.c b/drivers/counter/nxp-stm-cnt.c
new file mode 100644
index 000000000000..ff6db07962f4
--- /dev/null
+++ b/drivers/counter/nxp-stm-cnt.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018,2021-2025 NXP
+ * Copyright 2025 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * NXP S32G System Timer Module counters:
+ *
+ *  STM supports commonly required system and application software
+ *  timing functions. STM includes a 32-bit count-up timer and four
+ *  32-bit compare channels with a separate interrupt source for each
+ *  channel. The timer is driven by the STM module clock divided by an
+ *  8-bit prescale value (1 to 256). It has ability to stop the timer
+ *  in Debug mode
+ *
+ */
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/counter.h>
+#include <linux/pm.h>
+#include <linux/bitops.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define STM_CR(__base)		(__base)
+#define STM_CR_TEN		BIT(0)
+#define STM_CR_FRZ		BIT(1)
+#define STM_CR_CPS_MASK         GENMASK(15, 8)
+
+#define STM_CCR0(__base)	((__base) + 0x10)
+#define STM_CCR_CEN		BIT(0)
+
+#define STM_CIR0(__base)	((__base) + 0x14)
+#define STM_CIR_CIF		BIT(0)
+
+#define STM_CMP0(__base)	((__base) + 0x18)
+
+#define STM_CNT(__base)		((__base) + 0x04)
+
+#define STM_ENABLE_MASK	(STM_CR_FRZ | STM_CR_TEN)
+
+struct nxp_stm_cnt {
+	spinlock_t lock;
+	void __iomem *base;
+	u64 overflow;
+	u32 counter;
+	u8 prescaler;
+	bool is_started;
+};
+
+static void nxp_stm_cnt_enable(struct nxp_stm_cnt *stm_cnt)
+{
+	u32 reg;
+
+	reg = readl(STM_CR(stm_cnt->base));
+
+	reg |= STM_ENABLE_MASK;
+
+	writel(reg, STM_CR(stm_cnt->base));
+}
+
+static void nxp_stm_cnt_disable(struct nxp_stm_cnt *stm_cnt)
+{
+	u32 reg;
+
+	reg = readl(STM_CR(stm_cnt->base));
+
+	reg &= ~STM_ENABLE_MASK;
+
+	writel(reg, STM_CR(stm_cnt->base));
+}
+
+static void nxp_stm_cnt_ccr_disable(struct nxp_stm_cnt *stm_cnt)
+{
+	writel(0, STM_CCR0(stm_cnt->base));
+}
+
+static void nxp_stm_cnt_ccr_enable(struct nxp_stm_cnt *stm_cnt)
+{
+	writel(STM_CCR_CEN, STM_CCR0(stm_cnt->base));
+}
+
+static void nxp_stm_cnt_set_overflow(struct nxp_stm_cnt *stm_cnt)
+{
+	writel(UINT_MAX, STM_CMP0(stm_cnt->base));
+}
+
+static u32 nxp_stm_cnt_get_counter(struct nxp_stm_cnt *stm_cnt)
+{
+	return readl(STM_CNT(stm_cnt->base));
+}
+
+static void nxp_stm_cnt_set_counter(struct nxp_stm_cnt *stm_cnt, u32 counter)
+{
+	writel(counter, STM_CNT(stm_cnt->base));
+}
+
+static void nxp_stm_cnt_set_prescaler(struct nxp_stm_cnt *stm_cnt, u8 prescaler)
+{
+	u32 reg;
+
+	reg = readl(STM_CR(stm_cnt->base));
+
+	FIELD_MODIFY(STM_CR_CPS_MASK, &reg, prescaler);
+
+	writel(reg, STM_CR(stm_cnt->base));
+}
+
+static u8 nxp_stm_cnt_get_prescaler(struct nxp_stm_cnt *stm_cnt)
+{
+	u32 reg = readl(STM_CR(stm_cnt->base));
+
+	return FIELD_GET(STM_CR_CPS_MASK, reg);
+}
+
+static bool nxp_stm_cnt_is_started(struct nxp_stm_cnt *stm_cnt)
+{
+	u32 reg;
+
+	reg = readl(STM_CR(stm_cnt->base));
+
+	return !!FIELD_GET(STM_CR_TEN, reg);
+}
+
+static void nxp_stm_cnt_irq_ack(struct nxp_stm_cnt *stm_cnt)
+{
+	writel(STM_CIR_CIF, STM_CIR0(stm_cnt->base));
+}
+
+static irqreturn_t nxp_stm_cnt_irq(int irq, void *dev_id)
+{
+	struct nxp_stm_cnt *stm_cnt = dev_id;
+
+	nxp_stm_cnt_irq_ack(stm_cnt);
+
+	spin_lock(&stm_cnt->lock);
+	stm_cnt->overflow++;
+	spin_unlock(&stm_cnt->lock);
+
+	return IRQ_HANDLED;
+}
+
+static void nxp_stm_cnt_start(struct nxp_stm_cnt *stm_cnt)
+{
+	nxp_stm_cnt_ccr_enable(stm_cnt);
+	nxp_stm_cnt_set_overflow(stm_cnt);
+	nxp_stm_cnt_enable(stm_cnt);
+}
+
+static void nxp_stm_cnt_stop(struct nxp_stm_cnt *stm_cnt)
+{
+	nxp_stm_cnt_disable(stm_cnt);
+	nxp_stm_cnt_irq_ack(stm_cnt);
+	nxp_stm_cnt_ccr_disable(stm_cnt);
+}
+
+static int nxp_stm_cnt_overflow_read(struct counter_device *counter,
+				     struct counter_count *count, u64 *val)
+{
+	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&stm_cnt->lock, irqflags);
+	*val = stm_cnt->overflow;
+	spin_unlock_irqrestore(&stm_cnt->lock, irqflags);
+
+	return 0;
+}
+
+static int nxp_stm_cnt_overflow_write(struct counter_device *counter,
+				      struct counter_count *count, u64 val)
+{
+	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&stm_cnt->lock, irqflags);
+	stm_cnt->overflow = val;
+	spin_unlock_irqrestore(&stm_cnt->lock, irqflags);
+
+	return 0;
+}
+
+static int nxp_stm_cnt_reset_write(struct counter_device *counter,
+				   struct counter_count *count, u8 val)
+{
+	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
+
+	nxp_stm_cnt_set_counter(stm_cnt, 0);
+	spin_lock(&stm_cnt->lock);
+	stm_cnt->overflow = 0;
+	spin_unlock(&stm_cnt->lock);
+
+	return 0;
+}
+
+static int nxp_stm_cnt_prescaler_read(struct counter_device *counter,
+				      struct counter_count *count, u8 *val)
+{
+	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
+
+	*val = nxp_stm_cnt_get_prescaler(stm_cnt);
+
+	return 0;
+}
+
+static int nxp_stm_cnt_prescaler_write(struct counter_device *counter,
+				       struct counter_count *count, u8 val)
+{
+	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
+
+	nxp_stm_cnt_set_prescaler(stm_cnt, val);
+
+	return 0;
+}
+
+static int nxp_stm_cnt_count_enable_write(struct counter_device *counter,
+					  struct counter_count *count, u8 enable)
+{
+	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
+
+	if (enable)
+		nxp_stm_cnt_start(stm_cnt);
+	else
+		nxp_stm_cnt_stop(stm_cnt);
+
+	return 0;
+}
+
+static int nxp_stm_cnt_count_enable_read(struct counter_device *counter,
+					 struct counter_count *count, u8 *enable)
+{
+	struct nxp_stm_cnt *stm_cnt = counter_priv(counter);
+
+	*enable = nxp_stm_cnt_is_started(stm_cnt);
+
+	return 0;
+}
+
+static struct counter_comp stm_cnt_count_ext[] = {
+	COUNTER_COMP_COUNT_BOOL("reset",  NULL, nxp_stm_cnt_reset_write),
+	COUNTER_COMP_COUNT_U8("prescaler", nxp_stm_cnt_prescaler_read, nxp_stm_cnt_prescaler_write),
+	COUNTER_COMP_COUNT_U64("overflows", nxp_stm_cnt_overflow_read, nxp_stm_cnt_overflow_write),
+	COUNTER_COMP_ENABLE(nxp_stm_cnt_count_enable_read, nxp_stm_cnt_count_enable_write),
+};
+
+static int nxp_stm_cnt_count_read(struct counter_device *dev,
+				  struct counter_count *count, u64 *val)
+{
+	struct nxp_stm_cnt *stm_cnt = counter_priv(dev);
+
+	*val = nxp_stm_cnt_get_counter(stm_cnt);
+
+	return 0;
+}
+
+static const struct counter_ops nxp_stm_cnt_counter_ops = {
+	.count_read  = nxp_stm_cnt_count_read,
+};
+
+static struct counter_count nxp_stm_cnt_counts[] = {
+	{
+		.id = 0,
+		.name = "stm_cnt",
+		.ext = stm_cnt_count_ext,
+		.num_ext = ARRAY_SIZE(stm_cnt_count_ext),
+	},
+};
+
+static int nxp_stm_cnt_suspend(struct device *dev)
+{
+	struct nxp_stm_cnt *stm_cnt = dev_get_drvdata(dev);
+
+	stm_cnt->is_started = nxp_stm_cnt_is_started(stm_cnt);
+
+	if (stm_cnt->is_started) {
+		nxp_stm_cnt_stop(stm_cnt);
+		stm_cnt->prescaler = nxp_stm_cnt_get_prescaler(stm_cnt);
+		stm_cnt->counter = nxp_stm_cnt_get_counter(stm_cnt);
+	}
+
+	return 0;
+}
+
+static int nxp_stm_cnt_resume(struct device *dev)
+{
+	struct nxp_stm_cnt *stm_cnt = dev_get_drvdata(dev);
+
+	if (stm_cnt->is_started) {
+		nxp_stm_cnt_set_counter(stm_cnt, stm_cnt->counter);
+		nxp_stm_cnt_set_prescaler(stm_cnt, stm_cnt->prescaler);
+		nxp_stm_cnt_start(stm_cnt);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops nxp_stm_cnt_pm_ops = {
+	.suspend = nxp_stm_cnt_suspend,
+	.resume  = nxp_stm_cnt_resume,
+};
+
+static int nxp_stm_cnt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct counter_device *counter;
+	struct nxp_stm_cnt *stm_cnt;
+	struct clk *clk;
+	void __iomem *base;
+	int irq, ret;
+
+	base = devm_of_iomap(dev, np, 0, NULL);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "Failed to iomap %pOFn\n", np);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Clock not found\n");
+
+	counter = devm_counter_alloc(dev, sizeof(*stm_cnt));
+	if (!counter)
+		return -ENOMEM;
+
+	stm_cnt = counter_priv(counter);
+
+	stm_cnt->base = base;
+	stm_cnt->overflow = 0;
+	spin_lock_init(&stm_cnt->lock);
+
+	counter->name       = "stm_counter";
+	counter->parent     = &pdev->dev;
+	counter->ops        = &nxp_stm_cnt_counter_ops;
+	counter->counts     = nxp_stm_cnt_counts;
+	counter->num_counts = ARRAY_SIZE(nxp_stm_cnt_counts);
+
+	ret = devm_request_irq(dev, irq, nxp_stm_cnt_irq, IRQF_TIMER | IRQF_NOBALANCING,
+			       dev_name(&counter->dev), stm_cnt);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to allocate interrupt line\n");
+
+	ret = devm_counter_add(dev, counter);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register counter\n");
+
+	platform_set_drvdata(pdev, stm_cnt);
+
+	return 0;
+}
+
+static void nxp_stm_cnt_remove(struct platform_device *pdev)
+{
+	struct nxp_stm_cnt *stm_cnt = platform_get_drvdata(pdev);
+
+	if (nxp_stm_cnt_is_started(stm_cnt))
+		nxp_stm_cnt_stop(stm_cnt);
+}
+
+static const struct of_device_id nxp_stm_cnt_of_match[] = {
+	{ .compatible = "nxp,s32g2-stm", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nxp_stm_cnt_of_match);
+
+static struct platform_driver nxp_stm_cnt_driver = {
+	.probe  = nxp_stm_cnt_probe,
+	.remove = nxp_stm_cnt_remove,
+	.driver = {
+		.name           = "nxp-stm-cnt",
+		.of_match_table = nxp_stm_cnt_of_match,
+	},
+};
+module_platform_driver(nxp_stm_cnt_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Daniel Lezcano");
+MODULE_DESCRIPTION("NXP System Timer Module counter driver");
+MODULE_IMPORT_NS("COUNTER");
-- 
2.43.0


