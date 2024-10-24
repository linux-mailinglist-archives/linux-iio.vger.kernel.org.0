Return-Path: <linux-iio+bounces-11234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B36B9AF279
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42EF28959C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690422A49A;
	Thu, 24 Oct 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IoeKinhw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C42228B4F;
	Thu, 24 Oct 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797142; cv=none; b=HPPrtuX499sz6ZPVOCEm4BCbbUPVotYjNnSMBZn9i+5MfvDOgFmAyK0V4V2VIQ3A/oE/+sUDWbuP9/KOdK59en3IZCH7UUQkOT1a+ZgNwhWFYItTR3GxcskT+/yFEpwU8cZ44EcJIjc6KSN1dIm98dxcGIpC1xyATcbgnTlVjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797142; c=relaxed/simple;
	bh=fvNel6p61T3jK3xq1Ew/lp5LBDNzFIYblZQCIwx3ZuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRrQj+93GOSWpLc7gUfMYCpTkjXYYoyNfRlRK/Al/knIlYjqG5xvGFJ3v4BeM5Urt6E9xxeFR5aa61PiRja3bMYq8HEeHuL2U7wi6zsMItETy/nMcCndsP9fJMRu8MPcEd0rwESTnkuyJctaDRQnhO/q7Z1MNFdoBwIibWPfHTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IoeKinhw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797140; x=1761333140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvNel6p61T3jK3xq1Ew/lp5LBDNzFIYblZQCIwx3ZuI=;
  b=IoeKinhwKfsGsXZuoEuKRnRv90BqWb7tlXLXtTB8J7AnM8HE7s3IK2mt
   GsYGd515f/nZ/9Ax1r7VGzrXbFHUE+Nm5ENpPoUjsRYyj/eeECr2HWGaB
   cioT9THdxZZEBBS1zi3PYqQum2xJz4kfqv7C5li9s4k2lpLgQaVzbf7OQ
   rngx7HJqk4QkYioNfmPngqkCTS5xIP+LKeV468SQuAwfTh+tEIE3R0gSG
   XVruuu2hToZgwhTfYg0188gwaN0pUXhhS08PRxnINyDp0aPnD8Oo4/RxF
   ZHZ2eht5PgwWhGOJ3hZiGo4zB1v7vBbrL1CayGaiAFyFWw83VIuqegMbj
   g==;
X-CSE-ConnectionGUID: IaNRBiwUTgeRwV8FU0oeHg==
X-CSE-MsgGUID: 3fcLip4mQXWDGzLe72uPaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934545"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934545"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:12 -0700
X-CSE-ConnectionGUID: tKdAPWXmSKSSXkQ6shuOJA==
X-CSE-MsgGUID: qWQBQta4R9OiQpFdKa0iVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266723"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 22B3DA8F; Thu, 24 Oct 2024 22:12:02 +0300 (EEST)
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
Subject: [PATCH v3 23/24] iio: light: ltr501: Add LTER0303 to the supported devices
Date: Thu, 24 Oct 2024 22:05:12 +0300
Message-ID: <20241024191200.229894-24-andriy.shevchenko@linux.intel.com>
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

It has been found that the (non-vendor issued) ACPI ID for Lite-On
LTR303 is present in Microsoft catalog. Add it to the list of the
supported devices.

Link: https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303
Closes: https://lore.kernel.org/r/9cdda3e0-d56e-466f-911f-96ffd6f602c8@redhat.com
Reported-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 3fff5d58ba3c..4051d0d9e799 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1611,6 +1611,8 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
 	{ "LTER0301", ltr301 },
+	/* https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303 */
+	{ "LTER0303", ltr303 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
-- 
2.43.0.rc1.1336.g36b5255a03ac


