Return-Path: <linux-iio+bounces-11213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF679AF24C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9A2B22A05
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B06218302;
	Thu, 24 Oct 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwvql+L9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34412170AB;
	Thu, 24 Oct 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797128; cv=none; b=n2K4sttpjXg7lFqew2HgqLhxwV+rfZoZI3H8hZ2Gg7fI9XmJVSTHxl0WM/FrFwnEultWZH5uM6Lxsz2ZX6vCD0q2KP4YEgRJTR3pJCSZvCvELbO12Isk0IglOsvcCkFXEqo3oyuNru8jJhH8uNVeqb96YZHPuWn/3g1ZFOl0CxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797128; c=relaxed/simple;
	bh=vsc6MrVXxXDuLAESj8xZHll4k7qRnzwifVhQvxdNI/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6IdWoVECs5mGXzFFia/LiXZ/nYsG+TKiKqqgOhu9tDIS4+eU3QCAYsadXX9U8oK6RsIHs1Li4pmjVUl8IJBLhyUua8HmPuNwShecr6oK04uTj4IJ9KoE+EsPSJdnFvsMZkKYDfBR5kTrS1jMTloBLPHdqgBDnDwNFaylyOV80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwvql+L9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797126; x=1761333126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsc6MrVXxXDuLAESj8xZHll4k7qRnzwifVhQvxdNI/U=;
  b=bwvql+L9CIAj0oFhIB9mSr7I8/HUN9vYCY+Go1T3+5p5xc1ElgP74Exk
   +1HzJyOPzaGliRDkoQe7FkGrS3pdpvk5aSPjo8luw3N12Ul/3Gm6DEDNt
   PDDoOJW1RH8F38EtkKL52aJ9btzy/nTbdx8wN/kKtMXvPj/WhPo5FtYKQ
   e3JPun/mLHGCvDYFfACn/u9wNQo3bir8/dPIQnxdG+UcJbaBgBPhMAThB
   zoiz22XcJK3wxI0qafGn0nYLG9iMaR93SuOO60hY/xYXS9JWp5Du4RURK
   kp1Hj4RzSziXBRAwYwyJwKAAChghUs6P+cVzP6nmbHCCPwhZByVw8b/Uc
   A==;
X-CSE-ConnectionGUID: 9V7RnM5vQgSCUuTHHf9HNw==
X-CSE-MsgGUID: vIJxjBIeTFuiSm4WE89VLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29563163"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="29563163"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:05 -0700
X-CSE-ConnectionGUID: iMiqtcfNRsyurpJICUeIYw==
X-CSE-MsgGUID: NQgD1t2mSXeXwFoO4infrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85791718"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2024 12:12:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1305913F; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 01/24] iio: magnetometer: bmc150: Drop dead code from the driver
Date: Thu, 24 Oct 2024 22:04:50 +0300
Message-ID: <20241024191200.229894-2-andriy.shevchenko@linux.intel.com>
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


