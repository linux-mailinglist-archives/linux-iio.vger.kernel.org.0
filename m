Return-Path: <linux-iio+bounces-11003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4249ACE9C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FEE1F24922
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75201C9DE7;
	Wed, 23 Oct 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOhl9aT2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03ED1C9DFE;
	Wed, 23 Oct 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696956; cv=none; b=b7QZQhPdusuojmI8g+m4Hm3revQ1y+7nqDfyt3CYgUMa8Wl5yJ0QplRaREqWtzgpCKCPzgFZk5wOGpMXraiuHRyKW7N09eS+/K0ynMBgcO6sTYDCT3s350C6q4wSy5ID5p5T1Z99l9R0HrWbdkWPCtYPwBzUTdr69s3Cx8rnqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696956; c=relaxed/simple;
	bh=JS+kEPP5+HyuCUo40wT3QZ0dMCeFy8KPcsWr/CNp9Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHaE4W2hmh3FjXIoVxls6Pp7oKByDks+VdA/Pu3cJ50cNrnhM4lZ3lRSs25ZuB6lUnZfN9sGM8z/xycKg0wdMWzf8F0pCAjeRkZA8coZBCtIjvQgNcKCjGqLeU2Sp03IMso5ZIPaaNlYXkYal1mi9qIowuWrl8Qm8RxjOkz58Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOhl9aT2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696955; x=1761232955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JS+kEPP5+HyuCUo40wT3QZ0dMCeFy8KPcsWr/CNp9Hk=;
  b=bOhl9aT2eaJTF6BwZSyvoRnYUQMArU8jJnNHTNuzCVla8KI5YW0cuX1Q
   83cGZ46+QASgYnFt1kEH2rWrG3kHwHOQsGP2QhKde4qjuWJWCpZAQ3QXR
   ypJm4BWRJVoxd6RXNwrS7BRUwSqyaYf10EiI3WGaGCVM7mvlMrcrgbJI6
   WBlqZWt9IqK75NtfrHO6xhJpiISEB74LuADG+WffE4FqLCUW36zIXFA2m
   i0SgacsyuMsPjL4Pzs7jqO5yVygTnYwMKrGi0Zuz826B6WbzO19Kq9vnv
   xmzdOj/zxGnmi4p4vUqLaejMQmFUYNsz5Bq5Inv59CngIrb8Hdf1Xfcq2
   g==;
X-CSE-ConnectionGUID: PCe9FVb+TnKBW3bk+SsoDQ==
X-CSE-MsgGUID: EoZyocjZTVGb+C0qH8DN7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39841504"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39841504"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:56 -0700
X-CSE-ConnectionGUID: JvbUA6o2SgSgoBynn9uDpg==
X-CSE-MsgGUID: 9Kwy5JnDQXSJo0m/UapBXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80430813"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 23 Oct 2024 08:21:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DFECD4E3; Wed, 23 Oct 2024 18:21:48 +0300 (EEST)
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
Subject: [PATCH v1 06/13] iio: accel: mma9551: Replace custom implementation of iio_get_acpi_device_name()
Date: Wed, 23 Oct 2024 18:17:29 +0300
Message-ID: <20241023152145.3564943-7-andriy.shevchenko@linux.intel.com>
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

IIO core (ACPI part) provides a generic helper that may be used in
the driver. Replace custom implementation of iio_get_acpi_device_name().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/mma9551.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index fa1799b0b0df..a5d20d8d08b8 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
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
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
@@ -435,17 +435,6 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static const char *mma9551_match_acpi_device(struct device *dev)
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
 static int mma9551_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -464,8 +453,8 @@ static int mma9551_probe(struct i2c_client *client)
 
 	if (id)
 		name = id->name;
-	else if (ACPI_HANDLE(&client->dev))
-		name = mma9551_match_acpi_device(&client->dev);
+	else
+		name = iio_get_acpi_device_name(&client->dev);
 
 	ret = mma9551_init(data);
 	if (ret < 0)
-- 
2.43.0.rc1.1336.g36b5255a03ac


