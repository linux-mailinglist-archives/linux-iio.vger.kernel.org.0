Return-Path: <linux-iio+bounces-15226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE4A2E46A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC363A51B3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F001B85D3;
	Mon, 10 Feb 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWESRNpl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11C01ADC78;
	Mon, 10 Feb 2025 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170184; cv=none; b=OuGi3vpGTiVVT6GQRlcpfJ6QqJr/LYvAm6nD919ohmiGgiHC0z2GPgR1iFFYbjLmuu5Ng4/IBIhKdSY1xkFVB7vlX0Soc2B5CWBFFuF27X3N9gT0///vbHMbkjtGjVZ0DORWrw4WpuVZqxmRGCteoisfTfKk+WTr8Dn5QqhJLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170184; c=relaxed/simple;
	bh=1xQJNdT7uFvRmUE5qxdSY8EWMedqqbakyODPKyiYp6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b93Ww3/hANa0Y2/RXw/Rex9WFSk3ELogpFW/cdddt5hy/5vs4sDa+PpTCFGDGmRTo1tVcFNkx9hvNkWHPYKzLD8qncmVdLkg02zax7wqDm6bHhWCJ8xCSeHHU+jp+bA7kruJATSIMFCrdvgsmgdTZM+NI6HEeUEHiVQqLN8QEGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWESRNpl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170183; x=1770706183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1xQJNdT7uFvRmUE5qxdSY8EWMedqqbakyODPKyiYp6E=;
  b=HWESRNpltsFyI8YwgxsdcPx6wi/QrPedPc2lhlOmIK/h5tk9Rgvyvsx8
   EjHnMtnZ1OAYl3D50hEtlswwgo92Z09tisys5y/oKvs1D/PJbQ2ZE8R7z
   Yq93cos3pnaSefXfDEfcKEximmykCEhD6IVF5816eYoGXNorpWoEkTxsG
   n/c7yYMKj0WK6sgF55utzx0BQdZLasTsSvKwX3+GG0Kv1uKK3LO8KjMfK
   N2tBgT7cjSa+UB5B8hnDJ7/2qgJZOwj/0N/Ed2Kc4O233tg3hCgtOcRnh
   6YSmZezlcxW060wTNfV3M8H6O8V3bCdSUxcrTW6Cxq0Bk6irft/S6rrGl
   Q==;
X-CSE-ConnectionGUID: 1/t7txfYRlGkR3J/XIN+Ng==
X-CSE-MsgGUID: v5uPb/GrROWjaqC4+QH8Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499328"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499328"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:49:43 -0800
X-CSE-ConnectionGUID: 5NKvkyYaSTyc/mvCtur4rA==
X-CSE-MsgGUID: GMf0iXUKRAytWtxqMy59Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122436"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:49:37 -0800
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
Subject: [PATCH v4 04/20] pinctrl: intel: copy communities using devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:50 +0530
Message-Id: <20250210064906.2181867-5-raag.jadav@intel.com>
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

Copy communities using devm_kmemdup_array() instead of doing it manually.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index d593ad03f949..baa3686d7764 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1577,8 +1577,8 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 	 * to the registers.
 	 */
 	pctrl->ncommunities = pctrl->soc->ncommunities;
-	pctrl->communities = devm_kcalloc(dev, pctrl->ncommunities,
-					  sizeof(*pctrl->communities), GFP_KERNEL);
+	pctrl->communities = devm_kmemdup_array(dev, pctrl->soc->communities, pctrl->ncommunities,
+						sizeof(*pctrl->soc->communities), GFP_KERNEL);
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


