Return-Path: <linux-iio+bounces-14873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F507A253A3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412DA3A5124
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4BA1FC7C7;
	Mon,  3 Feb 2025 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INrGHksn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE71FAC56;
	Mon,  3 Feb 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570157; cv=none; b=Ggr7gyRPjiys4DgPqAL5T9mlQmy1ylhBIJkGx/kDCfC1H5JTRb3EcHb8L7fmiu+cazUsLbZn7AkU7OzZqKZVefgx513jWJiSshNhbRtd3loTnOE5fQIUnrvhpEFkID72KaSN803u9WyLPfmLiIOXg0Fyidx+5XF7iPsNN2fZdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570157; c=relaxed/simple;
	bh=D+RhCNvD41bLngc68/4K+jMhVH3uRcMiXJfibIbqF8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bEbQbYxJvMQmAwa7owXIdUr5MbLQqKjSA04kcNUPh4SgMuMvMkSJQVKGLzhzzKGss2VkzjkeKK30G4j8u3XIlVP6xFKuu1B6jNeLpGKvks5i8H3+6oz5xj2VzpX3mMN2Pdp2UHM3hSZubXApEWpJaqoPDsqy5Km+IeElAL9Mh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INrGHksn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570156; x=1770106156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D+RhCNvD41bLngc68/4K+jMhVH3uRcMiXJfibIbqF8s=;
  b=INrGHksnAYKu+X2jKqFcHEET+pf3wBAIgDbLLEF5FHrdBxHX96NMn9SR
   y/f+bpGtI1K7KCAYuRuCjD/WWCXFMqhgZHLyxQyCw9D9BO7cm2O0TTzm5
   qOrIIO0Rbr7pBexPFrrK8y5qpeNUDbg/Wt6bKjMJpX3cyOJ5qsSkVzflL
   ao4scaD7WcjuaipzPVLStGm6ND8esuwp3JGT0B37NvYfzl/KmvoN1bijj
   kg8iPwFRXd9H9FBRAtzslGs+OZjHcSskXljgD5Cg7BQ5UmHjithOQTX2+
   vIs4WMZGnJexMKy982r7XfFsTWFSW8W5TvrKdKp2J+58hdajEbhDpEMeA
   g==;
X-CSE-ConnectionGUID: 98Sw0lDJR1S9L+ks1/XOiw==
X-CSE-MsgGUID: z9kEdj8pT/S77fiaC2WlAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654106"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654106"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:15 -0800
X-CSE-ConnectionGUID: SPjaVgVwQQOHTG/GGQxWRA==
X-CSE-MsgGUID: TKqmoqLNRMCcQWt6tYnRIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788441"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:12 -0800
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
Subject: [PATCH v3 03/20] devres: Introduce devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:45 +0530
Message-Id: <20250203080902.1864382-4-raag.jadav@intel.com>
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
index 128d65defafc..6ef400abfe21 100644
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


