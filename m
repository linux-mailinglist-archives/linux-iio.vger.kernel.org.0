Return-Path: <linux-iio+bounces-11236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9599AF27C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955B21F26DA6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9EE22ADCB;
	Thu, 24 Oct 2024 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBBBeKZy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60F228B7A;
	Thu, 24 Oct 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797143; cv=none; b=i2XsCc/xQZ79qMlT4R8YsKtrcrXgOgl6zsX/9+uwqeQNnSzyQRfLP5DCa7OGQ2ct7FyL+VmHNT7HB80bik5S6+EuKlIFA1bGtrLqE+5z+HPmqeFs4LYrVyHPKjHeghQHcIK5vyWwDra0bz+QMj5UKz+QGdFIfIMBAzsXLv4+R3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797143; c=relaxed/simple;
	bh=ka5ttrTleL/Ct3ANbBPzaVEqvP9UA33xx6pJzKITIMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7s6eZVTouA/c9nm6HHaRQPFVMff7xe5xOgw7l0EDRr75NBwfpCSzOaTCVtatpqoYU4ivpZySiAU/Lqlsolyhb9ZFnuOAga3mIn1u+5NFpwuK2vZMlk3QFNObWZzr3UtuknoTC9MAfFxBu1+e/kivtN6N0NXe/UwoOOnd40qKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBBBeKZy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797141; x=1761333141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ka5ttrTleL/Ct3ANbBPzaVEqvP9UA33xx6pJzKITIMA=;
  b=MBBBeKZy37PQaxbJ3bFFEEekEgXzCNjgm0tJlj+8+v7x5557yj7biUnh
   lG/LARpG6s/TXsqywlzejAjZASMopQ5G6LbQkydinuUwgCEr8XrI5a+8k
   qTbe3vbj8f0Y59hFPwUflRliYADkN+L868BQoh7xOcxr7Ht1yozc2pH7R
   KnEdOtyOTCXfyND65WB3ZxECWIpOWFloZpUX/67JFgVpK5StvTcwIZVou
   MSKqqFN7mwqeDBwL1jL+YU1EO7CzOksizue9DQ2Syc5rgC28v+kr3zfBd
   t0QE6tmyXfyIGhxHF91ND1w3Qmt+uQtidbakwFbnWdLz3qYwPgHLyd23p
   Q==;
X-CSE-ConnectionGUID: 1IjighxHS/iF0xlTyLHs8g==
X-CSE-MsgGUID: RQdi2gPfRfyLsZrHohRRFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934544"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934544"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:12 -0700
X-CSE-ConnectionGUID: emUAEGTES9+HXR84xMcPhw==
X-CSE-MsgGUID: CSicA8C/SPqmeJZyxBPymA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266721"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 11888A9C; Thu, 24 Oct 2024 22:12:02 +0300 (EEST)
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
Subject: [PATCH v3 21/24] iio: light: isl29018: drop ACPI_PTR() and CONFIG_ACPI guards
Date: Thu, 24 Oct 2024 22:05:10 +0300
Message-ID: <20241024191200.229894-22-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
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


