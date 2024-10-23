Return-Path: <linux-iio+bounces-11002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883EB9ACE99
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D0285680
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2381CCB24;
	Wed, 23 Oct 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z363/QA1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBF1C876B;
	Wed, 23 Oct 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696955; cv=none; b=hmsFHiNAwNC9sgbke7+0VQoggmzuiEg0wh9/txLuY/dbX1R2MLV56zFRAEtIJe94EZB4iGu/uBRuabmpW8vXvcZAOBoMO9Akye9Dd2WDTFfhlkXmUxWleMLAmgg54Z7rqE9d9NtwGvB3qzSCLYv8ROD0GY4dR5aCi02cqUArq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696955; c=relaxed/simple;
	bh=kgbPGnupvACZXY/KCoscd2WgwarUJ/iVo+9QSdYMauM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bn70GEL6ZHBKndwRDS62iZfe+pSoM4/gXHK3FHVdK5IHNtNpbc+3npQasVHKFjBWdAhUnnB7T+7Xn9Q8pxk6aZ+J56WfWJ0uYcdv0MVJ7KEHJEmewZt0EOetTeHbZZRejcPe12F27JK96bBNfW8SHrkPs+IsLA2beZlPGz7b/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z363/QA1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696954; x=1761232954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgbPGnupvACZXY/KCoscd2WgwarUJ/iVo+9QSdYMauM=;
  b=Z363/QA1KELE9ro4lcv8OTlwFpfevd/CvexrNBGmjlpIHmVkKDnQ5xx0
   +kYJyyywf0KuQt1rGcrkspg4Tto8+fV9BUZR00zRh2wsmy9/7AOvcTAu1
   gEQofMzrJApUZIXCcSCn4hof2h2Dtad4rZmJJ8dhvksQ6dhVbUFpDC23D
   GozlHKJAZF6GG9q2mOqigBwVsMY1nnWQtG0QX2BQnyzovMMlMHbjl6Bqq
   4bId63Z125Q0alXQ1rYCp0mIirFo/zTE97Wp/jUMMnhyoX8zqe4cqv0Qm
   YSWr+Lnm0U5rDVDcf3ddvXUbYo+bx+AM3WzLX3p0FhZqA1ipY3mZKJCtr
   Q==;
X-CSE-ConnectionGUID: vSC3RnVdS9uLmFTyQ1MHDg==
X-CSE-MsgGUID: 2dwB05gRRWKmYOiSgs+h8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39841491"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39841491"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:56 -0700
X-CSE-ConnectionGUID: 4LRNR7ivSGSZvRM/bMUslg==
X-CSE-MsgGUID: y4rjCJdLTquO1gdcqZDdhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80430812"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 23 Oct 2024 08:21:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EE523550; Wed, 23 Oct 2024 18:21:48 +0300 (EEST)
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
Subject: [PATCH v1 07/13] iio: accel: mma9553: Replace custom implementation of iio_get_acpi_device_name()
Date: Wed, 23 Oct 2024 18:17:30 +0300
Message-ID: <20241023152145.3564943-8-andriy.shevchenko@linux.intel.com>
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


