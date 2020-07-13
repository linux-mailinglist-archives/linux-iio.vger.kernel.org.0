Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D0D21D95A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 17:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgGMPAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 11:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgGMO7s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2020 10:59:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B73AC08C5DD
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2020 07:59:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so16938004wrv.9
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2020 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2K0+WpAjA/clN2fcxfwCJnR+PHkjcGu57v68HdMeUGs=;
        b=TjuSWxVQpca2khBzPDyHDbnK38Uj8WWXhdul0NXSoye176axPOsOxp6kAwga6KNvsq
         jDt5y35XtzO+Ru/Z3SWAdx8kFmXIx4IU8Kf6x0ZeQliyfyCNQ97egkeuE9nGJXvovFq3
         7MUiVkzlQSLGagLRSSQpzeYAjvyrYCIXkQgjKjBOBEsY8ESj8G3gvYSZmCCLqvBtSsM+
         7MQhvUDvz6v7xsGvdpeakrqoypfNhkSsQ9UDcN1f3OrIAGvmTLVv9MbA9YRFWid8l/oB
         5xXcp2P7I50sZp8L114/DIbu/CveOtr/aty1Ljvh92SqdseqIoeC0p/U8690QqKpYFE9
         k+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2K0+WpAjA/clN2fcxfwCJnR+PHkjcGu57v68HdMeUGs=;
        b=Zof7/a2icoX5/oefLd0CguH3ChcV1nB36Rj2dG/iJVMANhqJtdW8JDWAZ5Rn3TI3jL
         oG3htJg6qo0HQfZ8KabwruQ8qO45IB9AEpZQ5ZgmEiUkdAIUIY3TPM2r+xWh29Gus3+G
         KT5yq4qywXXS0OWww5UPmNJZRQeFCnUGqwuh2vcPcja+iKNLvUb3h74dZFbYxu/ovEku
         cxg86puG0lJIgq28xlzhVzHs22A7j7KktthvW6LXYGfQthQ3EJuCMsJOSqe58wboCI1m
         3VKU24ocUUcCYyqPO+RqVAvDAGixGIqC6QjrKG2AB0NQ73HcbvYL9BBZpw1udWdK1vj8
         mmMg==
X-Gm-Message-State: AOAM530VkNrQdWqksYCnUSkmDNVsBozkQxcrYVfcoCTbiCQrKr9DuJKv
        V7tWa7o94NC1ulBuU4A/sYYL/Q==
X-Google-Smtp-Source: ABdhPJynbnzJegf5dNDoEbDXw70BU9CgzBs8/kZqPTPdIxehdfqK950VzM4VPnHZxExJobVenj5B+Q==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr79063986wru.200.1594652387098;
        Mon, 13 Jul 2020 07:59:47 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id u20sm21991145wmm.15.2020.07.13.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:59:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 1/3] devres: provide devm_krealloc()
Date:   Mon, 13 Jul 2020 16:59:32 +0200
Message-Id: <20200713145934.18243-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713145934.18243-1-brgl@bgdev.pl>
References: <20200713145934.18243-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement the managed variant of krealloc(). This function works with
all memory allocated by devm_kmalloc() (or devres functions using it
implicitly like devm_kmemdup(), devm_kstrdup() etc.).

Managed realloc'ed chunks can be manually released with devm_kfree().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 67 +++++++++++++++++++
 include/linux/device.h                        |  2 +
 3 files changed, 70 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index eaaaafc21134f..f318a5c0033c1 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -354,6 +354,7 @@ MEM
   devm_kmalloc()
   devm_kmalloc_array()
   devm_kmemdup()
+  devm_krealloc()
   devm_kstrdup()
   devm_kvasprintf()
   devm_kzalloc()
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index ed615d3b9cf15..1775d35462300 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -837,6 +837,73 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(devm_kmalloc);
 
+/**
+ * devm_krealloc - Resource-managed krealloc()
+ * @dev: Device to re-allocate memory for
+ * @ptr: Pointer to the memory chunk to re-allocate
+ * @new_size: New allocation size
+ * @gfp: Allocation gfp flags
+ *
+ * Managed krealloc(). Resizes the memory chunk allocated with devm_kmalloc().
+ * Behaves similarly to regular krealloc(): if @ptr is NULL or ZERO_SIZE_PTR,
+ * it's the equivalent of devm_kmalloc(). If new_size is zero, it returns
+ * ZERO_SIZE_PTR. This function doesn't change the order in which the release
+ * callback for the re-alloc'ed devres will be called (except when falling back
+ * to devm_kmalloc()). The contents of the memory are preserved up to the
+ * lesser of new and old sizes.
+ */
+void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
+{
+	struct devres *old_dr, *new_dr;
+	struct list_head old_head;
+	unsigned long flags;
+	size_t total_size;
+	void *ret = NULL;
+
+	if (unlikely(!new_size)) {
+		devm_kfree(dev, ptr);
+		return ZERO_SIZE_PTR;
+	}
+
+	if (unlikely(ZERO_OR_NULL_PTR(ptr)))
+		return devm_kmalloc(dev, new_size, gfp);
+
+	if (WARN_ON(is_kernel_rodata((unsigned long)ptr)))
+		/*
+		 * We cannot reliably realloc a const string returned by
+		 * devm_kstrdup_const().
+		 */
+		return NULL;
+
+	if (!check_dr_size(new_size, &total_size))
+		return NULL;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+
+	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
+	if (!old_dr) {
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
+		WARN(1, "Memory chunk not managed or managed by a different device.");
+		return NULL;
+	}
+
+	old_head = old_dr->node.entry;
+
+	new_dr = krealloc(old_dr, total_size, gfp);
+	if (!new_dr) {
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
+		return NULL;
+	}
+
+	if (new_dr != old_dr)
+		list_replace(&old_head, &new_dr->node.entry);
+
+	ret = new_dr->data;
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_krealloc);
+
 /**
  * devm_kstrdup - Allocate resource managed space and
  *                copy an existing string into that.
diff --git a/include/linux/device.h b/include/linux/device.h
index 7322c51e9c0c7..f64f408431593 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -206,6 +206,8 @@ int devres_release_group(struct device *dev, void *id);
 
 /* managed devm_k.alloc/kfree for device drivers */
 void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;
+void *devm_krealloc(struct device *dev, void *ptr, size_t size,
+		    gfp_t gfp) __must_check;
 __printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
 				     const char *fmt, va_list ap) __malloc;
 __printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
-- 
2.26.1

