Return-Path: <linux-iio+bounces-11105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC2B9AE58B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811AC284E4E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF401D9A70;
	Thu, 24 Oct 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jy6MG/l0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CF21D8E18;
	Thu, 24 Oct 2024 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775075; cv=none; b=RqocRDI2TG1idNnkiFUprz5VnM0dqUDeZLIP1WJ7pcCF+jAQEv0s2mDQU4XEdcGUTXjip+bygTphxjIo8+UNwnoCmI68YYix+AHyW8ZSrhXebkUsn2CoJ8OSKDqRz4oAm6MuN1jkw2EE7qwVfSWcaa9tDh5SO+NIR1d8hSlx5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775075; c=relaxed/simple;
	bh=ka5ttrTleL/Ct3ANbBPzaVEqvP9UA33xx6pJzKITIMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTVsQr9ls5VEV/OWN2KqoYh+U82SXaejHHZxK0yg+b1FlL2oXspt73laYPZGockKdILBBxW5mEQRQZaYQR4MnsGcvTrY3Dj4xVWrJRlpsN/pHDNBsEuyWnz197RyY70Xf7akW1RimaSMlGYkgYChSFURwuRmSwY32pNPEkf1uQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jy6MG/l0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775074; x=1761311074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ka5ttrTleL/Ct3ANbBPzaVEqvP9UA33xx6pJzKITIMA=;
  b=jy6MG/l0GIMwjV/tdvpQYmnNThHx4okl5MJXfMJP3pXmY8pLtzksxjS1
   bPFPZ0RY8sjhdfSXZy76Fq5GsBheJwKHMjYOTCLFJmI4plkB+7k2Mvv74
   9oHaMyxDYq0bFakETtycNWrRW67HvvY5UT4N2gWtZ1w0LZBEYEdIqeit+
   SlIkiIW8298rXZQyN9QdCy6v83t6bkphNPlMajt7w2cQIMoWBtoP5Smnk
   xSCTYQuUtXWxi3VBm1DwEwDCnOXdreQRTQ6fgutaHMbDveiNFBpB+R4FE
   QTb7WwEYyc7IAF2qTOjbTr9af2lUYH5xEFeXAVofGrMpERh/cC0PQsuRU
   A==;
X-CSE-ConnectionGUID: 46gAZZznQHengQbfjhX+xA==
X-CSE-MsgGUID: fZaNdBa0Qc2F+a8XJzv+Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40795240"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40795240"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:32 -0700
X-CSE-ConnectionGUID: kaHB+LMRRYqQeYr+UcearA==
X-CSE-MsgGUID: sdyLLeXCRfGVQq6qGSKcfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="103898632"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 24 Oct 2024 06:04:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2765D74C; Thu, 24 Oct 2024 16:04:25 +0300 (EEST)
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
Subject: [PATCH v2 10/13] iio: light: isl29018: drop ACPI_PTR() and CONFIG_ACPI guards
Date: Thu, 24 Oct 2024 15:36:15 +0300
Message-ID: <20241024130424.3818291-11-andriy.shevchenko@linux.intel.com>
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

The complexity of config guards needed for ACPI_PTR() is not worthwhile
for the small amount of saved data. This example was doing it correctly
but I am proposing dropping this so as to reduce chance of cut and paste
where it is done wrong.  Also drop now unneeded linux/acpi.h include and
added linux/mod_devicetable.h for struct acpi_device_id definition.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/isl29018.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 526ee5619d26..56e1c915af64 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -8,17 +8,18 @@
  * Copyright (c) 2010, NVIDIA Corporation.
  */
 
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/acpi.h>
 
 #define ISL29018_CONV_TIME_MS		100
 
@@ -819,15 +820,13 @@ static int isl29018_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend,
 				isl29018_resume);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id isl29018_acpi_match[] = {
 	{"ISL29018", isl29018},
 	{"ISL29023", isl29023},
 	{"ISL29035", isl29035},
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
-#endif
 
 static const struct i2c_device_id isl29018_id[] = {
 	{"isl29018", isl29018},
@@ -841,14 +840,14 @@ static const struct of_device_id isl29018_of_match[] = {
 	{ .compatible = "isil,isl29018", },
 	{ .compatible = "isil,isl29023", },
 	{ .compatible = "isil,isl29035", },
-	{ },
+	{}
 };
 MODULE_DEVICE_TABLE(of, isl29018_of_match);
 
 static struct i2c_driver isl29018_driver = {
 	.driver	 = {
 			.name = "isl29018",
-			.acpi_match_table = ACPI_PTR(isl29018_acpi_match),
+			.acpi_match_table = isl29018_acpi_match,
 			.pm = pm_sleep_ptr(&isl29018_pm_ops),
 			.of_match_table = isl29018_of_match,
 		    },
-- 
2.43.0.rc1.1336.g36b5255a03ac


