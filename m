Return-Path: <linux-iio+bounces-14872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBBA2539C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA45C16419E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45251FBC81;
	Mon,  3 Feb 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/ua2YaU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D611FAC56;
	Mon,  3 Feb 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570152; cv=none; b=bNVQXgyMXCl3eZs0FH+DoCaZa9EeVBrD275nGerb4zXLZFPnui8ajilvgdKHalx+iV2glySUaRmtakClJgZogZGGdEbdZ13YmFEnFW5ERidb/HWRLnBROlq9GcSlkTMRCf01yJBM/m6lEGnQ8EAiBALTV8b+j/gGlmxjGnKzWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570152; c=relaxed/simple;
	bh=kLaQvzOlZ+lmcT+S3jNKV3UnNVEkf0Le78yG58ks7iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RaaZslcjbZBIAxWhKjoa+L8/ribCoEiitLk2KYjzl58VwoWuHXPpwhPRRv634Tpi24Oxrt303WFSLRdu7A2AcAM7ELM7f6BoMApY7i84sxsVW+xCCNBdq1XkVDHhobldygFIWdL7bpnD0k6rkmF/3aSlPYzC2KXWpQxjJ3WjpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/ua2YaU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570151; x=1770106151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLaQvzOlZ+lmcT+S3jNKV3UnNVEkf0Le78yG58ks7iY=;
  b=N/ua2YaUVQLrW7M+BcW6JdiQf8H4L/mkefrilNg++1nCdjILjKl9q9Hc
   iN1MuOgRk5eXe4Lunrw7zlklOFVwxFz/tQf/MgEqzsNyowAoC3JyvRzOL
   1yyyyTOIj20/Cwvgts+aR4K+7z+9K+07gRd/DBSDWxVqacWajRWK1SQH3
   UWpXO7/YIF5mBlE4A5Ngij/feX03FZgVThQ27JAD+1VsB10KnLduYtJah
   HUQztgXlJZP7ZsrEVd9i17RnHNZt4VDCLFbi4psKwHH4zwBBu8ZaHzRRe
   ZuvVgZ4xX03BtI0UieOoZdePQ7N2yXBRlTU9hviyfBlzBs4iGqwhDroPf
   A==;
X-CSE-ConnectionGUID: u0s1SWwWRRCoXwB5RSgy5A==
X-CSE-MsgGUID: i+M+tzm0RdajVxqko2lbIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654085"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654085"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:09:10 -0800
X-CSE-ConnectionGUID: CBm8TWneRYSwMRt64QjlCw==
X-CSE-MsgGUID: O5sEIIt0Q5mOUl0qmcagcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788427"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:09:06 -0800
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
Subject: [PATCH v3 02/20] iio: imu: st_lsm9ds0: Replace device.h with what is needed
Date: Mon,  3 Feb 2025 13:38:44 +0530
Message-Id: <20250203080902.1864382-3-raag.jadav@intel.com>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of including a huge device.h with tons of dependencies
include only what driver actually uses.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 0732cfa258c4..8cc071463249 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -7,7 +7,7 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/device.h>
+#include <linux/device/devres.h>
 #include <linux/err.h>
 #include <linux/gfp_types.h>
 #include <linux/i2c.h>
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 43ec57c1e604..806e55f75f65 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -7,7 +7,7 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/device.h>
+#include <linux/device/devres.h>
 #include <linux/err.h>
 #include <linux/gfp_types.h>
 #include <linux/module.h>
-- 
2.34.1


