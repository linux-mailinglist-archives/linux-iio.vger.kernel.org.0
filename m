Return-Path: <linux-iio+bounces-15232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88736A2E487
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECF418865F6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A11C1AB6;
	Mon, 10 Feb 2025 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATb9DlaK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56A1B4154;
	Mon, 10 Feb 2025 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170217; cv=none; b=keNcQEVt36nHYaoJKM9+VsD4paNA8WVwfD9Rlml6KjVIbmLB9QYdN0LekKO5h3TnXND3zki8WSpHR1hFv3APS4j8RwOF6KAp5BoZeqZkno4SgeDbG9+4+X6+BV46TiemG0/gZx8EzEz1Yubyg5hXQgSiEXs7CLPYHBt0yZMhUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170217; c=relaxed/simple;
	bh=tKd11dX8so6573A0u2H006iFssbu+bQR5O6pj8pFlEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6iOkfqvENQ491OYgABZEGSQVRbSM8JP6HcratH+6ytyABL581fP33iAabvn6HWc4J4mQeVgSKib2Ta2wPK8vn84DzAfTYafNGV/mCcM8kkTCa6xi/FwxB7cbvoFq4Fo9WTLYLfBxb+jwUamj/iRCukfSxT+PbAoNi13H16QxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATb9DlaK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170216; x=1770706216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tKd11dX8so6573A0u2H006iFssbu+bQR5O6pj8pFlEg=;
  b=ATb9DlaKa4KTXKL/JjLODIh79KgDK3/5PNV+0dGYjTeqlXHCGJR3l+83
   CnNkw1zK6Q4czxvJ45YNGp0uQ9TB5Z5UeLbxSVe1KfUYig3oG/zeGQB05
   WKjGLmUbMeRVpnpcHgKB9gFcxjhUZUFuiWxXVw9Sc03C75VbNMtyXEAyx
   jZXK8NY1c6RkekGEeRsU3gGjrfu7SXDE+D3svix9zkfO1sVpODuIFFrVk
   Wgr6TTngewPFxSGEAnTlpIqf1pvDnrVfUvyBnhaF4zPORzUyD/UcYSY6t
   d8/xoFjuQAFisi1LVjl8felQllf7/Yn5/K7CM3XXv4YldaVttLf8rVJ5Q
   w==;
X-CSE-ConnectionGUID: LT42vljPTMW7iFQKO48WSg==
X-CSE-MsgGUID: jVr7uYHSQQKg6wdCsXgkHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499384"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499384"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:50:16 -0800
X-CSE-ConnectionGUID: Vh02E8mWTReXwU4lxesNiw==
X-CSE-MsgGUID: QQMNnGisQpWxQd0CTZU/ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122559"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:50:10 -0800
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
Subject: [PATCH v4 10/20] input: ipaq-micro-keys: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:56 +0530
Message-Id: <20250210064906.2181867-11-raag.jadav@intel.com>
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


