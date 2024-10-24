Return-Path: <linux-iio+bounces-11109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8959AE595
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12DC1C220F1
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD71DE2A9;
	Thu, 24 Oct 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcSDnVZQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F71D86C0;
	Thu, 24 Oct 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775085; cv=none; b=XnfZQOgKj2vCCj0HyvNxA8GZLlN8NSnqZ5/TMAMFuPEzrUjPa93dFzeDkWoYGmyRESZbkmH3nu3iLqIAE7jylg50rfAXq5Gi6o5RUjleVK2Yq5VIPaT/F7TWRznzLBWmVq+x6hnNB451FJBAOUIMLusQpBcxuPl01x1TDPWkEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775085; c=relaxed/simple;
	bh=8atlFWavefIc6+oxaGcsEV449zq2pd7xjIWLQwE6VyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T40eoPrDP5gyp7ctqcKOX7eGRLYS0ct5jBB+LGPR7A4JAt9Rm5HgO5M1jRvOdw9Yp8DUIXApvvzbCyNs0whV2nbFTa+cKwnCMuAqAR145SdDgPM15j3saRhHQUNlZQeukrGhDK4ydSwKOX6ORCEyX8ugBV/rttQDcWSozd2+/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcSDnVZQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775083; x=1761311083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8atlFWavefIc6+oxaGcsEV449zq2pd7xjIWLQwE6VyU=;
  b=CcSDnVZQmhnr1ML8pif/JlTDrchz1AfAPbIyMTYapIWEK30aE9EnbZo3
   fu5aafxU2WrB8V02QRICUDhdI2WP0GCYiONGNF4z32TCIajBrZy9CDR/F
   0aOtIlzYpIKJr4+O/Lhb79MlCMOCeG7lgUg4v7nzBekhPU+eGIAJWgnwW
   j1YAPqtqdzr06DXKEW6fBqixSLUtWXCOzhO49AfaT/rDod3G5gUyJ7vZ8
   F19NPy9ARU1V+RR/VSp7hbncJ0qqErHRTp7qXtacLyqzTSFDz8MIhvs1j
   BsdK0OlNdPviS6Pz5qqdY8eGFGz7RrH5/hSZM5sYDljVk0tqSeyzy1ZQh
   w==;
X-CSE-ConnectionGUID: Es3Di0FdRKKW4BFsIw3y2g==
X-CSE-MsgGUID: t9r0dSWNRrq+S7Tw3fxAng==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54802787"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54802787"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:28 -0700
X-CSE-ConnectionGUID: FQ4as4GlRJqn4untf3bYZg==
X-CSE-MsgGUID: vtN+1e2QQuC+3Mt6DtzzGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80238764"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 06:04:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D6B1A4D5; Thu, 24 Oct 2024 16:04:24 +0300 (EEST)
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
Subject: [PATCH v2 03/13] iio: imu: inv_mpu6050: Replace strange way of checking type of enumeration
Date: Thu, 24 Oct 2024 15:36:08 +0300
Message-ID: <20241024130424.3818291-4-andriy.shevchenko@linux.intel.com>
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

When device is enumerated via ACPI the respective device node is of
ACPI device type. Use that to check for ACPI enumeration, rather than
calling for full match which is O(n) vs. O(1) for the regular check.

Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index b15d8c94cc11..373e59f6d91a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -104,14 +104,11 @@ static int inv_mpu_process_acpi_config(struct i2c_client *client,
 				       unsigned short *secondary_addr)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
-	const struct acpi_device_id *id;
 	u32 i2c_addr = 0;
 	LIST_HEAD(resources);
 	int ret;
 
-	id = acpi_match_device(client->dev.driver->acpi_match_table,
-			       &client->dev);
-	if (!id)
+	if (!is_acpi_device_node(dev_fwnode(&client->dev)))
 		return -ENODEV;
 
 	ret = acpi_dev_get_resources(adev, &resources,
-- 
2.43.0.rc1.1336.g36b5255a03ac


