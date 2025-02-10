Return-Path: <linux-iio+bounces-15233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0055A2E48D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884EA165261
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89E11C2DC8;
	Mon, 10 Feb 2025 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEvA3ksp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351D1B4247;
	Mon, 10 Feb 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170222; cv=none; b=aEDdm1utF3MQ/SHFVl8fvP7Kx9Q7yWLyaTmhq3OJiShqUzxFegRZCxPNojTO4jeGDj5s86VtdDlr0E11aPS5kVj5gD//c7fMDmdEwvEwn3QpsiWspPXU5kY0VtdhoIsT2ILHAVRqYJFSxhXFMXy9R1gOsj8lf09sYoSTCCoajDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170222; c=relaxed/simple;
	bh=A43sWN4sdLq3tQc+IB25Ps/3Ig8snwsi8Gmk90X6cpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCk2y9lw6QfJ0R9RzT6GLTFUvK6VAChBi+N7eyLiq4Met1kZ9oMVwlfI/RctQcVcXNLsdIYTJJ2UHAglV/9X+9kajU8xZNfWrEk269Ka1XrOo+ulqgubc9mgL/SJsbdGHvWwYKd6Z2YEhnwlsc1Jl3rgYUvJtPSPoUHYBLHpCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEvA3ksp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170222; x=1770706222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A43sWN4sdLq3tQc+IB25Ps/3Ig8snwsi8Gmk90X6cpQ=;
  b=GEvA3kspBf/QXizartks/llrGmqgFxynuxZCcPiMmE5yjHXgGDO19rWE
   hzw7rgMgk+i5mOtJClSpgpFnI7bD8zlz54Kpl6xXjyH2gKrA3cjFZUib+
   tFdZReS0OST8Z+z805CM4sBUCrF6I+uA7fEfJh0UkkXix3jFuX2pDff+p
   r+B+2h+0PbMgW5P9GuEzH525XIDYORaQI7/vy1uqdJLmz6KlgBzVQzSWb
   oL84jr8rH9FqIqtNVb1Q2jPDpJCKkKTBH3ahKRUOc4OBUfCRtyUwWy4LU
   CuYpgtqpgaIr8xZu13rT088ZhXpshzsD3VhKQaM/3S9Kv18OkZRp9CfO4
   A==;
X-CSE-ConnectionGUID: E710izjbSq2yHzYLYoT06g==
X-CSE-MsgGUID: LNaOf3RiRJKcaFBTvuY2Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499391"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499391"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:50:21 -0800
X-CSE-ConnectionGUID: Lg6IrC95Tp6+J/HKNqFazA==
X-CSE-MsgGUID: 00l51m7rSr2f6sjRR3brpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122577"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:50:16 -0800
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
Subject: [PATCH v4 11/20] regulator: devres: use devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:57 +0530
Message-Id: <20250210064906.2181867-12-raag.jadav@intel.com>
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


