Return-Path: <linux-iio+bounces-10994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 503D49ACE84
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2F21C22A02
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008477404E;
	Wed, 23 Oct 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkF3PMrt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA51BDA8F;
	Wed, 23 Oct 2024 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696919; cv=none; b=sGUJdruEVmnCGWkri3D6ThZbZaAQkiYnEOQRInAEXtFsIe/NNDhQA/ypfzWjZLnDile6DWol7L8TFMeFXyWIVvbQO15mWwVkh2eXc7WNuMVtYhJrTEZMYqWIkmP3Q6Hv4XtjK+bKcOAQmPWj7m9L7AmdNIc64DmjW9681uzUd0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696919; c=relaxed/simple;
	bh=qGFrLAzLBa1UVY//MxJ0MY/Oz1e9GIAtr9LCUj3kOWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jk0ABs3btjBmJgw7HJneWqxKeoOa9pJH9rg37FjHeMHTNxGkSc5LmoGrUJAQEgC4j9hB4mEcDhYQfIl/bWR9BC1e9jbb6R5Vq/HyPo1/PFz8t6gjXoj4p6Bu8aU/fDtzoWxDRtwDMA/HU4WB90g+M8g6R3ilxkJsgPr6cOf4/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkF3PMrt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696919; x=1761232919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qGFrLAzLBa1UVY//MxJ0MY/Oz1e9GIAtr9LCUj3kOWM=;
  b=TkF3PMrtdJOKkaxVegnte0xL4BLjc7hIeSV0LJV2500AvcJvu/6juogS
   9ViIYDzvjNZLH6Cs1StjwSQentPoMQeJWynhKvgTIg8sl7PbeDmCC33u3
   eFgl10VdtLFcYJL9Peo3trpgjdoUiU0wsQqsQkvVMBcbTMWUStB8LA2bP
   KQ8cyzFd/82dRjwTv5iMPlH+p1Aw2TZxLzIhiz1G0BThKgQ4PYApam05y
   yuxO+SKse/YozOJeqct6J3bw21ze4VxEPDr9uwVtfguPyUB1m0U9ybZIf
   +gbAhJDe3Bhwmpe4LYyM61SndKIORr219l4h9Jilq2C4CM4g4ecVkUr2V
   Q==;
X-CSE-ConnectionGUID: YcPTmGYpSTmOQwvaV5Jm7A==
X-CSE-MsgGUID: V/XDJHBNTmelSSkLgRr4hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46757911"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46757911"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:56 -0700
X-CSE-ConnectionGUID: 6aBiLJeLQV24QnEbciROhw==
X-CSE-MsgGUID: 6JOqbKK8R0mU/Pds2BVubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="79823542"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 23 Oct 2024 08:21:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D0E524D5; Wed, 23 Oct 2024 18:21:48 +0300 (EEST)
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
Subject: [PATCH v1 05/13] iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
Date: Wed, 23 Oct 2024 18:17:28 +0300
Message-ID: <20241023152145.3564943-6-andriy.shevchenko@linux.intel.com>
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

A few drivers duplicate the code to retrieve ACPI device instance name.
Some of them want an associated driver data as well.

In order of deduplication introduce the common helper functions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-acpi.c | 35 ++++++++++++++++++++++++++++++++-
 include/linux/iio/iio.h         | 10 ++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
index 1e46908f9534..0003f6c67580 100644
--- a/drivers/iio/industrialio-acpi.c
+++ b/drivers/iio/industrialio-acpi.c
@@ -2,7 +2,8 @@
 /* IIO ACPI helper functions */
 
 #include <linux/acpi.h>
-#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/export.h>
 #include <linux/iio/iio.h>
 #include <linux/sprintf.h>
 
@@ -87,3 +88,35 @@ bool iio_read_acpi_mount_matrix(struct device *dev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_read_acpi_mount_matrix);
+
+/**
+ * iio_get_acpi_device_name_and_data() - Return ACPI device instance name and driver data
+ * @dev:		Device structure
+ * @data:		Optional pointer to return driver data
+ *
+ * When device was enumerated by ACPI ID matching, the user might
+ * want to set description for the physical chip. In such cases
+ * the ACPI device instance name might be used. This call may be
+ * performed to retrieve this information.
+ *
+ * Returns: ACPI device instance name or %NULL.
+ */
+const char *iio_get_acpi_device_name_and_data(struct device *dev, const void **data)
+{
+	const struct acpi_device_id *id;
+	acpi_handle handle;
+
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
+		return NULL;
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!id)
+		return NULL;
+
+	if (data)
+		*data = (const void *)id->driver_data;
+
+	return dev_name(dev);
+}
+EXPORT_SYMBOL_GPL(iio_get_acpi_device_name_and_data);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3a9b57187a95..445d6666a291 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -831,6 +831,7 @@ int iio_device_resume_triggering(struct iio_dev *indio_dev);
 bool iio_read_acpi_mount_matrix(struct device *dev,
 				struct iio_mount_matrix *orientation,
 				char *acpi_method);
+const char *iio_get_acpi_device_name_and_data(struct device *dev, const void **data);
 #else
 static inline bool iio_read_acpi_mount_matrix(struct device *dev,
 					      struct iio_mount_matrix *orientation,
@@ -838,7 +839,16 @@ static inline bool iio_read_acpi_mount_matrix(struct device *dev,
 {
 	return false;
 }
+static inline const char *
+iio_get_acpi_device_name_and_data(struct device *dev, const void **data)
+{
+	return NULL;
+}
 #endif
+static inline const char *iio_get_acpi_device_name(struct device *dev)
+{
+	return iio_get_acpi_device_name_and_data(dev, NULL);
+}
 
 /**
  * iio_get_current_scan_type - Get the current scan type for a channel
-- 
2.43.0.rc1.1336.g36b5255a03ac


