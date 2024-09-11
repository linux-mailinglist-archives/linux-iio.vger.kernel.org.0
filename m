Return-Path: <linux-iio+bounces-9450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688DE975C74
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 23:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE4EB210F5
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 21:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B3B1494B3;
	Wed, 11 Sep 2024 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0oMPIqg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439D62EAE5;
	Wed, 11 Sep 2024 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090277; cv=none; b=vA4UwLoMTVg0dzxpPGOI5WnGM/arIJyHczrWqcz+kVIiACXLkQMAbvS2qHAeLvdy6Ufqww1D3YYur+X2wyyH4lYZrMP73clAFBHlR/8efudm3kftpcdVwkedfozRxiK9CFSlnOogpgz0QrapTo1PUA26wWp8UUW9YTey81wS+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090277; c=relaxed/simple;
	bh=iNWEbTYcT/nvFB163ly5IMOZWOgwxgH1UpgT47gwP+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxGx1ewvQg5uSJTh2jtaVjZNycOOC1ZzeDEWBfzaAX3CNYRzOrBBxIfCzj04J6LA6P7duQja/7I1lwfp2HAs4UeimcVMwl5g3SUyi1/adEyNPfO1ADyuqYiBBMyfmEmo7cAmqHuTRhOzVXJtVpRD+IEaeFWtf3fXpOAuK+oLPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0oMPIqg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726090275; x=1757626275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iNWEbTYcT/nvFB163ly5IMOZWOgwxgH1UpgT47gwP+Y=;
  b=e0oMPIqg9WZwoUt6FtBo9TONOcqwoPPw2RbcKvhdtzLjZFnrsPbrbeBu
   eUKeRMtntv/rMLXTYrqwppXIMaBWRvB3twDuh/88thctsuHF80wJMP6XU
   nEjwHTHlymdVusrdEQ8PJYxnEduYVhB+oztuQznoOO3jF4XHpuzt7PMS+
   A5iNSTbnrytq7tGLZnDyyHLvh6CogpKiM5MVMq1V29hgPoFyhKwU9MwMu
   SHc3ZAKs1e+Vp8Vd+6MenB1jJCyzFrV7nSBeW3nXLbLXlYdA6jF1t2Qrp
   YbjNs4CNqo6ywjPP8JZ6y67OOeIetegNGBDzjZSxuSnPpgmt+z9vz5yHi
   A==;
X-CSE-ConnectionGUID: kpai5d4zSryViTN7JsMNkw==
X-CSE-MsgGUID: 0vqmRlBVREW5lrsVBu3u2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24851956"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="24851956"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 14:31:15 -0700
X-CSE-ConnectionGUID: kqJ9EAOCSTmzprcJAicTsA==
X-CSE-MsgGUID: 72WYPs8fTy2iMkIPLdWGSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67327781"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2024 14:31:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E8B43170; Thu, 12 Sep 2024 00:31:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 1/1] iio: imu: kmx61: Drop most likely fake ACPI ID
Date: Thu, 12 Sep 2024 00:31:10 +0300
Message-ID: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in question does not proove that ACPI ID exists.
Quite likely it was a cargo cult addition while doint that
for DT-based enumeration.  Drop most likely fake ACPI ID.

Googling for KMX61021L gives no useful results in regard to DSDT.
Moreover, the official vendor ID in the registry for Kionix is KIOX.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/kmx61.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index c61c012e25bb..2af772775b68 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -7,12 +7,13 @@
  * IIO driver for KMX61 (7-bit I2C slave address 0x0E or 0x0F).
  */
 
-#include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/acpi.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
@@ -1217,16 +1218,6 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static const char *kmx61_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-	return dev_name(dev);
-}
-
 static struct iio_dev *kmx61_indiodev_setup(struct kmx61_data *data,
 					    const struct iio_info *info,
 					    const struct iio_chan_spec *chan,
@@ -1293,8 +1284,6 @@ static int kmx61_probe(struct i2c_client *client)
 
 	if (id)
 		name = id->name;
-	else if (ACPI_HANDLE(&client->dev))
-		name = kmx61_match_acpi_device(&client->dev);
 	else
 		return -ENODEV;
 
@@ -1496,13 +1485,6 @@ static const struct dev_pm_ops kmx61_pm_ops = {
 	RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
 };
 
-static const struct acpi_device_id kmx61_acpi_match[] = {
-	{"KMX61021", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(acpi, kmx61_acpi_match);
-
 static const struct i2c_device_id kmx61_id[] = {
 	{ "kmx611021" },
 	{}
@@ -1513,7 +1495,6 @@ MODULE_DEVICE_TABLE(i2c, kmx61_id);
 static struct i2c_driver kmx61_driver = {
 	.driver = {
 		.name = KMX61_DRV_NAME,
-		.acpi_match_table = kmx61_acpi_match,
 		.pm = pm_ptr(&kmx61_pm_ops),
 	},
 	.probe		= kmx61_probe,
-- 
2.43.0.rc1.1336.g36b5255a03ac


