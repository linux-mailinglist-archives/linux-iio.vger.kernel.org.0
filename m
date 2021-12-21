Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B147BB99
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 09:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhLUIRP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 03:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhLUIRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Dec 2021 03:17:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF887C061574
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 00:17:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a394f00b001b0f6d6468eso1818813pjf.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 00:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjmeBVzpmVNuoVKPIAqqBFZFlEBd33RCxrYbf7EI4Z8=;
        b=SO/Zqg2JKypBzmuEAGJgMlaQUULw7eDDwZvAuqNlqmM6dn3QyTjNNsiCQcDTDi6KI0
         RmWAtJ3LFtxU5rV1usPpL/i3S/d+L/kcvsLZ0kqDhOZMO07PzZNnb+odYyJOwQuP1EEl
         oKxNXRUd5vJ5r52nase4axHtiNzcHRub6WlrtPZ/JWw2053uB541nBCZ/2kFf6DfNjX1
         VxOEtzYYo2RqDopVXgOdcoEdf3KMXOn6d+SLZVHbtzU0nvocOorCiY8Vf7dPJIO9s2lM
         1DZaH6jTNfHuBH2u3dzd/lLIhI98hmVq3Qn9Zw3pZaaHtvyvT6qp7gfHuNyt3BAERqsj
         Ugsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjmeBVzpmVNuoVKPIAqqBFZFlEBd33RCxrYbf7EI4Z8=;
        b=4yAidzXzzrYjH/gkjfLjEGcR1qT6yZZpEzfAOadGBxSQkx4E+lKjEDINk15UWqmRTi
         TRKiWb6r8VpHZ1/mJGAM+iioRlbSMf4WgNFfJGoHIkFtiuEoj0FzAWl+29Rn2rjxylgk
         8Fvn8skjQ+2pZnmPVakqv1fG0fTWYMXoKOPWKSzsbf7PhBraKojzAXKpwh6ipGhVCvDK
         9jOJ88UNEZTdWFWdleYfNhXC0vFsWN6GDx6Eu14wAJQkKc7dYRPjpKqTVhzQsWNXBaeh
         iJ3duKIdqHvn0RLOYifT1xZ7kj3zCW71aALMl6dFPhXn0kyk6+WruxbdfLwMueO9QmOc
         NLKA==
X-Gm-Message-State: AOAM533CKr0S7RU430N3EOW0Sg8lZJk4YDXIQ1fQH+rR5RIg1xrJrVJl
        mnfPqCew8UuAcv1Tv7zG/kQ=
X-Google-Smtp-Source: ABdhPJw1w1NnrtAULaB47cl61CQ10ImdldglwV2wnzSFQe6nvytmPXdm3jS5NY4bRoK+1ov5qyjppw==
X-Received: by 2002:a17:90b:198d:: with SMTP id mv13mr2860408pjb.182.1640074634454;
        Tue, 21 Dec 2021 00:17:14 -0800 (PST)
Received: from localhost.localdomain ([37.120.154.44])
        by smtp.gmail.com with ESMTPSA id b6sm21196890pfm.170.2021.12.21.00.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 00:17:14 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH 3/3] counter: 104-quad-8: Fix persistent enabled events bug
Date:   Tue, 21 Dec 2021 17:16:48 +0900
Message-Id: <5fd5731cec1c251acee30eefb7c19160d03c9d39.1640072891.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640072890.git.vilhelm.gray@gmail.com>
References: <cover.1640072890.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A bug exists if the user executes a COUNTER_ADD_WATCH_IOCTL ioctl call,
and then executes a COUNTER_DISABLE_EVENTS_IOCTL ioctl call. Disabling
the events should disable the 104-QUAD-8 interrupts, but because of this
bug the interrupts are not disabling.

The reason this bug is occurring is because quad8_events_configure() is
called when COUNTER_DISABLE_EVENTS_IOCTL is handled, but the
next_irq_trigger[] array has not been cleared before it is checked in
the loop.

This patch fixes the bug by removing the next_irq_trigger array and
instead utilizing a different algorithm of walking the events_list list
for the current requested events. When a COUNTER_DISABLE_EVENTS_IOCTL is
handled, events_list will be empty and thus all device channels end up
with interrupts disabled.

Fixes: 7aa2ba0df651 ("counter: 104-quad-8: Add IRQ support for the ACCES 104-QUAD-8")
Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 82 +++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 1cbd60aaed69..a97027db0446 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -44,7 +45,6 @@ MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
  * @ab_enable:		array of A and B inputs enable configurations
  * @preset_enable:	array of set_to_preset_on_index attribute configurations
  * @irq_trigger:	array of current IRQ trigger function configurations
- * @next_irq_trigger:	array of next IRQ trigger function configurations
  * @synchronous_mode:	array of index function synchronous mode configurations
  * @index_polarity:	array of index function polarity configurations
  * @cable_fault_enable:	differential encoder cable status enable configurations
@@ -61,7 +61,6 @@ struct quad8 {
 	unsigned int ab_enable[QUAD8_NUM_COUNTERS];
 	unsigned int preset_enable[QUAD8_NUM_COUNTERS];
 	unsigned int irq_trigger[QUAD8_NUM_COUNTERS];
-	unsigned int next_irq_trigger[QUAD8_NUM_COUNTERS];
 	unsigned int synchronous_mode[QUAD8_NUM_COUNTERS];
 	unsigned int index_polarity[QUAD8_NUM_COUNTERS];
 	unsigned int cable_fault_enable;
@@ -390,7 +389,6 @@ static int quad8_action_read(struct counter_device *counter,
 }
 
 enum {
-	QUAD8_EVENT_NONE = -1,
 	QUAD8_EVENT_CARRY = 0,
 	QUAD8_EVENT_COMPARE = 1,
 	QUAD8_EVENT_CARRY_BORROW = 2,
@@ -402,34 +400,49 @@ static int quad8_events_configure(struct counter_device *counter)
 	struct quad8 *const priv = counter->priv;
 	unsigned long irq_enabled = 0;
 	unsigned long irqflags;
-	size_t channel;
+	struct counter_event_node *event_node;
+	unsigned int next_irq_trigger;
 	unsigned long ior_cfg;
 	unsigned long base_offset;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	/* Enable interrupts for the requested channels, disable for the rest */
-	for (channel = 0; channel < QUAD8_NUM_COUNTERS; channel++) {
-		if (priv->next_irq_trigger[channel] == QUAD8_EVENT_NONE)
-			continue;
+	list_for_each_entry(event_node, &counter->events_list, l) {
+		switch (event_node->event) {
+		case COUNTER_EVENT_OVERFLOW:
+			next_irq_trigger = QUAD8_EVENT_CARRY;
+			break;
+		case COUNTER_EVENT_THRESHOLD:
+			next_irq_trigger = QUAD8_EVENT_COMPARE;
+			break;
+		case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
+			next_irq_trigger = QUAD8_EVENT_CARRY_BORROW;
+			break;
+		case COUNTER_EVENT_INDEX:
+			next_irq_trigger = QUAD8_EVENT_INDEX;
+			break;
+		default:
+			/* should never reach this path */
+			spin_unlock_irqrestore(&priv->lock, irqflags);
+			return -EINVAL;
+		}
 
-		if (priv->irq_trigger[channel] != priv->next_irq_trigger[channel]) {
-			/* Save new IRQ function configuration */
-			priv->irq_trigger[channel] = priv->next_irq_trigger[channel];
+		/* Skip configuration if it is the same as previously set */
+		if (priv->irq_trigger[event_node->channel] == next_irq_trigger)
+			continue;
 
-			/* Load configuration to I/O Control Register */
-			ior_cfg = priv->ab_enable[channel] |
-				  priv->preset_enable[channel] << 1 |
-				  priv->irq_trigger[channel] << 3;
-			base_offset = priv->base + 2 * channel + 1;
-			outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
-		}
+		/* Save new IRQ function configuration */
+		priv->irq_trigger[event_node->channel] = next_irq_trigger;
 
-		/* Reset next IRQ trigger function configuration */
-		priv->next_irq_trigger[channel] = QUAD8_EVENT_NONE;
+		/* Load configuration to I/O Control Register */
+		ior_cfg = priv->ab_enable[event_node->channel] |
+			  priv->preset_enable[event_node->channel] << 1 |
+			  priv->irq_trigger[event_node->channel] << 3;
+		base_offset = priv->base + 2 * event_node->channel + 1;
+		outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
 		/* Enable IRQ line */
-		irq_enabled |= BIT(channel);
+		irq_enabled |= BIT(event_node->channel);
 	}
 
 	outb(irq_enabled, priv->base + QUAD8_REG_INDEX_INTERRUPT);
@@ -442,35 +455,20 @@ static int quad8_events_configure(struct counter_device *counter)
 static int quad8_watch_validate(struct counter_device *counter,
 				const struct counter_watch *watch)
 {
-	struct quad8 *const priv = counter->priv;
+	struct counter_event_node *event_node;
 
 	if (watch->channel > QUAD8_NUM_COUNTERS - 1)
 		return -EINVAL;
 
 	switch (watch->event) {
 	case COUNTER_EVENT_OVERFLOW:
-		if (priv->next_irq_trigger[watch->channel] == QUAD8_EVENT_NONE)
-			priv->next_irq_trigger[watch->channel] = QUAD8_EVENT_CARRY;
-		else if (priv->next_irq_trigger[watch->channel] != QUAD8_EVENT_CARRY)
-			return -EINVAL;
-		return 0;
 	case COUNTER_EVENT_THRESHOLD:
-		if (priv->next_irq_trigger[watch->channel] == QUAD8_EVENT_NONE)
-			priv->next_irq_trigger[watch->channel] = QUAD8_EVENT_COMPARE;
-		else if (priv->next_irq_trigger[watch->channel] != QUAD8_EVENT_COMPARE)
-			return -EINVAL;
-		return 0;
 	case COUNTER_EVENT_OVERFLOW_UNDERFLOW:
-		if (priv->next_irq_trigger[watch->channel] == QUAD8_EVENT_NONE)
-			priv->next_irq_trigger[watch->channel] = QUAD8_EVENT_CARRY_BORROW;
-		else if (priv->next_irq_trigger[watch->channel] != QUAD8_EVENT_CARRY_BORROW)
-			return -EINVAL;
-		return 0;
 	case COUNTER_EVENT_INDEX:
-		if (priv->next_irq_trigger[watch->channel] == QUAD8_EVENT_NONE)
-			priv->next_irq_trigger[watch->channel] = QUAD8_EVENT_INDEX;
-		else if (priv->next_irq_trigger[watch->channel] != QUAD8_EVENT_INDEX)
-			return -EINVAL;
+		list_for_each_entry(event_node, &counter->next_events_list, l)
+			if (watch->channel == event_node->channel &&
+				watch->event != event_node->event)
+				return -EINVAL;
 		return 0;
 	default:
 		return -EINVAL;
@@ -1183,8 +1181,6 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		outb(QUAD8_CTR_IOR, base_offset + 1);
 		/* Disable index function; negative index polarity */
 		outb(QUAD8_CTR_IDR, base_offset + 1);
-		/* Initialize next IRQ trigger function configuration */
-		priv->next_irq_trigger[i] = QUAD8_EVENT_NONE;
 	}
 	/* Disable Differential Encoder Cable Status for all channels */
 	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
-- 
2.33.1

