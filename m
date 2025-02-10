Return-Path: <linux-iio+bounces-15231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F377FA2E482
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F69A18862BA
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9D1C07D8;
	Mon, 10 Feb 2025 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnwQl3P8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362751BEF7A;
	Mon, 10 Feb 2025 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170211; cv=none; b=Ib1BzgCV8yc8qEINRocE8crhzEFXaf+468cc6QAn8rtU4xgTX6tsqGK0ngEB2eUqOuKtEJj2d473YUhx90O8H7wFIWLJTEvQjRUbeSfn/KpNfD4dpnCiwcyu+bwvEDB7dGbSkb6GyVp8G9cdpLWSl5qIqvE74EF5WPhbDdzemtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170211; c=relaxed/simple;
	bh=lUStIRYPZjB0P64Z7kGwVsTZ33TcqKuazW93nUPcXMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0SpMbCSfhskv2qcKRaHJ0JbiH3UFJSBhGHu3KRxjDbVtdNJoomYiId+/G3Hu7X92CwYL5amfelaB7jIVruKyzZFSToPanmn0Jx3gSYYgg5OTvCnp4g59/ANjFhvIgag2PZSx/RIKZwJF2abL1LpxcbcDgYavyW2tvNJn6wDyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnwQl3P8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170211; x=1770706211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUStIRYPZjB0P64Z7kGwVsTZ33TcqKuazW93nUPcXMw=;
  b=JnwQl3P8w4dL4B6DOa4v2TJ4jbvwKFqzMrlmmgEzW/ZzAO3ehpKYEnsm
   ywm7bfpnEOK8gpMQ75RZUw9yPu818f1lUz4/NVpvihEKOZcHARWDto102
   WENpio9cFUOH1dsLs40MACk4gVTdKAoLl8KHT2cm0qKPDYCiPZERCNMHH
   oCMHsINUEX4ePmrBSbEdoVmP8tnMSbM5/SZgkxEeOmrmbznrw443i97s6
   XXszfjtoaYhf0PZaef3tjGdOKFz7APyZeTShaIYOYa37sDEhn3QtaYUa2
   quhj4kqciiHK98Zz6s1jT+0uzfPDgXLRsBGJBlKE9VkN4pFv8W68RxbFH
   Q==;
X-CSE-ConnectionGUID: 9MwkVPX0S5a/N0fgNAs81Q==
X-CSE-MsgGUID: aGq+w9F8QGGntubOLl0kTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499372"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499372"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:50:10 -0800
X-CSE-ConnectionGUID: n8ubXwU7Ruu8sRoHRXIrXA==
X-CSE-MsgGUID: MP/WNh3lQEeAr1TazIWQKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122545"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:50:05 -0800
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
Subject: [PATCH v4 09/20] input: sparse-keymap: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:55 +0530
Message-Id: <20250210064906.2181867-10-raag.jadav@intel.com>
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
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/sparse-keymap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index 25bf8be6e711..96f23ae57d5a 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -176,8 +176,7 @@ int sparse_keymap_setup(struct input_dev *dev,
 	for (e = keymap; e->type != KE_END; e++)
 		map_size++;
 
-	map = devm_kmemdup(&dev->dev, keymap, map_size * sizeof(*map),
-			   GFP_KERNEL);
+	map = devm_kmemdup_array(&dev->dev, keymap, map_size, sizeof(*keymap), GFP_KERNEL);
 	if (!map)
 		return -ENOMEM;
 
-- 
2.34.1


