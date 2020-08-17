Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E36246E69
	for <lists+linux-iio@lfdr.de>; Mon, 17 Aug 2020 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbgHQR33 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388455AbgHQRFn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 13:05:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A95C061343
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2020 10:05:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so14499862wme.4
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2020 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ppXwFfraTQM+joRLep3NDQF8tVHJ1ee0dymwQ438l4=;
        b=qwpkWQszAeTcIOVQClBm7OUU7yvOqxouNptJiW5TzPM+y8IP8dXVk06w4q4N4ZMbmB
         iscXGX1e8h4g/uzv2iHKCyBAlvT/l8tCY/WRMC0yKfANHE2Y1W/jSjLvEGa02NH6BDDk
         eq38E90AKRl2ARO4SR5dnXezG9WG5HhwzNKC8EbQMsPPIfgfewww7AOJ5aDUcS+ii/2Y
         0PqhLL8NbG6RQTtJLEojmsZj2+J7+ZnM92Y6SLVKlfVoKEQuRpSDV34grq8cVTPh9VWR
         s+qhuOjQnND5AAwbUZNlWCsWObVSAb8NzX8NDHzSL3dJWf1EvyJ/2QP7srTU+KbqE2ZS
         vQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ppXwFfraTQM+joRLep3NDQF8tVHJ1ee0dymwQ438l4=;
        b=rpmGGXbhgGIhJudifXeKzXFy5XJbukgJC68a0/KCjaZN4k/3ZsLZ6+ngzLF3G9RVPH
         /A0LF13fdSxh5S918lldndD4wVw1JN2EDKof8R54rWf0HJ4bi43iR4JvpDugGAMmC6gN
         DJcpRJOOC6jHkIsyPvb9Au2T5Z8En9LrT1nc4HR91oeQ8QokZNyaHeHw4rLKyLcNNEBc
         AbaKM+CV3XYRv5N3QjTO+SI88S4Xd1qhHu5GUuw/sWKs8xAzx1X2YNdw1p4SpPRBEXl1
         2L0D0s1OLy1/5+S9OimMtDPWgeG/aTEKtl9fiU/YakqgtnFUA8bu/SUHmocXhitJywZX
         J2KQ==
X-Gm-Message-State: AOAM530GIB6kS3gEQMOCcHmboNjOGbi9yYvMDHR7TEvisART8a5TJ0Qj
        C03rnoMd0ud68InFi0L97lqkSw==
X-Google-Smtp-Source: ABdhPJz9Jid19DV7ctHwh+x2zDOnvpSQodhQiDyVVNFAeXKoUGkGRyRcjZtjZiKWMvR0JlGPWoBw+g==
X-Received: by 2002:a05:600c:410b:: with SMTP id j11mr16058569wmi.38.1597683940681;
        Mon, 17 Aug 2020 10:05:40 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id k184sm29747177wme.1.2020.08.17.10.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:05:40 -0700 (PDT)
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
Subject: [PATCH v7 1/3] devres: provide devm_krealloc()
Date:   Mon, 17 Aug 2020 19:05:33 +0200
Message-Id: <20200817170535.17041-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200817170535.17041-1-brgl@bgdev.pl>
References: <20200817170535.17041-1-brgl@bgdev.pl>
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
 drivers/base/devres.c                         | 93 +++++++++++++++++++
 include/linux/device.h                        |  2 +
 3 files changed, 96 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index eaaaafc21134..f318a5c0033c 100644
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
index ed615d3b9cf1..bfe46e83147e 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -36,6 +36,17 @@ struct devres {
 	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
 };
 
+static struct devres *to_devres(void *data)
+{
+	return (struct devres *)((u8 *)data - ALIGN(sizeof(struct devres),
+						    ARCH_KMALLOC_MINALIGN));
+}
+
+static size_t devres_data_size(size_t total_size)
+{
+	return total_size - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
+}
+
 struct devres_group {
 	struct devres_node		node[2];
 	void				*id;
@@ -126,6 +137,14 @@ static void add_dr(struct device *dev, struct devres_node *node)
 	list_add_tail(&node->entry, &dev->devres_head);
 }
 
+static void replace_dr(struct device *dev,
+		       struct devres_node *old, struct devres_node *new)
+{
+	devres_log(dev, old, "REPLACE");
+	BUG_ON(!list_empty(&new->entry));
+	list_replace(&old->entry, &new->entry);
+}
+
 #ifdef CONFIG_DEBUG_DEVRES
 void * __devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp, int nid,
 		      const char *name)
@@ -837,6 +856,80 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
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
+ * it's the equivalent of devm_kmalloc(). If new_size is zero, it frees the
+ * previously allocated memory and returns ZERO_SIZE_PTR. This function doesn't
+ * change the order in which the release callback for the re-alloc'ed devres
+ * will be called (except when falling back to devm_kmalloc() or when freeing
+ * resources when new_size is zero). The contents of the memory are preserved
+ * up to the lesser of new and old sizes.
+ */
+void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
+{
+	size_t total_new_size, total_old_size;
+	struct devres *old_dr, *new_dr;
+	unsigned long flags;
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
+	if (!check_dr_size(new_size, &total_new_size))
+		return NULL;
+
+	total_old_size = ksize(to_devres(ptr));
+
+	/*
+	 * If new size is smaller or equal to the actual number of bytes
+	 * allocated previously - just return the same pointer.
+	 */
+	if (total_new_size <= total_old_size)
+		return ptr;
+
+	new_dr = alloc_dr(devm_kmalloc_release,
+			  total_new_size, gfp, dev_to_node(dev));
+	if (!new_dr)
+		return NULL;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+
+	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
+	if (!old_dr) {
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
+		devres_free(new_dr);
+		WARN(1, "Memory chunk not managed or managed by a different device.");
+		return NULL;
+	}
+
+	replace_dr(dev, &old_dr->node, &new_dr->node);
+
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+
+	memcpy(new_dr->data, old_dr->data, devres_data_size(total_old_size));
+	kfree(old_dr);
+	return new_dr->data;
+}
+EXPORT_SYMBOL_GPL(devm_krealloc);
+
 /**
  * devm_kstrdup - Allocate resource managed space and
  *                copy an existing string into that.
diff --git a/include/linux/device.h b/include/linux/device.h
index ca18da4768e3..5da7d5f0a7ff 100644
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

