Return-Path: <linux-iio+bounces-14879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F169CA253BE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B455A1884418
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594301FC7F0;
	Mon,  3 Feb 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYGW31Ap"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD511FAC50;
	Mon,  3 Feb 2025 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570198; cv=none; b=UG2chseDc8qwcnkmzewwVc0TVpRTSVecUJdJHaNXwCGe7MLJJV8OW0BTCxhRrylONilATaRCRGE4VNdlrZy6qLUgbCgTW7Q2mdSebpmY39NmXVfwsNp6Gm4gBkjxHPYZb4XsKIICXwldqg2xsLeSZ0FSyXjL7V4NyWkkUjCtZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570198; c=relaxed/simple;
	bh=7uxT4Yoo0myKuwyuc9y1ZwjqTCehlS9vUOOQkrr3HkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laoaheoWuCnyaqzhqeXukywMWffNQo9PNkXF2xTqhk8CD8/4kjk5u1KbxX51iy7EbAtHhi+b4h89zybthoVeQ1DBqpPzb34OfQH1BY/ciHvuLfAL0/Y+wiQFWG8XRBPkJNOicHovsecuuYas7fHAEeXCev4PS857zpHu7UFlJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYGW31Ap; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570196; x=1770106196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7uxT4Yoo0myKuwyuc9y1ZwjqTCehlS9vUOOQkrr3HkQ=;
  b=KYGW31ApzCLbHPYmJ1aUu1Ll1KqeF8gzxr7LqWKQOVtQ2K7I5dxmyVCh
   uGTTQDwEg5FJBSfkC0JhpNmLEl7R+USxRKOjSEP1VvxGX7HVtqs8XrQOb
   EEjXA8UW/wTGZPRwCe91LNgu0y4azmeg+3PxATXZPuZ8/ZdLnkgdNSuLE
   XMWQiu8BDDU0pDSWkvfrfZeq4/xKzsSgB15c5EdtIPf0NycuyBgFe8F3L
   g88+ip2Jy3zSb0AgEhZ7NPSuWIpm7MEz6Kprglo0EipG6FvQ6SQFGO1IV
   gJSA5eIRuoGbw4PgrTdJXleRi620+lsCwPR3k2OOoND6t6d4S6/3yKNVF
   Q==;
X-CSE-ConnectionGUID: QYngTFAbSI+mZ0hHAuq/Jg==
X-CSE-MsgGUID: QyTdoU4ZS6aqt8DPW+CoPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654171"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654171"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:55 -0800
X-CSE-ConnectionGUID: pQetALQ/SPqdscMURHTn5Q==
X-CSE-MsgGUID: IbN/5bJBT/Ky6e9s3At3xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788550"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:44 -0800
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
Subject: [PATCH v3 09/20] input: sparse-keymap: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:51 +0530
Message-Id: <20250203080902.1864382-10-raag.jadav@intel.com>
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
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/sparse-keymap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index 25bf8be6e711..5ec3b9ebcac5 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -176,8 +176,7 @@ int sparse_keymap_setup(struct input_dev *dev,
 	for (e = keymap; e->type != KE_END; e++)
 		map_size++;
 
-	map = devm_kmemdup(&dev->dev, keymap, map_size * sizeof(*map),
-			   GFP_KERNEL);
+	map = devm_kmemdup_array(&dev->dev, keymap, map_size, sizeof(*map), GFP_KERNEL);
 	if (!map)
 		return -ENOMEM;
 
-- 
2.34.1


