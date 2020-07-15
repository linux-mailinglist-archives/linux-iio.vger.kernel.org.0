Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634932208A9
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgGOJZf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbgGOJZd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 05:25:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457CBC061755
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2020 02:25:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so1608505wrw.12
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2020 02:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpXopXA9x90Wjy6eqipdqGTrFJSiDmax3dW/BVZ/exg=;
        b=OkHF0M8N72w/ViIlFgdpGBVuiFHoxGV2bvG7K5MxGl8vwEBQVoFLfX8DHRabPmzHK+
         whXuFhRnEGpHFBXwcaVp9ASmIVZYOIMsVE6sfYt29BXKGeXurD/JEReY3t2vwzZnOJ/0
         aohZUlkMpLG2234iZcTnCaWkgMC6edvX71zRqqPdH2fFOeF3dYXjxjxs/Dd68l2BPgRs
         EZjMLJyQTFJ1/F7LQGX49d5n7FSgYuFZhqnBIAeRDEexQsYzGKxR/c1D1iAZ4FcdDAs8
         e2Ri3dPOQTmX9uCM9bpeC6UUpjybqo0ts85oUUxx9hp7wB9kzOy7EcKI+3afTkfXD9tG
         oFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpXopXA9x90Wjy6eqipdqGTrFJSiDmax3dW/BVZ/exg=;
        b=SYihunpRtx5Tr4Hx2V0JhRijxkcuvPJyTjB+NvaKk+KQvI3H4swGJTHfckYvSMr0qj
         STIKplciLCJ7OSyFKdflPbFMubVleLrekBkixnQxeENEg/E77ttEFiv4jFR2IVG6li3K
         XzYN3E+cIyf6gknytbPuhblhCyN9bxnOhzL8zv1oclbgJ1jgDVlip+i5pgTAWtFoEOxK
         kFphvMdmJfNQXUUvx8YEWANnOmGIWJhn349eqzDKngd98/UaVW0iS/vSvkB7R77Y/gOh
         e0RawnZfUOZlTbCABjhLFwKjYoqt1UWxovdm4Vl844LDmwxZem5YFWMP3SPoqL4Tei4q
         RBuA==
X-Gm-Message-State: AOAM531ifAmBPKDSqGSewQFaybwG7xdaLMd2a738fwlNf4zaNTqkFoIe
        bdJpLnxztdOluvXZv1NmNbEQeQ==
X-Google-Smtp-Source: ABdhPJx08isc11ZEFi5Fr1kS4qnSfmfkUN4cSC+ENZEui02cY7HrLoSWibPtPtW9htyIBIbA0gN28Q==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr11103040wrm.103.1594805131963;
        Wed, 15 Jul 2020 02:25:31 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id v11sm12083419wmb.3.2020.07.15.02.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:25:31 -0700 (PDT)
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
Subject: [PATCH v5 1/3] devres: provide devm_krealloc()
Date:   Wed, 15 Jul 2020 11:25:26 +0200
Message-Id: <20200715092528.8136-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200715092528.8136-1-brgl@bgdev.pl>
References: <20200715092528.8136-1-brgl@bgdev.pl>
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
 drivers/base/devres.c                         | 68 +++++++++++++++++++
 include/linux/device.h                        |  2 +
 3 files changed, 71 insertions(+)

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
index ed615d3b9cf15..24e27959af270 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -837,6 +837,74 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
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

