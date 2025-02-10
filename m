Return-Path: <linux-iio+bounces-15230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE67A2E47E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC71118861E8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1842D1BEF6A;
	Mon, 10 Feb 2025 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+J89JIp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480A1922F5;
	Mon, 10 Feb 2025 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170208; cv=none; b=LYUaBmeX4IdqL/q47KU7xFQuM8doo0pn/9FAPck+C2oGdPDjsdqt7yTRTkr997A75ujjV2I91qxbxhaxr5mUIItZSGlU5VhBFzNqDQMzu2q/TYL+kJ1bxV5XvFtvgIo5O+dIjHKGKTeVzJq6uFh5K0PaUkJa+stGd/O1jijPsic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170208; c=relaxed/simple;
	bh=CMhnUnr4463VNOt0ws9aGEqOeemLByI7HN+Yah3gnW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5P35MhoCs/wlL/t06nj9J7mNbrcYi3dQ2c2UY4fxXh2T+bmw0nSRv1Yhe3tITZvwCDCHHWX+V+z12xYwRXPHxoYhFKODSgjfTVMh6PvnR7bw6FLOd4vFXF5bszwORFWCZsLA3JFv8PO1YbbsKo3InATdQ7DV0x242kSh2cVJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+J89JIp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170208; x=1770706208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CMhnUnr4463VNOt0ws9aGEqOeemLByI7HN+Yah3gnW8=;
  b=Q+J89JIpSL+L3BQOvG+tc4I1QjbMNb3so09whqzs4A4NK8UaJYAMbHYN
   kijq58X3rXDdERLxAQplZP28g1bOfXsr80VsC0Vhf2s2mVMyRw6ALLR57
   J+e8x4fV+NYgiFLbsl1HIZwZIwoo+yo02HbkwSNz8nmt59LRmTzBzhBKc
   TkaEyHPU5mQ2bRRbIijnbMhAvIUISSoQ4AR5iV+QkScPdaHftouE0L3qq
   HU4qZfyqlOS+XZcQ2f5xOAJUFyApFWo4EQADK6R86WZRypfugsxKqwKMV
   gstlkvXPpuErVL2yGZVeTeR0tbTOJg8kkljInDHnbaOyh2szalpGjw+CO
   g==;
X-CSE-ConnectionGUID: qt7SrQ3+SzmglHiaUhnyyA==
X-CSE-MsgGUID: fL2yb55aRJCdD3cllNbXPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499370"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499370"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:50:07 -0800
X-CSE-ConnectionGUID: BDLuerSYQ/iPXogW+ulCiA==
X-CSE-MsgGUID: LUtaK3B2QCuAt0vw3Viz5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122533"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:49:59 -0800
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
Subject: [PATCH v4 08/20] pinctrl: pxa2xx: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:54 +0530
Message-Id: <20250210064906.2181867-9-raag.jadav@intel.com>
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


