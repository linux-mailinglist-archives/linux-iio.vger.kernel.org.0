Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F492BC92B
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 21:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgKVUaV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 15:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgKVUaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2020 15:30:19 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5418C0613CF;
        Sun, 22 Nov 2020 12:30:19 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id y11so7623660qvu.10;
        Sun, 22 Nov 2020 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDdSV1LnKzQU3hHNIbM2yw4LJDpxHkHNKoSeVkAnN/4=;
        b=UHqiToxJoNSsiSi3IrimHWeeIJiKW6kGdA3Kz9hx8EWewPC04DngS0y4mz/nYyJ950
         VOYnno2dVvZp/NMF17/jug0dzBpIQQ0yeau30T2+KaHpa+IdSMVVjiTPbOtv29qc5J6w
         c4Jts8dgUCpdViORWlqfqI/bqs6fxqd+fyqyL1SzlX9D3V51owCcZ8j6RBKy5cJZhFrf
         DX8P3WyHqmPCEHY8yE3npDc2otIDc5UxEyy4575nqdJ5P1/5e1IqvTaHp8lLXsmSj1/7
         ic/sX2QI9N9UVFKdV+RFdIEu0JpjS5i/87LmjtQWqGObYbMROQUg+BRKlZNUKrq56ufC
         G6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDdSV1LnKzQU3hHNIbM2yw4LJDpxHkHNKoSeVkAnN/4=;
        b=kdcuAI/PI4vLizLFSm/snyr9lLuP6eRKLiAnFnjxX3GOi5WDTX2L4KwlMGG5uy+mKO
         a1vMmxOB4PeVAPYD8j7P2HAYFiffAaV78YSHKk6HoH17V61OcB1JUuwLLz7cwR/B1j//
         Y3ERT/cigOZp11Cx0MPDS5aBuIRoZ/dWY9SIJ+nOBDjiz/SfNxC1lum45HytVsqPwneW
         9ZI611oesKhunaukhdRtF3WUT/eYJjaIRAcqTEK56BTSaQeEuqJ2fye1eiHYZue+00gx
         SEkVDnbpr0RJiEXuOZTAbLW8fqegHy6NhJFW/2a6gKe5g84iwH0Uu7JZwGfH4xJBZl8o
         Q24g==
X-Gm-Message-State: AOAM531ygX3HXDvBvNdxmrDx3zgZ70SE/vHAkzMPHWgSUHSMKxEVWR6F
        WJd6I1sC4TgCUq5ExNz6PXM=
X-Google-Smtp-Source: ABdhPJwhb4FYMk4UmoIjyLfDXPgL5aPhRheLn/ca+gBVeWRBpdTG7viqjmUPTvZi6fKOHmwBL4US2w==
X-Received: by 2002:a0c:a959:: with SMTP id z25mr9091266qva.51.1606077018747;
        Sun, 22 Nov 2020 12:30:18 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id p73sm7446522qka.79.2020.11.22.12.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 12:30:18 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 5/5] counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
Date:   Sun, 22 Nov 2020 15:29:56 -0500
Message-Id: <4942ff8bbdd782340a3fd028e0e04c6e98e9940c.1606075915.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606075915.git.vilhelm.gray@gmail.com>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The LSI/CSI LS7266R1 chip provides programmable output via the FLG pins.
When interrupts are enabled on the ACCES 104-QUAD-8, they occur whenever
FLG1 is active. Four functions are available for the FLG1 signal: Carry,
Compare, Carry-Borrow, and Index.

	Carry:
		Interrupt generated on active low Carry signal. Carry
		signal toggles every time the respective channel's
		counter overflows.

	Compare:
		Interrupt generated on active low Compare signal.
		Compare signal toggles every time respective channel's
		preset register is equal to the respective channel's
		counter.

	Carry-Borrow:
		Interrupt generated on active low Carry signal and
		active low Borrow signal. Carry signal toggles every
		time the respective channel's counter overflows. Borrow
		signal toggles every time the respective channel's
		counter underflows.

	Index:
		Interrupt generated on active high Index signal.

The irq_trigger Count extension is introduced to allow the selection of
the desired IRQ trigger function per channel. The irq_trigger_enable
Count extension is introduced to allow the enablement of interrupts for
a respective channel. Interrupts push Counter events to event channel X,
where 'X' is the respective channel whose FLG1 activated.

This patch adds IRQ support for the ACCES 104-QUAD-8. The interrupt line
numbers for the devices may be configured via the irq array module
parameter.

Reviewed-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |  32 ++
 drivers/counter/104-quad-8.c                  | 306 ++++++++++++++----
 drivers/counter/Kconfig                       |   6 +-
 3 files changed, 273 insertions(+), 71 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
index eac32180c40d..995bf08d365d 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
+++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
@@ -1,3 +1,35 @@
+What:		/sys/bus/counter/devices/counterX/countY/irq_trigger
+KernelVersion:	5.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		IRQ trigger function for channel Y. Four trigger functions are
+		available: carry, compare, carry-borrow, and index.
+
+		carry:
+			Interrupt generated on active low Carry signal. Carry
+			signal toggles every time channel Y counter overflows.
+
+		compare:
+			Interrupt generated on active low Compare signal.
+			Compare signal toggles every time channel Y preset
+			register is equal to channel Y counter.
+
+		carry-borrow:
+			Interrupt generated on active low Carry signal and
+			active low Borrow signal. Carry signal toggles every
+			time channel Y counter overflows. Borrow signal toggles
+			every time channel Y counter underflows.
+
+		index:
+			Interrupt generated on active high Index signal.
+
+What:		/sys/bus/counter/devices/counterX/countY/irq_trigger_enable
+KernelVersion:	5.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether generation of interrupts is enabled for channel Y. Valid
+		attribute values are boolean.
+
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault
 KernelVersion:	5.7
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 92a3809609e9..c6948e31c6d6 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -13,23 +13,30 @@
 #include <linux/iio/types.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/interrupt.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
+#include <linux/spinlock.h>
 
 #define QUAD8_EXTENT 32
 
 static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
 static unsigned int num_quad8;
-module_param_array(base, uint, &num_quad8, 0);
+module_param_hw_array(base, uint, ioport, &num_quad8, 0);
 MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 
+static unsigned int irq[max_num_isa_dev(QUAD8_EXTENT)];
+module_param_hw_array(irq, uint, irq, NULL, 0);
+MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
+
 #define QUAD8_NUM_COUNTERS 8
 
 /**
  * struct quad8_iio - IIO device private data structure
+ * @lock:		synchronization lock to prevent I/O race conditions
  * @counter:		instance of the counter_device
  * @fck_prescaler:	array of filter clock prescaler configurations
  * @preset:		array of preset values
@@ -38,13 +45,14 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  * @quadrature_scale:	array of quadrature mode scale configurations
  * @ab_enable:		array of A and B inputs enable configurations
  * @preset_enable:	array of set_to_preset_on_index attribute configurations
+ * @irq_trigger:	array of interrupt trigger function configurations
  * @synchronous_mode:	array of index function synchronous mode configurations
  * @index_polarity:	array of index function polarity configurations
  * @cable_fault_enable:	differential encoder cable status enable configurations
  * @base:		base port address of the IIO device
  */
 struct quad8_iio {
-	struct mutex lock;
+	raw_spinlock_t lock;
 	struct counter_device counter;
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
@@ -53,13 +61,16 @@ struct quad8_iio {
 	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
 	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
 	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
+	unsigned int irq_trigger[QUAD8_NUM_COUNTERS];
 	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
 	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
 	unsigned int cable_fault_enable;
 	unsigned int base;
 };
 
+#define QUAD8_REG_INTERRUPT_STATUS 0x10
 #define QUAD8_REG_CHAN_OP 0x11
+#define QUAD8_REG_INDEX_INTERRUPT 0x12
 #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
 #define QUAD8_DIFF_ENCODER_CABLE_STATUS 0x17
 /* Borrow Toggle flip-flop */
@@ -92,8 +103,8 @@ struct quad8_iio {
 #define QUAD8_RLD_CNTR_OUT 0x10
 /* Transfer Preset Register LSB to FCK Prescaler */
 #define QUAD8_RLD_PRESET_PSC 0x18
-#define QUAD8_CHAN_OP_ENABLE_COUNTERS 0x00
 #define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
+#define QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC 0x04
 #define QUAD8_CMR_QUADRATURE_X1 0x08
 #define QUAD8_CMR_QUADRATURE_X2 0x10
 #define QUAD8_CMR_QUADRATURE_X4 0x18
@@ -107,6 +118,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 	unsigned int flags;
 	unsigned int borrow;
 	unsigned int carry;
+	unsigned long irqflags;
 	int i;
 
 	switch (mask) {
@@ -124,7 +136,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 		/* Borrow XOR Carry effectively doubles count range */
 		*val = (borrow ^ carry) << 24;
 
-		mutex_lock(&priv->lock);
+		raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 		/* Reset Byte Pointer; transfer Counter to Output Latch */
 		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
@@ -133,7 +145,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 		for (i = 0; i < 3; i++)
 			*val |= (unsigned int)inb(base_offset) << (8 * i);
 
-		mutex_unlock(&priv->lock);
+		raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_ENABLE:
@@ -153,6 +165,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel;
+	unsigned long flags;
 	int i;
 	unsigned int ior_cfg;
 
@@ -165,7 +178,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		if ((unsigned int)val > 0xFFFFFF)
 			return -EINVAL;
 
-		mutex_lock(&priv->lock);
+		raw_spin_lock_irqsave(&priv->lock, flags);
 
 		/* Reset Byte Pointer */
 		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
@@ -190,7 +203,7 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		/* Reset Error flag */
 		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
 
-		mutex_unlock(&priv->lock);
+		raw_spin_unlock_irqrestore(&priv->lock, flags);
 
 		return 0;
 	case IIO_CHAN_INFO_ENABLE:
@@ -198,25 +211,26 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		if (val < 0 || val > 1)
 			return -EINVAL;
 
-		mutex_lock(&priv->lock);
+		raw_spin_lock_irqsave(&priv->lock, flags);
 
 		priv->ab_enable[chan->channel] = val;
 
-		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
+		ior_cfg = val | priv->preset_enable[chan->channel] << 1 |
+			  priv->irq_trigger[chan->channel] << 3;
 
 		/* Load I/O control configuration */
 		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
-		mutex_unlock(&priv->lock);
+		raw_spin_unlock_irqrestore(&priv->lock, flags);
 
 		return 0;
 	case IIO_CHAN_INFO_SCALE:
-		mutex_lock(&priv->lock);
+		raw_spin_lock_irqsave(&priv->lock, flags);
 
 		/* Quadrature scaling only available in quadrature mode */
 		if (!priv->quadrature_mode[chan->channel] &&
 				(val2 || val != 1)) {
-			mutex_unlock(&priv->lock);
+			raw_spin_unlock_irqrestore(&priv->lock, flags);
 			return -EINVAL;
 		}
 
@@ -232,15 +246,15 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 				priv->quadrature_scale[chan->channel] = 2;
 				break;
 			default:
-				mutex_unlock(&priv->lock);
+				raw_spin_unlock_irqrestore(&priv->lock, flags);
 				return -EINVAL;
 			}
 		else {
-			mutex_unlock(&priv->lock);
+			raw_spin_unlock_irqrestore(&priv->lock, flags);
 			return -EINVAL;
 		}
 
-		mutex_unlock(&priv->lock);
+		raw_spin_unlock_irqrestore(&priv->lock, flags);
 		return 0;
 	}
 
@@ -266,6 +280,7 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel;
 	unsigned int preset;
+	unsigned long irqflags;
 	int ret;
 	int i;
 
@@ -277,7 +292,7 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
 	if (preset > 0xFFFFFF)
 		return -EINVAL;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->preset[chan->channel] = preset;
 
@@ -288,7 +303,7 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
 	for (i = 0; i < 3; i++)
 		outb(preset >> (8 * i), base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return len;
 }
@@ -309,6 +324,7 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel + 1;
 	bool preset_enable;
+	unsigned long irqflags;
 	int ret;
 	unsigned int ior_cfg;
 
@@ -319,17 +335,18 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->preset_enable[chan->channel] = preset_enable;
 
 	ior_cfg = priv->ab_enable[chan->channel] |
-		(unsigned int)preset_enable << 1;
+		  (unsigned int)preset_enable << 1 |
+		  priv->irq_trigger[chan->channel] << 3;
 
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return len;
 }
@@ -387,8 +404,9 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	unsigned int mode_cfg = cnt_mode << 1;
 	const int base_offset = priv->base + 2 * chan->channel + 1;
+	unsigned long irqflags;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->count_mode[chan->channel] = cnt_mode;
 
@@ -399,7 +417,7 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -430,14 +448,15 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel + 1;
 	unsigned int idr_cfg = synchronous_mode;
+	unsigned long irqflags;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	idr_cfg |= priv->index_polarity[chan->channel] << 1;
 
 	/* Index function must be non-synchronous in non-quadrature mode */
 	if (synchronous_mode && !priv->quadrature_mode[chan->channel]) {
-		mutex_unlock(&priv->lock);
+		raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 		return -EINVAL;
 	}
 
@@ -446,7 +465,7 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -476,9 +495,10 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel + 1;
+	unsigned long irqflags;
 	unsigned int mode_cfg;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	mode_cfg = priv->count_mode[chan->channel] << 1;
 
@@ -498,7 +518,7 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -529,8 +549,9 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel + 1;
 	unsigned int idr_cfg = index_polarity << 1;
+	unsigned long irqflags;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	idr_cfg |= priv->synchronous_mode[chan->channel];
 
@@ -539,7 +560,7 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -646,6 +667,7 @@ static int quad8_count_read(struct counter_device *counter,
 	unsigned int flags;
 	unsigned int borrow;
 	unsigned int carry;
+	unsigned long irqflags;
 	int i;
 
 	flags = inb(base_offset + 1);
@@ -655,7 +677,7 @@ static int quad8_count_read(struct counter_device *counter,
 	/* Borrow XOR Carry effectively doubles count range */
 	*val = (unsigned long)(borrow ^ carry) << 24;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Reset Byte Pointer; transfer Counter to Output Latch */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
@@ -664,7 +686,7 @@ static int quad8_count_read(struct counter_device *counter,
 	for (i = 0; i < 3; i++)
 		*val |= (unsigned long)inb(base_offset) << (8 * i);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -674,13 +696,14 @@ static int quad8_count_write(struct counter_device *counter,
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
+	unsigned long irqflags;
 	int i;
 
 	/* Only 24-bit values are supported */
 	if (val > 0xFFFFFF)
 		return -EINVAL;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Reset Byte Pointer */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
@@ -705,7 +728,7 @@ static int quad8_count_write(struct counter_device *counter,
 	/* Reset Error flag */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -723,8 +746,9 @@ static int quad8_function_read(struct counter_device *counter,
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int id = count->id;
+	unsigned long irqflags;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	if (priv->quadrature_mode[id])
 		switch (priv->quadrature_scale[id]) {
@@ -741,7 +765,7 @@ static int quad8_function_read(struct counter_device *counter,
 	else
 		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -755,10 +779,11 @@ static int quad8_function_write(struct counter_device *counter,
 	unsigned int *const scale = priv->quadrature_scale + id;
 	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
 	const int base_offset = priv->base + 2 * id + 1;
+	unsigned long irqflags;
 	unsigned int mode_cfg;
 	unsigned int idr_cfg;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	mode_cfg = priv->count_mode[id] << 1;
 	idr_cfg = priv->index_polarity[id] << 1;
@@ -797,7 +822,7 @@ static int quad8_function_write(struct counter_device *counter,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -915,9 +940,10 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
+	unsigned long irqflags;
 	unsigned int idr_cfg = index_polarity << 1;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	idr_cfg |= priv->synchronous_mode[channel_id];
 
@@ -926,7 +952,7 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -950,15 +976,16 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
+	unsigned long irqflags;
 	unsigned int idr_cfg = synchronous_mode;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	idr_cfg |= priv->index_polarity[channel_id] << 1;
 
 	/* Index function must be non-synchronous in non-quadrature mode */
 	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
-		mutex_unlock(&priv->lock);
+		raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 		return -EINVAL;
 	}
 
@@ -967,7 +994,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -1012,6 +1039,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 	unsigned int count_mode;
 	unsigned int mode_cfg;
 	const int base_offset = priv->base + 2 * count->id + 1;
+	unsigned long irqflags;
 
 	/* Map Generic Counter count mode to 104-QUAD-8 count mode */
 	switch (cnt_mode) {
@@ -1029,7 +1057,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 		break;
 	}
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->count_mode[count->id] = count_mode;
 
@@ -1043,7 +1071,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -1063,18 +1091,20 @@ static int quad8_count_enable_write(struct counter_device *counter,
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
+	unsigned long irqflags;
 	unsigned int ior_cfg;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->ab_enable[count->id] = enable;
 
-	ior_cfg = enable | priv->preset_enable[count->id] << 1;
+	ior_cfg = enable | priv->preset_enable[count->id] << 1 |
+		  priv->irq_trigger[count->id] << 3;
 
 	/* Load I/O control configuration */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -1120,16 +1150,17 @@ static int quad8_count_preset_write(struct counter_device *counter,
 				    struct counter_count *count, u64 preset)
 {
 	struct quad8_iio *const priv = counter->priv;
+	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
 	if (preset > 0xFFFFFF)
 		return -EINVAL;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	quad8_preset_register_set(priv, count->id, preset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -1138,8 +1169,9 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 				    struct counter_count *count, u64 *ceiling)
 {
 	struct quad8_iio *const priv = counter->priv;
+	unsigned long irqflags;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
@@ -1153,7 +1185,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 		break;
 	}
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -1162,12 +1194,13 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 				     struct counter_count *count, u64 ceiling)
 {
 	struct quad8_iio *const priv = counter->priv;
+	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
 	if (ceiling > 0xFFFFFF)
 		return -EINVAL;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
@@ -1177,7 +1210,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 		break;
 	}
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return -EINVAL;
 }
@@ -1199,21 +1232,91 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id + 1;
+	unsigned long irqflags;
 	unsigned int ior_cfg;
 
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->preset_enable[count->id] = preset_enable;
 
-	ior_cfg = priv->ab_enable[count->id] | preset_enable << 1;
+	ior_cfg = priv->ab_enable[count->id] | preset_enable << 1 |
+		  priv->irq_trigger[count->id] << 3;
 
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
+
+	return 0;
+}
+
+static int quad8_irq_trigger_get(struct counter_device *counter,
+				 struct counter_count *count, u8 *irq_trigger)
+{
+	const struct quad8_iio *const priv = counter->priv;
+
+	*irq_trigger = priv->irq_trigger[count->id];
+
+	return 0;
+}
+
+static int quad8_irq_trigger_set(struct counter_device *counter,
+				 struct counter_count *count, u8 irq_trigger)
+{
+	struct quad8_iio *const priv = counter->priv;
+	const unsigned long base_offset = priv->base + 2 * count->id + 1;
+	unsigned long irqflags;
+	unsigned long ior_cfg;
+
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
+
+	priv->irq_trigger[count->id] = irq_trigger;
+
+	ior_cfg = priv->ab_enable[count->id] |
+		  priv->preset_enable[count->id] << 1 | irq_trigger << 3;
+
+	/* Load I/O control configuration to Input / Output Control Register */
+	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
+
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
+
+	return 0;
+}
+
+static int quad8_irq_trigger_enable_read(struct counter_device *counter,
+					 struct counter_count *count, u8 *state)
+{
+	const struct quad8_iio *const priv = counter->priv;
+	unsigned long irq_enabled;
+
+	irq_enabled = inb(priv->base + QUAD8_REG_INDEX_INTERRUPT);
+	*state = !!(irq_enabled & BIT(count->id));
+
+	return 0;
+}
+
+static int quad8_irq_trigger_enable_write(struct counter_device *counter,
+				    struct counter_count *count, u8 state)
+{
+	struct quad8_iio *const priv = counter->priv;
+	unsigned long irqflags;
+	unsigned long irq_enabled;
+
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
+
+	irq_enabled = inb(priv->base + QUAD8_REG_INDEX_INTERRUPT);
+
+	if (state)
+		irq_enabled |= BIT(count->id);
+	else
+		irq_enabled &= ~BIT(count->id);
+
+	outb(irq_enabled, priv->base + QUAD8_REG_INDEX_INTERRUPT);
+
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -1224,22 +1327,23 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
 {
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
+	unsigned long irqflags;
 	bool disabled;
 	unsigned int status;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	disabled = !(priv->cable_fault_enable & BIT(channel_id));
 
 	if (disabled) {
-		mutex_unlock(&priv->lock);
+		raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 		return -EINVAL;
 	}
 
 	/* Logic 0 = cable fault */
 	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	/* Mask respective channel and invert logic */
 	*cable_fault = !(status & BIT(channel_id));
@@ -1265,9 +1369,10 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 {
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
+	unsigned long irqflags;
 	unsigned int cable_fault_enable;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	if (enable)
 		priv->cable_fault_enable |= BIT(channel_id);
@@ -1279,7 +1384,7 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 
 	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -1302,8 +1407,9 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
 	const int base_offset = priv->base + 2 * channel_id;
+	unsigned long irqflags;
 
-	mutex_lock(&priv->lock);
+	raw_spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->fck_prescaler[channel_id] = prescaler;
 
@@ -1315,7 +1421,7 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
 	     base_offset + 1);
 
-	mutex_unlock(&priv->lock);
+	raw_spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -1418,7 +1524,15 @@ static const u8 quad8_cnt_modes[] = {
 
 static DEFINE_COUNTER_AVAILABLE(quad8_count_mode_available, quad8_cnt_modes);
 
+static const char *const quad8_irq_trigger_states[] = {
+	"carry",
+	"compare",
+	"carry-borrow",
+	"index",
+};
+
 static DEFINE_COUNTER_ENUM(quad8_error_noise_enum, quad8_noise_error_states);
+static DEFINE_COUNTER_ENUM(quad8_irq_trigger_enum, quad8_irq_trigger_states);
 
 static struct counter_comp quad8_count_ext[] = {
 	COUNTER_COMP_CEILING(quad8_count_ceiling_read,
@@ -1433,6 +1547,11 @@ static struct counter_comp quad8_count_ext[] = {
 	COUNTER_COMP_PRESET(quad8_count_preset_read, quad8_count_preset_write),
 	COUNTER_COMP_PRESET_ENABLE(quad8_count_preset_enable_read,
 				   quad8_count_preset_enable_write),
+	COUNTER_COMP_COUNT_ENUM("irq_trigger", quad8_irq_trigger_get,
+				quad8_irq_trigger_set, quad8_irq_trigger_enum),
+	COUNTER_COMP_COUNT_BOOL("irq_trigger_enable",
+				quad8_irq_trigger_enable_read,
+				quad8_irq_trigger_enable_write),
 };
 
 #define QUAD8_COUNT(_id, _cntname) {				\
@@ -1457,6 +1576,51 @@ static struct counter_count quad8_counts[] = {
 	QUAD8_COUNT(7, "Channel 8 Count")
 };
 
+static irqreturn_t quad8_irq_handler(int irq, void *quad8iio)
+{
+	struct quad8_iio *const priv = quad8iio;
+	const unsigned long base = priv->base;
+	unsigned long irq_status;
+	unsigned long channel;
+	u8 event;
+	int err;
+
+	irq_status = inb(base + QUAD8_REG_INTERRUPT_STATUS);
+	if (!irq_status)
+		return IRQ_NONE;
+
+	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS) {
+		switch (priv->irq_trigger[channel]) {
+		case 0:
+			event = COUNTER_EVENT_OVERFLOW;
+				break;
+		case 1:
+			event = COUNTER_EVENT_THRESHOLD;
+				break;
+		case 2:
+			event = COUNTER_EVENT_OVERFLOW_UNDERFLOW;
+				break;
+		case 3:
+			event = COUNTER_EVENT_INDEX;
+				break;
+		default:
+			/* We should never reach here */
+			WARN_ONCE(true, "invalid interrupt trigger function %u configured for channel %lu\n",
+				  priv->irq_trigger[channel], channel);
+			continue;
+		}
+		err = counter_push_event(&priv->counter, event, channel);
+		if (err)
+			WARN_ONCE(true, "unable to push counter event %lu for channel %lu (error code %d)\n",
+				  (unsigned long)event, channel, err);
+	}
+
+	/* Clear pending interrupts on device */
+	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base + QUAD8_REG_CHAN_OP);
+
+	return IRQ_HANDLED;
+}
+
 static int quad8_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
@@ -1495,9 +1659,10 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	quad8iio->counter.priv = quad8iio;
 	quad8iio->base = base[id];
 
-	/* Initialize mutex */
-	mutex_init(&quad8iio->lock);
+	raw_spin_lock_init(&quad8iio->lock);
 
+	/* Reset Index/Interrupt Register */
+	outb(0x00, base[id] + QUAD8_REG_INDEX_INTERRUPT);
 	/* Reset all counters and disable interrupt function */
 	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 	/* Set initial configuration for all counters */
@@ -1527,8 +1692,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	}
 	/* Disable Differential Encoder Cable Status for all channels */
 	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
-	/* Enable all counters */
-	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
+	/* Enable all counters and enable interrupt function */
+	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
 
 	/* Register IIO device */
 	err = devm_iio_device_register(dev, indio_dev);
@@ -1536,7 +1701,12 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		return err;
 
 	/* Register Counter device */
-	return devm_counter_register(dev, &quad8iio->counter);
+	err = devm_counter_register(dev, &quad8iio->counter);
+	if (err)
+		return err;
+
+	return devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
+				quad8iio->counter.name, quad8iio);
 }
 
 static struct isa_driver quad8_driver = {
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 2de53ab0dd25..bd42df98f522 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -23,11 +23,11 @@ config 104_QUAD_8
 	  A counter's respective error flag may be cleared by performing a write
 	  operation on the respective count value attribute. Although the
 	  104-QUAD-8 counters have a 25-bit range, only the lower 24 bits may be
-	  set, either directly or via the counter's preset attribute. Interrupts
-	  are not supported by this driver.
+	  set, either directly or via the counter's preset attribute.
 
 	  The base port addresses for the devices may be configured via the base
-	  array module parameter.
+	  array module parameter. The interrupt line numbers for the devices may
+	  be configured via the irq array module parameter.
 
 config STM32_TIMER_CNT
 	tristate "STM32 Timer encoder counter driver"
-- 
2.29.2

