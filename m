Return-Path: <linux-iio+bounces-15403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F2A31ED9
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2227A37A8
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441D201033;
	Wed, 12 Feb 2025 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVwn8oc/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113F31FDA78;
	Wed, 12 Feb 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341557; cv=none; b=ZcHgP937qMJEPI01cNo6V+qrt1Cu3h7gcxmAm3q6atXpXLIep9CJQ7+uk3QcTWJkYL7gCiUzry0FpePyC/N0sTF009gyyTkX8HGym1X6W0X2lIeKr+JK3E40BkDYORu3lpO0K4+DPI20HFGGNTeefmEmRZJM3nfVy93HNyNMRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341557; c=relaxed/simple;
	bh=CMhnUnr4463VNOt0ws9aGEqOeemLByI7HN+Yah3gnW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2h+vGdna1R4yFMvcCWrGltcCSY7VNS2NEOg0KarqQHDodaxmdChAdooSD2sPM12rDMs4cbcA8pC4hxivvchh5coMS0m9wnVF4ZKCF5Ah6txjYKby8yzpmPoCrsiLPqaeF6vPrIsxMmdHdQg2ew77yXfW8XB/WghdZmcfmWrbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVwn8oc/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341556; x=1770877556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CMhnUnr4463VNOt0ws9aGEqOeemLByI7HN+Yah3gnW8=;
  b=dVwn8oc/0UtQ0IaTWjW1AdsBQ/y13j7woHXSXzUid9uPRq+2vuY1vpud
   M2BnFJ+/0YeYy6N/+03V6SEJnC5xp8uMMHNdEho1LOD0gnoFR+5+iFxca
   HW/gibRy3ylTbogYzlOqxJlV7JlhOxqgdTo4jTPHXC3O0rVbWAWBgEMW1
   G4SQCM1+WjUuPTU5PtxgWn2wm3LkX9piT7SgLbB6B25VR/lmYLx2HYKSy
   fqv63YyS5/IElDLvXfNL2neP1w6PnyE/0V/IvBGU4OkDAeplIhHn7RfTE
   sHAjFxb0JIUVtmLx8lYvV4BNJ+f6DKPoW/tCcETfv28emjxwAjHUD4dwd
   A==;
X-CSE-ConnectionGUID: Q4jvTedOS+KpP7oTsjHd4g==
X-CSE-MsgGUID: Wi47lSoOR5KCg4nNEj3Gng==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005224"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005224"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:56 -0800
X-CSE-ConnectionGUID: mhJo2of1Qc6KD2fbHq9VPA==
X-CSE-MsgGUID: IXSmKUubRwqoZvMyBsS9PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117812147"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:52 -0800
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
Subject: [PATCH v5 09/12] pinctrl: pxa2xx: use devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:10 +0530
Message-Id: <20250212062513.2254767-10-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index 9e34b92ff5f2..9fd7a8fb2bc4 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -281,9 +281,8 @@ static int pxa2xx_build_functions(struct pxa_pinctrl *pctl)
 		for (df = pctl->ppins[i].functions; df->name; df++)
 			if (!pxa2xx_find_function(pctl, df->name, functions))
 				(functions + pctl->nfuncs++)->name = df->name;
-	pctl->functions = devm_kmemdup(pctl->dev, functions,
-				       pctl->nfuncs * sizeof(*functions),
-				       GFP_KERNEL);
+	pctl->functions = devm_kmemdup_array(pctl->dev, functions, pctl->nfuncs,
+					     sizeof(*functions), GFP_KERNEL);
 	if (!pctl->functions)
 		return -ENOMEM;
 
@@ -314,7 +313,8 @@ static int pxa2xx_build_groups(struct pxa_pinctrl *pctl)
 						pctl->ppins[j].pin.name;
 		func = pctl->functions + i;
 		func->ngroups = ngroups;
-		func->groups = devm_kmemdup(pctl->dev, gtmp, ngroups * sizeof(*gtmp), GFP_KERNEL);
+		func->groups = devm_kmemdup_array(pctl->dev, gtmp, ngroups,
+						  sizeof(*gtmp), GFP_KERNEL);
 		if (!func->groups)
 			return -ENOMEM;
 	}
-- 
2.34.1


