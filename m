Return-Path: <linux-iio+bounces-11108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF7B9AE593
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4791C22143
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E431DD9AC;
	Thu, 24 Oct 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSZhojeL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC01D63FD;
	Thu, 24 Oct 2024 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775084; cv=none; b=umXtmZyebtC/tH55ad05R4l072MHqKrotPzC9MGet18wH/euMiQo8V5M/bSJAzG8xZQzk9P2+se0vp+fGG6udg5uwtL1bahk6y/15L56X6ubGyzmI49xgoCvAC9ZAlN6/ac3USL/OZQREBTyOzFgrrYR+mC8KbCDFrX3rBiBT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775084; c=relaxed/simple;
	bh=vsc6MrVXxXDuLAESj8xZHll4k7qRnzwifVhQvxdNI/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRPiKKXNFTdpJEHLBYnEh+bNUwIAHtJAgZ1XaFMg+G7fbQ5vFTeD1XZpW4ctkn2WbEOmeg8wqoRpfl2qMx69y4YvUw/HjWAJbWhyDwL5N3A90szBp7HGUn/ULCjOpdTQJk2kRMdMrXnRFz/yBmJNG1uIgXLXeO3QPfKMWudcMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSZhojeL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775083; x=1761311083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsc6MrVXxXDuLAESj8xZHll4k7qRnzwifVhQvxdNI/U=;
  b=KSZhojeLzy71GNMvylXgO1SDlZRoJUIWb8gCMzWWUGhJ11f+N/BR8xlV
   q2ILhmIx9W8+yimj/ZWC6KC/9hJ4J08307R2ACrL4dBhXCRSb5TP2KK6r
   WA0MWDLCT/nlD+sBvH32Pm6PQEVxyzfDWE70lsbHuctjF30ZCPuyCFIQm
   sU8Ko2+D7rOWGfPEJw/sqoJwZ/2SWDInlbCFmgiJ1CmHrEjhDlUuCCxUc
   W3Ae1SDyMXsE4ihhOR7TPXM7S6f7GRErf+KUIbfdI1Yn00crB4oWg1B8D
   TwGbsvA0upEXNUW35fvH8KHNakxaAhMtyFfESma7Fyjj8LOiOpbV7iHaG
   g==;
X-CSE-ConnectionGUID: PbwH36PLRVGFgCiAIKTvJA==
X-CSE-MsgGUID: CTWPtSNvTZiM40qqbwXRQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54802777"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54802777"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:28 -0700
X-CSE-ConnectionGUID: 2GyIuEzQSsOFNWIOEfiVVA==
X-CSE-MsgGUID: 2zWxvJNvTJyArGYN4Yx8xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80238763"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 06:04:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C06B32E9; Thu, 24 Oct 2024 16:04:24 +0300 (EEST)
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
Subject: [PATCH v2 01/13] iio: magnetometer: bmc150: Drop dead code from the driver
Date: Thu, 24 Oct 2024 15:36:06 +0300
Message-ID: <20241024130424.3818291-2-andriy.shevchenko@linux.intel.com>
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

Since there is no ACPI IDs for this driver to be served for,
drop dead ACPI bits from it completely.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 06d5a1ef1fbd..7de18c4a0ccb 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
@@ -855,17 +854,6 @@ static const struct iio_buffer_setup_ops bmc150_magn_buffer_setup_ops = {
 	.postdisable = bmc150_magn_buffer_postdisable,
 };
 
-static const char *bmc150_magn_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 		      int irq, const char *name)
 {
@@ -894,9 +882,6 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	if (!name && ACPI_HANDLE(dev))
-		name = bmc150_magn_match_acpi_device(dev);
-
 	mutex_init(&data->mutex);
 
 	ret = bmc150_magn_init(data);
-- 
2.43.0.rc1.1336.g36b5255a03ac


