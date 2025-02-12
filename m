Return-Path: <linux-iio+bounces-15405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5D7A31EDD
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E4B18898B0
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5E7202C22;
	Wed, 12 Feb 2025 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFizWxMM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D624F20126C;
	Wed, 12 Feb 2025 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341565; cv=none; b=LZOyR/fKILv6Y79px0pCrPoTZObE90aEERyZV39deNNV+/TKOUjRyU29ODYN7YaIrAXX2k9G1j2eUEbt1tKvxxcAv8JVyPZSjJwJJtJwSKJv3jsfkFAwBekQ+uRWHo0pb6amrlXp3rsuz55DOaGHlGZ8sWiAdzZW7HFeAL/YRdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341565; c=relaxed/simple;
	bh=lUStIRYPZjB0P64Z7kGwVsTZ33TcqKuazW93nUPcXMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6nfutxrAiqfPPYro0x/UXmBH0XdBKbOwyQG9RrBx/VkPRqxPwr5mZAFChnKAy2MkFRDXCdoslN0x9KIkDjPBrr8ia7WNBF4HYE3CSbdIPTWrcH3NjtWW48Ms5sv9mSeQtvR1oE5Xnr9SgwGjJdKW+Negko02PQiOq9lRgWbcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFizWxMM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341564; x=1770877564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lUStIRYPZjB0P64Z7kGwVsTZ33TcqKuazW93nUPcXMw=;
  b=QFizWxMMV/eVZbM0cJ86fZjTCvj94P3h22ROgJjTg86o6Bww2WVLq1Wx
   5+SJOfORk9Ocshb3COYgdGqWJPpaKqsH3+FDMrkedruajGA7FwA/YAHKa
   P0n9LgUgEiXbet54d0ttWqibuWn75bKOh9DJseKqlfRrB2gqxpE/U8qcq
   uPBH2fTI40EPhFbFYNXZYjFYVkqOzMgL4wjAwOnCGAih7YQyvv0gVU+Fl
   YNG67UI3zeIZ4MFG2EocYU14lSjcSxnmKZfclEN8GmwEMxeqaajjXPMuL
   CiieQP2yLlDd4x2V904W1uZLJv2Jt2Wlnf9dKkbA3MMnd06jpsayup+g2
   A==;
X-CSE-ConnectionGUID: TqfdWQtFTN6Ihe1vUDFYdw==
X-CSE-MsgGUID: ZqOCNMNHQgyLfdzj7Yweug==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005243"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005243"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:26:03 -0800
X-CSE-ConnectionGUID: mpSuVEjIT2S0ZZ56e5vkaQ==
X-CSE-MsgGUID: p3javzktQbePDcr8SCvusA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117812205"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:26:00 -0800
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
Subject: [PATCH v5 11/12] input: sparse-keymap: use devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:12 +0530
Message-Id: <20250212062513.2254767-12-raag.jadav@intel.com>
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


