Return-Path: <linux-iio+bounces-9100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F1296AA22
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 23:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34411F25B04
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F791922D3;
	Tue,  3 Sep 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9dCvAk1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8FE13DB92;
	Tue,  3 Sep 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398975; cv=none; b=B6AfeVVcgAi0NZqnc7YZYcIfpmI1PrnO3+If1MagYqL2iEQy5TOA9wIbZzh+svQ1YbU1bWxaKZ+rqfsT6l5VlQVmXXyV78IWvwx5K1IAQhlklyzKMB7cbk4Um5U4G2fML2jgo2DqIuLS2NR1W4gLIqyQO13j8z/EZARXievG25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398975; c=relaxed/simple;
	bh=RzBWo5I47sYPIU+Mwh9SA+bbgDpT7ljQ4ejQ2FXfWLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGaUKeTlrhDgxXeoLl+6zh68yRBnq0xqVrGj7Cqb5VZQJ3bwTkufPRq/A2DX+ljtZr6bLjs1Y+xnRPauXA6iYzI7EnG0nn5udhcL5CUhfrnod3BcVThuY4aaX0zCXx8myiZTRqm4A48MCTKNMF5Y3FlwcI20gB5e9UvnJ+3sYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9dCvAk1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725398974; x=1756934974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RzBWo5I47sYPIU+Mwh9SA+bbgDpT7ljQ4ejQ2FXfWLE=;
  b=M9dCvAk164yHh32Y0K/zek2zqGV6RJW1VZSsOzQbguH5fngtnyFJggTN
   xNYM+wnx7qDV7st2zf3O1xTedq639lI4vc/b7zWDa1RpIuF5io6iOSuf2
   OeqZnzboBatbOGFDRoRvxRNCCpe1qZJHr1Qn4srqM3Vl0+XwNaYuLSunU
   vUTdsdHz+hrNGwPcFAAzBjGYutZcoXk3saYLxaYf27NdS8RzMtGxP8Lkl
   Q/mh4eeWNgKwW/QA1OpkVoc228hJfOcnHpl+SN55EJI0OwfzX/LQWRbxW
   ksuna85SFFyLcYdgsnpE41InGdTBfBfFLZ9F/sPOG2rclAtsCP2EQt9PQ
   A==;
X-CSE-ConnectionGUID: /lAQ3/jES/OrPyXTgKDI9w==
X-CSE-MsgGUID: WlBxq9G+T7ej5IWlKizCYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="46554422"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="46554422"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 14:29:34 -0700
X-CSE-ConnectionGUID: YeeJv4UYSji2B4ua+Gsflw==
X-CSE-MsgGUID: KrWvWV/RQBy7cpBOkeNfzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="95781598"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 Sep 2024 14:29:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1D09B3C1; Wed, 04 Sep 2024 00:29:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/3] iio: imu: fxos8700: Drop unused acpi.h
Date: Wed,  4 Sep 2024 00:28:20 +0300
Message-ID: <20240903212922.3731221-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240903212922.3731221-1-andriy.shevchenko@linux.intel.com>
References: <20240903212922.3731221-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are drivers that do not need acpi.h, drop unused inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/fxos8700_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 6d189c4b9ff9..281ebfd9c15a 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -8,7 +8,6 @@
  */
 #include <linux/module.h>
 #include <linux/regmap.h>
-#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


