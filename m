Return-Path: <linux-iio+bounces-11632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5761F9B68E7
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5C31F2182A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB9021503C;
	Wed, 30 Oct 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIJXfDLk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7C2141B2;
	Wed, 30 Oct 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304488; cv=none; b=cOGCuMMrQa9L3d3YEhdDFzzqt4qUfTMGlaoH5EFbfKtkxOhZDnYs20Ga6ZYLKaauJu0awWxf0PBcc7yTMfylWLp6TfJOlYOeXg/Rk9B45UhhSJ2Y12+fErYNvBjiy2hWGTonWsypxyG7+XGzIxthHDXgaVKino7H4K8EwPONUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304488; c=relaxed/simple;
	bh=w5J1pfMR+5EsH4+HYJttJ9rxVRxOBk/FPPHfLvvsJ54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrnu3erxP/ozo1HDgx/NP0eJ3POVV7JRH2TUvl6J6P8pNdVA4eCJBl3rj7VY9PJCrvCql0+YtgKrfjk0r9OvDLckvtrOfAWIjOynNDIoufsMipMdS/juJmz/I4xaH94hs/EmRY6V06GTigF5CsZ1NHKmSTW7QKvK7jvIGT0hHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIJXfDLk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730304486; x=1761840486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w5J1pfMR+5EsH4+HYJttJ9rxVRxOBk/FPPHfLvvsJ54=;
  b=kIJXfDLk7yvXBCyjQcSic6GaEuFEzd06lpr27u9owMRMfkIWNrADiDCX
   kHJj29MqPTVn4F5gNIVL/ibiJn7YxN3lF5Xb/jfmKLATNZsiWj+LU3jEJ
   CGZeMnumotqeovSAzzwZVQbbfWEoZA5B+S1O+3vJG3uFAULlG9gWNkj0r
   EtXqYiH3nR9PYDKEImEqkaISFS4AQlWQISO7t4J4kyM6cvKnI9NEzZrr2
   yQkvCmlpNJeShWI0MXzaU9NDGemXGsNBesMcMkmC9wR+0dMDNSw1qMuD5
   huniL7252gszRZyM4fzZv6F7YNEMDKA3NSOVITMkqcW7rzmxeXCzQcGZ4
   w==;
X-CSE-ConnectionGUID: GSyeAs4MQje20DyVgftTsA==
X-CSE-MsgGUID: hOC0GlrnT22CU+83HxeYnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29432046"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="29432046"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:08:02 -0700
X-CSE-ConnectionGUID: 9AqPC5ZZTYeow2Vyzq1x0g==
X-CSE-MsgGUID: cm1O6Jr6RzCTEcjFLxByEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82523848"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 30 Oct 2024 09:08:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 53C701CF; Wed, 30 Oct 2024 18:07:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v1 1/4] iio: acpi: Fill data with NULL when iio_get_acpi_device_name_and_data() fails
Date: Wed, 30 Oct 2024 18:02:17 +0200
Message-ID: <20241030160756.2099326-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241030160756.2099326-1-andriy.shevchenko@linux.intel.com>
References: <20241030160756.2099326-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill data with NULL, if provided, when returning NULL from
iio_get_acpi_device_name_and_data(). Note, the current users check
for name to be valid, except one case which was initially doing
like that and has to be fixed separately.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain
Fixes: dc60de4eb0a4 ("iio: acpi: Add iio_get_acpi_device_name_and_data() helper function")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
index d67a43843799..33c737c7a2f8 100644
--- a/drivers/iio/industrialio-acpi.c
+++ b/drivers/iio/industrialio-acpi.c
@@ -102,13 +102,17 @@ EXPORT_SYMBOL_GPL(iio_read_acpi_mount_matrix);
  * NOTE: This helper function exists only for backward compatibility,
  * do not use in a new code!
  *
- * Returns: ACPI device instance name or %NULL.
+ * Returns: ACPI device instance name or %NULL When returning %NULL, the @data,
+ * if provided, will be also initialised to %NULL.
  */
 const char *iio_get_acpi_device_name_and_data(struct device *dev, const void **data)
 {
 	const struct acpi_device_id *id;
 	acpi_handle handle;
 
+	if (data)
+		*data = NULL;
+
 	handle = ACPI_HANDLE(dev);
 	if (!handle)
 		return NULL;
-- 
2.43.0.rc1.1336.g36b5255a03ac


