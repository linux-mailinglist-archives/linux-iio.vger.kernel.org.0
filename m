Return-Path: <linux-iio+bounces-15406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA3A31EE1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74E9188945B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725D3202C46;
	Wed, 12 Feb 2025 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W88bWC5J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B11FECA5;
	Wed, 12 Feb 2025 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341569; cv=none; b=WVjWEqEtgxkkzetC3H0C1eHUqvDsgAZxYLYez7NXvFZzOE6idv9pCgFlW9hR8dUDrP4QjkE4mlQe20bh2LzeaeBYxZAG+CVtGDYRNA4GwJFgfxdxUUzDmR6w096UpMc8BdWOQmgZpJrbJs5Etp294JtMqnehNgQ1arUGs5fNJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341569; c=relaxed/simple;
	bh=tKd11dX8so6573A0u2H006iFssbu+bQR5O6pj8pFlEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=heh0/jHwjpd/xya0FLqCCQJJ7XyhjDd7hN39CS/SCG0bHNoagHE8a41kWPEqxLBSaDIFOJATaZparH89sxW6ZS+wZMRaeVqs1hJjnLy3isx9nafyB67gti2wDEHib6f67p/tsMnB1VbqO0/E96VkOVRQamSsTlLgYon0K7aUoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W88bWC5J; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341568; x=1770877568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tKd11dX8so6573A0u2H006iFssbu+bQR5O6pj8pFlEg=;
  b=W88bWC5JkSl8VoVgMwOp5b6XKKJsnrTgXA+C43D/o7jJxkazNB/1qnYL
   ejwiFXoX+AiiVMP9+uO2rC2ypognyK4ux5Ynj+GlhZZp/5X4cJllCP00K
   UsvKbSAk5oTQEALVnkErJWvTSQ6e9XdW8zlk2jmXR41dFCN/lXMtD/gw2
   vnLfL0LdqL+yhcANLy6guxOQ0y5D1S3dPh6LujiYUx+HwD5Lji2nQ3zh1
   axN1Ayjwe0QetpXFcQEXxHl4xiUGczOtcMc854e1H/0c+vR4EECsS9g/d
   NseKjPhDaFABfBot3Q7CSVe6WMWfe437ypcSo0hrZs1VGd6k933wyzM6z
   g==;
X-CSE-ConnectionGUID: 2O4CXHSZS9u6vAAIbfAyKw==
X-CSE-MsgGUID: ArXUJoUpTmOLIfJEeSfOkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005252"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005252"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:26:07 -0800
X-CSE-ConnectionGUID: 8ds+cfntTI+MByDkEBXUiw==
X-CSE-MsgGUID: R4/vkoXzSPaZDNne193kjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117812235"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:26:04 -0800
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
Subject: [PATCH v5 12/12] input: ipaq-micro-keys: use devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:13 +0530
Message-Id: <20250212062513.2254767-13-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/keyboard/ipaq-micro-keys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index 58631bf7ce55..ca7ec054b1ce 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -102,9 +102,8 @@ static int micro_key_probe(struct platform_device *pdev)
 
 	keys->input->keycodesize = sizeof(micro_keycodes[0]);
 	keys->input->keycodemax = ARRAY_SIZE(micro_keycodes);
-	keys->codes = devm_kmemdup(&pdev->dev, micro_keycodes,
-			   keys->input->keycodesize * keys->input->keycodemax,
-			   GFP_KERNEL);
+	keys->codes = devm_kmemdup_array(&pdev->dev, micro_keycodes, keys->input->keycodemax,
+					 keys->input->keycodesize, GFP_KERNEL);
 	if (!keys->codes)
 		return -ENOMEM;
 
-- 
2.34.1


