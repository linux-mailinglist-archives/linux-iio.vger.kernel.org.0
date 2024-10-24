Return-Path: <linux-iio+bounces-11228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E059AF26C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E732D1F260C2
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D67226271;
	Thu, 24 Oct 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr44tn3e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9C21C18E;
	Thu, 24 Oct 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797137; cv=none; b=Jf8p+7LPl+cFB5c3F+KL/gIyoYo9ypF9TaspEMwIUBoThkZ6NnrDVmFglGE3CYjlKloDB4K/F066oY+jpQWkxwZYFNkAOJTcTB5eeK3r2Nv9ck1GK+XHnn+rNedAoQYyHufF4vfoME3fP96BCTkAdY4MjPUHAqxtyba9cqcKEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797137; c=relaxed/simple;
	bh=QjdeYHP6bLRULSx5x70pbUZ1lUja1ExHACvu0ZrgtZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCZG0GvQJM/mzbAHPSWu/lcb/2oAvsL08+tfHaK2njUYg3itUbTz/yYVbJsOsii5i/uicsM+YChlEVN+abVklS+Qov4nqQLFtaf6Mx6oudqRqU1vu6j1i1c9Y/ZbHcPW5c9nHwROF3SJ/+mwDlbuha4ioLJMokf7BLltOOzpWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vr44tn3e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797135; x=1761333135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjdeYHP6bLRULSx5x70pbUZ1lUja1ExHACvu0ZrgtZU=;
  b=Vr44tn3eu9Oo7UFU8+IgzbJRX/8DjaYXpww2ldDLdaThOI0yDkEm5Jii
   PFm6ezl/nMxautl37qZeerRkH0c4DQjNBA29cE/C1hkfA6k9hQRuRLF4T
   +Erq6x5XGAtlYu23Kh4sSlUR9IVLod704hOnU05x+Xjz/u0oRfn/o2lPH
   5i4mB5vqcD8coJnFMquzFN4d6N/Ez22f5Rp8B/a5N4bvJlLeirqIbeDBd
   ezhCOERUVEpZXM0BxD+XkPjPtHCvmKCPPKRrR7h9peHEEUolYLb7La7sw
   HLuEnRfMwtxcjoZJcWmHIXjjQHWhslhR3Kq3OAnPgA63HErtQOKJ94LQs
   A==;
X-CSE-ConnectionGUID: lMLDbmcnQh2/z2haF3oT0w==
X-CSE-MsgGUID: OE362faTSsGNOxb8EUhLzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934488"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934488"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:11 -0700
X-CSE-ConnectionGUID: Q1Geg9EvQsaclO4Fg8BZUw==
X-CSE-MsgGUID: vS83GRZtTge7vewKdGQD8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266717"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DF6764E3; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 18/24] iio: accel: mma9553: Replace custom implementation of iio_get_acpi_device_name()
Date: Thu, 24 Oct 2024 22:05:07 +0300
Message-ID: <20241024191200.229894-19-andriy.shevchenko@linux.intel.com>
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

IIO core (ACPI part) provides a generic helper that may be used in
the driver. Replace custom implementation of iio_get_acpi_device_name().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/mma9553.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 86543f34ef17..1ea6aa007412 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -4,11 +4,11 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
@@ -1062,17 +1062,6 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static const char *mma9553_match_acpi_device(struct device *dev)
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
 static int mma9553_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -1091,9 +1080,9 @@ static int mma9553_probe(struct i2c_client *client)
 
 	if (id)
 		name = id->name;
-	else if (ACPI_HANDLE(&client->dev))
-		name = mma9553_match_acpi_device(&client->dev);
 	else
+		name = iio_get_acpi_device_name(&client->dev);
+	if (!name)
 		return -ENOSYS;
 
 	mutex_init(&data->mutex);
-- 
2.43.0.rc1.1336.g36b5255a03ac


