Return-Path: <linux-iio+bounces-11217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E409AF256
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5801D2894B3
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A921A6FC;
	Thu, 24 Oct 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnkhNlPB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7A218328;
	Thu, 24 Oct 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797131; cv=none; b=TksZy355V+A8sDO2YEPPHLMZpsjyLqggZR8H2qe1hUGQUayEe4tIHgBwrcJw2YWUrBRkjCfhd/lq+V7urElq60u13pzzBz4EKZMr/xFCb2IKOBd1dzbok1WEHBor3umg5vquWvg2i8FlzIjinM7BaxXBa3+AmViPsxDVAII90dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797131; c=relaxed/simple;
	bh=d3ZSLU8ibrc6Yan7aMm3T4jPhAakbMXjPcSvB3iW4f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKX6hnQ7iqlspTpOz2qciKzX6jiRn+Uqz0Zuakd9e7Yab7Kf1rOqc9CvMWPMy3pxEJj/C3bdCwyUGEls6RmyYMkAHzSHomc3JWg+5/MPe4k4LBwF3fLMA9Z6zIdgvTF3esVclp5jWMDNteegz10KJ7HbKvizJJCEwwuZLRYnU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnkhNlPB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797129; x=1761333129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3ZSLU8ibrc6Yan7aMm3T4jPhAakbMXjPcSvB3iW4f8=;
  b=BnkhNlPB1tEa6iABdwRzaleFRXdjcoHDB1/tPhxOORdItT/ZvwZb0q2n
   ou1FR6V04PgZHjjDKt7y+fOHjpsnh+iCSY74NV4WyBbkIuVOin+ymbjV/
   c+v5ED79ifjxZE9DncuAoT4v3JcJsq4piFPJ4Oza8aKaGZXmuiFknMPI+
   mYN88ilf5hFMuZ0lzCdQgmSMCSeWB+CymQMGd80jyquPfH7TVML2Gf2SP
   rynOXwZNv0VH57PPwu7yfSx5NmFQr8SRwVDxXhOaDNzPT2MaLAtFTQrVK
   FBPoQ9i7Zym6wthXMbWVf5p/F0vk2NOGRbxGgZ+jOMCu6DdBxGlLei52Z
   g==;
X-CSE-ConnectionGUID: e8eT4Sp0RS6DSZkHoHdUIw==
X-CSE-MsgGUID: nZrrcGu2QVq0wnGPb6dxLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934420"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934420"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:08 -0700
X-CSE-ConnectionGUID: ZpvnPiN2TpOa4eu64aephQ==
X-CSE-MsgGUID: qEmkvdwpSaqurBkNbwQgug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266678"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 493224D5; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 05/24] iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
Date: Thu, 24 Oct 2024 22:04:54 +0300
Message-ID: <20241024191200.229894-6-andriy.shevchenko@linux.intel.com>
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

A few drivers duplicate the code to retrieve ACPI device instance name.
Some of them want an associated driver data as well.

In order of deduplication introduce the common helper functions.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-acpi.c | 38 ++++++++++++++++++++++++++++++++-
 include/linux/iio/iio.h         | 10 +++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
index 1e46908f9534..d67a43843799 100644
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
 
@@ -87,3 +88,38 @@ bool iio_read_acpi_mount_matrix(struct device *dev,
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
+ * NOTE: This helper function exists only for backward compatibility,
+ * do not use in a new code!
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


