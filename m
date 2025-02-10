Return-Path: <linux-iio+bounces-15227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016CCA2E46E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547C118861CD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129B01B87F4;
	Mon, 10 Feb 2025 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZ36aXnW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6331ADC8D;
	Mon, 10 Feb 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170189; cv=none; b=rngSPrGm20I1Gq6ysTRnWPPHgKr+Ek8EPnIs0d8KcFEf8HseywpHgMrWZ5zbiUTYyvsCxdQ37GSNnuI+zAS2DiUUM/PdgC2Jby27KFiSWQYV6jIXaMdiToqNrzOzpz8UsjAPdYSmW4zuwt1dKn37oCrzsYew3GIvJRPriFaDHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170189; c=relaxed/simple;
	bh=NZrOpoIR0kcwzhW5RiAR7w3SpFSD3n21/pIeM0wBqjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0pspEIR8o+u1r8zv7lhmhA8cIh/WC+bnh68dPZMInKHT8+N+uMfoXtiUxUczuIdIv4FxnNbvr2t0ea87RKMxNXX5ogvlXBai9f4blkaL6n9TIW8GLCN5E/VLFm+/kAjSv1xMRkGrfYrfGknvbzuclaPvNwPJP60OkgvhpQ20Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZ36aXnW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170189; x=1770706189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZrOpoIR0kcwzhW5RiAR7w3SpFSD3n21/pIeM0wBqjI=;
  b=MZ36aXnWjK7nmm/gNyVICO9TwJDdEG8chNVomAC97RB8PrvTsUpz9AT6
   cDbzMQ5SaRrjcYo5rgEc0xifwf/CvytnUcYl0nBKs5kaCBAeFzaU5sKER
   dzPEMzPdlZvkgaxjMy0J/ZMHrd/M0mAxkCZCH/ZXcCiCX8Xqz23VFzV8q
   +Vjejj7sLl3tLybfHbdMGn/HDK8fei+/4EJ+PjqUPk4fy0Xtcs+dJucu8
   VelcC6WkOUOw+DRrU+Np5eVJZMhbNuVK3mNgn4J6ZA3Pcl/N7GXUTydO4
   VMstFxYyQLTVOceTAysHxG1nZDS/LEady+czjwuSXC/s7nWZTNTJcBsCh
   g==;
X-CSE-ConnectionGUID: Ce6M/7KfRX2faHiVDBN6Mg==
X-CSE-MsgGUID: FNgY+MOFQdyUmkwewlb6nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499338"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499338"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:49:48 -0800
X-CSE-ConnectionGUID: hm7soczWSCy4NSeEe6nnUQ==
X-CSE-MsgGUID: iew0Pi8ITduN6ADbQ8mFNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122446"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:49:43 -0800
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
Subject: [PATCH v4 05/20] pinctrl: baytrail: copy communities using devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:51 +0530
Message-Id: <20250210064906.2181867-6-raag.jadav@intel.com>
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


