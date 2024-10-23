Return-Path: <linux-iio+bounces-10997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A859ACE8C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD45A28454D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7D1C9EAF;
	Wed, 23 Oct 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chv30kM6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952FD1C6F71;
	Wed, 23 Oct 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696922; cv=none; b=QyrEkBb/KWqS5maLl7yhiQfG3EbpBesecLo6uZapiSQy66WPnIrDZYhbmSrd/EzwD5jxSJCg9707FHZeF083R3cBGhnsvqRCoA1JIo/lBSkCiGvRf/7+2ReEs9E0B1a63S7Z/P3zbRMEJZEbf4c9/zHlwQ83yMsQBmyQGhcSe+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696922; c=relaxed/simple;
	bh=EvqHvmqySQB6ykPyYZ17efivk2BOCoil+F/v0X6V9zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxTruDoIrcNeKkI9UHz6SZ4lMnB0/I8VMAH8Fkvwat4jVUIT5mK4mQ+71HZgZWaP9Wmo9sVTFMxH5L2ca/uE0gc2PfPtriJJZyjPnmcaXufeMkL/gm8Ap5aybHHZSKjkf9IIrzaf6BWeULJcE98h7dFP87JShiyyqPdJnFvURwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chv30kM6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696920; x=1761232920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EvqHvmqySQB6ykPyYZ17efivk2BOCoil+F/v0X6V9zA=;
  b=chv30kM68y3Ln09uCKZGyw+7TdPtnISqliZmyIJ8sbk1CGfS63K+VbAT
   YhbeuS5ehcw74sSHqsfwZkIrIVeaoCfk7s/OYFFGRbKCH92O4uRFsvdjg
   jkDhloRayZcVAniqRCJSVRkBt0rhB8nJDsbmwsbU1EdOZ0n11463uGwQT
   HqTNws7l9YkEvriRrTO924W4ukK+GXovyearc39/z5cyzJUkF+IVwM5lh
   XqWkDtMmS55gRIvN8RyySvJ1DCneiyi13uAl5JraLrCViW7fg9J8k0gCD
   /iQIkYeaONGn9bCZ5iqKH/yllACKYcI70Hu86fG1e2Zwa4fsGTYsBa1oO
   Q==;
X-CSE-ConnectionGUID: b64rVXG7TKWT/VLunXQlqg==
X-CSE-MsgGUID: yqT+kIJQQPS79DF446/4Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29449170"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29449170"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:58 -0700
X-CSE-ConnectionGUID: 5kS7MwdcQjCbvlL871Gt/w==
X-CSE-MsgGUID: DhSO68g/Tvy1XDUmB4QtvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80179590"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 23 Oct 2024 08:21:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9BF3C17E; Wed, 23 Oct 2024 18:21:48 +0300 (EEST)
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
Subject: [PATCH v1 01/13] iio: magnetometer: bmc150: Drop dead code from the driver
Date: Wed, 23 Oct 2024 18:17:24 +0300
Message-ID: <20241023152145.3564943-2-andriy.shevchenko@linux.intel.com>
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

Since there is no ACPI IDs for this driver to be served for,
drop dead ACPI bits from it completely.

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


