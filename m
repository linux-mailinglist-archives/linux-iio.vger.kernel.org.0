Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764AF3326F0
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhCINXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhCINXF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:23:05 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FA9C06174A;
        Tue,  9 Mar 2021 05:23:04 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id n9so7798620pgi.7;
        Tue, 09 Mar 2021 05:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oWakiYpT0xXwfQsuTaJUoNlRwTEXD7Xbq7I9eeif91U=;
        b=p3/lhCup3JrB82x9/r4b91kWwLaLM+bP6/fUMzJzikNQO2K+Krcp1ogH4iRF9BD1wr
         KFNHjvax37//Jv8yzcRgTe9M1VWJA9RyIp1KlczKp8Wd4vzb+OlIeUMDPoiuZvvcDGiP
         PG34qtcb2dvTLlN6UHj0W5H8J/gU4M+i3plTn/949Rg88HWtIToQ4P6nv2xkG7KB9tWm
         PdJXrxYJdnGl8cI5qaUZEznl8+ypVD2zO5fjxCGcG3hrNlZmCjv+Rzr+wUSMcloEQpNu
         Qh7cyX0tj5dF8NN+VQ5jqrp0mkNU7VrBamLO9uClVHtRdePj1chkyL2XDaPa8UxRJPcb
         gczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWakiYpT0xXwfQsuTaJUoNlRwTEXD7Xbq7I9eeif91U=;
        b=tO1rbtOb240JxPTZoF0Ju8nFmEcNbhA3xlbZU49ib4x0xR8AmZhblZc+3cEaq7I39Q
         eFk6S9VML2vUbhrmBQULe8HEh1VxZsL2LxD7qbEGp8+ArqapuW5xtJDOOr8Pm0kp5x/U
         jAnfdyCCI0bhASKSIBuQX8TH8RcEadUJZ39Y0CaG2YrjfvpIGigZMocs38T+UCyjVo3Q
         m8a6e0GOAAHWUwzaqlRPQ7WrBhCIeT/JNFZU26ZHLD+/20NodLMiSrHxRnbkIhjl+6la
         pnHBwLePcZZljjU+r1f2LLBHjAUQxoYIDtUvZGJ/K2Apn5NJZbvoxwccToVzBmV/4C72
         /C3A==
X-Gm-Message-State: AOAM53031p9VNcATbol9jTgPrvYdrTOkOxp2SO5OlXpODZPBV7VHCT6Z
        0qLDUU9/+rHeS3cJvQ5MY9c=
X-Google-Smtp-Source: ABdhPJzw5PB3n1upDXlO100EBSOSc4gH/Xl+cMUBNjlNOtjplbVGNWtl8FRYVugkBvoEfbNx3jg32A==
X-Received: by 2002:a62:7708:0:b029:1ee:f656:51d5 with SMTP id s8-20020a6277080000b02901eef65651d5mr26195025pfc.59.1615296184322;
        Tue, 09 Mar 2021 05:23:04 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:23:03 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 33/33] counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8
Date:   Tue,  9 Mar 2021 22:19:46 +0900
Message-Id: <2368417d253917b7a2c3e0e952dd6e4fa3815e8e.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
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

These four functions correspond respectivefly to the following four
Counter event types: COUNTER_EVENT_OVERFLOW, COUNTER_EVENT_THRESHOLD,
COUNTER_EVENT_OVERFLOW_UNDERFLOW, and COUNTER_EVENT_INDEX. Interrupts
push Counter events to event channel X, where 'X' is the respective
channel whose FLG1 activated.

This patch adds IRQ support for the ACCES 104-QUAD-8. The interrupt line
numbers for the devices may be configured via the irq array module
parameter.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 167 +++++++++++++++++++++++++++++++++--
 drivers/counter/Kconfig      |   6 +-
 2 files changed, 164 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index d46b8101f207..09b0b0ba8fe7 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/interrupt.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -25,6 +26,10 @@ static unsigned int num_quad8;
 module_param_hw_array(base, uint, ioport, &num_quad8, 0);
 MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 
+static unsigned int irq[max_num_isa_dev(QUAD8_EXTENT)];
+module_param_hw_array(irq, uint, irq, NULL, 0);
+MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
+
 #define QUAD8_NUM_COUNTERS 8
 
 /**
@@ -38,6 +43,8 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  * @quadrature_scale:	array of quadrature mode scale configurations
  * @ab_enable:		array of A and B inputs enable configurations
  * @preset_enable:	array of set_to_preset_on_index attribute configurations
+ * @irq_trigger:	array of current IRQ trigger function configurations
+ * @next_irq_trigger:	array of next IRQ trigger function configurations
  * @synchronous_mode:	array of index function synchronous mode configurations
  * @index_polarity:	array of index function polarity configurations
  * @cable_fault_enable:	differential encoder cable status enable configurations
@@ -53,13 +60,17 @@ struct quad8 {
 	unsigned int quadrature_scale[QUAD8_NUM_COUNTERS];
 	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
 	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
+	unsigned int irq_trigger[QUAD8_NUM_COUNTERS];
+	unsigned int next_irq_trigger[QUAD8_NUM_COUNTERS];
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
@@ -92,8 +103,8 @@ struct quad8 {
 #define QUAD8_RLD_CNTR_OUT 0x10
 /* Transfer Preset Register LSB to FCK Prescaler */
 #define QUAD8_RLD_PRESET_PSC 0x18
-#define QUAD8_CHAN_OP_ENABLE_COUNTERS 0x00
 #define QUAD8_CHAN_OP_RESET_COUNTERS 0x01
+#define QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC 0x04
 #define QUAD8_CMR_QUADRATURE_X1 0x08
 #define QUAD8_CMR_QUADRATURE_X2 0x10
 #define QUAD8_CMR_QUADRATURE_X4 0x18
@@ -378,13 +389,103 @@ static int quad8_action_read(struct counter_device *counter,
 	}
 }
 
+enum {
+	QUAD8_EVENT_NONE = -1,
+	QUAD8_EVENT_CARRY = 0,
+	QUAD8_EVENT_COMPARE = 1,
+	QUAD8_EVENT_CARRY_BORROW = 2,
+	QUAD8_EVENT_INDEX = 3,
+};
+
+static int quad8_events_configure(struct counter_device *counter)
+{
+	struct quad8 *const priv = counter->priv;
+	unsigned long irq_enabled = 0;
+	unsigned long irqflags;
+	size_t channel;
+	unsigned long ior_cfg;
+	unsigned long base_offset;
+
+	spin_lock_irqsave(&priv->lock, irqflags);
+
+	/* Enable interrupts for the requested channels, disable for the rest */
+	for (channel = 0; channel < QUAD8_NUM_COUNTERS; channel++) {
+		if (priv->next_irq_trigger[channel] == QUAD8_EVENT_NONE)
+			continue;
+
+		if (priv->irq_trigger[channel] != priv->next_irq_trigger[channel]) {
+			/* Save new IRQ function configuration */
+			priv->irq_trigger[channel] = priv->next_irq_trigger[channel];
+
+			/* Load configuration to I/O Control Register */
+			ior_cfg = priv->ab_enable[channel] |
+				  priv->preset_enable[channel] << 1 |
+				  priv->irq_trigger[channel] << 3;
+			base_offset = priv->base + 2 * channel + 1;
+			outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
+		}
+
+		/* Reset next IRQ trigger function configuration */
+		priv->next_irq_trigger[channel] = QUAD8_EVENT_NONE;
+
+		/* Enable IRQ line */
+		irq_enabled |= BIT(channel);
+	}
+
+	outb(irq_enabled, priv->base + QUAD8_REG_INDEX_INTERRUPT);
+
+	spin_unlock_irqrestore(&priv->lock, irqflags);
+
+	return 0;
+}
+
+static int quad8_watch_validate(struct counter_device *counter,
+				const struct counter_watch *watch)
+{
+	struct quad8 *const priv = counter->priv;
+
+	if (watch->channel > QUAD8_NUM_COUNTERS - 1)
+		return -EINVAL;
+
+	switch (watch->event) {
+	case COUNTER_EVENT_OVERFLOW:
+		if (priv->next_irq_trigger[watch->channel] == QUAD8_EVENT_NONE)
+			priv->next_irq_trigger[watch->channel] = QUAD8_EVENT_CARRY;
+		else if (priv->next_irq_trigger[watch->channel] != QUAD8_EVENT_CARRY)
+			return -EINVAL;
+		return 0;
+	case COUNTER_EVENT_THRESHOLD:
+		if (priv->next_irq_trigger[watch->channel] == QUAD8_EVENT_NONE)
+			priv->next_irq_trigger[watch->channel] = QUAD8_EVENT_COMPARE;
+		else if (priv->next_irq_trigger[watch->channel] != QUAD8_EVENT_COMPARE)
+			return -EINVAL;
+		return 0;
+	case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
+		if (priv->next_irq_trigger[watch->channel] == QUAD8_EVENT_NONE)
+			priv->next_irq_trigger[watch->channel] = QUAD8_EVENT_CARRY_BORROW;
+		else if (priv->next_irq_trigger[watch->channel] != QUAD8_EVENT_CARRY_BORROW)
+			return -EINVAL;
+		return 0;
+	case COUNTER_EVENT_INDEX:
+		if (priv->next_irq_trigger[watch->channel] == QUAD8_EVENT_NONE)
+			priv->next_irq_trigger[watch->channel] = QUAD8_EVENT_INDEX;
+		else if (priv->next_irq_trigger[watch->channel] != QUAD8_EVENT_INDEX)
+			return -EINVAL;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct counter_ops quad8_ops = {
 	.signal_read = quad8_signal_read,
 	.count_read = quad8_count_read,
 	.count_write = quad8_count_write,
 	.function_read = quad8_function_read,
 	.function_write = quad8_function_write,
-	.action_read = quad8_action_read
+	.action_read = quad8_action_read,
+	.events_configure = quad8_events_configure,
+	.watch_validate = quad8_watch_validate,
 };
 
 static const char *const quad8_index_polarity_modes[] = {
@@ -579,7 +680,8 @@ static int quad8_count_enable_write(struct counter_device *counter,
 
 	priv->ab_enable[count->id] = enable;
 
-	ior_cfg = enable | priv->preset_enable[count->id] << 1;
+	ior_cfg = enable | priv->preset_enable[count->id] << 1 |
+		  priv->irq_trigger[count->id] << 3;
 
 	/* Load I/O control configuration */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
@@ -728,7 +830,8 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 
 	priv->preset_enable[count->id] = preset_enable;
 
-	ior_cfg = priv->ab_enable[count->id] | preset_enable << 1;
+	ior_cfg = priv->ab_enable[count->id] | preset_enable << 1 |
+		  priv->irq_trigger[count->id] << 3;
 
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
@@ -980,11 +1083,54 @@ static struct counter_count quad8_counts[] = {
 	QUAD8_COUNT(7, "Channel 8 Count")
 };
 
+static irqreturn_t quad8_irq_handler(int irq, void *private)
+{
+	struct quad8 *const priv = private;
+	const unsigned long base = priv->base;
+	unsigned long irq_status;
+	unsigned long channel;
+	u8 event;
+
+	irq_status = inb(base + QUAD8_REG_INTERRUPT_STATUS);
+	if (!irq_status)
+		return IRQ_NONE;
+
+	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS) {
+		switch (priv->irq_trigger[channel]) {
+		case QUAD8_EVENT_CARRY:
+			event = COUNTER_EVENT_OVERFLOW;
+				break;
+		case QUAD8_EVENT_COMPARE:
+			event = COUNTER_EVENT_THRESHOLD;
+				break;
+		case QUAD8_EVENT_CARRY_BORROW:
+			event = COUNTER_EVENT_OVERFLOW_UNDERFLOW;
+				break;
+		case QUAD8_EVENT_INDEX:
+			event = COUNTER_EVENT_INDEX;
+				break;
+		default:
+			/* should never reach this path */
+			WARN_ONCE(true, "invalid interrupt trigger function %u configured for channel %lu\n",
+				  priv->irq_trigger[channel], channel);
+			continue;
+		}
+
+		counter_push_event(&priv->counter, event, channel);
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
 	struct quad8 *priv;
 	int i, j;
 	unsigned int base_offset;
+	int err;
 
 	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -1009,6 +1155,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
 
 	spin_lock_init(&priv->lock);
 
+	/* Reset Index/Interrupt Register */
+	outb(0x00, base[id] + QUAD8_REG_INDEX_INTERRUPT);
 	/* Reset all counters and disable interrupt function */
 	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 	/* Set initial configuration for all counters */
@@ -1035,11 +1183,18 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		outb(QUAD8_CTR_IOR, base_offset + 1);
 		/* Disable index function; negative index polarity */
 		outb(QUAD8_CTR_IDR, base_offset + 1);
+		/* Initialize next IRQ trigger function configuration */
+		priv->next_irq_trigger[i] = QUAD8_EVENT_NONE;
 	}
 	/* Disable Differential Encoder Cable Status for all channels */
 	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
-	/* Enable all counters */
-	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
+	/* Enable all counters and enable interrupt function */
+	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
+
+	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
+			       priv->counter.name, priv);
+	if (err)
+		return err;
 
 	return devm_counter_register(dev, &priv->counter);
 }
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 5328705aa09c..2c2862dd46a5 100644
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
 
 config INTERRUPT_CNT
 	tristate "Interrupt counter driver"
-- 
2.30.1

