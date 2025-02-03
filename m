Return-Path: <linux-iio+bounces-14877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE6A253B2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D41F1884606
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAE72066E1;
	Mon,  3 Feb 2025 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvJwihDP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3871FBE9F;
	Mon,  3 Feb 2025 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570179; cv=none; b=HrwK5IJZldgStlVWVL5YVagF5fOsjQ857innn3CVk1OkasIHw4zQBXLIVDf1mPbzFwuUi/1czfCRv12xe8tHgxFdUd+5rmhhI3BnuW6L/IR2f3RUDWM49FQlhQ6hf0rTKHa+m/ShQCm1FTu+Ydkfgk/aFehwIqXSBlZg6ens3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570179; c=relaxed/simple;
	bh=Xuc7hS1zlRLuER1FWLMZl/k1Q9r5SbWrqebmKseTUQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DzIpifQZWLo+wh2oXR3ewGC0zWrxQv3G1OaLFCA1qGja5y3CL5qyZpZQM6jXDvQyEUScGHGBl+/AH+C5QpwvKp4nxElKUkyz+TRznguHbLR7uSBYOuA1sC93jwVm9w+6VFOQSMZuaZa8YKC9ErBiYBeNx/sINdyWVXIjynMmG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvJwihDP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570178; x=1770106178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xuc7hS1zlRLuER1FWLMZl/k1Q9r5SbWrqebmKseTUQU=;
  b=kvJwihDPg9hkAe4z/rh4FR7+DUIV+nMymPxw6MokmfwqcrsuqRcyrXc7
   2FnwvOa5FJlZIT/XSNjqeOfh7zi6yAnZQZqjtlYvcq88kwkrpUuwn9A0E
   dZQaDfPBzO4uEYTMZdaphbRYhc5LzSXhcKzIGcE7CtRrfSiF+GhoIprVK
   kJKScLcpKgxYud/J3BCl+7a5LTg6p64dANbi21E5se71oKl4WIKD63eOu
   fu6vEB8zF7w33PbBH+3LB6PFJ4tmurtXDgFu3Ih6u7/zGfYIiZPAHhAWP
   hv/0GDUYj3NS/92j8uUcot9Ka4yYj1zr4GuwjnoL4VeviN+0RHKPoaj3A
   g==;
X-CSE-ConnectionGUID: PaquM5LvQ26CKAJvCtov+Q==
X-CSE-MsgGUID: +GmVyVOsTYyfP6Ihq05C/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654150"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654150"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:37 -0800
X-CSE-ConnectionGUID: BroHsbuYSGubbNWU+KivtA==
X-CSE-MsgGUID: 9jn97e1XQjuDJEs7LwLDHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788509"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:34 -0800
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
Subject: [PATCH v3 07/20] pinctrl: tangier: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:49 +0530
Message-Id: <20250203080902.1864382-8-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-tangier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
index d3baf0f4eea0..e9a742ddf1f9 100644
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
+				      sizeof(*families), GFP_KERNEL);
 	if (!families)
 		return -ENOMEM;
 
-- 
2.34.1


