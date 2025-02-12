Return-Path: <linux-iio+bounces-15402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD79A31ED4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43091650B4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01990201005;
	Wed, 12 Feb 2025 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nv6K+ER5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C00200BBF;
	Wed, 12 Feb 2025 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341553; cv=none; b=lJbUNL5OYYedWgsOuSThtGj335+tMLn0XKEM0iKZDbqchUTAciRxA8xVb6/uqqUIoHzOaA6+Nx4Yi0rOi3mqni1SvRvfHUqZFdnKu6SesadzTbqLgpK5b0fHBqzyJyPUZ87iUC0ih6lSf8KOIMuuAsQp8E0FGMrlehvzI/mjDmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341553; c=relaxed/simple;
	bh=i0Vg6izha13aWDeJ5vn8MBrolGY/TSxc4KHdVaVAYEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryVtv4NqVQBWmkIEbdY8aBWmC2qjKiqQBcYGQrDPgMbAgtgaSw+aG54U+WgLoX9izMeXpn6/PopSubkW/YJYne9hccCYFlt7g3w74g710s7A20wPn+9pVGS3CS3A8XmqGO87sItrmBvjNuGO8rDJphRwd9tCPkuuTkfKSpM8oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nv6K+ER5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341552; x=1770877552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i0Vg6izha13aWDeJ5vn8MBrolGY/TSxc4KHdVaVAYEk=;
  b=nv6K+ER5jVqmUxcGgHMoCUOkfW4mj3NLQt2ePSSE/XjjvtLt5cOREBtf
   HrLIn/T4jjG/NZLdrm/WtLMToUHZ+zP6tNqLDyabxEOlfFWWMO8AwMJHf
   DdsoWEOl1l/EgVeMwbBqLGponiQA0izWhrIRXklxzCnwGTK1Ss3Wjda1D
   Gluoammpo9V7oC80MmIloD7TI5oDfwxO+YFX9FWjHXZGifAsoXwPhAfAv
   oz+cJEsKFCR+a+2GBWuQQftignuKKfynoehrtptcG29ChyKeWBOabgcV2
   pc+RffTz5lctZ5Fcqj4GYPqXioudQVHTKEp+qX1eaN/tpIK/7jfADFAtx
   g==;
X-CSE-ConnectionGUID: KTc3C//gTnmUdLOE2rP2Sw==
X-CSE-MsgGUID: zzZc1hGGT/CGa0sBA3KWwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005216"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005216"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:52 -0800
X-CSE-ConnectionGUID: YPih9FbhRCaYYZF/gbSASw==
X-CSE-MsgGUID: 0qhcn4GSSPemJrY0a07AkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117812115"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:48 -0800
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
Subject: [PATCH v5 08/12] pinctrl: tangier: use devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:09 +0530
Message-Id: <20250212062513.2254767-9-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() and while at it, use source size
instead of destination.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-tangier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
index d3baf0f4eea0..ac61e632b487 100644
--- a/drivers/pinctrl/intel/pinctrl-tangier.c
+++ b/drivers/pinctrl/intel/pinctrl-tangier.c
@@ -524,7 +524,6 @@ static int tng_pinctrl_probe(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct tng_family *families;
 	struct tng_pinctrl *tp;
-	size_t families_len;
 	void __iomem *regs;
 	unsigned int i;
 
@@ -543,8 +542,8 @@ static int tng_pinctrl_probe(struct platform_device *pdev,
 	 * Make a copy of the families which we can use to hold pointers
 	 * to the registers.
 	 */
-	families_len = size_mul(sizeof(*families), tp->nfamilies);
-	families = devm_kmemdup(dev, tp->families, families_len, GFP_KERNEL);
+	families = devm_kmemdup_array(dev, tp->families, tp->nfamilies,
+				      sizeof(*tp->families), GFP_KERNEL);
 	if (!families)
 		return -ENOMEM;
 
-- 
2.34.1


