Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4447158F91
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 14:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgBKNNJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 08:13:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35292 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgBKNNG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2020 08:13:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so12344426wrt.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Feb 2020 05:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anPiy+Oai5eVC9epbsqPoMEWmUp50/yoIqvuC47WE5o=;
        b=LcrMHtCUppxeolsKFGx6QsBeDzCgd+5f8d/Oq/d8bQLTe2OeansixpI49rk7VTtwHO
         TAadngLfrWrhX/Za4qdIf48h7osfj+UtUjkYt8J+GCrXmU3esu+ojHKWvQPt39Cw0EmU
         8iwhyTdDSKEuJwjPVx2LSG1K+4AZ2eHca+Pt/hpgb3HSE0TJRzk7+/6vxp+A9MQcK2g5
         WxLqITqfiEcblyk3kcL8wB0WDcrtnF8YEuApH4lNvz2SbbUmBdKrW2BpMVkOXQPlDMzc
         mPmY3MEo4I7MsTQ6a5JLe7mIygDcVOKtUqN9hKS/JM0sKW02t0qiGKxQ/L81g4zm1bkC
         blQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anPiy+Oai5eVC9epbsqPoMEWmUp50/yoIqvuC47WE5o=;
        b=uQG1Xjsi111OCX7pGoTorbZm2AuW/GTGfkmTNWEiZI8RJL4kX50fg4A0PbNLFKT+yz
         xbO3YiTWnPyNUAPse15ks/+qJMdym8nJHKTP9fBWYDLeMwMdGAT9CRmZwPkJIvdI7ObO
         /oj6pd2E/eHk1pn+7QSY5XqtHEw8VWJpcaUbDLK1ID43bYfbE2JnZcH5a1r6tYr+lfK4
         mCBc/NYFWWngMgbiE6Y/x1KlI1u6VN26UDiKtqR/P49z6QTPnb+WGcfhYdNmnj8Xd37Y
         uwMnVom7W1Y+Ul9J9VKitxHAupNgw66v4UFDTNxnZfmjORuIGVcIoGZ03Zi0VTzBo/Wx
         fVyQ==
X-Gm-Message-State: APjAAAWvRBotRhWRZwxJCHF1TJO+IOzYM/oFR7L/EX3V5PxVv3vYBJma
        3pWm0pVOF/Iq+iPAaBi5FwhSUL3fsBE=
X-Google-Smtp-Source: APXvYqzzhUz5QJgJfU2ox7SdgabZbIVUaJl7QIQdgt8cnPmLLHB161BbLwhKlnx0AUyBK9UVc6nz1A==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr8771950wrv.334.1581426785134;
        Tue, 11 Feb 2020 05:13:05 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id b21sm3873013wmd.37.2020.02.11.05.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 05:13:04 -0800 (PST)
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
Subject: [PATCH v2 5/6] irq/domain: provide irq_domain_dispose_mappings() helper
Date:   Tue, 11 Feb 2020 14:12:39 +0100
Message-Id: <20200211131240.15853-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211131240.15853-1-brgl@bgdev.pl>
References: <20200211131240.15853-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Unmapping all interrupts before removing an irq_domain is a common
use-case. Provide an appropriate helper that can also be used with
the remove() callback in irq_domain ops.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index fbc25f464f62..8fd27614dafd 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -390,6 +390,7 @@ extern unsigned int irq_create_mapping(struct irq_domain *host,
 				       irq_hw_number_t hwirq);
 extern unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
 extern void irq_dispose_mapping(unsigned int virq);
+extern void irq_domain_dispose_mappings(struct irq_domain *domain);
 
 /**
  * irq_linear_revmap() - Find a linux irq from a hw irq number.
@@ -594,6 +595,7 @@ irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain)
 
 #else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
+static inline void irq_domain_dispose_mappings(struct irq_domain *domain) { }
 static inline struct irq_domain *irq_find_matching_fwnode(
 	struct fwnode_handle *fwnode, enum irq_domain_bus_token bus_token)
 {
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index b391d2e65bdd..d09de9f2411a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -888,6 +888,23 @@ void irq_dispose_mapping(unsigned int virq)
 }
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
+/**
+ * irq_domain_dispose_mappings() - Unmap all interrupts
+ * @domain: domain for which to unmap all interrupts
+ */
+void irq_domain_dispose_mappings(struct irq_domain *domain)
+{
+	unsigned int virq;
+	int i;
+
+	for (i = 0; i < domain->hwirq_max; i++) {
+		virq = irq_find_mapping(domain, i);
+		if (virq)
+			irq_dispose_mapping(virq);
+	}
+}
+EXPORT_SYMBOL_GPL(irq_domain_dispose_mappings);
+
 /**
  * irq_find_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
-- 
2.25.0

