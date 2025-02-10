Return-Path: <linux-iio+bounces-15225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6AFA2E466
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868523A4B28
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A91B424F;
	Mon, 10 Feb 2025 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSVSJUHj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352CB1AF0DB;
	Mon, 10 Feb 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170178; cv=none; b=AZXwIBJSYRpUitPsN0dHQ5NWYVy9yketgCgBPZrdeUGRnALvWCdiVd0HEm1KGL22GddaQGgsk/rBM3H13C80fcqNRZp/lFHtzPk1RSw9DufU+ZCk5gbGqKc7o4kA/l40+9+Le4ab9naFz6XTLLeEMvb8/6SMx1riBb7yL3viG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170178; c=relaxed/simple;
	bh=yZUkpezDWb6PWJ0o7eQG3RTvuXmRTg1DIwLHbE6Jk/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dai432PtX+NBc19vTkxruP5B7Mw4tHKxQBhu2dU/IepDEZVMop6IYVfCToAY3x3Tvs6CyQrbPKlRKUejWCzsHlCUPQw8MAZBRaP5Cy7f7/682t56iHTY6oap1kl+rtFMKkyH7MJvvUGgu59XRHYSs36Jmyc3PsUCrGVNfbb8gZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSVSJUHj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170178; x=1770706178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZUkpezDWb6PWJ0o7eQG3RTvuXmRTg1DIwLHbE6Jk/k=;
  b=KSVSJUHjvMmVcJluP6iPyh61pHIn0JGnGd+NBDIOJnZ0L/Qaads5P3jn
   plE+z0UQUb/PYtnCaIEg/vsKpMY5gzVN60lDN4dx5+TVe89fOZzde+Y60
   vQRITmtywGWLwaSjTkUXe604q2nGXZowixrXSEFrhS8CSeKMy3Mc/lBXo
   QaJCPllcva/Hbo4RUk/6H0D4xnnezru6p7jTIFVhdg7DLUcA5QkyUvIPr
   DCiCn5HSnwGp70jFfO9ekrDxFt0GZZAMsVzURwETzgd/sOiMgKcxRo1iL
   zqVl+H0tyfv4tRRFO2clPwgR2/6ML1r4ZFQNdlZkXmy0EIfBm3Gdqacuq
   A==;
X-CSE-ConnectionGUID: fEVCVri0SMiCVDUs+goCNQ==
X-CSE-MsgGUID: m9NuUVOaQwCa0siREiKkoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499303"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499303"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:49:37 -0800
X-CSE-ConnectionGUID: vrD5siRwSFWTIdSrJpq8/A==
X-CSE-MsgGUID: uwIr33ewT4aOepm0opVtrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122423"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:49:32 -0800
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
Subject: [PATCH v4 03/20] devres: Introduce devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:49 +0530
Message-Id: <20250210064906.2181867-4-raag.jadav@intel.com>
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
index 4ec4c658879a..634af06ec775 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -80,6 +80,11 @@ void devm_kfree(struct device *dev, const void *p);
 
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


