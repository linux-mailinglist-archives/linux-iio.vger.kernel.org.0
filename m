Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B03F9341
	for <lists+linux-iio@lfdr.de>; Fri, 27 Aug 2021 05:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244369AbhH0DuU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 23:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbhH0DuL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Aug 2021 23:50:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF3C0613D9;
        Thu, 26 Aug 2021 20:49:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u6so3928797pfi.0;
        Thu, 26 Aug 2021 20:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWnjTolsyQJJUJtgYHQ22qVQAWFYBt5fDLJYF+RU014=;
        b=XCRSNMm+9A/9KvsyUBw+XvmXPcTDyyqFH+qkdDylRRN5Lnh+zVALWaw/ra3paapLuy
         rkYP2Dmoo+/pYMUU8E2GPcKDA4lI7YVXmO+J8GWVwS173QN+HlWxcK9rl4rZxMIpzSHp
         zb5MZ9ERCOQvFp0ZmP7kLkXpGXODc6gf9FqmwvLOAkpfHTy3o8C4dzlN6g1mNeObbm4C
         7G0CAhMIK3H8VMH75n96WJ3biXjqyLhLZ3iZA6sU7+upiQRsw1pRlyWs4hKZmInpwodX
         20tawz7zEbVECzZnbXyvDpfktmsynhYiEksY3asiFwJodzaOGMq5Cg3DcutI0r0kWcFQ
         VLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWnjTolsyQJJUJtgYHQ22qVQAWFYBt5fDLJYF+RU014=;
        b=E+jzd1Syy3Gq/bckJy9OF1IGHyOFaQG2wqhIuLx48LskAnRxpa3Hxwf/kA7g0xdug6
         7OBVOHvEY1fhATe8dHOA5UPLRy/yBrnMb0mC/OJz21BTdxTUmUlXoiO4fPs8ay7e3Glr
         dV8Ek2pYP+VLvCIrKmTB36wkmGtcwMEvID4YQkOWGCxHFPayjNBpKjzeiINR+Z/+sabG
         EHpLIXCtDfcsnaG0XJk4M5BI4g0Z36EfLrVk75wOxaTW+cUFr5ScdFSTfFO1icJ4OfFB
         tkwgdgh7MUevqOnNFVta/ctTI975YvNXJ7KiQISmXk5VR7C17PQcjDcL6wxtlSoMBMss
         5Nog==
X-Gm-Message-State: AOAM532Z4WeF8uJZTYRuQ+X9dMUeon9h2c03PO038B7EgvaLn30I4ItS
        B6Re5aDvw2aufeq29SLye78=
X-Google-Smtp-Source: ABdhPJyvU4NwffmfJbLHxSop6MqlcWBTM5rfpt8dSPh+x+uy6AE9AKs+2bLLVtWf3gQ1E6ZlsG/c8A==
X-Received: by 2002:a62:a117:0:b029:394:dddf:6b00 with SMTP id b23-20020a62a1170000b0290394dddf6b00mr6739629pff.50.1630036162272;
        Thu, 26 Aug 2021 20:49:22 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o6sm4364693pjk.4.2021.08.26.20.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:49:21 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v16 13/14] counter: 104-quad-8: Replace mutex with spinlock
Date:   Fri, 27 Aug 2021 12:47:57 +0900
Message-Id: <eb21d25c7bce01bf938c434604fad1482a47f273.1630031207.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630031207.git.vilhelm.gray@gmail.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch replaces the mutex I/O lock with a spinlock. This is in
preparation for a subsequent patch adding IRQ support for 104-QUAD-8
devices; we can't sleep in an interrupt context, so we'll need to use a
spinlock instead.

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 89 +++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index c587f295d720..a56751bf1e9b 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
+#include <linux/spinlock.h>
 
 #define QUAD8_EXTENT 32
 
@@ -43,7 +44,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  * @base:		base port address of the device
  */
 struct quad8 {
-	struct mutex lock;
+	spinlock_t lock;
 	struct counter_device counter;
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
@@ -124,6 +125,7 @@ static int quad8_count_read(struct counter_device *counter,
 	unsigned int flags;
 	unsigned int borrow;
 	unsigned int carry;
+	unsigned long irqflags;
 	int i;
 
 	flags = inb(base_offset + 1);
@@ -133,7 +135,7 @@ static int quad8_count_read(struct counter_device *counter,
 	/* Borrow XOR Carry effectively doubles count range */
 	*val = (unsigned long)(borrow ^ carry) << 24;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Reset Byte Pointer; transfer Counter to Output Latch */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
@@ -142,7 +144,7 @@ static int quad8_count_read(struct counter_device *counter,
 	for (i = 0; i < 3; i++)
 		*val |= (unsigned long)inb(base_offset) << (8 * i);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -152,13 +154,14 @@ static int quad8_count_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
+	unsigned long irqflags;
 	int i;
 
 	/* Only 24-bit values are supported */
 	if (val > 0xFFFFFF)
 		return -ERANGE;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Reset Byte Pointer */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
@@ -183,7 +186,7 @@ static int quad8_count_write(struct counter_device *counter,
 	/* Reset Error flag */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -201,8 +204,9 @@ static int quad8_function_read(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 	const int id = count->id;
+	unsigned long irqflags;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	if (priv->quadrature_mode[id])
 		switch (priv->quadrature_scale[id]) {
@@ -219,7 +223,7 @@ static int quad8_function_read(struct counter_device *counter,
 	else
 		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -234,10 +238,11 @@ static int quad8_function_write(struct counter_device *counter,
 	unsigned int *const scale = priv->quadrature_scale + id;
 	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
 	const int base_offset = priv->base + 2 * id + 1;
+	unsigned long irqflags;
 	unsigned int mode_cfg;
 	unsigned int idr_cfg;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	mode_cfg = priv->count_mode[id] << 1;
 	idr_cfg = priv->index_polarity[id] << 1;
@@ -272,7 +277,7 @@ static int quad8_function_write(struct counter_device *counter,
 			break;
 		default:
 			/* should never reach this path */
-			mutex_unlock(&priv->lock);
+			spin_unlock_irqrestore(&priv->lock, irqflags);
 			return -EINVAL;
 		}
 	}
@@ -280,7 +285,7 @@ static int quad8_function_write(struct counter_device *counter,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -406,9 +411,10 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
+	unsigned long irqflags;
 	unsigned int idr_cfg = index_polarity << 1;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	idr_cfg |= priv->synchronous_mode[channel_id];
 
@@ -417,7 +423,7 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -446,15 +452,16 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
+	unsigned long irqflags;
 	unsigned int idr_cfg = synchronous_mode;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	idr_cfg |= priv->index_polarity[channel_id] << 1;
 
 	/* Index function must be non-synchronous in non-quadrature mode */
 	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
-		mutex_unlock(&priv->lock);
+		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return -EINVAL;
 	}
 
@@ -463,7 +470,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -510,6 +517,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 	unsigned int count_mode;
 	unsigned int mode_cfg;
 	const int base_offset = priv->base + 2 * count->id + 1;
+	unsigned long irqflags;
 
 	/* Map Generic Counter count mode to 104-QUAD-8 count mode */
 	switch (cnt_mode) {
@@ -530,7 +538,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 		return -EINVAL;
 	}
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->count_mode[count->id] = count_mode;
 
@@ -544,7 +552,7 @@ static int quad8_count_mode_write(struct counter_device *counter,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -564,9 +572,10 @@ static int quad8_count_enable_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
+	unsigned long irqflags;
 	unsigned int ior_cfg;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->ab_enable[count->id] = enable;
 
@@ -575,7 +584,7 @@ static int quad8_count_enable_write(struct counter_device *counter,
 	/* Load I/O control configuration */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -626,16 +635,17 @@ static int quad8_count_preset_write(struct counter_device *counter,
 				    struct counter_count *count, u64 preset)
 {
 	struct quad8 *const priv = counter->priv;
+	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
 	if (preset > 0xFFFFFF)
 		return -ERANGE;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	quad8_preset_register_set(priv, count->id, preset);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -644,8 +654,9 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 				    struct counter_count *count, u64 *ceiling)
 {
 	struct quad8 *const priv = counter->priv;
+	unsigned long irqflags;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
@@ -659,7 +670,7 @@ static int quad8_count_ceiling_read(struct counter_device *counter,
 		break;
 	}
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -668,23 +679,24 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 				     struct counter_count *count, u64 ceiling)
 {
 	struct quad8 *const priv = counter->priv;
+	unsigned long irqflags;
 
 	/* Only 24-bit values are supported */
 	if (ceiling > 0xFFFFFF)
 		return -ERANGE;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
 	case 1:
 	case 3:
 		quad8_preset_register_set(priv, count->id, ceiling);
-		mutex_unlock(&priv->lock);
+		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return 0;
 	}
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return -EINVAL;
 }
@@ -706,12 +718,13 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id + 1;
+	unsigned long irqflags;
 	unsigned int ior_cfg;
 
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->preset_enable[count->id] = preset_enable;
 
@@ -720,7 +733,7 @@ static int quad8_count_preset_enable_write(struct counter_device *counter,
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -731,22 +744,23 @@ static int quad8_signal_cable_fault_read(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
+	unsigned long irqflags;
 	bool disabled;
 	unsigned int status;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	disabled = !(priv->cable_fault_enable & BIT(channel_id));
 
 	if (disabled) {
-		mutex_unlock(&priv->lock);
+		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return -EINVAL;
 	}
 
 	/* Logic 0 = cable fault */
 	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	/* Mask respective channel and invert logic */
 	*cable_fault = !(status & BIT(channel_id));
@@ -772,9 +786,10 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 {
 	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
+	unsigned long irqflags;
 	unsigned int cable_fault_enable;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	if (enable)
 		priv->cable_fault_enable |= BIT(channel_id);
@@ -786,7 +801,7 @@ static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
 
 	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -809,8 +824,9 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
 	const int base_offset = priv->base + 2 * channel_id;
+	unsigned long irqflags;
 
-	mutex_lock(&priv->lock);
+	spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->fck_prescaler[channel_id] = prescaler;
 
@@ -822,7 +838,7 @@ static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
 	     base_offset + 1);
 
-	mutex_unlock(&priv->lock);
+	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
@@ -991,8 +1007,7 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	priv->counter.priv = priv;
 	priv->base = base[id];
 
-	/* Initialize mutex */
-	mutex_init(&priv->lock);
+	spin_lock_init(&priv->lock);
 
 	/* Reset all counters and disable interrupt function */
 	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
-- 
2.32.0

