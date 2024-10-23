Return-Path: <linux-iio+bounces-10995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526F09ACE85
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67D2283715
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB11C6886;
	Wed, 23 Oct 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1+23id1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26561C1AB4;
	Wed, 23 Oct 2024 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696920; cv=none; b=aWqeLFdG4gMGhZfTGRm/Q7L0qWj3H0NRl0FBy1ASmm/xBiZ34G2T+K1m14BWPl18ttDwM++DWsdJojlHXoTXH7oPn7ftz1lVgh4fIsVTZa4NZp3kd6rX5+LBNDVrkNokymlVY3pKleBGXJbrLA+UIIRNqP4niTMLeb1B3ifwUCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696920; c=relaxed/simple;
	bh=phP+VOTWj0eqwAEgvhhUVcTJJ0XgbStGd6GiA5Wr1BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyqIT+AYzzu1a+CLp1H9l5OgLOYsJt66EMdNYwMl7S53vlvZEU6+AUf6Pgod4Tz8znCeSWe0ckgBXq02vW/OK6dadmLNisRJrvYT8KuUp2leloGvqN07ASMiGJqKMKsK4Qmh8YdXl2LhaJTBtoL/A2pJlgknh6UGhJDYXsnsTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1+23id1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696919; x=1761232919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=phP+VOTWj0eqwAEgvhhUVcTJJ0XgbStGd6GiA5Wr1BI=;
  b=n1+23id1qwrg5JqZsQCla/8yhqorxWpJevgksfgTn3n8xh0xOFbK2HMf
   rpVdSfuEAjcg4mEJ+3zn7eTwg3vwEnkodDJfguAzy3plU3G0Sw4UHwSMw
   CcwjCGw36tLE8wXFX0PC8pOx6N3TwmbYn6SCbSDvVdpicqvi8XXF0nO0w
   IEXX2INwN8Gtp8Xzr4uSfATIs09rDPl58SEc4iFUz1ZAmw6ImHEmyjN3M
   UReAJj8Rn2TReuTAI+agmbzFZTUtC4KE0jxpGy86phPJ7+f1mk4+Cx+hm
   /nPyztBHfm/uGEm4axV/bSNQz986rmHY0j6awoCUvrQSfdeMe05Pt/3Bu
   A==;
X-CSE-ConnectionGUID: 6vw7aXrdRcyxsAm5S0+5bw==
X-CSE-MsgGUID: M1j/frN1SiGGQ3WIQUeWWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46757919"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46757919"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:56 -0700
X-CSE-ConnectionGUID: avMrQDQsSayuBs/VZYgFMQ==
X-CSE-MsgGUID: udqst/3uRQqT9DFKKvPtiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="79823543"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2024 08:21:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1A29D386; Wed, 23 Oct 2024 18:21:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v1 10/13] iio: light: isl29018: drop ACPI_PTR() and CONFIG_ACPI guards
Date: Wed, 23 Oct 2024 18:17:33 +0300
Message-ID: <20241023152145.3564943-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
References: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
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


