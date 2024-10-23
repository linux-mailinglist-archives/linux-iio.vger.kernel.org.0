Return-Path: <linux-iio+bounces-11000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CE9ACE96
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D859BB204A2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7791C75E6;
	Wed, 23 Oct 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiMklJ27"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924E1C3318;
	Wed, 23 Oct 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696948; cv=none; b=UWnCZAF007kXnjowGVU0OumQF6hMVp1z5+0mCsJXTsMlakTDkI4sIor8U3F30NL2vm0bvDF43C3NMb7sc+8Uoe3b+qWb80R+UimJa6FXJhulE2lvxd0t52tUTGV97jPNM+PPpdF6fBs/fAq89+lGK4DZisxW09UGtRJTeGF1f84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696948; c=relaxed/simple;
	bh=sQn3XKO4IzTmW1nY5JMl4V8hhJQCw0hKg+BK0qJqweQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5HOFDpTWFGuOoX3MjUnGtJBuVmAWGi0xAOp973QUJn0HmyA9MljxqdSaugA8R1GGvtzUPjgJlNeAYygqnJa1JXCxuIv3fspH9OkZa0HfE4a2g8erKq119y9VHl+cL43Sx9BwZFc8NJdFV/iNndXG+80U3+Aej2WRu117QNKq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiMklJ27; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696948; x=1761232948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQn3XKO4IzTmW1nY5JMl4V8hhJQCw0hKg+BK0qJqweQ=;
  b=jiMklJ27AOO9GsPVSMq61out7JFvjT4f/fJqspmUtGsC0XyMHJuxlG5C
   8b8c2yFJ2MhdGd/1t1XDJKohsLKzu6XU6144yKDZzpo+HVP5UToJ9KOt7
   kTndkXbcFc0/eoYgR/RImR8H6e59A3SDJ7Yr+TkgKKMR8gJrIptJsoY3/
   SfrGHZgEgUG6rayYG/qbIRXtJcS1z3r5dsxvzId1zpi2oflxLB67zmPrN
   s1kZLh6GeiRMiqgHk6u2blDl7ypvnrkpWuxGMtfanWElR4ezfCXYUebb5
   SjH/lGVBDyAfexmtckt1NHrH9GpJv6+Z0Jd2TC573vtlBwqY/289xTNkF
   Q==;
X-CSE-ConnectionGUID: cJ8J1pr2Qm2mZ9SX7wva2g==
X-CSE-MsgGUID: nleDXZ5CTZ61Y6FRPwk3cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39841467"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39841467"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:53 -0700
X-CSE-ConnectionGUID: O+QSFN+WSauhqmJvWo+hhA==
X-CSE-MsgGUID: PfGRHoYzS/yDT7Qml/uRPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80430762"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 23 Oct 2024 08:21:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B05162E9; Wed, 23 Oct 2024 18:21:48 +0300 (EEST)
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
Subject: [PATCH v1 03/13] iio: imu: inv_mpu6050: Replace strange way of checking type of enumeration
Date: Wed, 23 Oct 2024 18:17:26 +0300
Message-ID: <20241023152145.3564943-4-andriy.shevchenko@linux.intel.com>
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

When device is enumerated via ACPI the respective device node is of
ACPI device type. Use that to check for ACPI enumeration, rather than
calling for full match which is O(n) vs. O(1) for the regular check.

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


