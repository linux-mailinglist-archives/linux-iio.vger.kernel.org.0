Return-Path: <linux-iio+bounces-9101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E396AA24
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 23:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E7F284D3E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF11C9DC9;
	Tue,  3 Sep 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3bTyG1q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42339197A67;
	Tue,  3 Sep 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398977; cv=none; b=Cm7jghVgrzO3YScidOewR57Lc0wH5jBJdS2QU/fb19gQeVmy4i9a9Nkln9o3DQXTJbETRDtGVg2rgvDMs6Bepn2jBJT/SV7dVQBtVmEsROUp0ZSTp9jfZelmcfXNDuHoEnByQgllaMBhfQT6nJ5g7sH3+NvEWNP4Vxy91ChgSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398977; c=relaxed/simple;
	bh=ajPdL3zT44Mb1wkT/fu2AjjJ6krZ4DWIeQlZ9MsHEkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaGtXmB8nXdEFPr3Mz1dEbXot+Tke7j1ov+ck1UXJ6m6ZrGXi0BsFudIN/OtzdEluqZ/NsFzatccd2d2FyMK/8y008QrxHI/SuItmFFdyqsfrUPCaqeqRxXYux2UaM6wKtOLYAaVfZ78eXB3vgCWHW0JKtD2mjptGYgnyv0U5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3bTyG1q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725398977; x=1756934977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ajPdL3zT44Mb1wkT/fu2AjjJ6krZ4DWIeQlZ9MsHEkQ=;
  b=h3bTyG1qPHEFn5ztzwOyvJiZbrwxyWjkPywEqnniH/k6Y4UuxfGTHxh/
   LxoCEVgD37ceNlAxTKV7FcXEA0iArcgZ9LkG0sWr0CTl5ctwBn/N9yzo9
   rh73cIWLe187VveWAr+NgMspqMB55EK0rF6bHSLQsigrEWy6oMOmmPU4z
   4ZIxqtqGTWENmiHDNz0MU52LsbKSf8V9WtPtoEgvXn1y8Gdea+Eu/HRWW
   8PXhWofJhdxqzW8tOtziTDlMBpiJZA9oEAY8rXcZMf9AXg3RYVq7auu96
   jZUk34+taMGmcpSrWnhgo5cgzOirGO2cUNDj1bXc+mh/RMatlJEK5nUeJ
   w==;
X-CSE-ConnectionGUID: 7LeeOghHTSy/YXOdAJGQug==
X-CSE-MsgGUID: VW05yyJCRXiHsqzy+NjwCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="46554428"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="46554428"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 14:29:37 -0700
X-CSE-ConnectionGUID: zq/GWJZSTFyIkkvkDuUv8g==
X-CSE-MsgGUID: 1VM+E7nQSp6WCVpvKV6FWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="95781600"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 Sep 2024 14:29:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5D6B9AF3; Wed, 04 Sep 2024 00:29:33 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 3/3] iio: proximity: sx_common: Drop unused acpi.h
Date: Wed,  4 Sep 2024 00:28:22 +0300
Message-ID: <20240903212922.3731221-4-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/proximity/sx9360.c    | 1 -
 drivers/iio/proximity/sx_common.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 2b90bf45a201..07551e0decbd 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -7,7 +7,6 @@
  * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
  */
 
-#include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 #include <linux/delay.h>
diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
index 175505eaae7b..da53268201a9 100644
--- a/drivers/iio/proximity/sx_common.h
+++ b/drivers/iio/proximity/sx_common.h
@@ -8,7 +8,6 @@
 #ifndef IIO_SX_COMMON_H
 #define IIO_SX_COMMON_H
 
-#include <linux/acpi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/regulator/consumer.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


