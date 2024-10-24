Return-Path: <linux-iio+bounces-11215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B176F9AF252
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C221F23C44
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB77219C93;
	Thu, 24 Oct 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFgqbloI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6FB218301;
	Thu, 24 Oct 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797130; cv=none; b=VZUDi8/XO/R+0j3DIgVgwpCBpCqLaDS5PGNyQvv8qIL+rLyEOclZ6hUrMFLkSMUYpgp+DOXaCSMXQhlUBlAHjtVWlavAiJ37aV5R9YE7sS0IFFxPj1IUeM9/gHLI+N6BmCSb238TT/MRm5e8k0XIfiZr5A+hLjNl1WL6eO/Sv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797130; c=relaxed/simple;
	bh=8atlFWavefIc6+oxaGcsEV449zq2pd7xjIWLQwE6VyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntP3Lr26DsD6pKLSzojfcMtmnFK+EVeT0FhXvcUWmL8afXgDmU2Tbq0ePYOAk/1+50hGwb5sggrPQ4I0ePH14u48i2pZiXAh+mPmyamkTgwiBH0e3XVxOay5GcdFO/b3x6wOWRLdq5/+CPSIYB7g9rQyRd7JMb1Fg/JCGai6Kxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFgqbloI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797128; x=1761333128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8atlFWavefIc6+oxaGcsEV449zq2pd7xjIWLQwE6VyU=;
  b=TFgqbloI8ErobvhVJuOkX2Y9gTD04eOYt0oz47O6g0d2RoPmOF7EbXcB
   JQZWUzPJPGMx1apti6v28xdfrpgfzDnlenql03l/duAtt0I3ZtvXt+Sax
   k1CW32w4c9uCDSFU7/PJvgrucvuEZumPgUGuKHGdz/8R8qOoIvuureaoT
   wyH7TTedRLVKF9OL8eJttAm3CNyuZVvKZuQ057Pcm5zydS428apKt2Ui/
   LO0cxkxdZk8SYbx0WTLMADXtDIeF1h0XiTcsXgmD5i1Z7pbvLilJqrpyz
   9Z/W94BJ4+5DadFs2EuXH2ORLbsKexi1Wu4zbYYoy2Ixpa2LVXVtuKKSu
   A==;
X-CSE-ConnectionGUID: JbVAmeV0R/q/1nO3NZla0g==
X-CSE-MsgGUID: q7EzYlxJQWKZmZrtwkmwZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29563172"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="29563172"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:05 -0700
X-CSE-ConnectionGUID: lFY+U7t9RsevBYCtLb7v9g==
X-CSE-MsgGUID: eJLOipv+QUeDX4Ii50O6lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85791719"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2024 12:12:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2D929386; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 03/24] iio: imu: inv_mpu6050: Replace strange way of checking type of enumeration
Date: Thu, 24 Oct 2024 22:04:52 +0300
Message-ID: <20241024191200.229894-4-andriy.shevchenko@linux.intel.com>
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


