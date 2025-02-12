Return-Path: <linux-iio+bounces-15400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0CAA31EC9
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCB1167366
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC07200116;
	Wed, 12 Feb 2025 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0TOYOOJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584151FFC73;
	Wed, 12 Feb 2025 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341545; cv=none; b=nEzMyPuMrfUp7Qs275wC6jFlGkl6WxlflaFVTouz4Pczn/+Hu8wTvNf1hOmnFTuqoBZuVSqM12/MvrX9DqtGuh/ecrJ0YPALWVc2VbZabcHzUWlymhXMwoQK17jvbb5oVwExZRKrPK3Wm8MUsSrbiN60wZJ9XELZeIafoJ/P0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341545; c=relaxed/simple;
	bh=NZrOpoIR0kcwzhW5RiAR7w3SpFSD3n21/pIeM0wBqjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQKjIrZNeBtkZ/ogc2HL5HO9HEpCY1l2QxsfZGbwVSwmoQvNZz2X3U8kO7LaA9zO9QWvWbym22myQrPaKlINQSVb6zXxCRzxxZRT0L3ZI1ZRyZ0MsY9AGOyxz56L7OlzbiPU1rXPlZLTSUVNbEy0bqKGPmcJgxzWYp86bm/24As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0TOYOOJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341544; x=1770877544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZrOpoIR0kcwzhW5RiAR7w3SpFSD3n21/pIeM0wBqjI=;
  b=K0TOYOOJDXnvZXe3Z+Alkm9u+vRefFAovI26/MAZmg0l+VfGCyjhpfQi
   3HWxTq/5UHmllJCRqntTr+UOfzUmYw2LKbauS0Q90vzRgfPHe4Piu2gnr
   ncILELdqjdWGyyqmNXyoCmEdvql3oGQH7vj6b/9Eb/gJYXwQ7XtU8edz1
   M5aL0uHtKbAj5gKoUJUIveO4SDQ0jScxYN+ZiZAelUtX9X2yc072uWpel
   UW9/Lla+hfhcuOx4Y9AhCnaB4bQ2spejpRrEsvTNs4cDtSlKGD26DhYCD
   wBhubbd2cWEKYG3+r63MVmcD42LXi3Zrpl3P59OeSjU5sDtox9YCrQIst
   w==;
X-CSE-ConnectionGUID: R/MPFpaVS2+HNS7n18M3KA==
X-CSE-MsgGUID: iK65QunjSnWi+rjgOS45Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005199"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005199"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:44 -0800
X-CSE-ConnectionGUID: 8SEEhFUSRb+fduAoTX1iWg==
X-CSE-MsgGUID: VyvogbmVTvWDq4sHoTfZeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117812058"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:40 -0800
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
Subject: [PATCH v5 06/12] pinctrl: baytrail: copy communities using devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:07 +0530
Message-Id: <20250212062513.2254767-7-raag.jadav@intel.com>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index c4458ac539ff..969137c4cb06 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -1560,16 +1560,14 @@ static int byt_set_soc_data(struct intel_pinctrl *vg,
 	vg->soc = soc;
 
 	vg->ncommunities = vg->soc->ncommunities;
-	vg->communities = devm_kcalloc(vg->dev, vg->ncommunities,
-				       sizeof(*vg->communities), GFP_KERNEL);
+	vg->communities = devm_kmemdup_array(vg->dev, vg->soc->communities, vg->ncommunities,
+					     sizeof(*vg->soc->communities), GFP_KERNEL);
 	if (!vg->communities)
 		return -ENOMEM;
 
 	for (i = 0; i < vg->soc->ncommunities; i++) {
 		struct intel_community *comm = vg->communities + i;
 
-		*comm = vg->soc->communities[i];
-
 		comm->pad_regs = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(comm->pad_regs))
 			return PTR_ERR(comm->pad_regs);
-- 
2.34.1


