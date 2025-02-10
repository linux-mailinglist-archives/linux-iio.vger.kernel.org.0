Return-Path: <linux-iio+bounces-15242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302B9A2E4BD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9931884EB8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE10A1DE3CF;
	Mon, 10 Feb 2025 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diwcHWQ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09C1AF0AF;
	Mon, 10 Feb 2025 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170272; cv=none; b=gD2IdGY9FvM97ItuKEJnWqaC3znBuTOjMKSxEaXZ7O3bm/z+FC9ViqWSpnkcXDMEBp1B3deJZubybCyv74Hu7UhObgg4cfFLc5GDsuptntr8BRblrkV1p7q84P+0K9xUKIGP10xG6GZShuiuN0CkXzFLPOOxTLRp1n9Jtyvf+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170272; c=relaxed/simple;
	bh=rmG5AJg763QuUwHiI4zIJ8TFRtKX3Nej46Hu42LYCJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mnuz/jB5ibCM3+7CxH/ijwDHN8aIZ8NhQWAXDU+q3rubR0k8rDY7zn4+P+1XzGvD11XdO4sq3jukcNpqn3QRavWZtAqbKxI6aESjdj4T1bFRReNcva0hHYsWAJNS5C0sMqmYV9JjqrExJQ8pqtS0pGZDYO3vc8kn+FmwWXuzTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diwcHWQ6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170271; x=1770706271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmG5AJg763QuUwHiI4zIJ8TFRtKX3Nej46Hu42LYCJw=;
  b=diwcHWQ6Z6Dg099qNctEunjRDt9wFkaBqyThcyUvLswYfKRbBZRsid3R
   Bx9FgWUPYG1tVIPqJV0hUyLLpir7PLL4ZqWWjpyurb+a/DY/oyPWHmnze
   fxkI/3V2gM9UFbfJw129bCaMPul8D5jxUxHsmv+ZZLhzMjGCnRo06OK82
   FRqkfzFC+kfzBq0Dd4mJAVtfhjz89dCLTzZdrERJiZ8o+PkcTLr7Yvb4N
   Yl7I15/48ECmJkzhi00OwO/sx7kw+wME3WgM/nnWROqj0kyOBoJqO14W9
   6PybSFNRRR5pzGZfTElwAzw3R1x1xA9mTn/ZW6fJBq/3SbDdjjTAJ8RWO
   A==;
X-CSE-ConnectionGUID: WGp/YFGnRMi2lso1lpMj9A==
X-CSE-MsgGUID: dxioNWiVRXWS0/C2tIy8PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499468"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499468"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:51:11 -0800
X-CSE-ConnectionGUID: qzXCctUsTDukvjIjjq8hmg==
X-CSE-MsgGUID: gPxWE5btS8qOJ6Ff6PazAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122726"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:51:05 -0800
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
Subject: [PATCH v4 20/20] ASoC: uniphier: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:19:06 +0530
Message-Id: <20250210064906.2181867-21-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() and while at it, make the size robust
against type changes.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 sound/soc/uniphier/aio-cpu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 470f129166a4..3224c11a527f 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -762,14 +762,10 @@ int uniphier_aio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	chip->num_plls = chip->chip_spec->num_plls;
-	chip->plls = devm_kcalloc(dev,
-				  chip->num_plls,
-				  sizeof(struct uniphier_aio_pll),
-				  GFP_KERNEL);
+	chip->plls = devm_kmemdup_array(dev, chip->chip_spec->plls, chip->num_plls,
+					sizeof(*chip->chip_spec->plls), GFP_KERNEL);
 	if (!chip->plls)
 		return -ENOMEM;
-	memcpy(chip->plls, chip->chip_spec->plls,
-	       sizeof(struct uniphier_aio_pll) * chip->num_plls);
 
 	for (i = 0; i < chip->num_aios; i++) {
 		struct uniphier_aio *aio = &chip->aios[i];
-- 
2.34.1


