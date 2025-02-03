Return-Path: <linux-iio+bounces-14883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0380AA253D3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D6B164317
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDDD20B815;
	Mon,  3 Feb 2025 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1RocNKW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A97E1FCFD8;
	Mon,  3 Feb 2025 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570215; cv=none; b=I2tQX/O1lZdCq2/TT39HvkQEZ42/D0SMq6bFqIgVZxMAEmWLvEBTe7RBo4wGViXCJgMWuTGQnlxpelC+2J63/5Y77lc6pQ9vlVC4JJdHLrK152UVQrXVKfD5gPxXW5x5cfKFgxpR7uhZNpNkdtuvTyBBjwy2PeI8sSfbD72CPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570215; c=relaxed/simple;
	bh=WQcQgwN6rj0CXjCqPcouJGQfDiiFhGzfaeRKYbGINW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUikM3W7o+LcvhWbO6ODlaPDUBERgH4cnDgnYER+wryrkVsN/z3yWyF36ONncmglpItmzPG3gHwImumHFH17DNQp0IzQnbDjS5zsNB+2GPXepfMQs3XVLOweSfCh56vGO53BzkjxZMRGQJtpzY5vMJlhJi9clmIrlbk+TFX3JYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1RocNKW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570213; x=1770106213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQcQgwN6rj0CXjCqPcouJGQfDiiFhGzfaeRKYbGINW0=;
  b=Y1RocNKWL/YBE7+e/H0V99OCfNNFwz9v+GTX8XrrNCsbcvNVY3crLMgb
   o2xhnnVTtVx7JKhzXeiNj5Heg8LpvXIgntxC+7l7qQ9THXiufQXtR1+6x
   SAz3S+MO7Udun96WzGBo3gsvohbklBpDtSP1AtQ4I2ZUOZMwmOt9+LNqt
   egPJvwxRti4Jn4OTiOC2gRiFlwk5Sg68VZy/cva/ZGHpXuftAci2G5XCG
   YUR0+E0GqisqCfN0d5e4c/QjThs2dMIFcq5C4oxi94X1LV+l/bt9igIwn
   21HjGL4LCPfWREDpPcVfCZKK869mrfKXPOWl23NMmaUQoKprShPIX9Ee8
   A==;
X-CSE-ConnectionGUID: FlqVa9uzSZu0TjoaUx7Ctw==
X-CSE-MsgGUID: l+yyhYaBSB2IKEtgK8VB5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654204"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:10:13 -0800
X-CSE-ConnectionGUID: BkLsN70KQ1yOZhatgkHeVg==
X-CSE-MsgGUID: mtsBWcUhRnO8ruUkXDwpTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788736"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:10:08 -0800
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
Subject: [PATCH v3 13/20] power: supply: sc27xx: use devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:55 +0530
Message-Id: <20250203080902.1864382-14-raag.jadav@intel.com>
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
 drivers/power/supply/sc27xx_fuel_gauge.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index f36edc2ba708..573838ca8ed8 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1014,9 +1014,8 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 	if (!table)
 		return -EINVAL;
 
-	data->cap_table = devm_kmemdup(data->dev, table,
-				       data->table_len * sizeof(*table),
-				       GFP_KERNEL);
+	data->cap_table = devm_kmemdup_array(data->dev, table, data->table_len,
+					     sizeof(*table), GFP_KERNEL);
 	if (!data->cap_table) {
 		power_supply_put_battery_info(data->battery, info);
 		return -ENOMEM;
-- 
2.34.1


