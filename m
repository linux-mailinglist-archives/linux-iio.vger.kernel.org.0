Return-Path: <linux-iio+bounces-9449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BABD975C57
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 23:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38923B22085
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 21:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35AF154BEA;
	Wed, 11 Sep 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/aQ5Ax+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE973D3B8;
	Wed, 11 Sep 2024 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089733; cv=none; b=VUByxYp4lGswKsytQd9C/C7YdBMV6AVCAVBzSEGkhtsonA7blD7Zu/DdLmTFIg91sEWljvZtR+QCJ+prQ5qn6C0nj9/sgn+dPFx5+QCEgFsHfroIZGYcQ/1dCnCHGeudfxsR0SdzN+mQZQdtaAoVc7my3GSZvXGFl4HmS7YpjPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089733; c=relaxed/simple;
	bh=0PVxAMKfNzSmFdH4j/ySkuLjFEIcVx6fmFR9USlhXh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmrXJQ/RI5JTUXjULEL/l70MgJru6B3AX85I91oS5lK1Wqp9D8fAZt/afrSe/aOcZ1HrsqMT5HQKs884lJRwVgYb4qyL20QSW3iahu3pHkXYW7AbGqDKz0GzqWeTOHfyZu52/243bHsbNFDceBk3v67DJJC01OUMDFtRbAE/MhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/aQ5Ax+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726089733; x=1757625733;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0PVxAMKfNzSmFdH4j/ySkuLjFEIcVx6fmFR9USlhXh4=;
  b=g/aQ5Ax+KwfWr4L16uXiUJetqZIPC8arCIaddrn9iLHwcgd0qQ3Gll7z
   pUjsBnPmM/NukbXAUhTWJHPZ0R7mESm2VDQPRtLpk931YMUdyMn/Q294P
   2S/f/IdZNGUmpJepS1n/PK7A/NmgJMdWyF2hCpZxMAizJhXQo1wox2fKf
   geUXb4WaGLoTmBquW8RP6T1W+SG4gbFrFooAfFigWZ09l9WwzgRScg40F
   nTQ0tBuAAENQRaSsjpP1qay2zJYlsF2qtSlE2Dh4pM6dgZzNj1crEXD+M
   /sXF5KkT8Qq+fNbFMHnhP9+igJy83+z25rrWI7QyZThA1eiwePVHeq0Kq
   w==;
X-CSE-ConnectionGUID: Aam9m5QLTRmzaYQz9tGuiQ==
X-CSE-MsgGUID: LvEibXp+RBKWKZrj7yyQYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24786506"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="24786506"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 14:22:12 -0700
X-CSE-ConnectionGUID: S+7X//eIQqKo7RsZTIg7oA==
X-CSE-MsgGUID: jCXVbS0WQuC50oTv7NQNYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="98329615"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 11 Sep 2024 14:22:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DCE97170; Thu, 12 Sep 2024 00:22:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 1/1] iio: light: ltr501: Drop most likely fake ACPI ID
Date: Thu, 12 Sep 2024 00:22:02 +0300
Message-ID: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
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

Googling for LTERxxxx gives no useful results in regard to DSDT.
Moreover, there is no "LTER" official vendor ID in the registry.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 8c516ede9116..0e0420573286 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -15,7 +15,6 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
-#include <linux/acpi.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
@@ -1422,17 +1421,6 @@ static int ltr501_powerdown(struct ltr501_data *data)
 				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
 }
 
-static const char *ltr501_match_acpi_device(struct device *dev, int *chip_idx)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-	*chip_idx = id->driver_data;
-	return dev_name(dev);
-}
-
 static int ltr501_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -1523,8 +1511,6 @@ static int ltr501_probe(struct i2c_client *client)
 	if (id) {
 		name = id->name;
 		chip_idx = id->driver_data;
-	} else  if (ACPI_HANDLE(&client->dev)) {
-		name = ltr501_match_acpi_device(&client->dev, &chip_idx);
 	} else {
 		return -ENODEV;
 	}
@@ -1609,14 +1595,6 @@ static int ltr501_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
-static const struct acpi_device_id ltr_acpi_match[] = {
-	{ "LTER0501", ltr501 },
-	{ "LTER0559", ltr559 },
-	{ "LTER0301", ltr301 },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
-
 static const struct i2c_device_id ltr501_id[] = {
 	{ "ltr501", ltr501 },
 	{ "ltr559", ltr559 },
@@ -1640,7 +1618,6 @@ static struct i2c_driver ltr501_driver = {
 		.name   = LTR501_DRV_NAME,
 		.of_match_table = ltr501_of_match,
 		.pm	= pm_sleep_ptr(&ltr501_pm_ops),
-		.acpi_match_table = ltr_acpi_match,
 	},
 	.probe = ltr501_probe,
 	.remove	= ltr501_remove,
-- 
2.43.0.rc1.1336.g36b5255a03ac


