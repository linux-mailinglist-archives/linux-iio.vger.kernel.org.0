Return-Path: <linux-iio+bounces-11751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8A89B8CAF
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 09:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DB0283EDC
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCA157484;
	Fri,  1 Nov 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3VsPmuW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C015531A;
	Fri,  1 Nov 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448735; cv=none; b=etiXtUG+gf9QhM7RGvc1u8V0Mz9njf/PQdh4MugqqbElD2V2rn8zjePDR/acetPBXi/qyRcFTBeulqD03sD04IL4WIWAHlwIixX7+YuKvXWZ1hOiwsdfooP5/2acoERgtm1gtKfyX/8N3vEGqjpzuqcvmRSlw9kBI6TShiVEvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448735; c=relaxed/simple;
	bh=SUeyM5D/YyQIEWJIw/juo3qb1rym0zBMgsApAOnHHbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcHZOU/MqsWQBGdkZtJrSViiLNMIss7qPTbmJ5LY9sZu3dSgWPfbr7rfYcXrFCJ2iUWYELCe2r2LejPXHJ9MaIP+qWZNo1IhrGqhWbpcqjX3+vsNACqU0pP5/r5MGWhKto6dpj9xg6ObQcAa195dxdyfBOp6suWXFdI78ms6hdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3VsPmuW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730448734; x=1761984734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUeyM5D/YyQIEWJIw/juo3qb1rym0zBMgsApAOnHHbU=;
  b=W3VsPmuWqGgEbS/iStpZPfooBRtQx6ApjzrHlJBuED87AZkV40cbDDrZ
   h8iwLpXvWk5DsyBL5LpOowd3cCiajYrt4bJ57/HVCLoM7ptgYFEGGeMb7
   Hjcze5lJ/bGbRuXYkH0XGl+3EouXiJmfclXvWkvy1XN9Na4kAV+cQ0z+b
   dUmCENOoXinNkckH2A4BepWsypoaEEqMxPKAd+7VOFg5HjOOw3b+87RKE
   iMXRlXjSOldjib8c93bW+LGmGS4TGJPYBFN8p3HEOBY+D7QFiSfJIw9/Z
   TwYGTnNkmcC9hlKOS2ZvMlFnELwyCEltStSNK2h8AqJOvXJKD2E3DepcC
   w==;
X-CSE-ConnectionGUID: IVX2E3jTTxSHNpB1HixJeA==
X-CSE-MsgGUID: AWHWeCvqRAWmlObIBPbdPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="55614556"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="55614556"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:12:11 -0700
X-CSE-ConnectionGUID: Iak95K5OQ+Wne+YiwQuTyA==
X-CSE-MsgGUID: G5HaMvVzQZ6qDSBIG8z6NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="106234620"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 01 Nov 2024 01:12:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1DEB92D3; Fri, 01 Nov 2024 10:12:08 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/4] iio: accel: kxcjk-1013: Assing ddata to NULL instead of NULL check
Date: Fri,  1 Nov 2024 10:08:28 +0200
Message-ID: <20241101081203.3360421-4-andriy.shevchenko@linux.intel.com>
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
uninitialised. Initialise it to NULL and drop unneeded NULL check
in kxcjk1013_probe()

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 28ed0e09d099..753ec2f71a9a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1462,7 +1462,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	struct kxcjk1013_data *data;
 	struct iio_dev *indio_dev;
 	struct kxcjk_1013_platform_data *pdata;
-	const void *ddata;
+	const void *ddata = NULL;
 	const char *name;
 	int ret;
 
@@ -1507,8 +1507,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 		data->info = (const struct kx_chipset_info *)(id->driver_data);
 	} else {
 		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
-		if (name)
-			data->info = ddata;
+		data->info = ddata;
 		if (data->info == &kxcj91008_kiox010a_info)
 			indio_dev->label = "accel-display";
 		else if (data->info == &kxcj91008_kiox020a_info)
-- 
2.43.0.rc1.1336.g36b5255a03ac


