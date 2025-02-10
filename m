Return-Path: <linux-iio+bounces-15241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB5A2E4B6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E5E3A40F7
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE001D54FA;
	Mon, 10 Feb 2025 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SB9GMaDZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598831BBBDD;
	Mon, 10 Feb 2025 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170266; cv=none; b=W089om/0Ae4bRMhfAAdCsM8CERaTQc+yaF0tqQNeWs7RsTQXltDi1s2jMOB7WHSJQPeq4zSLUkwWMIT8cOyHn3VXKELrpDIEJ5WrKzDSUYSwjffpC/XA61oLaqPZt2wc7bmvb50s4v5fr8ErLb4T08q6g4BIco82SjUv6A9dOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170266; c=relaxed/simple;
	bh=9jklcU8zXeb2fq/kZyVr5PcF5WyfIGqHTEgky7Oh+0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=em3ZotvcRsAx07PFDE/Z++Ro81CmYzVdHheCvwbfw9slBwVakTSktxYhAqoVKI9+/ehWM84vfqBNxj8HbMI1obA55vxTIjRNX8Pytg+gRHt4auSJHyva4KVzAqnXdD64iLNeS6jM+nGqhTrTQRtiO+akYW9NQgHqrAl5elacfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SB9GMaDZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170266; x=1770706266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9jklcU8zXeb2fq/kZyVr5PcF5WyfIGqHTEgky7Oh+0o=;
  b=SB9GMaDZZm6qXtD0x4M5hii3WPAdeduVjk+ld0IzZ+ByCMTyxERub1HK
   Wy0nHmzskxLim1DVgyLQEnM0Il/11GqEoTaG4j99dVV8aG7kLoTen9ZlU
   9wiBypZjc5DGIMHl/Gj25LbHelBQ8FFl5lQZ5GCyjs1IQsrgTd/I305qJ
   7IV0Lk3MsCFPjJbWLfBXe/NvfDH7bu69VXelQ6b4W+0MOeGABzS1b8/dY
   kXXEoyl6VeEu25nOp+L+KD9y39EJcBfJEwBwHNfTrzoigjBrkO0592NkK
   Z8RMdiltf7ZW/PycTCO2XsTXIvScE09c1pnL8F+kmO5oAsPJM7A9CN1Jd
   g==;
X-CSE-ConnectionGUID: Cd7E5JIFTLGSYoPb6CObcg==
X-CSE-MsgGUID: +0k6dbxQQGimnbE0Cuq1nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499457"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499457"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:51:06 -0800
X-CSE-ConnectionGUID: oaVYRkPrS9Od603demoHJQ==
X-CSE-MsgGUID: qCLmA8brR3CZKCwycekT8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122690"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:51:00 -0800
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
Subject: [PATCH v4 19/20] ASoC: meson: axg-tdm-interface: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:19:05 +0530
Message-Id: <20250210064906.2181867-20-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 sound/soc/meson/axg-tdm-interface.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 09103eef2a97..421b5d719fb3 100644
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
+				     sizeof(axg_tdm_iface_dai_drv[0]), GFP_KERNEL);
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


