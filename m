Return-Path: <linux-iio+bounces-15228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E2A2E474
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7AA7A223B
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F091BC9F4;
	Mon, 10 Feb 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLBlALwX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF51922F5;
	Mon, 10 Feb 2025 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170195; cv=none; b=oTjsC3F3PUbd2kF+Q39+CqdY0lbRC7XXyq6BifG794VRMiSnMjGI4Rotw5UmaUFuPrAB8rWJjaLcU4bxyeOQGZWOn/w2ShU8MAkt0/1b3B9smDm85LqVfZDgMYYlUtGBn/WaB5ZgfQqJKhoGhV38JyzSjyrqB3dvoi95y6ENhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170195; c=relaxed/simple;
	bh=PhbQs8p9waBKbeb44Xnob2Y5LcrbeI9vuKmKrB6wy2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mswyth9VkWIF9IqqrBXpK0Xu8W9xiZBTqzAzWcq8/V8mX2oOVXtYnbYGVpo1H622GZb8iyzqblzMEyxd7YDEEW3PFeBu9gqyFbh8B2tRQJeMhse22TIhIz1Ajrb7Fr0Isi/XpOymEpFCOnHqIEzjbIZXmMGQkbT846Gn5Gfo9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLBlALwX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170194; x=1770706194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhbQs8p9waBKbeb44Xnob2Y5LcrbeI9vuKmKrB6wy2g=;
  b=PLBlALwX1ZxBd+lNr4auPKL5FU02mbv90LOrgKQvG/u8Uf2dnoegh24m
   zGGTY1Qlb624Q/as86TN6eIoOwriC79e9QxAPDvhPmaih216e16YCXdOa
   lEJeLMd1eIEVhaJtoa2j9F7OyPWROJruTjSlmoDMhWEy7tr37H50E2vW9
   5Mpq/q4I0Cvd2bL3X10lZ2qV51Q15RjPA4Mtq6/95GplCbrITMD0GF4Yc
   ZempcDt7pgztCpaqbCfR92+emZds5rDzfKWs34Cub5si4se9US8zqHoCY
   v00NGhZsaHIXKlBEM9p/o9mdp9A0JtR3QTU+PqHLQNfIWU35OaTVWIE0+
   Q==;
X-CSE-ConnectionGUID: baD5DDPUQEmSrRsJ7jsgyw==
X-CSE-MsgGUID: PalWhvlESLuNbhpX9rI/Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499344"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499344"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:49:54 -0800
X-CSE-ConnectionGUID: VJ3ipuFDQDy0GDjb9C8G8w==
X-CSE-MsgGUID: obIty8Q3TfmVkW8mgoAv+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122456"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:49:48 -0800
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
Subject: [PATCH v4 06/20] pinctrl: cherryview: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:52 +0530
Message-Id: <20250210064906.2181867-7-raag.jadav@intel.com>
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


