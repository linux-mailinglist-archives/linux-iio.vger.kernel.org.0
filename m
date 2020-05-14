Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035491D2A64
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 10:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgENIjJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbgENIjI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2020 04:39:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565ADC061A0F
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2020 01:39:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so2705748wre.13
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2020 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gnBehs8n8X8G6+U4IGEmmNfIUqdPo2J9oO97C9jFfas=;
        b=XxKndpMwCiexb5RR5u9emCO2sqm5Su+FxxmWcuaPNPltZ45A7G2YqUjxL5tOY3scHr
         z8QORk2QOPUMojy3fXVjcBw9rGR5s3+zfgYR79vRBk0rAEdMf7kyEsK8f9Z1uZoV/CXT
         uAlKehXR7We08RxjMgFhHWLAeavUDo1vepWK90NtiGKV+ZayZQeD324F/3JKB6JqZw9e
         dBm/3nilOlqhNqxM/kI+PlLzkYpz6DhO1OTdh4VvdkYfv0chGtj7u8k1j7RtKzPzPKlJ
         jI2Tu9fqQeGxyfBzUzeSHEBF9ARskuxaCfZjzKUj85QhVOxwFME2cv4AJP0HqJvHPhBQ
         Y9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gnBehs8n8X8G6+U4IGEmmNfIUqdPo2J9oO97C9jFfas=;
        b=ATPVcwGLkD8rwej5eVmLODCPpjUsmIM6A/s5sY6oyS1DJcEmmke86UOig5fnkvrQjO
         2+mm6mUy8c3Le/ZMzvzUPcjV1jULSXhfKULAu8DTq39/VbUBpj9BpEWHEeRx+Qm0H1b9
         vAPqZSHF1QHWqeE4pp2r/ko/nQuSNHP/b+VnN+JRlhzKiJR1oxSpkGIl8u7kMYF/QSAA
         2iqGe1tt/fC4kWC+RmNcCNX+B0xdKwhsDeSFiBX/aR8es1UJ8FvQQ0sWW0RHjZIy/Q9X
         6zoQJb3cx1BC9//GLSwScp+0v0M2Za1EnDEVAMthOvtQzwDLzuK/rOUGOkqu5OEj+KMQ
         cz+Q==
X-Gm-Message-State: AOAM530Blw5yS95FoOF+cTHjSJ9fm9mTQWiJIujeIAz2vFBmjqRY7axB
        d84Yjxb0JAeRYws0lSU+b4+CTA==
X-Google-Smtp-Source: ABdhPJzuicQc9lXXLGz7we6zHzn9LdHpBsCJDJMMCDJ+vgVRkix00VVg08XP1GrDYeVxDuuk2yiOLw==
X-Received: by 2002:adf:fac5:: with SMTP id a5mr4387775wrs.210.1589445547012;
        Thu, 14 May 2020 01:39:07 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id z7sm2975922wrl.88.2020.05.14.01.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:39:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 1/2] irq: make irq_domain_reset_irq_data() available even for non-V2 users
Date:   Thu, 14 May 2020 10:39:00 +0200
Message-Id: <20200514083901.23445-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200514083901.23445-1-brgl@bgdev.pl>
References: <20200514083901.23445-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

irq_domain_reset_irq_data() doesn't modify the parent data, so it can be
made available even if irq domain hierarchy is not being built. We'll
subsequently use it in irq_sim code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/irqdomain.h |  2 +-
 kernel/irq/irqdomain.c    | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 8d062e86d954..b37350c4fe37 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -450,6 +450,7 @@ extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 				irq_hw_number_t hwirq, struct irq_chip *chip,
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
+extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 			unsigned int flags, unsigned int size,
@@ -491,7 +492,6 @@ extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 irq_hw_number_t hwirq,
 					 struct irq_chip *chip,
 					 void *chip_data);
-extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
 extern void irq_domain_free_irqs_common(struct irq_domain *domain,
 					unsigned int virq,
 					unsigned int nr_irqs);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 35b8d97c3a1d..e2aa128ea3ee 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1047,6 +1047,18 @@ int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
 	return virq;
 }
 
+/**
+ * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
+ * @irq_data:	The pointer to irq_data
+ */
+void irq_domain_reset_irq_data(struct irq_data *irq_data)
+{
+	irq_data->hwirq = 0;
+	irq_data->chip = &no_irq_chip;
+	irq_data->chip_data = NULL;
+}
+EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
+
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 /**
  * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
@@ -1247,18 +1259,6 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 }
 EXPORT_SYMBOL(irq_domain_set_info);
 
-/**
- * irq_domain_reset_irq_data - Clear hwirq, chip and chip_data in @irq_data
- * @irq_data:	The pointer to irq_data
- */
-void irq_domain_reset_irq_data(struct irq_data *irq_data)
-{
-	irq_data->hwirq = 0;
-	irq_data->chip = &no_irq_chip;
-	irq_data->chip_data = NULL;
-}
-EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
-
 /**
  * irq_domain_free_irqs_common - Clear irq_data and free the parent
  * @domain:	Interrupt domain to match
-- 
2.25.0

