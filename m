Return-Path: <linux-iio+bounces-14876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF1A253AC
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89386188472A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180F205E17;
	Mon,  3 Feb 2025 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gcp9cSCL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E21FAC57;
	Mon,  3 Feb 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570174; cv=none; b=RNkqwzGTkkcvPOXN5KbhNFCGlz6lDjBlqoa2n27gmFRoQXJcOerwWeP1/54KUGORsMb/RCLEyWAiqu02rBKvpVZFT8X+ojy9Vxmqbb0hDYLpH/mT45e8e1qAa+jTK6bpaWZZkSw+zJc/6xQmCFoIJOfXL1PZ2q+QuYGuSlwkN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570174; c=relaxed/simple;
	bh=OoC2DC8bR9/Lwyni6OiCmLFgeIae3uP2mgo+wZ4jjFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2JmEyh15JPLh9ezykMFTnATe7i4ImKmuLf4PEG+q1+giLZGwc9s65e260sehM/vzTUA/OOgqoJbZurWXwsaudwVlmPrWm8OdNuk/efdLAycnQhBdktuC9KYA9F18t5wX1kHnQaUOCL4iKBZNXkE88EqqSMkbrqjmRmFiGXL92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gcp9cSCL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570172; x=1770106172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OoC2DC8bR9/Lwyni6OiCmLFgeIae3uP2mgo+wZ4jjFo=;
  b=Gcp9cSCLdvgNcVFygez4s8WfFdlr5ehz0GQE5JsZqZKyjxPKDjquON9J
   R4MWZKlU2BtQssCXciMD/DG61fYeCjKDfhkxTslcw4d/ceTth3FOm9ssB
   +UHNbs1/Nb9wikAwi8cQhVkAKW9i28UipXg42lc7DDqDL7rZ79fMnKFEh
   qqc1EMbb7FkJDkBrZsjrQBF5qJe/KwtRbNc5Fbx1WWDoIBW2ldUO+06Cu
   5W7DuF1jITWR6+ua9Vm2zLcuL+EnYLRyrLavT5gnh8WS022XHvndQNPc4
   TcTBC6S9qPBBFnspjE/ri6T0bm7dMsS+lyOVEzEB/GM54xKK+iXmuQbyF
   A==;
X-CSE-ConnectionGUID: CDgUpiSAQ8aqyQasbmKj5Q==
X-CSE-MsgGUID: i6iEv2UST+az6utPiPXdlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654140"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654140"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:32 -0800
X-CSE-ConnectionGUID: SZ7SO365SCSJ2QvZoXK4Tg==
X-CSE-MsgGUID: wJJKsSpWRAubW+HUo0Y4jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788503"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:28 -0800
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
Subject: [PATCH v3 06/20] pinctrl: cherryview: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:48 +0530
Message-Id: <20250203080902.1864382-7-raag.jadav@intel.com>
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
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index c673e262e1db..df97aa97c278 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1631,9 +1631,8 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	pctrl->soc = soc_data;
 
 	pctrl->ncommunities = pctrl->soc->ncommunities;
-	pctrl->communities = devm_kmemdup(dev, pctrl->soc->communities,
-					  pctrl->ncommunities * sizeof(*pctrl->communities),
-					  GFP_KERNEL);
+	pctrl->communities = devm_kmemdup_array(dev, pctrl->soc->communities, pctrl->ncommunities,
+						sizeof(*pctrl->communities), GFP_KERNEL);
 	if (!pctrl->communities)
 		return -ENOMEM;
 
-- 
2.34.1


