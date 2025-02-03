Return-Path: <linux-iio+bounces-14882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B722CA253CD
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90268164482
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA340208973;
	Mon,  3 Feb 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmdgYWXv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9891FBEA8;
	Mon,  3 Feb 2025 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570208; cv=none; b=WNUwci88mAT9dM2tMPK7SCoc1BNRWtXzRwClhvfRssAeTilh2+Y4SVCNh0XCPuj1WJC8qT5eBtEyEEr63Lr4IRhryqwEXeH+eBb66m9+V5WXDXs257Jlmi+tw5Y05JNTySZ0WSYUZpSCi0cL6JaLHLwPDzYRalsduqjvi4QbJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570208; c=relaxed/simple;
	bh=OSRsss3tuKD3vY5WfVuTCN2y3tWF8dN0xNckRSATDeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QLYa13NIhPvfjf5XqnRItq8hCaN7N8Pq3ZKOXwQuXfhCfya23tUwhJt/9SWwLhbhngYQhYpSJCk1PI54sEgiXq9ntMfobb2psgRkK7qBhIMrafNlaN8TxguusQ15n93iviFHOJuszgi06gSBkOOp3xI6WKgVzHeqOms68UuO0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmdgYWXv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570207; x=1770106207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OSRsss3tuKD3vY5WfVuTCN2y3tWF8dN0xNckRSATDeY=;
  b=MmdgYWXvKz7Gqmdj33s5E/UOeliycRmx5jjPoVNTwwGDv00WKDsrbUcP
   JiAzXfcsoC/a9epBunlbpRbNG2YQzgXDetbcMTYsguw73WGwFA1MoZaYA
   kPh+NzDoKS/nnh+yOXoZTekD3Hrfvt4SBCv55TZ+NxoFzrMCF9DjrFZxu
   iJ5ZAnQ0CYbRXvEjLTDIqgcHz89d07Nr+NvvFLYUTc5PgDTBb1Dzxvk4D
   uBSmyNcuHyFFu60rMvvMxxw5RQtG01JHtmzLsBO4AkOoSYdprU4/UaDDL
   7fEtatYLFKnI3qloK3C8FOWfhSsZh0nIYNhX+dbbr6/W8LhwYz9kryPsA
   w==;
X-CSE-ConnectionGUID: +maf17xuSfOtU+SA5DdTGw==
X-CSE-MsgGUID: g5PGKa3USS+FB+egbUDhuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654195"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654195"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:06 -0800
X-CSE-ConnectionGUID: kf+CO4YORgC+fx4/crpfmA==
X-CSE-MsgGUID: 9TfkrXC0TkaC5/Pvt7lt8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788656"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:10:02 -0800
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
Subject: [PATCH v3 12/20] regulator: cros-ec: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:54 +0530
Message-Id: <20250203080902.1864382-13-raag.jadav@intel.com>
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
 drivers/regulator/cros-ec-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index fb9643ed7a49..38afd4b3d2d0 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -138,8 +138,8 @@ static int cros_ec_regulator_init_info(struct device *dev,
 	data->num_voltages =
 		min_t(u16, ARRAY_SIZE(resp.voltages_mv), resp.num_voltages);
 	data->voltages_mV =
-		devm_kmemdup(dev, resp.voltages_mv,
-			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
+		devm_kmemdup_array(dev, resp.voltages_mv, data->num_voltages,
+				   sizeof(u16), GFP_KERNEL);
 	if (!data->voltages_mV)
 		return -ENOMEM;
 
-- 
2.34.1


