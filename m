Return-Path: <linux-iio+bounces-11750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397639B8CAC
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 09:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7E6283E1C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED79D15667B;
	Fri,  1 Nov 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShzGbSbj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F0150994;
	Fri,  1 Nov 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448733; cv=none; b=YMV+HIj10Gev2BgvKW+MiuDj4d4SAzDe6ScQ9NtrHb+Pm3CZmbJfz5AVziyUnYzGGsPWEweJuncOJzdcbiO2y0eQoFdkqTe7jciIDpcAUXULMGWjNgqNgxIR3r75jKDM1kqAbcCoocPCKGBmG8QoXxU+Iciup0vLDOOBiHYouwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448733; c=relaxed/simple;
	bh=dju4LAP4QTdsPDNP1GHQ1R4Awpczpb0FwVCmmtIPoE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klZaewxWQSn3RE4dBVdqx7TrqrHytZ0JyMpoy/Y4+E9UZcvMh4X8hiJUHVD3y0dsG5We2CyZhRn9+IVwSTEcTEXc+YSQ9k6ldF6mWuxeqFiC/J9dBcoGJDM0ox/2eoT2iLUWO/mBkQquK/vf2jHtBaNHwF7aUgPpdPQlEa27bos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShzGbSbj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730448732; x=1761984732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dju4LAP4QTdsPDNP1GHQ1R4Awpczpb0FwVCmmtIPoE0=;
  b=ShzGbSbjMCnIzM6m2lSioax1szVojB1DQH6IjPdaHhLHaNZDNu7uXW8A
   zDgvnnDrCS0/AQq8W4OxiKyzDbV7TC0EwjnZRPQy9W/k4/yFrlKUyFQ7R
   Q9LbKKdvc+iTbCoJ5+uHwABM3P1hnYuwQcGHk14KP+JyaUrySan5ckiOi
   uvjuau/dSvnoEOfjzKFf2j0J7FAOhUttXSLJXBhJpGHmP3XqqORw89ZEp
   KinbRw0h1f237cvb6wErthkYWvyJNT/JmgDk4WXcR0mcKJELSU1NTmYAR
   SMCrqpy+IsxjZRqAztFtyM0ZCgjok/HccOUzNoFS8xFnkVy3zrJKBAl2c
   w==;
X-CSE-ConnectionGUID: gxe9z1T/QrGtK9DUzrPInA==
X-CSE-MsgGUID: GFSAnR0aRFqzeTLncYGUaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="47698425"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="47698425"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:12:11 -0700
X-CSE-ConnectionGUID: dy0lpUUeRM2xIfZV7ikaPg==
X-CSE-MsgGUID: 1LK6GdKmQpS6MexyDHNopw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="87712820"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 01 Nov 2024 01:12:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 14836357; Fri, 01 Nov 2024 10:12:08 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 2/4] iio: light: isl29018: Assing ddata to NULL
Date: Fri,  1 Nov 2024 10:08:27 +0200
Message-ID: <20241101081203.3360421-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241101081203.3360421-1-andriy.shevchenko@linux.intel.com>
References: <20241101081203.3360421-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When iio_get_acpi_device_name_and_data() fails, the ddata may be left
uninitialised. Initialise it to NULL.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain
Fixes: 14686836fb69 ("iio: light: isl29018: Replace a variant of iio_get_acpi_device_name_and_data()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/isl29018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index cbe34026bda6..201eae1c4589 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -703,7 +703,7 @@ static int isl29018_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct isl29018_chip *chip;
 	struct iio_dev *indio_dev;
-	const void *ddata;
+	const void *ddata = NULL;
 	const char *name;
 	int dev_id;
 	int err;
-- 
2.43.0.rc1.1336.g36b5255a03ac


