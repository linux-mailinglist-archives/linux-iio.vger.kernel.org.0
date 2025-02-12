Return-Path: <linux-iio+bounces-15399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D3AA31ECC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC4A3A94F7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522741FFC55;
	Wed, 12 Feb 2025 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eT9hASGv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C91FF7DA;
	Wed, 12 Feb 2025 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341542; cv=none; b=JsCd8Fs3vfrKFWjkjkx4LI8dCMWz2B7ISoIl97iXWv4Zg0p1mKkiVjL/ouQthrHVt5561RoVrQ5IRnwG/f6T4w37f9YQInAb/C5GNWsKoq0mG6dkb4uzceFnDuRAzPujGXcNYbgCX+tzL2Bl95JxaIG9sRUvfbIJdmVy2ud5cIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341542; c=relaxed/simple;
	bh=dSWBLCsTgDJb/ooxSXROwWN2INPzEVBKHz8DnUA0erc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QSBAiQdq1ZQyE0F2utkSwoUu9oAZgnOLP5KTBFSz7iC4fYLTQMdctAzMHjRE6MGbDpKnKWn2MPegwyRvAK0loBSzxI/kSUzCDVFwr6LIZRxDuotDWTdlAZ800FXJpl4htX29YxNQQjZz3eGkbRxb+Wo3omsa1rwsm9ycvJSWy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eT9hASGv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341540; x=1770877540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dSWBLCsTgDJb/ooxSXROwWN2INPzEVBKHz8DnUA0erc=;
  b=eT9hASGvORC74/WO51/QwkGS0hjXOU2XBZlNEdOofT5BH9f4SGZAIKb/
   lJhlY0I8h/fotIfYcg+52WukQbL2hFABjTR17q2EOxRznlCrQKSUGEEzH
   1xTD/wa0VKCZJXEIjyXnp1cQJzOf261rBUIO5CYcKY1b+6JBL5VfJM3GO
   /tvKl9Ek1Rfg4BiLOLkYUnTBICntr9SKYlQAByp/F7NqQt2SoXOU8CGoT
   SUewdttTEP93JcuuplhRHAhNmdBjdSzgX2BfbDJQIuuE6FV1KMMNZCU9w
   SLqRh+egrNmTL7KTTqoPtaXaJvLo3Fe7f+7GlW6G/6kCvThDjYOHSxokz
   Q==;
X-CSE-ConnectionGUID: 11vSKXzzThGC3ENT6dfn5w==
X-CSE-MsgGUID: 96JcxjRSQW6yQkXjJdiFQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005186"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005186"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:40 -0800
X-CSE-ConnectionGUID: p9ltLyOoTSi8CRFRBbV0jA==
X-CSE-MsgGUID: wsyqyTZORcGxmwlgHJXdDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117812023"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:37 -0800
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
Subject: [PATCH v5 05/12] pinctrl: intel: copy communities using devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:06 +0530
Message-Id: <20250212062513.2254767-6-raag.jadav@intel.com>
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

Copy communities using devm_kmemdup_array() instead of doing it manually.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index e4de88e10d68..d889c7c878e2 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1576,8 +1576,8 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 	 * to the registers.
 	 */
 	pctrl->ncommunities = pctrl->soc->ncommunities;
-	pctrl->communities = devm_kcalloc(dev, pctrl->ncommunities,
-					  sizeof(*pctrl->communities), GFP_KERNEL);
+	pctrl->communities = devm_kmemdup_array(dev, pctrl->soc->communities, pctrl->ncommunities,
+						sizeof(*pctrl->soc->communities), GFP_KERNEL);
 	if (!pctrl->communities)
 		return -ENOMEM;
 
@@ -1587,8 +1587,6 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 		u32 offset;
 		u32 value;
 
-		*community = pctrl->soc->communities[i];
-
 		regs = devm_platform_ioremap_resource(pdev, community->barno);
 		if (IS_ERR(regs))
 			return PTR_ERR(regs);
-- 
2.34.1


