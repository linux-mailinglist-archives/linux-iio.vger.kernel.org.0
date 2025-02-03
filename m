Return-Path: <linux-iio+bounces-14874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3852A253A9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C87A3A53A1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD411FCF44;
	Mon,  3 Feb 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/uhVN2q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAC51FA178;
	Mon,  3 Feb 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570163; cv=none; b=ehXVtvi42wMZWH1ctnD3+zeOOxFG+HOgJMhu8omwX3BCm6V50G9s4/S6siGan3f4kThr4d4fIWJZrStVVMhITr2qGIC+KYC6LRfvE7qao7vVEhd189yOjSWIBVQ/29D2VpKX8pm0SAB1lzT/+XM1b+R8SM4OWH/om+qqUn8VNL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570163; c=relaxed/simple;
	bh=GXYV0orH70R2NryxmvHyRUUP/UpUF2N+PCzrF2VKTgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nkztn5NiXVtM8ZJd/iNBEvcsNnaNlr4s+glEQZ7lMKc6i92HNccSRhCEr0/EVqWUvDqhKhkyFtSKZOHhuTKYV7nM9RUJYOsE72G1+MPimQVe+tif2ZMGdg/HVd04OLQ5tOdqy/8kOSSd+94EJFzNfeb5Nsf4ubzj069zKtRw7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/uhVN2q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570161; x=1770106161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GXYV0orH70R2NryxmvHyRUUP/UpUF2N+PCzrF2VKTgA=;
  b=f/uhVN2qJE5JvOmNzvFBszeIdwKHy5ba4C5VR4eAVYSzrlQlliHUMUIt
   3Qg5IVgfcwhHADCn1XXj6sjg06DUqQ3acGFxdyqYKOrrYOP/K3oKMAv6U
   WAs5H7y0oSUtdKf8NOWBtAu7CQcMFCQrboiAzahvQxi7cxDOmJs6VxXuo
   SyQmshHO3FKybyWU7eM48diAgeZNrm5G9IeR9BCORg2pdCgPHqGYQfnVs
   kwSOnrtHwuq93lycBDmp5lKF9RWb8uqKQE7P1vkl1tj3gLKM4zt+GZujQ
   ZBzivK/yKLER1TjN27hwMa69BHLOfKBIZWAITnZ/5wCouDSv3aOGsLeRk
   g==;
X-CSE-ConnectionGUID: CFXbkBdsS4qiJnEB+w7mAQ==
X-CSE-MsgGUID: L6SfeLrfR+Goa1sGccMH/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654126"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654126"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:21 -0800
X-CSE-ConnectionGUID: 0KnX28oERXyAzskGY7P7pw==
X-CSE-MsgGUID: WibekBpTQp6sbziYAsh78g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788491"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:17 -0800
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
Subject: [PATCH v3 04/20] pinctrl: intel: copy communities using devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:46 +0530
Message-Id: <20250203080902.1864382-5-raag.jadav@intel.com>
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

Copy communities using devm_kmemdup_array() instead of doing it manually.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 527e4b87ae52..0a1905869472 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1577,8 +1577,8 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 	 * to the registers.
 	 */
 	pctrl->ncommunities = pctrl->soc->ncommunities;
-	pctrl->communities = devm_kcalloc(dev, pctrl->ncommunities,
-					  sizeof(*pctrl->communities), GFP_KERNEL);
+	pctrl->communities = devm_kmemdup_array(dev, pctrl->soc->communities, pctrl->ncommunities,
+						sizeof(*pctrl->communities), GFP_KERNEL);
 	if (!pctrl->communities)
 		return -ENOMEM;
 
@@ -1588,8 +1588,6 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 		u32 offset;
 		u32 value;
 
-		*community = pctrl->soc->communities[i];
-
 		regs = devm_platform_ioremap_resource(pdev, community->barno);
 		if (IS_ERR(regs))
 			return PTR_ERR(regs);
-- 
2.34.1


