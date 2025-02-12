Return-Path: <linux-iio+bounces-15398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC19A31EC6
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9144A3A0FC9
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA5D1FC7C6;
	Wed, 12 Feb 2025 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXihWwJn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375A1FF60D;
	Wed, 12 Feb 2025 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341538; cv=none; b=LB3afkzJ/biK4C4dDuQHEv81eG+EryV/GUhXxinigvCeItWhSCQfgi6pFgYjarseBMGv0c8AQe8YrtaKFee8V0BcPW/xa/yNpMx/32kMiFMNTntqkQ5n+9357U0hLg/XL3w4HMU32Rt/wBQS71fE7LXGZFuNk/8pwNDKVZmqk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341538; c=relaxed/simple;
	bh=kXNsZ5OEPvESAT2ItADgSvaxbJWn0Bu43326BOmRHII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmanCDMZ+OWSVWsVaGkgW5IdObTNFY5rRoFPUs0P+r6ZnYyAmEG5DeSjBACy3dNHV26cAFiiffKqepdZQriAbNWlvtAIqbv19LgPszIqN6eeEiCUmCH93mBCHX67PeJv6YXmseSUZszN/eDcUh7d72LO/fpqmjgmEgwrH42YiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXihWwJn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341537; x=1770877537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kXNsZ5OEPvESAT2ItADgSvaxbJWn0Bu43326BOmRHII=;
  b=dXihWwJngw/glPIcVlkOxtWVhFuevQdPcP2VhOCPVbBuji7l6BvDDHX8
   YKAhQSVILYHeXXMy2p3Ke6DGzlhUg/58GVU8TryzCGSUtei6Fbea6WXgT
   bkJWr9rf+hiCMT3GDiyFcDC2p4Upu2zt09gRj7j1UYkXAVVMEgzT4L1vQ
   8No0FDui4B9t4fP95CtBX04/k9wb6HllBcwmhqn56ilkBouXPEf12+vPB
   U3AXBX4j63d+qDxXkcrAX1i8ZTEKFXfIokMUOQ8y8LRbVpS7qQSwSKlzg
   K0XC+7NW5Q5YFywxr30Ugehp/5faZGXt9/0UtNa5F4kG+S1SHUdLGLaO+
   w==;
X-CSE-ConnectionGUID: TQk14WMKQ8O1GMea+zIsPw==
X-CSE-MsgGUID: L7V9n618S8OnR3jmjkpKXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005178"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005178"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:36 -0800
X-CSE-ConnectionGUID: CgIPukCaRF660G0wvOHD4A==
X-CSE-MsgGUID: jINXPxBMRFuMHSguzkYokQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117812005"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:33 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v5 04/12] devres: Introduce devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:05 +0530
Message-Id: <20250212062513.2254767-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212062513.2254767-1-raag.jadav@intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce '_array' variant of devm_kmemdup() which is more robust and
consistent with alloc family of helpers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/device/devres.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index 6b0b265058bc..9b49f9915850 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -79,6 +79,11 @@ void devm_kfree(struct device *dev, const void *p);
 
 void * __realloc_size(3)
 devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
+static inline void *devm_kmemdup_array(struct device *dev, const void *src,
+				       size_t n, size_t size, gfp_t flags)
+{
+	return devm_kmemdup(dev, src, size_mul(size, n), flags);
+}
 
 char * __malloc
 devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
-- 
2.34.1


