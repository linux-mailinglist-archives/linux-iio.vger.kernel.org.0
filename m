Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002712506A8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Aug 2020 19:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHXRjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 13:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgHXRjH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 13:39:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D38C061755
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2020 10:39:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so5682983wme.5
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2020 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IM4nLu2vwj8edbMPLQ6Y8SGdHl2C8QezmkyULndrgow=;
        b=tJE4GjPTi870tfWVtDFHFf2cNVWrY8ls91g2f39HwQ6Sln7wRhLo0Ucy0F0ucsD93l
         ZY9K6VH1i/NvXk4V48YcjhOddjht3ncPVlEBJ9KLbvQNr624Y4qpNN97kFza45urAW8g
         s7L3L5Ehs0JN5olEsCDQw7QSQgL7tDckg4ie4J7ICylKkEKyMiD2fqaMUliFgz97VXId
         aNi2UnflPTs3i9nP1Kb1kQfuj+h5uDw65iMz/KehNWBE/L/wOEuipTmAcRnlxH+P2Sd6
         3/oRijwwVIv366lbDRPkVi+ptmnwPtt7lvT9dthZVHQfzGj9UU0TRj2NhD1m4WygFU7f
         PZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IM4nLu2vwj8edbMPLQ6Y8SGdHl2C8QezmkyULndrgow=;
        b=gjKvvp1IcwGhQIP3/hjnZbDkpgsYU2zURLfj5q5yfY/3BHgpaK2PwVTQqQAA4MOJ0f
         /5tPDFtzvbpsT/CvTmeob7AL4TWHQWDnWlnNXgfLRn2+mv7B0mh5dCCWcpz1DP5zzxX7
         5JtISnnMbuARySIWr2IoykrJquUX4RmQl5K+LY0d6qgCM23z5ohph6cWO98Ji4/EnJeb
         fHLTZXvbYaBbYRNmGAmslGmBQ2koTeRmt8Pn9QNMcqvpsIFAlUPu1w5DtrZEgG2RcbUx
         U5IHOjBKNlDHNvAjKESgQx22ugGJeyk+PhMqGrhKyq/UsxII+2ajevEjcwhoBo9MAdOE
         Fn2Q==
X-Gm-Message-State: AOAM531s3Ie7cnGYTneruCE4/C78Jfzbx2BV+LxOilvd3w/j9V7BaBHp
        WCzvhHb+N7O1IK7gntiUuBzYng==
X-Google-Smtp-Source: ABdhPJwFab+HKnem/w5mC3GHxWaWpYuvz+TPfeQHLz7XZaMrgpQ22emRmJcCSLxR8HtXpsXYOWvtQg==
X-Received: by 2002:a1c:e288:: with SMTP id z130mr404342wmg.32.1598290744509;
        Mon, 24 Aug 2020 10:39:04 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y24sm471977wmi.17.2020.08.24.10.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:39:04 -0700 (PDT)
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
Subject: [PATCH v9 1/3] devres: provide devm_krealloc()
Date:   Mon, 24 Aug 2020 19:38:57 +0200
Message-Id: <20200824173859.4910-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200824173859.4910-1-brgl@bgdev.pl>
References: <20200824173859.4910-1-brgl@bgdev.pl>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/base/devres.c                         | 105 ++++++++++++++++++
 include/linux/device.h                        |   2 +
 3 files changed, 108 insertions(+)

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
index ed615d3b9cf1..586e9a75c840 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -126,6 +126,14 @@ static void add_dr(struct device *dev, struct devres_node *node)
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
@@ -837,6 +845,103 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
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
+	total_old_size = ksize(container_of(ptr, struct devres, data));
+	if (total_old_size == 0) {
+		WARN(1, "Pointer doesn't point to dynamically allocated memory.");
+		return NULL;
+	}
+
+	/*
+	 * If new size is smaller or equal to the actual number of bytes
+	 * allocated previously - just return the same pointer.
+	 */
+	if (total_new_size <= total_old_size)
+		return ptr;
+
+	/*
+	 * Otherwise: allocate new, larger chunk. We need to allocate before
+	 * taking the lock as most probably the caller uses GFP_KERNEL.
+	 */
+	new_dr = alloc_dr(devm_kmalloc_release,
+			  total_new_size, gfp, dev_to_node(dev));
+	if (!new_dr)
+		return NULL;
+
+	/*
+	 * The spinlock protects the linked list against concurrent
+	 * modifications but not the resource itself.
+	 */
+	spin_lock_irqsave(&dev->devres_lock, flags);
+
+	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
+	if (!old_dr) {
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
+		kfree(new_dr);
+		WARN(1, "Memory chunk not managed or managed by a different device.");
+		return NULL;
+	}
+
+	replace_dr(dev, &old_dr->node, &new_dr->node);
+
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+
+	/*
+	 * We can copy the memory contents after releasing the lock as we're
+	 * no longer modyfing the list links.
+	 */
+	memcpy(new_dr->data, old_dr->data,
+	       total_old_size - offsetof(struct devres, data));
+	/*
+	 * Same for releasing the old devres - it's now been removed from the
+	 * list. This is also the reason why we must not use devm_kfree() - the
+	 * links are no longer valid.
+	 */
+	kfree(old_dr);
+
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

