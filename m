Return-Path: <linux-iio+bounces-14881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D1A253C9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425B21884F39
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4832080E2;
	Mon,  3 Feb 2025 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfvLJ4Ly"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C582080C1;
	Mon,  3 Feb 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570202; cv=none; b=LrDepaIIwdM4Jh6pC2plitJX79n/b35/OmLErsbewGfrwudm9HLVft10sx3xE4M9jza2AVfIz41itPCvTIDu5k0/7CTJ8ozwoVAt1GCoIHYn4ChoquSSRoDPgh2EGoJvau+vlHdWNwSnZRAv54T+pfe3Nro8/i6mPNFbgns5+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570202; c=relaxed/simple;
	bh=A43sWN4sdLq3tQc+IB25Ps/3Ig8snwsi8Gmk90X6cpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bd36PQJFW8LSWJlP4wfANUweaJmljXyKvoCu20rFglcHYTbKwfsdpHpGLeK92FhjD6ptQysat7Vm+j7fxY7BIjbe5P6dXQzjAcRl25KuWAVQwUrNOM6ZlYXePIjsA5uWUYMPaWqdNKwlwHeLxYLWD4X6tUM91pYzy7hUGw00Yhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfvLJ4Ly; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570201; x=1770106201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A43sWN4sdLq3tQc+IB25Ps/3Ig8snwsi8Gmk90X6cpQ=;
  b=HfvLJ4Ly+13faZF/j2S7yUjLqODi1LYOvq6/8s4EmNDyUNnAp8UE8hcQ
   Sco8SeZ0M/5CPPPRP7kLA3Hqmi05GgrzYHC2++RX/PJLa04ziCOCsINwz
   8Rvphouc6AAC0FKH3wcDjcpP6i3+M3shOZeBvLnybKTrJCIdWJjvBXcgD
   wzcEqXuLD+PYHQppdTi820Djmf4okYgFDHOg39E55Htudakky1fVGGP/m
   IqDCeOhq2lRnG6jWs3gJv2cBHQ5tD7uDaJFuTHg+WapZA8IaovUN3Jlz/
   7Lh0RYGwQ4wmupWaF0aFThZ2KKiBEgGgmLEZ5mdTs/bBBKvUGgzPah0nd
   Q==;
X-CSE-ConnectionGUID: eK8NulWzTsq+uKZGmWmfRg==
X-CSE-MsgGUID: u1Md70b3TJeIv6rnKit4Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654187"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654187"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:01 -0800
X-CSE-ConnectionGUID: mgw6WQaRQCCybSnMnArnPw==
X-CSE-MsgGUID: SixG5aROQMeDwDQFY+/oYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788595"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:57 -0800
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
Subject: [PATCH v3 11/20] regulator: devres: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:53 +0530
Message-Id: <20250203080902.1864382-12-raag.jadav@intel.com>
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
 drivers/regulator/devres.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 36164aec30e8..ab238579879c 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -332,9 +332,8 @@ int devm_regulator_bulk_get_const(struct device *dev, int num_consumers,
 				  const struct regulator_bulk_data *in_consumers,
 				  struct regulator_bulk_data **out_consumers)
 {
-	*out_consumers = devm_kmemdup(dev, in_consumers,
-				      num_consumers * sizeof(*in_consumers),
-				      GFP_KERNEL);
+	*out_consumers = devm_kmemdup_array(dev, in_consumers, num_consumers,
+					    sizeof(*in_consumers), GFP_KERNEL);
 	if (*out_consumers == NULL)
 		return -ENOMEM;
 
-- 
2.34.1


