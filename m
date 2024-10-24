Return-Path: <linux-iio+bounces-11115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2D9AE5A2
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690041F24AFE
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85D1E282B;
	Thu, 24 Oct 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhKEEb/O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07991E2607;
	Thu, 24 Oct 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775089; cv=none; b=aB0siWR9soJymbzz2sb4pEgo1p6mKrF4R5eadUyt/wtHhRG13WKFCsd1bFMEMH8/hdBk6P/PY74Yfwb1gv9wj4wvRe5cI0T2fWZvSoE4QWAcmZZrcrYFBxnjqqcVCAHQNYj1o2QiC4qgZPsmdmWLEob+bAjLguR+ImMOGN6bW0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775089; c=relaxed/simple;
	bh=Iocz/KVSforp7TWPBNMBSymCJu2I9Wm9f+hSS1P8ifo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ6jcDw0EAAEmC+gzAyDgzWk4jHcZGhq5CBWQJfpmAbGHZXLwY5Dkd0JE+pCUP/xdpJBiumKdu8g9uR5heUpynwOkxKyspkRu1vDhrjEnESrNIGmF9FOsxqnIB01J645+aseihTGIxsp20O+Kfj4+SC0zQzBMYj8f6WAooNMOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhKEEb/O; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775088; x=1761311088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iocz/KVSforp7TWPBNMBSymCJu2I9Wm9f+hSS1P8ifo=;
  b=XhKEEb/OKhJlXIk5TONg6tXy1RKBakaWX+AbL5nFq9x9ocgznTUWM/1m
   iwV8KjA9PL4g3H2uFqV+OWa9/jJVXzFM2Y5y7SnI3aq/MYeH/MeIhNX5n
   rI7wny2x2ybeTA1QyaJpcEsmcGcvJYM7GxaYUvRMXYf7H2eVNQ4bwxSWl
   BzmROSLCrXhsI2P5ZPEjAX/AV/0jXxsWIt0aUxdPEjhePyp8dHIyLou5a
   pKW7/kt3A0T/iOWCZB+uT4MAn5xEwdON4EE2CYWmlrKQMm/ACbYf8Xd3S
   wp4kaQb0HMV7jR7v5SPZ73npu/UByVm+eYIaocDgo75BimMEEYIDqYyu4
   w==;
X-CSE-ConnectionGUID: vzoKtPQtSZGsQRQ82bA+Ig==
X-CSE-MsgGUID: AmDt5GFfT6u3PC8ks4y2tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54802845"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54802845"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:32 -0700
X-CSE-ConnectionGUID: q+4u1cDQSUOIZnIxYHooQw==
X-CSE-MsgGUID: 4qxAxZ1VQGic+Vojf1ToVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80238794"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 06:04:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 355FA386; Thu, 24 Oct 2024 16:04:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 11/13] iio: light: ltr501: Drop most likely fake ACPI IDs
Date: Thu, 24 Oct 2024 15:36:16 +0300
Message-ID: <20241024130424.3818291-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
References: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commits in question do not proove that ACPI IDs exist.
Quite likely it was a cargo cult addition while doing that
for DT-based enumeration. Drop most likely fake ACPI IDs.

The to be removed IDs has been checked against the following resources:
1) DuckDuckGo
2) Google
3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
This gives no useful results in regard to DSDT, moreover, the official
vendor ID in the registry for Lite-On is LCI.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 8c516ede9116..3fff5d58ba3c 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1610,8 +1610,6 @@ static int ltr501_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
-	{ "LTER0501", ltr501 },
-	{ "LTER0559", ltr559 },
 	{ "LTER0301", ltr301 },
 	{ },
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


