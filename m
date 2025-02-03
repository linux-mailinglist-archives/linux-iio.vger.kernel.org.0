Return-Path: <linux-iio+bounces-14889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93823A253EC
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5B87A13B6
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A986621517C;
	Mon,  3 Feb 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gM1R34kO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0700215169;
	Mon,  3 Feb 2025 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570249; cv=none; b=MQlViX5yOrXdUzZYBis9b15fJ/L8Ctm6OjBhCcC8oDYggmya8HHJKwR/i7CiDBadIWM0+bNVCN31FB9ZrTLBpIeskugxmOaCzPq0bYQOk84j01o/7cvRTlYhl5bjfvLmWaHcObmD5hXjAnkzU5pD+nkrr0UTLOuzg4v7DrSyB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570249; c=relaxed/simple;
	bh=RHHyVMG4EoULJq/bEkGgTePdgnTNpqG5oPkccUePrV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e98evZh6hH+Q/I2flA3ob6P+rX1B3VhyAF7qqF51528sjW292p/2M7N6BnQzT/+2xKvRO4/ALJ9Yif92Apq8PuVUuqOnEf/16ld7828UOzXTEjeC6RcEr3D1axnwQBBdwRk+EzF1jH9nehTr/4y9KENxTCEzA/Jk673Bs4A90f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gM1R34kO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570248; x=1770106248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RHHyVMG4EoULJq/bEkGgTePdgnTNpqG5oPkccUePrV0=;
  b=gM1R34kObdyPQ94XLVQYYX2TRRQ4sXuHR5Z80PozZBHfXpnUVp9CNb/t
   QygyX3J60ceG0Wonw0hTmGR5VvSfH2BHhPrG4zXAscvDh0KaDr4I7BbNc
   CO9tjjYlskHJ7Vit/90yduvhM9hc+fDG7txWTSHhK0dM0GH0TANQbZJNy
   3HwHwJTezFYCea2K49jaPSgYRiO2VeITlc8g3PhdyLMtjPiA7QT1RiKAj
   Kzv4ZiUtCakJFvPV9KIip2JSNg8ZuZT/oCvH3Squ+e8OnJzi+UEhcAcQa
   7DjLCYF0+rQJ4Adxud4Leu44o4H8HG4wmCUIWgmR1aSkARZRp6J3T+9A1
   w==;
X-CSE-ConnectionGUID: rpn7bNqPRi+RNl5lFG/iyA==
X-CSE-MsgGUID: 051Bm3ASQX2pJ19YPwpoWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654319"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654319"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:47 -0800
X-CSE-ConnectionGUID: jm6afwMUQzqEcqbvMQDCtg==
X-CSE-MsgGUID: MZnnC1p7S6OgZYMgJBLR0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788969"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:10:43 -0800
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
Subject: [PATCH v3 19/20] ASoC: meson: axg-tdm-interface: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:39:01 +0530
Message-Id: <20250203080902.1864382-20-raag.jadav@intel.com>
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
 sound/soc/meson/axg-tdm-interface.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 09103eef2a97..20f06b9ccd57 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -529,7 +529,6 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct snd_soc_dai_driver *dai_drv;
 	struct axg_tdm_iface *iface;
-	int i;
 
 	iface = devm_kzalloc(dev, sizeof(*iface), GFP_KERNEL);
 	if (!iface)
@@ -541,15 +540,11 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	 * We'll change the number of channel provided by DAI stream, so dpcm
 	 * channel merge can be done properly
 	 */
-	dai_drv = devm_kcalloc(dev, ARRAY_SIZE(axg_tdm_iface_dai_drv),
-			       sizeof(*dai_drv), GFP_KERNEL);
+	dai_drv = devm_kmemdup_array(dev, axg_tdm_iface_dai_drv, ARRAY_SIZE(axg_tdm_iface_dai_drv),
+				     sizeof(*dai_drv), GFP_KERNEL);
 	if (!dai_drv)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(axg_tdm_iface_dai_drv); i++)
-		memcpy(&dai_drv[i], &axg_tdm_iface_dai_drv[i],
-		       sizeof(*dai_drv));
-
 	/* Bit clock provided on the pad */
 	iface->sclk = devm_clk_get(dev, "sclk");
 	if (IS_ERR(iface->sclk))
-- 
2.34.1


