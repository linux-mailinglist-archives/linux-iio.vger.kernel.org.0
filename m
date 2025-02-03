Return-Path: <linux-iio+bounces-14878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF6CA253C1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A071F3A54F2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B99207667;
	Mon,  3 Feb 2025 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkQsWXmr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547511FBE9F;
	Mon,  3 Feb 2025 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570185; cv=none; b=j4CzSv8zo/aw8sJcUyseh1lDgstlS+UvzFkXi74yqz6lzcz/mYFelWGiPvo2xQuqjsEF3HeMQ0xvFmipZDvgnL8KxoXeErCpqww3ti9Cq4/77BF0ONcXFzXdUMW0fm+UxQZOf3ckr+2dOPk5DOmb0V0E3hfSxm3g7eIkppOVO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570185; c=relaxed/simple;
	bh=CMhnUnr4463VNOt0ws9aGEqOeemLByI7HN+Yah3gnW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s3d8TkC43lM9BDOIbpLu5aPmfUoYSnNhpapsBJN502P+KiTaSUaFE5nunIOOiUZakCmnM0XXpcXw/2B0lgH0ACc35Jg1qAFLE46N2ZDzwgI2DxCyOtHe3uRtNOZAPGFUgPrkWmtKjGjW48Lwu3wkDPROfKNKg97er49mbWeExWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkQsWXmr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570183; x=1770106183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CMhnUnr4463VNOt0ws9aGEqOeemLByI7HN+Yah3gnW8=;
  b=fkQsWXmrKJUwqAUiiB+oc1aYhTNabaNw7nKF6f4zu0o7p9quoOV01DC2
   Rcy+M4wBJD37XHCZ4AfSmAamZmMyb7Es9qVIg2lPKAE+THDpHFl3W5QP6
   7/xF//OpihLqEr6HVxdfWhe0Mb6g3b8uSdiVZJGwTNMXUjG3h1KadH5BX
   yUy+ntaBgrphuyfk6nEvzi0NqArHCwuA7uvu9rBt4MJQejJJ5p7io9jFC
   4AbKcRony4EBdf2wFZriLc+pODTCK9o+PiWc3TX29TyhEyOveMZz7f06f
   HZ/3ibLIeYPuvdclYZ8Gp6Yd68xJdzYdKcOrty4i4S4bdPGOYZbxuNZR4
   A==;
X-CSE-ConnectionGUID: MiAjEDxVR2O/W8ojKfTPog==
X-CSE-MsgGUID: QMfYacZwSGWcuyy9C0vqZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654158"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654158"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:43 -0800
X-CSE-ConnectionGUID: 6hPJyCMDQ+21KZuVA15zLA==
X-CSE-MsgGUID: IF1gma4CTWi05kIbDRGugA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788522"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:39 -0800
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
Subject: [PATCH v3 08/20] pinctrl: pxa2xx: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:50 +0530
Message-Id: <20250203080902.1864382-9-raag.jadav@intel.com>
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


