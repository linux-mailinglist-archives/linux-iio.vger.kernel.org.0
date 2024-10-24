Return-Path: <linux-iio+bounces-11111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD89AE59A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA47C1C21F0F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4A1E1C11;
	Thu, 24 Oct 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6wisoWa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE11DD88D;
	Thu, 24 Oct 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775087; cv=none; b=Y9BEAjwZ0MKwIJNeXIaw4UhFlWwUDJW6NbKmem+tzHf4gvcHhh56n8PQd463fgGa6zukmNc62/hAw5Tg60lQc4NCxuB5v/JRaeow7t6qi6beTp8C3m8gkOcjA7Y5T9C5yWIy7IE7GVvkXZKyXGIa338/0dM7BYRMpxIwQVRAxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775087; c=relaxed/simple;
	bh=qu1MeaORnimrsRm6+oZqb8X4YUWsFbVUZk6LP5Gff1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2HW+wvkzYdyAYygvaqMAwoDra/V09zGpd62QJyATumyD4h17vP+iaOecxKAbpYsaMjWBmpQdFPpXxhhQKsRG46RZNOnWH+DNBhLTn2Lx4RbBTLhwYqgRkgvkiU1Sdw/h3PlPp7+AdPMFU9yTZMk5WvRqUqaV/QRL5AfY8vBxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6wisoWa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775085; x=1761311085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qu1MeaORnimrsRm6+oZqb8X4YUWsFbVUZk6LP5Gff1Q=;
  b=K6wisoWahYXGcYw8/Ijbgkw7kE44O5U+BGa665rmwpF7IGBbeRvVcJ3e
   zoccTIE1gehVFmv8CLoxCN4soyOlcuZWuWa4AR+34fSlIH7bWj5Xx/P6b
   DuEMzeKO2kO6RWNG6TgAbLjUm5OsAlEPblKpPl97n7EQgsLBvhWv9d7CI
   9R6j9IzoqoMFV/cXuTXspJwZwoPdaIG9YHHEa9kq38ZkWTor2u5pV+mXA
   Fs0sBq2U33Asym2ArC2e9toO8YdFr/AU3Y6MIg9Tjf4vv+VTCsVGHj87R
   c30M/Hq7fMLG5FWyUkulHPeEKN/ccYXDQbwEzvn8W5P5z+P5owfNh77+i
   A==;
X-CSE-ConnectionGUID: EH3rm8HyTgquMQRkdMdz8A==
X-CSE-MsgGUID: 3Gj7wbZNQBmWhcp55WWnuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54802808"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54802808"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:32 -0700
X-CSE-ConnectionGUID: wJu4Dzo0QRulCF7BRjf6lg==
X-CSE-MsgGUID: sSzw4t0OQAeb5MubzOeuDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80238785"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 06:04:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EC360550; Thu, 24 Oct 2024 16:04:24 +0300 (EEST)
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
Subject: [PATCH v2 05/13] iio: acpi: Add iio_get_acpi_device_name_and_data() helper function
Date: Thu, 24 Oct 2024 15:36:10 +0300
Message-ID: <20241024130424.3818291-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
References: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
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


