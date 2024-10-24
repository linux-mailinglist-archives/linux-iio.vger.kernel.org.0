Return-Path: <linux-iio+bounces-11113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B3D9AE59E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7A7285B81
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19781E376C;
	Thu, 24 Oct 2024 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsBq7bBt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B741E04BD;
	Thu, 24 Oct 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775088; cv=none; b=quHyAxX/25x+MOFRvDcmA//fs7zzt8l+AoofUwP1hLED/fSbwSeF5ce0kJ2C2n3neBAwm+jOqTTR7/X2KFACzfjdj6ouPdHt8/dlFsMo3Wqxkh5+P2o7y3dg26C667+Wt3ELc0Vqyixke/yTrJI60o4YXMu0bWRdR34h90ABjoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775088; c=relaxed/simple;
	bh=QjdeYHP6bLRULSx5x70pbUZ1lUja1ExHACvu0ZrgtZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1LKRCtfcLfGB2SzbJRQCuPEIl0Cq+ykFc3tG+HuWQxfkLELxKoR6Po8r5JEy8fnXOAJ/RVk64HzfuLJFQQRk8gHzLJT+9yoWLTk/9BnyVy+p24CJM3UNQwFYQlkcVypvy4vnQyKE03Ni42pgeKnDX8B4Oe8JqMTRUHFrMBq2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsBq7bBt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775087; x=1761311087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjdeYHP6bLRULSx5x70pbUZ1lUja1ExHACvu0ZrgtZU=;
  b=TsBq7bBtGy1MzYm6ny/Oqa+eFRbfKGFS7gTVjpVpzNFXMJQSEJjmceQg
   UpVN1/2Q2xbeu1UUjW3Vzxwg0AmoQKS00lHLMQLtGegmWUfVeVE7oQRdm
   5gvqYB0dh4PFb8bLVkYWYsHnfqyUFm91Sqe7NdqrbUl7Or4E5iM5INKwa
   wq0nFst2xuluK2I1oPxE3bJrgT3Vncrr+a73BK8k95TdWt25C7QxGeI7g
   P5L/Y2YaPJiuKqpy4IU3NH1szjTrbZockmKIbLC7yQT6RQ5mXKjOVfQ5S
   oXThmP6y/FQyShtQJ+AZUnVBkt0cxtNIM1eKEMoqA4mEHN+2uIJ03yRmb
   g==;
X-CSE-ConnectionGUID: HgVOSWSLRqOy0uRI6OYtXQ==
X-CSE-MsgGUID: m/YINrzCRvmldf2VQKD+5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54802822"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54802822"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:32 -0700
X-CSE-ConnectionGUID: g/I8CVPbTnuHkQEMvsh7Kg==
X-CSE-MsgGUID: hyUyQ+kmTH271EKuRYsdkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80238788"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 06:04:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0DB7A5B8; Thu, 24 Oct 2024 16:04:25 +0300 (EEST)
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
Subject: [PATCH v2 07/13] iio: accel: mma9553: Replace custom implementation of iio_get_acpi_device_name()
Date: Thu, 24 Oct 2024 15:36:12 +0300
Message-ID: <20241024130424.3818291-8-andriy.shevchenko@linux.intel.com>
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

IIO core (ACPI part) provides a generic helper that may be used in
the driver. Replace custom implementation of iio_get_acpi_device_name().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/mma9553.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 86543f34ef17..1ea6aa007412 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -4,11 +4,11 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
-#include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
@@ -1062,17 +1062,6 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static const char *mma9553_match_acpi_device(struct device *dev)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	return dev_name(dev);
-}
-
 static int mma9553_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -1091,9 +1080,9 @@ static int mma9553_probe(struct i2c_client *client)
 
 	if (id)
 		name = id->name;
-	else if (ACPI_HANDLE(&client->dev))
-		name = mma9553_match_acpi_device(&client->dev);
 	else
+		name = iio_get_acpi_device_name(&client->dev);
+	if (!name)
 		return -ENOSYS;
 
 	mutex_init(&data->mutex);
-- 
2.43.0.rc1.1336.g36b5255a03ac


