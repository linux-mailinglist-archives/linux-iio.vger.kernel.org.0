Return-Path: <linux-iio+bounces-11230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF99AF270
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F4A1F264A8
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1ED224B6F;
	Thu, 24 Oct 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y3wYR7EP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78308218D7F;
	Thu, 24 Oct 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797138; cv=none; b=FcEihCzcAzMjVjEuzPfcyNWZ+0MxbGmayRfm+P9lPaf7qa2fTKRuzGLyTMRmKRxIjdFat3LzQFlWV99/VadmKfcxaO/Hs4XB3Xv9JeUGfu41kiTgtITRujJgitUG6kt5P1K/JomoT3v0ozElMfGMro7FbfqhLP+6z6sKyDIF298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797138; c=relaxed/simple;
	bh=zxQd+68Z1zPrrX9bNKxVFx6C4dGvd3tUJFvHEY8+Vz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmwhLTUGwIAcamcTCKzF91BbyjejcbgexxgoX5noUkHjLPMTprsB9qGH+vyy91ktqbfFBiHyXC7c4CtxeNvPIPeKag+U8DzO7o+XPWmQ/RggMciwmWOgC9gsI0OfVkWhENMJ0mpHf2JsAn99ZnxxXOds+yNalKeEBdRbDqY6H6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y3wYR7EP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797136; x=1761333136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zxQd+68Z1zPrrX9bNKxVFx6C4dGvd3tUJFvHEY8+Vz4=;
  b=Y3wYR7EPqnDcRLveifZ5FWoqfWb+jamTAu9QfrmsUczcfPHMsQ8IY3Hw
   iIJPE82IB3NMRvu/OSRw5p61pGcMj0j5rmmhjBCV5gQcewR8apUcmaj6p
   IAuTPC4XeSYmrd4qwwyjjwc1qCNL75CIw3T4Y04EM38KDLi9fBV1jVUi/
   iWWeD3XWnF3dlnNLcWfGSXNEUJG2+5GEouO+zUZTy8ZmEu7LTt52yMzCJ
   knA5Y+7qEStRzdsFJxkZF8S0CmG3lNCpckFwYTNqDUZ/ZSMTxrxOa/N98
   DsVTk75AqOS6+vP8MFEc/RgO+gI0mUNKJe4hzoThcFNuavIBI5riRZzZf
   w==;
X-CSE-ConnectionGUID: tkgAj+w4SzGMhnCZ6mlJow==
X-CSE-MsgGUID: vnvODcQ/SgiOmFV2sZ4MNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934505"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934505"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:11 -0700
X-CSE-ConnectionGUID: 7+UF6+JeR8afNWZmZpDFqg==
X-CSE-MsgGUID: ZFhJ9pZXTDup4dBV96Wl9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CF6AC7F9; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 16/24] iio: accel: kxcjk-1013: drop ACPI_PTR() and move ID out of CONFIG_ACPI guards
Date: Thu, 24 Oct 2024 22:05:05 +0300
Message-ID: <20241024191200.229894-17-andriy.shevchenko@linux.intel.com>
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

The complexity of config guards needed for ACPI_PTR() is not worthwhile
for the small amount of saved data. This example was doing it correctly
but I am proposing dropping this so as to reduce chance of cut and paste
where it is done wrong. Also added linux/mod_devicetable.h for
struct acpi_device_id definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 41 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index e8074e0c59a4..baa2674b93f0 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -4,11 +4,12 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -465,24 +466,6 @@ static int kiox010a_dsm(struct device *dev, int fn_index)
 	ACPI_FREE(obj);
 	return 0;
 }
-
-static const struct acpi_device_id kx_acpi_match[] = {
-	{"KIOX0008", (kernel_ulong_t)&kxcj91008_info },
-	{"KIOX0009", (kernel_ulong_t)&kxtj21009_info },
-	{"KIOX000A", (kernel_ulong_t)&kxcj91008_info },
-	/* KXCJ91008 in the display of a yoga 2-in-1 */
-	{"KIOX010A", (kernel_ulong_t)&kxcj91008_kiox010a_info },
-	/* KXCJ91008 in the base of a yoga 2-in-1 */
-	{"KIOX020A", (kernel_ulong_t)&kxcj91008_kiox020a_info },
-	{"KXCJ1008", (kernel_ulong_t)&kxcj91008_info },
-	{"KXCJ1013", (kernel_ulong_t)&kxcjk1013_info },
-	{"KXCJ9000", (kernel_ulong_t)&kxcj91008_info },
-	{"KXJ2109",  (kernel_ulong_t)&kxtj21009_info },
-	{"KXTJ1009", (kernel_ulong_t)&kxtj21009_info },
-	{"SMO8500",  (kernel_ulong_t)&kxcj91008_smo8500_info },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
 #endif
 
 static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
@@ -1736,10 +1719,28 @@ static const struct of_device_id kxcjk1013_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, kxcjk1013_of_match);
 
+static const struct acpi_device_id kx_acpi_match[] = {
+	{"KIOX0008", (kernel_ulong_t)&kxcj91008_info },
+	{"KIOX0009", (kernel_ulong_t)&kxtj21009_info },
+	{"KIOX000A", (kernel_ulong_t)&kxcj91008_info },
+	/* KXCJ91008 in the display of a yoga 2-in-1 */
+	{"KIOX010A", (kernel_ulong_t)&kxcj91008_kiox010a_info },
+	/* KXCJ91008 in the base of a yoga 2-in-1 */
+	{"KIOX020A", (kernel_ulong_t)&kxcj91008_kiox020a_info },
+	{"KXCJ1008", (kernel_ulong_t)&kxcj91008_info },
+	{"KXCJ1013", (kernel_ulong_t)&kxcjk1013_info },
+	{"KXCJ9000", (kernel_ulong_t)&kxcj91008_info },
+	{"KXJ2109",  (kernel_ulong_t)&kxtj21009_info },
+	{"KXTJ1009", (kernel_ulong_t)&kxtj21009_info },
+	{"SMO8500",  (kernel_ulong_t)&kxcj91008_smo8500_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
+
 static struct i2c_driver kxcjk1013_driver = {
 	.driver = {
 		.name	= KXCJK1013_DRV_NAME,
-		.acpi_match_table = ACPI_PTR(kx_acpi_match),
+		.acpi_match_table = kx_acpi_match,
 		.of_match_table = kxcjk1013_of_match,
 		.pm	= pm_ptr(&kxcjk1013_pm_ops),
 	},
-- 
2.43.0.rc1.1336.g36b5255a03ac


