Return-Path: <linux-iio+bounces-14711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C277CA22030
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F59B3A72E6
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6C1DDC3F;
	Wed, 29 Jan 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iz2ZEPvJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910D15B102;
	Wed, 29 Jan 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164354; cv=none; b=rlELpo60MOY1VC1/aZhJ5UQjcui3J8Vw1VD6mMRBB1ub8GUHsnTzOZJtZr+uL0Ib/WZFYl4dk2fb58qYmQ1IEhbOOPGSHN4Y1/D1KPQc/kAWtGHNi4ZNAuNdr5hl2ZDCexYzY82bkbRBdqoRalJQiKU9vmIYEyMKKpvBdgkJrKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164354; c=relaxed/simple;
	bh=O1kPc7XADX4ZT5RIgx3jp8KfJErYzvWAz09wgcxVAIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDh9H+V71f11tHnjEboW3MYuM1YWjVJEwlO+KRGAx7EnX87RVoyCC1WiuyTNAtip62qqS/XeWoGitQYZ1fFXeO+czcqXkaixA4VsUsKB1LJzK+CYyktcX2C74eL08MbeCzqmqhv3oMncBYn24QzQtDPsAFfQZD7xYWEWdagt9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz2ZEPvJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738164353; x=1769700353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O1kPc7XADX4ZT5RIgx3jp8KfJErYzvWAz09wgcxVAIQ=;
  b=Iz2ZEPvJ4InZ0kaQoSDWtjAFLrLZw0Q2wTwlyI5kpl9oi9Mfg4HhNjtY
   ju8Aw65CLovZwjD6Tv3h6UVBrHawowkVlQDG7CnN+YRmOyRA8LOGVU9Q4
   65H2NuTd42MEZpu5Fo1XNMIzg0tA8XsNGnDu+eHAo86ACTULbjGkl8kHT
   obTDItuFNMh6pvJ+qpOFvCWn1CQQc6TI1Ug8Ih3BWmo5JY63DOmPHFoND
   9/sNVxmo93itlTk0ATqEPIU8hSPFUSDgsPFXVS0hh1OeS8oMJ3ZVk5bP9
   tAbdEnjYy3keH8HFLYD7uGmz8QWI2lHF5X6M2/zdSxQMkiBprbtgPqtnd
   g==;
X-CSE-ConnectionGUID: ArLwDk8/SVCM2GejV9qGhQ==
X-CSE-MsgGUID: VNTpzec+QT6N043M7kA9hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="37879628"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="37879628"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 07:25:52 -0800
X-CSE-ConnectionGUID: 1AybBBsUQNqixkKSzD6nag==
X-CSE-MsgGUID: n8r+vyy5TZqSXhsd9aexxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="114051106"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 29 Jan 2025 07:25:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 00ED453A; Wed, 29 Jan 2025 17:25:47 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Icenowy Zheng <icenowy@aosc.io>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] iio: pressure: zpa2326: Drop unneeded assignment for cache_type
Date: Wed, 29 Jan 2025 17:24:42 +0200
Message-ID: <20250129152546.1798306-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20250129152546.1798306-1-andriy.shevchenko@linux.intel.com>
References: <20250129152546.1798306-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

REGCACHE_NONE is the default type of the cache when not provided.
Drop unneeded explicit assignment to it.

Note, it's defined to 0, and if ever be redefined, it will break
literally a lot of the drivers, so it very unlikely to happen.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/zpa2326_i2c.c | 1 -
 drivers/iio/pressure/zpa2326_spi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326_i2c.c b/drivers/iio/pressure/zpa2326_i2c.c
index 49a239ebdabf..a6034bf05d97 100644
--- a/drivers/iio/pressure/zpa2326_i2c.c
+++ b/drivers/iio/pressure/zpa2326_i2c.c
@@ -25,7 +25,6 @@ static const struct regmap_config zpa2326_regmap_i2c_config = {
 	.precious_reg   = zpa2326_isreg_precious,
 	.max_register   = ZPA2326_TEMP_OUT_H_REG,
 	.read_flag_mask = BIT(7),
-	.cache_type     = REGCACHE_NONE,
 };
 
 static unsigned int zpa2326_i2c_hwid(const struct i2c_client *client)
diff --git a/drivers/iio/pressure/zpa2326_spi.c b/drivers/iio/pressure/zpa2326_spi.c
index 317270fa1c43..c678f5b96266 100644
--- a/drivers/iio/pressure/zpa2326_spi.c
+++ b/drivers/iio/pressure/zpa2326_spi.c
@@ -26,7 +26,6 @@ static const struct regmap_config zpa2326_regmap_spi_config = {
 	.precious_reg   = zpa2326_isreg_precious,
 	.max_register   = ZPA2326_TEMP_OUT_H_REG,
 	.read_flag_mask = BIT(7) | BIT(6),
-	.cache_type     = REGCACHE_NONE,
 };
 
 static int zpa2326_probe_spi(struct spi_device *spi)
-- 
2.43.0.rc1.1336.g36b5255a03ac


