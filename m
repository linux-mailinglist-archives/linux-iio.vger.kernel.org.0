Return-Path: <linux-iio+bounces-14871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF18A25397
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E3C1884E35
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF671FBCAF;
	Mon,  3 Feb 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVxBwSqZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2344D599;
	Mon,  3 Feb 2025 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570147; cv=none; b=A2YMXhVbEkMaJ48BbmWbHmM2PZCHW93NPCHUZ7r457/oMR/gDBEieztZY1WZCHRGK3sFbinWF0uj2aiNOXO45WUwlCPhYhpcsLvMgInuxO74DRG0JH7ybpu+fV0WQe65hj5C/JJZWSBvjl2gocZIOUDkrDCC0W7+ODT4gKZ3qYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570147; c=relaxed/simple;
	bh=DTXNyig/1ACgJNyRQIga5IVUxeHEQKbU9z47pViCjHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=diJmpIpl4u6w1x4ziC6jcMdNg/9dUKchR0QxUCPZAHYv3TUlnZXd62vmoU8bQhu+sKioCNUDKdTMy42ScKk+wlGevavZ5+u9Vy1fHnzNlZQPrf2skGCsfNOyomNvkhDcl8h0yWqAtAiPlnrKI0r6SKqkYWyRvOmMENxa3N8koJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVxBwSqZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570145; x=1770106145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DTXNyig/1ACgJNyRQIga5IVUxeHEQKbU9z47pViCjHw=;
  b=MVxBwSqZEhpNaldVmcc7X0n3QfL0XwiszPMoa6fR7mvT9VUIUiySXh2v
   9sqtKBUAzrXNIn/M8e3Kt89Gbz8WWlc3F3eNLYZ99ss5gAU8dDHs8JDjU
   eFg7XmZc8jR5iLKd4OHRYFwxV2UCUqCN1A9CNNGL6xNDDO7n/sp9vSdRS
   T+4kVAuPUNuxtLxNvYrm2aqhfKfu1oFB8ss4c2k4iujrlRnqKLcSWGUzb
   jLP+Bgn6nS0QV3QFC6kkW52Y/uXXyGdEhCnIpp4On2kKn2NuTj+/SL5pN
   WUk4Y6U/VnveEnIDeL0Ahe6eO03NF0jYkAaJ9I9lFIGHlEOWEDo/U2Nb/
   g==;
X-CSE-ConnectionGUID: 9Oz3CoMKRtCV6vfb5eX0BA==
X-CSE-MsgGUID: 13xZx9myQcC42w/Bs10yhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654065"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654065"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:05 -0800
X-CSE-ConnectionGUID: 2XvlLHTRQZmsWTYucRKSkg==
X-CSE-MsgGUID: pm8c1FMKR9mGJ3ptdhHOEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788417"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:00 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	sre@kernel.org,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 01/20] driver core: Split devres APIs to device/devres.h
Date: Mon,  3 Feb 2025 13:38:43 +0530
Message-Id: <20250203080902.1864382-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203080902.1864382-1-raag.jadav@intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

device.h is a huge header which is hard to follow and easy to miss
something. Improve that by splitting devres APIs to device/devres.h.

In particular this helps to speedup the build of the code that includes
device.h solely for a devres APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/device.h        | 119 +-------------------------------
 include/linux/device/devres.h | 124 ++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 118 deletions(-)
 create mode 100644 include/linux/device/devres.h

diff --git a/include/linux/device.h b/include/linux/device.h
index 80a5b3268986..78ca7fd0e625 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -26,9 +26,9 @@
 #include <linux/atomic.h>
 #include <linux/uidgid.h>
 #include <linux/gfp.h>
-#include <linux/overflow.h>
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
+#include <linux/device/devres.h>
 #include <linux/device/driver.h>
 #include <linux/cleanup.h>
 #include <asm/device.h>
@@ -281,123 +281,6 @@ int __must_check device_create_bin_file(struct device *dev,
 void device_remove_bin_file(struct device *dev,
 			    const struct bin_attribute *attr);
 
-/* device resource management */
-typedef void (*dr_release_t)(struct device *dev, void *res);
-typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
-
-void *__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp,
-			  int nid, const char *name) __malloc;
-#define devres_alloc(release, size, gfp) \
-	__devres_alloc_node(release, size, gfp, NUMA_NO_NODE, #release)
-#define devres_alloc_node(release, size, gfp, nid) \
-	__devres_alloc_node(release, size, gfp, nid, #release)
-
-void devres_for_each_res(struct device *dev, dr_release_t release,
-			 dr_match_t match, void *match_data,
-			 void (*fn)(struct device *, void *, void *),
-			 void *data);
-void devres_free(void *res);
-void devres_add(struct device *dev, void *res);
-void *devres_find(struct device *dev, dr_release_t release,
-		  dr_match_t match, void *match_data);
-void *devres_get(struct device *dev, void *new_res,
-		 dr_match_t match, void *match_data);
-void *devres_remove(struct device *dev, dr_release_t release,
-		    dr_match_t match, void *match_data);
-int devres_destroy(struct device *dev, dr_release_t release,
-		   dr_match_t match, void *match_data);
-int devres_release(struct device *dev, dr_release_t release,
-		   dr_match_t match, void *match_data);
-
-/* devres group */
-void * __must_check devres_open_group(struct device *dev, void *id, gfp_t gfp);
-void devres_close_group(struct device *dev, void *id);
-void devres_remove_group(struct device *dev, void *id);
-int devres_release_group(struct device *dev, void *id);
-
-/* managed devm_k.alloc/kfree for device drivers */
-void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __alloc_size(2);
-void *devm_krealloc(struct device *dev, void *ptr, size_t size,
-		    gfp_t gfp) __must_check __realloc_size(3);
-__printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
-				     const char *fmt, va_list ap) __malloc;
-__printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
-				    const char *fmt, ...) __malloc;
-static inline void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp)
-{
-	return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
-}
-static inline void *devm_kmalloc_array(struct device *dev,
-				       size_t n, size_t size, gfp_t flags)
-{
-	size_t bytes;
-
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
-		return NULL;
-
-	return devm_kmalloc(dev, bytes, flags);
-}
-static inline void *devm_kcalloc(struct device *dev,
-				 size_t n, size_t size, gfp_t flags)
-{
-	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
-}
-static inline __realloc_size(3, 4) void * __must_check
-devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
-{
-	size_t bytes;
-
-	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
-		return NULL;
-
-	return devm_krealloc(dev, p, bytes, flags);
-}
-
-void devm_kfree(struct device *dev, const void *p);
-char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
-const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
-void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
-	__realloc_size(3);
-
-unsigned long devm_get_free_pages(struct device *dev,
-				  gfp_t gfp_mask, unsigned int order);
-void devm_free_pages(struct device *dev, unsigned long addr);
-
-#ifdef CONFIG_HAS_IOMEM
-void __iomem *devm_ioremap_resource(struct device *dev,
-				    const struct resource *res);
-void __iomem *devm_ioremap_resource_wc(struct device *dev,
-				       const struct resource *res);
-
-void __iomem *devm_of_iomap(struct device *dev,
-			    struct device_node *node, int index,
-			    resource_size_t *size);
-#else
-
-static inline
-void __iomem *devm_ioremap_resource(struct device *dev,
-				    const struct resource *res)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-static inline
-void __iomem *devm_ioremap_resource_wc(struct device *dev,
-				       const struct resource *res)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-static inline
-void __iomem *devm_of_iomap(struct device *dev,
-			    struct device_node *node, int index,
-			    resource_size_t *size)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-#endif
-
 /* allows to add/remove a custom action to devres stack */
 int devm_remove_action_nowarn(struct device *dev, void (*action)(void *), void *data);
 
diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
new file mode 100644
index 000000000000..128d65defafc
--- /dev/null
+++ b/include/linux/device/devres.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DEVICE_DEVRES_H_
+#define _DEVICE_DEVRES_H_
+
+#include <linux/err.h>
+#include <linux/gfp_types.h>
+#include <linux/numa.h>
+#include <linux/overflow.h>
+#include <linux/stdarg.h>
+#include <linux/types.h>
+
+struct device;
+struct device_node;
+struct resource;
+
+/* device resource management */
+typedef void (*dr_release_t)(struct device *dev, void *res);
+typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
+
+void * __malloc
+__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp, int nid, const char *name);
+#define devres_alloc(release, size, gfp) \
+	__devres_alloc_node(release, size, gfp, NUMA_NO_NODE, #release)
+#define devres_alloc_node(release, size, gfp, nid) \
+	__devres_alloc_node(release, size, gfp, nid, #release)
+
+void devres_for_each_res(struct device *dev, dr_release_t release,
+			 dr_match_t match, void *match_data,
+			 void (*fn)(struct device *, void *, void *),
+			 void *data);
+void devres_free(void *res);
+void devres_add(struct device *dev, void *res);
+void *devres_find(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
+void *devres_get(struct device *dev, void *new_res, dr_match_t match, void *match_data);
+void *devres_remove(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
+int devres_destroy(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
+int devres_release(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
+
+/* devres group */
+void * __must_check devres_open_group(struct device *dev, void *id, gfp_t gfp);
+void devres_close_group(struct device *dev, void *id);
+void devres_remove_group(struct device *dev, void *id);
+int devres_release_group(struct device *dev, void *id);
+
+/* managed devm_k.alloc/kfree for device drivers */
+void * __alloc_size(2)
+devm_kmalloc(struct device *dev, size_t size, gfp_t gfp);
+void * __must_check __realloc_size(3)
+devm_krealloc(struct device *dev, void *ptr, size_t size, gfp_t gfp);
+static inline void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp)
+{
+	return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
+}
+static inline void *devm_kmalloc_array(struct device *dev, size_t n, size_t size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+
+	return devm_kmalloc(dev, bytes, flags);
+}
+static inline void *devm_kcalloc(struct device *dev, size_t n, size_t size, gfp_t flags)
+{
+	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
+}
+static inline __realloc_size(3, 4) void * __must_check
+devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+		return NULL;
+
+	return devm_krealloc(dev, p, bytes, flags);
+}
+
+void devm_kfree(struct device *dev, const void *p);
+
+void * __realloc_size(3)
+devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
+
+char * __malloc
+devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
+const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
+char * __printf(3, 0) __malloc
+devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt, va_list ap);
+char * __printf(3, 4) __malloc
+devm_kasprintf(struct device *dev, gfp_t gfp, const char *fmt, ...);
+
+unsigned long devm_get_free_pages(struct device *dev, gfp_t gfp_mask, unsigned int order);
+void devm_free_pages(struct device *dev, unsigned long addr);
+
+#ifdef CONFIG_HAS_IOMEM
+
+void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res);
+void __iomem *devm_ioremap_resource_wc(struct device *dev, const struct resource *res);
+
+void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
+			    resource_size_t *size);
+#else
+
+static inline
+void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline
+void __iomem *devm_ioremap_resource_wc(struct device *dev, const struct resource *res)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline
+void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
+			    resource_size_t *size)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+#endif
+
+#endif /* _DEVICE_DEVRES_H_ */
-- 
2.34.1


