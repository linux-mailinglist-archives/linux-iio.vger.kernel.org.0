Return-Path: <linux-iio+bounces-15223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC0A2E45A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415871641B4
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A451ADC8A;
	Mon, 10 Feb 2025 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3BbtGM1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED67199237;
	Mon, 10 Feb 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170168; cv=none; b=t2sBWlV/WjGPK8xiR6xDlzxRZhRiWRuMVllY8Le5hj5zAngVJApOI+dN2Fit67/Yo05kqVq81iXa48OaLZ+45/gcjQ/B3Ur7tuVkkp1I+ou+4mweakUx/PnWJQkYIK3naSOoZhPBZAxkPJ+RU1PZIU0CKEjD3l6sLwEcO4P8dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170168; c=relaxed/simple;
	bh=0/mIx0lDcKAufZebxBVJ3umyd0uC7bn2bFzKCrpc1rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ba89MDMaISIOslIth0X+IqWiiObyybUkYVJTXvzlbdTBtny4pIaq1uQfZ7hp7OD3cZQAa4ETdU5OEfymzkbNEDLIoddEehbURfPaaDBsoisOfjI7trro8SEZWToZe1Mmcd2NBpgTgR3afyIzVGaB/YLDJVhHxPHr7AOD7XhfTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3BbtGM1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170167; x=1770706167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0/mIx0lDcKAufZebxBVJ3umyd0uC7bn2bFzKCrpc1rA=;
  b=b3BbtGM1YilcbuxSc06cqp+I2xj6r7aMHQH/aveTcfgnZjm6ILbeFSqG
   86mJowXujpmhu94YzQJamAUQxECNMjaA6SSn9cnDfyoeByDlQPiWbkMbs
   FXwdVZMWqD9s35rlz03p1OWbMw11KiJuv1RAOZJVJ4OPASOeqvI0FVgwq
   UIadQMaDoMenst7JSYp/qwvmI2OrSmJy5BydwedPoqpjmGzBnsGMRYbqR
   MrxeDgdsWnw1mZLXeWrS/lhsoPwqm2IH3ILqBqNdhyybAeVUcmUkoMvt3
   himooppvmsEbXJBgq/44xycGnQBwAdjXV0sqYK98JkAaXlvcDmyuTvEMM
   Q==;
X-CSE-ConnectionGUID: WToqYP2kRtaLJEd5m4Ho5w==
X-CSE-MsgGUID: nvcPWWtHQuesBI0gegb0nQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499290"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499290"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:49:26 -0800
X-CSE-ConnectionGUID: ozlGUaOcSsC/qRV2hHGpcA==
X-CSE-MsgGUID: UmvCuoM0TH+zkcFUWpbv2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122385"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:49:20 -0800
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
Subject: [PATCH v4 01/20] driver core: Split devres APIs to device/devres.h
Date: Mon, 10 Feb 2025 12:18:47 +0530
Message-Id: <20250210064906.2181867-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210064906.2181867-1-raag.jadav@intel.com>
References: <20250210064906.2181867-1-raag.jadav@intel.com>
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

While at it, cast the error pointers to __iomem using IOMEM_ERR_PTR()
and fix sparse warnings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 include/linux/device.h        | 119 +-------------------------------
 include/linux/device/devres.h | 125 ++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 118 deletions(-)
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
index 000000000000..4ec4c658879a
--- /dev/null
+++ b/include/linux/device/devres.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DEVICE_DEVRES_H_
+#define _DEVICE_DEVRES_H_
+
+#include <linux/errno.h>
+#include <linux/gfp_types.h>
+#include <linux/io.h>
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
+	return IOMEM_ERR_PTR(-EINVAL);
+}
+
+static inline
+void __iomem *devm_ioremap_resource_wc(struct device *dev, const struct resource *res)
+{
+	return IOMEM_ERR_PTR(-EINVAL);
+}
+
+static inline
+void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
+			    resource_size_t *size)
+{
+	return IOMEM_ERR_PTR(-EINVAL);
+}
+
+#endif
+
+#endif /* _DEVICE_DEVRES_H_ */
-- 
2.34.1


