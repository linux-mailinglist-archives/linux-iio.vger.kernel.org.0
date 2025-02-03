Return-Path: <linux-iio+bounces-14890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61BA253F5
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A82D16481A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A60215195;
	Mon,  3 Feb 2025 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJZupebz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7D1FBEB2;
	Mon,  3 Feb 2025 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570255; cv=none; b=LL2tOUFv7wF8l5RA9bDKJs5fX8q4EgKbpE+Ct3cjVA3XfcpP1g5ZcVeBEiWPoQNNXjAr2HU64zeu8bM/eAwcy7c4X0WbBAfUpxSX7BD211CHELVWd6P5kNWE62HrEFGiDx8QEYcr/i5SnZyympDvtLxx6Lis/cc2UU/H5St2Ja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570255; c=relaxed/simple;
	bh=SphjoMu5QyKhAhaOtzkRUUaDVbtlBQlqGuY3h1dWhso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qtn23ZThqjALTvyTso1pUk26cyCYvoKeqQotjOq/t+ofvV2A4YswgnHflo9HVXr977jHLi/gDubCwBD3GaWuTSqRo/dVG42HPh2UsNBAW8bB8P9hf8L1CcruLX/1cGzOlkjm+Nl4aNioDO12SGZU0XxmIR0g11nRMEmVgJY8IsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJZupebz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570253; x=1770106253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SphjoMu5QyKhAhaOtzkRUUaDVbtlBQlqGuY3h1dWhso=;
  b=DJZupebzRh2HBT/Fg3ECb/LgkGDXk8yrj++l0KBjJ5FBpEOGOSsDqyJp
   qS2yvo3fzdZ6k1MGLazPdE9jIJ2tLch/XZ4Vdxiu3BSCY45xI2sPVZZEb
   E6MbF1Io7I2btwWLyK1KXbeDzR48/ZCozKmAtLQSf1hOvMSpZ3Rhom89/
   /OfbMIEXKe2OdQX/7BjecvTncd41wlvGZRXier39Ze1Rel1BGB6y1fO8c
   wdjZH5AFeAKvfCsUdSnYGkEuG5IheWJeg83Yv0dbbcBx7IrwgcC+nPQxF
   WjZpZmMbt1BkFoyMUXtppxmWa8HBuk/dKptRoeYdPEMe+kM6pVZksQDaO
   A==;
X-CSE-ConnectionGUID: yoZCEj5iSr+qM+Aj/bstaw==
X-CSE-MsgGUID: ZLG72tpBT3icBAMy/lLXOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654339"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654339"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:53 -0800
X-CSE-ConnectionGUID: EqeDqQ/aS92vll0bqveLrw==
X-CSE-MsgGUID: /Xo1xFGQSxGQMSk7XBXw3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788994"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:10:49 -0800
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
Subject: [PATCH v3 20/20] ASoC: uniphier: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:39:02 +0530
Message-Id: <20250203080902.1864382-21-raag.jadav@intel.com>
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
 sound/soc/uniphier/aio-cpu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index 470f129166a4..44f4053e5584 100644
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
+					sizeof(struct uniphier_aio_pll), GFP_KERNEL);
 	if (!chip->plls)
 		return -ENOMEM;
-	memcpy(chip->plls, chip->chip_spec->plls,
-	       sizeof(struct uniphier_aio_pll) * chip->num_plls);
 
 	for (i = 0; i < chip->num_aios; i++) {
 		struct uniphier_aio *aio = &chip->aios[i];
-- 
2.34.1


