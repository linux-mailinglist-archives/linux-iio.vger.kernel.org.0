Return-Path: <linux-iio+bounces-15229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBDDA2E479
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039E1188735B
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B31BD9D5;
	Mon, 10 Feb 2025 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QahnAxoh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B71922F5;
	Mon, 10 Feb 2025 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170200; cv=none; b=fIcgy4gNxsc/teEgS8+G7m1AXze+W6+CPcPzjbnH/9OtWUEMI4jOZgVg2MHvcubEVxhGbGDMimwnz60t648LrCGh/OspHuZFBIRQX4EchIbLp5BPFjK45EffbiQIi4zx5hwMOE+tKLiBSczx7LtPBGMlDnsAXYBrJ0Wlk/cuI2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170200; c=relaxed/simple;
	bh=i0Vg6izha13aWDeJ5vn8MBrolGY/TSxc4KHdVaVAYEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqzYpVFaE1l28konr1PtPRA/Jf43O2thUEk+xjblKIGKn/zW6xh0BsEIsZttDMJfOb6MWZsE2iErd+E6ZWielAOoRMS/yCw3aheNtk0IVT+zvatffuOuoyNbV7I2b2GOrB+hjKaCQbksn2fXemm2yRKDRk+XwFfVgiIpfOn4ReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QahnAxoh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170200; x=1770706200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i0Vg6izha13aWDeJ5vn8MBrolGY/TSxc4KHdVaVAYEk=;
  b=QahnAxohRD7lRhf7YS+1w/eZQD7NIPDclfZ9GNzyOD9bFc/+yzrC2AKx
   OijIIJ9j+LQkxFsqIYGiC0PTHbG3hpyhZWwXu4+ZetXHqf9d3vo9uIE+g
   AA7pUg+nycHoIKCsoiQPDeQozZoVLot40JG0JxImk2IIMkzH8jYuYsYdL
   4fFNB7DkUJaIRJbPhYpZPagfmwtUlNDTc64NK0tbyn8uMRLGYC3EBRL3r
   qYSceyDOpDxJ4+FgPzSPH8Ae+ze8IRRUYSpy8CENuTSfp4+K85RxkSQcZ
   /9pu+hcMGcj5d4dff80zXt+K1/2rboVJDzZV9uekLj/6Am+47Srd0vXV1
   w==;
X-CSE-ConnectionGUID: M0fvyJC+Sfy8tjloTl3jqA==
X-CSE-MsgGUID: olRUnz+PTn+30XDzbO1IEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499350"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499350"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:50:00 -0800
X-CSE-ConnectionGUID: E+ROVhLtTI+VrnN5ZC0aug==
X-CSE-MsgGUID: vO2An57dRFyXBQ64iPr2sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122462"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:49:54 -0800
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
Subject: [PATCH v4 07/20] pinctrl: tangier: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:53 +0530
Message-Id: <20250210064906.2181867-8-raag.jadav@intel.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/intel/pinctrl-tangier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
index d3baf0f4eea0..ac61e632b487 100644
--- a/drivers/pinctrl/intel/pinctrl-tangier.c
+++ b/drivers/pinctrl/intel/pinctrl-tangier.c
@@ -524,7 +524,6 @@ static int tng_pinctrl_probe(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct tng_family *families;
 	struct tng_pinctrl *tp;
-	size_t families_len;
 	void __iomem *regs;
 	unsigned int i;
 
@@ -543,8 +542,8 @@ static int tng_pinctrl_probe(struct platform_device *pdev,
 	 * Make a copy of the families which we can use to hold pointers
 	 * to the registers.
 	 */
-	families_len = size_mul(sizeof(*families), tp->nfamilies);
-	families = devm_kmemdup(dev, tp->families, families_len, GFP_KERNEL);
+	families = devm_kmemdup_array(dev, tp->families, tp->nfamilies,
+				      sizeof(*tp->families), GFP_KERNEL);
 	if (!families)
 		return -ENOMEM;
 
-- 
2.34.1


