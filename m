Return-Path: <linux-iio+bounces-15401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CB4A31ED0
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20A3167439
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE6200B8C;
	Wed, 12 Feb 2025 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNtMbOUZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C71FCD11;
	Wed, 12 Feb 2025 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341549; cv=none; b=QaP7dOZfpB889vXRTMg+lBwOIy0sh7nsPIFQesWkZettjVHVi9dGdjTiFjIBaQA53G3cOzucRxAD7sx7vOItWBxGaDIjoouhmlcTVqrle7+LVfU1bowjg9VoAhQT5Uh3/8BYP40G+fI6OteeAMOYUkXiL5Cg3wvAFWSBipO8N3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341549; c=relaxed/simple;
	bh=PhbQs8p9waBKbeb44Xnob2Y5LcrbeI9vuKmKrB6wy2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8uyuEhvaZqunTxcmznGAu0iQ01/xGbkFu3MafMHLV4gPVJM7LAZ5FfD6bvvCVSJD9dp7SQ9nEYHesFWvgXcOo3hM+UJZsO6l1ttH0jQu7KcM4LbPFSdiLo8RMSiIZeTJzsdeUZsiB9k/dW+axqrwLDLH/eoPZJ7NFcrPs3mdKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNtMbOUZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341548; x=1770877548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhbQs8p9waBKbeb44Xnob2Y5LcrbeI9vuKmKrB6wy2g=;
  b=UNtMbOUZ7oFoQFalVeoLI+MMSdf2ssp7ZjCiA+gJFm8ZsvTmKE/fuAGI
   0FYeRzJ+g1ue82vv/Hpl1/UGJOAEzaTSiz6PMl6A01aqXxwfLby7hyF9r
   ldmj2o0of9rZhfFLJ/THbfcSPadYFock0bym2CN3y6FX32KbUSC9tfe3h
   m35ABb7gM8/ZiGKK8jGcTTg7xTdj2+HDlQ3qo8noh38YDX7Q1qINlqWIi
   bJ3oJnj1PVwU1EjUFKi5Yz1/IXrgNzHIvj4JPbznkd3LV8LUjL03C8bjH
   eHmAA7gGELgHqNHnc1Jdd8uKrB5ZMNCUB+IPfeRO37GS2YwuU0UeeCVUo
   w==;
X-CSE-ConnectionGUID: excMh5fOSBipktZahUNUpg==
X-CSE-MsgGUID: RTSCA3htRKO1GG3hjc20Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005207"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005207"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:48 -0800
X-CSE-ConnectionGUID: UuqZEjoEQru7xspekINK2Q==
X-CSE-MsgGUID: JkL0YjVQSkies85l4OTGWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117812086"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:44 -0800
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
Subject: [PATCH v5 07/12] pinctrl: cherryview: use devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:08 +0530
Message-Id: <20250212062513.2254767-8-raag.jadav@intel.com>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index c673e262e1db..69b18ce0f685 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1631,9 +1631,8 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	pctrl->soc = soc_data;
 
 	pctrl->ncommunities = pctrl->soc->ncommunities;
-	pctrl->communities = devm_kmemdup(dev, pctrl->soc->communities,
-					  pctrl->ncommunities * sizeof(*pctrl->communities),
-					  GFP_KERNEL);
+	pctrl->communities = devm_kmemdup_array(dev, pctrl->soc->communities, pctrl->ncommunities,
+						sizeof(*pctrl->soc->communities), GFP_KERNEL);
 	if (!pctrl->communities)
 		return -ENOMEM;
 
-- 
2.34.1


